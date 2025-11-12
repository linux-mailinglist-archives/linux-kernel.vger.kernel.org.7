Return-Path: <linux-kernel+bounces-897439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7A2C5312D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7AAC508AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECA53469EF;
	Wed, 12 Nov 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cEZRY1OG"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DA03446B5;
	Wed, 12 Nov 2025 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958456; cv=fail; b=a3ugB+2BrRDR4qhDbu3jvzEX2YZJPdIHXqC2EmHU81mtJLPb9s9f7YyUxYz1XaCUVuX/Om9RV+szExVMlZXSBxgKt3Kdp/8Dl8+rqQlnxp/9pr1hkdmO99BF08U1GLD+OpFr3Ycpk2fwWKoY3fuzClrO4XilPWc2ln6yToPNGow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958456; c=relaxed/simple;
	bh=Vu0cuNl8laYYZvCV1jNOEGKXcBKQ6dEZRP1HnPjMcyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=A+clWUOMzhy3blVVEnzQpzKuxQahFAsZ1Ort9jYwYgegpER3SDa5MFbNEGIw7kqW14Z1ltDVgpDTZWZhteyhW0qMKw947q4NoBoqbLjtEcFJoIXhfH9bl6VDSggHxj1sv58Mj3YoOq9z3kNmYexbjXjMeW/vBM2+8KWsxD0/HoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cEZRY1OG; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEVYZ41386883;
	Wed, 12 Nov 2025 15:40:42 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013068.outbound.protection.outlook.com [52.101.72.68])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acret90dr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EH+PR8rIkUT3eIFPaxQXJCJ84CNd7VJ/M7a+5fFtfs3vKhBMohZXFlQ13/cm+i+diwIiV+L8/r5A0fggiFRz5EIF66CGpMVtH+tdwb6XdIpVmmtWssCjShDB2w2xLr1um5/3S+tXY6HZXq/U/VghbxkHwy2p2jwvSCiQ39HZsIo5FsHLXiLCrQlawYSQR2Ky1/qEziXhveefe4lYrAqP4ZB/9sKmcjxL9ne4f4S8LcSd8u89/PyMWdHEn3tVQ6evFWpOwOv39THDDAkGZncjuDF2ewdhjKdWUCl8yl8eXE0mywCBx/Ld4MRONPOvi654S0V9iKXPz4deaqCGymhpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+OH33L8crjGZWkxbGA4Yns9O2R75OVIawlulSTOr7c=;
 b=bDaPh6IXo775CPsMhxs70B6TTaX8Ep8OEC8ShyzxyMNkweALSIyj7IZdIbCBlhMRWzrOId8VqWWohzRhhffPUbQp33sJkFdiJVlTnH70TrxSHtnG2dtSWWHRHmf/G/IZTiFY6DaBegd7yq7Iczl+Kzyut0qkdQraKs7u7utjtedc8LvmIG8iRtu3pjhBUKOaUlePsTBFQcJQox5GeH3ENjZndQlrh9pme5/mcRTPQbwWddcs3RsXfiVe/ZQitlZqiqteE+8wc0w8ym2UeSn/gbyNEFGrmOraa2CLgySL9sThGYL8s3WsZdLX4fya6E65A/RXbMaDIUWytIZjZ01WkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+OH33L8crjGZWkxbGA4Yns9O2R75OVIawlulSTOr7c=;
 b=cEZRY1OG1uRUYT9Jmle9b6izkG7zTvU/2AP2ZLzxQ7ZyLv2MS0CRsHgqydYCiCt4BwI6HY2gy035+m+kzY7yXdGKRRhwVM8v8xKwPbHbe3l8JVUSZEt76i5CElmQHZKTtXcL2BhpWZHFoFxAHzLu9eBpDy2kNxzZIfbjcwLguap/DfGMzM/eEorHwZATgiuDHeTFyTV6TeXnGd3072JG12l0Xie8zMku6FGUf0i9y1eVCWaX9VV3eGhYhT2nYTqz51GCVq+hNDNe5yet5Gt1xdE8ci/ADxHGsaoXn3+m1aEPedflSZYH8R2yLlEFmq9werh9BJGw7XupQ3JNYpmZpA==
