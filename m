Return-Path: <linux-kernel+bounces-786143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C67B35598
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E8B189F1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5774A2F83DF;
	Tue, 26 Aug 2025 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gSv9w5A5";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hHX6/tYY"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA017A2E1;
	Tue, 26 Aug 2025 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193052; cv=fail; b=C8KMy+kw/vIUNY/yPHLq7fxCgI38ialW/jGNkA4TOHGoIO4faltXD5aeu89Pbe7xYkPaaAyNlhzB9fW9dzJdDWGH8ZGEiSJ9qysNqtQq/8cJQ0HloTQbkjv0qOI4c5TFoPMFDGivVDIAyS70l/5JGWkzBbq1sA3WIdFWgQyZ2AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193052; c=relaxed/simple;
	bh=UnasYhC2cuk0GPRyEEDKaFrdq2yqmtnNHPjyeWiotHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qKlCYJi/YJeXtN+pq8XEZdsDn86kuhFQQcx3Im0Fddz2oO2m4FEARKcZHE+jXZA3RbPgEgTVyFePe14Y5fl/hOnw8DV1gWNL4f1LJVSKeiY8/pnmuRdil/mbvo1hu5cYWSCIhSn+1JfJErQVGMWe8YvJ+gaU7bTbzt3Zxfng/4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gSv9w5A5; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hHX6/tYY; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a5443f6a824d11f0b33aeb1e7f16c2b6-20250826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=UnasYhC2cuk0GPRyEEDKaFrdq2yqmtnNHPjyeWiotHg=;
	b=gSv9w5A54FiOoZ3zGanYwdlfhNEzHMeQj9dBVaPmJY5+lHvjhTJU33jLs82Fxm+y6MEWOTAwPkI4LrKVeV834sSEZQIIJDTqWk1PJdJCkl0AFj1YVTWRQy89YFTAQx1ysXJHmLOpc9/EYtk0g8uF7A24aHEhXdczQ+CgwTJfTxQ=;
X-CID-CACHE: Type:Local,Time:202508261516+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:2a28d9c9-7cec-4d62-942e-6cfc8ef83cee,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:b962887a-966c-41bd-96b5-7d0b3c22e782,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a5443f6a824d11f0b33aeb1e7f16c2b6-20250826
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <hailong.fan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 346659219; Tue, 26 Aug 2025 15:24:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 26 Aug 2025 15:23:58 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 26 Aug 2025 15:23:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qs26qu4EHRQ01ERFA+TtcKeCGaIfQQHo+WBHg8W5TGEa/A0l/QRgmY0nPLEX4MhZJhDQrCHorgrovPdc2GYEfN4P8Yw1n4Q1dKUN2pMj1cvdLgAYVd41SC3EDupC0njrGOz8i8TavttrM5u3eQiwxwGGykVsr3sohRaQVRAMjCSHOXtS1muubVqwpQSQPoGdQ4gjizAxLlv35JHLwXJeKnLAse6fRXn/mUxd4w6iD9IV8dpBVQTbJ8YG6wZu/DGnWrJNKZ87/in3K8nWZSss335Gs9yKqcCxYQIICUrye9xlM7ln5bm+967ISdzgNFTxMOuk8GcrOaqQtAViMcIUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnasYhC2cuk0GPRyEEDKaFrdq2yqmtnNHPjyeWiotHg=;
 b=yFXFcAB0zJ4t/CLJtiMnB/5GJy5InEA80Pf4d2AAe8TQZbYJRdAjswiZ0Pwv5wvzwHInq3bCDpnhIJX8g9hAFiAnQJ817tj4Cqxnk7DWTZGPui6rW/U4uIXY4ATWI2xkVgY1QkK9U9kfPJ3ENo9HB6tualVRHkOf32ohN1Wtx03EPJYv/AUqCYfg61585KzJTvovpBwosJJbJQ27Tn5J1rh8GPkgBsgKHom+MZekdx6KtwqXN5RqpQscgf+bil+jdW6HL2vu92Mu7YgEbH3829BQp3FFCIumAbnnppYy8Xm9/w8DzfN1JjVHsZ8ZiHGiLGyW+9fmmP5vCInyfyLS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnasYhC2cuk0GPRyEEDKaFrdq2yqmtnNHPjyeWiotHg=;
 b=hHX6/tYY7HGtZJdK/nNMglAwWJ7qWNxpPxEQWA+xleSG3cYyYSN33ahFrvum0J0duqMx/uIq61t84Vw2g2RngC+ENTs4tFMdZf81zreDNDw/ZBIch6MGum49W59uI6ZTLTItIBSUJT+frshpERYBRNgMIEa8RbMQau3YkRZ5sbg=
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com (2603:1096:820:8f::5)
 by KUZPR03MB9470.apcprd03.prod.outlook.com (2603:1096:d10:47::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 07:23:56 +0000
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d]) by KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 07:23:56 +0000
From: =?utf-8?B?SGFpbG9uZyBGYW4gKOiMg+a1t+m+mSk=?= <Hailong.Fan@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>, "pierre-louis.bossart@linux.dev"
	<pierre-louis.bossart@linux.dev>, "kai.vehmanen@linux.intel.com"
	<kai.vehmanen@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "tiwai@suse.com"
	<tiwai@suse.com>, "robh@kernel.org" <robh@kernel.org>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "yung-chuan.liao@linux.intel.com"
	<yung-chuan.liao@linux.intel.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "peter.ujfalusi@linux.intel.com"
	<peter.ujfalusi@linux.intel.com>, "perex@perex.cz" <perex@perex.cz>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	"ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
	"daniel.baluta@nxp.com" <daniel.baluta@nxp.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "sound-open-firmware@alsa-project.org"
	<sound-open-firmware@alsa-project.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: dsp: mediatek: add mt8196 dsp
 document
