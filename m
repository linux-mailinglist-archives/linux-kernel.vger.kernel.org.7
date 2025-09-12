Return-Path: <linux-kernel+bounces-813224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D0CB5422C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557B248318F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97162727FA;
	Fri, 12 Sep 2025 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bCpmRNfN"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FED21A38F9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757656239; cv=fail; b=Mx2FL+lkZpTJ77mE920YJ1nkm2+jteoVfKjrYBgrGjtR8G0MwmOj9LjPX0NBZgk2GzTQa8ElKmF4KavJygkyG/klHoaXA68LiZytwdtrumVr1EFwWRHLXhQHJmZMJCZPIZRS5gSoIBI22AYRRt5+XSeb0vbboHD4K+xEGhmpRLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757656239; c=relaxed/simple;
	bh=LMcUWw0J5KlwLYFLiWbIiii+ytgHREdXMxd5bOdTVQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YrpVKF7zy7lN/4IVheawJJ5StiWnh8ZNG/B5EuiBMz1U/PvXi4D5hq+nmPe3SX0DiDOMblCmGc7g+mJhbJwhEPWVMC+PVYz6qsidQSeTZ52DxLvU0pU9CRQpem2YtcBq/ZUCCrhRKJLF+BkboWEoKsLu9YWhxr43OzlsO4cRZ/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bCpmRNfN; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHBi6DpJBaTjdUYpX1BKfD+PnlnteyORJs6ZoKQbCAccemunBC+hr3zS11hPKRTgJPn81VQiXKtrqqnKZ+yXsGsVX7NpzhxLktEFgutIfmSrjUbJFh5QzAr35p0ehf8qQ9K3ji/Z4jdsUpI4nA67gJK4P5xZQSBiFOj9V0s/a3nTLwFNzPzC2tmfgDasDd9KlDlWR3YRYTFTQSUrFMI6SFOA4zmd0xaql3QcXWq1wzNgTY3IfqxDG6sy2ntTVd/3PRn1cUOrPXJMsTkXAymWDeM8eXeSCKpIU6ooR6I+/aQ5Zes6XePk66n+Da978X3MZh/RUW5RfrB9J79uNInjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXfR4PoZkcyoYjA1sfk+mWIVNr1fvQ7Ep/XGRRVWbsQ=;
 b=GNbNbn7OE2nLlfRhYoU7pPbwthkUf9fvtt8wwdAN6+isBf5WV/Ny3hLfsc1GQiHWy05GhqMML7FIwHPfPAOwTRxaKGGRvtss0f8Rxw6pE8uP0cNrrT7YTfkD83o/0qAk9M2gSPJiSofI5UUedkbQrcY/IUImEmNNnrBBb4JTUpsb/QJWNe6Djlfmcjo4b9vUuuHIkbNs75+JN78+hfu7Cp91NXrqK+ayXWaNiDnLSk3xqHO+KqhqSoQ+xUHxvTcu/5zVWkLsL3jVVJb0aS2BixJvpcmORwn3+Ya9Lej7MGvAcv7dijYa1YqRSALsMsEwxpovujGqWRcT6/1JRflipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXfR4PoZkcyoYjA1sfk+mWIVNr1fvQ7Ep/XGRRVWbsQ=;
 b=bCpmRNfN/nHjoGM3O4eBCf887HBYC4ZCX5KOhmPxpYurS4e0xTkdiucxLBrTicwRk0W9SRAsdeFoqdBd2I03OsBLX8LjmfBb49sTzV/RWTVhiJ2W0caLW9mAphOKopeJWsrpbBO/Cw4XPfqkRyKhRdBEiiEbnNbRAOI6x68t3fM=
Received: from DS7PR03CA0164.namprd03.prod.outlook.com (2603:10b6:5:3b2::19)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 05:50:33 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::9) by DS7PR03CA0164.outlook.office365.com
 (2603:10b6:5:3b2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 05:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 05:50:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 22:50:32 -0700
Received: from [10.136.41.4] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 22:50:24 -0700
Message-ID: <a6c0b576-393d-4283-86ab-5c88c22ebdc3@amd.com>
Date: Fri, 12 Sep 2025 11:20:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v21 1/6] locking: Add task::blocked_lock to
 serialize blocked_on state
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
CC: Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
	<vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman
	<mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan
	<xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	<kernel-team@android.com>
