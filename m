Return-Path: <linux-kernel+bounces-770607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E78B27D02
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308B916EF6A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1526C26C3AE;
	Fri, 15 Aug 2025 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D5tbmeid";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="flK8cCp7"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456126D4C7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249753; cv=fail; b=MhEhXDMolzHnCftDfMDsAMN4MvnCvA6pw5EnYrRIQ8QSi0Ijw4ho1AlegKK5SeQ0ipRc1JDg8p0dOT8waMK6tkpIquMr6bZMWNWy5zOFEPMiUNvLE8eb5uRAHd7/FABK9LLXZCFF6gCMo7CAp9vBXtjJUm5lA7fTkZ3ZXFSoy8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249753; c=relaxed/simple;
	bh=t4ZqYSi1SipCjkYR68Ny6DQoaLz+n7As1J3k6CawvWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZYEC0IzREptK3lC7RLPEvf3cE0lEPsL7U7JXNmwEJ4Myyd2Xu7ab9yscpV5DBjio0r70aQ6o/2/LpAdliHFj1h5Dtgg9vMQLXasB4ppwqA8/kodMbwiI+HYJIJfuH+Y0+7R2KRQkUZ2wDK6B6K8mjis919kPnjA3+R9moMS2E7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=D5tbmeid; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=flK8cCp7; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 59bd280a79b911f0b33aeb1e7f16c2b6-20250815
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=t4ZqYSi1SipCjkYR68Ny6DQoaLz+n7As1J3k6CawvWE=;
	b=D5tbmeidmZIv9uC5VSK9UVpsR63C6kSU50jzpbypQCrIR5KeFmH2yJQFZm2lb3HhDyE+cALVkIZdxUOstZs+DYJr12cCYTJtqc23gdBB04SHHO0Ul8xfE0IuLKeotuitXQHTxyADm/Vbu25QaG0shyTBpn5Har45eD4C5EmvcFg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:6141bfae-10f4-4fa2-9feb-bffab729a03d,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:a5638344-18c5-4075-a135-4c0afe29f9d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 59bd280a79b911f0b33aeb1e7f16c2b6-20250815
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1802747669; Fri, 15 Aug 2025 17:22:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 15 Aug 2025 17:22:20 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 15 Aug 2025 17:22:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0598nHgctjz4X9paZ4uMi4OaT7vPKYJ1gEtZBleYUT/u5W+8igmEBY3r86Kruo8y3XkklYIxJ0r2UzTkszBJavdbGgDr7t2epEH6iUtXaGAYe6fc8jm0sKeljqAMIam3Fw05Dw9GR0k5klcJVbdCJyv90+NiAqaYZbaqcp9UdZmmkxcZfF43fqt+UbJMA+gbbKX0iZqoHGPMRB8td9O2ifDPCHJ8k5NpLJrxf++kT0bRSSBZBh4BZhaMRNYgPJ1y/0EN4YJZD0FdaYYzCfZ1oT9eDUNt15tX3nlhngP/WX70Zbcz71GQ+HTpZhTTb/Pl76VbNRK/yuSfbxEmvb4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4ZqYSi1SipCjkYR68Ny6DQoaLz+n7As1J3k6CawvWE=;
 b=pRDHgOeTlnqLotfzHNFqVOO1xSPMBu1+O0EKdP3hMOE662WUwzLooaJ4fH7XgvWDKh0SoEbs5L+AfkN2+V6rNBPARBuc/tXoZ/6NQKRy6zMsmpkQG5zJ/KPiDmrH7A32j4RUbxbbBVASCan85suVHGC2hhbU9/rwIiIfV/TYK7Ym4pcVfh9X09kdsJcTs2ElJaFk1j1+hfPfhseNC4ACbubBY7bfMxuI2MXN1kXihQAjB0+bAIThnc2KAMTc46zI116BEH+ZDD4zIvPc/b2FSFJHt99bIp4M7jiRriSGIiXurXrly+k3eNGxlRsHZCEYG1IgfwaP2mHrfuQ/FvRJAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4ZqYSi1SipCjkYR68Ny6DQoaLz+n7As1J3k6CawvWE=;
 b=flK8cCp7nG/zk/lyPYwmpS6bMxYdXSf7L0HRxwoJtw5ec4/anQaPH6IqwJ3De4xu5S0+4IX3EowoRRTFzH4LKHAPnFYN6wyeIomvny6AWDb4iZ1MFLs89FnCpQ2XDpvDPDK0wlPriLAZ/eEdMKQxZyUu6NQMWjCfo0O4daLTFwY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB6572.apcprd03.prod.outlook.com (2603:1096:101:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 09:22:19 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:22:19 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
	<airlied@gmail.com>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 01/10] drm/mediatek: mtk_hdmi: Drop redundant clock
 retrieval in mtk_hdmi_get_cec_dev
