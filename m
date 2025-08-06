Return-Path: <linux-kernel+bounces-757296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89349B1C06D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE6E180A7A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 06:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD52066DE;
	Wed,  6 Aug 2025 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BjwZfybW";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TXlvNYHz"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F9A81724;
	Wed,  6 Aug 2025 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754461727; cv=fail; b=UjuC/utj2bgeuEtcUTl+W9wpYgEAUXksS+o/nyIHhwyHUNZazCEevjMR8eH9XCKKd1uMy5IsQ9zqIeFmidrE+/tg5QwUWsSU7n/FqG7PY/BGGQnxjJkiEyjNjqbA9HLCyGt5qIj81HP+2ywWS83U51UYxTHWY2fWjuCAiNnRZsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754461727; c=relaxed/simple;
	bh=A1OjI9NHiFZOM2RZ9Mm4SIMglSiFm6/N7ftheEYxZFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cle74LAXFz7zj10gCYMkNasc9MkvP+jNP5yZ7B5ROdrXGe+DPJc1fP+LuqBJbAKYhApOPWkNSX+ucfNVGDBsj4hY1AHs2QEMIwGKf5yaoupxCWxVuNKmBtP556CHUxyfVhu6bB3YbDqDAP3mWkAAbC4bvLs6wSUumyOWaJM+1Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BjwZfybW; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=TXlvNYHz; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 92a34690728e11f0b33aeb1e7f16c2b6-20250806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=A1OjI9NHiFZOM2RZ9Mm4SIMglSiFm6/N7ftheEYxZFs=;
	b=BjwZfybWA2oGNDaKRgdB+As9BH2EZllPc9Nowt1++MQ9PN7psxXLX/zPBIYaNd8V6cNTGrpuqLQ7PmRoa8Tv9fZZ2xEkjCHXJAEL82Rr3NFfE/1cqgQHulyks1+ODP/hTmtomlAXtHXE5aE6pf71AQt99aEuZAEEXgX301heayQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:a4c85366-5857-43e5-9c7e-d25770a00ab1,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:65942b09-aadc-4681-92d7-012627504691,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 92a34690728e11f0b33aeb1e7f16c2b6-20250806
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 301811011; Wed, 06 Aug 2025 14:28:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 6 Aug 2025 14:24:44 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 6 Aug 2025 14:24:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaaGH4LU8V0h6A+IJVHeeSSM5ZH430OynBnU8NRiVtPPbtzbPi4MapVmbuLpENcR3yoaXOpBBww9vcOK62hqz3xIPjmbtCkYEIFrsKeAtae+0/clj7PVXdBqYW2V7GF4Kg/YY/B8ho2z+RA0Z/L2N3tghiariicmvEnyUIyQvCyBQi8PahC7MHtPWQjwxoPzhzCqks4VX4SO/NxkNxISjXZ4S3kyx1+m0u9C/B3iFh6NrMIt85ZOAuUkqpjDyMdOiBEo2LGK66UdYwab9D9/7xlMrH/FioB8AQd2MtkAxKxkvyJxJRn3w9sbm7SpWpW9sBzYGLiaQqWZh0DoRvgnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1OjI9NHiFZOM2RZ9Mm4SIMglSiFm6/N7ftheEYxZFs=;
 b=gwumfSem7gv7jkJzhjC0rGsOwWbyP5vVec9X7ekUKASAy8IM83fzd0Sq+GivefEBQSmQnWSQcOhcOCGUcQdEUHIAQkHrtyNiYrrxKDNkt9OzWDnjc2Z3bmbqqyozaF7/n2PofvltzANJTZayqphqcpwpZn39OnYEhI12KlR9EVe+70NaOVl6BGZI+G+4hPKVlDz13EOM9BXQrJ/rk7YEgddUGuzUYYXFfxOZD7R0tXseLVshLNuLtahl4ftoKDfTRap2a1VmoAFZZI7XGJs7Md6hvnVkgKezBw/KVDXFOZvNUceT/kj1GAWhsqXEyEbgjiAGfXL7xtk6V9Aff1aD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1OjI9NHiFZOM2RZ9Mm4SIMglSiFm6/N7ftheEYxZFs=;
 b=TXlvNYHzUUEAvi43ZBYVteGvDEGYqACZ9Gi1o1b4gJaL1WnM10eKaOLB7Q3pW7/4B4xMphpkWdG+H77aDI59BAxZkI4Kq9IeXIVKBrqG9ivOfRx0m9vFRgIALDX9D1t9353dN8RgnI0euvEsBTasgPbCNK79nHO5Puevj8Jvahc=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7994.apcprd03.prod.outlook.com (2603:1096:400:463::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 06:24:41 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 06:24:41 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?SmF5IExpdSAo5YiY5Y2aKQ==?= <Jay.Liu@mediatek.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "hsinyi@chromium.org"
	<hsinyi@chromium.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= <yongqiang.niu@mediatek.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/7] drm/mediatek: Add CCORR component support for
 MT8196
