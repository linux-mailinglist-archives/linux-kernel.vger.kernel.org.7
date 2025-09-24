Return-Path: <linux-kernel+bounces-830683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A64B9A4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777071B26649
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060B03093BF;
	Wed, 24 Sep 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="AiVNVXlx"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022082.outbound.protection.outlook.com [52.101.66.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9629B3002A6;
	Wed, 24 Sep 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724776; cv=fail; b=CgDnfEb/dSqJ1vPw5TF5Gj33JzekVJNd6fFYOp/FYlEUzYnAX/bQJfPp4oUVkzGZcdp5tXBpO2OEbdGLEZvg77zjGS+WU+ABgg1hreu5QyrBo7LUtEGGRHpzKXR5QZfEfFjDVMLnvnCEaGvwhK4pqrdhWfcK8o8YLLKNRV7qGug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724776; c=relaxed/simple;
	bh=CiYu3HNM8z/a23z14xWsBAhmB1iGdK+lAcASo4A+pfA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gQ0i/j/qZsYL9ird0xoQ+abiVEQK9IVP7uWLA+kSzU/A74D0zVAQ6njwBaVEWlKy5r68tjGie5qNjsw08WXW9HSs85UVFbSkpoNd0ACT/SSUEkY6xm75pumUD41Q7vj8Dwi6tc+me3ycel1yQbmL45GeOpWdeWJ8AEvuZDrBfc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=AiVNVXlx; arc=fail smtp.client-ip=52.101.66.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7VFKPGTwe78Q8vumslzPGpn/wF0jnjemszVxl2wZ/z9TjcqGgRirvu3El9hJ/+/u+JeG0XusMN9h9P925kJ/j6oC/pMB/9kYkJYv4NWzE4zk4nHFCQ+bN3g4T2XCyGV+BEz7kzalYEDe8bMKnJB3sC9eiIPPOrBRlBxOlI9PvFy96j3mj9cgBcRbLQk61NuGiVpMU281YoVbmF/B1IKooNUz8ul/SOmnnnTKuYx5yhIdx7G05PGCUwromCbWu3tVKAWPSWDOwGLHGdyiyasS4oJJ6yRMN5eM1A3GOOAQ0TLZXHOQPFyHB1gVstwUmKy27B4KHExfQhg1utvItrkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT6xl5ZKgjE1sjMlkMC0a1NKQ02olkrCbvJO9pyHj1U=;
 b=ZCIgF28hE+yh0GnBC4wU53I9IOyYwpEdfI5MqieW9aucSTU6JWI7N4DA3ftS2nqlwB9FrPQeMPFfqYxjLSf/rVGh/NR1yYJcfc+iG71qj8GmubdeCdlqDq2BpME1XTVsAclC5txE1QXSwpOUSSyLMYBB+YtIO5tGsSS98lK2bPIq9YhNS6QBMjm08LYbRw8CiCkelhzLDYiodvh3dgZPAibvf/n71Gfx8Q2JcGp4mQjJfqOSp+2TMTOX+gkcii3+uPwJWQrhYrs6DlPT6xBhNNY4Jmf4pMi5tsmQ3TM+WZFNcfRcs3ba772oOIOm+C87TzK0ZKpVIrjLQui9KE55UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jT6xl5ZKgjE1sjMlkMC0a1NKQ02olkrCbvJO9pyHj1U=;
 b=AiVNVXlx1+8QTpFY+A/iuKGF1GK8kIUcN1F1vyJmGkIPNYuuxDq2PX19fVLWQo3OQFxtnoSu7Yo7DjOyqBYSG4RQ4JUFjvTpiWd4FIkPul64mZgY66CDH6HTq6ugJ3bFHnp8esNpBA0mJo0UhWCfhQDd6vu7X4a63S6zH4plCh6JBE0iXlgiwr3VMHODELzVO6RBzXP1I1d3H3iCv99pRVMCOso6ZjAzNbRRbI5EVvqmZ5gIOrSepcf5HTPFBFy7ZdZ88bcm4NsnakdQxiSO3Q4wobe0yyYe8ErfjP5ZyZvInMJUc77pxW0LvoqXNb+dsd7qQPoswCVxtTefpU7OZw==
Received: from CWLP123CA0073.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5b::13)
 by PRAP195MB1530.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:295::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:39:27 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:401:5b:cafe::b) by CWLP123CA0073.outlook.office365.com
 (2603:10a6:401:5b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:39:26 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 16:39:26 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <aradhya.bhatia@linux.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH 1/3] arm64: dts: ti: k3-am62: Add support for AM625 OLDI IO Control
