Return-Path: <linux-kernel+bounces-807979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EB2B4AB8E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2521886BDB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6502A3081C3;
	Tue,  9 Sep 2025 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zK3Pp3uj"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD9F315D34;
	Tue,  9 Sep 2025 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416753; cv=fail; b=oDdPQCNezjEAnRAw+d5ftUD5Qt8J+s8gB5b1/Ye/8JVWF+v9oBx6cZaBhlJBbrLQjbu3c8t+Po+ThJNo537BuP0yFuOHu+ZRdtqDlDvahlyvEPtE7ZqotPV90fQv/qOV2lIqDfEmwGYEhDIqFHuQXopJ9xTxG1g11VNfZfZ2WUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416753; c=relaxed/simple;
	bh=/Io+q/801HDTbZj2109RngbWQ9/KAw2YcODB5D3TKpg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uuXgodR3oas+U52b9zLQPSk0oUAflN2LOheSeSFh3BlnYHxQuiyiXflfqSbrOKugOqqaqBOeF5sbljyksmqc/DCE8lg7YN8uh8oxEVEyHSjg6kvFgfr0xRK+4a8Ha8TdZOb2O26EJXXzV4PsYpDgy+tOsoCUtKplNPBywi/Q8nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zK3Pp3uj; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVc1fjcfM0ju0p2lqr0dpKvW6kDgaEtfiuLTSWXE9cP9YnAK+kJnwtezwB+r6jRv7KpNmQAm/ueBN20U1LXswTz6Go9BVyBFNvytXfYTGgl5gO+mitBvGD3gycBqb5vV7Qap6uArvyrh4cEiFC6GtSLjkVpy6QXZEouZkVugHNniuRZvFTzogjmhIf0JEoQn4vSyEcEf/n7wtMd4bl/fJBxu+0RQYQp32JhydplY/vo1F4nzQB7rnmM5jZ6PXH/lQzXHMNnvbrhE8bE1/YLbuO+H0KSHHt5WzPh2iy3+I8UE3UFIcE/FmFLPJLjgbkury0WlxJI5xC3RH4TSJ3/glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Io+q/801HDTbZj2109RngbWQ9/KAw2YcODB5D3TKpg=;
 b=dEsT3jkozwu7HPW8rVtz+fGWucbaugL0+FyNC3doSNfFI3tgSQLfjGbfciM4nyk3LSrS11ZhpXutk/fk1sB06deZ6E7mKKZyhvVzqIFVfdkDKE+6OIUd61YZ8PaM5hwPBFGHhPNU2JBymdejxpoSJsJDmVkjL6/mjgWjBRJunoYDyJlgbzKBuPqZRg0D+YIZg8w8wfXB/ngS3rghWxWe7Q/NFIa/qE6arCdKeniZtajYzEB6cRwP+ICAXNkIdHQMWSF2GihGFkWd+ig17ryppCqHEpJphhbmstyiOhCmiCSCShevo0wZdPbISou1coW0iGM4jianHm0+NmnyLgqc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Io+q/801HDTbZj2109RngbWQ9/KAw2YcODB5D3TKpg=;
 b=zK3Pp3ujjD8PRt3TaliwVNLwVu4sCkBW2m5uxnEJAVB4ZEL5ngXY4N6GGMyt8xlfGxughcGtcs4D60wVrvNYbdqEiRV+EnvLuFgx7z7Fftg42EYrpRqp5JbbR8ubJHZOmunfq4Oz5HUEhA6II61VO9TPLw+w+l3/Y2+h9yFX78dkd3iEDB77NLT8Ik2zhqvcX4IutQ8LKS7+jOGevuR/5nh2gF3s+jRvbicoLzmVY8oo942DQgw8q5/BU9VJzNmIa4Hk4KZyPAxTBGg9LiEUFPqFN1zGYYzCTgY+/1q7XttIjTY86Q67IQ4J2P1Z8O5Mk51XfgunupMe/PUIonzIpg==
Received: from DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) by
 MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 11:19:08 +0000
Received: from DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347]) by DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347%6]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 11:19:08 +0000
From: <Durai.ManickamKR@microchip.com>
To: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Balamanikandan.Gunasundar@microchip.com>,
	<Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 1/4] clk: at91: sama7d65: add peripheral clock for I3C
