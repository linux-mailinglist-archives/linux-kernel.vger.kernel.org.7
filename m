Return-Path: <linux-kernel+bounces-777924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4211B2DF34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07AF9581B15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5E82C21F3;
	Wed, 20 Aug 2025 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="e6FLPsV9";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Ujz3a1ZI"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A93A2741AC;
	Wed, 20 Aug 2025 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699766; cv=fail; b=N5mK1liFkaZAa7yTpDPxa4VkNcj0Xafoff9BnlFMgOosb5cwXfeFZqri3YdD/jHItlhtXB6GSIyzKw1SA+bzmF5iq0c51gVocVwgyuaSjaTJo+k11yc18EQZlRsSk7TLJ/Wz0Ll9McM0ojrfQN7KbjYdWN0btptwf/hqMG48lFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699766; c=relaxed/simple;
	bh=1aF04LqeDYhade4IlSElf4Kbs6qc2PrKpWaN4Ufv+Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G72BqehKRgI+jKbwS52YcNDCImHWEBkBU2DGCmZdSvVoKk/7TeyA+dLGDdQ8O95TfMWyCq1c2BMPsoXLi6fpZ0i/HHWXm7ex1S1lEnX0dcAJww1FjDeNzRe+X0bw3xpg3l7M15wTGnixZmrfpzF4Zl1RB4PEGMuVMAUnim1r9+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=e6FLPsV9; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Ujz3a1ZI; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57JJZ5ms732100;
	Wed, 20 Aug 2025 09:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=fXRsSiCzZMCsTmzpE4I1P9xAb5YwzDqs62e33loq6nc=; b=
	e6FLPsV9pg9bk4FXfSK0N44HfdfsHIqjO+JmHsIpyHzVeiDNa4j2HlzLDg32P2cd
	NiHR2cXWmZqFneZM2kiCx4mRm8rY+LAhkXik7AKeGqurPMr8VrO0wA5zzhqGKifa
	qwqlt9jHjlcRvbzXgem7zUoHpDBaUGxOzBlHkf/tAMJ33H/yF/jY8+BwwMJksRbg
	6EIhhgVkUTZDkj9WQ0mH/lKzQtlsvpVqsKALt3uuKLkExUi66ntPL3cmPG+4nFj9
	+9EUTFcrEfe2rUsHHawNfe805qP/rwshs7KPsjrk03IfLk8sSY+laAkFKD80+gES
	gU9TqgG0ijGphTHmulkD+g==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2125.outbound.protection.outlook.com [40.107.94.125])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 48myd59c7w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 09:22:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYRKSOn80bk7iM5tQH0jsoqOg0/1Boed4aoXGDDjUstFKlc4zhXYg15hUNww23zjlZ92wsPL4CRj9ABKpIEY2DTAl8nwFjPjVDWouHs1AiPF0Qo9yBMSuI3ruxICwjhufb4IMCcnnn2E6hzT0TM08l5qDIxof7y67JhlSv7HGcIxZ2D6ottEwnAPZp5zP0U8TYkVtT37fHweIzoxLJEtFa86agzTgvH4Te/Hm9TScr6kwhP9wpD1gS3ltVdQdgFe3TifACO00m9iTgr4nQVFLgtPkT+e8D3DMSzRtQZQ3/4SAAA1XgYTNKyfUMmh9EB3zu2PCEuddSFQzoMokbfE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXRsSiCzZMCsTmzpE4I1P9xAb5YwzDqs62e33loq6nc=;
 b=Q/aoHvtRMvFOYvenwQGGLA6OZFbEtRBr1NhIi0d66HJNkEO9klYUKuV8YfqztfPfETqKQWLgbFSUbVM27GqlxUf+e1WFpY4fc7OyJu+nfg3ZJgIWjvxX6tjJEd/vbrJQN/uDSr7eO5aCUJdJNUXErT6WGzMiEG0TmfSXrogQihASGJrj6q8xlNzW/vd4W7NLuCfOdWg3AluC8h5+zf6WKEe+kb7VV8XhDitFvH/n2qfKmLKEb4yjpLCO2tKP2WE/X/4LyBhep8MTN5ij/hXgHz+c50Iu0EVg1bhgEBMmVq4DO4gv6YRkLna0RcJfpM4O+AzF+9BMgoSSIPk5qha/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXRsSiCzZMCsTmzpE4I1P9xAb5YwzDqs62e33loq6nc=;
 b=Ujz3a1ZIpojRkZmoyAOGOeNvNMLDVbWk2PLNRM/wGv0oQXggY9A7jHUtuv0JY8gAX4yPT2OboRa96prSrJ7fWxGW3ukcGUN6h6Kx6dGWETKQwCOBdurD3eKiF/G41OcWxyUQpW0hdDbop786UyxcMBQt2k/SlhmxsDoiYrcJqko=
