Return-Path: <linux-kernel+bounces-722712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624EEAFDE11
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B56567DF2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C651F3BA4;
	Wed,  9 Jul 2025 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rIUVaILi";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DJuXPPSs"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEC81DC988
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 03:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752031539; cv=fail; b=ruGuwv0YVKVlhn+APdllrZuuT6+uoX+QuMwYfoV0IeV7xsgDJsX+Ao989o6G0pK4vzITgu7mkDKXDYaqIYTNSnJN+h4VANZJ5+YhHOMsfvoyVZmhq5umPEmFAHStpeiHEbLa4m6q2GbzZ8s0O4QqPT9KkCwU34op8vP7yjRfYHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752031539; c=relaxed/simple;
	bh=sL3mjZ1nWhk5++B9tCqJsg8KKcuL08VT0MOxghnVFPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fbZJYF/+iKnwpHBFtL+tcPg5pwlOhIN9L1VRmA6Rih5w5hzkjFggXseS0YXKh1dx5eiA6KwrFgGPpFOI/GI20I2IA8gpxj9jYC0fIPR+CFa8KdndT9vOCtHRkpDDEpnI0QW3eSSIP0jiqdr3jVXSa47NwgIcue5+EKidnGiPypk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rIUVaILi; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=DJuXPPSs; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5e1ff0c45c7411f0b1510d84776b8c0b-20250709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sL3mjZ1nWhk5++B9tCqJsg8KKcuL08VT0MOxghnVFPc=;
	b=rIUVaILiAMCELBlsY4zzf0h3k8Nr4lOSzUt4Htu1svRETSOSw1Ghex5+MqBRxHUwPmn3VjiDVJyUes2DIj8xSDMEkVC4wfURSfziOfgqNIR3W9ioL8rtO1IZASgsB/sIhwKvuwtS3lu4Ju3nukqof3NcjUANV1ezksPxn2YOhR0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:9c719e9d-e265-4bbc-b067-510a01a91ab5,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:0a5001d8-b768-4ffb-8a44-cd8427608ba6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5e1ff0c45c7411f0b1510d84776b8c0b-20250709
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <qun-wei.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 827334984; Wed, 09 Jul 2025 11:25:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 9 Jul 2025 11:25:28 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 9 Jul 2025 11:25:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oq3k1v7GFvumzhAXBCXToGzFOnM2tAgab5UmgLPHHIiVQxSuj+zhXy6hj8JnKUgMKSpniNWY5efgFPeDyvhy7B0yEq3sy0g6PIG0r0CZlL/O2tC32Wol2LTlrwO8ja/yW8QCBixwAz4xznFWA7dj30wRUYc5mrbPATieDKVsZKtjwVGs49yAld5xppNHv5ZOd+YW15co8uAIxJDJoLXcUT2K62qGHiw3T5AmwtosAqw1aUjCawyqoLxSlR9jVuHszfaZ74hgqmPkPCoOu3p8maLAJDAfhg8psKAaQff4PdGkmfRAiLb4kshMjhEVYTmxXt2xO0GgMb7fNas1LZTaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sL3mjZ1nWhk5++B9tCqJsg8KKcuL08VT0MOxghnVFPc=;
 b=lPqimBkOwZA87UNwFPzswnJ6fTDWhdH+CJXnCalLqTub8L4fprO/oEuYgRczDKOQIg/2joGuuL13lQkNFOPO8W8jBMSVEsl1nlGKuzqdI0+5tBWXjHgVsOJPHmnnTkiHm74/rwTiYVXcdOemHtXJKCr9+2at5ekfRd2WW9xMODztY17Q7/XQFv46ZcdqUusXUcLcOYer3FwTLMZzVyDVMDbYb1/6YbfcOhPZHS0jtCQoRV0uhiOxMX9gsKbyYqjY4iZY1s0yPDGYc/mNaQDCA+9dotkyYKKcRTaijY5vRkiCLIiwOrup7NGGqLj+MelSEHbGXmmY2+8H9u52ruHulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL3mjZ1nWhk5++B9tCqJsg8KKcuL08VT0MOxghnVFPc=;
 b=DJuXPPSs7VUsRaWAQvD6Tl/iNbVxrXlkBCYsUPE7VyvWZ7OlSUAjVWbKkkWm/W/J5MeYAkKbpQeIgN35uCQRX2kns5owafsahLIf2TU7Fbfp0wfjFkJQKuak1NWMmADyxPoHj349SvYcBFmpaBn1/BKSaw4YQ6lcaEt5GJFsnZE=
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com (2603:1096:301:4e::12)
 by TY0PR03MB6655.apcprd03.prod.outlook.com (2603:1096:400:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 03:25:27 +0000
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02]) by PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 03:25:27 +0000
From: =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>
To: "hannes@cmpxchg.org" <hannes@cmpxchg.org>
CC: =?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
	"rppt@kernel.org" <rppt@kernel.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"sj@kernel.org" <sj@kernel.org>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	=?utf-8?B?SmFtZXMgSHN1ICjlvpDmhbbolrAp?= <James.Hsu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	=?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?=
	<chinwen.chang@mediatek.com>, =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?=
	<casper.li@mediatek.com>, "minchan@kernel.org" <minchan@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>
