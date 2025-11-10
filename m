Return-Path: <linux-kernel+bounces-892297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE11C44CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9733F3B01C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF12F23C4F3;
	Mon, 10 Nov 2025 02:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sm3UuoGJ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dpQi39oj"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D961A9FB0;
	Mon, 10 Nov 2025 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762742856; cv=fail; b=pLLWY0neAhha1rg8Xg4L6HJpEWxiThRyWzud37J5CIF+7fXW8nMsIn3F6mxjy3lWml3DjSw6sDh5Xl/1BzsCiwwDsynRuynYTwb2s1DaJ3tbY43t4VtniXk0nNVfvrbZTcl33+agoYzBqmNSrZm+/kBxwme4NoORjoXauN0YC9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762742856; c=relaxed/simple;
	bh=RZzUJ4d2BaquRmX03zTESShb5hfTAq4/W7g85LaB/e0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LbMOFgPn5C6GyeDBpJux3IJsG6W5RHk6OTbb1G0Ro/Hsunmzoz6t/ehKpmwwEk3Mb7wXDiZmFio2f6SqO3sPILDLYHqjS3azqQ2/bz6EzI9oKViED0PFbdFjrMV9D7dnY4Z38wbCpfFxg7O3pIfH1rDmYPkohjezUsr+LO6ueDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sm3UuoGJ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dpQi39oj; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7ce46768bddd11f0b33aeb1e7f16c2b6-20251110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RZzUJ4d2BaquRmX03zTESShb5hfTAq4/W7g85LaB/e0=;
	b=sm3UuoGJsODXnhMGnuh5kzlfS+yyVQwW6lRBHI8dBWyvCkWsvJ8EMHZoxzvg3DEGMx822lHeZ/vreHi/dKYsQIoWrCgZson94C67dO0o1JNTqlydV36akpseT+3WNbpBnnw8uqpDY66l1ZbNU0F5FMe0XX455RXuPsETWUx+TI0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3d30b329-a436-4e79-9bbe-e9ad72e23f01,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:f12f167d-f9d7-466d-a1f7-15b5fcad2ce6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7ce46768bddd11f0b33aeb1e7f16c2b6-20251110
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <kyrie.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 565372300; Mon, 10 Nov 2025 10:32:22 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 10 Nov 2025 10:32:21 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 10 Nov 2025 10:32:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIoWqge+CwlzepdOOWxYCb0HgP/SLkpMRpxb+XmEZzFMfqDGSjVMIR3rvoMQNW4Z8b1xbQkEl9GSORVP1IDngFCR9u+tW2zayrOUwLaumARyt01/ljtY0oEQoLHm28Sn+x4pPwoni5+iqz1nabo7oGFKhvrCVtG+KgiH001FiYAhrvlCZC+J8aAiByqu7Ub3wQiJ28Y7i5sOwMue4D4y77gD52mGO7TNnqUCo7hLJtLR5UzwY6yhDtUW+qDLXjYhFYzUvz8pCyKHrD3HKSRmzS3tuwQu8vSX3G7GgCBEHBrx26vXfcUh8Fms3ldktkmANM1lqBOI02Vvfc6iiMubPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZzUJ4d2BaquRmX03zTESShb5hfTAq4/W7g85LaB/e0=;
 b=sETT67ZefPovyljDsU5kj2Pqa0KxVXpdAfaXG2CFmv+I1thVv7CPNhowQMvYXxa5GLREswX6fhbb27Lz1dnRrphx/5C+frHmFmdEUiG6VIFQKXUAJNtzROuDlNYR3hL8ugHmJGo1hXR5xp2lidt158aR4fDuTSxlfszGKZZ+RpU2cQXOctJ4M9WcptmIHyLLBgZ/7X6MHD45QGqABqbscrsezx3p7aZureGVTnRH4QUgmj8qVv1Vt4sTvEXKYC7FmW6CU55kOvMUAGbvGBzemX6b4gudpXyVCjGdzRLLrJHw8O5TMZBTdHsuMionYkv9aUqoUFqEhfbqhWpcMDdS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZzUJ4d2BaquRmX03zTESShb5hfTAq4/W7g85LaB/e0=;
 b=dpQi39oj5zqfLrrSzMfiYDTOuSmiYbXm4q2EPvqbJcM9rcuC+u5G8PV9XmzG6IBpjL0yslJMxbk1wW5OIX0JTYABOUMhL55vlDdwwE1uwgbwmhkA80iaPBHyACjAi8F2DOTpQgHFAo5vhbnBmU2WhAdavXM6LxLulXG+eQj2vEI=
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com (2603:1096:301:b9::5)
 by SEYPR03MB9503.apcprd03.prod.outlook.com (2603:1096:101:2d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 02:32:15 +0000
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::a013:f3b3:a461:8ece]) by PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::a013:f3b3:a461:8ece%4]) with mapi id 15.20.9298.012; Mon, 10 Nov 2025
 02:32:15 +0000
