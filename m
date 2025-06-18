Return-Path: <linux-kernel+bounces-691366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F113BADE3D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 08:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3726F189929B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 06:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7A920A5DD;
	Wed, 18 Jun 2025 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gMeuYEK6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VQUbBuSF"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5A620296E;
	Wed, 18 Jun 2025 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750228865; cv=fail; b=MxnwiAZYrbITYE6jywOLxLq66ST/qY8tmQvIV1wzq78r1XJoBAv73WOJJWLYPX2mixLcPPfjYiCg51BIaWqXveiXDX3WkwXtp8gLTjIzaK4G9JbMHQKTmMVqUI3N2T7uwny/SsqDbRdmfcjY+GVdoTsrrRrSXHjS9hsbmj2g5oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750228865; c=relaxed/simple;
	bh=9KgmgHxNMOikxs0GimsDmHm95L9FSFkx8FC+1mSAm5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tj8KBADPvClAVPT4cKOuLCRH9/xapkSz8NsCwACmzsFcCkP8w4/WKfwrgML0f0/kO85dmYg4DAvmrIxcWuTt5soM37gZVcwv6AOb1CYAY/eISpfFGHRcUF8HV9CLBC+R5nI1/dOUcRJmclyNoPASE5ZbN6bmwo2U5pPjZeACOg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gMeuYEK6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=VQUbBuSF; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 31c405c64c0f11f0b910cdf5d4d8066a-20250618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9KgmgHxNMOikxs0GimsDmHm95L9FSFkx8FC+1mSAm5I=;
	b=gMeuYEK69JUTaVeOwKQonk9QtnpFhZ/GOBVMGMpauDSJu3AV9forMN3sTizdiHg+hrWyKDkL5cEnfgmvBl7CidA9LA2xRGeQWdO42G5y8cKKopDcUGtV6hHwCOvaBANwRC0qMy7CfZFmuNPjOrMCijiPBR5lhs+GVXiAealWGro=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:f548d29a-b305-40df-93c6-eb6db6b5e5d4,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:09905cf,CLOUDID:736dbb83-db76-4e00-9dd0-5c1455b2676b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 31c405c64c0f11f0b910cdf5d4d8066a-20250618
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1955864810; Wed, 18 Jun 2025 14:40:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 18 Jun 2025 14:40:57 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 18 Jun 2025 14:40:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUsRHw+uXqCDNf12FkAUkv9NTgxLbC//OfvN0Qcmn2APD0ONqJbiUUGjlMkaNvvEdquk0vDhP8j+7sIY7jk0god10F6hRdvgmITAUjZthHh+hXMBtOHhAnBj3tnQ1bCs5MVjFXxZQyyParLRwGxPD9hHZ0rg3gHgGAwoecrcYIhNvQSJrGJWmiMKSX4aTLEKEub7OvEjqIimRsKYolLkfvI3U6JdEljVnOBy3xNapn6+mxF8KIe6asiExbsLbWzXKLlN8zn1xnX/2XLxiL+gdi3H2hDzt6rkxEUH92JLjNE37jYN8+4vbdVCEJ2pbES+kj2mDENZnLQBgl8LiDn6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KgmgHxNMOikxs0GimsDmHm95L9FSFkx8FC+1mSAm5I=;
 b=bQOh6Q8rub2bOyqEHI9ZBcZULwFl+qjRiOua6txJEW1am8cehI3hIcQXtKYm1auFvrmo4i6dtbRr+AeIu4XteFHMWCYzMtojlslTvO2h1Mq0/GijCop3G1clmuy2LAvajGdy4Ez9gpQXqmqAI6loYWBTQFLvD7BWhANHDYRAzslk5+sc0BgrynU6Q1DALQ7fZcs8mNNjJ4qa6fi0Yo91ym+v+dwsOwWNfAyHBB8P552lisSv0J+tuJ3sHKzVYmTmUXzxZtNRU+xhb/pITCqG2nUIuv0bnfR19nSrtkd6QXi6DNv7maPj8RqgifRqu6EXccldvck2My9mTNZ9bdjxpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KgmgHxNMOikxs0GimsDmHm95L9FSFkx8FC+1mSAm5I=;
 b=VQUbBuSF73bDkTe2xY72uUFn2+0Wur0xMsNPZBwrXtxufOOkoje8EClJiAmXClDe2IM0uOkabbkNlXcbOBIxe1fmQN6/6usF7hjP3u93UVz13Nm9xsmYs4NkGJShQAni+IqkRMlYtfEMqVIEjmBb8I1bRzDMciWFonOu5fFpmPs=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SG2PR03MB6827.apcprd03.prod.outlook.com (2603:1096:4:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 06:40:52 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 06:40:52 +0000
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
Subject: Re: [PATCH v3 13/17] drm/mediatek: add BLENDER support for MT8196
Thread-Topic: [PATCH v3 13/17] drm/mediatek: add BLENDER support for MT8196
Thread-Index: AQHbxXzSW3PWtsK69EWC+y/eOuAOLbQIrOOA
Date: Wed, 18 Jun 2025 06:40:51 +0000
Message-ID: <6b561f320d4e614f37d065f5769759bef5f08632.camel@mediatek.com>
References: <20250515093454.1729720-1-paul-pl.chen@mediatek.com>
	 <20250515093454.1729720-14-paul-pl.chen@mediatek.com>
In-Reply-To: <20250515093454.1729720-14-paul-pl.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SG2PR03MB6827:EE_
x-ms-office365-filtering-correlation-id: 76e157c7-ec8e-4fb9-c1d9-08ddae3311b8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?THhmQVl0THR2THQrYzRmUHBQV3RFa2xuYXJqakJGYjZxcEFuR0d4VzdPaU41?=
 =?utf-8?B?cGx6UWZWdUpKT1FMSlByM2swUDN4N0xUVTlkTUZTb1lFTmJlVXBseFhCVWIv?=
 =?utf-8?B?d1dpbGV6QW1GUlgzQ25xTVpLQjM4Z09Dd3ZTUmNTeDJjaU90N0NvVTlSYWVS?=
 =?utf-8?B?ZURrcWIzQjJoM09jTThOSGVjK0xVYjVJSzYyU2MzSWJyM2Fpbkd0bEJhcUlq?=
 =?utf-8?B?M3B6U3ppb3IwRVRUSExYRVZZSy9QSnhsb29pV2FhT0hlNmVncElTbDlBYUFv?=
 =?utf-8?B?dEx1NHNvMi91T3JFOHlDOWJUSE02bUZtMFdYLzFoQnF0NlorVFNZbWRPR094?=
 =?utf-8?B?NlZNT0g1bDVlMXl5WWdvMndiSWtkYWVrU0JiWFlZdnRxRWFwZ0tPMWhITU5r?=
 =?utf-8?B?dzZmSHV5bkJvOGE2Z25TS2ZESmVma1E2VEtkaWN3K0FSUVN4dlhHUkRYUUN6?=
 =?utf-8?B?dzY0VWlyanBRdGZRQlF5YzRMY0ZqVWhpcU5QbWhTaW9PNkY0bjZIT3dQblo5?=
 =?utf-8?B?dE0zdEJpUmRxTk1kR2ljK1RiVlprN0JFaVkvcGU5VlM3ZzdzSStJYWZmYnpu?=
 =?utf-8?B?dEI5UjM5aExBbFRjNXFnTitiM1NMMFJ6ck5iblArVHNkZm9WTVYvdEdrMW9Z?=
 =?utf-8?B?QjFTSmNVTWNWZkd1NmRzaE81WlBZNHprNlVVSFpZem1QQnh4Y1gwZmY3d0E5?=
 =?utf-8?B?LzczbEl3SjdEaExxWEppNDJrTGpjSkkxbmNYUS9wTkR2bUhTZkordDFGOVY4?=
 =?utf-8?B?Y0lKQ1BYaVF1ZzRxTVpwQ1JuVWpBTVU0Ukk5N1JuYkFvYTdydHRpdnBLY2tj?=
 =?utf-8?B?a0hOQ2FxU28xcGRGZmZBaWhjYmNQRWdWMUxwdmVlQ3pFOEFtU205U2xHNXRW?=
 =?utf-8?B?U1c5OUxlMnR0aFppYnlidzZpcXc2cnNrZnRDL0NVUVZwOWlVNTcwdmN0aC92?=
 =?utf-8?B?dThiWjVyVm9HNzRScnBnOFMxK3RxTi9Za21BeHpjd1FjZENDL0RheC9FOElX?=
 =?utf-8?B?MHlFWUdOMzVpamVSN1NmTjFibUFXbHdnUWdTUFE0RzBnVUVGUkNEV2pTSnQv?=
 =?utf-8?B?aXJ3Y2dMaGtJV1hCRlFLQlBYNjlQM3g2Um1UWVdoYVhJRkkyTW9HbHQ3aHVv?=
 =?utf-8?B?TzYvaS9iM2RJaXlNTHl3Y0JPSjRHVzMwQzBPaVltbDlwQ2FmcjFTN1kxRnJ5?=
 =?utf-8?B?cVdqOExscTMrdmVvL0E0VHBOVXBKazZrSVhqZ2NIYVdNSjhFTjNoMTlqeEhZ?=
 =?utf-8?B?cXhIalIrTU5iTFhRSEx5aGNqa2dKbEtTL3BJZmhxdzZZQTE3L3NDZlg3SlJn?=
 =?utf-8?B?Z0dQb3daQXVSVi9lbXJPR0FBOVJIZUpNV3dDV3RZTE13QTNpemVpenE2YVh1?=
 =?utf-8?B?akMrc3BEdGxuWkFSQXc2b2NUaGZNYVZ0cEI2Q2g1b0xmbjVxVDZlVWtldUpX?=
 =?utf-8?B?LzVrQkZJUVdSVGF6K3I2WDJSdDdlcFdrNUhOcU9FcGY5OSt4eFltSm1MdzR1?=
 =?utf-8?B?QkF0N0ZqbWZ6eUFSUEpid215ck4rRjg5NlJpMWQ0TGI5SDE4K29VWUpHcCtR?=
 =?utf-8?B?UUFSWHpsOFBoOVVIWDZrR1pXMTk2YWtWZHdMd0s5THA5ZXNYS1IvVG80L2lH?=
 =?utf-8?B?bENiQmtybnNONkpDVmtab0VRVlNwaUUvRjZjdjZ1SFQ4THpOM1lOZVNkWk5Z?=
 =?utf-8?B?cXY3amcxbVlOL0hSUTZWRDMwRjJmbURJb2FVaHRXZWJEMVVtSm0wK0crcnRJ?=
 =?utf-8?B?bjhnYTQ4T29JV0VtcWRhc2wxcjJYTHhMT3pqekdSSlB0QlV0dkh4RFE3YWNk?=
 =?utf-8?B?KzZZSkIyWVNyRWdmc0kydEE3QnhoOFhPWjhFRTdxSksvVDF3SEVuVzBVbzkx?=
 =?utf-8?B?ckJTb1hsYlVqMDVBekdQWS8wL0pIZ0hJS2RZQ056MU1mSC92Ny9tN1NjcDVW?=
 =?utf-8?B?djNQeFZGRW9DWW95bEJDK2lnUlpnSG1pUXpGSnVnbW1haXp1eUFOV0IxKzZX?=
 =?utf-8?B?UkFyY0cxZTFRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFlTVXJwUURib3hUMWh3cWhjcDVlV3YrMUhERVpuRWlNSWJBbWIzNVFLcmNT?=
 =?utf-8?B?UDd3amRmc1Y0UVJoZlI2Y1dHK0ZGVk15eS9NZ3RucmcxQkF0TlhlZHlzNjdh?=
 =?utf-8?B?N3JMVFptTzZhd2hNQlk1S1VKNm82bWk1UnBZVkVjOVZ0TUNLME9UVFNVQlRp?=
 =?utf-8?B?eFBHUFA4a0EzN0JBd3ZBNmlmUHJ6TDN6Zkd1S20xMTZUL0FNUzJJWXpLS0dU?=
 =?utf-8?B?dHc5SWpuSE95OEJlSnR3eG5SMjBUSFZUcUhSS09ibHZlOGxzbVkxNDFLeHJP?=
 =?utf-8?B?Rjl1UGxjcGlEQVArWGhKb3FWVmVWc2YzaVNCNkZRWUV0VmhMSVBYUmVJam1u?=
 =?utf-8?B?bXcxVkdIRmgySGYwc1owK1Y3eHZhUHhENkt0eXdrOTl5M2h5Z3R3VGZiN21B?=
 =?utf-8?B?bXQ0NWZybnFON2hOU29uNHZMODl5OXNJR1dDcURmazNTK2xHSVNvenVta2lO?=
 =?utf-8?B?aDJHWEJORUZEckRZck8vV1I5ZzRTNnpBL0tJM2tLVVhKZG0wNWFGcFEwMFU4?=
 =?utf-8?B?Vk5KajlhSXFBbmlqU04zZ0UvWDFrODhDdTJwT0tocmQwSzU4TTh1czNRVEwz?=
 =?utf-8?B?VFFBREhpK2pyblA0WnpaOUxMK255d0QrSFZXSG5yNDVSZExwUEllcUVRcnRk?=
 =?utf-8?B?ajk3QXpvU1dlcnRoc0ZvcEVJWXpUTG9YVmw5TDR4Z2NXL0gyTjRONUdWd21B?=
 =?utf-8?B?RWlCNCtxRGJZeTB0U25qWVZWTVF6dlduSEw5Zi9vYk00SEVoY2RnbUFIeUEy?=
 =?utf-8?B?TUQ5clVKVENJUGJUeW5pbjdieEZKMGpRU2gzblpidlpHMVZyb0d0OThKYnhl?=
 =?utf-8?B?QndJWm9jd3h1TnhpdDgzNTB4VUlhU3BicVFQNmIzMC95Rys2VUFScVN2Undj?=
 =?utf-8?B?cUtERTlLR2RxaUd5bTR2NThWZTYvM3J4TDNucU1WUEVXd09sRGppU0lLMXd5?=
 =?utf-8?B?NFh3UDVxMWtnYzJxT0MvekhORU9OUktHR3RiTmRkVlJDTlRSQWlwZ3RqZGhD?=
 =?utf-8?B?NDVNQmRaNGJzNFZLdm1SRjZuUnMxdmJQRzJaS0I1Yy9BQTJUaDZwWXZ1NVpC?=
 =?utf-8?B?UUhFeW5TWjZ2cmFzNVNoajIrblY3M2tSTDRwWDZ1cForWGtKZlpydjFZc044?=
 =?utf-8?B?TC82S3Z0a0RGV3FRWGpDSE9MYjVDY1ZyL29sY2JPYWE4MjloQlNDSFAwMnZL?=
 =?utf-8?B?ZmdmSFB4WFp3a21yV21PTmp3cjVVTzlENkcrUUtIYlFMNDU1UkZjZnBKeUhY?=
 =?utf-8?B?dlVvckJtS1Z1MHBxdUw1Z3dqdzFZY3FoNmxtZVJhMXhNaVNaUkJGamIwdXdK?=
 =?utf-8?B?WDBmMm85cGt4THlGOWZxQTI2aDR5ZXo2RGZ6VDBnTWVIUmZtMVdmRkloMVp1?=
 =?utf-8?B?c3gwajZTdTZJT2RCdmdyY3p5V2xmVVdoSUEzK0RndzA1QStmQkZISlpxMk96?=
 =?utf-8?B?QUgzeHJuV0Q0YlFTc0hmczVQQmJwVUlDZG16cjFUOXdVeHpRSCt4WEYyNnVB?=
 =?utf-8?B?YlRieDcwQWtRdEwvRDF0Mk53V1VTcURHcEk2NnloRG1vSUhZQzVEZU5sd2N2?=
 =?utf-8?B?Sm1XZFAxMGI3Y0l6cnF3d3F0V1lYL0gyRGxDd29NWmEzVnc0aTdZdW9CQnl3?=
 =?utf-8?B?QzhGK3kxUzlaZWExcmhmaE5FWWxWQlM0OWJhSElYY1VlY1pmWkI3cm9mbU5h?=
 =?utf-8?B?WFk4RFNGb2ZpUjlyaUg0enBUZGpldWRtd1NuNXNsTy9CQTIyVGVZTExFLzFE?=
 =?utf-8?B?MlhibGNodmszNXhrSFdjN2ErTU56TlJyRDJ5d1oybEdMUFhYaDg0dkVRQUps?=
 =?utf-8?B?Ylc0SmtTaC83YmdTTzBIZDVYUndOU0FFV0JEZGZLSUhaQ1IvQVdhc3lzK0lS?=
 =?utf-8?B?a0RBb0NRUHk3ZU5mSHRveWgzK2hFNWFGeEdpdWFKc2V3cVZac2ZLUkZrMmwx?=
 =?utf-8?B?M1o0NFFqZFJOL0d5RUhLZU9jOUJSMDFybkhuaVpNWVRWd1BuTzFzSnEwckpG?=
 =?utf-8?B?TkVMWkdOcnl4cUxhNTh1UTM2aDF0ZFZrai83czFVeTY4V200Q3lCOFA2eXov?=
 =?utf-8?B?bm5MTVdpZnB1QnpkTmhSODVnZEVVRUhZK05IQ2c2RzduQ01Qc3ErQkFoWjRL?=
 =?utf-8?Q?rvdNMc3fCbFW6iaIFs0F8eNzB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0FD8CEC148F6F4ABB3E46C1B3E40C75@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e157c7-ec8e-4fb9-c1d9-08ddae3311b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 06:40:51.9729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fihDsflwvAKdZwRisQ0Wci2UcYeWzVYWhacsDLVhA4ynBhPFq5oRalGOOflZy87Ds8sdqY8ei1/gz8PuLEeoGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6827

T24gVGh1LCAyMDI1LTA1LTE1IGF0IDE3OjM0ICswODAwLCBwYXVsLXBsLmNoZW4gd3JvdGU6DQo+
IEZyb206IFBhdWwtcGwgQ2hlbiA8cGF1bC1wbC5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gDQo+IEJM
RU5ERVIgZXhlY3V0ZXMgdGhlIGFscGhhIGJsZW5kaW5nIGZ1bmN0aW9uIGZvciBvdmVybGFwcGlu
Zw0KPiBsYXllcnMgZnJvbSBkaWZmZXJlbnQgc291cmNlcywgd2hpY2ggaXMgdGhlIHByaW1hcnkg
ZnVuY3Rpb24NCj4gb2YgdGhlIG92ZXJsYXBwaW5nIHN5c3RlbS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE5hbmN5IExpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
UGF1bC1wbCBDaGVuIDxwYXVsLXBsLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCg0KW3NuaXBd
DQoNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2JsZW5kZXIuYw0K
PiBAQCAtMCwwICsxLDI2NCBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAtb25seQ0KPiArLyoNCj4gKyAqIENvcHlyaWdodCAoYykgMjAyNSBNZWRpYVRlayBJbmMuDQo+
ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgPGRybS9kcm1fZm91cmNjLmg+DQo+ICsjaW5jbHVkZSA8
ZHJtL2RybV9ibGVuZC5oPg0KPiArI2luY2x1ZGUgPGRybS9kcm1fZnJhbWVidWZmZXIuaD4NCj4g
KyNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9jb21wb25lbnQuaD4N
Cj4gKyNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5o
Pg0KPiArI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9w
bGF0Zm9ybV9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0KPiArI2luY2x1
ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstbW1zeXMuaD4NCj4gKw0KPiArI2luY2x1ZGUgIm10a19jcnRjLmgiDQo+
ICsjaW5jbHVkZSAibXRrX2RkcF9jb21wLmgiDQo+ICsjaW5jbHVkZSAibXRrX2Rpc3BfZHJ2Lmgi
DQo+ICsjaW5jbHVkZSAibXRrX2RybV9kcnYuaCINCg0KYWxwaGFiZXRpYyBvcmRlci4NCg0KPiAr
I2luY2x1ZGUgIm10a19kaXNwX2JsZW5kZXIuaCINCj4gKyNpbmNsdWRlICJtdGtfZGlzcF9vdmwu
aCINCj4gKw0KPiANCg0KW3NuaXBdDQoNCj4gKw0KPiArdm9pZCBtdGtfZGlzcF9ibGVuZGVyX2Nv
bmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCB3LA0KPiArCQkJICAgICB1bnNp
Z25lZCBpbnQgaCwgdW5zaWduZWQgaW50IHZyZWZyZXNoLA0KPiArCQkJICAgICB1bnNpZ25lZCBp
bnQgYnBjLCBib29sIG1vc3RfdG9wLA0KDQp2cmVmcmVzaCBhbmQgYnBjIGlzIHVzZWxlc3MsIHNv
IGRyb3AgdGhlbS4NCg0KPiArCQkJICAgICBib29sIG1vc3RfYm90dG9tLCBzdHJ1Y3QgY21kcV9w
a3QgKmNtZHFfcGt0KQ0KPiArew0KPiArCXN0cnVjdCBtdGtfZGlzcF9ibGVuZGVyICpwcml2ID0g
ZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsJdTMyIGRhdGFwYXRoOw0KPiArDQo+ICsJZGV2X2Ri
ZyhkZXYsICIlcy13OiVkLCBoOiVkXG4iLCBfX2Z1bmNfXywgdywgaCk7DQo+ICsJbXRrX2RkcF93
cml0ZShjbWRxX3BrdCwgaCA8PCAxNiB8IHcsICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywN
Cj4gKwkJICAgICAgRElTUF9SRUdfT1ZMX0JMRF9ST0lfU0laRSk7DQo+ICsJbXRrX2RkcF93cml0
ZShjbWRxX3BrdCwgRElTUF9SRUdfT1ZMX0JMRF9CR0NMUl9CQUxDSywgJnByaXYtPmNtZHFfcmVn
LCBwcml2LT5yZWdzLA0KPiArCQkgICAgICBESVNQX1JFR19PVkxfQkxEX0JHQ0xSX0NMUik7DQo+
ICsNCj4gKwkvKg0KPiArCSAqIFRoZSBpbnB1dCBzb3VyY2Ugb2YgYmxlbmRlciBsYXllciBjYW4g
YmUgRVhETUEgbGF5ZXIgb3V0cHV0IG9yDQo+ICsJICogdGhlIGJsZW5kZXIgY29uc3RhbnQgbGF5
ZXIgaXRzZWxmLg0KPiArCSAqIFRoaXMgY29sb3Igc2V0dGluZyBpcyBjb25maWd1cmVkIGZvciB0
aGUgYmxlbmRlciBjb25zdGFudCBsYXllci4NCj4gKwkgKi8NCj4gKwltdGtfZGRwX3dyaXRlKGNt
ZHFfcGt0LCBESVNQX1JFR19PVkxfQkxEX0JHQ0xSX0JBTENLLCAmcHJpdi0+Y21kcV9yZWcsIHBy
aXYtPnJlZ3MsDQo+ICsJCSAgICAgIERJU1BfUkVHX09WTF9CTERfTDBfQ0xSKTsNCj4gKw0KPiAr
CWlmIChtb3N0X3RvcCkNCj4gKwkJZGF0YXBhdGggPSBPVkxfQkxEX0JHQ0xSX09VVF9UT19QUk9D
Ow0KPiArCWVsc2UNCj4gKwkJZGF0YXBhdGggPSBPVkxfQkxEX0JHQ0xSX09VVF9UT19ORVhUX0xB
WUVSOw0KPiArCS8qDQo+ICsJICogVGhlIHByaW1hcnkgaW5wdXQgaXMgZnJvbSBFWERNQSBhbmQg
dGhlIHNlY29uZCBpbnB1dA0KPiArCSAqIGlzIG9wdGlvbmFsbHkgZnJvbSBhbm90aGVyIGJsZW5k
ZXINCj4gKwkgKi8NCj4gKwlpZiAoIW1vc3RfYm90dG9tKQ0KPiArCQlkYXRhcGF0aCB8PSBPVkxf
QkxEX0JHQ0xSX0lOX1NFTDsNCj4gKw0KPiArCW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwg
ZGF0YXBhdGgsDQo+ICsJCQkgICAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsIERJU1BfUkVH
X09WTF9CTERfREFUQVBBVEhfQ09OLA0KPiArCQkJICAgT1ZMX0JMRF9CR0NMUl9PVVRfVE9fUFJP
QyB8IE9WTF9CTERfQkdDTFJfT1VUX1RPX05FWFRfTEFZRVIgfA0KPiArCQkJICAgT1ZMX0JMRF9C
R0NMUl9JTl9TRUwpOw0KPiArfQ0KPiArDQo+ICt2b2lkIG10a19kaXNwX2JsZW5kZXJfc3RhcnQo
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0KQ0KDQpEcm9wIGNt
ZHFfcGt0Lg0KDQo+ICt7DQo+ICsJc3RydWN0IG10a19kaXNwX2JsZW5kZXIgKnByaXYgPSBkZXZf
Z2V0X2RydmRhdGEoZGV2KTsNCj4gKw0KPiArCW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwg
T1ZMX0JMRF9CWVBBU1NfU0hBRE9XLCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsDQo+ICsJ
CQkgICBESVNQX1JFR19PVkxfQkxEX1NIQURPV19DVFJMLCBPVkxfQkxEX0JZUEFTU19TSEFET1cp
Ow0KPiArCW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwgT1ZMX0JMRF9FTiwgJnByaXYtPmNt
ZHFfcmVnLCBwcml2LT5yZWdzLA0KPiArCQkJICAgRElTUF9SRUdfT1ZMX0JMRF9FTiwgT1ZMX0JM
RF9FTik7DQo+ICt9DQo+ICsNCj4gK3ZvaWQgbXRrX2Rpc3BfYmxlbmRlcl9zdG9wKHN0cnVjdCBk
ZXZpY2UgKmRldiwgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCkNCg0KRHJvcCBjbWRxX3BrdC4N
Cg0KUmVnYXJkcywNCkNLDQoNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX2Rpc3BfYmxlbmRlciAqcHJp
diA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArDQo+ICsJbXRrX2RkcF93cml0ZV9tYXNrKGNt
ZHFfcGt0LCAwLCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsDQo+ICsJCQkgICBESVNQX1JF
R19PVkxfQkxEX0VOLCBPVkxfQkxEX0VOKTsNCj4gKw0KPiArCW10a19kZHBfd3JpdGVfbWFzayhj
bWRxX3BrdCwgT1ZMX0JMRF9SU1QsICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywNCj4gKwkJ
CSAgIERJU1BfUkVHX09WTF9CTERfUlNULCBPVkxfQkxEX1JTVCk7DQo+ICsJbXRrX2RkcF93cml0
ZV9tYXNrKGNtZHFfcGt0LCAwLCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsDQo+ICsJCQkg
ICBESVNQX1JFR19PVkxfQkxEX1JTVCwgT1ZMX0JMRF9SU1QpOw0KPiArfQ0KPiArDQoNCg==

