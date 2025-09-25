Return-Path: <linux-kernel+bounces-832743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C538BA02C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 093754E39B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10CB3009FF;
	Thu, 25 Sep 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DvX5h/Bx"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1BC2E1C69
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812973; cv=fail; b=Nrj3ua5pqKdhz8SJ5XIIQXHn/x+9+bfMMl+JZfpbaWG/zaV6oTYp30optialry1IM8+HZKP7M/gO7QU7JzueWm3/u4P/mtz8vbXvpwne4OAncyNGLAHur+pACxGx3ac9AnGrb6hxeSN2/bbkQI6B2mAsb/YcJpNHRgWzoqLb26M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812973; c=relaxed/simple;
	bh=LhSBu25+c0eTQeEF6XCquY7k+fZ9Pc+dB6UDYzYH98Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SIeVHyrFCS6MQjYlQtuMrH1gjfhtKLixD4ygwjOJz9rxvImo3bsQD9ow6n89wJZjGctxaEMoaehoKblP1EMbH57+S9atyFDvNiPwHrHij9HmgjBRDhPky3fZOag7XKBbnmTtEiwXE5iA8UdrarMabOOnzIcq17J8nPmempdYY8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DvX5h/Bx; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnV/NtYPtbI33EySymJ7BgU/07FfH2YEvdQ8/CadS3D4sc3PW3ZjqsUY6mn0IHd4ZBay4OxwM6yFRCSAjXchI6uM79rMR3nB4ChrPa7kwzL1BvzaysYXxylq8fqR5KJafmVALtlKgXlCkC0AXBZxFdqYv7n3eHkorQlSXU+Cj80L0W7mWzE36gopMMkqab1LjDCdP0CNd8jKatp0jABQcuPGazL88qpURtJ5kk3swyI2Gxz2kmeQM/aWzT6TXtR9QxKRhQYWfuWsjwbwr+83RD7VoXLwlIevYmhE4EZlpg8P46+ZT8OeJlBsrqbkj2/L/0NfAhJQAwDBzNqkh8bJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ev1lXm3m2yPNyJ0OeV+t3cBFvKHbi9NO+bJ5DDFKmkE=;
 b=Ma0n6IR6YEN7Ur3a8dkLXlca9gBlN5J/We17vD6+D6tu5jYT7DX8sA1v0p7roKRvBncEqwwISotl0rNtAgIvtCxpAZq2eUnVPO3XJSj76Qz/pOh3pzmojeWuBWsDh9WgyHVzr8nvysmsO2itC/sdyjo9P/fJMciMa9r+ZellG3Z5ezrKjasH8nW1/uM6X+5mFNh7usWOt1xUFIY3TiDR4J8B2AmD+a/CXcDtf61n1C43s0CrWDvIEIxgGLX/dxU2YHjqApXeV//F5DfqsEqjt/9AI8uTfZa8pR9BRHneOBAJT0+KEbDW1BWGcoE/uebzkNepgMrlO0FRyRdkS085yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev1lXm3m2yPNyJ0OeV+t3cBFvKHbi9NO+bJ5DDFKmkE=;
 b=DvX5h/BxYyi619jbytSC8+kzD32f0J6cbtTERgt3gzBmgYM4B7YlsfGG6UAows/NNolOZKNzO0uyM9tWiOt4f/gocTBSIrSoNdPkwHOsUYnBmtA7F8BOcpKqE+obLXAMtB7zs4qQvjVzSM12EacuhXb+fBeohc6WcQ7tRmG2w72fOpdw+eaQkWvtTJh0fK2XJs614oarOgvJO+syGIUsSsCPWyRv8QWXE8m5ucrPuNK7g4NaBfBOrmKMDajBkrX09/uUCMX+kX8umLvN8FxQf8Uqf8+HJ6IQZiiBR2uEK+/72WgEVop/XEyNUhIwZpoTIvM9slpXs+RX+3SYvUJ6CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB11543.eurprd04.prod.outlook.com (2603:10a6:150:2c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 15:09:27 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 15:09:27 +0000
Date: Thu, 25 Sep 2025 11:09:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
Message-ID: <aNVbHeky1X58EYT1@lizhi-Precision-Tower-5810>
References: <20250924201837.3691486-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924201837.3691486-1-arnd@kernel.org>
X-ClientProxiedBy: BY3PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:217::30) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB11543:EE_
X-MS-Office365-Filtering-Correlation-Id: 6055316e-e8d2-4b26-83eb-08ddfc4584c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2HXmgjow2YpjWtORNTGuJDiY4+Mg/nX4KejDuwO+Dm7FKH3kKmg8uCZva6gW?=
 =?us-ascii?Q?7/2g0rrvAubZdzVdP/XvNhqS8/amnrPqlFJ2cweGiujWk/57gGZgrSWK7mDP?=
 =?us-ascii?Q?3l8IgxF7bL9nLlg4gGdhWJdeNtfGD7waPwI2PSMPKvDQIXbZRwxtpqFWvpZN?=
 =?us-ascii?Q?9GJWzFVEzphGArHgeWKeYrXDjWUpjj7kLP2EGiuq2vsOHd6nUydcqxD01hdT?=
 =?us-ascii?Q?ritZdX/RMEPLotjn+eWVpno1/6w4NAc3XlZB9G+IRUbCyWo2MCqB5aEO1v/N?=
 =?us-ascii?Q?asuYKyUX/IbPqEnmouQpyZNihM12hX/ONaKP8N0kEDY/fWnd3C2h0jEwims1?=
 =?us-ascii?Q?Wm3tY+0eo5T7GQ6EI1ngppNTUVMjzthhwcDLJS1r9yUBJy71JU64V9iUV5X6?=
 =?us-ascii?Q?FcHUt2XxjW7m9mnoE3Rl0DoyDOvrPK6Hop5PqIJjOoJceLsxRhHCvh33D5nJ?=
 =?us-ascii?Q?k2dAemq13se6kJVDbfOiHvClzM/9vfQJKYKHJj5ewpXj3L+2AI1O7Lx9+HXr?=
 =?us-ascii?Q?73lLQdWUK6osIOA9lhpQ7/7Z/NOFKgy3nLt5xhWvbtuWeIuLBTSCYOeD6HID?=
 =?us-ascii?Q?FVHdFRTZv8UptfsomQMo3O3Ri42jVUrwTWfa4IbgEzRnUw5Qfp857FI3C3hu?=
 =?us-ascii?Q?v7H88RI+hm4PG1tog2raB6n0FsxxTF5M3kAL3ii2Ue196DCL3L39ghY+9ruc?=
 =?us-ascii?Q?KvxaxMBFKPoFoUJlEdoJ71g0YDqKz9xVVucpuTacb8zNT2mpCu2mgOGhtCii?=
 =?us-ascii?Q?+ARxaauyB83PN3Ekb7toUGUy+Z4ekRTMVz9/W3nx89eZzTcI114wweSaSJtP?=
 =?us-ascii?Q?ODUmjGUi5sOhAEF1tsPXrWRP5H0mZH7WO/SVab1SmiRNka7nu2FOzpX16/3K?=
 =?us-ascii?Q?7+SG62GdWjRHsSFIYlnrMU0atRM8VhxdSuNI1Yv348FGOgTglF5FTgeoelRL?=
 =?us-ascii?Q?u0jQb3zrstShoxxYm+f4HdtWrw5tcr8UQF/8zt5niE89172IQyUIQObbsM4y?=
 =?us-ascii?Q?rRYkmygxBz+gIeJpWlMdUrNNdpED7CIbQkhkiU8FqSKl1tXKqcsPBfuOdySX?=
 =?us-ascii?Q?BK52J4XDby2VMkB1Z7+7Fm0uWNBDkXza3V8qep6OebNfBwzqSZFOKs56u1nI?=
 =?us-ascii?Q?e17KA6DE5ODi9LuwRQ64RT/DuWxYryqDSrhSXUKRR3uguOC8HM2JWG3+8DB0?=
 =?us-ascii?Q?Kl3vgyK5Vwzea6i8P1eARllcmmCFboBGoRvHr1NjImvKfFxecUfU5gj/TUH3?=
 =?us-ascii?Q?xQlG8yIX8fTaP+yXsaKDeMQQABS4tw0gyiTAu1NCtGZ+p1j+Hte6LwwXdqfA?=
 =?us-ascii?Q?C4DPflmbjHagFPw5E1eih0CByrACNIvqoCYvt32Ke716Qwsy61pL4XXQZzjT?=
 =?us-ascii?Q?/gR4op3ZTUPJo3uKkJSxiQPOFsR7EElbFNw6DwkzwhvF6pW2BzmIGYYJN20b?=
 =?us-ascii?Q?PwWpdwr3XXH4X4ID3ccN0aaI4idhoRTfxF7v80ns68fZM5C+1eTboRm7fQvy?=
 =?us-ascii?Q?lT8fBI1JVsGjgAc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v8aNrdst8qC5V16rH4i+avggQYtl5YvqMy/cY3FYwHhnkxYFkn5nH4MC55og?=
 =?us-ascii?Q?A0xZpcxcDgemIhYpZRTnCibrJVmN3NsoT88eZG2D+RjPEgQn9XSR7Kw8e9Da?=
 =?us-ascii?Q?P4Bb+/qJkfF/11NCk3J7hs4ZHE+CWiv44gjeOkdlE9vYyzwTxTo/h7SND0yA?=
 =?us-ascii?Q?PMSHKfN1rL7LJp2TWHy/ZMHcgvkHrKoMhBaU1S1k28KhIMbkQLL/9+GG39OA?=
 =?us-ascii?Q?Jd/fyEWECFVIdoJqWW0Ru2ni+7s8Xw5SKdMmEkfgAFrw/S65mKEd32RleQRm?=
 =?us-ascii?Q?lUZ7SAIpfW4SwYvjtgDLcZSGTF9lmhs6XXf8iXqkqKUta55xHa7xgaDTRt+h?=
 =?us-ascii?Q?NhBv/ZE39FVQ9V20H+78gfoAtYOCvzeYpsCRRWZnMEZfcyPHyZUuebZlxafe?=
 =?us-ascii?Q?C8gZ4RJXzah7Ks+q0K6G1LvQSMG7HBgrVklGT0mQhjNqzJqi9Wc8o7TrmH3B?=
 =?us-ascii?Q?YA+rOUuloVqcPQJpzDYCDvmeZqMBQe505G+tceMPX9Fsg6oApsXPvCVIS/45?=
 =?us-ascii?Q?UAQXaiQ9lUMf3AoA/D/XPjiYqfiAPr/MFsijO2VXCCa7neJd0w7NLhX51u59?=
 =?us-ascii?Q?8iZ0g64cW+L4CkzFPmQvM6GOkq3rzC5lnE7chiBhKYzkQT4p4yTp+wHzKD4W?=
 =?us-ascii?Q?ch20FH2yNrH4766ixSl1FP/jSi1u9wKrjGkQ/scffaGuGX/t8Nd3zbHjHyE9?=
 =?us-ascii?Q?7m/iDImd0icrvuJ7NjtdcpUE7XyBvDgAeDo5JfxXWai/B+Db6IA76hCrHGo9?=
 =?us-ascii?Q?IvTmxkq/p6wFpvnNdLsy67JZxKyu39V9UXCYjl46i+EifF+Knp3TC53AhU74?=
 =?us-ascii?Q?kF4bPD95BRB4lfPQMBmsl6qD9Dj+qdDAhUAKG+WCC7WWnF3vH8YpntgN3imE?=
 =?us-ascii?Q?lIp40DyLJo7tjJvmVxvtGWavtQ0fw5DWcVqaWYt0N5C9fkfKxa1chONCbrpf?=
 =?us-ascii?Q?6WHELJVw5diw2OvUJQyxDB+JWHTnvnEHd/3NSz8In0RN61Vhlu5ffbiabb20?=
 =?us-ascii?Q?kJSULZd+/rMKTJ9cKrnbrkQYLDqT5IjvayUG1RtziL8+71T4lwN40J7nLVlf?=
 =?us-ascii?Q?Vf0POGWYJ+ICWmnv71Ps24U/QQz3xAqrzxTD1YDigay3ufoonkep88grIelP?=
 =?us-ascii?Q?/qAAkNfVWyGdwB7zk/17I0Nfw9j+is64uaqOaPHukqswJI5Me8F9p6/0OG6M?=
 =?us-ascii?Q?XQa5p/rOs4TVUWn3Z0lnYB52cuJFrSV1caf9mmX4sSVYlRQ9X/TBGPLGAaSJ?=
 =?us-ascii?Q?p7Iv2VO/g+vE2CXKF6to+HH/2HPbHwWcE8q9QGt51bv1RQdzFi80s/1c9EGl?=
 =?us-ascii?Q?C7wS0kpOIhB9fEORIktcrJf4ZdEEMI1mWukWuQiO2SaqGPOBjUAal5QFFbOZ?=
 =?us-ascii?Q?KiP+9LC7rBtcpbDobco98GTfmLkgw61fa4dp7+J+CCvihOggocJ7os/3UH12?=
 =?us-ascii?Q?QljrvuVeF41MDUu4apn4Tw8zl8uf+c1bRK4x6rDJYeQ5bkG8zmSrfCkJ5e8o?=
 =?us-ascii?Q?VcFvVoA2eN56EmhgoYzkzet7gTNMazeV0ous3E+O63O2T9Imiy+vP6QD81Bi?=
 =?us-ascii?Q?rtycSdSW4TE95MLbCzodQPDcc7/ZtMcG5SoRSE6g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6055316e-e8d2-4b26-83eb-08ddfc4584c1
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 15:09:26.9385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Zc41RHRJ4E173IxEGYmMZP/a4a/kQJFa7Q8V+Sv7s7S+57Fk2p8m0QHOBkP7II0JAuqI+B3YH5VuvAONGdvUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11543

