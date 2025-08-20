Return-Path: <linux-kernel+bounces-777689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9252DB2DCB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6B4A0426F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1817F31770C;
	Wed, 20 Aug 2025 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JJgtWNvr"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012003.outbound.protection.outlook.com [40.107.75.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890EB31CA69
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693299; cv=fail; b=Evj36VDZzr3LIzlC/Dt3VbpGGrZjE+1oLRefPgLICaB6s3Teipfsd+zhzFuUGrEfmwrdW8Iu1wkfWLYjDhgvhvp7hnX1zCPg2LNzFsyvBFeyyfgr82s3Z3WNNdKKSuC+TUT0paKSYbpcnXV7gOlB6Z2s67Yy6l4M465UiiQiGcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693299; c=relaxed/simple;
	bh=ChVKwr+68NnaI376mLOpUNmSsOVOUU/jP1bBtDo3DKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bMpnXQTZz04EixJyIsTD+e3rqZSMytRmSfdBKAces0kDbZBDWD0+qCf86d0JQccL+IZ7HGRAjDlGYNI+kGdQZXYFpptlYUD7O8v2Y0GSeG3nVNpG33gLdBuseJDeGOhljKim1NKVuuJHxEJoZr1+cZ4qpUwP5pMm5Am++uzIa2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JJgtWNvr; arc=fail smtp.client-ip=40.107.75.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5Q9/ldQA+4jJ6zvBx/tFfnQxKsWHaNWGOkPozcL9GE1sbXboc4IryPllhGbur+8HXeM9ueIPEqzqMWwbLvlKN2ySpSIyDIZaZ+MCOlsq79CTGAD+nR3v116nSNU2BaGcARatGXPrAD1epqJqmQ2ZVQoUeNVeYRNAgvNPBKWwfdRAKDjNaUDELsxYLWFW4RjOmI3eyT/PGHsAYFi0UxLKXJmWDzYDmP0ttywMUjL3FIKJb63eOdaYvUAH2dq504AOZOhhzY7GfwQpfk16ar1VuMKnEzTYuUIbWv7d5vmLuhmG5RQaJxWzUYegkL6tkBi8AklHiRe/BIcYf8oFA4hBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caurnx70MZcsX4OpzoCyBt1N+ufMSib5BWUrrzLIKGo=;
 b=GcDma2FTmSWNJ5BM2Kas2ojWFiJ2PCaLffaQmLgHAY2n0Vv8qSGLmDTpR/VwywRqS6yzWjs8SVZLuvrvfIW81+/Gy9EfdKsEcBx5k05koemD9iJO5HIrxN26LXiu/naZaNop/ej/Yj1ctiomgT+Wy44K4Ej/csGQ6NHOEBJ34EYmSyDw+zcDk1j7+9fEBNVcUUilNhRZNdu9R29n20vsNHZYuAXvjfi5YxpD1lQ9LWgqEpgPLMKFS+HhEpxzRvRLnrwncSuawqUfRDuU0RnxOxSca/w4K2RPeKu09lHjaQS2LwXWOmvpXKDjYwive2DWmSo76RltBH/yRYPEVT7AnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caurnx70MZcsX4OpzoCyBt1N+ufMSib5BWUrrzLIKGo=;
 b=JJgtWNvroqclcsFd9BZ6lMDl+CrGZjxfXj0HkLS6ZKavqcKCrRG9kSCNqkS0jYbEvoS9RIzV2bchc/LjeR/MGA7zyyNXuJ7jTioPq6LLPpjatJmodSrFIdQ3BHpH3POG9wK1JyYptkpPtRgH7ABpL+2pszW/N0SCT4Qxsc8VPMtoPbmr1/QFs5YZ1M964k8XUvbOZ/Jn5eZaMqY08xWEB1AoDzF3YWRXf/MKuc3VHREyNeJsw3EuBVUO9vk8Yiobh5pUMy480NY46OVYotiE03NeIlgSEjBbo+D+nrFFD0RapTDTWBrbpY0EGbm9gBobsIYWE9q4QuKZGEW7jftfkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 JH0PR06MB7177.apcprd06.prod.outlook.com (2603:1096:990:9b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.13; Wed, 20 Aug 2025 12:34:55 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 12:34:55 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 3/3] ASoC: test-component: Use kcalloc() instead of kzalloc()
