Return-Path: <linux-kernel+bounces-816486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6CAB5747D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC951A221B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2059D2F657C;
	Mon, 15 Sep 2025 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qCJJApgx";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JlkVIn8O"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7882F6186;
	Mon, 15 Sep 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927728; cv=fail; b=agDpPHJsZLuQjL8Q7bu3Ormi+1NbfoM/U1Vr7J2GyskR5/hZtO5/FUknKsNEssqcuAyEaj6nYbYnc0bbRINEAjS8Ga4ddTzCaY/mHlTyGkwx+9Rr66xUo9DXVA6hISSrJQujJCZ11fRiAknD0u5f2iDlYLKD9VJp21dhefh9HKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927728; c=relaxed/simple;
	bh=mpg6yvNZp6Z+bQhw1dT5D27DgYI8cOpNlny5xGHawPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dhcemfK9qRIPspqQZ3ZeDOZQ+RaftDVXGaCgS6EqxJLtRFolVtKCn+t0Xs4DZDenN7OTmHrciIkYSSBE16kWIBSOU6YFOheUM8YUGmMSR7Vqu2JXchbJi5ZCv58jXW6qD+rEkVbiCtL33+sSe7y2TiIivJgLFeYMrzXSz2rc+Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qCJJApgx; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JlkVIn8O; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 81187184921411f0bd5779446731db89-20250915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mpg6yvNZp6Z+bQhw1dT5D27DgYI8cOpNlny5xGHawPA=;
	b=qCJJApgxXDqlHSAhuSgWbMsHF2aJSbRcJlxUDceSZuO3SQvDuTl8pXGhon9ZFtFaxOV1PAVRFU3acRbuMdzzHcHXA1OB3VuY63LKQmP7VP8d+xAv2AArf4M1oRv5wdvZnbF9Oktqe358ARPefRw7ssLVMuSjPscJSjAGczT9DqQ=;
