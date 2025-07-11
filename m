Return-Path: <linux-kernel+bounces-727088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10285B014D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C704A305A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696561EFFBB;
	Fri, 11 Jul 2025 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CSFiu+zf"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7021DDC15;
	Fri, 11 Jul 2025 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219510; cv=fail; b=fk2FdOdxh7Hkyv6zU8IIDjGtsAu/vSepnIKVDKTtSeukb7q/MWWxLSeDIs9SASG/N9umFxBZSUYqxfTLF++cGmp8Rb8XepARkb8Yi/NnmGLXub4idsQ7M+IhovUjoTMORRmNd4ZlOqOebhAXNy1JgwMOqhgEYbQ+7JEnj+eoEeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219510; c=relaxed/simple;
	bh=ZugQMU9GDSxSJ2br3LnoOd7L2CdHv4MZAqeprVd5K5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I609CLr1llL8fBwTwU78an3GtDgX/FoDQJv7GYUxQMarEMAfLsGUXYuXsw02Tw0fgJd5mPgPbkHWmI8GtkmHw60k7tF7ShBSzmHTFJmD3HexaMBp+/bZZgK3VmWdKjMhRT8TFuIdMnsxK/c/Cd310tk0NhOA7e4dkx14O9JfpCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CSFiu+zf; arc=fail smtp.client-ip=40.107.96.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THLVppqXrQ5Io0ueQc8pBIwgJyiC01AfOj8+wpmgV39hae+W6nD+RuTnJyLkma6kYK1qxprHwNB3PaYLa29wW00SM3hNhA50GTcWlvsVW3Coj+ksOGzzoN1vMRb7+AFjm6sAhFtjrBLmk5AZV9vJDQDu+02xDPWY8x+Km4H6eSMh8wBGtMXX0ie3OZXlGICTHVEJSVp0fyrHiE9xQcXc+xnsNfDxS7bhNBpfFi/RDNSn4o/roaX1kWxibO1DJuK4CTJvfLch3QMX2qvcLI8pgWk2w/HuwT7Z+MmSNuV+Vwd1NhJK3Dh6CpBDLuzPpDaxsKGCp3cyuRIqM1Xirj1Ygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZugQMU9GDSxSJ2br3LnoOd7L2CdHv4MZAqeprVd5K5g=;
 b=wM4gbP/5GY0ELhBCFZ0PRyR3H6jzgTIGh4gRbHFBuvRFCBurNNJrG1Oodil3wVQ1ZDk3NyXOWn7Rgf723sAaidpw9wz40uH8jvs39XB8+bFLr5LeEIUsUZFOL32F4TAA90qoSULvdlld73s6SybAJrkEMYsyoGpoADfgcvA/rF68qTYuRCvsH2k6SpjfL3kMNs1Es5WsIg0ZwJ6eFwTnSlMDS2CzEgQkLzEuDZsWcYDqt0iTnn/HjWQVd0fg/LAEaPLDufbjCV2bEPHyugoC0HL4hJvIbmlRv+zzyaTfcsib8XKYCVZNaENFai+fhfBVDkRMBSPrISGSQNLd7yTDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZugQMU9GDSxSJ2br3LnoOd7L2CdHv4MZAqeprVd5K5g=;
 b=CSFiu+zfYDfmtfuZsWxjT6a6NA0M4HbBVyzUDjAM8jIcrG1NFG7SOIAE5Cdg6MQRY+ENSCqptY3r1Q7OJbKCO537c+etpX0jS1T+XpEAiLb87pvgd5WxE9yP2tMbGo0PCIHtHr9C04yFH0h523RpgH/psjj3EDUK1BEPHGGtKUlDBa7MPb7MHnownO2y6rkGDOvV6af7v86pu/CuUdznDYySQLQ3UUMsF31Eue0eEgWl6V7Ey8+bhQ9FVSH2nrxukqDsmEQr3iLZSHzExZ0BbZl+Iw3t7CsStAkqw9F+PjLOdvJbOY0tY2QPtkRHeEWFuAKbpP5M+vah/OLG1jQ2XQ==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by PH0PR11MB7711.namprd11.prod.outlook.com (2603:10b6:510:291::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 07:38:22 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2%4]) with mapi id 15.20.8901.023; Fri, 11 Jul 2025
 07:38:22 +0000
