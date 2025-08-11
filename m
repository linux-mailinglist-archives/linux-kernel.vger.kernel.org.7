Return-Path: <linux-kernel+bounces-762541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F8EB2083A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 850934E30C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10582D29D8;
	Mon, 11 Aug 2025 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hcBM7nK9"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9021D3E6;
	Mon, 11 Aug 2025 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754913268; cv=fail; b=UWRHIIBo/nEWZyhTZhOucXxdezJhckdsg3uhEr5vd/wUyl4Zo3XD3dkiLINq1Xt4q95AFrmSiUNnlkw7y0VovmyX1TpnKm/GhX58s2xdvBmZzee5Ht4bTbNLbP3kOhVKTGKN4hXHeaOL9LTtdjh/WNadq6X/hFtXhF+veQE0cww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754913268; c=relaxed/simple;
	bh=t8oQ2Rj7/hR39hXjn4O8Yw/Kh6Z70NudGcqXW9Nfzws=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jj3xtlDcNWENRPpc24bMRxgqh2s80g2jFLXt9RRWQmZZR74qQ+wP4043BiQiSqmxlbYsWNDmhjLGJKLrl358voXcdJ646JmTtydXeHdY2h7p4kQ/BOgKUBzSNLXDzgxWuPswTqtjAdz2H7OAgkGMvxzAd0m9mPCrrI7vgUnTqrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hcBM7nK9; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRG0bT5CuYJ2Nem3HfOvDUciWbT9GZFoplyBkWHi32dcsHfT2Nw3vv1LbaFlT6dJ8SBtXEVA54wD11LKb/XsnQpcQzd7HkB6qNZL2gJ/SQ4DKXYIQJY5/lzEZ5F3HekZ+nk0jm0fNbo1eSHStMkBafVoY2adPrEAi5TSdmR6qXsbqbmmF7FlkWYk98pIC0Zjz8785TiBdRtM1Mjjq93Ehii9eCUtZLN7DXpHZWShIrhzYvOJ4BC5mUNS5056GoZ9ysnZoDpDsVdiooJS9Fj0tHhqePjSo2m9w5VdlMZHAbS5OXj/7bVG5/c5ADxTnqi9zPk44irO734zSwHpu5O7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciXcSznZRj3Kh66/q/ZfbAuLEV6gLsTlfv4/zzidyQI=;
 b=cU072L63v+6k/b3MYdmHDMhQm2V0GRzc7RB4vivyzIHBFE1FqKimy13wdb+1XIGmOJ7pBMWJtPPc+7QfPugcH6wZwR49PnZ2zoASlmZjYHspC5rA+71ewSQTyaCmvMaE2BNmiVxr/grGNqF8x1d+xJh3MQm2z8F6ZZuCn7OVobi9m96QxoPrDmZ8a9oPYdiNOEZlgiwXloTCIk5FRWR31AMhGoBCFkvgN22+IC6TXwn4LcNcyJCCLb4tb94qVn8TUpqA8WjIDpNhueSSYrSabmWuIgolllu8M/vV9L5zhI5QR2DMwbe+jVyOg7umCUKQPUqRQ3rT1etAj1hqnQPokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciXcSznZRj3Kh66/q/ZfbAuLEV6gLsTlfv4/zzidyQI=;
 b=hcBM7nK9JZZi+DUh1iFS/fGche+ikO3MwVYnKNyY7r6BbFgSC34O359QqVsT4PZ4U6B4UBhhAX8DO+433FDQEdYE0R0KEG6T2i7g2eFLlLkkUAT9GiHQzYVat5X1GkN3R6Z0FWewmnkS/B75ntquG1kB4jeoBERkJZQKmXWsK7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 11:54:25 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%7]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 11:54:25 +0000
Message-ID: <52fa4c81-9df5-458e-a07c-5d385e6d1631@amd.com>
Date: Mon, 11 Aug 2025 17:24:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] dt-bindings: misc: Move amd,sbrmi.yaml from hwmon
 to misc
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, linux@roeck-us.net,
 Anand.Umarji@amd.com,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
References: <20250728061033.1604169-1-akshay.gupta@amd.com>
 <20250728061033.1604169-3-akshay.gupta@amd.com>
 <a6103665-466b-421a-8181-5110354bafdf@kernel.org>
