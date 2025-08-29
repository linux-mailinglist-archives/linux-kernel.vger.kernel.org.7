Return-Path: <linux-kernel+bounces-791673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D885B3B9FA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E61204CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F3C2C08B2;
	Fri, 29 Aug 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AaG9OPum"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646F5B676;
	Fri, 29 Aug 2025 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467239; cv=fail; b=N36pjXqDifrFtoq2qiw3R8Dn3pwvY8Z16AG1udF8MuXvPjdOecqoWBpfP0MhmxV65BLEUFp8OC3eM1s8vCNBYRAoOqKiicY5EnofnA8uQaaLijvyJtTvFBJNw6B2KYNis1qaAmqrYKOcsyhV35JpWkzVLJzAeZeDalLH08Rlqn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467239; c=relaxed/simple;
	bh=ARzcj1Op56Ipxfc26SOk1y7dL/x0uRRVBTkjuIMjLpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tcOhOxImZMKIs8dpWh0bjcwn+lEdQRTbRs4ZoklkXZyUpOavaCLKHj2DQ91vD/HyxgjM91Vdhgn5iuwMaZAm+FVIqKl1PaeqWSTCwMfyB/ZXs0ifTkI8rnIXE15rlWkBeKIx35tkLkA35U96xGXPZKTEF/lR+FEq0OewMS4O7nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AaG9OPum; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfzipkbyF7R7BEkV2yO8c9RhDvsP14bM2fHta1ZRbAjw84Bxz8Eg3E8Xr1QgoGsRZmxEQz9KZVz+gvN0jxDbKaVB/755WXJX8E6TnKLse9vRMY9uHqrhtaPidrBxsuE2Vf2/qbJIexkIcUVj4A7H/TnEuiuDAmpbmm59glpU0t5cf1VM7IL+a2kqGd6MpsTEYWaAVBtWJwJ1GDGjrMxD8c04A+WEGK9kQSrRwXePHthMUM5LrycVOP8a38ooA2AbJYlRAxvyac63PlcFmd/Oukwqmkgb71ttc27Bg5+/rMPC7w34I8KwW2MfS7HKlBOZ+5WiW38Go8bG1E42vLlQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHnsl0ra/8v5chzbcyQMHWkh0zKY0IrpNbyms4v0DfU=;
 b=e8FGdAKITUzDqvGagdoXzUPo/jx8xGhzx3j/uHQKqVfYmhernYppHf1qDdnfvwMOiCElhhq1Sri4dI/8s73eV2GXMMYHX49HA3jgxllWZCS2wdBSYs9/J9TdH6a6J5+8elkiTQ1EPAsyp4pQX3WunhNW2+ak5HI/kyxUJ2EKgVhNKAyWnvzlKq2+WEexwEhtpRKarm8CKNMe4T4ApYM4x9lTBULqc1jKDZxOTwaQ5O4kXxWLFxsqmBTa9uuKoUks8rQpi4p0MZsRWKqlIPl+h6T3XASZ4QD3L0nkDHtbgxsIldoQE2ypBGpYzjaKIBFaN4U37oznbMSR0IgeCP1jgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHnsl0ra/8v5chzbcyQMHWkh0zKY0IrpNbyms4v0DfU=;
 b=AaG9OPumknUfBFgcmQLgsYhoaenZmKPAhBg34WeGd52U4KUfPkFMCUM/fwBLjjIMId2mVoUpeoFz/xt7Bvoyoxz63V53MhYbNxDOmbSYIxTZi+rypfkT7rR4+WtFhYr9w1jCa8D+KCpp64Bc69PGYQOJabXlfZusPTlYthTiNYlrdpdSBVLjpmbxtlKyCF7Tu8m1OqDWrQoZh0IXIWKs31vS4v5Ikt6UqQbIss4tABg4Ec4PKVuGoUnNSC+azWNcUZ+iHPjIjEVugnvA4sNi0dxm5ZIo0pwwT7xkmVvcSKPpq28ZjBUdBPvUOutNGlrX9Q3jAvTuu/rmlkBDA6bFfw==
