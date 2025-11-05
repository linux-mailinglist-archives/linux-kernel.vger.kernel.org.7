Return-Path: <linux-kernel+bounces-885896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE12AC3432C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C0E18C2352
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902172D46B3;
	Wed,  5 Nov 2025 07:18:04 +0000 (UTC)
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021076.outbound.protection.outlook.com [40.107.51.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384582D373F;
	Wed,  5 Nov 2025 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327083; cv=fail; b=daSZ2te7rc/HbzxqCOY/wO/anJg15e9PgDF/p4nASyjfUaJ32mzldGY+R313XckFSkVSj/fgp/PcXnrBGD6PPgIR4m3Es/eYk1YepTffVsf76wyd8IvgsRY/YFdB5vARBeofOzVWM8Z1CV0OzT+GA2dTuTJjqjMAwV29C3WAOhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327083; c=relaxed/simple;
	bh=TTeTCT5zplptHrpKyD9Ubz35TbpQz362q+w+twa8Ewg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RCldTo3QwD0FHorwGvNIycCks3LV/6fxkr4fvF+Kp8sKGwDP0IUhovF7ljbuav+c8HebYcTbfY7fBwfB+cuWC6pKpXg81Oq6MtWJIhaKwb4z+XVDwO5ur2AHEsuR38mMXtPadXC3xjk9j921Ov66poKaqaOZZB47eUCcUtqb/6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=fail smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.51.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cns55wJJiuvPgogSXokdxrzRxGEHoCZcA87txDxSu7BpnvmDy7dk4gwTd0TQU7phIihILIZhYj7OpMe2FZcIT8VQvjaIiKhJXL1pG0Zq3tK6T25Tjqh4hS3nqzelfGpt9rHkQW8bucQkAoEfdmE/wPc3YXSs+65R/OpDGm9WqV3GfsiThRZMelESHlU1fRuX73wSohNoDd9GLPwfgMq1CLzhqtxD69W+0G7sTmzvG/oZY5FMbq+30tjue2+Mm7MJeJOCMykSZ+Kc0vzSeq++iQ2FxMnj+5XNvFRisMyPSPWcH+LAAJS7N/cyRJE0oQRRp8kgWiQ57O+xB7wha9wnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTeTCT5zplptHrpKyD9Ubz35TbpQz362q+w+twa8Ewg=;
 b=UfCI9NC4f23PuHj6hrwhcE0Z5JprGCwRRJxY8X9udggtjEx1aOfymXaMVjKGYlnrmemFd6HIF+ZMei9Mfk9wwUtez4zfppbWKLMANYVYs5uaLe+i8Zzyct+MRDyDdJOUCK80iDJDyP48kQRmlhZnOzpno+R2uC33Uc+WbKMxTPyVjR7YXPx0cll+YQv5IkKNDfPLwAoB0FBPPgFihBeEDq5wWZDK6nvOWrCUUpmbYL21qWjKemLoAZY8YJsNCIyL37VIARB7ONjcRN2Bud3CJSm3igJroNf/xyfhgjSSfIlsye75Eu8x76auWx73OFLOuqWfhq93ZsajIJyfSs57XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PNYP287MB4880.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:2cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 07:17:55 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%4]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 07:17:55 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Sakari Ailus <sakari.ailus@linux.intel.com>, Matthias Fend
	<matthias.fend@emfend.at>, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, Hans de
 Goede <hansg@kernel.org>, Ricardo Ribalda <ribalda@chromium.org>,
	=?iso-8859-1?Q?Andr=E9_Apitzsch?= <git@apitzsch.eu>, Benjamin Mugnier
	<benjamin.mugnier@foss.st.com>, Sylvain Petinot
	<sylvain.petinot@foss.st.com>, Dongcheng Yan <dongcheng.yan@intel.com>, Bryan
 O'Donoghue <bryan.odonoghue@linaro.org>, Alan Stern
	<stern@rowland.harvard.edu>, Jingjing Xiong <jingjing.xiong@intel.com>,
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>, Mehdi Djait
	<mehdi.djait@linux.intel.com>, Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Hardevsinh Palaniya
	<hardevsinh.palaniya@siliconsignals.io>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hao Yao <hao.yao@intel.com>,
	"bsp-development.geo@leica-geosystems.com"
	<bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH v5 2/2] media: i2c: add Himax HM1246 image sensor driver
