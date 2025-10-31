Return-Path: <linux-kernel+bounces-879689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EBEC23C08
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5705652D2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4332EFDA5;
	Fri, 31 Oct 2025 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="H6MkkCrB"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7523816C;
	Fri, 31 Oct 2025 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898380; cv=fail; b=R6Q+yiCzLA3/bfouXKB384pfBpc8tHhcTGAaAdWLpgDV14mrNGNPNnxPgxWX+M3icUdqabQygd96+PBURUSmN3nsc0olGhGGBc7272nOr0vG/vKwciKx/8MkgV4VRGcKGxxHWdEvueVZQPYzRvga173y3aeh45SB8geYnBgq68o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898380; c=relaxed/simple;
	bh=PNj2lnrHGmmw9wd8rfvFolZFHIS5cOpbxOBoAjtZZqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g4FS8ULWrhHI3cDKc8sK2z6CmmtugGJ2Lx9IvIqBRKyuC+jM5AdrHFoxF+14NmGnn6OrmhUITwildAQOeE0yVsVzs3yVWLRWh+x2bWuw2/WAqSnu0HTAEoUytVzx3h/d1W2YSiOWc+WuXlKRn3LHU8AfNZBJx5GSxj1tLzBxplg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=H6MkkCrB; arc=fail smtp.client-ip=52.101.56.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qK97trZlhiMSYxFdeo1kz2Zi+LWkh8KRZOtnYeb7AB7edRWunrTPgAPPaKoYB65I9Bi/O63cLlyRIF79oEm0S4RrB6GorMnl2hJlxalSds0p+j04F5HOJkcK2QwfPx7sNKxFQl4OUHJtRF+18OifBCrmWKzcqqp+g+VksuCcdIsIpx7yrawYNZy3XgOhIlAElWMJnK4+HlH/lp2N63Qsv4A3jdcCKxXt/bqgROfmAwEVZAaI1sDeJzcglNDLB2srRVIa8h/hdx6IQyZOflP9K8vU5S2Kch1IG7Dxg/8civWy0h7iTnLFGHRuFFczoG3SE5U30IM9H7F/4f5Xt1JOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNj2lnrHGmmw9wd8rfvFolZFHIS5cOpbxOBoAjtZZqA=;
 b=Vg93XS8peN7XO+8fVLv7PdUZNws+ipGUVtnRmI241uSSk7VbUyYiBxqPn0Q/n0mR1gtjecGlnDq/JN+2APaiWQ161roFZcW/I8U3X34tv58DAMCwi1k7bh/i+WaadLCEXmEKtlYpoaay4LJY8S50FFngWFJWk1Y9xmqJnkz0I2DICX396VYFnTc0h6Wd8SXoda9aSnzV4hg9lRTf+j4rDZBQy/sZ/4eSkyrG3UA7FdTKHAHJ63MRUieTvZMcdE1SEWv1l7shVcIFK7F5CQa+VSExKKKGYssAjqorgfKh9h+Ai3+IbsArOA/Nk4kn7rkOUkILWHlaETRglBH5EkpAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNj2lnrHGmmw9wd8rfvFolZFHIS5cOpbxOBoAjtZZqA=;
 b=H6MkkCrByRRSrRTfBIJoFTpDYkA2380xPb5Dxz4CKdikJjPX0JJ+z3rGJ1/4qFff068XGV7sXbpsMLKb3qb5eLyEG58YdL4AWCqqRZgRgk5FYE91CBMddIQzPXYkPha/Gqz1mPUISmj/1ITCEw+tuAaQ2rhBmGmkAXIh8lGdQFExDz/Hk7NPrACXGj2kR7Q/IXLVtr3dkjm5O0zpKr7W5oZfxV+M9CTwZPKtBGrov+zYjIDKgxcaMMiRPSN4xz7xhqw1hfDd04VtZX7qHVA6ATGYOXkF0Q9iNqEr3+nxLRvWXGsnRpS770dxXDHbWFEumrFTXMhV6dwOaaemD76wAQ==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by CH2PR03MB5270.namprd03.prod.outlook.com (2603:10b6:610:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 08:12:54 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Fri, 31 Oct 2025
 08:12:54 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Rao, Mahesh" <mahesh.rao@altera.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] firmware: stratix10-svc: add the compatible value
 for Agilex5
Thread-Topic: [PATCH v2 3/3] firmware: stratix10-svc: add the compatible value
 for Agilex5
Thread-Index:
 AQHcSU2Jtha/h7K0JUijtynbkn4VWLTaU1KAgAA8rACAAFMugIAAbmaAgACUuACAAANqgA==
Date: Fri, 31 Oct 2025 08:12:54 +0000
Message-ID: <858557af-f421-471d-a9e3-b7b44e768af8@altera.com>
References: <cover.1761648711.git.khairul.anuar.romli@altera.com>
 <08cacb9328c338edb6a6f291c56c6d2c32a9e0cb.1761648711.git.khairul.anuar.romli@altera.com>
 <20251030-wakeful-hospitable-eagle-9dfca1@kuoka>
 <6b3cb11d-afbd-4242-b215-a3a0230cffb8@altera.com>
 <32c35bd4-fc49-428c-9204-a39bda7cef19@kernel.org>
 <eef97a92-40ea-429d-8bc4-6fb22f05d2a7@altera.com>
 <47d6bf68-10a7-499c-8876-7e3f64e4b7bb@kernel.org>
In-Reply-To: <47d6bf68-10a7-499c-8876-7e3f64e4b7bb@kernel.org>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|CH2PR03MB5270:EE_
x-ms-office365-filtering-correlation-id: 675241ec-615a-4f70-4ff3-08de18554b37
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2hpZnVvMlRNZEt3d2YwRWFZSXVUT3lmNGlaZ3JOeEY5SDU3djE3UDBXUWw1?=
 =?utf-8?B?ZUc5ckhYb21EZnRESCt6Zy9NMEV4djJXcGlvcXF6YSszaXlkL0x6VElCeGRM?=
 =?utf-8?B?L1JkOExhZDJoVmdqVEdUWXlkbWpvWFhwR00zQUJ0MCtSQmREd0k4aS8wTyto?=
 =?utf-8?B?ZGV6QXpKZzRjSER2TUxKckJEbTFMeUt3YndUZnJUcnQ0VGNjVkxSN2dVQ2Qy?=
 =?utf-8?B?aE5kb25VSURCNFZuYkxUbHFZVFdYWEsrQVhGOGhnR2FPcytFNUJMSDFzUFVL?=
 =?utf-8?B?UmVLTG5LblptaDVZWFNWTkZ5WjVaS2RkS2RRZGNtV1Bxayt3OW40dlhhc2NN?=
 =?utf-8?B?Z3JyUUxaZUx5T25lMjJkNWdBbWRQVk5sdHFmajY1ZytHM09kQ0RQZFVtd2pm?=
 =?utf-8?B?RElHbTNsVS96blhLR1NRdDJ1KytTQkNjS1o4cmJtR2NkblZGVXFDY2xMUloy?=
 =?utf-8?B?ZFM2dUg1ZGFxakNuZ0Y2ZlFLdGZBMkNMU1YvVS9RckdVeHV3ekhlVDZZbEZl?=
 =?utf-8?B?NkltendnN1EyTUYrUGtsNmZ4SmN3YlVucDRmSVN2STRCRjRSQUNKYnBnTWkv?=
 =?utf-8?B?eGRxSHNWeG4ySThtbEQvNmdpajFCUVRMbnpKcHZFRldvOVczOTIzcFdVQUlP?=
 =?utf-8?B?c3M1bXppTkxiSlI2ZitrMWpYWGZ4bFlvSmhXN2RYaCtoalRtUHJwMHVWaVE2?=
 =?utf-8?B?Z0hOMlNiTlQ4cXUwalNMWUZmbFUyWGFmbndFSFpJVlpSTEIvVVRsbTFBbkNr?=
 =?utf-8?B?Mnk2QXowM21WOVV5V2I5MGRWNWhrOGtPQ3JoMkNPdm1KZi9nZ0c5UHM4blp2?=
 =?utf-8?B?Y2NXczhFZWhIcVJxUlNaZW13cldoTzNPbko2Y0lTWk4vMVNuQUF0RnJIWmgr?=
 =?utf-8?B?Q3FRVUxqdmMvN0M0b2F5clBPTDVzUW5NR0YvVlljeHorNXR3bmlGZ2RVTSts?=
 =?utf-8?B?SC9PV1lwenJ5ZVZBbjhDMG9MTDF3NmI5a3A3dnhtcXhUdUlNL1FjcGdCUXRN?=
 =?utf-8?B?R25sMWdRS0s2WTV6MS84U0p3UEgxa1Qxck5HZXNaWUdRbWxVU1k1eHp2Z2Qx?=
 =?utf-8?B?UXFKL0llaVZqQng1TTNNSFpyU1pMRUw3Tk1uRWlJbXowNWhMSnc0SHg2Ykth?=
 =?utf-8?B?SlBoc0R2dTlQMHlzdmNyVVNjd014QjM2QjBvVkVRTno4c1NqWG02UGZHbjZ6?=
 =?utf-8?B?QW5MeHZVVk1Bc2c0dnVVOHBtZWI3K0k4TUtEZ2hWQ3gxM1dramxtRENCU3lT?=
 =?utf-8?B?TzJzcTdpdXQ3Y1VyUW56SWcrVHNMZVJMenlaOWZUKzFvQVp3TXlXc3RFN0U0?=
 =?utf-8?B?Z0JMeTJxWGloM1k3RHhaT0s2dHlxa2xhVzlCYmh1bGE0bWhJcjkySWhRK2NN?=
 =?utf-8?B?UmxHemYrYldiTnhHSmVPekdPOVdUbW54OTR1d1EvWGhLU3BIMHMxVDdDdzRC?=
 =?utf-8?B?YU5kQ2xkbEpFeFpXNnAyd1NncmZlTk9VUjZzY3l1WS9QcUFtcmRQQ1Y3eWVv?=
 =?utf-8?B?S0pLRTRwbm0zOXVHVjIrcWpKVVB1ajdlZDI3SXdyUy83UWhaeXpXbTl4NUNy?=
 =?utf-8?B?Zkc4bkdRdm83c1VTcW9TdnU0Q3V6MXJVR1B0SUFMQTh0T0VDMExEMkxPVXlB?=
 =?utf-8?B?OU1TT0VMK0RpeVpHZkNUN3A5K0JjNldaUXhWeWlnSVpqRFNZYTlObnlrWSt1?=
 =?utf-8?B?WE9PSjZhQ0hpQUIxOVFZZG92Zk5VNE9nUFIrOGM3WXZEZ2ZTSWcwbHNyYWd4?=
 =?utf-8?B?VHNnVkd1bG01YXcvTXh4UFRGMWg4US9Rcmw3RkVEYkhrZWFSRitVSU0zckxJ?=
 =?utf-8?B?ZDhnQ2o0K001VDNWdkdZK1pmSHZGbEpvTHpqbnFXUHVyYUJoV28xaFpOM1Jz?=
 =?utf-8?B?TERHRmJ4S1RaMHhEOTVUMnA3RTZRdHpqbW4wbXJmazFCOTZhTUo5MFZsc1pY?=
 =?utf-8?B?NERTUXNFWUtvN05ONVRyNG1hb0k2NW9HQTA4TDZwUjdPWXNkdllOVlJHeUtQ?=
 =?utf-8?B?Yml6L0F3cU9wVFRBdVhDWW9ZelkxQktudXVTK3dsbjNLaDdmbzUrSzdEZUdC?=
 =?utf-8?Q?++dVyx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZllsOSttSXFldWZWaGtYZFRLUnIrN3EwR1NIekVraytQUGNLVnc2S0ZXc1hI?=
 =?utf-8?B?MmZPVmw5eHJyWGlrZHArQTNwTmZ6MlZQYnhEdGlmSEp3amxsNnRMWU94cHhH?=
 =?utf-8?B?ZmxONDVTM24xdWd5L1V0UXVmaDQrc2R1VmJaTE85YXhLQVR1TGJ4NFdSeTZ5?=
 =?utf-8?B?MkttRk5JckFGalpxckdyQU9uODdzd1VMWUs1Uk50ZkNwTGtibHlHMy95NkxB?=
 =?utf-8?B?bXRRVkdXMEcrcGozQVg5S0lHeTBWUEhsTWZsQnZDRjVXaGVFZElyU0xuZmlT?=
 =?utf-8?B?TUd1RG9GNFJmMkgxQ0R6QXhaMzY0cmtXNkhqbHV2bGpXbjZjUzVKN09ESTlG?=
 =?utf-8?B?UnBWWldoZlBmMTByaTlJWVJuVE8rTzBsTHJwd1RqMzk0YmEvUzU5Nzh2VXlj?=
 =?utf-8?B?bjVDbzFnRTJucW1veHZTak9yRlZvWGZ0Tm5QVTVuZzZYTml4WlRQQ2ZDTEtO?=
 =?utf-8?B?TTNyaHNTaDNCbCs4Szh3S2lSMldvT2UrYUg3a2FteEZHMERCR21IUFJiZm5u?=
 =?utf-8?B?MzNCZ1BROU1LRXRNNDc2T0pPeFpjZnNrTjd1KzY5dE5TMm52T2VwUDdjUFVw?=
 =?utf-8?B?cVdWSjRUWUE3MW9objl1LzJwKzRibE9tamV2V3ZtKzl0S2xYN211cWx0SWIy?=
 =?utf-8?B?YkR0Y2Zwb0NVU281eFV4OFY4VVQ4N3pzM1VldEtGY1dFNUY1VWRod1FZN28x?=
 =?utf-8?B?T0dxR3dpanp1Umx2QTNMVXVjb1RCZWk4VEw0bERrVTQvZ3B4NVVvK0ZaM0Ey?=
 =?utf-8?B?a3BOWTQxR3hMYzdQQ0VlVE9sSUI1S3FWN3ZXOG16aDFESzVESnE2ZXViZG5a?=
 =?utf-8?B?MlJrWm5TZFAxSUsyeGE5VjFsVmJ4U3QyL2NRMXhwZ3RQVmZOa1FwQ0JFbWRZ?=
 =?utf-8?B?eGxjOEVtcWJNVmFnUEppMSt1WG1WNDk2MllnRmJkb0wxRUZ2UDU0aEdlN0lW?=
 =?utf-8?B?VWptTCtpVEVuNEV3QVEwSHZ5a01wWEt4NGVWZS9FZ2xMTnhtUGU3UTNTYXJj?=
 =?utf-8?B?dmIyV2VjNG9MdEFlL0NjZEUxYjc2UC9pckdGY1gxZW5qNkkrUnp5WUlDbzVq?=
 =?utf-8?B?OFRrSUxRMVRmZ3NoRTJHbkV3VTFucitBRFFvK3dNL3A2UjlBUW81em5RR2JX?=
 =?utf-8?B?MmlmRk9TQjlGMXJTMzJaVGpaMGwwT0FCMFp2UGVIK0ZPUTY5L0ExNUszNE1y?=
 =?utf-8?B?UHJFN1NHcDZqUDdSajIyOUMzeUpGNGFsWHJzWkpmR1FxbjZJcFlrTjZiV0V2?=
 =?utf-8?B?R3VkTWN5MFI5YU9jL0xkTEsvSVB6NWRodXhOaUJ5aWxzK3MzbVUzQnVhVFcx?=
 =?utf-8?B?SFEzRUp3Z25ib3llSFBRd21kRHJnd2FvdExqUldIdExjdHdmaFFKMGxXQ0FP?=
 =?utf-8?B?enV0ZUt2M2w2Q0dna1BYU0RiTUNLL0JLMVJQWmhLbnYwTVFmMnJpZVBTbDBZ?=
 =?utf-8?B?ZjFHbXNsdFFCY2V2Ly9jQ2ZUM1FXTG9BRHd5alpldnB1cVJUQSt3WWd0aDhC?=
 =?utf-8?B?L1A2QWhKQkQ2eVVWaFpkWmdlSnhDc2tac2p6RGdsUmhkWU5hRFQydmRoemdk?=
 =?utf-8?B?RlM3U2xWUXNLakRWQmQ5Z2o5K0RUeTdueHQrbjdQYVc5aGdHNVhRYUJMbVo5?=
 =?utf-8?B?cXB3THRrWngyQWxwMzgzcTJXM2pYdnMvRElEVTk2WmladHZ4NjZXc0J1Wkpn?=
 =?utf-8?B?cUFQdEJrTXBHb3V0ZHRoeDdjV2swUXRrUnJ6Y3RvNkFzZEFQRHh3ZHlzaVJZ?=
 =?utf-8?B?Q2tCaGRZdWhOU3R0Rzc5enB0WUtlTVNkT0lrMmVhVW1mNEU1b05CRUtCTWFB?=
 =?utf-8?B?alZaVXNtbmJkTjNkV0sva2YwM3FWMS9kNWVzSC81c2tJU3dwU1BadHVsT3Iz?=
 =?utf-8?B?ZmVrbm5WMHlCc3V3R2Q2ZkVwb1VGQm0xUG9YZFFaUStZeUdRcmdwWWFTcnVI?=
 =?utf-8?B?OEtCRmtHbmFZeS9Zb0xsa1BjU2NBTzRsL0Y3NktCOW1KM2oyZThlbHdYWnJJ?=
 =?utf-8?B?eDh2YUZPS285NVBUaTFlNUhUdWdDRGMwT0crU24zMmRjd3RnSEdRR1J5ZzRN?=
 =?utf-8?B?RXg2MzVjaU1hVmJNeFN3YUhZYWRNNlVTYmFqUGJMNkZBOG5HaFJJWm0vaGlz?=
 =?utf-8?B?K1V2eWw5WUZoYlJqUlFjM1R1MWhKeSsyMkdyZDZjbU1QNzZBWllzTG96UWRN?=
 =?utf-8?Q?f3dK6Mqhg0OTLr6ExMHmuMI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4F70C7E94414E4A869F370C476D5A50@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675241ec-615a-4f70-4ff3-08de18554b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 08:12:54.5668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/fYv4UoZd741PngSK1zOnq8b0VDCIEFggJpDToksEj2KEgwsUSQJhet5OACKTxiVprhAVjC9ZEfIEGu3/6xNv1xph1uSOvLybfzsrnmR+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5270

T24gMzEvMTAvMjAyNSA0OjAwIHBtLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAz
MS8xMC8yMDI1IDAwOjA4LCBSb21saSwgS2hhaXJ1bCBBbnVhciB3cm90ZToNCj4+IE9uIDMxLzEw
LzIwMjUgMTI6MzMgYW0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4+IEkgd2FzIGV4
Y2x1ZGluZyB0aGUgaW9tbXUgaW4gdGhlIGN1cnJlbnQgcGF0Y2ggc2VyaWVzLCBub3QgdGhhdCBJ
IG1lYW50DQo+Pj4+IHRoZXJlIGlzIG5vIGlvbW11LiBJdCB3YXMgbWVhbnQgZm9yIHRoZSBmdXR1
cmUgcGF0Y2hlcyB0aGF0IHdpbGwgaW5jbHVkZQ0KPj4+DQo+Pj4gUmVhZCB5b3VyIGJpbmRpbmdz
IGFnYWluLiBUaGV5IGNsZWFybHkgZG8gbm90IGxpc3QgSU9NTVUsIG1lYW5pbmcgdGhlcmUNCj4+
PiBpcyBubyBJT01NVS4NCj4+Pg0KPj4+IEJlc3QgcmVnYXJkcywNCj4+PiBLcnp5c3p0b2YNCj4+
DQo+PiBJIHdpbGwgYWRkIHRoYXQgaW4gdGhlIG5leHQgcmV2aXNpb24gYWxzbyBhZnRlciBnb2lu
ZyB0aHJvdWdoDQo+PiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvd3JpdGluZy1iaW5kaW5ncy5yc3QNCj4+DQo+PiBPbmUgcXVlc3Rp
b24sIGlmIHRoZSBwcm9wZXJ0eSBvbmx5IG1lYW50IGZvciBhIHNwZWNpZmljIGNvbXBhdGlibGUs
IGRvDQo+PiB5b3UgYWNjZXB0IHRoZSBsb2dpY2FsICJpZiIgc3RhdGVtZW50IHRvIGVuc3VyZSB0
aGF0IHRoZSBwcm9wZXJ0eSBvbmx5DQo+PiBmb3Igc3BlY2lmaWMgZGV2aWNlIGJ1dCBub3Qgb3Ro
ZXJzPw0KPg0KPiBZZXMsIHNlZSBleGFtcGxlLXNjaGVtYSBob3cgdG8gZG8gaXQgKGFuZCBwcm9w
ZXJ0eSBpcyBhbHdheXMgZGVzY3JpYmVkDQo+IGluIHRvcC1sZXZlbCkuDQo+DQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9mDQoNCkdyZWF0LCBJIHdpbGwgc2VlIHRoZSBleGFtcGxlLXNjaGVt
YSBhbmQgYWxzbyBnbyB0aHJvdWdoIHRoZSBhbHJlYWR5DQppbXBsZW1lbnRlZCBiaW5kaW5ncyB0
aGF0IGhhcyB0aGUgcmVsZXZhbnQgY2hhbmdlcy4NCg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMs
DQpLaGFpcnVsDQo=

