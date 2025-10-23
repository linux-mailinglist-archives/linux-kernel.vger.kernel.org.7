Return-Path: <linux-kernel+bounces-867316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3123C023EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE3D3A63D1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD43723CF12;
	Thu, 23 Oct 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UavvffCM";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="WqWm0g3/"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4699035B149
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234580; cv=fail; b=h2pKoMnAlPTgBTC+Nc21l0ZWMYBHISpLOdnSECHf6O0iyz5r08f1adl0VcRZC1o+17PZGavkPnw1NpnRehLeVJLUiGV1S1STZTn/wSAfe5W44fBOglB+DKin+OgGpQ4Z+WXTwpXezAovw7bLpTLXHRiZnDuajywULzdALFiGlUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234580; c=relaxed/simple;
	bh=Zzox48KG4rSUv47BANxM0QbTXBleDmxK/dvUMpgsNcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7NBVtKDi5bqs3+uU3ZIKv2NLeUF/2Fv4ByKSQ2H08j9hY3TJVFGAzubMjttGOGOLLqVGBGanvykJG6COepvEssrLJeNcvpgyGeUF6iSaPBUAgpB2DUvwpDmojP9PNQnI967tM9isvafppbo5+INGhVyXoFUch+i4v6mnZgNSkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UavvffCM; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=WqWm0g3/; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59MJpH8Z3660649;
	Thu, 23 Oct 2025 10:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=rwqRfjjooqaoR5GvmMTqaxd6CNlHmQ2K6J/f6uquHeo=; b=
	UavvffCMGw3h4kAk0IbBvnuqbvxMafJ+sJ77siL+Lt/+sEWYfdbR84JQs7LEudWW
	bAwKo9QmUstavAQZHksweclgluzYnFg4xs3HJZEyKqhIKMHsWu/0q71wIWlJJfXB
	/L/kZBby7B6z94/WxSsGeQRhOJTh2iukfkEEzyWQDLw6W38SAMFF3XVS2rroPdB1
	ZsIF3WsabeZH8zo6t9QwAs2FBqVgfnAzhkkLL9DHyQugNlbjzQBkXYBowp1M0P44
	Ra0YnzBz07aYIFUd3enH3DeLeztRVZ67noBASNXBS+Q34OPM3t62bqe0AJDAhlh/
	0Zuddiy1jvwasHuhlFU0Hg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020120.outbound.protection.outlook.com [52.101.201.120])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqtfp3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 10:49:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTHqfBw4tNq6kXGgOOqVHnhbMehEsVrvIX4SaGNNHo0bZN2HvE4PH6Qlg8A2WFEVNmjAhETe2RQe+uj+cc34xpL/14ff6Tzs0C+4bZOj2nneaOZoZxGlgQRdAbUI9SozTXTCoGSn42GxQ3SXDjEYac1tae7YB2b95WXvR2umqsLSRrPT9egOrSEnoIXgFT9Z+xX0b/jPd/Vf/1moqTlUh62dYJWyFYKg57OZA87KipWwamgT2FbVi26Bj1fBHTSI/uQYoL8xII5Xts10QOANrhUzDgMPE+B0+daH3hiXilpXpq+wZTRt4Yzc0hrrotNsfZ9mInTHsjEoT8uKqtSn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwqRfjjooqaoR5GvmMTqaxd6CNlHmQ2K6J/f6uquHeo=;
 b=bf3B0GRMVW4NHHUolzad6MHk8EgXJcUjcGz3PkKQ3SIAFAKxfmmJJL6f5MnE6LiE3cO+Pw5pP+QkOyHVglV7/Nz6GKMH1hEfGIPR55sw4GzjnpkXEIv1dT70e4ryJIawj0gxJ9FwWg3KCg11XhLyV804k1rIFtJyADpx8ZyGuenRlcEehTSEThyjeXJmOUNJB/vr259DQ4R3j5l4eVX3I6Y9In3OyNvEl7aLOEDMJWpLwI3lqWOk7VCvXEsm6ntGM/mj2iPW8ib01ZXEu+QCnMKp8hlA3O+bVI2m/iOqHe2k09YM+XqbTfy9eqGf3zECBC6yYWMx+JbJpIu007FGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=infradead.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwqRfjjooqaoR5GvmMTqaxd6CNlHmQ2K6J/f6uquHeo=;
 b=WqWm0g3/oKygCnslL2HLlzzXNyQ+okpApP1kBzoU6CQ57jRnvpGnA8qv3e+/uDxRoHcBotqziSyRCU3evMgYAA1Cn1MuYhdi+2+XJUpbPvZLziB0tX/+igho/kdg6VUnr37QkpyCBgmutiN8aG8ZWaLSFtjFQtTgjvsPZ4TCS/Q=
Received: from BN9PR03CA0869.namprd03.prod.outlook.com (2603:10b6:408:13d::34)
 by DS7PR19MB8981.namprd19.prod.outlook.com (2603:10b6:8:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 15:49:08 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::d4) by BN9PR03CA0869.outlook.office365.com
 (2603:10b6:408:13d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Thu,
 23 Oct 2025 15:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.0
 via Frontend Transport; Thu, 23 Oct 2025 15:49:07 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0279B406553;
	Thu, 23 Oct 2025 15:49:06 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E935E822542;
	Thu, 23 Oct 2025 15:49:05 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: tglx@linutronix.de
Cc: peterz@infradead.org, broonie@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] genirq/manage: Add buslock back in to enable_irq()
Date: Thu, 23 Oct 2025 16:49:01 +0100
Message-ID: <20251023154901.1333755-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023154901.1333755-1-ckeepax@opensource.cirrus.com>
References: <20251023154901.1333755-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|DS7PR19MB8981:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 12ac738a-ad77-46e3-e76a-08de124bb35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/HEHe/x2U3WHSGUrOAthMlx26KYuK2qtJUW6qL87qla/7b2kXSH5tFyv+Tpo?=
 =?us-ascii?Q?aieVLSW5U6btV5u/9j8OcP5moAknzRpm2n2n9tpQYW2TBtHhx/phzRzqq5TN?=
 =?us-ascii?Q?YIX+F7K9W6CVt/PBHw6+/F4WrFGsNr+LbBEAdRqnuINajcOqeMT32h9R6RYp?=
 =?us-ascii?Q?L+yGZmxKo0PpQT6cNHKkZcW7XD6olsMbEaDY6owMre73hFd+Znfb3RsZUwTE?=
 =?us-ascii?Q?OKtexIpIsmdzqjfhH+fBGclTzPP5D4liw3AgHJeOh9vANoxsXkNneP39VnSR?=
 =?us-ascii?Q?/AVFODkKoVJY8qOxUqbvfmzBeFjGGGY2GsvlXRqWXUpOT3Jgb2kNoeOKOn0w?=
 =?us-ascii?Q?cNmfhgHWwS4srQ2PCHOh4ju+3OfCDbSmp1mexu4fwnoobVDOBqEPstVvTx8n?=
 =?us-ascii?Q?5blQLTijRxeITLSBHWagvy0s79ho9x6KSTOuuFJVzrT91h7i+C4/RebHkWkn?=
 =?us-ascii?Q?j/x1PcPF205dgzbUB8SaZKOwwHOzhTAYQlH7LaBdac86bFOC3/hk/3SPRkXs?=
 =?us-ascii?Q?qbQ64WOdF08u5o4JgL/NmsgRGPbu8CGpFvWodOIOC2Xkcb1Yh2lj/IrnRCVy?=
 =?us-ascii?Q?LUtmAUmu9BKrSIjaUKRLcsC5DLfRLtqpEZRqMOEWG8rpOAps2QlglGZah4Zk?=
 =?us-ascii?Q?4e53f6VIpaYKQLaIcKlrdewcA5U0jzoTe1AY/+fYwdoYS4yYuAyNa76spVB/?=
 =?us-ascii?Q?eaiyBFtgx8JWDYgxSW5aS4HF0cEMHYNRPquasLjO8InnYh/PjJ8PDSspJT9R?=
 =?us-ascii?Q?3yhoFwgnBVzCeAUaF3/y5QryVLhxTdQ2WeLC47kfHMFCUOeTvAvriuBXgLp+?=
 =?us-ascii?Q?NZOzNxmAA3LmQ1SLeTA12+4B1UiHvYgDTgGYvvw/9DF5Tt4k/FiDeocGqBld?=
 =?us-ascii?Q?oMUsK+UcJ0AqE4Ic6XZuK3PYHU8Wj1S2b3mIadtkScTLpLVTEMSeCdT8UG1u?=
 =?us-ascii?Q?SlCnOVpZjNwp7Z2eplUpuEg2ZSWTBefq0GrrHn6YOYOIO0BOD1PdK/fKYW+m?=
 =?us-ascii?Q?3+zM00hh9jy5kNAHXBz8RRf2dbni371T6mDBRb08/qBbLxBqsq4+/dg5Me5O?=
 =?us-ascii?Q?NeK4ylLJH9RDgh0g7l+t8ohied2TJZhHlZ9VRIYhYaW6/nviX/Vg28I9A0TD?=
 =?us-ascii?Q?bDDCIarIeMB9+/jRG/wDrbSMLka+SGes7l25ilmjKPQrLhYScKvIf0x+xdU8?=
 =?us-ascii?Q?pkmzUbCWeeRuv3ycHPTu0OONwU+8+dFUtu7nB1VtzkqDSVAfk4rY/w/EKA29?=
 =?us-ascii?Q?TVjgJJYqsRXWjRja7c5hSWNlV8orrI3+cF/4nVLNQHWq8RIFGQCy3SC/fQJF?=
 =?us-ascii?Q?npsDaCHRSztFctsCs2guMVeQooBTor9j6MlOF5vfdd0a8i7QXE/VgsQndaqC?=
 =?us-ascii?Q?EzUUD7kSoQS5oDGF/UjEYHJnN9csnL1F1j8z9DyNNu69BKjt4Fo7NlyZEyhE?=
 =?us-ascii?Q?fi9GYOsev0HjgMqJiukAglgtc/CxNdxwHPPIAPdx3kJQxYoi4LheYDyC0/O0?=
 =?us-ascii?Q?Nu/pGGFzqadmKtuMnUByMQMOUOdQPZZVaz+ij7VjIsVd2vgqArYo/yVv+5bB?=
 =?us-ascii?Q?3ejEeml+iOk3HzVwv8g=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:49:07.1928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ac738a-ad77-46e3-e76a-08de124bb35a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB8981
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68fa4e76 cx=c_pps
 a=LMmQvGl5nJXnC0QjJfdYag==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=QDk8zecZgZoI6ZYqeuUA:9
X-Proofpoint-ORIG-GUID: sv6M-7s0R30yWSpzIjho7EDtH3Sn05O0
X-Proofpoint-GUID: sv6M-7s0R30yWSpzIjho7EDtH3Sn05O0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDE0NCBTYWx0ZWRfXy1WGKgsqtcH2
 I5HYxFWkBSSgjjzCgY9QdWkb3xUVYgXNRugKvSiVjEdzjwBFXeBZxz2iH2YRsuk64ciHnFQ38DU
 ZTyRyQiy7KuQUi5juZLg9eQ86wudrBjdLCmPnhzvM+wY7TavKU1uOr2aTZpjkcZVbDt4S42bDou
 hrnRj7SDQ/XM1G+i70XBrz9313awiDn8ZArmvtqxvO3ah0fF/OMF7mzPfMx+9Le1oJwXbvjuD2U
 sAJz3vkyU2/vz1gGfoXjD+o3NCepgZowEEvNQsnjzOaCkDELDL8mG81M+lqjtJujCRv/7kLvy7O
 kJ3+tw8Ni9PwcQYaBu5b/u56nIuoxewfRC8RcVufdc5J6tyGOQQe1onXyviCzMZZ9Jch0WZIiNa
 CmLsCv1ySHxgelAWQOmWFbySYI1boA==
X-Proofpoint-Spam-Reason: safe

The locking was changed from a buslock to a plain lock, but the patch
description states there was no functional change. Assuming this was
accidental so reverting to using the buslock.

Fixes: bddd10c55407 ("genirq/manage: Rework enable_irq()")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7d68fb5dc2428..400856abf6721 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -789,7 +789,7 @@ void __enable_irq(struct irq_desc *desc)
  */
 void enable_irq(unsigned int irq)
 {
-	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+	scoped_irqdesc_get_and_buslock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
 		struct irq_desc *desc = scoped_irqdesc;
 
 		if (WARN(!desc->irq_data.chip, "enable_irq before setup/request_irq: irq %u\n", irq))
-- 
2.47.3