Thread-Topic: [PATCH v2 1/2] dt-bindings: dsp: mediatek: add mt8196 dsp
 document
Thread-Index: AQHb6/AjDLqCeVaT/UOLwUvdRPs5orQgC4SAgAkVMoCAAERzAIBLd7mA
Date: Tue, 26 Aug 2025 07:23:56 +0000
Message-ID: <e2ffce807e5337925fb7907b3bd53cf0dbc62035.camel@mediatek.com>
References: <20250703075632.20758-1-hailong.fan@mediatek.com>
	 <20250703075632.20758-2-hailong.fan@mediatek.com>
	 <defd70cb-4351-4b0b-b4d0-dd1ff831615c@kernel.org>
	 <a72ff8bbd8205698948bf5be2c71d93f41a20ec1.camel@mediatek.com>
	 <61270ce3-8172-482f-80c7-e1c6d031cbe2@kernel.org>
In-Reply-To: <61270ce3-8172-482f-80c7-e1c6d031cbe2@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6002:EE_|KUZPR03MB9470:EE_
x-ms-office365-filtering-correlation-id: 3284464a-b06d-4019-05a2-08dde47184ad
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QzJIUVQwMWdIMEZuMFoxckQ4ZmcrTEJoWkxzcEFPVmYvMmFxTDlXa01LcnVH?=
 =?utf-8?B?NTlqOTZaeWhOWEpIV2I3aGNUZGY3S05hanpPQlRQZ3pYb1JZemw4b2g2WUd2?=
 =?utf-8?B?ck5PQXZCNWtiWURtNFFoeTJsOHZwQjhtUzU5YkJyRWU4d0Z3L0NDRURVZkta?=
 =?utf-8?B?eWxwK21NZlpYaWtxMHI5QzV3UmhPS2JhM2hvakVkMTFSc0ZYNmR1VTNEY1Yw?=
 =?utf-8?B?alNUakpGS1IyVEswRjc3bkRocGxIWVNGckM5bG1BbjhqQU56bzdUMi9DS0xU?=
 =?utf-8?B?T1F2NjlXYWp0U0c3akZCUjJtdEZzK3NmTEl6UnZoK0x2bkljRjhFZDY2Y1lT?=
 =?utf-8?B?MUhFMGsycGJaK2JPbjB3N3VvQzBvOGdGRzhvbS9vaUxPKzJsbkRwZ0ptWEM0?=
 =?utf-8?B?Q1dZbzRpdHlka20rN0VVa3JZam9lRjRUOFVCM1Q4ZEdnUzJFNmZkUnAyeFpQ?=
 =?utf-8?B?VTFsbGhHYjhlQk4vaWdSUS9sVHU0M0tmcWVsQ1MzWmpIM2Y0VVA0dTk1TjRY?=
 =?utf-8?B?cHR3cmpvcW9CeW82T2xyalhKaExUN3loaUlFNEdKdjJHR3padjJhV2NJQ09w?=
 =?utf-8?B?bFJNZ05DcW1EajhpU1ZqV2d2UnpzR0I0QzdTeEk4T3h4a25JVzBzd011c3ZL?=
 =?utf-8?B?a0lRRFgrOFozTVZnWTZhbVJaZnYxcjNVNVZkRnVYOWhNUGVzQWFKdXI5cENi?=
 =?utf-8?B?ZVFrNTVqKzdzWnZ0MWpmVlNlalBVQkYvVHViSmZNNDUyVStoUGRlNlVDRDAr?=
 =?utf-8?B?SUlONkdWTVI2T0xhUjJBVnZ6WFU1ZzIvMUNqMlhyU0NKUVM1MmEzL1Q4RmJ4?=
 =?utf-8?B?b1pKbmUzN2hPRHcvUTgzM1lhNTJkOEZYdnNYYkJHYUdESHdZSWVub1V5VHEx?=
 =?utf-8?B?ZjQ4bnFyUkcvVERvU29wQkNrMlNJaFJYSm9KZENMWG14N1VJNlpaOFRUTjV1?=
 =?utf-8?B?a0M0VkRsSWg2SjBiRnc4OWkrUCtjM0Y3NUV2elp6Tm9jaEZNYkREVWhPNUdO?=
 =?utf-8?B?RTArK2MwQkViOUthWUplUjAxdXI3d0JjT0JEc3NuN09XTGxaTE1nQXByVDZM?=
 =?utf-8?B?amJBbFNuY05kMWVWTXkvZFd1OFRzbDNkNFVoMUREb3RabFBrRzBYTnJwS2U4?=
 =?utf-8?B?UzcyTmdZT1ZpeVo2Mis2d0I1Q2dybnE1MmUxSStqUm5QVlFLdmdQcWJGY3Y5?=
 =?utf-8?B?dE1KNi90L0hpSi9jSkszdnF6MEFKZkVic0VWOE1iWGxoTHFkMDg1eXNrU2xJ?=
 =?utf-8?B?R0ZtUE1pQzhMN1A3WTdKcUJtb3hTOSswWVUxc2Myai9tanFHWW9uaksvY1VX?=
 =?utf-8?B?SWQxYnhvUVRlZHFIZlZVNUdvUjBNdHJLcHdSNTlhSS9NZzJNdSttYUU2bnRY?=
 =?utf-8?B?RE1QWkRjSWFIT2djd2xMaCthbjdHRllpdjQzazlBaWJUSDkwa1ZlNTNoai9F?=
 =?utf-8?B?OGVyeHUvT0ZQQ1RzNzFiSEE0Y0UwZTQzVFN3MXFoZGRhM0p4WklMaWhldVRH?=
 =?utf-8?B?c2ZPcG5GQS9xR3RVb0JQNEJLQzA2bFFnQ1d0M3dRYnQ5Mm1xc282OGttdGI4?=
 =?utf-8?B?ZXRBU1VrdUswVkdDaCtXc0kreFlOK2hFbEhzTkVET1EvN0h0K0FxaDhUNkVC?=
 =?utf-8?B?VENMT1l1MnNkeGxqK2k1VE9DTDNaYmdYcEJWdm5pdFpQT0VXK2I4VGtkVlBR?=
 =?utf-8?B?ZU5NVVVKemJNTkNZNFA3RzVlei85R21wbnpwZDZKbnZKNUpOZHZpZUdFcjZu?=
 =?utf-8?B?aE83ZFhNdUY3YnljeFp1WW5ETXg2N2Q0YjlMYUN5TGdPZXU4cnd6a0J1UDAx?=
 =?utf-8?B?TjZ5OHNVRDJ2aVpZY1dBbVZkeVJkMVJlMnM1Mk1ERldJcGd5emMxelZhYVpK?=
 =?utf-8?B?Yyt1T3lNOFN3V3I4V1ZwbXlaVkxTSXM2YnpMRlY3NkFXbXdVUDQ3b0Jzb25t?=
 =?utf-8?B?Zk80ODlqaGd2b3A4VmFrbWl0b1NMc2hvMVlQZHBWWHJBbUdVZ1dDOFZTbmRp?=
 =?utf-8?Q?hiif3h5knNjwyRvgeIrAuzouhE+N78=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6002.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWJzYzl5UEF0azV0NWJ6V0hFNzdpNzZoNlI2cUhna0ZzbVRmMVh6VFlWMFkz?=
 =?utf-8?B?SHhic0g5MmpFSlNvRzNYL3NaeHVIQTFldmdJZkRabjlIN3R0a3N1Y3FBVGNz?=
 =?utf-8?B?Rjd2QXM5cDlYbUJtSVFicTZWWUR0M0poNWlVSkN4UmlSM2I4cW1wTEIyVWlP?=
 =?utf-8?B?elluZUFUNlNRMytFSHFUbnJCOW5HR0tLODBTSm9NNTk4QWpKL3dnL2VIMWNi?=
 =?utf-8?B?ZlZnT3dwS3hsSzZtL0JVTGhWZ2xVOGwvV2EwZ2RTT0dEWVptbVRzdTdFU0I0?=
 =?utf-8?B?MUhZc25QRk9URkhzdUVrYThNdjBoL0NEVmVWaE9zWnhvNERnT00vaEVWa2Y0?=
 =?utf-8?B?Zm5KajhKc0NZd0pLd3FjRzdmWmppMld2RjFRU2l1QVUycFdmMStNeS9XMFNI?=
 =?utf-8?B?ekpKY25pZUFMY3JyK0wxaEw5RERLQkh0Z0tlMFRRTC9MSXU2T3FON2JtRVQv?=
 =?utf-8?B?QWZLWEFOcTR5YktWMlFoZFgyN0k1ckZ4NG5hak9PTWtnU2hQdVN0UmRENmY0?=
 =?utf-8?B?QmV6R0RLVFpKNTRlVVhTQ2xrZFpMWVVxWVQzbGxjZzlPQkJmWXFxQnFBbFA2?=
 =?utf-8?B?TWI1dUo3Rm4zV3NRRmpWbzlrSzJtcGpFVXI1K1JZeXB5TkxtTTNFMHhNM0lY?=
 =?utf-8?B?d2h6eUxlZmhFQ3FuUFk4enE1b2REUE9aZGVsdkNjTDRZOWxvWmJyd0ZIQ1dJ?=
 =?utf-8?B?QXF5dmFPMnlTd2dxRWNuSHo5MlNpUHgrNmpDVms1TmtFSDNVRTNKZ1BBMVc1?=
 =?utf-8?B?c1E1bTUvSEU2SWZyVnQyMVVvc1I5YkVXOTFOY0FWSGtIakkyWEYyR2p0ZVdz?=
 =?utf-8?B?cmJkVnEyemFFTUIrbGs4dk9sNTI1ZDRkK1p2eEc3T3haME9uclZwelpsbGw0?=
 =?utf-8?B?TWw0ZVpkM2lZZmJTa3AvM1RXL2dpZlJjVCs0a1lTVEtJSTUvaXhvZXl2Y1VR?=
 =?utf-8?B?SmZLak1kMW5DWk1KQXQrNHJiRWZ3aHA1bXVKcUNLaVFmdEpERjlwb3dkcE0y?=
 =?utf-8?B?dnV0d3cxVG5wYnJ1NytSVFI3YnhWeXByenZnWmFUOW9ZNERPTEhWYUlDa0FX?=
 =?utf-8?B?SGJVVW1ybklybVlWaVh3amJETW5ESUNhQzF1NmhFd2czRWZjZFpHcFlvMGcr?=
 =?utf-8?B?L2dmRXlJaVhkZFJ4NmZEY2l4VTF5eVRCc0w4UUNaYmg1TWtycTNSdkxnc1lY?=
 =?utf-8?B?Rm5OY20yejlGZ1lXWDBFRW5RNzdvS0NGQVAydnVqT1JzUG9PU3pVbThXR1d2?=
 =?utf-8?B?THRQSFpIcHdES2xRVk9rQnh1VXB1OFhPeGk3Q2JHTU5kSzJnbkZSRnFqWDUw?=
 =?utf-8?B?ZXh4WWJJUkdnMjZhL1g2TjB5d1BCeGtjRWY2RVZuL3U4L2VFVU1oVUZhY3hp?=
 =?utf-8?B?WVJ5Y0dESEN0c3NVSmZyNEcycHJrbmNnZ2ttZkZWT3paMGdjVmcxNWNHNW42?=
 =?utf-8?B?d1k4N2t2RHhtSU9WbVZwVjZjZXFDUkhkdmpqZHY2UG1sWnA2d0FNSnlGanZp?=
 =?utf-8?B?NHJoK2pNM0wyaXVVRDl4YUlQS0Q4Z2pEa2NBRUJTL3BvQ1hEVHRvY0FnSVBR?=
 =?utf-8?B?Z2l1VWtNU0dUay92bXZFNE5CNGJyaktYQzNDTS9FWFhKTi9ZTE9uaE1WL1hK?=
 =?utf-8?B?YTMvQlZsQTdUajU3NkphVUVRZXZPQkNFYkEvdXFRbFlHUlJtRWN5eTB6dG5l?=
 =?utf-8?B?NXJGTmRhQ2tUSzY3Q1VwWHVRL2JDT1BqQ1Q0dTdURnhuM2xrQTAvbERWYWJU?=
 =?utf-8?B?WG15MUthdmpVck1ta1VmNkhPQW1hdzRoSnd0cUhQaHpwZndLRHZETUdENGw3?=
 =?utf-8?B?c3JvVkw0bU5LaTU0VlJCd0NxbDZ4SXBhOGh6SEVIT0M3WE5PVnZrL3V3UHFr?=
 =?utf-8?B?dHU5T2ZkZ1V4eWRqRFE1WnM5MU9JZGVvVllFZWxwMWQ1NDJUbjFCRURFclV6?=
 =?utf-8?B?Skw3eHQzTHdoZnFNSmZFcUtiai9pc2Znd0tkS1V0TjhQeVZhcTdNOFlLdDB2?=
 =?utf-8?B?citadjIvU016MDN6M1JNRG02VlVVMWM5WTBOb1dBR0NUMnpEa1R1a2pWNFhu?=
 =?utf-8?B?cDVwelpyeG5rcnVUdUlJUFRTVkl2Y0d5UmZMNzE5QWlVRkdEMEpDVGk1ZlN5?=
 =?utf-8?B?c2FZWHpzOUNEUktqLzI2MXd1R056RTNMVjlQVU8rYUhBME01N2FEdlJRQ3ZG?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4564AA654FEFD34EA18232AD15A1FCCC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6002.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3284464a-b06d-4019-05a2-08dde47184ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 07:23:56.4625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IiwYRYq/wnqDqllBRN/JiqEm4sTOEkQ0nEIBIbalb851b3wL7rdYtSIPuDeoGRjWQ+6LZ/PviF3K6jbCrLuaSfZboZ4yUrioomxOYJ12eoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9470

