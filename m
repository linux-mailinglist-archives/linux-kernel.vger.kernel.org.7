Return-Path: <linux-kernel+bounces-733034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761A5B06F44
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E6916E4FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1317F28D841;
	Wed, 16 Jul 2025 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VkPCF9QF"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C47428506E;
	Wed, 16 Jul 2025 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651858; cv=fail; b=NyGf6T6PkZeg72L2ldjyLjJNhB6+QW0OTXr8LV05eg/9nD5e/LlTkNfO+8rxj6+pUwYkL8Rker2FYMHl96hXzxoORwR+IjI/I2HeHXYvWovtBrTGZ5WGuVIrRvxw6puA7sORbnQcOx21KQESeUqBPeNbrV3n8xMfBkjOkjnEsYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651858; c=relaxed/simple;
	bh=WZ4+z1yml2pKtIlxcY0SF3Q9SJnyfoRs0ewDvHGfLr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rdxajXyXP4Sqxx7da6hx78mdaOXdexVFetuxWRBm2WepTsD4hqXZ9kBDtL72PmjB/5d9FqIyugWbgL1qb7g50aeZZyDg/QxZ2cCT/r4GCwtl+2Dt1z1jx08ip82lHvv1FGpSwa3DbKfhLX8hAK++M7k4ycOuEgtLiHqwwKm7TW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VkPCF9QF; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQfqTDUk1oK7KCYUv/vP4sFhbjRFFmwvWiIkuelAxWpmFGpzkouC2XJqcqHaJ9MK8pt2yp5CGl3RTh7yJ4QVPBMJiCYMPBMWSyPXEzRUOAeDRS+RLGo38KEO2ZdxpCNWUfDUFutnxfnmkiyUEf8VTfhCgJw5UOezesmJ0SoZ7I5nPfxMnGrGHmvoUkWvm2v8SVIyH9VB38Ez1uU4Gkg9Qs1zNvU2e/3p+oMPykmlcNnQoarlr5zt5oiC0zDzV9rVuhDEPHlKml1byaEuVq7n5tRlpMuCsBP/bmIYnLed6R7l1MBtN5f9s3PpPLN0p/cX4PEZsu/eUgcVuvMvAQwAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6zGZcdMviyqEhALIMD+HXIMePXWff4BYZ8DrJsq75c=;
 b=buZun85nKa+Bl/KBiSrmVyGwmYODbrCRETiQnn8vUkCXU4yBji+tClf+pu5BzfRACNi9P2g9ThjLXKv2GnStuQhzgCvUXxkSMPO5kxVaFjZk6akVDUmScP5JPdKaQiQjTAtBgYuuR7LHYS7mwgBQLpm/bpvc+3akkqLB3kxmVTm6B09uGp4hO5XTZHJxkH6cIlM6ZD99nCqXN0gJBrx2WdF4/CGOjlKsDqc/ZXJSoGIU+omPBCqY/mQtyX4BLlMBQWJQs6o+q3RKVoTVpbsWzVIXx8aSI+hvBu2/NhJcrr4hU8AGXIHuGkdYVPtk3SXvrZ8luDr9QHXN6h2hHqXN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6zGZcdMviyqEhALIMD+HXIMePXWff4BYZ8DrJsq75c=;
 b=VkPCF9QFhRLIec2zmHXfzfL8HCmN6SzTH5pfUIvrburt71X1mH/bKE9qid9HgQGCuXuloYnafnSiMPDiapM6E9+fSSAxEOF4IoVokTECHggyM1hyk7Odvx77/GpsjoUWkc1KUV0evULIMgy0dhsQWL5ZKLPBkSuj8FvS/KMfVxDXb7OVpLk+WVA6AttyZTtNHDS2TJyC7EDWFqN2aMIeM40a0Q75ZNA0BgiTg9UScmCk0AMyc8x3/k6txfXjLZgCilAz4N1tGvSQxsatVcv/5Oc2xylwoYh1dhYMaXfLkDzSxKqaW12+RvNlBnb6vYt6jLsJ2eHF73CPulmff7ovLQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:44:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:44:12 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Shenghao Ding
	<shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun Xu
	<baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Linus Walleij <linus.walleij@linaro.org>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] ASoC: codec: tlv320aic32x4: Fix reset GPIO check
