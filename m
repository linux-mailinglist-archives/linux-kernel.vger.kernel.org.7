Return-Path: <linux-kernel+bounces-891484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3907AC42C07
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 12:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF9ED4E7BE7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 11:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980F62DF138;
	Sat,  8 Nov 2025 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SasukPuR"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF37273810
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762602094; cv=fail; b=ef2Fs7cKDXxAm5vd3+NdO4YQsnq5/XE2ROHFQ/REF1ur2u+W0W1OGiYa96VC78U+B2BoirZCHGOR3JrEBoBxB/l8GMnzffueNepeQ/UqLFYk0/tTGxLIRKFS0HdEqtmCj9XFH190zO52HRyi5kn9aw7KN+Dhu3UGbeyRBbWmd3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762602094; c=relaxed/simple;
	bh=C/UUzQ5+NIlRXz1dMSCpS1MdvzGpVwpmJHi+rf0ThHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RGTXaanDDoabRI5SuTFagpOVWwD6Z5RhTyJigpSSHrXQCA9uceQzcfLrjUgTWQHihtLWFY3Uq2gElrAIokpWjp+v388zWsjUGEyPqgiBP+rtY1U0vIW6GIQOyH6trm9w8P7iNQlPYpJUnQkHjohr4fBRtr9oVxj6PcPWNIF3XfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SasukPuR; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBdKLcZJqu+mzH2j/KcVtzYP2xvGe3QhxSY5QtB9B97Q0ya0yetHz9TqpoJdNltuQgMYB9V+0QHC3acpqbn5hRuik1NRuOS1fiSWGrbKnqfxK1Ib/3yqgZZuIOsrU5RDCZj6DCtKx4TqI6v46KAmMnlPCJ94fT807Wjwk4D7Ss50mrpYm+QEQbHP0BZ7MWaHtsiG2WLm6rpX10dT1ip7JKE+/iy5xUVkS1FIkVz/WM7K2caeuO3BcFvEoOCBoQeh44fV95Lnf5nuktqKOo/jGh7rKslhAj5ESGJg+cpEbUJ/PzNyWWvk0KVuNHMie3tMz7E6HXPM68t5mb1LxOjhfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/UUzQ5+NIlRXz1dMSCpS1MdvzGpVwpmJHi+rf0ThHo=;
 b=vwhqD2lRLaHEnTVSF+Hlm0BA6WPvkNVFN7tAbwDl+HOa8QVPHGEuktN6xsbQbiWpHrXJR9e+XvYsOCEYfloN9vChqT7WRaFGmNcW0VK/nRxkVempTs9zygBDKeJW+ghyCYgpAeGWuIj6N5h7N9rwCjud5h16Yoc/Eb8Hkq9ZF+ROSSMQ8ZiiFO3MEcoclC7AMqP+BiTNVFPKJ7VzGTYwAqzPzoQCBfF2xsRJBWTNBZTiiFMzu2hLzgMRX7Gvv3YNQ8IFbIKhGnmNOsxsZCploGe05OSFOZYA7oNgzUhQYnNJwg9N2deGDcRUMkYd2MzVXrfRla6y9iB/951eCh6XkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/UUzQ5+NIlRXz1dMSCpS1MdvzGpVwpmJHi+rf0ThHo=;
 b=SasukPuRyOgL0FpFWYS38JS1P0PnGOVghAWcZVkaCiGzWzg5lBrva42FXIC65yHnc6nFrXnRMyKlto7XLHnbcUcL2L7IpxRaEY9I3AAy0vu2C1ullz45upE3mXEdHXY+qYIWNBWObwLqw0zlr9GlbVmoxVzhbqXKcHRwI2zRhl1sKQZmeMEo/F9tPrqGdR8eip4izqP3o9Bqo0WR6PwynmGudidKDA1V5a6/mUVse8xNPgRICFoWQrlA5kXQfM1LzboXpskmA5xk756q4CD21WgxKSMaJ+Mr8piiuSrCPJjPUtpT2H2lxkE4N6nJMWs7WiFXtgc4Oo1CbSoYSDORHQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM7PR10MB3192.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 11:41:26 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Sat, 8 Nov 2025
 11:41:26 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "hui.wang@canonical.com" <hui.wang@canonical.com>, "mwalle@kernel.org"
	<mwalle@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "florent.trinh-thai@cs-soprasteria.com"
	<florent.trinh-thai@cs-soprasteria.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Topic: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Index:
 AQHb66DA/2ST5DqqmUGvisuiiSELdrTh5/AAgAICrICAAIdYAIADcAkAgAF1DwCAABN+AIAAB2uA
