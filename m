Return-Path: <linux-kernel+bounces-673240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F51ACDE8C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 15:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B496A3A68BB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 13:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D2928FFE1;
	Wed,  4 Jun 2025 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="WkIu4MXO"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023080.outbound.protection.outlook.com [40.107.44.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DAA28FFC5;
	Wed,  4 Jun 2025 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042445; cv=fail; b=gsuQSmk3PB97pr4Mkm9XkT8lIiENC7qatLxDxoZas9afs/yfz4gnQWCy6uw6ojb2C1LcZ4GXIn/rWZmpQGTbQ0NV1GhpWT2U4xBct9hoOiFYjJ7nPK6/zoAlQ8CGUpORtYBdYrqLYNHFNn/tyZD2VMgu8vbYW842MzfiHOmcQnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042445; c=relaxed/simple;
	bh=6jVnkjT6e2SZXWSCKEXlSFjwyyqyFjvjocdOvctZ5Qs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oEWsLPFeXjoUvJyaBllCUSsqdDUTMhdWWtLwVq2h6yq8Q2M78be+ObKG3amMVVQbeGnyLCuoURl3bMEjhZncKEoVdDqx7iTlq8NDb1OYxlHxevCLZgvm7WMHjcRqI2QyPwyt7RFL3gj/tvBNXl+vBUl6pG3b+/o+KRviK+ZUFhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=WkIu4MXO; arc=fail smtp.client-ip=40.107.44.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hT5IkW4ggCpbeDCl19cx1ctmIyBtudGSrWFPk1c8Ur61zyut7ouS/yCG9TL5tZO5+H0PxRNJ1+zvcmgzGPwiXjk8ofedwEBOx8Wx1UnbTn1y8OArdnzpFIKBCLH4Bfzk22d0wS/pUsz5f/4QWOe1QOih2474SwvYx4zpFfNVIUWxn5qME1MGd4RIt7fT/AKgN5jn/rpCbMtklJj61nQZuckb/X/CHU2A8I/nwfL39nsub/UA9Is1VzFLCOMOnAIlvwzoWepulwSog6zeznDk71doBJVLda/eDPwHsyLmbX5z/520YMgQjaEqpCEWWM2nAQQdpIecqEWCmhJohO+mHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jVnkjT6e2SZXWSCKEXlSFjwyyqyFjvjocdOvctZ5Qs=;
 b=h6AFH9l1F1U80RetjQTGox9zy+hF7BrkVg8nuVD139DR3NVFFEE6p5BrST2zdXpRt62OUXhMD1dZBr8ipjr1jErSIJCmuax/L4QWjt+qMvUCgMaq2sDydljx3Ebxfyg9GZ7FsWlKJLDq9yG9/hPIGYdOwGeZU9mgOnVIkD3Mvq+pRnbmJHe86Lq4yO8mSt/X8mlY0g54UlfT/2uRrA7HG8qUafMNNLsi40kK3QO/mfN1dx1JoMPrHYhp1PX2/yEEB+kVqn9IeZCT0tqqCinQUzLvYVRyf8sOaofkXSddxMCXiPGvSbqET9mJPpbZo8EV0vLXUIIukybgnoQoZa5FEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jVnkjT6e2SZXWSCKEXlSFjwyyqyFjvjocdOvctZ5Qs=;
 b=WkIu4MXO1gNVnKLStBaN0CeiT9PfrWMA25q7J8SctQu93hN87yaZXEBV5nr8KFz9t59fcUmqN3K5QVxX0ZVjNK6uzhVK4MIRp6DQUA6tDTLfmeH7t05CiQZjWI7UbyxPBJe26qrQxJEbXP/hPmsagEUSmW6D2o066IGUW9g6RfGsUvSWTNHE0gPar6GiCEJv0zhR64ZOVXPVQ5G500jmshvA6omxVwzkc1JgOpnEiPIWD6ib/63N/tFzkfVK9VsenE/WVEMnv607Y0lZh0ABhQ/YZDKSJFwi7MbFZqa+k/C3ewqnxJjNF8pA6yDnPYvGQbNVW6AsAsffiBUEYVLM5g==
Received: from SEZPR06MB6569.apcprd06.prod.outlook.com (2603:1096:101:189::10)
 by SE2PPF9C0841AEE.apcprd06.prod.outlook.com (2603:1096:108:1::7e4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 13:07:17 +0000
Received: from SEZPR06MB6569.apcprd06.prod.outlook.com
 ([fe80::e0b0:e0eb:f378:e316]) by SEZPR06MB6569.apcprd06.prod.outlook.com
 ([fe80::e0b0:e0eb:f378:e316%6]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 13:07:16 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] ASPEED: Add mailbox driver for AST2700 series
Thread-Topic: [PATCH v2 0/2] ASPEED: Add mailbox driver for AST2700 series
Thread-Index: AQHb1VAJRfMyqLL9+Eu9cibno2aoCbPy9e0AgAABJjA=
Date: Wed, 4 Jun 2025 13:07:16 +0000
Message-ID:
 <SEZPR06MB65691F4A1A28AC189D38A55EF16CA@SEZPR06MB6569.apcprd06.prod.outlook.com>
References: <20250604125558.1614523-1-jammy_huang@aspeedtech.com>
 <e967473f-f1cc-42d8-9786-437f52db4162@kernel.org>
In-Reply-To: <e967473f-f1cc-42d8-9786-437f52db4162@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB6569:EE_|SE2PPF9C0841AEE:EE_
x-ms-office365-filtering-correlation-id: bc481d65-4941-4ae2-f875-08dda368bb36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmhhRDJlcFZZblIyeUpmVnVnYmQra2VNNm9WM2ZKV1pJbWpyRk5jdkw2RXBV?=
 =?utf-8?B?UXBLRUdjenBPUkIzR202dHM3T2NZVGtRcU9KdWVkOVQ0UkMxdnRjcXYzSnVs?=
 =?utf-8?B?QzhhZTBzVWF5d2hONTZvOFU2a21LbmMwbjRuWHlBdVNFL0RrVlNYdEdJZEFR?=
 =?utf-8?B?YWNaYnBqZjUwaWR2R1ZtRGl1RFl6dGVnSVc0QVNjY0szZWYyMUZ0aEtybnJB?=
 =?utf-8?B?d1FWemE4ZnIzVmRjcDBLOGprZWI2TVhSRnRSaEF3dmdIWFZYc2dBeWpyUVRK?=
 =?utf-8?B?VnRzZlV3bUlHSVlyV3prdWFEQnJEUXd1Q2lPMWp6YTV1dWxSaWhEMjUvOHlK?=
 =?utf-8?B?Tms1VVZXalZiN1hrQnp5TlBWdXJrK2pGSEkwT2xOL3RlYUZ0ZWRMQ3BsNlAy?=
 =?utf-8?B?UVNvaVlFZDNqVWVpSWRwcVFkSWlRbjZncE4yWjlQb2VwM3RjOFIydzVOVnRF?=
 =?utf-8?B?Ujl4bjFEeGRvek41SlF0b0k4ZDBkQ2w3WVpFcTV2eDh2SWVHMWxsVjJHanhH?=
 =?utf-8?B?d0IwUEdSTTdITkcrNWlvM1dKSEpKWkRIVmI2UlZEQ21UR0dINS9HcTg4UGEy?=
 =?utf-8?B?OW9KWnUwYjYycTJPeXYwbUozSFUzbnR2OHNuTDQvSTZCT0YzbUVtRS9QdzN6?=
 =?utf-8?B?V0VsTzdxbVNiZjMvTDdCRHNnL1N1eTBIcVVrMFViVlIxcUdUemNpZitQQkdE?=
 =?utf-8?B?RWYxaUVjNG44YzM4ZjdORXBqeXFmM01YWVBtWlpzbjgyN051NGJVMkU4TG1k?=
 =?utf-8?B?Slh2bko1VFN6VGFmL0xvd0FSNHpQUUtrWnZuWUlUT2tJZ3FSYm1jMVF2SExB?=
 =?utf-8?B?dHlVZEhqSE1FU0FlS0d5c0YrRngwa0pld3psNVRtUGlPemZ5aGlWVW0wK0g3?=
 =?utf-8?B?UTV1NTNaS29LaFhiNWRzMCtHdWUzK3BFempNWFhhVm9reUlON1NTV2w4T25Q?=
 =?utf-8?B?ZzdXN1BmUExYZTdXNkMxMnl6VWtoSmVmblprelpRWW1iL1B2YmZGSVBscThx?=
 =?utf-8?B?bE4yR1BSM3h1V3NiR1p1YW5XMUlXckRqL2ZBcFBYRmdyeWE5TlNHS2tEYWUx?=
 =?utf-8?B?YmxQa2dsVUI3NVYzQ0hjZWRqdzBNQVRuQXltRkg3aWdabnAvVEhCN1ZFWHdW?=
 =?utf-8?B?K3NYdlBJaEJKYlVqOXdnQkFucWZlbDd5OXREYmtBNmoraUVUbzJXY1BBelN6?=
 =?utf-8?B?M3hOVkVLRnVXRjVSTFdpQjZZbnVaSERMOTkzM1lnK2JqN0hRK25OS1FYbzgy?=
 =?utf-8?B?R1lhUHFJWFNiYTk4Mk82SjJPVERCRVpONWEzV3ZTaUNScS9qWmwwSmVLOGRP?=
 =?utf-8?B?WEcwT2NrMldjME1nWlhmTGtHdnluaDdzMnI1NnZHZ3FTVkYvR0ZmR3h4RUE3?=
 =?utf-8?B?VEN2ekZuZC9NYVBZSFYxK2tqRWlXNWtDZDhzWVYvMWxJU1Q0Z1ZtUnl0NDVC?=
 =?utf-8?B?TVIwaGp4Rm9TTndMS2xpbHBVVmpPNkczSWpDaHRSeGRQK2tXTzRzV2NjOC9w?=
 =?utf-8?B?R1o3L3V5L3pYRFBZbEdTV3l0OUYwc0ZyOFdqVVVwNHlhckxUU2ZYR3E3N3Y2?=
 =?utf-8?B?ZU1mWDlGOWo4a1NnUURhb2daTjlsckVjSUp5ZWl3Mmx4RjhEdThjbVpMSVIr?=
 =?utf-8?B?d0pJQmhlU1c4RmZya29FRElLamtLQ1A2cVY0STZwUVdKMXNMWjVnWnpiaFFz?=
 =?utf-8?B?NzBqMm5QQTJIbTlKUWRLMXYyejdTMTBPVmNGZHkvZDZkVWVLb0ljbFFRNVRX?=
 =?utf-8?B?dFRSb1lLRFU1TTJsMDJjZnVXYmMvZjZBelVoWnVKOHFYTjZnTi9HeDJ3T0Mx?=
 =?utf-8?B?SGp3b0JhdFlCdUdOMTZwNkhFQytlYm9RZUtaSy94Snc2ZGRiWlgxMTNTWk5R?=
 =?utf-8?B?UlllZ0xVbUdOUXd4RWVHdHNDWXVzUlJ2cUt6ZkVueEtBSW1FSGkvcjVZVitp?=
 =?utf-8?B?S1BXNVBoSG1JMGlRK0hZQXR0R3RpVmtDZGo4bWtuMTVRcXlDOFlCSUZCS2Z3?=
 =?utf-8?Q?UvMGOIQSEgACyiGFWZ7hN2LJYQAasw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB6569.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDFwUHlqVTlLWHRsVGF4Vnc3OVdJMTZ1aVIrdWlVaDlINW5BTExiMDVhSDBC?=
 =?utf-8?B?ME8yOW5WSjBKNHowL05kcVhnOXNUaFdHeGFka1Z5ZExzZGpRbVo3TWd2WExa?=
 =?utf-8?B?cFlhYXpNTFMrVkZzN3VBT0FEUXhqaldpYnkxZmlCTjN0SWJlK2tyK1BWcnJU?=
 =?utf-8?B?L0NQaERsNmZPbDJCVTIwVVQ5RVI1SGNSVUlxNFVYRW9oUlRmWmhNN2MvQnRp?=
 =?utf-8?B?L3dIRkhqZG90WjNIQ2RoTTBCd0laOWo3OWduNjIyWWNwb3Y0WTgxRnJFL0RM?=
 =?utf-8?B?azkwYk1zc3YvcTA4a2lNNXNXK3VqUWdqTkkwVzRVTWxkM3h1ZXhVSUt3b05H?=
 =?utf-8?B?YnQvaCs1b1YwcFdldlBwd0RkQWhFM0dORytvVW1rUWZtZUROZHhjV2YxRENB?=
 =?utf-8?B?M3E1VlNVYm0yRVV0bENBa0lINEwxM0srdVBLMldQcVV3RG42eXJiTkpla1Na?=
 =?utf-8?B?d2ZjVERacTVFaVNYSmpKMzMzZHRaWXJCY1BZWGVDMHJadGo4TDhXakYyekdX?=
 =?utf-8?B?YkZGZHIyeEhCZEhBZEtaWXB6enVSNXdtYkpVd0RGQVhZMVJmRnAxL3p0NGNh?=
 =?utf-8?B?bysxVDExbEVYZG5JNGRZMGdvMVRsNDliVnVxV2wreFpVYUV5NnhCN1YraFJw?=
 =?utf-8?B?UFZpR1pIUEs3TmlOaCtZUlNRRDVEVDVxMnlLMTBCakd1b2Z6SzFvT1lZVDRK?=
 =?utf-8?B?a244L2hiQmVNWlhKQytXb0hydW84MG9BbkVQZWRPODVuNGxtbEZZZkhmZ2lC?=
 =?utf-8?B?WkRNN0Y2YllsQTdUbExZUDN2MDl3QWNIZE9SRER1WS94blA3dmtSVVFZM2d6?=
 =?utf-8?B?SXBCRVlPd3ZSZU1FcmVWQ0JrcWI2aURJcXlnT0p2blVBWkM5NEdsNHJrY3JU?=
 =?utf-8?B?bTBBL2F2ZlQxS0lnckxNUDRPMkpOOUpkMDRCUEtRdzVmVUtySFQzSWdDN1RD?=
 =?utf-8?B?dzJFNzhnd3JDVmdCajdXL0w2R1pKQk84dkdnNERQdzVReUxrS0tGNEhIUW02?=
 =?utf-8?B?cDFTdDNSYkVVTlR5Nm00Y1RhVEo3V0owcWhXWTlxZnZpYTFNQmpzNkNsMytl?=
 =?utf-8?B?Y0pkc2FudGtJQkhzTzg5Y2RMWmdmMmdhUHE4Rmg0K3p1bFQxOWdwUUc5dDJG?=
 =?utf-8?B?T29UeUpaS2VWMXVrblRFaFUrK1FKNmtKQmxXbmFkS3I0b3BXeUc2Q1lHOU15?=
 =?utf-8?B?c0JjaHd3Q091cUVhNHhrTHlXZ1VNQUhJUzAxYlAyTGQ0Z3dxVVQ5TVVZazUx?=
 =?utf-8?B?WXNYQWNTM2F5R3lucUZoMWZ6dWpIMlZpT2RaelFSRVRGaXFCMnZWM2J5OUlH?=
 =?utf-8?B?TU5Fcis4TzRXb1J1ZjFWMlRjNlFQcGpiMUVENWsvWExBWGRKYVNVMHFITklP?=
 =?utf-8?B?ZWF4eXRMTWdvUTkrWSsyVG9nTytXV3FLeFd3MmZDNC9JOUF4REx1UkNnc1RS?=
 =?utf-8?B?V2VoN2Y2b0lDMlNka3U1VXNLbXlvVU4vS1lIUHVGOTNaY0dyaVJCaEh5TnVt?=
 =?utf-8?B?MjhwM21PZ0VRTkEzRjIzUld2bWlaZGN2OS85SVpnc0Z5MEFpZ2U4OUYxZ0l6?=
 =?utf-8?B?eEltL3JORHg2aE9NNTlReURSY1dKYlFjVjBmakxLY2h1elpXODcwTGRZTW5K?=
 =?utf-8?B?ZnhEdk5KeVZheHFORzlzSHh6TmRJNVFXWEswQTAxRFZ2RFJ4d3ZJYytyL1J3?=
 =?utf-8?B?MEFOL0lFTDRSM0xPS21IVnA1SFplNzZvTkJUUGErblZiU08xTkpzVlRZSXZC?=
 =?utf-8?B?NzQwRzdLQy9ObENvMWJ5TVJVWUhTdS9FUGZsUjlCNjhMK3NRdktPWlc5YkdN?=
 =?utf-8?B?TDQweHhVK0Z1MWdYRkxON2o0ak5uSm9OQUZ3d0c4aHhVTEd6WHlsd3M4QTVT?=
 =?utf-8?B?T0ZuOEQwbVI5WjM2dTJXTzFEbzNjcnR4NTlBL2xpaVMveXNhNkJFM1B2K2xL?=
 =?utf-8?B?dW9KcGtTQTVaSlRVN2lIYVdVM3FUT3FEUXVjWk00c3VWbTdQMUdpdHlWcTRj?=
 =?utf-8?B?U3o4d1JrdkJSNUluSUF5NWFha2FOY0JyV2ZHbDBoQkxXc003MG5iRnVzbFJZ?=
 =?utf-8?B?NGpIa2dwMXl2cFI0d2VFbC9DelVXUFJkZ29TWjlSTWRtSndkTi9wNGo0eC9V?=
 =?utf-8?B?YXYwOTdUSnkwV09tUmtXM01Sb3Vzb1FkQk5XREM3VkVoeWo0Q2ZSQnE2anZL?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6569.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc481d65-4941-4ae2-f875-08dda368bb36
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 13:07:16.9010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gE4xtAj0AzdtUurpFeES4ecoe/2apsumkkBCfbDoIQ+Gy4MvpeQwIauv0RwXeP0/rQMUku8F0LqIK7/SNFQ7oxDzvMajcPJQT6zR9mggzCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF9C0841AEE

PiBPbiAwNC8wNi8yMDI1IDE0OjU1LCBKYW1teSBIdWFuZyB3cm90ZToNCj4gPiBBZGQgbWFpbGJv
eCBjb250cm9sbGVyIGRyaXZlciBmb3IgQVNUMjdYWCBTb0NzLCB3aGljaCBwcm92aWRlcw0KPiA+
IGluZGVwZW5kZW50IHR4L3J4IG1haWxib3ggYmV0d2VlbiBkaWZmZXJlbnQgcHJvY2Vzc29ycy4g
VGhlcmUgYXJlIDQNCj4gPiBjaGFubmVscyBmb3IgZWFjaCB0eC9yeCBtYWlsYm94IGFuZCBlYWNo
IGNoYW5uZWwgaGFzIGFuIDMyLWJ5dGUgRklGTy4NCj4gPg0KPiA+ICB2MiBjaGFuZ2VzOg0KPiA+
ICAgLSBVcGRhdGUgZG9jdW1lbnQNCj4gDQo+IFRoaXMgaXMgdmFndWUuIFdoYXQgZGlkIHlvdSB1
cGRhdGUgdGhlcmU/DQpTb3JyeSwgbGV0IG1lIHN1cHBseSBzb21lIGluZm9ybWF0aW9uIGFzIGJl
bG93Lg0KIDEuIENvcnJlY3QgZXJyb3IgaW4gZHRzIGV4YW1wbGUuDQogMi4gRHJvcCBkZXNjcmlw
dGlvbiBmb3IgbWJveC1jZWxsIGFzIHlvdSBzdWdnZXN0ZWQgcHJldmlvdXNseS4NCg0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KQmVzdCByZWdhcmRzLA0KSmFtbXkNCg==

