Return-Path: <linux-kernel+bounces-813065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A70B7B54059
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3601B289A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2401DE3CA;
	Fri, 12 Sep 2025 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QReksqy2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="k1+8Ebk4"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF732A1BA;
	Fri, 12 Sep 2025 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644075; cv=fail; b=LzX0swmjNtPDG6dA9CENIurlXd13jXJTMZ5LH5w2L7wryfyhx1Jv3WhXuE1jl4nGaLxSLR8EhP5B+1mKXeo1f4izrBqfC9HWDdTxmus1gNROtvu5aqAZEUmkKrAT7fJQQVo79tGKGTvsnNyGZh+6/0ykQ4I69SpivzQufsZuN/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644075; c=relaxed/simple;
	bh=iD6JY2V7HOvc33lLW+4ecz/wXWf9JmzCg8aeas5vZXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gYMkqSNyHQRJQWuMZuQyTviDZuEnIPesJxA5g8rRHrA0upsePG/B32OW6kP38UjzIfZTziNa6DDjmKHPlM/h2W86Z24RjVmxVX++nC16r5VQlrwgi0KxIB4HnFZf9NX2TytjyrlmNSRQJM1Z5fSZeqQrkUJqUxtqh8lPmcz3mfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QReksqy2; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=k1+8Ebk4; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 12ce5f2c8f8011f0bd5779446731db89-20250912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=iD6JY2V7HOvc33lLW+4ecz/wXWf9JmzCg8aeas5vZXk=;
	b=QReksqy2U7r1Kc92OIjQbs3O/cg+EI2YTfUaIZyrgJ4U1j8FdfXUx5kBAzQe6xYKd01W2b+yfq3GZ0NORL+9ynFqbiCP+LgTwcdjxrKsakGYWvelxdjJFHk5vi3C8El8HdlXtE2ef59eQq8Qin1rlz98D7v6Rm/QSJhYLc8HRO8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:061a2b8e-0fe8-4fac-b086-d1cd2b5b8ea1,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:605e776c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 12ce5f2c8f8011f0bd5779446731db89-20250912
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 879580498; Fri, 12 Sep 2025 10:27:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 12 Sep 2025 10:27:44 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 12 Sep 2025 10:27:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/sXjxYqtEwZufiOAfg7uxDcieaQ3Uwn5lvUNfqwZRgJdeyHcbHZH57k3e30CMglsWhOi6NaNJ78+pq0ZbQMatpWtOef4ID+YWNPu46fJ5YrGzgICjGXAWrgZ4tVuDtuzAWe2GM1V5xFNgnXGR9c8w81T7BXy1wpb38930Js6ltzkBRJ/NZkr+btHvxko1N/YpVUkoo18YJXpz6WDjKQ9jyik5yGo/EJx7DJLuxwPfPGsZHFOXcxLpWx+9WHbiWLUvhjgsGDfZVIlLZsaT/f1uBM209fHYhiqU/7FklfGi/I+TsOcY7txYezKxebKVIP0tTzd5N6iQNC8Lnx5r9XHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD6JY2V7HOvc33lLW+4ecz/wXWf9JmzCg8aeas5vZXk=;
 b=ukMPjw/X7ECCPM0hfp6eemiBYBOL3kjEvn6E3bjKNk/4aNXmcfAG7Uljk10a51Jz2THUA8Jrz0qEyKVAiITl2fHOw1M5aIsiiCo/h0zrELFb2sG/DRjUuZay19Rhg4pIMGurLiauP0enAz+kY9TUCGrbPJ1U1YyRSZ3IDpqGw3s0mrATGSaFwYWxwBvJVx4yzMCH49ag0PkV4exc8dLRvvoi/dm9fS11diTqNVSKZ+HzHiCq3E2Av2g1Q+pxwtGNoksYQYt7IwkTNsnC//GGOcM8m3RgVAMfy7KRvZLNWb9gjAKaomnPOJsUZS85IMIetWj5dTIGHCEpt/ONXb1sEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD6JY2V7HOvc33lLW+4ecz/wXWf9JmzCg8aeas5vZXk=;
 b=k1+8Ebk4ys1O3bC8tMDDA5ZH/Q8L8jiDOgOFqgCaMzWVmrbN+E8YQqs6MpHI//OUOwHEY6SemOltBzQ3IyGfv+vECGcKyHAnSuW5fR5DDk7CUZsV6gwWWzy+IhVylkQGtgBzG4OTvYBNAaDz8jU9i3KfKQ/flhoHNbqqLFOg0vw=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PS1PPF172F628C4.apcprd03.prod.outlook.com (2603:1096:308::2c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 02:27:41 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 02:27:41 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, =?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?=
	<Paul-pl.Chen@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: =?utf-8?B?U3VubnkgU2hlbiAo5rKI5aeN5aeNKQ==?= <Sunny.Shen@mediatek.com>,
	=?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	=?utf-8?B?WGlhbmRvbmcgV2FuZyAo546L5YWI5YasKQ==?=
	<Xiandong.Wang@mediatek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"fshao@chromium.org" <fshao@chromium.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "treapking@chromium.org" <treapking@chromium.org>
