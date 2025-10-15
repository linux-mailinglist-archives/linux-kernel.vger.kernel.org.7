Return-Path: <linux-kernel+bounces-854253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E6EBDDEC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0067C3ABE18
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC02731B822;
	Wed, 15 Oct 2025 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UZlN/1Qu"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020107.outbound.protection.outlook.com [52.101.193.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABCF319619
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523035; cv=fail; b=oIKc5FO3myKYcq/iz+nLWd2IGZ4JJo+/zGK8in2Gdm77QLTJsml4fh04c+tblMv5q4+iRB976ke07DS4u6msVcW8IWnECnQlbayEt+J/JMj1jiU6mNI/XDMsq+fjOpZejz0aloVVeyZqV1HwSeYa7WlHiGQ7ikrcdqGyfkvS3E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523035; c=relaxed/simple;
	bh=SGcd02gwYRIH2BoFVGjy2SR+lqmZgm2mDA9XeLP4yCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VvHA+hoIeBkACTv5YhynNMZFYEqmuNa3puY1vAt0mAOcaDTj9b1G9oEkxwHTTZpI1Bx8HBLNOynNFJT9THAsWmAvRXtdqa9UUxzhBu/wRGQhQyBS3S2RTSw3JRyH4Uz7BdAaMUlaaULUYgIzP+OTPiScfizcAg+eeAQeHHVEcYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UZlN/1Qu; arc=fail smtp.client-ip=52.101.193.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5Izk0swJaSTmGQLBOqxajvKl0ps99SvVTHR8zl7isvR9EfR9nMlL5xkSVqUcy4a5ulKgchGuGVmYcfAWNja+4X7TtJRxFpGSoMJLGeUX/HjexSRfWpIbNUh/hiqYn1qZ7C3YPm1XITwh3QdBY9I+B7t49AI9Xh8eZOZ+x92XXxqo0PE1Exe3xhkd8fja46gie2Q3BYNck8H01KnVXQnzyfolR+xmz7NRcLhr8zJonoZyrgXlfRt2TJaXzf5ZZwYLqqESrgwEXUb3/eOksR9ImBH9NSfMXQMLKR73yushZXv3WUQXh4O+/ZmzLeiRf9Y3hlc1kMYNayJFkLze0j4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgZtxN9DmDydAFjjHr9xCONSt0yksHXgt9Id/ehszQ8=;
 b=dbU7G4N+1BSm7B3V+kMpyigfDlqTjTzwBqwKFBjdmW0iL19zonz2J1Dm3589vFe8BAK2Ej2amd79HH+JrrKEAejPG+lkForkuzsSSjl44RzpyDewb/vTlJ2YSJ8Cftzi72jNNWev1HoezKOB6b3OMN4HNHvETRlmvuqdKnHj0nzsVkBooBSiQ39mFxPuP5rfIwi/WgZO6MBVBKTWapCp6H/qAA1D+cNXwI/xnqU60QvgOCw6EOOFy2CTibui/UXq+5ZWQDbjiwJ8Gq+XYM7erUr7MsP951hq+vmTsfa5Pzu0FLm1m+UN6FpIb2ypLhey9GPGECMCF3J7m+HJeYHgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgZtxN9DmDydAFjjHr9xCONSt0yksHXgt9Id/ehszQ8=;
 b=UZlN/1Quis+kiTHFpa5PiqxzIP414D/HxnRxi/JHSe+cM0Q5y5/n7YqwSi65AL+zGROrGKjEdkbWR1Rz7zu9Gg9bFQ7yWkWuo5z81b6/3v6m+tiavAa9/p9kUzUFAinRv9A7/1zJhM5wbhUKY3TqJfs3Nh8S2bUmEtLGw92J4go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 DM8PR01MB6998.prod.exchangelabs.com (2603:10b6:8:17::24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Wed, 15 Oct 2025 10:10:29 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 10:10:29 +0000
Message-ID: <8fd5189f-112b-4f30-8fde-10843b6a7fa8@os.amperecomputing.com>
Date: Wed, 15 Oct 2025 18:10:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] sched/fair: Only update stats for allowed CPUs
 when looking for dst group
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, cl@linux.com,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com,
 shkaushik@amperecomputing.com, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org
