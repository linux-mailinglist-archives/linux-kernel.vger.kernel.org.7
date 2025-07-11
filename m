Return-Path: <linux-kernel+bounces-727732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBD7B01EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DC01CA2D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6012DE70D;
	Fri, 11 Jul 2025 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvXkYTKZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA4F27EC98;
	Fri, 11 Jul 2025 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752243163; cv=none; b=H+KHIAYTgN4ELA+mBbjJihiMSLRgHSBnw9UXnZfz512vlCPYIQErIQJlmXfiwF6Nkqn6zCBaZ066gSXHfXMtequxrU4Zd+wrMMMuRI4b1BFgfwlt1PNFVqHIQzjYKAXD6D5Znhaj6Lvr12GNGm1N8GerMO4os9KCscL75W1RSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752243163; c=relaxed/simple;
	bh=U6cxtSHyOQ9QCaoBodqp6zYZ+8VXJFakc92XcJD5XCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iy2RlXxKFK1QaVQXo9xRTgRafMGRGffy/7DSyeZRb8ixEgX39+voQTSKmEPtO6CO11MxrDUUczY3P8od2zGLZ1JZTcjC8jzww3hHrUT9YtRIcIwZ1rveHlevXD16wi1TPVEtdVmRRoYLbsb2EvIeLhFJv/hPWsfBYArR+Kt0wxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvXkYTKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8C3C4CEED;
	Fri, 11 Jul 2025 14:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752243162;
	bh=U6cxtSHyOQ9QCaoBodqp6zYZ+8VXJFakc92XcJD5XCw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MvXkYTKZnshtOXEpmgxG1eAYZ5T4ybDEiM8la83RFl3X+yCJN6HV0lvD4KaKaaCHd
	 4d2/LIbSOq8ePdaTsubspT7Oshhw4WUFejE8+6pqlIczEoE0RU8zohMrMFNLNVGgHG
	 euIHEET071Fy4tEbTspOjxtty7WYLcj23SAUheVcZCOiMucBljX4nGKhj06jkGWGSQ
	 TacqM+6FhnMnSi5N7eNFuS51bSy56ZRTAnE2VJ/Xw45FLGVkhQDfFWp0INvrOs4Bbo
	 1s48fVLYxJr8FQAEpb/FDOyW+na2nnMbg/S0o21vn1jtKmMmDET8Ax1SkUJ/gE/SUo
	 tWZpDtL25alRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EF5C1CE0841; Fri, 11 Jul 2025 07:12:41 -0700 (PDT)
Date: Fri, 11 Jul 2025 07:12:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Natalie Vock <natalie.vock@gmx.de>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, cgroups@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Maxime Ripard <mripard@kernel.org>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v1 1/1] rculist: move list_for_each_rcu() to where it
 belongs
Message-ID: <a90c8ad5-e016-40bc-873b-8bb6e7b8b441@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250710121528.780875-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710121528.780875-1-andriy.shevchenko@linux.intel.com>

On Thu, Jul 10, 2025 at 03:15:28PM +0300, Andy Shevchenko wrote:
> The list_for_each_rcu() relies on the rcu_dereference() API which is not
> provided by the list.h. At the same time list.h is a low-level basic header
> that must not have dependencies like RCU, besides the fact of the potential
> circular dependencies in some cases. With all that said, move RCU related
> API to the rculist.h where it belongs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I cannot see why this would not work, and it does pass testing, but I
am adding David Howells in case there is some subtle reason why this
must remain in include/linux/list.h.

ad25f5cb3987 ("rxrpc: Fix locking issue")

In the absence of such a reason, from an RCU viewpoint:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/list.h    | 10 ----------
>  include/linux/rculist.h | 10 ++++++++++
>  kernel/cgroup/dmem.c    |  1 +
>  3 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index e7e28afd28f8..e7bdad9b8618 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -686,16 +686,6 @@ static inline void list_splice_tail_init(struct list_head *list,
>  #define list_for_each(pos, head) \
>  	for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
>  
> -/**
> - * list_for_each_rcu - Iterate over a list in an RCU-safe fashion
> - * @pos:	the &struct list_head to use as a loop cursor.
> - * @head:	the head for your list.
> - */
> -#define list_for_each_rcu(pos, head)		  \
> -	for (pos = rcu_dereference((head)->next); \
> -	     !list_is_head(pos, (head)); \
> -	     pos = rcu_dereference(pos->next))
> -
>  /**
>   * list_for_each_continue - continue iteration over a list
>   * @pos:	the &struct list_head to use as a loop cursor.
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 1b11926ddd47..2abba7552605 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -42,6 +42,16 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
>   */
>  #define list_bidir_prev_rcu(list) (*((struct list_head __rcu **)(&(list)->prev)))
>  
> +/**
> + * list_for_each_rcu - Iterate over a list in an RCU-safe fashion
> + * @pos:	the &struct list_head to use as a loop cursor.
> + * @head:	the head for your list.
> + */
> +#define list_for_each_rcu(pos, head)		  \
> +	for (pos = rcu_dereference((head)->next); \
> +	     !list_is_head(pos, (head)); \
> +	     pos = rcu_dereference(pos->next))
> +
>  /**
>   * list_tail_rcu - returns the prev pointer of the head of the list
>   * @head: the head of the list
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 10b63433f057..e12b946278b6 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -14,6 +14,7 @@
>  #include <linux/mutex.h>
>  #include <linux/page_counter.h>
>  #include <linux/parser.h>
> +#include <linux/rculist.h>
>  #include <linux/slab.h>
>  
>  struct dmem_cgroup_region {
> -- 
> 2.47.2
> 

