Return-Path: <linux-kernel+bounces-793997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD0AB3DB4E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699851887AF3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401AB2BFC74;
	Mon,  1 Sep 2025 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dp/3sbO5"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154672BE655
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712488; cv=none; b=FlpuG6QDfwwdoVzBNjN+hTU88IiBI6BJpvCH5Phc0YgfZlem+L0oSK4NBTaA92+XotCemFYUsdYqgIUxATYszyRT5fNjdXYYrEEWnrPK97c+4thCayjDMR01ihPLu7yEOuF1m+vWKHLGHRDjomZCtLYJvR8vd1w56fQmJsjaNJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712488; c=relaxed/simple;
	bh=DiUtzODySvVQy6C0+MeFAf+GpkdVpkzQ8pTRsz62UYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqmFEkKeQSrARtpjoLXO1X45i1HJHbxD2dy+h5Mps3Or/AkOFB3/wvhac1tCv6rukcy84eAQYTstOJCsVA3kTRDRdyRslMU2roWWkJxzKoL0c7EY7JYnawZapovX+MD/ZU+kEHvZ0EkCi0kTrhaaXd3H9NL/1k9qPurpig9T/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dp/3sbO5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso23333965e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 00:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756712482; x=1757317282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fTibsjsZinMAL6mt7SzQqJlZlrTvbHjOaiEQY+Pnxmo=;
        b=dp/3sbO5V8/LUnRh4XuhKBQg3jWBbraLYlezWUUnyUW7LjFyR8Z53b+rU+Zs1t+a5q
         6INrOy0QJaCFs9AnXx1JcyNiGZiKVtOeoCiq+iEd5UElojhrVXugTbfj6nWuT0EWU3CP
         jG5i2zedo+DR1lKEGXF28jAmtBzT13Ib9PpYLV56nxDSVo4cJ+BDbAqIr1ykeR9nEszA
         jPi5iUBrOhfH9aUORsyGQYz4v5MghePoZCZqNi1PMFp8D+naaPIxd/CMr1WqOSDDmcgM
         /bD/uvcDo0eJrGxRRIAoXPFa5/mqCY0GTJozqcVCNbSe4ZAAjZJXxAh9sMuUv7F1oEDn
         kV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712482; x=1757317282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTibsjsZinMAL6mt7SzQqJlZlrTvbHjOaiEQY+Pnxmo=;
        b=OZI7ew1RP1eOURpFfFCFN+fUb9ZiQcnwo/NEDV7tM47awQAPPmv0US6Fp3WyCXEoW6
         8xjXeejnjPBzX+YYoSWEF6NrHJG4w5MUEwsfw20SS816PsNMZfyyeUQsA6vHL1CGC9xl
         hOR1fejyscaDOY4NEIcn9G6puWUrwRusBzhLxVKWXKXf6Y4PBxJ+P7Je6YEAgNoAOEdp
         JR/iKdZvJNRVl/nGHvZphI9sjIDsmdDeTQhtY1twuNpu0lAYNDpGsb6r9Fh39mSbLXu2
         w6UQNAJ29hy2Kyanu1ZFMOm/aH9YU/CdjO6fAMsLLxRuW+22aqXTlN/ztZZIgVaY21OU
         crdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7tWQFlubHLVe0EBec42LkBnEJDnl4t4rg4UnjmScXOZLmpQQNhBGWJE474jqy4VXj+dOeIADvBkQbrsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMATDDhX+d0mFz8cGQdoCTSbhTDMsaa0Q83xxIeeASxL7DMfv
	qtk1Z4RXnHj6a/w9YQsuet/bu5dxvKirxaBpDUiL/WR0nQHHvubvBq/G5MZHAPmYqV6EnqF0Ugy
	WPlQT
X-Gm-Gg: ASbGncuZuAPj/LYDhbx34WFrP20PePh/oKsTvL+pU9RWI+D9WaZ+StefJEjPwhvufVK
	RS7BSL4Gu9WodaSEACRx/6WTjwopTxfkmjNqvuRU3YaPYMV6YiuAxIsdI9Ba7pSaJwAWpW348rt
	is+Y9CDD4hRf+009u8CsBJmS0DkwyT6hg0Ect1tV+1R2bykzHqGySRrlmgn1JVNiBP32Pk8jL9Q
	DfT99UgSsn2jPf+ANdtOBvRwB0bIovNcD2vqZSzYeb0YtqyP/8fGVTBJxbs1HDf5jnOQVSMdPS+
	3vb4EE8Pqet8Ug7qtHMQAbzKzKvOZsQbUBJE4Ab/xIds2lw0+uc8WlWS1YmK/3OwJznOk8MuXew
	xAJgLafKSN08SvJeRxYeUoc0MSnKj5MgJGgOAn5vEa+KRxkMaQehsZ07K
