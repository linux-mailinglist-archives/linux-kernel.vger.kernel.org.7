Return-Path: <linux-kernel+bounces-897626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07729C533E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEBC934F0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19431341653;
	Wed, 12 Nov 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="mVx0HUeI"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333A524E4A1;
	Wed, 12 Nov 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962528; cv=fail; b=RcZCFuLt8pL3bXic+/Al0r8XI3vuVE/g1W5e5xThAhsKxzb4qXjS/FmDHu8Stwd1mcT3vQfrTl8EpsVRhOfGyRH1IDIY0EiICtV1OJgJNo2FjGNFH77XDZFv3BwDAQnkFvyjYfFA50Or6M1rZkvEw/yLAS4lxupdENyOYxPtJIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962528; c=relaxed/simple;
	bh=2tWuwnHxd1c5yioQI00/0RfslOoRIWEbRN2HBUaIiDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WmRp9kM6WSstuwPPWSTzy6L1N6r5MX2SitXD3H0OPMCFz/qy3kPFao324f65kfLtW9voEKcRJnDyQgYjtfHqRhCuCu1i8sZrpZeNH/CjIUd599X0A5w0TyZI1yra/YQ9mkSwywoR4zN5mt4xK6J6da69Xv5RQLI2joe+GbfQsM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=mVx0HUeI; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACFjefq1614025;
	Wed, 12 Nov 2025 16:48:35 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acqa79peh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 16:48:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H89HvClNSZ6KQiyVR8xFJ8lsxLg9pMoPEbhgTChtmJKybM1IczE5LT0zJpvQnRXpd34OWNGtGxZ0/FE7ESS1LGFR9Gnr/h9X8S1oNz/Quk6Kh05mft3iEyX6MQrZ7fKFd3/Kqa3p0lAGwP8kTXCfBWp8vbSXxkrHjrmXnjJkGmxnU3si7yAeays/udDvHRguoWlfWUuSU+AB22zu8ytsuVFI/eqaFdVWALdilR/cbi0JAND9XTW0eLgkK3aIcTFkZLas/50mDa/qYGTrs9cA/BF2PBRCE6tyBPuEdVmCVt5VQtw3U4p6sKLIvfTQ+m6X5BJhfoH8rcuPRHMGTBpWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2qct/ro4VaDSnMHK6HAKn6hE2ULU+leUoILx1aNY2k=;
 b=ms1SrvtI6Lr0/8LHfOS7foMan/tvrnu4g2x8yyIPgIb2lve4UjSPWMw24P51ceqxQCkd4vjovqpgrd2ZzK03V2DM/ZLEnoteX2HGhNFv6IE5U10RO1VeScoJIXSFJAwHEBwsSrTHmr7wWOVmul2B1VVeiiYl33PzaWn3wGgSRC3vNabt0rm6Rskbi+T+g7yRMpCyuaZjjYXam/ezDo0cIF94ZzSl2jS1Hx0an0EMXJSb/ZkcsGYCLTo6GRXdqTdgIVzZvAdy1P2ah+NT0Qk6Fyzqjtj53tXdE/iG3ZwIQ2RWhCBhUKz5v5Ix8vXHp8Y9Dp/9tBMCaKizq/xpQBpgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2qct/ro4VaDSnMHK6HAKn6hE2ULU+leUoILx1aNY2k=;
 b=mVx0HUeIsU41rpffMaz10LoimQ0QCpIh1Mfe/PlgcE4eK3ofjL4WqU4fcn6Emy2ipHa38bNAk5Axg3uSsC9AEmvVc0aEuLVwLBV+WCbCu5hUjIi6vRBxz+vTem/mO1LkUjEi4/24xpiOD2gKrQaFw1F77VEk0iLx0RMqTWYo8vPRRsy/vkT7g+zUPqLwWOE1g2ASMa0Dc/+7x4xa7Rs8ccg+glmWOwsJmMNdA4JRvtioH8WjrwZzmz8Wyei7LzPM6JeGrwzw7Y2HDNjETBp7poulbFszlk+yo2WXt/H2dit0wx0c+COBaMuB4SS6dV+CNtDpdxXstcI16hQq5haw1g==