Thread-Topic: [PATCH v2 1/7] drm/mediatek: Add CCORR component support for
 MT8196
Thread-Index: AQHb/sZwcvpY8ZwRjkWwlwCmpOSK2rRVOAcA
Date: Wed, 6 Aug 2025 06:24:41 +0000
Message-ID: <533b3c5d23260bf0096d7ca320ccff0998ce461c.camel@mediatek.com>
References: <20250727071609.26037-1-jay.liu@mediatek.com>
	 <20250727071609.26037-2-jay.liu@mediatek.com>
In-Reply-To: <20250727071609.26037-2-jay.liu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7994:EE_
x-ms-office365-filtering-correlation-id: ddd34d36-ddca-411a-c5e7-08ddd4b1ed80
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|42112799006|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UXN4RGhwMEwyYWVNb3loNG4wVGR6dDFtYkMycFo3NG5xYm10QllNREZsS0tB?=
 =?utf-8?B?ZEh2aUhueURVVk1tb1ZFdXdEMDhyaEllK2Qrby9aZ01BdG01NWNvQW1tUjZj?=
 =?utf-8?B?ZlFDNWQxUStLUlBNSlhNdlZIY3lId2wzcnI5VGJPM25QY0RxMTIrc3dJUllq?=
 =?utf-8?B?bWdPWkV0Y09mazlwZDV2VjdaQjRSTEttR3JJRTVocDRiUHBnMXBRSml2bkg5?=
 =?utf-8?B?RXpKUGM4NGlpTEpPMzk4YUdRYVdkM2g4OG5ZemtDV3ZUTzF4UTdTclVxellJ?=
 =?utf-8?B?dm5xbnRLWkFjUHArcGpweGZtR1FDKys5ckc3ZlV5VlVKaDBvYmlwVFdBdzZY?=
 =?utf-8?B?NS8xQ0JMM0cydjI2MDhRSi9kd1U4NURtdDZyRXNUWlVtZm00SXlrZmtjVm9i?=
 =?utf-8?B?OFJIOU8vbWtraXNGNXowMDJscXlGRUpya2NmamkxU2FtWFdJT0NEbEZjTmNs?=
 =?utf-8?B?UjIvRG9pQlkwRmsrc1MrU0sxVE8wTzdVdjBMNzFUYmxtbG9RZm1JWWpLTFg4?=
 =?utf-8?B?QzQ0MHRYOFhVaGV6czJOSFRVYUxEaVdRT0IzeU9aQUZZUE85MGhMeDM2TWtl?=
 =?utf-8?B?Q1A5QWE3dXNQdVVkblZicXBzbS9QNndGWXh2dGdnQVBuQ1UrT0FCZ2N6dzlV?=
 =?utf-8?B?NWRleGNuUjMya2krenp1SWlmd0oxdUg2NXFSSEZvWTR6NVVOMS9xRVFyL0pI?=
 =?utf-8?B?U3hvQXJWUlduTkZrVUF4aEYzVXB5dG0yU1RpTklmMTZJNmI3RENXc3ZnMDE2?=
 =?utf-8?B?Y1NWeEplMU9sdHFCcDA3MGVGa2VrMktWYkdyM2YzMTUvNU5pN25TQVZMUE1Z?=
 =?utf-8?B?V2VTbTdmNElTdE9ienpsU21CY0d5NnY4NWx1OERjbUhGQkMva0hmNG1xb1Bz?=
 =?utf-8?B?dTVvbVRoMUdGWXdobW9DbCtCQlI3M1Z4SVJ5Q0wwR1VlbEVndVJGTWhFM290?=
 =?utf-8?B?ajBuc2ZESXpoZ0dCTisxQ1UxK0ZNVDNwYzlMZVA1TEF2YjkrR1hYT3ZKbG90?=
 =?utf-8?B?YXk3M2N0dktZNFI3MURxWFdUc0t5bHZCcFpMS3EvUGZQd1I1SFpRM1VMMnBV?=
 =?utf-8?B?Skp6QUY4TFpKRGF3bjMydEw1OVJoVzRxQU4wRC9MVnJ5QnI0SWRKSkpGN1RY?=
 =?utf-8?B?bjhJRmZTdkJuMFpGRkhDcU5idi9ORjBCdDd4SkJYNmNQbWt0ZmRmZWp2TEU2?=
 =?utf-8?B?SHFndEVXQ29VVDNCVHVGMlZLZ3FMZXNVUnh6elA4c1FKN3JKYnU3ZkNUcWhO?=
 =?utf-8?B?dUk3Q1p4WFR6YUIvWENqL2E1OEpFcklES0FwRmVPQ3cvZ0d5dGp0cVh2YW85?=
 =?utf-8?B?dHlVbHRjK1h0OHN1cTRHR1htc0dGQ1dtRVZOM2pXaTQydmZsVVA5bW5oU2dh?=
 =?utf-8?B?OUZNS2IzK0l3R0FFU1MvaXhEZWVpSUR3cThPcENPUno4QUgzWk9Nb1UwZjRw?=
 =?utf-8?B?L1dDTnRtLzEwMldwdTRpS0hhZ2ttempJVjBCS0FVUkE3aEMyb0lQRDhYdjJK?=
 =?utf-8?B?cEs3RDFFdHk5a3pOVWUyUEJNd2dsZUNIcGpOQng5dHliYlRTUEVoOGUrM05K?=
 =?utf-8?B?dG5yMDBJUTBlbHlsaFk4aXFLaWFPVVBycVVCa0FjSE0xaGJjSy8xdDJPSUFR?=
 =?utf-8?B?Q3BMSVRFUFhYTU9kZmRBYzVReGs2RGdCRGxzMlF6cTBLbEpYTmx0THFEZWtH?=
 =?utf-8?B?UDJjK1QvZ0xWYVU3a1JwM0FjZ2Q1WHVjK0RSbE1LVllDZC9XRlZDRjYrQmM5?=
 =?utf-8?B?dzBUNzZFSkFDaGJlTVBaUllYN0V6M2kwNFFEVEhUTENJZFpYUEQ2ZkNyUEhB?=
 =?utf-8?B?bXNSSklvV2M1STNkYTUrTTlONWZDZEZIZlN0K3Y0T1lmZW4zdFdQbDNweEl1?=
 =?utf-8?B?aysxV1kwZ2l5Y0VML0pnRXM5YjcvUXU5Y2ZpcHl1SkNBazZVYXlpclN6NEsw?=
 =?utf-8?B?QXk0azk5WWZMcnl0K3hRb2s3TXlZTGUyQlpLaTUzdTR3ZzZSWWV5WEFMY1lV?=
 =?utf-8?Q?cc88ND2knXdh5FDyjfoUhEGFrLCeHY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(42112799006)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjdHQmpQUlg3T3Mwbi85TTM1K2FQb2NSOVFLNXJlRHdpK2crUm5nbTFvMzFo?=
 =?utf-8?B?bEdDS0tNakhPKzJ5YnJ2UWhCaUI1TUdoczBwdGl3SXQzcHRDbS9oeGNiTHlE?=
 =?utf-8?B?U2JQWm5KSzIxZ3cxTTJPaXNwdjNYUWRKQ0dGSmpHMXBXay90NU94YnduRUUv?=
 =?utf-8?B?SGszNEN5Uk01dm9oeDh6UVMwb1VkVEMwV1NXWGZidEM0R2FOVG8zZENUSlhI?=
 =?utf-8?B?R21odVlwelNSUnJDeFc4Nlh6UXBoRlhxa1oxNHZnTWhOY1NKYnlvM0o0Yklt?=
 =?utf-8?B?b2RhaWJSQlZzSVFaa2MrZDNpNXdGeUNmTFRGTURoc1dxcVduMXA1U1ovRFky?=
 =?utf-8?B?U2dNTG1OZzlnTklhNE4zSUVrK1Q2TU51RnYvQWZGcTIwZHJKSitLSkRJM1h2?=
 =?utf-8?B?dVM0SGxLVW80ZXNtWHhkZENYWDczRUpMSkFYMGFHaFg0M0g1cTFTZnFYK0cz?=
 =?utf-8?B?SmhtcGFXdm5LL3NKRW82Nm9jcGFodU83cEovQ2JocDFWSFh0WG0xM3NKOExn?=
 =?utf-8?B?NFE1Mmg4Um9FV1pZc3BBbUY5enVQM2ZrTGgvUktJRWFSc21WY3g3VkxPYjhO?=
 =?utf-8?B?ZFMzM3FHSDd1YUlUZmVVOGxHQlVDZzZEcFpJRnM0dHdXT2RTVkhvejhRNE12?=
 =?utf-8?B?d2tWcDdwNHp0VGhkZm9LYUU5Y0RKNVpPc1ZOazRNNWxnemF5SzRNVjBnaGtK?=
 =?utf-8?B?NzdDQzZxT2tSVDZYck1HdDA5eWFNY0NpclVXdmp6dzlWdkgreU1DLzJqZk1L?=
 =?utf-8?B?TWFpQzBSUFczUjBmNzFsYU8yTzdPaThhOWhualhaVUM3YWovY1RtVVhMbkR1?=
 =?utf-8?B?Q2hlMitlWXd5RXhiOWgwKzZiZWRjRGZaS0pZKzVSbmQ1WUl3U25rQjMzYnZX?=
 =?utf-8?B?Q21RWk5QY1RsU2wzRWY2YU9CZnRFMXN5QnVvblo5cnFmTGxVK3AzaUNzSFFq?=
 =?utf-8?B?MzFCclhZNjBrTzEyWXFFOU1nN25CKzJLdGZuMUl4cEF2VzNxaGthTnIwQW5L?=
 =?utf-8?B?Sk8rTDlvMzUvVzdCVHVENTNjYVhESnFRNUpGSzg1TytPY2xhM1V4TVdZTDls?=
 =?utf-8?B?M3NoOUE5WjRzR2ZxeVVwNVdjUVZzdzJvU1FyaE9TMkExTkJXb3BUMlYzclNk?=
 =?utf-8?B?d0gwbzlFYUxCaWxWUDlkSFpQMWJ0RzNjYmlLeFBlYkVvemdGZzZMV3BRaWt0?=
 =?utf-8?B?NlhmekxIbWJCZTFtU21sdmM4YXNrUWFDRWhDMEYwcFpTL3ZzSFdiR1lwTE5k?=
 =?utf-8?B?MkpHZlFRNk9sNHJPeW0xZ2FFV1BMUENnbjhCMVVRMWpneDVmY0NxLzNxU1pi?=
 =?utf-8?B?cysxUEVjbkJtZXlOOWwrYStiU29Cdk9LQ2RWWTk3VGwyR3I4eURrdm1Qc0sx?=
 =?utf-8?B?SGN5T3c2N2dlUnMxK1JEWGVWS3hWSE1tUzZJV2dsVlo3S21WV3JiT01IUjBq?=
 =?utf-8?B?Z3JoQUhBZUVadEhwU0J2VVN5UDdnV09XS0JaTmh2WHhOZmR4QXhWUE1BcjIv?=
 =?utf-8?B?UTlSbjBHNnVpV0ovOEladHJPaG44R2tnejk3VTN5dUxrR2ZMZVFXMW4yQ1Ez?=
 =?utf-8?B?VlNGTnBaMTRWeHdBODJsOVlSaURxSWJ0TzBUZ1ByKzJrMjJQbnBDYUd5T2pB?=
 =?utf-8?B?VmtRUTdBdCtSaDU1bUFMNWxIZU5uelM5MzdzODNudFJDVkFEUVkvc1lwbjVK?=
 =?utf-8?B?d2Zzb2pidVh0SzFPQkUvUkowWHhocTlmMHFVV0xGbXJaSldQQWQvNmN3OXpB?=
 =?utf-8?B?U2g4T2E4WmNJMHkwL2FxWjVuY2ZuRmVLMVJhOVNOMzZGTmlacjhGdWZDZms0?=
 =?utf-8?B?cjJZaFNhdkI4TnVJZWxyaGZOWVN6ZFI1R0c2MEJmNGZaY1pla2o0cHhxbW56?=
 =?utf-8?B?NndJVHJJNUxVUytPOWVMTlBKVVZ4eE5VRXpkZnlEMVRubXM0WFNheXVHbXA2?=
 =?utf-8?B?KzFHeTIxS1Q5eEcxZHhRTkR1NFhwVUcxditOWmZjWUs2M0pPc2hhUmc3SVZl?=
 =?utf-8?B?QTNxL2xzYldNb2gxMDdvZVdrYURJNVlXWTk4ZWRuREN6NU1WVGx1R0JaSjJJ?=
 =?utf-8?B?bG9MSit3dG1CRlVlZ1VUVENBb3R6ZlBpZmJuUHF0UFpmSmp4emR2RS81SWJp?=
 =?utf-8?B?bmNHQVUreUNvYk9XZTdvUjl0Vm15RjRrZUNDZStiSU1FY2cvWDlaR0Q0NjAy?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00730B4E7018E34883E6FD35A00CDDA3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd34d36-ddca-411a-c5e7-08ddd4b1ed80
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 06:24:41.5033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ApXvlb2BbZUHl7ESRrIa0n0wiUaCIZh4E3QvwjRNEU04Os41GF+8Ej3AMA3bbqrtcRf/pTVb6lddGtbxxY/Eqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7994

