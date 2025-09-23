Return-Path: <linux-kernel+bounces-828135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3326BB9403C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C77917A5BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0A626CE04;
	Tue, 23 Sep 2025 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GRUY6nK2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="e5TT8YCf"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0E713AD26;
	Tue, 23 Sep 2025 02:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758594972; cv=fail; b=gPyvIbhlQ0bhTo03TCeMRKAo3yXnGrfwq1lTGeJ1wCmOsf7FA9NJbQwTQJy5YSoiMBr1OLq4hL59MTAmfc2fpKQyPj0oWMnrHWl5PJx1WHB0Vly8UyaUObxqfHZnXrRdIkKcg7tiqB5HJ9lvuaAZnQvmG911WXhlx59rgnd7jlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758594972; c=relaxed/simple;
	bh=Tkc/jU4EmBNaU4csRfxmwLEshvFXLHeuoH3vfumMQIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kfC8N9jcQCHP8yKBbPKStCLkRGNjvJmDe6JoSx6IT1tCI8gp3lcXBb+dXB5R/GpyTEnW3Ofu3pXe9MHOp9uNVMSj7cD5jELMYQOmN2MJUaweoHfcfP/y9iul7N+cCI+DZCiQrPIGh+004ZJbDKfzKfgD3WsJUyh5bdXblvS6UwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GRUY6nK2; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=e5TT8YCf; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0e0c6c1e982611f0b33aeb1e7f16c2b6-20250923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Tkc/jU4EmBNaU4csRfxmwLEshvFXLHeuoH3vfumMQIs=;
	b=GRUY6nK2yw+atZMNxF9GYvbT4hI2pzsBpk7e+PWpxSktwjDlFz/D7SqP8vlWghRuRg0CHt6WrfnVOj4CtSqJNWF+ifNqiBGiS3A16g6FHb3M+/fqN90j+f/q24OHmgdktoF/3zamQhwb4Qs17V7PvfSf4pjbvuaZNKhnxfCdYMY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:1111a2b8-59e1-43fa-84a4-b28e9218d51f,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:27a6d66c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0e0c6c1e982611f0b33aeb1e7f16c2b6-20250923
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 664971407; Tue, 23 Sep 2025 10:36:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Sep 2025 10:36:04 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Tue, 23 Sep 2025 10:36:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQLyCmgwabQ11P2malch+ZPK3GT61zO9WFvY+4bzB42Hda35Q0oKs4Sk8zbepa7Fh/p/3+CyqXeBLJSgob1Cf17+62lp35jMPGoy69kT+2IiE3SlCQlBrNKu4whqp/BMa+HiO4bGGC6HyQcZZOQUDB0Faw2Z6EsdK8BRJrI6JU5iEp5fuz4U3dQNaaUKnoxcfzANNXHCt2vaNLynK1zRBau+JPN8pS8FvcDT8lH85SIbZlJZyUbhCw/YR3Ohtxc4iC/MEtarD/62he9J/YH3MmtKbxoBtz+N5t5DePfo9j8IBLhPrskyLzYjRrEFagwiLJS7XlMcEzkXmGmTcduNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tkc/jU4EmBNaU4csRfxmwLEshvFXLHeuoH3vfumMQIs=;
 b=pmhaRQen6SZYYh2G8lopQlBhrU5oXPTqa1zRXwOZobl/2tQx6yAPgq89a+YLUATAVvxHgxaWPhNVHMhErdn0Jhc5k1zWfS784i6i3I9ubUHtuBRcyhDzLVQWjnTDv/AyublHHL7wW0BQv0Dy4ZjexbVWe5MOgyA9FqJPV5eNnll0nF/FSkxbP12tOfVSjoZf0dNZzk31rzO44lSk6KonSiqQ7lcrssl2ej3bk2aKLkRCbyOM6jdsbmKqMkBi5T/IwcA7tyboGUyXHfafbd1g9g+TMKVTuY5otIj5MMfZKExoml2e++BLLhWqgdb8rcGN1IZIDP9HTm7SfUlG32XBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tkc/jU4EmBNaU4csRfxmwLEshvFXLHeuoH3vfumMQIs=;
 b=e5TT8YCfkD3y37sZOxdGBF2aE3zHCTnaaPY3Lw4t3x1Hf44yoH4UNSAIUDGk6W4YHPn+WRR5V+hYFqceBi7RlsqeJqJmQXSHEh2Igx/Az4r4GNE7rmdomPefAhCp/vzVsslDn1tUGfBdL2X+3Rr8OU10ZGJEmb8GkzFKwLSG5Uo=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by SE1PPFC86F9605A.apcprd03.prod.outlook.com (2603:1096:108:1::865) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 23 Sep
 2025 02:36:00 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 02:36:00 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"nicolas.frattaroli@collabora.com" <nicolas.frattaroli@collabora.com>
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
Subject: Re: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Thread-Topic: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Thread-Index: AQHcEwpW87Sc9bspPUqF1pf91CjDQbSZyAEAgACRkwCAAIY+AIAAKeQAgAIpV4CAAcjDAIAAYpcAgADhGgA=
Date: Tue, 23 Sep 2025 02:35:59 +0000
Message-ID: <eb9b0ea70abb09f45c50e88b6221948ae09be6f7.camel@mediatek.com>
References: <20250822021217.1598-1-jjian.zhou@mediatek.com>
	 <CABb+yY2Ay+KqviJvOQC8X8kfzJN6-fQT04A+TCJAkLnWx+XwZg@mail.gmail.com>
	 <a9dd348fd7df95ebd5ad9cc58d57b588a18ccc9d.camel@mediatek.com>
	 <13850137.uLZWGnKmhe@workhorse>
