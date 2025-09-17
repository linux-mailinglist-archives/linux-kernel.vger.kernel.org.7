Return-Path: <linux-kernel+bounces-819785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FCDB7D490
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DFB1763E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43DC149E17;
	Wed, 17 Sep 2025 00:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="hzGOvnNs"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011018.outbound.protection.outlook.com [52.101.125.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C71736B;
	Wed, 17 Sep 2025 00:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069139; cv=fail; b=mEISGmzas5PHL6YJfPbiQrXzRgC0QTzOtMHCOeR+lJ9MnDf0L/p6phBHvdSYayPwnJsaROBtz5BTcfnzYUkfaOzA9P0kfHm84FlGZjvUGKnVXeHpadIHIqpafGvxT4hhea2xZU9Ew5XThj6KkSHucbCDIl0Er0C3UwQYvphQm5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069139; c=relaxed/simple;
	bh=mnZdmCZx2ngA9Zbv82bXVZATnQ2R2u3a0GkR/nDhxms=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=J96qnT3oM4PWqmGf2QGsmJYStrJIRkbTAEjFf6JGwRcKiYt/BVnCfHgZ/S88/j24wukSJbT/F38Rz/14YibZaxXkJmLBh8Ssm9rMeOfId+WFRZDL5NSTCWqqqlTjzvuftiw4RxTrdmjVZJu0P8fqX33TL+VQ3kdM27N7M3xWw5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=hzGOvnNs; arc=fail smtp.client-ip=52.101.125.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZjKpP6rqdpkvrvguXtfsUciB2wKVanSFQ7RjxqaJfpa9Xzz9jSxtWOTxvj2fmlKm3i/WuS2vhLtOvIMB6S6HZ2AIWjEfZ7ohuVmPPuEZRz6uK+xcMNLMwXXQ+UxdWKiVI0J1kVV9EtNXPyfpd9Il8w7/rMWziEUkMoLbrcpXMmij/ClHCePbTw20+VzQPAvckBA9bcAP9dwYA7d7G+B3i0Tiq6qprOfvGKdLyGgTUMPQvyuXo4UWEm009Z/G+XGII4nBNWUHVZ2pMUe8j4biM5OjH4eWymGwGXmSYCi+McC/vo2Esqqu4r9LqaAkpTkcv+xFrWoueBsTnrwX6ErxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo4aqY6u5AZwm5E2yJT5QfEE3m6c8vD9SNxbiB+Mit4=;
 b=vT0+GtkY0Qn740xwUS4Gh2kOBK99d2VP78VIuKKQJSNTJ1fA7Saj4MwkttByHxNa5Dsbb8TtD7kuL8mg6+w8tRiXQGepFMPy/jqoxbNYEyYcKyesHpchXg/BMejwfHUAt/SykiS6uMC2H+DR8s0PBi5t6qj+w/P9iHGbgScWKn/NuV0JfeGT62pNKrPH4mnIy0FYqBk3fwQ0uYSGFh/ERg5VILWagqs+A/maMoJaf2vozaLYcKwtzygUyfk7vQ0QPD551Rfwz1o2P7q6WMGMvbmSaWjm3B8LVZmG7yqW9SgdHzectDFfXJQmt7582lvjKZ6ILAf62jjbNn32r5K6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo4aqY6u5AZwm5E2yJT5QfEE3m6c8vD9SNxbiB+Mit4=;
 b=hzGOvnNsKVLzDAOSdZDdnT9Z97rdAu8A0olqX3OXzsVc1TH4TTIIeIXjosOC9EysmxE8Mfx7dWWsWj7bOuaDe04bVp2ualOdhVX/LGOaGp94MgdkU/ghLelgDhf3xuNrEyJEPBuMFDCu1UA5z9mhP+p3yoLiqXifWNIc21Efn2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY4PR01MB14650.jpnprd01.prod.outlook.com
 (2603:1096:405:235::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 00:32:12 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 00:32:11 +0000
Message-ID: <87ms6taph0.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"Mark\
 Brown" <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai
	<tiwai@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Alexandre\
 Torgue" <alexandre.torgue@foss.st.com>,
	<linux-sound@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: stm32: sai: manage context in set_sysclk callback
In-Reply-To: <20250916123118.84175-1-olivier.moysan@foss.st.com>
References: <20250916123118.84175-1-olivier.moysan@foss.st.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 17 Sep 2025 00:32:11 +0000
X-ClientProxiedBy: TYCP286CA0356.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::8) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY4PR01MB14650:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3fb69f-2112-4f74-2a71-08ddf581a479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RpGNp8vtGdPR6Ob+bWXZ2BuX2vMvJawcao5fSZOwL7B+PzKJ4H/jt5afxqkG?=
 =?us-ascii?Q?H8zO23qZdYmZP/QXWR2J1AS/IhhgSrVt8Qd7pK6Qc9XYKp3MHYJXfZU/Zxj+?=
 =?us-ascii?Q?oEdiz4g3hf8nAGiHwOT9JwXCNYfKB6p/yzaJaeXIhtwTAzl8vP3i9tRJPMZr?=
 =?us-ascii?Q?jAKHcRyDQ2UsDp8cTXiJ6GzqI2MTZBBI+hupWOiLOBlJkXUpNi6xru2Bg3wm?=
 =?us-ascii?Q?cR+LO53e0um4SiwvLwLQ5AdlIx8jQJLLKuN5DlzaY5zVUnPktzL/nn7bstCV?=
 =?us-ascii?Q?pDQf2JfAl5apCBymMshwQ5HPFHtPW5WP6xJO4zPle1I6LmoRI08iJYeVLVpe?=
 =?us-ascii?Q?P0qJ0hs0nMmtAKlKN9/PAsa3QeoLPJxSEeSfpz86sFePD+G+/ZO9+bBeI/DE?=
 =?us-ascii?Q?CN+sariJNV4jE2bW2eTPP2G2uuGLf8GRfad8WxdQJWQkc4cTRWJVx/QhJlHV?=
 =?us-ascii?Q?7Kv88hPln3XGBV8f71DJ4mHAyGkNtmrA3JTHfciGHK1AfWXBwd+TsP5s/Fxj?=
 =?us-ascii?Q?wvd9l1yP5T/di4txvLWPQG/71Ul+R5uz0mX1BhX6RCkG20If07GH0eJrSeUv?=
 =?us-ascii?Q?eTUyx4VdHK6nOw/1Syw8DnDZcIa1TdgI4qw7Kjh5I00DwVq8xfdi+BfhPKLX?=
 =?us-ascii?Q?eH/ldhRtWXlHnI06NJbLmr6g6hDPbJaikcIebd4pZEOYEL9SKHgYWdxCfYV9?=
 =?us-ascii?Q?GbUU9cfa41tRL9CJILdpm9C6EQLxqBy2RiyMW+spsXkAzleqGB3LoI6jMoGt?=
 =?us-ascii?Q?fIuvS2zOrOizrs11TWdmxRocPJfAZlif7pQffh8o3k9lutw9Hi/qpBwhV7G1?=
 =?us-ascii?Q?1WdCgrOlgsXG+WKqZ40ZwheRmW2++7wq6TYkb0Jlz4yKKFBXoHCMTLhVhh2A?=
 =?us-ascii?Q?58e+5XqlmGzuFXrSVIod33Qzt5ALZOe2hY/bb44WCTAzgP1v4yuPhn6hukZB?=
 =?us-ascii?Q?NUBGHs2MdT+ghUvGwZxBqsRtICoss3oso26VKed03XtpETgsg7HjQLM8Fril?=
 =?us-ascii?Q?di5jKOKy7uqTTZXcYJEiqnxP19e/8t3HHCy/DbnELyhlO6lNfDMAOMKlioEJ?=
 =?us-ascii?Q?04CM65Mp0d5w16wJPZeY6QZli8zstq+8CQ8yDW8akc+ojJg/mKXP4ZqqKKXv?=
 =?us-ascii?Q?IdxUxExR2/PV6ID9B+t7t2Qynj2NCPbBoCRAkCuKe4AsuvrhMoe2rPOK3aQq?=
 =?us-ascii?Q?QrYEE8wcIPWUfiPSlP++BTwhOytKK3M2AxBKE11nS9dFVupsyPcGsklybMp6?=
 =?us-ascii?Q?ZhUsUB7MjI3YOxKToq7lKH1OPMxspmdVTerpByH88if+h3LUKxWass70GJwn?=
 =?us-ascii?Q?lB/vWtrKzyXhQi+446XNCgIpQvHZhhNRozfSg8z0j+UY+k4N9YT5btShO/HW?=
 =?us-ascii?Q?6+3TGEFg3GK6wpc8XWO/evYewbsDqJ49Lap59yZGr5kLYEiIOamd1jk1fsye?=
 =?us-ascii?Q?JnLW03HroMV0JopxlVeUno3HC1YN9eSRjXyliLq1+pkpU/CTspgPOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qc9YNDBcVlvTNiwiS/zWUk53pun2jsIqAkt8ii5wLx2smi79VrEZmOXrmHY2?=
 =?us-ascii?Q?dhpxEaNb82Ctff0Wp2M8eAj/GcLS1oDLwWRguNllwAShyLviZKolVktW4q9U?=
 =?us-ascii?Q?oXPyYJmWMZPbMG7LmaUgTUJJM0UcVfe9OTtgjbCeyT7wp5pw8hnzOGJuo2UI?=
 =?us-ascii?Q?sS6/QINu7HEZLtkI5ScrCheZnmbg51Q1EX5lu3OHhJBV8FrJr/A9ArFNH+8z?=
 =?us-ascii?Q?elMdapyeBGbZjWBXAfYlvupSpMsZLY01pk9nwj0ftEj7IkoH3DL0c8ympEP5?=
 =?us-ascii?Q?St5kg+oszguXmYhMQos0E911CyKWmb+Rs0SLSep2mrfHkvZZxP7AIAkz9ZGA?=
 =?us-ascii?Q?MKSkfZ6PqtRIOdar5WTLpQWg3hK3Fww9MiadBi8GMf0QWdF8RQpJMHRlvjrK?=
 =?us-ascii?Q?gEtG6yFCJVTtJ5MAxWLggJUtIMK0fUt6nTRCo2jMJhHdyEWKp0+WiX11Oa68?=
 =?us-ascii?Q?AqwXyEo6mHXALzu/5qygx8E71rMvso+6qjwQ77hr4713Pd8h5DmNSH+Ws7MQ?=
 =?us-ascii?Q?IqDACXur6XhHLqp2jyfV1YHDIMoXNHPD0fI7RSYdqnMxHUFgl1K3oxfqwv3T?=
 =?us-ascii?Q?CZW+fztckthjZZAirHUElJm0f9Vu1m+iuUZ4ZkA/DpYOh/ApW3YZ9w9DThbV?=
 =?us-ascii?Q?3HWTyFqCsQ/yH+MS/y+35Jh14+OHFnEyQ2TprJ3iNrjDm5UeAJXaX+ZeZOeR?=
 =?us-ascii?Q?4l9NbL90umu2ShuCC9vKhMWuY6vyr2bUiWHKu5GJh9VS47YDN991Y3Davkaf?=
 =?us-ascii?Q?YmcYmVRaAKklvbpQbSAk3ehDTHeO6rmtzmwVtcE/4sxGUuuayqB8bjI9bGPk?=
 =?us-ascii?Q?MDxl51x661G5gOriGb4K482bCASxEGNDg2CIT4TclF/nLWTk9YEJ7DTsiLjX?=
 =?us-ascii?Q?Pc/Uerq5dhFgtYsH6zqSJw75TbZREZUUr6dxD8hpta4tVL8iJASuiQOFfMIO?=
 =?us-ascii?Q?skMfMEj2gX1qJr8qDq6MTTjE7cvhL9fCiNX7U3Zg79MW1tTd1ewIRKRxCDWF?=
 =?us-ascii?Q?SpPfQ3KG6kHYTAm4azDCmyEmZVaWdrMjHuPeSoJWwRU5by8p5KGTXFQ49IZT?=
 =?us-ascii?Q?81sMGGCZ//ejea/dMjimUXrsdv+utnIQdqjw4Y5jvr1p8CYvrb/e15Onl9Mh?=
 =?us-ascii?Q?hLrTzu+86WYIJwFaKlszwKOZJ47enLzvRUOALAmDGoJkoMmI5WuJRoynQ+Ha?=
 =?us-ascii?Q?SvTDLHHv0rL26JAJ9ACNfzTwc8Y7XRmHaK6BZ/RVgtx+t6OS2O8Sg8XKzPRO?=
 =?us-ascii?Q?UEF0uwcKBdEk4YVA5jn7u3vlp9kt+ZpXq2cOtBucrAfVoWPZdGVoTKOOz2g9?=
 =?us-ascii?Q?4ACH9eBB81vw/z0Ok/PBgrkgGFMixPvUFhEzo57iOEZKkM4zXcHKYnNuyTfa?=
 =?us-ascii?Q?yhMwHVfQdjFAfBOpZv0n/RgAPBYFrgdbeuVfav73KgDsRmCMYf3J9IFiM2qr?=
 =?us-ascii?Q?Gz3ijzfklfSS+tBV/5GBbjtmVrPouHtNp0xudvjFDw9kYZWFBBNN61ovL0tn?=
 =?us-ascii?Q?YrC86DZTgO/FShzDcfZFLPY3kof52jF3eX9L/bWGfeybrhpCShjZ8HkKoeaZ?=
 =?us-ascii?Q?69ez12Pq8nGJPcGik33tYGcw9G4MD25lskJq8K3kCEr/f8YkYZvXDqlICPhV?=
 =?us-ascii?Q?M/S9aVUtqWUkJHUBiGHZbLw=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3fb69f-2112-4f74-2a71-08ddf581a479
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 00:32:11.7685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XCwOn2PeMzuY3UcKjmH6vASB+TzWA8Ey9n+7LK7e8FFo4HnaRvtHcBgwZMo93HqooUYLHA+9c70TDx6DgStG5iHHS8PZR9akLzEZIWwY2H+VKZnMsps4ddk1uWH8yjw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14650


Hi Olivier

Thank you for your feedback

> Here is feedback regarding commit 5725bce709db1c001140d79398581e067e28c031
> ASoC: simple-card-utils: Unify clock direction by clk_direction
(snip)
> To accommodate the change introduced by this commit, I added the property
> "system-clock-direction-out" in the SAI device tree node.
(snip)
> * Before the change:
> - Initialization:
> simple_init_dai() -> set_sysclk(id=0, freq=sai_ck freq, dir=out)
> 	Calls clk_set_rate_exclusive()
> simple_util_shutdown() -> set_sysclk(id=0, freq=0, dir=out)
> 	Calls clk_rate_exclusive_put() (releases the mclk clock)

Here, about "Before the change". Does this "change" mean "before adding
system-clock-direction-out" or "before commit 5725bce709db1..." ?

> * After the change:
> - Initialization:
> simple_init_dai() -> set_sysclk(id=0, freq=sai_ck freq, dir=out)
> 	Calls clk_set_rate_exclusive()
> simple_util_shutdown() -> set_sysclk(id=0, freq=0, dir=in)
> 	clk_rate_exclusive_put() NOT called (mclk clock is not released)

Hmm...
If it was latest kernel, and if you added "system-clock-direction-out" in DT,
dir should be "out" in my understanding. dir=in means it doesn't have
"system-clock-direction-out".

And, dir will not be changed (out/in) in init / shutdown.
Are these same DAI ? Both "struct snd_soc_dai" and "struct simple_util_dai"
have "*name". Could you please double-check it ?

Thank you for your help !!

Best regards
---
Kuninori Morimoto

