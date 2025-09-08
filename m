Return-Path: <linux-kernel+bounces-805382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EEFB487D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C29877A172E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20B32EE5F4;
	Mon,  8 Sep 2025 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HgOXjDJw"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8739443
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322508; cv=none; b=Kj+f2oU1W7RUxWQX8bDC8FY2rZDgW6eVSurEt60Rb1eYPeRGKyK1o/Ec/GQl3irmit+dKS2p1q8RnGE2TGLVJuj7oPGvXVwIAj/Yrseb2yxD53n4TR62A5EvgA78aiLJCcFrSntk+Ajz4cgdz1GMyC8wSCfJ82Fy4SdwfSlVBYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322508; c=relaxed/simple;
	bh=p3axqcSjIgpt/G/0E6xuXsP7YLEdi6L+lrwMOhDGpls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKDDi/UPOqmBRfnpWEzdTWPwOP5NYwCnktoWBaRrQi4PN+REIrXS42gprrO50/HQ7TvCNrGwhEd9ls5qu4IprV54TeTO1ZTIcS5WoopgN22HLdFpuUGueFi3FJDjWztuOK6FtxIED2Y4dKpvTbkCyyZ/hguI17hFWXXkZtypr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HgOXjDJw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso20092845e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757322504; x=1757927304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CXAkEc+0hbVrwg0zBjiBl7uCpRmywegXjmBSprSMPqA=;
        b=HgOXjDJwmTc0jGXmEcPxlfACKwwcKHGqBNKQcdISagRZLy/X/SjzHwNekqKKT5puOb
         JEQ+bqGQgdECfbckkg5ZAmX623kd5u8dGbH9wcRa92e17O+OSXS6WjAgJxjxaY0TpmSc
         4ateAliliTpTZdV2QjiB+Mh2AvXVpMOVgTx1AE7V0dCIeSwGUww4cwro/EXOLD00s9C0
         D04EsAq97/z9L7C+KA3v9ZnhzAWg2K3D0CSCZOhLsJguABWVEBhyBSP+zoNAH3tVvmXn
         3HUguXB1XL2IVqJ81BDuYLXdr4/Da7UkCyRFOI5UWHHDA+IzzFGxlA1YOobSHItVTjWl
         XXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757322504; x=1757927304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXAkEc+0hbVrwg0zBjiBl7uCpRmywegXjmBSprSMPqA=;
        b=chF5xxCQQZDEvPfK2weC1aqX00acfifUgWggoFo7mOUscPk/RmRZD0DcAFvLLQL2Yc
         1pZjPGscSpRPRH6rJo0gQ/k83CSfEPoLpX6KCRawaY1TkAiCVIujyFPumOoXAw2C7cXn
         EG66tFODUwAIB440D1fqztWCzG4Il0ZMEbSJa5PS+YFFdunNiBQ19FI4azqN0Hpp/wGt
         QIecAZKxLN0Aw5GA2pMIG6Qr1jwpn3EI5u+gGSfrOzyCNHwXK8O8hbYCcydPebOAWhde
         K5zRuOQQOLrYhpkSEEjb9iqxwBRuKVtWgMOuO4rtcn3RmuL0xn+lcV23QdzRVKQomHcZ
         c2YQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9IB6dHBjFaSt+TTYdzozLi84dPCd92X6KA9gBRxl4E9Jcel893xAcxwxg1+UWwldFJOBEI3VSLO4pNeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJyrVf9PZSKdrS1HsaWVMkxPItCd5NNLGh8hduR30OKvniQUa
	TcgB/K2igYvZ3iQ2FDX5p9vaoDkGt1a2SSi/lN/fVa5weuvwjVI2IUILPpoajZDoLos=
X-Gm-Gg: ASbGnctTVV579obytEqyBMPqvA6aFF6eRAgEflK87BokyJrZ1/WIFKajR7PiWnFOkeP
	Z/2Qfd60h9UNDl8TEnzjZnxWIiRJKEmkR6JD0vdbOj4/k6sBjmjqxQS72jdecNQPYbqP1TIZgJA
	W9Sp7dqaMcn9c0So8e9us58uzY+p3aj7dEfu0k9CiZeRh0OUhKtIxIbe8imeeR7xlAcE3/B/TqM
	r68RzZD7nHsng0PCrCw0+/fAQyTtDezNGKKK36DiE7kh++hmIKzzoh4RYtac0JR7YnvNhw4YrcP
	IPEYCFkOuHTDYafA7nmvEuhymM84zd++BwHlHmfFl76q/mvStbw+5me/jpepuU1teV0Y7DEzusx
	YsbaQDoFJLe9WuQaReweIwOXnGmX55A==
X-Google-Smtp-Source: AGHT+IGjCdAP8Med5Uz3zM88YDI+0dw+kFhTAhqv2XIHSPraXCW8PtiZpKcSe5HEkCIs8k4Yh+M7Rg==
X-Received: by 2002:a05:600c:3586:b0:45d:d13f:6061 with SMTP id 5b1f17b1804b1-45dddec89e6mr70135545e9.30.1757322504380;
        Mon, 08 Sep 2025 02:08:24 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b8f2d3c88sm300994075e9.19.2025.09.08.02.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:08:23 -0700 (PDT)
Date: Mon, 8 Sep 2025 11:08:22 +0200
From: Michal Hocko <mhocko@suse.com>
To: Peilin Ye <yepeilin@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <aL6dBivokIeBApj8@tiehlicka>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <aLtMrlSDP7M5GZ27@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLtMrlSDP7M5GZ27@google.com>

On Fri 05-09-25 20:48:46, Peilin Ye wrote:
> On Fri, Sep 05, 2025 at 01:16:06PM -0700, Shakeel Butt wrote:
> > Generally memcg charging is allowed from all the contexts including NMI
> > where even spinning on spinlock can cause locking issues. However one
> > call chain was missed during the addition of memcg charging from any
> > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > cgroup_file_notify().
> > 
> > The possible function call tree under cgroup_file_notify() can acquire
> > many different spin locks in spinning mode. Some of them are
> > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > just skip cgroup_file_notify() from memcg charging if the context does
> > not allow spinning.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Tested-by: Peilin Ye <yepeilin@google.com>
> 
> The repro described in [1] no longer triggers locking issues after
> applying this patch and making __bpf_async_init() use __GFP_HIGH
> instead of GFP_ATOMIC:
> 
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1275,7 +1275,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
>         }
> 
>         /* allocate hrtimer via map_kmalloc to use memcg accounting */
> -       cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
> +       cb = bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_node);

Why do you need to consume memory reserves? Shouldn't kmalloc_nolock be
used instead here?

>         if (!cb) {
>                 ret = -ENOMEM;
>                 goto out;
> 
> [1] https://lore.kernel.org/bpf/20250905061919.439648-1-yepeilin@google.com/#t
> 
> Thanks,
> Peilin Ye

-- 
Michal Hocko
SUSE Labs

