Return-Path: <linux-kernel+bounces-837929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9C3BAE15E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED73516A921
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4301D5CD4;
	Tue, 30 Sep 2025 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="faG/AC4J"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C587B22AE7A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250852; cv=fail; b=dNZUkX7lqM28V71g0MD0ki7Y75KSfePoYyS/vmGPK25pmSoWTUy5yp5H8c1B3qhwIR9P2tidsXNVc0XmlOK46McBCuDhy577ZbORSfjHTn0TC76wlf2e71K4ptlTZD1lTsMk6damW8OeRY+srfz6u/nztcliEg8/va5KxRXFaUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250852; c=relaxed/simple;
	bh=78TctiDyp0VUOijgMiPbSvP+NHoJuI5PlHA7ysKrj9k=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=m+2kBFC1a8JRbLlfHTXK7auaVVsuZ0d2gaC1FahRwXtjdmZBeIxcnMBN3fyeKi0cnFjROXlFw1SGCxRFQvHHW4qyQuaV4VDJ3Wg8ztSHeLLBt1IiBGKVpVpvokQwF0MtICqeLbWW7a8BEHgEhMZRE+uTtllph0kKHafLS5kJnfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=faG/AC4J; arc=fail smtp.client-ip=40.107.200.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWs32UxhbBj5g7vZOq2tSpQzFPF8KapOgmglFPsad+/Y0E/+jDSIZNYX30wpBMXcSaIYVJ2YMgWVjJxtV/iANh0NpNxlBeh4F9NhSnhzQTqXOfG1aw/cuHzM61nUQ0rVuGJaCn+f47OLDw5rYGHiDT2Aoo3K3u7V+w5NB733HuLq7qn1Cjrz9Qfq8c8ad52ZTChSXyF2jHAOHVZsyscEb9hMeipmp7NLo8Ab6OBsu6vcFEjg3RKdpDiOJKj1X27wIDuy1wz2xVWojIcSaFAYQ11iTK+wAaZkG27T+27wVDqodbvCyZ61iBDLhZeUxBzds1rT460GCqQmreHo1SVcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee/5aiyedpF+zh+pxz3CQHo+M95ZT/s4qj80WykgZLc=;
 b=hfFrwgPTC6aFmNT7vqDLVFX3HOgw9Xo7DmxUVXtWJYdFZQ7kv76oC3dlYGyIwi8IXI305/owqkIiEPuCHntQG2MSOws1WjbrHQKBeM1R/g/K4OJ3wdc1SnQXW8PXDe7ynEtOqJY4I7Qzt6CMVVp3X/AgNksHiRjiNluPI7Eu3IaGt/IlcaXLhOrmHoe1Q9HbAYt9NIK4OB25fsOTKLxP17FNkn/IA/z5b9VSNL8xfPbsahAezjqKcd1hX/AmhpPGoO29KLlpExCeI6MgC8mLjmSIySuNNMmle7RdYioA7kssSz8VlkNLTbJwh1EDRWbcaFXWip8ZFx7gAtj8AfYFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee/5aiyedpF+zh+pxz3CQHo+M95ZT/s4qj80WykgZLc=;
 b=faG/AC4JxKjHKd5OA8ZR6x9CI/HxGkwpZ7bUVrX3+CNxWxY9MfoBlomGfGAasO2FHL2ih2dj/X6MT9hB66w1lasWEwbKdDmlPeKJZ+PAp07BArQdno4uMIPGZ/Ld/fgMYxjVOq4j3TLpYS/spUTCB3c7nxzZEd/TpAWVHi6Ubkw=
Received: from SJ0PR13CA0089.namprd13.prod.outlook.com (2603:10b6:a03:2c4::34)
 by CH1PPFC596BECF8.namprd12.prod.outlook.com (2603:10b6:61f:fc00::621) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 30 Sep
 2025 16:47:25 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::ad) by SJ0PR13CA0089.outlook.office365.com
 (2603:10b6:a03:2c4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Tue,
 30 Sep 2025 16:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 16:47:24 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 09:47:23 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/2] AMD root search fix
