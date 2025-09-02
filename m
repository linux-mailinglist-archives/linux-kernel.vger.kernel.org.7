Return-Path: <linux-kernel+bounces-795432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE20B3F1F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB0D202708
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 01:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C0A2E03F5;
	Tue,  2 Sep 2025 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BkvtiDFF";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZQorFSy2"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD126E17D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756777378; cv=fail; b=pgi63Xvr5amIWls78jz+eV113nZ013necRMz8O+4hVFvow9Z1dKOAY+b50lTtSjjAx9kn/uZ5fxTRWdChyiEn92sBeTPJC13OYYlI4YkGpkb56ydpB6SYJBIST0fazuNUFb1lVIEStJbiuIOxC+d/Bkcaq7fLhvEEKx+UmrNdCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756777378; c=relaxed/simple;
	bh=75hacSY3z7pYiu2JuJDWy3DupipC9zwELwhYZoNpwT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XGGx3zCNMs3zNcIy8wIgCEOPruQNLom2MHx/dw8hoTL3FHUtTQSMJWTa7RjPAgz+Vxfea+F97RdMc3VfObODCYxMjD1gXjoiJ64m7vQwC+hsvbanqVUI5BwboALjWNF5TuZzU4Rp3YZxUWb2J60PpL3SBsTD8fS6rM5S7pykZGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BkvtiDFF; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ZQorFSy2; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 226dd4d8879e11f0b33aeb1e7f16c2b6-20250902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=75hacSY3z7pYiu2JuJDWy3DupipC9zwELwhYZoNpwT4=;
	b=BkvtiDFFAH8BQV8TufhbMfLwAaGPYqUYR8SdEp3C+q/Nx4tqzkyMSBVeBI0oXmKNwIJaMtTXCn/wjbar2K0D7PEXoodlPQNZg5Z9V3GNd2tJRWoDQ0/gOnMusNO2WONM3weB/YEQdsRgWKST4qeYCKjpbDeeGaL3yF+nUse+wVk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:76d465e3-d485-4693-ab9f-b8e7102d5fb8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:c1ee176c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 226dd4d8879e11f0b33aeb1e7f16c2b6-20250902
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <xion.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 62875611; Tue, 02 Sep 2025 09:42:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 2 Sep 2025 09:42:48 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 2 Sep 2025 09:42:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLVmdCgDlJ61FxcmZ8sY7ggE5jBCmT6OTwcQRFlgwwbNa3HkvDXDSFY9pdhSLEyiuMa15g7Y6h3KlZQeLOZ+cLB2KK7287MMu4+thAd/vRRyPUZKjn2AelphDqi1eRKB5IVLA/+HHCZfJWy58gfficM4b0OPh3diyeSDX7KPIuEPuWRxfF8Y9QRTPq3B+RzOIeaidBJW0hwl+8xXUPl0OZmPn8qM0Yu/EePTqQH3m8rw6Q8oYPk2B4jEX1cztKLpBXmH/U4w0B0zKoE1LRtxN3J0pvDgcBc4JIO4BXf4Pwtnj8T6HDQBCalWrVihdByHdof9xxs0CjI4Czfho9lbTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75hacSY3z7pYiu2JuJDWy3DupipC9zwELwhYZoNpwT4=;
 b=MHF9mfLFSHfpPY4nIBwRgYHvY15K2QE/aC6x2kXSnPBsTLd51cs/L3urQWZ0KggoP7PTroBW6NbTa/6sQ96I0Gf/fHFZX1DjwdfDHuWTnIE0TWGIt4ZhS4EVVGBf3Kf5mYeAKxz/+gnR9We2qYljC7kMIvVnrgyp7kVSC6aCM4Z2bCATQDUBGS/xTlbP/99omkhPii7KRzIYJlBKVYL+NeDldASVgeb6LPdBipavDHg44q2LK/owbgVrfHwPkpFxh1NegdXOneuPSkxK3iFjihXgtUoZOaJJBTKOXblDzSRHHmwijdlXymuocJsMdIY2He/fr20g2o5Vw27TR4ZVlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75hacSY3z7pYiu2JuJDWy3DupipC9zwELwhYZoNpwT4=;
 b=ZQorFSy2wJOVoleiHAISLd2koQbeURu4IJjm7777Qp8g0zx2oOsvKvpEET0aSN/it+K06ySTLL30TzxX+wiG9kn+FcAigI40GbDFf241+3Cf9eJptFsIwAaic+5xCXJC1zl69rU1Ub9A8igaWsQ0KKO+8/SxIHrk8+mVXo1INLI=
