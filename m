Return-Path: <linux-kernel+bounces-777718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CE3B2DD0E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F111C418B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AAA31CA68;
	Wed, 20 Aug 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="AXkPwHwx";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="YnykARnV"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714931B13C;
	Wed, 20 Aug 2025 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694280; cv=fail; b=RKopIndMGrFe0Sdi2x7LIT4tuBnxVPoMt7EipgV/ODq6JgGTMWkx4Fez5ZF/sb5HJGSZU/atA21cW9IG5BOmkNSghHQkkZHD3cRpsURrunB6z19G3Kyfd3ePNCSG60Kt1joxSvrf7uxrlg/qh3FkWbufS6Ac2TeA7G9e0/OsfwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694280; c=relaxed/simple;
	bh=kdwLCZQTIMkVc0Bn7KI5sVGltbZVw/4EerC2nkJgkuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SRXdFrv/VcbF7SOrJ3eVWcff0+ASWcCVMyxDu+Y7jU7MGK7adqvvd7f8hcyDZ4bVTcUHaQOYhunLAAbSeSUY8tjaGqyZ5XDNuceIPhSrt4DT3B8NkILI7wGQ1017Xe0iZeYJI4aY9q1nVQm7LhWwwvXAUSeWqmTpiYAd69Z9fFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=AXkPwHwx; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=YnykARnV; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57JJZFA1732352;
	Wed, 20 Aug 2025 07:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=EJ2H/V6WyOFk9/Rx
	Cgeln8/8uIN0IMu3dvYq77Eq0DQ=; b=AXkPwHwxFrRWw7h3ZyaHn7UpBr8z7dg2
	0iBXruU4V95cGi1soOj3vf4IqmUqSNqzhUlcepk0QGFdipK47Udiyrqi4rdoOKn+
	LljEEaIWxIA8T1gnThiRTcdI27m06gSl3ZeqbfJUZn/kzRZrlbVVBKlQjdien/Ry
	Cnv8NO86ynBds4a+7hnuSaA8Lm0RreabM2xu+rkXXkENej2QsuTGF81+O8+RDDV0
	o86UDq3uwq6IMBwl/AznV7bqBZU3DyhC87U8n+AV64htDhIWDohtcHXwy3MpxBhO
	ci4v54tHeWINu96pOKAAldBVMNxrHKEXtRAmxpGfLrZYwD1PUx0kTw==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2130.outbound.protection.outlook.com [40.107.220.130])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 48myd597dn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 07:51:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDzl1f+ds0mLLLrc9NYNUMcMSDcZJKTWHd3PoYWELC3npY4tB+2AX/XcimVrBKPP0o08v/N8f/fjT3nsXdqNx5UG0wEa6hQZ4pnCisLT5BmQx/QfWkptpKkRccTkVi9tVj9wfK3S9k9hSxe7HA+/dZoz4btgbxl2fTTw06C6rzpV+SBbJjjPQ+Kq86m9BjvMIkYXtYQ4MVseSvHWBK5iwqGI4JIxDUG59vQCfMBWkCPg24V7XAxCwAnum0h3HS+22Jq3euW5IzXt46EbgUf0rdUKdUSx75pthqgkDGR8OJRg5kiqPLFatko5vwsVmVguyiZ8UMKifUo6aLwX22Fugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJ2H/V6WyOFk9/RxCgeln8/8uIN0IMu3dvYq77Eq0DQ=;
 b=xpSSnS+u1IQuHGHRSvEer8YvurFLZd6fnJ/dHw2GLLnMYU1os12rgZEnV9ynUdqh9aHJNcmAbGf+Qdl7DrUf2KZUSYO5feyMMEadq2O+4dCqjWMjthanghLLkwjUgMcjO1b16yvOTA8uV4WJLqpRKP6IQSYyQQ4RWEM/0vo/q2du1d3ye74O6oL4O+lGkDkQm+ckIWiJ3J0mW6cwvZeB3DDvhULKHCPJHAJo1kk1DEhUVPJY61pT3wzJlLCeLlk34jZKJx0c/uzQwXAjVwHK9sWGg8hB/eZtyVBHCwVnKKlsHuvHM/1vJD9Bas45jH/MHhHhJ9NTohgPBvcKlYyPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJ2H/V6WyOFk9/RxCgeln8/8uIN0IMu3dvYq77Eq0DQ=;
 b=YnykARnVOPmrsBh+Bj8ZIDGNes2ixLn+ZbGNFxrXmbye1WfP6fAnYc8gJfDFHr2yoCTBergl/bnsI4rqoyVrUM3qVQy6a++H2gbYLkjN38l+Uon9g0x1IU+N5i8GcocgaiGx98KWfTXp5ztbOPMZw9NVQYUb5z4NG5z+Vej5S50=
