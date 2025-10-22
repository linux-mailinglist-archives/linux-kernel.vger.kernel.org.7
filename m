Return-Path: <linux-kernel+bounces-865158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9351BFC643
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D1D660A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C3B345752;
	Wed, 22 Oct 2025 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="su1un/vT"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023108.outbound.protection.outlook.com [52.101.127.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B55345CA4;
	Wed, 22 Oct 2025 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141085; cv=fail; b=NPgT9wsgTvHyAVJvu/DNl7nJYkv1X/4twJa/aPpHC0G/Lemzeqb8rAWqqB51KXB7MCnkvWJfQqI16iN8Rfb3NJjfvsOqMVRvfyjnyCV57t+eQFkKxBOrHArXH1zBU5VaCpKVmoTDwu0mTd+4tmJ7/e+sCjS+6+EQ3NEXQoB3uGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141085; c=relaxed/simple;
	bh=Np2WCwzYaQVP7QvYBIeQ37iDkalm9Zi679FEdpzpHvs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BdN6JD3zNCYdaTFdZss8SIH+y6JEz2GHJdFbjLV0Zc7hYPsAQqtfwnHqF9yGdnJAWSgi+pvyGt85+5Yrx0N+WUxHSyUv7fejxsM/YI5XvEvFFnI7xtlIdNYhWxkw6IahyrAc/96conyvzWLeQ0fNu7c5Mrin6j5i6TFQGOLZfOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=su1un/vT; arc=fail smtp.client-ip=52.101.127.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2womspi+Jx9ymvgU8CO5rzw8DhvbVf4teDjNHKl3GUuPXS3/zaAwK9sf7YW89IO5DdRVIZ2raMLj6uXXe3nuBvtViR21UwIQSeLqAE6ooL/XbI10h7p+AL2AEMo919i3fyQ8juGKgvFNe9Z8eGjU4UVRACz4Lk5RJzVucZqkQs5Epo1o2ClM7gRZRMi4tmUABl1o+q2oNI/USxM5YYIgFH8v9rakO+zMSQR/X6fmHO/uFfXAQZASnot0r/BbqIawO97gS2th/KwS3974WVNonTVYUjdhvdBrQDBOp6LBf8040aGy3V23RGiC3HIBZXDgjDzkA2ejL9udP8MEqmL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/gH7evc9urr0jmbJLRT3jh3pmc/vRdSMeNjhGo4qlg=;
 b=gB3lQdZEEbaqbYVv22Z74MgYUeLpx6qjw0QZjGGso4QZ3w4CGuzTOypekivMUBgbiJynbVwEeMIhqlgathp5T/5/Fy84iQ5hYzo7QddcgsAdXfZpMR/dPhtqpn9tge2SeowzZWK4c41jjy74IyJIp4AaC/TctqG9uzLaPW0eFjPRznuLvsjlL9Im8Vvj2kXDeBLs/Ggl9/5tigcYMmDEWfHPGWZbNt40thxTzbZx2BVAsrtWBRB2wMSFG6xTdBdNNlgqZsmHN9uxkH91hz4reM3qYwz0pEvXJqzgQx9f8fD+V5AG7kiAEJO6zXhMOisL2gf5OQ0i44QUvnKrFCyD6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/gH7evc9urr0jmbJLRT3jh3pmc/vRdSMeNjhGo4qlg=;
 b=su1un/vTk/sH+WH5vox7IFnhoWKuhZpf57h9xHjquUK6fz+6dJBWXNqJzkgoVc9uZv5N5UL30HVYIIj2EGY0MBaq84obyXK001bPNu61X+xTscipBVzQOPo1VcmqjbVbK5H8IOA1Xtu2C6KbnPwSiJzMasxMeqUueTEpd+wo4/5FzLn3NLUYFTIkUIGE2P3JnZ3btqIBbT6XzfAAtcuhuM5qeorBogyU33YvsH4972e0PA/DMETsv/mrT4GYRrFu2/aAtTKZVRABP4tsWBuFuLiKOtzizJyGPIHIkk9k3CeVBLVwRP3xdF0bJ5mDJDJaU5hLZBFrJTn0j7+09QswhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by KL1PR03MB6975.apcprd03.prod.outlook.com (2603:1096:820:ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:51:19 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 13:51:19 +0000
Message-ID: <7be1f72e-00b1-4e86-88b2-260200b10480@amlogic.com>
Date: Wed, 22 Oct 2025 21:50:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] clk: amlogic: Fix out-of-range PLL frequency setting
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251022-optimize_pll_driver-v1-0-a275722fb6f4@amlogic.com>
 <20251022-optimize_pll_driver-v1-1-a275722fb6f4@amlogic.com>
 <1j8qh34098.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1j8qh34098.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0071.jpnprd01.prod.outlook.com
 (2603:1096:405:370::6) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|KL1PR03MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7294ed-b629-4198-369b-08de117213a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDNCa0ZpQkVHUy95eWNSeGpoT2NvaC9kVSthMUlqdXducFZUSHpvOWFPSSs5?=
 =?utf-8?B?SjM0azRFWU84MVVNYTFQT2cyUjZlVlZEY1JKOHAwc2ZXdDZMZDBuWWliL3dn?=
 =?utf-8?B?VGR3RklHM29yOXBGUFk4RllHNDIvSEhZTVhmTkV1NU0vWjRaNVFJZ0VpMi9k?=
 =?utf-8?B?cGVrSWE1S29BZkRIWVhhWGJRV1lPR0NNUGYrTFJhVkMwRHpJRzBKVFlFN3hH?=
 =?utf-8?B?aWEzbWE1ajRoQ2wvOTcyWXJlM3d5QkxVNWZxVnJ4MWdJNkkyOUpaY1dYUlp6?=
 =?utf-8?B?OUhBUjVhVUM4aGJlQk9kekpwc0h4VmVhTWYxK3pEUkF4SWt6Q0pHL3A4ZVBD?=
 =?utf-8?B?L3UyQmNQbENDSjViTnQ4RCsrZ1ZZTmU1MlVKS1BqQTZTU3kvRDlVQzR1dWxP?=
 =?utf-8?B?NmZGR2xLdENURVBxZW9tTVRxSU5xRW1LQWlPbE1OQVNwRFlUYkYyd0hYRU9B?=
 =?utf-8?B?OXFXOEdUYkRuMm5UQ0dIemNMeGU5b2N6VnFsMU1sejdTMGFGai9rcmswQmhS?=
 =?utf-8?B?VjIybjU5S2JqZkxpK3Z0RVA0VHpDWWVFMFE1RVh2TU9TaGxML1U5TFVBN2NZ?=
 =?utf-8?B?cGxsN1FkVExPWE9HdVVrUU13c2QvNlk1dkM0ZGZyN29qc0JFNy9PTU5lcHlE?=
 =?utf-8?B?SVhhaGMwUVdUTm80ZDV4VVVvMG93aHZKMDdRaUxvNlFzbE1vZzlGY0hTT28y?=
 =?utf-8?B?NHdFaDFvSGt5WkhPUWRYYjZJeWFIT0FrSmZ2b0FHU21FZ3lLUU9kVWdTMnFY?=
 =?utf-8?B?clZXeERNMEUybDRRNEpDTnVZQk9WZ3FZVlBzS2h0MHlJb0dCWUtKV3g2TDV1?=
 =?utf-8?B?MkdOT3VXTmJuR0pwQ2JrSFRzb1lXeGZZVUJPTEVMRm5KS0psUnY3cTZyTEUz?=
 =?utf-8?B?OUFwVkhYbnk4VzBWWHpsZkIxcjd5dHQ2ZmE5SERUazcrMDNOZGdzc3Bxc3J5?=
 =?utf-8?B?RmkvRWdYdlY0VmxqZGxxa1BvbjJUUEZtSTR5MEZ6cEVUME5CeTl5WmpOaGpP?=
 =?utf-8?B?c3R6QU13ck1mOXRDcjhjQWFGQjlkVk1nVkVvcmt0bk83STEvMC9tSHNHZ0lE?=
 =?utf-8?B?SHd5aHRkTnAxZGVNRllueVVCL1kxSDI0RDV0Z2dSNFNYcWhEb1dmM2NkUFN0?=
 =?utf-8?B?bmc5UWtQS2cvUDk2ck9kOXZRakJEOTcyQWhBdW5mOWF5S003MHhjbEM5VFBa?=
 =?utf-8?B?MG96VUVJQUZFY1NEZXZjSGdtd0RpM2pVenBuYVdzdEJIWklhU2dhQmZLaERW?=
 =?utf-8?B?TStiNHFMSGRMQVU2d1VMQndHT1dBSE5XOG4yODBCalRUdnJoM05rZXdmZjU3?=
 =?utf-8?B?TGpvZlp0ZERhdUlxcU9rYVc0bFk1ZEk1VnFRLzBLQWxGZnVabERCNWtCZzZ3?=
 =?utf-8?B?dzkyYmlUTzRqY3IxVk9NTlQ5bXVOSFk5OUR2VFlUeitBY3A2RXk3QnJxNmlv?=
 =?utf-8?B?bEkrV010V1RjZUVrSUpJQmdyU1Q5NHl3SFZoWVEvL01TeTluT21rWGh6Q0FK?=
 =?utf-8?B?Tmtwd3o5cWI0Wmg4VDUzMCtCRmlkcVlSMDEzNlVxbFhBRFlRSG5KZHNvRHNB?=
 =?utf-8?B?T0ZSMXlERVFRTHBGcGJnYTVSNFFqY3R2Y2ROakptSzl4UUozczh6TW9ZcUdV?=
 =?utf-8?B?YVRQNlRaMVlhKzFvTWxDeDA3bEFJZnRHSEYra2JKdXE1U0xIdjkzOTRCTnZP?=
 =?utf-8?B?bWNKMXIxMk4wYkw3UWJxVUdkck44YXg1aFVpTzgyeGtyOTBMcUNZdXYvbFdL?=
 =?utf-8?B?cFBLdmNoVmhXeUlMa0k2ZUozMUtKTWJoSHpKbkwrRGpNaTIxbXYzOFRZRWFL?=
 =?utf-8?B?WUJNMDhxODVJaDFuTzZiYmVJVGQ2dmV5MkVIbjNaRlJrczQ4TE53ZlJjaXRv?=
 =?utf-8?B?eEs3bjJRMEplNVB4bE13MXhXWU9rcVFzV0lxSmtOalFyaEh1bmdhQ1RBQ1hH?=
 =?utf-8?Q?slFnfvUwnrS2tsJlw3DBtYISvh5wL+Jy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFFYZnpzUFZmMkhrL3UvaUF2OSs3dU1wMWd6bXg4SVg1WlVKaTk1WE5FZ080?=
 =?utf-8?B?ZHh1RDROUWNmMC83QnpwZHRXaXlvTEVVa1NnTlNCeVBoRUkzUW9OZFREWkNo?=
 =?utf-8?B?TDg5YmZmTlFadklJeUVwMnZrQlhlTVhhSVFwV3VvL2w1bGJtWWJKQVZQTWp1?=
 =?utf-8?B?K2xZRm1XajJRaHdRNjZ4U2xWd2oyTlJrOHIwWXNIbVhrWXM0NnRjdzZVWm96?=
 =?utf-8?B?bGdObzN3T21rRVBFbW5NdUl4U3NrYmt6bXhyenFIRVNNV3FpamFTRmlMR3R0?=
 =?utf-8?B?c1N6Ti8ya2JrbVo3eVRMcTc5bjBscTNpQnorWkVoOXJmU01zaW9QSFdJMGNU?=
 =?utf-8?B?Yk50c0xUWW9sNHRNaWJqRUJUMnQ5T29kYkZZZDB0OGx1MlZOUzl1QitnUXpl?=
 =?utf-8?B?Q2d5SnBrdVNUN2Jkak9SSWU0cm9LVzJpVk4ydG4vSXdLRG11bUhpbWM3WEQ4?=
 =?utf-8?B?VytDcktGQlYyN3hscUNTSlV2MU9LMnhJaHd5MXlPSlZSV1l2QWhoZUVYMzVD?=
 =?utf-8?B?WCtyaUxVVFQ1LzVNdHFjbEYzOTQyL0FBMkplNThva3piYmJOWEMzbklmbkJh?=
 =?utf-8?B?VDhIaWV2NkVldHl0eGFwWFUxNEpqenp4Q1ZjOGh4eDB2TXhhWWlyNCtVSlp1?=
 =?utf-8?B?eTBWVmVtUUFBSVZpeHhjbE5OOERDMUNWdjFjb1lZR05wM0VtNFZmZ3hsM1ht?=
 =?utf-8?B?NGJxRVdGekRkdGczQ3M3Y3F0RVZ0UTZ3MWJ6RVR4eksxSzY4OEdQcFlvcUhh?=
 =?utf-8?B?RHA3Sk1NRFVNcmlRTWUxN2M1MElBQjFGcVVOcUlDTm95U294S2U4YlF5ZS9G?=
 =?utf-8?B?YVh3cGtycjlzK1lETFVTdGx6TDFwd25aRCtXeTZTUnFJTW9iTWxpa3plSzdD?=
 =?utf-8?B?Mi9ERFl5dFJOYjVtSU9mZFpuTk9OS1hNZmRXL1hoa3dHQzRUU0lWalp5aFlS?=
 =?utf-8?B?aWVaa01rOHFJTHFUM1NXMlQwamc3WEd4VlUraEwwOVV6NE5OblNTQVZJbzU0?=
 =?utf-8?B?K3VXbnZjSHd2aEUxWHNHVEhmeXFhcWdGYzN5bjFiREJST1QvK2ZnT2gxTTJr?=
 =?utf-8?B?bFVxa3JwUCsvZWo5c01wOFZBZVZLUmZqY0pEaDN1MUF1Q0p1WjVoL1VJYktK?=
 =?utf-8?B?WDZHclZ1eEpNcE8yREdLZ2M0N253Q1c5eWhCUm1oL0RBV2c0b1dFajJIbENR?=
 =?utf-8?B?TzV2MW1vcWRiN1NHY05NZmZUeXRTZG1tZUdsamtxZG56alpKeDB1ajVPTWpP?=
 =?utf-8?B?L2VSNHMyVGtsUHNMZ1VJUW1MNHpXRnAyMklWNi9mVjVXelczV2VKYjF5c05N?=
 =?utf-8?B?S1BHTXlsb2RuM0ZsNjBEWVJuT2MxbUZSVU1nb3hOQnRoWFpSdUFOanAvTlYy?=
 =?utf-8?B?OGRyalgrQ3lxbDlSdEZDVHVXUG1YUDIrRXRES3JqL3F3VWZaeVIxeE52OWRS?=
 =?utf-8?B?clVvQUl5Vk00Z2crZHp0Si9Fa3V5ZXF6eGNybFVPRG9GbTRWdEpJYUJWSG55?=
 =?utf-8?B?RjcyaWFGR0xVMm5oQ0VLMEJ3clBUU0J6bWROeTJxMFl1K1Y5bVJOb1ZueFlQ?=
 =?utf-8?B?MzZNUFdDVU41MktqRGgvUnVjdWtXRGRpR2YwTlJjL1lSR0svQjVmdGFOQ3VM?=
 =?utf-8?B?Q0o3QlVWeUZnVE0yeXdrVk1Bc3F6NU00ajJYWFpjbUlNbHdEd0xtdVB5dGVM?=
 =?utf-8?B?RUp6Wi9FMEpXcUtKWEFwNmY0UjBFZk5wdE5LZ2dFZnNhYnFpQ2hSL2s0MTll?=
 =?utf-8?B?U3B3ZGdwaGpHRktzOHpsNVZ6VXNkTkdiVUtaSzVBOFRQb2VxSE9OaDk4Nmt0?=
 =?utf-8?B?VzRUVnBGS2RqeXFJN2VVdEtuWXRJUk8yZG9nTzJNaFRDcUxhcjFzdFNNWmpO?=
 =?utf-8?B?NDF4aGNGUXhnZ3g2NlFyTWVQUVJTb3kyaFdxZENieXdINGFHeFFUWmdrUE9X?=
 =?utf-8?B?REx3RkhGdTdxSDNhMjZIMi9MSFhIbHZReHNnaXFNejM0RlNZMktpUExpVitp?=
 =?utf-8?B?S3RjRDFKQVdYSUs5aHFMTGtzZmhpcWVEcEU5ZTE1dmF5M2I3WFJ3R3praHVx?=
 =?utf-8?B?bDlmdnRtWnNBT0dxcGxFa2xBak9BSzBCdDVYbTBGU1MwYmJCN0huNWlRREFC?=
 =?utf-8?Q?8Eo0GISOCcNC9rWpJQUap9glB?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7294ed-b629-4198-369b-08de117213a1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:51:18.9044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZnMkNV7uQg2BBY6hmbACrQgdrLjPsTTBzmk8JXXDv/vJNxx+RsskSwMOh3WZHBV62volQv3XmTNIfdyQXDULA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6975

Hi Jerome,
Thanks for your review.


On 10/22/2025 7:57 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed 22 Oct 2025 at 14:58, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
> 
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> meson_clk_get_pll_range_index incorrectly determines the maximum value
>> of 'm'.
> 
> This explanation is little light !
> 
> How did the problem show up ? Under which condition ? How did you come
> this conclusion ?

In actual use cases, we haven't encountered any issues caused by this,
because we ensure that range->max <= (1 << pll->m.width) when
configuring the range.

If the calculated 'm' falls into the range:
- range->max < m < (1 << pll->m.width)
An incorrect 'm' value may be selected here. Therefore, comparing
against range->max is more appropriate in this case.

> 
> Other people having problems might benefit from the explanation
> 
>>
>> Fixes: 8eed1db1adec6 ("clk: meson: pll: update driver for the g12a")
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>>   drivers/clk/meson/clk-pll.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>> index 1ea6579a760f..b07e1eb19d12 100644
>> --- a/drivers/clk/meson/clk-pll.c
>> +++ b/drivers/clk/meson/clk-pll.c
>> @@ -191,7 +191,7 @@ static int meson_clk_get_pll_range_index(unsigned long rate,
>>        *m = meson_clk_get_pll_range_m(rate, parent_rate, *n, pll);
>>
>>        /* the pre-divider gives a multiplier too big - stop */
>> -     if (*m >= (1 << pll->m.width))
>> +     if (*m > pll->range->max)
> 
> Making sure m does not exceed the maximum value is valid too.
> You should check both conditions then

Ok, fix it in the next version.

> 
>>                return -EINVAL;
>>
>>        return 0;
> 
> --
> Jerome


