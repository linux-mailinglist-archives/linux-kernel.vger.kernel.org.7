Return-Path: <linux-kernel+bounces-765809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFF8B23E84
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068006E7028
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B7727604E;
	Wed, 13 Aug 2025 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PZtt9rCT"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058772727F9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053404; cv=fail; b=gIVkWfX3ACApjrS0CeBClKMHMqGc++6l/QhdX6lyBP4X4qVnVxAG+nN02XwGIRkA2fhwHqsz+p7swunryvjXE0Hup+JNWhMMP2V9+gC2+ln1FkYpESaitAuoiFJyls7hsRJ1B4QweNDlWcFtCP59/rtC3juQNmzAgyLaPEfSD0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053404; c=relaxed/simple;
	bh=Amdz1zt+MiKRcoY3uYSl7nBX6rplfNQBXcS1Vj7ul5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cBN2Sd++XRbf7AHdjV3np+6gOpZhGX5pfJNLhRqlc0jr7JaddSXX/2MT2hyqImqf0+DB3T4a/zk7IgMgCemcyh9PK2dkh59W+dzlha9LOXHXsTuTnDo7GOzK7EcNpY34cQQUi6oYNHQemA9aaeBnYMYeZx4A2AOcgOafBdpGKdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PZtt9rCT; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRqCBiK8SpSccZp7N8yDDMdqE8364OMLffaeuDZZRIYo7LzbLtKDwJY3OZHNuvEEG+Ao/apw8/7pT+ABCIX3vqYJ9qCuNNlrFoXF+wLqSfCy7T3ZJe6Ksae93hlGL7ocGd5m8b9KT4t/voOdaTcJrBVwF9dxVQzapVSRghzOQfpUQfMCWamQ3hGV72J4wMWKC4oLCm/l9tYGJ9fke7bmpOy2TMI9n50ljvhfemNpyeCLELTk5Od5f3BtBJuRg4K9xKrqszj5BW4Q8IXbVvVhEz4+iRz+SdiLQJYoxV7um57VwcjlELfH0TREf1J+PW8RS2bSA+5HPo1vjr+OigXYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9pYJl2lJ/zr0kSjwNp13SOZTEyXFtHiQ+v7wm8y9tE=;
 b=HQ4kwT33dcDHpR51vPnmiX7oLGi3oQkJv/tBCbL0T9exTDqkb8Wj+XZnLHqGHCGqHX480bQQ3rfblYPpUotWW9+HMQty4tvEisvcAzDrjxiJRV6UXVmjVxCYjXbvw3MsBVuF6dmJHI13eFjkmHQ/m5wv5/7+WZdL50QNFvlzNKjkT1T75chr3Y3mtZ2E1lOBsHLD+02t1/YcUKgDBwE9MwR+x7W9qqezhpiJDHZkSfAtBIyB/Z6itcjK86aW/ff0vg8lV0sD+g1gbsjBZZBGO4SlmgPO71b6GVgBFlNootaqZ5k/cRkHD7Chx1MSpHEvJc9jA+/5Pokxz+p8R8o55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9pYJl2lJ/zr0kSjwNp13SOZTEyXFtHiQ+v7wm8y9tE=;
 b=PZtt9rCTx7LplKfHn8SY8aXFebAJbN2L34mwl2OY2xXW2QxRy9zNtZH/SbbYuzV6c1wm5cl2bYgCbcChW56JrSB2aFqyqvRqwOGTsGpUAreh0XPTNSuIbp3ap8WbDF9nX4KJIsoH6ro5dSk3a25JTz3SRD7R0WpH5vzTIuDiK+SyyypaoyMXoXWK10fmmcr/TtudXoWK6yBsBGJvKZXKru3bQ22PwnY+MxOWO/3lfhiNT4QT+gW7wxu+jQHPZGfC84sjuRREs7ha1npGrhj9iKMKQnoh58Rzfr/BigCsA5EF1YeEqgOP38DSVBJ14d/n+fDJzB5sOm9qcYmAMD1Vkg==
