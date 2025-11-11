Return-Path: <linux-kernel+bounces-894833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C41F0C4C341
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0E4C4E9E65
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A492C21F8;
	Tue, 11 Nov 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ULw5Rzjp"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DDC15E8B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847679; cv=fail; b=sugaBPKuJ+Dj2HeBtqc1a0TcgPFgjP0eTq7vQr8gRum8OQ22EeLSv5AwJMBpyrMtc7OUp5JrTwGAeDMZaNreAC8YaiImFHS7KmOF1L8ysUY7Wx3F2Jbw+zgQj/J5jWibHCOHbobndCWhfe/ukSDRUYTW+xaDuCViarkWG7QqcGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847679; c=relaxed/simple;
	bh=vugu7ow21mHdDU+mKbAaA51tQnFobhqbCdg+W6mbM1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tbptKHiOm3UNmFbtaFr74eVZ5x3TfzciReZKL1gwoxA+eVMyAEdM6bGdp62d/TtAGmbT8V9814FvkpLTtoSF+6kB+VIOlqnOUhnnfcOerpLot8PxU34dA99efdrAHrUI011qLXEF+Mgx6XTagScoT78Jxj32cX/RSkMJjC07ssI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ULw5Rzjp; arc=fail smtp.client-ip=52.101.84.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRRXiIVVBkq6+WGZGUU9GAJmgPedSgWod5M6gAgCy0jn/hf9VKCLK9RNkwszUTtx54shoxZBqDzOZhSAJ01wABJSy+i08pabU9AFXdo4PgZS4qZ1BCCQZBSXNZffjphe6YwDV1cPq4YaBZfPQfub2G6QmQDspbtDSxBOJl62wknrpixunv849qE8L4USRXTQ/pzbNjFBnxSB5vhMcc30LQg4ZX2576uiZwobaxa4bjBekhkaopGt41Pyy0eYOtXpwGxZF8lH/4qTAwhPU3IWKPIJbMOXDUZZsDs9AdGGwvnbm+VU/zTFtCaI5tC4Ag+e2fwFWzaBwH5pKAyOlB5c3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vugu7ow21mHdDU+mKbAaA51tQnFobhqbCdg+W6mbM1c=;
 b=vj8IzSvQ/3Dx8Zu6K+0EdnPN6jbHZ+5junchPddoMFBZUHZ7v9yDwB7oLT2VX3aoUMzQB8WOZxaWbuGnE06D6zlRML8HPbmQGQvDyp3d9RiWAZJ+NtPfZGbQYjqRCJVqxxwCvE4S90mlCwtCOS7UrSqQIe5czUY2kRdmufwYwLqrXdxoxW4MLlV4IaGqnoUvoPAJJtEX2ZS2RS/mUkl1wW6fDIJLWXrHeTLwCPy9zMLxXDb/fPt9JMVg+TsAo2Il5BtjEoaJz12rWa8CEQ8kkRVK2SZhEuxkQps0ktpFSodStwgpjt0LrorSCJjXZ7eg/EVAzhdZN6fQauYb868LFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vugu7ow21mHdDU+mKbAaA51tQnFobhqbCdg+W6mbM1c=;
 b=ULw5Rzjp1dZvhxrF600IMpgKOROaG4h4lr8KoGtOTz/jdzfZWBZ4wBn93JqeYaKJHBOnp7dwf1gG/X2aRca+F0nEi45zFp7JW5OWdARJXkLtDdIL2Qw9QHftBe88FNR3HBdc5PZ9dEWwnz511XHBmQw2hg6PuZdkUiY2BkgwIGe4KTFMd0DVG5GL19czgQxYToSIAZVmUOMRdaaoOcHX+kWrXn1yPf55//D1BHvZkgcpA3zmp7P2jLl7Kr769j0MLSd7p/+j5BD8ZE4+FpnFhwHKT1KD7nmQbNyyrFrGspXhMr1x6vsB6ufba7CZnNxPGISzWNrgljfA6vzxaAfIfA==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DU4PR04MB12027.eurprd04.prod.outlook.com (2603:10a6:10:63e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:54:34 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:54:34 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
	<pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>