Thread-Topic: [PATCH 1/1] ASoC: codec: tlv320aic32x4: Fix reset GPIO check
Thread-Index: AQHb9h7p0FuaXpi1t0ikZc2rI+eCHbQ0XmWQ
Date: Wed, 16 Jul 2025 07:44:12 +0000
Message-ID:
 <PAXPR04MB8459B643427F1F0952F159A68856A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250716065708.4041153-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20250716065708.4041153-1-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB8726:EE_
x-ms-office365-filtering-correlation-id: ad2c4f2a-5485-4019-8951-08ddc43c8e8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oaGXePLOtITXsghPLWBGjAeOPfkn47tKxuNqvB1on4sn2UiOkF68Tb3RVXh/?=
 =?us-ascii?Q?Q7CZmKmr+20JEmEfmqndT3IgsvJXyNcAJq7spKOE8DoZWkEdhGbrZjG7Nn7d?=
 =?us-ascii?Q?+1QEt7/vi67HpuFKo/3x6JvSCXRYhrDUEpJOi1GLGubraaKcqbKznWSIiPEQ?=
 =?us-ascii?Q?F3LQaOlzaKCeO843CQs7o8mvWdwzMsAIC9ZzvkixpaHqmOxNTM7kjWP3wVLK?=
 =?us-ascii?Q?HXqqTl62e56YndQ6Doui9nW0UkNcPDfockN9t77/Wvl0VtjbQAvLzXcsN6EU?=
 =?us-ascii?Q?6VMEEmiiBVo+Uau2Qrzczs1QugMrBrRphXIoCzkXVHx0FFLcFYmzp3mFU8Ao?=
 =?us-ascii?Q?OjpBg3LUra6d72MtrAqQ/cjXayfK5ef3U4XjS+efVDQAgusHKMpon0gXmsJO?=
 =?us-ascii?Q?UFI8Dss76Pm7JNwLgtick/ahKuWVCJt8xjLPW2aznC4edo5Ftm5NVihaN7Lg?=
 =?us-ascii?Q?XsKh4iTYDBCRPXxCvq5ZhYPiZnfg1BvzKxAuDYmzOrmqAxP6RL3RMuDbVbr9?=
 =?us-ascii?Q?nrETqM2B+zIkcwF7uiBKuUL4c3X3RVPKHs4i7N/MvP/+rf3mTvSxAopzGihT?=
 =?us-ascii?Q?LzweCEpAFy27XM7AllzdP3zmWAONMJILHzOewbwLMhjAkQKKsXUolcca45y/?=
 =?us-ascii?Q?sYwCZZYU8rQviJLqrYEfyWIPz/aMbqZAuLNNbZBD5EMCu1QI1v9NmMzCtRrl?=
 =?us-ascii?Q?ayn8DgyPP5AJ5OJ9msCQlahispgevuTMW4qSgOusttYyyLhIA+tCjERy40LT?=
 =?us-ascii?Q?jwo3yWLZE2mFS2W1s+cN5zmGBGAV6SLp1WNeJ8wx4Ij2ZVEwIvkAF7+06XSe?=
 =?us-ascii?Q?/vgzpxMhNRIExjclI/mZ/ap5ZOqiMzF1xVOi1i872jWu/savLepw2OPZRwpK?=
 =?us-ascii?Q?ERJkrXyPXa+5iN4yh5c9RsI2qruqq32k9cMZxd3qVe/ot0rFqhhkGuv5ba/T?=
 =?us-ascii?Q?20n13ZiWdN/Yp72stGzS1/jrUQMskX3EtPVGxrq5uJLymliS6iLwAzCHUdre?=
 =?us-ascii?Q?tsCZmGAl6DqYmTWjfoBtZIb8+lRfA2iblv2yZZI2i2j7lHzAJTu49yHEQCQA?=
 =?us-ascii?Q?eIvWhMjBo2r4Wl1WtwHlxtTOFBZIFmMFWAe71D7vmT2kT23h3VufJ8I3/vSf?=
 =?us-ascii?Q?PVQsmnyVBvXZUmHjQSj8BMZ40RoImZDnAlaVUvRt/Ri17h3pBViz7mM6BKkX?=
 =?us-ascii?Q?p2Bl0J9xi5QxW1X1UzVpLtyWtdD81Qf5zAn6JltWFhfPAzdyqwqLT94ua2JM?=
 =?us-ascii?Q?MVXGsRSwIWS545RO2KT9BzPgvgiAI8+w31PhD+Q6GEi5exkVq5S3G3dl5RjI?=
 =?us-ascii?Q?GJq5BIWm2fnnYQWnBCiohuI2bVyVErjowm2X5BsL7X/vt3xF1wNsFJI71iHa?=
 =?us-ascii?Q?FHKOLzXFrkz652s8IxNEoEXSV1hMQ3m1BmklsZqeHfriWnEluckYX2JX8SLS?=
 =?us-ascii?Q?umoivuO6pzNV9bX2ogobJ6OsD37gX/5bWItpJ9FyzNDhQVWgJqr5RQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?48b50hKdA9qLEjkFYjk/Xk39GjYZf088hsuTle/0OBjCYjyDskXx6m0XtHFC?=
 =?us-ascii?Q?eHAlLghAe1MhcVrTOd/0yIZ4kWeFuZNPOKyPrZ3/4M2F2LoWUKkn189cCxSh?=
 =?us-ascii?Q?kHV7D4CGrcqhjTmsvHyW0skAMctL0Ffm4TUwfmZMUNHaKOexCuBg5SVOtb5U?=
 =?us-ascii?Q?AyuVjmxqasX2v3dNh0NlRtj43FYjyygGLGS1q4HzDNc128tzxrUpZSsMAzHX?=
 =?us-ascii?Q?nXuGZGCVDPzaNfx7SpkD2LqVUeOU2jF3M5mFPXK/V//9TQVc0KrajB9/rAWT?=
 =?us-ascii?Q?hL+olWrxvW7tI18mIZkJmqI74MyG7PsKFVn0JMkL37sy8yUx3/BZ5xRkomUH?=
 =?us-ascii?Q?SucZPQ6F+XJXQWXo0Kecne0wjkMZ6swbuUk0D8zoce2Ud8oAeOiRIcERYL9M?=
 =?us-ascii?Q?+FtSPPVKa6xDl3NhU68S29TyYDTminV9PQrMJ/R7SbNY2iH0m63La/GC8XbE?=
 =?us-ascii?Q?9BaZd7LThXssPJ2Ld/CZFVtjkZXJ6YWsy0CapN5ethlvq6ob/lMEoQaljVP7?=
 =?us-ascii?Q?/D9Ug8XQrYjW+3s0MCkeofhXuSoFNvchIcYqmc4KcrlMBz+srAbeTTDd98Cx?=
 =?us-ascii?Q?c/na0up+LngIzzWN5d3u1Azq3c6e+QyCNL+EwIxlokBB5hIgDyXGf9Czi/OQ?=
 =?us-ascii?Q?5PjgrqoFv2Gm6ZMOTAodOo8jBbGc4MHhbDBVxescVprgYKTJw1HnxwbqZY5i?=
 =?us-ascii?Q?+oTrjccpi2pRTIwPIRJaGEuTOcsHqMdrNnR95Bb105Nquk3rTyT38Wj4d1P5?=
 =?us-ascii?Q?dw2mrClsaq7A5jjyHWtmsKbPc51kdd/nbpyC5UyVEaiANZvXUEtt2uaFUtE4?=
 =?us-ascii?Q?xGVhJ/ph2KjI4phhcYHf5DRx0EH118EJVdMmH5xUIgBhp3aU+irhbcrivAD4?=
 =?us-ascii?Q?pb7b05iwtc90JnzOPXdhNw/lzbp1W5vLPkCdEpbrnpq8ZVXiGopyqYmNjRgn?=
 =?us-ascii?Q?sl18Nk6fo5EhBM7xRT8teqc8UnZS3XF+5j4crtrdvIqQM67uWfKaiOEybTbQ?=
 =?us-ascii?Q?Y+Zh4HtxyRSACEZ0xLYjib2xhTzieFLAZERSNMJ7sIaDFw2Peg6Z/EfsXjAb?=
 =?us-ascii?Q?jefjpyJFVPMjdyl0nlNGBkHibtnumNfuRNv89ch3erA/uCtCi5aq/dAJK59r?=
 =?us-ascii?Q?RttODKuPzMuyJnnUDXUeJljEb+d80X3YBy7YCHNYgYPjjfT0MPjaWeZbfe24?=
 =?us-ascii?Q?2TKq4ASg1AMiolnLtTVtM7eE+cN332XqGi5HInqSnFGy+SYoSCGrMKXIrjF6?=
 =?us-ascii?Q?iuR9uy3LZvy8KlRCFSMFS0s19WiVRUrdLVo+laKf9+0y2SUoj+8T1AxtVdLh?=
 =?us-ascii?Q?mjtX9nOg/voVflwOEzBDaBEqVTPjJSzwn1ZLpGw5O+LLHbznx/Ip8BqHgn58?=
 =?us-ascii?Q?Lx85FGcEBczACqf48kwIeyX3YYcN0/zKnvXekgUyOvZpLdHxVO4PYLlN4aop?=
 =?us-ascii?Q?1rDp4xDs/0arsE1fR0InL3jeb/QvyBdwcrKvIVIqrMP1x7OgbhKtvXzqKuyD?=
 =?us-ascii?Q?lVDKDWxKh6sUlaDbk1ywd0OU/035SQ8lwdL1LwOiGtmoYd5s2u9DfS/R309E?=
 =?us-ascii?Q?ZnloPzcKFm3JpNq2oRk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2c4f2a-5485-4019-8951-08ddc43c8e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 07:44:12.4991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O0OCRdWIUqFrYXfp7lw/gnSM1latPQL6+lrNP3ip3Jax0b7+XyrSlkQppS08Uug08j2Zi55KG2zRvmQ/VCTIsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8726

> Subject: [PATCH 1/1] ASoC: codec: tlv320aic32x4: Fix reset GPIO check
>=20
> rstn_gpio being a GPIO descriptor the check is wrong (inverted) for
> releasing the reset of the codec.
>=20
> Fixes: 790d5f8ee6f2 ("ASoC: codec: tlv320aic32x4: Convert to GPIO
> descriptors")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> AFAICT this bug was introduced on v2 of the series which changed the
> validity check
>=20
>  sound/soc/codecs/tlv320aic32x4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/tlv320aic32x4.c
> b/sound/soc/codecs/tlv320aic32x4.c
> index 3b89980e9bcf2..7399080f8580c 100644
> --- a/sound/soc/codecs/tlv320aic32x4.c
> +++ b/sound/soc/codecs/tlv320aic32x4.c
> @@ -1388,7 +1388,7 @@ int aic32x4_probe(struct device *dev, struct
> regmap *regmap,
>  		return ret;
>  	}
>=20
> -	if (!aic32x4->rstn_gpio) {
> +	if (aic32x4->rstn_gpio) {

Oops! Thanks for spotting this.

Reviewed-by: Peng Fan <peng.fan@nxp.com>