Thread-Topic: [PATCH 1/4] clk: at91: sama7d65: add peripheral clock for I3C
Thread-Index: AQHcIXrab/QyMa1RnU+sGDpA2xPiCbSKtCYA
Date: Tue, 9 Sep 2025 11:19:08 +0000
Message-ID: <bde8c4e5-6116-40ae-8bd3-e76d5954c461@microchip.com>
References: <20250909111333.170016-1-durai.manickamkr@microchip.com>
 <20250909111333.170016-2-durai.manickamkr@microchip.com>
In-Reply-To: <20250909111333.170016-2-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6541:EE_|MN0PR11MB6088:EE_
x-ms-office365-filtering-correlation-id: 97d865a6-5491-419a-7e3c-08ddef92b1ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUs1d3R3bFUzOXJDZGZ3SlBrVWgzMU1OTlJuLzN6NHdQQ3N0UFBsRG5BYS9D?=
 =?utf-8?B?MWh0aEtYRG1XS1U5QURSSTN0Zks2aDR2dTgzQlNmaGgySDhleGxsOUdkVzRD?=
 =?utf-8?B?V2RpMEVJS2hVTEU2c0h2TU5SS0thRzFGNjRoS2NzOStIdXJMZmM4QnlLeWFq?=
 =?utf-8?B?SHRqN2MvSTk5aU5mempyS2d4SzFZcWNodVBKdHpJTXBNbjNLd0ZFelh0clp0?=
 =?utf-8?B?VjQzMWladzMzYkRJajdkWTM1UURLcU1EaG1keFk2d1FxRXl4T1MwWGMwaFQr?=
 =?utf-8?B?dWZaWlF4eVZoOG1MZjBUYjFVTlRnMTN2QWpkZjM2NExnN2xvblJQOEVpQmxr?=
 =?utf-8?B?YzY4cmdjeVNBYkh4YmJLTElDanJvUnk1SjFyWjVBa0cvaGFvK2dHNVNRNXZ6?=
 =?utf-8?B?Z3BjMzI4Yzl6VmNmZTVBWjY3WVpiKzZZSVBBSUpuaFA3alF1MVlHZHorbUNP?=
 =?utf-8?B?OExZUTZwZlNPZVl2TnpYUzZpcG1QUTJyUEVxbENOS0pMdko4MkdkVEZjekxE?=
 =?utf-8?B?Vk40QnYydHZYMFRQVUdlUlpuRVkvRGVkd25xVEk3Ukhyem5xT0dVcmpySUh2?=
 =?utf-8?B?Y1lBUGJ0SEZoQk5rQ3dVZXR3KzBTRUM2eC8rUXcwa2tVRkJib0N5U2xrZU9l?=
 =?utf-8?B?VjdFeS9tMDUraGplNzlXQml4MVJwRFJZOEpReXIrUFRablZxR0paVVM2Qm1r?=
 =?utf-8?B?aE9pK0JlQXhLZ3EzWGp5RUxHRzVWbEJTUDJpalhOdjdZbzVhTHpNU3JneHh0?=
 =?utf-8?B?NUt5a3hRN0lMcHZzSlFaYkNQVUdWb2sxRjZvb0duS3FqejJYUjhjdFc5QVhO?=
 =?utf-8?B?N2RrZFI5bUFZMW9qZVFHNDVwc3M5b1ludG9UV29HNWk1THplcnhpRU1Yc2tt?=
 =?utf-8?B?VEFzdWJycUlvSnJtT2ZRWUMxR0ZUdlQ5dkVEM3NZNEh6ZnlOMEJaYkFpWGZS?=
 =?utf-8?B?aElYSXo1aG1kRnRZZmZ3aEgwTWpNekZRMEYxV3lWY2paaGF5Sm1jU0puK1ph?=
 =?utf-8?B?ZG1qT3cxbS9wRTBrSDZpb3pYbFl0eEE5ZVJkUHEyUjhrTDl2aEE5Ky9tVFhE?=
 =?utf-8?B?RCswOXkvaHppVlNuaWVqLzlLdHJTcW5XMWwzUzFxZHUzRUJ2U0dTdGpKQUpE?=
 =?utf-8?B?UzMzaVR0L3ZJY1ZHWkdQTWRESXJGajZ2NUpORDc2REdyeFRtcHFxM3VNOWhw?=
 =?utf-8?B?bWNHMWFiMzlFT21leGk3QjNSSVJ4bWJ0ekw1WkNwSjlJc0FYY05kR3VNMElw?=
 =?utf-8?B?U2FIdCt3MTNuQmZ5M1VFbGo3azhmeXJCRTZkZHhVSUlZOTVyaCtHMzUxd1lv?=
 =?utf-8?B?YkRxVzBaT2NOa2F2Nk1vUkU3VXZKYi9wMERWcnJEdzAvdGZ5U1AydC9MTjRX?=
 =?utf-8?B?UWdPUGlXbVVJM3RCSXpDLzVjOFFEejFXc2pEdHlsR1B1NTdjZzR0SEluMHJm?=
 =?utf-8?B?WloybnR5VEpYMnUwb3kvNTFOd3E4QlBxM09uVnZzWEdwN0dSejRPMTMzdThF?=
 =?utf-8?B?c3JkM2pUK1B6Yjd6OFNZSGJLamhDRlBOMVl1M3M4dXR1OFpXek1qQ051dFA1?=
 =?utf-8?B?aXozSnA0Szhwb1RsMUN6UDE1TjRiUDlONDM3SHZTamwvUTRBaUlBLzhDMHNQ?=
 =?utf-8?B?bVg5NklNN0xUWkYya1VhT0czRUpheFgwNkZFQnpZVWl4MVRONExBQWU1eGhh?=
 =?utf-8?B?UEJtTWlYM2xieTVialZmQ1dpQ09mYjNlZmd2ZUpZRkErczhRVnVXbk9peFZh?=
 =?utf-8?B?SkhPNVNYTWhjYWRJYVJEMjdqMW1DY0g5aDU0MjVTdUQrUWwwVE1pcXRLTVpo?=
 =?utf-8?B?VWJML2F6Rmk4aVEwdExoRXVPN0VKY1A2WVo2bDJLSTJNTG1QOG5VZDl0TEVU?=
 =?utf-8?B?MzEwNURyZ1J1ZXBLdktvRTE4TEJKZVZ5WGEvQTlrV2VHWVc4S0lvamYzVWJO?=
 =?utf-8?B?b2FqV1B1OS9KWDVzQ2Uxb2JESDc3VG03QWVSUWxDZjIvRGpaT1hQVG1aM3JT?=
 =?utf-8?Q?F4Su6Zw5cYOm03RTTiAZIitIJ+ryVs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6541.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXdUUnVlMU81QmQ2SHVNUnlTWENuUGFYNVoxNC9FLzBGWG9oQTEwMDFnOXcy?=
 =?utf-8?B?UDgxd2VYQWZrSUF0SUUrc2x4UWVZbEJYZlFHai9JaytlV3EyNWZXWE9qV1V4?=
 =?utf-8?B?WU4yZjVXRkMrSmEybEVYYjY3VTk3dCtGVk9QYmd5dnlwK3NYK0N0bzZtcm0y?=
 =?utf-8?B?b3hEQ0VIaklkdzVHU05tZHlsanY5Sm9qakwzQTNSbEZGWmNsVjRSWWFCSmQx?=
 =?utf-8?B?NUJoeXA1VkJPb1J0YmNUVERNSktWeENkMUdGQWZWTkxod05qNWZHUFV5Yko5?=
 =?utf-8?B?ZW5hWk4wZFJXY1VianVWQjVrRU5XdFhzbzM0MTNQY2llWUt0NnVpWWQyNnUz?=
 =?utf-8?B?RkI2RlJBUjYvTkxEY2dFaHI0UmV1NEk2dkRneExZTnhpNEYzaFluUlpZQk5R?=
 =?utf-8?B?em5sOFdNY21CRm5iTWt5TU1hNS9oVlh0QXIvRTJOem1mZnZLTEZRRmFrYUJ5?=
 =?utf-8?B?Tm1QbTJ1cFlJYXhKWVVOblBndWFlMEhPWHBSOHVjNFdpMzg2RTJ5dlVMYlFj?=
 =?utf-8?B?Q3VQWldMQUFLRUlpR2ZkQitFTWZyUTh0OEJLVXlIZE9CS3VDQmtOZEFUNWNG?=
 =?utf-8?B?a3RSamU2NXd2T29RTERGbEMzWGlobzRsUW8rTlE3cVJEaGtVakVtN0VnSE1v?=
 =?utf-8?B?aStmZE5ZSk8rcGJjS0ljN0owS0l0Vzhocnh0eFp0WDl5RUtuVGVjV2o0WXE1?=
 =?utf-8?B?WVFMY0pDU3hKNXVmN1BjL0pQWmdHdGIvc09aeTlRWnJEb0k3SE96SFhwR3lR?=
 =?utf-8?B?QitRWGlNR2U1ZzFoQVJIbUgzTEplU2dDQ0lpd1R4b1BaMXNnOUkwRmJHMkZK?=
 =?utf-8?B?cnpESEVoNjFsMzhDdzAzSUMyNW8zY0xjUjFuZW1VOTVoSS8vb0EvUHNnUVUw?=
 =?utf-8?B?c25EOGVMbkhnS0lpaW5yTWltcEFyNHdSVVA1MlVNTWNYMHc2S01UcnhkVmIr?=
 =?utf-8?B?bEhJcllVUW1GY1hhc2xkRC9TVHhKZ0ZocjZ4d0p3d2dGQzFUQXhmV2JqSXgv?=
 =?utf-8?B?dmY3YmNHNmJoZUZwT1oyeSs5TzQ4bnMvQWpUT1hzcjVzeER3ZlA3S05USXI2?=
 =?utf-8?B?bExOZnpkbkpJanNhNThRNDhDWGRDMTVMT3JwcUhDeEFLZm56dG12Tm5OMzAv?=
 =?utf-8?B?d0FZWGI3aUVCV2pEeHAwTTFhQmJZRmJTU2gyeWtBUVZNZGpXa0krUVVVQkdO?=
 =?utf-8?B?TDMvMlo3eXlaKzRFbjViNWprQktMV2RDeUtTVTdQdHZlMnB5VkR1b0p2Nm44?=
 =?utf-8?B?KzFObkllNmZuUVorL3V1WDJzUGVHSGhwekRoQkEyaWFrNnNOOC9udTZwQTBP?=
 =?utf-8?B?L0hVeDNJd3lyMTlnUE9RQlBpSlk5N0diLzRFNHBLV09OWWhpZ3JWSitnSnN0?=
 =?utf-8?B?c0E3TnRJRGk0RkwxT0ZZaHR6bVc4bUMvZkVOUzlFS3o1b0Y2cDRqeGhFL1Iw?=
 =?utf-8?B?dGt2REt6TmxrQUUvalgyOU1SREdHYlVvam9aeFkyb2RNSjlXRURNdERiZ1N2?=
 =?utf-8?B?SmY1UENZeUFIYnNHMmNER0VwMlpzMTdReUQ4VzR0ZVE0ek1ibnlxRW9zZDR6?=
 =?utf-8?B?L1JZQkZZWGFOck4ycURXVDZkTlBwRHIwR3Y2TUIrbHVpbnM2SCs2RDlUSVhp?=
 =?utf-8?B?KzBrUWdQWFJkWHcrUHJWcGpVS3BQMHRIOUNuQlUxTHdIK1BYVERLTkxMVU1Z?=
 =?utf-8?B?OStoQzBsQytGdlY5MWRWcVRyVDY1T0dvTTk0UFc4SGZzNzhzTWVFUE4yYUtT?=
 =?utf-8?B?cjZ0dTNFaHdNMmJ1WUNla1hTWUpqZzU3a2RiKzVnMW9KZ1NjM2lvZkVwOEFk?=
 =?utf-8?B?QW0rTmdwek5aT3lVVFZub3Y5OTJ5elNCZ3UrTll4ZkJEcjFKa1Qzb2lkdG9n?=
 =?utf-8?B?MmFUTmNiaDJieitxM3puaVVORVQzYzRURTJTOVU3VjNCbTZXeGhUdDN1RUww?=
 =?utf-8?B?QkN2b0Z2T0t4b2owU2JiNzdXZi9UcFhhTlNoejRXRW1oSHBFYzVvNXN3NWkz?=
 =?utf-8?B?MDc3Z0lTY2FleEJOTzVpeXlVNlR3ZktJd3YzM0o5dUtjaklkOGY4WE5kK2tN?=
 =?utf-8?B?MEpycHUydk9GelYrTWoveWVsSDE3YksreWVqSFUyK3l1eStuQUdJeGQ3bWVl?=
 =?utf-8?B?Y0JVa3M4eXRBYkZ4OURXSFVDbERvSkhqeUVHR2VHQ1d2ZWg1NGlROU9ZMVk1?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD9397EEAB37F54C9314B2651E34A242@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d865a6-5491-419a-7e3c-08ddef92b1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 11:19:08.0883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGKF3ik8jZpdiqfjsA5Tnal5DPPaOlRdB/BS9n5Q0WnQE+KAxcLSpMmxMt1swEjoidFelloc4NBapDMhq/nFLQC0lRvOJdfS6gnAanKaS5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088

