Return-Path: <linux-kernel+bounces-897438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC3AC52D98
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CC8C508AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357F23469EC;
	Wed, 12 Nov 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LszzvQz8"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4B5343D84;
	Wed, 12 Nov 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958455; cv=fail; b=Ke1Uk6ACmrWkO4h7bgbcxXRf8IVk/59O+x8QVO3fBFvSyRKi7nrNzXAPy6kTOBaZgViHq3yEfx9ebZUDbXONJH7ixJKzotThiOPSSekS3B0GUh7etCdrNeDZNzzcAOfXzFHSSMiNVCJX1JQpeMgcNGQgI3eP4FWfAgYzAp8ntYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958455; c=relaxed/simple;
	bh=EgvZVuHzcM6xBUu4L57EAgmMitt1DOW3fWLYGgAdOs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tMg7nGw+V2k+2ltCX1Vm5JKczWuBx5YiLmMW0F1WF3W8t7JjzsyPMAvQQVBGwm7BpTkoK4CasblR/aa+B3hX2dB5EIyM/69Rxz8EuVXR9gMo22Khb10GHKpwcgEFUF+MJsIrD/M1pXWjZxRs6iqmOEUbU2qTh58qTbqgbP0vOJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LszzvQz8; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACELTUR1472514;
	Wed, 12 Nov 2025 15:40:43 +0100
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acfv8b5ap-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7RNbIUfsxN/7OicyPlEFKpbVTMke1X9x8bRsq5GB2zIw53X9g1MZ/uR6p47aFsKvO+BXwjHdRc9QpfHtbml2ac3LGQS0yiRzKRV0X7+oaVC1Otbh7+mCwz7eiouwNzIzOrDpiGQ8q7UUA2fOYYRG3DZc7ImL8lp1mnZGAqOnXyxZsf/uoFlZHFlBRCV1wgQ7Xy4wf5SERBf9sqSp8YCPbBrUA6XCUrXDc6BSSYe1Sy2qEG5R0DWzxF8z6kfeeYbz2JcbD4M566zcnzC6lK2yhfi4HSTT/XE8/CJ16Dxckt1Eb7hFp5oFLPUGUbCar5whW9JpIWSjeKeU2ouhu934Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvK4VTcvLHRHx2jGDqsoAZ/m/IROuL01EGBROV/skm0=;
 b=GqQBFkhgzYiBfiCeDVBoFbPSKOkJWnSax774tsQjGUBkRB7hdKa5Uh+znuywaAKy+MsYyuL8ezJpUBZts5LNwzF3ibwHJRytLITSx03pMuGXv3/ylAZBO7xD7gs1wThrl+VVUtNo0lgm5rrw3M8Mp2Fp3EUkUjrWsEo+qSqbWSzSvaL6m+/XMfg2ZC3j7AySm0ZqiR7PM+gg3dbGzLs6gVGKbjO8iMQJgQSWHh/oizMNXk8YlQTZLVCWy3nI/qSJudtNc0RwGAc8TkM58878p7StSP48nkG/pF1s9NkAnRD45wKI0KV5y6A1Rifsa0Mau27L0gEiW/uTdpNdmcSpGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvK4VTcvLHRHx2jGDqsoAZ/m/IROuL01EGBROV/skm0=;
 b=LszzvQz8mJx5Ez3HUSPaJG6HRMRT+NCWY9hxZuL5Wpg9F74Kzn8efvLx/sCQjQ0AjtmX5BVW3gsiuQOgUYmbnSI6QUZ29vRdIaj9a+qLa6vKd32ZqVOPAKNEYcNiHc6IVJlG7udOaF0eqzwu4URTWaHOU12yvDc/gFA/NabWDM0CKhN7tIsm5oLtD4eFOpGj7iWW074S6VEBvPmrUqL34OiVVn7akz2aVPncv7iqPxPHZ5saQmP3KUFEQfujiF33AAhDb0X5312bCbbqVumy+Drn6I9yUoj6Ag0SPoBpUTvyVzPQksw8Sep4QP8/OPZkDFs8MTZB2KtslPes7Havug==