Subject: Re: [PATCH] mm: Add Kcompressd for accelerated memory compression
Thread-Topic: [PATCH] mm: Add Kcompressd for accelerated memory compression
Thread-Index: AQHbuam75fKFDYRy3kqH05cQs0i7u7O90AIAgAATqQCAR4n8AIACRVaAgAjVsgCAB3hsAIARjcmA
Date: Wed, 9 Jul 2025 03:25:27 +0000
Message-ID: <ed9e0fd13047b219839277409de52d6d2d041f4d.camel@mediatek.com>
References: <CAKEwX=ObLVcbR9q7ZvR3WE2hhmxLpk1bSuvcbWZwo5o5vPCDRA@mail.gmail.com>
	 <20250623051642.3645-1-21cnbao@gmail.com>
	 <CAKEwX=MTuxSbbSWaKOwdjAgdar2=D83UW-j9mV3qDSg+ZHHwkA@mail.gmail.com>
In-Reply-To: <CAKEwX=MTuxSbbSWaKOwdjAgdar2=D83UW-j9mV3qDSg+ZHHwkA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5542:EE_|TY0PR03MB6655:EE_
x-ms-office365-filtering-correlation-id: 7ea3a083-d9d1-48de-07eb-08ddbe983fdb
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c0VRSk90RTZlWjcxbUtJUy9KRkhCSjhPVEFVSzBQaVhvMjZNclJ0WjVQT25r?=
 =?utf-8?B?d0Y3WEh2cTZsNGVSR05OeENIT01heW5WQjdMelpoRkF1N2xQQ0xVVDNxR1lj?=
 =?utf-8?B?WUNJU2hYSFQ5ZEthdWVoc1U5a2pKZUd4NlNyNG5ibVNpL21VQnBHVkh4S3ZS?=
 =?utf-8?B?MHpVRkFqbDZUKzNOL2dQeUxwTmliM05rQ3pGZi9lWG5pYXN3MUpqdDBlV0NJ?=
 =?utf-8?B?VEwvaThucG54ZHpDYnE5bGV0dG1FNGtKRlBUNXBNN1RTWUUrUzB5S0tYQnI1?=
 =?utf-8?B?VnVaRFZFUm9zOWdHbHJHNG5SdC80eEFLVStZNnhVbENOazVucnNKV2VkQ3FG?=
 =?utf-8?B?ZC9qcU1CNWpNZUpucTlQQ0hKc3BGdVM1WVdWd0pmWU82eFR3SDRuSUZzVkdJ?=
 =?utf-8?B?NEErVXFVWG5sQkpDQWhzSGVsOFJRakpiQjFnNHhCV0pZbVpzUlNsVUdoNDRo?=
 =?utf-8?B?TEk1dXlqR28vdTJ6UjJ6QzgxU2UrU2VRS1dMR2VZbWVndFZ6UjQzNzdaRTFi?=
 =?utf-8?B?c2pjem04d28rR1JvUG9WUG1qVzJUTnVseDJpVmFOR2g0Nm5VSVFKWUZGd3Z6?=
 =?utf-8?B?OG02WmtLN0hEOWVOQXZOWlg3OUszcFlWbjRsZm1TTVhXVi9OYlJmZTR1RjhW?=
 =?utf-8?B?cHdCcE9jUFRSQlpyQVB6NHRtaU1kM0xuUEp6ZUxFaWU5TXZ2Y1R6b0szMm5M?=
 =?utf-8?B?MmlNYnFCcXJnRnNOR3N6b0VWTGlyaEFPMFc2dlQrenZMVEVFYmJIUTIzWEph?=
 =?utf-8?B?Si9kZ1lUS2hDMnNRZHV1WEpxNlhHMXN5V3E4Y3F0ZmlPc1VSL1JUYVFzVnNw?=
 =?utf-8?B?ZnY2TVRmcHNzdlZhNXBpUkNFdFdhcGpPNWsrNDNzUHI5VnFTL25ieCtaZHZO?=
 =?utf-8?B?WUl1Qml4U1o5UHBXd3lSWnVOVFdYcDZXTHhkZ1VlTm82dVJDdGxiQ3BEdmRq?=
 =?utf-8?B?S3hKMEhZcExjTW1CNTNIVmZJcFo2aHljUFpLZjB5NW5TbmJMVU5zeWFpRmpk?=
 =?utf-8?B?VzFnU2hUYk9WSWp6S01wdE10OUVWUmF4V3VnQ1NYWmtDQ2RYbW9INmw5ZVhx?=
 =?utf-8?B?V0lLbE0raGdmaG5lMEpORnZvS09zM2hra0ZTZTcxTmU1Z241WUdnZEU3RzZw?=
 =?utf-8?B?b0ZIOVI3a3JoK3Q5ZGZmZ0ZLSnIwZmd3ZlpBTlNsdkFJOFpCV0FrODZoY2Ux?=
 =?utf-8?B?RnBGRklOdm1XOFFUdjRuVnZtbkw2ZUp1YkUyeGxPaGdmV3VPVS93Yk5WenFp?=
 =?utf-8?B?TkRNWFpXM0daem9ZNXQ0VEcwSzEyOXZxUUxQNkdOREpvZnlhVHRCMWZ3M3lj?=
 =?utf-8?B?RDEybVlnTkJMUjF3RlQ2Qm1YaHllcjk1ei9FNnpWOUF0YU11dmtyY201THk3?=
 =?utf-8?B?cWllem92VjBNUnBXOTVKbDRxUnVMTW1aNGRyOVhuVVcwaWdNMlpNeHRVa1Bk?=
 =?utf-8?B?Z0VVSVhxelpFbW45ZEZ0Tm5lTjBFWTVERmxtZWN6Snp5Y211K1ZFWGNDamRl?=
 =?utf-8?B?WWZCeHVnZ05ZZ05YSVNzQ3VUYkJHYkVoN2JuY3ZLckE2OWVhVklHQU9JajJJ?=
 =?utf-8?B?eXBFdXhtaTkxQTJ4UXpNZWxhQVhaekVITk9keG9wVnVERjhOTUJLdGRMTXM3?=
 =?utf-8?B?TmY0RkMrNUpmd2l5eG1iSXd4RjEzbm94endYbVhtMjJqR0pNZTAvSkYwSS9E?=
 =?utf-8?B?ODFQdURndnp0VHN3NVF1dmw5QlhpTkpFVEhmR3ZuU09yT2pUelU4bUFQMGZJ?=
 =?utf-8?B?b1ZKTHc1OEdINTFhTll1b05CWlJkem9pbloxdCtKSGJpWXRNMGp1ZWhRVWQw?=
 =?utf-8?B?WEQxZGpsLzRUb0s0M1U4ZllhVXJIZDFubkQzN0JHSWl5VW9CTVBLc2thV2Zq?=
 =?utf-8?B?Y01XekludGpjeFM1R240d0xxZm5HVS9WclRESkUyM044SEJuRmdMcDNOMVdk?=
 =?utf-8?B?U3p2ak1qUi9XOWNJTndwSjB4NURKQnRVTDlYeUtocUZOYktTZmd1SnRCSXEr?=
 =?utf-8?B?dE5KTkdrejBnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5542.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3RjL2tRVkxMQUk0ZmxYUFlJY1FRQzlJcG5KRi9VRjZrWWY2KzJpdVNsWENB?=
 =?utf-8?B?aG1WTzZvaTdKOU8vS0dCUEFMeHhBOWpIcUxLcnlodFhzUmRmdVRLcHkrMVNV?=
 =?utf-8?B?c2NhcHQ5NWllTUhFY2R0NFB0bjF2YTlkTFZ0aWpHUXV1UTFyK0pmQmZOdXZZ?=
 =?utf-8?B?clp2ZVZqZlh5NDkvLzhGcW16M0V2RjdxeFZZbWJLMmphUkt3VEtHa3AvOExh?=
 =?utf-8?B?MXd0VGNYL0ZLRGlERkdlNExjQUwrV3FjbEozaXhNenE2dVphRHFKQ0FXTllz?=
 =?utf-8?B?RUhhMHdvSmVoejV1b0NicWtNNXgyYzg4TytsSnEvTWNOMXJpSURyLzN5Vm4w?=
 =?utf-8?B?d1Npb0NReWxhVExqeXduWFlmeW1JOHgwR3ptQU9ORnYySlA2QWpUODJZY1lq?=
 =?utf-8?B?ajhMVTNOQlhNTWFKV1ZVUUI4WXVieFB4bFVrR3BwMXF4TzdpQXdXUzJTeG1Z?=
 =?utf-8?B?Y3NhTXZ2MDIrb2ZCRXpDT25NWitYUmpWaUV0cmo2cjRrMUs2cm93eGhLNS9S?=
 =?utf-8?B?cEJ1ZDRqUm53SGhQeWZrTUd3aklCRjQ2c3dnYWticWRhNXVBc2h4bTlxVFhx?=
 =?utf-8?B?d2h5aERPekJsUjRuciszVndBc0xoVXUrY1RqS3RyYVNTbEFBRGRkeG9RTjIz?=
 =?utf-8?B?NXZPeDRoZVA4UTdaVEhxTnNueUk5QWZFRlFUUU1NekpMN2lpWTRyNTFUdjhK?=
 =?utf-8?B?aGtyWXA5cy9aam1ramRxR0FTcHAzTk9pcDhiQWpGZTh6RkhLN29XQnNKSytN?=
 =?utf-8?B?OXRNMFdtbVdiYjFiT2kwNXd4emNJaGJocVR2SFdCcHpTT1FqbGZiVUJYeFdM?=
 =?utf-8?B?R1NxQUhnRncwbE5jeGcxMnp3Z0ExRFVNNEtVOHFnTFlyOCtXNCs5alYzTnRF?=
 =?utf-8?B?Ty9hK052ampkdzF5TllvaGVWcEVUOFJiRmRpcVFiTUFFTGlmcXdMdWduYjJw?=
 =?utf-8?B?d3BwL1VZTUVvK0crME5HYlhCSUlMTE5rZlc2U1pzRnN5aGZobWYxeUtRL2l0?=
 =?utf-8?B?ZU9QV3NEbFdvSjdya3NjNG9NUE0ya3c1VVlVMkR4RlRzWklyaU1QV2hKWk13?=
 =?utf-8?B?akJGckI1Z1ZOOTgwM28wa1lwbk9CUFdUaTI2RkdlamQra2ovVGZaMCtqVUZi?=
 =?utf-8?B?dDdQRHZBZVpoWFhiZEx6MDN5MGJOUDVmUTd0RnZZQ2lOYytKaE1YbFJpeGJF?=
 =?utf-8?B?SHk3bE9INm1wd3BVcnFGTVVSaWR5cit3bXFrYm4yOGUwZGx2TDZzbFhVUGNG?=
 =?utf-8?B?czJVaHNSblR3L2M4UEUyN01pSWVFR3dtSjFpZitsc3Vob3NhN1Fwd2JBaHN6?=
 =?utf-8?B?MUx3Z09Kb3dFRVhMejNySmJVL2svK2FPNTdmb2crMDRLOFpZS1FvcGtEZnd3?=
 =?utf-8?B?QUhUbGJoYlhOamo3QXlrek80UkxhZmZ1NDFNMWZlS045eVhSRSsxb0NtZllR?=
 =?utf-8?B?VGtmSXpDN3IxTlVyTFhrTGQ0ZG8yalU5a2xsRWNqc0lXV29wSVRRUFlPMnJ4?=
 =?utf-8?B?UC9ZL21CNDJzTEFjZ2pTZ21Za01Od3VoWXJDNzQ2RGd2czVkRGlidC9tVjQy?=
 =?utf-8?B?Qm80YlhibXVBcDJnWkNVZXg1NlN6WHcxNEFHSmRSelUyNFlUUU5mZ3JiM0Ew?=
 =?utf-8?B?cGNvSzFWWCtGazE5Zk4zTlJBc01HUk5sYlhhTVNibWpDRHduZzRDbUxnNGlo?=
 =?utf-8?B?MVl0Vzd1a2RUWjZpQzlHV3Q5Z0ZvNWx0Y3prUG5rZ2F5Y1didTNtSGt1bGRh?=
 =?utf-8?B?Z3dRQUtKbDF6ZWJ3YjdhQlJFT1BwbDNDUVZTTjM5aXZ6aVp6dTNnbDB6N3Q1?=
 =?utf-8?B?ZHFlbjFOMTJtTUZMbEtHNDNZa1VqOXhLOXVYWVpreVpISm9EcGpIK29lOUEv?=
 =?utf-8?B?RjVXVVF6NTRweGU1Q3N2NTVaMFlQOVZoS0Roc2JqS2RPbTNTelorVFVmYy9N?=
 =?utf-8?B?ODh0bVZwUU5xbGx5dHRrYVczOTg5TFR3bTl4WTdDOGErNUpTeHV1Q3R6OUh4?=
 =?utf-8?B?ZTd1d1B4K2VlaTJxQjN4Wlc5K1paV1BmWE4vbFFxRUs0TWxtV3ZKL0hwNzZ0?=
 =?utf-8?B?c1M5Y1hlR1pwQW1VM2x4ZnowZEl2TEZzdFFCbXpxSFhpTDZreS9HY3dzYms3?=
 =?utf-8?B?eUNydWpsNHhVSmV0dmIzY0h2aE1rODArOUZqZ1ZUNThWaEZDVUZCaVFRNnhC?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D978A2E6DD4EAB4CBD8A330161872E8F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5542.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea3a083-d9d1-48de-07eb-08ddbe983fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 03:25:27.1538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAhx16hJ96ke6FSMmUxjIYNjjf9NOyLmDyCWPpDTVRRyLwnucG6Uzw8lkQAdFDyZXqaad+AIJovRnbIduS5PtLF1UxipsfVwfetKGujgj0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6655

