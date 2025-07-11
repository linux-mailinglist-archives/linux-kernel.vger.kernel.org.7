Return-Path: <linux-kernel+bounces-727252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F989B01729
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FFB4827BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699F721B9E5;
	Fri, 11 Jul 2025 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gg55oUGs"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF4D1F239B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224678; cv=none; b=hpuo2C6LgZ1jw4h0ar9/R7iGeXtjAWrmyMeDkSyaZmgQcUyq8SZfcA3mBLr78KMq0baUABsgm02sjR4lSuYsJNZnCb2c0em6/TgMs3B0Y76GRVYt5rqSI637T0nJoQ1LtnNx3gmBTc9eD56Fc4CSjzQkkTKH6saku8nMTLZhRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224678; c=relaxed/simple;
	bh=04wwIYzCyIt0hPLEgF4ULkMM62+IXa+xFlcJ6oiE+cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvjruzS1VDSXUTe+5VcQIQAqBFeUqGXmdX1LHUEdnJPFpydVlvBtGrEH+SMyuGHj05yMNFG6lcJ9bxp3wXjjNsl32Ey4EclZ4JF+QIrNiDr/ABoDhhjzTdO+xEib3M6/Kg93AFLH8urUaIke2gMDq8vtMKkBLoPm26stApuur/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=gg55oUGs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-455b00283a5so1835945e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752224674; x=1752829474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azkWYqIfD0IX3c6trMXIH2mHQXBlbPclhfsws1MJpdM=;
        b=gg55oUGs7irbUWBzIK7uVqa3q6GCgjQB80JZQpOJ8VJVKu16QCn/DNCSwGR8Gh9rTt
         tV1zX9x1ljoEKhveL1K3P42TbOo0j58IiAXheMSp/AN6+uQnhx2SekEGQmESDirvUHyJ
         tOXACWD78hml+QulsKN4kaVaDWZ32dvMWPBgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752224674; x=1752829474;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azkWYqIfD0IX3c6trMXIH2mHQXBlbPclhfsws1MJpdM=;
        b=qAAoKU+fTDnwMjQu6328ouMr6iQTAS/6IW1+tRZUuJwdvXv6CSXzNqpDe6lul9ZSA1
         /FaQPB2VaBI1Zdr3M2YwEQDMrInVzWn06aGhDD0sn/NyWCbn8Wd+dH5kR/QhNp7upzIv
         c6G6b+bhismeixeEjl7T/g9OG2Gj6vvpp9HjWtYc6YrW7nok4e/Q5ZgVe+o+XwxLPP+k
         kTDVGG1Yq3DSaLPfdVZsPsZ8ZLlYVZRJNJ6upkZcA7T6cu7lsICgw0YQW5Is2OhcPUd4
         H8A1vmtdimfOj9n2ld93fU9gy4mW0/4MdbJ5nUZktc9YobItxOMpxhMM6Ih1D1ZZpxDL
         wc+w==
X-Forwarded-Encrypted: i=1; AJvYcCV+kwQDlQqFuCYULGE0GXsVO40O6fDwJnPwH8WqM6+KgTqaSHoWFyhWgtzESsk69q1JXJ7IOLCjJqST6Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0YhX2uCzhHIJkJic0mKyxrRy0E5bLFanxWGZkIcRfzVC/nbOZ
	NU1UkMe0rnDHtGw2lCXtwzw/yVpr/Qut83kmc8WNTNPy1fGVaxeA+MSGC+3v/HS8Z4E=
X-Gm-Gg: ASbGnctPH2X3+BTJvp7E6vOYWh0miEIEb7z369h5pMghMszBUydP+aWfbXVpsrNDg+I
	QsRd2z0SgSz/r0RuygVEgjUOFlTTc0PJzu+o+I/G6mjZmn9cIlD9+CoJJFJYHAlJHmlhrSFVlrf
	mwldKo9esEB1ABgLBMYVeDjjeunOShM738XrwKFhIxxjAeijHWdMqDx0gdUc+A2nimsp/QFL0zL
	awJJQdBMGJBOUsdlEoWtXMTN2DPgJEANG7KK6fcfv0ao00CDZ0LRnF2saiVI16Ti5XWty1x4+VK
	t539T1FA60McYi8t/D7IQ9b4G2bv6w+DYw446+TP0R6VatJPdb4IxxbDc3QiLDtFerCXwN3QMdK
	ZGIVUwwE3/zTDpmFu92DGarUWIEpE5nAd4w==
X-Google-Smtp-Source: AGHT+IFGUXwZZxphgJZiWA8T7e58NqagXtzk90hoNDnBiUkxa4v1W5VvgPBRSAu+F+hnZton6PqeNA==
X-Received: by 2002:a05:600c:6095:b0:453:c39:d0a7 with SMTP id 5b1f17b1804b1-454ec15a9fcmr17912895e9.5.1752224674202;
        Fri, 11 Jul 2025 02:04:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd55b1absm41564565e9.40.2025.07.11.02.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 02:04:33 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:04:31 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <aHDTn5JgXOpiG_zd@phenom.ffwll.local>
Mail-Followup-To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
X-Operating-System: Linux phenom 6.12.30-amd64 

On Thu, Jul 10, 2025 at 03:15:28PM +0300, Andy Shevchenko wrote:
> The list_for_each_rcu() relies on the rcu_dereference() API which is not
> provided by the list.h. At the same time list.h is a low-level basic header
> that must not have dependencies like RCU, besides the fact of the potential
> circular dependencies in some cases. With all that said, move RCU related
> API to the rculist.h where it belongs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

Also ack for the dmem part for merging through your tree.
-Sima

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

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

