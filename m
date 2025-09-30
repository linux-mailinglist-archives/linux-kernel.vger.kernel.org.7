Return-Path: <linux-kernel+bounces-837040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7BEBAB249
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3B4189E5B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B2720B21E;
	Tue, 30 Sep 2025 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="JI3J00vN"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023110.outbound.protection.outlook.com [52.101.127.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49923506A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759202313; cv=fail; b=ZeYETD9rEZowV9zKhwSn9a1HGbcLU3laK68XyhdmnsY+VkHg6Gg0+hTr3sh2voHtrsTys9J9fait/toiNDKjSS+nwUIYuzjQHrjLeiY+YnKLIhUkD/xku1ZYXwiqFJiccTUt2ZKPfgN6vdEyIVMBz5B6rjITv7VhBoDPHuXgAgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759202313; c=relaxed/simple;
	bh=8/4o3KTDoMhLbWMZTWQ9YSmZRLI/eXH1zm+WQ53SOWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=toSuj0qAm8hBEqUNs2A5eq2irXAMvBvsJYI/hz3ZbuZewJHcIgODdQaWvJBDTUXs1Jykqo6qb7txL076Z+nFk8osqkjpA5P9kykpnxIM0iC8XaJtTFNx5MWGQcoPJ4FNcYOlhd5RwUIcu6DiJxW217yGSN4NAl14L5jwMdnWORs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=JI3J00vN; arc=fail smtp.client-ip=52.101.127.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B78/l91mfaufiQzJJ6qROnONBTuQsXdkhnAS5gbbPGn3IcGieTJuTqck76pVWH+eD+Qz4Oo1ZwCfG9yoCcw9hFS56YEk103daj5scaOHGY+J4zX+tQgBmMnB3YyMt8n1JOBvFi/eh7KJ/Lz7sBIHbT9HCnpzo5op4X5hsVKCZRpyrn3VhDUqcUYP3DPoAP9V9qf3yRvbWNP7jAorFRfkCqiM3xmybyqy0DfKE0HkoyPyIC4fjmPxTBc9S4MZMqUek/w78luLzvTtMvLi6gSG7rMp06gwKgV94bTL0+SISZHScEJigrrmNohqnNsc2FaMb5Fq/Rx/9LcCC6S4QSLLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6O3IPkRr5n4fvqdoNNDHU8mYuz9HrjEFCCEDENz3rM=;
 b=onpTwTLcmmNpvjaJ2jXSs5wbtRGQPuc8oWRETnxuSN8JEjOXC4vXz5e4IqRs0CZDZnK7Y5H6AhGUWy3sZr0nP5L6SKHVr4HR3PjOqmd8op4Er4YkbKMNMHNLNhiuXvosYmlMHHuiqA180JrwnYJJcAa5nog7EkONt3dc9PAuFuAQFeJ44YAoHV05/w5jcFFiOteav4cPG3qrCLggHktOoR5cH/WgQheCgs9oItqM3BYzU0ipXdoNYv8Ak5mteAwF+v8ZYrHQr87VQFfd+HZsv4rzrge3t6xVWHOq5aumLP8NML+5oZnvl56+VARSVJL3MQPY+hyNtrDVPnHsGumkig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6O3IPkRr5n4fvqdoNNDHU8mYuz9HrjEFCCEDENz3rM=;
 b=JI3J00vNJtG4DJua6KRJAoMIWHG6xeulnypF33OJHxT3+pcMGpKv0lvX1qAq7BDWO2nh4TzQLa4Wf9yf9+3ZFAIXgncoae9FOqcmmpuIbVnMX3SKueu2423eQZa04wUPlqU4Jx+dNgM8vY0lBNjZy0LU0TYpMJZlt3igmbMbaJnmV9QpHdEQTbAhFnc5bx2ZIC5RqutCCLi0W8HnbGd2bD2NJV27Ceir88VFg7MpU4HNf9keT2CXTM/tKgwpw0CWuq/TOxFTUThtgrNyXkdYhoi9dn7Mh1L2SXXVCcZ6HYV4q7DPLoj6pZssgnmxZKUrs7UU+tLgKlRb6g+FN8rBTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com (2603:1096:400:354::5)
 by TYSPR03MB7307.apcprd03.prod.outlook.com (2603:1096:400:42e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Tue, 30 Sep
 2025 03:18:28 +0000
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::1939:7c2b:9e87:2c38]) by TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::1939:7c2b:9e87:2c38%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 03:18:28 +0000
Message-ID: <f64a9a4c-a90f-4d30-bca2-9d9bc7724121@amlogic.com>
Date: Tue, 30 Sep 2025 11:17:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: Use mapping->gfp_mask to get file cache for writing
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 tuan.zhang@amlogic.com, jianxin.pan@amlogic.com
References: <20250918-origin-dev-v1-1-8d9877df9e77@amlogic.com>
 <d6609f12-78c2-4a42-b4fd-689b310ec615@kernel.org>
