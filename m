Return-Path: <linux-kernel+bounces-897444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE89EC52EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9DC561204
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C233D6FC;
	Wed, 12 Nov 2025 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BkXr9yPf"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213CA34A3D8;
	Wed, 12 Nov 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958466; cv=fail; b=qsuMNIMpxlA7eHZWvR+NqVKSXrVgFHS3x9jCFQQOeATDUqPcEPusswInoelgYvxzGoMXFn85JY2gptWOYR/KZaUg7ywA+pwfP+bNaUrzeOdg8R4s7hWGd2DDRXVw6Ci/zVlFWfhNWMNMBYuBugbV575fR1ARSF4W++Hq2f1CvLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958466; c=relaxed/simple;
	bh=6RdAd7Gn5gWjmJbRlyJmx1l+21js9pxDd+RgfvyScTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CW9Qr3H57hTfiDMfLYU6UhrYJ9NCTnSnMvgSgB7WQ9seuoBG4nQv3PIQdLzY0e7z1Kt1Q6A9IUbGi1eG0VNXgTyZZmC4wRIH+MFtNlDpcou3iBzCWtT9dXYaOryb7JqilOdnfYqI2Qb4wnSxKmLNyZJxnVdtY8xvnyidF6Xdhco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BkXr9yPf; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEVnxj1476468;
	Wed, 12 Nov 2025 15:40:49 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013049.outbound.protection.outlook.com [52.101.72.49])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acqa79dph-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAfMhXFecR6g6/6Rke+xx+aKzCRwZdOwaxH0XpxyvXQjW4e8I9+47p9ijd6bhMWI4T54ng1Z2iRKmiJGTxA7g71OUA3jt+2Cn11c6kzGftiPq1qG5P55YFbG3/ZeFmPbEgDfrSuwmnJu5o4D3o6vq4hCuRFe99DxH7bcw0imJ7ux+UWjSm8+YWOSCySIlV+ctoA9N4cNWfnOT7g0Re+5PBjuDgD0cb/y+ra58Ha8JAFgX9IQiuPzvix+ipDTi3JeFMnLN2l57ItmcN4LpIpHhPHYJWcwiBdnjL3NsyjL963cneAABiRHDISRMl6ZHpx3NRqTWdlfGZDmioPYBhGWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnIO9ZtV4ZnKaaDQxPal+sDG5zR43lw2xFvyuYfXJ0k=;
 b=Jzj/dMN28XO52waiFUe+yToB7jQSMw8NcPSoPPZQQmWkKrHOpmWPy3F20c/AxsOioclnzf+9cXbjVtK0+t9/B8hRkcoyfWukO2VU3cR4hvYDvrDMSBRyYSbo4S4+PAz4azIUlrtnSaWcRHhhTstbqT1SveftXRBAoKIye4Bh8BAWDetqmSE92UWFkEiq2UmAQY7SbKPs+GV309fCmvHhe25G5DSeWY1fHBEFq+7gLv3I/4YQseXdsWI+C1awJD6ujfIWD8JWDa2bOgKO8EbVkTmCkGXdjQhQG0zsSlXSnGVFfKhiz6PuYGUlde25YlXRbLo7DcYKJIh43K62H2pwjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnIO9ZtV4ZnKaaDQxPal+sDG5zR43lw2xFvyuYfXJ0k=;
 b=BkXr9yPfc8AkS8G2gkxUha4G/LslnnOrbGV5dSO3bkbLLXlirpfa0cDusWUsA/Mpcym8/ZIVURPh5i1ffFh6cFrS9alcr/FjQP4c1u4+48TlY1i2YSp28KLy7EraGkC5NjE1/S1Gr7BOqnszU4RtuvVjTVz1PV8wZ8F2Tn/t5rgPHH9y1pIRQUyc2VXoONC6VzQnm0XI9Y4b4Bnz1KdzyuqNMqkGHQ+ai/IU1DtBozZK+eZrV7q5JU5Q5NTU7CRdRo974I9r+jD+T1TwHfE4cv/vWv4GthXz2YbtwkLxgsHyfChNKGnM56BPyhYHAWbGjpVBYqv83L/3RD4XMpykpg==
