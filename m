Return-Path: <linux-kernel+bounces-809291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7B8B50B32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928834676BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8418224418E;
	Wed, 10 Sep 2025 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j3oshU8g"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013025.outbound.protection.outlook.com [52.101.83.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769BE236A8B;
	Wed, 10 Sep 2025 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472070; cv=fail; b=KbmkZymgKdJsDZu/OfwnCZkWae6PkymvJYO2GQ5Cmfwe4B0ZJxn4AzfT+fxj4pjMX5D+DNsQRXAjTjDZPGxrS7mjhxXdJqrxngxVn5mr1/VZKMkeD+wMs34X4KDZHmYEwT3JXg8lXEvJbm+eb1VutH4re35Hbw1fUeEnWSskzyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472070; c=relaxed/simple;
	bh=0ivKeokyGn1eKUYoXMIR1fNaUxHO7eY0ycc/Iwe3zrs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pnJUHBXrvaPCvUY4D/PbDr2rHa3cesH8TTy24Sl0NmzQgSDFkeBcWSA8IwiHfTfV/IFa+L5Q80AqBAccdykw0sOmcVEfj2+mI4tS7P8ssoEQIfzQ7iPlT1zjDfbWuJcRgmw5dv1AoG9qvHHgqPTO+fBo+r0Y5+69NCBFfuRxH/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j3oshU8g; arc=fail smtp.client-ip=52.101.83.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVDcpzhhh3Jk7M0QywBD2DcSaJZrYE/lGZiDxiRR1eQfGn28heHcJuxKBrXM9xxp69z+z6ZLHI4zKNkY47whoDNNc3IY+LYL3wLWVuXPQsVdL4W4+Op7EETxTjI2NbDF+2itRfPOJVoZ3ef52QqtlhZMZkCPteFdDS0IzL3hcDpH3Ij8BaUXSP/xJgw4ArL3WSQ+iCwwm9zm71S62v/FspmDxFgOfW9FGtLu6z3C9cL6/tPUEMGMY6AR9pnwsuB8hPT+lPIDvyCiqmEFBoTYz0UQm1OvRKVxrNd1SDUkvDyimEKvPnJPPuX93GQO5q2RfnGtRtwDIiICp6DvT+2B2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ivKeokyGn1eKUYoXMIR1fNaUxHO7eY0ycc/Iwe3zrs=;
 b=q/BqaOGEB34ueN/t+sJU6ZrjyJHNeLrTztNgoAGAlFVPWRap0vHWRontHAWucx3pjEq+bhuEPZBdAQuK51OvwM7Pd/bygtG+f/mezDboYXlNdWrUmLza5WLfLvWOdQ24icV0AjrpLNH7Vb1+ciIOZephGP/2IFvTa17Jljpxh9q3swhy5BcQ4TZrTYR/9P9ZFBsBhWmG7N7HrZ9T8VNZaeIDyoJ4Wti+w1mbl7lSmidAvKPr+gdoj0W/WOPS8bAO8YD5RWeXP3V4VUTfnDDTtAIYEb46IqDjef/Q60tcurAYrhiYWhot65zDczPC+d2JmsaoEzMz8R7kIdKX/uCGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ivKeokyGn1eKUYoXMIR1fNaUxHO7eY0ycc/Iwe3zrs=;
 b=j3oshU8g+uOBvDHLSIkoIcYJUSvyMBLWJVWFpSIXFXjhOFQCMakEkJtxR53IomMBSCNmjJyRUPJBJelwmCAr8XBwCo9yyJHFRwDoyf2tcXDov87QK/jT3vIqkhTJ1jRWdb6lwPMDzZPJ3FrPikbEedyK2KznO437CaFxvZhzjwp66CUCcqgLio0VIcBXYUaU32PrE0acBBPZhkLHeuED9/M2NcCP0K4Q0F1m/fB2Sh2jKjLb2ID3pLxD0fJNdbN8t6y1PscjEvdwIXj55/aChAKcl0bIgP9Hr7/2QMWbfDBJ6H5GL2CKQFuIJe7odKM3PTQZKCkRq81XxEOJ2LTnGw==
