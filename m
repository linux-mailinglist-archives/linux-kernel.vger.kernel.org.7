Return-Path: <linux-kernel+bounces-808008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6A3B4AC0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B141B24559
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB21322DC9;
	Tue,  9 Sep 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WGaJ3Qmw";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="d5Z2oeLJ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC654322C8E;
	Tue,  9 Sep 2025 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417458; cv=fail; b=NdyQ9S1g9GsWZ4d2oJL80AVze/OUSgFNtpcVTws2TrLbpQZJgHdariSvzhsygKK0l50uQz6Kye5PkyhKvNYXDCRdyOfsdnOCRrVtNwB57XvZ+rVif4gq7o3llCMV75QSdweafEHlOJLEKXk/qa10oq3JAwMbbGCFXy3pv3cu45Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417458; c=relaxed/simple;
	bh=wJhnQMsUsI9rAjc0BNjA1XOBKL7QbUrGwXxQp9Iz5Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKfCUe4f/QWz371ZofczBaSmU7vgZdsNTOX/2zCiIlyyCQqikKB76ckF889ZOpzT9r0cx9NUPeGJFzQEN/GvfD5C0nSin+VNto/iNdpXsNGm8rO8SlPVobecxjQS1n5vraPXBjRHGe2e2kocybyAd6rW+g6+W7JtFaMC3R+4Hx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WGaJ3Qmw; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=d5Z2oeLJ; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 588KTW2W1253433;
	Tue, 9 Sep 2025 06:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=h4Dfr0hD8yE9FJXgyaN7BRfYnhLiGIoENqRcYFsQiR4=; b=
	WGaJ3QmwjI/anX0aUGQIYpwQcIVtNdhos+lz5ic+i2F/kCGwhS7J/ke285GjADs+
	Fovu+3jfiZQz7TNWupkO7zvDjkk9tm+dAwrUD+uUlcY1Jf0CzgY8SzS3vW6FALD8
	Pt7ArYbbYqkitMwgUm4oMVe+5gJplvUQf57VZbAn4WWrXb9iURmJLrDcYBgKOYKU
	JvukzKv1ZTIzqSY5fSnWMYEblZfFHdjAOHytK4+HoJ333fVLV9pI8t3CnKgxH05m
	JJtE7GA46D6GoOPr8f6k0S5mJe2wr9jvULd6S6kW7deERVAcozZddfDN+zjZr0ps
	Dq97OmJOWo/ucq3Rp5GDQw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2092.outbound.protection.outlook.com [40.107.94.92])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49227r91wv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:30:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4tiH3l1kshLi5l0sjUkD1a/RchNrTh0BHaLcqjdPNvU4aXxznkgUzBY0+hHomPo5qk7A/xATwLk6W51QJLZr546xf9feJLh+Ar1zx6dsu5E5rS/byHhVUa5ZIhUCjh6iasY3+HLpTIdioBv82OHQTss72jsdBM8HbuwzogLt0RvcbHA0GNyg17SO1bpDjD8HQPBzYJ7m1t1yr/k3o/gX4K0fmWXYqOZerpLNFLO9+8M0LG5NS+Q3pRwYxw6AODs8V2mipTCn4bWvqsuxk707de80V3S3QE+4B7i5f7QFEcdrxFxwU7WRaSwX8qICNrK/RDObhXEXfFDbFyxMV2C2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4Dfr0hD8yE9FJXgyaN7BRfYnhLiGIoENqRcYFsQiR4=;
 b=ILhNnBHVNv3IVMesaBtVvCHS9mOU9ZPqpaeih4p+7XJToFnLUO8tnMkmkfZUC40tEt0qfP+ht47VsNMLEpagaWV6MhXc4dch3tm0ZPt7L7UlQ3h5k+xCykPVz5bXXtMYX9d/DucuBMRXibmajhp56ETPExudtlkKs9LI7f95juymLJk+p/p12YTc8IYKmvn+ZgbgNpLSAnI3TwYEGxz5rf8euV75xnPiMNCtGsFbaClniTTKSxTEPwrOdB3BRPsJ4JjzQoOLbBtv3m8Lew24pRMC8kMEURVCvYHJ5ZUGd1c3ANCfJmIQzS161JCsfTHtydJDu9QCRGxDQFL29exOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4Dfr0hD8yE9FJXgyaN7BRfYnhLiGIoENqRcYFsQiR4=;
 b=d5Z2oeLJ83w5qetOmuSGHp+yjFKH361hjkI3NRcDRHqk3dnrcn+LtaKkUjYO08ofFkHDHZVmTao0ejKVHAMUpwyF51IvqqCNkorYv93/8cOvalCzh6tIVO3ZjPLfYX+PhMNcSyiqzz/M47xfQ1HrXvAXV9nbSmj6BqLQ4l2j+j0=