From: <Varshini.Rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <Patrice.Vilchez@microchip.com>
Subject: Re: [PATCH] clk: at91: sam9x7: update pll clk ranges
Thread-Topic: [PATCH] clk: at91: sam9x7: update pll clk ranges
Thread-Index: AQHb2eQAPmUgICPA9EaQfapf002i07QR+LkAgAAi1ICAGRcfAIABhxoA
Date: Fri, 11 Jul 2025 07:38:22 +0000
Message-ID: <e59a1c94-e6b3-49c8-aa78-78d031e8a6ec@microchip.com>
References: <20250610084503.69749-1-varshini.rajendran@microchip.com>
 <c51b2b64-24a7-4e14-bdd8-c4a356423100@tuxon.dev>
 <0652df01-13e8-4fb8-a2e0-35820d83ac3d@microchip.com>
 <d1a16315-8e17-446e-87f2-57f18046288c@tuxon.dev>
In-Reply-To: <d1a16315-8e17-446e-87f2-57f18046288c@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|PH0PR11MB7711:EE_
x-ms-office365-filtering-correlation-id: fbeb7b01-12b3-4044-dfeb-08ddc04de9d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UU9BVnlLV2dOMmZHK0tZUGExQlM1ZnM2SlA2YWw5TmtzQVNwdXJKTFBqMmFM?=
 =?utf-8?B?TjBCeHFPM0FKcHVZdzArMjFNYVZOZnF6emhWOFNHdHN1T1ZFUkxOUmZpcHg0?=
 =?utf-8?B?WGxwSitGbCswS1lra2F3eVptbVRzekFDOXE4K2tKN0FFaW90RUxVUDBXMlQx?=
 =?utf-8?B?NkNmSGk4REFZNXZONVBzMGFhZGZJNmx4enNDTmlRcm1JOXF3TUNCb0ZkMk9h?=
 =?utf-8?B?R0FRV2lsUUlxU1l6Tzc2Zmpmd1A1S1gwNGhZOGFJRFJXcHZoeWNSYTNRbFFK?=
 =?utf-8?B?VWlxbkhTRXVEVkwrZFRvV0UwZk1WczhmemNpVVY0ZFhab2w0YmFyRVpGZitE?=
 =?utf-8?B?UGpGZkEzekVYbzkrMEdwWDk4OEtoYXl4WWlHd1NVbmxPSlZENGlSYTgxckNW?=
 =?utf-8?B?dHM4dVpkTGo3Q2hOb08rdHlBdUZCSFZYOURJMllVSTRnUk1JOVpLNmszSERK?=
 =?utf-8?B?RmdQVnl1VDVFeUxqN1plUmlsajBBYklIVm5jbVNEOFRZY2FzNHlOd01OUkM5?=
 =?utf-8?B?dHhGTGY1Q003K2tqR1U4QWs2U01ad2M0TVNSWUtBUUN6dEpmOXRETEF3RTRi?=
 =?utf-8?B?L2YwN2VyTXpIUHUvVWNCaUdyZklOT0RzVUlMVFlzN2dHV2N0SnRmek1zNVBY?=
 =?utf-8?B?QzZjd3RnNFR1Qy9qNnNmb2xMdjVXWkFKMjFpd1dqU01DTDhxcmp2YjVXdXpn?=
 =?utf-8?B?WkJvbXBDTm9FUmRLbno2dC9uVXkvTy9mVUdNaHhhc21WWWdzTktjcVhIU2th?=
 =?utf-8?B?MEo4M1NHRDJaV0R4UzVucG5NUFl2MGVsWStLNUhIekZZcWlPL3c5WWhZUTJW?=
 =?utf-8?B?bzR6eVFGS05EMXQ5QlloamRrK0pURk8rVU5EeC9wZmR1Z2prQTByZ2VjeS8r?=
 =?utf-8?B?T2JpOEVkZWo1bC9OSWRya0ZXOHBNNjhrZTN2bE9weG54V2R0K3FDQUJYeVFQ?=
 =?utf-8?B?TlNOdDZHNzR2RTkvemhHZVNzeFdJOFBCU1l2M3RsdlNiblpva2kxOHJUYmdv?=
 =?utf-8?B?ZDF0TnE2UG9JNTBjalovQzM1TGZwUU1oVjRrT1FWenhuNDhmSS9mdHdwcGd3?=
 =?utf-8?B?U21RaGc3a1dNcldIME9CaThTWnB6bWk5NXdNMUFwZ2JoQ3ZHcU1Pd2RSeDZo?=
 =?utf-8?B?UTZSODQrazBKaXpFNGRWdDhwZDFZREVVcTNURVhjS2VvNTBmdEdLOXVEdUVG?=
 =?utf-8?B?aUNNVGhYWDIySkZxTzdUOTIxekYveXVyck4rUGxodVJZSDZYRUVUSXdaaXo0?=
 =?utf-8?B?RUpYM21DUEg3dVQ4bzlkSkd3bGhYZSs0SllXTk1EcUVOTUdheEptYmFzUW1z?=
 =?utf-8?B?Y0o0eXZZTFVCYTM1MEFtTHlpcDlkbjRFajVMRlJtZ3ZWMjB3L2luamdkRUUy?=
 =?utf-8?B?UWVla25kaHlkTmFjVXhaaXBZVHJLNk5MYmpwUzlzcUVMSVhGSlZWZFBuU1JU?=
 =?utf-8?B?aDlTUENzTFI5T3gxNytpR2w2UWlxVEFKTDhYWlZLOU1JQUZLM0gxdTRlR1hh?=
 =?utf-8?B?NU80ZUhUWVU3SkZlTkZvMlI1RXFrYkh3NHRzZWpJdG5qSm9WTWV6UCswUnJk?=
 =?utf-8?B?bWlTaG9OR2NEUnBFQU9kYmZuaU5IaHdFL3JtZHFCYmpMVXlERDcxZC80Z0FG?=
 =?utf-8?B?cGtPSHRVODVOaE9OdlcyZis0T1BucHpPRTgxTGlYZFdWMERBZkpTY2YwUENT?=
 =?utf-8?B?OWNsWDVjdjMwL0lxUkpqU2oyR0NPSjNFRHJZTG5tKzlsTjh5NHc2MmNiZmxr?=
 =?utf-8?B?aEx3U3lMS1A1NVRoMDBYOXAxR3NYbWpaRGhyVjFvRjVNMFNlSUJXYWp5dFBa?=
 =?utf-8?B?Q016MDdrK2xHL21WUk1EYUU0ajE5L2h0OG5UemhDTWc4L0ZIbDBUc3E5aUM5?=
 =?utf-8?B?YXJjTE9ETkhXaExscExwbmlCdWVMSDBEQ0JtaVBwRkw2bzdoK3J0QkJYQjU5?=
 =?utf-8?Q?ru6hqIHlugk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3BJa3l4UWhWM1ozUmQ2Uk1Yc3pONklISi9hU0kwY01YekIzTDFERHNCNys0?=
 =?utf-8?B?UmdvTnhsaDZkMi80SmVLNVFlOWlmRFUxV0w2Wm9TVTUrQ0s3eG9QTXI0ZDNQ?=
 =?utf-8?B?cTNFdWFDV0pqYXE5dXVXTjJuR2txUVpSYjVnNXpZdmxRQldmbEU5NFpnbS9v?=
 =?utf-8?B?RjBNczdZWm91NnlFK0pSdk5WRjg2dDhmZWloSEd3eUIxYU95YjJ1ZWM0SjVH?=
 =?utf-8?B?Zzl2cXRvellsY01LRGNmNkdSR2hFZkJQQUdkempuaWw1cm1ra3Rmc0lDT3pV?=
 =?utf-8?B?T2hyL29rbE03eGpqVFZaYzRTU1ZlWGpzbktGbmdmVkpYRDlXZlM0NVVjT2RE?=
 =?utf-8?B?QmNwcGRiRytPVURUYTFibkdZZk50WFpOc1FjNzQvK2lEeDMrTjNaRktzYk5P?=
 =?utf-8?B?QU9vWU8xSVkrZ3BkMUVNQWptYzU0VkFveUhNN015dkQ0QXpLUW1nOWhxS3NI?=
 =?utf-8?B?OEVCL1RlUFMzTzB1YkswVXIrMnc2QmVRNTlDNGllRkF4Qk5qdHNnMGdUay9J?=
 =?utf-8?B?Q29TM3FpOVFkWlR3QXplY1RKWGlQa2hUd2ZBUE9aTlJ0SG1hakxRYU1NM3R1?=
 =?utf-8?B?eFVUT1dtOXN5eWFXUGVQd082T2ZyMTBXbUo0UlczU0hyK2N0K2hRTzdRWkdR?=
 =?utf-8?B?dEZ3NDcydm5XV2tNQzRQRDlsamtNZElkYVBLdkFPUSthUDVFUUNZRDRwRDVy?=
 =?utf-8?B?TGNUMGxPWnN3MlN3OUw1M0QydHRLd1REYU01a0QvVUd4VmVCRXNxQVNPVmFt?=
 =?utf-8?B?c21uUHM3MHVGSUE4TzdaNWNHSWIyaGRhUkFHSHJHQWNPeHRnRlBIeWltcWto?=
 =?utf-8?B?QnY0Nk1oQXl4NTdvY3FNbTIwMnJIUXQxeUE5bUJGL3lGZTA5cnQyc3FNR21m?=
 =?utf-8?B?L1RyNU8yazQ5ZDZvblRqNVhrVUczQUV1czBna0trM3prMDVHR253eTF0cXhR?=
 =?utf-8?B?a29TelVOT3RvV084Mnh2S1J5YWVzQTdTd2NUeGpVL1NnYWdaWHFWUThmbHMr?=
 =?utf-8?B?cE1hMDZoK0lZTmdjc2JLaitiZFhXeFV6Y01xVkdXbTY0TTMrTUc0ajl5OUw0?=
 =?utf-8?B?Q29KTWdGQ2tLcHBYR1Y1WnF1eC9JdGJlNDN1TWdCbVlrNUZUNThHUUN2M2hk?=
 =?utf-8?B?M1RhOWNkZHFPSGcxdDJaeUlIMTR4Ung2SEViYXQ3MWhNamluZG1rRFpId1NU?=
 =?utf-8?B?R1B6L0N1Ky83ZGppRlQ2OUtBaUVtMlp2a1dKZTIvY3B2NVgwUUJXNlFZMUdq?=
 =?utf-8?B?c1VZK1QzSzNKSTRQYmFVcUptQ2J0RjNTVlZIZ0dtajRBUzRYYWpaRGZEUGYv?=
 =?utf-8?B?V1E3STBnUXVkSkNmVUdEZm9QZzYyUkhPL1pxbUpKMXk1NDlxZG0yejlqdHBy?=
 =?utf-8?B?aC9kR1dDS0wvMUlxYjRwRW5XMHdYQTJmM2Fva2xkeEduQ3ZFcVlIQ05QYUNk?=
 =?utf-8?B?VVVrcHZ6OFI1MVpYNEJOVHlYakNJUDR5Lzk2YnpOZXA2c3dyS0NWZ3RxZUpt?=
 =?utf-8?B?RGNkS0pveEwwQmtLN1RHZ3dMS1lrbmFPYjczMVB4cmE5UWx6b0RqVWlkS0Vj?=
 =?utf-8?B?dUFpRkxpMGVUM09iUUlRWVl6SlA3U2pqbE1hWU5mSGRwdTNXZ0liZXY4dXRB?=
 =?utf-8?B?b0FHdjBwVXMrWEdNZk5mMmlHRTlnTFNiOXJoTjROWVczMFBCMjBFOFM2Mmg1?=
 =?utf-8?B?TDBjVEpPYlZVNWtEdjVYMkdXUHJ5MnRMYTlXUEhlM2pDRStBL1RCUTZXUzNV?=
 =?utf-8?B?dXlQZUtEenJqUGRsVnJ4VVBsK3NNdmNpcUJ3eEp4eXNqYUhzYzFucUpuSGli?=
 =?utf-8?B?TExOdmFXS29YTFkxYURrNEpRU3FHTlQ4bmxVMk4rWGIzbGw4VExGcGkzTmlr?=
 =?utf-8?B?allJUFladDFDYTJsdVVWZk5pK3Y4NlhRSzNrNFp0S1N1cE1ETTFHV2lIVzVy?=
 =?utf-8?B?ZUdqOHFqMkx6T0QrT1NtVXdjeTl5S1FMTGMxWUx5T1p6WG9aejZGTEJ6Yld4?=
 =?utf-8?B?NHp0M0orS2lRYTdYQjdDeC9CbCt6U3FQK2F0ZHhkUjB2bUlMQlpMRkcvZ0Nk?=
 =?utf-8?B?SDgvWWw0cUdNRUZOb2t1Y0VUVElSa2ZZL1JTamo0bHdjbGtGVHQrRWFEWEYz?=
 =?utf-8?B?SlNGbHFrUWNGWUlRNWk0K0JxMmtRbUdReklEVjZvS3RKQmdnK3lSejVwM1RZ?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70B08ADE30DEF543A39622BE80158F69@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbeb7b01-12b3-4044-dfeb-08ddc04de9d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 07:38:22.4280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRRzm0QR7pPIw6WUWEr61jgCA+K5bow+3I98Zrbko7XE8hTQfdBncwlXhfl9Pn+cMckMcyVAH/1CC/pQV4JhQUE/C3/74Ms+IWhA9WFgCkrrqjsMhLwr6lOJkybNoQeJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7711

