Return-Path: <linux-kernel+bounces-865114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6C3BFC4BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97D7662E96
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A85E348892;
	Wed, 22 Oct 2025 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FAjXwmCY";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="yvcBq1B1"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C5347BC0;
	Wed, 22 Oct 2025 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140398; cv=fail; b=TX4ASxjUHy2SLLYZfkZNAaqTcKr9RZasLg8iVCNyZqrACBNLsVpevUjRD7cYfq6mPDlCNHtPIYPb61Iabgh+B6HIDOcUivswDeW2MSK9NnZboCFnYTyMmE/wts6rABdsdKGnoUXZ/4hvC3fZNR+A3sqIuI/pewllq5BCTEj23zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140398; c=relaxed/simple;
	bh=XiWMwURe6+92nuC15j9vY7g90WZpzec8nLgGnXTiRRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOF2k2zwGCaEuMgECwffgHEc6igZLU17KlRPY+Iv2B4edaPfJGUArpA/sZ6ZumeIe5p9EoBgq3kvZdCxzQ0+/KOU2Xjwhp/0qT8iWmWafblp6erQG0TD8BqY8BA5bHlDcIavwNzftBsdimo4swtFTZyI05CqWvq1UvxWeK4Ooqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=FAjXwmCY; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=yvcBq1B1; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M3j1f03660649;
	Wed, 22 Oct 2025 08:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=xV3RnwZPX2qjFec9DuBIyVot9Qgpb+TgJq/ti9qaVRc=; b=
	FAjXwmCY4PYJBzVgQX1SRFsjkcsaW1CPY6LN6DNxPABwiXZbao+ao+BxDyAX/998
	yjBXHYGQbMJJKRlP8pOKUON/C1RRPU72tcGwZqM6MlZxKyhvsCh9XxaKNkeRW6H4
	Qi9cQ8P48DVcVptuRWuleZKRh0fddC0cXkTwWcL9y7lDgicMJ/Zjs+QHzMYc6OO1
	P7cJ+fDQWiSzfT8oCDlbTB4qRZZAc37UE42kvfvD990uqT2LBCX/8zHqYKkz+aig
	X05vHBxz7Z55khNYkMUriTiSUvztdflnp+Drruh54nYAR6FMEDi+TCC0TvUftYF8
	CrL1HO4dSMMp8mHSpq2zUw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020091.outbound.protection.outlook.com [52.101.56.91])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqrjpy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:39:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLTZ8dql2ZN0pNNxZ4JFA5XQiYhHpJ1AlyWKOI3/4gbWzDeX2bonhahMh9t1OhbUK1nlVQRxlCERFJRKjMKffveOo8sglPCw1cnO5Z45jNAe7oXxBWF+H04uykKnrpNSuvKvfv0MDO7Odywag3NVZYIiR0YEDTuFIqMgmSWbHazxULK1UvhsD5QFZl38IEwuWlKmGKLsU/OgSwIkT8gp1XHOhyVXe9LkExTPGQ3hK80e/H2WcHJQ0Bs2Kouy3zEeTdXVqom9WA5O1QnFUvi/CmvRweRpshRkWf0j5mkwunKBLLmynDObw51+UW2t1hFpkuPKq8kR56M43tyEyN2W5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV3RnwZPX2qjFec9DuBIyVot9Qgpb+TgJq/ti9qaVRc=;
 b=HSb4/tNbCA0ct6OVoSg3Glnv/0oq+EK5FT9pAZQMfrYaMYFRu7p72KW3eWioiNTEVZIwPNEDgPj9ttgqjr7fpjOfAP0vJFACT9pkZkeoemFDS/HxzF9ZQTHr3lGAj9SH5FELnVHbZXuffD+TLMBIcoNLorqj0KPZx6RjOrugpKyfnEwKmeNJHwAeJj4zAl8MHF7n26mNlXPHqY+O+V4WOZ9hqelW0DZbYa0qqgyOAWea5hFNz68Ee93veDvjzaXE8EZIFjLd8xVyTlAHECC6uJ46krrlqMj8ObYYJCoHvXhKodx1AE2jf//yUOl9e8y5NvXMw4CB8SuSCBRZvef5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV3RnwZPX2qjFec9DuBIyVot9Qgpb+TgJq/ti9qaVRc=;
 b=yvcBq1B1rKDSDL18EeBkgxp5PorNIWpyzPtRletzE7rM+Y2cEM6KHqe4TwHTB+vwM6CGuAfJTqMN4hFM0t52VAzkKCWeFa3arBFx3cgNCNLqRDdgbSyUIly+v7YwnB0QdS9/Ox4Wn6ubVau7Hej6gCSgNUID7qtNuba4IAvKAOE=
