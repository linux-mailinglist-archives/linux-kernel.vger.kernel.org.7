Return-Path: <linux-kernel+bounces-820985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9868BB7FF54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3641895A53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22418309EF3;
	Wed, 17 Sep 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ch3W1+vB"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA482BE635
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118277; cv=fail; b=VptLYu/4d9F/rDoOB+mDZ5ysl3QvmeiXBycJbtVkW+lykJKv9S5zbjatKUd4hAt9LFybqFDzwmnr1TGC0afx7/9fBX87mDuLrpSuDLrOBoHlOOEBFgS1Q87eZybd9nOCf+bVjDGiQYy22oXUh/HqHvaNfV8zOV7qXMVRzl27F50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118277; c=relaxed/simple;
	bh=z4LuvnR3mQfqai3aVWxt0QPKrI7C1y6BB2UsDCCJygo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pMu+/f08370r3IsAda2IIVIaX8RFQyeB0mXSiaHhe66kUXNiasyT4XQP+PLNYVUIoxCE5ePfys4mK+hsWI9FxQXKYfCb0DwT4BWWkxcMkoTYXRAhPZavBvmoYMlcZCXnvBjuxffSdCGRoq8BLQ9+dMUrxu2VCKgB4BBxmPTS6G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ch3W1+vB; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWiYYONKKGbJMPxnxqTBnKTihQ/iGQkjZl4KctvYDcqcz8yqdYj4eDB5o2l08qd44VrTa+efS6tX4cHb+X3UyiIubhyh6OF/XA9YHAuLFBCPQRwOLieKLuCDAY4UMV70CtgcZGK39tLvj37DNeCjHyyfLv6BpSmJaRlDi3/msF0L4S8Rlzw8PB6/Akc/tvV5u3RTdOoBmOj4Hc4rtL8dEVE2FACkamPFAmGGZnP5UqxokoZGpF5UTPxaab3BShPGkPZyPGe18IlpAp1XGKFnotalB7iwtrTiEeIznmtoEry2LaLWHOpcMLlseg6eFu85pP8ERVNYSkq3fyrUCqUZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfAB89Fjjpo1gwc1s+Lfb/YlXPMIzD+ARg53hmcmoqc=;
 b=FarDiXE3dZb/0pfZEEH1vTluUdKq43fmQvaDARlBIVTWPdssuOF6EA9RpEVSVYdfUnw0dM4NUCd1Ylsg9WfffsxO0jWPRhS5mfKVDaosbEph+kef2zyAYnJUKXRbsCVOp4u9FkJnYlsD4Kcl+YMUEkVRmiomo4/T46SqbiGsn4mKBh7XvOZrP8hWefryaYX603B5MANPwT7/cfFMqFxZpWZtOecZD9iJO+iL6wHyAQsiG0iVkH2wkZzu9YB6eILMHIXAk40rxgnQIaD9nkkLh8nm8svVAIWQnBKApr/xprRVnsTTYY10CcZBz/vc8abnIlHNishtnvslbDy6QBBVJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfAB89Fjjpo1gwc1s+Lfb/YlXPMIzD+ARg53hmcmoqc=;
 b=ch3W1+vBsFd7pbkojLQ8eEWep1IfeuwQfDQHEj9EYbA479qcukgscZ1P9h17XZlKh2nPYLt9rNj1QotNX1fsDIK+8uZJ6kRTVk1Ndjmxu1xXxD8i86ELr9Fpr+6/GOtvRySk5eyXpkPgikJhNyc4bDKZfig+e/kTVdyM+g44EzISypVTENORL9CqbsMc0jmBZQKBWyRSA4jt001uA2MAY9p34/c7EUfxQZVDUV55Q61sAqkPNh57Q/vz6N/+kFQLxAahhaAM0ObY64O/U9Fx1x6jYRwPTsRtvlPUZPQi2ShYs/VbYZQk4lWfnE6q9lc6Pp2Ra2nh/BtLNZOI9JJl2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10656.eurprd04.prod.outlook.com (2603:10a6:150:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Wed, 17 Sep
 2025 14:11:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 14:11:08 +0000
Date: Wed, 17 Sep 2025 23:22:46 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Harini T <harini.t@amd.com>
Cc: jassisinghbrar@gmail.com, michal.simek@amd.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	git@amd.com
Subject: Re: [PATCH 2/3] mailbox: zynqmp-ipi: Fix out-of-bounds access in
 mailbox cleanup loop
Message-ID: <20250917152246.GD28673@nxa18884-linux.ap.freescale.net>
References: <20250822045732.1068103-1-harini.t@amd.com>
 <20250822045732.1068103-3-harini.t@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822045732.1068103-3-harini.t@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:4:91::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10656:EE_
X-MS-Office365-Filtering-Correlation-Id: dcdaaa31-8db8-4ff9-0f7d-08ddf5f40c69
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X4I29jgtaIfxm8Vl2Hqygp1N+IfBXRKTPDD7835m8/9aPcqHWw32m8E3MYEw?=
 =?us-ascii?Q?KcMdhAlZfkjMQfv/dnsQTh4JLe6s6nS5GykRz0df7P01s6Jq37qvwlnI/nXT?=
 =?us-ascii?Q?jwqa+iwQKub/QOosabw2vMnFBWHuY+BKefmmQGaJhhvEBEzcS/XRUFN9+psc?=
 =?us-ascii?Q?FA9dD3jKD5IHtuusfYzzLUuo9g/8MJ+1Xni91mWh2yMHsFl5n/ZsLRCnpTS/?=
 =?us-ascii?Q?VJYmjTsLHX5fR3ilsjLM3CIOC2QX7ZH9KK76xkMOZN02/mMHM33MlA8GgNQe?=
 =?us-ascii?Q?HHk7YJWvOzNZW4vLRxDXvm27DkrArMdwmUf6tMigPA2WkfgOA/K1Or4Pmvhh?=
 =?us-ascii?Q?E19V+JarEK9KE91C++izB/UEAWWP5J2/gzEA50l5GnBF5TYdeQZO0yTt37he?=
 =?us-ascii?Q?nVfyKAlhHp/pFCFJgJIN1TSdqs6NR1heI5tKf2s12EQZ2kXtOTf9U7QVPVSm?=
 =?us-ascii?Q?8ZXh+2qbW8lztH8BQK+A0TL7Vq4Vhjaj+RhThWO137ytyhTzX/K5SGIWgYsl?=
 =?us-ascii?Q?8Jc83Ei/MqewrwwzRPKkvi7SYmmTg7k2Qr651zJCueo2h2JLvaKTmdTujzld?=
 =?us-ascii?Q?Wug1pSeBagVO7JavVb2W+I1giOZFvK0Z5A3Nv/pTDYcZeK+sk9iwmaNfU+ef?=
 =?us-ascii?Q?ct7M1neevCxrkMmPmHb7cyp58J4fSsOjFZeuv272im6XYTkbYOjTWQiM12XE?=
 =?us-ascii?Q?evqwa5fThrNhKTWoZ5vjsJecYg3oT6szGYCuDdG24qdmxQnMXIivScrQ2GmC?=
 =?us-ascii?Q?jWJHpRUwe7SME6agh0sZPA8CnDfVedvEKB+tL2e0awW1CuYjvaDl2Eytb5vP?=
 =?us-ascii?Q?Tex5xopGFF/gJ9zXgsZdoIspSSnXZgfi1rTZXcP56QQ2z3+HtIUAF4gJoGDH?=
 =?us-ascii?Q?5pOSIvPKP5laabQ+/W6FsQNGRbsiS27EMONmREOs8CQNrchXMebC43sLf4fh?=
 =?us-ascii?Q?gSGCN00Hh42InyO2VQ4+zZtRfW3e0OWxwJMVMog/J/gZKGFt9aslYjBKZesa?=
 =?us-ascii?Q?zZ/DoapV0IX042m/acIjPIzAPcuIaJqyaN1JMbJDk/LZz+WUJTuVIofoWVwB?=
 =?us-ascii?Q?ZGFNJX9uuxGXzRqGzB7cVTgdTltUStHsgMWx+Sc/kcOts5Cd1F7TqH2qtwWi?=
 =?us-ascii?Q?EY0sJ3KXToQyR++mjJ5TiQmYr2zvnS1DfvOFJuCcVpf6lxF/Lhbln4J+T5x9?=
 =?us-ascii?Q?wgv2Ds+vMKEaL/oxclaCUk4C35oFxg0k+VuvSlqlixJgz0luWrXeS9g6iCdS?=
 =?us-ascii?Q?A9vswTzuTDZ9nQHJ4sLH1fmp5mHZc0zDF3lG65dqDuzjUi/ntwW2v/XMmIAJ?=
 =?us-ascii?Q?jegmXrcLZVTUxP8a85C4l1H66JT/CDyAH9bw6Rga3O265oHnhDE7cxXZbySH?=
 =?us-ascii?Q?WCDDl4rh1qnXWqewewYEr54w0sTDz30UA1G2IbHm0a5SFv40n022ZSIEjYWZ?=
 =?us-ascii?Q?gN+F8Lzb7tb58VodrZ/ExfcBwUFeOhFrNizN6eyFpNGWWBweS4hZng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zURe60b0juuBsuwmFDv21H38RLtjkuE6dNDOUuoHU0rlkeaLjOPTDFQ9V8Uf?=
 =?us-ascii?Q?LkKlL5+Y6/HOvtEhVa4zE7BcRHcjRMCj0ayA+OuitoH3EOZ+7qezYc5LdY/7?=
 =?us-ascii?Q?3/LloyhVF/mZO+pipya7qdrKIsAZtBFW0Now+Cw351dLminHfAaIMwHKt/pA?=
 =?us-ascii?Q?6aS+RDT2RvRLdgT1htVXt3fMFGyEDNe0oukG2TwIxc/tN5OFB0YRD33M3TOl?=
 =?us-ascii?Q?ic2wrUlwMkGF0J4/2En9STFEZrVyW+yspzfyQE/VNN07H1PTZieggpIpn7qW?=
 =?us-ascii?Q?s+x6M/C6905XGV+PRAZXRKrTNA6yoC4B18JVSbzNVEOydok1aph+t/MQMvrV?=
 =?us-ascii?Q?plmtWxI+k/lNxLJJRiDgWP33DFkQzInf9AQ/m9TES+7/brKTDZ+0d5Z4shTZ?=
 =?us-ascii?Q?RMgjE1ZLeMBq6e6o+Vx+GbT0AxFrY1MFeVcvzmdF8VRZmYqQjSOEzSm4ipbL?=
 =?us-ascii?Q?CzgY7BwAyvaxfiFGurnRFqgrHpTFc8dwtrZ7Pb5rDrySHcN9cBzgVk4nH43h?=
 =?us-ascii?Q?B42vnntfEBcXCGW6ZXPVVsFWqGfYANQ1J+mNBrfcgwIwkVql9s5M1fm//Ft/?=
 =?us-ascii?Q?Bw3QO4yIg7BkcQx5racgp5txUnyepVrc60QCQ2zU93830V11utu+qjAIFpIG?=
 =?us-ascii?Q?Ie0/LNYZ6W5BDIfDbYYt7C8z6+ey0dYpKZg66vTF0VNDI5zaJIUNcFFiWQn2?=
 =?us-ascii?Q?aTuDevA/wiwScogAa/2o0/XpVgQmsYku3UIEQRFJPi3RoXYySxqWkU8pMhyQ?=
 =?us-ascii?Q?Vb4LM2TO8wRmxDK51ug/Hc3+NSBG6sSPJX0VaTpH4YrALsQYkrKOWKgJB3gw?=
 =?us-ascii?Q?A5jBfGlbK5Q0Wo2vb6k6JFv4e6Qk13YCO2/IX7Tg2jUYyWfrl9uyl1lR2bre?=
 =?us-ascii?Q?JNydoMOh9Jmh8wfgzGplRkPRtfW/R/nVQwUhOYdUnJ1mnuv4XjOBTc+SUl71?=
 =?us-ascii?Q?nuMutn7HfRu7TmE8It8uRNJMxSUp1XjNAuCsc1wSt8uk0758Ab4mJtp0nlK5?=
 =?us-ascii?Q?luUIYeV0HEiJhFuT3IGBkqURt5afEf0rN++wPxBhtkY73i8eAP+WGT2PGqWD?=
 =?us-ascii?Q?5lcz4sNT81Ym5WqCFFSxZN7OW1Jlqh9k/xrI+Dk71S+CPjWWgd1cR4qmxC37?=
 =?us-ascii?Q?bR9wQaygNMixqhGNl8l0P3aFJMGwWlgOqFyaD3Im8XdVFUHl18/dK1zlMNs3?=
 =?us-ascii?Q?Qg0taK1Vt6O9530EUuGbASkAWunPTOOcSwkZQIsVBQsq8uON0qK1ealBf8Sa?=
 =?us-ascii?Q?pqqTw58cOrFKPc5MFkeUHYxVxIMuoU0WzMPDqG9Rh3Vc3lncjjg6pzr4NJAT?=
 =?us-ascii?Q?Lz1p2D4IUnBK5JjSv2A5bKV3ppF7NlbFLgacOcZ5CJpf8iiyH4qhxK3muGpO?=
 =?us-ascii?Q?Skus5cQwx6ZsrvgaiWyKwGeiYct5jvo8Rh5qNzWBCQSnq9+S86jMhFB0Mk+7?=
 =?us-ascii?Q?oOXeQ/+mFaOiCfw2MoBbshq+8f21I+N9taxK7uAOcIR+HictMedJCDc1aZlP?=
 =?us-ascii?Q?5aesxe1Dw7sQfG0t5uRevYETejRnlmCDv+RSZzcAg12frb95rFm/kFf4s/+y?=
 =?us-ascii?Q?0F01xNVAE6JJy/PGMB3X5v0w8n5Co2AyFhHH0rfl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdaaa31-8db8-4ff9-0f7d-08ddf5f40c69
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 14:11:08.8747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIolCEIDIM+tDipK6TuYIq3ywFACcs7J/JrfVguOZ9O2m8raITfYT7Fhk+UzxJUSno3uE12emGuz3w4FdyZ/Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10656

On Fri, Aug 22, 2025 at 10:27:31AM +0530, Harini T wrote:
>Fix mailbox cleanup loop that accesses array out-of-bounds by starting
>at num_boxes instead of numb_boxes-1 for 0-indexed arrays.
>

Fix tag?

>Signed-off-by: Harini T <harini.t@amd.com>
>---
> drivers/mailbox/zynqmp-ipi-mailbox.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
>index bdcc6937ee30..3b806d1f89bb 100644
>--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>@@ -891,7 +891,7 @@ static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
> 		xlnx_mbox_cleanup_sgi(pdata);
> 
> 	i = pdata->num_mboxes;
>-	for (; i >= 0; i--) {
>+	for (i--; i >= 0; i--) {

I would avoid i-- as the 1st param in for loop.

i = pdata->num_mboxes - 1;
or
for (i = 0; i < pdata->num_mboxes; i++)

Thanks,
Peng

> 		ipi_mbox = &pdata->ipi_mboxes[i];
> 		if (device_is_registered(&ipi_mbox->dev))
> 			device_unregister(&ipi_mbox->dev);
>-- 
>2.43.0
>

