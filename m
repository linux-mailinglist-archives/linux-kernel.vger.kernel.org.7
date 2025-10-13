Return-Path: <linux-kernel+bounces-850748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5782BD3AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AE93E4617
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC69F30E844;
	Mon, 13 Oct 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n6SvTN+4"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012011.outbound.protection.outlook.com [40.93.195.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587AB309DB0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366180; cv=fail; b=d65QVdl8PoKJ/qmevuyp4qcKrDVgNj0JMlBBh3QyfzBF2zPpdWnQX6oaOAiOE8br9zdet7q6mrPgT0l+mD/sfSwHxud4FV8E7dC58mZsvyjpc0MLt4YClnkbfnsRcFlZpmTPaHTvz0DFrsBNowb0+Tz1u+XinkUsSKFCciGUtCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366180; c=relaxed/simple;
	bh=lYTgf73XlbjBrrO49F6YeAXkxNrCVkLHakzGVmI5/xs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acxPuOmNBjPxPsv9x9VUWGqJ8fksxI7A483EctDNCFY/IhRzNyPXVV5mB83pE9F5DOz2QN+iZcHIhxEvtx83xiTHvlBUgQp1qHLwqOP8LoPIS+15Ofa7pEk8UGBQJN2IUpfwA5lQqV0vjbmbuNavnUVpOWlz3Ef4EJghmdPV1y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n6SvTN+4; arc=fail smtp.client-ip=40.93.195.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9UY3xQrd82dXYdSFolheZj6HjbeK/eh3L+T2p6wtdcpDUOaMGsGdT9ASo31Njp/3748pB33gsVQoYyDMiMeM+1sZLvQbUJ5DZH9p+9Aabbj8buSyjKd2Ymz3h9nNgEJ3uP6oT9rreymZNxbjc8lpoSGPU5CVSN753OFjjAXuTWbV4/uNDTwXJT935ivPYNkQgyt/WavW7be5mwOUqZSSpYi+Ut5KHEVHGSXl3QOpDJNlC7UDzOv9C58YCqTFRmRgVZfueaOUPnNqzAUoxzBHgvxO5V7PYnoqksPkm/rm9eJwBa3CjGoeJwLK3H4uQRlDK6/kuctvpt4M+uJlPUZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNwbeXHhiQdDD553vkAdG1r8VNb4QKRnPXyqfciNwvU=;
 b=I+3UqQ8NFgNEJahoarm5vn5Yc+4VTL6LaWgby/8M13Ag/EAJzf8C2NP01YU6Z3nEjFlo7kkihGCYHb2QqImdXl2Xe3jc/LierxlYwMgQJtx0KmOYYGk66SNaD34hI8CUobPEnLxQ7RL5jaYkdsicmC8BpX+Iknq+j5XzJ6N/4K9Fvd0SLzpKfyKPQpNDJJSlfawgIUPQthgX3kjzDHhJZt89zUtM1js2L3zJTuOj89xq7j5qJiLRD1wZR7yg+hF6eoILLT7ZCH92D9YCgp6npVQMVsaLUlTg9R2XBQkjTGxx3CbXaNjmQ3R8XTAJVb+yi78JifzozN1fx2LGEzRq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNwbeXHhiQdDD553vkAdG1r8VNb4QKRnPXyqfciNwvU=;
 b=n6SvTN+4Hm4tvmimPEsKRqJg3pUKqBZk0E8xDUjTm3aQLmG7UQ1xnF0RbMgzC+CkxQVCwZD/8qLtg4XmPojg5rR0g+X4nSh+R/fSoTDzJ0RzOIg3BmgkC3025g0CF0c5Lk8AzfBfkmKII0QxJOgeyPRCtuBfNuW0hkr0hisG1fs=
Received: from MW4PR04CA0062.namprd04.prod.outlook.com (2603:10b6:303:6b::7)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:36:16 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::db) by MW4PR04CA0062.outlook.office365.com
 (2603:10b6:303:6b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 14:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:15 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:47 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 40/56] x86/alternative: Use sync_core_nmi_safe()
