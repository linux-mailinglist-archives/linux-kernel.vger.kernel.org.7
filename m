Return-Path: <linux-kernel+bounces-890330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05FC3FD07
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 128304EF83C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4AB2F39C5;
	Fri,  7 Nov 2025 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="J9IgUIMZ"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974192E62B4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516198; cv=fail; b=KBMwrwxvpzZer5Vly+XGl1qbi8pg+5Jr6o1qGcrm+Rfx3Gky7KKkaEWpHcyPmKoyB4mz0/KYbakUZ0JQykY4aCGUsi24ZRSYUvzsCVaI4vv/jSQJhjFN6oTfi1O9wOcDRMv6OQ7BSKp5Ot9s9dXZDXOPffXQCnlV8YGXwg2uqA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516198; c=relaxed/simple;
	bh=1ZDA+4/4vEO80ecFX7o8AbFwZniYNG8m226ZdHALxcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aH26fOs90iM79A3K+dJGTQJDIdxpJOGwCHsRL6Dmwvob2jDrDJd5Zl2kQboMJ57Fq9bPRuMq1S16xvhalGym6sh0f8w/pQzVK/ID1g8co1GiMeelELCSYDYSRl320WHlXfhQlaYZjvT/+g+QlQXym6IYqWT//fIa/AKBzXlb7ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=J9IgUIMZ; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqRmBjdV2k3AAvAMTWb8CE7qUf+YXZJkpoZFwu3on/vK0y0OlaQa3/V/wCScHICtNL/n77qGnnfxpbZ0woGiiumY+hadYNnqY3gCAFb30gZC+Dh2WOLcWObFmaWD5/i4r232G0wdDYmMgFuCHsObVWWdC3xYKihtvWhJwn0i3osOs5Jgmz6TvOPOPqftwB4CmuA7PrJ9yibOVKzs0qPFZtMGJcSNYp85A4vHT9xWXwZM3yfIFoPiJASpXupKXbAH58YO9+uwJCLr0Xki0ymqknj1lac+BbaWYbShgWDYeCsmBQ4TSI8mM6Ie4W3w2tpQNSnSU0m4EWvxdZew4QlFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZDA+4/4vEO80ecFX7o8AbFwZniYNG8m226ZdHALxcQ=;
 b=Hl4i1YTslaWYj6tJtSBi/y4EDau40tmyzM+DmXB2Zef+EaZSTVU9zz5tr1oSEXKsuXDLX/2xvH96asUamljM9EK/HC8e1GVA6HK/at/oNeIDzA2WD5MGgzWFZN9mI/U2D0YbCPAtidBT/g154pBd9FEKsfabP5ugEzOppx2gDL2yqOqT2y4dh+Yb04ZkZ3Y/5WjiF2iqE5yyOqN0wZR5gydpq5f2yJBhXpb3WHyZ++emSFQsqQBs3xvXOqTAYduv6qY01upJ+KwzXl15/tGP2jbBiTksKvI2ii+vmLRYSjWlT0ME9FpZEVf9Zpk8LPhjB8F67EpPsnt/Nh1C0QsN5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZDA+4/4vEO80ecFX7o8AbFwZniYNG8m226ZdHALxcQ=;
 b=J9IgUIMZ3vmhmAhsx5Dt+umvWUr+u03Erc0r+2znpVZ/lRF9noM51kOZbgTqgsAoZfZdomr5P5uWfR7P9EG0xHGzyMseM8ybD0gPh2jBDfpeGD66MlM8RkD9PNJggfLt2PfytE74zHNrILWO67uwgZtoMGDJVGRIBf8A5r5fr0ROWG1b+jHwvryiNiW8kkg2fDVq8Mq754QwYBRY0+utRQfdxVdpDvQ5PyHn434I/oR32LeYSsJvaZLE/lvTP+xP/rNJIqJUmuqmy3xFm1gDvhWvgFYhNfkqm4oEh/EHdkYA5etktEETlIdu5JrQnGFX3CUSNEIWjNz8x+JL6l3vvg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV1PR10MB8755.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 11:49:53 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Fri, 7 Nov 2025
 11:49:53 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>
