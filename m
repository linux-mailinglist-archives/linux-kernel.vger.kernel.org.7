Return-Path: <linux-kernel+bounces-883589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49950C2DCF7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 786214E48C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8762A291C1E;
	Mon,  3 Nov 2025 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oanA9FA2"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157D7208961
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197165; cv=fail; b=qIuO+byAMYAty4uhhqUGjY/AsdFeQeftsHU71kspwOHS2MV7bQusN9JOUs73JqoSWgsWe256yxjYUA2IcdNkzsuHzTL8wn1qUbh6pZAdPyz9nDImSTILEPkThS0UiNZdFhEQHjP52BRqIOBDG2al2XcRh0zpOjA8XwMBbLBL38s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197165; c=relaxed/simple;
	bh=EYEQuqKMFYRIP7MHGL+W3Breo6W5ticfYjDfZaz4xdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dPlLxJOq5qYSCf3hvxBlUhz7BnULuwOg3sx1XPi2c+B7YIxRBkrNVMLD+sP/waNryMD+xCT7TarcRSZ8Aqw+MGxNsdCBG0X64uolUSeLWEW4nloed9F0YuYKSLg3p8Hx8c9AS65Z0r//Juy2NuFowfknu2nehwMYLZjw+/UJtBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oanA9FA2; arc=fail smtp.client-ip=52.101.84.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+lj3NoZdpv+oIWdSafoEpTKEbKLoqUr311i5axDUjrNWHVQquYSdc1/Hv2g08JyGk5Yn96k2I5KzxIVo4U0LA50zj/NLtz4Woe0olhmPmRmNPSH853YwsyeD3KJ9jM767H+lcA5w50AAV8ktctGo3pw+yK8H7cOwSRaJvEy8OBZQYTlOhcbV9QHHSW4UsVDjvFE0vcR68jA4GFaJoJ5lAKSGn6jGofRgW8CyKPJN+2lbgwh+13Xxu8k06MiRX2O11XHwJJWkUPfQO8ufbLXfFAZ4zxPLUdDi3Llzmpbery9cZvd8GWflZD5EA68+Biv+5LE1DLLJG6W2DfEnUBUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYEQuqKMFYRIP7MHGL+W3Breo6W5ticfYjDfZaz4xdI=;
 b=iYTj3oqKiKHw2yw6JJgR2CaxcRBnQSX2LdK83XYB/KkdHLF43sKh3oHnDF+dJKFMgpxdao1lSoy3EmWCORnGPy37J3UaQ5gQ1n4ubUkvjYlxkw6CTOGNxP71UwMyZanaa8ICr1zV2c3o0MBAwD6bLLvDrOIaZpYWLIDitJufmRagZEQ5vWYhKkLDHPVGhyLMz2qfp9iTZxZKNMYWbBcXCEtyK/O6iTGUTg3ReDouEZ5jfAVNF/yy/AL4uCzTxi2Zu1fIPeWrtRdr5Tmbn3dkgRxfzU5U88hjW/DGRabc9AcyGfcJt4u4f4KFzfIg1pYWneCTPYxRrsuNQdBaq1h38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYEQuqKMFYRIP7MHGL+W3Breo6W5ticfYjDfZaz4xdI=;
 b=oanA9FA2Ucvb0c5rQdpr6g9ruL/zmdiPPOXGfEItW1/zNhutfltE8GlLhlLcJNm8Us6/W1W0yrmU7JA+jTQw76A1p3ayYynTEElKq2dqVFu0BJ0Ij1iGBrDuh3XP4+tR3gztrcp7DuFzcEOhE09ssDrj6neTFpxjEVRbCVtOPBTFkyGqtwLwOA8uZ0pJmzvdAVeE9mAZioDBKHnkWaXkqi2pAhBAFb3QKQDEJR6QTYii9KaBJFUDNtFaLCWLavYkQ6BKOXvHIKgIhfjbCVNS7Eo+6myyZgRAQjwm0YZBNAwkfXDDquUuf6M0kaeWC+R/HxKrtWlDNhr2Fj8ZafC27w==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI0PR10MB9518.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:30a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 19:12:39 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 19:12:39 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "hui.wang@canonical.com" <hui.wang@canonical.com>, "mwalle@kernel.org"
	<mwalle@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "florent.trinh-thai@cs-soprasteria.com"
	<florent.trinh-thai@cs-soprasteria.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Topic: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Index: AQHb66DA/2ST5DqqmUGvisuiiSELdrTh5/AAgAAscIA=
