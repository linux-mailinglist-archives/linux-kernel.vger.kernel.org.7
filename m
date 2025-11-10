Return-Path: <linux-kernel+bounces-893097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55103C468B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7463B5E14
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3215A311977;
	Mon, 10 Nov 2025 12:11:15 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023082.outbound.protection.outlook.com [52.101.127.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4C52FE585;
	Mon, 10 Nov 2025 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776674; cv=fail; b=CKffIy2lRjMeqclgJ7+HAOukvQ8j4nGKgP1NNy6ye1NBSf5cHklu1G5F9njJtb2RVnv9mNRrXT21EI5akYNh1ICZCRNfp9BjMIdO5Dboz8n5ddVz2XYVFL93UfHVfvkhqe+edA0UQttj6RzdRGdtL192eaSJeWnBB3L2Vxij+KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776674; c=relaxed/simple;
	bh=RfvUvhEA5s/cqZJ4mi/jolybZrJ3cIoWkAXwVZGw9U0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KSoCTPpB0v+NVVZ5YnGyJJsDdh+NWdWBeZCUmiMpxkdEOKoFDSJDMQWc4AwDZfFucwvXHQC6ysvklk7NDGLJasdBL6cGEfHeV3xgqQJ16OlmVXT4FRgFNKeTXe+RUWtAJWfsjNahrRzJW94FQT+mRWeB2AhmQ6CHCsZJSTWdoKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwKhtXn58fyKj2r6v8dWhcwWDbsfVo/RKN6LQ8HjUqFZC2umRhhFBGaDBC6SIj0ySJsIVkAI9+HWjQwc1nyE0IG94e8laxwBfzzNWMrSgWye8qZ/Zxpt1K/0D2ujSIaeVVglrGQbt92BPZadCCV+hrIlKRJ3AmIEabpLkc1nGhjrIceUe+vlCLOAOjrbsM8DOwXb5cCaZ5J3QpoNkPEkf+7Cao2UKF0DrwN95GcVvhplIuAfWXV77uLRu7JSSJdHo0EqisYnXh63gfroZ9nQ4KsQSd/77yJ3Xim8ROhZ9smUQWQU8+SNZC7WT2TePeho96M7oztDRSew/z1bbebpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfvUvhEA5s/cqZJ4mi/jolybZrJ3cIoWkAXwVZGw9U0=;
 b=sQMhgOrgGTjDWpEu2JhAyvW9QkhI2WerpKQ8a1WfwWuTfdvNpu/SsCgsx6z+2QPhexEU4VuGgudpSoRPMkaF3cc1/e1fRMHHffOJSfUM/K2bhL9kqugWbOC2midzAKOVmKPXQ3Hgibg07kR12TkVpL4u6b6BWT24ZWiXwVJDo8Qw+ecpicnrc/OZHHXbM1mtQYlBBcZ0fSQ9QFfXEEH4m7qgJqawSrDDmZTEOoqaS5ebQ+NXJ0liqDskRQkNi58xTh2XWipnMimWl9m7stmx1lyTyqK4ok8pKLm7paKqydG26E/V6nqmghe9PRo47dr21hCeylVwE669+hsiz2YBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from PUZPR06MB5887.apcprd06.prod.outlook.com (2603:1096:301:117::13)
 by PS1PPF31BDA4522.apcprd06.prod.outlook.com (2603:1096:308::249) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 12:11:06 +0000
Received: from PUZPR06MB5887.apcprd06.prod.outlook.com
 ([fe80::611c:7f38:af2e:22d]) by PUZPR06MB5887.apcprd06.prod.outlook.com
 ([fe80::611c:7f38:af2e:22d%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 12:11:06 +0000
From: Gary Yang <gary.yang@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, cix-kernel-upstream
	<cix-kernel-upstream@cixtech.com>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTogW1BBVENIIDIvM10gUmVzZXQ6IGNp?=
 =?utf-8?Q?x:_add_support_for_cix_sky1_resets?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCAyLzNdIFJlc2V0OiBjaXg6IGFkZCBz?=
 =?utf-8?Q?upport_for_cix_sky1_resets?=
Thread-Index:
 AQHcT5f6k32l2FqOtEO23efN98Wr37TmznKAgAS3HTCAAEPDAIAAAIrAgAAEGoCAAAY60A==
Date: Mon, 10 Nov 2025 12:11:06 +0000
Message-ID:
 <PUZPR06MB588738804D05FCDE912949ADEFCEA@PUZPR06MB5887.apcprd06.prod.outlook.com>
References: <20251107033819.587712-1-gary.yang@cixtech.com>
 <20251107033819.587712-3-gary.yang@cixtech.com>
 <69efdb9a-c03a-42f4-a78e-18c8a2b29322@kernel.org>
 <PUZPR06MB58875805D441AF3213189979EFCEA@PUZPR06MB5887.apcprd06.prod.outlook.com>
 <38e8e068-d06b-41f0-9cae-5dfdf0fcce6f@kernel.org>
 <PUZPR06MB588726F24E6193ADD6CF224CEFCEA@PUZPR06MB5887.apcprd06.prod.outlook.com>
 <6a57032b-3726-4074-9212-f0f16269f11c@kernel.org>
In-Reply-To: <6a57032b-3726-4074-9212-f0f16269f11c@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5887:EE_|PS1PPF31BDA4522:EE_
x-ms-office365-filtering-correlation-id: 4e63d2b5-be8f-4185-669e-08de20523a06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkttQW5VbUJ6bFFKTXV4cHhjS2c2S1dDYW9TL0RZMlJLRDlLY1FkWnpmOVA5?=
 =?utf-8?B?UnNtL0VZWm40eC95VThnNGE1WW50SStQRi9rbUd3Q2hNb2NHMFJUWnlmNnNz?=
 =?utf-8?B?OWUwQmFWQzE1T3hlNmFVTVNWQjdMWmpEc2pDZ0FsQ2xtUXBFbjFGdUJ3UGJT?=
 =?utf-8?B?a0thZXZvQmdpUmVpdjN2OHl0VDlYeWlGMEV6ZUlCZmJFa2thMmtZNExURkt1?=
 =?utf-8?B?ZWVoREVvdkF6NGFCQWd2cmpnWk1SLzNzNzRLMHlNWWpTejlMMkk3TlRzTHRx?=
 =?utf-8?B?Uk1vMVJ4NGduaHVXajByM3RzQ0dLL3VBR3ozbzI0eWRZMDNPUXIzUVhhYU1k?=
 =?utf-8?B?MUhlTUNyL1lPTFhqWVZSN3E1SVZ6T1gwZFRzQWlMNVdWdzVhT2UycDhaRGpz?=
 =?utf-8?B?WkJWRWdPcnh5bzBKa2NJZ1I1R2o4QzJBMG5UZmVjcDMzaFJTd05nRFNBcHJs?=
 =?utf-8?B?WnBiYkRlbW8wSjcyck9vYzBFQUc0RHpQT2FrVXp3bk5xd1NiemRSTVk4Ynoz?=
 =?utf-8?B?VUJSR1NxVzVTVmZQWFl0TVJLS2hZL0NoRDJueEZIZHBpR2NLc21lWmo0N01w?=
 =?utf-8?B?S1RoOEIyRGMva2dLVG9kSWZRUExuSDgwMFFDVlY4V1RCRVgrNzNPbG1ZTldO?=
 =?utf-8?B?cVFLMXo3eVFSNjRkdnB1T0dBL3BCenU3MGpEY28zWHdrQyttUnUxVDFIMkpN?=
 =?utf-8?B?RE4rNmFrcFhwUjN3VjNwMEFKa2xCSU9YSUg1WTRvL1d6SzFMcUFacS9hTHZ6?=
 =?utf-8?B?WUFEYTR5SFpwT1dyMXhGQk0rek1KbnM5V3pLMUR1T2p5MmZjeWpHek9yK0Rz?=
 =?utf-8?B?bXVJak5TR2hyVkpKeVhDQ0Q3Y050eFZxa01kVkZySmg1NkVzTmc5Wnp0OXJD?=
 =?utf-8?B?SlVFVENhTnl6Z21NcG1hWERMY2k5djFKSDNpV2VCa2VWN2JMVHpyV2t1LzRj?=
 =?utf-8?B?QlIxb0lxZEJrOWJueHpWanBIZ0NYalIyV2ZRWWgyZzJCRzNLZ3FQUnQrQUs5?=
 =?utf-8?B?SGd3eU4rMUQxS0NuNjhrMjlyaGtIcXJJamM0QnB6SDd1bXpZM3BQbTViblpk?=
 =?utf-8?B?L1JZYW01bE8xbHJOZy9PKy9udG5TTFYzQS9mVDU2dXVKZGVGU2ZuN3NadkNh?=
 =?utf-8?B?OFlEbGF1YXFNRjhrVWRibmoyUDFwQlovL05JNGNSSVNXSjUyak5NTS8vRHJh?=
 =?utf-8?B?cWVyV0traGdlQUF0R3VkY2l5ckhEZ2pVSGdKZDQ0OHNRNXhuS0xYNGJibjR6?=
 =?utf-8?B?UHRDc1dpR3lpNGxsRWRsOVhVbUF2eTZsTGY0SFVzaE83TGppNmZvaytyK2dT?=
 =?utf-8?B?ZTJ4bm5HSS8wa0hDcDhQTDZsOXh2QTRNRkM3R1VBUktLR0g3V3psdDc3SVBq?=
 =?utf-8?B?L1lQOUJLT3RnMG03RS9JK1dMMnZDTDZJYVhvejFQNDJDZEwybDl0ekJGUTc3?=
 =?utf-8?B?OW9SeHJHeURWeWl5OHliRFNaQ3g0bWNKVmQ3V2VLWVFFbm1VR01CRHpyRTZN?=
 =?utf-8?B?dnVPSDExaDRJN1VISEF4Nk1GZVZNQnZraFlVNWFiVjhKdy9WN3laWmdRczJE?=
 =?utf-8?B?dGoxUEFtOTZpVlpnMk1aQnJjdHNhV3FWZFB2Rllua0lMYXZaMnh5VjlNYzlM?=
 =?utf-8?B?Z0NnYjhaQnlGSjQyRE1tNHAvcVZCTWRsUWxzNmQzanZoWmhPVG15ZytRUEZP?=
 =?utf-8?B?R2xIN0diMFUvKzZhVWpQS28rQmhhNS9NWEVuK0I5b0lWUTU1YllXNkVCZWxJ?=
 =?utf-8?B?OGN2QURvMGx2d1NUZ2R1STNSZG84YlBlR1o1L2NZUWg5b0JXWGFLdWVmYmJk?=
 =?utf-8?B?RzJHbWF1cHRHUzVSdmRvWkx0STZaUEVMUkF0QzdSSlhSV0wra2w4UjZHVFpi?=
 =?utf-8?B?M3BBNnFnWVY1NEJpZVBMNkJPM3lPVFArRFlneTlzTHFkUURERVpLTzJRaHlE?=
 =?utf-8?B?cTF5cXM0Nm0weThBQ3h1bm1ZZ1BwNmxLUlU5bExtYTJMY0RjMDVnWFhoNGpW?=
 =?utf-8?B?N083V3Y3TmMwWE8xN2dKNHlLZlE2ZTRCMEhDSXFtVktrQm01d2EyLzlRQ09r?=
 =?utf-8?Q?w80rSK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5887.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUNDY1hsQWVPV3AvbHVFQ0FacU9EckYxQlVNTHJ1N2pLbnBSQmtRZHNnMDR0?=
 =?utf-8?B?K1c5Sk1hbktBTDVZUUxmanBMQ01KM295RHZrM1NsQThDdHBtellmb1QwR0N6?=
 =?utf-8?B?eXd1VXJLM1ZpOWFtNzFKMjgxZGZ2WHRyZ1FmbWJqMERzSmZERkIxekQ1WXVw?=
 =?utf-8?B?SDEzL2NFVlVob1ViaHFaUEtiMFl0V1ZVOCtoZTVBMzVIUkFQNHZZTTVRdU8z?=
 =?utf-8?B?ZEkrVS82U25QcHBQSkgyckt5Z3hCcHVqZExpTDhUTlp1eFRYeEZ3ZFg3dC9z?=
 =?utf-8?B?cEMvcFVOQkV4SXpZd05yVkN1QkROK3NLNUZwazFsaStnMW5yRHhQa05hUVNl?=
 =?utf-8?B?aTk1dUVCSUFpODhRc2xTUi9BWVUzazZoVS84clB6Q1B0M1lNai94eTZkMm9s?=
 =?utf-8?B?V1ZJWUJUQ1BmZ28rZm1NS0QzL0N0M0RwclY0VnFDYXRtUkpyelJUSXdib21P?=
 =?utf-8?B?Vy9kTzNMaThldEJpWThyd2trRkNSWERaZUdOOGdEb2grUjI4Ni8zSysrNlpo?=
 =?utf-8?B?cWNwZHpkZlhENS9IUVRVVVZzS1BlQWJ4NjdCOGc1RmhUaC9UNjdBaUtSSEZh?=
 =?utf-8?B?YllBdnMzSkRhd3lyZlNPaTFuNGtSSytKa0NvL2ZEV1QzYUVXNVlSbUttV0Nq?=
 =?utf-8?B?Q2llaFRWVWpSaklucXJjQTc0K0wrQWpJQkFMckROMnd5RXJzU1ZPQUF4TFNO?=
 =?utf-8?B?dGpoU3ZrUFdvVzVEa1g1UEdBREhTMTZPWDE2bG5JN3dteTg0NjhBTEpTQXRH?=
 =?utf-8?B?UmpiU3UraFYxeklKY01kWDRZNTUwOFBvcWFpejhPeGFxc0p2RkZ1U2l6ckgx?=
 =?utf-8?B?bExyeGlRSzFCcHdiMGhOV3RqSTJjVGJpMjc1RWI3Nm1XZWg2ZnBpV2JFVDda?=
 =?utf-8?B?dWh2SG9HNytZcE54RTFCYkNDUFk4V2lvZ0MrV1YrL1BmbTZlN21GZUNKWXhw?=
 =?utf-8?B?NlhkSXJwdFY1ZUZDdmFtZTFqQkxzWFovQzRTc3VWazZhcGN3RzAwb2JtV25W?=
 =?utf-8?B?K3ppeFlSN1Mvd0ZKQ29qOGFqYzhDakhqTXpQbTRYMnArNXdwYU1kZ09hMUU0?=
 =?utf-8?B?TXFCb2dBZWFBZjVRdUhWQS95WTFkenhMTjNTYUw3L2w3WENaQ25ZS015WlVY?=
 =?utf-8?B?akhIZk5PY1JCWWJkQXZidlI4WjJrNlFkaHlEZ3JqTTc1TlllM1FXZk5VZ09w?=
 =?utf-8?B?dkgxQzhvNUxFWlZxdFhmem1EK0ZxdTlKdE5GUnJ6Q1JQdVFJa0U3c3RWZHpF?=
 =?utf-8?B?RHNCMENLeUVsOXpaTWFpOFVQN1RFMUZGM3dBNFlEV1hSWFdTcjJsdFpzQ2FB?=
 =?utf-8?B?b1ZUVnpkYTBJWUk1ZTlZRHBIZXZKaEJ2d2JEelJlSmNwRG5CVnVBa216MmR2?=
 =?utf-8?B?eUdyd2Y1Skh0KzdQeE9TV2R3QkFhMEovY2h2b29XZmwzaE5ObERpamE1N1Zq?=
 =?utf-8?B?NDJsbURPMFVxOGRKYkdHT3ovaHR3VDllMnh1M09kY2pBOVg0RXo5aktiSFlN?=
 =?utf-8?B?WE4vWlROSFNnVHora3NuSGlvaldTMUZxbVJUMmI1YWxLSGt5S0N4Wkh3MG9z?=
 =?utf-8?B?NVBLWk9TbWdkRHEwUmQ5eWN6NVVGSTQvdmRnV0I5T0R0MlJ4UlNxcWJEanJs?=
 =?utf-8?B?RDRtSlpyQTg1QUplR21VUmpQa0Z5QTVtQTR6Z0VobDVPdkVqTlNidmNNRlgr?=
 =?utf-8?B?ckFwZk9lOUVpeWtiQkczMzJGVGF0Zmk4cTFSZEY1VWc1TmZhOTQ2d1haZ09P?=
 =?utf-8?B?NTYzSDZrSjk0dUNkM0VneVpXZGFnZ3dtaTg1OTV0TktRdENWUnUxdXRPaGp2?=
 =?utf-8?B?bGNVMUoxL0c2K0hnNEZKSExRaVN2endXV0Y1RGxUanlVZk1FakVRRVZmUlJX?=
 =?utf-8?B?YXJCRWgwVWpvWjJZMEVvd1ErVWtaZFBzOXlZRTUwOTVBd2xMT2tUaGYvSXFu?=
 =?utf-8?B?bDhvUlF5emptTVU1azFHSTF6WWxXaHhTSHQwSXRaQ3dOQTB6cUxFU0UyM01t?=
 =?utf-8?B?UU92SldXc1VuSytqNUJoc0dORENhdVpxM3pLcHdtTVVvV095S09TRVZIR01i?=
 =?utf-8?B?MG1NdUNVeUQ2aS9nME5ZMXpIZjhzV1grNmwzajMzeUZtVUVtVEZrQmxtL1cr?=
 =?utf-8?Q?Jb+kA9YYidvcgQOilMSDRbV7g?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5887.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e63d2b5-be8f-4185-669e-08de20523a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 12:11:06.5559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7VSdnFrq5d70DZ7Kvfs/f7lJ9Lup2o6NxdoJRpWXBrSejllB2sSO0dDsF2XcaRMW3kCTQHoCGgKLkkf1krJn6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF31BDA4522

SGkgS3J6eXN6dG9mOg0KDQo+ID4+IEVYVEVSTkFMIEVNQUlMDQo+ID4+DQo+ID4+IE9uIDEwLzEx
LzIwMjUgMTI6MTgsIEdhcnkgWWFuZyB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+PiArc3RhdGljIHN0
cnVjdCBwbGF0Zm9ybV9kcml2ZXIgc2t5MV9yZXNldF9kcml2ZXIgPSB7DQo+ID4+Pj4+ICsgICAg
IC5wcm9iZSAgPSBza3kxX3Jlc2V0X3Byb2JlLA0KPiA+Pj4+PiArICAgICAuZHJpdmVyID0gew0K
PiA+Pj4+PiArICAgICAgICAgICAgIC5uYW1lICAgICAgICAgICA9IEtCVUlMRF9NT0ROQU1FLA0K
PiA+Pj4+PiArICAgICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IHNreTFfcmVzZXRfZHRfaWRz
LA0KPiA+Pj4+PiArICAgICB9LA0KPiA+Pj4+PiArfTsNCj4gPj4+Pj4gK3N0YXRpYyBpbnQgX19p
bml0IHJlc2V0X3NreTFfaW5pdCh2b2lkKSB7DQo+ID4+Pj4+ICsgICAgIHJldHVybiBwbGF0Zm9y
bV9kcml2ZXJfcmVnaXN0ZXIoJnNreTFfcmVzZXRfZHJpdmVyKTsNCj4gPj4+Pj4gK30NCj4gPj4+
Pj4gK3N1YnN5c19pbml0Y2FsbChyZXNldF9za3kxX2luaXQpOw0KPiA+Pj4+DQo+ID4+Pj4gVGhp
cyBzaG91bGQgYmUgcmF0aGVyIGp1c3QgbW9kdWxlX3BsYXRmb3JtX2RyaXZlci4gRG9lcyBub3Qg
bG9vaw0KPiA+Pj4+IGxpa2UgcGFydCBvZiBzdWJzeXN0ZW0sIGJ1dCBsb29rcyBsaWtlIHJlZ3Vs
YXIgZHJpdmVyLg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gU29tZSBtb2R1bGVzIGRlcGVuZCByZXNl
dCBtb2R1bGUuIFdoZW4gYm9vdCBzeXN0ZW0sIHRoZXNlIG1vZHVsZXMNCj4gPj4gY2FuJ3QgcHJv
YmUgYmVmb3JlIHJlZ2lzdGVyIHJlc2V0Lg0KPiA+Pg0KPiA+PiBXaGljaCBtb2R1bGVzPyBZb3Ug
c3RhdGVtZW50IGlzIHNvIGltcHJlY2lzZSB0aGF0IG15IG9ubHkgYW5zd2VyIGlzOg0KPiA+PiBz
b3JyeSwgZGVmZXJyZWQgcHJvYmUgaXMgb2xkIHRoaW5nIG5vdyBhbmQgZXZlcnlvbmUgc2hvdWxk
IHVzZSBpdC4NCj4gPj4NCj4gPj4+IFRvIG1ha2UgdGhlc2UgbW9kdWxlcyBwcm9iZSBlYXJsaWVy
LCB3ZSB1c2Ugc3Vic3lzX2luaXRjYWxsKCkgdG8NCj4gPj4+IGluc3RlYWQgb2YgbW9kdWxlX3Bs
YXRmb3JtX2RyaXZlcigpLiBEbyB5b3UgaGF2ZSBiZXR0ZXIgc3VnZ2VzdGlvbnM/DQo+ID4+DQo+
ID4+IExvb2sgaG93IGRlZmVycmVkIHByb2JlIHdvcmtzLg0KPiA+Pg0KPiA+DQo+ID4gWWVzLCB5
b3UncmUgcmlnaHQuIEJ1dCBkZWZlcnJlZCBwcm9iZSBuZWVkcyB0byB0YWtlIG1vcmUgdGltZSBv
biBib290aW5nLg0KPiA+IFRvIG1ha2UgdGhlIGJvb3QgZmFzdGVyLCBiZXR0ZXIgZXhwZXJpZW5j
ZXMsIHdlIGhhdmUgdG8gdXNlDQo+ID4gc3Vic3lzX2luaXRjYWxsKCkNCj4gDQo+IEFnYWluLCBp
bXByZWNpc2Ugc3RhdGVtZW50LiBIb3cgZmFzdGVyPyBXaXRoIHN1Y2ggYXJndW1lbnRzIC0gdHdp
Y2UgKGZpcnN0IGxpc3QNCj4gb2YgdW5zcGVjaWZpZWQgbW9kdWxlcyBhbmQgbm93IG9mIHVuc3Bl
Y2lmaWVkIGJvb3QgZmFzdGVyKSB0aGUgYW5zd2VyIGlzIHRoZQ0KPiBzYW1lLiBBbmQgSSB3aWxs
IG5vdCB3YWl0IGZvciB0aGlyZCBpbXByZWNpc2UgYXJndW1lbnQsIGJlY2F1c2UgdGhpcyBpcyBu
b3QgYQ0KPiBwaW5nIHBvbmcgZ2FtZS4NCj4gDQo+IEFueXdheSwgbWFudWFsIGNvcmUgb3JkZXJp
bmcgaXMgbm90IHRoZSBzb2x1dGlvbi4NCj4gDQoNClNvcnJ5LCB3ZSBuZWVkIG5vdCB0YWtlIHBl
cmZvcm1hbmNlIGludG8gY29uc2lkZXIganVzdCBub3cuDQpXZSB3aWxsIHVzZSBtb2R1bGVfcGxh
dGZvcm1fZHJpdmVyKCkgdG8gaW5zdGVhZCBvZiBpdC4NCg0KQmVzdCB3aXNoZXMNCkdhcnkNCg0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

