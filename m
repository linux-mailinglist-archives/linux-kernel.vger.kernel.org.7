Return-Path: <linux-kernel+bounces-789031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38606B39017
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CD14643B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F3D19049B;
	Thu, 28 Aug 2025 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rTrrhzsr"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4412FF6F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341274; cv=fail; b=oSDFoeV9i50S4/UHjWn1ls/7nWUnEnBMXBLh4Ij3z98g6QndzUcbADkEw4H3m3dIo6ymTAb/8MbIJNR6MOtaDHzQPd/kfFAW1EVahuXJs+Qxp3W9rfMbH60CKLxkRRmKdiQ2rvVdWOz+7YEKXpgXRUYAQJhLEsI4ELThd6crGD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341274; c=relaxed/simple;
	bh=oZCl762v9Of2952m9aq6jefKKBUky2M6jRGSepRsTOo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L5m1fK5N8NJMnj7Abus/hWuDumMZottD/t9P26r0ZL3d5OP381XHRTr9xbxGw07yLygucr9NbxR3B0STz7R5yG1/3V6QeQChHz23Uxet/4YAVVTW+HSkUZGiqG2m8ILvcWskhLmrEGaMwIJQ/Bhil8O+fMhP6cXkEUWbKcOJxo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rTrrhzsr; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgFgq9xzUG7fSPVPpTxZSxEGhNwBz6erNdjZjX7nwmGv/ktpD03GmQzP8Y2gh6y0ytorRFN6IW5yKHqxZGCgq1/G8OdTxLpK18LENTnnCr4of6ygFNiy+HnLko78yQMjU8UJKHgr3u+/Ojw0Y2Zx6qj3gIe5OVB64AxxaiC2jb7OqbrYSd1sOZeZnrhbjTPAfkVP08l11g9sSIvE71RWwv19RbtAQ+klL0GgsS6jwwnenMy1RLteh5UKDk9btB7PRUgglMjPfqcghRGypq9lIhuiH3oDXPYgXniRBmNhFUIG0ZGVBtvsFDgtQb2Q+oLn0nxGc0M1JDzlCKFweIwz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vn7eBth2oHtJKO07Rys/pSHJpVQ8txr9CkjrO0LbiJ8=;
 b=WNdt4aLhbPG2myj8yjhj9pxMbHdH+g5ZuqJPF4btlSeNx1VbsvNUpPRvdNmp3tiX+PYlu4Ef+5DpimYvRS9FY8moy5uUvNKEgbupWCsgQ1MeLcOgvpuGboBYpqWCut9+tdS6WGqlq1F2HR9A5llnxbj11R+Eoxcr5Q5fmlLDiA9ACwBsr035i4LVG4PgvaYAt5KpYOk2ln0HLGFMyhs09ZOCdDauvpsW0BfpKzt/ZsUPkneQPEA1hQVU1bbNprl/UMIuDUqWP7bzuX3KZeU2gFO9U/DqTXYzZEhIgKdSaLTJYkfrAlklks3e1mm5GtpqqkcyyoEm9hfBgIfQYdKHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vn7eBth2oHtJKO07Rys/pSHJpVQ8txr9CkjrO0LbiJ8=;
 b=rTrrhzsrE9RtT2EjX/exWjhtiCAgMB/T01PxTXZb/ZPml3zuE9iRFCiTM3D/2s9GMBSF3LjK08nP0JBix2o955fMWZ0to37BBHGB356FLtLZV2EchVjXXwPlTfKtKbjwlzaLlmSn67Ar2uhUXWDdEH/fAU6mwXyboFw5GG2QSl4=
