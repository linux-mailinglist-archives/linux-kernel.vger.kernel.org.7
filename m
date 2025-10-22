Return-Path: <linux-kernel+bounces-865122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C61BFC387
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE263357EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF89934B418;
	Wed, 22 Oct 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VIv2bDiK";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ehs0sdla"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B3C34A3C2;
	Wed, 22 Oct 2025 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140405; cv=fail; b=cZC23LjztZWZuhO5qKOtRVG+rqraTah+ESAJo9Nqr1fyHvJk/o8SX+48Kr4fGsQXyCpMF/oxh0FyWq9/RYqFZC+kcBTLovF650JRBV5pZRQhaKbLwJECon8n8G/8i9ye75lKsAFSLDrgM9IoyK07pQvk+CAFAG/LvcaqlxobKLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140405; c=relaxed/simple;
	bh=j3cvHh9MKY4mj2K0VuusgiaIEb5eBFknZsjNhYfs8HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W88IPrZdQ/q2YvuVXt+q4mkfOqFKTn75pouuXS0g0nDR75mXXEBl7gmcuT2GQKsANSocWNpuRyjmtziDVtrbkhqNl+o+M0wjU/5/IveO/ztSfZ35nxfGFGyZZxqI4V7VZ/lFhhY8fhmsp12+BY+iin3PpXf4vWV+upoFmdW6vl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VIv2bDiK; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ehs0sdla; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M5O60o1194831;
	Wed, 22 Oct 2025 08:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=C7tq3lVWKxkqFLfXDYYdP63ukeARPmz5S97ApwnO+qQ=; b=
	VIv2bDiKFocVXYNV2qSJ7HmDZMnryDucdC+euKccgO8gsDGm8RvsIuW/uPdG03S9
	nHzmeXI2xX20mnYlCVh3kNBc/Ne3pvJamXOmV1ZJMDpA+3zGj+HxoXzYpkgdg4AC
	Jogc9vMagHkrgYP8oLDx3tOubbBchlNWrXQ8WTM0CheRhjbeOWW02AY4izTjyQhO
	6GlB3SpklopCOz//R1DbFZrK5UTdCrD1xF29wWP+pQY06NRU3iIAxIwdu/e4BK/8
	7u0btuOFBgeFMCkCEDYzjlunD4DFUuHkKDKM0k0IijrDkd1Pu06w7Nm8zFgUrz09
	IIrLh+9ScNIS5iirBTDp9w==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021104.outbound.protection.outlook.com [40.93.194.104])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49xs380gdh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:39:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHEnkziLSQ9U76Ac0TlDyJc8qGtpwPoxCfp29HBIrcYsQ7KoDxTczsQGqsD3R6IzCeiDCPaqxD/9QdqW3B9vLsKgE/wkodGLoU3Su/4THhFvi3NuXD4UCAj8tGzWrPy6bLowS4xEP8sQgToeRDLB06vXn9jdU8MUNczmnrFyG2iq/nrNdDHGgyia+qgZyKYHOkprBZThwvHQ+GlersM4ashgJriH7jgRvEb5FYDuCjWfL476COJm6Rj4xTcK4ek8OZkFMuXmwNOkXZFlDEwWKYpXOxqU3V/EchwUOJaIe1Vf1fIVM9e2rc7rXCZwntvuogiTWhghqsoCam7PbAs2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7tq3lVWKxkqFLfXDYYdP63ukeARPmz5S97ApwnO+qQ=;
 b=D7wyNudFgQ7nqRDhnqdLSsgA0qBVIINCQ9kkcWwR43Ysvq4BUlSBOVW7whmtpSdM/0lLAAQ8/2PfRIGixK77C9kyOqwTwS7DKWjcT30qJf8jaQdv+KY4R81YpLGKOUxunsi/5PQb0boI42q7Ht35dDGyIwN8L8RvhLgPoCFYhLW9T9yOug10wEiHfkT/OEteMw73emuVJm2Lwy4jAoX/DczOIOfyK9xAwxs+OHZm/J3dNh9prtsPU4hR9KK8p9B4GHNRTRerM4IbkpxSGbNYRltscif+13b+X11FAx4icEDbG+o1eMfhapSs8A7DcifmCcVaUoYD5pT/vSBypBpq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7tq3lVWKxkqFLfXDYYdP63ukeARPmz5S97ApwnO+qQ=;
 b=ehs0sdla3BPjQIwHUzTD05i4soqTosn/KjTrUOuMg/z8px2nFjkmPYggOwZvL3Lj7CwRyiSjZoDnmrlaZ5kFmPDM9n+6eSLr3r5bPfQJxuUh0vuZU5XEZlUI45iF3dYX1BTkKz5laSQppdb/uTXqEnat9LCzalKmxUe3zNAefwQ=