Date: Sat, 8 Nov 2025 11:41:25 +0000
Message-ID: <cd174dbaa3171f92e083d5dca89732aa64e32f15.camel@siemens.com>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
	 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
	 <2025110513-manliness-repayment-d005@gregkh>
	 <db80adb8b8006fbdeee77a386feabb81537d27e6.camel@siemens.com>
	 <e0037dc532f3aecb101c78e7d91b66430b15d541.camel@siemens.com>
	 <eb0cd539-9d76-489a-b5f4-ecef2a6d32dd@csgroup.eu>
	 <a88e1546-1530-4326-b0ee-dc4e50d0343f@csgroup.eu>
In-Reply-To: <a88e1546-1530-4326-b0ee-dc4e50d0343f@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM7PR10MB3192:EE_
x-ms-office365-filtering-correlation-id: e3b319a6-8bae-467e-f37c-08de1ebbbfe1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1ZuVitGNmdwZHNhSURmOVg0U0R4MVQyZTNMaGxIREt4S3ZYREN6ZXFLSjRv?=
 =?utf-8?B?YmVBSTNLRVg3eDFXUnZROEtGcm5nOFFaZFp1RmNLZE1sUjl6QkpRalNjVmlZ?=
 =?utf-8?B?UFd3TG1EWUpZeFFIblpjT3VDRFNqTmpiT08yNDN3REo4Um42eEx5YW9wWWI4?=
 =?utf-8?B?T0Z2djA0aW5oTXZaQStGM1RXZHN5b1lNUm5OYjRIWUNpWmtZOXlvMnBycHlo?=
 =?utf-8?B?NThkRFliMlVlOHdXOU9ta2NNc3FuVFRQQ2tMdzV4TGQrZUp4THFPSUVoZFpv?=
 =?utf-8?B?K0JvTisvUmJuREtqMGxwU3F3VC9zRXJ0aGdobC9NSlNEeDlkZmdKYmlPZFl4?=
 =?utf-8?B?RGl6TnZGSGZCK1dhUVZkalBuWkFvam45ODVTQmVFazJkQ2FoUk9qSTQzL3JR?=
 =?utf-8?B?eEx5Y1dlc2VYMm5NV3A1bnRNWlNpVnh6d2xIaWpPU3NXeThQbHJPT2U0dmFC?=
 =?utf-8?B?eG9TV2dSQzJibkdQQzFpUm5jYldqK01lQkNxRXRYL2RJSHRCZ0d1S09KQ0lh?=
 =?utf-8?B?ak5wK3haOGJqbmRydmtjSHpFREFjVGkwMWJtdWIvczFMMFd4bnVMSHVQbVJm?=
 =?utf-8?B?QjRiZExYVkhzdDZmbVpEWm45K2d6VUVhSWx0Ym4yWDNRUWIyQklnNkxvN3V2?=
 =?utf-8?B?M2YrdGJTZTZrQWpWWmtmbXBGbDBOTzFYT2I5bml3aXJLWmlxZDRVTkhNZ1RC?=
 =?utf-8?B?U3pwKzlaZnB6R1g1QU85WjVhYnJtN2tNcExGOFZqQzlSMkVTeXhnZU9tcWlq?=
 =?utf-8?B?Nlh3c3J1QkJFbDFMcVBwalN1YVN4RTJIQUIvS202WkN5YXpYclA5aXN2SlND?=
 =?utf-8?B?TlVwZzZuZW5xckJKOUNwc2hXTDVqZmVjTUJtQWJEdWUxMkdIQVNGaVcwMHQz?=
 =?utf-8?B?ZlNCVHcvVVk1dHlWSDR4NnpoVkpnSkVrYWFaQmw3UFRqOEF5a2p4aThNaHc5?=
 =?utf-8?B?R2dYYUZUTDFJT0l6RnMra0QvOEY0YWRaL3E4ZDVyTUFTZnZSdEwwZ3NsZGRL?=
 =?utf-8?B?RTFHNHF2T2JsL09tdkhibGdQZ3N6S2Y5cEIzcURPcnBsWHYzMm9NeUpPamEx?=
 =?utf-8?B?UEo0Ymt3bExTdmdDOWtydGF5T1NYems5NmVrbTN4cUVNc01XcGlJby9nZ2cv?=
 =?utf-8?B?WEdYVlJiQWY1OW9NQlk4RUNSVFp5eklXZFRjSWNHYWhPWDZsZVpucWxSTk8y?=
 =?utf-8?B?bDR6d0JrYnFyQjVHbGJNUk0vUTFMc0EreE9Xa0RjcDgybzlCTGs4dFBCbU54?=
 =?utf-8?B?aGQxWXNZK1N1akh0YnBYUTlHMHFJOFc4bC9qVUMzcnUyZDF5RWtrY3ZMVVR0?=
 =?utf-8?B?TFppKzZHY0NFMlVFQ1RrRDh1OHRBRmcwSlBiaVJJMnJLeE1uUUY1RHF2WU83?=
 =?utf-8?B?Uk5EVnErdXVtNEdDMTZ3S2FIdXcxV0gydlVvRlFEQ0xveDkrUGtMM0JMU2xq?=
 =?utf-8?B?V0pVNTd6UTNqZmZ4VXR6RFMyVVBseW1CNFhhN2xzdzlnL1pWV0M0ZWlOUnEz?=
 =?utf-8?B?NjFrakZld0ZpRVMramtzdnplbUFha0pJVFRNQ0o0Nyt2b0NZd2l2NWpmb3k2?=
 =?utf-8?B?NEZXVS9pTmZIOVh3bTFndnF1SXNMWTlTVVdWUzZ4Z0RzdldnTFdTWmk0cVdp?=
 =?utf-8?B?OEJXd2hrcDZuTkdER2w5VU0xaGM3aTJZckErNVhCUFhOSnJXejg0VE9vQlFW?=
 =?utf-8?B?cWVKLzhnT1pGdkxTODd5THBhVzhVd0E5WFlucUR2WlhFZHNmUU9HaklaMisr?=
 =?utf-8?B?VGRFYlZZanFHY2ZyVHJHbUhyajd2bVIrdGNJNVRKU1h3enZqRktIYnFwTk9x?=
 =?utf-8?B?YTZZQVB1MzRPNVV5bjZJdkxLeGMrZTV0Z3lGU1BsaEVsZ3lrY28rbVNXL09r?=
 =?utf-8?B?Y0FWaUNBTUVTUk1Yekc3S0w2VWxacWNjbllwUHluSGRqM0VsMlRKVUhmblg4?=
 =?utf-8?B?ekpQZXVVcWRyTmY2VnkzV1NxWlYyanV3NzFkK3NpRTNPOEFsU0VQNFA3NU9a?=
 =?utf-8?B?cWFwcDhPdkpBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0JMTWN6QkUva2VwY1lLKzZvM2hJMU1iUmJjd2p3OHoxZzRBdnUxY1pjWE9W?=
 =?utf-8?B?OTU4OW45ZmFxMk45KzVKaG5RbllxNTRDL2lmY2FqemZhTGRPOVphUkpFbmVQ?=
 =?utf-8?B?T1M0elFJN3lQUmhkK2xKZERaekZhZE4ycmdaTSs4bWtYcWlkVnZkdy8xaHlm?=
 =?utf-8?B?MDRjVFFtYkdWYnRkRE1kd3hkQkRuWElySElvNTY5SHNIbHpnYzBkbmZuUUs2?=
 =?utf-8?B?eE92Q1lmaW5YbXkzZVluTUVRSXN5Y1Ywd3lyQmlGNmpVYS9zU2RxVmdyT2Ja?=
 =?utf-8?B?Ym41LzlzMHNjNjdFUG9uUURXOWpSalVZcVFvWWM4d1A5REJxcGNMa0NNTzh4?=
 =?utf-8?B?MEFPM2VuSW9nTnR4TFJNYVg2Mi9iWjRkTk1vMFE0YStTVjd6azRycjJlaXYz?=
 =?utf-8?B?eTRVdzB5SjkxYWtTTW8wM25ldGo0SkdXbENLdlVaL0RlbEVRWjNVUnBsWWpB?=
 =?utf-8?B?cDhUd21DeHQzQXBuQjhwMjcyNXZzYU5Xbk8vOGt6ejlyZXpJemkwU2pCV0s5?=
 =?utf-8?B?bXV6Y1ZQT1hwYllScXlodFhyMWh0MWlUUkVHL1p2OGtMbFhpR0xudXBnR0tY?=
 =?utf-8?B?VEVyNS83M2RvUnN4anZFVWhVaVBCWTR1YmNpWVNrK0IrUFpTdVVhdFNsRmly?=
 =?utf-8?B?ajM4WnE5R3M5M2hmdml5TTFFWFdta25ZZ3NSV08vbjd0cE0yV2NtM2J1TXQ4?=
 =?utf-8?B?b2NZK043ZVFRbzA5VVBUdG9Gdm4vMGU0djJFVHdRcnRFMVltdU15RGtMM3NY?=
 =?utf-8?B?Ky91OWJGMGJRbzhqR1RDT3FWRjBJZ3JCSVk0ckpEdVVlQndBVCtvQUV0aU15?=
 =?utf-8?B?VWFkQjdrN1daTFBuS0E4N2gyYzE2RkRlRk9sTzcxVkpDMTlkTXE5SXVIYTB4?=
 =?utf-8?B?aEsxcFhsczlxTnU5SUpEOU1DL2pCc05mM0tJV21jbTlPSE9PaWV6ai9DaDdU?=
 =?utf-8?B?ZnRjaWJ2dGhRQ2ZCZnlLRittTy9SbkcrdjFlUjVSZzJOLy92K1FCZUYwOU5F?=
 =?utf-8?B?Tk1Za1pRb1IvMHJsL3VXRzhYOXNhakRSMDB1STErV0NCSE9XM21iT0lLQmFO?=
 =?utf-8?B?K1JvQ3M5VEFNeWcyNk1HTnp6K0ZXTkNxck1XbGd5aGRQWWdHWTk2SjJlNU9Y?=
 =?utf-8?B?U0didmxRTVpFS1ZIeFNydE5TVjJRdld4NkNJUnE1QkR4dHlXeGVmMlNPTWxL?=
 =?utf-8?B?V25SZXVFaHVubnNkdFFwczZXVkZIdmJFaXlWNTRCWUNXMjFRTVZTbUNlblRn?=
 =?utf-8?B?RHE5QmJ6Mm1Ebm5oRmZsOUpITGU0UEVDN011dWRDOUJSbTEwd0k1WHNtdEFU?=
 =?utf-8?B?V1V6MU1yWGtOK2xFM3NyTWxEVzNVMGZnYWlydmJ4Q01OK2tFcHpjTkdTa0NW?=
 =?utf-8?B?LzZKR0djVXJmMlpWQnZhR1IvVGFoRWZzZjQzcURRSzFrWm1ybWZXZWFETHN5?=
 =?utf-8?B?Y05YMDVYc1k2MjlmV2loSDR5QzA2bGlxbnM3V0FVczJrcUpvUjUxYjZGMWho?=
 =?utf-8?B?OHRNMmc5QUR2N3F3ZmoyL3p3c3l0ajBzUzNpeC9KUWlYdTZoY0VuVTBLM2Z5?=
 =?utf-8?B?a0tnZ2JsV0drK1NIaVBuendXYXlYSUVybDBiSklrQ3YwT2ZxOGlxZ1Fvb25l?=
 =?utf-8?B?MS96eXRHUEN4UCtiVzhCNVRDanF0aTRYVzB4dS9FcURQWnJIWEtaS2oyZkpu?=
 =?utf-8?B?UVludDNmekxTL0R6OXcxY3NEeFdmeGE2UkFwTjZIdy9JaHNJZG1QaFgvOE1J?=
 =?utf-8?B?eEQ2THUwZkZHSW5CVFVhNnZZaWJZSEkxQi9GZUVVMy91ZDNCcUt4N3ZOVjhs?=
 =?utf-8?B?T05oK08zUUFSekRoUDhXUCtxOEtXcUFuZFZnbXQxemM3VGlkbTNNTi9QTmUw?=
 =?utf-8?B?SmFwS3AwZGlkTUxMdXgzMys5M3dMcDkySVJXa2phOWFaS1ozS0g1VGxKcHZO?=
 =?utf-8?B?RlkrMklPd2w0c1lCMC9GczRzY2drOEl2WkNma2s1eUxWN2ptZ0ZPUzJ6OFhU?=
 =?utf-8?B?S2hka0ZPZjFzcm1sSVcrQVIxckdCWUZ5RUhiZ0VnQk1CNHc1QUNBYzZpcUlF?=
 =?utf-8?B?VUVWT1pRb3Q4QXNCTFpLd0RGVW9EaDM1ZzJFSE1HcUhZaE11cFFWQWozWFdQ?=
 =?utf-8?B?ZFE4akJOR05ZSWhIejd0K0h6WUUzYWpNRWcrcWhmVXhOeFR5VjJxaVVPVTlj?=
 =?utf-8?Q?sLEV0mARCVKH3bLDmRTcmKo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <037AE71CDA12A94F9ADC4456F30F35A6@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b319a6-8bae-467e-f37c-08de1ebbbfe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2025 11:41:25.9163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: byEKC761vMbBttgXvo+XrYPy4DMoVwvDTHVZ8AnRT6GqSAfFYW01v5egpWebTXFJEoz3QoeTaZDefWqMZUrSXUvF9p5Y1qOf3/lgoB1eC5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3192

