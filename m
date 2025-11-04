Return-Path: <linux-kernel+bounces-884854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B2DC31535
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEA918C36A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BB1329C60;
	Tue,  4 Nov 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KA2oyzlt"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138B328B65;
	Tue,  4 Nov 2025 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264542; cv=fail; b=qzMW21eFOHku/DmrqR87VPIwveURq4M0Bcpgq1IMGmaHbpEEAndC3hvHdptgtoQQRi6JnUdMWw0w3TBVo3Z06taRhDTtGAOR4cSDZzltaL0brz4QQI3yZqPafyqk2tgy5fYtiC7EITrs+ULw2vEsP5uqyEcRrVyDOPEwWyjInJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264542; c=relaxed/simple;
	bh=PF2+rUvnZ3yGUpQfW/s3zasXBkJykW+P0E4pcl+YV+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cZGsgFXOYEW/aN+E5k11t811fzDp+q4ZKPtD3GCkTNpAA7R/eVhxckmbBZo/+1aRbo8RAV1wlFlayUqY5q5GgkvAbgp6SvlRpcfCFtFLjemRW6OJNqeqQWmemdTvE0NYkmHXGv5gvUoYPOJSEHYzItNqn9mkn1UjZ9ps704xEEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KA2oyzlt; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4DpGTI856660;
	Tue, 4 Nov 2025 14:55:17 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a7gca0ty9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 14:55:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtTJ6XwlYTNfoQEK2WigGq1XJWbb43MKiyDSed3/X24EFxImut1C6N30eZyu+C4JveRm1O4oMbEnnp8GG07RkWxGOic7D3eLoT78yU9/Bpfhk5HKjTJBWSz36hQl+rSY0c9YyBIEDz17iLtw+227pW1Rr8JE2TvX57SXgKSWlb+tjCH9qfQjsPaCi6sY04zPbc+1CWhSNXCYN7RlfB/A0zH8dxaWHfNpc5559FAtSc6BV/d72TSivHveJ2Q9W9lTewNmLMSEe/fDSNzG0CZ2hIM/L78Ya0xywsBzPUzjNZXeWIfY/YHBLt15xCyoSvVSEi+edHs/zi/CFkUFQRCCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnMnLyaSfgXfaAXGbcNIAF5e/R+NghiMfeONrrTYVxs=;
 b=tkkNpFs7wtc17NrEnCOiEG30iXYa4SewFm9kWVggUsTjm+U0mr8kF+yfieOXtrzHMN2hrm2WZKGaSjo12SHMJ7IEbIZIazzVCNQPJoMKZWELs3wzZIGFQolJc2lNjdKiZlgjq7i+XSX4liHB353JBj7eH7oCBpfZ86x/+DnL9zitn3+dHRuC1VwsKAf9mQv58COP45SqJMFuuh88eu2oe6Og9+4VfekKaHqZlBCpHoHSRLOd5GjKAL6qBugFNFKz4RpQF0ARktgNfio1TiuXXgnbZV22jlNWhUC69Ewe7W0Mth+etNZR3oJYw2Y0q1eV64kBBL2VNnV7K00Ff8kETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnMnLyaSfgXfaAXGbcNIAF5e/R+NghiMfeONrrTYVxs=;
 b=KA2oyzlt1lAxL8OhT3raB9u3q7wB7v5P8vmxjtX8LJ97HOQP8R1t/AQ7bJ67vjtqSlqN+BGJ4WenY56V21lftTnm+NNVKmS2EnUPae2F4QZRZKhtGP7E/iYpq3WPvDRxH9O0AApdc2fRSqtGrYTFmaX4PjE98Ho/ZS7PpTqGYgj+D1x1XnW59yX0cXCZy054Dvyv5CqOWEQcd3Y4+YcJpot01Sl/V/R21U5lKKlIsFY9Y0mabTaKHUrZRFoHCTWaVmhzD2rVt+yYEVvetcjbBJoxGAIn4asKhcDCEkfsE2G1GCbnwnyEhr5zqOQG+ilTsDyoO3A/SYQkDknXVcAqXQ==
