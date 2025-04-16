Return-Path: <linux-kernel+bounces-602921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3A5A88109
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 15:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0B53B7DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 13:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAE3433CB;
	Mon, 14 Apr 2025 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iL+X9A+w";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Z4Nh/tgg"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6DD383A2
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635747; cv=fail; b=oLdRuWaFBrUkgmstRdZJ/X2Kg9qLj/jgQw5KvUmzKhWo7hHuK+lYG/g1lysNKziH5jmiudt0gzfINTshGHtSp1cc48hKUTPiBdgYt7wmq10krluskbaC3icDylLAaeE4Y1jU7GUdJ2WzQVbaiMLBAHnobL2A4IHBhjxiOqAh0/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635747; c=relaxed/simple;
	bh=fbYkN+QpdtPYTZgcznKEbZpmbe8as3X5sRUiAr621qE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fOAjhAveLGNu7J0lLVpwl7/tKZfTfEzAnFlXm9Zl/yFYss1DxAWQHG4z2QkgUweTfKNMv5RC1h+DCr0Y4j0bhfe//sCRnaNMbtCMA15wz+KXswRQcjN2hE5nKoxKkElUiBK/9c5vHRlgczvO2BMdIZCbdFgiJippIXWfjRVn96M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iL+X9A+w; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Z4Nh/tgg; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b30edc30193011f08eb9c36241bbb6fb-20250414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fbYkN+QpdtPYTZgcznKEbZpmbe8as3X5sRUiAr621qE=;
	b=iL+X9A+wu1FC4qnxsi0jkf+L41Pa2+f24zOzi5MzpAFIXBrGVrWADxDRUEEeqm+edt2QxJmTkcAzONhKnLK3ZNsac9ygmJcPlQrptvwJotkgzDGSCAmjpBkOzAzV1P8UX0H0cieZ5z/D8vA714iR3Zqc/0gAg2Aw1i4x+rcr3vk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:b1f0b658-282b-4518-84b4-1ff0a9e8ad9c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:d7268ec7-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: b30edc30193011f08eb9c36241bbb6fb-20250414
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 411366745; Mon, 14 Apr 2025 21:02:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 14 Apr 2025 21:02:18 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 14 Apr 2025 21:02:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtS3pZ1RijVTSLsFAmGxKM+mfKb89LGm8JoaP1epnwW1WOZVcQlL4LhK8wRy4yj3TdFvRyhF9pV3jfWOxiHmXB5f09QIioVYX09d7vyMQoDd7T+JRRhDTRwfx3g3T9BsdiHVgv/Gnmn3kBLzdrWdBCFV7jkGJUDxa2Q1khMw9M1WjxBOBRb10vJPUD2n0Vjad6lOdbwgzYtDshoKQxrUxDIoN+IfWHr6AzkzD9nACnFk1LxCpqdi+0f+W1yxNqGk5FvFbrGVC4sHmJYzrgu1ATRr4Md5X4CWnUQ1p+TmqfZ4rjhVvnnffSTA6zO4j8R7875/qFlG/8S6lF98MXikhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbYkN+QpdtPYTZgcznKEbZpmbe8as3X5sRUiAr621qE=;
 b=Zr3MV51+Z+z+OZR0+UFxqm9kMvMxJcyCW0Hu2M6/xaLlRGM83knWUfp83nIjU8/VyU0LLv/FSCrcU790B1992wPc9aKNnd0klZgCi27sPHIJ+lLM50kF6XVitb+iQEKKoEtttphnYRMMYLwKDYja85gxEQU1wkik9EWTsBc4gX8o8MU0VLUFoqHz73xFxLRBVYL+uZk7HFNemKVAQSa5u/eWgIeGZy0lJq5kawdU77as7BwEcjYlpHGxV1GAT/CgeCUVV5fWW0QYnmO7qYHN9aNAZTIY2l7ckoaI+ML/wcBJANm8Ri/joaW2x4vm9rs9GviB3XTiUxo5VFO5GOZBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbYkN+QpdtPYTZgcznKEbZpmbe8as3X5sRUiAr621qE=;
 b=Z4Nh/tgguKmePOKf5q+5FYpHdXCjR2eVdf4aPQuNglYXE/bCNNjkv1ZUtFkPV7x+NVTqZZW5EvQFmuZOJV+OvCr+r+PRYXnPGTaLW5TDvT7zg3GUyZZa+JYhAyAPY/PdOwCXKaKZ7jb7WO1YCpNpYKgLvKSiZ5+yUi3rznRHZz8=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by TYZPR03MB8464.apcprd03.prod.outlook.com (2603:1096:405:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 13:02:16 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350%5]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 13:02:16 +0000
From: =?utf-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= <Tze-nan.Wu@mediatek.com>
To: "oleg@redhat.com" <oleg@redhat.com>
CC: =?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
	"brauner@kernel.org" <brauner@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, wsd_upstream
	<wsd_upstream@mediatek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "chenqiwu@xiaomi.com" <chenqiwu@xiaomi.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [RFC PATCH] exit: Skip panic in do_exit() during poweroff
Thread-Topic: [RFC PATCH] exit: Skip panic in do_exit() during poweroff
Thread-Index: AQHbqibEtkPx8ADgEUO33Q74Ap66W7OdZC0AgAXCaIA=
Date: Mon, 14 Apr 2025 13:02:15 +0000
Message-ID: <249567d33e088a340780456c7ecd3ef3ee1433a1.camel@mediatek.com>
References: <20250410143937.1829272-1-Tze-nan.Wu@mediatek.com>
	 <20250410210507.GD15280@redhat.com>
