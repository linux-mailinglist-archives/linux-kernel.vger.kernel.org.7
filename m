Return-Path: <linux-kernel+bounces-889208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5E1C3CF81
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAD63A708B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA5F347FC7;
	Thu,  6 Nov 2025 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DXD8gRqL"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26C5342CA9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451633; cv=fail; b=E5vj32Lb484AyaYbln8yrAHcPpTif6MqpzRcH+6mDJiHViHUJT2ZFrVqG8Oe+xWKE3b5zwPRdFkLgskdczepKDvNJcM+fFi0DB/FAesYk7YgKcomp3zc9UV/Aki7ShqO+KW0UIIbYNAdtfKk3ShF4hzhAPYi2OuHO6SZBVvslQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451633; c=relaxed/simple;
	bh=JKinFtLDshT+q60DTK9kLipkXbN1c8Ddo9TuUoGSLcc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LfFAbu4mSRsbaIAxxG+u+HH2wpTHSXwVo6kxGwZPGDVAwgmr78qxMQb1MXo7O1Iv7b5/zXwf5l4/s8rTRGfED/0iEyOCmohPIhzrspj1izVr2O1xXPz2EUGJbkg+8UIIVr6CB3DTK1O8tHYskp53mD5xFib2rHX8hQDmkY2CxJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DXD8gRqL; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e47/h4qpqkHFO5zHrJK5Pwc2OafmUgY1qQaJWgv5tqaitD/HLk2/TMs8cWyvDWq9pI5bP4ozQHr9CqbrEUiOY6qxeS8ckX2ObZ5/3koNNUfcnI78mmZ00ldgcLVBRvrWjMjlE3HudAMTft+yON/lvJiUcPr8IuzAHm+g91TZQ0g+xj5XJ1btyK/WXehZc5tnIREdac+EJstJVxSU1WrYtK4xVfE5AUQsiiX70u8ygQwMZ/zMwpaLB5cWLDds9SXeRAYLlhEWaANDHDQi1U+mCcLQP/e5SKY0x8zRNIg7zeg+/9/cGhM7aIuO+tlmbBCycXY35SD3FC78iC6aMdiDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jaa18UNBKpxxHuZAMlCNzDIwROQLhX5euQMC5vAYsbE=;
 b=qm6YGpHBkB5h8K2HswgB2ZXKCw/zjbp0aKcoZnD9pWM/AtmZ7y1E9eh6yzXTeIS3/c8eM9JCyAUZ6yg7Q5PAvAAbnIxuWzyuz7YbF36s+mdpi9M0zmpLm21/Wsl3jdxQbgkw+BCH+tGurrplf5gZAhGtATJ3bLoGRNsZUkrTQMrr0R/qSKwmfIG6i2EcCwM9XoQLCFROnk7RRdWBHmagspzZ98a52lSAE6K5LMgkLBFcZVPybLPzEv5c7ZWX8CmG8kWDSibSxl1p6txO6279kNKI4r92cOCDGY9QmEJjvhdV4iu9maFv5qioXE5wmSZnbQ/WW0VgOiWh6avpQmpnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jaa18UNBKpxxHuZAMlCNzDIwROQLhX5euQMC5vAYsbE=;
 b=DXD8gRqLQtAwRNlntNsBsBfTMMjBQSbD1EzZtnTyLaZ2Cmbr3KOdA+AxxPcsNOJo9dxl3BBd2r1nyplMedpyecMOOlXgX+XElWror/bSU1jIVLhBVWYW5fhyBhNJqYJh1WBedrZlL/VCvzhys4tzCwDRlGIBltiR9Wlz/Bd/+Jc=
