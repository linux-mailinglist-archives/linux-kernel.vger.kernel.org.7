Return-Path: <linux-kernel+bounces-813776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED151B54A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80E11C21983
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53082E6CA7;
	Fri, 12 Sep 2025 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uNt/o3Pp"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58002DC778;
	Fri, 12 Sep 2025 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674955; cv=fail; b=TacAlyY3sjxYiDgXCzy2aH8ByZLF2T1WdNXyzVWxH70F34Kfy53/rtjsNsDAJ8eIeLA/VDTdKc8UWEoSYLVXY3pARMxjPXqFTkwgJaOgYg6GnO4pzusbNkCbCvh9XkaC5rvHGe1dPxaCCAsGDYWOmtYR4HPywC6fMTLKv2lNDz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674955; c=relaxed/simple;
	bh=tH6+HIjC0oI/bMJMJSYe9cdUTuZ/qTSFMCmT581TCCc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WZVyVz3QYCoA0wsegqHdyWHIMHK4wbRh01N2unkBSHLjoK2DRQsZYY3Ggj/lx/HB3kMlN0Lfk1gOBRjyKFb4aRhIbfsbNVsu0cw/lHuNbvqFVU1XsjYrAthGKYXK74e8nMwKgK8z5yc3CD0iYk6X16YXgiE4cJNQ2rGJOiIRsLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uNt/o3Pp; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9Npmqf84m3NljmUwlAuZ9E/mGJyix1bby/nJyRI6dh8xVPQDakFn56tLtEeJIXrAnjKooTxv70QT8jgDfL0/RcWvHfWH/cT9hFCTajAqVSUHMOJDFvSdy1QQlsIa4LFUH3ajII8Ls+vPJHnbagfLe+6fz8IOC/UPSckUYbeVHrg0xs8B8Ms1tFkndA9CXWlJjUHiO1IXknfZcnnp1yAlVxi9F4yjcYkvSxHsS9Y1mcHsJCCqy96hr3goZJkgPLGaJ3X3/iAwY0QBHkZ1sONtVBi4H28rFYr1aOvXR/eaE/AvyLZDLxsG2FUd0fa+joN+q8Cn0uisqjFNJsc9rShTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDUTAsvETg2c38LLcbw9mPZUA8Z524WXPaR4agWpAwc=;
 b=Yl4ZX3JCOPUTkt5dY/PFwBWPciY4GqBjw4ntawzUYB89oGawimhAIbWvjodKgFXeuR2/y375GDzdWjOze61P9FLtdIUzpejkIFIOOvyFgKsP5/NvMZBVjSuzxxwtwOoNxJKCzpxQkRMn8yFVvc5WraxuJoQ6PQCi7rMwbp01s74J6cld09TmNbp7agl6tljre58C8nHH3SXsChRT1YrHJa9isyCfUFHSakp6EqYNKHLaHi7EJPzbOV/wlmiHmq2H9MmZjivf2bXOBLUoHqiM1ud/sUM/u7KkPId2VDp0/uHOg0PPzTqYjRYYQsddYXWs3BUQq367SUyFTqJq6wFoaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDUTAsvETg2c38LLcbw9mPZUA8Z524WXPaR4agWpAwc=;
 b=uNt/o3Ppr60HTgswq4PM89LUF7qCklM567DiQyVvGT5H0gBWzqmi4ayFrz+luQEvwXzfXn4um7l6/7ywEuiZj8kfynA6wXydEZN/7zq8GKZ7tq2FWiyXr19PzpQlphWXGo7gLXi3V9N9JKDmo262hVWa3ZhQ8ke/bL68Ut/oes8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Fri, 12 Sep 2025 11:02:29 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 11:02:29 +0000
