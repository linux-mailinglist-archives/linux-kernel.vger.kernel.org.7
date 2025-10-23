Return-Path: <linux-kernel+bounces-866560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF0DC0016E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A4084F865F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7595F3009EE;
	Thu, 23 Oct 2025 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="J6ChCQMk";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="tw/P8yay"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A7A2FCBE5;
	Thu, 23 Oct 2025 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210247; cv=fail; b=ADE2+hf3s2D0+HBWwt1TVe7BhwiooPFt7xziQJUBRUCkZGROdjhRBIl9+B0j8WqW4wmtOcSWfGCEusxsW8rmaaOo52z3Wko8BtP7/mW3XCkML8f3b0Y0/ySFC1Pq7GiIYpKW2PNSvucAHQ0jOx9xTRKdCjAVjTZ/BodBiUIa4P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210247; c=relaxed/simple;
	bh=fLMGjP07uSDa9IDmGfGsYYQNWrDGEpmamY80AR4aVwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAL4HGb3q3rG+7pvTsXF/CxxX+fc+mPT+0dvo5ejFJvml8SW32rHwf09OC/EIJ5LHc86+5vLkgfDuZhftSL8xrNEiQuZsLxmZzOH7S5LATpI7bgWvEg2o13UmQdzb7BMcN+XCbVL9u9Xuj2t7tXfOMMhEPEaJ2XTjSOwhIQ/Cms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=J6ChCQMk; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=tw/P8yay; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59MJpHgi3660649;
	Thu, 23 Oct 2025 04:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=oKoBQj6tLeJRiIoS491qEZYxNqgPYIEPZXiMXGwAmCk=; b=
	J6ChCQMkPTh/Utgq54V2M3hCeXV2jerpNuH8x2QkCh+Q47/Aa5yIL10b7x+B5WDM
	bq7yu3pKoQhFfTrfl/eD6A1nTRJ9STuHCEKIZKskn9wGl86cYQjTJP0VEoH+0+LO
	FhrjVPpwnKbQLYS+cqqooX+jimn/Xj8kKSzoTVkMM8Gd2X9JyYmuihnA/etR8mS1
	SMhqzjUQkDRVadi5UC4g9CJ/jq1F7GZSHxVcNGCizn25s8gqyxDJb/U1duFCDiDM
	l9xKuN+JMOlXdcV0LN3sE8RS++DakdTACBWfsgabIno5EvfiqrHakYr1IUYv5KKc
	M8uu+NJ5VTs2PfZKaxDFEw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022102.outbound.protection.outlook.com [52.101.53.102])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqsx47-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:03:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzrldxmMi2FSqwiHo4uoVbjOoqgCDkUZWUTTGlTSAe3zmHTI64nNj7rTPzNVqZtz/bV+lf410BKgxPkdVopqWgvasYRnl5beScrfPd8TUd+pXEMGtnEqvjUZ/b6Cjb+W5T7qJnAC8cBKZGDL8y0NFKdmYijGnMuu1jRHvwMDDupyvloJgQvX+4yID+rkSoCDHDSA0EXqT7XovtM/HwCBPx8lvkWbqWXGh5VxbVrJfhQP9e2debBQIZbpe1iDVKqgTNgWJHcQAP19Fvj2xsis1aGN+HzqU6qeIwObHdK1v3aMxeEjBb4QpDAxbe1WYVe/9CG5lEyUYE0+Z6GAnJlwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKoBQj6tLeJRiIoS491qEZYxNqgPYIEPZXiMXGwAmCk=;
 b=Zy4ts32GR0wXdHnDLJDteTlp7xIVVyHr3nsbfIkZEs9jJngJKtpYZKGgXNwkNsQQ+7lEwxG7eUG99g8mv7kt0zr81w3cLYt4WwtuNyYGhQOflk3SRtEKiocup5G2h2RQYsrWHpO+qsi2NlL8O3J8yqkXR0/NDLvhlXhyanfeSpuAMoA/CsTf7zRMpM4oTEvUw2drrDi1BH8nsyDQP2CIK6rCjqFeezrEmIsU5dLD5PffmTmKRdz1syjj/3UwogOKx4vjQAK3Cr8SpM1XX5mpSBSY8nKwoP+Fq6HR/vBXn6sBrHkjWZ4Z3q5x5XXXK8aktcmT6mgDQLOvgBfjNiX8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKoBQj6tLeJRiIoS491qEZYxNqgPYIEPZXiMXGwAmCk=;
 b=tw/P8yayFyFNa20GicJB13Z7+z5zHj88HQSr5ge2Cp2Ou6P+uJGJwjHJ0EQmjtb6zYUwXqTKAxpyKmdN7SfXskujhWqAlscYt/kPJvaHtD4TrlNWirWD99ysZtOl+1YIovcdZeyo/rkjl1x4Y4esvL2es1v0vnr6fUd4Efow2/8=
