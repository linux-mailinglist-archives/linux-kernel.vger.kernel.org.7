Return-Path: <linux-kernel+bounces-733407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29F1B07454
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E5116640C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2F32F2736;
	Wed, 16 Jul 2025 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qQ5NOXiE"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F122F5322
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664089; cv=fail; b=ntRvScx8YA5X6fClGNxdcNLRZrO0fzYzSifL8H/1nTLUJP7DpFhqTMN4xyAVQ5Ux6LwaduP4tlQPSO8So853TYs7CUnG3WNEB/ll7y9xJ746O3MNSjzd4W002bBHG0ApYItEUh+9W1lv/s6kLYsExWS66r/dpSoP9bKabitmq+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664089; c=relaxed/simple;
	bh=XM+toFDm17JSjhS/MzRoxqDs6cmnRiplJ59IxViJsn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGMz6FJ+0Hr/K3IUemz7W7TfeQqkpuHAX3NicoEWNo7/OZgJaIjYIOVaX3wI+IDx+6JGoqlL02teWgunJtpH4EAqcvuSAFIJPz/lodmLJEWEKW7MEmeneKXs1ZPVeiUn7/SH4Igt1cNe6tFn3vfi1DvQKuSpQ4E65HN2cmWcuqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qQ5NOXiE; arc=fail smtp.client-ip=40.107.95.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8TJSRo2L3B1RevyfKgdikANcbYGJeFeUwS+ArZxQ9CzWLdvQY2FuX7AEDtD2ZryKdBYxnCiElIfvj5b4zyxm9o8T/TR9HU5LLVYnzQ5PTJVSqXeYoXpV/diU/sVJdXr6CA8D2hdb94N84tcGgQWDZ8IJyEhqYadr/tfZNo/VE6uD+odE8Uk5ksJEfENwuFhHC1gKWgcLejDKZWWPRWgKA0TTVgbWlY8dZl4sexpWwyWM7NX7OhwBuL0gkVeXGRNWVDOXvHUpREDEeU7agTGuGxDpMF0tDbqTri2xokzKplcc4CB5w7D71VH0Fw6vHTRYjTWVfvu84vd2imV8JiCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FELmG/XBF+blcjMYD38CwDijc67dwKO5TL/JfMvPPsA=;
 b=IAefEpZaXsdOgrtBVilUjTHplR2BzF52p54RxiZXKGqIUzU4pkP9JoK4Pb//nrp5kFVeCyZCpMp88mpeAaME3bYOY1z2EA9hIyiSyb8MaF3Szb5sUPkh0+TEPPhSSE4ZrvatiE/71xi9PRR0JxDqz22LeJhBOZUZS2fBKHPZGYhZcyIpEuzgKPaR8yqfyr+fiaZ6NoaEVkvBGI8ZmmyF0O6lDe930AI4TtgV1dDeIjuw77E6wecz5ftOgiiSq1IlO7Le0zpeG9BzqfhVHOWTflfI9FdWy8jYJpnXX0BlpvfjDNTGorRWddgD7j2bpTRx3DUAQsMwiTV7Iro8MuetbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FELmG/XBF+blcjMYD38CwDijc67dwKO5TL/JfMvPPsA=;
 b=qQ5NOXiE/IODcg1YkAdCCYWpRyu8oAqUygk4JyI3IiDA2c9/XOKK1nAn4qvr/0oe9nkJGCzGOID7qNdWbPGaDd9UFY2C7fUsrnJnkYYn+d4bfDEVwupkkvTXmfvjcjfDKyB2NAzPc0ohZGov+N/rznVn7CmAmH1zHXdG2xkcq6w=