Content-Language: en-US
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <d6609f12-78c2-4a42-b4fd-689b310ec615@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To TYUPR03MB7232.apcprd03.prod.outlook.com
 (2603:1096:400:354::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYUPR03MB7232:EE_|TYSPR03MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: f903c6f5-de64-491d-e216-08ddffd0066b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUlMY29zSkU5a2NXMjd2RC9rUFlVVjZQclN2WlphWmhaeUM4MWNkOEs1RlVv?=
 =?utf-8?B?WVc5ZkpieFNFZDhWSjBMeFNzSithaExrMzU1T3I1VVVZVWlVZ083azNVamRj?=
 =?utf-8?B?ZVAwM2xGQUMzdGFlTDhGYjV0MG9PVm1PekxQWWJvdS9TRHV6MnBTenlMdlY5?=
 =?utf-8?B?VUcxSmxnK0trNHpESGNLejJuL0pxQkFXeWMwRWp5U1hvWXY0V1JOUXJyN1FO?=
 =?utf-8?B?c2hZSnFvUEZDZEJhdkJwSmVKTHhWVEdxMGJKRGI0UW1KclJqWFowOElzMUl1?=
 =?utf-8?B?dFk2bWZ0TVY5MzBaTFlDRHFDMlBaTmJmK3krUWxmR09nQ2hkRExuempWdUwv?=
 =?utf-8?B?bGxibG81N0lRWi9lTGRTdjdTbEYrVzQ2cUcySzBJOFI2L0dYZTYwOUNWdWha?=
 =?utf-8?B?U25pbTcvTFh6VHJwdVRqbExrckY0OEt6Q0xTY2FYdUdMUHBqeXVPMVBYMHNr?=
 =?utf-8?B?VS9TeEQ0QmY2eWdTS2NWQVBsVTRUY0kyWFJGRnlrZDdrTGl5czcrSHo0eUZE?=
 =?utf-8?B?eG95UVFBeXFVVEUyMFZKd1U3N3REZnJiRmRaOVFGajBBMEwzQklHSEZTRkhk?=
 =?utf-8?B?NEVVTk9oeG9OVEw5RjJ3S0NKVndBcDJrS3BnU2drTFJzbTByNlVQZUVPYnRG?=
 =?utf-8?B?QjlybGZlRUpXYUVITmxndVNuVWt1MmpBVkZ0U0VqOWhnQVR3blRhcjJHMm5Y?=
 =?utf-8?B?aDd3U3VrUWU1SVFaUGFSL2hYdGRUa3VRaVBCREFtN1BCazB1WDFpVmZzTUR6?=
 =?utf-8?B?bEZVZmNISXFScnZOZlVYM3ZzNXNMS0NSK24yZjhTYkpRaUJTLzM4eGQxRk1K?=
 =?utf-8?B?THJvU2FqK1NheTRkZW4yMDdkRW0rY1h1UGpEek5qbGFQN2JQcC8zMXdVWDBF?=
 =?utf-8?B?ZDloendIMStwMjYrdGlpQ3lGU0VUSEluQXBlblR6dkJyTFJkZVA1T0dCQUpm?=
 =?utf-8?B?ZnlDMGtTY2tRdjRSTVhjNFJ6UzZIaVNoMzVIVkRhQXhHY2tQbFI4M1FCUklm?=
 =?utf-8?B?WlN1SDYyZ2FTeVloV3lBOEh2dmQ4cmQ1ZlJlN01ldlhXbmpPckprcmx3MXph?=
 =?utf-8?B?ZjlIMTBMUWlnV3hiNVpBK1IxQlNTc2VMY3NSYnhyTjlUTzNDVnZwdndXcWgw?=
 =?utf-8?B?bEgvbmpXMXpwc1lDaHhiem9Lbitqa3BOQjViYWZFR1IzckFsa2k0VTZMMVcz?=
 =?utf-8?B?bU9haXZHRnlVZ3JWeDVzUnlmQlFqK1ZpZlZhRjRFT2hPNzdYbC9rOWpTeXJN?=
 =?utf-8?B?OG4yNmRWU1pMckhsckZpREZDWVBKYUtJdmFmTFFqM1AvNWN6aVl4clNsVTJi?=
 =?utf-8?B?S3FZanBZTTRtUy9BTzhadURDZU9qN0J0S2JSZkNMZU50VmdXbGw4OGxrOWI3?=
 =?utf-8?B?UmlOK2dzMzBMSzF5b0VrbUZkWTdIQTdqd1NuZDNsM0NLQnNpdkl1QmtXZ25J?=
 =?utf-8?B?TldiQStCZ3NDaTY5bGdxT1FmNWloOWVLZFExVTNoTUsxdDNlQVZ3NWdZTVQ0?=
 =?utf-8?B?YUNqanVZRDQ2UHBsaHVWTnZPNFc3SGp3WSsvYnBoczV2UDRnTWFrS1FYUjRq?=
 =?utf-8?B?ZVVEVCtYUlY2NmIvRDFFRTRubnhza0hTUFhIbjdpczlQOUJXYm5RdGh2UTBm?=
 =?utf-8?B?K0ZhUHV0emp4SkRHdFRoNzQ2SjhpWG9iNVNlQ1l2K0w2YzhyYlpVREU3V0di?=
 =?utf-8?B?K0tVcGx6KzRlMi9FRzRHOFZhQTF6Nk9LY1JRNUFueXZIUzFwS3dkc3ptcjg1?=
 =?utf-8?B?TnZwWG9ua1BqK2hBeDFMYXV6Y21VY3pYdTdWQ0wxdW9wZStORk56MGl0Z2Qw?=
 =?utf-8?B?alp0Q2F1NnJSaXRpWEhQcTNNaFVTajRTVEk3elBCSGRzVllPaGM4aWRHaXlr?=
 =?utf-8?B?MHh2ZmRWUytWdG4xZGs5czQ4cnB1ZUg2UnM0cGpFcTMzWk11QnJDYzVzTUZJ?=
 =?utf-8?Q?NYDB+0OYpKDSXov6Se8p99eQSNIEjunX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR03MB7232.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzdSVVNYTUoyZ1kwOXlWNmR6cHJ0NHdWNzNmbGcrbld2OS9aMFBCQjFMbEx5?=
 =?utf-8?B?djR3STRZQzVVVlZHSDJYV0FKRlZ2bEh1MGxVdEY3bFRmMjdNSVg3NTdSWjVP?=
 =?utf-8?B?Y0JocTlDOFpxWWcxYUEwTnZ6TkU2eWRwMW1yMEx1QTlxREVGbEN2SzJReU80?=
 =?utf-8?B?bGhSaWRsTzNxSUxpRDQ3ZDl1SlYrZlhSbTU0ci80VzV2NmJxdTFodFB0WDdz?=
 =?utf-8?B?OUhYUFNUTmhCS2FVRENaTVlRNlBwUU0waDk0ZDBnTmx4T2wrOEZUdVhUb09S?=
 =?utf-8?B?MEFROVQ3NmZSNmRDMk9BNTV0eFQ1L0JtRGtrMWh0STZYbWppMmxaczU4NDNT?=
 =?utf-8?B?VGlUeU42NlNwQmF5dzJwMFVLNDNqTmQ4UC9GQWJ5VjNFcVM2VFNQOW1sSGVs?=
 =?utf-8?B?MTdUTEt1bHlLeTZ2bWVkVFdzVDVMQUdqWE1GeXNIMDUwVTVFbnhUbCtpZlJj?=
 =?utf-8?B?Vy85eVJzYzRGYUl0bW5UK0xoTlErMjRmSDNUSlRiMmxNRTJ3RUsyZ0pMMHpl?=
 =?utf-8?B?ZnArUUJ2eTdHaEhmNG5OWTVsWVZFY0c0VDEvRDEwM01hZ3pKYXY5THcxbTZU?=
 =?utf-8?B?K1dRSzVwNG9UcVNqc0s3VnJxNVVnbzVYcXNNZi9INnphSHdTZDFLMnJoRTcy?=
 =?utf-8?B?aU9UcWY2T01URHhXbkxPUkpqc1FCN0JLU1pOVi8zcEVxcHljY1N5aE5qOXk1?=
 =?utf-8?B?YTNmRlNIbHc2OC9Fa2h6ZXJDTnBaTithNkJYSC82d1ROaXdQOGVseWRkWFpM?=
 =?utf-8?B?OE9yMEhEd3V0U1A3MlZheHF5V3dWdUNIeXhjZlNNaTZWTVhQcnB4a21jVHRm?=
 =?utf-8?B?NXByNUFMV2dySnpqZTM2KzRaV1ZoMHNWTmNlZXNIdWhsMTdJWVY1QzJrNlVl?=
 =?utf-8?B?UFRlemNBTzRVdlhGd2RHNlRSdzlFN09wN1gvc0Q2aTlDZlJxL1JyMFNpaHo5?=
 =?utf-8?B?SmV2T2tuY0tPRE1Rd3A3TVhyWlk2ZHJRNmZMcllEM040WTAxRlpmUTVXd3Jv?=
 =?utf-8?B?OFoxZlpoVEcvWmErUlhwRy9aVUc0eHJaeHFWTG16bEo1Ykl2QTFDK3RldnJV?=
 =?utf-8?B?REkvRFF3NXV3R21aVUJkUGgyOERxOEdFZzN5SEZCRjNzekpwZXcxWm9VRTJz?=
 =?utf-8?B?RlhRY09ZZ2RpRTZvVm1uRmk2d2hCa3ZsdWVKM3EvVkZuR1hXNGtsbDl0bU9W?=
 =?utf-8?B?THZTZDIwQ0dWV3p5bG82RnlTWFJLcjZ5eVhkVWRhTzUyWEYxNFVXQjJtUFlo?=
 =?utf-8?B?LzdFMnNra28rMHd3RmtMMDVXN3dvMTRoeEJMdFFPNmcxS1N2WDkwS1BwTVVx?=
 =?utf-8?B?OXdVMGZmS0lLMThLbVBNT3UzZWN5K1pMUm1ZM1BIbytIaGlGc2svQXZzQzEy?=
 =?utf-8?B?NTh0VWZSMVJwenNJWlhoa3IyOFFTVk8wRFB5T2Q0MThkblk2V3RmdnNaR2Zu?=
 =?utf-8?B?NCtOUUw4WUU1N21Bb0xub01Gbkd6TWtxUE5vRWM1UjQycGdpUWErR3VFM0NJ?=
 =?utf-8?B?VzFwSHkvRlRYWnl1ZUtNeVVmMmhQbWdiTTJXZDBqbWZxdUQ1OE9aSk1NOE95?=
 =?utf-8?B?VWhnNllNMTJZcjVpb0ZJSm5xQ3VIOEx3d21FSXB5RTZVUmQ2S0dOS0IrZGFo?=
 =?utf-8?B?cTBiWXNaMG1hTUdubWIvTXNWOFR2RitvcENuV2FtSThuVzdGQTM5RS9VZWRE?=
 =?utf-8?B?UnJVQThtczB1cFFYVFNDa1RQUjJvaTJTMU5UbDZ2ZllIazV5UXVxWno1dE1s?=
 =?utf-8?B?NG5UamJ4RDNhZ3YyYU9ka0xMa1ZHdnhhblVBaHNXeUdNdmZta2dZUGxvRE5D?=
 =?utf-8?B?SU1aNndQbHZPdUkxSnBZY1JQajRrUU4xVURWdHFYNzR1QkhzL0I4b205QU1M?=
 =?utf-8?B?L3Z1bk92K2lya0dwM0lwTFByYjhFMFdYWW10bWw0RmRWdHgrandyaEliNGgr?=
 =?utf-8?B?WHhOMVg3UzR5ajFnSVhzVklUMFZhK0J2cmtUazBRSWZlVlRQa3c1bDZEZmNJ?=
 =?utf-8?B?YnN4Vkp4aFVDM1daLzFTYUh3WFZRQUlGYmJrV2xTditVRG8vaFdVbW5iV25V?=
 =?utf-8?B?MG9iZSt4dFpQRFdNRlNtancrbXIvNEpnSXZ1RlJzZU9acXp5TldoclIrV0du?=
 =?utf-8?B?Nk5sZFEvSTF4eEhrOGJmUXBEdTJrR0FtaHZIZ1k3K2EzYjN2K1U1andpZkNX?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f903c6f5-de64-491d-e216-08ddffd0066b
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7232.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 03:18:28.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dP70VXFQMlzcs6bc7kRWlCa4dl2y8awe/9/2SuVT0Z8pSx0J1gnzfkeKKNKO+tyoL/b7x0Du8S3Fdev+z7Z7OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7307



On 9/24/2025 10:25 AM, Chao Yu wrote:
> [ EXTERNAL EMAIL ]
> 
> On 9/18/25 11:32, Jiucheng Xu via B4 Relay wrote:
>> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
>>
>> On 32-bit architectures, when GFP_NOFS is used, the file cache for write
>> operations cannot be allocated from the highmem and CMA.
> 
> Hi,
> 
> Have you suffered any problem w/o this patch? Can you please describe more
> details about it?
> 
Hi Chao,

Thanks for your comments.

Our a platform uses a 1.5G DRAM, and the kernel is aarch32.
We have a critical scenario where system need to record multimedia data 
while replaying the previously recorded multimedia files. However, 
stuttering often occurs during playback. The problem does not arise on 
aarch64 platforms with the same memory size.

We have analyzed the root cause as follows:
Data written using GFP_NOFS is only allocated from normal memory. Since 
the normal memory is only 768MB, it easily triggers the kswapd to 
reclaim memory, which in turn reclaims and clears the file cache of the 
recorded data. As a result, during playback, the system fails to hit the 
file cache and thus has to re-read data directly from the storage. Given 
that our storage has relatively poor performance, concurrent read 
(playback) and write (recording) operations lead to significant IO 
latency. High read latency then causes stuttering during playback.
>>
>> Since mapping->gfp_mask is set to GFP_HIGHUSER_MOVABLE during inode
> 
> GFP_HIGHUSER_MOVABLE includes __GFP_FS, we should avoid using __GFP_FS here.
> f2fs_write_begin() uses GFP_NOFS like the most of other filesystem to avoid
> potential deadlock, as __filemap_get_folio(, .. |__GFP_FS | ..) may run into
> memory reclaim to call ->writeback in where we may suffer deadlock potentially.
> 
Since our platform only support 5.15 kernel, I have checked 
EXT4/FAT/ntfs3 and find they all use mapping_gfp_mask(mapping)) as GFP 
flag to get page cache on kernel 5.15:

6100cca:
___GFP_HIGHMEM |___GFP_MOVABLE | ___GFP_IO | ___GFP_FS 
|___GFP_DIRECT_RECLAIM |___GFP_KSWAPD_RECLAIM |___GFP_HARDWALL 
|___GFP_SKIP_KASAN_UNPOISON | ___GFP_SKIP_KASAN_POISON

therefor that's why I recommend this flag.

I'm not sure if the above flags has some problems on f2fs, so I submit 
it and would be very eager to learn about the views of your experts.

Thanks and Best Regards,
Jiucheng

> Thanks,
> 
>> allocation, using mapping_gfp_mask(mapping) as the GFP flag of getting file
>> cache for writing is more efficient for 32-bit architectures.
>>> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
>> ---
>>   fs/f2fs/data.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 7961e0ddfca3aaa332b7dbd4985ae7766551834f..9fbc41f9accb2626da22754f1a424da4805ca823 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -3587,7 +3587,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>>         * Will wait that below with our IO control.
>>         */
>>        folio = __filemap_get_folio(mapping, index,
>> -                             FGP_LOCK | FGP_WRITE | FGP_CREAT, GFP_NOFS);
>> +                             FGP_LOCK | FGP_WRITE | FGP_CREAT,
>> +                             mapping_gfp_mask(mapping));
>>        if (IS_ERR(folio)) {
>>                err = PTR_ERR(folio);
>>                goto fail;
>>
>> ---
>> base-commit: c872b6279cd26762339ff02513e2a3f16149a6f1
>> change-id: 20250910-origin-dev-8a5ff6bee1f2
>>
>> Best regards,
> 