Received: from MN2PR16CA0038.namprd16.prod.outlook.com (2603:10b6:208:234::7)
 by CH4PR19MB8772.namprd19.prod.outlook.com (2603:10b6:610:243::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 12:51:01 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::89) by MN2PR16CA0038.outlook.office365.com
 (2603:10b6:208:234::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.25 via Frontend Transport; Wed,
 20 Aug 2025 12:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Wed, 20 Aug 2025 12:50:59 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C67B3406547;
	Wed, 20 Aug 2025 12:50:58 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 957BE82024A;
	Wed, 20 Aug 2025 12:50:58 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 0/3] ASoC: cs35l56: Fixes for CS35L63 for production silicon
Date: Wed, 20 Aug 2025 13:50:33 +0100
Message-ID: <20250820125045.117740-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CH4PR19MB8772:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2267c9c7-db9c-4d68-b0ec-08dddfe836a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|61400799027|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c/hFdcUZNOS8PSheL7NwOtC5c6USPsomf5IScBJVF2n+ynPTTzjsNECdpEBi?=
 =?us-ascii?Q?Fkv/N6vUFGT5UFU06Asq1zu/AwcOQmiJhk/TimpsqCTO9EKjvrd0n0EXo8vO?=
 =?us-ascii?Q?YGT4P+ottNKBkmbqvDMcEMIdsCIehlPY/wQW8lM7YZin7G1daa8/rBJ5+N7K?=
 =?us-ascii?Q?WvGrI5zXWowwUiWkNEwwH8Rcl1Stcy8IODtlxyEXQzr5OxE1KzIwCgwpBfRm?=
 =?us-ascii?Q?HPzzjMekxIkvxUbs7botdqBvgn26UAVqQ4veFsjMCDyLrHOs3ahTExaUtTLV?=
 =?us-ascii?Q?Wb49rNcJkKbrkUGQunqE6fUkPs51zVc0B08CP202PDoJshbj7LWMjp8YLdv2?=
 =?us-ascii?Q?59YbcVR7IJJ3Y02dUyu7wuwi5x1WirTX/b/aVXh+Y3iz6Ax3hdsPMi755nvG?=
 =?us-ascii?Q?4sXbj3JShDj8nRJpgiuEp2Q89hKIm8kiz3ZyGwVdZBZf5f3/CHgRKXkbi8Ww?=
 =?us-ascii?Q?OCT/9QR52pmX5r6rhvRVYuuyLWfx8nHVudJehNETudzEzRiNWKcACJDZrU1I?=
 =?us-ascii?Q?AEw4i03X+k0KG1UQ9y3Qkw7nAyldRnaiecG7Feg/B+t4/74SjEu2WWOtfFdQ?=
 =?us-ascii?Q?gZtpAeIbp0Z+wdpAmpRlAgAUCnwQtYR9Iil5/ESBYeQTtAIov/EA0V+blAhA?=
 =?us-ascii?Q?zHNzpOpeVIT6VkWwEMQW01eSeblyVFbv8D06QBjBr2fgh80eQUvhTIuG8Nbw?=
 =?us-ascii?Q?ITY8oq1CIf8aQYSe5xvpmBEAn726H5HhGlnAD7Ir0SZxeekQFI5ufn+gjH9H?=
 =?us-ascii?Q?75boCejEXJJa7czT44/gSLnueN5ZOGaYqht1ZgLkOANndU9TWm8n5wIqg6hk?=
 =?us-ascii?Q?ogdYcoHAo47kTWBfch6p1fz7fI0b0Twy0h2tIZffpDzBjjkTiGNWxYu6QyVD?=
 =?us-ascii?Q?paWUZLFAH8/PSoMdsDydvvUaqvaHx2qrljeGZ4TBnUgHbs2bcO2RG/7OH6ch?=
 =?us-ascii?Q?sR1f0EbvRPkxfqCiA9H596tv1ZQpVSp+JxjjP7IzIRonZB0M6La+0H2MoIzC?=
 =?us-ascii?Q?SWGQdONO6GgRmsISShwZV4ddMdnjsMQ3be2KRceivkAL1OUEZO0Ocjx9ZvwG?=
 =?us-ascii?Q?4SEV6v1uUqKXg6yPgLf8UH5RCu2/r1Oa+RshPKbHO7qjQFLw8Ib5y6rv41Xf?=
 =?us-ascii?Q?gFKnVkuflrQkZQHi3FLpZpbG/YYiBkWdacK/VYePLotvqhtVofC2jRn8g8WF?=
 =?us-ascii?Q?5CoTg1Oeq0+X4A7YPqm/KkFSDxkmzWGJeWmZpxRfd33zdnNhR1nvV9/OBAHW?=
 =?us-ascii?Q?HEn4TJr7JuVISYr4c4soVkSeMdXAxGmx+PGqrQg6fycWnqFIMw7lY4wrtpVw?=
 =?us-ascii?Q?VOCvbt/J7I0ujCQ3CgiNrmvo7nFF4LypGUbgapKV7QAztOuusDpJq0itrtr9?=
 =?us-ascii?Q?x5RzR9JhuUR4o9+FkDKc+n7U3PIbRvIxe7JbXFzYn/Dd+mJflDcLUaBoiQ8S?=
 =?us-ascii?Q?AulSs605igZ2rmFBjzwoWQf+3/9BaZRfWPX25LYEpBYJq4CUQ1DXErB7o2LR?=
 =?us-ascii?Q?+KQM7IfczPCSyOzdNClfEHnqJoDujj1QtRC8?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(61400799027)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:50:59.6840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2267c9c7-db9c-4d68-b0ec-08dddfe836a9
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR19MB8772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDExMyBTYWx0ZWRfX90Z3QUixqIBo
 FzRYPAT2ZixESg/iEMLcv27SK9JJItNbQFU21XvDCzRXJIXhtlO94ozIIP6E+rWfajvxcGFlXuk
 0eYxRTqfKm5tnz2E8pbRavNJtFKZGLfCipeaBDtvDrrpWNEmZ9SVrMhpnH0SkPq5cH9Lw6eeJcK
 TNf/q9VT/HoIG+sEsecqL7kwjUUUKPd8gHT+UAAxy2guHkAYhNJV4q/iImMChGiaI0H8cm7rAfd
 hL3Ko8WIR3NQlx7+y+wl4aCELKtwHMkvgwM6HJt9qnLsB412hTq3aLRAJ5mOwtVd84V1wY5ddKx
 WF5jZchOh4o5vr5xzXlB5kjNRtQ0ewmzuIY6ZHeUKubu/cKXRfT3TtfytfYaM/KE7jFAMt53LaK
 h/iHhdFE3QTWw0HhAzxKLfUD/oE6FA==
