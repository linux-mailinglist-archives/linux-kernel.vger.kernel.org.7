Return-Path: <linux-kernel+bounces-854436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2035BDE5B8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F6CB4F6FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CCF324B1D;
	Wed, 15 Oct 2025 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fLyUy/0h"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A86C3233F5
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529530; cv=none; b=L368xgSLGx9fRL7Ah/8EwUtE+e63tgI8nS/QFOdL8QepoI2zNW3j2e8RZVLTI83guMBHuf+sI5EzOLT7B98YqWLyhVTXGMaYFUlEP4q6h60KwEdqsujwWYm06X6aWAfElo/qUezIagU2onU8nirqZdKM6GIqLiiqYF7gRD8bNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529530; c=relaxed/simple;
	bh=ye+xwhBBi4cjEPVc0W1c1rcFJoISFGbMNnCty7W/1UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK9tUD6heVaAuB0jLErPhzxNEOQ0AyV79+f9kYQVOEVeCbWMIvblJLNArvMPW76VDkOiTr7ZVnYINkywaHxmRWERW/+A1G0rnMNLVTBdkVIyuOTAe3uuxfIptetBH5DEVi3nkh33UDnKJJ6cOKK6qyY1wftuUOr+BYhRFzOybSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fLyUy/0h; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bIIEJOebOM0ppNdAtxycb3eWMKS9DRdGGdDuHgCUEF0=; b=fLyUy/0hKISJCrZEKqkhPqyVOI
	VUQwbvJDSjYeZHz2y7CrmR/up2mcvd725HKwkbMEPTNnQHC5oKEeshYujevoMlgkFUDR984SPM9o1
	YpOgWyWcGuGlAH6x/SvGPsAjJaCeQkX6CJQj7Ga/3fBjNjc3klIo0XLKShw49Zh/KyzIyWsIWurFM
	ld9iVqor1NAvblpSXdji5+ZUY7Is7pcaZ0S/nYEjTr+XhbL6TwImvwQwTzAYxIo48uyu3SqzE6l3p
	yGXvHi8ipLe2/cDNC9HSu27OESSbdAlhHqsP4veAnymdWtWOBzULUc0FY2vo1+CHkBg0+2+8VUdtM
	DjeWwr0g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9097-00000005urV-0zax;
	Wed, 15 Oct 2025 11:58:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C79D930023C; Wed, 15 Oct 2025 13:58:20 +0200 (CEST)
Date: Wed, 15 Oct 2025 13:58:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>,
	Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>, Chen Yu <yu.c.chen@intel.com>,
	Libo Chen <libo.chen@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/19] sched/fair: Add LLC index mapping for CPUs
Message-ID: <20251015115820.GS3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <7d75af576986cf447a171ce11f5e8a15a692e780.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d75af576986cf447a171ce11f5e8a15a692e780.1760206683.git.tim.c.chen@linux.intel.com>

On Sat, Oct 11, 2025 at 11:24:42AM -0700, Tim Chen wrote:
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 2675db980f70..4bd033060f1d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -659,6 +659,7 @@ static void destroy_sched_domains(struct sched_domain *sd)
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DEFINE_PER_CPU(int, sd_llc_size);
>  DEFINE_PER_CPU(int, sd_llc_id);
> +DEFINE_PER_CPU(int, sd_llc_idx);
>  DEFINE_PER_CPU(int, sd_share_id);
>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);

There is literally *ONE* user of sd_llc_id, cpus_share_cache(), surely
that can equally use sd_llc_idx?

That is to say, do we really need two numbers for this?

