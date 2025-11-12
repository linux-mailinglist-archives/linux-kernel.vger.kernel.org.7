Return-Path: <linux-kernel+bounces-896969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A853C51AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBE874FB0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8738B303CB0;
	Wed, 12 Nov 2025 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J0tVAyWs"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A473064BC;
	Wed, 12 Nov 2025 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943078; cv=fail; b=KTfddc/Tx7MjvxEst1fPlDMIZlboVffGHHVCfw715F6oEpraO/GJ2kai4qb+LN2Vilht6MU0hRTbqd/GqVo4pCPGGm+80wVr+jCM+2r08AVLWf+oHo9natv+aPb0BXGL+HZMIRWnyqr6myBkCcaCVj4mFPHnsPgmcDXctXNPnfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943078; c=relaxed/simple;
	bh=BnWZA9pdZFtnoBLs9CS0Q5eLuK8L3TooZt8GSSJVh4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=tTbbLJ0oyKkvis3628iOmgLhEPVB4KpdiLKGJWulIjpvgwpQyS11XtPC/fSybzC4o77TMJvMoEpTlwG8W4usXi213fFNrWCpeRIM+5rty+KH0PEuLGnW/32RhyX32exKLflqmtmk1ft/b7hxSrxyNloKboafiMWXy9ESxJ2e1fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J0tVAyWs; arc=fail smtp.client-ip=52.101.53.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euetDiiUyO5BUSTe68LOW8ZgKePBR6K8Cwfg9jEvIklnUYvqJ4tFwlVLkIVY4uWOVGe/p4dU+WCRf1W3hOhdIZSxG9c/AhgP6NVCGbkKwH3bHkqkTOR5rsQbxfQCfX7UH63GyhowailzjpiKLoDoDzrdHhy1UvzFbLybeAtvIAGUNBV6VBEDsiXuz8QSymBr+XsRuGr9cCUxGqwHp4Ioog/f1OYP/iaEakv3QK0yfo56ys+lZtu3+QNG6MKkgUSc+PIb/T2hFyC8ilSPoj4xe6vpGx2f7XnL17Xdf1+9p+5JFGX5lM69SnxNnyvQcDSC2WVLYsaBvrPKAO3BAC550Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mk2H8qPpAGFioL5Cy9VRJykYCU6poPcB+DKSZmtQxJM=;
 b=yty5usLJYOwpM7AgwW2lYnGQ5oQjMwuuWrPI2EC4uLvsfSZYD2PTd2PwQwVuBCf+BT5h6lmfsKtb4GG/TIBKxV0L7gYFOAraDBJ6uAOM3/Qf9Gy3Yh/Z8O+PXHAs7YTauUMoy+VUxr5SDr3vKcZaFdG8Ow+g+hXhdbmOcnHTkXMUNT2os1Eu4IdolGlOXQQwlRL2Yds3/znOvb/m/S20LHX0sd42BBVW4Xd9vQPqTeWP4rnChpFfReTzibz6ix39O24WraVaVXJ5VVc8J8/c94hZbwMODOiihfO9L3bCyGhkzAXBlE6h60GmjTDTluVvpk0OLnbB2K/QExNmh26VVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk2H8qPpAGFioL5Cy9VRJykYCU6poPcB+DKSZmtQxJM=;
 b=J0tVAyWsr00XqdYEnO9/wheVyN1Si4t20YWWN6RE3mvEgnavvJHBnIzaeV+xBibAFEChNfnW7hoV21MhD8Gaypu15vOYQCOxZsgeOLNU/rxuhpgKk2QFPrM9jeFiuP0VrQjOuv1Y8ONAMmRVh/wQSVWChyGXMjY/8z/yVqbiuxI=
