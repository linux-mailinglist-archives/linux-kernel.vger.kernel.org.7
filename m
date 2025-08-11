Return-Path: <linux-kernel+bounces-762542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8E5B2083D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6364C2A0672
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027482D3228;
	Mon, 11 Aug 2025 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QFE5SqWW"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DBF8248B;
	Mon, 11 Aug 2025 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754913346; cv=fail; b=cxi65drCbbZnff/t32ot4QCO44lnmSGgDBrdPXN71yzph2zRL3yIJobVJtVjDxgjYSjNwYggLkEPbBdJ/cUcoFE9aM/AYhtGgeNB+gtqhP/Sjs9Cgf+3SdeMWUSxkCb0fJ2IUB+Nqe1JKf7q2cOAdML2/iqof5TaV3LTMbK7bT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754913346; c=relaxed/simple;
	bh=u4JrjbNuXKekm/nR0he4raI2/XzsIeLTHf5eDV+/7vc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IxwucKYjjQW0Ssbbpy+uXtiFQfvO4I3w30/5FQ6B+T358XNG3HCo2IbzpC6UqDRh4RvwJjapbK9S6GJsCpfuKl1RCO3zPbZ8PY0SoJwO+sPHkI60uMa//WQDlJHEZ8VP+fTKORclYd/x3iZXF+nv913fukwsDvx5XXgHruq4a6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QFE5SqWW; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfnZhEmP+VrrVHVQ4ruuct4uqI6aFawXmfl1d+80WP18xXE3ph//TH80NIi3pZap8nG6RcH+1x9PhJZz1ITOz4bpTYR5ZwaYPTQkFvm5xcA3M6H7oJ2s1c0+yP/yD9zmsxV0QRyoggPc7Ywc3IcFg0QVVvd5o1ZCjdDMvVWvBJuZlZUJJBJka8hMPhFbb0TfKLGzB4JgguhzHkvVAF1pjveFDe22FRi+5/re9lF9AwzQig3LuZLVSLs3BCuhrjB7fi4Mv89ClppMx+9jkwrpwAd6U4bPW2noyXDV1HmAK48OhTeAJf2hr2dr38AwlLNGv80d5dHV75BnQIM/1Oe3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqLelavxoGk8HA5LpiuDNyd0+yaZcL79wpdEoXrNBpg=;
 b=uZzqiFoSyS0BcdYWlWpYtMTwZltb2fJlGRYwTVfqIE/7K1QGW0op6osxhgfQhImn8tljL+RNN5bkIK8LgxX0/mL808CHm/LF1dlfcVufPt2Y3dnS+GTrTrvHNs/w1E3ChfSBX000r6txMxSyryv+YluQbiKvOrfl/Ek2eDVrD44Q/G/HfhRlR6qt6LhwKgARxkFda4JIKxaRq+lDF+vMymoa1DBtzLA6HCEcC7ZZAkwOUAXgUFa9yLavzSkudNcsVyVw9dPq0dekCw7ueBcdfZTzoFGO1WolrRGAvJkjNyZeYxCuiA7w3yfpOxuZ1Xm0esonM9J3ONkGVKofuSMLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqLelavxoGk8HA5LpiuDNyd0+yaZcL79wpdEoXrNBpg=;
 b=QFE5SqWWq/TecXKP6MBLgPBZA+fqs48fUSbYpgzj/j2jGvdwzOKLuL86srYRx8v/NhD0Z9eyVX7oOqyv4Ari5uPD0tkcBKlVz2dzdAqFNgrUfgoZg+IlfNx6lFvcUDo3r4RwIiYOjteV8t+VngayoXaMg3pWATXR6nwl1XCCxBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 11:55:42 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%7]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 11:55:42 +0000
Message-ID: <eec28fe2-6722-496a-9256-2da2559fb18a@amd.com>
Date: Mon, 11 Aug 2025 17:25:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] dt-bindings: misc: Add binding document for SB-RMI
 I3C
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, linux@roeck-us.net,
 Anand.Umarji@amd.com,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
References: <20250728061033.1604169-1-akshay.gupta@amd.com>
 <20250728061033.1604169-5-akshay.gupta@amd.com>
 <c09da948-6e31-454d-acca-99c226c18c61@kernel.org>
