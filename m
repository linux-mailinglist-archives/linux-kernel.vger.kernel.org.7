Return-Path: <linux-kernel+bounces-831870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8D4B9DBFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90083425880
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27222E8E12;
	Thu, 25 Sep 2025 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="bp5M4QyE"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023108.outbound.protection.outlook.com [52.101.83.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679461CAA92;
	Thu, 25 Sep 2025 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783854; cv=fail; b=LSCHHncynT2DQj6bkXDKHlZrzC0Z3HqUTMsh2JcBTVMt/EfsAQEcSzhPknmhytF9/KaahjJdrSSsdRy67sM2BRRlcJ42/MaXnfmhsmtjwHOGzfIV/nAFdrn3sCpOWoOAtXZZSp916ck9Hyr6CZ4EolzI94+nsHHgPhg6wr6nuFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783854; c=relaxed/simple;
	bh=Au4laUxykb80gx+ZPcTGnwL7N1apxSjoG1v3kQEjDnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hr64/pxz3qzWC0xGUIajkUBy5/dYLsfBCU4DsgEsZfd6PY+oxCW91jZ847jG7wxwcUQvuf63c4mEBh0fE3c0STVKHQbqhC4asdHvE8N3FwlUgMOGuAGqOpMnUzoIrYsZYareGGEVrhnxv/6gKl6AGZerxoBp6VSwPvpk21zmTCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=bp5M4QyE; arc=fail smtp.client-ip=52.101.83.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTDnd/EzS8jnsIOuBy8C0M6Oqf1X1axnIueBe3VQK5SoIx4FesYodPIU9Oj8jiMPv+Xndwi9BnZhA7ZWwCzAptf2LtymPODN355EndD+B/fx6FntekFLCl3o2EUQVclMA1ArERgD7FWegl9VgpYZoJaSTq6MTRb+PpRxgzWbdXnm2voVCdP73vyNJnMgLkSXIv//vc7/ODBrkAcqT241oE81nrOXfLVCsFXJOV+0cSZ8Hk8TojHzzkrMslZrixQYDT7upsos8M1qXif1kzH645iPAlL3IdERneAcBIK453tdsl7gOEQ9tO4oWs0ea3ayiDQiUnET0MieTaQNK1hjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au4laUxykb80gx+ZPcTGnwL7N1apxSjoG1v3kQEjDnE=;
 b=afU9vYR1vDEnsluV09AEXyr0jqEUbKM6UL03h4HH3Nsbdvt3yYTgRuGtu8n/7FpDsoVRa7TmdQ3GMh3vSP806xMGxrtZ1Ui4Jna+QsYeg70masVHs4Wtv9gcFlwthtc15Wsv1YEsnvzBr/TYswLQy7KkfsQ2lsgCYZuvs/eCG2vk843lIVNNRKsp8kDoAOdCa96tydUq8nz27o6L22CdYVzu5Yz3f4lv9k/dbTTE9G7zcRBzOwydYmnJAn0W4K83giZedrOPQo7g1qXTeLq9OXSiZ0PWcPlzUNbSC9hOzN+ofoBs27VIAKiYjkHPefwqfAPYM/2m01QuWmvCmoRJ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au4laUxykb80gx+ZPcTGnwL7N1apxSjoG1v3kQEjDnE=;
 b=bp5M4QyE/ZbiWSW5uIaHFa+NrMwv6DnXb9CuJxsqJEJmJoq/0DWUToSLe4V03kM9XmeaYJauwUdQCQUC+MOvAhvp+N2B5S4jJxo9OWWWh4IbiHxxY8PSVe0bWsbCv4yYyo4m9lCOtEluED5itKbMHIm53BYt1cDIYAnSgDv0FzRr5bvNO6kHS63YSUbinHZceFPf9EE7H5PYg5k+mrNzgwjLnsCzF7BmLZ4J6tm3o5G99lpE4y6YioOv5dh2Bs8kEytrsY06kx0fmXmvLNn1u5EyJ/NzeOvB5Pw+Sdfi3rsDgUmJBVtz7zad7TjKYaJICcpBV0FHqzKxEbT8PCaYmA==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by VI2P195MB2959.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 07:04:06 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%6]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 07:04:06 +0000
From: Yannic Moog <y.moog@phytec.de>
To: "Frank.li@nxp.com" <Frank.li@nxp.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mp pollux: add displays for
 expansion board
