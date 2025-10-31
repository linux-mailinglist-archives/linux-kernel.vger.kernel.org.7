Return-Path: <linux-kernel+bounces-880810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C4DC26A35
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 553D34E85E3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226BF2EBDFD;
	Fri, 31 Oct 2025 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VZsIVdp4"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011032.outbound.protection.outlook.com [40.107.130.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C95F14B08A;
	Fri, 31 Oct 2025 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761936195; cv=fail; b=FGYNNdv2Ee4QHPhce5b19c9Hj/SytV7RHg6vD9qDQPJMplqBQ/xRx3+HDPUoT2InxhP32AOkbOPoMv5J2k4IFKqVOeCJmsyFoy3swsCeKdwGDAujBXCHwa+f/gUeVHSI4N2pXVpTBCxJsuT3KyKAL83CVugZfz6XQKBu/mK3ySk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761936195; c=relaxed/simple;
	bh=SVhCzAvt34GEHEiXG3VawWOukmljFuT1iZ7Ja/HA/i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ntJgHVgzBUF4Z6ZLv8kO/87RpnmrgU2uT8L96xET2Urr9HX/V2SpduidPfWECJDu2ArZ7CKcgdoAwREY7NuSXrIBZNf11MO0X13Pph6mQl06Ca6Gn/GM4H8do4O5TsReZ34Byr2mHEMEhhepAs2VrVvZ1ys3t2ZcI4WaJJxw9rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VZsIVdp4; arc=fail smtp.client-ip=40.107.130.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzGNAW9+LxkOcAw8H1ukSNtBUnym/hOQWUdyeGqfSQlcysp97eNOa70mJgd+SkUsgqnhwBx5esGlPvZfOl8GQe3vz5jNXmZlJlWqzd85DZVXGKWyz7ye9A0LUm8ogfgVVzide5FmD/kS7QWcLrl7y0Yfn5W8AL30p7ldcpzhRz6qkHPSxn3E+8tlbPE0M0c1FFDJkp076nAG12ZXOMyKtG3KgtylanMvMZhMYWilCzmkmADImp3QpJdDCcUTeNRLn6+nBiI++wEFsV3s7OF+sWOC9lSVIA26STkrij71jdMr+lGJp9o7HRI7lBkDtfviROAZWVHxYwj/hlnr2Z1zIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJVA0tFOWo1twwf8oW722DzvHGaNdN3cw/VeaSzPzXU=;
 b=Q/I7GS0JWnQcYZr0ROJNxDMqO1kiMZ9tEE1lmHRTejQ5UaCx5V3u6y2t6EZr26YuImGn+1g+7tLtCvFNndWUpDagzx7R7+9tzglJIAXzEKeUHVZOKi7eg02n+EtWP8G1iObwgyq7CEY+cz0NkFAeLdC3Day3U58osmUHY7pL59i9ACQaWdpjf3WWHhNeO7VEJQFqNJ7CAxqOcYdPPZuVLdw13HXmoQU/eav++d2d8D2Scby+k3SaglCCLomkN7CiN8bUvEtZ4lmLVJOTGtJmEVQHm6bd8jo4WlCu0aBsDw4FKfO88CYYjhO2pQQO6uY+l25oO8Rv16YHGgLVa/XcvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJVA0tFOWo1twwf8oW722DzvHGaNdN3cw/VeaSzPzXU=;
 b=VZsIVdp4Hmaz1IGgvHc+c6OzSMRNnRWVnrlMZSWfQIzcv/ZrpU2r8Ysv1I7jLlW8KhJa/eiBNpp9UjATonXuymoJ47+i7nWUfspopDNX+fVIb32igUEHchEInlmsIXwmmHEx63AcVRkBVkh5u/5djZ7lGZEpnrlp577/tPyRsmYaFEcYWwd9L7ktdfEu82+DueVOYXNoKuLW6OGFhi0+u5QdZ6AhlD2EmHWNVJX2gwI2D7m3i/89ciy4U+wMcNn95/iRPx2yq9pc9di4mGfzPAWgpqwaBBOItziCiT07PCEWDoQ386n7hYGRSHc3bebs6WvYnk8gyAifO+jvtPo3yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 18:43:08 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 18:43:08 +0000