Received: from SEZPR03MB8122.apcprd03.prod.outlook.com (2603:1096:101:183::7)
 by JH0PR03MB7729.apcprd03.prod.outlook.com (2603:1096:990:12::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 01:42:45 +0000
Received: from SEZPR03MB8122.apcprd03.prod.outlook.com
 ([fe80::e130:f417:b0bb:f2b7]) by SEZPR03MB8122.apcprd03.prod.outlook.com
 ([fe80::e130:f417:b0bb:f2b7%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 01:42:45 +0000
From: =?utf-8?B?WGlvbiBXYW5nICjnjovpkasp?= <Xion.Wang@mediatek.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?SHVhZGlhbiBMaXUgKOWImOWNjuWFuCk=?= <huadian.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "arnd@arndb.de"
	<arnd@arndb.de>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/1] misc: Prevent double registration and deregistration
 of miscdevice
Thread-Topic: [PATCH 1/1] misc: Prevent double registration and deregistration
 of miscdevice
Thread-Index: AQHcFZwQOZEhJSUEf0OpnbqCU1Sn+bRz0oaAgABtc4CAAER0gIAAEBwAgAAsAICAABn3gIAAC08AgApGAYA=
Date: Tue, 2 Sep 2025 01:42:44 +0000
Message-ID: <836023cd8131e4fa63dc027a8fd6e47ec3d589ee.camel@mediatek.com>
References: <20250825084556.10358-1-xion.wang@mediatek.com>
	 <20250825084556.10358-2-xion.wang@mediatek.com>
	 <2025082533-ranked-simply-4b63@gregkh>
	 <d3d0fc0e19f939c093e6df1ff08ce23be71636a3.camel@mediatek.com>
	 <2025082638-parlor-retreat-56ff@gregkh>
	 <1ffa28bf6e3dcde83a6a6a5dde163596c4db639d.camel@mediatek.com>
	 <2025082631-hypnotist-snazzy-147a@gregkh>
	 <d3a780c367478868319064c27e0b41c69d4cc722.camel@mediatek.com>
	 <2025082646-regalia-glass-951d@gregkh>
In-Reply-To: <2025082646-regalia-glass-951d@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB8122:EE_|JH0PR03MB7729:EE_
x-ms-office365-filtering-correlation-id: 171be5fd-68fb-4b24-cdfc-08dde9c203ae
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?TjI2SmZRUFB1Q0FqOHlPc1l0VkhVbElubUx1ejgwd1NOb2YxaWljOG40ODlB?=
 =?utf-8?B?b1d4elgwVGhJWk13TXRiQm9LMmxqRnE1MjF3ZDBDUldsVjU2dHlOZXJWdDJO?=
 =?utf-8?B?SU0wRlZYRFdqcHUrZjhqOElSUUNUM1VodC9CaThpcUJ1NTRiaXFsT0tQbGhS?=
 =?utf-8?B?MHprQ1R6U1NXcXg5VUMxWkt3Z1ZsYjg2UEUrSVZSVWNKSk9KUGV4QTR3MjR5?=
 =?utf-8?B?V0tNdm1wWXAzNVFPQm1ENnBJcnVzVnA1dzJGTWJjNzNkT1pzMThhRitFNUFx?=
 =?utf-8?B?WnNLNDZ0bCtnMzNtdFk1YW9VR0lQR2ZBNVpNZG5EQmVtT1hhZjFNK2RWaXQ5?=
 =?utf-8?B?dlBaVEU0T1RXa0ZWdmRXd2FpcFNqa3lHK0o4RE9La2xwYmEwa01SLy80cFZi?=
 =?utf-8?B?RTF3Mkk2K1lFQzYxSjhPWjk0Z215Z1JETmJhV0RPMC9YRDRiUHJNZlRDY2h3?=
 =?utf-8?B?OEErd0pLOEYxdG1QVnQrVDJ6RHUyRzdKR083OXZieDg2d1ZJOWFPZUxTYlgz?=
 =?utf-8?B?WEQzWGp2d3o0Q3gyM3MrSUQ4MHlGMGtsUmJOY3o4dHZROURydkdZVmlEbGFP?=
 =?utf-8?B?SlFycEZBdG9iaVFRWWNBa0tGeHY4RmR3Szd4RXdJTHlPZWRkRkxRcndvVEhD?=
 =?utf-8?B?enFzNytQVDdnbW1kUUc2VXJsTmdLbzluVHYvWDBZUUFXRyswU1hJQXpuVmcy?=
 =?utf-8?B?elpNaG5BRGdUNnJEVEZCWFAzMGMxOThTUDQ4Mmg2bmRGenhKUEhnL2ZseEph?=
 =?utf-8?B?QkpHNHBEYloxLytoMHhJbzUwU1hLZVhiMWNmdjUyVjZaY0djYWlTTHdzNGdk?=
 =?utf-8?B?UkttanJweFZ6SzZIVGpyTU1mYVVLUEN6ZVE5Q2NydGpvTUlEeEdGd0NXYzl5?=
 =?utf-8?B?MDNpVXNUVDVNSUtoMWFrQVQ4Nkg3S3RjWk5DdnBOc21tTTQ4NVJ4Zy9ldXR2?=
 =?utf-8?B?NURVVENmdy96d0Y2RERldzVkSXhQYVEyaDQ3KzlkMWhrKzhHSWsvTmsvNWlF?=
 =?utf-8?B?SUtybFlyN2M2Z2c4MG9oYUFRcDVqSkE3Z1JDVVpieC9QY0JwaFVtWno2K0h0?=
 =?utf-8?B?S2dKVXM2L0tUTUQram5SRDc3VlFtaXUvZlVxOUNFcWhiUVByMWhLam0yYXN5?=
 =?utf-8?B?YUNWNVZMV1JZR1FRVWdkTjh3RXFnUStJSUtjdVY0RStHc2N5cTZLQnVCUE94?=
 =?utf-8?B?QWlQaVZHM2FQclkybDNFZDlCeVNoc1Ryb3JNSWw0aUtGbHMrUUFucDdma3lK?=
 =?utf-8?B?Sm5EZTc3bzJrVkhveWRKUmFHVTRQSWg5RHIxbVFVbGtIUTZrTUduN3pJQ2FF?=
 =?utf-8?B?cFdWT2o5cll0ZG5hekVBU0hQTjVQVkZOWUNmK3dxeXVyQjdNZlBiWFdxNkY3?=
 =?utf-8?B?UUlCZjlUVXQxRS9wek5XWW1mbk9nN1dieXQwWm9ISVAwNWNHdktMSlREWmIw?=
 =?utf-8?B?MWc1WDNKWTZZa1JoSFdaU2Y3eHJEZG9lS1VHMFZWNXBWZTYweTdiRkhCVnJy?=
 =?utf-8?B?NTllZGFCQnpMUkR6VmYyZWl6UWprNm9rNkxWWEhDYzNjYlJHMlZSR1ZoM2E2?=
 =?utf-8?B?cGNQM29Kc0dEOVQ0a09PdUxsMXBMYnU0OFVMNlNwVWNjMmtoZlRnNlo3VDY1?=
 =?utf-8?B?Ky92ZW91RExEZUFQMCtKUkxoVjhwWExrbk45TkxCTWRqckkzSmgzY3d1OE1R?=
 =?utf-8?B?dEl0N25YamxINmVaMFR1V3FqYUtyZ0hzZS9jc240Z1p3VCsrZmptcUwra1B5?=
 =?utf-8?B?NjMzS2N0MGFwRktDMEdzbTZjbUdFNHhFZkljTzNBTnNaNHRaSHVHdWI2Yk8w?=
 =?utf-8?B?Uk0ySzkwWStLZVZxSEtSK2dmZDhSdmlOeTFVQ1lhZk9ydGVQaFVYTWxsSUJW?=
 =?utf-8?B?Wmo0dXFRNzZxTktUVUhVY2JqZ2ZiWEJFMkt1NjBicTRUYjZFajRqbE42Tmpq?=
 =?utf-8?Q?HUng6K4lAroISEAirHP68QixI4UVtG0Q?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB8122.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTBzTnVCMG5ZL1ZXN3I4c3lSZTBzdFNvK0tlcnZjNVFoUnN6Qm82S2NJSWhp?=
 =?utf-8?B?Tk9Ta3V2cDVrVFBhVmdOU0p3bTZHbHUxQU5qdW5SOEE3djlJSHVnY3orcWd2?=
 =?utf-8?B?MlRSd3lER09aRCtxOGR1NXd3dTBaMUd2WG5sTWRCL1ZZaER2ZVJSaDJ6NWNN?=
 =?utf-8?B?SmVsUHdrN0FkUkYxZ0NzYjQ3WThZZlZnRDV1eXFPdmdPQUY0d1I2ZzEwRkFr?=
 =?utf-8?B?YW1xNnBVbm1uVWE3dzZWeHgxUVVFQU5BWmNqckpPa3dKT0g4WlhNZEdUeUhL?=
 =?utf-8?B?VGdEd0gwcEFXSnF6bnl1V05NSnFteXFrQTQ2dmRlU1BFQlZiSmNMb3p1UER2?=
 =?utf-8?B?L2VTbllBUFhGK1NsR2ZWbnd1d2xPM0o4aTZDT3BMcFcvSGVKWHdXOGZkR1VF?=
 =?utf-8?B?dHBmUFZDcThTL2lIdGhXUDk3ZGM4WFp5cmY0ekhhSktxYXdNK1VBS3dJbHlY?=
 =?utf-8?B?dXNHRWJRWXlnSGt1R0pYaDhWd1JrdGd2UWdUK3JvNy9Qa05VaEIvbGM1U3Ax?=
 =?utf-8?B?ZHlTMk9WSHJneng0YnM0Y0QxY0hsU05KR1dHVzQvSVJLQ05qZWRSb1ZZNGhZ?=
 =?utf-8?B?cGVUOUNhbXNNUWt3TFFGWkJVQkVsTTAyOWIweU9xVjJLUkZUVlEwN2JNRitZ?=
 =?utf-8?B?c1pjb1ovelgzY05qZVV0MloyZk5qL3pQbVBrcjNXeDZYWkpYZEkvczRzR3o0?=
 =?utf-8?B?VHJlb2M2MHA3NkE5ZEVPamtXT0NJUUo5cEtYTS9VNzdBY3NVR0NNL1I2Ykxv?=
 =?utf-8?B?RnYwWnFMeXVZMCtoLzdRRzNXRUVlVlFDZ2UzYmN2aHZQZG9RUGFlYUVZdjZE?=
 =?utf-8?B?WStHRTZ6Z1A0c2pmT1RIMEcrYkdqVENYODU3aVFYYVFXajBoZ085WXdIUkYx?=
 =?utf-8?B?TDhmSEJMUVY4QnFqajlXNENtODRhKzlQYTZjdk1NdTI5aUhnYldDeEJYWkM2?=
 =?utf-8?B?di8rS2VQSDhwbUFHL2s0dXJlaGpXZzRrTzdONDU2bHhXblhrS0w0QitsSHNC?=
 =?utf-8?B?WUpETERIVWdYRm45WWpMK2duZ3I2R1psYmlLSmVuZVNtMFI4SFZ6SDI0eHpC?=
 =?utf-8?B?Q1pXSXczYkZNeHIwRjhNbjUyMDBqaXNYeXFlaDhvdkdLSFQ2aE5kcGtoWTd2?=
 =?utf-8?B?TEFaMTJ0NzZRT1ZIS0xFVjdubXJpbGhQMk9tWWRFQ2xZd1phUnRmWkhTeUZW?=
 =?utf-8?B?Ui9xdm9UOTR2cG1aTy9nWU9rVEVtcFpNVXRGZW9pMGl1dGNLY1hGdFlEUzNi?=
 =?utf-8?B?ZTJHZCs3dUJHc000Q0R3anp5MUZMSWlLZFlKb3JqeEQ2Mmp5TE9OTTV5M3Fa?=
 =?utf-8?B?Q090ald4ZzRxWkxQQ0JOVG9UTm5vVUtlWWZmcTJQbU9qVlFMNmk3ZEY1dWlw?=
 =?utf-8?B?Nkd3SlVoVHRFRmJ5M2g1Wm9sd2QyZU9oZjIzWENUcGt4UkwrUVU0NVBKb2tJ?=
 =?utf-8?B?ZDJ4bENOMUUyVmUrM0RDOFViY3k4YUZEa3NCSko5SEtaUzhsYU44d2FrNm1h?=
 =?utf-8?B?dHVEa2dneUFPbEtVQUFhUHA2VVkrYnBFak9CNFJCeEpmSEFGWXNXUG9aTnds?=
 =?utf-8?B?VHlMdnRLc2lBSk1rM3UreHVMOHd5ZVRHM0N4VUVMZk9wUll4RFZ1cWI3MnZF?=
 =?utf-8?B?Vkl0VndxUzNYMTAvS1B6QVBwRml5ZmFBV3lieS9lZGtIZklQbW1KWXdYb21E?=
 =?utf-8?B?cEhFTXV6SEFOSjBaYmkzcDlBdlNOaVV0YzFsdG5RUVFDMmpFcVhLV3RHZGIz?=
 =?utf-8?B?aVpEWEIrVDZpWHlSZzdkTjBBcEw4bXQ4dzlzRTFtV3RmeXowUlFlRlRxWnZS?=
 =?utf-8?B?SzRLMExoYVNnYWtZSlVYYmJQekxzV0ZsSkJxS0NWTnhXYTAxS3JHQnZHUVcy?=
 =?utf-8?B?SlJkQXNRT2cwM3dDdXVOZys4bjcvRHpRbUo2S25GUWs4d3pCME5UcnZxbUs2?=
 =?utf-8?B?ZlJlbU0vTVByMFFEaVJKa1VKbDZURnJ2Skl2cUR2UVdTN3N1SnR1QUZncFQ1?=
 =?utf-8?B?Zml6UkdjU0pKWUVFZW9QSG1GNXN4eDgzL1EwSk5GMjk0ajR1QTFtMUREMjZF?=
 =?utf-8?B?bk14djZ1NGF4ZzU4WnZ5MlhpSk55eW5DTjl1dmppNnVXTFBVV0FyVmtPdFoy?=
 =?utf-8?B?VDd6bUFPOS9pbWpvTDltTFlHWlM5VS80TjN5UVdnSjE3aVpCN21KQjJTRzZV?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <229E42D37DD51C4485556503DECE0A23@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB8122.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171be5fd-68fb-4b24-cdfc-08dde9c203ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 01:42:45.0984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pIUWtc1FoNBD5ENnt8lPjYSlMy8MhIUW2QfbYX8ub+m8b0Gz3wKDm1KU5ffgJnndD4sNBFjN+ZftRCvSNHlNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7729

T24gVHVlLCAyMDI1LTA4LTI2IGF0IDE0OjU0ICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBPbiBUdWUsIEF1ZyAyNiwgMjAyNSBhdCAxMjow
OTowMVBNICswMDAwLCBYaW9uIFdhbmcgKOeOi+mRqykgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDI1
LTA4LTI2IGF0IDEyOjQwICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZw0KPiA+IHdy
b3RlOg0KPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMNCj4gPiA+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IE9uIFR1ZSwg
QXVnIDI2LCAyMDI1IGF0IDA3OjU4OjQ3QU0gKzAwMDAsIFhpb24gV2FuZyAo546L6ZGrKSB3cm90
ZToNCj4gPiA+ID4gPiBBZ2FpbiwgdGhpcyBzaG91bGRuJ3QgYmUgc29tZXRoaW5nIHRoYXQgYW55
IGRyaXZlciBzaG91bGQgaGl0DQo+ID4gPiA+ID4gYXMNCj4gPiA+ID4gPiB0aGlzDQo+ID4gPiA+
ID4gdXNhZ2UgaXMgbm90IGluIHRoZSBrZXJuZWwgdHJlZSB0aGF0IEkgY2FuIHNlZS4gIEF0dGVt
cHRpbmcNCj4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+IHJlLXJlZ2lzdGVyIGEgZGV2aWNlIG11bHRp
cGxlIHRpbWVzIGlzIG5vcm1hbGx5IG5ldmVyIGEgZ29vZA0KPiA+ID4gPiA+IGlkZWEuDQo+ID4g
PiA+IA0KPiA+ID4gPiBUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMuDQo+ID4gPiA+IA0KPiA+
ID4gPiBJIGFtIG5vdCB0aGUgb3duZXIgb2YgdGhlIFdpRmkgZHJpdmVyIGFuZCBkbyBub3QgaGF2
ZSBmdWxsDQo+ID4gPiA+IGRldGFpbHMNCj4gPiA+ID4gb2YNCj4gPiA+ID4gaXRzIGludGVybmFs
IGxvZ2ljLiBIb3dldmVyLCBkdXJpbmcgaW50ZXJuYWwgaW50ZWdyYXRpb24gYW5kDQo+ID4gPiA+
IHN0cmVzcw0KPiA+ID4gPiB0ZXN0aW5nLCB3ZSBvYnNlcnZlZCBhbiBpc3N1ZSB3aGVyZSByZXBl
YXRlZCByZWdpc3RyYXRpb24gYW5kDQo+ID4gPiA+IGRlcmVnaXN0cmF0aW9uIG9mIGEgbWlzYyBk
ZXZpY2UgYnkgdGhlIFdpRmkgbW9kdWxlIGxlZCB0bw0KPiA+ID4gPiBjb3JydXB0aW9uIG9mDQo+
ID4gPiA+IHRoZSBtaXNjX2xpc3QuIFdoaWxlIEkgY2Fubm90IHByb3ZpZGUgdGhlIGV4YWN0IHJl
YXNvbmluZw0KPiA+ID4gPiBiZWhpbmQNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IFdpRmkgZHJpdmVy
J3MgZGVzaWduLCBJIHdhbnRlZCB0byByZXBvcnQgdGhlIHByb2JsZW0gYW5kIHNoYXJlDQo+ID4g
PiA+IG91cg0KPiA+ID4gPiBmaW5kaW5ncyB3aXRoIHRoZSBjb21tdW5pdHkgaW4gY2FzZSBzaW1p
bGFyIHBhdHRlcm5zIGV4aXN0DQo+ID4gPiA+IGVsc2V3aGVyZSwNCj4gPiA+ID4gaW5jbHVkaW5n
IGluIHZlbmRvciBvciBvdXQtb2YtdHJlZSBkcml2ZXJzLg0KPiA+ID4gDQo+ID4gPiBXZSBkbyBu
b3QgImhhcmRlbiIgb3VyIGludGVybmFsIGFwaXMgZm9yIGV4dGVybmFsIGRyaXZlcnMsIHdlIGZp
eA0KPiA+ID4gZHJpdmVycyB0byBub3QgZG8gZm9vbGlzaCB0aGluZ3MgOikNCj4gPiA+IA0KPiA+
ID4gUGxlYXNlIGZpeCB5b3VyIG91dC1vZi10cmVlIGNvZGUsIGl0IHNob3VsZCBub3QgYmUgZXZl
biB0b3VjaGluZw0KPiA+ID4gdGhlDQo+ID4gPiBtaXNjZGV2IGFwaSwgYXMgdGhhdCBpcyBub3Qg
c29tZXRoaW5nIGEgd2lmaSBkcml2ZXIgc2hvdWxkIGJlDQo+ID4gPiBpbnRlcmFjdGluZyB3aXRo
LiAgUGxlYXNlIHVzZSB0aGUgY29ycmVjdCBvbmUgaW5zdGVhZCwgYW5kIHRoZW4NCj4gPiA+IHlv
dQ0KPiA+ID4gd2lsbA0KPiA+ID4gbm90IGhhdmUgdGhpcyB0eXBlIG9mIGlzc3VlLg0KPiA+IA0K
PiA+IFRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4NCj4gPiANCj4gPiBJIGFncmVlIHRoYXQg
dGhlIGtlcm5lbCBzaG91bGQgbm90IGJlIGhhcmRlbmVkIGZvciBvdXQtb2YtdHJlZQ0KPiA+IGRy
aXZlcnMNCj4gPiBtaXN1c2luZyBpbnRlcm5hbCBBUElzLiBXZSB3aWxsIHVwZGF0ZSBvdXIgaW50
ZXJuYWwgY29kZSB0byBmb2xsb3cNCj4gPiBiZXN0DQo+ID4gcHJhY3RpY2VzIGFuZCBhdm9pZCBp
bXByb3BlciB1c2Ugb2YgdGhlIG1pc2NkZXZpY2UgQVBJLg0KPiA+IA0KPiA+IE9uIGEgcmVsYXRl
ZCBub3RlLCB0aGUgY3VycmVudCAnV0FSTl9PTihsaXN0X2VtcHR5KCZtaXNjLT5saXN0KSknDQo+
ID4gY2hlY2sNCj4gPiBpbiBtaXNjX2RlcmVnaXN0ZXIoKSBkb2VzIG5vdCBjYXRjaCBhbnkgcHJh
Y3RpY2FsIGVycm9yIGNvbmRpdGlvbnM6DQo+ID4gDQo+ID4gRm9yIHN0YXRpY2FsbHkgYWxsb2Nh
dGVkIG1pc2NkZXZpY2Ugc3RydWN0cywgdGhlIGxpc3QgcG9pbnRlcnMgYXJlDQo+ID4gemVyby1p
bml0aWFsaXplZCwgc28gbGlzdF9lbXB0eSgpIHdpbGwgcmV0dXJuIGZhbHNlLCBub3QgdHJ1ZS4N
Cj4gPiBBZnRlciBsaXN0X2RlbCgpLCB0aGUgcG9pbnRlcnMgYXJlIHNldCB0byBMSVNUX1BPSVNP
TjEvMiwgc28NCj4gPiByZXBlYXRlZA0KPiA+IGRlcmVnaXN0cmF0aW9uIGFsc28gZmFpbHMgdG8g
dHJpZ2dlciB0aGUgY2hlY2suDQo+ID4gDQo+ID4gU2luY2UgdGhpcyBjb25kaXRpb24gZG9lcyBu
b3QgcHJvdGVjdCBpbi10cmVlIGRyaXZlcnMgb3IgY2F0Y2ggcmVhbA0KPiA+IGVycm9ycywgd291
bGQgaXQgYmUgcmVhc29uYWJsZSB0byByZW1vdmUgaXQ/DQo+IA0KPiBZZXMsIGlmIGl0IGNhbiBu
ZXZlciBiZSBoaXQsIHdlIHNob3VsZCByZW1vdmUgaXQuDQo+IA0KPiA+IEkgY2FuIHN1Ym1pdCBh
IHBhdGNoIGlmIHRoZSBjb21tdW5pdHkgYWdyZWVzLg0KPiANCj4gVGhhdCB3b3VsZCBiZSBncmVh
dCwgdGhhbmsgeW91IQ0KPiANCg0KSGksDQoNClRoYW5rIHlvdSBmb3IgeW91ciBwcmV2aW91cyBm
ZWVkYmFjay4NCg0KQXMgc3VnZ2VzdGVkLCBJIGhhdmUgc3VibWl0dGVkIGEgbmV3IHBhdGNoIHRv
IHJlbW92ZSB0aGUgaW5lZmZlY3RpdmUNCldBUk5fT04oKSBjaGVjayBpbiBtaXNjX2RlcmVnaXN0
ZXIoKSBpbiBhIHNlcGFyYXRlIGVtYWlsIHRocmVhZDoNCg0KCQ0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8yMDI1MDgyNzAyNDIwMS4yMTQwNy0xLXhpb24ud2FuZ0BtZWRpYXRlay5jb20v
VC8jdA0KCVtQQVRDSCAxLzFdIG1pc2M6IHJlbW92ZSBpbmVmZmVjdGl2ZSBXQVJOX09OKCkgY2hl
Y2sgZnJvbQ0KbWlzY19kZXJlZ2lzdGVyKCkNCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBo
YXZlIGFueSBjb21tZW50cy4NCg0KVGhhbmtzLA0KWGlvbiBXYW5nDQo=