Received: from CH5P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::15)
 by SA5PPF916D632A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 00:34:28 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::86) by CH5P222CA0001.outlook.office365.com
 (2603:10b6:610:1ee::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 00:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 00:34:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 19:34:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 27 Aug
 2025 17:34:26 -0700
Received: from amd-BIRMANPLUS.mshome.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 27 Aug 2025 19:34:26 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>
CC: Jason Andryuk <jason.andryuk@amd.com>, <xen-devel@lists.xenproject.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] xen/events: Fix Global and Domain VIRQ tracking
Date: Wed, 27 Aug 2025 20:36:00 -0400
Message-ID: <20250828003604.8949-1-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SA5PPF916D632A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 76480195-1932-443b-6f10-08dde5caa505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VrHTUAjHG4P4pVXM8xtR7iUsOX++drKrzrFJTYXrwwa0Wex/7RSQreJdaI9T?=
 =?us-ascii?Q?YBFQGBgCrVJoIu70oaU1Ds8iCBmsQbYbLiP4k9BZ3++tbXAcpbs/ue8XqnL/?=
 =?us-ascii?Q?bcWsCtM4w7eiEgswYpr4PAp+o1qiAXx1C2ffZTv9Q+CXdac2qTqOXgDhI6uT?=
 =?us-ascii?Q?p8YmD/k4TTXcU9WA4JxKV2QqpNf5Ldi4KW+dIMK8Mrg+ze9SGjez6fpxqm8T?=
 =?us-ascii?Q?++15yNbWmJWGRqjuSA5g1Ftp3f5WpqJdi1qvqdP/evkBMJhP1Ucz/KHiSPqL?=
 =?us-ascii?Q?MJqrv1p7I7eRtVpQAUt5XcK4iP0uzUvjp+kEcQae5+d5ZnqYUWdfxn2+2Vq7?=
 =?us-ascii?Q?WTG7I5IgenCAPAd0aUJY7GvoEISohvoPh4frLwh+aIKrTc7jSI6OR7SSD3eN?=
 =?us-ascii?Q?NvnzkVOXD/Q/HWI2HOhCnaAd+x/Lu8qShBctMvjKu4VDiZykKqvRa/zOnkOY?=
 =?us-ascii?Q?As/ez+9OE2CstcGXUmDbgGLtMBiD4kmCQx9ClyNINwopTTZZrF9msGXpyTC8?=
 =?us-ascii?Q?nwkB65yex61s9w6PpEDm58jgg5zQNNETr7mPfr5TDTeSEbQ8YnvtSlvBRRjS?=
 =?us-ascii?Q?j9w7oQCkcAfHadLQwDtU9OnzPsGDdqfSVAqZWJHWeNYXcO//yOXGIlXIeSD4?=
 =?us-ascii?Q?QVoYPesDE3AAUn/hiZmE+r3bsRA+jCBKiaQJfcoJQ3S4T1fU0ATuUhY+I2PR?=
 =?us-ascii?Q?lj8lAa96xHVDgAlP4QlITz3W6lmQ/WjJ8LdkTBPbWJaIMkDFZOgaRl0etGmC?=
 =?us-ascii?Q?1mUZROYTjWRfVDiXZXnxXIobUS+sJ+gY84EEOwY9vOwxrEFPVEhhX37qdoNk?=
 =?us-ascii?Q?jAOmWXEe/GuvjBgzb0KdshpNGPTBrAlwKiM4YFKOZGcXWSxcDSdvDF//38kw?=
 =?us-ascii?Q?bWswicCXAblyJXYSc/9Hhd1b8Txmfc+SPhamjj0OPjVkEX8Qa0kEJf5tBc8R?=
 =?us-ascii?Q?0tzPEK+D1sNbxmFCZsGf4FCBDoNYQ0EHXMUkXOr1LXgIzzv+P6kig6d/vTGU?=
 =?us-ascii?Q?oWKuybBvzB6t8MzeqLJJvqbHh9A+TR70KcaGvLt/wZM8zUEiTJnyuY4As1PP?=
 =?us-ascii?Q?ZjCmau2euGzqWmSzAlfLvWIazM1eeAp9en4XJZ6wIGAtB3I/EqbpfdArE+mY?=
 =?us-ascii?Q?NlgcQ7spL4xA3VH/2sDp8hWlODnSOgwpi18hVyPLP5eRQs9oFejD9731tdfa?=
 =?us-ascii?Q?4f/Gk7ZD2hjboZjD/92lWdaLjhcZOYhSUWx8/KGW8MhuR4mFRvjmvdq+j4HR?=
 =?us-ascii?Q?Vh7jrQBFEcP2bTsZwGovd7HNALMQvlqnbvqdEeu/PpLbdci/jC8JTT8Y3HGD?=
 =?us-ascii?Q?vwszwrXyU3B0r0Iprb7B5UCr+CLGN4bmC8f6RZwBqicoZxNGa5IYISkaBh9I?=
 =?us-ascii?Q?ESkb/aZM3wwkJt/mM51ZEX4xxr/fUZrRtzM8SzvZI/z0XR9oc7hm0G3sxKHI?=
 =?us-ascii?Q?rH0WECKXo3pQ+RFWNllOe/Q8RbrcdIOSrC983SmfHVZV6mO39G0u2FrIqV0L?=
 =?us-ascii?Q?g6IgGn2QsZp0VTj1gyLKsI2HFKuEwGMOuX49?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 00:34:27.0677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76480195-1932-443b-6f10-08dde5caa505
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF916D632A9

v2 and v3 are now series first changing find_virq() to return -EEXIST in
some cases, and then tracking cpu movement of VIRQs.  This keeps ensures
the cpu is correct when calling unbind_from_irq().

I'm adding Cc stable to all patches.  Patch 2 doesn't have a Fixes, but
it goes together with patch 3.

Jason Andryuk (3):
  xen/events: Cleanup find_virq() return codes
  xen/events: Return -EEXIST for bound VIRQs
  xen/events: Update virq_to_irq on migration

 drivers/xen/events/events_base.c | 37 +++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 8 deletions(-)

-- 
2.34.1


