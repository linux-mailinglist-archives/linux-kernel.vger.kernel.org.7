Return-Path: <linux-kernel+bounces-818213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CE8B58E47
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17C41BC5A27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD962C3257;
	Tue, 16 Sep 2025 06:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nMxtpDlh";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="g6gbpIj+"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9846226F2AC;
	Tue, 16 Sep 2025 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758003197; cv=fail; b=vF7355wKkZHeehEtnfL2nSGILvyNSdgwbmV5Q0bgvPam1oTy8IWMI/E81FViW2Ms/mH8YfQS5kVNjauNuYexQV1XX/tsBsAN1YrLygLxvtPNExlyzzvapFBb6BKawYzXngnkJHDCE5feNfVXoeg09ljwCCt9I0NjAuO0vMpp8/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758003197; c=relaxed/simple;
	bh=6K9A2vuBxus5IPmUGePo64fsOcmcMwKpp4N1QehoXjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=swARD+OLh70LCzk9IJ6m1Ir4qhypqs32RHaTB0Wnf+XwrKOySIM8EM82BpMoR0gM3PewSQQ8y4XC7uBUehvjeOu4iB/RsWSFAFJw2IlKsjP2nCRE0n45OQlrMEv+htCBKHC/RGZxF+8N/fQcSm6WbjbL/kwB4P13MbVQxkNzMug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nMxtpDlh; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=g6gbpIj+; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3251ead492c411f0bd5779446731db89-20250916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6K9A2vuBxus5IPmUGePo64fsOcmcMwKpp4N1QehoXjg=;
	b=nMxtpDlh1fxWSTjlvf3mP2vPvSIwt3MlRi137auAB6nt56/ODsCozMTCwp495gZZ+CrL2aYV6pVQ4wiQKKxHTus2eNIY5mkDCscx+y5unQkIIIou5lKOO3QOJA0/RCr96+gDqmp2hDTC0636mT48ChdHPOio7ni9H1C5SVT4w5A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:4063fd32-7c04-4654-ae22-11a7dde3f90f,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:424f58f8-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3251ead492c411f0bd5779446731db89-20250916
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <paul-pl.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1515165931; Tue, 16 Sep 2025 14:13:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 16 Sep 2025 14:12:58 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 16 Sep 2025 14:12:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDBvxvt7ZJ/ZLvvw99TVWHxRK6gFjcxvKOS1tkGLigYtjGU8QAEz2oHdEgwjWjWINq0hd6utgsz/tf2hZGM4wTRJxtUwdfeSVXudvnwW25C6af4RonSNtpN4xkYD2h+S2amfvwI/HJ/70ZgOmtRGyRKKrYqPjXA3GeFsjJTXOJxuSBiQdbsJeUeKUhCTpTl4aHSsAGiJZYV2TPA/GaC1JSyIFiInWikwGJirJEW7p8g0XLO3W12sDvNVKYbtdMRY1BLgSJC+WnAb1jR/L3oa3W9c0uAOts5pd0fDJIP8/QXaAIGr9DDsUVHRFXFPDDs8BN/ddHZkFJF3nkWdO+Qlmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6K9A2vuBxus5IPmUGePo64fsOcmcMwKpp4N1QehoXjg=;
 b=i0vkUUaR8v9nRuveiu7vRtDNKiL5unCZJlIwifffWlfPuGZuoihJnwwIVq8AyT6eZFgOpzIHzML+Nr6kWo3menHMMutTcWt1dUyYssxwCHuz/6K4vNDHNMKKIZvvPcR+wAFcf/WIzU87+UVqN+Z8TnNoUjzy/fcNpSqZ1DUD9KMIXdZLgezafEW0EcLWl2+LF/eZ57nipr/84Xt12QIl6WPwgiBExo1JcCBj3npy4CVSvHF4EL2chpEwV7VMJvk4EZxBIbuP4isFIDmgT/Mc22l5ieVo9pi52K9qUXLaqWASx/vly4B0ZBvYdt3+Vu7ldEWdoMJP9TelsVaJXbn9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K9A2vuBxus5IPmUGePo64fsOcmcMwKpp4N1QehoXjg=;
 b=g6gbpIj+6dSYTxulpW44PPCbHLB+82SEQ0LEVIpe1xRfEyi4fc4jJY5QyCMoZThw07edWG/1H5dABe/EfxW+WSei5sNS7nU2CnPW2yAqEEuoifGOmxrt0mb2BfQCp8GMTuzMTY3PuoFNN2DpBigN0fosD4Jfk9RoGy54N0JuA8U=
