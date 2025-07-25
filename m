Return-Path: <linux-kernel+bounces-746198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367F7B12424
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E536AA79E8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D64E255F3C;
	Fri, 25 Jul 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EG5IAiSL"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D50724DD1E;
	Fri, 25 Jul 2025 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468573; cv=fail; b=ZH/DAUPD6Ff4tRi+vtaIfSyVGaaZ1cYhu/Uvh7Dg3IJrcohaiM8L+3rFODTqFVpaIcR3Do1x8FH+0pdwEfNSiiRONUmv64biLvg3quH0DQiC5ELCgONcKCLo3Qq2dlYe16tafCSymBIHmsrxaJinmfzgpIWZOPbtFG2Or7nCEig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468573; c=relaxed/simple;
	bh=f5Nqjzh6EXPYMbyi99k5bDo0f0P8EKuCgP79/ATlVW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HloPZeiae4s+zoLPXQirb9Cls8+dkxCRPNPvhwx9KGSlsLxYHa2MmHp3XZ9a5/PZTClLL/vGRyGCpB6W39qHFaj0ZzoiDvdfXTeIBe65D8b0wt+Trac1F0gegGkhqiRMcgiJDBOVGHrIOWmzp1ffz9z9l5W39ME1oF8Voou1P9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EG5IAiSL; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSzg9HWmpEMrJjOYpCrO1jzOloCs1cZ3VQOQ/ekl0DCFF9hvCEy56n8cMrjtvVThT7jqN77MviXWCwVIKrCIPz7N5Sg8DFcbZCNtEt5vonA1paSo92/A2wX2Mw8Tj4Lpm6TP7pKiQp+RmqW8Yt1xCL8OlFL4GtY28+jYUb9zLwOeUW9w6gXmuGrrzP9j7s3FHgHJ/IIjEkaXjgi/nBOnZplvMCDjhK8KYYXRlNQGI9wQKW57gnNTZGQ7tWxSsrK5h002RzxtkagiXvKUvpF8Qhk6XyxA9SDi0zwMZhDPgM3sSFPckGCvRAUCnIouhM8Zx+5gYU03DbGgVe6BkKdplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8SDQFOZi2WfKn5FUvR7FwSxJZ+KH2t/WcZAZNXU0mY=;
 b=a+honeNOzMTOnCfFXMfH30c7B2N3ts1+yqRH6tL+oukwoPql1le8yjM+/Xm3PMU1InXDG2WGHiB95kgOPf2A1sg1gm+XOneO6K5fh93gYQRJDxaSG8epJrbuikEMcYX4FSQbebkYkcm6rM/ybO+oeV7iOCEFxXpfhcKT/SmAQMpyvJb1/MLbDcxYii+tYhab03Ouw2F1EduvbIyGSsqHB6wcfo0Nw8LYM7x/Ra7SHSPErZIdyUhKD1DCZHGeHBgpJ1qUHzvhqS01IB+QXgLVY67uLr7tqMk0K63EVa/ZcoIMjrATOnHSJ6224z38z2fPAlBZ8WApeQcAN+gLjvb/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8SDQFOZi2WfKn5FUvR7FwSxJZ+KH2t/WcZAZNXU0mY=;
 b=EG5IAiSL13bSCMl5VkQ6UnNM/Hh9mif9qRVKXq8RAv0UswWGZBJBMuTLxeYvNrf8OjQUKlviutM2UHqecKYlk6etUasaQj2wneoj9E8TIy2N2oayw4j04rNZZ/IDBSz96OAo0KCdEgK47vb1YYVAKHF1AAKwBVPzJVV12VAI00M=
Received: from BYAPR11CA0107.namprd11.prod.outlook.com (2603:10b6:a03:f4::48)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Fri, 25 Jul 2025 18:36:06 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::2c) by BYAPR11CA0107.outlook.office365.com
 (2603:10b6:a03:f4::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Fri,
 25 Jul 2025 18:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:36:06 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:36:01 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <babu.moger@amd.com>, <tao1.su@linux.intel.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH v16 34/34] MAINTAINERS: resctrl: add myself as reviewer
