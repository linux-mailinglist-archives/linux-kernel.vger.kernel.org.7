Return-Path: <linux-kernel+bounces-748292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B31B13F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D701729E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB4211A35;
	Mon, 28 Jul 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="i2qCGPva"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D3D2116F4;
	Mon, 28 Jul 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717531; cv=fail; b=WMyyp4QmySr0xywcGoj+A5ZBge+5qcMwEvX1gUobfbslFiymY4sW+x1ufMlxaijPwivsNtEXGgUBF0Vrv7smBpupz+Skx1HANzxsB8Cc78/nbN2yfBK30XBsQiwHiJEahF9DHbZ+AlYkSc5/Oinb9oPRjhLh7JnHwCNSk7wHWmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717531; c=relaxed/simple;
	bh=FhHaFvKj7do9p4HZeWV1N46aTdKO22bnD+I7OUEXrdI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZUskxeZEuvYFEQGZKa/vvP4HFjiW43A5FatYhJqGzg7xZrU0LTSSpCfNBw45XuvBG4ThbxR59YUVBnA2Qma4DtffFqp0sw9ux9X4FJ9X+IciDCDKUaF0esuZAfyOyj58AD1dkVuV+E0Lqhl8gLPS2pqcQQlqJHkAdSwpYoeUrOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=i2qCGPva; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNpKDGbkdDe/ELFHqldOB4InmHHFvj6uFIzVS7jwZw1IQ2JNO6pBY97qMDpUA8dokQ3b9ShvMXE54HauEbPOxECXbqCEGHRlc4qi5gcN/xasYF0pZJAWp0NpwsM1lf6HWkhX6BnVzuQz50e8UnjUAlPopDFK3twqzOErUwREt7ZkenEb9cIcy9BBZAuPGfFpLpe02qpwvkKS3/BkZrTMbgCbF7mqyadZKbo9WxKZzvLjCMHnAe9SbannXBSlvVM/7SBukk1mMz0j3CV6ojoVoIwp85jmGRTn97kbaB4HR3+Kqxr4V8dnKei/HJsIJu3Dk76KiPw0xuCYG1ZP6uxCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmEGYnyQiuyMEkL3jTkm300Igq5wwvYmEieaeK6HJqU=;
 b=CcIbkH61JTh4sup9no91BmSLwAO06o3i/TmeS1MpRNKX4IVCsIFjDCmfDK4xZoqNlx1icio8fxsNlR44to8f+qzyCHSxzqwW+IF+8mler61hQQi82wKTKLltXfZVo0Wj7ioi1Q2SXf/J+saLOvR57sPQ6cnrd9tddTnNcm1gUl9heJcRHhSP2G/+E3gaPawNdnI5z9a4hqosyDRN0udAxHwgKyVQGhz3DVPzohgM6pi8qn04PZDM4OyW/6S2egWFMfSpKgVG+xFJb1PQytNyeSj4mLqBrE/4jXE/LNNluXLFwenJs5p628E7JNxsMzTxEFXkL7jSdVagY3dJ5lwa3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmEGYnyQiuyMEkL3jTkm300Igq5wwvYmEieaeK6HJqU=;
 b=i2qCGPva9jIqO7y2ZfkZ7T7sAflFVU9z+oJQhsGPw6CmNGRdCm7lNJGO7E7SUzz/NEQqlSbKd/XqMsPEiyHWIQEQhEIn2pyTZTD8jGVrBmF0bCLT+Df0yuRXE1w24Xh0CZc25fe7xR3heBtgWpymEBd39II42t1jz3wNYXE1PpI0XyNdqUnvsnbf3nqQq11Xis2eJrbqqrlHbQmwZUlpWX3gjb0P9y+qwk9lXfhh31Y6LV400pwSNy2hLANRjmHeVYMrOhrdb4XZdJEfbeFsNLhMfTH2O4NlbmEZKp67emgFnYWkpTJPH9mj4TxMt+lZ0zClavfSSbz+tUzdZqSL/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA3PR03MB7489.namprd03.prod.outlook.com (2603:10b6:806:39a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 15:45:24 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 15:45:22 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH] arm64: dts: agilex: add clocks property to clkmgr node
