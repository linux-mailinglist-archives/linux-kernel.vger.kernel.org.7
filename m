Return-Path: <linux-kernel+bounces-856418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5CDBE4206
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5915C58729C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99F3343D86;
	Thu, 16 Oct 2025 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hbCHPioB";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="MGxCe2nB"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68E3451C4;
	Thu, 16 Oct 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627236; cv=fail; b=GD7vFUN1agfhHO5NSvN46NBOHHuLI8BCfLgvjxal94/dWlMAkWfFqEjHfC98G3GNf99HFQgwTgVAcN2vsUox10GgfJo0k/LF4tNXJGSmD9WkzYPNCS/TIfG6K5xS57sVmTggQodGmyp56gbRbk7Hr8LZUBKjOcGYY2/lTD/N2Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627236; c=relaxed/simple;
	bh=tY7HYVyvuMjblzxXSWgHoXCzSPcKYYdHOovLaiLByTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ca9lHFkzdzPJNPlX0F/cUpGvgFG7jkeo0/NOy0RJoBrOCNv+qJ4x9yZPwmGNL1+aNMUlqaqWUsZWmmt2KshwVfGBVKgo7qFg1htfiQ46KNsNVSH+u+2E6U2Y3qwEKYRZnI86vuiiblGHXxKHIvXI4spxsDFjHHpjqA9bnaztxLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hbCHPioB; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=MGxCe2nB; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDTFLC4017904;
	Thu, 16 Oct 2025 10:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=YGqN8CWbEFQSkub+
	dC9Z2FOxdfCoZqpEq5rfbHx71lg=; b=hbCHPioBI89lOIRtTEOTo06vriwfb/h4
	oo9KlSb3eg3JJKkXVffP2CxVrvVWJF83KFmmBt0zVqqmthJTHqxeLm/ntw++hScp
	ok2wrcO+TVqFfGnlDlHSQtB/6VD/olHRVO6IoCaqGgPOuhKNa6yBn/j2dyMr5ca/
	PugtcipbAFNx9Md7GyMEbCWUCvGWqvTYkr0R7G9Awo+64RXc7dnq9RlF3PFeJmBq
	vtksQRxE3T8jUXNoAzHO8GZF24OGqHYQUTNArBku6UvLtaNtIVPm/NCzyKXh5qJI
	VCidDImaQEKb0mw2PdNxanNM/Q3GzeVY5jUvYoOgFZm+C3eHwSeTHA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020089.outbound.protection.outlook.com [40.93.198.89])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mng58e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:07:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhEOhS/BmMFgawdY67aVcLnp851UsppI1HwIM1XB4e7je591tHuLS2qcQOWDKSidgKNuBH4m+gJDZvH2GD8WU0XT/xDEmUJSfRPjahEpZzyYEEWjiGXI2Y3Da3XM+vBLJ5KvmtvKb/HrV2Kkm9197qWy4EGu+BKVFL1/eN5CSAh5CwDS7I51qErd197xGW8evl/XhH8LUcUdkiA2xkCKMpumgxvoBvNspFmEEnooLhgAMwJZUrScJd0wLn2zv6X+4xbm1cQPWmJo5f/gvfE0vTi6JRjyc+atAoHjaNTSGpwFUBy4S/fgo16lUd70j5z9L9xb+2WHM3UxgYo9g7Iaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGqN8CWbEFQSkub+dC9Z2FOxdfCoZqpEq5rfbHx71lg=;
 b=tfqn+2/WsEk8E0XDEIiRUtfm57UqYV2FmY+6T04sErySXSnX8TPGtQq3kXi09gThsnbFr0/iCNtADs3wPNjjnQk/Xg6zz03SKtiKxjl1VQrRQrgw7msko4u32WacnPj0YI3hcUQzIid4vO0kHAsnTmbzLrBG0zsdMWMxiN003A0UC4DQxKt3DuYQGn5YXkL+713ZFe4EOxJGp42B0pTTYKZty5S1YGccjxgLnT7dmKHk7/dPkqjTFOCmIv+iZEZyJlBDre25x01KG2+94ue4iMEStWCuiLUbLHWf/qpxynoJiP3z9g8K4TAdKQgYds7O3Z21rS8tO4eHYOHz215Y2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=amd.com smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGqN8CWbEFQSkub+dC9Z2FOxdfCoZqpEq5rfbHx71lg=;
 b=MGxCe2nBlrvh4Ip8PC/v02CryqYDyZvW9rMHTuLZ+HUxPLAajQ6mlEVCC3L+XH/+RlMYeo6iysu5bIM2WRDdwJOb9/XQO78AelaTWYLeitPrayxvaZXGm1A4L0bVjPDvrrAqgmqDs++01GGmtX1UGffJ93Xh9ai0MTlGxGfC+/8=