Content-Language: en-US
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <c09da948-6e31-454d-acca-99c226c18c61@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::28) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: ef218cc6-bde0-400b-9fe8-08ddd8cdff96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1F4RmRhZ2RuZnkvVG43Tm5VWm1OWUVQdkpRaUcrczB0SEQ1RmxyT05pc1JR?=
 =?utf-8?B?eUovWi9BLzY4MC9oeXBDMzNDbTNIcjNiTnJScnl0RXdlRTFGUy8xd1dvTVRh?=
 =?utf-8?B?SE14UGRoV3d1RXJ4V0I5eDZtVXUydnVsTm1qVEpWTjdMWWE5elRGK2RPZERj?=
 =?utf-8?B?NDJCK0liVXArQTFTS1ovM1VaM3Y2dEVHNnFFQUh5c21oejBQem9MQmNGUjVV?=
 =?utf-8?B?RXJBdEp2N2JMVC9ZdytzWm1jRGQ1WURYRXFHNjcwdUNCTlVlNHlPT2xISHdi?=
 =?utf-8?B?dmN4Y3VJN3BRYnRtRkE5RW5HWWxvTVUyUnpudzZjSmgvMkdXUVc0K050OCsz?=
 =?utf-8?B?YWV2dmN2K2EzdWNnZXoyOHo5bmQxTE9XcjB4N3hGWlMvTzBuMXlnMS8vdDFC?=
 =?utf-8?B?dmJ3TjQ4S2tLZVBSK2Y3aUlPaVp6U2ViYVlYTnRadTV4b2ZGdXhkL3U3MUF1?=
 =?utf-8?B?Q0hUWmIwejRrcFpLdXhwRVpTYzdtRGh4RURkMWJFeHdCU1NMSEVVSVNnQmZV?=
 =?utf-8?B?cHRBa0V0czdSdmsxa29zUlRRYUxOY29qQ3FabGVTaytTOHRkMTZmOUFGWXNv?=
 =?utf-8?B?enZYaUpmM0V2dWdxNFZOSk9BOUtMUXNnSnVuanhnbnVBbHVleWpibXgyay84?=
 =?utf-8?B?VW5rdExjbTVjbWR4SEFOUGhZY0ZYdXd0YnhXTDlqeTh3TWZwcXpQY3phVHp3?=
 =?utf-8?B?Mld1Mm9LNEp6TXpVSnhJOGwxRnczd2wvNjJNajVRWCtCRnpDeG9IQ0ljS2p5?=
 =?utf-8?B?M1pJWStFNWFPQjZmQ2kyTTJ3amNKaHg3MTRlTnQvYWlSWk9IUTUxQ3pud1p0?=
 =?utf-8?B?Zk9zSWw0ekdxZ2NjNWxaaDg4U3VOL1Z1aHF0aCtDRU96bUxOSUw3cnF3SkhH?=
 =?utf-8?B?a1J4YnJSRkVjcnpDUGRJQUJkU25oVFN1MkxuMytTbkQvQTQzcmlQV1pjbGpy?=
 =?utf-8?B?MllmRW1sVFI3R1dWODFYQ1hvU0RpWmovYndFdERKK1BvbFduelFYOE05cXBI?=
 =?utf-8?B?ZHU1U1RYTUl6d2FFL3l6dGpvZXpFVVE5TlJrcHFlSGVyVFBkWjRFMFA0OU85?=
 =?utf-8?B?ZTdUUWRQVFp3VWdnK216a1RuTjNodjEydEFWc2oyRU91bWFMVDlxTytBbE5D?=
 =?utf-8?B?VzVCUDF4TE54a2p0dHJScWQ3WjlzSmtISzdyL1dFT0d1ZHhid0FLL1hnZWZV?=
 =?utf-8?B?VkpOQ0FheEY5Umw1K01jU1VvUTdCaHFoUVpmVmprMEtZMjdnZnpRdGt5WFVD?=
 =?utf-8?B?Q04rTDNZcnNjeHJRZmhjUmdweFY1cEFSSlZxK3lDVUo3d3RRZUdvKzNJSkla?=
 =?utf-8?B?cDJUYkpLVFBERk80d254Q2c2UmhQMUJUTTQ5bk4zU1JqQWU5bWdhMXhQS1FP?=
 =?utf-8?B?TTRlMlg1TEFqVVVhbWJlVjV3bC9HRCt4Mkd6dHhZZ3lqelZ2Z0lPcHVvNzJw?=
 =?utf-8?B?ZmVXa0dwM0svQWkwMFlpS3JOc2VESTlZSGdKVFc3Nmlpd2FXZ3NWL1dUNVRG?=
 =?utf-8?B?SjZ3NGIvUkN0a0NNZ2hnaENINTFqR2RTaE5HbVZWWUN3dC8weWNKdm5Rbkp5?=
 =?utf-8?B?a0owbE92TWhaQThDY040Mk1UM29HbSsyS1FYQXp5TTlnL0o2MVNhWmlINjQ0?=
 =?utf-8?B?VnUwSmVjWWF5bnFETHUyWWlkbE1leGhwM24xVmpsMCtzL3F1NXhKTGxQa3RZ?=
 =?utf-8?B?eFo4TTRrV3NPQ3ZmcG9vWFg5eEVWRTZBYmtnRmtNb25yVUY0QndiRkpMbDZi?=
 =?utf-8?B?RHlYQ3VXL0ZUU0hBL0grL0I2L0VBMkRmS1hEcGtKSmpmRVl5VkkveExrdmJU?=
 =?utf-8?B?L1hRVWhBdW1RQXRrdFNSazdVcWh1R1BtNTRCYVVnZko1eTdhOE5UMVJoSDFo?=
 =?utf-8?Q?Ry/1XfxOmBizT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkkzTXBRc1JaL2w5QmRnUTNlaEVteTZuTnREdHdrbC9iV0FQZVZRYkc2cnE1?=
 =?utf-8?B?L2FISFd4OFBZWEQ4NWFtVVhGaE9FNXFlaXNmVWpFOWZNRDZ5dUYvWkFTZWUr?=
 =?utf-8?B?cmFjcWxKSyt0eUE2TUdGYVExaGVEZnJEeExQQU1rY2ZudWJHVjgyTnc4RHJ1?=
 =?utf-8?B?UUxzc1VzNmRjelJ1Syt1bE5zZHZjdTgyRFJVZXQzdXVISmdDR0poWHFhTzJz?=
 =?utf-8?B?Vlg0YnVJQVhuaVdUeGJjRW9qSzZxUzIyTm9TQUJ1Ynhoa0o0T3Z5WUI1KzRC?=
 =?utf-8?B?Sm96VDROT2RHdFR6TUNCUGVObXpjTUhTaFlPY29RU2FVUnpvUDZSNVVrRE51?=
 =?utf-8?B?YU52OUdId2dBQTAwU2gzYnJQUG1CaDF6OHBaeWpXbUVaYS9odEZXbGVONjk3?=
 =?utf-8?B?ZzE5Nk56cHgxVHZCUEZReXFLamMydXhmRzJYM1plMHFrQ25FL2kwYlVBb2th?=
 =?utf-8?B?N0ttL2lYc01BaFB4Qkk1V2NKZ3VXbmFQdlM2YUoxQ2RtM0tKL2pFSzJkci9m?=
 =?utf-8?B?Y1VRSDJ1Y1VvbWVjWlZBS3NESzhLRkJhcDJ3Qnk2bStBRnQ4UmF2NUNPdE5o?=
 =?utf-8?B?d2lzdTVjMUtxdHJtU0tVVTFIS3hkQUp3OGt6clVUMlcxT2xiU3ZxV3JsTFhT?=
 =?utf-8?B?S3IzN3ZIYVF4a1J3V3VNQkJZZlJkSnovd1EwelQvMmhWcFJzRkJkTkJLdnNz?=
 =?utf-8?B?TVVraWl5MjhMais5T1FlOWoyV0lKVXdnVnhQeGxoQ3NqZnYyQW5SUExXN1Vw?=
 =?utf-8?B?eWRaWnFhRVVVRGtQN09ERXVnVFd1U0dadEVMTm5KNEZsVXZQcDZDbWNGSkNW?=
 =?utf-8?B?M0RwUlpIOGQ3Z08yNnJZV1dweEI5c0pzb09tV3pvQmg1SlJlanpxaXZWT1RP?=
 =?utf-8?B?dFAvS0tMTUVtSTB5bFE2UlVENGtEbzYyZ3BKUXdQZzRzQm80S2RxaDUzK25P?=
 =?utf-8?B?Uzh6OVQ3aUxXK1BZQUNjVnM1UitnSURMcnBXci83VXluSHNvRkNSS3dmNkY1?=
 =?utf-8?B?c2J1UW5FaTl5Y3VUMEU1N0h6cmdra2tidDlmaFFjR2hGMFJqQ0FObnVoSzRZ?=
 =?utf-8?B?TVNZSjVOdzFZTnJJdm9sbmNYQUdsOFl3OTlDK3l3ZmpvWVIxWHZoWlVaZVVn?=
 =?utf-8?B?akpNa0FuWGFPYnU0U2J2dm5BUmo4ZzFTdTJ3b093ckl4Q0ZEdmlHZmttUjFQ?=
 =?utf-8?B?ZklsSnR2R0pyOE8xUE5LVjVjNEZQZExWWUltOC80dkFUb1czeEZIblNuMW5B?=
 =?utf-8?B?RzlySkw4MkxiTHR3VjhzMzZ2aWZ2L0xpYVlRbnFra2piLzBZVVBmK0kxQlBB?=
 =?utf-8?B?M2pmSkpGK01CamF0RXFxNkZiU2pIbit1NnZtbG12dWJaRlp1TGRvcW56R3hp?=
 =?utf-8?B?QkxoWE9RcWhzMGRrQ0VxUkl2ZmIyTnJTaW5DdVVQRTFmTDYwZzcrUDJZYnZp?=
 =?utf-8?B?Z2hySjJKSWhGNUI3eEkra1NpZmk3YkpqNERia0UzL3BuSXhwUkZvUUlEUXZr?=
 =?utf-8?B?NFNyYVYyYlZsWE5PMEt6NDAyUStZY1lEa0RheWZvMWs0M2JZQ3NHNk5CRUVw?=
 =?utf-8?B?SFdGdjFIa2hhUklEUXd5dXBSWGRMdk83OGMvMU9hQm1RTVNmL29rSkdwVzRk?=
 =?utf-8?B?bzE1Q2lQbWN2UUwrZGs3bi9lSjBsd3RON3U5VVN2Tnp5aE5LNWlwVzY4Z2hQ?=
 =?utf-8?B?bWpIMDl5OW9OSlk3WDlNZzBPeGNuOVNIblg4MHNnanRtWFphM2NHaUdiS3M2?=
 =?utf-8?B?Ni9tZ3BQTzNGRVJFamQ3cysrRDFEaDE2M3lqRjJGaDF3UFlGMVpkazhrUVBJ?=
 =?utf-8?B?WUJ6ZVp4QWJWNWU4K29vaGlma2wxcmtTV05XWWc4SXZYbVZqRGJWVVlLd1Jh?=
 =?utf-8?B?NTBxei8rK1d4YURmNUtnL2Z2U2l3WHo5cjIwdG94dGkwa2JxSk95MWVsT3Ux?=
 =?utf-8?B?UHlLL2twOFE1aHFISzVtY211STJwZStsTS9pL1RjdnlINHVWRGd1UlhTWm13?=
 =?utf-8?B?YnQ1WFdYcHR2Q0cvUlFYQUltdDFWSjNTRVhnUkZIeit1OE9nWTVGb0N6S0Rl?=
 =?utf-8?B?c1lNTUVUdngwK2tnVkdVOEphUUNGVjBtb0g5a3NkbVBuU0YyaVFDamhmMWFN?=
 =?utf-8?Q?SeKAnEJ2K83TTJbh6QwDMLqQ4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef218cc6-bde0-400b-9fe8-08ddd8cdff96
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 11:55:42.7502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDoghrybSEYjwFD8sX0OiG65qH6IVti1LixhvPSooOM6J3xMfwK6S3o2YE0P010gJnGEkmEYh40CwOfrWPDT6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934