Date: Mon, 13 Oct 2025 09:34:28 -0500
Message-ID: <20251013143444.3999-41-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013143444.3999-1-david.kaplan@amd.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DM4PR12MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a79167d-bdbc-4a84-86a8-08de0a65dd7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G1bkjK502JsFSLio6x40HYQZoo2mKo9kluy9wnKJGf2/YgXLOPv9TXYIyp9G?=
 =?us-ascii?Q?GlR2aMk9gRmhJ6fLsmFiMjVFa2sCx05Aj+RmmosQv0d3WCBkUh1P+eh153K6?=
 =?us-ascii?Q?HWWSAhPYUE32NLP9lkbQGb84J/TZ82v8hxxkfgiYdSXFeM5Cq+uyOzs2zsAb?=
 =?us-ascii?Q?gCSYglFcs0M8e3SqdhIfeSNqEskLatT8ayV22xyDqTW4RATgWySI4UvR19pq?=
 =?us-ascii?Q?o3scSDne+H6We8fckIrop/de9E813hoB7DzIFgM9rdCGjp1qrLjmoZXEsPVY?=
 =?us-ascii?Q?YYFMTIjd2sArMd8WZEvFNlmtsqL8R6RPAisOOD2tS1rqXLcRHYYXjIGgp1BY?=
 =?us-ascii?Q?xFXrznmwNliZdSXVwqsKnhJ5wvqvBJhTDDXYR4W9C1fy4E6Ozg1I7qxQpDei?=
 =?us-ascii?Q?Z0F4A1Cq0ZUL9hVhSZd4smDOCwE31G90tiMbZV1DJBP//0/1V+qbZHX8o+7o?=
 =?us-ascii?Q?kwnNi4WFjWqP4A08ByT5PM+yLOzc05wPm8LtrnBIVdpIh3MM6LFXG+EyU637?=
 =?us-ascii?Q?igSlr0cDCiXKq7qbEY1sv9pumMKolDN9VKPFHDvguZIKRlNXIBaz0W1R3zR/?=
 =?us-ascii?Q?wAOdITV4kEQAIrgBkcLzA48neoZt5WoQjKGlFaHBU/1gT9EJyITm8xM7nPNk?=
 =?us-ascii?Q?NzQp/z1eFLr76EIWE3/pA2JowaBh9wh8TANbA8xin9nhdSTABaNWN7z0HmZS?=
 =?us-ascii?Q?INkp5nK7Ef5yv0d2KP3LUoCA6Xe+C4qKQjZ2F3/YNA1/AuwVM0oUJ6o5VPd8?=
 =?us-ascii?Q?10c0W1rVrZAlkTxoF8R9XltRt8UZPO2arEIYAtMozPJ/sfnLKJSYmnPput3r?=
 =?us-ascii?Q?jLi3pB7zTjzwcQhcnzWf+Q0/rLpeowAG1RnFEsqiLnnMZE/ivcYvT+syJ2GN?=
 =?us-ascii?Q?L5My6inaTFRdNalqNy/5oyLwi32zm7VZGEaVBEctuJbPAw0QxejX1wf0v541?=
 =?us-ascii?Q?pSxP63uLB3UC8xei0Y1L28kDsVy18VQJuxtBXBYPDruztk/9f6kVNykQoRMT?=
 =?us-ascii?Q?FgQAVF6BoNTYdJRVEPxXFVudpz5qPmbRdk0Zzc5UtYUSqg+/PV8Cve9SCGRR?=
 =?us-ascii?Q?UWjwdMVzjk2nfraUIFh9hS4k/6gTNerVAXEJP8+VT3DEa+kej6wRS9/iNozW?=
 =?us-ascii?Q?OM++J5hgtwwaxDg7vGE3jwbVAH/l/iKkHMatXcwwXUuLAwwj+MYwBCiHL5pJ?=
 =?us-ascii?Q?iS1m1AN79tH6LjTwdBW40sP7aH99RE+mKLmpgYbURC37AxiGsWkPUJQaeexb?=
 =?us-ascii?Q?TEetfT0wIYAVe4SvKppO/3amkN1EW0w6BUAQZjWvQc5RPClaqhdbgCZQz78Z?=
 =?us-ascii?Q?lgLDH+O9PKgqDHEOREbAsPn0vpW50C8lfrQZ0OsxIw+buFZtLww+m/+h2QhM?=
 =?us-ascii?Q?DJTtQcY9p9RaIcRly/3vY2u/sKhf7k1YM8GFuX82AraQSeJ9VE76WYdiCf1q?=
 =?us-ascii?Q?JRNQ5zuVauaWETdg7dqKFdC8fNTYtPcKooiYCFGlDUOqb0RhthA/2gzkqt5z?=
 =?us-ascii?Q?EdBThvkXkxYcADz4X7zsRaHK/BkOZrSBXPvWEDhzKTdVbp8FrTwWW0vu5eII?=
 =?us-ascii?Q?agva0W4/bwwqd+uYVI4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:15.4700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a79167d-bdbc-4a84-86a8-08de0a65dd7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770

Re-patching is done under NMI context so the NMI-safe version of
sync_core() must be used.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/alternative.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b67116ae883c..2d48d750d4d9 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2585,7 +2585,11 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 	} else {
 		local_irq_save(flags);
 		memcpy(addr, opcode, len);
-		sync_core();
+		/* Re-patching occurs in NMI context so we can't do IRET. */
+		if (repatch_in_progress)
+			sync_core_nmi_safe();
+		else
+			sync_core();
 		local_irq_restore(flags);
 
 		/*
-- 
2.34.1


