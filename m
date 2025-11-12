Return-Path: <linux-kernel+bounces-896750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4035C511FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D2D3AE86C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A22C2D9EF9;
	Wed, 12 Nov 2025 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mfM9xnzV"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76452F28FF;
	Wed, 12 Nov 2025 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936271; cv=fail; b=W8Akg+FYLg546OYvTZBQDT0rIA9yC5ULGaZY+T5pB9yK15B3Hh6s83YidrMmnm+4CdvOtk3aoT8bBM3Od7FjT1MknY46AuCehyJwmhUH+MtwBXj+0e4g21EF8SxAca2u1E4FuiZGQgIpfNnimC3uN/C1emB8BCWncewga7Dv5V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936271; c=relaxed/simple;
	bh=8KAqWDZvkvwKl+g5oCPLC/v7Gjo9zRGUTbeaqL7rm6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BgIzAr1RcEZ+iSPne4gjJ5zsor/6Zye8ZLse8e9nTl3DjF1Nk2vk5WkFvgc0Lmos4F4slMA8WaB/oid+qaihlOjy+BXXZNpDXsMTjc7UpxFvRzmORyzNjEt+0x5EdL4QiBIQRE3Yc6dWHcXXzowzmk+KocfVYb0MhikNek722y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mfM9xnzV; arc=fail smtp.client-ip=52.101.46.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/c4EB3Yr1sHXuSwa717u87I8PLz3TAKZWmqoekBz/zzSFVRVsg8NxaYqy7Qo3VxU4E+RmsW3iiJuvuFiyTMpSlOapiG5kYSlJnVaJenO460XxL5vUqf9qpWZM6zN2yijhtkY6MMa3ilR7pyoiESuy6BIfKHl2LNs/U6CJAuYXJg1/rNHZQNyTARA8b1RnhUqxNSA2CwPdT/tD/0BROqZ1A0eaYEt/OL8jf8NkfThzCS1ZPPtNO67FhXjsTMDLPSoe9C9R5QllpOSGPHwlr+r1v5B37amk8N+bgpNGv4QLVSYk61UdR9iCdOGWgXMXthNM9DH6CmvoG6McE3pE4Snw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXt8rIjIe0VxSQBYLwgNlKzhnn4QLU/JOkXe5wfgpcA=;
 b=wleXdcNoeDxd/ZVB1tNUBwuvYtTZ+HAR20/iADu+9in2j9lAAyG/WgEJDeQlWuH+S9VovpMYj7HVP4903sMMtDADuv/g2cD/ppK3q7NHJDl+hHC8325tSS1AGTa7hHYqHaMJ4HEL/Qsy+XcO7SNx/pHzo1JY6n+YoecJDkxYPBoWK5qlkFXNuIM9CZaBn4f3ILQfJnJBN3ijw3xyByKARNSK5WjEkV7ckfSsJCOLnxM7gg82leJIYRwZa+gQ1uDhV6Tb4SYCyUoz6vm/IhMECgZ5Gt/5lxBtIL4JI8wxZgP74ZX5itPTSbhL0G1VL09OZhbuBm4gr4dn62Okma3qeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXt8rIjIe0VxSQBYLwgNlKzhnn4QLU/JOkXe5wfgpcA=;
 b=mfM9xnzV7NViFMUDDlzZcUYIvh159IVDr+TvSTcRJ5+RvDRspnMArrQnd6LJmwMlR2j8U4W39uCX/boR1wE4TlS4wUprt2QVLoNHLslKqHZTF5i/Dd264gfRVUYYlfhE17uNW3FeBqkHo7kWW1NhDPVlhk87pJfNDeShEuJPEG0=
