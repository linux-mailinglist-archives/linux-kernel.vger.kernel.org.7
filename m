Return-Path: <linux-kernel+bounces-723831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E24AFEB6F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5287F1C81770
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4EF28ECF2;
	Wed,  9 Jul 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b="LW44kW98"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020074.outbound.protection.outlook.com [52.101.69.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2910D2BE048;
	Wed,  9 Jul 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069900; cv=fail; b=UqCdWu2wnTp5A8nK68nrHCh3uQXY3gJSnc2McelXtYG7aX48LsdTxjkHARFO3n/7R2nDNWbhrpr1vSJ1DQxpLL29V5iU76XE+M25BysA5mzqPIf0vPGw0GDuhvf6SHtqovobnCQVwD9hp8YCxdQ/7hQWj922EIP7S2z8T1LdjTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069900; c=relaxed/simple;
	bh=f4xHTHw7kt+dQ7RiavEr+ahy3okla4amEQBGdkpgtt0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OSk+KeexXr5n4LM56R4ifyAUeO9VO/v09PrnZP1w9NN2xrWEYGsYPtCUnf8dtJ6u8hWshqjn/mN+4Ymp1+hmVymYBQ2SRgjSLYghtIkysueqS+TGwlXM6ix7LEK+Y5yj9zne0PhMcOjjdnVnulDEUIshwjovebe9IQACX07YRq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com; spf=pass smtp.mailfrom=htecgroup.com; dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b=LW44kW98; arc=fail smtp.client-ip=52.101.69.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+9MQmkqYnK+F9TkErUgO7LeGFhTUvAENmwJ4vPnJscpjcGr6bjWS/IjL+98tp9zhGqCby+ltFXYNDFTnltBEy32qFoxS8DwLXwRRqfdD9fmJDxBUNhXY0h5Flgz3VicbrkMxs7Hdk9u4lDzaLX9eyoLCX7iox7kgTw0yof8D9eR+XzNlK01BVSENlPMnC03v+jBTk4pJzCKm8gRQo8oX+udw5qKNZX7ddJCVB0A+0Ap4GPNADV3wJBFltWn5cCRl99D5gIhyPAu4ntG8YgILPI6spAc6LtYO5s055l9taPcyfIJgjSwVI8/bi9WGr6k5G/99KzEMhhvKuLsWk822Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4xHTHw7kt+dQ7RiavEr+ahy3okla4amEQBGdkpgtt0=;
 b=lARAnikNzwwr4EDjocYwIgv/6ax7VZ2DlrTleWxM6FT2tFDQ7u9Ipn4RWBNrQgrX2CSec5mkF51tbTLhIKUfk55pPqM3PyviKQlr4b/Jrx4A0v/MNv0+iXzizcNLU5WlPiriB2rayQFKD1QvV48m4pOBgvFBfDYaeh97KDOMGNh/f6HuXE3Z3NVUnuKPo2l3xMWsQWrR4UUhEkYz4DIIpJqUtrTcojZFBJo7tQ/IcmbYduzIO8eOf6cI4j/Rhf/Uuo0LJMMD+1Dtp+QQhH5IeERACJqvPKA8qe67TQvaYkF27K+hhcWk3E4wdyhvFRk4Y8qfwjLL3SBfut59ugtYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4xHTHw7kt+dQ7RiavEr+ahy3okla4amEQBGdkpgtt0=;
 b=LW44kW98vOOgyFBjZEX0P0Geikk1t8E6lmXjUKvJbPDfMbKWs2B8jqB92yiz7ziXv2/ROg5/nauh0UeodKpcpUE1dbBlD1w1myOYHnXf31MUgJfm9Sucd5ukYb3uYaNVVtRg1H6Aav0TofyxlpQt5CHVZAWGDzYPKZyeO/PJfK4U5sJsdUMvzoVcWyE/xefGw7J37AlLE0kfxj2VNARkGFZPNW5O1EUP8rcgQV7DRSbVNzvVAMMP91VJnOx7rZaGVNLvTboJXffNHaKjDpRnwqxXANx+f4c1s3TfMY1R/AeDjU0mkl7G9mIr0ZPU5TVoKwyyEfrL88fAuOtLSR2WVA==
Received: from VE1PR09MB3261.eurprd09.prod.outlook.com (2603:10a6:803:11a::20)
 by VI0PR09MB7143.eurprd09.prod.outlook.com (2603:10a6:800:23f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 14:04:52 +0000
Received: from VE1PR09MB3261.eurprd09.prod.outlook.com
 ([fe80::bb1d:4999:85b7:cc11]) by VE1PR09MB3261.eurprd09.prod.outlook.com
 ([fe80::bb1d:4999:85b7:cc11%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 14:04:52 +0000
From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
To: "ajones@ventanamicro.com" <ajones@ventanamicro.com>
CC: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "conor@kernel.org"
	<conor@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"devnull+aleksa.paunovic.htecgroup.com@kernel.org"
	<devnull+aleksa.paunovic.htecgroup.com@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"palmer@sifive.com" <palmer@sifive.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "robh@kernel.org" <robh@kernel.org>,
	"charlie@rivosinc.com" <charlie@rivosinc.com>, Djordje Todorovic
	<Djordje.Todorovic@htecgroup.com>
Subject: Re: [PATCH v4 6/7] riscv: Add tools support for xmipsexectl
Thread-Topic: [PATCH v4 6/7] riscv: Add tools support for xmipsexectl
Thread-Index:
 AQHb5dxjaqbHoDAWk0qz9dJPHr4eTrQVK5UAgAADr4CAABUIgIABblaAgAApQACAEw1FgA==
Date: Wed, 9 Jul 2025 14:04:52 +0000
Message-ID: <2859ccc3-49f6-47cb-aff9-62704c2356be@htecgroup.com>
References: <20250627-4830df29795364099432e6ee@orel>
In-Reply-To: <20250627-4830df29795364099432e6ee@orel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR09MB3261:EE_|VI0PR09MB7143:EE_
x-ms-office365-filtering-correlation-id: 34c4623f-3ad7-4241-3b16-08ddbef1931e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bDA5a1JuT3RlNXY2NExZcVc1TnpCZnJ2RWY3RXJBNktqK0Nxakp5TTh1ZVVw?=
 =?utf-8?B?citzRmYwSjVsM3RVb3pIZ2ovNXBTeWt2alhWTVpPRVEzSERyUVdJdjNvdUZs?=
 =?utf-8?B?SnhqampEdHJZSXFwbGc3WUppUXFqMUNNRGIxTE9IbmxlRSthcEV6ZUV5M2F4?=
 =?utf-8?B?b1FHcXB1NDlGM1RiRnlpdTZoMDJaaTdxZ0N1TmVqQ0kvakZLVU9Wa2RxSC8r?=
 =?utf-8?B?d3FRaVpBeS9TWHNOWCtrT0ZZVUZqaTRUL3R2VVJXL3pydnFGUGNBVldHdFQ5?=
 =?utf-8?B?bDR1N1dDeG1XWEhZN1F3MHErbmRYSTFkVXJrNzgramVMNXVHVmVDdDAzYSs2?=
 =?utf-8?B?cVY1R1U2WHBVVkxrYmlwdjdjeENFekFqMTZBVjYxOWFyZDlqaUMyOTljRGxk?=
 =?utf-8?B?SXBXdkNKT3pZZWZiMFoyUlNQbGRTZVBwNjBxbVY2cjRSemtaWHNUaHhHbm5o?=
 =?utf-8?B?VkUyQ041Z3dNdys5RktTck5CZDFSUmZ6NDFlSzFVSVJUV1Z4L25ib1B3R0Fu?=
 =?utf-8?B?OWczenRGdXlIRFZoY1djeE9zdEUvREZvd0pJUnFFQTNkc2tjWHBYaEpRTGRl?=
 =?utf-8?B?N1h2SXE5ME1ERSttNnFMUUR0dnRYYXBxUFh2bDY4VmVucm5iQjZtUWt6WERq?=
 =?utf-8?B?b0ZQSnJpTUFVM2cwcDh6aVBZNmtSbzFLSmUwOUoyTXdPQ29vb052eS9wK2Nt?=
 =?utf-8?B?RFFMUEh1Vm4vWGVPalI1anhhTXVISFVwKzZpbVErOG4zUVBUSkxQRm5PRVVv?=
 =?utf-8?B?TituSmFFMndPNzNkVlpxSi9uVHJuZVdYK1d6SEo2MTZDZHpJd2ppL2gwNFB2?=
 =?utf-8?B?V3Z6dkkzeFNtcC9oT0lrUU1IOWVRWWowUWZtVHRTUzUvbk1WbGtXeGsvZUYw?=
 =?utf-8?B?RGI0S2tRVmgwNVJvS0luMTUvU3gzbGJuMEZELzQ2eU9VTGk1blVFa0NLM1Vj?=
 =?utf-8?B?S3hrbHowVzNYSlR3VHQ1ajNVRWRDMUI0YlQ3M1Y5NXJXaS9yK0p5dExTVndm?=
 =?utf-8?B?L0IzNXEyTGtzZHFLaWtrN2hLREVMQmxMZW5nMi9yTFBiVGRsZzI2cWJrMHl1?=
 =?utf-8?B?YW5aOXQ2aWF6M2RJNVUwNnBScHdpb1F4Y0U2cDA2enJHN01Zdml3bWI5ck9W?=
 =?utf-8?B?QlVDUHZqM2R2Y3lpYUNhR1lFTXRQUHNFd09IWGoyOVJPcGxaQm9OaWRNelBu?=
 =?utf-8?B?WnYxOWswNmU0dmtjWnJ3b1JXQVd1NWpDbStUU1FJTEt4NWpMNGxPQjRWdTJ5?=
 =?utf-8?B?bXZVVGhSSXg4dGkyc0JuamFPc3lGSnNQUDNaR3JET1JUYS9XclQ1QXZuOSto?=
 =?utf-8?B?aVphL2JNYkZWaDMvR3U1L2EyVTIzN0lyam9tQ0pmeDVsQTY5VFBqbzBVUk8w?=
 =?utf-8?B?QTBBcFBSaDFOUDMvZmhydjd6YlF6cERKaVFWR3VlTWk3QlVCcG5jR3haY0xF?=
 =?utf-8?B?VjJDZVpyUXIyMjNsWmo1VSs0R0FjRythWmJGMTdhTzdkdUZDd0crREFTUFhZ?=
 =?utf-8?B?Z1BTVEJYS1Q5dTJrbHBPVHplWXhKMEowUEJJM1RmK0JQeGNZTXozTEVqa3JJ?=
 =?utf-8?B?c0hVUEdweWh5K055ZzVtTk1zWHRjTC9HZFJhdldaYmt1RXdzYUFyN1BsTVlk?=
 =?utf-8?B?OWNWYXAzcFNTUmJVbHFOTkVHeTZjZm14STJ0V3d2UkZSci9FRmtKdE00L2xQ?=
 =?utf-8?B?aEJNa0FRNXE3d0VjN0l5Q29FRW1QSEdHZGtSM3RaU2tIa1pSbzRTQ1lkakVS?=
 =?utf-8?B?STl5SThkVFFvOVk3SXlTR0w3R1NwdmhJWW5wT2xZRXFiRmF0UVFLZEJsVjhs?=
 =?utf-8?B?Q0U0ZDVpYnREb3dqQi9peEVvWDYyalhPRzZhWG96b2tUSUZaNjJmWVFseEd4?=
 =?utf-8?B?R0VZZG9leTJvSmhRVjFzQnRJZU5lZmRjUzZVYllXb0JSMDF6LzRPcXZUUnhS?=
 =?utf-8?B?b21qNExlVkNwS2paQ3d2cnZGMTVWb0Rza0xYWWlFWG1CTU8rMVNmY2Y3d3JD?=
 =?utf-8?B?Yjl6VnorZjZnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR09MB3261.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlpRZTZkU2RHaWtrL3IzM2xSWkxPWDFBWitwRjlUeUdCdFBEZEJxbzdPODhM?=
 =?utf-8?B?SzhOT09Rb3FxRmpkd3FIbFNnOXpRMXFjUEpjZWhBUkdZNkw4OWk3K2xEL3lN?=
 =?utf-8?B?VURTbHZ3Z1pFczFHVjNZNTVVaG1QbFRKUDRPZHlYM3dyQ01zeHYxVXBEL3d1?=
 =?utf-8?B?dEh4blU3bmEzaGtSRk1GMElyVk5Ic0haQ3plcGpodWF1eXZKTC9LVS9BRWhH?=
 =?utf-8?B?a21TOFdlb0hRZ29RMjQwRVJkOE03NGR1TjgxZmI4WVJwL1ZRV3pFakVxaGl2?=
 =?utf-8?B?djJCK2RDUjFaSE1mdzArM3ZMbVBNc1dpTVBKOTFLZkFocjRSVmJtc1htRHQ0?=
 =?utf-8?B?ZzNnV0Y5b3VLM1BhbFcyYXNuTk96c01MV3NiWlF0cmlsMkk0TWF3MDdsU0Zv?=
 =?utf-8?B?Z0RhMk5yUTJEclZWa0NHaHdCMVAxK1NCK09iWkE5MmJ3WWFuWVVvU3ZkRmVT?=
 =?utf-8?B?cEJTS1oyNWU0OG81TTRFWXdOWjc5cjBzeGdrTTN3NDFoTlNLbW9EU0lPMUJQ?=
 =?utf-8?B?elNOWXMvMnNLZ0pyYk0vV1JHd2p1SWRtNmNUWkNGWUh1cndrQkhkL0ZKbnFO?=
 =?utf-8?B?NVFRLzNsOGJ4SmFpY3NoWnI2V1BMcThtV0xKTklYbEF0aWJSb082a1A0dHox?=
 =?utf-8?B?WjFyZ0VQdmRSOXNNdDNVNWRxejgxN1Awa0hJUlpOTmN2NFZ4cnJYdnczSG1i?=
 =?utf-8?B?TFNRbGgrVUVMRzJUcFYxYXhFbFlEOHhKQWVYS21zdGRHZHA4ekUzM3dQOHB0?=
 =?utf-8?B?S3RVN1lvcDE3RENHckVaRmt4Z2RPZmU5dHMwVlJuT0xmci9qWkdVTDcxRWtC?=
 =?utf-8?B?YktEUGpPYzAxd0VHRElnZDJ3ZDVjQXB1VVl4ak4rYU9QNkdIdTF5SGw1RTN3?=
 =?utf-8?B?VVl0WE94TWdwTURaeWcyU3dwNS9UWjZ4aFczKzVuQ3BIcXlkL0FNQ0JKZkZD?=
 =?utf-8?B?VXJIc3N5UFY1aVh1WVlRKzZmdGt0TUFRWHZEQU1za3hQc3dtTSs4TUljQlBJ?=
 =?utf-8?B?amV0T1lQYlZpbldJTmt2dW5pMkY3Y05WaW5JTDQ0SjZkT3Z1NjNza0JTOVRR?=
 =?utf-8?B?ekYyREF3V2xYT3RrR3lOTzd4a0VjMFZ0Vnd2M0QwNHRqMmd1Zk9YTGJRb2xt?=
 =?utf-8?B?V3JPNE55bVhKUXB3K2tHVlc2SFVSUkNEN04wMDNUUWwva3dCSnYrUzFkcVN1?=
 =?utf-8?B?cjBsUk93UURZL2pYbWJuN1JwdlNYaWdpbjdBT2lLWGEvSjE1T3JUMCtsZXVB?=
 =?utf-8?B?UXZ4T1FVZXJWYU9NalhEMVhidVU2T0RPVTFWL3RKWVpiZW9lMWQ0Z2ZqMW5D?=
 =?utf-8?B?ZWhNN2hkYW9UeUFxazZrRGtBaENIcUlYRzlub0JRYmxVY3MrLzB1WmxKS3Ew?=
 =?utf-8?B?OTZ3ODZpLzdLVDd3dVZwMWJ0Y3lMdkdlZU1HeWRhQURUbEtoajdGYkZoSFls?=
 =?utf-8?B?Qy8wcVZlSWEzT05FSnU0LzYvbitkT09KeWdMajArV1pLR0pDZ2t0VDV1dUlQ?=
 =?utf-8?B?Rk50S2U0cFlIZzBSZzFCLytLQzBPTThmNTRhenh4dERvc2Z3d0ZSem9HVWhj?=
 =?utf-8?B?YnhQV0F1RHNpV1hNMEdMVWtYYlFkc1liT0ZncDBNcHFiWjRTakcweExFdzZk?=
 =?utf-8?B?SEoydzd4ODZTOFFLelFZTlAwMUZrSGZjRnNESjlNb0pXZWdCZWFQd3M0VjIz?=
 =?utf-8?B?ZVA0VlllQjJQS3BQWURJR0JZbkVoK3JkMUhpNEZieGVNTGtFVFZSbTY5UU9s?=
 =?utf-8?B?OEZtb2tLSmQyZVVLemJBd0xIZmdjOXh0UERKa3I0NkVLbXhCb2doQ21Mb1p1?=
 =?utf-8?B?MWQwd2NGRzV0VEpmTWpIRHVWWUJ2Q25rMEIxbENXTk81Tjhod0IwVkREamcw?=
 =?utf-8?B?MlZCcEpMOWpCbGxCSUNjeTNmR3lIeHQyK250OVVvbXVqZDN6NjBNQW5rYVIv?=
 =?utf-8?B?UmpMb3ducVk2Zm1JTEhCcStGS3FrV2NCUDZzMmZRT1hwV2FxbFFpYU11RTFU?=
 =?utf-8?B?TnFVcTF5cEhYQTZtdjZ6Z044YXFNQm1BOGFQZUJOQVFTOWErbzByS0dhaWZS?=
 =?utf-8?B?My80VmFPTDZDUng4cHRaQ3MvcTUrU1J1N0JZdUFBcWF6UURoR0pjN3dLbzB2?=
 =?utf-8?B?TncwYkY3YWtHRDAwLzQxN3kzSEYvdzhrUGdOMTRhMUxwRDdjRGx4Y1Q3VE81?=
 =?utf-8?Q?BI9gBC7kyfB+eDBMqpLAGFA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AFB8758DB70A441B003FACA08EA07FF@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR09MB3261.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c4623f-3ad7-4241-3b16-08ddbef1931e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 14:04:52.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agSow0lA2asTVLhVhTeYvGDhrkA+1r/KuD1+Q3XfPxwArdHmB1ur8WbD4KSNKnY165s16jYJvcw4hZH0KWVFpgwhKheR9rrrWQlJY+CdskI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7143

T24gMjcuIDYuIDI1LiAxMzowOCwgQW5kcmV3IEpvbmVzIHdyb3RlOj4gT24gRnJpLCBKdW4gMjcs
IDIwMjUgYXQgMDg6NDA6NTNBTSArMDAwMCwgQWxla3NhIFBhdW5vdmljIHdyb3RlOg0KPj4gT24g
MjYuIDYuIDI1LiAxMjo0OSwgQW5kcmV3IEpvbmVzIHdyb3RlOj4gT24gVGh1LCBKdW4gMjYsIDIw
MjUgYXQgMTE6MzQ6MjFBTSArMDIwMCwgQW5kcmV3IEpvbmVzIHdyb3RlOg0KPj4+PiBPbiBUaHUs
IEp1biAyNiwgMjAyNSBhdCAxMToyMToxMEFNICswMjAwLCBBbmRyZXcgSm9uZXMgd3JvdGU6DQo+
Pj4+PiBPbiBXZWQsIEp1biAyNSwgMjAyNSBhdCAwNDoyMTowMVBNICswMjAwLCBBbGVrc2EgUGF1
bm92aWMgdmlhIEI0IFJlbGF5IHdyb3RlOg0KPj4+Pj4+IEZyb206IEFsZWtzYSBQYXVub3ZpYyA8
YWxla3NhLnBhdW5vdmljQGh0ZWNncm91cC5jb20+DQo+Pj4+Pj4NCj4+Pj4+PiBVc2UgdGhlIGh3
cHJvYmUgc3lzY2FsbCB0byBkZWNpZGUgd2hpY2ggUEFVU0UgaW5zdHJ1Y3Rpb24gdG8gZXhlY3V0
ZSBpbg0KPj4+Pj4+IHVzZXJzcGFjZSBjb2RlLg0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1i
eTogQWxla3NhIFBhdW5vdmljIDxhbGVrc2EucGF1bm92aWNAaHRlY2dyb3VwLmNvbT4NCj4+Pj4+
PiAtLS0NCj4+Pj4+PiAgdG9vbHMvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS92ZHNvL3Byb2Nlc3Nv
ci5oIHwgMjcgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+Pj4+Pj4gIDEgZmlsZSBjaGFu
Z2VkLCAxNyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+Pj4+Pg0KPj4+Pj4+IGRp
ZmYgLS1naXQgYS90b29scy9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3Zkc28vcHJvY2Vzc29yLmgg
Yi90b29scy9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3Zkc28vcHJvY2Vzc29yLmgNCj4+Pj4+PiBp
bmRleCA2NjJhY2EwMzk4NDgxN2Y5YzY5MTg2NjU4YjE5ZTlkYWQ5ZTQ3NzFjLi4wMjcyMTlhNDg2
YjdiOTM4MTQ4ODgxOTBmODIyNGFmMjk0OTg3MDdjIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL3Rvb2xz
L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdmRzby9wcm9jZXNzb3IuaA0KPj4+Pj4+ICsrKyBiL3Rv
b2xzL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdmRzby9wcm9jZXNzb3IuaA0KPj4+Pj4+IEBAIC00
LDI2ICs0LDMzIEBADQo+Pj4+Pj4NCj4+Pj4+PiAgI2lmbmRlZiBfX0FTU0VNQkxZX18NCj4+Pj4+
Pg0KPj4+Pj4+ICsjaW5jbHVkZSA8YXNtL2h3cHJvYmUuaD4NCj4+Pj4+PiArI2luY2x1ZGUgPHN5
cy9od3Byb2JlLmg+DQo+Pj4+Pj4gKyNpbmNsdWRlIDxhc20vdmVuZG9yL21pcHMuaD4NCj4+Pj4+
PiAgI2luY2x1ZGUgPGFzbS1nZW5lcmljL2JhcnJpZXIuaD4NCj4+Pj4+Pg0KPj4+Pj4+ICBzdGF0
aWMgaW5saW5lIHZvaWQgY3B1X3JlbGF4KHZvaWQpDQo+Pj4+Pj4gIHsNCj4+Pj4+PiArIHN0cnVj
dCByaXNjdl9od3Byb2JlIHBhaXI7DQo+Pj4+Pj4gKyBib29sIGhhc19taXBzcGF1c2U7DQo+Pj4+
Pj4gICNpZmRlZiBfX3Jpc2N2X211bGRpdg0KPj4+Pj4+ICAgaW50IGR1bW15Ow0KPj4+Pj4+ICAg
LyogSW4gbGlldSBvZiBhIGhhbHQgaW5zdHJ1Y3Rpb24sIGluZHVjZSBhIGxvbmctbGF0ZW5jeSBz
dGFsbC4gKi8NCj4+Pj4+PiAgIF9fYXNtX18gX192b2xhdGlsZV9fICgiZGl2ICUwLCAlMCwgemVy
byIgOiAiPXIiIChkdW1teSkpOw0KPj4+Pj4+ICAjZW5kaWYNCj4+Pj4+Pg0KPj4+Pj4+IC0jaWZk
ZWYgQ09ORklHX1RPT0xDSEFJTl9IQVNfWklISU5UUEFVU0UNCj4+Pj4+PiAtIC8qDQo+Pj4+Pj4g
LSAgKiBSZWR1Y2UgaW5zdHJ1Y3Rpb24gcmV0aXJlbWVudC4NCj4+Pj4+PiAtICAqIFRoaXMgYXNz
dW1lcyB0aGUgUEMgY2hhbmdlcy4NCj4+Pj4+PiAtICAqLw0KPj4+Pj4+IC0gX19hc21fXyBfX3Zv
bGF0aWxlX18gKCJwYXVzZSIpOw0KPj4+Pj4+IC0jZWxzZQ0KPj4+Pj4+IC0gLyogRW5jb2Rpbmcg
b2YgdGhlIHBhdXNlIGluc3RydWN0aW9uICovDQo+Pj4+Pj4gLSBfX2FzbV9fIF9fdm9sYXRpbGVf
XyAoIi40Ynl0ZSAweDEwMDAwMEYiKTsNCj4+Pj4+PiAtI2VuZGlmDQo+Pj4+Pj4gKyBwYWlyLmtl
eSA9IFJJU0NWX0hXUFJPQkVfS0VZX1ZFTkRPUl9FWFRfTUlQU18wOw0KPj4+Pj4+ICsgX19yaXNj
dl9od3Byb2JlKCZwYWlyLCAxLCAwLCBOVUxMLCAwKTsNCj4+Pj4+PiArIGhhc19taXBzcGF1c2Ug
PSBwYWlyLnZhbHVlICYgUklTQ1ZfSFdQUk9CRV9WRU5ET1JfRVhUX1hNSVBTRVhFQ1RMOw0KPj4+
Pj4+ICsNCj4+Pj4+PiArIGlmIChoYXNfbWlwc3BhdXNlKSB7DQo+Pj4+Pj4gKyAgICAgICAgIC8q
IEVuY29kaW5nIG9mIHRoZSBtaXBzIHBhdXNlIGluc3RydWN0aW9uICovDQo+Pj4+Pj4gKyAgICAg
ICAgIF9fYXNtX18gX192b2xhdGlsZV9fKCIuNGJ5dGUgMHgwMDUwMTAxMyIpOw0KPj4+Pj4+ICsg
fSBlbHNlIHsNCj4+Pj4+PiArICAgICAgICAgLyogRW5jb2Rpbmcgb2YgdGhlIHBhdXNlIGluc3Ry
dWN0aW9uICovDQo+Pj4+Pj4gKyAgICAgICAgIF9fYXNtX18gX192b2xhdGlsZV9fKCIuNGJ5dGUg
MHgxMDAwMDBGIik7DQo+Pj4+Pj4gKyB9DQo+Pj4+Pj4gKw0KPj4+Pj4NCj4+Pj4+IGNwdV9yZWxh
eCgpIGlzIHVzZWQgaW4gcGxhY2VzIHdoZXJlIHdlIGNhbm5vdCBhZmZvcmQgdGhlIG92ZXJoZWFk
IG5vciBjYWxsDQo+Pj4+PiBhcmJpdHJhcnkgZnVuY3Rpb25zIHdoaWNoIG1heSB0YWtlIGxvY2tz
LCBldGMuIFdlJ3ZlIGV2ZW4gaGFkIHRyb3VibGUNCj4+Pj4+IHVzaW5nIGEgc3RhdGljIGtleSBo
ZXJlIGluIHRoZSBwYXN0IHNpbmNlIHRoaXMgaXMgaW5saW5lZCBhbmQgaXQgYmxvYXRlZA0KPj4+
Pj4gdGhlIHNpemUgdG9vIG11Y2guIFlvdSdsbCBuZWVkIHRvIHVzZSBBTFRFUk5BVElWRSgpLg0K
Pj4+Pg0KPj4+PiBPaCwgSSBzZWUgbm93IHRoYXQgdGhlIG5leHQgcGF0Y2ggaXMgaGFuZGxpbmcg
dGhlIGtlcm5lbCBjcHVfcmVsYXggd2l0aA0KPj4+PiBBTFRFUk5BVElWRSBhbmQgdGhpcyB3YXMg
anVzdCB0aGUgdG9vbHMgY3B1X3JlbGF4LiBXZSBkb24ndCB3YW50IHRvIG1ha2UNCj4+Pj4gYSBz
eXNjYWxsIGluc2lkZSBjcHVfcmVsYXggdGhvdWdoIGVpdGhlciwgc2luY2UgaXQgZ2V0cyBjYWxs
ZWQgaW4gbG9vcHMuDQo+Pj4NCj4+PiAoQW5vdGhlciBmb2xsb3cgdXAgdG8gbXlzZWxmLi4uKQ0K
Pj4+DQo+Pj4gSSBndWVzcyB3aXRoIHRoZSB2ZHNvIGNhY2hlZCByZXN1bHQgaXQgc2hvdWxkIG9u
bHkgYmUgYSBoYW5kZnVsIG9mDQo+Pj4gaW5zdHJ1Y3Rpb25zLCBidXQgaXQgc3RpbGwgc2VlbXMg
b2RkIHRvIGVtYmVkIGEgY2FsbCBpbiBjcHVfcmVsYXguDQo+Pj4NCj4+DQo+PiBIaSBBbmRyZXcs
DQo+Pg0KPj4gVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzIQ0KPj4NCj4+PiBUaGFua3MsDQo+
Pj4gZHJldw0KPj4+DQo+Pj4+IEl0J2QgYmUgYmV0dGVyIHRvIGp1c3QgY2FsbCB0aGUgc3RhbmRh
cmQgcGF1c2UgKDB4MTAwMDAwRikgZXZlbiBpZiBpdA0KPj4+PiBkb2VzIG5vdGhpbmcuIE9yIG1h
eWJlIHRoZXJlJ3Mgc29tZSBkZWZpbmUgdGhhdCBjYW4gYmUgYWRkZWQvdXNlZCB0bw0KPj4+PiBz
ZWxlY3QgdGhlIGNvcnJlY3QgaW5zdHJ1Y3Rpb24/DQo+Pj4+DQo+Pg0KPj4gV2UgZGlkIHRyeSB1
c2luZyBhbiBpZmRlZi9lbHNlIGluIHYzLCBidXQgc2luY2UgdGhhdCB3b3VsZCBoYXZlIHRvIGJl
IG1hcmtlZA0KPj4gbm9uLXBvcnRhYmxlLCB3ZSBkZWNpZGVkIHRvIGdvIHdpdGggYSBod3Byb2Jl
IGNhbGwuDQo+PiBTaW5jZSB0aGUgTUlQUyBwYXVzZSBzaG91bGQgYmVoYXZlIGFzIGEgbm9wIG9u
IG90aGVyIENQVXMsDQo+PiB3b3VsZCBsZWF2aW5nIGJvdGggdGhlIHN0YW5kYXJkIHBhdXNlIGFu
ZCB0aGUgTUlQUyBwYXVzZSBjYWxscyBiZSBhbiBhY2NlcHRhYmxlIHNvbHV0aW9uPw0KPj4NCj4+
IFRoYXQgc2FpZCwgSSBhbSBub3Qgc3VyZSBob3cgdGhpcyB3b3VsZCBiZWhhdmUgb24gZnV0dXJl
IE1JUFMgQ1BVcyBpbiBjYXNlIHRoZXkgc3VwcG9ydCBib3RoIGVuY29kaW5ncy4NCj4gDQo+IFdl
IHNob3VsZCBwcm9iYWJseSBhdm9pZCBhc3N1bWluZyB0aGF0IHVuZGVmaW5lZCBjdXN0b20gaW5z
dHJ1Y3Rpb25zIHdpbGwNCj4gYmVoYXZlIGFzIG5vcHMgZXZlcnl3aGVyZSwgbWVhbmluZyBpdCBz
aG91bGQgcmVtYWluIGd1YXJkZWQuIFRoaXMgc2VlbXMNCj4gbGlrZSBhIHByb2JsZW0gd2Ugc2hv
dWxkIHRyeSB0byBzb2x2ZSBiZWZvcmUgd2UgZ2V0IGV2ZW4gbW9yZSBwYXVzZQ0KPiBpbnN0cnVj
dGlvbnMgb3Igd2hhdGV2ZXIgdGhhdCBuZWVkIGR5bmFtaWMgc2VsZWN0aW9uIGluIHVzZXJzcGFj
ZSwgYnV0IEkNCj4gY2FuJ3QgdGhpbmsgb2YgYW55dGhpbmcgcmVhc29uYWJsZSBhdG0uIEZvciBu
b3csIHdlIG1heSBuZWVkIHRvIGxpdmUgd2l0aA0KPiB2ZHNvIGh3cHJvYmUgY2FsbHMgaW4gcGxh
Y2VzIGxpa2UgY3B1X3JlbGF4LiBJJ2xsIHN0b3AgY29tcGxhaW5pbmcgYWJvdXQNCj4gdGhpcyBw
YXRjaCBhcyBJIGNhbid0IHRoaW5rIG9mIGFueXRoaW5nIGJldHRlci4NCj4gDQoNCkhpIEFuZHJl
dywNCg0KVGhhbmsgeW91IGFnYWluIGZvciB5b3VyIHJlc3BvbnNlLiANCiANCldlIHRhbGtlZCBp
biBhbiBpbnRlcm5hbCBtZWV0aW5nIGFuZCB3ZSB3b3VsZCBiZSBmaW5lIHdpdGggbm90IHRvdWNo
aW5nIHRoZSB1c2Vyc3BhY2UNCmNvZGUgd2l0aCB0aGlzIHNlcmllcyAoanVzdCBkZWxldGluZyB0
aGlzIHBhcnRpY3VsYXIgcGF0Y2gpLCANCmlmIHRoYXQncyBhIG1vcmUgYWNjZXB0YWJsZSBzb2x1
dGlvbi4gSSBhbSBub3Qgc3VyZSBob3cgZWxzZSB3ZSBjb3VsZCBwcm9jZWVkPw0KDQpJIGFtIEND
aW5nIHRoZSBvdGhlcnMgd2hvIHBhcnRpY2lwYXRlZCBpbiB0aGUgZWFybGllciBjb252ZXJzYXRp
b25zLg0KDQpCZXN0IHJlZ2FyZHMsDQpBbGVrc2ENCg0KPiBUaGFua3MsDQo+IGRyZXcNCj4gDQo+
Pg0KPj4gQmVzdCByZWdhcmRzLA0KPj4gQWxla3NhDQo+Pg0KPj4+PiBUaGFua3MsDQo+Pj4+IGRy
ZXcNCg==

