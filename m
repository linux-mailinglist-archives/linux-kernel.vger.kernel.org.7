Return-Path: <linux-kernel+bounces-837028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEE9BAB1D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985FC1884566
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047122172E;
	Tue, 30 Sep 2025 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XyWsZbMO";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jbGdUxRg"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16D856B81;
	Tue, 30 Sep 2025 02:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759201200; cv=fail; b=KZqnT1y8Gt0gktjzLDLG3WqDm94HU+OzE9Cfw9Qjk1qlhPq+cKbnYPE4RMC3yQ7yskYv8jpKW0OCC+YHLVvZmINhmc/f9/N6Es2PE70Ddt7G89+tARtyaDhdFY9Tj9kjcRNeOD3wI5BBig5QzDAKg2zzi5bT6C7/MMoCAC140CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759201200; c=relaxed/simple;
	bh=Vt+5D/V8VYIO2kv+1h6lw57+N1K5X2gKhpQpwFiB4oA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iS+RvgvJpRRflIAL9bNZBub8ljIovz+AEmpeQRTEE1C4a6l33CLmmpB3Ay+yLtdyBoJhtlTiBJLLwTcQ0Dmg88xW6kIGwEf5cm1uDdtJJAEi8Idpp4rxc+F9eBEscugurQY/a/JJqxJtgmm5jT8uyWEKgViOj/uRZy9LyFw76iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XyWsZbMO; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jbGdUxRg; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8414bb869da911f0b33aeb1e7f16c2b6-20250930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Vt+5D/V8VYIO2kv+1h6lw57+N1K5X2gKhpQpwFiB4oA=;
	b=XyWsZbMOF5fbqHgm5Q8pV5MRBZl3ac891q2e4WYHJQ1Pgb9btJqunUrtF+Pl1b8d+AP9JBAv/lGyRbCb5Y+pF+hc1c59esTrF4TUyU3/HPeDca2m5UnWv3/L4dPyTBJk4wtIUIlKeixGvKkcL8oAHrNcMwXGMidObv79NTDEoZo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f558ff7f-a138-43de-82ad-5b26189fb9d3,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:f92ad1f8-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8414bb869da911f0b33aeb1e7f16c2b6-20250930
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 755036540; Tue, 30 Sep 2025 10:59:43 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 30 Sep 2025 10:59:41 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Tue, 30 Sep 2025 10:59:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSQzWbjaBgf/XXYjF6DQgip5/iReLG+5QPTLNvDJWkf+XQ7rNAbZXtdZpQ813KlLFRC2DOFRddfYygcYGYWczr4uWnIOJ82xpViJd0afsGBQrEenWMuxYMNXL0uAG4A3daMPkEji2hHsfLnBw8ep1j2h79ohWVN/pPELAYO4sfEJt800KGW+pJ8BOV/nMWprfQ/O3tuqscZWvqKzfgJcL8mWnVhRyesyQbe2kaJ8JT2N5+16BHpQMk4sEnKREtjwQeeciqtUHANQL26dtzbiNQ72179wzAyrxS/X90B5goAlVrH+8WCjcjZMsiI7pGvbkT/xDile7G2NeULFEMTf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt+5D/V8VYIO2kv+1h6lw57+N1K5X2gKhpQpwFiB4oA=;
 b=o5UxZg9XWGCxAIzboNBzAIvljASPB+wqMia1NB0uRmHbSBSmTWbIBOFo/7JoY7IxY+xRKiltUJ3d1Gb48fbuY1j3yEaBdMygtSH/F9hQ/dUE/O6lBx9Zp31DrtrQHSLWJbV85pxBirvjrJXnRreV5sWGSU6Dy4tRS/b7YaqlwiH8OQ3TKyi3yiHAFa+WnvuRHebTRrXM030bk33IPGf7MZsdOHsfw8hIhqjlksUG6UF6TQdtP/z6V4jNWg7PKwCoFDIMp1L0tDbVTNafEYlueKQjhv7h5OURV9JDiXEgKHnGYU8522bCI0PUrViveROJGXWnmqHNSsXl1kVSCkdCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vt+5D/V8VYIO2kv+1h6lw57+N1K5X2gKhpQpwFiB4oA=;
 b=jbGdUxRgfrGZXEC3PrEaQIiokuLrXpWhYGa6hxJBpoxF6SCQealjyAGFx+6wf+KCkUKlTw5+IGlC0RljEoUZrwgvBH43OR3tz4L05we0fLEnvZhyhaR4wtwtjqEyIc111/RUvG9PuL5R8o+wkepIPdsOXnmxKhKOduALhxRwr3w=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by SEZPR03MB8016.apcprd03.prod.outlook.com (2603:1096:101:181::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:59:38 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:59:38 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"wenst@chromium.org" <wenst@chromium.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v6 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Thread-Topic: [PATCH v6 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Thread-Index: AQHcLsTY126L+u5d3EyZiDCITEle+bSp+3GAgAETiIA=
Date: Tue, 30 Sep 2025 02:59:38 +0000
Message-ID: <aa86f9012bc56231066846f423263504313b6717.camel@mediatek.com>
References: <20250926090505.26267-1-jjian.zhou@mediatek.com>
	 <20250926090505.26267-3-jjian.zhou@mediatek.com>
	 <b62611ef-7ead-4bbe-8c96-d39e3c5c8dd8@collabora.com>
In-Reply-To: <b62611ef-7ead-4bbe-8c96-d39e3c5c8dd8@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|SEZPR03MB8016:EE_
x-ms-office365-filtering-correlation-id: 178ba996-beef-4781-a0e7-08ddffcd64f4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?L0R0SEZoSDFrWFZQd3I2cmwramowMWRPMmpBNzdtMTk4R2cvd1BHMVdQNWxG?=
 =?utf-8?B?V09ONklGQXN6K0VNUGRRQko1RW5GTkZaM3ZhV2tkOUl5TEhWbkZpRzhOaXll?=
 =?utf-8?B?ZTQrZXB4SDZudVZ6RXV4ZU1EODk3OFpXWVlFMW9WUTlBdXFLaE1yell0TGFR?=
 =?utf-8?B?TVlFSm9NL1gvN3NvN1EvNTBVZVdTNU5SUUhDNFFJVjJxV0lCU0pKekR2c0t4?=
 =?utf-8?B?bG4vSWpXMWZhVGIvcC9uaWp0LzVkcEN1dkNRY0pXdm9VakVUdWtxREM1ZUF4?=
 =?utf-8?B?UHUvYUlhT0x5ajBhck9SOVNDVUQrMjJQeFRSczZ6QlBCREt3bmd4aHpFbFFE?=
 =?utf-8?B?VDFxVTRWb0dhOGhoNDhKaDVGSWF5NS9INVZ5OHhiRVNvQjRJUlY2SEVveVcw?=
 =?utf-8?B?U2lGUHIwVUxOVXJ4OXRGZHZTOXpVZjlCQ3ZkRjNJcEI5ZGorUng2MkdXaUlR?=
 =?utf-8?B?dEZwVGV4TURET1dIajRURkFNN25LMU1xdHRUUGt3ZWUwSXQwbk9uK09ZRExN?=
 =?utf-8?B?alRva09maVhneTVGRW8zL1IzQzFrYXNwb2dEQjhwUzdTMTkyNmtib25iTnNW?=
 =?utf-8?B?ZzRkQyszc0lCS2tiQXBjZVFCOHovSUN6SERKc3FXS05wa1B5STF3ZWVXcGxp?=
 =?utf-8?B?WmhGUmpqYTl4QXBJNExTQW9jczRVeERFc2FQSEJaYXV2WUQxQ1A5NHQxUkRS?=
 =?utf-8?B?dUN2b2VDYndYMGVkckJKS1VlTW5tQUMrY0VmQzZ1OE1BalZlS0tCdkdCT0N6?=
 =?utf-8?B?R0grSVE4QkV5N2pPOEJrb0ZMYkFqNjBnUmhKZklhZWNlcVpaQWtUNmI5WWhu?=
 =?utf-8?B?bkJCcUU2dWhiKzZDWHRFWVNRa0xldlorNWJod29UZ09xUmVRRDc5Y1h3dllP?=
 =?utf-8?B?ZVVockRkekFndGlrejMwVjdad3BPdUgwa1dCd2N4OFFnSnI3cXM0RHJQekw5?=
 =?utf-8?B?aHl1OVEveGdQNDlkUTl6WEFLQUw2S3N6aXAzeURvUllFWEsza3lZTTRYQ1Fa?=
 =?utf-8?B?OEQ5SDFKRkFaTkpmd2o2SE5tNFY0WWgxVmpSMTZIUzFQb1JSMXUzRTFFUGQx?=
 =?utf-8?B?dHlqVmZ3bE9BMGliL1BsUkJXSFAzRG13Z1NRU3pnTkNzNGtqYnp2SCtweC9Y?=
 =?utf-8?B?bG85OWY4eUZObXVhdG9FZzVabkxJVTI1N2hHMlZVV2J4Y0RiZDk1ZkRGU1Na?=
 =?utf-8?B?VHdqalFnZDVxZDNGQ3BkSnR3MHo1RFVURWpXS05KTGZXQThuZ3JldGZ2WHlO?=
 =?utf-8?B?clhWTHRTYy9uNS9RaGhHODhHTFpjOEJ0UWJQRUlrYnc4dDdGRWYwVlNWbjVH?=
 =?utf-8?B?cndkOFo2R2pUZDM1Z2hBWVIweVh2VUFJRmliR0xUcUNUd2NuSVNIQ0t0NTFY?=
 =?utf-8?B?QVdEVEZDSzlqSzV6aEZzaUVoV2hvVHNCSnkzOVlrZVlWbGZzeXc5MzRXanY3?=
 =?utf-8?B?RmJHT0RKTFNEbmd0WENHVk1lQklENGZaRjdOcGJLWkgxR2ZpajBXd0FPNFVu?=
 =?utf-8?B?MWFiZmsrZEJHQnNLNWV5bzNwTGxyei9UL2FId3ZDRWQrbWdXN3lWY0ZPM1Rp?=
 =?utf-8?B?WVdOUVAzTU91STNKVW5rWUtSZWtJZkxVM2ZrTUhyak43VS9qVXoxVHdsYWd6?=
 =?utf-8?B?VE9XbGdWbG9vV3Vac0k1TXZ3dnZsNEIrZFJQdUhyaUlPclFIWEN1KzFuRnU0?=
 =?utf-8?B?OWhheDZMNThSbzBBdTFpYWFsMWtlOUtjZzdWU1piZFJjWTZRb2xCcXJQNU9D?=
 =?utf-8?B?bms5bjZTVVFIVy9LSWoxU3lPMndDeEFkYmhVeDhaOC9YS3Fha2NaODkxazhT?=
 =?utf-8?B?aXo3cEFOanRWZWUvWHVnSi9keEF3WUZKYzNhajYrQVIvZDlVSXM0cmNWWjJa?=
 =?utf-8?B?NlRxYzd6ZzJibjR2NWVqQzlHQnVxV1ExRS9vVTlQMURuZVNLZ3pKdlhEN0FS?=
 =?utf-8?B?aXU1ckJBWnhRdFJQM1lRbWNlTkRNVGlxS1h2SjVnU3VzZlZ0ZGRYbk9SQkp3?=
 =?utf-8?B?bHNFeUtqYlZ4MlJzdEJzaE9kb21wSVd4UmhmaWlORmpNWGlsMG9XSlJBUHBG?=
 =?utf-8?Q?pBOLvb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGJDRW9WcGRUdkRlUnRheERWRjF1dEEwN0YyN3V2VTVxOUE4R0l6dnllTi9M?=
 =?utf-8?B?STcxTTJQalNHTkEwbVlnODV6NUJQKzdVSmpEci9WTEk2UERPYzJhdVdZK1Yy?=
 =?utf-8?B?bDNvQlFRMmRhN2lMcUlCK0N3ZGJVbzBLNHhIeTZFQmtwTXdHZ3lRUDBrTDJH?=
 =?utf-8?B?dk0vN0dyMFpodkYvN1lvU1hXMWJJckg0QTNWZmJiZnlZcHBHa0VkcTFiN2Vh?=
 =?utf-8?B?SlBpUHA1aklESkRmWGEyWDgwREJQWlZFMXNsby9Ub1VienUzbExkOTZoZjU4?=
 =?utf-8?B?WndraGJ1OEY0Z1E3UVdEVGtDVkZOcXBRTkRuTDhlQi9kOEg0SnNpbTBFWnll?=
 =?utf-8?B?ZHhtZUpOdFVmRFM1eWdlQ3ZuaDdFWGh6OWFWdG90b3lQaWg0K3h1R1JuOWRG?=
 =?utf-8?B?OE5mOXdHSldQU1lqeFo2YTVnWmEvck1zQXlteTVId3lkVzdTQlA3T2VOWlA5?=
 =?utf-8?B?YXFXS3hNVFJLVHoydm5PZWkrd05FS0JyclZQVEdhY29TSVI0L3BEREdRbzB5?=
 =?utf-8?B?dkdtUnhKTDVselAyellpZDZSeTBZWjVnU2NKZk9RSkRjalBpUmxpK0xyeFda?=
 =?utf-8?B?ZEpKRmZJK2tJQ3ZERzAzbmlmSktZM2FZSlB0VXZ6MUVuaHN3cU9lTk1samhr?=
 =?utf-8?B?MlNUMUw4cDFZVEFYNG9iRGJuUEk0NFZTRTVWdkJ4S1cxUExTNFE0amtSM0Jo?=
 =?utf-8?B?L0hZSmpEOVo2WURPQ1RFL3FBd0JaRlJzRlBPaUdmWlhyNFZ0N1dMME5QRkVC?=
 =?utf-8?B?RDNYOVFONWs1SDdnZlVUaEl5VU9mQUZaVWRZdzVnVTVDZXB4OFFDUTN5UytO?=
 =?utf-8?B?Q2drSWNsMkV0dWJNeHNuL0R0ejVBWXhsT3BydEthQ1FDNFZBeDBBN0JjZUc0?=
 =?utf-8?B?ZUlBQ1E3R1k4eUdhNDU1bk1sdWloa1pWSzd6YUNuTTF3eTR0cnNsTlhhWk5r?=
 =?utf-8?B?SGlWVzdDMjc4Mzk5MU9HdDNRQm5PV3ZzOUdqOVlGODg1SXpZdjJ0QkErdVlq?=
 =?utf-8?B?dEpBY1Y5eG1NaTdOeHowNmpKSGtDSnl4bDdLVDlCRDBqZXI0THQwVnEzVTg2?=
 =?utf-8?B?R2pDN09OOFdEeDIrVE85bTNoL1lTTzh4RkorRW1VTEc1aTBUdUJkVFZBZ3BN?=
 =?utf-8?B?MDFLWHBTa2pBeFY2UWo2OUFZdUxsMEpBZ3ZITWwvamtVMDYxOTA1ZkVhSTV6?=
 =?utf-8?B?aE5wbkxlelRwZEpCc1ZCdUxCNkJqMjFRNXEvMWNlTkxwcmdOUkhoTFd1WHQr?=
 =?utf-8?B?ODB3dlB4Vi9CMndNcmhqVk9VQnhYamZvNVhSWmhRQ0hJWlQ1NC9iYVMvd0hW?=
 =?utf-8?B?UFR5UytEdWtmOEdaY0txNjdaZG1UVUZQcW5KcmppQllzSUhva2lPQ3hnZk96?=
 =?utf-8?B?dGJBMTZ5WE4vQ3czUHl1WG94L2ZWYWk5N3pCT3F2ZEJZWEdEVmNEcGRiUkor?=
 =?utf-8?B?SlNUY1pvVnhmazJiVDY3eWlXV3U0Q0MwRGFvVXBjbTZEZVd1MVNXQkF3QlhG?=
 =?utf-8?B?dUVmS0ZZRWV5UWxYdFQvRjZjT01UbVBJZWNXRFQ0RXllU2ZKVktaRXRCU1I3?=
 =?utf-8?B?WERobHo5V0pleWNKTS9udzhPblFCYm5hMGIyS3pNSDlrSHZWRVZIUjRHYXJM?=
 =?utf-8?B?QTU4ajhFR2lQMXVFQjJwT1VhcWp6MzMyWURvTWQzOW1scEtiNlQ1U1lvdFdK?=
 =?utf-8?B?SXVJOFV3eEdScDRuUGx3K1FlSXhLNWl4TTVCcU9xQTZwZTZTM1JhSmFZVSsv?=
 =?utf-8?B?R3picDIvL0ttbFJKVzFnVzltTEMvRUFyMEl6OUdGZlJ5bkZRZ3BzRUc3Wk9N?=
 =?utf-8?B?aWdsWW9WVmhJaFl5M1cva2d4YzJOTzBTUno1RkI2cDI3YzhBb1lteS9kazhN?=
 =?utf-8?B?d0xTa3BLYjZET09WV2JUM2NIZTJMSjhKZUFUbTlwWDF0Z0FmTkVyVVFZa0lq?=
 =?utf-8?B?akg2YTFWUUFMWHRIMjJRVEVyYXo5TDFqT2JWTVVEd3gzRk8vL0xzY3BSTG0y?=
 =?utf-8?B?MkJOWUsxK2xzTXRZYTZoRXo3SWgwaG9WNUttRDBtbEJXcEVYcXBYZ2N5WS8x?=
 =?utf-8?B?TGhJMDRuRTgrRjBNZmNTVnNnR2NnakxLNVpSU3pkZmxyL3JOZnJLMHoraUtp?=
 =?utf-8?B?ajNtQkR5V3R2dmNBeEpqWjAzV1NQK2Q5L1ptUEFsQmtNOUk0RWJUQUppYi93?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92B8742310E2784C8D94C896A571B18E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178ba996-beef-4781-a0e7-08ddffcd64f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 02:59:38.3493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SqHrNGNV95J5ZAxPSLsC2z8j0tzSwlvPe0HJAJvec3lMlbsAAYlBpxGR1ybCijd0NEIHE7cZ4jk+mYe17YGlMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8016

T24gTW9uLCAyMDI1LTA5LTI5IGF0IDEyOjMzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAyNi8wOS8yNSAxMTowNSwgSmppYW4gWmhv
dSBoYSBzY3JpdHRvOg0KPiA+IEFkZCBtdGstdmNwLW1haWxib3ggZHJpdmVyIHRvIHN1cHBvcnQg
dGhlIGNvbW11bmljYXRpb24gd2l0aA0KPiA+IFZDUCByZW1vdGUgbWljcm9wcm9jZXNzb3IuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmppYW4gWmhvdSA8amppYW4uemhvdUBtZWRpYXRlay5j
b20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL21haWxib3gvS2NvbmZpZyAgICAgICAgICAgICAg
ICAgfCAgIDkgKysNCj4gPiAgIGRyaXZlcnMvbWFpbGJveC9NYWtlZmlsZSAgICAgICAgICAgICAg
ICB8ICAgMiArDQo+ID4gICBkcml2ZXJzL21haWxib3gvbXRrLXZjcC1tYWlsYm94LmMgICAgICAg
fCAxNjgNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIGluY2x1ZGUvbGludXgv
bWFpbGJveC9tdGstdmNwLW1haWxib3guaCB8ICAzMiArKysrKw0KPiA+ICAgNCBmaWxlcyBjaGFu
Z2VkLCAyMTEgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
bWFpbGJveC9tdGstdmNwLW1haWxib3guYw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvbGludXgvbWFpbGJveC9tdGstdmNwLW1haWxib3guaA0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21haWxib3gvS2NvbmZpZyBiL2RyaXZlcnMvbWFpbGJveC9LY29uZmlnDQo+ID4g
aW5kZXggMDI0MzJkNGE1Y2NkLi5jMjhiZGI4NTU2NjMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9tYWlsYm94L0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL21haWxib3gvS2NvbmZpZw0KPiA+
IEBAIC0yOTQsNiArMjk0LDE1IEBAIGNvbmZpZyBNVEtfQ01EUV9NQk9YDQo+ID4gICAgICAgICBj
cml0aWNhbCB0aW1lIGxpbWl0YXRpb24sIHN1Y2ggYXMgdXBkYXRpbmcgZGlzcGxheQ0KPiA+IGNv
bmZpZ3VyYXRpb24NCj4gPiAgICAgICAgIGR1cmluZyB0aGUgdmJsYW5rLg0KPiA+IA0KPiA+ICtj
b25maWcgTVRLX1ZDUF9NQk9YDQo+ID4gKyAgICAgdHJpc3RhdGUgIk1lZGlhVGVrIFZDUCBNYWls
Ym94IFN1cHBvcnQiDQo+ID4gKyAgICAgZGVwZW5kcyBvbiBBUkNIX01FRElBVEVLIHx8IENPTVBJ
TEVfVEVTVA0KPiA+ICsgICAgIGhlbHANCj4gPiArICAgICAgIFNheSB5ZXMgaGVyZSB0byBhZGQg
c3VwcG9ydCBmb3IgdGhlIE1lZGlhVGVrIFZDUCBtYWlsYm94DQo+ID4gZHJpdmVyLg0KPiA+ICsg
ICAgICAgVGhlIG1haWxib3ggaW1wbGVtZW50YXRpb24gcHJvdmlkZXMgYWNjZXNzIGZyb20gdGhl
DQo+ID4gYXBwbGljYXRpb24NCj4gPiArICAgICAgIHByb2Nlc3NvciB0byBWaWRlbyBDb21wYW5p
b24gUHJvY2Vzc29yIFVuaXQuDQo+ID4gKyAgICAgICBJZiB1bnN1cmUgc2F5IE4uDQo+ID4gKw0K
PiA+ICAgY29uZmlnIFpZTlFNUF9JUElfTUJPWA0KPiA+ICAgICAgIHRyaXN0YXRlICJYaWxpbngg
WnlucU1QIElQSSBNYWlsYm94Ig0KPiA+ICAgICAgIGRlcGVuZHMgb24gQVJDSF9aWU5RTVAgJiYg
T0YNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L01ha2VmaWxlIGIvZHJpdmVycy9t
YWlsYm94L01ha2VmaWxlDQo+ID4gaW5kZXggOThhNjhmODM4NDg2Li4wNzI3ODg3MWQyNTQgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tYWlsYm94L01ha2VmaWxlDQo+ID4gKysrIGIvZHJpdmVy
cy9tYWlsYm94L01ha2VmaWxlDQo+ID4gQEAgLTYzLDYgKzYzLDggQEAgb2JqLSQoQ09ORklHX01U
S19BRFNQX01CT1gpICs9IG10ay1hZHNwLW1haWxib3gubw0KPiA+IA0KPiA+ICAgb2JqLSQoQ09O
RklHX01US19DTURRX01CT1gpICs9IG10ay1jbWRxLW1haWxib3gubw0KPiA+IA0KPiA+ICtvYmot
JChDT05GSUdfTVRLX1ZDUF9NQk9YKSAgICs9IG10ay12Y3AtbWFpbGJveC5vDQo+ID4gKw0KPiA+
ICAgb2JqLSQoQ09ORklHX1pZTlFNUF9JUElfTUJPWCkgICAgICAgKz0genlucW1wLWlwaS1tYWls
Ym94Lm8NCj4gPiANCj4gPiAgIG9iai0kKENPTkZJR19TVU42SV9NU0dCT1gpICArPSBzdW42aS1t
c2dib3gubw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvbXRrLXZjcC1tYWlsYm94
LmMNCj4gPiBiL2RyaXZlcnMvbWFpbGJveC9tdGstdmNwLW1haWxib3guYw0KPiA+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5hMmE4MGQxMjRlNTANCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay12Y3AtbWFpbGJveC5j
DQo+ID4gQEAgLTAsMCArMSwxNjggQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjANCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChjKSAyMDI1IE1lZGlhVGVrIENv
cnBvcmF0aW9uLiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KPiA+ICsgKiBBdXRob3I6IEpqaWFuIFpo
b3UgPGpqaWFuLnpob3UuQG1lZGlhdGVrLmNvbT4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5j
bHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiA+
ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tYWlsYm94
X2NvbnRyb2xsZXIuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21haWxib3gvbXRrLXZjcC1tYWls
Ym94Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiArI2luY2x1ZGUgPGxp
bnV4L29mLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiArDQo+ID4gK3N0cnVjdCBtdGtfdmNwX21ib3gg
ew0KPiA+ICsgICAgIHN0cnVjdCBtYm94X2NvbnRyb2xsZXIgbWJveDsNCj4gPiArICAgICB2b2lk
IF9faW9tZW0gKmJhc2U7DQo+ID4gKyAgICAgc3RydWN0IGRldmljZSAqZGV2Ow0KPiA+ICsgICAg
IGNvbnN0IHN0cnVjdCBtdGtfdmNwX21ib3hfY2ZnICpjZmc7DQo+ID4gKyAgICAgc3RydWN0IG10
a19pcGlfaW5mbyBpcGlfcmVjdjsNCj4gPiArICAgICBzdHJ1Y3QgbWJveF9jaGFuIGNoYW5zOw0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RydWN0IG10a192Y3BfbWJveF9jZmcgew0KPiA+ICsgICAg
IHUzMiBzZXRfaW47DQo+ID4gKyAgICAgdTMyIGNscl9vdXQ7DQo+IA0KPiB1MTYgaXMgZW5vdWdo
IGZvciBib3RoIHJlZ2lzdGVyIG9mZnNldHMsIGF0IGxlYXN0IGZvciBub3cgLSBhbmQgSQ0KPiBz
dXNwZWN0IGl0J3MNCj4gZ29pbmcgdG8gYmUgZW5vdWdoIGZvcmV2ZXIuDQoNCk9LLiBJIGNoYW5n
ZSB1MzIgdG8gdTE2IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCj4gDQo+ID4gK307DQo+ID4gKw0K
PiA+ICtzdGF0aWMgaXJxcmV0dXJuX3QgbXRrX3ZjcF9tYm94X2lycV90aHJlYWQoaW50IGlycSwg
dm9pZCAqZGF0YSkNCj4gPiArew0KPiA+ICsgICAgIHN0cnVjdCBtdGtfdmNwX21ib3ggKnByaXYg
PSBkYXRhOw0KPiA+ICsNCj4gPiArICAgICAvKiBnZXQgaXJxIHN0YXR1cyAqLw0KPiA+ICsgICAg
IHByaXYtPmlwaV9yZWN2LmlycV9zdGF0dXMgPSByZWFkbChwcml2LT5iYXNlICsgcHJpdi0+Y2Zn
LQ0KPiA+ID5jbHJfb3V0KTsNCj4gPiArDQo+ID4gKyAgICAgX19pb3JlYWQzMl9jb3B5KHByaXYt
PmlwaV9yZWN2Lm1zZywgcHJpdi0+YmFzZSwNCj4gPiBNQk9YX1NMT1RfTUFYX1NJWkUgLyA0KTsN
Cj4gPiArDQo+ID4gKyAgICAgbWJveF9jaGFuX3JlY2VpdmVkX2RhdGEoJnByaXYtPmNoYW5zLCAm
cHJpdi0+aXBpX3JlY3YpOw0KPiA+ICsNCj4gPiArICAgICAvKiBjbGVhciBpcnEgc3RhdHVzICov
DQo+ID4gKyAgICAgd3JpdGVsKHByaXYtPmlwaV9yZWN2LmlycV9zdGF0dXMsIHByaXYtPmJhc2Ug
KyBwcml2LT5jZmctDQo+ID4gPmNscl9vdXQpOw0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gSVJR
X0hBTkRMRUQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgbWJveF9jaGFuICpt
dGtfdmNwX21ib3hfeGxhdGUoc3RydWN0IG1ib3hfY29udHJvbGxlcg0KPiA+ICptYm94LA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdA0K
PiA+IG9mX3BoYW5kbGVfYXJncyAqc3ApDQo+ID4gK3sNCj4gPiArICAgICBpZiAoc3AtPmFyZ3Nf
Y291bnQpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiArDQo+ID4gKyAgICAg
cmV0dXJuICZtYm94LT5jaGFuc1swXTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBt
dGtfdmNwX21ib3hfc2VuZF9kYXRhKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4sIHZvaWQNCj4gPiAq
ZGF0YSkNCj4gPiArew0KPiA+ICsgICAgIHN0cnVjdCBtdGtfdmNwX21ib3ggKnByaXYgPSBjaGFu
LT5jb25fcHJpdjsNCj4gPiArICAgICBzdHJ1Y3QgbXRrX2lwaV9pbmZvICppcGlfaW5mbyA9IGRh
dGE7DQo+ID4gKyAgICAgdTMyIHN0YXR1czsNCj4gPiArDQo+ID4gKyAgICAgaWYgKCFpcGlfaW5m
by0+bXNnKSB7DQo+ID4gKyAgICAgICAgICAgICBkZXZfZXJyKHByaXYtPmRldiwgIm1zZyBidWZm
ZXIgaXMgTlVMTC5cbiIpOw0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4g
KyAgICAgfQ0KPiA+ICsNCj4gPiArICAgICBzdGF0dXMgPSByZWFkbChwcml2LT5iYXNlICsgcHJp
di0+Y2ZnLT5zZXRfaW4pICYNCj4gPiBCSVQoaXBpX2luZm8tPmluZGV4KTsNCj4gDQo+IHN0YXR1
cyA9IHJlYWRsKHByaXYtPmJhc2UgKyBwcml2LT5jZmctPnNldF9pbik7DQo+IGlmIChzdGF0dXMg
JiBCSVQoaXBpX2luZm8tPmluZGV4KSB7DQo+ICAgLi4uLg0KPiB9DQoNCk9LLg0KDQo+IA0KPiA+
ICsgICAgIGlmIChzdGF0dXMpIHsNCj4gPiArICAgICAgICAgICAgIGRldl93YXJuKHByaXYtPmRl
diwgIm1haWxib3ggSVBJICVkIGlzIGJ1c3kuXG4iLA0KPiA+IGlwaV9pbmZvLT5pZCk7DQo+ID4g
KyAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAg
ICAgaWYgKGlwaV9pbmZvLT5zbG90X29mcyArIGlwaV9pbmZvLT5sZW4gPiBNQk9YX1NMT1RfTUFY
X1NJWkUpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArICAgICBfX2lv
d3JpdGUzMl9jb3B5KHByaXYtPmJhc2UgKyBpcGlfaW5mby0+c2xvdF9vZnMsIGlwaV9pbmZvLQ0K
PiA+ID5tc2csDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICBpcGlfaW5mby0+bGVuKTsNCj4g
PiArDQo+ID4gKyAgICAgd3JpdGVsKEJJVChpcGlfaW5mby0+aW5kZXgpLCBwcml2LT5iYXNlICsg
cHJpdi0+Y2ZnLT5zZXRfaW4pOw0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gMDsNCj4gPiArfQ0K
PiA+ICsNCj4gPiArc3RhdGljIGJvb2wgbXRrX3ZjcF9tYm94X2xhc3RfdHhfZG9uZShzdHJ1Y3Qg
bWJveF9jaGFuICpjaGFuKQ0KPiA+ICt7DQo+ID4gKyAgICAgc3RydWN0IG10a19pcGlfaW5mbyAq
aXBpX2luZm8gPSBjaGFuLT5hY3RpdmVfcmVxOw0KPiA+ICsgICAgIHN0cnVjdCBtdGtfdmNwX21i
b3ggKnByaXYgPSBjaGFuLT5jb25fcHJpdjsNCj4gPiArDQo+ID4gKyAgICAgcmV0dXJuICEocmVh
ZGwocHJpdi0+YmFzZSArIHByaXYtPmNmZy0+c2V0X2luKSAmDQo+ID4gQklUKGlwaV9pbmZvLT5p
bmRleCkpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG1ib3hfY2hh
bl9vcHMgbXRrX3ZjcF9tYm94X2NoYW5fb3BzID0gew0KPiA+ICsgICAgIC5zZW5kX2RhdGEgICAg
ICA9IG10a192Y3BfbWJveF9zZW5kX2RhdGEsDQo+ID4gKyAgICAgLmxhc3RfdHhfZG9uZSAgID0g
bXRrX3ZjcF9tYm94X2xhc3RfdHhfZG9uZSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBp
bnQgbXRrX3ZjcF9tYm94X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
K3sNCj4gPiArICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsgICAg
IHN0cnVjdCBtdGtfdmNwX21ib3ggKnByaXY7DQo+ID4gKyAgICAgc3RydWN0IG1ib3hfY29udHJv
bGxlciAqbWJveDsNCj4gPiArICAgICBpbnQgcmV0LCBpcnE7DQo+ID4gKw0KPiA+ICsgICAgIHBy
aXYgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKnByaXYpLCBHRlBfS0VSTkVMKTsNCj4gPiAr
ICAgICBpZiAoIXByaXYpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiAr
DQo+ID4gKyAgICAgcHJpdi0+ZGV2ID0gZGV2Ow0KPiA+ICsgICAgIHByaXYtPmNoYW5zLmNvbl9w
cml2ID0gcHJpdjsNCj4gPiArICAgICBtYm94ID0gJnByaXYtPm1ib3g7DQo+ID4gKyAgICAgbWJv
eC0+ZGV2ID0gZGV2Ow0KPiA+ICsgICAgIG1ib3gtPm9wcyA9ICZtdGtfdmNwX21ib3hfY2hhbl9v
cHM7DQo+ID4gKyAgICAgbWJveC0+dHhkb25lX2lycSA9IGZhbHNlOw0KPiA+ICsgICAgIG1ib3gt
PnR4ZG9uZV9wb2xsID0gdHJ1ZTsNCj4gPiArICAgICBtYm94LT5vZl94bGF0ZSA9IG10a192Y3Bf
bWJveF94bGF0ZTsNCj4gPiArICAgICBtYm94LT5udW1fY2hhbnMgPSAxOw0KPiA+ICsgICAgIG1i
b3gtPmNoYW5zID0gJnByaXYtPmNoYW5zOw0KPiA+ICsNCj4gPiArICAgICBwcml2LT5pcGlfcmVj
di5tc2cgPSBkZXZtX2t6YWxsb2MoZGV2LCBNQk9YX1NMT1RfTUFYX1NJWkUsDQo+ID4gR0ZQX0tF
Uk5FTCk7DQo+ID4gKyAgICAgaWYgKCFwcml2LT5pcGlfcmVjdi5tc2cpDQo+ID4gKyAgICAgICAg
ICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKyAgICAgcHJpdi0+YmFzZSA9IGRldm1f
cGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gPiArICAgICBpZiAoSVNfRVJS
KHByaXYtPmJhc2UpKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIocHJpdi0+YmFz
ZSk7DQo+ID4gKw0KPiA+ICsgICAgIHByaXYtPmNmZyA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0
YShkZXYpOw0KPiA+ICsgICAgIGlmICghcHJpdi0+Y2ZnKQ0KPiA+ICsgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsgICAgIGlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRl
diwgMCk7DQo+ID4gKyAgICAgaWYgKGlycSA8IDApDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4g
aXJxOw0KPiA+ICsNCj4gDQo+IFBsZWFzZSBzZXQgdGhlIGRyaXZlciBkYXRhIGJlZm9yZSByZXF1
ZXN0aW5nIHRoZSBpbnRlcnJ1cHQ6IHdoYXQNCj4gaGFwcGVucyBpZiB0aGUNCj4gSVNSIGlzIHJ1
biBiZWZvcmUgaGF2aW5nIGRyaXZlciBkYXRhIGF2YWlsYWJsZSBvdGhlcndpc2U/ISA6LSkNCj4g
DQoNCk9LLCBJIHB1dCB0aGUgInBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHByaXYpIiBiZXR3
ZWVuIA0KIm9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpIiBhbmQgInBsYXRmb3JtX2dldF9p
cnEocGRldiwgMCkiLg0KDQpEbyB5b3Ugd2FudCBtZSB0byBzdWJtaXQgYSBuZXcgdmVyc2lvbiBy
aWdodCBub3c/DQoNCj4gPiArICAgICByZXQgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKGRl
diwgaXJxLCBOVUxMLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bXRrX3ZjcF9tYm94X2lycV90aHJlYWQsDQo+ID4gSVJRRl9PTkVTSE9ULA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2X25hbWUoZGV2KSwgcHJpdik7DQo+ID4g
KyAgICAgaWYgKHJldCA8IDApDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsN
Cj4gPiArICAgICBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBwcml2KTsNCj4gPiArDQo+ID4g
KyAgICAgcmV0dXJuIGRldm1fbWJveF9jb250cm9sbGVyX3JlZ2lzdGVyKGRldiwgJnByaXYtPm1i
b3gpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a192Y3BfbWJv
eF9jZmcgbXQ4MTk2X2NmZyA9IHsNCj4gPiArICAgICAuc2V0X2luICAgICAgICAgPSAweDEwMCwN
Cj4gPiArICAgICAuY2xyX291dCAgICAgICAgPSAweDEwYywNCj4gPiArfTsNCj4gPiArDQo+ID4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a192Y3BfbWJveF9vZl9tYXRjaFtd
ID0gew0KPiA+ICsgICAgIHsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk2LXZjcC1tYm94
IiwgLmRhdGEgPQ0KPiA+ICZtdDgxOTZfY2ZnIH0sDQo+ID4gKyAgICAge30sDQo+ID4gK307DQo+
ID4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG10a192Y3BfbWJveF9vZl9tYXRjaCk7DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfdmNwX21ib3hfZHJpdmVy
ID0gew0KPiA+ICsgICAgIC5wcm9iZSAgICAgICAgICA9IG10a192Y3BfbWJveF9wcm9iZSwNCj4g
PiArICAgICAuZHJpdmVyID0gew0KPiA+ICsgICAgICAgICAgICAgLm5hbWUgICA9ICJtdGtfdmNw
X21ib3giLA0KPiA+ICsgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gbXRrX3ZjcF9tYm94
X29mX21hdGNoLA0KPiA+ICsgICAgIH0sDQo+ID4gK307DQo+ID4gK21vZHVsZV9wbGF0Zm9ybV9k
cml2ZXIobXRrX3ZjcF9tYm94X2RyaXZlcik7DQo+ID4gKw0KPiA+ICtNT0RVTEVfQVVUSE9SKCJK
amlhbiBaaG91IDxqamlhbi56aG91QG1lZGlhdGVrLmNvbT4iKTsNCj4gPiArTU9EVUxFX0RFU0NS
SVBUSU9OKCJNVEsgVkNQIE1haWxib3ggQ29udHJvbGxlciIpOw0KPiA+ICtNT0RVTEVfTElDRU5T
RSgiR1BMIik7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstdmNw
LW1haWxib3guaA0KPiA+IGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay12Y3AtbWFpbGJveC5o
DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjE0M2Zi
MGQwNmUzMA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21haWxi
b3gvbXRrLXZjcC1tYWlsYm94LmgNCj4gPiBAQCAtMCwwICsxLDMyIEBADQo+ID4gKy8qIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBNSVQpICovDQo+ID4gKy8qDQo+ID4gKyAq
IENvcHlyaWdodCAoYykgMjAyNSBNZWRpYVRlayBJbmMuDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiAr
I2lmbmRlZiBfX01US19WQ1BfTUFJTEJPWF9IX18NCj4gPiArI2RlZmluZSBfX01US19WQ1BfTUFJ
TEJPWF9IX18NCj4gPiArDQo+ID4gKyNkZWZpbmUgTUJPWF9TTE9UX01BWF9TSVpFICAgMHgxMDAg
LyogbWJveCBtYXggc2xvdCBzaXplICovDQo+IA0KPiBQbGVhc2UsIGNoYW5nZSB0aGlzIGRlZmlu
aXRpb24gdG8gTVRLX1ZDUF9NQk9YX1NMT1RfTUFYX1NJWkUNCg0KT0suDQo+IA0KPiBDaGVlcnMs
DQo+IEFuZ2Vsbw0KPiANCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsgKiBzdHJ1Y3QgbXRrX2lwaV9p
bmZvIC0gbWFpbGJveCBtZXNzYWdlIGluZm8gZm9yIG10ay12Y3AtbWFpbGJveA0KPiA+ICsgKiBA
bXNnOiBUaGUgc2hhcmUgYnVmZmVyIGJldHdlZW4gSVBDIGFuZCBtYWlsYm94IGRyaXZlcg0KPiA+
ICsgKiBAbGVuOiBNZXNzYWdlIGxlbmd0aA0KPiA+ICsgKiBAaWQ6IFRoaXMgaXMgZm9yIGlkZW50
aWZpY2F0aW9uIHB1cnBvc2VzIGFuZCBub3QgYWN0dWFsbHkgdXNlZA0KPiA+ICsgKiAgIGJ5IHRo
ZSBtYWlsYm94IGhhcmR3YXJlLg0KPiA+ICsgKiBAaW5kZXg6IFRoZSBzaWduYWwgbnVtYmVyIG9m
IHRoZSBtYWlsYm94IG1lc3NhZ2UuDQo+ID4gKyAqIEBzbG90X29mczogRGF0YSBzbG90IG9mZnNl
dC4NCj4gPiArICogQGlycV9zdGF0dXM6IENhcHR1cmVzIGluY29taW5nIHNpZ25hbHMgZm9yIHRo
ZSBSWCBwYXRoLg0KPiA+ICsgKg0KPiA+ICsgKiBJdCBpcyB1c2VkIGJldHdlZW4gSVBDIHdpdGgg
bWFpbGJveCBkcml2ZXIuDQo+ID4gKyAqLw0KPiA+ICtzdHJ1Y3QgbXRrX2lwaV9pbmZvIHsNCj4g
PiArICAgICB2b2lkICptc2c7DQo+ID4gKyAgICAgdTMyIGxlbjsNCj4gPiArICAgICB1MzIgaWQ7
DQo+ID4gKyAgICAgdTMyIGluZGV4Ow0KPiA+ICsgICAgIHUzMiBzbG90X29mczsNCj4gPiArICAg
ICB1MzIgaXJxX3N0YXR1czsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyNlbmRpZg0KPiANCj4gDQo=

