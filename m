Return-Path: <linux-kernel+bounces-864216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E4FBFA325
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912E71A0225B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4BD1DA60F;
	Wed, 22 Oct 2025 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="IbmxjWeP"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021081.outbound.protection.outlook.com [52.101.65.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68867284881;
	Wed, 22 Oct 2025 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114026; cv=fail; b=K2O9vZfNNEWhvcsYWi8Sj+m64qY6SGB4Jvr9ix1Cu/VWRXODAGNMUmX+G3a+P1IkrIizhJU88nbYaLSEmRVzx9dkG4UrNhgjVmZ4yBO+IDyBdsLC0XkimWBS7loD2oPmOV1w7O3PrE3xBnYfmM0Kt1nQmXsP1ocDsV55ZPhR9X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114026; c=relaxed/simple;
	bh=vBco3NeTXGBhvvTfOtp+NdNWP1sn/96SNy+6dgkVpLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GtjZny9Lg7SU8Rf1Wl6Q6FFngWztxRYT2NbWivLVsTHC2CdrYM58SHmg6OGtO9DX1R2tPUl9YPgyy7YWAjEgrS0iIllK97+h4Z91BGtqjR+NA01qvgenbzdFRHZROfJyBiac4jYeJ5zGsZh7zkd54IxY4RQJpkcR/xOiBezjgxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=IbmxjWeP; arc=fail smtp.client-ip=52.101.65.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGqdvTN33RaUu3z//r0N+L0f1mjfoSYz/7H31L9V+JzcnLpQ+2b2LO1OddLSqOLsBT0hbTPs782OYDRpYhmMLA0RrxChMtt8v1MV2RjmzzKFTNfGxUIP9vhEsmLdUfLU/DbNAPVs7+sjLrAPfrkucXxgcrhwAoYDhaeuucMd2+WVfpiFj52fxvds6IfqtfdcZ9uSOqx9DArxvJaK2UoASYvvM+LO5MlljqIPzUGv8gYAoqWnKYYFe3TeoUqr/PBNeE+o9UwLGFdaoEJsDjT/sCMQgTxkjd5Ve5qXez7fa3piviE77cTs3i74iomjL4NB2PhRiduWg2DWxGl95p7u0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBco3NeTXGBhvvTfOtp+NdNWP1sn/96SNy+6dgkVpLk=;
 b=V+m5gaEdSBInH63FcPy2RCnGUp856xYZP5FWCFcjEn4SdfR6E9Hqe574fcsIi0Pj4xqnwkbYs411rfJQwXSfU/RMhWBDc48jpHNXh0d7bXSgVWz4ypLgkLtMqfMagaFnwpZkDtQigGa8ZBSeept/BId4J83M6qy/RW/CsL5VZPrWX2Et8fS0pQGgPjiWKIktlNyMvh8riLqVJuT4NnSYVQ9VmFBE76B4tsycxkx4uAPSYQ660+gjHq3tHudt6wNOV8K1TwtxTTHiqcDnPoqwsg/S6LTN9kKVJSgqHJlMln9QfiGsW5VPzjgBIfuEfF7U+tNrQovzP7v3QSEvlW2XlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBco3NeTXGBhvvTfOtp+NdNWP1sn/96SNy+6dgkVpLk=;
 b=IbmxjWeP/cp7V0qxsemJ79mzuFxbMyISEPvHAvCJPXOoNeUBiso6DOfv/MsDA9HsbfSOtz4cQo2ubAgbjjC+Nk+w5rl8ozb1oN4Nhj6rgjDM+bBlCzvO2mYKv89lg1scCoqOVWwkgaNqJracXFIl085OPXWb9A0T6htdNYwkGZRwXF+ZjK938+u6+Y68BGvMHJ1ekJloj10X8G5204khldlNXmZCL70Dvag+onD0BEz5n9QNSYUJGqKZMkrXFKTMQryKp6Fg+Yl4mha1O4C1vE5fduEBY2LmuuneXuM2l5NTlDhX8iL8nCSv3fofi0/L41HkQXfuksnRQmYr5l7w3g==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AM8P195MB1011.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:20:21 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 06:20:21 +0000
From: Yannic Moog <y.moog@phytec.de>
To: "Frank.li@nxp.com" <Frank.li@nxp.com>
CC: Teresa Remmet <t.remmet@phytec.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, =?utf-8?B?U3RlZmFuIFJpZWRtw7xsbGVy?=
	<s.riedmueller@phytec.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "robh@kernel.org"
	<robh@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "upstream@lists.phytec.de"
	<upstream@lists.phytec.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/4] arm64: dts: imx8mp-phyboard-pollux: Enable i2c3
