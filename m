Return-Path: <linux-kernel+bounces-770138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6F4B2776D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8923AE618
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7A929CB45;
	Fri, 15 Aug 2025 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KAiT8dw3"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010005.outbound.protection.outlook.com [52.103.68.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E11DA55;
	Fri, 15 Aug 2025 03:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755230234; cv=fail; b=lkrSeGMiHMW1u3t5DCNGzGafYygAZJW4Ke1lGgQbCczPBq7st06sZ25klC/QwhuHyxJU6gswBbQM7GF/FcL45lg3+AStbU3V0MUZmBcodWPLF38HNQW4L9mS+kfa3TKvRzcgk1Rb1YbQ8mx3G2fH3K8E4erw85QclumuMogR6gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755230234; c=relaxed/simple;
	bh=gnF6S9HhXdXFl0hlckJuxWAqi9IeOk/lBshrkd2EfKo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aU2LBQvN2p9va86hoDh0f1OgwOXghCN6oMOpqbddUbpuQamIXgWJK5O8csOZ8U2qZg8H0KEPRG1XuFj7Vj8w/x5HPWRgE3FsfYBtFshYrxG6IMkqUM92MeGs17CDFTV65S4Q4D9bxCjpdMrc98IYxv55Q+qnyamzWVwA56e2XRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KAiT8dw3; arc=fail smtp.client-ip=52.103.68.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO8VYeCFXOle9XooYTHx6mhT654sbX7LtLaBkSwPOl0MBnYuF/YkBOYpkv5jHaA1Pn5Tl+u7C4meGQh6WxatDch2seH+Ysog2A1/eWwlbtIZqvr09uql0+yZAtp9mYpmetQUj7KZVTlQEMezOJ9ZCQiTT5O5fAG35REAY0VkoxCdNR3eEm94K4znkLZs0YU3TxZN92GONcCvVYsnaKSIsEw34IK9UgwlpKzi4s1z+rTEiqKdpRcBaK2EfMKHQxegDdZzuaGe5so6yBPXcFeZRJlTe872kaz0UCZ7w7E4RSjPOhaMlEtw+KEpXgR0+tx4HWQfMiBhw5oXcN2DR4x4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/vQ3f8sFBP4S8qD6IOJkKOtMDXg3ELpSXDtZW3+zbM=;
 b=tfkrbNr8HGNVOakQIGKEfvcRE6xlqh5IwI59xRNrFkpP/NgCO+JgbZsChZv/SZMeCmm7StjU+4piALer0zBpqn7NwJkFszzyXyr0AHUsqoyt//f3AZ1tUV9O4IMXmNU3OOsYDm8MR6rxyljyc+Y0fEB7R1pRWap3GsqRgKBni1TVzddEg7c9l9OhjaESy5ZRm+C3F2SVyrUjnqDSaXGYXEpneceQztZMpvnTID1c6Xuop63J+Xn/+jPryEROEAUGgVeoCc7aaeqif0cEFltHvRUxQx5xS46UGAahdsAgHki4RMylh8lCAHXJ9LYXSj4X7ZdmgtdX91W9qVX/1OkIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/vQ3f8sFBP4S8qD6IOJkKOtMDXg3ELpSXDtZW3+zbM=;
 b=KAiT8dw3sovo2QgxV1xPpiFx49dQ9SiIdVyq+tLuYkspyPoXjRkKUgjlq9AFTJcY0Y3UuTIUtIMZ+ZIl7CxVN9efHV94os25TGdcTryoeXpaQnCrKPnB5iunNfdAYjwy+urY2dF2RhSQFI4XANpKL0c7ONDtvclUa7Qcz0aw3onR8oQtjD7wnqPh6w8LXMuNh8fC3iHK0F5oK1WZKTKTb8fdF/Zx+VA71CqqRiXyZQ8PErU56DDnitJACRp1C+4XweIYxSahADbQpNQYeO2PoIOV1R3kmqGvHVCNJonz52Zv98bTbohiaYVqMZMW0ppu/M77El8izaLkO5bdHGj/Tw==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by MAZPR01MB7182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:50::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 03:57:06 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 03:57:06 +0000
Message-ID:
 <MAUPR01MB110726155B08B3F8B481F1B86FE34A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 15 Aug 2025 11:57:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] riscv: dts: sophgo: Enable SPI NOR node for
 SG2042_EVB_V1
