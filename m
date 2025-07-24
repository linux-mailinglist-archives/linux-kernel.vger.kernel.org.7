Return-Path: <linux-kernel+bounces-743873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B90B1050D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAB837A5EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F396327F003;
	Thu, 24 Jul 2025 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mA5QXBuR";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ionMZN/2"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C4D27603A;
	Thu, 24 Jul 2025 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346641; cv=fail; b=BDWqBiqHyc8A/MTbEMJNomFEdBV9sw/6cOfQHPzHqWdb+wbiLSDM/AASTc2DbSvRBHdOChFuFtzflB/wyImPmAAgYD2BZueH98+zh0Yq6oaxgMnXQHBj3+n9b7CKdMmPnb2BJDdmjMbSuEzoDZBfG43JAS7lU1IMEyCrBxBqgls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346641; c=relaxed/simple;
	bh=zDeEqSd/rXbawZAlIPy/e2rox1MfZzN9UM8OFuD6E/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FkLHfUtHk+S2wSjdzm7UIb0BqV8xz6QZ96xEvCvIcr+lrJ49qY4vNW/k8+mmqm3bWUZQZ18p2VIyepOLWSI6kQsPht/tge8c3rswwTkTU5poNzk3b5iPsD3Vuj0QXpF9K3kjZFw720HnMGWq/50ziZ9eWX2Kfyxhrv+hmo9B908=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mA5QXBuR; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ionMZN/2; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 54f4914c686a11f08b7dc59d57013e23-20250724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zDeEqSd/rXbawZAlIPy/e2rox1MfZzN9UM8OFuD6E/g=;
	b=mA5QXBuRFzvH3fflAALri4zta8yAtQAiCzcZZreGAMR31uwkq5eKTp4vxT3JNp+9HiGEAbLVaub9duht6Qishs2GrP/pAIVHQOmE1o67TapG9uaTuGh+zVV1CbEliGaSNeFjxfAhl+U1zUtnR7WyETMj+kcSbCefEJo6KcfLrX0=;