T24gU3VuLCAyMDI1LTA3LTI3IGF0IDE1OjE1ICswODAwLCBKYXkgTGl1IHdyb3RlOg0KPiBBZGQg
Q0NPUlIgY29tcG9uZW50IHN1cHBvcnQgZm9yIE1UODE5Ni4NCg0KVGhpcyBwYXRjaCBsb29rcyBn
b29kIHRvIG1lLCBidXQgSSB3b3VsZCBsaWtlIHRoZSB0aXRsZSB0byBiZSANCg0KZHJtL21lZGlh
dGVrOiBTdXBwb3J0IG11bHRpcGxlIENDT1JSIGNvbXBvbmVudA0KDQpUaGlzIHRpdGxlIGlzIG1v
cmUgZ2VuZXJhbCBub3Qgb25seSBmb3IgTVQ4MTk2Lg0KSW4gY29tbWl0IG1lc3NhZ2UgeW91IGNv
dWxkIGtlZXAgdGhlIE1UODE5NiBpbmZvcm1hdGlvbiBiZWNhdXNlIHRoaXMgcGF0Y2ggaXMgdHJp
Z2dlcmVkIGJ5IE1UODE5Ni4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IENDT1JSIGlzIGEgaGFy
ZHdhcmUgbW9kdWxlIHRoYXQgb3B0aW1pemVzIHRoZSB2aXN1YWwgZWZmZWN0cyBvZg0KPiBpbWFn
ZXMgYnkgYWRqdXN0aW5nIHRoZSBjb2xvciBtYXRyaXgsIGVuYWJsaW5nIGZlYXR1cmVzIHN1Y2gg
YXMNCj4gbmlnaHQgbGlnaHQuDQo+IA0KPiBUaGUgODE5NiBTb0MgaGFzIHR3byBDQ09SUiBoYXJk
d2FyZSB1bml0cywgd2hpY2ggbXVzdCBiZSBjaGFpbmVkDQo+IHRvZ2V0aGVyIGluIGEgZml4ZWQg
b3JkZXIgaW4gdGhlIGRpc3BsYXkgcGF0aCB0byBkaXNwbGF5IHRoZSBpbWFnZQ0KPiBjb3JyZWN0
bHkuIHRoZSBgbXRrX2Njb3JyX2N0bV9zZXRgIEFQSSBvbmx5IHV0aWxpemVzIG9uZSBvZiB0aGVz
ZSB1bml0cy4NCj4gVG8gcHJldmVudCB0aGUgdW51c2VkIENDT1JSIHVuaXQgZnJvbSBpbmFkdmVy
dGVudGx5IHRha2luZyBlZmZlY3QsDQo+IHdlIG5lZWQgdG8gYmxvY2sgaXQgaW4gdGhlIG10a19j
cnRjLmMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXkgTGl1IDxqYXkubGl1QG1lZGlhdGVrLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogMjAyMjAzMTUxNTI1MDMgY3JlYXRlZCA8amF5LmxpdUBtZWRp
YXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMg
ICAgICAgfCA1ICsrKystDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21w
LmMgICB8IDMgKystDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmgg
ICB8IDcgKysrKy0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Njb3Jy
LmMgfCA2ICsrKystLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5o
ICAgfCAyICstDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19j
cnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0KPiBpbmRleCBiYzc1
Mjc1NDJmZGMuLjZiOWNiNTJlOTIwNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19jcnRjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19j
cnRjLmMNCj4gQEAgLTg1OSwxMSArODU5LDE0IEBAIHN0YXRpYyB2b2lkIG10a19jcnRjX2F0b21p
Y19mbHVzaChzdHJ1Y3QgZHJtX2NydGMgKmNydGMsDQo+ICB7DQo+ICAJc3RydWN0IG10a19jcnRj
ICptdGtfY3J0YyA9IHRvX210a19jcnRjKGNydGMpOw0KPiAgCWludCBpOw0KPiArCWJvb2wgY3Rt
X3NldCA9IGZhbHNlOw0KPiAgDQo+ICAJaWYgKGNydGMtPnN0YXRlLT5jb2xvcl9tZ210X2NoYW5n
ZWQpDQo+ICAJCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0Yy0+ZGRwX2NvbXBfbnI7IGkrKykgew0K
PiAgCQkJbXRrX2RkcF9nYW1tYV9zZXQobXRrX2NydGMtPmRkcF9jb21wW2ldLCBjcnRjLT5zdGF0
ZSk7DQo+IC0JCQltdGtfZGRwX2N0bV9zZXQobXRrX2NydGMtPmRkcF9jb21wW2ldLCBjcnRjLT5z
dGF0ZSk7DQo+ICsJCQkvKiBvbmx5IHNldCBjdG0gb25jZSBmb3IgdGhlIHBpcGVsaW5lIHdpdGgg
dHdvIENDT1JSIGNvbXBvbmVudHMgKi8NCj4gKwkJCWlmICghY3RtX3NldCkNCj4gKwkJCQljdG1f
c2V0ID0gbXRrX2RkcF9jdG1fc2V0KG10a19jcnRjLT5kZHBfY29tcFtpXSwgY3J0Yy0+c3RhdGUp
Ow0KPiAgCQl9DQo+ICAJbXRrX2NydGNfdXBkYXRlX2NvbmZpZyhtdGtfY3J0YywgISFtdGtfY3J0
Yy0+ZXZlbnQpOw0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kZHBfY29tcC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5j
DQo+IGluZGV4IGFjNjYyMGUxMDI2Mi4uODUwZTNiMThkYTYxIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5jDQo+IEBAIC00NTgsNyArNDU4LDggQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfbWF0Y2ggbXRrX2RkcF9tYXRjaGVzW0REUF9DT01Q
T05FTlRfRFJNX0lEX01BWF0NCj4gIAlbRERQX0NPTVBPTkVOVF9BQUwwXQkJPSB7IE1US19ESVNQ
X0FBTCwJCTAsICZkZHBfYWFsIH0sDQo+ICAJW0REUF9DT01QT05FTlRfQUFMMV0JCT0geyBNVEtf
RElTUF9BQUwsCQkxLCAmZGRwX2FhbCB9LA0KPiAgCVtERFBfQ09NUE9ORU5UX0JMU10JCT0geyBN
VEtfRElTUF9CTFMsCQkwLCBOVUxMIH0sDQo+IC0JW0REUF9DT01QT05FTlRfQ0NPUlJdCQk9IHsg
TVRLX0RJU1BfQ0NPUlIsCQkwLCAmZGRwX2Njb3JyIH0sDQo+ICsJW0REUF9DT01QT05FTlRfQ0NP
UlIwXQkJPSB7IE1US19ESVNQX0NDT1JSLAkJMCwgJmRkcF9jY29yciB9LA0KPiArCVtERFBfQ09N
UE9ORU5UX0NDT1JSMV0JCT0geyBNVEtfRElTUF9DQ09SUiwJCTEsICZkZHBfY2NvcnIgfSwNCj4g
IAlbRERQX0NPTVBPTkVOVF9DT0xPUjBdCQk9IHsgTVRLX0RJU1BfQ09MT1IsCQkwLCAmZGRwX2Nv
bG9yIH0sDQo+ICAJW0REUF9DT01QT05FTlRfQ09MT1IxXQkJPSB7IE1US19ESVNQX0NPTE9SLAkJ
MSwgJmRkcF9jb2xvciB9LA0KPiAgCVtERFBfQ09NUE9ORU5UX0RJVEhFUjBdCQk9IHsgTVRLX0RJ
U1BfRElUSEVSLAkJMCwgJmRkcF9kaXRoZXIgfSwNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuaCBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGRwX2NvbXAuaA0KPiBpbmRleCA3Mjg5YjNkY2YyMmYuLjk4YTcwMWFjNGNkZSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuaA0KPiBAQCAtNzcsNyArNzcs
NyBAQCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIHsNCj4gIAkJCSAgc3RydWN0IGRybV9jcnRj
X3N0YXRlICpzdGF0ZSk7DQo+ICAJdm9pZCAoKmJnY2xyX2luX29uKShzdHJ1Y3QgZGV2aWNlICpk
ZXYpOw0KPiAgCXZvaWQgKCpiZ2Nscl9pbl9vZmYpKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+IC0J
dm9pZCAoKmN0bV9zZXQpKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gKwlib29sICgqY3RtX3NldCko
c3RydWN0IGRldmljZSAqZGV2LA0KPiAgCQkJc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSk7
DQo+ICAJc3RydWN0IGRldmljZSAqICgqZG1hX2Rldl9nZXQpKHN0cnVjdCBkZXZpY2UgKmRldik7
DQo+ICAJdTMyICgqZ2V0X2JsZW5kX21vZGVzKShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiBAQCAt
MjU0LDExICsyNTQsMTIgQEAgc3RhdGljIGlubGluZSB2b2lkIG10a19kZHBfY29tcF9iZ2Nscl9p
bl9vZmYoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCkNCj4gIAkJY29tcC0+ZnVuY3MtPmJnY2xy
X2luX29mZihjb21wLT5kZXYpOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgbXRr
X2RkcF9jdG1fc2V0KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsDQo+ICtzdGF0aWMgaW5saW5l
IGJvb2wgbXRrX2RkcF9jdG1fc2V0KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsDQo+ICAJCQkJ
ICAgc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSkNCj4gIHsNCj4gIAlpZiAoY29tcC0+ZnVu
Y3MgJiYgY29tcC0+ZnVuY3MtPmN0bV9zZXQpDQo+IC0JCWNvbXAtPmZ1bmNzLT5jdG1fc2V0KGNv
bXAtPmRldiwgc3RhdGUpOw0KPiArCQlyZXR1cm4gY29tcC0+ZnVuY3MtPmN0bV9zZXQoY29tcC0+
ZGV2LCBzdGF0ZSk7DQo+ICsJcmV0dXJuIGZhbHNlOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW5s
aW5lIHN0cnVjdCBkZXZpY2UgKm10a19kZHBfY29tcF9kbWFfZGV2X2dldChzdHJ1Y3QgbXRrX2Rk
cF9jb21wICpjb21wKQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX2Njb3JyLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2NvcnIu
Yw0KPiBpbmRleCAxMGQ2MGQyYzJhNTYuLjg1YmExMDlkNjM4MyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Njb3JyLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Njb3JyLmMNCj4gQEAgLTEwMSw3ICsxMDEsNyBAQCBz
dGF0aWMgdTE2IG10a19jdG1fczMxXzMyX3RvX3MxX24odTY0IGluLCB1MzIgbikNCj4gIAlyZXR1
cm4gcjsNCj4gIH0NCj4gIA0KPiAtdm9pZCBtdGtfY2NvcnJfY3RtX3NldChzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqc3RhdGUpDQo+ICtib29sIG10a19jY29ycl9j
dG1fc2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSkN
Cj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2Rpc3BfY2NvcnIgKmNjb3JyID0gZGV2X2dldF9kcnZkYXRh
KGRldik7DQo+ICAJc3RydWN0IGRybV9wcm9wZXJ0eV9ibG9iICpibG9iID0gc3RhdGUtPmN0bTsN
Cj4gQEAgLTExMyw3ICsxMTMsNyBAQCB2b2lkIG10a19jY29ycl9jdG1fc2V0KHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSkNCj4gIAl1MzIgbWF0cml4X2Jp
dHMgPSBjY29yci0+ZGF0YS0+bWF0cml4X2JpdHM7DQo+ICANCj4gIAlpZiAoIWJsb2IpDQo+IC0J
CXJldHVybjsNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiAgDQo+ICAJY3RtID0gKHN0cnVjdCBkcm1f
Y29sb3JfY3RtICopYmxvYi0+ZGF0YTsNCj4gIAlpbnB1dCA9IGN0bS0+bWF0cml4Ow0KPiBAQCAt
MTMxLDYgKzEzMSw4IEBAIHZvaWQgbXRrX2Njb3JyX2N0bV9zZXQoc3RydWN0IGRldmljZSAqZGV2
LCBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKnN0YXRlKQ0KPiAgCQkgICAgICAmY2NvcnItPmNtZHFf
cmVnLCBjY29yci0+cmVncywgRElTUF9DQ09SUl9DT0VGXzMpOw0KPiAgCW10a19kZHBfd3JpdGUo
Y21kcV9wa3QsIGNvZWZmc1s4XSA8PCAxNiwNCj4gIAkJICAgICAgJmNjb3JyLT5jbWRxX3JlZywg
Y2NvcnItPnJlZ3MsIERJU1BfQ0NPUlJfQ09FRl80KTsNCj4gKw0KPiArCXJldHVybiB0cnVlOw0K
PiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50IG10a19kaXNwX2Njb3JyX2JpbmQoc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlICptYXN0ZXIsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfZHJ2LmgNCj4gaW5kZXggNjc5ZDQxM2JmMTBiLi40MjAzYzI4YzM4Y2UgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gQEAgLTIyLDcgKzIy
LDcgQEAgdm9pZCBtdGtfYWFsX2dhbW1hX3NldChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBk
cm1fY3J0Y19zdGF0ZSAqc3RhdGUpOw0KPiAgdm9pZCBtdGtfYWFsX3N0YXJ0KHN0cnVjdCBkZXZp
Y2UgKmRldik7DQo+ICB2b2lkIG10a19hYWxfc3RvcChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAg
DQo+IC12b2lkIG10a19jY29ycl9jdG1fc2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRy
bV9jcnRjX3N0YXRlICpzdGF0ZSk7DQo+ICtib29sIG10a19jY29ycl9jdG1fc2V0KHN0cnVjdCBk
ZXZpY2UgKmRldiwgc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSk7DQo+ICBpbnQgbXRrX2Nj
b3JyX2Nsa19lbmFibGUoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZvaWQgbXRrX2Njb3JyX2Ns
a19kaXNhYmxlKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19jY29ycl9jb25maWco
c3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgdywNCg0K