Received: from MW4PR03CA0304.namprd03.prod.outlook.com (2603:10b6:303:dd::9)
 by MN0PR19MB5756.namprd19.prod.outlook.com (2603:10b6:208:377::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:30:46 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::32) by MW4PR03CA0304.outlook.office365.com
 (2603:10b6:303:dd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 11:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Tue, 9 Sep 2025 11:30:44 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 465EF40654F;
	Tue,  9 Sep 2025 11:30:40 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 40332820247;
	Tue,  9 Sep 2025 11:30:40 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 5/6] ASoC: cs-amp-lib: Add HP-specific EFI variable for calibration data
Date: Tue,  9 Sep 2025 12:30:38 +0100
Message-Id: <20250909113039.922065-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250909113039.922065-1-rf@opensource.cirrus.com>
References: <20250909113039.922065-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|MN0PR19MB5756:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 04317a88-1fc1-4db4-c7e8-08ddef9450fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wM4Vuhyn42SW8RI/iC5xc+mFosWrP8kcfxN9XDC8VeY6ID4HKLZwBbEcCuZB?=
 =?us-ascii?Q?LcMbPk/QtmiuGAjGiyB/Cw7jhj/ttt/W1e4LnDmNz0z6HXFQJSsKrM1UJ8Mk?=
 =?us-ascii?Q?m70QfgSGd0krE8VxYZRklfxefDwlTPUbNDrcW/Al4X5FW9VdHyi3mSSwLXek?=
 =?us-ascii?Q?PbaeYXWXtQ5CaY15XntWS1rqWPLZ/BDGR6osxOIGs15eKSu3ahZ7UqGNXrIa?=
 =?us-ascii?Q?uI7dzd4WRGUIdOTbLEUo3fW4+Vk4bMT4bQgzY8rK6TLbz5qrt5ZzxTmmN9tx?=
 =?us-ascii?Q?7cQ+CIMUThkEHgxCQxFfDQGZwQM3PX6pCZh7EOsQZGKaBB1pfZ2Z4Lx7OBHD?=
 =?us-ascii?Q?bDnRy+jBxqijh87wbWUcs+4fMjGl21Sj1nkycik2CdTco6V3JnCNSukO32ui?=
 =?us-ascii?Q?3czyJJWpf0mnjsKE0gVTqUMpC3FWa3ZerpQQGXglJp/6pHDe/bptPZSFE/J/?=
 =?us-ascii?Q?+2F5k5HgqvcPlEOC6eXIQh6RzX71jD+6hW7Nhk0fkSPGjJhr1VCFrK4PZ7+V?=
 =?us-ascii?Q?3I31Bhf4jf2GHixSyrdmC7YPLEFRP0iIazzRqiSN/AEGQHXrrn0HSp/696CZ?=
 =?us-ascii?Q?/pMLKpMMyUPYSjpikpZErQsZ2l1pr66J+AVP8qkLZRqxknvEAS5pvgF6MDif?=
 =?us-ascii?Q?0pQ7wr7Z6Np1LiybH2nAXsSrplzO2HhJ2AVoFwff1Rp9mO9kXk13TLjFk3Pb?=
 =?us-ascii?Q?Jh7/iz0ZcQ1+weAwo8nw2QKBCqwtJq5nTFxG63mLCPVgi2cvh+qwjU6PHBS8?=
 =?us-ascii?Q?caBR+QJES9UX0RrMR1PLboO7Z8CrxDxdLjF+aeFinHHO8ndNa2uc0ZxghfAz?=
 =?us-ascii?Q?mktRibDyqHu7UI3kuoQ4kJib7W+mmAdW77WGehPK+IAY671P5huUN/NidBlj?=
 =?us-ascii?Q?Pe4QM7PDc9bnxckYzpUwPM9wUoXX/YnpP17d+9lDQx8aPO5g7T/aiYEK5QqZ?=
 =?us-ascii?Q?iXf9uCWXb9bvvjoLFs1MFFJvUGYL5x51RbJBCANLdj/u7fSyKeQwmc7G5dtN?=
 =?us-ascii?Q?8hqap+f+gY7BDjjCl+MxdR/hoaYNlPQIOAOoy9tgsQlNPY3ak6H56uhMZac1?=
 =?us-ascii?Q?W6VNif+YlnMhrCqPT+yY0a3ynGGylVbumgKVDrSpnXjzf4+EKZmXue2dy3cL?=
 =?us-ascii?Q?qjm08V1DwHxLjrxh02bOkFPJCGNgawAmQ0wPmOkXsds2+Tr0JuYXauI1xP6j?=
 =?us-ascii?Q?rXgQMyIN5KOMrM4Ss/Kishz7mCsrs9WVrEMcj/cENJm7C/e3qy5DlEzd171K?=
 =?us-ascii?Q?Gncp6Wx6oW5VCO4CGy6mpRI07EeVb7GOtu6X80YpfVFDDLsXCWsqDw1gZnRU?=
 =?us-ascii?Q?JtWiGLijqqmTFmDGYfTM9e+TVTm7wDuJ4Igq5HaVBMU2ei33vvoYJO7rvPkL?=
 =?us-ascii?Q?WGQqqpURuIquqKZzeTPozrBxGVQ54itefjWOj/gAZYCDg40REhDpJeTu019S?=
 =?us-ascii?Q?AjwrO2wkFwOWSBIzdQrVzHDBgS4uqfwnVUHGNIv7KluLR32XFAP56qJMcFjc?=
 =?us-ascii?Q?HbhcmMBN4QY5GXqVH7Q3MUO0K6fzqGTBX7Dd?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:30:44.6326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04317a88-1fc1-4db4-c7e8-08ddef9450fd
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5756
X-Authority-Analysis: v=2.4 cv=f+FIBPyM c=1 sm=1 tr=0 ts=68c00fee cx=c_pps
 a=odStxYl4fA30BBTO3gVnUA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=gujROYcaeV9tRZqipvkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDExNCBTYWx0ZWRfXxqhM+72YUPRY
 F+OR7X+AhJWkIiy2gQ3x/+X23K8KvX5w+2ruEfjcas6+bpFk+7Ql+Y5t8YYo6HoQemIhtTcMcBd
 IbVDSIhN1pF2gxXZ+qaN45MlUvyPOk7BWd1tUmbQgr8g9aR4upn+9a94Qb+oVWUdCmKodwUXn/X
 wownFcs+b5smTjJfZpuWHuzuV+PF0YBsI9998j2itvWDuDZXydUZMoyMmKMb9u9vSkzIbbTXpTz
 HgZcXMkf38gk4VxCEKUeUdw2LVyiiZwcLhp/ARZgVqnmiQMeVzkcgRoEF9I4tlzbkfb788QAg1X
 YbN+fvp8nTtwK/qExuz8NkyPFwa5ZNfTZuDIDjDQsEAKaSwmu2owOYnzyjiuJM=