References: <20250904002201.971268-1-jstultz@google.com>
 <20250904002201.971268-2-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250904002201.971268-2-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 54790c57-0c7f-47e7-f354-08ddf1c049d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yy9vbitHVUJEcW1PaVJjeWdSUFFIMW42QStsNytXZE1aREJkZDBGOXFMSTQ4?=
 =?utf-8?B?SHJyZFRrK0E3ekRrMUYxcitLNTQyaVV2c2lIendQd1RRZTE3VWxxNG0zUExM?=
 =?utf-8?B?ekRGT2xkNDhZU0tBSndydTloWnVRY04xcUkrbnAvTHBjdm8xODZtdXlnWEFw?=
 =?utf-8?B?OHR4OGVQMFBCOTlxbnZTbVRpSkZzZnNUeGtpS2NHZDE5eXE5aW1HZUdMK0lS?=
 =?utf-8?B?V1MzclpOeXVEb2xLSXFvTkNReEwydDgvR1VvMGRqNmtKaUh3ZElyamV0OFRv?=
 =?utf-8?B?UDkreTNDblp1QlBmSlIzNUo1REhGa3BJNzlEWkYyQnh2S0lhdjFSeTByL0wr?=
 =?utf-8?B?MDVwMGcxRTRPK0txaU5tM1ZCZlNwRUovT2lmOXpCS3hBM1hVNlNCSndCSTY0?=
 =?utf-8?B?RU8veFkvblNIZEp4K1UzTmtON0h5bng3MUlIeDMzU0RJQ1JQaXVab2FIeCt5?=
 =?utf-8?B?RzBHTjJlMHc1Y2dRczFDQjlNcFFENldsKzQ5cFhabHN5aUpLeHZCY0J6V24w?=
 =?utf-8?B?VmR0STE3R3daMUlPd3hSZCtZdTRPMTJmSDZ4Q0xBbXRCUFdYNXJxNWh3endD?=
 =?utf-8?B?YVE1UmRGc0dESkhhMjVUenh6S0lIM3lUTStOU1R0T1pyMHdIRGZsLzlhMGsw?=
 =?utf-8?B?Zjg5Y0YxbTFDVXhIZjlMa0VRMEU5UzVWaFNMbmZtbHVWQ1FPZy9pZlhUaFEr?=
 =?utf-8?B?cmRzVWdVSjV3KzlOVWRRUGZ2MTVJdldwVmVHUXlIanFsN1VWdUs3cTdsWUl6?=
 =?utf-8?B?N1UyN08veEUyTmkrRHNjMXJCKytXYVdaeWxTMXM0T3BucWY3M2d3aHpEbVpk?=
 =?utf-8?B?SG5qYmNYRnJMckZ6RHJkb3lWc2ZUWVlPQWZJanhWcmxUN2NzOHd3SGxmcmJh?=
 =?utf-8?B?bEwvVmZjdVNIMU1FeGhYREFFTWxzQkpObVU2dFp5WEh2VW9TM1FjV0xGQ3A2?=
 =?utf-8?B?VjY5c2ZhOWpSQk9MclF6RmlBMHU5V3BpSGRBM1NyN3NzMVo2azRhdC95Ujlt?=
 =?utf-8?B?dVdJOGZkSnR0eWtRRndBSUhyenN1RFQyMEQwZWNSemx4cTczcjRKMjdJZm5W?=
 =?utf-8?B?Ry8wMnNOTkN4TUFCM2Y5QVFnOEhQMDJSKzBTdmtDTVNrV1RMSkE3VjVyMW9H?=
 =?utf-8?B?ZmkvYVpVU1NiUVRCOUNHWTFDK0Y1UjN5dUVGOHZpNm1Pak40OWl3QkhwdTRL?=
 =?utf-8?B?U3NKUGExSkNUc1ZtQmcwcUZZaW9GNEM4L1ZwSENYbHZFc1NXOG1xd1ZiT3B6?=
 =?utf-8?B?N09JbmdNL3cvelo3b1JNOC9CSXltWGRjc1haLzlRY2ZzN0RDSFA5Q0l1dDlK?=
 =?utf-8?B?ZStGaDYrSURtVUJpUmZrcFU1ODNkRHdMZEEwV3R5RUJ3SWhaU3RGTWpVbkt1?=
 =?utf-8?B?NjNPME92Y2RPbytWUXhCQkFPcDFlT0NSd0lMeDdoRG5KV21LZHRoQkNYUzBR?=
 =?utf-8?B?U3RCclgycFh6SjduNDY5SkVrbC8zRWtVaUs4K1ZEbzVBY3hmM21ldkczYUQ0?=
 =?utf-8?B?cHJDR1o0bksrZSt6SzhOUEN6R3U5ZCtNTzRad1h5UnJOT1lzSTNuMFVWYVZD?=
 =?utf-8?B?V1paSzB4M1B5b3VGQWduM1ppTjVJTVhWVTBvLzVVWUM5S0RsQVlYUVV6M1Fz?=
 =?utf-8?B?dXFTOEFvTG1wV1dZRGdpaVpVSE1ERGcxa0tnaXpuWWZSTk1DTEtWVWpmRXB6?=
 =?utf-8?B?NzNpNUFBaDMycFZsV1g3TjFuM1BmTWpNRDdnSFlDWGtpbGhGVmVXUTNpS3ox?=
 =?utf-8?B?aEoxRExCREV6THpyejYyNnk0OUVuRVAvc1BYSGNoZEM1OVBQb3NhRWphaVJO?=
 =?utf-8?B?cnlMVkV1djRzUU5qMDZwZFNHTVE1dkpEWVJBb3RvQTRuZFlHSjVSV214bTRa?=
 =?utf-8?B?VEJEZW43ZDV2c2h1SUNoL0x4UXZGamF1eTFOc2pvVW1GT21BL3NpRnMxdko5?=
 =?utf-8?B?MkVRT04yK25CaDY2R2o1K0pnOEtrVW9UL0V5dzA2ZU1TQWJ6eFNqSmdPaFdT?=
 =?utf-8?B?MzgxeXVXZlg5R1dlbHRQVmw3VGlORVoxSnBYWnJwTlhlbm5pMXFEU3lCSDNa?=
 =?utf-8?Q?yR+i8n?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:50:33.0618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54790c57-0c7f-47e7-f354-08ddf1c049d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641

