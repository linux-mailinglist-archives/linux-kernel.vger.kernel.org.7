Return-Path: <linux-kernel+bounces-873454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FA6C13F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA14619C2E57
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2944304BA8;
	Tue, 28 Oct 2025 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LQfDa1BD";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kSSkXTsu"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4223019C3
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645347; cv=fail; b=YyOQPUS7vf/fQBHiSebxLM7Q8TeGcrxjJ5v0JoQeNYgygWndabiB2NJd+6DUNFDpufEX4jGpuNsmTOlXnmiXXyMA7KfJyS0+IORIBIxATlcYpm63rs9SMqZbn/hfNMpstOHWGx8cDwdL1NLxLhQri2bTqqZB8K0Uzld3UgF3EIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645347; c=relaxed/simple;
	bh=q0CCsSbvS/iTOEGaryFGXEj7V47oyY0ktac4nY+QC8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TW/QVGRq58uqlkobRb7eSHqg8DFSMQwzoLlQZxRhfkZLGkbDoYp5bj2MrIch7FxnUeIaFlavTErtm7Brrb6Op0O3FZh83/ZMlnnvnbaEf6Ibww8WPL9hNKltpX9+Tbk4P4KCi0f/H22F9tO2VcGYk5n4Qr9KSWAxOv98oCyzrHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LQfDa1BD; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kSSkXTsu; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4138072cb3e411f0ae1e63ff8927bad3-20251028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=q0CCsSbvS/iTOEGaryFGXEj7V47oyY0ktac4nY+QC8k=;
	b=LQfDa1BDciozI1bsXAZCpsAFmheXjaC8FAXHLTQtFlrFzS8YKGuMV2WXKWdqXRTnhv4wbw3JIvEUStN/XK0rgaHpZ5ubbAU4c3oTaHDUQlb2WH4xWyrJcKZ7PT8Hy2HVbmH6TlXqr3VQferYtPflwWeCC5TA5VdHKE0oZAlPSZk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:80260c3e-bd58-4de3-ac94-62f172af9b68,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:9e9ae858-98d8-4d0a-b903-bc96efd77f78,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4138072cb3e411f0ae1e63ff8927bad3-20251028
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 535119921; Tue, 28 Oct 2025 17:55:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 28 Oct 2025 17:55:35 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 28 Oct 2025 17:55:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHzZ8mvhtbIJSRXYQ1oXpdGrrB22i+p2LN3ocHR5IV598QjFX+WqIlHUSfFJEVXwITy2/LbNzpAfhfyavEs9nZ5KrZpLXA79EK9PvAjRj2pOJsLNuERpPfK5XueWMm4uu1s/vxwlQ9KQ1omPghShmvAERGM+yJBdHE/iXwFcRGwPPlOAVpVUGegphRG5N6NpETG8NAGy8oMptdMNuKJ2aQMuqvjMOS03fG5vzisVFiCmnabeojotJ7zDQi1GcaIiN31BrBEaY/eHxSVz4fxDfGVvPTa02U4hPcdnXyqdzWTk/b/LdRBZLIwCXFCthS5CG28/8PDcn0sCmpvxD5eTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0CCsSbvS/iTOEGaryFGXEj7V47oyY0ktac4nY+QC8k=;
 b=GXSyVwhTYAh1elBsJR3x1XCsMlqXYkdBf3sM+KAH5nr4orHbhfJu92+7qAU16JbqWoAy4VAr9eDnjBJCoOzhIw4ghNpLCfxl9/Dxg1LjBFCAhzXMqEbImUKqtKPwGbD/YfCkO5OttLFVV4JBEcGPzVAKK6udfhtHAQORv1jZB91YtSqVF6IBDxyKCC7rvzSRmD1/C4bXq83/FWPmCGx4i0JifVAyIkcrc943qD9lBp2sUvWteDh2y2JNcjoqrl6+xLtzJhH9u64JjsWQbYMI9rnp0YU1SdmYOvTHRUeP71U3LP45Uaem3bfXAGQxJ2t5UojP6aznBETulsj9srKRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0CCsSbvS/iTOEGaryFGXEj7V47oyY0ktac4nY+QC8k=;
 b=kSSkXTsuzQ/UcZ1FUN6gbyh3KIwUzZeZTNEwLDgCGn64Vn9jI6gTKpcof+elFzCOKdYuuzHyjDbfipi7l5nwtXW+7vBTIHrih3rRxjOJcFJRBwtWxsltyIIvap6JH1NoDnbI3umtzFmjCh+wBxp9Gsc6H0Yp2ogv4lSptY9dDFk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI6PR03MB8656.apcprd03.prod.outlook.com (2603:1096:4:250::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 09:55:32 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 09:55:32 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: Alexandre Mergnat <amergnat@baylibre.com>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "dmitry.osipenko@collabora.com"
	<dmitry.osipenko@collabora.com>, "kernel@collabora.com"
	<kernel@collabora.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "djkurtz@chromium.org"
	<djkurtz@chromium.org>, "granquet@baylibre.com" <granquet@baylibre.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "littlecvr@chromium.org" <littlecvr@chromium.org>,
	=?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH 2/3] drm/mediatek: mtk_disp_ovl: Enable/disable interrupt
 on bind/unbind
