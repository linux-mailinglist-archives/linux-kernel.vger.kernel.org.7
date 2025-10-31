Return-Path: <linux-kernel+bounces-880837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B62C26AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BCF188A73D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292B2367CF;
	Fri, 31 Oct 2025 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Jr7kzwNP"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020072.outbound.protection.outlook.com [52.101.191.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2063A1CD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938146; cv=fail; b=ohtVS0mKGHPQBFkk7IhxLvnQSNI7lYYHG7xpe09V5Q+qZff2Oip3BJIo6kBJd51y3IySd0TB5sJt+p8qUrq92m091yDlXrqf6UU8HHUGOR3V5/D629apAQufnXjykukgVvjW20eqM/3g4nQGvouj57m9bbmCAIHJ5+BIqW5OjP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938146; c=relaxed/simple;
	bh=MAAlF7khGwotDfJCQOKrZitMpZdrRjs4Y/AfKNKsFzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WgwZHlluRP/1pZOqT/p2cITIBAKfEf5FsrlwRKp/2zDYMVUTvqsWbeK/b+mzG4fEJutWyIIpA4QC+qnHi/7DiBQa+orN33d5wMbmbfO+ZwVU0GnAmKgZHudmAMJNFTB5BUBCZSQ0QJGHEZlORSrWXw29O9MKfnbp6yIDTLqgVFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Jr7kzwNP; arc=fail smtp.client-ip=52.101.191.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4ucsleVmFGTYSvqswy0dan+Twv49/LTLHJbRzxFRO4kVPIWeCS7UCpCd3Z3SeaN36jaMfAexrU9DgrAhGX2mdZ9suIDGy1iKQN+mrHVgfJmHaE8kRgAEkFhVKTsx599XKuO7j5shzDJw5QLr51wLXZNduWXlnh/THgI6TdRkHbCKC1Q6aLebahc+R4M7pBUXgP1l6ByfGA6w9YyZRVLOmk5dAyheAtXlwi1Shr7+6Kau4aZr+b7/A+FcX1CSeEM1SBG+WjU23QHT+iKuivvqItt2Xf2YwLdDpyJgymWeJ9vRWkAuameu1JGvbvNzy2/YEiruscuLuGj2bMAa/y00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/JYCkWnH+piZUu1cDUNlSCgEiQIzEjQbU61ARsthSg=;
 b=qYn+a+rI6198N41A32K+y/HDVAJPQp/m2fPqqg+22Hj0eurvUCCjXT5q9l1Bm3tUBtsojI/h3PlL0mLiAGxjR5qpGstPnRlO9cCdXaiTb3OEXiGC9BkaJOg3VOFtvJpPjmjuOI3JoKU+SfVMLOaqFcdiJQmba+eew57ucUmth8kRNS2+ViqgHnKtO2Y1swSWX3J5GFWmi4MkLa4dkuBrBEWxPKdNnh6wSZXlyyLKp3Roop1CNIJINm08HdUfDNbJ0SqXgwynzMr6ilxFmxL+yFmgh9LaUmtrc8L8xpxuz/UfCPQGJAliIB/TUNT7g41+ThISMCllupEUlK2xWnY2pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/JYCkWnH+piZUu1cDUNlSCgEiQIzEjQbU61ARsthSg=;
 b=Jr7kzwNPHFlzuJhL3rLrbL7TRwMAVyI9vEQ5Yf779zd3lBvJQUyrhrTf84mxwup9gyY3D2oy/wVLEFxtDMFR0Pf8p0qTp2tauNzOKYROqdJ7KhaIhw6TbZVJnp4Mimt5ftL8GdCS7zCv1v6aRJDAPWy6HVUfImHKBTr6x/z8Y+7BnbEYeP8jsCXyjbCZezgdfaGJOamtvW5gS7xcQd0lg7NsaS8TKj30qKjHaz8hENcs19eWbnopwXnopPH4VwDP+hb6hXopSu+r9t7/WQt/DJfv8RVloBuMga9kGw+C/kNpevCg2W2foN5YmtfdNgGDuVf1UBSpJCJdy/o4IZ5bcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB10275.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 19:15:41 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:15:41 +0000
