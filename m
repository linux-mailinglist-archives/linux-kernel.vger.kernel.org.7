Return-Path: <linux-kernel+bounces-806280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308A7B4948D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC053166B1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEAE30E0D6;
	Mon,  8 Sep 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="d8AWQ0kb";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="xGyz/Okj"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCA621171B;
	Mon,  8 Sep 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347133; cv=fail; b=U3X/jIUUNtGHuDIB/e7HSEx9AEtDlItIh9A4dqnbURJ6qebqMP9C8MdIMJLpFONGw/9SF8wUSnebOY3JTlf/Mx0odzoiiXsL91Dpv8/lnBiey1g9fisjz2RAEgmqCZbU09qietaqZMXYtIUp05RESHlrFuYdPh7IP1GV9ef/UCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347133; c=relaxed/simple;
	bh=omnds95bhwKrBEAgDAzl1+XqY37kHlQFv7FF0Nm9cMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IucmxfqRMoRgBusPlYtvfRX82GJ3mmrZqbevJQO1cvHGPuBoiOcYyYptEs1wMiO+Th1FD7PM0mtpWnGGxhAjXACwxrnFU+ny7P5GPWjh6e3JlqAGfdYODx+gTzbzsMvAMWvPByIobYaSN91LNOBRqXuRYCoYI8zS6PcOdatWCsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=d8AWQ0kb; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=xGyz/Okj; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5888UUxW2151922;
	Mon, 8 Sep 2025 10:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=UIdtVwSk/Nop5MOh
	InbWXt0pOmH0x/rumrNgC/DmLXk=; b=d8AWQ0kbFtARRtPHXmVnVO1u+vZzT2ys
	xBcM+0vPu/2LwYo5m/JalKT186rByc0nQdGIPgIwfvIB0Vsx4BVGd+ozLwsu29yC
	t+vw9aJPKKWBXbiFgmTZDHGShmaWzHddFyRgjhu9NZhCW2Fx1CvbEzTO7YYOoVLl
	F38r9D+Om/qK2mnFrKIrKKxn50nNYTakVWbsNf6XXH5HD0+lcseAbJAvAGJ8Km7f
	Whk06UyBw4xcgzULneT8SP4NxLt5WhSz0CxB+CM/MJqWEFMo1YbOwKc0mZNYbL59
	9PM/vztoSW4XuRwF3/8ZOtTz5LXQ8JSafCxuJ0SNEN2hpCCnFBJfnA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2123.outbound.protection.outlook.com [40.107.237.123])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 491upq8gr8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 10:58:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgT014IALWiMjNS+m6CbZKS95j85wKHjK4oBnAYdvu9zSOvUyboluilj6yVcIYWJ1nVtSiVAvfPBgS70dZOWBj+GD/ILk3dIBlEgfgDwS+8WswrcnmTZkMJaIE4y9KvY26cImcC0cJ/IErBymHBkLRVUWLWtOTitbFqHfowfLZjQPBW6aBRDob4Jrjil0BtfIQGXSJ66+iwQv4iJ7PuyRYOMoIpVWANsCiF82TXHfIy2diukquJcHMeX3dE9sJQXjN1qCZA9b8MZkm9t+tAOqf9xfVQs5tQtjKnYOEe5DKzSwOXtcAldE1rHYXU6j8AGlYjfDgTfxaCjw6MIC0AvfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIdtVwSk/Nop5MOhInbWXt0pOmH0x/rumrNgC/DmLXk=;
 b=r/VYvKDCgAEzJrXHfABYeVKaxwdRFignF4izcBIRBzQIB4B413eJwJnrof7zVhEG3MMtD1a9XZk1b26Vsyfm+rDzGeRYjiWePaYlrmdnj6lAyVhd94Lws6d74EPPNKRzJ/V2KKk5aRlbIouy52TnMC5gI6BvEujDijI01KPywl/XzkbWSRmbPpcZa4amb6StfmhHL7w4e2jUUGtraJWahJca/523cfyCrjrIFmuCAIJsehL+i8UKUgRLshaVB5QaNNqy3jrZYghbRngn6lP5qM/AqOOcfhQV872kEmCccnH9lB2GkLkQYiWDEsNBFIQ3om77j3sBUIZtVle5bg1OOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIdtVwSk/Nop5MOhInbWXt0pOmH0x/rumrNgC/DmLXk=;
 b=xGyz/OkjHoR5Lq5gs8S83e2/GB/G8p1loV735y0xhCEOHkqPDuiTi4IN/rCYsr0QzlpwR5YliYMGZLBJcBZYJOcExuaNc7dCD6ssG9kTe4LcMlKx+53QaEb2vcDG/XrBkivEVOn7/Txc6kis0DHFpNH3Sh18sRffV7vaoGhtQI0=
