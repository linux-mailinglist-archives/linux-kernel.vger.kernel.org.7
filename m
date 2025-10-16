Return-Path: <linux-kernel+bounces-856643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EF6BE4ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258EB48637C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EC33431FD;
	Thu, 16 Oct 2025 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="oybEVr5F";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="cO5zjPWs"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D330F95C;
	Thu, 16 Oct 2025 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633358; cv=fail; b=K+Ey/AZzWZwDF4mFliKyvfktnKyMXPOzdat0baBXwTiXBUDkxUCgsO//+KUfnptijznP5Vbk1yXi6bSiBaNi85VZ3qZcdHcae5Ehp60hADDc4bSXDkQoF7XKhXWLN9EG2F+l7cYNGLUZRjT/VectnYZE45yn9lsNrNGqCJUYAx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633358; c=relaxed/simple;
	bh=QfzAbrZ7QP7zm+iYfmvYX+uXRJkeIsEL0rpxVlVTVW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lm8K4GB16dVjtkF/LuJQbTkd/ZSz73AGWKFmSz17dpjY+ufLUP2EJ6mrx/SfvQQE+3di22CjiFFLEELlmAvdQTnTg/t9D6iiUjkpZ8VflrfiXwgDAZHiq5DxPz06m1rwwtfykRAGWoljCUey1192EDinsT23D7IQg2uwRgZc8z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=oybEVr5F; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=cO5zjPWs; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDTFSp4017904;
	Thu, 16 Oct 2025 11:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=efLGpdUsijDroiFjFKocPw+52LoKKBoglMzHJWAmAaU=; b=
	oybEVr5FRvjh0NFsSROwhMB8cD9inSJon93SOGFDIJ81Ya2eE2GeC53mCQ+1NvGE
	HAWj2LkWVT0YYh1zsGEoKI/8O7JhJUXRAZWn5P+yllwa9fJZFnC3rRmQaWkZHRpQ
	KwIv6Plw8/8gkI/9THxMzaH7SOceaE84HMhn+T3uOTxyT7dPCQw4Dzjl77Onfnwb
	6ABA8WYBpq2qKu7/4iEQHtX3Yo939o7vzkQVRJSKApqdc2vSDXEYVOaIOPkTpPBi
	n6jakjqNhO+Fk4HA12GSbV1ojUjHliNuxmP/Nru05QCVWYzfRBGc/6AQAlCxg8Le
	FoAN47yPYGwQHblTRRlzhg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023099.outbound.protection.outlook.com [40.93.196.99])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mngajw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:49:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOY8p7f3E2IrWqp36ut6wkM9d7j2jczHZBcnROMqGfBqKFsUFNmsaI24ot6MrgVnYnIXPdbv1yF/0TjGSN4V7z9KkNEy71qklmtzsgvHJyuXWAh3Q7Zpsp0vvinVgtb9Nqdn69bm/WCtcWFZIt66vqkvTA96j5diJVqVVcmxrrP0Y0eXSKYZM1TJfQKvAO+JJQ5PU3RlWsoW5qt6EOjaNmQ+JAhUY/SmSl4FkT0q3VwLtitluhcmeqSCdmpqMf60Gd3WI8iF4kGR5bdY+D3i44Os++AAQU8rnATclk5NlQ5EfLJaP8dByUOsHX/Dn5BDungfqZilifmBKkWht4wWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efLGpdUsijDroiFjFKocPw+52LoKKBoglMzHJWAmAaU=;
 b=ZUP2HQTvRzf3xgUPEYCVf0xQrNbfUUvdcfMCUHWRPD7N0MF4INEpMLaXF0/u3i6Xl82FfqxdHVbjubPB8r/MjN12IjTBgPy/VLUeaFvsCNMvl1hRFKGHxDJ3A9fsRbukR2XJJPxjZeJxyxXGXPsNOKf3YNlo53glu5W7GfJ0WiinajOEBK5VK2WUVeBQmKxOeOhu88mlGZKDERvsFFXMKaZZtUTd8welu3Oh8XSKmnbdKjEib6GRiEulrKbjurWMDVPdR4kaIKVGEWeNrTr/AF+HwiAHwSTqhZbmmzzFazr1YWToocnRmJwd6FaJrnS2OAuGHLP27cfeNlu7DdaFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efLGpdUsijDroiFjFKocPw+52LoKKBoglMzHJWAmAaU=;
 b=cO5zjPWsd9XQCfJ8RxcoOleSGjjlJ82PJKU7HdeBaZN3yxz9ajmPVSk5ur2OPVsPiF9RlqLgg658RahmSFWtq2IhzkFl43lJ3XdA8BEGTG6eeeunKFhYy8LXPtKZqBjIfqLX6T0Ywy9Mko2nBG6yf3iOuKuTaxIoZ2FtdSTpjag=