Message-ID: <87061e39-6bcb-4a0e-b551-bf75ea435446@efficios.com>
Date: Fri, 31 Oct 2025 15:15:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 17/20] sched/mmcid: Provide CID ownership mode fixup
 functions
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.343419392@linutronix.de>
 <c2e4fed9-b207-4d28-93f5-b09f0fe78e35@efficios.com> <87wm4brp00.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87wm4brp00.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0183.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB10275:EE_
X-MS-Office365-Filtering-Correlation-Id: a372f027-f798-4876-1961-08de18b1e1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVU2RDM5L2s5aHN3SlUyWWZNNDZHT0x5OU1VczlORWduRVgvRDNRbDMrSkhO?=
 =?utf-8?B?RDFxZGdBMVc4RW5aRm4vSjU2bVdJalZ5TTlYNCtWY0lWYk9zcTZoaVFYRVc2?=
 =?utf-8?B?VjNXdm1lTHVsYVJhUW5MZHhGdmVPZ2NWMFRTWk8rWVlhWjRqaWZONHR1S1d6?=
 =?utf-8?B?Nk95aTlZZ1JHUUR3ams0U3pTenBuS05VSlJNWmlLRm51NHVOUnFWQ1dMcDY5?=
 =?utf-8?B?alllblNTemdwdTYydjV5MnppcG5qSDR2YWFUU1BpS3U2NExQMS9GdHNCRDdx?=
 =?utf-8?B?ZWtYRlpQaTh2d25rT003UW1sMXRBd0FXU0FwSTJKUStIYWdVdnE4SzFDNzlF?=
 =?utf-8?B?SUx0VDRObXIweVUyV1pDMUtnd1FNTlVRQmVaRjQ4d3REdkx2eUZMaGwvTUNE?=
 =?utf-8?B?VitDV2V2TEFuNUd2b1hLdG5rbTY4RFlpRmxJR2lETDdyOGxyWHMyMnlHN0JZ?=
 =?utf-8?B?TG4vcWFTVGl4S0VXbTAwNnplNUpydG5Qc1pTWTcrVUhDZWE1RFRwcDZ1ZEQ3?=
 =?utf-8?B?eDd5V0RiVytuUUxIcmhqS0dzSDNGdWVkZ2pjMzdnaExveVlrWEVnOEFobnRJ?=
 =?utf-8?B?TXArdjZ0b3RIS3V6dzUyTlRMeXB1MHREamtOVVZUWHNGd003VFlkMTludzk5?=
 =?utf-8?B?WDBDZ3FmcDRENllrc0NQQWI2cmlnaVRlV2lFL2VlY3VsV1VhM2lxWnpCSWpV?=
 =?utf-8?B?ZUw3bkpoRGdwT04rZDdBL05qc2szYW84VE40NmtoUWQvc3hNZDJCU1ZxR3R1?=
 =?utf-8?B?WldvOGtYN0RGbW81Zzh4TXBSaXlPUDlhMm9xZ05pblI1TUFYS1crU0JUOTZB?=
 =?utf-8?B?VytaV0FZaUxJTDNNRjduVkt4TlUraG01d0F3b1ZISmJIRTZJWkgyT2JFTUJk?=
 =?utf-8?B?VEt0dXFUNThNWk5nRGxxS2IzUldMUmdldVBjNGd2b0ZZNFR2K0ZzVjEzTURt?=
 =?utf-8?B?MnJwQUQ4RFNiNU5velkrV3BxUlVjbDVibHM1eTlHdUtJdk52K1NxT1diUGVo?=
 =?utf-8?B?RFNVcnVwUlNRVTdqbGJmVHBJOFZOczhNN0ZWYThKQUZ3WFB4Wmg5T2l4SHdF?=
 =?utf-8?B?MUNZQW5lM0cydVphNzBUaGtBa0ZoR0dqRE9Sem9HUDBqbzhzRitEOUdkWkZ6?=
 =?utf-8?B?dGtVa2tIRnJ4UXZnZmhaSThMM2gzWVdnS2R1Ni9BcXJGWHhJT0tRVUQ4eldo?=
 =?utf-8?B?bk1FM1lmbDUwVGl1ci9OUE5Dc3YyczUxZDFWVjJudHFuS09yY0UyRFM0SDBF?=
 =?utf-8?B?dkdDT3BXY3Z5MlRIbzh2RG1NTWFoZE1sZkg5eXJodVcrYlRJbXVoS3R3L1g4?=
 =?utf-8?B?SFBLSi8vZFhMeVYvM1dsME95STkrUTZUT0JyODN2cGkyV3M3VFJaaXFYOEpq?=
 =?utf-8?B?WlJsV2FGYmE1V3lnWTNHSUVhUTR1OHQ3SDEzT0tlajgwV2RIKzRXV0ZjZ01n?=
 =?utf-8?B?NDZXQjdwQStaWG9pMmc1Z2ZsaTBvTk5GYjM5Wmpib0liOFNsZDYxNWIyVWxY?=
 =?utf-8?B?RFlUbzE2MjVnV3RjSGdwVWQ4ZmhKMUtzVmlBSXl6NEJpNkhiZVJMTVRWRlU5?=
 =?utf-8?B?TFJFckxzQUF0ZjJEQjJVYnFITEVkRWlsRmhTM2tHKytiNm5YblBkVjdkOVRM?=
 =?utf-8?B?VVJSNGVwdUZCQ3dRd21UZFhMRUE2ZFVoMXhjQ0p3bzVPTXBKUDdBSmhVMTFS?=
 =?utf-8?B?UTVuMnpPU0NyeVZoQ1dNU2Q2RnliVHdIUURsNGd4Mm1tTjFEYUM3YUhZYXZS?=
 =?utf-8?B?RzBrb3I0Mk9acURwQTRsWW1OUFRoVzlXZW5FdFEySzV0MDQ3OXJ6ektMaEFv?=
 =?utf-8?B?Nm9mdGpFcFZGQjFaQTVCaHhiQWtydXg2Q2xzQUEwaWJYRklOamVESHhzN3JQ?=
 =?utf-8?B?TXNFN3IzeXgvUThMUE5oR3hPUGZNY3p0eEJsM0tLWXkrblE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aitiaE1yMHB1bS9ybVU4cWQzYXRWMWdLaEVmRWFsUmFEeGZKWFUzcUtrbTgw?=
 =?utf-8?B?b2QwTlFnMHJtVzRRNExhMEVnQURycVM2OTY3VDFKTkpkK3hqMmJLYnpTcHNF?=
 =?utf-8?B?ZnphckNkaWhGZG1KbkNJS0hXbVNOSk9Nd1ZvaXg4MUtJakYwVVFEYmRKcXRn?=
 =?utf-8?B?K0VCbVRTVmJrOUNJVVk3MUJyK2dhRi90VEVpSkx0TmZ1c1BHeGRLNFdmRXl4?=
 =?utf-8?B?Ykl2cDdQOEJvM1dBMnhEeWU3UFA4Si9ZU3NuVjNYTW1rcUthNVdsK3dTTlhN?=
 =?utf-8?B?YVd0QlhVQ1ROcTRDOHByc2kvaTFIRmt1bW5zWXp6ZzZXSHQ0WXZ4SjZQTGgx?=
 =?utf-8?B?UWxpUmNjMnI3VVgvN3lKYUs3NnkwMHBGT3NjVSt2YmJLTkthNHN1MWc1Rzh0?=
 =?utf-8?B?dm5iYW9mOGNaVHRCSWxicjQ1V3VhTUtrYW8rdW8zbmZpMzJxQVhFTjhIdFR4?=
 =?utf-8?B?WHl2OVp2aVRsU1pPRjB0SGpBSGNqdWc0SGo5Tk9uL05haTZ1M3RyNWY3TE5q?=
 =?utf-8?B?RHVQeU96L2x2aDRPcjNwQ0JVTk9BaXNJRU5xUTkvQXRac1J5VHA2dGVlYlNX?=
 =?utf-8?B?cjU0ZnY0b2Y4QVQweDd1MHlxK2I0TjB1VVF6TG9yU0tKZ21qUXloeTJKUFUr?=
 =?utf-8?B?NFJHRGpwYjJlOXN4ajh4OWthOVowNFhoMmoyTExROUhiYmJXOEtINndvcUN0?=
 =?utf-8?B?WDJaV3ZDa3FPVk9Gb1l2TU1NOUl6UFEwa0FTTFVVL0NsN05MbnhRK3FacWpL?=
 =?utf-8?B?cmFydGgzcURWOENieGlHYW5jSjVZeGJyQThiTFNuUGlGZmhtNDB5R3JHY2kr?=
 =?utf-8?B?MmU2Snd1aHg0UEQvZXV5dkRObGc4bUIxTjE4emVSd1R3S1hSQk1kSUFzdTRV?=
 =?utf-8?B?M2UxY2RPQUhDY1prSXVCMG44WGEzMjVveFY1UnRVQ09scTZKVTgrak1HRTU0?=
 =?utf-8?B?RG9IUmxNdndBZ24ydFplZEg0TWhHbXpJUVdDMjZZUzIybmdRSkdUSlJ4VUlU?=
 =?utf-8?B?OWY4c1ZXVFBrTmM4UGRDNUFUa0plK05CL2YyUEVaR3lpSytvV2pNVS9zNTZj?=
 =?utf-8?B?d1RwbGFQa0RtcmlsaEw2WU5yM0lqNVBSWDAzaDlrVlBYRlRyQkttVVM1ckNL?=
 =?utf-8?B?STNPVUdkZHVRaHk3ZWVjWjlyY3hETERyQXVnQk9hQVkwelRXNnNseVgvdHZx?=
 =?utf-8?B?eFFWTkNuQnFQS2oyVGc1ZjRMcllvNVlVc1ZsWW1hTkNWUFJsM285L3NkUW5M?=
 =?utf-8?B?U1lYWlhxMW4zS0xUWmgvajhRSnUxM040TU5nWVpjUXJ4djhGVmU1ZGo4Y1Av?=
 =?utf-8?B?RnhUdjU2amNIaGk5MWdBY01OaW8zRWpTYTZ2cEpUeExnREZCSGpjQkNUMUNn?=
 =?utf-8?B?WkYyYVZyTnFwaW8zMEJTSDkwK2xRNXNST3RvTW8vbUZjdENPMXJQRzlET3pI?=
 =?utf-8?B?QkM5amIrcTVuSFNwb1ZvL1JZaW55N0l0M0c5RGY4cmlvVXkyYzkvYTRrbTFZ?=
 =?utf-8?B?ZXZ1MzJseTFNM3gyOVhMRUh1YytJdzIxMVZKdXNjTURvRzhnRnJNRW41QVps?=
 =?utf-8?B?TS9ueFNsckYyN3lhZmd4aHVBTzF0dEY1Q0Nvb01YaC9UbFkyUmx4RzFVS2w1?=
 =?utf-8?B?RkRSVFhTb0FITlpTdG5venBsekh5WE9iWXdjSEpxdFFQRnM4NHVwejRYdU9I?=
 =?utf-8?B?RTRoUXVGdWREdFIrYXRWaWFUSmp6WmRBWmt5a1R5amxOVjJ2eDFvQytoWXVB?=
 =?utf-8?B?aGEyN1NnSDJDS3dyMmx0VUJNWS9CakxWZEl5OFZhdUdKbk1MYlpsY1JZMWp1?=
 =?utf-8?B?ckl0UTg0Z2U5cDlhcDBQU3oxRUhvV3Z1UTJlN1R0ZVlMV0phUGZiMGhZM0tP?=
 =?utf-8?B?VG93VDhuV2NKdTcvUnc1NDJKbmxkSitFVTBwUFJRUXFRa1Vva1R6bW5ack5L?=
 =?utf-8?B?SE1QMU1TSjQ3YXdQT05TQkhJdDMxVVRlblVaZ3BCZE1DdS83Wi9xdmZrOWY3?=
 =?utf-8?B?ZWdmU0xUdmxYTEhvUkVPUGJreS9laHFwNkZHYkRhY2hKMkVrQmJZeWlqZ1Nt?=
 =?utf-8?B?aTh5YnNJc29iMy9sZHppVFBETVVIR2gxUGZRUUFmUmI4Y2NqNjdGTTEzK0I4?=
 =?utf-8?B?TDhBOGdVdVNveGpSQ0V1OXd6Q1pYVWc4QTRsS3RaZFhrRTZ4ck4rRnc5ZHZL?=
 =?utf-8?Q?yvNR8rQAnMIIbafrOrGuXL4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a372f027-f798-4876-1961-08de18b1e1c8
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:15:41.0939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3j9jKdev+wynszE7DF/kQxt9J/c91hO4/WitDv7iPUBorYY2L2dlL7NWRqUrI6joIAnD4XXcHFv/4iRcWmaXIczXJiPrLdxPDzZK3qCKOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10275

On 2025-10-31 12:54, Thomas Gleixner wrote:
> On Thu, Oct 30 2025 at 11:51, Mathieu Desnoyers wrote:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

