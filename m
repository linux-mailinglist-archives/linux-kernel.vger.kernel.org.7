Return-Path: <linux-kernel+bounces-613513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C579AA95DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 08:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB817AA189
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 06:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55011E5707;
	Tue, 22 Apr 2025 06:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Sw+ULxMW";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="btUzsUK6"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173091A238C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745301686; cv=fail; b=NWZ+E12reuek3K2PW1RKX3Hw6OVr86RwTMLtx1C1BdFxnkUvtWbV+WQ6xWQinQw1utp9I9EG+/ZG9zRcq0+oHLQb0tPjnxfhIXrmQmQ3iUFmVsEykpqB3M54gqTVuMpJlu8PX9ou9sICIy8YNDUrh2nd8PrLWIu1rY92TmICqmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745301686; c=relaxed/simple;
	bh=KbX/HLUiV5CQVz0fR7kquZeEBQgZ3qRe7MjO/xSooCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Va6FnsBHC/agMxhjyn2yQhbUgJGMyEJ30Pm1Rp/l3vwN2zSH/x60jQVqcfSY3XfdcCVDXsKuImHlXJisFJbXpwrgFuTAGf5/4B7qvzi1sVKeSJug6APrZjOyCNPCZVHiZtc3LJMYcDZCP5wkozFkGpJ9/OPa+pZWjP3expMVopk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Sw+ULxMW; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=btUzsUK6; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 349bd53c1f3f11f09b6713c7f6bde12e-20250422
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KbX/HLUiV5CQVz0fR7kquZeEBQgZ3qRe7MjO/xSooCw=;
	b=Sw+ULxMWylcBI/UuHnz24uqNfjk7LuruHHXeevIvpdhgsKYBGi4AghZKILJf579m+PvYIS7OpvwYKod0DLir1pUDLFMbbFrtmAMPHLoqUU42vEmI+FqAjgrVw6NZ4F4KUi6xNaqWChElVQ1HPBQH2lgH49fS2WFxGcAfvnbD+v4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:1d16c748-43d8-4d71-96df-e045091a5a82,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:b75b878b-0afe-4897-949e-8174746b1932,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 349bd53c1f3f11f09b6713c7f6bde12e-20250422
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 877248484; Tue, 22 Apr 2025 14:01:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 22 Apr 2025 14:01:16 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 22 Apr 2025 14:01:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQJAi2SuPIJ/3XGTKnOQ53+BF/Q9NCnebp29YcVtn/pH06D+cTOm5HHAzNQ2hgeBahJBf7k19wxlZLTeCE11e4tsnP6ufJIBDQBmpJTqGhled3L5NisyHcuXC/rOcAEi//MczUucFBP1Dyr1RmvbZGq20fDbBBoEJAL5ERELKiOYPcQWUh+hJr3mLYfcZ/uvjmebko8ZexKLqcVBwvVB1N9Q+r03zkk7lc8lwJEIlyYL4fmCNPASbbT5Ig++a8gezqbomqp5+tuQhs12/w6hjEmCx6IOVeBV6kmgCxU2UdtZX9VjGWUGWKKC8Roz8ymDeMbi3Xqb29ah5x+hZuCf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbX/HLUiV5CQVz0fR7kquZeEBQgZ3qRe7MjO/xSooCw=;
 b=V4VWg8WyTd3IWaQFOKGtY/f916riC/MsT5fPxrIfIuEUrXa2nUXdO0cxoNgLZF7I/IeYCKNmGxdo2YnW+HTrVKgQZq5bsZOJWF5OnJtfi3Qg+mErxgGykccVHBJSjHTvUnOVE7dJdPGsuF+ZezUdYfH+ETdpjYNSFw1TNGwTPmA6c/Eir66b0vNSNMoULzyX39G7mf7tlXjkFl0DkICFxje5ZmU+Ci7c6TcnsFKZ1+8eCvX+uJXB9cJzsNbMDGgqt/y+bWDHk9JiE9IGx+rxtW84P2MSUygUzOlYb7zVLuIfqaoIBxApF8xK4fT0wTPnpO/BF3w5RwdZIxU1h7iUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbX/HLUiV5CQVz0fR7kquZeEBQgZ3qRe7MjO/xSooCw=;
 b=btUzsUK6+HNHJxkYUkbW5H4QDE6SMZIKs6Y961k/Ytghbz9eZ4CEKTsICOtoMWIrioiXNL0tc7cMJPVKbmOeBn20UEpdui+WdYrAlC/VuUaPvFWStKzzeJM/VRi9gcy90MJyFC4CupiflDYnxPSUDP+HmnjXPKIkDJw5E7f26a4=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by SEZPR03MB8539.apcprd03.prod.outlook.com (2603:1096:101:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 06:01:13 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba%3]) with mapi id 15.20.8632.035; Tue, 22 Apr 2025
 06:01:13 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: =?utf-8?B?TGV3aXMgTGlhbyAo5buW5p+P6YieKQ==?= <Lewis.Liao@mediatek.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	=?utf-8?B?SXZlcyBDaGVuamggKOmZs+S/iuW8mCk=?= <Ives.Chenjh@mediatek.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>,
	=?utf-8?B?VG9tbXlZTCBDaGVuICjpmbPlvaXoia8p?= <TommyYL.Chen@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v1 4/5] drm/mediatek: mtk_dpi: Allow additional output
 formats on MT8195/88