T24gRnJpLCAyMDI1LTA2LTI3IGF0IDE2OjIxIC0wNzAwLCBOaGF0IFBoYW0gd3JvdGU6DQo+IA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiANCj4gDQo+IE9uIFN1biwgSnVuIDIyLCAyMDI1IGF0IDEwOjE24oCvUE0gQmFycnkg
U29uZyA8MjFjbmJhb0BnbWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IEhpIE5oYXQsDQo+
ID4gDQo+ID4gT24gV2VkLCBKdW4gMTgsIDIwMjUgYXQgMjoyMeKAr0FNIE5oYXQgUGhhbSA8bnBo
YW1jc0BnbWFpbC5jb20+DQo+ID4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IE9uIFN1biwgSnVuIDE1
LCAyMDI1IGF0IDg6NDHigK9QTSBCYXJyeSBTb25nIDwyMWNuYmFvQGdtYWlsLmNvbT4NCj4gPiA+
IHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGF0IHNlZW1zIHVubmVjZXNzYXJ5
LiBUaGVyZSBpcyBhbiBleGlzdGluZyBtZXRob2QgZm9yDQo+ID4gPiA+ID4gPiBhc3luY2hyb25v
dXMNCj4gPiA+ID4gPiA+IHdyaXRlYmFjaywgYW5kIHBhZ2VvdXQoKSBpcyBuYXR1cmFsbHkgZnVs
bHkgc2V0IHVwIHRvDQo+ID4gPiA+ID4gPiBoYW5kbGUgdGhpcy4NCj4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gSU1PIHRoZSBiZXR0ZXIgd2F5IHRvIGRvIHRoaXMgaXMgdG8gbWFrZSB6c3dhcF9z
dG9yZSgpIChhbmQNCj4gPiA+ID4gPiA+IHpyYW1fYmlvX3dyaXRlKCk/KSBhc3luY2hyb25vdXMu
IE1ha2UgdGhvc2UgZnVuY3Rpb25zIHF1ZXVlDQo+ID4gPiA+ID4gPiB0aGUgd29yaw0KPiA+ID4g
PiA+ID4gYW5kIHdha2UgdGhlIGNvbXByZXNzaW9uIGRhZW1vbiwgYW5kIHRoZW4gaGF2ZSB0aGUg
ZGFlbW9uDQo+ID4gPiA+ID4gPiBjYWxsDQo+ID4gPiA+ID4gPiBmb2xpb19lbmRfd3JpdGViYWNr
KCkgLyBiaW9fZW5kaW8oKSB3aGVuIGl0J3MgZG9uZSB3aXRoIGl0Lg0KPiA+ID4gPiANCj4gPiA+
ID4gPiArMS4NCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBCdXQsDQo+ID4gPiA+IEhvdyBj
b3VsZCB0aGlzIGJlIHBvc3NpYmxlIGZvciB6c3dhcD8genN3YXBfc3RvcmUoKSBpcyBvbmx5IGEN
Cj4gPiA+ID4gZnJvbnRlbmQg4oCUDQo+ID4gPiA+IHdlIHN0aWxsIG5lZWQgaXRzIHJldHVybiB2
YWx1ZSB0byBkZXRlcm1pbmUgd2hldGhlcg0KPiA+ID4gPiBfX3N3YXBfd3JpdGVwYWdlKCkNCj4g
PiA+ID4gaXMgcmVxdWlyZWQuIFdhaXRpbmcgZm9yIHRoZSByZXN1bHQgb2YgenN3YXBfc3RvcmUo
KSBpcw0KPiA+ID4gPiBpbmhlcmVudGx5IGENCj4gPiA+ID4gc3luY2hyb25vdXMgc3RlcC4NCj4g
PiA+IA0KPiA+ID4gSG1tLCBJIG1pZ2h0IGJlIG1pc3VuZGVyc3RhbmRpbmcgZWl0aGVyIG9mIHlv
dSwgYnV0IGl0IHNvdW5kcw0KPiA+ID4gbGlrZQ0KPiA+ID4gd2hhdCB5b3UncmUgZGVzY3JpYmlu
ZyBoZXJlIGRvZXMgbm90IGNvbnRyYWRpY3Qgd2hhdCBKb2hhbm5lcyBpcw0KPiA+ID4gcHJvcG9z
aW5nPw0KPiA+IA0KPiA+IEl0IHNlZW1zIGNvbnRyYWRpY3Rvcnk6IEpvaGFubmVzIHByb3Bvc2Vz
IHRoYXQgenN3YXAgY291bGQgYmVoYXZlDQo+ID4gbGlrZSB6UkFNDQo+ID4gYnkgaW52b2tpbmcg
YGZvbGlvX2VuZF93cml0ZWJhY2soKWAgb3IgYGJpb19lbmRpbygpYCwgYnV0IHRoaXMNCj4gPiBk
b2VzbuKAmXQgYWxpZ24NCj4gPiB3aXRoIGFjdHVhbCBiZWhhdmlvciBzaW5jZSB6c3dhcF9zdG9y
ZSBtaWdodCBub3QgZW5kDQo+ID4gYHN3YXBfd3JpdGVvdXQoKWDigJRpdCBtYXkNCj4gPiBzdGls
bCBwcm9jZWVkIHRvIGBfX3N3YXBfd3JpdGViYWNrKClgIHRvIGNvbXBsZXRlIHRoZSBmaW5hbCBz
dGVwcy4NCj4gPiANCj4gPiBNZWFud2hpbGUsIFF1bi13ZWnigJlzIFJGQyBoYXMgYWxyZWFkeSBl
eHBsb3JlZCB1c2luZw0KPiA+IGBmb2xpb19lbmRfd3JpdGViYWNrKClgIGFuZA0KPiA+IGBiaW9f
ZW5kaW8oKWAgYXQgdGhlIGVuZCBvZiBgX19zd2FwX3dyaXRlcGFnZSgpYCBmb3IgelJBTSwgdGhv
dWdoDQo+ID4gdGhhdCBhcHByb2FjaA0KPiA+IGFsc28gaGFzIGl0cyBvd24gaXNzdWVzLg0KPiAN
Cj4gDQo+IEhtbSBPSy4gSSdsbCBsZXQgSm9oYW5uZXMgY29tbWVudCBvbiB0aGlzIHRoZW4gOikN
Cg0KSGkgSm9oYW5uZXMsDQoNCldvdWxkIGFwcHJlY2lhdGUgeW91ciBmZWVkYmFjayB3aGVuIHlv
dSBoYXZlIGEgbW9tZW50Lg0KDQo+IA0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBN
eSBwb2ludCBpcyB0aGF0IGZvbGlvX2VuZF93cml0ZWJhY2soKSBhbmQgYmlvX2VuZGlvKCkgY2Fu
IG9ubHkNCj4gPiA+ID4gYmUNCj4gPiA+ID4gY2FsbGVkIGFmdGVyIHRoZSBlbnRpcmUgenN3YXBf
c3RvcmUoKSDihpIgX19zd2FwX3dyaXRlcGFnZSgpDQo+ID4gPiA+IHNlcXVlbmNlIGlzDQo+ID4g
PiA+IGNvbXBsZXRlZC4gVGhhdOKAmXMgd2h5IGJvdGggYXJlIHBsYWNlZCBpbiB0aGUgbmV3IGtj
b21wcmVzc2VkLg0KPiA+ID4gDQo+ID4gPiBIbW0sIGhvdyBhYm91dDoNCj4gPiA+IA0KPiA+ID4g
MS4gSW5zaWRlIHpzd2FwX3N0b3JlKCksIHdlIGZpcnN0IG9idGFpbiB0aGUgb2JqX2Nncm91cA0K
PiA+ID4gcmVmZXJlbmNlLA0KPiA+ID4gY2hlY2sgY2dyb3VwIGFuZCBwb29sIGxpbWl0LCBhbmQg
Z3JhYiBhIHpzd2FwIHBvb2wgcmVmZXJlbmNlIChpbg0KPiA+ID4gZWZmZWN0LCBkZXRlcm1pbmlu
ZyB0aGUgc2xvdCBhbGxvY2F0b3IgYW5kIGNvbXByZXNzb3IpLg0KPiA+ID4gDQo+ID4gPiAyLiBO
ZXh0LCB3ZSB0cnkgdG8gcXVldWUgdGhlIHdvcmsgdG8ga2NvbXByZXNzZCwgc2F2aW5nIHRoZSBm
b2xpbw0KPiA+ID4gYW5kDQo+ID4gPiB0aGUgenN3YXAgcG9vbCAoYW5kIHdoYXRldmVyIGVsc2Ug
d2UgbmVlZCBmb3IgdGhlIGNvbnRpbnVhdGlvbikuDQo+ID4gPiBJZg0KPiA+ID4gdGhpcyBmYWls
cywgd2UgY2FuIHByb2NlZWQgd2l0aCB0aGUgb2xkIHN5bmNocm9ub3VzIHBhdGguDQo+ID4gPiAN
Cj4gPiA+IDMuIEluIGtjb21wcmVzc2VkIGRhZW1vbiwgd2UgcGVyZm9ybSB0aGUgY29udGludWF0
aW9uIG9mDQo+ID4gPiB6c3dhcF9zdG9yZSgpOiBjb21wcmVzc2lvbiwgc2xvdCBhbGxvY2F0aW9u
LCBzdG9yaW5nLCB6c3dhcCdzIExSVQ0KPiA+ID4gbW9kaWZpY2F0aW9uLCBldGMuIElmIHRoaXMg
ZmFpbHMsIHdlIGNoZWNrIGlmIHRoZSBtZW1fY2dyb3VwDQo+ID4gPiBlbmFibGVzDQo+ID4gPiB3
cml0ZWJhY2suIElmIGl0J3MgZW5hYmxlZCwgd2UgY2FuIGNhbGwgX19zd2FwX3dyaXRlcGFnZSgp
Lg0KPiA+ID4gSWRlYWxseSwNCj4gPiA+IGlmIHdyaXRlYmFjayBpcyBkaXNhYmxlZCwgd2Ugc2hv
dWxkIGFjdGl2YXRlIHRoZSBwYWdlLCBidXQgaXQNCj4gPiA+IG1pZ2h0DQo+ID4gPiBub3QgYmUg
cG9zc2libGUgc2luY2Ugc2hyaW5rX2ZvbGlvX2xpc3QoKSBtaWdodCBhbHJlYWR5IHJlLWFkZA0K
PiA+ID4gdGhlDQo+ID4gPiBwYWdlIHRvIHRoZSBpbmFjdGl2ZSBscnUuIE1heWJlIHNvbWUgbW9k
aWZpY2F0aW9uIG9mIHBhZ2VvdXQoKQ0KPiA+ID4gYW5kDQo+ID4gPiBzaHJpbmtfZm9saW9fbGlz
dCgpIGNhbiBtYWtlIHRoaXMgd29yaywgYnV0IEkgaGF2ZW4ndCB0aG91Z2h0IHRvbw0KPiA+ID4g
ZGVlcGx5IGFib3V0IGl0IDopIElmIGl0J3MgaW1wb3NzaWJsZSwgd2UgY2FuIHBlcmZvcm0gYXN5
bmMNCj4gPiA+IGNvbXByZXNzaW9uIG9ubHkgZm9yIGNncm91cHMgdGhhdCBlbmFibGUgd3JpdGVi
YWNrIGZvciBub3cuIE9uY2UNCj4gPiA+IHdlDQo+ID4gPiBmaXggenN3YXAncyBoYW5kbGluZyBv
ZiBpbmNvbXByZXNzaWJsZSBwYWdlcywgd2UgY2FuIHJldmlzaXQgdGhpcw0KPiA+ID4gZGVjaXNp
b24gKCsgU0opLg0KPiA+ID4gDQo+ID4gPiBUTERSOiBtb3ZlIHRoZSB3b3JrLXF1ZXVlaW5nIHN0
ZXAgZm9yd2FyZCBhIGJpdCwgaW50byB0aGUgbWlkZGxlDQo+ID4gPiBvZg0KPiA+ID4genN3YXBf
c3RvcmUoKS4NCj4gPiA+IA0KPiA+ID4gT25lIGJlbmVmaXQgb2YgdGhpcyBpcyB3ZSBza2lwIHBh
Z2VzIG9mIGNncm91cHMgdGhhdCBkaXNhYmxlDQo+ID4gPiB6c3dhcCwgb3INCj4gPiA+IHdoZW4g
enN3YXAgcG9vbCBpcyBmdWxsLg0KPiA+IA0KPiA+IEkgYXNzdW1lIHlvdSBtZWFudCBzb21ldGhp
bmcgbGlrZSB0aGUgZm9sbG93aW5nOg0KPiA+IA0KPiA+IGJvb2wgdHJ5X3RvX3NjaGVkX2FzeW5j
X3pzd2FwX3N0b3JlKCkNCj4gPiB7DQo+ID4gwqDCoMKgwqDCoMKgwqAgZ2V0X29ial9jZ3JvdXBf
ZnJvbV9mb2xpbygpDQo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKGVycikgZ290byB4eHg7DQo+ID4g
wqDCoMKgwqDCoMKgwqAgenN3YXBfY2hlY2tfbGltaXRzKCk7DQo+ID4gwqDCoMKgwqDCoMKgwqAg
aWYgKGVycikgZ290byB4eHg7DQo+ID4gwqDCoMKgwqDCoMKgwqAgenN3YXBfcG9vbF9jdXJyZW50
X2dldCgpDQo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKGVycikgZ290byB4eHg7DQo+ID4gDQo+ID4g
wqDCoMKgwqDCoMKgwqAgcXVldWVfZm9saW9fdG9fa2NvbXByZXNzZChmb2xpbyk7DQo+IA0KPiBT
b21ldGhpbmcgbGlrZSB0aGlzLCB5ZWFoLiBDYW4gcXVldWVfZm9saW9fdG9fa2NvbXByZXNzZCgp
IGZhaWw/IElmDQo+IHNvLCB3ZSBjYW4gYWxzbyB0cnkgc3luY2hyb25vdXMgY29tcHJlc3Npb24g
b24gZmFpbHVyZSBoZXJlDQo+IChfX3pzd2FwX3N0b3JlKCkgPykuDQo+IA0KPiANCj4gPiDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsNCj4gPiANCj4gPiB4eHg6DQo+ID4gwqDCoMKgwqDCoMKg
wqAgZXJyb3IgaGFuZGxlciB0aGluZ3M7DQo+ID4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNl
Ow0KPiA+IH0NCj4gPiANCj4gPiBJZiB0aGlzIGZ1bmN0aW9uIHJldHVybnMgdHJ1ZSwgaXQgc3Vn
Z2VzdHMgdGhhdCBjb21wcmVzc2lvbg0KPiA+IHJlcXVlc3RzDQo+ID4gaGF2ZSBiZWVuIHF1ZXVl
ZCB0byBrY29tcHJlc3NkLiBGb2xsb3dpbmcgdGhhdCwgaW4ga2NvbXByZXNzZCgpOg0KPiA+IA0K
PiA+IGludCBfX3pzd2FwX3N0b3JlKGZvbGlvKQ0KPiA+IHsNCj4gPiDCoMKgwqDCoMKgwqDCoCBm
b3IoaT0wO2k8bnJfcGFnZXM7aSsrKSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHpzd2FwX3N0b3JlX3BhZ2UoKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKGVycikgcmV0dXJuIGVycjsNCj4gPiDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIDA7DQo+ID4gfQ0KPiA+IA0KPiA+IGtjb21wcmVzc2QoKQ0KPiA+IHsN
Cj4gPiDCoMKgwqDCoMKgwqDCoCB3aGlsZShmb2xpb19xdWV1ZV9pc19ub3RfZW1wdHkpIHsNCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9saW8gPSBkZXF1ZXVlX2ZvbGlvKCk7
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChmb2xpb19xdWV1ZWRfYnlf
enN3YXAoZm9saW8pKSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZighX196c3dhcF9zdG9yZShmb2xpbykpDQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKCh6c3dhcF9zdG9yZV9wYWdlX2ZhaWxzICYmDQo+ID4gbWVt
X2Nncm91cF96c3dhcF93cml0ZWJhY2tfZW5hYmxlZCgpKSB8fA0KPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvbGlvX3F1ZXVlZF9ieV96cmFtKSB7DQo+IA0KPiBJ
ZiAhbWVtX2Nncm91cF96c3dhcF93cml0ZWJhY2tfZW5hYmxlZCgpLCBJIHdvbmRlciBpZiB3ZSBj
YW4gYWN0aXZhdGUNCj4gdGhlIHBhZ2UgaGVyZT8NCj4gDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX3N3YXBfd3JpdGVwYWdlKCk7DQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPiDCoMKgwqDCoMKgwqDCoCB9DQo+ID4g
fQ0KPiA+IA0KPiA+IEluIGtzd2FwZCwgd2Ugd2lsbCBuZWVkIHRvIGRvDQo+ID4gaW50IHN3YXBf
d3JpdGVvdXQoc3RydWN0IGZvbGlvICpmb2xpbywgc3RydWN0IHN3YXBfaW9jYg0KPiA+ICoqc3dh
cF9wbHVnKQ0KPiA+IHsNCj4gPiDCoMKgwqDCoMKgwqDCoCAuLi4NCj4gPiDCoMKgwqDCoMKgwqDC
oCBpZiAodHJ5X3RvX3NjaGVkX2FzeW5jX3pzd2FwX3N0b3JlKGZvbGlvKSkNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiA+IMKgwqDCoMKgwqDCoMKgIGlmIChp
c19zeW5jX2NvbXBfYmxrZGV2KHN3YXApKSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHF1ZXVlX2ZvbGlvX3RvX2tjb21wcmVzc2QoZm9saW8pOw0KPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4gwqDCoMKgwqDCoMKgwqAgfQ0KPiA+IMKg
wqDCoMKgwqDCoMKgIF9fc3dhcF93cml0ZXBhZ2UoKTsNCj4gPiB9DQo+ID4gDQo+ID4gVG8gYmUg
aG9uZXN0LCBJJ20gbm90IHN1cmUgaWYgdGhlcmUncyBhIGZsYWcgdGhhdCBpbmRpY2F0ZXMgd2hl
dGhlcg0KPiA+IHRoZQ0KPiA+IGZvbGlvIHdhcyBxdWV1ZWQgYnkgenN3YXAgb3IgenJhbS4gSWYg
bm90LCB3ZSBtYXkgbmVlZCB0byBhZGQgYQ0KPiA+IG1lbWJlcg0KPiANCj4gSSBkb24ndCB0aGlu
ayB0aGVyZSBpcy4NCj4gDQo+ID4gYXNzb2NpYXRlZCB3aXRoIGZvbGlvIHBvaW50ZXJzIGluIHRo
ZSBxdWV1ZSBiZXR3ZWVuIGtzd2FwZCBhbmQNCj4gPiBrY29tcHJlc3NkLA0KPiA+IHNpbmNlIHdl
IG5lZWQgdG8gaWRlbnRpZnkgenN3YXAgY2FzZXMuIE1heWJlIHdlIGNhbiByZXVzZSBiaXQgMCBv
Zg0KPiA+IHRoZQ0KPiA+IGZvbGlvIHBvaW50ZXI/DQo+ID4gDQo+ID4gV2hhdCBJIG1lYW4gaXM6
IHdoaWxlIHF1ZXVpbmcsIGlmIHRoZSBmb2xpbyBpcyBxdWV1ZWQgYnkgenN3YXAsIHdlDQo+ID4g
ZG8NCj4gPiBgcG9pbnRlciB8PSBCSVQoMClgLiBUaGVuIGluIGtjb21wcmVzc2QsIHdlIHJlc3Rv
cmUgdGhlIG9yaWdpbmFsDQo+ID4gZm9saW8NCj4gPiB3aXRoIGBmb2xpbyA9IHBvaW50ZXIgJiB+
QklUKDApYC4gSXQncyBhIGJpdCB1Z2x5LCBidXQgSeKAmW0gbm90IHN1cmUNCj4gPiB0aGVyZeKA
mXMgYSBiZXR0ZXIgYXBwcm9hY2guDQo+IA0KPiBJIHRoaW5rIHRoaXMgYXBwcm9hY2ggaXMgZmlu
ZS4NCj4gDQo+IFdlIGNhbiBhbHNvIGhhY2sgc3RydWN0IHpzd2FwX2VudHJ5LCBidXQgdGhhdCB3
b3VsZCByZXF1aXJlIGFuIGV4dHJhDQo+IHhhcnJheSBsb29rIHVwLiBPVE9ILCBpZiB3ZSBjYW4g
YXNzdW1lIHRoYXQgenJhbSB1c2VycyB3aWxsIG5vdA0KPiBlbmFibGUNCj4genN3YXAsIHdlIG1p
Z2h0IG9wdGltaXplIHRoYXQgbG9va3VwIGF3YXk/IE5vdCBzdXJlIGlmIGl0J3MgbXVjaA0KPiBj
bGVhbmVyIHRoYW4ganVzdCBwb2ludGVyIHRhZ2dpbmcgdGhvdWdoLg0KPiANCj4gPiANCj4gPiBU
aGFua3MNCj4gPiBCYXJyeQ0KDQpCZXN0IHJlZ2FyZHMsDQpRdW4tV2VpDQoNCg==

