Return-Path: <linux-kernel+bounces-841187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D191BB6714
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E0B34E54C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB73A2E9731;
	Fri,  3 Oct 2025 10:28:58 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045AD250C06
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759487338; cv=none; b=C0cSoW1V5YDV2yuHv4ZpFdHuZKs7f1QxrhXR/OPT91iKw8o0hi+EKtoReNwksHjjVUO8wC59JYXBBocmoKLoQSClthxndM4fwzChaIBm25F30PjSE3YXsnEIqAxUSEsJr8t9ZvAmJkPscVsnRhpFcLAs5T43kYo4SCwAnK9ReSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759487338; c=relaxed/simple;
	bh=WgGLPe0xWAlQuEyjiZF0krcAuIoconm8EYGqulml/Q0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=athhQvw+MpgxqY79cwiWQE8MiDXwMzjgxz4I+zfc3djHdSdXzYe9yjmv/KAXc5u6oh6MNa5faG4e9BYFovnvO9ndZwFEaKRJUWkeNnkiYIZJ6gN0RRqlMI4EC9TvKKb3MuvDXGnkCDsWejMY5VhQATW72o1kVNxTTb9kMx09glE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdPwB1qVsz6L4w4;
	Fri,  3 Oct 2025 18:26:34 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id BD87514010C;
	Fri,  3 Oct 2025 18:28:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 11:28:50 +0100
Date: Fri, 3 Oct 2025 11:28:48 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Michael.Day@amd.com>,
	<akpm@linux-foundation.org>, <bharata@amd.com>, <dave.hansen@intel.com>,
	<david@redhat.com>, <dongjoo.linux.dev@gmail.com>, <feng.tang@intel.com>,
	<gourry@gourry.net>, <hannes@cmpxchg.org>, <honggyu.kim@sk.com>,
	<hughd@google.com>, <jhubbard@nvidia.com>, <jon.grimm@amd.com>,
	<k.shutemov@gmail.com>, <kbusch@meta.com>, <kmanaouil.dev@gmail.com>,
	<leesuyeon0506@gmail.com>, <leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <nadav.amit@gmail.com>,
	<nphamcs@gmail.com>, <peterz@infradead.org>, <riel@surriel.com>,
	<rientjes@google.com>, <rppt@kernel.org>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>, <vbabka@suse.cz>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <dave@stgolabs.net>, <yuanchu@google.com>,
	<kinseyho@google.com>, <hdanton@sina.com>, <harry.yoo@oracle.com>
Subject: Re: [RFC PATCH V3 14/17] trace/kscand: Add tracing of scanning and
 migration
Message-ID: <20251003112848.00000cbb@huawei.com>
In-Reply-To: <20250814153307.1553061-15-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
	<20250814153307.1553061-15-raghavendra.kt@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 14 Aug 2025 15:33:04 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> Add tracing support to track
>  - start and end of scanning.
>  - migration.
> 
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Masami Hiramatsu <mhiramat@kernel.org>
> CC: linux-trace-kernel@vger.kernel.org
> 
CC s are part of tags block so no blank line.

Probably move them under the --- as I doubt we need to keep these
in the git log long term.

> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>  include/trace/events/kmem.h | 99 +++++++++++++++++++++++++++++++++++++
>  mm/kscand.c                 |  9 ++++
>  2 files changed, 108 insertions(+)
> 
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index f74925a6cf69..d6e544b067b9 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -9,6 +9,105 @@
>  #include <linux/tracepoint.h>
>  #include <trace/events/mmflags.h>
>  
> +#ifdef CONFIG_KSCAND
> +DECLARE_EVENT_CLASS(kmem_mm_class,
> +
> +	TP_PROTO(struct mm_struct *mm),
> +
> +	TP_ARGS(mm),
> +
> +	TP_STRUCT__entry(
> +		__field(	struct mm_struct *, mm		)

Trace header formatting is sometimes interesting. But I have no
idea why you have this padded like that.

> +	),
> +
> +	TP_fast_assign(
> +		__entry->mm = mm;
> +	),
> +
> +	TP_printk("mm = %p", __entry->mm)
> +);
> +
> +DEFINE_EVENT(kmem_mm_class, kmem_mm_enter,
> +	TP_PROTO(struct mm_struct *mm),
> +	TP_ARGS(mm)
> +);
> +
> +DEFINE_EVENT(kmem_mm_class, kmem_mm_exit,
> +	TP_PROTO(struct mm_struct *mm),
> +	TP_ARGS(mm)
> +);
> +
> +DEFINE_EVENT(kmem_mm_class, kmem_scan_mm_start,
> +	TP_PROTO(struct mm_struct *mm),
> +	TP_ARGS(mm)
> +);
> +
> +TRACE_EVENT(kmem_scan_mm_end,
> +
> +	TP_PROTO( struct mm_struct *mm,
> +		 unsigned long start,
> +		 unsigned long total,
> +		 unsigned long scan_period,
> +		 unsigned long scan_size,
> +		 int target_node),
> +
> +	TP_ARGS(mm, start, total, scan_period, scan_size, target_node),
> +
> +	TP_STRUCT__entry(
> +		__field(	struct mm_struct *, mm		)
> +		__field(	unsigned long,   start		)
> +		__field(	unsigned long,   total		)
> +		__field(	unsigned long,   scan_period	)
> +		__field(	unsigned long,   scan_size	)
> +		__field(	int,		 target_node	)

Similar. Aligning stuff might make sense but why the spacing before the type?