Thread-Topic: [PATCH v5 2/2] media: i2c: add Himax HM1246 image sensor driver
Thread-Index: AQHcTXZGkaTUWYVfoUuLvk/SGYhvbbTigwEAgAENHYSAABUOgIAAB8fo
Date: Wed, 5 Nov 2025 07:17:55 +0000
Message-ID:
 <PN3P287MB182992E316928B9D72D8F9B78BC5A@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20251104-hm1246-v5-0-97c8f25b5419@emfend.at>
 <20251104-hm1246-v5-2-97c8f25b5419@emfend.at>
 <aQn_lguAdP-ZwCzK@smile.fi.intel.com>
 <PN3P287MB182902DE83B03F13D23CE9578BC5A@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
 <aQry_1Q9-QsSnNa4@smile.fi.intel.com>
In-Reply-To: <aQry_1Q9-QsSnNa4@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|PNYP287MB4880:EE_
x-ms-office365-filtering-correlation-id: 2c201845-6cfe-46c9-8aef-08de1c3b70ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?2tpdQIAXrqnHmRzjtTx6Pl3oJJf79vUsmSLnf93f0WtlytuJslrjNpT+wy?=
 =?iso-8859-1?Q?CHKWaSdBI8OkakaxXALTtlfwJ6GoXwlldZQ3XQLlFJ7UJ1gfMblfIWP8Vk?=
 =?iso-8859-1?Q?bW6rqGK0y9ri734PwwrEfCNAc0bD8OL+9kdeNB4Yub2OxkEHDTAen/bv8H?=
 =?iso-8859-1?Q?nchXvlxP8WfM7zJztKvegSJYaMGwzNOJPEyURb51LKVanFxJP8gJo/LnYP?=
 =?iso-8859-1?Q?XqQGS0+JKS2petIBDYLFX43XOGe73PNi58NZrAQJ+Fd0dtJqc1Sawkehcl?=
 =?iso-8859-1?Q?jmsE1Sp7Hr0RDTAMYlxTKr1anoTsfP1dd5s25VdkLslayefFY3zbLVHhRL?=
 =?iso-8859-1?Q?KbWEupjeKdqeoebmk1YE+V5uOMyZqsncl4mGonyu81Og5kUk+NPnVgk+fT?=
 =?iso-8859-1?Q?YDxh7eicXPyKDv35/UFgg4R4yrG+Txxv37bczQJAQ741D2hNWgGEu1I/BS?=
 =?iso-8859-1?Q?Bu1Obi6QybOxM/WVADjec9gXSUkaE+vRfGzz/WjiR9OoaIfBolocBN5rPD?=
 =?iso-8859-1?Q?f9GTOC5BLW0XLYPtTUc+SKxMIWFoSRUe0bBikkQPtocSFSrXWA5DbJsV8R?=
 =?iso-8859-1?Q?f1t71tI5e5WH6Eo3Xjq6xFRlVJ/Loz8x5kNFkYDWIHylAZdTCNHYF7ggup?=
 =?iso-8859-1?Q?cOR8jMjiJJqA/80UvLc69+vB55DUGp+xDXgQVywGGVyDE+/W9KGr9ZZ0/y?=
 =?iso-8859-1?Q?4jX0RPngWs1eA9lqwDje/OikgmlJTP0HxD24kp6ItX6GQEpU6/KK3IjpiC?=
 =?iso-8859-1?Q?DG5wEXbeaJl6GJN0d5NdmnR31ErJK2zJD+dj0ZoudKLeARS/q0aiAIb+L9?=
 =?iso-8859-1?Q?pyQHNTpyZw05o2x/W0g2Zi5kGdVXb8hRMnn9hOn3nXOXxttIlku+2Bey/E?=
 =?iso-8859-1?Q?tjOSPf2h3iOt4Z9HgVLJMzqX6p3KBnV+UTz/ST+mgYyF1x4ZY8Dug6VhgR?=
 =?iso-8859-1?Q?ztpfz8/XE4ngxHCk7AeFShzcJCk05DFfo6XqzvUKhLoHos6Oo9B0+CHmp3?=
 =?iso-8859-1?Q?eRWdlEzcATqWchk10jlgVEk0rZhOfRpI4NA+L0/JjTn2EzNRjtSvuh6yyf?=
 =?iso-8859-1?Q?hA8F+9OSOe0uyGFHDjW3S2HuoSRVBrH4jBBi3KvMf1vPRS8lTEYNR7HEp/?=
 =?iso-8859-1?Q?O89II+Xbt22+ZGW1DMqlzexFuSn/8Bc+8QPNEMCan2UtGzwzcCPCqHoX3N?=
 =?iso-8859-1?Q?Yw2K32lYyHGo7zUUW4Al+iUOEj19Q3OMExxqTmHdb8fB5Sp/fbHPCmHbKI?=
 =?iso-8859-1?Q?+XAYaSvsu+gwg5i9xQ42bvFp+oFH5k7kYJlaLrW5zfI2t0TOtad6e2ajjx?=
 =?iso-8859-1?Q?DsJRICjgT2MuF5XqqIOUpOXyWKqDddjlOhFHP348IUIsnXff9ObAdonz00?=
 =?iso-8859-1?Q?7UpsRqk1YOBfbdmVP4/bjJWGC+3I4rX918E5reca/7hPCt0x1t0cmfbcs/?=
 =?iso-8859-1?Q?WI7d165Zd4koOArAGD57lf/3vFWOONGL9O97aPqIv5c5SaU5UR6RQ8FgMz?=
 =?iso-8859-1?Q?CYJIB4/plhD+4TT+KY/mMkVKYiQHD1oEOmyfPdYFe89CyP5VwyI2r/ECCq?=
 =?iso-8859-1?Q?sran+HHFYhy2rjUPjGi23klCi92b?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3FcAVDpQrVC3DjHQcSybAF7GxTGsHk4EsnGl8pKSwBi+o9WeFLtqbrLwEm?=
 =?iso-8859-1?Q?tQ5bOpbtfbCpes10it+SRmaPyermYgA87g7jWLRZ0kEP3E4hTAfGUuHAXt?=
 =?iso-8859-1?Q?a1AkfVh1G4dK9zt84rM2FMrG8OvSW8KDpx+91KLtahDZlxpqRB91cjyRj7?=
 =?iso-8859-1?Q?dVKvzi8Q1QvJpbCUA1b6dW8HVvIEeMUFWZr/dVHGr3UBnKmNju2LUNoKzL?=
 =?iso-8859-1?Q?j9kdDo/8TBIw4L4O2WWpWjh88VqB/1/GCvmSajMMba3LCSHrC80JmxFhAr?=
 =?iso-8859-1?Q?YDUnNTqYLafy9/HhcgPZBXIbNyvYZEIM+8er6PScj5VC7QpGc15mNT28I0?=
 =?iso-8859-1?Q?Ptcbs2w760gBxboKaWa2e8KYMk1sc7BTCzXpO3RdSy39fcLz8RvuOu5097?=
 =?iso-8859-1?Q?gbVj+HKe2vl/mjLtpS288g6zId4JXx4Vvd++jEva1d/NHvdFiCk+yI6Yxs?=
 =?iso-8859-1?Q?NDGmfc5W0VEDzdYOMyINDeolqKAhqfUUVVCgX487Af0o+vNvVn5LAFN5MO?=
 =?iso-8859-1?Q?2cYawm7FqE/xqiYwuCOaSTysw24R2fYwnVN5yMZeMKZtJuTtgvdfv3WaI7?=
 =?iso-8859-1?Q?LcDGJU9V92BeXbUfCQSlH1YcOaQ8yyBD64TnuxGJmm/a1gMPegahBMOS0P?=
 =?iso-8859-1?Q?UZv2sMlK+puoXpQM/3cWmiyhkW2YUI4GrNj7HXf2klW5+jSb3UK//AdbHs?=
 =?iso-8859-1?Q?R/mNYPW9UXPeP7NxaSr/bTmo+GMRr9OfacM7O35kSLe9H/SlVVxz60jMmJ?=
 =?iso-8859-1?Q?Onj9GcdlsMVZ91UaCGPzD4xdMd8cXdovGele2cI898MS9kV6rzUwgma9ZU?=
 =?iso-8859-1?Q?Aor79QnEj3Ki3nt9pZoAO6dKyaS5vZPLzvznhA94Cv543zI6Rw3Hpxt2fL?=
 =?iso-8859-1?Q?t1ia2/jf3ppbBq7QiLnNEomCR0xnRtfVbgUaNWFKiF2xwfFC8cRdUKZlzw?=
 =?iso-8859-1?Q?F+BdyYQEYhqAnFSiLE7uwI0st624TkIpqM8A0NnJ3GEzlLaGBAmQv95Iai?=
 =?iso-8859-1?Q?KZDVgYq0FbcHWeDgGbMTNtXE6exWCn6kAo1QUjsMip6WxaGQt5qOzWl18h?=
 =?iso-8859-1?Q?GxFsXres9Mh32reox4zLvvs6RipHMw4nFVhvSISnelxMHLq7V5HPcMF10v?=
 =?iso-8859-1?Q?bP907qOvBlLuQr2qB9E7kNU//k8Lx8up9r9s6i/qj/CRfKizeeqFXnonpj?=
 =?iso-8859-1?Q?PWm7Ovbk0LP4KdsKLOBOca6J1i+e5689dcRF4Hd3rWVeW0/aicI8PXYM3e?=
 =?iso-8859-1?Q?8d2keSZnHA9XeXZh4pdLgkZ/C4Sa5cfNzCvVkr8Kec8McKgRmTTwZRCCHT?=
 =?iso-8859-1?Q?JyD/AizVBLxbPMbmjzHadkLQTdWiqLROjnj9YEkDnEMRD4RUvZOmH9+see?=
 =?iso-8859-1?Q?Mf4DegCUKftrq3QtiVmiJljtjTz2oBx8ngebo28htcd8KF93zTqfsTpBmA?=
 =?iso-8859-1?Q?C16mW3On4+hF794ppYnmjjYMVU6VBVP99W8e7P1rmlcab+tJPG3kGYIGrn?=
 =?iso-8859-1?Q?lGT9aU8CRYlPwe73ia15XwKyH3xr2ZaneZ/VrDqr58kLguC02jt7Yky2hE?=
 =?iso-8859-1?Q?Ize8jQh/NJSWl9JZ/c4t3L3B75iVX8/zeMU0VfR7fTHrYWF4oyJ3VjAUw4?=
 =?iso-8859-1?Q?tMHzpGao7/xqMfsorMFNvLaVEXnGr19HOh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c201845-6cfe-46c9-8aef-08de1c3b70ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 07:17:55.1971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxPgGi0F7oZXhFhVpufYV/7IKf9cYDGcOqpyk4jRK3YTOaSJybgiiEZgUEqnoDVFivcIWUL2Ij6kTNmYiG4p67f1aBWaFRrOJcdSIO+0EqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYP287MB4880

Hi Andy,=0A=
=0A=
> > > > +static inline struct hm1246 *to_hm1246(struct v4l2_subdev *sd)=0A=
>=0A=
> > > > +=A0=A0=A0=A0 return container_of_const(sd, struct hm1246, sd);=0A=
> > >=0A=
> > > It's unclear and confusing that _const() variant is used here.=0A=
> > > Either const qualifier is missed somewhere, or _const is redundant.=
=0A=
> >=0A=
> > The use of container_of_const() here is intentional and follows the dir=
ection=0A=
> > taken across multiple recent sensor drivers suggested by Sakari.=0A=
> > (e.g. ov2735, vd56g3, vd55g1, ov64a40, imx283).=0A=
> >=0A=
> > AFAIK, using container_of_const() is a no-op for non-const=0A=
> > arguments,=0A=
>=0A=
> I believe you want to say that it has no additional effect on the result =
or so.=0A=
> Because it may not be a no-op, otherwise code won't work as expected.=0A=
=0A=
Yes, that's what I meant.=0A=
=0A=
Best Regards,=0A=
Tarang=0A=
=0A=