Date: Fri, 31 Oct 2025 14:43:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: adrianhoyin.ng@altera.com
Cc: alexandre.belloni@bootlin.com, wsa+renesas@sang-engineering.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dinguyen@kernel.org, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] i3c: dw: Add runtime PM disable quirk for Altera
 Agilex5
Message-ID: <aQUDNTWE1d+fgFbG@lizhi-Precision-Tower-5810>
References: <cover.1761901158.git.adrianhoyin.ng@altera.com>
 <81ec74bab4ed1e843709ad95acfe2757b737abb4.1761901158.git.adrianhoyin.ng@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ec74bab4ed1e843709ad95acfe2757b737abb4.1761901158.git.adrianhoyin.ng@altera.com>
X-ClientProxiedBy: PH8P221CA0037.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::8) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV1PR04MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 559ee4ca-4b1e-4561-c611-08de18ad55b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?burhSGYITM8v+RsR1rRf0+Vv47pQ5FQ952vQkKHo1aID/eLwfWYYL0+n8WYQ?=
 =?us-ascii?Q?53Otyd2dYXIGOgRoh7G9XCz2E19vg8S0kHnie9EUwQUsrrZkHto72ZazeKst?=
 =?us-ascii?Q?uSzxk/pq7ZX64uLGa5BBRWRBFb0RtiBMEf4XC5t+5KKvuJfvNMGHnhiIhpIT?=
 =?us-ascii?Q?PgEVl0wMCFH8J3ReDb04gwO5RZyAk42P6p0aEu37/glIXazy2DiSXCap9Mi0?=
 =?us-ascii?Q?xS189UZhojb5i5lyMXm1aO63AsayichuXniYQ+/duSjM4E61iXP7AGuS2tFq?=
 =?us-ascii?Q?XqVdnbssPJ7fo23HFLvL5NM6pm3c0M8P/AWhyGGNx8wmhdFz7y8u89ZScZhe?=
 =?us-ascii?Q?0+JTj9a46ZRqSHR5RzsEfiLE8N1VDnclTL9JHuXnniPmJM9mMO1i4dm0l1GJ?=
 =?us-ascii?Q?qcvhhTxC1VPugzm7ijbKZlOn9eP104vS6YtLUI4gd/XLQypulbKbW/Mh3NEC?=
 =?us-ascii?Q?ZM7E6imRfPpnZuODiGWfWFakn7Oj1rI+gSc1dHvOW6aKsSOb2TGzkPT/DYNo?=
 =?us-ascii?Q?WWAGdwD6uSU0MVTg0xamMVaYcyJTzhoMxOo/ZwCFajUdUm64Hh4WNaHSbkVK?=
 =?us-ascii?Q?b6QTZeZFWj1Z+A1tkTDuQIr4Sg2ntyv9pDgpg8HMSEAV59lBuDfq3AMTtWOt?=
 =?us-ascii?Q?PH7WXqaCqSzTb46y5RrZ/uLSTDlWeF0ohAhyv1d+nPSs9Tn3xwy20jNanGEc?=
 =?us-ascii?Q?B9zS3HmRplh/TGGAaahej2NQQ0w2FrS7ON9cBt+6M4N9HUGMg9rVyAv3MJkH?=
 =?us-ascii?Q?WvpYiXR9HCfJ52q2VJnf4zIDhAOBtDG1jaPGIhJ1yMCUGEcqwn0n0vRw1Tc9?=
 =?us-ascii?Q?MllEzKC34tDCM20QuC28oaU/bBn/6T3h5QleziT/AyC1USLPCcvL9Qe4Lj7X?=
 =?us-ascii?Q?qDwfhC6qo1TmKYhtwwAuBMbJWDyJIN6ln7x4y5sIdhvzV9tfIrzA3BAAiTW1?=
 =?us-ascii?Q?vE/gLdct5Z3uLfOBOP75HWPf0b709EJ7z0bYr6eCMwhtnYwKCBUrFKiN7n0Q?=
 =?us-ascii?Q?+1EHLBQeWeUot7dz2RIUiAs8+wtyYRfg/qB4Ip9fTNcEJbiE75z9MXtrYX9C?=
 =?us-ascii?Q?Ln15VpPnfwFpxEjLArcwSygda65HVPXWqto82xTOHWmSSG8mx0RVbGsBGNJC?=
 =?us-ascii?Q?Hps5VJQkrsAkdMhw88rdWxjVCLL8d4rs65jp4bQXhVljRcf8PHgHswSrIqCE?=
 =?us-ascii?Q?QW/RgGVAiHjSgI85+BjpleAc8tDx4ap57Mc32RBgXvdvNAgkCNVvtxMzVNGn?=
 =?us-ascii?Q?SI0aMNass41ChLLxpaQOEoM8XvIf/NSbOzMO9F5BSf7L20S3Ng4P/x6etpXN?=
 =?us-ascii?Q?Sis6t/NkR+ZLC6wfz7qM6UMqYXtuIPQB2fcjX3dJXVakWU3Wj5BuVCYQqPsj?=
 =?us-ascii?Q?OUluY02jAfK/qyM1sH1JUS+88NBLii/C/IYWEQLazeeLRKXUKnAfoU1ott9B?=
 =?us-ascii?Q?JnFpIKHHalau/6TfRTzII8CKHAAZ3dU6twb2mXe4jvf2MuQVnhzv4NqqQqhC?=
 =?us-ascii?Q?iLG0f922rDVFHOGrX72u1+0RyoKTZ2TI7Std?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DZEsZvLIVQYUaoAOfQup9BHIFDc6NnZiPjiUuHaYMw115oLHHRx3OKVoiTga?=
 =?us-ascii?Q?nxUnIQx3SPX/sCra0lTrMlMPOGi7PFTpK1nhQQ0QXUFp+C6ztxehGms46fHB?=
 =?us-ascii?Q?v9WnuGuYPx7Qed5mHbKQ8F0j7sKyR3YjjyqJf7Zg1PFtJSVUwTRJNRBztKgH?=
 =?us-ascii?Q?z637qm05SXggtJEtB22FNdVq1jFSMpZND0yhWN4VGNhYvPq7qPVUFldITx4B?=
 =?us-ascii?Q?wCsJcK6nG8juvXhx1tjd03QKaSz7k6W/2Lui4H1k3NfXik05jhn8FgpDAwLe?=
 =?us-ascii?Q?sSzvV7DbCo66Wpxu4rpFp4ube3XdkD5FABsnl8ELfCWbVlR34TOZnyGNtZSz?=
 =?us-ascii?Q?b/j9U6+3bkMOY9UVhp5xtRXpXUaz9d93OFqK7KQlclQSj3ihjzLq6DJYvW/R?=
 =?us-ascii?Q?lkEVZE81okkL9IWxRJ/NgZN6OJu7+2SNs2q+rBXivYpnwB9cdj88BJhQNs7X?=
 =?us-ascii?Q?UJ1Ifup3WtCtVm1TBvapkJ1+3KAL1KfX5/mEh40M5Go+HIOmLGj7Kb2fM4S7?=
 =?us-ascii?Q?4+xIIMMruuMqcxQrs1ljw5vXSHLEpzbrAn3WrvS/bRGsv9MaJMeLbRxH0HlP?=
 =?us-ascii?Q?X/InEVN1wtb5X9R6xe7B0qHevNPFTjtCFaPGu2aGhSWcB9HmbMYCUZdJBXls?=
 =?us-ascii?Q?wLzudJZb8FFFxjqXo6bAeRvq1lGsWPHkMllwiLSpsZYKWAUTcMDS09VaGF2a?=
 =?us-ascii?Q?xOETIT/690O/H/itdzie7qBsg/+vl8lrLQwDEiaEfvvwxsvMsG5esgxlhV19?=
 =?us-ascii?Q?OvavPWAuala/nm7aYEVd5W6B8RgP0WdPrqjxAacbnMuDanjulTMBu/BXRDDi?=
 =?us-ascii?Q?ovl4CSt5qXdhIYW3IFMKXWVbvzcL3trBuRa7PdcY+sfvTnk0+vivTbWGxvvz?=
 =?us-ascii?Q?rNkSzLZNckS5cjK97OWIIrrmYpENyE8YgdMJhmrdXZ1/jx3wxRERoArqBTUa?=
 =?us-ascii?Q?RnAAg70FgoQrxxYvRlkpp25Gx7tDFoqpvwhkgXv+A8ULkWrjORVtAfNA23LP?=
 =?us-ascii?Q?zrUq5ADzISMruTfiGJPLxsEEaMBiqca4YU6cwYlYOW1YcJFj1AGhu4/2kNbb?=
 =?us-ascii?Q?Gv0P8H/iB8EL4rZyQy8nU6VHzQBdS3XUrlfSf6/sy+6ZMkDiOWwNcly9mZdk?=
 =?us-ascii?Q?GoRDAomwmdMXNxlc6gtukqP3km/jLfSEw2DWSjlaxX7dYRYHyGhrcMRqMHMd?=
 =?us-ascii?Q?5SUJdqXU53AkZgO2YcLRqWvxuYzA5epCewa1ZQrc4C478KdcTvDxXp9t0Zp8?=
 =?us-ascii?Q?qIo805HaV5Q/jfoVzpm6owDhRUHDeTPmL+OGZyS+1Z83YGnFAUSlh/eMBwnL?=
 =?us-ascii?Q?e5dkRbfrYsq2ggsfNQbvhVHKaslBxijxATiDoduEH/+ZpyTl45CkAJpjhHh4?=
 =?us-ascii?Q?QiGQEJDJi7U0YcsSTcsxEthMHLaUtjI66Xnm4vC7Qd0Vn7ACmmoMpfTl9tqp?=
 =?us-ascii?Q?cbgxzhpKQs/SBODIeeAccgVphwC5V1sJGqCCPnnH5pNZs9Go3rzyQwz14yiZ?=
 =?us-ascii?Q?820I+nW7SvhKJi2PFDKAdLza36kV1kb+7gyC8+wU3wKsPS6+8ENOcBNZbBk/?=
 =?us-ascii?Q?cw+nW0qsAhaWPLJ4O5swjBizifKX0j6OsMWmRk7r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559ee4ca-4b1e-4561-c611-08de18ad55b9
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 18:43:08.6357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOsSGWvMNnC5kzXY8FUymK14D18wOpazGZsPU1cDadbW+ya19zbd3K2+hu0onVl8s+NTDbzVitlKJFEuyOD3ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216