Received: from SJ0PR13CA0171.namprd13.prod.outlook.com (2603:10b6:a03:2c7::26)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.37; Wed, 16 Jul
 2025 11:08:04 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::8c) by SJ0PR13CA0171.outlook.office365.com
 (2603:10b6:a03:2c7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 11:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 11:08:03 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:07:59 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <Anand.Umarji@amd.com>,
	Akshay Gupta <akshay.gupta@amd.com>, Naveen Krishna Chatradhi
	<naveenkrishna.chatradhi@amd.com>
Subject: [PATCH v5 3/3] misc: amd-sbi: Explicitly clear in/out arg "mb_in_out"
Date: Wed, 16 Jul 2025 11:07:29 +0000
Message-ID: <20250716110729.2193725-3-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716110729.2193725-1-akshay.gupta@amd.com>
References: <20250716110729.2193725-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 174f1af0-ccc1-4cef-6c0f-08ddc4590917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n9xJl/zFS6K3HM9JtwEta5v0ou6KCyKfpVy4TaY65nt8QoIVdoy/uULDm5fQ?=
 =?us-ascii?Q?EBJ6DMhlpPV7ptB6IhytC7VgijvrisE1edoKVK/JPZYTjRWFEtvp37lAaVtE?=
 =?us-ascii?Q?BwUyZDm2OeG94N2xyJmPerLSPgeh7XWHU1CVOEfB7m1DlwTS9WT6fCeM0GQW?=
 =?us-ascii?Q?1b7y3WP8CRd3QU5T4sxkirTWCQx9dQwKpv0Sbr2jhJtw5mf+QZla2iaBZiaS?=
 =?us-ascii?Q?CuX1vDjX9sV0Ja8VWt0aoQSgliFjPvOT6PeUmeuXOXdxKZF4fdgCBh+xRCZx?=
 =?us-ascii?Q?Ete0HGCVjYJkihhqqwE/Q5AxQ72Z23WVwDLg9ZSm6vTwF0ANOx5oVwyDLrby?=
 =?us-ascii?Q?CpunoZQRRFjH8JGZvUeXDHbK0ABth4iB4LzmpoP3vlpYrK+54NbXhPisRU2w?=
 =?us-ascii?Q?k0re88NrPQ40r8UHveb7ViIusHnc4DNngcjyhKqBlk33AOBva16Cg0J1rLQi?=
 =?us-ascii?Q?uTrpWMdF2d30xYrqbreU/fc08JgyMdIfQIm/5ScfuifI33Qi1Gu1Bm25s6EX?=
 =?us-ascii?Q?aBK6mBdaUzG6v+2d+eTFJmeae81VH3/j6oRml8zUmIajAw4V4WnGD83va9WG?=
 =?us-ascii?Q?iFJnv7/M0c8QT14RPe1ewo3rf75IEH9Kxr2cpzBAUViRdtZ/75n3lETVy6LG?=
 =?us-ascii?Q?nML8hwlFIj6uVbW5X3zQG8bUNpkXU4CedATkEs0w1YTpjv2PvEeZVpaTjQoi?=
 =?us-ascii?Q?6lvzMAt+G7jwnnkQffOriaCQA3/aQw+qf3Abemtw/0ltiWBcin6/lxLXrxWd?=
 =?us-ascii?Q?14Ijm9824/fLfDdtTy4hLTC5fPg/tYNpJp//N0d+sERbKIX2j0fIREDzcoG8?=
 =?us-ascii?Q?tAK/RbRUGG51wE3vbUBqC0dRlemGkbBv+dqt01GqMiqlLLn+iITefyj2pAdI?=
 =?us-ascii?Q?taTHuRW312UG9Vmh5rbK8wdt5hTsAPu+eMvx8+Au+Q4HQHEEvVXN197d/fIk?=
 =?us-ascii?Q?2D3KrvIU1NSijbJYi0bpXA4K9wFMVc7HqRqZMBaEQjIT86zaSUKIxYTYBt9C?=
 =?us-ascii?Q?Gdyt+SD1ec6BLClmn96AakT/Qghj6QhMB88M9fSovSOhDxE+TTwpbm/5L1t5?=
 =?us-ascii?Q?N6m9wTIGDbjxlxLyQeUseGpKwdJWY6uy1yqH+dGlU7pj4oirZS7dQ38I76LZ?=
 =?us-ascii?Q?ycczmxJAL/vIVOMSRlywChv3IRYP1SZU2t2iI9ef1GDdwiG261xEF9wyx3mD?=
 =?us-ascii?Q?Y1HEc3cd4uXokKtykuJu46jJ6J8LcwlfJJyOEg6WTi38hu1kPZU/WOAgw1Ov?=
 =?us-ascii?Q?QDmWThwJEiZk7u6wHYB/ySkSSKRcp0JABG77PWPwTni99SnVcwqDWY0DE51L?=
 =?us-ascii?Q?RBk/22sdwNhQPB8leNgPJw6SgMEUNijnnB6DvJohRFQo6GxQlso3i5SSVm+l?=
 =?us-ascii?Q?HOzIg0soZyPyD2OdFW49w/rW6TXmlXt2N5cT6AKSjua3sIpfcbFsyVvQs5GV?=
 =?us-ascii?Q?3FatahMaLIY8EEVhi1H9JeG4OnAR+Osk5DjL44JqNPp5WPOUXDE+xNzqc0tw?=
 =?us-ascii?Q?ZL31v0fUxvTB4kO5D8H3c7fOg55qI7u3/T9w?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:08:03.8800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 174f1af0-ccc1-4cef-6c0f-08ddc4590917
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508

- New AMD processor will support different input/output for same command.
- In some scenarios the input value is not cleared, which will be added to
  output before reporting the data.
- Clearing input explicitly will be a cleaner and safer approach.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
New patch

 drivers/misc/amd-sbi/rmi-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 9048517c088c..3dec2fc00124 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -320,6 +320,10 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	ret = regmap_read(data->regmap, SBRMI_OUTBNDMSG7, &ec);
 	if (ret || ec)
 		goto exit_clear_alert;
+
+	/* Clear the input value before updating the output data */
+	msg->mb_in_out = 0;
+
 	/*
 	 * For a read operation, the initiator (BMC) reads the firmware
 	 * response Command Data Out[31:0] from SBRMI::OutBndMsg_inst[4:1]
-- 
2.25.1


