Return-Path: <linux-kernel+bounces-849033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF548BCF0C8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56229420D04
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0ED223DDF;
	Sat, 11 Oct 2025 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ejALSkTa";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="M+ChKbCo"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FC63D6F;
	Sat, 11 Oct 2025 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760166403; cv=fail; b=WMwQhas9Wn4ppmbqfsIiTCyIaX9h1nCvM2QXQCLJdecb1PoSdhveviIe6FJQk1MfBMVGa5HGdgxpwMeu6U9gtOR49/fj/qZaZK2ZCPMgKE+Q1f7sq44hy4VbRZUlt+/ME0Uu8gJl2u6CGgAAZcUUuqnsDEkisYg4nlscSm+NAzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760166403; c=relaxed/simple;
	bh=phibxyAAs8/C/OxzHhTYtCAG26YO6XAJhnEeqxz+PLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PYa8lekx8Z38TA1L67sCVQn4VY5NR97HEhrLAWHiN7IXultTazb7RQJP2W2YpuRziz1RmGLwInlhFrvJ3jUVrw4tzZQcsMkRGNgdGkUgnQwkRAGH1Ei8rHrYIaHM52w+XLqlMO2usg0pmUkYkdHthEKCKO28rr+zZFEGly5Eh24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ejALSkTa; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=M+ChKbCo; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b6a0e1baa66e11f08d9e1119e76e3a28-20251011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=phibxyAAs8/C/OxzHhTYtCAG26YO6XAJhnEeqxz+PLw=;
	b=ejALSkTay/nYNCfJgMp0Mxm9E9d214CSEK25UPlwRK+Pem64BUT04YGh5Un/BQePI1GDVfyc+UNBE2ChWMYi7ix+AJ6C4CVAidzt+rRgBEvayx6wooiAmIgSn+xMMa3Cg+SR1dfcHr7QMC6Qk9D+S/lFvywRSjBReBopl6xIHwg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:4d639d34-f85f-4362-a7c9-d282651cf2b5,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:9e750cb9-795c-4f99-91f3-c115e0d49051,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:11|97|99|83|106|1,File:130,RT:nil,
	Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BR
	R:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b6a0e1baa66e11f08d9e1119e76e3a28-20251011
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 221349395; Sat, 11 Oct 2025 14:51:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 11 Oct 2025 14:51:26 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Sat, 11 Oct 2025 14:51:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDcRkB8Wb0seYFcaTi8N3wCZUmLlQGnTnuNvc8Khs366EWylZJXO6QgrlNPHlr3AGvWsEL5mQS291N67ANCrz0KxB1cmi2fibFwJhqUVC59qYk0lZr6B1biKD7edAUdPvlFj50V8uLiPTxhje/mfNEmck79Vrmklfoy4U+fV/vQJO6oNb4UOwYytRojO5KDYaaQ9/BWBAzLYS+hq3/7CihT8NaPvhi0ndHVqlfNsKzleGaB1JHOG9lbElmjGLopoqCpTHrPPVL5b9bzlJYGWeDVY02jUTcsUzhOJLpeen0tmtlXrGFNbbONNPwWRHOLLNtaZDM/K6NmyMii92vqXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phibxyAAs8/C/OxzHhTYtCAG26YO6XAJhnEeqxz+PLw=;
 b=WomgrxGLuIT8aAbAeYSlTsqR39xsuisYrnIYy69NcYs4A4PDvOA7SS2RydZLfvEFVc9St6UjATXrDU8GZ27Cf1s1XoJkG3StPS6w681qdIqLvPQynkRDT1mvUr9hzVh75x44afK0pRE4Gtmi0lfOD5oTtVgV8X9gTKZdxGn/gi3u9zZB8IAS1kYxBW1JSgK5V01QfklGOQau+mQ2KWJ5LBF23wJsg+kH4ryKyM+/IDsjOsKDAYrSlWZwlPgq8cz2UtX++dXrpF4YUdcNpJUpq5RJEwKHY+tfuZIYItWwKoWmuk4Whw8aA7YSoQ1RvXuWT7tLSTBbpKlB07VeopaUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phibxyAAs8/C/OxzHhTYtCAG26YO6XAJhnEeqxz+PLw=;
 b=M+ChKbCo1i8maHcg7nDPmguObWPUXj8aOE3rs3Ke0IAtVNA7+GwF6Cg3wZn7fJ1Zic0sISpn/sySA+dnMZe2gy+wubRptVRzeor3R5+fj3cVebQ3yhMEl6cC336IS+5bMe6ilbJGKKyseE9YYzjpWONZFBtUxX59K4DkaMYyC5E=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by PUZPR03MB6855.apcprd03.prod.outlook.com (2603:1096:301:e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 06:51:25 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 06:51:25 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: mailbox: mediatek,mt8196-vcp-mbox:
 add mtk vcp-mbox document
Thread-Topic: [PATCH v8 1/2] dt-bindings: mailbox: mediatek,mt8196-vcp-mbox:
 add mtk vcp-mbox document
Thread-Index: AQHcOcazFbdUoMD+aUWITgR7vSbs3LS8g1yA
Date: Sat, 11 Oct 2025 06:51:24 +0000
Message-ID: <9a7d9264fe4914ce58031e08710dfd2453678653.camel@mediatek.com>
References: <20251010091549.21325-1-jjian.zhou@mediatek.com>
	 <20251010091549.21325-2-jjian.zhou@mediatek.com>
In-Reply-To: <20251010091549.21325-2-jjian.zhou@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|PUZPR03MB6855:EE_
x-ms-office365-filtering-correlation-id: 823c78d3-60bb-4e3c-aa13-08de0892981c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?T0JZaks1SldiUGUxZTd4cTVUUDBOdFZxVXE5L0YyYWZSV2ZaR0RJSVZUaG04?=
 =?utf-8?B?ZHhkOFBvK3dZb09wV3pYTWwyai9vWEtYSmtXV0dnN1c3MmMxdWZ4bzd5NzlC?=
 =?utf-8?B?MXRQNk50TW41M09JUitjRGZDMWg1N08yNWhmb2dkbTY4VUw1NmgraUpPTXRL?=
 =?utf-8?B?bVNkRUFXUXB2SFp5bktWWWxidnJSeUxtb3F1RFRpZzdKeXBZcFlRSEFtdTQr?=
 =?utf-8?B?MWcvYXFjOUNVKytwUmdydkp1bG1CTFV1b1UvTzljVVNKMlZzdkRGd0FhWndM?=
 =?utf-8?B?c3JYQi9HRzFzcWxIZmg5dThmQjhoZHM4K0l3U0FsZGpoSHNoQ0ZSdEh5Wk9w?=
 =?utf-8?B?SkVhVFFEMnFRamJqbXBBL0QwQW1zRzFENm1jcVpsY3ErdlNTeU0ycjZVNFZD?=
 =?utf-8?B?bkZudjUxcThvS095OUxmaFU4bVBHN201SUNPT2ZLckloK1VTS2dOdzNvckc3?=
 =?utf-8?B?bUtSVGJicHBHYVhza0xTRHhuV0pJaE9qZTBDNEN4cTlKRWwrZzdVV3hRZG5V?=
 =?utf-8?B?cFN1NUl3dDQ2R25wSU9Za0Q3YXR5Vkt3SUp4WkF4a2Z1Q2h1YWJnWGl0Wm9E?=
 =?utf-8?B?Y05QL2lXNld3akJYNVBjdzdHWjQ4VThJZEZkZ3F6Q3RBTDhhNnVkMHA0KzJT?=
 =?utf-8?B?RldjOXNCK2hmWWdNY3ZNWGkvTTRaRHVWd0NGdTQ4enhqeDZJaGpFYVM1ZndQ?=
 =?utf-8?B?dEdSWHFVaXhBR0I4QUhobTA0d09wTDRKVnBUOXBzTlNmUjQ0TjdKQzY0M1NX?=
 =?utf-8?B?Y2UzazgxRUNvN1lmRWczSWFoS0xVMklqcmlQaXFuVHRaaXBuMFBYNTR6T1k2?=
 =?utf-8?B?bnJrRW1DRm51WjdKbVcwRlk5dkFqYk5QK3VBVTNDTW9PUjBFRGdMRXpMSXVG?=
 =?utf-8?B?amdQcUF6TFMyY0tBT0MwL1VnYUIrci84VTlWWDdvQTZocW5KOW9JYWlyUy9u?=
 =?utf-8?B?UU0rNFZNM3FzTlRrMXpJSG5yVjhYbmR1K29XMUN0OU9Ya2VsMnhKdzVldnE1?=
 =?utf-8?B?VHdSOVoxNDFIZmhkaG9MMzhoYlNrdHVtRXJ5TWtONFVDVGJGT0NWMllIVWZr?=
 =?utf-8?B?S2dFT3Z2dE9sY3lKV1FIdVRadlNETm9DOHNYZWJNd25sUWxtK3RmaXcwN2J4?=
 =?utf-8?B?WmlzQmpNaTY2bG1XeW8ybVdxVUtrOVY5TUg5VUZ6V0pMWGxaRlh6UWpnd0s0?=
 =?utf-8?B?NjYvMVRYc1dmUHdTaW9oK0lEbzFJeXBVM1hEU0c1eUo4bGpaeWMyVkVYNFl0?=
 =?utf-8?B?eEo4R2NyL2FwQXhQbVRlY3BkT3NCeXM0UU5VeGhFRmRITS85ajljK3J0c2c4?=
 =?utf-8?B?WDJiQ3BTa3QrV2Q1QWFPdWoxdVB4VGhwREEvQXlyQk5ZRDd4OU1uNndieTdR?=
 =?utf-8?B?ZENzTGZmaHZMSVlCV2MyRW5iUGwzRW8yOVk5QTRuT0V2N0xBZVBFaUVlYjYw?=
 =?utf-8?B?K2hFaVF4eXJHbUZteC9DQzJvSnFMczBXMXgxMEdoNy80ZlRzSUpOWDlPR1FS?=
 =?utf-8?B?bWh6Yi9MWm5rcFg2eXVINjhaRDJscXkyK0IvQUtHL0VkTFNLZjd0aVQvRm4v?=
 =?utf-8?B?cndZRmdFUytBVVpWSFFhZFZXQ281Qk5hcWY2a3lTU2FIa1F6OGJPYllXbDVw?=
 =?utf-8?B?Qkh1VWNRdFVaK0pWK0o1ZEhlYk1xWjdCdXV6dGFaY3dJNis1SzBQL0pGQkVu?=
 =?utf-8?B?N1BXRVR1ZUpZa3I1bEVtMHdKOTA5enUvRC8zalpKOHhxYzF1WGhsaWw1WXA2?=
 =?utf-8?B?RzZkMTNwSmdzY1dvTWxnVFhwUWNUb2JTK1pYUTlwQ1lnMVJtUVByZTZqVTV0?=
 =?utf-8?B?SVJKalRVYWhFSUIrTFAvNzBsNEhGMGYrTVg5aTZmK2VZaUJ3QTdxMWtORHg2?=
 =?utf-8?B?eEx0R0ZubVdabTdUSWMzSVY3dDBKSEpUTzZZNzJ1TDc4WU5tNjN3SytNOWNi?=
 =?utf-8?B?V1REMmQxTE5hZTRoYXhnTm5pemQ3TXl6d3ZuNWp5eFVzNlJrdVdTKzdvY2Vr?=
 =?utf-8?B?S2pieWszMzFnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1VuVjBXS3dyMnA4b0pBaW50bmNxV2RCWjhHL0tzZkRZSG5LQWJJTUNEOTZS?=
 =?utf-8?B?SUZibHVVVkFJSjcrdUI0UlFWQ1ZMbERIYXIzWVY2ci9uZ05DdVB2TWlEYUhx?=
 =?utf-8?B?YXowNEVmcmRET0ZaUDlZbEpBODMwRUw2U2g3MVhqWVpIWUJDd1QyenhHL1dk?=
 =?utf-8?B?Y0JZRndCK3AxckVGb3lSM0N0YnpDblkwd01mZlJYa25XUUljNUhXdjZQQVll?=
 =?utf-8?B?MFNTcFMzbStJVWtQOFNFZ3Z5NjllRG8yK1ptRVZVcmJmLzhyZnlZRjRLOGZK?=
 =?utf-8?B?U0hncFJ0Q2lXaXF0dnVMUlkwYUZzQlp6eFhTbnN0SU9NTWZ4bXdrdGxoMGpx?=
 =?utf-8?B?cEF5dkg1NXJJd25WV2NlWHp6TVlXVFoxaEhpeFU4ZFVMcHNkcDBCM3FtQ1hU?=
 =?utf-8?B?bFFoQzFPUGxnaFFDWVgrcndOUm9VN1Q2a0dzbXFhd0dPN3RTYWl6ZDNZS0tj?=
 =?utf-8?B?bUZpcmpWMjBUUDl0L0cxZU9qMFVFdElyK0tyT1VIc2JuOWQ5UnJGZVpIeHUw?=
 =?utf-8?B?eXlUa0ZSaVhiZ1BXOU4yYkpvdjFQNW1YMU02dXFTZHpIM0d6QXo2VFBGakx2?=
 =?utf-8?B?U2pJQys2YzhWNzhiUjA5R2Q5YmVRcytrTWlnUDQ1QlhkcGh1cHdZd3pwNVZa?=
 =?utf-8?B?YVlyaUEzVlZYVXJySFBBcDNES3hTYVVLS3pqZGNISytqdktiSWtQaitFZit4?=
 =?utf-8?B?c2J3TXh1S2FOVjdjeFk0VU9qcFZIR0JvNks5RmxoUDhXV0k3dUpuM2Q1WXNX?=
 =?utf-8?B?Y2ZGRzNXaUVzNDZIb0d6WTJvZkg3aEhPWlpleFN4azRCdlRqK0tVTjAzc2tx?=
 =?utf-8?B?akp0RVB5TVRFZXIrdnl4cmhPaGt5blo5TzV6L3B0RFpBK0t4RVVUQ0E5dGRv?=
 =?utf-8?B?TGdGNVBpL2lra3FXKzlJNTRlUzR3M1lNZjcyRVBRcEE3dVVNR3VPQVpOckZF?=
 =?utf-8?B?MHNhN2lGa1RWaGVCRFZJZWZZdjBhK3V3ZHRUOEtjTXR4S29UeVdNeFUrcDl5?=
 =?utf-8?B?Sm9vNU5kTmdpNWRkRjM5bDlULzJ0ZDZYbXJtY090UC9rM1RNbDVya2pZUGVl?=
 =?utf-8?B?NThqcWhQTlVoaHFGNXN0dzFrbklHbmxNbXpJZ083OWtvRWNxTEF6T1h6NmY0?=
 =?utf-8?B?RVJKVVR5VHRuSHpGcmRLSEpTQ2hvVTRoVkNSOE5Nb2h4T0E2OHpQVGFzTk9r?=
 =?utf-8?B?RHBId1luOEsrUG9vdUVzWG1YNjFDVjBuY2xkYUpTWnZ5Q25zckdhUmlvOFdZ?=
 =?utf-8?B?b3Y4R0xuZko4VEJTcU9ENW5wd1RjbDJSZEtWU1VZbk9wcitJRWF5eFJDeHoy?=
 =?utf-8?B?YkEvU2tLd0pQTkVqdGdaUFdzQlQrcmJOVVZNMkdQeXdBMXh1K1hYN3RwSXdO?=
 =?utf-8?B?ZXA1L25xWlJ0K3A4bHBoWkdvTlpNbVphSmlERVF3c0RhS2F1bTZtRGNzYzBp?=
 =?utf-8?B?MUhjL0dWVU9CTFc1U0pkVHhzeVZzdWxleVJ1N1FYcnlESlM3emtQdS9wdlFJ?=
 =?utf-8?B?dzc3Ym9oT3BVYVpTa2xSOVNPbzhieWJkL2NrVDZhUk03Y2JWdFVIY1llb3Ni?=
 =?utf-8?B?U0djQUpzVTJndHdkUWZkT08xWTV0NE5qdHFLZmo3MzZSclErMSsvK29lWlg1?=
 =?utf-8?B?VGpDYVFMWGJPODZiTEZqWFIyUlpUOWJMY0VyeFNYWk9RSCsyOXI3emFtdGtN?=
 =?utf-8?B?elFsNkF4NEU3MC9HM2hrQ1hzWC9ZNDBqMEJ1TytWQk1lOTdZaHJZT1d0WXJV?=
 =?utf-8?B?N3pwTmpvZDJkZGRQcnF5Vk9WQldiODZqaG03d0hYMkI0SmtLVHAzbm5DOVBC?=
 =?utf-8?B?Ly93Um1rdExNcG9DZ1RRanFlekUzalNtZWNNc1lYaWIzOVZaK1pKZ0VraHBG?=
 =?utf-8?B?TEV2ZFJ2WENyMlQ0R0ZBbm9raVNhTDFoSXRmQzVscTNLZzNLRWFweGpSVXly?=
 =?utf-8?B?TkVPUWVsL0pka0s3SEltOXpzY1NaOUlseDBxN3FCQjJzYU9objJvZFBXRTd2?=
 =?utf-8?B?SldqN1JkRXd0NnJBMW4vQlpqd2sxaTcwWkdCYzFKSkttNks3SHRHdFViZ1E2?=
 =?utf-8?B?bDk0bUxEZzNJajNmSDJmQW5XNUxKTXFaS3BCU0E1cEs4WjZyT1ljUHdKSytR?=
 =?utf-8?B?ZzB5QTYydzEvNGM1UHJrbVBhdnFlc1NwSlhaMUpxTEl0NGQyUHBRb2V5ZDhq?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <612B866F331A3C4D8B73586DB56285CA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823c78d3-60bb-4e3c-aa13-08de0892981c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2025 06:51:24.3209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pw3eTAbcCwyDaxOIGREtvsZIsZ4dCTOVE9/Z0dGpvwIkZVcY6b2xc6WUlPmVr/iG1mTSwNACdIOi6Wd3AqKR+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6855

T24gRnJpLCAyMDI1LTEwLTEwIGF0IDE3OjE1ICswODAwLCBKamlhbiBaaG91IHdyb3RlOg0KPiBU
aGUgTVRLIFZDUCBtYWlsYm94IGVuYWJsZXMgdGhlIFNvQyB0byBjb21tdW5pY2F0ZSB3aXRoIHRo
ZSBWQ1AgYnkNCj4gcGFzc2luZw0KPiBtZXNzYWdlcyB0aHJvdWdoIDY0IDMyLWJpdCB3aWRlIHJl
Z2lzdGVycy4gSXQgaGFzIDMyIGludGVycnVwdA0KPiB2ZWN0b3JzIGluDQo+IGVpdGhlciBkaXJl
Y3Rpb24gZm9yIHNpZ25hbGxpbmcgcHVycG9zZXMuDQo+IA0KPiBUaGlzIGFkZHMgYSBiaW5kaW5n
IGZvciBNZWRpYXRlayBWQ1AgbWFpbGJveC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpqaWFuIFpo
b3UgPGpqaWFuLnpob3VAbWVkaWF0ZWsuY29tPg0KPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBSZXZpZXdlZC1ieTog
Q2hlbi1ZdSBUc2FpIDx3ZW5zdEBjaHJvbWl1bS5vcmc+DQpJIGZvcmdvdCB0byBhZGQgIkFuZ2Vs
b0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCmFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFi
b3JhLmNvbT4iLg0KRG8gSSBuZWVkIHRvIHJlc3VibWl0IGl0Pw0KDQo+IC0tLQ0KPiAgLi4uL21h
aWxib3gvbWVkaWF0ZWssbXQ4MTk2LXZjcC1tYm94LnlhbWwgICAgIHwgNDkNCj4gKysrKysrKysr
KysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKykNCj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJv
eC9tZWRpYXRlayxtdDgxOTYtdmNwLQ0KPiBtYm94LnlhbWwNCj4gDQo+IGRpZmYgLS1naXQNCj4g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxtdDgx
OTYtdmNwLQ0KPiBtYm94LnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWFpbGJveC9tZWRpYXRlayxtdDgxOTYtdmNwLQ0KPiBtYm94LnlhbWwNCj4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi43YjFjNTE2NWU2NGUNCj4gLS0tIC9k
ZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJv
eC9tZWRpYXRlayxtdDgxOTYtdmNwLQ0KPiBtYm94LnlhbWwNCj4gQEAgLTAsMCArMSw0OSBAQA0K
PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1
c2UpDQo+ICslWUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOiANCj4gaHR0cDovL2RldmljZXRyZWUu
b3JnL3NjaGVtYXMvbWFpbGJveC9tZWRpYXRlayxtdDgxOTYtdmNwLW1ib3gueWFtbCMNCj4gKyRz
Y2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiAr
DQo+ICt0aXRsZTogTWVkaWFUZWsgVmlkZW8gQ29tcGFuaW9uIFByb2Nlc3NvciAoVkNQKSBtYWls
Ym94DQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIEpqaWFuIFpob3UgPEpqaWFuLlpob3VA
bWVkaWF0ZWsuY29tPg0KPiArDQo+ICtkZXNjcmlwdGlvbjoNCj4gKyAgVGhlIE1USyBWQ1AgbWFp
bGJveCBlbmFibGVzIHRoZSBTb0MgdG8gY29tbXVuaWNhdGUgd2l0aCB0aGUgVkNQIGJ5DQo+IHBh
c3NpbmcNCj4gKyAgbWVzc2FnZXMgdGhyb3VnaCA2NCAzMi1iaXQgd2lkZSByZWdpc3RlcnMuIEl0
IGhhcyAzMiBpbnRlcnJ1cHQNCj4gdmVjdG9ycyBpbg0KPiArICBlaXRoZXIgZGlyZWN0aW9uIGZv
ciBzaWduYWxsaW5nIHB1cnBvc2VzLg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRp
YmxlOg0KPiArICAgIGVudW06DQo+ICsgICAgICAtIG1lZGlhdGVrLG10ODE5Ni12Y3AtbWJveA0K
PiArDQo+ICsgIHJlZzoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgIGludGVycnVwdHM6
DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICAiI21ib3gtY2VsbHMiOg0KPiArICAgIGNv
bnN0OiAwDQo+ICsNCj4gK3JlcXVpcmVkOg0KPiArICAtIGNvbXBhdGlibGUNCj4gKyAgLSByZWcN
Cj4gKyAgLSBpbnRlcnJ1cHRzDQo+ICsgIC0gIiNtYm94LWNlbGxzIg0KPiArDQo+ICthZGRpdGlv
bmFsUHJvcGVydGllczogZmFsc2UNCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAg
ICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+
ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0K
PiArDQo+ICsgICAgbWFpbGJveEAzMWI4MDAwMCB7DQo+ICsgICAgICAgIGNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTk2LXZjcC1tYm94IjsNCj4gKyAgICAgICAgcmVnID0gPDB4MzFiODAwMDAg
MHgxMDAwPjsNCj4gKyAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDc4OSBJUlFfVFlQRV9M
RVZFTF9ISUdIIDA+Ow0KPiArICAgICAgICAjbWJveC1jZWxscyA9IDwwPjsNCj4gKyAgICB9Ow0K