Subject: Re: [PATCH v4 15/19] drm/mediatek: add BLENDER support for MT8196
Thread-Topic: [PATCH v4 15/19] drm/mediatek: add BLENDER support for MT8196
Thread-Index: AQHcF/NAXa5BFhmqhE6icHacGeZMqLSO6bmA
Date: Fri, 12 Sep 2025 02:27:41 +0000
Message-ID: <41974a26982bf441230ba49f9c8c5ba21cf1336c.camel@mediatek.com>
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
	 <20250828080855.3502514-16-paul-pl.chen@mediatek.com>
In-Reply-To: <20250828080855.3502514-16-paul-pl.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PS1PPF172F628C4:EE_
x-ms-office365-filtering-correlation-id: 8ca68a5b-e404-4f35-7d69-08ddf1a3f325
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|42112799006|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NzlCRVFqTmNLWmlFTHlMdzVkbEJGbml2QlZLcHd6aTlXZ0xhNC9qaUpudkFx?=
 =?utf-8?B?N3dhTWdLa3dvYlhPT2lNcEp1aWJpOTFraWwwc25mRHlWa3VTT211b3FoVitv?=
 =?utf-8?B?cUZaRHF5eHlJVFAvR0dsNDZCWjYwREF6N3RNQVh4OWl6YnVqdEZoYVkrTVJI?=
 =?utf-8?B?WGRJbFd5UTAwK1F3eG1WQlNNa1l5Y1N1QnJCb2t1bVdyUDVHbThSMTJHWU50?=
 =?utf-8?B?ZWN6YW0rZTJXSWFKbWxoOW5KbGg5VW5TVHhxVGtka1cwTGpKQXo4N2MyMmlj?=
 =?utf-8?B?UVZWeFk0NVhwYzNQTUpnalNLU25jUG42TFVUcURZZU9qOUxUOGlTdnJWSjkz?=
 =?utf-8?B?SEtoTE5qRm56VHJlVXBFQ1JmaUNhV1Zjd3o4TEpBUkRBS2diaWEwbEptcmtq?=
 =?utf-8?B?Mnh0VEFiZE05RmNhdnJ2STYycityKzVWYWRhVUMzRHRvU2xUbCtCQkVlb2pu?=
 =?utf-8?B?ekpmMWdJUGs2SThicGk5WVJHNE53Um5YUUJna1IvSkxJK1RCR0loRHhvQ2hF?=
 =?utf-8?B?eXdGakZacWk5bEpsNWdOSU5hMit1dDZRSmx0R1Vhc252c2dWR3RwaUlBRnVL?=
 =?utf-8?B?NXNPMFFEa3NoRVc0M1N0Mm9tOFFtNDJCMkROc3BqTmEySTZsQStuZlczaFJ6?=
 =?utf-8?B?V0hXbEdBbkJCYTZ1Z3lyOHZyMEREMDEwdGd0UzMrL0IwbmRuNUhGMnorZjFN?=
 =?utf-8?B?Q01tbCttYkRFTUZkcnZIU3hmUkdwWEFSQU1MbllueHBpcDd1ZG5QNDdIM2Jx?=
 =?utf-8?B?WFJDR1dsSTNaa2FwbVJYVk5OK1JxeDBiNVErRCtpUlJMNWN4SmR6ZWkzd0s5?=
 =?utf-8?B?TDdIQjZQcEVod2dJbk9Vd0RwNUFqMW1tMEVnK1F6bXRVdUJwaEdSK2svNEww?=
 =?utf-8?B?cVNnUC83c3BCRjJTM2NJaG96OG1wMSt3aWR3eTRwR0FvTmhJS09xcnNBRDYw?=
 =?utf-8?B?QlZjYzlkN2VuYjhSR2J2Z3BlR0RhbFk3aXYyemE4RDMraDRKVUVCUG9yVis2?=
 =?utf-8?B?TXNrNzFZU3ZHNUpOVytCbnM4UXpud2JPQ2dBZTRPalVRSXFjUUhYbFBWczEz?=
 =?utf-8?B?bnRhNnJiN21nTFBYeGovWUVySEZCVTdJbUR5aXhqQzd0Y3JBY2VpK3IyM3JU?=
 =?utf-8?B?akpYdmswdmxpdzgrc1Z3VVFaOEZQN1RHTVY0TGg1Sy80Vy84UTB3cjFlYmND?=
 =?utf-8?B?NnZubzFoQWtzOEZVSHp6TkJFdTRrTHhHZjh6Y3h0OUNNVHpMMzVxREtVSXEr?=
 =?utf-8?B?VzVyRFZpK042ZTJDdS92dWQ1RFNFdHFyZnRZY09FYkwybWJzdnhVTmZ1REpY?=
 =?utf-8?B?eUIrY09aWHRzODVoVENpcjBSUDlWcGtYRENKdDVZZHNhZFlRZDJOLzltSy8w?=
 =?utf-8?B?SiswbHVzTXpVejYybmRJVTdsMWxMa3dpQTdtcVQ0dUIvbTduK054bzZ6SkhN?=
 =?utf-8?B?ejkvQzViTEF6dGtYZjY0LzY2QmFxNEVRdjVOOEhyamJOdVMwU2ZFRUtmOTgw?=
 =?utf-8?B?SDl2RFVtZjduc1dPSG5MS2pGOWc2WVBsaVF1VVNpVStlbUZ4bDViaHJGM2lL?=
 =?utf-8?B?TmozMHNQNVJ2QjBOblhJR1o2WFBIY21OdG5iRlMrbDV2aFFEUFUxZFhTWHBO?=
 =?utf-8?B?cjVKdUFMYVZ1OXFmZ0NLZmVkUURPSXdCMUNWSW0zNEwySVRwbUVnY29jOW84?=
 =?utf-8?B?VmoyZjFjMXNuU0VkYm1tNkpqN1NzZmNOOEtjN1FkdE1tMkdiR1NIbHB0SlpO?=
 =?utf-8?B?NFJDb1o2NVF0bUlscVdkVGRKdHRyZ2o1aXBhNS9tcEw2K081SytER3VGTHpZ?=
 =?utf-8?B?QW56UmJvQVp4V2VyTmVSUC9lem1oU1NBTHR2emdZU001VDg1V1FmQU5jUk5T?=
 =?utf-8?B?NSswTWJDbUxTM1cwNStiNWpteDExcmtRVnFNVWFpMi93Qk4xRG4xYU10Um9j?=
 =?utf-8?B?TEo3azRvcExGUmdFUENrcFI3Y3NCaHRyMjVvNVhNazl6NXRpRmlxOTJFalZP?=
 =?utf-8?Q?jqYfaYyOGzVLlD4C7SHAE6eyfh9Euw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(42112799006)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXdBUmZPVWhnVDBodWNMQzZ1MVd2NW52alZzdDJhbTEyaWZlSFdDbzJuT1dT?=
 =?utf-8?B?bmNRUDVoNGdnejliNjNBOU9TOHhqaFdkNy9YdkZnUndxWFNQdnVsN2ZyUGlu?=
 =?utf-8?B?aDBNVzRJZDlwME5jT2N3Z29uY0tNb3gzVDd5THo5UzhNVTJ6dlowU3JTY1ZX?=
 =?utf-8?B?SmxIV0twMldQQ0RDWDVqcE5vQ3NCOFo4Y1pqaWpHY2hsTVQxWTJ6d1RxUkFz?=
 =?utf-8?B?ZWpGVjUrY2JzcU1JaTNnZ212MTNYNUF6QWw5TDlOWFdOa3dpb0IwQkVvRUZP?=
 =?utf-8?B?bzhOSnZaUU9lUGlUc1JNSlBIOVcrSjVUMCthWStIK2RxMU1wRHFNQ2xjWlcr?=
 =?utf-8?B?VUFNNnJNVlhUSDBETzJ3eFAzc2lFVXlodW02blVzZDRRb1B6V3J2anFiN09K?=
 =?utf-8?B?dDdnelFwbUVOeFhEdXZVN3V2azc4TTMyeDl1NUk3MVpUWlYvOE83ZnkxaVpP?=
 =?utf-8?B?c2d3NlAyZTAzUy9FUTUxaXJJQzdMbXZYZ2gvdHhLdld0clczdWlMVUp0Nnk4?=
 =?utf-8?B?bDdXOUhaaWw4V01HNDZRQVlEVVZPKzAvSFUvOWh0OUxxZVVmd2NGbFZHaTJ5?=
 =?utf-8?B?V1RpZEZocHhic0tWcm9TcGdTNEcySHZqNHo2cUdoQWpmbGNpZXhQZW4yY3Fq?=
 =?utf-8?B?UnB4Z2hyK2tqU0dRdjJFRi9ZdDlwcjFYbWxjWTY3bVhMdkZBMnZxOHIzcmh5?=
 =?utf-8?B?RFVoTEtwcnd2OSs5clBvaWxaNzBORmh0TnBnTXhyZzI1ZlYyakh4eVBKdUFs?=
 =?utf-8?B?K3YzRmdBS0lhVG5DNko3L3VBWFp3MVA5ZFVvTW9mdEVwbnpQQkY0YjFYQjBw?=
 =?utf-8?B?eU5lN2dNZG5WOWNhdG5NU3hEYTE3aEJ1ZHlCMDVNaitvbE9SQWg5NmtRTDZq?=
 =?utf-8?B?QUlBQmh6REFzOURFYjR3ZnRTV3VpYlFCUFJWWnJ1bE1OVEE3QUUveGhDMXVZ?=
 =?utf-8?B?ekxURFNvWE9uVVFGNjFxVDQ2eGs4RGVwTHBqVXJjKyswUzlOcmFrTmhqNFov?=
 =?utf-8?B?WVdmQWdPbGo2TnNkVitmN0ZEekpvQTBVVmFyRXZBdzljYkhtallNYkFLV1Ez?=
 =?utf-8?B?NlpCUkY5eU9aeEgwMUVrYXEvR3ZvZlplK0p6VGN5R1gxTlloK3Y3Y1Y5bHp1?=
 =?utf-8?B?aTB3TDA1RmNCVnNKZGxxU012VTc5d1dQcWNUbVlxMzJtSjFTSmdYaDJjaitG?=
 =?utf-8?B?REsveFVwVnMwMGxNVXZYVHhScEJwSkI1bEhQcExyMGFuWS9VMnZpZnFZS0h1?=
 =?utf-8?B?WS9maXl0dDJlVlNuckdBQTBoSnZaVHE2QWdGRXFCRGptTFZmNmgwcTdSTU82?=
 =?utf-8?B?RFVMTW9vNHJpclBYakdDRXhHNG96a0pMbS9EMTZKd3RzaXZJZ1F1OFZ5Vnpw?=
 =?utf-8?B?K3M4eU1zNGIvZ01OTWJ1ZzJMd3FrbnlJSkJ3Uk1HZE9kd1JxT1BaOFlIWWtI?=
 =?utf-8?B?SWxuRExrV0huV0NCMWtPWi83VU9UcVlrOHN6UExlaTk2YzUrTEZYNHpsQzlq?=
 =?utf-8?B?Rlk1R0o0RzZZM3FRUVI2bGhiRzdNWFBldEMwQ0V1OW9KTXBTdmZ0S202NHhs?=
 =?utf-8?B?VXJZY2hLY0dqRjVWOTdEa2lqaXJGR2xmb3E4Z1hWSVIyT09XV1RNT3NQMDFV?=
 =?utf-8?B?eVhBTUJ2Z09sQnlhbEhQelRqZ3lNcWltS2pOWkh0RFg0aWZHWW1HQUI4eWlL?=
 =?utf-8?B?V1VFdEpoMmhoQnpwc0haYUxqd29iY096eUhtL0NBSmxPRmNVcFYxdXlFTWRZ?=
 =?utf-8?B?b1ZIaFo1c0g4YzVYRndmMmszVW5TVncvRGJITTBvbnJPZDAyWGt5c3UvaGpy?=
 =?utf-8?B?dnNMZ3lLUzZ6R0NCNzZweG5TSzVUOVFtU216Z0tOVTY5MU1RZjNaOFlWNTJh?=
 =?utf-8?B?SkY0dEozcnBwWnFTMVQyd1hhbGtEQ1prNnZKSkJVamlwOFBCakc2d2ppdEZa?=
 =?utf-8?B?TmxrRVBpUkR0NHkvWHVkMFZHQ3NUZUZBaFFUNzVYZVhaM2FjYVFBbXJnM3Vz?=
 =?utf-8?B?dXJzcThGdlNjL3AvOW1BSEhEMlZjYjV2bzJNTVVmUU9JTHo5MjBGd0N0bFc2?=
 =?utf-8?B?aXh3bmRocklwV01Ha3hQUGQ3YXk2L0xGTUJjRy9KcTB3SW9oblVzbHVoTzJH?=
 =?utf-8?Q?uheeBMjMSj88h0Dqpbe9K2yKy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DBB0B9C8CF45A48AB4ED64A6047F619@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca68a5b-e404-4f35-7d69-08ddf1a3f325
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 02:27:41.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +0Yl/cZo5BZrdLI+vJjlSA6KAop9NwdVHtiapoifxvWW/aaTK726HB+U/ukCgPdvgaCloLnQWHZbVlZAyqF7zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF172F628C4

