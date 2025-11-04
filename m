Return-Path: <linux-kernel+bounces-884412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 776B9C3014B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F058A34DF0A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B001315D36;
	Tue,  4 Nov 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="DXa7B1yj"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267C315761;
	Tue,  4 Nov 2025 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246421; cv=fail; b=bCC3v6e2gyk5CGLDL8pgJLT9NNDwP12cyMMG8tU7TqfVB0ih4wBpBNBiiEoWbY4yXmNHnZTRWG1i4EqwerzCgcZLHgMnoNQY0WFiAHe9TnZf5+I/m34Bb1i+fotg9RAcdjwqabiNrJxtT//M0trG/iFwktfXZrX+DqYl7nIzTXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246421; c=relaxed/simple;
	bh=6+WWLsHYqRPImPnx4GZ3iyryTdYtzs6U0KXasdJ6Iko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SMRwDeQBMuLlpb3OssJfwgFDPosrmHNOIWzI5f5TjGbXhARq+QuR9PpGofHgb1oK76kn328ASSJQttmyywxU3tBYZWR8AdktIPSDIDLQANa+CWVqEo58vRhKzqZuz5BEGdgebYZLVbwX2CAfE7tSaXZu02eJenT3DiZZUMfXDyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=DXa7B1yj; arc=fail smtp.client-ip=52.101.193.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjuF7gXrIR8lLeqd2D7/0TqOJcezbldQnrSNtePk3DyzL8Ga8qHbqc5U9C4uVeBxdLFqOsl0MwXmXTlMjEeFGkhDG9832QvWfZZSuSLsiVZxoJbHFdUa+5ydiGEpcWwuEpnInc8kH0r5Zvu8ekOdeuuKdSSzxtLPPM3cGTHQwT3MvqYYOAlqOaG5PlT5zouqjhUwtdY9RHDxj4guHDaSUPUiH8ACQbFive40pBXJvHWX7jEpe2jJ37J8zXS0tByzgeAUIf4ibFFBbf5Q+ndU6upHyDuiQ8M12mgyga7a16t1a9nmf83vzaqfRbqEMAGm001IiUmArYfbaVMU6Kj+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwbyjKE5fcVt6l5f9zLnaOV6ff8nulqlhg5sJsPZMBI=;
 b=embM50WmxrlpOZtXTRoofsT3WFdv7Np2gUwzXqJg24f+iqoldz4fMIdu31VSYY5R7d421JlYtx5nmzwx94gWHFJYYTfCyxxXdmcU+5gt8s0FBnJkvI3LjVh86wg/79CUGl/9TZHwvvJTt2A9MzUKf6iRStpPKDL5KuQVPv2nsHMFdxrzwrzaVfRk0fcH8LBUcKJZ4j1fxeDGwJBGypSP4iKibWD44wk3CHFxXUc5I6UBrnwAymLhTtAZ0nLl7go8mP6iFJotnbRe7ehnHFSIHmwMldqLA+bDGeABYGI2HlhCOur1db4oI6xtLb1wHZNo+YxdMdNTtTrXkWh7vXyTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwbyjKE5fcVt6l5f9zLnaOV6ff8nulqlhg5sJsPZMBI=;
 b=DXa7B1yjpNe7wr8qpUKsvqCpQ0Ah/xhEsl3ZLlVZSukY1yfOY/3aVd8t7+VJHv2i8CbivquKmu6P5sJdqvo8Xrfm/r5+ltPQ9LiYX/K4RGe6jO5fGwe2CDm6ab42+NWVrIBz1p6u6IcA/HD90AiIMecmy5q7KIOVLN9K9g+JMTP3oDSsxvkZOuqD1vNSEdR1J5ZWDyWkqpDa1EVZrQdbcIbOzPyhWLEC0ClmZrR85mPxlLcetuWaeehnvjpl1+7ZWGUOjnPOkxFuXlF8GB2E8Lx33tJb4BHLfmBMx2bsSBDHYk3lySkhZ/tpHerLuahcgrEnraBgC1p0jdYk9654jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DM6PR03MB5164.namprd03.prod.outlook.com (2603:10b6:5:247::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Tue, 4 Nov 2025 08:53:38 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 08:53:38 +0000
From: adrianhoyin.ng@altera.com
To: alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	wsa+renesas@sang-engineering.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH 2/4] arm64: dts: intel: agilex5: Add snps,dev-nack-retry-cnt property for I3C controllers
Date: Tue,  4 Nov 2025 16:51:09 +0800
Message-ID: <cd462b04f5ec5d425ff900823e596f193b373fc4.1762245890.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1762245890.git.adrianhoyin.ng@altera.com>
References: <cover.1762245890.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR03CA0028.apcprd03.prod.outlook.com
 (2603:1096:d10:24::8) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|DM6PR03MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ce29e6-9b02-46d9-32e9-08de1b7fa4f3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+fqjKrYls2rkxuciUNdJcC6oHeKTglvQuDNHkjEDzBzVZQNy1J9r7ox+cqq8?=
 =?us-ascii?Q?DVvGToPtkKEw7XnC4VCi6K5dXXUPkRYlzXyoVPo6+nmw/wXsz61ffUSWQPE0?=
 =?us-ascii?Q?1rci0/iG9ocGZ7OrJ3qNV9La2DxJWn+vSBU3KYfnlbBX3B7+XNBbvgddRXS+?=
 =?us-ascii?Q?wKAXv0y0DduUlayi6Qs3zbtp/VYbw2O33u+2Eu4ejFyc6TbwA9GaGRgRfddH?=
 =?us-ascii?Q?oXaz4VuRQjTajVSTOIkZqpAxTITDQfqPmyQQIm5gFduzug8F9NBScCb3q3Zs?=
 =?us-ascii?Q?Q0n3tcAvsnxVjWgMH8qawQPKF8CjyVCqFVd1OwxMNJ5qzoeIMzg8JacMtTeD?=
 =?us-ascii?Q?2YpCcF8I8oUy13feX7AXW4W+vR1gaarVtjbPEckxRob4nJXY/jGN93uuDv+o?=
 =?us-ascii?Q?+leIdT4fgsfYZz0UWh5WMoXYrNKnudycaSVPptcEAkQGmq7LEZfigy6RBMql?=
 =?us-ascii?Q?sp5M8iHbUfQob/Lyx8h1G+HWyWWqqg5LqcQkeeY2bEmKBVi7EMzOwj4gMivT?=
 =?us-ascii?Q?+ccdeLejWGAWew3VoSRQrocMTw/LpFL9BQKb6p46wMp/s1RXJ8wK7rXJDii9?=
 =?us-ascii?Q?QzOATLU20o9K2mj2+1fd7ElAjJk8osXpUME/o2kq9Po+b3pBpG12XhfI18y2?=
 =?us-ascii?Q?jxYkuwaX7WuN3g30O9LRvq1Zz1h/pTaqZ0z3ACVZFlZA4uCnvVnGBR1Iv1K7?=
 =?us-ascii?Q?Q12cpoAfpotB+cp6vzRbRXfIP8zr0LSrYUIOp/iHn+GBcGAEh62MYTV0nmZh?=
 =?us-ascii?Q?+11lS3EiE0RoHKMjxhRiH/jajRNaO5ROKWoxOszMxKjxzKXXUdiWTa60f1gl?=
 =?us-ascii?Q?oaP5XL80MxASsjFLFIy4xTRVhaosTfwE0l0GOQKDmbG8fWV3/YM9HlpiatpD?=
 =?us-ascii?Q?ba0R3D9OW9m6s0pf6o2quVJEkAvW0ZpJ4OOKrTtzYkrmjCu0N53RW+ysp9xw?=
 =?us-ascii?Q?681V//IQgGCXFHzjjt45G5HZ3Ev7kA/ftbnJFyXMlPYTShMvS2/tGTPYP8Fr?=
 =?us-ascii?Q?Q9yFvwMhgKA914NtMJ2nQsGel9f76C83KZDf6g54WVUECiYa/DvpeStaOo++?=
 =?us-ascii?Q?jsL2ZZ2x99WHEFanIEOy0/WcFq6RPYKCgtY5uNSTBq1S8ToiR5LZ5ArF266/?=
 =?us-ascii?Q?Z8hoPMe2mccrd4x9Q3/ckYBh4mvaN+sVU4xITrqfB4AxVfXbd3LJvpW9GoVG?=
 =?us-ascii?Q?A12GH9Zw8bHafoZmQjW05yGV1aAOiRjoHYius9WUkRKICOgMRvgqif3dp1tG?=
 =?us-ascii?Q?pGn1R8fL992PlAiJWRQ9qxXWtUFIZ8WHmwExAE734v2esz6+8m0C1RFaYnMS?=
 =?us-ascii?Q?gf/FViaM2QgXIthTVxtKOnCzza6TM9q/XJ4cM3LsqlAC/YE//3AY2MZeKmaG?=
 =?us-ascii?Q?WOpnLJXmOTrw40q0b67F6HffcA12v/aWPxjiNzRBDJhdTygiwc1cDrcM9rsQ?=
 =?us-ascii?Q?y5hYj6dI1nGypniGn0ShJvsf2BUqiDbzlEHvh40n+kYYpfkWT6arPtFLsciF?=
 =?us-ascii?Q?wmZWyec6tSq3Hjw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2baUqyEgoXf8EFs9mOa1NoRJRiTn8ah3xtnwUtOyuh0cTZ6UYJWxYY/hgPy2?=
 =?us-ascii?Q?CY+QO4ReFxXH6IdPujA6pcXop+tbr/jewlLi1BTGE9kRKVZswL8Qx3NNgqGT?=
 =?us-ascii?Q?8QNDt1/UW2L0scAMMvVS222OnhG2gOw6SXlusiIk97klJSpuaQwXyV8QYEYO?=
 =?us-ascii?Q?jMvVYAkN05jgJyQ5n9qhC7R5rEPC7CtjNGGzThk7lbAac5rSvvvQa8/S4NcX?=
 =?us-ascii?Q?liWmhDY8c8WTmFBHN+BoDAz/3wyAG+c3v1c7IjvXMo8DbWdq3+rO4qapYyQn?=
 =?us-ascii?Q?D6QguwecV+Doo2MlfuDQSaMAOQzzw+ZM3K93t5ekK2QpIvXCkz2kzXgiGTRG?=
 =?us-ascii?Q?4HZyNkH6Y3e9ThlwVF0W3x1nOfRzTygRSAne3PZM49uLGVhqaGdmi4zKzpAr?=
 =?us-ascii?Q?c6Zu6xAwVmNWvApVfpx0vqWiZE1y+WE8qLTIr7ie+0EAJsEdzDoaj8S+jej1?=
 =?us-ascii?Q?e3drkU4OQ4+YEcqcF43dPQqpeyEJ17X1fJueelA7fsR9Bq/8iOonYNyMo7Z3?=
 =?us-ascii?Q?Oy/qNLfDav1OyiYAHhFs4yJ3quTWjwiFi86w+6FJebqfA5MRjyRRSIV6kuL3?=
 =?us-ascii?Q?Ty+q+31D+yBdZS3qUdXBHG0B+9OEqz33C09aksOZtaK4c+VJY2jYeJW4pFLZ?=
 =?us-ascii?Q?lj86ExGm0eYtnNQo8ABjyA8om3oNu4/XXE7Xr7kc+QYXVFSmseTyK/uYp1NG?=
 =?us-ascii?Q?bzQmKqj+ITCxYQDfBfi5ChvEK3B64mvQ8m4egp1T+aWKs2MH19UOBjRm7bXf?=
 =?us-ascii?Q?qRaZgA+FyvIkW1pKp6a2js4CECR3Dtr4QVtNtCibriNZj6+XrjZN7TMGNvG0?=
 =?us-ascii?Q?yylGWC7U61MQRn6zr52B4Wfr+N/kKcJ8D0W+G6cYk0VHpuhfnvUsvLJYopWO?=
 =?us-ascii?Q?DRRBnfZrPRYagP0TkLUFHcZ4q67XMdqBjWgRTQZ6krIv8Oae0DiJ04lRTaSl?=
 =?us-ascii?Q?suLLdNhx1f7gb3dy4PFq7ICUXQVcmjv/Wa+mMOQu3HkR1z/Lb5EB7WfCXwPD?=
 =?us-ascii?Q?ap/MDdeospnIBs3f6waRcsjDpwZvj13Ad8gX1bIa73l7le7ocVZ8VnoOn9mw?=
 =?us-ascii?Q?AEw9jSEfGGuLYEa6YOZR2ZM+XskO6ueAkvyyulESSdQdVGPASL4rSQYkTkXN?=
 =?us-ascii?Q?H2QzWpPe+G+V37oa/9XX4r9fD9uj82enAWmtFIoS7OTb6Gjyh9mRSNcFP2O+?=
 =?us-ascii?Q?+KXgB1f95GbweOxEW0OSetDQicy/iHl1c4q+qF+2bdmWMhLNH1wdSws6OnQv?=
 =?us-ascii?Q?lo9KXbrynzBX/2myuaLdFJhVU8muDHC1fQn6Fi55sf52udqwWHYj2ROYpgP4?=
 =?us-ascii?Q?nMuCcmDM+N3WLPxL8odsE0G5kIvlMrd2PJo5A1Q/oqSIsFxTGGUAhDbcsUWp?=
 =?us-ascii?Q?2EHERT8sz/OE+9/weWIHB2kajrT/3de2bVwVRMWd8dxpF4O4H3mswqYKXh02?=
 =?us-ascii?Q?NQU4Sli/zDVoSdlDtAN5IOf1hTwC5CL5LJtTa4auvliJP3owZEiegEsoh/dr?=
 =?us-ascii?Q?1cSuQWH8f8ZkqF21SYTLIfZr6zYBQnrPMwX7XAVhKStbCJo93BRZqehWr4Kj?=
 =?us-ascii?Q?wjAuQEwnbMmwTdPhKDutCJUn20J6/H7izqmMUkKoXfrJU052CguLLdW80l3k?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ce29e6-9b02-46d9-32e9-08de1b7fa4f3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:53:37.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSqE4OK9PuMoUOil9WD2CY9Rvtlv4zx3V+ELWaKQ6IEPRmjA+b7fA5mtztxLm4xK2EEdCRpi1rmuVYrtJSoW48vN6T0ikK00elSpVrlUNrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5164

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add the 'snps,dev-nack-retry-cnt' property to the I3C controller nodes
on Agilex5. This configures the Device NACK Retry count for the Synopsys
DesignWare I3C master, allowing it to retry transactions once when a
slave responds with NACK.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 04e99cd7e74b..bb508d092fd6 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -209,6 +209,7 @@ i3c0: i3c@10da0000 {
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkmgr AGILEX5_L4_MP_CLK>;
+			snps,dev-nack-retry-cnt = <1>;
 			status = "disabled";
 		};
 
@@ -219,6 +220,7 @@ i3c1: i3c@10da1000 {
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkmgr AGILEX5_L4_MP_CLK>;
+			snps,dev-nack-retry-cnt = <1>;
 			status = "disabled";
 		};
 
-- 
2.49.GIT