Received: from AM0PR02CA0167.eurprd02.prod.outlook.com (2603:10a6:20b:28d::34)
 by VI1PR10MB3213.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:139::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:48:32 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::46) by AM0PR02CA0167.outlook.office365.com
 (2603:10a6:20b:28d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 15:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:48:32 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:39 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:15 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 16:48:07 +0100
Subject: [PATCH 04/15] ARM: dts: stm32: Add boot-led for stm32746g-eval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_add_boot-led_for_stm32_boards-v1-4-50a3a9b339a8@foss.st.com>
References: <20251112-upstream_add_boot-led_for_stm32_boards-v1-0-50a3a9b339a8@foss.st.com>
In-Reply-To: <20251112-upstream_add_boot-led_for_stm32_boards-v1-0-50a3a9b339a8@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|VI1PR10MB3213:EE_
X-MS-Office365-Filtering-Correlation-Id: 617ee5e0-9ade-40d1-a77c-08de2202eec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2V6c1hxdUt0Um9xZ1BaaTVKV3NKYXFnTythZlV0cnYzeVJTY0hJTE0vSkVq?=
 =?utf-8?B?enB4MkJ5NzQzVDRrRnNIbXV2KzFtU1ZWQ1oxN2I3alVhRDJiMXNDM0tGaEVH?=
 =?utf-8?B?SzNySEc3V3RLVklPUHQrOUx3VjJEUUhxQXlKeWNyREhlREQzNEozbWtLWTBa?=
 =?utf-8?B?ejlBZy9Db2VaQlVkNE9nWTMvTnR6UTBNZGJtTjlQT2U0Y2Q2OUZGRmFGNjkx?=
 =?utf-8?B?dG52TGR4RUg5TmVZa0RzQkxodHlMY0JmRGx3Qkp2SGsvMjJRbnV0OEZaSHFj?=
 =?utf-8?B?WmVqSHhKa0RqeG4yamVDYUhSYVVFb2NkSVFQWDUxUUtoTHVvazRsWHBkeGcv?=
 =?utf-8?B?R1YwV1pCSW1sc3VXek5WVEg2b2M1ZHByd0tpU3R4R01LSE1KT1ltcW5yQkox?=
 =?utf-8?B?dTQ2WTRYYmRQYlVLY3lNNk5hWGdFaE9hcHRSMkxiTjg0TnN6Zi92bURxSlN4?=
 =?utf-8?B?WlpLQVV4cFpJYTAyeVVTcWhXa1R6Qk1vYkhJajJ0Sjk2UkRMb2dhZVMzRWcz?=
 =?utf-8?B?L3dmOE5qbm1lMEVnVHR6L2ZZNHhWOEx2TUpuV2lic1hNVUhoQmRDQ0ZOOTBv?=
 =?utf-8?B?Rks2SW1QV2hHZDBtaTZIK1R3bS9TczlnWEloYzV5dU1ueG13a1I1RlR4WW1s?=
 =?utf-8?B?aFN1OWNXY2l1T1BVWStvbTgwKy9hL2xQOUhaek44SHFOQlhndXkyTWduZUIz?=
 =?utf-8?B?T1NSbmxzVVBWV29udXNObTBNblB2LzE1am1zSHo5bFg2a1lzcmY3bTBEbmtv?=
 =?utf-8?B?dGlqVG9tTHYwMWVjMjYwMlZCZE9INFc4RXJPOGJUdHhyeGlhY0ozRXFHQXFR?=
 =?utf-8?B?bnVtT2JnUm9sa1kybmFjMG8xeXRGNWx2bkRsQm5MWFVEYVRaSEpoVkpEbHlr?=
 =?utf-8?B?SWs1OWhpVURQY0hPS0dSNHEydTgzdXBXYkhQR2tnVDVOVGFsNEhtUUR3WUVT?=
 =?utf-8?B?eW54UjlrWUVFNENnRDRBVmptTG95eitudUtGVzJKSklrcXRIRDJxbFpnNFZs?=
 =?utf-8?B?d0NRVzVhRk1Xc2ljanVSUDBHUVROb0VYeFBPWlBXdTNOODBuVDlWR0tjNHZ4?=
 =?utf-8?B?QUtSKzE5ZXYyeU5yV0YxckpDSGp5ZWQyUUtSb0RDVEpZMzIzdTBkZGRRTHB2?=
 =?utf-8?B?U3pkM2F3RjJFdFJrK05WOEg3Y29kRGFoak9mWkZhTUVKVkhoNmZ2aFdvRWRD?=
 =?utf-8?B?WUpJUXRsYXJYbHE0ZXBSd2JENGl2dXNoN1hsZWxsNmV0V0NLeUpXd3BXbXFB?=
 =?utf-8?B?dnl5eVpIbUkyaUw4QlRtRW5EZGxBdUVlbmJoWXNreEFvRGNXUUIvb3ZON3NW?=
 =?utf-8?B?bDRLT0F3cFlvQWpXb3BRdVhnU2FKaVFUQ0FpTTkzNDFzdWVQRnJEYmliZ3Fp?=
 =?utf-8?B?dlMySWxpUVJXQ0lMaUpoOGpydlZYa29ZUlJEcnA3dVRnUXE1cTBnNTl3dGtW?=
 =?utf-8?B?VUwzRm51OExVRHgrTUZnM2lRZjRMRi9DSzdFN0ppSkVlNEFyNWo0YmhFYlhl?=
 =?utf-8?B?UU1zYS9rRCtXZXdwQjFXRTFIUmhxOU9qZ3RBSTZRZERsU2QrK01RS21MSVYx?=
 =?utf-8?B?UGRkb0YrK3JRdHVWS3pjdG41RnZnOVdUUTQyWHpOSUpJQlZEQ0t4bjNlMmFS?=
 =?utf-8?B?QnY0ZC9OUzJNeklqUmwxRmJPdXBtTUYxQm12VUlTZHpGQ0I4QktyNnVHZ1oz?=
 =?utf-8?B?dXFYajVONy9mSTF2TGM3MW9qRGpoQjkrdTZuWFlRRFZ1R1p4b0Vzb2xPcTRp?=
 =?utf-8?B?WG45ZTY0MzBDL3ZPNzdmd1h1R1FOT1U0dnd5a25idm45TG9oNmlJR1Qvd3Fa?=
 =?utf-8?B?TTRkWC9VQTg2Vy9LY1lWbVBRVVVRbFArNVJiRE10NHVtY1UyZWJoQ3JoOW5C?=
 =?utf-8?B?bzkrbzFtcitXOE5XdEVmTVhReWtIdWNWMnJTRkNMNVZDRFFtdlQ2M3g2WWZO?=
 =?utf-8?B?ZE5YVTJ6V2dlaTZBcU43VzJ6V1MvUTY1bXJxVHNVNHJMbWpVNVh4T2tyTVVy?=
 =?utf-8?B?YllINDlzN0Ztd0JidU0zN1lKNXhMSEp2WnpYOElaVDM3enNrQ2huN0dpLzVY?=
 =?utf-8?B?QlYyZFhLUHpma296VXNkNHpSMzg0a2VPT0lwWnNDWU5qTlk3TmV6eGxOQk4v?=
 =?utf-8?Q?Dg8U=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:48:32.3394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617ee5e0-9ade-40d1-a77c-08de2202eec3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3213
X-Proofpoint-GUID: i6Zh3X5Z0Jr5c-p62vNyfblKOhO4C_qF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOCBTYWx0ZWRfXx/fLnqtuUBgs
 T31g9FoZIVVlAaXZvu1TLqB4hxmu8XlThmtt0IPN5bdYMHsHpKs8OLk3Q64YioVnj7AbObCfn6v
 Bt2HYtfEcbt9vgrT7o7Z+bHOX4gKLnc2vMy2cNWnGChH7WGHGX7ZoWIhSycG6o7PNbXo0S93+Jh
 v0n82Txme1L+TdjosfZJuKJPuLUj4yrt/dxT0tP0R+FrDDeNeu8Ntmu6mW/qT8oCV3zXTVeMS/f
 3PQZEYHmtDg7XJbPF9Ih2424/ehb2mvsmYojZOgR0wm8Q8e/Kpu/8ouBDEJv+7QdIq2BricdTcl
 yO/DWMbsnP+pl6V6Y8+ZcqyVHH4jYo4gHMmnialC9B/ShpqNg5MSJEwtZd/EMOBg33NRFc581d4
 hS9BCe6REuqyE4ARL+aAiO16I9A6iA==
X-Proofpoint-ORIG-GUID: i6Zh3X5Z0Jr5c-p62vNyfblKOhO4C_qF
X-Authority-Analysis: v=2.4 cv=VoAuwu2n c=1 sm=1 tr=0 ts=6914ac53 cx=c_pps
 a=ImtDw27oDxRPo2ELsqiwPw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=VQfofKGPxMUNFPu2KYsA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120128

Add options/u-boot/boot-led property to specify to U-Boot
the LED which indicates a successful boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32746g-eval.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32746g-eval.dts b/arch/arm/boot/dts/st/stm32746g-eval.dts
index 78ceec4a9487..6772c1f9d03e 100644
--- a/arch/arm/boot/dts/st/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/st/stm32746g-eval.dts
@@ -67,7 +67,7 @@ aliases {
 
 	leds {
 		compatible = "gpio-leds";
-		led-green {
+		led_green: led-green {
 			function = LED_FUNCTION_HEARTBEAT;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpiof 10 1>;
@@ -133,6 +133,13 @@ button-4 {
 		};
 	};
 
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			boot-led = <&led_green>;
+		};
+	};
+
 	usbotg_hs_phy: usb-phy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";

-- 
2.43.0


