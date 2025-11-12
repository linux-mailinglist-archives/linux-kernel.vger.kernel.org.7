Return-Path: <linux-kernel+bounces-897437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5E3C52DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700E5560310
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C3F3469E3;
	Wed, 12 Nov 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ggj2YqmQ"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E3E3431EA;
	Wed, 12 Nov 2025 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958453; cv=fail; b=rtnz8+CnlrpxFBDZ3crDT3+9j3ot8EAiPO/Eqb6CtRf2Vgsrry2nQ6W3TGcxi/L44io5BYwpc7FgLKHSAB8i6HcGB60t1sM67UTCe6z8i5oNvBjyfn7OYQzGUlv5YuFEzFriXeLz/6gsy7SzsHCeIwKXL+H5HYXjrQlnjrdvUh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958453; c=relaxed/simple;
	bh=AO3Fk8quRr42PUKJPRCKocBNaCSqwQkEtSE0K0a6ryk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rE4bbpJF1Ewc+Y+34NOhGU46U1hrKzsyDMd+jZpAz56tjxUYiJa9TzVAHSUr54I05tiEs+/uf+8WdB6CGQh3kGo0ZMvxXK/hnpzgCsIXDNJw+J0xDnWzTR+1DNDoxpJl7QVNUis6dj/EdgqaDW2E6Bh/gFHLDINxIKjqgqf2xz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ggj2YqmQ; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEcvoJ976853;
	Wed, 12 Nov 2025 15:40:39 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acreu1044-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MunOiwUCx4deVWRzXwFpWcjtAzaOrHqAE+bImF03OhEw6P4ypOcjCH7L1kjzBtV4zCUtBNyHq0jOiaeLHAUaMkx9FVw9wUZfhuilOk3UFMGlwott+8rnOTHH5CprPvKbFDwrqqHO8fu6oZcsjMOgUXDYJ2eFZ9sOz5jik/NcXQS6UtNg2fEp8aH/TSWKJQqWtIfSrheUFBpGPd+MVk9xE7MXGPf8m3HIAa7hgNteZILOqtuFeCYrnpECSGJIxv0jhy3ndOW4i/yzepoud2sibM0dLjDMjXgp1ZTufQDCMZbrJ7xDNbD578/YqMmhELhYFEtsPiX7ZC+8uyfjtBewjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwTDHTTnXwgEqpAqZ5vXB0+k0u3TTJ/e1pqsLsu/SWw=;
 b=X83uQRLVlgPUzy2CzvxrWsEvVaUYh9rokV09rPzn0sLk4Q/MQj5EfUeDUrtOVrrVUVhFu985dN+VDTeEY8madgZ5EZ6Qe4+bg8YrCf49yoTd5ddSVzG/bMyEULQxMIVc4k3+WXYYEX5HLUra4uya4G2cpVy2O6uDoI/T5fXycktV8WLgBspMJrqJIcLwngQWQqYFziE1SitYq1Y/CiTgw23y4b1oOq6hgw4YhSRnAEGinKzqp7Uhz633G2VaviaSdZMWuwQxp/YQaD43RSv4QmlFKV/DQVsSLi/UQo6av6j+Kcggrtb52cqi2VdYdJAsmRY9LYU0k+xewUJVc5ma0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwTDHTTnXwgEqpAqZ5vXB0+k0u3TTJ/e1pqsLsu/SWw=;
 b=Ggj2YqmQWq46yguY7jahKtZjK+9nz1xr+W1A8jZTdz0xcf02olXxT12kMWEdnCBnbOWa5pxeCD3LH1N8sitzFAR4mEDT8KCcZyakOWrqWLiBmWCySdwDHNRXQigf1raLyCXVXHdWEqR4HfItzj2r8e2oAxLLl3Xdn7+WkkSYbX4jW9K3W/a1Fy8H2yCRuk9pc3BvLyZgmxpsX4vsFUs0pKvf5mdhRbGdZu/dv1LcmiLU+5Fn3Aqsud9y8VqYnsSWGvDz/5nKfVXZeQrFfMdOPXjvPxF3ZYX9ge+9+1u7lfIEWe/ybj9S6EhumOu3/GVbh/Jqb9Y09YAKvPDDl53x9w==
