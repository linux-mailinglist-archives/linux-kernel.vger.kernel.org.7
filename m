Return-Path: <linux-kernel+bounces-881167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E84CEC279EE
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 09:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE7D1895D69
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 08:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB90629D26D;
	Sat,  1 Nov 2025 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZFMwl64r";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fMPP+d2f"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C91FC8;
	Sat,  1 Nov 2025 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761986996; cv=fail; b=jcajvzd3v5dXvj/i48HNfakdsHffa1BpS9gwCKqP3RacfUTv++SLAgWPmiti2vAiilNfjC2UGnIEu/JdDa/VRDamWYAUM7mX87A4N71NQXyDthRf1amlbyF15PrNZaPm4vPPRExvMHMUK4NcP+jg8U4xIyFk+RDiMJFZfqZ/uFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761986996; c=relaxed/simple;
	bh=TY+QSwRJVm95ALeU/2Yy/DZdNk0yJaXh3OijWva3qjo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FnKAZRzjrz9o+/JvkiQZ/E+rwq3ngn58d28Env88pSyXiMkie0wAy7Dk3Y2uU+FMVDbtIxg3OxKe1dZ28Lji0xu7mH+8FhfN+H4qs68V3o+lvn4WdYwaovHrvsc82rcTXNvCUPwaciaj2yhhmrJUvTOyDkW+82c/ce1vodC9+iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZFMwl64r; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=fMPP+d2f; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b9ce6c62b6ff11f0ae1e63ff8927bad3-20251101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TY+QSwRJVm95ALeU/2Yy/DZdNk0yJaXh3OijWva3qjo=;
	b=ZFMwl64rdQTU+h0yw4EqRxHPdhx/eg8DOoLFwWFbuPkuh/Om53F2ccJxVF2Kf90GUM33dHcCVSNh8rVDEDDQ1qBAe8hmvZoKa11XDr3S/C7SgpDxaY/ydb9IpmEYLyRhNdntomxxa9Qw73BvqM3HixwEHuuW9V5v5z8P4grh+V8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:2d2951b9-a42e-4f31-a95a-9f38d5238cc3,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:8b7e7e26-cfd6-4a1d-a1a8-72ac3fdb69c4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b9ce6c62b6ff11f0ae1e63ff8927bad3-20251101
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 833949372; Sat, 01 Nov 2025 16:49:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 1 Nov 2025 16:49:47 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Sat, 1 Nov 2025 16:49:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbgrAhWyI/WiyPqPQ7hW9k4QuSAmlTfL+QuT/mOC9Q3ywVtFz3hBx6G/J7qA3mbZu2glkelf+eHONO33EhbGn2pKlQ9NLRvK+WKImPOFVicmorCKPfOywMfd9KRPS1yZW4yo9ucSNGa2INkp3jZ2wENpp/tSZe+oJJ2OdoSqmkwZNS6oOsNfZp9lbvrd6OSB4dkCTAOfm0G9ZceT25pL3UN1Btz8eWDOx/EtUrsTrsKIYI6wvyX5PqdQeLJgmBtT9uEITCrLhbIeFIzjxvcvfkyGt/HsDUPoE+cpmCsW3vfzjm7IzliQM2Jy02ykf5tYqY8V8pQA2eBmbqynBcy6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY+QSwRJVm95ALeU/2Yy/DZdNk0yJaXh3OijWva3qjo=;
 b=bpi0a/7YZoRvgX9acr0mvkBTPcALMdjQ7By8hdsQ9mYxOQLq07KO5lTu9BemmdIQYnS08mmGy4MoK/Ek0AaUeqk/yKb8Ztg1ehKsyikws1R+WuOL0a4toRub8qtlPdbglsEdZB0A8OvOyfQ7wB+KYJUPCc2Iui1Wcud3gfbAhU81uBlmYFhsQh1eGsKZiNI1rw/hzNa881CZKjy/8vro5f4h8Y34hLcS1+8YjIn0a+PECX7U1UZa8nHLYXRskuGqaWazHZ5HpklMgr7LjRyzNj5J3X/4QAJM3vJfrn5I3gZ0NDNS63n3lZcJecNBnfkPGHPQcl8IMj3EnfCjl4EyJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY+QSwRJVm95ALeU/2Yy/DZdNk0yJaXh3OijWva3qjo=;
 b=fMPP+d2fvarp/qSCD/WbKymlc6z4V4KyALnSoZlXo2ENQodovWmrnU7fK7fk7JYRV/8jplcoxbT5MCPyTd/puv8bBn+adWuhqaD3VEEOydKFAatrljXBWS7jfK8p7w0Jubvwmk+XY9PoCkF8DY+P3OofSPDuAj+bajDLPiK/Ju4=