Thread-Topic: [PATCH 2/3] drm/mediatek: mtk_disp_ovl: Enable/disable interrupt
 on bind/unbind
Thread-Index: AQHcLT9GuNYNU3Ubv0Kn5+kxhOZSCLTXh4AA
Date: Tue, 28 Oct 2025 09:55:32 +0000
Message-ID: <79e1cb6b8ddbd027096cc7f1d6a6f32ba4fbfbd9.camel@mediatek.com>
References: <20250924103708.19071-1-angelogioacchino.delregno@collabora.com>
	 <20250924103708.19071-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250924103708.19071-3-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI6PR03MB8656:EE_
x-ms-office365-filtering-correlation-id: d262240e-440a-4b85-a46f-08de16082286
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|42112799006|7053199007|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NHRESENobEZsdEVGZkw3UWlNMXlzUFhPcVFOUGwwd25PNGUrTWs1WlBBNGJk?=
 =?utf-8?B?SS9iRFJLRE1LTHcrMVVlNVI4YnhpdEEwTTRWVm9oN2V0YTJGUFpPa2Zyb29W?=
 =?utf-8?B?d2xoRy9oSURKb2VFckZEVjhGT1JKWkI2UDNKR0hHaTcwTlhRU0JRckoyR0ZK?=
 =?utf-8?B?b1A0WXVvOFJHSXlBV3p0ZDNMRzlERVhBVTZyOUQ5VG5qcmpoTUZscUdNQkJI?=
 =?utf-8?B?K1VHK0k4YUFUbU5FM3VKNSsxa2JjRGszZUZpNlErdFM4Y2x5YlRzS0V5QTBw?=
 =?utf-8?B?N1BMTTE4MEVHN0xZc2RCbytHcVB5YmFSSVV3Q0c2Z1liYWp6YnlIUitkVVhI?=
 =?utf-8?B?T0p5NkYrRUE5UkwzQ1VTM0pVdnNmQ1RucWNtSnlCMUJ0VVFmeWZVcFFseFgy?=
 =?utf-8?B?UDdUUkV5Q2tPZDRvd2psZEpPQjhUL1FHTmlnTDZIZEJ6d3VKTVVNYXVlY3A3?=
 =?utf-8?B?VDBwdWNRQ1pnNlhjR3JEV24vNFd5dDljRDBMRkVTMC9zQ28vV1pPYkQwQmNr?=
 =?utf-8?B?cFFpVU9jSDlWdHJ3VzFHU3N0SjFHZU4yNmNvZVR1dkM4R2NKc29GTmN6cFlo?=
 =?utf-8?B?NTg4RTI1b2J0RUxHaDR3bVRrWHAvekVJVncxTnROWkQ2MXZzTm16SitPV2NO?=
 =?utf-8?B?dUJ1YTFpTm9yT0thbGwwTmJJZFpUTGVoWFR6WE5xYnRqZ0VaREFjaDRFOEpZ?=
 =?utf-8?B?TzBhRHlPUzgyWW1NSHpmQlZoUDVqM0VaSnZpS3JXb1hjekUwY0hQUWFVak9F?=
 =?utf-8?B?bmJhTVF5cVdvZmJHdHlvQlZmb1h3NmIrb1VqTitkZURrZVRGQXFSemZtcjZB?=
 =?utf-8?B?Ymd2TlhqS2xqWWxCVFp2clU2d09hNC8xaGk1aFB3TXBjWXIrVmRCUHB2NHZC?=
 =?utf-8?B?NFY2TWlJUGtlY0crN3hmWFFNMmdSZGlaaWNlSFRqaDBud3dVVUsvRlVPMGxn?=
 =?utf-8?B?bDAyelN2L3BEMmRja3FOWG4vYzhuOUljRFRGcmt0VXBPSVZPc3dYV05nY3VK?=
 =?utf-8?B?UkVvTWlUeWlrSVBGSy9Td2pCT0dFL21CRzBzMjJHdnA3eEJqWGFYRjdvWHg5?=
 =?utf-8?B?TmJCcEptalBHS2tOcVo0dTF6MENTcTVRRFRwMWhoSmJCT1NvMVRoWnk1MzRa?=
 =?utf-8?B?bERSM2tiYUJRckRNN2ZHbFBLMGtPSkdicE8rTldRTEFCc1U2bkJmcDl2WGdK?=
 =?utf-8?B?MFBCelBtNkNFYVdWRWpKRHZCNThMODJTa0I0TzRIUTdyYnZMSlUxM3JXVWJ0?=
 =?utf-8?B?ZCtlRzRHakxLVmtNWFRCQiszMDNhZFh1ZVpabElFYlNEL2IxQ0kvdDBaSEFw?=
 =?utf-8?B?Y1hVYTNUNGFsWjd2TmtlYXU2RG1hSTlFbVlKTWJHTWFxbUo2cFM4QTFGdTll?=
 =?utf-8?B?OW1jTmR5MW5ONDI2TzZwejBnN0NmY1NzUjF6SllOcEV6ZzRBbkNBN2xKTlhW?=
 =?utf-8?B?QkgvVzVOaUVaaklGbVczK0gzbkl3WlN0M0VFbkZjUkRUYkp2SWdSc2JrVk4w?=
 =?utf-8?B?MHVzdUZYckFvWHVzWHNUYXlYTVRBU3QrUUxTeWd3NlorMU1WN2pqVXl3TWxR?=
 =?utf-8?B?NlIyanAxUlhTVDJrZnJjUy82Z1h5ODdsalZGcmxIbEpRL0xvNHQzTWh2cEtr?=
 =?utf-8?B?NmFiUGh4cXlyOE9kSnZoRkx2amh1NWFzVlNPMEpDOGtDTHdYYWlZZG1iRDBT?=
 =?utf-8?B?aEV3QnJUTldDdXpjeHBxb1l6OFZ2Z2RHYm1mdUVtQk94aHlValVLbnRrZGIv?=
 =?utf-8?B?V0l5clVMWktxRTBwTzNFdzBJUDlvZU5naU5yeStrQ3JYSmo0emF5bVU5eDM5?=
 =?utf-8?B?TWszZjM0SG9xMTRLSXQvZjBHUGhYczc1UjArRGU4V1NJOEhqdldGU09lcDRr?=
 =?utf-8?B?dlVRSVZ1Vk1UREJsc3dwUVlhdHVDYjhLblE5dklhSGRBWEs1cmtYeC9nb2VP?=
 =?utf-8?B?U2c5VnNkVGNjSWhUVndmS0FZSzJVQVZEenA1NldVc2o3MUxkRGJvOHR2K2Yr?=
 =?utf-8?B?VlljclJBWk10YmhvM3JuY2VRT2tDVVdsZEdFUHl6MlQ5Y0ZxQXlCZ1hLZnl6?=
 =?utf-8?Q?Vl7cjj?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(42112799006)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWVDQy9sRWFZWERaYUtUQTA3UTl5Z2Z6MGRVYTlvbFdaOXR5TEQvaDJBc2Y3?=
 =?utf-8?B?Z3RiRU95R3kxSW9QVkhTblp5UHE5aVdlTVZnTGg4QW5oOUQwbENSQTZXaXZ4?=
 =?utf-8?B?MjVhVjhPODE3TGQzMjNtampxSW1KVUIzdnhNT1NPMlluWEQ2bER0RVBWVnJ4?=
 =?utf-8?B?RUwwYmtYNVpqNWg4UGphcE9ybzdKTXZ5Lyt6OHR2ejN6R3dISEJteFhjczdw?=
 =?utf-8?B?eDJ1SjhUYWFVaXhlbkMrdllkTk9yUmJPZzlnc2J4bW1PdWVBd0swSktTbjZn?=
 =?utf-8?B?YVZJQU80VjF6dlNWTWlpZEFER1h3b05hcGlyK0Rvc3Y5V244VVp1TVhmUGwx?=
 =?utf-8?B?KzVPZXFQZXhQcnljYWVVY2dNTkl6TGlJR1E2TXViVXdUQVV5SWxqQ3FET1ps?=
 =?utf-8?B?aGFPZXVjTGtidVA0ZjJNT1ozS0psKytTRjErNEpkTGtGdHJKT2U0MXhSWXVN?=
 =?utf-8?B?ZTlUcUdWbkYzWnhIQkMya3pkVkorM3QyMjkrY1JrdmtGN2trYnVtNWpYc0tR?=
 =?utf-8?B?WXFKdWYxSUNyV1M4U2VCZlVXS3lSdEl6dXRLWGQ0a0xrY0NJSlRzNVNwTGV3?=
 =?utf-8?B?cCt2eitPN2t0TnYyczdRTjcyYXp1UVNIdEttWktEcHlpUTBuQmEyM3hUVlM0?=
 =?utf-8?B?YVk1bzg3K2VXeUdUeW1PMGcyMHFkNWkyQmNWbkpzNWRjSTZGcWtYOUsvVzZ3?=
 =?utf-8?B?bUhZa0F2dnhZZ3ZHdkxvZE9YSlFZbW12Q3FtdWhYeXhhVlh0dEZQZFM0anph?=
 =?utf-8?B?Tk8xbWNJNkZrdkpKaXBVdDdZcmYyMEJOaFRhdTNhcktmczJaOEQ0T0xEcG0z?=
 =?utf-8?B?em9nQ1RrT0VPbXJDTFUrKzdHcnBnTmRqNTFVZ08vRndTUXZlRVRFbnRHb2pq?=
 =?utf-8?B?NTR4V2YreTZJbVZzaVpzcHQ3REcwV2JoK1lyaXhrTTNNMEptVWxsdWc5MGxk?=
 =?utf-8?B?VHc2V2hvT3Q4VE9nUXlFOXlHQ0g3T29KOEcydHBnSDFKRzRVWVd6OWZHMTdi?=
 =?utf-8?B?QWIxN0ZJbTlXN1VTdHRPRUlWTGhKZ1V0WWpqaEtMVDJHbTJlU2JxUzVRT1Nr?=
 =?utf-8?B?RXVJK0Y0WkVyRk8xNGJFeXhMaEdGdFkxQ1J5SzhYNm5WTzJXZGVpMWl5SUZJ?=
 =?utf-8?B?dTZRUlFrVy82M1dCMGFsZ3d3N1AycGh2WmVRajl6WE1uamdubjQvTjdBcUlX?=
 =?utf-8?B?ZnIvQ0Zia3Y0RDgyeUdGNmZJaDgyY09DemFJdmxUeWd3K0lqOVRyUHRlT2di?=
 =?utf-8?B?SjhCV20zUGFmVGtEcGQyUEZ0THF6K1VrZHpia3hhakJySU02U04rYWNMNG5V?=
 =?utf-8?B?bHMzYXNCNjlUY241c1FKSkJjZ3ZObUhPZlBUdFNtV3RSWmc5eURsaXA4QW44?=
 =?utf-8?B?SkdTSUFHSGRpTXExYkIzL1IyYWhLZEpWa29GTklCUFVWRmEya3dOOVEzTGdu?=
 =?utf-8?B?cy9NM3BwaldIYXY5UjRUL2s4UHJXUU5XS0pvU3N4Q0ZJblNPaTJnOWwyQ0ZT?=
 =?utf-8?B?OXN2OU94TkN1VGM4eVRpNVZpSTQ4ZGNtSGpPamFkZVBjcWRDSWNTeFF3b3hl?=
 =?utf-8?B?UzFNeFNucVV2MEVFRGxyTnR6OFdxU2VaWmtkYlNtOTlHZEl2aTlNNmNiTzBl?=
 =?utf-8?B?N0RtSXpHN1dwZzE4bHBLSE10UnVycEd6TzcyS1Ezck5aZlBKbXVHTytTcllY?=
 =?utf-8?B?UVYwcmZJdmFmZmMzNXBNRVV1SGFOMDV5TnIxbGxxY3o1WStFbG1oeFFPT0tr?=
 =?utf-8?B?MTV6Y2ZiUkNaUnRTNlVKS3dYMVpBNDlWcHFxMGIwQ2VuMXZOcEd1Rk5qMG1u?=
 =?utf-8?B?Tk1XNW5DMzFWTWM5NDUzTis4b0ZWN3VpenNhbjFhbHhqcmh5dlB3bTlTMHl2?=
 =?utf-8?B?ZEJUL0E5cE9Ia3JUQm1wdjF6Y01qS3dYdkhvVGV1YjdwUkcvMXN3Q1pRTDUw?=
 =?utf-8?B?dzFESUNCYktmYjNKRTVtcE02NHpmWHZQY2RjZEhsRzhaZGtVTWlFMUk5eHlR?=
 =?utf-8?B?Uk5EcktaQjFKRnRDMWhOTElreWRNbzdka3Z0QlJlSkJXaGxCVm5RSzBsNXhp?=
 =?utf-8?B?eDNtSGJFSE11K3VneEo0RFcrS3liSjZiMFNZK2pYZ2NUV0g2NDgybVVqV1dr?=
 =?utf-8?Q?Stw4f7EpejjufBOaNGMOsZGP8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B86AE08B8A6BA4586A26D3E61E87321@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d262240e-440a-4b85-a46f-08de16082286
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 09:55:32.7823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sc0gZ4o7jHl6bY5Du6gzhK8sNrgQK54p9kJQqIwz3eRgidEV+IFSyiD6Iw1tC+7UZa/fc+zy4gnDPJ8hggOOrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB8656