Received: from BYAPR03CA0020.namprd03.prod.outlook.com (2603:10b6:a02:a8::33)
 by DM4PR19MB7882.namprd19.prod.outlook.com (2603:10b6:8:18f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 14:22:31 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a02:a8:cafe::f0) by BYAPR03CA0020.outlook.office365.com
 (2603:10b6:a02:a8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 14:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.0
 via Frontend Transport; Wed, 20 Aug 2025 14:22:29 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E3FF3406553;
	Wed, 20 Aug 2025 14:22:27 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id B922482024A;
	Wed, 20 Aug 2025 14:22:27 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 2/3] ASoC: cs35l56: Handle new algorithms IDs for CS35L63
Date: Wed, 20 Aug 2025 15:22:01 +0100
Message-ID: <20250820142209.127575-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820142209.127575-1-sbinding@opensource.cirrus.com>
References: <20250820142209.127575-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|DM4PR19MB7882:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9d558659-08b8-45b2-a58d-08dddff4fef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uSbIgbUMr92KhZbAhwW2Fkxy9dPanTA1vDMV6xmPFtuZ8Am0Cb0MLKzUSCNL?=
 =?us-ascii?Q?SqrDX7SNE1k9s1H9QMrUU2kDfs477HkRIxb02k87tAshTcI/G7DpJUEO8uiP?=
 =?us-ascii?Q?Hm9NZSjgErT6LcvO4IYOsFw9bZgnXOwj/L03L2TEv5wiE65o+uc/mM+MskU3?=
 =?us-ascii?Q?8uTawLRLNw0rAS8Yv0CDYd7NTs+6XlmVHBA9UKC8jIcpo8crQrRlnbAb26rq?=
 =?us-ascii?Q?v9CkCdI0f/Sjlk46SQiWNBmWJmVJ12mN4uQzTZbhBdth8pajmYrlvIw7mv4O?=
 =?us-ascii?Q?1AjaOvv6wp1aCJAVezv2IPIIWXT1hLLieBDwFtYKmHe5/U1YkFe50k/FQR33?=
 =?us-ascii?Q?QMcMlO9/y8Fr8HWrnEAevbi4axy6g249qKXWWg+rqmreQgZ5vDUHVzyztxBh?=
 =?us-ascii?Q?g4jPke/XnCMHWjbbDZsZI0CoOTF8Fve5hiFXqKj44GE53QZamywGf9Gb6UjH?=
 =?us-ascii?Q?FBpEI6r/jjF/PKRB34FczrwnMOTEANDNwEziSVMXRFGl/FWbUK3lbazmszf8?=
 =?us-ascii?Q?M6p4Z4O9q0InOAJ732hWDSU+23PuMC+pfWxWyHO5suEYjyr3DJZqP5AuqcL8?=
 =?us-ascii?Q?KuN++OeFXDPZr2THSd5ebhpg4yWDUxO1YLbBtCPwj5wBrVzTa2/IIWdn+Toe?=
 =?us-ascii?Q?PxIi+17b78GLwaBeufwZOKS5TXFgsGBU+WZnhjlKv/awwfXkQwhNxEMZqlKv?=
 =?us-ascii?Q?Gn9AUzukwjGTTBg+Cv9tR5AcDOgFUMUTZ6+WJrBGjaWDo2vEKd5VxNFyV7yV?=
 =?us-ascii?Q?R2tOV+TBIUQDJflw5mKuiDMnWElBwjgSmInb/KI2z+0tzoDjKganG9pykLiy?=
 =?us-ascii?Q?aUqNDJM67ZqphPTHecbwbHfSSgHp6XxAUJ0B2P0rdx79ISKlBkfU3ifWftMC?=
 =?us-ascii?Q?elmej7xVM4O48ZtK7ekjxeynJAgiBTfrWxgXtJiU5DQNpMoib9ilLjsDJO2H?=
 =?us-ascii?Q?IQzltVOvfzNL9GjwDks48E0UYcq12dZnq/77c3/2wux6notkJby9dZqeb6DC?=
 =?us-ascii?Q?812cUMeruSW5eMe0g5//q4+kZ5082x775I/sdfhbr6nawMrWYleOh+GYmxC/?=
 =?us-ascii?Q?fQM6XMN7FlEB74oA8pkarSd6Dr05mBGe6L95jAOWF2UWdq9ou4aWFpGoyX4X?=
 =?us-ascii?Q?mkMBX6p223ZqlYCn2rBcT97ekGsgxVvlLF4t7z+cW0NAYW1D1wNHZj03wVic?=
 =?us-ascii?Q?IZWyq4KakOLq4QAw372Y0DJftV1U0LW1vyVRTVk2cpSo9UIdaLxUl9aU5TVz?=
 =?us-ascii?Q?/o+Eqn4EDa9igvQJA42L2yIocI0UkPE5PX18UbwQeSwRu1qCy25Q2i1jGexc?=
 =?us-ascii?Q?i+VzhuGCyDwK4Bb9qndTnVJxr+x9ioERw1pdp96W+qEOXSj+IEa8Pj9n08W5?=
 =?us-ascii?Q?uWW2ikScEmF6QmXZI27NbudEK9fA7VYzw3olTEowlr7+tUg+RkEEfgtVu1xq?=
 =?us-ascii?Q?sBVhzzm0QImfRmi3TbAYDJPyHKjUsxjJgdirBC2Xe1qMxmUfOcScdCw2tycI?=
 =?us-ascii?Q?HeK7etj8Kk7xBV0fCd6X0GfVaRF45xqyC7lr?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:22:29.5654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d558659-08b8-45b2-a58d-08dddff4fef5
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7882
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEyNyBTYWx0ZWRfX7rjNjqhfGsMc
 9al8u/0LT8bvcymN4JpynUGo7MqVkXkbDF49txmfxTagh4/Asgg4ojCPsV0OLLxxgnp9ah/0Cjb
 YYxhY3O15KqIUcpt4wKgyYzD+311yZcIglnMP+XBcHMA9m+WPyNnxR0D6CLqL9nPD7FdSPIO4wf
 SGpuHcl6V85bC5oWDwa7jY3NEzFzV2C+/8XmLy99dpgy8p2FZUvghYC54RqEhzugzqrG00ooelR
 PNrAXuYaAfA3YLWUMFHJ6Wb3M6uIwncdSzMitVbGzkCre2yTihvCaObWpLEJEVJY/1X4otlpnOE
 G1Nmc0MdLFlvTx0tjhQPMUa0kX+v6jPfKzSkWOBB586xccUN1utmmwKq1JIJiaJhwcSNQQTCHzA
 Vjldy1OpmuVSbIUG9jt1KMozOsiaGQ==