Received: from BLAP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::16)
 by CH2PR19MB3781.namprd19.prod.outlook.com (2603:10b6:610:a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:39:37 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::b2) by BLAP220CA0011.outlook.office365.com
 (2603:10b6:208:32c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 13:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Wed, 22 Oct 2025 13:39:37 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8B5F6406555;
	Wed, 22 Oct 2025 13:39:36 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 29FB7822541;
	Wed, 22 Oct 2025 13:39:36 +0000 (UTC)
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
Subject: [PATCH v5 12/12] ASoC: cs530x: Add SPI bus support for cs530x parts
Date: Wed, 22 Oct 2025 14:38:53 +0100
Message-ID: <20251022133914.160905-13-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022133914.160905-1-vitalyr@opensource.cirrus.com>
References: <20251022133914.160905-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|CH2PR19MB3781:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4a3279cf-5652-4afc-0646-08de117071d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F7sAl7cHp35mWbhSgm8Gr6WpziQiBbcw/VmgUSQROGVzpmiKxCzZNK5YHHGh?=
 =?us-ascii?Q?LY8OxRVNNz6rr11Y6rjvP6/NshGMK7+AcE7HfL/ALPiYiCz5TpRkQ2x6jU2r?=
 =?us-ascii?Q?VTp4mE5HzFbmMQNsSQ0/vtY7SOmYr+fSlSXxB23ozZNQ+VFBxgjlAnseBP/F?=
 =?us-ascii?Q?DF9hZkIDLQFy4yIg4ompwZEDXwFocS4fGm6DrG14BAdCRmsimT9H+DhjwLWr?=
 =?us-ascii?Q?Nn8yMXlH2PkPtxLv3w0b6SxmmpwJR4XIJpB0t6FEOlX+xas7k336UhsJ3xHs?=
 =?us-ascii?Q?D+fi9Nq73D0s+Fi92UuXBYaq/FfUO+lvZAnMOmvVAuQkXRYGbRtA5u9mKokb?=
 =?us-ascii?Q?cG96dbEeq9ZIjznbKDJZmq6OW/yU99N45i916SRqwseBrin2rn8vJqUHbcaC?=
 =?us-ascii?Q?McZnWXiaHdZDp2r4FIWbmnTe8LjKT9yFGU60hP+xllNck5DXBKb7bM+PvQrY?=
 =?us-ascii?Q?RYQM7ztfID9Hb0FwzqltPySquBm4neKQfwyY5970VXSqgo4GAn+Sp0DYv0rJ?=
 =?us-ascii?Q?lUFfWs6soyBUfp003UX+vb3O/10Ape/qS56XEZuOc9MOkdqKKGHVIWbzsE31?=
 =?us-ascii?Q?e6lmr4sNRugvMMBk/pXfHZEvs+UThljp5HuebyNePm5fNrnqGy/H9l/q2XOw?=
 =?us-ascii?Q?swuiwZPJCO9A32CJku/0rRgsV6Ds0lY2/+CZcCh5/84K7xT7d7pJ2uoGzrlf?=
 =?us-ascii?Q?8cQ4BimOJrP/bhKu4/9R26oBKQxiUeuucN0OPHudU5N57gjD95jsyR7YEj7M?=
 =?us-ascii?Q?1HGQgeEK9WaAyoO02JlmjfcpzcvlwCwcHCuksj851ViK5HzArkMb9LtiO+/j?=
 =?us-ascii?Q?UKrQp+ZhW/t9muY5Qt30wkTh3rYnBaLuPdrKVocDpCZ9OgF8oiLahmj0QX2+?=
 =?us-ascii?Q?LSUpIeHbbYkck1z/GpypvZMRrOeuwffif1sdj5h8Y7Za2nf/Mz6uSXd3qiVN?=
 =?us-ascii?Q?/loKFch3nGAsHgvxK97ghZXfL/EF24zTVbP0CuXpwLWqamJ9eDdXlkDzYjBi?=
 =?us-ascii?Q?Hqa7B2KPLpxkZCHpQ8GCPebokptEyVIi0XGpM/jbxSDiHMBM2N3HYlnKZF4N?=
 =?us-ascii?Q?h+4cpZBVuaiQWd///RKEKMLbAzO0M1p4vnLrCFIjLAM7QgRs2yCoyhY6PUBM?=
 =?us-ascii?Q?55baCZp2Mj++H2QV8mel3CZLC7Eg6HVVp5OMnqfwHQXhTE2RqXiTWHeZOEAG?=
 =?us-ascii?Q?VesKRSmao7oDkNaidA9iqYl0c/9fockcHS4qLKUFIQ4mYzl8XaLW0bjtAK6o?=
 =?us-ascii?Q?fOURetpiSLCjpZJrVlL76FFCzT2mi0x1dcF2P5FlxBK+gk2ue+mIkdRjarJO?=
 =?us-ascii?Q?i51u6HBt01gd54mILw8Tpev4cYqichrPKVjj3j5Ed2PgI42b4LOqRyzjsX7G?=
 =?us-ascii?Q?dd4Zqd1dDUGaNmvlNawniKljQWrIzHcy8GM7DFqy0ZLn2tTsL2sC7Hlotmf8?=
 =?us-ascii?Q?76jOpKWeRzOoO2iEZ7tjYDio/ErL7Qe59aEWRKi6IJHEQk93DfPGpvGpmVnR?=
 =?us-ascii?Q?lybYD0kgnCwieQ26hYCPKmSqpX9ViUJdkgVlv4ykbJpmNIUJsS+OMG+W1zsn?=
 =?us-ascii?Q?l0oJiFLg4ocknneN3Jw=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:39:37.4531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3279cf-5652-4afc-0646-08de117071d1
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3781
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDExMiBTYWx0ZWRfX/kJFN4Ye9Cgz
 khx1ulu0f4Tyw04EbbKss153KywVIaizXTzaUgOeYakfndE1KULIPNetUuaQJ5zeSa0REt8gRNq
 GnsyUdavxIGvAGjXtVnUWkhTi6UqgHs4+5tOqcSDGzdEXrV6XLhy1upb7FsJb4w4OpplHvzUq6R
 kPCgL05NuHpAuVcfgQqHrFk2HgAExKlkvnlfWPdPMz7r+oe1CFTbR16zg+/pKv0kIcNhbyyDkj9
 I79FL1OrC0N8MDwunh7hxw/GBMsScDE6oi/oXUB7XkyKFRfSeKMez81mSodzeczbANJuMve9PMS
 cV2N9Oepgom3uKXNzm+Ayt9pHsdmSD+P/GSckZ78bgUg9SeCIHhRNVZSTdrLMNpt8Vwm8dZcv4p
 0nNrVxSpmcs0wY9Fo+5Ua2miEphnRQ==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=68f8de9f cx=c_pps
 a=zDPZN7IXkwPire9PJGhe3A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=0hqhs4pA57X8KY1vVdsA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: s0LXXsI19Pch91C448RjliCGVwJZhNyk
X-Proofpoint-ORIG-GUID: s0LXXsI19Pch91C448RjliCGVwJZhNyk
X-Proofpoint-Spam-Reason: safe

Cirrus Logic cs530x device family has 2 control buses I2C and SPI.
This patch adds SPI support.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/Kconfig      | 10 ++++
 sound/soc/codecs/Makefile     |  2 +
 sound/soc/codecs/cs530x-spi.c | 92 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs530x.c     | 21 ++++++++
 sound/soc/codecs/cs530x.h     |  1 +
 5 files changed, 126 insertions(+)
 create mode 100644 sound/soc/codecs/cs530x-spi.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 160c07699a8b..ef49f71e8b34 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -106,6 +106,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_CS48L32
 	imply SND_SOC_CS53L30
 	imply SND_SOC_CS530X_I2C
+	imply SND_SOC_CS530X_SPI
 	imply SND_SOC_CX20442
 	imply SND_SOC_CX2072X
 	imply SND_SOC_DA7210
@@ -1082,6 +1083,15 @@ config SND_SOC_CS530X_I2C
 	  Enable support for Cirrus Logic CS530X ADCs
 	  with I2C control.
 
+config SND_SOC_CS530X_SPI
+	tristate "Cirrus Logic CS530x ADCs (SPI)"
+	depends on SPI_MASTER
+	select REGMAP_SPI
+	select SND_SOC_CS530X
+	help
+	  Enable support for Cirrus Logic CS530X ADCs
+	  with SPI control.
+
 config SND_SOC_CX20442
 	tristate
 	depends on TTY
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index bd95a7c911d5..39138d96a720 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -115,6 +115,7 @@ snd-soc-cs48l32-y := cs48l32.o cs48l32-tables.o
 snd-soc-cs53l30-y := cs53l30.o
 snd-soc-cs530x-y := cs530x.o
 snd-soc-cs530x-i2c-y := cs530x-i2c.o
+snd-soc-cs530x-spi-y := cs530x-spi.o
 snd-soc-cx20442-y := cx20442.o
 snd-soc-cx2072x-y := cx2072x.o
 snd-soc-da7210-y := da7210.o
@@ -546,6 +547,7 @@ obj-$(CONFIG_SND_SOC_CS48L32)	+= snd-soc-cs48l32.o
 obj-$(CONFIG_SND_SOC_CS53L30)	+= snd-soc-cs53l30.o
 obj-$(CONFIG_SND_SOC_CS530X)	+= snd-soc-cs530x.o
 obj-$(CONFIG_SND_SOC_CS530X_I2C)	+= snd-soc-cs530x-i2c.o
+obj-$(CONFIG_SND_SOC_CS530X_SPI)	+= snd-soc-cs530x-spi.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_CX2072X)	+= snd-soc-cx2072x.o
 obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
