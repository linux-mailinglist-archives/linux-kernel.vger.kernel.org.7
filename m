Return-Path: <linux-kernel+bounces-809363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC09B50C7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3FA5400CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2A126D4C1;
	Wed, 10 Sep 2025 03:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fetCA905017.onmicrosoft.com header.i=@fetCA905017.onmicrosoft.com header.b="Ldt9fXQF"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022073.outbound.protection.outlook.com [52.101.126.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B20247299;
	Wed, 10 Sep 2025 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757476704; cv=fail; b=IQpgTvRk47v8ACDNcsZm1omCa3gIBEa32RqrTcgJApmPq8RlF8DdMb/owr/5ZGsl+ebbO42oE8CA2JfACTEm/PSFeFd1dC+noq3/0fheX86DIG3KnVMdJBopOfF3oCOErr0IuRDthD37sp4W5/ZUQ6RdIfDmtRk0vDAQ50Ff10w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757476704; c=relaxed/simple;
	bh=gn0NxSi+ptsw6zRO6LFHC7uvXAxUcE86LpxLGtVZoqY=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=Lgj//SFPTqst27JmRRvTy1LGkEG8TtEwFCf5OdWsBZR3TWMMSZijh87JUmg9xxPSc0xflWzqE4lyRmXE0Qp2I8C4R2bATjxe2N8DCBPFV81JGDtrIwEQU1QJ9S3ecy4PEZFTUDQ19qOu6FOAqvfjHdde8Kr7R8bi254sqxUzxe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=portwell.com.tw; spf=pass smtp.mailfrom=portwell.com.tw; dkim=pass (2048-bit key) header.d=fetCA905017.onmicrosoft.com header.i=@fetCA905017.onmicrosoft.com header.b=Ldt9fXQF; arc=fail smtp.client-ip=52.101.126.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=portwell.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=portwell.com.tw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Arq6d42ezYO5CxLHUdiG2Q88jkWMIVTWTJoNjlaXedrWIek5G5O+vh3gIV39AlFYkYog8jzE0wE6X9jcVqYiAqCNFwCf+GAlEUcW2jYxvIeeCU+IjVwQke6MoXYBtxaP+v2ucgtE5hjP4e0Td3VUGpPnheL/F+4iV7owI3IP8AI7RWLoWi11MV53dIICXnzJOJEDTVz5yBPJjPhyB76NWsPu8Nz5xVoRNtFl1tBgFi+UNpXM1tZ9zHfsNrLLv2YmTNCkXo22hazj7QZzyVVS7imEhOJeBALNknUuOA2UypeEy5S05WNLg6Ilby2YFM2q2JvtgWfZWIT1Nx8ehTqh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myd/65ULvn1geBVUQmNtuaK/4EwEFtzbgvQJdXZ2UfI=;
 b=jnFWclR5JwaETp3m1X6nQPGj4H5neQsakK+JZD/cyX80ovKS5klD2QSh07DlIJLH6f7mapvJa2E660UH1m2a33rbxyXPHhxXymSt5kcdr6Sp9DOUlrd53eWACgZ7rEritPCWKgYRYiHL/xyc1i6h1B1dI+u8Z69gTEWfsbXxV6jAMTQPOVxSMAEgIG1fJ0vp9ngUbF4rb3Qtyoyi1thFnTByDmBwYk0Ij7x0Bo0eknqp842028btHMuolyhgh4mDAVQX4iZKM/J+c04o6W/s8ZLcxV3Fu5jYGaTDqaTt68iV70UWB+OZmPp1kRSkOpQHu330DiCqytvwj1HUyJegMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=portwell.com.tw; dmarc=pass action=none
 header.from=portwell.com.tw; dkim=pass header.d=portwell.com.tw; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fetCA905017.onmicrosoft.com; s=selector1-fetCA905017-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myd/65ULvn1geBVUQmNtuaK/4EwEFtzbgvQJdXZ2UfI=;
 b=Ldt9fXQFNg7qtLSr/RJjZ9q7JoLwr1agnsD0r2nx7Kox8Iv9uqAXLy/SiOIN9L9sCJyrM2RGkB3kDsBSIx9CNDDFvMmkrPJt58EQV8pxpq5E34ajW2U2XLHQfOcaYroz4SrW37bupFJis5nK9/QjAMnqUeqH85Au4rg6H7ET3mov3iEupZd9FW9+iQQcmbEeLCbZvkv4JwzSrMiaLaR4KYPkYhe/ey7ZUcAVyrPd/Lsv6oPc05895vlcOQQW2NVRLHBoflu7aOR+L2SEtUbgWSaufhWXfLK8i3Y/sG2eESjg4MpEf4X6GtwmmC8F4zoIuchzL03kIH02swocZ1RgOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=portwell.com.tw;
Received: from KL1PR06MB6395.apcprd06.prod.outlook.com (2603:1096:820:e7::10)
 by JH0PR06MB6317.apcprd06.prod.outlook.com (2603:1096:990:19::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 03:58:17 +0000
Received: from KL1PR06MB6395.apcprd06.prod.outlook.com
 ([fe80::8aad:9193:92da:7ec3]) by KL1PR06MB6395.apcprd06.prod.outlook.com
 ([fe80::8aad:9193:92da:7ec3%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 03:58:17 +0000
Message-ID: <0d73c577-1941-44b4-917e-3aed6f1f664a@portwell.com.tw>
Date: Wed, 10 Sep 2025 11:58:13 +0800
User-Agent: Mozilla Thunderbird
From: Yen-Chi Huang <jesse.huang@portwell.com.tw>
Subject: [PATCH v5] platform/x86: portwell-ec: Add hwmon support for voltage
 and temperature
To: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 linux@roeck-us.net
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, jay.chen@canonical.com,
 jesse.huang@portwell.com.tw
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::15) To KL1PR06MB6395.apcprd06.prod.outlook.com
 (2603:1096:820:e7::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6395:EE_|JH0PR06MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 120eaac5-930e-45c9-9df3-08ddf01e45e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2FiU3dDZzhpVklqQ0FiUHhVYklybWhkN0pxcDFoWng0NFNza1I5Z083alFR?=
 =?utf-8?B?R244eE1DZmVBVUphR2JtUG4zWnk5MWR6NXhsUURLYk42NStEOWNJbmh3NWNn?=
 =?utf-8?B?cU9mV0k5KzRIRTNYUldac3VUcWlUcjhmK3YvdnUvWG9BNUFLQ2szbTBTM1Yy?=
 =?utf-8?B?b1hoaC9mWU8vd1diZjd4dFV1alZrMXpSOVI2dXB3U0grazFzQ0t1ZlJkaHRt?=
 =?utf-8?B?VVp2VnIzelBDKzY1OUdZa2V0c25RUnBJMmFuUzZMSEpieTJYaTNpZkpkTlhD?=
 =?utf-8?B?ZG9XbE5BMWxpaXVXTWMrVjlkTFRWY3UvNlVtNzdKNzhBdEwzbnc5aFhJeExo?=
 =?utf-8?B?SWV2ZHVGVjdYZEJSYWFsUHNrOGsxVGd2V1Q4UDdCdG1RaW01alpxUWY2SlNU?=
 =?utf-8?B?cGdXendBenZXRGdSUDJrRVkxVnJhbFBpdFBSc29MVXZSaDNaZWd3cXVZL2dn?=
 =?utf-8?B?VWNuc05UeDhuSkRXMDdKQW1vOUJ0RkRpZFc5bER2YWJsV3loY0ltRW1zczIx?=
 =?utf-8?B?bTNEV25lU25nZGI1YmdiejZpVVdiQ2t4YlpMYTZqbzV2eFJST1NlS1gwQU9K?=
 =?utf-8?B?VExzdlZ5NXlxajNkRWV1Qk1QaDJ6RnVoZVpvbnM0QS83Q00vODdRL28wQ1Vy?=
 =?utf-8?B?dHZ5OWVIZHB3enM0M2NFU1pPb1VHR3d3OHk2NkZXaGZQYmc5RDd1YWdyYVU0?=
 =?utf-8?B?eTU2dTF5TFhUeUhLMTZNS3dYS0pQZ0k3SWFHMnpsa0ZFYXpURlJhbnk3Y0Jk?=
 =?utf-8?B?d0NzNC9ISW9VZjlwc2RQQnlUaG8yZkFQakdkSjB1UGRiZkE5ZVBNVlZLNmRG?=
 =?utf-8?B?UHRsMWFHR25HK1IyM3BydEpMWnF1YkRERDd2aTJVL3RySHA5TC9Vbzdjekpz?=
 =?utf-8?B?ZGZyd0FNYUtUWm1GWWJlSXppUDliejVDQ216TUxqZnFWS1NFU0V1MEpFeGIv?=
 =?utf-8?B?a0dzM1cwVURCK3N1MFQvNnd0QWVaTHdMSzdBQ0YyL2dlQlJmaEYrckkzZmZq?=
 =?utf-8?B?ZlI0QmJOVnZRMktyZVRSQzYzT1RlUDlXV1dOa0xZS0owUnR5UEs4ZWxHWDJD?=
 =?utf-8?B?Q1dtS3VHMFpoVXRQSzUyblVSVm9vTFdYb0VPVWpqK2diL1R4NHpPSS9haDUx?=
 =?utf-8?B?MnhNTDc3V0tiT2luVTYrYW9sK05YWWxZQXF4UHhpR1IyUmU4Wnh4TWR6RHNs?=
 =?utf-8?B?T0xjTnJ3Zzl3WXR3STF5L0Nhc2EzRGtZRTlLS3pxNDNpeC81dkMwdGFBay9u?=
 =?utf-8?B?V0tRU1EyMitvU0htSitZVnZIZUI4aWtSMDcyNHZoS3pCZ1ErRGl6bWNBMmw5?=
 =?utf-8?B?R3VpQmdlVllKVjZVRmtqZWlodXFXNDFKZ1VkSGFyREpNQ1FDQUh2Y0lFRFlm?=
 =?utf-8?B?aXBPUzJtUFQxWHNxN3htUkdtejNzQVlJYWxVN0R5bjNaaXNVVXZnTEtqSzBy?=
 =?utf-8?B?dEo5RU5mTC81YVJweE9GdFhGUGlTQXpkbFJHNkpDazhuMDg4ck9hWjZkR3Fn?=
 =?utf-8?B?b0RQbTJFTTVZYzkvTFBJa2o2eHE3YS91N2ZDbWVuRmlMcXgzdVUwcGJ0Ukx5?=
 =?utf-8?B?K1F0MnNXcUdjUks5TWpMVE5IK2Y2c1JsbkFaMDhNTy9MOHhFYkthTzB5ZHFS?=
 =?utf-8?B?eEY5ZENNVm81ZldZaEEvd2JZSFJmMWlzOUQrL0VOcXQwYVJ5ZlR5SmtwMU1G?=
 =?utf-8?B?dTIwc0ZGWGU5T08zU0FBNmcyYnJyK0lOclZEdDdSSU5EYkovTm9nYTNlWjRH?=
 =?utf-8?B?R0VKNDRXbXp0Z3ZzMytBYmhjWEFJQTM1ZThyYnR4S002ZWlSQ2cvdjhpdGxs?=
 =?utf-8?B?Um5WcnRPKzVJZCs5WjBJMndyTEQxNGgvelBqakxRZFdEdWFid0JDZG1uWnYx?=
 =?utf-8?Q?/H0sbQ2XxLHZS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6395.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjRVNk9nM3g3OThQQVFHWlpsS3AyU0svK2pUMlo3aDJ2Sk80MjJkNXVqQ1p4?=
 =?utf-8?B?SHhkNXpZajNJRzF6S0p2MFVFWUY2cGYzTThQK0taaGdhcUl3Vm1KWUdZNU8v?=
 =?utf-8?B?UmZEeHNYcXdqaDRiY1gvbElNL3Axak9pd3VUS013QnRyY0YxMmJ6SUJyUVpr?=
 =?utf-8?B?Z3FxYXpPclFXYzB6R2RlaGZGSnpweitJK2h5bmh2VnAzR3I0K2ttcXlhRDd5?=
 =?utf-8?B?czZ6TVI3dU1rSEY2SVBpZEw2Vi91aWVhU05JaG5WVE9KZWFnTVJlS3FVKy9h?=
 =?utf-8?B?YWsxUjRyVGdnV3Q2eW1vckJVWDRCeHlMSlhaNmtyNlc1c29DOGVTYktPTUcx?=
 =?utf-8?B?di9CUWVYUEZJaGdkSUFhZFpGMVlSVHBBSkwwNW4wSGtlSHVrOHJvQlhqeTZL?=
 =?utf-8?B?alhFUDcwMTJuVDd2dkwwd2VPSzdXMy8rNW0wSk9ramtWTEl0R0tCS3dXNmNB?=
 =?utf-8?B?QmU1eDZuT3k0eWZzSSs5SmdwL0V4MFdIWjJ6YXA1b0tpWjNGUnJLZzV1dS9t?=
 =?utf-8?B?QWtjZEFuZjFkWlN1eVJlb003OHorWU9jQVlTUFR0TFNhNzlVWWo4MTEzUXJu?=
 =?utf-8?B?Y292QXpCa1hDc3NyWGdMa1FhVGRCRURKR3VyUS9WNVVJZXdjUUUyanBUVXdn?=
 =?utf-8?B?QUdmQTFITTkvSEFmblZlbU9xc1BqdVE0anlVaWZ1cEhiMC9BUUxWSkxKVU1W?=
 =?utf-8?B?Y3lNeXBIM1h2ZWhSc3N4dUxZemhQWVhteU45bHRVc0VDdzF1NkdFNURmbVVz?=
 =?utf-8?B?YUJKNWFWaXlyV2VvWjZLaGM3SzlZNDNJaWFiYVMyVTRTTys3RFlZTC9OMEJD?=
 =?utf-8?B?VkhnczIrQ1U4RlExZ0txd2hCOHRyQkFXNER4Mi9YdFpiUm9HcThna0ZBZ1VZ?=
 =?utf-8?B?alZJeWFkWFJRY0ZHanJuendwNE9LUm83bnpYeUZQcktZZS9JSCtPSEZRSit0?=
 =?utf-8?B?NWs4eWRKTEdBRDJMMnBCZFppWGdhQ01MU1ZSZUU2cU9zTXVpRlcybytFVG9F?=
 =?utf-8?B?MTM1UUN3MlRFV2lSamx2MFZKdVJQRmJIVkFVMnQ1SjJYMU91clV5RnUxTWpL?=
 =?utf-8?B?aWd2OXY1YWQvQVlMOEhwZUlkcE9SaWxwM2Uxb0ZvVlNUamswa0lIZnhmWXNs?=
 =?utf-8?B?cDFhY1JUWG1aSWJ1OXFGZUtWQkM3U2RUOXZoNm9TRFRUUXNRVWVYZkI5Smo4?=
 =?utf-8?B?SWpFQUxuZU1SQXF3UkVZVHpzejhVU3dlVk5Fb3lvaVdHaUQ1dFpxMGtKWmdM?=
 =?utf-8?B?UU1jZW1aKzNkcXh2bzl6Z2Q5dG9sZ3ZUcis4T1ZOVEFCLzJqUnJHK2RKQ2M4?=
 =?utf-8?B?V1V5S29ENE9zZkZJZ3k0bFAzVWYxZEJMOUVhRzNjSjZNN0cwaGl6ZGJ6ZE1B?=
 =?utf-8?B?eWxUc3hSL1FxY2dXRm16L1dZSE9LRFV3d2xXS2t1RVJTcXFjR0FNd3ExY2Q2?=
 =?utf-8?B?OTlKMkxoUFdwV3hqS1Iyck5tdnJ2aVRoa3B4dmFUN0dITXBGdGZmcXQ3ZGk1?=
 =?utf-8?B?R1VFNE5kUjNETGl0Wm84V3B3ZFRDZ0l1NmRUM1NMWExON2RNajNFd2U1d2o2?=
 =?utf-8?B?SDFSMUl1K28vUnhTK0JOazVEamZZYWtDWWkyZUErNzhuVVYvd3FpK3hQUVhX?=
 =?utf-8?B?TmRZMXk3dlpEVjhPaWpOVzIyT0ErMjNJWGdHazFISVZjeVRKZGF3YnJ2WkhO?=
 =?utf-8?B?SEREY0dvYjFUYUlBeUxNKzF0UDA2TktITG9maU9wM0VCT2JDbjYyaVlyT2lD?=
 =?utf-8?B?ZHNHUm1ROVR6UDd4UWJENFJWUTFRV2lsdmhaclFtZ0tDSDFvRWF5aktqSGZa?=
 =?utf-8?B?dHdxOXlURG9QTG83N1ovNGttbTZ0SEhlbmFyUm5EdXJoRWVPQk0yZjMrSVdW?=
 =?utf-8?B?RlN2M1dlSmNzYWZlcUlhM3M4VmpYU1lpR0hMREYxaVBlS1ZpZUpTZXpQTkhh?=
 =?utf-8?B?QXpxL2hxdGRlZ2x0UVJFNWdoWWV3dlY3OTBqZGlpUEdjdlBybWNpdFF4d1Zl?=
 =?utf-8?B?UFhtcTRHaU5DUEVQcWZqZFFoNzBMYnNmdXpzZksyUEkwOUgyUHo3dmxybDFt?=
 =?utf-8?B?R05QUS9oYmdBVlV3enQxbzRiZ2x2eTBncXVtTzdlRk9qTEU5eUgzTFFpOHY2?=
 =?utf-8?B?Skx6cVdGdXpYKzlRaVZGazYzcjFPdVZ2SlQveWZpUFV4cVdLMUVnNXdWL25C?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: portwell.com.tw
X-MS-Exchange-CrossTenant-Network-Message-Id: 120eaac5-930e-45c9-9df3-08ddf01e45e1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6395.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 03:58:17.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e309f7e-c3ee-443b-8668-97701d998b2c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKMoxNO3OENf0viuAdIa6T7MS4b2mwr5GdoZXiMxyaLGZvyURMWZT9pnrHc0W5MTUoPIoRycLhZ0rDxGzaMP6eN6EA4bfkVfe/B7vP7JYcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6317

Integrates voltage and temperature monitoring into the driver via the hwmon
subsystem, enabling standardized reporting via tools like lm-sensors.

Signed-off-by: Yen-Chi Huang <jesse.huang@portwell.com.tw>
---
Thanks to Guenter Roeck for clarifying that sensors.conf should only be used
as a fallback when board-specific scaling is unknown, and for pointing out the
missing .is_visible in v4.

v4->v5:
  - Restore .is_visible callback to fix sysfs attribute regression in v4.
  - Re-architect hwmon data handling to use a master data structure
    and a per-board bitmask for scalable configuration.
  - Rename hwmon device to 'portwell_ec' to satisfy naming rules.

v3->v4:
  - Remove .driver_data and related per-board hwmon data structures.
  - Remove unused pwec_hwmon_is_visible() and pwec_hwmon_init().
  - Clarify driver header comments.

V2->V3:
  - Replace hardcoded `1000` with `MILLIDEGREE_PER_DEGREE` and double check
  - Fix comma placement and spacing coding style issues
  - Simplify pwec_hwmon_is_visible() with ternary operator

V1->V2:
  - Removed `msb_reg` from `struct pwec_hwmon_data`
  - Updated `pwec_read16_stable()` to assume MSB follows LSB
  - Moved `hwmon_channel_info` to per-board data and assigned it to `.info` at runtime
  - Replaced the `pwec_board_data[]` array with a standalone struct
  - Replaced literal `1000` with `MILLIDEGREE_PER_DEGREE`
  - Removed unused include and sorted header includes

Previous versions (for reference):
  v3 patch: https://lore.kernel.org/platform-driver-x86/d6429164-46dc-4c0d-8d6f-4650e0b92f22@portwell.com.tw/

---
 drivers/platform/x86/portwell-ec.c | 170 +++++++++++++++++++++++++++--
 1 file changed, 162 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/portwell-ec.c b/drivers/platform/x86/portwell-ec.c
index 322f296e9315..c3b078c3c812 100644
--- a/drivers/platform/x86/portwell-ec.c
+++ b/drivers/platform/x86/portwell-ec.c
@@ -5,15 +5,13 @@
  * Tested on:
  *  - Portwell NANO-6064
  *
- * This driver provides support for GPIO and Watchdog Timer
- * functionalities of the Portwell boards with ITE embedded controller (EC).
+ * This driver supports Portwell boards with an ITE embedded controller (EC).
  * The EC is accessed through I/O ports and provides:
+ *  - Temperature and voltage readings (hwmon)
  *  - 8 GPIO pins for control and monitoring
  *  - Hardware watchdog with 1-15300 second timeout range
  *
- * It integrates with the Linux GPIO and Watchdog subsystems, allowing
- * userspace interaction with EC GPIO pins and watchdog control,
- * ensuring system stability and configurability.
+ * It integrates with the Linux hwmon, GPIO and Watchdog subsystems.
  *
  * (C) Copyright 2025 Portwell, Inc.
  * Author: Yen-Chi Huang (jesse.huang@portwell.com.tw)
@@ -22,9 +20,11 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/dmi.h>
 #include <linux/gpio/driver.h>
+#include <linux/hwmon.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
@@ -32,6 +32,7 @@
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
+#include <linux/units.h>
 #include <linux/watchdog.h>
 
 #define PORTWELL_EC_IOSPACE              0xe300
@@ -41,6 +42,9 @@
 #define PORTWELL_GPIO_DIR_REG            0x2b
 #define PORTWELL_GPIO_VAL_REG            0x2c
 
+#define PORTWELL_HWMON_TEMP_NUM          3
+#define PORTWELL_HWMON_VOLT_NUM          5
+
 #define PORTWELL_WDT_EC_CONFIG_ADDR      0x06
 #define PORTWELL_WDT_CONFIG_ENABLE       0x1
 #define PORTWELL_WDT_CONFIG_DISABLE      0x0
@@ -52,16 +56,60 @@
 #define PORTWELL_EC_FW_VENDOR_LENGTH     3
 #define PORTWELL_EC_FW_VENDOR_NAME       "PWG"
 
+#define PORTWELL_EC_ADC_MAX              1023
+
 static bool force;
 module_param(force, bool, 0444);
 MODULE_PARM_DESC(force, "Force loading EC driver without checking DMI boardname");
 
+/* A sensor's metadata (label, scale, and register) */
+struct pwec_sensor_prop {
+	const char *label;
+	u8 reg;
+	u32 scale;
+};
+
+/* Master configuration with properties for all possible sensors */
+static const struct {
+	const struct pwec_sensor_prop temp_props[PORTWELL_HWMON_TEMP_NUM];
+	const struct pwec_sensor_prop in_props[PORTWELL_HWMON_VOLT_NUM];
+} pwec_master_data = {
+	.temp_props = {
+		{ "CPU Temperature",    0x00, 0 },
+		{ "System Temperature", 0x02, 0 },
+		{ "Aux Temperature",    0x04, 0 },
+	},
+	.in_props = {
+		{ "Vcore", 0x20, 3000 },
+		{ "3.3V",  0x22, 6000 },
+		{ "5V",    0x24, 9600 },
+		{ "12V",   0x30, 19800 },
+		{ "VDIMM", 0x32, 3000 },
+	},
+};
+
+struct pwec_board_info {
+	u32 temp_mask; /* bit N = temperature channel N */
+	u32 in_mask; /* bit N = voltage channel N */
+};
+
+static const struct pwec_board_info pwec_board_info_default = {
+	.temp_mask = GENMASK(PORTWELL_HWMON_TEMP_NUM - 1, 0),
+	.in_mask   = GENMASK(PORTWELL_HWMON_VOLT_NUM - 1, 0),
+};
+
+static const struct pwec_board_info pwec_board_info_nano = {
+	.temp_mask = BIT(0) | BIT(1),
+	.in_mask = GENMASK(4, 0),
+};
+
 static const struct dmi_system_id pwec_dmi_table[] = {
 	{
 		.ident = "NANO-6064 series",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NANO-6064"),
 		},
+		.driver_data = (void *)&pwec_board_info_nano,
 	},
 	{ }
 };
@@ -79,6 +127,20 @@ static u8 pwec_read(u8 address)
 	return inb(PORTWELL_EC_IOSPACE + address);
 }
 
+/* Ensure consistent 16-bit read across potential MSB rollover. */
+static u16 pwec_read16_stable(u8 lsb_reg)
+{
+	u8 lsb, msb, old_msb;
+
+	do {
+		old_msb = pwec_read(lsb_reg + 1);
+		lsb = pwec_read(lsb_reg);
+		msb = pwec_read(lsb_reg + 1);
+	} while (msb != old_msb);
+
+	return (msb << 8) | lsb;
+}
+
 /* GPIO functions */
 
 static int pwec_gpio_get(struct gpio_chip *chip, unsigned int offset)
@@ -204,6 +266,81 @@ static struct watchdog_device ec_wdt_dev = {
 	.max_timeout = PORTWELL_WDT_EC_MAX_COUNT_SECOND,
 };
 
+/* HWMON functions */
+
+static umode_t pwec_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_types type,
+				   u32 attr, int channel)
+{
+	const struct pwec_board_info *info = drvdata;
+
+	switch (type) {
+	case hwmon_temp:
+		return (info->temp_mask & BIT(channel)) ? 0444 : 0;
+	case hwmon_in:
+		return (info->in_mask & BIT(channel)) ? 0444 : 0;
+	default:
+		return 0;
+	}
+}
+
+static int pwec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			   u32 attr, int channel, long *val)
+{
+	u16 tmp16;
+
+	switch (type) {
+	case hwmon_temp:
+		*val = pwec_read(pwec_master_data.temp_props[channel].reg) * MILLIDEGREE_PER_DEGREE;
+		return 0;
+	case hwmon_in:
+		tmp16 = pwec_read16_stable(pwec_master_data.in_props[channel].reg);
+		*val = (tmp16 * pwec_master_data.in_props[channel].scale) / PORTWELL_EC_ADC_MAX;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int pwec_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
+				  u32 attr, int channel, const char **str)
+{
+	switch (type) {
+	case hwmon_temp:
+		*str = pwec_master_data.temp_props[channel].label;
+		return 0;
+	case hwmon_in:
+		*str = pwec_master_data.in_props[channel].label;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_channel_info *pwec_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+		HWMON_T_INPUT | HWMON_T_LABEL,
+		HWMON_T_INPUT | HWMON_T_LABEL,
+		HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(in,
+		HWMON_I_INPUT | HWMON_I_LABEL,
+		HWMON_I_INPUT | HWMON_I_LABEL,
+		HWMON_I_INPUT | HWMON_I_LABEL,
+		HWMON_I_INPUT | HWMON_I_LABEL,
+		HWMON_I_INPUT | HWMON_I_LABEL),
+	NULL
+};
+
+static const struct hwmon_ops pwec_hwmon_ops = {
+	.is_visible = pwec_hwmon_is_visible,
+	.read = pwec_hwmon_read,
+	.read_string = pwec_hwmon_read_string,
+};
+
+static const struct hwmon_chip_info pwec_chip_info = {
+	.ops = &pwec_hwmon_ops,
+	.info = pwec_hwmon_info,
+};
+
 static int pwec_firmware_vendor_check(void)
 {
 	u8 buf[PORTWELL_EC_FW_VENDOR_LENGTH + 1];
@@ -218,6 +355,8 @@ static int pwec_firmware_vendor_check(void)
 
 static int pwec_probe(struct platform_device *pdev)
 {
+	struct device *hwmon_dev;
+	void *drvdata = dev_get_platdata(&pdev->dev);
 	int ret;
 
 	if (!devm_request_region(&pdev->dev, PORTWELL_EC_IOSPACE,
@@ -236,6 +375,14 @@ static int pwec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (IS_REACHABLE(CONFIG_HWMON)) {
+		hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
+				"portwell_ec", drvdata, &pwec_chip_info, NULL);
+		ret = PTR_ERR_OR_ZERO(hwmon_dev);
+		if (ret)
+			return ret;
+	}
+
 	ec_wdt_dev.parent = &pdev->dev;
 	ret = devm_watchdog_register_device(&pdev->dev, &ec_wdt_dev);
 	if (ret < 0) {
@@ -257,19 +404,26 @@ static struct platform_device *pwec_dev;
 
 static int __init pwec_init(void)
 {
+	const struct dmi_system_id *match;
+	const struct pwec_board_info *hwmon_data;
 	int ret;
 
-	if (!dmi_check_system(pwec_dmi_table)) {
+	match = dmi_first_match(pwec_dmi_table);
+	if (!match) {
 		if (!force)
 			return -ENODEV;
-		pr_warn("force load portwell-ec without DMI check\n");
+		hwmon_data = &pwec_board_info_default;
+		pr_warn("force load portwell-ec without DMI check, using full display config\n");
+	} else {
+		hwmon_data = match->driver_data;
 	}
 
 	ret = platform_driver_register(&pwec_driver);
 	if (ret)
 		return ret;
 
-	pwec_dev = platform_device_register_simple("portwell-ec", -1, NULL, 0);
+	pwec_dev = platform_device_register_data(NULL, "portwell-ec", PLATFORM_DEVID_NONE,
+						hwmon_data, sizeof(*hwmon_data));
 	if (IS_ERR(pwec_dev)) {
 		platform_driver_unregister(&pwec_driver);
 		return PTR_ERR(pwec_dev);
-- 
2.34.1

