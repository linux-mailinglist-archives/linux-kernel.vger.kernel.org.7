Return-Path: <linux-kernel+bounces-774079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533E5B2AE61
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B238B3B694D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCA8343D88;
	Mon, 18 Aug 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="guIbzlH5"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03C341AD0;
	Mon, 18 Aug 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535184; cv=fail; b=F3SMLUxm6/1rOY7xoLp8HU03pGkijJWRZ8e4s74/MdtQN/MAzftj3XbQ1XAizMYPfnH/fELEhSzmjwEPafOsy89F6Hm2WHG+bcHBdeIlGnOjlnE5vESOdyWgLe8ponQBMQTbePz03e+SHeUKgdsRGkRDS5VKUJXIWiHsk44gMog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535184; c=relaxed/simple;
	bh=BXGa3ywBmI4/Y4VdlDVwasMtDfv4Ju5Mb+onR6dcE8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ROxJgOAjXdv4cnnpQOAaooVWCcFH+AvI7OLW2a7TJmJL+MDliKuR466H+n7y20QxT7Z85DMqdT7WSepOojAEmHFPDdy6Ae7mC1lSGi2YTHdi9hq4JV5z4T4OzNxuAviFHPLN+gT7hlZg4OLTtlkmTx8pNUZwYV/PBLfXFAs3rKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=guIbzlH5; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJlOBuHJNWalhHy0PHgIJNcfPY+/U5rGSm+7+5PAYj7JL9REVqRrR7QtfR2VtuwtB6nNhIsPzOrAYbuq+YxvJvTE4QwRaMaf56jEFhx8jGIrcRY//j/Y6OEQUUbiQpIi3w81bE/j1p71/fHU7qqP/p5xmFxbXyHc0gwBalT5mq29wfn6hASGPaDbKlMPcQRTgrKynrOOm7oPB/GNoc0HyEdrPKh9F0VqQT9KouY8aGa3vrga5m4J1f4xwmfvfQSxaKuvFX387fwVKbhlLLmNT8ybCTRfsrDWmUZi5+KvoPQxWiQYqiQ2kjlauC6KgubvsG7+B1eETjQbu34l3jKiNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=473cQCpXm4lYFfKJ7DGcAAslx3zefgRzTQZP3QoG/a4=;
 b=RWieLs1DGWUc83X4hpkyv8YYK4OP6GbF7s6QpUM4YwoPsHrGpoIFBSrYH4mKk9KiNJeeTvmVHdm1Z1uFqdjqT/0j7UWhDWxVPVhAK9Gda54r8/y4qjS6qYKnQEY58JXY6OmR3sY3FRBRb52RgXQ+vQFy6a6x4eGFkSXvYxlDrN+UXcPU+7o82F7+wTYvGblI1HPj2j3xN0nBOZ9w5lEnwnhDURj0ug0/Jzxbcc5uF0Xb8T9gqVXK2VARSAHR1UfJPlzVjRBne8+69tScQgou2Qy+xFISLWrogWQtzxFVvCpMJDeuHUdq/RDxnz5nFlRv1y/0XdhBZd4/CNxjXk/EkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=473cQCpXm4lYFfKJ7DGcAAslx3zefgRzTQZP3QoG/a4=;
 b=guIbzlH5MTv+zx79GmCuyx412EwRWEmYFq1JAgo915KdepM7NI+DZmOD45Iu41mx712B9JMIfjdGG/DAzH3r/IPehxFpKnnC600CC1HxbZRiaoUsZ0IZUFp0c3RRlzUov4jgLPQL+97Hfw1pzG418oUbkuHrd/V6twEYcEhz2Om73IpOCQV8FsWUW8gRe51oI3jnSoLgdRUcNWga0iJ8siH3axcKDdfoQN3qq3zvzRGeCFZ6zNsFrMTi40eFDUKXzJgR6nQj+S6AghEqwS1e6lCvp7zhQvduhZCFCbbLWvVdMKceo3zI0mAnc1L2ZpqmKG493VIxrSFNvsgFwwUYmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DM4PR03MB6158.namprd03.prod.outlook.com (2603:10b6:5:399::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 16:39:39 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 16:39:39 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mun Yew Tham <mun.yew.tham@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v3 1/2] arm64: dts: Agilex5 Add gmac nodes to DTSI for Agilex5