References: <20251011064322.8500-1-adamli@os.amperecomputing.com>
 <90e7343e-7741-45d8-b076-d3852d1870fb@intel.com>
 <d6b78d12-298d-4316-91f4-bf7d3d7d5776@os.amperecomputing.com>
 <f4a95e4b-93f6-4b36-b077-58d1c05bdfa2@intel.com>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <f4a95e4b-93f6-4b36-b077-58d1c05bdfa2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0008.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:17::13) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|DM8PR01MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b3e72f-77b7-43bf-9c47-08de0bd31140
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjF1QUF1ZWVteHZYem5GMXhHdUxrK3Z0c3llRkx1bnN3cFIxMC9KaG43SmZp?=
 =?utf-8?B?SGoxbHBzc1VnUXA2TEpZcnB1QnpiMXdMY1g1WStSNSttd0dKcDJYRGNpK2dt?=
 =?utf-8?B?RXdIb2k4TkE4QTFtUTFVTFhqYWsvaTU3c2VqaklSVWFGMENoUkJIVmcwTE50?=
 =?utf-8?B?d0dUMjEwa0hoK3hMbmUvOEErcHdJZ3dFYnVJTi9UUUE3UVBkb3pkdkNpUWl3?=
 =?utf-8?B?LzMxUDdUQnRPR0ZqWHp5UThGVjlVVjFGZHFJZjdYellzNER4NWhUdWdpY0xF?=
 =?utf-8?B?RFZ2bFNZV0wvbjc3cEFSbFpiRzNHL3Jpa2FXZ3luMEhGbDBsbFNwWDRVUHBJ?=
 =?utf-8?B?dEVHeWdTOUtQYUwrS3o1alljcHU0Zkk3Wml4SkdYTWxDeTY0MllPRlBVZEc3?=
 =?utf-8?B?eU1jdEw0L2c4TytjcGVsYnAxZm9QaGRNclBzOHMvakhZVytrV2JoSDQ5eUVz?=
 =?utf-8?B?dmVUbno3OURUMFRDVzBOUitKZGVoM0plZ0FwUVM5dDFyOS9qUkgza2RwK2Np?=
 =?utf-8?B?VG1xYk9BSTYxOEd0RHJraVNJYXpPWXJtQm42RlRWQ0NybnpZRWtrdW5nS3Ra?=
 =?utf-8?B?NzdjN1NZRTB0cTVIaDVCQXZMY3F6amcxK0NVZ0xka3RtZWtUZWU1TkU3QlFa?=
 =?utf-8?B?d0xnRTU4RzAxWXQ5OGl5NWZ2b2lBWkExbjFyQUt6WHQ3MTU4SnpIVmU2WmQy?=
 =?utf-8?B?cFlRbEZKY0FvYk9KVERuSFN4WExBRTg3bVhSUFFteVpmb3FrcEVROE9UOEVV?=
 =?utf-8?B?OEI5QjBOaUN4TGVDVjZjekF6Vzk4WDcwOG9XTUZ6QXowUzR2bmpaOG5PMUJM?=
 =?utf-8?B?QnVRRElBd0UzcG9wZTRwSFpoZGQ0OE5uckM2ZkhjTytkaksyL0VLSmRReXFs?=
 =?utf-8?B?U28yVnJidUlCSnp5ZkJmdytXY2Y5andicTl3alBkbHBCL1FycGNkMTJ3K0pa?=
 =?utf-8?B?dUg0T1dIRUFaRllDeVA2enFva1Bad1BscEtzdXdQZ2N3bEZtbkM3bHc3Skdq?=
 =?utf-8?B?aDFHL1hDZ3paUXFDQVJMb0VoVlRnaTd2UDV1STAyZzIrNmlNMGE5aG44TmdT?=
 =?utf-8?B?cUZDSkhFby85eHFjbU9kSEhDZVgrcHZvTlFHNUdRZWZuYUdtMVZBSEVtVnpC?=
 =?utf-8?B?dzV6TExpbDFZbUJkbGw2R2JzY3ZiSkpLNVFDc2djcWNmblNzMzRJcWJScXZP?=
 =?utf-8?B?aDRXNi8wYVYvWkZsdmlLN3lublVXd2srWUVaTWgwck1XZERWa0VQSXU3N0Zj?=
 =?utf-8?B?cDZoQ1YvcC9VSzB3ci9zY3VOcHNucnpjdHVOZUtNWFlKT2hpd0hQdGFBY04z?=
 =?utf-8?B?WmJnTGpSeXdZd080aEpTSVpnQVV1R3o3UGpVNWRmWlFWcU1iMHBPZzhaR1E3?=
 =?utf-8?B?djNnYlA5TUJvRS9kcXZvbnBoczhVU0Q3REIwYnpxbXE2clA5dVo1Z3hDY2Jw?=
 =?utf-8?B?aHJOclEva2JuUFVNc2V2bm9IekFZT29yRzlxUWtEL0pTdkJVU1Ayek9INHBn?=
 =?utf-8?B?aDVDQ0hXUFVkUUJOUG4zQlhadnl2b1lNS09lZWhZTExBMmFQNlEzdStCblcy?=
 =?utf-8?B?REVKTXl6RlpEN2N4UDcvdkROT25xWk5XQXRlYnhDelROd0EzYWk2TXl0aGwz?=
 =?utf-8?B?YlRxbFB3TjJwbmloMi8wTVJ0bzJNRUlzYVE0dVBzR2FUL3NhV05leUY5OHVr?=
 =?utf-8?B?aVVMZThxNU1NWXRnL0dVMDN2bXIvOWMvU29lejFla2k2K2c1bmNwQVN2QTVU?=
 =?utf-8?B?bzgyNFVEblZGUjZSdzB6QWt0T0ZWdDRkaUVXWTlFaFc3Qm5tY0YwUlVad0Iv?=
 =?utf-8?B?RThHUEQrOTFJZ2M1N2VkcFhRUmN3SiticWptckQ4TVRHVVNQU2hlcUJhU1BQ?=
 =?utf-8?B?MytlOTBXcmhiWEJ2ZkZUMXpHejFwNDd5OVFzNWRaSEdpbXlhWTd5ZWdJVG05?=
 =?utf-8?B?b0llSm5FWHBjWnNPZ0pmVDgvamYrNXlXS2loMVZrTEZ2Y0dUdCtVSUpTMkJq?=
 =?utf-8?B?aDRsd2JSWTZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uy9PdzVNVmpPRHBkbFQ5UnJhYUtuWExLQ0xMakEreVdZa2YwTk8wQVdEdHVK?=
 =?utf-8?B?V28zSmJTejF0Z0wxekJOaU5wcnhFRis5SEd0RHRTKytwMzcrZHhzeUpPbTZZ?=
 =?utf-8?B?MkhBSnp6S2x3blJYcFlJdDFsRU9xS2hwNGEyVCtaMkN4cFArUjNEbUdPTHFS?=
 =?utf-8?B?TmtKMExmS21INXdRNHhUMzB5T25Ha3VOR29KQWRSQkRLTktZY2JwSnlsaVFq?=
 =?utf-8?B?RWZTaWZuVzZIdXdPWDBFeUZpRi9qY2FuRWlCL08vb1JVRFRWeEs2ZjVHbHRj?=
 =?utf-8?B?eWp5aDlpbkl6RWNVZ2FrWC8rbWw2bTFkUTdGTXdhUkpxa0VwVXlORjFvOVc4?=
 =?utf-8?B?NHBaTHNUVFgwcDY0aHVPWnhtT2ZTWDdFb2NjTm8yR3VTeWJta1hadi9uQXZp?=
 =?utf-8?B?UTg1SEtIeTlqZUZIUHhNU1pEanJTMG9jb1lMK2cxWmZWSHhubS9OSjBrYTc3?=
 =?utf-8?B?aUxaRWhTTE5WMzQyWVREczJuTXFROHdQOFZWQ2VERlNrNldXVlhwU25TbENW?=
 =?utf-8?B?T3RGSmVOemkvY2VFcHZpTks2d0hva1JYc1psU0RIT1hoQXQ3SFVPWDRFd1ZP?=
 =?utf-8?B?M3R4enZPMStrbkE2VldvZVpKREhnNUVkU0pGaVpzQVFzWnNCUXdvSWY3WVR1?=
 =?utf-8?B?dHluTk5EMklsVlBybDhjN2V6YjV0L1FYQ1g1RzB0N0hJaE5Kd2psbmdGZFBE?=
 =?utf-8?B?d2Joa29IaE03enZoRkpaOUNVdmZQOGhCdEpHb2NLNUU3WEJ1dXJEbnJBZmdU?=
 =?utf-8?B?RWtncE5JVGE1RmU2OFRCK2VEaTBTVndGTCtmSXoyNzNocE1jaEdBZmRnN1Ft?=
 =?utf-8?B?VFoyVFMzeGNMbG5uWC9BaUZMcUVTQkJvZVVEUGd1WERsaHRaRHZtN2l6NW4z?=
 =?utf-8?B?cVZPKzdvOGNUdFFvdnYreXI0WUdDYTRrTXJ1bktEVms3VE1wMk5pbGlkdjd5?=
 =?utf-8?B?WnlHL0ptays3QTZxOStzbGtZd0g3elJOVG1uOFhoVElBNUg2eGxYVjBBZHk3?=
 =?utf-8?B?eUNnVHBGWVZJbjJ3alNFSFFtSVRYSXdRNzFObVltS2xuUm9naUVSZ2EyeFl3?=
 =?utf-8?B?RzloS0w3OGNYcyt3KzhrZjlFNXRlRHcwbFZFNHNCbGtlZ0wwT2lpcnF5N2FS?=
 =?utf-8?B?VDRrVWJpUmlLdGdEaUhiMUhhM2VqSU9RdTdkY2w3aFJaYU83NHhyYno1bXph?=
 =?utf-8?B?RlQxc3lTUVpEOEI5a2JkdndXaDhscVZnaFBvcEFjOVg1ZDlkRWY0QVA2NlVv?=
 =?utf-8?B?T0F5N0dKQmZBaUN2YzdGVEljTWNFOGtSQ1NXb0RFbHh0clZSMVcyaDVTSEVN?=
 =?utf-8?B?TnFJeTc3ekpENUpTUFZ3a2l5L0sxOEw2WDhwTmQ2MjNzZjlBbFlPbE80S0FK?=
 =?utf-8?B?MThsZSs0R1Y4Qjg4YzNVbEhwRGo0K1laUXpBSzNCdXRWZEdldGZWbkFQNExu?=
 =?utf-8?B?cHR6ZkxPTGdQL2hRTE0rdWI0UTVMa3k3UmtCcURqTjVBWUFUakNkWWE5bW1t?=
 =?utf-8?B?QmtJUmxNeGpibHRHV054K2dicUhTZ0R3QmN2YmluYVpTaHo0d1R0SUZKUm1V?=
 =?utf-8?B?SmNhWk5rcHRYbjRtMDR2L3hIdHloRS9QY0ZVUHpFNU5YWXU1UDhwdE14QURt?=
 =?utf-8?B?cldlNzZheEhqdGdvbjJXOE5HYmt5b0laeldyUk5kQ2ZpZWorT3V2YnF4ZVda?=
 =?utf-8?B?K1ArazRiekd0TjFTZkEzcVRtQXU5NG1OdlRwd3ZkZ3l2c0JKS0JMNCs4MjA3?=
 =?utf-8?B?bTZPNEMyWVR1TWpsUE9SbWNCb1E4TlFXTnpsSm5jUWhsOHg2dUsxVFE5eU4r?=
 =?utf-8?B?OVAyVmtqbkY4eUNLV05oSE1ZRWVQY1pOZVl2WlAxVzJXdmY0TzNpYVphdnl1?=
 =?utf-8?B?SXRTN1dFRmx6R2hnWkdvQmZrbUIzVHZpTFlpNDh3OWpHKzhHS2Y4RlI3dllU?=
 =?utf-8?B?clVyQVhYWDlMN0hzeWdtdEc5RXd6VDFROXFGQTlQU3lsSlp6d3lVeGpyR25G?=
 =?utf-8?B?a3o5WlBnY2NyTXo5ZlJ6WjRabE1NZWhuMWI2RU5udVNwUWFtdnFMRVhaTlFW?=
 =?utf-8?B?RzNsd0w4UzloTG82TVpBV3BrWXVXTWRweU1Ua051cVErY3N4WTBraFlUQ1Jz?=
 =?utf-8?B?NWxqU3JCWUw2bjF0aHEyZG5yS2NTdnBTTm94SlFVcnVsbDhWRjBGeTI0bTFU?=
 =?utf-8?Q?GoLuxyl57JZp4YCTqQk3h+4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b3e72f-77b7-43bf-9c47-08de0bd31140
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 10:10:29.1420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfovN71qBbhVzeqZ3euo213Hu+ynXb201bduyRdLrFcmm9d/PFpVR8Vpviff1H+TszNaYAiQFqDUf1+3QxfpC6jm7g9Sbd9rMvVBqzM9hP7sZKyrahJsog1iXKLLWIon
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6998