X-CID-CACHE: Type:Local,Time:202507241559+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:b0c93721-18ce-405c-b48d-3f908cd213a4,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:987f3350-93b9-417a-b51d-915a29f1620f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 54f4914c686a11f08b7dc59d57013e23-20250724
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 98023718; Thu, 24 Jul 2025 16:43:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 24 Jul 2025 16:43:52 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 24 Jul 2025 16:43:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soQeka8FSEBWZu2C5rnpXuJhzPEt+l3d/GsAbyJLA/3/rd7zHF2Urgz6GX5eHFMi5lfnQYBL9CEhOb5EoS0MTt+mQxVI2+19IHllSzAqCHUIWjdQzuRQil90c91sL70I8ChXQJAfpOFJXvH8HT5ngxSG5QccoQ8ZR0TRQI6FzTkjVIxEoLyNXo+L6htV8su72t+/Nv9XTGUHy97C6rrr97w+XUyx2edDS/Tya3s0Jrv5scAErLtuttjLyZ7otPl/5cEpW36c3C/5trHvJHY80+IwU790TrlWVIq2Yl5wolmg+FKkVQEGr1HefiqeG2TcKhuB5ezlT5t71Nw7NI9hXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDeEqSd/rXbawZAlIPy/e2rox1MfZzN9UM8OFuD6E/g=;
 b=XuQm/x6wPORwduoYnjO0daCN3HU3EqbGi9EMq7KIpRT/lE8EFeksXveGv/Yqq1/aGiuzq5sslWD9t5BWK0rjL8qw03YDHpd29tQXluPdmxCRAZ2+RunxATySFMqZnLS/dJXcjTrnJE2upFRa62uyIfXR5Yg3/0dNNjkTxtSL3VSDtQ6WHanVuknQSWw5uFScru766b7MxjSmimKpO5eO+jkgz6AHmyPKSjvNzxKvyOAT1LoVFE/gF3O4HFUuGnqlpg5GjoXEnuYWIX7GuZCYfkBVMo7rwFc8oA5mTSsFI0MxpXbWBHKbJ2ipTHwEO4AGucVSjIx547bdINGgI2NcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDeEqSd/rXbawZAlIPy/e2rox1MfZzN9UM8OFuD6E/g=;
 b=ionMZN/2trbXiZXYoCuLxjKad+n6GDGEWWzIljTpqwoscQH3vjRNp1vsPa6er+H1rxeZsKf1BqUU0vtgcatfspNPllvkMG8uv6Y4xN9iJoaq+Odabwsd6+j63YCbCzdUwEW2NAs2VlR/0ZURRNR2PjCeoAIY5yv3zuif1XswDtU=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by TY0PR03MB7000.apcprd03.prod.outlook.com (2603:1096:400:27e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 08:43:50 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 08:43:49 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v8 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Topic: [PATCH v8 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Index: AQHbyhpymjbAswZs7UKlfaymlOtvZLP/xc+AgEEgbgCAAFkbgIAADkuAgAACvwCAAAmOAA==
Date: Thu, 24 Jul 2025 08:43:49 +0000
Message-ID: <2cc7a0be13d2b35b8728fb23e56097620a40fc05.camel@mediatek.com>
References: <20250521063347.31578-1-friday.yang@mediatek.com>
	 <20250521063347.31578-3-friday.yang@mediatek.com>
	 <fe4d93d1-fb6a-4985-8316-7a76fa1a481f@kernel.org>
	 <7421d8f4f3d5fdb392f46df93bfee21a97cc2e1c.camel@mediatek.com>
	 <633ea291-2e02-44be-bd03-220634b3c62d@kernel.org>
	 <d7e6e9f9da7adf5c806f29c577f6bf51b35fdeed.camel@mediatek.com>
	 <1e9de035-9d32-45d1-9f11-33c3439143be@kernel.org>
In-Reply-To: <1e9de035-9d32-45d1-9f11-33c3439143be@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|TY0PR03MB7000:EE_
x-ms-office365-filtering-correlation-id: 57bc059e-67a6-410b-3b14-08ddca8e35b6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OVloWmZhaDd2TmtJKzNjcmJnd3hZbDBRN3BsL01TK3lCZDlTRFRhWldBc0I0?=
 =?utf-8?B?MzZnVzJrSnE0NVV3UjRCWS9Xd0dqZjUwTjlRUnRDWWJ1bW1Oc3hQQjBTNE1S?=
 =?utf-8?B?QWNDaEwwY0RweDN1dGp3RXQyK0NjNnNxaXdZdytuUHREdDFmaW8xT0dyKy92?=
 =?utf-8?B?YkluLzlBK0p2MVdMM1ZBaVRxUm9teDhDVXlvQWJCS2hHL2M4eWtTbFl2V25U?=
 =?utf-8?B?R0ZFeUFDNVRXTnNMaXBqbVQwbDV1QXZWQWF1ODBaWUhCZTRtQmM2NTJPa3Zi?=
 =?utf-8?B?UzI3aFQyM0U1aVBqREM3YmdoWGFDR2IyQkoxU2JVRVdLdE5uYTduMzR0ak5Q?=
 =?utf-8?B?d0crWmovZnRXYk94L2lqVm8vSHZ6NXNUTnFRdU1pMEk4d2VITExKMjFqbEp3?=
 =?utf-8?B?V1ZFUzRtdDY3dUxZVDBTY29mVnZ1cnBZSjlja0UxMGpiUzRjWXk4dVlZUmRn?=
 =?utf-8?B?ZTd3Y3JlRFk2TTNHYnZTcXlKVlkxcEtBbHMzcjEzZFNIVkZ6V3BZL2JmLzFk?=
 =?utf-8?B?QXRWTzlqRmM3Uk51QWZNWWRZWUx2QzhMVzRMc0dEOXlPL2pGUmx3Qmg0REtF?=
 =?utf-8?B?ZmR6aGxpYUlteFpnR0VGUEQwMzdUUHVPb0xVSHRLVDBnY0lRc3Z5NFoyTGpQ?=
 =?utf-8?B?QnJwODc0ZzkyNjBoT1c0MkJkdDUwWldZSlg2YWpad3ZtbTEyME5pYi9mSVJz?=
 =?utf-8?B?cjVMZXAxU0NXeWcwMFM2M3JhY05LZlZEb0kveS9lMGlScHZpeHpQNk0vaDA2?=
 =?utf-8?B?Rzdzc3Z2cXVxRkxZZGFFb2RpeUNTazliSXdTb1RpS016ejlDUGgwS3ZwQ2xG?=
 =?utf-8?B?OGlEREJIZXZ3WjJDbUJsZjlTMEFWUWM3Yys1QjJVU0VUc2xRNHVzVEZGUENJ?=
 =?utf-8?B?c3pTWEh2SngzL25wdTdoUW0vaWo4blNDOTBuS3l1dUNNdmdwTDNBY1I2cSs2?=
 =?utf-8?B?ajI4K3dRajBFVStUa1FkZEJPaHFITkVlWEtDb0FMZzJCcDBOc0xBdG1CaUpY?=
 =?utf-8?B?TS8rTGh2VjBKMXdvQnozb2tUVWJ0bU05UGNEZ2dGUks0NkpIRjZjNFVyWFNh?=
 =?utf-8?B?WXErSjFPYnNJSTB6S1dpNVovaEZVM0tKN0svU0JaZVlRc2FrbHRRYnAxald3?=
 =?utf-8?B?aDZpNjlkK3hrbGthWUQ0SzBaQU5ja05DbUFINFNRbklmdndESGpMaC9aNFBn?=
 =?utf-8?B?YXpMUVExMUNVbGh5SThYL2pkUUJyY0xnZmpTTFIzOXBIM1JGNWd4dDhRQ0hM?=
 =?utf-8?B?bE5vY1lSZG1WMzhsZWhXckNhTlpnYlJ2L3JJeVhOWVhiZGNRNjZsRVBLM0NX?=
 =?utf-8?B?dGZGSlY4T3J0M2hVZG5JVjA0WkxYWjkyQjdXdS9JN2M5MlBrb1ZzblEvclJv?=
 =?utf-8?B?ejdEbDI2RFU4UC9IZ2F2NFZwNm5zWWQvQTlZUVVCMG90Uno5NlpuR3ljMld2?=
 =?utf-8?B?VUJCLzBwUTkxRUpUUVFuQzBlZjFpa3pIR0RSNTRibi9xNDJFcTE5a0VtdUEw?=
 =?utf-8?B?ODNaVDZDNFgzaGhGU2ROZmJWVUpoSE1ZMzVibjBsN202amdTcWExNlAxc1Nw?=
 =?utf-8?B?Z280c2p2djdrZWZQTVhqenRlcmhHSWUwRmw2dExzRjkrUUN2dDVKTVp5RXZz?=
 =?utf-8?B?bHZ5S05UT2I3cEdvWVZqRktCWjlTeXBjMm0zek1xc3RnUjZaNGlkbmhOZ3NY?=
 =?utf-8?B?V3N2NUFEYjVZUmxLS25nMHVmWnJPaDFiZndzWGQrSTA2UlprOHVkWXR2U2R4?=
 =?utf-8?B?VnRveENxekN1SXB3T3JWd09DQURFOE9KalJTRm8xMEdoNFV3aGlBZ3U2c095?=
 =?utf-8?B?WCtMMzdJRW5JQnJOSFY3Tjl0SjVhUlB4cWtyeU9DWUtBcEdzWGgxOU1iQXdF?=
 =?utf-8?B?QmFSMzFoVmp0NmZsK1dBdHVmdFZySWUxREFaWWk4TWVUUi92SzlqT0dxeWdT?=
 =?utf-8?B?djM2ei9iN29ITEcxQ3R4MkRSdlpSVnNkbUwrb3h0N1hEYzdBekZ1VCtya3Jz?=
 =?utf-8?Q?kX8viWXu94/Um+zO4IjokP6tJMujnQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3h1eEhPempleS9xZ0FPVVJuS3paMEJmUks3dk1nRWNiSm1vWFVUeEJmYk9X?=
 =?utf-8?B?WWw5cHdxYWhNNGdTUFZJM1phQTRHMkoyUDNWcU96N2dFWEpWc3FJNkNUcGdr?=
 =?utf-8?B?MjhGZlIrZXJIbVBWMHZTaXlWdEZHcmU2Titrc2pnM3NEMmIyUGx5SHJoN1ow?=
 =?utf-8?B?UXRpdHhxS1lRUmtoZEQ2Lzh6eFlySUZMaFlyaFJ0WXV6Rkh1V09tKzdVeGU2?=
 =?utf-8?B?WmFLTEt1TExuUWR2ZCsrclJMOWtrNHF5UTAyVkc1Ym1yUGNJcjQzV1lQTnk0?=
 =?utf-8?B?WXl4bUJKOVovWEtkeFR3b0wwaTNleU9ZWCsrWWU2RjlXSkV2TUdTdzhtRUFH?=
 =?utf-8?B?S3pNREJPZ0F6eU9FUHNWVHFFVnVWWm45V2l6TmhEZWhEa1FhQkZqTXFwMHEv?=
 =?utf-8?B?bGZtWHNneFVLTG94Y3cya0ZNc0ZKTmJkTk4zajRGWnRUNkxzU1kwRk1QRisv?=
 =?utf-8?B?cEVTaXRvRDZUUlBMNEU5dGxKSzVQWitzY2JHcVg5T1ZDTHA1ZXd5QUlrMFE5?=
 =?utf-8?B?bW5TWjAwTmFTcVpQZXlBMC9DaVVYMWFvOVhobit2TFZpMFhFREJpSG1nMXpY?=
 =?utf-8?B?OWxrdkZqYW9xYkVlOVlwdlRkQnR5cXJrcVlHQ2VidCsya21peE8vMGFZVnRX?=
 =?utf-8?B?eVdKLzA0ck8zZGhOdkpjTGdtd2x0K2wyV1FObXlkS1hRWHJwSEk3cmhuaVhW?=
 =?utf-8?B?VU9xekRPRFhWWGplSHFSVTlFYThySy90czNaWS81bTB3Uk9IQkhxSUJMZkVs?=
 =?utf-8?B?a3J5ek9FNTUrMSttWm8wU3k3QUd0ZEk1OUh3OFBCZXhhRlRPbHlpY3lhdlZS?=
 =?utf-8?B?Q1BGUEdnREhaZkloYWVPajJIN21xYjcxeG8yem5BTGRIWG95bDI4WXBBTkJn?=
 =?utf-8?B?U202RVB0Snp4bXk0Q1loTmNiRWpTY1l5cVZnZnNxY1Jvbk9kQ0JGWDltK0dJ?=
 =?utf-8?B?bmVNSkxDbDZBdjRoeWYyVFYzVk9MU2crNWt6OWNzQTFxaldNbmxnUlZ1S3Ju?=
 =?utf-8?B?VitGbTFPVTlic24xV1FZeVR3S1JaN1l5aVk1dEx0a2xacWo0ODIzQkhtMVZu?=
 =?utf-8?B?NFJkZ3hpNmtzU3BQWmluZXRadlkrblBKMGQvMG5iMC81MW1BeDlRL1M2SUxm?=
 =?utf-8?B?NHhqZFNhZEsxSnhYNkFJL0UxcHJLODdxZ1lhRWxjMWZnNVJxZ3pFeDllcVFx?=
 =?utf-8?B?OXRBRGdYZ05QVm9NRnIrVHdoejNtcGV4Nk1jdXI5NEpwdFVXeHJKM29yM05n?=
 =?utf-8?B?dUZ2ZnUvTklDTWpJcS9DOUtPZHY2WllGMUwwQmdyY3l6WnNUbWJvbUp4bUsz?=
 =?utf-8?B?blJYZEhKR29ySE14elNjRmwyWG9saTZXbGpocEhic1MyK0cxMEYyaEg1NHBX?=
 =?utf-8?B?R2YrbnVDMUpHeEg4bTI0dE1YTFZrdWRSQnRYY3BpWXkxLzVPMkx4ZlQ4cWVq?=
 =?utf-8?B?Ym9nQzdnN3RKNnpFYk1OQzBna0cyWkgvbnF4UDY2dHpYY2J6VHlDd2hPUVp1?=
 =?utf-8?B?QXpqMHNnT3JiYWVOL0tkaEU2by8yR0FHLyttbDJsS3Zhb3JlRUhoSDdQaHdl?=
 =?utf-8?B?bUJvWkFhWGtpZExsNmRyZENjM1ByT0ticDVkTUFDa2M5OUYybFN3Z1Q3VWoz?=
 =?utf-8?B?VmwvbGxaZ0pzdlVJMmRjNFVwekIzY3lhanY0K3BPc2FyYklFa2FLVnUybFph?=
 =?utf-8?B?MUdxRjdEVi9uRFcyWTlyejU0cWRyVklNZmo4UXJZRFJ0TzBpT0UxK2dXSUho?=
 =?utf-8?B?V2c0b3BROGNrdEJUeURTUUY1Z0xzK0NXUXc0UlBoamFTdERNckh6OXdqcWUw?=
 =?utf-8?B?TFFWdGwxQkp5UzdqbzhzN3hPYXdEbnVPUFFvNXhxZ25BRlpaZ2NwU0UvYXpi?=
 =?utf-8?B?dDhUa0JNMURQREpOMnNHcTRvSVMzOXBQT2xXVytMbGtQdFdRMXA0a0tna3Np?=
 =?utf-8?B?c0N5SEhmVDcvKy9JTjVhaGVPY3hRMGlXSzhpeVpCVDRPVWR6bVJHT3hmYzF5?=
 =?utf-8?B?QUhVRi9Xc3gwblJTNWhjK2p3UStDdm11cW5mUDhVOG40TzVTOERlNEg4c3Vi?=
 =?utf-8?B?L3Q1QWRpZUpPcmNkUFlFc0hlZzRSVjJhcExJTVpVcE82Ni9ZWkg4WXdpZHNE?=
 =?utf-8?B?emZwUVV3QVZNdmw3ZVZORkpNUS9PemtoZ0dLdkY3ejgweDdnQmt4N2lFTGl1?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6550D372124F848968824F3387C81E7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bc059e-67a6-410b-3b14-08ddca8e35b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 08:43:49.1738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vY5ab0wKjwEeanBXEw1vupEvtRmP8Pu+VRvhkdqKFnZiupAaqayo8tzQPDHrut+1FJA8J+/MBTt0hw85VYK7L+PcHEcO8crgD4uQKuOih8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB7000

T24gVGh1LCAyMDI1LTA3LTI0IGF0IDEwOjA5ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDI0LzA3LzIwMjUgMDk6NTksIEZyaWRheSBZYW5nICjm
najpmLMpIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyNS0wNy0yNCBhdCAwOTowOCArMDIwMCwgS3J6
eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gPiB1bnRpbA0KPiA+ID4g
eW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+
ID4gDQo+ID4gPiBPbiAyNC8wNy8yMDI1IDAzOjQ5LCBGcmlkYXkgWWFuZyAo5p2o6ZizKSB3cm90
ZToNCj4gPiA+ID4gT24gVGh1LCAyMDI1LTA2LTEyIGF0IDE3OjE2ICswMjAwLCBLcnp5c3p0b2Yg
S296bG93c2tpIHdyb3RlOg0KPiA+ID4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuDQo+ID4gPiA+ID4gYXR0YWNobWVudHMNCj4gPiA+ID4gPiB1
bnRpbA0KPiA+ID4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gMjEvMDUvMjAyNSAwODoz
MywgRnJpZGF5IFlhbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiBGcm9tOiAiRnJpZGF5IFlhbmciIDxm
cmlkYXkueWFuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRvIHBy
ZXZlbnQgaGFuZGxpbmcgZ2xpdGNoIHNpZ25hbHMgZHVyaW5nIE1UQ01PUyBvbi9vZmYNCj4gPiA+
ID4gPiA+IHRyYW5zaXRpb25zLA0KPiA+ID4gPiA+ID4gU01JIHJlcXVpcmVzIGNsYW1wIGFuZCBy
ZXNldCBvcGVyYXRpb25zLiBQYXJzZSB0aGUgcmVzZXQNCj4gPiA+ID4gPiA+IHNldHRpbmdzDQo+
ID4gPiA+ID4gPiBmb3INCj4gPiA+ID4gPiA+IFNNSSBMQVJCcyBhbmQgdGhlIGNsYW1wIHNldHRp
bmdzIGZvciB0aGUgU01JIFN1Yi1Db21tb24uDQo+ID4gPiA+ID4gPiBSZWdpc3Rlcg0KPiA+ID4g
PiA+ID4gZ2VucGQgY2FsbGJhY2sgZm9yIHRoZSBTTUkgTEFSQnMgbG9jYXRlZCBpbiBpbWFnZSwg
Y2FtZXJhDQo+ID4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiA+IElQRQ0KPiA+ID4gPiA+ID4gc3Vi
c3lzdGVtcywgYW5kIGFwcGx5IHJlc2V0IGFuZCBjbGFtcCBvcGVyYXRpb25zIHdpdGhpbiB0aGUN
Cj4gPiA+ID4gPiA+IGNhbGxiYWNrLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBGcmlkYXkgWWFuZyA8ZnJpZGF5LnlhbmdAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+
ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gPiA+ID4gPiA+
IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiA+ID4gPiA+IEFj
a2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IFlvdSBkaWQgbm90IHJlc3BvbmQgdG8gcHJldmlvdXMgcmV2aWV3LiBTZW5kaW5nIHRoZSBz
YW1lDQo+ID4gPiA+ID4gd2hpbGUNCj4gPiA+ID4gPiBpZ25vcmluZw0KPiA+ID4gPiA+IHByZXZp
b3VzIHJldmlldyBpcyBvYnZpb3VzIE5BSy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+
IEFwb2xvZ2llcyBmb3IgbWlzc2luZyB0aGUgbWVzc2FnZS4gSW4gdGhlIHY2IHBhdGNoLCBJIHJl
cGxhY2VkDQo+ID4gPiA+ICdwbV9ydW50aW1lX2VuYWJsZScgd2l0aCAnZGV2bV9wbV9ydW50aW1l
X2VuYWJsZScuIFlvdSBwb2ludGVkDQo+ID4gPiA+IG91dA0KPiA+ID4gPiB0aGF0DQo+ID4gPiA+
IHRoaXMgY2hhbmdlIG1pZ2h0IGFsdGVyIHRoZSBjbGVhbnVwIG9yZGVyIGFuZCBwb3RlbnRpYWxs
eQ0KPiA+ID4gPiBpbnRyb2R1Y2UNCj4gPiA+ID4gZXJyb3JzLg0KPiA+ID4gPiANCj4gPiA+ID4g
djY6DQo+ID4gPiA+IA0KPiA+IA0KPiA+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8y
MDI1MDQwODAzMzIwNi4xMjE3Ni0zLWZyaWRheS55YW5nQG1lZGlhdGVrLmNvbS8NCj4gPiA+ID4g
DQo+ID4gPiA+IFRoZXJlZm9yZSwgaW4gdGhlIHY3IHBhdGNoLCBJIHJldmVydGVkIHRoaXMgY2hh
bmdlIGFuZA0KPiA+ID4gPiBjb250aW51ZWQNCj4gPiA+ID4gdXNpbmcNCj4gPiA+ID4gJ3BtX3J1
bnRpbWVfZW5hYmxlJyBpbiB0aGUgU01JIGRyaXZlci4gSG93ZXZlciwgSSBkaWQgbm90DQo+ID4g
PiA+IGluY2x1ZGUgYQ0KPiA+ID4gPiBjbGVhciBkZXNjcmlwdGlvbiBvZiB0aGUgY2hhbmdlcyBi
ZXR3ZWVuIHY2IGFuZCB2NyBpbiB0aGUgY292ZXINCj4gPiA+ID4gbGV0dGVyLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gdjc6DQo+ID4gPiA+IA0KPiA+IA0KPiA+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC85ZjAxYTlhNC04OWIyLTRiZmMtOTdjZC04MjdiZTk4OWVmMTZAa2VybmVsLm9yZy8N
Cj4gPiA+ID4gDQo+ID4gPiA+IEluIHRoZSB2OCBwYXRjaCwgSSBoYXZlIGFkZGVkIGEgZGVzY3Jp
cHRpb24gaW4gdGhlIGNvdmVyDQo+ID4gPiA+IGxldHRlci4NCj4gPiA+ID4gVGhpcyBzZXJpZXMg
anVzdCBhZGQgZnVuY3Rpb25zIGZvciBTTUkgY2xhbXAgYW5kIG5vdCBjaGFuZ2UNCj4gPiA+ID4g
YW55dGhpbmcNCj4gPiA+ID4gZWxzZS4gSXMgdGhpcyBhY2NlcHRhYmxlIHRvIHlvdT8NCj4gPiA+
IA0KPiA+ID4gVGhhdCB3YXMgbW9udGggYWdvLiBOb3RoaW5nIGZvcm0gdGhpcyB0aHJlYWQgaXMg
aW4gbXkgbWVtb3J5LA0KPiA+ID4gbm90aGluZw0KPiA+ID4gaXMNCj4gPiA+IGluIHRoZSBtYWls
Ym94LiBUaGVyZSBpcyBubyBjb3ZlciBsZXR0ZXIgdG8gZmluZCBhbnltb3JlLg0KPiA+ID4gDQo+
ID4gPiBBbnl3YXksIHlvdSBkaWQgbm90IHJlc3BvbmQgdG8gdGhlIGFjdHVhbCBjb21tZW50IGFu
ZCB5b3Ugc2VuZA0KPiA+ID4gdGhlDQo+ID4gPiBzYW1lLg0KPiA+ID4gTm93IHlvdSByZXNwb25k
Li4uIHRvIHNvbWV0aGluZyBlbHNlIHN0aWxsIGlnbm9yaW5nIHRoZSBjb21tZW50DQo+ID4gPiBh
Ym91dA0KPiA+ID4gZmFrZSB0YWdzLg0KPiA+ID4gDQo+ID4gPiBJIHdpbGwgbm90IGJlIHdhc3Rp
bmcgbW9yZSB0aW1lIG9uIHRoaXMgcGF0Y2hzZXQuDQo+ID4gPiANCj4gPiANCj4gPiBDaGFuZ2Vz
IHY3Og0KPiA+IC0gUmVtb3ZlIHRoZSAnZGV2bV9wbV9ydW50aW1lX2VuYWJsZScgY2hhbmdlLg0K
PiA+IA0KPiA+IEFib3ZlIGlzIHRoZSB0YWcgeW91IGFzay4gWW91IGFyZSByaWdodCwgdGhlDQo+
ID4gJ2Rldm1fcG1fcnVudGltZV9lbmFibGUnDQo+ID4gdGFnIEkgbWVudGlvbmRlZCBpbiB0aGUg
cGF0Y2hzZXQgdjYgaXMgdHJ1bHkgYSBmYWtlIHRhZy4gU28gcGxlYXNlDQo+IA0KPiBUaGlzIGlz
IGEgZnVuY3Rpb24uIE5vdCBhIHRhZy4gSSBhc2tlZCBhYm91dCB0YWcuDQo+IA0KPiA+IGlnbm9y
ZSB0aGlzIHRhZy4gV2hhdCBJIGludGVuZGVkIHRvIGV4cGxhaW4gaGVyZSB3YXMgdGhhdCBJIGRl
Y2lkZWQNCj4gPiBub3QNCj4gPiB0byB1c2UgJ2Rldm1fcG1fcnVudGltZV9lbmFibGUnIHRvIHJl
cGxhY2UgJ3BtX3J1bnRpbWVfZW5hYmxlJw0KPiA+IGZ1bmN0aW9ucy4gVW5mb3J0dW5hdGVseSwg
dGhlIGZha2UgdGFnIGRpZG4ndCBleHBsYWluIHRoaXMgY2xlYXJseQ0KPiA+IGluDQo+ID4gdGhl
IGNoYW5nZWxvZywgd2hpY2ggd2FzIG15IGZhdWx0LiBUbyBhZGRyZXNzIHRoaXMsIEkgdXBkYXRl
ZA0KPiA+IHBhdGNoc2V0DQo+ID4gdjggdG8gaW5jbHVkZSBhbiBleHBsYW5hdGlvbi4NCj4gPiAN
Cj4gPiBJbiBwYXRjaHNldCB2NiwgSSByZXBsYWNlZCAncG1fcnVudGltZV9lbmFibGUnIHdpdGgN
Cj4gPiAnZGV2bV9wbV9ydW50aW1lX2VuYWJsZScuIEhvd2V2ZXIsIGluIHBhdGNoc2V0IHY4LCBJ
IHJldmVydGVkIHRoaXMNCj4gPiBjaGFuZ2UgYW5kIGluY2x1ZGVkIHRoZSByZWFzb24gZm9yIHRo
aXMgZGVjaXNpb24gaW4gdGhlIGNoYW5nZWxvZy4NCj4gPiBBcG9sb2dpemUgZm9yIHRoZSBkZWxh
eSBhbmQgdGhlIHRyb3VibGUgYWdhaW4uDQo+IA0KPiBOb3RoaW5nIGFib3ZlIGlzIHJlbGF0ZWQg
dG8gbXkgcXVlc3Rpb24gYWJvdXQgdGhlDQo+IGZha2UvaW52ZW50ZWQvcXVlc3Rpb25lZCB0YWcu
DQo+IA0KDQpJIGdvdCB5b3VyIHBvaW50LCB5b3UgcmVmZXIgdG8gdGhlICdyZXZpZXdlZC1ieScg
YW5kICdhY2tlZC1ieScgdGFnIGluDQp0aGlzIHBhdGNoLg0KVGhlc2UgYXJlIHRoZSB0YWdzIGZy
b20gdHdvIHJldmlld2Vycy4NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8xNzQxNzIz
NjEzNzguNDQ2NTAuMTUzNDUyMDIwNDI3ODAzODMzMjYucm9iaEBrZXJuZWwub3JnLw0KDQoNCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvOWRjYTg3NzItNmJjMC00MTA1LTk4ZDctZTRmODA0
YjBkNjM3QGNvbGxhYm9yYS5jb20vDQoNCkFuZCB0YWcgZnJvbSAnWW9uZy5XdUBtZWRpYXRlay5j
b20nIHNob3VsZCBiZSBkZWxldGVkLiBIZSBqdXN0IHJldmlld2VkDQp0aGlzIHBhdGNoIGluIG10
ayBpbnRlcm5hbCBnZXJyaXQgYW5kIGRpZCBub3QgbWFrZSBpdCBwdWJpbGMuIFNvIEkNCmRlbGV0
ZSB0aGlzIHRhZyBmcm9tIHRoZSBwYXRjaC4gSSBjb3VsZCBhc2sgaGltIHRvIGhlbHAgcmVwbHkg
YQ0KJ3Jldmlld2VkLWJ5JyB0YWcgaWYgbmVjZXNzYXJ5Lg0KVGhhbmtzIGZvciBhbGwuDQoNCg0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