X-Proofpoint-ORIG-GUID: 6M5HEYea7Pkp6wMrZhjdRW14AlunKI58
X-Authority-Analysis: v=2.4 cv=EpWLbScA c=1 sm=1 tr=0 ts=68a5da31 cx=c_pps
 a=BIp6kkfJeZTrem3KMu6imA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=rSAZ-gJm6b_PRif3JyQA:9
X-Proofpoint-GUID: 6M5HEYea7Pkp6wMrZhjdRW14AlunKI58
X-Proofpoint-Spam-Reason: safe

From: Richard Fitzgerald <rf@opensource.cirrus.com>

CS35L63 uses different algorithm IDs from CS35L56.
Add a new mechanism to handle different alg IDs between parts in the
CS35L56 driver.

Fixes: 978858791ced ("ASoC: cs35l56: Add initial support for CS35L63 for I2C and SoundWire")

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  1 +
 sound/soc/codecs/cs35l56-shared.c | 29 ++++++++++++++++++++++++++---
 sound/soc/codecs/cs35l56.c        |  2 +-
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index f44aabde805e..7c8bbe8ad1e2 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -306,6 +306,7 @@ struct cs35l56_base {
 	struct gpio_desc *reset_gpio;
 	struct cs35l56_spi_payload *spi_payload_buf;
 	const struct cs35l56_fw_reg *fw_reg;
+	const struct cirrus_amp_cal_controls *calibration_controls;
 };
 
 static inline bool cs35l56_is_otp_register(unsigned int reg)
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index ba653f6ccfae..850fcf385996 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -838,6 +838,15 @@ const struct cirrus_amp_cal_controls cs35l56_calibration_controls = {
 };
 EXPORT_SYMBOL_NS_GPL(cs35l56_calibration_controls, "SND_SOC_CS35L56_SHARED");
 
