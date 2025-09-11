Return-Path: <linux-kernel+bounces-811595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2394B52B44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED7E1C82F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852ED2D6608;
	Thu, 11 Sep 2025 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reversec.com header.i=@reversec.com header.b="wuDONYzR"
Received: from GV3P280CU006.outbound.protection.outlook.com (mail-swedencentralazon11020100.outbound.protection.outlook.com [52.101.75.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535862D6605;
	Thu, 11 Sep 2025 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578272; cv=fail; b=APkkvW77Y6IjHI+LsoqRa7cOSJvH/2zow9OysxcYrhC1hQQuQXF780id9MzZe2QXA9RpBkWBZtlanHa6BeXb772tDDnMuMcejP+I/TZRxHW/Ge4leWzTkpJKg1RNPrTaRWhE/BjDKzkbc2q1QTKLYXj35IXMAWWuOfT1IgfT6cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578272; c=relaxed/simple;
	bh=oVY6KNhVhoxwo2tm8yTfDrVWQCsyvQmFgqGu5nMd6eY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AuDAdJY21aMmagyN2xxUPgdT9FC5MrOOGvtKnTt1ggGf5CcoCVFqR8NjaKxyN2RC7o5xSpJP9qJXB/OvZRUwtt8Cb+uH9sekKC+dhVb6XUUqY0nsRAo4vZqxilkWa7JCuBB+KUXu0lKGxnZncUED/Tw4DWK9I3h6s6jEG73NRro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reversec.com; spf=pass smtp.mailfrom=reversec.com; dkim=pass (2048-bit key) header.d=reversec.com header.i=@reversec.com header.b=wuDONYzR; arc=fail smtp.client-ip=52.101.75.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reversec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reversec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJnepLMf1arhdaz0p4xVBMrAyyRKTyqD+am5pRyq9WEWtpsoT8KlDSvwDWiAHL4gdeAnga5fNK6TgQOlGc2I/uLcOic6vSOx9nsG0tTnpe9i+fHML6DG7dDEnM0aiQRQTpVZEDEHNr4MBLvDGJjDIKsEjcEZQ1LBtSo4OwebEHl8Pm754+0ZY81lPnr4Md6/R/yeAqJpe2LjZMHGGgh0r5dOdGXWv3crhw2mm/sNwurThMaF6//f8Jli9cQJ8WVzOpQk/oztv21XYhTK3kgc3tLVkOe74fLt6h1f9N7WOJ0CLymRSyGF5QmeqkFp+LRMTvWj/eteJ35bnDgSghFanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVY6KNhVhoxwo2tm8yTfDrVWQCsyvQmFgqGu5nMd6eY=;
 b=VgAmS3O+G5KUZxD5Lp2REp8CahJJexlq3zxcPYuADxLPBxgI2epG6/ZP1d/bBnqGLUepDwcXEFRz3R3GhclK2o/fjMO1u5HaWAyBPQzZdpkG4K4l0e0vN4K4V5R//nYyqFQKhg+nDl6S49L4BSEyTW6/l2pcrCbfCqzY+P5xJvMtxWMHotW4rfrqoj3j7VHMR9UEeNOM5is1VqqMAY/jaNWNS7vF0o+/MzA+NLgkW0dFD/BnkcWR/vW5AT7N5MLCudUyATYlMcDb8q5Q+MBh6AMa9GXdbUyGsxWUlXVLyRbQYgmOs0bXDL8lhLX6s7F39RJFNqslfPHBJ8uUD28/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reversec.com; dmarc=pass action=none header.from=reversec.com;
 dkim=pass header.d=reversec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=reversec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVY6KNhVhoxwo2tm8yTfDrVWQCsyvQmFgqGu5nMd6eY=;
 b=wuDONYzRuY3uF9ks/AmWSUvc4MilW0h8Ci7IYSvhbJLe2f9TPP+8ZMkrAF9/JWeqm+GhODXAzcmhxhRs47Mvznh45IY4n9/2hLh4wjhJDXNUKxzMNMUrONM7H4vjK7b7DAAqmg2hTFFxK/XhRvZwt5UWdw6lWbeJDeaKFuoDAvnBUaR/l4ms0k9az6X5q4RUsyMspQ1TNQSetTdu/XdydYgBKPojgkKYJ+3M1UDLIfPSOM1uaNX0amMeMFKp+6+JPBJQBq/lMzCZrb8FYz0OmqT6ecFTHrI5YIFzfwzK6mK3Dhr9efaSJQOgqU3riQr6U2RERv4CKznM1P6tnosnMA==
Received: from GVYP280MB0715.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::9) by
 GVYP280MB1019.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ee::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 08:11:05 +0000
Received: from GVYP280MB0715.SWEP280.PROD.OUTLOOK.COM
 ([fe80::dfb5:ad6c:275f:bfc2]) by GVYP280MB0715.SWEP280.PROD.OUTLOOK.COM
 ([fe80::dfb5:ad6c:275f:bfc2%2]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 08:11:05 +0000
From: Andrej Rosano <andrej.rosano@reversec.com>
To: =?utf-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrej Rosano <andrej@inversepath.com>
Subject: Re: [PATCH v2 2/8] ARM: dts: imx53-usbarmory: Replace license text
 comment with SPDX identifier
Thread-Topic: [PATCH v2 2/8] ARM: dts: imx53-usbarmory: Replace license text
 comment with SPDX identifier
Thread-Index: AQHcIvOdZqmmxaguvU67FzG2IA+/dw==
Date: Thu, 11 Sep 2025 08:11:04 +0000
Message-ID: <aMKEF4wAeET3Ntus@stjenka.localdomain>
References: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
 <20250814-imx-misc-dts-lic-v2-2-faff7db49a5f@prolan.hu>
In-Reply-To: <20250814-imx-misc-dts-lic-v2-2-faff7db49a5f@prolan.hu>
Accept-Language: en-150, en-DK, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=reversec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVYP280MB0715:EE_|GVYP280MB1019:EE_
x-ms-office365-filtering-correlation-id: d4cc1a36-84fe-4d13-1206-08ddf10ac129
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0srSFNGM1lFUG92RTBwNXkzR0VpTDNzNkVrOWc0NjlReldraEhSTDlUdkth?=
 =?utf-8?B?REZaeTRXWVNHUWc4QkJ1Sk9rbzNvY1B2d2JBKzdwVlorQTR2Ry9hSHpjQ0dN?=
 =?utf-8?B?UjBpSnZ0Zk9WWVBqOXlGNEdESWxqWmhOMGpldjlZN2xGdC8ydnR6R1AzRGpk?=
 =?utf-8?B?NEhmTm9WUWU0dE13dE1jSkx0Y1lpdnhhZFlmbVprT3VGY1ltVU1YeklnbHZ3?=
 =?utf-8?B?eWdyWGhYTUZkSjJKNEJoYWJIMC9wd2RJQUZkZ0pMSWxMZmVOSms1a3JnM1JO?=
 =?utf-8?B?L0hnT2JXcjdiUERVK1pjMmc5Wks4VnJGckpWZng5OHpZdWhOckQ1R2VKVStx?=
 =?utf-8?B?NXlGbXNYT2pGNndQWTBMcjdVWTgyMGZTcWl3SW83dDViYjlmbTFncVVhNC9C?=
 =?utf-8?B?T1ZkR1VDNEN3SjU3R3FDQVFrcHZCZkt6Zk9SODc5c3FkTmZPWTBFN2pBOHJ2?=
 =?utf-8?B?dG1OMzE0MTdYT3lnYUZXdEhFRXF3cmpHek95SDgwQUtWMnFvZEc5dExaSjNv?=
 =?utf-8?B?YnJrTGhHMlhJVGZWN0RFeGNMRGZzZE0zeFZUMjRneEwzLzFHWGEwRVY2dXNn?=
 =?utf-8?B?SmlLY28xQVlNa1A3bzdsYlVpdFRKby8xZjBuWEYwWDdYNmF1S25oMU90Q1N4?=
 =?utf-8?B?V0N1TE5BVW5NbWVSWUZKUXZuVDBUcUc1TTJpK1FSVC9wbEhlTkM0OHMzRXRw?=
 =?utf-8?B?TUhiUk9QejhjQ0dtNnV4aVdxYURWbWtUVmxhTHBwb3dsY1d1c2FNYXhZQXhM?=
 =?utf-8?B?MEFnRHpFVGJVOGRMZDVnNVhVM2Z2bm55MkJnZDNwUjBWR3NySjhsRmlUUFIy?=
 =?utf-8?B?NHlCMk1kQ2x4SG03SXlYY0dzMVMrZE85U1pXZVFWM2lvSjBMem1mVUdjb0U1?=
 =?utf-8?B?RzhnZUpleUpRRmhrVGFxd0NvZ2phaFdiQlNtZ0V0S1lBQlQrVHlSWDV1aXo3?=
 =?utf-8?B?MUgrZzZBY3h3TDFVY1cvdVdrMVQ4RUxnd3NBL0NOTjE1KzFLMkpEbEY0VTlq?=
 =?utf-8?B?NlJHbUZFVGhNbnVVT01kY0F1RFBtZXZUcStLd0NFNjQ5eFJhKzhYVnNpYy96?=
 =?utf-8?B?dEtDRVpWNFdHMHNlNFRZNlpMdDFpZU9PUEpVOXFScS9pTzQ4ZS9UK054WTBF?=
 =?utf-8?B?TjRNTVdscFFjNmluWnZGMURwRkdsZFNNMU5wejkzSU5RREhTN1ZPWkNnYm1j?=
 =?utf-8?B?TXV1U3lsckdCYWM3WHVab0FMNkNOY2dpK3p2ZldURDJPaGIrN1p2czl5Uk55?=
 =?utf-8?B?QlA3VnkyYW1WQytLUVpSendsVFBZNGhTWSs1NU8xLzVzMGl0SDViNFFabWY1?=
 =?utf-8?B?Y2k1aS91dHpCWGFpVmlwanFXZmoxVUZNanUvMmkxbzZJS2hYdDZ3cERtK2VP?=
 =?utf-8?B?US9aU0N5d09FQVdGRGVEeTF4RUFCcEp2MDk2eW4yaVJrY0QwdkFsZEU3OFNK?=
 =?utf-8?B?bnNEVUVZRWRucE5UNU9SSTZvMjBVVXo5OFZ1TUxxVUhOdklkL2ZWUGRnMkE5?=
 =?utf-8?B?Y0xidEpwSERiUzNBM0gxeHR5T095dmhnSzY5KzF2MHR6T0JLMHJMUVFHdGxu?=
 =?utf-8?B?QXRBbTl4WGxMb050dzRyUGxoTHlBK0lqZFd2S1pLU3EzL0ZRcXdmd2JYdSt6?=
 =?utf-8?B?MXkwbXZJUEtyVExINU9iR1BCb3EzcUNYSU1SWitkQkFjSmhYM216TXVoc213?=
 =?utf-8?B?MVVjNzJZUzVCOGtIdG9UUUNpVklFVzJoWnVubTFyWGd4NVNVWFRQVTBHRmhV?=
 =?utf-8?B?ODUzb2NSWWpEOGdTbzdwb1A2VlQzQlJ1c2hiQTVVZm1xbWM2dWRFelZTdng2?=
 =?utf-8?B?Tk0wakJUa0J5YlBxR0VaZEJ0V1ZHQVQrcUFZb01HR3MrZVI5aGtGeFBNNDlV?=
 =?utf-8?B?Z2NwVTQ1SzBzeC9rbVkwRHpMa1hkTlRuNHBiN2w4SnhpYm0wcWRUV3BaN2F0?=
 =?utf-8?Q?1n8RuH9fOCs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB0715.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1Vrdld4SzBGb0cvcjRoc25lRFlSaFNqWkVURjVMRGJSbmplQ09WYS9TcDZW?=
 =?utf-8?B?RXEwS2lFbmNLQ012VytNUHBQanN5MGNjQUpSOFVzTGF2VE1GZkJXZnNQUHp3?=
 =?utf-8?B?ZTBtTkczS25waXNBMURmam1wMGdkalgwZ20rN3pBdHNNN00ySFhpR2txbGJm?=
 =?utf-8?B?S0pjaWlMVlRGZDBHQm95L2t1VU9zRzBETEtCQ0ZGaHF6YlMrVlMwKzkrek5J?=
 =?utf-8?B?dzEzZG5FLzkwOTZIc3o5Nnp4Y1Ard1RBV1ZJM2htOXZKeXRZV0tXNSs1SFFM?=
 =?utf-8?B?aUg3MTNrc0tZKzdnZUREQ09NR0o3aXBkUG1xdkpQMlFDR1l0RTM3R0w5UXRr?=
 =?utf-8?B?djc2cE4rK0R4c1FLdzdGWDNsbmtyZlpPNVVjSG9LWEdVZlJQdkFKQllteDZB?=
 =?utf-8?B?dzU0QlRnUUo4b0g2bndWYkpqTGYxL2s0NkYzMnFiN2psak5Zb1I2ci9iYmFs?=
 =?utf-8?B?M043ZitzdkxOUnBrL0lpVmdDeW9CNlRZRjZ6QzgvNW9uN1BodHdxNmM3ajRN?=
 =?utf-8?B?RThlRW9FM2tPNjR1VDZlYjFTWHVTVm1jeWZubGdHYmYyWVh1VFpMSmtRT0Iy?=
 =?utf-8?B?bVBseVRzRm84Vzc4MTgwbXlOTm12bDdUaUNlUzFTMWtrM1owSDRYK2FrNWJR?=
 =?utf-8?B?cmE2TWdzWGgrOWRid2N3OWZyK2JFL01nbVd5VzZYSGlPd09Od0hlQ0Z5OHlx?=
 =?utf-8?B?RU1xdGxaeXNPZktpSWM4blA2aTVhMmVnbXlwOCtTeGl6d0llT0xyWGN1cE1p?=
 =?utf-8?B?Tm5Tb2o3QXF3NHVaTzVscXJERUlxVXJZa1pHUXlzRjNXNVBCZUpIZlUvMmZG?=
 =?utf-8?B?NFZyWGlQNTkrNktwbUd4d3hXb2hPRkZydFZhb0lSU1ZYLzBNTm1xcWd6WE13?=
 =?utf-8?B?bm1PR1V3azRtZmIwaHBFcSs0d3lIanFqMVVxSXlVUFpTS3E4V1gzK1ErNXhp?=
 =?utf-8?B?cVp5WDVZbndQZktJblIxa1VVbTkyUjBzODlHSmFFOTFodVhFOHp5cnlUMHRV?=
 =?utf-8?B?d1ZMQUtzVHZ4UFhGK0tJM0RHU3lvUUxmVi9halY5Rkt2VUh5QTNWSDVtMUc0?=
 =?utf-8?B?TC9EbEFuMm9NL2k3V1VLR2xYYnN0Q2RsQVFobjZ2dk5CaUQ1cXJydnJYYkNX?=
 =?utf-8?B?czFBSi9MQXF2L2pQNm1IOStVKzljcFlodEovMVpVaXpGenBjNzNOOThYVWQ5?=
 =?utf-8?B?SVFpSk1SbzlFODlkTjM4Y1RHRzIxYXZWK2FuQjhOVXh3bGk4NmlzQURIU1VX?=
 =?utf-8?B?OVRCZTFTZHEzV25vNmlUNnFBWm1tb0FCWDh2R3Y0TXd3ZWszTWpJNzI1YkFR?=
 =?utf-8?B?QlFnbHdaeTdiRHBIdHRaMmdxV3RJbVp6WE1nNEVoamlLdno5a3RORkF5UEZZ?=
 =?utf-8?B?UmdQb2lJZUtVYjdJQXY0amVNS1NVbDlDeC9iYnRrUDVKZG05QUNIbGRKN0JW?=
 =?utf-8?B?YkU3UDU0NGQxNTNhVy9vaEMxOVA4djAvSklWMTMyVndETjZaR3I4UXJIQ2Vy?=
 =?utf-8?B?d0JjVFUrZkU2SDVIdU93cjVZcHU3WWRvTXJXN1J2dXNkb2FkMW9aRGNvZ1lS?=
 =?utf-8?B?MFVTTC9tRnR1b2k4elZCUjZJZy9mSEJrN3M5Q0taT05YclB1ZjBFWjdJTHFo?=
 =?utf-8?B?cXJwK1F4WldseXUwMzkxRjRyTExGYUdGUnhxK09JbDJTenByQ1VNTEFBN0dC?=
 =?utf-8?B?cVlhejA5STYrUnpRWUNsRHZKWkZrYVZRS0ErUkMxbWJIbis2TG9uTmF6Tnl5?=
 =?utf-8?B?bC9WUVd0UGVKZ1l2UGJLb1ZPZ2pVYmk4WDMwa1YzNFNWZWEvTk5Ga1NQZmdV?=
 =?utf-8?B?R3Arc2pnUlRsS09ISWRFMXpZV1IwMS9Oa0hRNmFIbE1xQWdmaWhtREJGajVz?=
 =?utf-8?B?OHNESnlaeGhiNER2bkRZaGxSRTYwSFZzUUR2aVlkR25nZlUvOS8xOHRBbHlk?=
 =?utf-8?B?QWZCaEVDeThYM1JVbk16cGg3UjhMdm5DZWROQ0N0YWQwai9jbnd0SlVCbWRk?=
 =?utf-8?B?c2FHZWpISnZVOE50a0tKZzVQUUJJYnB0OThHMTNYbG56UW1aa0hYQWVKeEVU?=
 =?utf-8?B?M29rUXQyMzN0aEU2eVg4bXpSNjRzVTVqc2FJZnNBMHFhYXQvVmZrSXJKRnk0?=
 =?utf-8?B?QkxKc1A5R2FvVjJSN1JwSkxZUHIvV1hXakxTd1h2N1YrNXhNWEJmMDBsVXU0?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4028B52FCEBFC24F9CEBDA01FF69D752@SWEP280.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: reversec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB0715.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cc1a36-84fe-4d13-1206-08ddf10ac129
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 08:11:04.7460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ea33927c-14dc-4a64-9482-d3df5ef087b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SnGcKOxZvvNoojW8IuYLKkLP7fuJesC7fcQHYetIs0dvAkRSCR9RurHy9mDaeXDQCp0q3QJiQS8KahXLdW81orhvS8B6TSTbU87FYuEX29I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB1019

T24gMjAyNS0wOC0xNCBUaHUsIEJlbmNlIENzw7Nrw6FzIHdyb3RlOg0KPiBSZXBsYWNlIHZlcmJh
dGltIGxpY2Vuc2UgdGV4dCB3aXRoIGEgYFNQRFgtTGljZW5zZS1JZGVudGlmaWVyYC4NCj4gDQo+
IFRoZSBjb21tZW50IGhlYWRlciBtaXMtYXR0cmlidXRlcyB0aGlzIGxpY2Vuc2UgdG8gYmUgIlgx
MSIsIGJ1dCB0aGUNCj4gbGljZW5zZSB0ZXh0IGRvZXMgbm90IGluY2x1ZGUgdGhlIGxhc3QgbGlu
ZSAiRXhjZXB0IGFzIGNvbnRhaW5lZCBpbiB0aGlzDQo+IG5vdGljZSwgdGhlIG5hbWUgb2YgdGhl
IFggQ29uc29ydGl1bSBzaGFsbCBub3QgYmUgdXNlZCBpbiBhZHZlcnRpc2luZyBvcg0KPiBvdGhl
cndpc2UgdG8gcHJvbW90ZSB0aGUgc2FsZSwgdXNlIG9yIG90aGVyIGRlYWxpbmdzIGluIHRoaXMg
U29mdHdhcmUNCj4gd2l0aG91dCBwcmlvciB3cml0dGVuIGF1dGhvcml6YXRpb24gZnJvbSB0aGUg
WCBDb25zb3J0aXVtLiIuIFRoZXJlZm9yZSwNCj4gdGhpcyBsaWNlbnNlIGlzIGFjdHVhbGx5IGVx
dWl2YWxlbnQgdG8gdGhlIFNQRFggIk1JVCIgbGljZW5zZSAoY29uZmlybWVkDQo+IGJ5IHRleHQg
ZGlmZmluZykuDQo+IA0KPiBDYzogQW5kcmVqIFJvc2FubyA8YW5kcmVqQGludmVyc2VwYXRoLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogQmVuY2UgQ3PDs2vDoXMgPGNzb2thcy5iZW5jZUBwcm9sYW4u
aHU+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvbnhwL2lteC9pbXg1My11c2Jhcm1vcnku
ZHRzIHwgMzkgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDM4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NTMtdXNiYXJtb3J5LmR0cyBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL254cC9pbXgvaW14NTMtdXNiYXJtb3J5LmR0cw0KPiBpbmRleCBhY2M0NDAxMGQ1MTA2OTVi
MjhkYzhlNjU5OWJhMDA2ODU2YTg5ZWZiLi4zYWQ5ZGI0YjE0NDI1NGY1NDAwY2U4OTRmOTlmYjAz
OGU1MWY2NGY0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9ueHAvaW14L2lteDUz
LXVzYmFybW9yeS5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbnhwL2lteC9pbXg1My11
c2Jhcm1vcnkuZHRzDQo+IEBAIC0xLDQ3ICsxLDEwIEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogKEdQTC0yLjAtb3ItbGF0ZXIgT1IgTUlUKQ0KPiAgLyoNCj4gICAqIFVTQiBhcm1v
cnkgTWtJIGRldmljZSB0cmVlIGZpbGUNCj4gICAqIGh0dHBzOi8vaW52ZXJzZXBhdGguY29tL3Vz
YmFybW9yeQ0KPiAgICoNCj4gICAqIENvcHlyaWdodCAoQykgMjAxNSwgSW52ZXJzZSBQYXRoDQo+
ICAgKiBBbmRyZWogUm9zYW5vIDxhbmRyZWpAaW52ZXJzZXBhdGguY29tPg0KPiAtICoNCj4gLSAq
IFRoaXMgZmlsZSBpcyBkdWFsLWxpY2Vuc2VkOiB5b3UgY2FuIHVzZSBpdCBlaXRoZXIgdW5kZXIg
dGhlIHRlcm1zDQo+IC0gKiBvZiB0aGUgR1BMIG9yIHRoZSBYMTEgbGljZW5zZSwgYXQgeW91ciBv
cHRpb24uIE5vdGUgdGhhdCB0aGlzIGR1YWwNCj4gLSAqIGxpY2Vuc2luZyBvbmx5IGFwcGxpZXMg
dG8gdGhpcyBmaWxlLCBhbmQgbm90IHRoaXMgcHJvamVjdCBhcyBhDQo+IC0gKiB3aG9sZS4NCj4g
LSAqDQo+IC0gKiAgYSkgVGhpcyBmaWxlIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0
cmlidXRlIGl0IGFuZC9vcg0KPiAtICogICAgIG1vZGlmeSBpdCB1bmRlciB0aGUgdGVybXMgb2Yg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzDQo+IC0gKiAgICAgcHVibGlzaGVkIGJ5
IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlDQo+
IC0gKiAgICAgTGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4N
Cj4gLSAqDQo+IC0gKiAgICAgVGhpcyBmaWxlIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRo
YXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+IC0gKiAgICAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZ
OyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YNCj4gLSAqICAgICBNRVJDSEFO
VEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlDQo+
IC0gKiAgICAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4NCj4g
LSAqDQo+IC0gKiBPciwgYWx0ZXJuYXRpdmVseSwNCj4gLSAqDQo+IC0gKiAgYikgUGVybWlzc2lv
biBpcyBoZXJlYnkgZ3JhbnRlZCwgZnJlZSBvZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24NCj4gLSAq
ICAgICBvYnRhaW5pbmcgYSBjb3B5IG9mIHRoaXMgc29mdHdhcmUgYW5kIGFzc29jaWF0ZWQgZG9j
dW1lbnRhdGlvbg0KPiAtICogICAgIGZpbGVzICh0aGUgIlNvZnR3YXJlIiksIHRvIGRlYWwgaW4g
dGhlIFNvZnR3YXJlIHdpdGhvdXQNCj4gLSAqICAgICByZXN0cmljdGlvbiwgaW5jbHVkaW5nIHdp
dGhvdXQgbGltaXRhdGlvbiB0aGUgcmlnaHRzIHRvIHVzZSwNCj4gLSAqICAgICBjb3B5LCBtb2Rp
ZnksIG1lcmdlLCBwdWJsaXNoLCBkaXN0cmlidXRlLCBzdWJsaWNlbnNlLCBhbmQvb3INCj4gLSAq
ICAgICBzZWxsIGNvcGllcyBvZiB0aGUgU29mdHdhcmUsIGFuZCB0byBwZXJtaXQgcGVyc29ucyB0
byB3aG9tIHRoZQ0KPiAtICogICAgIFNvZnR3YXJlIGlzIGZ1cm5pc2hlZCB0byBkbyBzbywgc3Vi
amVjdCB0byB0aGUgZm9sbG93aW5nDQo+IC0gKiAgICAgY29uZGl0aW9uczoNCj4gLSAqDQo+IC0g
KiAgICAgVGhlIGFib3ZlIGNvcHlyaWdodCBub3RpY2UgYW5kIHRoaXMgcGVybWlzc2lvbiBub3Rp
Y2Ugc2hhbGwgYmUNCj4gLSAqICAgICBpbmNsdWRlZCBpbiBhbGwgY29waWVzIG9yIHN1YnN0YW50
aWFsIHBvcnRpb25zIG9mIHRoZSBTb2Z0d2FyZS4NCj4gLSAqDQo+IC0gKiAgICAgVEhFIFNPRlRX
QVJFIElTIFBST1ZJREVEICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5ZIEtJTkQsDQo+
IC0gKiAgICAgRVhQUkVTUyBPUiBJTVBMSUVELCBJTkNMVURJTkcgQlVUIE5PVCBMSU1JVEVEIFRP
IFRIRSBXQVJSQU5USUVTDQo+IC0gKiAgICAgT0YgTUVSQ0hBTlRBQklMSVRZLCBGSVRORVNTIEZP
UiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBBTkQNCj4gLSAqICAgICBOT05JTkZSSU5HRU1FTlQuIElO
IE5PIEVWRU5UIFNIQUxMIFRIRSBBVVRIT1JTIE9SIENPUFlSSUdIVA0KPiAtICogICAgIEhPTERF
UlMgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0sIERBTUFHRVMgT1IgT1RIRVIgTElBQklMSVRZLA0K
PiAtICogICAgIFdIRVRIRVIgSU4gQU4gQUNUSU9OIE9GIENPTlRSQUNULCBUT1JUIE9SIE9USEVS
V0lTRSwgQVJJU0lORw0KPiAtICogICAgIEZST00sIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJ
VEggVEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1INCj4gLSAqICAgICBPVEhFUiBERUFMSU5HUyBJ
TiBUSEUgU09GVFdBUkUuDQo+ICAgKi8NCj4gIA0KPiAgL2R0cy12MS87DQo+IA0KPiAtLSANCj4g
Mi40My4wDQo+IA0KPiANCg0KQWNrZWQtYnk6IEFuZHJlaiBSb3Nhbm8gPGFuZHJlai5yb3Nhbm9A
cmV2ZXJzZWMuY29tPg0KDQotLSANCkFuZHJlaiBSb3Nhbm8gfCBIYXJkd2FyZSBTZWN1cml0eSB8
IFJldmVyc2VjIEZvdW5kcnkNCnd3dy5yZXZlcnNlYy5jb20vZm91bmRyeQ0KQkRFMSA2MkY0IDcw
MjAgMTU4OCA4MDQ2IEFFMDIgRUExNyA4QzMyIEFCNTYgNTRDRQ==