Received: from PH8PR07CA0040.namprd07.prod.outlook.com (2603:10b6:510:2cf::26)
 by IA0PPF6A1766D3D.namprd19.prod.outlook.com (2603:10b6:20f:fc04::cac) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 16:49:01 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::b3) by PH8PR07CA0040.outlook.office365.com
 (2603:10b6:510:2cf::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 16:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:49:00 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 473F5406552;
	Thu, 16 Oct 2025 16:48:59 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E62AA820249;
	Thu, 16 Oct 2025 16:48:58 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v2 02/11] ASoC: cs530x: Update the copyright headers
Date: Thu, 16 Oct 2025 17:48:20 +0100
Message-ID: <20251016164847.138826-3-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
References: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|IA0PPF6A1766D3D:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: da71f852-3a04-4208-2f50-08de0cd3e84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DwAyJ22QQFrXUcgXqr3dKYWBOScMKdPidFS0l7WjDnf2515fmKymwRRLUs/w?=
 =?us-ascii?Q?LJLnLKxrqkqfhkAYulzVmCKJYwAJCDz28+b4Wr2WLYoTQuKhLD+dpWOMlHbB?=
 =?us-ascii?Q?wzAYhr6Nd1Iu7Q7kgEibKYcaBnvOnzbsKncbLogydimP0wRIYWUtBVFuHakb?=
 =?us-ascii?Q?b6sMbhudBLXW9zCi83AU5aAxcOqXVFe8vvLhnopRCMGShnECHdO1TN2eXwJW?=
 =?us-ascii?Q?OdUsoUX+MOcQeFM75hIVyYImmTEe8goc1LN9VR4SRNTbRdMu+3iIE/P4Nr5s?=
 =?us-ascii?Q?afOg2dJH4XifeEQQpWtRI7RJHGoFcidVRcBhcHVxoroJ1xAlu+pzZUHbgJ9O?=
 =?us-ascii?Q?cjXV3fTDZBPIObGyLI6yg8f8j8TlJMDVBXKzZHAjCJS/kl/InobNc7v4pS11?=
 =?us-ascii?Q?JhinAYg8cOgiJ1HOBBBUaRCJw9FicfGD8ZQP6cNiAjohkiv4wWRxBnBgsfj9?=
 =?us-ascii?Q?o254y5fRcN0N9EavzGdz3P2RBB+t8kdxN530KZ5KYfcmBdjp6r7uYCWasTPH?=
 =?us-ascii?Q?oQkIeAEd6JLAx/HGz6M5LraqYzcjp2GnyYUyb2yF8OQG3IwF0cMTZuJDwKZR?=
 =?us-ascii?Q?5IEcDk+1HGEBDwCM8net3hEO2h3H7HGNVrPIaukXuUQZx/81kwZuOOpqd19g?=
 =?us-ascii?Q?nl7UI5+fpEqS1Qmrv687X2kJLTEt4jZNXu65fdFqggSUSKItxOpZLVoYZrix?=
 =?us-ascii?Q?/noj52Lx7UvUfDZxVd4cOySi0Cn9I3jDpEWPQGxI/ZAxgAsdXK8JCXSEsxsH?=
 =?us-ascii?Q?5TykrMhJJ5eSTXLHOU2iV3gEyG5iopK3gPX1SNtmK1WRIlS4X0IyILX7lEbJ?=
 =?us-ascii?Q?HZgM/13fJm+0mlqmA52PREo0QunTUqdcs7eX5pKDV9DdxAspC1eUndkD+j3F?=
 =?us-ascii?Q?8DdPOKKk+mNLjqyfYsN5u1u7Vuqty3agqEpORXDme22VoyhHM0YOCGgPplLX?=
 =?us-ascii?Q?WvNSAs+X+N9glNsFIqjOONp3+YhPd62UhXkTnwkai24kY+YfOVmXRZN18NQk?=
 =?us-ascii?Q?WWhfOQCSvJu0ROXmtrA3YbQAXcnYr7nZjo0DaO7UOArO9rq5YePQ1/WHqgEN?=
 =?us-ascii?Q?oc79nlCOtLX1Ju+mXXrEGF8SKNLFAUe6gT8CA7VRUMqS1RH4dzbMRaszWqVH?=
 =?us-ascii?Q?xTd9oPw3yhM1cB+wNvKi9hFDynQP+U3DhdvbaXDznHko2VIoEVq5hKuX6KDY?=
 =?us-ascii?Q?fOlaqeWSQzBxZOieQASr6Mi/yZkRJckseSf6hGT912cEcAYZaKiXVY4jIwHg?=
 =?us-ascii?Q?KTUK2ElKXIfKEGlLSajkYE2JqkVOqhJ7uLSCQZytoUjLBkQFuQNpr6eJQCnu?=
 =?us-ascii?Q?6wt4PLS3RtiJORcI9nz6DazygEZhboLneCnOgN8ktKkJv2Kyt2AkazmEbYal?=
 =?us-ascii?Q?aK8+L8sTR69KJFyJ8mmPmCs/G6F4pyS9tj8QodpWvAqKOzkoFLBYnwGJWLp2?=
 =?us-ascii?Q?kOCJ6TkgCDhQJoOTtWJZPyAD5DhZ/SJyCvB/FzdF5YNtIDH0OsUyRbUi3mmd?=
 =?us-ascii?Q?CRNGPE9RzDIE6MfG+crQGCZ+5n/tD6QkIUpaVq4VGRLhiVtB1/ldwvtlT2hE?=
 =?us-ascii?Q?0PQyt9AoTeaWkctqqvs=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:49:00.5216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da71f852-3a04-4208-2f50-08de0cd3e84e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6A1766D3D
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f12202 cx=c_pps
 a=iMozJJ0ZMpdRlXWW5uynUA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=SQtk40xCRQeN874b5x4A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: bLYG8ZsYBgi82cxIPNfaM6TQagI-jVdw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMSBTYWx0ZWRfX34TTHLN17Czy
 Ub0nw5QCDWVUaJ/wHxlysHe+RS9zAkTS15gm+lLULDfbwd0+hUtBaF6AgqnxAHFC36qM1FH/3E/
 JRJT4o6m91TJuKk5s/60Y3QyN/oTATBmaqfiPlUQEcGUjWmloi2k3zXh8slLuD58iSjWSOVzARs
 CT8rupkMr9N1eTPV8DDFtj0gpjAZDSgUxunjZbELD6RWxtdkhvP80vRveUCMrrn6NbrrTVKsTWJ
 yItTFiEvMIv5BYWemxRZ3lbjMl6fqJIzSlQWuwhPw/KiL61gxugD84GRl9+CDH52JG3xWQ69rsB
 1qDFiwpg757jGz+Mf9E/OJoodTLrKDfvas+R8JsZvCtCURxOsvqWq+ewvHtkoBxiVAlO92Lshma
 +JNPUoEBQ/3aCMbM0XYJ+iBwCADEYg==