Received: from AM0PR0402MB3363.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::13) by VI0PR04MB10255.eurprd04.prod.outlook.com
 (2603:10a6:800:23f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Fri, 29 Aug
 2025 11:33:52 +0000
Received: from AM0PR0402MB3363.eurprd04.prod.outlook.com
 ([fe80::f786:18da:bb91:97c4]) by AM0PR0402MB3363.eurprd04.prod.outlook.com
 ([fe80::f786:18da:bb91:97c4%6]) with mapi id 15.20.9073.009; Fri, 29 Aug 2025
 11:33:51 +0000
From: Varun Sethi <V.Sethi@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Marco Felsch
	<m.felsch@pengutronix.de>
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
 AQHb4RFy2NjRRk9es0SVz8O1dms9rLQTvUUAgALjSvCAAB1dgIAE1IEAgAAdTACAAXh9AIAJZc0QgAr2xgCAI+auAIAAffuAgBY8mkCAAVTSgIAHWPTwgAUCyHA=
Date: Fri, 29 Aug 2025 11:33:50 +0000
Message-ID:
 <AM0PR0402MB33631F1A9448AE91B58AA406E83AA@AM0PR0402MB3363.eurprd04.prod.outlook.com>
References:
 <AM9PR04MB8604611B8D91B5526C9704E69545A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250627084653.6vgwnm3llf3zknlp@pengutronix.de>
 <b02055bb-0995-4fd8-99f3-4ca5146eedd4@kontron.de>
 <20250630121722.wviidlggt7hguyt7@pengutronix.de>
 <087b8689-7443-4720-a94c-160edd31a5da@kontron.de>
 <AM9PR04MB8604C05882605EDB4913DA089549A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250714094124.e6fnkrocnqagbm22@pengutronix.de>
 <AM9PR04MB8604EFCC5400DEBB7DF0CF49952DA@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250806132701.fouikyuqtzdsxqwh@pengutronix.de>
 <AM9PR04MB8604A636762E81DF9EA9A9B89532A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250821132129.hwnnqdagalvxw2uk@pengutronix.de>
 <DU2PR04MB859982BC71F6CB8182EA1F5F9539A@DU2PR04MB8599.eurprd04.prod.outlook.com>
In-Reply-To:
 <DU2PR04MB859982BC71F6CB8182EA1F5F9539A@DU2PR04MB8599.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR0402MB3363:EE_|VI0PR04MB10255:EE_
x-ms-office365-filtering-correlation-id: 3d2d68af-6f0b-43be-bfc5-08dde6efed52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|366016|19092799006|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jb1wx6DpmrBSPUgWwFeW7ILMPWdM8PnxhUo+P/BV2oRrv0k2Tha21LuA/dR0?=
 =?us-ascii?Q?IYCc2D7d9zSxpwSTrJA8x7KuBjmofuiY7rPO95CVs1EjaY5uNz+DTTjag68b?=
 =?us-ascii?Q?6WPZYVK6DgvrpCg+0XFUq4NWJn4jLeaEzPqf+yFWUQesMZv/GaFk27MYPalR?=
 =?us-ascii?Q?m3Ql0kC1RREvg0TpDAdcLg2gFB4DNCwxPNH1sifE9fdw6qfpg5StJ1es5XUZ?=
 =?us-ascii?Q?HdfIy/uqTriHdEHT9o8Pk2sHt7jimGmQTlGKrGliTeCBRnlaWz4A3BRLBh7V?=
 =?us-ascii?Q?UuDSKtbB/IOe5KOlR1Ou7JHKe+twih0/raNUxs0xz42Piu6ecGKRmpyhUbb5?=
 =?us-ascii?Q?GBZeqCxxLdqiHJi9IiG/dZgzT2iaCgWTw+y5JR0svxSxecNUYtVIHHJ5sDb1?=
 =?us-ascii?Q?sT1R9dwdAhAyk9Yu3oJ1U4OmoAGWDKXoO0+ceCV5y5hxf2GBbp3MSCMYy6PK?=
 =?us-ascii?Q?yxNqE4HClqZYk+qGpjjBexzL3YnvmHnfBCrDYNUVLlJrovwDnqQUFwhAU2H0?=
 =?us-ascii?Q?53v14Ce5IhUUxaD08xwaLlGHiOthPiQY+rS/Lwx/uv51/9MqcUDe8Ic1ozg5?=
 =?us-ascii?Q?zJo6kZkf99iAGWqSgdiqBfJPeodqXqSi5Heiwo9jUzUn/GJ6I7tWU5Mf5v1R?=
 =?us-ascii?Q?YUwGhR3lQrw29w+S5K096HuKGcnhND35POK83cmmRhHX+csWUrUErsPytxjy?=
 =?us-ascii?Q?p8CS5AtFjQ4h+g6Om2kONKo/nQKK7OsN9XKHxn0kuDbXzxGlVSt2fIzIBjfH?=
 =?us-ascii?Q?3bV1AdyAolWWS2Nf/UvtnePVdSiVvds6U/yGVOfFeZdKB8qj9RyrpaPovsRO?=
 =?us-ascii?Q?tX0I69rQm4lhL+WzZgFUQqsD0plBJJuHz2Mb0p4wKkJyq/zfHbsayJI/Tab7?=
 =?us-ascii?Q?eoneF9Fcnk/vhJERAL7/am5EoLnK6jDNrhSR+CtD6I8ARJpEWSexjEPnUEe+?=
 =?us-ascii?Q?gSewVowX7khJ61OIL/G/irTZDj6s/wVLZ9hRwuxE8NStBSm+l8/LRAZ+Wbkp?=
 =?us-ascii?Q?T5HCLjwzSAK9aFzvRaE7H1loLrDTAMIQESc2vKmCac/W64JXYM+Wg9M5Vgi7?=
 =?us-ascii?Q?T7C4mhetsvBOZUWKLa8WVG/2AhN4CQcl0S5C+Nibvx876+QALeM+7dwgbh0Y?=
 =?us-ascii?Q?Snm+TFDInyzSOcAxYGJaP/ntsShyhQqQ2VEaDb2TP1MTO9A8WCAW16UDsDtG?=
 =?us-ascii?Q?4xyvkG62mGgssfxTCZDrJ7OhWmPA807icc+raIf+G2DlfRJYOUXq/7zYe+Bf?=
 =?us-ascii?Q?ymjza73mpWffrpDNH4g6cJYmeA4PR8NW4lPv4KAvBcJ8/miuqVGOwV9hDUAt?=
 =?us-ascii?Q?xr2DXIYXl904AUAze2QisMeRXPtlPnvjJmcnZ6cORu3yl7rjpMBW266uNhSe?=
 =?us-ascii?Q?tLu/FyJFSpktHYzHS+RN7RBnbeCA8MGH+7KO40ZhehsdYwxR3xWB90e5BDUF?=
 =?us-ascii?Q?xxDmIwX17tH6RSpe5iMf66d2X/kxHPbQj4077PYdhPXsHk9l36HCVgeacYFF?=
 =?us-ascii?Q?RpFXTMBRZMN8joY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3363.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(366016)(19092799006)(38070700018)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7ySeV/d7oLFRPk1tjM5y8s/uxQo3iIdIebkGjSxM4Ea79lGSZ6VtDj7ewmx2?=
 =?us-ascii?Q?5hUtzqMhvpiOtk3vr64/byJ8H8bRZbohjes7WngOa2nNHJt0/Qa7ffODI7gU?=
 =?us-ascii?Q?f/ZyLn6kERwOofRuOdXyC9KjIjgrWGDwk4RZttlzyMc9cGL6JK77xqY1EubS?=
 =?us-ascii?Q?eckmmbR1cCsp1pFP/NWGFxWdyQakB2kzCU9mreUbZwUfdrlSkMKgcx8dAntL?=
 =?us-ascii?Q?nOnYJxJYcg5ksOKcaEh63J8jw12kVoRoEj3J/ZCIIHmv05SAKczU8BbQ9YM0?=
 =?us-ascii?Q?LebdmEwe/xfmXpVbVRkF6KR1LNIKU69YCV3Z29UIS4yYXtDLTKGAcU7PBm1u?=
 =?us-ascii?Q?UTnTDmGgAfP1B1fu9aXGWAfBaw2qpoznOoS8OJe6FVEnJcM9GyhzrW9PYfy3?=
 =?us-ascii?Q?bt5q/ZoW9z3rcqk2nNFY2RJZASfu25cL3ZdHsBInVga7DJvm7ZEdf/d3IOxX?=
 =?us-ascii?Q?t5ZNJ7eUGvv19cZxiSbaj/00aIJYGP+/3Vclpe3PlvmKngs0oYomkbjR20k7?=
 =?us-ascii?Q?KsD7ZZmxkpqGLSxlFpelLHKhpvwaR9p7gkkiR2OFzMAmkqirPwJFMPR0HmbY?=
 =?us-ascii?Q?/xEQHn0Ca7fL0qg9k5cdRFHzF3X/7TZjR/VxVg4QvJjsVKAeUafTj1acHtuf?=
 =?us-ascii?Q?6/N/GGqsBOi+KJqYIcoeGe3xVII6QkAH28AE+oyM0cfdAsp25WX+bnDeWMO1?=
 =?us-ascii?Q?aUs7M2cKqKt0m73DIgeXJErclJjZifTfgHIf6KNy7iHOzIjIFHtyBy9iaaAW?=
 =?us-ascii?Q?mnXtPmwSh3XdR8yI/1XVbChYhjnVhY4kangBUgWuWGNbiytCux7OlBZNOOoi?=
 =?us-ascii?Q?QslbSZCsELtUd61SujhxMBo6jH1PAyu/1G+2FEawwPH6JC5Nh68Oxu+XBHR6?=
 =?us-ascii?Q?6Q8WF8gPVASN1ciz50npi1T6Rv5sYPJ2pYcnkHUhfSV8e2OBTwwgbW0s3ndI?=
 =?us-ascii?Q?6Qn1ZV+JuMohlNBY8wvuz26MVHxerDbX1i60XdgtH2jpOeG+YX5hliearQzm?=
 =?us-ascii?Q?5RSDopMwWf0MM2FTsiwefiPVIx5atcyS9gnZz0n9ORkqjShKLhXsAjzXGv8g?=
 =?us-ascii?Q?CpdoafBgy8ssXpszF69Az0IM/B0zCvfUq6dfmV5DksNF7lM/MNTH4dQAClEc?=
 =?us-ascii?Q?kDfufPDnIuaR4rCCjNIWsKVi0LGxoGfTOpptPl7LxIZmGejv12nYVi2aOfGO?=
 =?us-ascii?Q?voasp86eOK8efQVpmt5alUjzSXtZ0mpqC8t53Nj9uyzi2YBgZlFPcJ6Ov4Hk?=
 =?us-ascii?Q?SfFmUQleU+rT8NLOmXXDfv4AKyF0HWC5Np1xe/fWNyZ66n6G35J4ROQ7WRyB?=
 =?us-ascii?Q?ju5HWvDnraL5EasR2qb2Gsk8B99/paZ5uE2rxZ0ePAtMjjmBm0TNnB6BV+2d?=
 =?us-ascii?Q?HQmxK7ET6956dOiXy/i5O77+XOa2NluwkryRPUuf4INRpLe43IxaR803yFZH?=
 =?us-ascii?Q?MS4zHwi4yKwKrC/fszOKEo8bn93UoKayco0mCEIL/htxxF0dsPhmsHOKK8K8?=
 =?us-ascii?Q?2FWD/zQlQ0AozdmVBFiiCfINoaI++Ph/zDN/dKGF8pFvitv38GRPC4aFcCjS?=
 =?us-ascii?Q?IbFuc9uTgAUxF6BXDZfmaAvG7wd+599BTSGsevnshW8/eD1SQZpVUGQSP2NO?=
 =?us-ascii?Q?x4dPt0TTudEPKwQdbV1qBQ8=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_023E_01DC1906.E2D832B0"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3363.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2d68af-6f0b-43be-bfc5-08dde6efed52
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 11:33:50.9451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLzxL30WEfrUrQEVDLn+r8+zCCKuEgB+oy9gH6Vu57ygPKa78Hi6Fzwh99b40+tD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10255

------=_NextPart_000_023E_01DC1906.E2D832B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Marco,
Please find response inline.

Regards
Varun

> -----Original Message-----
> From: Marco Felsch <m.felsch@pengutronix.de>
> Sent: 21 August 2025 18:51
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Frieder Schrempf <frieder.schrempf@kontron.de>; Jonathan Corbet
> <corbet@lwn.net>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> devicetree@vger.kernel.org; imx@lists.linux.dev;
linux-doc@vger.kernel.org;
> Frank Li <frank.li@nxp.com>; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; Varun Sethi <V.Sethi@nxp.com>; Sahil
> Malhotra <sahil.malhotra@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v18 3/7] firmware: imx: add driver for NXP
> EdgeLock Enclave
> 
> Caution: This is an external email. Please take care when clicking links
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
> 
> 
> On 25-08-21, Pankaj Gupta wrote:
> >
> >
> > > On 25-08-06, Pankaj Gupta wrote:
> > > > > On 25-07-09, Pankaj Gupta wrote:
> > > > > > > Am 30.06.25 um 14:17 schrieb Marco Felsch:
> > >
> > > ...
> > >
> > > > > Lockdown: For a verified boot setup you need to burn an eFuse at
> > > > > some
> > > > point,
> > > > > to tell the bootROM to boot only correct verified firmware images.
> > > > >
> > > > > After this lockdown it's no longer possible to burn eFuses from
> > > > > the REE
> > > > albeit
> > > > > the production line setup still requires the support.
> > > > >
> > > > Understood. ELE access from both secure and non-secure world is
> > > > fixed in Q3 release.
> > > > User can be able to modify eFuses via OPTEE.
> > >
> > > Splitting the read and write between two drivers is even worse.
> >
> > This could be use-case dependent. Depends on how customer will deploy
> > its solution.
> 
> I don't get this. You introduce even more segmentation if the read-path
uses
> another driver than the write-path and if this is optional.
> 
[Varun Sethi] The secure enclave firmware can restrict accesses to fuses
based on the MU (from where the request is received) and core security
state. So, we are not talking about segmentation but rather partitioning.
 
