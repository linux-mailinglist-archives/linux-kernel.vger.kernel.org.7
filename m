Return-Path: <linux-kernel+bounces-895600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4A5C4E745
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F58D3B69D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EC62F12DA;
	Tue, 11 Nov 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lfB6+nUr"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B802C324C;
	Tue, 11 Nov 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870712; cv=fail; b=EUBZ/4YU9qu0a5oTg/E6KTT8aT34dbhtatpqK7X/6smvT5h1lTA4iKjRMoWTsHBA7LJzKHMiNli28NE9HSW1Ym8HzE81P6hQ8X2hgNpNiH7ikOlQnJzYLcmgMGsw7s9muV4vuuipo6Y+K1OSn8gR8xVZDiaSA0xc/+ciLXvpbT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870712; c=relaxed/simple;
	bh=WkVJNteAa5tpILTdhlmLF/n1zsFSZYZTxCO4MMI5BMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sERhfIvK3mfd4dIte1zGFbzzxzgX0R6ftnAcAWmv0KJHIo2l9awu6Xn47ByYLGDlIaH+BkH79i0Qa4yfhYMo07jT/BxhkwQsHwcdEUaZR02ZSWIBqW8rkNFtWwJQTiuGAwiAo1dxL+lcfBxRoMmT/SAverrAM7scYVrR6a3+OLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lfB6+nUr; arc=fail smtp.client-ip=52.101.84.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR5deSkQRD1813QEPb4e6xJ5aLwEhTWZn2KKg9d0WYmMZdXU6h35TIvHH0QEfvzVsurIPzg2t+J3XNeAOvqo3iXt4ktqWSUB9sAnPvQiNFqbum8WN4ZEK/XT6kmw8FHwekdDUO/trLoVxTgThf8iLBe9boubgkwf+Pe2/NpJfuRK6C+gGPHSPNAzdmTnNcAI47hmjjYOjHpzMNn0Q0M8njwJ36Eap3px5Kbwjaa5g3tucbXPyKrIpZit8x4EbRm1boc6K3bs33dLTJtLRtSmVKXfpzWvDOpuMsz791jEpU73dHP/glhPk/EE1AKge9e38Cys4LDvzLpa1OK9ht4nqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZV1SKbjSUOu+jT7rx32oqfpHN9+EhkJKFMXEzUhOLY=;
 b=VSenllOJLWzPGfWGkYvBfjXSo0Jn0MuFIZfVqpaVT0Es0NgJTTFXdOuXUb9aStMIL9LRsJLeq6xEOhCbG5o/BN6gtmmBdTSg7Qven1SAzsUobNRjQzkKOA0Zgyyb2XEAoDv6Z3MIft8ZuK4XN8Kxcd54K1qB4/nC8F1O0U9NfhBddXWduzWYcBDS5KbJpTFNUI8GkLDk0tCYVmk9hXJfl5KoqF6eSmuKsy+cn3zzet4W6Bzd5FvlWU/fjmrD5Rfjfq1L7hZ5cl58wqQnRAISQ+coWkGX2rlZ/07nXC9amAff7fDloiWeFI8XE/SmP6tIsoEihrAWq20TXZfxvVpsTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZV1SKbjSUOu+jT7rx32oqfpHN9+EhkJKFMXEzUhOLY=;
 b=lfB6+nUrwerGwVBRd2kzqv+NgnivHiBj1q50ufpz1VNtjRjyxoNJF3Nj6p4lZCEVxRNxOg95i5utxqsVW9Vm/JVpwAj8iINF/+QfOoSMiYV7I1dCe8XJnh74FpLIISSIyh5PfAPp/+aXsdOj/KZR5cPs8hmPGELHPlbx0X5QP1tr46xGN69uHLNOwJuH7SQsCJg3aEnIXAOgUtVeB/VAQ0ep3Vvsue0dvYRTPvMu3SBwsioZdZQNoj9fPNX+M4+b+q2Wof1ozpehaaTPLlF0ZTwf8VdR8LZpu5h1s9qJNfpc8MU6xnGbddJZ3n3Hl47sqCPpRDoFQlCNG9pW7o56xQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11238.eurprd04.prod.outlook.com (2603:10a6:150:27c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 14:18:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 14:18:26 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Haotian Zhang <vulab@iscas.ac.cn>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: imx95-blk-ctl: Fix clock leak in error paths
Thread-Topic: [PATCH] clk: imx: imx95-blk-ctl: Fix clock leak in error paths
Thread-Index: AQHcUwBMzvzU1FmT2UGnvos4ZMmNnLTthbXw
Date: Tue, 11 Nov 2025 14:18:26 +0000
Message-ID:
 <PAXPR04MB8459499C6CC8C95B895F336488CFA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251111114123.2075-1-vulab@iscas.ac.cn>
In-Reply-To: <20251111114123.2075-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV2PR04MB11238:EE_
x-ms-office365-filtering-correlation-id: 936eec7b-0983-43d5-1ad1-08de212d2e1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R6kHSJ0uddmxCKaIIKsK/8IAAiN4AWgLcMZtcG6Qu55uLUQANlweBFCUWT6l?=
 =?us-ascii?Q?zGqAFzRKAylmzhGD5BP7pIvQY+CUhARlT0CL1PwZCY6HLJ0XiRbsPFl0PLsy?=
 =?us-ascii?Q?XR5cb6O08vH5xiaaZkuqoI5sN8jlKgh8xqjC0OistVP1ETCFk2VhtOQSgDQC?=
 =?us-ascii?Q?5i9/lqMvIRBgzHzARpz5Od1659VsjHYFfqbaos2UicANVgRiMpd7ptmbe5UT?=
 =?us-ascii?Q?0RjhnoFeajlbWreOPQsKvoR2BHeQOjbg9f1OjjJgXS4yp7yoL1VwHbjxFLCT?=
 =?us-ascii?Q?E0ivz4FUljsO3w5q1R1dsXQF1I/BW+JGalGFLCjjuP0m2rNeDE6BOp33L9q5?=
 =?us-ascii?Q?iZlbuVul+/6usww2lKRlbis5amyZC3WTEkzavAsHZGBgTWkBWqme5owyYFLK?=
 =?us-ascii?Q?uxwHXfb8cdof+gd0ODKslAZjWFg4iFjSlvlu69+NTNHbDmDMEBWSjif8AcmP?=
 =?us-ascii?Q?kpg+a7Rg9tjzfDyYcuhWNMW4zY4jz4/c7DZa2A92bwuMdZgTg+CI1cP4qwrX?=
 =?us-ascii?Q?mzME3kCxGzrsu2LmZu2pnUQokK138CHiiQ0YyJeGnicBpl+P2qaPv18X2/Ol?=
 =?us-ascii?Q?PzsX48q/UAZjddlqsV6QaVlt6ToyAMRMVWuI0E/8iaJ4Bj7WVa+Do8zUEqPg?=
 =?us-ascii?Q?vGHxQBKdSv/1giyENDslQ5uRnBq7ZA0NxO4fDqJ3OcLnDVduht1pGyyUAhCF?=
 =?us-ascii?Q?D8dIqStGd9kpiMNJoo2MW5ydFogB/fgf11U2OHpbOMB6WJo3PggYwzcYhaz+?=
 =?us-ascii?Q?+GSJ4xyf9si/tYmnm04/fc9LaBmEihLHlooodQd54L8dX8QkBSEpG/7rJuID?=
 =?us-ascii?Q?wm01y1Ya5x5bmcKDSZB8mBlCQq6MtgrId+51sXYu1MN5I1baXb+SPdyhAQHk?=
 =?us-ascii?Q?xuEs+wYf8aMwo6BQbXXzW20HlFmrSvZRQUyiGf/b3cbGXzHEr9eXqaL69XI8?=
 =?us-ascii?Q?KqKqGw88973HUvK/oaMXpkEFrzbWfxEyTpk/mpnZTrhKvSTppA0qXOXuyuCe?=
 =?us-ascii?Q?U/tsFdut21ahxggl/ZJcsYeAtQ85jQ74CoQNOfCM0OMIT3hTuQpW8Cgicnf0?=
 =?us-ascii?Q?W1HtfaaS5P1X5YyO0Bf2s8USagZHd8p0QGpqgtEqPcso4HiyOfPOK/BtLDUu?=
 =?us-ascii?Q?8vMnVZMVi1s496hKe38hVlgEQ3DdJAho0LME+TfZN7CpE57yO1jW4wUWlGnj?=
 =?us-ascii?Q?/rXIQ3fKD0Y1bkxGLIT8My8I2Ii4MaCfh5lvGSDexV3jXnC1WVwYJlqXVv9x?=
 =?us-ascii?Q?+IckbCPf8GiRnEPdO/9WjBYuC1P7m1qlD3eV9DkVEYxsiEJKOGAdTWIPFZeJ?=
 =?us-ascii?Q?drqgKVGkxfm/UZIkdneBKEcL+TK88dXabuqR10HcDpD/VudtEFQHuSlQaLSW?=
 =?us-ascii?Q?XIDjmAOPsjvNhvrtHzYzt0VncbSXNZdfoboj6W+KHP10EfiegRAA6aZxSHc6?=
 =?us-ascii?Q?pXxQLybfdbro0nY8+TGeb0UGdmcCgNt2TY1WCUXekHS9GBivmBx3lnr/bT/q?=
 =?us-ascii?Q?QtjcBUCqnQfD1+6/kjajp7cTL1BSYu+rW0e/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kYKpwropw4lnP6gwiS6OBHB7ArkD/e4nXXDk9tliy36KDSX3NKx77jaju08O?=
 =?us-ascii?Q?es5F0cKhA3DA3+tyLBnCdURgbO+iNcoR2owHf+Bm3QYom8Ax+QSu9q8PtyXv?=
 =?us-ascii?Q?WSooRDgDZJjTqyT4fppsD1Jh5tgBgVsQAi655sqUqpPPUCwmQntYIBzfla0N?=
 =?us-ascii?Q?R9mpODUOTF5NqaiDvNwEczMqHAMP1rnTgHXKzUxoPBPwqipRcvuERaUPFfSY?=
 =?us-ascii?Q?NrDCaA74s31usBAkawS02cZwXStnaBBb0le2whIFMLniEEKjwx037C6k9rNU?=
 =?us-ascii?Q?QEsj5fliu7TwQwdrG8pf2zQnGfjetiyVbca0uEUIgjkXHk2E3MImWqXha481?=
 =?us-ascii?Q?DghiwQtYKDtXBgAvlqRV9kJHHXgxOGKkiwD85VEkm7FtcKRN00MdeWQ8SaZM?=
 =?us-ascii?Q?ARVoBeQx/uqv6ccI5ONstB2dG3o9vZ+nHhjqW+9lhKkDhhhx0SyhOla9+xqD?=
 =?us-ascii?Q?mzpnVwLhfEvi8UYkQy06dG0Ogyuj3IXCnDvfqMCTMJjkon/21w8zn3mnUUHe?=
 =?us-ascii?Q?FaCBU8s7Ar/sBC9rjXkyqq308E2Yq2EBT/ki9KVAjExeNzcveD3gkfZDKg5+?=
 =?us-ascii?Q?HeGwmyWZTyWDWpb6jv9rbj9zljq4iWDuLDkjlc75Szz+oXJxBJ4DNC7QMBtS?=
 =?us-ascii?Q?U14r5RTQ8Ld774DdS7nobjxQpwrwKnRJtCsWBXHP9s7VSz7NeBFCQX23cPtK?=
 =?us-ascii?Q?ZqDeTwIeSnjzC8G4y+dQLH8RrfLjkAIC43ekUQvWzDfU7ygkFTuoGfhav7Mh?=
 =?us-ascii?Q?xbrkfrr4E3FalsbTPXbKTDfeE3mQMtn3fs4fyMvUmGFfCKa5IKGIifiUNjcc?=
 =?us-ascii?Q?OsOGPb0/QpRfY/jFIaIS3TtbM90RU7oEcndGj1w+BzO/s1lg95ZAAySM1t+N?=
 =?us-ascii?Q?x3q1suborTfZQoR8yhlk46hDB3/ICz7Dh5Y/IsLgL90yVm+6aHcaWtcyav85?=
 =?us-ascii?Q?af27nEv0Zj1nRRZu53xb8WVElh1/Uy7WI4eGGznIXTYnlr0hwPWVl2ReSUcx?=
 =?us-ascii?Q?eYJ3lqVX4HvwsyBuKo8CilazcXfh9/XnHzfinb2UE52jNl5wARNBqKT1xEd+?=
 =?us-ascii?Q?3A44itqRKLyBQbugjtWq5wrPAhc6VVNqrCrM/H7m0ZiblbqfY4vCgMUKfwrN?=
 =?us-ascii?Q?qBY87MEnFhUU6GpWxe6K7S+UZAZPlTUyw3Aiv1V3u16O3CnTJAKMpyvvauXd?=
 =?us-ascii?Q?4mvR772U5ILmzUjISOJAss4IBbMrn8bJuMIqBd71btnUinkw8IrUbHCY/g/T?=
 =?us-ascii?Q?CkOTAoj+sPZ9yqTx8L2KPaN8HrHa4mm2jeiLMCJGtL7gh7dNoUmzU7LzehCw?=
 =?us-ascii?Q?arkoX3ympY5h2hAA0l6pRlLyRezQKrMcJRHqyhHQz9Eyr4AuU0zWLEHkv9pJ?=
 =?us-ascii?Q?Zq9iJbCzdk/8+ewW3eA8aKw5dUcop9uBQ2gZZkc627aI9Su0a/wZhbU3XQcA?=
 =?us-ascii?Q?wdMWROQvznQpVrbvS85sDqJruhD9Sd/VWmkorNKHLgRtx0Ty/QheeLQXVikT?=
 =?us-ascii?Q?WiTQTAXmBKrWZzt9sCQCUmggXB16S0uSQd3yneKYtO/0MbWn/a4BrUUcfxco?=
 =?us-ascii?Q?HcAJIMbqpIe/K56qDdE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 936eec7b-0983-43d5-1ad1-08de212d2e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 14:18:26.3808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4V8DztsbwyJ1SN3tuRLkeOJkCvGCyoAueHGeGAkBkIHXwTZBnTF3vRG7f5ODotE4sSJBb2nIDaw3Z5uEUf4HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11238

> Subject: [PATCH] clk: imx: imx95-blk-ctl: Fix clock leak in error paths
>=20
> The probe function enables bc->clk_apb early but fails to disable it
> when bc_data is NULL or clk_hw_data allocation fails. The cleanup
> path also misses pm_runtime_put_sync() when rpm is enabled.
>=20
> Add err_disable_clk label to ensure clk_disable_unprepare() is called on
> all error paths. Add pm_runtime_put_sync() in cleanup path when rpm
> is enabled.
>=20
> Fixes: 5224b189462f ("clk: imx: add i.MX95 BLK CTL clk driver")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/clk/imx/clk-imx95-blk-ctl.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-
> imx95-blk-ctl.c
> index 7e88877a6245..b12aded2b304 100644
> --- a/drivers/clk/imx/clk-imx95-blk-ctl.c
> +++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
> @@ -380,13 +380,19 @@ static int imx95_bc_probe(struct
> platform_device *pdev)
>  	}
>=20
>  	bc_data =3D of_device_get_match_data(dev);
> -	if (!bc_data)
> -		return devm_of_platform_populate(dev);
> +	if (!bc_data) {
> +		ret =3D devm_of_platform_populate(dev);
> +		if (ret)
> +			clk_disable_unprepare(bc->clk_apb);
> +		return ret;
> +	}

Use devm_clk_get_enabled to replace devm_clk_get and
clk_prepare_enable. Then things could be simplified.

Regards
Peng.

>=20
>  	clk_hw_data =3D devm_kzalloc(dev, struct_size(clk_hw_data,
> hws, bc_data->num_clks),
>  				   GFP_KERNEL);
> -	if (!clk_hw_data)
> -		return -ENOMEM;
> +	if (!clk_hw_data) {
> +		ret =3D -ENOMEM;
> +		goto err_disable_clk;
> +	}
>=20
>  	if (bc_data->rpm_enabled) {
>  		devm_pm_runtime_enable(&pdev->dev);
> @@ -444,7 +450,11 @@ static int imx95_bc_probe(struct
> platform_device *pdev)
>  			continue;
>  		clk_hw_unregister(hws[i]);
>  	}
> +	if (bc_data->rpm_enabled && pm_runtime_enabled(bc->dev))
> +		pm_runtime_put_sync(&pdev->dev);
>=20
> +err_disable_clk:
> +	clk_disable_unprepare(bc->clk_apb);
>  	return ret;
>  }
>=20
> --
> 2.50.1.windows.1