+static const struct cirrus_amp_cal_controls cs35l63_calibration_controls = {
+	.alg_id =	0xbf210,
+	.mem_region =	WMFW_ADSP2_YM,
+	.ambient =	"CAL_AMBIENT",
+	.calr =		"CAL_R",
+	.status =	"CAL_STATUS",
+	.checksum =	"CAL_CHECKSUM",
+};
+
 int cs35l56_get_calibration(struct cs35l56_base *cs35l56_base)
 {
 	u64 silicon_uid = 0;
@@ -912,19 +921,31 @@ EXPORT_SYMBOL_NS_GPL(cs35l56_read_prot_status, "SND_SOC_CS35L56_SHARED");
 void cs35l56_log_tuning(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp)
 {
 	__be32 pid, sid, tid;
+	unsigned int alg_id;
 	int ret;
 
+	switch (cs35l56_base->type) {
+	case 0x54:
+	case 0x56:
+	case 0x57:
+		alg_id = 0x9f212;
+		break;
+	default:
+		alg_id = 0xbf212;
+		break;
+	}
+
 	scoped_guard(mutex, &cs_dsp->pwr_lock) {
 		ret = cs_dsp_coeff_read_ctrl(cs_dsp_get_ctl(cs_dsp, "AS_PRJCT_ID",
-							    WMFW_ADSP2_XM, 0x9f212),
+							    WMFW_ADSP2_XM, alg_id),
 					     0, &pid, sizeof(pid));
 		if (!ret)
 			ret = cs_dsp_coeff_read_ctrl(cs_dsp_get_ctl(cs_dsp, "AS_CHNNL_ID",
-								    WMFW_ADSP2_XM, 0x9f212),
+								    WMFW_ADSP2_XM, alg_id),
 						     0, &sid, sizeof(sid));
 		if (!ret)
 			ret = cs_dsp_coeff_read_ctrl(cs_dsp_get_ctl(cs_dsp, "AS_SNPSHT_ID",
-								    WMFW_ADSP2_XM, 0x9f212),
+								    WMFW_ADSP2_XM, alg_id),
 						     0, &tid, sizeof(tid));
 	}
 
@@ -974,8 +995,10 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 	case 0x35A54:
 	case 0x35A56:
 	case 0x35A57:
+		cs35l56_base->calibration_controls = &cs35l56_calibration_controls;
 		break;
 	case 0x35A630:
+		cs35l56_base->calibration_controls = &cs35l63_calibration_controls;
 		devid = devid >> 4;
 		break;
 	default:
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index b1c65d8331e7..2c1edbd636ef 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -695,7 +695,7 @@ static int cs35l56_write_cal(struct cs35l56_private *cs35l56)
 		return ret;
 
 	ret = cs_amp_write_cal_coeffs(&cs35l56->dsp.cs_dsp,
-				      &cs35l56_calibration_controls,
+				      cs35l56->base.calibration_controls,
 				      &cs35l56->base.cal_data);
 
 	wm_adsp_stop(&cs35l56->dsp);
-- 
2.43.0