Content-Language: en-US
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <a6103665-466b-421a-8181-5110354bafdf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::11) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 7778cd53-1271-44c2-d29f-08ddd8cdd13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUtKcTRLdjJIdTQzNG92YkVMb0hEdVU5ZjVCVUhmVWhUcUpCaElrcFU3T2or?=
 =?utf-8?B?WE01ZnRHdlV2RTlSZWlNUnNPTWxCZ1VQK00yT0FIckI1MENBL0RwK2hlOWtt?=
 =?utf-8?B?aEV3NWhNbTFvMTdGUUJmWWovdk5Dc0R5Ny9lQXhyS253cmhIc3lSV0d6NUQw?=
 =?utf-8?B?eGtjQ1NFS3VMMW1HZ2hZRzdlR1VGQ052NEpIV0s1c0pmZE5BVkh3VmRWYlY1?=
 =?utf-8?B?M0Q2NXplV0UzMkFzRC96U0hCa1ZzcGQ3TXdMd1FyN3NWRnNQc2krZGpDbjVO?=
 =?utf-8?B?M2liNzJPZ3UxeFU2bC81YlFEclNIdE9OblZ1Q1dRd3BnU0daeGF4NEh6bmE3?=
 =?utf-8?B?elFRa0NDUHhHTE1Sd2dRTDZaZWlYQ3dhb1NnMTc2bnVKWDliMW1wc3E5dEhs?=
 =?utf-8?B?cjBIOVpJQzBaYWthN29wYWc5eG5CUDNvUWR1V3hWNWhQOWxmblVpZjF3YmxG?=
 =?utf-8?B?OXhNUnhWRWxjaVZ4blB3SnRSS09DZXRNMTRYbkxQNFpNVlJLbkQwdmJ3eDc4?=
 =?utf-8?B?OTNQc0JQbXVBOE1NTllzalA0RHRYWU90V3pKbi9ubUxjVUpFdHJQcGVPTHlW?=
 =?utf-8?B?YW4rYU9SS0MyVkFlV0RXNWc2d0pHTXFzdkVHTG9PMy94TXZNUFlwejI0c0g5?=
 =?utf-8?B?c250YVd2MWJ5bkVKOHVmOFp6SmdVbnc2ZVpUc2EvMlVMdlA3WWJlYVMyVmZB?=
 =?utf-8?B?bmlxVFBPRnJsM21saWtpWEpkQWZEN2dlVkhUajZkVm91WGlCaTdGbkJBT1F0?=
 =?utf-8?B?NHBWeCt6OHgrVXl4M29OcU5ldnNWdmZUVjdkaU9JeS93WWFKUldGdWc4b05t?=
 =?utf-8?B?bEJsMUVGemNTYzVNbnV3a3I1YzFGaW9weG04aURNUG1OK1ByTHYvQTZMMjZE?=
 =?utf-8?B?K0doZ2ZCbEdWc2NweXdocndqT3lxUUNqWGxXSnlPcFUwdXZmd3kzL2J3Y083?=
 =?utf-8?B?NEc0eVBEM1dRdEQ4VHRwMG5vN1hZdnp0TjdxeEZIZlMxb1d5UEpnWWFBSW8w?=
 =?utf-8?B?eWdGbUpOQ05xdXdxTU1CQUU4TzlVeUhXMTllSjhhTkh3SUlGOGJmUSsycy8v?=
 =?utf-8?B?elgxYXN4OEp0cUlxUHhzRjl6aHNPbnE3TytHQmcyQ2dsSXY4aVQ2amkvbWRh?=
 =?utf-8?B?ME95dUNKWTRGM2F2NjBub0JwdEE2c3NNN2lwaW9LMnR2UTBNK2RUSWgyS1FX?=
 =?utf-8?B?OUt5d1ZrWmpVRVZJK05hS041aTdFS3VmWlFURnFsNS9oUjVlUCtPYmpZVVEw?=
 =?utf-8?B?eHRCMmlpS2plT0pCdy9MTGRSZ0Q3a3Q2SU15RzZOeFhIUnhnaFZyTFRneTEy?=
 =?utf-8?B?MFg0My9rWFU0YjJPTTBOTTl6WDMvRm5COE5YWUxvSkhCUzM3cFNjVWZsdzNx?=
 =?utf-8?B?b0g0VEJ5ckZSU3RMWU5YbjRiM3ZYVk1sajJCOVlWcms4R1d4OHBzUVBXN3py?=
 =?utf-8?B?UHZpL2pyQlpuOGhteVlTUVoxUTJ4VjlmSktIaWMzb1ZDak55RVYyU21EMmFR?=
 =?utf-8?B?UGhxOVA3Q0hlTzdoT05KaXRDWjN0RlFRRjdHdXlZVWd4UjgxWjEwYUpXOXBU?=
 =?utf-8?B?MFU3TWpmUWRCSytMTjcwNFRmQ3FhbWpGRitaRm9Ua3lLNGUvT1ZWWVB3LzZw?=
 =?utf-8?B?RGxYQ1JHdnk1SnhRUFRRUVFYWUw4MzFJeEQ5bDBmRWxzK1U2TUxNSmZMMmg5?=
 =?utf-8?B?ejR1OTRZMURNK1VxU01zbXNyTkZaQzJHaDBCMTIvL0h0YzJvOTF2UEVKeHMz?=
 =?utf-8?B?ZEdBalloTVNVZjRqL0t0MGNLTkpRaWdJOFJ0d2ViUTlTOXR1dFVEb0RPTHlJ?=
 =?utf-8?B?VFZnK1VZejVmS3ZQWTZFZkFQUGg0cUhHNUhYSHcwbkNxWTF0RmIzQzRndWtj?=
 =?utf-8?B?RGhka3AzNVA4c1VxWVlONm9LRGRmeVRKRHcwVjhjb3pqSUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFJRQUJnMEZhbG5HUXJzVVR5NE1WczNhaC9ZNkl4SWErTndtTG5qM01OSHlt?=
 =?utf-8?B?enVnMzAzdUNtMVZrNW5zL1NsZ3NWaFJ4dENmVzIzQXJlTFF3NTlYNTA1cCtz?=
 =?utf-8?B?Ly9Mc2IrRWlKTVpoSkticSsxNEhwaDYvOVNZalEyOTBWNjZ0TE1xaXBNSVI5?=
 =?utf-8?B?VGNQQTI5WUxqYjZjTi8yYkxTR29MVlkyc05sMEs5b2Vyak05V1pRTkV5TUJ5?=
 =?utf-8?B?S3RhZUdSNDFYS2lUMVR6Q3J3Tmh2NkRBTU1nNVFkZ3BwUmF6QVZTQUV1OUE2?=
 =?utf-8?B?YkkyNmw1bERzblBVaDhMS3k4bmx2QUhkcUg2dmd2clJGc2NkOEx2SFUwWVJl?=
 =?utf-8?B?MUI1eE9ybGpaa09yOUpKbG1wdEVaWjFzc2k2TDhmZFM1MGV6N3JXQVlGaW4v?=
 =?utf-8?B?TjhwMWgxMy9NNDRDbVVERURaV1ovclZvVXFLSy91Q0xQUStJZFk1MTlHRnhq?=
 =?utf-8?B?RnNrNVozdTMzdzRWM2hKekdGS0V5alNsWW9rY1dDU3RwK09KUnFKSDNQd1cz?=
 =?utf-8?B?VFZ5eWIrZ2M0OCt2TnJVaFFrR1RTVi9CVkxsNTBHdGVZcnJobzgxZWRZd0hn?=
 =?utf-8?B?ZDFoQ2wrSVQ0dWZLQ2Nwd1hleUd1TGxZS011QnQ1K1ZKRTdYUmZYRnlCQmRm?=
 =?utf-8?B?aVUyR25tRE40R3RtMm1DN0VhZFV3ekgxc2RiWVo0eTgva0FKQkNhL0JmYUpO?=
 =?utf-8?B?bXNUYnVTZElua1pSNkk2anlYNE5HUTlDaUdLV3AxQmovYmREc1N1anBHUkli?=
 =?utf-8?B?cUpmanpHV2t4c2JzNVpac2xBUXptbkVRT1B5V2pPSm1rT3FySHplWG9VOWJr?=
 =?utf-8?B?R3JiWVlSaldwTWJDUXFrZktxb0xtZlpaZ2x3VVpNTmp3Q2ZXMWpEbjYrbVhN?=
 =?utf-8?B?V1FDZE1FbG91VVNXcGNYNHNIdnZGSzBrb3lhM0Q4KzNzcmpVNDBxckxSc0ZC?=
 =?utf-8?B?ZngwSkRORmRXWmRmYjROdXdNMjB4cXhWUjMyaGtCUmJyNXVJZE9mK0NGVlBM?=
 =?utf-8?B?MHZ2L1gxY0NGdytTRFN3c0g1bTVYUkMvZjE2V2o3Uk96Um45TkJyNm55S1NX?=
 =?utf-8?B?cHgvaWVqRXVDYTV4S21aQVNRODY4aFVtcW1LK2JYS1RGSFdrbTU5ZTMwYVlK?=
 =?utf-8?B?djV2bVdoZHlSWmd3RkJJUXdGalZRMzU3clp4V3h4cXZsbS9WSmdvSGxzWGdL?=
 =?utf-8?B?N2RvaU5IOVhHYVJITnBlYitiSHBFK0tHbzB4bGF4Ull4NjVta2VnL01qMnc1?=
 =?utf-8?B?TzBwUW56czBYbHdDK1hMeURkeklvc1dweEsvb01nd3psN1ZVUExFVnU5cTUr?=
 =?utf-8?B?VG9GQWlHd2dneXVrU2Y5NUZ1Q25NTmtNMy9QQVhwaW02YTl5WGJOTTltQk9j?=
 =?utf-8?B?NVAwUU1CNjQ1MjQxaEt5ZDZxekpDMC9rc0Rid3FEc01zLzRTc1JKT1NSM0NN?=
 =?utf-8?B?Uk15Q1FGRCs2SDdyZzdTMjV3L2hoTXNlVW5hUWRTSDRsOWxMM1FaTXErMDlU?=
 =?utf-8?B?UExhZkFqQzBpb1lkdFd2SmdjbElNajZZYVBEUEJZc0FxUmltdmthalZ1enV4?=
 =?utf-8?B?VWlyVnVKK0dQK0JtejlScU9iWnpocmZrM3NBMy9mUTRyM3dvQ3NuSStacUVN?=
 =?utf-8?B?WGd2OGxIK2dFSExUaloyZ2pkYmZMVC9Yd1pMUWZxVHVKK0lpMzNNbEhCK1JI?=
 =?utf-8?B?RmZoWWNtUE5jOUxJdjJqUXlRSUhIVTdxZFdLSmdnN2NYRk9hTkNqWS9TWTNl?=
 =?utf-8?B?cHdhUzIyL1lXQ0RiYm5sVTRFSkQ1N1QxSTN5WFNJMHJmaWtDY0xVbWZNS3Zt?=
 =?utf-8?B?QW1ZNGNKd2VpbXlLYUYxdXEwdnJYNnZPMUdEcWx5YWhTUHVrbGE3dDJuV0pQ?=
 =?utf-8?B?RmVHRXVZUkYxYlNzK0VmNXVuZjVuckNvTXpmN1AzS0JiRHhJT2NWUVE0WmYr?=
 =?utf-8?B?TFdkUHR3OHB1dGh3OG4yOTVEWUpiUWh3N0JWSzc1L3ZVM0ZoeVNYbXplK0ls?=
 =?utf-8?B?bkRwd3dPSTM1aTRzVk9pUHRnVjVBZjlGL0RHWnpiRzZQYlRoRm9SMStINU15?=
 =?utf-8?B?RzJJSFd4a2pGZDMvYnZtNGN1ZkthRjBuamJySXpxSm1vUDF2b28yRWNLR0dZ?=
 =?utf-8?Q?9iSFwMWRWqRizCQvGIA3mF6lF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7778cd53-1271-44c2-d29f-08ddd8cdd13a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 11:54:24.9854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJeWLiWth3Pv3rvtYHJawO6xikuO8inqSyawjRy1UuN2zkRqcPWmteqdbceGodRRs+MUwRhANcY5tc7CPRaxhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934


On 7/29/2025 11:59 AM, Krzysztof Kozlowski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On 28/07/2025 08:10, Akshay Gupta wrote:
>> - AMD SB-RMI patches are moved from drivers/hwmon to
>>    drivers/misc to support additional functionality.
>>    Move the related bindings documentation files to misc.
>>
>> Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> Really? What was reviewed here exactly? Poor style of commit msg or that
> rename actually does rename?
>
>> Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
>> ---
>>   Documentation/devicetree/bindings/{hwmon => misc}/amd,sbrmi.yaml | 0
> We don't put bindings into MISC.

We moved the SB-RMI driver from hwmon to misc, and hence moved the 
binding documentation.

Referred the newly added yaml file, ti,fpc202.yaml through commit in the 
misc bindings.

If Documentation/devicetree/bindings/misc is not right path, can you 
please suggest the correct path for bindings for drivers in misc?

thank you.

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
>
>
>
> Best regards,
> Krzysztof
Sorry, will take care of this.