X-Google-Smtp-Source: AGHT+IEOHCc1C43y9L1dHpZXh6OP0LizmCzEwU9EaGTg2xElyTZrzgDrpKZg4MhMcKWHXdtU0bUDNQ==
X-Received: by 2002:a7b:c3ce:0:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45b855c980dmr32953665e9.20.1756712481379;
        Mon, 01 Sep 2025 00:41:21 -0700 (PDT)
Received: from localhost (109-81-86-254.rct.o2.cz. [109.81.86.254])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e887fdcsm145730905e9.13.2025.09.01.00.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 00:41:21 -0700 (PDT)
Date: Mon, 1 Sep 2025 09:41:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: rientjes@google.com, shakeel.butt@linux.dev, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, surenb@google.com, liulu.liu@honor.com,
	feng.han@honor.com, tianxiaobin@honor.com, fengbaopeng@honor.com
Subject: Re: [PATCH v6 2/2] mm/oom_kill: The OOM reaper traverses the VMA
 maple tree in reverse order
Message-ID: <aLVOICSkyvVRKD94@tiehlicka>
References: <20250829065550.29571-1-zhongjinji@honor.com>
 <20250829065550.29571-3-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829065550.29571-3-zhongjinji@honor.com>

On Fri 29-08-25 14:55:50, zhongjinji wrote:
> When a process is OOM killed without reaper delay, the oom reaper and the
> exit_mmap() thread likely run simultaneously. They traverse the vma's maple
> tree along the same path and may easily unmap the same vma, causing them to
> compete for the pte spinlock.
> 
> When a process exits, exit_mmap() traverses the vma's maple tree from low
> to high addresses. To reduce the chance of unmapping the same vma
> simultaneously, the OOM reaper should traverse the vma's tree from high to
> low address.
> 
> Reported-by: tianxiaobin <tianxiaobin@honor.com>
> Reported-by: fengbaopeng <fengbaopeng@honor.com>
> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>

The changelog could be improved because it is a bit confusing at this
stage. I haven't payed a close attention to previous discussion (sorry)
but there are two Reported-bys without any actual problem statement
(sure contention could happen but so what? What was the observed
behavior). Also the first paragraph states that "without reaper delay"
there is a problem but the only situation we do not have a dealay is
when the task is frozen and there is no racing there.

As already said in the previous response I think this makes conceptual
sense especially for oom victims with large address spaces which take
more that the OOM_REAPER_DELAY to die. Maybe you want to use that as a
justiciation. My wording would be
"
Although the oom_reaper is delayed and it gives the oom victim chance to
clean up its address space this might take a while especially for
processes with a large address space footprint. In those cases
oom_reaper might start racing with the dying task and compete for shared
resources - e.g. page table lock contention has been observed.

Reduce those races by reaping the oom victim from the other end of the
address space.
"

Anyway, with a changelog clarified.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/oom_kill.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index a5e9074896a1..01665a666bf1 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -516,7 +516,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma;
>  	bool ret = true;
> -	VMA_ITERATOR(vmi, mm, 0);
> +	MA_STATE(mas, &mm->mm_mt, ULONG_MAX, ULONG_MAX);
>  
>  	/*
>  	 * Tell all users of get_user/copy_from_user etc... that the content
> @@ -526,7 +526,12 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  	 */
>  	set_bit(MMF_UNSTABLE, &mm->flags);
>  
> -	for_each_vma(vmi, vma) {
> +	/*
> +	 * When two tasks unmap the same vma at the same time, they may contend
> +	 * for the pte spinlock. To reduce the probability of unmapping the same vma
> +	 * as exit_mmap, the OOM reaper traverses the vma maple tree in reverse order.
> +	 */
> +	mas_for_each_rev(&mas, vma, 0) {
>  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
>  			continue;
>  
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs

