Return-Path: <linux-kernel+bounces-824601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD69B89A61
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A833AB9AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF682FFDCA;
	Fri, 19 Sep 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="RhH6gKlI"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00538309DA0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288303; cv=fail; b=Muy3AraJg8iwA3GaehFe+Uw/iD4d07kyTlcPniA336aA4RxgMhp0t/pubXlGipk5byIbmAVRnkznHEPuXJNT+5c9sFqTB3tRhcwhXcCghfT2tnff5qfgKbKq0ICGsccuOQIeHf2eI8/mn/p6RxA3AqKUGiIX7/NXP6chMu0umxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288303; c=relaxed/simple;
	bh=ekLotQzj30cgFmzah2yLa7R2GIwwEFW3av9laA4DA0Y=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=eRIzEvMzxdNWTwnB4r/ksHsMro1DvB3xJW2AEGmN3mklsGnjP+3/6MZvhNnB/87pMtXX3im6JMPAYG5zlBe50n1Ld2u0PhPMKdhAQSWNn8SiH+PIeas/LVIdN20lOJxBf4QqoJ5yaluw02QjyHdQA2+hhB7D1FybNurpxAvKhp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=RhH6gKlI; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmzDNbcV9ebdM8FrlyIOoo9OA4oX6eRrQUzGkZ0AP7R9XbO8MGIDaFHwz+uzEkSpkhwuhZgdJVGvtOA8Wtoq/HLdSC+3kfu053EnEwnp0DCf3o49j9UMC2rS7gGWNHYCFFJggh+jQGEv/MLEhFkFu04xkJRXy2rGPDZxEtk+Rqy9o04vzIaNr+FnqrEAWSYkc/ZaC82K1vmomNQWEyUHrKQZac3/ZUEETwjMb3Wl/eGR9gnjbQer2Kul7QqAGiizPJMUeqkoPLQkyR8ZLYm4VyyF6K+ABgS1ObV1WqjYsqXiCUQLxmtOA6fBZqiiEn7SLAFmMLudl/BUfVu2McKtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekLotQzj30cgFmzah2yLa7R2GIwwEFW3av9laA4DA0Y=;
 b=k/iFpi/ImPSz7X/3CUAg88Ngyko9gy0Q7wQSj6W/AUQo06mbR2s3uZTfqBuODlpG+R5FsDvzPGCEFRtm2gUKH7EIk142Q0Uh61Zc4Z0kQgixie7ysTTCuWc6kyvDceTYRkAYLL5ag4JcHSvfmbcZsXVLX+pKhxLeDx21mk9kCGRijpRUkBStU1hFnHPGO1bBbIHy34faEEVX6Ykg+PkXbpqiOujd0kCn7K1Him4d+phCkbgMJLKspL9Jnxuy/z9PyZfNNu1QZ6/NX9utyPd+U0TfxFHP9xL2jctmJadqdkcmGStqQd+pOtYoOP2NtGQbIhMLGdvodLIoRIGOsoHRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekLotQzj30cgFmzah2yLa7R2GIwwEFW3av9laA4DA0Y=;
 b=RhH6gKlIhzTVlZq2Vv8AZ3OVD/NfUDDplL4pSgsz/efJwSXq5PqOzQL5RRIjoLkAlCjn9fBH4gHSVQbhHq4OKhS/qB6q9IoJf293jb07RLf+r+Mcm1MUKg8FTq6bJRbOGnzg9+hpAy68viTjLn2HyU4aKxcOw1d74ZmWsb3N2AW4ZvsIEIYlTM/9X8JfU4ybZ8uUhpCplEztJLqfi3NQj9sxfwUBDQHznux6UYpKEHU60g6SshEIsT157v1PBrpOfqs+Cm6L0AXY5bnPjRiTzAIPscuW9HoEOXhEJUWbk2Z2o+5tqEND4hMUtq0wy0JlMlCQ9NQkLuZVfJvRSC014Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from VI1PR07MB9706.eurprd07.prod.outlook.com (2603:10a6:800:1d2::12)
 by PAWPR07MB9394.eurprd07.prod.outlook.com (2603:10a6:102:2e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 13:24:58 +0000
Received: from VI1PR07MB9706.eurprd07.prod.outlook.com
 ([fe80::1620:bf68:4eec:61c1]) by VI1PR07MB9706.eurprd07.prod.outlook.com
 ([fe80::1620:bf68:4eec:61c1%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 13:24:58 +0000
Message-ID: <8f104eba-6805-46e0-90da-232ce18973c5@nokia.com>
Date: Fri, 19 Sep 2025 15:24:57 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
Subject: Highmem on AXM and K2
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::13) To VI1PR07MB9706.eurprd07.prod.outlook.com
 (2603:10a6:800:1d2::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9706:EE_|PAWPR07MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0468a0-5388-4ddd-719f-08ddf77fedbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVU2QlNJTE9xOUpqNjNkeGQ4ZFF3c1E3RmpNeFcvakw4RTNDNXFZcG94SlJo?=
 =?utf-8?B?VUNjMm9Zb3NlaG5YVENrK3NsMUVLYTdWQTNpQWVFZU5qcENkQTRzcTcyZU96?=
 =?utf-8?B?L0JvRHNUOHN2UzI2SnZ4QU43NnhkQnBOSlpOaGZyRlFLMW55ZkVGVmljUXI1?=
 =?utf-8?B?UWpFVE9veWZhR0tGeFFhMzNETCtybmVsbVo0T1U2eFBvbUFUVExSRzQ1ekg2?=
 =?utf-8?B?STVhcEFQNFdGQlhaL3lUbm10VXhrMUpuMzFaRzlKOWRHaEZ2a3l0MC9uSmdX?=
 =?utf-8?B?amUzSStnWEREUkVxR2I4UGlqT0doU3czWHY2NXREODEyTHFWZnBtM0lhMDNY?=
 =?utf-8?B?bEMySlV4c21MbDhPOSt1NHZZeGYvZ2lpbVE0VFkwMkJSa2tQYjBpeW9oY0Nq?=
 =?utf-8?B?SFBHOGl3QXVLUnoxbkM1aGhlcEtSNjdlUXV4ZDAxVGlONVd0c1UxdnNUOW9r?=
 =?utf-8?B?cTk3ekxLUlJGaXREVm5Pc3Z2cmcvbFBzNklnQW8wLzdzSS8yV3lEVUpNZkdK?=
 =?utf-8?B?MmxhcWFyUFU1UkZNOUpmOWp4bTdzdnIyQlJLY3pUalpza2EzU3dmU1J2cmRl?=
 =?utf-8?B?TUlkb2svUTBxblQ0bThIdnM2NkpWUXM5N1IyZUw1WmJWM1RLazhqaFo5U2JY?=
 =?utf-8?B?elZXY1ZWMnNKYmxZRGRxZjBralZoMzlaRXF3MUc1c3orTFVTc0hPK0xidkRU?=
 =?utf-8?B?OGxNbm9oR0ZuKzlSOExJMitpRlcyeXpTd2pzMHNleUtJMGY4dXMyVzBwYW1q?=
 =?utf-8?B?cDJMOFo1WnJUQTZ6djNRcWZJS2N0VVdnaVZoOGNhT1pMN2owbzQxZGozZ1Qz?=
 =?utf-8?B?RDFrNVd6clVYekhTRU9LUGI4TjdXNjgvYUcxNUd3NWdoWjlXclNyOUhRMXFy?=
 =?utf-8?B?bWsyR013Y2piUWZWS1dLMUkwcTB1YTBiQkt4QjM3UGVSaVhpc2ZkSHFxUFcx?=
 =?utf-8?B?TERZVkg0bjNWMUp3Ry9oT1VYNW4vWXBNZ2NkdVJJMHBabkF3WEhLL1MwRFA2?=
 =?utf-8?B?RFZjaTJTTDhCZkg2bHoycTNxV0lQNFlxekpoWHdoYktHKzVqZVhsd3B0SER1?=
 =?utf-8?B?SS9OMnhna1NqVWpDVVRRcHQzME5CM3lydFBJcDF1Vlp0bVQ3alFDMWxiUnVQ?=
 =?utf-8?B?S0wzMTUwYUQzWitzeHJZT3BkQXZGbGU4YWc0d1VUaWdwbVlEanJ5NXIrdWhk?=
 =?utf-8?B?NE1mVmlMNWNzd0pUeDlqY3ZHVWtlMkpBUkZGOHMwYWpQMjdJNm52VGViTTY2?=
 =?utf-8?B?aDh1MFRBYkU1NnJ2TjhoSGovUnlITE9ON2JOZ3gxeFJCc1Z3TDVIRmRIbFV0?=
 =?utf-8?B?Q2xZM2UxMWdPNm1wam5Qd2pDdVppUWhiOGVQVVg2ZFp0WkxjMjhhQ25hdGdv?=
 =?utf-8?B?UHVPZ2RSR0lwZ1RyNnNETmRKWm8yZSt4b2luajNjazdYWDJYYW5LQndsektP?=
 =?utf-8?B?ZzNaSEdDT3JOYlVuSTR2ZkVZejc4dkNYd3FOVU9vVVhpbHdvcjBzTUxSSFJh?=
 =?utf-8?B?Mlk5QTJtUXBlM2duTC9ES0dSNE5kMDNXOUxMamxNbkJyZDRaRzNmTDloNksy?=
 =?utf-8?B?SkI4bDFDajJIcnZ4ZnluZkd6K3JIRms2VFpyd1R2bjdZOG93TjFrZkVtbnRw?=
 =?utf-8?B?NUNVdFczTitOdllCdUxBZHJneldTdEpqODMwTFRZSUhVWDJYQTVka05LZklO?=
 =?utf-8?B?SUZwVElSbThGUGRCdVUwNitidE5pdE9DaWRITGhWenV4ejV6SFVCQTNXc0d4?=
 =?utf-8?B?b0lNUm4xWDBmZUtuR2tPaXNmYXZRc29tcGkzcUxWSzJaRTBpZnlvbnNaMit3?=
 =?utf-8?B?Q2VUQ0Nla0tody92WUtGUFNkcmJPQnJMVVRGT05ZdWFYb1p4YnlNaFE2T2tR?=
 =?utf-8?B?dEZMTWt4Q2ViMWVlbThrWnl6UGVTSDMxMWs5bmgrNFNtNEkvZGZEeDFxeFYr?=
 =?utf-8?Q?6X3Jjh907K4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR07MB9706.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGxSRTdXN2ZZenJ0MUUzdStrWjZWclZQWDFIS1ZEcUE0VVNTL0RSNzBhbmg3?=
 =?utf-8?B?MFRJVkxHQlNjaXE1d0dLcTViYVRnTGw5ekNBWVVqRkgxK0dDK0lJbWUzYXFG?=
 =?utf-8?B?VDIyRFhodzV5ekFCc01LaHNQZFE4MitsRHVwbHZOcEg5dlptNHBJNlZIdjlS?=
 =?utf-8?B?V1FmNmRkOUdKMXZFM2U0SUFDOG9FRUFhZVo0Y0Yzd1F4NVVsRDlJdjhIazFV?=
 =?utf-8?B?K2Z1T0lNZEVEblhQMmpXZjlEWDVQb2VKZ2M4d2xQYjRlT2ZKaVY3TitWLzlp?=
 =?utf-8?B?TkVXYVNmdnVRK3FmUUZ1L213bnNmeVI1dTlNancyK2ZFTDczcVJLVHVhdmsx?=
 =?utf-8?B?S3FyMzJNWVZaZ1VidTY0QitIMTd4cEd5YTV4RUQzemhpNEtiSStEcHhFL3Ja?=
 =?utf-8?B?R0pkczk4Sk9ZTGZ6bHphVjZleUpvVUhlWnBVV20yelpjZnVCUEo3UFBsN3l3?=
 =?utf-8?B?WVQ3c3BPN201RTgxQ2s4OTRxbG1BUjdHWWR3c092b2hFSUJCSnNqeFFBMFQr?=
 =?utf-8?B?T052TzVLLzA1WHAzc216ZzlZTkpTckpIZUxuV3lqY0xVZ0RsY052M3RuVWFP?=
 =?utf-8?B?dWVXcXZFMzhDQ0N1dS9vRG9ETERqQk9OdmdDT3ZTWVp5K0pHdENtMXRUUVhL?=
 =?utf-8?B?OVhrMm1KRFNQTGpvWldCSGtQNytHbFltL0tnQ0wxV1A2RDlxeVRDZmUwNVhr?=
 =?utf-8?B?eUM3ZDFUUnR6QmsrSVdaTGFaTVdaTkwyZTdqM1o4WUhyTEZlaWU3Nm41enBu?=
 =?utf-8?B?WU1QekdQUlZDNWQzYSthWHB1a0F6dXkvVHRRUUJ4QVhUTlF3Z0s4SlVsbDBK?=
 =?utf-8?B?TkkzNTkxRlJGMEVyd2U3K3JzOU4rdExSekRSVnNSaGNTYmozbHBoYXlTb254?=
 =?utf-8?B?Z2d3U0J0a3d0TVJkYUdqTXhaS3dlbkFEdmpzN1YyTmxvZkFBWmhLcWIybzQ1?=
 =?utf-8?B?NURXVEd3TXlzbnVsZXdwNXU1b2JJUnBlWDRXc1lNRTF4aFdDK0ZidUFuckg4?=
 =?utf-8?B?ZWxEdXkwLyt3WUp1akh3ZU9kVVFIVkxwcUFOQldoNDR5RHVwUDl3Sjh5blJM?=
 =?utf-8?B?djhlWWE2c01rWlNTL0NFa2pMZXR2OXRsSDNNWXpXakhxUitZMnRBbGpWMVVC?=
 =?utf-8?B?a2Jibm9jRE5uUjMzcmo3ZFpYMWR0STJTVnF5WFYwV0huaklST1BWY1c4TW0x?=
 =?utf-8?B?USt4cTBTdWx4YlVNaFQ3TlFiQWFiaEhIbGFKZ1B3MXVFRmtIR2dHeFl2TzY3?=
 =?utf-8?B?MWJwWDQxSks3NWhlZWNGdkR6MlgrYVQ0TXZqNitCWGpPZHNjS2RPRVVTV1VU?=
 =?utf-8?B?VXQxZlpWN2hWaUxRck1TSGU5Nmc5dE5wdlZobEJycmZjWURGVFlVc3lLZGwv?=
 =?utf-8?B?TzhQQVA1TUc5bVhXT2g2aTdQR2ZCdTNOc1JiTEZNcUYzd3FkZmNFN1NYcFYx?=
 =?utf-8?B?OE1jRG5IeVB1dXI4VUtuNlM1bllEVFBuVmhpU3p1M3phd1lFaGg3QWNLeUFK?=
 =?utf-8?B?U1ZSQmRqTVFreE10eHowdEp1NG50RlhKVjVJSEFMWjNhQk9iVDJ2WjNRM0lB?=
 =?utf-8?B?K0lJc2o4eHpuaTY0WTdZMmc0U0ZRbWowcWQrNjJBdnk2WTBSQ0hMOGVzVnAy?=
 =?utf-8?B?KzNWeitDeHViUGJTaVZIMWRjdWRoL1grSGVTU0RpYVlmZjJYb3NDdUFveXlG?=
 =?utf-8?B?THBIZS9hRHdJSmdwMmVvaE8vZ0Z4YXYwbmdpQlNpU0ZGQXN4eXBoZ2RYVFJW?=
 =?utf-8?B?MTM4SytnVjFEWWxod1pZa0trYWZJK1RWTHBhZldCS0FEdytWRXJhdVpGd1Jh?=
 =?utf-8?B?akpUUktwVkIzNDFYT1M3Y3Y5djV2S1M2TmxwcGRWK2N0L3ZmYTJ3MlUxME1D?=
 =?utf-8?B?dUpNazkrWThUSlZ4N01obDNWUDc5T1ZyOURBcUxCVXpwQXNaMG4yMjBKMlpK?=
 =?utf-8?B?VmhLOUdGY0VjZmhLOGZnRWUvWmVxbjZsSEJmTGZEa2xVNmd0ZEY2Mmx6Vis1?=
 =?utf-8?B?OW9Kd3p2OGVVSXVzZUhERXFldkprc0ZUUVk5NEgvZ0ZGT1VFT3FubUE2eVJm?=
 =?utf-8?B?MEN5M3J2UTkyWXNvTnlkRlBVVzZyK3hGZjR5VFZkVjlHMVRlVXFiNFNhZk9L?=
 =?utf-8?B?MnFLZk84b0l6SW9Va2J2UGNPV0NVaXhWRXJQM1F1ZW9iODBNcmNzZVdTWHlS?=
 =?utf-8?B?QWlaTEIxNFloUENFVEQ5VzN2Z2dybEV2U1l5enZOU0tVYUdPdHVmRFBvRWNv?=
 =?utf-8?B?QytHNkwvVjlpNytjUEhHSFVIb2FBPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0468a0-5388-4ddd-719f-08ddf77fedbe
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9706.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 13:24:57.9630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bi9aDpYjNSIGoUOvu74KiuztMSy+coay5sC6WPFS00TgKfdeJ6lisZdAYsAk08L3msuyTOtmCUHABbgpBYBpxiNKzDSSFlolAydLnaei0Qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9394

Hi Arnd,

You've been calling out for users still needing highmem, and here we are ;-) We
use both the Intel AXM 5516 and the TI KeyStone II with > 4 GB of RAM in our
networking products.

We use the AXM 5516 with 6 GB of RAM and highmem is therefore a must for us.
The latest estimate from product management for EOL is June 2029. We would
appreciate if this date (plus some buffer) could be kept in mind when choosing
the last LTS kernel with highmem.

With the TI K2, the situation is more complicated: The EOL for the latest
product hasn't even been defined yet, but most likely we need to support it
until 2037; it really depends on when the last 2G/3G networks will be shut
down. Obviously the community cannot wait that long with highmem removal. While
we have 5 GB of RAM there, a little bit less than half is used by Linux. I see
two options:

1. We'll need to evaluate if we could move away from current CONFIG_MEMSPLIT_3G
with our rather special memory configuration. My current understanding is that
there hasn't been a lot of interest in getting CONFIG_VMSPLIT_4G_4G into
mainline. As we cannot accept major performance degradation, I doubt that this
will be a viable path.
2. We'll need to switch over to the last highmem-enabled SLTS kernel, earliest
around 2028 (to keep some support buffer).

Kind regards,

Stefan

