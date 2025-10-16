Return-Path: <linux-kernel+bounces-856025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BB9BE2F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49639509162
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3876B3254B7;
	Thu, 16 Oct 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kBksV6Zz";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="xQWLzD1C"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43202DA769;
	Thu, 16 Oct 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611386; cv=fail; b=otI9hwK+lwJCMRbouoD730hQUQztItShdXvFGvcGUq0UnAlSUlots6rGEZF5+PZ88pjUJDNsCbzNwIeBVnZJCFg3jcyyzv9WcPgLOcHN1v1mhACjz7hTSULt8SFAjRgjiRNUq1/7XxwlxQ1jInD1dSeLv4zR2HqOQVHOg355Hj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611386; c=relaxed/simple;
	bh=pFb+S0bm5x1nsJhn74dfU4At8/rQKj8D/HFWL5MV+qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKVZFLJ+wWJdAECzqm6IG36/hujmyzJ129pXePRm3joA9xV+TRb6H182ucFia7hDAtg2aQYm8ecMU57682GmRRjYAINq7ql8LHWnK5Oa7U4u7WI0Hus0knMMrwvTP3eoddsKRH14/ajv1VEY7o+th3acBsy8Vjn6p6qYy5kd/uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kBksV6Zz; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=xQWLzD1C; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59G9oCCW648147;
	Thu, 16 Oct 2025 05:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=eigMgXC3mmB2bVkc38tlRn7apsQxJ723irr63EP0M2o=; b=
	kBksV6ZzmIiCKh+Pz+hAzRhaClvHQ32onZ3R2e6Ds7926tKcevnQ48+EmdlG0Rx/
	LmHgLwkLm9yqDJB+bufjhBuQER6wUh8qb8wf6iw/k83b1NIBR6Z7nWdrsaMU/hRl
	Fvxin+UG2VtNA3WGx6Z5OYNhczMD7m11/O9T/Wen4QE4E9eiAcZkMFfBVOMDP8no
	YOB4ebGwFiOjGVTFBwXXWnP6fLA0ggSN7Zl5U4WLD8WDA4SALUFqsENpSPNyLeKK
	Wrf/ZOLdPGvkCijGbyY3QqNCUjugyV/DTyyHKxV51ImDWw6j0OmXo0mRlaOndtpO
	vswlIQk5tqSwtG7Zgn45vw==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021124.outbound.protection.outlook.com [52.101.62.124])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb448a6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:42:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPhTzKS+AU5dFnUj5oaonuo9wtyAEAVnX9ujlAY3mnGaDxrFPg7WqdNkNHQOdBwFaVcn6cFFR/7edhZswLe5XmdnMhnVoxApMRyGspgsL6y8DmG6Aaf+tYjbRWpMeMYnpl/2eyIijYgsxWiqRaJmey4aMOjsct8jUtmoHu73KuRhIkf2uadSU/7On0vh04tlXLq6D2wD7DZWwHjtpgsjDq5etb0hAkSJT9WLSH9zjTdf/IitDmKa995e81m05Ey4KJt5QSTCuqczqQ1qAxiKjVlXOp1VmCR5aA4TdiOSzZ54rqVNJVhMfOQ3im2GC7kfzUevaN6jkQhBMatFj/uklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eigMgXC3mmB2bVkc38tlRn7apsQxJ723irr63EP0M2o=;
 b=sMF9fHYe/8ZPJarZE81fIqYKZMZyAkOhb233PuXuAtA4MuthanHxycjBoX7gMUKCOXNeEXnaKC8E9r8u0BusUva0K5R0MyVIO14dxWqLCz4XS/9FGOyW+Z6daxiRDTFoXU221ZTa2VkfCkrxDHhRD0sBChyvh/XEG22cFr/Ze585ptmGYsqVLarQRzdQFNnDPvuNvih6/FwlHPbJ1VgxD0tt+rorzYnlUZ2C12r0mvFc70XRGEbBEc+IRbfc5c1wx2flG1fQplhI+9jb7KBr/rP2Zct0x1+EETYq+M4yHpDOn2sR/hm9vj1lbsJqwGP+3MpSIkzHExFldTOg2zHoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eigMgXC3mmB2bVkc38tlRn7apsQxJ723irr63EP0M2o=;
 b=xQWLzD1CkzqsTLsPA3s5OKMdJEyzLL6Yjxyet5MYMZOXir5b+oPz5bBpqAeqn4WcuxS+0FC2l6W+fc1Wvu8boiM5qUng9EYLXZ/Sl703B6IJeJElH1fapzcnZfzZGcr+cOFoGxfuHchQlbWKk5iIpvwbvM4QPwPl4pXgpn4cgcA=