Received: from BYAPR06CA0034.namprd06.prod.outlook.com (2603:10b6:a03:d4::47)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 17:53:47 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:d4:cafe::5a) by BYAPR06CA0034.outlook.office365.com
 (2603:10b6:a03:d4::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 17:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 17:53:47 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 09:53:33 -0800
From: David Kaplan <david.kaplan@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/static_call: Remove text_mutex from __static_call_fixup()
Date: Thu, 6 Nov 2025 11:53:20 -0600
Message-ID: <20251106175320.2745006-1-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: afe49af8-f3dd-4a6c-d172-08de1d5d6f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jptyno/uIN5yPBfXSOaeQhyOGY8/CphBqKfGEmzbt/cjvfBbaH92vy5P0HRx?=
 =?us-ascii?Q?QXOUbJ5Bgmt0v4MrllxnOaH3nojBwj2IlS4WnELb3lI86XMQcbRnIfIml7w2?=
 =?us-ascii?Q?LNNSVLczGSG7OWgSkh+ooY5kXpnxAMiUXlJ9oHb9OTPw+jx/y62Kb+N0WTwI?=
 =?us-ascii?Q?05+v3sPuwHbqj+wDjBgAfrd6W0ZQmD52FryjEJGqWQPSfcepZZqVOa9kzDHJ?=
 =?us-ascii?Q?XkpWOF8loiq+h7o+dOkBKcplttOKz4Jc3c+kn6/4oh7CeiMSGN+kD2NCRu75?=
 =?us-ascii?Q?B3qNKI2Vr3h839KQXLZkp+he94Dr0q7P1vznU3aw9oAEQ4msPT3Hcka9i6vQ?=
 =?us-ascii?Q?70+HoF0/PBKI2uUq1Hc8frB/x89rKztBXDfcjcCr2B9U0rgMcF0Wqtc658hM?=
 =?us-ascii?Q?UktbdEdOaxCDdGDqh/9MZjzcxVoXTYzfbEsHBHnl7qMgd7Y5JVXQBvjfSKkw?=
 =?us-ascii?Q?MTCQ3nTxlG6U6QGH6oHqCZgGLTi5H4LzsjuwzhPsqRgYRKM+eZnMWvs2dafT?=
 =?us-ascii?Q?UzsPQKhnHfjkDE60W6xXfmMz1d7QmE4xy6/L+niT2mPajN9lLq8RHIpUogi1?=
 =?us-ascii?Q?CZJ0Wb4kUWSpWwoUzbcunIRABLVL11zMr6q9wvPDVusRYlNCtBlUaOBq2o3w?=
 =?us-ascii?Q?4geyk4XxG7DAWtSp/15pvAfewdTzwI9fvKx/TaCS1luR/Bqfm1a6C7AUKtoW?=
 =?us-ascii?Q?QQ5PiB2Sta4Sh+etTlFxvAJAQ83fkP+8pv7l/wiE6oui39Uy3TTZtaP//IhF?=
 =?us-ascii?Q?WSj3VuIbjQ1I6GF6hZZ/e+Dgs68a/hVEywg8j8F+r7EV1lKVEckRAl3fPgaR?=
 =?us-ascii?Q?K5p6lSgTuYaKzy7AiYKPqeyvhgiVGEMIiXUmyf6uR/fnaP7N8etYYAkuSDB3?=
 =?us-ascii?Q?0858C7qTjrDYZedHM3GkQ4gdK7ySnWexykodnKyo4r48rbg9D4IoteAuKfnc?=
 =?us-ascii?Q?MQ4QQs0yfSyjSOBj4pziCH2rz/L5LYKKL6R3bNIslQvAMZ2phBK7duMIh9Bg?=
 =?us-ascii?Q?mHfDjq31u9fBUAlgtvup+aeK315+BRaZxKtFVsjdpkaabsi+gWM4XHe5Qpjw?=
 =?us-ascii?Q?ebBEV4fKR+gLBLAtGu0L5dSaKtZHyEQXrUswyhgeHbEj42IWI5D2j15cnIFO?=
 =?us-ascii?Q?6vYu4fRq9zvjh8PkYfBca1zcgJqg2Ofh65mScVGSpAiEEejzCrdUaRJHMl2y?=
 =?us-ascii?Q?qBf3qq7PeVgfiURxKokh0Bn1sPkF9D2og0RKNhlP8KITLiPHw3C/Qdo1KuSL?=
 =?us-ascii?Q?F9PM8oZr+RDTSLPUplAvA0khD0+oC40JzC2UuNaz8oxgdF135xedgBPuiyX/?=
 =?us-ascii?Q?hKy57iF6KmWOMq931zt0mecSKD+2stmfTcQp1Posu3OZzQX1KG3abOEVBU8Y?=
 =?us-ascii?Q?HNQjZBGFELqUky/7UoqWTEUCbeBX42UkRHfmHxjNcxCMYsKggc2gw86zRwGN?=
 =?us-ascii?Q?PCs7NUyguu2FnKehQvAVOVTehitNV+LMYGfKjDw+YPsOu1atEhuHNmJpykj8?=
 =?us-ascii?Q?UwgH1JyAKbHYdSuiCh0WDUDkEMGXPoBIav/NUOv1EOq7Gh4j6pXERjRY0+sb?=
 =?us-ascii?Q?BkgH0R0NcBTO3KuHJkbjEgVtHbrj6WTuB41JQp8U?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:53:47.0617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe49af8-f3dd-4a6c-d172-08de1d5d6f6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

__static_call_fixup() is only called from apply_returns() which modifies
text either on boot when only one CPU is active, or on module load.  In
both cases, it does not modify live code.  This is why this function passes
'true' for the modinit argument to __static_call_transform() which causes
__static_call_transform() to use text_poke_early().

text_poke_early() does not require that the text_mutex is held, as this
function is only used when free of any races with other CPUs.  Therefore
__static_call_fixup() does not need to take the mutex so remove it.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/static_call.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 378c388d1b31..748fc98d416f 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -212,10 +212,8 @@ bool __static_call_fixup(void *tramp, u8 op, void *dest)
 		return false;
 	}
 
-	mutex_lock(&text_mutex);
 	if (op == RET_INSN_OPCODE || dest == &__x86_return_thunk)
 		__static_call_transform(tramp, RET, NULL, true);
-	mutex_unlock(&text_mutex);
 
 	return true;
 }

base-commit: 8411fdb92360d0b4d3337492a25ee2de7fb6c425
-- 
2.34.1


