Return-Path: <linux-kernel+bounces-779693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB68CB2F761
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C5C1888F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0005B3074B1;
	Thu, 21 Aug 2025 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J3/wpyIO"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEB62E0934;
	Thu, 21 Aug 2025 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777581; cv=fail; b=Ca7lLJr9qYBjFblf25WhLagWJa1oXq7bOuYSQ0azYmYYjlMb8B6ur8OJ/NAQ+NK5faGNXX7Fk5uGpsSNqLtWJSnIlBJtB0hjHJAPtwxUqxVmjP5KGwlNaQogrEh2xPTWCP2gpujLxSc5NDf9KP+0BSu5C8TurK5DCmg28BF0uhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777581; c=relaxed/simple;
	bh=uGklgbYQ3OD2UN4W/RAJcdsifU1609bp8ag/AZVKX5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LqZ1A/6R69WkuDqCrQP1vjDaU7uSB1V5uBICbc9BHS1jV6gcfEkRuKUE4ggwEDtk/MD+j/eYJ65zQk1qc0rUuHmW/wvYSe/iLEVs/LUMFP3IwWjgEyCYa2d3t9ZWScN6qTcOgAW/fS/UDpdZo26N/5PQLiGdM/GSUt+Zrgftb78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J3/wpyIO; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYSPfEAxUVhj7HhTfroj7XpKwRyVMKUUcEI8BX0TF78yR/iov6BdYy5Q0EWl+3Yh5LYtcRI3jYtbZ2+F2lJaHYy8Nx1WJEe8UZiozatvd2llxwkI8FFJnYntFOtqk3Bb92/hsx7HUfxwG7atWUZg4YeN2TqxZ/iOzzX0KXR5gjXgYVFgHJr6T8xKXYLjXkXq+CFVuQe9ztVy6btKlw6DHc+MDDv06iMKzd2ToM+Ag6FGdyaYTb0jpXbN2yiyf0Adlcwy98PZyeTNOOcVaoo8ft8K5FFVRkDQAX5GmLLlA5357EBxOPtY0JLMxehM9lrUDmObhiQMtPdLCPiaCzln4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp3Horu08Vim7uvYePgTA/myUoTMVoz3ta+dveZakWQ=;
 b=gFhwkA3FTJpE0VhAh834pixnO3ofEq854Iwvv4JRpk+kydsBIc1MKYYSKFp5iN4aMEK0CgItonr8M0UAA5zZnDE0Tf+mcOes07iGKs2qxGRFmQgcErN90+cS1ugkN2b3TL5kRlv55kd2El2CHEx574s62+6awUcG9ik2Lqqr0BEzQmi6mDsaO9f7dVRTl7t7CmueYhhc0PJ0MtIlz9YK+D6lXZPRecL7Tht5B9SdbfhJmwLnILMbr83lezkgFIEypO34b5whS7h7GfE/Oz2+EF/RjoGVHb8tta1W6vgVsbzmWQSIXx6r9f2QnEVmXfcKxL6zYzzBuYNvRzSWkpGuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp3Horu08Vim7uvYePgTA/myUoTMVoz3ta+dveZakWQ=;
 b=J3/wpyIOtenSXvsgC4yS90fTolhls9YdwjPASgpxvwiAL7zyQJ9JbURLHD7IdTyaErFf3W98VpU3rHMNpXfm62KXFfT1ytmMKz7x/KAjxeEp6NRlYMRRhzvc3lPDpjY4TPs8swF6Mywr0bSnqKQ3d9y8pKYRIeT1/QdLxVVB7NArf829fRMJ/FgI90oJ8sovasTjCQ3ZxmapftDiIvteffpd/ZzCl2stgGrNaNwIaro1YYqn7idabi+6syS0jiJWxxW4fsMjU285OF5Tj+HoTBKzVWfSccKe1Be21vkfEuBQwzc+rN5WfaLtRhE1w2l5zM6rDGNhttW3HEV1gI82SQ==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM0PR04MB6866.eurprd04.prod.outlook.com (2603:10a6:208:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 11:59:35 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 11:59:35 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: Frieder Schrempf <frieder.schrempf@kontron.de>, Jonathan Corbet
	<corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Frank Li <frank.li@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Varun Sethi <V.Sethi@nxp.com>, Sahil
 Malhotra <sahil.malhotra@nxp.com>
Subject: RE: [EXT] Re: [PATCH v18 3/7] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Topic: [EXT] Re: [PATCH v18 3/7] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Index:
 AQHb4RFy2NjRRk9es0SVz8O1dms9rLQTvUUAgALjSvCAAB1dgIAE1IEAgAAdTACAAXh9AIAJZc0QgAr2xgCAI+auAIAAffuAgBY8mkA=
Date: Thu, 21 Aug 2025 11:59:35 +0000
Message-ID:
 <AM9PR04MB8604A636762E81DF9EA9A9B89532A@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20250619-imx-se-if-v18-3-c98391ba446d@nxp.com>
 <20250625105546.pxuatcnfpe7mssgs@pengutronix.de>
 <AM9PR04MB8604611B8D91B5526C9704E69545A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250627084653.6vgwnm3llf3zknlp@pengutronix.de>
 <b02055bb-0995-4fd8-99f3-4ca5146eedd4@kontron.de>
 <20250630121722.wviidlggt7hguyt7@pengutronix.de>
 <087b8689-7443-4720-a94c-160edd31a5da@kontron.de>
 <AM9PR04MB8604C05882605EDB4913DA089549A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250714094124.e6fnkrocnqagbm22@pengutronix.de>
 <AM9PR04MB8604EFCC5400DEBB7DF0CF49952DA@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250806132701.fouikyuqtzdsxqwh@pengutronix.de>
In-Reply-To: <20250806132701.fouikyuqtzdsxqwh@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AM0PR04MB6866:EE_
x-ms-office365-filtering-correlation-id: e97ec49c-1f9e-470b-a0ad-08dde0aa32ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+mY9GXav9LtMRLd7gn3KuNiaIH0OepbadDds1qvY1GUkWAhNaZK7xpQYfIlA?=
 =?us-ascii?Q?StdXJ8L+Sg6qJPfkMtyqZxh9JsWguFoMUXPh2D5Ix/oGNBEBbRWXl3QKsD9N?=
 =?us-ascii?Q?9kv4S/BiUDDUEh3b+XkkK0v3UOiT2Vxsv5IeHp9xfvuVdT9cIay20o7QNVAs?=
 =?us-ascii?Q?49d09rS0QzncgO+y2srrnSN2uXwjhE21PiVA96PCb8S77ZsXnVoFMeeTdBst?=
 =?us-ascii?Q?YAwkPaveAVErXWRai83epvAPt38R4oCej7ygJLogwP2psniV6LyN7KUivC52?=
 =?us-ascii?Q?2jB/liKF54LISXI79dbkgavdOlqe+hQyw87+ka9xLa48Ug8u8v5s8OZadmYk?=
 =?us-ascii?Q?Rgq9FJjp9PvUNKW0Jtzk6afTBTeybrm0EC7DbsC4jtWLTtnDmw43J4/j/ISn?=
 =?us-ascii?Q?AG80SDUviedBsVVSd6vyxTF8KLKyzNMAY5u2nfpoTDqj2JY7jIf+rGXDiryg?=
 =?us-ascii?Q?QoDyi37NzHCvfGvHqzh616+WV6IR6I3FGSCuz6sthQaHBdfbm0kEwKHE/JRZ?=
 =?us-ascii?Q?IWBVHv6PvMkuMRATCqUAFy3wIb0KGrjImciAYv6JTKnJG1oxl/Qv69/LLVUW?=
 =?us-ascii?Q?ElBRsRqIy2Im41y7wIciNf793/rGN0D/pgtbrTTjWrGw8pfLC7xyMLTV2dh7?=
 =?us-ascii?Q?bYyHUwr5ppXB/x0FPBJ2j8teS1O7l53dCCWeiAmzt55yJmhS0REPnA2f6E9N?=
 =?us-ascii?Q?5B7uE/rLZ0SNzVerwP42HnFO7Fu08ox3BolWdrmVGtuiINta5Xv9Ks6bOHxu?=
 =?us-ascii?Q?hdAOqG4Xa0EAyKVv2Rquh0sSn8+t/ezplXKajv3PCwYCcU29i56NYMURlwcg?=
 =?us-ascii?Q?U8UivHn8TCm7aGo7RLvxuob4aGGH1FUlhOzbXQWjK6Yy13JC5LTOvpQe0osZ?=
 =?us-ascii?Q?RCFIcpA9CdZJnb5u1NVLvuWtvY9FLBn14um/s8tVFibsksqEznD2WHHLKjzW?=
 =?us-ascii?Q?Zh52U6yByD5mp0s533KNlJ82EPYm6nj7lEQ032GD3KISVt4JSAA1eEkknPmW?=
 =?us-ascii?Q?TVn0AjNnGWmiTO2kuJfQ1w0CwyyrragR1t4GXzbXOhKgnxgRtwXBRtKUVZof?=
 =?us-ascii?Q?b9+cLQDHEpw01ayThl6x56QcKPcxZOgnJryUecLKqun30KMx5i2ixIgDzXiz?=
 =?us-ascii?Q?erAzDWi0Xn+b5lSuzUiHug1l4DTzOtOjxyPNlFAGuFHykT2c8wL8WvZHE+oy?=
 =?us-ascii?Q?sJXMmnYlNUHNkW4Ai4Wdej8/H6gTIKJpNt2CGHfMHp6PKgpqBLVnIZ/6OGmY?=
 =?us-ascii?Q?P/E6Q2IghT3iHf5n/QJqv/jS2Zri/GdHXkrbKecMiUl3fCsq2RItNQ2PijBV?=
 =?us-ascii?Q?tjfLwbNRE0tlA4B4pTF7AWlsry3vaOYbYKBP83MMYyPDTzwJ/D8dFsE1u2k6?=
 =?us-ascii?Q?o5jk3N0AsIgswF5PiFFGVUi1261PRDttYrq4cYIg3eJ6SmCW85omLxcB+qfm?=
 =?us-ascii?Q?+e+UHkWNS9xty4gyib8MOoSNQInoYsxIq4j+Mm4TKDn8LXQ26FoR6WTACKNj?=
 =?us-ascii?Q?StpllDja2Szz8xo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(4053099003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9dc1AZa4jiZJbkhhgRuvRiX3drnwfa3LbIxOQq2kAwS1QN7nIkOQHZivWPdC?=
 =?us-ascii?Q?/1CHW6wugIur2s/Aejeyi/8Skrlp/q6jRnav61YE6GibMzIyp0d+J61Bon2W?=
 =?us-ascii?Q?5FYJApEWz362zlwa1m4xmb5K6PVWl+qpMeTsjVfHhseaWNfVHHWG55zTGMUd?=
 =?us-ascii?Q?6ffCTLD5VSMnDcTR+MHWwjDwDHDnrdAf+HuIQqj9sa2Spt2MTqN9TNVqktfj?=
 =?us-ascii?Q?GHFYo3Ea1EEgIpbb9UnYhTN3Ikp8GFnkMRoMd41LiA3kSYzxYvHMnbccbpXO?=
 =?us-ascii?Q?m3oKmfZAb0yYz9bTBgXaP0AZL8RS+akmYkSJZI3Yrveu7I7B2GMjpI8EvvhT?=
 =?us-ascii?Q?1gfwzrgVMOP1n5Yg5Kw+xpx43tQlLaGxrsVIFPc9Z4X2v81SdR2sZNI3e3E2?=
 =?us-ascii?Q?EG1qNFLgBsytS8IOCaXDmW1iQAAfxEaL8gOSsO3M3A9nHYbc+3tg3t3thFwA?=
 =?us-ascii?Q?d7MSlmvgtEjPAtks/jhvt66HV5Y9yI4KmFhWuu6cwaLEVRWLjznTOb+v2rec?=
 =?us-ascii?Q?RSzQtsaTv9/7Xm4m3KWKGrFgFAedMwPPJKwmRlc3d5j0vJ1RNgPGl/5qVVqr?=
 =?us-ascii?Q?r7Z/yujuK1nIc+tZn/cpL2SoUA0G8rvzj1NhUQtpKm8eu9hyjZFuRxrW9xwQ?=
 =?us-ascii?Q?W5w+yhlkV8WhjNJbwxQdE2MNWzilk5iMwFvZz6Qjs+6zb6WqmBfTmK1dk1UK?=
 =?us-ascii?Q?thjht0jmGRW4+nRLsxsRPhwTBnI+kiNKXuL27jtRxQFxWjUr/pYNymxCMa3q?=
 =?us-ascii?Q?hlg3tMAquoFPc4+qXzNJ7+FhTF8CRM9vtmgbRD8W3dnby/hy+IrQ1iYmMbwQ?=
 =?us-ascii?Q?5siKcQQreFdbSXndBtj+4iYVy9UxNon3tarB2L8GeK9WQ2mFiXRh5+hFgn0c?=
 =?us-ascii?Q?E2upbUiMCOOqHcsXZZhHxOf/hR5hBjEpTBm+mH78u2wEbDj5ZmV5oC97xv/F?=
 =?us-ascii?Q?KMxrf1PNPZSQvA3LLqImNmJMgmV0HXBTdCecyujcPwfuJCSoq2thQBZJYp55?=
 =?us-ascii?Q?9jOY0CR9548vxRha3KKRhK3vHnv24XDSEHgZzgVbbwCxUdwytF5iBLtaprnc?=
 =?us-ascii?Q?aNVKbdYANgyPGz8cdNq7ILmoho/dJ737EysWNm+KHzXCAOBOr+lvojLncmb2?=
 =?us-ascii?Q?xrfassULus4mebhRWC+MzgVq+5ygMWik6caSvccBWgpSDyS7OC5a+Xs1PLqL?=
 =?us-ascii?Q?4PCcV/4VnCEOzPXIkPvZy59H6t3MGh1iQtZaC0ueswVsXzQ5nZ56y3ZAvlua?=
 =?us-ascii?Q?ufTBCmdaIfx/LY93XVDaLPQd3k88eJEQJYwQ9SxGyFW2mQm/NZ0n2D5FJ7ll?=
 =?us-ascii?Q?BIcTdJH3Rcw/VEbaYqmK7mD6+Gk904ZmiO0ylQLgOmoSdcLAobvE+eXxQ+JP?=
 =?us-ascii?Q?gKNKpVpbEbmBbfGOurZJU7cGAfkdfc2+c2Stve/aGAxY/QBzZsPQYNJUctJ/?=
 =?us-ascii?Q?eKekKARJ/G/wnAn+qH9Obu4JibMEM5LxFTl2ScHtXepSuQtBmyVWuqYs4DIG?=
 =?us-ascii?Q?DV/8mrpCsFI+2pt2wlGIo+7FH53Nqjda5lgmLBynImQgXV/EN1MdEkmDcKje?=
 =?us-ascii?Q?DnOdIztSg95bYA78pWw2FL52xm6M3TfFb38QQ+Hw?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_009F_01DC12C1.27802590"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97ec49c-1f9e-470b-a0ad-08dde0aa32ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 11:59:35.5576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSs4P5yuWibVFyhmCvLwJG8FAg2buxnCQ03/CghUR65sgxvfxZYTXfrIlhHUX+vDzczjbFvUClFmI/RgV0Qp2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6866

------=_NextPart_000_009F_01DC12C1.27802590
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On 25-08-06, Pankaj Gupta wrote:
> > > On 25-07-09, Pankaj Gupta wrote:
> > > > > Am 30.06.25 um 14:17 schrieb Marco Felsch:
> 
> ...
> 
> > > Lockdown: For a verified boot setup you need to burn an eFuse at
> > > some
> > point,
> > > to tell the bootROM to boot only correct verified firmware images.
> > >
> > > After this lockdown it's no longer possible to burn eFuses from the
> > > REE
> > albeit
> > > the production line setup still requires the support.
> > >
> > Understood. ELE access from both secure and non-secure world is fixed
> > in Q3 release.
> > User can be able to modify eFuses via OPTEE.
> 
> Splitting the read and write between two drivers is even worse.

This could be use-case dependent. Depends on how customer will deploy its
solution.

> 
> Can you please point out why you can't just move the driver parts into the
> tee? I do see many advantages if only op-tee is used:

The ELE's KEY derivation function takes account of world from where, the
operations are requested.
- The key derived from secure world and from non-secure world will be
different.
There are different use-case for ELE accesses from both the worlds.

Using OPTEE ELE driver for Linux specific ELE-HSM requests, it will add
significant overhead.
Usecases like Transparent TLS offload while securing the secrets in HSM,
would incur additional overhead.

IOT-cases where real-time encrypted feed from sensors, will take latency
hit.

> 
>  + Minimize the maintainer effort, because only one driver
>    implementation is used.
>  + TEE code could be reused by other OSes  + You could already start
adding
> the support for it to OP-TEE because
>    no ELE-FW update is required.
As answered above, we do need support of ELE driver in both worlds.
  
>  + TEE is used anyway for new projects due to CRA and friends  +
Concurrent
> access handling is done by the TEE core

As answered above, we do need support of ELE driver in both worlds.
> 
> The only downside of this approach is the integration effort for the TEE,
but
> this shouldn't be an excuse. Mostly all well known buildsystems
> like: Yocto/OE, buildroot, ptxdist do have mainline support for OP-TEE.
> 
As answered above, we do need support of ELE driver in both worlds.

> > > > >>  - With new regulations like the EU CRA I think we need some sort
of
> > > > >>    secure-enclave anyway.
> > > >
> > > > > Probably some sort of, yes. But not necessarily in the form of
> > > > > TEE or TrustZone, I guess.
> > > > To use ELE features through Linux, there is no dependency on
OPTEE-OS.
> > >
> > > Once again, still no fix available and if your system requires a TEE
> > you're forced
> > > to move the ELE communication into the TEE (at least until now).
> > >
> > > Also the eFuse R/W access is not possible from the REE/Linux after
> > > doing
> > the
> > > device lockdown.
> > >
> > ELE access from both secure and non-secure world will be fixed in Q3
> > release.
> > User can be able to modify eFuses via OPTEE.
> 
> NACK, please see my comment above.
> 
> > > > >>  - Making it optional cause more paths of potential errors e.g.
> > > > >> by
> > not
> > > > >>    including the correct "secure.dtsi". Multiple paths also
> > > > >> require
> > more
> > > > >>    maintain- and testing effort. IMHO I do think that one of
> > > > >> the
> > paths
> > > > >>    get unmaintened at some point but we would need to keep it for
> > > > >>    backward compatibility.
> > > > >>
> > > > >>    Having one implementation eliminates this since.
> > > > >>
> > > > >>  - All above points assume that the ELE-FW and -HW is capable
> > > > >> of
> > talking
> > > > >>    to both world, which is not the case. As we learned NXP
> > > > >> doesn't
> > have
> > > > >>    a fix for the 2-MUs ELE yet and even more important there are
1-
> MU
> > > > >>    ELE-IPs.
> > > >
> > > > For i.MX9x SoC(s) there is at least one dedicated ELE MU(s) for
> > > > each world - Linux(one or more) and OPTEE-OS (one or more), that
> > > > needs to be shared between them.
> > >
> > > Please mention this within your commit message.
> > Accepted & mentioned.
> >
> > >
> > > > As mentioned earlier, there is an issue of using MUs
> > > > simultaneously, from both worlds. Fix is in progress.
> > >
> > > So until now no fix available and i.MX93 based products which do use
> > > a TEE are forced to move the communication into OP-TEE.
> > >
> > > > >> I do see the (minimal) drawback of having +1 FW but I think
> > > > >> this is more an integration problem.
> > > > >> Speaking of FW files, for the new i.MX9* you already have
> > > > >> plenty fo
> > > > >> them: bootloader, TF-A, ele-fw, scu-fw (i.MX95). So your
> > > > >> integation needs to handle multiple firmware files already.
> > > >
> > > > > Sure, but I really like to keep the complexity and therefore the
> > > > > number of FW files as low as possible. I'm not sure what has
> > > > > more weight in terms of
> > > > > security: shipping an additional firmware and therefore
> > > > > increasing the attack surface or maintaining an additional
code-path.
> > > >
> > > > There is no +1 firmware in case of i.MX93.
> > > >
> > > > >>
> > > > >>> Anyway, I see your point of having a single implementation for
> > > > >>> the ELE API in the "right" place. But as far as I know other
> > > > >>> platforms like
> > > > >>> STM32MP1 also implement both ways for the HWRNG, secure
> access
> > > > >>> via OPTEE and non-secure access via kernel directly.
> > > > >>
> > > > >> I'm not a STM32MP1 expert but here you have this setup with the
> > > > >> *-scmi.dtsi. So you have two code paths which needs to be
> > > > >> maintained and tested. Also if one customer of yours want to
> > > > >> use OP-TEE you need the integration anyway, so you (Kontron)
> > > > >> needs to maintain multiple configuration as well. I don't see the
> added value.
> > > > >>
> > > > >> I think for STM32MP1 the *-scmi.dtsi support was added later
> > > > >> because it required a lot effort to support it. This is not the
> > > > >> case for the
> > > > >> i.MX9* series.
> > > >
> > > > > Anyway, thanks for elaborating. Your points are all valid and
> > > > > basically I
> > > > agree. I'm fine with either way. But I'm afraid that implementing
> > > > the ELE API in OP-TEE only will cause another tremendous delay for
> > > > having ELE access in the kernel, especially seeing how slow NXP
> > > > seems to be working on these topics right now.
> > > >
> > > > To use ELE features through Linux, there is no dependency on
OPTEE-OS.
> > >
> > > How exactly do you provide the eFuse write access after the device
> > > was
> > locked
> > > down?
> > As mentioned above by you. It will be done via OPTEE-OS (or may be via
> TFA).
> 
> Why TF-A? Please see my comments above.
> 
> At the moment I don't see why the ELE must be a Linux driver. You could
start
> adding a TEE driver now, because there is no need to wait 3 months for a
ELE-
> FW fix.
> 
> IMHO having a dedicated normal-world driver makes only sense for
> bootlaoders which don't have support for the TEE communication but need
> access to the ELE. This is not the case for the kernel.
> 
> Regards,
>   Marco

------=_NextPart_000_009F_01DC12C1.27802590
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIImZTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
ggEKAoIBAQCsljsxzffby7IAt42e7cJH7K+49RL+7i56h3ORt8dS8WNVSdDlejp6uS6mLk/UX0wn
sSxDK1S5KquGJQzaT/3gxE8tdgvfFNBVdrgr48DeCVwWDr1o/UF3RmGcMdxqRz1M/oLDJ03C8n6h
L/0JXiwsNx0KZJoqDrN/48yX5TkoeKJmHFftZ5Op57xV0WkZJ/yLxSC1Om75jOG/UPdqsDzl+wi7
YVj5egV24hoaXgHBxtCeJzUgsHcJlo9nFtGe11j6H1vqFzkPzN9ydjRmhQATV/WLqpG8uot79u0m
6n7Mjwsd/HmJf+8xpovMcHPO2a0axppssKso/3APP6mR1FuVAgMBAAGjggORMIIDjTAOBgNVHQ8B
Af8EBAMCB4AwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAwGA1UdEwEB/wQCMAAwHQYD
VR0OBBYEFLNr0DCWM1fCXv4ubOt/elkvcoiaMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRw
YW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFua2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAU5TJ6
9GbBR5Ykf/wngDlY3ysX4rswggFKBgNVHR8EggFBMIIBPTCCATmgggE1oIIBMYaByGxkYXA6Ly8v
Q049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1ubGFtc3BraTAwMDQsQ049Q0RQLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2Jp
LERDPW54cCxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNz
PWNSTERpc3RyaWJ1dGlvblBvaW50hjFodHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFAtRW50
ZXJwcmlzZS1DQTQuY3JshjFodHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFAtRW50ZXJwcmlz
ZS1DQTQuY3JsMIIBEAYIKwYBBQUHAQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049
TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2Vydmlj
ZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jQUNl
cnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTA/BggrBgEF
BQcwAoYzaHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFAtRW50ZXJwcmlzZS1DQTQuY2Vy
MDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUuaklY/hMbNXILljX4C
AWQCAT8wJwYJKwYBBAGCNxUKBBowGDAKBggrBgEFBQcDAjAKBggrBgEFBQcDBDANBgkqhkiG9w0B
AQsFAAOCAQEAWS4IrHXWhCGNWk5vn20xV7mlLkM7JPwltVJzB6MRzwUB438upbyUMwNHcEgAmHcs
xL9hafErN+n9rLL00wEqZsCV732s7YOxSRRjZTE3CmZQ2+TYjXR7A6AzQKo0fv/x43bpSes8ttQ6
Qtt8nzIbGBkDAcI7wfXsUPF5o0NwLOxre+Z+JCPNH0eaOj2J7EKD2ERLCClmvohrYdlmu85iXfyi
nJo42eq9g08FtnxTXVQSIZCtiETiGtXA7+t2Aa8429XXunsijRznaYw2SwI/s4sVmvaK3XHaif0D
QaUYxQp4s2ctzgz3eU6hK68OnNzbhBtF/lx6PHbifqHDzrtUbzCCB+8wggbXoAMCAQICEy0ACwRu
JYOozH+yQuYAAQALBG4wDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMzEyMjAwOTIw
NDdaFw0yNTEyMTkwOTIwNDdaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAklOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
ODcxNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL2JT+kRihW1mBdeZFOoCLGIl4DZ
VL7FWt3V1iFFJJe/bZDw/SUf5z1HeA8xv9+S8rqMyybjlSRHFLgiMm7qrGpVEDniKe8eiqP8Un4Y
3fHgK5FKZIVVn0KlaMuD5G30AMk9HyUdc2MkVRL8YSQCewkQDEVjB8gnx/e6xfbWEVHf5+dOWJoR
aket5+0JKV0l/dPV7cT4hL3BFtiBhq8976Li6rn8gxIi63u0G3qvm9Scqk+EHzemDhw/W+eMmGR4
nwKVLKzumxko8l6EOnnvqqF4vj2hKTpB+2lsEXH1giireMEsvB2RY40lnRUXVQ0FDklOIQV4Qdgi
EJfUdq/ZhCUCAwEAAaOCBA4wggQKMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/gbeCPIPthzICAWQCAT4wEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwHQYDVR0OBBYEFMJ81PK4p3H8Q7gn7u/5OwWx
uAwGMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRwYW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFu
a2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAUWJVg7k5072Uiqr3tGakreo4XnQcwggFGBgNV
HR8EggE9MIIBOTCCATWgggExoIIBLYaByGxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENB
JTIwNSxDTj1ubGFtc3BraTAwMDUsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENO
PVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y2VydGlmaWNh
dGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hi9o
dHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybIYvaHR0cDovL3d3
dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmwwggEQBggrBgEFBQcBAQSCAQIw
gf8wgbsGCCsGAQUFBzAChoGubGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENO
PUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0
aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1j
ZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3LnBraS5ueHAuY29t
L2NlcnRzL05YUC1FbnRlcnByaXNlLUNBNS5jZXIwDQYJKoZIhvcNAQELBQADggEBALwIIuww1PaF
EbpQoy5vgJ/4N3xS+niIpFTKyYNAD0Ar38FcUlSnj0FIHKRj8rUmZP9WTky3U8m5B3LOyhJ14FPh
iy1EwkhZmds9fJiZyEEFiwQWYDG/uknu6zIKOTlLmtlYPfbzfi58keGcjD3T5H8D8DpCGWI1lAwe
clR9fJCbcYnQSQnuicSCfrHjjXiDZ2O8h7WbE1CC6Cj/qwo5nmS0lMv7yoG94rTNBvYe8iqOkcav
7KiZA6SdhXms3ppvFmBukI6pTheMvT39SM0S6E0dgeqZSGSxHrM7dcxUdAL4fnYMv3Sa+GAgyXB6
rihWC11+goz2eawt5TRU2w45TmcxggSzMIIErwIBATCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVy
cHJpc2UgQ0EgNDELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5k
aG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJ
kiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhM/AAV1goSs
wyqoLYNbAAUABXWCMAkGBSsOAwIaBQCgggK5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI1MDgyMTExNTkzMVowIwYJKoZIhvcNAQkEMRYEFCINspfD+F7F117Vixnu
bHl8bkebMIGTBgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggq
hkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIaMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMIHfBgkrBgEEAYI3EAQx
gdEwgc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjCB4QYLKoZIhvcNAQkQAgsx
gdGggc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjANBgkqhkiG9w0BAQEFAASC
AQAEDeQkfl2JmX4ikgN2mWY3yM8zpCPHcmGm6sX0MuUi4oh9Z/II5V03abDLHwl1kpxLQ/roI1Hj
3q60fmSJrvSW+v9erwfMVj0lg3vOnS9svSB6G6nSWrKJcVTZQadFGkqWTAUFX8v+v/VhmCeTKuat
2HJ+q9LQrR2u9IF1rOI+94SH3vBWlV6LP6+BYJOTDmnq2MkefyzRFWCTcPF7pnql+AZvzcCOg1/Y
Mf8W24odVIiJNg55QHyRuy8YG3yMVga0j5J9GkAwNzwK/bnFvWfRs6P7u15f/k2dL6nAORgAGHV6
mntOWcDBIph1lyxKopw6IGTOcZIoOllYZPaht7JSAAAAAAAA

------=_NextPart_000_009F_01DC12C1.27802590--