Message-ID: <985955d7-bc77-4483-86e1-0e3382e1f4b5@amd.com>
Date: Fri, 12 Sep 2025 13:02:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: versal-net: Describe L1/L2/L3/LLC caches
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <f740bf2d0af1e7e50d76196ec050c0fdbeceb049.1757338426.git.michal.simek@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <f740bf2d0af1e7e50d76196ec050c0fdbeceb049.1757338426.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0054.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 09627442-bf30-4908-058e-08ddf1ebdda3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TW5tZ0xEbFFzWlFwaDhBV0ZVRCtsNjd2T3o5WTZvQmoxODBZZmRIK1Fxb3pM?=
 =?utf-8?B?V2xsa0trY2w1RzRiQ21tZWt3UVJpTzNZaUY3OVJRYlBaT0wydFJ0eWp0YWlV?=
 =?utf-8?B?VVFoOUlnNTlUU1E1eUUyYlFSaVVkeExRNWl4Z2xsYXZLdUszb1JlTTlkRlFx?=
 =?utf-8?B?cDlodWVTU2NPOWZtNjAwYU5WWk9PUUNSUEtyMlE1UUR1am5UZ1JsN3AxbXpu?=
 =?utf-8?B?OXdZbmRlcVU4bVdNUSs2V0doaEFSd3ArQnpRbmQ5SFptTS9LK2NwOTJHc3Y4?=
 =?utf-8?B?UFp1emMxUzZsUHprcDh3U1lENzNKdmVNaUdTc05wNXYzbnFGUTlZcVdFZnRt?=
 =?utf-8?B?YlU4dnJncW8vMFJ0L2VNSDVPZTg5cEdKT3k5Tkp5QjRSUWpNL1hWR0lNKzhD?=
 =?utf-8?B?K1VqYlM2a210ZklrTmtWYVB1Yjg1Q2F3dG9Pdk9ydXhyUzdHUlFhdkpIclBi?=
 =?utf-8?B?VVVBK0EzVnZGUFN4VnUraEpJcWxQWmJ4ZFJlT0ErRjlSZ29CZ3h1ODNhZ2sy?=
 =?utf-8?B?a1NQNzJTcndBTWd3empzb3psS0djZ3pRYzEyekhyRDg2VU1hQ2dkTlluOXR1?=
 =?utf-8?B?M2V2eTZYaHJ0eXkwa0VFN1JrYVQ3cGM5bGZYMzVETnpIUHZiZFhTN1FBZnJF?=
 =?utf-8?B?UlVlei9iRHBiQ1ZKaDZzVnowRzRwRzBhR1MrZExac2VkTVlYL1dPeHk1cGpU?=
 =?utf-8?B?NllUOS9JdngrQzdQTHNrVHRIbTJMTU9BS29zQjBOd3lrcnFjenVieEFvSlZ2?=
 =?utf-8?B?cFQ3OXZVaW5yUWhSRnFKc3lFUkhwWTRuSkZyaEVkdHVqRDlQQ24zWGs4R0xp?=
 =?utf-8?B?UG5PSlhNblB1aXB1SzJueEF5VFRvQ05QWkJTbExGaTJSODBvZFJQT2taNTJN?=
 =?utf-8?B?dWNLb2I1clJPK2Joa0NPSzJ0eUVrMkh4MGpSRDNlUzU3eUFOenJ6dmwvVW9k?=
 =?utf-8?B?SlVXRkNhTEN6QUVhd0Z4b2QxTDE1eHBNOXhIeitpVmhDTTdPNUJ4SGFZNDc3?=
 =?utf-8?B?T0VuVmNEdWxqc1F3V2pxc3V1SXlvWVAwZTAxajhNNFJxVTB2eSsxaHdJWm9u?=
 =?utf-8?B?eFowZDJOamdvV1Z2SWZmUEtTaHJqVFFyUjJMOHF5U1JEcm1BUytva01KaFZY?=
 =?utf-8?B?cEhrbVhvMHpCeG91K0RWMCtBdWtZSlI3aFJhYUxZTjV1TGZjS09hUXM4L053?=
 =?utf-8?B?VzZXZnFiT3YvRGt0cTArUUt1MGEzcEFldUFNWk9BTUZISWRpZC9COE5BL05S?=
 =?utf-8?B?UFVZcm0zdXdFektVK2NXSndxN0l6QnRRTzRaQkxveUtFZ2UzQncyYkpOZ0c4?=
 =?utf-8?B?Z21rYWdDR0plS3Rwc005VS85bi9vbkpPbUdlRlJDdTNTMlNBdVQwR2RVWTM0?=
 =?utf-8?B?ZHMxUXZ4V0h3VVBlUzVnbzJSWDJOY2hGb0ZWbjgvZ3VJcWhZeUlSQVRtTGxv?=
 =?utf-8?B?K1RGSnRQUWEvVFNlM3M2a0NrWTM3SnNIQjNWVVA4aGR6cW95ekQraHBoNzgw?=
 =?utf-8?B?dWk2MEhZbTBJWm5aZ1J4V2MvQ3VtbEhYYXB4UG1RR21oYmFSQ3g3TDZtT0hQ?=
 =?utf-8?B?SGxtalZMYnNpaEFaOFBUVEZwUC8vZmNSUWF0amVnY3FOc3FXOFFKKzF6UDlS?=
 =?utf-8?B?SkpLUjZ2dm42VS9hZFhhVHF3WWtpaER4REhDMTVqYjFoU1Rmc1hzcmhZWWNQ?=
 =?utf-8?B?VGRGMVA5aFArcVRPSlJ6cjNpYjkzWVpqNzYxZSs2aElHUVBCR09CN2xQNFFB?=
 =?utf-8?B?WUZlWWs2Qll3dytaMGlvUHlGcGpWdHp5MWtuVTNwak92dE1UVVRvOFhqYksy?=
 =?utf-8?Q?h8e82Dj7PWfiMFkk77dEAZ6TjZb6lH4lzVnoQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTRTYSt1RzAwK1gwSE1qUTJOdmd6M2tDRGZRREFicXZUTzhTTFpTenEyZU16?=
 =?utf-8?B?dEp3cllBR2loSU1DVDZFT3lEUnpyblpDbXgyOW5OWG9GbVpqWUdWVWlVQS9n?=
 =?utf-8?B?dW8wSTQ1MVFmaFVadThYclJNd3JBQ2d4L01BdUpBemt2MlFFTHZsemFickhi?=
 =?utf-8?B?MGxXS2dJbC9Cb2VwSG55Z01aVGFCQ3ZOb3JoaWhZV2Y4bXE4UU4wQm82ZXJj?=
 =?utf-8?B?NzhjeXJEQVJaNk5IRFczRWk3WFBOM1JXYjMzU1I4OEs1YUVncFdRMnNvUkRF?=
 =?utf-8?B?cVJlUldCbklrd1R0QnFFNW8yRWhYY3RyaFcrd2NZMUI2bFNpMDZ3WHVCUXht?=
 =?utf-8?B?OG93Y2dDNW1tT2V0b3FMbldPU3FaeHk4ZjhKS1hoTytjV2lHZExJZzdYNlJU?=
 =?utf-8?B?R3B5akh2ZUx1YVFlM3lKbXZGaEozcGFUcVlvTHJCTDZDVVhEOVN5NGtKcXF2?=
 =?utf-8?B?RHhMa0h5dUI0YzBncUIzZjNvMEI4aGFTc2dTVWdySEppYTRsWTYyWnJJZ2J0?=
 =?utf-8?B?ZkhkalZmT3VsaDBtMHUwOHBJQlJWY1NIaEJYZU5iQUNsUGdqTUhld1ZONVR2?=
 =?utf-8?B?ZVdUZTM3THdJa3pvMUNKMWh5R0xIS3FDTmQ4SEJnN2V1enFlZSs2cW5XK1A3?=
 =?utf-8?B?Qy9NVDAwd0F5Y2JvSUFGcjZCMmFUV1R0ZnlUaFk2aUZiSVNLWnBnSUFheUpF?=
 =?utf-8?B?TG1lUS9oT0lqQzhQWDB1Y0ZaSU8wR25lY2pqUUdkTU1VTVpUZW5BcElia1pE?=
 =?utf-8?B?TmhTOTgwRXl4dndBdnVGeExrV0pVNm0wZnpzQ2x4aWFyOGNWMWQ0NGlhT1I1?=
 =?utf-8?B?YkgzSjk0R01BRWg4MEgra28yR1NrTS9rRWVxSEdpWEhqUmw5YThIamYxbUFF?=
 =?utf-8?B?V0xTWnUzbzZDQVhMbytaZVMrUDBna0t2QmhlVkxwTUw1TU56eWF6S3c0MEdq?=
 =?utf-8?B?clJud3BmeHhOZkV0ZXRta0haSnhHQ1pHeEtVcU1LT09ObWFqM0M2SWYrMW5U?=
 =?utf-8?B?YWhZVCtJM3RBYkZ0Zk5JQ3daVFY2VnpBMVVoQ3VnNjVjQStreWNFWUNRMHUx?=
 =?utf-8?B?UWFnY01adGMzQzNSY0VURVkzWU5TQmgzcUJSNHczcWwweEgxc01FcVd0cnBV?=
 =?utf-8?B?SC9FQk5NN09uQSs2a0RUUFJUTC9xT0o4V3ZpbXRNSUh1TmIwQ0Z5b2NMY1E4?=
 =?utf-8?B?TDBRaG1DMXRXTnI3VzkvcmJFRDdUN1ZvUVdpSm9HbmZyZDBSaFlVMkJVV2JZ?=
 =?utf-8?B?WWZsK0h1aThZN1A5b2U1RUZucnY3NkRtU1dzdERNRHNpTmlQeENUbjVndFBX?=
 =?utf-8?B?eFZxMHNCa2pIWElwYjYzYmhJdnJBUHJQaFZlR25zU29taXY4S2FZbXVsdUwx?=
 =?utf-8?B?dXpzcGVxYUFqNGRqbGdoSnczNUpSTWtubjRVWDRqeS9yUkQ0cXd6NythalZm?=
 =?utf-8?B?NEJnN1JDZzlDYkY0bE94VXhUdzQxbnhIUWVSUkZHSDVtTVlhUnJidHdvUWZU?=
 =?utf-8?B?V2RKVnBFeTRScHMycGcvbVNpSk1VN2tLaVR3bjZvNkViMUwwYjlXT2diWWVD?=
 =?utf-8?B?Y1NDLzBoTmhtL2NEd3prbkNRV2REdXJTYmJlaXNHMU9pN2M4WWxVWHMxOTNF?=
 =?utf-8?B?S2dZR2FOWkhaN3Q5ZENMZDZWN3lSSW4wRldwZE1GTGJ3TE9Jc0xhUndoSjNZ?=
 =?utf-8?B?R29uR1RtK2loWEpxSlNVaHBUQ2J1T0prOUdXNzkwb1NQcDdnNjhSQlh1VEFu?=
 =?utf-8?B?R1Q5NTdWMVJ0Vk5DdWZhalFRTkJqd1pNQ2F5RGJuYzluNFJML3lnRzdJZlFs?=
 =?utf-8?B?anJxWk1HS0dKZklQRmVBT2JvZ3lSZGtEYStUVys0S0J2Sm5BaUd6YXkrQWJJ?=
 =?utf-8?B?N3pNeFZlbDZpOU5iVENPY1VCdkQyb2hCM09sN29nOXlmWU44SEhnd1BUZ2hF?=
 =?utf-8?B?djArL1RqeDZENmRQbWhlVEhmTnV1OFJPbzQvQ1ZkQ1hiZ1dqd0lXQnVReS9q?=
 =?utf-8?B?RnJSSUlCamluSWF3UWNKbmdtNlZFK1FqL3Nibi9Xam04UlBtVnhFNFdWVVg1?=
 =?utf-8?B?TmExaWdieHF4YkduRkU2T1o5aXhVelFyODRGck9ZMEpUL3I4bXcvYXloMk0y?=
 =?utf-8?Q?VKPZKDg5w8plTrsi+eh7cOxRV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09627442-bf30-4908-058e-08ddf1ebdda3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:02:29.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tT3fRWvvEEghM2ge8Indv3hWFkyd2nSwL8/NJDovxzpEXcym8V+sF7Ro35HTZmnV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118



