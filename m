Return-Path: <linux-kernel+bounces-786115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DC7B3551F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0B8174CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E819277819;
	Tue, 26 Aug 2025 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OfKNI04q";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="oQb2iygQ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B6D393DE2;
	Tue, 26 Aug 2025 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192591; cv=fail; b=mtaDFk5zDXdLwAMKO0UKtuQ/GZgyYRB57xTPSUn9TtS6DBiGKElunzttm9qkcxGiUCidBrWWMoGtnZsRYEAekrcZlkyQ88QiWeLcF9jZjb5RqRj0ydhZctqCaHFIGvuRIFzcv17NUetEdpjfQLlhSgmliOAHrVxzbfoV6MoGcXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192591; c=relaxed/simple;
	bh=NtQbZgHI+Ihradc/JpzTVhFomZl7noqePYhXa4eIroU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t3unlPW9JLbHinmPRS86FjCf3xA+6wjR0WhXfk84MMn/8FTOjqYbq1/MUTfqYs24cWGXsFTiqRrBOZL5omM+nptfN7GfxpXgG+XmXtQz32qSK3JxMZiKx+8Gx1pSs/3u9HymZl3IGZ9SU8k/0qmYIk0egWb5ZyhfeuSRpT9KJIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OfKNI04q; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=oQb2iygQ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 90ca44a4824c11f0b33aeb1e7f16c2b6-20250826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NtQbZgHI+Ihradc/JpzTVhFomZl7noqePYhXa4eIroU=;
	b=OfKNI04qzI6nNDdDvaesPZdxA6b7qecGl9J4LQyIpey2doENF48yt/q2qITVyDeXchBVwR7hy4esXAljsByt1ijk6jy2+Diw6cN2SHs/WNa0VbN2vGw8KltTzkxurM5vSXlZHRlXcXqpPGKxakB9HBXOz0S7xgFWE44OKizCBFE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:a4b5b381-0b58-4038-8973-4ea0c28818d7,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:750ce044-18c5-4075-a135-4c0afe29f9d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 90ca44a4824c11f0b33aeb1e7f16c2b6-20250826
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <hailong.fan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2051603358; Tue, 26 Aug 2025 15:16:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 26 Aug 2025 15:16:19 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 26 Aug 2025 15:16:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u52OEz+yO4SV9WmeVFi2vMkGq04uR9q3g+u7iBsxmAD8tFCdeKv6uE39xuw87mEncT0U8nWRw2anrVwxS45PHLeT7H1v3tytmwtNmpZT+A9DSrRZpSpO7KGKS3w0fht/XIkoJ6lQufgP4n0Rd2sa5J98hAo+saF2Sw1SjUsnKphjJvovT/tzsNt5w6cfr/IDpmoFTLri4j0x3rfYGkUVtewd/kiCKmkdfQT4ssfBQYDpr2rUoRr6rCEFcMX42KTu2gfhel+8o2ENGqqzmYOGcHDtGNlhcPdV+minm3lLb5LsPLyI82ejKjUzXUgxHKIp78VcAmTHoLw/bMoFHLhjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtQbZgHI+Ihradc/JpzTVhFomZl7noqePYhXa4eIroU=;
 b=f3/gq4pwrsSz7vUTNbeQefprCwzGbbCGLO9MY1tEAxVDNr8LoWDYZ3NS5k2CBMMrVDxnU7oi7/pAPn0BOlQ4R85onNhZPLB72tVZm2OsPkNX8w6MaGUx9TEVrBOp0iIjxpPBiVVjjbOEr6PI2ijF6GU6m0QTi1/gTPnn16wtfNchykd9kWcYEx/p1PBhdvju/4MPqVyc8Kpr5g2gvagfpFn8qw+baI7yNZJIvFmm62x8L2gNnfsVO/MrNbu3yHMF9wvrX8UlI0qGYZOnJb4SP3nbJFoJCuOL7czXmjVNc7LHm5Rc4/5SmgOYbsrqwvsDviG9jHJ9+wyqAillxuAkLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtQbZgHI+Ihradc/JpzTVhFomZl7noqePYhXa4eIroU=;
 b=oQb2iygQ5S1XEanEiFjKGQNQUL1NLCpKDZ93vKU1SP2zJumUfGFNI+lPtB7mPNrlOYa9jLPV58+UaKgO0i6gHTavIQSpVaEs0IlmCGhS8m3GGZlceS7gYDo3wtzhpBRN5Ep/SW8IY0tSB3+LFRXnH5/WL6RPzFJlDsNxSsib8ww=
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com (2603:1096:820:8f::5)
 by SEZPR03MB8485.apcprd03.prod.outlook.com (2603:1096:101:223::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:16:16 +0000
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d]) by KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 07:16:15 +0000
From: =?utf-8?B?SGFpbG9uZyBGYW4gKOiMg+a1t+m+mSk=?= <Hailong.Fan@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>, "pierre-louis.bossart@linux.dev"
	<pierre-louis.bossart@linux.dev>, "kai.vehmanen@linux.intel.com"
	<kai.vehmanen@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "tiwai@suse.com"
	<tiwai@suse.com>, "robh@kernel.org" <robh@kernel.org>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "yung-chuan.liao@linux.intel.com"
	<yung-chuan.liao@linux.intel.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "peter.ujfalusi@linux.intel.com"
	<peter.ujfalusi@linux.intel.com>, "perex@perex.cz" <perex@perex.cz>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	"ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
	"daniel.baluta@nxp.com" <daniel.baluta@nxp.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "sound-open-firmware@alsa-project.org"
	<sound-open-firmware@alsa-project.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: dsp: mediatek: add mt8196 dsp
 document
