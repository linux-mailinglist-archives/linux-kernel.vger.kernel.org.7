Return-Path: <linux-kernel+bounces-805716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E67B48C97
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712283A65A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8E5229B12;
	Mon,  8 Sep 2025 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EvVrvXoq"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D52A1D1;
	Mon,  8 Sep 2025 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332403; cv=fail; b=th+XNdMmDjbGlM+P1calogyLrTOyMvq0hbuFyt8GeIDCiCuu8JgRd6bdMI/9BNT4no0+0QV9RVh7ZedSOFAWxmvzQcD4UJfiydfuIu5kDURF4q0T/7WRBruMpEgzfE5FQlauawYr9xn2kSCLsXHtpm63D15fN+sW5xUUsY0OvMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332403; c=relaxed/simple;
	bh=MCiIAh0Ef7uINXAjaTBIiRuhQ5z7/uI8aT97lut+eks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RTBIicO3OnDWJL+BS4wNNaWz8RBcplWq80uqZ5s5+BETKMI64hgfHeccxVSwFqABkCPacFrTvqrA1VD73SbcZHc4xLMYkGrVo0OIsmEDtqZs+yP6RDZJ1pPSWOj7BIYxgbcrjszjGL1AA1egVO/LOBl1XW5URnq9/K3CKLFCOTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EvVrvXoq; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWrgb4yBzCm+5sNEr8o0FGhSCSOLZ6fzkeejfxcskus1inQscQHr0hzICqOlYh66SMdRQR9L3U+3zOiQAa5GbN2sTX+WCbLj8bFzXmk+CIhW1H7oBdjrINLO3z1SbcYI4m19sWRMV/2KwFmByzmw5H2tLUVYGtXVkn2W/+LPBRRGOzkTwDpkeUxRzsrgN/NmlyaI5Oc6IS/K8DkY2PGl4IwIiQZSAtQj0bAy1xpg8nqC98jZwnW9WcwVC6WvGzhcc6x0tFgIEEE2d6PnlHBMVPYNVnsqNeEJFDjOCt0mZRsqQRdWamOcsdKQ0JzHlI/CdD4v0WaWxoIc/lndeTXixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCiIAh0Ef7uINXAjaTBIiRuhQ5z7/uI8aT97lut+eks=;
 b=PXq/76EFBWCiZAkqwZEAflTuoUlHefOh1cSD3Qp5hU/WPXKRkaktaCz0a610VSCGywW6v/c4cuPGy3DjPefijJ/aBf9F4EZPS1mf/7x71FKONzPc8tGiZ/g9EU26h2BvS4D9JQoJmwzQXVvuAhg4vEfLTrmaKdlFyGJW4LpWb0Ro1wewiwyJ6pRGzLY5+WtoCkm67D99ywvUiBv7ie3zwEvyj7VADzuRAFokdKI37vVw24MAIaBA1EFnPEjGCn2mudfkP27WxKroENlvOuBB8k6glB0F37FdhOwMmv8ctTFbN/elRhLQNGVKP+0OwLCWyaBi+r+iVdGWtAtcxM5ULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCiIAh0Ef7uINXAjaTBIiRuhQ5z7/uI8aT97lut+eks=;
 b=EvVrvXoqXQs/axvJNrqgjXbVVIWqO53TNKSP5uDwVE+lEbKyVnGbbycHWfRMc8bmWUAhEEhHulSaMyhv8rsl/ChVzBbKN2W3iFubUZ0UfsIhukT/XtsAKKy+Vl5RE2cjn5z3EFDEcyqFv1m+3QBWVdGRsfCRPnAUPHnszOSjJIgC5nkSU9y4/k65UQOYhCJXNepicoKdrfBNhfK8hteuSiqztTyyn8CFLrf4mHqXi1Z5OE6FzcDr650uB/gmcTk0ja76Fgye3e6bQRGftbnjOAzg/5bnf4iHprjr3wuBiAJzrV5IvxuWQsU6BOeT2+uUqZoiQqMBDUwgUF7JBKqzbA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Mon, 8 Sep
 2025 11:53:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 11:53:18 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: Cristian Marussi <cristian.marussi@arm.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/6] firmware: arm_scmi: imx: Dump syslog and
 system_info
Thread-Topic: [PATCH v4 0/6] firmware: arm_scmi: imx: Dump syslog and
 system_info
Thread-Index: AQHcHYh99w+470bowEmoLbCpX9ms/LSJJxuAgAALh4A=
Date: Mon, 8 Sep 2025 11:53:18 +0000
Message-ID:
 <PAXPR04MB845937237E3C1AF5A2ABA8FA880CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
 <20250908-brave-umber-spider-eb68bd@sudeepholla>
