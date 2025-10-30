Return-Path: <linux-kernel+bounces-877674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB41C1EBA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D78D3B5665
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47A2335BA6;
	Thu, 30 Oct 2025 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dEhrG0Rp"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022105.outbound.protection.outlook.com [40.107.209.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4946A2F0C66
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761808975; cv=fail; b=s48adv/j7tXvqqHYHg8G4UDBa6PthcvVDzaZQF+iHzAnZAXxtk4yyGDNw3eSh8wjECGc/2MoNTgUHnSDKaNZFLaBZRt4iJlG2O4BJA8YrAebqABZw+xIlowLzos7tD7z3KCcF+fTdXV7yQ/QNVoqhavUWslFTo3ij9QTAgK2GCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761808975; c=relaxed/simple;
	bh=tjVu4YvH3j8CBNAJgrDQeDurYqSYIJoZhw1pRNyOR+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qz1Uy9eRfu0Ykdo8Y9Hi3HQOWQVAhLjUtH+A11/VnBVG3qItyVRXQOVs0UVArZHSKYy9JZzA/69OkJvGuTgntzgX7skDuaGGBR7RpHgmCSz0lPrwLC0JQzCdRTQ5LBQ75SIRXAhb4zZyXWieQtDN+CEmZpdHLuMWUlgZEMhFZjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dEhrG0Rp; arc=fail smtp.client-ip=40.107.209.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOW/znQ4T28bRKSJHwqX3TmSRqcAT4UJS9eE3364B10DFJLq7t9Xh3nRncCZAIg4GddIGZSIWfb4N+hXPMFpJdE5e+y/3YKiVPNcGEc4WdiM50M4AwS21rUv15sMAwInT8sAokNriqa3KrcsjxZ5zCrFgzunhe1N6+Qe6nhW/TojR8Z9p7Jvc9+pFTpG6I+6rXw7BPfv7RKUDyp5oy+T0G0rS6jUjR3bz3vfZI50dHiCFPA7NjEuBW6wVCsaEjWK6Hj4NbFSlYkw2vx8PcMptK0setCvhAqkc7Dyy91IM4WwwowdTHd4/Aw8nDbYdQ9cns4fsT6zHiPMKMIFLLzSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kQ3igTqGU10JKQqrS6IId1q9k7kfFvUJhgAt3/EnBo=;
 b=sK5w8D3nWjmopTHGVoQe0aCGmqqARCqslu3ehh/LU3pr7PK2DD35ygjiy3s7GzMhPPs4focf1BZwAVvd0uAxyQIm4gttuo1t+7xIFqAglOY4K7yRi5ha1S2pdllHDVATn66f9B6/WH/cmpXYqip+x/b3y/5AhQPho6Yl5Fw0MB3VNmtBOquRvcaYWGsZ2Oi3wEnC2IqyqNwgo4LUyVbFaId084NmMIBF1qKY3d4zBLvM0W6RzomP4TIZr4yxJj7T0HDPsU9fSS2C/n6phFo7FDkBSqveTs49OOKaDGA94H+ovqYP0tOFL71VmxbMIQIYXFHpqKRttSsLszdSdaf2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kQ3igTqGU10JKQqrS6IId1q9k7kfFvUJhgAt3/EnBo=;
 b=dEhrG0RpfLFfA+693LTUctkz1ilvvXCT/Pm8c1ziolSmRuAvlywp2lj273lA9eZAk5XiDjG5A3xGxsOTssuGK8zmyJD/dAlWWKZD0XhQTkK30/MJn1lcS706wNGBQe3sEc5zbuKVA46j0NpNuywDE5DNnlATYv/6xJRLI/HVYuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 IA0PR01MB8278.prod.exchangelabs.com (2603:10b6:208:488::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Thu, 30 Oct 2025 07:22:50 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 07:22:50 +0000
Message-ID: <2aa7380b-bebd-4bb9-8597-49e06d1dcc6d@os.amperecomputing.com>
Date: Thu, 30 Oct 2025 15:22:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [REGRESSION][v6.17-rc1]sched/fair: Bump
 sd->max_newidle_lb_cost when newidle balance fails
To: Peter Zijlstra <peterz@infradead.org>,
 Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: Chris Mason <clm@meta.com>, clm@fb.com,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 LKML <linux-kernel@vger.kernel.org>
References: <006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com>
 <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
 <20251007113459.GF3245006@noisy.programming.kicks-ass.net>
 <36545e62-9947-43ef-9bc1-776f5663a45c@oracle.com>
 <20251010170937.GG4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <20251010170937.GG4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|IA0PR01MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf96af9-62fc-4294-4dcc-08de178521d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RitUaVdvUldzeW1nakJROEJVamZUWlhKdU5JVHFRNVgvU0JEdkUwbEIrQlRU?=
 =?utf-8?B?L2VTbkZTb044bnNVemxDMUYweXNLRkxneUFKWWoydElJMUtRSG5tcFZPb2FL?=
 =?utf-8?B?MXA3RkNVUDNENGNRTkZQRVU2c3lxTWM5dlA5dlVycFhOZGxmN1JJaTNQWVR3?=
 =?utf-8?B?NXdVNXYvTHdkZWxZdWhpYUk3WExLYXMzSHNHTGl4UlNwWEhUeDF0VG9hWmJz?=
 =?utf-8?B?cnFXZFVwc0xCOTZyT2NXZENMZUR0S2NWTUNyVDUxb2lib0h4Nnpsc2ZYMTc3?=
 =?utf-8?B?ZnZScXlMN1lzdEJsVERuWUZrY3hqTXM0cVdkTVVzYy90K2tqUFoxVlRXTWJl?=
 =?utf-8?B?Z2FLTVhzdGFoN29nSU1sOHhISkdwVjZnYjl4SFdyWitjd1VRZmFSTTBLWDZC?=
 =?utf-8?B?d1ArTVE3elBGaExPUlY2NURYTTdCSXU0NnQ5YmU1VS85MHRsVTA2VWwxeXg3?=
 =?utf-8?B?bG1zeTBhVVQyMW9SNk1VQlhGUElTU1QvNjlpclNlU2ZjVUxLUHFvdnNMdURP?=
 =?utf-8?B?WmZIR0trREJJVjN1Smg2ek9GYjJ0Vk56N3BSemFlekdBSUVXcGU5QktBZjd1?=
 =?utf-8?B?Wk9zTU93dkVlelhrSFpzdUhvWnQvK2JaTERFNVRNcWVBTG43ekRrRTg0RWxs?=
 =?utf-8?B?cmoyUFA0bkprSDliMzY5dHhYcTg1UGhwNnc5UXBDYmg0VWVEZXBPVGhhS1dG?=
 =?utf-8?B?c0VkN0VjWnllQkxSQnBUMDhEWndiVzlQdHkxQUl4Tno3MEpNYXFIRzJxTFZM?=
 =?utf-8?B?TnFTZHcxYk5vanJqclR1SDBacHBtaTJJU095Rmk5a2pjdlF6NUQ4a3JmR0ps?=
 =?utf-8?B?ZkplNk8ydlkvWTRXbGFnN1llNmYvdHJlTDZMNFFtbHFtRStkSXM0bGZMcHU1?=
 =?utf-8?B?MlpsMG80bmxCRGhkZnREWXVDMzRpQzFKdW5rdEJxb010Z0d5VGxGbXFuTHBa?=
 =?utf-8?B?emhZbkhpUEhzVU9IaXRta29PQkFPK3MwZkluVStZUytkNFNXWDh4Y3Z0dDJS?=
 =?utf-8?B?SEprdGJqR0dCclVJT2hVVFJPeUw4dHptSHJKeStDOWRYbU1SZm10cVJzekp1?=
 =?utf-8?B?QXg2MklxUkczK3dCVWpmbVU5c0FMOWMrWERab05MUjkwRzc2bXVqTnY3bXo0?=
 =?utf-8?B?azhNOHA4aEVVc1JFSDkrY3lTK2ZHMzZNSjdZZ01ncEQ0aDNwMXBiUWhKV1Rx?=
 =?utf-8?B?aDEzcXBiVk1GZHJsRXRqM01IR0RTem1RV3FXWmNoNUowbGxldy9qOEUxbGxl?=
 =?utf-8?B?c3hYUWVJZVM0TTZ5cU1zRG1XbU5Mb0VLQm55YlNMTGpKcDQ3bG8yc0I3RmM3?=
 =?utf-8?B?VVQ5bURMQ2x6V3B0b09ZSDR6RFVNSjBrOHNBVndiL1lwZ1NVREdPSXFhOEJ0?=
 =?utf-8?B?K1hoQ0ZRSStQOEsyRzdJcVA1U2lUYkZnMnp3QVNydUpiTjZHTUdTaWo5OU1B?=
 =?utf-8?B?c0Q0RUc1c2pseVA0cGw2TDdxdHc3c3JWNmxWVExLaCtaU2s0NDdHRGVFbzlP?=
 =?utf-8?B?MTlSTEVtUVgrMU9Ib1JSZktaRUNxUlh0amZnVmdseDVwL0FTSnNVQVlqd0dS?=
 =?utf-8?B?VWFMS2ppNytqRWF4WVQwNlV3dEJaZUE0UFFqTFgxTEx0NnhoNENsYlNMalhO?=
 =?utf-8?B?cXQzQTFoelJEZDBnSnd3TjFJSGRQNm1qVFRkVWVRdVI4eFU2cWFtYmVFL3Ur?=
 =?utf-8?B?QXpaK3E0bzZKT0xBcytBclR4L0xiNVhFZEQwYUlFMkFMNUhOT3hoSHZTRkZp?=
 =?utf-8?B?VU1LVWg2akJLYk1lTlpsS0VwR2ZVaDRsb3ZwSllHZ3JUWEdCdm9GRUJnQ0FY?=
 =?utf-8?B?WDg0NVhEMzR1WG1hbFBZb1lIWWlqNzJjTlczWUxBeDlXcHNkbVcycVBkUk5H?=
 =?utf-8?B?anQvb3ZndXkzbWtkYWZObW5EWkFlQVJzWVltaE5GeVFJVGo1NEJJSExJQ0hz?=
 =?utf-8?Q?1ufVsMNYYL+kqZGDQopnJGCqSHmWBzVn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c29IZ2lRMHdHQ1B1ZjZMMDhPbVNUblBicDJGazRKaklDRTNnaUhKTi82TmVh?=
 =?utf-8?B?ZGh5TWdPV0svcjA5N2NJVHowejhISStOWjE0Tk1IMzNFS2srVGg2Y1VSTDNq?=
 =?utf-8?B?UGNKQUdHTmJPa1JXRHlJUWhOTEdLMlFPMGowemZFMGtQR1JmbUxNUDFuVWZx?=
 =?utf-8?B?VmhNSVgrWHd1Rk9sbENPeTFGaFlRUnRUSnVJUUtOdkU0Nk83bXBtWUVValcz?=
 =?utf-8?B?cFdJcTBvSWFIdlVYLy9KWEhycDdJajlOQys4V1YwS1FlTUtqOGdEZjJRK0dh?=
 =?utf-8?B?Q3hGZkVqVXNCVzJoRnFWM09yOWg4eWRFUzBhSDRFM3JZTFgwUEg2UUlqRGN1?=
 =?utf-8?B?ZlVsTzR4R3d2ZHdWdmxkSXZMZTVFeWc1ZzZNVDVzR3ZnQ3Q2dEJvOC9vNkpo?=
 =?utf-8?B?L2tsMDNmWkM3aWQwREFQakpGZlExV3doLzhYMnBxbUtEbVhrZmU4MCtKZ2lY?=
 =?utf-8?B?R09Bc2JwbDc0ck5KdXBYR2pRTXFabUlyOGQ0TDFLVlBMd0NXZUNhUnU4MlRq?=
 =?utf-8?B?QkFGOVp2Z0Y4L1A2N2RsejllSW5WRGw3RWVtRkxKWjRuck5WUG5LZGNodnhl?=
 =?utf-8?B?SDFkdlJRaTNEWjdQV28va3JReXZyWkFNVG5GK0dRWWlGdnE2bUhETzRlb2xn?=
 =?utf-8?B?cnlGc1pZbFBZeHd2MXV3YTJ1SGpWSndrTjRSRG1jNlNZdkFZcjk3K1o3Mmo5?=
 =?utf-8?B?eDZGb1czT21VZmFtYXNhaXdJNkJXR2dEczl1ZkV4VXJQNWp2QVhwT29jTXhL?=
 =?utf-8?B?cE5iSDh4SWZ1TmxRZ3ZOMmVrNG9EaXVJVDlWdnpmNG1DM3JBalZZUTBHRmtW?=
 =?utf-8?B?N2tpWGFQRFVFZGp6NEcrM1o3akJlSWhqYTdjem8xL2hod2NLMTVkcHlvUHdO?=
 =?utf-8?B?c3hTM25weDhKWUZXWlJ6blVVOFZwbnV4ZVY0Zm8yb2NoV1hBTlNZeFhzbnRm?=
 =?utf-8?B?b3VzWk5FUVp6OUVZOFpvTnNWOXg2RERvK1MwblY4NjZ5ZXlsVzkzSmViLzRR?=
 =?utf-8?B?OEtHQ3IvZVJKOEJFVUJlQnZ2Wi9BbU5BZUlJcWpBQmlZL1NOOW5iak5VUnVj?=
 =?utf-8?B?eXM3ODNKbkpzNUhNa3V1clExZFFxTnFBTEdndU9yTi9Id25xZURXZFVxOUJS?=
 =?utf-8?B?UGREdGlGYlpJTEsvanNCR0pndGNUYllXQUhEeC92dkE1bTNESlZsL2pFb1FG?=
 =?utf-8?B?QW90SFVsd3p6U0JIdXVqTitENk5HUE5lZTRhN2lXR1RKMTZLN08xZ0tXZEQ3?=
 =?utf-8?B?K0Y0b0RhR2lUK0FHSkx0d3F5RkpzeTczdC8wQWFRY3o3aEU1OXRpREV1cGRy?=
 =?utf-8?B?WEl1WHV6Wkh4eFVtNEFLS25tMnBxMUZuYjNvbmJCd1NrRVVrRkx3RExTMXh4?=
 =?utf-8?B?QTMwSnZIUm1CRTFPZWY5M3EyRzBwUSs0UTEvd201SThMWHlwSXVTMDVxSTJl?=
 =?utf-8?B?OGt3UmNDMnhzWUtYOTMrOGpML0E0ZHI3a1MwN2YxMXk0NjJ6N1djTmdiaDYv?=
 =?utf-8?B?OUNzeW5YK29mOWo0bVBuYWpLYmh1WTNFMDlBNkVza292UzBGYTE3OS9rZEhW?=
 =?utf-8?B?czQwZURFeDVaVkJuclFtVjBta0xuVnJuRVUyczNVSkt0M3hFZ3JpZzZZSlVl?=
 =?utf-8?B?WDZlaTRMR2w4RXVzK3hnOXY0dTBibHlTWE1uclJLSk93b2JhSnFkVnpvRkZ3?=
 =?utf-8?B?SkZvRkRqMjlIYzhWTlRodjA2S1NIaDhOZkRKNlQrNklvaFNPdnZlZUVGRkZG?=
 =?utf-8?B?cXNSdlBENGRaVVN2UXB6Rjl2ZnVHd3BjV0hzajFkNm9YejhhUHdNUHNTa3dt?=
 =?utf-8?B?Zzl0OU84b3BUVC8wZ3IwUGhuT2dJVFl4ODZQd1pJU0dKUUxpQ08rcTEwRVE0?=
 =?utf-8?B?dkRVaHhlbGNtOXFBNlZNaEs1a1BVVkRqUGNFTXNuNTNNdDNSalE0VmFHSGxl?=
 =?utf-8?B?c2p5Q3MvVmxYY1JsSXA1MWJBLzE1cmpuL2thNlY2RVdsdTZhTnpwZysxZURF?=
 =?utf-8?B?Ni9SdDY1L1ErRytTVEtHcnA0RytCdS9BSXlZcXdFY3NRbGJkYlg0SnRBdGlP?=
 =?utf-8?B?RG50aW0xSSs4RFgzZm54ZHgrM2JxQWx3SzQ5emh0cEhxa2kzdUtkbnlMUWdC?=
 =?utf-8?B?c3lIc21SWVVhZnREYWJrdVRzcnVsWElBbjlEVk5Rd2hMUjlGbkNlY0g1MkFz?=
 =?utf-8?Q?Z/VCXiGA3lnlgRubmhLkt2Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf96af9-62fc-4294-4dcc-08de178521d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 07:22:50.0479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XX2K/vZ4EaXsHntrqlyREBWoBoPxdxFLONLTrYCZBVsihJsyYpxwDb73YI2e+9iEGjDxYw3Q1n6jtSshs/M35RWtdNA4VFbui+OHFOWw/SVANzd5/Z9htS7KUpRqvv9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8278

Hi Peter,

I tested your patch on AmpereOne arm64 server with SpecJBB benchmark.
Please see details bellow:

On 10/11/2025 1:09 AM, Peter Zijlstra wrote:
> On Thu, Oct 09, 2025 at 09:04:40PM -0400, Joseph Salisbury wrote:
> 
>> I ran some Phoronix tests (phoronix-test-suite benchmark apache) while
>> collecting drgn data.  I attached two files:
>>
>> *apache_drgn_log_WITH-155213a2aed4.HAS_REGRESSION.txt*
>> and
>> *apache_drgn_log_WITHOUT-155213a2aed4.BASELINE.txt*
>>
>> As the names imply, the first files 'WITH-155213a2aed4' has commit
>> 155213a2aed4 applied and experiences a performance regression.  The other
>> file, does not have the commit applied and is the baseline.
> 
> That's quite a clear difference there. The one WITH is more or less
> stuck at 5e5 while the one WITHOUT seems to hoover around 3e4.
> 
> So yeah, too aggressive for that workload. 
> 
> Ooh, Chris, note how you clip after checking for being larger. This
> means that you're constantly pushing the last_max value forward,
> impeding decay. '(3*max)/2 > max' is 'true' and all that.
> 
> Anyway, I've been playing around with various schemes today, see patch
> below. NI_TARGET is basically a revert of the patch in question +- decay
> speed.
> 
> For schbench -- the only benchmark I've tried so far, I get roughly
> similar performance using TARGET+RUNNABLE+RANDOM.
> 
> Feel free to play around with the settings or invent more options ;-)
> 

