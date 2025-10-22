Return-Path: <linux-kernel+bounces-865119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED52BFC37B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE0019C70CF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4677834B182;
	Wed, 22 Oct 2025 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="LYGT2PXW";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="tmL8VrqU"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE46E2FC866;
	Wed, 22 Oct 2025 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140403; cv=fail; b=KSGiDOz8Mm/INyP+gK61H9x/Ks6F6o+0IxdpSnO6yw8i4t1reig9wEU1rUi15kcPBztsB/1HN9I70YzMzRCYi2WISKfjZsOZN0F/GdYniEekAmd11ypQgvW72igdcw/snG6AdDOHLuUHnPKdoN8DUNLM9KFekfDooA8kJYJgUhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140403; c=relaxed/simple;
	bh=U+YekloaAmvDMnrdmWqgwU0d09aOlJJQnJExkJssbSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X+36EfzoA+G+y2pzv+hBblrDW56nLDwfAxemrwdxR84J4joj36Gm6ZGICZML2z7I5ceSWBSzm4jHhMO4sOpwSGPa8ONqO2jZ0RJM6xI1OK3mOnjQamCmjDnLZYu+h6/+/vr/rSLK1pCclEJ25bi4UxmQnFnd00ZPrCIbh0psFfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=LYGT2PXW; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=tmL8VrqU; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M5O60l1194831;
	Wed, 22 Oct 2025 08:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=U/J3+S+DX8RycM7U
	FQqoxg5bFtKcoesKn6XztJe26JQ=; b=LYGT2PXWOWIDw8LZb8zzAKgeRIcN9jsq
	6eg8yCXti44+z9YcF64lt6QlVjr1UtYMasxG2Ic6TBf4DTr2dJSmq8mx9g2QbZHg
	iP9Z71IrM/jGsEGNKpP5fQEjdrpJeQUmTx7mCMKSqjvW18dJ3FJcs2qP7qifbMXt
	+HAGHmvWbOjZtqunBchZEpAG1Ki58r4fvn1uTxohQbCmyYAB96Qwr57p1Uka2qhw
	6AvEpg7kxWBmZE0LxonjzlnTBU3QlyIV77sXvXpUfGKZ63Ikz4Ixl9VFtySPIYyn
	Odks2K0Gzzrqqe9AOONccf1g0cmqiuyyO5L9KC9qQm88LYu+mtp+Pg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023138.outbound.protection.outlook.com [40.93.201.138])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49xs380gdb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:39:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUaTZiitlJdJOmjst5Q6t3J4E0CmhYSdDj6HRPhV0UHVjzoIOD6FOR26hWUhYQ5rLpXzeHgCB+Ijurhm6AkfxcHtXJ23xYUJSMNIQMdb0fPY3o8re9WrzNY0sATnZr0OMYowU204CEt4YGSXajrkzhu8kkr0rQN8k1npmXBc8TU46e1c6yL4Tuowg8trWtbymkuScqIXfBbWN5U/vC7kHHIRkADPpKgNFg9wxrBnqNJTTMAORH3R4JJKH1Qc+Z+DWk0PVBh/i23JtIsf/U1ClI0NYu+KHGGIwiezQ5BKoB2lSSpEAGVLgm2E57p9RrHJ7q8wDGSCOtjAWmVTyEDkhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/J3+S+DX8RycM7UFQqoxg5bFtKcoesKn6XztJe26JQ=;
 b=d4uS4uVUs761lXnMxgS2NpFiMWomO6pkgL1H6Fz3O5HAclockc16BO92dlHCcGBKzFD62FpAKX85LfB2yaTgPuwTGpvEtZwKXDGxLGKGWjTWJtwXKWfIDePP70traQ7vmtNB7az9yPfHfglG0cysEflhx4h482Nv9FJOqKq6ElKYOOvkgj2fCdPKB2yyEtUaI6G5yFUUV8ROyQHqiwZKZbYLNGLw5c/L7GEKn6/722aAATEQG/IkeIDFcGkO+7XJjq6zlvpSgzxC/CaW4DAgbLleD99VtzKAwBBYKYxWNFmHkRDnrJK3pcfEvb1uXLqiUqxzdg6UakwTcIatT/+utQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/J3+S+DX8RycM7UFQqoxg5bFtKcoesKn6XztJe26JQ=;
 b=tmL8VrqUPwJD0gzNlSuZyuaRteS1ioMcOPwM5EKVtj2A0JezEb1g/qeQvd7isaVbsJs301+UBtQpokO4U5xVbAgCu/xGXd5C0UsVYHzFjRrjvXizATrND9kDO+U1vkgFmbB50qzheZxaJLrcZqTD8A/1WwaJ+rOOetwok3jaPlo=
