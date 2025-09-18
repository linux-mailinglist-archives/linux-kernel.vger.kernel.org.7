Return-Path: <linux-kernel+bounces-822185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D368B833E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288563A7474
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0E12D9EDD;
	Thu, 18 Sep 2025 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qT1yGDls";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vd+Bbj5W"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79EE63B9;
	Thu, 18 Sep 2025 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178902; cv=fail; b=ST08DpEfJtkRawmyicGQYmm312RxQvLKuwBv039u0QXSJ7x1dP/PTVkriLzZDkBrwdSrzbbJEnmULfzT5pJ34TKvAZOQIrmykmGQLbelnggtiwzCG9rGDVB+tbqg1+ZTPcNRbT2xridwpzogMUkmtopNx64PG5JcfgE7JWtzigc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178902; c=relaxed/simple;
	bh=j+y/zXeptQ3RIHeFYUDszd5nCepuquADVPcjGqx33JM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ShF/y2XMlr3Sgblr4XGJE6RXbbUHT1gjalYqT44nrMwcZfpxCNpJh2CQkjs4WA8cGWMjq62JFJsLCun+N79G9W8vb2EbzdLaX5g1Lumy1w7giRCLr8e3Pz3OF1MrGU0rYy3YsW1ZFSSq5p2M2ElJPu5NL1IxBR1anaL1aQ0XPp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qT1yGDls; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=vd+Bbj5W; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 50031932945d11f08d9e1119e76e3a28-20250918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=j+y/zXeptQ3RIHeFYUDszd5nCepuquADVPcjGqx33JM=;
	b=qT1yGDlsUWXiu2gnaUa6HnTk9sF37h7JvhFY2tquwGrviv4NQKrVXstF32IZRn2/beszxx0oG4376o9ca/DLsuKLzXEKyD13bjgKUk255ruVK4aK2XE0ca1FJ1o1V9V93QrjnJdQwfNxfxN+GbNgZGItT8xpuDI+NnwxlG5PD6Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:a12ad643-8d77-4e14-90b2-c94ba7b25cc3,IP:0,UR
	L:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:12