Received: from AM0PR02CA0172.eurprd02.prod.outlook.com (2603:10a6:20b:28e::9)
 by PA1PR10MB8738.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:440::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 14:40:38 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::39) by AM0PR02CA0172.outlook.office365.com
 (2603:10a6:20b:28e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 14:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:38 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:49 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:37 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 15:40:27 +0100
Subject: [PATCH 10/16] ARM: dts: stm32: Update LED nodes for
 stm32h747i-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_update_led_nodes-v1-10-f6c77739113c@foss.st.com>
References: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
In-Reply-To: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A8:EE_|PA1PR10MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 175ed292-02aa-4a31-4db2-08de21f9729a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjhxU3RGekt5dlgva3VydU1oTG1YWHM3YlBKcTJRbGxZZWlpeFRtMWdDQ3ho?=
 =?utf-8?B?SUM0NGcybHR5SEx6MHMwTFpKSVhXblU5cnd4RE5PZFJocGN6aisrbXBxL0Uw?=
 =?utf-8?B?RlNIWUdyRkU1d1ZWVXNJM2Zjd0VwUk9sQnFQeitzYzcvYm9hRXRJYlQ4QWlR?=
 =?utf-8?B?YUNzdlVodDdGSXFBNTYzZm1ya2M4dXd3QnNmWjlSeCtxcnFySlZ6aW0zblYr?=
 =?utf-8?B?QkZvb2VJeklnMnpDbzZsRXVTOG5aeEJuQXpUdDlLY2ZRWk0xNE1PNkQwbklq?=
 =?utf-8?B?VGlCeVE0Vm15dXJoWVVuOU1FSUtSaFVENXhKakNSMG53TUUxMm92SCtkcHA0?=
 =?utf-8?B?UXdqRjRRWnIwOEJhSTlsUEdlaXU0eVVhSVZUNnQrVXVaSVRGRElETWRGL29a?=
 =?utf-8?B?Vmlrbk9zV2N5RmhBMTV1WER5NUQvWDBBTFUyaS81Q0VVTXRvVmR6ZDYyQ1lk?=
 =?utf-8?B?SG9jenljK01NUklxZWFWZ0JicTlrSm1taURlazk1R2ttYmphMkRZMUFKcEtE?=
 =?utf-8?B?OG1UNlBTSDZKd1lOZDJucFdqWjVGS3BzS1E4NUUzUWJ6SHF6SEV0ZWN4RnJI?=
 =?utf-8?B?c0wxL1ZoMmFnTU8rd0kwQkVvTmlRZTUvNkpxR29xSElBWjZkMXR1dzA4bkZq?=
 =?utf-8?B?RjBEdm1wQk1HMThSeHpBY25CZnRVNWZSK0FMTzdlRXhWdXVVZWxRa01nSm42?=
 =?utf-8?B?Y2ppZGZBdFBZR2pjV2lnWFFTdzlsK0N0cjRBRlhGNjNDb0ZvamlwSEhwT0Y5?=
 =?utf-8?B?SHFRS3k5K09abWUwVFNZc2p6aTRxbVN6aTFKdDZwTlpKSzdwbGpya3dxQ3BJ?=
 =?utf-8?B?RnFrR1F2UU8wb2VFWERXaHpNeHNwbWREbWRkMjRqMVVkMFFLSlJBWU1ha1hY?=
 =?utf-8?B?bE96cHI4Q2FrOWFweXQ4bXBoQ1JIMFIzcnVsZytncUoxSmNtcEdyRTQvby9Z?=
 =?utf-8?B?b2xkQXJhb016MkJGWWRhUjZkNm94dWptZVVYRGZ5NmM1Z281NEFGdUo0TEps?=
 =?utf-8?B?WGlGa0pMWEgxUGFSa0FPWU5HYjZLeVN1T1dlZGd2SWo3dDN4TitEZkM5dXh2?=
 =?utf-8?B?a3RjWUdYSUdBNUdad0I0Tzl5aFpkOUx1V3pBeHVsMjNoY29NLzhMMkoxcmxn?=
 =?utf-8?B?N0hnMklONGp4NFpORUE2UEY5eDlWS1lYZldIb3Vhd0FweUdRNm9pT2tVbC9J?=
 =?utf-8?B?djhjRUVPeWFTZ3NETm5iTGhmR292enpUWXJZOUkzc1JSUDNjeVAvVVZZYlF1?=
 =?utf-8?B?VXVYNmFCREhiYzlveEtGSFN6eUhPOXdXWVJ1WGc1R0tyaGd0dlord3VsODVC?=
 =?utf-8?B?R0ZOTWZjMitVYUdEUUVDUlozR01rUDBJbm5oM213K0wra0graTBTSm1KSjdC?=
 =?utf-8?B?VmZyZEdzY1E0T1ZPRW1zMitjdnFabkpxUnlsMjJCUDVXTmNxdEFUcFlDcy9p?=
 =?utf-8?B?TkpKWW5OY05jM1YxMHFIMjZ2cW5FelQxeTVTR09zalVRZ2c3MXB4VDlpTWc2?=
 =?utf-8?B?VjRUVVJybFg5QSs0dW01QytYVmptNGJRdUVJSFY2ajZ4b0dVU2R2R1BLTkI3?=
 =?utf-8?B?cmNjSFAvMVY2MDlxd0VnVEUvSkM2NzFSRGlzVUw1ZCtXdFpjS0RoUTZFTUpZ?=
 =?utf-8?B?bTExVzhudmdTNmIvUm1EU0x6eWlZRWZ1MGpFa2xMMi9TUnZiL3IrUVlPQkFV?=
 =?utf-8?B?bUN4b0gxd3VvUTV2aXpyR1ZueG9xU05XK0V5amhNN0lUdXM4aHQzck5aSEpW?=
 =?utf-8?B?ZjdsM1liNktlcm5yV3EzSW9aUXB1Skh2UWFjUm5IeWh2MnFMZytLZGhMNVVE?=
 =?utf-8?B?TUp1bVJNNytEZnkwUkpaMVNoY1VQd2hvNDNqclFJOEpxdjNlSXlpYnJHL1l6?=
 =?utf-8?B?N2VBSENpaU16bmVmSzlJTnZFcXp0MllpeThlRklpbXBaNVY5MGNXdS9kTTJD?=
 =?utf-8?B?VDVmYmlIZnI2bHJwMUh2eHFLcDM4ZVEzWCtoamFVN0x6S1Q3YVNacTNFNlp5?=
 =?utf-8?B?dkovV3VTTW82bEd0bWhmZ3VUZHd3bXZueFNGQkVPM005Yk1EdC9RY0tVWGUy?=
 =?utf-8?B?RUhjRFg4V2NXcmFxS0hpVjBmUEZSVThQRjZwSzRHZGthcmd2eHR6SWV3NjEz?=
 =?utf-8?Q?deFs=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:38.5645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 175ed292-02aa-4a31-4db2-08de21f9729a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8738
X-Proofpoint-GUID: am9z8rWhrSzrnPNOk-1Gk-5Enahm3-yL
X-Proofpoint-ORIG-GUID: am9z8rWhrSzrnPNOk-1Gk-5Enahm3-yL
X-Authority-Analysis: v=2.4 cv=SMNPlevH c=1 sm=1 tr=0 ts=69149c6a cx=c_pps
 a=KOiI8WV4eRqHkUZxW/2pzg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=i6iesJtyZcC8ATvhLGEA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfX/8+QGxl2a8qp
 +YEIh+q6TRwgtmUuA1OYNRJ6aPtI12r66OffB82KlbIc+vsTKOQsO59oVHi+RgjTGLKOwd6R28p
 pk1dminCBh3nEaRyVuSAZ6kmLnV3AxEXenrwLqkgzJDmLxNwV97aXEjsWFHqZGGpWtHqfYPvsI4
 GpHPaku9LqAiAVcF7NNVYaREyZSa8IVx3sJG2BGq+XFVUF0rMuK8GTAXcGMU68qxhwIMFIlBakw
 9lNjQFP3XBcnCdUJgWPXjHkFgZazoQN/ONy3WQSvKYcr4/yRjc8G8R8Waxb0AXA+oMuSR/I2nNK
 5p9Z3NQQGdUNm75uPyMJNx5HsN95jbgYbzP0NIF2mgseL5MqKYRcx/ccDfgJLvqR+PFp7ykxFJI
 +SJkXY3Z5JKOGB0depqgjBQCXN5Eqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120118

Add function property for led-green node.
Add color property for LED nodes.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32h747i-disco.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32h747i-disco.dts b/arch/arm/boot/dts/st/stm32h747i-disco.dts
index 99f0255dae8e..bb6649a58bc1 100644
--- a/arch/arm/boot/dts/st/stm32h747i-disco.dts
+++ b/arch/arm/boot/dts/st/stm32h747i-disco.dts
@@ -8,6 +8,7 @@
 #include "stm32h7-pinctrl.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "STMicroelectronics STM32H747i-Discovery board";
@@ -39,16 +40,21 @@ v3v3: regulator-v3v3 {
 	leds {
 		compatible = "gpio-leds";
 		led-green {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpioi 12 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 		led-orange {
+			color = <LED_COLOR_ID_ORANGE>;
 			gpios = <&gpioi 13 GPIO_ACTIVE_LOW>;
 		};
 		led-red {
+			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpioi 14 GPIO_ACTIVE_LOW>;
 		};
 		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&gpioi 15 GPIO_ACTIVE_LOW>;
 		};
 	};

-- 
2.43.0