Commit 155213a2aed4 brings ~6% regression for SpecJBB critical-jOPS on
AmpereOne server. 

Baseline: v6.17 kernel + patch. Compared with baseline:
NI_TARGET	+7%
NI_SPARE	-3%
NI_RUNNABLE	-4%
NI_RANDOM	-3%

So NI_TARGET reverts the performance regression.
The other options brings more regression for SpecJBB.

> ---
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 5263746b63e8..f984f5972b76 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -77,6 +77,7 @@ struct sched_domain_shared {
>  	atomic_t	nr_busy_cpus;
>  	int		has_idle_cores;
>  	int		nr_idle_scan;
> +	int		has_spare_tasks;
>  };
>  
>  struct sched_domain {
> @@ -101,7 +102,11 @@ struct sched_domain {
>  	unsigned int nr_balance_failed; /* initialise to 0 */
>  
>  	/* idle_balance() stats */
> +	unsigned int newidle_call;
> +	unsigned int newidle_success;
> +	unsigned int newidle_ratio;
>  	u64 max_newidle_lb_cost;
> +	u64 max_newidle_lb_target;
>  	unsigned long last_decay_max_lb_cost;
>  
>  #ifdef CONFIG_SCHEDSTATS
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ccba6fc3c3fe..a80601481472 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -119,6 +119,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> +DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
>  
>  #ifdef CONFIG_SCHED_PROXY_EXEC
>  DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
> @@ -8621,6 +8622,8 @@ void __init sched_init_smp(void)
>  {
>  	sched_init_numa(NUMA_NO_NODE);
>  
> +	prandom_init_once(&sched_rnd_state);
> +
>  	/*
>  	 * There's no userspace yet to cause hotplug operations; hence all the
>  	 * CPU masks are stable and all blatant races in the below code cannot
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8ce56a8d507f..10378135368e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10255,7 +10255,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  				      bool *sg_overutilized)
>  {
>  	int i, nr_running, local_group, sd_flags = env->sd->flags;
> -	bool balancing_at_rd = !env->sd->parent;
>  
>  	memset(sgs, 0, sizeof(*sgs));
>  
> @@ -10285,8 +10284,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  			continue;
>  		}
>  
> -		/* Overload indicator is only updated at root domain */
> -		if (balancing_at_rd && nr_running > 1)
> +		if (nr_running > 1)
>  			*sg_overloaded = 1;
>  
>  #ifdef CONFIG_NUMA_BALANCING
> @@ -10969,7 +10967,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  	if (sds->busiest)
>  		sds->prefer_sibling = !!(sds->busiest->flags & SD_PREFER_SIBLING);
>  
> -
>  	if (env->sd->flags & SD_NUMA)
>  		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
>  
> @@ -10983,6 +10980,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
>  	}
>  
> +	if (env->sd->shared)
> +		env->sd->shared->has_spare_tasks = sg_overloaded;
> +
>  	update_idle_cpu_scan(env, sum_util);
>  }
>  
> @@ -12055,29 +12055,82 @@ void update_max_interval(void)
>  	max_load_balance_interval = HZ*num_online_cpus()/10;
>  }
>  
> -static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
> +static inline void update_newidle_stats(struct sched_domain *sd, unsigned int success)
>  {
> -	if (cost > sd->max_newidle_lb_cost) {
> +	sd->newidle_call++;
> +	sd->newidle_success += success;
> +
> +	if (sd->newidle_call >= 1024) {
> +		sd->newidle_ratio = sd->newidle_success;
> +		sd->newidle_call /= 2;
> +		sd->newidle_success /= 2;
> +	}
> +}
> +
> +static inline bool
> +update_newidle_cost(struct rq *rq, struct sched_domain *sd, u64 cost, unsigned int success)
> +{
> +	unsigned long last_decay = sd->last_decay_max_lb_cost + HZ/10;
> +	unsigned long now = jiffies;
> +	u64 target = cost;
> +
> +	update_newidle_stats(sd, success);
> +
> +	/*
> +	 * Failing newidle means it is not effective;
> +	 * bump the cost so we end up doing less of it.
> +	 */
> +	if (!success) {
> +		cost = (3 * sd->max_newidle_lb_cost) / 2; /* + 50% */
>  		/*
> -		 * Track max cost of a domain to make sure to not delay the
> -		 * next wakeup on the CPU.
> -		 *
> -		 * sched_balance_newidle() bumps the cost whenever newidle
> -		 * balance fails, and we don't want things to grow out of
> -		 * control.  Use the sysctl_sched_migration_cost as the upper
> -		 * limit, plus a litle extra to avoid off by ones.
> +		 * We don't want things to grow out of control.  Use the
> +		 * sysctl_sched_migration_cost as the upper limit, plus a
> +		 * litle extra to avoid off by ones.
>  		 */
> -		sd->max_newidle_lb_cost =
> -			min(cost, sysctl_sched_migration_cost + 200);
> -		sd->last_decay_max_lb_cost = jiffies;
> -	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
> +		cost = min(cost, sysctl_sched_migration_cost + 200);
> +	}
> +
> +	if (cost > sd->max_newidle_lb_cost) {
> +		sd->max_newidle_lb_cost = cost;
> +		sd->last_decay_max_lb_cost = now;
> +	}
> +
> +	if (target > sd->max_newidle_lb_target) {
> +		sd->max_newidle_lb_target = target;
> +		sd->last_decay_max_lb_cost = now;
> +	}
> +
> +	if (time_after(now, last_decay)) {
> +		s64 diff, max_cost;
> +
> +		trace_printk("CPU-%d %s runnable: %ld target: %Ld cost: %Ld has_spare: %d call: %u success: %u\n",
> +			     rq->cpu, sd->name,
> +			     cpu_runnable(rq),
> +			     sd->max_newidle_lb_target,
> +			     sd->max_newidle_lb_cost,
> +			     sd->shared ? sd->shared->has_spare_tasks : -1,
> +			     sd->newidle_call, sd->newidle_success);
> +
>  		/*
> -		 * Decay the newidle max times by ~1% per second to ensure that
> +		 * Decay the newidle max times by ~1% per 10ms to ensure that
>  		 * it is not outdated and the current max cost is actually
>  		 * shorter.
>  		 */
> -		sd->max_newidle_lb_cost = (sd->max_newidle_lb_cost * 253) / 256;
> -		sd->last_decay_max_lb_cost = jiffies;
> +		sd->max_newidle_lb_target = (sd->max_newidle_lb_target * 253) / 256;
> +
> +		/*
> +		 * Decay the newidle max cost 25% towards the target -- the
> +		 * value it would have been but for the failure boosts above.
> +		 */
> +		max_cost = sd->max_newidle_lb_cost;
> +		diff = sd->max_newidle_lb_target - max_cost;
> +		diff /= 4;
> +		max_cost += diff;
> +		if (max_cost < 0)
> +			max_cost = 0;
> +		sd->max_newidle_lb_cost = max_cost;
> +
> +		sd->last_decay_max_lb_cost = now;
>  
>  		return true;
>  	}
> @@ -12110,7 +12163,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>  		 * Decay the newidle max times here because this is a regular
>  		 * visit to all the domains.
>  		 */
> -		need_decay = update_newidle_cost(sd, 0);
> +		need_decay = update_newidle_cost(rq, sd, 0, false);
>  		max_cost += sd->max_newidle_lb_cost;
>  
>  		/*
> @@ -12726,12 +12779,20 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
>  
>  	rcu_read_lock();
>  	sd = rcu_dereference_check_sched_domain(this_rq->sd);
> +	if (!sd) {
> +		rcu_read_unlock();
> +		goto out;
> +	}
> +
> +	u64 newidle_cost = sd->max_newidle_lb_cost;
> +
> +	if (sched_feat(NI_TARGET))
> +		newidle_cost = sd->max_newidle_lb_target;
>  
>  	if (!get_rd_overloaded(this_rq->rd) ||
> -	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> +	    this_rq->avg_idle < newidle_cost) {
>  
> -		if (sd)
> -			update_next_balance(sd, &next_balance);
> +		update_next_balance(sd, &next_balance);
>  		rcu_read_unlock();
>  
>  		goto out;
> @@ -12749,10 +12810,46 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
>  
>  		update_next_balance(sd, &next_balance);
>  
> -		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
> +		if (this_rq->avg_idle < curr_cost + newidle_cost)
>  			break;
>  
>  		if (sd->flags & SD_BALANCE_NEWIDLE) {
> +			unsigned int weight = 1;
> +			bool success;
> +
> +			if (sched_feat(NI_SPARE)) {
> +				/*
> +				 * If there are no spare tasks to be found in
> +				 * this domain, then searching for them is
> +				 * pointless.
> +				 */
> +				if (sd->shared && !sd->shared->has_spare_tasks)
> +					continue;
> +			}
> +
> +			if (sched_feat(NI_RUNNABLE)) {
> +				/*
> +				 * If we are over 99% runnable, maybe we don't
> +				 * need more tasks?
> +				 */
> +				if (cpu_runnable(this_rq) > 1014)
> +					continue;
> +			}
> +
> +			if (sched_feat(NI_RANDOM)) {
> +				/*
> +				 * Throw a 1k sided dice; and only run
> +				 * newidle_balance according to the success
> +				 * rate.
> +				 */
> +				u32 d1k = sched_rng() % 1024;
> +				weight = 1 + sd->newidle_ratio;
> +				if (d1k > weight) {
> +					update_newidle_stats(sd, 0);
> +					continue;
> +				}
> +				weight = (1024 + weight/2) / weight;
> +			}
>  
>  			pulled_task = sched_balance_rq(this_cpu, this_rq,
>  						   sd, CPU_NEWLY_IDLE,
> @@ -12763,14 +12860,13 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
>  			curr_cost += domain_cost;
>  			t0 = t1;
>  
> +			success = !!pulled_task;
> +
>  			/*
> -			 * Failing newidle means it is not effective;
> -			 * bump the cost so we end up doing less of it.
> +			 * Track max cost of a domain to make sure to not delay the
> +			 * next wakeup on the CPU.
>  			 */
> -			if (!pulled_task)
> -				domain_cost = (3 * sd->max_newidle_lb_cost) / 2;
> -
> -			update_newidle_cost(sd, domain_cost);
> +			update_newidle_cost(this_rq, sd, domain_cost, weight * success);
>  		}
>  
>  		/*
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 3c12d9f93331..5ded210701d0 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -121,3 +121,8 @@ SCHED_FEAT(WA_BIAS, true)
>  SCHED_FEAT(UTIL_EST, true)
>  
>  SCHED_FEAT(LATENCY_WARN, false)
> +
> +SCHED_FEAT(NI_TARGET, false)
> +SCHED_FEAT(NI_SPARE, false)
> +SCHED_FEAT(NI_RUNNABLE, false)
> +SCHED_FEAT(NI_RANDOM, false)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index cf2109b67f9a..d269eb864583 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -5,6 +5,7 @@
>  #ifndef _KERNEL_SCHED_SCHED_H
>  #define _KERNEL_SCHED_SCHED_H
>  
> +#include <linux/prandom.h>
>  #include <linux/sched/affinity.h>
>  #include <linux/sched/autogroup.h>
>  #include <linux/sched/cpufreq.h>
> @@ -1346,6 +1347,12 @@ static inline bool is_migration_disabled(struct task_struct *p)
>  }
>  
>  DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> +DECLARE_PER_CPU(struct rnd_state, sched_rnd_state);
> +
> +static inline u32 sched_rng(void)
> +{
> +	return prandom_u32_state(this_cpu_ptr(&sched_rnd_state));
> +}
>  
>  #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
>  #define this_rq()		this_cpu_ptr(&runqueues)
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 6e2f54169e66..2e2d4b5fd5e9 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1670,6 +1670,12 @@ sd_init(struct sched_domain_topology_level *tl,
>  
>  		.last_balance		= jiffies,
>  		.balance_interval	= sd_weight,
> +
> +		/* 50% success rate */
> +		.newidle_call		= 512,
> +		.newidle_success	= 256,
> +		.newidle_ratio		= 512,
> +
>  		.max_newidle_lb_cost	= 0,
>  		.last_decay_max_lb_cost	= jiffies,
>  		.child			= child,
> 

Thanks,
-adam


