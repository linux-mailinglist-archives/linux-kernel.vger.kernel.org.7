Return-Path: <linux-kernel+bounces-808004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBBDB4AC09
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0043A9682
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371F532254F;
	Tue,  9 Sep 2025 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HvC6t1wE";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ef9fvWIC"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926B2E718B;
	Tue,  9 Sep 2025 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417452; cv=fail; b=fDAm9Bqj9+5LtP1muXTP/cyuQoF8mNkNHVFPYR+th8vc7JBqWInaYg521VsEM69JzySVPMPRMPxWkkTRHkXIQFJBAGvtjxZ/LjkTwcxWu8resSXiFAcw+T6Xb7qJuYMdepu+nXFI98i5ObreHY75UL6RHnC/YzorShRoFfXm0EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417452; c=relaxed/simple;
	bh=UY/tSK4frnrXxrs5I4tzqSGtv4jJZJBS66EV4gPtdQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V9fL+OjjpWriHKn0J8apHT0KXye3hZ7bI17ce5wxHBuoBoLdxZ0tlqOE5tcC2iGfmEJv7xOSwL+4EH0OUSmb1fGpgZtP84GiwPhIUVR1DnO0gRSRxqsTQ9t555QSO4wM8LZMZLpMgy9xtBgEtWzEcw9PYzkIO8A6wJOwFzcQjjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HvC6t1wE; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ef9fvWIC; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 588KSv901252531;
	Tue, 9 Sep 2025 06:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=aoRcLeQufLfM+8b3
	k6KqPXr8lELpncYa6xniGC+SxHk=; b=HvC6t1wE55Lzq6FwtI7MW09ED9sNPKpB
	hh9uejxAeg8dmQ7YEngLc2zVPoyrOeb3SPu5EErLfVqNv/+fq62Y/eaMaZt0kdk8
	JF0tYPCUGdqdChPelFv8LTXC3HUoA75NF5T9ODic9QGJNrGhef2UBuydN/dqN/Ic
	YfcGXk6VKa63rbC8XRzpfvwgyzaOl+Lx+GR0c0Nnq1SOnCad7w4sLiGYbWrqUdeR
	S8KmeqrZZnmgWP3FG/mYXO0YCvBhBqEYbRAC0ezETH7IXXibr5II87j0Bal1WSIq
	kgB9eS328hJ4tCB+FM+Hh9E9VyOCz+6B2NxKzCC0z4IQvnmJF7ffAg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2131.outbound.protection.outlook.com [40.107.223.131])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49227r91wr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:30:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUDSUpBb03RLIPvbGYH8LdOMfDKhmPsDtjWxAuk1+sX0WWbiLHiGP1QUMy51xAJzqOOutbyrfkEDDwg/GzvyufGA7YTKwfgibqQRuGoDpgLXpKaiklR8YQzaiUDi740nyT/vsYwXeLXWI11f4E4pEsqGPwGxdVMY4EN/0gnHBvL3VTHhMkYbYcoOxuKmwfd1nUlRYqEWKbs0J0VE+gxTQDJl5p/0jAPev+Z7VOeY+Gvs6a4EGhdNco66SfmHwfd9BCmYzcGKehwrSz8W3cKqXdqtkq2B+Pm2hWiBUZGoFk2T7eYwyiQajDz6jQDmPOkemSyROHHp041h6rXm8bwN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoRcLeQufLfM+8b3k6KqPXr8lELpncYa6xniGC+SxHk=;
 b=fzy82UIkpsIZqejiyEe3mRjaIiqnu9CWZn4YBfpoq5gbVP3gG6Z5va4ox/KpJ/S5RqIIKuHm6w9zzyqKjf8QcVEGHMw86fpxxe1rbKaVgMckDvyforji6HIPVHLiYDJ74G9Pg5u8l/A8kTqIRMf9oruaZXt2j588ybBWWAiQ67iHfPwYfJ3VrhHqL0HdVpazHI7AZJNnLwsFCLX00Nwfe0wmrBgtIwKsxxfmlyOneLdZxRIiBuLHI6OmhUXt/w5kXNzCdu13yVbdvnzml4TwGiqzv+K8M4coGcRnh4KuDrCp04ek/NEhD+v4WguhyXe//rC4gFSAfpFNTQnZIOZWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoRcLeQufLfM+8b3k6KqPXr8lELpncYa6xniGC+SxHk=;
 b=ef9fvWIC/gdyt4/Euw8Q3Nv2WiUcKQBXge8HlH5pcp3T2PObDSTCD159Na/nxqBytva9qnxjh1n+agjl+xAjCA0eFTiPMX76alzQAdqxGMKA2xsAfjdpiw0GH3jHBJc+9gm6JQikVDAXItLpC9VEGX5ZgllsZwmZWSH7N0sPYOE=
