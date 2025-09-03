Return-Path: <linux-kernel+bounces-797818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF43B415BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAA85E62B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89432D7DCA;
	Wed,  3 Sep 2025 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XK34mdlr"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C9270578
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882843; cv=none; b=Jbb6ryMEx/sHe8eQYf11lQIcvrMkJgT2ENqi5ZTL7/pr27XtkJdvpWHAu29JxdmEzJ2bD0hJ+KzkJFHUmpjr75obibUdZv+IQ1ib4Kb+0cwJj4IKTE+22pb9gmKa9lFGwSwwO1FzgOTY0T6m4g3sAbuMAPQbDw8yv/VesXQ9ib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882843; c=relaxed/simple;
	bh=oVCavdrm4v3wXN5EGefiOGtZMyGf4oSb+mlfB3AhRs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NC5AExfKnzqftdOZby/Fk2bLfYMQuMLDOKqaROpHPhWaNXrKMsA+fS+rkm7uICV20NWKxNJJXUDtJqHhfxL5l/NV4PKEe9lT7QhZ+hFL+lQhFKvvG4LQJ7WifOytZCVtfCRePmhkWJJN2Zk09uNUG+USj/Bo1kKLjqqisg9p4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XK34mdlr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso38425005e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756882839; x=1757487639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4SeVcETCZnlVYVPJLuLayVDeCpLMJgj8fEd5DO+wa8w=;
        b=XK34mdlrf6o/HbCOCOtVu03lxN19tGhvVM3KvGSjt6XEArD8v/5hHDMqGG9oHE5/X3
         AAUjTlcmpMNgVALnyyAexcHzwH+1qEFQGsPAm1iiq92k3gzcYbULtUB9AXsZ8DP5qvuT
         2Ae+fGrv+3w4ty8Ylf0ae2rGn1AbkBcgPtGkUsBv0517OTxp2hTIeO/H2gQSKfFNTI33
         jMwWuz6LlVx6BjhKbGX3mccHRGwZyfXuNWTsU8HrTJCfdjCeo6d6qowmJ1W3+Rvl7Om6
         6LanXqaND+oHo8ShBBCaWeQH5F1w4DBEIPtQYIiVyjPJZHKbk32eoGFIWPB+Zu8WUvsF
         KUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882839; x=1757487639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SeVcETCZnlVYVPJLuLayVDeCpLMJgj8fEd5DO+wa8w=;
        b=cmVlyqmRpQS7rhdjZZQKqJNO7lthhCSh7qegxid3Sk0UDF6EYSwkVSwtyXUKgUF8tO
         trS5URBcsfbiI+21x76+SmhwePrthv4c6ci0msXYFhOSMuD7PuJ5xk+00V1aR9euzin0
         +abLui80Y+amIBUhwJTlXnhf7FFSjWE6FXpxzJ2zv39fy49xxQizKcZBM15AOQfeWLdF
         Q2aQo3QilXjcAKbPCRi0I8iwQGPTzeQmrcg8nWW86oLhps+CmS2S8Tw7ICeUOTgifDQ2
         w2J3NzSy9llqOzDjm+G+sHE/INvXHi3COUFduWRXaNf+SWtXChTBkKDXWB4ALETek35w
         ncYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ4Tt6MvoEVjSrAkDvxawnse7ELrurl7uXbp856Nu5GrrXi7bFnEHqPWVlJmyGSFo8jQnYD58XCIrWyhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBqllxfDBH6204l+CisANbl5xeAR/bSeSU49qXrUKHFLWm2xZ
	N8n/TsNc3APWgQn6bni3f5AmK9m0ywxygukOTCc2sZ99K/HKlVWaJpQAYKVBHrHO6/w=
X-Gm-Gg: ASbGncstso/cnRLaYwmY2Z01NkSi8GLaRnlOWQKv86g5XJ56qom0C+T77ehFUBU4Mun
	u5blQc0D3LzCtnMPBV7Q773Z7c31Un+8L0iaMh/J+/199ur+vlscGcDJz1az1ptvh5Nz0tvJuW9
	eE61bT31gyfbgrrSd9+T9CMXD6Yi9oryzudOSrFasZGt/8KY7NTXQB7s89h2S21sMTgXkgEDyGu
	Lw4jrzfIcvITrhfDy+xeZhawwp3s3E6apA4PLYd+AhXMizUHiGtrLkl171Ve2yjcWgw8rmaovKd
	hBxQoxuxChRZcrOXUO19wQlGQV+akARPMbqth7c2cf+yHEao8tysvp190DXGMBjzUDitWKl0CJs
	vo2n9tbsnz5+JZsPf8xFP4VPEsOKngjygF/FrUJFbwBNNWP5002Ho7s5v
X-Google-Smtp-Source: AGHT+IEoXoDchPxjlW6nm9//Q2WMCRnFI5AVjrKIHIeZDsgd4U6erHhnOiYunkXji17UofJ0tU0gOg==
X-Received: by 2002:a05:600c:35c8:b0:45b:8939:8b1c with SMTP id 5b1f17b1804b1-45b89398f5emr91109865e9.27.1756882839064;
        Wed, 03 Sep 2025 00:00:39 -0700 (PDT)
Received: from localhost (109-81-86-254.rct.o2.cz. [109.81.86.254])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f306c22sm312469495e9.13.2025.09.03.00.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:00:38 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:00:37 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: akpm@linux-foundation.org, feng.han@honor.com, fengbaopeng@honor.com,
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, liulu.liu@honor.com, lorenzo.stoakes@oracle.com,
	rientjes@google.com, shakeel.butt@linux.dev, surenb@google.com,
	tglx@linutronix.de, tianxiaobin@honor.com
Subject: Re: [PATCH v6 1/2] mm/oom_kill: Do not delay oom reaper when the
 victim is frozen
Message-ID: <aLfnldGMZkRkt8Z8@tiehlicka>
References: <aLWmf6qZHTA0hMpU@tiehlicka>
 <20250902160129.13862-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902160129.13862-1-zhongjinji@honor.com>

On Wed 03-09-25 00:01:29, zhongjinji wrote:
[...]
> @@ -772,12 +773,18 @@ static void mark_oom_victim(struct task_struct *tsk)
>                 mmgrab(tsk->signal->oom_mm);
> 
>         /*
> -        * Make sure that the task is woken up from uninterruptible sleep
> +        * Make sure that the process is woken up from uninterruptible sleep
>          * if it is frozen because OOM killer wouldn't be able to free
>          * any memory and livelock. freezing_slow_path will tell the freezer
> -        * that TIF_MEMDIE tasks should be ignored.
> +        * that TIF_MEMDIE thread should be ignored.
>          */
> -       __thaw_task(tsk);
> +       rcu_read_lock();
> +       for_each_thread(tsk, t) {
> +               set_tsk_thread_flag(t, TIF_MEMDIE);
> +               __thaw_task(t);
> +       }
> +       rcu_read_unlock();
> +

I would prefer if we had thaw_process() rather than open code it here.
But the implementation matches what I would expect it to do.

>         atomic_inc(&oom_victims);
>         cred = get_task_cred(tsk);
>         trace_mark_victim(tsk, cred->uid.val);

-- 
Michal Hocko
SUSE Labs