Thread-Topic: [PATCH v1 4/5] drm/mediatek: mtk_dpi: Allow additional output
 formats on MT8195/88
Thread-Index: AQHbqVFgMggQ11QFZUWpXtAKiSq7JLOvRUKA
Date: Tue, 22 Apr 2025 06:01:12 +0000
Message-ID: <270828a4074dcb0d1017cee0c5ce0406991fbc8d.camel@mediatek.com>
References: <20250409131306.108635-1-angelogioacchino.delregno@collabora.com>
	 <20250409131306.108635-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250409131306.108635-5-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|SEZPR03MB8539:EE_
x-ms-office365-filtering-correlation-id: b2c79269-dbcd-48d9-0d3c-08dd81631628
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZjhBSVNSTC9YdFpVcDdMb3ZRSk94VXFCVWUyZEc3dEtsNVBPd0lkdWFjQTlQ?=
 =?utf-8?B?dExOSlJWc1JHclpwcm52ZVg1Mis2NzZBVVZ1VzhvYUZmUi9qWUpBcm1QZU40?=
 =?utf-8?B?eDNjVmtYcjcwTUQrV29SZ2NiUzVBM3VvNDRTNEx6UU56YkwxWDdBaDh4UTRJ?=
 =?utf-8?B?UU5xeWtqTnV5YkJaMmRzSmdxZzQ3a2Z3cTgxd0xKVXNHd3VHaGRkdURkNTUv?=
 =?utf-8?B?cXlDREYvWUd1Z2pSZTlvMEpGQWdKbHJ6eDFyaGdpbVJFWXhxMFl0blF4Q1VX?=
 =?utf-8?B?ZzFhWjRIMFBQOTlBMVU2ZFZBZkJPVVVBUXFrcVNHNFRBQzFkdkFRaEU5ZEc4?=
 =?utf-8?B?SS9pMzVxTlcvOEwwK2pEOGhwcWpLempwZ3VJeVIwQXl5Smx4Q0EwKzlRd080?=
 =?utf-8?B?K1hWOUlUWWFSMmRkb3poenhpQk5PSzdsVGowdkx4TDRhcEFmWUpHTHhOQi9k?=
 =?utf-8?B?cXhNRXlLNTE3dmJROVplc2gzc0Uxd2RWTUlvZUVPWXBEcFZYZDdXUVZ3eUVr?=
 =?utf-8?B?aUpZTVZjVFYzMjYwZDBzNzZEbmZnbyt0OWhKZ083OGltYmdPdmdjN1JpanRt?=
 =?utf-8?B?U1BtTzdZLzNkYVFuUXFIZ1RSZHZvY28vbnFLUC9sNTdDQU5jeVpIc1ZwakVN?=
 =?utf-8?B?cjB0d3FEMTJ1WWRycFB2MXFURjNheEd0eVhxcGtGU2NCZkFUUWYrNU9JM2pR?=
 =?utf-8?B?QTRRTGpUT3oraVVseU9yWTZ4czBsYmRMaWJXWkVNU1YyeWd5cHVham5NT1JS?=
 =?utf-8?B?TVMxYjlYcGRmMEt3QkF5VE91dWhXTnRvUE9OaEtVVGhManhuNnl5VjFGVUs2?=
 =?utf-8?B?VzU0WDNSLzc4b24wUjFaTEhBTVU1UHVjVVNzcFh1OWUyeC9XSGpoUE05VlVS?=
 =?utf-8?B?VkhLSThuYlZpYXhmRGhSdUxzSFRINlhoZnN2SEF6Mko2WW5IUlFRcjljVEdr?=
 =?utf-8?B?R2RVTGhCMjdqQ0VMdDN6cHoweUR6M0RLV05BSjZIUFRLZXhSZkdUeXFQM0xM?=
 =?utf-8?B?RTd5ZmFRR3F6Q0ZnTlRZY3NpN1VSSDBJTU1EZU1RYmpGclEzQnpoVmh5aldk?=
 =?utf-8?B?b0dkTDk1bERUSmgrcGtMNHN6RDdsMHNtZXhwQVZmanp3TTJ5SXU2bVR6ajVQ?=
 =?utf-8?B?N3Y2WUQ1bnUwN1RnVjdXYlEyV0lCSjhrOWUxcVp1Q21pelA4NG1UNUVaREhH?=
 =?utf-8?B?eTJrQU8zUEc1dFQ2cWZObVNDcU45ejUxeENjNzVqUFBuQngwNVc5cm03bGF1?=
 =?utf-8?B?SWRNNURQUmV0Ry9rems5QjloY1ZpSWRwMmhhOHM2dGJHNUEzMWpJOU5QbGEw?=
 =?utf-8?B?S0ZZZTFYcVh1NXYvVHNoLzVpYVZtbFFRdHNmc09taVlJdnZUWFQ4OEFPN1lT?=
 =?utf-8?B?cHFnQkhObUkvZk82TXRybXl4UTd3MldQeURDYkpsc1I3OUIwOFRsS1ByVTBH?=
 =?utf-8?B?Qmh4SUR6NlJ4N1lFWU1sNklwVUZGcnlXRWpzUUl1cmx5TkN2OGpmelphNUZ6?=
 =?utf-8?B?NithUHpMbGhrbjQvaS8vNnRGbXp3V080UnRvb2tUQWhNM3BMWFVra0FOMmM3?=
 =?utf-8?B?N2t6VkY4Y2pnK05PY05ncXhINDFVdlZ6MzVQMElveWNLOXFxZDR5U0NZSjEv?=
 =?utf-8?B?VldzM3o2NnpkTzZKN2Jqb3VTdjBqeWZCYUFabjl0czZ3dmloWEZLWEpkcHpU?=
 =?utf-8?B?QmR0K1pYSDJ0T2gwNGNodHc2N1E1YjY1S1RJZWdpOUVaZi80UXBWT2dvaFpr?=
 =?utf-8?B?eTNtSk91Vnd0Z01McllLNVZWaEVGWUQ5eEptb3QvdlBnc0pybFJYbnErRzJu?=
 =?utf-8?B?cVE4ai9GZFg5dEdDbDBxaFpFRm1MRUhLckRBME56SkUvNUw3bnNpcmZGRCta?=
 =?utf-8?B?TFR0U0ZjV2hNeGp6ekRFWmlmUVVNWnB2aVNqb1JEWnpNVGdqaUxHV0ZjQ01E?=
 =?utf-8?B?aWNCNnZsT3lHRGZvUE1leld1RFMwcmF4UHk3Tll3aFlSekJ0MGI1M2FOZmNx?=
 =?utf-8?B?aU13YUhqbHFnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEY1TngrYVFicm1Bb0lyQmRnNks1MW1JSzlEYkdYUG5vQ3BPOVN3bUwydGk0?=
 =?utf-8?B?QmtUeGE5VkhhbWZ6d3V0Y0V5dHQxUmY3Ti9DT3dYOS9wS0VlYWNrdFZMc2dW?=
 =?utf-8?B?cmdSMjBvb3NLLytmK2hheTluaElmR2xMZlFOb0E5dU1NcmYra3dBSTRNNUho?=
 =?utf-8?B?Y2pxMlR4anQ0eWI5ZXYwQVA3N3kzZ3N4NGNub3dYbDAzcGh1SE9SdVdFMmhu?=
 =?utf-8?B?MDk2MXp6RFQ3OThLSENSZWM1U1g5bE01K0V3eHdkR2dJMStmbEVGT0R4REdl?=
 =?utf-8?B?MDUzWURpemdrdVJ4QkpoRDdCVzRQYUcwVW81WE9BYlhDaEVtZWExaFlrd3B3?=
 =?utf-8?B?NVlFYi9ObVJUWGNiS2gxSDlKeHhOQUc2eVpxdE9jampva2I5NFJuQjJwUWhS?=
 =?utf-8?B?T05uY25uWnZJUXA4Lzd5TUhkZVFpbGlqYnNsdVhiclFhY0F1SWJZZ1B2TnFB?=
 =?utf-8?B?czBWUSthM1lQaWE2dS9GRzN0Mk5EUWRabENwU1JqaXYrVE1iVGRGaUZhencx?=
 =?utf-8?B?ZUlKV2JPdjk1VGpSZ05UaEdKcDNGbWFIYkJEUkdaazFKcUhJRnZPNkpneFI4?=
 =?utf-8?B?RFNzMCtEV2FjT2k1cWhNZjJSSXN1UE1tUEs2TWQrMFcvV0xSdk5ZRHFrRkJY?=
 =?utf-8?B?MkcwZFV3ekVoTWloYy8wZDQydXNxMXM1RmhFYnQ3a1FJb2VNaUlHSmhQcWxY?=
 =?utf-8?B?TE9UNEpzZHRBMEtZTkxGMmxtY3NzMWhyWTYxTXFPWGVETEIvT0x3Z1pEeDRa?=
 =?utf-8?B?cFlOcGNnYzNWcnpKRTJCaXVLTnBCVzZWNnJDU0ZIY2gza21vZmpEaG00S3Jj?=
 =?utf-8?B?OXZWRzMzQU5nNVRDM3hGQlZxZ2svbGJTTFdZQWhoYnpvWmtOMVlxK1R1RUNs?=
 =?utf-8?B?UFhMbkluMXR6bHhkYnFHdHB5TGYxRitxRHVCSW1qZnJsQ0d5N1BOWENvRy8y?=
 =?utf-8?B?NTA2Q0tldFF2R1dIMHlnY2s3d0gzeDdwb3k5ZS9YN3Rkdm5RQmMvWVRHUjQ2?=
 =?utf-8?B?KzYxcVlRWlJPcEg2T1E3RGM1d084b3hNaitHMEx1Ym54VlhhS0paL0ExZXNE?=
 =?utf-8?B?NHU2WjlyNjhMNUpsMHpWZjVhdW1DYVA4dFY3UUpjcXRid3dZM21FU0gxY0lT?=
 =?utf-8?B?NTJLd2p3UVVlSWI2aktubG1jRmt4elllNGNSNGlQbjk0MysyckswZFdBQzdC?=
 =?utf-8?B?ajdacnJLMTZlbmtTNWZhTStPZVUwSWl1aWlNaUIrZWRNQUpCeUJpbERrWjJC?=
 =?utf-8?B?ZTZzb3o3Vkk3TEJ4SG9EWUpwNU1mWU1qUU81a0dHQ2Y2ZGVEU0gxSjdqNDk4?=
 =?utf-8?B?bEE5QVJ5K0ZHOStDNzcyOUVNOEtGeWxOZEgwWGM4MFBCVE1xenI3czluSzMv?=
 =?utf-8?B?R1BXUXdjL1p2WjNZdmdoUkxBNXdHWnk0MWdkWWdUWmxqTmZJL1lCRmRoTGts?=
 =?utf-8?B?eFpLWFdiU0JUM2lENGwweWx4dEowVEdndG03dzl4Mk9OZlVMSXlTZUgrWFZt?=
 =?utf-8?B?SXV2NGI4TzdCYmkvRmdtckZaNnRhNGE4YXlsSWwvMHJlamFhUmVwM1d1RS9W?=
 =?utf-8?B?bEFGamljclVSTGZWSVhtWHVmeEwvWlZ4UEZJbFNyblRMSEY0NzA5MUxVdlB0?=
 =?utf-8?B?S0Vra3dkK3drOXVnUFkweXBkcjRGc0NpalNlNlR0U2ZEdXYxVlRmdVBZRHhH?=
 =?utf-8?B?RFdoNStqWTlvWS9acno3andrOFBjN3RxRGR1SkZmZG93KzBIbmh2UzVhZ0VF?=
 =?utf-8?B?ZkYva2UxQ2E3WVhWN1JENUxaaDNaSnJOTS81dFRtd2dVQUdJenBlRFpEaWJ3?=
 =?utf-8?B?eVdIWEJIRkdpQ3BuaGd0bjB6VXhVQjErK3BKU2ZHanFvc2QyNVFORjNVY3hz?=
 =?utf-8?B?eDJ1RlNFSit6cnNicHlWVGtEY0krMUx1TkJmQ0FOM0w2YitGVlYwRnRWUVp6?=
 =?utf-8?B?ZmNpRkpiSHY3Vy9YVFRPYm9LdzdKL21lZDBST01CS1dvbU9LQk5OSlJQcVVS?=
 =?utf-8?B?SzE3QUx0WlB1YmJmNWVYVlhYbDdXSTM0WG5KcG1DbGJiaGd4akt5WGZMeXZU?=
 =?utf-8?B?WXQ5RXRwOEZTL0tUSDFFTnR0aTNyeXRqMDM5blYzZExTMm1UTnhmUkR0ekFV?=
 =?utf-8?B?dEVBcVlOV2hqQmg1OCt3dkNDWCtMc3VPeXRIN1J5U2hTRE8yTEx5QUw4dXRR?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1667EC64FFC0B34A8F74ACECEAB1F482@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c79269-dbcd-48d9-0d3c-08dd81631628
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 06:01:12.7828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwFs0jnAkPOifuprRsl6G/7AQUi5r4HZme+eFxXeIQFL2Ga+I1Do8KdEXdi0ycKIDAlqv2tKJMbh93uwpH1WQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8539

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI1LTA0LTA5IGF0IDE1OjEzICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBbGxvdyBhZGRpdGlvbmFs
IG91dHB1dCBmb3JtYXRzIGluIGJvdGggRFBJIGFuZCBEUF9JTlRGIGJsb2NrcyBvZg0KPiB0aGUg
TVQ4MTk1IGFuZCBNVDgxODggU29DcyAoYXMgdGhlIGxhdHRlciBpcyBmdWxseSBjb21wYXRpYmxl
IHdpdGgsDQo+IGhlbmNlIHJldXNlcywgdGhlIGZvcm1lcidzIHBsYXRmb3JtIGRhdGEgZm9yIGJv
dGggYmxvY2tzKSBieSBhZGRpbmc6DQo+IA0KPiAxLiBOZXcgZm9ybWF0cyB0byB0aGUgYG10ODE5
NV9vdXRwdXRfZm10c2AgYXJyYXkgZm9yIGRwX2ludGYsDQo+ICAgIGxhY2tpbmcgWVVWNDIyIDEy
LWJpdHMgc3VwcG9ydCwgYW5kIGFkZGluZyBSR0I4ODggMlgxMl9MRS9CRQ0KPiAgICAoOC1iaXRz
KSwgQkdSODg4ICg4LWJpdHMpIFJHQjEwMTAxMCAxeDMwICgxMC1iaXRzKSwgYW5kIFlVVg0KPiAg
ICBmb3JtYXRzLCBpbmNsdWRpbmcgWVVWNDIyIDgvMTAgYml0cywgYW5kIFlVVjQ0NCA4LzEwIGJp
dHM7IGFuZA0KPiAyLiBBIG5ldyBgbXQ4MTk1X2RwaV9vdXRwdXRfZm10c2AgYXJyYXkgZm9yIERQ
SSBvbmx5LCB3aXRoIGFsbCBvZg0KPiAgICBmb3IgZm9ybWF0cyBhZGRlZCB0byBkcF9pbnRmIGFu
ZCB3aXRoIHRoZSBhZGRpdGlvbiBvZiB0aGUNCj4gICAgWVVZVjEyXzFYMjQgKFlVVjQyMiAxMi1i
aXRzKSBvdXRwdXQgZm9ybWF0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlu
byBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jIHwgMjQgKysrKysrKysr
KysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RwaS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiBpbmRleCBh
OWU4MTEzYTE2MTguLjlkZTUzN2E3NzQ5MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcGkuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RwaS5jDQo+IEBAIC0xMDkzLDkgKzEwOTMsMjkgQEAgc3RhdGljIGNvbnN0IHUzMiBtdDgxODNf
b3V0cHV0X2ZtdHNbXSA9IHsNCj4gICAgICAgICBNRURJQV9CVVNfRk1UX1JHQjg4OF8yWDEyX0JF
LA0KPiAgfTsNCj4gDQo+ICtzdGF0aWMgY29uc3QgdTMyIG10ODE5NV9kcGlfb3V0cHV0X2ZtdHNb
XSA9IHsNCj4gKyAgICAgICBNRURJQV9CVVNfRk1UX1JHQjg4OF8xWDI0LA0KPiArICAgICAgIE1F
RElBX0JVU19GTVRfUkdCODg4XzJYMTJfTEUsDQo+ICsgICAgICAgTUVESUFfQlVTX0ZNVF9SR0I4
ODhfMlgxMl9CRSwNCj4gKyAgICAgICBNRURJQV9CVVNfRk1UX1JHQjEwMTAxMF8xWDMwLA0KPiAr
ICAgICAgIE1FRElBX0JVU19GTVRfWVVZVjhfMVgxNiwNCj4gKyAgICAgICBNRURJQV9CVVNfRk1U
X1lVWVYxMF8xWDIwLA0KPiArICAgICAgIE1FRElBX0JVU19GTVRfWVVZVjEyXzFYMjQsDQo+ICsg
ICAgICAgTUVESUFfQlVTX0ZNVF9CR1I4ODhfMVgyNCwNCg0KV2hhdCdzIHRoZSBvcmRlciB5b3Ug
Zm9sbG93Pw0KSSB3b3VsZCBsaWtlIFJHQiB0b2dldGhlciBhbmQgWVVWIHRvZ2V0aGVyLg0KDQpS
ZWdhcmRzLA0KQ0sNCg0KPiArICAgICAgIE1FRElBX0JVU19GTVRfWVVWOF8xWDI0LA0KPiArICAg
ICAgIE1FRElBX0JVU19GTVRfWVVWMTBfMVgzMCwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25z
dCB1MzIgbXQ4MTk1X291dHB1dF9mbXRzW10gPSB7DQo+ICAgICAgICAgTUVESUFfQlVTX0ZNVF9S
R0I4ODhfMVgyNCwNCj4gKyAgICAgICBNRURJQV9CVVNfRk1UX1JHQjg4OF8yWDEyX0xFLA0KPiAr
ICAgICAgIE1FRElBX0JVU19GTVRfUkdCODg4XzJYMTJfQkUsDQo+ICsgICAgICAgTUVESUFfQlVT
X0ZNVF9SR0IxMDEwMTBfMVgzMCwNCj4gICAgICAgICBNRURJQV9CVVNfRk1UX1lVWVY4XzFYMTYs
DQo+ICsgICAgICAgTUVESUFfQlVTX0ZNVF9ZVVlWMTBfMVgyMCwNCj4gKyAgICAgICBNRURJQV9C
VVNfRk1UX0JHUjg4OF8xWDI0LA0KPiArICAgICAgIE1FRElBX0JVU19GTVRfWVVWOF8xWDI0LA0K
PiArICAgICAgIE1FRElBX0JVU19GTVRfWVVWMTBfMVgzMCwNCj4gIH07DQo+IA0KPiAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBtdGtfZHBpX2ZhY3RvciBkcGlfZmFjdG9yX210MjcwMVtdID0gew0KPiBA
QCAtMTIwOCw4ICsxMjI4LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQ4
MTkyX2NvbmYgPSB7DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQ4
MTk1X2NvbmYgPSB7DQo+ICAgICAgICAgLm1heF9jbG9ja19raHogPSA1OTQwMDAsDQo+IC0gICAg
ICAgLm91dHB1dF9mbXRzID0gbXQ4MTgzX291dHB1dF9mbXRzLA0KPiAtICAgICAgIC5udW1fb3V0
cHV0X2ZtdHMgPSBBUlJBWV9TSVpFKG10ODE4M19vdXRwdXRfZm10cyksDQo+ICsgICAgICAgLm91
dHB1dF9mbXRzID0gbXQ4MTk1X2RwaV9vdXRwdXRfZm10cywNCj4gKyAgICAgICAubnVtX291dHB1
dF9mbXRzID0gQVJSQVlfU0laRShtdDgxOTVfZHBpX291dHB1dF9mbXRzKSwNCj4gICAgICAgICAu
cGl4ZWxzX3Blcl9pdGVyID0gMSwNCj4gICAgICAgICAuaXNfY2tfZGVfcG9sID0gdHJ1ZSwNCj4g
ICAgICAgICAuc3dhcF9pbnB1dF9zdXBwb3J0ID0gdHJ1ZSwNCj4gLS0NCj4gMi40OS4wDQo+IA0K
DQo=