X-CID-META: VersionHash:1ca6b93,CLOUDID:2aa3eb84-5317-4626-9d82-238d715c253f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836,TC:-5,Co
	ntent:0|15|50,EDM:-3,IP:nil,URL:99|11|97|83|106|80|1,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 50031932945d11f08d9e1119e76e3a28-20250918
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1543868626; Thu, 18 Sep 2025 15:01:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 18 Sep 2025 15:01:32 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 18 Sep 2025 15:01:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgZmqhH8ZUbZRLUwYmlNUD1LjW9UgcltIu+UysaoRVnqP/UAJGJ/1Qy1ItMCBh4mdLl48RMl/CL8fA8PmsuyKfheJJYjEXX6P9SjmrFmn3yNeKtgkOiFVJniZtyoVJ8uLH6Ru97zR46fdZ4Af8U/vEeLlBr/L/P7h8K8eslvDjC3UoN41ZKKExeB8XgfqqhUqRoyoxcyDyl5NJXXzIGKpmEuDsUMQXDLCLLbxA2iFhq3Y5+nJM6ALuXJ3PthMfz1886N7rkZpWJQU8QZ3wB9vjVR4p6r4ZPjwjdQ3yS+jsMUn5jualuuRAiqIqFrWk+Xg3A1TTb1JSIw/oIvx7N7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+y/zXeptQ3RIHeFYUDszd5nCepuquADVPcjGqx33JM=;
 b=Ey6ry2poGJHHy88qeCqfYVWjsW6W8JMyyEK+m8lQZKdA018eZGqA/pW5GsUan3O63bF8Nl2uJZLWtr7gL8CMIA7z/tuOVRsuiPHdTE+xdKfl5VdVhiHdaAs3keTc7zNmnxTv+jwTCfBJ0HCUiSL/W4WmAuBRXjsSzec4h1ZhPgC7qE9ljYsoV7wHUZ1OAyD6z/RkrPLjRiwkR6w6YzYyawozgXXWqaJbwUobDYJIKXflu63mS2raIgcD5yzK4E6LVggBx69j2U3zGuqgEvdVqewYb3w3kon72qYDQF3wMNWbwdncqskR5Zk6JOkXFE+4Hp00qbmEZHvO05M2nMiA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+y/zXeptQ3RIHeFYUDszd5nCepuquADVPcjGqx33JM=;
 b=vd+Bbj5WkSBO46tsPxela++LlG5zMiuw2LQw4CX9iGrnG3eyM3c+MjE6dPS+qksak52gBRvAh34bkDUhllkPs0s4kI4RYn3rB6a8vTLg8MLwzU2VpNwsuTfYmv2AnPYvdvX4gYxkxP+Zsl/FmUKboSqz45Q4XFfK7rsao67f+Z4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7583.apcprd03.prod.outlook.com (2603:1096:400:410::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 07:01:28 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:01:28 +0000
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
Subject: Re: [PATCH v4 03/19] dt-bindings: display: mediatek: add EXDMA yaml
 for MT8196
Thread-Topic: [PATCH v4 03/19] dt-bindings: display: mediatek: add EXDMA yaml
 for MT8196
Thread-Index: AQHcF/M+mbrAlfbD30W7FCMINL+5LrSYpDSA
Date: Thu, 18 Sep 2025 07:01:27 +0000
Message-ID: <89356c625715c984fcdca4e275df1a8747866909.camel@mediatek.com>
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
	 <20250828080855.3502514-4-paul-pl.chen@mediatek.com>
In-Reply-To: <20250828080855.3502514-4-paul-pl.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7583:EE_
x-ms-office365-filtering-correlation-id: 0eac8709-4b15-4779-157e-08ddf681306f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|42112799006|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UEoyWU9xRUxNREVWVlB4d3lQaG5USFllQ1VOVFBvT2Q5eFMzWTRuN3pkT2lX?=
 =?utf-8?B?Zm9tK1lkMFlJTXIxYkpzRmhPK041T0dqZytwdkFEczROOEx5RFhNRlIweFda?=
 =?utf-8?B?d2pMZVdmR2FiNHd3dVJyV2xrbHFrNTQ2TnRQdkxwejFnWjIxZVUyZi93Q1FI?=
 =?utf-8?B?OUk0anNuZG5ERFJ3UWd1WlJuZFU4T0JPQzgyYVBBaWZWZFRoakk4Q3Q4ZHdE?=
 =?utf-8?B?SC9vZjdmbVFsOENhWGI0N2ROd1JmTFNOOEZseFV3VERma0FKNTFjR1NmT2Nx?=
 =?utf-8?B?NEpucEl4TFE5Tk5lWW9GeW1hWFRqOG5zcnY3RmJqR245VFJrU1ZkWXdEUDdS?=
 =?utf-8?B?SnFTTVNITzBlMm5QUDc4aE9YYkdKU1QvRDlQc1hiUTlKR1p6dmdLQ2Yvangy?=
 =?utf-8?B?YTJocEJIYjg5b0lnR1pXWXltMzFFU2pKR3lSa2pUdDBOR1FsYzg2MGlYUEJm?=
 =?utf-8?B?UGUzWGx2Ujk2TjJhZG1Xb09vWDA1Zm9uOE1lc1ZZRmdKVzVyRGRQN3Q0dGdW?=
 =?utf-8?B?blc1WTd5bkx4MFo0emxjVk9hczRqODBBUFVHYnJSRWFoanpCYjMreXdrdXlP?=
 =?utf-8?B?R29TK0JKSjBhSTFuMTd5QmtEeGNpTnUrWnRWNG8rQVpqNTlxQTBtL08yNS9T?=
 =?utf-8?B?WVdXU20xYUkxUmlrb2drNTlqcHdoRDhvcWpXM0dCNDJNT1llWmxnTXdXUUVP?=
 =?utf-8?B?Q3pmV3d6ZnJKd1I2K1YzRC9MdEk3MDNaTFVmZVg1QmZVdVpBVFcreDZDUTBU?=
 =?utf-8?B?Y2EzYXNJZ016NWpDLzFsek5OTy9Vc1pEaktuS0Rjei9ucmhLNHBQRkx3Y3l1?=
 =?utf-8?B?bVlDeG9SQWhBeHZzZEoxcmhCY1VrWE0zUDM0S2RCRUhjNFplMlJJNU91Z1hS?=
 =?utf-8?B?elpDbTdRQTErWmxMai9lS0Y3WlVRTzYzNVFIc0ZUYmg3QWNHUXM3Vit1a0p1?=
 =?utf-8?B?MUUxVU5QQnMyZnIvSmhpcStuVXo5bWg3TGEyZGY5d05YS1pTZTJ0Um8xemh3?=
 =?utf-8?B?TDBNckNZZjNscHFzSXNIUUJuYUxBUTZsdVJzdjZ1ZVZ3bEJsQndiRkFVTllQ?=
 =?utf-8?B?UkwyejhYbnJ1WVFBQS9IVTBXV01Zbm5FM0s1NW9OeEVXUk12ZEJoQ3NFR2w3?=
 =?utf-8?B?L013NmUrdW14N3g1K3FoM2thbEdYalZXcGxhaU9tb0xTWWdHT2swdVY0d29q?=
 =?utf-8?B?djRaQXhTYjA0VXhHSkJQd2xqYjhmVWxraGRPVjN0THBpMThheDA5NGh2b0Y3?=
 =?utf-8?B?MWtsaGdaSkdBNU9rbjIyNVdoYnNzRmpnbGh5YVlQQTA3ZHN3VWllNWkyYVln?=
 =?utf-8?B?SEZyTFF5am1ISDdFWGZjVjlTcjlMaFYvc1d5TUh6eTdRdzhBdFY4eTlOOEFQ?=
 =?utf-8?B?VjBLUkpUVklFaWdGQUUrZ2kwWjBndmdEcHpNZWlnUGNUVWtVUEhqRUpwalBF?=
 =?utf-8?B?OWI0ZDdFVE1YcWtZUmJKTUd4QTRnVXBURDdwdHNCa1VHKzZNWVVMSzc0UXhu?=
 =?utf-8?B?eDhUS0VjSFZLTUg4MmVYd3VZZVhiNmc2THJReG9VRHI5SmpqN211TGplUC9B?=
 =?utf-8?B?elVmaVFBc2tPSHdwcC9CZ2xTOEZJVkdOM0FSYXRWZHNwb3RmUUpka3VMMWt2?=
 =?utf-8?B?VHAyeit2aU1hUm5rSDZ6WjRlUnJXR0l3OG1GcFJiODRBU3A2U1FSRGJHc1NS?=
 =?utf-8?B?bXc3dmNxdXFpVVhxZjdidnIxUGIzdEhNN1AxTjVIUW5DWFgwa2pFamZCbVpO?=
 =?utf-8?B?MzZKb0h1Qmgzbi9ScGk1dDEvSGNuVkpNMnJsUDcrMnFTZmJzRmZZS01MdHVy?=
 =?utf-8?B?b1dBcXIySXZjZWIvWWNXTC9GbzFDaTBvU2FVY2JLUjBjU3Q3N1psOWdFMGNi?=
 =?utf-8?B?SGVJSWVNc1g1aFJrRGh1V2lSbm5nUjVPL2FzZFNLZkc3SFkvRWVNRzlDYjcy?=
 =?utf-8?Q?ah7Zm9fwHVg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(42112799006)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0VjUGRsekltN3poL0drbkVmc3Q2bUFGcUxTeHl0WkJocEJhaHRNQ09LTFYx?=
 =?utf-8?B?N2NvdDMvMUFOaVdkOWg3MjdTL0RsWWUzTmlxUE1qWFc2aWJXU0VFSlhKaFJy?=
 =?utf-8?B?WUw4c0gzdGFYMnozZ3d1b2JBKysxcEdJM3RrUmVoTGFrZ20rYTB4dnJQOEN2?=
 =?utf-8?B?YWxRb1dqS28xL2xrTGlBNS9SbVVndTJqWEIrUnhockJJZlQyRVlOZDNOM1V6?=
 =?utf-8?B?VFRtTFNxc0l4NEg2eDQ0QVVtMHZ0aXhCUkVIeWR2Sy94SnVNOTN5bEtieFNO?=
 =?utf-8?B?bzRUdDVoRUxCMmdZbGk1S1p3UDc1YmkrUnJWNnZIQnkrZk5TVmx4azVVdEpv?=
 =?utf-8?B?djRSbW5YNEVNUEJ2cHRsMGhEVjZhNUFYbk5ITjAvRXNuLzNPdk1KUDRxVmth?=
 =?utf-8?B?RTZqVVh3dWhwVHJKZ05xblR1WWZpYjcvOVZUSlUvdE5sYVF5aFBaNTRabEtG?=
 =?utf-8?B?WUU0bjNvL29PSWpGMVQrbWEzUzYrVm05alhNMVAxS0dOMElGMWthNGVmQUxV?=
 =?utf-8?B?bit0c0VhZENkWG1abk9yVm8zeFN5REJyajlxSGhCWHBIZDY5KzZPWW11KzA5?=
 =?utf-8?B?SlJaYVhDR2w2S1pCUGhtVU01SGJKV0hOR2JXdjlyM1lMSUdBZkVGSHZySUIv?=
 =?utf-8?B?VGF4aS9MNVFWcit2Qm9wK0JXUld6eE5BZThBYlRNWTh3cE5SbkpXUEhNcE8y?=
 =?utf-8?B?YnIwZDNtWVZwVktoTjQ1OTdmWVZwQm8vOU5Rc3VCbk01U3ZQbkRqUFJiT3Rv?=
 =?utf-8?B?N2FwUTRhNG15SDhlaFR5QzY5cVhHVnIybDJJdnQwZTNWSnBFMlhnaWowUFVt?=
 =?utf-8?B?Q3hOZEZBMVlwUmR3SHVsaSt5cjRDbDhTdG8yZnBadStVNktHUTV4ZFg0K0xu?=
 =?utf-8?B?WGFyUW9CYlJjK0dZUmVxa003RUpnNm9HOFlIM014WHNYa3VyUTZiVW5HaW8v?=
 =?utf-8?B?cVhZbUZBTFRLNW5RVit2TG1DdnlWajJoT3ltYnhDZGRLUXhwNHlnQXEvbWZG?=
 =?utf-8?B?OUZyNTRlbnE2cUw4RWVvTS9DZFIzWXNESTNDVXBNVHVlUjdqZlNrVnBjdTdK?=
 =?utf-8?B?MWluWlBWVi9ZWFk1UlZQK0xaR08rbUpxNGhhczRYRGtMbFVNNnhGQ1lZWHlU?=
 =?utf-8?B?VlRSQWtodXVaaUgwcTBVL2JiLzZNZkFqWnk1YlJSOHU1VFIwc1k5RmJ5eWhL?=
 =?utf-8?B?NVgrYlhmSVhucGJwdmNZMUNYSGVRUzlQWDhlZ0xIcHZHUXNOK3NLSzl1VjVB?=
 =?utf-8?B?V051WkF3NGhvaC93WDhISWxSYVJ1em5sODNjdlIvbzJ6eFk3YlJTei9mTHdF?=
 =?utf-8?B?NVpvUkl1WndjUDRsN21KcVRnM3RmbHpzRjBlVFdyY1cyYkp0WG9rVHVjZWs4?=
 =?utf-8?B?eS9sY3hRYVcwSkhsVjc5cGhKZ3lETzRjUDhvQWRMZzR2Z1N1dzdWanY1aFBQ?=
 =?utf-8?B?N2tnT2x5ZVBRdnd1TEx1NzhmbEZ5L3I5ZHUwWWNmQ216MHZiS0pmNTNzdUda?=
 =?utf-8?B?cFBobW05Mm9aZEF6dm96bUE2bFl1dHh6aWRXakhkVVF3VEcveHpBVGc2TXNP?=
 =?utf-8?B?dzhhRU5aM25lMTRsTE96K0txU25wVEM5SHQ2QytCWjdiTzlCNXN6UkpiZ3Ez?=
 =?utf-8?B?aFRxTnpqUWV6OHZPdVBRSkVPeFQ5RnRYUTA4ZWtJTEhTeko0MVRHeldmbmw4?=
 =?utf-8?B?VGRRT2F6VTNnTElHT2huN2lLd3JvWTV1U1ZGNyszdk1FUVVOY1plTWZlRm9B?=
 =?utf-8?B?UFlCRXNyT29SeElkYTdwdzg0bGVqWjlJMkZzZ0QrY1lzS3FYUU1aandkaUJv?=
 =?utf-8?B?RG5ZVlZ3c1hPZWd6Y0xqYUViOUVFdFFKczVhR1VvZDdlL3RnMDZlRW1TcE5Z?=
 =?utf-8?B?NG13LzZHelRJTDRHU1dwbThjYXVYWCs1dFo4c2FHYUp5TzY3NHE1RFVOMmp2?=
 =?utf-8?B?NmpCVUt6amorb013RkMvVks4UW9YSmVxam5rVHpZYXlaaFBEUFAzWHhyTU42?=
 =?utf-8?B?VTZrVlhlRnNRWStkVDlDMzNXQng3Zlo3cTVoTFFhVVV4U1dtSE5Rb0F2OUE3?=
 =?utf-8?B?SkJKeG5hRCtvVmNuTVF4S0c0dHhpeTZHTDk4ZlB0WlppZnRlZFRtQTJmeS9I?=
 =?utf-8?Q?jT7AoWMmTKM/QWes5dF2O4G11?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D82833D5D29D748AFBA27DB78162746@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eac8709-4b15-4779-157e-08ddf681306f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 07:01:28.0028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e69v7qD2FtqP+xdI60T2Z75VwqyLMquizyxvYg8an4u6DUsrrSNHJuPlrz1ZiZ0hnkmgpXkKbaHwqk/+YXEV6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7583

SGksIFJvYiBhbmQgS3J6eXN6dG9mOg0KDQpPbiBUaHUsIDIwMjUtMDgtMjggYXQgMTY6MDYgKzA4
MDAsIFBhdWwgQ2hlbiB3cm90ZToNCj4gRnJvbTogUGF1bC1wbCBDaGVuIDxwYXVsLXBsLmNoZW5A
bWVkaWF0ZWsuY29tPg0KPiANCj4gQWRkIG1lZGlhdGVrLGV4ZG1hLnlhbWwgdG8gc3VwcG9ydCBF
WERNQSBmb3IgTVQ4MTk2Lg0KPiBUaGUgTWVkaWFUZWsgZGlzcGxheSBvdmVybGFwIGV4dGVuZGVk
IERNQSBlbmdpbmUsIG5hbWVseQ0KPiBPVkxfRVhETUEgb3IgRVhETUEsIHByaW1hcmlseSBmdW5j
dGlvbnMgYXMgYSBETUEgZW5naW5lDQo+IGZvciByZWFkaW5nIGRhdGEgZnJvbSBEUkFNIHdpdGgg
dmFyaW91cyBEUkFNIGZvb3RwcmludHMNCj4gYW5kIGRhdGEgZm9ybWF0cy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFBhdWwtcGwgQ2hlbiA8cGF1bC1wbC5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gLS0t
DQo+ICAuLi4vYmluZGluZ3MvZG1hL21lZGlhdGVrLGV4ZG1hLnlhbWwgICAgICAgICAgfCA2OCAr
KysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKQ0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
bWEvbWVkaWF0ZWssZXhkbWEueWFtbA0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvbWVkaWF0ZWssZXhkbWEueWFtbCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvbWVkaWF0ZWssZXhkbWEueWFtbA0KPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmVhYmYwY2ZjODM5ZQ0KPiAtLS0g
L2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEv
bWVkaWF0ZWssZXhkbWEueWFtbA0KPiBAQCAtMCwwICsxLDY4IEBADQo+ICsjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gKyVZQU1MIDEu
Mg0KPiArLS0tDQo+ICskaWQ6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2
aWNldHJlZS5vcmcvc2NoZW1hcy9kbWEvbWVkaWF0ZWssZXhkbWEueWFtbCpfXztJdyEhQ1RSTktB
OXdNZzBBUmJ3IW1qUUgycU5LaFhzbDQ3ZDN4ejJfUW1vN1dhZHE1LWtEMEdKYUFWamg3WFk4VzNO
Z0lfZERwQk5pbk1FN05WVzFQS2RPOUlFVXNPYk9UdWdqeXBxbzVqOCQgDQo+ICskc2NoZW1hOiBo
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2No
ZW1hcy9jb3JlLnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFtalFIMnFOS2hYc2w0N2QzeHoy
X1FtbzdXYWRxNS1rRDBHSmFBVmpoN1hZOFczTmdJX2REcEJOaW5NRTdOVlcxUEtkTzlJRVVzT2JP
VHVnajNoTU1QaFUkIA0KPiArDQo+ICt0aXRsZTogTWVkaWFUZWsgZGlzcGxheSBvdmVybGFwIGV4
dGVuZGVkIERNQSBlbmdpbmUNCj4gKw0KPiArbWFpbnRhaW5lcnM6DQo+ICsgIC0gQ2h1bi1LdWFu
ZyBIdSA8Y2h1bmt1YW5nLmh1QGtlcm5lbC5vcmc+DQo+ICsgIC0gUGhpbGlwcCBaYWJlbCA8cC56
YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gKw0KPiArZGVzY3JpcHRpb246DQo+ICsgIFRoZSBNZWRp
YVRlayBkaXNwbGF5IG92ZXJsYXAgZXh0ZW5kZWQgRE1BIGVuZ2luZSwgbmFtZWx5IE9WTF9FWERN
QSBvciBFWERNQSwNCj4gKyAgcHJpbWFyaWx5IGZ1bmN0aW9ucyBhcyBhIERNQSBlbmdpbmUgZm9y
IHJlYWRpbmcgZGF0YSBmcm9tIERSQU0gd2l0aCB2YXJpb3VzDQo+ICsgIERSQU0gZm9vdHByaW50
cyBhbmQgZGF0YSBmb3JtYXRzLiBGb3IgaW5wdXQgc291cmNlcyBpbiBjZXJ0YWluIGNvbG9yIGZv
cm1hdHMNCj4gKyAgYW5kIGNvbG9yIGRvbWFpbnMsIE9WTF9FWERNQSBhbHNvIGluY2x1ZGVzIGEg
Y29sb3IgdHJhbnNmZXIgZnVuY3Rpb24NCj4gKyAgdG8gcHJvY2VzcyBwaXhlbHMgaW50byBhIGNv
bnNpc3RlbnQgY29sb3IgZG9tYWluLg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRp
YmxlOg0KPiArICAgIGNvbnN0OiBtZWRpYXRlayxtdDgxOTYtZXhkbWENCj4gKw0KPiArICByZWc6
DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICBjbG9ja3M6DQo+ICsgICAgbWF4SXRlbXM6
IDENCj4gKw0KPiArICBwb3dlci1kb21haW5zOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4g
KyAgbWVkaWF0ZWssbGFyYjoNCj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZp
bml0aW9ucy9waGFuZGxlDQo+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gKyAgICAgIEEgcGhhbmRs
ZSB0byB0aGUgbG9jYWwgYXJiaXRlcnMgbm9kZSBpbiB0aGUgY3VycmVudCBTb0NzLg0KPiArICAg
ICAgUmVmZXIgdG8gYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJi
LnlhbWwuDQoNCkluIE1UODE5NiwgdGhlIGRhdGEgcGF0aCB0aGF0IEVYRE1BIGFjY2VzcyBEUkFN
IGRhdGEgaXMgc2hvd24gYmVsb3cuDQoNCkVYRE1BIChkbWEgZGV2aWNlKSA8LT4gTEFSQiA8LT4g
U01NVSAobW11IGRldmljZSkgPC0+IERSQU0NCg0KSW4gTVQ4MTk1LCB0aGUgZGF0YSBwYXRoIHRo
YXQgT1ZMIGFjY2VzcyBEUkFNIGRhdGEgaXMgc2hvd24gYmVsb3cuDQoNCk9WTCAoZG1hIGRldmlj
ZSkgPC0+IExBUkIgPC0+IElPTU1VX1ZQUCAobW11IGRldmljZSkgPC0+IERSQU0NCg0KVGhlc2Ug
dHdvIGFyZSBzaW1pbGFyLCBhbmQgTEFSQiB3b3JrcyBsaWtlIGEgYnVzLg0KDQpJbiBNVDgxOTUg
ZGV2aWNlIHRyZWUgWzFdICh1cHN0cmVhbSksIE9WTCBoYXMgYW4gaW9tbXVzIHByb3BlcnR5IHBv
aW50aW5nIHRvIElPTU1VX1ZQUCwNCg0KYW5kIElPTU1VX1ZQUCBoYXMgYSBsYXJicyBwcm9wZXJ0
eSBwb2ludGluZyB0byBMQVJCDQoNCiAgICAgICAgICAgICAgICBpb21tdV92cHA6IGlvbW11QDE0
MDE4MDAwIHsNCg0KICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTk1LWlvbW11LXZwcCI7DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8
MCAweDE0MDE4MDAwIDAgMHgxMDAwPjsNCg0KICAgICAgICAgICAgICAgICAgICAgICAgIG1lZGlh
dGVrLGxhcmJzID0gPCZsYXJiMSAmbGFyYjMgJmxhcmI0ICZsYXJiNiAmbGFyYjgNCg0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmbGFyYjEyICZsYXJiMTQgJmxh
cmIxNiAmbGFyYjE4DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJmxhcmIyMCAmbGFyYjIyICZsYXJiMjMgJmxhcmIyNg0KDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZsYXJiMjc+Ow0KDQogICAgICAgICAgICAgICAgICAg
ICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDU5NCBJUlFfVFlQRV9MRVZFTF9ISUdIIDA+Ow0K
DQogICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZ2cHBzeXMwIENMS19WUFAwX1NN
SV9JT01NVT47DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJiY2xr
IjsNCg0KICAgICAgICAgICAgICAgICAgICAgICAgICNpb21tdS1jZWxscyA9IDwxPjsNCg0KICAg
ICAgICAgICAgICAgICAgICAgICAgIHBvd2VyLWRvbWFpbnMgPSA8JnNwbSBNVDgxOTVfUE9XRVJf
RE9NQUlOX1ZQUFNZUzA+Ow0KDQogICAgICAgICAgICAgICAgfTsNCg0KICAgICAgICAgICAgICAg
IGRpc3BsYXlAMTQwMDkwMDAgew0KDQogICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxOTUtbWRwMy1vdmwiOw0KDQogICAgICAgICAgICAgICAgICAgICAg
ICAgcmVnID0gPDAgMHgxNDAwOTAwMCAwIDB4MTAwMD47DQoNCiAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNTg2IElSUV9UWVBFX0xFVkVMX0hJR0ggMD47DQoN
CiAgICAgICAgICAgICAgICAgICAgICAgICBtZWRpYXRlayxnY2UtY2xpZW50LXJlZyA9IDwmZ2Nl
MSBTVUJTWVNfMTQwMFhYWFggMHg5MDAwIDB4MTAwMD47DQoNCiAgICAgICAgICAgICAgICAgICAg
ICAgICBjbG9ja3MgPSA8JnZwcHN5czAgQ0xLX1ZQUDBfTURQX09WTD47DQoNCiAgICAgICAgICAg
ICAgICAgICAgICAgICBwb3dlci1kb21haW5zID0gPCZzcG0gTVQ4MTk1X1BPV0VSX0RPTUFJTl9W
UFBTWVMwPjsNCg0KICAgICAgICAgICAgICAgICAgICAgICAgIGlvbW11cyA9IDwmaW9tbXVfdnBw
IE00VV9QT1JUX0w0X01EUF9PVkw+Ow0KDQogICAgICAgICAgICAgICAgfTsNCg0KSW4gTVQ4MTk2
IFsyXSAodGhpcyBwYXRjaCksIEVYRE1BIGhhcyBhbiBpb21tdXMgcHJvcGVydHkgcG9pbnRpbmcg
dG8gU01NVSBhbmQgYSBsYXJicyBwcm9wZXJ0eSBwb2ludGluZyB0byBMQVJCLg0KDQogICAgICAg
ICAgICAgICAgIG1tX3NtbXU6IGlvbW11QDMwODAwMDAwIHsNCg0KICAgICAgICAgICAgICAgICAg
ICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk2LW1tLXNtbXUiLCAiYXJtLHNtbXUt
djMiOw0KDQogICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDAgMHgzMDgwMDAwMCAwIDB4
MWUwMDAwPjsNCg0KICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQ
SSA0NzcgSVJRX1RZUEVfRURHRV9SSVNJTkcgMD47DQoNCiAgICAgICAgICAgICAgICAgICAgICAg
ICBpbnRlcnJ1cHQtbmFtZXMgPSAiY29tYmluZWQiOw0KDQogICAgICAgICAgICAgICAgICAgICAg
ICAgI2lvbW11LWNlbGxzID0gPDE+Ow0KDQogICAgICAgICAgICAgICAgIH07DQoNCiAgICAgICAg
ICAgICAgICAgZGlzcF9vdmwwX2V4ZG1hMjogZG1hLWNvbnRyb2xsZXJAMzI4NTAwMDAgew0KDQog
ICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTYtZXhk
bWEiOw0KDQogICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDAgMHgzMjg1MDAwMCAwIDB4
MTAwMD47DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8Jm92bHN5c19jb25m
aWdfY2xrIENMS19PVkxfRVhETUEyX0RJU1A+Ow0KDQogICAgICAgICAgICAgICAgICAgICAgICAg
cG93ZXItZG9tYWlucyA9IDwmaGZycHN5cyBNVDgxOTZfUE9XRVJfRE9NQUlOX09WTDBfRE9STUFO
VD47DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICBtZWRpYXRlayxsYXJiID0gPCZzbWlfbGFy
YjA+Ow0KDQogICAgICAgICAgICAgICAgICAgICAgICAgaW9tbXVzID0gPCZtbV9zbW11IDE0ND47
DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAjZG1hLWNlbGxzID0gPDE+Ow0KDQogICAgICAg
ICAgICAgICAgIH07DQoNCkJvdGggaGFyZHdhcmUgZGF0YSBwYXRoIGlzIHNpbWlsYXIsIGJ1dCBM
QVJCIGlzIHBvaW50ZWQgYnkgSU9NTVUgZGV2aWNlIGluIE1UODE5NSBhbmQgTEFSQiBpcyBwb2lu
dGVkIGJ5IERNQSBkZXZpY2UgaW4gTVQ4MTk2Lg0KDQpTaG91bGQgTEFSQiBiZSBwb2ludGVkIGJ5
IHRoZSBzYW1lIGRldmljZSAoRE1BIGRldmljZSBvciBJT01NVSBkZXZpY2UpPw0KDQpPciBhbm90
aGVyIHdheSB0byBkZXNjcmliZSB0aGVzZSB0aHJlZSBkZXZpY2U/DQoNCiANCg0KWzFdIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4
dC5naXQvdHJlZS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS5kdHNpP2g9bmV4
dC0yMDI1MDYyNg0KDQpbMl0gaHR0cHM6Ly9jaHJvbWl1bS1yZXZpZXcuZ29vZ2xlc291cmNlLmNv
bS9jL2Nocm9taXVtb3MvdGhpcmRfcGFydHkva2VybmVsLysvNjI1MzQ1OS8yL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk2LmR0c2kjMzEyNw0KDQogDQoNClJlZ2FyZHMsDQoNCkNL
DQoNCj4gKw0KPiArICBpb21tdXM6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICAnI2Rt
YS1jZWxscyc6DQo+ICsgICAgY29uc3Q6IDENCj4gKw0KPiArcmVxdWlyZWQ6DQo+ICsgIC0gY29t
cGF0aWJsZQ0KPiArICAtIHJlZw0KPiArICAtIGNsb2Nrcw0KPiArICAtIHBvd2VyLWRvbWFpbnMN
Cj4gKyAgLSBtZWRpYXRlayxsYXJiDQo+ICsNCj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxz
ZQ0KPiArDQo+ICtleGFtcGxlczoNCj4gKyAgLSB8DQo+ICsgICAgc29jIHsNCj4gKyAgICAgICAg
I2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiAr
DQo+ICsgICAgICAgIGV4ZG1hOiBkbWEtY29udHJvbGxlckAzMjg1MDAwMCB7DQo+ICsgICAgICAg
ICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Ni1leGRtYSI7DQo+ICsgICAgICAgICAg
ICByZWcgPSA8MCAweDMyODUwMDAwIDAgMHgxMDAwPjsNCj4gKyAgICAgICAgICAgIGNsb2NrcyA9
IDwmb3Zsc3lzX2NvbmZpZ19jbGsgMTM+Ow0KPiArICAgICAgICAgICAgcG93ZXItZG9tYWlucyA9
IDwmaGZycHN5cyAxMj47DQo+ICsgICAgICAgICAgICBpb21tdXMgPSA8Jm1tX3NtbXUgMTQ0PjsN
Cj4gKyAgICAgICAgICAgICNkbWEtY2VsbHMgPSA8MT47DQo+ICsgICAgICAgIH07DQo+ICsgICAg
fTsNCg0K

