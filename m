Return-Path: <linux-kernel+bounces-897007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD1CC51C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937041896197
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23466309DC6;
	Wed, 12 Nov 2025 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LebLZwjv"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB402D8DB1;
	Wed, 12 Nov 2025 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944459; cv=fail; b=oMN+uatga8gw+KMZ4NfUL8PXNgEiIak/tfRVL4wx0GJL0LISvFBJhbJ640cDuMK0UfQqI5UgKAsBWI18NJaqDiRyTcpTolAZew39trdf8G9B7yaHHL5mUq38R5V8nXWFoOg3emHUHp209yEkpIjFbq2DII5X5u+o349dCZseVWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944459; c=relaxed/simple;
	bh=FFZ8TxbdgnCksc9ja57FCXTgy8xDeLloWUEePs0vZiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KtrcXDiPiG7Sva1hHyfVnUVZXowF+Ox6o4fwMiiJRwynfprVbttMW3rdYYxoH0DwPR20drnhvZFjFDCczilJ+9/qv/ZCCx2heRTR+/eC/omNtmmoHp4zXGR26gfiP6shPuDz9RUU4lagk83517nSmYICQRc1Kvh8wOCiBzUNQBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LebLZwjv; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACAgaLV959029;
	Wed, 12 Nov 2025 11:47:12 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acret83pc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:47:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCUOgOoPh+lh0tw2Stv3INKazmq6SGjxxxfxqrcwgrGrucpCKIuqKEbOTEb2nezHYeIbxw91dWn4dUxcS+nmacZaDgxnfDFLrjCyPw1rBDHQwd+Y+n1+hoqk+z/cPREENPGXD7YKH62BSwR2rV0d0VSY2LSz7F6vsJEqUPq+0zo2QU1Xf+d/2Shc5+GoFX1/7DhAr14+E5mrx9/o0TjdfODUpGpazhV9XJz793KWGHD0kJRDoLdqxX8yF4HEBb0l81nUOa2Q9NmtfGONQiqTJpxX3veOqYRXwbWhX5zt6adXUORYO6UYx9+KdN9aBo+uTEr8fFKS2TDYD/qHdCK5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YExCqRFrfDEsaunpy04sLQ8JOdIM85t5EPyjuyqYBAU=;
 b=K+H6J8kgD6puyA3b0rZ7lcO4jUDHVNoYAGB0mKp631db6uCmb9U6UvTGXm9sibrCNP/z8Z7g6HUlbloo+jJn7QQBIW2OkF16ni/PbkJccdb0OXd25ACqRXyytldmPMESC2t+NERRTpEQFu8KE3oKO4Bsr1eQc/lzxyOieCtzcZqLAKtH51fjNJfSV60t3FdCZurEwBulKCH7EPWe/ENQlE4i4fLFY+ms6HrLgI9zAh4P38riata14AFTjKGWx2HGyiarrhE0VvMGFLBL7GatTU63tKgzgm6TpBWRVJs1+ZP80WYWFMfu7opAGIgvP4BVDLuur+m6URn+9yMnucX3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YExCqRFrfDEsaunpy04sLQ8JOdIM85t5EPyjuyqYBAU=;
 b=LebLZwjvZ+A0e/3PyufKKK4Ue4aE9l30zTShzotXGxmEeMLHsisoXlbx3XYR+GWlu5XRSXw0WFXK6Y/k7iIA2QeelHn5Lo0bLkTT1qCgGimx4SvXhin0TLw8K4Mk1bsyqEzTqy/zrt1SHOeyFGIRV4H1nJ7GzVDv6TWBsbAlOBT6QZWZevg18BeKuLK8uISkVFXWNkF8eawfYDCB3HStq7HJhdNaTf08Az8m8Tm5HZKNzkMRjJHmusyr01LX9DAy+0AqbExoIncmm6siquSfUUS5Uj/0Jffi9Gj/T2huxor4uWd69mgG07SPR5qh9ulP+S2zBP3uQCb3QYNbnXzJyw==
Received: from AS4PR10CA0012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::15)
 by GVXPR10MB8180.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:119::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 10:47:07 +0000