Received: from PAXPR04MB8574.eurprd04.prod.outlook.com (2603:10a6:102:215::19)
 by PA4PR04MB7837.eurprd04.prod.outlook.com (2603:10a6:102:ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 02:49:58 +0000
Received: from PAXPR04MB8574.eurprd04.prod.outlook.com
 ([fe80::60b6:6a5c:8db3:cce]) by PAXPR04MB8574.eurprd04.prod.outlook.com
 ([fe80::60b6:6a5c:8db3:cce%7]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 02:49:58 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: "pratyush@kernel.org" <pratyush@kernel.org>, "tudor.ambarus@linaro.org"
	<tudor.ambarus@linaro.org>, "mwalle@kernel.org" <mwalle@kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>
CC: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bough Chen
	<haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>
Subject: RE: [PATCH v3 2/2] mtd: spi-nor: core: avoid odd length/address
 writes in 8D-8D-8D mode
Thread-Topic: [PATCH v3 2/2] mtd: spi-nor: core: avoid odd length/address
 writes in 8D-8D-8D mode
Thread-Index: AQHb7+kr6X39dcfaRky9vQ05nZNeZ7RgGcFA
Date: Wed, 13 Aug 2025 02:49:58 +0000
Message-ID:
 <PAXPR04MB85749F748DD87CE41452AEBBED2AA@PAXPR04MB8574.eurprd04.prod.outlook.com>
References: <20250708091646.292-1-ziniu.wang_1@nxp.com>
 <20250708091646.292-2-ziniu.wang_1@nxp.com>
In-Reply-To: <20250708091646.292-2-ziniu.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8574:EE_|PA4PR04MB7837:EE_
x-ms-office365-filtering-correlation-id: 0cd914a0-57cd-4ca4-6f1f-08ddda14179d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wQyBM8XQKo4RJvOQFnD6SSMuPjAeteuhZbY9+vRWAy5tSMV2vDmFIvbkTxNM?=
 =?us-ascii?Q?UNFfK4gj9ZEq2w3fDV096la62Z+Uflu8Me+J/MLG2V9vl3XWFITv+a1bwNwU?=
 =?us-ascii?Q?/wk3JwVcAugpTp+QOmzpt3DJ1xdDTytcrpJu2+yFE+1cNbF4UdDXIWBFznyN?=
 =?us-ascii?Q?PKDgwZ+P9D86RCoqFctGe/3zlswDqIxa62r8YyaHesEXEDvsmWZi4UHWbTPA?=
 =?us-ascii?Q?y9fY1Q4Ce+QGYCHG8MP6VjzBECOKC3hWtEJyH6ys77EjJaHTYA+Bwkj13pLR?=
 =?us-ascii?Q?3Zjk+X5PfARORFNoHqXMFTvVUY+JI4MBWrU1W1t4qhieYQAUF6Jifmkt1tJo?=
 =?us-ascii?Q?6C+V2OBd8o//2cFHcxkQQK+C5Sp1nrAtGQQciGywoIpJQWic38PgVK2d2sRt?=
 =?us-ascii?Q?7k5eLgJphMPjF1OtgVzfa1MmUhhutk0qrbNJpE1eqjjEYQToiID8OVOaGMWW?=
 =?us-ascii?Q?v87kl+pUrdB9M2lbAnRE9f845yLXrvBBxUWi2faULYB+w/q2GyO2TxqhsbQt?=
 =?us-ascii?Q?1hN7m9I7CTO1oWL47TEYvaox46WhoqrtTOXMihPHPytyHzkRzvFulk2qapZ1?=
 =?us-ascii?Q?MG9SNWbJ6teczBXJfknAxGClrBU7MWk3/6jFCqdfPIaaRCSHbnI9R3a/3X1Q?=
 =?us-ascii?Q?otVwoXbzh+dz17Yy79uXcvlb5btr72lryTv8tSCCzmacwiJcHFdWHQ+ySSN6?=
 =?us-ascii?Q?lV9YiWHVU4CPLOAi1clzcBRorwRGg2vTK61N9SA19fK/0u/ujjBFZWDT6zIx?=
 =?us-ascii?Q?DWXTvblzg9kO1B9rHbRydM35UuN/DvEtSM+xCl7l7+i8NEK9AK01spoDnRlb?=
 =?us-ascii?Q?m03E3gqIYTNYU+kn8+VcEB7FK0D7EUDL7BGRwIxmmpyl8rB5s3PXPsHWrFAW?=
 =?us-ascii?Q?PQNLquhfVnASbZsvS4o1WQR9u8Zz9lhOVYBJbV7TJqY5yT+8OzYKTEfBoi4G?=
 =?us-ascii?Q?w9jY9NjO9LlBgRRzA4L6GM5xKcss6Heprrh69gXv/F+AVusDqWjTQDxdeYBk?=
 =?us-ascii?Q?RR5+5W7ikDYIKRy96HhSSIc2oFKhCU9WTMXQxCThczTikF7/sK4o099d1cf5?=
 =?us-ascii?Q?SMaLl0lqVs3pKTkiymwgHmpJjmSrlVDP30ORFXGzD1rqqwsfYh0PNmYwusWY?=
 =?us-ascii?Q?AmQB84TuhcZB+xXUqm5A5p9Jxwh3PK0tBmeJT5QKxA1jnI2LI8eKEnJ2Yxla?=
 =?us-ascii?Q?b5U3fRCDrwq2eda5N4/C9t8LxSFFiNS7abtfYN/p8xx9+NBYqeOVWj/vJyFn?=
 =?us-ascii?Q?XVQfzqU3rBSAx+z/bU6lpQxXI+I03Wvgl6fsgrPPSVEGeB1D6c+m+sezTZXM?=
 =?us-ascii?Q?lOEyeM3lExqvJ1h3hfbVVG9yo/Bk7ZfIo4wWjUOuCOrfmO8kpMrwg3Co1Epy?=
 =?us-ascii?Q?npG9Gjg+MNvlxFWTAlFcTJdU1zPZ6Ljdn7rCSvptmZPzT4aveKTAPpQ1guGb?=
 =?us-ascii?Q?nOIY23NI9uYkX5g8r9pUd0UmKF8Gd+FY3EhsJ0h8RtDqYtMscnkpfQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8574.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BOSuH5e+ibk27ViIeiwzNo8sqzfMQ0F4Np9lPdWu3avkzjHLi65JjNA0d5aM?=
 =?us-ascii?Q?mmGhvXgOxqRXG8oAvNMoZGwH3sELeS0rzns2QVdgD5kVONYTeg0zWIsB22Il?=
 =?us-ascii?Q?NIZ2mbVqSyKOP+DDpomJKaF+8F/7EjYvHgnJn+0oVUBZW0P8k6oH69C8yRb2?=
 =?us-ascii?Q?p2U75WmNnDAMqqdfsexBHLNruE2XrCD/W9+YXmdTHY2lBNEYIZXyBOm7dkRl?=
 =?us-ascii?Q?oJUmlqZo7za7+12myCUiPTYal28G7BWCxSbbF1OzeTLQzjZUYF1eKj/KAqh8?=
 =?us-ascii?Q?9nUDzr8U8YZm5m5DZnk6zaGHs19FSmj4qLfbtSE97Ar7qJXgk6kktEOrzPNO?=
 =?us-ascii?Q?0CQQiXiE5NPFprSUElSkmJsUMcj5lVi3fb2savQSf8mO3BA8X/ThDDJLOFXY?=
 =?us-ascii?Q?QU5ruWe424jHveEql1vmh6zuBXFNJa7pGRCdGcdvHVrznY8x8c5uaLqT5EHx?=
 =?us-ascii?Q?5ajfmGMtjtnzwkMelsqcNw5TUoHxEH7IVwFuGd8sOkZXMuj1UQGd8ZHFP19W?=
 =?us-ascii?Q?hRjJyrpMRq6wiMzJxH3s4dFWLZJgVGIIJC4n/2gQ2yylnt02YVXPzPcH59L6?=
 =?us-ascii?Q?lthmHp7OwTKkEIies9bOx69oSp4YPU/GrW74DuuA05o1QFH48XiWn6ivj7gF?=
 =?us-ascii?Q?2/xuL87RO2RR27GjZFSwp/AxKDHwcJqK2BoidI+hHPjXJ8wPvtZLImKzny4Q?=
 =?us-ascii?Q?d68q8MqVoqb8nOIKsNqRto7Gh4DMefUUW0PsaYHzZ1DWbPX3/tdO8Pp3Y5nQ?=
 =?us-ascii?Q?QeJvoX/3HB8n8midi0TGuWYtfLTszHyGBYBsz76GSUjNtS+K1hQTsAkUPyDS?=
 =?us-ascii?Q?mbylPmLCxDnJupim7YrJGcb4lzgb6OijP1nqJtX0nkriuadQQVS//ceheO84?=
 =?us-ascii?Q?/ZjlIQ6pW9a7t21lDXlTXOxFzfAIDUiEKQ3sThKKog3BR4uN8zmsZKHEGc7o?=
 =?us-ascii?Q?OaATVsiaJylPpP2XRPRcvGPYX0nSyeZ7y8uR/el7OucxPrwB03KhEcmjVHSv?=
 =?us-ascii?Q?gsJFsoAJdN7d2AkDsu6Iu93uyzmvyiRHoGzCHNpj9CpSj91CCAH6M4dPvZvn?=
 =?us-ascii?Q?h0S+kFamXSgPa3R/Bd9ar9BY9ZvUx847Nf2zcQPj26C4g3amgj8IjNCiJRf4?=
 =?us-ascii?Q?mOa++zEFnxt9dGGWoLKUv+91Kp1MNBCFaufeOcC/iH1Rxrgu2LcicCtEckSK?=
 =?us-ascii?Q?+ovyLmr5S1/CI8fSTjsRyCxxeb6fH6MR0gVtnDPYnEZgFl3Ry6r0AkadONIS?=
 =?us-ascii?Q?yTxRmHkhL71UklZliuikwoiN7EImkUpWcEQemWh85Cf/7xZqZ23uV5BPmh6C?=
 =?us-ascii?Q?V6vodQjlwYVIrQfD6M08RCwPORCK5/dwHBlHZt4wQVeWm6NTZfljvr03/UT4?=
 =?us-ascii?Q?0SjajXwd4YSpBQvreklPFJErAMGxkprUDMBr0Dt+i/RfJ0/hziQwbBdVfE2I?=
 =?us-ascii?Q?AOSnCgNFp6nFOJXpsrroAyLz7gfzV7jowYmyuKcdsj1rLbfH+LOsUIYv5VYn?=
 =?us-ascii?Q?A+atHVZov+fyjYYcYkOEKXwcyFIPFi+wmFAz0bTYL3cnTOh2APsT2EN+/+rx?=
 =?us-ascii?Q?n2eDO/H6cJWi2bn3EgAMpAcKJRZrwo8rT/O8Opy1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8574.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd914a0-57cd-4ca4-6f1f-08ddda14179d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 02:49:58.6478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9/QSv6KEFeuVdtHcvJ1simQk5Pnfjp+APF+v3cZiOGUPGKB6qJPkGVbCcIyA3gXE8GpF9VKwXmOdN4riSGJkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7837

Gentle ping on this, are there any comments or issues?

Thanks,
Luke

> -----Original Message-----
> From: Luke Wang
> Sent: Tuesday, July 8, 2025 5:18 PM
> To: pratyush@kernel.org; tudor.ambarus@linaro.org; mwalle@kernel.org;
> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com
> Cc: linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Bough Ch=
en
> <haibo.chen@nxp.com>; Han Xu <han.xu@nxp.com>
> Subject: [PATCH v3 2/2] mtd: spi-nor: core: avoid odd length/address writ=
es in
> 8D-8D-8D mode
>=20
> From: Pratyush Yadav <p.yadav@ti.com>
>=20
> On Octal DTR capable flashes like Micron Xcella the writes cannot start
> or end at an odd address in Octal DTR mode. Extra 0xff bytes need to be
> appended or prepended to make sure the start address and end address are
> even. 0xff is used because on NOR flashes a program operation can only
> flip bits from 1 to 0, not the other way round. 0 to 1 flip needs to
> happen via erases.
>=20
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
> Changes in v3:
> - remove last if (ret < 0) check, as ret always >=3D 0
> - remove Micron manufacturers info in comments
> - change nor->page_size to nor->params->page_size for latest kernel
> ---
>  drivers/mtd/spi-nor/core.c | 69
> +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 1b594f720b6c..20ea80450f22 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2128,6 +2128,68 @@ static int spi_nor_read(struct mtd_info *mtd, loff=
_t
> from, size_t len,
>  	return ret;
>  }
>=20
> +/*
> + * On Octal DTR capable flashes, writes cannot start or end at an odd ad=
dress
> + * in Octal DTR mode. Extra 0xff bytes need to be appended or prepended =
to
> + * make sure the start address and end address are even. 0xff is used be=
cause
> + * on NOR flashes a program operation can only flip bits from 1 to 0, no=
t the
> + * other way round. 0 to 1 flip needs to happen via erases.
> + */
> +static int spi_nor_octal_dtr_write(struct spi_nor *nor, loff_t to, size_=
t len,
> +				   const u8 *buf)
> +{
> +	u8 *tmp_buf;
> +	size_t bytes_written;
> +	loff_t start, end;
> +	int ret;
> +
> +	if (IS_ALIGNED(to, 2) && IS_ALIGNED(len, 2))
> +		return spi_nor_write_data(nor, to, len, buf);
> +
> +	tmp_buf =3D kmalloc(nor->params->page_size, GFP_KERNEL);
> +	if (!tmp_buf)
> +		return -ENOMEM;
> +
> +	memset(tmp_buf, 0xff, nor->params->page_size);
> +
> +	start =3D round_down(to, 2);
> +	end =3D round_up(to + len, 2);
> +
> +	memcpy(tmp_buf + (to - start), buf, len);
> +
> +	ret =3D spi_nor_write_data(nor, start, end - start, tmp_buf);
> +	if (ret =3D=3D 0) {
> +		ret =3D -EIO;
> +		goto out;
> +	}
> +	if (ret < 0)
> +		goto out;
> +
> +	/*
> +	 * More bytes are written than actually requested, but that number
> can't
> +	 * be reported to the calling function or it will confuse its
> +	 * calculations. Calculate how many of the _requested_ bytes were
> +	 * written.
> +	 */
> +	bytes_written =3D ret;
> +
> +	if (to !=3D start)
> +		ret -=3D to - start;
> +
> +	/*
> +	 * Only account for extra bytes at the end if they were actually
> +	 * written. For example, if for some reason the controller could only
> +	 * complete a partial write then the adjustment for the extra bytes at
> +	 * the end is not needed.
> +	 */
> +	if (start + bytes_written =3D=3D end)
> +		ret -=3D end - (to + len);
> +
> +out:
> +	kfree(tmp_buf);
> +	return ret;
> +}
> +
>  /*
>   * Write an address range to the nor chip.  Data must be written in
>   * FLASH_PAGESIZE chunks.  The address range may be any size provided
> @@ -2164,7 +2226,12 @@ static int spi_nor_write(struct mtd_info *mtd, lof=
f_t
> to, size_t len,
>  			goto write_err;
>  		}
>=20
> -		ret =3D spi_nor_write_data(nor, addr, page_remain, buf + i);
> +		if (nor->write_proto =3D=3D SNOR_PROTO_8_8_8_DTR)
> +			ret =3D spi_nor_octal_dtr_write(nor, addr, page_remain,
> +						      buf + i);
> +		else
> +			ret =3D spi_nor_write_data(nor, addr, page_remain,
> +						 buf + i);
>  		spi_nor_unlock_device(nor);
>  		if (ret < 0)
>  			goto write_err;
> --
> 2.34.1