Received: from BYAPR06CA0005.namprd06.prod.outlook.com (2603:10b6:a03:d4::18)
 by DM8PR19MB5288.namprd19.prod.outlook.com (2603:10b6:8:6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Thu, 16 Oct 2025 10:42:48 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::14) by BYAPR06CA0005.outlook.office365.com
 (2603:10b6:a03:d4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 10:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 10:42:46 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id DDE1D406556;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C30A4822540;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 05/11] ALSA: hda/cs35l56: Create sysfs files for factory calibration
Date: Thu, 16 Oct 2025 11:42:36 +0100
Message-ID: <20251016104242.157325-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016104242.157325-1-rf@opensource.cirrus.com>
References: <20251016104242.157325-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DM8PR19MB5288:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 87eb3ff2-4678-434f-ca86-08de0ca0bead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IZfWoRn7aql1oCXl8SmCChZD4Wqy4ItqcIEq1tzEB6ZMPW41VKrsTZnvaFpI?=
 =?us-ascii?Q?qqSm6ceHmL2Y0URdfHmg6P9pz54amt26B3soobagiNwlQ71YzYdbPRo9zSvc?=
 =?us-ascii?Q?4I2yNEAolmMrWrNLEQnx64oZWNka3DlMPdEZl1sBQN9UqB4BqJXQXR4q0Mpj?=
 =?us-ascii?Q?QtMUq6DmSaACIJunACrHeVnz1Nkb5w014uZkAoLllK/Xw96GE/1UwQoXm+Dn?=
 =?us-ascii?Q?e3ngeiQEoi3b9iONv/ep6V53OvjtSc7fCJnj4TBowunAdtivcOXKf6YhwbyJ?=
 =?us-ascii?Q?5J4/K6VSC5ZePA7i9dTFc0Gvrq7WaOYjIN6ytOuwlHs8uemwV6Wv8NoncwYZ?=
 =?us-ascii?Q?/KO7lGouNxyxWiOhvVNfwB35BCH9XS6YZD6o4Dz5bTVjZr7W7u7UcEuoMLNN?=
 =?us-ascii?Q?X8W46Nd/5XXBVmIuZ/iK4TKm6GJLMJTtRSLESbNhYIMP1U7IqtMhQLo23EYM?=
 =?us-ascii?Q?0hIkn+QUmZA3x7M8JMcjecSftSNPrfKrHjg7n+5SqOo6MlNd1BqGdNU6y9aQ?=
 =?us-ascii?Q?9H1C9zVpTMoCHYvE6gDtAi56uuqddv+LkTsNKbW9GImE2e27HDoNqZRg+Zuc?=
 =?us-ascii?Q?EVUb1npPEOphX95COmyjvxzz7J7UMEimjdMYw2K6EtYjaE7zAVzgeXGxzmu2?=
 =?us-ascii?Q?WwBUnOA9TtIKO97XpmxC53pG9wd+dU7Hamzf6eNSnohZS7lQDqYiZn+khNNf?=
 =?us-ascii?Q?Dt8i87sODLgT2V5lk7rBqoaEy+A2leS9vgT0erYJzSfGv/OT1xBVdTVgG5Wr?=
 =?us-ascii?Q?YZWPHiSuE0wLxGM5MLfuRLgKGoW8zC626GQ++zpAJ/VFvlVS37WrPjWGKKJF?=
 =?us-ascii?Q?8kDyennE5TbYgsemv6Te4X+qpOGzEhbbmDCebyJlTnKGda2jQs1l4T6yQWSW?=
 =?us-ascii?Q?RLjnkoAIPfmFrMpNSwcXFwKA32IOB9kN1WKwk2IdGnwPWImm36ShjuXhdjei?=
 =?us-ascii?Q?YGSpOtUKv5tNoz7AGPBeZsOH0vKeckY0XjhFoAf4SiuwMklQziDHNXvISRYc?=
 =?us-ascii?Q?XC7dlfgkjWCtkA4Qdp38P8z4KUfKk1GEo/AM5HmpaZQ64+4HfyNO3msfEjXt?=
 =?us-ascii?Q?OBToVCDBn5mf1hnKJJ7MlvXpD1/fBxg3O1+1//6yVb1wOWvxPwRsgGoefHoK?=
 =?us-ascii?Q?hWZ3d+MVls9E/jpAhPEGlW7VCtHdgnmhfGr9Al6QwgCs9OzP2yxPSfSP2c0V?=
 =?us-ascii?Q?1v5P6mFSb4Rtp0rvvRbSaux7Ar0Y3TvUWwj9kKQ9nq+VSDA45U/CHknhxlvT?=
 =?us-ascii?Q?HjRljT+BdpkOtWaTR5oyB2mMSdCR25AuhvSnqKAH0yT34Ru3m4kfpmNUtzik?=
 =?us-ascii?Q?35jwSAai0wFhSZ21qUqz8sNMtMlx8SQhJlbKDnz/Xi4ZFKtkdm2EIXVyKA6G?=
 =?us-ascii?Q?29y8rJE68tRmR2T+yVNzrn3G1hl7MkyCNOEV522uZBz9NbG5Dnb9YSQBfb1f?=
 =?us-ascii?Q?QrwAJRDZ4rBRsK/HSzzixjuHBuKv/F42+8jfF0F9WiZmIPVmzYHXev73ZSgg?=
 =?us-ascii?Q?UQ9DHqjD9aeczbAIG5axovuO8q97lcoefmUv42rHGvww5qng8rdkVK0n8oHC?=
 =?us-ascii?Q?OddNCrKuTEtoS1CG8Ec=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:46.3198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87eb3ff2-4678-434f-ca86-08de0ca0bead
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR19MB5288
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA4MCBTYWx0ZWRfX1A3QWerAgDon
 9+E7jRzoHLSfrwE5wyI99UzS/HehvKJcjtE2zou3jB+EFlnqn7T0pZhhV1Abb/loBOiAntcCun1
 QZYn1d38Hnp3pldmUlYSK03sHN5BPPhDKwcuwqdg6+DwcNutV43R4/mbvFtAIpZVe+a6a0w331S
 jRt84pGnFdFhCMovq5Eydy/YKpznNIISjryCf06xniXn1LrAKxSU5Xw+sDLXDB+1s/pdWu2Zaqr
 pq3TI6ZhG4nrM9YbBWrxq5cpT+dEMsU/2WCp5WQfHGfZabx3+qZyATZUmAv3DQTa/Py4F0z6ktU
 WdK5tWT1bPPs/n0GiopMcz4zkaz7FJQppWGbVlAVotrvPOCokuCl9Y23vwzlLDofIbGQryKbCfs
 K3GrcZ3e9+THxbmPzfxH2Y0DZcf/4g==