In-Reply-To: <20250908-brave-umber-spider-eb68bd@sudeepholla>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VE1PR04MB7245:EE_
x-ms-office365-filtering-correlation-id: f39febb1-fdbf-4b83-95c1-08ddeece4d2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ju+hlsIhyPPwizSgfGC54QpXUpzwXbcGsPGqay3bc4gZdha6VXJnAbnWAJKn?=
 =?us-ascii?Q?HyhERCOUSGvZ7TyvUabz4dNiurM6dIvN72cMQqQbj9c/KkdH6Ta9bo3ZCgeW?=
 =?us-ascii?Q?/R7ssw8Q/EKG1aD4HAgPzX3AqdO+rh+Bnk0nBBjo/s1ynATvOO1K43PBedRl?=
 =?us-ascii?Q?pfct15NPAFl5VuVTgm4IbV3ijy0yqdokfbYQivoLhG3+eR6v+VyD1mR48VY3?=
 =?us-ascii?Q?7hNEygVyRBs2rcbU843WYTeieSTBY5QSfI7QHA50CvqQa/2Z/UhwDEUBwyO4?=
 =?us-ascii?Q?xd5LWw5l2pkLZw/kEA2KIzyDfZBL4sgG2fwo3ZPdS9S20yf2lKhDVs3IZsDk?=
 =?us-ascii?Q?XMDdciMIbdOGUgorb58LKlFocZHNniWEAV3pGWHqOen2bYNmQWZm1jvXYWGy?=
 =?us-ascii?Q?BFhJvNCrQlZ0D0g9KGsB+3G05Seuea7cIMFeVEr0cSn304HGK/kY9XsGcI0x?=
 =?us-ascii?Q?K6FGAgiTRh0yAFBuydVZenKDCh5ZTR2NtpjClcM7dVs6A4KEC04Ke82ao4ig?=
 =?us-ascii?Q?QKn74SdftRzGWgivzOourPACp8VENQYyex4bB3YrPopfwOfA1xEhQxMAaOnI?=
 =?us-ascii?Q?663j9tj4CRcajpbj7oDgD6lzoi3zn5XECBWF4V2n4JGIVAQN6We6oowEAE8q?=
 =?us-ascii?Q?2tgbFroX77rmA5Fb8lRP5uOgjlFIpFGQD/Sj4v1LrFrfKEr10JMLwdVxhLjO?=
 =?us-ascii?Q?6u8xbCbXMyzkXWv9rjydWz4KucHkbqhCNRctSBjysot6FxK7QP1GzOr2VXxA?=
 =?us-ascii?Q?gAKCG/LmzrvcMg5ly2RkTu+OzYeVxXxz69yJ5rX/IGYJu6c8UCPqdi+BKwi9?=
 =?us-ascii?Q?uptcvzTAF5HVLTVV3/Zb8mGMdJhY54eMBYkxaaKA8ii1DmLpPxAcyucND7XZ?=
 =?us-ascii?Q?1niCIWUt3ozX63WFEk+oTyICTju3HdtLwALz4wdr4RAQlm9tPLypR2G43N+u?=
 =?us-ascii?Q?M0eoF9RKCi5PT6NZd4yP41yE09vOGSWO/mcvvzlAKgVfKX7eufBfswCLzWnY?=
 =?us-ascii?Q?qnlDhScf1/53c1W2+7M5DuvWwFYjTvLE7B8GWs6FxyFhOG2m2eaKvm/RScr6?=
 =?us-ascii?Q?FLQw6L42hKpHYolRKlthnrc5aQrZ2JeVOaMPNbbMhmo3tvgBBDWPuuNx4l8p?=
 =?us-ascii?Q?6ZwkFKCZw5NqEBHAi+QPd1Pu50HlOTRWFukOLOQ/LU1fwmyF68TlUuTLiKAm?=
 =?us-ascii?Q?ssugiWoFi9ysbvPbH2N6uMzwyTmhpnxRAUOozWzJ83AGJC9wZPOv5plp1qEi?=
 =?us-ascii?Q?OIYRgWy/adrTBuRkg9yvoor3cM7ykpP4yHWIzQol3cJ9YItVSUpyYv/U/SPM?=
 =?us-ascii?Q?t2YHFWdiGvPYfLl+EU4JaycF9jjb8jqnxyheK1iP+ZXujfToUOZs/tO3TybH?=
 =?us-ascii?Q?Sb/esi2HZ2uQg9Ko8895c20U5MlWvJjX+pgLpWD/wj4zrgrBYVMYPfY6Tt8f?=
 =?us-ascii?Q?6bUtMaha0mbCGF/OJd2krH/xh08GHphHmqtS6Xlb91/qsapAbigeAw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KiRj5t9mnVP/aOYHlBvZSzINJxnQv2SeyoF04ZDMIR8fnRoo5fcz0HX9c1UY?=
 =?us-ascii?Q?bQiiSL9k2G2nwiBZM/wvMGL3hFcuWKF4EnVasms72U1+Mzns3vllAzTPaEF1?=
 =?us-ascii?Q?8wTsDTYRDkUF4mlkiZ9jkmej9o1NZ3GbugPrsJBYNXlo901rlGWgVEVqaj14?=
 =?us-ascii?Q?9nKOUs4SCZ8n8yn/W0P3LjuKdwkEYXVdMnV4mJ5r6Vxligb8q2thqF7Mm6y0?=
 =?us-ascii?Q?Hr0IJF9/KzbJtGPue16uqxmYV4QfRq0CX8tpxjkA4cUj06HuR5mCqG5U6E4Q?=
 =?us-ascii?Q?GFI81Qq1GgiMJpsL3j2Hv9BOGEkvUUW4XHUlUPJIDPBAOE/xZdvZOrRRPONd?=
 =?us-ascii?Q?EPdJ+1Ln5ZbHgyzVpdSQGbk/Di7nyFhdW5tzK4hmXTb0rQ9obfdpUF3i6te/?=
 =?us-ascii?Q?yPf3dIc8s0m2ma+PuI4qcLbyNijdrpj18+phFcfLHxUOa/zhWqsoChSM64kj?=
 =?us-ascii?Q?yAwmmI5ChaeAk2sB5zhm8m0Iz5bRlJi+vqz07nVnpRJh2uto1qujCJybLo4D?=
 =?us-ascii?Q?1gevyn1lXORXqVarTOeB6H2R34PXAOwtvAkcivKZv7ihg7UOQTy8nc8xUWTE?=
 =?us-ascii?Q?4Cly1euz9TzW5SC1Tn+uRXuCB0xniAbRb9qAakvCawuml9ZGB80/BCaezNv8?=
 =?us-ascii?Q?QuORbsq4ciMDvr58aTeU7SV6hkbf/MGj9icBIjiL5l8zORt9HGwtXaweqNsZ?=
 =?us-ascii?Q?5yZYL4nUZVHRjj/XMMOUM8AF0uSUpgash3usUInQUWalquwYz8mHu8jcqMn+?=
 =?us-ascii?Q?4ztMb10w9VfutdD7MInxpIA0hHZZKNwkNemYyj3aiAEBr74ud9Ovm28p2L49?=
 =?us-ascii?Q?rS7zOZYW9zeSd0suZ7v9dXMH5VwNnm/cwO5Q3SauBuK3ijcq/FsHGT6GgZLC?=
 =?us-ascii?Q?BibL6/6P3kT0I9NZu7XQWZx4L0kRu1AiGhNh5Vy/2QGuqrpFmqiM/Sv0PB3Q?=
 =?us-ascii?Q?Y63UJda0UTXlh7Eq7oDAuK6Ti+A5znWzi8UgkJvEU+a2Ii/vQTHktrxqzvqi?=
 =?us-ascii?Q?N9vf39UkXqNJsWcVgOPnvcryVXdmCZHFk+qnBlLtlMk42yX5HZ4ShL/55b0Y?=
 =?us-ascii?Q?e0DYffDzuBY9TUN62xNv7/jipjWjkP8yeAYPXKO2agGHYTLebXhkFG+QH0Ue?=
 =?us-ascii?Q?GY9rL5QIwECsqZI0hTuqvJecBxr6WImxCYTKC/UNIrZ9FZWc6NNDpR/tcCjn?=
 =?us-ascii?Q?+uXp5x+NCCzWA3S+6Rf7pm9o3I6CPIlYHKz4mca5mteaz8G81uqOYKvr+e5x?=
 =?us-ascii?Q?X5D8WiI6m8UlRLVIjQPcKLiunzk45dwNBVDwc48GuR1OGB5RlVlXFnT9Sozt?=
 =?us-ascii?Q?NsIgh2LoOhzWkNrJUiCtGiAa1tDx2SH8J/DL3eU7nmcHMcVVfIxLLK2Xg7tW?=
 =?us-ascii?Q?ubpG6N1xAIsvZDhyeRcUK3dqbxDRg7ozsX3K0pURlUY+h3rr0mTFQFi0swqU?=
 =?us-ascii?Q?kwS726XwI5yACK2fBoikSyerFUt6cSPCF0YEtxIwea2eDTQ5SdU7wTXM96R+?=
 =?us-ascii?Q?cD23hZbnKOFJO+qSa99smPnCGQd3hnSF0qMfJr5sc1zdmMk0lbjcZxmsMesa?=
 =?us-ascii?Q?cZ7VNwxpfS0CRSax8Aw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f39febb1-fdbf-4b83-95c1-08ddeece4d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 11:53:18.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nIWmTmV6LGeOKMJFsYVadcqZIEOncV7PTYjQR3FKPpKpK6Wxdz/EtfnIjVsMxb+Y6N9Xq7/+5Ek6Y3ZrRlj1Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7245

> Subject: Re: [PATCH v4 0/6] firmware: arm_scmi: imx: Dump syslog
> and system_info
>=20
>=20
> I will queue 1-4/6 from this series as it is ready.=20

Thanks for picking up the patches.

So repost 5-6/6 when
> ready. Also I notices some inconsistency with CONTROL vs CTRL in the
> code and document. Please choose either CONTROL or CTRL and use
> the same in both document and code for the command names and
> send a patch to fix the inconsistency.

After the open discussion in patch 5 is done, I will fix all and post
patch 5 and patch 6 in a new patchset.

Thanks,
Peng=20

>=20
> --
> Regards,
> Sudeep