SGkgQ2hyaXN0b3BoZSwNCg0KT24gU2F0LCAyMDI1LTExLTA4IGF0IDEyOjE0ICswMTAwLCBDaHJp
c3RvcGhlIExlcm95IHdyb3RlOg0KPiA+IE5vdyBJJ20gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgd2h5
IHRoZSBwcm9ibGVtIHN1cmZhY2VkIHdpdGggY29tbWl0IA0KPiA+IDhhZDYyNDljNTFkMCAoImVl
cHJvbTogYXQyNTogY29udmVydCB0byBzcGktbWVtIEFQSSIpDQo+ID4gDQo+IA0KPiBUaGUgcmVh
c29uIHdoeSBpdCB3YXMgbm90IGEgcHJvYmxlbSBiZWZvcmUgd2FzIHRoYXQgdGhlIHRyYW5zZmVy
IHdhcyANCj4gZG9uZSBpbnRvIG9mLT5wcmVhbGxvY19idWYgKGZzL2tlcm5mcy9maWxlLmMpIHdo
aWNoIGlzIGEga21hbGxvYygpIHdpdGggDQo+IHNpemUgKFBBR0VfU0laRSArIDEpLg0KPiANCj4g
Rm9sbG93aW5nIHRoZSByZXdvcmsgb2YgYXQyNSBpdCBub3cgZ29lcyBpbnRvIHRoZSBib3VuY2Ug
YnVmZmVyIHdoaWNoIGlzIA0KPiBhbGxvY2F0ZWQgd2l0aCB0aGUgZXhhY3Qgc2l6ZSBvZiB0aGUg
dHJhbnNmZXIuDQo+IA0KPiBXaHkgZG8gd2UgbmVlZCBhbiBpbnRlcm1lZGlhdGUgYm91bmNlIGJ1
ZmZlciBub3csIHdoeSBjYW4ndCANCj4gb2YtPnByZWFsbG9jX2J1ZiBiZSB1c2VkIGRpcmVjdGx5
IGFzIGJlZm9yZSA/DQoNCnVzZXJzcGFjZSBhY2Nlc3MgaXMgb25seSBvbmUgcGFydCBvZiB0aGUg
c3RvcnksIHRoZSBvdGhlciBpcyBOVk1FTQ0Ka2VybmVsLWludGVybmFsIEFQSSwgbGlrZSBudm1l
bV9jZWxsX3JlYWQqKCkgYW5kIEkgc3VwcG9zZSB0aGVyZSBpcw0Kbm8gcmVxdWlyZW1lbnQgZm9y
IGEgZGVzdGluYXRpb24gYnVmZmVyIHRvIGJlIERNQS1hYmxlLg0KDQotLSANCkFsZXhhbmRlciBT
dmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