Received: from CH0PR07CA0014.namprd07.prod.outlook.com (2603:10b6:610:32::19)
 by SJ0PR10MB4797.namprd10.prod.outlook.com (2603:10b6:a03:2d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 10:24:33 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::1b) by CH0PR07CA0014.outlook.office365.com
 (2603:10b6:610:32::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 10:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 10:24:31 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 04:24:30 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 04:24:30 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 04:24:30 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACAOTr62536862;
	Wed, 12 Nov 2025 04:24:29 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 12 Nov 2025 15:54:25 +0530
Subject: [PATCH v3] dt-bindings: arm: keystone: add boot_* mboxes to ti,sci
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-k3_syscon_add_boot_mailboxes-v3-1-66155a4236dc@ti.com>
X-B4-Tracking: v=1; b=H4sIAFlgFGkC/4XNSw6CMBSF4a2Qjq3hXt6O3IcxTUuL3CjUtKSBE
 PYuEGMc6fA/g+/MzBtHxrNTNDNnAnmy/RrJIWJ1K/ub4aTXZhhjBhBn/J4IP/na9kJqLZS1g+g
 kPZQdjedlmqHSuiqrHNlKPJ1paNz5y3Xtlvxg3bS/BdjWNwzwGw7AgWdYSSwahLjIzwMda9uxT
 Q34LeEfCXnMpVE1mLRQSQUfaVmWFykJQJAPAQAA
X-Change-ID: 20251105-k3_syscon_add_boot_mailboxes-8452bdd98962
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
	"Anshul Dalal" <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762943068; l=2968;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=BnWZA9pdZFtnoBLs9CS0Q5eLuK8L3TooZt8GSSJVh4I=;
 b=MvsYmuIZfYBxx7udQMpxMEa1opPAkZ/FI/2objCMjwN6i6oBZyTB1Vo+bqiRu+mjrICkGhGtP
 9bezfDfidQfC5vlw8HdzjV7TuXlyIc6vP70eYl98yQrgiWaOcEDr/C8
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SJ0PR10MB4797:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c618fca-d758-4eb5-924e-08de21d5ab42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QW1uSWthelBudTJOWDlQMENKK1ZDV0c5WGtUVUQ1OXpSUitYOU8rVEErU0ZH?=
 =?utf-8?B?VEdpUDlyQ2RXSTdZOXNkeCt6QVJ1c0ZVdlR3d2tnckIwZDlUMXdFcytUai9B?=
 =?utf-8?B?QWFEVXh1T1FqVjRIVW1OekVkRWE4cEhTVlFNQU9wSWhpWHdibVBZODhPOVNK?=
 =?utf-8?B?TmVZUFhOb3l1cGtUUFNhNWdKUHpkdHBFT05YMWxvM0RMSnhuQWlXaktMb0Z3?=
 =?utf-8?B?SjJlUEI2QlhQcWxUME9ocUg0QUVDeExkL0NGNXBDUm9vN1h0dmFXUnZVVlVP?=
 =?utf-8?B?ZUFwUFJMbE1EVjNucXZsSm5qWVVaSzlLQVhZS1Z3ZVA4THdBdEZPWWYwTlVa?=
 =?utf-8?B?L1NleFoycnVWazgzR2hqM0dzbCsxQmJyMERRZGQ4WGJrdXZVeDlobGIzREpN?=
 =?utf-8?B?RzNka0sxRndyZU1qMXRSak11ZHh3WG9KT0p4WkMvZHhsSXcvR3Btb090Z3k2?=
 =?utf-8?B?MldOaUNhQ0NKcXIxSnk3Q1VnbS9YemloV0c3dUlaMmpvTFExRDBLS1VabUxK?=
 =?utf-8?B?QkNvMnBnWk5GcmRLYjFibi9vSG1YRVYwUGx3Vmd1TWI1QzExMHRpZHM3eDlT?=
 =?utf-8?B?QVRpT2lsM09tTSt6V0UyWnQ3RUNlRk52NElmN2d5Y0J3UitLbDlOWGxYckRX?=
 =?utf-8?B?Y2paaDVpL1JXakNpaUlmbTVVWUlLZElvTUlyN1FZaDJOVUlkdEVZSE1IWDZu?=
 =?utf-8?B?SWdDTVczcWZKQkt4c01JOG16R09WTU1MNDhvZ29oZnRxcmpJWGgzMWh4VlhF?=
 =?utf-8?B?Y01jVVpqRnRUZStvaFJVejVPbXVNOVhOOXkvanRINi9LZzhsZkRWRnNsZU9u?=
 =?utf-8?B?RzBna2duSG12dTBGZHpIN2JZNDU3NHJPcXpnUmVuV28wTUpWT1l4WjlVNm0z?=
 =?utf-8?B?QmdTa1Q2U0MvWngzcnE0cEFqZUhGdEkyQk1zaG9tazZlNzU3cVJIbDQ1a2g0?=
 =?utf-8?B?TTdmdDRkbkxPdVkrNm56NytQN3YwZHNQckZ0Q01nUkIvQzUyTnhKaTJSbWxT?=
 =?utf-8?B?TmRyVGduUk9icVo5VnJsK29FMTViaHkrV21acUMyUkg0dkM1L0lNc2FnbVFj?=
 =?utf-8?B?MDh4YklZS1p2bXRuT3RsbnRhOHBRN1JBbGpTcnZGNW9ZeS8yZ3dLbmhtaFlM?=
 =?utf-8?B?ZHQ2Z2NZMzdST3hoaWpFakhIZ0RPRHllcEFGQ2VsQ3FsRXZSL3daZ0dwZ3kx?=
 =?utf-8?B?cGkySWNTdFVpUjBabm9ONTJxRW1ibGR3S2xOTUNYMlVZbXVkS1dTSUEzbkk2?=
 =?utf-8?B?aDVkOVdwNnovZ05rYmhUeEFuZVIwSmZSemZjVGZnY2piSSs1WmppLzd1Z2x5?=
 =?utf-8?B?SzV1RURkd25ZbDZPTEJVVmhZWFNxRE5WTVplZFVvWnk4K0FkRXFnalA4NG43?=
 =?utf-8?B?cFFSaDgyYkZpeXhOMmM5TnhMeTFlbE1lY0VRVGdxNzhaNzcyUS9oMHY0dHlm?=
 =?utf-8?B?ZG55dUY1QnRiLzQvYUM1bkRxYVl2eGUzM1BEczhQcU9nZUVYRE5ncktZSUhW?=
 =?utf-8?B?ODBHZkpXR0xVcEFzWXlVR3F0K0dTWldnSkJzYUNuYThxZHc4MllxeUozLzBH?=
 =?utf-8?B?RG9rb3FqN1BFOW52Z1BPODJyK3hKVUVoamNrQTlQYUxTamtIYWdZZVR5b1VD?=
 =?utf-8?B?RUI0dWc1ejJwSkVtT1V1UVJmSHVFOUtMOHNoWDh2Qi9YbEVjY25vek5xcjdS?=
 =?utf-8?B?VnV0cWoxU0libTR2c3Z1S1ArZU1pZWFYM0lTU3RFNmpRNnJoUVVlRkN5YUpj?=
 =?utf-8?B?eGdoV2hpM0RUZjdESW5hME1XNEJ3aElLUTVlUXNDTUdla25seGw0Znh3RUFS?=
 =?utf-8?B?K3VXcVJiU2NjNGNFV0IraFBZcGIvNWM5RGkyUTRrNU5YOCs2MCtVUU1sMkVG?=
 =?utf-8?B?R01vMm1Ba1hWdStRcnZ0QUVMcGN1cWhDbDZVeXRndEpHNHE3M25sUG8wcEk5?=
 =?utf-8?B?UVBURENQOEYzVzV4Y2g0SDJqd0VWdm5Ga1NHNnZnbGlmeVJkbkRiME1BS3I4?=
 =?utf-8?B?SFFEbjVma01icE4zYTc3cFM2RUFVNWd1SGNnYXlQeHpya2tVbnd2dzJrbmg5?=
 =?utf-8?B?d1ZjZlIvaWlLb1VLNndCcTJGeXFZYnFYYzRibDhiSW1nMVFxWUxLWmZHSGN2?=
 =?utf-8?Q?RsI4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:24:31.7675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c618fca-d758-4eb5-924e-08de21d5ab42
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4797

The bootloader on K3 devices makes use of mailboxes as per the ROM spec
which might be different than one's available to the kernel (firmware
spec).

