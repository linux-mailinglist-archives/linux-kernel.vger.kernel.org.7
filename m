Return-Path: <linux-kernel+bounces-793949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BFDB3DACC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC97189B85C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F37234964;
	Mon,  1 Sep 2025 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kQmHitxD";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="khHkqDBl"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708DE21FF44
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756710507; cv=fail; b=WmJparAu0PPoU0lPGWsx49u6GeTmD2be0QIVqjNoYOFyvpmLxsKjQv/rRNe1f31Y1LF3mzPpvNb3slAC7Yf73js5fMWw8letnKYYZcuHWDL5tzrJps/KiE6KJ/dNV2kTjsiksvhIvA8ZpVFLvEjF1MyZ6dbmn9WagP5hhCYK3do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756710507; c=relaxed/simple;
	bh=4rfxFePPD5tz91+BZJ0LxzaL04jGllpI7xkV+WmrEdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KaoU639wsYat70fWmnrZMQc7n2l4l0kp3ymN7Z/m4qh5af+dk0evAWwybcufg2dm6j9m/7QhrH2ASBpyzaLnAQ8837yBU1LE17CCbM/OuAHuFzj7DkOEZ6Iu5on0WQnbc4mYUfRTryfRFtdpQ95Gy06X6LNL/KpaJxM3Hks1J28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kQmHitxD; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=khHkqDBl; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6fa51b9a870211f0bd5779446731db89-20250901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4rfxFePPD5tz91+BZJ0LxzaL04jGllpI7xkV+WmrEdA=;
	b=kQmHitxDb4zRsZfUu/lUMIzxqPEMLBiB8+IUA7BBawI3x76AMXWMmRY0INfvSuakKii4VnivZJj5pIOgxRto73BQRz6qE4BWdXgANMHQOnW3Ub6umzIqnhI5AicbV4MeUPyrFAqp2EkPXRvWHkB1KJQSG0I76X8huqpawJ+aIXs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:ce9135f9-12e0-41dd-8e81-75ce71c441e1,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:1734116c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6fa51b9a870211f0bd5779446731db89-20250901
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1866943286; Mon, 01 Sep 2025 15:08:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 1 Sep 2025 15:08:16 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 1 Sep 2025 15:08:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1iQep8gqX4sV/UrNEp5HW7rOEpJRF0gSRI2JomhVPHkzTSMC2V+TcrIrEuB46JRQr6iSbAlMPuuWg7hcnYJX6uqwK3mO2/s6QXW7e+xlbmiq0vbb6I9uEVsxziPOL+0xDeSrX1ODINOcJSYhnCHyud4HDsfS923R3sNTrZ/pq1XqRSTNEbYmnqJBQQAbKV9P4Za4KFvOXmwe9au8mZyxaIK7XupiTYFI2dEwVBvuCzuFNMznL8jUKBZzhFKWTO6yHEj0VXHFplE5V7cWyrNwe/GQiCGlNJwU/CGlCMJOVW6wxjbyIzWXjQqQKeTyiXoArchwyFPiMhmCnvm/d7SOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rfxFePPD5tz91+BZJ0LxzaL04jGllpI7xkV+WmrEdA=;
 b=iCzOTg4zDUzlaFAYmuCkQYIIx+Kt7g9bTp4ki4z4+d3KTENAMDSVeK+MGBo2nPOSS6Qdz99Y6oy8kSbwJqUqaf5XybzbSYdbeydlUWHLBlAk8QRK9lv4VE4GVpaPtjGF2/PvHB/NtEJdNouRAjWvHhIjKdqHXxKMxpmpKcZYWz9oOYtHuSRqyNcatAuGXPLtmRW315ZtrMWGcUfaUlPWJRmTUS851t62RDqc2bEvb6RujXfV/b77yM1hB2ckCMlzbPcwICNqLkmWzYLGIcoEH0wpdejDHQYFFXDIyTRH0Q0iMVV/QqdrkIE2ArNh5AJeOjQdFvGnEx2hF3eewQ2HEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rfxFePPD5tz91+BZJ0LxzaL04jGllpI7xkV+WmrEdA=;
 b=khHkqDBlM69RptWJlIeQTMdomB6q3XOC/CzZTKDBUR7Iu4H6ksEZFwPyvxxE4YPn0rCV5zoEBjLUaF7Ei3in3ekI1bMVLGqsOsATnPzjCMGA6shRLsV2TL0AJQzuLDiWgOhp2KbEwM8hFEoacS/L5gVFV9Mkcl/2pTw9+fOUPf0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7811.apcprd03.prod.outlook.com (2603:1096:101:18b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.24; Mon, 1 Sep
 2025 07:08:13 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 07:08:13 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "simona@ffwll.ch" <simona@ffwll.ch>, =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?=
	<Mac.Shen@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?UGVuZyBMaXUgKOWImOm5jyk=?= <Peng.Liu@mediatek.com>,
	=?utf-8?B?TElBTktVTiBZQU5HICjmnajov57lnaQp?= <Liankun.Yang@mediatek.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/1] drm/mediatek: Adjust bandwidth limit for DP
