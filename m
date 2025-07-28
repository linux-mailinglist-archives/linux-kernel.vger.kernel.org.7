Return-Path: <linux-kernel+bounces-747523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06804B134C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E29169007
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEE222127D;
	Mon, 28 Jul 2025 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BdxU5R41"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF25222593;
	Mon, 28 Jul 2025 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753683078; cv=fail; b=Z4nQGgWWREKTG6pQRoePvJUMJhJJbJ0x58GLdXtiT6tRZ2YsCsRE4UcJ7jskt70Qd0y+4rTNKIUmmvmQKH7Oevh5SqWKKeCkYsDLfhQZCCdYDK2KNUr/QW3G95pdQV1FnPElr2QQO6VfvdeTClzDNYO7y7MF5cLiYijSJuJ4lzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753683078; c=relaxed/simple;
	bh=qd2nlRNIlXmh4gWO77oMgWCT+lS6Ufv2Fay9kr9glrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nG6oYsZ4EZOkCOTBi4ze6Io2iwkbXss3TODUPEPHOII10Fenog1sqAQf/Ol7LdYgJr7Q7C5T2TmeeXIxnvCxDGcqkGieWSpXtLO9zFYTJvziQ+HO53MucKVGea3RURJT6soHn3d3aNiismyvB6n7+wF8lbLA2zDjzsDYTjYNybM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BdxU5R41; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+i28CZwdG2aLlnejo0bagqpDonh14SlPb7SbmZXZO2NpiPEqo0JTKcE6Rekc9UHMYHjtboslOeveRW6PzttP1s/QJ8ZgzrBTT30MibUsfqaNVeUJfYZrtGCg6S7OrBgil+r3LiQtB2weKT4i7Bih5kvNl1qPz44Otsk1QPIJKBACmx7tARqi7/WwNVOZYpgpXtskI9UHv2GwGLPZ6VXiYgRi2xG+FJpJPSClmUJyKERDWiM+CqGAmsGbCojAPx9v5VsBQ/1BXwd3tYKaAfMdhvB3TQrmEycR5FgzxeXciw3QNwJekqQG+iU7ea4QQnebom51OEm2JsNwZ6CZc6vkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxSE0xH3j7Le+JHulyFedEBRTlMgaDULnxZgrZcSytg=;
 b=Zw61K8gnEkJNP1AjoFofENQ5jQn0MDlzp6n2Kj+kxorqtws5Zt1WOPPyZIf32zdoeN9u/CQKHqpN0/IVfy2ZponoC15/in2+D4QWw0LjkVL5aT3NhWEy75+8Dw/RUwFqSB+roxvfmQlFPVFtjr8W+GfEiSUoTECRFTME2b1a5ur6DcLCieAqMcXGm4T3tf8nfqwnrlE7HPmFd+Al/MTJOH5hTBKRlOHdq6RTa5HZ5705GlnkOj58sataTJaknZ4e9q+YH1cGuLsVgnxwXi91Pqzvj/kKDhRctJHibY67oyHLzPu3MEqClrgxUoTJu5AweRLlq5btxhhXVcboelmKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxSE0xH3j7Le+JHulyFedEBRTlMgaDULnxZgrZcSytg=;
 b=BdxU5R419DlG9lKzLbpa6t5CZZfMU2++Xly5J3n9ieYN39lLGmIHCRn1iXytbOvS6VCAb9ksWlTyPC55l+d43uk1KY3ZY/Yzjuzz8hO/k/Lo6abDERwjDcTdr++2AOIu5o4TLnwdz82PECf6BuvtikXKYaxEVBCSHiRtpSXIgCI=
