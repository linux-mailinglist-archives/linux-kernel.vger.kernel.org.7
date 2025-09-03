Return-Path: <linux-kernel+bounces-798182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693E9B41A6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541D43B02D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEEC2E889B;
	Wed,  3 Sep 2025 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ZMMlbnRH";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="zupPwmE8"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26EF270572;
	Wed,  3 Sep 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892776; cv=fail; b=IQECrQsd9cFB+58vBFeZQhrooQD7gPqvu2uelivDTQI6ji84YfrjHjL0OE1IiM+M3pGIUTCrygxogGOJVO3iqN5FgEnDHJ7udcwehvJOjNv+eOH7iA2Px5MIm7NzRq2IfJr3wAw59VMaKzqeE9qz++VG0CXrUCJDkpxI3WtWNOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892776; c=relaxed/simple;
	bh=zKQi9l0umajr9077TGG/iqjerczNwKWGb3B349itv88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JjZ+65WkH4mLj7ne7CVvNjyAranhwyEynqxDe6NnhdRVJAqrcPQIcWlDrbGh7596qEHFDTf8yxNwY4F9uzZIHneowJHazZ/ujyKXzYM4VVKVI7DzCfnDzd5zxpzztAk5VWYuY9L0Uwhfn3fvuMDdhdfV5yU+jTa5kZsPCQeNbm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ZMMlbnRH; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=zupPwmE8; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 582JWgRA2223743;
	Wed, 3 Sep 2025 04:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=HXMcB9BWn926TACV
	X5MqXyRFiT1q935ZSQLJrmaSU9k=; b=ZMMlbnRH20oPSaTntDVeCoGhCRRViH0V
	Vv7hvkhIfXHwKiBCi1ID1AFUgMykjoiJrlOF8Hmh0PiXoU79dopATzUAVorJaQAy
	ktk6PGq1A2Gr4CQQLj2XU2XTZqQkPDdOdTRwWZuaBo3oqrdVamI/LxL2slbyXtyi
	/Re4GUcyLcRjiFdMt6VcbTxgpuP+z51SfCzZ4VSk3yjpkg6Dj6DQXpVmIDaa+UNv
	cX3O8oVCJeSLl3Gb/UjPFRPkzEmh99ou5BUlUtx5OUEhN06M9csupRlRLUsYpOBt
	/GI6gNiROK8oXGYsbmjw010qCJtAipExDaPuw1k7QbPk16lEyDRRiw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12hn2239.outbound.protection.outlook.com [52.100.166.239])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48vensc6d0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 04:45:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2RtFA3fJ6jq3V3RpcchpB3JqndCl9uCjQx24XfAV1PebWdZKQgpPMwntq5I4P2dsxgFPXW9zrLmqQ19L3T5ULeyXcPgYqJ7+vywvfnSt9QmB9slnuzkq7kJmwxNS3I+cXf8jdU6DdzQf+IrLWqAPP3vSV4ANtTLuKXpQHmVSeXPx6pTvL8wnPFCsjgXpep2bGlVOW9dbZIfhs+Vys7sVZvGAH9I4ft+8gHAoPa9Vj6KPWbfZ0uCw3RcxDTLNcqqh+xW6jn1/zHscoET+z3/VlDiXYdyN5KUTDGuNIB8FN0kXVw/UNZtwweQUjGQ8YVnRzDGcFI478UisGf0oEMwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXMcB9BWn926TACVX5MqXyRFiT1q935ZSQLJrmaSU9k=;
 b=qUy+oKcatZBfp5hPQExAbTHXWR26JivKCPsWlBcQ9Vq+I+TTWP9w4W8q0rQYhZx3EKUDKtnTMwg2Pdc+Eqyy6wyEaZoO31ghKIdIUz9U8HWm1m9tMwr00LXiTtMxDzUYb3XWISuOrG/oBKCI9jliCpVLsOx8l5Q7GIovO03TxIpHPQsRfaqOHNzI7UAEonxVa8sa3kkIPn5Wyp2Fig/tTRnjHtBZhyozeVR7YoGY15pUhXkh6730kYuCBbvtDYW7x+pMNYc5+OqbbDJcMIMMnEpTqMYfqkWRUCJM336CYHHgUkaENUfm39HEtlqb1xnA27Y68OUQtRv65W4ess/FPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXMcB9BWn926TACVX5MqXyRFiT1q935ZSQLJrmaSU9k=;
 b=zupPwmE8gbAOFATNxZoWtk6VGPcbRT5q7xJ0gRQO3wR+62qCTsSwmToAWA5CPyG665HjSHWMiz0KVo5w/LaO62HAku7ld5JZ8lQUMWc+5TPjELkbx7Q8tgMIyzB7Jyh5Lj+o+BNmAzqvlvfTwCd0D/WS9NndfEyZp7FR77Qyr+o=