On 7/29/2025 12:01 PM, Krzysztof Kozlowski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On 28/07/2025 08:10, Akshay Gupta wrote:
>> - Document the dt-binding for AMD SB-RMI
> Why every commit is a one-item list?
Ack, will add more information related to changes
>
>> Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> I don't believe these reviews. Code was obviously buggy, but still reviewed.
>
>> Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
>> ---
>>   .../bindings/misc/amd,sbrmi-i3c.yaml          | 56 +++++++++++++++++++
>>   1 file changed, 56 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/amd,sbrmi-i3c.yaml
> Your previous patches make no sense with this...
This will push with I3C driver changes
>
>> diff --git a/Documentation/devicetree/bindings/misc/amd,sbrmi-i3c.yaml b/Documentation/devicetree/bindings/misc/amd,sbrmi-i3c.yaml
>> new file mode 100644
>> index 000000000000..1d19571c2095
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/amd,sbrmi-i3c.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/misc/amd,sbrmi-i3c.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: >
>  From where did you take such syntax of title?
Ack, will update.
>
>> +  Sideband Remote Management Interface (SB-RMI) compliant
>> +  AMD SoC.
>> +
>> +maintainers:
>> +  - Akshay Gupta <Akshay.Gupta@amd.com>
>> +
>> +description: |
>> +  SB Remote Management Interface (SB-RMI) is an SMBus compatible
>> +  interface that reports AMD SoC's Power (normalized Power) using,
>> +  Mailbox Service Request over I3C interface to BMC.
>> +  The power attributes in hwmon reports power in microwatts.
>> +
>> +properties:
>> +  reg:
>> +    - description: |
>> +        Encodes the static I2C address.
>> +      Socket 0: 0x3c
>> +      Socket 1: 0x38
>> +    - description: |
>> +        First half of the Provisioned ID (following the PID
>> +        definition provided by the I3C specification).
>> +        Contains the manufacturer ID left-shifted by 1 (0x224).
>> +    - description: |
>> +        Second half of the Provisioned ID (following the PID
>> +        definition provided by the I3C specification).
>> +        Contains the ORing of the part ID left-shifted by 16,
>> +        the instance ID left-shifted by 12 and extra information (0x00000002).
>> +
> And this entire patch is just noop. Makes no difference, makes no impact.
>
> Drop it and write proper bindings with proper description of problem you
> are solving.
Ack, will modify the content as mentioned.
>
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
>
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
>
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>
>
> Best regards,
> Krzysztof