Received: from AS4PR09CA0022.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::14)
 by AS8PR10MB7799.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:629::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 14:40:37 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::59) by AS4PR09CA0022.outlook.office365.com
 (2603:10a6:20b:5d4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 14:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:36 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:47 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:36 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 15:40:25 +0100
Subject: [PATCH 08/16] ARM: dts: stm32: Add LED support for
 stm32h743i-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_update_led_nodes-v1-8-f6c77739113c@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AC:EE_|AS8PR10MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 2077e7ac-8861-4583-f5bb-08de21f971a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEhmQ3FKTzg1bFRROXMzSVpNUXIyV084dU9odkNCdndvbWYwT0puNkN4dXRI?=
 =?utf-8?B?bW1FdkI1RlVBSEJxSC9zeExCeE9wYjdkY2h1ck44bThJWCtRTmRwbC8rcmZk?=
 =?utf-8?B?MjlNMCt2dmJYbWRSNlRENStsV2JIc1o4aTcwQ0lzL1VSU1F6ZC9zcXpJL08w?=
 =?utf-8?B?MnF4OUNBbUtPb3Y2NkNGRXpLRThQdzdMaG81QThKeDYwV2QwR3NjUHpPYnVF?=
 =?utf-8?B?Sm1IWkk0bStXNDRJWWxweFZEVWlHWkg4c1NiMDJteTltUVREa0x4QnZqd09u?=
 =?utf-8?B?UDJVdnUyTm01QXpOUW5QaVRLZ2Rtb0xhL1RoUmZXZXNQL0tyVFFYOUtVdDNK?=
 =?utf-8?B?NGNkeHJCRGU1Q0cwWDFtcklmaEFaT25iK0Jlam1UQ3RIeldobVVWQlFqQlFi?=
 =?utf-8?B?MVplT0pldFppa2xYSnZzWEcwNU80cnlDd0xBWEViUGVnL2ZZTlZ5SHRGSU1D?=
 =?utf-8?B?cUIzNndVRVpWMC94Umo0c1BWRy9JZ3htY2hGMlI0Vlgrd0xMd2NhbW5VUWxY?=
 =?utf-8?B?Vi9hKzNjb1ArQTRjSFlTaDJFN2xKbko4b0ovVEJ0SnN2TVZRV1dabzVuVG1t?=
 =?utf-8?B?bXNCajJwMlRPUUJpSnMrdi9uUXVaWTluSXdMOEdpRERWTlplSkx2UFVFMXlL?=
 =?utf-8?B?dUxSdDV5TnFvcEJmUnlLbnRVa2hXRk5qb1liK3pIMjBoS2hFNXc2Q2dYYzlu?=
 =?utf-8?B?ZUI2bU94U1A0MGJGQTdRUDZWbkhIK1dUZFVIdzFPV1hicll2Tk1tRVdPVGJa?=
 =?utf-8?B?Q2xzZlM2NTZvZjdjbmNrRHZKOUdiR0d2ektMQ2tsdzZRTld1Q1pBRjJqNnJj?=
 =?utf-8?B?akgrOGpIbGNFYVpraHVmNWFLOGY2bENzUUV2THFqaTNWaG0zUVl1VmtuN0Fa?=
 =?utf-8?B?bWp3LzJPQlBxaE0xa1hBeHgzZ0ZLZkJqbUpEMWZzNC81TmtzTU56NVpnbHVG?=
 =?utf-8?B?MUNFeUp3QkZQOUVWZUhFbi90ZnN5MVBraE94MDRJUSs4bjgrVG5PQVdTVXRz?=
 =?utf-8?B?WUhMNE9MUlBPdWw3R0tHbHBpMFZubHJUbXNuQ3NmSnpJQWRSc2FrSWU4NXp5?=
 =?utf-8?B?VGRhNVZMSnBmcmpqMGhQd0pocU5Qa2tMTHE5S3kzZlJiWFdjWXMwV3dya0ho?=
 =?utf-8?B?V1hkK2hkeC92QjdlL1pHNnR6RzlJUElBMkhXR2JpdW8wUjVwMW9pSTNXUllK?=
 =?utf-8?B?Y3FUbFEyenlpcXg2Q0hFdkhmQndiTHBpNjBWeFhGUDkxR3lEaVIzWHZ3VDJ3?=
 =?utf-8?B?V1hNL1JsanFvMmVTK1gyRDg1OThzVkpSa2VNZ1FSZFJadjZOV0tQQjB2S0Iv?=
 =?utf-8?B?SERYQTJCWCtjZUkxdjU4bDVtOUNweko3bVd2Y3ZDRGovbW9XNnZTZkJ6eEpv?=
 =?utf-8?B?VW9lOHYzakhxNGRCSXoyMlNPREkrcituWXBLdFY4SVlDcFUzQ1ExWWY4N3ly?=
 =?utf-8?B?UXlhdGYzeWFWdnQ0WXZnS1NPS0hLQ1Fkbms5UTRIRFJvR1Y0OTJITkNvT2xI?=
 =?utf-8?B?UE95R1lGUi9zMnlZaHZwVUlBcG9YTGl4WnRlVFVIVmhPYnJoTHRCcUJOU1FH?=
 =?utf-8?B?WXlqQjFOZGI2MWE5eFlucGU3TFdBRVdRcVVwdUpaL2pvWXpVUjA4Z2J1TGNK?=
 =?utf-8?B?ZCtjNW5xbjQ1bW1VQjdTYnJBMEtRa0xFcm05VldrNzlGT2lrd29mditMNjNX?=
 =?utf-8?B?RzVjdUFzZXZidlU2N1hUQWFLTjdWMTJkdHduK2ZFS0NobmVkbi9xWlBrUVJz?=
 =?utf-8?B?SUJaczVVSFk1OTNnZDAydytmd1RRRE1MTmQrWGFMU2R4ZXAvZmU2OEFyUzBv?=
 =?utf-8?B?ejVDeE0xYVJpNEtKM041V3BrWlZUc1dPN2E3RGkvakV3dm1WeE1RY29ZSmRZ?=
 =?utf-8?B?Y2FLZEQ0eHN1UWRzMUlPQ2lhYjgyS3NLenFTTFdVMTZPYUxGWUtxaWFYaHhh?=
 =?utf-8?B?ZkVRLy9uT1dqL2tnRHFTWE1jdzVvTEpFVFhUS0hBNDhpbzF5L2lZeFdkem1L?=
 =?utf-8?B?ZTRyYUdKbkJjczcxWHJqdWtiSkRZOW9rWnNkVks3UTNiM2F0MjZyakJhaC9a?=
 =?utf-8?B?UnlNczJ4WGhUZnJrQlladEFtZWZ6Z1VFMFFxdml6c2ZOMU9mSnpTdDE3K3Fy?=
 =?utf-8?Q?Ht0U=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:36.9837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2077e7ac-8861-4583-f5bb-08de21f971a7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7799
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfXw/wnM9+08eox
 oThVo0HWGxAxsFgB/SMm3u+OA7vuzjqSAgBTb9jfbmkjqLA6FtuSTIYGyJ1goJeZhlOPOv504bd
 0I2fLaY0FEbrpuNvMIfCjtKeuBT72upma+6uYpBjbxQxJpEuxFqASAW39fyOwB3f1yGAXD2MiYZ
 Xh4Wxfs+CCC1O3KcNMh8Ge4W4oaYIbaJyszias3VkW8TQNh4Im9RHmX7pkD2oH0nudXtTw6UZ+i
 EaAJF63VsGXDagzx5zZVdfz5XbcYtKPO3uYca6l7dyA9vXvvZHGqXuEWybFsAXazA+IiVqFy0G0
 2P/ZGyyTs9D6T1gPvnTXUMnLjxxwDzMmGGi+2ggbrKv6e2sRPR1pOAEV89R8md3vFOamQosq2jx
 Q9/Tr/GQJrYOcZUeEhb8q7QtCyP17w==
X-Authority-Analysis: v=2.4 cv=D+hK6/Rj c=1 sm=1 tr=0 ts=69149c67 cx=c_pps
 a=JuLilwxa4atMZRuDtqj8ZQ==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=MH3SmirnJdOKttSIsTgA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: hUWWIjlzaqqPighQng0A6nFzaij9q7He
X-Proofpoint-GUID: hUWWIjlzaqqPighQng0A6nFzaij9q7He
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120118

Add gpio led support for LED green,orange,red and blue
in stm32h743i-disco.dts.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32h743i-disco.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32h743i-disco.dts b/arch/arm/boot/dts/st/stm32h743i-disco.dts
index 8451a54a9a08..f20266de4e7f 100644
--- a/arch/arm/boot/dts/st/stm32h743i-disco.dts
+++ b/arch/arm/boot/dts/st/stm32h743i-disco.dts
@@ -43,6 +43,8 @@
 /dts-v1/;
 #include "stm32h743.dtsi"
 #include "stm32h7-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "STMicroelectronics STM32H743i-Discovery board";
@@ -69,6 +71,31 @@ v3v3: regulator-v3v3 {
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-green {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioi 12 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-orange {
+			color = <LED_COLOR_ID_ORANGE>;
+			gpios = <&gpioi 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-red {
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpioi 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpioi 15 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &clk_hse {

-- 
2.43.0