X-Proofpoint-GUID: kvrkGeJP75yV-1WBMoeN3jKhEjiWssju
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68f0cc2d cx=c_pps
 a=xVCXbABICjn79FXy6fcvAA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w1d2syhTAAAA:8 a=x8F6GPULHbFzkjThbqYA:9
X-Proofpoint-ORIG-GUID: kvrkGeJP75yV-1WBMoeN3jKhEjiWssju
X-Proofpoint-Spam-Reason: safe

Create sysfs files that can be used to perform factory calibration.

During manufacture, the production line must perform a factory calibration
of the amps. This patch adds this functionality via sysfs files.

Sysfs is used here to restrict access to the factory calibration.
It is only intended to be used during manufacture. It is not something
that a normal user should ever touch. Calibration affects the matching of
the amp hardware to the external speakers. If not done correctly it can
cause the speakers to be under-protected.

As this is only needed during manufacture, there is no need for this to be
available in a normal system so a Kconfig item has been added to enable
this. The new Kconfig option is inside a sub-menu because items do not
group and indent if the parent is invisible or there are multiple parent
dependencies. Anyway the sub-menu reduces the clutter.

cs35l56_hda_apply_calibration() has been changed to return an error code
that can be reported back through the sysfs write. The original call to
this function doesn't check the return code because in normal use it
doesn't matter whether this fails - the firmware will default to a safe
calibration for the platform. But tooling using sysfs might want to know
if there was an error.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/hda/codecs/side-codecs/Kconfig       |  15 +++
 sound/hda/codecs/side-codecs/cs35l56_hda.c | 139 ++++++++++++++++++++-
 2 files changed, 149 insertions(+), 5 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/Kconfig b/sound/hda/codecs/side-codecs/Kconfig
