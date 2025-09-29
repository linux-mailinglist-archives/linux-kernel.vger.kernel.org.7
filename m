Return-Path: <linux-kernel+bounces-835708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE97BA7DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882471896011
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E481DDC2C;
	Mon, 29 Sep 2025 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="nCWlB4NU"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023085.outbound.protection.outlook.com [52.101.127.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B7A92E;
	Mon, 29 Sep 2025 03:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759115788; cv=fail; b=jGv5uHKQNos6uZOs65JO10UfgtKNkQsDtATV3a1ly1+WW3dc4qqBnKuiSAWfmS3rOeKZ67CWixzGTu9xu5WkSLQXLPd6VW65OrHIHQPlInQRHSKKVQnNa9NB0WkN+SaiCXHhK3HBNZFnr5rJRZL2wbPGCo0tb3tcdurrdkO1B9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759115788; c=relaxed/simple;
	bh=54TN3D5Gbl6pZ5hVEqEzqJ2xx8OO23uKTjU9a3kD4jc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H39Jgv5pGz/Nn/VWqKcAm3wDzAUdAAAbkjXf2fbDeX3S1kQBkLdkSxAuFYjH1bXeMdh/UMIDKvt3COLGdxNnLLCcqxDCm6FXgc2VFcnL0J4800BGFmDtRb9JKcvULyv+xAf7SJ/pfr6jhjmcPQ9YHBw0+rnMLHfhoMZ9XRRSfS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=nCWlB4NU; arc=fail smtp.client-ip=52.101.127.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAGVgYzPkZMJJ7Ybgnm+1yINWvSGP9qPkY8oLvqdsmzYI+WUiMjJpxN2qHzeebclCyhIOZ0BmOlIDc6ORqfV3y2zGBawftYEPinRjrNMRE+usycVF2W54oWVl1S8PAh8aWQp4EqiftttfU2Jb1iqVOR7uHGRGBA4BN3ZUpDiuOrV7j+42/5yB6iwhpnp1tiQ6GyLGUjpM687OhjFGLzKg8E1veTvi2ffDPA9rc5lCrI6pm5yorW8zBO3D5yD09SFyiqqxfrpgCmGnQqZ5FQo7dqZtLE6uHOgoxd8PfYGiB0zYEp8z22mJE3kp9KPvB1jKXXN2RHt77I/xQ0ztCfQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zt1QSmgRejrd+NrfTWSKN0EhNtY26T0rV8lKeG4yNQg=;
 b=Ot+rdoWDerZIXBrTjCGzBRiK1Wepta7DPcBX/y7DwWacjadAxGg6MK+hdodZkE+gF8u/PHOzmIr9v4WUtu70NTx4WbYjcdBi6LvFRIwOxhaRbkyA6LZz5Ly3DveURbO7/RUK+GyZEOtcDHAbVnSFzvVFs2JCMYGFtZTDuHalAsw0aZexlYfMU3iWY4TsTZixaFPDaORV+vhw7mlemUMeUjAPhBcXgYehZOT4QuZsgxSwYTXCXS+wQvVOHRD/lrlw8Aw7Za87V48hhIJaJd5QXz+jMJveBT87PpeLEfuwShD/P2GVGqaqQYYnwonQY5KBnVn0Vezruj3ns8ivwifZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zt1QSmgRejrd+NrfTWSKN0EhNtY26T0rV8lKeG4yNQg=;
 b=nCWlB4NUjKZ9BY93+w6EWzc9Y7ZzxyqSRjuAcfOKklndfRQwRVwr3KOFcxIrY/s42SLz5acQvfltyNWyrflXwHqmfuJETb7L/9Qp9bLGHngmq2n26/55sRODnJ/0JloM3JSbWyDS3qvmbEewHjC9SI8if6/OE6YOUAUHtbFWBEN/VAvwX2JaAOrje1UNjqhr8q5vC+2s39cDOT6gIkfnGisJVuC9Ai6DJMjva8S8BaFRhV8gVpigJSoPOVP2xDJ8djccMjmKqzVBjXlWw82H3qguA0U0XPLrIVdYkYfotKI/IwSmKtDq36eXLa2TY9K7BJwNKLZgbIRSPuJmuN0/fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEYPR03MB6816.apcprd03.prod.outlook.com (2603:1096:101:8d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Mon, 29 Sep
 2025 03:16:21 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 03:16:21 +0000
Message-ID: <eee93d9d-2977-449d-8792-b2416f0c09ad@amlogic.com>
Date: Mon, 29 Sep 2025 11:15:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
 <20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
 <CAFBinCBd5-s6vaBoJNerXavQiHgsv4Fm3v0svUX7geL=kJvVYg@mail.gmail.com>
 <20178015-4075-40e9-bbf4-20ae558c2bef@amlogic.com>
 <1jldyzrv2t.fsf@starbuckisacylon.baylibre.com>
 <e70e9aaa-f448-4f67-9149-cb5970c9bbd6@amlogic.com>
 <9834c7c5-9334-4c78-a2fe-588ff03cf935@amlogic.com>
 <CAFBinCCoX5+6+KQAtbhKx9KdSZhXVxS=cz8DfMVhjPX1c0iSPw@mail.gmail.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <CAFBinCCoX5+6+KQAtbhKx9KdSZhXVxS=cz8DfMVhjPX1c0iSPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEYPR03MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 19fa7adf-5e81-464b-f392-08ddff069039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R281d2REOUxTKytnMWFtdkEyQ1A5bWxJeTJjT3hQNDA4d0ZzbVJ6RTVyREZa?=
 =?utf-8?B?NFBnMGJmQmxTaTFsQ29pSS9ibUZSMHBmV0NsbjZXUmdQblVLa1BVYWREYmN1?=
 =?utf-8?B?cUVtZWZobzhVYndmNjNrZ1FjclpTZFhySksxc1hRZ0VrTjhqa2owMFRWOHVK?=
 =?utf-8?B?M052OXB5elI4Nm5PRHRBdXd3Q05aMklMQS80ZkNzOS9xbytDdklGYzhFYk1R?=
 =?utf-8?B?MElXcG5JVzZPY0xnSURyS0ZRU0x6UkM4cWRzVm9jak9QSE04bWF0eEdvYlVB?=
 =?utf-8?B?NFQrSTBoRUdHaStEbmVZME1BVUlucTdXUWIrek0vUmVKZThNajV6cHpSMy9M?=
 =?utf-8?B?WnQvM0ZsZHgxandXL2tzRGl6VW9CL2tOQ2tOU29YUmIvMFNqcFVQclZOVEdk?=
 =?utf-8?B?U2ZiWEl2UEVpUnRlc2FaYmpPMHpDeFdhdmxqeVowSGZONnlMU2xTZXBDVXNL?=
 =?utf-8?B?MmxHaG9NY0xxVnNjRmZ6WElMRzVINEFTSW52SE9sZi9XdWNJTzZiOXdFTU94?=
 =?utf-8?B?TW11UVB5dXJFeURqUlE1c1pGckQ4U09IUXhkRldGSWoyUTVZQW84bVpNOWZ1?=
 =?utf-8?B?cjNPa24rbVBnbUdzbVR2TFhvbkFNWmFyVkhoT09CVWl4OGx1K3RreW1qeW9F?=
 =?utf-8?B?ejlzUVpyY0x1YmRHc3hGV1IrZlA2MWFhT0RBSklSZE5sRzd3K3QyQ0oyaUdy?=
 =?utf-8?B?UlFtc2tOV2lIMUNKWFh2MlpKb0lSM1dkcEphRTJVL0JBdld2RDNkV1BHK1BX?=
 =?utf-8?B?TDQ5QU1TUnI4L3dJSFJoUk5JNlpabjBydXFNSWZZS1ZPc2hXdXVzaUxRbmoz?=
 =?utf-8?B?d1JYT04xOHdSQVMzSzF2NTY2T1RIcStJbEVDRU9pM24rTlNpNHU3NjFCaExK?=
 =?utf-8?B?S0NHVExCdjhQT0lkTEpKK3pTQnBjUWJuYUdIMzVUVkhGNmRlRmZxcUlMZHdp?=
 =?utf-8?B?WXJXNERBVTNENUF6TFFKbXNtQ1VnR2hLSkRwUk1mNkRYcmE5VTVwUEVzaTRI?=
 =?utf-8?B?a0pycEJwcUljcm51MkdrSTlCekM3NzdUeTc4OUZaRXgyQlNYamJZNTEwZEV5?=
 =?utf-8?B?SlRobzdQWlRSYzNVY1FqbysvN2ZNODFWS1lqY2ZnK0ZkVmR5ZHpJUkd3RUNZ?=
 =?utf-8?B?dzFVZTU0UHl5ektoNFhPeVVzeGUzWjBPbjRnR1pUSVBRNEtiYmdKMHdQUjdJ?=
 =?utf-8?B?eU1iTG5TUDRLVGpHZTJKaFRUUUF6ZkIrMEw2dG52QlIycUFFOExVOVhwY2pD?=
 =?utf-8?B?SkxzbzFCWW41UjRZZU5mMHRWeGlhU0o4TjJJMEVzQytDOFBEcDlJb1NDVTlO?=
 =?utf-8?B?cXVYMUp6Ky9aSm16ZENzWlVVUTI4Z0pvZk9DZTNKWFMxekptb2QwNVdXcXRO?=
 =?utf-8?B?ODUrN2Y0Y3NQYnJJWk9IZ3BETDNkMlptYm1iK0tjL1JnblU2QU9ZcWh4eCs5?=
 =?utf-8?B?blh5U3NjRklTMEVseDF5dVFLbHpKdWFnSGFzM0VWRzBhbGRnUEFNby9ac1ZT?=
 =?utf-8?B?OGIvbnc5NlRNb3BTNWtVQzI3SS9XMENTK2tsVC9VZ2hmMUF1N2xYejlaeE1Z?=
 =?utf-8?B?aUd0eEdrQ3BzdnMxUS9tcEh5SGdhcWIrcUNpY25mbnZybkM4RkRXaktTM1lZ?=
 =?utf-8?B?cEdSRnZkcVpmV29OYWxnT1JpOHkyWUFVdnkzUWpNNDBsUTdIaWRnTmwvK1B5?=
 =?utf-8?B?MWdsZnhwelhpbTh6ZVZNQWltUWdvdU9UY2NOZllnZVBVQVpVNnRjOXg5NVFw?=
 =?utf-8?B?ZGVkNWtXeWxzZlVrZzN2RGRMbW1mV1FJMWNhSXhhRVZuMjFmQ0NpSkxYNzJq?=
 =?utf-8?B?NUhBdjlGV3VxOTJFdXNMcCtKQm5BaWJyeVRuTjcxd2JVc3h0SWFzeHIyZnVI?=
 =?utf-8?B?OEMxeThXOHhNZlpyQThqSGJmU3RCU3hkS1JOM1JXWnFaNEY3alppelNDRGt0?=
 =?utf-8?B?TzlVOVJxTVFyVlcvSE5BalpvYzR2SXRPWXo5d1VMc1p2NTRydEw3OGI5TnRX?=
 =?utf-8?B?NVRjbmZ3QTJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTNRYkxXNytjZmtqS2U5MkM4VUpEZHE2enBpMHBqWXVzd0pPaVpEMGtISVRu?=
 =?utf-8?B?SFI1VjEwalB1OUgzRmdscmNlV1I3S1FoUXA3eTlQcHpzZTlzdHhJdlg3UlUv?=
 =?utf-8?B?dG0vb2E1ODBYNmV0Qll5eDd3NHp0My9jTE1PWHd6YmNmLzBsU1B2T3ZGemRj?=
 =?utf-8?B?SGRnelFqckZycFluMnJPbTA4VHg2TEdBamtlVXROeGh4Vno1ZmlzcXpLMGRt?=
 =?utf-8?B?enIxYzlBU3g3QzdtbFlMY0p1SGxNYmNvRWpLNHZxdUlpU0ltQjNyNGhodDdo?=
 =?utf-8?B?Q3ZhSEk0akhQWXplZEUwQkVyZ3MrTVE4RGdXcnNtd3VSaE53Z1ZSNlRZdlNW?=
 =?utf-8?B?cmMzWnh2dXJSdjRnaG8vUnNUNFZjdU5wRVQ4c2ZlVXVtQzJaUmJyd1AvVFpo?=
 =?utf-8?B?MVVQZEtNeXR4Sk01NGFKWGtDM1BodjlDOEUxZmllQ2JRSHVEVFlHZWhsU0VI?=
 =?utf-8?B?TGtZWW9TV2t4bDV5eWh0c1dxQ0tQc2Y2ZkQ1NzFlZG10a2k5TXU5ZGhTc1FK?=
 =?utf-8?B?Z0pXMXp6L05ubEZGRnFpRW95MVFsMXVSSzFJTE5FVTRFZ0hKV3FUOVdLcElI?=
 =?utf-8?B?N1VlajZuZll4UTJPL1lYN2svdVRKR2NWSzl5bzZGZEx4NXg1WVBYL0VLcnha?=
 =?utf-8?B?R0JHeGxVRXRabTIyc2swVDgzditWNk84cEdtVmtWcWxyUmlFYzZ2SlhobUE1?=
 =?utf-8?B?WllLY1VCTzVISVNJOWR4S1lLLzVobXZ1ZzhHTTZwZmR5eUFuUHpnRERnSmVL?=
 =?utf-8?B?ZnBkRjRCV1RHRDVRZXVtMitmeUFTdDh4UDJvaWhpdzU4TkEwOEhqeXc1Q05I?=
 =?utf-8?B?VTI5QUR0S3dwMXBUOG93aEtvTDB0ekR2Rk8zeVJoL2g5RFVzbzhLTzdFM1dq?=
 =?utf-8?B?WmE3c0E2REtEaGxGLzIzcmQrYTVzdlNSV05hYlBDUGRXMjZ2aTAwZEZqTFVL?=
 =?utf-8?B?VEVZM3NqTzd1Q1hQUXg5Q085OWRRQXMzeWFmOUxTWTlvcjdjbEFnTE5sS05F?=
 =?utf-8?B?Q00xdEtnK29wdHFRVEkrbjZzb3VwakZ0VXNzS3NINkxGREQrN0xzYmZObG5q?=
 =?utf-8?B?Um5aWHp2S3Z2cmUybU5ZWVRnR1M4NmY4a2c1M3YxM0c5NzQwMzEvK0duU0FM?=
 =?utf-8?B?N0hoYm9SWTVUaWFyL1l3d0M5ZzloTW5TUHZ2eEZaVmNoMndQa0tyemJlUzFr?=
 =?utf-8?B?OGdNV1pSMmN2YjJXSVlVRWUzclp2bS9raTQvc1RWU1pLRTIwNmlhREo1NGM2?=
 =?utf-8?B?VFRvdnZKUlArVDdpVXVmK2Rhc3Ewc1IycmtockZaN09KN1JlWUY2WUtheHRL?=
 =?utf-8?B?T0lUMmQ3VXhYR1NQWXQ4WUxBYUVzc3FEVUs2Z0hqNXVlZW0yRWF3VTQ0RDNZ?=
 =?utf-8?B?dG9EeWRPbVZ1bWJINGcyaHlGSSsrM0FkSTVsRTcwMEZYNDUybTJZdjFUOGsr?=
 =?utf-8?B?ZE9XZkRVZCsxRzhTV0lxRWhqQTFZT3dFODIwWVJIbkk4d01XTGFMeVN0NldK?=
 =?utf-8?B?YkNvOVJVS2R4cTVsUjFpS3k0MG5WbUlGUndjcDQvcHJnSmxkNHNPYUtJWWVy?=
 =?utf-8?B?Vmw0VE9BMTVyWC9PbUxwWE93ZE9ZdUUycTZOVnVCTGNpRlZZVXR3dUZucHMy?=
 =?utf-8?B?Z3RheXluR2M0a1pxeEhmN3E2dnJOUUJKVTFCdVFhYVNBNUxiQmY2WmVtS0sz?=
 =?utf-8?B?UVFTcW93NFV1dDREMy8yYkwyeTdHUDlhM3FiYlpYWDR0UHlZSXM1VVYzZWpK?=
 =?utf-8?B?bDBhcjUyUlNtc3N5TEc4aTArdURTNWNlWG5KTlpPN1J4QlRYckRScm9oMTRa?=
 =?utf-8?B?Qk1MTGoyVnpmamZ3cGVrU0dhYTNqSGpZQmNxNjdLWllVUHZGQ1FNN21rQmpy?=
 =?utf-8?B?UWZzanFSNGR2QkpOd3MvajZFVEhCMlovTGNZVTRDZmJCT0RNY1VFTDhhVFVv?=
 =?utf-8?B?YTFSOEVpTE5sTVZOeE5jN2NadWgycThKbU5jVFYzUjJOVCt4VWZQME1jQzVF?=
 =?utf-8?B?cXZMbUVSQm12U0Rub3YzNjk5bGRvYkdQUjVkZTZiYWFDdnZoT3QyYXZ1VHRa?=
 =?utf-8?B?QjY3YUFIOC9JV1pFb3hGWGZhNkphakZrWExGUjBZVU9PZHBYaWRURjBCOXh3?=
 =?utf-8?Q?8u3QDtdNSVfdt8+eTvXI+uc4a?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fa7adf-5e81-464b-f392-08ddff069039
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 03:16:21.3535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOc+GVth4lAjGqXsMRBTDc4nR0aMm1Qb0I/rgS9tpuL+PPbOU4C99q/cVlYPdYYtlHCWDE/04TM1hcHmXnRTYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6816

Hi Martin:

Thanks for the detailed explanation.


On 9/29/2025 4:55 AM, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
>
> Hello,
>
> On Sun, Sep 28, 2025 at 8:41 AM Chuan Liu <chuan.liu@amlogic.com> wrote:
>>
>> On 9/28/2025 2:05 PM, Chuan Liu wrote:
>>> Hi Jerome & Martin:
>>>
>>> Sorry for the imprecise description of the glitch-free mux earlier.
>>>
>>> Recently, while troubleshooting a CPU hang issue caused by glitches,
>>> I realized there was a discrepancy from our previous understanding,
>>> so I'd like to clarify it here.
> [...]
>> An example of the clock waveform is shown below:
>>
>>
>>          __    __    __    __    __    __    __    __
>> ori:  ↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑
>>                     ^
>>                     1 * cycle original channel.
>>          _   _   _   _   _   _   _   _   _   _   _   _
>> new:  ↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑
>>                                         ^
>>                                         5 * cycles new channel.
>>          __    __                        _   _   _   _
>> out:  ↑  |__↑  |______________________↑ |_↑ |_↑ |_↑ |_↑
>>                ^                        ^
>>                start switching mux.     switch to new channel.
> Thank you for the detailed report!
> This is indeed problematic behavior. I guess the result is somewhat
> random: depending on load (power draw), silicon lottery (quality),
> temperature, voltage supply, ... - one may or may not see crashes
> caused by this.


Yes, our glitch-free mux is designed to prevent glitches caused by
excessively short high or low levels in the clock output.


>
> Based on the previous discussion on this topic, my suggestion is to
> split the original patch:
> - one to add CLK_SET_RATE_GATE where needed (I think the meson8b.c
> driver already has this where needed) to actually enable the
> glitch-free mux behavior
> - another one with the CLK_OPS_PARENT_ENABLE change (meson8b.c would
> also need to be updated) to prevent the glitch-free mux from
> temporarily outputting an electrical low signal. Jerome also asked to
> document the behavior so we don't forget why we set this flag
>
> Both patches should get the proper "Fixes" tags.
> I think it would also be great if you could include the waveform
> example in at least the commit message as it helps understand the
> problem.
>
> Let's also give Jerome some time to comment before you send patches.


A V2 version was submitted later with changes based on your suggestions.
Regarding the "Fixes" tag, Jerome had proposed some modifications.

[PATCH v2 0/3] clk: Fix issues related to CLK_IGNORE_UNUSED failures and 
amlogic glitch free mux - Chuan Liu via B4 Relay 
<https://lore.kernel.org/all/20241111-fix_glitch_free-v2-0-0099fd9ad3e5@amlogic.com/>


Adding CLK_OPS_PARENT_ENABLE causes the CLK_IGNORE_UNUSED configuration
of it's parent clocks on the chain to become ineffective, so this patch
depends on fixing that issue before it can proceed.


Jerome and I have submitted patches to address the issue of
CLK_IGNORE_UNUSED becoming ineffective. I originally planned to wait
for progress on this patch and then incorporate Jerome's feedback before
sending the V3 version.

Hi Jerome, sorry if this caused any misunderstanding on your part; I
will provide timely feedback moving forward.


>
>
> Best regards,
> Martin

