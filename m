Return-Path: <linux-kernel+bounces-770029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB43B2760C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFB5189F039
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093F829C328;
	Fri, 15 Aug 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pHDJCx2m"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41782BDC09;
	Fri, 15 Aug 2025 02:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225041; cv=fail; b=F1R6H04K+iTWnN4vLlv0js2Dj0IzVjsy7lpE/JiuYv1+5xWoDNoHuGWxDa+IOiRYd7XQyFJpQQUDEHboPSsK+6y3d9m+hUUiTfdR9DFOkRr0UyBloffrw4e+TGfEjzqFBv1MYKe+miT7o8vrgOVx/kUHJgiwQG9kRp5QzcX+3sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225041; c=relaxed/simple;
	bh=X/4YmlbAkyWeSZMbiOA2c+CjPSHu8dig2KOg3/no3Dw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVTpay9LoInRVGSQe+5szjhEocwXd4PmlAMllZzWLxgad/t6/ACGdV9xj4BAXtITtjtxdUhuo5mNU6MF/VeNGf8JDmz6EiG1HltWF9WqXzVSUH5Lc5sunQvDN94WHXXvcrBrLgsj6A+G6XEZNVZuTklgUfjzVh0+GW9OKQn4XGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pHDJCx2m; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKqu7oeARBa7zEVIDkLb8l7cEFUNZNQegn8P5n+PQAJ+Pnfq8dBQ4mXARJdWnXLkDxCMkDgtuCqJ1aoFy40VnsFKhK3fVbOrlfrmQykqmfbVYAPDI8r4hbNtYryjOqDQZp3gHxtdLcUMrggNLl8+YUwCBl+ahPs4m51TJrDn/pBSUyXEwkttGmKTlsmWJkXvW89d7+cOPyA8Ihu6mo9bv1QPr03tPkkksO9PjLH05AT5YWxdgQxjEatlKIWhRiBurvury8ceGffRAS37AQ04ragv2Z9AQc8CUGQmFhd9AiHVj2vOonR2T96pz8iLKpnmxluLVTGSswiLZGW+Pt5agg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NEIBDC6iRJNeAag2EwSyJls8bju/k74xrLXsX5lvjg=;
 b=vwcO+hfrQ4zJYQVU/3Udg8SZhFRh1N5m30VdDcvJ+cHbTOPhfHITHu+AkI51QZgpFd2tvcG1C6EjgnNe+SixJlJ+AF3wdQgQFq6USRGL3luEZ6SvClV/BYIUei8cruoggy/3o2YRYYonZKSgTxwGm1p1yLifV8fwpkRDbd5/bztOeRzuJiQLmxLkX+dJPOMrLtJyA/tO9cVLYh0tcKSRXYSfIbZv/tn14S1+rpgKjIC4Ih2h/0bdHmQSr8RPo4r3//r4ZP1mYgZ+oVMFnmaAsa6zW89KTGNZ3YR5gjcsBdCOe4k6qLqezXUcl8gAFpKVn/uvIiCQUzaTu7kUn9zbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NEIBDC6iRJNeAag2EwSyJls8bju/k74xrLXsX5lvjg=;
 b=pHDJCx2mwMIIfYLIBkjztaTEvu48ut72NamMZNpUCugE1u4teZg2khYUEBGCMX8FTbWrgGH/8HpcJXQfURmS/f9PTO/Aj/IZOkxgvvZeJitauc7MYwPvbiWz4TjMkj1eWFlu7jKxWoYsv/XcWgdRv8w201N8mse7/hAiLEhIVC4=
Received: from SJ0PR13CA0236.namprd13.prod.outlook.com (2603:10b6:a03:2c1::31)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Fri, 15 Aug
 2025 02:30:36 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::76) by SJ0PR13CA0236.outlook.office365.com
 (2603:10b6:a03:2c1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.7 via Frontend Transport; Fri,
 15 Aug 2025 02:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:30:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:30:33 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <babu.moger@amd.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<rostedt@goodmis.org>, <paulmck@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <thomas.lendacky@amd.com>,
	<yosry.ahmed@linux.dev>, <xin@zytor.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<mario.limonciello@amd.com>, <xin3.li@intel.com>, <perry.yuan@amd.com>,
	<chang.seok.bae@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH v17 33/33] MAINTAINERS: resctrl: add myself as reviewer