Therefore, this patch adds the missing mailbox entries to the DT binding
to represent the mailboxes exposed by the hardware during boot for the
purpose of loading the firmware.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v3:
- Drop [1/2] of the last patch series
- Update existing example with boot_* mailboxes instead of adding a new one
- Link to v2: https://lore.kernel.org/r/20251112-k3_syscon_add_boot_mailboxes-v2-0-aebc1e47b391@ti.com

Changes in v2:
- Remove maxItems entry
- Remove RFC tag from patch (added by mistake in v1)
- Document the new mailboxes in mboxes instead of mbox-names
- Provide example with all the mailboxes set
- Update commit title to have "ti,sci"
- Split into two patches
- Link to v1: https://lore.kernel.org/r/20251111-k3_syscon_add_boot_mailboxes-v1-1-529a27f21076@ti.com
---
 .../devicetree/bindings/arm/keystone/ti,sci.yaml      | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
index 25a2b42105e541cb3c8ad12a0dfec1af038fa907..be8a5b2b051b441884795059c70892910d981130 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
@@ -51,15 +51,27 @@ properties:
     minItems: 1
 
   mbox-names:
+    minItems: 2
     description: |
       Specifies the mailboxes used to communicate with TI-SCI Controller
       made available from TI-SCI controller.
     items:
       - const: rx
       - const: tx
+      - const: notify
+      - const: boot_rx
+      - const: boot_tx
+      - const: boot_notify
 
   mboxes:
     minItems: 2
+    items:
+      - description: RX thread
+      - description: TX thread
+      - description: Notify thread
+      - description: boot stage RX thread
+      - description: boot stage TX thread
+      - description: boot stage Notify thread
 
   ti,host-id:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -90,9 +102,10 @@ examples:
   - |
     pmmc: system-controller@2921800 {
       compatible = "ti,k2g-sci";
-      mbox-names = "rx", "tx";
-      mboxes = <&msgmgr 5 2>,
-               <&msgmgr 0 0>;
+      mbox-names = "rx", "tx", "notify", "boot_rx", "boot_tx", "boot_notify";
+      mboxes = <&secure_proxy_mcu 8>, <&secure_proxy_mcu 6>,
+        <&secure_proxy_mcu 5>, <&secure_proxy_mcu 4>,
+        <&secure_proxy_mcu 5>, <&secure_proxy_sa3 5>;
       reg-names = "debug_messages";
       reg = <0x02921800 0x800>;
     };

---
base-commit: 4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
change-id: 20251105-k3_syscon_add_boot_mailboxes-8452bdd98962

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>