Received: from BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::7)
 by DS7PR19MB7721.namprd19.prod.outlook.com (2603:10b6:8:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:39:34 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:a03:59d:cafe::59) by BY1P220CA0009.outlook.office365.com
 (2603:10b6:a03:59d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Wed,
 22 Oct 2025 13:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.0
 via Frontend Transport; Wed, 22 Oct 2025 13:39:33 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 87750406552;
	Wed, 22 Oct 2025 13:39:32 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 27D11820244;
	Wed, 22 Oct 2025 13:39:32 +0000 (UTC)
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
Subject: [PATCH v5 02/12] ASoC: cs530x: Sort #include directives and tydy up whitespaces
Date: Wed, 22 Oct 2025 14:38:43 +0100
Message-ID: <20251022133914.160905-3-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DS7PR19MB7721:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e1944afa-b778-4994-c535-08de11706fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nO7E+23FcvNdi+oSs/ZkQO1tjzjlUPE+cB/bzGxjVvnmtC/ewrX+4OztxWNS?=
 =?us-ascii?Q?2vQOJNx5YscAIhlPoqpql0mXbwtpjP/gpQQdTmikc6+KxQX3qqdFVTRQG+Y1?=
 =?us-ascii?Q?FQHFhSe2XHnngFztx8TY/FRoBGj1xCTAjZ1G1nSC206B6Y7N3+8KEbSp75p1?=
 =?us-ascii?Q?DAJ1G23RbTUDOMnBXJpMBV3nhmwQjoitsizhTGaiDVyOI1UUh3QCIJ3+/mHe?=
 =?us-ascii?Q?c1kLegNPzvdjhQRqhkxafAc1HpybnNaCTc+27eZcqJiRnQFXfxmJr6KxE66d?=
 =?us-ascii?Q?Lo6M8n9LoPV7JIKDJ2UGUedCzhAmrJqNatLJzWsOAOV37evLZk+fKpaKjhfJ?=
 =?us-ascii?Q?qiIvnoG+bQqbugs8GF3tVGsEA3ccH0+2BUoaJTn7FCEdZx290KjVGUz7Czgm?=
 =?us-ascii?Q?eq9Qrh39HkBBiJlmP4pGSfo+gf/DSaEW4JOZRvxqemTtYfT5RYIawSSPITLS?=
 =?us-ascii?Q?C4CLf95oP2G8I9L1lXF9yxUFZK9KTqkkWgT1+mR4VV8usPxbEp4QxoMyk+S3?=
 =?us-ascii?Q?YGYgv/av2AYBX4KNBGlB8H1H6C7862Ci5eCtvFI4qh8xWcdZcI5SZ8R0PGW+?=
 =?us-ascii?Q?CS6J1YB3UD/fG+C0TCviCUxZPj3RGWxAGmQKYYPPY90wEG4XLcxePxK+Ry22?=
 =?us-ascii?Q?RFiQ+lHQfsTqec+N8MSnBuklumkaLqa7xcUwFbpBCNRDnpn4jipLCeBFuBEX?=
 =?us-ascii?Q?14VbVs+1ZMuf6Y2RceUfVNNoaFemzEFTPITP0VvajkDnooyM52yZgrP8TQy+?=
 =?us-ascii?Q?sWSOQaR4ScrVPLzbAP4m9jq0YZXPr13zk7d/8rk+JklPzuGa4e4t9vFICfPd?=
 =?us-ascii?Q?n1hG1+dtiR73LzbS8qnJyMirynSnZQ56B/UWSYk9iLd6xjsYkweIVdbYNwqC?=
 =?us-ascii?Q?rvMeyiRQi+5Hw2WrdvkVchQR76yQVLNepcr8n513IveUS46dmK5zOVqMa11t?=
 =?us-ascii?Q?mlBYUbHzhFrpwXxIn42xgdJPgM42C2hAb8JGA9U2jPx4TkZeY9dmsOdMsXDX?=
 =?us-ascii?Q?/DSxIwJ2Ib0wkFA1SdZsAJOgxnVWsy0wBK3DwYzEgfyexgWEKWXtZGUrG3qf?=
 =?us-ascii?Q?e7fU4UBlTOobBxvLXRBDQl0KV2rM/SgfBRsYDb/C70kMmmgXJC1n+6IjmxOS?=
 =?us-ascii?Q?hjBGTVfFWEl9oYCtCBhDlMm+zNXlfC5p9b/9glBc6E9sBbIY3QoOVGVcx1Pw?=
 =?us-ascii?Q?DI341UeFXdrYs1EZt/c84MUaZtJkDJMgTVbI+FGV3JA6vb6uUE0BlWx39MiC?=
 =?us-ascii?Q?1ExTJgZZ4A/ccG6hdz7sjMqiTOWjOWu6xwnZg3cVJ+WZ+7pqh8LakZszt+L+?=
 =?us-ascii?Q?Gmb8J3C9e/P49raEK8mrLVhUERNgZkq6/DEWk0UytKehSw03APsFetAnmQrJ?=
 =?us-ascii?Q?6gIfSiUm4pv4Xnl2xQF09Jbp/ELfxu/mBWLNGvF6VC7WZOQ2CENmriFjB7VE?=
 =?us-ascii?Q?NesURx1dOXHuaiKVZwidcmBnuRg7axvT7RCQ4Y6IoekLiqD09Hqsna0Fzx34?=
 =?us-ascii?Q?2HnDY8MFCDpBIEuR8+pWhsOlyn/PJjqR1DD6DQTYKHvdxcZcO/A05RrNXSli?=
 =?us-ascii?Q?eOKHNHP21GZwa+CJ1Kw=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:39:33.8240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1944afa-b778-4994-c535-08de11706fb7
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB7721
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f8de99 cx=c_pps
 a=DCeSEX+nBJmE/I7rcEuDsA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=wFt9MVH1Lw3u3H5ftKQA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: yuwabJ0HrufGt-gzpe6NFkqLEMil7lKF
X-Proofpoint-GUID: yuwabJ0HrufGt-gzpe6NFkqLEMil7lKF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDExMiBTYWx0ZWRfX0XDyDpWjf38G
 0r/i5Yzg+PuWvW1R+LEc84uyWsT9vK9kSSXJ4rZc6Us8/spP/uAAVgJodC4YqQRb98whdXV3TxH
 YbiHayJKaC1OXABmRoE70SeR025oygRc9HlR2S9gSbn89xZotA6M+W9bdcagX1DPF68G96rVtdT
 qj6xuwkVWhBe24G1KjHL/N2UN5NW0+NHeK8kJjqntJysriRXDXzlkHO3RZ1562hadLiVRaq7UGG
 lQYe+6pgQ/ZU6Bi/CLG0ZlsgdZGxMFne3gEe6+6+yEVshrYJmOcaSvRTyiLMs+ixt4hve3vLONw
 kvleNcRbeLIF3uEQtLtWcUDAm8FCFSGEtuFiYJ7oX8yrkplO4nexNnu+NJlbVyW6JLdIOyAS0NB
 c5uT4ej62zphERYkDT1p+N7jsqNRiw==
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x-i2c.c |  2 +-
 sound/soc/codecs/cs530x.c     | 49 ++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/cs530x-i2c.c b/sound/soc/codecs/cs530x-i2c.c
index be80dcad3647..d6b7883ba7b9 100644
--- a/sound/soc/codecs/cs530x-i2c.c
+++ b/sound/soc/codecs/cs530x-i2c.c
@@ -48,7 +48,7 @@ static int cs530x_i2c_probe(struct i2c_client *client)
 	cs530x->regmap = devm_regmap_init_i2c(client, &cs530x_regmap);
 	if (IS_ERR(cs530x->regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(cs530x->regmap),
-			      "Failed to allocate register map\n");
+				     "Failed to allocate register map\n");
 
 	cs530x->devtype = (uintptr_t)i2c_get_match_data(client);
 	cs530x->dev = &client->dev;
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 88084e7d6447..3a59eeba5e55 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -5,17 +5,17 @@
 // Copyright (C) 2024-2025 Cirrus Logic, Inc. and
 //                         Cirrus Logic International Semiconductor Ltd.
 
-#include <sound/core.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
-#include <sound/initval.h>
 #include <linux/module.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
 
@@ -104,7 +104,7 @@ static bool cs530x_writeable_register(struct device *dev, unsigned int reg)
 }
 
 static int cs530x_put_volsw_vu(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
@@ -224,7 +224,7 @@ SOC_SINGLE("ADC8 Invert Switch", CS530X_IN_INV, CS530X_IN8_INV_SHIFT, 1, 0),
 };
 
 static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
