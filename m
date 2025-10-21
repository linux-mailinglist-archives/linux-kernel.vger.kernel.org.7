Return-Path: <linux-kernel+bounces-862672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1ABBF5E28
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28343B48C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791F532C955;
	Tue, 21 Oct 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cSMKdt1e";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="nXk0ksxH"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6AD303C93;
	Tue, 21 Oct 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043836; cv=fail; b=MjtLa/3OlyZ3al5fAfsPkl+OZMn5ctyD6sIYBYH1hN+9nO73EKQ3sSurKrjyezYd9oW2FhnK/8TB9TqFtSZwB2Cuun0MASgIqEt7eK7ecaJmIyBW14E1kMFxDmKR2IzYER5GSHorW53g4dC39lH5LgIHNjgrCakWgLV1H40ygog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043836; c=relaxed/simple;
	bh=P1MWqPO3tKGdenYUxbTvvUcxwscYD8bnqSJS1FAXtiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOrcWN7HTUAel8IqK00R6CdNMd178F4lrqFAEfbLNxPt1Bo23O14CeSbvscmoJYdy3DOWvUCe9TftDYE5iRgjy/8EIPVPUN147NRVV63ExEVgozLSbl3pewcBOf9XU+O5KCa1RKcAl2gJfxnQnqg3RvZLs47ELKuWe/CfjKJNN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cSMKdt1e; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=nXk0ksxH; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59L4xtJn2412958;
	Tue, 21 Oct 2025 05:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=zNCQlsf1Qw7sQkpt8u710Er7F3pdB79f07UFMQ0OZ18=; b=
	cSMKdt1e7pBslHXZ0xWLeY+GyXRkjCJEo7LE1OcKb1acM6z1SBc+W8K2uVdSj641
	g+mE+tF2lXnoM07vq+miaEQ/Hlh83JmImBP9J3fUd+Bx3V+oCvWaLtFF9AwG8XSp
	8KbMkcK0lQTzUvBbfU1MI59ptbLMODpVMPfvua8WSxXqe/PauzPlTStdEAU0jjmb
	M/ae2wMBponxYliMXPsz5jIs1CJw2Zj5XgOfIwUNMPxgiJiLfl2Y1qMxJ2LmPX/y
	yFs1qA5CqlZeOIXlKMp+RwZzvLWqt0pdkybAyfJbeuo6E6tg8j40W+btExW41KZf
	IuyQ+OQiTDahZJHPW/PO0Q==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020134.outbound.protection.outlook.com [52.101.61.134])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49v7aj3eg1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 05:50:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIUFJhHm6DEsIveuO+xrFY0vPHX9iihBu/GZisNM4cxaiOAO3+thvjNxNlXXrsNjT5dp54+yiBBm14i8ExcyyCi3ww0uGiKUz8+bQxXA3LHlC3z7QAConzZ/Nd/QMEvTMUs1OGRWUqdIeYCebUnzf7KQEAmf1j8toRGIjUtMFqZ4upCgL0s25srWfrW4dUTz4aFvB3P1C4Srif8o6jJ8kYWSRwlCVU1xJ0xOwq6+YhXQRcOxqpCGx70aI1PvfMDtqNviPwIf6mIzo3tx0ARq97PRKrBELA6LO9i02CEDF5fwdfq6go1BROGaxiB9HFUlsbm/0Vcb2bs5FGajf0SgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNCQlsf1Qw7sQkpt8u710Er7F3pdB79f07UFMQ0OZ18=;
 b=vzE+oUEUSjXPqXzvU8D3GA28O5tIZbcXwCFSWu8y+gP6EIVEImbIC9GkW15IFCy/uKy318ckXRvrwvQLfKrDCSwLIu99B5cKCQvhKHXSJdJNSsG1GHQCiUnSk4s2doWU49sRM/kbTCew7X/xVbKAYicouqjN7cRmIGNMWTz48ZAGfqOswK5ypIOqq97WuTyQo/Y3wCqhh9WjiQaFnrChLdkkLwC+Uf17wrBeNJCN4Ptr5KrXiR3LcNi4HoLapGG90LpUkk9xaUFU+OW48/K7NdOaMbIfJCFUBs3B6peMS+uNQH8IVn/iacA2fBkzcX8D6i0wtsJpKHXk8/Rfu8Jjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNCQlsf1Qw7sQkpt8u710Er7F3pdB79f07UFMQ0OZ18=;
 b=nXk0ksxH0qxssTRqAOOfBvrW2Rbcwrj7t1TNLJFGEKF0pzDGBZeYIdU1iotLfzkipjcx+K4kHlYEwNVyV3wDProHyUx9mea5Ag6Tq9h56GIWioD5YLw/2Tm7ccd0yFW5xviAT3d69fym9zfzwTtfqjrybOzohG9IhJZGfp8aKdM=