Received: from MW4PR04CA0221.namprd04.prod.outlook.com (2603:10b6:303:87::16)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:11:13 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::11) by MW4PR04CA0221.outlook.office365.com
 (2603:10b6:303:87::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.25 via Frontend Transport; Mon,
 28 Jul 2025 06:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 06:11:12 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 01:11:09 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <linux@roeck-us.net>,
	<Anand.Umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>, "Naveen Krishna
 Chatradhi" <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH v1 4/5] dt-bindings: misc: Update the "$id:" to misc path
Date: Mon, 28 Jul 2025 06:10:32 +0000
Message-ID: <20250728061033.1604169-4-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250728061033.1604169-1-akshay.gupta@amd.com>
References: <20250728061033.1604169-1-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c59af7-0aff-4173-79e2-08ddcd9d8d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KFK4HXCWPMUCm9SKwhW/tkwVBlOAEpuD22VtWirJxJw7s/qgQD4l4c0opCXo?=
 =?us-ascii?Q?SddKLD77tYprdlP8hHdgXg5n3bRNWDa6to2D+/Ot93j9/ykQ2iB2E+qABZcM?=
 =?us-ascii?Q?fj7D5dRC5mb/7h4ubxALH8YqXXJn1ORS491h6yLmHdCgGwIMIgJDIO10c1+i?=
 =?us-ascii?Q?GCRSGLIXwNi4XJfG9jVvX53jx6Z8/Wa+gVxWn0ohYbah9bQDtZxXU/wIlzNb?=
 =?us-ascii?Q?zat5mmjcTeJ+yZFMafvARx+5Auejk8HH1HaBELlSMhIzgJooGxKNmFQ88U8b?=
 =?us-ascii?Q?smzat4N03vYDUdKcJa7+Bvbi09g5y5KIKKzvuplNDG7icKHYg8lT4Atabr8v?=
 =?us-ascii?Q?IqJYLFbxoEDBA1yljselznHuTiHUCsd89Ktlpsfhd1o3hhRtZxGnTzLKA8uG?=
 =?us-ascii?Q?AL+GSE/valTC9BzWLjIAThNiK4sxfjZ4VKFX8sZVP+eLEAZgbYhZ7hNTyJxm?=
 =?us-ascii?Q?tm9ZgwHtNuAiiUWTJYVX987j/Lm6KU0SzSrDQI5SmhgOiBIc8ZmtwbyroF5V?=
 =?us-ascii?Q?Vb0wITXsZaq7x20XkhtLL+C0L7Wd8wSjREdkb1rRiHs8KdUYjmQEqdUidj77?=
 =?us-ascii?Q?uvIYUWTFVJIc3ubq61Ohyn6u3n2LbCl14HUblEA//I9yGu6CX+VeoPb2a6H8?=
 =?us-ascii?Q?55vy6GYqoD78AalbiWqyX8+64ahvJTwaEr1CEV/FNrapJnAEKm07kzuq4Mp3?=
 =?us-ascii?Q?mu+1XqbZBlqdPqIg7RvR/ZbyuKe4hXx6I7eKbd2NjltwzkUeEE9sgpavFyph?=
 =?us-ascii?Q?++9wRkIqmvLk5d/nVcPgkBXmbAXYoLfS+NyQ0ZaM8zNmpTDhX8cvqYqeBiRj?=
 =?us-ascii?Q?HH0UuJBQpyNzf5AxCLdtHoNFZobvUu92V7wjUT3V+u06mgTOEP0a8VF8/wki?=
 =?us-ascii?Q?KeI9nsGkiwph8n30/ZsD3MWbkQVDqFzSOXMoNJgqjUQ7nv+1CsqiEphC93JI?=
 =?us-ascii?Q?0/sTTodKxogWXQjlNX49ORFbbCdWhTglaOYZ9qXURLy7/F1qSsSrltA4wF26?=
 =?us-ascii?Q?SwIyPZ3/MjNpuznZhczO5J+m2Y9q3t1t/EwCzbCLNJdQNyJBu821HQd+BP3j?=
 =?us-ascii?Q?s+SNl++DTJQTJ6htDFNZkARsCOHnXo+lrgs7XFLS+33uvHIml83q5qUSm7lj?=
 =?us-ascii?Q?0oMs7Vff6LzAwPlgM1tBSoTWoRmP2Z4CUsxGDzaUN8UiBWxm6l9/9AD8l70l?=
 =?us-ascii?Q?M//H6MuZxWZ1mxracPrHo9jWhhC2G31Akr18MIdvQnNnPuozvs7/eD5lEW9d?=
 =?us-ascii?Q?gNddjtogodoamxKoGUiFCdLhvFryRss3uzn/xXf27J/euEp7P6OAsDdL7xDb?=
 =?us-ascii?Q?g0nQFALLvlAnV/BneEYLOWP+cZXguN0awTq4GoWwJ0gV974UImTDR/y/0bdx?=
 =?us-ascii?Q?3dNApKx/4hogx9UfTZvq0uf3UhAAztqdziizsxGQfsVU6ddTg3H5AVLgHLs/?=
 =?us-ascii?Q?zKt4ksDXfNksPEKnOpnzTQhRc3yb4zPnwHowiTUquVrBZVYJMKcoJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:11:12.3491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c59af7-0aff-4173-79e2-08ddcd9d8d8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568

- Modify the "$id" path as file moves from hwmon to misc

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
 Documentation/devicetree/bindings/misc/amd,sbrmi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/amd,sbrmi.yaml b/Documentation/devicetree/bindings/misc/amd,sbrmi.yaml
index 353d81d89bf5..5fd221200e37 100644
--- a/Documentation/devicetree/bindings/misc/amd,sbrmi.yaml
+++ b/Documentation/devicetree/bindings/misc/amd,sbrmi.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/hwmon/amd,sbrmi.yaml#
+$id: http://devicetree.org/schemas/misc/amd,sbrmi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: >
-- 
2.25.1


