Return-Path: <linux-kernel+bounces-816461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 840D7B5740F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EFBE4E189E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74BC2E6127;
	Mon, 15 Sep 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OCowR3rv"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5D3D984
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927108; cv=fail; b=R1aryUOZLUiWohtyzuNlh6b7H13VvOpcKWST/mB5sG76hOaoxt91qc090C4CpUyzie10G5nKwADnKRDR7k65vci6v6YiiluvRNCxMO3m2K6SPl5uh7Avt3Zws4kNi2Yxmg/fmdzLeknESJZCAt3yoFZ4U4yXU4l1FzqKbSvYJzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927108; c=relaxed/simple;
	bh=QoAA1WpmisEA6JLBWpL1hY0kuf8vOPuyLvqGuk6DDyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cGgO7fNHF/3f9mfIVc9tNr2XwrqaRP4qdnxW8a1c1veaQtBtVxEZlWNr2hCiPcHefgNV1zDSUkzwacrKnu1+e9GTFk9v+ug2IM0zYMspcSSLTDum5QBh5GnMAEnmoWbO69O6jTqVYgTB7JdFrNy46LXC8ggN3vvNepQak2lIcko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OCowR3rv; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pV67l8EZik8rrtjHDo6YTK68+/K7Jm/hFg5Qa+0gzgAcd+ANSk39U6PrYL8BGJ8WslqLbdPgCW+L77vrLxWIwZ7UwYEUdNZ5BUe9j6ptdW6ZgyhpBkILkORF+shX0LlMoMaW/P5aBcKAZX2TT760ZuKaRIqTy47FRkmOV88AGOjMJdxI4Y/VBW1D+7PJGRN4l4IOTw+yA57Nk3EPeTNZCRagwH086+f69sGTWLdmiO/hjyjtM8fk+vQAGASerYEhOQDp5mCXGeM6MmmEpFMxQZGWqoKAqJNscX8ygtrZJYwYbBZY0/PzzwgBwpjr5nSFsqnu5xFSLYvvF8vNLTfBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nk5XX5jRuj5s3JaCeBrALyrmDwnvjg8X6ErimcIolAE=;
 b=ACXu3XLV+K9Nwe+raGwSoQdTI4r+MDuCQNzLRjM/z1Mc57vbKoaGsdaTpwzCBd0SLSvz83XYxQ5U4qkBwIr1f0ezr5hQkHq90OFQUWCjndfBz4GufJjR9iz7VglMvfqJbQU8s0TO+jW7E1oiECsPMFMMK9yPoKOm6cM3nezh3IIUnh8JSgTJ8E4l8XGpc2atnm7ReQyPncm0sDIZScU+xOU2GQxgGgsF6o5lJcc82afoqu1rLTdkRDrKmG1hCFv93n9B4QnmzrrlHaFC45ECMRUrYtAAfLR43YCXdhtVTL9gwIvvrkxzfU4u6a4tZrXGvuy2huDoHCg/P/qF5iysFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk5XX5jRuj5s3JaCeBrALyrmDwnvjg8X6ErimcIolAE=;
 b=OCowR3rvietrfzUkHY5eV37S8QPLGqnNq4IWdk+mQM7LFtVGM9b+jIeZkuVFjrsUc2ZfLEFbFLdBUuot4Ngq37fNZDG5ySoqvkxblfogTi98SAGmvzSyVl6VnbiBlJ8elx81ijOxpa6ZjYcQ7WNhkqxVzZOW9GS/raKvGAGLC/4=
