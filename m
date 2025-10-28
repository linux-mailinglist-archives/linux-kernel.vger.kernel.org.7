Return-Path: <linux-kernel+bounces-873624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA33BC14476
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D08465074B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B901B27FB2B;
	Tue, 28 Oct 2025 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="d6wVYUDp"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C17246327;
	Tue, 28 Oct 2025 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649292; cv=fail; b=g3dJwIV1L3hiLL+hUB+fjU6luiQ36bM3Ei2rrlYHJbsst7pVr3aTaW5Iq2DrXH+unRtXHC8kolZdmOUkAcboJrpa/9976TupyrC/O+PgILg0X6oNpyZaT1XYYHizO3cY/QXmkbbI+ds5Aeh/m/ILp5BAwlDU961n4Ye/OYv7EwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649292; c=relaxed/simple;
	bh=OlsknaL97gT4a37UCaS2/7hG4f5uXZhGBNIBe8Lcigk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K1TXcRXR00Fw9FSxOkR9xonCKgzhVGNJiJo8BnF4Shza6n3TPauskLtTNv0MOPQIu9sgDW9Nndg1v3fBoQjQ9qEvzQReY/HjvXFndRzp2Ucqlv3USQanh3Jnr7H3y4ta1qdOH6WYI4gDFmUxHpxDIfWB+BFTLQ2nbU6iB9AP0lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=d6wVYUDp; arc=fail smtp.client-ip=40.93.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxM+/unvnO8RLQ/zwN/+PpdHJP2+giLGlm6zy6b7KoeRP1QmJxKJVqACMz924MXvXGIzfwC1nZeRRAOJkvqZOU0ok4QdBNOZk9fxYhfIQPcIQgM+lGAsAPxH0xGzsNgDyLETn0HY7C/qv26XWbpM39J13vHxQB6r4UiYmTN7nLe626uobvY02Z2/vbJnApK0ZgQS8ImweHsYPK3QSkjkLFt7yqKVjrXT2U1tbTR4D3PcocROwgvEiAM53BN495iJ2jqLziolCdq7DxiVMLKodcqk5BXtdY6VhhR8TgJU/DD+8uTBYuLYYegCvpftfccXOUdK9yacNewyemcScGCUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlsknaL97gT4a37UCaS2/7hG4f5uXZhGBNIBe8Lcigk=;
 b=UArSdPRJEDpQHagXLKdpzgp6tR3+Eg/qjWiqxThj+j/08oEOqCBFd16k6zulvhrhk7WS0P49mDmocnmmfZ30+In5XdG/dYtu2F4sVkQpY/PwrL7YVqSa8SjGX1UNjpCIFkqmlsqXAC6kwainEpJm8seO62BSmtK06lvleAB2Am0MZ8JZ24J5v0flovEhF+LCwIQ1BlivY1pu+uDaccYp/NiAqs4Yd8qxGPiYz5Y1CqByhy5Xeg8YxQNwm/aR8crbPx0zmAB4LP9MGj92iG4chBTvEOZhU0gV2dd/eYoCOJC1z1JmC+wcumZpZJ9c5HBtsHt29X3w0FNIdRcoLRZv3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlsknaL97gT4a37UCaS2/7hG4f5uXZhGBNIBe8Lcigk=;
 b=d6wVYUDpIJ/n5QidWPIAVuZUebLnXlzxwhAE6hD3S7stsee37R2gTy0/6d6NEZeMHQ0Ns4V/rWLktndlN7+7ynVOfkErFVNK+mHKmRQs+bA39wgbtgcRpA5TS3VTeaKiJZ8Cf82FAvriCaE1RfqBIHA+nAT9LSmdh3SgvUyyN2gop4qNm7dXMAV0p3/S1MGNEkrRq8qscsKyw2St9ItMsszJoktMlZi/YfxQMjad1UWAWNGmrujobhWUUpnsL5cdS//9D+cZDXjtURB7q/ljmmr0nIzZyr4b+0+z4aZGspf08P9Ku4Z1hPDb+Esm/LLBjKcQMhkaAHE9vDbbsKPrig==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SN7PR03MB7258.namprd03.prod.outlook.com (2603:10b6:806:2ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 11:01:27 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Tue, 28 Oct 2025
 11:01:26 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "Rao, Mahesh" <mahesh.rao@altera.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: intel: Add Agilex5 SVC node with memory
 region
Thread-Topic: [PATCH 2/2] arm64: dts: intel: Add Agilex5 SVC node with memory
 region