To: Zixian Zeng <sycamoremoon376@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Han Gao <rabenda.cn@gmail.com>
References: <20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com>
 <20250813-sfg-spidts-v1-3-99b7e2be89d9@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250813-sfg-spidts-v1-3-99b7e2be89d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <28cb7144-7b3d-451b-b14d-286f1d7a354c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|MAZPR01MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b46fd61-5816-4dd5-fbce-08dddbafccc1
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TVWrg+fxRScxfg9v9HXnUFlR7U3F9NJo7eLfCYua/UdAlB9i2Q5sxfy4Druyckh2+Y2xaV4so6738n9IwqXd6ZuLWduHejnml/3XnNPIklOl1zTw8/bMvxly5urkIpvAfEVZvvppNj/Sr+VS+ro6x3XCZ4TbfmHI+OuKqFZX1bKc5ra1c5iC913JaI/chHOT2QE8lyxI6NPxJ3MPrtnaVWP5vyEf3HOBTNfrC/FtRYgcCYuNPv9eb+3/rql60bxzOk1gIBVBzt2XQj0o6UIjbgKAV/+zfTkFvZujtQomRRafylkNUGizmnp7eUxliV0NQ1K8akPjX0txjNcD5BkDRFg6Crm4GzvOJ11Wu42gN4ySEUxhDjci6qp4HXnZqx5r03P++xd8x6Fv7dFrcVC1PFN/8KBx6Sm0rvcJIZPIb4sE7GW5mDK+uGLKjC+0UOeGXSIl3RhfCJPsY+dK6BDVeha29l6sJ5kz9yjYWyFPWBpSv9qIjLpSreGkxBR4MlU0tAUxWMSmBmCWyC/BzkNSCQq4eeQPOKYc1LuYafLVzLjl+ALnTbpNoPKmthkQEPZ4L9OlVcBdKmZiMni5C7v2Ts1CIqhvEt6OXVQ8ceOoZ/c3W0p/Az8pSL/n9HXMb3OgjRy9O+xvDmRVG//l/scz7+AWYkOzihilf0uKJ+mbvvHgF+3cAl+hTGpJXGNBGF0EDQib0MmBQz1dhYs8KPFc6uTfhmktOhsdJsmA0kI2kv3AybUdydKwfo88MMftuB6laByanEf+Bfj1diRJLNQTYzPLpxgT9qAMTY=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|19110799012|6090799003|8060799015|5072599009|461199028|3412199025|39105399003|40105399003|41105399003|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1JrdFkvdHJ6TEhPMnNXVEQzYzJWNzlJdysvV3ViQmhKeE5VWTJxanVFd2Zn?=
 =?utf-8?B?K3RGRkM2cUsrbVAwYlpsN0dLSTQyeEltTXNFSzhTcWIxVjVuajR4Ym9jS2xF?=
 =?utf-8?B?dWc2cXUwR00xbi9RVDlqRzRKbjcrcmpFWG9KS2hkZE9MdnZ0bjl2aTE4ZnN3?=
 =?utf-8?B?RG5PVnJGZmU2RlArY3BpVXkzWnkrR0JoZVNkQXZNZkQ0TUxDTjRiclk3SUxq?=
 =?utf-8?B?UGxHRjNNUUVVditNY1hxZnhOOTdyWkxFZ2FpbEFDQkx5NjJTME42aDNoRmNx?=
 =?utf-8?B?dWNCVUYvZXM3Ry85VUFPTlE0d3REOFJndm1QM3BtNEFKaGc0OXR1eFFscXNh?=
 =?utf-8?B?ZUJZdjZhM1pHNTZSaFk1T05qY0Z3YzcwbzlBSGJRMnBxOTFwOURidFdyRlNL?=
 =?utf-8?B?MGtFNUVleTQwUVZXS3RTdFNoajB0VTUwQkZ3NXBGalZaS29sb3VlYUE2SSsx?=
 =?utf-8?B?b3RmL1hqejIrUWtSMjFyTjk0WE92S2htZ1NYT2M3VmFjUmZCNzFXWjNrclpm?=
 =?utf-8?B?YmVrdkRxTmZsKzVuNzNBWVpnODBPSHA4dHNDNWliNk9PK2hwalVCOVp4RFpx?=
 =?utf-8?B?OFNtcEtlelVZRk1MMHFSWGRUNVhGZEhnYitVNzh0bXlhNGNUWFF2YkVzMUxt?=
 =?utf-8?B?aWNaUVFmdGI5cjl5RGpoNWZuREQ4UzI5Z0FBOGhscDUvVHcwTFZMNzF4K2hn?=
 =?utf-8?B?cGdvdHduTW81Q2pFNmMvYW9aUTB5SU9HRm1aazNuQ25qdHFkSW9ES0tWSm50?=
 =?utf-8?B?YzRPMmFZY1VyL2NyOVZMWnEyOGduRmZ4NXhKTnFFcWxCZFNzY1gyV25JNkRP?=
 =?utf-8?B?Q3NlMjQ1UHR2WEQvOTl6VWd0Z1pWUGJKdVM0aFZNSUdnQVBtbnJPRS9qOHZu?=
 =?utf-8?B?V3ZZVjVTVU1nb2h5STRBeFNLZmtGSG9KSS9IM1Jrb1M4VytwZ2ZneSt0djgy?=
 =?utf-8?B?Qm1jTHN2UXJMcWdsNVkyNzd1UytiU0xVcTlscmdqc1FMYittSjk3MWdWZXly?=
 =?utf-8?B?eVF4RldtdTZ6T2ZTeXZnZTZ2blYxb0dhNmo2alUrc2N4aXRrenNQdi80eXZM?=
 =?utf-8?B?MDZDWjR4eDdKR3hwV09uc0ovNHdLbCtobE1HVWhpbk1NMzNPeVNEYkxlbDNp?=
 =?utf-8?B?M1U4MUllekJGaDlyenJOdU5VbzRYQVVUUnBpMWhaR2pZSWRmY1FFbHRxSnpE?=
 =?utf-8?B?WkhNQzRJc0hkUkhGVDJLTHpsa2lwdGcrSVlDTWdjL3NJcXRyRzVxa3FHS3Vq?=
 =?utf-8?B?dkRZVHdmUCtkQlpWT3VqMEtYREhsbloySFh2Y1VaY2NyQnRQT2tneXlXVUNB?=
 =?utf-8?B?cEhkS0VtTlNvZ2VrYkdyL2N1MnVXRXM4c1Fsd3JBNldaekE1azFpZlJXVFdn?=
 =?utf-8?B?TTlVaTJJbjFkUnNoQXVhNHZGa0dLeE5Ba0E2YmdvaXBCTXcvOWpMTk5UNVd2?=
 =?utf-8?B?TWZ1TlhHVVE5VzlOYXhMVDJTVE91Q05LR3EyN3F2YTV2dTJISzZjQk43Znlw?=
 =?utf-8?B?OGJsNkIyODlXSFZ6Z3NybDBPK3JpNFE3WGxoRnRSVlo4WS9ScUw5K1BBYWFv?=
 =?utf-8?B?MENHd1FoTmI1TWpoMVdqL3VVZlU1empRM3IwbXJrMXhhbk40d3BsejlDby9v?=
 =?utf-8?Q?duNFKoFG8Py16ZdC8lu0pEnD4aoXjvGU/HobJ/BACK40=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emd3MUhBY2czLzZRcDdaQno5c2NGNzBuaWNxZFkxYWp3Z1NScmdJTEVWWDlZ?=
 =?utf-8?B?VGtGYUZPN1orNUgxTXVpMW1zQnVoM3NJSFcwdlVYZTIxc1YwbXJJUm9kSmFK?=
 =?utf-8?B?NmQwNk84alZoWVp6MzRtT011RnBpZURHMXhZc1NJNDNXK2pPMUV1SE1JSVpY?=
 =?utf-8?B?T09ZMERYSmkzZ09UMlJkUHdYbnVXYjhCTXN1Q0cvRTh4dFJIWGJRa1FPRUtG?=
 =?utf-8?B?L1N5eEhCTW04Q3Qyb1dCczd6UitKNmM3OG54MTlJSzBQb003RVFqdTBEVmNq?=
 =?utf-8?B?eTB4K1VhMWF1NVlaZk54L1pGa0JtL0lrYlBLYUwvdW9WeDJUdnBocURhRU5p?=
 =?utf-8?B?aVVNQXAwNGxYbmhaZ0l0QUhzckhTOHZrc3kzeW9STUYweVQvSUM4Q2pkTnZ5?=
 =?utf-8?B?ZWE4aitCZVFtVmFRRzFqNlc5QVdrOE14NDNBWUFKNERLaTlEd3hLaVM2QTJp?=
 =?utf-8?B?WTJVMXp2YTkxaG9McVpLSWM1QktrdnF0c3I1T0RadHNjcjJheVgwMlBNWFpZ?=
 =?utf-8?B?NjdCVnR2OTNOKzI4SWNyQkJKdG9wcDRlS0VvT0VZRHA3ZTVId2tZcS9pdk9C?=
 =?utf-8?B?TExzNXlSSVM1L1lYc2VNTkpzcVB3MUpiT1d4UGUzcjJpeVhNZVZybnVrVDJG?=
 =?utf-8?B?SEg3MGphdkt4OWJscEZGUVpPYWkvc2VrQ3Y2aGpCOGZ3WmJ5NmpMKzQ2ZzRa?=
 =?utf-8?B?UFJqem9YRDI2M3FkQ3l0MUE2eDc3bUY1NmtzUUZRbDU5KzdaY3pXVS9pNWV2?=
 =?utf-8?B?VThyWE51UkJwTTNSdXpJcDAxOVFOektGc2crMHg3cGQ3enJmNnd5bS9qVlBx?=
 =?utf-8?B?aVptODJXcEova0lTMURKZURiaVpCZHI3NWx2Q2hFREV3M3lVMEFHaTlZV2lK?=
 =?utf-8?B?VHZ3ZjNGcHlZQmtGRm9BajU2aTJjRlljWGptdElObHhTN2pmOHJ5MnF4Nmwr?=
 =?utf-8?B?MFArNVV6MGJPbXl6MzE4dEtFdEF4S1N0bC9FY1lNRUI1TmllMitHeUI1UlE5?=
 =?utf-8?B?bEdNYzVBUnd4c3FqbEloNS9naXoxSkVZd2owTjIrZzVVZTFJNExxYjZZVE5B?=
 =?utf-8?B?ckJsMVp1amhXSHhmVFNhT0N6d2pHbkNQWDY4azA0OHJ0cVhMNzV0SExVRk96?=
 =?utf-8?B?VFBIMUo5bGVUMkNyS2o0Ylg0SkdxTm5wcUtVZmMyQndOYTNDQ3FMU3huOTU1?=
 =?utf-8?B?bWo3VjBZQWlMQUZoc2xTQlhlTjJNVGt1UnZ2OW04MWtNVGlRSzh5ZkFKN0Ur?=
 =?utf-8?B?bzIwelJoNnU4L1JabGpocUxWTzU4My9iRFphbTBEdFhVYmZzOFNvM1dndjZT?=
 =?utf-8?B?NksyL0pIUWZLT0l4bWQ2MVRwdHBjelEzN3dLbFJ1ejFKRW9qQ0svZjkwRGRB?=
 =?utf-8?B?bDNCT2plOGxJUkRBWlpPV3BUV1RwUjEwa2ZFS01TRnB5aUIydi9OOHhYL2RV?=
 =?utf-8?B?aUVLY1VsR1JmTWtkTDhLV25DSGtHakFlOE45bXdkTGNyUU1laVFqbUVDdit0?=
 =?utf-8?B?dU9GTmZrTjNqajhLanFtajJWNHJUNDlQK0ozS0M2R3V2ZEVmYTFlcWZ3THQ3?=
 =?utf-8?B?aUp5TU00dSszZmVlTysyTGRjM1lrK1VONEdqTS9SUzlSY0NGbFk5RkY5OTNH?=
 =?utf-8?B?VVB2TjJuZlJJZWhVdzdwUVRjdWVMbzI1cGN1VDR2a3hrVUtCSVJZVTJuUXcy?=
 =?utf-8?B?SWY0S0ZUV2V2L3NGRjFic0lqcDF0TUdSSGR6SFM4RkwwbG9qY3NaaHpKL2ly?=
 =?utf-8?Q?PFbVGyTm0m96gVb3umiuS0FjBB/ZvZjVlqveIDb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b46fd61-5816-4dd5-fbce-08dddbafccc1
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:57:05.9726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7182


On 8/13/2025 4:33 PM, Zixian Zeng wrote:
> Enable SPI NOR node for SG2042_EVB_V1 device tree
>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>   arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
> index 3320bc1dd2c66ab1a77fce719f145070ad51f297..d447d66177ee5c66b12af2d8ca79a22cc920c666 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
> @@ -238,6 +238,30 @@ &sd {
>   	status = "okay";
>   };
>   
> +&spifmc0 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <100000000>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +	};
> +};
> +
> +&spifmc1 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <100000000>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +	};
> +};
> +

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Thanks,

Chen

>   &uart0 {
>   	pinctrl-0 = <&uart0_cfg>;
>   	pinctrl-names = "default";
>

