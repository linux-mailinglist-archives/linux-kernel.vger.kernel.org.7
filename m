Return-Path: <linux-kernel+bounces-899598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7561DC58659
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26C3F4F2DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4517735295A;
	Thu, 13 Nov 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cVUnd/VB"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37D346E66;
	Thu, 13 Nov 2025 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046873; cv=fail; b=a3zVwu5KUmKhhPfFt4dDvx68XPTLSW5a+xOoD2K2FKRmVLGcO0NTeK78sUchUytt1WqDYDKh3oIgxkWAOZIYYYoTQ8Lsov3ANjvjZziiixltxX3FbyiG8u/pR7uDsvsEe4Rd+niz2GGNNJHSrQ62DQvmLJClvYSq/1ZExXuZWGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046873; c=relaxed/simple;
	bh=CQhzPqI4DpL/d04W3b2ZrSomOiL88MHcWHDvcckU37E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qbF93iyaYelzNkksZbSbX7hQO5OREVAzTl9fqvYED0/MKWWi7MhNNh1FVbhff8423CpOfr1hARvgbQeINl+fIgJFO4SADQTAAlEHKoP6ozqGmkVHwYDcTm2pxqx2pxkUfiXzoKC0ks3oJ6Vd5bhMEAYHpXT0VeOxea73IMCM0XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cVUnd/VB; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADFCUoE266094;
	Thu, 13 Nov 2025 16:14:16 +0100
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adc9s9g4h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 16:14:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2MEX5Grg6GK2APRTM/7nxKX7GWY+lWECiETCMtlG8mRXk4iumXpKEBssnvWTxFa8yDfsz8y4AHDUJJrI/wI8rC9aAMI2sswJhAU38FggsshQZYJ+Osko7nqh2gVvDYa3/82+XLnoiQoViGJDHChJgmWRzvJQC+nvT3geyfwp3HmOeau72Gh/gb7rr48cKugWC4p5ud4CKNJAepAT8Zazapu3r48+Zq7yQQlOW8n9yS934Qayierl2tBZ1M+F/r7xpfAamWqyJvs300f0SVEihdFGjcLVrY8dE+26Onus1ikIN0CCXpfB1vxPRtyqGGIAGD9l1pEoQwOIxT8d4fXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92zov0C+uB9MOBT16ijczFGM5kBkTH2zO13odElRvVM=;
 b=XuwAYm5ZSV1T07G6CYHHsnxq+wdmRLPlJweJ0lwxkx+GP+Dezi7YuJM8Q8ei0sfJmQMdwAQJXZRDWeiCxkg3hJoqhjpgt4vfJnlDYAgt7RkFhV2yJVfM8UO9YmGGGBfm/radZcgkGtaB69LnGuAkb84058o0B36mZuNgCJcr0oCax/U/iIchc/fdcqVY8ndLSabBA8mZjRCiYycBhlZKrOzypQ1PwOF9B1BlUQ2AALts67HBDVlM8t6JmT4cf1P4bGp3UQCTRZ9ZvsiWMnz7F70jxfQn0GL9gIlmSsfCUbCPATRPh7U9SGcaVDDFlqVqEJ0XzLK/Afj7TOlBJsZxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92zov0C+uB9MOBT16ijczFGM5kBkTH2zO13odElRvVM=;
 b=cVUnd/VBvvkxMiKu2/+oTh1uGFW5Ul7HdI7m1q6hqL5hsk56YI3zuxtJXCSkr9bqWYDz4OygblMquqmKp5tc601ZUxSPgglCjt2QbzcA9yQDBnyWtLSg6NidAKFlQmlqicPPLELuy5Tu3R2wdpEmPDrK1Tt7GZsuCn+Q43ENutth9ZSuoX7D6A5xO7qrOH5kusbXvvDwEYDQ2GblbPhLLgTp+cYcdLPTjRLZhPu8hL64KZqJW1zwu11rb+sYMEDtah0rXlMotTVoK8V4nS7OYpayYEZssBhmeajNneSh5z+XR9yKT5oJSmKMR8SB/ePdpNN1TFOAQen9VGCpIEKm0A==