CC: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 3/4] mtd: spi-nor: micron-st: add mt35xu01gbba support
Thread-Topic: [PATCH 3/4] mtd: spi-nor: micron-st: add mt35xu01gbba support
Thread-Index: AQHcUfbjKiF8sNqJ6UeAxk1fp1nwu7TrdlWAgAGhuLA=
Date: Tue, 11 Nov 2025 07:54:34 +0000
Message-ID:
 <DU0PR04MB949675657F9A4C52A0C5E19B90CFA@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20251110-nor-v1-0-cde50c81db05@nxp.com>
 <20251110-nor-v1-3-cde50c81db05@nxp.com>
 <b046d19f-6e55-47db-b7a8-6c8766da2e7f@linaro.org>
In-Reply-To: <b046d19f-6e55-47db-b7a8-6c8766da2e7f@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DU4PR04MB12027:EE_
x-ms-office365-filtering-correlation-id: f0b46ae2-7679-40da-2d8d-08de20f78de1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?d2ViVWZYNFovU3hGRlYwb0EycFB3clpRUlgzeE1qYWF2aW5yTWRXckRlRnBs?=
 =?gb2312?B?a0hwbVhmSEdWbldaTHFneVZlWng5bEtiQU5TUEZKYUxQcno1MFFtOFBvb2VT?=
 =?gb2312?B?REtZazNLYkNEKzdKR1BGQVJyMGNZSnR3QTFEYmJzUS82TzZ3TUVKSjhHcEhq?=
 =?gb2312?B?ZXp1T2dJYmxhMlJBOS9yRmgwU0FGTVhHVFZtSU13SHF4ajNZd1hYQUFmWFds?=
 =?gb2312?B?OG5iSVdMTHRPQTFnSTd4dXBUS1hwenZMQTRmMjVsVkJhQVd6TkRjRkFvTE5y?=
 =?gb2312?B?WXRSV3FPVitOdzZwYmQwRWhoTDgrTWtLK1NUUlRyUmNXY1ozVC9mamhIVC9U?=
 =?gb2312?B?M2E0U0l4N1dGV3RKdmVkOVhIU2tETXRKWWpEc0w2aHRsUEVKQTloODc4V2VQ?=
 =?gb2312?B?Wk4yZmxLTzV2YkFsamRIRVgyUnFoMXN6VGoxUWxNbnc4SERzckc5dVpmYmg0?=
 =?gb2312?B?QWsrRzhmdWRrZzhBekk0R0NDMlhTT1hhd0xuellxZUM2US95ZmZCVVU3aSs1?=
 =?gb2312?B?NXlrV1JwaWNZaHZGRXhBT0paUFlBMGppWnorbHBDUzAxUThkbml0YlRkcDBC?=
 =?gb2312?B?ZWRMc3ZIeHluREdDT1ZrWVBCRkdOODhDUHdpV3d0Sy9ySUFrMU83S0E3dWxO?=
 =?gb2312?B?eHdrKzlhaCtodGxYcDVab001NVlxMWpHZzJ0SllqY2kxRmIyOW40c0ZqQkt6?=
 =?gb2312?B?RHNFR0UwSkFHbStsOHpKbEhXR1RVVmFYUVZjTEFmeWRndEhuYng5YUhpTGQ3?=
 =?gb2312?B?V3BlSWRudzVZSkVVYk9WN2ZaWXFkeTdaSi9tUitMUi9tNlM5cEMzWTVJUWlM?=
 =?gb2312?B?UDA3R05McURqakRSbXBZa00wWkxMMjB5MnluZ21SVnNUSStpTkxaVVA4dHJw?=
 =?gb2312?B?cGhraGdhQ29ianhiU3RYZGtzeGpFR0ZKRUsxNm9yTjVIMUFuOGxPTWpqcy84?=
 =?gb2312?B?djZrTnZ5M01EczExSFU3MDAvMDhoVGowaXRIYldwMFpRK3BaWWk0VDNabThJ?=
 =?gb2312?B?YU9HdUp4dFZLbHNiUUdZVythNXlhQWxKV1FGMk8xWldaMTFhTUJicGN1ZWox?=
 =?gb2312?B?TkhxYzFmZ1A0eCtjV0ZXTDFhelJsYzJpNGtGU2NUYUN3UVR5RWsvMDQzSGR4?=
 =?gb2312?B?UVNaRjNpOUloZ0hsY3pFN1dJd3ZvTWxReCs3a2VIVVYvclV4cVpkQWF4R2tE?=
 =?gb2312?B?aDVQUnNHaUI2eGMyM2FRMmJyTnJpREd2M21saEVHcGg3TkF1N3E4cjdiZDMy?=
 =?gb2312?B?ZGM2cEhPM2E4Z0VhaGVvcTRnTHg3RFRtTGxyS2VBTzllZFFROUtXYklkRFl5?=
 =?gb2312?B?bUk3MnJDSWVmZGNKODEwZ29MN05iSUlCNTNqOC9zallDYUQ2QTlHdm1LQTln?=
 =?gb2312?B?UzgzZDBsUVhiNjJQM0hYYndFWE01cCtuT3d6dmU3T1JRV3d4c0RwbXE1aXZ2?=
 =?gb2312?B?dnp2TE4weDhzdGJhbDFIUTVQd0tvcC84aStNSjJvR2pEMEJGczVGUXVOdkJQ?=
 =?gb2312?B?eXE5RlNlZGJVSEhJcUNqbHBUeE04STdQM2FnczZZL1QvNjBXdXhQN0Q0d2dE?=
 =?gb2312?B?T2xkVk5lYlkxSHhyUDhWZDFNTkp0K2grTEdKVVJZOGFlQUpkazNFaFphZmly?=
 =?gb2312?B?bGtnTk9UdjZDTEl4c0pGcSsxdXd2U2ZSRVk4a2pXaHlBVm1KUnJJUENnUEN1?=
 =?gb2312?B?Q0gwck5BMkZZU0hkelBkLzY5Wk1Ua25FTnhYVFpIWjhhS3BUbmtIWGFqMUli?=
 =?gb2312?B?eGV1aEo0UkVGaTRrQ2JmeStIRFJoekk0aGpXYTNsNEJILzQ1QnpPVTFUUFda?=
 =?gb2312?B?VFZmb0NkWU5HNk5kNUloSEtRM3RRM2M5MVZGdzVqNUtFT1AzOUNLalU5Yitt?=
 =?gb2312?B?Z2lxVVA2aWhiYkpHSHJsWExsWFVvcGlMQU1WK1MrQVN0YVdBL1FaN1BiRXFP?=
 =?gb2312?B?c3kyamNtZmNPTHMyVy9xL3k0b3VwOHBHVVM1RzZpNTdkcDhQRDZVaURVcXoy?=
 =?gb2312?B?c0liaEZGeW9GUFhyQ0RndVk5c1VYV1hEQ3pNRUZjNVl5dWUybUcrOEFlN0Zv?=
 =?gb2312?Q?ZQVl6i?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NTdjTit0VjdUb25mWGJhN2haSThaMEQrWVJsbUlIRDBFZFRMVlBOSXZTb1BI?=
 =?gb2312?B?eDBxM2NzU0RscWNOeEJqVlFTVkFMV0JRRkVBbWVHZEFpOUNBUHZlWFA0UDcy?=
 =?gb2312?B?MDdHWEQwMXA5YWNMcURwL1pHN2VLc3dybTQ1RkhSYmxGU0E2WFNRV0diQ0h5?=
 =?gb2312?B?Qjh4K3Zza3pPQU50a2ZKbnV0aDRScGEvdnordXgxL3lhN3Awa2lXQy93L2V3?=
 =?gb2312?B?Q3ZuUGZyUXNjK3pSUDEvTlY4enlpbytsRXJSK1pFYlZGZVcwMHBSL1ljSnJG?=
 =?gb2312?B?WVZHTzJucVgwUnpVT2hrYnJWVnYxTTNZY3lQVFRVRDU4RE5OakM1MXJvVmor?=
 =?gb2312?B?V29LZzlwVU44YlVKWGNMaTVSWmY3S0Fxbm82b3Ztbythcm9NNnBDcXU5TFpK?=
 =?gb2312?B?R1JFalVJUnpwYUVLNWRDakVIREt0TmhBVmdkaEVFNWJ2cmI2UDFxbkNYVHNz?=
 =?gb2312?B?TWgxUkJQTlJmUTE3a1BGVEo0c1RiWE44OGh0dHM5ZWtjTDZhRGdKMXFmVUIr?=
 =?gb2312?B?YWF4QnFUL1RvRWd2V1ZZOEFWekNNRzFtUVRtbWtETW55TEQ0a0p5enNSR2t1?=
 =?gb2312?B?aklxTHEzN2pnYzNSTUhUcjZ6M01TeFZsYkE2dmU4eDZxZUpEUjBoSG5LNE10?=
 =?gb2312?B?eVJDS1VEcUtJVHhGNTNsblFTaXZkRWpqWStFOEhwNTVHek1vdWI5WXpXZGZ1?=
 =?gb2312?B?dnFNd2UxNStVblA2YVhYcHVtL1d2TjhmSDVjNjdtanNZaGhKWmZCS3pHcnJw?=
 =?gb2312?B?ZHk5enJGWVlsT2JydGdZdjdINnpDTld6d3ZWTnV1emRtbEIyR1Zqa3hkbGI0?=
 =?gb2312?B?cU5CajJoOFFVZzk0ajFEVFRDNW5tRE1DS2MwbU9TU2xqSEV6MXFHM2Q5aFVw?=
 =?gb2312?B?bzNNaUF6R29zcXlnN1BIVWZybXl6eVhrMVIvRTVYa3pidWYzdTM5V3U5MWZT?=
 =?gb2312?B?ZnJBL282Z0pjRDZQTTVGZ1BuRytQUG1MRTRPUC9mVTJUWW1BZFRGOVhrL0pu?=
 =?gb2312?B?UW5EOTdBTWNOYXp5SlNyL2pjdVNKSnVta0ZTaTl0MUgvamhoeUlqdVg4S2l2?=
 =?gb2312?B?RUljOEZsY3dTRGE0a1RLTEVBNVVlV29EcEtwellxR0FTT3JLU0orZzREYm4w?=
 =?gb2312?B?SHo4U3lrcE0vNmdhYTVDRTMwdTlhSzhlT3U0TEdJc1JsblpZbjBwSHRRbjlN?=
 =?gb2312?B?SVVxUTA1Umo0bVNpdHZNVnRkdmRGZnRINWFzZGMwWGlDWmliU0sweU55b2VJ?=
 =?gb2312?B?U1Evc2FFUnFUY0RoNWpJeXBXcmhOWG9iTk4rbzFKV2lTOHA0Sk9sMGRWYSt3?=
 =?gb2312?B?dTV2cmVGUHdCQUNMQzBjVG81T0R4RGFhTWdLaXROakxGYVR2NHZXYzdwem9z?=
 =?gb2312?B?amhNaHZmNUJIalVIUEZjME84UldETkpiUmlvR3VWOUtvSFFDb2NOSHVCL0VB?=
 =?gb2312?B?cEExeXJkcTZZZ2FxYmxmODc4c3l4Yyt3UTVWR241SDBySDlKZ1BWNXpVK2NT?=
 =?gb2312?B?bmwrVjh1ZHVqN3ZFQnNTeXpMMGxBTHlFVGU2bmFTcHVXNkNmdFVnMVYzN1cy?=
 =?gb2312?B?ZW5vS2hVeW5uUFFWaktNOUlVOUZBM0hIN2JKSk9kL2ZIZkVuRFJwM25ZQ2JN?=
 =?gb2312?B?OFRGc0k3SWdpV1NIZzFJOU1MUCtOMW5WZW9MLzZPWUdDT0FFY1hzZzIrakhx?=
 =?gb2312?B?akZHN2M0d1ZjS3FRZkt6MHBTdk9LNExBWk1sUUtOS3NreU1mc0ZWSHpPRVBq?=
 =?gb2312?B?ZHRUNkIxWFg0ODc0Z05WanFsZGpFZ0pFSGNHQ2VSNWtBcDM2QkNEMTBhTUJS?=
 =?gb2312?B?SXBoM0o5RFA3SVhZNHIwNHk1aEQyRjlvZW5BRUtQYXZTOGtGek0wcEVCUHJr?=
 =?gb2312?B?bisvMFdZMCtPQSs2aWJKY2p2YjVtbllxUEt4T0E5c2FNalNWMEROZTlONU1I?=
 =?gb2312?B?N3ZJNVhTUTNMb2ZRbU5wckF4QkpveDhCcStGT3dxSmdtTlcrN041eFhQbTd1?=
 =?gb2312?B?Mk40M2N0YWpQWDZ4QlRQQmFnUm5qZmt3bi84enlZVWgvVkQzN3dWeW5oUEpi?=
 =?gb2312?B?ZENuakVTWEFLUWVSWk9IL2h5ZXBVYVRvZlNxaWRTMk50Z0xRNUMxMW9Od1h6?=
 =?gb2312?Q?LP3w=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b46ae2-7679-40da-2d8d-08de20f78de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 07:54:34.1983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DH813UKcs1xrtR2Zdj6ZFEKUs4UVvlW3Si9IcAqeQ8TNeA1ZeaTDJfrSJ6RKqXg/67gL2yX1ukSqjAmb3mMNvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12027

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRv
ci5hbWJhcnVzQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjXE6jEx1MIxMMjVIDE0OjQyDQo+IFRv
OiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyBQcmF0eXVzaCBZYWRhdg0KPiA8cHJh
dHl1c2hAa2VybmVsLm9yZz47IE1pY2hhZWwgV2FsbGUgPG13YWxsZUBrZXJuZWwub3JnPjsgTWlx
dWVsIFJheW5hbA0KPiA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT47IFJpY2hhcmQgV2VpbmJl
cmdlciA8cmljaGFyZEBub2QuYXQ+OyBWaWduZXNoDQo+IFJhZ2hhdmVuZHJhIDx2aWduZXNockB0
aS5jb20+DQo+IENjOiBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDMvNF0gbXRkOiBzcGktbm9yOiBtaWNyb24tc3Q6IGFkZCBtdDM1eHUwMWdiYmEgc3Vw
cG9ydA0KPiANCj4gDQo+IA0KPiBPbiAxMS8xMC8yNSA2OjAyIEFNLCBIYWlibyBDaGVuIHdyb3Rl
Og0KPiA+IG10MzV4dTAxZ2JiYSBpcyBzaW1pbGFyIHdpdGggbXQzNXh1NTEyYWJhLCBidXQgd2l0
aCB0d28gZGllcy4NCj4gPiBTRkRQIGNvbnRhaW4gdGhlIHdyb25nIHNpemUsIHNvIGRlZmluZSB0
aGUgc2l6ZSBkaWVyY3RseSBpbiB0aGUgZmxhc2gNCj4gPiBpbmZvLiBBbmQgaXQgYWxzbyBzdXBw
b3J0IDhELThELThEIG1vZGUsIGJ1dCBTRkRQIGxhY2sNCj4gPiBTTk9SX0ZfSU9fTU9ERV9FTl9W
T0xBVElMRSwgc28gYWRkIHRoaXMgZml4dXAgZmxhZ3MgaGVyZS4NCj4gPg0KPiA+IExpbms6DQo+
ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGZGF0YQ0KPiA+DQo+IHNoZWV0Lm9jdG9wYXJ0LmNvbSUyRk1UMzVYVTAyR0NC
QTFHMTItMEFBVC1NaWNyb24tZGF0YXNoZWV0LTEzODg5Ng0KPiA4MDguDQo+ID4NCj4gcGRmJmRh
dGE9MDUlN0MwMiU3Q2hhaWJvLmNoZW4lNDBueHAuY29tJTdDY2EyOGNhNTlhMTczNGU3MDYyMTkw
OA0KPiBkZTIwMjQNCj4gPg0KPiA0NjRlJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2
MzUlN0MwJTdDMSU3QzYzODk4MzUzNzMzMjANCj4gMjE5MzclNw0KPiA+DQo+IENVbmtub3duJTdD
VFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlkV1VzSWxZaU9pSXdMakF1TURBdw0KPiBN
Q0lzSWxBDQo+ID4NCj4gaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZRJTNE
JTNEJTdDMCU3QyU3QyU3QyZzZGF0YT02ag0KPiBubGcNCj4gPiBsVjRINXclMkJJYjNVYTNhTk9D
bEVsVTBNZklDbnFXWXZqV25SQ0VBJTNEJnJlc2VydmVkPTANCj4gPiBTaWduZWQtb2ZmLWJ5OiBI
YWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4NCj4gPiAtLS0NCj4gPiAxKSBUaGlz
IG10MzV4dTAxZ2JiYSBpcyBwb3B1bGF0ZWQgb24gdGhlIGlteDk1LTE5eDE5LWV2ayBib2FyZCwg
d2FzDQo+ID4gICAgdGVzdGVkIGF0IDIwME1IeiB1c2luZyBueHAsaW14OTUtZnNwaSBTUEkgY29u
dHJvbGxlci4NCj4gPiAyKSByb290QGlteDk1ZXZrOn4jIGNhdCAvc3lzL2J1cy9zcGkvZGV2aWNl
cy9zcGkxLjAvc3BpLW5vci9wYXJ0bmFtZQ0KPiA+ICAgIG10MzV4dTAxZ2JiYQ0KPiA+ICAgIHJv
b3RAaW14OTVldms6fiMgY2F0IC9zeXMvYnVzL3NwaS9kZXZpY2VzL3NwaTEuMC9zcGktbm9yL2pl
ZGVjX2lkDQo+ID4gICAgMmM1YjFiDQo+ID4gICAgcm9vdEBpbXg5NWV2azp+IyBjYXQgL3N5cy9i
dXMvc3BpL2RldmljZXMvc3BpMS4wL3NwaS1ub3IvbWFudWZhY3R1cmVyDQo+ID4gICAgbWljcm9u
DQo+ID4gICAgcm9vdEBpbXg5NWV2azp+IyBoZXhkdW1wIC1DdiAvc3lzL2J1cy9zcGkvZGV2aWNl
cy9zcGkxLjAvc3BpLW5vci9zZmRwDQo+ID4gICAgMDAwMDAwMDAgIDUzIDQ2IDQ0IDUwIDBhIDAx
IDAzIGZmICAwMCAwOCAwMSAxNyAzMCAwMCAwMCBmZg0KPiB8U0ZEUC4uLi4uLi4uMC4uLnwNCj4g
PiAgICAwMDAwMDAxMCAgODQgMDAgMDEgMDIgOTAgMDAgMDAgZmYgIDA1IDAxIDAxIDA2IGEwIDAw
IDAwIGZmDQo+IHwuLi4uLi4uLi4uLi4uLi4ufA0KPiA+ICAgIDAwMDAwMDIwICAwYSAwMCAwMSAw
OCBiMCAwMCAwMCBmZiAgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgIHwuLi4uLi4uLi4uLi4uLi4u
fA0KPiA+ICAgIDAwMDAwMDMwICBlNSAyMCA4YSBmZiBmZiBmZiBmZiAzZiAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgIHwuIC4uLi4uPy4uLi4uLi4ufA0KPiA+ICAgIDAwMDAwMDQwICBlZSBmZiBm
ZiBmZiBmZiBmZiAwMCAwMCAgZmYgZmYgMDAgMDAgMGMgMjAgMTEgZDggIHwuLi4uLi4uLi4uLi4u
IC4ufA0KPiA+ICAgIDAwMDAwMDUwICAwZiA1MiAwMCAwMCAzOSA2MSA5OSAwMCAgODcgOGUgMDMg
ZDMgYWMgYTEgMjcgM2QNCj4gfC5SLi45YS4uLi4uLi4uJz18DQo+ID4gICAgMDAwMDAwNjAgIDdh
IDc1IDdhIDc1IGZiIGJkIGQ1IDVjICAwMCAwMCA3MCBmZiA4MSA1MCBmOCBhMQ0KPiB8enV6dS4u
LlwuLnAuLlAuLnwNCj4gPiAgICAwMDAwMDA3MCAgMmYgY2IgMjcgOGIgMDAgMDAgMDQgMDEgIDAw
IDA2IDAxIDAwIGZmIGZmIGZmIDhlDQo+IHwvLicuLi4uLi4uLi4uLi4ufA0KPiA+ICAgIDAwMDAw
MDgwICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgMDAgMDAgMDAgMDAgZmYgZmYgZmYgZmYNCj4g
fC4uLi4uLi4uLi4uLi4uLi58DQo+ID4gICAgMDAwMDAwOTAgIDQzIDBlIGZmIGZmIDIxIGRjIDVj
IGZmICBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiAgfEMuLi4hLlwuLi4uLi4uLi58DQo+ID4gICAg
MDAwMDAwYTAgIDAwIDBiIDgwIDllIGIxIDgxIGI1IDg1ICAwMCBmMCBmZiA5ZiAwMCAwYSAwMCAw
MA0KPiB8Li4uLi4uLi4uLi4uLi4uLnwNCj4gPiAgICAwMDAwMDBiMCAgMDAgMGEgMWEgODggMTAg
MDAgMDAgMDAgIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmICB8Li4uLi4uLi4uLi4uLi4uLnwNCj4g
PiAgICAwMDAwMDBjMCAgMDAgMDAgMDYgMDEgMDAgMDAgMDAgMDAgIDE0IDAxIDgxIDAzIDAwIDAw
IDAwIDAwDQo+IHwuLi4uLi4uLi4uLi4uLi4ufA0KPiA+ICAgIDAwMDAwMGQwDQo+IA0KPiB5b3Ug
aGF2ZSBTRkRQIGhlcmUNCj4gDQo+IGN1dA0KPiANCj4gPiArCX0sIHsNCj4gPiArCQkuaWQgPSBT
Tk9SX0lEKDB4MmMsIDB4NWIsIDB4MWIpLA0KPiA+ICsJCS5uYW1lID0gIm10MzV4dTAxZ2JiYSIs
DQo+IA0KPiBkcm9wIHRoZSBuYW1lIGZpZWxkIGFuZCBhZGQgaXQgYXMgYSBjb21tZW50LiBTZWUg
cmVjZW50IGZsYXNoIGFkZGl0aW9ucw0KPiBjb21taXRzLj4gKwkJLnNlY3Rvcl9zaXplID0gU1pf
MTI4SywNCj4gPiArCQkuc2l6ZSA9IFNaXzEyOE0sDQoNCkkgZGlkIGNvbnNpZGVyIHRvIHJlbW92
ZSB0aGUgc2l6ZSBhbmQgb3RoZXIgZmxhZ3Mgc2luY2UgU0ZEUCBjYW4gaGFuZGxlIHRoYXQsIGJ1
dCBpZiByZW1vdmUgdGhlIC5zaXplIGhlcmUuDQpNaWNyb24gc3BpLW5vciBkbyBub3QgaGF2ZSBh
IGNoYW5jZSB0byBleGVjdXRlDQoNCnBhcmFtcy0+c2V0X29jdGFsX2R0ciA9IG1pY3Jvbl9zdF9u
b3Jfc2V0X29jdGFsX2R0cjsNCg0KYmVjYXVzZSBpbiBtaWNyb24tc3QsIHBhcmFtcy0+c2V0X29j
dGFsX2R0ciBpcyBkZWZpbmVkIGluIGZsYXNoX2luZm8tPmZpeHVwcy0+IGRlZmF1bHRfaW5pdC4N
CkFuZCBmbGFzaF9pbmZvLT5maXh1cHMtPiBkZWZhdWx0X2luaXQgY2FuIG9ubHkgYmUgY2FsbGVk
IGluIHNwaV9ub3JfaW5pdF9wYXJhbXNfZGVwcmVjYXRlZC0+IHNwaV9ub3JfbWFudWZhY3R1cmVy
X2luaXRfcGFyYW1zDQpJZiBubyAuc2l6ZSBkZWZpbmUgaW4gZmxhc2hfaW5mbywgc3BpX25vcl9u
ZWVkc19zZmRwKCkgd2lsbCByZXR1cm4gdHJ1ZSwgbm8gY2hhbmNlIHRvIGNhbGwgc3BpX25vcl9p
bml0X3BhcmFtc19kZXByZWNhdGVkLg0KDQpJZiBuZWVkIHRvIHJlbW92ZSB0aGUgLnNpemUgaGVy
ZSwgc2VlbXMgdG8gbW92ZSB0aGUgcGFyYW1zLT5zZXRfb2N0YWxfZHRyIHRvIHNwaV9ub3JfbWFu
dWZhY3R1cmVyLT4gZml4dXBzLT4gbGF0ZV9pbml0IG9yIGZsYXNoX2luZm8tPmZpeHVwcy0+bGF0
ZV9pbml0Lg0KDQpJIG5vdGljZSBtYWNyb25peCBhbHJlYWR5IGRpZCBsaWtlIHRoYXQsIEkgd2ls
bCBhZGQgdGhpcyBjaGFuZ2UgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KUmVnYXJkcw0KSGFpYm8g
Q2hlbg0KPiANCj4gZHJvcCB0aGVzZSwgU0ZEUCBzaGFsbCBoYW5kbGUgdGhlbS4NCj4gDQo+ID4g
KwkJLm5vX3NmZHBfZmxhZ3MgPSBTRUNUXzRLIHwgU1BJX05PUl9PQ1RBTF9SRUFEIHwNCj4gPiAr
CQkJCSBTUElfTk9SX09DVEFMX0RUUl9SRUFEIHwgU1BJX05PUl9PQ1RBTF9EVFJfUFAsDQo+IA0K
PiBEcm9wIHRoaXMgbGluZSwgbGV0IFNGRFAgaGFuZGxlIGl0DQo+IA0KPiA+ICsJCS5tZnJfZmxh
Z3MgPSBVU0VfRlNSLA0KPiA+ICsJCS5maXh1cF9mbGFncyA9IFNQSV9OT1JfNEJfT1BDT0RFUyB8
DQo+IFNQSV9OT1JfSU9fTU9ERV9FTl9WT0xBVElMRSwNCj4gDQo+IGNhbiB3ZSBkcm9wIFNQSV9O
T1JfNEJfT1BDT0RFUz8NCj4gDQo+ID4gKwkJLmZpeHVwcyA9ICZtdDM1eHUwMWdiYmFfZml4dXBz
LA0KPiA+ICAJfSwgew0KPiA+ICAJCS5pZCA9IFNOT1JfSUQoMHgyYywgMHg1YiwgMHgxYyksDQo+
ID4gIAkJLm5hbWUgPSAibXQzNXh1MDJnIiwNCj4gPg0KDQo=

