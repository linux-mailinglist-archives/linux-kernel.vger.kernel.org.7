Return-Path: <linux-kernel+bounces-853144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296F0BDABCA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6303E7A05
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F44304975;
	Tue, 14 Oct 2025 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="RqP62IeA"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021080.outbound.protection.outlook.com [40.107.130.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0E242D97;
	Tue, 14 Oct 2025 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760461672; cv=fail; b=okLq1ZtlmPGXBmLJPicoqFBt/HhDf9nNIjuas6tJOMV/ZoWypOPtTtMII4BKnYu9rBsZNsActLSiHvd5iHkbk1Svy+Xry+aQNH2WhvCsNAMb3xMmbCqH1qkOF3HZuDIul+Bsc9kHSqI4dJB7QfPIAMGpr/KGPJLLehObvMLYjw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760461672; c=relaxed/simple;
	bh=+iQZlXnZQ9HCOWgdFw7nV4WuX9ZTQlt8cG7L0KsHTb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LgcSNcLhqIFh5phG7oxWZ6QCJX/cY+Q+Rzlz3i3tL9cFEHPu5TAm/WhpS++wLls+gmvw0YKgV8wW+Nhcn4Xt+++pQBTaS4hwOrNo7sqBnMTIG1a0VEpjC3JPPlhmI+M+sTqOujKvUHdF7EWSZZ/1w+LNa987htMavkOqtQ+lzs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=RqP62IeA; arc=fail smtp.client-ip=40.107.130.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruLkWtOGHldDVScv3Arx/3fHQfQQthaYORac9uflKBsmqTf/qgbL6f4z4+oJn9ZwvGezKaoaApNtLj++2kz8in8MzQ2Mgn+Ksp+CKKMfvY3Z5KxYMCWSjoxN0jvD1srTxjW206Xpt3PV9JlZVx+zyxA/liu/ZPujcpr+rBFGcEg1w47a+e1ICUeUrSFnqdpj88Zd84H2GMJzzHdPEGpYd8yIBuf5hdf4zbCH49yL7JjOL1fZn1vIWSJoIAcYDth+VY3K/dZICodjpNcw3fvXr6UG5rFodJxg4+BrX6nyo+XqguIaAB1r0u/foOAwWYCzw/0HUPAxuIRa+rtY2eadLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iQZlXnZQ9HCOWgdFw7nV4WuX9ZTQlt8cG7L0KsHTb0=;
 b=oXPejgfBswqUq+KAQXO0RXaswwzQQOct+PGK76xX8i9JJIiVRTsqPhadvu5zyIJ+WAEDJlt6tMQSlia3J4JrJ8d5JNveJ8TRcyrGLr1p3Jw9Gbm2SNJC5G6bJ5qkZO/s7A7AslDc95sq+mHSMJ2hmPBPIABJYRUcvdACREtbAETmsKLYIGrHqTaBLaATlym7+VVXDLtMbhhRfymjTMchLQU2c67rZURSw0UFYXu7XlDz22etRZRcc4dsP8PWJeaW/NwqOCppsHc0uor7wwhPqpySFnd9tx1omOVswnDijR1XtG8CA97/dnX4Gdi+TRvEId412v5grRA8w23YPGAnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iQZlXnZQ9HCOWgdFw7nV4WuX9ZTQlt8cG7L0KsHTb0=;
 b=RqP62IeAtZXn9JyGN4NV/2w5G8hz+6D8Il9BBFQ7UDWO1zc8mmHNfHAH3cggluLMpg1BAfS6e5Hv+P6EfGcJ99wBVqbVkEktflZ/KYtwJguFlcD2+f2j9PgSvMBqNQ5Xi/yH3hlr3mKIyJaQMhFqK6XfoaEd8q1cEKQUedRFtPwAZYavpNWFuxygo8vJC89nsMLgzyFZL5mWgBzYKLJqsFUq1+IWI8KUijrCMJM+uLJSX7yg+/RqTG6dmnNrWkdK5YT/GrZ9XryPlrLnpygZLtC/bbzlucZ/N3FF+iTdEnc7T+ljIcJrgjxnR4HiIqTA35HZcuRLYosYOIRTeSmABg==
Received: from GV2P195MB2328.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:dc::8) by
 AM8P195MB0962.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Tue, 14 Oct 2025 17:07:43 +0000