X-CID-CACHE: Type:Local,Time:202509151715+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:d67c042d-a834-430a-86ab-57a6f4571a32,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:1eec54a9-24df-464e-9c88-e53ab7cf7153,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 81187184921411f0bd5779446731db89-20250915
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 766375644; Mon, 15 Sep 2025 17:15:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 15 Sep 2025 17:15:19 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 15 Sep 2025 17:15:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+ZCLyCukxx6/Pbze+QzeUKJmvR1mvycycHSK4TqDtxGeuCyMfZzcEI/R7AVfp22fVUZ8ja55rxKCeD3wchtriZbc7CCGfqQcavpKk/mBwNnzrTo5XYZyaiMw+/uOiihjDaMyFCfwAtRI0dMyz81XWxYom5f9Coj4ItFrvAp/0+zU4ka66nUUcC/Hh7cOSWmfqmW3wRJ39eKGAAzY755CGfV7YsWM8M1YRSfUVt5FzwSkD2iDO5EnesdCtgIcUEuF3aQ0rEQPK7pYSfpmdVBNWsYvibrCWC+mHdgne8++ZbtB3U7VOBSflmr6F8YtEoiDyG3l9Hp0MHxHApHIX6V/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpg6yvNZp6Z+bQhw1dT5D27DgYI8cOpNlny5xGHawPA=;
 b=O8BEMImCndkmmNrC53b0wYVMH9fvXMHq8ka4q5RzARn4aUJyex5hQndKLhEwvCvrncpJ0YVYp/hsB9KC1LuiiYlFzdG6xuXGT6b32LuD+wsbGbfZ7oYFBZHdXeBM+76FK2ofovVhQUfLJ4/dOX81troy68sRi9FHhU7UlZ3gajL6jRYM4DRDJthIIh/0QBnFkvni92mduBQjXZ5TLWgj3jgk2YpcdvT2YbSWpIpR1JFANIeyFHrdHxxDUPdtkUN4ujM8ZULxYpEC6iyp8anKboxhoYvvzkyEUVYrJenst/jzTCSzJ325HVu/ap2LaKB0plTx/mSXpe+taUZbUotsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpg6yvNZp6Z+bQhw1dT5D27DgYI8cOpNlny5xGHawPA=;
 b=JlkVIn8Ortb8NsWRTcGOCT3LYKnMGwQ/um9HGeUtA6oqLoSf2kYVObOYdIzvW2sPDubSFZ5mMXo2n22dFQGCoYfBF1fzHgpRrq/ezL5rmFRGwd8ARqIowE1Ygq5MzVemVTSN1mR8WNCilc+zUHrxEIOMRK5D/PVmXJ0eI+Gbab0=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by OSQPR03MB8747.apcprd03.prod.outlook.com (2603:1096:604:282::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 09:15:17 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%5]) with mapi id 15.20.9115.017; Mon, 15 Sep 2025
 09:15:17 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "robh@kernel.org"
	<robh@kernel.org>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v10 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Topic: [PATCH v10 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Index: AQHcBrCYXXn8dpTcxEeaFgD9eans8LRe8dyAgDVDQgA=
Date: Mon, 15 Sep 2025 09:15:17 +0000
Message-ID: <9bc7813b6d9717c14642f07648c0b552206fec07.camel@mediatek.com>
References: <20250806085946.11383-1-friday.yang@mediatek.com>
	 <20250806085946.11383-3-friday.yang@mediatek.com>
	 <cad00fbcb5dc69bb76358d495cef08dad56306a5.camel@pengutronix.de>
In-Reply-To: <cad00fbcb5dc69bb76358d495cef08dad56306a5.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|OSQPR03MB8747:EE_
x-ms-office365-filtering-correlation-id: af66dcde-3ec2-4255-d5eb-08ddf4386300
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?M3NvakxjajRnN2hzZlVJNERlSVpuWFlNb0dVUHNBYlJTUE5Hd216bFhjajJs?=
 =?utf-8?B?NGZOMDRYMnRPb3dlMFFyVVd5VGRhOFlzTTVLQVk1aVZTcWczR1RZczJTVFFS?=
 =?utf-8?B?dEZjWkFkbUV0UlhieWFDdmxKekdINm1USVpNalI2RmdoeEhyQkp2cDlwcytm?=
 =?utf-8?B?aEpuVXdvK24vdVRuRkFvZW1EY3RvRWNJSDJSVTlORHBrN3N6NmtDQkFmRGRp?=
 =?utf-8?B?VVBRZCsvK2NYTEhISUZ3TklXVzVlMmRTc01mOER5Wlo2NTRmMW1QeUlsd2tR?=
 =?utf-8?B?bXRNOEpNVllhY0U5M3BqVkd5a0VmTmxCTTU3bnVHVTFOdjl5S3FHT0szUFJx?=
 =?utf-8?B?akFhMHlQcHIrYTdyUHE5VnNvY3NmejBLcDVsbjdjZ2x2czJyV015dHJUZkU3?=
 =?utf-8?B?bWw1TmJnK0VpUXJiNDNKWm14Zmw5V2l4V2t3ekNrY2xUa0xMZkJVK2ZvSGJQ?=
 =?utf-8?B?TDduUzdaZWFFY0YvQ0ZrYUVsdW1DRzVidXN6M1dVN0tzK1VodjRhNHYwdk1h?=
 =?utf-8?B?ZFFGN2tveUxwZmRBSnpYNHpiRTcyZktranRib1JhZGlzQmFucExSWkFOak5p?=
 =?utf-8?B?T1FrUGxRN1ZaZVNVSlU5Q00yZ09zaWZ4bzNpVW40N004OXBCbFRVRDl4Zkli?=
 =?utf-8?B?c2dkSytWRTVGVmhwb0IrNVBBYWJTK3FUaDFvRm9rNXJvKzE0NGhOL0FQR3Zi?=
 =?utf-8?B?eWkwL1VCOW9tbzB6ckRUdXU2RHh3QjRlaENVbnhaQzZReW1GWE56dmtoVm53?=
 =?utf-8?B?eUVZUUFrTEZ1djFlNjdPWXFSTzA0Rk5UWVJMbFFFa2NKSVFrQUZmSmJXQ1k1?=
 =?utf-8?B?YWJFektrT1hYUlY4UDZjV3NxdmhobkRjVk5sMnhFSHY1anNrWVFLUXkrTllO?=
 =?utf-8?B?L0YvL2dnT2JYTmRIY203WTRWZzNVaXNxQ0svamtsMjFlSDZRWVAvemNXRzVt?=
 =?utf-8?B?eDRMOG9rcnRaKzA1d2ZiVTNVa0tKSVJEMFdNOHBvWVdxRkdWZldZZ2FhTVI2?=
 =?utf-8?B?TGNaa0ZxTGt5dHI1aENxbW5QeGh2bkJYdS8xbUdta2lBcElYdHVFK2tXSmdU?=
 =?utf-8?B?M0NickdiWFJYRWZubFduZ2FjSXpHYWFKeUM3bFJuekg2ZUlpREV6Nno2cUIr?=
 =?utf-8?B?aG01NHdQTnUwMUxiOWVzbzhERUVTL1lBdWMycDBzV20zblBZVHZsUkJhaDNF?=
 =?utf-8?B?MjZSMEZOUlNPNEh1RExuLzRENHZyWGg5RzQ4eko4Nm4vdUhjNkJybDRYL2pP?=
 =?utf-8?B?MXR4SnY1MERmeTZBaE42ekh5VDhsUHkvTnVmWit1dUU1RjJrQzZxeXNsci9r?=
 =?utf-8?B?VFNud2EyUklaT05zb1JxY2hPNXpzVDFFclhMNE85V1o5R3h0NzlrTmRFaFBQ?=
 =?utf-8?B?NEV0aWpVQzFiOXl0Q3hlMWU3TGFGUWtxdFEyN1YzWGFDdXVlbGV2L3B1a2hR?=
 =?utf-8?B?U050cGZncy9rTTRjdmVUbUhMKzdBeGlUaXpSTWxOdEI2NUEwZk5GVnRjM25t?=
 =?utf-8?B?bGtvcnlCWTUzRFpSTDNrbHd5WUhVazVVeExJTUhkZ0hZYXVnclhpUGdiMWtu?=
 =?utf-8?B?anpQakRRYmlEb1E2UHpOTU94Ukg0UXloeVp6SlBSaVhFYWhLNWhUVStLMHN5?=
 =?utf-8?B?N05PN0Y5RnNmR1pYMHNIckpXZVZRRkswZWZ0dGlBdmJrSkgvaENZUE5tR3Ro?=
 =?utf-8?B?WWVSTkx2aDdZdkNoREFRbXpVcXdoSkJtZ3Z4Q24veDlLOEgvRGxkaWVTZlBn?=
 =?utf-8?B?VnlIYlJXeTUyNTVFU0lueVoyQmM1MGE1SVNFVWFDNkdxVFJGWDdQeDNpbllY?=
 =?utf-8?B?V0ZJR25FbGxCKytFRzA3UHZhSE9NaEhzU3ZrYXF6b1BkOHlXcmN2ZTJFNUs4?=
 =?utf-8?B?ZnJMMytpVWRMVXh2ZklTMEtjSmswVUlEV0I4Q1ZJbUc4aERCSU1BN01YRFJG?=
 =?utf-8?B?cnBZY0twT3E3RVZPc0tvVlJHcXRFS2owWmVYTUtXQlVZb2tBQ2ZVSWpRWUZM?=
 =?utf-8?B?TTRMZm5hOWVBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1I5TzNqaEJsS1lKQzdiZkRKTHk1NWJsWVN5c1NCSXNuMzIvUmFzNGNBUFN0?=
 =?utf-8?B?cUs5OVpvR2pqZjZhQnhSUlNJcnhiWDVDbU5QWkRKV05vOVp3VHhyVGVDSkg1?=
 =?utf-8?B?eXk2Qit4K0VWN1VoclZpUnpEbTZsUU1FVkhnZUVTNnNxM1pvMWlpQzFWNTF6?=
 =?utf-8?B?bnIwWE5tYnJxWU9CWlppd1VwK1BGU24rYjRVODNQQnRycVJFanlYMG81ZXRx?=
 =?utf-8?B?aXJ5c3ZiRmt4MTJaUHRKMHArUlBLb3llRTFJeUdCK3VHMDcyZWxENFBsaU9z?=
 =?utf-8?B?MHh2b3NYS0dHK2M1dGRSN0tBUU1EVXNRcjR2c3lWQVVHcTBLSXB3Z1ZCbW4z?=
 =?utf-8?B?Y1BQc3BDWXN4bEk5MzNMbXBJb280TC9HTzRmVDMwVFdHb3Y3UU1ydVo2YUN4?=
 =?utf-8?B?NWt3VHI1RkFhOGdzTHBITUNQUlBtcklDaFU5RFNZS3NnUi9JSi84UGdZMENq?=
 =?utf-8?B?TG9FV0I2ZmRrK3dEekc1VHdzamZaWTdUUzcxTE1oMXJXQUUzakFqdXZQSWcz?=
 =?utf-8?B?aHg4NEZzbmJET0YrVUZ4cjZtdkUyKzZsWVVXVjBUTjcyZnhWNmV3anNmNzFx?=
 =?utf-8?B?ZFFQM1MyYWd4WXp5clVVb1ZPMFNETVhkek56SnRoaHJycnZ5L2wxUXc3Y1ZK?=
 =?utf-8?B?aVYzWkc5MnhJZTd1S1lIcXUxYmZRT216cGpUUnJjVXRqcmNpL245SDZpa2hK?=
 =?utf-8?B?cjhuY1pKbU1NNWNSeWR6VHFjd1lPTFV2RGNNSDg4NDRYT0hwV1h6VFR3d3l0?=
 =?utf-8?B?a3QxT3JvN0xFaVc1Q25OOXhqWGxrcGNucVcraVhSU1B3TW92T0ZiNXI2T3pD?=
 =?utf-8?B?c0ZNSUtMaTVSL3Y1MkVFcEQ3dTBBV2p4enVUSmxVZWRHSFhEL25xeCtWcGFr?=
 =?utf-8?B?dXNDWmUyQUVrK3lSY1JlTTF0ZmhnMjVnNEo0aWYyS2laYUIwaGpqR3NvZGhH?=
 =?utf-8?B?TFp6bkNGZmJYSGxYa2FNbmc2MnY2dHpuYXh2NCt6RnRQbGlvbFhwY3JGOVM4?=
 =?utf-8?B?VFR5dkhrUDBMQVBlWExnc0hCa1BVcDZRMko4NXo4ZFk5WVJ5RU9GMkZ2OFl5?=
 =?utf-8?B?OFhBRE1BOGQ3ZmZGQUVnWGYxa25KckVkQzNUcDZvNkMyWmx5c0JETFFCUThJ?=
 =?utf-8?B?a05NNVlQVnN1Y2hmcmQyMFVocjhGWGJzMlRFUEV4MVdtTXQ3NTJoK1hUcWRj?=
 =?utf-8?B?aU9DVHpoaWRXNW10WERuT1lIK3hzUXFYbkRCYk9udXhLNVlycTQ0TTVnOXV3?=
 =?utf-8?B?eFJNbEhTaWg4UmNPRFpBdnVzUDZBVkZxNDJBc09SRFZEVkFGRnRhNEpELzJB?=
 =?utf-8?B?ZHBwaVlUQTB2L3BzSEVRTlRGdlNtMW5ReTlHOGlJOHZtc3F0OHFDS2wxeTN2?=
 =?utf-8?B?YmZEMUtic1dCUldYQWRVakFsR0dFaFFTN3RUamkxTFd2Mjdsd3FXcE9acGlk?=
 =?utf-8?B?VGJvcUlRTUNWOUN3RFFYOHgzc0hEK0hCMTFRNUFOdzk1V0RnS093emhaY2ZD?=
 =?utf-8?B?WWhmUTl6UDRyc1JLSmpGT0FJSTJiOUVCd3BTZkdGejhzb0tQYjNSUGhlYTUr?=
 =?utf-8?B?VFFoTHA0Sk43WTVsbkxhSmIvSXlrVVVpQk96UHl2NU9FMUNPd2E4YVVjY3hD?=
 =?utf-8?B?WVVWazU0SDJBMUJyWVF6di9rVnd2UkdkQUQrY205SWNndkxHVWFYTkNDQjdM?=
 =?utf-8?B?aVJDelU0V1NSTThjZTFLbUNOOEVtUjJnV3M0Wmc3aHh4aE1NR0FMZlNpQkdX?=
 =?utf-8?B?VXQwNG9wQTNNLy9YTE9QUGtMTm9wU1RyYVF5YlhtdXJSWmh2ZC9nNGpNb09H?=
 =?utf-8?B?cWhJbFN6SkR0cmdVdWxmZWRPdDdwdCtSMHFicURJZldLemVwdFkzWUJCT3FK?=
 =?utf-8?B?Lzg2K0UrUG1JZ0dIMTdwU1ZwbWEwdytHM0I4eDdLcC9GZW5FKzg3N0IrTnJx?=
 =?utf-8?B?K3pta0xaamRrNGpiRkthelAwODZqbGZkMlZUMHVZQWNJWm9zVkRSUk8xT2py?=
 =?utf-8?B?a1k0aUtQekt5dFpxZTZ1VGRUNmdod3RxTklvTUc3UDN0VWJxd0xvc0VpdkpV?=
 =?utf-8?B?UDh0YTVveGVuWjJsbDhzTHV0TStaTk4wU2ovKzNacWtrbDJua01SWndaYUlV?=
 =?utf-8?B?NWpISEpFc3FWSFN2MERaNmp6dy81bEd5Y2ZJQ0VmVWFsUkwvQVRvMU1VVUo5?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20040210287A374B83899F0A3C40F8D7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af66dcde-3ec2-4255-d5eb-08ddf4386300
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 09:15:17.2522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3SGnrv439nYsZSG2fp71HnbzRE1R/fdX/2m6HyxbjrxRbpVyoGhJ+C3Y4QFk/s16iKkiYev3b5kSCvXo8f44qJNo+PLWSAsFi7Bg71poUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8747

T24gVHVlLCAyMDI1LTA4LTEyIGF0IDEzOjUyICswMjAwLCBQaGlsaXBwIFphYmVsIHdyb3RlOg0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiANCj4gDQo+IE9uIE1pLCAyMDI1LTA4LTA2IGF0IDE2OjU5ICswODAwLCBGcmlkYXkg
WWFuZyB3cm90ZToNCj4gPiBUbyBwcmV2ZW50IGhhbmRsaW5nIGdsaXRjaCBzaWduYWxzIGR1cmlu
ZyBNVENNT1Mgb24vb2ZmDQo+ID4gdHJhbnNpdGlvbnMsDQo+ID4gU01JIHJlcXVpcmVzIGNsYW1w
IGFuZCByZXNldCBvcGVyYXRpb25zLiBQYXJzZSB0aGUgcmVzZXQgc2V0dGluZ3MNCj4gPiBmb3IN
Cj4gPiBTTUkgTEFSQnMgYW5kIHRoZSBjbGFtcCBzZXR0aW5ncyBmb3IgdGhlIFNNSSBTdWItQ29t
bW9uLiBSZWdpc3Rlcg0KPiA+IGdlbnBkIGNhbGxiYWNrIGZvciB0aGUgU01JIExBUkJzIGxvY2F0
ZWQgaW4gaW1hZ2UsIGNhbWVyYSBhbmQgSVBFDQo+ID4gc3Vic3lzdGVtcywgYW5kIGFwcGx5IHJl
c2V0IGFuZCBjbGFtcCBvcGVyYXRpb25zIHdpdGhpbiB0aGUNCj4gPiBjYWxsYmFjay4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBGcmlkYXkgWWFuZyA8ZnJpZGF5LnlhbmdAbWVkaWF0ZWsuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21lbW9yeS9tdGstc21pLmMgfCAxMjkNCj4gPiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEyOSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVtb3J5
L210ay1zbWkuYyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KPiA+IGluZGV4IDczM2UyMmY2
OTVhYi4uYWNjODkwNGRkMTE3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVtb3J5L210ay1z
bWkuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KPiA+IEBAIC0xMCwxMSAr
MTAsMTUgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvaW8uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KPiA+ICsjaW5jbHVkZSA8
bGludXgvbWZkL3N5c2Nvbi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4g
ICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0u
aD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ICsjaW5jbHVk
ZSA8bGludXgvcG1fZG9tYWluLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3Jl
c2V0Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrX3NpcF9zdmMuaD4N
Cj4gPiAgI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCj4gPiAgI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL21lbW9yeS9tdDI3MDEtbGFyYi1wb3J0Lmg+DQo+ID4gQEAgLTM0LDYgKzM4LDggQEAN
Cj4gPiAgI2RlZmluZSBTTUlfRklGT19USDEgICAgICAgICAgICAgICAgIDB4MjM4DQo+ID4gICNk
ZWZpbmUgU01JX0ZJRk9fVEgyICAgICAgICAgICAgICAgICAweDIzYw0KPiA+ICAjZGVmaW5lIFNN
SV9EQ00gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDMwMA0KPiA+ICsjZGVmaW5lIFNN
SV9DT01NT05fQ0xBTVBfRU5fU0VUICAgICAgICAgICAgICAweDNjNA0KPiA+ICsjZGVmaW5lIFNN
SV9DT01NT05fQ0xBTVBfRU5fQ0xSICAgICAgICAgICAgICAweDNjOA0KPiA+ICAjZGVmaW5lIFNN
SV9EVU1NWSAgICAgICAgICAgICAgICAgICAgMHg0NDQNCj4gPiANCj4gPiAgLyogU01JIExBUkIg
Ki8NCj4gPiBAQCAtMTM0LDYgKzE0MCw3IEBAIHN0cnVjdCBtdGtfc21pX2xhcmJfZ2VuIHsNCj4g
PiAgICAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgICAgICAgICAgIGxhcmJfZGlyZWN0X3RvX2Nv
bW1vbl9tYXNrOw0KPiA+ICAgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgICAgICAgICAgZmxh
Z3NfZ2VuZXJhbDsNCj4gPiAgICAgICBjb25zdA0KPiA+IHU4ICAgICAgICAgICAgICAgICAgICAg
ICAgKCpvc3RkKVtTTUlfTEFSQl9QT1JUX05SX01BWF07DQo+ID4gKyAgICAgY29uc3QgdTggICAg
ICAgICAgICAgICAgICAgICAgICAqY2xhbXBfcG9ydDsNCj4gPiAgfTsNCj4gPiANCj4gPiAgc3Ry
dWN0IG10a19zbWkgew0KPiA+IEBAIC0xNTAsNiArMTU3LDcgQEAgc3RydWN0IG10a19zbWkgew0K
PiA+ICB9Ow0KPiA+IA0KPiA+ICBzdHJ1Y3QgbXRrX3NtaV9sYXJiIHsgLyogbGFyYjogbG9jYWwg
YXJiaXRlciAqLw0KPiA+ICsgICAgIHN0cnVjdCBkZXZpY2UgICAgICAgICAgICAgICAgICAgKmRl
djsNCj4gPiAgICAgICBzdHJ1Y3QgbXRrX3NtaSAgICAgICAgICAgICAgICAgIHNtaTsNCj4gPiAg
ICAgICB2b2lkIF9faW9tZW0gICAgICAgICAgICAgICAgICAgICpiYXNlOw0KPiA+ICAgICAgIHN0
cnVjdCBkZXZpY2UgICAgICAgICAgICAgICAgICAgKnNtaV9jb21tb25fZGV2OyAvKiBjb21tb24g
b3INCj4gPiBzdWItY29tbW9uIGRldiAqLw0KPiA+IEBAIC0xNTcsNiArMTY1LDEwIEBAIHN0cnVj
dCBtdGtfc21pX2xhcmIgeyAvKiBsYXJiOiBsb2NhbCBhcmJpdGVyDQo+ID4gKi8NCj4gPiAgICAg
ICBpbnQgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxhcmJpZDsNCj4gPiAgICAgICB1MzIg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICptbXU7DQo+ID4gICAgICAgdW5zaWduZWQgY2hh
ciAgICAgICAgICAgICAgICAgICAqYmFuazsNCj4gPiArICAgICBzdHJ1Y3QgcmVnbWFwICAgICAg
ICAgICAgICAgICAgICpzbWlfY29tbV9zeXNjb247IC8qIHNtaS1jb21tIA0KPiA+IG9yIHN1Yi1j
b21tICovDQo+ID4gKyAgICAgdTggICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzbWlfY29t
bV9pbl9wb3J0X2lkOyAvKiBzbWktDQo+ID4gY29tbSBvciBzdWItY29tbSAqLw0KPiA+ICsgICAg
IHN0cnVjdCBub3RpZmllcl9ibG9jayAgICAgICAgICAgbmI7DQo+ID4gKyAgICAgc3RydWN0IHJl
c2V0X2NvbnRyb2wgICAgICAgICAgICAqcnN0X2NvbjsNCj4gPiAgfTsNCj4gPiANCj4gPiAgc3Rh
dGljIGludA0KPiA+IEBAIC00NzgsNiArNDkwLDE5IEBAIHN0YXRpYyBjb25zdCB1OA0KPiA+IG10
a19zbWlfbGFyYl9tdDgxOTVfb3N0ZFtdW1NNSV9MQVJCX1BPUlRfTlJfTUFYXSA9IHsNCj4gPiAg
ICAgICBbMjhdID0gezB4MWEsIDB4MGUsIDB4MGEsIDB4MGEsIDB4MGMsIDB4MGUsIDB4MTAsfSwN
Cj4gPiAgfTsNCj4gPiANCj4gPiArc3RhdGljIGNvbnN0IHU4IG10a19zbWlfbGFyYl9jbGFtcF9w
b3J0X210ODE4OFtNVEtfTEFSQl9OUl9NQVhdID0NCj4gPiB7DQo+ID4gKyAgICAgWzldICAgICA9
IEJJVCgxKSwgLyogbGFyYjEwICovDQo+ID4gKyAgICAgWzEwXSAgICA9IEJJVCgyKSwgLyogbGFy
YjExYSAqLw0KPiA+ICsgICAgIFsxMV0gICAgPSBCSVQoMiksIC8qIGxhcmIxMWIgKi8NCj4gPiAr
ICAgICBbMTJdICAgID0gQklUKDMpLCAvKiBsYXJiMTFjICovDQo+ID4gKyAgICAgWzEzXSAgICA9
IEJJVCgwKSwgLyogbGFyYjEyICovDQo+ID4gKyAgICAgWzE2XSAgICA9IEJJVCgxKSwgLyogbGFy
YjE1ICovDQo+ID4gKyAgICAgWzE3XSAgICA9IEJJVCgyKSwgLyogbGFyYjE2YSAqLw0KPiA+ICsg
ICAgIFsxOF0gICAgPSBCSVQoMiksIC8qIGxhcmIxNmIgKi8NCj4gPiArICAgICBbMTldICAgID0g
QklUKDMpLCAvKiBsYXJiMTdhICovDQo+ID4gKyAgICAgWzIwXSAgICA9IEJJVCgzKSwgLyogbGFy
YjE3YiAqLw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfc21p
X2xhcmJfZ2VuIG10a19zbWlfbGFyYl9tdDI3MDEgPSB7DQo+ID4gICAgICAgLnBvcnRfaW5fbGFy
YiA9IHsNCj4gPiAgICAgICAgICAgICAgIExBUkIwX1BPUlRfT0ZGU0VULCBMQVJCMV9QT1JUX09G
RlNFVCwNCj4gPiBAQCAtNTMxLDYgKzU1Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3Nt
aV9sYXJiX2dlbg0KPiA+IG10a19zbWlfbGFyYl9tdDgxODggPSB7DQo+ID4gICAgICAgLmZsYWdz
X2dlbmVyYWwgICAgICAgICAgICAgID0gTVRLX1NNSV9GTEFHX1RIUlRfVVBEQVRFIHwNCj4gPiBN
VEtfU01JX0ZMQUdfU1dfRkxBRyB8DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgTVRLX1NNSV9GTEFHX1NMRUVQX0NUTCB8DQo+ID4gTVRLX1NNSV9GTEFHX0NGR19QT1JU
X1NFQ19DVEwsDQo+ID4gICAgICAgLm9zdGQgICAgICAgICAgICAgICAgICAgICAgID0gbXRrX3Nt
aV9sYXJiX210ODE4OF9vc3RkLA0KPiA+ICsgICAgIC5jbGFtcF9wb3J0ICAgICAgICAgICAgICAg
ICA9IG10a19zbWlfbGFyYl9jbGFtcF9wb3J0X210ODE4OCwNCj4gPiAgfTsNCj4gPiANCj4gPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfc21pX2xhcmJfZ2VuIG10a19zbWlfbGFyYl9tdDgxOTIg
PSB7DQo+ID4gQEAgLTU4Miw2ICs2MDgsNDUgQEAgc3RhdGljIHZvaWQNCj4gPiBtdGtfc21pX2xh
cmJfc2xlZXBfY3RybF9kaXNhYmxlKHN0cnVjdCBtdGtfc21pX2xhcmIgKmxhcmIpDQo+ID4gICAg
ICAgd3JpdGVsX3JlbGF4ZWQoMCwgbGFyYi0+YmFzZSArIFNNSV9MQVJCX1NMUF9DT04pOw0KPiA+
ICB9DQo+ID4gDQo+ID4gK3N0YXRpYyBpbnQgbXRrX3NtaV9sYXJiX2NsYW1wX3Byb3RlY3RfZW5h
YmxlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiBib29sIGVuYWJsZSkNCj4gPiArew0KPiA+ICsg
ICAgIHN0cnVjdCBtdGtfc21pX2xhcmIgKmxhcmIgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4g
PiArICAgICB1MzIgcmVnOw0KPiA+ICsgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgIC8q
IHNtaV9jb21tX3N5c2NvbiBtYXkgYmUgTlVMTCBpZiB0aGUgc3Vic3lzIGRvZXNuJ3QgaGF2ZSBi
dXMNCj4gPiBnbGl0Y2ggaXNzdWVzICovDQo+ID4gKyAgICAgaWYgKCFsYXJiLT5zbWlfY29tbV9z
eXNjb24pDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKyAg
ICAgcmVnID0gZW5hYmxlID8gU01JX0NPTU1PTl9DTEFNUF9FTl9TRVQgOg0KPiA+IFNNSV9DT01N
T05fQ0xBTVBfRU5fQ0xSOw0KPiA+ICsNCj4gPiArICAgICByZXQgPSByZWdtYXBfd3JpdGUobGFy
Yi0+c21pX2NvbW1fc3lzY29uLCByZWcsIGxhcmItDQo+ID4gPnNtaV9jb21tX2luX3BvcnRfaWQp
Ow0KPiA+ICsgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIlVu
YWJsZSB0byAlcyBjbGFtcCBmb3IgaW5wdXQgcG9ydCAlZDoNCj4gPiAlZFxuIiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgZW5hYmxlID8gImVuYWJsZSIgOiAiZGlzYWJsZSIsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIGxhcmItPnNtaV9jb21tX2luX3BvcnRfaWQsIHJldCk7DQo+ID4g
Kw0KPiA+ICsgICAgIHJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQg
bXRrX3NtaV9nZW5wZF9jYWxsYmFjayhzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBmbGFncywgdm9pZCAq
ZGF0YSkNCj4gPiArew0KPiA+ICsgICAgIHN0cnVjdCBtdGtfc21pX2xhcmIgKmxhcmIgPSBjb250
YWluZXJfb2YobmIsIHN0cnVjdA0KPiA+IG10a19zbWlfbGFyYiwgbmIpOw0KPiA+ICsgICAgIHN0
cnVjdCBkZXZpY2UgKmRldiA9IGxhcmItPmRldjsNCj4gPiArDQo+ID4gKyAgICAgaWYgKGZsYWdz
ID09IEdFTlBEX05PVElGWV9QUkVfT04gfHwgZmxhZ3MgPT0NCj4gPiBHRU5QRF9OT1RJRllfUFJF
X09GRikgew0KPiA+ICsgICAgICAgICAgICAgLyogZGlzYWJsZSByZWxhdGVkIFNNSSBzdWItY29t
bW9uIHBvcnQgKi8NCj4gPiArICAgICAgICAgICAgIG10a19zbWlfbGFyYl9jbGFtcF9wcm90ZWN0
X2VuYWJsZShkZXYsIHRydWUpOw0KPiA+ICsgICAgIH0gZWxzZSBpZiAoZmxhZ3MgPT0gR0VOUERf
Tk9USUZZX09OKSB7DQo+ID4gKyAgICAgICAgICAgICAvKiBlbmFibGUgcmVsYXRlZCBTTUkgc3Vi
LWNvbW1vbiBwb3J0ICovDQo+ID4gKyAgICAgICAgICAgICByZXNldF9jb250cm9sX3Jlc2V0KGxh
cmItPnJzdF9jb24pOw0KPiA+ICsgICAgICAgICAgICAgbXRrX3NtaV9sYXJiX2NsYW1wX3Byb3Rl
Y3RfZW5hYmxlKGRldiwgZmFsc2UpOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgcmV0
dXJuIE5PVElGWV9PSzsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBtdGtfc21pX2Rl
dmljZV9saW5rX2NvbW1vbihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdA0KPiA+IGRldmljZSAq
KmNvbV9kZXYpDQo+ID4gIHsNCj4gPiAgICAgICBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpzbWlf
Y29tX3BkZXY7DQo+ID4gQEAgLTYzOCw2ICs3MDMsNTEgQEAgc3RhdGljIGludCBtdGtfc21pX2R0
c19jbGtfaW5pdChzdHJ1Y3QgZGV2aWNlDQo+ID4gKmRldiwgc3RydWN0IG10a19zbWkgKnNtaSwN
Cj4gPiAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gDQo+ID4gK3N0YXRpYyBpbnQgbXRr
X3NtaV9sYXJiX3BhcnNlX2NsYW1wX29wdGlvbmFsKHN0cnVjdCBtdGtfc21pX2xhcmINCj4gPiAq
bGFyYikNCj4gPiArew0KPiA+ICsgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IGxhcmItPmRldjsN
Cj4gPiArICAgICBjb25zdCBzdHJ1Y3QgbXRrX3NtaV9sYXJiX2dlbiAqbGFyYl9nZW4gPSBsYXJi
LT5sYXJiX2dlbjsNCj4gPiArICAgICB1MzIgbGFyYl9pZDsNCj4gPiArICAgICBpbnQgcmV0Ow0K
PiA+ICsNCj4gPiArICAgICAvKg0KPiA+ICsgICAgICAqIE9ubHkgU01JIExBUkJzIGluIGNhbWVy
YSwgaW1hZ2UgYW5kIElQRSBzdWJzeXMgbmVlZCB0bw0KPiA+ICsgICAgICAqIGFwcGx5IGNsYW1w
IGFuZCByZXNldCBvcGVyYXRpb25zLCBvdGhlcnMgY2FuIGJlIHNraXBwZWQuDQo+ID4gKyAgICAg
ICovDQo+ID4gKyAgICAgcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzIoZGV2LT5vZl9ub2RlLCAi
bWVkaWF0ZWssbGFyYi1pZCIsDQo+ID4gJmxhcmJfaWQpOw0KPiA+ICsgICAgIGlmIChyZXQgfHwg
IWxhcmJfZ2VuLT5jbGFtcF9wb3J0IHx8ICFsYXJiX2dlbi0NCj4gPiA+Y2xhbXBfcG9ydFtsYXJi
X2lkXSkNCj4gPiArICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsNCj4gPiArICAgICBsYXJi
LT5zbWlfY29tbV9pbl9wb3J0X2lkID0gbGFyYl9nZW4tPmNsYW1wX3BvcnRbbGFyYl9pZF07DQo+
ID4gKyAgICAgbGFyYi0+c21pX2NvbW1fc3lzY29uID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlf
cGhhbmRsZShkZXYtDQo+ID4gPm9mX25vZGUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAibWVkaQ0KPiA+IGF0ZWssc21p
Iik7DQo+ID4gKyAgICAgaWYgKElTX0VSUihsYXJiLT5zbWlfY29tbV9zeXNjb24pKSB7DQo+ID4g
KyAgICAgICAgICAgICBsYXJiLT5zbWlfY29tbV9zeXNjb24gPSBOVUxMOw0KPiA+ICsgICAgICAg
ICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCAtRUlOVkFMLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIlVua25vd24gY2xhbXAgcG9ydCBmb3IgbGFyYg0KPiA+
ICVkXG4iLCBsYXJiX2lkKTsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiAw
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wYXJzZV9yZXNl
dF9vcHRpb25hbChzdHJ1Y3QgbXRrX3NtaV9sYXJiDQo+ID4gKmxhcmIpDQo+ID4gK3sNCj4gPiAr
ICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBsYXJiLT5kZXY7DQo+ID4gKyAgICAgaW50IHJldDsN
Cj4gPiArDQo+ID4gKyAgICAgbGFyYi0+cnN0X2NvbiA9DQo+ID4gZGV2bV9yZXNldF9jb250cm9s
X2dldF9vcHRpb25hbF9leGNsdXNpdmUoZGV2LCAibGFyYiIpOw0KPiA+ICsgICAgIGlmICghbGFy
Yi0+cnN0X2NvbikNCj4gPiArICAgICAgICAgICAgIHJldHVybiAwOw0KPiANCj4gUGxlYXNlIGRv
bid0IGlnbm9yZSBlcnJvcnMuDQo+IA0KPiByZWdhcmRzDQo+IFBoaWxpcHANCg0KVGhhbmtzIGZv
ciBjb21tZW50cy4NCkFzIGRlc2NyaWJlZCBiZWZvcmUsIHdlIG5lZWQgdG8gcmV0dXJuIHRoZSBl
cnJvciBpbg0KJ210a19zbWlfbGFyYl9wYXJzZV9yZXNldCcgd2hlbiBpdCBmYWlscyB0byBnZXQg
cmVzZXQgY29udHJvbGxlciwNCmJlY2F1c2UgaXQgaXMgbm90IG9wdGlvbmFsIG5vdy4gV2hhdCdz
IG1vcmUsDQonZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNsdXNpdmUnIHNob3Vs
ZCBiZSByZXBsYWNlZCB3aXRoDQonZGV2bV9yZXNldF9jb250cm9sX2dldF9leGNsdXNpdmUnIGlu
IHRoaXMgY2FzZS4NCg==