On Fri, Oct 31, 2025 at 05:05:58PM +0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
>
> Add support for disabling runtime power management (PM) in the
> Synopsys DesignWare I3C master driver through a new quirk flag,
> DW_I3C_DISABLE_RUNTIME_PM_QUIRK. When this quirk is active,
> the driver skips all runtime PM operations (e.g. pm_runtime_enable(),
> pm_runtime_get(), and pm_runtime_put()), keeping the controller
> continuously powered.
>
> This change addresses a reliability issue observed on Altera Agilex5
> where the i3c bus enters a hung state when a slave device tries to send
> an IBI while the controller is in a suspended state which happens after
> the DAA procedures. Once suspended, the controller no longer drives the
> SCL line, causing the SDA line to remain low and leaving the I3C bus in
> a hung state when a slave device tries to send an IBI. Disabling runtime
> PM ensures the controller remains active, allowing IBI transactions to
> complete correctly.
>
> A new compatible string, "altr,agilex5-dw-i3c-master", is added to
> represent the SoC-specific variant of the DesignWare I3C controller,
> which requires runtime PM to remain disabled.
>
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 171 +++++++++++++++++------------
>  1 file changed, 103 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 9ceedf09c3b6..97da2b17b5aa 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -228,6 +228,7 @@
>
>  /* List of quirks */
>  #define AMD_I3C_OD_PP_TIMING		BIT(1)
> +#define DW_I3C_DISABLE_RUNTIME_PM_QUIRK	BIT(2)
>
>  struct dw_i3c_cmd {
>  	u32 cmd_lo;
> @@ -635,12 +636,14 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
>  	struct i3c_device_info info = { };
>  	int ret;
>
> -	ret = pm_runtime_resume_and_get(master->dev);
> -	if (ret < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, ret);
> -		return ret;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		ret = pm_runtime_resume_and_get(master->dev);
> +		if (ret < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, ret);
> +			return ret;
> +		}
>  	}
>
>  	ret = master->platform_ops->init(master);
> @@ -682,7 +685,8 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
>  	dw_i3c_master_enable(master);
>
>  rpm_out:
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  	return ret;
>  }
>
> @@ -798,12 +802,14 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
>  		writel(master->i3c_od_timing, master->regs + SCL_I3C_OD_TIMING);
>  	}
>
> -	ret = pm_runtime_resume_and_get(master->dev);
> -	if (ret < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, ret);
> -		return ret;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		ret = pm_runtime_resume_and_get(master->dev);
> +		if (ret < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, ret);
> +			return ret;
> +		}
>  	}
>
>  	if (ccc->rnw)
> @@ -811,7 +817,8 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
>  	else
>  		ret = dw_i3c_ccc_set(master, ccc);
>
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  	return ret;
>  }
>
> @@ -824,12 +831,14 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
>  	u8 last_addr = 0;
>  	int ret, pos;
>
> -	ret = pm_runtime_resume_and_get(master->dev);
> -	if (ret < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, ret);
> -		return ret;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		ret = pm_runtime_resume_and_get(master->dev);
> +		if (ret < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, ret);
> +			return ret;
> +		}
>  	}
>
>  	olddevs = ~(master->free_pos);
> @@ -893,7 +902,8 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
>  	dw_i3c_master_free_xfer(xfer);
>
>  rpm_out:
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  	return ret;
>  }
>
> @@ -929,12 +939,14 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
>  	if (!xfer)
>  		return -ENOMEM;
>
> -	ret = pm_runtime_resume_and_get(master->dev);
> -	if (ret < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, ret);
> -		return ret;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		ret = pm_runtime_resume_and_get(master->dev);
> +		if (ret < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, ret);
> +			return ret;
> +		}
>  	}
>
>  	for (i = 0; i < i3c_nxfers; i++) {
> @@ -978,7 +990,8 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
>  	ret = xfer->ret;
>  	dw_i3c_master_free_xfer(xfer);
>
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  	return ret;
>  }
>
> @@ -1089,12 +1102,14 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
>  	if (!xfer)
>  		return -ENOMEM;
>
> -	ret = pm_runtime_resume_and_get(master->dev);
> -	if (ret < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, ret);
> -		return ret;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		ret = pm_runtime_resume_and_get(master->dev);
> +		if (ret < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, ret);
> +			return ret;
> +		}
>  	}
>
>  	for (i = 0; i < i2c_nxfers; i++) {
> @@ -1127,7 +1142,8 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
>  	ret = xfer->ret;
>  	dw_i3c_master_free_xfer(xfer);
>
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  	return ret;
>  }
>
> @@ -1272,12 +1288,14 @@ static int dw_i3c_master_enable_hotjoin(struct i3c_master_controller *m)
>  	struct dw_i3c_master *master = to_dw_i3c_master(m);
>  	int ret;
>
> -	ret = pm_runtime_resume_and_get(master->dev);
> -	if (ret < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, ret);
> -		return ret;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		ret = pm_runtime_resume_and_get(master->dev);
> +		if (ret < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, ret);
> +			return ret;
> +		}
>  	}
>
>  	dw_i3c_master_enable_sir_signal(master, true);
> @@ -1294,7 +1312,8 @@ static int dw_i3c_master_disable_hotjoin(struct i3c_master_controller *m)
>  	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_HOT_JOIN_NACK,
>  	       master->regs + DEVICE_CTRL);
>
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  	return 0;
>  }
>
> @@ -1305,12 +1324,14 @@ static int dw_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
>  	struct dw_i3c_master *master = to_dw_i3c_master(m);
>  	int rc;
>
> -	rc = pm_runtime_resume_and_get(master->dev);
> -	if (rc < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, rc);
> -		return rc;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		rc = pm_runtime_resume_and_get(master->dev);
> +		if (rc < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, rc);
> +			return rc;
> +		}
>  	}
>
>  	dw_i3c_master_set_sir_enabled(master, dev, data->index, true);
> @@ -1319,7 +1340,8 @@ static int dw_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
>
>  	if (rc) {
>  		dw_i3c_master_set_sir_enabled(master, dev, data->index, false);
> -		pm_runtime_put_autosuspend(master->dev);
> +		if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +			pm_runtime_put_autosuspend(master->dev);
>  	}
>
>  	return rc;
> @@ -1338,7 +1360,8 @@ static int dw_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
>
>  	dw_i3c_master_set_sir_enabled(master, dev, data->index, false);
>
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  	return 0;
>  }
>
> @@ -1573,11 +1596,6 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>
>  	platform_set_drvdata(pdev, master);
>
> -	pm_runtime_set_autosuspend_delay(&pdev->dev, RPM_AUTOSUSPEND_TIMEOUT);
> -	pm_runtime_use_autosuspend(&pdev->dev);
> -	pm_runtime_set_active(&pdev->dev);
> -	pm_runtime_enable(&pdev->dev);
> -
>  	/* Information regarding the FIFOs/QUEUEs depth */
>  	ret = readl(master->regs + QUEUE_STATUS_LEVEL);
>  	master->caps.cmdfifodepth = QUEUE_STATUS_LEVEL_CMD(ret);
> @@ -1592,6 +1610,13 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>
>  	master->quirks = (unsigned long)device_get_match_data(&pdev->dev);
>
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		pm_runtime_set_autosuspend_delay(&pdev->dev, RPM_AUTOSUSPEND_TIMEOUT);
> +		pm_runtime_use_autosuspend(&pdev->dev);
> +		pm_runtime_set_active(&pdev->dev);
> +		pm_runtime_enable(&pdev->dev);
> +	}
> +