Received: from GV2P195MB2328.EURP195.PROD.OUTLOOK.COM
 ([fe80::c6fe:e602:7166:f258]) by GV2P195MB2328.EURP195.PROD.OUTLOOK.COM
 ([fe80::c6fe:e602:7166:f258%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 17:07:43 +0000
From: Dominik Haller <d.haller@phytec.de>
To: "nm@ti.com" <nm@ti.com>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
	"vigneshr@ti.com" <vigneshr@ti.com>, "kristo@kernel.org" <kristo@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "srk@ti.com" <srk@ti.com>
Subject: Re: [PATCH v3 0/5] TI-K3-DTS: Cleanup CPSW DT Nodes
Thread-Topic: [PATCH v3 0/5] TI-K3-DTS: Cleanup CPSW DT Nodes
Thread-Index: AQHcPQmp3JsH63QiGE6LAKyGjDZG1LTB4AOA
Date: Tue, 14 Oct 2025 17:07:42 +0000
Message-ID: <df6acbfe5d30956ed66e2768fa595c36d2ebe98a.camel@phytec.de>
References: <20251014125349.3408784-1-s-vadapalli@ti.com>
In-Reply-To: <20251014125349.3408784-1-s-vadapalli@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2P195MB2328:EE_|AM8P195MB0962:EE_
x-ms-office365-filtering-correlation-id: 9b35465b-de31-435e-6dd2-08de0b443060
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MEVIeEhJZHNuNUJtN2VUNThNUW01Z0N6ejlNaGhzY0dhbVhpamVHZm9ZMW5I?=
 =?utf-8?B?WmVhSnZySEFNYW1OWmJYcEgrRnE3OFkwajVvRGlzL1psWW5VRkFHNExYR3BF?=
 =?utf-8?B?WGVLSEsyNkRoMjBMMkpjbndDd21wemVZV1pXbmFZandzbitnZzhra1MyUmZa?=
 =?utf-8?B?Mk40V05pYTJ6bzdGZGFTdGNLUGhyYkUzREFPRTlCVE9sZ3NRZVVLRlNPYmQv?=
 =?utf-8?B?YlIwSlp1b2FxWGdMSVlVZjZWZVNYV2hvczRwTkw4QmJFeXBJTzFnMDJHVVBw?=
 =?utf-8?B?Zll2MHludUxibkdCYjlrNG5oQUZ5c3E1dEVWWjFuQXNiZnAyUXZzVHE0N0pl?=
 =?utf-8?B?MnoxTFA4U0ZSTWhwVmJtTElwV0k5VkNCaGhEdkp0U3B0Z2xlclplSUZuRUFk?=
 =?utf-8?B?bmdkckg2Y3lXeWxFb0FnOFl5bkpFTEtqczJLdGQ4VXY1Mi9UOGYzd1BXdXpW?=
 =?utf-8?B?VVI3RnVZTitMc1MydVdlQTlVc0NCejkxVmZqdHdBUjY1M0FybDJRdmNXT0t1?=
 =?utf-8?B?U21oR1c0L0JCbTZrekRnbmZSalBldDBxZllQdGhiMm1ZUHB6RFJIN0dhZWdQ?=
 =?utf-8?B?YWcwR3hXb05KQXZrbDd0VWc3Uy8xdGJ2Qm0weFN6NDNmdDhQc25tL1ZLd09Z?=
 =?utf-8?B?S0FHNXhCR05FNGNjc3BaOGxoeS9Takt4bW5Ec2JhSDhIeXpLVFdhemFtMGYv?=
 =?utf-8?B?aFlpRDdBeEdDdlFUN3dMaXFkdjhzbWVqY3c1TEdHQWI5QjF3WEFvTzJheUND?=
 =?utf-8?B?eUdzaEVDQUJxU2dGKzdsWmM0SE9RVDAva1M3MFpaTVFObmhHaHg1ZlBZOXFh?=
 =?utf-8?B?VFNVV1M4UCt0bTVrdS9ZcTBNUXRIbml2bWE3NHRoL1F5Uk5iOUJCQXBKQk5W?=
 =?utf-8?B?UDRjaFBzWlBlelBDajJIU3hVV3kvM21XZmhmelIrZUF0QXBZTjNNL2xsYkpr?=
 =?utf-8?B?V3VXWVNaT0pHVlBqZjUyUVJ5bGNqTnBFbkJHQlhRVDFIdEIzSWJiaFJXNExo?=
 =?utf-8?B?OUhQMy9xQWRXK0xQN1lOUHZmTkVLNDdiVi83aTNFbGxoa2tVZzk1R0dxRkFT?=
 =?utf-8?B?aXZvYy91eDZUYTBDNTRRd0tnM1RYV3M2aloxcEMwcW5SQTV5SThJKytNbkVl?=
 =?utf-8?B?K0lITXN0MEsyMDErN1JFbk04dFZCSHZTQzRJVFVvcVZTQlk0T1dYVzl1dE1h?=
 =?utf-8?B?Qzh0VDI5TittUmZ3R05kU1FkcnUxYmd2ajNuWmpOZGZKNCswbUZEUFgrYVpy?=
 =?utf-8?B?WmJKVmZlSllsdWs4NFgxc3YzSWljYzlnSkYvdnNtS0VwRG1vOWZFUFhPNXNJ?=
 =?utf-8?B?NWZaeEJoeVBLUWpqMWljdm51dUFiNDhlQm9aYlV2cHRHck0zcitmR3IrSkFn?=
 =?utf-8?B?bjNWbm1wNDBMMU13TVVBSjA5ZUpKcTZNZVp2TkdWVDVRVDdiRnBBdkFJaWNw?=
 =?utf-8?B?TFMybCtrZTh4UDhvQWcwcDJGa1lmS0w2UVBEcDFpb3JaS2hpNGFRQ3FHSlZR?=
 =?utf-8?B?azZCYkFQMWRseVAzeUlDcmJkdWd1R0IyQ1lkYjQ2OGQreVUvNWZrODRISVdn?=
 =?utf-8?B?QVNCME5QempkUEtMT2VKV3RYQnplc0VjNnhFT3FlVUlNbzQyRVNHbzBhbldY?=
 =?utf-8?B?MmdUUVZwd2orVk42T1lLSnJhQzljaDhqWVBtQnVLQnRzWW0wWUY4SnkwTW5V?=
 =?utf-8?B?VCs1VCtXbnU2dlNUdThRYmpVMmN0cVI5VFBGUkRGUklUU28zQmxhOVYzTDU4?=
 =?utf-8?B?eGFXNE5zWk5uWHlKeDd1a3ZIamZXdS95NWNyVzRxNyt5QVJRUXVxTW5QR2d1?=
 =?utf-8?B?aWQwQ05kUHBjV2V1UG4rRWZtTUwxaS9JOUZRWk9HUGFTMzVqUjNEWndMVGwx?=
 =?utf-8?B?WTVRdmE1SVFqd1ZXdWtUbjFsSnJaYWx1MFdSZVo3UWVKVjh6dWlJUlI1U1lU?=
 =?utf-8?B?MStXMkFnM1dFd2h5S3VDajZTZFpjZlB0bGthajFhU3MrcGlsMzBwQWpqT21G?=
 =?utf-8?B?ZkJJQXJUVzhaSjhnUjZOVmRiNmV4R3RkYlU2WHZJZ3hUalo3SS92V1ljYkNB?=
 =?utf-8?Q?8SqWTB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2P195MB2328.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWY4cE1DNUU5VXJKR2VvaXFMUnZPblp5SDhhVUZBbFlldW1VNnBJOFgzUmZT?=
 =?utf-8?B?eERsai90R2FGR2lvR0VHZkhoMFJkMzdIeXEwSEIwWGZVUDNtOUFGdWpIQ2tW?=
 =?utf-8?B?c05WbGsyMk83QW1TM1Y1bUlBcHYrYzJsd0lyWE1lalBGS3ZGUkR3bkNKZ3A3?=
 =?utf-8?B?aEp4aGxEaTZFcllkcVJTYUhWeG82akk1c3EySE10cHY0QytreS95Vms3dzVJ?=
 =?utf-8?B?VGJjdHFnbDJoSDB0MFhadmFpTzMrTnRGcVArQzFFYVI2ZVBPNHZRcC9VKzBk?=
 =?utf-8?B?WlZBTGMzaU9pL3VWdmFtQ3J1QVJlZDIxVFVVTUtyRVlmcEhnMXdoSlM2TW5Y?=
 =?utf-8?B?NVlXRTRwa1ZiL1lzT3RCbWR6b0tXS3NSa2xwbU5mVTZMSDl1aTR5ajJuREw2?=
 =?utf-8?B?ZldxVFk2TE05dGM2Q0pQYVBsbWhqcFdMNkNOakd6Tlp1WHBubU02MDdBelJD?=
 =?utf-8?B?aWxBcDhwMVEzVGVWR0ZVM2hBdERKeStaQUNyakl1MEJISVg4YkhOaDB4NUY1?=
 =?utf-8?B?SmZxeDllSWIwU2dpeHkrYUQ5MFlaTXVYK0pqZFlmd3RwVmc5VHVPZXAxL1lz?=
 =?utf-8?B?Q1RJdTJyS0xoOEN0RWFBRW1PakRQU3pYU3JOYTZFcEMwVGUrN3N2YUVNY1p3?=
 =?utf-8?B?V1A5bnBKQllBdmJHNzUwUjc1ZG45aXZlcWxHK0M1Z09aa1RxcFcrQTQyYSt3?=
 =?utf-8?B?bmNhSm5BanBOdUx0SDFkM05zbTluNmhvL2l1QTVLbUNtK3NSM29VWk5CTVhm?=
 =?utf-8?B?d3NDZmQvWHhaakdRV0NwYXpHNXZsREdHMWU1cVYrc25jZVFwU3lnZW5LcFFn?=
 =?utf-8?B?aFREOHVCUGlIbElWWms0NTFZT25Fa0ZmeklYM1hQVktqVGZxbm9nQ1h6WGlp?=
 =?utf-8?B?VlNHSzZWcjl6aHFkeE54NzB1eTIwZGtPVGpJUUNZOU1oTCtXWnBudnVWTGV3?=
 =?utf-8?B?VlN4Z0FSY2xsU3AyWVZDVk1FOXI0bHFBOTJ3ZDRZK0FSSWJ6dGJZejJQSVox?=
 =?utf-8?B?YWlIcGNaL2w0RjdXSzBXQ1NQbWdUb3F2VU4vYzlmUXlNeERsL3lHTlFHZDJF?=
 =?utf-8?B?OFdlbmVPK016djdCVVg3NmV5NFlXTWs0bTZLY1lrT0JLVmhtQ0UveWFjcHFP?=
 =?utf-8?B?L0VmN2NRcVZRRUlDMmw0WmNjM0RaekRONUlkM3lwaW5vZGtSTTFOT1VFa1ov?=
 =?utf-8?B?a3VEckJWSGhoNnRNeEZJMndYTmcrbEM1c1pEelo2V0g3NmUzODhXRjQrWklS?=
 =?utf-8?B?a1poTUN3ZkkrMTRHd2ZHN04xUTRucEU4NjR0WnVmRGQ0b05la3lFbTY5NnRQ?=
 =?utf-8?B?eTlobWlpVTMvSG5uQUZ2Ulp5ak45K0RJeUUwOS9VT0Zua0YxTzFCTTRWWjNB?=
 =?utf-8?B?alRuWHNmbW5RT09ZM1lvRHcrcFhJUG5QZjBxakRvZzQ2QnpQTmMyNk1wNXFq?=
 =?utf-8?B?cTExMUY1UDgrWkJ6V1NlSURJVGY2dzZ0ZWh4ZnNLdlR3S3hVL2k3Yis1SnUr?=
 =?utf-8?B?UWthaHh4azdrem9JZWNZWGhjUWJkUnJKaFNnYkNxMzhxNmFrZnZObUJxbzcw?=
 =?utf-8?B?OHdKam00N1E3bjBUck0ySlc5MmxacjkySytsdDBVOGcvOFA1ZUVVWHNWUm9I?=
 =?utf-8?B?RTVqQ3dVMXJ5bkNLdnZ3UGFvNFpmTEZhUmIxRjhtUTlFSnJEZnhabGtHNDVN?=
 =?utf-8?B?TjhNOXVOcENFVjFQOG5tUlVQK3ZFNm1PaXR4ZmEyL2djZTh6MDBhbWppdW9R?=
 =?utf-8?B?WG1wZnJjVXF4V2UwWVJCNlZHTzZYckNCTnRmVVY2RnBmNFVkM1ZkK3JwQVVh?=
 =?utf-8?B?WlRxaTJrZ1NJQmg5MXRzQkNEQXd3VWlzTmR6L1JrTXh6SFV1SzVPZXBweDNp?=
 =?utf-8?B?a0NoMmg0eFU4eG9mcElFN1ZvMkhpb1FlUU41ak55WjVETFQ5TjJXZTJteFlW?=
 =?utf-8?B?MjBOWmNkRjN4aUQ1ZDg3NkFMa2lRYWtRWnZ4WitaQXowbnNaYjIyZC9mbm1l?=
 =?utf-8?B?S0VnSEY2ZFd0RVBJZE1LdDFGZ0JsKzVlRzYvWC9pdXJEZTZGbFlwY2tSTjdq?=
 =?utf-8?B?ejVwZDlPN3RQVHZobDIzRERHTndia2NIODFydWl4bjByY043SVRYRkJPcmwr?=
 =?utf-8?B?M0pDZEg3Umtkc0dKbHRGbTlDdWFkOG5ZdmxlVUwyVkFtV0FiU1NBT3dadFl2?=
 =?utf-8?Q?anQN3xhZZSjO3I9j6pr/onU2ZJ0dhWesUbuqi6VhaXnG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07AC83CB7EF9CA40A858ED6AA2B86C57@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2P195MB2328.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b35465b-de31-435e-6dd2-08de0b443060
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 17:07:42.9944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KwOXEhTjXUcH1j4D6/cogYHZcTpBisCr0bTaVwMrJYdqae2famEFYyPk4kjmyjOyviQ/6jOL/pF4q2QEXZjj+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0962

T24gRGksIDIwMjUtMTAtMTQgYXQgMTg6MjMgKzA1MzAsIFNpZGRoYXJ0aCBWYWRhcGFsbGkgd3Jv
dGU6DQo+IEhlbGxvLA0KPiANCj4gVGhpcyBzZXJpZXMgY2xlYW5zIHVwIHRoZSBDUFNXIERldmlj
ZS10cmVlIG5vZGVzIGJ5IHVwZGF0aW5nIHRoZSBTb0MNCj4gYW5kDQo+IGJvYXJkIGZpbGVzIHRv
IGtlZXAgQ1BTVyBkaXNhYmxlZCBpbiB0aGUgU29DIGZpbGVzIGFuZCBlbmFibGUgaXQgb25seQ0K
PiBpbg0KPiB0aGUgYm9hcmQgZmlsZXMuDQo+IA0KPiBUaGUgZm9sbG93aW5nIGlzIGEgc3VtbWFy
eSBvZiB0aGUgU29DcywgQ1BTVyBpbnN0YW5jZSBhbmQgdGhlIEJvYXJkcw0KPiB0aGF0DQo+IHRo
aXMgc2VyaWVzIGFmZmVjdHM6DQpIZWxsbyBTaWRkaGFydGgsDQoNCnBsZWFzZSBhbHNvIGVuYWJs
ZSBjcHN3M2cgaW4gb3VyIGszLWFtNjItcGh5Y29yZS1zb20uZHRzaSBhbmQgbWN1X2Nwc3cNCmlu
IG91ciBrMy1hbTY4LXBoeWJvYXJkLWl6YXIuZHRzLg0KVW5sZXNzIEknbSBtaXNzaW5nIHNvbWUg
b3RoZXIgcGF0Y2hlcyB5b3UncmUgdHVybmluZyBvZmYgZXRoZXJuZXQgb24NCnRob3NlIHR3byBi
b3RoIHBsYXRmb3JtcyB0b28uDQoNClRoYW5rcw0KDQpEb21pbmlrDQo+IA0KPiAtLS0tLcKgwqDC
oCAtLS0tLS0twqDCoMKgIC0tLS0tLS0tLS0tLS0tLS3CoCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+IC0tLS0tLS0tLS0tLS0NCj4gUy5Oby7CoMKgwqDCoMKgIFNvQ8KgwqDCoMKg
wqDCoMKgIENQU1cgSW5zdGFuY2XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBCb2FyZChzKQ0KPiAtLS0tLcKgwqDCoCAtLS0tLS0twqDCoMKgIC0tLS0tLS0tLS0tLS0tLS3C
oCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0tLS0tLS0tLS0tLS0NCj4gwqAg
MS7CoMKgwqDCoMKgwqAgQU02MsKgwqDCoMKgwqDCoMKgwqDCoCBDUFNXM0fCoMKgwqDCoMKgwqDC
oMKgwqDCoCBBTTYyNS1CZWFnbGVwbGF5LCBBTTYyLUxQLQ0KPiBTSywgQU02MjUtU0sNCj4gwqAg
Mi7CoMKgwqDCoMKgwqAgQU02NcKgwqDCoMKgwqDCoMKgIE1DVSBDUFNXMkfCoMKgwqDCoMKgwqDC
oMKgIEFNNjU0LUJhc2UtQm9hcmQsIElPVC0yMDUwDQo+IEJhc2VkIEJvYXJkcw0KPiDCoCAzLsKg
wqDCoMKgwqDCoCBKNzIwMMKgwqDCoMKgwqDCoCBNQ1UgQ1BTVzJHwqDCoMKgwqDCoMKgwqDCoCBK
NzIwMC1Db21tb24tUHJvY2Vzc29yLQ0KPiBCb2FyZA0KPiDCoCA0LsKgwqDCoMKgwqDCoCBKNzIx
RcKgwqDCoMKgwqDCoCBNQ1UgQ1BTVzJHwqDCoMKgwqDCoMKgwqDCoCBKNzIxRS1Db21tb24tUHJv
Y2Vzc29yLQ0KPiBCb2FyZA0KPiDCoCA1LsKgwqDCoMKgwqDCoCBKNzIxUzLCoMKgwqDCoMKgIE1D
VSBDUFNXMkfCoMKgwqDCoMKgwqDCoMKgIEFNNjgtU0stQmFzZS1Cb2FyZCwgSjcyMVMyLQ0KPiBD
b21tb24tUHJvY2Vzc29yLUJvYXJkDQo+IA0KPiBTZXJpZXMgaXMgYmFzZWQgb24gbGludXgtbmV4
dCB0YWdnZWQgbmV4dC0yMDI1MTAxMC4NCj4gDQo+IHYyIG9mIHRoaXMgc2VyaWVzIGlzIGF0Og0K
PiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtYXJtLWtlcm5lbC9j
b3Zlci8yMDI1MDYxMTExNDMzNi4yMzkyMzIwLTEtcy12YWRhcGFsbGlAdGkuY29tLw0KPiBDaGFu
Z2VzIHNpbmNlIHYyOg0KPiAtIFJlYmFzZWQgc2VyaWVzIG9uIG5leHQtMjAyNTEwMTAuDQo+IC0g
SW4gdGhlIGZpcnN0IHBhdGNoLCB0aGUgY2hhbmdlcyB0aGF0IHdlcmUgbWFkZSB3aXRoaW4NCj4g
wqAgJ2szLWFtNjI1LXNrLmR0cycgaW4gdGhlIHByZXZpb3VzIHZlcnNpb24sIGhhdmUgYmVlbg0K
PiDCoCBtb3ZlZCBpbnRvICdrMy1hbTYyNS1zay1jb21tb24uZHRzaScNCj4gLSBUaGUgJ3N0YXR1
cycgcHJvcGVydHkgd2l0aGluICdub2RlcycgaGFzIGJlZW4gb3JkZXJlZCB0byBmb2xsb3c6DQo+
IMKgDQo+IGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL2RldmljZXRyZWUvYmluZGluZ3MvZHRzLWNv
ZGluZy1zdHlsZS5odG1sI29yZGVyLW9mLXByb3BlcnRpZXMtaW4tZGV2aWNlLW5vZGUNCj4gDQo+
IFRlc3QgTG9nczoNCj4gMS4gQU02NTQtQmFzZS1Cb2FyZDoNCj4gaHR0cHM6Ly9naXN0LmdpdGh1
Yi5jb20vU2lkZGhhcnRoLVZhZGFwYWxsaS1hdC1USS8zYWYxNzhjNzFjZDJkYTQzNmY2MGI4Nzky
OGRjYjFlYg0KPiAyLiBBTTY4LVNLLUJhc2UtQm9hcmQ6DQo+IGh0dHBzOi8vZ2lzdC5naXRodWIu
Y29tL1NpZGRoYXJ0aC1WYWRhcGFsbGktYXQtVEkvYjAyN2E2ODQ5ZjNjMTdlMTFmYWQ4MzI0YTkw
NWFhNjgNCj4gMy4gSjcyMDAtQ29tbW9uLVByb2Nlc3Nvci1Cb2FyZDoNCj4gaHR0cHM6Ly9naXN0
LmdpdGh1Yi5jb20vU2lkZGhhcnRoLVZhZGFwYWxsaS1hdC1USS83MGQwZDk2ZmFiOTJiODk0MjUz
YzE4ODQ0OTlkNmZjMQ0KPiA0LiBKNzIxRS1Db21tb24tUHJvY2Vzc29yLUJvYXJkOg0KPiBodHRw
czovL2dpc3QuZ2l0aHViLmNvbS9TaWRkaGFydGgtVmFkYXBhbGxpLWF0LVRJLzJjODhhYWRmMzY5
MjNiMWQyNzY3MmI2NDQ4OWNiMmRjDQo+IDUuIEo3MjFTMi1Db21tb24tUHJvY2Vzc29yLUJvYXJk
Og0KPiBodHRwczovL2dpc3QuZ2l0aHViLmNvbS9TaWRkaGFydGgtVmFkYXBhbGxpLWF0LVRJLzBh
YmJhZTJlZjk5ZjgyODcxYWE1MjBlMWFiOTczYzg1DQo+IA0KPiBSZWdhcmRzLA0KPiBTaWRkaGFy
dGguDQo+IA0KPiBTaWRkaGFydGggVmFkYXBhbGxpICg1KToNCj4gwqAgYXJtNjQ6IGR0czogdGk6
IGszLWFtNjI6IGRpc2FibGUgImNwc3czZyIgaW4gU29DIGZpbGUgYW5kIGVuYWJsZSBpbg0KPiDC
oMKgwqAgYm9hcmQgZmlsZQ0KPiDCoCBhcm02NDogZHRzOiB0aTogazMtYW02NTogZGlzYWJsZSAi
bWN1X2Nwc3ciIGluIFNvQyBmaWxlIGFuZCBlbmFibGUNCj4gaW4NCj4gwqDCoMKgIGJvYXJkIGZp
bGUNCj4gwqAgYXJtNjQ6IGR0czogdGk6IGszLWo3MjAwOiBkaXNhYmxlICJtY3VfY3BzdyIgaW4g
U29DIGZpbGUgYW5kIGVuYWJsZQ0KPiBpbg0KPiDCoMKgwqAgYm9hcmQgZmlsZQ0KPiDCoCBhcm02
NDogZHRzOiB0aTogazMtajcyMWU6IGRpc2FibGUgIm1jdV9jcHN3IiBpbiBTb0MgZmlsZSBhbmQg
ZW5hYmxlDQo+IGl0DQo+IMKgwqDCoCBpbiBib2FyZCBmaWxlDQo+IMKgIGFybTY0OiBkdHM6IHRp
OiBrMy1qNzIxczI6IGRpc2FibGUgIm1jdV9jcHN3IiBpbiBTb0MgZmlsZSBhbmQNCj4gZW5hYmxl
DQo+IMKgwqDCoCBpbiBib2FyZCBmaWxlcw0KPiANCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL3Rp
L2szLWFtNjItbHAtc2suZHRzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQgKysrKw0K
PiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02Mi1tYWluLmR0c2nCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMiArKw0KPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02
MjUtYmVhZ2xlcGxheS5kdHPCoMKgwqDCoMKgwqDCoMKgIHwgMSArDQo+IMKgYXJjaC9hcm02NC9i
b290L2R0cy90aS9rMy1hbTYyNS1zay1jb21tb24uZHRzacKgwqDCoMKgwqDCoMKgwqAgfCAxICsN
Cj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjUtaW90MjA1MC1jb21tb24uZHRzacKg
wqDCoMKgIHwgNCAtLS0tDQo+IMKgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY1LW1jdS5k
dHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArKw0KPiDCoGFyY2gvYXJtNjQv
Ym9vdC9kdHMvdGkvazMtYW02NTQtYmFzZS1ib2FyZC5kdHPCoMKgwqDCoMKgwqDCoMKgIHwgMSAr
DQo+IMKgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY4LXNrLWJhc2UtYm9hcmQuZHRzwqDC
oMKgwqDCoMKgIHwgMSArDQo+IMKgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1qNzIwMC1jb21t
b24tcHJvYy1ib2FyZC5kdHPCoCB8IDEgKw0KPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMt
ajcyMDAtbWN1LXdha2V1cC5kdHNpwqDCoMKgwqDCoMKgwqAgfCAyICsrDQo+IMKgYXJjaC9hcm02
NC9ib290L2R0cy90aS9rMy1qNzIxZS1jb21tb24tcHJvYy1ib2FyZC5kdHPCoCB8IDEgKw0KPiDC
oGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtajcyMWUtbWN1LXdha2V1cC5kdHNpwqDCoMKgwqDC
oMKgwqAgfCAyICsrDQo+IMKgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1qNzIxczItY29tbW9u
LXByb2MtYm9hcmQuZHRzIHwgMSArDQo+IMKgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1qNzIx
czItbWN1LXdha2V1cC5kdHNpwqDCoMKgwqDCoMKgIHwgMiArKw0KPiDCoDE0IGZpbGVzIGNoYW5n
ZWQsIDIxIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KDQo=

