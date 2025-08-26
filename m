Return-Path: <linux-kernel+bounces-785867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F20B351F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 04:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878357B4940
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702BF29DB73;
	Tue, 26 Aug 2025 02:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="H6Haf7Gk";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="d4pOgq56"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B726AABE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756176974; cv=fail; b=GUGVC9xm5jBXT0nikKzoaD5KVEf0je5JRf2TwLq463Ky49ZFJSa7oM5wUxzWjapYORtb80ddjW6hAsZk9yHpU5hoaD9AOtT/EXTSparjP9KuxmiqizHK1um89NiBiolG758lqfNHfxtHo9TgDSIH70++IE7MyXPd35pkv+iJQCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756176974; c=relaxed/simple;
	bh=ka2wJsHQm7GfQUryp+ngWG4i9KG3SUHH6DHDkboX0pk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sRa7giKUv9KLwvQSY4xJ8B+VIy1Yc8u7wJex7dRryHq+vE6amjbuFGprnkOpHMOXBXu5vYTWlkP37Oaj9A2Nr76pa8l0OxjpUZSDJVjgAWBu8qSMxYBYTVLLaOnCv87csIyPjrPJoJidzoYm8arLp2r8W9dgjn6MwG/aCzUguEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=H6Haf7Gk; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=d4pOgq56; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 35e26a72822811f0b33aeb1e7f16c2b6-20250826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ka2wJsHQm7GfQUryp+ngWG4i9KG3SUHH6DHDkboX0pk=;
	b=H6Haf7GkP80bjpGElTTq8kTpoHkySfrkpZpkTbsoeVX17VaHewhKQj416olpVCNChUkKNiB8tDCbjxaZ91dqUkYLPj8nM7Y2x0aqnU1VqS2aC/uvoiEgxa4rvww1xS6x8QvqK3ZvfnsgoJkqF1TeN73X0Hj1GSIOoEMRsLj43/s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:7c8dae97-8863-4f0a-beaa-90f5c94db07a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:a6ba857a-966c-41bd-96b5-7d0b3c22e782,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 35e26a72822811f0b33aeb1e7f16c2b6-20250826
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <xion.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 373480886; Tue, 26 Aug 2025 10:56:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 26 Aug 2025 10:56:05 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 26 Aug 2025 10:56:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1xgKRowg2AZazWyBAVH2OVutbQfRYDPYEIM2KGEpLpVTSIKp7nFIDa0injxoIqGjxSeXf/HjEKjDgeQ+BviixIuISNOLT1MFQDXFskX0n6eWN1xubjFvFmXJY4u1YpOjFiRyiLIYHeNi8F8z53T5F/VvzRDnlknZUKpuP5UsXt4z9jXwWODZ+MFd8YPAuApliREEVqxvru+V36T1m7PTm2zED/Ub9KPrzJbUoPj3XjEBk7vSMlgNonL8ckxqG/E5ahulOtlk6l3x6mTcyJk8FK/kEZ60w7ZhZKfzLOn1XyAwI4wWVLCKaVOjSDKpIga53gAqQudd071jo2gDMPQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ka2wJsHQm7GfQUryp+ngWG4i9KG3SUHH6DHDkboX0pk=;
 b=YRFCs7CSu9cOgRFFmW+P1Ipru8XLbwgXmopz2o1poJGZwA+lpeUjO7fZNQiegFRZ3F0P0j3hRmVX16TIFT3ORuUNOpbtKYDi3f+nnf1v75YA9UEp8Cpn6bBXvk4q1EEXEDew08zUG8lIWYhkgsK2s8TrwEvdSg2vnVNKOzg4R4bLvR4khABMZmS6l5nbMTQ3Crv5BAtKRlLBtPKJQ6nVh+G0zUMEhCWnEbw4fYoa7jf09t1xL3tgQmbK9IfGXoIniypqo4uxal3A6WR9BtBQbzG/DD2ZMDkqHGB+QjeQQJd2jDjsIWcTRsOGGDieXvb9CiioF+aaDmW9CYuRHpcWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ka2wJsHQm7GfQUryp+ngWG4i9KG3SUHH6DHDkboX0pk=;
 b=d4pOgq56mliN+OaorkRc6sISjmXZmgzXHgy7QhyI3CLXpXglqMM4IP72+pfAEGCMDlXBYQu1AoKfd2kaA/RomnoCHfIiMgHgNp8e1TIF1Jj5sT0lQuMoNqUfa9xuNyI55QGht1InViHkOqOXMqcj9E2ZR/3CJJK+0mpg/8Euhbk=
