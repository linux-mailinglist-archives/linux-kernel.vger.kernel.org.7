Return-Path: <linux-kernel+bounces-830674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3871CB9A458
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83442A4A49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF8A307AD7;
	Wed, 24 Sep 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CHGAHfM+"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA3E1A9FA7;
	Wed, 24 Sep 2025 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724537; cv=fail; b=X3phj/qYdCC2uykN3c/G/Pibyd0PX+12KIa2IKortN1pF5EisWGWBN+9guuNy/iACk2j4/pVfnFp79dz1CvePNJZSUZli55ZVjLs2o3rngXRymRgXjFDkSHQtAsjwcYavCbmbzqHbUSSQKtrFWBNheUzoCOoBqb+aoTYKORKKQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724537; c=relaxed/simple;
	bh=7XGcz8ovMSwK+mcd4Ei/ZyrbGmMEmM30ZVrZ8TA0Ydo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JemRWWd20pjU1l9u5Vn8BOTYDZxBBYB3jCmDLfbokzcCpdJXc85/DIeFmvWuRX0yjJiljYMwCi2ChrCbReVpO9le3wyDEeTMK5rBLeyXih5l1m/m1JO5L6vofpkj++2ls8FGjR275ez/IUlJflzIbO/AVLpbsq4MJs5FD1DxAl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CHGAHfM+; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpV2SJdG4/2MbL5BjvrIQEEdBz+vjVWAfCYRByDnX9vUASk02W3VAGB108BNzRkWWD50m7XJxInOBAzDx/rDTdSwJ9lf0DTXk33FttQy6+li3TkUaOf2j5VPcwK+sxfRIAnRMx8kVBNuNn5JEE7Dt1SkwrkIX/Wtq3FY3Ietyw/M2ZCYr7fPtbKsIp/M8hBkWi1619w2Cy4B+8zy1oKHtaf3fA20S12LTEkpgqcVrwrLSdyjBQ9bqsQghk1+FO9Ah2CwHSVtCMIrGEKMPhLytAi6rO+Ic8ZPh9C40OiWK7S+vQfrtNT6BqNbPXLJYn/AYtTEaNbQY798ZJXIjHXdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XGcz8ovMSwK+mcd4Ei/ZyrbGmMEmM30ZVrZ8TA0Ydo=;
 b=G9PvcEAoBnlcqdb0xGxaksr50LL/0hWwV01Y+uBGaXkgTsB0Dy0tQuhd9XCjDNZZvgdtTBpVEEFaihunrUd2hMlhd5E0/aP+PCuu2mGaQ07P3u19bwS0g6Yxmubb9B34eGEbT92oWwpPYMrM37M/9AYKxfoq+KwuvVEstQnLvF6GUD+GMvUpCDhDHgC1PwrKcLC5j8QA8d/UHSVl4CUgNFTj2xjgR2Sjg+Xg37mVfdITy/eJA5WHolCLu6tkjEo0BrSVuwopd3ezAgxn/sfwNKwUHoM/MmmKInhAlFfDE/ByN+hskB9ee5R7nWRxI9ZSrx6VedecOj6rnJwNEHwYEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XGcz8ovMSwK+mcd4Ei/ZyrbGmMEmM30ZVrZ8TA0Ydo=;
 b=CHGAHfM+SOcL6xync3LhYjl3M2drxyEEnl2NEyWQHYzeVnxkmCgYFLvlJtYBC7Ga3sLCZYz4lsTc0I9bwogR0XO219rrTKbGEzAs+DHgsXNd+sBsWT9EqCRng41vqH2IY/1j7N2s3/XUkfomEDbhS1/A/LlR/cAJ2SiqmYYSs3WL8sl/Mv5Hqz1+UMKKAXYQk5bz+TFsOk2TNaItp42e4TlGjCqo1gQOS7PB7qw3UDWyp85xvkfUI+vpm8Ibk7xR+4T76T8U7V71SXl4kjXjvSDacjItfJfm0xwx4gJfBTYEBdvAvQsbCl8Ggy28DKq+5UsovHkpcnPAgfNMAMgVBg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB11537.eurprd04.prod.outlook.com (2603:10a6:800:2cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:35:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:35:31 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Sebin Francis <sebin.francis@ti.com>,
	Cristian Marussi <cristian.marussi@arm.com>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Brian Masney <bmasney@redhat.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for NXP i.MX95
Thread-Topic: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for NXP i.MX95
Thread-Index:
 AQHcJhsCzmRSrEp0oEyqjCzMN4tqC7SgpByAgAAO97CAAWsJAIAAIANwgAAfpwCAABEKsA==
Date: Wed, 24 Sep 2025 14:35:30 +0000
Message-ID:
 <PAXPR04MB84592331881F5C0C529C7B66881CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
 <20250915-clk-ssc-version1-v4-5-5a2cee2f0351@nxp.com>
 <5f508f1d-2d08-4687-86cd-d1944caa0a49@ti.com>
 <PAXPR04MB8459CE9F22CD56A9BFDB5E78881DA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <082735e7-956b-4574-952e-06ba69db41f1@ti.com>
 <PAXPR04MB84590D5AAAB56ED7E1CBDE05881CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250924-dark-super-gharial-246400@sudeepholla>
In-Reply-To: <20250924-dark-super-gharial-246400@sudeepholla>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB11537:EE_
x-ms-office365-filtering-correlation-id: f566843b-6896-480a-048f-08ddfb779d01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUF2SzI5TWozOGNNaXk0MGxRUmxmRzNEVWx3QmozS0h6Mkd3NDFJdlRpc2c3?=
 =?utf-8?B?M1NBb1hhYUZ6aXFaYTVLK0M3WVdBck1waFh5ckg1SW5QL1lha3lNNGVKUVpO?=
 =?utf-8?B?QnJsQ0xybEEzdzZvTElTM1N0UGVrL0VQKzBIWEQ1ZnllUUtWeUJ5OE1IN29i?=
 =?utf-8?B?L2l5QmNHR1ZIUDF6YnluSU9la3N5ZVBDQUkvTUJIQjNJN1kvMW1YTzJOZ0lU?=
 =?utf-8?B?eUx4c1Q3SVR0MEJSdEJNRnpuUUx3SjJUY0QwejV6TWxvZHlsR3hvUGE2ZHhJ?=
 =?utf-8?B?ekprY1JTTnhZckJYRDh6YkQ2Q3J2aGxXYXFjbnZmSi91WDBXNzNSc0RxZWo1?=
 =?utf-8?B?QTRtd3Rwa2QvVzJvdmdWQkNJYkRIMFhDb2R0aCtxYytUMFpZc0ZkdlZCb01P?=
 =?utf-8?B?bjJqZXFQNThLS21ZU3VWbVhKNEpsZFkrRys4MHRlc01Hb2hmUysvdWh5UWI5?=
 =?utf-8?B?aUR0ODc3eVBieTZsb1JtOTdlYVB4TkhmZFhKQlFTb0E3UytSUitlT1gvS0dl?=
 =?utf-8?B?d0FGVmlMQ0IyeHljZXh3RllTbGVVSVUyb1poK1c5M3FXaEtnR0Z3RzR6dm82?=
 =?utf-8?B?Mm9YS1hlYUFneG1LR2dkTUpxOGxhY2tJcW44L2xFdU5ZUDhHVTJaUURQMW9n?=
 =?utf-8?B?UWxZcHRWdGx3djdaZi9HMVdCWjNwcmZsSC9VamJmTlI4bldlbG1CdEc1THE5?=
 =?utf-8?B?cUpud2o4TWw5RWd2b0tuZGtTZmU1ODlocGtpZ2dLKytaQngrL3JJTE9TQUx2?=
 =?utf-8?B?b3IyMzFrWEk1aXJqaVNPaVhEUmlPR0FURXJoSUVXQkhiN1ZjKzlkbDV0SnJs?=
 =?utf-8?B?Si9FbVA4WHBXeVMxR09zRXBPS3BGYjZEbWRkbXltTFJZNmdBNitrWVRzQWxQ?=
 =?utf-8?B?OXpTVEM4NlNZZnlZazNjd1FFUUhoUDRvY0lmeXFHb2s4Q0FLOWgrN2lFTGlQ?=
 =?utf-8?B?cmF5YjdnRUNya093SFA0ZndyTWgwQmUxdGpTRWF1NlpTWUIrTStHWk9DQmZt?=
 =?utf-8?B?elp2bXl4QXNhdmxqcFRhaVNlakdIZDVaa3N6bnJQU01IQTRLMkJIcTFEUmZH?=
 =?utf-8?B?ajh3ZzVQcStaQjhPaUtDaGZjSldldzUwdWpEV3p4WFRJSUV6cTQ5RmJSZ0VR?=
 =?utf-8?B?Q0FoQUYwQWY2b2N2MXVYb2NOUWV3TnFpcldKKzZlaUE1ZGF1S2t1a1hvbW9J?=
 =?utf-8?B?elNNL1BRaVo5SDFWWGRzTHlXU0EzemhmTC9pNnNyWjdEaUEvMi9sV3RhZW8x?=
 =?utf-8?B?UnpPRVlEUTRrdVgrMlpaMzFQS1hZSnEwTUZNNjUzcGhOQU1DbVRPdkZwSGFU?=
 =?utf-8?B?ZFBPNFBOZms0ZTZOVnVidVRNUmoyaER1eXcxM2hldzhQRW1maFl5SnhjU2Fx?=
 =?utf-8?B?azl0SW8zUWF0TnJRK0lqbk9xVWtzeGdCMmRUVStIcGFVbWR1ajFWQkpNRm9F?=
 =?utf-8?B?S294ZlI3cVdYTWRvUzBIaGZSNndHWStwL3dtZm5xUFdBOVp1KzBJMWRTRURy?=
 =?utf-8?B?U2krVnI3WVhRKzdEZVdPTHhZWVNmVW9wV2kycFdBOUlhd3BEbGVRTjJnMjZN?=
 =?utf-8?B?QmltcjYrRUVkdjZJTTlJaU83WFlteXFOZDVKK2c5dXkvMjBHNElmejczUm1Y?=
 =?utf-8?B?aTFmQndQQSswSy9vTFlIMTNFa0p2YnRWWDI3bFZDc1NyaTBIcXBKd2d4RHJs?=
 =?utf-8?B?aG04SEFsWG1jKzZMUDNDMDNrMkRkQnpkNmN6eHgvRlpTRyt5ZW5SWTBGR1lv?=
 =?utf-8?B?K1ZRVml0VTBvRitpSTRvSll3UHg3UXNjRzE2dkw4cFBFTUowYm1iQ2VaUm5U?=
 =?utf-8?B?ZzVqVmwwSlZwV0dUSk1QVVhwanFhWUl2RFR0QytncGs0dDN2M3BvMmdBVGRX?=
 =?utf-8?B?MmhrUHd6aTUxdk9wWVd4V05kMnF1aUNLYzNZa0orZUNmbVJOcVhYaHIrY1FU?=
 =?utf-8?B?NndsOGhZbVJhNmU4NFkySHhyczFGWTZkOGRLZlR2R3hUd1BXMndmVU9jY3lw?=
 =?utf-8?Q?Te5cMqls4PyDVaPJuWZpbLwbycxFgM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHBsNExOV2hDYW1jK2VQNVpIdHljZlZmaVJiNm1lQjE3QWNOWlgyb1BlcGYv?=
 =?utf-8?B?b0JzZzR4bklocmdOSEp5MHU1UVpQVDlSZUlnSlNtY3lFZVJHTnhDRW4wQnUr?=
 =?utf-8?B?SURqM09Ya3h4OTIzcTBzT1RjR3ZBY1IxL05JR1k3Uzl5Nkw4TURJeE5YOURk?=
 =?utf-8?B?M3YvMXhsaGtRRmp6MHBTUFJ5TnhMdldQU3NFZ1hpVnBHdXhzZk5qeHJ4Mzhh?=
 =?utf-8?B?Q1d1TXZ2RHI0MkVUWmdMUlozMU4rSlpGZ2xRQUoyUmwzZC9uVi9Kb21xZXRK?=
 =?utf-8?B?T1RuV2VqbDA2RHBKdTZKc01hNFZVcnpIdFZMc0xjRm5EeU9aOWtsS0tISXB5?=
 =?utf-8?B?V3lMTTQ2U211Z2ZSOTIwakNWRU5BYVVOeTR6SmZHcVNqZndtSWVESEQzdjZM?=
 =?utf-8?B?SXdIaEdrWDNhOHRLMlBsb0Y2dTNtcW42UE04YVkycE5DdUhRYVkvdGVqSmow?=
 =?utf-8?B?UENnc0cvbmUxSFEvdEs1MGVndjRlT1kyOU1wQ2l6aERoam1Ha0FrMDdqYkpO?=
 =?utf-8?B?WUdWZm9HMFVKdVM3SG4yci81djQrNjhoVlFpbnh3T05sT2VnSCtRcHl1RUtX?=
 =?utf-8?B?R0c5WWRlRWpVU0Y0ZExMMktseTFXOGFYZjNjdE9tam1McUJKNjJPd2NZbVhj?=
 =?utf-8?B?TUFSTVQ1bXhWaFhwcHVBTW5LZnRqeUJIWG1OYmlGS0lvQWp1em9vVHlsZjFJ?=
 =?utf-8?B?V3VQRHBMLzVlamhsSmM5SHVaamcvSmdoTzNOeENZYXgwSmNnTk9YTlNYbmFI?=
 =?utf-8?B?b09YaElid2ZibVRPeGNXcmltQnA2bEc2ckp0Q2E2YzdxbzlKcDVvL04rMktJ?=
 =?utf-8?B?WVE2V0RJbnpiV1IxbFlkTzd0emxpYW50UjhqZG5mQWViSUlNanovWEczT0RF?=
 =?utf-8?B?YVVkTkR3N2w2dzZUSnNtcFpMRWw4NG1YalQwWVRRSDZaZE9PNS9CaG9wY1hB?=
 =?utf-8?B?UytxL3VMNDNLaXloVTFWMkMzQjhFanZNd0VUOVpjcFZ5T3hFaCsvMFlnNytx?=
 =?utf-8?B?TkthaDByWlRoRmFVenR6ZWpnbXNRMVR4ZDY5NTdxWUJkdnZyTXpjNzVvQjF1?=
 =?utf-8?B?VHlWZHZXcVFIaCt3RFFWSUlLencybEpEeVhCdXBCajdtWHRsdzgwSkpQbEdh?=
 =?utf-8?B?dHU4QjhBenI2LzBVaVdGTjlkMlQ2NGZ4RWl2UmxIaW5YUGNYY2NNRjlTTEFv?=
 =?utf-8?B?R3ArWDVYVHhqMlNGUnF2YkdNT3E4UmRkWEpEL1ZLL25CbXNxTUdFMFovb0w4?=
 =?utf-8?B?Z3RyaHd6VlZiR0VrL3pyVFEyOEJ1d25HWVNOdVJRZTVkWjU3MGVhNWpkYXNo?=
 =?utf-8?B?dW5KQ0FCRDFodDFKVHliT2VwMXVjbW9ZQ1N6NXhLbWZQOXhZaDZ1dGtxSkRo?=
 =?utf-8?B?emgxcVZyVXBKa1M1d3FZRHRLbTZNSytnNDNDeUhnK1d5dFB6bk5wQkxUZXZ1?=
 =?utf-8?B?dkwxZWVWOVM5TGFuMk1JeVhrYUVJcHV4bW5jMzBrT2hTU0xGTnZaWGdaOVBM?=
 =?utf-8?B?NXVUYm5nT3ZOc1p3TkRJc2JPK2U4cG5PQWVoQnFYazNCS1V4YjRMbmhaZW9z?=
 =?utf-8?B?VWkxSTNhMXhVeFppbytCYkRkWUJVaUtJZkp0YUlVTWxDTFUwWDludUVscUh5?=
 =?utf-8?B?VE5rckNuejlRczVXWWV4OVNFYjczNnBLeWY5YitlZTdlV3JFRTFubWFtUVM1?=
 =?utf-8?B?VHpnSWptd25MU3RiVUxDa3NtUW5zNzBUbHNad3RKS3Z6dWh6N1lLN3JwMXhw?=
 =?utf-8?B?bVNUZW9CZDRkbVducGdMRWYxWDJsOHc4MkxyYS9XdFRmWnFuRjB2RDRVYUli?=
 =?utf-8?B?eW9CaUJma2w2S2VGT0puSEF0RitFN0tBVVNWemhXREw3Mkx6Y3BjV29TZGNz?=
 =?utf-8?B?WTdLaFZUVzI5cmJiYmlnME5GcTZRb25QQWhlaVZjdXI5MzJzODh2U2lvcGI5?=
 =?utf-8?B?SXNDekxFdHN2WVRqT25sbG8vQlQ5Ujd0OHphNzhCSzkveElabDVKYUdVbGVB?=
 =?utf-8?B?dytCNzdacytNUXNWaVdUY2NWQlB4dHhsTm5ndSt1V0NvaUpNZ2l5UGZOaTM4?=
 =?utf-8?B?eEFvL2hTMHRBaHk2SG5JMXU3bGJoUzFUNEV5VG8rZ3A0V1ozUk9vU256RUVU?=
 =?utf-8?Q?fV+k=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f566843b-6896-480a-048f-08ddfb779d01
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 14:35:30.9754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqwUoNMr/Y6MtCorDhn8hnvoyA4B+1tiZH6ibKHcmSMPt2nLLso+WoGZvEyCvdjGiGTEASXK11JCxdWP1YTI1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11537

SGkgU3VkZWVwLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNS81XSBjbGs6IHNjbWk6IFN1
cHBvcnQgU3ByZWFkIFNwZWN0cnVtIGZvcg0KPiBOWFAgaS5NWDk1DQo+IA0KPiBPbiBXZWQsIFNl
cCAyNCwgMjAyNSBhdCAxMTo0Mzo1NkFNICswMDAwLCBQZW5nIEZhbiB3cm90ZToNCj4gPiA+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNS81XSBjbGs6IHNjbWk6IFN1cHBvcnQgU3ByZWFkIFNwZWN0
cnVtIGZvcg0KPiA+ID4gTlhQIGkuTVg5NQ0KPiA+IC4uLg0KPiA+ID4gPj4+ICAgICAgICBTQ01J
X0NMT0NLX0NGR19PRU1fU1RBUlQgPSAweDgwLA0KPiA+ID4gPj4+ICsgICAgIFNDTUlfQ0xPQ0tf
Q0ZHX0lNWF9TU0MgPSAweDgwLA0KPiA+ID4gPj4NCj4gPiA+ID4+IFRJIGlzIGFsc28gcGxhbm5p
bmcgdG8gaW1wbGVtZW50IHRoZSBzYW1lIGluIG91ciB1cGNvbWluZw0KPiBwbGF0Zm9ybS4NCj4g
PiA+ID4+IHNvIGNhbiB3ZSB1c2UgYSBnZW5lcmljIElEIGluc3RlYWQgb2YgdmVuZGVyIHNwZWNm
aWMgbWVzc2FnZSBJRD8NCj4gPiA+ID4NCj4gPiA+ID4gSSB0cmllZCB0byBwdXNoIHRvIG5ldyBn
ZW5lcmljIElEIFsxXSBpbiBoYWxmIGEgeWVhciBhZ28sIGJ1dCBpbg0KPiA+ID4gPiB0aGUgZW5k
IEFSTSBkZWNpZGVkIG5vdCB0byBhZGQgZ2VuZXJpYyBJRCBmb3Igc3ByZWFkIHNwZWN0cnVtDQo+
IHN1cHBvcnQuDQo+ID4gPiA+DQo+ID4gPiA+IFRvIGkuTVgsIGl0IGlzIHRvbyBsYXRlIHRvIHVz
ZSBhIGdlbmVyaWMgSUQgYW5kIHdhaXRpbmcgc3BlYywgaS5NWA0KPiA+ID4gPiBmaXJtd2FyZSBo
YXMgYmVlbiBwdWJsaWMgZm9yIHF1aXRlIHNvbWUgdGltZSBhbmQgcGFzc2VkIHNldmVyYWwNCj4g
PiA+IGV4dGVybmFsIHJlbGVhc2VzLg0KPiA+ID4gPiBTbyBJIG5lZWQgdG8gdXNlIHdoYXQgb3Vy
IGZpcm13YXJlIGFkZHMgYW5kIHNwZWMgYWxsb3dzOiB2ZW5kb3INCj4gPiA+ID4gZXh0ZW5zaW9u
Lg0KPiA+ID4NCj4gPiA+IFRoYW5rcyBmb3IgdGhlIHF1aWNrIHJlc3BvbnNlLA0KPiA+ID4gU2lu
Y2UgdGhpcyBpbXBsZW1lbnRhdGlvbiBpcyBzcGVjaWZpYyB0byBpLk1YLCBjYW4geW91IG1vdmUg
dGhpcyB0bw0KPiA+ID4gYSB2ZW5kb3Igc3BlY2lmaWMgZmlsZSwgc28gdGhhdCBpdCB3aWxsIG5v
dCBicmVhayBpLk1YJ3MgZmlybXdhcmUNCj4gPiA+IGFuZCBUSSBjYW4gaW1wbGVtZW50IFNTQyBp
biBUSSBzcGVjaWZpYyBmaWxlLg0KPiA+DQo+ID4gaS5NWCBoYXMgZW5jb3VudGVyZWQgaXNzdWUg
d2l0aCBwaW5jdHJsLXNjbWkuYyBhbmQgcGluY3RybC1pbXgtc2NtaS5jDQo+ID4gYm90aCBzdXBw
b3J0cyBTQ01JIFBJTkNUUkwuIEN1cnJlbnQgbGludXggc2NtaSBkb2VzIG5vdCBzdXBwb3J0DQo+
IGJvdGgNCj4gPiBkcml2ZXJzIGJ1aWx0IGluIGtlcm5lbCBpbWFnZSwgYmVjYXVzZSBzY21pIGRl
dmxpbmsgaXNzdWUuDQo+ID4NCj4gPiBTdWRlZXAgc2FpZCBoZSB3b3VsZCBhZGRyZXNzIHRoZSBk
ZXZsaW5rIGlzc3VlIGluIDYuMTkgY3ljbGUuDQo+ID4NCj4gDQo+IFllcyBpdCBpcyBhIGRpZmZl
cmVudCBpc3N1ZSBJTU8gYW5kIG5vdGhpbmcgcmVsYXRlZCB0byB0aGlzLg0KPiANCj4gPiBHaXZl
biB0aGUgY3VycmVudCBzaXR1YXRpb24sIEknbSBoZXNpdGFudCB0byBpbnRyb2R1Y2UgYSBuZXcg
ZHJpdmVyDQo+ID4gc2F5aW5nIGNsay1pbXgtc2NtaS5jLg0KPiA+DQo+IA0KPiBZZXMgcGxlYXNl
IGRvbid0LCBhbmQgSSBkb24ndCBzZWUgYSBzdHJvbmcgcmVhc29uIGZvciB0aGF0KHlldCkuDQo+
IA0KPiBVbmxpa2UgdmVuZG9yIHByb3RvY29sLCB0aGVyZSBpcyBubyB3YXkgd2UgY2FuIG5vIHVw
ZnJvbnQgaG93IHRoZQ0KPiB2ZW5kb3JzIGNhbiB1c2UgdGhpcyBpbiB0aGVpciBvd24gY29sb3Vy
ZnVsIHdheS4gU28gSSBhbSBub3Qgc3VyZSBpZiB3ZQ0KPiBzdGFydCBidWlsZGluZyBzb21ldGhp
bmcgZ2VuZXJpYyBmcm9tIHRoZSBzdGFydCBvciByZWZhY3RvciBhcyBtb3JlDQo+IHZlbmRvcnMg
c3RhcnQgdXNpbmcgaXQuIEhhcmQgdG8gZGVjaWRlIPCfmYEuIExldHMgc2VlLCBuZWVkIHRvIHRo
aW5rIGEgYml0Lg0KPiANCj4gSWYgUGVuZyBvciBTZWJpbiBvciBvdGhlcnMgaGF2ZSBzb21lIGlk
ZWEsIHBsZWFzZSBwcm9wb3NlIG9yIHN0YXJ0IHRoZQ0KPiBkaXNjdXNzaW9uIHNvIHRoYXQgd2Ug
Y2FuIGV2YWx1YXRlIHRoZSBhcHByb2FjaC4NCg0KSSB3b3VsZCBnaXZlIGEgbG9vayBhbmQgaG9w
ZSB0aGVyZSBpcyBhbiBvdXRwdXQuIEkgd2lsbCBzdGFydA0KYSBuZXcgdGhyZWFkIHRvIGRpc2N1
c3MuDQoNCkp1c3QgaW4gbXkgbWluZA0KRWFjaCBzdGFuZGFyZCBwcm90b2NvbCBoYXMgaXRzIG93
biBPRU0gb3IgdmVuZG9yIGRlc2NyaXB0aW9uLCBpdCBtaWdodA0KYmUgaGFyZCB0byB1c2UgYSBn
ZW5lcmljIHdheSB0byBzdXBwb3J0IGFsbCBzdGFuZGFyZCBwcm90b2NvbHMuDQoNCkl0IG1pZ2h0
IGJlIGEgYml0IGVhc2llciB0byB1c2UgcGVyIHByb3RvY29sIGV4dGVuc2lvbi4NCg0KQW55d2F5
LCBsZXQncyBkaXNjdXNzIGluIHRoZSBuZXcgdGhyZWFkIHdpdGggcG90ZW50aWFsIHNvbHV0aW9u
cy4NCg0KVGhhbmtzDQpQZW5nLiANCg0KPiANCj4gLS0NCj4gUmVnYXJkcywNCj4gU3VkZWVwDQo=