Thread-Topic: [PATCH v10 01/10] drm/mediatek: mtk_hdmi: Drop redundant clock
 retrieval in mtk_hdmi_get_cec_dev
Thread-Index: AQHcCE0lusMD8+7ocU2fvwFD+izTH7Rje5YA
Date: Fri, 15 Aug 2025 09:22:18 +0000
Message-ID: <feabc447d5030d5fc727c4f890e470efc111e40b.camel@mediatek.com>
References: <20250808-mediatek-drm-hdmi-v2-v10-0-21ea82eec1f6@collabora.com>
	 <20250808-mediatek-drm-hdmi-v2-v10-1-21ea82eec1f6@collabora.com>
In-Reply-To: <20250808-mediatek-drm-hdmi-v2-v10-1-21ea82eec1f6@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB6572:EE_
x-ms-office365-filtering-correlation-id: 7ba4a2c7-41b6-4191-601d-08dddbdd3b94
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|42112799006|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YmZRL015SDNpMzB6S290WEJYeU02VStGTVZxMTQxWEtQamlxd3ZGT0dNTldP?=
 =?utf-8?B?aW5SQTVtdlFoZ0l3b0xSbGdlWXg2MHhhMU1lVlZMbExhZ29ObjQ4SkdqWGpp?=
 =?utf-8?B?SlVQbklWM0k5bGIyR3d3RS9NdkJnNjFIdU9QdG9SWlh2UERRdmZrTlZPOEtC?=
 =?utf-8?B?OXQwTHVObzUzbytDVmdEbW81REJobldlYy9haDZTaE1yYmNLUWRORkl6Q3hx?=
 =?utf-8?B?S1BMREd2T1ZaRHNVMjhPTkd3cGxHWjJrOHFYd1laSHdLRzNUaG9kTkd4aTJ0?=
 =?utf-8?B?U3lNeDY2aFY3dld3SS9aSFZieER4YXRwSjV5L2cvSGRsMTBHamFmaWRUZmpB?=
 =?utf-8?B?QzJtWnltL2lFN1F5N3dsRXhZR3RFVHlJVy9pSlg2SGFHUzREZXNPVGJaVTVC?=
 =?utf-8?B?T1NmZndoaXova0lXSitHZHpNTTYxUEVkbDJ3VTF0anJZS2s5ZlBaOVdCNFBz?=
 =?utf-8?B?UzlmUXVvSTZ4Ui8wcnQrY21BcjR6UGg1Nm9wUVhnejd1UnMyU1pLNC9MN2gy?=
 =?utf-8?B?VkNNSlZWTmNqTlQrY2NLUmdFM3FmY2toTlVSMUNNYXV5cHdKbWpCMVBkME15?=
 =?utf-8?B?elk3R1krNldYTUIycDdsTkt4MWV6eFVrTXRRWlo1NnhCZWNQR0t1UHd5c3JX?=
 =?utf-8?B?a1FPZmM4K2RHbzBjUVZ1WDhYVVN4ZW43Q1J1U0Uxb24wMG5SUGI1TE1EZzFB?=
 =?utf-8?B?eWNrR0N4N2UrYlVTNlBTMGVPUnVJOHU2OXJhcVl6aytJbVBENExNL2cyU3Nh?=
 =?utf-8?B?TUlOc0VjMWJNUE1iNjFsemFEZU1vc3g0VHZvcDRYa056TEREM0RvT2pYRlgw?=
 =?utf-8?B?cjNRbE1JTjBPTFU0UzBXcEU1K01GODE3RVNxVkwzbnFzL3orQnNnd3QxTFZp?=
 =?utf-8?B?Q2x6Y1lzbjd1Vk9TSzFTWmdBTHZHMzlvdmFsTUNpZmxXWGFvVitqMVhkV2hS?=
 =?utf-8?B?dnV4enlvSW1RdmRqQ2dnNWdxVW1PU0hxeFBscnBPaXpvTjRtcXgzeXVLUjNx?=
 =?utf-8?B?QkpVMno1N3VKUmdkZ3JaUng0Wkc3N0ZhSExXSFFzdGZkd0IyTmMzMDU2bVJz?=
 =?utf-8?B?RVh1ZmRJZkIvdjh1Ny9hTE1rVml6bWdNVHpLWUUzNnFMdHBSZ21rcEtVVG1h?=
 =?utf-8?B?YUN3bDd1WUE0NWhUMktWWTFRNXRiZjZ6elRkNStOeEZ0S2x0V0lkTGtEaUNr?=
 =?utf-8?B?UVcydElGazErVTYyNHlZMDNsaXRyLzBFQzQwY3l5eVhTVWZrWTdmTjUvbkVS?=
 =?utf-8?B?OGk3amxsUkNhL1FNa1FXUWRGbFFyUDUyMDFxZkREem5wMTdDblRyeVp4RnZr?=
 =?utf-8?B?Z215eUJQYS9od3N5ZVlZYnB5K0hzZWJuZUtPd3ljT2N3TGROQWxKRSt0bmR2?=
 =?utf-8?B?aGxaaWU2WERNVWY1RU9nV2dpd3hYcXNnQVNBcU5RVmJRMjF3REdtUU0wOTUw?=
 =?utf-8?B?RzJXcHRLR0hZcUxCdnIyT1d5dncvY1NQWGszNWRMaEsvZlczd1dGdk9uZmVt?=
 =?utf-8?B?OTZFNWxNR0JqMmJ2VVBIcDdUYThNK3FzTGJXTmw1N2ZITTVGaS9QVjViTURW?=
 =?utf-8?B?d00xaVovbkJ0VHR5TGJqajdBNnRPeXlKdnJTQnRpY25zOElORytxLzBpWmNY?=
 =?utf-8?B?QXNWZTJYTnpIbjRuS3VHVTlPRlJCMEwxNXQxa3F2OE5hRC9Xb1dIUEpIYXla?=
 =?utf-8?B?eVBwTWh2YWRQZ3JPZWpDdG1pbTYrZndEUzIzOXVxQjVQKzVBTko0b3cyS0FY?=
 =?utf-8?B?cGxPYnRDTGdVcytNYUhwVktCUlpEYk9zQkswcVRLS3g3YUFUeVBhNm1pSGtm?=
 =?utf-8?B?djk3U2JxM0lUaDBqR0FlQlZ6MDJnWXJvc1l4eEJmMElsdE9FTmlkMDJRUUdS?=
 =?utf-8?B?aEltcDBiM215WUoyM3d0MDBmZDVCQXpQTGlIL2E3bWZsTHc1LzRHeXRUUkdB?=
 =?utf-8?B?QmU4ak1nVWtvWW95aGpvQlJHMWlEVC82KzJPVnBtWTFYUVM4UHdMVHhabDdn?=
 =?utf-8?B?eUNRbGdHaUdBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWp1WjRYM1NMRnM2VmU2RHd3YVZpVG4rWnJvMTVUNDBybGZQOHlQTFprTlNT?=
 =?utf-8?B?OXV1NzVDNW1YdndnQ1gySG9tK2c3VFRZYjdMODVGZlZIV1ROVEI1WlJJb1Bu?=
 =?utf-8?B?M21nSCtJaWxxb0xIbmd3RDMwLzlnRENiY2FQUVhETWFxajFFcWJsaE03RXVX?=
 =?utf-8?B?V240TmFiSWJwUS9oY3oyQit0N3NrUi9reGtEbTQrQVVUSDFBdjJwZkdxN3la?=
 =?utf-8?B?MHRmTjdoMGpMcXhNekxUV2xReGt1c3JqOUVsc3JTOVJadUhiU3M2bW42aEZN?=
 =?utf-8?B?RWVpaVQ1VHB1UkVBbThOTlBRYWdnSHhFNHFzWi9kTFJhc29WQ3hlOWhoN2pp?=
 =?utf-8?B?QUpNSTc3RS9hV3RQRmloNTlDWk0waWpscDJtWFFXaEJUdVo3ZDdIOGhPK2Vk?=
 =?utf-8?B?ekdudXNTMDlFY2FNNmdMa1BVUHFoWGNNLzBIZzNIRytLa00xVktpNzByako0?=
 =?utf-8?B?N1FsY2FXakRLV2tidXVpMlpST1BGYVVZS3E3ejhuMnJaTnI2WFNUSlhWd1VH?=
 =?utf-8?B?clpmc0g4SEdZSDJ2WjVONlI5czZZNW9hSGFrSy9iRnhhbFZkeXI5aUFDcGZ2?=
 =?utf-8?B?eUs1VUVoMEZJakEvYmNYUCt5dExWNEJscXp2OEpyNmcyNTR0THlpbGhndlAv?=
 =?utf-8?B?RzJMb1RXcGJ3emo4NHYwR3VCMmpPcGU4U2ZjOG1sZkhMR3BYVHc3RlpXVjZB?=
 =?utf-8?B?RE41Szg1NTZQanR0eURGTEZzS0c5REE1VE9aTWNOYk9MeE54YVlndk1Zc1g5?=
 =?utf-8?B?TW5WajdIK1F5bXltaDBuKzA4Tm9lV1dMa01nSkNZQ0tSUkhDbksvNi9HMDYv?=
 =?utf-8?B?d2tiUk1UWTB3UUVRS3duN0ZKQXR2MThkVk5uWm9Mb2ZuQnJtM05TQjdhT0t0?=
 =?utf-8?B?WC9qaGRiek9sWFRwOTlHZHBXNUNhUjlCWVIzeUtPbE5QQkxIUmVEY01iRjds?=
 =?utf-8?B?ODkrMlB1MWNnRVByVThjaXdJbGY4eGlkalZkcVBUamZrRGQ5Q2NkZU9nRk9q?=
 =?utf-8?B?QmgwQXpJVTNFZDB0TlZNNWs5VGFyMklxMUF5SnJkcDRkM1NvaE40dTdDZjBm?=
 =?utf-8?B?NDF2Z3JUL0hUYlFUcVFDUkpyUUt3aS9YU1N0YXB4cHh3SUpaMlMzUzYrdnl1?=
 =?utf-8?B?bFV4U21paThSZ2wxR0xVUEkweElzSTM5TnVCZHBWYm9LdXZDdDlTUGF2bGU4?=
 =?utf-8?B?b2lPYVNPZnozY2VDNXo2NkI0bzdINW9Kd1hLOFhWRG1BV0NtV29zY2xRWXov?=
 =?utf-8?B?YzgrSHp4czB2Q25hSld4N2VpcGR0UTM2dXBEeGVIMENZOE9ZVnRYV2dZU040?=
 =?utf-8?B?cDBMLzFBVDhncHovM2E1QU5EbUlYREFRdmtObldYN0d0a2c3cHEyK3J2cnJQ?=
 =?utf-8?B?aXFQTDBCcDFhOGtHdnUycGptR1JJUEpFSTQvRlp3VGlFT3c0R29Jb2xxYWxJ?=
 =?utf-8?B?aWlCZHBtWGwxR2JJeXhEREMxWHlsUFZYZ2h0OWlqdW5EUUplaG1wREllODVG?=
 =?utf-8?B?YjB5aFltOTdJZlV5VGRNcG1OZ3d1SmVIYTNPSGRCOFo4ZWo0NWNtRXBxa0JP?=
 =?utf-8?B?TlVIMTlmOU1aSDhnSlRGdUdtMFdsZXRDaHViSDJHL2FuZUlOQTJhdW55NmVv?=
 =?utf-8?B?QkNPRG92N0FxWEdwcW9TbEl6YTNoUUh2U0RvcXlMcUE2clpjQlY3Z2R0MmpT?=
 =?utf-8?B?bVRqTHp2TzV2NEdjVU9NY2F0eFRVRDVBTjN5aG45blRaQmN3N0E4TEZjNXV1?=
 =?utf-8?B?Z0w3eWE2M3JUcThsK2haNjg5OXM2aWNCRzlQYkxybVVRcXFpaDBxQXM5cGJX?=
 =?utf-8?B?OGkwQjFRL25zL0tYSGFrY1Z5am5FVi9hYUQ0UGM0WCt5aDl5am11RnNKT3h6?=
 =?utf-8?B?MnZMYmxPd3JtdmNXRkwxdGNuci9BaDllV29sRzFDdUt3c0dNWVEwcDgvNkVo?=
 =?utf-8?B?aXpBQjNXNkJ2WVNoUXN5SlQ4TCtLR0RUbHc4aUh0TFdYdUcrbHNtTytiaFBi?=
 =?utf-8?B?dWlEc1FuMmp3MnMwS2Fqenp1V3lGVENGeEFQQTFQaEl5elc4Q2Z2RlhHOGdl?=
 =?utf-8?B?ZDR5djBNNnJIRGg2aGpUMW1wc3dOcnJzRmFvaVVoclprSlRCUnJYSjB6TlNG?=
 =?utf-8?Q?BTGS0AeMj+7RSPilgOqjt6oXg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDF15C2E71D5B049B71B57CBE70B28AC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba4a2c7-41b6-4191-601d-08dddbdd3b94
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 09:22:19.0116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqZBA0xKfToHL04tO9YARRJvTKagqatzu3AKv67FR2aZd6FCePiKoUhBHQwJpUXBaowD4cWzihxSXDdvcw2FQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6572

