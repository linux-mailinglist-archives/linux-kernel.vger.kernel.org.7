Return-Path: <linux-kernel+bounces-723300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A16AAFE591
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605F03AE749
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DF828BA96;
	Wed,  9 Jul 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e5FSisza"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013053.outbound.protection.outlook.com [40.107.162.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF8C27E7D9;
	Wed,  9 Jul 2025 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056329; cv=fail; b=NzuqIUOSuXxrC/821u8jzwyu+hDuLODZxQqaR2AZm8iCGQoLEmkJ7Gj+283QrYUo5vrdkWAj6bkzyiqtdQ+ltP00gD1+SyFaLClSBp83yFFR7jBdCkXV8ahluZrXScHlDi0+8LpjZXLqxbfF2zTFVeXqYGBmBSNsYk7/GmKqdt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056329; c=relaxed/simple;
	bh=wjRmBSY+fbchlzeVli05JWVheKIQXGt5lkHOh8V63f8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R30uTm/0uJ0wGC/qgVK1KuX9ppgCo/PX3BC5xyu+rXmIgcPu2MmctoMVzM4/wWwukMDICYUTAO3SIzieutzmgl/r76KTTc0rZfCUQLkrt6zRKLRV9T32aGBSD6am0KRbXoI1Vcjt80Y4LzS2FKR/tqB0dmsHwo4tEwwVlp8kmDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e5FSisza; arc=fail smtp.client-ip=40.107.162.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fw8p0rHqtf5shwf+DSCotMilt+Cg7FHicH7wb8Cr1wDjiLCes6BnR933IZ6JAKzOznxRPt4GMRhwj6I+bWrX6v7gG18kv5LsIHF0bjA4D4UoQ7+OoYvcguHIp4OIfwy1k02a6yruztO0VqpJoPoaMg9ssHXK+2/dtjGBUBB1UUuK/RxS/Ma4pjwAMZLyM1GBygdGKXUxoRdcgnsV6jF2S37+nqn83AWm2OOq+tIdtFs7ShhvJ5i1YWDXfdqoI15OsnA3UevA1C+3dkrfSIEiGgzCHOEet+Mey/J4tNho+Igj/QPeR8lpjtS9wB1pcLXTQUB8Qo/PK7QII9R2VkifDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXwfuzsMWgxyFgDKOo2898VWd/ff+dE02plwSyJp8Qg=;
 b=Y92ebDR4bWTymPMZVyrNV8IlHx0qxpi8r98OdfNu9H2o9QpyOLv3nKOlK0r60uQWfJcO6CnCvxrgNj6koiJBxKj5wqq8NPV1rMamA2RwhDFlDcrnuM22zy9RdwGAJBcgz7JaYZy8Li1zwka6TbufUduv+IMTYQ1EnJBwZEmvalfhuDxXRRA55KIkJk4s+dPk9A+/m72wTx0+YYzA1W962mIuYgMbmr3UaQjxEnLTSIoDxvpXLeqZVj0mFYHC7Y6M3qQkMPPE3cdDwKVFqyTN3UsOjC8Ev79jAvIUAyTC/H2tSjvoWyLPSrLESzFu1s3tljReps/cB06QoarZ5I40Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXwfuzsMWgxyFgDKOo2898VWd/ff+dE02plwSyJp8Qg=;
 b=e5FSiszaKiHxK3MxCACKR00zKDBhbBvjBmozgnh8mCf2a3w6v0RVnN2esATMAQZOw0tMLYDOKfUSrmsZcZzPtT+YjL1xeqaCsB4zwIitRd5oAbRZ7/1Zjx42JDYSsuEzCOfGQ6vtebQLswXEXm8uir2OrzlXucB7EHTtGN8zFB1tUBOX4WpjA/38vrMmNvnwT/pMZ8wWJO9oJ3BSuEes3SYopjdGBnYRE1lOFqpATGAUjm0T032Wm5bQNsItlxnfPE7rZN5+cQRvBZmH2cUzWycF/5nzJgNdseoRK+dkVBaupeE3AooPajy8nGWP2M6Ox6+9opTuX1xOOb7V4fKnmA==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DU0PR04MB9395.eurprd04.prod.outlook.com (2603:10a6:10:35a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 10:18:42 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 10:18:42 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>, Marco Felsch
	<m.felsch@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Frank Li <frank.li@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v18 3/7] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Topic: [EXT] Re: [PATCH v18 3/7] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Index:
 AQHb4RFy2NjRRk9es0SVz8O1dms9rLQTvUUAgALjSvCAAB1dgIAE1IEAgAAdTACAAXh9AIAJZc0Q