T24gV2VkLCAyMDI1LTA3LTA5IGF0IDA4OjU1ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDA5LzA3LzIwMjUgMDQ6NTIsIEhhaWxvbmcgRmFuICjo
jIPmtbfpvpkpIHdyb3RlOg0KPiA+ID4gPiArICBjbG9ja3M6DQo+ID4gPiA+ICsgICAgaXRlbXM6
DQo+ID4gPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBtdXggZm9yIGRzcCBjbG9jaw0KPiA+ID4g
PiArICAgICAgLSBkZXNjcmlwdGlvbjogMjZNIGNsb2NrDQo+ID4gPiA+ICsgICAgICAtIGRlc2Ny
aXB0aW9uOiBBRFNQIFBMTCBjbG9jaw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgIGNsb2NrLW5hbWVz
Og0KPiA+ID4gPiArICAgIGl0ZW1zOg0KPiA+ID4gPiArICAgICAgLSBjb25zdDogYWRzcF9zZWwN
Cj4gPiA+IA0KPiA+ID4gSXNuJ3QgdGhpcyBjYWxsZWQgYXVkaW9kc3AgaW4gb3RoZXIgYmluZGlu
Z3M/DQo+ID4gPiANCj4gPiANCj4gPiBZZXMsIGJ1dCBlc3NlbnRpYWxseSBpdCBpcyB0aGUgbXV4
IHNlbGVjdGlvbiBvZiB0aGUgQURTUCBjbG9jay4NCj4gPiBTbywgd291bGQgdXNpbmcgImFkc3Bf
c2VsIiBtYWtlIGl0IGNsZWFyZXI/DQo+ID4gDQo+IA0KPiBTbyBldmVyeSBuZXcgYmluZGluZyB3
aWxsIGNvbWUgd2l0aCBuZXcgbmFtZT8gU3RpY2sgdG8gdGhlIHNhbWUgbmFtZQ0KPiBpZg0KPiB0
aGlzIGlzIHRoZSBzYW1lIGNsb2NrLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
CkdvdCBpdCwgd2Ugd2lsbCBrZWVwIHRoZSBuYW1lIGNvbnNpc3RlbnQsIHRoYW5rcyBhIGxvdC4N
Cg0K