Received: from AS4P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::14)
 by GV2PR10MB6408.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 14:40:44 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:5de:cafe::4) by AS4P190CA0008.outlook.office365.com
 (2603:10a6:20b:5de::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 14:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:44 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:53 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:42 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 15:40:33 +0100
Subject: [PATCH 16/16] arm64: dts: st: Add green and orange LED for
 stm32mp235f-dk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_update_led_nodes-v1-16-f6c77739113c@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A9:EE_|GV2PR10MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 48de28ce-c31c-4f9d-4a7b-08de21f9764c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHJrT0xhZ0Nmd0gxdmpLZ0dSVWZWb0xXWkczMDdmQVJNYXc0Y09oYWcrNGd0?=
 =?utf-8?B?b1N6bGpkZnBWT0hlSDE4aTBwem0ramtsOEpSWWFGdjVKVVAyczBxbWZja24y?=
 =?utf-8?B?QjBRT2VwYmNaaXd2RUtMd01xbjdzcjA0Mzl3b2xwVlBiM1VGK3lRMHgrR2cz?=
 =?utf-8?B?eHFUUnFYTFptMEsrdWRKUktFQStkU2I1eWJVRVhQSjNyaXdOZTd6aWFJQWxQ?=
 =?utf-8?B?S3p0c0ZCaCtHaSs3TStOV1pIZExqeTJLVHpwOU1SWmdBOFVNMlFtbkV4N29C?=
 =?utf-8?B?QVBoTFo1TzJrQVp2U01CT2xRSHJMbUhOL3lHSDUrcGQ4UUN6R1FMbEI3dHpL?=
 =?utf-8?B?bVk2TFhCSHNyVEtmNmg4TkozbGFBd2hibmhqK3NFcU1LMklBeXNxRmFXMmt2?=
 =?utf-8?B?TXN4WXNXVEZKSis5djJtcjhxQjFxU1RMYzE2RTdCLzUxRlo5cms2V1lHUlR2?=
 =?utf-8?B?aXY5V0JnYldRNzNGRHVSSFhjdUIyYU5vWG5oaUd1Zjg2bXkzWkNCMnFnN3Rz?=
 =?utf-8?B?eFYvMHk5NGVKSUxwYmV1VHN3emNoOGFHeXpSdWVjcmlWTmdXbWJUUmVBWE1S?=
 =?utf-8?B?UkJZUWxvUlMxK04vamx2QmcrN0tOKzI4aVVWQlV2RUV1NXRyenVKNDN2N0Mw?=
 =?utf-8?B?Wms0Z1dhMnNjTVRzdEoxblhSL1oxOEZsWEh4VjhQZkxRKy9vSGFKUW11QXFJ?=
 =?utf-8?B?cGlYUEc2dGZkYmd6a2d1QWdHM3l1SE9rYnN3LytHU0Jhdm1URW41a1UzbnpN?=
 =?utf-8?B?V0dwOFdaTFVua01tZVhDY2N0c0VlRnBrUC92TTZ4cjI0WDhzTTAxYXVrVzMx?=
 =?utf-8?B?QTNwNFpuejFzWDVLZzk3cTNWcy85aktPeDRtT0w3MXExMTBhdWRDSUhvUUJ2?=
 =?utf-8?B?SnVyMGFPWnpma25aUFUveVg1QW9YaWwvYzY0K2ZZYm9BSEVPNFgwT2ZIMHpp?=
 =?utf-8?B?RHdLSjJUQXczbVowcmhBNXl1TVpCdDFLUERqRDVCcFNjeVZ0VjR6clFCeDgx?=
 =?utf-8?B?ZjhZWG4xNmtBS2VvZUtxenVqRjJ1ZWdhTWxVc3dORWtBZmUwTGdGZ0FweFMx?=
 =?utf-8?B?eVlFQzdBbjI1V2MvRk53eGJoS3VYQUl1ZGdxV3MvaFIxWUt2UWU1dnZhUnky?=
 =?utf-8?B?VDhzM2lYVTBQSXEyMlBGZ0NZRmJ4c1UzK29xQkIyTWlzM0VFS2h3NmxBWkhM?=
 =?utf-8?B?UUhLUjZhUkJhbVdObnNtKzNtdFhMOUNRanVaMWJUeTRETmVoNG5ydjVvVi9i?=
 =?utf-8?B?TTZUUmp3UCsxTllQWHB4blVKVVVFdTBNanpuQUwwNEh1aDU3TDZsNUVsSVFz?=
 =?utf-8?B?dlRpUXZLL2gvUW9GeEhhQ3NTeENob2Vick56bk41b2pVVWxMN1laYTlueGwv?=
 =?utf-8?B?YmYveDNKb3IrRFZqYUtscnBsTGZwbnR6M3ptSWlnV2c5ZHkxeDc3UWN3SnQ4?=
 =?utf-8?B?aFowaEs0YWlYUzNTTzBKbGVaNk0yc1BObCt5YkxlalcwSGtXMlNSQnlwUW13?=
 =?utf-8?B?WGZwTjBoYytNdzlvYm5BZ1hZU1RaNW9iUTZ1aGZzdXJVbm5jOEdqeUhURGlL?=
 =?utf-8?B?dXNXNTIwUE9OejRMbGVzWUw2dnNYWEU2TzJSa1graHAwKzBXUGJLMzg0WFJy?=
 =?utf-8?B?MVBWeHpScC9ZQllpZUo4STkzMmU1cnIxbmp4RFJKYmMyclkxckhubU9MeDhY?=
 =?utf-8?B?QUw4WGxrQ3lGdFAwallIZ3hFczJNQkplQ0Zmc3lBUVAzb3g1dUNWclpFdUNh?=
 =?utf-8?B?REVJKzE5QjBRRkkwR3R5RFBNODk0cldNWW85Q0dYblk5cDZSNCtaZEtoZlIv?=
 =?utf-8?B?WHNGQkJGa1ZHeGIyRHFIMjB2QVQvckxMRVJpdUZsU1JjbFV6ejdxbjhnSnJL?=
 =?utf-8?B?M285RmhOMVRiVFRzcmdMZGpZQ3AzeDVnMTRZNlQveDhsWTZFSmtteHg3TjBi?=
 =?utf-8?B?WG9YcTFDdVNraFJQMUovVmppSmhNVWVYMGgvVWJncGM2RjZVbS95cmR6SEVj?=
 =?utf-8?B?ZnlDQ2J3T2xqTWpnSEhQOXB0WnFBVEdIMDR1MTFvUTNrckUyQTlYd0YrNktV?=
 =?utf-8?B?U0RnbWlhRUMrdWRFQ0p1R3lVZDN5L2FxRy9WdWs0WUQxaWRZNWR6LzQreDgy?=
 =?utf-8?Q?FPjk=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:44.7595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48de28ce-c31c-4f9d-4a7b-08de21f9764c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6408
X-Proofpoint-GUID: KbWleRrHcX_WvQBa4n0uS3fPAu-jFteV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfX9AllM3rT3vKE
 E8SZUZHJRTMDaUD3Ijxp3KUssmVtswVe+TcvkJq1yndWerNC5hzWUi5sHjG2JMpe9SMip8FeSCf
 24bUFU1sSpMAjBzNCeSfomlFQ20uxUEL2eLrXmtjtnW5afzUkRuHbw5817MBK2CXBLY2kw4Wfd5
 V40HH7xkQ3uxFirrKtabt+xE8J4UDZQTJoIpxYWR9uTnEMwyCNSlHy+CbGSTg8hT7EHuw/H0nYB
 Bztl84p+IYevHN4mv0kER9gXCGRAfbUooRhUy8BNgHjmGBaBO8DgIXPkI4D8cSGLdJ6UZ31Ev9b
 O9Bt8hzb15Y4Uy6CazDMYwoFUi1S7sZM5GO/zEJZdXyP5pTSqOc3p3wzbKQW+TUcnv87GBAwo6u
 oTU3+VbTif6q3yETObUeEefkt3tF2w==
X-Proofpoint-ORIG-GUID: KbWleRrHcX_WvQBa4n0uS3fPAu-jFteV
X-Authority-Analysis: v=2.4 cv=VoAuwu2n c=1 sm=1 tr=0 ts=69149c71 cx=c_pps
 a=Ca7o2WdDEAbC360iv+y32g==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=GoHG9ZAtNuuEcBzL9IoA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120118

Add blue, green and orange LED support on stm32mp235f-dk board.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 6e165073f732..f41213187723 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/st,stm32mp25-regulator.h>
 #include "stm32mp257.dtsi"
 #include "stm32mp25xf.dtsi"
@@ -42,6 +43,28 @@ pad_clk: pad-clk {
 		};
 	};
 
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led-blue {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpioj 7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+
+		led-green {
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpiod 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-orange {
+			color = <LED_COLOR_ID_ORANGE>;
+			gpios = <&gpioj 6 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	imx335_2v9: regulator-2v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "imx335-avdd";

-- 
2.43.0