Thread-Topic: [PATCH v6 1/1] drm/mediatek: Adjust bandwidth limit for DP
Thread-Index: AQHcE10e57bvZ8z/LUSZjqlZMVme6bR996EA
Date: Mon, 1 Sep 2025 07:08:13 +0000
Message-ID: <e6337c08e2c40653b4a6542f1dd9fc350036b8c5.camel@mediatek.com>
References: <20250822120506.15486-1-liankun.yang@mediatek.com>
In-Reply-To: <20250822120506.15486-1-liankun.yang@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7811:EE_
x-ms-office365-filtering-correlation-id: 94f6efbb-5af9-4081-3f55-08dde9265107
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|42112799006|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bDZTcm1yMEFxU21lditCREhGWXIzV05ReTB2WDZPaVM0TEpWd1FKWFFvKzlH?=
 =?utf-8?B?RDJqMGVmVEUyTHZ2Z1J0bUprbUk1UVg4Y0VIeTdyUmtIMnM2bFZ4SHZvWTh0?=
 =?utf-8?B?clgzMTdLVnR4a3Nhb3I4bUJCTDhVM3RPbzFTdW53OWthRDlpMEJJL21Fcy9S?=
 =?utf-8?B?dEx5MmpZazVEcFE2VElROFhXVkhDMzV1TEprMk1VT3pYSnF2dXdybEtSeDBP?=
 =?utf-8?B?T0JhZVViY3ZzVXBPeU9GN0VyV20rWU5MVkVVMUZPTitwM2xKd3hqKzd6M21y?=
 =?utf-8?B?cUdXS0NyMFh2L0NINE1XZjVWTjJ1cmF4bytKdG5ZQ25pR2hSZEdKMkl0STJr?=
 =?utf-8?B?TmVycklSMjliSlJITnJBS3RtNkFkNzFuQzZad1JSWjZJSVJJUmRseVdCZUpF?=
 =?utf-8?B?NnNLZ21FZllRa0MrRFlnZFNxK0M2K0FEV0FiRlZNUFExa0xUcGV4Y2hsVTBT?=
 =?utf-8?B?TU9VUWdPT0NvN0QxOHErZjg3UzBPVmQ0S20vcFFRQWQrbkhNcVFlSDBQTThI?=
 =?utf-8?B?N3ZETENwc24yMEE0QlpVL3FPZ2NHUEQwMlM3R3d2QnNSM2x6UFlBbWFIWDM0?=
 =?utf-8?B?a1pSaFh1dmJCbTRQeWIyQTVLS3lzMUU3S0UweTVtdnU0eS9IRENHdTFBM2FH?=
 =?utf-8?B?dmc1VTNrWml5L2NxWmJVODRJVWRtTlIvYytSbC9wMWVTTytCbUNES3ZUYm5v?=
 =?utf-8?B?b1Z3QWVpNzU5TkZUeGhNZ2FEWWRHYnVTTWJvdjdmQ2FpSjhjaStmTjl0UGVW?=
 =?utf-8?B?N1FYRloyNDBGek1CbFQwT2RQOURJRklCaUZkcmZsY284U3orRFZZSjJ3eHpL?=
 =?utf-8?B?NHV0MkxRWm9haGx4VW5JZXBUZWc4Vnh5UnBHMGo3bFVITDRMU3F4NDFNbUE3?=
 =?utf-8?B?blRiTmxkUHJIOTJTVTVmMzdCYkFwcnNtVk5lNUh3ZDY0eTR5NEdEa3NlYTY3?=
 =?utf-8?B?SUV5bFA4Tm5oMGRzS0NFL3VPamZzeEJveHVtOC9NemEzbWN1RmxWN0lyOG9D?=
 =?utf-8?B?R2tSUWFMTGhoWkx1R2ZpcnY1MDJTZ0JycVpJM0dBanVZTkZCNmZ0SzFtQlkv?=
 =?utf-8?B?Ty8wNjNqWnZ1N256cWNMWXArQjhzY1h5dVA3Qm1ZM1hweUhQYXVkMkRBaE5i?=
 =?utf-8?B?SHEySXhxeHVYMTVoT1Rod2svSTlMT0RMdVF5WWMxd0VPeXlySlNtYlVTVi9m?=
 =?utf-8?B?Ri9wT3paYURwdXczQ3Y4dEUrVFNFaWVIU2xneGYwYWtJaHNjbjJ2elZhOXBE?=
 =?utf-8?B?L1VYVVFZbzAycVNRSnB6cUFCSzcrOENxdVZvUUlTZS96aS9uT3lkaFZVSS9a?=
 =?utf-8?B?bUZ4MEk0d0FYbGNpd3FzK2w5YjZkTzNsS3lXbWZhdXZTNUpUdXIxNnQzcXQz?=
 =?utf-8?B?UlJmaDBYUnJrWUEyTklnbFExOHlYdWc4b1ltZ1cveE5Zek1YbEJCUEttZkRv?=
 =?utf-8?B?SWRTN2pQQVgxeVIzTmdMQnAyS2Fla3ZEZnAvYXpVN0RYNFFMdGVmNU1OUm9E?=
 =?utf-8?B?NW9jS1N2bldrMk9CR1RCZ1FJY0pkTHZIcUtxUk9McmR3eDUrUHFlWWlNeWZh?=
 =?utf-8?B?Q2FmRm56NlNwY3VVakl1VEUzR1NVbTk4eXI1c0VlSlA3OTFaNHlmQXBNWDd6?=
 =?utf-8?B?NjNScWNIY0JRbzB0b210all1RTV5bmpGM2VGTUp5WDN2dGp1QTQ0Nmhwc0hy?=
 =?utf-8?B?WktEM0FOa0tEOXRBUENKTWRkN0lFcW95L1FqZTkrQW5JeWpQVDZnTDNRZld2?=
 =?utf-8?B?VnBPcmlrbWtyU0ZiQnkyemlFaHpxd3JHQlVhaTZFeUo2OEFBbnU5N3ROamhu?=
 =?utf-8?B?NVRoeDg3RzV2OEVwRk5mVVFxNFRIMm9kK1o3dml6NGR1K0J4WXQ0d0NrcVdU?=
 =?utf-8?B?SE1pM0UwRUxxVStiSzdyL05aSHBMdk43TXkvMWF6L05ISXRIcU01cnkxVXo3?=
 =?utf-8?B?UFNMVmdHTitjK3lOQmpmUFF6YTFncmVoN1RCSXhKbk9VWEp0dFBiQ0RKcm45?=
 =?utf-8?B?Nkp6dVBBTUFUK0c0ZUJRZDVZQVgzaUJnYzEzSExIQ094R01xVms4cEx5Y04r?=
 =?utf-8?Q?Py2EVl?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(42112799006)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1FnSXNnbnNySDBTVXpjbkZ5SXRGS0JLdHdRVXl5NUZGcjBjRlhGUHhiSmFC?=
 =?utf-8?B?UmFHdDNuZzBXNXRpUk1zcGprZE5zVjhwT2xPVmR0N0QrK3NCWHpaOFBCS2cr?=
 =?utf-8?B?RUgxa3VBdlBRV3Erekh2QzdPZEV1dVVHdzZJWDJOeUF0cHRhSDFVSWl5c1li?=
 =?utf-8?B?YXlselh0d2lPeXNJcHdYeU9pdlUvc2NnYllCOThDbS9vRVJ3cC96cG1GSUgx?=
 =?utf-8?B?d2lab3NXd2dqaVpGZ04xMWZ2b0xWdytjdmVyc0h1ZFEzZXZjNTBvS2dYc2Ix?=
 =?utf-8?B?ZURydE4weWVEWnI4enZUMmROY3RiVVhuYXlMV1NJaW9Wb3FYUGhYQVlaZW5z?=
 =?utf-8?B?TFlncEVUY2NRSmgvM1BNR1ZJTTJJNUw3TUd5bUQwYkNiNnlkM09CeTBTb0x2?=
 =?utf-8?B?ZUx1NmRZQklncjBybVM5QmUzYXdiWTY4OWY1aE1xdG5ndURrajlydmhkeDFX?=
 =?utf-8?B?ZS9KaE1DNnZRT0htekFsYktTSTVNQUJOWmJ1ekQvY0dzaWpPKzFxbjlHUE9B?=
 =?utf-8?B?UlpTNXFubkthdkExcWxidVZnV1F2ci83dnB5SiswZ3JTNXpTZXpRcUhhTVZz?=
 =?utf-8?B?MnRiZkdacURDQUE4bGpKSWRLR2hOOTVtb244NGl4OExaVDkvMGJTOXdLeDU5?=
 =?utf-8?B?Q3BUcXlYSUpjTXVqRk5OQmIzdmNJa0xJTWl5anpSd1Q5TU9pejc4Y0QvSlU4?=
 =?utf-8?B?YTBJRGZvcWUra3dUQWcxTFpLVFROTGZUbzFyMHdvbHJVUHpiODBoQU5uakt1?=
 =?utf-8?B?dll1dFpjUG1iT09qOVQwSU00dDRCWGJJVGdyelJEeUk0NmtiOEt5alVzQWND?=
 =?utf-8?B?OEVCei9vamR4dzdGWHhDTmlVU0JUeU9WNVBuRjJtM3YzMGNRYnRXUGxLRjlG?=
 =?utf-8?B?QjQzK3JtS0t5TWE2cWJZaW5iVkZJYUdGVEtsWmN1L2xPSDRBWEdTank2b2dS?=
 =?utf-8?B?VUIxNDJwVWQyZGJBN3F0VXUwaXJNMWd5T3F5Q3JDVWdjeU15WjlFRFJxMi83?=
 =?utf-8?B?VDhyMWhIbmpXRE5peS9odWt1UDFiTnhGSTNMSEgvUjBEZDlQZE1NeE4vRWhC?=
 =?utf-8?B?NGw2aUV6QW14RFRwazEybWFmYzFFMUNDK01aMmlmck8zY0p0c2lEVm9JUEt6?=
 =?utf-8?B?Q3NhNDN1ak1jRWlFSUpsRlNDQVdWQS9PbW44b2N4QUpzam9sRW1pdnZyWlF6?=
 =?utf-8?B?a3dSOHdQV1dLZEQwZ3owV2U5Z29FZ1RMT1hFY054OFNWVUF3dlJhRlA2U3B0?=
 =?utf-8?B?TG4rZVZ3cVdrNm5KMWtHQXlLekRSdGlVelhobkN2Um5kUjdSRlB0eDZHTXFk?=
 =?utf-8?B?U2FVMWdSNGc5WE5BSVpWNDdFMVRmT1VKeHBxMHQwMVRTMnd0RW1zNmg4bmF5?=
 =?utf-8?B?Z2c2VWN6dVozMWhjSGNzdkFsaEsxTWdwTXJDOFdxQ3V3RXZvM1BUYzF5cnIw?=
 =?utf-8?B?a0h2UVRQemd3MmQ3aW5nN01jK1RQa3RrUUlhd09nc254bVdQMWJueklEUURl?=
 =?utf-8?B?YU01dTg3QjQ1Y0F4TURGN1NQZHg3WlZRdkVheVJGSUlxWUM3Q0xVVTgrcVR5?=
 =?utf-8?B?V2VMRHVkNzRKSzFoUlQ2cXpxdW5TZEtlU0RxRmVxekN3eEluY2dOazh4cTZJ?=
 =?utf-8?B?MVdZVVdPa25WUjQ0NzdxNmFaTTJjV3pwYUhaNDZXNjBIelc5NUNjL0tPaGxE?=
 =?utf-8?B?VEkza3BVVWlScUdtMk0vVmZRZVUvWTFUbm1vQ3dXL08zQU5BaG82bW9UMkdM?=
 =?utf-8?B?ajBzNUozUlFwVTJsOTF0UnB6NFVQSDVtU3gxRkp6YmhtZ2k4aFFDazYxR3lB?=
 =?utf-8?B?YzNDdmNILy9ONUg1OXV2YXNscGlrWktiR0F3cDZncmhoVHBkRmFuOTMxYVZG?=
 =?utf-8?B?VUZ6ZEY2dmlrcjBPNUF2cVY5WHVLSlVYVnp5UmZnUjdGZHVPbjZjSXc1WWJF?=
 =?utf-8?B?ZG83bUJYcW80RWZ1VW93WU1YOVpFczlDT2xqUm85Z3IwRkN1Y2NncUx0eWZ3?=
 =?utf-8?B?MFJZNFpxYzY0SnNJYjV3S0lKR0hYYXBMSGpQLzdOVkVlVGUzVWIrWWFQMjR4?=
 =?utf-8?B?OGp6RzRkWlFXYlV6R3hUNTZBN0tVeHVLMGN5VlRFUzd2QU5aRjB3V1R5YmxW?=
 =?utf-8?Q?qyVOeFYKXzA1Y5RPJeoo6d4oL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6283CF9AA5B8D44D8F2C5F9E96CB226E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f6efbb-5af9-4081-3f55-08dde9265107
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 07:08:13.3781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ME34RDjGLhvSNFoyks7K/6MPLCUSmCYzVBQr5xvECTbXXiRNMTp3zCXk83znSFkSHQ5qQTXa+ItQCCSoYI2Rgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7811