diff --git a/sound/soc/codecs/cs530x-spi.c b/sound/soc/codecs/cs530x-spi.c
new file mode 100644
index 000000000000..dbf1e7bbec19
--- /dev/null
+++ b/sound/soc/codecs/cs530x-spi.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// CS530x CODEC driver
+//
+// Copyright (C) 2025 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+
+#include "cs530x.h"
+
+static const struct of_device_id cs530x_of_match[] = {
+	{
+		.compatible = "cirrus,cs4282",
+		.data = (void *)CS4282,
+	}, {
+		.compatible = "cirrus,cs4302",
+		.data = (void *)CS4302,
+	}, {
+		.compatible = "cirrus,cs4304",
+		.data = (void *)CS4304,
+	}, {
+		.compatible = "cirrus,cs4308",
+		.data = (void *)CS4308,
+	}, {
+		.compatible = "cirrus,cs5302",
+		.data = (void *)CS5302,
+	}, {
+		.compatible = "cirrus,cs5304",
+		.data = (void *)CS5304,
+	}, {
+		.compatible = "cirrus,cs5304",
+		.data = (void *)CS5308,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs530x_of_match);
+
+static const struct spi_device_id cs530x_spi_id[] = {
+	{ "cs4282", CS4282 },
+	{ "cs4302", CS4302 },
+	{ "cs4304", CS4304 },
+	{ "cs4308", CS4308 },
+	{ "cs5302", CS5302 },
+	{ "cs5304", CS5304 },
+	{ "cs5308", CS5308 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, cs530x_spi_id);
+
+static int cs530x_spi_probe(struct spi_device *spi)
+{
+	struct cs530x_priv *cs530x;
+	struct device *dev = &spi->dev;
+	int ret;
+
+	cs530x = devm_kzalloc(dev, sizeof(struct cs530x_priv), GFP_KERNEL);
+	if (cs530x == NULL)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, cs530x);
+
+	cs530x->regmap = devm_regmap_init_spi(spi, &cs530x_regmap_spi);
+	if (IS_ERR(cs530x->regmap)) {
+		ret = PTR_ERR(cs530x->regmap);
+		dev_err(dev, "Failed to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	cs530x->devtype = (unsigned long)spi_get_device_match_data(spi);
+	cs530x->dev = &spi->dev;
+
+	return cs530x_probe(cs530x);
+}
+
+static struct spi_driver cs530x_spi_driver = {
+	.driver = {
+		.name		= "cs530x",
+		.of_match_table = cs530x_of_match,
+	},
+	.id_table	= cs530x_spi_id,
+	.probe		= cs530x_spi_probe,
+};
+
+module_spi_driver(cs530x_spi_driver);
+
+MODULE_DESCRIPTION("SPI CS530X driver");
+MODULE_IMPORT_NS("SND_SOC_CS530X");
+MODULE_AUTHOR("Vitaly Rodionov <vitalyr@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 9fcae9b85a45..f8f409d0b035 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -12,6 +12,7 @@
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
@@ -1142,6 +1143,26 @@ const struct regmap_config cs530x_regmap_i2c = {
 };
 EXPORT_SYMBOL_NS_GPL(cs530x_regmap_i2c, "SND_SOC_CS530X");
 
+const struct regmap_config cs530x_regmap_spi = {
+	.reg_bits = 16,
+	.pad_bits = 16,
+	.val_bits = 16,
+
+	.reg_stride = 2,
+
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+
+	.max_register = CS530X_MAX_REGISTER,
+	.writeable_reg = cs530x_writeable_register,
+	.readable_reg = cs530x_readable_register,
+
+	.cache_type = REGCACHE_MAPLE,
+	.reg_defaults = cs530x_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(cs530x_reg_defaults),
+};
+EXPORT_SYMBOL_NS_GPL(cs530x_regmap_spi, "SND_SOC_CS530X");
+
 static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 {
 	struct device *dev = cs530x->dev;
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 2a7b7d01ecfb..1e2f6a7a589c 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -247,6 +247,7 @@ struct cs530x_priv {
 };
 
 extern const struct regmap_config cs530x_regmap_i2c;
+extern const struct regmap_config cs530x_regmap_spi;
 int cs530x_probe(struct cs530x_priv *cs530x);
 
 #endif
-- 
2.43.0