Received: from BY3PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:217::23)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Wed, 12 Nov
 2025 08:31:06 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::a0) by BY3PR04CA0018.outlook.office365.com
 (2603:10b6:a03:217::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 08:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 08:31:06 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 02:31:02 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 02:31:02 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 02:31:02 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC8V1vW2389899;
	Wed, 12 Nov 2025 02:31:02 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 12 Nov 2025 14:00:53 +0530
Subject: [PATCH v2 1/2] dt-bindings: arm: keystone: add missing items to
 mboxes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-k3_syscon_add_boot_mailboxes-v2-1-aebc1e47b391@ti.com>
References: <20251112-k3_syscon_add_boot_mailboxes-v2-0-aebc1e47b391@ti.com>
In-Reply-To: <20251112-k3_syscon_add_boot_mailboxes-v2-0-aebc1e47b391@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
	"Anshul Dalal" <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762936259; l=1128;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=8KAqWDZvkvwKl+g5oCPLC/v7Gjo9zRGUTbeaqL7rm6s=;
 b=3Sh5JGf1oRhfp9l1GzQ/XP98nuls7mIxCi/hNdf7t4Ol+Rv4q8YZ4sT+U3wHi8tS23N9CdMWO
 SHpm35nBXn6D8YUrnV6zB2Yta1LaZJHTop5YwvL93SU66ng8hUWD5bL
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|SN7PR10MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: ab36e710-a97c-4f0c-7584-08de21c5d2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2tUTnRVWlNmVlg4NXNkS2x6b2NKQ241U0JLRU1NOFMvWUZ6cVJqZCtvdDRC?=
 =?utf-8?B?N3hBaW8zMks1b21ROG5UcDBMYU0yVU96YWV5WmFMVDJ2dzZPNjdzN01iZ1My?=
 =?utf-8?B?WWdzaUh2MUlSaGhyV0x6bStVTWExY2hYdk5BTE9Db0VWZXFzWHNuczR6S0po?=
 =?utf-8?B?RUl0RXNIc3pCVjFRSEdCUUIzSmJZU21JSlFRaGpuQ3FLUGFZNWtTaEo1UVoy?=
 =?utf-8?B?QVZpdGc1RmRKQmZ1bWcyTnZtQWZwY2lCdUJRakxMRUFUQWxpMlFLTXBkOEQv?=
 =?utf-8?B?TnBxRWdJQ1F1cDA4Mm94eEtYYkJvbVVtLzVwbjhHK3R4RkMycHNCK0JkSVla?=
 =?utf-8?B?Y1hLcmJGZkszbUpTTThhR2x3KytKYnc2TDZ1YTZiQnRRRUJhQUdxRzJodHc3?=
 =?utf-8?B?Z1VwQkg1MVVYMkNPOEcxSWF5YVdITlV0cHBDc1dFWGlVRXN2SjhIOXF2ZURD?=
 =?utf-8?B?N0lBNDNrOEJ3alN6S2IzM2lBNVhwS1IyMXh5dnBiN1hJNUZTSXowLzN4eERm?=
 =?utf-8?B?alBFdnVVMVZNWmF2ZFkyQ1BDU1NtVjRnQ0pZUjBUSm8yWHFJbCs2S0R0SlIv?=
 =?utf-8?B?WURMdGRKeXZpUVhOdFZoMHlJZWlxVnpEZEx2UHEwWmFMR0c1dGl4c1BLSm1P?=
 =?utf-8?B?ZlB1Z3ZUTlQ3R2FlUnh3c0t0VHJFMnBRbE5VdUdGSXB0akJpYUNqR2Rkc1Fp?=
 =?utf-8?B?ZlcvL0t4eWtZUWhSU2xiS3ZqTTN2bWx2VWFMaUg0cDFHQ3pNQjZNcHhzalI2?=
 =?utf-8?B?WnFleURQcnlUNm5tMHowZFpSUWtHaUZ3S05iS0czV1BrZWVTN0E2MW9TY2Uw?=
 =?utf-8?B?VnpVUkxDUmhybTZaMVRNUU14dUFJbmlTWXV1SzhoTWhUdUcrK2FaMXd2NWsv?=
 =?utf-8?B?V0YwQXRXR2NEZ3NxRW9yV2ZzWW1UTVFtdzFKMmsvN0NuVWcwMnZmQ3BaQWow?=
 =?utf-8?B?OWFCWTdPMVpuMWlVOUNpRW9YVW5xL3lSOEs2aFZMYjlvNTg2b1Z2bTZpeVpy?=
 =?utf-8?B?R2VWaHJueWJha0dOM3RwQUxOYmFPSWZGSU9HQW9nZWZyKzNnRlM0SDJPUTB6?=
 =?utf-8?B?MTNRMkdwZXZjMzJFNXpCaVl6UVJxUWZqcmkzTVg1TFI1dnNyRGRRQkR4MThG?=
 =?utf-8?B?UmNOV1B0NkJGYlFKV3ZtZkU0NWJKU2plbkppMmtmVzF0eVNQNUtqd3crTFgv?=
 =?utf-8?B?czVtMWxZR0RPSlZna3ArN2h6WCtLVDFqZzlWbHBHQytramZQVGZzT2s4R1BF?=
 =?utf-8?B?ZnE4bS8rUThMeUs0NTZHa1plaXZoMk8ybGgyRTZpREFPTnppNGdXamF0aU10?=
 =?utf-8?B?NGhqSU5NQXdudUgyWlBkZ1lSZmFvREF4TEViWHc2VDBNT1c4Q25KYUMvNTBo?=
 =?utf-8?B?cDl4Qm1ta0lNVHBVaUdlQTE5VDZtcytQWStpUEdFOC8wczZHMWYwWWllcDk2?=
 =?utf-8?B?Z3M0NFp5L1Nqd2QvMmd1UXl3Z01rMGNJU2hWZTFSTDlpcnljbk1tZTRHaUda?=
 =?utf-8?B?M2Z2aHQrQ0tUcDY4TFlHbzdHZVAvd3UyNGVBMnFldFFBM2kzcEdJRllibWJ3?=
 =?utf-8?B?Q3lQVFN4UzBSRXV3ZjlNK25yM0xFRDR4eHlncGRvdHZqNlUwa0ZUbm5JaUxs?=
 =?utf-8?B?THlKR0p1VVVlWGhOSHI4SGFUU2tDNU90SU5ueUxsUlVUVElTWkQ0Q0NtaXhB?=
 =?utf-8?B?K3lremk2TWlvMS9GTzdJYWRlSXhmcEIzNkhWamt6c3dONFNmRWFyRlVQb01P?=
 =?utf-8?B?OWFYUWZSekNlWmZnVWk5bE81MkxYMlM1eVY5QktWTnZxdHBKMkkyb0dJRUNv?=
 =?utf-8?B?VUFpdlI0RVpCUmlEK2MyRHNyQUlVY2U4cHRiY1hPQUF6SnFQeXdZaGNkRWRU?=
 =?utf-8?B?bERiZnl3dTQ5UXluMWdidHF6alI1Ukd6Z2xHdDNIVmM0VkhHUWp3YVBEU1o0?=
 =?utf-8?B?cmFxWTNubEdodFY3aVFYcU43dkVSN1dxYW14MUtwQnRKSU5oYi96Wm5JdUp1?=
 =?utf-8?B?UVhXZHZyQnA5MFFvRi9MTnpZeGRaRmpNTllKekhERWZBTnoxRjFjUzVETnFG?=
 =?utf-8?B?bzJxdkl2bVhMM2JmYjB6TmlYbjZvUDI4MnlMWDU3Ny9kaHZyK0NxVG13MGdL?=
 =?utf-8?Q?rFlU=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 08:31:06.0124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab36e710-a97c-4f0c-7584-08de21c5d2b9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547

The mailboxes for the ti,sci node were not documented, this patch adds
the description for the two channel entries as per TI-SCI spec[1].

[1]:
https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am65x/sec_proxy.html

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
index 25a2b42105e541cb3c8ad12a0dfec1af038fa907..182915c34fc1429fb627ac44c99c0c76fdf28e0f 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
@@ -60,6 +60,12 @@ properties:
 
   mboxes:
     minItems: 2
+    description: |
+      List of phandles to mailbox channels used for receiving and transmitting
+      data from and to the TI-SCI Controller.
+    items:
+      - description: RX thread
+      - description: TX thread
 
   ti,host-id:
     $ref: /schemas/types.yaml#/definitions/uint32

-- 
2.51.0


