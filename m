Return-Path: <linux-kernel+bounces-823158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167FEB85AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9FF37B8E11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A8A3128C3;
	Thu, 18 Sep 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="m+WoJJUe"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5113830F95C;
	Thu, 18 Sep 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209761; cv=fail; b=RN/as/c7kAX35WcuaWEIDN8MgRyBZKoJPRAR03MqD9sBVmEFTLGnBKpo+D+G2k+MUIX57PWYJ77LfeBwSktLdretEQaSePRx3ntQCiFD5TDoIHj0/PVmXJDBKdmeYDXVov3U89nDyogP2cs3FAw8/73dvbZ24xJlM2K6cFMWEKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209761; c=relaxed/simple;
	bh=kQoJXmrlOjU3kMfwbxFNjKxeOJNTj8XhKWYRdzuUS2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cQA64CkRbDRbgiA6eOiiWvdfHoJlmm8uUZB5bWUjJyMuTSw2hHpzRG5Syjc3jYjcGj5YjDuK7tJWkclxBfdw+AD0gNObQJXqsuvj8af9k1PBi9ZkrY/HgGKmRxOrDSQMxaQUcZq35NOJVbzyO+63i12w4bdv4qGqiqBnGes1bRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=m+WoJJUe; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IExMUv008483;
	Thu, 18 Sep 2025 17:35:49 +0200
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11011058.outbound.protection.outlook.com [40.107.130.58])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxv1hmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 17:35:49 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hh1Sn/hqzYcz5s6Am+QF9rybW2pFbhiYSKXKVhOCZernaNJkYgRogmIYD0eKWFVGa+qt7OoC7DwdXAXdq68A1CU4GGu8IZhMB4vvgIzzPOtAhMHQ6u5VD2rsdYXVZDXOWhzuXS+EJ2c2dbzvxsMpgY9pMYTMott6KINLKUF4HJa0JA1rwXKH0xyT1SIT2qg9BA1xaOD3jID5LjUOjfrcNcAhjSOEv7GDLrV7ip2asoQoDEI9mPiucKrNlNie6R82G0xO/sH5P0wVxDo5jYiQGc5yiMqEbZb0vLjJkWSq17NvXVQL44ZsmBjMVVMxkhrwbEYSPCAcM+iTeE1oTVqxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XhAfLs8LemqkL2RJFku5JO/vMufr2xgETYKcJn/jOw=;
 b=sjqrcGcBso9mVJTlMuTB3QOmcfL2Mg8X7A5KX7K4IEe+YYI2+jDrM8SEtyBEoXwPib3WoSwBUlaBSdenxDiVFxnGyKvv5ECMv7AtnqUXCyxAzXLh3U6Zjh7WSkGVIJtKgwDyTdQSsRVdiDI9psm1RZreRtJG0v+VaR4NkNBsO4TGZmAE/hQksruFASaobHuTVu+jEAUEElxOIlH48CojVSYMjRTVyG8InyHu/98gyA5dYT4wMM68YSqaMS4QOBHlmQa0xiTTSj4QcUg8jb1ff7Yz2aUKWYoIi8/9JCGZhFz4j9xSALoHXa85ExfMdrXgZhk5NzB2rXcXh8SjP5wOyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XhAfLs8LemqkL2RJFku5JO/vMufr2xgETYKcJn/jOw=;
 b=m+WoJJUeALjDqsJExOkBo7WqScSK+fRg9Gpbj9QmOXWrR9vi1brTnW9fmFHrjUeItDXMOrPls57YmNVjAH13Il+grVcyGP0WXa9nMcLvDU0QqJWzmptjeU/5RS9yUyj7VYa7k8+T+hrB25g0hXkvIywZNMgjyOwR+sPaMQWWv5K4mDG2RIov/yi61d6C2tdvjILjYt5ejv3r0/Uq0+TQzJOQIabfQXcQUg0PN1GK8j6HfPYn76A+NgvbiiNlnUCilI7MMLw6/NeFyet55eKpZpZbvh9CPeRORItYaS4+G5sKy6vvaNsn5xuilXNRHbt4FU/Cmx8HFRE54bKB6PeCjA==