Received: from BY5PR20CA0015.namprd20.prod.outlook.com (2603:10b6:a03:1f4::28)
 by PH7PR19MB5848.namprd19.prod.outlook.com (2603:10b6:510:1d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 15:07:04 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::46) by BY5PR20CA0015.outlook.office365.com
 (2603:10b6:a03:1f4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 15:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 15:07:02 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C25E1406547;
	Thu, 16 Oct 2025 15:07:00 +0000 (UTC)
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 87F51820249;
	Thu, 16 Oct 2025 15:07:00 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, Vijendar.Mukunda@amd.com,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 0/2] ASoC: amd: ps: Propagate the PCI subsystem Vendor and Device IDs
Date: Thu, 16 Oct 2025 15:06:47 +0000
Message-ID: <20251016150649.320277-1-simont@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH7PR19MB5848:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 184e763a-3fc6-4819-4b9c-08de0cc5a9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TcbjFLPORKynfjryfMP3LofG1xBzgIhWRAdyiNg5v+i9ZIa/LUVM+qdj1DBL?=
 =?us-ascii?Q?srGkYxrDbqWmZhHAce3GrGWDogOazo5JAmpLfZ9mW3lG1iPk0wq3QazIIPgD?=
 =?us-ascii?Q?YRti/ABUYFSc8GnCNecAy/GD6UiTfwptxVl1APz2l5H0b6or2jOk4erZ2QK0?=
 =?us-ascii?Q?ZJoiGKQyaCiPJWGJNU6hmPdtWBrDskNy/wYBiKstuTui0N6dehGeJUqMKsOA?=
 =?us-ascii?Q?QmzRp/07D4SsGDmN3kZGZw9t9RVFQRYwrrH9z9nnkB8fvctiiUXJeHOM6qu1?=
 =?us-ascii?Q?xjkM2CLAVgbGGDrpXhUtdpqyNoYZZeLpgkHdlzM2Gi/uIRirUP3SohHIFSIw?=
 =?us-ascii?Q?xiAypy3Qq1LHjlGTlWFeJv79M8Kn8NMP+DBrvPV+CbdXrkjxEHBHAq/WGVhv?=
 =?us-ascii?Q?e87AXtIapg4k9nWVR0Nx/MAB63HARjSxGL5wqnoCm/f87VibVIudffOb9yrT?=
 =?us-ascii?Q?f9A4xyg0RVepz3KcLJgEPpVCcudAubEKcIAmBA1Tgk7ME6efD8DuchvxJuXw?=
 =?us-ascii?Q?c9bTElBgW8XjSPtEz6YlnieKGBB3TLhUpYPFeYbb8T1xF451EOIQIrfpCdbA?=
 =?us-ascii?Q?JP0quiT1yRGINuT4le3YeP87SJitisgHj9IhbF8QXnLryv8WXdmbQi03N75O?=
 =?us-ascii?Q?TdqHqFiWvl2VTwG+q3LPHxCkisUztwj9yj295vHlxTnpgUALrMOSmSrhiiOL?=
 =?us-ascii?Q?VGtX7kodi0R49ECePhmznsfKCEuLSNfMYgz4Cv+pZKs6JbAbyVXwsWzF2S6n?=
 =?us-ascii?Q?9n389Qo8B8I+EomCwVsQtzCdZvyY+UVmMr8ah6dvX4iiND03JpwgCz20za+q?=
 =?us-ascii?Q?bLWGgD3b/3Fk9ienlr5wyEXl7zUVuO+xHeXYrwoaZWriV0Lx6PqBpOWlJ0y9?=
 =?us-ascii?Q?4CjRrH0mGqqdNk8lYUqRr+6dOl6z65snu64OqzeIAc2yKbkhT/S7Y8gwNmnU?=
 =?us-ascii?Q?Jlu8dSnqSmCUeBSfhmZDzD4uMW7Z5kUNS7ddW85mlbx0xZqBy3pmhxqf7Lb/?=
 =?us-ascii?Q?dB47PCw7swdgRQlabOwMe0Od/OaaHobx0cxFDuKk1Z+w1ExkM3TSykDwh/P0?=
 =?us-ascii?Q?UBYIB8pKdxXM2UBcJ5ifdE4jV4bnpevZmV5YST6TNav0e1GygLB/p72wyEo0?=
 =?us-ascii?Q?C9EkXVCuq2jcs2QIDfRV0n4n3bTy0ZRMCA9q1Owag++KtfgoYK1pUBy5iKn2?=
 =?us-ascii?Q?IV7ErgtYB00Pfd7FMaBZ4bjWh+2di6k//galiL7zJqkF6q5LMspfo9jMjpCF?=
 =?us-ascii?Q?oW5bUQ+pDD4W9eUqq8yEuiUsvGePVdyHtBXYa38l4ksW+w0fLobTwgjaAPPJ?=
 =?us-ascii?Q?Xo+weQsUX39PPsxpIAhVfojz1hErVGRf7QFPKu21KKzyDxuESGImaunkV2z7?=
 =?us-ascii?Q?pWnDzvMj4Erf/kteSSTYoB4PvANpl10WIBcZBFh4ek4r3+4Rl8wSb7iyvGVQ?=
 =?us-ascii?Q?YbLjdtl87XZGBXDQPVpJiQHYGv0POVBYIJTTpfmTTAVvazREFOdT5Q8NB4RR?=
 =?us-ascii?Q?9JjOGwkDqRk+kt54ypeW5IT+HhDsCQBUkPyJXSwu7X2FOv0lu1p7EyHEknJ7?=
 =?us-ascii?Q?Rk1NSzAj3ZdnBLvlFok=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:07:02.7230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 184e763a-3fc6-4819-4b9c-08de0cc5a9d4
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5848
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f10a1e cx=c_pps
 a=Im6zT5tXWloa+1LbjvLQdw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JONGIQgQuKa38HGBpMwA:9
