Return-Path: <linux-kernel+bounces-813740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A11B54A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4479246464D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFC62FD7B3;
	Fri, 12 Sep 2025 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="W/sj3sNr";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="fxVYywmX"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF861A41;
	Fri, 12 Sep 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674015; cv=fail; b=sJKFRQ82ssIfNqsWw57FBNJI+7b1vGWLz3U/YXAfHzUHatfmBUPNn7pePEkeeNKWWbUAJaVE2ylWu6ZAjRrRg6x5HfbZlmZdbyZ+mp2hnbOPeGX4KO10wiTBdTrLyKjDDf1qKy2xObp8dJHSlXp+brPPRn60HcZ23NDmPlmAbEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674015; c=relaxed/simple;
	bh=Z71A7T/4k+ANYtestCIMmxwBFPXXayN8iWUZfgC9u3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDsnYR7KFMyFzfgIjzA8eYBTHIJS+7xojSclTeNvIhGK0FZfCXbBt3iKcDrccAyoTP7S+WSOSKYPDNNOOvmiR6Q6VNDD5/bvXp+0AvxlvRSRF+s4DjqOq8Hm3vsQowfwcmBDw+4Pp0RVNiMu+OQIgiUsbdzMxhrCmCppv0h3rOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=W/sj3sNr; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=fxVYywmX; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58C4oDu41137784;
	Fri, 12 Sep 2025 05:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=FKoDupw6iAZh+442GD4UOmv+03loFRrD7e6ENv+GptU=; b=
	W/sj3sNriH2p09lx6WV43YAEjuT2qdR3efW0DCOAgneHq5bj5FWEURuig/YJuZWN
	n4MHkUXV7W6KHRZT2u8C7apQynSYBxMACyjKeAdzxZitQcpc/1fgFeW13mKir56f
	LgKmKzQlW9fpr91QC85o265Tomi8521ucPDg17KJ2HK7yuQn+jIYcOva6fdRXsa8
	d5zJc23sB5o2HSN4uDqywesYQLsYrywnSaWV3qUNHFUzlQzIp6Fw2yf41UnKAB0d
	FuRgNXPB54Bl20lb+QgG4Ap8D7Ov/+BYLj+/dR49xpD7pTVjqypOGmn43kXLk7/H
	Sy9FW3ZQt7oCie+yZkBZBA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2123.outbound.protection.outlook.com [40.107.220.123])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 492q6tcpv4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 05:46:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dI9kiJ11Fz2NOrxKbqn/OWFyXk4GMTHpCtHBq6ejoxTjmsyQ8YJrt3ZPtrzkao1i368Zex1DmzMz/MrjhqntOOVutIbu9VdqIKkXmlSrBuwvGXwmb9Wzn9O/ZrXxV+d8YicrteCyMhksqekJnQ/lmX/M9KVxx8sq7eRKsEzFFEVpAEn6oBfGlgO6PxK6OsHukFWB63tKCMmg8LL1Kvav4iIsyb8Wv5hU09AgRzlpDDoNbAqzNPlZfzCFIiUGisIm/sGuKqGjozLG1OfkRIvBR0YzMTSHWbWXksJniFsQZgYB+YAbRXi7d/JYN7eFMYOdRWguap4oG1taq00DzT3VNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKoDupw6iAZh+442GD4UOmv+03loFRrD7e6ENv+GptU=;
 b=kJHIsbFpHXOBKB90Yds9sfV4JkdqWh7k2ne0RltOK5tmySgELrmAIJljo8rvd266u4X1sNcZtxjeXPGjJYhreObNstzurquw3SKmQ5UydxD0jovMveiP+WyZ5C0oh7l4OPIRubaY1rmn1suS/7UobPahtsMTYnaFFOXVPXRYthanwuSks7076jksoaMgbrEdnZEikLMarGe+7ZkmtIePiCPiE9hzIlXXDIErkY2qWFqsZ/NMxEqjCfW8fIucFIyadTwIsKRhrUdL3ANbwJTkgkEyiw/zTahmMTTUodNJcz4k1AAprRYVJDOatu14uSxG2O106v2Uha1pYeT8NA9L1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKoDupw6iAZh+442GD4UOmv+03loFRrD7e6ENv+GptU=;
 b=fxVYywmXPhYMWIwMy4AO9TXxV+6y72a3dz3M6/ZvV9FkKD3vi56YCl9wpXHeRsuEq5L8JE5HfN3GhPVsi4L6mxlSTRPObFfj/0zK/1lhKvwd04bLQeCzqxYeQq2e5O2vm+ZnShHoL59kdevyUIhya1CC/nkuWcC9ScVEqh2wGoQ=
