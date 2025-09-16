Return-Path: <linux-kernel+bounces-818016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C161B58BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D404838A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744BA1DF75D;
	Tue, 16 Sep 2025 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N2La1Xma";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ojE4P0FB"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3011A256B;
	Tue, 16 Sep 2025 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988132; cv=fail; b=PV6u8MSXbNHiMxiQe8PLSUme7B+2X0zigP68QD2SW5I0Z9W8zhaDAOKnydv1ISzkS3Cj2qfTSHhukydDPDIujSWnKi/sJBrk/yYuZrja8TKbaiiMQ40HCHmqnvCsEPnGL8saroA1M7z1LFd7udF/4pYm2EjNfo22MmQ/dMxwmnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988132; c=relaxed/simple;
	bh=ekcCKJ4KkF/cGbyE35L7zr4FMJVhQMvVZf4VAnnGgEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oQKdp1jR668jJeaQ1HsBKvXxU+jAFAKo61iPjg9sEUTCSisXnFXbxcqwEHLy8YA946nRB135YPcvIYJ06oNHRNNSj8pYMXX6XVLEZdyp4h1+QXbmaYtG4CQLzBNqAmDeksSNzTuWuX4Ab+E+ZHoMvX6o+qAHGqgYJH7gzO3gmEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N2La1Xma; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ojE4P0FB; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 216e248a92a111f0b33aeb1e7f16c2b6-20250916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ekcCKJ4KkF/cGbyE35L7zr4FMJVhQMvVZf4VAnnGgEg=;
	b=N2La1Xma9A/30HSVrtwRcYl3DmvAeDLoP6+RZTrcPC7Q/DXyyKQD19Hg8p91QfBu8+6D6+ZQm3pyC+IldbWTMWnyzQwmiHSLk2U21NX/8ISWcH1O5mALYVPKvfErFCZ5FmGC124AXPBIENXb0XYrAY3dEULMB3kaHUcFoNCg9rQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:3b5fda5b-876a-439c-97e6-ded9b582f0e6,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:dd0d976c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 216e248a92a111f0b33aeb1e7f16c2b6-20250916
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1803398672; Tue, 16 Sep 2025 10:01:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 16 Sep 2025 10:01:57 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 16 Sep 2025 10:01:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UE3eGOQaMdbzC0Hr+hKmSmy58Hy21pePFPG6uQcyXTvHKRlhy4nMBrSidpq86hLI0kstrBdU+JoyWndqsxC60RTYtaAz7jHCBiAl0Ow9NkfUJoRto+IzrnwJ/khoyJiH3eTPKCarP/B+nmpMsWqEXRRKWvjErenzbCHt2tgwNAjbPzp7XXREQdh3CwBROQ60nGlTW+1elWyWnIBoFtCdGdhdqpu6Z1Wsexor6TSLJ9qgO42HlcKdTF1T8BOlBexffRVb3ndUNLZupGLKGqbCFEBm8VXKUJHCAXh0+WQFgd14UXycpHaDm7ZZ6wbeweNfatNIDWEUKOTUjYjV4rqChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekcCKJ4KkF/cGbyE35L7zr4FMJVhQMvVZf4VAnnGgEg=;
 b=I8fW6lI00+IXeLvO3W//+20Nf3DzR0mQnJm1exdU1b7RAyYqGwwyPuCEDat5AXadgl4yjeRRLid5LDJGildj3bBhfrHx205bfusv13gSba/nMxpzyfAcg6Vn0H4sxwcI9944PfXgcfsMKdcW7uUVGuksUh4PvEgXCa0mjQHJ2GLsgvyFytxkgtA9HH4RWXXPpBvfF/mS1zZ01JqjfQqitAcUKMIqaEzxTmv+s42F/Xicy3Ft6Hn2wb9l1Gym1d4tI0t42Xy4LfRj9mkyzjmicfDWEJyaGItN0abfT/6lxsUDkMFzqFTR7cG4zee2Ii8efCQ2rGZKgEgJjsnQk8ixAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekcCKJ4KkF/cGbyE35L7zr4FMJVhQMvVZf4VAnnGgEg=;
 b=ojE4P0FB3bNaEmK4AJtq41/8CM8w+Se5RgevuB61ff69b9vXcrm/J2DHpY/pi8tonao/ngKmGR1q/NKgi8e4n2Zp7pcSkD4fy1BITRuzhgviKLRqpVZ9eOQtuMKpw4bKnl+0FOYA839uYVxtlf7Z5bLCJ9FFIQDv757qhrqdICI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB8545.apcprd03.prod.outlook.com (2603:1096:820:13e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 02:01:55 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 02:01:55 +0000
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
Subject: Re: [PATCH v4 06/19] soc: mediatek: Add runtime PM and top clocks and
 async controls for MMSYS
Thread-Topic: [PATCH v4 06/19] soc: mediatek: Add runtime PM and top clocks
 and async controls for MMSYS
Thread-Index: AQHcF/M+3AnIlAAMBEqsXMRYxgdqwbSVK9kA
Date: Tue, 16 Sep 2025 02:01:55 +0000
Message-ID: <3c59833569ca93ec6d65c0145f1054c5f889aeab.camel@mediatek.com>
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
	 <20250828080855.3502514-7-paul-pl.chen@mediatek.com>
In-Reply-To: <20250828080855.3502514-7-paul-pl.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB8545:EE_
x-ms-office365-filtering-correlation-id: f28eab54-3f9e-445e-52ab-08ddf4c5031a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|42112799006|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cjhkK1FVbC9hYXBMZkFlalViREFLUU12MjVnVEtSd1AxeHYycjZ3K2RRZ210?=
 =?utf-8?B?WWtRd2g5U0N2d21JYm5oVW0xOWUySk9QYnA5enBqTERCckFuamRtQkdIY1By?=
 =?utf-8?B?VVlWODZLT3pCWDA5M0Y0MXVRYlVnMUVPMmVrNGdDbmtQa1ZqZDBrZ2grRlh4?=
 =?utf-8?B?VHlJcVNOWXFteTN1UER6M0o1QjZheisrekJQYVdGVE5aU1Z6RXF5ZE11Rito?=
 =?utf-8?B?MUFtenF0NHFQeXgxZjNIU2ZSQTZCSWRCUVBSb213T0JMYmNnTmR3RjB2MEJT?=
 =?utf-8?B?SHd1M2g0TlJIVlVUeTJobE1VbFVuMkd2T28walI2NmJYYUUrUnNtVzhCWDAr?=
 =?utf-8?B?OVo0MlphNm50WjR5U2FtZG5LdXVqTEVoUjdvVEU3QmE3bHNMMU5ocmRrTFJS?=
 =?utf-8?B?bHhLRDhYRG45MlRwOUF0bHQrNzhnc3hBYmQ0NU1sQlRvczhBblFETUVYSS9W?=
 =?utf-8?B?RUJ2WW9pUS9aVXFkd0hWZHNCMHdQNmFQcnovdHdTeFZ6U3FOV3NvZW04dFFv?=
 =?utf-8?B?c1haWGxhL20vUnNBVTB0YkxOVUhXTUpweFJpZGk1L0RqNHpFakFaQ05UckZH?=
 =?utf-8?B?NGtUdmYrdGdsYkFEemNhcVZGZ2JZOUZtQW5jRzQ5d01DNHEvOVl2eXlqMDV1?=
 =?utf-8?B?WXVRWDZHcmJ6SmhmanRqa3RFUCtSWC91VU9DRm5xNUJiTmtjcjEzQkNjYTRz?=
 =?utf-8?B?Uk5Xd2pXMEJRb08vMmkyZm5hWE1IdXZWVDl0NDd5Z0FRUTcxZnVCcFZjWFZz?=
 =?utf-8?B?SXFQUndyaVVtY0RvS3E0enlDMWNtOHpKY25xM1ZhMU9TejZGOTRid1VMNFFt?=
 =?utf-8?B?M01pUjYyTWV1Q3J3L2NQRVMwTm1vRFhvSVBCYnRZOFRncGJmOWxTSUo1VE02?=
 =?utf-8?B?TDVSREhZd1ZzSjVacldEclNkM3pmTElGNnBhSEZWWUJaTWg4MjUweVQ0WVpl?=
 =?utf-8?B?ZlZETFFtdGdBZS9idTRuOG8zY0dIcStRZnNCc2tpQzdzaDBwMWtWRjZpNjNI?=
 =?utf-8?B?VC9KT21RSTc3Zmpoa0tTYXl1cTlXbjR1a0MvdmtsV0gzc25OYWYxUGFyczk3?=
 =?utf-8?B?WU1NU1dxN0F0c0dpOHZtRDloZ2hiSWxCUS9vSzlUaXNBdmNodUQwd3RHSE9p?=
 =?utf-8?B?akZRK2dIZWdpeTN0ZVo5TWY1MEhYc0tNZndSTm9oZVJJMXE2bzNUOTk0S3hV?=
 =?utf-8?B?REd2UFRqWVRSa0FRS1F5aWU0NW9NMUViZ21ZL2V6Y0E3aVhTeEJQRmdCYWZx?=
 =?utf-8?B?V1Q1TDA5dXhTQURURU16cXZBdFFPMWZrRWJWNGxnWXNBNXBLbGdvc2RibC8r?=
 =?utf-8?B?M244K3hRekZ4Q2dhc2RkUm1rWjZDSzRuY05tanVKdXd0TTVYK3gvVEt0TlhN?=
 =?utf-8?B?N3BoTy9PTDdyT3Juc1crU1NVVEFMRFJRdktieXhqUnZybmU1dDR0UFFzS005?=
 =?utf-8?B?WjArd2kwbWtOT0N3emVNL3J2cEg2WmlUNWpETzNPOFd6djdQdWxkV3VVUEsv?=
 =?utf-8?B?aEtVY2daZG01OHE1Q3drUC9xMWZ6WE8zRXI0THlOOXZ3MCtaaTNnUy84d29y?=
 =?utf-8?B?ci9FTklsVDNuenV3UE9WdFI2S2hWT2ZLeGxGS3ZYZHJ6emJzVnc4SFZVQzI0?=
 =?utf-8?B?RktsRXpYSG83U3MweEl3alp2Q25rUWM0QUpOOEdlZTVpZzRzTFcrQUlEOG9R?=
 =?utf-8?B?eHE1aXVTRzdJQ1hXVm1leWZlWGo0NjJ6QTVObWpneDV3OGVhRHQ1UmJMUWw1?=
 =?utf-8?B?Y0p3NEJOdFZKTVFzWklYam03TU5FTjhZZ0k2bWpST2x1S29Qaml6cWhyLzNG?=
 =?utf-8?B?aEdVaWRyUXlIMGtzcjgvQVl3Zy9yWXZ4Nm12NGpndEpndFQ5aTNPWVVYbDhS?=
 =?utf-8?B?Q0ZvTGJ2U2V1dlhNV1d3VUh3bjBGU2dhZDhhWGcvNzhGdnl1Z2VzeERSQ2RX?=
 =?utf-8?B?b0VsQ3BERHdYT0xtVmF3ZURkazFOUFZ2U0cwaVdFNVV4UU00YXVoWjloelF0?=
 =?utf-8?Q?643qBqL/KN+/vRBVVuc3chdz3j3jBM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(42112799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUhjV2E0WU9ndXFBQlprRnBlTTk0Q2kzbmw1VC9yQVBYMnZ1NldhZjZyeGpS?=
 =?utf-8?B?eWc5ZFNvcXFVYUVtTXBJNzc1c1Z6YmQ5WWVuTmVoOHk3SmVFR3BMOWJrWUla?=
 =?utf-8?B?aFUzdEpkRUlWMllRems1Y0xnc1owOVpmVXJGMzRxQzB6cGJhZG1OUDBpNlFI?=
 =?utf-8?B?cUwxWU8xZmtLaFBNV3VRZzJ4VkFEeG1VTG8wTDVHclM1NHo1UW4za2tIOXBG?=
 =?utf-8?B?SHdqMllQVnM3RUtRdG1qcWtCNXFaampWM1A0YmJQckNzc2dqTGNtalRDT0xi?=
 =?utf-8?B?dU5pcnZjVTZnUWpBUExqdVZFamVwdlZnNW5FWDRSMS9MSmE1MmNOSTE4andx?=
 =?utf-8?B?di9YeWJOVkhnbUt6dE4ydmFhNnc1M0NxblcyNFRIcHJoZDhYRnFMYlNBd3V5?=
 =?utf-8?B?SGx6UGJvVTYxaFhIVzZUZnZJZEY0WEpQV0NpN3Nlc25IbkV0QzBUdzJnbW8w?=
 =?utf-8?B?NVhKdkczV2lKRzdjOTVaRFhnWU9OeHN5LzBxbEpyQzYvQzIrVDN0ZlM3UVNw?=
 =?utf-8?B?eDIzTlFZQjRLZzhsR1JjSTZYeDErZ3JPQW9OQnkvcTRYLzZmaFdORyswT09l?=
 =?utf-8?B?Y0grbUdDM01xSk5PaVduNHd0RngybDBzaWI5WHVWRFN5RUgwQzQ4cnNELzhC?=
 =?utf-8?B?WkxFcURKLzR2dU16V01YK0dWaGttRWdtNUFDVHUxVFM3Z2lKLzNpRFNIZHNC?=
 =?utf-8?B?WWZ6RkdXV2dFY2VkUmVQSU9oL0RtQ1piT0FRMGx5WHZwYytkMlIxcDluN1NH?=
 =?utf-8?B?WDdyaWgzcEtPN2s4ajR6Z0cvVDJCekUrcjhuZnVNei9Ic1BJTjN1eENjcUNo?=
 =?utf-8?B?dHg2c0RYRnhzK29DQVB3M3pzN1R2R0tYY1hWMFNYeUI0dk1CTnBFb3VuSU8x?=
 =?utf-8?B?YzRJWDdGWXpMOWU3WnlSanZMb3FleWdvNmZMVUF3c3I3eHptYUpOaUlHbm45?=
 =?utf-8?B?emdSU3k1L3lvLy9qeVFtT21KR3Q5b1Y1U3VOb3hwSTArQWdkYU5TaCtjNVZF?=
 =?utf-8?B?a29WWjU3MUVUc1BKcUZaMGJIWVpSTmpPK3JNQkJ2UmczWjN0S3daWThGZXVL?=
 =?utf-8?B?bWpPMUNuM3FPeVZxUTk1amZMZHJvUEF6Szl3TmMwTmppMmU0emJFU0lVTHJT?=
 =?utf-8?B?YnhZdDVZcWFIQWM2RjZZenpiQW9hN0NJaThLako1b3MxZzV1T1RPN1R3c1Jh?=
 =?utf-8?B?ekNxK25vWXBZQlFNeFNGNFRuUk5wNmtudi9YbEhjSkEyRWVocGxyQTVoYWxw?=
 =?utf-8?B?aTUvUHBIcDluajAwVlJKYTNqOTk5VTdBOUxjU1NIa3B4UUhzbkFJYjQwMTcr?=
 =?utf-8?B?UHdyMVI2R1ZZK1BrbTlEdTNsY3p3WEZ6U01VbnhFRjV5MEl4dGpNcGdDeXRI?=
 =?utf-8?B?MUN0YTU2ckY0cmN6ek5MSXhBVmljYk5tUENody9CbDBQQlNDNEtwNUR4VlMv?=
 =?utf-8?B?SWNkeDAxQnQ4T0hjL2Z5clU2b09sQyt6VXFSb01HZmdMa21GandBQWZxU0hU?=
 =?utf-8?B?TmpYM3lMNnVrWG40am5rK3Rhdyt6K1F1WXR3R2hkYUtHL2swcEozd0t1M3pQ?=
 =?utf-8?B?VVBuN0hDSnVRaG9DREJUMWRza2R6cDVzY054NzN3Z2RiZThwQW9nTTFVZWVQ?=
 =?utf-8?B?MGlwZFpMSHhyWUVpbXZFeUUrMXpERWpuMDlvYkREQmNrYnZGV0RQVTh3MHNM?=
 =?utf-8?B?dUtZbHdQcndnSmFqK2dRVVBucExMMG9BZTQ0eWl5dUphOUNlVmxpQ3d0cUF6?=
 =?utf-8?B?QUlGMFVZZlordVVGY1VMYlFPK2RxTVF0ZlNFbW5lU3l4MStXNVJRUEtKVGNo?=
 =?utf-8?B?OFlRTEtOdE9hcWh1ajZvMkhCLzRnditFbVYwdjF2Wko3YjhBN24wN3dkb3lG?=
 =?utf-8?B?UVdzdTNEWHhVYXlTcjlkY1V1VVRpOGl6cXo0R094WDVPaW9TRWlyd3JXc0Fv?=
 =?utf-8?B?THFkWjdJQnp6MmwzKzNzd3J6Qit1Z2pPVHhRbnlmazloTTY4MGNHdzAvRDRr?=
 =?utf-8?B?S0UrUUlQQlYvdDIzUjVOQml3cmk3NmYvWkdycmZxaUZXdWRZUnE5eUNFSm1V?=
 =?utf-8?B?ekxycERYbjl2bE1lUDBWRWhXcTVGNXoxcndQYUVma3hpalBwTlhLR2NXUEFJ?=
 =?utf-8?Q?FAZXaNbDqWOfx6dHW441YlXWy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E030E5A8E706D34B845C3D9FD7DFE2EF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28eab54-3f9e-445e-52ab-08ddf4c5031a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 02:01:55.3905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9WVNcWGycHKbMuJQHQ1M5V5y2SUIm1rCBc8GDp2dTZiCUuW8PPco23tZl8FCxhFWelyUd59DfF/pkQOAuuddg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8545

T24gVGh1LCAyMDI1LTA4LTI4IGF0IDE2OjA3ICswODAwLCBQYXVsIENoZW4gd3JvdGU6DQo+IEZy
b206IE5hbmN5IExpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gDQo+IC0gQWRkIGluaXRp
YWxpemF0aW9uIG9mIHRvcCBjbG9ja3MgYW5kIGFzeW5jIGNsb2NrcyBmb3IgZWFjaCBNTVNZUy4N
Cj4gLSBBZGQgUE0gcnVudGltZSBjb250cm9sIGFuZCBuZXcgZnVuY3Rpb25zIHRvIG1hbmFnZSB0
aGVzZSBjbG9ja3MuDQo+IC0gQWRkIGZ1bmN0aW9ucyB0byBzZXQgdGhlc2UgY2xvY2tzIGFjY29y
ZGluZyB0byB0aGUgZGVmYXVsdA0KPiAgIGNvbmZpZ3VyYXRpb24gb2YgdGhlIGNvcnJlc3BvbmRp
bmcgTU1TWVMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOYW5jeSBMaW4gPG5hbmN5LmxpbkBtZWRp
YXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBhdWwtcGwgQ2hlbiA8cGF1bC1wbC5jaGVuQG1l
ZGlhdGVrLmNvbT4NCj4gLS0tDQoNCltzbmlwXQ0KDQo+ICB2b2lkIG10a19tbXN5c19kZHBfY29u
bmVjdChzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAJCQkgICBlbnVtIG10a19kZHBfY29tcF9pZCBj
dXIsDQo+ICAJCQkgICBlbnVtIG10a19kZHBfY29tcF9pZCBuZXh0KQ0KPiBAQCAtMzkwLDcgKzQ5
MSw3IEBAIHN0YXRpYyBpbnQgbXRrX21tc3lzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqY2xrczsNCj4gIAlzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpkcm07DQo+ICAJc3RydWN0IG10a19tbXN5cyAqbW1zeXM7DQo+IC0JaW50
IHJldDsNCj4gKwlpbnQgcmV0LCBpOw0KPiAgDQo+ICAJbW1zeXMgPSBkZXZtX2t6YWxsb2MoZGV2
LCBzaXplb2YoKm1tc3lzKSwgR0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCFtbXN5cykNCj4gQEAgLTQz
Miw2ICs1MzMsNDkgQEAgc3RhdGljIGludCBtdGtfbW1zeXNfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gIAkJcmV0dXJuIFBUUl9FUlIoY2xrcyk7DQo+ICAJbW1zeXMtPmNs
a3NfcGRldiA9IGNsa3M7DQo+ICANCj4gKwlpZiAobW1zeXMtPmRhdGEtPm51bV90b3BfY2xrKSB7
DQo+ICsJCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZTsNCj4gKw0KPiArCQlub2RlID0gb2ZfZ2V0
X2NoaWxkX2J5X25hbWUoZGV2LT5vZl9ub2RlLCAidG9wIik7DQoNCllvdSBzaG91bGQgZGVmaW5l
IHRoaXMgaW4gYmluZGluZyBkb2N1bWVudC4NCg0KPiArCQlpZiAoIW5vZGUpIHsNCj4gKwkJCWRl
dl9lcnIoJnBkZXYtPmRldiwgIkNvdWxkbid0IGZpbmQgdG9wIG5vZGVcbiIpOw0KPiArCQkJcmV0
dXJuIC1FSU5WQUw7DQo+ICsJCX0NCj4gKw0KPiArCQltbXN5cy0+dG9wX2NsayA9IGRldm1fa21h
bGxvY19hcnJheShkZXYsIG1tc3lzLT5kYXRhLT5udW1fdG9wX2NsaywNCj4gKwkJCQkJCSAgICBz
aXplb2YoKm1tc3lzLT50b3BfY2xrKSwgR0ZQX0tFUk5FTCk7DQo+ICsJCWlmICghbW1zeXMtPnRv
cF9jbGspDQo+ICsJCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCQlmb3IgKGkgPSAwOyBpIDwg
bW1zeXMtPmRhdGEtPm51bV90b3BfY2xrOyBpKyspIHsNCj4gKwkJCW1tc3lzLT50b3BfY2xrW2ld
ID0gb2ZfY2xrX2dldChub2RlLCBpKTsNCj4gKwkJCWlmIChJU19FUlIobW1zeXMtPnRvcF9jbGtb
aV0pKQ0KPiArCQkJCXJldHVybiBQVFJfRVJSKG1tc3lzLT50b3BfY2xrW2ldKTsNCj4gKwkJfQ0K
PiArCX0NCj4gKw0KPiArCWlmIChtbXN5cy0+ZGF0YS0+bnVtX2FzeW5jX2luZm8pIHsNCj4gKwkJ
c3RydWN0IGRldmljZV9ub2RlICpub2RlOw0KPiArDQo+ICsJCW5vZGUgPSBvZl9nZXRfY2hpbGRf
YnlfbmFtZShkZXYtPm9mX25vZGUsICJhc3luYyIpOw0KDQpZb3Ugc2hvdWxkIGRlZmluZSB0aGlz
IGluIGJpbmRpbmcgZG9jdW1lbnQuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJCWlmICghbm9kZSkg
ew0KPiArCQkJZGV2X2VycigmcGRldi0+ZGV2LCAiQ291bGRuJ3QgZmluZCBhc3luYyBub2RlXG4i
KTsNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArCQl9DQo+ICsNCj4gKwkJbW1zeXMtPmFzeW5j
X2NsayA9IGRldm1fa21hbGxvY19hcnJheShkZXYsIG1tc3lzLT5kYXRhLT5udW1fYXN5bmNfaW5m
bywNCj4gKwkJCQkJCSAgICAgIHNpemVvZigqbW1zeXMtPmFzeW5jX2NsayksIEdGUF9LRVJORUwp
Ow0KPiArCQlpZiAoIW1tc3lzLT5hc3luY19jbGspDQo+ICsJCQlyZXR1cm4gLUVOT01FTTsNCj4g
KwkJbW1zeXMtPm51bV9hc3luY19jbGsgPSBtbXN5cy0+ZGF0YS0+bnVtX2FzeW5jX2luZm87DQo+
ICsNCj4gKwkJZm9yIChpID0gMDsgaSA8IG1tc3lzLT5udW1fYXN5bmNfY2xrOyBpKyspIHsNCj4g
KwkJCW1tc3lzLT5hc3luY19jbGtbaV0gPSBvZl9jbGtfZ2V0KG5vZGUsIGkpOw0KPiArCQkJaWYg
KElTX0VSUihtbXN5cy0+YXN5bmNfY2xrW2ldKSkNCj4gKwkJCQlyZXR1cm4gUFRSX0VSUihtbXN5
cy0+YXN5bmNfY2xrW2ldKTsNCj4gKwkJfQ0KPiArCX0NCj4gKw0KPiAgCWlmIChtbXN5cy0+ZGF0
YS0+aXNfdnBwc3lzKQ0KPiAgCQlnb3RvIG91dF9wcm9iZV9kb25lOw0KPiAgDQo+IEBAIC00NDMs
NiArNTg3LDkgQEAgc3RhdGljIGludCBtdGtfbW1zeXNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gIAl9DQo+ICAJbW1zeXMtPmRybV9wZGV2ID0gZHJtOw0KPiAgDQo+ICsJ
aWYgKG9mX3Byb3BlcnR5X3ByZXNlbnQoZGV2LT5vZl9ub2RlLCAicG93ZXItZG9tYWlucyIpKQ0K
PiArCQlwbV9ydW50aW1lX2VuYWJsZShkZXYpOw0KPiArDQo+ICBvdXRfcHJvYmVfZG9uZToNCj4g
IAlyZXR1cm4gMDsNCj4gIH0NCj4gDQoNCg==