Received: from CY5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:930:8::29)
 by CY8PR19MB7617.namprd19.prod.outlook.com (2603:10b6:930:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 09:03:40 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:8:cafe::29) by CY5PR03CA0001.outlook.office365.com
 (2603:10b6:930:8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 09:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 09:03:39 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 58FA5406555;
	Thu, 23 Oct 2025 09:03:38 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 02CA9822540;
	Thu, 23 Oct 2025 09:03:37 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v6 04/12] ASoC: cs530x: Correct constant naming
Date: Thu, 23 Oct 2025 10:03:12 +0100
Message-ID: <20251023090327.58275-5-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
References: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|CY8PR19MB7617:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3b49d24e-f3fd-4e12-8156-08de12130f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IN9HvDIBUk3ffLt8z9pmsPtDlWTRG7GLvlo/zSduT6u5AMFAJzQK7gGh42Hh?=
 =?us-ascii?Q?TOL39SJJAUReVy+bDMQGGuoCqE9fULSejJAvH0zl/HD+386PXQyJQqysYd6A?=
 =?us-ascii?Q?DLtzLBCOJpReu+Nz/nQaWFVJEfrSB6gqqRFOmVuWyCLrC90Y6t8k2GgArQe5?=
 =?us-ascii?Q?F2KCFI4XN3KAFmwfI+MhRBl5TbYWq2eZ0YlZ0jktpOOm8VGLr2OvE9eJ/VVs?=
 =?us-ascii?Q?KToB1r/9sYUM4wt0eIXOoGZ+hXbLt1+YUHjKErwc8G9JJM52TgGZrKd9q7HL?=
 =?us-ascii?Q?ZwbDFiJZ56fGx21e4YD/N2e6b3ZwrrEbEVQyihcUE17NaW2w89tzXxws1kQ6?=
 =?us-ascii?Q?Cwd2VRe4cGG1l9nYulIRevXQmt9lr4yx9GNQzXDxHlvE5dVcV0hwyowB6XlY?=
 =?us-ascii?Q?4LKdlAYK/1+60Hka4Llo9/yaeZaQVGWxt7OgJqf3tJkUhl8g6tcPlhAyqUiK?=
 =?us-ascii?Q?FT3xGzaFcU8BYMTd1vzJsgUAHHQe8vK+Fhjz1EOxN1EP41jiisL55RezYAo3?=
 =?us-ascii?Q?jwzw/W0+2ZEmqCboBEuU2vjCHMT+xSaUDhVCRMQF3dEDi1aWe9kiu9R/Ck+N?=
 =?us-ascii?Q?1E9TRnsgRCnwMw8DcfupT2MtQVbLqczrvUDCjIr9aWaipTxEcuOYxamwDm89?=
 =?us-ascii?Q?+QTrGAGY0kJCOuquQm9grqJ7ehpD1PBs9MRpOT72uxKuUiZpUsJCauFzhZTa?=
 =?us-ascii?Q?hqq3Lje8DSe2yDxOm+s4rzbWIo09F/q8YGqtv4KVH/sMQjmyzM/9CNE4RDq+?=
 =?us-ascii?Q?xkkRqimqxLL+5x/uC2pC9PKCvRPIV8JUuBu2Vnt6+AW9eV2I6KCpZ+PXlk9u?=
 =?us-ascii?Q?9+2u1v9aTjqlONo36D/Pgu8ophfOkoF7Iw+Cdw8kNPdlU9lasnheInQfFx3u?=
 =?us-ascii?Q?ThyrxuOM/6iyUkXXH/nRHHmy/ZHOB++z3iUcuNtvY1LVE36QgheJN2GCgU8j?=
 =?us-ascii?Q?PLw7qb93TNG9fEnEfGJ+VLGsIG3bIUxZgp9GivPYZJ273R/mSqCW8lahDifA?=
 =?us-ascii?Q?bYuIZq04LVJUC6pgPe+M986m2YTqyM4+M7PyhWf2QPZ9wD+yuHolkFAL/Qtv?=
 =?us-ascii?Q?9sUmgiMXAkkovCewrm6Xx7u0YnoSPl+Nu3l7QiRvJ5JvJJOlw5VGI+iZ2Wau?=
 =?us-ascii?Q?N3NTN6r7rFskCMCOroAQkuaWsktLw+kkR0ZQYdxkBaUTMmUageWAuIyhMxIx?=
 =?us-ascii?Q?8lezQnr9zh8wTY30/ojOn8PPdUZ/Vsa4eF/DjI8r9Bk/An38zjD3rzYvTsZx?=
 =?us-ascii?Q?9HFmOHRqNZUXRK57XHkVorHbZ7kENqOlMXvA2CJ7HBnb8rphZJqSeLG2k3D8?=
 =?us-ascii?Q?MpXnc9nQk3fyzv0fszJOaPn0/oR6fBY1UjiFTt6vCNlnv94c5Gaj+6xXkPKq?=
 =?us-ascii?Q?Nvbs4GyxnHP8+k/oNs+R9gwV2SGyMmUPDIjC3NJSymWPTBC41/NWOzGXXRM5?=
 =?us-ascii?Q?LfWeRs5gINreAedR4iBXi9tIFru4Np7WOc6N8crmW581wm47bkKQHh+CMYNt?=
 =?us-ascii?Q?KvNLyY4nutWoNr2w+huJhpp9J49irkf0B1vx+P1k/ZNn8m5tcJn3Z3HSoeXa?=
 =?us-ascii?Q?9rVio5aUGbLsHHSkAGI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:03:39.7815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b49d24e-f3fd-4e12-8156-08de12130f22
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7617
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f9ef72 cx=c_pps
 a=2Rjy4IR3uOVgXvcUMQBuHA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=zWlGrJBK1FuhkNR3vBAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: cHq-mWIvDSu5rOu4Ha7zRjvNv3smoOWw
