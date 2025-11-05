Return-Path: <linux-kernel+bounces-885837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EADC3402F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 06:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2C0422DE1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 05:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5C8280331;
	Wed,  5 Nov 2025 05:53:37 +0000 (UTC)
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020134.outbound.protection.outlook.com [52.101.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE827F017;
	Wed,  5 Nov 2025 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762322016; cv=fail; b=qA+7T6jdNEL6IOvDI/S79OzEL+3soVUeEmDhI0t33CWj/GvYz+TjPmkJtyx6n0Od/xlHi2IAhXVSQwZTIEMWg4U6hGHF+NupxA0KSHVGQgieEeXjxMWa+7Ws+CYcjcMu5qO6wzNIU/EDebSfrLe7PzU+sKe0hGclO9iqDoiLawE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762322016; c=relaxed/simple;
	bh=i5IxIGZnTcfqvkNSYLQaC+61+eKpi9FU7j1zfWXXfmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pwurvbgOnffHhDZPdHH5fknVlErK4MwSajglNuS5YHqkRU8tZ5bfalxy9dNE4hzxnCbOpoCib+WxPIGxEvadkOhjoKQu4kTxlCF74UqZYyVwuIcCfvi9CheFvqcoMF4eQDrfUeceDGbHzqJhMqQEGCoVk7KKhiBjFzOdGDUOyz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=fail smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjiMfLQWb/Q00oqvPLYPResEdjRkeK6ZJ2IhXabJa+lx4qSxjIhSQWCvWuE07mbFn8UN+TT8uK/OOriODXaFXsQDxUQ3pIyZEOM5dvkCZsPqVXrvL52Exs9PCRCsd+bOWb07uYbGqphJdQgpUqv2fThr6GpYatNX9y7tivqwqisMeMIaM59FCL64StXheys0kPTzll3U99ij9/qQZ2xupV2nWnNHbHC3LNtNccJv+EPyPgkBPQ4ObdcARljjTc266xhXdNbX3Fw5cbZY6lwXmC/WzDH3Y+44BPEnky7zy0h1N1Zs73WVgScOU16ziTgDJBMH89xFxBmB18lFZm/3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5IxIGZnTcfqvkNSYLQaC+61+eKpi9FU7j1zfWXXfmw=;
 b=Nf4bLXFHOmVMbpPKc3/5VxgWQ0wYbVXuhULVCVjrOd/HlAkDwehGXid+DEhFpQoToiHxop5yOYKHd3jbMoA6casIA/s+sY4BkGosFQU6nB7svajsA/M0xceBXyE8TFsWV5sHjOrCBh660dtkXtvr0jSJXsNBREkUhZQNQeRjqObzOXAejv9Xr7BzEW7ter9HafasMyp0FGDrE7nSAzwUPfbl1bEdDBLvewoK8tvhNt4DYV+eYeUKfUIWA81KrVagTOGyYc2ozjBBy+GQEEZUN6udpo8tGb7qhpV8BJAgvVYf5f1ObppDLoggSHx0aruYKeoecSwsiC0WM0QIclW3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by MA5P287MB4534.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:193::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 05:53:31 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%4]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 05:53:31 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, Matthias Fend <matthias.fend@emfend.at>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>, Hans de Goede <hansg@kernel.org>, Ricardo
 Ribalda <ribalda@chromium.org>, =?iso-8859-1?Q?Andr=E9_Apitzsch?=
	<git@apitzsch.eu>, Benjamin Mugnier <benjamin.mugnier@foss.st.com>, Sylvain
 Petinot <sylvain.petinot@foss.st.com>, Dongcheng Yan
	<dongcheng.yan@intel.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Alan Stern <stern@rowland.harvard.edu>, Jingjing Xiong
	<jingjing.xiong@intel.com>, Heimir Thor Sverrisson
	<heimir.sverrisson@gmail.com>, Mehdi Djait <mehdi.djait@linux.intel.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Hardevsinh Palaniya
	<hardevsinh.palaniya@siliconsignals.io>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hao Yao <hao.yao@intel.com>,
	"bsp-development.geo@leica-geosystems.com"
	<bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH v5 2/2] media: i2c: add Himax HM1246 image sensor driver