Received: from SEZPR03MB8122.apcprd03.prod.outlook.com (2603:1096:101:183::7)
 by SEYPR03MB6964.apcprd03.prod.outlook.com (2603:1096:101:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Tue, 26 Aug
 2025 02:56:00 +0000
Received: from SEZPR03MB8122.apcprd03.prod.outlook.com
 ([fe80::e130:f417:b0bb:f2b7]) by SEZPR03MB8122.apcprd03.prod.outlook.com
 ([fe80::e130:f417:b0bb:f2b7%7]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 02:55:59 +0000
From: =?utf-8?B?WGlvbiBXYW5nICjnjovpkasp?= <Xion.Wang@mediatek.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, wsd_upstream
	<wsd_upstream@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?SHVhZGlhbiBMaXUgKOWImOWNjuWFuCk=?= <huadian.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "arnd@arndb.de"
	<arnd@arndb.de>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/1] misc: Prevent double registration and deregistration
 of miscdevice
Thread-Topic: [PATCH 1/1] misc: Prevent double registration and deregistration
 of miscdevice
Thread-Index: AQHcFZwQOZEhJSUEf0OpnbqCU1Sn+bRz0oaAgABtc4A=
Date: Tue, 26 Aug 2025 02:55:59 +0000
Message-ID: <d3d0fc0e19f939c093e6df1ff08ce23be71636a3.camel@mediatek.com>
References: <20250825084556.10358-1-xion.wang@mediatek.com>
	 <20250825084556.10358-2-xion.wang@mediatek.com>
	 <2025082533-ranked-simply-4b63@gregkh>
In-Reply-To: <2025082533-ranked-simply-4b63@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB8122:EE_|SEYPR03MB6964:EE_
x-ms-office365-filtering-correlation-id: d0cc603c-c775-4462-26ef-08dde44c1623
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YVpkVkQyY2drQXhBWVF1OFEvYTZEL3hRV0hudVB6b3BkQ21Hekx1alc2dzVy?=
 =?utf-8?B?SWI5MXlXWVNaclF6TkZNU08rVmtoRmlORjVjcmI4RFY4c2c2Q2dxR0lRemY5?=
 =?utf-8?B?a0QwYW1Qb1RmRVIyUFdqSURTaUJ6dStsVFhUZzNJOFhGS1R6NTFYUVF2aUly?=
 =?utf-8?B?M3VNWUFZSjd5UDAvZkxTc1BqQzJNRXlwNGt3cDdSS2ZaNC9td2t4WnFHSGsw?=
 =?utf-8?B?NXZzQ3k5VnB2cHVCdXZ6bnJJMENMcE10eWhFUDI1dTlCaDl3OHduTnJoY0Ja?=
 =?utf-8?B?Z2pSaHBBUWVBVnhwQXF1dE5kSjF2VEx1Mm1LTk8wb2xSRXNrbVpsWlB0SW9v?=
 =?utf-8?B?cWg5QUo3dDhNUTlYUVhmNml5VG0yWldYK0U2TVFWRXJGRVZtTTRiaUZTMHFQ?=
 =?utf-8?B?OFd1RUE4TnhscW5PYVlMNGMySTVMdGJQcW9hOHVwSXFvdHZYcG94N0VhMWty?=
 =?utf-8?B?ZmhZZ2U4akdtMjMwNVJZS2JVK2RhamNSaFNQQ2U3KzJpV0pJNmlxSVlEUDJM?=
 =?utf-8?B?VzZHUmF6a0NoUGtQclZjby9IUHY5WDB3bzcxeG56eGVvR25nNmZnamoyQk9z?=
 =?utf-8?B?VUVnRjhSNTJjZTdQaTBrNXZDZ0tnNmxrNklOUWk4cXIyblZTUTJiTU9aN082?=
 =?utf-8?B?d1VGUXowUnVhRVhxSUlpSllicE9kUjlkV3FqbVpPWUZsSmJyL3lucmJKQzdh?=
 =?utf-8?B?RXR3Rmw0QjBQM0xlSUlzajNvM1B0TGxPZmFuSUhpc1FtL3RzZjUyNTlmU09N?=
 =?utf-8?B?eGszSGt2UHdXMVBXUVRSdWVBOWRuVUpmWHFYQTg0eXlhdm9LbmtDUDhMWUx4?=
 =?utf-8?B?WDZRcCtMbDdjdThSQVRCWjc3UkVZeXNtWm1UQk1JWDUvR0JKYzJmSFFhVkph?=
 =?utf-8?B?VTkrSVJWaFVrK2tZdm15MXFoWWJlaUZ4bllobXExVkRNOTFRMVB4eDNWYTl0?=
 =?utf-8?B?em1uTmpFWjNCMncwcTIwb0MvQWJXZDhKUzR4NTl6NUc3SjZ6NWw2L1F4OTBE?=
 =?utf-8?B?MGRkYnp2aHk0RklnUWF6QlU4V0N3Qkk4Mkp0Zi9Xc2F3aEFNUXRRaWp0TUlS?=
 =?utf-8?B?bVRWUEQyZ0NGYW9Jckx0Qm9aNzR0bUREOFMyM0ZUdGJUdDRWeDVjNzlUZGtk?=
 =?utf-8?B?QnpZeGxhelVZWlNkZXR4bmN2aDF0eU9CZGJxSGw3bTNtcUJrQ21iQ2VIcTBY?=
 =?utf-8?B?UXpZb0htSnJKL29QcjVSSkZEYkFSN3BOZHFyc2RCZWhVekZCdnl6bVIyU0xk?=
 =?utf-8?B?ZUt5SVFKZ2dQK08wMXNUd3FDRCtyUTk3SXhhcFNiMDdNdGM3c21ibDJZTmJ1?=
 =?utf-8?B?d0N1Wml3Q3ZCb2gwYXJOWk0zZ3p3bHZRZkcxSEIzcnlidWVxV0l2dmVueE0x?=
 =?utf-8?B?enBNb0tHaVhFNllpYm5TMXNkdTMrMEhRZnBDSTBhdGppaDZTZjNxaE1lZDhC?=
 =?utf-8?B?c1F6SmZRaWg4TVNBTHVYYnRVNGI2WFg5WTFLK09nc2lVY1FXSXlLVTZKWkFB?=
 =?utf-8?B?UFFYOWhIY3NFUzltQjlPSVJpL1JPQlkrUTk1bFBtZVpzZ3h5WkpPbkJvelB6?=
 =?utf-8?B?ZzFEdCtyOUkyZEg5ZzNVOTlaWHJjaXJJdURTc0VtRThrYmMrdDluaW1TNnNm?=
 =?utf-8?B?TEpoUkdGc05ZRjlKTitLeExGSDZuVWdPV3ltUjVPa2YwajhDdnBPSWE2RzN4?=
 =?utf-8?B?aEFPMEQzeWpqcXZpN0p2WFlKYVNQb25UVGtYZFRGemRkQllWQWo0N3MzSDlE?=
 =?utf-8?B?OTNrR1lMNXR6OExEWlFET3g0Nzc1eEQ1M1lJNS9wWVBFQVBPU254by9Ec3JG?=
 =?utf-8?B?QkwwUXNnM0RIUURlWktMSUx4MWZFZ2pROUJVN05sM2V4aGFsMnJ0TG5kYWFI?=
 =?utf-8?B?YyszY2tScmFlb29nYnF0VDZ6NUY0OGtBSkozclcxWmVNZkE1QVNHb2hCYUpL?=
 =?utf-8?B?aFR5SXFHbnhRazNKc3B6T2xKUkNuNFdqVTBoZ0xnNFgwOWZOQmxJOEVIdERC?=
 =?utf-8?B?OXBmN0VaaW5nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB8122.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVV2R0NpbDVzWHNaalNJbjAyT3QwWGxDWmxBL1ZJTjhOZFlkSWZwS0Z5cEJa?=
 =?utf-8?B?bTgyQTQ5Y1QxVmx5eGFEM0lBTEloUGZFYWxubWRJT1FsNU5SQmZvZ1VzR0to?=
 =?utf-8?B?VWh6ZTlyWnVlOHcyTHdHckQzS0dQeEJNUGNUY1g3MnBRUTlkNTVZUkQwQnU2?=
 =?utf-8?B?czRqbWFtTk5wVjNWbE9xK0RzUXJ2VXRDQ2wzMlEyTStXY2QzYWpVL0dlcEFZ?=
 =?utf-8?B?Mjlsbkd4MmtCUzJJblVGV2tkSWZ1VjNoUUJmNXM0anJZTW1pOTdOY3F4cW5q?=
 =?utf-8?B?NWFlVXNkVWVYLzVkV3hrNHBVdCtubU9yQm5nNzAwODFTQzBwbThGSzlqK3I1?=
 =?utf-8?B?Wnlqc0k1VHNxNGVuTDVORUZ1UW9XNk5YVHlsOGVRSmtvTDlicFo4VHJWQys5?=
 =?utf-8?B?ZVJaVVlsczlXSzBRUm5TT0F5NXNEdlUvOHROVFNuM1krK3I5MGJUT29yZ1Zr?=
 =?utf-8?B?UFo1VmVCL2NGVDV1MHVxK2xUVDhNYkVaR3dJMEN4aWl0aDBGRzRLZjZKdVEr?=
 =?utf-8?B?eVBYTXdYQk04bm4zQlZXaTlkMGd0dmQ1bWVwRnZhSW02NUFtUTVabHNKd0hC?=
 =?utf-8?B?Y05DdHdyeEtkTWxYUmZ4ZGdHRzZ1dEY4YkY4U0d5Mzk2Tk5NMHpPTG83VWkz?=
 =?utf-8?B?eEpxQWU0S2hlaU9YRlRXRERXNGljMlRPNmgza0ZHYU5BWHFCVUxOUjBGTUtH?=
 =?utf-8?B?aG96MWxxdmV6V281UmhHRk9KSDk2azZubVdSTVliMXNHM25QNldqWHNyNngy?=
 =?utf-8?B?cnMxTmpSS1hjNWNMd3dzMnlZRktJOVFsanB1ZjhFZnpFM2tXcFNmNUdzWHY0?=
 =?utf-8?B?WU8wYkptRGFPYnZBVytJOTdWU2hEaytpNXVMbkdGaUZoYkV5ZmsvTnJwaHNY?=
 =?utf-8?B?a0JNR0pmdzlwMnZVTGVxbG5EV29oTjVuMnJIeEV1TmxVaEE4SDZXREJ3UHp0?=
 =?utf-8?B?bFZNS1YzYjF3TWI3anFLMjdSSzRMaVk4N25ybnhKNzFYWmRzODA0RDVWQ0pP?=
 =?utf-8?B?dmNBM3M2dVh0NHpkZzR3eTJadW1oTXlIbWdLUHM5TnovMHhLMDlLVlpaYjky?=
 =?utf-8?B?V2t5NFo5cnR4a3F3THA3cjNISlgyOWF2OUVSM0xQZFdITzNQNmluMHZjS2tP?=
 =?utf-8?B?MXZHb0JMRnpIbE5IZFlFR0RVUit2ZzlDdWFxYm9oOXRjMXFlbW56a1QrK01h?=
 =?utf-8?B?Wnd5NDdhVE42U0FtRTRTNXlJZnRzVVFkTUV0THBpK2doSVlaUkt1anllYTlH?=
 =?utf-8?B?M2ljV3p1NHdOMjZuL01MTXZCbUZpbTlkRnNxVkFFc0tMWkxqL05UeitqZWF3?=
 =?utf-8?B?UzJ0KzhLSjFjWlI5RFVaRVp2WTU0YXNwc2lKU2swZ2o3RWNoeS9raU9PLzRL?=
 =?utf-8?B?MDk5RnJXNnBvTkVRN2dsSHdJQ3lBQ0IxRVhVSVRGWGRmRlRxVHgzK2p3S2lx?=
 =?utf-8?B?NlB0WlhWWFlRc2ZpSHJkaFYwU3o4ZzFMTTlrdXVRUWlReUt1N3RMeCtzdmha?=
 =?utf-8?B?MlNMQ011bFEzYmx3NTVRcHptU3BUWWlsa3J5TURxSzd2NFFweXlVVVNvdE5v?=
 =?utf-8?B?R3gvRDYwZGhOdEVRT2pDR05VbGxIaTQ0WXRoQ1VzY1JIbDdqek9SYWgwR2t0?=
 =?utf-8?B?bXplTFRZcXVFeXZnWkdHc3Q3V09KTjk3T1ZlVG1USjlmZkM3c3UzaitxNUtW?=
 =?utf-8?B?VG1WUUF1ek9uUjNBSURoc0k3SW92cVpQVHRBdkowVk1RclB0TUpkM1RjQlpp?=
 =?utf-8?B?NkRPNU1uK2dQdVEveU5ORml2bXRFMnRHTHNZd2pIajFTMFZoeXRqZ0M4djNJ?=
 =?utf-8?B?REUyQ3BJK3F5dzkwbTRacVpYTWVMQnJPMW1PbGlaVjNrTnE0S3BSRUJaUnIz?=
 =?utf-8?B?Z2RmazlrQ3M4dnF0QWo4WTdQU29uRUFsVURyWXRyTzRqbXJZa0tpM0EwREMw?=
 =?utf-8?B?alpJaUhKT3lNRzFDdGJMNzhSbERST1AvVENpWStVRWZGRmxNSUduWXBDSUxK?=
 =?utf-8?B?d09pUEhtbWpOam0zbmdCQjJVTkJuOTA3MVZISHd3bVhWYUc3RCtHVnVGNGxS?=
 =?utf-8?B?N2U1ZE5sekgyTzBVUUd5Z1luZkFTUmJhSkpuSHI3TnhEQzhaMkJVdm1FWUFz?=
 =?utf-8?B?N1RsUERNT1hBZWtNL0l5RTBXWE5xczlndlJhRWlLdWFaWmlVc2dIRFhuUkJv?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7937D9AE243A3E418191F610509416CD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB8122.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cc603c-c775-4462-26ef-08dde44c1623
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 02:55:59.6134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /g6Cp/9Hdox6uSo+PjcUiwng+cWNNoBz2lHnZSmsCRihsiSiF4SEsmIUlKt9TAHgziloDTS1GlAbQBUHc38Q3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6964

T24gTW9uLCAyMDI1LTA4LTI1IGF0IDIyOjI4ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+IA0KPiANCj4gT24gTW9uLCBBdWcgMjUsIDIwMjUgYXQgMDQ6NDU6NDdQTSAr
MDgwMCwgeGlvbi53YW5nQG1lZGlhdGVrLmNvbQ0KPiB3cm90ZToNCj4gPiBGcm9tOiBYaW9uIFdh
bmcgPHhpb24ud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gV2hlbiByZXBlYXRlZCBjYWxs
cyB0byBtaXNjX3JlZ2lzdGVyKCkgb3IgbWlzY19kZXJlZ2lzdGVyKCkgb24gdGhlDQo+ID4gc2Ft
ZSBtaXNjZGV2aWNlIGNvdWxkIGxlYWQgdG8ga2VybmVsIGNyYXNoZXMgb3IgbWlzY19saXN0DQo+
ID4gY29ycnVwdGlvbiBkdWUgdG8NCj4gPiBtdWx0aXBsZSBJTklUX0xJU1RfSEVBRCBvciBsaXN0
X2RlbCBvcGVyYXRpb25zIG9uIHRoZSBzYW1lIGxpc3QNCj4gPiBub2RlLg0KPiA+IA0KPiA+IFRo
aXMgcGF0Y2ggaW1wcm92ZXMgdGhlIHJvYnVzdG5lc3Mgb2YgdGhlIG1pc2MgZGV2aWNlIGRyaXZl
ciBieQ0KPiA+IHByZXZlbnRpbmcNCj4gPiBib3RoIGRvdWJsZSByZWdpc3RyYXRpb24gYW5kIGRv
dWJsZSBkZXJlZ2lzdHJhdGlvbiBvZiBtaXNjZGV2aWNlDQo+ID4gaW5zdGFuY2VzLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFhpb24gV2FuZyA8eGlvbi53YW5nQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9jaGFyL21pc2MuYyB8IDcgKysrKysrLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2hhci9taXNjLmMgYi9kcml2ZXJzL2NoYXIvbWlzYy5jDQo+ID4gaW5k
ZXggNTU4MzAyYTY0ZGQ5Li4yZjg2NjYzMTI5NjYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9j
aGFyL21pc2MuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2hhci9taXNjLmMNCj4gPiBAQCAtMjEwLDYg
KzIxMCw5IEBAIGludCBtaXNjX3JlZ2lzdGVyKHN0cnVjdCBtaXNjZGV2aWNlICptaXNjKQ0KPiA+
ICAgICAgIGludCBlcnIgPSAwOw0KPiA+ICAgICAgIGJvb2wgaXNfZHluYW1pYyA9IChtaXNjLT5t
aW5vciA9PSBNSVNDX0RZTkFNSUNfTUlOT1IpOw0KPiA+IA0KPiA+ICsgICAgIGlmIChXQVJOX09O
KG1pc2MtPnRoaXNfZGV2aWNlKSkNCj4gPiArICAgICAgICAgICAgIHJldHVybiAtRUVYSVNUOw0K
PiANCj4gWW91IGp1c3QgY3Jhc2hlZCB0aGUga2VybmVsIGlmIHRoaXMgZXZlciB0cmlnZ2VycyAo
cmVtZW1iZXIgd2hlbg0KPiBwYW5pYy1vbi13YXJuIGlzIHNldCkNCj4gDQo+IFNvIHBsZWFzZSwg
aWYgdGhpcyBjYW4gaGFwcGVuLCBwcm9wZXJseSBoYW5kbGUgaXQuDQo+IA0KPiA+ICsNCj4gPiAg
ICAgICBJTklUX0xJU1RfSEVBRCgmbWlzYy0+bGlzdCk7DQo+ID4gDQo+ID4gICAgICAgbXV0ZXhf
bG9jaygmbWlzY19tdHgpOw0KPiA+IEBAIC0yNTEsNiArMjU0LDcgQEAgaW50IG1pc2NfcmVnaXN0
ZXIoc3RydWN0IG1pc2NkZXZpY2UgKm1pc2MpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIG1p
c2MtPm1pbm9yID0gTUlTQ19EWU5BTUlDX01JTk9SOw0KPiA+ICAgICAgICAgICAgICAgfQ0KPiA+
ICAgICAgICAgICAgICAgZXJyID0gUFRSX0VSUihtaXNjLT50aGlzX2RldmljZSk7DQo+ID4gKyAg
ICAgICAgICAgICBtaXNjLT50aGlzX2RldmljZSA9IE5VTEw7DQo+ID4gICAgICAgICAgICAgICBn
b3RvIG91dDsNCj4gPiAgICAgICB9DQo+ID4gDQo+ID4gQEAgLTI3NSwxMiArMjc5LDEzIEBAIEVY
UE9SVF9TWU1CT0wobWlzY19yZWdpc3Rlcik7DQo+ID4gDQo+ID4gIHZvaWQgbWlzY19kZXJlZ2lz
dGVyKHN0cnVjdCBtaXNjZGV2aWNlICptaXNjKQ0KPiA+ICB7DQo+ID4gLSAgICAgaWYgKFdBUk5f
T04obGlzdF9lbXB0eSgmbWlzYy0+bGlzdCkpKQ0KPiA+ICsgICAgIGlmIChXQVJOX09OKCFtaXNj
LT50aGlzX2RldmljZSkpDQo+ID4gICAgICAgICAgICAgICByZXR1cm47DQo+ID4gDQo+ID4gICAg
ICAgbXV0ZXhfbG9jaygmbWlzY19tdHgpOw0KPiA+ICAgICAgIGxpc3RfZGVsKCZtaXNjLT5saXN0
KTsNCj4gPiAgICAgICBkZXZpY2VfZGVzdHJveSgmbWlzY19jbGFzcywgTUtERVYoTUlTQ19NQUpP
UiwgbWlzYy0+bWlub3IpKTsNCj4gPiArICAgICBtaXNjLT50aGlzX2RldmljZSA9IE5VTEw7DQo+
IA0KPiBZb3UgYXJlIG92ZXJsb2FkaW5nIHRoZSBwb2ludGVyIGhlcmUgdG8gbWVhbiBzb21ldGhp
bmcsIHBsZWFzZSBkb24ndC4NCj4gDQo+IEFnYWluLCB3aHkgd291bGQgdGhpcyBldmVyIGhhcHBl
bj8gIFdoYXQgaW4tdHJlZSBkcml2ZXIgZG9lcyB0aGlzPw0KPiANCj4gdGhhbmtzLA0KPiANCj4g
Z3JlZyBrLWgNCg0KDQpUaGlzIGlzc3VlIHdhcyBlbmNvdW50ZXJlZCBkdXJpbmcgTVRLIGludGVy
bmFsIHN0cmVzcyB0ZXN0aW5nLA0Kc3BlY2lmaWNhbGx5IGluIHRoZSBXaUZpIG1vZHVsZSBvbi9v
ZmYgcHJvY2Vzcy4gSWYgdGhlIFdpRmkgbW9kdWxlDQpmYWlscyBkdXJpbmcgdGhlICJvbiIgcHJv
Y2VzcywgaXQgdHJpZ2dlcnMgYW4gIm9mZiIgcHJvY2Vzcy4gSG93ZXZlciwNCmlmIHRoZSAib2Zm
IiBwcm9jZXNzIGFsc28gZmFpbHMsIHRoZSBtb2R1bGUgbWF5IG5vdCBiZSBwcm9wZXJseQ0KZGVp
bml0aWFsaXplZCwgYW5kIHRoZSBtaXNjIGRldmljZSBtYXkgbm90IGJlIGNvcnJlY3RseSBkZXJl
Z2lzdGVyZWQuDQpPbiB0aGUgbmV4dCBXaUZpICJvbiIgYXR0ZW1wdCwgcmVwZWF0ZWQgcmVnaXN0
cmF0aW9uIG9mIHRoZSBtaXNjIGRldmljZQ0KbGVhZHMgdG8gY29ycnVwdGlvbiBvZiB0aGUgbWlz
Y19saXN0LiBTdWJzZXF1ZW50bHksIHdoZW4gYSBkZXZpY2UgY2FsbHMNCm1pc2Nfb3BlbiwgaXQg
bWF5IGFjcXVpcmUgdGhlIG1pc2NfbG9jayBhbmQgZW50ZXIgYW4gaW5maW5pdGUgbG9vcCBpbg0K
bGlzdF9mb3JfZWFjaF9lbnRyeSBkdWUgdG8gdGhlIGNvcnJ1cHRlZCBsaXN0LCB3aGlsZSBvdGhl
ciB0aHJlYWRzDQphdHRlbXB0aW5nIHRvIGFjY2VzcyB0aGVpciBtaXNjIGRldmljZSBub2RlcyBi
ZWNvbWUgYmxvY2tlZCB3YWl0aW5nIGZvcg0KdGhlIG1pc2NfbG9jay4NCg0KVGhpcyBzY2VuYXJp
byBleHBvc2VzIHR3byBpc3N1ZXM6DQoNCkluY29tcGxldGUgZmFpbHVyZSBoYW5kbGluZyBpbiBv
dXIgaW50ZXJuYWwgV2lGaSBtb2R1bGUncyBvbi9vZmYNCnByb2Nlc3MgKHdoaWNoIHdlIGhhdmUg
YWxyZWFkeSBhZGRyZXNzZWQgaW50ZXJuYWxseSkuDQpUaGUgbGFjayBvZiBhIG1lY2hhbmlzbSBp
biB0aGUgbWlzY2RldmljZSBmcmFtZXdvcmsgdG8gcHJldmVudCByZXBlYXRlZA0KcmVnaXN0cmF0
aW9uIG9yIGRlcmVnaXN0cmF0aW9uLCB3aGljaCB3b3VsZCBpbXByb3ZlIGl0cyByb2J1c3RuZXNz
Lg0KDQpEdXJpbmcgb3VyIGludGVybmFsIGNvZGUgcmV2aWV3LCB3ZSBmb3VuZCB0aGF0IG1pc2Nf
ZGVyZWdpc3RlcigpIHVzZXMNCmxpc3RfZW1wdHkgdG8gY2hlY2sgaWYgbWlzYy0+bGlzdCBpcyBl
bXB0eSwgYnV0IHRoaXMgZG9lcyBub3QNCmVmZmVjdGl2ZWx5IHByZXZlbnQgY2FzZXMgd2hlcmUg
YSBtaXNjX2RldmljZSBpcyBub3QgcmVnaXN0ZXJlZCBvciBpcw0KZGVyZWdpc3RlcmVkIG11bHRp
cGxlIHRpbWVzLiBUaGlzIGNhbiByZXN1bHQgaW4gaW52YWxpZCBsaXN0X2RlbA0Kb3BlcmF0aW9u
cyBhbmQgdHJpZ2dlciBhIGtlcm5lbCBwYW5pYy4gDQoNClJlZ2FyZGluZyB5b3VyIGZlZWRiYWNr
LCB5b3UgYXJlIGFic29sdXRlbHkgcmlnaHQuIG92ZXJsb2FkaW5nIHRoZQ0KdGhpc19kZXZpY2Ug
cG9pbnRlciBhcyBhIHJlZ2lzdHJhdGlvbiBzdGF0ZSBmbGFnIGlzIG5vdCBpZGVhbC4gSSB3aWxs
DQpyZXZpc2UgdGhlIHBhdGNoIHRvIGludHJvZHVjZSBhIGRlZGljYXRlZCBib29sZWFuIGZsYWcg
aW4gc3RydWN0DQptaXNjZGV2aWNlIHRvIGV4cGxpY2l0bHkgdHJhY2sgdGhlIHJlZ2lzdHJhdGlv
biBzdGF0ZS4NCg0KV2UgYXBwcmVjaWF0ZSBhbnkgZnVydGhlciBmZWVkYmFjayBvciBzdWdnZXN0
aW9ucyBmcm9tIHRoZSBjb21tdW5pdHkgdG8NCmhlbHAgaW1wcm92ZSB0aGlzIHNvbHV0aW9uLg0K
DQp0aGFua3MsDQoNCnhpb24gd2FuZw0K