On 10/14/2025 8:07 PM, Chen, Yu C wrote:
> On 10/14/2025 6:51 PM, Adam Li wrote:
[...]
>>>
>> But I am not sure if it is safe to use the percpu 'select_rq_mask'
>> in update_sg_wakeup_stats(). Or we have to allocate a 'struct cpumask'.
>>
> 
> Allocating dynamically would be costly. Using percpu select_rq_mask is
> safe in this scenario: the waker's CPU has already disabled local irq
> via raw_spinlock_irqsave(&p->pi_lock), so I suppose no one can modify
> it simultaneously. Moreover, if the fast wakeup path select_idle_sibling()
>  can use it, the slow path sched_balance_find_dst_cpu() should also be able
> to do so IMO.
> 

Yes. Agree.>> I tested bellow patch. It can work and fix the bug.
>> If it is safe to use 'select_rq_mask' , I can submit V2 patch.
>>
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10664,6 +10664,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>>                                            struct task_struct *p)
>>   {
>>          int i, nr_running;
>> +       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
>>
>>          memset(sgs, 0, sizeof(*sgs));
>>
>> @@ -10671,7 +10672,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>>          if (sd->flags & SD_ASYM_CPUCAPACITY)
>>                  sgs->group_misfit_task_load = 1;
>>
>> -       for_each_cpu(i, sched_group_span(group)) {
> 
> nice-to-have:
> maybe add a comment here that cpus is not empty, because
> we have cpumask_intersects() check in sched_balance_find_dst_group(),
> (just in case sgs->group_type incorrectly remain 0 which is group_has_spare, if
> the cpus is empty)
> 
OK.

As Peter suggested [1] for this patch I will keep 'for_each_cpu_and()'.

I will try this cpumask pre-calculation optimization as next step,
for both update_sg_lb_stats() and update_sg_wakeup_stats().

>> +       cpumask_and(cpus, sched_group_span(group), p->cpus_ptr);
>> +       for_each_cpu(i, cpus) {
>>                  struct rq *rq = cpu_rq(i);
>>                  unsigned int local;
>>
>>
> 
> and from my understanding, for this percpu version,
> 
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> 
Thanks for your review.

[1]: https://lore.kernel.org/all/20251014113731.GO4067720@noisy.programming.kicks-ass.net/

-adam


