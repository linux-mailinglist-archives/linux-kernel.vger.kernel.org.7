Return-Path: <linux-kernel+bounces-884486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C577C303FC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DB11886340
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1A331B80A;
	Tue,  4 Nov 2025 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="WeIfWpDN"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022090.outbound.protection.outlook.com [40.107.75.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C63126B6;
	Tue,  4 Nov 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247883; cv=fail; b=ixqkW/hYZtrpJ3B8iWWRrozAKVAeObsMmbN1P3Hh3ahveuj60jFjooE4TtX8XTuPswx4chvfjDDwooJpBSE5zFjDDZkT0iO9w4sSMYpBIX2d43/6E9lEtKY9YPcva7RFU0l9WksR8xEslrualHcX6bA0FbfuD8AtfPXu4/6lcto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247883; c=relaxed/simple;
	bh=NhJbZCaI66HlW3RUuQ5d4Y0FxrS1UZtk1aBtkBYANjQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lAeqiHy8NakooIpvq5l8dxhArL6jFDBkKYfJ/w2pLeof3/P+DVp3rXwbhltakl6J34AR31n/6G/TfduE4RwZWvGEOxqoSTlDVImU5rVN9s5p7IAJsgm0iu6wZJp/FSzvUe4Pk5d4pmUDTxbDpnslBCpq8rcucG0o8sMu7SDCeUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=WeIfWpDN; arc=fail smtp.client-ip=40.107.75.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTQKg7eWCNbgpxrvtxbDj7lvVMCNpKRvQ30Pq8e2JlayHms5Uebnj2szt0edkXAx7qPorQVthbjQtJYnZ7E30L5qNGcuqaUBp37ENpaOO8E0tC72Ln4kBcm0hiDUHrnD6uWiU+YMra0XH1WaNqM63nbTWoFUnxAZBy+RCWAlino8PjM7MmEqHCW4awFkKDqRhpyjvdam46/wu8149LvgKs0Wn4BRcG+qjg3EysIPRJYmGEMyNbw8gJ2WF3JfFaqOGxv2B98ycWpHfTc91w005YBZGY1HJZ3slAsW1eHtdyK742zXSwvjodDM5DLGvojYdOQx/ITjkuo60slFWxlDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjHqNBkLZXqvcbKecPGGHsl08expU5vi3Egw/B9Dpvg=;
 b=XiJF8MXX/6TobtWSzuU6+NGDaMej5BaceV+9kbeS64yUVH0lA2r9vFwBuLj/0UZGHJNx9tZDtpNthWNVx9TvonfrQdCqqr4QYAzNKXKYHdmK5BCyMaGZKkqR4BYIysu8FgECJbXdYid8eU3WqE6LOnfcdenX1034NDwEygpRay5LkNrf32EZ9ac6kK+UXV5Vnx8DSLP5oyp/D80xbOyqSYiFYIhtrHCB+2SqZIR5zhmssrESFIUKwm7QjuMwySp+cdzzDRCgR9GHjdbfLfcKXJIfgljYGf9FCp5e8t0oLxucOu400QocBShYFG1lESJHP+KKEZ56CHF0ByUUxxPOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjHqNBkLZXqvcbKecPGGHsl08expU5vi3Egw/B9Dpvg=;
 b=WeIfWpDNZP0Lzd+PyYSDMiVWzxpn22FKC9T/pEv1MkPCaAjxs8WGNP0rmz3WBLdIY6aNvwLmA4+SW1fvfG9Z2j6kXy0RTRzKKwqQQywhfKGx20Y3hGkoRT7MZo3PjQ41UURmtwFvcLjsbsf1zTvtVZgcWwqz/e6UkwQa7JUTrAJ4hoXpessYxO7RnuAhl/E0SSZqQTnQI+znPE9NHi4+Blr3FpVlzEaG+KMAiktGkhtTcVcfUNM0glwGoZrDWnBY2OviwIhTrpnUHfc+uspqFVCSQydHsZ1lecp5v+zW+EdwaRNBfun6BmSCcgeerP3I/FDRAp2Ot10gvNCl94Xe2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SEZPR03MB7146.apcprd03.prod.outlook.com (2603:1096:101:ee::14)
 by JH0PR03MB7927.apcprd03.prod.outlook.com (2603:1096:990:34::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 09:17:57 +0000
Received: from SEZPR03MB7146.apcprd03.prod.outlook.com
 ([fe80::f608:5d7a:df6:35f8]) by SEZPR03MB7146.apcprd03.prod.outlook.com
 ([fe80::f608:5d7a:df6:35f8%3]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 09:17:57 +0000
Message-ID: <3b9a5978-aa02-486b-85f5-6443dc607dd5@amlogic.com>
Date: Tue, 4 Nov 2025 17:17:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] clk: meson: t7: add t7 clock peripherals
 controller driver
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>, Chuan Liu
 <chuan.liu@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, robh+dt <robh+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, devicetree <devicetree@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-amlogic <linux-amlogic@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20251030094345.2571222-1-jian.hu@amlogic.com>
 <20251030094345.2571222-6-jian.hu@amlogic.com>
 <1jbjlnxuug.fsf@starbuckisacylon.baylibre.com>
From: Jian Hu <jian.hu@amlogic.com>
In-Reply-To: <1jbjlnxuug.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To SEZPR03MB7146.apcprd03.prod.outlook.com (2603:1096:101:ee::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR03MB7146:EE_|JH0PR03MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 50300e5e-a965-4567-c45b-08de1b830a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGlJYjg2djhkOXhPOG9uWkwwUXFBL3NBb0oxcUo2WjJ3SEtEakNXaTJVNFJP?=
 =?utf-8?B?UnNuMi9OOXhIT2JuaE5sMXJESTYyc2xRZmlBeDRuK3dnc2xBa1Eza25GRGkw?=
 =?utf-8?B?YWp6OWRuRG9FZnpVQlNaRGtzTHgzb2xJTHlZMlZLSGgzRXBiSFI3SmtUZnYx?=
 =?utf-8?B?QytQaWFjNmJiQjdPU281RWFUYnMvVXB2bTA5Q2NVL0N1Y3o0aURxenREcDJT?=
 =?utf-8?B?WVpBS3g4RlNuQzBHRmYrOHl6UkRLblBITmQraWRXSjhtQVAwbUZ2N25Jb2Zu?=
 =?utf-8?B?MXN1WkpJZWJQNHdNSDdoR2txcWVtZjNMYWFjWWxGa1huWGJabENXRGwyZUYz?=
 =?utf-8?B?MG90YWdYSnlPMkhGaFJEbk9ZWFpGNkJFdnJlazJ4bXhvelAzeTFhR1ZjK05H?=
 =?utf-8?B?WHNHUjgvWTJIWUJTVnozTlFMQUlGQm9jWDhzUmZTZ2FKOGpqbjhhOS83dGlQ?=
 =?utf-8?B?Nm9pQzQyVXNvWk5remFBU25vbURoc2liQkxHU0g0QWJMUGF1YjNRM1NHVTNT?=
 =?utf-8?B?WWZxNlhuNkFON0NET2NtQnVlb1B3c1RTYVRIMTk5MS9BWVpHMTV6VzlSN1c5?=
 =?utf-8?B?cUxXdFhzV1ZVUDIxdkVmVFVIOW4xQlVjZm5WeDh2Rld2NXozM29PdDhoNWlm?=
 =?utf-8?B?aGx4VmJsNENPZlFJaUNLTG1aWDlwdWFreFdiblViVms5TGl6aFZVVlYra2Q3?=
 =?utf-8?B?N213eWxBRjZHeWFxRXVGNFVDVldZQXZYSEpWc1ozYUI4TG44MWErVFZORkFo?=
 =?utf-8?B?K2R6c3IwVTNoVVdNSGNBS3NRdU9yUzNGSk9KNmVJbmd3OUJSU2FPMHd6amlL?=
 =?utf-8?B?WmJ5eFc3akM1WHRtb0s5ZUh2LzdnTndUMlIwZWFjR1dJWGJlS3RUWVFmVkp4?=
 =?utf-8?B?bnJLVm5LS2JValNDbTFRTWZmMVpicXd2SGtxa2k3WlV2RVNZaGZwQUwzc1ox?=
 =?utf-8?B?VHdRcUZQaVk3MTZpSjYvc1k2bU9tZ2F0dU5rNEM2UUtpSzlyRGRweVRYY0ZL?=
 =?utf-8?B?aENDcGxnWDRtSmYxNWZLT1BGZHgzTm9TYVB2ME5DSkdSaEQ4dzEwa1Mxc3FS?=
 =?utf-8?B?TVN4SUlzd2ZIMExldkpraXFEblhYYTZFa1hta3ppVUN1NWZMcnV6ZXY2OVhB?=
 =?utf-8?B?OUhKdDhuRTA0Wjl2OFFQeDRMdGt4R0tGeEdJRzRSVTUrbGdJOHFTNmw4TlRn?=
 =?utf-8?B?TTV0VHk1NFVzVTJLM2trV0RodkZkaWFhYVU1aTlYLzFDZ2xEUDBQTER0Nk1i?=
 =?utf-8?B?T041L1pJb3E5eG56Rk03MVVpZ283Q1llTVllNHBkUzE3YndNUm1SUTlaWnEr?=
 =?utf-8?B?cFErMnBHemc1RTZ5SHcyaHR0a3gwTmN1cDlNZER3WGhwRFJSRk8rWGxmOTJC?=
 =?utf-8?B?czc4T1R4RU5WQVdsZWVtYzZYSWlwM21XaHBPSUxXSFd3Y2RJN2ZTdFpqckVN?=
 =?utf-8?B?NWdkZDU3bzY2ek1QZDYxTGoyMktIcy9mM1ZDdmRzSjRhOFYyb0tiTkxQM2tq?=
 =?utf-8?B?YVFreG5WNExlTjY2UWI1TEt2OUQxQ2gyK05IMThBTncrUGJGZWw5QjNKa29F?=
 =?utf-8?B?M2IvWGZLN2l4U24rT1pIQXBzcnRhbmRkZUJxUW9oQWR2Q25rZHIzSC9ZcE9O?=
 =?utf-8?B?a1RpeWVRZVZlZVF4L3pnbmR2UWUxWk5HcFZxL2JQZURLaHE1c1R5b3AwMk5u?=
 =?utf-8?B?OGVLa1orcHRGZldrVS9qRmNxNEZtd3RVOG9BOThocER6aWJRM3p2VUVLRUxN?=
 =?utf-8?B?WkVxYTBDclFFbHVXcFRPNUIyejlST3Y0MndsdHVEWCtVTC84NzBPSG5lZUtP?=
 =?utf-8?B?dS95bEVBMTQyRXowUXVSd1paZDA2RXkvUFFnY3paSlBlV0cyaDgwclBxM2dy?=
 =?utf-8?B?QTdzZnV6MzNpSVM1SVhsK2d3dU1QUmdDMWlIQVVVTVdEdTZLTnhoeUdMVEhv?=
 =?utf-8?Q?6g0PjabMKCeJ7bazmOIQDE1A3Ok04JMi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7146.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkJyY1pkZzgyTWJnamVCR3J0VUNKSlY0UGY3OXhlVDFiZDErbTI0eHd6bU1Z?=
 =?utf-8?B?emtZaVUrRzJmN2xENzdKb0dzNTJwRVhOMTcveUxuUFRYNWdKMTZsUG0zOUU4?=
 =?utf-8?B?YmZqUnVWY0szMXpvMjk5RUdGNHdjRnhEemxUT1c4RUpac2loMldFSm85SUZ3?=
 =?utf-8?B?S3NicUlNTjQ1dTZXVDI2U0tsblZRVDlteUg2TDBjZTA2dFRFQ21kT1NDdGRM?=
 =?utf-8?B?RGV3djJ2STlEamw5QmlZRUZQUyt0enRvbnRscXBEZmRMVUlvQStLdVpVcDk2?=
 =?utf-8?B?MDU5NGx3TzkzSHBYSng2NlRpOFNvbGlNZE9aQzJTNDhRbE82SWhvbHNlWXlU?=
 =?utf-8?B?Ym4vaFMydHpaZWN3VEVKcWFZQnc2OUpjTDUvRG5JZm5CYytIbVMzcVMva1BF?=
 =?utf-8?B?OVRDMkdkZ0dnM2kxV1JjY25rS2h6c29KODFhMjJXSDkvRG45MzdmZnY1eWpw?=
 =?utf-8?B?cVBlRU11VzJWYko5bEdORTlSeXFCNUs5YUEvNG1MWGVxYWhkUTNmbmIxbzRJ?=
 =?utf-8?B?ZHNxcTBod2l0dzVtK0JxRHpESlFLVGppejgvRDgrZG1TWE5IMU9KRHh5R3Iw?=
 =?utf-8?B?QW5tUmhSOXRwT0J2VUpxbDcrT2V2dk43cG5TdU1hZEZyU01Jby8yZmJUQjA2?=
 =?utf-8?B?V0JUc3NZSUhoZUFjSzU4di8rVll3S3h0SDlpWG1yc2lNNGNQbkRiaGFXK0ZW?=
 =?utf-8?B?WGxHM2NBdFlHaE16NXF2TkZnQ1o2cGdkUWxrRU14TFhCczRiKzI2aUcrOUc5?=
 =?utf-8?B?UWVnN083Si9tcmdMTGNaZXlzSG5aNWFzK0RtWXNoNFBFMkVhZjZyZHVsSWFp?=
 =?utf-8?B?TnVoUVdjS2plZWc2MWdNaDRDOUlQa2Rkd0M5c0wzVENKQkxJQkM0L3M5YkF4?=
 =?utf-8?B?VzBBRnBwUENLUXRVTnRqMjdTckV3NXgvdVFoVWZ1UzlFeHdqOEZUQkJ6Szhq?=
 =?utf-8?B?YzV3amh6K09Db0M1L1I4OS9iWDJ4MVJlUFVpYlIrZ05YbzJ1ZGlqM3cyalZU?=
 =?utf-8?B?WVFkL3N6M0ZLNW05OEVpYy9BeU9xdnh6eHlvdEpjbzdXWnB1R01heEU3QWxh?=
 =?utf-8?B?c1E4UVg4L0wwQkJuTmZPU2p6SVp3cUYxa2RSOGlmSzYvMk85WUszazN1ZlA4?=
 =?utf-8?B?cG9zYThoWTZrMitiYVg0TjJOZ2xYTlZIakxZbGRQd1FFM2tQVngrS0p3OVFu?=
 =?utf-8?B?MERxbGFER2xuQjc0YUtwclNCYlVPUFRCMVNvbWtnUVZjRVk0RXJrT0J3c21p?=
 =?utf-8?B?WW13UzYzZk4zNXdwYW1nY3JoS01tZll2Y3VkSEp6bXpTY1A5ZHl0ZzNmV0xs?=
 =?utf-8?B?QTRYTWNsZ2MxajdPNlBuMWVJaW1rVGxvR3VTcUJYcGt5YUFua09EdTJVRTJl?=
 =?utf-8?B?TTNRTlVTSDJmMVp0ZjdoejB6YmhiNWZyblNXMDR3YWVKRmZscSs0VHU3M25Y?=
 =?utf-8?B?UkdEVE1TVkVrQm1aaDVNUjRTNEVDcEFtRmQwRWc0ZktwQktLV1NyRGVncFE4?=
 =?utf-8?B?SmpzVFA2T1h6bWVtSzd6a0pMVlV4R0QzdThMYmZvVXZZUlhuNkhubXR2TmNF?=
 =?utf-8?B?bTNQNVlyVDQzb1NQVHVRQXpvSUJ0VUFnTW85aXFEWSt3b045ZCt0OFJwdTk3?=
 =?utf-8?B?em4rTGxLbFpMTSt0bFcrY1FnU04xbVRPVlJPSDc4akJNb05BTU4xZWVQOUZn?=
 =?utf-8?B?dHhEZGs3MDIydEgySGx3V2l4SGhyUHE0cUhrZVdoN05qajhkZURFQ3U5UW1F?=
 =?utf-8?B?R25DbFVKZysvNEw1QjJWc1RXRUEwVFo0Ri9zL2pGbFljU3hodE5QeGd0RlFw?=
 =?utf-8?B?bDVMazFLNnpHOXRiKzdrM2lVTVBhRlVxL3A2VDE1bjNTbXQzS1dFVHpDOWRp?=
 =?utf-8?B?YUoxbWFGY1JDK0haZ2xZSkJhN0NzdTYrbDY0UW8rTGd4Tk5VMEx4R20ydE5x?=
 =?utf-8?B?LzFOU3NFbExiOVFPVnBYZlM5WGF0UEcySVVGQVYxeG1aM1daaW9QTDZ0K0hZ?=
 =?utf-8?B?S0Q3UW13VGUyRFp1WkthV25iQmt2Zm15SU9WNzJHOHN3dWFvaXZ0ZGJUcUww?=
 =?utf-8?B?R1BxS2FKVndpMURMVlkxcGFVTHM5eENkREloWE1idVNCc0tQN3krZjBOdUY0?=
 =?utf-8?Q?o8rC7YGB9jP45gvyhldPcn7Ur?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50300e5e-a965-4567-c45b-08de1b830a95
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7146.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 09:17:56.9222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlBfUo8vOywT4lF7vQo5QN8NVox1fFRNd4zL2Ske/s/HfKek3wUv9vOY6pkoeuOy9vKLEaih4d4MkbZSLB7zDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7927

Hi, Jerome

Thanks for your review.

On 2025/10/31 17:51, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Thu 30 Oct 2025 at 17:43, Jian Hu <jian.hu@amlogic.com> wrote:
>
>> Add Peripheral clock controller driver for the Amlogic T7 SoC family.
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig          |   13 +
>>   drivers/clk/meson/Makefile         |    1 +
>>   drivers/clk/meson/t7-peripherals.c | 1734 ++++++++++++++++++++++++++++
>>   3 files changed, 1748 insertions(+)
>>   create mode 100644 drivers/clk/meson/t7-peripherals.c
>>
>> ......
>> +
>> +static struct clk_regmap t7_rtc_32k_in = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = RTC_BY_OSCIN_CTRL0,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_32k_in",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "xtal",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct meson_clk_dualdiv_param t7_clk_32k_div_table[] = {
>> +     {
>> +             .n1     = 733, .m1      = 8,
>> +             .n2     = 732, .m2      = 11,
>> +             .dual   = 1,
>> +     },
>> +     {}
>> +};
>> +
>> +static struct clk_regmap t7_rtc_32k_div = {
>> +     .data = &(struct meson_clk_dualdiv_data){
>> +             .n1 = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .m1 = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .m2 = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL1,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .dual = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .table = t7_clk_32k_div_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "rtc_32k_div",
>> +             .ops = &meson_clk_dualdiv_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_rtc_32k_in.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_rtc_32k_force_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = RTC_BY_OSCIN_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "rtc_32k_force_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_rtc_32k_div.hw,
>> +                     &t7_rtc_32k_in.hw,
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_rtc_32k_out = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = RTC_BY_OSCIN_CTRL0,
>> +             .bit_idx = 30,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_32k_out",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_rtc_32k_force_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_rtc_32k_mux0_0 = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = RTC_CTRL,
>> +             .mask = 0x1,
>> +             .shift = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "rtc_32k_mux0_0",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "xtal", },
>> +                     { .hw = &t7_rtc_32k_out.hw },
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_rtc_32k_mux0_1 = {
> mux0_0 and mux0_1 ? Those are  terrible names to search and grep.
> Is this really what your documentation is using ? If not, please come up
> with something better


ok, I will update rtc clock name.  It is a mux clock,  and the parents are

'xtal,  rtc_32k_out, pad, xtal' controlled by RTC_CTRL bit [0:1]. the 
first and last parent are same.

here was defined as two mux clocks. I will use one mux clock here.

After updated, the rtc clocks are:

     rtc_dualdiv_in

     rtc_dualdiv_div

     rtc_dualdiv_sel

     rtc_dualdiv

     rtc

>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = RTC_CTRL,
>> +             .mask = 0x1,
>> +             .shift = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "rtc_32k_mux0_1",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = (const struct clk_parent_data []) {
>> +                     { .fw_name = "pad", },
>> +                     { .fw_name = "xtal", },
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
> You probably want CLK_SET_RATE_NO_REPARENT for clock with a pad source
> like this.


ok, I will add this flag when for clock with pad source.

>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_rtc = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = RTC_CTRL,
>> +             .mask = 0x1,
>> +             .shift = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "rtc",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_rtc_32k_mux0_0.hw,
>> +                     &t7_rtc_32k_mux0_1.hw,
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_ceca_32k_in = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CECA_CTRL0,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "ceca_32k_in",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "xtal",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_ceca_32k_div = {
>> +     .data = &(struct meson_clk_dualdiv_data){
>> +             .n1 = {
>> +                     .reg_off = CECA_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = CECA_CTRL0,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .m1 = {
>> +                     .reg_off = CECA_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .m2 = {
>> +                     .reg_off = CECA_CTRL1,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .dual = {
>> +                     .reg_off = CECA_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .table = t7_clk_32k_div_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ceca_32k_div",
>> +             .ops = &meson_clk_dualdiv_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_ceca_32k_in.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_ceca_32k_sel_pre = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CECA_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ceca_32k_sel_pre",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_ceca_32k_div.hw,
>> +                     &t7_ceca_32k_in.hw,
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_ceca_32k_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CECA_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ceca_32k_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_ceca_32k_sel_pre.hw,
>> +                     &t7_rtc.hw,
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_ceca_32k_out = {
> Is the "_out" really necessary ? usually the last element just the base
> clock name. Same for the other occurence.


ok, I will rename as ceca here. Same with cecb clocks.

>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = CECA_CTRL0,
>> +             .bit_idx = 30,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "ceca_32k_out",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_ceca_32k_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> ......
>> +static const struct clk_parent_data t7_dsp_ab_parent_data[] = {
>> +     { .fw_name = "xtal", },
>> +     { .fw_name = "fdiv2p5", },
>> +     { .fw_name = "fdiv3", },
>> +     { .fw_name = "fdiv5", },
>> +     { .fw_name = "hifi", },
>> +     { .fw_name = "fdiv4", },
>> +     { .fw_name = "fdiv7", },
>> +     { .hw = &t7_rtc.hw },
>> +};
>> +
>> +static struct clk_regmap t7_dspa_a_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = DSPA_CLK_CTRL0,
>> +             .mask = 0x7,
>> +             .shift = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "dspa_a_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = t7_dsp_ab_parent_data,
>> +             .num_parents = ARRAY_SIZE(t7_dsp_ab_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_dspa_a_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = DSPA_CLK_CTRL0,
>> +             .shift = 0,
>> +             .width = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "dspa_a_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_dspa_a_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_dspa_a = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = DSPA_CLK_CTRL0,
>> +             .bit_idx = 13,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dspa_a",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_dspa_a_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_dspa_b_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = DSPA_CLK_CTRL0,
>> +             .mask = 0x7,
>> +             .shift = 26,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "dspa_b_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = t7_dsp_ab_parent_data,
>> +             .num_parents = ARRAY_SIZE(t7_dsp_ab_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_dspa_b_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = DSPA_CLK_CTRL0,
>> +             .shift = 16,
>> +             .width = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "dspa_b_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_dspa_b_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_dspa_b = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = DSPA_CLK_CTRL0,
>> +             .bit_idx = 29,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dspa_b",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_dspa_b_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
>> +     },
>> +};
> You have several instances of these glitch free mux (dsp here, anakin
> below, etc ...). That's quite verbose.
>
> I suggest defining T7_COMP_GATE() such that flags is a parameter
> Then use it for the sel, div and gate of element.
>
> You'll just have to fully define the final mux element, like you have
> below.


ok, I will use T7_COMP_SEL/DIV/GATE for dspa, dspb, anakin clocks. and 
leave the final mux.

>> +
>> +static struct clk_regmap t7_dspa = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = DSPA_CLK_CTRL0,
>> +             .mask = 0x1,
>> +             .shift = 15,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "dspa",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_dspa_a.hw,
>> +                     &t7_dspa_b.hw,
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> ......
>> +
>> +static struct clk_regmap t7_anakin_0 = {
> Nitpick: for the DSP it was a/b, here it is 0/1
> Could you pick one way or the other and stick to it ?


ok , I will use 0/1 for DSP.

>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANAKIN_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "anakin_0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &t7_anakin_0_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_anakin_1_sel = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = ANAKIN_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "anakin_1_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = t7_anakin_parent_data,
>> +             .num_parents = ARRAY_SIZE(t7_anakin_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_anakin_1_div = {
>> +     .data = &(struct clk_regmap_div_data){
>> +             .offset = ANAKIN_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "anakin_1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_anakin_1_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_anakin_1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANAKIN_CLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "anakin_1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_anakin_1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_anakin = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = ANAKIN_CLK_CTRL,
>> +             .mask = 1,
>> +             .shift = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "anakin_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_anakin_0.hw,
>> +                     &t7_anakin_1.hw
>> +             },
>> +             .num_parents = 2,
>> +             .flags = CLK_SET_RATE_PARENT
>> +     },
>> +};
>> +
>> +static struct clk_regmap t7_anakin_clk = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANAKIN_CLK_CTRL,
>> +             .bit_idx = 30,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "anakin_clk",
> Again, not a great name, especially considering the one above.
> Is this really really how the doc refers to these 2 clocks ?


bit30 gate clock is after bit31 mux clock,  and the gate clock is the 
final output clock, it is used to gate anakin clock.

I will rename bit31 as anakin_pre, rename bit30 as anakin.

>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &t7_anakin.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT
>> +     },
>> +};
>> +
>> ......
>> +
>> +/* parent index 2, 3, 4, 5, 6 not connect any clock signal, they are empty */
> Remove "they are empty" ... the rest is fine


ok.

>
>> +static u32 t7_eth_rmii_table[] = { 0, 1, 7 };
> t7_eth_rmii_parents_val_table[] ... consistency (please check for other occurences)


ok, I will update the table name.

>> +
>> +static const struct clk_parent_data t7_eth_rmii_parents[] = {
>> +     { .fw_name = "fdiv2", },
>> +     { .fw_name = "gp1", },
>> +     { .fw_name = "ext_rmii", },
>> +};
>> +
>> ......
>> +
>> +static struct platform_driver t7_peripherals_clkc_driver = {
>> +     .probe = meson_clkc_mmio_probe,
>> +     .driver = {
>> +             .name = "t7-peripherals-clkc",
>> +             .of_match_table = t7_peripherals_clkc_match_table,
>> +     },
>> +};
>> +
>> +MODULE_DESCRIPTION("Amlogic T7 Peripherals Clock Controller driver");
>> +module_platform_driver(t7_peripherals_clkc_driver);
> This is an odd placement for this.
> Please move this right after the platform_driver definition. Same goes
> for the other controller


ok, I will move it after t7_peripherals_clkc_driver. same with T7 PLL 
driver.

>> +MODULE_AUTHOR("Jian Hu <jian.hu@amlogic.com>");
>> +MODULE_LICENSE("GPL");
>> +MODULE_IMPORT_NS("CLK_MESON");
> --
> Jerome

