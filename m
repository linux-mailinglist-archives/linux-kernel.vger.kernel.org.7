Return-Path: <linux-kernel+bounces-828794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9085B957AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F19C7A70EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABFA3218B9;
	Tue, 23 Sep 2025 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TUesZLxK"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F8320CDB;
	Tue, 23 Sep 2025 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624320; cv=fail; b=vEsFFAj5ZT5h77mHGNTZRLbQ9gC+bTyVcIGL8z3Wu/6eEYXQ5Tju1x9PzgQL74HIHitj8PyMI24MxhhCYrTlKRpNRjdP3w5nJYgc+yF/HVTNGIlJo/35W0Zf3EDwt4MEK4c6DZnzN3FiCgRr4gSVi4oK2kAYDmhneTWGXL4/PuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624320; c=relaxed/simple;
	bh=L+cljrz0+9Tj9YokqZnaXUcuvpWHd83RF8J7Rk9DdS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJ1f/QCzZEBx/ogDeSfRwCR+xHw9DgGrm+Pv6NxlC1p/WvPFKlYPurOkt4V2JtP6soMwZ7PI9CHq7rewJXb7Wv4rQI1Xn+xy/0ibOQkgZhOJd5RBsFIKIOYawWwkJzQagrDYTzN0BFHYMjeVHzfELBPYCnc6ha6Lc9vBUmvPzy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TUesZLxK; arc=fail smtp.client-ip=40.107.209.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjLH59bOHWJq52VPKUPRlJIE7CglvXHP5hdaNXF0qGL8jexaCEh+6pf1q/tILRnYUykfnCHUTR9oKmByTSXGgTkPNXjKvhxK7gSwvsgHYYzdvt7y+GhCaE8aBR6X5aYlkhvPO+4tYvElA4pLHwSW0xWqurrZhdWisqAihsUl2OJBi8UpoXaf9NAfQfLaeNUBvbNb3q5TH9KGBvp/6onxAq1cSjXCj4Rj4MKOeEhdh4dFFaQ1YRM74ZOduv+wIrusKE1aqrrs8TaFFlSf4KRglxCalZ8U2+XU/FhWp22IPR0X/yfW61P2aGnpVjBDV9l4xO25O48xYKEyvKZT7CoS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKzYkEfnASHkRDvf7/89o2I7nOG7igsK4qh9vMa4Cl8=;
 b=Yd61bMmWfYg3o84DUW4y/JtG6LJzXMXeMRF9bGEZ9lDs8HBgeayi5y36CM/llt1H5llh5oTH7EYvQTgWtmrPKQGe3dNcPl4uVuXiMFvfUR2hOGp2Eq4BSS/Pomx6VaXTDpUPzVdOPRJZ1X6YpaVMEucef/Gwn+hcG7uh+JVKJYxImaYwILRxmiE1wYgkjGCnizxQEF6b3UPc6BmEDKT1F/XeJmtB8vwNlwQcn4/J7nEikl5ZA4cK8wAAOrpDmwATmqQmOYcWKMfSSukgEzUSlhiM/bUZ30WFuYQM2ckB8UkjJzdI9nTNHaQYZriosveXuTwDz5NAUvdwmeAH/M1fKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKzYkEfnASHkRDvf7/89o2I7nOG7igsK4qh9vMa4Cl8=;
 b=TUesZLxKAfg4Nvm1dK1Dpy0+EpYOTZksgg7TV6h11GKe77VYba+RztuDAN7PVzBc6PlkxgnCgv1hwkBuEUJTY1/DA7SxBDILvwjtXCfZq69NZH5DKJElAYNu0uZbS1QHMqqCzKIBjjyQHs5kgDCKHQYfeQHsOS/O6ilxNQAbukufSwNwQS+vdCC6M4O39n3+48UUP4vClO5EIcWL5CKokEMBjaeH7Oq0MWkr53wBgGmDYbBkS7yQ0JUi/NcCmZe5WCgmPn00BMXbBPBAiddqYyCj9O8kKGO+fCwsf7V+S5HEeOUY87FyNaWpR5yp6hm7/CbkhxVpTg+kgRj/j1BQqQ==