-			     struct snd_kcontrol *kcontrol, int event)
+			    struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
@@ -236,9 +236,9 @@ static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		regmap_clear_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-				 (w->shift * 2), CS530X_IN_MUTE);
+				  (w->shift * 2), CS530X_IN_MUTE);
 		regmap_clear_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-				 ((w->shift+1) * 2), CS530X_IN_MUTE);
+				  ((w->shift + 1) * 2), CS530X_IN_MUTE);
 
 		cs530x->adc_pairs_count--;
 		if (!cs530x->adc_pairs_count) {
@@ -249,9 +249,9 @@ static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
 		regmap_set_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-			       (w->shift * 2), CS530X_IN_MUTE);
+				(w->shift * 2), CS530X_IN_MUTE);
 		regmap_set_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-			       ((w->shift+1) * 2), CS530X_IN_MUTE);
+				((w->shift + 1) * 2), CS530X_IN_MUTE);
 		return regmap_write(regmap, CS530X_IN_VOL_CTRL5,
 				    CS530X_IN_VU);
 	default:
@@ -263,16 +263,12 @@ static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
 
 static const struct snd_kcontrol_new adc12_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
-
 static const struct snd_kcontrol_new adc34_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
-
 static const struct snd_kcontrol_new adc56_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
-
 static const struct snd_kcontrol_new adc78_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