index cbf1847896bc..0218aa41bba2 100644
--- a/sound/hda/codecs/side-codecs/Kconfig
+++ b/sound/hda/codecs/side-codecs/Kconfig
@@ -88,6 +88,21 @@ config SND_HDA_SCODEC_CS35L56_SPI
 	  Say Y or M here to include CS35L56 amplifier support with
 	  SPI control.
 
+menu "CS35L56 driver options"
+	depends on SND_HDA_SCODEC_CS35L56
+
+config SND_HDA_SCODEC_CS35L56_CAL_SYSFS
+	bool "CS35L56 create sysfs for factory calibration"
+	default N
+	select SND_SOC_CS35L56_CAL_SYSFS_COMMON
+	help
+	  Create sysfs entries used during factory-line manufacture
+	  for factory calibration.
+	  This is not needed for normal use.
+
+	  If unsure select "N".
+endmenu
+
 config SND_HDA_SCODEC_TAS2781
 	tristate
 	select SND_HDA_GENERIC
diff --git a/sound/hda/codecs/side-codecs/cs35l56_hda.c b/sound/hda/codecs/side-codecs/cs35l56_hda.c
index 5bb1c4ebeaf3..4a1bd934887a 100644
--- a/sound/hda/codecs/side-codecs/cs35l56_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l56_hda.c
@@ -548,20 +548,24 @@ static void cs35l56_hda_release_firmware_files(const struct firmware *wmfw_firmw
 	kfree(coeff_filename);
 }
 
-static void cs35l56_hda_apply_calibration(struct cs35l56_hda *cs35l56)
+static int cs35l56_hda_apply_calibration(struct cs35l56_hda *cs35l56)
 {
 	int ret;
 
 	if (!cs35l56->base.cal_data_valid || cs35l56->base.secured)
-		return;
+		return -EACCES;
 
 	ret = cs_amp_write_cal_coeffs(&cs35l56->cs_dsp,
 				      &cs35l56_calibration_controls,
 				      &cs35l56->base.cal_data);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_warn(cs35l56->base.dev, "Failed to write calibration: %d\n", ret);
-	else
-		dev_info(cs35l56->base.dev, "Calibration applied\n");
+		return ret;
+	}
+
+	dev_info(cs35l56->base.dev, "Calibration applied\n");
+
+	return 0;
 }
 
 static void cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
@@ -669,7 +673,9 @@ static void cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	if (ret)
 		dev_dbg(cs35l56->base.dev, "%s: cs_dsp_run ret %d\n", __func__, ret);
 
+	/* Don't need to check return code, it's not fatal if this fails */
 	cs35l56_hda_apply_calibration(cs35l56);
+
 	ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
 	if (ret)
 		cs_dsp_stop(&cs35l56->cs_dsp);
@@ -695,6 +701,126 @@ static void cs35l56_hda_dsp_work(struct work_struct *work)
 	cs35l56_hda_fw_load(cs35l56);
 }
 