Thread-Topic: [PATCH v2 1/2] dt-bindings: dsp: mediatek: add mt8196 dsp
 document
Thread-Index: AQHb6/AjDLqCeVaT/UOLwUvdRPs5orQgC4SAgAAP9QCAABYCAIAJJawAgAAObQCAS3UoAA==
Date: Tue, 26 Aug 2025 07:16:15 +0000
Message-ID: <f8b2a2bf59eb8f6cdbc7fd80e5c2c5df7df9271e.camel@mediatek.com>
References: <20250703075632.20758-1-hailong.fan@mediatek.com>
	 <20250703075632.20758-2-hailong.fan@mediatek.com>
	 <defd70cb-4351-4b0b-b4d0-dd1ff831615c@kernel.org>
	 <61784658-c71d-458b-8934-5f5db2330bc0@collabora.com>
	 <8b8a58f0-9e18-47d6-8382-1d16d630ea15@kernel.org>
	 <dff1a4d6d97d7d3d55c4bd409780d2857ae070ca.camel@mediatek.com>
	 <738c1951-afbc-4cda-a16e-54a5055ca7c8@kernel.org>
In-Reply-To: <738c1951-afbc-4cda-a16e-54a5055ca7c8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6002:EE_|SEZPR03MB8485:EE_
x-ms-office365-filtering-correlation-id: c2891254-80f8-4ba5-1c8c-08dde47071cd
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ejk2c0Zibm1pNkhPUXZlRm5lYUJUUmJPdjQ3bkJiWE9rM3FnbTlTakVTb0pD?=
 =?utf-8?B?WDFWNGNCeTZzRW9pMDN1Z3pGS2ZsSmFPLzdwRDNpR2RyWFZBQ0xnUTlIODVP?=
 =?utf-8?B?anA3ejR1U2w1NloxcVVsZi9qa3phTTFLeXVsSVo3VUMvNWI1SXlaM1IyY0NP?=
 =?utf-8?B?TFByMFE5V0xJY1RUU0oxbThtODB5TEgwOU9sZFNQdStwRFZ0dVRxWFhmZjZC?=
 =?utf-8?B?QmlGb0dPbnBmbFQxVmxTdWxUaThnOFlGYmhMeVFRWjlrOWVWdFFSZW9CZXll?=
 =?utf-8?B?blk0TUpaMW5LbjFuVi92cTM3L2pJb21zc3BXMUo5ZXMwSFVCOHh1ekJ2Vm9k?=
 =?utf-8?B?cWhENWFVZ1kxdU1xYTR3TkFDcGI5Qi83ZFZ5L1ArRmVoaXFRTllOOE9SZ2dC?=
 =?utf-8?B?Q3FoNVk2T2JBYTZxRlNNQmtkWjhiTVg3RFppUHpzOENRR1RHWUZDSVJQdlJs?=
 =?utf-8?B?Vy9na3A2NXB5UTVSNHZKWmhBNWJNN0VsaDJQVmhFcWFJVGE0Q0tKZ256RVNZ?=
 =?utf-8?B?V0dQOGxlZEpud21YbDY1bEk2bUNNSklQWVhLQXlKSnN2dUVHYWVyWkFPWEx4?=
 =?utf-8?B?T1FKRW8rOGszeERJS2FycHhZQi80Qmc2UTdFdkhQS0duRnZxMks1MlVEZGpR?=
 =?utf-8?B?d0JhaEtUWnlIamRFcCtWY3N6OSttOHFzRGRBZWo1eE90WGJjSitrTFBNdFdZ?=
 =?utf-8?B?WnI2b0NyVXlZOUZVNFN2Rk00OHQyc3FwY2ZCN1cxN1ZQdlRadnFoVGU1anVM?=
 =?utf-8?B?bGhjSk5MVHBrZXFwNjdiWS9aci9aVGIrNTVIRDZKS3pqWk90bjFOdlJlQ3o0?=
 =?utf-8?B?Z0QrdnZuM3Q1MFBTeXhUd1Q4V3RnUnpXVGFEc3pHRTlGWUh1c2hEZ1RYZnR6?=
 =?utf-8?B?a2ZiVUMrZ2h6YkxMcmpiYW54VklLZ3BuVDNsYkcvVnhseHc2NDJoRlNoSVc5?=
 =?utf-8?B?UkRqdHlTYWQrMjZ2WVp0TXc2NHExK055MzBwVEIvekNvNjA0WmVTYlQ1bFQ2?=
 =?utf-8?B?SVhTeURNQXE0MVNQTnJ3amttcUxZVTR4SjNCYzlOd21UdnhuTlVUb2hnYjdp?=
 =?utf-8?B?eHU3MmtFbWVBQkFmYkx2V25GTlVWRVhFZ2RZazFQZk9SQ2x3MDFxdzlvRGEw?=
 =?utf-8?B?aDJEaXduM0xNcUE1cHRLK0JScURaeGpmZXRNV1ZjMDB2Ti9GVS9RYVBOcjBP?=
 =?utf-8?B?RmlxMFhHaGlrQXdxMjdaS3I2Mm01RnQ4L2JQd0xTWGxkUG4rdEFVdm0xZmJm?=
 =?utf-8?B?cjVhZklURi9nWkxsT0VaUjNqSlhkeElCWUt6MTJQZ1B6dFVjK0w1S0NYeHpR?=
 =?utf-8?B?N3dQSDBGanhyV1k5ZDk3NEEvODMyVkxnR1Rjd0F1cDd6Yk1vSng0SGJaRnAz?=
 =?utf-8?B?MHFScGdxTjVWemhjeVJteU5BbzVBUVppWVhIbUlpeXN3dzZJZk9TUjBkdExC?=
 =?utf-8?B?aHF4eXV5Q1RCaVpzUGxPTHQzbUJVZHF1WFZDK0VBUHlBY2k5aktRZEtPQkkr?=
 =?utf-8?B?U2RpaTZTc1pSNWNTVlFYM1h1SjB1bDhCQXZjUVM5VjBpSjE1azNQQnU1NytT?=
 =?utf-8?B?c0NNQ3ZtK3MrN053aWRNWVVSN2EwZ3ZFMXhhODk0YmJhL2V1QlpIdVp5Nm9Z?=
 =?utf-8?B?WlpKTWFwWGxKKzdMZ2JmMVZlejdJN2wvTkV2NzlaSEhkUjEyU2U2Vy92eS8y?=
 =?utf-8?B?L0VEK2p3RG9hc1dNM3Z6REdhOW9zeHdMUm5qd1JFQkVrQXg2M3owQXcweU83?=
 =?utf-8?B?aUlrZUcwZWNGM2RDYWJqNC9mTGpWOTlvaXhpUjhnMmM4VnJZamlVR2RhMTVC?=
 =?utf-8?B?Y1M0SXJLbTQ4ZTVWQm05bVY4cDFCWjhrRUhkNmlQUVFvZ0JLcWhlQk1DYTRF?=
 =?utf-8?B?dVJVWVNEUHJvdXQrS2grWUVwOFFZcmhENmhNanhSOEl0T1A1Smx1ejFxQWRu?=
 =?utf-8?Q?TPKH9jXbj6QWPZZti/QZQkXlxZTjW2qT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6002.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTdFcVp3SFAzUStrNTA5Wmh6M3Z1MUp2eEZDejd3bDRGUUtaMFBLcGtyU2ww?=
 =?utf-8?B?MzVKUG9hV3lHVENhQzBGdVRDVXVlSjVZM0dMQVl2c0ptcCtaMzMwK0RiOE84?=
 =?utf-8?B?NHF6NStFSWl5LzVQZlNRSlZuQnE0WlVuamU4dUY2a3pwb1FTakZTQ1VYMmZG?=
 =?utf-8?B?UDhrQjhBdmI2dFF1RU9mNWpMbyt6NjR5ekNpRzliVzRSd1huZ0k2bjFTdGNs?=
 =?utf-8?B?Z1BQSVBENDRnalJKMlB5TkE1M0Fqckc4Q0lzZ0M1eEM5eHlwNmkwRnRScmVa?=
 =?utf-8?B?WWlDTFNCOVhJVFZEYmczSG0zNkd4TVFkVHpsdkNCUWtFWHA0WUcySW9JSWVG?=
 =?utf-8?B?QWRCWW9BVkxXTnhxU1BlN2poRHdiRzhkcldOaWt5dm0zSnpwK2p6a0I2d01h?=
 =?utf-8?B?RXdHOTdFZmlFcW11bDRxQjhuQ0M3VlpDR1ZnSUNxTTdNMHNZTzd1bXErYzN6?=
 =?utf-8?B?emQwQVEyRk5HalIxMVBkeEgyN0M3aTZoTnZMcm44MWc2VWdLdDNDRytvSVlj?=
 =?utf-8?B?Q3ZPZDBvaGhqMVUwc0dPUmhXQ0VYaDRvMGdEbnl1MWJaN3J5cVFBZ1ljZWoz?=
 =?utf-8?B?WHdWTDVhSnVyZ09wVUlpTm9Yc1hnTnJHdlhFR2xxZDJ6UVNQWHhramZ3UTNZ?=
 =?utf-8?B?aFJVcUJiVll3U1Vucm9SR1pWcjNGZFdPaEpSMit1M1d1UUFnZW41MHRMcTBq?=
 =?utf-8?B?WEphU3hBRHZQZkxaaHJBRkdCM2Q1UXo0d1BFdXE1bjZYMVF5aHFYenpjRGVi?=
 =?utf-8?B?WHlEMVd2U3MrNE9wSmtQb2FGWmlaaC92UG9OcGlEanJzWUdvT2N3T0U1T1FF?=
 =?utf-8?B?SXNxTkdqQTJuRDVNTGlUS21BMWZpd1NrNy84RnNKbnhtVzFVYTdYSE5ZSDRW?=
 =?utf-8?B?SnhOcjFTc2lPWHJ4VVZJMk84WVY4V0RrZENQMmVrc0h5dUIrWEljLzZVWEZR?=
 =?utf-8?B?K3p4Unk0dG1HSllkR1FveXpkNGhnSmY3Q0RQTVN0dG9OaU8xd2p3U24xR2JI?=
 =?utf-8?B?enFzTjkxQjBXRGxSOUVHcHRmeXZEa1dQVVJkc2ZkZGY0dXhTelRLUVdEeGk0?=
 =?utf-8?B?THNUY3dBNTFaalhTd1NWUUFlT29Mc0FmUEJKNC9saVBZRld0djU4K3BNYmNr?=
 =?utf-8?B?U2QwZzZkdWxMM2ZQZ1FrR1JCcllBdThvanptOUxraGVQTk9HY1NMSnB3Mkxv?=
 =?utf-8?B?VmJ3czlSREI0YmpHV2pHSjY0ZGowWktVdTBGSVB4cWhJSXJBVWFxUDVLTUs0?=
 =?utf-8?B?T0hsaVBYWmxzN0sxdWE3bC9ON3VLTXBQWHZ0TDdNM3NPalVCZVlRU1diMjgw?=
 =?utf-8?B?bE01aUVYYXBVSWY3NUgvU1B1VlMzY2pRaFh2ZnI3TTVza3VYWWFidnZmVWE1?=
 =?utf-8?B?Nk14S2Q1VHk1YnlEVlFGZ2twVEVsQ0JnN1h3TkwxYWl5WHZ3Vy94STZsb2ZX?=
 =?utf-8?B?UGhFNjVSL3dJb2lHdzZhK2oxRGJmaG1HMDFQNStMVFF0dHA0eUEwVFRoTmV4?=
 =?utf-8?B?dkh5SDVQV3UydDFCZWJUZ1Fmckdka0xaVmpySDNiUjM1MmY3d0ZZUDZYNnBj?=
 =?utf-8?B?Zk1Jd1lGazBBMmxJaitWRVg5VnJnSXZpbWtSa3hyR0xGZWFKQzhzUVVvYlYx?=
 =?utf-8?B?S1JJTTZ1ck5ENGcwSGdyWE5OQW92U0RaYVZUZXZtN0FVMStxUmNmckEyRlQr?=
 =?utf-8?B?MHUvVEJLektiRitFWFdwZkxPNlVBNkFJTlZmQjNjZDJKTkV5ZzRhbkZJdFlw?=
 =?utf-8?B?Vzk4czNKdGdRck15S0loK292R3lLNnBLajg3MUR4Q1gzQ0l5blJlZWo1VU02?=
 =?utf-8?B?Rlc2Um9NNDhPRi81R1N2eS9FT1hLTHFRNVZaN3FNSGdhSU50SzFSc0wzTFh0?=
 =?utf-8?B?MGw1L0FSUm9rUWR5bGFEbzhlaXFNMzdIWGc4WWJUSklISFFMTFVsbXp1SVRB?=
 =?utf-8?B?WUsraUdydC9DZnRYVWRBaFY1UDAyK2crZFY2OFZpTmRUTUdueXJrSFY5WVc1?=
 =?utf-8?B?VURtSVJOUlE3OE83cVQ4SlpETWVDNnZHTEdEUTZhbDdqSzh5ZitUVysvUmgv?=
 =?utf-8?B?QzRGSDFXTW5oMHdXQmw2MzluT0VWVnVlOWl3eE9remR2UnU1QnJPWGpEVS9w?=
 =?utf-8?B?UFhqVElFQTdWTU4zQzVBTGdtazBGSnZBNXd5R0xlVTBZQWdxSzZoTHdUcjJL?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87DA8DE4CB56EA40ADD46166161D7790@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6002.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2891254-80f8-4ba5-1c8c-08dde47071cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 07:16:15.2767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fHgo6fCSk6Uu3YtwzQrLb0Cwdp0Nc2a60ZERW9OtFdTqy3AtrgDY5G5mQ3xfp55iR94e2M8lxoONdz9YmvP1Hcr08lElVMJ6ypp6UtQ5EQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8485