T24gV2VkLCAyMDI1LTA5LTI0IGF0IDEyOjM3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBUaGUgT1ZMIGRyaXZlciBpcyBpbnN0YWxsaW5nIGFu
IElTUiBpbiB0aGUgcHJvYmUgZnVuY3Rpb24gYnV0LCBpZg0KPiB0aGUgY29tcG9uZW50IGlzIG5v
dCBib3VuZCB5ZXQsIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciBtYXkgY2FsbCB0aGUNCj4gdmJsYW5r
X2NiIGFoZWFkIG9mIHRpbWUgKHdoaWxlIHByb2Jpbmcgb3RoZXIgZHJpdmVycykgb3IgdG9vIGxh
dGUNCj4gKHdoaWxlIHJlbW92aW5nIG90aGVyIGRyaXZlcnMpLCBwb3NzaWJseSBhY2Nlc3Npbmcg
bWVtb3J5IHRoYXQgaXQNCj4gc2hvdWxkIG5vdCB0cnkgdG8gYWNjZXNzIGJ5IHJldXNpbmcgc3Rh
bGUgcG9pbnRlcnMuDQo+IA0KPiBJbiBvcmRlciB0byBmaXggdGhpcywgYWRkIGEgbmV3IGBpcnFg
IG1lbWJlciB0byBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsDQo+IGFuZCB0aGVuIHNldCB0aGUgTk9BVVRP
RU4gZmxhZyB0byB0aGUgaXJxIGJlZm9yZSBpbnN0YWxsaW5nIHRoZSBJU1INCj4gdG8gbWFudWFs
bHkgY2FsbCBlbmFibGVfaXJxKCkgYW5kIGRpc2FibGVfaXJxKCkgaW4gdGhlIGJpbmQgYW5kDQo+
IHVuYmluZCBjYWxsYmFja3MgcmVzcGVjdGl2ZWx5Lg0KPiANCj4gRml4ZXM6IDExOWY1MTczNjI4
YSAoImRybS9tZWRpYXRlazogQWRkIERSTSBEcml2ZXIgZm9yIE1lZGlhdGVrIFNvQyBNVDgxNzMu
IikNCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDQwMjA4MzYyOC4yMDEx
MS01LWFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbQ0KPiBTaWduZWQtb2Zm
LWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdu
b0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9vdmwuYyB8IDIwICsrKysrKysrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MTMgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gaW5kZXggZTAyMzYzNTNkNDk5Li44ZTIwYjQ1NDExZmMg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gQEAgLTE2
MSw2ICsxNjEsNyBAQCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsIHsNCj4gICAgICAgICBzdHJ1Y3QgZHJt
X2NydGMgICAgICAgICAgICAgICAgICpjcnRjOw0KPiAgICAgICAgIHN0cnVjdCBjbGsgICAgICAg
ICAgICAgICAgICAgICAgKmNsazsNCj4gICAgICAgICB2b2lkIF9faW9tZW0gICAgICAgICAgICAg
ICAgICAgICpyZWdzOw0KPiArICAgICAgIGludCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aXJxOw0KPiAgICAgICAgIHN0cnVjdCBjbWRxX2NsaWVudF9yZWcgICAgICAgICAgY21kcV9yZWc7
DQo+ICAgICAgICAgY29uc3Qgc3RydWN0IG10a19kaXNwX292bF9kYXRhICAqZGF0YTsNCj4gICAg
ICAgICB2b2lkICAgICAgICAgICAgICAgICAgICAgICAgICAgICgqdmJsYW5rX2NiKSh2b2lkICpk
YXRhKTsNCj4gQEAgLTU5NCwxMiArNTk1LDE4IEBAIHZvaWQgbXRrX292bF9iZ2Nscl9pbl9vZmYo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiAgc3RhdGljIGludCBtdGtfZGlzcF9vdmxfYmluZChzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2UgKm1hc3RlciwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2b2lkICpkYXRhKQ0KPiAgew0KPiArICAgICAgIHN0cnVjdCBtdGtfZGlz
cF9vdmwgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKw0KPiArICAgICAgIGVuYWJs
ZV9pcnEocHJpdi0+aXJxKTsNCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICBzdGF0
aWMgdm9pZCBtdGtfZGlzcF9vdmxfdW5iaW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRl
dmljZSAqbWFzdGVyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmRh
dGEpDQo+ICB7DQo+ICsgICAgICAgc3RydWN0IG10a19kaXNwX292bCAqcHJpdiA9IGRldl9nZXRf
ZHJ2ZGF0YShkZXYpOw0KPiArDQo+ICsgICAgICAgZGlzYWJsZV9pcnEocHJpdi0+aXJxKTsNCj4g
IH0NCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGNvbXBvbmVudF9vcHMgbXRrX2Rpc3Bfb3Zs
X2NvbXBvbmVudF9vcHMgPSB7DQo+IEBAIC02MTEsMTYgKzYxOCwxNSBAQCBzdGF0aWMgaW50IG10
a19kaXNwX292bF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAg
ICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICAgICAgICAgc3RydWN0
IG10a19kaXNwX292bCAqcHJpdjsNCj4gLSAgICAgICBpbnQgaXJxOw0KPiAgICAgICAgIGludCBy
ZXQ7DQo+IA0KPiAgICAgICAgIHByaXYgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKnByaXYp
LCBHRlBfS0VSTkVMKTsNCj4gICAgICAgICBpZiAoIXByaXYpDQo+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVOT01FTTsNCj4gDQo+IC0gICAgICAgaXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2
LCAwKTsNCj4gLSAgICAgICBpZiAoaXJxIDwgMCkNCj4gLSAgICAgICAgICAgICAgIHJldHVybiBp
cnE7DQo+ICsgICAgICAgcHJpdi0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsNCj4g
KyAgICAgICBpZiAocHJpdi0+aXJxIDwgMCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBwcml2
LT5pcnE7DQo+IA0KPiAgICAgICAgIHByaXYtPmNsayA9IGRldm1fY2xrX2dldChkZXYsIE5VTEwp
Ow0KPiAgICAgICAgIGlmIChJU19FUlIocHJpdi0+Y2xrKSkNCj4gQEAgLTY0MCwxMCArNjQ2LDEw
IEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3Bfb3ZsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICAgICAgICAgcHJpdi0+ZGF0YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShk
ZXYpOw0KPiAgICAgICAgIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHByaXYpOw0KPiANCj4g
LSAgICAgICByZXQgPSBkZXZtX3JlcXVlc3RfaXJxKGRldiwgaXJxLCBtdGtfZGlzcF9vdmxfaXJx
X2hhbmRsZXIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJUlFGX1RSSUdHRVJf
Tk9ORSwgZGV2X25hbWUoZGV2KSwgcHJpdik7DQo+ICsgICAgICAgcmV0ID0gZGV2bV9yZXF1ZXN0
X2lycShkZXYsIHByaXYtPmlycSwgbXRrX2Rpc3Bfb3ZsX2lycV9oYW5kbGVyLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgSVJRRl9OT19BVVRPRU4sIGRldl9uYW1lKGRldiksIHBy
aXYpOw0KDQpSRE1BIGRyaXZlciB3b3VsZCBjbGVhciBwZW5kaW5nIGludGVycnVwdCBhbmQgZGlz
YWJsZSBpbnRlcnJ1cHQgYmVmb3JlIHJlcXVlc3QgaXJxLg0KSSB3b3VsZCBsaWtlIHRoZSBoYXJk
d2FyZSB3b3VsZCBiZSBpbiBpZGxlIHN0YXRlIHdoZW4gcHJvYmUuDQpTbyBPVkwgc2hvdWxkIGRv
IGxpa2UgUkRNQS4NCg0KUmVnYXJkcywNCkNLDQoNCj4gICAgICAgICBpZiAocmV0IDwgMCkNCj4g
LSAgICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiRmFpbGVkIHRv
IHJlcXVlc3QgaXJxICVkXG4iLCBpcnEpOw0KPiArICAgICAgICAgICAgICAgcmV0dXJuIGRldl9l
cnJfcHJvYmUoZGV2LCByZXQsICJGYWlsZWQgdG8gcmVxdWVzdCBpcnEgJWRcbiIsIHByaXYtPmly
cSk7DQo+IA0KPiAgICAgICAgIHBtX3J1bnRpbWVfZW5hYmxlKGRldik7DQo+IA0KPiAtLQ0KPiAy
LjUxLjANCj4gDQoNCg==

