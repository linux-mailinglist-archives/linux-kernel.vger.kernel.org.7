Return-Path: <linux-kernel+bounces-883771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC82C2E621
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EEA3B482D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A681C2FE04E;
	Mon,  3 Nov 2025 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="FKhTbM2G"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA13279DAE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211464; cv=fail; b=bMCXuPu/FZ5QAggGeogbDDOyALeyaFsmDK/yZANR6uJTp9ZPf8PLlUfx1faxI+yQFEdXs3MxJjQXm7McrculYhlbiIQaO7L5hhLPM7U3ljCt7gQFAYOcY0pSL3BI0f6acqqQtJSCaByZ2f3g/mEeyKHovapWiydoz947PZVK3gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211464; c=relaxed/simple;
	bh=IgHXpdRJ1s5BaWzT4nmJBUWInCbw2UxpTDMahJyg7js=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JABPWQdrPjqwIneRGvPdvXD7UNpWE5BbbPM2jPjl8KxgARAVwPHDkxQyhquX82gb2pnPWINrmPs0kruGSv4sz63sA6evu4PEwjm80BmcZLtZC4tRQqwtdYbnSL+cR3RLiAIcO7nLpwp5X2/TdadVceDhRPac7KB5kYyw3RCPPU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=FKhTbM2G; arc=fail smtp.client-ip=52.101.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MimgK6vDqQVNXre734uV1C4IBbaptv9Zun8QQFW75AGDotWBhsbtV4BJbvIoVCWSTniJxXVsBhPCRm3UFd2isKfrWcorn3xaSJwl3SZhVTQwAq+P+het8tHrhPSJHmT/YBdHmzowyynUYNBHppUAdn39qXaMbzhAJatwZc/U7JdbghveVXph3Xt4UiM9CEzrcNyuVKHGvSZbi9BZmfohvJVT6SQyvpPwaTY0cn+6Be5BkA9OfYnURb/8iO7Q+fhvgmHIOCeCdEsbCy0Jh4doPymTw8kDsiLhO/itYjeTss6JLSTVpp/b+p/EjnoeMgGq9TfQa9McIOeLKNidHqTu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgHXpdRJ1s5BaWzT4nmJBUWInCbw2UxpTDMahJyg7js=;
 b=rSonNFhl6bB572gml7plaTFkYF5/zHputsfxdcE2kGGcHJnMoLUlP2p2clxwlh+CI5xgnJyE5RzEjyLybDAxcguMPXI0XaEySKdXs7jbiy2/hNzZaq5hyJHUFojg+fHc50rfastC4BLUHZnjJvRVpUK/r4NbmZfWk9xfyTERyiJLBY6QRHWIWs+k/TXQFozlEC1GrhKu9BvwC1SI6ZjMiki77DQfSlwswg5LqIXjUOcXD25GKPQnZjGaxVhgoYdmuiePXVJuqZRNySEEh3POirzDGsbv7VV3wNEGQd0HKfTTiNKMEa7H3UBNQXQV7hadOfDLMNDL4KbWsJgtMJCGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgHXpdRJ1s5BaWzT4nmJBUWInCbw2UxpTDMahJyg7js=;
 b=FKhTbM2GQ1NlpueDUCpxzT+pwnTyuLSl7YsJaZTxnimzAzZBnOszj8mFWXkaCCkvoAkdV9AhUMppTFCughbG++qLxliurMgCLXfy3VB3yMcfiNJTG3a7j/Ll9Gn7zuVF8FhXw6MjjXvKz6NeQHMK4789kT7+EWL3Zb1eUnXU9gSEEVzd9cIuTp446i9SpyMSXrWy/rKMQ3l0I2rF+aAx+42uKRomw1W3mm3xubbqup2dc7XFkDeDlGU6fFdonbmo7vPoMdVFdh+gir3vCxzj6hbSVzubMZNrWjfdUZc7DY52RVAQ7G9VKTqmVLC5fludsib8TM8asRsSJL/ESv4wOQ==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA6PR03MB7950.namprd03.prod.outlook.com (2603:10b6:806:432::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 23:11:00 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Mon, 3 Nov 2025
 23:10:59 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ang, Tien Sung" <tien.sung.ang@altera.com>
Subject: Re: [PATCH v3 1/1] firmware: stratix10-svc: fix bug in saving
 controller data
Thread-Topic: [PATCH v3 1/1] firmware: stratix10-svc: fix bug in saving
 controller data
Thread-Index: AQHcTE9tPr4hAa5NlUy45atA3D4ejrTg3kEAgAC3WgA=
Date: Mon, 3 Nov 2025 23:10:59 +0000
Message-ID: <4343e9cc-9e22-46bf-b78b-7b934d888f28@altera.com>
References: <cover.1762125299.git.khairul.anuar.romli@altera.com>
 <f3f620cd38250ed9ae4e44a8bd881a16c05c7bf8.1762125299.git.khairul.anuar.romli@altera.com>
 <649ca547-ab05-40b6-8e20-b1121720e601@kernel.org>
In-Reply-To: <649ca547-ab05-40b6-8e20-b1121720e601@kernel.org>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|SA6PR03MB7950:EE_
x-ms-office365-filtering-correlation-id: dc97c35a-bfc4-4d38-7232-08de1b2e4080
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnBuREVUUGFuemZYVkpMTlVybkxZYytlbHpJenZ4YUhPN29EV2ZCaytLRUJY?=
 =?utf-8?B?aTllQ1l0TDRFUHN0d3B2Wk1JcnJiZ0pxb1dCNm1iU21KMUkwclR1ZHBkbzMy?=
 =?utf-8?B?Y0twT1U0dmRFT3pkZXNDNjFaeUhtQkhVVWdvdmhoZVRpZC9JL3N0d05QV1hI?=
 =?utf-8?B?WWcrWGxoWFU0VDFzTWRSTkRpWU1LM09jSmdhc3c4bUY5ZnZKUXpnb0hnd3Fu?=
 =?utf-8?B?QW5BeFdjZjBTR2o0OUFmVnRmL3ltbHVscThNb0wvbFRaZDIzRzRqN3MreVRp?=
 =?utf-8?B?L2FuK0FKNWFUTUF0bFpYR3pScHR4cHR2OUFmUTRJUURYZDF6TUF5ZnRTSFVw?=
 =?utf-8?B?VUVGZDNaWnU1allBbGpUZE1KRzBkdWlvTjJzY2k1UUQ3OXFEK091N0dhVXYv?=
 =?utf-8?B?dmNuY0Z4YXpDT1Y4SGZYM3RoeGFEeVBQMkp2VnJIWklQbkJoZGJ3ZEVFcUd4?=
 =?utf-8?B?YXd3Z2RjVWhuMHlqM1BTbVY5M3h4V29UdUNCSXpJejZSTUQ3eitJZ1Q1UmhK?=
 =?utf-8?B?Y0lZQU9OZzJqOEtrYTVFdW0vNy9Gc3IySkNKa2dJSEQvNGZEQytaVmE0eWtu?=
 =?utf-8?B?dTc4M09JUlpkUXY1WDRQZXFZOTQwMUpnNGoySC9iaVNzSndNNUdDd3U0d0V3?=
 =?utf-8?B?ZkZSdk91LzNkcGtwdFhvbzkzY1NkYXFzN1hBMGpEWkFwM1QrbVZERjJuWXho?=
 =?utf-8?B?UnJqVW00U1U0OFJYbDIrYjl2aXRCQ2NrNGdBc3QrVExScjNrZUtKQkRjcVFL?=
 =?utf-8?B?VjZMN1VUTXJwdUxoczBFTDVTcmtyRzJ5TEQvNlQxaC9BUmw1NHZuZzdGaytB?=
 =?utf-8?B?M3o3alczWFBTY1ZtUGZHM2JEamxoMzRvWDZsanV4TWlWSFJHRVozTVpwRUNt?=
 =?utf-8?B?aEtRQjU2U3QwUkF6SmplYzRIZzhhZEFNLzZzTVFJV041Z0grZzFVTFlQTXJI?=
 =?utf-8?B?MjR3azF6eDg2RXlMNHpwTVp6MWxVMWtGaURHSXA3V1RWNTFWNHFJNkcyaitO?=
 =?utf-8?B?QVFjUDVpU0JPRlo3VFg1c1hJdTdObEhlTnBkelpQbnlUcHJjWW54UWIwcmtI?=
 =?utf-8?B?QlJkamF4NldxVWQraUJPMUl1enJndkR5Q09YaTVJb3JEdGI0SzNMOE8zbGtP?=
 =?utf-8?B?cGE2OHYyUW5NWm5LRFEyakRveW9nMitHUVhWN29OSEF3bWU0cUFYMU40blVk?=
 =?utf-8?B?M2pNUmQrenNvdHdHc3M5MDJtbE5GdkZFT2FML21obE1jTWluWmM0VktnNmND?=
 =?utf-8?B?bkdOZ2RIRWJnWmZNb1h6ODZQUmNaRkNSWit3NDRXMk52YWlkbFhJeGVYQXFR?=
 =?utf-8?B?citsc0lFMVBhREhXQjl2VWttb1N1Z3NxeFFVYldhTEIwdzJBRzZBZnhMVkk0?=
 =?utf-8?B?Uml2WDhCOWhDUFdyMzU3cHRZaFdxS290NXJhaFhqQjc1dDJUd2V6a1dKc1Bu?=
 =?utf-8?B?MHRGaUE2cnkvKytkTGtSdjJDUGtlcGZBaVA2VjN1R0QwZUlMSVVDbVhMUDRx?=
 =?utf-8?B?MkhubVRIdjUzU3ZkRzVkQXZSVmxvc0U2ZytLWjN5ampMNHB3L1FGOE9NUTU5?=
 =?utf-8?B?NTBRcGhDU3BsVm1pbWE0Z0M1NlF4bW1SVDNnMUUyZTBMdzVYVmpFNUw5dGJt?=
 =?utf-8?B?UXBNMGQ5eXJJRVpCY0VNaGRGQVpDbkRKZHdROUpGS0tvclRFaVRXOUJKMUla?=
 =?utf-8?B?Z2xmM3VtZEJVZ083Zy9Tcnk5bzhVT3k2TWQ2Q2FWKzE1UERFQmhqamJwK3cy?=
 =?utf-8?B?RlA0YVJvZEZoc0xuWFJvQUttWlZiL01Rc0ZrbkZCRGszZHNCUkJTZ2NobVBT?=
 =?utf-8?B?THdOYnA5b3JCNm92b2hWc0hxUXRtdVp0R2NrWk04dmdzcDhYRk5tRndJUEFY?=
 =?utf-8?B?ODZWVXk1RXhTeTh5T2hpTGZJUmUzeWU1Vm1JMERCeHJoSjdPMyt3MzBYa0N5?=
 =?utf-8?B?M3VSWkR6WE91dkdQdjF3WlRrWDhKTGk3bGlHRCswMnBjOTNhUUU2ajI2ZFBr?=
 =?utf-8?B?R25FNmU0OHlvNnhWTUs2eXpMY3BUR2RxM0hLdXB0dGQ5b3NZL00xempHaEZ5?=
 =?utf-8?Q?tfpoDT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUpQdllHMSswNU5wb203VkVVc000OUNRTjdyTFd4U0ZEWUZtSTd0MGpLbldO?=
 =?utf-8?B?QmFCd2Z3Q2hEaWIwRk0zMTdHek1CZzhPT2JVdWN3RXZMalJCaFdxVkc0eE44?=
 =?utf-8?B?L2NiOUU1RlVNY3ZXV0JnbXJyOGl1VWtjd3N5cldyVnVjY3Q4MzAyWVd0VUh4?=
 =?utf-8?B?cTQxc0M3bG5uOUg3bUNGZ3pjUDFZQ3FhWlRDUzF6aEtOVm1ScDB3NkNPVU1a?=
 =?utf-8?B?ZEpZN1Z3UzAwMGdjZ3Rxbjg5dzBlRUJXRDhvMHJsc1BYL1JSUGp4TjJ5Y0hk?=
 =?utf-8?B?MVpzMG5taGNMY0NnRVIvOFpWOXF4WGhpOWxSbmFoRTEvLzdvMUVKT1B1anVm?=
 =?utf-8?B?ci80eEV6YXRkT0Q5S2FwL1BTcG5kTGpzTjBmZ2dBbHdJRWh6L1pTK0ZtWVFO?=
 =?utf-8?B?MmtwNkttZEtOZEk2ODBkRGdtZHFXRWsrSlI0N2o4NFBhTGlIcnlqTWlwajds?=
 =?utf-8?B?enU2WTBUSWRCbTVvRmc1a0FLQXlZQ1JXejhHOXNvaC9jSTlaK1U4bFFlRU05?=
 =?utf-8?B?Nlo4K1JCUEo0amJzcWRCWklCSDNpa2RqYzBydGFGQnRFTVhCSkhOWk1tYlYv?=
 =?utf-8?B?OTRibW9xV1NqcmV5b3oxSm5CSTZDTzg1RFdpMllhOENDQUhMVGxWSDB2SmxC?=
 =?utf-8?B?WHpFRXpGaU0renhGcEdvc2I0MXpaZzlzTnZEUjdWTjY2dVpSQzRQa0hVaVFS?=
 =?utf-8?B?QzI3VFBnaSs4S0RLTGFtTTJOZkRrWlc5cmxKd0svTFRVV3A4Sjh0SWQ2YVA3?=
 =?utf-8?B?b1VFNkVzNFdYNXRwVUpVUmlCTU90OTlDanFXZDk5ME9JWi9EN3NMbE4zTnNv?=
 =?utf-8?B?dW5sbGJ3UEs2SkMzaUJnSEtJczZxTW5MbkRpK0IrUWljSnFjQUVudVplWTdQ?=
 =?utf-8?B?elp0RWxNNU13SmFyb0NxUmJRV0gzVFZkVXNpWElPYmVOOXVIRndvWnZGK1dH?=
 =?utf-8?B?RXBMaTg2UHRUOTUzdnBUT3FYVFNONXZ2Z25JZzJLdXllbTRZemhiYjZhTTZm?=
 =?utf-8?B?dXlCZjJnL3hiMmVzdzl5cDVUQjNEY3dGYzQxOG9EYzVUMGVMdHZRYUNFTlpO?=
 =?utf-8?B?WFRtQW9rcHZHeG4wU2IzV2NFSzFDUVltYTNzVE8wbUpKYlk3VXIzSUVBV0VJ?=
 =?utf-8?B?djlFdDEydDBDbnRIamEvUFQrVXd0b2p4Z1FpWG12eHdBcEYza0pmK3pNMkNL?=
 =?utf-8?B?UVVDN1h0TWtjMjFCSE1Pd2dFTkhXd0lnNC9tMFZEN0NlQ3pXMkxNTVJVR3Vi?=
 =?utf-8?B?djlTVjRiMlBYUGQyaE8ybHFvRnlQV2ZDcXNZQXhLSjBCbDZScW9yYkpQYkY4?=
 =?utf-8?B?all4a3lzYjl4RXVhS0JJeG9uNkUxQmVZTENoMUIxTHpNMHZNcVc3dkswZEp3?=
 =?utf-8?B?cUxFUkh6MXZzcDdQdm5kejFtVEFXVDRNN3BkTWM4NkFwelVzZU44NFo4ejcw?=
 =?utf-8?B?eFIxbFVoajMyMlZOcGYrMmZnN3BvWFoyYU1HNXpxc1NacUdFVTNkSHdkMHli?=
 =?utf-8?B?ZkMvWmJ6VUVGUDRhbW00TkpBcGdJc3dqcURXKzVaR3VtbEROTGhFWnRlYnlX?=
 =?utf-8?B?a25aWDNnZ1ozZmVLbXlJVHgwbmp0UWkyMXcrb1dHVGc4NTZWdm5oSEFXMXU1?=
 =?utf-8?B?NENvYjlMYnM3S1ZheXVOTnFkeEphNU45Szd1S1RJbjFqVDFydXhHa09rMnAx?=
 =?utf-8?B?RCt5TzZNSEt0MEdod1RmSzdyaWtqcHpMM3pzdGsrTE9YSlFWRGlNQ2hGNUtL?=
 =?utf-8?B?UFB1VTh4TGMzbmRBdm40T0c1M1UrMWxQckRvTHB0bTVZY2EyK0FYald2TEs2?=
 =?utf-8?B?Q1hRVlVxRnhuYnZUM1VtYitDeGIrOEw2OUladkI2Qy8xMFZ3MUMxSCs4SjI2?=
 =?utf-8?B?OHl6UUg0RUNGZGRycUdUd01Cdm9lUGVFZXhUZ2MyUVNCZis1ZlhHRnJXZXNW?=
 =?utf-8?B?R1drWXl6MyszaEs5TDdEUFVJSTU3QmRhMkROcEF3TEwyNUR3SmJVWEszaXJJ?=
 =?utf-8?B?UmErbVJIbmNTdjRVS29veWJDYkZ6OVpZQjBOSmhJU0RkTUQ4QTA4aGxYeU5w?=
 =?utf-8?B?VXpQL0xKODdNWUdsUlYyMk11bEJVc082d0k4Vy81eDh5NU8xV0hheG1ycWcw?=
 =?utf-8?B?NHRTa2dYNnJhampsY3RxOWlkSG9hZU9jYTdrc3c5eU5VVUcwWHRSMHRycURT?=
 =?utf-8?Q?fudpE0WsEosewLUDC7eSrDA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EAB61BEEFBC154EAA4A1B00C1B22E57@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dc97c35a-bfc4-4d38-7232-08de1b2e4080
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 23:10:59.7485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KiO1saJcKuhlWsAVqb7hb4Sj71Z6JYMWphEnJ9K+fl6LvGLE46f5CvX0gHPoZM4NqoPVdiQhw+jmojK+Vvm5tCHA6gtWBoJWEc5XznFHHks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7950

T24gMy8xMS8yMDI1IDg6MTQgcG0sIERpbmggTmd1eWVuIHdyb3RlOg0KPiANCj4gDQo+IE9uIDEx
LzIvMjUgMTc6MjEsIEtoYWlydWwgQW51YXIgUm9tbGkgd3JvdGU6DQo+PiBGaXggdGhlIGluY29y
cmVjdCB1c2FnZSBvZiBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YSBhbmQgZGV2X3NldF9kcnZkYXRhLiBU
aGV5DQo+PiBib3RoIGFyZSBvZiB0aGUgc2FtZSBkYXRhIGFuZCBvdmVycmlkZXMgZWFjaCBvdGhl
ci4gVGhpcyByZXN1bHRlZCBpbiB0aGUNCj4+IHJtbW9kIG9mIHRoZSBzdmMgZHJpdmVyIHRvIGZh
aWwgYW5kIHRocm93IGEga2VybmVsIHBhbmljIGZvciBrdGhyZWFkX3N0b3ANCj4+IGFuZCBmaWZv
IGZyZWUuDQo+Pg0KPj4gRml4ZXM6IGI1ZGM3NWM5MTVjZGEgKCJmaXJtd2FyZTogc3RyYXRpeDEw
LXN2YzogZXh0ZW5kIHN2YyB0byBzdXBwb3J0IA0KPj4gbmV3IFJTVSBmZWF0dXJlcyIpDQo+IA0K
PiBUcmltbWluZyB0aGlzIHRvIDEyIGNoYXJhY3RlcnMgU0hBLiBJIGtub3cgdGhhdCBkb2N1bWVu
dGF0aW9uIHNheXMgYXQgDQo+IGxlYXN0IDEyLCBhbmQgbm90IGV4YWN0bHkgMTIsIGJ1dCB0aGUg
bm9ybWFsIHByb2NlZHVyZSBpcyB0byB1c2UgZXhhY3RseSANCj4gMTIuDQo+IA0KPiBBcHBsaWVk
IQ0KPiANCj4gVGhhbmtzLA0KPiBEaW5oDQoNCk5vdGVkLiBUaGFua3MgZm9yIGhlbHBpbmcgb3V0
IHRvIHRyaW0gaXQgdG8gMTIgY2hhcnMuDQoNCkJlc3QgUmVnYXJkcywNCktoYWlydWwNCg0K

