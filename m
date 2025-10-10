Return-Path: <linux-kernel+bounces-848037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E4BBCC4D9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8011A65CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7799026D4D7;
	Fri, 10 Oct 2025 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R/3MpFlb";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pgErSJBK"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E671FF1A1;
	Fri, 10 Oct 2025 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087860; cv=fail; b=q7uRvYZ4AbopBWDK2OMThW1Sl0ojLgpCTt9Wdhpwx1rzi/AD9QZE+xTWBS4a2K2SG0I1ePeo+0SiLA0BdhMBfOECWEMV3Jv3YBqyXUWvGNivpBHWk5QeRTkcaWZVYKR6mqN9xfzGIKhF9Sz8MjJO2GeqUputdioYh8TQCfIXb3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087860; c=relaxed/simple;
	bh=cif0rTPjZ2DJhaQrsRhss0qMRyjx1jMwQSmONvEnTtc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WAcEKoc9XocRocSKpUkqKxNTPh++LYQXfDPPKPyYpPqvk+9yhcx2mCKaHXXVxk66HUCusUXNZQXWTKe2w2aYrBZz5LYJnMk0ASpFlF1JnX5g2AY8qNSyY5mUFeEI6N+QZdIN6fO/B+3V9q9lbZIumuttsw+GlB9sf5vnOF8gfZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=R/3MpFlb; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pgErSJBK; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f2a3ee24a5b911f08d9e1119e76e3a28-20251010
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=cif0rTPjZ2DJhaQrsRhss0qMRyjx1jMwQSmONvEnTtc=;
	b=R/3MpFlbl3qcwlCLBRMWZIdrgmymDt4WnifmwcnUuwVK/FSjBJI6oEcMButAx9m5W3FJ6Oghw6FyEw7/aqTRitNumetIPpMyBl8P6Ok8Pgp9hTRAlP6rgnM6TInL2gaGIZvPYjfPyUB4l0vYKhFJStZoxI2HOpUESvu/w5L7mIM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:a6118380-0c20-4a64-ae31-1bec17a7bb55,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:eb273f02-eaf8-4c8c-94de-0bc39887e077,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f2a3ee24a5b911f08d9e1119e76e3a28-20251010
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1202550394; Fri, 10 Oct 2025 17:17:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 10 Oct 2025 17:17:28 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 10 Oct 2025 17:17:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaykCMswVVmC5KGKTNOq/UOtZyZb74gQQsv4BKs94sF4Z7Fij5hmlYQSLPM9S7Fazy/q8/d/AyWqyBUrFkqSSzyMEh35jmm+HXgWnimY3RnCL3nEw2cU47f5YZkRH2vwXqPyHCGjiM0SmtW0he4cfHZ7/uxg0eBTD4wTWD56b+CqzgbVu5jmupLNMMhfJ269MCNAiMCiOaHsKpg2Zgv+UT8OzF0kB/gYlZA3FZe4pLoy7RtqUbxh2OnN1bUnliqe3j1cC7KVmuLDAohuifGVZMxF+19dufm/a2mXZCqUpB5MVIwLYmrF3qZt0zi0dBWP4UkOWFfRm4S0sNrVoVuRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cif0rTPjZ2DJhaQrsRhss0qMRyjx1jMwQSmONvEnTtc=;
 b=ab81kwpz1kuUx2NMuj1a/teJWQs0u/DMLFfPog3C/DJX8GOjPzBodnRWl2/7HqT/2le4ow1dxiLqC6VoRtf/7ZwPPmqBfTuYC6QixsdkNedFxsaXxTTDQVr0ubwf547j95CN+mK4H/6bjxMbb7MEK54gchUF5sFROHDY43lrDp4P+yT9l9MH6fjYVe29QHa8p9VaFqJURBnCjkDuatCFbuvMwkDDUXheLNgj41FUyBaoiSgiEMz4fmUcR2PQ9fRLf2hltkk/cxuHTEjm6FTHjcE7zzMYW93mQl1FrYbNnvcCHATO5pVub1pin4Yy6Y4pfHnD/Fc8E9njCGiz2kAOQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cif0rTPjZ2DJhaQrsRhss0qMRyjx1jMwQSmONvEnTtc=;
 b=pgErSJBKuxxfmdBUUo3xm7jTNWeZYw3YmPkP4uJZz+/3dK9WHqmdcvCaf4IXYlOpcgtiZ4ye+LaWm+9G++gXtbcUYp9mtUydVCOs0DzzCg3ogfuKX47Cu0T+C9WRoeNMtn2RbDEntNRu42u5wnhXYWjEAUZNTg0pEpIu8qaW0nY=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by JH0PR03MB7596.apcprd03.prod.outlook.com (2603:1096:990:16::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 09:17:26 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 09:17:25 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "robh@kernel.org"
	<robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v7 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Thread-Topic: [PATCH v7 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Thread-Index: AQHcM3iZI/kc03UuBECs4L8oiXqTzrS21vwAgARPcwA=
Date: Fri, 10 Oct 2025 09:17:25 +0000
Message-ID: <2f23e3685ae621b568e9aec4ad99fc7e2fbb4039.camel@mediatek.com>
References: <20251002084204.15898-1-jjian.zhou@mediatek.com>
	 <20251002084204.15898-3-jjian.zhou@mediatek.com>
	 <CABb+yY1Z+F=emOi2Q58bGv6AtKOMjY3qsNgRYqheNni+yN4_yQ@mail.gmail.com>
In-Reply-To: <CABb+yY1Z+F=emOi2Q58bGv6AtKOMjY3qsNgRYqheNni+yN4_yQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|JH0PR03MB7596:EE_
x-ms-office365-filtering-correlation-id: 0ba24ee4-08a8-48e2-4421-08de07ddd3b4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VTlYQjFYTXdMU3RGRDZ4bW5jNWU2YWxTdm84OUU2bmlRYlU1YWxxb0lnek0w?=
 =?utf-8?B?aEFDdUV6Y0JQK1RRS0U0QzQyTnl4eGZ4c0FNYklKQWc0UTFsd2cvY3BvNkpi?=
 =?utf-8?B?aExkZHpvYkVrYndXdGczdkxQOVo5Qml6NWdoS2ZrZURRM00zZWxKTFJPNVlv?=
 =?utf-8?B?SjJhZkVXdDNxT1pzQVFES0tzUy9RY1BVLzNZVi9UUmFET2J4QzQ0ZmFvNFBh?=
 =?utf-8?B?WkFqY3ZWRnZWbEJUTTUrYWZWTExQeEtIeWdRZXY1UTdoNUN4WVkvU1RlOHF1?=
 =?utf-8?B?eXBXOWUwTXpWUnZUNHlNK0hlWVhybFcvaldwN2xxbWltYjU5ZGlzaHcyODAw?=
 =?utf-8?B?Rnpja0JkRkM0N3J4QWN3azloS3RWS2ZUOWF2eE4zVkpmMzFmMGRybWw3ZFJm?=
 =?utf-8?B?U2lDaTdQaTZLSFRCamdBU3AwQVJHaks2RXpqS2FzVXdLaUg3L3I3eHJOTkd4?=
 =?utf-8?B?a3NQUzBGb080M0t1NFZFbXBOUzcrL2NGUTBpSGhrTjhsOWlxK2VocGpDbEJu?=
 =?utf-8?B?RTZFbWw4Mmx6Y1QvNGhGZXdYOC8zUnBZUHVZOEVMUVJYMS9FQ29vOVY0LzJS?=
 =?utf-8?B?LzZJWTlLcVF3UHlzMUQxSGp3OFF1Vlhic0wrNUl1NHZucWlWOWhRSU1keDNm?=
 =?utf-8?B?cm5EajNPU3p6aEtkTEVnSGdDc2VNRUNzSUlrK2NPSUxlSGVHK0Q5aUVJUHhv?=
 =?utf-8?B?d3hiUUdVYWEwRHAzbzY0Z0tsNU9sS1VsKzUvT05KbXRSTnp6QkFOM3VOMlU3?=
 =?utf-8?B?QURReWxKc1lPNy8xZnhoRE5YK0ZIdXhXTUd4UmU0OEU3dUhIM0JlejRsazVh?=
 =?utf-8?B?dlF1dmJaNWxCZzd0OTFsaUpRM3NoVWhxVkpPRDhFQk5NWVVvSmdMZ3F5a3Bx?=
 =?utf-8?B?SXFFNTdTU2ZvMWhER2tLeFNlZGVZRnZ4V0VTT2ZsakdRYytoei9nQ0tIRGJm?=
 =?utf-8?B?SXZDT2tUaFcwS296NnVxOWhLNG1BSHVWelBWRWNjYTNNNWUrZnQxb3FoUi82?=
 =?utf-8?B?bFVqQzBYRzAyanYvNEMyMGxSRTQ2TjZYemxkTUdNSGJGc0xnbzV4VVlGVll2?=
 =?utf-8?B?clNpNjVjL0EyN29Wdk5abjdHS2ZGUnRUaGZNVFdEU2pVUW5IMDNubVRueWc4?=
 =?utf-8?B?SUx4ZWJTSC9scDJTRTFBUWFZUk50WmYvRk1SRVB4c1BwWkRXUWdLa2IzKzlF?=
 =?utf-8?B?dnBzMXdRUU1XTC92VUNwWC83QzQyTzNJWTMxOFNzK3l4UGdWa21QUDgydGdH?=
 =?utf-8?B?UldkelV4WXFXT1NtSmtLbThneHNXR3ZHSDQycHdwalFNdXJxeGtiRHgvMlND?=
 =?utf-8?B?Uk1naXNjVlBHUE9vSkNPM3RqRnVmcEppNzBXMEcwcVlPYUNJWnp2OHVqMzFK?=
 =?utf-8?B?NW9SZzZXd1l6SS9OQ1BIYkNLbVN2SEtQRCs1TEpVNG0wenoyZXJ4V2FyTVRT?=
 =?utf-8?B?TmdXc1hYeUVIb1oyVmlyMzE1RkV5ZlEvQmtVZmtKdkJPNlBnb0w2TEhWUDYy?=
 =?utf-8?B?ams1YkdWRXVBNHFUUXQ0NEpNNEdPR3VyZFA2WkNkNW9majM3NVZTZHZlblVB?=
 =?utf-8?B?U2lVM0x3bmc2Q3dROG5qeWJnQWowVmh5QVE1aGtTSUpJTTB4ZFRXenhsQVEy?=
 =?utf-8?B?aWZ6SUhUY0VMNVFIdk1PaGZ2M0pRRkRLUndiUUxIVm9BaWN5R1I5cWJkaFdN?=
 =?utf-8?B?VGovdFBiNXIrVEYyODVmZ21DNkcrZ0l2ZFhmR0F6b2JFRXFkR1NCbjJtbkdo?=
 =?utf-8?B?Mk0vN0w3TGx0R2M5SUpEUkNSYmIzK0xOejBsSU5MYkVZNE9ONkhZN3Y3R21a?=
 =?utf-8?B?QU0xS2dvbityVXd2c1haNEluSERFSjArTzAyMVVCY2JOSVhCbWxEektqL2tC?=
 =?utf-8?B?eGp2TWJrWjJxWUp6Uzh6akR3aU5SZ3N6YUJ3dW1CTXloUTFPWjJ3bXZ4SEdT?=
 =?utf-8?B?ZTJYSVBlMGtWWTU2dVNObWRWMnpEdyttU3BtK0lCbjYvSERtVldQcmFNZVY1?=
 =?utf-8?B?VURMQzE2OExTZmRLZ3NhUk14elltM3BOQnVlRmdJc3hRb0tUQVh0Q2lIaHds?=
 =?utf-8?Q?LNOp4o?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXhud1UzOUVzVjFwSW5Cd1hJZGZzdU9uNng3YTJDMlRyVFFZNzJtL1FkQ0Y4?=
 =?utf-8?B?cmVtSVJHYzI1L0NrKzdKbGw4VldvQnIyc255alJoZWJyVUlDdU9zeGxYQVBG?=
 =?utf-8?B?NXBQSnAwNllMc1U5L3k4VzlDNW5VQjE4OHltazQ1bEF5QlhxdUtwNm9leUVw?=
 =?utf-8?B?YTE3VTA5c0FYNkVRYUl0dW9QU3N6SHJXOUZhb1kxc3J6K1JxekQ2Q1JSbUVt?=
 =?utf-8?B?MGYwOHhrWEJsRWxaUFN0Mm5hNThKLzRBb21zWFF4bUZFNG91SXNlYXhkZnFk?=
 =?utf-8?B?MVV2SXVIdFJyQjhMWDQwdldwalplZnJJbllkVmlUM3pVaEFYbktpVlc1RmJi?=
 =?utf-8?B?YkpKRmpEbldsNHpEK2tiQjhEd0dTWXdBYkdLVk8yWkVEVWhHMXZwamRyejJ1?=
 =?utf-8?B?bEV5TXI5VnN5d0ZZQ3hRbytEQnNQdWxVZUFPdkdLWXVjc2MwOE1qSDlaT1c4?=
 =?utf-8?B?U3p6NFRlWXdJeXJFaVpjMis3a1dsRDhoMDRzSmNpcXpHdU5lenBDRWtTN1NQ?=
 =?utf-8?B?ODEzZTI4TE96TW16WCtqeXU1anFQVVMzRkF6eEM3bzBra0hnMmFCMVJNei9q?=
 =?utf-8?B?bEpzd0xyNWd6WGNjUStoNCtWL09kRGZobmxUYVMvTXVzVHhIVEM2RERkVm10?=
 =?utf-8?B?UnN2YnVRUWkxRXFoWVRpZHBsRjFIbEZWaEczOS9FcHZmRDkwY1UrQXlicGt3?=
 =?utf-8?B?dnh4b3EzYzdpL1pNeUx4dTdxK09XeXQyOXc2TTliOVN1Wis5V3hPNjVVVVdM?=
 =?utf-8?B?NjdQcXlmdkR2WTRBMk5rUzBXa0llUTB1dlZkQ2JPL0pNMGMvSElpL0RkZWs2?=
 =?utf-8?B?WDltM2d0UU9hdk10T3FKN01ZaE9CWW1mRktnOTZaV3FOVHhoZWcwTjRrVlZm?=
 =?utf-8?B?TjB2QldRWkp4Zm5yWkg3N29DRHpJVTRxbERIeGZ3Z2dxUFVVcExIUUx3SzlH?=
 =?utf-8?B?V3hMbThVQytZWkJKSnI5UDhmOGlsMDlnRzVBRUJaVEgya1lWVUNvakpJRmMr?=
 =?utf-8?B?elhXRGdZQ2NpdDE3Q056OWgyRTJSdzNLZ0wyZTNlUzlZSy9TQ09RQ2FSZGZO?=
 =?utf-8?B?Qjg2MDBNRy9ETUgrR2F5eUIxWEx5QlNoMGVMeHY2eG95TjVTeGRzN1dvWElr?=
 =?utf-8?B?MVNCME12NUtJeEIzaDR5cjlnT25rRjAxY2U3cWhSd1Vvc1JMa1NqbTdmUUxM?=
 =?utf-8?B?blN5UktmKzJXQWNJSlhjTkM4dG1QZXBmWVRyMDZQaGJZMEN2M0xZU1p6MEE5?=
 =?utf-8?B?VzBEa2dpRVlZZlZ5Lzk4c21QQWVxL2Z1SVVmS0U3THdEZHZpZGxXSGdFRm5B?=
 =?utf-8?B?eHNDWTNxVFkrclBLMEROSGpCN2Y0ZDBTd04xYkN5Q2RuU2ZLUHZFVEFYa1Bt?=
 =?utf-8?B?UEtOTWRRRCtGb2d2TjhkSjhXT3IyaWNoaHJlT2JhOFpEVDluVTFTNWd4d0pi?=
 =?utf-8?B?L0RvL0lHWENJaVhrc3h5TGJmcGR4TEJMV1l3Ky9DQ2daZklwZ3h3dWJRQzN0?=
 =?utf-8?B?anhzZ1E2aDJDRVU5V1UyNW5SeWhUTHJSS2hqck5QSEwrcDBSaUpnWXVDYmFS?=
 =?utf-8?B?ZmF2ZjdvVGpUS1lmWVFPbHNOTnJPOVZocjJmKzNPY0NYWGljVi82MzFYUjJ5?=
 =?utf-8?B?cTNGRmM1RzFjUXZsVUpFRWNJb2dqSU01TUZ6VzI4em9pWWQ3MFlwQW04K1lM?=
 =?utf-8?B?Y3JUMTh1a2dveU1qYWFVZ3dsbFNUQTJhZ3lCMmtzNldUOEVaYVQ0R1JiaWtl?=
 =?utf-8?B?Y0pGa013ejFsWFZ4cmVjVkpTdUtrZ3FBNjQyc2JUUEgxcWRKYldnT20vVHFB?=
 =?utf-8?B?cmZhYy9QNTc2YUptSzFRK1lxK250M3JHbGU0TUtEb1NESWVxYkQyREFEVFdO?=
 =?utf-8?B?b2xFS243eHJYUFl4bm14bzE2cmtKN1JId0VMTlQyNEpIQ2czamw1Y3BESnNN?=
 =?utf-8?B?T3QvUWMwbWhBMmRyY1czaGF0YnJ4TzU5eXdkS1g4c1UrYjJCSHdXdlArRzNN?=
 =?utf-8?B?ME16NzhzbUlqK1Q3QVhCa1pMZWJZaDhRUmp2YUdPVnVrL1hyNHJqNUlwUkdF?=
 =?utf-8?B?anpGVWVpSGlKbUxySVBNNnd4SjRWaURyS2VYQnZmRVZDak84RjBZRExJdzVH?=
 =?utf-8?B?SGtJKzNXazEweFZ1aFhDWnZGR1FmeXZxNDJjdlcxeUhKRVJQZDNIb3NmcWtF?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAADDF0AF13138488191D71E3DB1D634@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba24ee4-08a8-48e2-4421-08de07ddd3b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 09:17:25.3968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dlkfpQ7GRwQq6rkjZVGCVv9hBaBopuj1HhVsmY5Za3YmP+kuhNSnh1CGU1MjJZ79D1FBj4kHxIb6ksLcODYMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7596

T24gVHVlLCAyMDI1LTEwLTA3IGF0IDEwOjI4IC0wNTAwLCBKYXNzaSBCcmFyIHdyb3RlOg0KPiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50
Lg0KPiANCj4gDQo+IE9uIFRodSwgT2N0IDIsIDIwMjUgYXQgMzo0MuKAr0FNIEpqaWFuIFpob3Ug
PGpqaWFuLnpob3VAbWVkaWF0ZWsuY29tPg0KPiB3cm90ZToNCj4gPiANCj4gPiBBZGQgbXRrLXZj
cC1tYWlsYm94IGRyaXZlciB0byBzdXBwb3J0IHRoZSBjb21tdW5pY2F0aW9uIHdpdGgNCj4gPiBW
Q1AgcmVtb3RlIG1pY3JvcHJvY2Vzc29yLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEpqaWFu
IFpob3UgPGpqaWFuLnpob3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21h
aWxib3gvS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAgIDkgKysNCj4gPiAgZHJpdmVycy9tYWls
Ym94L01ha2VmaWxlICAgICAgICAgICAgICAgIHwgICAyICsNCj4gPiAgZHJpdmVycy9tYWlsYm94
L210ay12Y3AtbWFpbGJveC5jICAgICAgIHwgMTcwDQo+ID4gKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstdmNwLW1haWxib3guaCB8ICAzMiAr
KysrKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDIxMyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21haWxib3gvbXRrLXZjcC1tYWlsYm94LmMNCj4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstdmNwLW1haWxib3guaA0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvS2NvbmZpZyBiL2RyaXZlcnMv
bWFpbGJveC9LY29uZmlnDQo+ID4gaW5kZXggMDI0MzJkNGE1Y2NkLi5jMjhiZGI4NTU2NjMgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tYWlsYm94L0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJz
L21haWxib3gvS2NvbmZpZw0KPiA+IEBAIC0yOTQsNiArMjk0LDE1IEBAIGNvbmZpZyBNVEtfQ01E
UV9NQk9YDQo+ID4gICAgICAgICAgIGNyaXRpY2FsIHRpbWUgbGltaXRhdGlvbiwgc3VjaCBhcyB1
cGRhdGluZyBkaXNwbGF5DQo+ID4gY29uZmlndXJhdGlvbg0KPiA+ICAgICAgICAgICBkdXJpbmcg
dGhlIHZibGFuay4NCj4gPiANCj4gPiArY29uZmlnIE1US19WQ1BfTUJPWA0KPiA+ICsgICAgICAg
dHJpc3RhdGUgIk1lZGlhVGVrIFZDUCBNYWlsYm94IFN1cHBvcnQiDQo+ID4gKyAgICAgICBkZXBl
bmRzIG9uIEFSQ0hfTUVESUFURUsgfHwgQ09NUElMRV9URVNUDQo+ID4gKyAgICAgICBoZWxwDQo+
ID4gKyAgICAgICAgIFNheSB5ZXMgaGVyZSB0byBhZGQgc3VwcG9ydCBmb3IgdGhlIE1lZGlhVGVr
IFZDUCBtYWlsYm94DQo+ID4gZHJpdmVyLg0KPiA+ICsgICAgICAgICBUaGUgbWFpbGJveCBpbXBs
ZW1lbnRhdGlvbiBwcm92aWRlcyBhY2Nlc3MgZnJvbSB0aGUNCj4gPiBhcHBsaWNhdGlvbg0KPiA+
ICsgICAgICAgICBwcm9jZXNzb3IgdG8gVmlkZW8gQ29tcGFuaW9uIFByb2Nlc3NvciBVbml0Lg0K
PiA+ICsgICAgICAgICBJZiB1bnN1cmUgc2F5IE4uDQo+ID4gKw0KPiA+ICBjb25maWcgWllOUU1Q
X0lQSV9NQk9YDQo+ID4gICAgICAgICB0cmlzdGF0ZSAiWGlsaW54IFp5bnFNUCBJUEkgTWFpbGJv
eCINCj4gPiAgICAgICAgIGRlcGVuZHMgb24gQVJDSF9aWU5RTVAgJiYgT0YNCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tYWlsYm94L01ha2VmaWxlIGIvZHJpdmVycy9tYWlsYm94L01ha2VmaWxl
DQo+ID4gaW5kZXggOThhNjhmODM4NDg2Li4wNzI3ODg3MWQyNTQgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9tYWlsYm94L01ha2VmaWxlDQo+ID4gKysrIGIvZHJpdmVycy9tYWlsYm94L01ha2Vm
aWxlDQo+ID4gQEAgLTYzLDYgKzYzLDggQEAgb2JqLSQoQ09ORklHX01US19BRFNQX01CT1gpICAg
Kz0gbXRrLWFkc3AtDQo+ID4gbWFpbGJveC5vDQo+ID4gDQo+ID4gIG9iai0kKENPTkZJR19NVEtf
Q01EUV9NQk9YKSAgICArPSBtdGstY21kcS1tYWlsYm94Lm8NCj4gPiANCj4gPiArb2JqLSQoQ09O
RklHX01US19WQ1BfTUJPWCkgICAgICs9IG10ay12Y3AtbWFpbGJveC5vDQo+ID4gKw0KPiA+ICBv
YmotJChDT05GSUdfWllOUU1QX0lQSV9NQk9YKSAgKz0genlucW1wLWlwaS1tYWlsYm94Lm8NCj4g
PiANCj4gPiAgb2JqLSQoQ09ORklHX1NVTjZJX01TR0JPWCkgICAgICs9IHN1bjZpLW1zZ2JveC5v
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstdmNwLW1haWxib3guYw0KPiA+
IGIvZHJpdmVycy9tYWlsYm94L210ay12Y3AtbWFpbGJveC5jDQo+ID4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjk0ZGFjNTljYTMyYg0KPiA+IC0tLSAvZGV2
L251bGwNCj4gPiArKysgYi9kcml2ZXJzL21haWxib3gvbXRrLXZjcC1tYWlsYm94LmMNCj4gPiBA
QCAtMCwwICsxLDE3MCBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MA0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjUgTWVkaWFUZWsgQ29ycG9yYXRp
b24uIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQo+ID4gKyAqIEF1dGhvcjogSmppYW4gWmhvdSA8ampp
YW4uemhvdS5AbWVkaWF0ZWsuY29tPg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxs
aW51eC9pbnRlcnJ1cHQuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ID4gKyNpbmNs
dWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21haWxib3hfY29udHJv
bGxlci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbWFpbGJveC9tdGstdmNwLW1haWxib3guaD4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2Yu
aD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ICsjaW5jbHVk
ZSA8bGludXgvc2xhYi5oPg0KPiA+ICsNCj4gPiArc3RydWN0IG10a192Y3BfbWJveCB7DQo+ID4g
KyAgICAgICBzdHJ1Y3QgbWJveF9jb250cm9sbGVyIG1ib3g7DQo+ID4gKyAgICAgICB2b2lkIF9f
aW9tZW0gKmJhc2U7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4gKyAgICAg
ICBjb25zdCBzdHJ1Y3QgbXRrX3ZjcF9tYm94X2NmZyAqY2ZnOw0KPiA+ICsgICAgICAgc3RydWN0
IG10a19pcGlfaW5mbyBpcGlfcmVjdjsNCj4gPiArICAgICAgIHN0cnVjdCBtYm94X2NoYW4gY2hh
bnM7DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgbXRrX3ZjcF9tYm94X2NmZyB7DQo+ID4g
KyAgICAgICB1MTYgc2V0X2luOw0KPiA+ICsgICAgICAgdTE2IGNscl9vdXQ7DQo+ID4gK307DQo+
ID4gKw0KPiA+ICtzdGF0aWMgaXJxcmV0dXJuX3QgbXRrX3ZjcF9tYm94X2lycV90aHJlYWQoaW50
IGlycSwgdm9pZCAqZGF0YSkNCj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IG10a192Y3BfbWJv
eCAqcHJpdiA9IGRhdGE7DQo+ID4gKw0KPiA+ICsgICAgICAgLyogZ2V0IGlycSBzdGF0dXMgKi8N
Cj4gPiArICAgICAgIHByaXYtPmlwaV9yZWN2LmlycV9zdGF0dXMgPSByZWFkbChwcml2LT5iYXNl
ICsgcHJpdi0+Y2ZnLQ0KPiA+ID5jbHJfb3V0KTsNCj4gPiArDQo+ID4gKyAgICAgICBfX2lvcmVh
ZDMyX2NvcHkocHJpdi0+aXBpX3JlY3YubXNnLCBwcml2LT5iYXNlLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIE1US19WQ1BfTUJPWF9TTE9UX01BWF9TSVpFIC8gNCk7DQo+ID4gKw0KPiA+
ICsgICAgICAgbWJveF9jaGFuX3JlY2VpdmVkX2RhdGEoJnByaXYtPmNoYW5zLCAmcHJpdi0+aXBp
X3JlY3YpOw0KPiA+ICsNCj4gPiArICAgICAgIC8qIGNsZWFyIGlycSBzdGF0dXMgKi8NCj4gPiAr
ICAgICAgIHdyaXRlbChwcml2LT5pcGlfcmVjdi5pcnFfc3RhdHVzLCBwcml2LT5iYXNlICsgcHJp
di0+Y2ZnLQ0KPiA+ID5jbHJfb3V0KTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gSVJRX0hB
TkRMRUQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgbWJveF9jaGFuICptdGtf
dmNwX21ib3hfeGxhdGUoc3RydWN0IG1ib3hfY29udHJvbGxlcg0KPiA+ICptYm94LA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0DQo+
ID4gb2ZfcGhhbmRsZV9hcmdzICpzcCkNCj4gPiArew0KPiA+ICsgICAgICAgaWYgKHNwLT5hcmdz
X2NvdW50KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiArDQo+ID4gKyAg
ICAgICByZXR1cm4gJm1ib3gtPmNoYW5zWzBdOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMg
aW50IG10a192Y3BfbWJveF9zZW5kX2RhdGEoc3RydWN0IG1ib3hfY2hhbiAqY2hhbiwgdm9pZA0K
PiA+ICpkYXRhKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgbXRrX3ZjcF9tYm94ICpwcml2
ID0gY2hhbi0+Y29uX3ByaXY7DQo+ID4gKyAgICAgICBzdHJ1Y3QgbXRrX2lwaV9pbmZvICppcGlf
aW5mbyA9IGRhdGE7DQo+ID4gKyAgICAgICB1MzIgc3RhdHVzOw0KPiA+ICsNCj4gPiArICAgICAg
IGlmICghaXBpX2luZm8tPm1zZykgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKHByaXYt
PmRldiwgIm1zZyBidWZmZXIgaXMgTlVMTC5cbiIpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBzdGF0dXMgPSBy
ZWFkbChwcml2LT5iYXNlICsgcHJpdi0+Y2ZnLT5zZXRfaW4pOw0KPiA+ICsgICAgICAgaWYgKHN0
YXR1cyAmIEJJVChpcGlfaW5mby0+aW5kZXgpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl93
YXJuKHByaXYtPmRldiwgIm1haWxib3ggSVBJICVkIGlzIGJ1c3kuXG4iLA0KPiA+IGlwaV9pbmZv
LT5pZCk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7DQo+ID4gKyAgICAgICB9
DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKGlwaV9pbmZvLT5zbG90X29mcyArIGlwaV9pbmZvLT5s
ZW4gPg0KPiA+IE1US19WQ1BfTUJPWF9TTE9UX01BWF9TSVpFKQ0KPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gLUVJTlZBTDsNCj4gPiArICAgICAgIF9faW93cml0ZTMyX2NvcHkocHJpdi0+YmFz
ZSArIGlwaV9pbmZvLT5zbG90X29mcywgaXBpX2luZm8tDQo+ID4gPm1zZywNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgaXBpX2luZm8tPmxlbik7DQo+ID4gKw0KPiA+ICsgICAgICAgd3Jp
dGVsKEJJVChpcGlfaW5mby0+aW5kZXgpLCBwcml2LT5iYXNlICsgcHJpdi0+Y2ZnLQ0KPiA+ID5z
ZXRfaW4pOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+
ICtzdGF0aWMgYm9vbCBtdGtfdmNwX21ib3hfbGFzdF90eF9kb25lKHN0cnVjdCBtYm94X2NoYW4g
KmNoYW4pDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBtdGtfaXBpX2luZm8gKmlwaV9pbmZv
ID0gY2hhbi0+YWN0aXZlX3JlcTsNCj4gPiArICAgICAgIHN0cnVjdCBtdGtfdmNwX21ib3ggKnBy
aXYgPSBjaGFuLT5jb25fcHJpdjsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gIShyZWFkbChw
cml2LT5iYXNlICsgcHJpdi0+Y2ZnLT5zZXRfaW4pICYNCj4gPiBCSVQoaXBpX2luZm8tPmluZGV4
KSk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbWJveF9jaGFuX29w
cyBtdGtfdmNwX21ib3hfY2hhbl9vcHMgPSB7DQo+ID4gKyAgICAgICAuc2VuZF9kYXRhICAgICAg
PSBtdGtfdmNwX21ib3hfc2VuZF9kYXRhLA0KPiA+ICsgICAgICAgLmxhc3RfdHhfZG9uZSAgID0g
bXRrX3ZjcF9tYm94X2xhc3RfdHhfZG9uZSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBp
bnQgbXRrX3ZjcF9tYm94X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
K3sNCj4gPiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKyAg
ICAgICBzdHJ1Y3QgbXRrX3ZjcF9tYm94ICpwcml2Ow0KPiA+ICsgICAgICAgc3RydWN0IG1ib3hf
Y29udHJvbGxlciAqbWJveDsNCj4gPiArICAgICAgIGludCByZXQsIGlycTsNCj4gPiArDQo+ID4g
KyAgICAgICBwcml2ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwcml2KSwgR0ZQX0tFUk5F
TCk7DQo+ID4gKyAgICAgICBpZiAoIXByaXYpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAt
RU5PTUVNOw0KPiA+ICsNCj4gPiArICAgICAgIHByaXYtPmRldiA9IGRldjsNCj4gPiArICAgICAg
IHByaXYtPmNoYW5zLmNvbl9wcml2ID0gcHJpdjsNCj4gPiArICAgICAgIG1ib3ggPSAmcHJpdi0+
bWJveDsNCj4gPiArICAgICAgIG1ib3gtPmRldiA9IGRldjsNCj4gPiArICAgICAgIG1ib3gtPm9w
cyA9ICZtdGtfdmNwX21ib3hfY2hhbl9vcHM7DQo+ID4gKyAgICAgICBtYm94LT50eGRvbmVfaXJx
ID0gZmFsc2U7DQo+ID4gKyAgICAgICBtYm94LT50eGRvbmVfcG9sbCA9IHRydWU7DQo+ID4gKyAg
ICAgICBtYm94LT5vZl94bGF0ZSA9IG10a192Y3BfbWJveF94bGF0ZTsNCj4gPiArICAgICAgIG1i
b3gtPm51bV9jaGFucyA9IDE7DQo+ID4gKyAgICAgICBtYm94LT5jaGFucyA9ICZwcml2LT5jaGFu
czsNCj4gPiArDQo+ID4gKyAgICAgICBwcml2LT5pcGlfcmVjdi5tc2cgPSBkZXZtX2t6YWxsb2Mo
ZGV2LA0KPiA+IE1US19WQ1BfTUJPWF9TTE9UX01BWF9TSVpFDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgR0ZQX0tFUk5FTCk7DQo+ID4gDQo+IA0KPiBQbGVh
c2UgY29tcGlsZS10ZXN0IGF0IGxlYXN0IGJlZm9yZSBzdWJtaXR0aW5nLiBEcm9wcGluZyBpdCwg
c29ycnkuDQoNClNvcnJ5IGZvciBteSBtaXN0YWtlLiBJIGhhdmUgZG9uZSBjb21waWxlLXRlc3Qg
YW5kIHNlbmQgdjguDQpUaGFua3MuDQo+IA0KPiAtamFzc2kNCg==

