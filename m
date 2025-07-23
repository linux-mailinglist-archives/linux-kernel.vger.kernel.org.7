Return-Path: <linux-kernel+bounces-741721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F9CB0E839
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5C07B1FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B530119D88F;
	Wed, 23 Jul 2025 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="us34bLgP"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8288C225D6;
	Wed, 23 Jul 2025 01:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234989; cv=fail; b=QVJPSFsicOxydPz7q++5TgwtNk/QcOFH71HRNNXA6OUU9zrq/ROrM0lfe5bzoevwGzAVy/hvuyzYojYVHCOSaqM20Z8XVmJLAef74PqwAb9tJW22mozNDnXjNhDCfeSmEtFPmsLjbTpgy8MaPcaR282nqm1uDWzs77R99AwCsFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234989; c=relaxed/simple;
	bh=vySU0VPZ+3Afzok7O9MS/K7g2tLZ8P9hWjc+R35E+nk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSDLe3u18K0VDxXYI9tRj4ClAa6/YMLUKTYi261xtOV7S0ZgpRyt6GcZ9X6CvGMeIFz56xh9jiakBA1fUk6HhroCURPow+NLFwKXsXcipY/sG1sPiD7M3r1uuCygNkN6EK6JpLrFWbj4uocZyRNKORpOFI2u3U7jyd8+cXuSGig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=us34bLgP; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giY5qdrIGOF7yHDBYoqwYS6sqHDWBS8zp0Pb/sOgea7e8kbjv2pb3+AQeWYTqdccbBP9ENulTQmfigGlJAwQtE7GzQQ3hbIgQGja1HCx9VVKpjNwHnbbp9v+yqiR2itNy/NPorznqToYOCeZ/ekQIu9jdAETg4PHA5gB/rDIqzrcLoA95MySUtNRlsPhtLqCbHid/gkp+t8qw+hccWLjpqnytSwYntqbCUwbu74smImGC09L/FytJ2DDeoBZqJX++3SETMmF/cknz4DRNIeMMZR2RbJ593pQCR58DSBR71vJVn3WOhvtmBsCsGKdT427IDybP8STwnEQNNUmCE0Www==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTTt7IBir9zBweCwAPFzunv14n6sj9nlz4Pz7qQVOqw=;
 b=x3PnsJCsdNsZ1dpkIcIkO47NwUxw64kqM8O7Fgpk4/9bUS94x/mtBI+ylBTfuBFZUJcM2wnV0k09GFLGQ56XauiYI3P/Fuej39x5NuY1UzxwvdbfP/d5rbd/DPAQ1wOAwujygDdqQ+gBNKfUA4KbVL6IHvkkIrDDnGymHVik41yCSwoJyKcikWfhuWGRZzaAirhMBa/hkV8s/x5OgYzUo7iKaXDRcYcoiEPN4CiwmNJcGp75TZj1iVY7p/QNI4oXRo6H1iFvjTqDGuTbhj0sijB9JOJ6tFIAAVRU5HypWcQcgL+JNxa348+nAjgKQcBZY9z842ADnrn/1EndytzJVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTTt7IBir9zBweCwAPFzunv14n6sj9nlz4Pz7qQVOqw=;
 b=us34bLgPFoCRp0jLOkjV0T1/vy4acGQeax6hIEaB59ihKm57SJvYdsaNHidRNvouFvBIor4LQVvG9Lgr9MYujxdQscC5vMUazOankv1m4mD+oX4UT4M1YXpq+awO8Qv3pLGE/vXl2+CLPW3yHNRImW1r4tv24aRu6wPL9HlzuM+W6jOTANyolCWt/QjBuCPOhqTm9400F5EzoOBQdaSro64ICNt86Du/2QdAk4JB+F0lDVBTZcbUHhJo8/Wm9Q6y2/KmAd5DKL/T8kf0UmrsNfXhdA34X5qi/nQs50CWUhlKNiEqOz/N4q4N6JCci6UEWVGIj3GhOg1mib0a9cg4Cw==
