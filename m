Return-Path: <linux-kernel+bounces-747531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D129B134DB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932B11760C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE70221278;
	Mon, 28 Jul 2025 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eVDu62XR";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="SH6esJan"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003DB86344;
	Mon, 28 Jul 2025 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753683706; cv=fail; b=Tzf3zGQaxJ4Fywef14RtUpYIwjRWU90w8pma4gALXQtShfTby2SeoHAjSKWEK9Bj4mZabKPp4MGui/7HIcylLOy5VtcCpcmCStMPC9eyEGTeMYJuvjii9bMN4OGOZ8Vfvxov3GKL5YBtUd2mgpiakmbzSuCzG92d4MAnBRKuhtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753683706; c=relaxed/simple;
	bh=0uxEQ0uKZesJSKti9CM81Y1oPPvdI+fuzziT8P3uMTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B7BW2TgS8r6bJHlma9w1O9A5q6kVMoFJnQ1NpGAtT0avZAE5/YrGycqdg2A+g8lCaQL8IDjekOiMnUswGXux8Vl+j5+cnt/tThcwDdUJfl7KDakHj7/2MLtLEOsm89QchJtcBH9n2YvkFiF7OYtybarUPcnlPLPrgdYX5tdCV0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eVDu62XR; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=SH6esJan; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1fb023d46b7b11f08b7dc59d57013e23-20250728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0uxEQ0uKZesJSKti9CM81Y1oPPvdI+fuzziT8P3uMTc=;
	b=eVDu62XRRYFGoGbPCuFQFQly2Rbj2BNuyQY2GYWZ1VcujedAShxO0ISCwUwNhv4dpX+n6wgMgaGRWUC5d6Ve7VOQPfs+YlrMOJAQ6SG5iFzDOs1PFa6Bn4ttbrczvPEkHtWl4LQU+gmlNCUQdADf3gPcqZs1hc0ZPz1ztoup4vY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:5b127c7c-b5be-493d-964a-c3220f324081,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:9fc23d0f-6968-429c-a74d-a1cce2b698bd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1fb023d46b7b11f08b7dc59d57013e23-20250728
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2022051603; Mon, 28 Jul 2025 14:21:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 28 Jul 2025 14:21:37 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 28 Jul 2025 14:21:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiBIdjlAiYamodcjJc6V4ado00eNVFcEaLU0ujqh+SsiM6pmAT1lrzl0Ywsk+SIjCoVwKJygDCe0IVdjTuycstBE65NLCixXNqR2N90+6d0ORenIu6gq4Y5a7Q4JT00JiyMyic0OCcpkrpiPEXY0Zlr00SNksiu2EcQkR1x78Qeb3ysKGlnOE3i1J/Cwl0UdQWk4Ag5Ka75IUwKOfXephVsxnUmZAKRGeMMA17sHDtlUU6Tg/6M8rlTqsSUoMiZ56CRS960wvjOUyjO9OlOhih1sxtIeznT0HP/Y7lgKvIAbD6Stz2CITWFu9+CV+NiwA/2XOMtCMYI8L42Xb6BeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uxEQ0uKZesJSKti9CM81Y1oPPvdI+fuzziT8P3uMTc=;
 b=dwzf9BWebFOBgO8Ei9hAGg6+OV6srUKg9nUyr4duKKfFzswVyXI20QmGKJL8JVhl7wULrM8EvPxpHTavhdLwO1wZSJmEQU6t/1/57hZwJFGTs13Ix9eY15IjwPIjx0C6i8pIkmnJINQ6TBcRzx1cFnjHuedZRZJHc0kl15zRwTDaja7y68N2+zqPH+AK/PvMXhUWu3eks/CwG4/knJYmxsiwpT5m36sC8jPdjjFIiM6HeU9mAChaWGWSfaicxUv3BPcZDNs5ag/l+VnxT4ux6jFXr1kGwHwEpIqd4B/DaHtW2FO/JRwsNQNL8d/aDFeVxJV+UXTx/URugyljlTIJ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uxEQ0uKZesJSKti9CM81Y1oPPvdI+fuzziT8P3uMTc=;
 b=SH6esJan51Ndih2D0sG8bzNWQpsAJd0HbxhuVCbEimHwSmXH9oDTVkEkkaR43R6i/2S6yTwimQZbjbljqKCqoyy0tywsPujwkprP/nvh8DK4VTeyGdaJKVhhzsGh3c2Shq9x3bxMtQ/3A+hiaT98Y2J+xZhlOSu5/OjSa7mEw1w=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by SE2PPF9D8ADABD2.apcprd03.prod.outlook.com (2603:1096:108:1::49f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:21:36 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 06:21:36 +0000
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
Subject: Re: [PATCH v7 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Topic: [PATCH v7 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Index: AQHbubTGkmH/7Q97fUK8yI7GEpvvKbPCgMwAgIUbhQA=
Date: Mon, 28 Jul 2025 06:21:35 +0000
Message-ID: <5ee8b669b93b18eed00329be90595539bc4f3e9f.camel@mediatek.com>
References: <20250430094545.23932-1-friday.yang@mediatek.com>
	 <20250430094545.23932-3-friday.yang@mediatek.com>
	 <9f01a9a4-89b2-4bfc-97cd-827be989ef16@kernel.org>
In-Reply-To: <9f01a9a4-89b2-4bfc-97cd-827be989ef16@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|SE2PPF9D8ADABD2:EE_
x-ms-office365-filtering-correlation-id: dfb46ef4-1491-4c38-9103-08ddcd9f0129
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?KzVMTW16cW5HZnl5UTdpWWVZQUZoOVFDaUlzM29qMENNZWVvYnhEQ1pFMnk4?=
 =?utf-8?B?M3VPZ09LTFU3K3JSQm9IR0dxaHJ0Yy9jTFRhU2c0RE43UzFRWE50L1k4Mm1t?=
 =?utf-8?B?Y1RVMktpYk9LVmRLSG1Ka2thSHVCOEVWWDBTTVVQOU8ycmZvcm1uTEVhVzF3?=
 =?utf-8?B?UTVlVXJaa0NsVzlNOGtKWTJwV1ZZclNKdi9oc2xpcVZvU1BvS1dFL3FSK2J0?=
 =?utf-8?B?L3hrQ1pSWnZVSHpYcDdOSkIzbG5SaDBwVy9nZWRPbnNRWHppN2JVNEhvRGk0?=
 =?utf-8?B?a280RDB2Q0JoSmwyd213OFM3V2llQ00wSUUxR3hWZE1xQ2orVjNNU0NQUGZU?=
 =?utf-8?B?RTFIUSsxTGtxaHJIWDg1c0FDK0xReFpKSDdlVnROUHc1cTUvYUZZRmUycHpk?=
 =?utf-8?B?M09SRmxmSm9oU1RyU1ZxOVI1aEZVaCtTbUdsSXZrYTZSdVlSVHREbHFoWjd6?=
 =?utf-8?B?Y0pYNVZ5Nk0wRHkrd2Z1enJETUxnNjRLbEcxdEUzaHhUeHlteGVXeDZ0REhP?=
 =?utf-8?B?YWFXa3ZkUWc2bTBHZEcxVXZXM1RFQThuZmlNU3FEMU9uQm1NZGQzeUlGV3BY?=
 =?utf-8?B?STZ4YzV3Q2hZZDdVcGo5NlRhTzZwWkswbW9oUFRNM0xFUmpRdmJNMVAzWU9z?=
 =?utf-8?B?WURKTUFqTHFqWnhlaGUwMWpEVmRZWHBlUjg2OEU1U09BMU9IZVZkR0lha2t3?=
 =?utf-8?B?Si9DbmNKSUxLU2R1TnowM2JrekpwVnZOdTU4eGVJbU9nSDNUYjFnZ1R3NTVN?=
 =?utf-8?B?ZUVWd0NudmtNYzlTZi9Ua0E0N3FJeWRVSE92Qmh2UlhBMW5kZVMva2ZMVHZu?=
 =?utf-8?B?L1doTU5sYUJJTVNPME5QaTIrck91eDRzekZQczhXY0V0WDhtMTByWDFmNDlh?=
 =?utf-8?B?YXNZdjRlVzNNYXFRL25Kd1d5TjVVaHV4RnR4ckg2V05uTmNtRXBmRzhpQ2wy?=
 =?utf-8?B?TkxsMkZmdHl5Wjl4UXJ0c3BCeUp4VURSNElRdE4vc1dsSC9RZTllamNTamNZ?=
 =?utf-8?B?VVZzd1I4QjdGdnFyMDgreHRKTTR4bDhWSDNhekpTVUo4d1ZRRzNkalJ5SnNK?=
 =?utf-8?B?VVJZcllaakhnTVlOU29BQVhBYnQvTEdwRjdLeERZcG03aEk5dmdPVEVDb1hy?=
 =?utf-8?B?QjE2eWhVTy9wZXNNd0Y3VW5TZHR2WG5WbnQrNzA1WkhZNElKZ1hRK0NMd3Nl?=
 =?utf-8?B?UWFoSGF5dXBWZkV3d1prdEUrbTk3Q2NMdVU0TG9ZMmVEWmVtNEY5MlBSQVgy?=
 =?utf-8?B?bm1vOGdwU1BEUmc1SENyZmpyM0JxdlZKZy94blFyN0FyTUV1WVFCZElucEdk?=
 =?utf-8?B?K0FRUGdBYzlOTkoyUStIWGZ3c1g2VWJINTJwSEJqWG5qNU5DL2h0akpHUEpN?=
 =?utf-8?B?Q3dlWTg1K212c3pRTk12SkEyd0x1aUhSTXlTSEJDWnNiY1hidTZNTDJZZEd3?=
 =?utf-8?B?QjQzQ2VCNDd0WG5wZ0Y3VE1nNWFkZ2RZOU9xbWVCS3gzVlRNR1FaUkcrcmx3?=
 =?utf-8?B?M1JwZFFjeHovbnRxeXppL3c0YzVRdmxIQ3ZiTEx6VjJOdVJ0Z25PY1NVNWlU?=
 =?utf-8?B?WmZ3VjZEQThLd0dCVzRrZ2VrS3FJZDhQZVNlTXo2R1c4R1JKRkFxM242YXZP?=
 =?utf-8?B?cUpiL04rS09OM095c05OMkhPTEx4bGZCcVZWdG9HZGRHNGQwR3ljci9SSVdh?=
 =?utf-8?B?UUtiMUd3R0dvajBBWkZmZlJXTDl3SnAvZy9mTEVNV1VGSzh0TVFGc3NMWGgw?=
 =?utf-8?B?ajB6U0NDT3huazBYWFZ2RjlpTzM5alVrL2FOUUt6RUxvOVlRVU9ERysxc1B5?=
 =?utf-8?B?M05qblBYYlhYMUxyalRuZWJLTUpyeUZrd29EMmxQS3ZUNUlRN0l2Mk8xa0U3?=
 =?utf-8?B?cXZjZXZuWFpObFBqcm5nRFFTUmI1cUR5cWx3MUp1eCtrVDZXZTM4UThRYWwx?=
 =?utf-8?B?RlgwQVowYjEzTDhZWklwRXZCVFJMWC8rYjJhVTZKNkwxVEpuOWlEWmRxQzMv?=
 =?utf-8?B?SmgvSi9zbnJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjN6WFpxMXVTSzVSMk05Z3dKREhMRW83TlVjM2xyV2NDS0pLQXRXWThCL3hW?=
 =?utf-8?B?YWNNaHQvem4zTEdZRm8zRkVZbElxbG8yczZUMTd5RlhocWdHN09tTWZYL3ZT?=
 =?utf-8?B?V3grNldHc1hMOW9MYUZRNHU4a0Z6VHVCc3RkdkZtKzF2WXdyMUozWCtpQW9V?=
 =?utf-8?B?UUE0clUwUWFOd1VaZTVoOGJtK21ocEpFdEQwelVwNGVOSU9Bc0Rxd1k1ZjVr?=
 =?utf-8?B?WDhKNi91aUFuT2gxTzJEMDhYZEovQzlqeXYwQTh3OUxLTi9aQy9WdEJOcllU?=
 =?utf-8?B?aDVGbmdrTTJHRk9HallVd29jdmRZOTdvSnlucmQ4K29vVExkMWN3SXJTWEJy?=
 =?utf-8?B?RzlLQkFEaWFzNk83NHp3aU5MczVJWTl3b1R1enh1ZEtGQzVzM2xDUUVhSGpL?=
 =?utf-8?B?V2RyL2tEZUF2QTh2NTQyK2I1SFNISzV2ZWswZ0tLNFArNkZhWjJKVUdsOSsr?=
 =?utf-8?B?MHBCRVNqSFNYd2RXaUNvdElJWEZzYUwxcjFOcjJ0bTlkemRnV1dDd2RFVzNH?=
 =?utf-8?B?NWNrS0VaOWpnRlZYVWN0ck43UTJUSWNSU01lK0hwZjc2c2V5U0d2Zmk5eG5P?=
 =?utf-8?B?Z3lSckM1QU1iNjBjeUlldGIvQ3Q1TGlVWlNGV0dpWnpZcGc5RXBIa0V5emFD?=
 =?utf-8?B?Z05GMURBaDFiU1B3TTZheWxiTEZnU1oxTEtOanpmVUpYNmFFTTgxcGNFcGRQ?=
 =?utf-8?B?em9NMS9Bd3RWd3lhdm1GUk9FdHh5NWphVStFNlF0VXh6eHhjMVZDMXUveTlX?=
 =?utf-8?B?cW81ZjRqYjFyTUxjdjdHYzhnU2xxSXVVcVVyaGplbldvb2R1SlRhUnZMMkNn?=
 =?utf-8?B?czVDbFFJMjkrY3IrNUV3aDkxQjIvM2tObnpBb1hrenFEdXIxUitxNWI1dVJu?=
 =?utf-8?B?SzdrVHBRaWNmK1RyTm1BZkNZbDFrNVVTbklJUWl0OWNPdk5Ib3Mrdnd1Smlx?=
 =?utf-8?B?UDBuVFEyeTByMS84UlNwZXg4aExmYXR0Q0JmNUV6WjFXSS9IMlhsck5uVVc0?=
 =?utf-8?B?eGVzQWIxbWFIUk15aXVRd3ZSTWlyRnNmei9waDJkeVMvVlozU2lHNkg4Z1ZF?=
 =?utf-8?B?N2F6aVpVMk9ySkk1bTZTd1V4akkyN1RPL1BnVVRsd0JNUXdLMDRrRjRlNith?=
 =?utf-8?B?QjhoWHZydU5ETlVmY2VsRndQamF0bExXaUFGak5ZbWg2Z3ZCelBjQWRZVVMz?=
 =?utf-8?B?OWxKVnZ0SklXa1g4UTE1ZndBRGpDWmJ1bVJvQnFoanhkYkdxZmVXUDFmNktX?=
 =?utf-8?B?VmZIWnRKRjRxcGpvQTR6dTJxNlRpUFd6dE43ZVlmL1ErY2FBNWl2Qlc4TnE2?=
 =?utf-8?B?SmdsU0xMKzdRV3NSdTRxTGV2VjlFL3k0VlhyWjhPMlozVGV2ajVONkVTMlF4?=
 =?utf-8?B?a3hkd3kwZjZDMFdhcWREcEM1UWovWWdBUVRTNStVdGxzamlDQnMvb2U2Qmc0?=
 =?utf-8?B?UjZmV1JCUHpoR2JXdnpoUHRZaDc3Qm55U3FjTEZZaFZOWjlJTVA5SVY2dWpj?=
 =?utf-8?B?dWtUUjMxQ2VSSzI5UHV2NU9mVjBLeXdmTjBLY0IvRGRqZHZDc3FCYWgvcnlh?=
 =?utf-8?B?VFBkV3VicVE1TkNaTDlDS1NRSDZFRDhBMGNTeDE5dmhqZ1ZySG1MeTI1cmVR?=
 =?utf-8?B?TWt1M3VTN0xlUC9RWGdNWUZIT0hCVzFEdUQyaU5pOUgvQUZFV3NRYU16ZEtV?=
 =?utf-8?B?ZkthUHRnOWZoOUZlOThiTjNmRmZHWkVyOHdWVHBvWmhtRFFzWXpycCtLZ1Rx?=
 =?utf-8?B?R1pGVFNaVHE3c3ErNVB4b1ZOS2hHRWcrUkNKc1RhQVJIWVdwUE9hWDQreFhE?=
 =?utf-8?B?dExzSnJJMFRQYmpZanVvVTRQRGYvRVU1TU9qUTJnMmhKcEJHU0pBZkRYRitG?=
 =?utf-8?B?cVFQdndRZi9qblRoM245MUIrV0RYalhLazdXYzExNWNlL1V1cWpjeUsrR3RQ?=
 =?utf-8?B?K3ZhbDVMUWFZNlFUTk0yM0k2cmlpcDN5aWYzVlFyZ0pVZHdBTjZCSktXQVhF?=
 =?utf-8?B?V24yOFptMWNzQUUyWGdpMkl1QTFQNzRTcURsQjVHWDhIVGV4YUtYdjFoSDZY?=
 =?utf-8?B?b2o4ZXcvT3h3UmRTa0ZLR3J3L0VzSVliamdOOVFBWGJRd3pIYUsybU5adnpP?=
 =?utf-8?B?VjdyTkUzMUswVHZ2V2hJM21sSHp1K01jckxhOEoza2pCLy9EV3RFTUhaZjZC?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB9422E2D5AD394A9808DF7D40F696D5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb46ef4-1491-4c38-9103-08ddcd9f0129
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 06:21:35.9229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peCtQJmQuWRzw69ekB2iRxeDsTuhrT5rkAdJYxtDpZIHW1WtODb8o2e2VXTGu4/lsm4yBy1KkHM1Cry9c5YZ5GgyldpOf9YMVm/ixd061Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF9D8ADABD2

T24gU3VuLCAyMDI1LTA1LTA0IGF0IDE1OjQwICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDMwLzA0LzIwMjUgMTE6NDUsIEZyaWRheSBZYW5nIHdy
b3RlOg0KPiA+IEZyb206ICJGcmlkYXkgWWFuZyIgPGZyaWRheS55YW5nQG1lZGlhdGVrLmNvbT4N
Cj4gPiANCj4gPiBUbyBwcmV2ZW50IGhhbmRsaW5nIGdsaXRjaCBzaWduYWxzIGR1cmluZyBNVENN
T1Mgb24vb2ZmDQo+ID4gdHJhbnNpdGlvbnMsDQo+ID4gU01JIHJlcXVpcmVzIGNsYW1wIGFuZCBy
ZXNldCBvcGVyYXRpb25zLiBQYXJzZSB0aGUgcmVzZXQgc2V0dGluZ3MNCj4gPiBmb3INCj4gPiBT
TUkgTEFSQnMgYW5kIHRoZSBjbGFtcCBzZXR0aW5ncyBmb3IgdGhlIFNNSSBTdWItQ29tbW9uLiBS
ZWdpc3Rlcg0KPiA+IGdlbnBkIGNhbGxiYWNrIGZvciB0aGUgU01JIExBUkJzIGxvY2F0ZWQgaW4g
aW1hZ2UsIGNhbWVyYSBhbmQgSVBFDQo+ID4gc3Vic3lzdGVtcywgYW5kIGFwcGx5IHJlc2V0IGFu
ZCBjbGFtcCBvcGVyYXRpb25zIHdpdGhpbiB0aGUNCj4gPiBjYWxsYmFjay4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBGcmlkYXkgWWFuZyA8ZnJpZGF5LnlhbmdAbWVkaWF0ZWsuY29tPg0KPiA+
IFRlc3RlZC1ieTogRnJpZGF5IFlhbmcgPGZyaWRheS55YW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+
IEhvdyBpcyB0aGlzIHBvc3NpYmxlPyBBcmUgeW91IGNsYWltaW5nIHRoYXQgbm9uZSBvZiBvdGhl
ciBhdXRob3JzDQo+IHRlc3QNCj4gdGhlaXIgcGF0Y2hlcz8gSG93IHRlc3Rpbmcgd291bGQgYmUg
bm90IGltcGxpZWQgYnkgYXV0aG9yc2hpcD8NCj4gDQoNCk9LLCBJIHdpbGwgcmVtb3ZlIHRoaXMg
dGFnIGluIHRoZSBuZXcgdmVyc2lvbi4NCg0KPiA+IFJldmlld2VkLWJ5OiBZb25nIFd1IDx5b25n
Lnd1QG1lZGlhdGVrLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwg
UmVnbm8gPA0KPiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4g
PiBBY2tlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gDQo+IENoYW5nZWxv
ZyBzYXlzIHRoYXQgdjcgaGFzIG9ubHkgZm9sbG93aW5nIGNoYW5nZXM6DQo+IA0KPiAgIC0gUmVt
b3ZlIHRoZSAnZGV2bV9wbV9ydW50aW1lX2VuYWJsZScgY2hhbmdlLg0KPiANCj4gV2hpbGUgdjYg
aGFkIG5vIHN1Y2ggdGFncy4NCj4gDQo+IE5vIGNsdWUgd2hhdCBoYXBwZW5lZCBoZXJlLCBidXQg
bG9va3MgbGlrZSBtZXNzIHdpdGggdGhlIHRhZ3MgYW5kDQo+IHJlYWxseQ0KPiBpbmNvbXBsZXRl
IGNoYW5nZWxvZy4NCj4gDQoNCkFwb2xvZ3kgZm9yIHRoZSBtaXNzLCBJIHdpbGwgYWRkIG1vcmUg
ZGV0YWlsZWQgZGVzY3JpcHRpb25zIGFuZCByZW1vdmUNCnRoZSBpbmNvcnJlY3QgdGFncyBpbiB0
aGUgbmV3IHZlcnNpb24uDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==