Received: from SN7P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::34)
 by DS2PR19MB9102.namprd19.prod.outlook.com (2603:10b6:8:2b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 10:50:27 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:123:cafe::3e) by SN7P220CA0029.outlook.office365.com
 (2603:10b6:806:123::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Tue,
 21 Oct 2025 10:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 10:50:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id BA409406561;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 8F9F782255A;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 09/11] ASoC: cs35l56: Add calibration command to store into UEFI
Date: Tue, 21 Oct 2025 11:50:20 +0100
Message-ID: <20251021105022.1013685-10-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021105022.1013685-1-rf@opensource.cirrus.com>
References: <20251021105022.1013685-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS2PR19MB9102:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8c71f0c8-f3c9-4041-6cc4-08de108fa50e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XMxGnfM6/IrmbJE48LChngX1lrNMjIsIHQcjn8U8hKkS+3lm819BBKBwJU/D?=
 =?us-ascii?Q?nyXrw72tEZErIkXWoVd7sv4DKw6Qa5FMy6G8KR7cEA3p4HTxl9L4ilKAvFXW?=
 =?us-ascii?Q?8DooEvdx5s5sJjcJX/In5oUu8QeboxtBeEXN2iGSmKj9Y73TowX1P/lzTZFs?=
 =?us-ascii?Q?fAoVMXBy3e3DoPuA8duPo/sopY9/u45NpsPVs/NeXutI6j73Iic+1pkSXMf0?=
 =?us-ascii?Q?Ey7LHuw6pULT/fdai3nELkJZSYAPdhaHOMsO7QBKISjxdiwuLhlLEtb6HwAR?=
 =?us-ascii?Q?94IaEuY9cYlRZNnDJnsdPBr7HWXwJoctxWr/2+9DGC/EvYSxcUYxNMFnWXnv?=
 =?us-ascii?Q?HSxgMa1nr+n+bRQme1mDd6vPIGyW5Wx13dFnuPzX4lCVI/TYah3FaTW9hymM?=
 =?us-ascii?Q?OEcXCiRNc1Q8gBG5TYqQjg/NY/HdL/qpUUIHDKUHIiTBR0KipE+x5EXSPJS8?=
 =?us-ascii?Q?CJFwDlkIKni4x6bstJsVYTLw5WSdhdyx8jOCAB6OXK6mH1wFmPrG7ThKFzOr?=
 =?us-ascii?Q?dW/VDMVkbQ9pO2xkkgOvAnkTof5rMccA7mRw4c7pQx4PgUC/Mv2NDY3t/spA?=
 =?us-ascii?Q?QCOb4xYVoTGmGOiViM4Wwh9/GY03uPL8hobaUndrx3f3WKAhErMYRU9v7ndg?=
 =?us-ascii?Q?zhj2Ve/OwYDLbJTmBFutnSgAo/bmWFRi9+WGLnaDNbvm6NnBA2xh84mVQd4b?=
 =?us-ascii?Q?3/XQjosNsFJlNGwsd++NmnAyw/rgaIpo04i2kBkq7XIfWbIY9ynO/3yejfqR?=
 =?us-ascii?Q?bobvjOK14lBXkhhfMkyK+byjfqFhKVKQQ4xOlBmOAkOcNPQjooLjDwOA0Fem?=
 =?us-ascii?Q?eWp/lH8z34oExlqJaRtUo4cY+aeNBGkjUVSOe6WGjI0bRnUAdSJC8xTGUrt2?=
 =?us-ascii?Q?Vw36zb748bE7tZnLv22BJJevdKU3i5DgPLklz2fuLl5zPTmQUzC/tw24PTZ1?=
 =?us-ascii?Q?AlesMci0q7MOHeA757pGLTInxqs0rBPD552ZDWgpZCg0EVlojfTbo51a/NpZ?=
 =?us-ascii?Q?B2dXWfOKZscwTTF87WVnZJp5jyMD+UKQcHUieQ68D90M9yaZceZLBcsH9ZZh?=
 =?us-ascii?Q?qcay8njwh4XYBJQBtPSmTLEvVjfxhUBGHTGEUM30frnGd6l76F0ZV4Ttb0vD?=
 =?us-ascii?Q?eqg4Nglq/pPIVLh9/nvBi21rCdh//4JPmdqjLxuv2RYznRgS/stje5MgZR25?=
 =?us-ascii?Q?FGdaSfr1NN4h/NBV7i0u3A6Mm2vM1ZJNL1mTxAkBxk0BrOXJU/VweLJikhXM?=
 =?us-ascii?Q?NVFD417s/6pTCu+x35UTBDSf1L248ZAgUHTICKURCMp5kWgwbnCXb7QZ2aZx?=
 =?us-ascii?Q?2mkdfO+s9Li6qJ/NEzKbRc9FyUpSLis25htahcreuqE0l0n7RT6l52rVFxsm?=
 =?us-ascii?Q?F5Qt3owTRwTbLpdak1EKQaZ+u+aEmyoRvYuMKzsJYPXGFUc121l95v1FFRNI?=
 =?us-ascii?Q?kiflXjbNGO2OIxgoXchW66SDFUzGopfFlE6LEfKXNVmRwUE75ialGPh2N3+K?=
 =?us-ascii?Q?cIb3TW5RWMmOZYAPjXNnui83Txo8S0DZU2jN5iYRdHrJ+bFs/WVGOAxK9eje?=
 =?us-ascii?Q?jUkYsR/s4yYQMP8OAPs=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:50:26.5915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c71f0c8-f3c9-4041-6cc4-08de108fa50e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR19MB9102