X-Proofpoint-ORIG-GUID: na_t7HcWhiAltkR26zk1_gs2mgsTNRfG
X-Authority-Analysis: v=2.4 cv=EpWLbScA c=1 sm=1 tr=0 ts=68a5c4bc cx=c_pps
 a=jBEHeNYf6hLE1JIelm5fYA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=pupxUiop5PrUMPZKw3AA:9
X-Proofpoint-GUID: na_t7HcWhiAltkR26zk1_gs2mgsTNRfG
X-Proofpoint-Spam-Reason: safe

Production silicon for CS36L63 has some small differences compared to
pre-production silicon. This requires small fixes in driver.
Update firmware addresses, tuning algorithm IDs and remove soundwire
clock workaround as no longer necessary.

No product was ever released using pre-production silicon, therefore
there is no need to keep support for it.

Changes since V1:
- Split V1 patch into 3 separate patches

Richard Fitzgerald (1):
  ASoC: cs35l56: Handle new algorithms IDs for CS35L63

Stefan Binding (2):
  ASoC: cs35l56: Update Firmware Addresses for CS35L63 for production
    silicon
  ASoC: cs35l56: Remove SoundWire Clock Divider workaround for CS35L63

 include/sound/cs35l56.h           |  5 ++-
 sound/soc/codecs/cs35l56-sdw.c    | 69 -------------------------------
 sound/soc/codecs/cs35l56-shared.c | 29 +++++++++++--
 sound/soc/codecs/cs35l56.c        |  2 +-
 sound/soc/codecs/cs35l56.h        |  3 --
 5 files changed, 30 insertions(+), 78 deletions(-)

-- 
2.43.0