Received: from MN2PR08CA0021.namprd08.prod.outlook.com (2603:10b6:208:239::26)
 by PH8PR19MB6569.namprd19.prod.outlook.com (2603:10b6:510:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:45:55 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::d5) by MN2PR08CA0021.outlook.office365.com
 (2603:10b6:208:239::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 09:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.0
 via Frontend Transport; Wed, 3 Sep 2025 09:45:54 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 23B84406540;
	Wed,  3 Sep 2025 09:45:53 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 0B698820247;
	Wed,  3 Sep 2025 09:45:53 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org, lee@kernel.org
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 0/6] Improve cs42l43 suspend/IRQ interactions
Date: Wed,  3 Sep 2025 10:45:43 +0100
Message-ID: <20250903094549.271068-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|PH8PR19MB6569:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 205d9809-1704-4a5c-83ae-08ddeacead02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|34020700016|61400799027|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5U3WQUPAj2EYJsfMNMnus2hLfOgJ6KZLARNEHtbBc6i7BdreixDT2cbFYPMt?=
 =?us-ascii?Q?RPTUn6/itGB7TuHvBdeBhgHoYj1dl5Jep9Y072Iy/RzQ2fHi2qda6cqt+Hw+?=
 =?us-ascii?Q?DvVjlT9q7hZ8UX9fuXf7pWioF7GuH3uIxFPj7mm0BSSltrJs8BCf0/kEKeUU?=
 =?us-ascii?Q?iyBx4lCPrx5v4XrJKP1hWingxi+AxIr/TI1UPBBouHCelj6G+Zttcr6u8Fcv?=
 =?us-ascii?Q?HOa+9WkUAF5x3SYLomWqUI8xwWKDwEX4zYfeTP5KxaorMfGcJX/0JSnlDie+?=
 =?us-ascii?Q?ub7rzsY96QFBJNmBJK8Vk1cFrS4gG6tQCiibDQ4CEQUs66Rv7ZVsvEmmy0fE?=
 =?us-ascii?Q?wEnv07A6d7vT8n79W1J1Y1EeZbSpyx2kL2Pfn2a8A0pIl/VyU12HgeCrwnjw?=
 =?us-ascii?Q?WIHBAQByFbfhtkoHzlaUz94iLVhlmIdKfidCSII0Za0UkfnU/bIkypys8S2X?=
 =?us-ascii?Q?Svg2ifhSivt8Berd4ekW8E3RPu4nL32x7eCNvl0CX++bbCDKOGuOIEff6UK+?=
 =?us-ascii?Q?m2EbMfuufsrTvWDGZp/QYN9U8mNtkWqdUhuuJ9d6ZtHYUwM5/v0yxBsVpPnQ?=
 =?us-ascii?Q?euXyUy4rvFZPcXU/DUij37SFZ6SyX9cKj0jmKk6XmEcx5LqiSx4mKrcuLc1s?=
 =?us-ascii?Q?8VnSOpIw/yrUwSgDYiWf4g5TfOYf57PK6XeGsxvFqbbjGqM1eE2OX7Y+akzA?=
 =?us-ascii?Q?dz31xvOwzkot73mAfbRw4493TBvwLN+zD0JV/LcciSYTL9rcMx+5phR8ZSq4?=
 =?us-ascii?Q?wmjStYArZf+ytEskYD7OelI6ojrcLneaN2BS85t9YpiF/Z2ax4Eib3xY9QOZ?=
 =?us-ascii?Q?NWGqM0nRmk+lbkR854NIH4ZUVGjcUzIYX0vaSUJN945TEmGKutV42yDYO2j2?=
 =?us-ascii?Q?BZPy430vQdkcFMkF97MgBlxhlFrzf+UvK1c/MZ0Ip05a0M1xEUMgv9w3inJD?=
 =?us-ascii?Q?aie0+SfetexmqrHDRm6nuzfblnRVNZirB59djHrlJ9WFaEuiq5uKWSAQWVlg?=
 =?us-ascii?Q?n+iYMi8vbfamCN2y7PD/l0LUqTiM0S/6+rD3at4jk+LG70MLUU/uH16JYYOs?=
 =?us-ascii?Q?BJ998cfat2jvD6TJCh9Uqi/40WiEcjEvTqMxHZ/3tQiLvebd5Rq/8HWn1/J0?=
 =?us-ascii?Q?uII7vE/ecI+YAkyNJ1yYJknmpxFw4dGNLuz/cEmW82Kye9ku7bWnPjVmMDei?=
 =?us-ascii?Q?MuIOXOANy04I1uoEvRFORXH0XhAYYuCBTfSfHjmImH8xzOHb0VyU4Z0kIEkV?=
 =?us-ascii?Q?vqhBV7lWRf0gHIfALDJXLJEZTR/hwUc++bjJQ+WzRN8ubrDZ55OftRVoReNf?=
 =?us-ascii?Q?T81edOHmdgEuMfOvgn+BW2uEv2Poy4ixRVwCjGB0bP5jeu/00wXpXvtaKAYz?=
 =?us-ascii?Q?WuagwjyL+Tpc+SiAPlox3yGJjwNkUMfpmep3/nEJf7P+Uy5VtDtH42vY9a1j?=
 =?us-ascii?Q?Q3gcf06+s4leeVvRaVEwKnNdoJDkGl8SzsQJdFy2Fr8gvtZOR2SR6eD0AkmH?=
 =?us-ascii?Q?ArJOeHNR3zqeWytvhDXi9eIM1c9ncaniswsR?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(34020700016)(61400799027)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:45:54.1118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 205d9809-1704-4a5c-83ae-08ddeacead02
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6569
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDA5NyBTYWx0ZWRfX/bdGhc52Vc5M
 LMrdSXMmMhYKZU66GPtq/c3r0To7IYEuITQahCVZOKjDvkZgR7jlhAciHxtWa+qsW8oqMyUG0wZ
 gKiVp++PEh8k2/3c0B1XsspWc5lyMotI047miFFHcLVIUxzJDrwI1Ea9jr1io1YUxJn1oZKqP1h
 rDzCeqtCaQJURTxpO3dPHv8H3ks2IQ6teKxxzozHwpsIbV9a9b9/x55jWsp5h2f9ai+Xtxz5pit
 wNXKQ0QZPTZzY0MvJOLpFDxKRuqnLu0qhGHp8IDr223B/BSE5vUmWVBCbMH0AGzXrIMQTIwk4vu
 p9HjeypftwEicuCK9pt5/6FOP5CtYh3P9Jp/ucEbNaVHDGJc9D1GuGpWMxPJdc=
