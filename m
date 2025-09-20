Return-Path: <linux-kernel+bounces-825450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA267B8BD3A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 04:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58EBF1B20CE9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366DF1FC104;
	Sat, 20 Sep 2025 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="obZ14HIk";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Lu2V5RA6"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56117194098;
	Sat, 20 Sep 2025 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758334275; cv=fail; b=AtLBO8L/bJ3JUbiwPoleNDwiUTHwdfs+yfRTLzlyof5K09dDNBPLNRR13ti1izI11vXG+7VIx3OcSy5ddf0qf+iaQBDScuBxh+im/imbfSa8iD5BKBT6o21+JM3NZsLE34/J5+WD1guudoKr7s9EY36saCtERctJj8Ri9n7gCP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758334275; c=relaxed/simple;
	bh=blMghhQZ/rzOGTLHAEsaioIi0bUpyn/6V0ikgwwB+mg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J40fhFwn6A0JMlECrWso8tHitRrgqEsE9qcNvaAblJPR3JnpPzjGJLEEFEiG0sio8XYGYOeEKLG54+FbCenz7+46AXpQwM8AIf+CmQDYBtNatjDoq/gztuvM6eqAwnPBX3NWbWFv9MT4j0xzT5GyL5v5NmVYbPwwna6NzQWWqGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=obZ14HIk; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Lu2V5RA6; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 110bd8fc95c711f08d9e1119e76e3a28-20250920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=blMghhQZ/rzOGTLHAEsaioIi0bUpyn/6V0ikgwwB+mg=;
	b=obZ14HIkKNtvoQL/8eiifP1WrF0Tk+cWUWUqkmaa1BVDaKsg6KviUOLZbBlzlmhJ0AbKhITpNefqBSnYiJZ/4oRkY1jGxm2jpIGR/U8v/ilLhTZU1uyJ+FxPnWcuU10xgu4fyYSuk0Q5Zdv7HWM6Xs9JLd48YUTjteZq/VVXF8M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:683d44ac-3cb9-4d28-8ed4-40e830132729,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:f584c06c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 110bd8fc95c711f08d9e1119e76e3a28-20250920
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 350490749; Sat, 20 Sep 2025 10:11:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sat, 20 Sep 2025 10:11:04 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sat, 20 Sep 2025 10:11:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWcSn77O0S7nFirzM3A8U7FZf242bUMz+ykFksYuIbseYpdTMqInxLLeCyD/Hup6orJiovLF+Ls+0jMoaqAB+we7SlwxSr2famofkKwfGqlMRpi8zFDgyj9knPYsgtIb9aiqf4EJ4/cXlE2ez3tSXDubyCbhjltYoNanL+aU++0VAENHEvIpAZU5Y5HdtuH2s+bxdn1usfJkB+NSONR8+WHZY8VMjkUCfHWr1scy6Hb2ZpRGdunMGtU9uq9II+brrTXWtD842B+csVM776YlCJAe4wnJDDr1gR1z+9amzE3QW0DHSCyPi4Hjjr0Hes0Ycz7d8HlwA4xz4+z6/AXTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blMghhQZ/rzOGTLHAEsaioIi0bUpyn/6V0ikgwwB+mg=;
 b=EOgDcJTamRKncgeTiXePixXye1VNOChtk1O/qaraE4k9Sfi5WcD6kNyz981ay0tUUFWSFz9dYhPg8eUS7ILSRdZht76NpKYWcCIDReOjLSZ/b2YZ89gGjimF7/W1myYcDX40u8WYHXlRSaS7kBQFHXEi05bLp/6c4BWiqNutFW7QAfWf95qKbflfIU+oa9K/IRGGH7UFdkEGCfhU4+CjK0hiifvZeL1aG+4u7o96BN7f4gsN2Z8gWgbAn+NvlXaznGV45x+kIUU0wW3NTK5OYWGeHcyOIQ2Sa+qW9B3fuLVaVNy0UCv6F7tTsCTqB9/dQn4loLi1vDSdQ3cq5wNr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blMghhQZ/rzOGTLHAEsaioIi0bUpyn/6V0ikgwwB+mg=;
 b=Lu2V5RA6woVADW9z01AC+BjjKx+1rLrYIJeVEgQbmJr9u93SM3gsbNs1gRrFtCeeA5ASrdTyaX8Z0ULVZYrU+zAiEEqmG4kDNv4fHHb2bk9PsjG3s2DQrRE18eKUe2gCxLCODadvkk2ld/j3jpEqePWE4jGWuZjJMce2AV4+2ho=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 PS1PPF8AB88AC68.apcprd03.prod.outlook.com (2603:1096:308::2df) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.19; Sat, 20 Sep 2025 02:11:01 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%7]) with mapi id 15.20.9137.017; Sat, 20 Sep 2025
 02:11:00 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?=
	<Friday.Yang@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v11 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