X-Proofpoint-GUID: cHq-mWIvDSu5rOu4Ha7zRjvNv3smoOWw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDA4MCBTYWx0ZWRfXyHd4pIQjbwTZ
 h5nkdn5oCGqQOWsXUt1iNJI2PogvzmFgklhrFTzCLgUyjB/DZQk65yVcJOaeYHlLNM7bznlK07c
 GN0Nk/PCsl4i8C25Y6oNSw5ibps3RiHl5JfloctPabDxT05y4QmX5EQin+7z4ReS0u+M5uwSZs/
 5CQXVC9dQ/mK+BPdeRtB27DJy4VTr0Vv8qOz/ROpwBRPUbqVxXcJWGJi+IxhLhiM8WS153R31tT
 zrqGL25bEE4CVMyLUZvKpo/lxohpdi6LGXykiqS97MvK8N78LqbF2xKGH75ttzravV7SlNfPkwg
 QyO7ek3t1kBu+C9+wu1tWIxYl/sa2hpQkff9yNdEZOTqkp8i+4wxYvwQn26EX4nk2kL1VsVAWF9
 9cxkObcjExvfs48GNDrJetGZgD87pg==
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 10 +++++-----
 sound/soc/codecs/cs530x.h | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 3de748fa5255..42b9e087f28d 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -491,23 +491,23 @@ static int cs530x_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case 44100:
 	case 48000:
-		fs_val = CS530X_FS_48K_44P1K;
+		fs_val = CS530X_FS_44P1K_48K;
 		break;
 	case 88200:
 	case 96000:
-		fs_val = CS530X_FS_96K_88P2K;
+		fs_val = CS530X_FS_88P2K_96K;
 		break;
 	case 176400:
 	case 192000:
-		fs_val = CS530X_FS_192K_176P4K;
+		fs_val = CS530X_FS_176P4K_192K;
 		break;
 	case 356800:
 	case 384000:
-		fs_val = CS530X_FS_384K_356P8K;
+		fs_val = CS530X_FS_356P8K_384K;
 		break;
 	case 705600:
 	case 768000:
-		fs_val = CS530X_FS_768K_705P6K;
+		fs_val = CS530X_FS_705P6K_768K;
 		break;
 	default:
 		dev_err(component->dev, "Invalid sample rate %d\n", fs);
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 5b47c1ae2a09..f7640161c77f 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -73,11 +73,11 @@
 /* CLK_CFG_1 */
 #define CS530X_SAMPLE_RATE_MASK		GENMASK(2, 0)
 #define CS530X_FS_32K			0
-#define CS530X_FS_48K_44P1K		1
-#define CS530X_FS_96K_88P2K		2
-#define CS530X_FS_192K_176P4K		3
-#define CS530X_FS_384K_356P8K		4
-#define CS530X_FS_768K_705P6K		5
+#define CS530X_FS_44P1K_48K		1
+#define CS530X_FS_88P2K_96K		2
+#define CS530X_FS_176P4K_192K		3
+#define CS530X_FS_356P8K_384K		4
+#define CS530X_FS_705P6K_768K		5
 
 /* CHIP_ENABLE */
 #define CS530X_GLOBAL_EN		BIT(0)
-- 
2.43.0