Received: from DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) by AS2PR10MB7180.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:60c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 15:14:07 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::44) by DUZPR01CA0029.outlook.office365.com
 (2603:10a6:10:46b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 15:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 15:14:07 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:16 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:05 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 13 Nov 2025 16:14:06 +0100
Subject: [PATCH v2 15/16] arm64: dts: st: Add green and orange LED for
 stm32mp257f-dk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251113-upstream_update_led_nodes-v2-15-45090db9e2e5@foss.st.com>
References: <20251113-upstream_update_led_nodes-v2-0-45090db9e2e5@foss.st.com>
In-Reply-To: <20251113-upstream_update_led_nodes-v2-0-45090db9e2e5@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8A:EE_|AS2PR10MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: cce7a976-d195-489e-56aa-08de22c74a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkdjaUJpc1VlWjk2cUQ5dzZ4SFEweHNwVEMxNWl0ZXJwN245Z1Q3TGNUMjFm?=
 =?utf-8?B?QUQ4RHV0ejlvcmVIdi9NUHh4Q0lMdW5tWVlpa1lvN1BnM0U2RlZydC9RQlUr?=
 =?utf-8?B?VXR6OGkyeW5CV01pNTNBNWk5RFpHWGlRY0JGaFYxYU5JM01uVGhweis2RGwx?=
 =?utf-8?B?WHJhWFNvLzAyVTJoYW53OFpkalpvQ0l1aXN2Z25yQ0VKYWhKSXBQZEROZEh0?=
 =?utf-8?B?YXdtdGdUeU95a2FEcWlGdXg2V05oajNQVGpwM1ZzUkkzVFcxdU1mYVB2cWVu?=
 =?utf-8?B?bGZJTEZ5OGtERk9TWEkrRk9kcG1aclJjUmFuL0c2NWcvU0JPYmdHZmZ4OWxJ?=
 =?utf-8?B?YldnK1dya2Rwa2hIU0ZLajhzNXVQcE5iYjVzZUdRYXVqTVVOV3NwbmNXdjhT?=
 =?utf-8?B?QnQ0c2oyN3ZaeU9ybXE4WnZmbjVVZi95WS83R2l6Q3Y3YzJJQ01scVJXRGI0?=
 =?utf-8?B?Qk5HSWErQXNlOFh2WHJLdys4eW1VRTFzV2lWdTY2dEY5bVh0aXNiQnFjdUQ5?=
 =?utf-8?B?YWV2Rnl3cnpuSDlNZ1ZZNFRLeUFXTkRWT3VraVhaOEVyb1pDdkZhZ3phN1RN?=
 =?utf-8?B?bG5RYU91a2dnRXk0NklxdVNYMWx2ZVFqc3luaHBQcXNzcjFKWWo0UkViY2FY?=
 =?utf-8?B?SERWZDFTY2pYZVRpYVNseFJJNXFMYWFJNUVWanRmWVMyajRYVkt0MUc1aG9C?=
 =?utf-8?B?bEZLNTl6Rll3ZXRZOTNtbWtqZEVIc2VYbG5mK01vRmRGakFiOEpURDFkYmx5?=
 =?utf-8?B?K0JWeUE1RStwRE56YlY4dFM4VXVPV2UwdDdIN0dVNUFXZkV1bUpaZHBKMURy?=
 =?utf-8?B?Z0M4Ynl0a1k4R3VPaVRHMkpabm1neEh5WXpJbHQ3WVd6Y05mMTVmUVZmYWtn?=
 =?utf-8?B?eHV2L0FJM2NvR1VlTktoU1Z0Qk1JOUdXWkhEZU5jNmlBeUFVZzNNVUFTTmpM?=
 =?utf-8?B?d2JQQ0VQSS9Za0o2T1dPYXFjYWdvcVVHVzJON1czVFY5cHAxNGQ1eDAwMWdP?=
 =?utf-8?B?ZkR0OEw0SjluU1V4Y2RvMnFyS3VMTmJrV2JBN3BRdURoQys5Vml2M2htTDlm?=
 =?utf-8?B?UTk1NWFZVGRuZlB0RXVrNUoxVDZ6VlA4UHovY09JS0VwNHo5NFlVVmVTTmxw?=
 =?utf-8?B?YkljTzhxY3RONzIxekhZQnhPanNsU2Q4TFpsTldJY2VCYXVhcjY4c0lLTWNB?=
 =?utf-8?B?MHhJMFlrR2xPWmU3VG9ZdUlKNUdPdXhmWWdoNjBHUFpnbDVjcDgzUlVKOFNE?=
 =?utf-8?B?NTM4MFZSNHUrZE1LUWhoeGNlbUsxU1BHeHhKS0FNUVdrR2VJR1U2dkJ3QW91?=
 =?utf-8?B?LzhjU3FoUFl0SEpBVUFwYWRDclJWUEwvYW1YbVpDSGJ4TU5NaFR3SWdidm9S?=
 =?utf-8?B?VzU2ai9mVjBXZ1BsdUd5V01iOGxNcjJacHlvMFVyNkdUYVU1cVcveThZOEJ3?=
 =?utf-8?B?YytxeE5abVQxWmxHbTRCd3FoenVtbDJZUmZUOHRBeTFGWmtWWC84UjRxWmN0?=
 =?utf-8?B?Qm5kclJiMFB0U2MxTDRrZHBOZjNQTWd1d0NLK3QxMnQ0UW1xR2dVVXhvZEtm?=
 =?utf-8?B?d0gwNTExbkd5T1dONncwV2tHd28wOGZqZEU1WWtlK0tnVWxialVQck9EQXA0?=
 =?utf-8?B?TkZZM1R0dXZwVVJYbVBaalVncEpaY1hQbWRaMjNQRGhhRlh3a0RmdzgrQ3VF?=
 =?utf-8?B?cHF4dGR1cGF5NUF3RjNRc3ppM0EzYkRkV3FEemZidnEvWDlmRXlmbFU4a2xW?=
 =?utf-8?B?T0xTZXJkL2dtWWVqaElRWThkMU5RMHlCb3lIekZOb2pkMFBMc205S211Z0NE?=
 =?utf-8?B?SXc0SGxET3pOeUV1c25NcnZMSFdOYWkzMmFkOENhMzRQVWwrL1Y4MTc2VlBO?=
 =?utf-8?B?eSs4RzhCeFQvdUNDYTFRNThXUGxuckJBOFNHM0dIK2hZVG5RQnBiT3E4NnlT?=
 =?utf-8?B?aFBNUTRJMVpieEFiTkp6cTFGR0Z4ZGJaa0NiVmd4Q0ZQZys3c013QUdtNXQx?=
 =?utf-8?B?QTVaRzI3bkw3dXA5UEFqdkowSXZrZzNXeTUwZWRzMEdXZmlKYmRXa1BhZEth?=
 =?utf-8?B?UVh3dlJqSjYybWx3eXg4aG9lazE0NlNON1RQLzc1ZUxlV0pIRUpYcFVKLzkw?=
 =?utf-8?Q?Xa+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:14:07.5935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce7a976-d195-489e-56aa-08de22c74a81
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7180
X-Proofpoint-GUID: LeAKTTYON2c8f5LpJy_21gx5R7NHC-rB
X-Authority-Analysis: v=2.4 cv=M/FA6iws c=1 sm=1 tr=0 ts=6915f5c8 cx=c_pps
 a=XUW+b4G2ANNWtaUD5ifWjQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=8OzEVrWVIK6RD9uD4J4A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNyBTYWx0ZWRfX7lNgWszJQyyr
 QYXGO3/oPP5qYqqw5x4POiTTWKVEofEdGWCXHIkaYJHg6v2GQFRIvHUS98svSM+R53zJ5Zda1Vo
 15n6onaaRgGtcJnaXvlkcqYD4AEAdWRHtBRJy6AlL8DMZJiAXODgikdignBeTDwXbf6jESTn7p4
 wk3+8FpFfsKUhN/klczDaAYwDzSDpj7BuZckqn3l9UJDt2Ln6g3CBtp280XhY6EncTQZkf622vH
 1YOF/Nz/mQjSzF57VIQ2Telt3+XOrITEVu+F5IhdMnHnDV61hWQ20vEbHlvv+1rSCZWPRSr1m55
 z4ILBn+VkMF+GsR5iBXOII/pjaSpDvyPRo0NuBZL1bKRq8E959uHRHWEhEexGboH8F8AGysY0Nb
 3iQSOItTlsidxhKcYJGV4ggGfy/n3Q==
X-Proofpoint-ORIG-GUID: LeAKTTYON2c8f5LpJy_21gx5R7NHC-rB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130117

Add green and orange LED support on stm32mp235f-dk board.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index e718d888ce21..dc1a75f10f49 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -53,6 +53,16 @@ led-blue {
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
+
+		led-green {
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioh 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-orange {
+			color = <LED_COLOR_ID_ORANGE>;
+			gpios = <&gpioh 6 GPIO_ACTIVE_HIGH>;
+		};
 	};
 
 	memory@80000000 {

-- 
2.43.0


