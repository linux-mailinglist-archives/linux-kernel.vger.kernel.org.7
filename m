Return-Path: <linux-kernel+bounces-789853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44368B39B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28E3189CC79
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32EF30E82E;
	Thu, 28 Aug 2025 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qTaiFF1H"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF4730AD0B;
	Thu, 28 Aug 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380608; cv=fail; b=GQ8PysygCeiKulUn30FBucIhsn/S0XJmXntiU49ojZZaqexlfvTkBqeY+/29Oxn8XbUtR9NMDAsYkqEIwhqoc60HE9U8clpA6jPlXtDxclc7/E83sAZDrTmdBc8w1mcHLA9vAFxpqXxDbHCYdKK3ies3EbiHzbhQckuNI4ov6Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380608; c=relaxed/simple;
	bh=U6237DGAqIm+CdCP6ryQMn9Imrod03KKSpbJ9itjgdE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LOPBEkiBRE/jgU35J4RtZdDzVWmUQ6VSqSYC/0vCy5+jqHtXIyUKV3JLYoFRnUbRBzcHDaBhgKmeYOEUuhd0E10EHyiciry4JoUIirQ0PRjZtw6SJnzHZ2CTMZcT5e+asWQj+rJwAP3sw5RODNWk6Oj+RFwB7v9A58wclEl/bvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qTaiFF1H; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ge08C2MPBhJ1oy6i1zSOoWNiMRfghwsbLMB0bikB8UICq0QVK27MGMmOjeZnDz86eeJqCLtJMuu6mHTqmwXC+TAR79Y4Z4jzJQ6Jj7yxQmBCmlPLOr8G/lqjtwDLrxuqJem2mw/mrdu60lPK+jEwl6iIQ8rzNi9A9LuvhClOdqFb+zBSs0+8XXQoUBJBBBv/EL18ZgG78s9iiS4OeENajvB4OnpfOIX/T8ITy6E506Ow/bM04pcXtg3OK8DZVRc5rXWkuHaUat7OSSdJSD3yHZ6IQ3z6uvB7wW9wfag2gIMa4fLJeSkaQRYYc3cLOHsu7oNNZmcNR8GC8bmBXrEqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBunU10Iq5Y2qBsDmBWxpZU7qTjBA448F6Cu7T4CbuM=;
 b=LKiOjWDWcvJ6mXzbXyJSrFIGe+L7pMg8MlYUDgkzC35DRKVwquax5mk4cQPGmFSjr09E8agX+MmvdqGoO7H/SmrVuYhwBxaSme3OpZky6l+41HyYG7Q0RmtAe+C9JEeNFBSCijBrOQyT8IfZDhfPdNjadRBNYdK1xJQlWUbcSy6cYsI0FUIj2RsP45RXoXGVe8c3rSmeAX+chaceUpauziV8h9RuUGiQ9HI5gxpks/s2uSwxNrKExMkeTPwKwujI1iq9ck0gymNE9swjFSANv4Gtr0JtThesnXfho1JUbDdHsJrwzjQaBkQGCYNtciK1bKOCe6S/b3pliiGgBQTzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBunU10Iq5Y2qBsDmBWxpZU7qTjBA448F6Cu7T4CbuM=;
 b=qTaiFF1HlJwEtQLq8rEnJysiOLsrWHFXqlQ+1RxwipaURsEQ5NB2F45mF60xxMWVDTazBOy+SZjzoEYC3WHnZSVHNOD1FTXdK0tCpL2D2EpSH2KBBhyztqdgKih6RFUHY18CLykFl4cXZDgJ979y6hH6tmd18zyoOGJD30EH5k4=
