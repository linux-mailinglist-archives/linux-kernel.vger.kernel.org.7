Return-Path: <linux-kernel+bounces-888092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910EEC39D49
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB99E3BD581
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051C430C60B;
	Thu,  6 Nov 2025 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ELF0ygg6"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E65635965;
	Thu,  6 Nov 2025 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421562; cv=fail; b=f6Wpv0ypR0F6Rb1XlknuyQwCiiABvurukBpUB4hIa1I6mUdv7lv4VD6NLliSN/uE+pUMwqDmwHn57yqx9wDfXijFBXGgXfPrpkFq083QjGe3j6tMFk6hJVSbxu2clYAdbNSs7nk6hQdc5Efba86YzGNYk5Q5G8S+huMbU/kT2Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421562; c=relaxed/simple;
	bh=cCLXQEEOaymckeh8/p7ZTJ+miF7T3TZOBChrMeaF+WQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BhGkhlhAzos47Hp/DHdPjWS8TId0L3+3v3yigl6G2ysnpqZ2nhUa6nIG/LCEySajH9S6RHAOcn79Z09Q02fyEpT2bdpFfXqqsYpEWtYx6vY22cJIlJvNngJoDz3jjpYCM4FM5bYeraGaREVTtRqjI597eWtKwLC/gP8Cr0n1sJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ELF0ygg6; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A69E3HI1369429;
	Thu, 6 Nov 2025 10:32:22 +0100
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a7g98br11-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 10:32:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3uZacXQpWObnr14zejwDRDocfCOB1ds9BXM1A8OfhTD7xojwOctsTo19yOKVedxFTSVr6WM9nGhJVpdHWVcVB8JpBJxp431/1D/ZMAQzALDwX/BH1onDxs0wx8yCf3TIKop6bhV7+uAkPD/jq/rKVQFkUUR6k6CGDiHuEQg3L9o3r07G3zqm0W19o9V+ufQmetrOgrWOgC5MGLtqG1ok8PL6fBi1Tmsi2UgVR8GLsraJ5ZYEV1ZZn80rx/pDIHAziX1VZo5KWWyF+1QYBKZV9YTvPefgwC4KEjWXLbGIbpMZugCSQ8rmjHZX3/ZCMxRSP+I8Sg5QyWn/+6Eee6bNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKfYt79/o7oM+5otTjMRmmXdDMnYVCjb7shXhCpCMfA=;
 b=JVOP8cUHVSVKsJf95bHti9oICRaDKEAWmJXR/SWWwtjJDWZoYYTT74Y/qLqC7o4ZJpjuC1KEkoDT8V7JwSZj3EvZQl2J5avjG9p5IpeZStVXqp2Xp7qrVq9FM0g6J0BKpnwu5eQb+tGvad0J/9n8afdTBljVkWQF/C5skJ3QUjsCDmqWmIrQcllpGvSbSdfuLXDpKxHFaU11RqiibMB4JwsoEGZgy885hfo2cfoRF/wfEGFKtGtCu+eUTu97RL3kZ7Xsz+qkHWOeZJRMgmdfOzEzTImsTqZYRqbVvnNaTuMeV2RmqAaPlspKZ1w2uvyX9VKyNllptpddLzC2cwurFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKfYt79/o7oM+5otTjMRmmXdDMnYVCjb7shXhCpCMfA=;
 b=ELF0ygg6qdLmKT5MxKQz2o3Tsi8Q2KXaTWgylBtyBuNAJ0HfJs99KOXeQZwBR2Uhh49gGx6yld5Nh37U2OimX/LIGu/PMoBpWlDXSMg2IekOpih4HYQaM+eE04L3vuezDYy2WT9lGwLr/uYS7Cw6KgFuOq7UOl/SJhKe/9emT9/pfXxU2mV5cFNVIFjUG/XeEDDfWZ8mz5cRIE0k00h5KSt7BxJL8mQwNOx9LOQoqLb8a+BK2sZJmPf91zFuFQHOjGXBGhohT3fu5DwyvIHxO2AUfU01GPlcO0mtlsqFTDCFZ2AE/jB/wJSf8YmUJlp8AYM9Oif58boO66+7ReFZ9A==