Date: Mon, 18 Aug 2025 09:39:32 -0700
Message-ID: <20250818163933.62086-2-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250818163933.62086-1-matthew.gerlach@altera.com>
References: <20250818163933.62086-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::45) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DM4PR03MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 33071fef-1e1b-46f3-f3e9-08ddde75d2fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vCVekAt54ZsOudkvT0Ltyqzawb5aM6sCFfHFQUxckYRNXmNsQlt/eZk+/HQE?=
 =?us-ascii?Q?i8K0JgZhCHSER8oGQO0yUW7VQn6XvS27Si9xCoDeg9pzU5ogEX84PF86WeBJ?=
 =?us-ascii?Q?BbZbXfqoWbbVQrZMnAK38AXzs1NLR75tDGYAiRcIhZAqjPQ6NIg4R7Ch99JS?=
 =?us-ascii?Q?dUItdRW+mrMq2rqslDCyWmpBXQvMh65J/UeNlQdxV7HFMjzPZDkbNdz/rMJa?=
 =?us-ascii?Q?xpkN4eIx/9tvsW9bocI+gPm/81z83BMaHAFREEMo6DHW8nwIiAjd6JS+q10L?=
 =?us-ascii?Q?FvXsxS9ksnAf3aDjI5cSzpOk/c0SWn7XAHwvRed8Clb0AvWe5hDFqAHCLywg?=
 =?us-ascii?Q?w/hvZvGNAETEsVr4LGeOoxaNoEYHF5bP9MbDDqihAm3EuxJ3ezgDc5nm/67v?=
 =?us-ascii?Q?HkwBo75X4jrpPp8OWiGEAGh5brXVcvPnKy5hSbMLpmBnQQsxOHVjLsuH8tkB?=
 =?us-ascii?Q?V13+6ujFmlDvpYMVVE3lf2dtGkmPLv9+5/yqQCw9uVHbZN9dUQo5J8UVT8gc?=
 =?us-ascii?Q?w+eBnogpEwCkm6rSADSFjS6TdeuGJDXvt7KA+Rjvw5DTcEgBfTYcgH7DXgwz?=
 =?us-ascii?Q?RnabDjW/HP/EgEr/f9amxucitfgNp4lJ9exn2rRbF4PcqTAo8eGxwjbSW5Mz?=
 =?us-ascii?Q?JJjQMXm+f6bJ2T/Rl9iejRprH4GED+cOf3z9eJQhVi6Wm2+i1U8mq9820FFz?=
 =?us-ascii?Q?5R7vxxjerga+kmLvNlRmBDjJTvG0XFv5hPgmkHSv4xpZfbvUi6sNX7tsSI/m?=
 =?us-ascii?Q?IfvQq7W+GbWPdVAjSaEZoUqxX9OUFU0ezJL0xh2XhHYFmBTlmFjrtbt6DUo7?=
 =?us-ascii?Q?u7iiE22Kyj/a5KdjZwHx7WJg1YOYFh/ZLtwpnuEk5wrkPtvt/OXiplXZNpC2?=
 =?us-ascii?Q?6B2tyRtgRTlO9ry5y5v5y3SRsaXL73IZaadM9w+mjX78HV8HtScl179ZZea+?=
 =?us-ascii?Q?SpaKTGRXfEO4pjooIivKnqmZaOICmLgtsq97LYHR8TpSC4C52i9bidPa9pNF?=
 =?us-ascii?Q?NEGZ4Cafb2VBSwSDFQUQBqkUtSgM36pGF05zF+am7ALCUKS1IG2m7o1BuHOm?=
 =?us-ascii?Q?Rr097c3FyRovJmD+okYRZGGLgAKBg1NU8N5vkOwumzIocpRGOemcj7Wbr34L?=
 =?us-ascii?Q?GinO8ZyoJ7KBgfxfP1DHZt6dx3shDvPkdcqgsVZ+2295FMG4MfbVUf829Wlq?=
 =?us-ascii?Q?k1qJJczHusS3q7UNeJq+AQwyqCCU9/PyBw6PAPhX7YdN478MQjPj/b9rgzMJ?=
 =?us-ascii?Q?wucQ20zhgANB5BAj2itn3U0iolQOQH7zemJCAIemn9ZrzRRMbM27IwMlwqHj?=
 =?us-ascii?Q?UexRV7viCpTEleH3gtFcHIFPODPKB1f1xO4rrfpyhX6NREVA6DeqMypOqs7L?=
 =?us-ascii?Q?uvHr9HpnkBeEeX/nkigtFmsPxjG5/M5dzsN6IMXk51olQYlyC4cXa2ppf23z?=
 =?us-ascii?Q?UXN/P+oRcn8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sxOHZy++B4pBhJZPI8lOQ9c1f5Epu5SvLtwgD4NLYC5Kr9D2yRaPesMBScUi?=
 =?us-ascii?Q?ejuxUb1yfPR6FV0VVvpRL3NDi652EKwRf7ilRB+4xj2H2F6xURB8zqyU7Bn+?=
 =?us-ascii?Q?z+Lks/WLeoHKcTJs5SQ+bp56dy8jpv8y3duj6KpKY5zrMYf/gJh5+jpFs9qN?=
 =?us-ascii?Q?cgBN6+efmx0uF7V6kq1V4UT1D2AV9VeurxppezmslnXNJ1NVbUkDP9YH9j6m?=
 =?us-ascii?Q?EpOs122XrvLMlPJHAdmTmEYPqpf5o4wHzKt/kMGMyR8VxtruHwVuUeWExT7+?=
 =?us-ascii?Q?McTEz7IRmjrSBWgriA6z3h1yrditQj1lmuGS0aOqcanSSAX9ySYfZbBzRT+W?=
 =?us-ascii?Q?Dvl6ja3iI7vqMtzmpfHklJdWN+tnfWhBYEapFdB3HooUNIKdHEoB+LWPSzy8?=
 =?us-ascii?Q?oaUPrSQ+UBGUpGVT/k4K4Qa58ygeL8tWVFLjK+LhwSHYRSbvDgZpxdjqoNBU?=
 =?us-ascii?Q?6i16Isff8Zz81GP1i/B4hKo0a6bD+h5z7ho8YwhvunYBBsWkT3+PLnFSo7Fi?=
 =?us-ascii?Q?SkK6NHnuT6tXBnNudXEUt05fuCM9eg4Zc2h9gqvhQCAqDCXxtJGQUykjz/+x?=
 =?us-ascii?Q?Iz7/WU3gQuv8BybDabuZj7Fx/3WKmrqfylS/lJARx56/EDAmIR+AdYo6V3AV?=
 =?us-ascii?Q?SgzBSQ/WubyBO037NqZOSYXbplrsgM+dhgzga3Mdare6reqlT6wnvK0PBavs?=
 =?us-ascii?Q?Npc0ic3MX05u8eJdFLFvoIODP1zX2b1x2DI6cv9WxawzKNyMN/7Rs6Max1RI?=
 =?us-ascii?Q?WJqGrcjms1IIL/2wbx9eI50q0OZJ6DVRbtKIqrDK5/uofNv0HNxywI9BOE+h?=
 =?us-ascii?Q?5OCAqusxfVP5+Q8PlESKFssqTYZ3PfW50pyPkwpqqCt34GBTH7ThEoQw5Y4Y?=
 =?us-ascii?Q?wvx1ceGjprOn3jHjmWO1bgCByk9bE9EMoQEQrEvZLFbZZ9L1mrSs4AxfCYlM?=
 =?us-ascii?Q?9hRYKpJCnmGsb6EBdjEGVKvEc1/sHClnBOCkB37oLc93FPENLCCU4D37CrNR?=
 =?us-ascii?Q?f0bqmUykmjm1Sz9sLKQ8SVoXLvYTRDgydiXGB09t+ob5RhiqUJB1xct+H/Lm?=
 =?us-ascii?Q?4s3Tno7uLWkvSIo/pjaQwXhPzAhiy7YruEb+29diASGVHgEVsAeEV9GguF6z?=
 =?us-ascii?Q?RPK8LIVJwFJHkraUbmzZdRp4/SwvZRFxBOlZTK83ruE5+62g6Ec89wVneFxp?=
 =?us-ascii?Q?QYnBf45Gjyj7lS6QqnO7X/swP4aXMjxKpAsFbww6tzfv/X6Scp8OoGvh+YZk?=
 =?us-ascii?Q?17QigTKtAA6m88T7jrI3PbgvJ7bAvkXFMcoGils+l/gcYjnjg8vspwUv+YkD?=
 =?us-ascii?Q?VY5w6ULTdDnZugHo0+1Q9uxc8foA6Il4jHg+04PdZA6dW9dr2Cu4rzymcvRF?=
 =?us-ascii?Q?O5LiDz7PrKLL1TtglPO2HcSnlB4YNy4uh7kZsoZVY6nC3Z4f6LDKDkRgWQM9?=
 =?us-ascii?Q?kzbtDlVDwhuTiliOILoKKef7hD7omFstGCPd/BkGF71m7HkGOSrH9govUphU?=
 =?us-ascii?Q?lsbTJ0+dbJBPPcQ3mBnB9oiNzEqvuIvXSoylNuDrOaAQpKamcfhIiiyFyWsk?=
 =?us-ascii?Q?gBu8FvV4xTHJqnva0j4diggq0uwFjW6rWZsz5HX/0k1tilhllVfpKcv8stV+?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33071fef-1e1b-46f3-f3e9-08ddde75d2fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:39:39.0918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+Gf8AOYO5BWUTd8GwRYx8JKkTc6O668AF3n0vnetl61S5XTZ3VmZrxO1BUzgVdToORLRtoYUBVsS7OYqmPrNK+POGxV19DXXj79911YbPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6158

