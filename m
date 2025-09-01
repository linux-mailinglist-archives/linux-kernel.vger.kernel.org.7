Return-Path: <linux-kernel+bounces-793965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EC5B3DAF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8A57AC2E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F065826AA93;
	Mon,  1 Sep 2025 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FpssDubY"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0079A1E5219
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756711528; cv=none; b=TjkRZuqcfKvlIdh4Vg1cDoRNJ/nx+uSQLLjEQLzXa2Ow7Tvn2uCGvPrzyNeM6qfjUXw65u5JX+ugIDO/LhOosqmYDINHTUzIkbcifBixcx+/dj0mfG/s9F/MZEx1bAWXwzJGtk4K+E77b23xvUN+cKDSVOUdBP3kmsqPtzOeXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756711528; c=relaxed/simple;
	bh=U2nu4IulEafUYn62IgqjNZst7UT7N1raYLkqA3hC+VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkxC03QpWiSREOwdZI9PrbY57s0Dp4Nw/sxYr3y5Z/CTSo/ahfSxwtZkPgdewFeDLQvh5Ge+mDj2fVcRR1iTVam4a0UvXOBo05rvqU5zRsMpN2zJVzo3GS7xVuJdeXkilK2Dg9gN5lZax3YK8DFlvqzq7daFPD5Xv6N9vl1aGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FpssDubY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b8e28b3c5so2140415e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756711524; x=1757316324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NsD+lKisfCr+EvsMgdQlQ9bYE75VHiYAu6VA9km9Iao=;
        b=FpssDubYFKkTZRg9gXXX901lRZ8Xd2wUObIavzpYkNrXVgyp35MeQWxYUUyWnpi1Ai
         G0j6C+Ih6vgUGFzTi0rBGYD20MjHdVGKSvcYj9ewWyYZ6grZaeL7rtB0DtXUoqn99WQ5
         1gnn4PkGPF5zspCIMJt8TqrCDpzx6sv/HFFycy/z6o5N5kT+MXImuj67QQTkrWk9WKnF
         mJCMhH4FXAa3yb9oRV0xYv4KHl0ZIxCl/BYKoPQOitcbknJG0O+EbwKg+Klj5DH4OVXv
         6TPRS4ZpkyRU4Fi4ZBbasxbGuW2sxa/bRWWwZofhMVEVxn6AV38E1eMvS0yCCaoIZYU9
         /waQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756711524; x=1757316324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsD+lKisfCr+EvsMgdQlQ9bYE75VHiYAu6VA9km9Iao=;
        b=AgjL+tmsyNRufSWJsTv21p9MHrqIo2eIUWo+0D/O+T6BNWNhBsle5dRFJ5xOu3UPBW
         ko/Dt5q1IXryFamis9IAXJiP2Nq0O6FCcNwkmgkxipfmaVYq+q8kxKZBkxdXkx3ZuCaA
         9sR434tL51yMUAobbkE0bxX7FhUcDtlLthCPo0E7XAwqejukK8so9VO4TyXoMkXplD2M
         f7Woa37Hj8V/ny1bmClaKc1uSU3za8KDt/Kl2hBsCDxIHAMyXJozbeUNUctxV2uyDwMl
         o+SSVZ6kY6b2odEy5FzOHjuF/1EtfKX5CnvsBnPhHEfJ3CW7j/MGUuG+mav3k0VzGYs6
         DPBg==
X-Forwarded-Encrypted: i=1; AJvYcCXKmkJ7F5bQxrkaplq+EjgmyWSsBZOvwLLTgAnHPitT9WLhFiskdeE/F93WP88W1Rwy9FWtB5ziXu/QoBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7FKMEpaHHQgRbnzahq9Y81h5NJn0aLmOL+X7+dNJ7u6NHI6e9
	z/bR7tpMVeFhxTBD1AbpkBC6QVvCOnhe0XiBJqur5BbY5Ztg0r25Yz59YnCEUv4Ql9c=