Date: Thu, 14 Aug 2025 21:25:37 -0500
Message-ID: <b5f527fc33ec5c187af0ffa02a4b6366bccd1c65.1755224735.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755224735.git.babu.moger@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 669a62e4-4fa7-43f1-57ec-08dddba3b76e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0iVSOQL3hpecCk1n+uKmkwaaRLB0JSSzY9fv4Cc0DPrWccEzmS7WvwpepQLR?=
 =?us-ascii?Q?qPEDNVlssjQ0JjFKaGbKfMIu0Ws6q+ehmnc8pj5UZoVdaM8eHXETmqbBATsi?=
 =?us-ascii?Q?P6MKIdLBzeMo2XbSMBqJBWCYjQ8ZHnSccEHg5zBpFZoD6Q0QSZrzsTeoL9ML?=
 =?us-ascii?Q?fVul0LLAAVZi1Px3POrdPKjvulHCPswhIxiVWDSYnzoLgJFUvrb8miaGrkRg?=
 =?us-ascii?Q?bFR1Oht9vE1mU/zndg7beNTsVjPmYCqTE0QNXJUstN2jFr9x1tiqpSplBdp3?=
 =?us-ascii?Q?pGxcyPTKPdwbw3ssBn8LUXpsd61tWQwrP16hObtr4sxsL1rSPOfJw39x+AeH?=
 =?us-ascii?Q?6stuFPWF0dZREtqUIzPHBagDKqVtZXN7U+a/RAQgbphJEy3Y60UBYFMkxb2r?=
 =?us-ascii?Q?6OaogUrl6nQ+LXuxUGifWFlBN8/1IKqWEJltLMqJhboApZsC318haNcCnT4/?=
 =?us-ascii?Q?2x8sm8+sqxLStCXpVfzC9fVwk1dvjBjWDQd1IRr+JHbCjQb/TaXNOE/tvSKN?=
 =?us-ascii?Q?E0+3DkAg8Nqc8uYVqIVdSbMDndmc8TQDjeNcD2KZr7vMskqkke55x3f4mYFK?=
 =?us-ascii?Q?wwvHrlzHAzaf5BzBJTd2QKrAL3pwoHRpgDGq3XqJoqPAnBCcZD0CIpekFVLA?=
 =?us-ascii?Q?8Db7I6Q53zeu9VALVARoAG+jN3rlIxr5gCrFmmVknEXgSE6lZq3IRLGY/VOO?=
 =?us-ascii?Q?KZ33gDu9gA1W8g8TwGvTO8tC6gMY6OJed4d+8EuNr/o3gk/ZW/8aA8zj3j8p?=
 =?us-ascii?Q?NdMmFurROjC0O4xM636+xmpPfgjCcuj6UdHhM4NEF1sl0pfE8KqkRWBOobPW?=
 =?us-ascii?Q?aSeUlpltxO9X4ju2mjMG4B1W63YfzvGd+RlZYqyVUABNXSvpWYvUMWglhepr?=
 =?us-ascii?Q?7FZ7TCHLadXHBV+sqtYgpUjEeg566jzHFnDf5yAh6poQ3bIvwc6S4jQA72U1?=
 =?us-ascii?Q?y39dqwRPVLozMP2AeOaWha8PUyGf1JtfOrRifxWqyB5gUWYMLOKuT6S9zX85?=
 =?us-ascii?Q?tpmnv9zFIdtC6W6z6x6sh65Iq432Enbpxc/BDsCabm3R2lYanIEjBXUefUh+?=
 =?us-ascii?Q?rmyuql7pB4PTSEOOVf+5JAxp7a0RaWaFt6kxTFT7NrfW5lhLef+CzXUWASaD?=
 =?us-ascii?Q?Yuqx9Wxsosy3tpiS3JLhAQ8tM7z09BMkEsxzsM6Mp3mniKok74Zb1rASRSsc?=
 =?us-ascii?Q?EmGnxvWklyAdxlV9pnou4SASmK46vVWJtShbyFcgjkgSXKgONg39ZpUHBCJQ?=
 =?us-ascii?Q?GKeewtlK56RRHUmDtVIHKutOJ1bzZ8rMNF+CGLipc4tfQDVVggQbzLZsMhzu?=
 =?us-ascii?Q?Ndu5hrpvzZZ4YoHhuVABk2+3iXN/CdGdOcGudJuNHa6acl3At3cGffTCJl07?=
 =?us-ascii?Q?wWdry6KALEKggeyoz8lenGfR4XZcCtYH+xvZm8wnGLjnPvnr8Nl3LrjPx3un?=
 =?us-ascii?Q?sAs3ahdomx4Qv1nOiZtOPa3Xd1JS2wizwSpW+O9hnVQKNqn6ChwdMFYk833t?=
 =?us-ascii?Q?khKa0K8wKsmEpVvs1f5398lKKhK27m89VDGt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:30:35.8752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 669a62e4-4fa7-43f1-57ec-08dddba3b76e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092

I have been contributing to resctrl for sometime now and I would like to
help with code reviews as well.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
---
v17: Added Acked-by tag.

v16: Reinette suggested to add me as a reviewer. I am glad to help as a reviewer.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..875c4cc8bcfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21144,6 +21144,7 @@ M:	Tony Luck <tony.luck@intel.com>
 M:	Reinette Chatre <reinette.chatre@intel.com>
 R:	Dave Martin <Dave.Martin@arm.com>
 R:	James Morse <james.morse@arm.com>
+R:	Babu Moger <babu.moger@amd.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/filesystems/resctrl.rst
-- 
2.34.1