Received: from CH5P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::16)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Thu, 28 Aug
 2025 11:29:59 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::b) by CH5P221CA0012.outlook.office365.com
 (2603:10b6:610:1f2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.18 via Frontend Transport; Thu,
 28 Aug 2025 11:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 11:29:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 06:29:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 04:29:54 -0700
Received: from xhdctallapa40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 28 Aug 2025 06:29:52 -0500
From: Srikanth Chary Chennoju <srikanth.chary-chennoju@amd.com>
To: <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
	<m.grzeschik@pengutronix.de>, <Chris.Wulff@biamp.com>, <tiwai@suse.de>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<punnaiah.choudary.kalluri@amd.com>, Srikanth Chary Chennoju
	<srikanth.chary-chennoju@amd.com>
Subject: [PATCH v2 0/3] Add support for Superspeed plus EndPoint for Bulk and Isochronous transfers
Date: Thu, 28 Aug 2025 16:59:41 +0530
Message-ID: <20250828112944.2042343-1-srikanth.chary-chennoju@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: cc229e9c-a96a-4f07-e834-08dde62638b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KPM74Ndy3YOCZNKckbwVyRxZ9vc2FEMIxyo/9rSvfLKEYtsT7oGwPN2uDFSu?=
 =?us-ascii?Q?vBMbgdDE1+R1qgT3Ne/S1IvdRbaPhmUnBsQqPHuZfcIw62OSDpU/CRYGo+1V?=
 =?us-ascii?Q?DsfbLSgYIDOb/XQnZuTKfDuPEshsMgRCCuX5bAwYokwg1ZbxzdRDk9U6p/WC?=
 =?us-ascii?Q?gk+yasWhhiyNz9FVyliPV/xA5Crwe18tv8mnG9mlYmaB9r4rbwf0NLV8uJVs?=
 =?us-ascii?Q?D0B8btEE1NxUMju0K9qxkBsoExH0hpHuFlVqgqoqCt2pQyrNJg0swHHUzNgD?=
 =?us-ascii?Q?l+At4CplxUAEPbyd9gfKyRoVLqgCzO/U/v9BDPGixwQC1Anx9U3fl4Og/Vsd?=
 =?us-ascii?Q?11lO+tkNOOXQ3o0PYS+9uYmnrNb+UBHhq39oc1qGIrEcxFSCv0jXE9/DwiWu?=
 =?us-ascii?Q?uiak+CY4FlQn7rVpGRRwUGkBBVUvsNtBRsyEOdITb0iQ9GY9xi0w9ZW4Gf89?=
 =?us-ascii?Q?Jq0CtKWaPsHl++LOFvnBiBaMgTAE5uM5Q/FcxckSemNuCU1YeTnPTBy5SFcI?=
 =?us-ascii?Q?tbePp6gsBLrjOiVDfXumrBxKSYlyO04ZSN9jwPx8ZDSPlGzedWwvko18KmyQ?=
 =?us-ascii?Q?pxI4cqTpaCguIo/RPKDxEaVI2iqPBMLEHnhiT864OizpvZBRBuUQ6MXP3Vq2?=
 =?us-ascii?Q?F60Ywb6khlVczqu5v/oIwVGY6ZxFoM1su5LY69mwqIXvFwqXZLXdI+FfZivB?=
 =?us-ascii?Q?66oluEEriLQds5XY7Waj3HLuuNnuH+So8uKQtCH4xOt4ECCDJjvyPlsA0fDn?=
 =?us-ascii?Q?MnTR4a/C7XlK5deDF8SrKjl5/BPf2LpcMKx0b594R1ANlCEOektln9j1M0Ho?=
 =?us-ascii?Q?stsxWKys6nUcsN2OIxYsd2o+EiqLXnpmpAeDaS99OqqmcsXuHPiVH5+vFYHL?=
 =?us-ascii?Q?6NFoCqUOQMdM20Ud/Aiv5CrZ8ne8WMdCmbSYSDd8v5MkQYnf3kANn323V+Yb?=
 =?us-ascii?Q?uUQsq78USk49yjtxJOXWiotej51mpyf45GXvqnTkZTmersjyPCkc5MOHobvb?=
 =?us-ascii?Q?WCptT9yyJwE5k0lzBjgfJVHthayQhi8kuUt6VKVs9FknDQrMlM+fkQH+I2YH?=
 =?us-ascii?Q?BfKFuUOFYw3U01dvMstwjMXsINjAZZz/+KuUy6GNoN0gTuH7puum9ESQluVc?=
 =?us-ascii?Q?GU6RgS9Gzbu4WDjcHeP4SBcw0DLgeOQLHHfcjM5myxuy2/xyd5aSryYURem+?=
 =?us-ascii?Q?Eu7a1niBb7YlnQTu+mP8KQSTrDMJ3eG2uquN76b7HP7JPSN57b3RzLIYY+MH?=
 =?us-ascii?Q?GiHwuew8pmHB0t6mJk4yBTx//UsvP43CzvefwJZnLL3hBvxFPinuLnvVBp35?=
 =?us-ascii?Q?Q5gb11Y+i+Ekur6pViS749VISI1d+1DJsHai1tg1Mu56guEMA3/XLiCA5a97?=
 =?us-ascii?Q?anLWpP7IRRpEgsc2wPI7sks29e/WOS+MK9YsepmcrLPOXqEV6dHwKW+mdk4X?=
 =?us-ascii?Q?qI3BcYcD7/shugDJNmnJNcw+ZlPcUNSaEY81mpdcvRqASJkj1tLz832aNcrj?=
 =?us-ascii?Q?Ee7tqkn+Yvy71NMQiqUTVnfEgq2v8FhUX7or?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:29:59.0266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc229e9c-a96a-4f07-e834-08dde62638b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260

---
Changes since v1:
 - PATCH 1 - No change.
 - PTACH 2 - Removed the comment.
 - PATCH 3 - 1. Removed odd spacing.
	     2. Added defines USB_DT_SSP_ISOC_COMP for 0x80 and
	        USB_LANE_SPEED_MANTISSA_GEN2_BY_GEN1 for 2.

---	

Srikanth Chary Chennoju (3):
  usb:gadget:zero: support for super speed plus
  usb: gadget: f_sourcesink support for maxburst for bulk
  usb: gadget: f_sourcesink: Addition of SSP endpoint for ISOC transfers

 drivers/usb/gadget/function/f_sourcesink.c | 32 ++++++++++++++++++++--
 drivers/usb/gadget/function/g_zero.h       |  2 ++
 drivers/usb/gadget/legacy/zero.c           |  2 +-
 include/uapi/linux/usb/ch9.h               |  2 ++
 4 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.25.1


