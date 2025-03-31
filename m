Return-Path: <linux-kernel+bounces-582389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6FEA76C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 19:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927B6167AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 17:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0736B215073;
	Mon, 31 Mar 2025 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UA2hDYeg"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5464213E77
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743442166; cv=fail; b=RfvbpGeP1OfAHTaNNxFFN+j/K0WmlcoKawKCrGLyXRlQ9tiILOj40NK3l+rW8Rp0FNd2XVxhSWn1RhnfhsTk5KcKoe7oGsx7ZlAFvTwlN1z5PhNnEgM4shWMcYjCRo6DXOkVjOi13JXYf+mfTNCSbLdZBxcEYFG1UBt15JFMEQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743442166; c=relaxed/simple;
	bh=pDZq3gkFwyWmdPFhZWHAwop2OjqBWclhzllNor9xnPI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hHKoST4AkjZI6vrcvuG2x0Jr3D1P3xYVSniZZ/4ZNKcV+ReFy/X42k3ykaJHAUHXLHVzVFtXU8kwQZ2oL9OHIQGD5wAAxe/YuKNvUhaWmlN42/szbxrQN1BvIdVWoMF84PWi1nxcAP79YpVdw4x1MMCgmP453QtADD2F/d8Icjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UA2hDYeg; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt+EufALWn6OX0zOVMkVFBCK4+bdqODBhGUKz9oFnRsAmQ8azv+NsMZ0u+LUVF6Hegc6Ui400J52HdRJL86WD9he6uDKNPAVMi8O7dgdUGwRBhzhibvleDMjxt06H7On0rnnI6YVSfNbSWAO/O56Qy4nhwJTZMky7qtAsljriyyYigMgmRyIm7ZzGsHvBCWwLWVPFDckS0c8oaCu4rCxje7iUzibPVnERQ9/hWd3dhGLHzir88eemgShQjL7sT2w/3YqStM1i8qRdeaDxKA7SbLcYQBWEWZBX1ji4iMc0zOKF1oivH63f1j/xQ9QsJmFFUQgSwrZ3PdiCdIQcGKzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lL0Jbs5VXhS7/v5txesVAgBEq43pyq8eEgFTJqznXk=;
 b=YnHbROAT65c4uoGz8JsF5Xvvd4zNgxawjaeRiTuNfK3RB4ufD0vqM5rnZ39lHIwb7hiUu/O18sgiXDPaMQnM6X/ZUzzTZBJt5k60n/7UYATPYumizTf1VdIfmwvUmaSUw5Ri2ENZlZWGb1m/7rDFJRitCpKzeNTVIRwV5GwMLG7kujNnG9Z1EvAPHnQ4ERdmSoxsdTLe7o6jw+vyhWF8UNST62MuqkfnoqbwJDaUsFfh4tnMMwFfz+4bfAnVIKEEPdo8XmIU5OQI6D7JCv7XAtDniEm7/uZ6hMFdKVGLQ52iPdAkcNQXevSCmARSmdv/ifqpBInujPOJ9EZkrvtn5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lL0Jbs5VXhS7/v5txesVAgBEq43pyq8eEgFTJqznXk=;
 b=UA2hDYegSVYgyA+M9sWU+T80KLXKj0K1RoAjiQ9Og2GUbDVl4XAiJJpbEDbSVlDNDJFwM7s/yGTw5HOvx8DYIjlxU1W91X18KNnO/jzPH6DiP1pZ8xxz/zvn2qfm0a6kfUZzJelX7aRYKNNHMrM9b21BS18iSswlU13qndDeiCU=
Received: from CH0P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::7)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 17:29:20 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::a4) by CH0P221CA0003.outlook.office365.com
 (2603:10b6:610:11c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.39 via Frontend Transport; Mon,
 31 Mar 2025 17:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 17:29:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 12:29:19 -0500
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 31 Mar 2025 12:29:19 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>
CC: Penny Zheng <penny.zheng@amd.com>, Jason Andryuk <jason.andryuk@amd.com>,
	Jan Beulich <jbeulich@suse.com>, <xen-devel@lists.xenproject.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] xen: Change xen-acpi-processor dom0 dependency
