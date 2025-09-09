Return-Path: <linux-kernel+bounces-807662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A97B4A7C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2303E5E1511
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A7A289E06;
	Tue,  9 Sep 2025 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PIyMysj3"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A55288C96
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409351; cv=none; b=JF6uReP4OxszJDpyciPsn1lRJse0Z6Zu8KqPpJKhivBVf5lRMCt/bHZnTbEoI3Wfsqjl1v2SmIgC546zjLU5FIqrFCk4MxEzXYcGxI17/AU3iDCO4helk1adFT32CTG4RFU7pNNWQYBnb6ShlmliVo4ek5B6bQIRjMQPyP0CPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409351; c=relaxed/simple;
	bh=lA3Sef89UxhD96LIqU14KJgSsxI2nu11zjoqrGnvJhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTL+6kgFcV9hSpf39mHgMm6KFB0vCYCxIA5kxgrWX7m0i5beErtzcX3dT+6LShiXqluHbgv7sBJRWcIz7j2XLRTrS5t7sFhA+C4qDKZKx6zbWbIuQ2D+kM76469FXotaOKFx+JlhTBLRshX6XSR3HtArWqKRwC+3xkTuY+8lTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PIyMysj3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b04ba58a84fso407132966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757409347; x=1758014147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wyBfzXieOB4BKjRhG36VNeBbb5dfQQ18kcUJJo+HeI=;
        b=PIyMysj3v8aZhqBX1vhj3O4t7W/Vb/XanqhaMHs54kO6fn8DJNv3OU46ArFb5PDXpM
         veVGiheYjBgAkKMQ4klKDxYP83C/d+LglcfHOj3cHsRhg0YUWmDnwqkiQzOyMcRkMjd3
         C5lSs9+8L1k4HE3oTR02CbaGWniKc+mj1mLytKtodjnwfykDID7Radnt9TdJ9LUlTwvH
         VfvPu1fj1hi+SsjQ3DRQPcwVNmvi30VQGJ1Zu3A3ZLO7LFgn/hsQcZi27x5R9v+2rwcb
         4KcDK9J5hySef+T/OJEahX/4Zl0+dpZfnYnh7/A0zg60RYBjsVgEvccWUmxGXPgW1Kyf
         M/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409347; x=1758014147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wyBfzXieOB4BKjRhG36VNeBbb5dfQQ18kcUJJo+HeI=;
        b=jjKY9X6OWDFAH/rNGqnG2zNwRzuwCSa3TXW/MAQL2kRDobRSpK6EiL8aPGpdCCZisl
         GPOvLyal+b9zrNdm9idxneYMsj0EeoCtUQMqkrSj6uhDfqh+BFzk7vmq0RQJuxCqUe3M
         9zZAkL25o9cInqPLl9GrRc5RjzODt6njI1NX5k/bSBmdDe0vwj6UnsbDHJZfS4wMkn8b
         Rw8WpEe/rnMGL2UTwOQh3XjjG6bmqSnuICyRu2+hYdBVGitfPNB/iesZEVMxOg/9Mrz5
         +THdMAKRUFgyFgsDjRIJLKwm2l52XAbDX3/iC56mEUYXgLPq/w+ZNz6Wm6ZJZQ/If5J5
         BRXw==
X-Forwarded-Encrypted: i=1; AJvYcCXMLSQxnfaMdikHTne2hxGWO3hoKiGzlsIolH/d2TGWtwHvuj4Z195UtJ/ZudSG/Mzv3BJiR6d4Tz+y0Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU8P3vNIMnw3iNbm545bPKksqO51aw1iQcd4thqbJ223pm0UpT
	baad1Vr1uRXhH8Va8o12FuZP65hqzAiskunMz71wvq/HHBYhBS29PkHj0QJ4uG7V05XSgi43jcM
	1WiwJ
X-Gm-Gg: ASbGncs/AwbD3FTvLO29Ll6faqtSO+9dPugt4biNaF77tonL3rM+m9jqH+b9G3XS0S9
	ELzvBavc/6icvDH/Xkmk3HSYWbM3g/mgXAyxSJGlab/B/oqndaY9xue/qd/fRtEyOTygu/AuQBD
	BxCHl3TaJnvuotJ3/NwjJMdypX7MjO4F4ahoY99RvA8+MR4ucDnsOlgsTKVv85gIgks2+j3PSIw
	wyWlIiZgQYfsgPPa4doBIOeccIi5nmAMMIS2cu5M4y7emcfGV7qFUhVUzwWW0Rlvu0O2K8GExMo
	2zh9/JDai4oAes19fIuBgqs38JXhu2RCDmRtTCKC+oQ+umGqIYsryBvw1BvQ4E/7fHxu/SgoEtw
	3nLJiRSZgG2qGTB0yeECGXgkzQitg5pIr5GrDpYQnf11TvtcyaD5PHUY=
X-Google-Smtp-Source: AGHT+IFUomSr1Edwt6q9MQDVZ8nWTr0HkefRKWchKOMD/D/mp42AWKlgEJvjm+P3vDEQZ3SMoB8W3A==
X-Received: by 2002:a17:906:9fcb:b0:af9:5ca0:e4fe with SMTP id a640c23a62f3a-b04b179c35emr1088210266b.56.1757409347400;
        Tue, 09 Sep 2025 02:15:47 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aff0681aefdsm2661611766b.8.2025.09.09.02.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:15:46 -0700 (PDT)
Date: Tue, 9 Sep 2025 11:15:46 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: rientjes@google.com, shakeel.butt@linux.dev, akpm@linux-foundation.org,
	tglx@linutronix.de, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, surenb@google.com, lenb@kernel.org,
	rafael@kernel.org, pavel@kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v8 2/3] mm/oom_kill: Thaw the entire OOM victim process
Message-ID: <aL_wQkwBZ7uLM2ND@tiehlicka>
References: <20250909090659.26400-1-zhongjinji@honor.com>
 <20250909090659.26400-3-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909090659.26400-3-zhongjinji@honor.com>

On Tue 09-09-25 17:06:58, zhongjinji wrote:
> OOM killer is a mechanism that selects and kills processes when the system
> runs out of memory to reclaim resources and keep the system stable.
> However, the oom victim cannot terminate on its own when it is frozen,
> because __thaw_task() only thaws one thread of the victim, while
> the other threads remain in the frozen state.
> 
> This change will thaw the entire victim process when OOM occurs,
> ensuring that the oom victim can terminate on its own.

fold this into patch 1.

> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> ---
>  mm/oom_kill.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..ffa50a1f0132 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -772,12 +772,11 @@ static void mark_oom_victim(struct task_struct *tsk)
>  		mmgrab(tsk->signal->oom_mm);
>  
>  	/*
> -	 * Make sure that the task is woken up from uninterruptible sleep
> +	 * Make sure that the process is woken up from uninterruptible sleep
>  	 * if it is frozen because OOM killer wouldn't be able to free
> -	 * any memory and livelock. freezing_slow_path will tell the freezer
> -	 * that TIF_MEMDIE tasks should be ignored.
> +	 * any memory and livelock.
>  	 */
> -	__thaw_task(tsk);
> +	thaw_oom_process(tsk);
>  	atomic_inc(&oom_victims);
>  	cred = get_task_cred(tsk);
>  	trace_mark_victim(tsk, cred->uid.val);
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs

