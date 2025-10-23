Return-Path: <linux-kernel+bounces-867318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36661C023EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7883F3ACAE9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3662824339D;
	Thu, 23 Oct 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RqiJstFk";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="p4qU4/7x"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4C1A267
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234582; cv=fail; b=Jy6gjTfh7m2cLPt8XotHLvwfYe3XgFuWFoUeKPOugNz3kNYKOkkV3QlR0TQl3prUBcTtdG+quHSytDr3NLxo6cjwpwMCL4934h1lHA9pU/UEJi6ibGytXplPdUwfUKR/fRAoyEhzMAwMNSJz+/HNFztu3fNQe8jyqw10tvLy5ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234582; c=relaxed/simple;
	bh=AfXWJ33XRs4kozmp1HkJtJQpQOrcgcsjiIlZgUy0HS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n/D4hVsaWRn2LSrQygqtB3Z6Pi8GZFuilrD0T9FfpZww1hQYpnToJTJvP69oIpRf4uv6kW3S4+TacROI6wmD7YWlju2xCdWksX1LpN3D6grPw6EgkzhswLgOxx1PqXu0QWDdpjV5tGgzGxcjOzbuPsQFFUL0QDTxy90U6Y3K/+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=RqiJstFk; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=p4qU4/7x; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59NFWx5U3660629;
	Thu, 23 Oct 2025 10:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=LuDtPk2LdRb4hlwn
	OhPqSYEe9QpueXTkyutdqmYja7A=; b=RqiJstFkzPJR2IzvoGi/IxmGVOqvtm3v
	3JZA6cHyUzsszqZlnUI1O0mW25Ut1Hnyx/9opL8a10OQXfooZtfze2dMaNsD7wWh
	4hRyvdteASVAtQo3iq9A9Xmzrytwc0U8uz49qVYdgKUc2D2F0JpwZWngN36X9IAQ
	cZ80w436oFrGk8tBGQc5l/f8MhCOuveKPwcWNB42U3zpei8hLoIpG/B5OFVZVi+K
	h32nIBB1Q6/8HNaNzde4FjkMnTPcALbQ7ovt8M2uoQPgt90R5MGDsp/EB82BywA5
	aTY1biyiCVBaw4GwgYrjmvslA5bzVsmA+3/oTqmKW2W3SXCO/sZmTA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020129.outbound.protection.outlook.com [52.101.201.129])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqtfp5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 10:49:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg5TFj9/hKLjSPCpW+/Kttm27qwf3flRUQDPI3Tz0zDJ/ID8+X+PBkiAkX7XQCzyIxe91tP3/8WvZPDedsiVh9Fovi+MgG8Imrlhm1gAcE/JYlfOBhgKrR0tQERCMUQpt54BZy4xY0VGc9vCTezrE/ipVTgTwYDoTGZI8NxarRub7zIYavqZwH0do7+mQCjEVzjY2U/yV6cY6WNAQQ4H1zUdOQCDM87z6p1JEbebU5ow50DJkuG2xlSpzhLw9gU8/ktZc0k0BAkkTJngf7RfeqE6DUVXSGrKQwB3LnPI0p6ZsC2NY80HNIxfov21jK82i8B7ATLpLVOGqzmOYgYr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuDtPk2LdRb4hlwnOhPqSYEe9QpueXTkyutdqmYja7A=;
 b=teznebSgt0i9h51RIHAGx2bSfOkgSbFMLf2RaIt5FhXWUiSU6Uq3yimAdOPU4fmWQh/HBLpbQPPCjzlUgxIAhXCkps8rGFGwK7n2smIwehbICHVYt7mbBJZEQlc/8F36kDIXvGtteHnARhtsCBFKETzlZLOX+VxZ3m57bD0w3IgeCSN4qlnEbC9rhFzwEEfBwrAeb5mlsi/dBTlzq1cfJUVBuHrJEUMF4tPzLlolAejMWXjpnOIAXJXTXxV6M0JNDLHL4AyeY5svUvQsabBYDiZ9sAl1Ha6hznZayMoe+BqbYOlQwFAUSbkvRSXx9xmnliAQTrY8JSJB19+S99kJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=infradead.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuDtPk2LdRb4hlwnOhPqSYEe9QpueXTkyutdqmYja7A=;
 b=p4qU4/7xp0dreYJi7lbVsF+EJjXJFIoK/+gt27bUSX2u9/DJMiJWD0Vk7SxyHv81EuNGNU6/DiTUFsM99RlBxJfd/HFScRMknpgk50eAQbVsYreo3ylpQmnVD8ojSZiYbThxHqBHVZKYfkIbzYEpsWlsiDGd+emM55eFC+DkJ2Q=
Received: from PH8PR02CA0053.namprd02.prod.outlook.com (2603:10b6:510:2da::24)
 by PH7PR19MB5968.namprd19.prod.outlook.com (2603:10b6:510:1dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 15:49:08 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:2da:cafe::55) by PH8PR02CA0053.outlook.office365.com
 (2603:10b6:510:2da::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 15:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.0
 via Frontend Transport; Thu, 23 Oct 2025 15:49:07 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id ED178406547;
	Thu, 23 Oct 2025 15:49:05 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D85E7820244;
	Thu, 23 Oct 2025 15:49:05 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: tglx@linutronix.de
Cc: peterz@infradead.org, broonie@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Fix some accidentally dropped IRQ buslocks
Date: Thu, 23 Oct 2025 16:48:58 +0100
Message-ID: <20251023154901.1333755-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|PH7PR19MB5968:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1a27c137-179c-4d12-1ae5-08de124bb37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BnfuV+FqZmhtMcyt3BZBZCUN6A08R7ukTL3VdgEXmYZ0ultnBUDeJKAPZcu7?=
 =?us-ascii?Q?Fq/W1rxS8mtyStCQbC/OcJ4ObhMy/wez++J5NoVIAxLgWugPoeJPh7kbBlrb?=
 =?us-ascii?Q?L9anN9/rjUVLPopXlbZWKXj1kNl9FsmPsJihyAgPiIDseVdlO5S6ujagym21?=
 =?us-ascii?Q?NChAe4v1XsLbyCgxWMB0CgNwr8Z2MhSqjmmanTHF3wJV7NhZUeAFHmzHooyz?=
 =?us-ascii?Q?fGQnUrt2Dpxjtu7vUqIvuoZLQEaaOvlZxEYoYBHdVgFfMMOaNf5vIwKnH7O4?=
 =?us-ascii?Q?Ye41EgMI6AiH4gTfj5oED/oRfbFz0ZvIDRVUFH62UMMCc6gGRiwUe+Qari/L?=
 =?us-ascii?Q?Ls+D9B3F+8OZqkkwqCT1r4/VCa+srQ+nDfyeNR8nX9wpvRb2nxgg3XeaUn9t?=
 =?us-ascii?Q?6ZKZDImxGAOIH9s2IuV8iIK6db3kE9rp8QBwkaXZzjfHgSeuZWRhlUn6rhJP?=
 =?us-ascii?Q?TQggY529LrtZTLi+q24G8YQ6LTWv3GEU2kKNYyhzY02vLyb5GEapTuQz2kgi?=
 =?us-ascii?Q?hg2oDXivfhtws8GEznQp4Qxb1hn1LZSCHqMmFsezd/WY7i+rrU1LZ501UNGx?=
 =?us-ascii?Q?H1dzAQa9prPtrpFE0Rpl83LR7y4UtbLDSEyqKR7vtEtPvgIGw+mD2LXIDo6F?=
 =?us-ascii?Q?F+YF4OZ2IGKZJLkBeqoz6t/gFVqctUOgHISv36z+Joi83BttFJZOyFRGXY4k?=
 =?us-ascii?Q?GPR1httg+/gAAdxYL/5JPRonglGW1vr7koaB3DVDhmgtfmP/HCrGPTO/nRgc?=
 =?us-ascii?Q?oWid+Rv39rB1w7+LRkW5x8N8oghJ4ceIjag7TGMIXkg1tBcHFbsDfEEhW0In?=
 =?us-ascii?Q?oelmnwhyP4ME/6g2fydFnxVJzLHNezpDm/MsAGItyGJRK4DwY0usY04Ja8C/?=
 =?us-ascii?Q?BugOHB4Mj18GaH5ggcyjQGkzX/UoTH6nnOwuC8vz5WStn5Zhmp8RoarOeaqS?=
 =?us-ascii?Q?FmNzCu/C0tP1fZmEmI7tLCP8Srjd6VEKCgfpeYUWOyUaX4iPyzuDJYan/ABi?=
 =?us-ascii?Q?MEizcrLz3RtqcxsE6S6Ujex4/oh4M+K7ODA9WW4kqlf+dhJOFsqyj0eXhOA8?=
 =?us-ascii?Q?485BvACYEDk0wv4WBDIdYwCnp5uPSL69K5H5x2kRbLOmpLCstBLdjz9UYem8?=
 =?us-ascii?Q?J6bGdgAe8FWWPa00GyfvADJ5qR5/HPuQtacM+1VjqEI2oY7ueCzJDSNao+kk?=
 =?us-ascii?Q?zd/4aJmzHaB7GS/0KQgR0euDdavJbN2jlqQRjuIRxTX2i+aQAFQQ1767QUJy?=
 =?us-ascii?Q?C+F7o58wVjC5pzY4ZwE41woZpR0svzqaT7tSRlFU7LVX9mTtzfeo5+WUHqWo?=
 =?us-ascii?Q?2xGj7gwUMH1eU13xtSVQp6UTPVp46XKNiYqAGk3c76PnP8PbzEA03VlbnF+s?=
 =?us-ascii?Q?4Pzh4R8DEkAfBCdlJOgyKCrfSFoTeVE5O7BSk/6gmDEN5MP/tPvCmlMGmtlg?=
 =?us-ascii?Q?z//LYExgnLG9Pngbj/txSpY/b3VD3Vu0PueRvE7pJitT1wV7eGTq8n1XgA7z?=
 =?us-ascii?Q?w8vSZpXJJoa7Ser4pEXxUTdIMCs6MERC3bmW12YQElgcNUusT2suqjDvYPIX?=
 =?us-ascii?Q?nDgBBFWbe3/M9dzJECA=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:49:07.3108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a27c137-179c-4d12-1ae5-08de124bb37d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5968
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68fa4e79 cx=c_pps
 a=ZUzg8RnVik1YVJD3af+61A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2vB2vCwgimYRsxO45bcA:9
X-Proofpoint-ORIG-GUID: otS-W7tizCUi-9HPdFcTSAeSYdpjuDvm
X-Proofpoint-GUID: otS-W7tizCUi-9HPdFcTSAeSYdpjuDvm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDE0NCBTYWx0ZWRfX39TuaBc/MFpa
 RCl67puMDocU5x6nY9D6s6XNo00lYllQn+z5blkje2HHaxquS0gYMcFgQyiQOcEF0OsM6VswPIV
 P8bZcpWAVA1l5I9iD6Lp3LSGY53RQpMdZ7H/7mTwiXaSj7Fo4FczMvWTApQ739ovX7LZeMxaoyN
 DJCUtGiKSBOFEuRWBC0hZ5RsQf54/dvLxsCf802rgqN33xo2O5un/20Fjo60gB1kaLB8jls1+qJ
 n319/9d4qVTxUbO2bQZ0W4erDkUIARnfcoXsMkzq05U+Rvx57r1ALwD+d0N33DHNvwLtdn0ZmmQ
 rqsGPerGEcVkDnYdVRYtT+n9QvIi8rvZgHLc/DvztBK5qJP0YptoNBRhBTz127QbbUFnpm6oYM6
 agbKkQACCLqwmhjg7WvrwK8xq6Nb5A==
X-Proofpoint-Spam-Reason: safe

In the conversion to scoped guards several buslocks were changed to
plain lock operations. This causes issues with some regmap IRQ
operations as they rely on the bus unlock to synchronise operations back
to the physical chip and those are no longer called.

Thanks,
Charles

Charles Keepax (3):
  genirq/chip: Add buslock back in to irq_set_handler()
  genirq/manage: Add buslock back in to __disable_irq_nosync()
  genirq/manage: Add buslock back in to enable_irq()

 kernel/irq/chip.c   | 2 +-
 kernel/irq/manage.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.47.3