I think you just need increase runtime pm refer counter should be enough.

if (master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)
	pm_runtime_get_noresume(dev);

So all runtime_pm function will no be called because ref counter always
bigger than 0.

Frank

>  	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
>  	ret = i3c_master_register(&master->base, &pdev->dev,
>  				  &dw_mipi_i3c_ops, false);
> @@ -1601,9 +1626,11 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>  	return 0;
>
>  err_disable_pm:
> -	pm_runtime_disable(&pdev->dev);
> -	pm_runtime_set_suspended(&pdev->dev);
> -	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		pm_runtime_disable(&pdev->dev);
> +		pm_runtime_set_suspended(&pdev->dev);
> +		pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	}
>
>  err_assert_rst:
>  	reset_control_assert(master->core_rst);
> @@ -1617,9 +1644,11 @@ void dw_i3c_common_remove(struct dw_i3c_master *master)
>  	cancel_work_sync(&master->hj_work);
>  	i3c_master_unregister(&master->base);
>
> -	pm_runtime_disable(master->dev);
> -	pm_runtime_set_suspended(master->dev);
> -	pm_runtime_dont_use_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		pm_runtime_disable(master->dev);
> +		pm_runtime_set_suspended(master->dev);
> +		pm_runtime_dont_use_autosuspend(master->dev);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(dw_i3c_common_remove);
>
> @@ -1742,12 +1771,14 @@ static void dw_i3c_shutdown(struct platform_device *pdev)
>  	struct dw_i3c_master *master = platform_get_drvdata(pdev);
>  	int ret;
>
> -	ret = pm_runtime_resume_and_get(master->dev);
> -	if (ret < 0) {
> -		dev_err(master->dev,
> -			"<%s> cannot resume i3c bus master, err: %d\n",
> -			__func__, ret);
> -		return;
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
> +		ret = pm_runtime_resume_and_get(master->dev);
> +		if (ret < 0) {
> +			dev_err(master->dev,
> +				"<%s> cannot resume i3c bus master, err: %d\n",
> +				__func__, ret);
> +			return;
> +		}
>  	}
>
>  	cancel_work_sync(&master->hj_work);
> @@ -1756,11 +1787,15 @@ static void dw_i3c_shutdown(struct platform_device *pdev)
>  	writel((u32)~INTR_ALL, master->regs + INTR_STATUS_EN);
>  	writel((u32)~INTR_ALL, master->regs + INTR_SIGNAL_EN);
>
> -	pm_runtime_put_autosuspend(master->dev);
> +	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
> +		pm_runtime_put_autosuspend(master->dev);
>  }
>
>  static const struct of_device_id dw_i3c_master_of_match[] = {
>  	{ .compatible = "snps,dw-i3c-master-1.00a", },
> +	{ .compatible = "altr,agilex5-dw-i3c-master",
> +	  .data = (void *)DW_I3C_DISABLE_RUNTIME_PM_QUIRK,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
> --
> 2.49.GIT
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