Received: from SEZPR03MB7007.apcprd03.prod.outlook.com (2603:1096:101:ac::12)
 by TYZPR03MB8491.apcprd03.prod.outlook.com (2603:1096:405:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 08:49:45 +0000
Received: from SEZPR03MB7007.apcprd03.prod.outlook.com
 ([fe80::641d:833a:915c:d1f0]) by SEZPR03MB7007.apcprd03.prod.outlook.com
 ([fe80::641d:833a:915c:d1f0%5]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 08:49:45 +0000
From: =?utf-8?B?WmhlbmduYW4gQ2hlbiAo6ZmI5b6B5Y2XKQ==?=
	<Zhengnan.Chen@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"krzk@kernel.org" <krzk@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: memory-controllers: mtk-smi: Add
 support for mt8189
Thread-Topic: [PATCH v2 1/2] dt-bindings: memory-controllers: mtk-smi: Add
 support for mt8189
Thread-Index: AQHcRzt79okpwIs0qEmglj34c7ujN7Ta6kmAgAKgLIA=
Date: Sat, 1 Nov 2025 08:49:44 +0000
Message-ID: <099d22558c6f57c770ca3e552bc0731318d90f46.camel@mediatek.com>
References: <20251027121443.16783-1-zhengnan.chen@mediatek.com>
	 <20251027121443.16783-2-zhengnan.chen@mediatek.com>
	 <20251030164353.GA4119862-robh@kernel.org>
In-Reply-To: <20251030164353.GA4119862-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7007:EE_|TYZPR03MB8491:EE_
x-ms-office365-filtering-correlation-id: f0f08fc0-37cd-41e6-d850-08de19239b0a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SjlJc0dseGFqajNqaHNtUXdrSFlURURKRm85a1N2UGtpZ3oxaWIwNzFpOW9y?=
 =?utf-8?B?cjIxanFxaFVzczc1ZVpCeVVuMTMxVW92S3VLbStFSTgyY1M0ZTQwcTRFUWZw?=
 =?utf-8?B?TFl5dTI0QW14VHY2NkY3R2lGaXhGNkk1ckdtQ0dSV0FPNFhIRnprcnI2MGZw?=
 =?utf-8?B?T2lUdHFzeXlpTW1PUE1TZTZ3ZDBaekJyNVg5N3ZIcE4xU1dSUWNvSjUzQ0do?=
 =?utf-8?B?b0hEYTVIclVsMEgwL0x6T2xzUm1kaTl0TitzQlY2Y0c0YlgzRTNSWE03L3pU?=
 =?utf-8?B?cGwzcnlrVlJkVnhPaUIvdll0RFB2ZzZySmIzWklWdWlRL1NOY0l6TmZiTVFJ?=
 =?utf-8?B?VlR5d09qQVQzS2pJMExVYWx2UUd3U0JKVGt6SGJzWE9BUThIcnhnUUx4VjlY?=
 =?utf-8?B?aUNJNmtNdUtjMXlDcWVaaThpd2pxYTh2VGwwT0c2M1ZaWWthcmp3cTRkWXBD?=
 =?utf-8?B?U1l3Vm5FcGtZOElpTUVrZWJYN1BJL0VrbERZbU5YWG1MNWM1c1NQbXV6LzZk?=
 =?utf-8?B?YnRpOGdpUGY1ZTJPOE0wS2dJcXRzS0NoT2ltYlNweVhjMktwdVJQK1ZIaG5q?=
 =?utf-8?B?V2dzNGxCVVJPaVNKRjdVNzBITWo3VnBNZStaeWtqZmUzNnFVckZaZklOMWpW?=
 =?utf-8?B?eGt6TFg4dG1PcDg2V2d3RTN0Tjk0U2Y5YThaTnhScE9UN3VmWnpWcTVBbE1s?=
 =?utf-8?B?YWZ6UHZjWVB2V2kxT3RhanJmVGpqZXZna3ByS1YzQWNsditkSW01QXArTVlk?=
 =?utf-8?B?NTVtN2hGbmZsd21UMXJEZHkxZnltc3gzaUZTODA3bm54UUZkVTJtYkRzQ0xl?=
 =?utf-8?B?Z2tqR2d2WTBGbm1kQXJJU2xLV2ZsUGx5S1dZNUdkdmVxT1c5UzY2WnpySDVG?=
 =?utf-8?B?ZXc2aHExY1UxTnhyNlVMNnIxUnd1Zno4WkkyRzNlVFFVdzZ6MXdpNEFGV0Rs?=
 =?utf-8?B?YjU3OE1xL3Q4bW5xeld3bWd2SFFoTndQNHlxNnV2U2VpelU2dHNDcnRBYlp5?=
 =?utf-8?B?Q05RZ0FwbGkxc2F1UGlhWVBHZTJYeTFJLzZiSGVzZ3dFREorTW1xaTRYelNy?=
 =?utf-8?B?ZzhXcGY0b3FvNU84N3A5VENnWExhUmR6ZzRoRzZYT3hHcFZjUXBTZFJ1YWpu?=
 =?utf-8?B?MGwzRklGWnE5STVMb0xzekM0cTJqbVpTYmxRR3BDZnVOdktxL2JRS2JFYUNO?=
 =?utf-8?B?WndjZm13U3BmS1huN2w3VVpudDBsb1R5ZlRvQVNZdnh2NHI0V1BUNlNNZ0Mz?=
 =?utf-8?B?NENIQXRlRVhyS3RXdHFGc2dpM0MvdmF2T0p6UE9DcTQzbDdSQ1hZeHl2cTBj?=
 =?utf-8?B?VGVEQ1ZLZDF2VGZmd1BhT3dLazJselNsRVYrZWxMZjJNYWhxRzMwbGs4N3hM?=
 =?utf-8?B?TldlZGphWEhvaDQrUDUvK0pTZ1h3a1cvRCtJeEFHL2xvRTZpZzNwT1ErU1dm?=
 =?utf-8?B?Q2FkY3pVRlp4YnlJTzkzQW1VaHVMR3YrOHlEVlpucCtyWmdsOEJqUmxqRnJM?=
 =?utf-8?B?WkFkcTNiRUw2RDk5ODk1YVZneGZmSDdheXhvWDdGOVBhTFgxRG0rZUtNYnZN?=
 =?utf-8?B?YmxoWmdpTnRwU2p2Y3M3ZjRFM0E4eTIrakFVdVB5cmRNdW03UWl2YlRlMlMv?=
 =?utf-8?B?ak15SVZZYXN4dDFjYTZjTjd2RDdja3RoUFBwQkkzVEg5UjNwbFJLc0U5akdH?=
 =?utf-8?B?ZG5OL0VMdVhJZXRWT0pIMFQ4R2dIZlJxTHNWNjRPK0ljR0VpWU83U0RuajJK?=
 =?utf-8?B?TCtIdWZyOEpVdTVDVFJjWTZ1Qy8yVUVLbkNBdWlod3lhd3cvc1kxL1hSWGly?=
 =?utf-8?B?TEVPVm9CcFhPWVRUajZqVVcvWEpSYWVZMEpVNndHR2duQ29LMkEvT0lXNjhL?=
 =?utf-8?B?UHp3NjlyQ2lxV0hOa2w2MW1VOWw2a2JHN2xxaHd4aXBnZExJcHI2Ly9PRHZR?=
 =?utf-8?B?VGZXeENFTHFWOXczRzFuUE5jS2RNRlJzRE1ubVptMUEyYU5LZWxRQlVFODcw?=
 =?utf-8?B?UnNZSk0vaENRWXI4R3NoNWY4S3BKKzdXakdGU3RXQmxsVENta2Y2M2pYNGNE?=
 =?utf-8?Q?wB7dCh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7007.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGhYRk9jZ2xTWWhPamFidldiU3h2R3ZSWFRuK1dLVUs3MUdhWTB6aGJEbzZu?=
 =?utf-8?B?MW1zTGtRelk2TnB5cWs0QVhhNVI5OGw3N0tIMkdUTjRMWm9KenNBSVdBL1JF?=
 =?utf-8?B?NTlmQlpzbFVxMXlsS2xKbzRRcTczamxYM2JFQ1JTbWxIajRUVnpSN2FDNXVt?=
 =?utf-8?B?ZVlXSElHUXp6NmhIVFhsSmhmZGNkT0tIMFJaSy8xL0F4U2p4K0VsVW9ORS9U?=
 =?utf-8?B?L3duNFVTbkFkaWZhM09JbkIvaCt6TkY3U1l3S0xZYTZBSERtV2l0TCt5bHE0?=
 =?utf-8?B?U0FyamJVMTQyZkMyZTEyRUxIaldaWHZvMEp0MDNWS2d4L2NydG16ZmwxcCtN?=
 =?utf-8?B?MGdGKzlrd1ZMOWxhcHpUS0FKNTB2TnZub2xqRkR2YUNvWTAzQW1pNWwvR2h5?=
 =?utf-8?B?b2dBWVd5Y0s2bGRDSU5Fc3hTTDg2Rkdjd2l4cHRwVnJQSzVLYzBpaXp3dnp2?=
 =?utf-8?B?OXI0ZmFQaHZWVFFWSnltRHNNL2hWRVRuUGpWR3VvS2kxWURlRnZ5NUJSU2Vl?=
 =?utf-8?B?dFB0S0ovZDJwYWNHRDZ4WnY0cW5UN3lQOUkrQlFoZVpGUVJ0VHpiS3BkS2hI?=
 =?utf-8?B?dWM0QVpuVFV2aDR3T0tCcEY2c2R4ajZLNEZXMEU3MnFwMUxheUM5YUhITHo0?=
 =?utf-8?B?Y0JmUzJ4ZnZJVGdTNkx5UFFFN2RNM1NzanN6QmI0cnBZUHdwc3BhTW43THFK?=
 =?utf-8?B?VEw4MmQvMEZIUHZ4cFFaV2lUMksyV2pFSHV0ZW4yalVBcUlhTWZHaTB4c2xH?=
 =?utf-8?B?R1owRCs2aDA4VnA1VlJRY3cwL0hYazVUMDhSMk5mSkIvZGVIVXpmQzR6cGty?=
 =?utf-8?B?YWp5dVA3K05zUThQUE1Fb0tCb3Y3ak9rSS9DeERIeVJycWViVzBZdVM4MjBD?=
 =?utf-8?B?MHdkeG1qbmVlNy82anlxSlpjRVlIeUl2STg5WURQeHdxN3dXL1pZVVJxUHdD?=
 =?utf-8?B?S2g3MWt4dEczV29VSHRFK0tIcGorcktEdGxuK2lCczB5OGZxb25FQm1hZmxy?=
 =?utf-8?B?S1ZYNkxBd3hTejlpRjBGYnFSaXVSdElrOVA4SCsyRzlDdUlaNE9pQm5kYzhE?=
 =?utf-8?B?ME5mMUVCcjU0a2dNU3N4d084VThPakpvQXVhSkNqT0l5Si9YUGVxd0s1bXRp?=
 =?utf-8?B?NjJ5blVRbEdQNDNrNytCRSs2NHQrNGRjUVJhWGs3ZFdDbEpxNU5NZitTcDFr?=
 =?utf-8?B?M1VvQkt1dFdDQytpWXQzZU9WTWw4WVg2UDAxdWJmeGZGUlVFcFB1Q2s5V0Fx?=
 =?utf-8?B?d2tkckpWc2IrRzNYQ1VRYWFNL1N0Q1M3VzVEWkhYTFF4U3NJNWNtWHdVZGZr?=
 =?utf-8?B?TTJsRFBSUm5ZTDNqZmpiMmRLVUNINTFBc3JXTDJlcDhwaW4yMVZKUHVNckxD?=
 =?utf-8?B?WVBuWU5sL0dNVk01TDJKWVlaZDFBVGtuMHdnczluZzRPOFJLMml2NWU4emcy?=
 =?utf-8?B?UlFDR0REK3Zsc2xtekNuUXZzY2JrMVdGSEIrVThtQ2o3NHFKWmgxc2M3QVVq?=
 =?utf-8?B?cWk1SzlET3dFVGcrMVhrWldJRFErSEpNZVMybzhKZW8rSkpuL3pZVkYwcTEz?=
 =?utf-8?B?aVp2bE9tdjJzTVFMOTJaU0tHcHgzbmVHTHBUaGZCWDZ3TzBzWGxpRW5EYTd4?=
 =?utf-8?B?N3VWZ1ZXbjhZN0lENGVlMnE5cW1PYzJVbnUwaitMWEVZbVdjVFZlN256RUZa?=
 =?utf-8?B?Tno1cWNvSzByNDJvVWJvdXgycUM0ZW5FZXhmanZSSjhjOEhkU0RTd0VVLzZK?=
 =?utf-8?B?dFJRZWpPNkFyZmdGeUY5czFSL0UxUEt5R0huYmFGeDdVSEFVakt1endhYUFp?=
 =?utf-8?B?dVV6MGVlb1d4YldETWdkeG11eGJZdWFuR01ab3NQTFNvZ2NlYW5Ea28wWFcr?=
 =?utf-8?B?VHFsbUFFRDBhdVJjbFpUR044cXJVbTFUQ2hKQ0xGUEFlQWVNd01IMHBWSnd6?=
 =?utf-8?B?eVNUUTdHckRsQlNWUlAyYlBVek9ZdFd0Y2gyVFNuWXlVK0NsMHZOR3BVWUdH?=
 =?utf-8?B?czdQNUIxU0Y3NC94cTBJTTZTb2g5RDFGWlhSclY4bFRwdWF6ZDE0UmpJWFlV?=
 =?utf-8?B?TTUwQkpzeW13MThGbTg1MXZzY3NqMVBNbXd0dmFpMU1jdGhFczB0NUdrc0ZX?=
 =?utf-8?B?MlNVMndHdmg3VC9yL0J3RE5HVVpReko1d2F2RW9RY2ZLRFRwRGlKam8wUWQ5?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E2F668070DC6140AA9F91234BD47C15@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7007.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f08fc0-37cd-41e6-d850-08de19239b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2025 08:49:44.8661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNtQfo3MQtasfI8DdNeplDsEXsf/ROUD8srPWHDJs+nU6iNPJY/IdjU1fj1qaQBaRdg8IqENXV7Re9eKFd/fGkJn9+PCeYhprls+h7pfPf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8491

T24gVGh1LCAyMDI1LTEwLTMwIGF0IDExOjQzIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiBNb24sIE9jdCAyNywgMjAyNSBhdCAwODoxNDoyN1BNICswODAwLCBa
aGVuZ25hbiBDaGVuIHdyb3RlOg0KPiA+IEFkZCBiaW5kaW5nIGRlc2NyaXB0aW9uIGZvciBtdDgx
ODkuDQo+ID4gDQo+ID4gVGhlIGNsb2NrcyBudW1iZXIgb2YgbXQ4MTg5IHNtaS1zdWIgY29tbW9u
IGhhcyBhIGJpdCBkaWZmZXJlbmNlLg0KPiA+IEl0cyBjbG9jayBjb3VudCBpcyAyLCB3aGlsZSBt
dDgxOTUgaGFzIDMuIFRoZXJlZm9yZSwgdGhlIG1pbmltdW0NCj4gPiBudW1iZXIgb2YgY2xvY2tz
IGlzIGNoYW5nZWQgdG8gMiwgd2l0aCB0aGUgdGhpcmQgb25lIGJlaW5nDQo+ID4gb3B0aW9uYWwu
DQo+ID4gDQo+ID4gQWJvdXQgd2hhdCBzbWktc3ViLWNvbW1vbiBpcywgcGxlYXNlIGNoZWNrIHRo
ZSBiZWxvdyBkaWFncmFtLA0KPiA+IHdlIGFkZCBpdCBpbiBtZWRpYXRlayxzbWktY29tbW9uLnlh
bWwgZmlsZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGVuZ25hbiBDaGVuIDx6aGVuZ25h
bi5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiBIaSBBbmdlbG8sDQo+ID4gV2UgYWRk
IGEgZGlhZ3JhbSBpbiB0aGUgc21pLWNvbW1vbiB5YW1sLCBXZSBhcmUgbm90IHN1cmUgaWYgeW91
DQo+ID4gYWdyZWUNCj4gPiB3aXRoIHRoaXMuIHRodXMgSSByZW1vdmUgeW91ciBSLWIuDQo+ID4g
DQo+ID4gVGhhbmtzLg0KPiA+IC0tLQ0KPiA+IC0tLQ0KPiA+ICAuLi4vbWVkaWF0ZWssc21pLWNv
bW1vbi55YW1sICAgICAgICAgICAgICAgICAgfCAyNQ0KPiA+ICsrKysrKysrKysrKysrKysrLS0N
Cj4gPiAgLi4uL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi55YW1sIHwgIDMg
KysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21lbW9yeS0NCj4gPiBjb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnlhbWwNCj4g
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktDQo+ID4gY29udHJv
bGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi55YW1sDQo+ID4gaW5kZXggMDc2MmUwZmY2NmVmLi40
NTRkMTFhODM5NzMgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21lbW9yeS0NCj4gPiBjb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnlhbWwN
Cj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LQ0KPiA+
IGNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24ueWFtbA0KPiA+IEBAIC0yNSw2ICsyNSwy
MSBAQCBkZXNjcmlwdGlvbjogfA0KPiA+ICAgIFNNSSBnZW5lcmF0aW9uIDEgdG8gdHJhbnNmb3Jt
IHRoZSBzbWkgY2xvY2sgaW50byBlbWkgY2xvY2sNCj4gPiBkb21haW4sIGJ1dCB0aGF0IGlzDQo+
ID4gICAgbm90IG5lZWRlZCBmb3IgU01JIGdlbmVyYXRpb24gMi4NCj4gPiANCj4gPiArICBUaGUg
c21pLWNvbW1vbiBjb25uZWN0cyB3aXRoIHNtaS1sYXJiIGFuZCBJT01NVS4gVGhlIG1heGltdW0N
Cj4gPiBpbnB1dHMgbnVtYmVyIG9mDQo+ID4gKyAgYSBzbWktY29tbW9uIGlzIDguIEluIFNNSSBn
ZW5lcmF0aW9uIDIsIHRoZSBlbmdpbmVzIG51bWJlciBtYXkNCj4gPiBiZSBvdmVyIDguDQo+ID4g
KyAgSW4gdGhpcyBjYXNlLCB3ZSB1c2UgYSBzbWktc3ViLWNvbW1vbiB0byBtZXJnZSBzb21lIGxh
cmJzLg0KPiA+ICsgIFRoZSBibG9jayBkaWFncmFtIHNvbWV0aGluZyBpcyBsaWtlOg0KPiA+ICsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8IHwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzbWktY29tbW9u
DQo+ID4gKyAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gKyAg
ICAgICAgICAgICAgIHwgICAgICAgICAgfCAgICAgICAgICAgLi4uDQo+ID4gKyAgICAgICAgICAg
ICAgbGFyYjAgICBzdWItY29tbW9uICAgICAgLi4uICA8LW1heCBudW1iZXIgaXMgOA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgIHwgICAgIHwgICAgLi4uDQo+ID4gKyAgICAgICAgICAgICAgICAgIGxhcmIxIGxhcmJYICAu
Li4gIDwtbWF4IG51bWJlciBpcyA4DQo+ID4gKw0KPiA+ICBwcm9wZXJ0aWVzOg0KPiA+ICAgIGNv
bXBhdGlibGU6DQo+ID4gICAgICBvbmVPZjoNCj4gPiBAQCAtNDAsNiArNTUsOCBAQCBwcm9wZXJ0
aWVzOg0KPiA+ICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODYtc21pLWNvbW1vbg0KPiA+ICAg
ICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtc21pLWNvbW1vbi12ZG8NCj4gPiAgICAgICAgICAg
IC0gbWVkaWF0ZWssbXQ4MTg4LXNtaS1jb21tb24tdnBwDQo+ID4gKyAgICAgICAgICAtIG1lZGlh
dGVrLG10ODE4OS1zbWktY29tbW9uDQo+ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OS1z
bWktc3ViLWNvbW1vbg0KPiA+ICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTItc21pLWNvbW1v
bg0KPiA+ICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtc21pLWNvbW1vbi12ZG8NCj4gPiAg
ICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTk1LXNtaS1jb21tb24tdnBwDQo+ID4gQEAgLTEwOCwx
OSArMTI1LDIzIEBAIGFsbE9mOg0KPiA+ICAgICAgICAgIGNvbXBhdGlibGU6DQo+ID4gICAgICAg
ICAgICBjb250YWluczoNCj4gPiAgICAgICAgICAgICAgZW51bToNCj4gPiArICAgICAgICAgICAg
ICAtIG1lZGlhdGVrLG10ODE4OS1zbWktc3ViLWNvbW1vbg0KPiA+ICAgICAgICAgICAgICAgIC0g
bWVkaWF0ZWssbXQ4MTk1LXNtaS1zdWItY29tbW9uDQo+ID4gICAgICB0aGVuOg0KPiA+ICAgICAg
ICByZXF1aXJlZDoNCj4gPiAgICAgICAgICAtIG1lZGlhdGVrLHNtaQ0KPiA+ICAgICAgICBwcm9w
ZXJ0aWVzOg0KPiA+ICAgICAgICAgIGNsb2NrczoNCj4gPiAtICAgICAgICAgIG1pbkl0ZW1zOiAz
DQo+ID4gKyAgICAgICAgICBtaW5JdGVtczogMg0KPiANCj4gU28gbm93IDIgY2xvY2tzIGlzIHZh
bGlkIGZvciBtdDgxOTU/DQo+IA0KICBObywgdGhlIG10ODE5NSBzdGlsbCByZXF1aXJlcyAzIGNs
b2NrIGN5Y2xlcy4NCiAgVGhpcyBhcHByb2FjaCBjYW4gYWNjb21tb2RhdGUgSUNzIHRoYXQgcmVx
dWlyZSAyIG9yIDMgY2xvY2tzDQogIHNpbXVsdGFuZW91c2x5Lg0KDQo+ID4gICAgICAgICAgICBt
YXhJdGVtczogMw0KPiA+ICAgICAgICAgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgICAgICAgbWlu
SXRlbXM6IDINCj4gPiArICAgICAgICAgIG1heEl0ZW1zOiAzDQo+ID4gICAgICAgICAgICBpdGVt
czoNCj4gPiAgICAgICAgICAgICAgLSBjb25zdDogYXBiDQo+ID4gICAgICAgICAgICAgIC0gY29u
c3Q6IHNtaQ0KPiA+IC0gICAgICAgICAgICAtIGNvbnN0OiBnYWxzMA0KPiA+ICsgICAgICAgICAg
YWRkaXRpb25hbEl0ZW1zOg0KPiA+ICsgICAgICAgICAgICBjb25zdDogZ2FsczANCj4gPiAgICAg
IGVsc2U6DQo+ID4gICAgICAgIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgbWVkaWF0ZWssc21p
OiBmYWxzZQ0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWVtb3J5LQ0KPiA+IGNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlhbWwNCj4gPiBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktDQo+ID4gY29udHJvbGxl
cnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbA0KPiA+IGluZGV4IDJlN2ZhYzRiNTA5NC4uOWE1ZGFm
ZDdjMDdlIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tZW1vcnktDQo+ID4gY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbA0KPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktDQo+ID4gY29udHJv
bGxlcnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbA0KPiA+IEBAIC0yNyw2ICsyNyw3IEBAIHByb3Bl
cnRpZXM6DQo+ID4gICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4My1zbWktbGFyYg0KPiA+ICAg
ICAgICAgICAgLSBtZWRpYXRlayxtdDgxODYtc21pLWxhcmINCj4gPiAgICAgICAgICAgIC0gbWVk
aWF0ZWssbXQ4MTg4LXNtaS1sYXJiDQo+ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OS1z
bWktbGFyYg0KPiA+ICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTItc21pLWxhcmINCj4gPiAg
ICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTk1LXNtaS1sYXJiDQo+ID4gDQo+ID4gQEAgLTg1LDYg
Kzg2LDcgQEAgYWxsT2Y6DQo+ID4gICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTgzLXNtaS1s
YXJiDQo+ID4gICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg2LXNtaS1sYXJiDQo+ID4gICAg
ICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXNtaS1sYXJiDQo+ID4gKyAgICAgICAgICAgIC0g
bWVkaWF0ZWssbXQ4MTg5LXNtaS1sYXJiDQo+ID4gICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4
MTk1LXNtaS1sYXJiDQo+ID4gDQo+ID4gICAgICB0aGVuOg0KPiA+IEBAIC0xMTksNiArMTIxLDcg
QEAgYWxsT2Y6DQo+ID4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDY3Nzktc21pLWxhcmIN
Cj4gPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4Ni1zbWktbGFyYg0KPiA+ICAgICAg
ICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXNtaS1sYXJiDQo+ID4gKyAgICAgICAgICAgICAg
LSBtZWRpYXRlayxtdDgxODktc21pLWxhcmINCj4gPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVr
LG10ODE5Mi1zbWktbGFyYg0KPiA+ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTk1LXNt
aS1sYXJiDQo+ID4gDQo+ID4gLS0NCj4gPiAyLjQ2LjANCj4gPiANCg==

