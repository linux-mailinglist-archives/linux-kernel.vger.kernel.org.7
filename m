Return-Path: <linux-kernel+bounces-852215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620CFBD872D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4791923613
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB5B2DCF6B;
	Tue, 14 Oct 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G8uJIbNy"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5E22E7BB5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434405; cv=none; b=iw08+lCapkhogmvaxThZQ7rqWuJ/cPm/9IzzDEwSXcOIlR5IIYwU0U6kYcYIhrYCkwB/1HyHurvgEgWeGrdqKb6oSAIYPNaStmHepyVuVz/RQse2qwQwlEdHpfpKN7/4xLSFiymc+1ryE+hMZ1W+shuksaWpUe/4Vh/lQU8G+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434405; c=relaxed/simple;
	bh=sgJEDl2BfQemQLRatwbuYyh2daM/bWlOwAa1JZi5oBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C87avGi6XOgE/dapOQq9Pd3T0ipwvFV+QF0rgSxkSOrvgC04dmzEB5niOJJQ5b8eoyEhdDNY2NlijquIwo++3Bp58p+7BBuTcAHDWTZiaAULsNY4Xjc/ka007NKDJzcQv7OLEZmCVQPukS7PBhpC/11EvGDamKBa8zzg29RiVA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G8uJIbNy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so28132155e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760434401; x=1761039201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOAPJCH11hDS3jLByXOGPi6Sv8SZOPugR5veuhkVP30=;
        b=G8uJIbNy7uwtw8/V9atZnd/UNu4nS4WOxf1CCi90qyw5CgBJOfS3F3KQ4o0hj1AX0H
         7sCaALnKKpwS4ruhrXjxP3H4hs86SEVFpHiuxQBBPKjASIfBUO4Edvuqgr/9xo7vXYN8
         YqLKwLsU2NlerLY1afyvCWRZXWmu0zzigdoUKwymcxhlB2V/oQ7wfclQtFYdA9bKPOEP
         ts4XDtcUtya0Smqi1jRsm23UuUxX3YMrTgAJTMJ6//9XPuGAY8anrOxC8LrxTH8PGBeL
         yxrIMoCW9pwaw2ssLtQaPbdXbLO1WaZGKO4VyBH8JbQnp/lTwUDgzSxFkGVL40hp+98n
         xeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434401; x=1761039201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOAPJCH11hDS3jLByXOGPi6Sv8SZOPugR5veuhkVP30=;
        b=qB3Y/D1n+7gj2uTGEI16lTfX6Df2v9Zt+poudonuW03OskKbzRApBwKolxsi91nOCd
         cQKBmwL3VxD6bm+JBK141XHuzhwTQCVgPTqh4zpFn2Eongsjf2yfhfDo63LcQzNTJcec
         Thp6pJ9Y9OLf1HEIuPG1zfJCZ7qvnot147+WbwzR1iRPk1bCwvItqkgtGyJzFyEWw0hX
         eQQyROVXRzEUeSDpm5DxYbawYJiIXbGShczcp5AejnPkYqGiQG1HIfbBDpDrZEhCW+vO
         xGIXQd8VpVK0IfgeeaBSn3CO1aoCMBRBJjwfsilRQKz/v10U9sxlZq6YiFji6GqPwUc2
         01vA==
X-Forwarded-Encrypted: i=1; AJvYcCWHW1/Lhc8zAkjvXHqxJfzasncZ37DsTmOi19q+Thp9NMK3v/rPjpG70QxuDPjiS3/C+PdpbFzaD9vt5zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9F+Yb6hmBIUtEmeD93n/gEU3k2BHIuXATBsnXn+7HCuEa/yAZ
	57CznEIbzJlOkOnC0oQS/r6VLZc/DjXnjUDkdT4pv4l35bhJJbaSvrVJD34hicyJUt4=