Received: from AS9PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::28) by DU0PR10MB5655.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:319::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 09:32:17 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:20b:540:cafe::89) by AS9PR01CA0015.outlook.office365.com
 (2603:10a6:20b:540::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 09:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 09:32:17 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 10:32:20 +0100
Received: from localhost (10.48.87.185) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 6 Nov
 2025 10:32:16 +0100
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Thu, 6 Nov 2025 10:31:48 +0100
Subject: [PATCH v2 1/3] dt-bindings: bus: add stm32mp21 RIFSC compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251106-rifsc_debugfs-v2-1-f90e94ae756d@foss.st.com>
References: <20251106-rifsc_debugfs-v2-0-f90e94ae756d@foss.st.com>
In-Reply-To: <20251106-rifsc_debugfs-v2-0-f90e94ae756d@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|DU0PR10MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e819196-2799-4e7d-aa30-08de1d176075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWtqcFJWS0NTODhsdERjaU9xRjByaWFqWjBPMkhCQWdTMnFkWjMvK29ZdlJY?=
 =?utf-8?B?azhQTFE3UlM1Z1hQT2dTWW1vK3lPWFZvSG8xUitHMXBWc0lrZG85eGZwa0Ja?=
 =?utf-8?B?TksvMXFkeGgvMlIvZ1pBOEZCSFREM1EwZ0JxOWZXQkRwZEpkek92REkxcC83?=
 =?utf-8?B?WDBIR05PL1dtcHRWUG0wcHZsZm1CUTlyREs5MVhXYjBZUGdRSUFpOG0xeU12?=
 =?utf-8?B?clcrNGhMV0VqKzFDUHo2K1lXVXoxK3JTRFdmYlRuMmJUWmtGTy9SZkhyTktV?=
 =?utf-8?B?TlpkRVZkZkZKaFBQVUV1R2M2dHNMeHNOWGJ0VEpPQW0yeUEwZ0lNTldBbjlw?=
 =?utf-8?B?ekkvSEg5akJwb2hpSVZ0ME94RFd4L210S0tNL2dWRTRKUzR5eVZqVDBHWXFx?=
 =?utf-8?B?T2V1a3R4T0VTUXllbjVuMmh2NVFaNHI4d2o1UzlSSjdaYTBFc3RyNkgreU1J?=
 =?utf-8?B?eU1Td1RBY0pKU2haVnhDNkJnekhoRFVXQk1ReDZsT0FoemZtS3JmTGJVTlNq?=
 =?utf-8?B?djlpVHlmMDJvakppZ3J2Tkl1Sy85ZkVYY1VLQ0ZCdlpYdVFLbXZ4OVVEcTd2?=
 =?utf-8?B?aG0veFp2SWVJVFVUR3E1eEhlZHo3eWhWeHRoY3A0eHpFSUhpRVpLRWxyRWFE?=
 =?utf-8?B?ZC81ZGFsbXdpL2pYdnBLVEFFZU1CTVBBMTVLWEJiNi9sU05xOElNQVp1WWdI?=
 =?utf-8?B?L0VCdW1NakxiN1JCMG5mU1l0NlRNdFdpQm1SUEpKWXR2WXl5ekc2VzBnZFJ4?=
 =?utf-8?B?RFN1OHdYUk8wSjhYNWNKSDcvcUJPNk1kb2xuQ0VNdy83SXdxcnFnMlhwKzRp?=
 =?utf-8?B?Y0Z0czQxZVc4dGR0OEJMU3pXaS9JZmlXeGx3ejZKaDN6bXJJOWJzRXZaNFha?=
 =?utf-8?B?NFJKdHlrOWRSTWE3RkFSNllBd0w1VHlmNlcxL2NkVXpYRy9kTkZhd2UzNzhy?=
 =?utf-8?B?bUYxbHVuSHlSQjN2ZngyZThaeElMUENLUVU0QVhPSitJRGxDdFUzNjNmTUhw?=
 =?utf-8?B?SytPbVBGa3czYTJ2RVZOeXZsQVdQMDBJeE5NTjZDQmtiaFNSdEl0TDdYdHo3?=
 =?utf-8?B?aTVPWWtLUkczOVZHcTJxRG96TEtQSnR3NHlNNmhXMVg1b3dBckRuRjBUREJq?=
 =?utf-8?B?Uy9GTnE3N3kzRlpqcWI2MWVlK3VnMFI0YlVFdEcxbmF0WFVkK1VXc0xQdmM3?=
 =?utf-8?B?SFd6UDRsMUo4WUw0YnhiZGJuTzFHVlo4U0UzYkN3WXlKTGVoSjllWEI5eUtF?=
 =?utf-8?B?aTEwbFUxWlNJOXhreVVZamZmUHJmOGxFTGtPcGxSVTQwL0pPNzNYbW1XalJM?=
 =?utf-8?B?MEtsK3Ywd0trYjI5bFU0VVdJMlkrb3BMamZjUm43aC9zelpDazZYOU16Mmhr?=
 =?utf-8?B?ajY2eWhHVW1qOVdrZlJ0SkJ0eXgwekV3WEpRRjFKbXBKR1RCalI2S2xTUG1W?=
 =?utf-8?B?cGZzb3BkWElpSTBGbjhCWjZ0UEllYnRKaE8vYlEyU2Z6dzFHV2R3NWNjTlpE?=
 =?utf-8?B?RGxHTEpmMzFPVEdjQTJEMllqcmdSQ2FyRFRDQUd3aDIxckNwT0EwL0NMNVFV?=
 =?utf-8?B?VWoxWkdVazdBMHJvdXpzSlNaRUtwSXorbFBvVXVLRU0xOVU0bkIwOHEvU283?=
 =?utf-8?B?NmRRQVdEWXU5bS9KKzFrdlZ3MmRDdklic2U3NjdkS1hCZlBmMkdrTmdMS0d1?=
 =?utf-8?B?eFlvRE04RXpvalJGK2FsV25JZVpCY1h3U2t1NU9GL0pXd0dWNEpwdllIKzBJ?=
 =?utf-8?B?OTVnVVlibmV6S1VHTGduTzFhc0d3TnV2aU5KdGp6KzNzVk1Va1U4Y2hUQkVE?=
 =?utf-8?B?M2UyY2REQWVMYUc5ZmprekFDSkkvT0MzUlEyL01JdTZwNUdDL3BhUDEzU1RJ?=
 =?utf-8?B?eSswMXlHekJzT1YzVWpIK1NrRDVUN0JkOUNsay9mMzJaMms3Nk54SDRGNzBD?=
 =?utf-8?B?bEMvVW5xd25jMEtjYzh1alA1RXliWDkycFZnMEVCUjRvb1R5U3NWVmphcjZJ?=
 =?utf-8?B?T2Q4UG8wYzBzdmt0YnBQNTlxQ2FsaGlBNkI0THh3dVZiTkYvUTZOdUxtVFVy?=
 =?utf-8?B?UFdHM1M5dEIvVjROcGZhSW5oRTlRVSs0Y2Vza1ZQSzdZZEN5Q2VTSkZuL3R0?=
 =?utf-8?Q?rr1s=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 09:32:17.2140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e819196-2799-4e7d-aa30-08de1d176075
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5655
X-Authority-Analysis: v=2.4 cv=K+sv3iWI c=1 sm=1 tr=0 ts=690c6b26 cx=c_pps
 a=iq9n1zC+GKOXjPenYUPC1g==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Wpbxt3t0qq0A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=XYAwZIGsAAAA:8
 a=Od9f8wzskGMPMKVYy8oA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Tv9JCjzIb3N8QC15JHuAahXrPJF6yE7v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA3NiBTYWx0ZWRfX/kflr9E9fYDU
 HhQNld57JcpmCSapK9UbxJjhGseeXz2qmLreJl+by20NcD0Su0p86kQWIwuMEZ4ItfDZPscamyC
 o1T8xBo5KLJJmqhn4rPOj+BtgXtvzjeHu0rkseDchQOSSHg6zhVXv5CPUU77KpIAH5L4so9ABNz
 09W9MVg6XhR4/1Tp+VfQsDJ8YxetaRt2JDyysD2LGZYfYqTdhPQ55OT5nxWueWEDwkieJot1Tlv
 KwEZ1MhyE/+puhpnlBg96iqLdkutgZk3jUo2NjiEK5LF+YZgV6LJWLrj/FD3xacqrs2yjbCiiKa
 oLJhCF5oRRIVWfvNb9Pgs/OajSteKDMqa9fGoIhQcdeGyTGpeaboAd+X1KYuhuTWk5OaB/hxrtA
 OFCSx0x4y3BN+Q5hSSBymxw67l+o4Q==
X-Proofpoint-GUID: Tv9JCjzIb3N8QC15JHuAahXrPJF6yE7v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060076

The STM32MP21x platforms have a slightly different RIFSC. While its
core functionalities are similar, the wiring is not the same. Hence,
declare a new compatible.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml b/Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml
index 20acd1a6b173..3952c99cac6b 100644
--- a/Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml
+++ b/Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml
@@ -33,14 +33,18 @@ select:
   properties:
     compatible:
       contains:
-        const: st,stm32mp25-rifsc
+        enum:
+          - st,stm32mp21-rifsc
+          - st,stm32mp25-rifsc
   required:
     - compatible
 
 properties:
   compatible:
     items:
-      - const: st,stm32mp25-rifsc
+      - enum:
+          - st,stm32mp21-rifsc
+          - st,stm32mp25-rifsc
       - const: simple-bus
 
   reg:

-- 
2.43.0