Hello John,

On 9/4/2025 5:51 AM, John Stultz wrote:
> @@ -693,25 +697,30 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  			break;
>  
>  		if (first) {
> -			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
> +			bool opt_acquired;
> +
>  			/*
>  			 * mutex_optimistic_spin() can call schedule(), so
> -			 * clear blocked on so we don't become unselectable
> +			 * we need to release these locks before calling it,
> +			 * and clear blocked on so we don't become unselectable
>  			 * to run.
>  			 */
> -			clear_task_blocked_on(current, lock);
> -			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
> +			__clear_task_blocked_on(current, lock);
> +			raw_spin_unlock(&current->blocked_lock);
> +			raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
> +			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
> +			opt_acquired = mutex_optimistic_spin(lock, ww_ctx, &waiter);
> +			raw_spin_lock_irqsave(&lock->wait_lock, flags);
> +			raw_spin_lock(&current->blocked_lock);
> +			__set_task_blocked_on(current, lock);
> +			if (opt_acquired)
>  				break;

nit. Is there any reason for setting the blocked state before the break
other than for symmetry? The blocked_lock is held and we'll soon clear
it after the break anyways so does it have any other subtle purpose?

Also super silly but that above block is too dense. Can we add some
spaces in between, groping the relevant ops, to make it easier on the
eyes :)

Apart from those nit picks, I don't see anything out of the place.
Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

I'm still lagging behind on testing (Sorry about that!) but I should
have the results for this by Monday.

-- 
Thanks and Regards,
Prateek

> -			set_task_blocked_on(current, lock);
>  			trace_contention_begin(lock, LCB_F_MUTEX);
>  		}
> -
> -		raw_spin_lock_irqsave(&lock->wait_lock, flags);
>  	}
> -	raw_spin_lock_irqsave(&lock->wait_lock, flags);
> -acquired:
>  	__clear_task_blocked_on(current, lock);
>  	__set_current_state(TASK_RUNNING);
> +	raw_spin_unlock(&current->blocked_lock);
>  
>  	if (ww_ctx) {
>  		/*