X-Gm-Gg: ASbGncvDKudPkK7RDYyVkabhjuvAQFTezOlpvLi3Jza9MNmbAf4OoRD+ADhs83IbbUX
	VdNYhM2Eqzv6pr2PZpBdvg1haM7zIJJj8YBVVZVZgEZ8QPUTV+RvrGfW9ncZoLaS7L/qGDimvN3
	Dix92vs70f1we7vPKhWVNa8+8RBBqLXScUrNeljn83C6ZhB/XhT24No9Sqb46prtRxnU2VJN8t3
	IbEXy3wT9QH/evMUdy9IwRjZkCuRjYYXTcVVdYfDZavgRh8TG47BQnflA9I5hoQZ9JTQhkaKVup
	10oW3rTGQe8rhgUL7zAuQ0mgAG9dUnn/UAriVitu6eTnW9grr+e/XS/L38yhwxtYDQDp/Ads0cH
	qR5JbCJtjYLUgdB/Lou2VvBbrfOO2qsJiy3zYFlHkyV6xl0ZmYxISWfoufxHxcts=
X-Google-Smtp-Source: AGHT+IGcTFlotl++DNaOADqQPzPL48+M3MLBrIdj40znL9ulmxpmP8mkq3jzjYz/lQESgVWhNIZdqw==
X-Received: by 2002:a05:600c:5247:b0:46f:b340:75e7 with SMTP id 5b1f17b1804b1-46fb34075efmr133092415e9.8.1760434400686;
        Tue, 14 Oct 2025 02:33:20 -0700 (PDT)
Received: from localhost (109-81-16-57.rct.o2.cz. [109.81.16.57])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb48a60b8sm233103935e9.19.2025.10.14.02.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:33:20 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:33:19 +0200
From: Michal Hocko <mhocko@suse.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/vmscan: Add retry logic for cgroups with
 memory.low in kswapd
Message-ID: <aO4Y35l12Cav-xr4@tiehlicka>
References: <20251014081850.65379-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014081850.65379-1-jiayuan.chen@linux.dev>

On Tue 14-10-25 16:18:49, Jiayuan Chen wrote:
> We can set memory.low for cgroups as a soft protection limit. When the
> kernel cannot reclaim any pages from other cgroups, it retries reclaim
> while ignoring the memory.low protection of the skipped cgroups.
> 
> Currently, this retry logic only works in direct reclaim path, but is
> missing in the kswapd asynchronous reclaim. Typically, a cgroup may
> contain some cold pages that could be reclaimed even when memory.low is
> set.
> 
> This change adds retry logic to kswapd: if the first reclaim attempt fails
> to reclaim any pages and some cgroups were skipped due to memory.low
> protection, kswapd will perform a second reclaim pass ignoring memory.low
> restrictions.
> 
> This ensures more consistent reclaim behavior between direct reclaim and
> kswapd. By allowing kswapd to reclaim more proactively from protected
> cgroups under global memory pressure, this optimization can help reduce
> the occurrence of direct reclaim, which is more disruptive to application
> performance.

Could you describe the problem you are trying to address in more details
please? Because your patch is significantly changing the behavior of the
low limit. I would even go as far as say it breaks its expecations
because low limit should provide a certain level of protection and
your patch would allow kswapd to reclaim from those cgroups much sooner
now. If this is really needed then we need much more detailed
justification and also evaluation how that influences existing users.

> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  mm/vmscan.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c80fcae7f2a1..231c66fcdfd8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -7147,6 +7147,13 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>  		goto restart;
>  	}
>  
> +	/* Restart if we skipped the memory low event */
> +	if (sc.memcg_low_skipped && !sc.memcg_low_reclaim &&
> +	    sc.priority < 1) {
> +		sc.memcg_low_reclaim = 1;
> +		goto restart;
> +	}
> +
>  	if (!sc.nr_reclaimed)
>  		atomic_inc(&pgdat->kswapd_failures);
>  
> -- 
> 2.43.0

-- 
Michal Hocko
SUSE Labs