Thread-Topic: [PATCH 3/4] arm64: dts: imx8mp-phyboard-pollux: Enable i2c3
Thread-Index: AQHcQcMPMcvZHtM34EitYqj/VkPsgrTLK5QAgAKIxwA=
Date: Wed, 22 Oct 2025 06:20:21 +0000
Message-ID: <8269481ecde6757a18f08ab76e35a8689f48a58e.camel@phytec.de>
References: <20251020-imx8mp-dts-additions-v1-0-ea9ac5652b8b@phytec.de>
	 <20251020-imx8mp-dts-additions-v1-3-ea9ac5652b8b@phytec.de>
	 <aPZXaC8HL+Rg7rax@lizhi-Precision-Tower-5810>
In-Reply-To: <aPZXaC8HL+Rg7rax@lizhi-Precision-Tower-5810>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AM8P195MB1011:EE_
x-ms-office365-filtering-correlation-id: 4cd99b7e-d02f-4a29-0127-08de11331423
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnduZW9ibUR0a01Md3dOYU5WZC9seU5iWDJGNGozS28raHlhOWM0RXVQcUxF?=
 =?utf-8?B?NUNwQlNCS2Yxb1hLM2dndjBYeWw0a2UwL3FXTFMxdFlrZEJVQUxYVnhGalkv?=
 =?utf-8?B?TENaeXpKb1dCYXpsNk4vc2Z6MzU5aUpPWlpmTEsxRTcwY1lZUFVYN0dzZDAv?=
 =?utf-8?B?MnNlRnBQMlJlSlBXeVN6ZHZndjdFc3B4Q1ZzZmhnVDhGQnczMFphWkZSQzVl?=
 =?utf-8?B?NCtjb1kzKzJHOUZ3WFRQZmk3YUhTSHBxeEN1Z2tMR3FHSjFZMnl1K2hYQmNW?=
 =?utf-8?B?VkhNb2lkTTU1MHZQTFRJK1VhQnZrWFpOV01RVTA0d3ExSW5zZEJNUlU1clhJ?=
 =?utf-8?B?dWpkT1NTb04wb256TGxHeGEwYXdHYlA0MFhMZE83Qk9BSzBIelBQT3pwYTYy?=
 =?utf-8?B?MzBVVUMwbTdwaVFabTFSZWZ6NGNaZVFSZk1NUE9MeVpHenNUU0Y4bit1MjQ4?=
 =?utf-8?B?L0RjSlFkd3NnVi96R1l3VzlkMWYwS3kxOUxzTndtaXNIOEFjdWVjYndNOVc3?=
 =?utf-8?B?amplYWEvOWlOS2JBajRvQ0ZMdUhGZFozbmhDRW9ESmx2eUJ6NVZmQU1ZQmdv?=
 =?utf-8?B?WDQ5U3p3OCt3SW9LR1QwWjVBQ0ZRMHlHMWt0TXAwWHFnRU9jQWt4bGNSaGpZ?=
 =?utf-8?B?YmpIZ2dDUEN5UnFGWFNhOFdJUlRkc0dVODR3MTFFNTNvYmdiQ2xQbFNJcXBC?=
 =?utf-8?B?a0VrQ1g0NThwS2dqTmdJRmtNRTBPTWl1YzJJSHBqZWRCUlBlZW56dmVINHUx?=
 =?utf-8?B?R0U4My9Ca1V5cjV0bVJvTWVOQmtyaXpYZWg5N3FaU1BFZjdMWEFQMXZ4VWFv?=
 =?utf-8?B?VUNJY05zbXFFc29kdjBRbVZtSTJYOU5zWWR1bEpqZ3JXcVIvYytOdEdTMkhO?=
 =?utf-8?B?dnQ2d2c2bzRuVkQ0Uit2OHJFck16SkFvRE5aaGVMQS9nSXNXdEM2bzJFVEhQ?=
 =?utf-8?B?NWN3OWkyeVFza1RnTVQyUTQvUklLSjkrYXNqV3NpWTl6a3A2Rm1QR3lWVDFk?=
 =?utf-8?B?a2RQUGZYSUhQOVZiUFpweDV6OTlFTGlSd0pGcVIvTy9VcWhHeVJqWmpQb05u?=
 =?utf-8?B?SDZZNzhjUG0rK0RsL1RNeFI3MHZWdWtoUFE3bHljS0ZWWWlVeW5oYTNpU0pW?=
 =?utf-8?B?L0xXR2VXQnh4YmhGWTlWbjhKSVlKM3RJWkFxNzBRRXIyU1RkQm5LdkhQQUlW?=
 =?utf-8?B?T2pyVlpLZ0RMSmI4L0FXeVNObUpKd25OWXBKQ1FzQVVzcjBmQ0x2OVllTVBp?=
 =?utf-8?B?SnVTZXpObVNpajBOeUF2MFpsT1FBRW1XSy91UnN5OXJlRUpHR01sZFYwQ00x?=
 =?utf-8?B?dE9XWVZHa0ltbkhWWm04TXRaUWRNaERRWU5PRTM4ZWVxT3dkMHUyaUxnZ3Nh?=
 =?utf-8?B?WittM2VURmpWMXZXOGxLL1FDZDdrSXYyLzFTczZOYk5tWW56OVpQU1JZTkN1?=
 =?utf-8?B?L3Nhb2NTVEV0Vk4zQlpDTHBhUGRRWkNQR2tMUFIzLzNGS0VNbWM1ME9PeUxp?=
 =?utf-8?B?bHBSdW5VSHhrbHN6N2RrWWJ6TGVIVE1sNTdoTTAzUld3WnRkV0lQdDNMby9m?=
 =?utf-8?B?bWxCOUFEZ3NnSXZWckI5YU1lZjVOT3E0eVpXeTAzelNVTVcydGtjdTJpbGFI?=
 =?utf-8?B?amJVNkN5L0tQSkhDencrQ3N2Z2NpaFM2Ymx3SlNrS3IxZE5HRjVHMk9UdXgv?=
 =?utf-8?B?cjNMYlR4ZXFBQXppRytUYVF0ems1azBjL1dKNTNjK3I1bk85am1yOGhXNkQ3?=
 =?utf-8?B?T2ovTW1YbDRGZG92ZTdEWFdOMW81d1NFd244S0QySEloWkpSS3V2MWFnckZE?=
 =?utf-8?B?Q3JtN05WY3ZicWszZjFwQmZON0xicDduYW5yb2tScjk5NEFPNnZrZGJkQXFL?=
 =?utf-8?B?OE16ZXZyS0pyczFTQmxZNnp2aEo4NzJrMjkwVXg4MUMrWlQ5K1RzeVR4TUk1?=
 =?utf-8?B?WU1yZTBmb0lqM0w1amZQdVdjQ0dKeUpaQ2VjeWdyWTRVK3JUVVMvUktRNThu?=
 =?utf-8?B?eFVzMytYZzhtK09qV0JuUzlaSVhXRWRFa0R4Zis1dVVRQ3dFS2E1d3ZlMys4?=
 =?utf-8?Q?JKopMP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDRzbXE3Smgyc0d4R0VCU21hNXN4Z1I0TlBGaklac2RGL3BEUm50QnJMNWVn?=
 =?utf-8?B?Z3hlQWpBRFg3amhWM3Z2S1YxTUltQ3o2bXQvWmNielF2Vnp4Uy9rc1VnQldC?=
 =?utf-8?B?U1d5VUhHdUswWExsN0s1ekdNaGg4RzArblB3TEhsYnJRR0dkYk1lM01tWmpW?=
 =?utf-8?B?c2tVc1BXaTJkbjlvd01UTW9hMTlkdDRTdWRnOCtDcnVJU2hDZGJVeU9OdzBt?=
 =?utf-8?B?bkFyQXFCeXovOUUrQWhjYjQ4S2ViYW1qcUJPMFAyR3BPNEg1MC9ZbVI3bXdq?=
 =?utf-8?B?Z2EyV3pPOFdXRnYwTlU3ZWRkc2FtbzlBZzU0QzkvTi9CcFZ4Rkp2RmxTK09i?=
 =?utf-8?B?andxSDFZcVVnYWpTUFRhLzRxR1g1T3NYWGtOODhZTGhOK0h6dWIrOTVkNnZS?=
 =?utf-8?B?S1ExVjJGU3laTlpYZFFGNGh3SDU3NXluKzZ1N1FCZEJObFhlTWpwNENKUVhu?=
 =?utf-8?B?SVJNQlFYRWpLcldtc1o4VFVGclFHU3BpeVNDWU9kcm1xb0M4TnMzZWFDdGlU?=
 =?utf-8?B?M1BQaCtQWlA3NGlQMXE1V3NYTUd4cTFDdThFdk5uSU8wQ1Rod0t3dDFmeVg0?=
 =?utf-8?B?S0p0Sk1PbHhIcm92YndKK1d5L2V1ekdob0YwamsxMFFXWWRvU0JPdEhTY2lh?=
 =?utf-8?B?dEtwcURqd2tOZmNGUVNRMGd5NDU1dUxIb0JJUEpmcTVVMmh3RUJMb2Z5RFp6?=
 =?utf-8?B?UURMWWRHNGV3TnhPTEVCeElKNmliT0NwS3lOeEVidEpPZVorNTEyM3VIMkgz?=
 =?utf-8?B?eWVZSnBCZXd5djlwQ2Y5Wlg2TVgvQ1lRMWRoL05RR3FLb2ovVGNtTFR2L0U4?=
 =?utf-8?B?Uzk4NEpyUzhYVlpRa3V5eWNQR2Jqa3JWZjI0MVlrdlR1eGVCMXJuS1lqSUNk?=
 =?utf-8?B?ZnhmcWphMGhlSHhFMEZwTTVDRzU0RWZYdlJKSXg3eVpPQkJCb0h3ZjJpbUJp?=
 =?utf-8?B?YjV1L0xPcUMybmgvSytGMXpPaHpsbjlWYklVaysxK3k1Mmc1MjJDNmF6Sk5m?=
 =?utf-8?B?YmpvMDBtb0ZtTWFmdlJPSU41c0lNdjhldmluc3hGZzFvOTJGWFY3VlI3VG1s?=
 =?utf-8?B?d1U2SXc0VmFuTldoMGJIVkxUWWVNTGhXdDNzSWlVTkFhZEd5K2Z5YTN1R2tJ?=
 =?utf-8?B?V0pqbG9aWDRmbjhhV1dGUWQ3UTF6MVZhakJ5a1ZhVklFMFVmVHhTSVZ6Slpw?=
 =?utf-8?B?cEdYZUZkb1N1dWdGRFJYL1NWTlRQK3pOSjVZQy9RdTBXalc3NXpjd3FCUVcy?=
 =?utf-8?B?N29zV0tYVzJtdFFMK3NPSy9zZGJtemVsVTZXSGh2SjNSdXRTZWtucHJCT3pX?=
 =?utf-8?B?ZDFPWmVobndTT3JKN05Pais4TXR1WjN5TncrUG13T1pYaDJpZm10SE9meXJl?=
 =?utf-8?B?V0hFTmYyd3QwRHkyTFJIZS9MQ05ZTUFOTVJORVo3L0NWZHhFb1htTkNNWHAz?=
 =?utf-8?B?T2ZwWkZicVlIRTdtek5YanpSSytBUU9RK2h1b25nTExpYi9reEFpbjA3K3VM?=
 =?utf-8?B?YWxka1V5V2RxTUFURVBwVXkxbWZ6cFlOZGh5VXNvVjJqa1F0dVJGWEhIbmtS?=
 =?utf-8?B?T0N6bVVxK09kWmhkTXl4M3VJSmxzcndmaHpFWWJ4Z25oZmVHbkNEdzlYOVUv?=
 =?utf-8?B?aExUVG4yMzRjWmV5Qjk5U2pOeXBmUlhPajRqYlhJV2NsUEQzcXlIS3dCM2ts?=
 =?utf-8?B?WEUvM3lJcEJjenlWdFhJNmlqNE1mNUh6ZFFaUW1jU2FqZmdWVTdDRGIrMjRY?=
 =?utf-8?B?bFA4eU9USVlyQjdiOUxZZDVKZm8zajhFVm5tTnVDcVBxUTJmNlpmV1MycVhk?=
 =?utf-8?B?S3N6a2I0cTlxMmU2RlM0UnBoTWVjS1hsUWdwTnNqNEhabzhMVzRqOXFreC9Q?=
 =?utf-8?B?MVFVeFdqb3BMNWxxVVNXZWNxQ1F5ZGw5L3gwa0VVYjN1b1pOS0hFTjhaOHRo?=
 =?utf-8?B?cnhiNWU2QlNpWmY5UHFYZERJVU9CdkM2MURGWkhJNlB1V0J4Zkh2WEIzNVE1?=
 =?utf-8?B?dmx0VUVTZmhLU0NoME1pSTN6NStlZTlLR2RtbkUyNGNhc21ESDBRMWhMdWIw?=
 =?utf-8?B?R09CMm9RVllMWDJyVUtYZHVrNGdoUEwwVmFLcEt2WWU2VzhHMjdXeGgzcDlj?=
 =?utf-8?B?RjB5NXZNdE1kWjJ6NTNYcWdidkRBamowdVJOMmhZNXlyUmlQMGk0WHRwMDhY?=
 =?utf-8?Q?eZxwPja5bn9gA1wgphHRoXzxuECbTiz9XaTMBjny92I+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C981C883B2662B4CAD1963A63544F7C9@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd99b7e-d02f-4a29-0127-08de11331423
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 06:20:21.1812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TOs9LPAWE5ImEJ/CQ0TugbXwIIs5LGf54yzlLb7EY0DIehk8eqQRa2XJu3JwGhGDSafTKXXpxJlcPWwZWgJp/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB1011