X-Proofpoint-GUID: -6db9WgYa5wOpHTCQkc7iAlIE4CEH0hc
X-Proofpoint-ORIG-GUID: -6db9WgYa5wOpHTCQkc7iAlIE4CEH0hc
X-Proofpoint-Spam-Reason: safe

Search for an HP-specific EFI variable for calibration before falling
back to the normal Cirrus Logic EFI variable.

Future HP models will use an HP-defined EFI variable for storage of
amp calibration data. The content is the same as the normal Cirrus
Logic EFI variable.

The first step in cs_amp_get_cal_efi_buffer() is to get the size of
the EFI variable, so this has been made a loop that walks through an
array of possible variables.

A small change is needed to the KUnit test, which is included in this
patch. Originally the cs_amp_lib_test_get_efi_variable() hook function
asserted that the passed name and GUID matched the Cirrus Logic EFI
variable. Obviously this will fail because the code now tries the HP
definition first. The function has been changed to return EFI_NOT_FOUND
instead, which emulates the normal behaviour of trying to get the HP
variable on a system that has the Cirrus variable.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs-amp-lib-test.c |  5 ++--
 sound/soc/codecs/cs-amp-lib.c      | 37 ++++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index e7492afa041e..c090498cbf78 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -204,8 +204,9 @@ static efi_status_t cs_amp_lib_test_get_efi_variable(efi_char16_t *name,
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, guid);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, size);
 
