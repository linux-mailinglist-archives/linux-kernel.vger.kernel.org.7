Return-Path: <linux-kernel+bounces-809235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B97B50A57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE9F1BC7B54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AA520B7ED;
	Wed, 10 Sep 2025 01:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uB+irvQe";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BTZt0Etd"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9EA1EDA1E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468310; cv=fail; b=K0FB4zmjmuguf3paO2RK028RCpyQ0usghWHXkjk8bCGBNRbPwxNVIjagrjUDSDTBB399n5etRX3VI//UJnvLUJXb29BuF5aDB7zWzQOzT14KY4lMNmKXJILf15Coxuk6UfYS2xI65ZLqE1nVZxpj4ZKyfe9g6PUbpZlkipJCvyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468310; c=relaxed/simple;
	bh=3omNDE2W6v81yb7UIKniAZdrPFqbiKALhMAO9pb5O9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WqNJ2VTEHhPeqiKk1vObBLueIKckHq4bfnq4z4J7hHNEeFDQ4rMP6mGOFbk2t98tAnkE7yHHk3UWNMAOGZtL16iEeiHvEWJyd7pmN8TNGz34JAAMHGutrFX/prD1GdySvZ2JrtGpEVmopWViDJqaHlKpDGjK27PDnbdxYG+bLic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uB+irvQe; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=BTZt0Etd; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d3dbdfa08de611f0bd5779446731db89-20250910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3omNDE2W6v81yb7UIKniAZdrPFqbiKALhMAO9pb5O9Y=;
	b=uB+irvQemtQh5LR5DrVjW1XPdik6yqrQmT6hjqWI9JWKTuXK25HR+aLive38hT3qZ++DVOm0krUuYcj3ootCGISCDSKlNtkeBABA83UTlAj5F9g4eYyO2mXz3QcZwKIg/55UaLSO8r6fiHytZvZUg9H/I/m3V171q6EuUG+Lu94=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:65b1320a-2ba8-4ec2-b08d-dae03094086b,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:83b99d84-5317-4626-9d82-238d715c253f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d3dbdfa08de611f0bd5779446731db89-20250910
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1922908199; Wed, 10 Sep 2025 09:38:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 10 Sep 2025 09:38:17 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 10 Sep 2025 09:38:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4XQPkICJU4LSVv0HlAnjD6DGXRWMjATUQlhc3D0cgY5hVriXgfmi/kLabxGx9nlzOHs6x3o+sLA8eJUnkmlK0S+Fz91ZtwzYa2FPFvi7iN4r/g+OCFmTD7Bw+DCUsedwE8hep/gAHBk0XI6eVqLMppAoz/yKXUHM6d4r9rWdnPUdN9CTLWFoB2kXxDdc8GdLgTzUlR8sc1NQ8gmooGtV1AYGQ13reN5jXOwW+Y08mpxfI6Ty4XDL2ryKQ1d5nRJaxpkn2I5LW9cV4MONpqkdASrRYbbfZ3nVYynP7+GcGxvci/gAIMcY9OrraiQvZlmKdIbzwim0UooXQVfbsPPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3omNDE2W6v81yb7UIKniAZdrPFqbiKALhMAO9pb5O9Y=;
 b=lLmg4o7Zupbh7Pf4j9w81MKN8JbS8G9mg9mY44LGaTTL08GcFN0OMfgQpyoCSr84Y9xilvGASY13cQkH0S5HKgZynNAAhQ8xXPIKGID5o9I5lmE8CLdhgUtKyFCPKTTWyymBWQgnhrNeOTiKdsjwvqYSv0mAhkpDwHVF/Y9c1vD1WVaTyyecuSV22b6BfESutma6g2RiT6tPQTlcImqfW1Bog34VVq6pW6ilD7LLhI9mFnWis/IotJDw++xFKCzz6PHOEsmK7xB4GxuVUQLGsfk9khRuoG5b54s3i1R09Tc2L6dbH9qQ4j+4vao7cdSUt7SGF4VGb4UyvK3ihNSoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3omNDE2W6v81yb7UIKniAZdrPFqbiKALhMAO9pb5O9Y=;
 b=BTZt0EtdevuqQfMGtaqLuFzxgQ1Z/uE2miPAr2fiCyX+E3u8L7oa98GreEY9iK67pyMz0URyHAOOwkEF8ZbtuoT2FkVKdAcsQf/bjaFXPymadoN080451tubT/9/4lyyvHr1s3+iAtdWWhB8ZRGngB+Z18cx2+t8S+HJhhxE0jQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7612.apcprd03.prod.outlook.com (2603:1096:990:17::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 01:38:13 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 01:38:13 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "johan@kernel.org"
	<johan@kernel.org>
CC: "simona@ffwll.ch" <simona@ffwll.ch>, "make24@iscas.ac.cn"
	<make24@iscas.ac.cn>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 2/2] drm/mediatek: clean up driver data initialisation