T24gTW9uLCAyMDI1LTEwLTIwIGF0IDExOjM4IC0wNDAwLCBGcmFuayBMaSB3cm90ZToNCj4gT24g
TW9uLCBPY3QgMjAsIDIwMjUgYXQgMDM6MTE6MjRQTSArMDIwMCwgWWFubmljIE1vb2cgd3JvdGU6
DQo+ID4gRnJvbTogU3RlZmFuIFJpZWRtdWVsbGVyIDxzLnJpZWRtdWVsbGVyQHBoeXRlYy5kZT4N
Cj4gPiANCj4gPiBPbiB0aGUgcGh5Qk9BUkQtUG9sbHV4IHRoZSBpMmMzIG5vZGUgaXMgdXNlZCBv
biB0aGUgQ1NJMSBpbnRlcmZhY2UgdG8NCj4gPiBjb25uZWN0IHRvIGltYWdpbmcgc2Vuc29ycy4g
VGh1cyBkZWZpbmUgaXQgc28gaXQgY2FuIGJlIGVhc2lseSBlbmFibGVkIGlmDQo+ID4gcmVxdWly
ZWQuDQo+IE5pdDoNCj4gDQo+IFRoZSBpMmMzIG9mIHRoZSBwaHlCT0FSRC1Qb2xsdXggaXMgdXNl
ZCAuLi4NCg0KU29ycnksIEkgY2FuJ3QgZm9sbG93LiBXb3VsZCB5b3UgbGlrZSBtZSB0byByZXBo
cmFzZSB0aGUgY29tbWl0IG1lc3NhZ2U/DQoNCllhbm5pYw0KDQo+IA0KPiBSZXZpZXdlZC1ieTog
RnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFN0ZWZhbiBSaWVkbXVlbGxlciA8cy5yaWVkbXVlbGxlckBwaHl0ZWMuZGU+DQo+ID4gU2lnbmVk
LW9mZi1ieTogVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVjLmRlPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPg0KPiA+IC0tLQ0KPiA+IMKgLi4u
L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRzwqDCoCB8IDIzICsr
KysrKysrKysrKysrKysrKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25z
KCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLmR0cw0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRzDQo+ID4gaW5kZXggNjIw
M2UzOWJjMDFiZTQ3NmYxNmY1YWM4MGI2MzY1YmNlMTUwYWUzNy4uN2QzNGI4MjBlMzIxM2EzODMy
YzViZTQ3NDQ0ZDRlOWM2MzZhNjIwMiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMNCj4gPiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5k
dHMNCj4gPiBAQCAtMjI4LDYgKzIyOCwxNSBAQCBsZWQtMyB7DQo+ID4gwqAJfTsNCj4gPiDCoH07
DQo+ID4gDQo+ID4gKyZpMmMzIHsNCj4gPiArCWNsb2NrLWZyZXF1ZW5jeSA9IDw0MDAwMDA+Ow0K
PiA+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgImdwaW8iOw0KPiA+ICsJcGluY3RybC0w
ID0gPCZwaW5jdHJsX2kyYzM+Ow0KPiA+ICsJcGluY3RybC0xID0gPCZwaW5jdHJsX2kyYzNfZ3Bp
bz47DQo+ID4gKwlzZGEtZ3Bpb3MgPSA8JmdwaW81IDE4IChHUElPX0FDVElWRV9ISUdIIHwgR1BJ
T19PUEVOX0RSQUlOKT47DQo+ID4gKwlzY2wtZ3Bpb3MgPSA8JmdwaW81IDE5IChHUElPX0FDVElW
RV9ISUdIIHwgR1BJT19PUEVOX0RSQUlOKT47DQo+ID4gK307DQo+ID4gKw0KPiA+IMKgJmxkYl9s
dmRzX2NoMSB7DQo+ID4gwqAJcmVtb3RlLWVuZHBvaW50ID0gPCZwYW5lbDFfaW4+Ow0KPiA+IMKg
fTsNCj4gPiBAQCAtNDQyLDYgKzQ1MSwyMCBAQCBNWDhNUF9JT01VWENfSTJDMl9TREFfX0dQSU81
X0lPMTcJMHgxZTINCj4gPiDCoAkJPjsNCj4gPiDCoAl9Ow0KPiA+IA0KPiA+ICsJcGluY3RybF9p
MmMzOiBpMmMzZ3JwIHsNCj4gPiArCQlmc2wscGlucyA9IDwNCj4gPiArCQkJTVg4TVBfSU9NVVhD
X0kyQzNfU0NMX19JMkMzX1NDTAkJMHg0MDAwMDFjMg0KPiA+ICsJCQlNWDhNUF9JT01VWENfSTJD
M19TREFfX0kyQzNfU0RBCQkweDQwMDAwMWMyDQo+ID4gKwkJPjsNCj4gPiArCX07DQo+ID4gKw0K
PiA+ICsJcGluY3RybF9pMmMzX2dwaW86IGkyYzNncGlvZ3JwIHsNCj4gPiArCQlmc2wscGlucyA9
IDwNCj4gPiArCQkJTVg4TVBfSU9NVVhDX0kyQzNfU0NMX19HUElPNV9JTzE4CTB4MWUyDQo+ID4g
KwkJCU1YOE1QX0lPTVVYQ19JMkMzX1NEQV9fR1BJTzVfSU8xOQkweDFlMg0KPiA+ICsJCT47DQo+
ID4gKwl9Ow0KPiA+ICsNCj4gPiDCoAlwaW5jdHJsX2x2ZHMxOiBsdmRzMWdycCB7DQo+ID4gwqAJ
CWZzbCxwaW5zID0gPA0KPiA+IMKgCQkJTVg4TVBfSU9NVVhDX1NEMl9XUF9fR1BJTzJfSU8yMAkJ
MHgxMg0KPiA+IA0KPiA+IC0tDQo+ID4gMi41MS4wDQo+ID4gDQo=