Thread-Topic: [PATCH v11 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
Thread-Index: AQHcJ8u+7uNe9P0eyUaG0yR3cQO8T7SbWAMA
Date: Sat, 20 Sep 2025 02:11:00 +0000
Message-ID: <e01d359d674d36eceb440aa870544eab2e6f6646.camel@mediatek.com>
References: <20250917120724.8650-1-friday.yang@mediatek.com>
	 <20250917120724.8650-3-friday.yang@mediatek.com>
In-Reply-To: <20250917120724.8650-3-friday.yang@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|PS1PPF8AB88AC68:EE_
x-ms-office365-filtering-correlation-id: 93a6c23c-70cc-46fe-4533-08ddf7eaf1cd
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eUZpNEY1bkE2bkVqRlhmeTBMd3dybXBKOElGeHJVNTNyS251OGxiOUFDOGxk?=
 =?utf-8?B?ZHlSTHZuWXVQbVk4d3NtNjgyNFFjOHRuNXA1ZzRLdmVNVXdMbllQb0NaSWlk?=
 =?utf-8?B?bVFBQjVVMFF0YXdSVTZXd0I4MVRENEhIRXRxOXZFT2JQUm5aRjFMaFg5cjdU?=
 =?utf-8?B?c0tVWkIvRDJ5aGV6eWhvdldWK1ZqRTN4SitRWE9MTTZRdTM0V1dpTGR3Qmsy?=
 =?utf-8?B?ZkhRd0N4UVVTQWJvNTdJaHBvdzNPWjVsZWEwVjFGeVphN2pPZ1laRWFZcEVH?=
 =?utf-8?B?ZHo5bTFuRnczVDB1bGZOT21RTjdnWWgyL2djc0g0MlEvdDB4bG1xQzRYblN6?=
 =?utf-8?B?Y0dPaWdPSHZwSzJTZ1pFSW5abTRBUGlUS2NCeGpINkpjNXEwSVN6TzJZbktG?=
 =?utf-8?B?aE42L2RGRWtLdzNNaFE0NlovOGlXeVN5Q0JrZUZ1N3cweHFPbmR5NGM3Rmdo?=
 =?utf-8?B?bEIyU0xNTU5DZ2ZlanRlaER3TUwxcGhId0IxRFc1RGJPTzRJYjN5V3Q1WUFF?=
 =?utf-8?B?RjlzNlZ1S0NQNmhxaC9lb2NIdjNRRk5GSUczcW8wRjMxL2JaVDlTYTVvMmdN?=
 =?utf-8?B?OEloMzcyYmU5RkZqUjNBRlRRaTFZK2tKWEg1czh3NysrcnVQRWYvakVKYXo5?=
 =?utf-8?B?RHNYZHByTzduMEhCdEg2bzNhbXE3ekxuZFgrdlVYbmNmRTZQS09OUTlxQkNy?=
 =?utf-8?B?WWs5V0xJMldHY1pUVW5ueUtvVkRqdlAzUlZ6REM5bkJRVkcvMVBFK243b1h2?=
 =?utf-8?B?UWxrS2t3Y3ZGWmlQY2RBV2ZRYzBEZEh2SWpycFdaQ1o0YWxSc1Vqa3lrQmxB?=
 =?utf-8?B?NWdVUThNazJ5T0tqVjdUNCs3S3BFWnBYalB6NXVrQStVUGZjZ3Q5UEI0bUxV?=
 =?utf-8?B?clpKcElGREpkYUc1ZWtORndGaUZ4MFB6clcxZ0NmbDBwZXdkcEhRUzVlRm1X?=
 =?utf-8?B?Uk1qRzBST3FzMEVjUnB4T3l2ay9ycEdkTGtEeHpPZDVYeTFlT2pPVVp5WVRr?=
 =?utf-8?B?cVpIUEFJTnMySGwxdzdsbnZzdm9mbWZUYXJhNSs5dDVRVDNxUVFLUENZdjRP?=
 =?utf-8?B?b2NrZUN4Vy8reS9DMU5TVmxNWDlWaERFZUxwNVM4ODJZb1JHdlBnNk1XU1Nz?=
 =?utf-8?B?N2twSldZV1hkM1NCS2N3RmJWV1NVMGJCWHBjQ2ticG9tM2VXbEwyV0kxbmRx?=
 =?utf-8?B?Y1lTT25QMXlNenZya1YwZ0lNZzRzakRyRjNVa2EvY2grejJkSGNaZXgrWFR0?=
 =?utf-8?B?MTRpTjYxM3RMY3JZcEdzcjZuK3pHaHRidVZJTlpBQ29tc1NMb1NLZ1cxMFA2?=
 =?utf-8?B?bWE1c2NzZ3BpY09xcTd5OEFYbjdWVHFuaGt2R2tlc3BwQWlBY1BNcnBJMlZv?=
 =?utf-8?B?RFQ1Z3ZTYk05RDdyZDZON0l3RmdHejNWV2Y3UG5icWZ3cjBjVUNTV2l0Q0Na?=
 =?utf-8?B?dzhmdXducUZDc09xK2Uxd0R2c3NJV2QySWIybGNZOHkxTC9LQzY0NFEvdmxr?=
 =?utf-8?B?c2VtTGFkMm1GTlRPQURyclZ6TW1ncEo1cGsyTXpnRHlWTzY2Q1BHeURMWktn?=
 =?utf-8?B?SVNpSXlzUG4vZzFOekhZbTVTZWpHQ3Npb3ZtNHJRd0ZGL2FhSkJ3c0s1NXor?=
 =?utf-8?B?Z2NuNDNXTE1XYXZUL0RpVk1vc3pmY2xURzlwd2R4T0crOWRIdjZod3NneTR6?=
 =?utf-8?B?ek15VzdyNlpIMFpCelM2MExDUWxtWXBwUWRhTi9iRWtLd2JXeEQ5Vk4ydGg3?=
 =?utf-8?B?T0wra0oyMG8rVEV5S1pXRVhRV0U4WHhTNW1tU3JKdXJsNnNjbkswbHJSaFgr?=
 =?utf-8?B?eTcrZEhCNkw0eWpweFU2eXJ5MEVNMm5ObmNMNzJCd21xTHE5S0lvQlZheitn?=
 =?utf-8?B?aFpnYy82cFRkbzQvUXlHYzlpQ0RQR0JDUDErVHhjck0zRFVVOTJiSG9BaXlk?=
 =?utf-8?B?aTNJbXI4bEgxbUFvbG1SNlhLNjFoYnNNVE8yUHpFcmpWL1J4aHFTaFBySzdu?=
 =?utf-8?Q?eWk38fgPo5nW87zm6KMjGthl6cXDco=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmZuNGhTVGhHdCtkRWI4Ukl4Z2U4ZSthUERjYmUzNzdVa21GMzJQMk5ia1Zs?=
 =?utf-8?B?Ry9MdWZZdmNWSExvaDRjMGR0bWoyZmN6Mk9MVnM4cUFkdGg0R1Z6OHY5ZTRM?=
 =?utf-8?B?R0NhdEFyQUpUZjhVTE94Yk1EZEY2U0RLejRPWDNZRzMvOHoxdkNtdTA2blk0?=
 =?utf-8?B?SXRyWWtRNEx1Uk5PeFMrNlUwQldPUVRQeHR4ck53T2tYWnp3S1h4NDU2SkI1?=
 =?utf-8?B?R0gzMmhteUMxYWVRMzVTZWdzbktsN05VMklDZXdob1VRRW5zZWRqbEs3WVN4?=
 =?utf-8?B?YTYzTm50SFIzbFlua09Nd3RaMTdVdXhSOXQ5Sm1uQ2Jla21mb1dLbzBGWFI1?=
 =?utf-8?B?Q1JSL0srZ3d0MXBGbFp6L1FTelVaZ0tZV2VjWlg3dnluK2hETkZ4amdjQjB5?=
 =?utf-8?B?MWpxam8rZkx4VFVpMU1kbHh3QWlQMjVBOG12L0ZQL2d2Ny8yMjE2WDV5WUdy?=
 =?utf-8?B?U2VUK3piN3lidXBNM1lsQzZSWWl4bDRpalNtTUtQU3dSTUZMbkcrblUvempX?=
 =?utf-8?B?bXExeURzRmREOE50N3c2enF2TGJHemNDUlpiMExkQVo2ZmtlQjFXU1lLUjg3?=
 =?utf-8?B?TFpCV1ZyVWZ1Q0hqZm12clEzTTBlYWQ4WG90Qk1tL1ZCTWJYblVKV3oydFpH?=
 =?utf-8?B?SWdZWEZvTTZwQ0FYR2xnenhjWk81dlNZVk11SHJ2eU9wWndjQStzZjg2Z1I3?=
 =?utf-8?B?R0hNSk0wMCtaRklxS1ZPamYyM1k0QTRDZUhzOFM5NWxLc3YvOHFJQTJaNXdT?=
 =?utf-8?B?eDh0bFFBL2NTeDc3K0J3RjdvVldNVHk2VFhMMFF2S1NiL0E5Wm1DUkpkVG45?=
 =?utf-8?B?WTdhZEhXZVBFTXRRa0R6dGRrOTgrdXhWUnVhSFBwS1JEWXY1TFhqL1h0V2J4?=
 =?utf-8?B?WGZVdjdlcnFEQnc2eDZBVVluNDh3TU1VVFFxS0VHYTFtZUNqTjdFNjdseGg0?=
 =?utf-8?B?bGttRXhoK0wrbkVZTkxKMWNVUlJqZTZ1djVNRUFSeEpPNC9FbDFMYmxrempy?=
 =?utf-8?B?ZHZ6VmhNeGdqeGc0R05zUTFKbjRROEtkMVN1WmF3TGZLYVJ2cWxROTI0OHpz?=
 =?utf-8?B?Ti9YSWJRR0lwejY1UlJVYzdGNWtJQlUzQTJpVGdNS1B5NUpUelNkaEJWOXRw?=
 =?utf-8?B?d3U1Z04xZVZaNUxSZGQvendrbE5IQ2VrVjVLNjdwanBVTkFJMWlROUgxQUc3?=
 =?utf-8?B?dThLdTlreVBOL3BxOFVoZFFicHMrL2dIVlppQVdIdEVrT1Z2cHRlSjBxRW5Y?=
 =?utf-8?B?QThaM2FMY00rdTl0OEh1UmZXOGJUU2V2TmlVYm9hMUlUZzZnOUdEbXAxNzFV?=
 =?utf-8?B?YWpwYStXa1BobXFSTm5GRHBsTi9welBEU1hWbk5veE41NU52a2IvVjBYN0Rh?=
 =?utf-8?B?MjVyT2VvdHY4TkVFcGtqNUg5U0xTUGIzbXM2ZlV4ZGhjQVcrZHYxcUJGV0dJ?=
 =?utf-8?B?RkIrYS8vcEdHaUROOXNqSGEwdmhWSjlOYlpqMHNZdnZPMUZoa1M1VEQzOEUx?=
 =?utf-8?B?K0xYalRiV1JNTnNrbjhyZlZrNW4yd01OTnl2Nmpta2ViVDAzQmRIajRwTkZm?=
 =?utf-8?B?emtVbXZVUVpSVEhTMUF2TFFFeFBWQmx0c1NRVnJtYkNRTVVxclZSeU5uUlI5?=
 =?utf-8?B?eXg2NFBIYWhSY2E0ODNuVWQ5VDNqbm1DbGV3U2JFZUhmR2N6d3BHVFNtVklv?=
 =?utf-8?B?UitYc2N3Q3JlZGZyMGFtTEN6ZVM3cHU4MlB5OFRNS0NtMlJQeU5hSUdweXRP?=
 =?utf-8?B?TWV6VWRlWUpjU1p2dkNLMFU3b2MxaTBJWlpTcTNUNFA1SDIxWVViMmFMSGx2?=
 =?utf-8?B?a0ZiT25ORmtIS29uNnVhRzhXSVgvaTI2OEw0bFNrZGw1NU1IeHNURHdvY0xV?=
 =?utf-8?B?RjFpSngvVXFKSklDdXFFQVpCRGtWdHVUV01CK1V3aG1zdDN0Z3RLYXYycnp1?=
 =?utf-8?B?KzRCU1g5dnMwSzRkL3FoTFpVdy9lcEw4VDFYVlZOUEN0c05QUnlQNDZEYjJI?=
 =?utf-8?B?VnBuNFc5MWt5RlZ2VnpkUHZQaE1qZnM3MjM4UW9wU2UvNm5BSkxHSXMrT3oy?=
 =?utf-8?B?cS9VZDB2OTBqdW04c3NOaVVPcEUyRlYyTFNmWHhremVLdVhNcnRuNW9SNXdv?=
 =?utf-8?Q?JgYuLZUGcl8uJD0afkMRZG/SS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77475CD779271F40BD468B48F38B9FF2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a6c23c-70cc-46fe-4533-08ddf7eaf1cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2025 02:11:00.7277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trFjQwsFnkhxp9MJcfX6WXyyvsEKQNVOC0pxpuGUZjT2nN3408lp/ZtCZdp/AIZEUxZRMeXmjzr2f+d/dSyMZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF8AB88AC68
X-MTK: N

T24gV2VkLCAyMDI1LTA5LTE3IGF0IDIwOjA3ICswODAwLCBGcmlkYXkgWWFuZyB3cm90ZToNCj4g
VG8gcHJldmVudCBoYW5kbGluZyBnbGl0Y2ggc2lnbmFscyBkdXJpbmcgTVRDTU9TIG9uL29mZiB0
cmFuc2l0aW9ucywNCj4gU01JIHJlcXVpcmVzIGNsYW1wIGFuZCByZXNldCBvcGVyYXRpb25zLiBQ
YXJzZSB0aGUgcmVzZXQgc2V0dGluZ3MgZm9yDQo+IFNNSSBMQVJCcyBhbmQgdGhlIGNsYW1wIHNl
dHRpbmdzIGZvciB0aGUgU01JIFN1Yi1Db21tb24uIFJlZ2lzdGVyDQo+IGdlbnBkIGNhbGxiYWNr
IGZvciB0aGUgU01JIExBUkJzIGxvY2F0ZWQgaW4gaW1hZ2UsIGNhbWVyYSBhbmQgSVBFDQo+IHN1
YnN5c3RlbXMsIGFuZCBhcHBseSByZXNldCBhbmQgY2xhbXAgb3BlcmF0aW9ucyB3aXRoaW4gdGhl
IGNhbGxiYWNrLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJpZGF5IFlhbmcgPGZyaWRheS55YW5n
QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21lbW9yeS9tdGstc21pLmMgfCAxNTEN
Cj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTUxIGluc2VydGlvbnMoKykNCg0KUmV2aWV3ZWQtYnk6IFlvbmcgV3UgPHlvbmcud3VA
bWVkaWF0ZWsuY29tPg0K