On 9/8/25 15:33, Michal Simek wrote:
> Add missing cache layout description.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Also describe L1 caches
> - Add L1 to subject too
> 
> v1:
> https://lore.kernel.org/r/f2ee23526349a0674149c969a2176c906e529402.1756825388.git.michal.simek@amd.com
> 
>> lscpu --cache
> NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL SETS PHY-LINE COHERENCY-SIZE
> L1d       64K       1M    4 Data            1  256                      64
> L1i       64K       1M    4 Instruction     1  256                      64
> L2       512K       8M    8 Unified         2 1024                      64
> L3         2M       8M   16 Unified         3 2048                      64
> L4        16M      16M      Unified         4
> 
> ---
>   arch/arm64/boot/dts/xilinx/versal-net.dtsi | 408 +++++++++++++++++++++
>   1 file changed, 408 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/versal-net.dtsi b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> index c037a7819967..412af9a394aa 100644
> --- a/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> @@ -104,6 +104,28 @@ cpu0: cpu@0 {
>   			reg = <0>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_00>;
> +			l2_00: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_0>;
> +			};
>   		};
>   		cpu100: cpu@100 {
>   			compatible = "arm,cortex-a78";
> @@ -112,6 +134,28 @@ cpu100: cpu@100 {
>   			reg = <0x100>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_01>;
> +			l2_01: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_0>;
> +			};
>   		};
>   		cpu200: cpu@200 {
>   			compatible = "arm,cortex-a78";
> @@ -120,6 +164,28 @@ cpu200: cpu@200 {
>   			reg = <0x200>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_02>;
> +			l2_02: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_0>;
> +			};
>   		};
>   		cpu300: cpu@300 {
>   			compatible = "arm,cortex-a78";
> @@ -128,6 +194,28 @@ cpu300: cpu@300 {
>   			reg = <0x300>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_03>;
> +			l2_03: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_0>;
> +			};
>   		};
>   		cpu10000: cpu@10000 {
>   			compatible = "arm,cortex-a78";
> @@ -136,6 +224,28 @@ cpu10000: cpu@10000 {
>   			reg = <0x10000>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_10>;
> +			l2_10: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_1>;
> +			};
>   		};
>   		cpu10100: cpu@10100 {
>   			compatible = "arm,cortex-a78";
> @@ -144,6 +254,28 @@ cpu10100: cpu@10100 {
>   			reg = <0x10100>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_11>;
> +			l2_11: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_1>;
> +			};
>   		};
>   		cpu10200: cpu@10200 {
>   			compatible = "arm,cortex-a78";
> @@ -152,6 +284,28 @@ cpu10200: cpu@10200 {
>   			reg = <0x10200>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_12>;
> +			l2_12: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_1>;
> +			};
>   		};
>   		cpu10300: cpu@10300 {
>   			compatible = "arm,cortex-a78";
> @@ -160,6 +314,28 @@ cpu10300: cpu@10300 {
>   			reg = <0x10300>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_13>;
> +			l2_13: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_1>;
> +			};
>   		};
>   		cpu20000: cpu@20000 {
>   			compatible = "arm,cortex-a78";
> @@ -168,6 +344,28 @@ cpu20000: cpu@20000 {
>   			reg = <0x20000>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_20>;
> +			l2_20: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_2>;
> +			};
>   		};
>   		cpu20100: cpu@20100 {
>   			compatible = "arm,cortex-a78";
> @@ -176,6 +374,28 @@ cpu20100: cpu@20100 {
>   			reg = <0x20100>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_21>;
> +			l2_21: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_2>;
> +			};
>   		};
>   		cpu20200: cpu@20200 {
>   			compatible = "arm,cortex-a78";
> @@ -184,6 +404,28 @@ cpu20200: cpu@20200 {
>   			reg = <0x20200>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_22>;
> +			l2_22: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_2>;
> +			};
>   		};
>   		cpu20300: cpu@20300 {
>   			compatible = "arm,cortex-a78";
> @@ -192,6 +434,28 @@ cpu20300: cpu@20300 {
>   			reg = <0x20300>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_23>;
> +			l2_23: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_2>;
> +			};
>   		};
>   		cpu30000: cpu@30000 {
>   			compatible = "arm,cortex-a78";
> @@ -200,6 +464,28 @@ cpu30000: cpu@30000 {
>   			reg = <0x30000>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_30>;
> +			l2_30: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_3>;
> +			};
>   		};
>   		cpu30100: cpu@30100 {
>   			compatible = "arm,cortex-a78";
> @@ -208,6 +494,28 @@ cpu30100: cpu@30100 {
>   			reg = <0x30100>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_31>;
> +			l2_31: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_3>;
> +			};
>   		};
>   		cpu30200: cpu@30200 {
>   			compatible = "arm,cortex-a78";
> @@ -216,6 +524,28 @@ cpu30200: cpu@30200 {
>   			reg = <0x30200>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_32>;
> +			l2_32: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_3>;
> +			};
>   		};
>   		cpu30300: cpu@30300 {
>   			compatible = "arm,cortex-a78";
> @@ -224,7 +554,85 @@ cpu30300: cpu@30300 {
>   			reg = <0x30300>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			d-cache-size = <0x10000>; /* 64kB */
> +			d-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			d-cache-sets = <256>;
> +			i-cache-size = <0x10000>; /* 64kB */
> +			i-cache-line-size = <64>;
> +			/* 4 ways set associativity */
> +			/* cache_size / (line_size / associativity) */
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2_33>;
> +			l2_33: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +				cache-size = <0x80000>; /* 512kB */
> +				cache-line-size = <64>;
> +				/* 8 ways set associativity */
> +				/* cache_size / (line_size/associativity) */
> +				cache-sets = <1024>;
> +				cache-unified;
> +				next-level-cache = <&l3_3>;
> +			};
> +		};
> +
> +		l3_0: l3-0-cache { /* cluster private */
> +			compatible = "cache";
> +			cache-level = <3>;
> +			cache-size = <0x200000>; /* 2MB */
> +			cache-line-size = <64>;
> +			/* 16 ways set associativity */
> +			/* cache_size / (line_size/associativity) */
> +			cache-sets = <2048>;
> +			cache-unified;
> +			next-level-cache = <&llc>;
> +		};
> +
> +		l3_1: l3-1-cache { /* cluster private */
> +			compatible = "cache";
> +			cache-level = <3>;
> +			cache-size = <0x200000>; /* 2MB */
> +			cache-line-size = <64>;
> +			/* 16 ways set associativity */
> +			/* cache_size / (line_size/associativity) */
> +			cache-sets = <2048>;
> +			cache-unified;
> +			next-level-cache = <&llc>;
> +		};
> +
> +		l3_2: l3-2-cache { /* cluster private */
> +			compatible = "cache";
> +			cache-level = <3>;
> +			cache-size = <0x200000>; /* 2MB */
> +			cache-line-size = <64>;
> +			/* 16 ways set associativity */
> +			/* cache_size / (line_size/associativity) */
> +			cache-sets = <2048>;
> +			cache-unified;
> +			next-level-cache = <&llc>;
> +		};
> +
> +		l3_3: l3-3-cache { /* cluster private */
> +			compatible = "cache";
> +			cache-level = <3>;
> +			cache-size = <0x200000>; /* 2MB */
> +			cache-line-size = <64>;
> +			/* 16 ways set associativity */
> +			/* cache_size / (line_size/associativity) */
> +			cache-sets = <2048>;
> +			cache-unified;
> +			next-level-cache = <&llc>;
> +		};
> +
> +		llc: l4-cache { /* LLC inside CMN */
> +			compatible = "cache";
> +			cache-level = <4>;
> +			cache-size = <0x1000000>; /* 16MB */
> +			cache-unified;
>   		};
> +
>   		idle-states {
>   			entry-method = "psci";
>   

Applied.
M