Received: from CH2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:610:50::27)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 23 Jul
 2025 01:43:03 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:610:50:cafe::ee) by CH2PR16CA0017.outlook.office365.com
 (2603:10b6:610:50::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Wed,
 23 Jul 2025 01:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 01:43:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 18:42:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Jul
 2025 18:42:42 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 22 Jul 2025 18:42:41 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Donald
 Shannon" <donalds@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v6 1/2] dt-bindings: arm: aspeed: Add NVIDIA GB200-UT3.0b  board
Date: Tue, 22 Jul 2025 18:42:38 -0700
Message-ID: <20250723014239.22667-2-donalds@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723014239.22667-1-donalds@nvidia.com>
References: <20250723014239.22667-1-donalds@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: af043bba-5cd7-4290-9675-08ddc98a4379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uAaV1fgMH9mhZ+Y88lN8BFrtTLmK90NxOS/3qO8jnhJ1x9ZCQisNKkbNqqqF?=
 =?us-ascii?Q?6toP7D2ze/2iMvlP7rWbkhBiL2uxtOuUT8/p8ly5U7X8YrJfF+1Rg6lVNf34?=
 =?us-ascii?Q?82bSoem4Mm2EhYSSvBsiw+dl5fpBxVxTZKcb4bRxnloYjj/0ublIGF9jQDJc?=
 =?us-ascii?Q?zuquPu9L/dlM0RpBdMpgxNCMGNngzXS/fzrJ318B4CbolNXGL59qSxp7Zq9c?=
 =?us-ascii?Q?329kXGDWZzqLjorDEMLWv7u34CyzmSErHachS1Kf2hp2F7eBlvimp8iYRBHR?=
 =?us-ascii?Q?e2Ow7jU6H/y9CwP2YPrSMy0Ri+AsNCbS/LQzmeb4vz8kWNPIj5gbYAapnX58?=
 =?us-ascii?Q?HQYyQ7fDLuzwLa4dW4PCjCu+/JUrVVXeDuscKOYS1XtA9zjOQEKruZrn01W2?=
 =?us-ascii?Q?4vtEWlUFcVxY6hxIkupZW76btfc2sSaf//ztVdgfX9DOlf9nNdz3W6HDlyr6?=
 =?us-ascii?Q?luZMR1yge1CXPhy7a6owJ0l2VIHWfNnWJzzT7gjMYtmr5nKAPyDp0kqzputo?=
 =?us-ascii?Q?gXZxWXBHG8p+53Y84pdS+D73PaDndTu430xRfcr4E5+8f88HzOYzIwOf/Lqb?=
 =?us-ascii?Q?kue95IVCIBWzkU/T+HP7jXBGEVsccXAXlxjqHUSPM9EozmIVIwBfTKO4l7Lw?=
 =?us-ascii?Q?YdEW2C5HpkwJ1xWfU0h1oU/QCVZtXfSTSGmfI5qomRRoXWUw6CDNS+ZZ6xt+?=
 =?us-ascii?Q?tawh1/aJ1DWF9hKQAfMs9MHFG0nSRTIaMT9Ga5cMwPMDyRPTQPowCj9e6nIX?=
 =?us-ascii?Q?KgCqZDxkyTs4BE3KOu0+Uf8shV1DP614ISi5VV6KD7K0kdIcupG12GzMRClA?=
 =?us-ascii?Q?HrMrP9s3H2d3Y50CYjVdpFo4DdDRUK992kRTfmt1t5Kckl+6ctc9NHw2QOLJ?=
 =?us-ascii?Q?FBreg9Bx+FCKeEAlrc/68zyfXLZYvZL5xt/K/dRhcK8Z09Dl4zqsy2ra8fQD?=
 =?us-ascii?Q?1Uh7G862SLyY9pwHm8lxvEPbOCrhEccyVJdjqY6ihcuED8AwowzjcXkAmksU?=
 =?us-ascii?Q?3xiV/dXJezWghuUzdTihjPgatiq6Mtc26VD5wQ5THixz4JenkwJKuoB7Psco?=
 =?us-ascii?Q?AlGFLg4T/Mk+XSg/GLoQ9QZsitMkWPIeRU/18YtmktpRHhLaLQQo2VZW9A3l?=
 =?us-ascii?Q?PKIsd6p/WiBWQR3jEaqqtRvG5FOryHBAgcp7iUZXZvcdi/hrQ2INDszwyDuI?=
 =?us-ascii?Q?2JrMdsdxT5Yw/tqLZemoUl/g7pWBHyY0yI+Dqd7mvbEmwv2osrTCiiCMQhQH?=
 =?us-ascii?Q?B382axmZv61LuAktQArW5B4PiVjMOI6RFJv+qiwuajJEAGzpiJ1rVP+wkj0f?=
 =?us-ascii?Q?PANnl2ISIhdzKqm4lDu+BfEkKmn+DScRXJpUdqqp4Umo4951V46axoIMV25E?=
 =?us-ascii?Q?sax6m6DSEZK9Od4pNsfBGRPer9Dj2a0p2hn1menglfmQ+XghES2QfdT0cpMb?=
 =?us-ascii?Q?+R3s96pOXDoQKomHNtjxPK0I/xhUeNJGWI++WEsk8UqGltKCbKAkRLmMX3We?=
 =?us-ascii?Q?AfmCm5ujHn+1g8pWEir/m8gjiO/0KZTlaoNo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 01:43:03.0093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af043bba-5cd7-4290-9675-08ddc98a4379
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776

This is an Aspeed AST2600 based unit testing platform for GB200.
UT3.0b is different than nvidia-gb200nvl-bmc due to networking topology
differences, additional gpio expanders, and voltage regulator gating
some devices.

Reference to Ast2600 SOC [1].
Reference to Blackwell GB200NVL Platform [2].

Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
Signed-off-by: Donald Shannon <donalds@nvidia.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 456dbf7b5ec8..624581db2330 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -99,6 +99,7 @@ properties:
               - inventec,starscream-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
+              - nvidia,gb200-ut30b
               - nvidia,gb200nvl-bmc
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
-- 
2.43.0


