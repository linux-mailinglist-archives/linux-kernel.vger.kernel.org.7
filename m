Return-Path: <linux-kernel+bounces-879726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E924C23D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D915634F0A9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562A722172E;
	Fri, 31 Oct 2025 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WoyDtMBu"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6D82773DA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899560; cv=none; b=UYg+dMofX4G9XZoknZzA+pkLD65gR591GhCCmvFT9i87+WIiyQ+awmG5ZQT0i066Cp//zPVtZy9dJy90OR9LDx6pcwZYFq2HAUsHYt3fOUnZODXcW4D2/OhJyOQm00/ofBlnoU1KUpeQv47s8buK3fpAjjgo2lBlqfzNBJbtL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899560; c=relaxed/simple;
	bh=3j8afmSJ7Nmsi16sNeqRifyt/WmVa4gl82NY0GZWAqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXkrfHsqUF7jvqEdWbEDpw4e6t6IANo/xgulyK8Ie2Gzlrvo66vVkdUL788r292IIi3HzgpkyJ72F3VfImUpin11F7Bz/VSiTcrUUCWcTOhV4fbPW4yF8YXHMKwDU4dizPO5vGiPmBzagXOYEGI9gNE2shaEWYYhjuEoAzHwLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WoyDtMBu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4711810948aso14564875e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761899557; x=1762504357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4h4q0wa7BdASeLKkAa33sOr+LqpNtBVUob6S/qE5mOw=;
        b=WoyDtMBuNhhFFznEpNIVqcF2X8Widy/OoxXlAPNS9tf4RR1UCNUREksKORQRI6yHHa
         Z0XjnXYYxmTep6USUQftuXPQ3AKA3IOLtlc1K5UrfKYJzIkvcXYzVYvqvq93a/eODgSt
         fNmeJIAoydG1RoAtJAc53SELCfJzaqJDms83Z+HfMZs8ZZd06vetrDwxcnqbWlT+Bhsx
         n3qz0JDHWCbYfLpbZTghOvE2Y3XqVOtRecg0gjvV/3NGn9eMZsx9t4KywxXTkZesTyFT
         TRez8XiTcf77/jOFeVVke5YfzY7UVYW4G2kz59apMI1vXAs7kdwJzqfdC5+RzCoMOO9N
         NnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761899557; x=1762504357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4h4q0wa7BdASeLKkAa33sOr+LqpNtBVUob6S/qE5mOw=;
        b=w0ojOY4noTNcf0pQ9aCpOveDK1ap6vVjYkeni4kuP6zLa46Zdq8yzdZKfBJMvuHklS
         3CT5Puuj44zMYK/wmGZJXt0czvnh5TiZfhBZuhxD5gmrKdbRK0cJ3tjsPd05xvUBwjFV
         tl8sQdgu5GZ2dL1StMgbfl88mN1kaY4/8Ej1X+0+vQyNMnsm+uifxl8uBf9DDTXk0kWI
         6r31vhMcW4BIwOVuE9XdnJE4+gEUiFdvlw2kF+Wjs4wHWWNWThi5PI5psrGLI3cw7q7T
         lMrvXv4q48Ba0jLNpYqgF0M9aq1sHc1pV+Hkbg4H1v2bgnh3b4kxtDpAhPAqcYqL9QXO
         Qj6g==
X-Forwarded-Encrypted: i=1; AJvYcCUDSq1sKkbbOmQFbb2f5R/CUmb7/LEqprotWluNcePtViJYii7EJRgnAo94zh07ncUoAYNLJsz52OwMmSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8q+NWMKhcRPufIOuWS4y92QU43I2cv+If4UHKEyic2hAt6ch
	Zbfa8thNFY7tvkgGNuKqe8rqaa3OGiStOHQg/wnOsnw6+ryifzD7zw5KO4Bnr9st1PQ=
X-Gm-Gg: ASbGnctqCu2GYpFDeDRm+E0xBYXXl542TOjJ5mOGGtybiFc8WSnYGOHAfral/FOetOS
	UstgNBxHhdIiddNVFFI/SS3jPhvbEOLGQXSlycqlOamfzR+K9SVj+svAOj1oVTBc6jSqIhkIKtB
	SFu7u7N+FqU2KMbrfQJKNPpdpNV4bt7fUcrTC+2En4VLB+Cb9YDwhrBEATf/UhKAuWg5FT0qaDP
	etSnPntZpmyj+cnYpB/ZgzxeZsMMOH13QAuM+USmGYESFXcWzvnxqp9IbOUzqEvaI24xSnpYWcc
	SCWQ9hCUJepGecWxTFyLUW1Vxb4DVLktNMuBal1c/u7eUYVpqqDXLzbc7fDuMbtSTwezttAJITw
	9pxqRbe+agM0Y251OMi4CZXpUDUS83YHTD3jmbAXmBGEfqBbheXsTZZ0r8B+JqalF4fSJ1dM4H9
	WDsAtPiR1LC3dThWHbLmjmaMJI
X-Google-Smtp-Source: AGHT+IGfDhEwc+4540g9zxrsusq87Jw5oannsM7AsDgvzrefgTdYZ1mcnrXQoAnn7esV8SehlhvpnQ==
X-Received: by 2002:a05:600c:1f91:b0:475:daba:d03c with SMTP id 5b1f17b1804b1-477307c51d5mr21021365e9.13.1761899556870;
        Fri, 31 Oct 2025 01:32:36 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732cb7f41sm20722905e9.0.2025.10.31.01.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:32:36 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:32:35 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 04/23] mm: define mem_cgroup_get_from_ino() outside of
 CONFIG_SHRINKER_DEBUG
Message-ID: <aQR0I9B9b1VvmYl2@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-5-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-5-roman.gushchin@linux.dev>

On Mon 27-10-25 16:17:07, Roman Gushchin wrote:
> mem_cgroup_get_from_ino() can be reused by the BPF OOM implementation,
> but currently depends on CONFIG_SHRINKER_DEBUG. Remove this dependency.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 4 ++--
>  mm/memcontrol.c            | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 873e510d6f8d..9af9ae28afe7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -832,9 +832,9 @@ static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
>  {
>  	return memcg ? cgroup_ino(memcg->css.cgroup) : 0;
>  }
> +#endif
>  
>  struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino);
> -#endif
>  
>  static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
>  {
> @@ -1331,12 +1331,12 @@ static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
>  {
>  	return 0;
>  }
> +#endif
>  
>  static inline struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
>  {
>  	return NULL;
>  }
> -#endif
>  
>  static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4deda33625f4..5d27cd5372aa 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3618,7 +3618,6 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
>  	return xa_load(&mem_cgroup_ids, id);
>  }
>  
> -#ifdef CONFIG_SHRINKER_DEBUG
>  struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
>  {
>  	struct cgroup *cgrp;
> @@ -3639,7 +3638,6 @@ struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
>  
>  	return memcg;
>  }
> -#endif
>  
>  static void free_mem_cgroup_per_node_info(struct mem_cgroup_per_node *pn)
>  {
> -- 
> 2.51.0

-- 
Michal Hocko
SUSE Labs