T24gMDkvMDkvMjUgMTY6NDMsIER1cmFpIE1hbmlja2FtIEtSIHdyb3RlOg0KRHVyaW5nIGNoZXJy
eS1waWNrIHdyb25nbHkgYWRkZWQgMyBsaW5lcyBpbnN0ZWFkIG9mIGkzYyBjbG9jayBjaGFuZ2Vz
IA0KYWxvbmUuIEkgd2lsbCByZXNlbmQgdGhpcyBwYXRjaCBpbiB2MiBhbG9uZyB3aXRoIHRoZSBv
dGhlciBjb21tZW50cyANCndoaWNoIGlzIHlldCB0byBiZSByZWNlaXZlZCwgd2l0aCBvbmx5IGNo
YW5nZXMgc3BlY2lmaWMgdG8gaTNjIGNsb2NrLg0KPiBBZGQgcGVyaXBoZXJhbCBjbG9jayBkZXNj
cmlwdGlvbiBmb3IgSTNDLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBEdXJhaSBNYW5pY2thbSBLUiA8
ZHVyYWkubWFuaWNrYW1rckBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2Nsay9h
dDkxL3NhbWE3ZDY1LmMgfCA1ICsrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEv
c2FtYTdkNjUuYyBiL2RyaXZlcnMvY2xrL2F0OTEvc2FtYTdkNjUuYw0KPiBpbmRleCBhNWQ0MGRm
OGIyZjIuLjg0YzZiYmUyMDg3MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9zYW1h
N2Q2NS5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEvc2FtYTdkNjUuYw0KPiBAQCAtNjcxLDgg
KzY3MSw5IEBAIHN0YXRpYyBzdHJ1Y3Qgew0KPiAgIAl7IC5uID0gInVkcGhzYV9jbGsiLAkucCA9
IFBDS19QQVJFTlRfSFdfTUNLNSwgLmlkID0gOTksIH0sDQo+ICAgCXsgLm4gPSAidWRwaHNiX2Ns
ayIsCS5wID0gUENLX1BBUkVOVF9IV19NQ0s1LCAuaWQgPSAxMDAsIH0sDQo+ICAgCXsgLm4gPSAi
dWhwaHNfY2xrIiwJLnAgPSBQQ0tfUEFSRU5UX0hXX01DSzUsIC5pZCA9IDEwMSwgfSwNCj4gLQl7
IC5uID0gImRzaV9jbGsiLAkucCA9IFBDS19QQVJFTlRfSFdfTUNLMywgLmlkID0gMTAzLCB9LA0K
PiAtCXsgLm4gPSAibHZkc2NfY2xrIiwJLnAgPSBQQ0tfUEFSRU5UX0hXX01DSzMsIC5pZCA9IDEw
NCwgfSwNCj4gKwl7IC5uID0gImRzaV9jbGsiLCAgICAgICAucCA9IFBDS19QQVJFTlRfSFdfTUNL
MywgLmlkID0gMTAzLCB9LA0KPiArCXsgLm4gPSAibHZkc2NfY2xrIiwgICAgIC5wID0gUENLX1BB
UkVOVF9IV19NQ0szLCAuaWQgPSAxMDQsIH0sDQo+ICsJeyAubiA9ICJpM2NjX2NsayIsICAgICAg
LnAgPSBQQ0tfUEFSRU5UX0hXX01DSzgsIC5pZCA9IDEwNSwgfSwNCj4gICB9Ow0KPiAgIA0KPiAg
IC8qDQoNCg0K

