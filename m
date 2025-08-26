Return-Path: <linux-kernel+bounces-785754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67539B35085
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 808417A46DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF0027467F;
	Tue, 26 Aug 2025 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="li2CCzhL"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3274326A087
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756169728; cv=fail; b=FhOV4NL/ow+FvwMQJHAiOkHEx17vUrtOzwHk4SAx4G8XDY+Ud44Fzs+oKQliFek38/IkjPkrpRIxOSVh5yef5YK2mb4l+dfn7LBVNcAfxHq7/gXak1TfISJ1D8bqsZFtnaHOl6HV3n1wGuHEwY5yDN21BZYsOh38b+EcTbhsDu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756169728; c=relaxed/simple;
	bh=FgMX2I1bEZ1D2MhcOq/lYaqKiMiG8xZyr2/xzqGnvaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjT7uDEoIBdbBLDUEoBcgwpr7ENdDrulp/ANISV23NJfkDOeS5IoNJKbDkr74yn8+iHD7CW65TXYO0L3SR32FCvvPhQI90jsnp0SpiQnqCjXGY7DvhYxN7ek5JIOA06mwrYBEvYMRO+OiZz0bQ8TAYsFZPIxOzvIRn6cmCz8f7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=li2CCzhL; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owDcEnN3x8CwUUn6PVf0fbJ+wlYEzjL1MzzVzSjclR1FmJ4Dch4QOoarUhPou4OeuNgo2snh6YFBylILJ0fS/oen7d4vtVSaRUn8dTQ4RyDSKDgiZV9Iw8U7RCMUzv70wEkHX+BX/g0bGuOk8994/dJsxJ2/EYKbx+LXaskNg6FnCJBvkreoo0X1+DTKRmJqzXMShyw+DVjjxps6RHQVcePH6QHXYafj2XkCXvZ45Zb87S+bESr5ynttEjckVmbSCHrTJaLQknVJDfmbZt3DtO9lTSyFNv1i0zfJRwV/XlgsAKuiIrGx88uIBm5it/Pg9KfA3rhmYFJZqpDtDIClKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1q3KmF7GFISQT8S9tLsbJH+OYzpCjoxR+k6hCrAMQQ=;
 b=w5ukV1SVmN5D5eB8vBMTUV1TZOHJ6c14LvvaL9x2tWc+nWTS969bLwFzLK+BKgT5VsmvOyL9kFJ+4Q13JggiILmU+mYuXPmQFYjXz9yl441bfpPCQJCAI/FE1UNiuaFfE6mOQFd6T4o9b7ucn9jpPJEpGQvgWk8stpinc9TWltwPg5dZKDYd9KjSVYQq5gP7lNXxVi66VmTxTKNLW2AL0nbz+7JTqX8R9ZYRC/RKygU7TumNPYM2W/Lqk5QGgvsoG/+D4mihf02qbxIde7QArHZcT0JObp7o/fSC4p/vc1sVFMCqINCbh5OsixbC4hiLOPQV3cJOESBE7v/7wCQw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1q3KmF7GFISQT8S9tLsbJH+OYzpCjoxR+k6hCrAMQQ=;
 b=li2CCzhLK4U/tmMfuKhwcPaeDpz/KeZ46gF/+8ZGRjAY/4zLZkugqhFnrUj9Zblg/2VkH9JM4CIYirsZyzMQmwGUKqmrRcvvJYCyvNoJf26KDn0YeeOz1MX4gHiwJu6uT5rQT3sUqEzbQFgBv5Wj3P7Ywrmt6iUZXMOFnky9yvU=