Thread-Topic: [PATCH v2 3/3] arm64: dts: imx8mp pollux: add displays for
 expansion board
Thread-Index: AQHcLUqm+JFzoqyW5UGnkOvklWV8DbSiZ9cAgAESvIA=
Date: Thu, 25 Sep 2025 07:04:06 +0000
Message-ID: <fa5a8f22a89f12ed5247e7e8613e417dadd97a5d.camel@phytec.de>
References:
 <20250924-imx8mp-pollux-display-overlays-v2-0-600f06b518b9@phytec.de>
	 <20250924-imx8mp-pollux-display-overlays-v2-3-600f06b518b9@phytec.de>
	 <aNQC7nVj4m1TyF/9@lizhi-Precision-Tower-5810>
In-Reply-To: <aNQC7nVj4m1TyF/9@lizhi-Precision-Tower-5810>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|VI2P195MB2959:EE_
x-ms-office365-filtering-correlation-id: 08daf932-36d0-46ae-761f-08ddfc01b7e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmRYb1dBclY3bFMvT20vZUNSKzZlcUpKQ2RTZkV6c09kcWNqRUxuM3VtdnlJ?=
 =?utf-8?B?SzVaaVl1eEE3eUJsZTdGajNaRjlBZEY5Y1l5aHVWbEQ3OVVzUlJZazkwT2N0?=
 =?utf-8?B?OC9YbUlkSEhZalQvVUtmMGxmS2w3TnN3eHBOcUJJcjZscHpsU0hsS3ZGSzR1?=
 =?utf-8?B?MkF5Vnp1N3dvaFFMZU5XRm15V3laeEIrWWU0dGhQU3cwa0RGdWk3dFczQkhQ?=
 =?utf-8?B?TEpxaGJmMTczejhPblBoQ25rZUg5YVR2OEtqZXY0U0Q0MlFZbm00RFUxcnhR?=
 =?utf-8?B?bDlSZkwwQWlXSHBFcGRnZ3RzTkk4OWMwMlVmWVF6YThMMXBBSkMvdGQ1VW16?=
 =?utf-8?B?WG11dkpxbEJXS25RNkZtbUU3MmZiRHoxMHJqazJibFhrM243ZGszWE9TT0Vw?=
 =?utf-8?B?azQrQTBqT2dadFFxNWxsbWl4d0xUcTZIV1lKdmxUVjFUT1pXdFBjeEZHMEdQ?=
 =?utf-8?B?YjBjVk5LeWlLVmNQRkdtR3BDMDBILy9CdDBUOExHNERBTTZuVm00UkNybkJ3?=
 =?utf-8?B?elJQYTMzS0p5UUVESFE4d2x6L2dES25vWmc1UmNYbDcrcHNOdnltVWx3M0Iv?=
 =?utf-8?B?YVF6eXVZdk1ScFdTdk5mb01mSlA4emQ5b2ZaclJleGVPTlFNYkJKd1hONVp1?=
 =?utf-8?B?aWJsY1dMZmlDSmEvbENNS3RpbXlhVW00SDFneWdXdEVkUys2TE5ncW9HWDA3?=
 =?utf-8?B?aDg5dUNNMW1qK3ZPdW9UUE5sNDl0U1FiaEVXaEFWQ2I4V3VHem1UMmR5TEpE?=
 =?utf-8?B?a1RQUWRhdWg0ZXVoN2hGd0g3bDF4RC9LNmNMdXJMRUMvcUxwS01LRTVOVVhr?=
 =?utf-8?B?OTFSQzBUbUFxa1dVOEs2bkZqb2QwQVN6Z2xpRXArcUVTdnVtVlJyckV0Z2J5?=
 =?utf-8?B?ZVlKYkM1M3kvMktBS2NFcWJmc0xyV2RVNjh2cnkreDR0OW1aZnN6cDVqVTNO?=
 =?utf-8?B?NXJrYmp4Rkg3QWUwdW40TDYvQy9SV2l1cy9laHFZaDdjWTkwRDZsaWF1ZE9O?=
 =?utf-8?B?S2kzcGZBR3hiOEZydklpYmFmOU9OaXV4VHJxNGZsVnorMklDWS9hbWREbHdG?=
 =?utf-8?B?bUk1d25QemRvSnN2TG45ZkFBeUhlcHF5MGdlaEkxRGJWdUVGTWMzR1I5WXAz?=
 =?utf-8?B?NTNxRDMxNGRVVFo2MVJ1YmFIeVdVL0c5YlpmVkdBbGNKcWZjRTVVbzkzUDU5?=
 =?utf-8?B?MzNMTUZsdDAwU0drYjdEcW1RcEwySDM5NmNJazBiSU1HYkZOMG8weHYxVFRB?=
 =?utf-8?B?dG9aWmtjN0g3VGJRSjljaFRscTRqUFJXazAzVmYvd2lreldEQm5rY1F6b1lU?=
 =?utf-8?B?cXFCdFhFUHJVYTc5L3VyMlZ0b1BTdlZjZ1dxNHJFdHl6UmZXZllVa1AwQ0xV?=
 =?utf-8?B?Rll3dVlqYU9PM3BsbjZnSzFOakpySXlXZll2aGxUaXkyamROUFNXeTEvb2tq?=
 =?utf-8?B?OWhxYW9vQWcvS0lmNXlPUS9VeWZNYTdmbk5sdFBQeEttZ2RqNVoyRE5ZcXBj?=
 =?utf-8?B?bENKL2VzREhvZDJ6d1grei9uaXhPSUR5b0o2TUN6Wi9sbmJYZy9DaU95VlZS?=
 =?utf-8?B?dVdSN0hUWWxTMmMraS9tYkVUM2tVTHM3UlV0L0R3V1BLZHBEU1RKOXpJOS8x?=
 =?utf-8?B?aU5MODE3SjAyQ0tLNGZEWUdkMHp5dkdDNG1MZmYzNjBxamhxWWg5RUcySmlU?=
 =?utf-8?B?NTJNenF2UmhRNUVrUEpXQVN4Sk1oNjdJSzdSeWhDVGVFblppQ2VmWG9QcnVu?=
 =?utf-8?B?Y2dWUkNIdHRBWXFIT3ZnL2tJRjd2ck5LWVdCem5oMjZTVldMN2lJcU1oL0V6?=
 =?utf-8?B?Vm1VUFlaUVBIZ0ZzL3NZWDIrTTVwZW0zeWZ2eFhKMjBSTW1Uc1NEdUtjck45?=
 =?utf-8?B?MUtHYXJLT3VxcWJwRVZxcmpMOExVVmM1ZVVEaC9na0MrOEE0UUJyd3oyeEtD?=
 =?utf-8?B?Tkc1VHN6WlFvN25JSlZXY0N0eU1peUY0MjVoWk9XQzZGU1AzVHNlanVLNEMx?=
 =?utf-8?B?aDlRZXRhM3J3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emF3cEd6ZUV0VlEvdisrUFoyVWs3azBPK2tIbzVyOU5WTzRST1RzR0tsK1g1?=
 =?utf-8?B?bEt4czhDRFdGZWFSNWM2QTdudFhsbzZzbVFWOWxFQjkvclBRMVJtei9kRVlW?=
 =?utf-8?B?QklWMzJuZi9sd0htcGtCaDJMaThQcFNaYnJDMGh2dEtnaEZoeGpGVXdxTVNy?=
 =?utf-8?B?bkxIZmpLaWhXWGVvdG1vdHpreitadXJIY1EwMkl3Y05WVXFkbERhYWk5SEJV?=
 =?utf-8?B?YnQxUGsybUdFUm4xSGVaUjB0TEJrZExZUzV0QTlySkluZ1NWZnRDZTQzZmZ5?=
 =?utf-8?B?OTFteEJnTGdIK3Z0M3FkNkVVSnA2RHFRS3loWEpFMlE2WGRuWGw0RTFnWW9K?=
 =?utf-8?B?RkVoNk1xWjdpZXNUNDBBd3RkY1RXREQxSFdTZmF6QnNyLzQzNHhxcG9KN0xR?=
 =?utf-8?B?c2hqU2JFanVZTkw5OFE4YllGdWtiWHQ1RjZKRTFRLzIvUXBRWmVYME4zTE5V?=
 =?utf-8?B?blFVdy9XMURnbEJGeXVrc2FWYkRFZzRIbWhFS3lQMEIwWUZBS3FsVHdJeWRW?=
 =?utf-8?B?Zlp0bUU1VzQxNmk3QmsxOXEyQ1p2RFRXL0N5c2twUkhYNVJyWnpsWGlaQ2pq?=
 =?utf-8?B?N2JReWt2MVlzbVdFNFFuSjdUWUlTQUgvaW83SEp5TG1KS2NJU0t2amQrdXdo?=
 =?utf-8?B?NzZiTnlHTnN0QVJycGxvSEgxOXVNZzJaWWhmWGd5U2E4UUpYaDBHNFNMRGtG?=
 =?utf-8?B?OUg4Z1NJdE1mTTh3YjFWZ3pjTjl4d0Rkd0xQdmViNXYwTVNCL0VWVHBNVnpQ?=
 =?utf-8?B?L0tSRUZFZ3owV0lmblpSbEpiSUVwdGlaY25XRjdWK0hMejUrTXJxVUFhb05H?=
 =?utf-8?B?dzFZZVp0OGt4N3RPUGErb1ZZT1N3VDhYOHdtalQrTERUa0M1eUNOTHRpUms4?=
 =?utf-8?B?UUJnTHJFb01oeUpVSFJtZTdTWk1mQ2ZKYmJhaFZ5UlUwTHhwSEJrRmVWWUVl?=
 =?utf-8?B?UENaNnV1SkV3RWJncWZ5ZHM1UjNjbXpXd2tkSS9HVk0zMDN2eEFIUzZiNVU5?=
 =?utf-8?B?bmJJWlFHUXlaS3U4dHNmTWkvN0VLUXFKeEl0R1VwaFNkMnZBUjAxQkUxWlZO?=
 =?utf-8?B?U1hlWHc4RmpsV3Y2bU5oczVYNnlEdmFQeTdzUllpc2R4WEZ6bVFLWGFaeDVh?=
 =?utf-8?B?Sk1GZHZpWkVnbkRFZUJzRGlPYUkwMDJJSnlYVmR6UmViNGUzNkw0ZHBFTDNN?=
 =?utf-8?B?SGNwcTdZcjNTaE4zUnBWaXY0cC9mVlhDYlQ1YStGelQxS3lmclJQTE9TcXps?=
 =?utf-8?B?bExwMGpCUlRJMkJCa1IyQmYvS3R4azdtelp6ek5iUDJicGtEa1I2LzZ4NUt5?=
 =?utf-8?B?U3g4Y053YVB6REcvZ3BncG44OEk0a3l3RXFsY2VIR0dLWjNoZGVPVVY1Zksx?=
 =?utf-8?B?STZlbEltbk93cEdzRVAzNjZjQzhOUnpOR3VwK0VVY1E2TVUzaEREUkxEbU9X?=
 =?utf-8?B?cEdTeXdxNS84dWtGTlcrN3crN09FWWMxeldadUgvU1l3UlE0Q2Zuci9kUnFN?=
 =?utf-8?B?RmMwNk1ZYTVPWU1sUkFhdGVTektDWnBpOG4xakZMV1pmMXptV2VJVXNFWlVV?=
 =?utf-8?B?ODduRVVsRjJYdzBDV0FxSmQwa1JaSEVVM0RsTEk4SnJydXpWenVPcStNL2h3?=
 =?utf-8?B?ck1SbDdlRWVIR3VCL241bkplQmlHUlpYT0JYVHJPQW5tL2dxY013c2kzL2hR?=
 =?utf-8?B?Z0dOYjczYzNpWXVXM1V2d1RDMWtMdTB5am8wSC9QKzg0ancyaXI1dTloVEk5?=
 =?utf-8?B?c2pqTFRBd1BvWlJHWWg3YWY4S0UydXdlRE1FcGJoSlFiQnhYTkQvR3Jacmpu?=
 =?utf-8?B?Vk8zZ1ZxL1BPcVVNR05xc2pDWlJyV3JJZ3dGSS9PRzF1SUh2blYzSDZIMmN1?=
 =?utf-8?B?ZXlVcVNzZGxPOVRHN3ZkakJvNlhTcHZscFZYVVhMMFFnZGFLekxuTC9DNCtq?=
 =?utf-8?B?bnNsZlJleTdsaDZld0lhWXIzOHlEQzFOZlBmUG5FSlhlaVRlS2ttSHh3SWlI?=
 =?utf-8?B?Q2hUVW1MM1psYUkvbTl1RXpzeE5CMHFMQ2VGYlJIcUhLdWhvSTJwdjhRTUJy?=
 =?utf-8?B?SnlzT3FQM0dWeXFnZVNyRkpVRDh2ZThvTjBZdC9XZ2xQcmxkNkw0UTQvOEdE?=
 =?utf-8?B?U0tTb0FlWUVhMmtaRmluYVlIREZuajRGcUZVRWRKZGFYQ2QvZWxFTStkdW9V?=
 =?utf-8?Q?v2O3tlvC4yz5o3HFQLa2KqHiZn4gHMKNOLoRQUxUzO8m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B2D6EC7434B0B4CB5D507851770A91B@EURP195.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08daf932-36d0-46ae-761f-08ddfc01b7e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 07:04:06.6651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MW9R3kqhw/rsGP6ARg8/KcAKMDC659uuUvfbmTB5IiY8HvTPgOZ/wUh90a/DJfZNG2DM+ZCMAAkvt74kEItdaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P195MB2959