Thread-Index: AQHcR+1RFc/Wn5aMBE6dhUnJql36X7TXTMOAgAAXyYA=
Date: Tue, 28 Oct 2025 11:01:26 +0000
Message-ID: <0e80f035-00b4-4134-a877-7253dbabe5b5@altera.com>
References: <cover.1761643239.git.khairul.anuar.romli@altera.com>
 <a3182556c07839dcd9227fa6a4a9d295507f3e8e.1761643239.git.khairul.anuar.romli@altera.com>
 <0d9895d1-9c4a-406f-858f-fcb318b9f04b@kernel.org>
In-Reply-To: <0d9895d1-9c4a-406f-858f-fcb318b9f04b@kernel.org>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|SN7PR03MB7258:EE_
x-ms-office365-filtering-correlation-id: 6f4ea54f-21a4-4615-3d25-08de16115738
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q1dWaHZNM1Q1Ty9YYTh1S0dxa2ozMlBoc1ZxZXF3S2x0SGFCck9UNFlhWjRT?=
 =?utf-8?B?ZERKeG9pMkM3N2tSL2RyNU9EbmtHZEFCY3JiZHRDZGNDWTAxdExtTWx1U1g0?=
 =?utf-8?B?MHJYaUhlbXUwYnJhUS9GSFNTWmYwSldKV2ZYU3lTMitOeU15dlMvUEF4a1ho?=
 =?utf-8?B?alJ6bjZzTjRzblBtMlZudmhtQjBndFI2bXFGYWtONStqQjMzMWNvQk5kNm1G?=
 =?utf-8?B?TnFqbE1RQ01UeVZrM3M5UGFsUkdNa2xMbEZmZ1dGdThZVXcxdEhqRzcvZjdw?=
 =?utf-8?B?a1hyMWxPdE90N2Z0REV1aDE0Y3dTRlBaTEJibzRqeklzNTVicW1WbFdHNFdt?=
 =?utf-8?B?aFFkczNaYlRiRGxYQUgzZlBRR2RBK05pampZUEJKNUNqeXFkVlBkSjRxclhR?=
 =?utf-8?B?bGp3dHNBVTl0Mi9YWFV3R0NRK0ZXZ240M1NrUDZVd0RvaUwwK3dkV3B0N2c4?=
 =?utf-8?B?aFZlbmhmeTlZU0h1RUZPNHk0OWVEenNTVFFZUzZ6OGNKS2h6RzNBM1BVWG4y?=
 =?utf-8?B?QXBHRXk4dVE2RGhLbVNyR0JEREtDYXNHdFcxQ0plWFh1Sy9zOS9HYjRpbGxr?=
 =?utf-8?B?NWt0QWZGM3l5V1k1N0VOSWJpbVZpZkRmN3JMTFhtQnVnOHBHWDZSc04zQXJr?=
 =?utf-8?B?R1BOT3RHbnN6WHhuQ1kvWlU4akdnOWtOVnBaTGRCeWpvbTRDeC83RUtvbStR?=
 =?utf-8?B?dnU5L1M0MVE5NnI2SXhsclBSMnI2SVdobEJLY013MUNvZVYxQlFySnRsQm9v?=
 =?utf-8?B?TGFFOUNFU3ZUcnJzdktQWXFtOUs5NTBxV0ZvdnN2QkZrUXN1VTBQRUFheU5V?=
 =?utf-8?B?Yk1oaHA5ckV5YmxwcFFUK1FpOXJ3czQ4MTIxU3paTGxEWmU2aElwNnV4ZjBl?=
 =?utf-8?B?OE5kZ083K21GZFovSFVqakJ2NGxVdjlMb1lZanRUaEJNZVhSZzhEOUYvcEt6?=
 =?utf-8?B?UEU1NWk0Q1lPQ1BGL0h6T2pEdWhGMkJSdjJaUVN4ODBoMlFoWFE3KzNZUUxi?=
 =?utf-8?B?WGtHTmR5UHVaSFNUd3pDOE9UejEzY25kRHJVR1FSMTlTcGZ0U01qTzFWTEh3?=
 =?utf-8?B?SUlBNmhlRlVadUVoSmtnRU5MZjdDWE1uYjRTcWN1Q0VKNTRJMkJMZ0FJNWYw?=
 =?utf-8?B?NzdlQ0taS1U0VytJbW43SEJVejhWRkQzVjkxWXZYUkhFVzRKTThGMXg1enR2?=
 =?utf-8?B?RW5SenZ4eXUxbm9sRjc5Rk51ZERRTFgwTjlRdnpCUE1JM2FwLzFMKzZLMGhI?=
 =?utf-8?B?a2ZhNnJhaDFlNG55N1NWaDk3YS9NWjduMHM3dmgveUVITm5DZ1RiOEtMeS8w?=
 =?utf-8?B?WFl4dWU0SHN5d1hyMnRXbzd2ckpVMGdFdGlSYlh6dWcrQ2F1MDZLbWhrQ3RV?=
 =?utf-8?B?NCtPaXBSNFhFQUN0U2JjeDU0L0h0eXIydVBIU09xczVjMmdxc2p1eTJsejJw?=
 =?utf-8?B?ditsZ1FqbjBxU3hVRWtuVXl2Qjl4WURYTlcrOStscnJLcCtlcEd4RmE1bzJ0?=
 =?utf-8?B?eGxlbyt1NHpLYWttd2prSXBHVkFjYlVxcjJHMGRnZXNkT1h0cElYZVVtc252?=
 =?utf-8?B?S1c1YW5jUE5xY1lUK2NHVkVJZXg1QlpqaG8rN1VqdU1kUDJCdGVRdlEzOTJr?=
 =?utf-8?B?ZndObkdoNDAvT3NWQ2RLWU5WamFSVXArTGlxcStEMzdPRCtmUFp3bkNDbXJ4?=
 =?utf-8?B?dUI5K0ZNRU5Na0JocjhxVlY0U2RQNHBXcVlXOC9WTWxRQW9HQ1phN1NlNis0?=
 =?utf-8?B?K0xaR2RlL2hoYXExQ1RaejVBVWdzTXNvSmNVS0YyVURGc05ncUx5QytHajk0?=
 =?utf-8?B?c0FzV1d4TEhqN1hoRVE3dG45cGp0ZmFybzZCd0ZLcmJTMngrWkRtY0w4WVVT?=
 =?utf-8?B?ZXpQTnZJeE5CTWRhb1hGSUhmNHZQN253ZGpLZ0hRd0tMajJHY2Vxekh1YlMx?=
 =?utf-8?B?b04vWG5VS1Fld0RXQ0xuYjJ5RjVkUUlkVFMxQW0xcVZReG8rSDgrMkZYVitJ?=
 =?utf-8?B?QlhvVU9FMDdRMXZiclh4TDBNRWlta1orT0JYMU5hdzBnMjAwRGlzUTdvYWRt?=
 =?utf-8?Q?4eB1QF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzlEb1dWN0lmVE9TakFXZkg5YVFJZWxIdUNiS3NMNXllc1IwZEpOUFF3Qlhj?=
 =?utf-8?B?RlZSV1QzakNkYVV3K2VXQWpvQklGb3JsNi8vZXBCd2Q4OEJtRWdKZGFTS3dX?=
 =?utf-8?B?YkFaUytrblhEYy9VK3hwNnM1ZFVVc2JlZUpJTzBiVGRVMm8wUjkrOFY0aTQw?=
 =?utf-8?B?Q2NXdzg1dGJTZWlyNGMxbkF4WXUzakNxMDM3aDQzV2FXb09vNGFiOVlwb3hP?=
 =?utf-8?B?aVZTVWg5a05zd1h4ZWNNNm9yOGs5NExtOEpsa1JNZHlzSENON3BnamhXSTF6?=
 =?utf-8?B?QU9lbmxtWkxTYnE2dy91eHpwZXFKSEt2RjBDZWhianJTcyt4YkdGNllkN3ZC?=
 =?utf-8?B?bnJiL25SWUVYS2NQaHd1VE1RdUljRjBpMVJOcC9EU0FxVVJ0aVloclBaVUtF?=
 =?utf-8?B?cGI4bFllK3JEUFBlRGhtc1JZejkwODd3WTZ5RExKd3M4WHpZYXU3Q0NsSmV2?=
 =?utf-8?B?Nlp3TGRySUlrMmVkZCtqdllZejQrdzRNWXA2cWd4bjN2eWpaMHY3RHdpR0Vj?=
 =?utf-8?B?VTFhYkJPMzk5KzhLMElyaTBlQ01KbFY4OHRYSU5ybGxHVFkrc1ZVZ0g1cFhz?=
 =?utf-8?B?WHFKaHJ3blJrODFlWE9PKzJ6UU9qcUVCN1lWSkFCVGwzbEZ2YnZqczRTWUNN?=
 =?utf-8?B?RVUzYlJVb3g4bExPZXZudFg4TlZGWlV0U2YzNC9tOTQ4a0tsdEJYc055M1Ni?=
 =?utf-8?B?WU9uUFU2WEplVEYrQ1NGV3pPNWN5QVhPTGQwTXM1Qi9FbWVHM2xpQ2xnbnBS?=
 =?utf-8?B?TXhVNnljdmFPUnV1d3FFWjY5ZUdEZi82VllJdDlONGllQkkzR0ZFNXVhcjBO?=
 =?utf-8?B?bFovVXcwV3pWRktEWDY2Q2dqemVOS2I2M3RmOVBEK214dmYreTNPeXE2YmFZ?=
 =?utf-8?B?V3RhUzNGOVpHdENIZUdYaGZWRTQxMzhGQlh3YlpoTElxTGE4ZDB4U1FYbUNM?=
 =?utf-8?B?cWNOdzNBQklsU0NYZUt5K3BFcEJSaHZzY2E3UTBYWTJ2QmdkL1c4cDFKeGF2?=
 =?utf-8?B?TjdzSmw3VmQvcmd2WTJKb1RNWVBPMkFLTHlwUWRhWkhrNm1ENW9veHlZbDB2?=
 =?utf-8?B?YmxJeGgyUGU2NGxtamxoZHgrT3NXL0trV3VCZjZlYXpsQ0dHSU1kUUlUOEtX?=
 =?utf-8?B?V0FBTUlKZEg1dzhhTlQyalZyWmQrMFU4N1YrbkNVV01BS3pjVkdUcHVkbTVu?=
 =?utf-8?B?RlplV0xJV3NUUWRyMEJNdWdvVHNhd1NLc0ZxY2plQmExbk00d1R4Mk02RkNt?=
 =?utf-8?B?cmFjWnJUOUxMWE4ra21ULzA0a3NkdzkzQnNaYTJmVE9IOW54aW0zOTNEZVFn?=
 =?utf-8?B?L2V0eGVaS2c4VWthYjBlNVQwWmE2TGtBTWkyYVBySW9rekcxTkQyUnZhTEth?=
 =?utf-8?B?N3Mxb2RvcFdWajdMN2NyWUtIVjhaK2FOQVJNSTVzSXpRQ0ZZeGNQenF0a3JT?=
 =?utf-8?B?VHpqUEJMN2dicGVOb21obWtlbitIVjlXOEJrdXF5UXF6SWRHUGpwdW9xNWxO?=
 =?utf-8?B?aEZZRHFjUElPa2pKbVFOS2lLMk4rVnRZK21tQWovWndHdzcyZWwwd1RqZndG?=
 =?utf-8?B?K0RpT05NYmp6eTdxcVlDd1NsYnByeS9nRnZWNVhlVUNpWmJ1UWRJc29VbVB6?=
 =?utf-8?B?SUFEU0owdzYvNXVOL2FtR3g4aWMyRDBxREI5dGd3RUl2SlpGcys0UmY5bkQ1?=
 =?utf-8?B?L2dEQU55bDE1S3ZzaEhuaFdFUlp4QzJaV2h5S08rcW5wbldTMzRCdFFIcTdP?=
 =?utf-8?B?eVJIc3RhYzMrRmo1b25Xd2Z4Q01odk1VS2xJVW0wWGNmdk45Rmg0TzVwN2NN?=
 =?utf-8?B?a2NVNXZnVDlPdzRRU3RtT29uOGViYS9neXRnU0VPK2VGRzR2WEJIU3B3UkJ1?=
 =?utf-8?B?REFOMXpWOGIvS2JuelR4aWFwU2RrZmNQSVpKWGlsd0hla25aOUk5K2tKbStn?=
 =?utf-8?B?VDQrQVZ1VGNJcUcwV3dPWStCdENneDJKY29FZFhLWTVNSTdWQVVHaVlxQ25t?=
 =?utf-8?B?enVwOEZFQ3V0RUNZWDVWbnM3Qjl2cGFjNkZNV1FmOUxJeDBLeTA0US9sSDRl?=
 =?utf-8?B?VFlkcUdEeVN3RnprYWRnM0l1WU9DNkN1SE0ydFFuY2pUd05oa1ZOTG5Hdkxh?=
 =?utf-8?B?M3Z5bjI4eERDcVBrTitQcUlHR3FmbmxLK1hMN0xXeXZhc3JXWk5CVzRXcjN2?=
 =?utf-8?Q?OeBKsXz7jzvRzaksvsPz+O0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F71F91F708A6C9418D6382488E406B42@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4ea54f-21a4-4615-3d25-08de16115738
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 11:01:26.6163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HN6DY3ZVbKEI5wdjISQe7HKGAdOvUKaBd0Or1w2EuI18/D7TlwQ3o6yUeDotdKzGno2swtBYnzddtu0MtNKHmhrUn0Y9TT5hRvkFa5lrNV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7258