On Wed, Sep 24, 2025 at 10:18:33PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Short MMIO transfers that are not a multiple of four bytes in size need
> a special case for the final bytes, however the existing implementation
> is not endian-safe and introduces an incorrect byteswap on big-endian
> kernels.
>
> This usually does not cause problems because most systems are
> little-endian and most transfers are multiple of four bytes long, but
> still needs to be fixed to avoid the extra byteswap.
>
> Change the special case for both i3c_writel_fifo() and i3c_readl_fifo()
> to use non-byteswapping writesl() and readsl() with a single element
> instead of the byteswapping writel()/readl() that are meant for individual
> MMIO registers. As data is copied between a FIFO and a memory buffer,
> the writesl()/readsl() loops are typically based on __raw_readl()/
> __raw_writel(), resulting in the order of bytes in the FIFO to match
> the order in the buffer, regardless of the CPU endianess.
>
> The earlier versions in the dw-i3c and i3c-master-cdns had a correct
> implementation, but the generic version that was recently added broke it.
>
> Fixes: 733b439375b4 ("i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()")
> Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This was a recent regression, the version in 6.16 still works,
> but 6.17-rc is broken.
>
> v2 changes:
>  - add code comments
>  - write correct data buffer
> ---
>  drivers/i3c/internals.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> index 0d857cc68cc5..79ceaa5f5afd 100644
> --- a/drivers/i3c/internals.h
> +++ b/drivers/i3c/internals.h
> @@ -38,7 +38,11 @@ static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
>  		u32 tmp = 0;
>
>  		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> -		writel(tmp, addr);
> +		/*
> +		 * writesl() instead of writel() to keep FIFO
> +		 * byteorder on big-endian targets
> +		 */

endian look like how CPU decode byte order to MSB to LSB.
targets FIFO define look like

BIT 31..24   23..16     15..8     7..0
    B3        B2         B1       B0

regardless CPU is big endian or little endian system, data in memory should
be

0x000 B0
0x004 B1
0x008 B2
0x00c B3

I think your sentence in commit message is better

/* writesl() instead of writel() to keep FIFO byte orderer to match the order
in the buffer regardless of the CPU endianess.
*/

Frank
> +		writesl(addr, &tmp, 1);
>  	}
>  }
>
> @@ -55,7 +59,11 @@ static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
>  	if (nbytes & 3) {
>  		u32 tmp;
>
> -		tmp = readl(addr);
> +		/*
> +		 * readsl() instead of readl() to keep FIFO
> +		 * byteorder on big-endian targets
> +		 */
> +		readsl(addr, &tmp, 1);
>  		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
>  	}
>  }
> --
> 2.39.5
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