T24gVGh1LCAyMDI1LTA4LTI4IGF0IDE2OjA3ICswODAwLCBQYXVsIENoZW4gd3JvdGU6DQo+IEZy
b206IE5hbmN5IExpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gDQo+IEJMRU5ERVIgZXhl
Y3V0ZXMgdGhlIGFscGhhIGJsZW5kaW5nIGZ1bmN0aW9uIGZvciBvdmVybGFwcGluZw0KPiBsYXll
cnMgZnJvbSBkaWZmZXJlbnQgc291cmNlcywgd2hpY2ggaXMgdGhlIHByaW1hcnkgZnVuY3Rpb24N
Cj4gb2YgdGhlIG92ZXJsYXBwaW5nIHN5c3RlbS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5hbmN5
IExpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGF1bC1wbCBD
aGVuIDxwYXVsLXBsLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCg0KW3NuaXBdDQoNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9ibGVuZGVyLmMgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfYmxlbmRlci5jDQo+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uOTIxMmQyZTE5Y2E3DQo+IC0tLSAvZGV2
L251bGwNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2JsZW5kZXIu
Yw0KPiBAQCAtMCwwICsxLDI3NCBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAtb25seQ0KPiArLyoNCj4gKyAqIENvcHlyaWdodCAoYykgMjAyNSBNZWRpYVRlayBJbmMu
DQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgPGRybS9kcm1fZm91cmNjLmg+DQo+ICsjaW5jbHVk
ZSA8ZHJtL2RybV9ibGVuZC5oPg0KDQpBbHBoYWJldGljIG9yZGVyLg0KDQo+ICsjaW5jbHVkZSA8
ZHJtL2RybV9mcmFtZWJ1ZmZlci5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiArI2lu
Y2x1ZGUgPGxpbnV4L2NvbXBvbmVudC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ICsj
aW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQoNCkFscGhhYmV0aWMgb3JkZXIuDQoNCj4gKyNp
bmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1f
ZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gKyNpbmNsdWRlIDxsaW51
eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0
ZWsvbXRrLW1tc3lzLmg+DQo+ICsNCj4gKyNpbmNsdWRlICJtdGtfY3J0Yy5oIg0KPiArI2luY2x1
ZGUgIm10a19kZHBfY29tcC5oIg0KPiArI2luY2x1ZGUgIm10a19kaXNwX2JsZW5kZXIuaCINCj4g
KyNpbmNsdWRlICJtdGtfZGlzcF9kcnYuaCINCj4gKyNpbmNsdWRlICJtdGtfZGlzcF9vdmwuaCIN
Cj4gKyNpbmNsdWRlICJtdGtfZHJtX2Rydi5oIg0KPiArDQo+ICsjZGVmaW5lIERJU1BfUkVHX09W
TF9CTERfREFUQVBBVEhfQ09OCQkJMHgwMTANCj4gKyNkZWZpbmUgT1ZMX0JMRF9CR0NMUl9JTl9T
RUwJCQkJCUJJVCgwKQ0KPiArI2RlZmluZSBPVkxfQkxEX0JHQ0xSX09VVF9UT19QUk9DCQkJCUJJ
VCg0KQ0KPiArI2RlZmluZSBPVkxfQkxEX0JHQ0xSX09VVF9UT19ORVhUX0xBWUVSCQkJCUJJVCg1
KQ0KPiArI2RlZmluZSBESVNQX1JFR19PVkxfQkxEX0VOCQkJCTB4MDIwDQo+ICsjZGVmaW5lIE9W
TF9CTERfRU4JCQkJCQlCSVQoMCkNCj4gKyNkZWZpbmUgT1ZMX0JMRF9GT1JDRV9SRUxBWV9NT0RF
CQkJCUJJVCg0KQ0KPiArI2RlZmluZSBPVkxfQkxEX1JFTEFZX01PREUJCQkJCUJJVCg1KQ0KPiAr
I2RlZmluZSBESVNQX1JFR19PVkxfQkxEX1JTVAkJCQkweDAyNA0KPiArI2RlZmluZSBPVkxfQkxE
X1JTVAkJCQkJCUJJVCgwKQ0KPiArI2RlZmluZSBESVNQX1JFR19PVkxfQkxEX1NIQURPV19DVFJM
CQkJMHgwMjgNCj4gKyNkZWZpbmUgT1ZMX0JMRF9CWVBBU1NfU0hBRE9XCQkJCQlCSVQoMikNCj4g
KyNkZWZpbmUgRElTUF9SRUdfT1ZMX0JMRF9CR0NMUl9CQUxDSwkJCTB4ZmYwMDAwMDANCg0KTW92
ZSB0aGlzIGFmdGVyIERJU1BfUkVHX09WTF9CTERfQkdDTFJfQ0xSLCBhbmQgdGhpcyBuYW1lIGhh
cyB0eXBvLg0KSXQgc2hvdWxkIGJlIERJU1BfUkVHX09WTF9CTERfQkdDTFJfQkxBQ0sNCg0KPiAr
I2RlZmluZSBESVNQX1JFR19PVkxfQkxEX1JPSV9TSVpFCQkJMHgwMzANCj4gKyNkZWZpbmUgRElT
UF9SRUdfT1ZMX0JMRF9MX0VOCQkJCTB4MDQwDQo+ICsjZGVmaW5lIE9WTF9CTERfTF9FTgkJCQkJ
CUJJVCgwKQ0KPiArI2RlZmluZSBESVNQX1JFR19PVkxfQkxEX09GRlNFVAkJCQkweDA0NA0KPiAr
I2RlZmluZSBESVNQX1JFR19PVkxfQkxEX1NSQ19TSVpFCQkJMHgwNDgNCj4gKyNkZWZpbmUgRElT
UF9SRUdfT1ZMX0JMRF9MMF9DTFJGTVQJCQkweDA1MA0KPiArI2RlZmluZSBPVkxfQkxEX0NPTl9G
TERfQ0xSRk1UCQkJCQlHRU5NQVNLKDMsIDApDQo+ICsjZGVmaW5lIE9WTF9CTERfQ09OX0NMUkZN
VF9NQU4JCQkJCUJJVCg0KQ0KPiArI2RlZmluZSBPVkxfQkxEX0NPTl9GTERfQ0xSRk1UX05CCQkJ
CUdFTk1BU0soOSwgOCkNCj4gKyNkZWZpbmUgT1ZMX0JMRF9DT05fQ0xSRk1UX05CXzEwX0JJVAkJ
CQlCSVQoOCkNCj4gKyNkZWZpbmUgT1ZMX0JMRF9DT05fQllURV9TV0FQCQkJCQlCSVQoMTYpDQo+
ICsjZGVmaW5lIE9WTF9CTERfQ09OX1JHQl9TV0FQCQkJCQlCSVQoMTcpDQo+ICsjZGVmaW5lIERJ
U1BfUkVHX09WTF9CTERfQkdDTFJfQ0xSCQkJMHgxMDQNCj4gKyNkZWZpbmUgRElTUF9SRUdfT1ZM
X0JMRF9MX0NPTjIJCQkJMHgyMDANCj4gKyNkZWZpbmUgT1ZMX0JMRF9MX0FMUEhBCQkJCQkJR0VO
TUFTSyg3LCAwKQ0KPiArI2RlZmluZSBPVkxfQkxEX0xfQUxQSEFfRU4JCQkJCUJJVCgxMikNCj4g
KyNkZWZpbmUgRElTUF9SRUdfT1ZMX0JMRF9MMF9BTFBIQV9TRUwJCQkweDIwOA0KPiArI2RlZmlu
ZSBPVkxfQkxEX0wwX0NPTlNUCQkJCQlCSVQoMjQpDQo+ICsjZGVmaW5lIERJU1BfUkVHX09WTF9C
TERfTDBfQ0xSCQkJCTB4MjBjDQo+ICsjZGVmaW5lIE9WTF9CTERfQ09OX0NMUkZNVF9NQU4JCQkJ
CUJJVCg0KQ0KDQpZb3UgaGF2ZSBhbHJlYWR5IGRlZmluZSBPVkxfQkxEX0NPTl9DTFJGTVRfTUFO
LiBEcm9wIHRoaXMgb25lLg0KDQo+ICsNCj4gK3N0cnVjdCBtdGtfZGlzcF9ibGVuZGVyX2RhdGEg
ew0KPiArCXVuc2lnbmVkIGludCBtYXhfc2l6ZTsNCj4gK307DQo+ICsNCj4gK3N0cnVjdCBtdGtf
ZGlzcF9ibGVuZGVyIHsNCj4gKwl2b2lkIF9faW9tZW0gKnJlZ3M7DQo+ICsJc3RydWN0IGNsayAq
Y2xrOw0KPiArCXN0cnVjdCBjbWRxX2NsaWVudF9yZWcgY21kcV9yZWc7DQo+ICsJY29uc3Qgc3Ry
dWN0IG10a19kaXNwX2JsZW5kZXJfZGF0YSAqZGF0YTsNCj4gK307DQo+ICsNCj4gK3ZvaWQgbXRr
X2Rpc3BfYmxlbmRlcl9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbXRr
X3BsYW5lX3N0YXRlICpzdGF0ZSwNCj4gKwkJCQkgICBzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0
KQ0KPiArew0KPiArCXN0cnVjdCBtdGtfZGlzcF9ibGVuZGVyICpwcml2ID0gZGV2X2dldF9kcnZk
YXRhKGRldik7DQo+ICsJc3RydWN0IG10a19wbGFuZV9wZW5kaW5nX3N0YXRlICpwZW5kaW5nID0g
JnN0YXRlLT5wZW5kaW5nOw0KPiArCXUzMiBhbHBoYSwgY2xyZm10LCBpZ25vcmVfcGl4ZWxfYWxw
aGEgPSAwOw0KPiArCXUzMiBibGVuZF9tb2RlID0gbXRrX292bF9nZXRfYmxlbmRfbW9kZShzdGF0
ZSwgTVRLX09WTF9TVVBQT1JUX0JMRU5EX01PREVTKTsNCj4gKw0KPiArCWlmICghcGVuZGluZy0+
ZW5hYmxlIHx8IHBlbmRpbmctPmhlaWdodCA9PSAwIHx8IHBlbmRpbmctPndpZHRoID09IDAgfHwN
Cj4gKwkgICAgcGVuZGluZy0+eCA+IHByaXYtPmRhdGEtPm1heF9zaXplIHx8IHBlbmRpbmctPnkg
PiBwcml2LT5kYXRhLT5tYXhfc2l6ZSkgew0KPiArCQltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCAw
LCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsIERJU1BfUkVHX09WTF9CTERfTF9FTik7DQo+
ICsJCXJldHVybjsNCj4gKwl9DQo+ICsNCj4gKwltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBwZW5k
aW5nLT55IDw8IDE2IHwgcGVuZGluZy0+eCwgJnByaXYtPmNtZHFfcmVnLCBwcml2LT5yZWdzLA0K
PiArCQkgICAgICBESVNQX1JFR19PVkxfQkxEX09GRlNFVCk7DQo+ICsNCj4gKwltdGtfZGRwX3dy
aXRlKGNtZHFfcGt0LCBwZW5kaW5nLT5oZWlnaHQgPDwgMTYgfCBwZW5kaW5nLT53aWR0aCwgJnBy
aXYtPmNtZHFfcmVnLA0KPiArCQkgICAgICBwcml2LT5yZWdzLCBESVNQX1JFR19PVkxfQkxEX1NS
Q19TSVpFKTsNCj4gKw0KPiArCWNscmZtdCA9IG10a19vdmxfZm10X2NvbnZlcnQocGVuZGluZy0+
Zm9ybWF0LCBibGVuZF9tb2RlLCB0cnVlLCBmYWxzZSwgMCwNCj4gKwkJCQkgICAgIE9WTF9CTERf
Q09OX0NMUkZNVF9NQU4sIE9WTF9CTERfQ09OX0JZVEVfU1dBUCwNCj4gKwkJCQkgICAgIE9WTF9C
TERfQ09OX1JHQl9TV0FQKTsNCg0KVGhlIGJsZW5kZXIgZGF0YSBpbnB1dCBmcm9tIGV4ZG1hLg0K
ZXhkbWEgd291bGQgY29udmVydCBZVVYgZm9ybWF0IHRvIFJHQiwgc28gYmxlbmRlciB3b3VsZCBh
bHdheXMgcmVjZWl2ZSBSR0IgZm9ybWF0LCByaWdodD8NCklmIHBlbmRpbmctPmZvcm1hdCBpcyBZ
VVYsIGFuZCBzZXQgWVVWIGZvcm1hdCB0byBibGVuZGVyLCB3aGF0IGRvZXMgdGhpcyBtZWFuPw0K
DQoNCj4gKwljbHJmbXQgfD0gbXRrX292bF9pc18xMGJpdF9yZ2IocGVuZGluZy0+Zm9ybWF0KSA/
IE9WTF9CTERfQ09OX0NMUkZNVF9OQl8xMF9CSVQgOiAwOw0KPiArCW10a19kZHBfd3JpdGVfbWFz
ayhjbWRxX3BrdCwgY2xyZm10LCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsDQo+ICsJCQkg
ICBESVNQX1JFR19PVkxfQkxEX0wwX0NMUkZNVCwgT1ZMX0JMRF9DT05fQ0xSRk1UX01BTiB8DQo+
ICsJCQkgICBPVkxfQkxEX0NPTl9SR0JfU1dBUCB8ICBPVkxfQkxEX0NPTl9CWVRFX1NXQVAgfA0K
PiArCQkJICAgT1ZMX0JMRF9DT05fRkxEX0NMUkZNVCB8IE9WTF9CTERfQ09OX0ZMRF9DTFJGTVRf
TkIpOw0KDQpUaGUgbWFzayBzaG91bGQgaW5jbHVkZSBPVkxfQkxEX0NPTl9DTFJGTVRfTkJfMTBf
QklUDQoNCj4gKw0KPiArCWlmIChtdGtfb3ZsX2lzX2lnbm9yZV9waXhlbF9hbHBoYShzdGF0ZSwg
YmxlbmRfbW9kZSkpDQo+ICsJCWlnbm9yZV9waXhlbF9hbHBoYSA9IE9WTF9CTERfTDBfQ09OU1Q7
DQo+ICsJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBpZ25vcmVfcGl4ZWxfYWxwaGEsICZw
cml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywNCj4gKwkJCSAgIERJU1BfUkVHX09WTF9CTERfTDBf
QUxQSEFfU0VMLCBPVkxfQkxEX0wwX0NPTlNUKTsNCj4gKw0KPiArCWFscGhhID0gKE9WTF9CTERf
TF9BTFBIQSAmIChzdGF0ZS0+YmFzZS5hbHBoYSA+PiA4KSkgfCBPVkxfQkxEX0xfQUxQSEFfRU47
DQoNCldoeSBkbyB5b3UgYWx3YXlzIGVuYWJsZSBhbHBoYT8NCkluIG92bCBkcml2ZXIsIGl0IGRl
cGVuZCBvbiBzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEgdG8gZW5hYmxlIGFscGhh
Lg0KDQo+ICsJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBhbHBoYSwgJnByaXYtPmNtZHFf
cmVnLCBwcml2LT5yZWdzLA0KPiArCQkJICAgRElTUF9SRUdfT1ZMX0JMRF9MX0NPTjIsIE9WTF9C
TERfTF9BTFBIQV9FTiB8IE9WTF9CTERfTF9BTFBIQSk7DQo+ICsNCj4gKwltdGtfZGRwX3dyaXRl
KGNtZHFfcGt0LCBPVkxfQkxEX0xfRU4sICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywgRElT
UF9SRUdfT1ZMX0JMRF9MX0VOKTsNCj4gK30NCj4gKw0KDQpbc25pcF0NCg0KPiArc3RhdGljIGNv
bnN0IHN0cnVjdCBtdGtfZGlzcF9ibGVuZGVyX2RhdGEgbXQ4MTk2X2Rpc3BfYmxlbmRlcl9kcml2
ZXJfZGF0YSA9IHsNCj4gKwkubWF4X3NpemUgPSA4MTkxLA0KDQpSZW1vdmUgdGhpcyBTb0MgZGF0
YS4gYW5kDQoNCiNkZWZpbmUgQkxFTkRFUl9NQVhfU0laRSA4MTgxDQoNCj4gK307DQo+ICsNCj4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kaXNwX2JsZW5kZXJfZHJpdmVy
X2R0X21hdGNoW10gPSB7DQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTYtYmxl
bmRlciIsDQo+ICsJICAuZGF0YSA9ICZtdDgxOTZfZGlzcF9ibGVuZGVyX2RyaXZlcl9kYXRhfSwN
Cj4gKwl7fSwNCj4gK307DQo+ICsNCg0KW3NuaXBdDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9ibGVuZGVyLmggYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfYmxlbmRlci5oDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4
IDAwMDAwMDAwMDAwMC4uYTQ3YWIxMjg2NDlkDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2JsZW5kZXIuaA0KPiBAQCAtMCwwICsxLDEw
IEBADQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovDQo+ICsv
Kg0KPiArICogQ29weXJpZ2h0IChjKSAyMDI1IE1lZGlhVGVrIEluYy4NCj4gKyAqLw0KPiArDQo+
ICsjaWZuZGVmIF9fTVRLX0RJU1BfQkxFTkRFUl9IX18NCj4gKyNkZWZpbmUgX19NVEtfRElTUF9C
TEVOREVSX0hfXw0KPiArDQo+ICt1MzIgbXRrX2Rpc3BfYmxlbmRlcl9nZXRfYmxlbmRfbW9kZXMo
c3RydWN0IGRldmljZSAqZGV2KTsNCg0KTW92ZSB0aGlzIHByb3RvdHlwZSB0byBtdGtfZGlzcF9k
cnYuaA0KDQo+ICsjZW5kaWYgLy8gX19NVEtfRElTUF9CTEVOREVSX0hfXw0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IGluZGV4IGI5ZDhmMTdjNGYzMS4uZTBhZWI4
N2YwYTViIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
ZHJ2LmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+
IEBAIC05LDYgKzksNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGstY21k
cS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaD4NCj4gICNp
bmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLW11dGV4Lmg+DQo+ICsjaW5jbHVkZSAibXRr
X2Rpc3BfYmxlbmRlci5oIg0KPiAgI2luY2x1ZGUgIm10a19tZHBfcmRtYS5oIg0KPiAgI2luY2x1
ZGUgIm10a19wbGFuZS5oIg0KPiAgDQoNCg==