Received: from BYAPR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:74::32)
 by PH7PR19MB5799.namprd19.prod.outlook.com (2603:10b6:510:1d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 9 Sep
 2025 11:30:42 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::d5) by BYAPR05CA0055.outlook.office365.com
 (2603:10b6:a03:74::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.14 via Frontend Transport; Tue,
 9 Sep 2025 11:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Tue, 9 Sep 2025 11:30:42 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 23D1B406540;
	Tue,  9 Sep 2025 11:30:40 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 0F37D820247;
	Tue,  9 Sep 2025 11:30:40 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 0/6] ASoC: cs35l56: Handle vendor-specific UEFI variables
Date: Tue,  9 Sep 2025 12:30:33 +0100
Message-Id: <20250909113039.922065-1-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|PH7PR19MB5799:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 232e1801-c640-46d8-9896-08ddef944f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tYhSuWlBmg4fx5ARqUo9OGdqkPh/R52i3cX4EBkSdSiLx5M/v0iqBRUiKFuR?=
 =?us-ascii?Q?fXpflLLAVSqxjP0p8qO8i7qHudSlRAUtTH27WvZDmTw6cMiGi/PnrOn7dVgD?=
 =?us-ascii?Q?KWIJNCALEmjextvG305dbSmp//I9Y0eIFOg1x3Gl3dnNVk65x97L9Th+xNoZ?=
 =?us-ascii?Q?ZUT1r3yutMG4sttqUpKtAml3Bc0bJpYpl7igpkgGMMGLkkLcWs05LgzIDpOm?=
 =?us-ascii?Q?5jLJkHkc/Gw81sFRruoCuRfv8w7bDrVJxxFLZO3wRqXvzXC+Q6WIu9Wd/C+f?=
 =?us-ascii?Q?WJ2cGLhNPIib9kcfc92OPqOhGTbELzjms1AJrEJ0zhvFhzP7sI1GWd13MEo6?=
 =?us-ascii?Q?RniAoUxgA66Pe5A/yvNHVUBGx27cLJHYiF4KDWSYdG9iPLRh3gN1043smiO4?=
 =?us-ascii?Q?gJv/1TJpNazjWO48TItpjP2/WtRCRsphFFotaT63Migox5FD57ZdAksxud1G?=
 =?us-ascii?Q?/CSAnufCqUWVMEO0Iy0THTqe1d+C+lIMo+wt2M8oD0bM2W3r7jp7/yKekpm4?=
 =?us-ascii?Q?qz0P84Au1x5smuPdbsvopeZV52yKJBLjTXA3qpx12bgfAkmikbewyMhm6rFy?=
 =?us-ascii?Q?bWEb3iEuw7OdKF0iLfQYpRBtUAA2SeZ/QSsjp1YqC+I0hu3snkSIxDZin74Y?=
 =?us-ascii?Q?TeLsPdOTpuA924yF+9ESCaaYo6VZKa5P3LQMnv07MnFSxB+XgBeJgru++Lur?=
 =?us-ascii?Q?AQTldH+P0ug9c/JaDkkqBYxd7BepQgJ/LvxoSwnPYc0iOaFQtnvsPTY+KCuN?=
 =?us-ascii?Q?k1TwI6J2KyGdmZIUfmac+Ra9eyRZRDIEPo7xmAtucwDmtGfgUaAnNgyKPpU+?=
 =?us-ascii?Q?hd8LEUFmAVZ2Dnh6+scGrP4zHcltmYbDSmJpl+YBLQj/2hjRbhvNjga/iADA?=
 =?us-ascii?Q?Aiznpb8EUfYOfGClkM77kCuxDctHZ3KNzfnQOq8H09X3pFWHflu7xeQB++qU?=
 =?us-ascii?Q?abJxZeevmCChkJvWex/cwl4U7bZAK6DAxenXTdVkqz6DvB+VE5eMMabWRKqH?=
 =?us-ascii?Q?mdPfQ/dIJcfyK6J0fe6Rzg0PlQ+Fm5L4qStR03a1IvkddAUSz2Uzb6wKsGJ8?=
 =?us-ascii?Q?fKGARCPIHlOGN/AfyDgzN7ILOtBu2hfostsfMfmjfc/ggna/zGo4pq995q7A?=
 =?us-ascii?Q?uRbJ/dRKvvwt5k8LKc66rZYKkjkVWxtLNK7iSSmJ+Ci3ODWaPo8juvX6SQkl?=
 =?us-ascii?Q?KiQkHxEmTiRsu0n2J33s9qRLRUpyHzdBK1tGTgXtht88TDM+f0+5mUOZiQ5z?=
 =?us-ascii?Q?HW2dKk7YSZ35gHUw5hGudBfAch+DWArZEbM8lbpzMl7rWTCn3jG4Z7Ued28a?=
 =?us-ascii?Q?gYvnE4cAfyLfrBuxKuDJV4g1l57OvOB7AylUCzL8cNih3F50Tvp0t+olvn3C?=
 =?us-ascii?Q?nZ9U+MsVv+L6OTWSKMnpYLkeITjU94PDXJbmeQKsBbof9ke5isloKt6SPfUd?=
 =?us-ascii?Q?s+oWRv3yojs9ZCEkF3UiaRQRRF6LNrjfCmsqiy2u+wsg5NcLD546ABDedEHb?=
 =?us-ascii?Q?6ARqteAEQZRCUUGpnuV55dcJCdRb8MqjWPDh?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:30:42.0761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232e1801-c640-46d8-9896-08ddef944f77
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5799
X-Authority-Analysis: v=2.4 cv=f+FIBPyM c=1 sm=1 tr=0 ts=68c00fe8 cx=c_pps
 a=1MBqgszBUERISr+GSujF9A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=3fGIzR2kGj_yFl8m2zMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDExNCBTYWx0ZWRfX98Y1J7iITBDT
 1nMeSQDAq2wRj9TIP2YQqpoOeSrhQ22sYM1Q7bTqexhNzwuxcBofEpKkybHUDkzJuBZufnlIwCZ
 t3fhQraJXTJojvdhBGmLQ1qXUiejH+Pz3WyZy6lG7NY6TYpyOtCEdmhKuQJJMgKtVu7VuZNMwu1
 kG6HKgLytYP8f6uJnp5EkB35pZp8C2AfXLrxx0larxKpVIW9kYONpm/uaKs4kd1fUxbYB9BrTWr
 /cBUN37/Vl8iQzMn/r7kya+EjQHdEUC5G6bhRjA3yjKpsIRLIcNd5H5974K3T0KvUhPIrLxGaOB
 RsbkX0pwyhdMf9XQ+sdaBiNvyN/ULEiVe8HRP7elz0uQykATI2LHbRUYA3f4as=