Date: Mon, 31 Mar 2025 13:29:12 -0400
Message-ID: <20250331172913.51240-1-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b15ecf-d049-4bf8-535a-08dd7079920c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Blz5XQYtI0t6poep2IZ38dsMrZei/gWHtR+5lv6duuqxFrowys4sFiqDUfdR?=
 =?us-ascii?Q?SY28JWtv4JeQ+k9tsMprJfRIoVyKzvPV0OMkOMzMxeGTNn4m8Twdf9pl/E4Y?=
 =?us-ascii?Q?hbsUbEmMuP5xGM1B8PE0p6omLv1SNDTFhIbJmtWP49CPdpm3zbypZEAXF8j4?=
 =?us-ascii?Q?BpA5C87I1apq4Hb5lWWvCZMhSM5dpL7/V0oxclq3SKuehGrvhtctMrBRgaCb?=
 =?us-ascii?Q?qAUGK+e6fvuGD6982rTKw4JYSXUHf9iyIk4NPA/TXPG+lDf3N9YGbZIvEgZW?=
 =?us-ascii?Q?orMnzKqTVjVzxFoZ8gFiElQwEy0/Ktco/82E0WXl6br2J3eogGcB7D+UHtnx?=
 =?us-ascii?Q?0V/qwpcwrBT7SB+PNKdLQ0smTfMGig81uuqLxdxiDULIhtKS1W/PDrWgcgZu?=
 =?us-ascii?Q?ZYGAgiBOfQPyYo1IhlNtEJaZePQ8/wXOq/a/8ULyFP7VR+4t3HDx6Rg08POH?=
 =?us-ascii?Q?RV9mjjg8Q7UCrhSAuR1DYVrf7TVIeB9LmarBl71FMWJLUZ6ubww4jUaeW6j5?=
 =?us-ascii?Q?JRo3oqouOAu9e41H/7MOHYNBvZyTDvPUNdY8vm3oDRfBQ43Bx815BQpe7OeE?=
 =?us-ascii?Q?wx308yryAIHZwZLpS3Q9eeURSUP+hRlRYZxDwz0YSqu6wZP0Xb1ksr0gDGvI?=
 =?us-ascii?Q?3eWQo9H9eqxBvZfJ+HYo8QD8KXwpwp6/8ESRfKUzI21K0YkVY1FJqLMDRB9w?=
 =?us-ascii?Q?LttlyIe5/oK7cNjlS6NLWY+pixQddqBiDeG0yhYccYL8h/QfgxsRd6uu6d3z?=
 =?us-ascii?Q?6QZ9ZTsWjB+e/BXntZDb/7k4z1JvroITTwJgyV7lgjx2qJfWm3m1UMTcBNZZ?=
 =?us-ascii?Q?2L8d55LrYsVG1ziM5s7j+ajxyRS384Fe1ijksR0GrPwbNmamDK1r2BsqreL4?=
 =?us-ascii?Q?zYOdOFhn2VAb0gTkIrovaxTMPHPsKcR3rEiAT0DYk3O/cKuQ7CTgUHLOaVfg?=
 =?us-ascii?Q?cVIhu/yA+ccWieaHwyCwIQOq6i5kuYBo6Yil8G6levGa6f41vRYPo67t9VkC?=
 =?us-ascii?Q?PgAO+OC6/xi5GPR9B4Tru4WQg6dqBqapNEnL1VZZkmvs8c28iO3/xVNMEIIo?=
 =?us-ascii?Q?sakvqOTxkGMml3A95k1uZClKFBQx6SSb7evgwlDQ/VLZVSVFIFApgro1un6e?=
 =?us-ascii?Q?gTUigXFtWjep/rZcXejzyeljdm2qYFXSNzdo2ukcO2mj+kxnZX8FD32RLEvk?=
 =?us-ascii?Q?I+dmMFpg4wQRTK3idEotPk0vT6FjPWy3mw+LtQkfsAXCEjSQd6ZwJhxjBvl+?=
 =?us-ascii?Q?NonzGqLr8YnaA1CsYlU2De67f4KBapw7seTpp5hkQPDzZujrgxU7jZnmJudH?=
 =?us-ascii?Q?O+aiAwV0xEeTZ7f6Cm+xnAVqiXyHG+NcDYnmH8BdUAIvH/kHl5IRGk+9SVTX?=
 =?us-ascii?Q?GRV/diGaYdm9lDfMx/wDfTkGs1hOtEKKmE3+ZZTsv9oj2Ocq94FhVE0usv9h?=
 =?us-ascii?Q?z6JHQCeixDCTP5t2RHAKZHnY+TcL7ccr522uCjau5uDVPB23HPrMmSNHqYbR?=
 =?us-ascii?Q?o3ldW74iemjyFGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 17:29:19.9488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b15ecf-d049-4bf8-535a-08dd7079920c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288

xen-acpi-processor functions under a PVH dom0 with only a
xen_initial_domain() runtime check.  Change the Kconfig dependency from
PV dom0 to generic dom0 to reflect that.

Suggested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
 drivers/xen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index f7d6f47971fd..24f485827e03 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -278,7 +278,7 @@ config XEN_PRIVCMD_EVENTFD
 
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
-	depends on XEN && XEN_PV_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
+	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
 	default m
 	help
 	  This ACPI processor uploads Power Management information to the Xen
-- 
2.49.0