Received: from AM9PR04MB8382.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::11)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 02:41:04 +0000
Received: from AM9PR04MB8382.eurprd04.prod.outlook.com
 ([fe80::5328:8a92:1dcc:e783]) by AM9PR04MB8382.eurprd04.prod.outlook.com
 ([fe80::5328:8a92:1dcc:e783%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 02:41:04 +0000
From: Clark Wang <xiaoning.wang@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, "tharvey@gateworks.com"
	<tharvey@gateworks.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li
	<frank.li@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 08/13] arm64: dts: imx95-19x19-evk: Add phy supply for
 netc
Thread-Topic: [PATCH 08/13] arm64: dts: imx95-19x19-evk: Add phy supply for
 netc
Thread-Index: AQHcDcOqPWhJYB2cHU6Q5dvXJIGBrbSKGTWAgABRCYCAAWrlAIAABaiQgAABT3A=
Date: Wed, 10 Sep 2025 02:41:04 +0000
Message-ID:
 <AM9PR04MB83826B402844A71F573E5E28F30EA@AM9PR04MB8382.eurprd04.prod.outlook.com>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-8-e609eb4e3105@nxp.com>
 <CAJ+vNU2hro_ZoRvmQ9yowKsX25AnrgZdGMn2D-RCkyJA02CEhA@mail.gmail.com>
 <20250909043327.GD20475@nxa18884-linux.ap.freescale.net>
 <CAJ+vNU3=mwZFBqQRNz4i28EjWXX6=Nf7iAsYPEBgpqkQw4wgtA@mail.gmail.com>
 <PAXPR04MB8459AE0C8D6A88632390C28F880EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8459AE0C8D6A88632390C28F880EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8382:EE_|DB8PR04MB6777:EE_
x-ms-office365-filtering-correlation-id: fe441a58-e5a4-48ac-9ed2-08ddf0137ca5
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHVlZDJvc05jQk1MZE9hRm5hVHd3Zi9qYUdpQW1NVERCMEtJQkhuMHBxMnpV?=
 =?utf-8?B?MEpyVGtxeXEyaGJjYmp1NUZXN0NVV1I2SlFsQjVLb1daMGRHUCtzSkRvZC9C?=
 =?utf-8?B?NmVtSExPNHJEV1VXM1VvY0RNS2EzS0wrM3FyTjhlVHNGZEZlNXRtc2tqMmha?=
 =?utf-8?B?QTNTR0xRTzdMUUsvNmJTVk1BZHBBbXNtQWdDZFNkaW9YSlN4WFJVVi81VjFt?=
 =?utf-8?B?UHZ2V2taTGNZcERhcXlqVGVRRjdUR3l4NlFIaGRrOURHdnJLVkU4bDBvYlpW?=
 =?utf-8?B?LytObmh0TGcrWGFDT1haNjJZNHRjV3B1NW84VTNYMzN2aThPSUUwL2k3aFpk?=
 =?utf-8?B?UmxxMlZaRHdNTTFzRFhJbXNKaFltUjMvS0lsaDZNaXBCYXJ3MGl4WkRCdk1m?=
 =?utf-8?B?bXV1SG1Yb3V2REpwMVM2Q3lMVkVZMit0UHBZKzRROGdkSGdoMmJ0d1JNWDBD?=
 =?utf-8?B?RXU4S2hDdER0OHdvaDFablArMmJrMHFpN2o4UzB0NWcvQmx4eEU2SGFKdldn?=
 =?utf-8?B?d1lIYkZnajUrdEU0ZnpuWXhDNWJHM1pFeXRRMktFc2dyYlFsSGczVnNaYVU3?=
 =?utf-8?B?NmVHYzRjU25DN09ZeCtxekRmMmI2T1EwbHFSRVBIQVdoUFJQR2xqSlpOOWZK?=
 =?utf-8?B?M29tb0MvWFdKekhIK2JDaWlwVisvcVhnMHQ5ODVraUVCNkZ1S3lETjkxRTAx?=
 =?utf-8?B?U0cxQkphNFpuRFcwVnVKS09kV1hSWU00UkYrejUxSjltVWhJRU0rUHhEbk9C?=
 =?utf-8?B?c253TFVkenZDbGUxdUIxSC9Qb3Uwci8xVHFWamRJQlRhbmM2SWZteXFBNDRK?=
 =?utf-8?B?MWJDNWhOMHRjeEVUd01EaW5iQXBhSjFhMHRkb2E5cFRLQzY2R0t2QzhTSEx5?=
 =?utf-8?B?TEsrNndLd2Z6eWhtelBQaXVZYWFXaGE1U0MzTS9vcHd0a2Z0M2dvRVBNL0lX?=
 =?utf-8?B?TkZrOFdBaHVqL0dCTzV4d095bW1UK0RDOU0veEI0NFJGNDFJemVRRFZrTW8z?=
 =?utf-8?B?MXNtS3k2S0p3RUxBaE9LWjdXTU1xZHRSTGxMV3N2TTVCZU5wOHBwdWptR3Nj?=
 =?utf-8?B?d3VGalpyT0xhaldnTXE3R2RmTDNiQXdPRXNSSXpKdld4QzlrWXJOeDBSMTBz?=
 =?utf-8?B?UUgrbkcyV2pBNjZyajlaNGl4ZzVRQ1d5NEJUMjgvd0NuY2ZEa09GTXRteUJS?=
 =?utf-8?B?OGYzZlhMbEI2L09XN3pMYVRSWHh3OUF5NFNORHNzL3phTHJaekMxNWJLUjFV?=
 =?utf-8?B?TDV2RWIyYW5IaytTRFhiU1NXRmRFOEdLNmNXUTZvZXVGSy9XNE9ra2o3cS9F?=
 =?utf-8?B?UzRzZERmdlBWNUVyVHBSNGJTMW0vWWNacVA5cGw0Q0pQb1ppNW8rNDFBM2RH?=
 =?utf-8?B?eWRMQkFtak14bDVSdERONHZJMklZc0NtK2NjOWJXODhXTzh3R1p5VDUzWUFi?=
 =?utf-8?B?OFRWYUJmZGdHeUJBNVpRRjUrUGxadk9TMG9PUFE0RjZ3ZFl2c0cvdnhlOU9E?=
 =?utf-8?B?M21TaGU1alBMQU5wQVZTVXZlclEyUmdQNEZiWCtXc0xzUGVsQUp0K1FtQ1pB?=
 =?utf-8?B?S1lqaXk0dHZLRlBLdzJYaTZlNEpwOWg4cHcvdE01a3pCMzhmR0E5M05oOXlS?=
 =?utf-8?B?SjdHYUVlRW9vOERXY3VrMjhnYTNkUCt6SGtuc0VSSjMycHBzQ1Y2cEs4MkVP?=
 =?utf-8?B?Z2FuSmYyQlM4Ty9mWm0wd0I2SHkySy9xenBRd3k5Vmw3cDBGZk5mR3dWZFMz?=
 =?utf-8?B?dFlybDFvKzhFTUIvalkzVlhPaUV4UmZBN3ZIcGJQZlNFK0ZSYUNMR3NtaURX?=
 =?utf-8?B?cmVxZmtDZTRueVp2T0x5bURQdElFQVNoVm8wamFTbDN0V2Q2dFl3ZEM2SlhK?=
 =?utf-8?B?ZFpPNVRkZm9iWXVpZFh6VnNhdE1MOGFxN29CNWh0Tnc3QjROM1MrNnpWTk5j?=
 =?utf-8?B?MTljWWtOMDZFMCsvZjJFSERRNlpVZkNxVzVpZFlmNUxZRm1SalhPdFo0Y1RM?=
 =?utf-8?B?S2w4L1V1NWRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3RTWERqNHMzV05TSlIrY3hQYkNjQUtUOEk5VUhjWThJWEhGY25EbFlnVFhP?=
 =?utf-8?B?SzZTNGZjV2FsM2tnTGdGOURTMklyRVoxaGV0SnBGa1EvZnIzSGFHNm9rWHNZ?=
 =?utf-8?B?RlI3a3lNcmEveVFWM09aM3pxdXNQUFgxUldVQzE0M1o5ZEp3bElqTlZHd1FX?=
 =?utf-8?B?eGFidDJlYWlrcUViKzFZUXVaNHh6eTNUVWp0UzRIOUY1VUJSOFVaVVN6Y0pO?=
 =?utf-8?B?c3U1dGdNVnJrSS9BczJrS2NwMkNFWmNSTlVLL3B3dHpIbndVSkhPM2o5aytD?=
 =?utf-8?B?RE5GV3hPV2pzWDMxVlFFMzBrdyszYXYxVFRPNDQ2dUo1VWJuWUpUM3FseTR1?=
 =?utf-8?B?bHcrZ3U3S0dsUUV4VVo2VlZHbE4rY1hZVHozNnd2OVFKN2tORDJXdlZNMFZa?=
 =?utf-8?B?emRjakt4YUpJN2JZS0RzOVVoNjJiRlR1NXdUbCtoZEJMbWs4UURWR2F3S3dG?=
 =?utf-8?B?eHUwZmtFbFMxVWlUSE9aZy9MMUJXbW1kVUd1OHdvQjJjK2VsUEc0SmFZUnVW?=
 =?utf-8?B?UTJqelVoQUMrU1hPSWd2cDFGdWZDN1BhbXZJTklMT2QrUU5NSWt4Q3MxRmFK?=
 =?utf-8?B?c29rVFlzVlk0SXFkMVAvQ3BHZ1JKYjFNMnMvU2RZdW9SdU9XTS9oNitxY1F0?=
 =?utf-8?B?SUYzS3lsc0xXeWVzNFNLWXJBb2o5aS9mdmVxSXVuWFJheHFxZVV3VmxvMUJu?=
 =?utf-8?B?S1VnbmRoRW5NeFJQMGdwMkpwS3llbk4zQmRnQSt5TXRUZ1QvRlRndW5rZW5o?=
 =?utf-8?B?c2Y2cE1XWjI0MGthbk5XYXB0QjlGMmZQZXZDcjQ2WFFsaVlZenJVd2xPOVVY?=
 =?utf-8?B?Y3FFMCtueEFVYWRkRStCQVlldVNSWVNHSkhuZDlUeUM5UmhMWVBSOWlENm1x?=
 =?utf-8?B?YlhMSUtWeHVXdTMweWdSUnplT2Nuc2hScFFVV0ZBbElSbWlkdUtOOTRCVHd2?=
 =?utf-8?B?V04vUVdpaGM0a3lHaUpMQWdna08rR3Evb2ppSmlTcTN3UjczSlNsZ3lKMGZG?=
 =?utf-8?B?VXNiRFZLUU9xYmpFQm10M1JoRkhzeEQzN2RTdy9SNTIzditvbEFUbEFpV0ZH?=
 =?utf-8?B?djRCalVjdEtJWU01aXZTeFExSGNkdUhWVmJKZHhqR21oL24vWEN2Q3VhNEJt?=
 =?utf-8?B?cE9jUXVCQ0ZkdzNucXRPbk1wUDdzbGY4Sk5vSGZRSUQvSCtpWVVINDBaS280?=
 =?utf-8?B?YUg2L2FpM3F1L0RiWjJRcURHTlpxTkVWSXRqNHZCdkNwdlllMHAwRkJGQzI2?=
 =?utf-8?B?alhFWk1WV2h1MWVuVnlxdVIrZ2h5RTVqRnNJMGowcFJ2MFY2NWxWMm1LYVo0?=
 =?utf-8?B?VFVBZWJkb0N5TmtSRkkrWUtBcjQrMUhVK3NGUW9wSHIyQVIxMlA3Z2xLR1NS?=
 =?utf-8?B?eVhxRTlOYmI1TzFmUkRtNkNXTWkxL0RIYm5tdk50RCs0OS9OTG1QTGxqMktZ?=
 =?utf-8?B?NWtiNkZvc1kwTHBvbGxXbDNKR3l0RlI2ZmV3dFZxejVka1JXNlNVK0JYVDRT?=
 =?utf-8?B?SkpVZExEbE9pbTRMdlRDVG0rZ1BUTjViR1lWcXZlODJXRGQxRTBVRjBlVk50?=
 =?utf-8?B?WlVQRmRSUXNnc203bUdER2dCRVJKNDhHa01DR1F1YWdGTjAzZmFDd0ppWm16?=
 =?utf-8?B?dGVNVitBTk9xOW5ubEl4R2ZEc2crTFZ5MXZqVlZPbkpBMTIwRHVVQ2g4a1Vu?=
 =?utf-8?B?QVdXdENBMEc1VXFtc3NrSHZpbGg2M2JLVk1CSHV2NUxMMGZSQmhselJaYzJh?=
 =?utf-8?B?amtwazJ6ZWhpcGlxMVlkTDF1V1E5VjRlSC9UZElXVWNJazVEMHZXaVdpejJa?=
 =?utf-8?B?bk5YckhKN203VUxhWGt3c0NLcnVIcjhmZlF3MnZXYVluRTJMMmkxUFdmZHg4?=
 =?utf-8?B?Nm5NZ0lnU3ZuRzhoQllQQXlJQ1B2bWxHb1Bsem80aHdnT21kbVNPTy94TTJs?=
 =?utf-8?B?Z3ZWUGpZMlJaVExFK25hWFJ1M2YwOWwwbllHTmJWZkhxdkRrZTAyVFVVTUgy?=
 =?utf-8?B?OW95N3RDUFptN0ZTU3FScGhCN201SFdCR0o5Qzg1ckZ3ZkZlTTRQUkRFbkNL?=
 =?utf-8?B?TlF4ajRUV3J1MHo0dHRpRVpCZU1vbDY1UURJUC9oVGhjQXNJTEVjdUozV2V5?=
 =?utf-8?Q?HO3GvM/akZRbLOXvonf0t+XJa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe441a58-e5a4-48ac-9ed2-08ddf0137ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 02:41:04.2354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RT5pUPc01mOpzykFXmGwJkVY+EpfuMlveN56B6cpz7g2pYQPYpYtzbH0Jo8KvOXdqjUFB1vg4uq3PHKwFODGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGVuZyBGYW4gPHBl
bmcuZmFuQG54cC5jb20+DQo+IFNlbnQ6IDIwMjXlubQ55pyIMTDml6UgMTA6MzMNCj4gVG86IHRo
YXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPg0K
PiBDYzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kN
Cj4gPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9y
Zz47IFNoYXduIEd1bw0KPiA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlciA8cy5o
YXVlckBwZW5ndXRyb25peC5kZT47DQo+IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxA
cGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtDQo+IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBG
cmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRD
SCAwOC8xM10gYXJtNjQ6IGR0czogaW14OTUtMTl4MTktZXZrOiBBZGQgcGh5IHN1cHBseSBmb3IN
Cj4gbmV0Yw0KPiANCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDA4LzEzXSBhcm02NDogZHRzOiBp
bXg5NS0xOXgxOS1ldms6IEFkZCBwaHkgc3VwcGx5DQo+ID4gZm9yIG5ldGMNCj4gPg0KPiA+ID4g
Rm9yIDEwZyBwb3J0LCBpdCBpcyBzdGlsbCBub3QgcmVhZHkgZm9yIHVwc3RyZWFtLg0KPiA+ID4N
Cj4gPg0KPiA+IEZvciAxMEcgaXQgbG9va3MgbGlrZSBhdCBsZWFzdCB0aGUgWFBDUyBzdXBwb3J0
IGlzIG1pc3NpbmcuIERvIHlvdQ0KPiA+IGtub3cgaWYgYW55b25lIGF0IE5YUCBpcyB3b3JraW5n
IG9uIHRoaXMgb3IgaWYgYW5kIHdoZW4gaXQgaXMgc2NoZWR1bGVkPw0KPiANCj4gKyBDbGFyayB0
byBjb21tZW50Lg0KW0NsYXJrIFdhbmddIFllcy4gRHVlIHRvIHNvbWUgaW5jb25zaXN0ZW50IGJl
aGF2aW9ycyBhbW9uZyB0aGUgWFBDUyBpbnRlZ3JhdGVkIG9uIGRpZmZlcmVudCBwbGF0Zm9ybXMs
IHNvbWUgYWRqdXN0bWVudHMgYXJlIHN0aWxsIG5lZWRlZC4NCkkgZXhwZWN0IHRvIHN0YXJ0IHVw
c3RyZWFtaW5nIHRoZXNlIHBhdGNoZXMgYnkgdGhlIGVuZCBvZiBPY3RvYmVyLiBUaGFua3MhDQoN
CkJlc3QgUmVnYXJkcywNCkNsYXJrIFdhbmcNCg0KPiANCj4gUmVnYXJkcw0KPiBQZW5nDQo+IA0K
PiA+DQo+ID4gQmVzdCBSZWdhcmRzLA0KPiA+DQo+ID4gVGltDQo+ID4NCj4gPg0KPiA+ID4gRm9y
IDEwZyBwb3J0LCBpdCBpcyBzdGlsbCBub3QgcmVhZHkgZm9yIHVwc3RyZWFtLg0KPiA+ID4NCj4g
PiA+IFlvdSBjb3VsZCBvbmx5IHVzZSB0aGUgcmdtaWktaWQgcG9ydC4gVGhpcyBjaGFuZ2UgaXRz
ZWxmIGRvZXMgbm90DQo+ID4gPiBicmVhayB0aGUgcmdtaWktaWQgcG9ydC4NCj4gPiA+DQo+ID4g
PiBUaGFua3MsDQo+ID4gPiBQZW5nDQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPkJlc3QgUmVnYXJk
cywNCj4gPiA+ID4NCj4gPiA+ID5UaW0NCg==