Date: Wed, 24 Sep 2025 16:39:14 +0200
Message-ID: <20250924143916.2023919-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5E:EE_|PRAP195MB1530:EE_
X-MS-Office365-Filtering-Correlation-Id: 14118594-290b-40de-1bb5-08ddfb782969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y7IAO44You5P93/ACw7W8iefpDAfwyOi1wy2ZchO78JQeTaq0V/r+9+miCJ/?=
 =?us-ascii?Q?nHubzmsaIn84yG3aTgdN7XYZrGptxKLjaXutKzyy+Mzkt0g75ZY1ESRzlypk?=
 =?us-ascii?Q?h9qcT6cU0tcwRAwjtt6deLtQb53Gfmgy4FcfTnnId2p/i8ljv6YlEd+Jma3w?=
 =?us-ascii?Q?dgMWUb+SC590hHgNCf0sJTb6a5PCnQWMQW++yvZSxjfg4DB8GFNpfPbiBibE?=
 =?us-ascii?Q?Q11eumRtsgPZk1V1qV8eb7lyjpamqxF0O2sDxyp+gHP9G43v1F2Cvk4UO8hR?=
 =?us-ascii?Q?nmOooiTZbDgDR0X8NOBFofHk+JdeYov2EsPXocpelwApxeh9QnoMpYprMFC8?=
 =?us-ascii?Q?koKlufEE2TN0Ekf04k+wg0C6ThbknJskQLGQki7uPhTJjDe7HxRISPfkPZnB?=
 =?us-ascii?Q?4VCwy1MV1jIy+zPXfRvTOev42F/c1ogT+uh99Sz2SsbxuwYQRb8A0tUxDipL?=
 =?us-ascii?Q?fiRzFdl2nnnFCTZTPjDs24hYe+Dpx54SnVQBs9BozLyeOc0WpFFAcqq2et5z?=
 =?us-ascii?Q?APbTlmhnHuuami7OAkUgWdgokU/IHjZpHgsMK9kxEPTG1n/NuoZkODHLX1xm?=
 =?us-ascii?Q?GdIxeBImqIdq6U8cHq/k3dKgwbNnUnMsCxZy+hhHQ/iooGdWBDPPLiyox5fP?=
 =?us-ascii?Q?LuaYvVsB2Qy3LuUSq290X/7zblWQ0GNlWjBqQb872lDDZp+uviDXMJ3RLodH?=
 =?us-ascii?Q?rjM1hCX1aZw+8uPpyzTpDcxLgh6AkAKXmGCRcKsJf4xAaDwqCvBBWGFK4QTY?=
 =?us-ascii?Q?HZmnKk9f2vmNlaI9LLnWrQ71aO9AhNMxuKu+oFuknbdKSsFAbVagGAv7T6Lr?=
 =?us-ascii?Q?tMvVUbMQsow62g9xX7+0v2gjBKjSal7Qcofd3go+6Y4SHdrkFPAhIuIOpWGL?=
 =?us-ascii?Q?tGYs0tyQcNheq1bD5+H2RuJOfOgSRaZ2DJSbcDzI22W3z+MNpcq8al+3oo7I?=
 =?us-ascii?Q?rDCvOyCI/AG1fcdU5xALzkUaPjzNz13VQd/uCSbU5O207CPw76RiBA0/ftSj?=
 =?us-ascii?Q?BsxQPteDMZ0qT/5TNS/+rGmuJP9t9LXAOlNOWIuixCw4r2yrQA7dbauB2MxP?=
 =?us-ascii?Q?XQFhWIsiAHR4Xg3z1ioLPDjxHFkPjIKjSfzLnIxgBdPLIRO5QgJyr+Wib4vS?=
 =?us-ascii?Q?9/neI+vGNNDprlU/ooFNC6lzhy1AgklLmyn2Ii5iT7jUVIDI9YyrDnuppbT6?=
 =?us-ascii?Q?d7oeANfnvq/lEeKR8ziuEI60JiTF0pUAO6PgrD9qkfDvajy7ESbfaR+bWXhm?=
 =?us-ascii?Q?UNk1PSlIa3v6iqc438Y8FKF9ZYioirPA9gB9JhvNfKxp9HP7tjET6EKOjelL?=
 =?us-ascii?Q?ILpAoLIsHe1aeT6AHI+arWx9TA7De8M8HBEp+FbYdxIe4oOT03G+aUG/2Vfz?=
 =?us-ascii?Q?gX0xE1Hk9ULBhWjz9e5GWDKluPozza+BdeSX3h606m4pdNSDZ+Eue7JxLBbt?=
 =?us-ascii?Q?+xQ1kayf+1sNGwJczWawdnaFncwLxLkrrBMlOqzVBPjA3pZS/g6Vxehu3STW?=
 =?us-ascii?Q?f/3UIlGh5d00U6sQiGsiJ/pqgg/FZVK18M/AlXp3ETIXcpHY5ppt+f+hmA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:39:26.5477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14118594-290b-40de-1bb5-08ddfb782969
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP195MB1530

From: Aradhya Bhatia <a-bhatia1@ti.com>

Add TI DSS OLDI-IO control registers for AM625 DSS. This is a region of
12 32bit registers found in the TI AM625 CTRL_MMR0 register space[0].
They are used to control the characteristics of the OLDI DATA/CLK IO as
needed by the DSS display controller node.

[0]: https://www.ti.com/lit/pdf/spruiv7

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 120ba8f9dd0e..ffa485545a5f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -76,6 +76,11 @@ audio_refclk1: clock-controller@82e4 {
 			assigned-clock-parents = <&k3_clks 157 18>;
 			#clock-cells = <0>;
 		};
+
+		dss_oldi_io_ctrl: oldi-io-controller@8600 {
+			compatible = "ti,am625-dss-oldi-io-ctrl", "syscon";
+			reg = <0x8600 0x200>;
+		};
 	};
 
 	dmss: bus@48000000 {
-- 
2.48.1