X-Proofpoint-GUID: bLYG8ZsYBgi82cxIPNfaM6TQagI-jVdw
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x-i2c.c | 4 ++--
 sound/soc/codecs/cs530x.c     | 4 ++--
 sound/soc/codecs/cs530x.h     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs530x-i2c.c b/sound/soc/codecs/cs530x-i2c.c
index 22b1a4d6b61c..be80dcad3647 100644
--- a/sound/soc/codecs/cs530x-i2c.c
+++ b/sound/soc/codecs/cs530x-i2c.c
@@ -2,8 +2,8 @@
 //
 // CS530x CODEC driver
 //
-// Copyright (C) 2024 Cirrus Logic, Inc. and
-//                    Cirrus Logic International Semiconductor Ltd.
+// Copyright (C) 2024-2025 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
 
 #include <linux/device.h>
 #include <linux/module.h>
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 535387cd7aa3..d016e8298a69 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -2,8 +2,8 @@
 //
 // CS530x CODEC driver
 //
-// Copyright (C) 2024 Cirrus Logic, Inc. and
-//                    Cirrus Logic International Semiconductor Ltd.
+// Copyright (C) 2024-2025 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
 
 #include <sound/core.h>
 #include <linux/delay.h>
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index f473e33eb835..b325847036e9 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -2,7 +2,7 @@
 /*
  * CS530x CODEC driver internal data
  *
- * Copyright (C) 2023-2024 Cirrus Logic, Inc. and
+ * Copyright (C) 2023-2025 Cirrus Logic, Inc. and
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
-- 
2.43.0