From: =?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?R2VvcmdlIFN1biAo5a2Z5p6XKQ==?= <George.Sun@mediatek.com>,
	=?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= <tiffany.lin@mediatek.com>,
	"nhebert@chromium.org" <nhebert@chromium.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
	"hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
	=?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>,
	=?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= <Yunfei.Dong@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
	"robh@kernel.org" <robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?WWlsb25nIFpob3UgKOWRqOaYk+m+mSk=?= <Yilong.Zhou@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	=?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?=
	<Andrew-CT.Chen@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "andrzejtp2010@gmail.com" <andrzejtp2010@gmail.com>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 0/8] Enable video decoder & encoder for MT8189
Thread-Topic: [PATCH v5 0/8] Enable video decoder & encoder for MT8189
Thread-Index: AQHcTuR6XWfoGtR1akKwtxmAbZGRRLTlso0AgAWEHAA=
Date: Mon, 10 Nov 2025 02:32:15 +0000
Message-ID: <09eb315e50aeaf865b093880aaaa5f2c9c0feba9.camel@mediatek.com>
References: <20251106061323.2193-1-kyrie.wu@mediatek.com>
	 <c49b979fd911f2587bbfed129b07065f1cd2a2db.camel@collabora.com>
In-Reply-To: <c49b979fd911f2587bbfed129b07065f1cd2a2db.camel@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB6186:EE_|SEYPR03MB9503:EE_
x-ms-office365-filtering-correlation-id: 2ceedf6d-22f1-4782-56cb-08de20015c85
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?YndOTWVUWU9BcENzUlN5dkxPU3RLSDk5Z0hVVmNXcTZGZ2xWZ2FVVGJoT24v?=
 =?utf-8?B?alBLNFdOL1d6MDJxay9YRSs1eitLMmcxemlVTERzYTVjeTVDcG9mYnJydDFo?=
 =?utf-8?B?WllMSmtWNXBGYllLWk4xRmJiOG94bzdRM0hUTVJIcVlBOWZhUVZpb2E2aHlF?=
 =?utf-8?B?ZEc3ckZmY213S1J5SENlcW9zTTQvSFd6WkVneUxGRHJKNWZVUGI4b0F2TXBh?=
 =?utf-8?B?bEIrdnpBZFJtRU9raFE4bjZrZm9jbDBXTjVBcy9VT1BWb2JJVzBVRVJxejJo?=
 =?utf-8?B?YmFUejV3cEJ5cmpLck1XRTZaOER6d21pNDJnK2tGd042RzJMNlJUS2NBQ0Rq?=
 =?utf-8?B?ZmptRFF1cUY1Z2dVWnpZVkgvcHd0cGgzdlJjdTVBQ1lVOU1LV0lEVWxySk5o?=
 =?utf-8?B?eWoyUnJaR20wWWJqemE3ZFJRRGowcDRvTWNPVXA5cVhnYWxBbTV2c3ZjUWp4?=
 =?utf-8?B?NC9KQXZGNlptd3B6eFZoNFo1cE8rWWdwZVRTZXlsS0kxcUwvNGlJMllWTHRq?=
 =?utf-8?B?eVhFMy9TUFJ4RTJWRWxmaC9DM1g2TDBTOHZmdHhJRWtyS3pOYWhJc1p0TTBi?=
 =?utf-8?B?ZEV6TVBsOEpFYm1UMTk0NjZma0Z3VVhqdWxzMFVzeWtSa1FZU1Y1NVFyeGxU?=
 =?utf-8?B?NEZHYVpORUw0d0FSQU5taHNScVcwTnhlZjVLVGhzdFlKVlVrMDFPK0M4OHla?=
 =?utf-8?B?NWttZ1BFQktqYjI0QlRQUGx2NkR4ekxXSjlDVFdiU1lkSnA1MkFzUDdLVjND?=
 =?utf-8?B?Z1h5R3lWaUt2dlExS0E0YkcrTzRrYlBsNVo1WFRlTnQ0S3E1RzdKbk9EVEJ3?=
 =?utf-8?B?MzQxQ0thMlhhUXdzUDJURFVsWGZaWFBBUHZ0ZHZ1b0gzdnV3Qkx0QnVaMXBi?=
 =?utf-8?B?WlZFMW5maGJyTlBTY0YvSVpKZTB1dFNsU2crV3BpOWhKZE1DMHU2RzhUMTg2?=
 =?utf-8?B?M3UwSVVoRmIxSytuTy9hejBkOGg2c290Wi94U2xxMEJ0U0NDMllQcU5FYkJF?=
 =?utf-8?B?ZE1mamxYSkdXNDhHeElLclN0Zm9YaEYxUFBuQ25nSHMzdmhxSUFiaStXaXlF?=
 =?utf-8?B?OUVYRnNMREVXY1JFSEZsZXhEcHJrbHVkTjFVSEJ4QWNvd3RzOVBuUGVFdThC?=
 =?utf-8?B?UnVVT2JVTXJCWDByenlqL25SUVR6VnNCNEh6QUxRVGFaTGNEQlhUSGR4a0ln?=
 =?utf-8?B?NnN1UW5Nb0RCVGw5OXV0a1FybmFWZ21YLzNEam1JOXZGcCt2eFdDSWVNTkEz?=
 =?utf-8?B?M1E0RXVVNWdkSDZTWEFsQlM0MitCUGZyZjZZMFlKaVd6ZDd4MnlSREF0RzlW?=
 =?utf-8?B?MUlmZldKM2luYnN6L0Z2T3NmK2FPMG5ESnM5T1pDUVM5T0RXVXFtUWJ5NFdk?=
 =?utf-8?B?Y0pOVmNPKzcwYVJDUExEbldaNjcrRUc5TGg0bkR2b1MvTEhYZUNaTzJ0STlS?=
 =?utf-8?B?V2E4OXFmektHblBvY2xBb0J1Q2w2cGFkMzV5SHhYdzducHFqNGlTYTk4c1pF?=
 =?utf-8?B?cUxGRTNGeU1WM2dtcmtxQUYvaitVbEdZWSt2WVM1K3hoTDhPTy94RE9BMVFU?=
 =?utf-8?B?eUlCUVcxeWVCTEl3TXI2MjR0TUJ3UlNwWTlMMnBTZFpzdE0vZ25xc3FSWVBM?=
 =?utf-8?B?SFdQUmRQVnF5YTZQMUM3blpPa1ZkZXA0TUZzUW9xYm5DWWJCV3JEMlh1Rjhy?=
 =?utf-8?B?bWVxbEtQQkxVRThXTFhWSEV4T0tBSnoyaUpiaEg5aHNERVRPa2k2UHF1MGgx?=
 =?utf-8?B?THZxNFhMb0tnNXpoQlFWNytnTjNJL1l2Um1oZk9IRTU3di9vRFNHUStsMWMy?=
 =?utf-8?B?blF4aDE3UUEydHBIWDdmYldoR0dzcDhMVW1kWURUejZsNUZqcDNLZTE0dWIz?=
 =?utf-8?B?VCtWamF2bmovdDJMbEFGT1ViSENxaDR1dDdCMCtrR3RibktwMysybzljb1p1?=
 =?utf-8?B?OVB5M3NFZ1J1cW04Yy9HdHNTN2Jsb2RMOFpZTlo3WVB4SEJtMUU2WkczZnZJ?=
 =?utf-8?Q?cPauBgPr7q6Rzhi3EvIlLe9c9mH20c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6186.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXJPcnR3R3ZKSThHZVQzV2M4aC9oV1J4cVIwd21VOVdzWk5yS3lvcWwyem5T?=
 =?utf-8?B?Y3NOcE1wazF1b0dqOHZRM0hET3YwV3hmNjIrMXdsOWhOL2FIVVBZUXVYWm1O?=
 =?utf-8?B?bW5KMDE1d0RhVGRZLzZXdHNqOXB3b0VwU0lkbzRoV3N4VTltT092aWtpelRa?=
 =?utf-8?B?ZVFVclJTeVpvd3pQWmh1NWpTY1lSRjRNeTRNUzBDUkVQcDh5VHhWY2dsWE5G?=
 =?utf-8?B?T0QyL1lJTVl3TGVZLzNmWTZ2dEtHVTNWeXQ5bEdhdG5nSzNrSkdYelJjemRE?=
 =?utf-8?B?ZE9JUm9lRENlaEVkVnlGSWVYTU9ENjVmbUcyWHByUlFVR1RLbGRVWWZzZ3dM?=
 =?utf-8?B?UXFXOSsxZ3FleitWZ1RwMHNBRy9JTjFWdVhMY0tydnZpK0FCK3Q0VjYxRTla?=
 =?utf-8?B?Y2MyNWh2eXVVRlJWOVpBbkFqaEFpQm5DSU9OUzhOVnJSZEp0SWxvUEJmZjll?=
 =?utf-8?B?cEpaZHFLUE51Z1UzWC93UkpvSnV5QzE3ZFVBckM4UlJ0VGNMbFUzVGVpejVh?=
 =?utf-8?B?WkJyU2FWZVpFQTFkUU1lNnFSZFpyeEtJcGdtYzNvTlBMTEFXU3FJdjAxNTdL?=
 =?utf-8?B?c3dXU1FXOStwTGFpTlUxRDZheXVLaEdCVUgzTjBOZ01DajdMT0ZaTnZuNHRM?=
 =?utf-8?B?TG9PQnV4aE9zTHA1SUpYcGZwcG1UdFJSd2ZiRDZHNkZubjZiY3BqZzV6bHg0?=
 =?utf-8?B?MkJBa3ArYjdqTnE5ODNjRGtUTjd4bXAvNGJFSWpmaVdzcnhVeEtKS2dVQ2NN?=
 =?utf-8?B?TFA0OEZBaWhKaHBzaTNKbkNyd1NYTjBWUHk1ZXBMSEY5MDJvSmVqRy95ckky?=
 =?utf-8?B?T21lTVBhbWdoM0xtM2pid1BCSXhXVHBQUEZqYmZ6N0h1a1BZRkFrRXZYVDMy?=
 =?utf-8?B?eTlOam1xNng2UDlEQllZY1VnYzdIZS9sU1pMelI2SUtDU2pwUlJUNHNXNi9M?=
 =?utf-8?B?QmVhbU9ray9uSnp2UURMdDZXdWQrbDhlUENRbG5hNm5SaGlxRzFmYzVwVTRK?=
 =?utf-8?B?WFNCY0pqUjFkYmJXVk40eXRNT0JwZk8vZTJrdWVpVUNMZkNNUlZIajRrWkM2?=
 =?utf-8?B?T3MvWHk5S0ZEcFNVNzlUb083Yzd6eDJUMTVrYlJPd0RWUk0xQkpKd2Y3UzNa?=
 =?utf-8?B?eHZKSnE0dlJkM2tNR3BCUTVwZWhZZDJYTk5kdWxKQVgwaW5PUVBjQXRidmRM?=
 =?utf-8?B?UGgyWUZnWkpzbjhvUkFQMjF1MjBKc3FnYXF1L2RlVVZlN05wcDRZeEh5Y1Nx?=
 =?utf-8?B?MlFqa3BKNWJySDZYRmIzd1pjMjcvaGlDeHlXZUszSGtsVlNoZ201QndZenFJ?=
 =?utf-8?B?MVpRd09JUHJ6V1pvV1FtNlZQcGhPWWU5c3Q1TCttMjlFMFVXQXd0VEoyL2g4?=
 =?utf-8?B?MS9oTC9NL1hkbW1PM1hOOGpQWHhFVk9xK0JuRUlIcStzQ3RSdHdCbnoyd0hU?=
 =?utf-8?B?RHZReGdiYms2bHMvbmhCVVcvTVE4eDdOV0crMUhHTzcxL0dRbmcyNncwVHlI?=
 =?utf-8?B?bDBkeDBYRzkxMjdBODlpcFFHK2REcFVqMmVtL3g2cmsxV2hBd3hKblRtTTcv?=
 =?utf-8?B?Nm5oWWEvbkYzWm92S25VSTNCUDlNSmIrWFBGMktOdVd3WW1uc3VTeFhpenZx?=
 =?utf-8?B?aWlkUVZRckh5MWFGY1o2aGM2ZEpWODdwOUlzQWU2WWthZ3l6Wjh5Qy9ydGFK?=
 =?utf-8?B?T0dDUzQweGV5Mkl5T2xKa1dJZjlFRGR5ZndHaU4wVUpONUc5b3VIekx4Z2Zq?=
 =?utf-8?B?cndpTkYrNEI4OGpxNW5yQnZyMXlLUWdyTW5BNlVUU3lPQmljbW9oR3BXVTlh?=
 =?utf-8?B?ZE9pZU1vbUJwMlFaSmFQUFdnZ1BnTWxVL2JKN09VRS82UjNOaHhLNWhNWXl0?=
 =?utf-8?B?MkdQTkl5T3BOT08wc2Z6YjY5V08zclNxTkpacUZMUUN6TGVyUk1XblNudmF2?=
 =?utf-8?B?RGhENnJIbDZYTzRSYmdRYm9RTjk0c0gvQ2xqK0xtYTVqM29oNndiVi9GaDBY?=
 =?utf-8?B?V2JCNjdMdnFOS1ZSQVBrZHhmNlRMeFI3dmlWeVFWN1lQZFczQlNLb1ZISW52?=
 =?utf-8?B?dmVBeEV0b1FZZEx4WlBCRXpDN0tjQ3lvVWRYS2x0ZC9HQ1huK3NORUlqUjZR?=
 =?utf-8?Q?Tog3ttIQzz/QO+6xdZdLXGvKg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <016FCB22D0EE714EB87C8868B92B94D6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6186.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceedf6d-22f1-4782-56cb-08de20015c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 02:32:15.2312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 191Y4X8EuQosjxL9R/yD4iVhuUa+PIKizqO4mazY6eMZG/UxWR2yel7UJbvL0ismwfPsWx92Bp7ghRQeCwndvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB9503