Received: from DUZPR01CA0274.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::13) by AMBPR10MB9243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:6a7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 14:40:39 +0000
Received: from DB3PEPF00008859.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::77) by DUZPR01CA0274.outlook.office365.com
 (2603:10a6:10:4b9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 14:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF00008859.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:39 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:48 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:38 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 15:40:28 +0100
Subject: [PATCH 11/16] ARM: dts: stm32: Add red LED for stm32mp135f-dk
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_update_led_nodes-v1-11-f6c77739113c@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF00008859:EE_|AMBPR10MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 51cabe0e-c97d-4e66-e2cc-08de21f97317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmhqbW52OSs1MFJKVUtrNTMyUzFYeXBhRlZudHpNaUpiUGNZZUk0R2l5dTkx?=
 =?utf-8?B?ckZsRUJiK0RJcnpLajd2QXBDSVhIaUZuNXdXSEJIZWNjbHlmS0EzSXFPQVov?=
 =?utf-8?B?aWZnNDAxT0FhUXloUU5Ba0p4eGdxdWxVOU9Nc2UyQ3R6S0FONmtvMU5SZHQ3?=
 =?utf-8?B?UlRCbzlMd0tIZlpHWk1pbnQ1a0o4R0hnb0xRZTVMQkM5UWdUbWg1eW5LR01I?=
 =?utf-8?B?WW9zaUxmWGJEQWk1d1NoTGQ0OWRac0p4VEpNR0pnelFTVHlHWUU5RjNqWEtn?=
 =?utf-8?B?dlBNNGI1Zi9ydmVvQ2E4bGdvRUpiNmFXUGdTK1ZvV2hoNUtkV1RhVXZCbFR4?=
 =?utf-8?B?Y0FzM0tEVGQ0YzdDZ3l3QXpoUUVhcjdpT1JTSmcxRHRjaHVMcSs1c1hDZlVr?=
 =?utf-8?B?MDNmUkg5MmlKOVZ4VnM4enBQL2pDYTlzdzFsWmo5WThxYWVxWFBHSFBzYlds?=
 =?utf-8?B?aTZFZDJ4U0diWko4MEZkSThSL0o3eU9INitkNmxFdS9UMWZzN3c0UHNXb1d3?=
 =?utf-8?B?TGduRnpjVTVNY1FlUnd0ZWZBWW8xSjBra0VpTXRnY2FYTWFpamZSZmlRSzhT?=
 =?utf-8?B?cU9OMTZVbWdZVythR2JkK0Z6NmRiTmdWUmZ2ZFlIUEU4YnVuNERIV3l6Z3dP?=
 =?utf-8?B?VTgzVVpjNnBoOHlnZEw0bzR6UWMwVnI5THAwN2ZQN3RGenNuRG5TSnVSQnpP?=
 =?utf-8?B?OXJTazh6bWFzVHE3NldoVGZWYnlkMG8rWTIrcUNBZU1URjQ3YnJ2dlh0RktY?=
 =?utf-8?B?aXVGc0NHTGZiMDd3Q2d1MG5ZTmJoblF2MnBRcUdyc0syZld4L1ZmdUJSV2tv?=
 =?utf-8?B?YVpIMGFSQ3pJM3dKSjZUTmZZWklNdkh5aDFOYzN2M1dvNWs1TnVUYXF6c0RD?=
 =?utf-8?B?NnY5elVHMnRJYUR4Z2h0WndmNmdtdHJwM1Nob2hkcUw2U0hsT001MHlXNDdB?=
 =?utf-8?B?WGNqdmVYWGxmVnFCY01zN2JNTDhkdHI2elEraEZ1RmRVZmVFQTI4Ulp3WUov?=
 =?utf-8?B?UzN4Q21tdXRWWDJaVXRmL3haQmtXL1Q1dVV1ZkdUZVhPaHM3RGRBQThFQmdr?=
 =?utf-8?B?N1ZuS1FuWjFTMjFDSWdrcTF5Y2piNE8yVHVyanMvRUNtRzdjb0xxclF3R3Z6?=
 =?utf-8?B?aEdJWlduU2lqMkJXN2ZLUmJRNXBncCtTUTVrSFFsQmI2dGxuQVhqa01SK1J4?=
 =?utf-8?B?cW9pSWdCREM2SjNlSmZ6azRlNUg5M0xydjJwSHA1akwzUEdHU1hkMWlxTFgv?=
 =?utf-8?B?dXZSU2x3b1NsdzdGbktwSTNrdU9kcXBISnFsNGdWU2w5TVJFRC9ESnN4Nlcz?=
 =?utf-8?B?eFBwTWxBd0J0Ry8reHZzd0JoaXpWTU9qbzNZYjF1OHVoZnJIbjNLWlJvVW1J?=
 =?utf-8?B?eUZrSjhTVFUvcDQ2YXVPcGRIdzFDY2xKWkx3SCs1Rml4TlNOTEQyM1pCRzJ1?=
 =?utf-8?B?QmU0dkd1RW1WZzJGYlk2UHFHdjl3RC8yOXdOZlRZSEVEK051Nnl0TkRJVW56?=
 =?utf-8?B?azBxVTl3Z09lSFIrMERlTGZyNnFyR1NWT2NtdHdTZmEvNnp1ZGlaMlY4SjFr?=
 =?utf-8?B?ZzgxSE4rcmNxSktnb3RkdUROazVnN0RZekRzL2hhbzNHKytoSnN3NWEwYko3?=
 =?utf-8?B?ekZWckFrZDd2Z2hJcmZJM3hmRkJ4dXVqTU01eXRXQjJUeklhc1VKTEhFdFdk?=
 =?utf-8?B?YWdDa2JYL2pHYmxVSWR2L1ZCQXlBcUxOUUZ4VGtpc3N6b2cxbmVHL29JMWdP?=
 =?utf-8?B?MXQzOFo1cjUzbU1RNUJ5cStsVUhUSDQyMUZCSnBQRGxmaGJKeUFjUkN1L1NS?=
 =?utf-8?B?NElISnJ4T24vVm1EWlA4cllxbVJZRER6WGlaQnFzd1hGK1BjTWxLdmsweSs2?=
 =?utf-8?B?Y0JPNDl5bmY2d2xNVVl2Uk95cWQwUHpaVDBKK1lQTmFIcmJlNlBmVHJqdXpR?=
 =?utf-8?B?T0JTaHRZNlpBWmxPTUlBZmxGenhEN2hQVkczaWYzbGljM0tOSDczUW1FRTNz?=
 =?utf-8?B?aC9ITWw3ZlBpZWV0aUJaWXZDd255cUg3UmdxN2grR01BSUR0N1BrM0dCaFgr?=
 =?utf-8?B?UVFORGJuUlNqQm44OUorTktxODJqekZYMG8zQUlNOUxUN1cxVmFZajNCc1Q2?=
 =?utf-8?Q?Szds=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:39.3646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cabe0e-c97d-4e66-e2cc-08de21f97317
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008859.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9243
X-Proofpoint-ORIG-GUID: i6sE2WdaLKWPGc59E_BqOKMlaOQBBvnn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfXwKengA4ryI1U
 nCZg+HOwBDYuaY7lVuDDSCViM5cuwigpU0dVxKvjbwQbT/dMDQ0IEoyjCUZmObsJW1VpliU5/Vu
 r41UMHOYe4fQcYnv1ldnDKY5ivKs2SnLo0dp1k1b7wANYFGs+FxBOaKvC8XOPRddpUsQuZoOFLa
 kfGQp4ONKinkkgSzyjEk91ZFLsR/1SSkNEkH9QlWKxujUIe4/AwMqG0FvVk6hUzd43+YgzcV8O5
 GgThX476tqZHI/eLpCnhitFzv4RZdiQtbWTn5NhR5/dMKuT/EnvQ3jNZ1pzuAnrpzzNbvgbMeEz
 zYNcenCJpDTooBmWrWsdRiTal8JitbMpYke0MzfDaREGAsf2L/gdufqyjPHYdxpIUt7KWuGnxQy
 fOz9o5rZ//qOw83aW2mLgfQ1KL07+A==
X-Proofpoint-GUID: i6sE2WdaLKWPGc59E_BqOKMlaOQBBvnn
X-Authority-Analysis: v=2.4 cv=ZqDg6t7G c=1 sm=1 tr=0 ts=69149c6b cx=c_pps
 a=OO0GoY2mO76woEg6W8CiTg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=bCBYE7X1YGK-GcsMjE0A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120118

Add LED red node for stm32mp135f-dk.
This LED is used as status lLED in U-Boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 9764a6bfa5b4..909372da711b 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -80,6 +80,12 @@ led-blue {
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
+
+		led-red {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
+		};
 	};
 
 	panel_backlight: panel-backlight {

-- 
2.43.0