Received: from BN9PR03CA0945.namprd03.prod.outlook.com (2603:10b6:408:108::20)
 by BLAPR19MB4418.namprd19.prod.outlook.com (2603:10b6:208:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:46:47 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:108:cafe::82) by BN9PR03CA0945.outlook.office365.com
 (2603:10b6:408:108::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Fri,
 12 Sep 2025 10:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Fri, 12 Sep 2025 10:46:46 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C52B2406545;
	Fri, 12 Sep 2025 10:46:45 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 8AFBE82024A;
	Fri, 12 Sep 2025 10:46:45 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 2/2] ASoC: cs35l41: Fallback to reading Subsystem ID property if not ACPI
Date: Fri, 12 Sep 2025 11:45:38 +0100
Message-ID: <20250912104612.361125-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912104612.361125-1-sbinding@opensource.cirrus.com>
References: <20250912104612.361125-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|BLAPR19MB4418:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 93cbb022-b0bd-4011-030f-08ddf1e9abfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wrpqDPrsutw1QbvtqR+tYK2eGpDE6tH0zndMn8J8JkCMlXR6KDG7l84oLEve?=
 =?us-ascii?Q?/CyUTQnzecbUiOq5Z+R6zMp60WZQz2Qk7wV7ya1qli6p3fJxfMDTmfO2ByCo?=
 =?us-ascii?Q?VBgeuVGMZXdg3KytmA50XMrJPZHgPDy6tY6QjOBZV4o58gbCxwUFghzWPsh6?=
 =?us-ascii?Q?cK9YuRSVEMewiHrH78K1vVZ+fLlSkzr6JhnwK7umryLwfWSP9GY9wj2n8soJ?=
 =?us-ascii?Q?vfikNhukrxRBHmUOrP7uZzGrkAemQVXdu5TxWtIz+lti0MMRUf+xHZL8ue+E?=
 =?us-ascii?Q?oZ/gecV2gI2RhiMRkwtGFtmyY4K+eECygYUzXSYIw9ZGXBTAszLUDkjoLRsd?=
 =?us-ascii?Q?bdwfFIe6pt3OEwTKi7C9Uk9dDu6TLdcq8wNfpbzKSnvKfVsIrUkLO1YCJG+C?=
 =?us-ascii?Q?1vUHPkUZ3VDRZzQO6cBgTsUcZQViSPxAO5OGb87GXi6XFGvi6JKopD14zaeo?=
 =?us-ascii?Q?ONnR3gP0rfsQLnPyPDqjD40S/A9Reoj08cIpccfgskfhggD9xR+Ec2YpdIu6?=
 =?us-ascii?Q?akMotlFl+eAhVTuYIet9xI47MBGnOvkL/f3mAOpxc/WY5MrePmypxoVc5JjS?=
 =?us-ascii?Q?N7lMFZbifVpZqcGobQAtqg0EdS6R748560OCpFcfeG/G63T/LbwZ7foT1u+V?=
 =?us-ascii?Q?AsOdY87psoGWZ4ymuGkVtcigRNipO79uEMjdNYDEtWimXC9VAAnWa0cRqgkH?=
 =?us-ascii?Q?ZcXVwWt5RPGYUFBqUFM7644oh4wdIpByg7ByT8TlYVGm9VHfQ6gZX3U2n2Gb?=
 =?us-ascii?Q?LJ3nsLCcp9JBIoZEriBzIFGHPGSBN1OeqDCrioHMLwB5u41BWKLfbJHh5eR2?=
 =?us-ascii?Q?50n/edMzsUvonqvHF/mr+UiAM/2Sz+gASOn+aCEVz2Y5W1xRDftjd2eCv/bG?=
 =?us-ascii?Q?Es6TDXewp9re+oRKXOJrGbrpDie98n+dvsqaKWHyWhTaPBdrGTChsKl154BQ?=
 =?us-ascii?Q?pZU1AjsMfHBjwe1nxhkSmMC29Sno70SnuRBEGqfvzGLbaBaSRxKloURVzgtA?=
 =?us-ascii?Q?17XSLxtkzY8/iNs8JQRSq+NfoQFXQMpm01/aQlGyMpIoP/cOB2sqbWzmw1eq?=
 =?us-ascii?Q?gTUy3LgTG2fDDEWwwWH+PYO85wjaM/nUIQw6P84ttv5IfqPkp5NkHLhF2VdZ?=
 =?us-ascii?Q?OLeLNgYoQcxd6mRDqoEBEZvuyGj1Vs0FyaocTTtrh0duLBZ4eFAasYC3jbRA?=
 =?us-ascii?Q?7ljQ1LLtk04MuNeWZUIUvA+BbueijhvUO/IZw4WfWQ/G4geepM9mQoYpBC15?=
 =?us-ascii?Q?cgGsJqhaxoFngEeAG3DJQTfBnxaiWxaX0KV9SCA4nxQ/8vCLWC0bEV+lwu9I?=
 =?us-ascii?Q?sZvb8LHfaEU+oO6/WnAwrPsgHbXxBw2DY3O77oPZ66LwzDAtgCNFFgCi//+T?=
 =?us-ascii?Q?B/UNeDK5JrR6nXsG/Hnqq6TgQvDzxzDFD4QjsucrQnhEkA8kqNWaPJomLxJP?=
 =?us-ascii?Q?vCmrYdEt3D/XSVnKF8RsPaNIkasNwg68k+Zets3f5RQggazDP2zp9tqP/Ebd?=
 =?us-ascii?Q?FmYkvqj+gsYvqcqajwfPkRABxah3RnmCgc+Q?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:46:46.9488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cbb022-b0bd-4011-030f-08ddf1e9abfd
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4418
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDEwMCBTYWx0ZWRfX6oJbhgBuX9yJ
 XHh+I4gsBiOxudtC+YAF1bgvf7j0y80gW1/65/51bt5Lyf9COpxxYIYAoJp18V/nJk6TAMxzYNh
 ydhJFrH7yCxwbp4t34iO6G5MDXimkj0XhBKsOIKu2We4NNh005QRok68ceBrN2njhahgKdg4ABM
 7N0CMhSkM5OxG9m+ZiRIPxROjtTVswH1oT8EZhtw1h1d1GaIXL7/J3dkWIeKziP3a3Ou/kR02LN
 5K69YlAr5Uw7rKaeCopsTf9h1Nu+48aUIp9T2tTUnEydrvzuLVHQQ4VqDSZXooVlb2xPZvMeVkp
 MxaphAPJ+0m659hoyTiqgWv1ECPXowsKY7w9qqa6CDVFc3NUBn5QhclFNLmsQg=
X-Proofpoint-GUID: mdwPVoCwifqwVnhAPp-MxXIO6mLqPFRI
X-Authority-Analysis: v=2.4 cv=X71SKHTe c=1 sm=1 tr=0 ts=68c3fa1b cx=c_pps
 a=f3Kr4HZljxwrsYTGj9vx4g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=bL0rdlc7CeB77TPmB0MA:9
X-Proofpoint-ORIG-GUID: mdwPVoCwifqwVnhAPp-MxXIO6mLqPFRI
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
index 224d65987a8d..d7e3d89de652 100644
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
+		ret = PTR_ERR(sub);
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


