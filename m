Return-Path: <linux-kernel+bounces-821171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F8FB80A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9C1623163
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02F36999C;
	Wed, 17 Sep 2025 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fWlW7F1+";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="LFx/x3tj"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2EE33B464;
	Wed, 17 Sep 2025 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123464; cv=fail; b=V9IPCVqA7PmTEfevKH7vqn1W1+r6PQDBl8MbWPtA9TrIAmmwH3lYtH15kH5XMljq0OcLNonhTO20z+rJwRuzPtZ70roHvp1BBNRS2T2c/MYLYIBmWb38ilavlNtDLkbFOerPFkz93ZwVVaH8HHJi21QgDe8PkeRpLdMXCq6RKRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123464; c=relaxed/simple;
	bh=9fENK6SNnhV4DAGaNi7Ye8SDSFSJ/NGGImv71zIDeog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWL9zudT9jOs1laX/Verht+injCsZaa65eteZlinU9KQYZOdFBQjFFd0yr9nKJcZSp7rVGFLkA4FPFWlqFs+rIUzj3jt+5ZYGz18+uuo9lLQd6Gl1jfjpBNydAwd+enBDY/vBX/wYJiHQI60HlT0zWtVnnTfegLbDzETsayNbDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fWlW7F1+; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=LFx/x3tj; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58HBDHi92718596;
	Wed, 17 Sep 2025 10:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=gp40NizKm1FM7ylVvmUIRHmLfezg4m3gwW3kPy0zH7s=; b=
	fWlW7F1+QDtvoSt2Fy0hpHjHhZz3bGCSYYc/f4t54DPJLkZJvlZV4vQ1c+5adQYB
	3b3a2QBmCeg38InRzpkdG3aj/i7SqWz9eok0vobUA8Rb2xR9kKwN7JNwTSUfMLeo
	cAUFdkZMI7p4/ZNorZ3cz1s1mSU8zin8wlQ56OBKI0JZUMqPrmt4Knw8silyf7g+
	8igKLNG7wbJuc0bYSoKuYbF2+V2/PWd4w3uqI0XSnDVaKlMpQSI+CuT7PWO+T6Eh
	lVx/IR75rrlorrnJGzB7N5cF4f7yw2kKhWmyC+zAiDcZGk6744H22SPQBcUrgzDC
	repfK+uPqfCF/u6rIGw0/w==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2133.outbound.protection.outlook.com [40.107.244.133])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 497fyks976-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 10:37:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkN+bXm5qMY3jKrllXAOVu4bOIA9rGR3F3iiJTtH2PDaSZXFcCcWFCNC871pgKGPy0INiodzSgLhskfqPZIISz7A87/LAy351wWZscv98GB83jHmx8OJBbM6du7byuh8Lh19d6P2SR86NLRljhFy114dPjhjwf91t4PqcfEOwqs3t7Z8Ae0jMx8JDeSr9LaJ6ve4i/rCuNBasEApP9PmwKjlLmP+c8lsGeoU3GB8zIamSCku8aMDomkJVxZZkuD1vRDndxaGZb7SVMmZnCs3VI+vG3zrHrHnLThbIBjADSkLrobkpLlaxwuuLt4u+QdvGEZLzCc9SbldsB4ll8Tf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp40NizKm1FM7ylVvmUIRHmLfezg4m3gwW3kPy0zH7s=;
 b=Adv4lSFQb/EWP1D1ffRxVVnhe28aAzYCsaQ2BFoBWAcr2rX3R+mA7/Fte5VA9WmVKwg8qNRnWdOasmOzOLK0THriFudRY0IR6dolASvTzEULRl8rZ4mXanU+JFawaRPE6fIR0+PrXcs7xWIgCEaLV4FHpgj68SjaLSEpSBgbX98U3AtvWZaPv4v8AlxHZr+rE9W8kbu6XbOhHOKOLT3jLwv/OwZKhoGeZ2kgWyGtu/3UlINMcWKzbtMwdGNiSwsX2Fg5MZDZc1bY8mJGIPJmY+E6BVS+IuFLKhPs4WQ5ICbYHvuhFLfhux1g38TauT1+9TfU+aBBhtwGSm5CU/UDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp40NizKm1FM7ylVvmUIRHmLfezg4m3gwW3kPy0zH7s=;
 b=LFx/x3tjUeOpCDRvnVJWF/2X8Ol/nWl3LzjH9BU+1xNbbh8oFa1tqcViIyV7p/Ssvm3du1jo5pEhp5smPNSa4dZMiC9IC8J+1iPppCcH3Ei6LQgRbQ7eagPbM+nqvUZuLgOrhpM/XgJLnGYH/G2oUDK9IvA1oIhuz8Y4Jshz57E=