In-Reply-To: <13850137.uLZWGnKmhe@workhorse>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|SE1PPFC86F9605A:EE_
x-ms-office365-filtering-correlation-id: 0021a134-e7f8-42c2-9c36-08ddfa49ee94
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?Sm5kMzBBcEQ3Y2lrOStDazhHL0dVYUlQVDgxbllpK0FKeTVqU2dMZVgveFZU?=
 =?utf-8?B?OVgyNGNiczM0L0VLRUw5ZDhtMmVMYkt6YzQ5T0JxSUk5SDZZRiswc2xEZHNP?=
 =?utf-8?B?S09va0hGWERWb001N1psSmtrSHFabTBjSHh1SE5tOVlZOFF2SWxNa3d2SE9H?=
 =?utf-8?B?ZVRydGs5c0FCcUI4OEhRdUVCS0NJNC9qTEpnK3ZZUXVrV2hTR1JzZ1VLSTdl?=
 =?utf-8?B?amgvQ1FEaEw1NDZEaWFhTW96cXd2cng5eHRaSmticTFidTMwQ2huRlpSV1NB?=
 =?utf-8?B?bDVhZVBDQU1nV0lvUmsyTlZwU0pLN09zVm94bzMrQzRzbklHUTFRVU1mN0k2?=
 =?utf-8?B?NDdlZmpGK0F0aThyMWRCbjhIQ0hpbDRVODU0R1FrZmhjUW44RktHajF2dEo0?=
 =?utf-8?B?SFI3ckJiK1RvSzlwS3RieVdLRXdsUG96NzFZNS9VKzh1OFd1ZzlZVVJ4WG5u?=
 =?utf-8?B?NFVCWHFTaFRxcCtGL1gyUTFmci91U3p0aXRsQmY3eUw5cmYvR3dRU0c5eDVN?=
 =?utf-8?B?eUF6MENkUkNtdmIvVUNIT1hEV0dUbWttengxOWdZb1pwOXk1ZldNT2R4VUpq?=
 =?utf-8?B?ODFrN0htYVZzckxnb1MrbGtGaXJmenhkY0ZYT1RtNHU3bklIRWpQWHFqOUpK?=
 =?utf-8?B?QmpzNlZ0Zi93UFpCUkNLWWQzQ01oeFRLSjYrMStOaWdoaW1pd2FOQ1AyS3dE?=
 =?utf-8?B?M2hHUDJPNW0rRDBBcTN2blFQc2hqTEtrV1N6bU50aTRvK242bHp2Z09kVEk5?=
 =?utf-8?B?SE05UENtVlcrbGFLRW9HWGU2NHRHT3AzYzZKcW4rckkzaFlDRldhVXlEVXJI?=
 =?utf-8?B?RlhSMHljdWxsREV3dHd0UHdQVGlPdnJ5cnlWV2M5cDhrU2ovNjFDdlNxbjFL?=
 =?utf-8?B?ZWRkUXhvSVp2WlBrWVRpZ0xOK1ZlbUIxeFo2NE1JdEpRRUcvTk1oVkZvZ0Uv?=
 =?utf-8?B?VC9kNHgxL3NzUzN1ZEh5a1A5QVZ3YmwvK3FGK1B6OHlGWkFBVCtPUWE3Z1RM?=
 =?utf-8?B?Wi9TblgwTlZ6UHBBL044V210ejNwZGppZXlVcUhMVFF6cWZLZUR1RWx5dHhu?=
 =?utf-8?B?SFhuVXN3QW9ROHJ6TG9qZURnTW41N3RXMGNpeUsxK0FiQytEdytZeXZpUkEw?=
 =?utf-8?B?WGtrYUVtenJJekRhcVdqWVhmRHBkQ2pObjBDTnJXanhaejAxdjhTb1c3ZGE2?=
 =?utf-8?B?TlpnSXpNdTVkdE1nVGI3NE4rM2tBRTNmOVp1UyswZnJOT2llSE1qZkxrWWhS?=
 =?utf-8?B?STlrckR1K2ZPcGFUYVpkSEJJdTUvU0c2NzBzcWg1S1ZlR2xocXBwS2pEc0xx?=
 =?utf-8?B?TTNnYjVTQUxwSDZSKzJNQW1zblhrYUw3dmp4NU9HTHFZYnY2eU10MjZPSmdw?=
 =?utf-8?B?NFZzU2FJMEp1QnVORUNRTG9sVXBjbHBxeUVqM0lLcHFkckRLTjNteVdLWkNn?=
 =?utf-8?B?ODF4a1pnN0JqOUovNDZZTlBRWUVKL1U5eVQ5WGFlZ3pKNWgrOU5kUEFmUFF5?=
 =?utf-8?B?REEwM3FMaU1Hdzc3TDBSYTY2TXI4a0Zta3VoRTZzUnExT2pMOFFQZEJubWxz?=
 =?utf-8?B?ZlVFdUR6WjFRNi9DR2tlMnJmTktRQnRTVm1rTXlLeW5HQU5Wdko1TEpya0g2?=
 =?utf-8?B?dGNuT0tTMTRMb3k1YTNQalNHQkROSytIS01xa2g5Rjk2QXdXQTVGQUxuUkdK?=
 =?utf-8?B?TGpxWVlNbHZ1azVhUDRxbW53bjVFbkdWcWlETVIwb0dYeXA2ekJla0x6Z3Ex?=
 =?utf-8?B?T0NvOS81eCtRRjJ6aFkxRU1QM0dCN2kySUNxME9VcG50NmRWSzZpNGI2ZUJa?=
 =?utf-8?B?RHFKUy9jOVFVU2xwVExJNHhwT3RNaUdHcVZUSG1uQUg0OS82S2Nta2VwdkE0?=
 =?utf-8?B?azRxYWJ3RXYySnQ0YlNUZkZTVnQxeTdGMWtnaXdHRTdFRGU1N1BlSW9xbVBm?=
 =?utf-8?B?WUF6TTIzQmVOMnVEUFNsM2RpU1J3V05vcGJQZkR5ckEwVml1Zm1uZklqMitD?=
 =?utf-8?Q?rI7oPmSJqQzrhyO35iD3oCHygfFmzA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzdnRUl0TmtyUjhhcDJ2K2Fza1ptcG5QSEJVZGtvbnRWOFYzV1llc3VCNmNS?=
 =?utf-8?B?K0x6Q1E5anpQUnkxTWdBNXVIWTNMdS9Ra2hJTUxWQituS0N0d1dLTDJobk1w?=
 =?utf-8?B?OWlMblExUzlDVi9CeHAyc05jUUlqYUFaWmV1N0NsMEMvRXBSeHRBcFdwRXg2?=
 =?utf-8?B?RUk3MWRyZHAzRFJSaUF0ZlVvRzVxU0ExNGlGdHo0WEhkNUJmeDNKS0E0R21G?=
 =?utf-8?B?NUZnaEl3ZXB5d2ZVTEYyaTZyTndrZGd0OHhSbHkxaXV3YzRITVI4SVlVT0ta?=
 =?utf-8?B?NE1MWS9sTDQ2REJQR3hoNlBjQVJlR1JHZVc0ZnhVWFNsSzE5VmE0MTUxV29H?=
 =?utf-8?B?aDlRSk1lZkNXUUxROE1EVzJxK25RTUtQT214M25mV0oybjZySFR6RTZXMkVS?=
 =?utf-8?B?cTVYaTVYQno3MW8vak1oRHJxZnFSSlBBdEJPa1c2ZUVYLzFuR2Zxa2x3MUdj?=
 =?utf-8?B?c2h1Z2crd0s0dGNqRzlzNjk5bHBrVTFOVWRjeEdDMyt1SVVtRDV4dzFMQUl4?=
 =?utf-8?B?NHBkekxUdTlDNy9TKzQ0TFR2OXV5SmpiSDJFRURBRUtpYkJFZzVwK202YWlo?=
 =?utf-8?B?V2wzNXRNcE1YQmJoeUFoeUJ1eWZJTHJwTXB2UmRjSVg4cEZ4RmpmMTAvSTRa?=
 =?utf-8?B?V2xVYWRpNVdJVERYaWpVQnNXRjlGNFlhN1ZDbGQzcTduVnl4cnV6aTJ2ZG8w?=
 =?utf-8?B?SkZRQVc2ZDRkUC94ZnFHV0Y5dEpyRURONFJDWlMwYUI0UVJHOG1MSTZMN1Uv?=
 =?utf-8?B?dkNLM2p0UVEvNldZY1JrNiszWktLNGdpYUFGQkxReUhRSi85VGUvRG5iZG1J?=
 =?utf-8?B?UDYxQlZmd0FONktOK0FSS3JGcGJQdGlZa3pSc0VlODV0QUNEdzVYMmN4MnhI?=
 =?utf-8?B?ZE5ZUmhoSk9meW1HazhScWZ4cG8wbEJzblZtRmRHdUc1QVljbmN1cG9YQy9H?=
 =?utf-8?B?dzkrcW1LYSttZVFoWEQ1cHZGN0laTkJNNWVrWTF6cU52MFJHT2pOdnJOdE9O?=
 =?utf-8?B?WS9wQUw0R2Z6OVZnUnh2MFFEYmR2ZC9wWDQ0YUh0Mll4ZEJHd1E3cE5oTFNn?=
 =?utf-8?B?K0tVT000UFJVaER4bm5lR3JsczlRUm8wTlZPUHlOMzVES2V4VExQNUh5YmNT?=
 =?utf-8?B?U3NsTnA3MmhzblZ5Nm1HVEFPN3ZGc2FXdVdML2Rodnk5bTJMZXRCV2VGWHJm?=
 =?utf-8?B?WUdVM01uVXFpYzVtZHFHcFR3TS9La0xQL0VreWhyQ28yQUJHU05zTzB1OUZ5?=
 =?utf-8?B?cW1vQU5NRFZua3orNXhqWEJ0c3VmZStXeStsWjRURk1xMGxZWktrS0ZVR0hL?=
 =?utf-8?B?bXpza0F4bHR4RUtnM1pGR0pMeDhIMGNua2RmZkdxampxZFc1aElCQ0IxTzhE?=
 =?utf-8?B?QXkxT3ZHdEdvQzZGZ3NCeTNvVGF5RmJFNnNDWmZERU54WTI0blRRcnNxbFgr?=
 =?utf-8?B?NVRQRUlVMTg4R082cXZ0c3JvUU9nNDhuMDNVcDk0cXdaMHhxdEkvOUM3NjJw?=
 =?utf-8?B?UzBGTW1ISStTcTB3eEpDQlhmbU9ZeDVCTUdIeExpSEtzK3ZNSmp6MXc5d2tk?=
 =?utf-8?B?cElMN05wZ1JJZnJFcVFtRE9IUkpxaGs2SExGN0dDUFdhdkpQYVhwMVFYS1l1?=
 =?utf-8?B?cGJqaG9nQ1hDOElqd0NFQURwVWdtWXJtdEVhRTRVcjFBaU1zT05Uaks0Si9i?=
 =?utf-8?B?NVlCUzB1aVRaWUg3NWM5ZE13VittK3U4RFVabnR2aFZOTkpRMGN6U0gzUFhh?=
 =?utf-8?B?TzJUbWVZUlFOQWZHTzJUVHczOTJFK3N6MVZ5ZlRULzVlcFplaStKbEc0bTZC?=
 =?utf-8?B?bEcwaURseTFXZEdOUGJNWVpZUVBIMGdCYklYeXQ1VUt2OHZOdEJJY0crU3NX?=
 =?utf-8?B?TDQ0bGxXblFHWll0RzYzckRLUXVjZkVCN1BmRkRTVXFScEg2WSt4SHVZbWxi?=
 =?utf-8?B?ZmxsV1MzTXZaV29Dc244bW9ndWw4Y0xYN1Q3T2RQZHlEZzhFa2loQ0h6Zk5J?=
 =?utf-8?B?YWVVb0JaOVJUVWRPcFdnbDNObTVEajZoZkxJR1pSSW84NUQ1emowUU04aXMr?=
 =?utf-8?B?MUFOc2tWRHZjNURONVd0VlBwTG41RGpGYk15T25XdTRqWUFJTTh4Rk0xREVD?=
 =?utf-8?B?dThWWWU2cHpVR3hwYUE0VnB5OThuSzB1YXZWNStPVjBTOXNaRWFFNGhTZC9Z?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EDE9FFD4B0B474D9B83494C5C3E8A17@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0021a134-e7f8-42c2-9c36-08ddfa49ee94
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 02:35:59.8691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uueRBSxyzH4tbnS8K1ZV10bL6y39aEKY2/xj5EbAFhFk38qS1LgroxiRrBxeOSYfSwD97e3o9q0ncIzdTn4gAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFC86F9605A