> > > Can you please point out why you can't just move the driver parts
> > > into the tee? I do see many advantages if only op-tee is used:
> >
> > The ELE's KEY derivation function takes account of world from where,
> > the operations are requested.
> > - The key derived from secure world and from non-secure world will be
> > different.
> 
> Which is correct and no reason for not having an OP-TEE only solution.
[Varun Sethi]Yes, driver instances would be available in both OP-TEE and in
Linux. Secure enclave services exposed by these instances would vary. 

> 
> > There are different use-case for ELE accesses from both the worlds.
> >
> > Using OPTEE ELE driver for Linux specific ELE-HSM requests, it will
> > add significant overhead.
> >
> > Usecases like Transparent TLS offload while securing the secrets in
> > HSM, would incur additional overhead.
> 
> Of course, the ELE communication itself will be faster if Linux
communicates
> directly with the ELE instead of going through OP-TEE.
> 
> But to be honest I don't think that the ELE usage itself is much faster
than
> using OP-TEE and the ARMv8 Crypto-Extensions.
[Varun Sethi] That's true, the main point for using secure enclave is about
key protection at rest and runtime. 

> 
> For the ELE you need to:
>  - setup the context (incl. the message and all mailbox mechanism)
>  - wait for the ELE to be accessible (only one ELE, only one
>    normal-world MU).
>  - transfered the messages to/from the ELE
>  - the ELE processing should be equal to the CPU processing time
[Varun Sethi] Well, this is similar to any look aside accelerator. 