+static ssize_t calibrate_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
+	ssize_t ret;
+
+	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
+	if (ret)
+		return ret;
+
+	ret = cs35l56_calibrate_sysfs_store(&cs35l56->base, buf, count);
+	pm_runtime_autosuspend(cs35l56->base.dev);
+
+	return ret;
+}
+
+static ssize_t cal_temperature_store(struct device *dev, struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
+	ssize_t ret;
+
+	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
+	if (ret)
+		return ret;
+
+	ret = cs35l56_cal_ambient_sysfs_store(&cs35l56->base, buf, count);
+	pm_runtime_autosuspend(cs35l56->base.dev);
+
+	return ret;
+}
+
+static ssize_t cal_data_read(struct file *filp, struct kobject *kobj,
+			     const struct bin_attribute *battr, char *buf, loff_t pos,
+			     size_t count)
+{
+	struct cs35l56_hda *cs35l56 = dev_get_drvdata(kobj_to_dev(kobj));
+	ssize_t ret;
+
+	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
+	if (ret)
+		return ret;
+
+	ret = cs35l56_cal_data_sysfs_read(&cs35l56->base, buf, pos, count);
+	pm_runtime_autosuspend(cs35l56->base.dev);
+
+	return ret;
+}
+
+static ssize_t cal_data_write(struct file *filp, struct kobject *kobj,
+			      const struct bin_attribute *battr, char *buf, loff_t pos,
+			      size_t count)
+{
+	struct cs35l56_hda *cs35l56 = dev_get_drvdata(kobj_to_dev(kobj));
+	ssize_t ret;
+
+	ret = cs35l56_cal_data_sysfs_write(&cs35l56->base, buf, pos, count);
+	if (ret == -ENODATA)
+		return count;	/* Ignore writes of empty cal blobs */
+
+	if (ret < 0)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
+	if (ret)
+		return ret;
+
+	ret = cs35l56_hda_apply_calibration(cs35l56);
+	if (ret == 0)
+		cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
+	else
+		count = -EIO;
+
+	pm_runtime_autosuspend(cs35l56->base.dev);
+
+	return count;
+}
+
+static const DEVICE_ATTR_WO(calibrate);
+static const DEVICE_ATTR_WO(cal_temperature);
+static const BIN_ATTR_RW(cal_data, sizeof_field(struct cs35l56_base, cal_data));
+
+static const struct attribute *cs35l56_hda_cal_attributes[] = {
+	&dev_attr_calibrate.attr,
+	&dev_attr_cal_temperature.attr,
+	NULL
+};
+
+static void cs35l56_hda_create_calibration_sysfs(struct cs35l56_hda *cs35l56)
+{
+	struct device *dev = cs35l56->base.dev;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_SND_HDA_SCODEC_CS35L56_CAL_SYSFS))
+		return;
+
+	ret = sysfs_create_files(&dev->kobj, cs35l56_hda_cal_attributes);
+	if (ret)
+		goto err;
+
+	ret = sysfs_create_bin_file(&dev->kobj, &bin_attr_cal_data);
+	if (ret)
+		goto err;
+
+	return;
+err:
+	dev_err_probe(dev, ret, "Failed creating calibration sysfs\n");
+}
+
+static void cs35l56_hda_remove_calibration_sysfs(struct cs35l56_hda *cs35l56)
+{
+	struct device *dev = cs35l56->base.dev;
+
+	if (!IS_ENABLED(CONFIG_SND_HDA_SCODEC_CS35L56_CAL_SYSFS))
+		return;
+
+	sysfs_remove_files(&dev->kobj, cs35l56_hda_cal_attributes);
+	sysfs_remove_bin_file(&dev->kobj, &bin_attr_cal_data);
+}
+
 static int cs35l56_hda_bind(struct device *dev, struct device *master, void *master_data)
 {
 	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
@@ -722,6 +848,8 @@ static int cs35l56_hda_bind(struct device *dev, struct device *master, void *mas
 	cs_dsp_init_debugfs(&cs35l56->cs_dsp, cs35l56->debugfs_root);
 #endif
 
+	cs35l56_hda_create_calibration_sysfs(cs35l56);
+
 	dev_dbg(cs35l56->base.dev, "Bound\n");
 
 	return 0;
@@ -736,6 +864,7 @@ static void cs35l56_hda_unbind(struct device *dev, struct device *master, void *
 	cancel_work_sync(&cs35l56->dsp_work);
 
 	cs35l56_hda_remove_controls(cs35l56);
+	cs35l56_hda_remove_calibration_sysfs(cs35l56);
 
 #if IS_ENABLED(CONFIG_SND_DEBUG)
 	cs_dsp_cleanup_debugfs(&cs35l56->cs_dsp);
-- 
2.47.3


