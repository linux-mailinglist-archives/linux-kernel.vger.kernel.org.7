Return-Path: <linux-kernel+bounces-757104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B7EB1BDBE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9486262F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9441E4AE;
	Wed,  6 Aug 2025 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="eyHhcPJ0"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2123.outbound.protection.outlook.com [40.107.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D1D17597
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754439010; cv=fail; b=Hl8AWuGVgxAT1ZNo+GX6mN1n97hCD6gl+yJ/cLmZ7fuGJQpBfK0ecdag1YQ9euuXRLAup5iQ1nX4AvFm12Nd4Dak9dhNLYnAGpxQ8v805xJrSmfB4G3czKfrqcr3CsXvd2E/PCWCCcASxWSyeusN0OFOaqQBwjsfVF2t7oGaXGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754439010; c=relaxed/simple;
	bh=y9RnfO5RrbJBmoVcCI0TfqMEx79lAQgmYjJbMn4DMGY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s+5hTSRhxf0L0KXrJId0YLKg8TsC5nDOp/fI5VmKSsTIhcpC0k70lJEcqN847AAibAXiZpQT6mTzh6nVEqA0/vTJciAePkAWNBGV0ZTo/iuZiIi3NDZYzmY3D8B0pgvAySgRKBIuoc0MENHTtuAgDqzw2I4vZFZ1XYBS9iu6F1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=eyHhcPJ0; arc=fail smtp.client-ip=40.107.223.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giiJKdyh394/UlXzxRY6oazRNlH67ZV4N3MQ0x9Y8+Xlegchkcw2BiIwc2gQ62paD6/LAmnsWky4RKBDz1YpR1SOQt4woZDxGYvODd7RkhCSPfuEx6EhoHMETpFT7Xgr1H9HIYxuNomD0GUhX6Gu3Mjk/2aXbgoQGCayvzrLxh9bci/mXY8ALzsvYRlPpuTwc4VVlM2u/HT9iiLP8Ra5bbt4Qw6HpF1ZOvLRzSsvNJFWq0m4KQXshhzea0F82r2JGzuzTD1r9pyZNPuZFwcS8PuGcWCwPiimJNumcxSZ1U1cFsNWEf7yspv3GzP8j8eUqRQPSh6JzLiXz29zABBz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yr1ueE33JqE26w+PGMk64vAUvV0H6HytF6WXJpr3hZA=;
 b=u4tUXY/GqWYYe6N+1XUuo4amjRzSzxkm/UfAUzWvYhEhwydI2XJYUWs9gefGF3GeJI2CVQ5Em5rPa6Nju0pg7lwM6ELEabGC7DMO+6QJrikKdf4x0FE7IiXBvwAs1TpUnp7c3gdHSUWuXwXsmSsveRAccX+l8bbkPRrUyO3+PWZjL2s1ZYD80ESomwNtCvGfd4pafS8cOl5AASIGOeOcHnnqTLNv70fv9/VrklGha+rgxm8TV1o7M7aI11uOjV2rM1ojXz1CBUCZi49JHay1jQSVyKNPGbmfKHvzU1ZZZuSnhwgW96GoxIaoZmJ0KxemZkeXylUQizly/oxWysobww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yr1ueE33JqE26w+PGMk64vAUvV0H6HytF6WXJpr3hZA=;
 b=eyHhcPJ0U9C113y7ppfVV3oisR//SFhAhNJ74EsGneKyQPs3bwl4ano8/ZKd9fiVPIpeMXc1zP/lNrJvdIS6CC6sZUcTCY1GqzLd31vJfAqkpf7ebhvgLQ1T+ZfgWHYDjiKIlEVjv8JW6RNKXbo2zeTSaFvnOWzBasgomMjAU3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6404.prod.exchangelabs.com (2603:10b6:303:72::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.21; Wed, 6 Aug 2025 00:10:05 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 00:10:05 +0000
Message-ID: <c23f7ecf-78f6-4ec8-8f00-b92e98fa95a3@os.amperecomputing.com>
Date: Tue, 5 Aug 2025 17:10:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: mm: support large block mapping when
 rodata=full
From: Yang Shi <yang@os.amperecomputing.com>
To: Dev Jain <dev.jain@arm.com>, ryan.roberts@arm.com, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250724221216.1998696-1-yang@os.amperecomputing.com>
 <20250724221216.1998696-4-yang@os.amperecomputing.com>
 <d9960dbc-376d-4d33-9334-e4eb546b69ae@arm.com>
 <da766ad7-143b-4c7c-b296-f18df8380643@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <da766ad7-143b-4c7c-b296-f18df8380643@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0154.namprd15.prod.outlook.com
 (2603:10b6:930:67::21) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: f9dcc1cb-9417-4912-d63e-08ddd47d983c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnNkZ0x3L29oTEovT0Z2SThyWHpTMGgxTDM1TXd4cExKZFdJWjVubjFOdVY4?=
 =?utf-8?B?Q3FGdmtIZzJyWXo0UGYwZlQzOFBJQS94LzdGcDdSWkdzZmNFRlU1UGdJV2VI?=
 =?utf-8?B?dm8xN0JBaDFObDR5cjlOSm01TDFnQVJmQUQwMXBkSFhpbmlFYlNyV0ZSRmQ5?=
 =?utf-8?B?RmJTcnNUL3RxdUZwUVVSeThma1lXNExlMkt5a2czNlM0d1V4WWk2STRjcmw0?=
 =?utf-8?B?eUF1Z2FseWZOdVJoNHMwZ3V0T0NFSm5YWkgyd1A5MWpjMTdtZGh1ZWJwRTdh?=
 =?utf-8?B?UFVXa2J1SEtPekF2aVNsMlBXemhkamlrTlVwQTZJVnRZYXhqZjRCeUdXeFhE?=
 =?utf-8?B?UGhDc21iaVh6Q21uWmhRa0Q4UlRwNDFkVE9RSlJwLzhFZW1vOWxKSThkSjkr?=
 =?utf-8?B?ZzdEWmJ5YU16dlhSZUYxUmhmdEZKeERFUVo0Y004clBVODlZSk1KcFVlNTNt?=
 =?utf-8?B?Sk1tWmh1UDAyZ2hnY3NIUDJma0xyZFllSzBmTDZxWUM1YTRjTW1PM0toM3Nx?=
 =?utf-8?B?M0dWSS81RFJPSU5wRDRwUk4xazBiZEhFV2lpU1VObnV5dk9LaWRyYWthTyt2?=
 =?utf-8?B?dnVvZ1JhbEhNZW9RR2VGYk9hWm43R3lDMVJoT1U5MjlWWklpdXNnUlplVTZQ?=
 =?utf-8?B?eExGcFZycE1IS3lsdExIOGRpQ0VBck9UWnBoRzdkQ00zaFE4M29Gcks1SVZy?=
 =?utf-8?B?Wi95TXlmaGNTSE5lTnNzaTIrVkx4VXdieTZsOU9GM0l5VzQ0dUc2bjQvQVJI?=
 =?utf-8?B?WThGT1AxejFuSVFKMG1zbW0vZVpHcVd0V3p6cGdmQjRVYUprK2FBMVhOSURI?=
 =?utf-8?B?S25Dbm5zQmpUV3NRN0I0amRMaDVpZWI4ZzgwT1QyMEdFUk1VY0xUMThqSzhy?=
 =?utf-8?B?VDZHa05qbm85aXFESGR3ZzNJOHVQQ3FsR3RLeHM1TGw3a1laWUhNZStXc1h6?=
 =?utf-8?B?dGdCT1RPVlY4Y0pNQjRRL2p3VmU5Z1JLWGZIUFBUQ0d0dmV0NmN2U1dLTDNB?=
 =?utf-8?B?OU9Ca3ZPL2puL3g1S2xYWFBudiswVmEzU2RzUi9qQTJOMWd1MEYwZXpGWkNs?=
 =?utf-8?B?aDl6dlFEMXlsT0hoVENNYmtsUFNSbXJyai9sQnpKeis2d0JXM2hBYlBBOUVw?=
 =?utf-8?B?eFUwMmhDRUxpejVXUWdyVVFKNTNxNVk3R2cwVUVOVU1QVVhMdjdVbkhiMDly?=
 =?utf-8?B?aC8wbmVVVE5wVkNSWjdzV0QzTVFFYmhRc3JvNm9ZUWwxWTJOTTVSSFhlN3Fr?=
 =?utf-8?B?cTd1NTUyMWNxLzFCRVpNcHBFM2RPZ24zT1dPSVdoRU9SZkVDSHpReElvYlN3?=
 =?utf-8?B?cjNxVkRLd3dWQ0x1YmhyenZEK2tJYWpWd3dRUjk1NGlaMVNFa1F1aHU0alU2?=
 =?utf-8?B?UEd1QTNlTWdNeVFXZVlUZFFhSGlaWSs5U0RKSDJwVngwNEwrTFlMZDJiRFQ4?=
 =?utf-8?B?M0xMKzc5ZVdUUjNSeXJ4MXlEV2grL21kSUNWNE4rSmUxY2R0YVNEb1RqQUds?=
 =?utf-8?B?bU5rVmhzazZjc0hwNFBOeHRidGhNN1JLQ3F3UHVKVGhqYXNyOGtwL1NVdHMw?=
 =?utf-8?B?VW5CSmtCN3hmRW4vUG5QRTZoNVp0dXozN2V3eXNGMXFVZVVpbGFaME9ENEpG?=
 =?utf-8?B?SVNKdE1oOU5YdEZQNGRBejJmNjdFTG5RUXZFckZQQk9iUHNpWTdIL2IwRy9U?=
 =?utf-8?B?WG5ZWWVjTmx6Qmxmc3ZyY2puZ25CMVpqRXNZR1E4K3QrQUszcGtVajlQYllI?=
 =?utf-8?B?V2JYRGJlOXFWUWJYSVBLcHNVNXo2bXdrdUsxdW5vbXdrVk50YlpKbTdHeHd1?=
 =?utf-8?B?Y1VvaHp4SkF4SnBrTHU1Vk9wM1FxUGtGVDFIcHhYZjZ1ZDVmZm5ScmJ2NzMv?=
 =?utf-8?B?QUIwRGRQVkJFQytDUUtkREQ1Y000dEMvT2ZLS3I1OWdjRkVmNjYrSmZhbEVl?=
 =?utf-8?Q?DIr5VpIUf44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlQ5SWFHQ1JSRENQLzY2ZVpqSXFzQTVBUW5zd3BsejZmSFFVWGhURUJlUTM3?=
 =?utf-8?B?Z0h3OUdjRnQ4aktpNHh5T0w5UG03WnlJNzlOS2ZhdnA2dHppYnB0TGZSTUtm?=
 =?utf-8?B?Z2ZzMllta3F3bHltTWk0SGlwcFZ6Z2ozUSt2bUVlY3AvMklTb0RmL1YveEQ0?=
 =?utf-8?B?L0wzeG9CU0lnWkRuL3BWaUlpZ24zUlpoa1F3UVRnRTMyZnk5YXJiY3pjdXAz?=
 =?utf-8?B?WUNBNnNBaUFyd0h1TzdDQWo3bHJTOFRnN0psUC9QVTJibmRxQ1I1VXhwZkNS?=
 =?utf-8?B?dEhJRTRWcUUvQm96UEd4eWdXem9FcUoreTF1VC91cDVndS80amNBUWNPY0VK?=
 =?utf-8?B?ZHhBVE1VTlM4Rk1NN2dPUUkvcTBrTWZxNldnTU5nZmNiVEhkY2IvMHRXSXhX?=
 =?utf-8?B?SlZTTUNhcmpDMHRjK1dpczdPRkhMQnUxWVM4Q1JSZEpTZWNvUHJKdjJzbWl5?=
 =?utf-8?B?Y2I0V2ZsRzd2bjYzR1V6T2xNcmwyU3Y3bWFncFFlWHY3SkpCSm9MM3dGaGdy?=
 =?utf-8?B?cU8ydXRzbkJVRitYREgxZTRQYTVFRys5VDJWeTdpWEFWdjQ2VnFwcFVyTjI5?=
 =?utf-8?B?QVVnVXdlMlNmc2hWek1VdWdvUjlVU0hqdG5MNk5SclN0Y1ZzYkhXc2t1ck5Z?=
 =?utf-8?B?RlJ2N2FlQjg4Z0IvUksvQldob0NQZXBRTHFUOUJrU1FTWHNjcklhcVFSa1Q3?=
 =?utf-8?B?UTVTdUhmOWhkOCtsMmxIUFg5dHVvYTg1YjdoZUYrV3dkQUNFNEM1WmZwc2x4?=
 =?utf-8?B?aWRVNTJERnVaOGdpVm5kUkI3N0lKTG9DaW5aSkREK1hrOGptWm1HUjRrVThC?=
 =?utf-8?B?QnJDY1F2UTJhektvVWZNbWxybzVBd1R4d0xFdzZzdzdqUUZzSjBnL3pTZWVK?=
 =?utf-8?B?V3BNVWJJcGlxd0gweGtXVjRMMmo4WHVrT3RwelZkaFlScGFpU0pSaXplZmNE?=
 =?utf-8?B?TitET0VJdklLOTNKdTVjSG45QjhkdFFWNmpIVk1kck80VFAwZHJiZTYzT291?=
 =?utf-8?B?V2N2OWxSMDQvWUNsOG5LMEVab25MdmMwM2FNMVMxWkx3VEhDWnI0bmRNZFVN?=
 =?utf-8?B?Z21MZUNwTHFMc2paMmt3bzNXVnQvNTR0ZEVXRmVrMGkwOUJjSStOdlU2NWZN?=
 =?utf-8?B?cktjZ1VoNWVYN2FvODJobjEzVGtDV3ZLOTA4NEVZajlzYWxBV1lSODQva0My?=
 =?utf-8?B?dU1rUVA0TDRXODN5alhNUG1FQXd5TFc3b3NBQ0ZkbUxrMnVkQVFkVDBQeFJK?=
 =?utf-8?B?enVCV0crRENHUmdFczh1UkFGL3VIcEpJS1RLYmpaTTBtTDNrdVBpZWRKNzM4?=
 =?utf-8?B?QUo4Y0daYzAzbzhlbnFvL2Eyb0J2ako1WTl3ZjJ0bkNvVm90bEhlUU9tUHpV?=
 =?utf-8?B?YVNpaVZtZkdTRytLZVRkKzd6USsramlkeFMyQmM3RHlYYWZZcjdtdXRVclJN?=
 =?utf-8?B?dGdFeVpWOGJLY1N0V0hWMEoxS3NhVjlhNWtJU1BpRyt1T0tERldTd3ozaGt2?=
 =?utf-8?B?blIrMU1Rck85U0hacGQzRUZKa0F1NVBoYm15OHh4NU5CRGRHenJtc2FQZ1Zq?=
 =?utf-8?B?ekdXRU55aXJFbWN5elJZVFdlRzBGQ0paOUxZUnhkMGlRS2o4Y1puM3E4Y1py?=
 =?utf-8?B?d0tKam42NVVIUXg4OS9LUllVU1ppSDh0N0owY2pxZm1GN1B5dmVXeGtReWRa?=
 =?utf-8?B?TmZORE10YlB1bUpCL3NsQWZwVWNGMy83WDhhOU02YmlKd3U1NDBOb2F4LzNV?=
 =?utf-8?B?MUZHUmdzOEhpYTdZQW5BcVhpdXdNdnhkTzhpbkl3b1MwUlJJNWxrVGIrR3lY?=
 =?utf-8?B?UURQK2hZdHRnTyt4SWc0MGdyaHlQdWowdHFIN040cUlCMCsxblhQcDdrZEl4?=
 =?utf-8?B?b2p1ak1UYU1FdGI3K3RpMlU0TDJYS2dSc095RE4vdnVRdDAydGZRUnRCbXFv?=
 =?utf-8?B?Y0pxNXdXbUNqUEEydFU4T1VkYkZsbW56UWFjaUZ1YkF4OUwzUnMwdmIraS9N?=
 =?utf-8?B?K0lyaGM5VS9GT0VLUmtOUTlkZE1EN2FIdDU4aUkvdTlHVzh3VUJxT1BkNmEz?=
 =?utf-8?B?a3MrQzQ2WmQyTGxZMGplZjFuTmluaUxpKzVSNHZ5UVdxZ0hsbk9UbkhNUFRY?=
 =?utf-8?B?SWZqSk9aUmdFSjAxWFBJdUNhbUh4cS9oWjM2RW9DRjVUbERUYzk4dFEyS3p3?=
 =?utf-8?Q?BP7lUPFWmT92APk6ddYqYz4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dcc1cb-9417-4912-d63e-08ddd47d983c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 00:10:05.5029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FbwUDm/f61OCCJXtD6KsEFf437Q3ImIjAbreLVl9i77obGNdctCBucT4V73HdzXJa89t+NpWbF83YfgDCsRSFUU4lczMWlXuD8Vopo1vww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6404

>>
>> --- snip ---
>>
>> I'm afraid I'll have to agree with Ryan :) Looking at the signature 
>> of split_kernel_pgtable_mapping,
>> one would expect that this function splits all block mappings in this 
>> region. But that is just a
>> nit; it does not seem right to me that we are iterating over the 
>> entire space when we know *exactly* where
>> we have to make the split, just to save on pgd/p4d/pud loads - the 
>> effect of which is probably cancelled
>> out by unnecessary iterations your approach takes to skip the 
>> intermediate blocks.
>
> The implementation is aimed to reuse the split code for repainting. We 
> have to split all leaf mappings down to PTEs for repainting.
>
> Now Ryan suggested use pgtable walk API for repainting, it made the 
> duplicate code problem gone. We had some discussion in the other series.
>
>>
>> If we are concerned that most change_memory_common() operations are 
>> for a single page, then
>> we can do something like:
>>
>> unsigned long size = end - start;
>> bool end_split, start_split = false;
>>
>> if (start not aligned to block mapping)
>>     start_split = split(start);
>>
>> /*
>>  * split the end only if the start wasn't split, or
>>  * if it cannot be guaranteed that start and end lie
>>  * on the same contig block
>>  */
>> if (!start_split || (size > CONT_PTE_SIZE))
>>     end_split = split(end);
>
> Thanks for the suggestion. It works for some cases, but I don't think 
> it can work if the range is cross page table IIUC. For example, start 
> is in a PMD, but end is in another PMD.

I think we have to call split_mapping(end) if size is greater than page 
size, i.e.

split_mapping(start);
if (size > PAGE_SIZE)
     split_mapping(end);

This can avoid walking page table twice for page size range, which 
should be the most case in the current kernel.

Thanks,
Yang

>
> Regards,
> Yang
>
>>
>>
>>
>


