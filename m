Return-Path: <linux-kernel+bounces-774723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B62B2B673
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C697B13E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6019B285CA6;
	Tue, 19 Aug 2025 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Y1fn8JeW"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010031.outbound.protection.outlook.com [52.101.228.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C12239E80;
	Tue, 19 Aug 2025 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568065; cv=fail; b=jRBifRmmjbAHo1CZIHxPX2m4C5Zc/+1A3MMwUb05Jrna3j2V/dnL4cbXwdCKyT7ite6i2wxXJVcchw4jw2r3xEv+8vesjhlFz0zEkyLrWONQ1l3CPidg0L0jdx9f7StpGeJOid64otpaUPGywPRJ6p+Csdt+/NP9EdE4qJpI8kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568065; c=relaxed/simple;
	bh=01qbbhipp0qgSCIhl46+dSjESQp7xn2TCXK1WYzcQJA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=EpZeLD6kjm978OfRsqtcuAgtE7QOAGSb6tebvWTqkmwdS6zHeBPpD3bpApWhKDLTeasIlqr2NtohWsApMiXmB8ozCmhigwiKfaSQvrGUzPAKSarcHFIid2CJ2wBLcJz9fwncrxBjuQDBMNdjR7e0AOIVvFRgI43lzYZeZ0HF7c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Y1fn8JeW; arc=fail smtp.client-ip=52.101.228.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xf8/vXtLdSoo6l/pRirdWDA56GDD5tlEbHmjmdWkGMmKGpsJMy/f6bnLZYXbmo9LbCu/hPnO+4O3DBGAzDBGwZ0KHUr2J/xehHmL0g3qtm4gOPoSVFKTXgvj4aUmRgpPBWRQEJtaE2Hrj7dqwKkSHpwqh5vP/z2LtmiSx4ha8kHV6W+6LaPgsJvInKPA6OzHC8QAtwcydCJ7yqhSf8otoBmU3Z3T4RG/m7uulWrMVJaiwdT5IVuyxoSlNfo/zonKMYdcTbRTLImeYhXOc62ARuoPZqoEYhyxTQ4/FSZutujG0eqJEPE+5kkavzZeyxnl2peV3lYUli8Lo/lL4DquSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MICfQuyfQvPiWBYlK5qME16GiTjn6Y+MXlYNbBQVO1I=;
 b=QDRIFQ7k7cxs2pf3+w8e1ldUg6jg9miQ32AOq17yvA778rHZCy3Bbh4bzSn2ejMnfspUbQyKyqzbf/hI+uPINhzIA4u+peiY81x11URtUE+S6G3ppq2Rx38AoqumhQYMZBLXsStMk4YZpYxSiuAMoExLgdM3zvRcmyDcRHpZYI4Y0fbnGUF3srqUdh4u9iLkNfcoukf26DO4ZRH5AqzSf6CxyJoqtvT+PNwPPvi/Tr9elTgtyiFDwu4YmvdwEGMr+b92GRrNfbp+h96sCw8Z+h24lqZ4kZ0phicqZWf/fxFUuBDFK31fNZdPSESMpc7yv+Hoj9UN7AOBBnsCwDjOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MICfQuyfQvPiWBYlK5qME16GiTjn6Y+MXlYNbBQVO1I=;
 b=Y1fn8JeWHPM3/NBs4qc+n7pv13Qf9CLeYbjdCSH8fTiV5fCskIXT0Sd3Ig0dLNGHdvuUQOxg1O/hdGsJlASzYtR9OsNgcTmDy43yIJ5MtI1eDnEji9VE9lYQVd5IOWhUm/N8RmX1tJgou8Ft3NTy1If9qnYLV5RbUbUQWu5HEDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY4PR01MB14084.jpnprd01.prod.outlook.com
 (2603:1096:405:209::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 01:47:38 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 01:47:38 +0000
Message-ID: <87h5y4ytdy.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: J. =?ISO-8859-1?Q?Neusch=E4fer?= <j.ne@posteo.net>
Cc: linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [BISECTED] NULL pointer dereference while probing sun8i-codec
In-Reply-To: <aJb311bMDc9x-dpW@probook>
References: <aJb311bMDc9x-dpW@probook>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Aug 2025 01:47:37 +0000
X-ClientProxiedBy: TYCPR01CA0197.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::10) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY4PR01MB14084:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b495b2a-1b46-4575-c02b-08dddec26068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?MyzDTPEEGKrTGVV3MDhUIEYvVOETJsxt2e+vo5k2T4feCpdbLeXUUXt0+o?=
 =?iso-8859-1?Q?OHUEpBe/0YkJSXz7dvE47ow0KVH4sf/KPQzfVUFO2tLg+3PAFSPN88z0ry?=
 =?iso-8859-1?Q?uQoLO8tA6DUHxZrvd5lzaZXM7y1y+eoloAj0SnO7RlOMOoRF1seyKKNFfa?=
 =?iso-8859-1?Q?swPDM8PQ3F744zhXR2MqGBB5Gzc16imQh5M2LYuUMO39840U2jb3Pmzkx/?=
 =?iso-8859-1?Q?uGP192ZQqUNOK3xNOTzKvRT7cb2BnHvXA3EEfiJc6YvaMVQM0qusfd1qW5?=
 =?iso-8859-1?Q?2DPVPba0lBGzsmWVR4oXASlUN+IGN0WC42I9DjY1rSKp1m0muKFT3EpvGm?=
 =?iso-8859-1?Q?x/vPmRSgYe/jpmDT8UyOWSz6l6TCc3jeS4WwJk+JffmWua3pWq2djnz7c3?=
 =?iso-8859-1?Q?t/hiCwu1/WPRPvDgUHkajaN67BOrusJ/O4dOaHv1foRBzuie71+kQhq/+F?=
 =?iso-8859-1?Q?CD8EermVlkCtWAgB+tcK8PShJPs2MJTAFb3NSHKqSeHVMSVLq8jMgbGkQ0?=
 =?iso-8859-1?Q?DclL/IJnr7UKqvGGgYbvOhI1jCOJK98SKBSHc9MUKAABbSe11pTnELbFl/?=
 =?iso-8859-1?Q?JCzDE9TRX+b4ajgXCFKB8a7qN/H3NXqyUNOLuWFI68ccNuHc1M7tqxMwOR?=
 =?iso-8859-1?Q?VlMpHQO0mT4PXrwULUwDBz3GIIoIK1k0JyNT/pzAe91nyGulcxUbicoTHp?=
 =?iso-8859-1?Q?sNFmfaCuMhmJLUvIA4jSI60k/o1Fl7J/Qx39IcEY//sH/UvzkKmnOmO5Qg?=
 =?iso-8859-1?Q?fxS6EAekn2SE4l9RjWiXj3v2zRKvRH0C0NVms7quvwBURPfr0QZhCyAM4U?=
 =?iso-8859-1?Q?85L6yRi4WENKFSTbNmHDdElFwJf5PLUo+/c9KCC6YojRJdgkBHiwlGS2oS?=
 =?iso-8859-1?Q?sB8mC5iCb+GHU1wouCn4fMiEV3aypzmv6jsSSJza2ELhtKmymwwLPmf7P9?=
 =?iso-8859-1?Q?dZLz/DtYZeFIdyw8z3hWkxPzF85RBFJ3lKvpUDNWqy9DR0z7FsXjV7K5xW?=
 =?iso-8859-1?Q?+ECqmmtCNjU7Wq/xSCbw4d0rZEtOVCGkMvgSrOEh+NGC0s9DtsyNZ13ZTa?=
 =?iso-8859-1?Q?tQ0dt7+frvdTpquS+TT4S52m9vx4tYRvu9n2qJsukfztWZQ0hQVO/o6NdN?=
 =?iso-8859-1?Q?IzdLbyspDjdfAor+AUf5PHYqw571EogwsXClMZOpEe1FHQSX/8NtgteJpf?=
 =?iso-8859-1?Q?p5UID4azeR1eHB+iPFj6Kapu4N1DwEb56pgpGACjZeGPcI5ZPAGrPd+9Yk?=
 =?iso-8859-1?Q?azBB0jC0se5+lm2sFR9p6h8ZU+1X0CIpN6vSV+1R3mm93keijHZaFaVV1J?=
 =?iso-8859-1?Q?cD0cgMrB5c4TOeACN0WqCvg1P9lpEJ93ISdZbvlF7o9fK1GPGAxA+nj2ml?=
 =?iso-8859-1?Q?nnOEl7lxyGrtXyn03NPUIoDGyb4XsO2RNyKkxQEdtKalxwZF0VYZRqqhNh?=
 =?iso-8859-1?Q?YZ42hgM5GA/x3tTlfHHrzvARZiL+7o2HLdt4ls9qToh+UQLOcU/r8o9eYD?=
 =?iso-8859-1?Q?uVKV1RGL2e87RKn7iGDWybTShloJqPNRWsO55D2MFPNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?gFvvLR31JcyPRTQp3QEQ8Zg/MNrbsUxG5rtXrqLsGzs/YFjqkr00C5A4aS?=
 =?iso-8859-1?Q?cF9myF1k3fBJq2LpYl1OTDqp67xlAHOIkXHw7HF+2gTkaZ3y0+QpOXVyxx?=
 =?iso-8859-1?Q?h6V4C0XIus6Q2ZSDJAP8IIcSYIOyCxfrhJlnzNpCJzbENgSuQHqCLaoteU?=
 =?iso-8859-1?Q?VsylFbTiDkfjfltqZfzVb4brlh8BaGy0v+FwX2S/CNlZlsGD3XkpdzldIg?=
 =?iso-8859-1?Q?YCd7lhG2GSxv2PP9XslMFMMx04VSZklhCkvsX1PLus7AuuMbUMiSArWn49?=
 =?iso-8859-1?Q?DH4tbFvtUgyB1TE9ej1wUiMOLxFAkXvGSB3iJO6ccvj/yDRbslT+GCsyP8?=
 =?iso-8859-1?Q?FZorJyFogHxcnK1l7F9cJydq6viOxDUJXptfXwlqyub5hYgrULKLioPsDa?=
 =?iso-8859-1?Q?MXTUfp+0oeO89wwRDAztnCpGIRGy0F6ArkkJLLI/PKhqZwiCBgpPQzZ7QI?=
 =?iso-8859-1?Q?HaIYojtcyrcJIrg9Nyw6mDMAwHn9BDx5L+zavd3HXxAnVvp9d5uJyFfAOQ?=
 =?iso-8859-1?Q?gtIHJmYoR4O0p9tAmnJQSydbtlZTzhoNZ6X3TzE9GoleOSv9aQat5qEHYX?=
 =?iso-8859-1?Q?Q5s+ucQ3Iw7UiLKROxUIpsuyH9+julOqidNn5gTSsLrkLunfaf/52byVj7?=
 =?iso-8859-1?Q?y5fxbwclJG+oxZiisomL3EvsD3an1BSZBiasQJTcZYNOvGckgCf2X0fQYu?=
 =?iso-8859-1?Q?6v8JVUG1+ZH7f3xR0NbYMbRoIgbbGO3qSieS+ObKCuEowxvFRnMRiDVkzo?=
 =?iso-8859-1?Q?K7RXzwlOSojVyU5a6jFTaxv6DuAhu9mpI1tffCcKjIqMwXEieRAruY0pt/?=
 =?iso-8859-1?Q?sizvUApz+09p4Nd+xZBzAFwQWAMxteYHF0tMwnARHGKizwwiVHAOQYuT0J?=
 =?iso-8859-1?Q?wBwlYiI8m13TcnLP1jnPy6ObdpBMWlRlqbxCwrIkGZqKwPmdE8O0OrbsnF?=
 =?iso-8859-1?Q?6pA9Y8SpsJTjcUT4DDpeoMFFORtWtHppqTppLJ1BFZViTbdXshZpt/JJL4?=
 =?iso-8859-1?Q?9FxAsDg8GL89azCNHOu2W1HBc/QDnm29SFuU29KAkw1wIYSkshvv8D/acb?=
 =?iso-8859-1?Q?ovqH3Va8ghnJSxosaCItcd6Ki2i2gNtjNra9Ry6FirHZxdSNmV25q/vtL3?=
 =?iso-8859-1?Q?bFdcenk4qhgsTbmghQKjIMF7iBxvPk7IyG6lxi2/1x5FqXiayWrut7ekUW?=
 =?iso-8859-1?Q?aJy1mkQAQSCvIhC77JDTL5ncy6YUzd0Nab+hjJb2nvJKes131DTVFq1B0q?=
 =?iso-8859-1?Q?X+1HbjpKsuXKWoSSFf7V/3HXChK0fETC3Hj68DECud6JnGBE8O5IiCTzP0?=
 =?iso-8859-1?Q?3n1+DT9CD7FihKJp+JZ7TstqubBuBG403TnAy5Wuv1WvUgHWKF1vO9GFj9?=
 =?iso-8859-1?Q?eH4OcTBgeIVHr2r0D1k6/+WCD5mJOf3/4JhM4hysJ3j9VYUGDGxJVpXBJn?=
 =?iso-8859-1?Q?53kE9OUfURM0+L11ekvNLpPnuXoucGiayk2Qt1mrlvYt7qsDZ2Jv8QViJD?=
 =?iso-8859-1?Q?HRjIzoMAVb7S7gV5YEtvNqvKay0Nr2lF5D+/BJobykvZ9I7Fyr85HN7xGm?=
 =?iso-8859-1?Q?p/9xeoEvMf+JbaRaW/RYbjFJeSV3skq/YMtBbIRNSjQgQlQKy96yWc/Sf2?=
 =?iso-8859-1?Q?PnJzfzSs0+fxEYR8B4cJwKE/LJOK2ROOoRj9VCpplrSbJCZ4KCBCXsxbd9?=
 =?iso-8859-1?Q?LoqecWLhnRt/SvajaoE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b495b2a-1b46-4575-c02b-08dddec26068
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 01:47:38.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8OwC8czYdlFEUw/wDzNi3axVhR5WQxerERcqVJf/p7RylYJ/m61ZXrqk3rEvdd4VbEe3k8ybVl60d3f7XCofwKrTABjgXTDStCUU8kEGVCWyNKKaAgj0ltUw/wLtdXN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14084


Hi J. Neusch=E4fer

Thank you for reporting, and sorry for my late response (I was in summer
vacation).

> When booting the Allwinner H2+ SoC (Orange Pi Zero) with the audio codec
> enabled, recent kernels crash with a NULL pointer dereference:
(snip)
> This particular error path is taken after platform_probe returns -EPROBE_=
DEFER
> to call_driver_probe and really_probe calls device_unbind_cleanup.
>=20
> The parameters to the strcmp call in snd_soc_lookup_component_nolocked ar=
e
> component->driver->name =3D NULL and driver_name =3D "snd_dmaengine_pcm".

Thanks.
I think it is...
	- snd_dmaengine_pcm is sharing same dev with CPU and Platform
	- Platform has driver->name (no problem)
	- CPU doesn't have driver->name (will be NULL pointer access)

I guess your CPU component doesn't have driver->name ?
Anyway, it should care about such case. I will post 2 patches (1st is for
fixup this issue, 2nd is cleanup patch).
Could you please test both patches ?

Thank you for your help !!

Best regards
---
Kuninori Morimoto