T24gRnJpLCAyMDI1LTA4LTA4IGF0IDEyOjEyICswMjAwLCBMb3Vpcy1BbGV4aXMgRXlyYXVkIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiANCj4gDQo+IEluIG10a19oZG1pIGRyaXZlciwgd2hlbiB0aGUgQ0VDIGRldmlj
ZSBwYXJzaW5nIGxvZ2ljIHdhcyBtb3ZlZCBmcm9tDQo+IG10a19oZG1pX2R0X3BhcnNlX3BkYXRh
IGZ1bmN0aW9uIHRvIHRoZSBuZXcgbXRrX2hkbWlfZ2V0X2NlY19kZXYgc3ViDQo+IGZ1bmN0aW9u
LCB0aGUgY2FsbCB0byBtdGtfaGRtaV9nZXRfYWxsX2NsayB3YXMga2VwdCBpbiBib3RoIGZ1bmN0
aW9ucywNCj4gd2hlcmVhcyBpdCB3YXMgb25seSBjYWxsZWQgb25jZSBpbiB0aGUgb3JpZ2luYWwg
bXRrX2hkbWlfZHRfcGFyc2VfcGRhdGENCj4gY29kZSBhbmQgZG9lcyBub3QgbmVlZCB0byBiZSBj
YWxsZWQgYSBzZWNvbmQgdGltZS4NCj4gU28sIHJlbW92ZSB0aGlzIGNhbGwgZnJvbSBtdGtfaGRt
aV9nZXRfY2VjX2RldiB0byBrZWVwIHRoZSBzYW1lIHNlcXVlbmNlDQo+IGFzIHByZXZpb3VzbHku
DQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBGaXhl
czogNzQ4NWJlOTY3ZjdmICgiZHJtL21lZGlhdGVrOiBtdGtfaGRtaTogTW92ZSBDRUMgZGV2aWNl
IHBhcnNpbmcgaW4gbmV3IGZ1bmN0aW9uIikNCj4gU2lnbmVkLW9mZi1ieTogTG91aXMtQWxleGlz
IEV5cmF1ZCA8bG91aXNhbGV4aXMuZXlyYXVkQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMgfCA1IC0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2hkbWkuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5j
DQo+IGluZGV4IDg0NWZkOGFhNDNjM2M5MTY1OTgwOGQ5ZTZiYjc4NzU4ZDFmOWI4NTcuLjBhYzRl
NzU1YmRmOGFhY2U3NjZmZWZmYTU3NzEyYThmYmY0ZmY3OTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfaGRtaS5jDQo+IEBAIC0xMzQ5LDExICsxMzQ5LDYgQEAgc3RhdGljIGludCBt
dGtfaGRtaV9nZXRfY2VjX2RldihzdHJ1Y3QgbXRrX2hkbWkgKmhkbWksIHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWMNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpjZWNf
cGRldjsNCj4gICAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKmNlY19ucDsNCj4gLSAgICAgICBp
bnQgcmV0Ow0KPiAtDQo+IC0gICAgICAgcmV0ID0gbXRrX2hkbWlfZ2V0X2FsbF9jbGsoaGRtaSwg
bnApOw0KPiAtICAgICAgIGlmIChyZXQpDQo+IC0gICAgICAgICAgICAgICByZXR1cm4gZGV2X2Vy
cl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBnZXQgY2xvY2tzXG4iKTsNCj4gDQo+ICAgICAg
ICAgLyogVGhlIENFQyBtb2R1bGUgaGFuZGxlcyBIRE1JIGhvdHBsdWcgZGV0ZWN0aW9uICovDQo+
ICAgICAgICAgY2VjX25wID0gb2ZfZ2V0X2NvbXBhdGlibGVfY2hpbGQobnAtPnBhcmVudCwgIm1l
ZGlhdGVrLG10ODE3My1jZWMiKTsNCj4gDQo+IC0tDQo+IDIuNTAuMQ0KPiANCg0K