-
 static const struct snd_kcontrol_new in_hpf_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
 
@@ -450,7 +446,7 @@ static int cs530x_set_bclk(struct snd_soc_component *component, const int freq)
 }
 
 static int cs530x_set_pll_refclk(struct snd_soc_component *component,
-				  const unsigned int freq)
+				 const unsigned int freq)
 {
 	struct cs530x_priv *priv = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = priv->regmap;
@@ -492,7 +488,6 @@ static int cs530x_hw_params(struct snd_pcm_substream *substream,
 	int ret = 0, fs = params_rate(params), bclk;
 	unsigned int fs_val;
 
-
 	switch (fs) {
 	case 32000:
 		fs_val = CS530X_FS_32K;
@@ -540,7 +535,7 @@ static int cs530x_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (!regmap_test_bits(regmap, CS530X_CLK_CFG_0,
-			     CS530X_PLL_REFCLK_SRC_MASK)) {
+			      CS530X_PLL_REFCLK_SRC_MASK)) {
 		ret = cs530x_set_pll_refclk(component, bclk);
 		if (ret)
 			return ret;
@@ -614,7 +609,7 @@ static bool cs530x_check_mclk_freq(struct snd_soc_component *component,
 }
 
 static int cs530x_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
-				 unsigned int rx_mask, int slots, int slot_width)
+			       unsigned int rx_mask, int slots, int slot_width)
 {
 	struct snd_soc_component *component = dai->component;
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
@@ -686,8 +681,8 @@ static const struct snd_soc_dai_driver cs530x_dai = {
 };
 
 static int cs530x_set_pll(struct snd_soc_component *component, int pll_id,
-			   int source, unsigned int freq_in,
-			   unsigned int freq_out)
+			  int source, unsigned int freq_in,
+			  unsigned int freq_out)
 {
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = cs530x->regmap;
@@ -743,7 +738,6 @@ static int cs530x_component_probe(struct snd_soc_component *component)
 					       cs530x_in_sum_4ch_controls,
 					       num_widgets);
 		break;
-
 	case CS5308:
 		cs530x_add_12_adc_widgets(component);
 		cs530x_add_34_adc_widgets(component);
@@ -775,7 +769,7 @@ static int cs530x_component_probe(struct snd_soc_component *component)
 }
 
 static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
-				int source, unsigned int freq, int dir)
+			     int source, unsigned int freq, int dir)
 {
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = cs530x->regmap;
@@ -895,8 +889,8 @@ int cs530x_probe(struct cs530x_priv *cs530x)
 	int ret, i;
 
 	cs530x->dev_dai = devm_kmemdup(dev, &cs530x_dai,
-					sizeof(*(cs530x->dev_dai)),
-					GFP_KERNEL);
+				       sizeof(*(cs530x->dev_dai)),
+				       GFP_KERNEL);
 	if (!cs530x->dev_dai)
 		return -ENOMEM;
 
@@ -914,10 +908,10 @@ int cs530x_probe(struct cs530x_priv *cs530x)
 		return dev_err_probe(dev, ret, "Failed to enable supplies");
 
 	cs530x->reset_gpio = devm_gpiod_get_optional(dev, "reset",
-						      GPIOD_OUT_HIGH);
+						     GPIOD_OUT_HIGH);
 	if (IS_ERR(cs530x->reset_gpio)) {
 		ret = dev_err_probe(dev, PTR_ERR(cs530x->reset_gpio),
-			      "Reset gpio not available\n");
+				    "Reset gpio not available\n");
 		goto err_regulator;
 	}
 
@@ -947,7 +941,8 @@ int cs530x_probe(struct cs530x_priv *cs530x)
 	cs530x->dev_dai->capture.channels_max = cs530x->num_adcs;
 
 	ret = devm_snd_soc_register_component(dev,
-			&soc_component_dev_cs530x, cs530x->dev_dai, 1);
+					      &soc_component_dev_cs530x,
+					      cs530x->dev_dai, 1);
 	if (ret) {
 		dev_err_probe(dev, ret, "Can't register cs530x component\n");
 		goto err_reset;
-- 
2.43.0


