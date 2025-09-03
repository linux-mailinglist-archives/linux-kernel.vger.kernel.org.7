Return-Path: <linux-kernel+bounces-799014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECA0B425DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA8F54831D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A59E286D7B;
	Wed,  3 Sep 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lponYI7I"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059EA285C98
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914535; cv=none; b=fYWspaAgcnBaWk/TFw6Oqw7zd4J4AaIEwLXT8oCA3kDo75hOw3vMX5hYEUCZBgClMoFDE0EKTRq8MYqPwwgxBaUxO0RYs7YRyOvH5QIQgzSUvsTBn/jTZgWBw2rEuatWhUH2KOisOO9TpetgQxrkj8VkIOzdDQQkPcrOsMrWQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914535; c=relaxed/simple;
	bh=5Qa1UegjJv1f8egxv4AJaycNQ2amUSLwZ/7SX4oq9Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jc48CIC9QEafhoTnUGQlU0K3cM4ld+RSR6RbELTtOqT0NlqNDZzhZ2N54qRvIplPCd5ytiVMLSrmfOaMBOsOqzDi8y7qrL3UmyG1RflTddWu01gOF67Xo2tUzFQih37xTzQiV56KNIzI2/CdYB0SieSA0TFoOm5u6yNmEQx4PRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lponYI7I; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b86157e18so712905e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756914532; x=1757519332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4NFWtXgAaJ6iNMsd+UQ5O9Z+xVd57WsOenpYzlV6Kk=;
        b=lponYI7IWQzp7LEilVVlLqvb1DXg6m5cgPDIvIWOnape3GDF349sFLRT/YzHJgwPNy
         MRwpfDWHxZ18hkrJTYSfbl15lq7G8zkyrNIeo95sUX/cczuB0hzDNHKzNEzfgRUA0BI0
         80qswSe8ZIX6/U80YocpHG/lOgYy4uC2I5cHSy9gGK9rZnDhQ8M//CAgM+jfsQP0T55i
         0uBR9GqDt/lznfRlk4RTVHaV4CWIoZ+eM23VWx1grKEw/woObJzN9u40ZirO+RZ32CVF
         icMVQsUsElU1zePLQeq9rsplSyHPlVbkwFdZZ+TpXngDew/Ga2MmsPH0m4uKi3SPKTAc
         fVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914532; x=1757519332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4NFWtXgAaJ6iNMsd+UQ5O9Z+xVd57WsOenpYzlV6Kk=;
        b=ta9CsQYJCdRmPCyk7yY20lWAJvLH3bhQYNWP4TXkx7nXD/EgJ+70KNkAZfFvpLq+gr
         P2q1pF4rpF1YG+Xmgp9mfdtElCyluc+0SAvFw/GpX6sODMfdJ/ciQ3kPeeMw6V0FHXBy
         nZji1tS96SrPk14csS3htD6kfZwKkeVXiGk2efoxr8hd1qiyQSINieXa4MrMb+G7+BxW
         DkNry44FGO4W5KcN4BM4OaBxWyKMRpEDX7j7fQV0hoiz0VGVOdd+YlJB6GZieY1CiHO7
         a87WRVTpW6FzzfpxS1r1Q2oQNRnbnaaBaKrHNM4JYTF5F1+MebFEMvFt8PXYkpEa19bg
         1B3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMkTBGXOIajASCjjnUdnJNePYJoV9QvUhU1Y4KvXDpGqf6WhS455iPfzLwwB1LGhl+RvWO70n5QBjEIO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX9VUQbbQUlsZvaVJl+581GInJ+V80Duecojs9e5oZ1WTmoAwM
	z34+tcRCM4mJ8p1xLfE7ULTttPgDYmNvxfs/5lBn8+63eEBF8tAqyRqB
X-Gm-Gg: ASbGnctweUNx0vYhiAaRFGMddc/lrXAfhl+7VNpyaCfv5apyS9v7qYQ1Tf8vx3h8cor
	RIuEwV5uv8HsApOFSzCImMmaSIn5yGpwB5btzyPE9Z+ImdCC0Ox9IVASFw9Km4LlBJJzuu2Y4qm
	jjZyn4cXz2nDinGf0Tacwp79RK/oNAYVCRC9ixg9pw7TsS+CKuxfMNkwxWPnpWSALjuGYa8ch0l
	VxYF8ePxqOgmoq5UqDqHlFvQtIC8+cSOWP26dX/UoGX4Yhx4/LITpIo3QG741K9FrqOmnpKcZir
	0Ux/rheKGvJa6oGvo3/k36yhtcf/kVU6p0Qq2gvaaOe9RlKzI+34OpA24My0PpBhj51vrhzaTVc
	RKca7rZPYpulT00bOg7zg6ONFUAiJ5dhCLKy5FPW6y8YdpkGTdAAkv0ORvtrioCIM94mTVUeevd
	QNebDzWwgo1V7/b57Tts/seA==
X-Google-Smtp-Source: AGHT+IG2IWHGwxoWmo8S5cPd/A3dfYVVUoCh7nIq7BEowuCtzecaRZAq7kW6j5HJmaHkGmaET7f2fw==
X-Received: by 2002:a05:6000:1786:b0:3de:c4dd:9e58 with SMTP id ffacd0b85a97d-3dec4dda120mr1788739f8f.50.1756914532073;
        Wed, 03 Sep 2025 08:48:52 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::5:3267])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fbd01sm24556962f8f.13.2025.09.03.08.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 08:48:51 -0700 (PDT)
Message-ID: <45477803-dc64-48be-b460-e2c66cf4b9e7@gmail.com>
Date: Wed, 3 Sep 2025 16:48:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/show_mem: Add trylock while printing alloc info
Content-Language: en-GB
To: Yueyang Pan <pyyjason@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Vishal Moola <vishal.moola@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
References: <cover.1756897825.git.pyyjason@gmail.com>
 <4ed91296e0c595d945a38458f7a8d9611b0c1e52.1756897825.git.pyyjason@gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <4ed91296e0c595d945a38458f7a8d9611b0c1e52.1756897825.git.pyyjason@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/09/2025 12:16, Yueyang Pan wrote:
> In production, show_mem() can be called concurrently from two
> different entities, for example one from oom_kill_process()
> another from __alloc_pages_slowpath from another kthread. This
> patch adds a spinlock and invokes trylock before printing out the
> kernel alloc info in show_mem(). This way two alloc info won't
> interleave with each other, which then makes parsing easier.
> 
> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>

Acked-by: Usama Arif <usamaarif642@gmail.com>

> ---
>  mm/show_mem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index fd85a028a926..e9701d07549b 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -421,7 +421,9 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>  	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
>  #endif
>  #ifdef CONFIG_MEM_ALLOC_PROFILING
> -	{
> +	static DEFINE_SPINLOCK(mem_alloc_profiling_spinlock);
> +
> +	if (spin_trylock(&mem_alloc_profiling_spinlock)) {
>  		struct codetag_bytes tags[10];
>  		size_t i, nr;
>  
> @@ -448,6 +450,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>  						  ct->lineno, ct->function);
>  			}
>  		}
> +		spin_unlock(&mem_alloc_profiling_spinlock);
>  	}
>  #endif
>  }