In-Reply-To: <20250410210507.GD15280@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|TYZPR03MB8464:EE_
x-ms-office365-filtering-correlation-id: c612a0ad-26c7-4652-8b30-08dd7b5494c4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Nkdibit5c1NkSENvYzM2VDVQTi9mZTM4RXBiMEFPNUpNOU1ZZzdqZDBIU2s5?=
 =?utf-8?B?WTBsY3dUVWRMazdlcTduUFpKcG1rd0wyMU9ST1kxVnQ2UE01WGVha1QwczR4?=
 =?utf-8?B?TkZuc0l1WnBBdjk4TjF5TDNzUFpvQjRwcFNJekFrdGhTaEZsaERaRnlubUsv?=
 =?utf-8?B?OS9mbTBwc3BRU1lML1RBekVnVUpZaUlmUFV5Y1pyNGpORFE5a0xoV1BvWG8y?=
 =?utf-8?B?alJnRmNqWWI3aVY2ZGgwTTZkaVVRZmpuZUs4MUtSVDJOZTFwMkR0a1RiU3Fi?=
 =?utf-8?B?dUFQbWlxRm9hWTRnUDRxMVk4U0UrM090ZnhQbnlNUVhJQjRLTU1WemFXczQ0?=
 =?utf-8?B?UG1ya1NoYVQ4TjRpQ21KK1F0akNTcHNmWlB3bklVd3V2a1U3ZEc1cUlaWkJ3?=
 =?utf-8?B?V2FSYnhON0puN1M1WGV0dlVvdUp4aWFBalVkN09XcTMwZGFFM2JUeEo1T2hk?=
 =?utf-8?B?cTI5VnBDbTlEYTFhRWpRSWtLYTRBeVA0YmVzbE9URGF1eUg5dUZDK2VScGdS?=
 =?utf-8?B?bUxxZnVjT2NaWkNDOUM5WmY1NzByRFdEUzVSRDRUUWNGcnY3b1Z2R0YzM0tQ?=
 =?utf-8?B?cjFRa2NjMlpxRi9vOGpRaWRxTXpMTVNhWVl5SHppR1ZBSnZxUnUrV3hveGFP?=
 =?utf-8?B?UnpZcnBYUUcrN1ZWOVYxTnZ6VVorWGgyS0dMVG94L2tUK1g1QWtKN01FZHVK?=
 =?utf-8?B?UkNTaHVmU2lIdktvbTIwcE4zYmVTSEtvZ3V0dXpheEFlVnFha3haK0FVajhk?=
 =?utf-8?B?aTlNSUJUSXJSa3pGaHh2SGpHVmtlS1NKWllpVDEza1QwUUpWSXhQaFBUQ0Nl?=
 =?utf-8?B?UVRibElqZlBONWhxdEpYYlBDT1BFdkVyQ2Q1OGtPcXZkTTJvZkFVZldNQk5w?=
 =?utf-8?B?dE8zV2VZWThVemV5TkFLOFMwSzh3WmxMdzF5em5SY2lxZTd0WGxvSlJTZmlo?=
 =?utf-8?B?aGVWZTNvdCtGT24vbVBkNUJzS0xsMUtrL1VBSjNLZkhtdE1qWkIraXBKSGs1?=
 =?utf-8?B?NGlYN3lhUHZIaHM5cnhyMEJLQXBYM1MxOXRVdkdlVko4UnkzejdkZ1RQT1V5?=
 =?utf-8?B?cWdKaFJNYUV5cUY0WXFpUnlZWTVZaTY3MWNqV2paWnh3cnJraFFheVM2Y1By?=
 =?utf-8?B?WCttTnVtbGxNa3FsUG45L0xBQlBzd2ZOQU5YMmxuSWw0akJDVCt1dCtma2Z4?=
 =?utf-8?B?UTJWcDVCcVFNY3Z0TWQrdysvZHN1b0s4WUdVQ05pdWNacFV4dVZIVGJ4dnJu?=
 =?utf-8?B?K1BuUWtyUE1RSnlsR0xkL2lKR0dlREwvc0Q4MDRrWWo4Q28yNWlXUHlpRkZm?=
 =?utf-8?B?SUF2cDBoMmRpNXIzdmV6K2tIM1ZYWVAydHVnYWEzMHh1cXkwNjVheVhud2Zk?=
 =?utf-8?B?YWd0WVJPMlZuL3RUczllQUh4WG1HR0kwcFRyQUszT0o3bVRlNzhoeHlaTDRD?=
 =?utf-8?B?OCtaYmNGWnAyTnp5dW1YdmFmeFliZ09KOGxrZUVHcU0vaHJIQ2pGa1ZvUnZB?=
 =?utf-8?B?V1JTWlQ1OUtQVk5kbHZ4eXZXWjNqR2J2WjQzam1HUVN0VkozZy9NN2YvalpW?=
 =?utf-8?B?U1ZoZmxPU3EyVGgyckg5M3FQNmRHeU02TXpSMU5RdHlaK0xhSk1vMjk0Z3Uy?=
 =?utf-8?B?OVlhdVVXUzArVk1oWmd3WGZ2cG1KbWY4MDhsL09jR0dzSHJZcjBnak5zTUZj?=
 =?utf-8?B?bUx0ZTgyLys4TEN2b2VxSkZMVFdKdXB6TXV6ZHN4ejJEMlU3c09ySDVaQTFV?=
 =?utf-8?B?OThMejlsSU1UK0dER3lVVGl5cmo3SFUrTHJUMG1RZURmWndwaGxEdTM4eEFM?=
 =?utf-8?B?RTRBRm4vYjJSU0FDRVhPZElsSFFTaGc2RnI2bTYzcVlsTXNTMGo2QVdUSkgv?=
 =?utf-8?B?eU1xcFNNTk1uOWpKbzlzN09JSGRjbmF2M0NwRCswSXhOSDZaaUpWeWNBaHBV?=
 =?utf-8?B?N01OakxxeVU0V2FwZWNjM25JMXhlUlVHUy9iRW0yUjUyWjRUcTdhbll3K1FP?=
 =?utf-8?Q?Yy+4mE4uwyYZ1CpC5EHe7AxHpGZjnc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXBzTlQ5SWRZNUl1VWVGRnFkUXIvUUtyajVEUG9hWmVZZmQ5TitFYk40ZVl6?=
 =?utf-8?B?NFJuS0RJMkF0WFo3MlVyZDhiMWUxWDd0bm56N2dLYVRCT2RvY2lKZzdtbTIy?=
 =?utf-8?B?QVdXWUo3M3NMaFAzR3I3YzJieVhNK0h6MVhrWnZzK2ZKTHRsbk1CRzVHa2dJ?=
 =?utf-8?B?SXlOVG84SVgzTDRzdlErbVRJeEh5bnpSY0VUc01QZGtqSkJNNWQ2TTY2VkdC?=
 =?utf-8?B?YnR4U3UwUmpnRXQxeS9uMWxWM1NoWlpSdUdjMElkMjNSWkxMSzd1Z1V2akJr?=
 =?utf-8?B?d05ubm1wdHdnUFhNUk5jYjhsdkcwbUJac2Z3NkhFOVB4Q2dralo2WjBYbzVt?=
 =?utf-8?B?azRCM01HMWZHWEM1K1NmSkFwMzBtU0ZRaUNKWGhodTg4MHdPVm5tZDRHQVJV?=
 =?utf-8?B?NGNuR2V1QlJ4eUlRVnY4amxqc2IzUWwvd0hCbjczbW56VUt3Z2VBOHkwUzJI?=
 =?utf-8?B?alZOek1pVlNGWm50WTlJN1EzV08rSkRTZW1GeFl1YW1CaGQ2N09MV0hqT3Za?=
 =?utf-8?B?R29IYldKOEZiS1MzVE8vak1IeVNyNjliMlVjODdzd21BaWJFaGFaTENGM0VZ?=
 =?utf-8?B?VEN2MW02MDVIMUQ5WXYrRGlIODFqM0RvV2R6SlEyNVJxZ2w2WFFhTVpKdjlG?=
 =?utf-8?B?bDF1WWswdEVmOUhGdjJ1d3ZuVGlXc2IrZVhrU1hLNzVCU2tYOUVLMmNjVVB1?=
 =?utf-8?B?ejBlVjJZV1lXRVV0VVFJMHQ2dVBNOGJ1L3lQWFdlRnNIbTF1S3ExRmJGUjlk?=
 =?utf-8?B?M2VhRzNERUJ5NTlkVDcrMXNiTW1NT3dTRS9NNkpsaUV0QllqanNTWWlvL3k2?=
 =?utf-8?B?bnN3N0UvbnJtVGJYZjhCTEpEalVvVlh3SVpOQ2x3YjZRTDlMN01MQnFVb2s3?=
 =?utf-8?B?T0Y0Nm9jK1E1VmY0VUVxbG9VcnV0WmJZVk96dFkyY2JEeFltblljdXZWWC8y?=
 =?utf-8?B?eXRXQXF4WHhNczJTVVdsNEtuSWh4RjhPWTZQMFJVUCtxUnQzcmphSDVIVWFU?=
 =?utf-8?B?R3pER0RmOTB0N0pyK0k5N3VNWk16dTFPN2xhWm1nK0JsbW00MWlzdnIyNDcw?=
 =?utf-8?B?cWxkWXlDYzlaS0VLcmhhRzJoNlZTVTZKUzlXWnJyNWlkRDhJa25lbzZ3VmhR?=
 =?utf-8?B?L0FwUTVnbVFqazBoYUhGdlZGYi9WL2VPUkF1cU9uM2VJam1OU2tJMmtVaHNw?=
 =?utf-8?B?bFZlRmYxd3EvSXlhb0dxSFZ0bzFHczdFcndKY0t5RVh2YlpQVDlJbkora0lJ?=
 =?utf-8?B?VFpLdGo1a0RydzZEdGVKalBXYzFZRHRaaUc4TXMyd3l0ZVB5S0FEUy9Yc1JX?=
 =?utf-8?B?aWRaOXdtZGVuRjhBc0tLaGpJTlJhL3hDOHo3ajhwUUgyNktCdWtCOGNNK0hH?=
 =?utf-8?B?YXZrL1VPSnNaMjZaTS9JUlQ4dkFTUHp2U3pDNElvT1hzR2Vyb2VrNkd4ajM1?=
 =?utf-8?B?S0hUM3QwOWlpOHBYaHRZREduV2xEcnJuWVE0QUZGT2ZTOEx6cWlyS3U4alNW?=
 =?utf-8?B?VEtDOWJYWnV4bTdZSEZXTHJtQkYyZFlKdVJuK1Y0SldkUDFUK2N6UjhDNnhW?=
 =?utf-8?B?bXJ2WktFbjBVOFRUajFnU0pORjJZTjlGTlUyWXM2MEEzU1hwblU1a1FGTUow?=
 =?utf-8?B?QTlxZGFWdklULzVGdUU2VEhKVCtZWGM3bDRJZzhqZTAwU2JZUm9vMGZUTG1M?=
 =?utf-8?B?eEhqNE1pcFJIdFQxdWpxMjB1SnZVT05jUFEybGkxR20remFzSVFSMTMzbkRS?=
 =?utf-8?B?eU5QeXNJcDBZc2ZDcm4rejc2MU5RMW1SQWxQd0kzU1BZTm9WTDIyVVp1bVpm?=
 =?utf-8?B?TWVVQnRVV3hlUXY4ZVcvNXNsV1RIWEVDcWk4SzNsWWRvbFFoNXN5cmR5eU95?=
 =?utf-8?B?akU3RWV4RTBRcWNSNVh2OFBxUG5yK1FWem40Mks0Z0pUOTdmcjRYNkFKWk1I?=
 =?utf-8?B?T0ppL0hVcFpEaWVZRXhyMmlZZ2NzbTJPNS9DbDN4Vk82a2V2QWRrMFdFVkVu?=
 =?utf-8?B?WnE0NkUwa1JhUEtGK3owMG1Ga0UyTjhlSHFYUllneklJRksraEZVMG9LTWo1?=
 =?utf-8?B?Z0NQbEJrbVpRejVOZmtwU1JIL0VTS3hFeWxZL0w3clkvc3JqODV0dWR6YTRl?=
 =?utf-8?B?ZnRKN3Q4SW5vbWV6MDBDQ2JlUW5vTDhibnlFbUlaTVJkd3lFNDRkUDU0V3lW?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F36AF6277ADAF54D92FAD8E1779E594F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c612a0ad-26c7-4652-8b30-08dd7b5494c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 13:02:15.9491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4Jg1XzD+L3tS/03KPIvQi5/GnRwMoYgfbOZNuPi8TgCXpb9Y/hQzdxU49EJIVL6dmNvq4xvEgFvJwTn5WoYdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8464