X-Proofpoint-ORIG-GUID: TDg6tt6IWnlMz9ZyPliZH9fAwZu54D4A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDExMCBTYWx0ZWRfX6oHpWnojlly0
 +p0UdxB5Xw9MAE7U6tr8zWHu1mA4lTt6sipklYX3ZJ8p4vuqt3dKgGI3Sbb3WWCORaJ5BJUEDXQ
 nLKQWERwwr1nvzsKihmGF6T46QzTQr2Srp5G6bGYHIG7xU4FSpmcEECmS/LYAQkMj8fc2OjMFEz
 czsWf3PmTvaSR7Lb42CG6hxM+7g/m3VpA7bayMoOKJiRu9d5oSHLFgFkZEPaXCPf9YG1h/zcGkF
 wMSZpi43E+srKymigOC8fVluF9B9Q2Ukz6qPbpwi5Gbf5YNdoeu9c0VKff/B8o3vCIwC596e3dG
 srBzg5hpvcRx/DS5M/LkM/J7eM3CKCj3NIfTg7Zlz1nHZN+WIFn0ZAD5hMlqs8+u0mOCdnvRRau
 YmicM6JAmrrNAB+dL7D3G4UHXMYKvA==
X-Proofpoint-GUID: TDg6tt6IWnlMz9ZyPliZH9fAwZu54D4A
X-Proofpoint-Spam-Reason: safe

This chain of two patches propagates the PCI subsystem Vendor and Device
IDs so that they can be used by component drivers to differentiate
firmware loads.

Simon Trimmer (2):
  ASoC: amd: ps: Propagate the PCI subsystem Vendor and Device IDs
  ASoC: amd: amd_sdw: Propagate the PCI subsystem Vendor and Device IDs

 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 4 ++++
 sound/soc/amd/ps/acp63.h                | 2 ++
 sound/soc/amd/ps/pci-ps.c               | 9 +++++++++
 3 files changed, 15 insertions(+)

-- 
2.43.0


