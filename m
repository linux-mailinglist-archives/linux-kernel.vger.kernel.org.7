Return-Path: <linux-kernel+bounces-792288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEA5B3C254
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E39A6111F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF534165E;
	Fri, 29 Aug 2025 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="OKbrGx3u"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2121.outbound.protection.outlook.com [40.107.236.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62E77111;
	Fri, 29 Aug 2025 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491454; cv=fail; b=J3ZK51toPoFkTcNzD4y8JvHp3n6YeYUcnXo5qpNwc4N9yo3vXtvWVbKdbMzRTp6ZQMWoJlIYE8woNf//LttJ9tsoTqgQUscOrEaj5XlUdbRSUtSWsJYGRJJrjezSu5vQ2xEW2Li38Co+0NMys73uxQbpHwzgYN8z6RrD9GC4dMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491454; c=relaxed/simple;
	bh=zZEyKm9FEeCZLquISkYDu1E6hhGfkNEZQPUDqJwMTzg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gbhFJW/16+s6tA0oEJ4AYhojcHaI0C+zpjb5i8hx7YTjWFtramhnydUcjr3pW95qZ57DzBtEKdnIOHFIXXOhpoBLyx9u6o/M7ktjJ6WREAaO88AiP5KOOfSZI77siTIKU/7K7+SHgBEHJ6MarZRga2LvhOgToEYJXmQItXSXpKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=OKbrGx3u; arc=fail smtp.client-ip=40.107.236.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNlZ0XKZMP9sLvnifnOzSbQ2QCwvwWTpCqNbMQ/MkzoQhjgMET7NNlJ9oQSQgYsFH13I45N2X469zU6zFcDPqgas/Qs2VjeTEyAgGX0Swwl39QOHXnkOWPFQqkHXjNH512M2UF3AI0IOySoJgi5KIBybC28CQke/Uwm/SABA1In12ng+nzpoV6W5c5rnE+GyCV3Vyl/ZKTFiNHcEEw+59QzfbaHSf06UjEU2xNSxwewEQoDe9KPrYr8vs+OflBXxmVxBNyMlqePWbCVaR0fcVxptj8lMM84pZlqZfJmuK1fdfbP9vVMVfYlv2glBeXDWoT8PNDU99oD56UpaK50Nlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZEyKm9FEeCZLquISkYDu1E6hhGfkNEZQPUDqJwMTzg=;
 b=pPvRJ7c1357xqGX1d0DWVvhlnuOYtQOW3/WEUBeNMKHYW9UAJx0hlHJLCTfisRkV4U9BCqnHMB2z5iMrOxy0GhETZ+qtY2s5ihwgC9SzZkrxIYMobHS5RGgk1APT+YJlrI5VBvY1Mx7yT1GOpN4kXmsA6hGX/oMWf3qLj7LUsfcXCyk3/B8WTUV9npNKdmmBWyKRok1OGF6wZ266jns0nXc1ImeGjqzDpnt7VR6ZiDxUZdbK62IxhGzx8u8m95VZp9Rzto6F2IMglYu0udqCkT7xseA35wx/auhK/pCzyf1TpdVbWmiFOgPJA6vTBACWfKPhPdWo1ABPonPHVPBhuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZEyKm9FEeCZLquISkYDu1E6hhGfkNEZQPUDqJwMTzg=;
 b=OKbrGx3uaIFgVsIAHZlVn9w3vWSbHyx1QTOgQVhNIqEgGU6H5zkeQqpOhm8aOIk1QrTSc8iddk0XkC88fjYzpP3+JS8Tch8hI89HMw2taQf7Wd6m/0vVcOvurGAWncFERQKvwkIcXIxRMUF/4OhwrBkrFxLUNPTljQpvLzod8eKYJYh95r/xwGW8i6Orq4Jt+mkgm9UI1vKYMMB+WlbwO79XbaJKHOcsLW6C9mv6TCj17cS8VcasIoCOL8zqx6maEoZQ0Rk/wKrFZyyfj6PxYzDufBhbwAOTpeRIyrQRlqVRZaeyfP1IMbkrZ2avHbC2Amtx4M8DUoK01yw1+ctBgQ==
Received: from IA0PPFBEC4B1F8E.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::c3d) by MN0PR18MB5944.namprd18.prod.outlook.com
 (2603:10b6:208:4be::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 18:17:19 +0000
Received: from IA0PPFBEC4B1F8E.namprd18.prod.outlook.com
 ([fe80::fc1b:1122:169a:5b79]) by IA0PPFBEC4B1F8E.namprd18.prod.outlook.com
 ([fe80::fc1b:1122:169a:5b79%5]) with mapi id 15.20.9052.014; Fri, 29 Aug 2025
 18:17:18 +0000
From: Harshit Shah <hshah@axiado.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "soc@lists.linux.dev"
	<soc@lists.linux.dev>, "soc@kernel.org" <soc@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: axiado: Add missing UART aliases
Thread-Topic: [PATCH v3] arm64: dts: axiado: Add missing UART aliases
Thread-Index: AQHcGEmAHveBGp5910y12eBPOJIdDrR5I3OAgADOSAA=
Date: Fri, 29 Aug 2025 18:17:18 +0000
Message-ID: <cb78b679-e349-43dc-a6ed-5b63b10d0d7f@axiado.com>
References:
 <20250828-axiado-ax3000-missing-serial-alias-v3-1-393111f4bd9e@axiado.com>
 <4e51bbdc-744b-4a23-a695-a6c49d82e779@linaro.org>
In-Reply-To: <4e51bbdc-744b-4a23-a695-a6c49d82e779@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPFBEC4B1F8E:EE_|MN0PR18MB5944:EE_
x-ms-office365-filtering-correlation-id: 95951073-f886-4c37-ae7f-08dde7284a3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1Q1U0g5TDJidGxHYWN1K1ZacGhsaktKMzhBczFQVmRqSkhydWxBQ0NBMDI1?=
 =?utf-8?B?VytCcDczR2FLNkZHemR1N3haaTdDU0luejJQbFhJU2pEby94NmVxcVZqcXNG?=
 =?utf-8?B?aVpaR0pJeGFteUVIUEpSWWRocGo1aGFuOXB1UzdmSDR6MUNPK09KNGc0TFYw?=
 =?utf-8?B?bFFlQS9wNUNzQ3lJbXFhOUZiNEd3S0EvU0pCQW4ralU5VjBDUDMvcGdYeUts?=
 =?utf-8?B?U2ZuNVYvOWtUTHhySVcxN0VaeWVnblZFT0R1dExOdFo5MnYrSlZLeHNxTjY3?=
 =?utf-8?B?UVNTSTBIbGFGZjhQN0t5TWZpN3RvZS9OVXJyM1VuckF6VnpQZGYxYlhmUWZo?=
 =?utf-8?B?WTEwRExHKzR3WkdWazZmc3V1UGhQSXdPcnhFeEVsa0JHbE1wdnpZSW1ML2Ft?=
 =?utf-8?B?TlN6WDROMVlBTGlTamM0Z2ZHZmxUcnp2MHVZMHFjRXhUWUtZN3p3N0hsUHAz?=
 =?utf-8?B?Z2greks1ODhFT1MwQXVDMWg5RFlZMTM5YVYyZStoM0VNTTQxSHduY24rcTNG?=
 =?utf-8?B?Z3czRmVtRUhsRXBmdklMMkluMlFKWFhIdlV6SGp6VWhZc1h0L1QyczFJTkxL?=
 =?utf-8?B?dXB5cm9CK0s1Vk5lRGhoRDJObHNkaTYxYlZqTUg1WkU1QWpGTGxXNXZzV1dJ?=
 =?utf-8?B?TXhqV2tyL28yeFFsY2NTQUxNUk96alJ3VGcrWFFDYTVLWlgzL2lUSVhBdE5C?=
 =?utf-8?B?Z09zUW9jZmhENGpTS1FNV1hxSUx6ZEpFdTFEM1grQk1PcFRzek93RUVPQmor?=
 =?utf-8?B?aFRQMFAwRVQxYVhDdGtvUlJEY1lsb0hiVWpSZXRxOGNOams5WXpYT0lOaTND?=
 =?utf-8?B?NmRRMkw5eCtPM3hwd3FBcnNqRFN5RGpmTDJXbHkvelRuVXFqU3VwalFDaVUw?=
 =?utf-8?B?ZEtoNExua3pyK3J4ckxhak54SmJ1NjlhT2V2ZTYveUpaRDFiRkNWU2h5TlQy?=
 =?utf-8?B?cnBML0k5d0htRVJpSDJFMUdnTCtvUUFrd2llUGpCNyt3VXhIZW1JZmNEcUsz?=
 =?utf-8?B?bktuNUE5MTkzeXFPUVVFK010Z1ZncUxUZFUwV0doRklLa1FQWUdUZmRZOTUy?=
 =?utf-8?B?eUhabE0vS1Q1akVVQ1U2T2V3dkUrU1ZVdThUYW5PYjc2djZ2MjhZM0V5czJp?=
 =?utf-8?B?WkJMME9rUWlsaXRnU1lnZDNtUlA2UWsvc3BjQkhmME5icGtHa01XVEkwVWMz?=
 =?utf-8?B?Ykc2UGJPUkF4Zm84ODZaemFqSWVJenN2ZDFpT2FWZUFyWDB1S01YYWlGaTZi?=
 =?utf-8?B?T3pEVnNIUDVuSCtSZ2xaZ0dld0Z2SmhCRi8zRUlNTEZvUmJKMVVMSjc2UVVj?=
 =?utf-8?B?NXdGSWN2dlVTS1ZqQzZKcUd4MzJQeUFIV2h0L1hXbmdqbmxWLzNQWWVkUEE4?=
 =?utf-8?B?VnhUTVBRUUI5aVVrMGZ4NVR5eWtxdFFHMEUzTU1wMUdIKzZ4QnpqakF2VmMy?=
 =?utf-8?B?a2s5clUxb2xNTTNWMExNMEhHbVJad2pCdkdKNGlyM0Y2VmJyUHZ1NU1LcDlH?=
 =?utf-8?B?MkVGNEtMb2hwNldVeVR0NjJmOWtzRTJyVFM1OW8zMWd1aUlDTzhHaTh0SGRy?=
 =?utf-8?B?YWJMdlIxbmlla1FaNEpTNExJK2JBTVgvdjM0MUJ6T2NBSWR5ZGluZ1g5dDNa?=
 =?utf-8?B?NDl2QTRJZml5NjNVT3VkMEY3WTJoNElUTVN0OUplZHVVaWZLcThvVGtmQ3lt?=
 =?utf-8?B?aEFTNkxRRjRYTTBraXhDa1o0WWp2OU04ZmVSU2Y3M3ViY29LSFFwV0hPU2tn?=
 =?utf-8?B?QWx0Q01DTStPVjl5eWVUSUFTTENRcDF4S0h4NjhlVHhNV3pRZzcySDNLRGhG?=
 =?utf-8?B?S2ZNWmFka09JWjc0R01HVVVLZnlRRlVCcDNtV0tqa3V2TGpNdUZibXpUMGhS?=
 =?utf-8?B?RjFZb3UwYWFGT0FLQmJwdTJpRCtoTlZKZ0x4OHJuakkwMUwxV0JtMHFLWVdE?=
 =?utf-8?B?elFrZ1lpTTIyYjZYYk8vOGZ1TmlsYUtjWlJLU09Qd2ZEWUpERXh6YitFSEFZ?=
 =?utf-8?B?Ym1rVnk2Qjl3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPFBEC4B1F8E.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWRBclFRNzNlY1dGZExTREpMcDVoNUQzSkkxZXRRQk1GaCtOV1oxcmRCNUw2?=
 =?utf-8?B?WlJjajVWUm5FTUJXN2hwYnJoNTJ6WTlCbFZUeVV1dnJ4aW1FaVJFd0FhV0tR?=
 =?utf-8?B?ZUc5L09BdkR4QWVsVmJVZEl1cmpQdHg3LzFYZGd0VXR2QWtYSlVTYk5WY3lW?=
 =?utf-8?B?bGs4cjZoRlN5WUthRUE4VmtGVlF1c2phZXBhOEVIckhua00rUUVqUUx3ZFcv?=
 =?utf-8?B?UFRNRXRQcy80WlBGTDl0RFpJUzU2eXRHcnRVemlvZzdFWVpxMk9XeEdEQlkv?=
 =?utf-8?B?Y3NzRWdJZWVzRjk2ZUhQOFNVa0Q4cnA5TjFaN2Q1S2tWWEFhY3cxS0RLYUFR?=
 =?utf-8?B?dHlFUXA4dFY4dk11SUt5MXhEelNhd2dxcXJkTVlleEhXS3ZhT3ZEODIyNitG?=
 =?utf-8?B?VnVtNWZzcGY3NzNRdjFYQ0VIUytXYjZieFBpdk9qUG9vL2Yxbi9EWHhRWW03?=
 =?utf-8?B?Z0xiZ3B4RHJxNHRTVzZRY0xITW4zVURBNjY5TDIvOWhjbW5YcW1JQWNRNFdH?=
 =?utf-8?B?aVQzVXVKSzVjWktJckh0bURFVm9lTWc4VG5uaHhWK2toTllRdEc1WjA5L3hB?=
 =?utf-8?B?dHVrbXNDRzZ3ZURiZGtEZWE0bW9QU3dIQmd0Y3NKWmlxa3NPbkgvL01jZEJT?=
 =?utf-8?B?Yzg3ZzAwbEh6VjE5VldIQzVZSEEwaW9hSE16SFNWajF4RnU1czZzSDh0R3ht?=
 =?utf-8?B?VnlGc2prbTFqbEhqU1pyVXdIb0dadW9NbUtNVDAwQzRvYjAwRy80MEM3amJB?=
 =?utf-8?B?ZjdUN1ZINUo5YzBWZUxRamsyREloYk1JK0FIWUI0S3QxZTZycWRXM2owb3FV?=
 =?utf-8?B?NlBzZy8rM21LV3A4Z09nbUlLN3F0U2NrNjBnNzFZcjc4QkZYNHlmNUJKbUF5?=
 =?utf-8?B?ZVdzTkkxVWppd21UdFcrVjhmb1hIK1l3eDByWkkyUGppd0xMaWNKMkI1YnA3?=
 =?utf-8?B?alhBYlQ0b3d2dmFIT3U3Q1B0YzZpRm9uMU5lRzN0bWZiQjBuNDBNaytqMXU1?=
 =?utf-8?B?VjIyTTVVRTVqb3N6S0pKRVdVYm40Zi9oRVc3eVdOVEVNdnYrUGpaaUtBcUZQ?=
 =?utf-8?B?eCtnUFJ2Wmc4bll3Z2diWUNXZGFXU3MvTHErM2N0T0FMUHRaNFdFUmJPZ21B?=
 =?utf-8?B?NEhnbzVXUlZrSVpNbTJBLy82em5VeFVkRGJwMkppK3NPa3RYR1lHK3hxWWVa?=
 =?utf-8?B?ZEZUclZ1N3E1ZGJZQk1JVWhQNmwvZ0Q5OERoUmF3T29oMjVVbDFZQ0lYK3Ay?=
 =?utf-8?B?WHhKWmtLN3ZOZTFQamlCL0dhdS95UUpIQStqaWlKaXc0Y1hSemhXMWFmaDY1?=
 =?utf-8?B?RGVSbnJaeFJrT3RNTHVTVVh0elAvc2ZHV3dGcFp5NG01MFAzTFZkaW5pUStN?=
 =?utf-8?B?RUJsOENiYmxOaVpWRGJoU3lDOXRxRDVVdlAraFIzT1FkZHZ1R0MrQ0pQckNT?=
 =?utf-8?B?SzlrRzdaTnpSQ0h3cjJKSVpCajc0TzRLNUFVS3h2Z1FMMWp0ZUVpR1BaT09K?=
 =?utf-8?B?L1hkR3RBNXE2bHNEQ1UrWlZSRnBQdERZOUN4QnBHaWpteit2bjQzSmRMYkxG?=
 =?utf-8?B?blRrWUtqRlg1dE0wTTNlYThKZWVMSFdUQUs2UUp0MmZUVTRvM1R3VTBkRUJV?=
 =?utf-8?B?UW9Id1lVMWdBT3ZQakc0L2ljVGJrUEhIZFppM3dORnBWUEp1VlQ5b04xcVFS?=
 =?utf-8?B?elJrTVRkb0w3eldZQWJwbVVCemJRVWZtbmM3cWthWXZZbExlRE5Bd3d3M2xV?=
 =?utf-8?B?R25FUGpKeCs2NnJSQkFkQk9leTRlaTkzOTNkWjZxRUZ2SE5tamNrMGM4L0RG?=
 =?utf-8?B?QjU5MGQvY0ZNeDYyTFI0eUJJbFJYUGNZSmxVZ3plYjMxM0xaR1JKT05oUktH?=
 =?utf-8?B?c09MWDNRazZNNE1rTnhNOVg1SEVHRjhzNVFjOUN1ajBlUGJ6YnAxWlgzYTll?=
 =?utf-8?B?UStaaDNQS1ByUVpBVHk0Ym16bGVNRldnSWIyL0VWVWtBY1p0RFFHODFpdHFo?=
 =?utf-8?B?aWpPQjZ6c2U1VkcrQkFCNkJqN2hMQzlVSkhMWVBOejhMbEVPajU0VnF5RzJJ?=
 =?utf-8?B?WkdSb0o0b3g0QXdVaWRRVHhmRWZ3d3NmNlphUnNaR1hZaHI1UVlZSjVsQkRL?=
 =?utf-8?Q?9dBc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCFBCC4C36499C4EB3B7C4F55DEE0F47@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPFBEC4B1F8E.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95951073-f886-4c37-ae7f-08dde7284a3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 18:17:18.6111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4ukiYtgP2U28+1qwUmm6UXa5SLHeVQfzsyZQe+Ve5YJPcCj1D5MXAuC8Y63bFfiodNm9OwFSX8QwemY7vxW/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5944

T24gOC8yOC8yMDI1IDEwOjU4IFBNLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBQbGVh
c2UgZG9uJ3QgZG8gdGhpcy4gSXQganVzdCBnZW5lcmF0ZXMgdW5uZWNlc3NhcnkgdHJhZmZpYy4g
U2VlIG15DQo+IGluc3RydWN0aW9ucyB5b3UgcmVjZWl2ZSBvbiB5b3VyIGZpcnN0IHN1Ym1pc3Np
b25zLi4uLiB1bmxlc3MgeW91IHdhbnQNCj4gdG8gc2VuZCBwYXRjaGVzIHRvIHNvY0AgKHdoaWNo
IGxvb2tzIGFkZGVkIGhlcmUpIGJ1dCB0aGVuIHRoaXMgaXMgYWxzbw0KDQpIaSBLcnp5c3p0b2Ys
DQoNClllcywgdGhlIHJlYXNvbiBJIGhhdmUgcmVzZW50IHRoaXMgcGF0Y2ggd2l0aCBhZGRpbmcg
KHNvY0ApIGFzIHRoaXMgaXMgDQp0aGUgZml4IGZyb20gdGhlIHByZXZpb3VzIHNlcmllcy4NCg0K
Rml4ZXM6IDFmNzA1NTc3OTAwMSAoImFybTY0OiBkdHM6IGF4aWFkbzogQWRkIGluaXRpYWwgc3Vw
cG9ydCBmb3IgQVgzMDAwIFNvQyBhbmQgZXZhbCBib2FyZCIpDQoNCknCoG1pc3NlZCB0byBhZGQg
dGhvc2UgYWxpYXNlcyBhbmQgaXQgaXMgZ2l2aW5nIHByb2JlIGZhaWx1cmVzIHdpdGhvdXQgDQp0
aGVzZSBjaGFuZ2VzLiBTbyBJIHdhcyBob3BpbmcgaWYgdGhpcyBjb3VsZCBiZSBtZXJnZWQgYXMg
dGhlIGZpeA0KDQppbiB0aGUgdXBjb21pbmcgLXJjWCBiZWZvcmUgdGhlIG5leHQgbWVyZ2Ugd2lu
ZG93Lg0KDQoNClJlZ2FyZHMsDQoNCkhhcnNoaXQuDQoNCg0K