Date: Wed, 20 Aug 2025 20:34:20 +0800
Message-Id: <20250820123423.470486-4-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820123423.470486-1-rongqianfeng@vivo.com>
References: <20250820123423.470486-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|JH0PR06MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cabe4cf-9572-4b1c-adc7-08dddfe5f76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oeq1bLhRYCR2VmM0dbbV5+AewUZ7D9b8QmkGNRLmBkXqJhXSkZ5WZ2bTmxEy?=
 =?us-ascii?Q?TS+7gP+P8ZhfRQH1Qwg77erCwY6I+8dCcukTFSAg6NqkKFELNlR5oyO+N+ZW?=
 =?us-ascii?Q?GyeM7L0KtLrecrqtpED0aCNc2fi10phqd/MSoLNlc06B7u2Ar3rzpk0v7pHW?=
 =?us-ascii?Q?hngRvyVH4wzdZ6ofUAnuedtRe0O17gLhcB3BGHFXx2dMZ120uIvzLNYvpM3r?=
 =?us-ascii?Q?MDZhAuijYbnZqGv6funTj/pYA5aNE1buncERr2evSYUQyQkC5MazcivlSUXY?=
 =?us-ascii?Q?0oCLeOZwVYFUJ0Ndx2Sgua0sfKnTbL8/bRODXBMGRPH+w6JSwU06yBhWOsnZ?=
 =?us-ascii?Q?+1BPYGhc/rR/VwifeiOd4m9c30/bovrJmayQbI/+kmE0dSej5b+JQjftdsfT?=
 =?us-ascii?Q?qPQrAEwghw5MMkYrt6085ka2m8qtv4Mb8MLSDFzQFmGUzDQuuIENEBz/D7n7?=
 =?us-ascii?Q?R5vGmKq7onfjVDn7eoudxXru30AVud28vmR7tegucQUzCAhpasYp90/Oe4QZ?=
 =?us-ascii?Q?hdw1mwEjFFUz5f1wukMb3y45beVt6ESq6vxETmmTJ7JWliz3OUllDzascGYd?=
 =?us-ascii?Q?tvdKRywv9iHp2eD2kNm0Fpqja7t/U2gDux/oX8M8hXw5WDERdxg7krDJ1zmt?=
 =?us-ascii?Q?os+bHnbvcdgxXM/NNuBXb8LnZi3INniTnTjCgorbZ0h7gH6MGxy6Md5zSScF?=
 =?us-ascii?Q?TqJPeQ2bp8l2ViiGlr3dtMjCHLI/gXwJym1fHqSqu/q3d0AdAuo3BtKUp91S?=
 =?us-ascii?Q?Wj/AlPXgyMemfaINyB7TVl1+U9tC1272gMqUlwOoxkHZ9+622l31ooGhqlie?=
 =?us-ascii?Q?taR9+HjK8wqTzsLt0bMkBgikRDnCyip3uBIDJ/yIhoZvuXX48TkO+IXYoxBY?=
 =?us-ascii?Q?X1oC50BqyXv2HrCZPMSTDuckfSgoptqWXPmxrwSFJz3U/HvgjDWk/8KH/Dc0?=
 =?us-ascii?Q?MYqj6HZXxfS5tPTYOMtXrsy2sFJG+avbCnkViYye3hj8QEey742asTefJ8fV?=
 =?us-ascii?Q?nWdP5tj233CIM/5fEozVIJNHE3WJ7k3iB3RzAkvWKhtbvNn+WOCMtGXL5mD7?=
 =?us-ascii?Q?oY/MaXDAWlUVl85ceUg5OJJZilQGUb7hCWaRU5513wJ149Q0Q5xNdeyu4jYp?=
 =?us-ascii?Q?lh3QZrKyvhQX+5dlYdORfNxC/e0a44qQttgU04/ur1kAkVGJvuI2Z2ysFr1i?=
 =?us-ascii?Q?YV+Vrxk9XdwRFK5TlLcYW2dFFgu469TxCmkkODKGCtgyp7DAjDqksAfykhQD?=
 =?us-ascii?Q?QsRDq++zyuGLZ9Y+HaN1msdkyHURY66CKYkin7XvszaOO5EFFNOEIYTPRWjG?=
 =?us-ascii?Q?jpksDTtk0w2DWUyKL1auoaVxMqOVc2O6XY8Rax7PGyL+ogIKoE53QEnUNUzf?=
 =?us-ascii?Q?mx9tx4mMU2pYrEgBWK0GsJrJhNH6SC9292oij5bzi+G9BC4JS7wc9lPIYXs+?=
 =?us-ascii?Q?xxuSooHKnlYi+1VHca+ZHGx/0U1rL+ZF70HMMqSv5TmYpNs+8f/daA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RfVC0O7bM4Piz8s51SV8a2AiL+SYHfF8383d3c8ZgZHLu6eV+pyJqmOqjiz6?=
 =?us-ascii?Q?A/v1z13VwC12GF0y2pCrHNNf7E5bjHy76dA2X7dTswiPp/MtZpH1s7ThOpF7?=
 =?us-ascii?Q?oNOyJZznI534/wj9EBr2+7+8O8I8ypVd2XqvSS0cvvbNO7P77vodEvBK7eEp?=
 =?us-ascii?Q?eVYVyPgbBVL/8791O/EWTCpY/fhL5gTYDaEra3vy6y4xNtxqYxcB+hb1tM/K?=
 =?us-ascii?Q?RVP6vPlH9gup3UTZLFnMV4qheFXfJcPXiU0WYypTUrJEyAdujscl8dn4uoFz?=
 =?us-ascii?Q?LYzbiJyGYVlbVh+d/ekQD9G7tSEClNt5T/iYe0GwAYt23KSPaU5OZ8VOmNSN?=
 =?us-ascii?Q?sDq4OFDfrDMWuEvFBL7Gax1OWEc/+DFqNHCNWPdjj/zq7+mWm2g6cHGq+K1y?=
 =?us-ascii?Q?negC8vg8fGy0vib19ibzEhZzkbbNNC0LQsYHaudRMPWZ5SltQHqMn7vGrvbW?=
 =?us-ascii?Q?1xYMLpPftJxvr/hAdgXzgWLKTBQNjgP7itK7Iro83p+XOV21/WTRan8znovZ?=
 =?us-ascii?Q?Ic10P3svL1cHb4MueFqfwaVS/8YiS0QHf59j6e9PXnrtaO9ny31bAnyxJ1xV?=
 =?us-ascii?Q?zcvNQ95wddx1leVZUSvoE8EIq+m5UTCep2PhS0NMV2zkZ/kgeywOLSgH2ExB?=
 =?us-ascii?Q?eX358zR+LX83glmBLEAnXmWtLWr4VW4GO5rOQUr7NeKtdAi9UMCgO3VNmrO1?=
 =?us-ascii?Q?CgS6QF4Z6XaxXVV1etv1/ZgXwMBuF4KAQ5EYgVs8JKSDUjvURcJ2R4ymYyaa?=
 =?us-ascii?Q?9ZfhXC9Ivb2jU+UuNfDgDmdiin9XCTKsS2YA3hFxqLEYBa5SB98OeSRT/+4V?=
 =?us-ascii?Q?BbxgT/WayeLD1/EvyUxzycvWZql70ZRpYY37ROi7wBMZdJIRH6NsR6La1JeQ?=
 =?us-ascii?Q?7B7EfH51rI8WNIRfFNoRmhuBoME4nHX4LgKy6Oy1J45FjGHJQ7aDFQxRGCAF?=
 =?us-ascii?Q?jRc9KzjUtqjf7kkanCjN/6N2UjBg4vhIuRTPiXpZaz90fpMoGGcLBqLHRabb?=
 =?us-ascii?Q?Uhg519ehZSmHtipM7H/tpPL2FqbOAmgc2cdcepgOz8thWLYfLJpAnMOXJSmw?=
 =?us-ascii?Q?dvu7tv8bdx2Oi4D3V6bscLzoQVHXnhdjVHA7eoFGZrqMyUP6+ZqWF9Os9zMP?=
 =?us-ascii?Q?YyEwfLmqFvRMMpr3jDaOISFS+NE/L1E/SfbniCVS6URvwQgzzsjwwuhtjUug?=
 =?us-ascii?Q?tMBsr1px7fo3uxwDy39DIqjwC6QNzA/JS2H4ztHiWedCLgybKB0L2s4QpVLH?=
 =?us-ascii?Q?T5OlzMYzsuL/GjxZ58zzWzWqfoCqsT7E7hheyLhoH4nKd1GA+O7jVGkfOR0S?=
 =?us-ascii?Q?EXtkFVdwsRaCyGma/PhQvbWfOMumpL7P1fMZirg4yabPwd9VNlKkQFLXP23+?=
 =?us-ascii?Q?9Elav5t9RSLZLX2zhEgMlxAvLQruOB525CLPaogyiA7n1viHEcaYdnPZNi/f?=
 =?us-ascii?Q?mxKWAqBd3aCCCD3oYq+FwZ1EOtzJWg9rkEJgFy+VVDV5x2CNh6Yb0MP4QoUd?=
 =?us-ascii?Q?7jVKd1Taz4v64SegEWMncZYgeNaah1TgOkuujTagYV6EbBStB9Ab0maugJJO?=
 =?us-ascii?Q?2aNfCwnqkZH1kbIoS/SB0w/BZfLsuWr7FYgDngCj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cabe4cf-9572-4b1c-adc7-08dddfe5f76f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:34:55.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oz+97NfWNvKP/fgzY105lmEOU8gX8qdxHtYARLX1poxc3LLn/jILX3Ix1ogPTK/JjMcwZ2iZzAmyMebfa2VhsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7177

Use devm_kcalloc() in test_driver_probe() to gain built-in overflow
protection, making memory allocation safer when calculating allocation
size compared to explicit multiplication.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 sound/soc/generic/test-component.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/test-component.c b/sound/soc/generic/test-component.c
index 89b995987e2d..2e49066dedd4 100644
--- a/sound/soc/generic/test-component.c
+++ b/sound/soc/generic/test-component.c
@@ -547,8 +547,8 @@ static int test_driver_probe(struct platform_device *pdev)
 
 	priv	= devm_kzalloc(dev, sizeof(*priv),		GFP_KERNEL);
 	cdriv	= devm_kzalloc(dev, sizeof(*cdriv),		GFP_KERNEL);
-	ddriv	= devm_kzalloc(dev, sizeof(*ddriv) * num,	GFP_KERNEL);
-	dname	= devm_kzalloc(dev, sizeof(*dname) * num,	GFP_KERNEL);
+	ddriv	= devm_kcalloc(dev, num, sizeof(*ddriv), 	GFP_KERNEL);
+	dname	= devm_kcalloc(dev, num, sizeof(*dname), 	GFP_KERNEL);
 	if (!priv || !cdriv || !ddriv || !dname || !adata)
 		return -EINVAL;
 
-- 
2.34.1


