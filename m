Return-Path: <linux-kernel+bounces-807410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C4B4A405
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769661686FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A973090DB;
	Tue,  9 Sep 2025 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="By1IBAMS"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA8F3081D2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403656; cv=none; b=pGcU9VCYZr4g9Cuka3EOolUm/G3GJYHJQg+HtyDng0KXvP4vB6XasHXjHnK4F6qkyrtseS3DZRr2fATk5tv4VymHAcSWMIPLIycK6fzMcO17bL6IjrFUEeGo7z/Bsm8IK+1CK1vMXvEmHpXMkp6AJP71fkaK+RnHlSFlHkzjseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403656; c=relaxed/simple;
	bh=RQWIncjyb7m1TgFR79FR+l+FyH7TurC989EWAVFhxEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtalDpCUBqH6P9FthZGM9nWihbZaSKopQ1kWQmWKcP25gopF6fgGqnX2GFYWdpCVZVrJT4E+aDq8b72E9I+uc7uDhZ3Z652j0EgaZ+qWf7i2G+kGa1B0HO1jENj+w6zbrZDy/zsoTZjj4YmIaysLqzpZIlBPGRRRrb51AT2MRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=By1IBAMS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0431c12df3so910667166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757403652; x=1758008452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u22boo28UvFDQfs2oEw/hxJdzWFKv2Wia7rhjSS9eNo=;
        b=By1IBAMSx5p6XZzACatgk8qwN2QpDn3dpB6K52MH87fFtwEX0cTWwElxPXitsM6XBD
         dskeI7LJUNti2abByDkrSnZSfGFNFaoEiJuxBawCTv5fpk+i5j05fwdIhFY8JtsLs7n3
         cjAlNyKpWZWKBo51d4YczgviDTPmB3+9Y2ENQl4kcKYl0UodH4MMBNGM22sWay0V9ZmM
         9mVd5QKoqPovdpCl7L0ckOaZCQwXx9DzSR0E0BOWLOy/IMoPuuSMp0bZnRbIpLjx2DcA
         N9ZU6O3oZ04OGNmdn1MysG7aILjCONE2esLiDEt7wK7ePn6FoZsplMRTXjLOuur0mbWl
         a/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757403652; x=1758008452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u22boo28UvFDQfs2oEw/hxJdzWFKv2Wia7rhjSS9eNo=;
        b=qvAorJ9DRy0luJPzOIBc5Ufp9DiXT7iTqvqKLYk2pN9Fz7guAsn5Ffqh6CgkaHFgbY
         isk/va0YqJ9jtqs3a6QjCXsHnIxFGCcdpnmEfLUqX7UKFf8ESi3rme8Adk9lmKgkiDq3
         nsQYEvVj9cqYYyBUGahrIXZo5MRMS2qzULH329E86PHWpd3BsWxxGSVO8DfHRiGgWiCX
         2a+S0LVsQ/lZL7VzB4lL9z5c5m4We3lvRj0bDvGX3ur/3v1+O+G7NZmpKvMW82ml3P7s
         BPw365NbFDrffrmGv/NBtCq/kjIitk31PyzevLRqsGeuyN9PUj0IkFEBgkYMl4Ec+LtS
         0KOw==
X-Forwarded-Encrypted: i=1; AJvYcCXvvbrUa3z3xJDKMB8IBKcMtgouGazKNQVKyv7z2pxiOqULAQprzKSdkX0InGvSi2yWPgQhnX4LalQCqeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZaDRv7xNib9NcdxhgbLyqL9F5PVP3R0SAhjTYEG+bak6NICMS
	I43lmFwm/eVgukDPoSLE4GFsvOVQHQKKmNWc0FGae6NtXAHVQv2oAB/9PyrK9eB8JAo=
X-Gm-Gg: ASbGnct3hQ8qWsmu4DabZKnYvQeW7fvekUuK01/QVDiHCeLyM4hGS6bu17ZYZ28UB1W
	ewVMw5gZ4QJOlUMyPFbSnOoix6FAedYF3rBnZUtza0gX2Ol8aAc2bD4t6a6bS305dvpuA6SfFXo
	GnQhdRf1POxXsDWRhoWJVaaPSbYNLFd3cZyMLDsrvnnHs7RgJcGfnR0Jbb72OQjjAIhzvjfkNNd
	UmkMEdWOZgkRAlqi2GZ1ug3SN/ut8uBC4b557xRC7VpMDYuCDB1O1tl12oEcNJjPKhOuArXz5v2
	9YntsQ2u4fi5gDpN3TyrNOGnSZHKuT1tLfQz3YgfpyGbOaRCoOPKdIgUj6+5xYg3iN+3VjVLDt0
	tIrlhkMN/Cz/GnApmOQC3SydkodDs2dImeQedaO7sv8+w
X-Google-Smtp-Source: AGHT+IHDPUSJwJ09FmuKcRHCbVb4TRocjJO5VHcQQhngEcihEY5pYVTneb2uR9H+cbvN0Kp9WTpARw==
X-Received: by 2002:a17:907:d2a:b0:afa:1a67:e012 with SMTP id a640c23a62f3a-b04b13c1530mr865161366b.8.1757403652476;
        Tue, 09 Sep 2025 00:40:52 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aff0ed6ffebsm2543940966b.32.2025.09.09.00.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:40:52 -0700 (PDT)
Date: Tue, 9 Sep 2025 09:40:51 +0200
From: Michal Hocko <mhocko@suse.com>
To: cuishiwei <cuishw@inspur.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
	hannes@cmpxchg.org, weixugc@google.com, david@redhat.com,
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disable demotion during memory reclamation
Message-ID: <aL_aA2HKjfmwBaJ-@tiehlicka>
References: <20250909012141.1467-1-cuishw@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909012141.1467-1-cuishw@inspur.com>

On Tue 09-09-25 09:21:41, cuishiwei wrote:
> When a memory cgroup exceeds its memory limit, the system reclaims
> its cold memory.However, if /sys/kernel/mm/numa/demotion_enabled is
> set to 1, memory on fast memory nodes will also be demoted to slow 
> memory nodes.
> 
> This demotion contradicts the goal of reclaiming cold memory within
> the memcg.At this point, demoting cold memory from fast to slow nodes
> is pointless;it doesn't reduce the memcg's memory usage. Therefore, 
> we should set no_demotion when reclaiming memory in a memcg.

We have discussed this in the past and it is my recollection that we
have concluded that demotion is a part of proper aging and therefore it
should be done during the limit reclaim. Pro active reclaim through
memcg.memory_reclaim has a slightly different semantic (see
6b426d071419a).

I can see you have replied with more details to Andrew but in general it
is always better to describe your usecase and why the current behavior
is unexpected. Is the memory limit not being enforced? Do you see
unexpected memcg OOM situations? What is the actual problem?

> Signed-off-by: cuishiwei <cuishw@inspur.com>
> ---
>  mm/vmscan.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ca9e1cd3cd68..1edf618a3604 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6706,6 +6706,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  		.may_unmap = 1,
>  		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
>  		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
> +		.no_demotion = 1,
>  	};
>  	/*
>  	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
> -- 
> 2.43.0
> 

-- 
Michal Hocko
SUSE Labs