Date: Tue, 30 Sep 2025 16:45:44 +0000
Message-ID: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADgJ3GgC/x3MQQrCQAyF4auUrA1OIy3Wq4iLtI024GQkKSKU3
 t3R5cfj/RuEuErApdnA5a2hxSraQwPTwvYQ1LkaKFGXhlPCu36Q84xeyorEfUeDnNueGOrl5VL
 3f+56qx45BEdnm5ZfJLPaU02OmWMVh33/AtxrQvSAAAAA
X-Change-ID: 20250930-fix-amd-root-2a6529e8162a
To: <x86@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Filip Barczyk <filip.barczyk@pico.net>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|CH1PPFC596BECF8:EE_
X-MS-Office365-Filtering-Correlation-Id: fffaf7e9-5fb5-4b72-354b-08de00410895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXdmZTNRcUJLOXQ4YnQxRzNrY1JHVTUxVDFzSHVTSzJNMS9LTVlDUlcvdFJI?=
 =?utf-8?B?NXJNT3YybzdVRDVrSERjSGdYTzRjbjF1UDgxR2tyQUxwUi9uRmxRWVN1TEtq?=
 =?utf-8?B?bmRVanMzZEM2TUIzS1M5MkNUMUtPVzRkM0M2Z0tOVTdYKytRKzI0N3hTWVJs?=
 =?utf-8?B?ZTlqb0xYVEc5ZzZjVUppVm5Mc201L0pUL1ZNNHE2U0VwbTN0UmVTV0wzNHlM?=
 =?utf-8?B?R2krcFQvaDZmY1RFUmszd0hZK2JCbVZSb3FOYitzNi9tLzRkaXgzS0ZMQlRH?=
 =?utf-8?B?c3k3eU5PNEJ6MDZIWURsSG9wa1NWZGMwSzZLd0JCRDlSVGo0a0ZWSkVwK2du?=
 =?utf-8?B?V1BDUHhjVUFaa0tUb3AwYnlaTTZNRGphM0tnMG5rNkpJUGxqNktpZDdpTmVP?=
 =?utf-8?B?enFZVEZRZ0d6OUtxSTZkRUtQOFN1OEJUOVV4UnBqcUhmT0V4MkhLQTJnNWgy?=
 =?utf-8?B?bnlLOWxpcU5GcGxZdmVpWDNjS1RZRzNPdzhPWnRYeHdvR0NaMExXaTR1UU5j?=
 =?utf-8?B?ZW9ubDkrMDB1UWo3UE5aRU5McDRtWktYZ0RwQ3V6NXRvNUJKckY1Tk9Id0VH?=
 =?utf-8?B?Y2VnWWRpMElqMFBvcDZBbXB5Yk1INlVDbGdIRVRyTWZGY0s5V1V3VXVieUF4?=
 =?utf-8?B?eUZONWRWbUR3VkFOUjhGaDdwVXRsZGNIMEZZMnBOeUJKbXpyZ2R6bGJXR09u?=
 =?utf-8?B?YWVKUVMvN2ZOMlh5VGVVT1V3dHkyYTRGYlZnSnVUV2Z4NEFIc294SEdQbW5h?=
 =?utf-8?B?b1YySHkxQURIcTl3YnFXbnZiY2ZtQklSUjRNUjV5SWEvSXJhTHRZLzJoWW9B?=
 =?utf-8?B?cUtvWFRqUGFmTGxaL3J5Q0g1Y1NLR09kamJmY1c1YzZmaC9DRE5SbnZScCta?=
 =?utf-8?B?RTI1MExtVWVNTFEzQ1MzTnpqNTNiZTdXNVNHaUxhcVZudE0wdHpmc0gzL1B0?=
 =?utf-8?B?WWpvSUpEa3I1VjJFcFpNalBOK3o2NVJFQ2xwSkRaVW9oNzlXVHRGcnB3SnhM?=
 =?utf-8?B?MmYwRFIzVEdnWXBpWE0wcVpwNEFTQU9yeW5xVm00bG80U2xKV0VWOEM3QzYy?=
 =?utf-8?B?K3FLUGp3QkZzMTNJaW84US9YYWU0ZU85cFFSRlFPcDQ3VlVlZmtEQzh5eXVS?=
 =?utf-8?B?VXR6VFpmQjA3eDVvSE9JTFY3bGVQVzUwTllPYlJwczI2K0p3dlhjTTM0ZHpR?=
 =?utf-8?B?a1o3NHYyZE0waklBS3NsYUd4cTJFenlQQ0Y4OVFQUE1XWWRHR2RwemxHTTN2?=
 =?utf-8?B?djlRTDduejVZU0cxVENKR2V0UFNKU1VLdFFaZkd2Y2dqSGdOMHdzTVFTLzNz?=
 =?utf-8?B?T1hwYm4yR2JUR0ZmeWN5QkpuNzhvS01GUEJvWGxrWGVLbGdWK0pnVUVRVUV2?=
 =?utf-8?B?TE5iWjZhWkc4K2RyV0pFckFESU1hQU03ckNVWnlVRXJyUGtlN0NIWjVKTDV4?=
 =?utf-8?B?KzVvOTc2U0NUVldFYlo0VFlhLzVCWW8wajNqYXZYMEI0WmJqR0d1ekZRd1ZV?=
 =?utf-8?B?UytaeGhQek9HeXRoZTB0L0tPQnV6dUJwM0tIOTlNTFdxNWIyd2pBb2xWMzdo?=
 =?utf-8?B?QVZsMG5mT1o5SnZWTHhzZThyUmN2a3pVUGdlWnFXelF1SlNQY1drb0syb3E4?=
 =?utf-8?B?a00rMEErb0lxYmhyL0U5RXF3VVhmejViZHNCWll1Y1dBRGZkcWRRdzR6bks2?=
 =?utf-8?B?VjQ2Z0dIb0JRWUx6ZjFwUjdkSGxyaml4cldacnJ6ZTFiV3Q5a0liYTZ0VFJZ?=
 =?utf-8?B?MEhmbzlRY1dIOEkzUUp3NnJkNmxDdzhOc25jeS9tL0N5Z1A1S1BiajJVclFL?=
 =?utf-8?B?VUU3cTZySkJSajU0UmprTkJ4UFhOYVRNRVhnZnYzTGg1MlpSSUU3Q1hvdGtT?=
 =?utf-8?B?YzhZd0xoQWZLZ2NOeDZ2eUo4K0MwQ0ROWjdPd1FzOFhYc2NuL3o0b3dkMUpJ?=
 =?utf-8?B?SUViSlZBNmxwNTY0Z1pVeVNCVTI4SkZUVjBhRXBlcTVTTzN3b1RvMWhEdXls?=
 =?utf-8?B?NTNkdDRDd1NVRnFjMDRuVjRSMVhIemExM3k1SmxzSDBzWDFBbmY3V1FjNjh4?=
 =?utf-8?B?a2JKQXhsYU53aHIvZ0NvVSt6VG1VMXQ4UmdmRXBZYVBmWmlYbHR1ZGJ2SVlz?=
 =?utf-8?Q?NdfI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 16:47:24.8743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fffaf7e9-5fb5-4b72-354b-08de00410895
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC596BECF8

Hi all,

Recently, there have been a couple of reports of the AMD64 EDAC module
failing to load on v6.14+.

This has been root caused to the recent AMD node rework. Specifically,
the root device caching method breaks on non-reference boards.

Patch 1 is a proposed fix.

Patch 2 is a minor cleanup.

Thanks,
Yazen

---
Yazen Ghannam (2):
      x86/amd_node: Fix AMD root device caching
      x86/amd_node: Use new root search helper

 arch/x86/include/asm/amd/node.h |   1 -
 arch/x86/kernel/amd_node.c      | 107 ++++++++++++++--------------------------
 2 files changed, 37 insertions(+), 71 deletions(-)
---
base-commit: 30d4efb2f5a515a60fe6b0ca85362cbebea21e2f
change-id: 20250930-fix-amd-root-2a6529e8162a