T24gRnJpLCAyMDI1LTA4LTIyIGF0IDIwOjA0ICswODAwLCBMaWFua3VuIFlhbmcgd3JvdGU6DQo+
IEJ5IGFkanVzdGluZyB0aGUgb3JkZXIgb2YgbGluayB0cmFpbmluZyBhbmQgcmVsb2NhdGluZyBp
dCB0byBIUEQsDQo+IGxpbmsgdHJhaW5pbmcgY2FuIGlkZW50aWZ5IHRoZSB1c2FiaWxpdHkgb2Yg
ZWFjaCBsYW5lIGluIHRoZSBjdXJyZW50IGxpbmsuDQo+IA0KPiBJdCBhbHNvIHN1cHBvcnRzIGhh
bmRsaW5nIHNpZ25hbCBpbnN0YWJpbGl0eSBhbmQgd2Vha25lc3MgZHVlIHRvDQo+IGVudmlyb25t
ZW50YWwgaXNzdWVzLCBlbmFibGluZyB0aGUgYWNxdWlzaXRpb24gb2YgYSBzdGFibGUgYmFuZHdp
ZHRoDQo+IGZvciB0aGUgY3VycmVudCBsaW5rLiBTdWJzZXF1ZW50bHksIERQIHdvcmsgY2FuIHBy
b2NlZWQgYmFzZWQgb24NCj4gdGhlIGFjdHVhbCBtYXhpbXVtIGJhbmR3aWR0aC4NCj4gDQo+IEl0
IHNob3VsZCB0cmFpbmluZyBpbiB0aGUgaHBkIGV2ZW50IHRocmVhZC4NCj4gQ2hlY2sgdGhlIG1v
ZGUgd2l0aCBsYW5lIGNvdW50IGFuZCBsaW5rIHJhdGUgb2YgdHJhaW5pbmcuDQo+IA0KPiBJZiB3
ZSdyZSBlRFAgYW5kIGNhcGFiaWxpdGllcyB3ZXJlIGFscmVhZHkgcGFyc2VkIHdlIGNhbiBza2lw
DQo+IHJlYWRpbmcgYWdhaW4gYmVjYXVzZSBlRFAgcGFuZWxzIGFyZW4ndCBob3RwbHVnZ2FibGUg
aGVuY2UgdGhlDQo+IGNhcHMgYW5kIHRyYWluaW5nIGluZm9ybWF0aW9uIHdvbid0IGV2ZXIgY2hh
bmdlIGluIGEgYm9vdCBsaWZlDQo+IA0KPiBUaGVyZWZvcmUsIGJyaWRnZSB0eXBlYyBqdWRnbWVu
dCBpcyByZXF1aXJlZCBmb3IgZWRwIHRyYWluaW5nIGluDQo+IGF0b21pY19lbmFibGUgZnVuY3Rp
b24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMaWFua3VuIFlhbmcgPGxpYW5rdW4ueWFuZ0BtZWRp
YXRlay5jb20+DQo+IC0tLQ0KPiBDaGFuZ2UgaW4gVjY6DQo+IC0gRml4ZWQgcG93ZXIgb24gaW4g
YXRvbWljIGVuYWJsZS4NCj4gLSBGaXhlZCBwYXJzZSBjYXBhYmlsaXR5IGZvciBlZHAuDQo+IFBl
ciBzdWdnZXN0aW9uIGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1t
ZWRpYXRlay9wYXRjaC8yMDI1MDYzMDA4MDgyNC43MTA3LTEtbGlhbmt1bi55YW5nQG1lZGlhdGVr
LmNvbS9fXzshIUNUUk5LQTl3TWcwQVJidyFrU0xyWV9laFh0SUoyMWFfbGpuWDdFbUR0RDkybjhS
ZmpXOUplZTZxUmZLekM4ZWtwa3Z2UmNNb0pSSW8wM1dnUUFtX0w3UjN6S3JyNWtTMUZVS002YWck
IA0KPiANCj4gQ2hhbmdlIGluIFY1Og0KPiAtIEZpeGVkIHRoZSBpc3N1ZSB0aGF0IHRoZSA0dGgg
dmVyc2lvbiBvZiB0aGUgcGF0Y2ggY2F1c2VkIERQIHRvIGhhdmUgbm8gc2NyZWVuLg0KPiBQZXIg
c3VnZ2VzdGlvbiBmcm9tIHRoZSBwcmV2aW91cyB0aHJlYWQ6DQo+IGh0dHBzOi8vdXJsZGVmZW5z
ZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVk
aWF0ZWsvcGF0Y2gvMjAyNTA2MjUwOTU0NDYuMzE3MjYtMS1saWFua3VuLnlhbmdAbWVkaWF0ZWsu
Y29tL19fOyEhQ1RSTktBOXdNZzBBUmJ3IWtTTHJZX2VoWHRJSjIxYV9sam5YN0VtRHREOTJuOFJm
alc5SmVlNnFSZkt6Qzhla3BrdnZSY01vSlJJbzAzV2dRQW1fTDdSM3pLcnI1a1MxTngtZnM1TSQg
DQo+IA0KPiBDaGFuZ2UgaW4gVjQ6DQo+IC0gVGVzdGVkIHRoZSBpbnRlcm5hbCBlRFAgZGlzcGxh
eSBvbiBNVDgxOTUgVG9tYXRvIGFuZCBpdCBpcyBmaW5lLg0KPiBQZXIgc3VnZ2VzdGlvbiBmcm9t
IHRoZSBwcmV2aW91cyB0aHJlYWQ6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAy
NTAzMTgxNDAyMzYuMTM2NTAtMi1saWFua3VuLnlhbmdAbWVkaWF0ZWsuY29tL19fOyEhQ1RSTktB
OXdNZzBBUmJ3IWtTTHJZX2VoWHRJSjIxYV9sam5YN0VtRHREOTJuOFJmalc5SmVlNnFSZkt6Qzhl
a3BrdnZSY01vSlJJbzAzV2dRQW1fTDdSM3pLcnI1a1Mxb3NQMVNHMCQgDQo+IA0KPiBDaGFuZ2Ug
aW4gVjM6DQo+IC0gUmVtb3ZlICdtdGtfZHAtPmVuYWJsZWQgPSBmYWxzZSIgaW4gYXRvbWljIGRp
c2FibGUuDQo+IC0gUmVtb3ZlICdtdGtfZHAtPmVuYWJsZWQgPSB0cnVlIiBpbiBhdG9taWMgZW5h
YmxlLg0KPiBQZXIgc3VnZ2VzdGlvbiBmcm9tIHRoZSBwcmV2aW91cyB0aHJlYWQ6DQo+IGh0dHBz
Oi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2pl
Y3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAyNDEwMjUwODMwMzYuODgyOS00LWxpYW5rdW4ueWFu
Z0BtZWRpYXRlay5jb20vX187ISFDVFJOS0E5d01nMEFSYncha1NMcllfZWhYdElKMjFhX2xqblg3
RW1EdEQ5Mm44UmZqVzlKZWU2cVJmS3pDOGVrcGt2dlJjTW9KUklvMDNXZ1FBbV9MN1IzektycjVr
UzFNalE1R2lVJCANCj4gDQo+IENoYW5nZSBpbiBWMjoNCj4gLSBBZGp1c3QgRFAgdHJhaW5pbmcg
dGltaW5nLg0KPiAtIEFkanVzdCBwYXJzZSBjYXBhYmlsaXRpZXMgdGltaW5nLg0KPiAtIEFkZCBw
b3dlciBvbi9vZmYgZm9yIGNvbm5lY3QvZGlzY29ubmVjdC4NCj4gUGVyIHN1Z2dlc3Rpb24gZnJv
bSB0aGUgcHJldmlvdXMgdGhyZWFkOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzIw
MjQwMzE1MDE1MjMzLjIwMjMtMS1saWFua3VuLnlhbmdAbWVkaWF0ZWsuY29tL19fOyEhQ1RSTktB
OXdNZzBBUmJ3IWtTTHJZX2VoWHRJSjIxYV9sam5YN0VtRHREOTJuOFJmalc5SmVlNnFSZkt6Qzhl
a3BrdnZSY01vSlJJbzAzV2dRQW1fTDdSM3pLcnI1a1MxaUpIcE16WSQgDQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDkgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IGluZGV4IGJlZjZlZWIz
MGQzZS4uMzg0NDk2ZTQ5MTE4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RwLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+
IEBAIC0xOTc2LDYgKzE5NzYsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgbXRrX2RwX2hwZF9ldmVu
dF90aHJlYWQoaW50IGhwZCwgdm9pZCAqZGV2KQ0KPiAgCXN0cnVjdCBtdGtfZHAgKm10a19kcCA9
IGRldjsNCj4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAgCXUzMiBzdGF0dXM7DQo+ICsJaW50
IHJldDsNCj4gIA0KPiAgCWlmIChtdGtfZHAtPm5lZWRfZGVib3VuY2UgJiYgbXRrX2RwLT50cmFp
bl9pbmZvLmNhYmxlX3BsdWdnZWRfaW4pDQo+ICAJCW1zbGVlcCgxMDApOw0KPiBAQCAtMTk5NCw5
ICsxOTk1LDI4IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBtdGtfZHBfaHBkX2V2ZW50X3RocmVhZChp
bnQgaHBkLCB2b2lkICpkZXYpDQo+ICAJCQltZW1zZXQoJm10a19kcC0+aW5mby5hdWRpb19jdXJf
Y2ZnLCAwLA0KPiAgCQkJICAgICAgIHNpemVvZihtdGtfZHAtPmluZm8uYXVkaW9fY3VyX2NmZykp
Ow0KPiAgDQo+ICsJCQltdGtfZHAtPmVuYWJsZWQgPSBmYWxzZTsNCg0KSSdtIG5vdCBzdXJlIGVE
UCB3b3VsZCBoYXZlIGhvdC1wbHVnIGV2ZW50IG9yIG5vdC4NCklmIGVEUCBhbHNvIGhhcyBob3Qt
cGx1ZyBldmVudCAob25jZSksIGFkZCBkbyB0aGlzIG9ubHkgZm9yIERQDQoNCmlmIChtdGtfZHAt
PmRhdGEtPmJyaWRnZV90eXBlICE9IERSTV9NT0RFX0NPTk5FQ1RPUl9lRFApIHsNCgkvKiBBY3Rp
b24gb25seSBmb3IgRFAgKi8NCn0NCg0KPiArCQkJLyogcG93ZXIgb2ZmIGF1eCAqLw0KPiArCQkJ
bXRrX2RwX3VwZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX1RPUF9QV1JfU1RBVEUsDQo+ICsJCQkJ
CSAgIERQX1BXUl9TVEFURV9CQU5ER0FQX1RQTEwsDQo+ICsJCQkJCSAgIERQX1BXUl9TVEFURV9N
QVNLKTsNCg0KV2h5IG5vdCB1c2UgbXRrX2RwX2F1eF9wYW5lbF9wb3dlcm9uKG10a19kcCwgZmFs
c2UpPw0KV2hlbiBwbHVnIGluLCB5b3UgY2FsbCBtdGtfZHBfYXV4X3BhbmVsX3Bvd2Vyb24obXRr
X2RwLCB0cnVlKSwNCkkgd291bGQgbGlrZSBpdCB0byBiZSBzeW1tZXRyaWMuDQpJZiBub3Qgc3lt
bWV0cmljLCBhZGQgY29tbWVudCB0byBkZXNjcmliZSB3aHkgaXQncyBub3Qgc3ltbWV0cmljLg0K
DQo+ICsNCj4gIAkJCW10a19kcC0+bmVlZF9kZWJvdW5jZSA9IGZhbHNlOw0KPiAgCQkJbW9kX3Rp
bWVyKCZtdGtfZHAtPmRlYm91bmNlX3RpbWVyLA0KPiAgCQkJCSAgamlmZmllcyArIG1zZWNzX3Rv
X2ppZmZpZXMoMTAwKSAtIDEpOw0KPiArCQl9IGVsc2Ugew0KPiArCQkJbXRrX2RwX2F1eF9wYW5l
bF9wb3dlcm9uKG10a19kcCwgdHJ1ZSk7DQo+ICsNCj4gKwkJCXJldCA9IG10a19kcF9wYXJzZV9j
YXBhYmlsaXRpZXMobXRrX2RwKTsNCj4gKwkJCWlmIChyZXQpDQo+ICsJCQkJZHJtX2VycihtdGtf
ZHAtPmRybV9kZXYsICJDYW4ndCBwYXJzZSBjYXBhYmlsaXRpZXNcbiIpOw0KPiArDQo+ICsJCQkv
KiBUcmFpbmluZyAqLw0KPiArCQkJcmV0ID0gbXRrX2RwX3RyYWluaW5nKG10a19kcCk7DQo+ICsJ
CQlpZiAocmV0KQ0KPiArCQkJCWRybV9lcnIobXRrX2RwLT5kcm1fZGV2LCAiVHJhaW5pbmcgZmFp
bGVkLCAlZFxuIiwgcmV0KTsNCj4gKw0KPiArCQkJbXRrX2RwLT5lbmFibGVkID0gdHJ1ZTsNCj4g
IAkJfQ0KPiAgCX0NCj4gIA0KPiBAQCAtMjE2Nyw3ICsyMTg3LDggQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBkcm1fZWRpZCAqbXRrX2RwX2VkaWRfcmVhZChzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdl
LA0KPiAgCSAqIFBhcnNlIGNhcGFiaWxpdHkgaGVyZSB0byBsZXQgYXRvbWljX2dldF9pbnB1dF9i
dXNfZm10cyBhbmQNCj4gIAkgKiBtb2RlX3ZhbGlkIHVzZSB0aGUgY2FwYWJpbGl0eSB0byBjYWxj
dWxhdGUgc2luayBiaXRyYXRlcy4NCj4gIAkgKi8NCj4gLQlpZiAobXRrX2RwX3BhcnNlX2NhcGFi
aWxpdGllcyhtdGtfZHApKSB7DQo+ICsJaWYgKG10a19kcC0+YnJpZGdlLnR5cGUgPT0gRFJNX01P
REVfQ09OTkVDVE9SX2VEUCAmJg0KPiArCSAgICBtdGtfZHBfcGFyc2VfY2FwYWJpbGl0aWVzKG10
a19kcCkpIHsNCg0KSSB0aGluayB0aGlzIG1vZGlmaWNhdGlvbiBpcyByZWxhdGVkIHRvIHdoYXQg
eW91IHNheToNCg0KIklmIHdlJ3JlIGVEUCBhbmQgY2FwYWJpbGl0aWVzIHdlcmUgYWxyZWFkeSBw
YXJzZWQgd2UgY2FuIHNraXANCnJlYWRpbmcgYWdhaW4gYmVjYXVzZSBlRFAgcGFuZWxzIGFyZW4n
dCBob3RwbHVnZ2FibGUgaGVuY2UgdGhlDQpjYXBzIGFuZCB0cmFpbmluZyBpbmZvcm1hdGlvbiB3
b24ndCBldmVyIGNoYW5nZSBpbiBhIGJvb3QgbGlmZSINCg0KSSB0aGluayB0aGlzIG1vZGlmaWNh
dGlvbiBpcyBub3QgcmVsYXRlZCB0byB0aGUgdGl0bGUuDQpUaGlzIGlzIHRvIGltcHJvdmUgZURQ
IGZ1bmN0aW9uIG5vdCBEUC4NClNvIHNlcGFyYXRlIHRoaXMgdG8gYW5vdGhlciBwYXRjaC4NCg0K
PiAgCQlkcm1fZXJyKG10a19kcC0+ZHJtX2RldiwgIkNhbid0IHBhcnNlIGNhcGFiaWxpdGllc1xu
Iik7DQo+ICAJCWRybV9lZGlkX2ZyZWUoZHJtX2VkaWQpOw0KPiAgCQlkcm1fZWRpZCA9IE5VTEw7
DQo+IEBAIC0yMzU1LDYgKzIzNzYsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHBfYnJpZGdlX2F0b21p
Y19lbmFibGUoc3RydWN0IGRybV9icmlkZ2UgKmJyaWRnZSwNCj4gIAkJCQkJc3RydWN0IGRybV9h
dG9taWNfc3RhdGUgKnN0YXRlKQ0KPiAgew0KPiAgCXN0cnVjdCBtdGtfZHAgKm10a19kcCA9IG10
a19kcF9mcm9tX2JyaWRnZShicmlkZ2UpOw0KPiArCWJvb2wgZW5hYmxlZCA9IG10a19kcC0+ZW5h
YmxlZDsNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+ICAJbXRrX2RwLT5jb25uID0gZHJtX2F0b21pY19n
ZXRfbmV3X2Nvbm5lY3Rvcl9mb3JfZW5jb2RlcihzdGF0ZSwNCj4gQEAgLTIzNjUsMTMgKzIzODcs
MTYgQEAgc3RhdGljIHZvaWQgbXRrX2RwX2JyaWRnZV9hdG9taWNfZW5hYmxlKHN0cnVjdCBkcm1f
YnJpZGdlICpicmlkZ2UsDQo+ICAJCXJldHVybjsNCj4gIAl9DQo+ICANCj4gLQltdGtfZHBfYXV4
X3BhbmVsX3Bvd2Vyb24obXRrX2RwLCB0cnVlKTsNCj4gKwlpZiAoIWVuYWJsZWQpDQo+ICsJCW10
a19kcF9hdXhfcGFuZWxfcG93ZXJvbihtdGtfZHAsIHRydWUpOw0KPiAgDQo+IC0JLyogVHJhaW5p
bmcgKi8NCj4gLQlyZXQgPSBtdGtfZHBfdHJhaW5pbmcobXRrX2RwKTsNCj4gLQlpZiAocmV0KSB7
DQo+IC0JCWRybV9lcnIobXRrX2RwLT5kcm1fZGV2LCAiVHJhaW5pbmcgZmFpbGVkLCAlZFxuIiwg
cmV0KTsNCj4gLQkJZ290byBwb3dlcl9vZmZfYXV4Ow0KPiArCWlmIChtdGtfZHAtPmRhdGEtPmJy
aWRnZV90eXBlID09IERSTV9NT0RFX0NPTk5FQ1RPUl9lRFApIHsNCj4gKwkJLyogVHJhaW5pbmcg
Ki8NCj4gKwkJcmV0ID0gbXRrX2RwX3RyYWluaW5nKG10a19kcCk7DQo+ICsJCWlmIChyZXQpIHsN
Cj4gKwkJCWRybV9lcnIobXRrX2RwLT5kcm1fZGV2LCAiVHJhaW5pbmcgZmFpbGVkLCAlZFxuIiwg
cmV0KTsNCj4gKwkJCWdvdG8gcG93ZXJfb2ZmX2F1eDsNCj4gKwkJfQ0KPiAgCX0NCg0KaWYgKG10
a19kcC0+ZGF0YS0+YnJpZGdlX3R5cGUgPT0gRFJNX01PREVfQ09OTkVDVE9SX2VEUCkgew0KCW10
a19kcF9hdXhfcGFuZWxfcG93ZXJvbihtdGtfZHAsIHRydWUpOw0KDQoJLyogVHJhaW5pbmcgKi8N
CglyZXQgPSBtdGtfZHBfdHJhaW5pbmcobXRrX2RwKTsNCglpZiAocmV0KSB7DQoJCWRybV9lcnIo
bXRrX2RwLT5kcm1fZGV2LCAiVHJhaW5pbmcgZmFpbGVkLCAlZFxuIiwgcmV0KTsNCgkJZ290byBw
b3dlcl9vZmZfYXV4Ow0KCX0NCn0NCg0KPiAgDQo+ICAJcmV0ID0gbXRrX2RwX3ZpZGVvX2NvbmZp
ZyhtdGtfZHApOw0KPiBAQCAtMjM5MSw3ICsyNDE2LDYgQEAgc3RhdGljIHZvaWQgbXRrX2RwX2Jy
aWRnZV9hdG9taWNfZW5hYmxlKHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UsDQo+ICAJCSAgICAg
ICBzaXplb2YobXRrX2RwLT5pbmZvLmF1ZGlvX2N1cl9jZmcpKTsNCj4gIAl9DQo+ICANCj4gLQlt
dGtfZHAtPmVuYWJsZWQgPSB0cnVlOw0KDQppZiAobXRrX2RwLT5kYXRhLT5icmlkZ2VfdHlwZSA9
PSBEUk1fTU9ERV9DT05ORUNUT1JfZURQKQ0KCW10a19kcC0+ZW5hYmxlZCA9IHRydWU7DQoNCj4g
IAltdGtfZHBfdXBkYXRlX3BsdWdnZWRfc3RhdHVzKG10a19kcCk7DQo+ICANCj4gIAlyZXR1cm47
DQo+IEBAIC0yNDA2LDcgKzI0MzAsNiBAQCBzdGF0aWMgdm9pZCBtdGtfZHBfYnJpZGdlX2F0b21p
Y19kaXNhYmxlKHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UsDQo+ICB7DQo+ICAJc3RydWN0IG10
a19kcCAqbXRrX2RwID0gbXRrX2RwX2Zyb21fYnJpZGdlKGJyaWRnZSk7DQo+ICANCj4gLQltdGtf
ZHAtPmVuYWJsZWQgPSBmYWxzZTsNCg0KaWYgKG10a19kcC0+ZGF0YS0+YnJpZGdlX3R5cGUgPT0g
RFJNX01PREVfQ09OTkVDVE9SX2VEUCkNCgltdGtfZHAtPmVuYWJsZWQgPSBmYWxzZTsNCg0KUmVn
YXJkcywNCkNLDQoNCj4gIAltdGtfZHBfdXBkYXRlX3BsdWdnZWRfc3RhdHVzKG10a19kcCk7DQo+
ICAJbXRrX2RwX3ZpZGVvX2VuYWJsZShtdGtfZHAsIGZhbHNlKTsNCj4gIAltdGtfZHBfYXVkaW9f
bXV0ZShtdGtfZHAsIHRydWUpOw0KDQo=