Received: from AM2PEPF0001C70D.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::e0) by AS4PR10CA0012.outlook.office365.com
 (2603:10a6:20b:5dc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 10:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF0001C70D.mail.protection.outlook.com (10.167.16.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 10:47:07 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 11:47:17 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 11:47:06 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 11:46:45 +0100
Subject: [PATCH 3/6] ARM: dts: stm32: Add boot phase tags for
 STMicroelectronics h7 boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_uboot_properties-v1-3-0b19133710e3@foss.st.com>
References: <20251112-upstream_uboot_properties-v1-0-0b19133710e3@foss.st.com>
In-Reply-To: <20251112-upstream_uboot_properties-v1-0-0b19133710e3@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70D:EE_|GVXPR10MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb62db1-4fe9-4427-1b6c-08de21d8d32f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHlQK3duMFphTncrVXRhRWJOajg3L21qTjFpYjIrVkJXZnFGT05SSlp4WjZQ?=
 =?utf-8?B?VGRuOEJWQ1doamU0VzZacDJTeU01cy9PR3FiYmFFcE9NSEdoRnlYZHRVZlFp?=
 =?utf-8?B?ZW5SRGVLV0paS2lrMmFMYlAwQ2tmeXRMVnBkVWc3ZENTaXJEeEJEU1FmY3Vx?=
 =?utf-8?B?czJBS0wrb1o2RWpoYi80L3EyTk1NSGk2WUtNMVgrQmRxYllxNWFQR08rK2xE?=
 =?utf-8?B?TnhqNUpjNytLT1FaSE5kaE5wRjZlTU1wczF3MEsxR05FZVNiOW5XZnJ0YXk5?=
 =?utf-8?B?QjhYQkpMM1l6OFQ4Q05pWHNIbkpUVnJuRlhheTZRMDZIWDFwUkZ1WGVGWmNB?=
 =?utf-8?B?Z1VmTEh1QTduUXIvUEFSWXBIOUw2OS9qajVPeWFCTUtBMDlTdzkyMnd2azVm?=
 =?utf-8?B?UUNkZ3djRnA2c1A1WjlmVXNTT2R2UXNoSTRYbmdISGhDL1R3UGl3ZTFqMGxX?=
 =?utf-8?B?NGh0YzVyeW9xRlp1cnZWTjltcmRNeWlJWGlmMnM0b2RYZVhJRzdFMnBjUmVC?=
 =?utf-8?B?UzJqcEgrdGxIbjU4Zi8xaENSaGNEYm8rdzFRM29waDlFNVl0bXR0RkhocE1T?=
 =?utf-8?B?Y2lDam9iU2EvdW9UTkdha2Q1ZXJwVDVabjdXMHhGem9YM0FmR1JINVpsYmZF?=
 =?utf-8?B?MU5GM2tjd0FjckxhcmRMSVVVQnliWExQbU1JcXBmZmQvbDBsTXNQYjY1V0s5?=
 =?utf-8?B?aUhxaFk3LzBDV1RyemFiUnZZc1V6YUlxRHgzL2oydU1Vbk1aMzRYWVdITXFH?=
 =?utf-8?B?NFBMS1ZmdmROd3BCRlh6SXlWTU9UTzBkN2pDdm1NSDFDdTJpK1VadmZyQ2hL?=
 =?utf-8?B?STRrV3d1VWF1aXV6WlNMb3pGNFQ2Nkc3WXMvd1ZWaG5nUVpxazA0TUxxSUxC?=
 =?utf-8?B?UUppeWhLMzdrY2V5VHNtYk5hWUdqRzJkbFVoeWFJdm15bXVFSUV2VHdqZmIv?=
 =?utf-8?B?K0xhYjBMaXQ2L3k5ZzY0bmlQaGVVQVFNclJMSUJ6a3lYSUJ2WGRGamIrbzFI?=
 =?utf-8?B?ZjNrWTRwbm1TTzFUd2dhR1QyYlo4NjhyWVRJU2tRZHg4a0M5VlVNbWZ2T3VM?=
 =?utf-8?B?UWVReWhYVS9STzBua0JIcmZkK1RCZHhjZ2I2cjE4V0NDWDdrN0NoSU5mNnNo?=
 =?utf-8?B?UWlmcmhVdDkxbTl3MWJTWXNUVTlIeGdxQUdwbHJxMTI5ei9HVFRaSy9pWGJE?=
 =?utf-8?B?eVdXUmF2SzFxS2VrTkN3bW9MYlpFNVNCZlF5dWpOR0U2V0VoL3F4eGNlODNF?=
 =?utf-8?B?Y3MrTmFnRVRCdmVST1hEaVMvTENHNWQzVSszVFFTR1hwdW9sT3VTeUlYWkp0?=
 =?utf-8?B?M29Oc04wODhHNFdTZDc5ZUpMZnZycGpVVGd5YTNLU2NLU2Q2dFdPc1U5ZzNU?=
 =?utf-8?B?cTlwZ3R3bVFjQmhSdGxYZUJRS2k4K0RDTTE2RW44VnlwZm1rM0VJZ3V3dUll?=
 =?utf-8?B?S1ZYR2ZSenEzQWZENEFBT3dUQW1DZnE4VzUzY0hQNXUwNzFmYnZpaEgzSS9z?=
 =?utf-8?B?cTgxMEhYVTE1blE0bnJ0WmY4TXdna2U3TERtLzN4ZXRjTHZtTTI4UU90YUFl?=
 =?utf-8?B?eGk2cHgyZWV6MFBnak1sOGM2KzR2dDNqYWhKUnlKSjdZNHc0TGxsNjd0NFIr?=
 =?utf-8?B?U0RtRGdBOHRMenF1Wk1hbUM3UjltaytPdmdOdHBUVVdvRmE2aHBKNHI2NjBO?=
 =?utf-8?B?UnkxZlhUK2gyNWJUK0Q4L213UmZiQTY0SlN2V0dkOGsxSE5FdkNVbis2TFBk?=
 =?utf-8?B?b0lFV3dteDRMQWRwTW1tZGM2Zy8vZC9sQkRzYzByVU9TRkpYN3J5MUJBRFYx?=
 =?utf-8?B?QW9Nc1g4L1I0UDVYbGl4enY4NTkrVndlS1dROEtIcHVkUzd6MzlURVE2ck5Z?=
 =?utf-8?B?N0ptNk16T1cxVitYcFhPYytNVkFaZHdvUHRZY2grcExtdnVXQ245TG9VU2dt?=
 =?utf-8?B?Umt1QVAzUXR4YmgzcURBV3JXb2lYenJMZmRXaHpsNjcrOXhXNXlYejNrSmRQ?=
 =?utf-8?B?aG1QRWlQTVV1ZC9XNVhzaTJWT0g2UzduNXozbFZGcjU4a01UcTUrSEdsRlhL?=
 =?utf-8?B?N3RjZkk5dVZtU2kyQktRQzVkZFZ0RlBZTVU0RzNkNGI3UUxiL2x5NGxVcnFr?=
 =?utf-8?Q?dDek=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:47:07.2102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb62db1-4fe9-4427-1b6c-08de21d8d32f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8180
X-Proofpoint-GUID: PZIn1dgtV0UMiy8EnYGk1DoC-Jqg8VB5
X-Proofpoint-ORIG-GUID: PZIn1dgtV0UMiy8EnYGk1DoC-Jqg8VB5
X-Authority-Analysis: v=2.4 cv=SMNPlevH c=1 sm=1 tr=0 ts=691465af cx=c_pps
 a=gXrl5TodGbHmua8ggoz7cw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=HILBdA-kGuq4vTFu6uoA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4NiBTYWx0ZWRfX/CNlK3ZfEzbg
 B+Ffi7mTmlycEvUpS0QzF05tCERVA1QSaRs/gZKTpy4zb7rtBOW9gKYKzOfcZuPaRg5Ps3zGENu
 7rXxIPRDcI4bBqKHcvM02Mz3dQtGhudmBxK6uD++UxWDu4FYQjJYB6aJRfell+WxD8RSFcUmDCl
 iBk+YxOtY9Kiib5XZeXPxcbS4IGCFpK1nwD0TdK/6N97adONMteBODFki8OQ6Zm4pWKJ6nUdFja
 ZRVgx7GhHCh+jBMiyqEBjXpMLzdh4hCzg8jWAsxCpiS/6V0wK1NkkqPlWLH0GOdKrRzenHfUKA9
 /yBIRqLOj5aUFPBEcZtnoU8P6lDTppSw9l6uEBlg38j0uOtn1GCGq54cBkV/fh6zwvTz/6GSker
 ioWuXN+DyYsHglD/JzcqAmL6ujbl+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120086

The bootph-all flag was introduced in dt-schema
(dtschema/schemas/bootph.yaml) to define node usage across
different boot phases.

To ensure SD boot, timer, gpio, syscfg, clock and uart nodes need to be
present in all boot stages, so add missing bootph-all phase flag
to these nodes to support SD boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32h743.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32h743.dtsi b/arch/arm/boot/dts/st/stm32h743.dtsi
index 2f19cfbc57ad..790e4558c905 100644
--- a/arch/arm/boot/dts/st/stm32h743.dtsi
+++ b/arch/arm/boot/dts/st/stm32h743.dtsi
@@ -50,22 +50,26 @@ / {
 	#size-cells = <1>;
 
 	clocks {
+		bootph-all;
 		clk_hse: clk-hse {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <0>;
+			bootph-all;
 		};
 
 		clk_lse: clk-lse {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
+			bootph-all;
 		};
 
 		clk_i2s: i2s_ckin {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <0>;
+			bootph-all;
 		};
 	};
 
@@ -75,6 +79,7 @@ timer5: timer@40000c00 {
 			reg = <0x40000c00 0x400>;
 			interrupts = <50>;
 			clocks = <&rcc TIM5_CK>;
+			bootph-all;
 		};
 
 		lptimer1: timer@40002400 {
@@ -547,11 +552,13 @@ rcc: reset-clock-controller@58024400 {
 			#reset-cells = <1>;
 			clocks = <&clk_hse>, <&clk_lse>, <&clk_i2s>;
 			st,syscfg = <&pwrcfg>;
+			bootph-all;
 		};
 
 		pwrcfg: power-config@58024800 {
 			compatible = "st,stm32-power-config", "syscon";
 			reg = <0x58024800 0x400>;
+			bootph-all;
 		};
 
 		adc_3: adc@58026000 {
@@ -596,6 +603,7 @@ pinctrl: pinctrl@58020000 {
 			ranges = <0 0x58020000 0x3000>;
 			interrupt-parent = <&exti>;
 			st,syscfg = <&syscfg 0x8>;
+			bootph-all;
 
 			gpioa: gpio@58020000 {
 				gpio-controller;
@@ -607,6 +615,7 @@ gpioa: gpio@58020000 {
 				#interrupt-cells = <2>;
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 0 16>;
+				bootph-all;
 			};
 
 			gpiob: gpio@58020400 {
@@ -619,6 +628,7 @@ gpiob: gpio@58020400 {
 				#interrupt-cells = <2>;
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 16 16>;
+				bootph-all;
 			};
 
 			gpioc: gpio@58020800 {
@@ -631,6 +641,7 @@ gpioc: gpio@58020800 {
 				#interrupt-cells = <2>;
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 32 16>;
+				bootph-all;
 			};
 
 			gpiod: gpio@58020c00 {
@@ -643,6 +654,7 @@ gpiod: gpio@58020c00 {
 				#interrupt-cells = <2>;
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 48 16>;
+				bootph-all;
 			};
 
 			gpioe: gpio@58021000 {
@@ -655,6 +667,7 @@ gpioe: gpio@58021000 {
 				#interrupt-cells = <2>;
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 64 16>;
+				bootph-all;
 			};
 
 			gpiof: gpio@58021400 {
@@ -667,6 +680,7 @@ gpiof: gpio@58021400 {
 				#interrupt-cells = <2>;
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 80 16>;
+				bootph-all;
 			};
 
 			gpiog: gpio@58021800 {
@@ -679,6 +693,7 @@ gpiog: gpio@58021800 {
 				#interrupt-cells = <2>;
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 96 16>;
+				bootph-all;
 			};
 
 			gpioh: gpio@58021c00 {
@@ -691,6 +706,7 @@ gpioh: gpio@58021c00 {
 				#interrupt-cells = <2>;
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 112 16>;
+				bootph-all;
 			};
 
 			gpioi: gpio@58022000 {
@@ -703,6 +719,7 @@ gpioi: gpio@58022000 {
 				#interrupt-cells = <2>;
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 128 16>;
+				bootph-all;
 			};
 
 			gpioj: gpio@58022400 {
@@ -715,6 +732,7 @@ gpioj: gpio@58022400 {
 				#interrupt-cells = <2>;
 				ngpios = <16>;
 				gpio-ranges = <&pinctrl 0 144 16>;
+				bootph-all;
 			};
 
 			gpiok: gpio@58022800 {
@@ -727,6 +745,7 @@ gpiok: gpio@58022800 {
 				#interrupt-cells = <2>;
 				ngpios = <8>;
 				gpio-ranges = <&pinctrl 0 160 8>;
+				bootph-all;
 			};
 		};
 	};

-- 
2.43.0