Received: from BY3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:254::20)
 by SA3PR19MB9257.namprd19.prod.outlook.com (2603:10b6:806:497::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Mon, 8 Sep
 2025 15:58:45 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::96) by BY3PR05CA0015.outlook.office365.com
 (2603:10b6:a03:254::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.14 via Frontend Transport; Mon,
 8 Sep 2025 15:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 15:58:44 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 80FB2406541;
	Mon,  8 Sep 2025 15:58:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 74250820247;
	Mon,  8 Sep 2025 15:58:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 0/6] ASoC: cs35l56: Handle vendor-specific UEFI variables
Date: Mon,  8 Sep 2025 16:58:36 +0100
Message-Id: <20250908155842.599459-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SA3PR19MB9257:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b13f7811-a0f8-4207-ccbf-08ddeef096e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D694vo+kYktt8XZJFSoCzi5P16OUms675ftnPiJqevPYYksZyeK+wqLdezf7?=
 =?us-ascii?Q?nMRHe7DhepzsP3yHTpPQ0wMuuhC4VkjqaWSkQl9K1NJyAFYg5OW7Z60BklRa?=
 =?us-ascii?Q?fh1FhZwxdHUOQAlH1eZ6A7MInS4zOlQrqEDrMYbEBJG9dX2D97KSArWL7Fqb?=
 =?us-ascii?Q?JeKSsWVoZwypreumKEKoBH2yu5JqAJ9juhSb84BZAQScJIYq0HtK/dqRRD66?=
 =?us-ascii?Q?HE3pr5rkzkpO1jhIDLMyUGle+zj1ZfLwImk9sHAAnSmTb9X7nt/WqgenB6dH?=
 =?us-ascii?Q?kDdwfDUZsgMi8nj+R/io9oWblgch7Pq2Ucj+hqthHiSBH8hK9N7k26/OqsxS?=
 =?us-ascii?Q?s7yEAIOx7LPaWLLxuABaUywt9yVfDGaY5u1LeVUNkmQ/LRbbdfmYhKGlEVOQ?=
 =?us-ascii?Q?gyE2PvzV+/UGru7zEiO8wQlWGfIJezFFHQpYKkS9v8zkgnJPoqSXyVwNzjun?=
 =?us-ascii?Q?h4TNCYCSgSZO+0RcF4jD39T86bLjbgNpCQ0Zxyud9P3WbPwrfssYkA8iR1zS?=
 =?us-ascii?Q?QaRX5fluE0xI3SM1hh5xyN5QGoCDn/RkiS+WCvcXUCfFrMNYx9Z3mCvIjGpD?=
 =?us-ascii?Q?fBMwg27V8eUoFvIAlBHju6rXJSpXcfhcFNjHxBFRpt4AJOWRirqMaV3MY47g?=
 =?us-ascii?Q?yNGwBYdgwEYos1AgkVDE8EtHLB2IuHsz+/jDcEH5w35uhzNt0YiTeBNSmYtT?=
 =?us-ascii?Q?GA6onIES3VxVjXvujIN7RgstgRT2FaBQmtKDbFj2rDDBdsKSh7rR3teYzzij?=
 =?us-ascii?Q?CrCVYEopXwBCIlCrnUkrOVE6WfO0EsHtq3vXUqb/IjV4oOfkCAxQ87q9NnPs?=
 =?us-ascii?Q?V37E5wMRUuMI4TcLtwBelLGGiPg+BnpdYgAfHf3/Xo5HGohiolPGg2D0cX+P?=
 =?us-ascii?Q?cSZEIRaExZIplJxVyPXGRL9xmhwxHfcCMNIpeUPtEE0i0a7KHeuYHpoorQDd?=
 =?us-ascii?Q?bhHGEFrUpmvNgwgE5yG7LnRqX/kXA7iWhQ8rc28YvT+WkymbDmNhfgbqq2MM?=
 =?us-ascii?Q?20hlFXmEsA4rsBzYSl3baT7ebfseZXbnhMoSmdNTvYjvDa/3r6XORddY2SHJ?=
 =?us-ascii?Q?AJL99cGJOrdQ2Q9l/FRCyv7dQfyhc017B4PUNq8Pbj69LrjTUY7ay+fqsAXN?=
 =?us-ascii?Q?E/b9Ku6NEVti7R3aSVTzT0LX/sXG0FRf1gNvq3Hw0FQzmg8CxNi7r3vTmJqY?=
 =?us-ascii?Q?CDbTFke8juRBBvmOsZvmxXT+kMrRE6sycN2YssGLL4ZZui0D/YOwUUgUCOLV?=
 =?us-ascii?Q?gwUs/PVNSFGcvRpEEf8l8borinh/oea7MHHGEZyc5pvIIH91wS7YqCBszg+I?=
 =?us-ascii?Q?BwdxOKWiQkTN0dLAfvkecM2TuuCgNoKX1X3sbuf07pmHdnEAzWvoVJAHM90Q?=
 =?us-ascii?Q?AmTba/m6WrAkHf5ydj0bb0UOz/jgIB/lwOQTsWzKw5YdLtIXbsV9oJLUU8IN?=
 =?us-ascii?Q?3wgrV0k5gOfqJjw3rHGRHA4HAYnAKLsTXLF5MEfbu6qMa5NxL116TN6gzAXx?=
 =?us-ascii?Q?odciUylHNAY/PYG3g9tdwDGxsdgJYoYm0io9?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:58:44.4532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b13f7811-a0f8-4207-ccbf-08ddeef096e8
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB9257
X-Authority-Analysis: v=2.4 cv=DMuP4zNb c=1 sm=1 tr=0 ts=68befd38 cx=c_pps
 a=sXP4CBoXI4FFEMmoTRPjnQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=3fGIzR2kGj_yFl8m2zMA:9