Date: Fri, 25 Jul 2025 13:29:53 -0500
Message-ID: <716f7dd7550b7cce8d4a3b1b29904cdf7224a090.1753467772.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1753467772.git.babu.moger@amd.com>
References: <cover.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 66fd6956-bec7-4387-e1a4-08ddcbaa1e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4f5g/lnjpFzGhV9HVpLhyXRx0aZF/nYoEEtwDyiqrYShd14ngsyGApY5D5Nx?=
 =?us-ascii?Q?AHH537U+PfAoEBi94WQ9xkqbf4uldOna/TbiKiaES087DdGnmnBuu2JgpCS9?=
 =?us-ascii?Q?OdijyuDrK+DShx4i6nd7utyqKEXIDJot6UTGSFXhK7hlsJuVq9pX9smNz+Ls?=
 =?us-ascii?Q?hQCLhVZTvnz4e0oKsffOMKvODPtgg9CYjTdEwL/mJDuxq2NfSkYonZ4hWowV?=
 =?us-ascii?Q?ODjwA9BwkwAdBUoz70E4Stcwu8jTIbDfKIlvLLcCh5lzBgpp+Ssr6TVYtv7g?=
 =?us-ascii?Q?Z/6XuUA/CdvfVccjaC1hPDMmVoAqHuVYUTNrI17pyFFxbj14EpmXAaH83GKh?=
 =?us-ascii?Q?UuAlv3bpBzGW3TndjeNIFxy3F/fuSpymHhCXcllBH40seunFKJUHAHRjysAl?=
 =?us-ascii?Q?hOlWgp3x0ePp3zaDBOxg1DWbHrhX17WKnmXcCbhskv1LeF9YR4tDKFJNmerv?=
 =?us-ascii?Q?yiNcXewQHh6/tcMfzUlihr5hJSJpOSkg7lCupKVUbJaFquCHDW+OiaEUl6tU?=
 =?us-ascii?Q?uolxvo70IV6F3vM+Q529/N9Q6XrIQBnmk+SUbqPLs1rBs5sdUNHJSOMFewj1?=
 =?us-ascii?Q?JxY3nDvZmfVDd6mTdWhpPlvffJ8e5XrjtMuSmWr+MU7qep1kgHh4eJ6AVTMK?=
 =?us-ascii?Q?vLT+mfOOeaamw+Ansbi2tO6KlmTbKTy8Dq/6YsqxZhZyz8loj0KgrbKz9jd+?=
 =?us-ascii?Q?NzYE7te0rpgNnOK8dAAdM++cxdORCcQEp4lmaMlNRdzyZUSmEYxD/RucKEAO?=
 =?us-ascii?Q?4yFjI72Fo0twuZYA9suwuU+GWeCIju98eaAij2dSh5Hyu4vzeAuTRpfcxkc0?=
 =?us-ascii?Q?zDTXFemROxZBSM6wQzT/2OXqlALm1s55Hhb2C3zUE5CqfNedAV8xQEiA8Dd8?=
 =?us-ascii?Q?XW2Pk5Qwz47nehOLOtFzW7oqGRt2So2UQ5wbKqLfclYCK2CjRmLNbsP1VFQq?=
 =?us-ascii?Q?oaXs/guiuOK+fqkf/ZbOgsdMA2Vzmjf+axyiTQ4zsgwCkAR4j77wGNmRJiK0?=
 =?us-ascii?Q?Svi2KvXMnymuGLFuNMVsPgUkmAEtzop0+Ra0NprekHkIAiLjljCkpO+bNnTN?=
 =?us-ascii?Q?DWYtbUu8A6iAvEN8fGZ1AOIRQfxrBp4ynNubb3O20GINJCFpHKDL7eWN0vTO?=
 =?us-ascii?Q?tY7MyobZDsbIQ2H6V96lolymPzE25F5nf8r2dG8tTKc+jCxKr/6dfeBvmKIX?=
 =?us-ascii?Q?I9G4U1KOZqQFqYosJwBo0yjqfNwGVS1z0zX7W4e+lnObbUSp7vTVHxSP2zwY?=
 =?us-ascii?Q?UhKYmXAZ3ZhM1+fmU7/v6P9vInG8uJylTfgDPXNbdAeNf5PZU861llwfIlzc?=
 =?us-ascii?Q?uH1JFfQD0fZsEKrm/7hycIQxOycm77MIDUCpQTIGxDsi3bt5f0+T7uzbT5ln?=
 =?us-ascii?Q?EMTgbV9zgOufJcnJyRJlkh+ZPtthhb+2v0gex3+FI1mPKL6apAYp2xbuReP+?=
 =?us-ascii?Q?UlNSpozO41hUPFIN96/UgjyoC2TgqSRuM+1t29YJxoPq8Ym83zkJgsrkqg2o?=
 =?us-ascii?Q?Yh7DCxpniws31OA4SvwU6caoMfGiwtTbzrEL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:36:06.3863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fd6956-bec7-4387-e1a4-08ddcbaa1e01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723

I have been contributing to resctrl for sometime now and I would like to
help with code reviews as well.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v16: Reinette suggested to add me as a reviewer. I am glad to help as a reviewer.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f697a0c51721..70a2f83145db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20866,6 +20866,7 @@ M:	Tony Luck <tony.luck@intel.com>
 M:	Reinette Chatre <reinette.chatre@intel.com>
 R:	Dave Martin <Dave.Martin@arm.com>
 R:	James Morse <james.morse@arm.com>
+R:	Babu Moger <babu.moger@amd.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/filesystems/resctrl.rst
-- 
2.34.1