Received: from BYAPR08CA0032.namprd08.prod.outlook.com (2603:10b6:a03:100::45)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 00:55:24 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::3d) by BYAPR08CA0032.outlook.office365.com
 (2603:10b6:a03:100::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Tue,
 26 Aug 2025 00:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 00:55:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 19:55:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 25 Aug
 2025 17:55:22 -0700
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 25 Aug 2025 19:55:21 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>
CC: Jason Andryuk <jason.andryuk@amd.com>, <xen-devel@lists.xenproject.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] xen/events: Cleanup find_virq() return codes
Date: Mon, 25 Aug 2025 20:55:13 -0400
Message-ID: <20250826005517.41547-2-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826005517.41547-1-jason.andryuk@amd.com>
References: <20250826005517.41547-1-jason.andryuk@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3f9c9b-4a37-40d0-30e6-08dde43b3d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CzLqcgkG2C1T6JYUkk3ak8wE/m8cS/VXFMJke4mmXoNe98VGK/bl4fXIPicd?=
 =?us-ascii?Q?kriCYoHmduWs6j8Gjcg5d2VtZ2N0IcQ3NOqhdwXNFa2YYPNOxC47PTQScD/A?=
 =?us-ascii?Q?etl3ZIh6sN383oUu/wvmH9R5tdPC9Oy6DXOXCiLSvZjGTAlGhNSkotL1ZjGp?=
 =?us-ascii?Q?YTZy6xZSeMUYpK4KwCxlkw01Eo1rJ5qkCkHiyHVh0PtIBtwdBLAuXB92+kdf?=
 =?us-ascii?Q?3QXp0/OGGcESSC0my6Lln3oMsQ/DAN3oNATw7S8bbcZeoPB4ZlZSBavki+4X?=
 =?us-ascii?Q?4Eg8YpbqhLBpq6q33p5eEQ9tFTF9EkFQxK8g7MQhY3g+ixJ+J3lrXuFU37br?=
 =?us-ascii?Q?Yh0A3kC7rqiCiU4Z5i3L6OotH1Y1WOhB9aa2SD6Jwsh4TYDMNu94LPPpWdhr?=
 =?us-ascii?Q?DKGi3vYuOZ5genEmBK4O+/5X99oesdircHZU+/PuQ5wV7A7dyp9LQeT5ggV8?=
 =?us-ascii?Q?urnWLWU6GvXh4lHj2IwY3hBRzQqSyY8wh/3poChhCEzIMeKyPTZBeWyZF5Z5?=
 =?us-ascii?Q?3Jo7dhT0MCo4w7KDs0z3fwTOHs/84S9MbY4tqvsR8ZQDPq5g7hcy+jGUoLFj?=
 =?us-ascii?Q?rCxonjjOt2CdkW3fD54Vmi3zgdt6p8l+fO/veaWBabaadzyDqhxVqeyimTjv?=
 =?us-ascii?Q?/7/5EclWK4kTBXrXaajoFi2M2g7UnshoxXYuNuCO9Tsl5DddETvr/HSbPfX+?=
 =?us-ascii?Q?3ssqfNIXqNYQPrmOHcPqXUt/wGC/B7lqJt6hYN4HPppfubCXQBBlSUUAd82X?=
 =?us-ascii?Q?W9b+VjVsaiM6YHTVSuSQXzg1tHviHwvGCcLZFhBzRk4NSq759grx+JfQYz27?=
 =?us-ascii?Q?+7tbFB0ngYvzIzmBsFHh82n28UEcdYVZUWCFSQROY/tQk5OUdp9VtirwtYgc?=
 =?us-ascii?Q?LHWHaQNl4XlAfuFMoZiSQ7I+4vWvvMbrkjcim4wMktEyBKIT5OP//BVW462B?=
 =?us-ascii?Q?mH6YNUv8VlgN0NdBu6LMngZKnJy4FJt6tFxwgSDsMmMj7ompkPIhgK61OKqo?=
 =?us-ascii?Q?O30aMGveqGMqPerVERJuDKZ+gFfIaZJccw4ATVBa9GSem0zA6vVcbBXZhOXW?=
 =?us-ascii?Q?zyKmN7ltAobUZCR00WOz+GgPllGuUA3vP80tBbJIYTLhcLlsk5vSEuM63nkE?=
 =?us-ascii?Q?EbIS2yMdilkRcttipCKnYjoIqf2M7V26/xaxvreLHI1mR4eqOXwveSN1Ks5o?=
 =?us-ascii?Q?CqRIA7O8OVVJJV+Qrj/PG1Ssx4JWYbvWRG/SyQyWl+TPVWg4SZ8XDStM3lvV?=
 =?us-ascii?Q?9UbIK4oCV6fCV2n11jtiGWw4ZRr4WjThuKolsKqX26nsGSFNVtAC8TNiySXb?=
 =?us-ascii?Q?RLdcj+vjJ9a3+IQWLTxzXr+0rwvQpTUHYcr0EwNfg5RFHGqCxBwFAtoZu/Jv?=
 =?us-ascii?Q?/OyIP6Ql3t2m8iAnTu2gegWoFCQihaQiBG5xIgvLCZEjR2GqCX+L8nZF4XZK?=
 =?us-ascii?Q?LBCAnnc5vISJEu/yBmmEXPdyvU5NrI/7ASCrcJ4cJmBpUbp6NmScC6mqPb4j?=
 =?us-ascii?Q?Y6Ba0NEveE2kUDzyemIdwROvLJ8hnlwbHkvc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 00:55:23.7683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3f9c9b-4a37-40d0-30e6-08dde43b3d44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941

rc is overwritten by the evtchn_status hypercall in each iteration, so
the return value will be whatever the last iteration is.  Change to an
explicit -ENOENT for an un-found virq and return 0 on a successful
match.

Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
v2:
New
---
 drivers/xen/events/events_base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 41309d38f78c..199afe59f357 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1318,7 +1318,7 @@ static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn)
 {
 	struct evtchn_status status;
 	evtchn_port_t port;
-	int rc = -ENOENT;
+	int rc;
 
 	memset(&status, 0, sizeof(status));
 	for (port = 0; port < xen_evtchn_max_channels(); port++) {
@@ -1331,10 +1331,10 @@ static int find_virq(unsigned int virq, unsigned int cpu, evtchn_port_t *evtchn)
 			continue;
 		if (status.u.virq == virq && status.vcpu == xen_vcpu_nr(cpu)) {
 			*evtchn = port;
-			break;
+			return 0;
 		}
 	}
-	return rc;
+	return -ENOENT;
 }
 
 /**
-- 
2.50.1