From: Mun Yew Tham <mun.yew.tham@altera.com>

Add the base device tree nodes for gmac0, gmac1, and gmac2 to the DTSI
for the Agilex5 SOCFPGA.  Agilex5 has three Ethernet controllers based on
Synopsys DWC XGMAC IP version 2.10.

Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
v3:
 - No change from v2.

v2:
 - Remove generic compatible string for Agilex5.
---
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 336 ++++++++++++++++++
 1 file changed, 336 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 7d9394a04302..04e99cd7e74b 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -486,5 +486,341 @@ qspi: spi@108d2000 {
 			clocks = <&qspi_clk>;
 			status = "disabled";
 		};
+
+		gmac0: ethernet@10810000 {
+			compatible = "altr,socfpga-stmmac-agilex5",
+				     "snps,dwxgmac-2.10";
+			reg = <0x10810000 0x3500>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
+			reset-names = "stmmaceth", "ahb";
+			clocks = <&clkmgr AGILEX5_EMAC0_CLK>,
+				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
+			mac-address = [00 00 00 00 00 00];
+			tx-fifo-depth = <32768>;
+			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <64>;
+			snps,axi-config = <&stmmac_axi_emac0_setup>;
+			snps,mtl-rx-config = <&mtl_rx_emac0_setup>;
+			snps,mtl-tx-config = <&mtl_tx_emac0_setup>;
+			snps,pbl = <32>;
+			snps,tso;
+			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
+			snps,clk-csr = <0>;
+			status = "disabled";
+
+			stmmac_axi_emac0_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <31>;
+				snps,rd_osr_lmt = <31>;
+				snps,blen = <0 0 0 32 16 8 4>;
+			};
+
+			mtl_rx_emac0_setup: rx-queues-config {
+				snps,rx-queues-to-use = <8>;
+				snps,rx-sched-sp;
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x1>;
+				};
+				queue2 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x2>;
+				};
+				queue3 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x3>;
+				};
+				queue4 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x4>;
+				};
+				queue5 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x5>;
+				};
+				queue6 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x6>;
+				};
+				queue7 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x7>;
+				};
+			};
+
+			mtl_tx_emac0_setup: tx-queues-config {
+				snps,tx-queues-to-use = <8>;
+				snps,tx-sched-wrr;
+				queue0 {
+					snps,weight = <0x09>;
+					snps,dcb-algorithm;
+				};
+				queue1 {
+					snps,weight = <0x0A>;
+					snps,dcb-algorithm;
+				};
+				queue2 {
+					snps,weight = <0x0B>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue3 {
+					snps,weight = <0x0C>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue4 {
+					snps,weight = <0x0D>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue5 {
+					snps,weight = <0x0E>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue6 {
+					snps,weight = <0x0F>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue7 {
+					snps,weight = <0x10>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+			};
+		};
+
+		gmac1: ethernet@10820000 {
+			compatible = "altr,socfpga-stmmac-agilex5",
+				     "snps,dwxgmac-2.10";
+			reg = <0x10820000 0x3500>;
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
+			reset-names = "stmmaceth", "ahb";
+			clocks = <&clkmgr AGILEX5_EMAC1_CLK>,
+				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
+			mac-address = [00 00 00 00 00 00];
+			tx-fifo-depth = <32768>;
+			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <64>;
+			snps,axi-config = <&stmmac_axi_emac1_setup>;
+			snps,mtl-rx-config = <&mtl_rx_emac1_setup>;
+			snps,mtl-tx-config = <&mtl_tx_emac1_setup>;
+			snps,pbl = <32>;
+			snps,tso;
+			altr,sysmgr-syscon = <&sysmgr 0x48 0>;
+			snps,clk-csr = <0>;
+			status = "disabled";
+
+			stmmac_axi_emac1_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <31>;
+				snps,rd_osr_lmt = <31>;
+				snps,blen = <0 0 0 32 16 8 4>;
+			};
+
+			mtl_rx_emac1_setup: rx-queues-config {
+				snps,rx-queues-to-use = <8>;
+				snps,rx-sched-sp;
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x1>;
+				};
+				queue2 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x2>;
+				};
+				queue3 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x3>;
+				};
+				queue4 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x4>;
+				};
+				queue5 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x5>;
+				};
+				queue6 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x6>;
+				};
+				queue7 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x7>;
+				};
+			};
+
+			mtl_tx_emac1_setup: tx-queues-config {
+				snps,tx-queues-to-use = <8>;
+				snps,tx-sched-wrr;
+				queue0 {
+					snps,weight = <0x09>;
+					snps,dcb-algorithm;
+				};
+				queue1 {
+					snps,weight = <0x0A>;
+					snps,dcb-algorithm;
+				};
+				queue2 {
+					snps,weight = <0x0B>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue3 {
+					snps,weight = <0x0C>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue4 {
+					snps,weight = <0x0D>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue5 {
+					snps,weight = <0x0E>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue6 {
+					snps,weight = <0x0F>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue7 {
+					snps,weight = <0x10>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+			};
+		};
+
+		gmac2: ethernet@10830000 {
+			compatible = "altr,socfpga-stmmac-agilex5",
+				     "snps,dwxgmac-2.10";
+			reg = <0x10830000 0x3500>;
+			interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
+			reset-names = "stmmaceth", "ahb";
+			clocks = <&clkmgr AGILEX5_EMAC2_CLK>,
+				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
+			clock-names = "stmmaceth", "ptp_ref";
+			mac-address = [00 00 00 00 00 00];
+			tx-fifo-depth = <32768>;
+			rx-fifo-depth = <16384>;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <64>;
+			snps,axi-config = <&stmmac_axi_emac2_setup>;
+			snps,mtl-rx-config = <&mtl_rx_emac2_setup>;
+			snps,mtl-tx-config = <&mtl_tx_emac2_setup>;
+			snps,pbl = <32>;
+			snps,tso;
+			altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
+			snps,clk-csr = <0>;
+			status = "disabled";
+
+			stmmac_axi_emac2_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <31>;
+				snps,rd_osr_lmt = <31>;
+				snps,blen = <0 0 0 32 16 8 4>;
+			};
+
+			mtl_rx_emac2_setup: rx-queues-config {
+				snps,rx-queues-to-use = <8>;
+				snps,rx-sched-sp;
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x1>;
+				};
+				queue2 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x2>;
+				};
+				queue3 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x3>;
+				};
+				queue4 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x4>;
+				};
+				queue5 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x5>;
+				};
+				queue6 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x6>;
+				};
+				queue7 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x7>;
+				};
+			};
+
+			mtl_tx_emac2_setup: tx-queues-config {
+				snps,tx-queues-to-use = <8>;
+				snps,tx-sched-wrr;
+				queue0 {
+					snps,weight = <0x09>;
+					snps,dcb-algorithm;
+				};
+				queue1 {
+					snps,weight = <0x0A>;
+					snps,dcb-algorithm;
+				};
+				queue2 {
+					snps,weight = <0x0B>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue3 {
+					snps,weight = <0x0C>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue4 {
+					snps,weight = <0x0D>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue5 {
+					snps,weight = <0x0E>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue6 {
+					snps,weight = <0x0F>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+				queue7 {
+					snps,weight = <0x10>;
+					snps,coe-unsupported;
+					snps,dcb-algorithm;
+				};
+			};
+		};
 	};
 };
-- 
2.35.3