T24gMjgvMTAvMjAyNSA1OjM2IHBtLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAy
OC8xMC8yMDI1IDEwOjI5LCBLaGFpcnVsIEFudWFyIFJvbWxpIHdyb3RlOg0KPj4gSW50cm9kdWNl
IHRoZSBTdHJhdGl4MTAgU29DIHNlcnZpY2UgbGF5ZXIgKFNWQykgbm9kZSBmb3IgQWdpbGV4NSBT
b0NzLg0KPj4gVGhlIG5vZGUgaW5jbHVkZXMgdGhlIGNvbXBhdGlibGUgc3RyaW5nICJpbnRlbCxh
Z2lsZXg1LXN2YyIgYW5kIHJlZmVyZW5jZXMNCj4+IGEgcmVzZXJ2ZWQgbWVtb3J5IHJlZ2lvbiBy
ZXF1aXJlZCBmb3IgY29tbXVuaWNhdGlvbiB3aXRoIHRoZSBTZWN1cmUgRGV2aWNlDQo+PiBNYW5h
Z2VyIChTRE0pLg0KPj4NCj4+IEFnaWxleDUgaW50cm9kdWNlcyBhIGRlcGVuZGVuY3kgb24gSU9N
TVUtYmFzZWQgdHJhbnNsYXRpb24gZm9yIHJlc2VydmVkDQo+PiBtZW1vcnksIHVubGlrZSBwcmlv
ciBBZ2lsZXggcGxhdGZvcm1zLiBUaGlzIGNvbW1pdCBpbnRyb2R1Y2VzIHRoZQ0KPj4gc3RydWN0
dXJhbCBjaGFuZ2VzIG5lZWRlZCB0byBzdXBwb3J0IHRoaXMgZmVhdHVyZSBvbmNlIHRoZSBJT01N
VSBkcml2ZXINCj4+IGlzIHVwc3RyZWFtZWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogS2hhaXJ1
bCBBbnVhciBSb21saSA8a2hhaXJ1bC5hbnVhci5yb21saUBhbHRlcmEuY29tPg0KPj4gLS0tDQo+
PiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvaW50ZWwvc29jZnBnYV9hZ2lsZXg1LmR0c2kgfCA5ICsr
KysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvaW50ZWwvc29jZnBnYV9hZ2lsZXg1LmR0c2kg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ludGVsL3NvY2ZwZ2FfYWdpbGV4NS5kdHNpDQo+PiBpbmRl
eCBhMTNjY2VlM2M0YzMuLjE1Mjg0MDkyODk3ZSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvaW50ZWwvc29jZnBnYV9hZ2lsZXg1LmR0c2kNCj4+ICsrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvaW50ZWwvc29jZnBnYV9hZ2lsZXg1LmR0c2kNCj4+IEBAIC04NDEsNSArODQxLDE0
IEBAIHF1ZXVlNyB7DQo+PiAgIAkJCQl9Ow0KPj4gICAJCQl9Ow0KPj4gICAJCX07DQo+PiArDQo+
PiArCQlmaXJtd2FyZSB7DQo+PiArCQkJc3ZjIHsNCj4+ICsJCQkJY29tcGF0aWJsZSA9ICJpbnRl
bCxhZ2lsZXg1LXN2YyI7DQo+PiArCQkJCW1ldGhvZCA9ICJzbWMiOw0KPj4gKwkJCQltZW1vcnkt
cmVnaW9uID0gPCZzZXJ2aWNlX3Jlc2VydmVkPjsNCj4+ICsJCQkJaW9tbXVzID0gPCZzbW11IDEw
PjsNCj4gDQo+IA0KPiBZb3UgZGlkIG5vdCB0ZXN0IHlvdXIgY29kZS4NCj4gDQo+IFBsdXMsIHdo
ZXJlIGlzIHRoZSBkcml2ZXI/IFBsZWFzZSByZWFkIHN1Ym1pdHRpbmcgcGF0Y2hlcyBpbiBEVCBk
aXJlY3RvcnkuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpJIHdpbGwgYWRk
IHRoZSBkcml2ZXIgaW1wbGVtZW50YXRpb24gaW4gdGhlIHYyIGFzIHBhcnQgb2YgaW5pdGlhbCAN
CnN1cHBvcnQgZW5hYmxlbWVudCBmb3IgdGhpcyBBZ2lsZXg1Lg0KDQpUaGFua3MNCg0KQmVzdCBS
ZWdhcmRzLA0KS2hhaXJ1bA0K

