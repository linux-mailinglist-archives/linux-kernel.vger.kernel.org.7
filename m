Return-Path: <linux-kernel+bounces-789741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 423D4B399CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28FA1C80AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF6130ACFC;
	Thu, 28 Aug 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b="feRsgvwS"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021096.outbound.protection.outlook.com [52.101.70.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30830AD1C;
	Thu, 28 Aug 2025 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376704; cv=fail; b=VA+Km7z6z0lnoRpDUclZYCIBdATKjU5Zt/VU586sgKu/KGVokYqjnhVwlL9JZ+SdKY31WgnUuF+x5MiBZy91xhUGW1wqOG0XuXR2HfxJeGwKt86m8H9+r3uYievdvHKpC9RyC7ipXktwMLxcyEF3U+rTIiX3ikpNCAaTTQlRwJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376704; c=relaxed/simple;
	bh=OATL8/fjPpoliwHCh+gVyPBtysYYMGux8gDcbaId190=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nHa3SYQqgYtKeA/7V/8SIlCD6t+kpkTEdLRo0ftVY6IhqlwAyT5W7Ad4/f7zipWjyUPUP1p9wTNMYNSzfLnuB+ZX53Si26zfyVjpv1Nma6MZD6mqNAbCi0RkH1o6bbwBsEYMMZXIoXL+dw0jGltBweCSCI9hRss3rQH7ZTvnEjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com; spf=pass smtp.mailfrom=htecgroup.com; dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b=feRsgvwS; arc=fail smtp.client-ip=52.101.70.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLdLhoqOkosfc7RAoqbK7FOQceJ6qDRHYcIMK1xsKSjqx7T3zN35hM0jGQ+Olf41U1GuNr/H11iX7Mg8Rviln7d43r00TuMYs1ZG6R+csPTb2Qv3jBNEEKj+vHwfPBTaHS+BhyfxUoyaWWMTTuNVN6o6g5+gf7XSPXOyvOSIIhsc9bEtYsxJruVLFlc8tKRtMubM64cR1oA8eNX/D4JXJZxUaryu8Ur0KbrKOaLW1zKGibMV4qpcc992YGJ8MYOY3yqgMzWYMWOujPeBGzcEjYRW3xfd7P+gyG5/6AS8HN5UeJiNnDwbBk/7slQDovhCgOcvC9tXo8hak7bWbKP+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OATL8/fjPpoliwHCh+gVyPBtysYYMGux8gDcbaId190=;
 b=cYMKu51T7ZJse8rqxYK43yp8NvwkQtCdHGPDGlFeUMaqweufIDGYqWlD+X99p1tDyHp4ySNKGRgsXX/cPpkAvUOt6gWmfRSnrGlHzJI7ZngRq15Ton9hNo6uE2voRf43OEJhlSqoV8/xB2D+BI5X4egdnIv2fnprOD1lTX2/35mWr/rTnWGTkFdHVbd53wacihhjc4Tb3sTAB3qfWe0iQvNjgljudzsDxIazgmCCmpvRuwZl6g9fup1GD9eYFbN07uAyHpGgqypFB8D0yrvg7cN/C9vGhIj+Qg5UZ44/ayUWWN57CyD6NaX0BnYGapiCIbdGM87Q3y4VdxsD+Yxp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OATL8/fjPpoliwHCh+gVyPBtysYYMGux8gDcbaId190=;
 b=feRsgvwST99Bt5LrwNhrGXZy9d5MenxUjXQxlwzxHvFwxkexLug+/5fN/fPNa+uLV8iTH2x1EdafiVNgubPFCqBq3XfXJlAocQOn4WYn0/F5wRBVvuwtZUnpJDeLzbGY87YJECqf9x5OhDxfrj07v9GGDpOQl2m+zjhRmtZH2j2FnK6f6k7AeVxhRf4ry06FHPqitLrx9LqLYedlTu52MIKy8mbkLUvSJnUldoSdwOZGQY3NpH6BhIMfmnKIUawKD132ifIBRbz7bJlmcRdNYsLr16hNvzXprhDIvop/2w3wc/OsIQFArvW76TfSH3JYbTJyR6CULV6ZpI8N0giyUQ==
Received: from DB8PR09MB3260.eurprd09.prod.outlook.com (2603:10a6:10:105::13)
 by VI1PR09MB4256.eurprd09.prod.outlook.com (2603:10a6:803:13d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Thu, 28 Aug
 2025 10:24:54 +0000
Received: from DB8PR09MB3260.eurprd09.prod.outlook.com
 ([fe80::cad0:cb5b:959d:f7f]) by DB8PR09MB3260.eurprd09.prod.outlook.com
 ([fe80::cad0:cb5b:959d:f7f%5]) with mapi id 15.20.9052.023; Thu, 28 Aug 2025
 10:24:54 +0000
From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
To: "devnull+aleksa.paunovic.htecgroup.com@kernel.org"
	<devnull+aleksa.paunovic.htecgroup.com@kernel.org>
CC: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Djordje Todorovic
	<Djordje.Todorovic@htecgroup.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "robh@kernel.org" <robh@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH v6 0/2] riscv: Use GCR.U timer device as clocksource
Thread-Topic: [PATCH v6 0/2] riscv: Use GCR.U timer device as clocksource
Thread-Index: AQHcBs12repHpSIFJEu3XipmITYBdLR3/kgA
Date: Thu, 28 Aug 2025 10:24:54 +0000
Message-ID: <a17a89a1-cdab-4082-8cf7-bb6ec456a51b@htecgroup.com>
References: <20250806-riscv-time-mmio-v6-0-2df0e8219998@htecgroup.com>
In-Reply-To: <20250806-riscv-time-mmio-v6-0-2df0e8219998@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB3260:EE_|VI1PR09MB4256:EE_
x-ms-office365-filtering-correlation-id: bdd4fca9-5ca0-463d-136b-08dde61d2143
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?dmQzMkVMSWU0V3o2YUZkUHZyUkhpK093bWU5S3BkUllaQ3NtSnE4eHJnV0Y0?=
 =?utf-8?B?ZWsvVEw4dUNiUW9DcitZQ0N0eGVpRWVvL09CY0ZvMmhSajBqblhacEdBWVZI?=
 =?utf-8?B?TkVVTzIwMEVrekdTR29DN00xMEpaQSs1c05BempPVk9YUHVRaXEzSHZhUzk1?=
 =?utf-8?B?aGxYVHJMeXduenhVcmJjdmNjM1YzTDZBd2V6dHVsOXlKN2NmVTRVVjBjREVp?=
 =?utf-8?B?a0c1ODN1a3BIS1pad3NrVzM5bmpEd3dUdVdUU25EZGpkMFNMTTlmODRrWlg4?=
 =?utf-8?B?ejlKOVZMRlNtOGo0bEs4SGFwVTJGaC9QZ2h4cnZ0dzVMSHorS0hYMkhqTFVl?=
 =?utf-8?B?ZGl1RWp6SXErS1Y2RmNoVHd0MGNVTU91S1V0azFJc2J2eUFWZEFrVGJHK1J3?=
 =?utf-8?B?MGlOZTRIT0R5dzdYTDBXR1E4bnFJQzl5YkJaSTR5MCtSZjlFakxXSGNTcStx?=
 =?utf-8?B?VnpaZWl2RGlkd1d1ZVJxN3FjV3NoL0ZtN0ZJT0FaT1MydE9OZXlxbjlTYm1K?=
 =?utf-8?B?ZlBkYW1hcFVKTzVHd1pqUURPYVZWTm5MRmlWTUg4OWJkOXRDY25WZ3N6YTc1?=
 =?utf-8?B?Vm9hdVdvbW9NYzN0Vjd5ZTZZT0pWOUJMSkdvelVBZExyNVRLTHZRTCtkMk1p?=
 =?utf-8?B?RnFxcjVWdnNGZWhhUTRORnMwaGFJazhYbU1JZ3NEdTgwT3F1ZU1aU3orMlpL?=
 =?utf-8?B?M3oxdmpUczdzWnZwWTBKaTJjQjhCV29tdDR3Zmk1RnFibldBZU4xOEN5N2hO?=
 =?utf-8?B?eTFpdVlNUnMvMXdQbmIxZ1FJVnNQZXF4RjJrbmxQbnQzUCtXSmE1alAzRHZj?=
 =?utf-8?B?WVJUNmlDQ0tUSmZ6OHpSaC9VR1pZZk9jQXhHWHluSkJqOC80U2F0S2ZyUHBJ?=
 =?utf-8?B?NzYvU09wQnBkdDc5RHJZdnFIOE0wQzFETnIySG5mVFBMQkRheE9KdnNhajNR?=
 =?utf-8?B?aGRvaGNyODUzS2dORzBpdEdXc3FlNCtvNVVWZUYvMTlJNkUxd1BNV1dTdUhq?=
 =?utf-8?B?SWdCeXREdlYxVjhDV0J1VytnU1pHSWxOZThvSFNWMW43RzZWYnEweko1cHp0?=
 =?utf-8?B?Ym5Oam1RK2xQak42eUJPVzNqZ01mVlYybmVGbWRyT3NJYUpJQitGWkpUVHZm?=
 =?utf-8?B?V1d0NlhXdi94S0RGZlRXRVdrK2wwakxqay8xNkczSmI0QmpwQjA2MTNqY09a?=
 =?utf-8?B?MkhSQzRpcWQ1R2FLMkRFRUhvTjFja215N0h6M0tzR2U3UGVpa3JGSDhveGRZ?=
 =?utf-8?B?Uk01NlNkTHBtUVFiL3Z5SW4wRTBWOGtEK25KWGVSSzZNZk4zTHMrNjNWYjdT?=
 =?utf-8?B?TklWUnc4VmdiM1dxMW1wdStwdWVpcmRwSHN2SUg1dlRHNWFMUE5NbUJPTFhS?=
 =?utf-8?B?TXNZeWMreDFKdzYvMmw3aWlQQUR5WWNlN3lKczJDTWR6N0xjaU1oYytCRHZV?=
 =?utf-8?B?ZHBEcExldUZCcXRJdW93K1VKSFNvNEF6c1JONjEydFhxMDVLOGRZOXovMTBv?=
 =?utf-8?B?YTZoMkMzWlczRk9lVzZnVTQ4b1B1alIrVHVaSkcwaHhlTWw4SmY5NHVhTDBm?=
 =?utf-8?B?bS9pQ1l0ZWsrOVZqcm52aUtXLytaOVFpQjVjZGU4bUV4SkNHSVdmak5YeDdq?=
 =?utf-8?B?SWFGVjNLcitRWXlWTStQZ3lkK3BaczUyYnVEazBoY1lTUW16ZkRCSkd6Ti8z?=
 =?utf-8?B?S1dMZEFZdlBKUU14NC9hK2o0U1BVbFE2Z2ZBaTI3NGJsYytGYW1icm5TSVFt?=
 =?utf-8?B?dW9NZ3lKS2RnZmtnQ3JGSjZPMS9Hb2tSWFhtSjAySGdLMzRZUDFUeWlLM1lY?=
 =?utf-8?B?Yk40ZVlURUpFZE1sWUw0eDlzSDN3RkdMd1dxencreE85U1YxL0Zod3QzUU52?=
 =?utf-8?B?dU9ldGVnNDlOcHBpZ2hkbUV3UGlSSGhoVExhYnE2S01wblA0RTVIZjVTb296?=
 =?utf-8?B?UmtxTkF4VDNISzFsRmxQWExYU2pUaHVaYlE4a0gxWHh0c3MySFJla0dXQ2hI?=
 =?utf-8?Q?9s5lGyfn0jjOY4tRRvmN7pDPu8Y2go=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR09MB3260.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(13003099007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEZ4OC8wZ0xVTXFSZTFqc3hkTmN6T0NNWk1vODQydis4L1hUa1I4RWZ5Ujh0?=
 =?utf-8?B?T3lGajhvSFAvak9LZFEvT1pmZ0k4bURZaHd6TUJRZ2xKcmxOeitVMy9lcHBM?=
 =?utf-8?B?ZGo5L3c2UEd5amhCM2VLbEliQzFVd1NJSkNUYVRER3Z6ZU1PZXVieWJJTGh3?=
 =?utf-8?B?UVF5WS93bmY3SVQ3WVd2Q3E4eTh5aFpjYVc3MnhtN2FiK0xJWld4Tm1VNTJi?=
 =?utf-8?B?M3Z6VENYT1ZDQzNTcTRYUEZEdXU0VDNGbWhRYTgzOFdxdjdnUXZrNDZ6dWxL?=
 =?utf-8?B?Z2RZcU5iczArNnh0OUN2K0RCbTNsdEgybTZtU2tXb2ZNTEVHdjRta29GZjF3?=
 =?utf-8?B?ZmtrWldpbWwwMzJxUTRKQmNzZURGalBWc3V2ZE1UaE1Tb1hZdytXSjh5ZzNt?=
 =?utf-8?B?YnBVTzhVblJETEZMNklPdzRLeTMwamlTQlRsNVBTRzZXNmN4SW5uZENHeUtk?=
 =?utf-8?B?d0ZZdmZoSWo2bWxpTTUvYzFvdU1PMUJWRmZnbWh6NkdHYzRRam5MUVBFemx1?=
 =?utf-8?B?WnQ5bUdMUXN3bEtmdE9JNW1ZOWVOYU5Rc3hDUW1LZ2xvOEdvdzY3TXpKYktV?=
 =?utf-8?B?bTlTUjFCSmgxK2ZSRGtoZ0xqbjFXZFZOQjliZzVOalBYdWtmMVpLbTZ2Q1hr?=
 =?utf-8?B?eXVrS0tMNmtweGxvdzNoMVd3U2JvaWNOdWdiWmw2eDMvT2JOQmc1R09ta0Z0?=
 =?utf-8?B?ZS8vRkh0eEtKdTFsS2d5c1F2WDFmb0swaHU4Y0U5YVE0b2tVRXgvY2t0MUIy?=
 =?utf-8?B?TjJpRXdCRWx3bGRuTndTdEVraVVnOWRsbEhnZWtncVQ2a0I2aE5Xc1piaTUz?=
 =?utf-8?B?aDdGcnZPN1h0MUVGNmlpZlNFK3RQckUvWVdBRkxiWVVuazlNcFpDVGFnWFBx?=
 =?utf-8?B?TklDcUFkUWxOZWNYVUhtY3JwS2g5V2xmUy9GSk1KWWdmVlRZd29MYVpFVVZq?=
 =?utf-8?B?ajRodzVxZzBDVi90V002YzJBMlFMRW51cUVuOHRpZWZTOWlpeTJQa3c4SVE1?=
 =?utf-8?B?VlhOb0s3cldmc3h1ZFJkdHJ5T0Y5THM4RmR2RzdHVDM3MGVGK1h5NmlYSmF0?=
 =?utf-8?B?eEh0MGFEbDhrR2dKVkhMTjZOc0J4RUl6YXZpaHdJZ0w0V0VIaldHenVPYWxu?=
 =?utf-8?B?OFp3blcrNWpMWVoraXZKUHZ6b24yMVJ0TXBsV3NXUjhhN3FLREVHRklFK0F3?=
 =?utf-8?B?bmtQUmN0RVJSdHlFbXhwY1ZJNVR3MzRsd2dNb1J5NzR1WG81eFhybHdRRmRO?=
 =?utf-8?B?RzBlQm9vN0lnTC9veEdDRVM1Mk44NnhxeC90dSs4dDVpR1dCOFVjR2tuVDY2?=
 =?utf-8?B?RE92V2xHcjh2NTFRNmVYUkFaSVlUdUNCVkFOMlNyR1FhMTNUOCtCUzBZZ2Q4?=
 =?utf-8?B?T1lYYXB4UklTTzZSanlLZlduY1AyenJrT2dqTnRlTTMwOHgxY0hWSVZwajhs?=
 =?utf-8?B?QUtWS3hqSWhuNUd1dkEwZ2JRalFMNWErR1duS25CYlVDMXYwVkxpNTNtSEhR?=
 =?utf-8?B?bkJiVzNwZjRwWXBMSVRWa3V2bXR3UTBoRnBtblB1bzhaM3E0YU8yRlN3UjQ5?=
 =?utf-8?B?clB5dFhlU1UwbVUreTkyMG9Qc0cwQjlUTXdkVGt6ZXE1ZmJiQUV4RHFDcllq?=
 =?utf-8?B?MFJuT2FwQjJWUTVGVUdTU1ZoclFRTXlUVGo4Z3VWMWZIeDc2a2VoMFdkUkFO?=
 =?utf-8?B?KzQyNHJHM0x6ZFk5Rk5ZMGxsd0UweURtTDl3STdrWklFK3ZjeUcyekNPUmdo?=
 =?utf-8?B?emRWQmZ5ZHhONWZzaEtXMWRYRUhreTMvQ3R0MlZrRXFaYUFZaTl6blQ2M2hN?=
 =?utf-8?B?VmtPR3BSUmRIZGNLelJIQnJDR293VWZPSVRVVmVJZm1vWTNZcis1WkZDc3NO?=
 =?utf-8?B?dW5US0JHOHQySlEyZWh0aFdJLzhCMkNJakRINFRMb1ZOazNVL1VKd2QzdlMw?=
 =?utf-8?B?dzhZTDRBZTNsNlNHTnZoQ2RGMVlPbzFocXRhbmhNYjB3cHVrSDFQanV0WGY5?=
 =?utf-8?B?MXRYeVBJQjQ5STc4dFJkbk9lYkZSRzNVQ296Y0tmRGIrMTFwSy9oVnZNSGlk?=
 =?utf-8?B?bks2MWRRT3FWRDhNSUJKbW1RcmhVNjBXaVA3MFBxTGxTQ05EczViWG1US0ly?=
 =?utf-8?B?V2NXMCtSQXVMaWNKRlBqOERwZE1GUDBBRjlnZzE2K2ZzcytkcXZuTWxZUTRB?=
 =?utf-8?Q?SlOzsNHVad5psYyvFwS1NdA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E60373D0C2B43843A521074F7DD86273@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB3260.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd4fca9-5ca0-463d-136b-08dde61d2143
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 10:24:54.2628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBsWzZhHE0LRDO30ZhDgPjKdVp1KDbG9MPE3XKSsHxFKCxVr5HnjdDjO+w8wtsXAdI30iXN7ENYLw7bTcjt0hNyCW41CTbHErT/bQAglbME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4256

T24gOC82LzI1IDE0OjI2LCBBbGVrc2EgUGF1bm92aWMgdmlhIEI0IFJlbGF5IHdyb3RlOg0KDQo+
IFRoaXMgc2VyaWVzIGFkZHMgYmluZGluZ3MgZm9yIHRoZSBHQ1IuVSB0aW1lciBkZXZpY2UgYW5k
IGNvcnJlc3BvbmRpbmcNCj4gZHJpdmVyIHN1cHBvcnQuIEFjY2Vzc2luZyB0aGUgbWVtb3J5IG1h
cHBlZCBtdGltZSByZWdpc3RlciBpbiB0aGUgR0NSLlUNCj4gcmVnaW9uIHNob3VsZCBiZSBmYXN0
ZXIgdGhhbiB0cmFwcGluZyB0byBNIG1vZGUgZWFjaCB0aW1lIHRoZSB0aW1lcg0KPiBuZWVkcyB0
byBiZSByZWFkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGVrc2EgUGF1bm92aWMgPGFsZWtzYS5w
YXVub3ZpY0BodGVjZ3JvdXAuY29tPg0KDQpHZW50bGUgcGluZy4NCg0KSWYgdGhlcmUgYXJlIGFu
eSBmdXJ0aGVyIGNvbW1lbnRzLCB3ZSdkIGJlIGhhcHB5IHRvIGFkZHJlc3MgdGhlbS4NCg0KQmVz
dCByZWdhcmRzLA0KQWxla3NhDQoNCj4gLS0tDQo+IENoYW5nZXMgaW4gdjY6DQo+IC0gUmVuYW1l
IG10aSxnY3J1IHRvIG1pcHMscDg3MDAtZ2NydQ0KPiAtIExpbmsgdG8gdjU6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3IvMjAyNTA3MTEtcmlzY3YtdGltZS1tbWlvLXY1LTAtOWVkMWY4MjVhZDVl
QGh0ZWNncm91cC5jb20NCj4NCj4gQ2hhbmdlcyBpbiB2NToNCj4gLSBGaXhlZCBidWlsZCBpc3N1
ZXMgb24gMzItYml0IFJJU0MtViBhbmQgc3BhcnNlIHdhcm5pbmdzDQo+IC0gUmVtb3ZlIGNsaW50
X3RpbWVfdmFsIGFuZCBjbGludC5oLCByZXBsYWNlIHdpdGggcmlzY3ZfdGltZV92YWwNCj4gLSBE
ZXBlbmQgb24gUklTQ1ZfVElNRVIgaW4gS2NvbmZpZw0KPiBDaGFuZ2VzIGluIHY0Og0KPiAtIFJl
bW92ZSAic2VsZWN0IiBmcm9tIG10aSxnY3J1LnlhbWwuDQo+IC0gUmVmYWN0b3IgdGhlIGRyaXZl
ciB0byB1c2UgZnVuY3Rpb24gcG9pbnRlcnMgaW5zdGVhZCBvZiBzdGF0aWMga2V5cy4NCj4NCj4g
UHJldmlvdXMgdmVyc2lvbnM6DQo+IHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIw
MjQxMjI3MTUwMDU2LjE5MTc5NC0xLWFyaWthbG9AZ21haWwuY29tLyN0DQo+IHYyOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi8yMDI1MDQwOTE0MzgxNi4xNTgwMi0xLWFsZWtz
YS5wYXVub3ZpY0BodGVjZ3JvdXAuY29tLw0KPiB2MzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtcmlzY3YvRFUwUFIwOU1CNjE5Njg2OTVBMkEzMTQ2RUU4M0I3NzA4RjZCQTJARFUwUFIw
OU1CNjE5Ni5ldXJwcmQwOS5wcm9kLm91dGxvb2suY29tLw0KPiB2NDogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8yMDI1MDUxNC1yaXNjdi10aW1lLW1taW8tdjQtMC1jYjBjZjI5MjJkNjZAaHRl
Y2dyb3VwLmNvbQ0KPiB2NTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDcxMS1yaXNj
di10aW1lLW1taW8tdjUtMC05ZWQxZjgyNWFkNWVAaHRlY2dyb3VwLmNvbQ0KPg0KPiAtLS0NCj4g
QWxla3NhIFBhdW5vdmljICgyKToNCj4gICAgICAgZHQtYmluZGluZ3M6IHRpbWVyOiBtaXBzLHA4
NzAwLWdjcnUNCj4gICAgICAgcmlzY3Y6IEFsbG93IGZvciByaXNjdi1jbG9jayB0byBwaWNrIHVw
IG1taW8gYWRkcmVzcy4NCj4NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL21pcHMs
cDg3MDAtZ2NydS55YW1sIHwgMzggKysrKysrKysrKysrKw0KPiAgYXJjaC9yaXNjdi9pbmNsdWRl
L2FzbS9jbGludC5oICAgICAgICAgICAgICAgICAgICAgfCAyNiAtLS0tLS0tLS0NCj4gIGFyY2gv
cmlzY3YvaW5jbHVkZS9hc20vdGltZXguaCAgICAgICAgICAgICAgICAgICAgIHwgNjMgKysrKysr
KysrKysrLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnICAgICAgICAg
ICAgICAgICAgICAgICAgfCAxMiArKysrKw0KPiAgZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1j
bGludC5jICAgICAgICAgICAgICAgICAgfCAyMCArKysrLS0tDQo+ICBkcml2ZXJzL2Nsb2Nrc291
cmNlL3RpbWVyLXJpc2N2LmMgICAgICAgICAgICAgICAgICB8IDM0ICsrKysrKysrKysrKw0KPiAg
NiBmaWxlcyBjaGFuZ2VkLCAxMjggaW5zZXJ0aW9ucygrKSwgNjUgZGVsZXRpb25zKC0pDQo+IC0t
LQ0KPiBiYXNlLWNvbW1pdDogMDM4ZDYxZmQ2NDIyNzhiYWI2M2VlOGVmNzIyYzUwZDEwYWIwMWU4
Zg0KPiBjaGFuZ2UtaWQ6IDIwMjUwNDI0LXJpc2N2LXRpbWUtbW1pby01NjI4ZTBmY2E4YWYNCj4N
Cj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBBbGVrc2EgUGF1bm92aWMgPGFsZWtzYS5wYXVub3Zp
Y0BodGVjZ3JvdXAuY29tPg0KPg0KPg0K