X-Proofpoint-ORIG-GUID: fMiLW9EI2RLJ1qZAuHmuXfOB87GM5qYU
X-Proofpoint-GUID: fMiLW9EI2RLJ1qZAuHmuXfOB87GM5qYU
X-Authority-Analysis: v=2.4 cv=bdNmkePB c=1 sm=1 tr=0 ts=68f76577 cx=c_pps
 a=TszpKlPPvK6rXl4+XYbYdQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=8cExK4-QNj-zMObyTR0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA4NSBTYWx0ZWRfX9AgNoxfDPwMW
 2wynpM5wIRm9TnIO+Qn2v9m+YmyztqwtQb/SWbkpvnnGmCcdTxpIWac6/svXzdk9Wr6ocDASNJt
 wbVVC0ZAfWy4/UscOH9eUBRTCBBClAfcXLDbv+cEQsq7tRp77z3mjDJH8sFQjz+5LFG6Jn7VVuf
 Ji5QcUSDpDNdNoIEYzLAExBYmsDfh9Cw+2zDbNSyfag+kXhuwmY+/C2jD9w0YRRRjEYlaSAYdVD
 RKLK7bCxZNMrdFoyuXVtWzTuB20Sl/ye4SiqFUOqPnoePSPhkZvZCZSdSEYzxxMr15w5s0j3rrs
 z0uvWcSCQ+kGAi3Y52ZnO9wmZmUS7fqknbelGFWcum9yIVuYh/JePeA0e+CCTQ8GPoi8lH4AWFn
 vZfiKGDZ/vl8twrS55d8HdcQu2aFuA==
X-Proofpoint-Spam-Reason: safe

Add a new command 'store_uefi' to the calibrate debugfs file.
Writing this command will call cs_amp_set_efi_calibration_data()
to save the new data into a UEFI variable. This is intended to
be used after a successful factory calibration.

On systems without UEFI the write to the debugfs file will
return an error.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes since V1:
- Rebased onto the new debugfs callback implementation
- Only code change since V1 is to increase the size of the local
  char array buf[].

 include/sound/cs35l56.h           |  1 +
 sound/soc/codecs/cs35l56-shared.c | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 349b896ee737..82559be0f249 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -321,6 +321,7 @@ struct cs35l56_base {
 	bool can_hibernate;
 	bool cal_data_valid;
 	s8 cal_index;
+	u8 num_amps;
 	struct cirrus_amp_cal_data cal_data;
 	struct gpio_desc *reset_gpio;
 	struct cs35l56_spi_payload *spi_payload_buf;
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index eeb830e3f743..bbacac6bda81 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -1105,9 +1105,9 @@ ssize_t cs35l56_calibrate_debugfs_write(struct cs35l56_base *cs35l56_base,
 					const char __user *from, size_t count,
 					loff_t *ppos)
 {
-	static const char * const options[] = { "factory" };
-	char buf[8] = { 0 };
-	int ret;
+	static const char * const options[] = { "factory", "store_uefi" };
+	char buf[11] = { 0 };
+	int num_amps, ret;
 
 	if (!IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_DEBUGFS_COMMON))
 		return -ENXIO;
@@ -1125,6 +1125,21 @@ ssize_t cs35l56_calibrate_debugfs_write(struct cs35l56_base *cs35l56_base,
 		if (ret < 0)
 			return ret;
 		break;
+	case 1:
+		if (!cs35l56_base->cal_data_valid)
+			return -ENODATA;
+
+		num_amps = cs35l56_base->num_amps;
+		if (num_amps == 0)
+			num_amps = -1;
+
+		ret = cs_amp_set_efi_calibration_data(cs35l56_base->dev,
+						      cs35l56_base->cal_index,
+						      num_amps,
+						      &cs35l56_base->cal_data);
+		if (ret < 0)
+			return ret;
+		break;
 	default:
 		return -ENXIO;
 	}
-- 
2.47.3