CC: "hui.wang@canonical.com" <hui.wang@canonical.com>, "mwalle@kernel.org"
	<mwalle@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "florent.trinh-thai@cs-soprasteria.com"
	<florent.trinh-thai@cs-soprasteria.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Topic: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Index: AQHb66DA/2ST5DqqmUGvisuiiSELdrTh5/AAgAICrICAAIdYAIADcAkA
Date: Fri, 7 Nov 2025 11:49:51 +0000
Message-ID: <e0037dc532f3aecb101c78e7d91b66430b15d541.camel@siemens.com>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
		 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
		 <2025110513-manliness-repayment-d005@gregkh>
	 <db80adb8b8006fbdeee77a386feabb81537d27e6.camel@siemens.com>
In-Reply-To: <db80adb8b8006fbdeee77a386feabb81537d27e6.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV1PR10MB8755:EE_
x-ms-office365-filtering-correlation-id: 0ff0616e-7e67-4a57-6321-08de1df3c32b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEpGa25sUVZxa2pUZDVrWHlDQk13VHBXM3pOQjkzSFkrci9XcFpqSnkrSlhN?=
 =?utf-8?B?ZFdwWU92czJSdjVUVFMzWGYvRWhzQVJ2UkYzdjdBSy91UktMNnpiYzlZWlhL?=
 =?utf-8?B?S29wQTlzem9PYTF2dnR5YVd2SlFhUmp6ZmF2am8rUHBZbWl2Tk5UcHZYVjhs?=
 =?utf-8?B?ZkxRYStBK2p0UHhrMFpnKzJNdFVmaFMrTlQxTVZuTlNCeHlndE0wWXVOSnRR?=
 =?utf-8?B?NUx3R3hOeXhBa09VY0dRY2pCNFZsbGZvaDlHR0hZMEtndElxaVo0a1llSmk2?=
 =?utf-8?B?V1p4ZSt1dHlDWXpHRU8wRC80aGkyc2lVSnBDZ214WmEvOFNWdXoxRythN2l0?=
 =?utf-8?B?a3VmL0RwNmZZZG5UQzZ4T3VVa1dtSTB3eXRHb2kwd3YxbkRBREVvRUExL0h4?=
 =?utf-8?B?Z3RkMjBGWkV3OWxWbCtPdXpHR3JWdHVPSXovTVVNWlBpV3UxVDBIaHhNYzR1?=
 =?utf-8?B?WHc4dTAxQlBxbXpMN3Z3a1kxbzJTbjE5UWhKd2poZU82eWlLd1lDbytVWlly?=
 =?utf-8?B?QWtkd0owcDF5NHZUZkJwd3M5OHpZbmhEUjR2SXlXTWl3REhZdFRuRVNqK0Q0?=
 =?utf-8?B?anN2cUhqd09qU0RRN3RGdzh1WlFsbS9yZDM5NXhnczh0amJNOTRDcVNNaXU4?=
 =?utf-8?B?WEl0d3ZDellxdVd5SEJpREJWVFBoNVFpbDAwSkxhcFRjWHFHaGtDdExzcFE0?=
 =?utf-8?B?cUhvM2hyaTVmUExtdCtFcmQrWVFJaGlkMmJsTk1lODBzR1RzU05SRlBXUzVp?=
 =?utf-8?B?RXI1SFoxTkNwYks5S0V3NU93UWQ0bHpHR0JhOHFsWXBRakNVNXBtS0VoMkNs?=
 =?utf-8?B?RUE0c3lLM0hNemdTeklUWHJFK1htN1RiTytoVnJiNEV0NmdXN2x1aW91bm91?=
 =?utf-8?B?WGRsbzMrWUxIRU9xTWpvRGIrSlI2ci9uUE52TE1ReTgyZy9QdUhBc3dMdnF3?=
 =?utf-8?B?Nzdwb2VBRy8xMWZjTlJ6OFRySXJhU1ZUZHFVQ2w4UG45c052eUJRWU52NFRv?=
 =?utf-8?B?MHdMeXMyVjg0N3hJR2ZEVFM5bUU5amhMWkc4eEVtQWdtWHNobkxBajVOWjg2?=
 =?utf-8?B?V1pubjZhclZ4RWd4UXZveW5SRWJSOW5uN1dYeXN2MmkwSE91YlJYakh5SFVk?=
 =?utf-8?B?OVk3WVBjTktRZDdrNklCcjFCTmZJcGN1dUIwVmhXcmwwclowRjM4SVhzUFhh?=
 =?utf-8?B?elVaQVpBc3RydDY0eVpjeHA2L3JxazdPQTQ3SnhYbHNTaFJPV0FLVkdFRFBC?=
 =?utf-8?B?RS9zR0QvcUIxWGZPSklENkFGb3g1OHFQVFl6U20zY0xrUGRtWFZ5MmgyOE1K?=
 =?utf-8?B?c2NlbVJUbG44TmtBTmkzR0Y5b1lJUUF2TzJBUG40U3FaZWFzVlViaHRTTEFF?=
 =?utf-8?B?cGIyRWJleXRSdElLUzJKVnVYZ0ZRbFFjdEJqSk5LOE9hOGNhUkhFNExrL2xy?=
 =?utf-8?B?R0F2cWhNTlRlbHFKSDhuME9aSEVvdGdEL2lIelJrM1FXOXNQTHBnanlqOVRT?=
 =?utf-8?B?cDFnRzdpalVjTitvcmJKTzBlZmxOUTJtaUw0eFR3NlBWS0dleWQrWkJjbmFn?=
 =?utf-8?B?U1pEdnAwWm1sSWRjT3QwZmJjWTI5c0tZM1NwSldTU2FRSDVqL1ZSUW82TGo4?=
 =?utf-8?B?UWFSekJPeWRiM3ZxMjV0dGdXTHErTVRYWnVPZWExMnhsc2prUXB2THRGS3c4?=
 =?utf-8?B?UHdWMy9BaWgzcUhDeFBvMURRWUltQ1p2bjdwNnlXbS9UckZMSjZQd0g1NU9l?=
 =?utf-8?B?RlJrd2tUMGR2ZS9ERUl6ZUxjKzZOU2JHMXBGUFJwOFlTd1J1OXZudVFqU0dF?=
 =?utf-8?B?NUh4Z0tOWndOcUEvc0xaSUpZTlBoTHZtbFVHNlN1dFVZb09laWcyNXRhQmpS?=
 =?utf-8?B?SDZqNW1GN2V4aUV3UkRKTjJ4N3R1V0YrTjJ0MGJWVk9zbVJLdWQvMnpsazI3?=
 =?utf-8?Q?L6/WUYwcX/kk33OlasrliMEd0aZxDty4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXlsVjIxamNiU2JRYk9VNUk3RnhYdXFhaGdvbDc1b2crUWVOSXA5aEpheUpa?=
 =?utf-8?B?QzBPUXArOXI5a0o0bS95bXhsVlZ4ZlhjVFVhZ0swVXozTWI2UEQ4WFBteDc1?=
 =?utf-8?B?RFhVYTdCQzBKZXlISVN5U3l6QmhLMm1FbDNneTRpZVQzVWNiYUFzZGpQNm5o?=
 =?utf-8?B?eGRuajJqRjUvS0FTWXEwZzNEb0pXWU5MUDBHbzVLeDlXZEhkT01tK3pvZ1ky?=
 =?utf-8?B?c0N0YXNYUnRCTnlXcUxta25KbWhCblR4OUZhMXppMXFuWmJoQ1VzWVg1OTNT?=
 =?utf-8?B?Qm9zSU4ybnU0empUT3RPSS9qK1FxMDU1YjBPRmlqN0NFOGJFczRpRWVLNzlZ?=
 =?utf-8?B?TFhlbWd5RFdNRnJIVzdNUnJaNTZ5NlM4SFkvTXZnVGRFQmxQVXpTRW03ZW1J?=
 =?utf-8?B?My9aei96V2Jpell0ZnNIMldXSEUwbG90N0hrNEQ2KzVIUjJZaGhUc25Xd0hY?=
 =?utf-8?B?WUpyUFY2SXF2M0VaVGl3UkZOUFA3U1lkQUJUbkVyUTJmQjZYanZSMC9TL3Z4?=
 =?utf-8?B?RExRVElMTmpDNjEyc1lMZDlkZENyd1UvbmdlSGVySGRGZ1pSS0lWVEw1R0Uw?=
 =?utf-8?B?elFwN0ZxRUxmcXhMbHJpMmdYZFZDMUlNbkJpeXhDLzhMY2c4aVhxb0lic0tX?=
 =?utf-8?B?SzRib1R1Wm9RbHMrRWM5MnlhaHVFU3JaVDNGelRhQisyUVh4ekdCTGNvVHRY?=
 =?utf-8?B?ZVN3dlVNRkNHRUpOdTBaTnZST0VUYmE4TE42aWpRTkpmZHlpSzVldHAxY2pm?=
 =?utf-8?B?eVBDWUpRRjJWVkFzZGIvenY2bEZrU1dlMWVQcWdieWViTkhUTmk5V01xZFp4?=
 =?utf-8?B?LzROOHNoWWU2YWFsWTNsUnBmekh0WXhaelZ4UzNtOVpObkNCa3RFaS9jaGRn?=
 =?utf-8?B?dzFTa2FtZUEySk1zNThWTG9wQ0sxOHcyc0JENlNDaVRYbFNreVhqT08vU0ZH?=
 =?utf-8?B?Z05MZzdLNFd6SUlDSlM4dExhakJadnphbjU0bklMV2wyWFZ0aHBwRnVzRi83?=
 =?utf-8?B?VjJKWGNqVU1LWGR6NFZPVXRUQko3T29DUFA5MTVvMHRabTJKRk5BN1ZPYlhv?=
 =?utf-8?B?T2dlUzNKeWRJcFgrdmdxTDR3ZTR6cy9CQWNtV2Y4MnJuWUdOcEViRTFtSVlZ?=
 =?utf-8?B?UEo4R01WWkZxRzJ1dDZHRTVpWEFvcXoyNFdMOUcwTmNhVXFzdWxoeEJwRzN3?=
 =?utf-8?B?MHpYSGpkcjJSSXIwZTlMcWFpOHNZL2w2Z0ljQnhtK2Z5T09tNkpJMWkxd3hH?=
 =?utf-8?B?cEg1SlJNYUt4aXJEVFVnTklPKzJkZmlJMDRkb2ZPLzlEQUNVNkp1T3d2WHFl?=
 =?utf-8?B?RDMweVVpUE9LZWx2UStsVHR6aVUyemFXY1hUWXBZZlNzRUJaZHJxNkFKNmhx?=
 =?utf-8?B?bFFEMGUrV1dLRFpkdUtWcS83a3BNQU94NUx3OXJ2eHhJVGMvNTdNZ1VIc09t?=
 =?utf-8?B?azJHMUZtalA5U0lyRGxZdmZob3JZWk42a0xUcEJTb01EVmpFOTZEMGtZRkd2?=
 =?utf-8?B?ZmhUeFRnNkZsUUVNSDk4WTkzTVBsUzRFS0NOUjk3S2hPZzhqTitDQWhjTlNG?=
 =?utf-8?B?NytLNVRzcnFKSUtFSHNWeXVXQ2pFbFJ4eXhMbjlXdnhPOFp2ODVOanRobkhV?=
 =?utf-8?B?cXVKS1Y5TjJFS2ZDUmJpUjFsNUFuMituc3diQ2RHZEtxMzlnd3Q0a0FtbUxt?=
 =?utf-8?B?UlkzcHNzR3BxOXdTczdPTTNIdkFwNk5TVFJIdk5jSTErZlppdUJDQ2FRVHVT?=
 =?utf-8?B?azFlT0pKZ3RXbGFwK0ErcG1qUHRHNDI4RklrMWEwKzFUL0NiMlpDWWdlbFhF?=
 =?utf-8?B?cklRaDkveEpob0IwNmpVdi9MQ1cxWXVNaVFrWnYwYXlRNFJPanJVeDFxenFV?=
 =?utf-8?B?MVZYT08remFhSU5TMVhodWtCMjJKajd3cU82MmJoVW1MSWZ2WkYrd0d6dGdY?=
 =?utf-8?B?SVBMSGk3RlE1NzgzblVybzdrOVpLRU9wNnRxQlVCZjJJVXZqU2w5cHU2M3lG?=
 =?utf-8?B?Z1ErZjFuSXFod29lQ2xPSjFGMklzd2ZaeWpzRFVhUEVSSitkWlNVWHRJMisx?=
 =?utf-8?B?b0FLWlAraWo3bmhIRERNVjRSc2ZZeEJjM0NtaTRGN2JzSE9tQ3NKQ21vOGds?=
 =?utf-8?B?S0wwdGtMak9yTWZqbFA4NVQrM0t3dHBCK0lFczNNUmZwdGZiQzg2TUhsb3Fi?=
 =?utf-8?Q?dZVHuxL5UJQ8pmcNiPibmTs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8325A664C81A594F8A1D308DFEA4D90C@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff0616e-7e67-4a57-6321-08de1df3c32b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 11:49:52.1692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nakulCqVta9C210MSoesPmO6AO40zbmvqHKBgLq+w//hSNC9KkdKT20uVVCTstu0y2BWgVFmKrTr1aZbnv7ei8Vetx0PlGgcEvBR670qwV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8755