X-Proofpoint-GUID: rJFPy5FuHDBdzUtR9fTbrBRPtqKHrCz2
X-Proofpoint-ORIG-GUID: rJFPy5FuHDBdzUtR9fTbrBRPtqKHrCz2
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

Change in v2:
Removed unused target_uid variable and code that set it in patch 6.

Richard Fitzgerald (6):
  ASoC: cs-amp-lib: Rename defines for Cirrus Logic EFI
  ASoC: cs-amp-lib: Add handling for Lenovo and HP UEFI speaker ID
  ASoC: cs35l56: Check for vendor-specific speaker ID value
  ASoC: cs-amp-lib-test: Add tests for cs_amp_get_vendor_spkid()
  ASoC: cs-amp-lib: Add HP-specific EFI variable for calibration data
  ASoC: cs-amp-lib-test: Add test for getting cal data from HP EFI

 include/sound/cs-amp-lib.h         |   1 +
 sound/soc/codecs/cs-amp-lib-test.c | 252 ++++++++++++++++++++++++++++-
 sound/soc/codecs/cs-amp-lib.c      | 139 +++++++++++++++-
 sound/soc/codecs/cs35l56-shared.c  |  12 +-
 4 files changed, 395 insertions(+), 9 deletions(-)

-- 
2.39.5