Received: from BL1P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::17)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 10:45:12 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::cb) by BL1P223CA0012.outlook.office365.com
 (2603:10b6:208:2c4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 10:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 10:45:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 03:45:01 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 03:45:01 -0700
Received: from r-build-bsp-02.mtr.labs.mlnx (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 03:44:59 -0700
From: Ciju Rajan K <crajank@nvidia.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<tglx@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
CC: <christophe.jaillet@wanadoo.fr>, <platform-driver-x86@vger.kernel.org>,
	<vadimp@nvidia.com>, Ciju Rajan K <crajank@nvidia.com>
Subject: [PATCH platform-next v2 1/2] [PATCH platform-next 1/2] platform_data/mlxreg: Add fields for interrupt storm handling
Date: Tue, 23 Sep 2025 13:44:51 +0300
Message-ID: <20250923104452.2407460-2-crajank@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250923104452.2407460-1-crajank@nvidia.com>
References: <20250923104452.2407460-1-crajank@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec5a9c9-e63b-48b5-a0aa-08ddfa8e45dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yECdtu1VKwsVV1yFkZcVHnCXDLmBVPGfZqKXtZ1Q64fnzNhVnr0sg1HunXdz?=
 =?us-ascii?Q?LeOEBVXBcnYTv4FmC3dWXW3zBllsGq6s8HUE9suRs5RuyC+yiyPB+xop0ZTr?=
 =?us-ascii?Q?0mkAZ67+pRNJUgR8FAJkQC/BYDOk/5OVq20KC9NQCr4AqpilL9+qWzk1JBQS?=
 =?us-ascii?Q?Qg+uv6j2kaYOkVlD58Qqf56u42TrPSfD1m5aB9+6CXi6E0FVCreNGd0JjhJ8?=
 =?us-ascii?Q?9xj4m7UOzJvP9R/cJP+niyk6un2LkNbdnq2mI5UvTqYUG1o5OnCnxGwxUram?=
 =?us-ascii?Q?80n6JtpvmG26ScvaBXRSvHL4d8LnZzXygOBYlrVyeFWL1dL4rTCOkXi6GllP?=
 =?us-ascii?Q?5Wy5GW5ytMqTou2z6awrj6zExeXiiIzzzqLjGmw8IuTF9KVXd9V5ScESuBc4?=
 =?us-ascii?Q?HeS4I1ur4ME5F1M8+lc1dd8NlSDF1vgR4txpOSRENWF5ljnd3pOePWZ9GY1K?=
 =?us-ascii?Q?V6CVOjCvsqLtAOUbs9hIem8fCTK2+KekdgvBRpJvQr1iXnJK7kiqvu4hLFpp?=
 =?us-ascii?Q?z8mVdly8pzFLrANrvg+Dd+X7LwL/smHF5+dz84qsIi2x3Z3QLAECEpIbsss5?=
 =?us-ascii?Q?cwnMrVrwT8UayHV/hZFSys4o5AT75sRAwI43chCDlc70SI4hAGl9IQ7XE3SP?=
 =?us-ascii?Q?BSaVSNLluIcURwm1f/5gVerFtaktGtDEEjUOM2de+rO5vBVPO4j9kb+KZfQM?=
 =?us-ascii?Q?toP6Fltwh+mH84mCRU5n60BWZwuE6n5fCJUlSCrrYxLEaOxZ7YGCZr2ou1pD?=
 =?us-ascii?Q?OJWWmzFgaQy6ZyDOQ3Z9QNkQON947g305ZxqP0EtpQcyJke5Spd8FqH07b58?=
 =?us-ascii?Q?zKA+Hw/YFJGeub+NbrQCXu8I/SZ+f/YdxSiYQx0bibADDh+Yg5DkhKvkeW8z?=
 =?us-ascii?Q?1/8q3KlvhhEdKeVI2PldUlHfBJHhFlEtytOq5OvfxQDFxAAWumIVQnMRFTNi?=
 =?us-ascii?Q?VB28wVKw5q55H7lvccOi6Z1MjVUBn3Rol7WXKml6wAf1dk2gEghrecJ4vfNh?=
 =?us-ascii?Q?lTYvhBVZ55gudQwLUMirbE/lHtZS98YSZqW7fVKcUZvxnNmBPcW0UiLJf+t+?=
 =?us-ascii?Q?1NfYLIqcVMoChuy+N2jCDovxorK42vlEjMdiBJ8ZIsnwnFMoeQiqFxCyBioq?=
 =?us-ascii?Q?/lNeL1dFV1e0VjURhsYPvgYscdbV6ZnRTT/h+L+QK9JO1IT+BcTW3LG1y/V7?=
 =?us-ascii?Q?pfXESr3EpSeTj+omU5UXiW3HPpHkaha6+gwGh840R6JWFZ69UqX1+Tf8Ttv3?=
 =?us-ascii?Q?oqfbatv3GYqW8M928tU2meGmrna/d+Zc0suU6w/PqFdHlKYMvc9Y7jo/xxd4?=
 =?us-ascii?Q?1jmZG9T9F94KVa1EIk0gg/yn+yTBQK5XDPm0+9U2b1pEdfnSeCx8jDpdVIn0?=
 =?us-ascii?Q?1hEPWjQbil3iOkJP5BSRhbVNj75McRYUsFfUwISJzqBaYg0bojNrwhaAUkj0?=
 =?us-ascii?Q?YtwkB4Fg7JTMXhfFyT3+sHqKUq2UqQCAPB2ktl2jR1ZGhIZ32glXBwZhQSol?=
 =?us-ascii?Q?cPw69pOH82yb/NH9Z7RAdHxwaxf07wzCvvff?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 10:45:11.9041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec5a9c9-e63b-48b5-a0aa-08ddfa8e45dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841

Add fields for interrupt storm handling.
Extend structure mlxreg_core_data with the following fields:
 'wmark_cntr'   - interrupt storm counter.
 'wmark_window' - time window to count interrupts to check for storm.

Extend structure mlxreg_core_item with the following field:
 'storming_bits' - interrupt storming bits mask.

Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Ciju Rajan K <crajank@nvidia.com>
---
 include/linux/platform_data/mlxreg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
index f6cca7a035c7..453c8dfd7eb9 100644
--- a/include/linux/platform_data/mlxreg.h
+++ b/include/linux/platform_data/mlxreg.h
@@ -131,6 +131,8 @@ struct mlxreg_hotplug_device {
  * @regnum: number of registers occupied by multi-register attribute;
  * @slot: slot number, at which device is located;
  * @secured: if set indicates that entry access is secured;
+ * @wmark_cntr: interrupt storm counter;
+ * @wmark_window: time window to count interrupts to check for storm;
  */
 struct mlxreg_core_data {
 	char label[MLXREG_CORE_LABEL_MAX_SIZE];
@@ -151,6 +153,8 @@ struct mlxreg_core_data {
 	u8 regnum;
 	u8 slot;
 	u8 secured;
+	unsigned int wmark_cntr;
+	unsigned long wmark_window;
 };
 
 /**
@@ -167,6 +171,7 @@ struct mlxreg_core_data {
  * @ind: element's index inside the group;
  * @inversed: if 0: 0 for signal status is OK, if 1 - 1 is OK;
  * @health: true if device has health indication, false in other case;
+ * @storming_bits: interrupt storming bits mask;
  */
 struct mlxreg_core_item {
 	struct mlxreg_core_data *data;
@@ -180,6 +185,7 @@ struct mlxreg_core_item {
 	u8 ind;
 	u8 inversed;
 	u8 health;
+	u32 storming_bits;
 };
 
 /**
-- 
2.47.2