Date: Mon, 3 Nov 2025 19:12:38 +0000
Message-ID: <44b4f443075818cc0799724c9adf635b786e97b4.camel@siemens.com>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
	 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
In-Reply-To: <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI0PR10MB9518:EE_
x-ms-office365-filtering-correlation-id: 92b831f6-5e84-464f-4873-08de1b0cf4a3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFdGVTFZd1Nzcnl0dGtrdmZoem1DZFI4RUZqcnJBQmRJbitIVEZmUDlQRnhN?=
 =?utf-8?B?R2dZbkNTaENadW5tQm1aeUM5eVZJNU9ldEhuL1FOYUNWTGh0Tk5GTHBmeGkv?=
 =?utf-8?B?ZTh1cDFyQndiQVFpdmRETjFJT3RVVWg1OCtsZDYrK3RqZk9rSzg3V0wwOVlu?=
 =?utf-8?B?aTUxRkY0b1NRQWp1bTM5VDJZTXM4dFJDajZORnIrT1R4K3ZvK2lDM2RHQ2pM?=
 =?utf-8?B?SENZQ2dwNlZGL2haN2h2aFJlNzlJTmd0R0JDckJBUmNRQmFuWkxxRzUrd1FW?=
 =?utf-8?B?SitpbUtEVFVqb05oVnpGQjJFaVpxcFpOMTlvWVBQSHlBb2hXYjhSaFQ2Zy9H?=
 =?utf-8?B?MGhTVC9SM2x4cFdkdkhLSUl6T0ZUSVdRVllLNXEzZHVOeVU5TmpwOVVZUUZN?=
 =?utf-8?B?d1J1MUh1T054eWxjZldzUjUzdlVZS2QxNytVQ3A0STFEa3d5YzA0YjNJNVJV?=
 =?utf-8?B?Q2g5UGFzVHVjTHFPR3FKTTVnZjQ4a2M2Rys4TXhIaDRWcUNYV292amZvWXQ5?=
 =?utf-8?B?Rk03bzBRNm9rSkh5NDJBQjNEZnhJVnp2RlBzMGJvRGpqYWJlU21YOVNUdmRU?=
 =?utf-8?B?NlFoamdaVjhFT1RxWm9jaEFjNVpxZ2ozSXdkdFhhcFpZb3YwOUpvNktNOTZ0?=
 =?utf-8?B?SUpYUm96UjAvQWFGN2hVeS9pbkthdExjQnBybnNSYisySjM2b21JT1c2TmNj?=
 =?utf-8?B?STJaTDRVaW9oaS80RllNZ1hDQVpMZjBMV09tS0VwT0djdGhsbEJFeWpWdHgv?=
 =?utf-8?B?RlRUV1NGVjFldUo5ODFlaXhWQndoUkVwNWUyWXVBc2lsZlhURWZONS9MaUk4?=
 =?utf-8?B?cnBLSDFwa3M0MUJFVjZyaWpMQTdVVS83OThpT05UYTU1UzRISy85R1FmRHQx?=
 =?utf-8?B?aHNEZkEwTlFLbnI4TnZobTk5SUoycEUyTmhBWUpTRlB4VGhiTG55cFNpaWVy?=
 =?utf-8?B?QURIVzVOSmY3QmJJem5KdWlzMXl2WCtvQUdBYS9UL1lFbDU5TWFuZzdkMkdN?=
 =?utf-8?B?d0I4cnVUSHRWVno4SHA0M01DVUp6RVNtcXFZanZ3K092R0xnYy80ZDZKZXhU?=
 =?utf-8?B?SlB2b1ViQlF5QXJkcnNhVVlLNlgyQkJ5c1JOaDVLb05mYmwyTmdsUHZsOW9O?=
 =?utf-8?B?aTFraExxeHdiYlBneUJtaTg4YTQ2TXc2MjBCeG9mVm1zTXF5RnB0WS93eGlG?=
 =?utf-8?B?cGYzeUZvaVZpYlhFNTNGd3hCalBQQ3B4UGl3c3EwVXZ2VUtoUkNzeklWamVj?=
 =?utf-8?B?VWtPcjRPN0JBU2FWZm81WGhyMDhKeGc3WktJWEJjck04YUZZc1crTFpMWTIv?=
 =?utf-8?B?aktkMDVYdkpEd2swL3JFMlI5N0NlamhVcS9ZM1FraWlwbkI4bVBteVgrWU0w?=
 =?utf-8?B?RmE4czdvVzVxRUlvaGEvc3V0amhMOExpSjErZW03aFZkeGZrZytDbVBWZ0lm?=
 =?utf-8?B?bitRUDFweEJPb0tmNStoeWdKM3czQkFiSzQrTW4rbVh4LzZyUmpIMEJZVjF6?=
 =?utf-8?B?MENGa2oxbkhyMEgyNjQ4bWVsS2tGVlhJeFE5MzljSzZuV21EUUtDWUgxTUFm?=
 =?utf-8?B?dGE2QzJqRFdRcXJzNG5ZcFZJbmhldU1UZWo4SFFXdlZzT0lYeEg3LzEyemlL?=
 =?utf-8?B?NUN3MmoyRzNqWXY2QVRXamtLa05rb0N2Z0xoaHc3eGEzeHNpd0hZUEFNcWNp?=
 =?utf-8?B?b3dZL3pzVzhRd3FMWWo3dTNWQ2xOMkIvVEFkakpqbWo1TVVBMXpVSU9JTVVY?=
 =?utf-8?B?ekpCWUFIQ2RCSWNRV1J6VGxiTjljREZPWG1xcGh6NU11RXZXanBOUjJUaDls?=
 =?utf-8?B?dnQ0dkRZRTl1TEtOWXA0bVRZcFhYQzhaRWllbFo3L0tvaVZ0Q0FCejY2a3dE?=
 =?utf-8?B?TnVsTGE1WkVvTEdHcmpVd21GckxqV0h0VjJWRk5SNEx3SGRlR2ozSldGUERH?=
 =?utf-8?B?M2xYWDUwUFJyd0ovSjlYWDJUOEpKUGJUbUZySGR3cklFc1BpVXpNUWJTNFZu?=
 =?utf-8?B?b29LUnlRcTBBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmcweHFqSUxpM3pkaXl1dG1oQW5lUitVRmxsdUF1TVhaN29kUUw2ekkvdzRs?=
 =?utf-8?B?ZWcvdkJvcHJCSFVHZ0R1ZlhxUGFZRzBnRzB1NDRHK3JHakFPaWJoNnV3Q1JK?=
 =?utf-8?B?M1VKYWhDOWgzcStLZHlnQjYyejhsblpSQUR1UEV5TTNxeWFIUlpWWWo1V0Ft?=
 =?utf-8?B?ZnNIeGl0Z25ZR2M4VTBjVmhhRFhlN2lqREt2WC9nZElZbWxjT0FnSlJqTS93?=
 =?utf-8?B?U212OFlDZVVtZ25JL2t0QldiUGM5M3VlTThsSzRhOFJGS210eVRyMkt5Ykho?=
 =?utf-8?B?b3MrN1BiTWR3MW9CUEtaVk1ybTRkdU1iUndEaW5CRWZMWldlSTJ1MnJKczJ1?=
 =?utf-8?B?RWhQMHJUdGFoTXBoUE1wYXpnYUZOMWVGalEyTTVaRk1mb0VmVXpYdmFHaGRU?=
 =?utf-8?B?T0FZS1dleUxkaXladnpTejVJOUhtRUE2bWk1STJPQUVDOHRQNy9ubWdJa3hz?=
 =?utf-8?B?TkE2WTVEWHJnU2s1VmVjSTM1ZnRMY1ErOFErWnVnK3NjYzdtT25NdGU5U0xH?=
 =?utf-8?B?eTg1QUk4bXBOcHBCTDJyS0FRakJmTkRYZllURmhCRTVMeEpidUIzbk1sZUN6?=
 =?utf-8?B?YzVpZndLSG56Zkw2dHZ1UEhYekJRWXp1VndkY1JDdWg0eDJSNzNvR2JNWGFm?=
 =?utf-8?B?Tng0dzZHYXdZTUs2cEhoQksvN0doTUwrQ0l5RHRMOUcwOXF6ejFNeWpOY3Rl?=
 =?utf-8?B?LzBsZTBscytyRll3SVZ4dFRWSEpBRGpZK1ZHa3FDdzYxQTB5MnQ2bEZxRDIw?=
 =?utf-8?B?bkJGWEM1M3dNUVpjRFNOUGREMTh6N2hPVFFsQ3JYNERJYnM1NTZnTjFFbVM2?=
 =?utf-8?B?VnFtQkFkZk9aUnQ1QXZMRUU2TWRJQVdnUE5iVmJKTzRTT1Znakxpa25lSTc2?=
 =?utf-8?B?dzlETFAzdHJ1YjI4WHNmV3FTUG14WFUzb3lTU1gyMWVBVURMWHc1dGxyR2FS?=
 =?utf-8?B?QmpEenR4TzVGZzg2OU9KdDFtNFN0ejRRUFV6RVVwd2RjOU92MU5QRGVVWlJz?=
 =?utf-8?B?VHZiVHB1dlZMcURQYnFkUTFJMmp3a09QM1lvS1lnTXZtb3dPaHF1dVl0dFF5?=
 =?utf-8?B?amFDMzlHL3N2T1YxVjFuL29FU0IwUk56NFl1V3BwT2F3bHBFazRla0U3Y016?=
 =?utf-8?B?T25PNkVlZkwzVktReW9Pdm16K1BCaWwwcnoxc0NQUCt5SGNXUjVVOVRCOWFa?=
 =?utf-8?B?UmNPZkozM2d0S1V2eU5BNGJSdUpWTzRPMW9pbkFzOFMwQis5Y0dnS0R2bGlL?=
 =?utf-8?B?bmN2b0doazA4cmErQlNWQk1nUEFMaWZueEI5cktEK000dWQ0eHFiV1diL1hO?=
 =?utf-8?B?dVgrSEZtbFk0WmowQ2w3NEU2dTdmd3I4YmU2d1NHelRsK3F5enBubEY4Q1Z1?=
 =?utf-8?B?bSt2cGV2UTdoT3dDOU8rV3lpcEFoMVdBM1VNZll0aTN6RlJFTG5YcTBnY25q?=
 =?utf-8?B?bkhIdzlZeDVqeFpqYjRSYWJWek1lV002b0VpR2hrYmxYNnh3Ym9JYmJOWGh5?=
 =?utf-8?B?NTdXeVduN2h1MnJHRWU5OUJycWFxSmRCYXBOak9aRVJGMDhkN3ZVOTViWU4v?=
 =?utf-8?B?UWJ5VVJSSlhlQXltMXlCN1RVYytQUWJ3S3JzNmJFcWZOZjVSL1hzRStIbTJ0?=
 =?utf-8?B?SW1EM21VeGRTb2Q3Q3pwQ2ZqYW1mQlpjTWhPMm5oaEpMelhnUUxLQnNZMkU0?=
 =?utf-8?B?eEljZUJ0MHp1UERDS21QNytiNmNPdUpoVVcybWdIeFJWWTlsSWowT0pDNzFh?=
 =?utf-8?B?dndSWFlIWlNJa3ZrWW1zSkExKzRLa1lKQ3lzTk0zUHZuazBEVEhrcUVPeVNE?=
 =?utf-8?B?dDdaMWVSbStxNVFPMVJYZEM4SmsyUzhyQy9HM2lvOVluYnZnaEZQRjUzNTlt?=
 =?utf-8?B?K0REenRORE9UbE1iU2poVDN2S1ZYSjNzSTRZS2F4SGRVS0JkK3ByY3BuZnRL?=
 =?utf-8?B?MlpBT0VKRGJWQXVaUXY0R2pmbG0vaEg1ai9OUFNUWTIvQm0wVXlPdzh6WG5X?=
 =?utf-8?B?QlVsQnFNenJJWUVHK1FtVmNXMWRSRlhoOVFuSUFVbE9xNHE5eE9nbjE2R1A0?=
 =?utf-8?B?RThWeGEycW5odEF6L2ROUGM3Wk42dGV1dmVzQTIyamt1a2dFYmVqd2R4b2Z0?=
 =?utf-8?B?MW9mTE81TGpqS1luUThheDhUNXkxck9LL0pncC9ZQjVXNFJRWlQ4M1FzT0pW?=
 =?utf-8?Q?pIb989RbkwctANbw8AlCEno=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B95085D5359804AAA601C7E3C25DC85@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b831f6-5e84-464f-4873-08de1b0cf4a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 19:12:39.0919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crdhUViuXrArTfm4pHb6vBkOMK91XUp9aklGc3H6HJMgA1IHYtZAQxTfIwAQ+ZQgPBG98XV3AlIp+QDCnGfTne2CRMA2HAtHQC9RyDE128I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9518