T24gVGh1LCAyMDI1LTA0LTEwIGF0IDIzOjA1ICswMjAwLCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0K
PiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBXZWxsLi4uDQo+IA0KPiBMZXQgbWUgcmVwZWF0LiBJIGRvbid0
IHVuZGVyc3RhbmQgdGhlIGtlcm5lbC9yZWJvb3QuYyBwYXRocywgeW91IGNhbg0KPiBzYWZlbHkg
aWdub3JlIG1lLg0KPiANCj4gQnV0IEkgc3RpbGwgdGhpbmsgdGhhdCB5b3UgdGFyZ2V0IHRoZSB3
cm9uZyBnb2FsLiBRdWl0ZSBwb3NzaWJseSBJIGFtDQo+IHdyb25nLg0KPiANCj4gT24gMDQvMTAs
IFR6ZS1uYW4gV3Ugd3JvdGU6DQo+ID4gDQo+ID4gSWYgUElEIDEgZXhpdHMgZHVlIHRvIHRoZSB1
bnJlbGlhYmxlIHVzZXJzcGFjZSBhZnRlcg0KPiA+IGtlcm5lbF9wb3dlcl9vZmYoKQ0KPiA+IGlu
dm9rZWQsDQo+IA0KPiBXaHkuIFdoeSB0aGUgZ2xvYmFsIGluaXQgZG9lcyBkb19leGl0KCk/IEl0
IHNob3VsZCBub3QsIHRoYXQgaXMgYWxsLg0KPiBJdCBkb2Vzbid0IG1hdHRlciBpZiBpdCBpcyBz
aW5nbGUgdGhyZWFkZWQgb3Igbm90Lg0KPiANCj4gQXMgZm9yIHN5c19yZWJvb3QoKSwgSSB0aGlu
ayB0aGF0IGtlcm5lbF9wb3dlcl9vZmYoKSBtdXN0IGJlDQo+IF9fbm9yZXR1cm4sDQo+IGFuZCBz
eXNfcmVib290KCkgc2hvdWxkIHVzZSBCVUcoKSBhZnRlcg0KPiBMSU5VWF9SRUJPT1RfQ01EX1BP
V0VSX09GRi9fSEFMVA0KPiBpbnN0ZWFkIG9mIGRvX2V4aXQoKS4NCj4gDQoNClllcywga2VybmVs
X3Bvd2VyX29mZigpIHNob3VsZCBub3QgcmV0dXJuLCBidXQgdGhpcyBpcyB0aGUgY2FzZSBvbmx5
IGlmDQprZXJuZWxfcG93ZXJfb2ZmKCkgaXMgaW52b2tlZCBieSBQSUQgMSB0aHJvdWdoIHN5c19y
ZWJvb3QoKS4NCklmIGtlcm5lbF9wb3dlcl9vZmYoKSBpcyBpbnZva2VkIGJ5IGEga2VybmVsIHRo
cmVhZCAoZS5nLiwgdGhlIHRoZXJtYWwNCmtlcm5lbCBtb2R1bGUpIG90aGVyIHRoYW4gUElEIDEs
IHRoZW4gZG9fZXhpdCgpIGNvdWxkIHBvc3NpYmx5IGJlDQppbnZva2VkIGJ5IFBJRCAxIGFmdGVy
IGtlcm5lbF9wb3dlcl9vZmYoKSBvbiBhbm90aGVyIENQVS4gKHNob3duIGFzDQpiZWxvdykNCg0K
Y3B1IDEgKHRoZXJtYWwga28pICAgICAgICAgICAgICAgIGNwdSAyIChQSUQgMSkNCi0tLS0tLS0t
LS0tLS0tLS0tICAgICAgICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0NCmtlcm5lbF9wb3dlcl9v
ZmYgICAgICAgICAgICAgICAgICAgICAgLi4uDQotPnVmc2hjZF93bF9zaHV0ZG93bihVRlMgZG93
bikgICAgICAgLi4uDQouLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBJRCAxIHBh
Z2UgZmF1bHQNCi4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmFpbCB0byBoYW5k
bGUgcGFnZSBmYXVsdCAoVUZTIGRvd24pDQouLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNlbmQgU0lHQlVTIHRvIFBJRCAxDQouLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFBJRCAxIHRyYXAgdG8gZG9fZXhpdCgpDQouLi4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHBhbmljKCkNCi0+bWFjaGluZV9wb3dlcl9vZmYoKQ0KICAtPiBzbXBfc2VuZF9zdG9w
KCkgLy9zdG9wIG90aGVyIENQVXMNCg0KV2UgaGF2ZSBlbmNvdW50ZXIgdGhpcyBzY2VuYXJpbyBz
ZXZlcmFsIHRpbWVzIGluIGEgbG93IHJhdGUgb24ga2VybmVsLQ0KNi4xMi4NCg0KPiBJZiBub3Ro
aW5nIGVsc2UuIGRvX2V4aXQoKSBhbHNvIGRvZXMgZGVidWdfY2hlY2tfbm9fbG9ja3NfaGVsZCgp
IGFuZA0KPiBzeXNfcmVib290KCkgY2FsbHMgZG9fZXhpdCgpIHdpdGggc3lzdGVtX3RyYW5zaXRp
b25fbXV0ZXggaGVsZC4NCj4gDQo+IElPVy4gSU1PLCBpdCBpcyBub3QgdGhhdCBkb19leGl0KCkg
bmVlZHMgc29tZSBjaGFuZ2VzLiBUaGUgdmVyeSBmYWN0DQo+IHRoYXQgdGhlIGdsb2JhbCBpbml0
IGRvZXMgZG9fZXhpdCgpIGlzIHdyb25nLCB0aGlzIHNob3VsZCBiZSBmaXhlZC4NCj4gDQpJJ20g
bm90IGFuIGV4cGVydCBvbiBVRlMsIGJ1dCBpZiB3ZSB3YW50IHRvIHByZXZlbnQgZW50ZXJpbmcg
ZG9fZXhpdCgpDQphZnRlciBrZXJuZWxfcG93ZXJfb2ZmKCksIHBlcmhhcHMgbW92aW5nIHVmc2hj
ZF93bF9zaHV0ZG93bigpIGFmdGVyIA0Kc21wX3NlbmRfc3RvcCgpIGNvdWxkIGhlbHAuDQpTaW5j
ZSB0aGUgdXNlcnNwYWNlIHByb2Nlc3MgcnVubmluZyBvbiB0aGUgb3RoZXIgQ1BVcyBiZWZvcmUN
CnNtcF9zZW5kX3N0b3AoKSBjb3VsZCBzdGlsbCBhY2Nlc3MgdGhlIFVGUy4NCkJ1dCBub3Qgc3Vy
ZSBpZiB0aGF0J3MgcG9zc2libGUuLi4NCg0KVHplLW5hbg0KPiBCdXQgYWdhaW4sIGFnYWluLCBJ
IGNhbid0IHJlYWxseSBjb21tZW50Lg0KPiANCj4gT2xlZy4NCj4gDQo+ID4gdGhlIHBhbmljIGZv
bGxvdyBieSB0aGUgbGFzdCB0aHJlYWQgb2YgZ2xvYmFsIGluaXQgZXhpdGVkIGluDQo+ID4gZG9f
ZXhpdCgpIHdpbGwgc3RvcCB0aGUga2VybmVsX3Bvd2VyX29mZigpIHByb2NlZHVyZSwgdHVybiBh
DQo+ID4gc2h1dGRvd24NCj4gPiBiZWhhdmlvciBpbnRvIHBhbmljIGZsb3cocmVib290KS4NCj4g
PiANCj4gPiBBZGQgYSBjb25kaXRpb24gY2hlY2sgdG8gZW5zdXJlIHRoYXQgdGhlIHBhbmljIHRy
aWdnZXJlZCBieSB0aGUNCj4gPiBsYXN0DQo+ID4gdGhyZWFkIG9mIHRoZSBnbG9iYWwgaW5pdCBl
eGl0aW5nLCBvbmx5IG9jY3VycyB3aGlsZToNCj4gPiAoIHN5c3RlbV9zdGF0ZSAhPSBTWVNURU1f
UE9XRVJfT0ZGIGFuZCBzeXN0ZW1fc3RhdGUgIT0NCj4gPiBTWVNURU1fUkVTVEFSVCkuDQo+ID4g
T3RoZXJ3aXNlLCBXQVJOKCkgaW5zdGVhZC4NCj4gPiANCj4gPiBbT24gQW5kcm9pZCAxNiB3aXRo
IGFybTY0IGFyY2hdDQo+ID4gSGVyZSdzIGEgc2NlbmFyaW8gd2hlcmUgdGhlIGdsb2JhbCBpbml0
IGV4aXRzIGR1cmluZw0KPiA+IGtlcm5lbF9wb3dlcl9vZmY6DQo+ID4gSWYgUElEIDEgZW5jb3Vu
dGVycyBhIHBhZ2UgZmF1bHQgYWZ0ZXIga2VybmVsX3Bvd2VyX29mZigpIGhhcyBiZWVuDQo+ID4g
aW52b2tlZCwgdGhlIGtlcm5lbCB3aWxsIGZhaWwgdG8gaGFuZGxlIHRoZSBwYWdlIGZhdWx0IGJl
Y2F1c2UgdGhlDQo+ID4gZGlzayhVRlMpIGhhcyBhbHJlYWR5IHNodXQgZG93bi4NCj4gPiBDb25z
ZXF1ZW50bHksIHRoZSBrZXJuZWwgd2lsbCBzZW5kIGEgU0lHQlVTIHRvIFBJRCAxIHRvIGluZGlj
YXRlDQo+ID4gdGhlDQo+ID4gcGFnZSBmYXVsdCBmYWlsdXJlLCBhbmQgdWx0aW1hdGVseSwgdGhl
IHBhbmljIHdpbGwgb2NjdXIgYWZ0ZXIgUElEDQo+ID4gMQ0KPiA+IGV4aXRzIGR1ZSB0byByZWNl
aXZpbmcgdGhlIFNJR0JVUy4NCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdTHC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdTIN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgLS0tLS0tLS0tLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLS0tLS0tLS0tLQ0KPiA+IMKgwqDCoCBrZXJuZWxfcG93ZXJfb2Zm
KCkgc3RhcnQNCj4gPiDCoMKgwqDCoMKgwqDCoCBVRlMgc2h1dGRvd24NCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC4uLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgUElEIDEgcGFnZSBmYXVsdA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLi4uwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFnZSBmYXVs
dCBoYW5kbGUgZmFpbHVyZQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLi4uwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBQSUQgMSByZWNlaXZlZA0KPiA+IFNJR0JVUw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLi4uwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcGFuaWMNCj4gPiDCoMKgIGtlcm5lbF9wb3dlcl9vZmYoKSBub3QgZG9uZQ0KPiA+IA0K
PiA+IEJhY2t0cmFjZSB3aGlsZSBQSUQgMSByZWNlaXZlZCBzaWduYWwgNzoNCj4gPiDCoMKgIGlu
aXQtMSBbMDA3XSBkLi4xIDQxMjM5LjkyMjM4NTogXA0KPiA+IMKgwqDCoMKgwqAgc2lnbmFsX2dl
bmVyYXRlOiBzaWc9NyBlcnJubz0wIGNvZGU9MiBjb21tPWluaXQgcGlkPTEgZ3JwPTANCj4gPiBy
ZXM9MA0KPiA+IMKgwqAgaW5pdC0xIFswMDddIGQuLjEgNDEyMzkuOTIyMzg5OiBrZXJuZWxfc3Rh
Y2s6IDxzdGFjayB0cmFjZT4NCj4gPiDCoMKgID0+IF9fc2VuZF9zaWduYWxfbG9ja2VkDQo+ID4g
wqDCoCA9PiBzZW5kX3NpZ25hbF9sb2NrZWQNCj4gPiDCoMKgID0+IGZvcmNlX3NpZ19pbmZvX3Rv
X3Rhc2sNCj4gPiDCoMKgID0+IGZvcmNlX3NpZ19mYXVsdA0KPiA+IMKgwqAgPT4gYXJtNjRfZm9y
Y2Vfc2lnX2ZhdWx0DQo+ID4gwqDCoCA9PiBkb19wYWdlX2ZhdWx0DQo+ID4gwqDCoCA9PiBkb190
cmFuc2xhdGlvbl9mYXVsdA0KPiA+IMKgwqAgPT4gZG9fbWVtX2Fib3J0DQo+ID4gwqDCoCA9PiBl
bDBfaWENCj4gPiDCoMKgID0+IGVsMHRfNjRfc3luY19oYW5kbGVyDQo+ID4gDQo+ID4gU2ltcGxp
ZmllZCBrZXJuZWwgbG9nOg0KPiA+IGtlcm5lbF9wb3dlcl9vZmYoKSBpbnZva2VkIGJ5IHB0X25v
dGlmeV90aHJlYWQuDQo+ID4gWzQxMjM5LjUyNjEwOV0gcHRfbm90aWZ5X3RocmVhOiByZWJvb3Qg
c2V0IGZsYWcsIG9sZCB2YWx1ZQ0KPiA+IDB4KioqKioqKiosDQo+ID4gKi4NCj4gPiBbNDEyMzku
NTI2MTE0XSBwdF9ub3RpZnlfdGhyZWE6IHJlYm9vdCBzZXQgZmxhZyBuZXcgdmFsdWUNCj4gPiAw
eCoqKioqKioqLg0KPiA+IFVGUyByZWplY3QgSS9PIGFmdGVyIGtlcmVubF9wb3dlcl9vZmYuDQo+
ID4gWzQxMjM5LjY4NjQxMV3CoCBzY3NpICtzY3NpKioqKioqKiogYXBleGQ6IHNkKiAqKioqKioq
KiByZWplY3RpbmcNCj4gPiBJL08gdG8NCj4gPiBvZmZsaW5lIGRldmljZS4NCj4gPiBMb3RzIG9m
IEkvTyBlcnJvciAmIGVyb2ZzIGVycm9yIGhhcHBlbmVkIGFmdGVyIGtlcm5lbF9wb3dlcl9vZmYo
KS4NCj4gPiBbNDEyMzkuNjkwMzEyXSBhcGV4ZDogSS9PIGVycm9yLCBkZXYgc2RjLCBzZWN0b3Ig
KioqKioqKiBvcA0KPiA+ICoqKjooUkVBRCkNCj4gPiBmbGFncyAweCoqKiogcGh5c19zZWcgKiog
cHJpbyBjbGFzcyAwLg0KPiA+IFs0MTIzOS42OTA0NjVdIGFwZXhkOiBJL08gZXJyb3IsIGRldiBz
ZGMsIHNlY3RvciAqKioqKioqIG9wDQo+ID4gKioqOihSRUFEKQ0KPiA+IGZsYWdzIDB4KioqKiBw
aHlzX3NlZyAqKiBwcmlvIGNsYXNzIDAuDQo+ID4gLi4uDQo+ID4gLi4uDQo+ID4gWzQxMjM5Ljky
MjI2NV0gaW5pdDogZXJvZnM6IChkZXZpY2UgKioqKik6IHpfZXJvZnNfcmVhZF9mb2xpbzogcmVh
ZA0KPiA+IGVycm9yICogQCAqKiogb2YgbmlkICoqKioqKioqLg0KPiA+IFs0MTIzOS45MjIzNDFd
IGluaXQ6IGVyb2ZzOiAoZGV2aWNlICoqKiopOiB6X2Vyb2ZzX3JlYWRfZm9saW86IHJlYWQNCj4g
PiBlcnJvciAqIEAgKioqIG9mIG5pZCAqKioqKioqKi4NCj4gPiBGaW5hbGx5IGRldmljZSBwYW5p
YyBkdWUgdG8gUElEIDEgcmVjZWl2ZWQgU0lHQlVTLg0KPiA+IFs0MTIzOS45MjM3ODldIGluaXQ6
IEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBBdHRlbXB0ZWQgdG8ga2lsbA0KPiA+IGluaXQh
DQo+ID4gZXhpdGNvZGU9MHgwMDAwMDAwNw0KPiA+IA0KPiA+IEZpeGVzOiA0M2NmNzVkOTY0MDkg
KCJleGl0OiBwYW5pYyBiZWZvcmUgZXhpdF9tbSgpIG9uIGdsb2JhbCBpbml0DQo+ID4gZXhpdCIp
DQo+ID4gTGluazoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAxOTEyMTkxMDQy
MjMueHZrNnBwZm9nb3hyZ213NkB3aXR0Z2Vuc3RlaW4vDQo+ID4gU2lnbmVkLW9mZi1ieTogVHpl
LW5hbiBXdSA8VHplLW5hbi5XdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gDQo+ID4gSSBh
bSBhbHNvIHdvbmRlcmluZyBpZiB0aGlzIHBhdGNoIGlzIHJlYXNvbmFibGU/DQo+ID4gDQo+ID4g
RnJvbSBteSBwZXJzcGVjdGl2ZSwgdGhlcmUgYXJlIHR3byByZWFzb25zIG5vdCB0byB0cmlnZ2Vy
IHN1Y2gNCj4gPiBwYW5pYw0KPiA+IGR1cmluZyBrZXJuZWxfcG93ZXJfb2ZmKCkgb3Iga2VybmVs
X3Jlc3RhcnQoKToNCj4gPiDCoCAxLiBJdCBpcyBub3Qgd29ydGh3aGlsZSB0byBpbnRlcnJ1cHQg
a2VybmVsX3Bvd2VyX29mZigpIGJ5IGENCj4gPiBwYW5pYw0KPiA+IMKgwqDCoMKgIHJlc3VsdGVk
IGZyb20gdXNlcnNwYWNlIGluc3RhYmlsaXR5Lg0KPiA+IMKgIDIuIFRoZSBwYW5pYyBpbiBkb19l
eGl0KCkgd2FzIG9yaWdpbmFsbHkgZGVzaWduZWQgdG8gZW5zdXJlIGENCj4gPiB1c2FibGUNCj4g
PiDCoMKgwqDCoCBjb3JlZHVtcCBpZiB0aGUgbGFzdCB0aHJlYWQgb2YgdGhlIGdsb2JhbCBpbml0
IHByb2Nlc3MgZXhpdGVkLg0KPiA+IMKgwqDCoMKgwqDCoCBIb3dldmVyLCBjYXB0dXJlIGEgY29y
ZWR1bXAgdHJpZ2dlcmVkIGJ5IHVzZXJzcGFjZSBjcmFzaA0KPiA+IGFmdGVyDQo+ID4gwqDCoMKg
wqAga2VybmVsX3Bvd2VyX29mZigpIHNlZW1zIG5vdCBwYXJ0aWN1bGFybHkgdXNlZnVsLCBpbiBt
eQ0KPiA+IG9waW5pb24uDQo+ID4gDQo+ID4gSW4gY2VydGFpbiBzY2VuYXJpb3MsIGEga2VybmVs
IG1vZHVsZSBtYXkgbmVlZCB0byBkaXJlY3RseSBwb3dlcg0KPiA+IG9mZg0KPiA+IGZyb20ga2Vy
bmVsIHNwYWNlIHRvIHByb3RlY3QgaGFyZHdhcmUgKGUuZy4sIHRoZXJtYWwgcHJvdGVjdGlvbiku
DQo+ID4gSW4gbXkgb3BpbmlvbiwgcmF0aGVyIHRoYW4gY2F1c2luZyBhIHBhbmljIGR1cmluZw0K
PiA+IGtlcm5lbF9wb3dlcl9vZmYoKSwNCj4gPiBpdCBzb3VuZHMgYmV0dGVyIHRvIGFsbG93IHRo
ZSBkZXZpY2UgdG8gY29tcGxldGUgaXRzIHBvd2VyLW9mZg0KPiA+IHByb2Nlc3MuDQo+ID4gDQo+
ID4gQXBwcmVjaWF0ZSBmb3IgYW55IGNvbW1lbnQgb24gdGhpcywgaWYgdGhlcmUncyBhbnkgYmV0
dGVyIHdheSB0bw0KPiA+IGhhbmRsZSB0aGlzIHBhbmljLCBwbGVhc2UgcG9pbnQgbWUgb3V0Lg0K
PiA+IA0KPiA+IC0tLQ0KPiA+IMKga2VybmVsL2V4aXQuYyB8IDE0ICsrKysrKysrKystLS0tDQo+
ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2V4aXQuYyBiL2tlcm5lbC9leGl0LmMNCj4gPiBp
bmRleCAxZGNkZGZlNTM3ZWUuLjIzY2I2YjQyYTFmMSAxMDA2NDQNCj4gPiAtLS0gYS9rZXJuZWwv
ZXhpdC5jDQo+ID4gKysrIGIva2VybmVsL2V4aXQuYw0KPiA+IEBAIC05MDEsMTEgKzkwMSwxNyBA
QCB2b2lkIF9fbm9yZXR1cm4gZG9fZXhpdChsb25nIGNvZGUpDQo+ID4gwqDCoMKgwqDCoCBpZiAo
Z3JvdXBfZGVhZCkgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qDQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIElmIHRoZSBsYXN0IHRocmVhZCBvZiBnbG9iYWwg
aW5pdCBoYXMgZXhpdGVkLA0KPiA+IHBhbmljDQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogaW1tZWRpYXRlbHkgdG8gZ2V0IGEgdXNlYWJsZSBjb3JlZHVtcC4NCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpbW1lZGlhdGVseSB0byBnZXQgYSB1c2FibGUgY29yZWR1
bXAsIGV4Y2VwdCB3aGVuDQo+ID4gdGhlDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogZGV2aWNlIGlzIGN1cnJlbnRseSBwb3dlcmluZyBvZmYgb3IgcmVzdGFydGluZy4NCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAodW5saWtlbHkoaXNfZ2xvYmFsX2luaXQodHNrKSkpDQo+ID4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFuaWMoIkF0dGVtcHRlZCB0byBraWxsIGlu
aXQhDQo+ID4gZXhpdGNvZGU9MHglMDh4XG4iLA0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0c2stPnNpZ25hbC0+Z3JvdXBfZXhp
dF9jb2RlID86DQo+ID4gKGludCljb2RlKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmICh1bmxpa2VseShpc19nbG9iYWxfaW5pdCh0c2spKSkgew0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChzeXN0ZW1fc3RhdGUgIT0gU1lTVEVNX1BP
V0VSX09GRiAmJg0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc3lzdGVtX3N0YXRlICE9IFNZU1RFTV9SRVNUQVJUKQ0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYW5pYygiQXR0
ZW1wdGVkIHRvIGtpbGwgaW5pdCENCj4gPiBleGl0Y29kZT0weCUwOHhcbiIsDQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHRzay0+c2lnbmFsLT5ncm91cF9leGl0X2NvZGUgPzoNCj4gPiAoaW50KWNvZGUpOw0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFdBUk4oMSwgIkF0
dGVtcHRlZCB0byBraWxsIGluaXQhDQo+ID4gZXhpdGNvZGU9MHglMDh4XG4iLA0KPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0c2stPnNpZ25h
bC0+Z3JvdXBfZXhpdF9jb2RlID86DQo+ID4gKGludCljb2RlKTsNCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIH0NCj4gPiANCj4gPiDCoCNpZmRlZiBDT05GSUdfUE9TSVhfVElNRVJTDQo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaHJ0aW1lcl9jYW5jZWwoJnRzay0+c2lnbmFs
LT5yZWFsX3RpbWVyKTsNCj4gPiAtLQ0KPiA+IDIuNDUuMg0KPiA+IA0KPiANCg0K