Received: from DUZPR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::17) by AS4PR10MB6112.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:584::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 13:55:10 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::69) by DUZPR01CA0023.outlook.office365.com
 (2603:10a6:10:46b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 13:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 4 Nov 2025 13:55:10 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 14:55:01 +0100
Received: from localhost (10.48.87.185) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 4 Nov
 2025 14:54:50 +0100
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Tue, 4 Nov 2025 14:54:12 +0100
Subject: [PATCH 3/3] bus: rifsc: add debugfs entry to dump the firewall
 configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251104-rifsc_debugfs-v1-3-7ebdfbf8d33f@foss.st.com>
References: <20251104-rifsc_debugfs-v1-0-7ebdfbf8d33f@foss.st.com>
In-Reply-To: <20251104-rifsc_debugfs-v1-0-7ebdfbf8d33f@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFF:EE_|AS4PR10MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a3c092-cdc0-4fd0-8482-08de1ba9c512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1ZOMCtDc1Y5SEN6TmZjdnlLSVhjOFpXOVdUdy8zVzVtdWtzZGp5Ym9OU25n?=
 =?utf-8?B?SWN5SWRrM0NycEZ5dHhLNis2SE94TVJWd2JxU1A1SlVqRFh4dEdHVzcybmpm?=
 =?utf-8?B?LzdFZTJHbXU2NE02Qk1BM1c5bkUxQXl3QU9lUjFtN0dpMWgzLzJ3TGw4VTBW?=
 =?utf-8?B?VkhrQjNJYVMvOWZvMTh0WnJ6UlVCb21ZWnIwQzc3czVQd3B0K1pCTTZkTHJV?=
 =?utf-8?B?QzVFYzArYjNJQnN5M29hZjR4U1ZnRnMyYzAxRzdzVEZEaHFyOEV2N1dvemVm?=
 =?utf-8?B?Q0EydVpKSVRCZnZFenh6QkxTWUF6eVlGbkltaDYzM1hiU3NhSENsVGRWdUll?=
 =?utf-8?B?TnN5QTlVQjVZVWx0cC9ZdlFFU2F6VDlydjFXYVk4SUNFcUtpY1ludUNvRjRL?=
 =?utf-8?B?YTc5cG5SeHFaWURUMnYwbndGdytTN1EvMUhJaVd0Ti9QdDlwZDRPZU94OTVG?=
 =?utf-8?B?NFl5VlFGSDBYTm5ZNzZLN291dmNNcGFtbnZPaU1iSHI3QmpadExtME9aaWt2?=
 =?utf-8?B?NkxUWVZ0QXRxcjhyNGw1UnJHbm1JYWd1SThQaHRqZ0NVUUExWmp2VExsVnd4?=
 =?utf-8?B?THV1bUlsUWN6RTNtcm4rOXpyZ2EyanVqb2svNk1zVzFZbEFoM3QvaFZYR0J1?=
 =?utf-8?B?OFhhYVBJYXZMbkdITHlnaEU2VitpeTRHMVBtcURyUDJFTTAyNjQvVTM4c0l3?=
 =?utf-8?B?RjBFU1BFUVg0QmIxTW9mTFc2eWdMelI2YUNUcVczbEZiMXFrazd4Q2RzL2Jv?=
 =?utf-8?B?MmlBTW5CejJ0K0h1VE1PbTFVdWVJN1hkZ0IvWGlIeXphMWhTQjdlZjBidC9s?=
 =?utf-8?B?NGRUM0J1YmV3a09HOU9wWkphUVhVc1c2YytLNzl6M0oxa09VUzhKYVJYdTlx?=
 =?utf-8?B?ZGhpc1QzQjdhSzR1SkhneGJ0S0FqeFhXMklNd2xOM2pjbU02SWN3djJ1QStJ?=
 =?utf-8?B?QUJoZ05TTm1JejlHSkxwZUEwaDIvMVhmQnMrN04yZmFXc1pEVDZPMHEvOUxy?=
 =?utf-8?B?NHZVMks2dGxleC9BV3RaV0xGalJ2Q0I5SzRjeWpwbjUrSlpJNDF4YjhuREVW?=
 =?utf-8?B?VFFPUGgzMTQ5WWlma04wN0NnTmRBS2VqQ1pZeXNiTkJiN1FXa3BnWitlUjZC?=
 =?utf-8?B?WW1DQ0s3cm12Nmh1eXlyUFArazUxdGtFRDlIR2JudEp1WWpiMytTMkxDYVhs?=
 =?utf-8?B?aWxXa0tHMWlEQTNCdzZyWGNjYmRxclJPRjBNMlpQeTJBNFJQZE1TcVJWdnU3?=
 =?utf-8?B?cVZURUZDbXJLTHdBVm02ejEwVDF0TVdmNXhjSWw3SmdKNERrUy9VSjZVMU1z?=
 =?utf-8?B?MStjOWt4c2k4WDNjU1FqMmIzMHYyb21uL1NjMnFIbjN6eWdDZWtOTlNGNUVq?=
 =?utf-8?B?SjIzb29BemtSa3RTMFhHcnhKV05zRUNEV2JoRzA2SzBtaE1UZ2s1aEREQk5p?=
 =?utf-8?B?Z2gyazZhV1o2TWNIMXZFZ1R0UEJqUWQyWFVMaVJiSEwySkswZmVUZjZsNklQ?=
 =?utf-8?B?NCtsblY0RklLemlvdGJXTHkvYURFR2ZsdFRtMU9hZ2RVMEV2a2FxQTVzRnJz?=
 =?utf-8?B?Mmx2QWRIMFRZQlg1eHdtMjFiQ1AwU2Nac0ZpSktPZFo3SUtsc0tVL2Q3SDJO?=
 =?utf-8?B?UlM4S0NRWlJka3FnaVdSZ2F5eHc0VU5ZeGUwcHRIeXV6Zm9TSXUxejRZV3pn?=
 =?utf-8?B?b0JTWjhVSWJ1dHJ0ZzJGRisvRHJQODFEMGFCd1ZsbmVKcDlvLzIzeVlaN2s4?=
 =?utf-8?B?N3ZzYXpybVduTjlTZ3ZDYUV2NytXN0ZVbXhvSkJKMVZsMTNuc3RnUnpkbklT?=
 =?utf-8?B?NWhZZ3QrNEYzc0hoWE5MeDlQYkVTTVdSb25xb0hJeXQrKzdTQTBQZ2NQdm0x?=
 =?utf-8?B?OFdJempwZGVGQmxjSGllUWEwbnZlNkxWT3UzVzIxeDhqcW8wM1ZqN2JIcEJv?=
 =?utf-8?B?N3VadGxUV0twb25WSFdJVEE0Y3FwS21sbVVkREMwVVNDaXhlMlNpUUJJUzhw?=
 =?utf-8?B?OFhNdVhxTFZYTTFmQ3dXWGd2WUFEcklMUEI4N0FuYWE0UUFJZ29ZM0tnMXVk?=
 =?utf-8?B?Mmo0am5OQ0FEOS9KZVdLR3ozclBCQk9XRnppOWFON0doTFFDMU5LNGpuOFdM?=
 =?utf-8?Q?vqXY=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:55:10.1878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a3c092-cdc0-4fd0-8482-08de1ba9c512
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDExNiBTYWx0ZWRfX8sffHCtbus8A
 KDCKWYNHGwbirfob+sKCXWzLA0UZulQA5oRqtIqxR1nitoaoTbounpQvB4iXUH1nFNX6Li9sbwO
 RezHvW3yZ6Peo2BwZLSWCnprN62mhqUJOdJObAVW3fL1VMJ0cg0vlvJjVFNAbI+/UgHGlaRDKNw
 XNxgXYV+helg1ULBEitWXv4EUP/lIboxXB2Bcpo9Ode4aVoYDw7horjDaDLwgR8uj3KnuUJhYOq
 juWeHiWqhLUuzg8TPG5qp4aDMnmh6tH2rDevY8xAdaRcEH+oUUk1Q+3sdVkTPzie/JOqI3ENEvl
 40f9Eog9upoAw566z7xdVm82BoMYWlkV0OqiBAfx+xQZEc/kI2IY9e9m0HvawTRID2JJ/dBn5cG
 4rtV1Owoh4Hk9eC+/bd+d9FCYPJyJg==
X-Authority-Analysis: v=2.4 cv=EpzfbCcA c=1 sm=1 tr=0 ts=690a05c5 cx=c_pps
 a=dNrFwgn0Rq8ysk2JmkLJkw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Wpbxt3t0qq0A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=sv003Xou3s-jQteCACwA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: KA2AP-O8-Wz5xjKDlz6awBmuWgj7DBDY
X-Proofpoint-ORIG-GUID: KA2AP-O8-Wz5xjKDlz6awBmuWgj7DBDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040116

RIFSC configuration can be difficult to debug. Add a debugfs entry
that dumps the configuration of the RISUPs, the RISALs and the RIMUs.
This will allow to display the whole RIFSC firewall configuration at
runtime.

While there, fix a bug on the computation of firewall entries in the
probe function.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 drivers/bus/stm32_rifsc.c | 600 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 596 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/stm32_rifsc.c b/drivers/bus/stm32_rifsc.c
index 4cf1b60014b7..d8cf081232a3 100644
--- a/drivers/bus/stm32_rifsc.c
+++ b/drivers/bus/stm32_rifsc.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -25,6 +26,8 @@
 #define RIFSC_RISC_PRIVCFGR0		0x30
 #define RIFSC_RISC_PER0_CIDCFGR		0x100
 #define RIFSC_RISC_PER0_SEMCR		0x104
+#define RIFSC_RISC_REG0_ACFGR		0x900
+#define RIFSC_RISC_REG3_AADDR		0x924
 #define RIFSC_RISC_HWCFGR2		0xFEC
 
 /*
@@ -70,6 +73,568 @@
 #define RIF_CID0			0x0
 #define RIF_CID1			0x1
 
+#if defined(CONFIG_DEBUG_FS)
+#define RIFSC_RISUP_ENTRIES		128
+#define RIFSC_RIMU_ENTRIES		16
+#define RIFSC_RISAL_SUBREGIONS		2
+#define RIFSC_RISAL_GRANULARITY		8
+
+#define RIFSC_RIMC_ATTR0		0xC10
+
+#define RIFSC_RIMC_CIDSEL		BIT(2)
+#define RIFSC_RIMC_MCID_MASK		GENMASK(6, 4)
+#define RIFSC_RIMC_MSEC			BIT(8)
+#define RIFSC_RIMC_MPRIV		BIT(9)
+
+#define RIFSC_RISC_SRCID_MASK		GENMASK(6, 4)
+#define RIFSC_RISC_SRPRIV		BIT(9)
+#define RIFSC_RISC_SRSEC		BIT(8)
+#define RIFSC_RISC_SRRLOCK		BIT(1)
+#define RIFSC_RISC_SREN			BIT(0)
+#define RIFSC_RISC_SRLENGTH_MASK	GENMASK(27, 16)
+#define RIFSC_RISC_SRSTART_MASK		GENMASK(10, 0)
+
+static const char *stm32mp21_rifsc_rimu_names[RIFSC_RIMU_ENTRIES] = {
+	"ETR",
+	"SDMMC1",
+	"SDMMC2",
+	"SDMMC3",
+	"OTG_HS",
+	"USBH",
+	"ETH1",
+	"ETH2",
+	"RESERVED",
+	"RESERVED",
+	"DCMIPP",
+	"LTDC_L1/L2",
+	"LTDC_L3",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+};
+
+static const char *stm32mp25_rifsc_rimu_names[RIFSC_RIMU_ENTRIES] = {
+	"ETR",
+	"SDMMC1",
+	"SDMMC2",
+	"SDMMC3",
+	"USB3DR",
+	"USBH",
+	"ETH1",
+	"ETH2",
+	"PCIE",
+	"GPU",
+	"DMCIPP",
+	"LTDC_L0/L1",
+	"LTDC_L2",
+	"LTDC_ROT",
+	"VDEC",
+	"VENC"
+};
+
+static const char *stm32mp21_rifsc_risup_names[RIFSC_RISUP_ENTRIES] = {
+	"TIM1",
+	"TIM2",
+	"TIM3",
+	"TIM4",
+	"TIM5",
+	"TIM6",
+	"TIM7",
+	"TIM8",
+	"TIM10",
+	"TIM11",
+	"TIM12",
+	"TIM13",
+	"TIM14",
+	"TIM15",
+	"TIM16",
+	"TIM17",
+	"RESERVED",
+	"LPTIM1",
+	"LPTIM2",
+	"LPTIM3",
+	"LPTIM4",
+	"LPTIM5",
+	"SPI1",
+	"SPI2",
+	"SPI3",
+	"SPI4",
+	"SPI5",
+	"SPI6",
+	"RESERVED",
+	"RESERVED",
+	"SPDIFRX",
+	"USART1",
+	"USART2",
+	"USART3",
+	"UART4",
+	"UART5",
+	"USART6",
+	"UART7",
+	"RESERVED",
+	"RESERVED",
+	"LPUART1",
+	"I2C1",
+	"I2C2",
+	"I2C3",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"SAI1",
+	"SAI2",
+	"SAI3",
+	"SAI4",
+	"RESERVED",
+	"MDF1",
+	"RESERVED",
+	"FDCAN",
+	"HDP",
+	"ADC1",
+	"ADC2",
+	"ETH1",
+	"ETH2",
+	"RESERVED",
+	"USBH",
+	"RESERVED",
+	"RESERVED",
+	"OTG_HS",
+	"DDRPERFM",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"STGEN",
+	"OCTOSPI1",
+	"RESERVED",
+	"SDMMC1",
+	"SDMMC2",
+	"SDMMC3",
+	"RESERVED",
+	"LTDC_CMN",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"CSI",
+	"DCMIPP",
+	"DCMI_PSSI",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RNG1",
+	"RNG2",
+	"PKA",
+	"SAES",
+	"HASH1",
+	"HASH2",
+	"CRYP1",
+	"CRYP2",
+	"IWDG1",
+	"IWDG2",
+	"IWDG3",
+	"IWDG4",
+	"WWDG1",
+	"RESERVED",
+	"VREFBUF",
+	"DTS",
+	"RAMCFG",
+	"CRC",
+	"SERC",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"I3C1",
+	"I3C2",
+	"I3C3",
+	"RESERVED",
+	"ICACHE_DCACHE",
+	"LTDC_L1L2",
+	"LTDC_L3",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"OTFDEC1",
+	"RESERVED",
+	"IAC",
+};
+
+static const char *stm32mp25_rifsc_risup_names[RIFSC_RISUP_ENTRIES] = {
+	"TIM1",
+	"TIM2",
+	"TIM3",
+	"TIM4",
+	"TIM5",
+	"TIM6",
+	"TIM7",
+	"TIM8",
+	"TIM10",
+	"TIM11",
+	"TIM12",
+	"TIM13",
+	"TIM14",
+	"TIM15",
+	"TIM16",
+	"TIM17",
+	"TIM20",
+	"LPTIM1",
+	"LPTIM2",
+	"LPTIM3",
+	"LPTIM4",
+	"LPTIM5",
+	"SPI1",
+	"SPI2",
+	"SPI3",
+	"SPI4",
+	"SPI5",
+	"SPI6",
+	"SPI7",
+	"SPI8",
+	"SPDIFRX",
+	"USART1",
+	"USART2",
+	"USART3",
+	"UART4",
+	"UART5",
+	"USART6",
+	"UART7",
+	"UART8",
+	"UART9",
+	"LPUART1",
+	"I2C1",
+	"I2C2",
+	"I2C3",
+	"I2C4",
+	"I2C5",
+	"I2C6",
+	"I2C7",
+	"I2C8",
+	"SAI1",
+	"SAI2",
+	"SAI3",
+	"SAI4",
+	"RESERVED",
+	"MDF1",
+	"ADF1",
+	"FDCAN",
+	"HDP",
+	"ADC12",
+	"ADC3",
+	"ETH1",
+	"ETH2",
+	"RESERVED",
+	"USBH",
+	"RESERVED",
+	"RESERVED",
+	"USB3DR",
+	"COMBOPHY",
+	"PCIE",
+	"UCPD1",
+	"ETHSW_DEIP",
+	"ETHSW_ACM_CF",
+	"ETHSW_ACM_MSGBU",
+	"STGEN",
+	"OCTOSPI1",
+	"OCTOSPI2",
+	"SDMMC1",
+	"SDMMC2",
+	"SDMMC3",
+	"GPU",
+	"LTDC_CMN",
+	"DSI_CMN",
+	"RESERVED",
+	"RESERVED",
+	"LVDS",
+	"RESERVED",
+	"CSI",
+	"DCMIPP",
+	"DCMI_PSSI",
+	"VDEC",
+	"VENC",
+	"RESERVED",
+	"RNG",
+	"PKA",
+	"SAES",
+	"HASH",
+	"CRYP1",
+	"CRYP2",
+	"IWDG1",
+	"IWDG2",
+	"IWDG3",
+	"IWDG4",
+	"IWDG5",
+	"WWDG1",
+	"WWDG2",
+	"RESERVED",
+	"VREFBUF",
+	"DTS",
+	"RAMCFG",
+	"CRC",
+	"SERC",
+	"OCTOSPIM",
+	"GICV2M",
+	"RESERVED",
+	"I3C1",
+	"I3C2",
+	"I3C3",
+	"I3C4",
+	"ICACHE_DCACHE",
+	"LTDC_L0L1",
+	"LTDC_L2",
+	"LTDC_ROT",
+	"DSI_TRIG",
+	"DSI_RDFIFO",
+	"RESERVED",
+	"OTFDEC1",
+	"OTFDEC2",
+	"IAC",
+};
+struct rifsc_risup_debug_data {
+	char dev_name[15];
+	u8 dev_cid;
+	u8 dev_sem_cids;
+	u8 dev_id;
+	bool dev_cid_filt_en;
+	bool dev_sem_en;
+	bool dev_priv;
+	bool dev_sec;
+};
+
+struct rifsc_rimu_debug_data {
+	char m_name[11];
+	u8 m_cid;
+	bool cidsel;
+	bool m_sec;
+	bool m_priv;
+};
+
+struct rifsc_subreg_debug_data {
+	bool sr_sec;
+	bool sr_priv;
+	u8 sr_cid;
+	bool sr_rlock;
+	bool sr_enable;
+	u16 sr_start;
+	u16 sr_length;
+};
+
+struct stm32_rifsc_resources_names {
+	const char **device_names;
+	const char **initiator_names;
+};
+struct rifsc_dbg_private {
+	const struct stm32_rifsc_resources_names *res_names;
+	void __iomem *mmio;
+	unsigned int nb_risup;
+	unsigned int nb_rimu;
+	unsigned int nb_risal;
+};
+
+static const struct stm32_rifsc_resources_names rifsc_mp21_res_names = {
+	.device_names = stm32mp21_rifsc_risup_names,
+	.initiator_names = stm32mp21_rifsc_rimu_names,
+};
+
+static const struct stm32_rifsc_resources_names rifsc_mp25_res_names = {
+	.device_names = stm32mp25_rifsc_risup_names,
+	.initiator_names = stm32mp25_rifsc_rimu_names,
+};
+
+static void stm32_rifsc_fill_rimu_dbg_entry(struct rifsc_dbg_private *rifsc,
+					    struct rifsc_rimu_debug_data *dbg_entry, int i)
+{
+	const struct stm32_rifsc_resources_names *dbg_names = rifsc->res_names;
+	u32 rimc_attr = readl_relaxed(rifsc->mmio + RIFSC_RIMC_ATTR0 + 0x4 * i);
+
+	snprintf(dbg_entry->m_name, sizeof(dbg_entry->m_name), "%s", dbg_names->initiator_names[i]);
+	dbg_entry->m_cid = FIELD_GET(RIFSC_RIMC_MCID_MASK, rimc_attr);
+	dbg_entry->cidsel = rimc_attr & RIFSC_RIMC_CIDSEL;
+	dbg_entry->m_sec = rimc_attr & RIFSC_RIMC_MSEC;
+	dbg_entry->m_priv = rimc_attr & RIFSC_RIMC_MPRIV;
+}
+
+static void stm32_rifsc_fill_dev_dbg_entry(struct rifsc_dbg_private *rifsc,
+					   struct rifsc_risup_debug_data *dbg_entry, int i)
+{
+	const struct stm32_rifsc_resources_names *dbg_names = rifsc->res_names;
+	u32 cid_cfgr, sec_cfgr, priv_cfgr;
+	u8 reg_id = i / IDS_PER_RISC_SEC_PRIV_REGS;
+	u8 reg_offset = i % IDS_PER_RISC_SEC_PRIV_REGS;
+
+	cid_cfgr = readl_relaxed(rifsc->mmio + RIFSC_RISC_PER0_CIDCFGR + 0x8 * i);
+	sec_cfgr = readl_relaxed(rifsc->mmio + RIFSC_RISC_SECCFGR0 + 0x4 * reg_id);
+	priv_cfgr = readl_relaxed(rifsc->mmio + RIFSC_RISC_PRIVCFGR0 + 0x4 * reg_id);
+
+	snprintf(dbg_entry->dev_name, sizeof(dbg_entry->dev_name), "%s",
+		 dbg_names->device_names[i]);
+	dbg_entry->dev_id = i;
+	dbg_entry->dev_cid_filt_en = cid_cfgr & CIDCFGR_CFEN;
+	dbg_entry->dev_sem_en = cid_cfgr & CIDCFGR_SEMEN;
+	dbg_entry->dev_cid = FIELD_GET(RIFSC_RISC_SCID_MASK, cid_cfgr);
+	dbg_entry->dev_sem_cids = FIELD_GET(RIFSC_RISC_SEMWL_MASK, cid_cfgr);
+	dbg_entry->dev_sec = sec_cfgr & BIT(reg_offset) ?  true : false;
+	dbg_entry->dev_priv = priv_cfgr & BIT(reg_offset) ?  true : false;
+}
+
+
+static void stm32_rifsc_fill_subreg_dbg_entry(struct rifsc_dbg_private *rifsc,
+					      struct rifsc_subreg_debug_data *dbg_entry, int i,
+					      int j)
+{
+	u32 risc_xcfgr = readl_relaxed(rifsc->mmio + RIFSC_RISC_REG0_ACFGR + 0x10 * i + 0x8 * j);
+	u32 risc_xaddr;
+
+	dbg_entry->sr_sec = risc_xcfgr & RIFSC_RISC_SRSEC;
+	dbg_entry->sr_priv = risc_xcfgr & RIFSC_RISC_SRPRIV;
+	dbg_entry->sr_cid = FIELD_GET(RIFSC_RISC_SRCID_MASK, risc_xcfgr);
+	dbg_entry->sr_rlock = risc_xcfgr & RIFSC_RISC_SRRLOCK;
+	dbg_entry->sr_enable = risc_xcfgr & RIFSC_RISC_SREN;
+	if (i == 2) {
+		risc_xaddr = readl_relaxed(rifsc->mmio + RIFSC_RISC_REG3_AADDR + 0x8 * j);
+		dbg_entry->sr_length = FIELD_GET(RIFSC_RISC_SRLENGTH_MASK, risc_xaddr);
+		dbg_entry->sr_start = FIELD_GET(RIFSC_RISC_SRSTART_MASK, risc_xaddr);
+	} else {
+		dbg_entry->sr_start = 0;
+		dbg_entry->sr_length = U16_MAX;
+	}
+}
+
+static int stm32_rifsc_conf_dump_show(struct seq_file *s, void *data)
+{
+	struct rifsc_dbg_private *rifsc = (struct rifsc_dbg_private *)s->private;
+	int i, j;
+
+	seq_puts(s, "\n=============================================\n");
+	seq_puts(s, "                 RIFSC dump\n");
+	seq_puts(s, "=============================================\n\n");
+
+	seq_puts(s, "\n=============================================\n");
+	seq_puts(s, "                 RISUP dump\n");
+	seq_puts(s, "=============================================\n");
+
+	seq_printf(s, "\n| %-15s |", "Peripheral name");
+	seq_puts(s, "| Firewall ID |");
+	seq_puts(s, "| N/SECURE |");
+	seq_puts(s, "| N/PRIVILEGED |");
+	seq_puts(s, "| CID filtering |");
+	seq_puts(s, "| Semaphore mode |");
+	seq_puts(s, "| SCID |");
+	seq_printf(s, "| %7s |\n", "SEMWL");
+
+	for (i = 0; i < RIFSC_RISUP_ENTRIES && i < rifsc->nb_risup; i++) {
+		struct rifsc_risup_debug_data d_dbg_entry;
+
+		stm32_rifsc_fill_dev_dbg_entry(rifsc, &d_dbg_entry, i);
+
+		seq_printf(s, "| %-15s |", d_dbg_entry.dev_name);
+		seq_printf(s, "| %-11d |", d_dbg_entry.dev_id);
+		seq_printf(s, "| %-8s |", d_dbg_entry.dev_sec ? "SEC" : "NSEC");
+		seq_printf(s, "| %-12s |", d_dbg_entry.dev_priv ? "PRIV" : "NPRIV");
+		seq_printf(s, "| %-13s |",
+			   d_dbg_entry.dev_cid_filt_en ? "enabled" : "disabled");
+		seq_printf(s, "| %-14s |",
+			   d_dbg_entry.dev_sem_en ? "enabled" : "disabled");
+		seq_printf(s, "| %-4d |", d_dbg_entry.dev_cid);
+		seq_printf(s, "| %#-7x |\n", d_dbg_entry.dev_sem_cids);
+	}
+
+	seq_puts(s, "\n=============================================\n");
+	seq_puts(s, "                  RIMU dump\n");
+	seq_puts(s, "=============================================\n");
+
+	seq_puts(s, "| RIMU's name |");
+	seq_puts(s, "| CIDSEL |");
+	seq_puts(s, "| MCID |");
+	seq_puts(s, "| N/SECURE |");
+	seq_puts(s, "| N/PRIVILEGED |\n");
+
+	for (i = 0; i < RIFSC_RIMU_ENTRIES && rifsc->nb_rimu; i++) {
+		struct rifsc_rimu_debug_data m_dbg_entry;
+
+		stm32_rifsc_fill_rimu_dbg_entry(rifsc, &m_dbg_entry, i);
+
+		seq_printf(s, "| %-11s |", m_dbg_entry.m_name);
+		seq_printf(s, "| %-6s |", m_dbg_entry.cidsel ? "CIDSEL" : "");
+		seq_printf(s, "| %-4d |", m_dbg_entry.m_cid);
+		seq_printf(s, "| %-8s |", m_dbg_entry.m_sec ? "SEC" : "NSEC");
+		seq_printf(s, "| %-12s |\n", m_dbg_entry.m_priv ? "PRIV" : "NPRIV");
+	}
+
+	if (rifsc->nb_risal > 0) {
+		seq_puts(s, "\n=============================================\n");
+		seq_puts(s, "                  RISAL dump\n");
+		seq_puts(s, "=============================================\n");
+
+		seq_puts(s, "| Memory  |");
+		seq_puts(s, "| Subreg. |");
+		seq_puts(s, "| N/SECURE |");
+		seq_puts(s, "| N/PRIVILEGED |");
+		seq_puts(s, "| Subreg. CID |");
+		seq_puts(s, "| Resource lock |");
+		seq_puts(s, "| Subreg. enable |");
+		seq_puts(s, "| Subreg. start |");
+		seq_puts(s, "|  Subreg. end  |\n");
+
+		for (i = 0; i < rifsc->nb_risal; i++) {
+			for (j = 0; j < RIFSC_RISAL_SUBREGIONS; j++) {
+				struct rifsc_subreg_debug_data sr_dbg_entry;
+
+				stm32_rifsc_fill_subreg_dbg_entry(rifsc, &sr_dbg_entry, i, j);
+
+				seq_printf(s, "| LPSRAM%1d |", i + 1);
+				seq_printf(s, "|    %1s    |", (j == 0) ? "A" : "B");
+				seq_printf(s, "| %-8s |", sr_dbg_entry.sr_sec ? "SEC" : "NSEC");
+				seq_printf(s, "| %-12s |", sr_dbg_entry.sr_priv ? "PRIV" : "NPRIV");
+				seq_printf(s, "| 0x%-9x |", sr_dbg_entry.sr_cid);
+				seq_printf(s, "| %-13s |",
+					   sr_dbg_entry.sr_rlock ? "locked (1)" : "unlocked (0)");
+				seq_printf(s, "| %-14s |",
+					   sr_dbg_entry.sr_enable ? "enabled" : "disabled");
+
+				seq_printf(s, "| 0x%-11x |", sr_dbg_entry.sr_start);
+				seq_printf(s, "| 0x%-11x |\n", sr_dbg_entry.sr_start +
+					   sr_dbg_entry.sr_length - 1);
+			}
+		}
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(stm32_rifsc_conf_dump);
+
+static int stm32_rifsc_register_debugfs(struct stm32_firewall_controller *rifsc_controller,
+					u32 nb_risup, u32 nb_rimu, u32 nb_risal)
+{
+	struct rifsc_dbg_private *rifsc_priv;
+	struct dentry *root = NULL;
+
+	rifsc_priv = devm_kzalloc(rifsc_controller->dev, sizeof(*rifsc_priv), GFP_KERNEL);
+	if (!rifsc_priv)
+		return -ENOMEM;
+
+	rifsc_priv->mmio = rifsc_controller->mmio;
+	rifsc_priv->nb_risup = nb_risup;
+	rifsc_priv->nb_rimu = nb_rimu;
+	rifsc_priv->nb_risal = nb_risal;
+	rifsc_priv->res_names = of_device_get_match_data(rifsc_controller->dev);
+
+	root = debugfs_lookup("stm32_firewall", NULL);
+	if (!root)
+		root = debugfs_create_dir("stm32_firewall", NULL);
+
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+
+	debugfs_create_file("rifsc", 0444, root, rifsc_priv, &stm32_rifsc_conf_dump_fops);
+
+	return 0;
+}
+#endif /* defined(CONFIG_DEBUG_FS) */
+
 static bool stm32_rifsc_is_semaphore_available(void __iomem *addr)
 {
 	return !(readl(addr) & SEMCR_MUTEX);
@@ -207,9 +772,19 @@ static int stm32_rifsc_probe(struct platform_device *pdev)
 	rifsc_controller->release_access = stm32_rifsc_release_access;
 
 	/* Get number of RIFSC entries*/
-	nb_risup = readl(rifsc_controller->mmio + RIFSC_RISC_HWCFGR2) & HWCFGR2_CONF1_MASK;
-	nb_rimu = readl(rifsc_controller->mmio + RIFSC_RISC_HWCFGR2) & HWCFGR2_CONF2_MASK;
-	nb_risal = readl(rifsc_controller->mmio + RIFSC_RISC_HWCFGR2) & HWCFGR2_CONF3_MASK;
+	nb_risup = FIELD_GET(HWCFGR2_CONF1_MASK,
+			     readl(rifsc_controller->mmio + RIFSC_RISC_HWCFGR2));
+	nb_rimu = FIELD_GET(HWCFGR2_CONF2_MASK,
+			    readl(rifsc_controller->mmio + RIFSC_RISC_HWCFGR2));
+	nb_risal = FIELD_GET(HWCFGR2_CONF3_MASK,
+			     readl(rifsc_controller->mmio + RIFSC_RISC_HWCFGR2));
+	/*
+	 * On STM32MP21, RIFSC_RISC_HWCFGR2 shows an incorrect number of RISAL (NUM_RISAL is 3
+	 * instead of 0). A software workaround is implemented using the st,mem-map property in the
+	 * device tree. This property is absent or left empty if there is no RISAL.
+	 */
+	if (of_device_is_compatible(np, "st,stm32mp21-rifsc"))
+		nb_risal = 0;
 	rifsc_controller->max_entries = nb_risup + nb_rimu + nb_risal;
 
 	platform_set_drvdata(pdev, rifsc_controller);
@@ -228,12 +803,29 @@ static int stm32_rifsc_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+#if defined(CONFIG_DEBUG_FS)
+	rc = stm32_rifsc_register_debugfs(rifsc_controller, nb_risup, nb_rimu, nb_risal);
+	if (rc)
+		return dev_err_probe(rifsc_controller->dev, rc, "Failed creating debugfs entry\n");
+#endif
+
 	/* Populate all allowed nodes */
 	return of_platform_populate(np, NULL, NULL, &pdev->dev);
 }
 
 static const struct of_device_id stm32_rifsc_of_match[] = {
-	{ .compatible = "st,stm32mp25-rifsc" },
+	{
+		.compatible = "st,stm32mp25-rifsc",
+#if defined(CONFIG_DEBUG_FS)
+		.data = &rifsc_mp25_res_names,
+#endif
+	},
+	{
+		.compatible = "st,stm32mp21-rifsc",
+#if defined(CONFIG_DEBUG_FS)
+		.data = &rifsc_mp21_res_names,
+#endif
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, stm32_rifsc_of_match);

-- 
2.43.0