X-Gm-Gg: ASbGnct2MRVxKYhbCWamx0VdihEAP0M7h4tPcrb8gBNf2hhIXGb/mXEkDQ2WvB7XIFq
	2Y1EAUf3vxf0+HoRR8e+sk+oMnrd+kN5TTeMN34UBqKPAQjtq4o2+XyFO5URUPZ8VGac94eRWMs
	bPXLc5zOirv7C0fnLOGDUzJD6Y/WZH5ATW1Uw+6M/bEaBHY2Sr+u5rhKGy7Km+UljW9BzkiHaf+
	4eNZ6bWS+E42GVzqbYLxgHEmqlDmUT0O8OWLOIhTYsLfW3qX7DZqOlvu9HJQHlmqK19nUgFkbJ2
	5smfuWB5tIsdeRiW5i+fjrkzE35Exlp27sM58AKEc0LJJtvzJgHuzqo/JLENQ5hnEWKvS4eWvt4
	+F3yTKaCZfLZ45jlMcNofQxaZ9CjmYegL7pwnAdtttbad9YOfuSFXo6mE
X-Google-Smtp-Source: AGHT+IEVKsTduRpps36EMANEZSQFs4JECFp/5VO74627zg25yzawH8D3jvfC4CEKLLIvyDxZ2JF5XQ==
X-Received: by 2002:a05:6000:430b:b0:3c2:d7f0:9c4e with SMTP id ffacd0b85a97d-3d1afe48fa0mr5451319f8f.8.1756711524239;
        Mon, 01 Sep 2025 00:25:24 -0700 (PDT)
Received: from localhost (109-81-86-254.rct.o2.cz. [109.81.86.254])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e7ef7cfsm144073115e9.6.2025.09.01.00.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 00:25:23 -0700 (PDT)
Date: Mon, 1 Sep 2025 09:25:23 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: rientjes@google.com, shakeel.butt@linux.dev, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, surenb@google.com, liulu.liu@honor.com,
	feng.han@honor.com, tianxiaobin@honor.com, fengbaopeng@honor.com
Subject: Re: [PATCH v6 1/2] mm/oom_kill: Do not delay oom reaper when the
 victim is frozen
Message-ID: <aLVKYz6C5bXYG1v3@tiehlicka>
References: <20250829065550.29571-1-zhongjinji@honor.com>
 <20250829065550.29571-2-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829065550.29571-2-zhongjinji@honor.com>

On Fri 29-08-25 14:55:49, zhongjinji wrote:
> The oom reaper is a mechanism to guarantee a forward process during OOM
> situation when the oom victim cannot terminate on its own (e.g. being
> blocked in uninterruptible state or frozen by cgroup freezer). In order
> to give the victim some time to terminate properly the oom reaper is
> delayed in its invocation. This is particularly beneficial when the oom
> victim is holding robust futex resources as the anonymous memory tear
> down can break those. [1]
> 
> On the other hand deliberately frozen tasks by the freezer cgroup will
> not wake up until they are thawed in the userspace and delay is
> effectively pointless. Therefore opt out from the delay for cgroup
> frozen oom victims.
> 
> Reference:
> [1] https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u
> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks

> ---
>  mm/oom_kill.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..a5e9074896a1 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -700,7 +700,14 @@ static void queue_oom_reaper(struct task_struct *tsk)
>  
>  	get_task_struct(tsk);
>  	timer_setup(&tsk->oom_reaper_timer, wake_oom_reaper, 0);
> -	tsk->oom_reaper_timer.expires = jiffies + OOM_REAPER_DELAY;
> +	tsk->oom_reaper_timer.expires = jiffies;
> +
> +	/*
> +	 * If the task is frozen by the cgroup freezer, the delay is unnecessary
> +	 * because it cannot exit until thawed. Skip the delay for frozen victims.
> +	 */
> +	if (!frozen(tsk))
> +		tsk->oom_reaper_timer.expires += OOM_REAPER_DELAY;
>  	add_timer(&tsk->oom_reaper_timer);
>  }
>  
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs

