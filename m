Return-Path: <linux-kernel+bounces-895163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA51C4D236
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1661D4EFE89
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE5834E763;
	Tue, 11 Nov 2025 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hxwI973J"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1B2F3C3F;
	Tue, 11 Nov 2025 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857479; cv=fail; b=Os16JdHlM8rLPotbGAmHkeZYAR8OZAY75wHNCThMPXs0GpoIckWg+lOOfPNJXlA+YPgVs16syKKCSrglLe0FEBUqxvz4Lpo2Z4ym+pMPgNxI7bA7lQdwIdCKA4wxhAaWrA1BeA+++nuxLXf0Ij6O5apP17UHiqZnPUYikL71OlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857479; c=relaxed/simple;
	bh=mj0q0SnTkW02eP9ExxyFhZNUJ90oEVn+DZtgzBwS78s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=S0x2JL8D19TDKC1Qf6tSJSC0sCBWXBeo+4iAqW7ui2g6uY3JluOwgYLRoZLM9t8RQxgn4moZ/8WAWVNNY9iU4PaCEycVTWK2b5Y/C6CDhxBYKiYo68Bl7SaKzISIRV5y8aHVPFr5C/rQmEbobx6gwcnayKuY8tbl82Mczf3lia8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hxwI973J; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZChkAM3zfRq3HiA/3ZUOUKatpN6y4O+4AJwwZr75df1hPA9WdjxhCJBrEksdwMjcrDqYERkdpLPkrTfqagY+Rv9UysYYNLz3f1TXJaglB871PKWYLQQIyaa7AbuLBNfeYkkxhcysGe1GMyRXNDEUrUvke6YZW0NTyuxC6C3iDAQv6hnFkhDBKGkRQ7jyMeqsHhUTDvPgFENcgFwQa9FQkPA6c7QEUum+f6FPlJ4AUwpZ/DIt4pnBOerGfx7rgXQEV62VCOT41fLPpzL0p1udmem25Jn34FozbT7KyXlbrVEb+/a+SsM2YmaEPLuvyuuDq48rx3W3Cn3BiW2FCGRSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eB+fhLcfB1i0mBadf1iV4l+D+XZbe35Q4EopZkorEw8=;
 b=rF2HTKQgqknbbNUpwpAubwxk+WUbvxpPCLnWCY+VcUlMjWQi9lZtREWASWIr6VChOeZVCI7w1aomiU2QqgN2032hcfSd1wkv8WY2rhKSQejbYXl6o7I8/HUtja18BBT22iAwkHiNYWl8GlaVn0PTR9fkaJwDvXNgFVrs5eYDYMIZa56cwx7CshehjZ+BljFAv+1CjjEQjizocl1wapV0V7q7Lbw3ydoSWhyts5YaFY6ocsWfwT8KTfjsSCPOwOf4A3KKcPehKvu2ttTt6pYv5BsRTOmpHIblkH7u5xCBGSfXxn6DTThRPML7F9bCx8soVyTAdaZsGGvZ98chgMhilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eB+fhLcfB1i0mBadf1iV4l+D+XZbe35Q4EopZkorEw8=;
 b=hxwI973JBMl9RMGwyiLlY8vjWlqFrWxEMyuxkkGA8GoQ9QTrfUXHHY8R0nfH5EVDxpVTOP9uq2V9299F8FD9eEZgmuij5sB+ppdSBEDF1Y0kA93+8DccKPyZjYTTTPk/F0oZTIc4CDIy9etexgU/AXNeoco65JY27vrhx68eDLs=
