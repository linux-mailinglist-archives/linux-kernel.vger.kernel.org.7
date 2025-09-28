Return-Path: <linux-kernel+bounces-835251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB0BA695A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE233B3515
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C70261B65;
	Sun, 28 Sep 2025 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="oJ+IvJLU"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022133.outbound.protection.outlook.com [40.107.75.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B2C2367BF;
	Sun, 28 Sep 2025 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759041687; cv=fail; b=NF6IortV7JawYbX3YZ1Azk0+UK+DePb3pBmvOOJtx/FgwQ5Ai/k9jCE5ZWIa++viLrjmWZcMSRmv1xWsNyKNtJbfmaUv7YToD4WD0C2DAo3Mb5RXHb9ETJe07GcsSozaRZOQC9f028oU1oyc3XkeqOGseQYw+e9/jKxzqSt90Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759041687; c=relaxed/simple;
	bh=s2VWkNj3Qt/r6tsGUK6hQ+f3eFPxlLxtbn3B42V961g=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QXpCsmO2ErPwARrBwejUeGdHm6HkqqOXxiRkfnuL5HE0yC5Yu+i2qCM+WSL8c0W2a7pVwxYoNUl8/17s7rtBgC8w6qaav0nx5EkHbpF8dPHZ+kKSbWetq/TzPDBeXc2ACRNq8913zoz4VeXER2Ky6QJvR+chG4Fql5Dak7nOCN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=oJ+IvJLU; arc=fail smtp.client-ip=40.107.75.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXwtZh05s9afX27Z9S6J9C7AQRxKxNgQiWKdHZpPi5l0ENwZsL2weqBNIrxYPS3VE6JohSSr49qnynqFvormk3PvJn4ppLJLJCFGGgm5/M7Lyp9lUN3V4cuiVuuWsidf/oc2J8NWE7ed+kZK0Fa+5KjBW3aq/ryf8thOgWJNkl2UUn+QTZFebjP3u8azigApRF2XePvuvyEYLUKVxGvhjV4pXghwNGs+bx1WevhCNqEOxiwp0FDrP2FW3G1ZB0KZh3TaCVt6DSrsM3YXHK1/FpzsOsFQPsbXgr0DZGgt5aM3VSPmOOhpZCUtpjAs1drK1DhKn0OR8Y3/xpVZj5vtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBf4HMpCfkhlWPW13vqIyVW818GwvAjfWE2LtaewXTo=;
 b=KBv/Bh3OO6YSbZM2B/HnJJpQSJnhQQQBSAFcpHAvwSPsEZGcEz20zG6/WYPwHYtc5lVtIKaVTk7iQypx83EqYyvLVSpY9ChOxixocgAeyDLcvuPuR3U6Hn71koT+LA9O5BZjZ6jBZXqMuD4lKWyVhqlpJn0vG1Lnmf9qFxOfGxMoMwatbxcpdbuSHvNELHh/O1TdlDNaWppEtvSKy+yV2pNi/i+qqgriCmrkY2rMmil8daoM4Dc9vGSAjiTc70joTInz/Wq7Ef3nRgiqUuQ8i2zsfxf6SjjNc2WCOStL6mWGnbIowUqR+eI1OK902X4NShxruuotXGRV3Qz4zftTJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBf4HMpCfkhlWPW13vqIyVW818GwvAjfWE2LtaewXTo=;
 b=oJ+IvJLUhMyMXgqXbV2xGGmnk/DZmeyxuxmV1HT6qouyNZ7Z8XbJs9RFaGrmQyTXsbWbwA7HwjTrlLRABvfFFI72EM1tBWVA8WNbSts0HNMGWbpgrK2qpbXi9QUJd4CCGCZZ7ZeL09nEuNfJK0+K8s0MbmGcWV6t0pm/bDnKz0FJPY8CUDEQzrs+GTfdgAnN7/0Y3k8dXwh9jvgpG4kWEXDl0utyVEQ96bY1ITxbqhtzZFArQ7YQMBCzzasP94vURdIaM8OJMSXc9yr7Zxh3pPMwxg15gNEicR7nsJJw7KH5yDOEouihZAemEMUOq3POg0TDlTvArPVv/TtnDLjyTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEZPR03MB7775.apcprd03.prod.outlook.com (2603:1096:101:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 06:41:21 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9160.013; Sun, 28 Sep 2025
 06:41:21 +0000
Message-ID: <9834c7c5-9334-4c78-a2fe-588ff03cf935@amlogic.com>
Date: Sun, 28 Sep 2025 14:40:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
From: Chuan Liu <chuan.liu@amlogic.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
 <20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
 <CAFBinCBd5-s6vaBoJNerXavQiHgsv4Fm3v0svUX7geL=kJvVYg@mail.gmail.com>
 <20178015-4075-40e9-bbf4-20ae558c2bef@amlogic.com>
 <1jldyzrv2t.fsf@starbuckisacylon.baylibre.com>
 <e70e9aaa-f448-4f67-9149-cb5970c9bbd6@amlogic.com>
In-Reply-To: <e70e9aaa-f448-4f67-9149-cb5970c9bbd6@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEZPR03MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: e0062479-6def-49a9-5f56-08ddfe5a096f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVpiT3lxMnBxTnhoRWFRam5oTVorWUlNZzhDWk5LZWV0aXBYMWplLyt2c2Y4?=
 =?utf-8?B?cGhSb0wvL2Joa3crWFJkQVpSWWdGRXNaOUNQL1NwL1NkVXB6cHVSaFhNODNX?=
 =?utf-8?B?b3AvajRTR2tqUTBrc211SDlpZEU1WXJxWEVTM0FDWjVHOE1EU0p3VWVmeGtH?=
 =?utf-8?B?NkhHQ0tJdWVJZm1lMlgxR1dOcmJBeFBNQTdjWnVIdk8wV2wxSkdkRHUrNTNB?=
 =?utf-8?B?YkwzOUdtV05ubjNHNlkybU5BZ0pQdlpSZGNrcG1UTjFnb2ZhdGQxbllrRG5m?=
 =?utf-8?B?Qk9ZY2RsMkNxQzA0S09semR1SGl0TUUvU0JINmlxS0VyaHRwYjdyQXRRZllj?=
 =?utf-8?B?UklSdy9GcFNWcXVFdHlTVzhnY0NUZzh0b01tVWVKNkZDQjA4L2drOFppWmY0?=
 =?utf-8?B?cGY5N1ZFUVFYNEVNUUpxTk5UK0REbVlySnAzY3oxejJ1dG5PTnluWVJkbzhj?=
 =?utf-8?B?alhwbTExaTNzVVk4T3h6MmVxbkprWEEyTjd1NnBKNzlRMzh4NEw5QjA4V0hW?=
 =?utf-8?B?NU91OHpIaVNRTHBXYmRGR0xjcHo5MkhITmZzUlBtalNpTTBVQzZuVGxGTERX?=
 =?utf-8?B?QmpnZ1pVQUlGRHRISEZ2NXFLc09sd2l0NmZreTlBNFFmeDlPcFFQWTE4TGRY?=
 =?utf-8?B?WU5uQ0FUK2F3MjhkMGMxZlZxdTh4dXRzM0E4U2JQWXhUSG41L3kxU01PUEo1?=
 =?utf-8?B?R0NldVJOcXNLVjFTcU9laVZhVksyd2dJK1dKcngrdjhOVVA4TG1wSGN3N0lx?=
 =?utf-8?B?Q0VMWHJBZ1FnelpUczlOeFE1TDZnKzY2MmcwekFNdHV4SHZhM2l2UnlwRnJu?=
 =?utf-8?B?WlU5K2N4TWZQdmtjWlVzWVRtcDcrem95bDdCTjF3QkxmWVVFSmc5SDVtOXUr?=
 =?utf-8?B?Rit6U1J2SWxLQXdham9tM3hpQk1ad1ZOb3BYTjI2TklHQkRMa0EzdWNicloz?=
 =?utf-8?B?OWNYUTMrNDVFbjRxV1NkUkdsWEpuWlJCWmtKMVJLdG5IYTk2czJVNmQwUFNJ?=
 =?utf-8?B?WWpLUVgwYUtMdS9DajBqVHN4YS8zS3VCTk0rcVdzTTlJVjUxNmdCYnJwNGJo?=
 =?utf-8?B?OTlKMUtmc1pJM2M0Wk9wU2ZnM3E4eHhJOVEzTXVvcXV6ZUtjMHB0QXZMNlU2?=
 =?utf-8?B?bUgzZHoxRXhCWkpIU3RJclRyVFpISGhiek11Z1FROXBHdTFSNlIyNzZIeGpG?=
 =?utf-8?B?L3ZOd3JndERsU01wMU5KdVl0elBraGp6Ni9xZDAyRmdPQVIwbFFndUptTjhu?=
 =?utf-8?B?VGVObWpoZVBpRXBvZWNaNWxMQnVseU90LzIwUi9BZlpYUHJSZ1czMm1ERWI5?=
 =?utf-8?B?UTBiR2JiQTNSV21udDJOZ2RVR3REbmFpQTRGTG1MTW80WXk1MVJ2aUgxSnhM?=
 =?utf-8?B?bDhGYTRHeWpCeG9rVE9QVnYrV2FSQ2ljZFlXQ3h0cHBqUlZ1RERkaG1qdFFR?=
 =?utf-8?B?bk00VjRhU0N2YVhJZ3Z3aHNlNXA1VzRpSjU4eDZ2RjZ0YXpXeHNtbFhUSzMv?=
 =?utf-8?B?aFlHbHJod1o1bjAyNzVsL2F6MHRiUEdncGNabUFKcEkzeWxGSmo3WE5YaVFX?=
 =?utf-8?B?YUhReHhqSWZkN0lQcElCZGREYkVNOFIreWlobHhJNVJpUHFNTlh3bXROdVdV?=
 =?utf-8?B?bHZYMGwyV2tBVEttYVhCWEdhYkhVakErUTl5UFFiMmlKTDJ2MXVUMmhaM3Ba?=
 =?utf-8?B?bWNxYVRtZ0NaakFZWTUydWY0c1ZNaUZCWkx4b0hmVldKcWZMUXVBWThjYTIv?=
 =?utf-8?B?b2xCRUQxT05FdGVQdWtlNDFsaGRKb1krK2NKQkhHdkpGbWZHSXlzWlRxZEZ2?=
 =?utf-8?B?LzZpbjZHNWNyQ3M4OEMzcy93MXlNejdtN3BvWlpiMCs0Vnh6d1ZpZFIzYnRI?=
 =?utf-8?B?cHNZS095MFgzTTJqVkE3YWdqb2l6aTZUN3JOWjNIVDZVRlpMOGIrMVdmVStm?=
 =?utf-8?Q?IyElpppnR++F7yjRZNj+QEshr33+k/6f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlRoY01Mc3lLRDdXNzRPQ2NSMkdUaitmdFpIRzdvTXVvaWFhVzJsZlU3STQ2?=
 =?utf-8?B?M0p4c3lQeHpzNXZ2ZnNEb2E1b0ZKbWV5cWZmVjdLbTFNeFVLM2RDNFJGNWxF?=
 =?utf-8?B?MmQxNXllQlg1RDhCS3o0VHRlMVUrbGdKUkY3Q0U5MW5qVmpxYW5Zd2tQcmpz?=
 =?utf-8?B?Wkt5QlhxQUF5MzZBOFFWYlpIRlFuYXpoeVIrNDIzWWNvZXJMWTBYVmxvY2Zw?=
 =?utf-8?B?a0V2NmZMckw4aUVOclJaVmpEWGZ2SFBkWHU0ejVuUEJQNGVDYmZxV29xWHZM?=
 =?utf-8?B?QmI4N0k3dnRORlFvS29JRlIwdURYR1Jsdk14WUVwQk9jbmtOZHBrcW81N0Y2?=
 =?utf-8?B?K1pYKzRkMmk1OFJGZXFiOUcrZDgyajRhb0hFbzdvcy8zbEQ4REc2bzFuQzQ3?=
 =?utf-8?B?UDUyQkZ5bUw1MkkvNTlubXZVemF3VzdHQXB0YjVZQ25SSE0yNDJsNjYzd2pQ?=
 =?utf-8?B?cDlaUEFBNWxNeFJKait6QXhwT0hLY2FEOEpWNGYyTWRXRjM5eWV2ZnYvbGRO?=
 =?utf-8?B?U0RZM3ErNG51NGtSNWF5NjFvOFJESVNsVmQ2cjVtQWR3S1ovU21qZzkvTUc0?=
 =?utf-8?B?UVFvcUlZclVwYWpUekJWL2ZLU1VEZFcxL3BUUm1Jd3ZZb3dwM2x1a3B3aFJ6?=
 =?utf-8?B?TUp6UmtUa1AwN3EzOUUrRlRhMnN3NmU0VTRxTCtKcnk1ZmtiVXF6NnBLMkVR?=
 =?utf-8?B?djJ5NVVMeHROcTVHdGZYdjA0cERjKzBoQm45Ykp0NWhKNm1kVU9BOXVEbjRB?=
 =?utf-8?B?aEN2Z3hYL0hacWxhZmFDdjlKcHdiUUNHSndxaHFRZldrSmV2YlJ2eU1GdUFw?=
 =?utf-8?B?MnVXc1ZYUk05M1pXeFcvRXlsQStJNG12U09YMlkvNGRIa1Zpd3M2T0lzS080?=
 =?utf-8?B?STRMMmhONHhLRTNKbGQ4ajdiWjVmWlM1YThLc3grTmRUQk9aYU5oNDdGMFoz?=
 =?utf-8?B?TWdlVG4wMXV6OEttTlVxQStsV05ab0JoTmlvWlQwbE03M05WbFJ3QlRublFL?=
 =?utf-8?B?QVdLVFM0dUJVY2tGZ2F5M0FBNWdMMmtRVUFFdi9CVTZLSjdYalpXWUdiNyt1?=
 =?utf-8?B?L3FuMXdBbXJmNVdlRHhMTHN0cGNZSnZPZnJuM0YrdkxuWVRqUExvTG5oaWpq?=
 =?utf-8?B?d2lhWnhWYzVrQW5BdlZxRTBUdjdrYTJLeXFrWWhMMVptckpjWDVGcmw0ZjJv?=
 =?utf-8?B?MlZUcGE2Z1pnQnZJU3QzQktFeThUcmpFaDNBZFNMbUZKa25FSVNMeGhsRStK?=
 =?utf-8?B?K3V3NjB1M1JqN0RiYWdXaUxOc2dyVWJLdDVMaGxnMjRZakplUThhMVlwRytt?=
 =?utf-8?B?d1V3eXZkbUVrRUtXU2IzaUcyd1JOSEEwQ1FxMEg5blVrMVlFd3Q3NHZRTWNh?=
 =?utf-8?B?czdaRFdxQXdTZTMvcmtWVEpTVVV0V1ZGdk9zWDlNWktwV1M3alJxaUM3T3NE?=
 =?utf-8?B?TlBGek90VWZwM3NtV0dmVnI0aXRyN1JDZWRRZXBGYnIyZXpzdk5BRCtRd0dv?=
 =?utf-8?B?OVBFQWZqZ3RxN2ZSU1E3eXpjRUE5Z1FKM1pyNGNBT3NISGFXZGE0b0JPZmNw?=
 =?utf-8?B?aUQ5UFRCbmdVTWNHRzFYZm4rck5pR3pvekJQZjNWc1NnaWFjZjZiSGxDL3kz?=
 =?utf-8?B?dHR0SDFCMWEvVTU2Z3lrb05VWkI4WU4yVk5aREpYMkZaS1haaDZqeFI3b0hP?=
 =?utf-8?B?SUtxTWN1THZidjZ3OXBUZm5mTUFsSEIrTm5XZDhkM1QvQllzNys0bTdyV1pM?=
 =?utf-8?B?RzBpZWJvNzNYbEdJSmpMYk56Vm1IY29oaEtOSHJ4K1BFVVFtMjY5anFhZWpx?=
 =?utf-8?B?RGk5ZlAzK2FpbmY4ZDZuMnZkc0VPKzdUU2RjZTNCRjB1VDVJNGw2VWtad0RT?=
 =?utf-8?B?UldJNHRqbGZnSjNKZld1YStSd2FxWVVOV0pDSFptdDdTWXZpbU05NWdsQnFz?=
 =?utf-8?B?a0xlSUNHMXh0ZkVrcHR5VXdIUVRKWXBXSWZ5dlNzS2h3YkcyblhZN0w5SFBP?=
 =?utf-8?B?Z3lJT05Pd0o1K0g5MGUvVXVnUFRKWXFRUUxadGU1T1VWWTFvdXNROFZ1V3pl?=
 =?utf-8?B?Rkg1aUxMWXJmNWh2QzdxZjF4VC83SGRXakxyUTlhTXJvWnBweWJCQ2JYaFYx?=
 =?utf-8?Q?Qn591aPIL6sG34JEhQBHzW0zb?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0062479-6def-49a9-5f56-08ddfe5a096f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 06:41:21.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOeYIf1xJhFVzQMuIJogaZhUmuymK2vmB1pmDZSCnCUsjAMS56WFc2+c/mLUpIm/xAo2Kbl1vLCwFB8XZR6tNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7775


On 9/28/2025 2:05 PM, Chuan Liu wrote:
> Hi Jerome & Martin:
>
> Sorry for the imprecise description of the glitch-free mux earlier.
>
> Recently, while troubleshooting a CPU hang issue caused by glitches,
> I realized there was a discrepancy from our previous understanding,
> so I'd like to clarify it here.
>
> On 10/8/2024 2:02 PM, Jerome Brunet wrote:
>
>> [ EXTERNAL EMAIL ]
>>
>> On Tue 08 Oct 2024 at 13:44, Chuan Liu <chuan.liu@amlogic.com> wrote:
>>
>>> Hi Martin,
>>>
>>>
>>> On 2024/10/1 4:08, Martin Blumenstingl wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> Hello,
>>>>
>>>> On Sun, Sep 29, 2024 at 8:10 AM Chuan Liu via B4 Relay
>>>> <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>>>> From: Chuan Liu <chuan.liu@amlogic.com>
>>>>>
>>>>> glitch free mux has two clock channels (channel 0 and channel 1) with
>>>>> the same configuration. When the frequency needs to be changed, 
>>>>> the two
>>>>> channels ping-pong to ensure clock continuity and suppress glitch.
>>>> You describe the solution to this below:
>>>>> Add flag CLK_SET_RATE_GATE to channels 0 and 1 to implement Ping-Pong
>>>>> switchover to suppress glitch.
>>>> It would be great to have this change in a separate patch.
>>>> The clocks to which you're adding CLK_SET_RATE_GATE aren't switched at
>>>> runtime in mainline kernels (at least I think so).
>>>
>>> Okay, I will separate it into two patches and submit it in the next 
>>> version.
>>>
>>>
>>>>> Channel 0 of glitch free mux is not only the clock source for the 
>>>>> mux,
>>>>> but also the working clock for glitch free mux. Therefore, when 
>>>>> glitch
>>>>> free mux switches, it is necessary to ensure that channel 0 has a 
>>>>> clock
>>>>> input, otherwise glitch free mux will not work and cannot switch 
>>>>> to the
>>>>> target channel.
>>>> [...]
>>>>> glitch free mux Add flag CLK_OPS_PARENT_ENABLE to ensure that 
>>>>> channel 0
>>>>> has clock input when switching channels.
>>>> This describes a second problem. I think it's best to have this in a
>>>> separate commit/patch.
>>>> Also you're updating some mali clocks (e.g. on G12 and GX) but not all
>>>> of them (Meson8b for example is missing).
>>>
>>> Yes, M8 missed it, I will complete it in the next version.
>>>
>>>
>>>> I still have some questions to the CLK_OPS_PARENT_ENABLE approach -
>>>> please share your findings on this.
>>>>
>>>> There's multiple clocks involved in a glitch-free mux hierarchy:
>>>> - a number of clock inputs (e.g. fclk, xtal, ...)
>>>> - two muxes (one for every channel of the glitch-free mux)
>>>> - two dividers (one for every channel of the glitch-free mux)
>>>> - two gates (one for every channel of the glitch-free mux)
>>>> - the glitch-free mux
>>>>
>>>> When switching from channel 0 (which is active and enabled) CCF
>>>> (common clock framework) will:
>>>> a) on channel 1:
>>>> - find the best input clock
>>>> - choose the best input clock in the mux
>>>> - set the divider
>>>> - enable the gate
>>>> b) switch the glitch-free mux
>>>> c) on channel 2:
>>>> - disable the gate
>>>>
>>>> To me it's not clear at which level the problem occurs (glitch-free
>>>> mux, gate, divider, mux, input clock).
>>>> Also I don't understand why enabling the clocks with
>>>> CLK_OPS_PARENT_ENABLE solves any problem since CCF is doing things
>>>> automatically for us.
>>>> Can you please explain (preferably with an example) what problem is
>>>> solved with this approach?
>>>
>>> If CLK_OPS_PARENT_ENABLE is configured in mux, 'new_parent' and
>>> 'old_parent' will be enabled first when __clk_set_parent_before() is
>>> called. And disable them at __clk_set_parent_after(). Our glitch free
>>> only has two clock sources, so adding this flag ensures that both
>>> channels 0 and 1 are enabled when mux switches.
>>>
>>> In fact, we just need to make sure that channel 0 is enabled. The
>
> It is indeed necessary to enable the glitch-free mux on *both* channel 
> 0 and channel 1 to allow proper switching. multiple original channel 
> clock cycles and new channel clock cycles will be filtered during mux 
> switching. An example of the clock waveform is shown below: __ __ __ 
> __ __ __ __ __ ori: ↑ |__↑ |__↑ |__↑ |__↑ |__↑ |__↑ |__↑ |__↑ ^ 1 * 
> cycle original channel. _ _ _ _ _ _ _ _ _ _ _ _ new: ↑ |_↑ |_↑ |_↑ |_↑ 
> |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ ^ 5 * cycles new channel. __ __ _ _ _ 
> _ out: ↑ |__↑ |______________________↑ |_↑ |_↑ |_↑ |_↑ ^ ^ start 
> switching mux. switch to new channel.
>

Sorry, there seems to be something wrong with the following format parsing.


An example of the clock waveform is shown below:


        __    __    __    __    __    __    __    __
ori:  ↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑
                   ^
                   1 * cycle original channel.
        _   _   _   _   _   _   _   _   _   _   _   _
new:  ↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑
                                       ^
                                       5 * cycles new channel.
        __    __                        _   _   _   _
out:  ↑  |__↑  |______________________↑ |_↑ |_↑ |_↑ |_↑
              ^                        ^
              start switching mux.     switch to new channel.


>>> purpose of CLK_OPS_PARENT_ENABLE may not be to solve our situation,
>>> but adding this flag does solve our current problem.
>> This is last point is important.
>>
>> It is OK to use a side effect of CLK_OPS_PARENT_ENABLE but it needs to
>> be documented somehow, so what really matters is still known 2y from 
>> now.
>>
>> Make sure the information appears in the code comments at least once.
>>
>>>
>>>> Last but not least: if we're running into bugs when
>>>> CLK_OPS_PARENT_ENABLE is missing then that patch should carry a Fixes
>>>> tag.
>>>
>>> Thanks for the heads-up. I'll keep an eye on it in the next version.
>>>
>>>
>>>> Best regards,
>>>> Martin
>> -- 
>> Jerome