X-Proofpoint-GUID: udXQIuqafZgANvi8-IMOmko1iGVlU0kF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1NyBTYWx0ZWRfX7J+7m3Ke3vKx
 mEx1Vy0W7tWBEFaUesFi8MBrRZJs3RPyuL9kgggTKxbIXf/joLG4npzWw4AMGgh3wWAWUk0upC2
 00c5X14PqTG/Q2s4GDtxtrM5z/VNnuYeVR/pVVP4JvR4pOiaNcxInqwlp/PIuHIBDreDNMIcLCQ
 fUGgRJtmryfAmfCFdVM3UhyOVrdx/abNktnjL9y1Jlb7/EW7M1Nggyi3JfnIYB9HLdza0cyn7nL
 NcwUoaPCXnyb1oqemrj+8UwdgpZVarvntkQ1oKW/n33sy/75XLSlEUZdQlYooKXFYBLkMVummWG
 Tb1LfEk9kxm30yyd2vrDnyYcd0kRwn+Og//CXWWz7MN8KTmwTXxv7QjZCpvoqc=
X-Proofpoint-ORIG-GUID: udXQIuqafZgANvi8-IMOmko1iGVlU0kF
X-Proofpoint-Spam-Reason: safe

This series adds handling for vendor-specific UEFI variables from Lenovo
and HP. These vendors will switch to using their UEFI variables instead
of the normal Cirrus Logic-defined mechanisms.

The model of speaker fitted (Speaker ID) is normally signaled by a GPIO,
and the driver is given access to this GPIO. Lenovo and HP will both stop
giving the driver access to the GPIO and instead the BIOS will create a
UEFI variable giving the value of the GPIO.

HP will also start using their own UEFI variable to store amp calibration
data. The content of the variable is the same as the Cirrus Logic variable,
only the UEFI name and GUID are changed.

Richard Fitzgerald (6):
  ASoC: cs-amp-lib: Rename defines for Cirrus Logic EFI
  ASoC: cs-amp-lib: Add handling for Lenovo and HP UEFI speaker ID
  ASoC: cs35l56: Check for vendor-specific speaker ID value
  ASoC: cs-amp-lib-test: Add tests for cs_amp_get_vendor_spkid()
  ASoC: cs-amp-lib: Add HP-specific EFI variable for calibration data
  ASoC: cs-amp-lib-test: Add test for getting cal data from HP EFI

 include/sound/cs-amp-lib.h         |   1 +
 sound/soc/codecs/cs-amp-lib-test.c | 254 ++++++++++++++++++++++++++++-
 sound/soc/codecs/cs-amp-lib.c      | 139 +++++++++++++++-
 sound/soc/codecs/cs35l56-shared.c  |  12 +-
 4 files changed, 397 insertions(+), 9 deletions(-)

-- 
2.39.5