Date: Wed, 9 Jul 2025 10:18:42 +0000
Message-ID:
 <AM9PR04MB8604C05882605EDB4913DA089549A@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20250619-imx-se-if-v18-0-c98391ba446d@nxp.com>
 <20250619-imx-se-if-v18-3-c98391ba446d@nxp.com>
 <20250625105546.pxuatcnfpe7mssgs@pengutronix.de>
 <AM9PR04MB8604611B8D91B5526C9704E69545A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250627084653.6vgwnm3llf3zknlp@pengutronix.de>
 <b02055bb-0995-4fd8-99f3-4ca5146eedd4@kontron.de>
 <20250630121722.wviidlggt7hguyt7@pengutronix.de>
 <087b8689-7443-4720-a94c-160edd31a5da@kontron.de>
In-Reply-To: <087b8689-7443-4720-a94c-160edd31a5da@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|DU0PR04MB9395:EE_
x-ms-office365-filtering-correlation-id: 3a2f8509-9466-49e7-544d-08ddbed1fadf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VCvexclJi1GuYd2wnnqtJLe+iKWDPorYf86rHgVr6suPigkTEkaCl9ZAnS0H?=
 =?us-ascii?Q?pe8T9Rr0CO0XLleV/+I4Jg/j3oQjzntDdLgn73EdeaF5g5MUUsbn/f5ggCEI?=
 =?us-ascii?Q?v/zen93ob5c/v8YCBxl1Sqs08DodzivXvzravUZNy7WwahPkUJExJhmaPNa0?=
 =?us-ascii?Q?9pJ8za5OfB0p20zHgm0Kh4Job+3slDGrG0Tme7Ushb86dzlkf/fiFPtRBh8K?=
 =?us-ascii?Q?IFtPRpXBBlmOeV6O+PMyMhZRZkXADj3rReg2vLD/t9eDpaOJCKANizXnrohq?=
 =?us-ascii?Q?CuW+CcMiNCSgVm8B1VNSqjgGLZATLpseyfmlCEK6SkasW/ysv9BglhWeZD7s?=
 =?us-ascii?Q?JT5FbUO6LyQ0KyAg3MbgCOcbw6n5YeBhR69HaZ/IkVDVBNpSr3rv7hx8pdU7?=
 =?us-ascii?Q?aKpkUZ5Wagi0DmTAbvn8Atb+4sdSuEkXgiFM6zoEx5mD0klWYNVyGNx3kpyC?=
 =?us-ascii?Q?gY7vU+qRzMV88XJb3zATObDDOwaFodbtNPJ3IhxRYD+J151nvGeXqMnz/aPO?=
 =?us-ascii?Q?yh5+nCVJnSlpsFnh8LUjewkU6jjJ0ialWaNRRHyqb89yxt9px7Z3n639Nxp/?=
 =?us-ascii?Q?y+3OuMS5vc7UbKyRTgvdklUCto5TpGPjdX+98fbawTFR5RcYqHciGLu92+dN?=
 =?us-ascii?Q?LeJLJmii3Zk21d/0ye/u7N8PVte5aJqYSBuZPUDYmtey+HvL0UXNEQNLD035?=
 =?us-ascii?Q?WzWnjxME4iPZaCM8n9agXTREwGwJIzh3oT0GtXKj6oK4n+qdwo3QXAb4xQYe?=
 =?us-ascii?Q?JwSlafWX/ZU/72sACVT/dVAszQSgWGHgbNB3I/OG+prz4RQ3ZIqAq0Czjxkr?=
 =?us-ascii?Q?kjZmhFiAXqdAg0A08WOjgD+lNZURZn5/IHW185izCgfaP3W8Qt4YVNuWMUd9?=
 =?us-ascii?Q?FJYY92VhpwUJ4RGHKuJ9JWj/gRKem242u0U97ax7UfkX6XsVglZsIRa5dBeg?=
 =?us-ascii?Q?yTeH+tWysgkTWWxApfHZMbbFNC+AMHvpHQxGDQpS3rmrRNzwqvCJtUz04F4E?=
 =?us-ascii?Q?wAttFLd/keVfvwBCo20YJgEQZfmtOa7NkbmVZWzF+oHqnCujwT/DjBRu64UV?=
 =?us-ascii?Q?2nAAfmjzXmuvYaYGvaPvm1pU87KlGVm4yLCfN3iwAsMHvfn/Otg3mB3T8VwM?=
 =?us-ascii?Q?lSJNfitmEHV4+H4QSr5KmLTlEiKbKaqgASY4lFuuPd0T7RbzzExCOgKYXoKY?=
 =?us-ascii?Q?cn0CUJldNeTCjd4qjqyVorhX7ullIb56/RMNXOr2n0y97ONiodd/QbcBxd2x?=
 =?us-ascii?Q?0z3uLZ6x6Tuqy4AlnOxPu4xNvp2aDOcetBxSwf7KdYFp6bvmk1CZLDCmlbB7?=
 =?us-ascii?Q?VLahFHaWCPZ6y1TbPwxvpF8qU7A4LoS+2Z8RtHRMOwC5EE6R/4VaKH/YmIMe?=
 =?us-ascii?Q?AXQ6u0zvnEw4qupo36IdJ/SdDfaSfwGvok7bu4eFYC1Qy3K4LbQELzYPuUe2?=
 =?us-ascii?Q?ZuC2lRA6KivrowH35UeOJrVqQEJc3hB7RIYaSCwkYawHwIRuqvH6yF7sNSeM?=
 =?us-ascii?Q?r4pEtIiC7omFAeU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(4053099003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NJyWEmXSA5+0wj2Wq+mIyvX7rGN9qlKNJ14eElsfa4lYPP7mCe7w+xVc90wR?=
 =?us-ascii?Q?M4ii3wY3XomLRFK9ERpssYnDezfEO9YLy8KbZ+qG+LgsQFo2LaRAho4A6I5M?=
 =?us-ascii?Q?4E6V/S4L2lHEAZGBnoF6yE+3pdukD1D3/u+G/0drWCwUn1dKl70flo1Yqs0f?=
 =?us-ascii?Q?SNQSBIlGBg2S/pmqYoE8JqGUgiAnWk5Jxl6jh5AGQ7yxQHdUIsnn4nscgtUb?=
 =?us-ascii?Q?+k2uObHsLqwqkiikyzMlni+KUUzPvWnbNywnIYzY0isY9LCM5wfWypH1zTFp?=
 =?us-ascii?Q?sWcKhRYQoGBy7IPHxJ7qNmNKDJl4CWXcED53dXBWWkfxst7fzYlsH2UXhRYq?=
 =?us-ascii?Q?wHstNEQ3QfYSAge4n6qhw6imxEKB8oHOp+a/zpFykM1/0aRkXkh8zi9qVPHZ?=
 =?us-ascii?Q?p7CmGZsANx0ov4mD7P37Si2KE4klE2vl5yf9CsHhcduKfD7IWmJbX3ZWezcy?=
 =?us-ascii?Q?G24Zw9hsE/gSiGcRLabskaIhGkmqzRfK5VbqpsmgD00WLx+Jtkc+2W9K8IU6?=
 =?us-ascii?Q?DmXccor+5UlwafyI8duT8tZWEHg0yc+0Uy6CCjiu4YOnxiisjaViAfCaEIH0?=
 =?us-ascii?Q?PPcsUAgKrXQEoulXa9otM0egjfNLAfFI0DhuoleKoStWa33okL/GD+vlZJRf?=
 =?us-ascii?Q?5yKEhbvUSmk8YEVe6O/DPi1/Fk1IJp9HdgggZ6mAew7853sIpeOwpq7y2VCU?=
 =?us-ascii?Q?9oxjExHbCfSs8dlK6JK76e9bvRXZkPW213goGPIp9Bs8GVZ/vQj1dG7SNH7S?=
 =?us-ascii?Q?L6pJRVHYmcxc8gbu0zAAH/OCqUvcksf+n5Ee00AeegK15/cmwQB8JFSe6izk?=
 =?us-ascii?Q?5yc+I55m+59vPHj+q2un3j2/2Lspswxp2kBKj4bV19s3YWwgsoNAZqiDmUCB?=
 =?us-ascii?Q?nW1/8PdyUjF1GEkcjc2STKKZN4wBgmvaL9zySTr0UwJ4OE4gk/X7QNvFi/KI?=
 =?us-ascii?Q?BXAa0gHQ75OnifMEDpinDbAkTusaUahR0gyRhQca0hRS+YS5Iu7I73Aeh/Uy?=
 =?us-ascii?Q?nfcJIqIBMH1fHeInXs2AIlBlSvBYkYVjC5oT3Hwq1nuKoB2v5L2oZybcOXZu?=
 =?us-ascii?Q?4uHdDKjsXGSVix4yq0xaY8DrO8lM4kU7RON/nstaYNekUkZ6TlT2iYM36UaC?=
 =?us-ascii?Q?iI1EKEE2ZzBq4/7xrMbUnGWPMkkUm+9RQehwlE6tGNHpXBIi//P7F2oizTKa?=
 =?us-ascii?Q?Jb9qKSUPmduebrLkpxnAfx6ekv3S06nyPjhGUVNwAhkDDpgKlL1wQIJw052h?=
 =?us-ascii?Q?EXGyEVl+9fqY5oOxJrnU2ToQPeUv79Yu3KIWXwLDaoI7yxEhDj3PIozqd5uT?=
 =?us-ascii?Q?phXA2VttoZbYiPiNPpWeFB0lk5N+kcFFcxycUEiZIklB2qx43Teh0+wD+76b?=
 =?us-ascii?Q?IJDaAPZlb35CpShAxqCU01NCLcYFroRmsqgIwRAhCzPx76bpvIS8p8QHurJZ?=
 =?us-ascii?Q?IkkL7qnaBWci4bpvvrRVnUOw+yVL1qblmkVq+8GwFzE8yPNvaXYTmbif+xag?=
 =?us-ascii?Q?DnEKPMnI5OoGZG1E5Clt/x+ji6sxFJtMKqFl2j5XBLg0/2YxbO62UbIXAiPH?=
 =?us-ascii?Q?cGaPQ6eZAkC5e/z9cYKq0mox7w89+yAsSY0W54Vs?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_00BA_01DBF0E8.F0405B30"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2f8509-9466-49e7-544d-08ddbed1fadf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 10:18:42.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IHyv6CkflngnYPGWAPrOwh7c5nGpmZdG8r5bCF6t7uIsPrDmlOOr9HiRnvIrrywZu1dRpF3FxfFrjWV5IQP/Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9395

------=_NextPart_000_00BA_01DBF0E8.F0405B30
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Am 30.06.25 um 14:17 schrieb Marco Felsch:
>> Hi Frieder,
>>
>> On 25-06-30, Frieder Schrempf wrote:
>>> Hi Marco,
>>>
>>> Am 27.06.25 um 10:46 schrieb Marco Felsch:
>>>> Hi,
>>>>
>>>> your e-mail configuration mixed my e-mail with your answer, which 
>>>> makes it hard to read. Can you please check the quoting next time :)
>>>>
>>>> On 25-06-27, Pankaj Gupta wrote:
>>>>>>> Add driver for enabling MU based communication interface to
>>>>> secure-enclave.
>>>>>>
>>>>>>> NXP hardware IP(s) for secure-enclaves like Edgelock 
>>>>>>> Enclave(ELE), are embedded in the SoC to support the features 
>>>>>>> like HSM, SHE & V2X, using message based communication interface.
>>>>>>>
>>>>>>> The secure enclave FW communicates with Linux over single or 
>>>>>>> multiple dedicated messaging unit(MU) based interface(s).
>>>>>>> Exists on i.MX SoC(s) like i.MX8ULP, i.MX93, i.MX95 etc.
>>>>>
>>>>>> You write single or multiple MUs are possible. I'm aware that the 
>>>>>> i.MX93 has two MUs one for the secure and one for the non-secure 
>>>>>> world. But I'm really concerned about the fact that both MUs can't 
>>>>>> be used at the same time from both world:
>>>>>
>>>>> Yes, you are correct.
>>>>>
>>>>> Fix is still work in progress.
>>>>
.>>> So after ~6 months no fix is available :(
>>>>
>>>>>> Also how is the secure and non-secure world talking to the ELE if 
>>>>>> there is only one MU as you have written?
>>>>>
>>>>> Till the fix is WIP, either Linux or OPTEE can use the ELE, at one 
>>>>> point in time.
>>>>
>>>> That has nothing to do with the fix. The fix is for platforms/SoCs 
>>>> which do have 2-MUs, but you also have written that there are 
>>>> platforms with only 1-MU.
>>>>
>>>> This MU can't be shared between secure and non-secure world.
>>>>
>>>>>> IMHO it makes much more sense to put the complete ELE 
>>>>>> communication into (OP-)TEE and let the secure OS taking care of 
>>>>>> it. All non-secure world requests are passed via (OP-)TEE to the ELE.
This involves:
>>>>>> - eFuse access (done via OP-TEE i.MX specific PTA)
>>>>>> - ELE 23h59m ping (kernel SMC WDG driver, requires OP-TEE watchdog 
>>>>>> driver)
>>>>>> - HW-RNG (kernel OP-TEE HWRNG driver + OP-TEE HWRNG PTA)
>>>>>
>>>>> There is a dedicated MU "trusted-MU" for OPTEE-OS. The idea to 
>>>>> converge to a
>>>>
>>>> Yes for systems with 2-MUs there is a "trusted-MU" and a 
>>>> "non-trusted-MU". As of now, there is no fix available for using 
>>>> both MUs at the same time. Furhtermore there are platforms/SoCs with 
>>>> only 1-MU, as you have written in your commit message. This 1-MU 
>>>> system can have the MU either trusted or non-trusted.
>>>>
>>>>> single path via OPTEE-OS, is good. But it will impact the 
>>>>> performance of the features at Linux side.
>>>>
>>>> Performance? We are talking about a ping every 23h59m (I still don't 
>>>> know if this is a feature or bug), eFuse write/read, and the HW-RNG 
>>>> which can seed the Linux PRNG.
>>>>
>>>>> Since the fix is still WIP. Let's wait till then.
>>>>
>>>> The fix is for the 2-MUs SoCs but not the 1-MU case.
>>>>
>>>> I would like to have a system design which doesn't differ too much 
>>>> between SoCs which are equipped with the ELE engine.
>>>
>>> Do we really want to depend on OP-TEE to be available for having 
>>> things like OTP fuse access and HWRNG? Personally I'd like to be able 
>>> to build systems with OTP access and HWRNG but without OP-TEE. 
>>> Requiring OP-TEE only to make the ELE available to the kernel in 
>>> cases where the secure world isn't used for anything else seems to be
unnecessarily complex.
>>
>> I understand your point. I don't like pulling in more FW neither but 
>> we need to the face the following facts:
>>
>>  - OTP eFuse R/W access after doing the LOCK_DOWN fuse is no longer
>>    possible without OP-TEE. This involves general purpose (GP) eFuses
>>    too. We faced this limitation in a current project.

> Ok, interesting. Where do find information about the LOCK_DOWN fuse? I
don't see it mentioned in the (Security) Reference Manual of the i.MX93.

From i.MX9x & onwards, SoC(s) has at least one dedicated ELE MU(s) for each
world - Linux(one or more) and OPTEE-OS (one or more).
As mentioned earlier, the fix for the issue of using OPTEE-OS dedicated MU
on i.MX93, is identified & under testing.

Other point on whether OTP effuse are R/W access, after LOCK_DOWN fuse?
Not sure about how "doing the LOCK_DOWN fuse"?
Please elaborate more on this.

>>
>>  - With new regulations like the EU CRA I think we need some sort of
>>    secure-enclave anyway.

> Probably some sort of, yes. But not necessarily in the form of TEE or
TrustZone, I guess.
To use ELE features through Linux, there is no dependency on OPTEE-OS.

>>
>>  - Making it optional cause more paths of potential errors e.g. by not
>>    including the correct "secure.dtsi". Multiple paths also require more
>>    maintain- and testing effort. IMHO I do think that one of the paths
>>    get unmaintened at some point but we would need to keep it for
>>    backward compatibility.
>>
>>    Having one implementation eliminates this since.
>>
>>  - All above points assume that the ELE-FW and -HW is capable of talking
>>    to both world, which is not the case. As we learned NXP doesn't have
>>    a fix for the 2-MUs ELE yet and even more important there are 1-MU
>>    ELE-IPs.
For i.MX9x SoC(s) there is at least one dedicated ELE MU(s) for each world -
Linux(one or more) and OPTEE-OS (one or more), that needs to be shared
between them.
As mentioned earlier, there is an issue of using MUs simultaneously, from
both worlds. Fix is in progress.

>>
>> I do see the (minimal) drawback of having +1 FW but I think this is 
>> more an integration problem.
>> Speaking of FW files, for the new i.MX9* you already have plenty fo
>> them: bootloader, TF-A, ele-fw, scu-fw (i.MX95). So your integation 
>> needs to handle multiple firmware files already.

> Sure, but I really like to keep the complexity and therefore the number of
FW files as low as possible. I'm not sure what has more weight in terms of
security: shipping an additional firmware and therefore increasing the
attack surface or maintaining an additional code-path.

There is no +1 firmware in case of i.MX93.

>>
>>> Anyway, I see your point of having a single implementation for the 
>>> ELE API in the "right" place. But as far as I know other platforms 
>>> like
>>> STM32MP1 also implement both ways for the HWRNG, secure access via 
>>> OPTEE and non-secure access via kernel directly.
>>
>> I'm not a STM32MP1 expert but here you have this setup with the 
>> *-scmi.dtsi. So you have two code paths which needs to be maintained 
>> and tested. Also if one customer of yours want to use OP-TEE you need 
>> the integration anyway, so you (Kontron) needs to maintain multiple 
>> configuration as well. I don't see the added value.
>>
>> I think for STM32MP1 the *-scmi.dtsi support was added later because 
>> it required a lot effort to support it. This is not the case for the 
>> i.MX9* series.

> Anyway, thanks for elaborating. Your points are all valid and basically I
agree. I'm fine with either way. But I'm afraid that implementing the ELE
API in OP-TEE only will cause another tremendous delay for having ELE access
in the kernel, especially seeing how slow NXP seems to be working on these
topics right now.

To use ELE features through Linux, there is no dependency on OPTEE-OS.

------=_NextPart_000_00BA_01DBF0E8.F0405B30
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
KoZIhvcNAQkFMQ8XDTI1MDcwOTEwMTgzOVowIwYJKoZIhvcNAQkEMRYEFO3YVkMiPxezwarzrWEY
P56N/w3VMIGTBgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggq
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
AQCFj1We/WmpUtnMhtztI3TLbox3C7K35pn0u492rs3n0z2Wg4YB+1liF7zSyUCyjmULPzobg3wZ
JrP2FG7jG0GT/CX5RIL8rLryJRgC3Nv46MaRtHruihYAYMJZF/P62cX0Rzpv9o71dahXpYhRq3YP
3fo04TbJyDTKUVp/o18V3DAWhvjAVlIKN2rfnEVqi9ra0IjzUh9kxW5WOAUye8/UtLP7U4j6C/3A
o5+t2VtGsgbAQdACsqc0CwdGJGfBLaL0KMj/3z9wgTIKSQCRwMuRjDJCkF0KpeQutRR6BnCRwiun
7rO/U5oP040zXPnrvwMIw1tZqTMOnjzVnbu8Mj+dAAAAAAAA

------=_NextPart_000_00BA_01DBF0E8.F0405B30--

