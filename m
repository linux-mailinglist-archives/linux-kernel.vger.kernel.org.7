Return-Path: <linux-kernel+bounces-818524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B997DB592E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70462482836
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF429BD94;
	Tue, 16 Sep 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fw3UtVAK"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25242299922;
	Tue, 16 Sep 2025 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017042; cv=fail; b=dFnzCfxNGme6oc134YQYVCWlN4oyITWqOneAMNatdKzwnAZSWWyToc7T6A2eIc3CSlBUE+4pFRwBZ3glBmhCBaTc1O4hfHaDad68yXkBv4GYkrAoxwrtYoZ05vmILgUEKZoclNhanq/M2lQAqcIq7OwpEtcRpfDweqMbZ635zHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017042; c=relaxed/simple;
	bh=Ce+RSBUoCaLwG35VqqYlgz3/c80iBBIAxh4v3ZCcScw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lEYZh1IVNfMHBeglzzrTdUyLIMAulTYOindhvdC+ep32wh4toYu6lFLil4NBYjQGumpuXJNqum3G3Xw1NsB7i52oaEXDqvAjwtcwC6eWdKx2SOz9vRQPsRgc53ma98l+WPjV415oR04jE+WdvLv3h4Yplue4ef99nWPwYGoufEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fw3UtVAK; arc=fail smtp.client-ip=40.107.162.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPek8ez11+ARbvS52D9PEe81wvnnkvjZAPIRDmctlrR0AxiToskbC6yKW5y3vGc4r+qeNj1LB9ttSNC1a2y6g0Lanrj3VdiFcCxLgvcikionkLw6xXlXodUzFS/VfaNcw6oX9//Og1izX9Gkr7EtzRn/6hJu0jRz1KludEN7yWhFH+vEChfWwwqG/72I8T+6u5MdjIeoHiNgwfaMKYt+D56hPHNyh3WG40jYMdEfNKReydYpi1ZSB/lDsDrwyQotPmA33ACxL1CBZgZ6QTlVjAi1H/Bg4/Th7uMJCl/ETBMG3y0/yma2z3A1PQJ28DOqkiMFGTJ2cX/mpmr8sDPRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ce+RSBUoCaLwG35VqqYlgz3/c80iBBIAxh4v3ZCcScw=;
 b=IEnuxZgzfKar1FoaRvt7TwxaeSp/v3m3TAiLlY9i6qD87K8Lx2yYWP2C5BrARtGclxIHrSy3+eir7mITpJbOa/Z56P//njxEfhP1FSySxXQ7lp2GdFUR/mjNsY/WBD3N2HLsawvRf6rdHAOdD2/2eDqxLa1DI2/qgx8BeLLwJynxcsrCer1x6W/85oKFusrlF8y0ToTdJSwdLJ8tj7mWiAOp+3U4Wc64tjVLV98/pNOO3Igk37d6ROIJSKORa4MnFLwgSoV+qzaLnRRDhJFiD9H3kB8lv80mhCnGINJR718cvzgvMO2LZW0iGZGGs32nspWFUx/gHpJUB//i61GGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce+RSBUoCaLwG35VqqYlgz3/c80iBBIAxh4v3ZCcScw=;
 b=Fw3UtVAK723PYr+dvo21F/M494p+9jYC0H9Y2Xl9ZHr/l/9LfeLKr5TJDZTy95qhsA3R+u1XbW4Gwwj63Wtn0SBZolJ4GI7PTm/djKtcBWsy7R54HHcIEg3Kdfp2YRAtkLiZLIWCZS7G4NLJGwdsLychzKQKua5vjYWQkWeTPjC5kFhV7MDEH9kXSJv3C87w1ZUlooIziHtnPrDtFuR2eed7ulW56iDjlpIvraqzONvtRMsztaG9oQVRJFHQzzJ9dNFYV6v8tARQxhRLwWwExo5M1X5/wkBhnFXXc/f75k7iIiCTcYv6YCCZDzUhpDKz9JacGKYhrZG86ft7+EfXPQ==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM7PR04MB6951.eurprd04.prod.outlook.com (2603:10a6:20b:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Tue, 16 Sep
 2025 10:03:57 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 10:03:57 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] arm64: dts: imx8mm/mn/mp: limit the max frequency of
 spi nor chip
Thread-Topic: [PATCH 2/2] arm64: dts: imx8mm/mn/mp: limit the max frequency of
 spi nor chip