Received: from CH0P221CA0036.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::14)
 by CO1PR19MB4840.namprd19.prod.outlook.com (2603:10b6:303:f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 15:37:35 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::fe) by CH0P221CA0036.outlook.office365.com
 (2603:10b6:610:11d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 15:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Wed, 17 Sep 2025 15:37:32 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 50F1A40654A;
	Wed, 17 Sep 2025 15:37:31 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 182E882024A;
	Wed, 17 Sep 2025 15:37:31 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 2/2] ASoC: cs35l41: Fallback to reading Subsystem ID property if not ACPI
Date: Wed, 17 Sep 2025 16:37:12 +0100
Message-ID: <20250917153722.94978-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917153722.94978-1-sbinding@opensource.cirrus.com>
References: <20250917153722.94978-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|CO1PR19MB4840:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d16b2196-850a-4afa-290d-08ddf6001e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Q1H92xhwJa6dFy8h15cEPUI5oRqq7P1TwwVbFe2zjcHnMvUjymMOhv+/89M?=
 =?us-ascii?Q?XjJ91g2IE5O0YdXKKbiOYzNLWrGoXjeBkLfAFD1gRH0NNpT+2EGlMJfw6EB1?=
 =?us-ascii?Q?fLEoGjWwaeeomm2NsXOZTzE4uR71Ra4baGnNMclZO/VMbkl427h1ytgzoRfF?=
 =?us-ascii?Q?fXGT68kQUZ+dfIhkLwvi//JtNL5v4HZ0xVCe3gabWB5IYy8GudesQ1vYp9Rz?=
 =?us-ascii?Q?9I6+/sbQaY5BfutEkox3Yjz1+WgiyoLfFRX21+N3d2PI/hHfThWMZiT5Zx96?=
 =?us-ascii?Q?e+y7BdOnuNRpGP/Za8AmWqw547IFrMQkKg97dMcwb5FT74Xbki2tMOFl5wPM?=
 =?us-ascii?Q?J2N/Ivk/BYgY0vK7mbVdlSQPm+OzYU54LLtRya7XEyjp9C8vSc8QXcg0YEf+?=
 =?us-ascii?Q?rQgocdnc9K4s6QPlOJ7Fm4xezvEHTcAvG6XLjJDCZZzbr180KEEpUTefSROa?=
 =?us-ascii?Q?hjrOlbLHpaOHb2f7VWleSJOP7YB5r5/elRB7qaWNcNxeruj+iC6IOste8F/i?=
 =?us-ascii?Q?MCj+jUu+ZQlvd5fHQDWIZERFKqKJ0OsLhRoJURiQPGdZU8TD+BdWaz+ZNiWE?=
 =?us-ascii?Q?RMDT4T1gVmWYJxj9n8p84zm5syBdUVMOYcuQF6CXh4fUIR/VaUUdg7EuX0Oi?=
 =?us-ascii?Q?JszDhc9QR1jarcO/ATSBcp1Y2Sfh9ZhTkEe3p/hRrkjPyRXD7TBdV55mAMKw?=
 =?us-ascii?Q?c+331FZQcukPlgsp1H1l3UZ8gWRbdKqK5jis9EjVZC1fy7VRFOVS22XG6IP1?=
 =?us-ascii?Q?eRm6EuMBt1bvE+uykJyvqeur85RbtO0aQ2y4vzcryAv8Dz5X3QLx6mMRydY1?=
 =?us-ascii?Q?VcK4FYm/EqYKzyaIAwwzf7bzI/s+/ksiKMidFNd4jyNXjSTTHcqVndjt/nqi?=
 =?us-ascii?Q?yLuyETivvituYX2XSdiwhYy89bMH+q0ac15EkfuYhTPIhDQz+cNPPvCTOEE4?=
 =?us-ascii?Q?ZN3qjVlpFIfA7mX1ng2pwms2KViPuBHWv9PjdzsFARNnvk32dSRkJdARQh7A?=
 =?us-ascii?Q?5FV+7kmntu+VI22Ft0SLmZ474J5cu8/MJXkfCcTki6NId4GT+wh/pPITQyQu?=
 =?us-ascii?Q?35G7GPYrEp1Omzjn0quXAa1+UsjCVIAjeb1MZRMKa+Uc517jQq2AaPkZ1VMx?=
 =?us-ascii?Q?uZN0d3T6XfjCXYwL+Ad9XGIzMxsTTH82JVVi/mlq+mAhncOthmT4XouPHraK?=
 =?us-ascii?Q?VSENLmEjpj68rLYth53r/GFpssIyjER4K8/qw0AmNc8099A4egULlfcXRqTo?=
 =?us-ascii?Q?duJ2ri+O5T0feGmpC6Seg1PpIMJ4ql7FFQSybsB+VcENicqPoLa7cEHXJuWT?=
 =?us-ascii?Q?VxFBOLrKcwuXKpQJUy3pvSw1x0GxgvctNV5s9lgNmRTRvDd/46X5KNfYeeIA?=
 =?us-ascii?Q?FQCbnqKX0QbcuOxV3V3WkljsWoy6YPVcyUTFOK1UEQnj0acxqdqrhHwlN//I?=
 =?us-ascii?Q?RVqFeKRnySzeZMpC/tpmzB/EiDBpvHUI2zl7Uh4wzrm6oi1RLxuRgLBpmnwI?=
 =?us-ascii?Q?L2KldSIELg2CXt6CKclXMmuoZY6F22HcIAeG?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:37:32.2458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d16b2196-850a-4afa-290d-08ddf6001e45
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB4840
X-Proofpoint-GUID: mtGvai5Gkel9Y0Jfl2j3ipgD3m4ssxVe
X-Proofpoint-ORIG-GUID: mtGvai5Gkel9Y0Jfl2j3ipgD3m4ssxVe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE1MyBTYWx0ZWRfX9jIhZkFisI5S
 WX09EmYuDIRiu/ax6DNw9qznsAonzlEuGCFJObFedyE8Uh6ZlX0toi0T2RTci35Hw9MVmIOOvTg
 cSIB1Cq7QLAEZGlSHDgrvh+UTM1FmtyGy0u1Q2paZlne6c9/8/QSA8LGZFKapLeGeL8XPsOmPHY
 LmGIUsiuaPd1WkOU0glzw3E/EIawY3XqJraH5JfbMqVtGvFx4AzA2z3+y2a7lQnzpIhWPmITu7J
 U1Y5t1rC0152vIuTqJaTY0MxnhV2L6oyNEek920zL0SLQoDDYfVhKyS5h88tkIE75Nizxv8Ufvn
 pXfkZEFXPAv3xnni6Z+ghj+GzZkeQevJeBHBMcO+8YfpeSn/TPcknJQnLNB3Fk=