Date: Mon, 28 Jul 2025 08:45:18 -0700
Message-ID: <20250728154518.299282-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:40::41) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SA3PR03MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3f8324-893c-4c5d-6cfa-08ddcdedc32c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pR4p9jP65vxgYP4W2oftmq36LznHr12umBrsrZBNHmKj2nJ/YmYLKywKfHLq?=
 =?us-ascii?Q?Em8VMujuSH4ZWWeEY5qc3uAKsxojoTWfrmYBlEtRlAftt1sViI+eDfOFLf64?=
 =?us-ascii?Q?SYiTJht26LWwezfkbMiXmzyabqvrbg7QsrGj2gOqjMufY3WcmH5sDP81UKe7?=
 =?us-ascii?Q?RQjACiCvBEzJz/iBkkUsIQI+E7C5Q3lYcli21flF6s5/I5bDtt3Vo3GBrtuV?=
 =?us-ascii?Q?uKHfAbNJcvD8maThztCof8vyvuEKstmD9TQFxNU3nlEVelwi+f1+ksWK1iyL?=
 =?us-ascii?Q?c8BGZFItMXw1PpgSCWk3EShf3v3I1MdjlDSZ/OqcTxSe/ngSJySGu28TvIpv?=
 =?us-ascii?Q?a9ezd4aUgWvLk3JngWthLdxSs8kS/aY19ufRohEuCsxfPCZKgCiZeZ6vVA7t?=
 =?us-ascii?Q?QVkMt1b3JYsI4fm0KYjhTCBOnHWJP2T8bzdN476zbJW7hYEAoHK0qBE8ot1c?=
 =?us-ascii?Q?ZX/DYJMriFdtiEsE8kwbBnidV4bc0D0Q20IFSjEuCpGYDWyULZONkWqw8Miu?=
 =?us-ascii?Q?61hKc+0SvX318AmCvt74bTFuyTb8HBEqbQ+YArADeKd8vzIUXEmhYf5T8TIt?=
 =?us-ascii?Q?Tukm9EfqVcV2SUtLEnLOWRDM6BvyKWegrTDxAdXWQzOv5ErQAakEtAh9L136?=
 =?us-ascii?Q?+6D028nX17wpirdhV0QrvNDHPY9JW1y1T5gAuEzurr+9gX4tVPlryA4Ew/M0?=
 =?us-ascii?Q?wo9lQ3+KpXLWZdVANwzg/s4TZ0tr1snHav1zPw4clU49FzM5FU2sCMNwCKro?=
 =?us-ascii?Q?AGEN6FwCp8UQvSMYy/MmYwWW4ustbEUzWF941oA+FnY+lKP94HaW/FruStO6?=
 =?us-ascii?Q?OCRZLogmYRQDpo7MgW04gIQF4PBt4+QAJS8olBCHvXvzQXw+bJsK4BfO1Ib5?=
 =?us-ascii?Q?IXi7oIfqDVtOUcfiMTDJ9GgCKxPRG2eGv6taQoLASKdAo0OXmvsMGHMU2VWB?=
 =?us-ascii?Q?Q2BYD9QbKLp8X1jkEe8gel6qZ46DD4nj/I3jCzFayDVuMkCS8dioP4/Q0Xbo?=
 =?us-ascii?Q?sEUF8XK3rqOaMx2xIrnfJRxgFreq2yeAxlpw4AJdJV0VSKsvG4mo33GwXEZw?=
 =?us-ascii?Q?F4fdd7bUdvpClB9fUnQUAMfVWlxEng0TR9oMc9J3vGYOG/Ser7Z9o1YNr/gh?=
 =?us-ascii?Q?Mu+tU7kOj+IpvBkKXSJHLU4IbtUKAFl2LPJNIbmJetRbdzFso9w1Fh1SkYJW?=
 =?us-ascii?Q?2JnGIEC8H9l6vcCyYCYf9sWpoBCqhapOumcyHIuqcigZN/Pc4zKDJ+bf/FfK?=
 =?us-ascii?Q?AhsR+vLP/t8pdlDYH+NVY6Hnm+mPK2mKVCjYTuELjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?apv0BUw9/39te2IVBTjmqqQ28tWP1iEdzr1zft100Xj10QsHnRevP573TTxw?=
 =?us-ascii?Q?enyEYYm3/3NmNUvwds7+9TZyjmVDhHAeBchJ81ot995Ec3ErnBh5/jH6+cPi?=
 =?us-ascii?Q?7sW6ZSgakuZkHO1TO8hubhxm2T2zcRTa4zXsLbwVUV+BgI+K50A881h9p+qT?=
 =?us-ascii?Q?BWXOv2u3x2W6ZtkW2SX9laohaRXjAwQqbFPyBkRbXiKytInCGsH+s2i4FP7G?=
 =?us-ascii?Q?6WRaH8TvSpp/uq+TsW8tOTy5hfQldym1pWSf6fIkjoNhoyc05DhXL1750iyd?=
 =?us-ascii?Q?Mq+eN1/IXKqOKM6e+Gphpw7XW5lMmHSW5VA+16r3AsoWaWD2Tt5pi+u0kgMU?=
 =?us-ascii?Q?VOBr7y8MsdKSO4nOWJm7VfwK4NKj6Q6UBE2u8PHv4i0Xdr9RHoUWRw5NbUUd?=
 =?us-ascii?Q?P+32/E1DE0Od3pfrIL764K5VkQC5SepKyHpY4JCRurg8y8mW6y4cUXLQOd7c?=
 =?us-ascii?Q?Quxd41nQERjUn7xzSY8KWOo0jxDSDG2A7Nb/XEdHtIgWd/hbFgxpKoq+fTez?=
 =?us-ascii?Q?19qv8XpygVHmfeANmZlBonJbjg1QAmLPpuW0LpeuTaH7UxUGEowdUNgmKDGI?=
 =?us-ascii?Q?W+n4OLxo6yVpaQfb//1n3tlXrwDa/X65OwRZZYr3kI/rrBTSdK/dEl/H1mZA?=
 =?us-ascii?Q?YZdIsOoV9ijNIHpuTZNzSE50QkuuTCpdMhF0SYclNCdfM6R7ZICrBKhPuTYj?=
 =?us-ascii?Q?6Ede9TAm+ds+aoVmxut4p1V3UmgrRK5zmXrLAsxgtENlfEskluyeSYwNdIjT?=
 =?us-ascii?Q?jCatHKOXB+1cLZFQua/zJ1Yar6OtjhAvc8MLR5ybmJ3g8+F4sVCqqaxb2tUw?=
 =?us-ascii?Q?NnKAnGZje75mVnn6N8y3zFZJQKZcc16EduIoKofRe+J1UL/40u+YWMbSHxx3?=
 =?us-ascii?Q?y1TR6/sxyooYVF4OyCgEMZt15EQjexHT2lnKkOMjWvmHGt7AJBTBMs3AAgVj?=
 =?us-ascii?Q?8fMtsbQOdVWGlZ27OZkWZcTalycS/7D4g2LzxSpSW+rPtLKisdIc9GsOfqvK?=
 =?us-ascii?Q?wISBW6dbHd+WxllrUrx4Z16JbILIFFTl+WsBMzeDGIGbiooWJEESjQBZm6D3?=
 =?us-ascii?Q?WnVzyV1uxJz88K2frMsSfYuP2KQxZqb7F9sXm9QnN/SdZjO9o/PuNzcaL31i?=
 =?us-ascii?Q?vVwx+/dLJW9GZ+g7TA+z0tz2+JJSCCBYDpmyAGePr5Ke8Y5X3rOsWgknCG1Y?=
 =?us-ascii?Q?Orl9Z4ZAPFqPq2H+FR3YbzCGVK2swe0eVoL9gEg3g2NItxUCpyhWp6YbsRnz?=
 =?us-ascii?Q?cS9EQgGRANIlITjJ+T6R+bQ1y+3T2FzbF9n538XI0JPVdSSMEduD2BnpSo1V?=
 =?us-ascii?Q?DWIqiRcfxWcC8IKEh10VsUwLFaAUOArZOp1W+SocFxYF2cFJtVW965ET3qMF?=
 =?us-ascii?Q?aNDKPE2lmjYEyCuFNZjvUEzjbA+cc1HMxKWFJR5PoUDs6sUFE0rXEP3HSjs0?=
 =?us-ascii?Q?5ZUSqNRH3o/iv4HrH3v2PXCsY9teULF+bKJGp2itQre1NnrIw0EUQWRrlIHI?=
 =?us-ascii?Q?Zz6cHfDaJyHxSYvQV2kwHyEdCigD/ljd8qHtCW6ocZzPW+/BtRJBEEcevrYU?=
 =?us-ascii?Q?hC17rPB3SHgL+QM2gVT1ELxUCK1+UxVgQUol6XbwhcBpG08aBKboyoDX+E5u?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3f8324-893c-4c5d-6cfa-08ddcdedc32c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 15:45:22.4253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpiBnZ6Yw3BiygLEGdJzsYhfcLqDLfn9055YIlQce6gyRv5nBl8Wn0Bfd4stFGUYaoH6JLa9hz9+93YrikishoUm7yRsTrmflBWtAYQo498=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7489

Add a clocks property to the clkmgr device tree node specifying osc1
as the input clock.

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts      | 4 ++++
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts      | 4 ++++
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
index d22de06e9839..e913f46f25cd 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
@@ -45,6 +45,10 @@ dma-controller@0 {
 	};
 };
 
+&clkmgr {
+	clocks = <&osc1>;
+};
+
 &osc1 {
 	clock-frequency = <25000000>;
 };
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index b31cfa6b802d..6b6a8a37624d 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -44,6 +44,10 @@ memory@80000000 {
 	};
 };
 
+&clkmgr {
+	clocks = <&osc1>;
+};
+
 &gpio1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
index 0f9020bd0c52..1bce69e90f04 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
@@ -78,6 +78,10 @@ phy0: ethernet-phy@0 {
 	};
 };
 
+&clkmgr {
+	clocks = <&osc1>;
+};
+
 &nand {
 	status = "okay";
 
-- 
2.35.3