SGkgQ2hyaXN0b3BoZSwNCg0KT24gTW9uLCAyMDI1LTExLTAzIGF0IDE3OjMzICswMTAwLCBDaHJp
c3RvcGhlIExlcm95IHdyb3RlOg0KPiA+IFJlcGxhY2UgdGhlIFJBVyBTUEkgYWNjZXNzZXMgd2l0
aCBzcGktbWVtIEFQSS4gVGhlIGxhdHRlciB3aWxsIGZhbGwgYmFjayB0bw0KPiA+IFJBVyBTUEkg
YWNjZXNzZXMgaWYgc3BpLW1lbSBjYWxsYmFja3MgYXJlIG5vdCBpbXBsZW1lbnRlZCBieSBhIGNv
bnRyb2xsZXINCj4gPiBkcml2ZXIuDQo+IA0KPiBXaXRoIHRoaXMgcGF0Y2ggKGtlcm5lbCB2Ni4x
Ny4xKSBvdXIgcG93ZXJwYyBib2FyZHMgYXJlIHRvdGFsbHkgDQo+IHVuc3RhYmxlLCB3ZSBnZXQg
bXVsdGlwbGUgcmFuZG9tIE9vcHMgZHVlIHRvIGJhZCBtZW1vcnkgYWNjZXNzZXMuDQo+IA0KPiBX
aXRoIHRoaXMgY29tbWl0IHJldmVydGVkIHRoZSBib2FyZCBpcyBzdGFibGUgYWdhaW4uDQo+IA0K
PiBUaGUgU1BJIGRyaXZlciBpczoNCj4gDQo+IENPTkZJR19TUEk9eQ0KPiBDT05GSUdfU1BJX01B
U1RFUj15DQo+IENPTkZJR19TUElfTUVNPXkNCj4gQ09ORklHX1NQSV9GU0xfTElCPXkNCj4gQ09O
RklHX1NQSV9GU0xfQ1BNPXkNCj4gQ09ORklHX1NQSV9GU0xfU1BJPXkNCj4gDQo+IEhvdyBjYW4g
d2UgZnVydGhlciBpbnZlc3RpZ2F0ZSB0aGUgaXNzdWUgPw0KDQpjb3VsZCB5b3Ugc2hhcmUgdGhl
c2UgInJhbmRvbSBPb3BzIj8NCg0KTG9va3MgbGlrZSBzcGktZnNsLXNwaSBkb2Vzbid0IHN1cHBv
cnQgc3BpLW1lbSBpbnRlcmZhY2UgKHNpbWlsYXIgdG8gc3BpLWZzbC1scHNwaQ0Kd2UgdXNlIHRo
ZSBwYXRjaCB3aXRoKSwgc28gc3BpLW1lbSBmYWxscyBiYWNrIHRvIHRoZSByZWd1bGFyIFNQSS4g
RnJvbSB0aGlzIHN0YW5kcG9pbnQNCml0J3Mgbm90IHRoYXQgbXVjaCBkaWZmZXJlbnQgZnJvbSB0
aGUgc2l0dWF0aW9uIGJlZm9yZSBwYXRjaC4NCg0KQnV0IGxldCdzIGxvb2sgaW50byB0aGUgc3Bs
YXRzLg0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMu
Y29tDQo=