X-Authority-Analysis: v=2.4 cv=KvRN2XWN c=1 sm=1 tr=0 ts=68cad5c3 cx=c_pps
 a=V+OjpK3aUZD57wWhQcm3pw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=bL0rdlc7CeB77TPmB0MA:9
X-Proofpoint-Spam-Reason: safe

If ACPI is not used, then there is currently no way of reading a
Subsystem ID property used for a system name to uniquely identify
the system in order to load the correct firmware and tuning.
Add a new property which can be read from device tree to be able to set
the system name.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 77 ++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 224d65987a8d..173d7c59b725 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -7,6 +7,7 @@
 // Author: David Rhodes <david.rhodes@cirrus.com>
 
 #include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -1147,45 +1148,55 @@ static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
 	return ret;
 }
 
-#ifdef CONFIG_ACPI
-static int cs35l41_acpi_get_name(struct cs35l41_private *cs35l41)
+static int cs35l41_get_system_name(struct cs35l41_private *cs35l41)
 {
 	struct acpi_device *adev = ACPI_COMPANION(cs35l41->dev);
-	acpi_handle handle = acpi_device_handle(adev);
-	const char *hid;
-	const char *sub;
-
-	/* If there is no acpi_device, there is no ACPI for this system, return 0 */
-	if (!adev)
-		return 0;
+	const char *sub = NULL;
+	const char *tmp;
+	int ret = 0;
 
-	sub = acpi_get_subsystem_id(handle);
-	if (IS_ERR(sub)) {
-		/* If no _SUB, fallback to _HID, otherwise fail */
-		if (PTR_ERR(sub) == -ENODATA) {
-			hid = acpi_device_hid(adev);
-			/* If dummy hid, return 0 and fallback to legacy firmware path */
-			if (!strcmp(hid, "device"))
-				return 0;
-			sub = kstrdup(hid, GFP_KERNEL);
-			if (!sub)
-				sub = ERR_PTR(-ENOMEM);
-
-		} else
-			return PTR_ERR(sub);
+	/* If there is no acpi_device, there is no ACPI for this system, skip checking ACPI */
+	if (adev) {
+		acpi_handle handle = acpi_device_handle(adev);
+
+		sub = acpi_get_subsystem_id(handle);
+		ret = PTR_ERR_OR_ZERO(sub);
+		if (ret) {
+			sub = NULL;
+			/* If no _SUB, fallback to _HID, otherwise fail */
+			if (ret == -ENODATA) {
+				tmp = acpi_device_hid(adev);
+				/* If dummy hid, return 0 and fallback to legacy firmware path */
+				if (!strcmp(tmp, "device")) {
+					ret = 0;
+					goto err;
+				}
+				sub = kstrdup(tmp, GFP_KERNEL);
+				if (!sub) {
+					ret = -ENOMEM;
+					goto err;
+				}
+			}
+		}
+	} else {
+		if (!device_property_read_string(cs35l41->dev, "cirrus,subsystem-id", &tmp)) {
+			sub = kstrdup(tmp, GFP_KERNEL);
+			if (!sub) {
+				ret = -ENOMEM;
+				goto err;
+			}
+		}
 	}
 
-	cs35l41->dsp.system_name = sub;
-	dev_dbg(cs35l41->dev, "Subsystem ID: %s\n", cs35l41->dsp.system_name);
+err:
+	if (sub) {
+		cs35l41->dsp.system_name = sub;
+		dev_info(cs35l41->dev, "Subsystem ID: %s\n", cs35l41->dsp.system_name);
+	} else
+		dev_warn(cs35l41->dev, "Subsystem ID not found\n");
 
-	return 0;
-}
-#else
-static int cs35l41_acpi_get_name(struct cs35l41_private *cs35l41)
-{
-	return 0;
+	return ret;
 }
-#endif /* CONFIG_ACPI */
 
 int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *hw_cfg)
 {
@@ -1317,7 +1328,7 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 		goto err;
 	}
 
-	ret = cs35l41_acpi_get_name(cs35l41);
+	ret = cs35l41_get_system_name(cs35l41);
 	if (ret < 0)
 		goto err;
 
-- 
2.43.0