SGkgR3JlZywgQ2hyaXN0b3BoZSwNCg0KT24gV2VkLCAyMDI1LTExLTA1IGF0IDA4OjIwICswMTAw
LCBBbGV4YW5kZXIgU3ZlcmRsaW4gd3JvdGU6DQo+ID4gPiA+IFJlcGxhY2UgdGhlIFJBVyBTUEkg
YWNjZXNzZXMgd2l0aCBzcGktbWVtIEFQSS4gVGhlIGxhdHRlciB3aWxsIGZhbGwgYmFjayB0bw0K
PiA+ID4gPiBSQVcgU1BJIGFjY2Vzc2VzIGlmIHNwaS1tZW0gY2FsbGJhY2tzIGFyZSBub3QgaW1w
bGVtZW50ZWQgYnkgYSBjb250cm9sbGVyDQo+ID4gPiA+IGRyaXZlci4NCj4gPiA+IA0KPiA+ID4g
V2l0aCB0aGlzIHBhdGNoIChrZXJuZWwgdjYuMTcuMSkgb3VyIHBvd2VycGMgYm9hcmRzIGFyZSB0
b3RhbGx5IHVuc3RhYmxlLCB3ZQ0KPiA+ID4gZ2V0IG11bHRpcGxlIHJhbmRvbSBPb3BzIGR1ZSB0
byBiYWQgbWVtb3J5IGFjY2Vzc2VzLg0KPiA+ID4gDQo+ID4gPiBXaXRoIHRoaXMgY29tbWl0IHJl
dmVydGVkIHRoZSBib2FyZCBpcyBzdGFibGUgYWdhaW4uDQo+ID4gPiANCj4gPiA+IFRoZSBTUEkg
ZHJpdmVyIGlzOg0KPiA+ID4gDQo+ID4gPiBDT05GSUdfU1BJPXkNCj4gPiA+IENPTkZJR19TUElf
TUFTVEVSPXkNCj4gPiA+IENPTkZJR19TUElfTUVNPXkNCj4gPiA+IENPTkZJR19TUElfRlNMX0xJ
Qj15DQo+ID4gPiBDT05GSUdfU1BJX0ZTTF9DUE09eQ0KPiA+ID4gQ09ORklHX1NQSV9GU0xfU1BJ
PXkNCj4gPiA+IA0KPiA+ID4gSG93IGNhbiB3ZSBmdXJ0aGVyIGludmVzdGlnYXRlIHRoZSBpc3N1
ZSA/DQo+ID4gDQo+ID4gV2UgY2FuIHJldmVydCBpdCB1bnRpbCBpdCBjb21lcyBiYWNrIHdvcmtp
bmcgcHJvcGVybHkuwqAgQ2FuIHlvdSBzZW5kIGENCj4gPiByZXZlcnQgc28gdGhhdCBJIGNhbiBh
cHBseSBpdD8NCj4gDQo+IHdoYXQgaXMga25vd24gZm9yIHN1cmUgaXMgdGhhdCBpdCB0cmlnZ2Vy
cyBhIGJ1ZyBpbiBTUElfRlNMX0NQTSBbMV0sDQo+IHdoaWNoIHByb2JhYmx5IGp1c3RpZmllcyBh
IHJldmVydCBpbiAtc3RhYmxlLiBCdXQgdGhlcmUgYXJlIG5vIGluZGljYXRpb25zIHRoZQ0KPiBw
YXRjaCBpbiBxdWVzdGlvbiBtaXNiZWhhdmVzIGl0c2VsZiBhcyBvZiBub3cuIEknbSBnb2luZyB0
byBLQVNBTiBpdCBvbiBhbGwgdGhlDQo+IEhXIEkgY2FuIGdldCBteSBoYW5kcyBvbiB0aGlzIHdl
ZWsuDQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzc2NDg1OGQ1LTU2MzMt
NGFlYi1hYWJlLTUyZjllYjFlYjUzMEBjc2dyb3VwLmV1Lw0KDQpqdXN0IGxldHRpbmcgeW91IGtu
b3cgdGhhdCBJIHN0cmVzcy10ZXN0ZWQgdGhlIGF0MjUgZHJpdmVyIHdpdGggS0FTQU4gb24gdHdv
IEFSTTY0DQpwbGF0Zm9ybXMsIFRJIEFNNjIgYW5kIGkuTVg4UVhQLCBpbiB0aGUgbGF0dGVyIGNh
c2UgaXQncyBldmVuIHNwaS1ueHAtZnNwaSBkcml2ZXINCm9ubHkgcHJvdmlkaW5nIHNwaS1tZW0g
QVBJLCB3aGlsZSB0aGUgVEkgU29DIGdvZXMgb3ZlciBub3JtYWwgU1BJLiBVcCB0byBub3cgaXQN
CndlbnQgc21vb3RobHkuDQoNCkNocmlzdG9waGUsIHdoaWxlIEknbSB0cnlpbmcgdG8gZ2V0IG15
IGhhbmRzIG9uIGEgUFBDMzIgSFcgc2ltaWxhciB0byB5b3Vycywgd291bGQNCnlvdSBiZSBhYmxl
IHRvIHRlc3Qgd2l0aCBDT05GSUdfRE1BX0FQSV9ERUJVRz15PyBUaGUgZmFjdCB0aGUgS0FTQU4g
ZG9lc24ndCBkZXRlY3QNCmFueXRoaW5nIGFmdGVyIHRoZSBmaXggdG8gc3BpLWZzbC1jcG0geW91
J3ZlIG1lbnRpb25lZCBtYWtlcyBtZSB0aGluayB0aGUgY29ycnVwdGlvbg0KaXMgZXh0ZXJuYWwg
dG8gQ1BVIGNvcmU/IFdpbGwgeW91IHBvc3QgeW91IGZpeCB0byBmc2wtY3BtIGNvZGU/DQoNCi0t
IA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