Received: from MW4PR03CA0225.namprd03.prod.outlook.com (2603:10b6:303:b9::20)
 by BY5PR10MB4164.namprd10.prod.outlook.com (2603:10b6:a03:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 10:37:53 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::b6) by MW4PR03CA0225.outlook.office365.com
 (2603:10b6:303:b9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 10:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 10:37:52 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 04:37:47 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 04:37:47 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 04:37:47 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABAbkhm778082;
	Tue, 11 Nov 2025 04:37:47 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Tue, 11 Nov 2025 16:07:32 +0530
Subject: [PATCH RFC] dt-bindings: arm: keystone: add boot_* mailboxes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251111-k3_syscon_add_boot_mailboxes-v1-1-529a27f21076@ti.com>
X-B4-Tracking: v=1; b=H4sIAOsRE2kC/x3MwQrCMAwA0F8ZOVtYOyubV8EP8DqktEvUoDbSi
 EzG/t3i8V3eAkqFSWHfLFDow8qSK+ymgekW85UMYzW41nlrW2/uXdCvTpJDRAxJ5B2ekR9JZlL
 Tb71LiEM/7BzU4lXowvO/H+F0PMB5XX9gKwCHcwAAAA==
X-Change-ID: 20251105-k3_syscon_add_boot_mailboxes-8452bdd98962
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
	"Anshul Dalal" <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762857465; l=1731;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=mj0q0SnTkW02eP9ExxyFhZNUJ90oEVn+DZtgzBwS78s=;
 b=N395AF1oLLoFjT9c5dLzWgWB4HxJltMuVOdbZgTCSykhGvd83ZsrXP4pW1p1iDLwzatfkYKMo
 wSFWhMCQqtUATD727SQlxHzwDC7+hjON9SRFxuPNC4rXzOnXJNAz7JY
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|BY5PR10MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: c55d4f23-c200-4c10-d7d9-08de210e5dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVhIVjIydFNJdDd0a1VZajdOWGRJZ3ZlYVhmUmc4U1dNY01vTFVoQ2RWWWd3?=
 =?utf-8?B?eGZzTC9hay9Jb25ZWWF1TDhqQ0N5TEdSM3I0bXI5dmtUWE5uUTBvc3d4WEw4?=
 =?utf-8?B?VkMzdC8vWjRNbDFpMFJ2aG11STBmVzdMTG92RXJiWnB1L09aeWw2RDNnenZO?=
 =?utf-8?B?d3QwYUNtQVVVTE0yU0Y5b3NiSUlsOEh2aDNTMUxMdWFpOTlpQlpHUFowWmpV?=
 =?utf-8?B?SWg0Y3VzUDhOOGs3bVE5WjVNVk5wdjgwRnRkTDIxVjBucnN0cEpZYnJjbngy?=
 =?utf-8?B?VHZKQzc4RTFOaGtYTGI0RFd5dTYxclNSYTR3d1cycTExZVZjRDM5ZjlMQW9k?=
 =?utf-8?B?d2EyczEzQ0xzQ0JZZWdMSklLVGlZWkhWWFRYOE1pTzhMUTBLTzZQQ1hBRnlE?=
 =?utf-8?B?dE5xcHVhU3k0ZWttQW9MTFlPSUZNOVdkT3lNSStZY1dJbCt0eUhma0VzSUli?=
 =?utf-8?B?d3l2Y1ErU2FwNkErQnhEMzJ1MWdrakcrYVNWL0VZc0JXblJqQmg5Q081bllu?=
 =?utf-8?B?cFFwSHlOaW04SlJKVHNraUVKbnJRMk5ZOUxwZUxOM3IzZU85alFBMlFBWnpt?=
 =?utf-8?B?dDV4SXlaR2luM1RXSHhZOUhsYVdZN2YybWFEWm81cml6c1BQMFduMmwrdU5r?=
 =?utf-8?B?bGYwNkZyQi9GKy9OMnM0Q29yVWh6S2hUa0tkZTZ1TzVRYW9EdVBEc0I5UU5F?=
 =?utf-8?B?WWU4dE1xSjR6MzNJYXZLVDRVeC9kWEk4TFFaZVk0OFA4SXJPMytIR0VuVU9s?=
 =?utf-8?B?R3ZFTGpUL282UTFxQVdRNHFHbnNZMlBqemNRUmxUY1ZIbTgwT0Fob0crWENT?=
 =?utf-8?B?eUpiN3JqaUVIN0N3clkwZGUrbnl4eVNRdlpQdVNpd3lReWgwWHdDbms0Z2FN?=
 =?utf-8?B?TFZ5b2l2dHk2YjNYWENReVhmVzh0aVh0RFNyOVJ3U3dDQjZSWTZPMVJWemFV?=
 =?utf-8?B?MjlYTEpNdnZMV3p0M3hQa2g0ck4rUFg5Y2w4UzZXVUVjMThWTCsrVmNpcDk0?=
 =?utf-8?B?M0MvSjJHemF0dXErZmhLUHNUckdwZDYveVJ0N2FlVW8ycGV1RHRCOE85Y2M4?=
 =?utf-8?B?bEpaRzlLd2VCK0FsVUJVS3lxZVEvem1MdGpjejc5OUZXNElXcG9DUVlWVUc4?=
 =?utf-8?B?OTRJdGNyeHZXODFYYjQ1c0hoUm9UcDdmOHlEaS9RYUp6c1l5R0hLdllYdGdw?=
 =?utf-8?B?QUlSVytTdExnbW9Rb2IyNldwUjNQSHpqRVdJYk9hRCtmcnBWaGUxMVVZbzRj?=
 =?utf-8?B?T1Rqd3dOVkhRMTVKeDJCcWRFRzRuMUZtSDFxa1ZmY29iWGFvd3RNR3g1TVJp?=
 =?utf-8?B?MnplT3JMaUlRUWZ6ZXhXMnZCZGVLb0ZzeEF0MU5JNHlVWHF1M2VydmVWUVgw?=
 =?utf-8?B?TU01SjhtRzZuYWJLbXltZ2xyNVhyOStzYmNBV0ptL0FZc1lYaE5iaFNXRXh2?=
 =?utf-8?B?aDdjcDVxVFF0RmxoV3hrMWIycXA0ZE1zZDFXSW1YeklxQ240d2xQU1ZpV1Vu?=
 =?utf-8?B?dHRWRzFNU3owTklTSGtjb3dJMFhsbjFvN0hOczJyRnFDdVg3K0pHRDZSYWpv?=
 =?utf-8?B?UUtKNlY1cVJuRTNoZnlZMjh5aThRUXNHU0pDcTc0REV3eWJnTi9kdHZGRzZl?=
 =?utf-8?B?MDlNUGVpVUNwZ0RMOWNlUHVoaHFSQkxmOGdFeGk4Z1lRNXNWT1hzRml4bTQ4?=
 =?utf-8?B?VHVRMDlrb0RIek16RFpGY3dVYWRuZVFQTFlCelNOUlBZTlZhR1ZuWlNDdDdU?=
 =?utf-8?B?aVhxeE5HeWFZRzIrWGFBcHg0WGJkRUViTnlZK1oyL3RKVFB1MGdYY0dQRWZh?=
 =?utf-8?B?UmdtNFB4WTdsaXEwQTcvazJrMHFhOVFEZWNnbjAxSjN0TFpFaUpySGdBOGw1?=
 =?utf-8?B?OXl6Q1VseUhGc2c1TkFDa05yZkdzcVVTbHFFTDI4SU81dmZBU21RNGxkc2ow?=
 =?utf-8?B?eGgveGhnSkZ4czJFRUo3cTlnVmxiSGJTMHVTMTJKYnU2WElFNGkzNFp4ZW85?=
 =?utf-8?B?RDh1VWxlWWIyTUdOVFg1QUdVdXBHdWYyZkhTLytTZWxFbjEzNjFOREluSDhM?=
 =?utf-8?B?VVNqYWN5cFZYK0Z6WnM0SGFFTllXWkpkak94TUx2T2pyMGZrKzhmR3dxM0p6?=
 =?utf-8?Q?vOt8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 10:37:52.0362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c55d4f23-c200-4c10-d7d9-08de210e5dda
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4164

The bootloader on K3 devices makes use of mailboxes as per the ROM spec
which might be different than one's available to the kernel (firmware
spec).

Therefore, this patch adds the missing mailbox entries to the DT binding
to represent the mailboxes exposed by the hardware during boot for the
purpose of loading the firmware.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
index 25a2b42105e541cb3c8ad12a0dfec1af038fa907..b5f48647a0f09bb930f052ea0f84a78525c925eb 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
@@ -51,15 +51,23 @@ properties:
     minItems: 1
 
   mbox-names:
+    minItems: 2
+    maxItems: 6
     description: |
       Specifies the mailboxes used to communicate with TI-SCI Controller
-      made available from TI-SCI controller.
+      made available from TI-SCI controller. All boot_* mailboxes are used by
+      the first stage bootloader to load firmware for the device.
     items:
       - const: rx
       - const: tx
+      - const: notify
+      - const: boot_rx
+      - const: boot_tx
+      - const: boot_notify
 
   mboxes:
     minItems: 2
+    maxItems: 6
 
   ti,host-id:
     $ref: /schemas/types.yaml#/definitions/uint32

---
base-commit: 1c353dc8d962de652bc7ad2ba2e63f553331391c
change-id: 20251105-k3_syscon_add_boot_mailboxes-8452bdd98962

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>


