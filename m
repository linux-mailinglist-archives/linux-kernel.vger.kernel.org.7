Return-Path: <linux-kernel+bounces-854768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323EBDF55B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBAD24E277A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D0E2FC00A;
	Wed, 15 Oct 2025 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E4AF2c6T"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC42517AC
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541893; cv=none; b=frGEJX9iT1iWCgGfVDO7uh77CE69zN+FNiHBpaT9YCkNRT6bpFmj2CMh7pUbd7ICLZoBGCZLmXu3L0RTy3LuoXMqGD9xRzMyCop6lT3LVs/OwWG/Ew8VKiRggOTJUXVziKPH9EXDrsjRIjVXyLXF3Sm8wMO34bmq5GDU9+EyimI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541893; c=relaxed/simple;
	bh=R+9xeFP8T9Y1PDPc8AHwS5k4vLdR7rxRhYeU2jVPwFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jx7otr1nC2rhSo3W/BqnxDX7e+tbueWXdbr9C/hrYS01eSILQQE09/EB/gswERmqcfDCr7QY79zY6yRMY/WzanpdvPfVJAwsJT8Q6lmziXRcpO2MGLVa4wmH4ROHUVdM8kTedZBxBXZrvKmxsHqmXIv2pX0R9tyf4Bl/eTecHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E4AF2c6T; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8M2G3XjviaSq0AtCIIi8Utl5wZlVcAd+EccrjLXECpc=; b=E4AF2c6TKEFfMOhJx71+z1jm8/
	+7Ax+h9/m/uIJ3eBkMuZhDOpYDGGZHvEnVYXYlVpuyfnSIEZYYkyTIxRRTYdQc8M7TqJie3VfyY/G
	bksnMRmKzSYQNC81R7rD/G1OXTfBHbKVsbyDGDIwCskVl+CnNDRC1GmdKTotHywCiKbEWbpW4OvzQ
	TM2Boj4IkKZVFS+0akGtsrPsPOsfq67Gy2DgQg85f06hCxYiWd3XwBaLxd1himxQ4DdhoCnMBlLVN
	HzLtyz0cc7ni7konZUszMTjjmqIOfwOWBOITjoNInEzZ1ZDy7rIWZOrdXFP0/xqfh6nVSRsdG7zXI
	AiqUsLcQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v93MB-000000061L2-3cd5;
	Wed, 15 Oct 2025 15:24:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CEFE030023C; Wed, 15 Oct 2025 17:24:02 +0200 (CEST)
Date: Wed, 15 Oct 2025 17:24:02 +0200
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
Subject: Re: [PATCH 11/19] sched/fair: Identify busiest sched_group for
 LLC-aware load balancing
Message-ID: <20251015152402.GE3168635@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <fcdf37780eeb409cf10925f8b8dcef486c92b218.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcdf37780eeb409cf10925f8b8dcef486c92b218.1760206683.git.tim.c.chen@linux.intel.com>

On Sat, Oct 11, 2025 at 11:24:48AM -0700, Tim Chen wrote:

> @@ -11035,6 +11059,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	     sds->local_stat.group_type != group_has_spare))
>  		return false;
>  
> +	/* deal with prefer LLC load balance, if failed, fall into normal load balance */
> +	if (update_llc_busiest(env, busiest, sgs))
> +		return true;
> +
> +	/*
> +	 * If the busiest group has tasks with LLC preference,
> +	 * skip normal load balance.
> +	 */
> +	if (busiest->group_llc_balance)
> +		return false;
> +
>  	if (sgs->group_type > busiest->group_type)
>  		return true;

This feels weird.. should we really override things like group_imbalance
or group_misfit_task ?