T24gV2VkLCAyMDI1LTA5LTI0IGF0IDEwOjQwIC0wNDAwLCBGcmFuayBMaSB3cm90ZToNCj4gT24g
V2VkLCBTZXAgMjQsIDIwMjUgYXQgMDE6NTk6MDZQTSArMDIwMCwgWWFubmljIE1vb2cgd3JvdGU6
DQo+ID4gVGhlIHNhbWUgZGlzcGxheXMgdGhhdCBjYW4gYmUgY29ubmVjdGVkIGRpcmVjdGx5IHRv
IHRoZQ0KPiA+IGlteDhtcC1waHlib2FyZC1wb2xsdXggY2FuIGFsc28gYmUgY29ubmVjdGVkIHRv
IHRoZSBleHBhbnNpb24gYm9hcmQNCj4gPiBQRUItQVYtMTAuIEZvciBkaXNwbGF5cyBjb25uZWN0
ZWQgdG8gdGhlIGV4cGFuc2lvbiBib2FyZCwgYSBzZWNvbmQgTFZEUw0KPiA+IGNoYW5uZWwgb2Yg
dGhlIGkuTVggOE0gUGx1cyBTb0MgaXMgdXNlZCBhbmQgb25seSBhIHNpbmdsZSBkaXNwbGF5DQo+
ID4gY29ubmVjdGVkIHRvIHRoZSBTb0MgTFZEUyBkaXNwbGF5IGJyaWRnZSBhdCBhIGdpdmVuIHRp
bWUgaXMgc3VwcG9ydGVkLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlhbm5pYyBNb29nIDx5
Lm1vb2dAcGh5dGVjLmRlPg0KPiA+IC0tLQ0KPiA+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDYgKysrDQo+ID4gwqAu
Li5tcC1waHlib2FyZC1wb2xsdXgtcGViLWF2LTEwLWV0bWwxMDEwZzNkcmEuZHRzbyB8IDQ1ICsr
KysrKysrKysrKysrKysrKysrKysNCj4gPiDCoC4uLjhtcC1waHlib2FyZC1wb2xsdXgtcGViLWF2
LTEwLXBoMTI4ODAwdDAwNi5kdHNvIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKw0KPiANCj4g
SSB0aGluayB5b3Ugc3F1YXNoIHRoaXMgdG8gcHJldmlvdXMgcGF0Y2gsIG9yIG1vdmUgcHJldmlv
dXMgcGF0Y2ggZHRzbyBpbnRvDQo+IHRoaXMgcGF0Y2ggdG8gc2hvdyBkdHNpJ3MgdXNhZ2UuDQoN
Ckkgc3BsaXQgdGhlIGRpc3BsYXlzIGZyb20gdGhlIGV4cGFuc2lvbiBib2FyZCBpdHNlbGYsIGJl
Y2F1c2UgdGhlIGV4cGFuc2lvbiBib2FyZCBjYW4gYmUgdXNlZCBhcyBpcw0Kd2l0aG91dCBkaXNw
bGF5cy4NCkkgaGFkIHNwbGl0IHRoZSBjb21taXRzIHRoZSBzYW1lIHdheSBpbiB0aGUgcGFzdCBh
cyB0byBtZSB0aGV5IGFyZSBkaWZmZXJlbnQgInRvcGljcyIuDQpJZiB5b3UgaW5zaXN0IEkgd2ls
bCBzcXVhc2gsIGJ1dCBteSBzdWdnZXN0aW9uIGZvciBhIGNvbXByb21pc2UgaXMgdGhhdCBJIGFt
ZW5kIHRoZSBjb21taXQNCmRlc2NyaXB0aW9uIGZvciB0aGUgZXhwYW5zaW9uIGJvYXJkIHBhdGNo
IHRvIGJldHRlciBleHBsYWluIHdoeSBpdCBleGlzdHMgYXMgYSBkdHNpIGZpbGUuDQoNCllhbm5p
Yw0KDQo+IA0KPiBGcmFuaw0KPiANCj4gPiDCoDMgZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9u
cygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9NYWtlZmlsZSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlDQo+ID4g
aW5kZXggOWMxMjEwNDExMjg5NzJkMjIzOWUyY2M3NGRmOThiMGJmN2RlMWFjMi4uZTRiMDk3NDQ2
NDQwZjQxNzg1ZGQxYTBlNWQzNTQ3OTZlODAwZWU3NiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlDQo+ID4gQEAgLTIyMiwxMSArMjIyLDE3IEBAIGlteDht
cC1waHlib2FyZC1wb2xsdXgtZXRtbDEwMTBnM2RyYS1kdGJzICs9IGlteDhtcC1waHlib2FyZC1w
b2xsdXgtDQo+ID4gcmRrLmR0YiBcDQo+ID4gwqAJaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1ldG1s
MTAxMGczZHJhLmR0Ym8NCj4gPiDCoGlteDhtcC1waHlib2FyZC1wb2xsdXgtcGViLWF2LTEwLWR0
YnMgKz0gaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRiIFwNCj4gPiDCoAlpbXg4bXAtcGh5
Ym9hcmQtcG9sbHV4LXBlYi1hdi0xMC5kdGJvDQo+ID4gK2lteDhtcC1waHlib2FyZC1wb2xsdXgt
cGViLWF2LTEwLWV0bWwxMDEwZzNkcmEtZHRicyArPSBpbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJk
ay5kdGIgXA0KPiA+ICsJaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1wZWItYXYtMTAtZXRtbDEwMTBn
M2RyYS5kdGJvDQo+ID4gK2lteDhtcC1waHlib2FyZC1wb2xsdXgtcGViLWF2LTEwLXBoMTI4ODAw
dDAwNi1kdGJzICs9IGlteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLmR0YiBcDQo+ID4gKwlpbXg4
bXAtcGh5Ym9hcmQtcG9sbHV4LXBlYi1hdi0xMC1waDEyODgwMHQwMDYuZHRibw0KPiA+IMKgaW14
OG1wLXBoeWJvYXJkLXBvbGx1eC1waDEyODgwMHQwMDYtZHRicyArPSBpbXg4bXAtcGh5Ym9hcmQt
cG9sbHV4LXJkay5kdGIgXA0KPiA+IMKgCWlteDhtcC1waHlib2FyZC1wb2xsdXgtcGgxMjg4MDB0
MDA2LmR0Ym8NCj4gPiDCoGlteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLW5vLWV0aC1kdGJzICs9
IGlteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLmR0YiBpbXg4bXAtcGh5Y29yZS1uby0NCj4gPiBl
dGguZHRibw0KPiA+IMKgZHRiLSQoQ09ORklHX0FSQ0hfTVhDKSArPSBpbXg4bXAtcGh5Ym9hcmQt
cG9sbHV4LWV0bWwxMDEwZzNkcmEuZHRiDQo+ID4gwqBkdGItJChDT05GSUdfQVJDSF9NWEMpICs9
IGlteDhtcC1waHlib2FyZC1wb2xsdXgtcGViLWF2LTEwLmR0Yg0KPiA+ICtkdGItJChDT05GSUdf
QVJDSF9NWEMpICs9IGlteDhtcC1waHlib2FyZC1wb2xsdXgtcGViLWF2LTEwLWV0bWwxMDEwZzNk
cmEuZHRiDQo+ID4gK2R0Yi0kKENPTkZJR19BUkNIX01YQykgKz0gaW14OG1wLXBoeWJvYXJkLXBv
bGx1eC1wZWItYXYtMTAtcGgxMjg4MDB0MDA2LmR0Yg0KPiA+IMKgZHRiLSQoQ09ORklHX0FSQ0hf
TVhDKSArPSBpbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXBoMTI4ODAwdDAwNi5kdGINCj4gPiDCoGR0
Yi0kKENPTkZJR19BUkNIX01YQykgKz0gaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGstbm8tZXRo
LmR0Yg0KPiA+IMKgZHRiLSQoQ09ORklHX0FSQ0hfTVhDKSArPSBpbXg4bXAtc2tvdi1iYXNpYy5k
dGINCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1w
LXBoeWJvYXJkLXBvbGx1eC1wZWItYXYtMTAtZXRtbDEwMTBnM2RyYS5kdHNvDQo+ID4gYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXBlYi1hdi0x
MC1ldG1sMTAxMGczZHJhLmR0c28NCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4
IDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAuLmQ3MTk0NTQzMGM4MDFh
MDEzNmE5NWQ2OTFhZjBjZWM2NDYyMmEwNjYNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1wZWIt
YXYtMTAtZXRtbDEwMTBnM2RyYS5kdHNvDQo+ID4gQEAgLTAsMCArMSw0NSBAQA0KPiA+ICsvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjArIE9SIE1JVCkNCj4gPiArLyoNCj4gPiAr
ICogQ29weXJpZ2h0IChDKSAyMDI1IFBIWVRFQyBNZXNzdGVjaG5payBHbWJIDQo+ID4gKyAqLw0K
PiA+ICsNCj4gPiArL2R0cy12MS87DQo+ID4gKy9wbHVnaW4vOw0KPiA+ICsNCj4gPiArI2luY2x1
ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
Y2xvY2svaW14OG1wLWNsb2NrLmg+DQo+ID4gKyNpbmNsdWRlICJpbXg4bXAtcGh5Ym9hcmQtcG9s
bHV4LXBlYi1hdi0xMC5kdHNpIg0KPiA+ICsNCj4gPiArJmJhY2tsaWdodF9sdmRzMCB7DQo+ID4g
KwlicmlnaHRuZXNzLWxldmVscyA9IDwwIDggMTYgMzIgNjQgMTI4IDI1NT47DQo+ID4gKwlkZWZh
dWx0LWJyaWdodG5lc3MtbGV2ZWwgPSA8OD47DQo+ID4gKwllbmFibGUtZ3Bpb3MgPSA8JmdwaW81
IDEgR1BJT19BQ1RJVkVfSElHSD47DQo+ID4gKwludW0taW50ZXJwb2xhdGVkLXN0ZXBzID0gPDI+
Ow0KPiA+ICsJcHdtcyA9IDwmcHdtNCAwIDUwMDAwIDA+Ow0KPiA+ICsJc3RhdHVzID0gIm9rYXki
Ow0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJmxjZGlmMiB7DQo+ID4gKwlzdGF0dXMgPSAib2theSI7
DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmbHZkc19icmlkZ2Ugew0KPiA+ICsJYXNzaWduZWQtY2xv
Y2tzID0gPCZjbGsgSU1YOE1QX0NMS19NRURJQV9MREI+LCA8JmNsayBJTVg4TVBfVklERU9fUExM
MT47DQo+ID4gKwlhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZjbGsgSU1YOE1QX1ZJREVPX1BM
TDFfT1VUPjsNCj4gPiArCS8qDQo+ID4gKwkgKiBUaGUgTFZEUyBwYW5lbCB1c2VzIDcyLjQgTUh6
IHBpeGVsIGNsb2NrLCBzZXQgSU1YOE1QX1ZJREVPX1BMTDEgdG8NCj4gPiArCSAqIDcyLjQgKiA3
ID0gNTA2LjggTUh6IHNvIHRoZSBMREIgc2VyaWFsaXplciBhbmQgTENESUZ2MyBzY2Fub3V0DQo+
ID4gKwkgKiBlbmdpbmUgY2FuIHJlYWNoIGFjY3VyYXRlIHBpeGVsIGNsb2NrIG9mIGV4YWN0bHkg
NzIuNCBNSHouDQo+ID4gKwkgKi8NCj4gPiArCWFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDA+LCA8
NTA2ODAwMDAwPjsNCj4gPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gPiArfTsNCj4gPiArDQo+ID4g
KyZwYW5lbF9sdmRzMCB7DQo+ID4gKwljb21wYXRpYmxlID0gImVkdCxldG1sMTAxMGczZHJhIjsN
Cj4gPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZwd200IHsNCj4g
PiArCXN0YXR1cyA9ICJva2F5IjsNCj4gPiArfTsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1wZWItYXYtMTAtcGgx
Mjg4MDB0MDA2LmR0c28NCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
cC1waHlib2FyZC1wb2xsdXgtcGViLWF2LTEwLXBoMTI4ODAwdDAwNi5kdHNvDQo+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwLi44ZWM0YmJiYmFiYjVjYzdmNWFlMDVkNjQxZmI1ZDE0OTMxMjUwZGFmDQo+ID4g
LS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhtcC1waHlib2FyZC1wb2xsdXgtcGViLWF2LTEwLXBoMTI4ODAwdDAwNi5kdHNvDQo+ID4gQEAg
LTAsMCArMSw0NSBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAr
IE9SIE1JVCkNCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDI1IFBIWVRFQyBNZXNz
dGVjaG5payBHbWJIDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArL2R0cy12MS87DQo+ID4gKy9wbHVn
aW4vOw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPiA+
ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svaW14OG1wLWNsb2NrLmg+DQo+ID4gKyNpbmNs
dWRlICJpbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXBlYi1hdi0xMC5kdHNpIg0KPiA+ICsNCj4gPiAr
JmJhY2tsaWdodF9sdmRzMCB7DQo+ID4gKwlicmlnaHRuZXNzLWxldmVscyA9IDwwIDggMTYgMzIg
NjQgMTI4IDI1NT47DQo+ID4gKwlkZWZhdWx0LWJyaWdodG5lc3MtbGV2ZWwgPSA8OD47DQo+ID4g
KwllbmFibGUtZ3Bpb3MgPSA8JmdwaW81IDEgR1BJT19BQ1RJVkVfSElHSD47DQo+ID4gKwludW0t
aW50ZXJwb2xhdGVkLXN0ZXBzID0gPDI+Ow0KPiA+ICsJcHdtcyA9IDwmcHdtNCAwIDY2NjY3IDA+
Ow0KPiA+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJmxjZGlmMiB7
DQo+ID4gKwlzdGF0dXMgPSAib2theSI7DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmbHZkc19icmlk
Z2Ugew0KPiA+ICsJYXNzaWduZWQtY2xvY2tzID0gPCZjbGsgSU1YOE1QX0NMS19NRURJQV9MREI+
LCA8JmNsayBJTVg4TVBfVklERU9fUExMMT47DQo+ID4gKwlhc3NpZ25lZC1jbG9jay1wYXJlbnRz
ID0gPCZjbGsgSU1YOE1QX1ZJREVPX1BMTDFfT1VUPjsNCj4gPiArCS8qDQo+ID4gKwkgKiBUaGUg
TFZEUyBwYW5lbCB1c2VzIDY2LjUgTUh6IHBpeGVsIGNsb2NrLCBzZXQgSU1YOE1QX1ZJREVPX1BM
TDEgdG8NCj4gPiArCSAqIDY2LjUgKiA3ID0gNDY1LjUgTUh6IHNvIHRoZSBMREIgc2VyaWFsaXpl
ciBhbmQgTENESUZ2MyBzY2Fub3V0DQo+ID4gKwkgKiBlbmdpbmUgY2FuIHJlYWNoIGFjY3VyYXRl
IHBpeGVsIGNsb2NrIG9mIGV4YWN0bHkgNjYuNSBNSHouDQo+ID4gKwkgKi8NCj4gPiArCWFzc2ln
bmVkLWNsb2NrLXJhdGVzID0gPDA+LCA8NDY1NTAwMDAwPjsNCj4gPiArCXN0YXR1cyA9ICJva2F5
IjsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZwYW5lbF9sdmRzMCB7DQo+ID4gKwljb21wYXRpYmxl
ID0gInBvd2VydGlwLHBoMTI4ODAwdDAwNi16aGMwMSI7DQo+ID4gKwlzdGF0dXMgPSAib2theSI7
DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmcHdtNCB7DQo+ID4gKwlzdGF0dXMgPSAib2theSI7DQo+
ID4gK307DQo+ID4gDQo+ID4gLS0NCj4gPiAyLjUxLjANCj4gPiANCg==

