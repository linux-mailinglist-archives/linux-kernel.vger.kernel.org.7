Return-Path: <linux-kernel+bounces-815986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD79B56DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7579D3BC1F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEC71BD4F7;
	Mon, 15 Sep 2025 01:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kXBOhz8u";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iHi3hJIU"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD52628C;
	Mon, 15 Sep 2025 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757900019; cv=fail; b=leAtDeFIx3a+VPuqEcZ9TKgNKo3RH5HjdF3u2GcxOp/brBxrYIwr7ykbji9SsYq5/chl/zfDEbsbqsMxwMKLCrapxDa5OH2u/c/jOGZYlsmyCnkNULiKbHVdmBPA/at2L4Ldw8bu1Y2pxlu6NQYYA5kXGzkL3asV8t9nXFZsmUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757900019; c=relaxed/simple;
	bh=Ll8ixS8eAyYlDSuHBRD19nJ68VP6zitL0lU4+AC+lLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s89JG6Ely50bbevIRf/omlfRs0n/GOKcBiqNWHN5/2NCr66LTICqFN/7mAnaM3eyodB/6xdg/Yxy0XpkTYTQQumSIHwghKAELfwcw8O0mI3A42JL//Q9NAgCmWG4BrN8ccfoy68ThJURvDJv6EJUHk+SuQcrjITkW/nvGZu65IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kXBOhz8u; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=iHi3hJIU; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fc85898891d311f0bd5779446731db89-20250915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ll8ixS8eAyYlDSuHBRD19nJ68VP6zitL0lU4+AC+lLY=;
	b=kXBOhz8u1tLXny4gedjw3YJfJPssk/QjQbR7sQmbmR9C3fH9Zm5AYVQQRcTn8V99h5EcXYXxQRnHnE1vetjrrZXgVw9LlljQuo3WuJvFdwTG4eBAu8qDUuYvdvRFZVKnnUvnh3g1FkQReEzr82s6YW9Qnnwp03ktbQVFMXJnCVw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:6bb2bdb7-c016-4d67-9d8c-dd641a054037,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:8b924fa9-24df-464e-9c88-e53ab7cf7153,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fc85898891d311f0bd5779446731db89-20250915
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2109457333; Mon, 15 Sep 2025 09:33:30 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 15 Sep 2025 09:33:26 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 15 Sep 2025 09:33:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXr1FjlSiz6pEgvDC7WHX5sgJUJaqYZ8VQ2EsY8/aHDlEBRmYoZoahfXAhz5CHmsTIVlBVEJeDF9UEW8gQsR5j8reJPJC8x8wGuPaYOnAo3qEwrs5PxWGOcy1ZGFC6vVkaiznrMh9BOkmF4ERkkaqxuGL4VnZJHt7IX2BDZcwqopOj53cQPNrNiP0D9RB/+a0JkxQ1QYDO6HRQRmI50o0bKuLjBJhKIK9JeEzUAJ30UmCIkfX1plo6EHFJs+ZYP3W/hEkS5raqajLZjntusyY2vt5LyOCzl2wOujvFA0wdGH+zg7Grq91IC/QhUmjpjGmbGh9mPxe/XeiipnbMY/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ll8ixS8eAyYlDSuHBRD19nJ68VP6zitL0lU4+AC+lLY=;
 b=BqAXCNfBr4NrAfl1qIFhl5xHQAVyIZ5/EZrKsKnoiCJCUSMXX1cT2bTr2AmUKEAwDYdafMyIxqqoRPLYkMZxvyIAMoN/iflvAf2kTPvDVhjnONVWFSzPNh28XZ/WMBtqoTkHjOaKNgulOzSOonZS1secjOdcT9Z5E9j5MezWHAuxsJgQnPndxB/ZqIHMsw8dXyjiRYxiK8UKkGTaSMCB0Cuwyafx7cemCmg8SwKS5pbW0M8lBqDuFFf1YKnzlgr/bPoclA4V1t6qrzCblPvppoD+MbNHBH7XD/mh6Zfo7nlj13d42BCZ9HQXPo/bRaqeYTDR/fNkpKSeB0dn6PODaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ll8ixS8eAyYlDSuHBRD19nJ68VP6zitL0lU4+AC+lLY=;
 b=iHi3hJIUGGCBJz+Q8wQkR05dI7z8xoY+zymgDuVyPeJrFs+A5YHADZ9eH+gBZ8a3yArQQMXpdkXOR/KO6kXJqkV9E5smxqzwcBGwyPV6Ij2RxohYbve0UD3+ZYVW3MGLuGzzix59rwM+nyF1p1kfqMYEuI1jF7CW+1k8GpbHAM8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7099.apcprd03.prod.outlook.com (2603:1096:101:ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 01:33:25 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 01:33:25 +0000
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
Subject: Re: [PATCH v4 16/19] drm/mediatek: add OUTPROC support for MT8196
Thread-Topic: [PATCH v4 16/19] drm/mediatek: add OUTPROC support for MT8196
Thread-Index: AQHcF/NAbAXVVsnBs0GflsNXgT1IibSTkYyA
Date: Mon, 15 Sep 2025 01:33:25 +0000
Message-ID: <6fb51817ba0e0772bc6921d24d2cece75df94fe8.camel@mediatek.com>
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
	 <20250828080855.3502514-17-paul-pl.chen@mediatek.com>
In-Reply-To: <20250828080855.3502514-17-paul-pl.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7099:EE_
x-ms-office365-filtering-correlation-id: 8adff3c7-9a39-4ec6-3c9f-08ddf3f7dd5e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|42112799006|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cnBFTDErNWs4K1ZxUnQvVCsvbk5ZR1F3eEpSZnk5ZFlXQnFtUW5uS1lPNkp2?=
 =?utf-8?B?QW5ZaHlNKzNCQ0tDZUducUJYbjl0ZTY4SXJPUUhuUDlHZERja2c1ZENBZVVV?=
 =?utf-8?B?YUkxbFZEOXpzbUQySEUzK3dVU1ZKTjZzVm5Bbk55UzRpRjY0MGhPVStFRVlH?=
 =?utf-8?B?WjhvbWNCNnFyTlBsd2FxSG95TVZJVTNZRG5YUTJrQ2JXT0dmSlRDODBRelBM?=
 =?utf-8?B?VWEwOEhDM1IxR3l4OXJTTHlZQU01MlIvS09lSXZPT0VIb2xjOHZNbjN3aCs4?=
 =?utf-8?B?RmxTd0plZ0NCcmFGSFlwY0xoY0tmMHREUGlSRVhlSTViM1pjVUNUekU1QnNX?=
 =?utf-8?B?R3Z5bUNQek81NEowODhGMFZpbVZXSGRyTm1CeGtKSW4xZE1TNHhLQTVTRFc1?=
 =?utf-8?B?OHpCMy9Gdk4va0Fmek9KWVhUSzNtWWYxTS9IbjRzMmJqcTc3dkhKbEwxd05F?=
 =?utf-8?B?ajB0RXM3SXhnUDVuYW0vczNjcXgyMkxNK2xxVXc3Y2pWcklEWGd2Mlk2ZW1o?=
 =?utf-8?B?Z0xVc0tvelgvOGdNYTRicyttQVBTV1ZUMW1xVUt6Nk5iUmVpQk9jWENvTmpi?=
 =?utf-8?B?ZnkzVG5iV2ZWaFBnM3dVOVhoQUxaUEVraXNZNmQ2cW9lVVFiampQMjZCYW1H?=
 =?utf-8?B?Mk9jREs4cDRvOTl0U05UYlY1RzEwN2x1aDJwSk9aZzBldVBBRWRhd3ZpcWVN?=
 =?utf-8?B?bzdBellhRGJ1NUU1ZWRNeWxhM0FXQ3NxYW5DL1VUS3EzZkNpUzNJZFlqN0Nj?=
 =?utf-8?B?NFYxNllJRWdQZGtyTG9KaVpGVEN5aEF2SjZRbUVmYnROaTdHdGV6ZVBLakl6?=
 =?utf-8?B?S0VZUk1CdTh5UGY2RXR2eVBkZUxwNzhYTVB3cGxuUHFTR0JwWDhrV0Q4czNs?=
 =?utf-8?B?SkxyN2t6M3BKaVlpNXl5Q1FrYjlsVzhoMWlXQzN2eEUvQXQwZHd0b0Q2WFhM?=
 =?utf-8?B?ZjdEcXQ0VG9tR0V1bmY3TWVJNDVBRGVkUWtuelNJdjZkckhKRGRxVVFoZVZ2?=
 =?utf-8?B?WUYrVlE1cEE5S3hZUW1FZGg5VWFlQVZiQk9vS1N5OEgzOG1SWDhnV2NuemZY?=
 =?utf-8?B?VGQ4bVp6T3hPcnhDYjc1Snp3YzArZGNDMkF1bWRydDkxT1c3cmtBYlgyU2Vv?=
 =?utf-8?B?M0M5WVkyaXZDRkxtcXRKV2lvNGVOUVh0OWtEZWZEcjdGNUhJNWxKdVhuQVQ1?=
 =?utf-8?B?TE9vRnRYWndEQ2xkUytnaEpRZmN3TC85UCs1QkZjK3pjNndSTXpmWFp4K0t4?=
 =?utf-8?B?TzYrV3Bxek5vSW1Ta0lGakREOGVCSkxVSHlPb21ZZ0tLbmNaMUQ0NVQvV0do?=
 =?utf-8?B?Yk93NHJWV0FaeG1jMWkrZkxESzNRa1dVSTJXWjdXenZ6ZC9KMW1tYmg1Y0RT?=
 =?utf-8?B?MHNCQmYrN1VlSkhyMUR3b3liOTZkRVE5Ukxjc1RoZ2FkcksybFZxbVN2K3o0?=
 =?utf-8?B?SWxLSlAzZHo3KzJ4b1ZTRXMrdm1TU0g5NDRuUFVmdXBiT094SjZYOWVHV2hy?=
 =?utf-8?B?YUJrZTMyNlZIUEVsY1lkR1Q3aTEyZ3dZeHNycUdndTNRWnI5YkVwbmszNVFy?=
 =?utf-8?B?RkxWWXhFU1NoS2RVd2JiS2FRY2FRYWRWSnlIZmZjdDNpQlNFb3d3WllxNjln?=
 =?utf-8?B?TWYzTkZEYzB1dE1oTlVPT2MvdXpYeUd2MGVLWkFuaDdWY3hWVDMxT0p5aU9q?=
 =?utf-8?B?VGdxa3h5ZnVjbysrK0xxN3NlblRYQ1dzWExmSUhoT29JdTdkWUZ5MWxWYXB1?=
 =?utf-8?B?bjBLRE5pY0EvNmJVOFlXMWFEYzMxN3JsbGNZWG1TSXB0MWI1cmxBSmN6Mk1o?=
 =?utf-8?B?MFI4eTAwTjRuUnJLNGlKV2NWOXdKQWczeVBLajR6TWxEZUFjTWhZbkhvVXJj?=
 =?utf-8?B?eFJiby9pMWdtc0hpZ3I5MlRBblBoaDAwaURJTFRPYmIxMHBXNUpRYVluNmg3?=
 =?utf-8?B?NFR1R056OC83eGNkQU9CNm9Sd1NNYmNQc1lHNzYrUm9vL1Ivd3dJYi84cTZ5?=
 =?utf-8?B?Q0ZUY1FCTnhBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(42112799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUtqK1lpeVptSXluSW12T2pRdHlVaFcxQ1ppQjU5bkFxS2VCZTIwdHB1L21l?=
 =?utf-8?B?ejNlS2RpUUJLTGhBeitLcDNFdDNNenorN1IzVkx4S2lUekV1VVdQRlBiSHk2?=
 =?utf-8?B?R1JOUFUxNjRBaHI1T0RSWlV2alVkRllJTzVCdEdZdWtjVUZSMmpoc1l6Ui9E?=
 =?utf-8?B?WmJKaGRBYjhzckdWQm9lMGNZMEI0ak9NemVZS0N2ZWt2T1N6bGZ1N1ZyTTEy?=
 =?utf-8?B?Yk1xVEs2TXI0NGlRRVZ0dDV0bVB6bWNlNk51ekVkUU1NeFR2VXJ4bDdvSEty?=
 =?utf-8?B?MEgvTlFaQXhaR295ZXBISnZxMVl0Y0FvR3FaaWFSTk9LMHJTajM1S09IMTlr?=
 =?utf-8?B?ZjFob0VtZ0pvNTZKOUlLTjY3VHBvZmJLNHMzaFJGMGpvS1djdzVnTDE1UGQz?=
 =?utf-8?B?MlpUaW5wK21Xa05vYVluYlRaVms1NzFzeDNjMEZVRmIxaXlMYy9GVmJMRGdH?=
 =?utf-8?B?MkFYVGZDcC9NSzRZUVpqNDV0MUl4c0Jqc2thUHFqdDErT1RScFJWZy9nTVpW?=
 =?utf-8?B?WDJrWEpPODk3S2YyMW1nUXErcjltVjd1dXZoZ1RDekJ3dmUvaGFlRTBUR3NK?=
 =?utf-8?B?c25zWGRjMHZMN1JEZlEvMS9rMEt3cHdJc042bFAzUW9UZGhENS9KZVVpbGt0?=
 =?utf-8?B?bGszT3NjeTc4TStocFV5dXhXazV3RDN0RnBvMzRvaTRCTWNIYXR6aWFYRGt2?=
 =?utf-8?B?TjRST1BUek45T3pJMFNtYml2WUhyUHU3cmRTV0ExRTYwRkZ3SGx3bXMyZ3hn?=
 =?utf-8?B?ZlhmRWxvOEFmeFlmMkx1dmhEQnM2b0Y3Mlp2TU1pTVpSY3MwMTRHSi9YRjJ2?=
 =?utf-8?B?QVlMZ3BFYzJoMkIwM3FoRmZTUHRocEFnYTloZ3lsT0p5YVVIU2JsTkdjS0Rt?=
 =?utf-8?B?ODBSUmZGUVA4cHZRT0thMDBhVGRST1hBdmlidWdiekVhVWlnZkVvYncwa09i?=
 =?utf-8?B?NGZRTmhVVUpWVk45L1FHa2RvNmdjQVVTNlphOW9tLzVNVWZhZWxZb2oydXNH?=
 =?utf-8?B?ditrZzl1UThVWm9iV1RxcEpGTEFCd1Fka2RKMmp5OEhRYkFuNnBUSXR4UVRN?=
 =?utf-8?B?cFlYVnRaU2pObHlRMzVPZ05XOFprNFVjd3JZVWZUNjN0aldhdlNkTHl4M01l?=
 =?utf-8?B?RzNjVEZRVmUraGYyS1pLVVJVZFphVSthZlRKc1lwVWxKclpPeXZ0MHNlOFM5?=
 =?utf-8?B?d002cFZTdSttYURHN2lrbU5EZmdiNFJmL3hTVC84YmhXc3NVNHF1cnhDUnpG?=
 =?utf-8?B?ak14eFlKQThtYTdZd0dqelI2QWdEeTRmeUZLK3gwcWpvNUVxTmtwNnA4WFNj?=
 =?utf-8?B?eTJmUkZ2RVdkbXlwQlRrMXFVSzNlUlFxWDdtbGpQUHBuckhucVR3cnhpMUti?=
 =?utf-8?B?TUFTUUsvLzBtYlhQcFYxcUJjWHZJK1lkM1dmTjJKbGhSaTFLOHU1RVFrWWJM?=
 =?utf-8?B?K0VYWlZnQnorU3dyWkU2TUhmeHY3eFQ1MGxNZG5LYUwyeXlWY2RUbWJEQlhJ?=
 =?utf-8?B?dGdZSGN4MElPZjQ4V01nOVZGNkh6aXFhRG5LTkwrR1hJTGN2Q2l1MEdFTS9t?=
 =?utf-8?B?NGQ0ZzdmMnJTSkVQc2Y4eTFuSkdteS92Q1o1amk4bjNLZ3BsZXZDRzI5bUJT?=
 =?utf-8?B?elh6bUNYWXpvbmVHR0hBa291aWNEemdXcmhVWkNlNDVLQmhMTjd0cW93MnFh?=
 =?utf-8?B?dDk3Z1lWNjVSR0hBQWtvaWVLWU0vdEJnOVJMRi9IRzByRHF5alJuK1lEb3da?=
 =?utf-8?B?elY3NzVIQk1VK1MxN05WZFdEeHRIZnVKRUIrSjZMYWprTXZoTTVwaHh2UUlj?=
 =?utf-8?B?K3l1enVSZkF3aGovcitQcmxpbTBOZEdMdE9LK3VSRUFxc2JTTWRlZzBsWjI0?=
 =?utf-8?B?b0E5bHpxbXUzQldCQjZ3M01GTk5sZWhvL1dnOGNjOGcwdzZNNWIxVDgxVWdz?=
 =?utf-8?B?cUFSQko2Qk1hRmlVUjNWSURqdy9LQ0hOaXVHdTZwMCtxa1VsbERhYThmVHJI?=
 =?utf-8?B?WHBwTzI4Y3dlUHY2TGVBQmEzV204bzFZZktka3p3WFErWnFpNUxKMTcvYXNt?=
 =?utf-8?B?ZmVUY0E0WkFOL200WmVITGZCL0Z1RWJLdGJZMnh4ZEt3QldMUEhoZWs5UXBt?=
 =?utf-8?Q?RuMDI6Ol3wFA7pNDjWFCzvvZn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACD59177F0A45A41A7361444991F9CA3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adff3c7-9a39-4ec6-3c9f-08ddf3f7dd5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 01:33:25.2811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LD2gVX1a053qw4qy7eoSOwn3BAgCtmltC1igz3xzwJHTLv3+4dBwpErObZbyJkelLYpmqaB+qUDHmXF0NbYXSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7099

T24gVGh1LCAyMDI1LTA4LTI4IGF0IDE2OjA3ICswODAwLCBQYXVsIENoZW4gd3JvdGU6DQo+IEZy
b206IE5hbmN5IExpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gDQo+IE9VVFBST0MgaGFu
ZGxlcyB0aGUgcG9zdC1zdGFnZSBvZiBwaXhlbCBwcm9jZXNzaW5nIGluDQo+IHRoZSBvdmVybGFw
cGluZyBwcm9jZWR1cmUuT1VUUFJPQyBtYW5hZ2VzIHBpeGVscyBmb3INCj4gZ2FtbWEgY29ycmVj
dGlvbiBhbmQgZW5zdXJlcyB0aGF0IHBpeGVsIHZhbHVlcyBhcmUNCj4gd2l0aGluIHRoZSBjb3Jy
ZWN0IHJhbmdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmFuY3kgTGluIDxuYW5jeS5saW5AbWVk
aWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQYXVsLXBsIENoZW4gPHBhdWwtcGwuY2hlbkBt
ZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxl
ICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9j
b21wLmMgICAgIHwgICAxICsNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2Nv
bXAuaCAgICAgfCAgIDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Ry
di5oICAgICB8ICAxNCArKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX291
dHByb2MuYyB8IDIzNSArKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX291dHByb2MuaCB8ICAyMiArKw0KPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZHJ2LmMgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9kcnYuaCAgICAgIHwgICAxICsNCj4gIDggZmlsZXMgY2hhbmdlZCwgMjc2
IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3V0cHJvYy5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX291dHByb2MuaA0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtlZmlsZSBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9NYWtlZmlsZQ0KPiBpbmRleCA4ZDE4ZDU1ODM5MDMuLjdiYzAyYTdmMTc4YyAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9NYWtlZmlsZQ0KPiBAQCAtMTAsNiArMTAsNyBAQCBtZWRpYXRlay1k
cm0teSA6PSBtdGtfY3J0Yy5vIFwNCj4gIAkJICBtdGtfZGlzcF9nYW1tYS5vIFwNCj4gIAkJICBt
dGtfZGlzcF9tZXJnZS5vIFwNCj4gIAkJICBtdGtfZGlzcF9vdmwubyBcDQo+ICsJCSAgbXRrX2Rp
c3Bfb3V0cHJvYy5vIFwNCg0KQWxwaGFiZXRpYyBvcmRlci4NCg0KPiAgCQkgIG10a19kaXNwX292
bF9hZGFwdG9yLm8gXA0KPiAgCQkgIG10a19kaXNwX3JkbWEubyBcDQo+ICAJCSAgbXRrX2RybV9k
cnYubyBcDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9j
b21wLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMNCj4gaW5kZXgg
MmU0NTU4MGYyNWVhLi5mM2U4NjQ1YzM1YjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RkcF9jb21wLmMNCj4gQEAgLTQ0OCw2ICs0NDgsNyBAQCBzdGF0aWMgY29uc3QgY2hh
ciAqIGNvbnN0IG10a19kZHBfY29tcF9zdGVtW01US19ERFBfQ09NUF9UWVBFX01BWF0gPSB7DQo+
ICAJW01US19EU0ldID0gImRzaSIsDQo+ICAJW01US19PVkxfQkxFTkRFUl0gPSAiYmxlbmRlciIs
DQo+ICAJW01US19PVkxfRVhETUFdID0gImV4ZG1hIiwNCj4gKwlbTVRLX09WTF9PVVRQUk9DXSA9
ICJvdXRwcm9jIiwNCj4gIH07DQo+ICANCg0KW3NuaXBdDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdXRwcm9jLmMgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3Bfb3V0cHJvYy5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uOTlmMGQ2MGMzNTc0DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX291dHByb2MuYw0KPiBAQCAtMCwwICsx
LDIzNSBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPiAr
LyoNCj4gKyAqIENvcHlyaWdodCAoYykgMjAyNSBNZWRpYVRlayBJbmMuDQo+ICsgKi8NCj4gKw0K
PiArI2luY2x1ZGUgPGRybS9kcm1fZm91cmNjLmg+DQo+ICsjaW5jbHVkZSA8ZHJtL2RybV9mcmFt
ZWJ1ZmZlci5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiArI2luY2x1ZGUgPGxpbnV4
L2NvbXBvbmVudC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ICsjaW5jbHVkZSA8bGlu
dXgvb2ZfZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KDQpBbHBo
YWJldGljIG9yZGVyLg0KDQo+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+
ICsjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lz
Lmg+DQo+ICsNCg0KW3NuaXBdDQoNCj4gK3ZvaWQgbXRrX2Rpc3Bfb3V0cHJvY19jb25maWcoc3Ry
dWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgdywNCj4gKwkJCSAgICAgdW5zaWduZWQgaW50
IGgsIHVuc2lnbmVkIGludCB2cmVmcmVzaCwNCj4gKwkJCSAgICAgdW5zaWduZWQgaW50IGJwYywg
c3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCkNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX2Rpc3Bfb3V0
cHJvYyAqcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArCXUzMiB0bXAgPSAwOw0KPiAr
DQo+ICsJZGV2X2RiZyhkZXYsICIlcy13OiVkLCBoOiVkXG4iLCBfX2Z1bmNfXywgdywgaCk7DQo+
ICsNCj4gKwl3cml0ZWwoKGggPDwgMTYpIHwgdywgcHJpdi0+cmVncyArIERJU1BfUkVHX09WTF9P
VVRQUk9DX1JPSV9TSVpFKTsNCj4gKw0KPiArCXRtcCB8PSBPVkxfT1VUUFJPQ19EQVRBUEFUSF9D
T05fT1VUUFVUX0NMQU1QOw0KPiArCXdyaXRlbCh0bXAsIHByaXYtPnJlZ3MgKyBESVNQX1JFR19P
VkxfT1VUUFJPQ19EQVRBUEFUSF9DT04pOw0KDQptdGtfb3ZsX2NvbmZpZygpIHdvdWxkIHVzZSBj
bWRxIHRvIHNldCByZWdpc3Rlciwgc28gZG8gdGhpcyBmdW5jdGlvbi4NCg0KUmVnYXJkcywNCkNL
DQoNCj4gK30NCj4gKw0KDQoNCg==