> 
> (Side note: What is the ELE behavior if the secure-world stresses the ELE?
> Is there a MU priority so the normal-world MU may get blocked (never
> addressed) or are both MUs scheduled in round-robin?)
[Varun Sethi] Priority based message handling is a possibility but currently
it's round robin. 

> 
> For OP-TEE you need to:
>  - setup the context
>  - switch the CPU mode
>  - make use of ARMv8 Crypte-Extensions
[Varun Sethi] You will also have an option to use the secure enclave via
OPTEE.  

> 
> On i.MX8M, which uses the CAAM (the ELE predecessor), we can verify that
the
> ARMv8 crypto extensions are much faster than the crypto-engine itself.
> Therefore the CAAM is mostly unused.
[Varun Sethi] CAAM does offer capability for runtime and at rest key
protection. That capability is used by multiple customers. 

> 
> Are there measurements/application-notes that show that the usage of the
ELE
> is more performant than using the crypto-extensions?
> 
[Varun Sethi]It's not more performant but offers protection for secrets. 

> > IOT-cases where real-time encrypted feed from sensors, will take
> > latency hit.
>
> Does the ELE support inline en-/decryption? If not, I don't think so.
[Varun Sethi] Again, it's about key protection. It's possible to combine
secure enclave key protection with other high performance crypto
accelerators. 