T24gTW9uLCAyMDI1LTA5LTIyIGF0IDE1OjEwICswMjAwLCBOaWNvbGFzIEZyYXR0YXJvbGkgd3Jv
dGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+IA0KPiANCj4gT24gTW9uZGF5LCAyMiBTZXB0ZW1iZXIgMjAyNSAwOToxNzoy
NyBDZW50cmFsIEV1cm9wZWFuIFN1bW1lciBUaW1lDQo+IEpqaWFuIFpob3UgKOWRqOW7uikgd3Jv
dGU6DQo+ID4gT24gU2F0LCAyMDI1LTA5LTIwIGF0IDIzOjAyIC0wNTAwLCBKYXNzaSBCcmFyIHdy
b3RlOg0KPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMNCj4gPiA+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IE9uIEZyaSwg
U2VwIDE5LCAyMDI1IGF0IDI6MDLigK9QTSBOaWNvbGFzIEZyYXR0YXJvbGkNCj4gPiA+IDxuaWNv
bGFzLmZyYXR0YXJvbGlAY29sbGFib3JhLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBP
biBGcmlkYXksIDE5IFNlcHRlbWJlciAyMDI1IDE4OjMyOjEyIENlbnRyYWwgRXVyb3BlYW4gU3Vt
bWVyDQo+ID4gPiA+IFRpbWUNCj4gPiA+ID4gSmFzc2kgQnJhciB3cm90ZToNCj4gPiA+ID4gPiBP
biBGcmksIFNlcCAxOSwgMjAyNSBhdCAzOjMx4oCvQU0gQ2hlbi1ZdSBUc2FpIDwNCj4gPiA+ID4g
PiB3ZW5zdEBjaHJvbWl1bS5vcmc+DQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IE9uIEZyaSwgU2VwIDE5LCAyMDI1IGF0IDc6NTDigK9BTSBKYXNzaSBCcmFyIDwN
Cj4gPiA+ID4gPiA+IGphc3Npc2luZ2hicmFyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiBPbiBUaHUsIEF1ZyAyMSwgMjAyNSBhdCA5OjEy4oCvUE0gSmpp
YW4gWmhvdSA8DQo+ID4gPiA+ID4gPiA+IGpqaWFuLnpob3VAbWVkaWF0ZWsuY29tPiB3cm90ZToN
Cj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IC4uLi4uDQo+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gPiA+ID4gPiA+ID4g
KyNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ID4gPiA+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgv
cGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gPiA+ID4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9zbGFi
Lmg+DQo+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ICtzdHJ1Y3QgbXRrX3ZjcF9t
Ym94X3ByaXYgew0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gTWF5YmUgJ210a192Y3Bf
bWJveCcgaXMgYSBtb3JlIGFwcHJvcHJpYXRlIG5hbWUgPw0KPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiArICAgICAgIHZvaWQgX19pb21lbSAqYmFzZTsNCj4gPiA+ID4gPiA+ID4gPiAr
ICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgIHN0cnVj
dCBtYm94X2NvbnRyb2xsZXIgbWJveDsNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgIGNvbnN0IHN0
cnVjdCBtdGtfdmNwX21ib3hfY2ZnICpjZmc7DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICBzdHJ1
Y3QgbXRrX2lwaV9pbmZvIGlwaV9yZWN2Ow0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
TWF5YmUgYWxzbyBoYXZlICJzdHJ1Y3QgbWJveF9jaGFuIGNoYW5bMV07ICIgc28gdGhhdCB5b3UN
Cj4gPiA+ID4gPiA+ID4gZG9uJ3QgaGF2ZSB0bw0KPiA+ID4gPiA+ID4gPiBhbGxvY2F0ZSBvbmUg
ZHVyaW5nIHRoZSBwcm9iZS4NCj4gPiA+ID4gPiA+ID4gQWxzbyBpZiB5b3UgaGF2ZSAgInN0cnVj
dCBtYm94X2NvbnRyb2xsZXIgbWJveDsiIGFzIHRoZQ0KPiA+ID4gPiA+ID4gPiBmaXJzdA0KPiA+
ID4gPiA+ID4gPiBtZW1iZXIsDQo+ID4gPiA+ID4gPiA+IHlvdSBjb3VsZCBzaW1wbHkgdHlwZWNh
c3QgdGhhdCB0byBnZXQgdGhpcyBzdHJ1Y3R1cmUuDQo+ID4gPiA+ID4gPiA+IFNvbWV0aGluZyBs
aWtlICJzdHJ1Y3QgbXBmc19tYm94IiBpbiBtYWlsYm94LW1wZnMuYw0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBJIHJlYWQgc29tZXdoZXJlIHRoYXQgdGhpcyB3YXkgb2Ygc3ViY2xhc3Npbmcg
aXMgbm90DQo+ID4gPiA+ID4gPiByZWNvbW1lbmRlZC4NCj4gPiA+ID4gPiA+IEluc3RlYWQgdGhl
IGJhc2UgY2xhc3Mgc2hvdWxkIGV4cGxpY2l0bHkgbm90IGJlIHRoZSBmaXJzdA0KPiA+ID4gPiA+
ID4gbWVtYmVyLg0KPiA+ID4gPiA+ID4gQW5kIHRoZW4gY29udGFpbmVyX29mKCkgc2hvdWxkIGJl
IHVzZWQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEkgZG9uJ3QgcmVtZW1iZXIgd2hlcmUg
SSByZWFkIHRoaXMgdGhvdWdoLiBCdXQgSSB0aGluayB0aGUNCj4gPiA+ID4gPiA+IGV4cGxpY2l0
DQo+ID4gPiA+ID4gPiBjb250YWluZXJfb2YoKSBpcyBlYXNpZXIgZm9yIHVuZGVyc3RhbmRpbmcg
dGhlIGludGVudC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFuZCBob3cg
ZG9lcyBjb250YWluZXJfb2YoKSB3b3JrID8gOikNCj4gPiA+ID4gPiB0eXBjYXN0aW5nIHRoZSBm
aXJzdCBtZW1iZXIgdG8gaXRzIHBhcmVudCBpcyB0aGUgc2ltcGxlc3QNCj4gPiA+ID4gPiBmb3Jt
IG9mDQo+ID4gPiA+ID4gY29udGFpbmVyX29mLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IC1qDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBXaGljaCBpcyB3aHkgaXQn
cyBjb21wbGV0ZWx5IGVxdWl2YWxlbnQgYW5kIHNpbmNlIGNvZGUgaXMNCj4gPiA+ID4gc3VwcG9z
ZWQNCj4gPiA+ID4gdG8gY29tbXVuaWNhdGUgbWVhbmluZyB0byBodW1hbnMsIGNvbnRhaW5lcl9v
ZiBzaG91bGQgYmUgdXNlZC4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IE5vYm9keSBpcyBzdWdn
ZXN0aW5nIHR5cGVjYXN0aW5nIGNmZywgZGV2IG9yIGFueXRoaW5nIGVsc2UuDQo+ID4gPiBUeXBl
Y2FzdGluZyBiZXR3ZWVuIG1haWxib3ggY29udHJvbGxlcnMgaXMgZmluZSBhbmQgYXJndWFibHkN
Cj4gPiA+IGVhc2llcg0KPiA+ID4gb24NCj4gPiA+IHRoZSBleWVzIHRoYW4gdXNpbmcgYSBjb250
YWluZXJfb2YuDQo+ID4gPiANCj4gPiA+IC1qDQo+ID4gDQo+ID4gT0suIEhvdyBhYm91dDoNCj4g
PiBzdHJ1Y3QgbXRrX3ZjcF9tYm94ICpwcml2ID0gKHN0cnVjdCBtdGtfdmNwX21ib3ggKiljaGFu
LQ0KPiA+ID4gY29uX3ByaXY7DQo+ID4gDQo+ID4gVGhhbmtzLg0KPiA+IA0KPiANCj4gQW4gZXhw
bGljaXQgY2FzdCB3b3VsZCBiZSB3b3JzZSwgYXMgYXQgdGhhdCBwb2ludCB5b3UncmUgdGVsbGlu
Zw0KPiBDIHRvIGNvbXBsZXRlbHkgaWdub3JlIGFueSBzZW1ibGFuY2Ugb2YgYSB0eXBlIHN5c3Rl
bSBpdCBoYXMuDQo+IA0KPiANCj4gDQogICAgIHN0cnVjdCBtdGtfdmNwX21ib3ggKnByaXY7IA0K
ICAgICBwcml2LT5kZXYgPSBkZXY7DQogICAgIHByaXYtPmNoYW5zWzBdLmNvbl9wcml2ID0gcHJp
djsNClRoZSB0eXBlIG9mIGNvbl9wcml2IGlzICJ2b2lkICoiLiANCldvdWxkIHRoZSBjb252ZXJz
aW9uIG1lbnRpb25lZCBhYm92ZSBhbHNvIGhhdmUgdGhlIGlzc3VlIHlvdSBtZW50aW9uZWQ/DQoN
ClRoYW5rcy4NCg0KDQoNCg==