Thread-Topic: [PATCH 2/2] drm/mediatek: clean up driver data initialisation
Thread-Index: AQHcGMQlDAnTrXAYxkCoVJ3S/41H0rSLtZsA
Date: Wed, 10 Sep 2025 01:38:12 +0000
Message-ID: <c4137f43453ee9ae17592dd230426f26e338f0d8.camel@mediatek.com>
References: <20250829090345.21075-1-johan@kernel.org>
	 <20250829090345.21075-3-johan@kernel.org>
In-Reply-To: <20250829090345.21075-3-johan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7612:EE_
x-ms-office365-filtering-correlation-id: 13a6f2a5-eb7e-48d9-aa8b-08ddf00ab4d4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|42112799006|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?b0ozZ1BRTHJXZDlEZTNRVGdjcU9raEkwVWxCY29HQVV2cGNXUVg3LzQvOTg0?=
 =?utf-8?B?LzNwSy9qNHRjcXRldG9PbFFmb1Y4OTF0N3FZaWEwS2lWWXM1eXNpbkNZZklj?=
 =?utf-8?B?TzBpcUVWZWJpeTEyaVJSOHBUUC9ITWlzeXVUblFwLzJSTGVFOTVkMlpSWjVy?=
 =?utf-8?B?ZnpNWTd2R2Y2cnFZVDU2VlJaOVdIMS9PSkFySXZNZUtNRWlRWmh2amhLZlBq?=
 =?utf-8?B?U1lOUWdkVVFoVy94RWF2RTIzLzYzbGFaTXFmLytqYjRwUFJCNndaWk9uYTNK?=
 =?utf-8?B?ZURlZUNhZlZlbHBuNWlCYTRTdVBsQVVFMVdMVlN4THFXY0ZrWFVydE44aVhJ?=
 =?utf-8?B?QmdZUXBVcHlQeDhaNWlOVGpodWppZlZUM2xVaHh2aXEraXVOc0tvNzRrSW5K?=
 =?utf-8?B?ei9YWnhEMENBSHF3SktKVUhUejFHMzZLczB0UkdNZkhqeDNnZ292d0dZV2Qy?=
 =?utf-8?B?d0VYR1RBMjh2OTN5MmZtZ2tDMHFGTzNQa2hjbnI2YzM2MXhDbkNReU11VGdW?=
 =?utf-8?B?ZDBuKzRRc25zM09DYzFBbzk1cXAvaTc2aDhCV1owVDRnSW1CSmQxS2tuYmdX?=
 =?utf-8?B?RytqaVZxZlRXZXVNSXZKMm0yN3h5YXRRWnJZcnZLVEdHRzlPaWp6N3FXQXM5?=
 =?utf-8?B?UXFiNEZYVU9iWnlFSUc1dm83UFdlTWIxYXo4dm9kL1VOTmFDa2JsdGptN3py?=
 =?utf-8?B?MDZESG5kZ2NaTWRIbklrcE51SGNPSjBYbHhseHRkeUZJQnNuSWJYQkdwOSs5?=
 =?utf-8?B?Y2lGVlNFYTBhQURUdXRwanVwRkxQTGlSTm8rdU5oWUJZRXR0MWZMZE1MM0ZF?=
 =?utf-8?B?RmlTMmlNM1ZlZUI5dmxKTldIb2gwZmk0RXNvNUZuKzVwVENZbmF5Z3Fkc3Jq?=
 =?utf-8?B?b2tpOHpNWjIwOG9JVE1YSm5MZW95andvMzExSEVHVGFOUFNPY2xaK3VzVTVQ?=
 =?utf-8?B?d2JTVEwrLzhvd2trYy9KUUZnWDZaVW9aeTdKdUIxWlh1Ynl1MDZieWV6Umxz?=
 =?utf-8?B?c1RXK2Y2RUNvUVgxRjVyL3FkMEQybTV5YUlXMzF5NnBRQUdzRm1BTUl5NnVT?=
 =?utf-8?B?d0dJb3lyZkZYWjM4R2QvMnBabVpKbWUzTThsMTJVc2RGc044eHJlMlJIb1JG?=
 =?utf-8?B?a0RSRFYwcHRwQUFWMFZqLzZic1BPQXp4UEZXeDhINnJQRmpWMjJOMzRGcXUx?=
 =?utf-8?B?T1ZXVWRGc0JITzlmYUtIME5hcXBmVlRHV00xWnRyV0NuUzNyNC9YdEd4a1RQ?=
 =?utf-8?B?SnN4aTVuTkl5OG1GcnVFdEpkYUkyaG5jM0tiUTFzSVR1VGRRa3NsSGYrams4?=
 =?utf-8?B?dXFPOUk5SThOVm1kVG1YSytiNWk2NlZHZEhUUkF6NG1STGpjdFBBanhyb0R2?=
 =?utf-8?B?V25idnNYb2RVVDNpU3MwMUR0MVRaVk96eFZxaUdmUktybzYzY3kxYkdVelpi?=
 =?utf-8?B?ZWZpSXpEdUJ6b0ZiMTlwelB2Q1F0aVRYUWF2Ni94dkhNYTZNVHd2ZUg5M1Rx?=
 =?utf-8?B?WnVnWVBvL25icVdiYU5TcjNRUUhFanh4VG9NemZQZUNtb0w5Y3VHSytoZDBD?=
 =?utf-8?B?UEJuY29wT1B1RDVYQXRjT1lQM1RXMXU2SkNLcWZtdHppalBFTmtkZFcrMUxI?=
 =?utf-8?B?L0N3dG1nTFBJVFpqNVlCbnVlNm5UL0lNUUpkOXhvZnY0RXRYNjI2em4zbXpJ?=
 =?utf-8?B?bTNFYTVSNVJBNlR6SVNwZmRwblBzUnY2YzZETWsrQWQ1cFYxdUZDVXVCMzJt?=
 =?utf-8?B?QlRvZVpVcExBYTdtbklJc3YyZkRYTDg3RzhxclB4TFFxbHZ6ZmNEN1lLbU5G?=
 =?utf-8?B?RkY1czBKRVQydzZlL2JKWTI2amJ4YzRrRnZQbC8yL1JZTlFIbSswdU5NUnI0?=
 =?utf-8?B?NnVGNzI2blIrT0RiUzlIZk1YL2IwdGVLcjlTYmUrTzVhWXJWRTF6bzdMb29D?=
 =?utf-8?B?WHZVRXc3YmJPYTZJUm5TMnVWTTRadDNNc1AreDhaRG1nRVNLNi91YkNydXFG?=
 =?utf-8?Q?m5ngpkRX3lXmat8syRbMAfkHpb+P10=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(42112799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZForNUk3QkRQMGErRDhXZC9MOVFIc2haaUZWRWYrT09XZlpkMjNrRjVMRnRI?=
 =?utf-8?B?ZmhYUHBwYTYwdzJOZWdDTExDM2VsQTlKQ015NHlxQ080dW94OFdhRzRESmlW?=
 =?utf-8?B?K0tzbjVHd3F2UWdzbUxxcjJwcHFCeE1ZaTRrYTlMc1BCQk9reTZvWVR3TW42?=
 =?utf-8?B?S3ZWRzJ3OWNicXJkMm9SKzlzcDE3SWVJTmpHTDRsU3hwdVBYVE5SNmxDVlc5?=
 =?utf-8?B?VHNwb2VrQkw2QUVPWVhyQWxicitaZ0FlTS9SWlhOc0pYcTdvRUpndWNPT05D?=
 =?utf-8?B?MlhMRDRMaDkveDdyMWxZK243N2l4cHBWbTBWT0RGSDV5OFNWbUxQMGZySUtl?=
 =?utf-8?B?WEhFcFpaZjJ5dlVvK1I4bzVkM1h5UEJ5VFJDRWkwakpzOUY1dVZVblJ5LzJT?=
 =?utf-8?B?M3NDVGZSRnQyU0dvT1lPTktLVU9yU0tJdmFjdFdwQTJRaDkxMHVSR1c2MVo0?=
 =?utf-8?B?THQ2TktBdDlJUUFEUWFOSXBTZk5PM21KZVZJNjVWU09jSGpoN1dqbTRHS09Z?=
 =?utf-8?B?d2FxQlRiM0I4T1Z1WXNqdWZCbVdpTjN2bW1YNzN1Rk40c2VFWDkzY0V0ZkNY?=
 =?utf-8?B?ekM5WG9GbjNOZGtIUmMyTjlYeS9iVHhkSjdEUUtrRkRjM0Y0NGlSTk1SVUZH?=
 =?utf-8?B?Rmg0bVBwUnlVekc5L1pPRmRaTHJSZWJRUTBwdm1UY0d6L3F0LzJ0ZjlaVmxm?=
 =?utf-8?B?TzRhSFhQQTJSMW82US9TK3FPSXlTcnVnNm1rN3ZDQzA5c3B4NHpqb1lQbkty?=
 =?utf-8?B?Nm04QmlRWU5VQzZoRnpHUXJDKzU0cUV3c3Jab1lZOVREL21yZWE0MDNZdU16?=
 =?utf-8?B?Wm5ZemJrSjA0WDhWbmp1L1JNMmFiMTZwclVjbUVwbCtZd3h2OFhacjRWdEor?=
 =?utf-8?B?clM5TTNuYVczUVpoVWlRektvYnYzcndkSHM4dzNOb05oOHgxamlRM08zMUp5?=
 =?utf-8?B?cE9TdlZncVh3cytyYUk0MXdNdk9lTmRpcjIzZFpsSnlRRTVjOUViOW85TStX?=
 =?utf-8?B?MGtHN00wa2tneW9aVmRVaXlQZThGc0NoMFBVdEtpaXB1b2dzVnlKRDBycnFj?=
 =?utf-8?B?ZnBsTWFVWTJ1NVBKOTBmbjdUc3VQYkFMRGtIdnJYVWNqWm9BeCtBT3JzMlJO?=
 =?utf-8?B?YUxCanFaRGNCRTBvd1E4elk3aVdOaGgyWTlxczAxMkRFcUhSNWVnVHl6bVRl?=
 =?utf-8?B?ZmFnUHN1UHhaY3ZKY0ZvQXJNaWVJdHgzSithNmY4cXRobXp6N0c4c2VocnBY?=
 =?utf-8?B?TnJ2eGhsVGwxV0Vwc2FhTkNhK2E2bFd3TjcrV2RHRTM5RThWSy9XeGFGTkxj?=
 =?utf-8?B?VDhtaXV5YTRhNEdDSy9LTmV2cm1Fb1FZWDhwSDBWN2NGQ2JHVnYzV1BIcnht?=
 =?utf-8?B?NVA3SnFWSHdGeHpKdkhDd05nSy9qeUZBL0diVWZXKzVpNjhFbUJ3RXAxRG82?=
 =?utf-8?B?c3VaWkk1WXBRcEpRcG52bTlCaVJHc05oeWhkRXg0WFlqTFR4ekhOcU1oR2xr?=
 =?utf-8?B?UlEyOFlsRVhHN3pLcDEyY0NySXByUHR2YmUzdzhzOXQvM1FkdmUxdlc2YnNk?=
 =?utf-8?B?YkUwaXRNcm5CK3hyZUxKcDNXOVRVNzZLTWE3NmdZcktMNUJ6YUEyN0lVZ0NN?=
 =?utf-8?B?OFZjRkV2bGdxakFsL2F3TXF5Mld5VXdpSTk1ak9zVmY3RWZ5U0ZDdUllWUdy?=
 =?utf-8?B?dXpjS0VYQXBCSW1ER0tIaUNUbVRuZG5aSFhhS1ZCVXlJWDdDc0lzd1A5T0hy?=
 =?utf-8?B?T1V2Z3hMb3dFcWRQNGV5c2hndjVVOG9FNmE1SDZvQ1BLcHRHOC9lcEw0bW41?=
 =?utf-8?B?amlkK0VienZuNkdFMmoxcXBvK2hZenR1a1VhTmQwbXloNElZRHVSZzZjUkVT?=
 =?utf-8?B?TTZDMXNDa01RK2lmWEI0VW5wMXdJakZWZzdCanVoQ0JUOUxrK2hEeWpibi9G?=
 =?utf-8?B?N0gwL1ZDOFdUT0YrRWNBUDJOcjZ4Rk5QN2NJK1hzMGg5c0dkRkdrcnpTMDZw?=
 =?utf-8?B?aGFVbGE3aW83SzEvd0dxUkIyUm5oVEl6QnFDbFhYSjcvVDloaDFaWWVOdjFE?=
 =?utf-8?B?aWp2NFdqY1R3MlBxZ2g0VkF5ejRmTXlYd0hSQlJ0c05kajhGTnY5eFgwSGU2?=
 =?utf-8?Q?9qYptJnesy8vWbRhyJL9uaT0I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A68A5969A2BE942B623904F046B4835@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a6f2a5-eb7e-48d9-aa8b-08ddf00ab4d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 01:38:13.0347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMHAMNgFSJaNXrO7xtbqurjhVugVEunZoJ4sL9irzbOU5rVp7u/KX0Pty+KSYYaItqpejwDDhQBtfQaTeUz4Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7612

T24gRnJpLCAyMDI1LTA4LTI5IGF0IDExOjAzICswMjAwLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQu
DQo+IA0KPiANCj4gVGhlIHBsYXRmb3JtIGFuZCBkcm0gZGV2aWNlcyBhcmUgb25seSB1c2VkIHRv
IGxvb2sgdXAgdGhlIGRybSBkZXZpY2UgYW5kDQo+IGl0cyBkcml2ZXIgZGF0YSByZXNwZWN0aXZl
bHkgd2hlbiBpbml0aWFsaXNpbmcgdGhlIGRyaXZlciBkYXRhIGR1cmluZw0KPiBiaW5kKCkuDQo+
IA0KPiBEcm9wIHRoZSByZWZlcmVuY2UgY291bnRzIGFzIHNvb24gYXMgdGhleSBoYXZlIGJlZW4g
dXNlZCB0byBtYWtlIHRoZQ0KPiBjb2RlIG1vcmUgcmVhZGFibGUuDQo+IA0KPiBOb3RlIHRoYXQg
dGhlIGNydGMgY291bnQgaXMgbmV2ZXIgaW5jcmVtZW50ZWQgb24gbG9va3VwIGZhaWx1cmVzLg0K
DQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSm9oYW4gSG92b2xkIDxqb2hhbkBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIHwgMTIgKysrKy0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gaW5kZXggM2IwMmVkMGExNmRhLi4z
M2I4MzU3NmFmN2UgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5j
DQo+IEBAIC0zOTUsMTIgKzM5NSwxNCBAQCBzdGF0aWMgYm9vbCBtdGtfZHJtX2dldF9hbGxfZHJt
X3ByaXYoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjb250
aW51ZTsNCj4gDQo+ICAgICAgICAgICAgICAgICBkcm1fZGV2ID0gZGV2aWNlX2ZpbmRfY2hpbGQo
JnBkZXYtPmRldiwgTlVMTCwgbXRrX2RybV9tYXRjaCk7DQo+ICsgICAgICAgICAgICAgICBwdXRf
ZGV2aWNlKCZwZGV2LT5kZXYpOw0KPiAgICAgICAgICAgICAgICAgaWYgKCFkcm1fZGV2KQ0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG5leHRfcHV0X2RldmljZV9wZGV2X2RldjsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+IA0KPiAgICAgICAgICAgICAgICAg
dGVtcF9kcm1fcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShkcm1fZGV2KTsNCj4gKyAgICAgICAgICAg
ICAgIHB1dF9kZXZpY2UoZHJtX2Rldik7DQo+ICAgICAgICAgICAgICAgICBpZiAoIXRlbXBfZHJt
X3ByaXYpDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGdvdG8gbmV4dF9wdXRfZGV2aWNlX2Ry
bV9kZXY7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiANCj4gICAgICAg
ICAgICAgICAgIGlmICh0ZW1wX2RybV9wcml2LT5kYXRhLT5tYWluX2xlbikNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgYWxsX2RybV9wcml2W0NSVENfTUFJTl0gPSB0ZW1wX2RybV9wcml2Ow0K
PiBAQCAtNDEyLDEyICs0MTQsNiBAQCBzdGF0aWMgYm9vbCBtdGtfZHJtX2dldF9hbGxfZHJtX3By
aXYoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgICAgICAgICAgICAgICAgaWYgKHRlbXBfZHJtX3By
aXYtPm10a19kcm1fYm91bmQpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNudCsrOw0KPiAN
Cj4gLW5leHRfcHV0X2RldmljZV9kcm1fZGV2Og0KPiAtICAgICAgICAgICAgICAgcHV0X2Rldmlj
ZShkcm1fZGV2KTsNCj4gLQ0KPiAtbmV4dF9wdXRfZGV2aWNlX3BkZXZfZGV2Og0KPiAtICAgICAg
ICAgICAgICAgcHV0X2RldmljZSgmcGRldi0+ZGV2KTsNCj4gLQ0KPiAgICAgICAgICAgICAgICAg
aWYgKGNudCA9PSBNQVhfQ1JUQykgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBvZl9ub2Rl
X3B1dChub2RlKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+IC0tDQo+IDIu
NDkuMQ0KPiANCg0K

