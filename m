Return-Path: <linux-kernel+bounces-802418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34ACB45238
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA013B4F3D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DC32FD7A4;
	Fri,  5 Sep 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="InHNqotq"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023122.outbound.protection.outlook.com [40.107.44.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266F27EFF1;
	Fri,  5 Sep 2025 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062635; cv=fail; b=i6PkH6VcHUxiDj/aI1upC4t/dcrj0wSNj6U8V6eSr/3uIG2qCCYPG78CiAk/DQG49IYbDbbUhAJUllxARHvLRR5t1Tn+OZnnMEina0ePuyzqZDtxu2EHS2jFMknDjgRRFKgJC5+Fa4CbAeolK/7Hp4Ts4PhRSLgbZGJiMAX5L1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062635; c=relaxed/simple;
	bh=yVy4L7L69SW7kJOx3S3pc6EhmM5w4Eyor+Yn93JilGE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nTGEicWRJHVdvgHU7sN4WHe0v9CW78XR9BmDEWe8kR5/5Vdj9EWbYp+YoPPTkkbEWmqRzO62ePTFxvq/sYOj2GsSJcTAxpTdf0hSrFytsvDGPUaefGos7ThBGvCw7k6lKL3DtJ5flfyz3D5Ar1Qi5LEbm3mcunyg0NzLKBLL044=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=InHNqotq; arc=fail smtp.client-ip=40.107.44.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHD/ZTOE46Lu6wsBe/2cAWhvEP8Fi3r1V44wjRjP+b8RsNeaiTNe/QBtNR5YnFrqq1dBPmIpjaZMnBJomZcvrCwUJt5WWby+zMnC0pSSkfG4TET9s19PjNl0BfM9AH7kMW9XBYRcJtsVdCnZ3+jfuWCxae9BExk0PKarVTf+2iQEtODf/aRB719U5Ia9FbEsfuIpO6OOMd/EERG9nl4UZfnC5nkNOX8ZU5K5zRBfTNwxPJJC0qudy6eonY8XOmUBHB9Mr2f9GbWFR836Wlr+jt6edTAxKwBZo6iSmKPc5d3b/FBPrGORmaviNf8cbgOMkqZrMU99bvrOcONNxJDGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bBHMQehf2aHd+7S85p7janWKl5kkS1nKsROzDyjn1c=;
 b=BhCTpHWt5E3v/gYQwlLbtFAQWrwUwk6xEcPCM3NTQhbp2L1VS569ms2piae1ez+isC9a2u99nkhonwSu1irRwAgVHs/t5Org2ylTsoc4iGeDMIUSMgWZfXLYZu9BfvG8GYYlQZ4jKM9uMeIU4cFRJdkTgXEKwPz8djIT7S1FhPkzFyNYDKS9LWIEcHM5RE6Y1nyFQeIargEV8ZtoEIlHQ3Zv4bZTbqpxV5yyFAYX4r81QhtOkQR3e76Jr8PZSK90Zoiec1NQjVTIvGBfFlC+1tECHnmIl7JdZInfsc15H0w6b7VfD3lbFBV86zWeWXK0xp00Qstu1MZvt3gKALe6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bBHMQehf2aHd+7S85p7janWKl5kkS1nKsROzDyjn1c=;
 b=InHNqotqnrVTwoYSlwh8uck+OSD3EZfoHCCshdWe+lCX3fqfQFwiUK1/BTPUOCEn7Az6Br1K+I2bMT4nwE1AZCHC7nGM10HA39KawkJA8Zxqg2fbxX5uuPPpDXLLzNKfMFma+olNDYTmhqr/o9Nxa7Mm5cEKak84vCzv07EoHesomVjzldcKEetmpmV/XZSl1VNbUh/PjomIEprA0EVdy7SqfiqnqdRzv+sj5K2sm+e6al8Kk5mqnUxgmLkF5ACiXoXH7A3pxa5KyfZZ5pVGkzDHnY1GR5cLlQ2ZKb/uR0x6MMD1sBrcWPNLEaSaxPc1b8mwOIwDRmmm912yM5Iq5A==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 08:57:08 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 08:57:08 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Eddie James <eajames@linux.ibm.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SCU
 interrupt controllers
Thread-Topic: [PATCH v2 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SCU
 interrupt controllers
Thread-Index: AQHcGh0GPU6Ub5O2HU61CmoAvkdS+LR/4M6AgAJX8wCAAgXBAIAAE0jw
Date: Fri, 5 Sep 2025 08:57:08 +0000
Message-ID:
 <OS8PR06MB75416851138FFF2A62AFEE56F203A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
 <20250831021438.976893-5-ryan_chen@aspeedtech.com> <87y0qx0zqu.ffs@tglx>
 <OS8PR06MB7541CD16E659666868EAECB9F203A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <87tt1hwdb1.ffs@tglx>
In-Reply-To: <87tt1hwdb1.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|KL1PR06MB7034:EE_
x-ms-office365-filtering-correlation-id: a737cc3e-c165-4e33-e18c-08ddec5a31b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OwcfjDLSl5A5g6hOPpc5pETldtBR3Tooml/B6Z+AIz56qtrT+JNjvDLKZNhQ?=
 =?us-ascii?Q?On3GT4KhKU8IhqzWmsozdqkxJjGJVKq/heHdTHf8T+xv80eQNU0zVXkfvDcK?=
 =?us-ascii?Q?YyZ91MsWV6djOyqbAet04BiYmTt/PDJWYYptnJHCmK/6e2eTe2/+SoQp7/sc?=
 =?us-ascii?Q?Xsfu2Mf90MHlqCobH9i1kHvi9qFzUosR+zqeuPymjB+15H7fvWHPJX7p0IuU?=
 =?us-ascii?Q?a3jrPpbMnPxXczvmafs5geQM9TVrpgztTmPFm0WhMXykup3hs5vEjjJvj9Lg?=
 =?us-ascii?Q?KVG46gkiaBq4YYi54P5Zh7MXTLOajVxBKkHGm/XrshZJ/KPS19d3vabQLlEl?=
 =?us-ascii?Q?iZQ7bB9xVbal+zRLVPIOpe+rpegm9z/gyOAFKPYSMvMBlV0vy1iQ4CmUxH68?=
 =?us-ascii?Q?/4cqAfhZ5F0QuHzvqFMyx8xygQU50mYqCAKNEC0yV8HOOW9AaZnoSFdmsiCW?=
 =?us-ascii?Q?j/N52jrwIXjuI52zJyfIa/avbX5eq12Hp28QBXSgadBaLS6UITuLMGcJjt8+?=
 =?us-ascii?Q?CB2lm8+lKCLMSRvW31e7yKMZK9Ot+CkYmrLwN0qVM3WrC6oFBxAVJgOXz+3u?=
 =?us-ascii?Q?3K14uudQHkz+ICLCNSzQNxSg5uQIcbKXm5dvvEJgMHvfbPsBVWrmK7t0QhQj?=
 =?us-ascii?Q?Yf+B4bObIlZ4vAZ1SJsY5FuIRoRO2s+oIjFlp75uBx+RtxTL0tJ3uFiv+1sk?=
 =?us-ascii?Q?G6oxRdX34h6OmiMhMrYMEVkmPLG+EPVbGc+/4mBu/PKYfC1RTaiDVi2BYGvs?=
 =?us-ascii?Q?5KLh2GIvsrKouC3Kz8dhJpUypoLWR1/XRfmWJpFPS+fQfCQKAfHJ+9+RxUU9?=
 =?us-ascii?Q?S3hwmjcdazYwQmXnyO7nTkraemKSlpMd0RdvQh6jpxTtYWmdAqXSIAbv6pxQ?=
 =?us-ascii?Q?mKJQ5UULHSwUJaCrsoyMMZPKfPs825YJiZzDdFoiDZESOnxyMCC2joi4GMuL?=
 =?us-ascii?Q?q8/RLvqi5DWwGye9bnvUtrA3eKPpKns2b6vtE0r6zDpr1lXH7yJ2l/1dOXk5?=
 =?us-ascii?Q?5KXG10SGeLSeSuIJ0uOGx1+hFpbhZQNpYheKJVzFF2JyLpRVvWbea5ihwT3U?=
 =?us-ascii?Q?v8l6gc1FkCU8xPZ3zfF/ooWadv6yKjKYjxiYlDuWlK2uRisvvN1pX4k6957M?=
 =?us-ascii?Q?SmBeZOLPN9V6bbc8b7doREZaGknieXyY6T+XzqPo11ifq0N59b/LORy38Mba?=
 =?us-ascii?Q?xxys73Dcg+0X0Eg9KboMEw0Kof+nC8ggdJCgRugHQmRMKWXzzJl26a8ZYySr?=
 =?us-ascii?Q?uAL4zt7T5vPtueDPY2suH3AZS4opsK6Y2mvU1V0W5i1VZ024pQuXlSAbSJ2t?=
 =?us-ascii?Q?I9NUAo1u5psIHf2Dy1aSDW7NH7LmBZaLgBDSeBsR/WpGo6kp2PB7M245+fK2?=
 =?us-ascii?Q?wCuR6trXg4YUgbcGfyBrisEs5sLREzu0so9lumrXYinp7LGAHJruLWpJQn/c?=
 =?us-ascii?Q?xKPvT1QmTYCqPHWUypTeGa+MCv70EonKOZvKGQj4WXCU4TlJX6DD8wNJTWTI?=
 =?us-ascii?Q?a480EsQAVMn4NIk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DNZDZ1J9qd6H8FRa2Oe+cAhIwKQl7YwohlCdznK9v2JOyWMeQF2s2QOSe33z?=
 =?us-ascii?Q?Zk3JKc4FZJByLBphX8YK6rXTcnSUuWwLfbZPnqgtlwnVvqbUmC5llVNBLZ/B?=
 =?us-ascii?Q?AHxoVgFcYjijLkcp78oP242nRNjocPkYUKvLk2rYHTiRyrrwHcM21LxdZXDg?=
 =?us-ascii?Q?pCG0U+taTGeuJiLtscDmn/wrzElv49fNheRkpDA6pu+diXnHks5J2+KMwlhU?=
 =?us-ascii?Q?/tgs4AhYvj+9cGwEBiM3tEGxHMFJvwzej3H9J7tOfPbhwzZiusbsRrpNuFan?=
 =?us-ascii?Q?L4Vz+CoHzwRbiAKrpaykc8dkKYix3/NnvyPxPGaqAem0oGIh/tJLg7gMSi61?=
 =?us-ascii?Q?5aK0aEST9z2xuqSgajZ/VTynwHB0SHvotuxXoydY10uVd9FJcA88tjvCIurm?=
 =?us-ascii?Q?hIjFdX5wI4ZLDGkE4iB3EN/Q1n/GPvj0LEO6Z6x9lBu9J6GUlwJ/HIt7AEVJ?=
 =?us-ascii?Q?3dFPglEFpBWY5NCXVNITseaT1Ci9O5i4MHEFVa30JNj3Y+IFE5k2pSAYFE8b?=
 =?us-ascii?Q?gc6CPnCECFW82C1F0K5nprqRnOvJuSl20hbeEvOkJD48HQjyHaiVtePDkUdZ?=
 =?us-ascii?Q?OMbKTSuiur0Oa9J5538Rt/hPo/hS5MhcmC0UfdKKg8YCacLPds9fwK+FuPDq?=
 =?us-ascii?Q?blHk5X6GmEM28hbI4ZUQHRG75tKG+cBaMbwkj0XbipBu4lKIaoCVIhia2xVq?=
 =?us-ascii?Q?g912n3xDhwHkJ5DYieiViY51Gy88DkZaWvk76KBzNd0BoezfnXzzPT4Jc33K?=
 =?us-ascii?Q?6fCtpzTfX8MPmrLspM3NXpW6NuTFFp9uwHTuQlBTHRxrrlpltKI5ut7DmRG7?=
 =?us-ascii?Q?GVLLpmRDd2XyDwJRwpOW1jGOpUo4Yhg/jtEM42K93MOFTMp92A9nJz4ogwXg?=
 =?us-ascii?Q?R9Wq+Caqm5WjXInjdy9mqXtOOnmU5x0lwQTlMmblWFPV/J++p6gWth+W0d0W?=
 =?us-ascii?Q?Q3K4QMmudZkB/BU+X6FLUz4CfwAhZ/bTuHfGjugZuI527Yc2kHUeAFMIh7B6?=
 =?us-ascii?Q?Xfb+aD06R4M26bvsCt6K5o/QI4ULf+guL/pByyjcF8V8b2u7XvQUOY2xhUuh?=
 =?us-ascii?Q?EoW+ZTCFerLeAl5tb468UNDb0eOMD5GH7K9Hg9twN4uR4xgEqgGSv9kc2fAC?=
 =?us-ascii?Q?UbHGepzoj4g4SRm3uSvO+3WGkfeCli4P10Lw7QHInmC2/+3ivwnUd/eU+dw9?=
 =?us-ascii?Q?O1R8/GORf7CW26X3LCtyW8EryF4cWePyjdhpezX//w6uCmg9NQzgK5ZzXFHb?=
 =?us-ascii?Q?Q36KCuIfKeGcCL1Xh2aFCOvD/dI4EHD1MHQ86uOGLBx09+uJe3MwRW6MzWAS?=
 =?us-ascii?Q?Lu+ijE3oK/t9FXNGyPWKUEYkAKie2yu318mL1qLZfhzsktOX9Ussfo3hFpvA?=
 =?us-ascii?Q?b9EYBPCUiNZVFGfxMj96XdbVPfelszvQ9fYCo74JSqRN3Gbt3CMgysU6/X8w?=
 =?us-ascii?Q?M2I0J/1oNHfECEBxzBM7mZLA11ofyT7Gvnox9aqqUivmo4x/1ZzlDKMybF/6?=
 =?us-ascii?Q?aEcOLAmhX0WlNsu/s7Njzd7UpmOnzw4fWWSTL45T/MDbKiBwo7fglIlaHfns?=
 =?us-ascii?Q?ipfY5ZWs/H1ea77hWDU3Wv06xKDi7s4G+p2aOqHr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a737cc3e-c165-4e33-e18c-08ddec5a31b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 08:57:08.1402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xm0SlQWUYyNiCnhq+kSR5XYO9UWbmCQTL5b0rOCLkvHVimZD5akWybJ/NWHwshPLRHHadhIHegxRn1+Yx8vxkSAscdjlH9Vic62i+crwByE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034

> Subject: RE: [PATCH v2 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SC=
U
> interrupt controllers
>=20
> On Fri, Sep 05 2025 at 05:55, Ryan Chen wrote:
> >> So you have two different handlers. Why can't you provide two
> >> different mask/unmask/ functions along with a seperate irq chip
> >> instead of cluttering the code with conditionals. Thes two variants sh=
are no
> code at all.
> >
> > I will add irq_chip in SCU_VARIANT, like following.
> >
> > struct aspeed_scu_ic_variant {
> > ..
> > +	struct irq_chip	*irq_chip;
> > };
> >
> > #define SCU_VARIANT(_compat, _shift, _enable, _num,  +_irq_chip,
> > _split, _ier, _isr) { \
> > +	.irq_chip		=3D	_irq_chip,	\
> > .....
> > }
> >
> > static const struct aspeed_scu_ic_variant scu_ic_variants[]	__initconst=
 =3D {
> > 	SCU_VARIANT("aspeed,ast2400-scu-ic",	0, GENMASK(15, 0),	7,
> &aspeed_scu_ic_chip_combined,	false,	0,	0),
> > 	SCU_VARIANT("aspeed,ast2500-scu-ic",	0, GENMASK(15, 0),	7,
> &aspeed_scu_ic_chip_combined,	false,	0,	0),
> > 	SCU_VARIANT("aspeed,ast2600-scu-ic0",	0, GENMASK(5, 0),	6,
> &aspeed_scu_ic_chip_combined,	false,	0,	0),
> > 	SCU_VARIANT("aspeed,ast2600-scu-ic1",	4, GENMASK(5, 4),	2,
> &aspeed_scu_ic_chip_combined,	false,	0,	0),
> > 	SCU_VARIANT("aspeed,ast2700-scu-ic0",	0, GENMASK(3, 0),	4,
> &aspeed_scu_ic_chip_split,	true,	0x00, 0x04),
> > 	SCU_VARIANT("aspeed,ast2700-scu-ic1",	0, GENMASK(3, 0),	4,
> &aspeed_scu_ic_chip_split,	true,	0x00, 0x04),
> > 	SCU_VARIANT("aspeed,ast2700-scu-ic2",	0, GENMASK(3, 0),	4,
> &aspeed_scu_ic_chip_split,	true,	0x04, 0x00),
> > 	SCU_VARIANT("aspeed,ast2700-scu-ic3",	0, GENMASK(1, 0),	2,
> &aspeed_scu_ic_chip_split,	true,	0x04, 0x00),
> > };
>=20
> You have this split_ier_isr field already, which should be good enough to=
 select
> the chip to assign, similar to what you do with the handler, no?
Got it, thanks your feedback.
>=20
> Thanks,
>=20
>         tglx

