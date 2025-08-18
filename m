Return-Path: <linux-kernel+bounces-774080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A47B2AE62
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23685E4224
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0C1342CAD;
	Mon, 18 Aug 2025 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="LCKJduB5"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B9A25CC5E;
	Mon, 18 Aug 2025 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535186; cv=fail; b=OM821Fi2gZGDT759TlwXW1I6StaQFAh5WKdTkLfhMaNXJ2w2rj7vguGN4vn5SF5HSe+9dhxhJdQJL4zlh2F2FLEEeDsRqK8OBCIP4jCotAwxeNwirskdI7wB/0I1JBhPICyQz7FwNX5kx5gzcwbKpu/oYjQJL4Vq4UMy0r9dRYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535186; c=relaxed/simple;
	bh=TbrRFdlm8CpD/ziX2ZvYDQdJ4hVtpVMG23Lm8zwWwW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lATE1qJ39qc4p3VMKS7+fX86KD2ezHEZDuT46mBaXkvMzv7KmYg7DcNJVIXcCO2cFImXgAoqiX/eTz/XjfAFVUWUpfwAKFiyBOc9dx/8RRkTZpPegSCjp53RisUQVvJRtX1a7RH++2alrmA7Az5mlZ3B1O6w2M9JyncFM7vJ2kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=LCKJduB5; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBofDDaiCjYO1UBc63icenOLqUX/kTACV8gOdiEe9KzSU6BDJIbOWJi6ugoJzkyNKME149UC/ZdVcJKU3gEQFK/XsR8s+np7L2jqmRFyIN8GJQg0gY1HdSJoxOUZf9qg7q59pVwylxAhty/m7yobTRjQrWjhkhMnO2Dp4uMxZTRVaSkGnp/hH+YPVokvsoabmKZ9lB2lbU1gyuxPYMCawrfkLz1DFoeRJ+JjUADHT3uS4gL6aeKEk0sJDiceg4pzOTo4BIydxVgFt4I2u02HjQYviOnfICJatC0mj1wpG6aYpWKK8SarikdAr0QvVYE771CreP478Tydsr5jMAeqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP5j50NrlRd36fxntbtMIiyH1vdSpeul6ChXiT9g4Io=;
 b=I+2NhRs/ozZyoRo2FkFUxbTyYGSm6G6+yE5M7l1lgm4cBTeWPNkv5B86bw2DPa3LiUtpxp2uHsdCC6du3KsGMpr8xZgDoWyxJbSW8ByaX/8ejowSamvH8rMYwRL5OjQ8G2ZD/0QKwto0tO8kjYd1NT74j+cABfmIyYjjzE+owosZEfuKOCCg0aZMbwVjOd7DfQGkIGhno78wQqrFcz1ZbBYoJkjO1irJLNz+QAtJ3u0gpHo5I2zFbStAwi3blbgzc7LIF/ldGVPKS4aarDBes2zzEHq7fXHTiVBo01BDkKjfvIKciQXvVWpPNlTMK8NpgKg9nR+eJ2uFGMbA3L9Xew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP5j50NrlRd36fxntbtMIiyH1vdSpeul6ChXiT9g4Io=;
 b=LCKJduB5sAPGDqZAGaOXDFmzmn4FbptjkaRfWTjQE8WZS3Jk4fB3W5Vw9WHXn4/zcQeXdfzTSBU+hYNZXnKVI8b2jpRHN+wvIBL/scPBOrHwmXeFm5IYkqziUAs3PzafnedhB+Lz/owkElfhrCSZG0TDKnYRHdT2vXuT35c0nQZ+OHP3OeMYRoiFNPHvn4wAQ+jdTJPtyCcbcNH5QDKhr8lL3HqIgxClV3JY8JDwPJP8LfR+hov+aX66GhatSpnaonK6winFputKQObj+Sa9KFYA1BX86R3Idj2EKiG5TJVm4gzF8bXQV0u00o4UyCuHavE+WFYEYVa3l1AsZc4wvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DM4PR03MB6158.namprd03.prod.outlook.com (2603:10b6:5:399::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 16:39:40 +0000
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
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v3 2/2] arm64: dts: socfpga: agilex5: enable gmac2 on the Agilex5 dev kit
Date: Mon, 18 Aug 2025 09:39:33 -0700
Message-ID: <20250818163933.62086-3-matthew.gerlach@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3f442880-4b44-4495-03c8-08ddde75d387
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F0hYGad/VNQT4Sz71KjkoNi6kFF5d7ZyImhpFNVI4HtJ4cNNcjdzpounyfh9?=
 =?us-ascii?Q?Xt2lKazadz8/q7+4D1Y411upth7Of9UTxPvrlv6lrRpHetGbwfRvPHoP0k3s?=
 =?us-ascii?Q?mjZ/waJ1FfSMFC385Z8n1y53Zxyut81KE1fnKBhuYvSIVcqnkSRtTKUaJjkJ?=
 =?us-ascii?Q?514AbVmVnw5v90VZmz37kFbqZ/GejKfut9PwZpreIsaow8fZCfB9CZsZUdNS?=
 =?us-ascii?Q?RmtLM+UfpMu5qvIQzWfShC41GvIeo9BePCgxemvOtT7Ic0g1MT/aRtD1nbYO?=
 =?us-ascii?Q?vXmFD7XyligPWUSc7Sz5P/cREwZ5nPAYG9LsbMhPNUKkVd2BL3wm30FM2XTE?=
 =?us-ascii?Q?aKYMppCREpkQPMe9HobckLlRTozLEthUEOrFILTyul3UpphVdjgt+Y11Wx/m?=
 =?us-ascii?Q?KBLtJeoh80dGb+6zvU89FB1sFDZ2sS0ZJWXRf2dxuQWi0LYnJ46cDWS7SDjz?=
 =?us-ascii?Q?P1ERlom/fghQrLELzJkQxGycFt2fyN/2q7xrzZ6Z8uatkGTPt5W9TL4o3p0/?=
 =?us-ascii?Q?m8FOI8Wu6B2Nrds+GwR1Qjv6WKwJFqGd6b3HFXssm/fnoBYK8OeIqLZbKHX+?=
 =?us-ascii?Q?oITiarYYe6F0pzVpheJwViw6gbIM54Ioc4ZYxWwCvzY9KlIrQ3Ja2+p5MsYR?=
 =?us-ascii?Q?A2iXjU1UUGIEZiY/NMG4Lf83cUBpgaQoA2tw68YKALnIjCgT6IjUGgJakReL?=
 =?us-ascii?Q?AJkPq2Z8iQXMj8aRigE+a4+bzeFvwB62SQ1YESaESfjku43RL2KaowKTryQS?=
 =?us-ascii?Q?07kZ6OA6Oj4oJxn8t7UVneAN4cw6lNmSrE3dCPwaTOPDx6AtRm3CKSATO3Xd?=
 =?us-ascii?Q?ZqRE8TFnFWmHHpaH34+mhfy52K9b7KlzoRckXn52QVmUQgZDsSr0agaWgU5B?=
 =?us-ascii?Q?L0ebbzOx3W0IaNBWm/++YGOrJZ7nBHj+A0sBu8tX6m8KqAnWM+i4z4AweCwc?=
 =?us-ascii?Q?J0kMSjZvDzzotMBE7Gr4nTuOWlYcuYM8tcrs75OoZioPfQnoY871ngoOuRW7?=
 =?us-ascii?Q?XYvCiHsiChLYlh41FKrlBfi6vJZovwdAOSIb6xSbipvvJzNOyyxZqx2CXDcu?=
 =?us-ascii?Q?hh94G2wlxyJvsJ55XmhZAcVeM7CEMcROUJ4h1rPQ+Ngp7QJzgGW3o2x1QvwG?=
 =?us-ascii?Q?f9ZBHLe61EagmlcTRq9vRSj76yRdb3OOEoW4AKmm3xeZFWyw35C8YZJ3Udbl?=
 =?us-ascii?Q?3DoISN6c0PpPKyqNemtf3mkXraeVlKQsBrY2ShDBnX4RD9uAUXhh+mtTPRy9?=
 =?us-ascii?Q?xKHugZ0iWXNltXQJxH7VmCDoxU66TLGjMn1rH9ydwiqy9GpgXcGBmpAChGUu?=
 =?us-ascii?Q?QfIzMFAgxKbf4EXwLoCDXrYLuAhfnxEG3oUkDBy4faZGkLwKTytysdbEB3Uu?=
 =?us-ascii?Q?pfK/tHVw3cG/tvVJ5rL1QeKZ/Nod7cqRepAAmKSs5D8b3hhkI0Mr1LAM8i1b?=
 =?us-ascii?Q?RE4vEG6toFM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sf4YFuc7oIGbQlH7x6QLFCgOdWUClLZncy0zseBcKuG7u7WJy2i42dNS9wKN?=
 =?us-ascii?Q?fcbJf8acFtBgz1LtikZ0i6fEK79+bqtTYVfEoPj1AM3ELb+LReT+nZQ/Enf3?=
 =?us-ascii?Q?yfw7xWT+Rtd7W8Ow5KPz2tWQ5GyrmFJQTBdwJRtZljhbkbOuwhWtw58jvg68?=
 =?us-ascii?Q?6Mqj0+Ou1Jm034DqVjGx3rJVxZcMkmP4m7ZhbMNU7Gu4tcVAuXKIDpCUNhea?=
 =?us-ascii?Q?ubR2f5FAXizDvXJ/4i+i6NmKRCGcad/walu8oUpHUa2D4RTEzrMdpYWwe9Yg?=
 =?us-ascii?Q?2VB9dB0oE2h47QzaxPw02KO93uV/2zilsZi3hnBPGfS/gLCqYdtMLY5tYLnW?=
 =?us-ascii?Q?pcM7bT0To3x7ozkVwpkuOLQdieMqZfvAwwJBqeBFIttWZgdjiowzHZM4p1M0?=
 =?us-ascii?Q?/goo/BUIHZEI5Ys6SSL3Yibqs3aFZDFRhJ99CAhLOrBq1XP2xJ6VaYZDmkr+?=
 =?us-ascii?Q?5Hzx6w1d+4n/FQ9W23Rg+yJnBORWtCHKihfHoE0uNIEPGGZ3fDNvDroFWbCm?=
 =?us-ascii?Q?xL8LSc8zJB+O7IDFL88tRtcQcwSXj8Zwh0lqZDHwl4PNkC1njtRI/8ZaMeB/?=
 =?us-ascii?Q?5EfVd4UoFHuuRACBP4QMcWBarJgFsQEVGGht4DmIG/pd5CucF2ojMd+pjGCk?=
 =?us-ascii?Q?UB5Cko4TiXoUYVIbzBJEjM6FrL+kApzbd/D+fDia/iDOJ07QtnC7m8ixHxs6?=
 =?us-ascii?Q?aZk2GhbPTUtGWnQHJkdcBhqjzN3NLi/UcNL5ZPZ/ETC5uSnU8OBKqPmucNMd?=
 =?us-ascii?Q?6CFHo9UM7jcFxxwH8/YWDlCW6/FaRaLpMNFTDizuXgOD/fAivbzLOCp4T7pi?=
 =?us-ascii?Q?PZCgm4VdcdmOwcyEHYJmJdPMkCDLkS9CJjRZlv2TaPUpF0CBqZa7unxsIgKB?=
 =?us-ascii?Q?yCnd6NxtkpXaTCbMtSKRxH57A6pY/QmdqW8o4ULcP098oFSU0N9ojvdrfRFV?=
 =?us-ascii?Q?WOwf74RCNPnYQj0t6FlM76/2cmZ/OXsJfIOZozNQB6Vg6pLsuo9jTxCioUyV?=
 =?us-ascii?Q?SrNtrEN8tOmWg1MgQmuAc0RjSJF2uma6DMVDza9TnTgqV8+HWCPQjl4wGcBX?=
 =?us-ascii?Q?kZKhig11k1Nzo4+32qAPC7hNk41msV6NXevMEDw0+fUAPQgyNc3p0AMjju35?=
 =?us-ascii?Q?eMXO8+u/w1FvuyNFTkuXyciCwwtw8ndBPOWJJmob6e+W2YQN4rAc5whUBI6f?=
 =?us-ascii?Q?TrbydqBBqCp7i9ewdws6QkcSd6NcS+5zM8c3wMLMyZvhbyIToDOWyRXqrDen?=
 =?us-ascii?Q?e6eCmTRLcV+IzJEn42QFgEqnwhuxYk3eZmBJaGNLUPiNqt1BJjZQIkh09Rrv?=
 =?us-ascii?Q?0TWmWRBqAutCZFPgjw0u2eHKOdipPtm/2FYT1lkdDhxSp7yzMGFa9pdV6Bci?=
 =?us-ascii?Q?6lBfdGZyGU2x8hbjUSQ6eTgDQ4cS4VLIFGtpDiWxWm9bj4ihPYvnkXQnJeOQ?=
 =?us-ascii?Q?LHAVPp5rkIES5EueDH1T9Evk/Y5VJzU3S584uGpcuEC0nVpLsOtyRzPasut1?=
 =?us-ascii?Q?3JQAXEEZ48H1Kqzgi+8PixIEyy2pctXsYugFSA+jN8caIL4ncAdGFH45oowQ?=
 =?us-ascii?Q?RsEp+h/RKGl3e2vPwLabt0Sl+5eajExLuBXxOfcVRMj2Lo1Exc7w9UH5r1Sv?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f442880-4b44-4495-03c8-08ddde75d387
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:39:39.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDOW8TxNy57JBfEgESs+Lwj0KNRAEmjI3NqTq6Cz5/ug+P/jk9/h+9ptvwS+qi0Qr4MU2+VZUT+9YvtRmnZgBT+OCVVvIFDc5a7kL8MzrVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6158

Enable gmac2 on the Agilex5 SOCFGPA Development Kit. The MAC is connected
to a RGMII PHY on a daughter card. There are no RGMII clock delays
implemented the on PCB.

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
v3:
 - No change from v2.

v2:
 - change phy-mode to "rgmii-id"
 - add newline before inner device tree nodes
---
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
index d3b913b7902c..e9776e1cdc9a 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
@@ -10,6 +10,9 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
 	};
 
 	chosen {
@@ -37,6 +40,23 @@ &gpio0 {
 	status = "okay";
 };
 
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac2_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
 &gpio1 {
 	status = "okay";
 };
-- 
2.35.3