SGkgQ2xhdWRpdSwNCg0KT24gMTAvMDcvMjUgMTo0OCBwbSwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGksIFZhcnNoaW5p
LA0KPiANCj4gT24gMjQuMDYuMjAyNSAxMjowOSwgVmFyc2hpbmkuUmFqZW5kcmFuQG1pY3JvY2hp
cC5jb20gd3JvdGU6DQo+PiBIaSBDbGF1ZGl1LA0KPj4NCj4+IE9uIDI0LzA2LzI1IDEyOjM0IHBt
LCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUNCj4+Pg0KPj4+IEhpLCBWYXJzaGluaSwNCj4+Pg0KPj4+IE9uIDEwLjA2LjIwMjUgMTE6
NDUsIFZhcnNoaW5pIFJhamVuZHJhbiB3cm90ZToNCj4+Pj4gVXBkYXRlIHRoZSBtaW4sIG1heCBy
YW5nZXMgb2YgdGhlIFBMTCBjbG9ja3MgYWNjb3JkaW5nIHRvIHRoZSBsYXRlc3QNCj4+Pj4gZGF0
YXNoZWV0IHRvIGJlIGNvaGVyZW50IGluIHRoZSBkcml2ZXIuIFRoaXMgcGF0Y2ggYXBwYXJlbnRs
eSBzb2x2ZXMNCj4+Pj4gaXNzdWVzIGluIG9idGFpbmluZyB0aGUgcmlnaHQgc2RpbyBmcmVxdWVu
Y3kuDQo+Pj4+DQo+Pj4+IEZpeGVzOiAzMzAxM2I0M2UyNzEgKCJjbGs6IGF0OTE6IHNhbTl4Nzog
YWRkIHNhbTl4NyBwbWMgZHJpdmVyIikNCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBQYXRyaWNlIFZpbGNo
ZXogPFBhdHJpY2UuVmlsY2hlekBtaWNyb2NoaXAuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBW
YXJzaGluaSBSYWplbmRyYW4gPHZhcnNoaW5pLnJhamVuZHJhbkBtaWNyb2NoaXAuY29tPg0KPj4+
PiAtLS0NCj4+Pj4gICAgZHJpdmVycy9jbGsvYXQ5MS9zYW05eDcuYyB8IDIwICsrKysrKysrKyst
LS0tLS0tLS0tDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMCBk
ZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvc2Ft
OXg3LmMgYi9kcml2ZXJzL2Nsay9hdDkxL3NhbTl4Ny5jDQo+Pj4+IGluZGV4IGNiYjhiMjIwZjE2
Yi4uZmZhYjMyYjA0N2EwIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2Nsay9hdDkxL3NhbTl4
Ny5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEvc2FtOXg3LmMNCj4+Pj4gQEAgLTYxLDQ0
ICs2MSw0NCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19tYXN0ZXJfbGF5b3V0IHNhbTl4N19t
YXN0ZXJfbGF5b3V0ID0gew0KPj4+Pg0KPj4+PiAgICAvKiBGcmFjdGlvbmFsIFBMTCBjb3JlIG91
dHB1dCByYW5nZS4gKi8NCj4+Pj4gICAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfcmFuZ2UgcGxs
YV9jb3JlX291dHB1dHNbXSA9IHsNCj4+Pj4gLSAgICAgeyAubWluID0gMzc1MDAwMDAwLCAubWF4
ID0gMTYwMDAwMDAwMCB9LA0KPj4+PiArICAgICB7IC5taW4gPSA4MDAwMDAwMDAsIC5tYXggPSAx
NjAwMDAwMDAwIH0sDQo+Pj4+ICAgIH07DQo+Pj4+DQo+Pj4+ICAgIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgY2xrX3JhbmdlIHVwbGxfY29yZV9vdXRwdXRzW10gPSB7DQo+Pj4+IC0gICAgIHsgLm1pbiA9
IDYwMDAwMDAwMCwgLm1heCA9IDEyMDAwMDAwMDAgfSwNCj4+Pj4gKyAgICAgeyAubWluID0gNjAw
MDAwMDAwLCAubWF4ID0gOTYwMDAwMDAwIH0sDQo+Pj4+ICAgIH07DQo+Pj4+DQo+Pj4+ICAgIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgY2xrX3JhbmdlIGx2ZHNwbGxfY29yZV9vdXRwdXRzW10gPSB7DQo+
Pj4+IC0gICAgIHsgLm1pbiA9IDQwMDAwMDAwMCwgLm1heCA9IDgwMDAwMDAwMCB9LA0KPj4+PiAr
ICAgICB7IC5taW4gPSA2MDAwMDAwMDAsIC5tYXggPSAxMjAwMDAwMDAwIH0sDQo+Pj4+ICAgIH07
DQo+Pj4+DQo+Pj4+ICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2xrX3JhbmdlIGF1ZGlvcGxsX2Nv
cmVfb3V0cHV0c1tdID0gew0KPj4+PiAtICAgICB7IC5taW4gPSA0MDAwMDAwMDAsIC5tYXggPSA4
MDAwMDAwMDAgfSwNCj4+Pj4gKyAgICAgeyAubWluID0gNjAwMDAwMDAwLCAubWF4ID0gMTIwMDAw
MDAwMCB9LA0KPj4+PiAgICB9Ow0KPj4+Pg0KPj4+PiAgICBzdGF0aWMgY29uc3Qgc3RydWN0IGNs
a19yYW5nZSBwbGxhZGl2Ml9jb3JlX291dHB1dHNbXSA9IHsNCj4+Pj4gLSAgICAgeyAubWluID0g
Mzc1MDAwMDAwLCAubWF4ID0gMTYwMDAwMDAwMCB9LA0KPj4+PiArICAgICB7IC5taW4gPSA4MDAw
MDAwMDAsIC5tYXggPSAxNjAwMDAwMDAwIH0sDQo+Pj4+ICAgIH07DQo+Pj4+DQo+Pj4+ICAgIC8q
IEZyYWN0aW9uYWwgUExMIG91dHB1dCByYW5nZS4gKi8NCj4+Pj4gICAgc3RhdGljIGNvbnN0IHN0
cnVjdCBjbGtfcmFuZ2UgcGxsYV9vdXRwdXRzW10gPSB7DQo+Pj4+IC0gICAgIHsgLm1pbiA9IDcz
MjQyMSwgLm1heCA9IDgwMDAwMDAwMCB9LA0KPj4+PiArICAgICB7IC5taW4gPSA0MDAwMDAwMDAs
IC5tYXggPSA4MDAwMDAwMDAgfSwNCj4+Pj4gICAgfTsNCj4+Pj4NCj4+Pj4gICAgc3RhdGljIGNv
bnN0IHN0cnVjdCBjbGtfcmFuZ2UgdXBsbF9vdXRwdXRzW10gPSB7DQo+Pj4+IC0gICAgIHsgLm1p
biA9IDMwMDAwMDAwMCwgLm1heCA9IDYwMDAwMDAwMCB9LA0KPj4+PiArICAgICB7IC5taW4gPSAz
MDAwMDAwMDAsIC5tYXggPSA0ODAwMDAwMDAgfSwNCj4+Pj4gICAgfTsNCj4+Pj4NCj4+Pj4gICAg
c3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfcmFuZ2UgbHZkc3BsbF9vdXRwdXRzW10gPSB7DQo+Pj4+
IC0gICAgIHsgLm1pbiA9IDEwMDAwMDAwLCAubWF4ID0gODAwMDAwMDAwIH0sDQo+Pj4+ICsgICAg
IHsgLm1pbiA9IDE3NTAwMDAwMCwgLm1heCA9IDU1MDAwMDAwMCB9LA0KPj4+PiAgICB9Ow0KPj4+
Pg0KPj4+PiAgICBzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19yYW5nZSBhdWRpb3BsbF9vdXRwdXRz
W10gPSB7DQo+Pj4+IC0gICAgIHsgLm1pbiA9IDEwMDAwMDAwLCAubWF4ID0gODAwMDAwMDAwIH0s
DQo+Pj4+ICsgICAgIHsgLm1pbiA9IDAsIC5tYXggPSAzMDAwMDAwMDAgfSwNCj4+Pg0KPj4+IElz
IHRoaXMgbWluIHZhbHVlIHNvbWV0aGluZyB2YWxpZD8NCj4+DQo+PiBZZXMuIFRoaXMgaXMgYSB2
YWxpZCB2YWx1ZSBtZW50aW9uZWQgaW4gdGhlIGRhdGFzaGVldC4gVGhpcyBpcyB0aGUgcmFuZ2UN
Cj4+IHRoYXQgZml4ZXMgdGhlIGlzc3VlIG9mIG5vdCBiZWluZyBhYmxlIHRvIHNldCBsb3cgZnJl
cXVlbmN5IHZhbHVlcyBmb3INCj4+IHRoZSBTRElPIGludGVyZmFjZSBmb3IgaW5zdGFuY2UuDQo+
IA0KPiBTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuIFRoaXMgcmFuZ2UgaXMgZm9yIGF1ZGlvcGxs
LiBDYW4geW91IHBsZWFzZQ0KPiBleHBsYWluIGluIHRoZSBjb21taXQgbWVzc2FnZSB3aHkgdGhp
cyBmaXhlcyBpc3N1ZXMgd2l0aCB0aGUgU0RJTyBpbnRlcmZhY2UuDQoNCkkgY2FuIGRvIHRoYXQs
IHdoaWxlIGRvaW5nIHNvLCBJIGNhbiByZXBocmFzZSBpdCBhcyB3ZWxsLiBTRElPIGlzIGp1c3Qg
DQphbiBleGFtcGxlLCBJdCBjYW4gcG90ZW50aWFsbHkgZml4IGFueSByYW5nZSBpc3N1ZXMgaW4g
YW55IGNsb2NrIA0KYXNzb2NpYXRlZCB3aXRoIHBlcmlwaGVyYWxzIGNhbiBoYXZlLg0KDQo+IA0K
PiBBbHNvLCBoYXZpbmcgemVybyBoZXJlIGFzIG1pbiByYXRlIHdvdWxkIGludm9sdmUsIGFzIG9m
IG15IGNvZGUgaW5zcGVjdGlvbiwNCj4gc2V0dGluZyBmcmFjLT5tdWwgPSAtMSBmb3IgZGlzYWJs
ZWQgUExMcyBvbiBwcm9iZSAoSSBzdXBwb3NlIGF1ZGlvIFBMTHMgYXJlDQo+IGFtb25nIHRoZW0p
LiBQbGVhc2UgY2hlY2s6DQo+IA0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92
Ni4xNS41L3NvdXJjZS9kcml2ZXJzL2Nsay9hdDkxL2Nsay1zYW05eDYwLXBsbC5jI0w2OTMNCj4g
DQo+IEhhdmluZyBmcmFjLT5tdWwgPSAtMSBtZWFucyBmcmFjLT5tdWwgPSAweGZmIG1lYW5pbmcg
dGhlIEhXIHJlZ2lzdGVycyB3aWxsDQo+IGJlIHNldCB3aXRoIHRoZSBtYXhpbXVtIG11bHRpcGxp
ZXIuIElmIG15IGFzc3VtcHRpb24gaXMgcmlnaHQsIGZvciBhDQo+IHJlZmVyZW5jZSBjbG9jayBv
ZiAyNE1IeiB0aGlzIHdpbGwgbWVhbiB0aGUgRmNvcmVwbGwgd2lsbCBiZSAzODRNSHogd2hpY2gN
Cj4gaXMgbm90IGluIHJhbmdlIGZvciBGY29yZXBsbCBzcGVjaWZpY2F0aW9ucyAoZGVzY3JpYmVk
IGJ5DQo+IGF1ZGlvcGxsX2NvcmVfb3V0cHV0c1tdKS4NCj4gDQo+IFRoaXMgbWF5IGJlIGhhcm1s
ZXNzIGlmIHRoZSBQTEwgaXMgdW51c2VkIGF0IGJvb3QgdGltZSwgb3IgcmVjb25maWd1cmVkDQo+
IGxhdGVyLCBidXQgaWYgdGhlIFBMTCBpcyBqdXN0IGVuYWJsZWQgbGF0ZXIgKHcvbyBzZXR0aW5n
IGFnYWluIHRoZQ0KPiBmcmVxdWVuY3kpIGFuZCB0aGUgY29yZSBvdXRwdXQgZnJlcXVlbmN5IGlz
IG5vdCBpbiByYW5nZSAoZGVzY3JpYmVkIGJ5DQo+IGF1ZGlvcGxsX2NvcmVfb3V0cHV0c1tdKSBp
dCB3aWxsIGxlYWQgdG8gUExMIGxvY2sgdG8gdGFrZSBmb3JldmVyIGFuZCB0aGUNCj4gZXhlY3V0
aW9uIHRvIHN0dWNrLg0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgY2hlY2sgdGhpcz8NCg0KSSBpbnNw
ZWN0ZWQgdGhlIGNvZGUgb24gbXkgc2lkZSBhbmQgZGlkIHRoZSBjYWxjdWxhdGlvbnMgYW5kIEkg
ZGlkbid0IA0KcXVpdGUgZ2V0IHRoZSBwYXJ0IGhvdyB5b3UgYXJyaXZlZCBhdCB0aGUgdmFsdWUg
Mzg0TUh6LCBteSBiYWQuIEJ1dCBJIA0KZGlkIGdldCB5b3VyIHBvaW50Lg0KDQpXaGF0IGlmIEkg
c2V0IHRoZSBtaW5pbXVtIEF1ZGlvUExMIG91dHB1dCB0aGF0IGNhbiBiZSBvYnRhaW5lZCBmcm9t
IHRoZSANCmNvcmVjbGsgb3V0cHV0IHJhbmdlIHdoaWNoIGlzIDYwME1IeiBtaW5pbXVtLCB3aGlj
aCBnaXZlcyB1cyAyMzQzNzUwSHogDQphcyB0aGUgbWluaW11bSBBdWRpb1BMTCBmcmVxdWVuY3kg
YWNoaWV2YWJsZSBmcm9tIHRoZSBkaXZpZGVyIHBhcnQuIElmIA0KdGhhdCBpcyBva2F5IEkgY2Fu
IHNlbmQgYW5vdGhlciB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2guDQoNClRoYW5rIHlvdSBmb3Igc3Bl
bmRpbmcgdGhlIHRpbWUgdG8gcmV2aWV3IG15IHBhdGNoIGFuZCBmb3IgdGhlIGRldGFpbGVkIA0K
ZXhwbGFuYXRpb25zLg0KDQo+IA0KPiBUaGFuayB5b3UsDQo+IENsYXVkaXUNCj4gDQo+IA0KPiAN
Cg0KDQotLSANClRoYW5rcywNClZhcnNoaW5pIFJhamVuZHJhbi4NCg==