X-Authority-Analysis: v=2.4 cv=BY/Y0qt2 c=1 sm=1 tr=0 ts=68b80e56 cx=c_pps
 a=QuHjuBYgp6riRNet61434g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=GU5AjF8Zzp4RI5i95sUA:9 a=jZz-an6Pvt0H8_Yc_ROU:22 a=VlVynqX4KLlZR1Cn4-IV:22
X-Proofpoint-GUID: QYOUTqJi2XVRzEn1xChXiAGj94kR3Ifk
X-Proofpoint-ORIG-GUID: QYOUTqJi2XVRzEn1xChXiAGj94kR3Ifk
X-Proofpoint-Spam-Reason: safe

cs42l43 uses pm_runtime_force_suspend() during system suspend, however
this means care must be taken that IRQ handler code isn't running when
entering system suspend as force suspend will ignore that the handler
is holding a pm reference. Typically the result of this is just a few
error messages, but better to improve the handling and ensure that all
IRQ processing is synchronised in before system suspend.

Note the ASoC and MFD bits of this series have no build dependencies,
so could go through their seperate trees, however, it would be nice if
all the patches could land in the same kernel version to avoid the IRQ
handling being in a transitional state.

Thanks,
Charles

Charles Keepax (6):
  ASoC: cs42l43: Rename system suspend callback and fix debug print
  ASoC: cs42l43: Store IRQ domain in codec private data
  ASoC: cs42l43: Disable IRQs in system suspend
  ASoC: cs42l43: Shutdown jack detection on suspend
  mfd: cs42l43: Move IRQ enable/disable to encompass force suspend
  mfd: cs42l43: Remove IRQ masking in suspend

 drivers/mfd/cs42l43.c           |  32 +---------
 sound/soc/codecs/cs42l43-jack.c |   8 ++-
 sound/soc/codecs/cs42l43.c      | 109 +++++++++++++++++++++++---------
 sound/soc/codecs/cs42l43.h      |   3 +
 4 files changed, 89 insertions(+), 63 deletions(-)

-- 
2.47.2