T24gV2VkLCAyMDI1LTA3LTA5IGF0IDA4OjU3ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDA5LzA3LzIwMjUgMDg6MDUsIEhhaWxvbmcgRmFuICjo
jIPmtbfpvpkpIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPSywgdGhpcyBpcyBhIHZhbGlkIGFyZ3Vt
ZW50LCBob3dldmVyIHdlIHN0aWxsIHRyeSB0byB1bmlmeSB0aGUNCj4gPiA+IGlucHV0cw0KPiA+
ID4gc28gYmluZGluZ3MgY2FuIHNoYXJlIHN1Y2ggcGllY2VzLiBJdCBpcyBkaXNjb3VyYWdlZCB0
byBoYXZlDQo+ID4gPiBzaW1pbGFyDQo+ID4gPiBkZXZpY2VzIHdpdGggZGlmZmVyZW50IGJpbmRp
bmdzIGluIG9ubHkgb25lIHBsYWNlOiBjbGsyNm0gLT4NCj4gPiA+IGNsazI3bQ0KPiA+ID4gb3IN
Cj4gPiA+IHdoYXRldmVyIG90aGVyIG51bWJlci4NCj4gPiA+IA0KPiA+ID4gQ29tbW9uIGlzIGFs
c28gdG8gbmFtZSB0aGUgY2xvY2sgaW5wdXQgYmFzZWQgb24gdGhlIHB1cnBvc2UgKGxpa2UNCj4g
PiA+IGJ1cywgcmVmKS4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4g
PiBLcnp5c3p0b2YNCj4gPiANCj4gPiBPbiB0aGUgTWVkaWFUZWsgcGxhdGZvcm0sIHRoZSBtYWlu
IFNvQyBjbG9jayBzb3VyY2VzIGFyZSB0eXBpY2FsbHkNCj4gPiAzMkssDQo+ID4gMTNNLCBhbmQg
MjZNLiBUaGlzIGlzIHdoeSB0aGUgdGVybXMgY2xrMzJrLCBjbGsxM20sIGFuZCBjbGsyNm0gYXJl
DQo+ID4gdXNlZC4NCj4gPiBTcGVjaWZpY2FsbHksIGNsazI2bSByZWZlcnMgdG8gdGhlIHN5c3Rl
beKAmXMgMjYgTUh6IGNsb2NrIHNvdXJjZS4NCj4gPiBUaGUgY2xreHh4IG5hbWluZyBjb252ZW50
aW9uIGlzIGludGVuZGVkIHRvIGluZGljYXRlIHRoYXQgdGhlc2UgYXJlDQo+ID4gU29DDQo+IA0K
PiBCdXQgaXQgc2hvdWxkIG5ub3QuDQo+IA0KPiA+IGNsb2NrIHNvdXJjZXMsIHdoaWxlIGFsc28g
ZGlzdGluZ3Vpc2hpbmcgYmV0d2VlbiBkaWZmZXJlbnQgY2xvY2sNCj4gPiBmcmVxdWVuY2llcy4N
Cj4gPiANCj4gPiBUaGVyZWZvcmUsIHVzaW5nIG90aGVyIHRlcm1zIGNvdWxkIHBvdGVudGlhbGx5
IGNhdXNlIGNvbmZ1c2lvbi4NCj4gDQo+IE5vLCB5b3UgZG9uJ3QgdW5kZXJzdGFuZC4gVGhpcyBk
ZXZpY2UgcmVjZWl2ZXMgc29tZSBtYWluIFBMTCBvciByZWYNCj4gY2xvY2suIFRoYXQncyB0aGUg
b25seSBpbXBvcnRhbnQgaW5mb3JtYXRpb24gaW4gdGhlIG5hbWUsIG5vdCBpdHMNCj4gZnJlcXVl
bmN5Li4NCj4gDQo+ID4gDQo+ID4gRm9yIGV4YW1wbGUsIHRoZSBBRFNQIGNsb2NrIHNvdXJjZXMg
YXJlIEFEU1BQTEwoODAwTUh6KSBhbmQNCj4gPiBjbGsyNm0oMjZNSHopLg0KPiA+IE9uIG90aGVy
IHBsYXRmb3JtcywgdGhlIGRlZmluaXRpb24gb2YgY2xrMjZtIGluIHRoZSBEZXZpY2UgVHJlZQ0K
PiA+IFNvdXJjZQ0KPiA+IChEVFMpIGlzIGFzIGZvbGxvd3M6DQo+ID4gDQo+ID4gDQpodHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDgxODguZHRzaSpuMzI4X187SXchIUNUUk5LQTl3TWcwQVJidyFpYlNjUEI4OXR5
Vm9sblVoQnNjbTZna0V3TWViRGlEOEZvelRZMUhfLWNNWjVfa2xCeG1KeGdXbE9UT2hib0lURWxz
NGVmNHctVGNlMnFzJA0KPiA+IFRoZSBtdDgxOTYgcGxhdGZvcm0gdXNlcyB0aGUgc2FtZSBkZXNp
Z24uDQo+IA0KPiBTbyB5b3UgYWRkIHBvb3IgY29kZSwgYmVjYXVzZSBwcmV2aW91c2x5IE1lZGlh
dGVrIGFkZGVkIG1vcmUgcG9vcg0KPiBjb2RlPw0KPiBXaGF0IHNvcnQgb2YgYXJndW1lbnQgaXMg
dGhhdD8NClRoYW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0aW9uLiBXZSBhcmUgcGxhbm5pbmcgdG8g
dXBkYXRlIGl0IHRvIHN5c19jbGsNCmluIHRoZSBuZXh0IHZlcnNpb24uIFdoYXQgZG8geW91IHRo
aW5rPw0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