Received: from SG2PR03MB6636.apcprd03.prod.outlook.com (2603:1096:4:1b8::6) by
 SE2PPF60ECEDADA.apcprd03.prod.outlook.com (2603:1096:108:1::49c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 16 Sep
 2025 06:12:52 +0000
Received: from SG2PR03MB6636.apcprd03.prod.outlook.com
 ([fe80::98e8:d61:f404:4052]) by SG2PR03MB6636.apcprd03.prod.outlook.com
 ([fe80::98e8:d61:f404:4052%6]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 06:12:52 +0000
From: =?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
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
Subject: Re: [PATCH v4 18/19] drm/mediatek: Add support for multiple mmsys in
 the one mediatek-drm driver
Thread-Topic: [PATCH v4 18/19] drm/mediatek: Add support for multiple mmsys in
 the one mediatek-drm driver
Thread-Index: AQHcF/M60+RXrlOaskqFEMRvofLSTLSMa+uAgAkGCYA=
Date: Tue, 16 Sep 2025 06:12:52 +0000
Message-ID: <8ddf201e459cabd22772117857b0fe65a9171002.camel@mediatek.com>
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
	 <20250828080855.3502514-19-paul-pl.chen@mediatek.com>
	 <4367758f-77d8-460c-887a-946b1c7cdd68@collabora.com>
In-Reply-To: <4367758f-77d8-460c-887a-946b1c7cdd68@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6636:EE_|SE2PPF60ECEDADA:EE_
x-ms-office365-filtering-correlation-id: de8d5300-67c4-4195-d7a8-08ddf4e811f3
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TUZlK3JVSzh2b2ptRWNDZERYU25rYkY1K283K2RZS28xc1FiaFJQSXY0enRS?=
 =?utf-8?B?QzdKNkRNZzR6OThWbzFVSEMycUFzUk9lS2lqckRGbFVsTk54Qzd0amZZbC8v?=
 =?utf-8?B?elVjejhuWG04SHlRSU5VcWhJdllQWVdaWUMrUXFOZ1NhYmlpaGlUaDlCVWtT?=
 =?utf-8?B?RVRZZ1J1ekhUc2FBSXkvVE5nSjB3SWFDUTVsRW5WY2g4SnlxWVFSU3c2U0Jl?=
 =?utf-8?B?ZU1yWXgxWFcwWHRsUC9UM0ZFL1NJeDVWamZZbm95ZklxeFVNOFVlTnNsUGQw?=
 =?utf-8?B?VGpNTnl0Wk5hN2I4OXBtRlAzOFV3MU91V29QeU81VGhTQWtDVk9FZHEwZGZD?=
 =?utf-8?B?SVo3MVhYNllLZEZlUUxUY0N3N0lTenIvbnJldmFyTmxhRXpWMjBRcHkxWVhP?=
 =?utf-8?B?MTdCQnQyYzN3WmxyV1MvdlBzTUJpV2ZpNDNKaUVCcThycEZ5SENsVjFRTGhM?=
 =?utf-8?B?RS8zYllxVjBlWXQ2MnAzRUZMVkx3T09ETk5wb1piNkVST2FIYkcrTUg0R0R6?=
 =?utf-8?B?UjdoSTcrRHpadUxTTGp4Sm0wYnA4dFR2U29SYjloVWJFdGlkZzVFOTJjTGF1?=
 =?utf-8?B?SmhTd1Y1aS9Lb1k3ZTRpODlHcFJrWlR0QUxKNkhtajBpVEVKNnhjR1RGUU94?=
 =?utf-8?B?NVBicWlEUzhjYURER1Eyb2FPdzc5VjdUeGZRNVRBZzMyd3gzVWdKSG1MUmZJ?=
 =?utf-8?B?N1BYdmNGdGxoNUFDaW9wWWloQ1plUUdpYi9tUnoreGd5Sjh4MEhmVWcrK3JJ?=
 =?utf-8?B?bytvN0NhdjB4YXY1NjF1UjRHREVNK3JrRjBNcVVBcEwxdGxzV0ZqSlVDSlZK?=
 =?utf-8?B?VGR4TTRveHRSVmtFRjBIVWtNTytuNXVNdlRTbFM0NmU5blRYbXZYN0ZFcUxP?=
 =?utf-8?B?Z2tGMWh1WmIvVmw3VWlZRFBkYzk1aHhob3lnMzVhbGUxVTV6OWNWNEpKeFdG?=
 =?utf-8?B?WU1xQ242UGxGSnJrV1dScjB4bXNpWmZHUHNFcDhOWCtseERMdUxGTFhORllH?=
 =?utf-8?B?TTcvOUxLNjFJdStEbzlGN1B3NldSMEVrOHZOb0FTMjVFWXk1QWsza3FoZVpL?=
 =?utf-8?B?ekVMRDEvOTM4b2FEbUplQmx0eTZ2NDExeHZIUTU3Q0hMWW9GNkFBTllnNzMz?=
 =?utf-8?B?WFVCRmt1UW1hUWdqVlV0MitnaHJIVU1GcUtmUHZESFJWOWxuV2RpNXdEMzlx?=
 =?utf-8?B?NXNQN2tRV3FGczVvTmc4OGF3VVpvd2tkTXV4WE1WQWl2ZjNPK282SXJQdVln?=
 =?utf-8?B?Wm9JUkNhZE1EREpmZjU2b1VkbVgxK0ZKN0pES3ZQY0xZVFVJSXF6VmRrelBC?=
 =?utf-8?B?T0gvTHZ0VkljaitjcDhKWTZaK01ORExjR1Npa3h3VWRjTFNDMGNDdjRYUmxE?=
 =?utf-8?B?cUt6M3p0WU5sMDdHYzFGQ1gxWWRkZ2tYTUo2QzBZMEhsdnhPOGw4RHo2bWE4?=
 =?utf-8?B?MDc0YW1Iai9wbXczOFRMOFNZYm9CamRxUXJud0lyOXliYnJyU1I4Ti9Ndm5S?=
 =?utf-8?B?NW1pQkJGWTBmMUVLYThraFZtLy9KUUpKQllxK1E2dkdZcWR3UDlNaFV3UExC?=
 =?utf-8?B?c25CRWp2U3JzTEFMUzZubkwyUEVrWHM1ekM1dlhYcU5HdGpMMU1MeVUxNldp?=
 =?utf-8?B?UzJoNmdzREt6cURRUVMya3FzSHFTQ00xQjJ5K2tDRElDaW01cmZmbnRkZlJi?=
 =?utf-8?B?b1FYVXoxZkVsWElJczZTU1BiNGV2QUI5bEt4Q2FwRkZQMHgrMFhDVFFUTDJI?=
 =?utf-8?B?bkNFRENVTUlvdU96V1ZCODNndlRRNjRrN0F5cnFCSW54N0Z3UkZhbkRuamsx?=
 =?utf-8?B?UnZXSHZldHlPV2tHcTEwUCt2L2NlWXdwSzd4RVZMZ3ZxalZvamYxS05lWDdI?=
 =?utf-8?B?QnJZNkE5amw1eUNKdSsrV3N5SVY2Mkd5Uk12RnJrWnFGYi9pc09JbHhkQzJa?=
 =?utf-8?B?WkNhZ1V5TDh2dFNFbjc2VWYyckVmTkovZnRaUEJxYnJsUFhDOERxRm9sbW9V?=
 =?utf-8?Q?3DMN4B9FihOmr0MWmK6RwZ66ZXzuOM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6636.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tmk0dUxydmVoMlQzaTVjYkVWTSt1dWlubXdmdzZ2WU5EdTl4SmczUnlERWph?=
 =?utf-8?B?WEs2SEcwamd6a2ZQWlBMcUVwcTdoQ0pCbVZVSGF5aEh1cUMrdjh2VFBVcGhI?=
 =?utf-8?B?N2k1TG93V2hhNEVwNjdLdUdva1dzVWxHR21LN0h6cnBPRWlKb3Z4eEtocDlZ?=
 =?utf-8?B?WkI0azk4VHc0ZHRzSWRXakJrd3o0SDJTdDRjUC9xMHk3TXJ5cWwxbFVmcTRV?=
 =?utf-8?B?TjlqT1ZKVGg0dlNyU2FmbXhudmZjRUI3M2Y4bmRZZzhiMHZUTmlWM3FqZ0Zx?=
 =?utf-8?B?RW5qdHpReDl4eW1tclMwL0c0d3laTjZmRHZTWGx0NFhSeEVDTU9mNWN5UUVG?=
 =?utf-8?B?R3QwZzdLVUNsSTFJQzN6SGUzTkIwZkJmT1puYy9EMUI3c2tCd1N6cXlpN3pj?=
 =?utf-8?B?UW9UUVRwN2o2RVhVaWlrM2hjSFpjSnFvRVkyVlJZZGVCdXRya1RyTEtHeDkx?=
 =?utf-8?B?bHhXZWxFVmtLTXNhOGpQNTBlTWhGM3Z2ZHRNZWM3T0xIOTFOYWQ4cXduTlM0?=
 =?utf-8?B?bWNBMGt0YVRDNUltUFNDQnVjaFg4WGRibEpGOERrN21JOW9Qbm9wYUU4OHhx?=
 =?utf-8?B?emdQelFhMjZiZTlYSzZEbUVjRmhyVE8zVXV5aWRHLzRGSUJGd2c5VXMzSW8w?=
 =?utf-8?B?Z0NZWXJ4d0kyT25PbEJBSTJnUUUxcUdXMm90N2ZpaEQ5dFM1cy8yZ3BYSUNM?=
 =?utf-8?B?V3oxOXR0OFJFRjRaSWg2RnNpeW45aG40aE93T0Qvei9HTExOVnJiWHc0VVQz?=
 =?utf-8?B?SFIyb3NPVVc0dTdqUFdqMW9TNm8zQXVGVjVpZUdnczJLeS9OeGd1Vm1HYkdo?=
 =?utf-8?B?UnU2QlJBcnUwWkxWNCsvUjdCdVY0R3FybElhYVRTMDhMcnJvVmJ3SHBlRndH?=
 =?utf-8?B?M1kvMFRRSUN0dm90b3pzdGYvTy8rU0lsZGpUMHVyWm8raTRrWnhIVk9JQ1Yv?=
 =?utf-8?B?L2U3bVlRK2tWVHBmTnptWEFTdkxmYzNqNHRoOFYyQVM3NElJaGlqdld6UEFr?=
 =?utf-8?B?OHdrNTRLcThuRVVhT2RtM2MyNS9pK3EvTVNuS1ZjcmUrQUk2Mm81UE81a1Nm?=
 =?utf-8?B?aGdHU2ZQYnVXVnJGdkF5U21aOFRHblNTR1VQcGZHejR0RC9YOHc4OVlSL2Jx?=
 =?utf-8?B?ZVFNZnM5VnRxYjB3MndxUDE2RHdvNWN0QTgxdU96TmpqaGRDaXlYMlExUHly?=
 =?utf-8?B?Q1BtMmFYNEljWERjNFVvUjdhV0c4blhzTkx0aGJPMUgwVThmYU9NQ2pIWjlT?=
 =?utf-8?B?VFVFc2RsZ05teW9SbGtzcnRobjJLWUcxc0theW5RQXJ5bDkzVkZ0UXNsazcz?=
 =?utf-8?B?bUw4Qmp4TEdNSnFtNkxxQnpuTXdaa3YrNi9VWVpZRGwyVlZxWk9wSlNLUUV2?=
 =?utf-8?B?dUd5ZDFKaEdHVFJBQnhFbzJmbGFGKzJxc0RRN1ZrWG1IdkZkWGZJUzFaMTc3?=
 =?utf-8?B?bWx4UFVXekJ0UDJzL0tOYWFBang1L01CK1FYMEtCVmlLNDVJc0JweEo5WWh1?=
 =?utf-8?B?MTNRTGxoRTV4V293OGIycUZrdmNGU1lsVUZMbTFCeWgvMlBaNytqMlo5QmRJ?=
 =?utf-8?B?cjIwdm5lQk9WOWEzNW9qYWEyajRjWEwwMzJTUjhSRnlhY1BBQVNJc1FZOG9R?=
 =?utf-8?B?RkJrbFJ1REZraFRNMGxjNEthb3h2TWtRVE14OThjNkJIUEdxMXVXeDA1aXRT?=
 =?utf-8?B?N1lPMFc2VGRUaWJLejhPWkdQT1F4UUJSVlVqUkJsc3BKU2s0VWFWcFg5QW01?=
 =?utf-8?B?Q1NyOGllVlNaencyUDJ5RURjRDY5TW5vOHVhenI3b2gxSzdONTdJT1N3OEps?=
 =?utf-8?B?V1ovajZQQnJyRm9HbmVjNk91R3kvZzFSS3l0MWlweDYySnJhWXJaeGMwVURU?=
 =?utf-8?B?T3FBVkFDU2JyYkdVMmVaWWVOY2dEcDl6TlRzVnZYZmk0YnB2aW5iSXduV0I4?=
 =?utf-8?B?SDJJWjZ1KzRpRlFkVklQeWM4cCtGVkxTWk5NUzRHZk45ZTV0U1AxeEtIbXdi?=
 =?utf-8?B?Tyt5T2FTQklRK3VIK05RUGdETS93OFNTYVcvTHhrZ0ZOSEQ0ckY3bXZPMjhT?=
 =?utf-8?B?OEYzN0NiV2NxaW02bDlDcHFFZkJnREhJT2Vya2tvVFYvc2c1eklaTklSRDdT?=
 =?utf-8?B?ZTVtS212VU9XSnlJSEVRWG1TYXVtZ0p6V3JUVExwN1RIaHhqdkp0Wmd6WWRa?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F363EB4DC952D54180EFD05C743687E7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6636.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8d5300-67c4-4195-d7a8-08ddf4e811f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 06:12:52.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MVeHD4p+8gsSkBNzus1VFtJ3awa9Q5dBhkJBwQa4V4ZGp9V+qY0gm10UTlL1ZFXW2kZKKqynpqFikuo4k0VbPTJVSeDiwQ8ppCUlUrT0plA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF60ECEDADA

T24gV2VkLCAyMDI1LTA5LTEwIGF0IDE0OjI0ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBz
ZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gSWwgMjgvMDgvMjUgMTA6MDcsIFBhdWwg
Q2hlbiBoYSBzY3JpdHRvOg0KPiA+IEZyb206IE5hbmN5IExpbiA8bmFuY3kubGluQG1lZGlhdGVr
LmNvbT4NCj4gPiANCj4gPiBUbyBzdXBwb3J0IG11bHRpcGxlIG1tc3lzIGluc3RhbmNlcyBpbiB0
aGUgb25lIG1lZGlhdGVrLWRybQ0KPiA+IGluc3RhbmNlLA0KPiA+IHByb3ZpZGluZyBpbXByb3Zl
ZCBmbGV4aWJpbGl0eSBhbmQgc2NhbGFiaWxpdHkgYnkgdGhlIGZvbGxvd2luZw0KPiA+IGNoYW5n
ZXM6DQo+ID4gDQo+ID4gMS4gQWRkIEREUF9DT01QT05FTlRfRFJNX09WTFNZU19BREFQVE9SKiB0
byBwcm9iZSB0aGUNCj4gPiDCoMKgIG92bHN5c19hZGFwdG9yIGRyaXZlcnMgYW5kIHN1cHBvcnQg
ZGlmZmVyZW50IG1tc3lzIGNvbXBvc2l0aW9uLg0KPiA+IDIuIEFkZGVkIG5ldyBjb21wb25lbnQg
dHlwZXMgTVRLX0RJU1BfVklSVFVBTCB0byBzdXBwb3J0IHRoZQ0KPiA+IMKgwqAgcm91dGluZyB0
byB2aXJ0dWFsIGRpc3BsYXkgY29tcG9uZW50cy4NCj4gPiAzLiBBZGRlZCBhbmQgYWRqdXN0ZWQg
dGhlIGV4aXN0ZWQgc3RydWN0dXJlIG9yIGludGVyZmFjZSB0byBleHRlbmQNCj4gPiDCoMKgIHRo
ZSBzdXBwb3J0IG9mIG11bHRpcGxlIG1tc3lzIGluc3RhbmNlcy4NCj4gPiA0LiBNb2RpZmllZCB0
aGUgY29tcG9uZW50IG1hdGNoaW5nIGFuZCBiaW5kaW5nIGxvZ2ljIHRvIHN1cHBvcnQNCj4gPiDC
oMKgIG11bHRpcGxlIG1tc3lzIGluc3RhbmNlcy4NCj4gDQo+IFRoaXMgY29tbWl0IGlzIGh1Z2Ug
YW5kIGEgYml0IGRpZmZpY3VsdCB0byByZWFkLCBidXQgYWxzbyB5b3UgaGF2ZQ0KPiBzcGxpdCB0
aGUNCj4gY2hhbmdlcyBkZXNjcmlwdGlvbiBpbiBmb3VyIHBvaW50cy4NCj4gDQo+IFBsZWFzZSwg
c3BsaXQgdGhpcyBpbiBmb3VyIGNvbW1pdHMsIGZvciBlYWNoIG9mIHRoZSBjaGFuZ2VzIHRoYXQN
Cj4geW91J3JlIGFjdHVhbGx5DQo+IGRlc2NyaWJpbmcgaW4gdGhlIGRlc2NyaXB0aW9uIG9mIHRo
aXMgc2luZ2xlIG9uZTogdGhpcyBub3Qgb25seSBtYWtlcw0KPiByZXZpZXdpbmcgYQ0KPiBiaXQg
ZWFzaWVyLCBidXQgd2lsbCBoZWxwIHVuZGVyc3RhbmRpbmcgd2hhdCdzIGJlaW5nIGRvbmUgaW4g
Y2FzZSBhbnkNCj4gdW5jYXVnaHQNCj4gcmVncmVzc2lvbiBzaG93cyB1cCAiYWZ0ZXIgdGhlIGZh
Y3QiLg0KPiANCj4gVGhhbmtzLA0KPiBBbmdlbG8NCj4gDQoNCkhpIEFuZ2VsbywgDQoNClN1cmUs
IEkgd2lsbCBzcGxpdCB0aGlzIGNvbW1pdCB0byBmb3VyIGNvbW1pdHMgdG8gbWFrZSBzdXJlIGV2
ZXJ5DQpjb21taXQgaGF2ZSBvbmx5IG9uZSBjaGFuZ2VzLiANCg0KQmVzdCwgUGF1bA0KPiANCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW5jeSBMaW4gPG5hbmN5LmxpbkBtZWRpYXRlay5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUGF1bC1wbCBDaGVuIDxwYXVsLXBsLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KPiA+IC0tLQ0KPiA+IMKgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5j
wqDCoMKgwqAgfCAzNDINCj4gPiArKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gPiDCoCBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuaMKgwqDCoMKgIHzCoMKgIDYgKy0NCj4gPiDC
oCBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMgfCAxMDUgKysrKystLS0N
Cj4gPiDCoCBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmggfMKgwqAgMiAr
DQo+ID4gwqAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmPCoCB8wqAgODUg
KysrLS0tDQo+ID4gwqAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmjCoCB8
wqAgMTMgKw0KPiA+IMKgIDYgZmlsZXMgY2hhbmdlZCwgNDIxIGluc2VydGlvbnMoKyksIDEzMiBk
ZWxldGlvbnMoLSkNCj4gPiANCg0K