T24gVGh1LCAyMDI1LTExLTA2IGF0IDA5OjE4IC0wNTAwLCBOaWNvbGFzIER1ZnJlc25lIHdyb3Rl
Og0KPiBIaSwNCj4gDQo+IExlIGpldWRpIDA2IG5vdmVtYnJlIDIwMjUgw6AgMTQ6MTMgKzA4MDAs
IEt5cmllIFd1IGEgw6ljcml0IDoNCj4gPiBUaGlzIHNlcmllcyBoYXZlIHRoZSBmb2xsb3cgY2hh
bmdpbmc6DQo+ID4gRmlyc3RseSBhZGQgbXQ4MTg5IHZpZGVvIGRlY29kZXIgY29tcGF0aWJsZSwg
cHJvZmlsZSBhbmQgbGV2ZWwgdG8NCj4gPiBzdXBwb3J0DQo+ID4gTVQ4MTg5IGtlcm5lbCBkcml2
ZXIuDQo+ID4gU2Vjb25kbHkgZml4IHNvbWUgYnVncywgaW5jbHVkaW5nIHZwIDRLIHByb2ZpbGUy
IGFuZCBtZWRpYSBkZXZpY2UNCj4gPiBub2RlDQo+ID4gbnVtYmVyIGJ1Zy4NCj4gPiBMYXN0bHks
IGFkZCBtdDgxODkgdmlkZW8gZW5jb2RlciBjb21wYXRpYmxlLg0KPiA+IA0KPiA+IFRoaXMgc2Vy
aWVzIGhhcyBiZWVuIHRlc3RlZCB3aXRoIE1UODE4OSB0YXN0IHRlc3QuDQo+ID4gRW5jb2Rpbmcg
YW5kIGRlY29kaW5nIHdvcmtlZCBmb3IgdGhpcyBjaGlwLg0KPiA+IA0KPiA+IFBhdGNoZXMgMS0y
IEFkZCBkZWNvZGVyIGNvbXBhdGlibGUuDQo+ID4gUGF0Y2hlcyAzIEFkZCBwcm9maWxlIGFuZCBs
ZXZlbCBzdXBwb3J0aW5nLg0KPiA+IFBhdGNoZXMgNCBBZGQgY29yZS1vbmx5IFZQOSBkZWNvZGlu
ZyBzdXBwb3J0aW5nLg0KPiA+IFBhdGNoZXMgNS02IGZpeCBzb21lIGJ1Z3MuDQo+ID4gUGF0Y2hl
cyA3LTggQWRkcyBlbmNvZGVyIGNvbXBhdGlibGUuDQo+ID4gDQo+ID4gLS0tDQo+ID4gSDI2NCB0
ZXN0IHJlc3VsdHM6DQo+ID4gLi9mbHVzdGVyLnB5IHJ1biAtZCBHU3RyZWFtZXItSC4yNjQtVjRM
MlNMLUdzdDEuMCAtajIgLXQgOTANCj4gPiAgICAgSlZULUFWQ19WMQlSYW4gOTYvMTM1IHRlc3Rz
IHN1Y2Nlc3NmdWxseQ0KPiA+IA0KPiA+IFZQOSB0ZXN0IHJlc3VsdHM6DQo+ID4gLi9mbHVzdGVy
LnB5IHJ1biAtZCBHU3RyZWFtZXItVlA5LVY0TDJTTC1Hc3QxLjAgLWoyIC10IDkwDQo+ID4gCVZQ
OS1URVNULVZFQ1RPUlMJUmFuIDI3Ni8zMDUgdGVzdHMgc3VjY2Vzc2Z1bGx5DQo+ID4gDQo+ID4g
djRsMi1jb21wbGlhbmNlIHRlc3QgcmVzdWx0czoNCj4gPiBDb21wbGlhbmNlIHRlc3QgZm9yIG10
ay12Y29kZWMtZW5jIGRldmljZSAvZGV2L3ZpZGVvMjoNCj4gPiBUb3RhbCBmb3IgbXRrLXZjb2Rl
Yy1lbmMgZGV2aWNlIC9kZXYvdmlkZW8yOiA0NywgU3VjY2VlZGVkOiA0NiwNCj4gPiBGYWlsZWQ6
IDEsIFdhcm5pbmdzOiAwDQo+IA0KPiBUaGVyZSBpcyBvbmUgZmFpbCwgY2FuIHlvdSBleHBsYWlu
IGl0ID8NCj4gDQo+IE5pY29sYXMNCg0KRGVhciBOaWNvbGFzLA0KDQpUaGUgZmFpbHVyZSBpcyBj
YXVzZWQgYnkgc3Vic2NyaWJlZCBldmVudC9kcWV2ZW50LiBPdXIgZW5jb2RlciBkcml2ZXINCmRp
ZG4ndCByZWdpc3RlciB0aG9zZSBhcGlzLCB3aGljaCBjYXVzZWQgdGhpcyBmYWlsdXJlLg0KSGVy
ZSBpcyB0aGUgZmFpbCBsb2csIHdoaWNoIGlzIHNhbWVkIGFzIE1UODE5NjoNCg0KaHR0cHM6Ly9w
YXRjaHdvcmsubGludXh0di5vcmcvcHJvamVjdC9saW51eC1tZWRpYS9jb3Zlci8yMDI1MDUyODA2
MzYzMy4xNDA1NC0xLWlydWkud2FuZ0BtZWRpYXRlay5jb20vDQoNCkNvbnRyb2wgaW9jdGxzOg0K
ICAgICAgICB0ZXN0IFZJRElPQ19RVUVSWV9FWFRfQ1RSTC9RVUVSWU1FTlU6IE9LDQogICAgICAg
IHRlc3QgVklESU9DX1FVRVJZQ1RSTDogT0sNCiAgICAgICAgdGVzdCBWSURJT0NfRy9TX0NUUkw6
IE9LDQogICAgICAgIHRlc3QgVklESU9DX0cvUy9UUllfRVhUX0NUUkxTOiBPSw0KICAgICAgICAg
ICAgICAgIGZhaWw6IHY0bDItdGVzdC1jb250cm9scy5jcHAoMTE3MSk6IG5vZGUtPmNvZGVjX21h
c2sgJg0KU1RBVEVGVUxfRU5DT0RFUg0KICAgICAgICB0ZXN0IFZJRElPQ18oVU4pU1VCU0NSSUJF
X0VWRU5UL0RRRVZFTlQ6IEZBSUwNCiAgICAgICAgdGVzdCBWSURJT0NfRy9TX0pQRUdDT01QOiBP
SyAoTm90IFN1cHBvcnRlZCkNCiAgICAgICAgU3RhbmRhcmQgQ29udHJvbHM6IDE2IFByaXZhdGUg
Q29udHJvbHM6IDANCg0KVGhhbmtzLg0KDQpSZWdhcmRzLA0KS3lyaWUuDQoNCj4gDQo+ID4gQ29t
cGxpYW5jZSB0ZXN0IGZvciBtdGstdmNvZGVjLWRlYyBkZXZpY2UgL2Rldi92aWRlbzM6DQo+ID4g
VG90YWwgZm9yIG10ay12Y29kZWMtZGVjIGRldmljZSAvZGV2L3ZpZGVvMzogNDgsIFN1Y2NlZWRl
ZDogNDgsDQo+ID4gRmFpbGVkOiAwLCBXYXJuaW5nczogMA0KPiA+IA0KPiA+IHNjcCB1cHN0cmVh
bSBsaW5rOg0KPiA+IA0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4
LW1lZGlhdGVrL3BhdGNoLzIwMjUwODExMDE1OTIyLjMyNjgwLTEtaHVheXUuem9uZ0BtZWRpYXRl
ay5jb20vDQo+ID4gZHRzaSB1cHN0cmVhbSBsaW5rOg0KPiA+IA0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtbWVkaWF0ZWsvMjAyNTEwMzAxMzQ1NDEuNzg0MDExLTEyLWpoLmhzdUBtZWRp
YXRlay5jb20vVC8jbTg0N2UzNWRlMGE1YjE4ZmFjMGNhMDYyNGE4NTU5ZDg0OTY0YWQ1YzcNCj4g
PiANCj4gPiBDaGFuZ2VzIGNvbXBhcmVkIHdpdGggdjQ6DQo+ID4gLS11cGRhdGUgSDI2NCAmIHZw
OSBmbHVzdGVyIHRlc3QgcmVzdWx0cw0KPiA+IC0tdXBkYXRlIHZwOSBzaW5nbGUgY29yZSBkZWNv
ZGVyIHByb2Igc2l6ZSBzZXR0aW5nIGFuZCBjb21taXQNCj4gPiBtZXNzYWdlcw0KPiA+IA0KPiA+
IENoYW5nZXMgY29tcGFyZWQgd2l0aCB2MzoNCj4gPiAtLWFkZCByZXZpZXdlciB0byBjb21taXQg
bWVzc2FnZXMNCj4gPiAtLVJlYmFzZWQgb24gdG9wIG9mIHRoZSBsYXRlc3QgbWVkaWEgdHJlZQ0K
PiA+IA0KPiA+IENoYW5nZXMgY29tcGFyZWQgd2l0aCB2MjoNCj4gPiAtLWFkZCBIMjY0IGZsdXN0
ZXIgdGVzdCByZXN1bHRzDQo+ID4gLS1yZW9yZGVyIGNvbXBhdGlibGUgc3RyaW5nIGZvciBkdC1i
aW5kaW5ncw0KPiA+IA0KPiA+IENoYW5nZXMgY29tcGFyZWQgd2l0aCB2MToNCj4gPiAtLWFkZCB2
NGwyLWNvbXBsaWFuY2UgdGVzdCByZXN1bHRzDQo+ID4gLS1hZGQgc2NwIHVwc3RyZWFtIGxpbmsN
Cj4gPiAtLWFkZCBIVyBkaWZmZXJlbmNlIGRpc2NyaXB0aW9ucyBmb3IgZHQtYmluZGluZ3MgY29t
bWl0IG1lc3NhZ2VzDQo+ID4gDQo+ID4gVGhpcyBzZXJpZXMgcGF0Y2hlcyBkZXBlbmRlbnQgb246
DQo+ID4gWzFdDQo+ID4gDQpodHRwczovL3BhdGNod29yay5saW51eHR2Lm9yZy9wcm9qZWN0L2xp
bnV4LW1lZGlhL2NvdmVyLzIwMjUwNTEwMDc1MzU3LjExNzYxLTEteXVuZmVpLmRvbmdAbWVkaWF0
ZWsuY29tLw0KPiA+IFsyXQ0KPiA+IA0KaHR0cHM6Ly9wYXRjaHdvcmsubGludXh0di5vcmcvcHJv
amVjdC9saW51eC1tZWRpYS9jb3Zlci8yMDI1MDgxNDA4NTY0Mi4xNzM0My0xLWt5cmllLnd1QG1l
ZGlhdGVrLmNvbS8NCj4gPiANCj4gPiBLeXJpZSBXdSAoOCk6DQo+ID4gICBkdC1iaW5kaW5nczog
bWVkaWE6IG1lZGlhdGVrOiBkZWNvZGVyOiBBZGQgTVQ4MTg5DQo+ID4gICAgIG1lZGlhdGVrLHZj
b2RlYy1kZWNvZGVyDQo+ID4gICBtZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzogYWRkIGRlY29kZXIg
Y29tcGF0aWJsZSB0byBzdXBwb3J0IE1UODE4OQ0KPiA+ICAgbWVkaWE6IG1lZGlhdGVrOiB2Y29k
ZWM6IGFkZCBwcm9maWxlIGFuZCBsZXZlbCBzdXBwb3J0aW5nIGZvcg0KPiA+IE1UODE4OQ0KPiA+
ICAgbWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IEFkZCBzaW5nbGUgY29yZSBWUDkgZGVjb2Rpbmcg
c3VwcG9ydCBmb3INCj4gPiAgICAgTVQ4MTg5DQo+ID4gICBtZWRpYTogbWVkaWF0ZWs6IHZjb2Rl
YzogZml4IHZwOSA0MDk2eDIxNzYgZmFpbCBmb3IgcHJvZmlsZTINCj4gPiAgIG1lZGlhOiBtZWRp
YXRlazogdmNvZGVjOiBmaXggbWVkaWEgZGV2aWNlIG5vZGUgbnVtYmVyDQo+ID4gICBkdC1iaW5k
aW5nczogbWVkaWE6IEFkZCBNVDgxODkgbWVkaWF0ZWssdmNvZGVjLWVuY29kZXINCj4gPiAgIG1l
ZGlhOiBtZWRpYXRlazogZW5jb2RlcjogQWRkIE1UODE4OSBlbmNvZGVyIGNvbXBhdGlibGUgZGF0
YQ0KPiA+IA0KPiA+ICAuLi4vbWVkaWEvbWVkaWF0ZWssdmNvZGVjLWVuY29kZXIueWFtbCAgICAg
ICAgfCAgMiArDQo+ID4gIC4uLi9tZWRpYS9tZWRpYXRlayx2Y29kZWMtc3ViZGV2LWRlY29kZXIu
eWFtbCB8ICA1ICstDQo+ID4gIC4uLi92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19kcnYu
YyAgICAgICB8ICA5ICsrKy0NCj4gPiAgLi4uL3Zjb2RlYy9kZWNvZGVyL210a192Y29kZWNfZGVj
X2Rydi5oICAgICAgIHwgIDEgKw0KPiA+ICAuLi4vdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19k
ZWNfc3RhdGVsZXNzLmMgfCAgNCArKw0KPiA+ICAuLi4vdmNvZGVjL2RlY29kZXIvdmRlYy92ZGVj
X3ZwOV9yZXFfbGF0X2lmLmMgfCA0OCArKysrKysrKysrKysrKy0NCj4gPiAtLS0tDQo+ID4gIC4u
Li92Y29kZWMvZW5jb2Rlci9tdGtfdmNvZGVjX2VuY19kcnYuYyAgICAgICB8IDE0ICsrKysrKw0K
PiA+ICA3IGZpbGVzIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0K