-	KUNIT_EXPECT_MEMEQ(test, name, expected_name, sizeof(expected_name));
-	KUNIT_EXPECT_MEMEQ(test, guid, &expected_guid, sizeof(expected_guid));
+	if (memcmp(name, expected_name, sizeof(expected_name)) ||
+	    efi_guidcmp(*guid, expected_guid))
+		return -EFI_NOT_FOUND;
 
 	if (!buf) {
 		*size = priv->cal_blob->size;
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index 9b51d056d863..8434d5196107 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -28,6 +28,24 @@
 #define HP_SPEAKER_ID_EFI_GUID \
 	EFI_GUID(0xc49593a4, 0xd099, 0x419b, 0xa2, 0xc3, 0x67, 0xe9, 0x80, 0xe6, 0x1d, 0x1e)
 
+#define HP_CALIBRATION_EFI_NAME L"SmartAmpCalibrationData"
+#define HP_CALIBRATION_EFI_GUID \
+	EFI_GUID(0x53559579, 0x8753, 0x4f5c, 0x91, 0x30, 0xe8, 0x2a, 0xcf, 0xb8, 0xd8, 0x93)
+
+static const struct cs_amp_lib_cal_efivar {
+	efi_char16_t *name;
+	efi_guid_t *guid;
+} cs_amp_lib_cal_efivars[] = {
+	{
+		.name = HP_CALIBRATION_EFI_NAME,
+		.guid = &HP_CALIBRATION_EFI_GUID,
+	},
+	{
+		.name = CIRRUS_LOGIC_CALIBRATION_EFI_NAME,
+		.guid = &CIRRUS_LOGIC_CALIBRATION_EFI_GUID,
+	},
+};
+
 static int cs_amp_write_cal_coeff(struct cs_dsp *dsp,
 				  const struct cirrus_amp_cal_controls *controls,
 				  const char *ctl_name, u32 val)
@@ -146,12 +164,17 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 	unsigned long data_size = 0;
 	u8 *data;
 	efi_status_t status;
-	int ret;
+	int i, ret;
+
+	/* Find EFI variable and get size */
+	for (i = 0; i < ARRAY_SIZE(cs_amp_lib_cal_efivars); i++) {
+		status = cs_amp_get_efi_variable(cs_amp_lib_cal_efivars[i].name,
+						 cs_amp_lib_cal_efivars[i].guid,
+						 &data_size, NULL);
+		if (status == EFI_BUFFER_TOO_SMALL)
+			break;
+	}
 
-	/* Get real size of UEFI variable */
-	status = cs_amp_get_efi_variable(CIRRUS_LOGIC_CALIBRATION_EFI_NAME,
-					 &CIRRUS_LOGIC_CALIBRATION_EFI_GUID,
-					 &data_size, NULL);
 	if (status != EFI_BUFFER_TOO_SMALL)
 		return ERR_PTR(-ENOENT);
 
@@ -165,8 +188,8 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 	if (!data)
 		return ERR_PTR(-ENOMEM);
 
-	status = cs_amp_get_efi_variable(CIRRUS_LOGIC_CALIBRATION_EFI_NAME,
-					 &CIRRUS_LOGIC_CALIBRATION_EFI_GUID,
+	status = cs_amp_get_efi_variable(cs_amp_lib_cal_efivars[i].name,
+					 cs_amp_lib_cal_efivars[i].guid,
 					 &data_size, data);
 	if (status != EFI_SUCCESS) {
 		ret = -EINVAL;
-- 
2.39.5


