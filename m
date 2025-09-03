Return-Path: <linux-kernel+bounces-798503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53787B41EEF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9A017982D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575892FD1D5;
	Wed,  3 Sep 2025 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GzP1nG2h"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4622FD1DA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902471; cv=none; b=iZX8aRaNAKPGXkS6s1hxAw4riP1XFP3YGpTX0pAxbvJKCMulXTrD7yiqkt7WdywUhcJM+odMnpLmA1XDlx4wLnAeUm1UJdDARUfvxJOn3sY+KBLenjpDScgvigCO60DTpVkWAkHVRSX5ND05kqpfMmtD8nM8/hr67vTdv3v58dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902471; c=relaxed/simple;
	bh=E+QiLggFkBTE8pLC5tArrdCwRZegV19hpyJXfZveTPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpBvviw7VqX/zgL7noKrn7SNGQJb4mtahxeSDFMVUdoW+ZZSIdj2Au158y84SypRT7K+0FqQVst6HzsE/IxBKQwFWmEnQBRPUSIEHe2Qe1fKHa/ITXy4Lra7UjcA7QsxXpMsAVackeYA5uYzVqVEOWTCGEezXNEVIAip/BEP6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GzP1nG2h; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso4137506f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756902467; x=1757507267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow89xrjnsbNKNS24LObxWfvrCfFy+ufBe9CUqvS3aF4=;
        b=GzP1nG2hkZuvSWSt9Ry4tCi/UUVlC9mL/iNIQDgVs7mSbKBpnvYkgiVj0K6rppXVLD
         bXplsPyvwjFDuWjY5IGNt6cB8bFMyKGhMpGocQHQn4QljzchbevN61ljyz0PY4vkPy9z
         83l/lXeRx1SJr4s4cuw8tUwxtUYIt8oimYlgkyiSDrxdfPXWzBu6fCxU37acxU/UXMs2
         910FR7T7QHWgkB0JpsZknhcqBsFWTW/KXcRTGE3JugwT2Gd9cVxuXktZiFdW+Kox8pAo
         UH8FShr6HqdzRc1bDwkllkMDzwboIaCivzAqDLmFBCu3TGzYI2tCERP0mwRcAkMK8vKO
         QdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756902467; x=1757507267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow89xrjnsbNKNS24LObxWfvrCfFy+ufBe9CUqvS3aF4=;
        b=fRqrAA2qhJFBQqVtu5sh8S1hpn4TrBRYikZ/2i/JqlQoBhocVu9ZjXG9xS8Fu+ZuoU
         r59YXog8zG2Gp09/FzxYLRxyU64uHjlcQxzAAunFZhPHJcScqBq8oiLeIxxK42HJjdDp
         ynVP/nEjo3nVwBHnAoyTVFKdp/ncpnIdqFhjN911swd53Z9AIV+QKuvdEwESPTBCfBmT
         ya9IwcbcTfBa7bFvaBHoP/xmFjTVHx8Y6I/pr6dQYzn4A1AhVymvy8RWDKj/EX1BK6cp
         ww1toCSPcou1wvcOul7g3HAl15VQJir4ZZ5w/FsLxxncQol/FKQ6wSukMzPb1OCn+dyr
         aXtA==
X-Forwarded-Encrypted: i=1; AJvYcCUJKenbI4uCS7Jir0RuUgevjV5cNxWsX3Kc/xNaHoUWHI+uWXocMJpPzzAGQPTNva2lWHEiiQln1ljNKq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKcJ4ObzCHDQygeBe7ODTqtbSpAVOkOuIIy4SSbTLQ83QHfmEE
	bjwqe93YvDzV6HbufNGmcCCCy1EWYvB2/m+gG+izxAQlyHFfXw1wBsUj4ADsOp1eLUA=
X-Gm-Gg: ASbGnctiQJvBV6NpC3TU9EvhbzyNCDd6JceSrIuBgUKZMbWtUv9ry8tVAn7CaMozlFt
	NwlECfr5PPouqzaE7jOpngWKA3JNw3CzuYGqtS8tJYTkbPS3kQHEZG2iGHXsipnNPq3g7twZhGL
	pWVc/4iq0m6pRGgapZX4PYizwvyt+1689EG7H3ohc2NFxcJjxCKGB85WVlnyy+6r7oCHKgMAgQz
	be1QDKDmYzF8PcRsoBdKTjFxijiBbgVn36MvpzoMXkBXLT5DfqwwGW3ExM92CcsT5LwptHXpW4Q
	QC+c7UIoUjxCGFlgYte5VpiuAeiBsx4EBTM4bHeA0GCmTwghh3wODMmwuXQH1BhOQa6YPOiHKJU
	xOenoASaz3n0aY0NrrljdfhWYbU4UnjOo60B6Q/Qu6WylMA==
X-Google-Smtp-Source: AGHT+IHU4yMyqQulSlJlrYj9+G4ULF7MakFGi0tAtaV3rKdWzPVcIYjLJfUJpv+mJdgP3MWvAdEV0Q==
X-Received: by 2002:a05:6000:1788:b0:3df:c5e3:55f4 with SMTP id ffacd0b85a97d-3dfc5e35d8cmr342968f8f.6.1756902467402;
        Wed, 03 Sep 2025 05:27:47 -0700 (PDT)
Received: from localhost (109-81-86-254.rct.o2.cz. [109.81.86.254])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45c6faad9cfsm44331935e9.0.2025.09.03.05.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:27:46 -0700 (PDT)
Date: Wed, 3 Sep 2025 14:27:45 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: rientjes@google.com, shakeel.butt@linux.dev, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, surenb@google.com, liulu.liu@honor.com,
	feng.han@honor.com
Subject: Re: [PATCH v7 1/2] mm/oom_kill: Thaw victim on a per-process basis
 instead of per-thread
Message-ID: <aLg0QZQ5kXNJgDMF@tiehlicka>
References: <20250903092729.10611-1-zhongjinji@honor.com>
 <20250903092729.10611-2-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903092729.10611-2-zhongjinji@honor.com>

On Wed 03-09-25 17:27:28, zhongjinji wrote:
> OOM killer is a mechanism that selects and kills processes when the system
> runs out of memory to reclaim resources and keep the system stable.
> However, the oom victim cannot terminate on its own when it is frozen,
> because __thaw_task() only thaws one thread of the victim, while
> the other threads remain in the frozen state.
> 
> This change will thaw the entire victim process when OOM occurs,
> ensuring that the oom victim can terminate on its own.
> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> ---
>  mm/oom_kill.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..3caaafc896d4 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -747,6 +747,19 @@ static inline void queue_oom_reaper(struct task_struct *tsk)
>  }
>  #endif /* CONFIG_MMU */
>  
> +static void thaw_oom_process(struct task_struct *tsk)
> +{
> +	struct task_struct *t;
> +
> +	/* protects against  __exit_signal() */
> +	read_lock(&tasklist_lock);
> +	for_each_thread(tsk, t) {
> +		set_tsk_thread_flag(t, TIF_MEMDIE);
> +		__thaw_task(t);
> +	}
> +	read_unlock(&tasklist_lock);
> +}
> +

Sorry, I was probably not clear enough. I meant thaw_process should live
in the freezer proper kernel/freezer.c and oom should be just user.
Please make sure that freezer maintainers are involved and approve the
change.

-- 
Michal Hocko
SUSE Labs

