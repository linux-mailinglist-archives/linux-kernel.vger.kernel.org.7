Return-Path: <linux-kernel+bounces-884761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76DCC310A3
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCA53BBFD1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199487261C;
	Tue,  4 Nov 2025 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dt2pAaql"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136119D8A8;
	Tue,  4 Nov 2025 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260323; cv=fail; b=mDxlWEC9oYPIp96tLgcGj5KrIeSQxZ5CgxpQloItCcmgX3d1hdCLntRnLeTJBZJXyEQAVCXCPyZWGhfnkobTJsS/C99mN+I43/1u8BwNhoE7aTgzBELpux4agAoouTNujm/p+bhN2CMSsE6J1OwTMaLTQg0W9SrmVU4fzDeo0kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260323; c=relaxed/simple;
	bh=rN1OwvELmtEtwPp8gjeyUCVdjs7sXQgXjr/896K/c28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EiT5B51gYgGe3Ih1g54uVv4bUpw4as4BGxoL7f0AMjXWxtxknSnTPpUEpiKCd50JmI151QqJ9JLl5f0ezghJ0dBMARw6NZpOALUgqFrZERCtHu6eftwlGO/0vjKgRbI9tY22n0IJ3t/aW+ydnmTMxCQTyDkqzFfQspyVV3MnGus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dt2pAaql; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU+4xUncqjHMKw052z6UcJ4GZJ7RTdTO3P/EsaZMF7kLiYzTob4DxrZb1hN6IIxjfpA7hIKwdQLV33f8mzuS+AnCCG8brnvPwPX87NHCbOMg5GzMewU/zz/7mGJM/IHDWkytTWgVi3dd1IXtSYKrpkI0FLnu4Xz8GUqubiqzYFaXT086gP8YgvPW+MOJorqGyHfZBz8fuv4lRG4hWSYK8CoZjr89lGvKARmX67LSGfJ85HQIaMX8nsU8Zwg/jNyjpn1CETwB0aADthF6/Gf3ak058ghT4rcvwi1BCUklWSYumk9AZX6svq4HAWNQMjCoZIZ8Q5QAlqS19Pt4jIKZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rN1OwvELmtEtwPp8gjeyUCVdjs7sXQgXjr/896K/c28=;
 b=e2Sk7nAXCMU0lVmybsdUVCBrrci3sa5sr81+kpSS7MAJHsCOXwBbT47DZCOC0Li8Lg+I+qSNju5V5t8e86PnIuovRm0P1k7zW218Ccn4F54SAUo2luv2NXycWHDGeCPrZ8c5VLcPnwUWEGUEZOuSRB/fuMnAS1YwQnj0cDQXJacaP5hkTXePEE9hr0Hw1c10GwmWKiZdHTtJRZ5r50qtXQe7dhyv1wwKAuvMcqZ4cDNtuy0pKl5tYTktk5Axe3bUiHPfE+WyKJH946aKru7izxXvfC0P7ghbs6/TT50IQchV6KdNNYXDAV7Ia3R+ZO2o+mnOrLwuJb7Kcttkb/XYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN1OwvELmtEtwPp8gjeyUCVdjs7sXQgXjr/896K/c28=;
 b=dt2pAaqlC4JQMA8yf76W2HuBg+HgkB3g6UehphgQiLhhJ0LUokqBzRTcqvfKyZB7wu39Xjg2ETqF13cOWt/m5CuWXV+Nbmdm++APWW3+BQxD7917eAOUWoeKP0RPLERWVpfSAt3JzYZjT79v9/iPpZH/7MAK9Qsgwyx2YZcRAnNbMvRre6FUqoB15oDN0vwmosIGbPHPOjegQieNhgRruZrnhsoQlP7/+wR2DQ4Tn0EtDNnHYALPuLSpBv8a6X6XUJvfd+fekBdPGArlR9zUk/8cvnB1EYAZiLF1bj+orbTovFhgUvmU+q6py+pyambL78fGATuIwaHPI237pdNHLw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6790.eurprd04.prod.outlook.com (2603:10a6:20b:dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 12:45:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 12:45:17 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>, Abel Vesa
	<abelvesa@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam
	<festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Daniel Baluta
	<daniel.baluta@nxp.com>, "S.J. Wang" <shengjiu.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Pengutronix Kernel Team
	<kernel@pengutronix.de>
Subject: RE: [PATCH v4 3/8] clk: imx: add driver for imx8ulp's sim lpav
Thread-Topic: [PATCH v4 3/8] clk: imx: add driver for imx8ulp's sim lpav
Thread-Index: AQHcTYNXHATylbq+lEOFLnjYuXp+VrTidpcg
Date: Tue, 4 Nov 2025 12:45:17 +0000
Message-ID:
 <PAXPR04MB845969CF96F1AFAD5EB1DE4E88C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
 <20251104120301.913-4-laurentiumihalcea111@gmail.com>
In-Reply-To: <20251104120301.913-4-laurentiumihalcea111@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM7PR04MB6790:EE_
x-ms-office365-filtering-correlation-id: 8d359ef1-2754-4f58-5a7f-08de1ba0021d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y3J8u6AZ9NtGVm7B7tbIMeV2rFLgHmpK+PjOMgH6jHf1ChkTOGuEuzyNmjJP?=
 =?us-ascii?Q?m+sDEkeY7YQehxnSLv5AzItibuhSkJdQnxkVhH1VYjdApps/eKEJCiDEglLG?=
 =?us-ascii?Q?DTYCfdt4aXhuLITZlNxtNYK1zUSS0lOZXpptUq/70u86HgxBOG/AwoligJoY?=
 =?us-ascii?Q?X3DdOjERDnlLCA2mQNwD2Ejm5boIeArkjKWt7H27Izmt/It8CjV+eJgDlxuT?=
 =?us-ascii?Q?nYGZVnoXg+jSbnPwIcG3ZPm6iQGxubfHJCO4FOgz9AQnvrW1d/v9Og0XMDBA?=
 =?us-ascii?Q?NOR9BDbqKcHcE0epiVKxLB+LQHe8yWuG3STYJd0Kmux0mDi9vzhEDUA8y/0Z?=
 =?us-ascii?Q?XzZdfSJ0nGuPMX+3dhVgL7IJpQZKZuCnCVbEG90Y/hjmraPg7+nxFcalQSCP?=
 =?us-ascii?Q?XaRbzP2jx1Q6J3mCmEltVs2klu0QIHmayMBy592ycxccJC+Qd7FgNH9kEOZB?=
 =?us-ascii?Q?fanNutOtE02LMzbxDiynPFF/XDBJp2DsOo0/RiOIIevZZ4KC4LmFQNzDoXhu?=
 =?us-ascii?Q?g/9loJ8JZFm6qxcP1K+p1b4lavz+kgRIkE4d9LHU5eWzQgNrUINqAV88CE9m?=
 =?us-ascii?Q?kl7vk6M5c1IMlvJByRLscq8txotLYPj0TP1J7+UFo9gg6sBu5vT0fQI8IC4W?=
 =?us-ascii?Q?4Q/F5a0nz0YXTH8NE70udxlkUpQTAkXnBSO7Zpb/LV2cikcbWG8MS1mULR0V?=
 =?us-ascii?Q?K3L8Bc3sMdzPHx/kDrrdjyrnVlLR0z++qiKX/485rUakpZR1GSocBenn+Htg?=
 =?us-ascii?Q?VvTe07IrG/L9cR+bgPg4mTXBKvQg0W6gbisclUM/bymLMsBMrREYHp3YTh3J?=
 =?us-ascii?Q?aSmo5ei5nKBW8qrSM8h7tPjaEesMzKjvu7Fwpgtb6urex+Eb0BejWXniG1/4?=
 =?us-ascii?Q?19bSbmxD/lDrNJSNiZQMXkQh1a5sJZTMlIIh5I9zZ1k1rQM6gvoZu8OpuoVL?=
 =?us-ascii?Q?ZdLXjWYsziEYe0RIxRrm62+A9gmGCzaEhg6yw/ghbeg1TgSC6IlYHt1h1q3g?=
 =?us-ascii?Q?87iq088nxfymjcI9eI9TXazzRbi0bQq/yAZ9K44vyKmPY1D0CMJAs+jZRUmc?=
 =?us-ascii?Q?fw9otOJzqWyIXfvYNuUw2JKL1RbXSUojmRLJQxf5rNZESfM3vxOvsrUXzBMt?=
 =?us-ascii?Q?xETDwGw61vyOZ5WcLmMkWpWjhXT9j5JqrFt58u+5IYmCu46wGxRYx6Q+GRLh?=
 =?us-ascii?Q?Pk/sAYzFuQLtPNX/pOhno+3ieAHNd+NmDFlemJ9+d2hx3K+i1uHlzOoSIfgf?=
 =?us-ascii?Q?SzD8IibBr5i6TIW+iNrVqUctVSpdWgb0kvX6go1ROoh+i0+OtazjfHuLVYdD?=
 =?us-ascii?Q?leDZ0AFdRKXg9qv/Nl8ZFCk68jGGcrg+wHRPUdBPezoWWLcNdk8PEN33J1k+?=
 =?us-ascii?Q?wpHQgfQUTH1/RTJIITyJCloW5ppy6rhjlQGHc82DRzJYKFGJuLN39jUctuWc?=
 =?us-ascii?Q?BABD7cVjKl078cfQIQyN6w6WA92IQMuHzspgJJtTlyXrklxwiGUiR3Hyq6Ne?=
 =?us-ascii?Q?WG1+mq5VJF2+jjWW6SnwroaQtOjNYYHwSL2FgN2uO/Mu+eb6yqIxyAi66A?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TegaraErJJP0Bo+iRDROIzG6ZpqBJ/Xq695T0g2PP9+QVEnwWKbMD4nEbk8q?=
 =?us-ascii?Q?Q8Ri/HtQyYXxpZN+OYs3D4txxRolJS7oYdgKDS+U9qd+TUBebRuwd2m0glBZ?=
 =?us-ascii?Q?s5BgnGHHbTAlm5saqp5Qmg1K20xNGAqggCrKh+eYSTVl57Dc5y0IbzpFPKhd?=
 =?us-ascii?Q?7Oqb6XDPe9NOWfl4VZtXuUEa+Wzf+zECauGvhJwEjc2Y5w3CjVD+2OBLkilh?=
 =?us-ascii?Q?Vg6RnuhwE1nl/vCnTvhIRJYOBrRh//vjSTb9NbWo5laOD1CTZfRnrOaxGphY?=
 =?us-ascii?Q?FpVAHAszkAlZoOT9nGco3815Uhz2FXcQnc+t5RZH1YHrBA4W9b73g11rB7uV?=
 =?us-ascii?Q?UX7zE5CwXOkGEU4Ov5g8NgI0AB8It5M1/kYRkzd0jPUmaN4CCJCaypojtOKe?=
 =?us-ascii?Q?3U0tU9FIMu6Z05MQp9zNsLOZdcHaHSsnBnCAh37akYzDdVWV4CqRoTfgI+q2?=
 =?us-ascii?Q?mq4ob+3iG1M4AOwXZQWXTBCK21rMgrKrxWvITDujDf+qGJptMtlyD8IPum8R?=
 =?us-ascii?Q?STOgQNTkmhoMP5ZZonSumwsLdCh3axQGU2PH/rtIajJVy5v30lxA960V/UqP?=
 =?us-ascii?Q?cvVLCXZJXrCdiQAVlZJFS8k/0KW4a3Uf5Z0cNsW286nENQ+D8HYAYr7I3F3U?=
 =?us-ascii?Q?njthCyGws5cs0q7EiiechmeQ2pcFQPX8baAi/JUhdlNFrDebSRvztjq6RdCC?=
 =?us-ascii?Q?N0W/Kt5ZFltogGxkrjJAdno/R6bt5H/qL/tSY33urwpZQs8fkF5J/o3XKSrm?=
 =?us-ascii?Q?n1/w2fR+lZSLT+du6J6d2ISqPOthYP8Nu6nfxTwYqM6j4/n4DIz7LQBRdP0h?=
 =?us-ascii?Q?jWSKn16qsrfCpqaCiCEd3qAGbPM3LxG6wvjmi3hHiUT5VhzL2NZ12LAizkx8?=
 =?us-ascii?Q?n6oK4PZRE2g5R+wfAIHjwbjgH0q8nI3utmPz1JsmhFCvyH/UpNSruXGddf5i?=
 =?us-ascii?Q?TQRfOdkf2f+TaLXib/eDMHRe63U/3Hw/feWEyDkKojIHQiXmS8k8AU27Ue5J?=
 =?us-ascii?Q?4kmtd2/RiLLEJ+LZ/aLxIFbdnO5d/APiwZtGIAWstNMigcP/cvBsYl8WMm3K?=
 =?us-ascii?Q?LrRFFDJ5fj1iqodJ+K8Dui9yFElKWxMUV5QRLQYy4uxQXs5h8/3Uoa/QjHOE?=
 =?us-ascii?Q?wP8qAa9iTYXINynnwptMizKI3bJysCRv6jjUAnM+Kc47cNcv4r8doH+8cwVv?=
 =?us-ascii?Q?HtakkNG7mGZeLPvDZ3wN0VsWMANOwGx8AidPTHtQhpME9bBjJxGjZtwgWHIh?=
 =?us-ascii?Q?U/oD+7GGjACQoB6X4ISneL8WkE97VWaz7ipVrhwBoOBPTpPcsFIih8CFePLW?=
 =?us-ascii?Q?QdFyzEZ1la3g9OsJUMHnF/zZX9x++y+9UqCxPGzXUnDvKqbMMpCQn/txLJdK?=
 =?us-ascii?Q?9E0dXFBeIL1AyY7f9mzNS7bs12sAkLoMZ5zZ2my/+RdanDDyV5uLqJuQGgej?=
 =?us-ascii?Q?ZVc8DPRibmmUkdCqjDUbhe/HZ8nNeiGUdZpkrgRsJAE/K4meAERxt92YKLXE?=
 =?us-ascii?Q?imTtT905X5CSwYv6hEzm1f1D+1f+fwarHYc8Lg+mS35YFfnupMwudgfNs/hD?=
 =?us-ascii?Q?ynGxHV4rK3Fc5Z6pd0I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d359ef1-2754-4f58-5a7f-08de1ba0021d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 12:45:17.7342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0fDfhr/+OV2N/xIqcYTtxLw50+/f785gX5ewU76Msk17aZAk15cTHqBTagCDzKpwFre19iwzsasYRt6mziBsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6790

> Subject: [PATCH v4 3/8] clk: imx: add driver for imx8ulp's sim lpav
>=20
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>=20
> The i.MX8ULP System Integration Module (SIM) LPAV module is a
> block control module found inside the LPAV subsystem, which offers
> some clock gating options and reset line assertion/de-assertion
> capabilities.
>=20
> Therefore, the clock gate management is supported by registering the
> module's driver as a clock provider, while the reset capabilities are
> managed via the auxiliary device API to allow the DT node to act as a
> reset and clock provider.
>=20
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