Thread-Index: AQHcJuf27wQaYiqm7Ee/snmbztbMTrSVjoCAgAAFDGA=
Date: Tue, 16 Sep 2025 10:03:57 +0000
Message-ID:
 <DU0PR04MB949692AA53054CF8418213609014A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250916-flexspi-dts-v1-0-61567f969165@nxp.com>
 <20250916-flexspi-dts-v1-2-61567f969165@nxp.com>
 <CAOMZO5DYWenp7fzrthWUiEyOHAVcL02wBqvzA3RyPqiQ8CzGUw@mail.gmail.com>
In-Reply-To:
 <CAOMZO5DYWenp7fzrthWUiEyOHAVcL02wBqvzA3RyPqiQ8CzGUw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AM7PR04MB6951:EE_
x-ms-office365-filtering-correlation-id: 2c9358dc-888d-43d0-99ad-08ddf50859e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmVFd2NjaUdUWWFTb3hYSU1MKzc2V2xlYityb0hmRGRGcUZZNlBBNTE3alJI?=
 =?utf-8?B?Nm13SS9hRDN6aEVML2F1cStTekl2RHorUGhpcWdzOS9LV3lLY2ZBalRWT2FI?=
 =?utf-8?B?My84Y25BNU41NjVpa1pVeHJtditxVzJGbHZSN3M2QXlZUEllOGVlMEtIZTlN?=
 =?utf-8?B?ZGY5alg1ekxOK0xBU0RCbHB1Z21PTjhkRHAyZVlqM0hvMHhTTkxYS1pBQnZx?=
 =?utf-8?B?UXNrbzA4T29DcGEyWVVZNXBRTlZ0UTcwaFExRnJXZk1QTGFUa0dubUh3UnFU?=
 =?utf-8?B?Q0o5SnowWng4VWVEL2tKL0FvTEx4Z2NRRHlXWGZLc01XYndyQlM4M3ZDVG5Q?=
 =?utf-8?B?bjM2YlpvNmpVbngxdEVlaHB3N0lEZENDcUwxQUp4Nld6L1kxbUJJMnkxQmli?=
 =?utf-8?B?eE1hVDJNWWt1MEFLM1p4SjFHYldsbXhTeit2RG9HazVybm10aDE3RndXcnZl?=
 =?utf-8?B?dkFNSEl4MlRqdTI1eTVRVnA4dWRzWENGTytlNHg4L01UMUcrU1c4MDRWUWRS?=
 =?utf-8?B?UE1hZ3YzeXhmQXhEd0VEVUhJTE51YWlDZkVpRVlLRVYrQ2pQNDNIbWZCa21I?=
 =?utf-8?B?MGFqQjVreHY2cEVYeGFPVUZHVEp4eUFjdG5NMHRncmpDUjl6VzdqaXJEdEdu?=
 =?utf-8?B?TEV3bmh1TkFEQlhnaVhhTlhKcTJGRHdGWDdNMXlPd1gyR0g4MDg1OHNYNWhD?=
 =?utf-8?B?OSsxS1ByQndtU29OUitiWHU5RUZpdFFlVFNieCtwdE1RUGc3UERzaWpsTmND?=
 =?utf-8?B?VFk2a2NYeHpzMkoyeEgwa3gxNHQyekZMNGxhUEkzT0I0RTFuN0xDSXIvS2Zs?=
 =?utf-8?B?V295aGNaRXByZDFQMkZ3TjlDaTBWNzFDaFR5ZkorSUNTaDdpdEVXUTUrY3JU?=
 =?utf-8?B?UkZHYlg0MUNWeUp5YUxrV0c2eEF5M0tVWTZrdEMwNGhqOU9jWkVxVjNPYUp6?=
 =?utf-8?B?MXBBOXdKUUg0dVFSckFCdCswMVlLSGYyek92Rk1LZGg5aHJ1UDd6TmVuUXBK?=
 =?utf-8?B?djlnZmZXT1hlMml0OTFmUUhkOHBOQVR3bnk3QzU5QisyN0l0Z0FBQ2NFeGVL?=
 =?utf-8?B?K2JQN3d1Q2lhMk10ajNyUjVLYUFmY2ZUM2xNM2FoNWxHSFVJREZmaEFwWnhy?=
 =?utf-8?B?bVdtTXo3ZGZhTU1vTWxlTU5ITTJvRVFESERKVDdhZFdCYVAzYXlkSGtFRmpJ?=
 =?utf-8?B?a0Zjd3QzS0t6eG5RWWlRSC9oV2tBS1ZTMzB6dlRyWjI4QkxTbXNPWmdabTFH?=
 =?utf-8?B?anVnTnE5RXFITXJOSVBrR0dVdzdsUnpLWW9qamlZNGhUY3NLOTFnckVVNjFQ?=
 =?utf-8?B?U080REhudkpNazBrZnZZeFNKdUhSUjlQOFg3NDBiNXNTUWdpNmpyK3NaME5y?=
 =?utf-8?B?M2ZIVSsxU0N4Y3dRNkRpY0J5c1JpNUg2ZEdveWpKZ0Era1B0UXhZKzlsM0VT?=
 =?utf-8?B?bFloVjFRZDF2dDAwQUVyMWpSVXU2c2hKVS93SU5VOTJ0aXZFbW5xWFNpZUly?=
 =?utf-8?B?bGNjNTZUa0FBR0FSd3NGOHhMVHFiZytWZm41ZlhaTjFPUktERC9VYTZiMHpN?=
 =?utf-8?B?QnMrclhLQW9iRy9wWWw5bmJ1UDN3elJlVENrQnpNOWdNYTA0V2Y4NGNtRElO?=
 =?utf-8?B?aXhQVkRlS3FGbldHY1NxaHIrWC9nSzZQYmRQTWdDdFJ6SlBDZyswMXBKaEx3?=
 =?utf-8?B?THl5bVRKRER4R1lJNG1uMkJKNVBpWUpEQ2hEaDhZMjhvN3YvcysyQWNjSnQ3?=
 =?utf-8?B?UVNqZ1hEMFdpV0JyWktvL3ozbWp0ekk5UFdYMlAzMUNWWjcxWjlHZk5VSG9r?=
 =?utf-8?B?emp2dkJBMUpjdGRYdjZoVnM4TXZTVktYeFU0U0QxMXdOZzh5TUMxblZCQjVN?=
 =?utf-8?B?dy9QRmNaZjF2bVJZdlJIVUZVZGxSN3FzSW1waytWdStUTDFNbzRYbTdXTVd1?=
 =?utf-8?B?QkNUaTYrVUJQeDFYVmF4dmZxNFhYZWFSR2N4ekc1TWlveG51eDh4RkI2RjVw?=
 =?utf-8?B?NzNyN1RkZGtRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3pvVEdHQ3ZkN2N0ckE4aTRSeHBZYm4wVmU5UTRMV2tSUFM0RmF4ZVdqTUE2?=
 =?utf-8?B?b1dOZGVYUFVNU241OTM4K3JabGV1ZW1idGZTbUxuK2dvWEs3NDlUV0haeGRK?=
 =?utf-8?B?QnZKYVNDaU1KVDJYcnZyc3JsZzFzMjhrZTVDOTdyWkhoOW9ETk1DUEN6TDA0?=
 =?utf-8?B?WHZWZTB3VGNUUUlGZ3F0ZlBiY3h1akdyV1hSQlFGanBZY1NhM085S3Z4QWNJ?=
 =?utf-8?B?dmhTczZUU0JxaTRtTGlKMm80dVAwSndEMDZFaWMrbEFlQ2YraTU3NXdHSmpD?=
 =?utf-8?B?b0p3NGVLSzJGcCtJeVFGNVZxTS9iM2lIaTNmallwMkE5S3RaVkQ5ZFFYbzZ0?=
 =?utf-8?B?cy84K2NIYjlqcmt5bS9ZLzJqQkFkYWM3dXhQVFQwN3RWM1ZXZklMWXdvdHIx?=
 =?utf-8?B?bTNBMXBqZGVYYVF5Q0xOT2ZHVDJ2eDR2ZUpyUFU3MHFxNjRiQitheWpNSDJR?=
 =?utf-8?B?aVd4cVYxYU8zOS9qZzNwSUlFOUJYcGJsdTU3REpEWm11R1RoZVNWS1gwYmti?=
 =?utf-8?B?WkFUcjcyd3NOMHFUZzRqQXVkMDJWQWpSY1A1eDVwdWNnOFJXemVvNmF5MnVH?=
 =?utf-8?B?TGl5VFFqaHplZlcrVlJLVFovZmprU1p0SXRudzlkTG5ERjRhVG5uZHp2UGJo?=
 =?utf-8?B?UFNCK2NUVXlhSzRNZGY3OWZ3ZlpuSUhBcmVZT0Ywd3hFNEI4Tk9DV3VSelJR?=
 =?utf-8?B?bGJWMDJMbjN4Z0tzSUc4aTJPQkFqY1dhVDhHTFJjanZtTVNVWTJCQTdHUzFR?=
 =?utf-8?B?YUJRUzlidW9HLzM2WTJEN3lrYTFpRDh6OWdiSjlUQnd4R1ppZkEyYnJWaXNJ?=
 =?utf-8?B?WHQzWDFtQTRXejk1ZlNIbHhUbU5rSnFibVkzdGxHUWduU1A0VGpiTFoxbXl0?=
 =?utf-8?B?SWtDUjhsRVF0OUR6NWlMenlJVEJXNDRnaUlpaWFKRkN5Ky9VQVM0Z1lHVWN6?=
 =?utf-8?B?WWQyMlNwZG15WHRXN0Y4elpjcVdqRllMYWVVd0VoVUl2M0RhNnlOV2lGNkdx?=
 =?utf-8?B?dTg1c1p3b1BpYlpGK0xyV0ZNdnkxRW5oUElVd2dGU2hRbk9uTk9YV1R5R1J1?=
 =?utf-8?B?dEdIOE4zK3RqWUdHMmhNWFVlL2taRno0TjliZTJWb04vNlN3VUZ2Rjlob2V4?=
 =?utf-8?B?YVJBcU9adWdoaGZ3Q3hhdHpROWJoSTQ0RnFpNnNZZUhXWnJBanRmaXZ0Z0U5?=
 =?utf-8?B?eVZxUFdObGRNcG8zUFBkR203VCtpemQ4OXZ3LzNFOURRa0UwUGlPQXhQTVFj?=
 =?utf-8?B?YUxrcC8yemtBNmtYRDI1UjI1UnRLZUZzK2JCZE1nTXF5RkFqdlpWMXc2L3pI?=
 =?utf-8?B?enZ2aHpqUnk4SmNhVUhMVlY5VXVVTmNpQmxpcnVtdWlXR01kckF0M2ExNDk1?=
 =?utf-8?B?eUEzdXlVZnZsdGc4cXpGc1kyKzFKUnJsS3lneHVLbGhVZXNGR00zTS9neU96?=
 =?utf-8?B?WkFCRjU2UjlVUVFDOEhZRUcvYkREby9ycXVIUzE1NU94cTJRUnJtUEVzSVNa?=
 =?utf-8?B?UFM3bnZSNEZDRmhGQXBCNFdGNUY5ZnA5aFJ4bU1RaWVLRGRNUzlqUU14am56?=
 =?utf-8?B?emNTeVFVd2FnV3QxSFRKVVB6VUdBWHR6eEhtTDZ4L3FLZjhDYzEwUDFVWUxU?=
 =?utf-8?B?Y3Iwc2VEMWpTcmR2RXFyYUNvckQvcWQxTTZDdUhyVWhQdnBJU05jL3FqdWoz?=
 =?utf-8?B?OTZTZmNLeWluYXhiY1o5a2owaGlwVFkxOW1ycFNRQkRRNE05WHg1RDNMTUJO?=
 =?utf-8?B?cENqUVlmQmlTdHVpS0FUSTJvUEdubHJNSnd2OHpZZEU3dUo0TndhZVJWMkFz?=
 =?utf-8?B?S2RacTFRWWZHWkc2RkxzNHFCS0FsWERjKzN6aHdhWDhmeHJHYmwrcWtTdHVi?=
 =?utf-8?B?WjB3RWZqVS9LNlNvYStzOEFOd0d3eXZQdGIvSWVmZXRCcjVlS3RZYlJzc0Ny?=
 =?utf-8?B?bjNPUmhyeGErRXpDZmZFQ3gzeEd2eTh6STlpclJxazRLOTN5Y29uQk1MaGI0?=
 =?utf-8?B?a1NhemxpZ1dDOUhzOHg1Q0wwd3dFM0ZWemRNb1dQOHRsQkFtclhuRGQ0VVBa?=
 =?utf-8?B?TS9jTG5GbFdyRmpzTGlrVzY3NUQzNFFzY0laVzZ3RTl2K2c1bnY0UnN2VU9C?=
 =?utf-8?Q?GTfs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9358dc-888d-43d0-99ad-08ddf50859e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 10:03:57.2696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CZRZ9sDJ9icQZj/VlKz8iHtBI/Uyb9vW3F/pdPDhUZCxF9nFlqyl3AywC1pSoiL70nSFrsHyDo7d01UHh0J0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6951

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhYmlvIEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT4NCj4gU2VudDogMjAyNeW5tDnmnIgxNuaXpSAxNzo0Mg0KPiBUbzog
Qm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmhA
a2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47DQo+
IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IFNoYXduIEd1byA8c2hhd25ndW9A
a2VybmVsLm9yZz47DQo+IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFBl
bmd1dHJvbml4IEtlcm5lbCBUZWFtDQo+IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBhcm02NDogZHRzOiBpbXg4bW0vbW4vbXA6IGxpbWl0
IHRoZSBtYXggZnJlcXVlbmN5DQo+IG9mIHNwaSBub3IgY2hpcA0KPiANCj4gSGkgSGFpYm8sDQo+
IA0KPiBPbiBUdWUsIFNlcCAxNiwgMjAyNSBhdCA1OjU34oCvQU0gSGFpYm8gQ2hlbiA8aGFpYm8u
Y2hlbkBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBzcGkgbm9yIG9uIGlteDhtbS9tbi9t
cCBldmsgYm9hcmQgd29ya3MgdW5kZXIgU0RSIG1vZGUsIGFuZCBkcml2ZXINCj4gPiB1c2UgRmxl
eFNQSW5fTUNSMFtSWENMS1NSQ10gPSAweDAgZm9yIFNEUiBtb2RlLg0KPiA+IEFjY29yZGluZyB0
byB0aGUgZGF0YXNoZWV0LCB0aGVyZSBpcyBJTyBsaW1pdGF0aW9uIG9uIHRoZXNlIGNoaXBzLCB0
aGUNCj4gPiBtYXggZnJlcXVlbmN5IG9mIHN1Y2ggY2FzZSBpcyA2Nk1Ieiwgc28gYWRkIHRoZSBs
aW1hdGF0aW9uIGhlcmUNCj4gDQo+IFR5cG86IGxpbWl0YXRpb24uDQo+IA0KPiA+IHRvIGFsaWdu
IHdpdGggZGF0YXNoZWV0Lg0KPiA+DQo+ID4gUmVmZXIgdG8gMy45LjkgRmxleFNQSSB0aW1pbmcg
cGFyYW1ldGVycyBvbiBwYWdlIDY1Lg0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnd3dy4NCj4gPg0KPiBueHAuY29t
JTJGZG9jcyUyRmVuJTJGZGF0YS1zaGVldCUyRklNWDhNTkNFQy5wZGYmZGF0YT0wNSU3QzAyJTcN
Cj4gQ2hhaWJvLg0KPiA+DQo+IGNoZW4lNDBueHAuY29tJTdDZTZhNzU4MDBkNjZiNDI4ZGMwM2Iw
OGRkZjUwNTUyZWYlN0M2ODZlYTFkM2JjMmINCj4gNGM2ZmE5DQo+ID4NCj4gMmNkOTljNWMzMDE2
MzUlN0MwJTdDMSU3QzYzODkzNjEyNTM5NDcwOTE2NiU3Q1Vua25vd24lN0NUV0ZwYg0KPiBHWnNi
M2Q4ZXkNCj4gPg0KPiBKRmJYQjBlVTFoY0draU9uUnlkV1VzSWxZaU9pSXdMakF1TURBd01DSXNJ
bEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUVw0KPiBGcA0KPiA+DQo+IGJDSXNJbGRVSWpveWZRJTNE
JTNEJTdDMCU3QyU3QyU3QyZzZGF0YT0lMkZuNWRLbzlFWmRPWTdJJTJCYUdrMA0KPiBvWDROJTJC
DQo+ID4gZFBaa3RIcnB6WXlEbGpDVzV6YyUzRCZyZXNlcnZlZD0wDQo+IA0KPiBGaXhlcyB0YWc/
DQoNClRob3VnaCB0aGUgb3JpZ2luYWwgY2xvY2sgc2V0dGluZyBzdGlsbCBjYW4gd29yaywgeWVz
LCBpdCdzIGJldHRlciB0byBhZGQgZml4IHRhZyBoZXJlLg0KDQpUaGFua3MNCkhhaWJvIENoZW4N
Cg==