Received: from BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30)
 by MN2PR19MB4063.namprd19.prod.outlook.com (2603:10b6:208:1e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:39:33 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::4) by BY3PR03CA0025.outlook.office365.com
 (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 13:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Wed, 22 Oct 2025 13:39:33 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id CFD91406547;
	Wed, 22 Oct 2025 13:39:31 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 63A31820244;
	Wed, 22 Oct 2025 13:39:31 +0000 (UTC)
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
Subject: [PATCH v5 00/12] Add support for Cirrus Logic CS530x DAC and CODEC variants.
Date: Wed, 22 Oct 2025 14:38:41 +0100
Message-ID: <20251022133914.160905-1-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MN2PR19MB4063:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6f86985f-a91a-4e2c-7e17-08de11706f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PeK8zMYL+gW0aIMo+LO7i1yBS/dzDNWgi+68VeU7xwA7g3R/MA3mWKtElNLj?=
 =?us-ascii?Q?J6QZWgTzCzd0Bqc6OkfWUPME1rM8NLx1xTw8c+aOTY8xBre9zaLkEIQq66zh?=
 =?us-ascii?Q?iS8KGOuoPm4SL0hOyjvWUcaPA3F0PLFkMgtzJevxj+W9qyAyum2M20UITRdW?=
 =?us-ascii?Q?gKtxkO2tedHJqysuAHvRxulKcsfNoNHs7e3IylpwXgOUpqq+pDH230jRUrZ7?=
 =?us-ascii?Q?zinA3BN/Mw56MDMXb+NKM2HXw/PfUWt6uAkoZgBFnULKbmKMVZY+4CcP5p0F?=
 =?us-ascii?Q?IwN959y28pWw4oFi8MAvtJGHwAbNYxV5C6LI1w5hTkw225o0DfSzzDATc1+n?=
 =?us-ascii?Q?ZnSUUOwW+JPfkGuJ1++s6eRRiYfXQfrN7Z5LgrqG6pJQYdb2c7+Tq9p7LC1/?=
 =?us-ascii?Q?QBWelDcCkfK5t4Aorkce77SUW5aHB15dAhZZV1D/w3ioewfE+2hvF2lCNwoh?=
 =?us-ascii?Q?F2FuInyfrzM5tXUmLEXUeSw0RzQozEcRxCcIPmSmEeuE/uvf3VRIgNJqOL3g?=
 =?us-ascii?Q?gZilqEWesBYIwTJ3EVnw0m0zELIOOR5oocAP1ysGW8pQ5WHg60gpKgTFLmzz?=
 =?us-ascii?Q?8bNJPngfcXcAtkLC5L07am69Z2bm2mhwKWHH2yTMW+ftH5garh8GSwWnT2oY?=
 =?us-ascii?Q?SSL8apaXRuBG31T2ptkO7jgs4nYi2NVOtzdLZMXpsFDVNlrDo21GY9INgypm?=
 =?us-ascii?Q?v941BMFjxw3JfxfZb3n1H3uQ2rv4Qisp4OU93va5W/oiygoROV+lWYDrMtNt?=
 =?us-ascii?Q?w0T8cWrpuoavKT6i+CvNKNzgYz1YBh6V//rBz8wFVNkhjFoGJ7CqaSTg8KPw?=
 =?us-ascii?Q?dZWqJZoVew8CQLP9VLh4ba+JsVfQxDelq0QdCZqYcwzF+GXyevak0WIN/veA?=
 =?us-ascii?Q?30NrNPyUZ50L37CICzukdFrc2bdeLX1KCGN4cDvx2gGVgrLlA2HEWnRVE9kl?=
 =?us-ascii?Q?7re9IjDZ8B9y9TpjT62NNg6tzCsZX17SPKfoyWSVcpsHvSA1ILRBR6uXvpyU?=
 =?us-ascii?Q?e0Bqdk3UJFEa/KCNhsC/YVEs9ejwWARJ0IVTFcJZ6BPPyVeIhB1Fb+k5BtW8?=
 =?us-ascii?Q?0EkZ1BW+TmsgCPnP2WlA1aun55z1l8G/BMOwiTRc0E9KWU5QJZSfjZt4wTaX?=
 =?us-ascii?Q?tJ7XmnKOY7LYHRQ5HJpVtHJgnK3eNvGdbGSCOo+WWopJe0X+28QDjHhIRPsz?=
 =?us-ascii?Q?9GbGB+jkTXvik9zzRRdnSGIfOWuarinuVtM5qM3a7BvOdnlULGji0DWx28P2?=
 =?us-ascii?Q?6Qh7vt9T8N8fTRLq+ZxLPBLXq+yMrWO39qjrOdn1ISgUo+/nqTVOUtZPeC+4?=
 =?us-ascii?Q?IlXSrEifpDCLmfz5kZxYjQgh90cS/7/BHEDKeHjMwIkERpG8qdMmwtFdVVwn?=
 =?us-ascii?Q?pYa1Itt1BSnQqkh4N7UtITwA/weFBrJT48wUMlTFgMxsDv7tNxgInu4RaR+u?=
 =?us-ascii?Q?xhy9rwcuq06N9N5CydK/PgFPyuWHkgooquhwLQa9XPuJcWXQKc5EPf8fVDCW?=
 =?us-ascii?Q?1SRGEqUkrTYE0Vq6AWonI6BZxUmx8wcDl+8rDB6F2p7BO1DJ53JAT/BSa3rd?=
 =?us-ascii?Q?vcMiQlzBxL/P6aQS/m0=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:39:33.2238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f86985f-a91a-4e2c-7e17-08de11706f5d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4063
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDExMiBTYWx0ZWRfXxqIHcBP7H3pA
 kGtu7EGrFOtWD7i7u/fY6GB2Afh4eH5/VmTgV28QNmDs1/F4cs9no3fuqrTKJqD0lBqOCEyFhv9
 dqo+cqIx6zmKflpkJG3yYMJBT+c972NlHf96mMMPI2uUfOKEQ4wladGRfT3+iguoA8oWgQhK3lw
 zM6MM8uCCLM1CzOBUO7OWUBK1rtOdiIccQUiqgC2D9xOz1VMJC9Z91T3698uSFFy4jaLeuDiObG
 8cwdsi6ZuSDQF3YAe1WWS18O87VDGwU9XskYQbMC6A9NobGJrZNNgw/KFgH9M5T1IYf6ROKq4Fn
 WpTVGU2xbz+xO0hSnum3SulfIBi5uWushQnzxwCIPXK8y4PIvDIkX7h27koXy3Yf7eeF+M4WL/+
 WvbFQIOEO4BXkd0c+aUkl7m6kf9mYg==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=68f8de98 cx=c_pps
 a=S0nsQJN0x0NZxitFF6bqdA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=emXAkaYdkGb4hSi0DYUA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 6BB0I7HZxeK4gZgS7hAa8cpjUJ9OZa3g
X-Proofpoint-ORIG-GUID: 6BB0I7HZxeK4gZgS7hAa8cpjUJ9OZa3g
X-Proofpoint-Spam-Reason: safe

This patch series introduces DAC, CODEC, and SPI control bus support
for Cirrus Logic CS530x variants, along with general code cleanup
and resolution of checkpatch.pl warnings.

Changes since v1,v2,v3:

- Signed off all patches
- Splitted "tidy up" pach in 3 separate simple patches
- Fixed commit subject to much preferred subject prefix for binding patches.
- Moved dt-bindings related patch down the chain
- Added all relevant maintainers to CC list

Changes since v4:
- Sorted dt-binding properties list
- Re-worked removal of unused defenitions and structures
- Move renaming of CS530X_IN_VU to CS530X_INOUT_VU into separate patch
- Added dt-bindings SPI propery patch

Simon Trimmer (3):
  ASoC: cs530x: Add CODEC and DAC support
  ASoC: cs530x: Check the DEVID matches the devtype
  ASoC: cs530x: Rename i2c related structures

Vitaly Rodionov (9):
  ASoC: cs530x: Update the copyright headers
  ASoC: cs530x: Sort #include directives and tydy up whitespaces
  ASoC: cs530x: Remove unused struct members and constants
  ASoC: cs530x: Correct constant naming
  ASoC: dt-bindings: sound: cirrus: cs530x: Add cs530x
  ASoC: cs530x: Rename bitfield to reflect common use for ADC and DAC
  ASoC: cs530x: Correct MCLK reference frequency values
  ASoC: dt-bindings: sound: cirrus: cs530x: add spi bus properties
  ASoC: cs530x: Add SPI bus support for cs530x parts

 .../bindings/sound/cirrus,cs530x.yaml         |   7 +
 sound/soc/codecs/Kconfig                      |  10 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/cs530x-i2c.c                 |  24 +-
 sound/soc/codecs/cs530x-spi.c                 |  92 ++++
 sound/soc/codecs/cs530x.c                     | 516 +++++++++++++++---
 sound/soc/codecs/cs530x.h                     |  90 ++-
 7 files changed, 635 insertions(+), 106 deletions(-)
 create mode 100644 sound/soc/codecs/cs530x-spi.c

-- 
2.43.0