Received: from AM0PR07CA0010.eurprd07.prod.outlook.com (2603:10a6:208:ac::23)
 by DU4PR10MB9430.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5f4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 15:35:45 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:208:ac:cafe::a9) by AM0PR07CA0010.outlook.office365.com
 (2603:10a6:208:ac::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 15:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 15:35:44 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 17:33:19 +0200
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 17:35:43 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Thu, 18 Sep 2025 17:35:38 +0200
Subject: [PATCH 1/4] ARM: dts: stm32: add iwdg1 node in stm32mp131.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250918-iwdg1-v1-1-02c2543c01a5@foss.st.com>
References: <20250918-iwdg1-v1-0-02c2543c01a5@foss.st.com>
In-Reply-To: <20250918-iwdg1-v1-0-02c2543c01a5@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A2:EE_|DU4PR10MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fde1434-dc32-4dcc-d655-08ddf6c9086c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXBFeFNTQVlEbEVWNFhXK1RWWkpYQU91L20rWE8xckJvZFJrRE5wWWRsdVJa?=
 =?utf-8?B?VEFWdEhIR09HWG1sRDlDZ3NJeVo4Qk9FOS91VU5pdGJvV3I0STRFa3VLVmNh?=
 =?utf-8?B?cU9LT2FWclVhT3VrZHBRWkk2bnBHb3VHOGJtY3NjSHowNThtVVBNbXBjKzNN?=
 =?utf-8?B?YzlpK2dXUG1DREU1eWdQcXRxNThraVpDL3NsRytuTG9KUkliQXVPRHJJRm9X?=
 =?utf-8?B?cVFlMFN2OVB3WWlXSVNhYkd2aTBGaC91ajB4aHA4Wi9FMjU2Kzh1M2UybVgw?=
 =?utf-8?B?QmhFNjIzVnZ6TkRRNHUrNzhVVVAzTHpMeGlpUjB0NWxueTJzMHd4V1RSZit3?=
 =?utf-8?B?L2srTmhPMk02cmZWVllzT2JmQ0dUS3RaZitaSkxzMmFTREVUSzhPdG5RYzZx?=
 =?utf-8?B?elgyeGNNWmpLVGRpUUdtK0tLalVGYUZFNThtNnlISVVBQXhIc2R1TGRya3NO?=
 =?utf-8?B?NDRRUi9LZGJqUXhJc3BIeXhYbVIvTVFGQ3B3MFJLUk5BeWVaQ1MrSXdmYlhL?=
 =?utf-8?B?dXYzenhwbTQrcGJyUzVYN0JaOXM3UldKNzV0bnNTZlNDb2hibmdmMFIxWEtV?=
 =?utf-8?B?ZXp2aHZBZmptbzR2cTR2TDU0NlNSM294UllvN1IzeGhTR083N1RNZFdNd1NJ?=
 =?utf-8?B?Vkd0ZU4zdkZRUmM5elhvMFhHQmNNWFJxYWh4ekgyWHIrVmxjclBUMVh0aUo3?=
 =?utf-8?B?RHpmbGQxVHA2amdWVHFzeHRVZi9vVlJjTTd4TC94Zjl0KzczY0hQOHhEcDJk?=
 =?utf-8?B?eHB0bjd6OGdhUnJaYUZYUllDNjZRb09hbkp1UVU2WFp5WFg4Mk5Vb1FleTc1?=
 =?utf-8?B?NVlzWDlsZzVFVVdEY29EVE1XeG9zYjVlTmhMUy9JaUJZb2hvOHl4eWhpZlJq?=
 =?utf-8?B?ajBtREYxQm1Uc1BXdjVhdUN6WmQvSjZsNEVHQUZlZjZTNFBhNnhyTTRkVE9K?=
 =?utf-8?B?VGV4V2dGL1FmaEszcWtKN3N1bHFZbmNySGk4TXlxcDdKR3VFWDNZRzc1M3px?=
 =?utf-8?B?YkJzNkNvZGVqUjFHdlppcm9JdUJ2S3pHUTVvVmtCM0xGMk1XSjhMQm82eDNa?=
 =?utf-8?B?KzVkU09UYlBWNmhMaGsrT014a2ZMVUltOWpNQkR5cnFVcndwOFBKYndGVjd4?=
 =?utf-8?B?eDhvTjYxd2tuRTNhR01VdjVEOW9iVjlTUlFtSVBMUTYyZGJSNmQ4NDhzbHpC?=
 =?utf-8?B?OS93Sk1QTE1UOUV6UzlmZ1JBRU1OUHg4bzkxcW5kcVhDWHcwRjk0ZDhVL29P?=
 =?utf-8?B?VTJ5WVptNkVXQkN4N2VKMStIdHdVMzV5Z3BHMlpld0wxb0dYd0dYMUg2Tndk?=
 =?utf-8?B?TVF3MFpLcEpYYVlpZExwVEFtYmQyUE5nZ1ljQ3pnSmlUVE1xSFRJOEgxQnNy?=
 =?utf-8?B?cnRpbTJFaFpFVnhNVlM3QnZQd3REUXBUVGJHNnBzb1FsU2ZWQkgxSXZpOUxk?=
 =?utf-8?B?M0t3UHF3Rm50a0lzWnRRekxXVmM1R1VjLzRoSFVxdnpYeWl2cTFsbGx2d0Js?=
 =?utf-8?B?KzFHZk5xUnM3RUJMcm1BdjRzdDZZNGI0b25iQnZaaVBWVldmYTBWVkdwdnNE?=
 =?utf-8?B?NlpMWXBVVHpsczdsQ3lYTDYzQWJQUWpNbkxxWjNVaGpPRy9BUHArNkUzNVlH?=
 =?utf-8?B?V1pxNFBjdGZOWEcrWFVJeHF0eWFHOXdzeFpmTkJ1TTg5a3RrK0RXKzZaaTJh?=
 =?utf-8?B?TzBnbkVNWk1hVER2ZHFSYnBXdC9tQXVRWWRYaDFmSFg5OGRHcEZxK1owRG5u?=
 =?utf-8?B?anA1ZlYrdVF5RXpYTVo5MWJxT3BvcFZPdWFWNWRNNVFXcWRhNXlteVdFZ1Bj?=
 =?utf-8?B?OWlrUjJQMDR2d3BINlNrSit3VFRCM01NSHRJWkFZNXY1YlAwWnpDUW9yWE9n?=
 =?utf-8?B?R1NCVDFlYW9iTkJQWTQ5ODZpR3c1SVFQZ2pDL01WNjEyaG1neXROQWw0U3Ar?=
 =?utf-8?B?WFBCdVpOb083YklISHM4THpCTnVQVm1leUtaNkhIbUdBVVdESUQxenM2Z1d3?=
 =?utf-8?B?ck9JeDBwT0ZQSGRyYXdDWmFtSTJlaG50eS8xZGMrSVBYNWpnQVp4dFQydFFv?=
 =?utf-8?Q?ycwbKl?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 15:35:44.5762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fde1434-dc32-4dcc-d655-08ddf6c9086c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9430
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0EWvtsfRubMG Q/YljiwuhUzIoE7PZZxVoOtA6r9hKXyWLgE91h/k4utiHI+j7rkP+69ELnLKv17I4Mqda6pHvnE fV1WNy/LKJrqXrIv/X/9bUWDA0KXrwz54KR4x4X7CXK+7QNxaVWrJAi9OESu4DjTRBYHhVixHWU
 GeWkMgzT5mScVrU1h58qXq1iCNuL5DGdCHidfk6No06hVucScKwzZOhD4SdC52FXLuCd1qxrE2c yXxgCc9bGsv0i4VK8tHot7ow4/EaOLhp9wiMqrq40Bs8GcPGNuSFcygeuTUkAhr9e/lUpErtckb T9b5GhVHJ2suhc1Nrb8w2qoq//II6z7AxEsql2RxIgdbAY3GPIo3k4Y4SElvrCIuYPMu8JE5ck7 0X6D1fTZ
X-Authority-Analysis: v=2.4 cv=TtLmhCXh c=1 sm=1 tr=0 ts=68cc26d5 cx=c_pps a=9AYPsD8W/ECldZET4Imr7g==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8 a=uCS1rdZqkCKZFn4t26oA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: 8uKfCeEBUdh76uom-KP7G8XvNej5UWye
X-Proofpoint-GUID: 8uKfCeEBUdh76uom-KP7G8XvNej5UWye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

Add the IWDG1 node in the stm32mp131.dtsi SoC device tree file. It can
be used as the Cortex-A7 watchdog when it's configured as non-secure.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index fd730aa37c22e02ec2fd8171f569ab681f47d737..583938ea5c08163b1b100a2aef5894f4a7f34a51 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -1005,6 +1005,15 @@ iwdg2: watchdog@5a002000 {
 			status = "disabled";
 		};
 
+		iwdg1: watchdog@5c003000 {
+			compatible = "st,stm32mp1-iwdg";
+			reg = <0x5c003000 0x400>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc IWDG1>, <&scmi_clk CK_SCMI_LSI>;
+			clock-names = "pclk", "lsi";
+			status = "disabled";
+		};
+
 		rtc: rtc@5c004000 {
 			compatible = "st,stm32mp1-rtc";
 			reg = <0x5c004000 0x400>;

-- 
2.25.1