Received: from SA9PR13CA0180.namprd13.prod.outlook.com (2603:10b6:806:28::35)
 by CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Mon, 15 Sep
 2025 09:05:03 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:28:cafe::37) by SA9PR13CA0180.outlook.office365.com
 (2603:10b6:806:28::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.9 via Frontend Transport; Mon,
 15 Sep 2025 09:05:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 09:05:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 15 Sep
 2025 02:03:41 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Sep
 2025 04:03:37 -0500
Received: from [10.136.41.20] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Sep 2025 02:03:31 -0700
Message-ID: <7bead244-f366-48dd-aae4-380d32de173b@amd.com>
Date: Mon, 15 Sep 2025 14:33:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v21 2/6] sched/locking: Add blocked_on_state to
 provide necessary tri-state for proxy return-migration
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
CC: Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
	<vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman
	<mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan
	<xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "Daniel
 Lezcano" <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	<kernel-team@android.com>
References: <20250904002201.971268-1-jstultz@google.com>
 <20250904002201.971268-3-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250904002201.971268-3-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|CH3PR12MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b7b255-4f4b-4059-f715-08ddf436f4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXVVT2VjTXJPTG9GZDdzYXpud2Z6SHZ4bzN4RDU3SFI2VWdsR2c0Z3Exazhz?=
 =?utf-8?B?NnZleGhvT0tvZ2QvcjltWXhSS2dXbUVOSFFsQzNCSnBvWmNtRU9uSGlaeTda?=
 =?utf-8?B?aUliSW1wcXdaNE5WdDRUaC9NNEdqREQzR2Zab28yU3hiREZYNjFTcnZWMXNP?=
 =?utf-8?B?Z1JvQUFTTm1lVDIrVENMVUdldVcrdHZlKy8rS2lwYWxNMGlvYTM1ZEtVN3FT?=
 =?utf-8?B?WnpOVGt1alozM1BQRkQyNWRWdys0UHZvUlJOVVZNUThCSVNxWEpNZGtvazhl?=
 =?utf-8?B?RFdZcWowend0ZVdiTUlOdm5hMTB5T3hiSzJzMld4U1FnWXBMVE1zZVhNdGZQ?=
 =?utf-8?B?eE1ZbzdpYW5NamlJUmdHZmxrZUo5SkJDVUlDUkN3L0JzblIvL25HYjQwcHJR?=
 =?utf-8?B?M2srLzFJUzRIb05xQjVlZmxDQm9zK21CUUF6aHBmN1NuRVpTdlZDTUhxMUlz?=
 =?utf-8?B?SjVyZ29hRm9lZmcrVDRzZXVvWG1rRFY4eTIyVms2bU03VnhlcDhQZTR0am1O?=
 =?utf-8?B?ZXRrbkc1V0lKRzFWN3VMbFVpQWVZVGVhZ0wvdm92QzBvZEoybnZyMFhFb3BN?=
 =?utf-8?B?ZFBRSlY2S3BFTU4rdlpoKzZOWGJPWTVoa2JNdmpGT1RCVnpNQm80N2MwY05P?=
 =?utf-8?B?WWpnRmt4dzdGUWxSU2huOXd4cE5naFc0amlRaHJmNXkvdjQ3dHkxNmpoOCtx?=
 =?utf-8?B?aHoxRmp1ZEFDTHc1RDhPcGJYcUREc3lMSWV3NzQ3K3FVLzk4MVRKZ2VaZmlj?=
 =?utf-8?B?VUJzaEdyR3VZQjNkYnltczBNTk85a1IzNFhEYVNmdEo4VC8xVmlGV1ZrRVRR?=
 =?utf-8?B?RHBtYUdPckpTYkVJR2pxZENwamMxc040VHJEYXZoWDA4MXJIeEFzUWdEcUh3?=
 =?utf-8?B?Uk54NVhXMHY4emxya0pkQ2RYWmJvTEZ2NXB4RFVxUVpuUndFanpsaHFQRDFG?=
 =?utf-8?B?RW9WcFJFOVgxMmN0WnNRT0xlSU15RWhXYXZkdS9uZXIxRGFtZnRqOXdVajZv?=
 =?utf-8?B?WjRNM0JsUmJoeXZTMVJNZlBobzAwYjYrWCtTUnlrTk82ZllWSTlaU1M3cGJS?=
 =?utf-8?B?NURBNjFQSnFhQ0NjSy9DeFZwRG9mWW9qUGJ0S2h1bjI5eUVuTTFiZm0wZkVJ?=
 =?utf-8?B?cnAybjRQNjZVQnZFaVl1c1hNN3dDUituVGs1eXljQXBDZ0NIK1RSWjRSdGp6?=
 =?utf-8?B?SGQ1dXdKaDdNMGZ4SWs2MWMzWFkyNk1EVjVOcWFvV2VQOTJMMlNlRG5nK2Jr?=
 =?utf-8?B?U2o0dkpGNXZibVBnSUFPOGNzaDNSOU8xeFRVbzV4RjJJNG8vbjJVYjI0TGdM?=
 =?utf-8?B?V0k0Ly9nNXJVQmo1RWFLNzhpYm4ydFNWOWthRzRGWEU4RGl2c01HNHVkK2hu?=
 =?utf-8?B?UzVFd1ErVzFRaXZxeitaNDhLVm9PQzRUaC9xaUY2c2hlOHNKKzgwMkQxTTFE?=
 =?utf-8?B?bUhEam5ZOWpkdlBwdmNXQUxpOWczblJGMjY1Q2Y3VS9QRmdxbXowT2FHbEFo?=
 =?utf-8?B?b3dtRWR4WGpFdEcvd0VPYWhaeU44ZUV6QVQ0UnlsclM2dkVKWVl4YVBxUHc1?=
 =?utf-8?B?QTh6NjRpc1V4dGJiM2JKR29PVHI4cmdLckt2VWMzbGVPZXBJN0RvRjlVSlRK?=
 =?utf-8?B?MWFQeHdWYjB0cndDUFZqbXk3MkxkNnFmUWVXS2ZNb2hzU3Q2ZnZTbURTak55?=
 =?utf-8?B?RlVmd0VTSUZHOGR4QTNwS1JVVktvdVlZclltQ0wvbkl3WE81d0JUQ284cExx?=
 =?utf-8?B?VHJrNjEyWTlPdnluOTZxMCsvU3JRWklDRy91RUpwUXYwL1p1eXFvYitvMkNk?=
 =?utf-8?B?NmNsNzgvc2ZjckI0NVNvK2VnejUwbjZDQ2krOENxVzdRQXg0WnZOWUFMZzFX?=
 =?utf-8?B?UkxRYlRBRG9QMGlpVEpmV0dFVVowUHV3bW1aa293c3hXN0tNNjZyOTFUTnpr?=
 =?utf-8?B?V3NHUE1ZbGdUcXN2aFNUc0dCYlZvQ1M4VG5uTFZRRkN2VTdXNDYydzdnS2sz?=
 =?utf-8?B?QTNmeUZaTm5wK0o1NDVqQkl2TWIwbWs3Z2o1ZjF1TE1uNW1OT0JIcjhWdVkz?=
 =?utf-8?Q?s35Nl6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 09:05:03.0107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b7b255-4f4b-4059-f715-08ddf436f4e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080

Hello John,

On 9/4/2025 5:51 AM, John Stultz wrote:
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -815,6 +815,12 @@ struct kmap_ctrl {
>  #endif
>  };
>  
> +enum blocked_on_state {
> +	BO_RUNNABLE,
> +	BO_BLOCKED,
> +	BO_WAKING,
> +};
> +
>  struct task_struct {
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  	/*
> @@ -1234,6 +1240,7 @@ struct task_struct {
>  	struct rt_mutex_waiter		*pi_blocked_on;
>  #endif
>  
> +	enum blocked_on_state		blocked_on_state;

Is there any use of the "blocked_on_state" outside of CONFIG_PROXY_EXEC?
If not, should we start thinking about putting the proxy exec specific
members behind CONFIG_PROXY_EXEC to avoid bloating the task_struct?

-- 
Thanks and Regards,
Prateek

>  	struct mutex			*blocked_on;	/* lock we're blocked on */
>  	raw_spinlock_t			blocked_lock;
>  

