import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

const CustomTable = ({ data }: any) => {
  const noData = data.length === 0;
  const tableHeader = Object.keys(data[0]);
  return noData ? (
    <p>No Data Found</p>
  ) : (
    <Table className="border">
      <TableHeader>
        <TableRow>
          {tableHeader.map((item, idx) => (
            <TableHead className="text-white" key={idx}>
              {item}
            </TableHead>
          ))}
        </TableRow>
      </TableHeader>
      <TableBody>
        {data.map((row: object, key: number) => (
          <TableRow key={key}>
            {Object.values(row).map((cell, key) => (
              <TableCell key={key}>{cell}</TableCell>
            ))}
          </TableRow>
        ))}
      </TableBody>
    </Table>
  );
};

export default CustomTable;
