Return-Path: <linux-kernel+bounces-803262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20007B45CC1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C405A477D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAD3302144;
	Fri,  5 Sep 2025 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c5srzPtu"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013043.outbound.protection.outlook.com [52.101.72.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB3B640;
	Fri,  5 Sep 2025 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086918; cv=fail; b=XyPo1hZp1cH7A8I+/rRqwY/yhQgwBCluagqKiKgsZhBZ+IbNU06N64HcRU4+xq7YKEFZXQpgEk+GAgbcSKCForFx8NAKZCTX9MK8kO2ItJKEUBeKRA+YmrFpEvrQ3Ij5MxfLIafOZqVyN/FJhLuVCA1ip70ZCkzTrtp6i3yVWpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086918; c=relaxed/simple;
	bh=ursclvbcXnaWe8mm5h9bfld3FEmm0EoqmaGHkvmIJDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m0qdKHdRna8s5Q2z6VYiny+qZ4lkWqXhJOX2XH4daMH7uPbd0XjOETUddmJlzd8AvDMjsTHz5PpESWLFRZt1tBC3gwRsY4QPirBoXln3xW9k5Gv0zk8T5hFDFpC4tG21Hke+lS8KUppJrq7XmGTFp87GNxmjjLqWQcDYEfmyrvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c5srzPtu; arc=fail smtp.client-ip=52.101.72.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKCerpV2QGVlicXlLbF+aPxE1kjrNXlq93308wK/zepIhmP+srHWz5gPSj/LcRBC74VqU0HDHzyHcp4NaX1GpHdKgBRWdw8rVq5iVUhUeZioADi6Soix6cu5yCIhig7nrzSqeQds+GrMyHz/MRlLNRs9+oeVCx0BH8WXF7WC+sCfLwt701Ydsn/WBDbFE8KuJtx9nYdIy0fdGucSmZs3EKZ3zG00nZGTsyn680fw3CXIFSfrDTjVOEo564Jw6pXntCQlVb2Oa+NoFMwjQo4YfLdXU1qn+m17bRalpJueF+PbHZHW0i0JJoPuh7Cbslj5rdNqb0pJhQC9xrcdJPgvEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdE3WynccPamT4llkdb3MUWyuV3tC/ud9BzGzfn7TDU=;
 b=lvV9e+2hHPN85UVq+R7yGfiPZGbH0DdxybNFsWHiqk+IerykOdQwnwXQibxkg0ttEGs6dAfgRuh5CxZiZWvNc+Z8YSocwffvLHgci92iKW5JybcLOfhM8r2Bf0BwZMyjCFY2iwwRhUJ1bx4QiIAEFU9ORmvJazaD52sOsbltasFy3FhR1/EuJ6N/rWeQIJbVoF5web3392wjbVuknP0WnqF3SzTtNg3C8bWxnSwHhrORbW3tex9A38CHG+hUEx+qdboxtjODTJ/1e8eEgE9mjHCpft2H08VO6tv1TFN6RVpXR25RPvRjKuiY2dlp8az/Mi6hSOqdR2omU7DdJGrt5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdE3WynccPamT4llkdb3MUWyuV3tC/ud9BzGzfn7TDU=;
 b=c5srzPtuCwZeKrXyzkZnLTHIOTJldRdVAcmpoUOpN/7uOfJfOy49v5dwRQCJM0ZGZ1muUiJzXNyGeAHRbrkBYcWk6jj9J+KZ/8hJTE5jI26TIkwNosvpa3tCQpZ/i4pm5aH2jMcuZMzXzoBzhVIOi7q3R9DdZ9D0FEVnWquUeqtJJjJT34qFF3F4HIdgmSZgRIN8kfjw/0FL4bXqeMQOnJGZ586DTCMANbRkzrgTQ5b5YUAnNki/fUkkzaBY6Ho6OcARfs8/7ukaYmqs2+7AxHBsr5iI5Y00f8Zg6EQZLsLwWhTqKv4fsntXreFfnGksAIfliDQOY5H8TTlWVrxxPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB7635.eurprd04.prod.outlook.com (2603:10a6:20b:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 15:41:53 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:41:53 +0000
Date: Fri, 5 Sep 2025 18:41:50 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-phy@lists.infradead.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Josua Mayer <josua@solid-run.com>
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250905154150.4tocaiqyumbiyxbh@skbuf>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
 <20250905-bulky-umber-jaguarundi-1bf81c@kuoka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-bulky-umber-jaguarundi-1bf81c@kuoka>
X-ClientProxiedBy: VI1PR09CA0129.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: f248c50c-f52f-40fb-203f-08ddec92bcc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|10070799003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GsFOoRFShSUZz7r5IPe4kT62DZ100Sbp1unSuEqwgMFhyWb5xFPi3/qMzH9D?=
 =?us-ascii?Q?luWJ7zPtKxMLmPgtkYUe7sSCIgvp4HHkB+3EHjBl4oOF+VTLTxpa4fsFNT4x?=
 =?us-ascii?Q?kwHVeJSXyz1pCH2iO/e7RVjzSyJPJRrDF9P/hxo3o4HWLePN9IqMXuAaC/Or?=
 =?us-ascii?Q?LAbACFquBhaw01UlRVqYIQRy8xaY4YWJ+R66JhoaydrS1610wg8QBMd9SsDt?=
 =?us-ascii?Q?WXZxNIXjdFuvKXrRHSE0xqoWsPxT+JjnYB4UQlJgKXA+/JAnHlyG7/bJmxah?=
 =?us-ascii?Q?hpsQTBJ1n8PJHrC9xX8/+n2uILYb6Avs/75m4wWVLAAYz2vSCtX+Qgafx8u1?=
 =?us-ascii?Q?DoBYDWpeZYJ9eDwQ2cmJFQYIWXeUpv+TgIrxtylHfUtJ9kuhz0Kkgw78STPb?=
 =?us-ascii?Q?mOGZpBucpZkMG0eWTspAAueohMSgHbiSkDIe61EWm7PX/MlbjSYJPZOcDjut?=
 =?us-ascii?Q?SWlue0fdLp/wO8CK6uxjGADqNjz+7f6Zu8uSRccFYcOdiTzaxxkOsM4r0ieD?=
 =?us-ascii?Q?ZdoLMHIcs2PAqj5pKnmRY68PXm40L/1kT+cj/9SqzMz8WcUuBg6XGSi1+F6T?=
 =?us-ascii?Q?3CR4PP7ZktlX1xMKm3FRzKCs24yL1FJEmAdvvev1x+p/KcT5ADTxYZ7u9LIF?=
 =?us-ascii?Q?cVsxV+N6lF1O8ItBBppydFA6gXtq/+tytVnZu/OOHF+CaiNNQjq7EwkLTzVe?=
 =?us-ascii?Q?5pMfY37AX1MSxdaixI8Awem/gG/fh3yokIO3Iz3R+67eh5FhsQYrwipA+5Rc?=
 =?us-ascii?Q?6nH+87p1pt/hOt+IwxQak067IGUkG7eyiGe71jR8J3CICd1ustlufwEk7Zpj?=
 =?us-ascii?Q?0blhTlA95/1Ruc399gtTZRZjOjGcVBY+HNfSi98qRTm8BJ94d7f/rJ+euzlC?=
 =?us-ascii?Q?XjGbZoc0ltgZGN0sDSpbLfXgY8yTd8gSU27WW+phhQEXGI4AHO/KLunke8TR?=
 =?us-ascii?Q?MBEqxjYBv4py8Pr9Yrw3mLOeHNoEUH32zC6bmoZyxrTUAhO6L8/8gLMNuU2e?=
 =?us-ascii?Q?sa/kV77oFgFeyUNZsxOMYOfziWS0+C7BRdDxWujd3lKpPQ2m5tS/6NySyONp?=
 =?us-ascii?Q?DP3eB8opa98tDwUCfEeHIehr16Jh5YDEocFvvZiUWugupbwWO/OINw/jAO9M?=
 =?us-ascii?Q?LxszNMPFMHZyzxa/35Cjx0Y1GD6mV5jIqamn7FMGUXyjMpuNtwTBKoZ2djB7?=
 =?us-ascii?Q?YbhJNTx9TM576b7/cC8fe1UpxAN83D21Gat3m8SwoFhaFg0cSV8zJKmM/Rmo?=
 =?us-ascii?Q?88CsaLs83Syk4bgFaheakM6Z6mWprMuMHTImGtv/Jv81pPCKR62ExFdfqzKb?=
 =?us-ascii?Q?nF45fhvMLjBSj+Z90I9DEbX1byGpx2DnRit2Gjh3U3QKJwMtPgwuTD6EpWhj?=
 =?us-ascii?Q?O0iaAyRujjZvUCxOfjYi/cnZCDLlGNE6cTi0k13AmxMW3BaBuktt976ieaLz?=
 =?us-ascii?Q?/kN8KXAMej0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(10070799003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yZL2B8gyElEUWrR5GWl8PQaNQwF7ReHscSd8E3++iS4NGchhHrQwI7GmW/CL?=
 =?us-ascii?Q?iroDro7WnVE77IA/HfUPFUZmi0jc0g9lvjdqSKH4TFle7m7pIQRykmr9NI+N?=
 =?us-ascii?Q?b+GesZm+dmAA422enYF7cF7VjupmGIp8Jl+d7UOxz7y1AqN1P51kgpg5QBss?=
 =?us-ascii?Q?Cswz19pdMJesXUw8BpbMMlVsZgLq0ha2IX+XaRtBCxvpN3jJxjxXk8JnsfoY?=
 =?us-ascii?Q?GmCYzLRSfB+/qb0VS/qnEJiZGw5UUCrOKdpszf0c/nsRM3BvJJUc973A24LX?=
 =?us-ascii?Q?uV14QgGRlKrkBcqM02p7TW+avc68waMtLXggWUrt84DZF3IZVCEC6UhcQsEg?=
 =?us-ascii?Q?SGh85u35woYprL0w+FQZ7gZRRqXudAMDgKSWqQOMOUCorSTjOqxBeZw6psO8?=
 =?us-ascii?Q?T2ek4Ko3TNJ4AweFu2WwPTrp7e++xrO/GjGi75oU7Hcz34mhvDo5ccE9OtFx?=
 =?us-ascii?Q?W22ziCea8G/G+2V244WmfPkmcMzINIaR+CceIJMdfVUoQ/4Zd4bKU/2Ov76l?=
 =?us-ascii?Q?e/YTu28kWIg7mzCh36d6mzqvJX5vlqRFyf9Jq7pqCMf9WJsOpeFCtjGlSPH3?=
 =?us-ascii?Q?rsXW9QlfzR0yPfDdgd7qVyuY2y0c0UOdeM7GoEVxlSd5yapRU5TsA3VW3jOh?=
 =?us-ascii?Q?XD271VZcPgiMaI3gpc4FZ7O08mlZmeJC5DYhyy62kSi2a8pk0c1Oh1+xnOx4?=
 =?us-ascii?Q?+LR9fLIrv9Jg0X4UdZ1GAM0gPpkjl7jtaa3waj/foZm0KgdWyA3xzsiiwyzi?=
 =?us-ascii?Q?UT6aqNM3E7Dlly71C+FKSFUtqvdcQVHRItWDKXx1lMCt8QftxgBbcivGJ5Oo?=
 =?us-ascii?Q?OHM3/soKx/vSeEW/+9N0Fod7awVinP/Z84hTpW7sYdo3sct6joQfY5Y88h1V?=
 =?us-ascii?Q?8sf+zPA328BxP79rp2xDyJrUaFTQF64HqVl3LZVQNbXvjYuvZIWj96FEo1Hd?=
 =?us-ascii?Q?KGpjsv0H/BumlN6g5kTxDmjxDWxfFSg2HwTDkh9vh2RMOrrO8nEwcbI6Ixmy?=
 =?us-ascii?Q?1M4NQRxewPr58y03IQMV7egI4f8zFK5xMddVDj+jaiZddNW0QsVKUywoTwfb?=
 =?us-ascii?Q?nIiR6GPsKlg8IHecIB2NnC5DJYR8DWghwPCi86t78aKixp3fkLCiYKND45Kx?=
 =?us-ascii?Q?d6iTS+Mw5MPw/auNCQjqOSv/SraCFrdZyw9TExzoDuUBrGY/t/SRDP8eSTey?=
 =?us-ascii?Q?/HNIzIBYE6fXBXO8dS9AxyeakxmN69h8XzabWUj+3sYuAbEJ4s9/DUHNnLQR?=
 =?us-ascii?Q?XBrV/TlVqHLP3SlOTmJx/oGwi7zi+ms/NTsYXL5t/G8iRiRzXmvUUIZYnZ7w?=
 =?us-ascii?Q?RhFYtxWx1V3UW4UQCGp6biVZm0aEkZnEB7jHF63wyN0uAfxorJ41gbCByrDg?=
 =?us-ascii?Q?hLnX9weYmDuphRMtMo5id5pZJ/J2gQiAzBxX+aI16XlM6VN3Ekc9niMszR8O?=
 =?us-ascii?Q?ivZZI2z5OGbcsRSn0BFDE0dbjJFTVM8hHthMyGQoLVFqRSBrj2AEFl06kNRX?=
 =?us-ascii?Q?xVMnbbo2lKTM7mk77U+hd3sSnxazMkrIGNWavVUYYl0yLloEddvxiflRwpa6?=
 =?us-ascii?Q?R726ELEa8CIIkXiKoibUsKTROtXRPuDsxelVF9BmxhJzMid1EAATOBN4k9WX?=
 =?us-ascii?Q?6hD180KOfHAbasxgaNoiEGV8eS7b2H/QCh5/XQ6IcOgi7t12rSW6IaYwDWXC?=
 =?us-ascii?Q?PpBSOw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f248c50c-f52f-40fb-203f-08ddec92bcc3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:41:53.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0FOsBZQbJiz+LaI3iBjBIFr6WCcKIUZkautC9sfVpChfb00FCA7CY7uiBVTgcJdM5JnYK+7Rnpq4Yv9nBeSPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7635

On Fri, Sep 05, 2025 at 10:29:33AM +0200, Krzysztof Kozlowski wrote:
> >  properties:
> >    compatible:
> > -    enum:
> > -      - fsl,lynx-28g
> > +    oneOf:
> > +      - items:
> > +          - const: fsl,lynx-28g
> 
> Don't change that part. Previous enum was correct. You want oneOf and
> enum.

Combining the feedback from Conor and Josua, I should only be permitting
the use of "fsl,lynx-28g" as a fallback to "fsl,lx216{0,2}a-serdes{1,2}",
or standalone. The description below achieves just that. Does it look ok
to you?

properties:
  compatible:
    oneOf:
      - enum:
          - fsl,lx2160a-serdes1
          - fsl,lx2160a-serdes2
          - fsl,lx2160a-serdes3
          - fsl,lx2162a-serdes1
          - fsl,lx2162a-serdes2
      - const: fsl,lynx-28g
        deprecated: true
      - items:
          - const: fsl,lx2160a-serdes1
          - const: fsl,lynx-28g
        deprecated: true
      - items:
          - const: fsl,lx2160a-serdes2
          - const: fsl,lynx-28g
        deprecated: true
      - items:
          - const: fsl,lx2162a-serdes1
          - const: fsl,lynx-28g
        deprecated: true
      - items:
          - const: fsl,lx2162a-serdes2
          - const: fsl,lynx-28g
        deprecated: true