Thread-Topic: [PATCH v5 2/2] media: i2c: add Himax HM1246 image sensor driver
Thread-Index: AQHcTXZGkaTUWYVfoUuLvk/SGYhvbbTigwEAgAENHYQ=
Date: Wed, 5 Nov 2025 05:53:30 +0000
Message-ID:
 <PN3P287MB182902DE83B03F13D23CE9578BC5A@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20251104-hm1246-v5-0-97c8f25b5419@emfend.at>
 <20251104-hm1246-v5-2-97c8f25b5419@emfend.at>
 <aQn_lguAdP-ZwCzK@smile.fi.intel.com>
In-Reply-To: <aQn_lguAdP-ZwCzK@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|MA5P287MB4534:EE_
x-ms-office365-filtering-correlation-id: e0457cac-6fef-44e4-2a02-08de1c2fa62f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DCUwyHsJljwjBQMPb3GLeSxKuc7SxvRxtMg8l5UdKEvd67ab96teC9gBTx?=
 =?iso-8859-1?Q?+CsaaXNweUCC3J99uxTstbn0bCbp7M6qFGGUUX3okrcxvGvootVAiWZhe0?=
 =?iso-8859-1?Q?9IhyMqihTuaPmySqv7FukG639hyWeaIMX2JAeYQEtDy/YaDzH2i40zEmUP?=
 =?iso-8859-1?Q?IJczjQWtuS4crb13oN7NqzMsPFVv2aaVOrUXtYvJcsWSSp3LRDJUpxZ30H?=
 =?iso-8859-1?Q?kuYXKOPj0mJOVv+G8guHoutPbUIebhtkOMLQ+NVxEy6XdEt6Lw4Ogy9fmB?=
 =?iso-8859-1?Q?+qldqCL5+ERkfseO0hgm+QtyNznBSYR7e9WnVoAVk10n+tyYu5+P8ear+b?=
 =?iso-8859-1?Q?C/cv5qjxUe7XVbNreVIZdVVOiO6AKRfpX06RS6Ky8SMGXJOJAIRfsd9S1p?=
 =?iso-8859-1?Q?Y5QYbWLEgXyDcqfVH7GOMUvg9H2N8N136Mm6FQTCAJizSFiHhN/u3p2Sik?=
 =?iso-8859-1?Q?0bVWiN/EcRL0a4uM262ZF+Xpj4vPUc+N7e/ajiuYmEZYChESCx5AU/52lz?=
 =?iso-8859-1?Q?7T1+hsjFfYDyZAbzgE+GPB4f748Wnl6Nkug+9AwJpdYyWIKjHgRNFNuveT?=
 =?iso-8859-1?Q?wkSDe1V/dtkKd4rFk5I4eWXqb5IifIQ5aa/z3CO4cslgau4gsUYKAGjoDU?=
 =?iso-8859-1?Q?WmmWY7zoz4QSxhNRtJ3i10g8n8nxOJ7qNO6y2ZwHBYCUA8SeemTUes3fdz?=
 =?iso-8859-1?Q?zAnmNxSmgCPhf+okt76CgAQBEEpCisNk3sKWrO22HEgbsfewr0SrPro+R1?=
 =?iso-8859-1?Q?ptmv8+6TgRTX1KdmkmLAfV8zmByyP+h+/oHB4bdGhWjgbMdAxxWS9WZdaf?=
 =?iso-8859-1?Q?+jysTzaUfGtipq71zLWZjBYUJcG1BuA415xjPPr4hk+HQNju5Kpd3r1prX?=
 =?iso-8859-1?Q?mtvV7J3Kev49A4v3Ho65cN3W6eZ6+pvFeyFL9/QKdULtVAi4cIQx99BdBi?=
 =?iso-8859-1?Q?HGIRp+2D59I0/R8XA1teGC0BvNXpVPSD4UExhB9iiakGtfyTK6x775WGsv?=
 =?iso-8859-1?Q?2377v4yKT1c53l8Q42GRtaaXhyvTVlasVyMmEdalL7M7rbqcybzOyMyezF?=
 =?iso-8859-1?Q?TTpUb9Y2xvuGAkXDX+2ZtFY6jdVDCSemNgLkjUZn0kB1KV9CYIbV94FgYz?=
 =?iso-8859-1?Q?X/tgpCi6DaIWOAbz0J3ZkFdaqKRG9sEqEhZnO2v+FjQOqixr9xtxSkqApR?=
 =?iso-8859-1?Q?+PoG/xUiV4do5fxdF6xQLr9y8K/7Cnmztf5p++JB+tmIuWv4SO1b5R7F0Z?=
 =?iso-8859-1?Q?FzrsQJx+9Rv6VssvFJd2rCZHm/v/lFDSNtAKcPpznEqdgfYhlU4kEGxC8M?=
 =?iso-8859-1?Q?roybyyygEPlQqqSMyRUvYmBp84k25q8Xje8XaNp30msQ/2k7wN2UJrroiN?=
 =?iso-8859-1?Q?9uTuY5l7HEqNPiPyd56q8DqBS0nU7A1eL521j7Kc2DtWe4J+sJOrO+FRG+?=
 =?iso-8859-1?Q?9CKvcUS7CHmrbbKPByJkM1LvGV6sxw4k+ewBK0NJr6yg9q/z7t2wgIDWdn?=
 =?iso-8859-1?Q?yEpdk6katb8d6rd2Q1h0I14ePaIZeznguIP+r2ile1t71ff0zFXS0rSZOx?=
 =?iso-8859-1?Q?kv51m3vQHRDDBOkYg164yEAy/Jjb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dKp5cGwYJSJkuaTYw2N9Am5WqnUAAljQSQ0oLjagJD3KFzLbUtv8/EOk6A?=
 =?iso-8859-1?Q?fAM6kWHd6wwBNIfbgYVgZqoy8hOZgB1PbrNe+vzpNYPXe8JXY02K5NuGqY?=
 =?iso-8859-1?Q?vJFK7xp05IeJ+dT55NSmmJKfS9jBDyIzbTk/HZraIi/vw8TwXSMiC1pJCI?=
 =?iso-8859-1?Q?IKRnfIWUyq3jlJSyJ0O2+vxFEzaRIy3Pp+0PNhRkrtIgJQyWrxRGq5CYKw?=
 =?iso-8859-1?Q?1zEF3Hr8yehhtFY3mWvFICojkrh4gIV+M9EVdZ6VlWSP1QWw1gHyGDvF9q?=
 =?iso-8859-1?Q?p2yY5nsH6VA9hgfD4ElBSPKR3mA8v0vYhBKciu0rxumZuc6yyQlqlhpfNb?=
 =?iso-8859-1?Q?XDFBZl+XtawjZlcpCloQRh9Fk4uMAW9FUDP4Z4OlRJOr6ESR3oK88YOg2j?=
 =?iso-8859-1?Q?qvk6ne1UeLieSs6nDKEJMQrtnYiQp6yFIVeyD7qspndA+F4Jqn6xvQR4qo?=
 =?iso-8859-1?Q?q59agRW6DuPZq8cQgEHDrJJ9FTbYJCjLYAV8HfCmP76gSuTU4IeIUQTjGG?=
 =?iso-8859-1?Q?m+FQ2EfpQvxbh5g14XJXjZnXk0byvMN/IPTdAGe5O5JI8BAah86wq1LvYd?=
 =?iso-8859-1?Q?QRUaO4tf5b/eiUkgykSuzUUWv+mmE/rLBoWgkwODaOHKqsFPEEdKue9oII?=
 =?iso-8859-1?Q?1iDMJ9u249SNsqALuUH7PRo1gZ11HgKX6If0doGxjZ6JVIpQhFWfsROEmb?=
 =?iso-8859-1?Q?GvRy7IUQGAW5WCUCxBgXf8U8W7/KI1sBYhDrRyznTdGqPZHIqq7bLVWzet?=
 =?iso-8859-1?Q?G1pNfUVf+ApuhKpVZfL6toNeHVxGO89JH5McHtyOh9Rvo93l0fGiJ11JAS?=
 =?iso-8859-1?Q?po9WN2911kznfGZgaJWjo2uXkKmEQuZqTMnJlSXpwzVeHiOyXI1eS02VX6?=
 =?iso-8859-1?Q?9AD6sSBuv6x2quoOlb5dOWFbSzeD5uxgfG5P1CydRg95eZg8buovYAO2xy?=
 =?iso-8859-1?Q?8+HfeXBEqXdf08VvmoT9lsTfYg9aQmqQSW/ccphtQJu/vGgsu8sjhbHT/S?=
 =?iso-8859-1?Q?Sk313ACKBCK4KvkFiJ89rUYpBbQAnt5d7M99+otfqNwBRn3Kg2KdyQVF5s?=
 =?iso-8859-1?Q?BQg6Us3I2jQsFU1WHiuLiE8EfrSmGoQKZSHUIg4kdMX3NwvV5xLO4qMJe5?=
 =?iso-8859-1?Q?nDXsbMOlKH+fmoqlczObCCYbCviM5OiTpwFQs1KZwSXcJ1v8OPaYxhc2o2?=
 =?iso-8859-1?Q?eHxN3tJ7GZVnnmgq9xJqxIMkYrwOEuEu6Uq5oMKktfSWLzky3hq4dt2eK4?=
 =?iso-8859-1?Q?HxYlbOZrgdKpumQO1WCO8XTRqfjeDUaBvY6uM4uG+WdrdoEtbcHyPp6bXK?=
 =?iso-8859-1?Q?0Y2/ay1S2TkLHzCRsxf+Eie7HbYv0FNY2gOfNbxaef8Tbr3z35jKbQXJ8f?=
 =?iso-8859-1?Q?KIsFNjsXx3GJMq03Bt6ojR3ZdE+LSPOUeptFngg4OegT1o/1BMZd7wbmkL?=
 =?iso-8859-1?Q?LQ+MdzG/M2UI6fS9MhnxE2oIV+m00fhAUwAIuZreDkKO5UeBsW9WC7Tpvv?=
 =?iso-8859-1?Q?TVkTKBBzPTPlEkgzHK9Jv9h4xOvtOE21vXMwMtHUqwsv/w6P+jtPsW6IBW?=
 =?iso-8859-1?Q?LfQMu06MzRwp8PoiNV9e6pE9erx2taoJDfrURRacNiT7zhjjoNVEqbORal?=
 =?iso-8859-1?Q?UdsYjwszRYdolxcnOzBJGNcE+9wRetJ16T?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0457cac-6fef-44e4-2a02-08de1c2fa62f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 05:53:30.9847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOghUMtSbTlnMSWjf26Qx+5vdxKgjeXjG/ogoT0+4cPVrcSBqg4pTqMb2cLyr0GmsbGwKhtyB8/lBTuC9QXnHFY/BTVtoDc3xxhqhiJDi7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5P287MB4534

Hi Andy,=0A=
=0A=
> > +static inline struct hm1246 *to_hm1246(struct v4l2_subdev *sd)=0A=
> > +{=0A=
> > +=A0=A0=A0=A0 return container_of_const(sd, struct hm1246, sd);=0A=
>=0A=
> It's unclear and confusing that _const() variant is used here.=0A=
> Either const qualifier is missed somewhere, or _const is redundant.=0A=
=0A=
The use of container_of_const() here is intentional and follows the directi=
on =0A=
taken across multiple recent sensor drivers suggested by Sakari. =0A=
(e.g. ov2735, vd56g3, vd55g1, ov64a40, imx283).=0A=
=0A=
AFAIK, using container_of_const() is a no-op for non-const =0A=
arguments, but keeps the helper type-safe and future-proof against =0A=
possible changes in the V4L2 API. This also maintains consistency with =0A=
other upstream drivers and avoids subtle warnings if any of the subdev =0A=
Callbacks later become const-qualified.=0A=
=0A=
But yes, I guess Sakari can give you a better answer.=0A=
=0A=
Best Regards,=0A=
Tarang=0A=