> 
> The data needs to be read from the CPU first, afterwards it needs to be
> prepared for the ELE and transfered to/from the ELE. Also there is just a
> single ELE with a single normal-world MU, so you need to handle concurrent
> access if there are multiple ELE-users (sensor+tls-offloading).
> 
> If CPU is used, the data still needs to be read from the communication
> interface but afterwards doesn't need to be passed to another IP. Also
there
> are multiple CPUs.
[Varun Sethi]You are right, but please note that secure enclave offers key
protection and offers support for asymmetric crypto operations. So, for
cases where we need to establish secure TLS/IPSec connection and ensure
protection for long term secrets (asymmetric keys) secure enclave is
suitable. For bulk crypto operations you can use high performance crypto
accelerators along with secure enclave.

Secure enclave use cases can vary for OP-TEE and Linux. We are enabling
drivers for both environments.

> 
> Regards,
>   Marco

------=_NextPart_000_023E_01DC1906.E2D832B0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIImUTCCBaIw
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
ggEKAoIBAQCdCIXHKmGeHnxxviKcRMbZCBGU7o/waJP5CaJTTQwdvjbfdn8tvk7875dJeeqF5OCf
I3hluTskPB3kkwt7J7/2iFLJf8jZVwUfIeZNyp4S5JDZ1CgBfALQqmc0zJB12m/Vw0FPwiTS8e+A
J/DNOnvS0bA7pb6JLzo65A3C7sDmK7S9G93yNmKJzL1+HW2I/nSBPW+puQBVdRglMs8kAFFs8W4r
lRFfaCuY8JjdiIgg7kmRK8eqr7QcChER/BK7ZgplyTzSecIqNwycOmE52j4Awsmx+WwCEfWb7xfB
/56iGhJugU3QmGFA5V9ruTXj/tQ90545/aal4nF6qII0GP2ZAgMBAAGjggOHMIIDgzAOBgNVHQ8B
Af8EBAMCB4AwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAwGA1UdEwEB/wQCMAAwHQYD
VR0OBBYEFJ4JSBGm/BBluRFJnF03QOIRkCEcMDsGA1UdEQQ0MDKgHwYKKwYBBAGCNxQCA6ARDA9W
LlNldGhpQG54cC5jb22BD1YuU2V0aGlAbnhwLmNvbTAfBgNVHSMEGDAWgBTlMnr0ZsFHliR//CeA
OVjfKxfiuzCCAUoGA1UdHwSCAUEwggE9MIIBOaCCATWgggExhoHIbGRhcDovLy9DTj1OWFAlMjBF
bnRlcnByaXNlJTIwQ0ElMjA0LENOPW5sYW1zcGtpMDAwNCxDTj1DRFAsQ049UHVibGljJTIwS2V5
JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERD
PWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJp
YnV0aW9uUG9pbnSGMWh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUC1FbnRlcnByaXNlLUNB
NC5jcmyGMWh0dHA6Ly93d3cucGtpLm54cC5jb20vY3JsL05YUC1FbnRlcnByaXNlLUNBNC5jcmww
ggEQBggrBgEFBQcBAQSCAQIwgf8wgbsGCCsGAQUFBzAChoGubGRhcDovLy9DTj1OWFAlMjBFbnRl
cnByaXNlJTIwQ0ElMjA0LENOPUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2
aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NBQ2VydGlmaWNhdGU/
YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MD8GCCsGAQUFBzAChjNodHRw
Oi8vbnd3LnBraS5ueHAuY29tL2NlcnRzL05YUC1FbnRlcnByaXNlLUNBNC5jZXIwPAYJKwYBBAGC
NxUHBC8wLQYlKwYBBAGCNxUIhYLAfoGO9FWG7YU4guuZS5qSVj+Exs1cguWNfgIBZAIBQTAnBgkr
BgEEAYI3FQoEGjAYMAoGCCsGAQUFBwMCMAoGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQCV
ISYPyZ8tMzV2Vxxwhb+eacmV5ZY5Xwd0qF/tfU8omgx2ZVb5ESgtaWAKIQEXQSBIsLdkIA2n491f
/uNGSVN15RCpA17D0iIBS61U5UzhxMDH4KnxMmiogR5GBkzRLVoVAnhR/Boxa1uIXppV5dh6Ywq4
JiRXu44iDaGby4EGDAhLtffZ0fQVWi2qmYHC7sPu90kPqwYbhgeTtDeeEFSZR0XKnaAmsvej9Pyf
Y/dmUeXfAgeuO0Bka3B2TfnYBSaNs+pHXneKQfvfqMaG56tEHpgkEsYDZAeQrKmDZinrEH3LFa50
gcla+E1xl0B+JA5hA1ui8l3wfJ2N/6XWd3byMIIH5TCCBs2gAwIBAgITLQAKnGVT0DER9d4+2AAB
AAqcZTANBgkqhkiG9w0BAQsFADCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkG
A1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgM
DU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAx
EzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MMB4XDTIzMDkyODA4MjIwM1oXDTI1MDky
NzA4MjIwM1owgZoxEzARBgoJkiaJk/IsZAEZFgNjb20xEzARBgoJkiaJk/IsZAEZFgNueHAxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxDDAKBgNVBAsTA05YUDELMAkGA1UECxMCSU4xFjAUBgNVBAsTDU1h
bmFnZWQgVXNlcnMxEzARBgNVBAsTCkRldmVsb3BlcnMxETAPBgNVBAMTCG54YTA2NDc1MIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAx63quqUHNiw+4UjSQdC7iq/7GeB9WxVhfJcTmP67
/E8e4UjtWZA93P6+axPP+WCCC9AbvbkQqYoDPIc4uARjy63M9GVMUlSUCc1ryhE1Gh8ZkTA3gg2d
19ajIAI9qWBTEkCD/uoQl8LX+z7PSfIJN4TUTSQdnY8YHBS0eaQsoIKTc9SA9u4CNCGIH8+JrbSN
jX66AyKSw5bd01e5gJLKSRr3/BcA9eFKe3x+KnyGz1eHo9tvGNFdYjy6B1vX/RoGS4OWKIVIpXiR
TuVCV6wLh+2Br53bh2b826oYL7/yNwS4nPMxGtk1N1kPVJPBMmztkdg+SO2IKLXYnjaQArgopQID
AQABo4IEBDCCBAAwPAYJKwYBBAGCNxUHBC8wLQYlKwYBBAGCNxUIhYLAfoGO9FWG7YU4guuZS5qS
Vj+Bt4I8g+2HMgIBZAIBPjATBgNVHSUEDDAKBggrBgEFBQcDBDAOBgNVHQ8BAf8EBAMCBSAwDAYD
VR0TAQH/BAIwADAbBgkrBgEEAYI3FQoEDjAMMAoGCCsGAQUFBwMEMIGUBgkqhkiG9w0BCQ8EgYYw
gYMwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBLTALBglghkgBZQMEARYwCwYJYIZIAWUDBAEZMAsG
CWCGSAFlAwQBAjALBglghkgBZQMEAQUwCgYIKoZIhvcNAwcwBwYFKw4DAgcwDgYIKoZIhvcNAwIC
AgCAMA4GCCqGSIb3DQMEAgICADAdBgNVHQ4EFgQUVJ8GnSFHOap7x3oDZS+Bm6IttxIwOwYDVR0R
BDQwMqAfBgorBgEEAYI3FAIDoBEMD1YuU2V0aGlAbnhwLmNvbYEPVi5TZXRoaUBueHAuY29tMB8G
A1UdIwQYMBaAFFiVYO5OdO9lIqq97RmpK3qOF50HMIIBRgYDVR0fBIIBPTCCATkwggE1oIIBMaCC
AS2GgchsZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049bmxhbXNwa2kwMDA1
LENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1
cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFz
ZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludIYvaHR0cDovL253dy5wa2kubnhwLmNv
bS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmyGL2h0dHA6Ly93d3cucGtpLm54cC5jb20vY3JsL05Y
UEVudGVycHJpc2VDQTUuY3JsMIIBEAYIKwYBBQUHAQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxk
YXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNSxDTj1BSUEsQ049UHVibGljJTIwS2V5
JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERD
PWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0
eTA/BggrBgEFBQcwAoYzaHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFAtRW50ZXJwcmlz
ZS1DQTUuY2VyMA0GCSqGSIb3DQEBCwUAA4IBAQB7i18WVDH91ma12T7GohhRfFOQSgEagWyOWuHa
2f+OkalA7iTXDerQXZ7HRHCegpuUz9CegLfDXdE2W8X3E3HaSIFHNzo6A84lvEPmj+c997KH4lqh
jh5jH0Afnehfo0COjcFR+njAQZ397cyp/ZzGx02au72mc+GVEBEEXF/pARUikf3JZfy9Ohz8nENk
XleZvq13FE/qh/MTl3Ki0v7yggWGHqv7hUuDayevFDd4FRx7siS5BzNCgrxbyYXmL2gnOjGaGJa+
gCDOjQt8WJs+RR3PvdA+BBVivYluJ9SPr2T4921RtFCJzzBn6/4gbtjyUakLTe+6Kunjy2hdVDa9
MYIEszCCBK8CAQEwgc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDQxCzAJBgNVBAsM
AklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29y
ZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYK
CZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTAITPwAF/iNEwhddrQna7gAFAAX+IzAJBgUrDgMC
GgUAoIICuTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA4Mjkx
MTMzNDhaMCMGCSqGSIb3DQEJBDEWBBRSFj85jzIL5RgQO98lDCJ33ncrJjCBkwYJKoZIhvcNAQkP
MYGFMIGCMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAEC
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJ
YIZIAWUDBAICMAsGCWCGSAFlAwQCATCB3wYJKwYBBAGCNxAEMYHRMIHOMIG2MRwwGgYDVQQDDBNO
WFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNV
BAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3di
aTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwC
Ey0ACpxlU9AxEfXePtgAAQAKnGUwgeEGCyqGSIb3DQEJEAILMYHRoIHOMIG2MRwwGgYDVQQDDBNO
WFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNV
BAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3di
aTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwC
Ey0ACpxlU9AxEfXePtgAAQAKnGUwDQYJKoZIhvcNAQEBBQAEggEAc3LT7yXV6NceKCxKdHJ7O0/U
XdwhzHoXXsbDrCcBvwm38Kc8SnvcX/pLuZjSYBqdyALXHeFx1ShdL3FUxJB+s2JJShEptMysUAdu
NpCdBFKVbMa+VbMnsFwbfoq07bL+fpv3RCRLPSBEvk1Ck1F7xFJFzyLjr1z4okmzvyJeoaYI7KyO
c504AEAihAsllX9K13Udpd3hsB6zlVNvdjZMKWNMFo8tZtDMgVSwzMHceasnX395WxWVfU7rb0OP
YP3bKufEHe/tPv3x7nZ4/O4GJ/52S69Utm5EMH0miIao9PcsVgz7uyrerJQ6qCWmkA3H0gtx9rLc
xibBHt5Sf69IkwAAAAAAAA==

------=_NextPart_000_023E_01DC1906.E2D832B0--

