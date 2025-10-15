Return-Path: <linux-kernel+bounces-854468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0382BDE752
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1479919C48A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2EB326D4B;
	Wed, 15 Oct 2025 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eeC2HRSB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5448E31BCA9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531163; cv=none; b=i9wnl2h+taTMToP3MUUAygAmx6mtoqWNeRbbliqjz3QyrdpjEPFheUdIb40znMzFSc5PdLBsPMDX7AZbLQxko9pa572+RCGibhjRJP+9waHh94Sa0jinstLnEi3EBiYQjYaMQ/NJXU+kEznsZkDoVQR4fr3yhJdlYQsFxDHnNdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531163; c=relaxed/simple;
	bh=jpfseK+uaprdY8ZL0p8TTiXhMFGbh4cAQgLwmOpcLns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0YnJNLzhho/ip9ZYFcC4soHI3N50s8UZTlRbtEfv7g7aFxvwJ3udrxSYKlLHIGBGGejHPbBpNSv6IQUWfmmNH6ahRa37H6YlFm9Ewu80eE8NBFfQgW/jo85O7jJnzfL1c6Dy9JtaGfFxm2r1+4mdIOOuKNt+NcPNPHiLSnDXlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eeC2HRSB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iNkMpKPkTwguROqmsCXjL/NuyLEi5Ty2e7DdfPmbr2k=; b=eeC2HRSBxlCelM77D/bUKklEyZ
	VL9z96RhdOmOX/AFgA9QnRXKdmDGpGDaISwq41l9+3CkZhi3Hu1FVcbMytBBAzpPUYrkpeOLez8QA
	xEZu/8gzV80Yj1xxvTuRw4baD/rMe6w5mY8PYaGJnChu1wnui1boZ0adjKa0+sE+mssaBiXOF6dkq
	CXss1PBwcP1rdaaFpFWw0+39DsBpU+j5WW0ccv/TJHrMkmBnLuzdiBX5i9jDRtjrVyCKfNLZJRWE1
	/8SyCQBfOEwW+zbbrLP5ACUDaVApxOKQRAr8XANFc8+lBqD5Rq2pIE++5p1pUZIHw5ZIVUT4n8l5m
	G6Nq2fxg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v90ZC-00000005vdS-2c5U;
	Wed, 15 Oct 2025 12:25:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8210430023C; Wed, 15 Oct 2025 14:25:17 +0200 (CEST)
Date: Wed, 15 Oct 2025 14:25:17 +0200
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
Subject: Re: [PATCH 09/19] sched/fair: Count tasks prefering each LLC in a
 sched group
Message-ID: <20251015122517.GW3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <00e5f2cb6eadc3738e33858d3c4563a0775ee1c0.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e5f2cb6eadc3738e33858d3c4563a0775ee1c0.1760206683.git.tim.c.chen@linux.intel.com>

On Sat, Oct 11, 2025 at 11:24:46AM -0700, Tim Chen wrote:

> +#ifdef CONFIG_SCHED_CACHE
> +		if (sched_cache_enabled()) {
> +			int j;
> +
> +			for (j = 0; j < max_llcs; ++j)
> +				sgs->nr_pref_llc[j] += rq->nr_pref_llc[j];

We live in the year 2025 and have embraced c99, please write as:

	for (int j = 0; j < max_llcs; j++)

> +		}
> +#endif

