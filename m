Return-Path: <linux-kernel+bounces-879799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5912DC240E5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B66F64F3D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8CF33030A;
	Fri, 31 Oct 2025 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N2+v4Gun"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D93314D0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901711; cv=none; b=JU8sw88XOP9C/bPJE2CzhXfE8xybdGRtcUbKICGKW0BCXMaEfehoDCnIM3np44j8fLUv4oXn0E+h3HVsggkj3DHYDAzPXQU/jrWzARE5GGg0xQ5nLlp7VajUbHySO0//dBEMkQFZksLXFmXbZrnW3kiM++/VRErRRNJ6rArqYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901711; c=relaxed/simple;
	bh=q3uzjK/gvtyvyf0n2V1KvcduPuP3HasHyUqeLfnPGuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk5B7NiFnQjuOxCLA0JJ0WP+v5Jeb2mL5a5lGspmLWeBamREryJeP/E5QiRr4CGBUUISxZrUmD9nfH3BbMALcTye2e0O24MnInA8VYSFEbFklIkmNbLBCBYVmjUJIYOACUau6RYPKfYEDavsMNPClJy+uJ96G6QGDmtoTNziaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N2+v4Gun; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429bf011e6cso631798f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761901707; x=1762506507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s4ZSMG2AuU/ZGT4Jo1L6qr4nQw/AKzOrQurRx1abInc=;
        b=N2+v4GunhVgDbvjPMm0hRMyki6ovu9q2Dtoobb4YUz/MswuKwHLWEodq4bXOqRPFmO
         wj0oAQQC9SRRIqyfU3z+JQ5lxjaBdLk1TiCXRiBLA1uu+24AEWQt1lmR4cUA0dg5dkDN
         IdUCHbn65yuN2HI3UXdCg3lcGLe2fiJIJTmTl3yxZl9jt4u/CfCasKNVckM9OFkIn7Br
         cB4AysaecmupP+aKn5MQmvTvOiFXuWywaRNmXzHQOLPUpXOKwUyPkknibJpzLCLDtU/O
         ZyXwgNx0KgEva5M5DMBo+Ul2ylRdKlq8WWX+zwzDOwIVyIGcH2b0NEb3ErP6yUNEoV38
         iirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901707; x=1762506507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4ZSMG2AuU/ZGT4Jo1L6qr4nQw/AKzOrQurRx1abInc=;
        b=mfQ0xu5q542eLZ0Fo8jh6OyLGMWSwGxPCJyRa885XFCd36evRi1Vj99osZuQVvWg+j
         EvzQ4+jSJeiMwIdw1yBrEmTEUR1oDNJViC/RHzYqZ79Az9mNxe2ksCKWD7WkqG6XFUHk
         8nSvrNycl18on4Z1XqsJPYy46Up9M5UOwT9cus74pKcnTrLwhkl3L35L2i1l7xAFKQcF
         jh4/Co2vQhttgdgwCQLQesmHM5Kbh1+flyFDh5dEsHO6fl4NN9f1ijhkEqHm0bZbzlcB
         VuyGOz9OW6WeeMMIrrHP7o1/Hp9V/OdDlKVHl/cCMH0Ugdna9+hXEy/4ZhryXFkEzlDN
         +D3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1qjsyUqgWuBBI4U5AykoYRmjGEhPHWHe5aCt6xGAlYhTuTbOgJL/qznT3aKREbmnZHbsXE/3W1dL2cRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVBlsHKy5cUad9doNggdyvA24H8YVCH8RHBr44dvDPcCWC656v
	Wbt+mY+Ob6Rdur+yVy6FwbqcesvMJyo79L2kJNCThXT41VrroTsIriN6i/1YoMbPMq8=
X-Gm-Gg: ASbGncuZ+KNIRJnmcmLPHABHTVpusc2hricTpw0PNy7IXWOHh4ZCjp3IpA3jMSo7zKs
	kF9Cl0GbeJS2UvmEb54EPcxyoOtbtRvQZcZ9/SOaPM37nXsglDYzPEz1miyR5uJ2sJ4nBxYEnGp
	rKfHc/XcH8f3DHMU+CtJbRyUeyWEYg/snL4rzVx0KXsQ/MCsPObgtux1XYmD/wfTxE6QQG8S3AN
	f3BrNti4GscI3DJ+hWVHlEAO4ycDzvjkZ/9p+xQGSPNoCDp1vHCg18ox9z5VKJhut24tVyf9Mc+
	QNAbj5wNrgSs68RZvw40i6CU6T+yCPGlvKsMpsuasL6Mo6XDMX5Ob2C/Wh9hB6S0jSW9ddSja/C
	rp+GwME6BsZQDoaaqCgbq1qOUFJqLhZwzJ9Axxe7ufrYtHU4QAVlg6oW4rlR/jfqNLVQKmPKebe
	QI6iz7dH5yZMQJv7m7H3eN+2aT
X-Google-Smtp-Source: AGHT+IEIajU1J4qwwHCSAhYY1Y0QbJUQjFbzl13BM1lB02XFV9NpxNKRXT5AUnkNlCIE5mpOdA1/sQ==
X-Received: by 2002:a05:6000:41d8:b0:429:be56:e508 with SMTP id ffacd0b85a97d-429be56e6e4mr1870640f8f.58.1761901707235;
        Fri, 31 Oct 2025 02:08:27 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f4732sm2429798f8f.43.2025.10.31.02.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:08:26 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:08:25 +0100
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
Subject: Re: [PATCH v2 10/23] mm: introduce BPF kfuncs to access memcg
 statistics and events
Message-ID: <aQR8if0cpQQ5Am36@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-11-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-11-roman.gushchin@linux.dev>

On Mon 27-10-25 16:17:13, Roman Gushchin wrote:
> Introduce BPF kfuncs to conveniently access memcg data:
>   - bpf_mem_cgroup_vm_events(),
>   - bpf_mem_cgroup_usage(),
>   - bpf_mem_cgroup_page_state(),
>   - bpf_mem_cgroup_flush_stats().
> 
> These functions are useful for implementing BPF OOM policies, but
> also can be used to accelerate access to the memcg data. Reading
> it through cgroupfs is much more expensive, roughly 5x, mostly
> because of the need to convert the data into the text and back.
> 
> JP Kobryn:
> An experiment was setup to compare the performance of a program that
> uses the traditional method of reading memory.stat vs a program using
> the new kfuncs. The control program opens up the root memory.stat file
> and for 1M iterations reads, converts the string values to numeric data,
> then seeks back to the beginning. The experimental program sets up the
> requisite libbpf objects and for 1M iterations invokes a bpf program
> which uses the kfuncs to fetch all available stats for node_stat_item,
> memcg_stat_item, and vm_event_item types.
> 
> The results showed a significant perf benefit on the experimental side,
> outperforming the control side by a margin of 93%. In kernel mode,
> elapsed time was reduced by 80%, while in user mode, over 99% of time
> was saved.
> 
> control: elapsed time
> real    0m38.318s
> user    0m25.131s
> sys     0m13.070s
> 
> experiment: elapsed time
> real    0m2.789s
> user    0m0.187s
> sys     0m2.512s
> 
> control: perf data
> 33.43% a.out libc.so.6         [.] __vfscanf_internal
>  6.88% a.out [kernel.kallsyms] [k] vsnprintf
>  6.33% a.out libc.so.6         [.] _IO_fgets
>  5.51% a.out [kernel.kallsyms] [k] format_decode
>  4.31% a.out libc.so.6         [.] __GI_____strtoull_l_internal
>  3.78% a.out [kernel.kallsyms] [k] string
>  3.53% a.out [kernel.kallsyms] [k] number
>  2.71% a.out libc.so.6         [.] _IO_sputbackc
>  2.41% a.out [kernel.kallsyms] [k] strlen
>  1.98% a.out a.out             [.] main
>  1.70% a.out libc.so.6         [.] _IO_getline_info
>  1.51% a.out libc.so.6         [.] __isoc99_sscanf
>  1.47% a.out [kernel.kallsyms] [k] memory_stat_format
>  1.47% a.out [kernel.kallsyms] [k] memcpy_orig
>  1.41% a.out [kernel.kallsyms] [k] seq_buf_printf
> 
> experiment: perf data
> 10.55% memcgstat bpf_prog_..._query [k] bpf_prog_16aab2f19fa982a7_query
>  6.90% memcgstat [kernel.kallsyms]  [k] memcg_page_state_output
>  3.55% memcgstat [kernel.kallsyms]  [k] _raw_spin_lock
>  3.12% memcgstat [kernel.kallsyms]  [k] memcg_events
>  2.87% memcgstat [kernel.kallsyms]  [k] __memcg_slab_post_alloc_hook
>  2.73% memcgstat [kernel.kallsyms]  [k] kmem_cache_free
>  2.70% memcgstat [kernel.kallsyms]  [k] entry_SYSRETQ_unsafe_stack
>  2.25% memcgstat [kernel.kallsyms]  [k] __memcg_slab_free_hook
>  2.06% memcgstat [kernel.kallsyms]  [k] get_page_from_freelist
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Co-developed-by: JP Kobryn <inwardvessel@gmail.com>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h |  2 ++
>  mm/bpf_memcontrol.c        | 57 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 39a6c7c8735b..b9e08dddd7ad 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -953,6 +953,8 @@ static inline void mod_memcg_page_state(struct page *page,
>  	rcu_read_unlock();
>  }
>  
> +unsigned long memcg_events(struct mem_cgroup *memcg, int event);
> +unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
>  unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
>  unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
>  unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 76c342318256..387255b8ab88 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -75,6 +75,56 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
>  	css_put(&memcg->css);
>  }
>  
> +/**
> + * bpf_mem_cgroup_vm_events - Read memory cgroup's vm event counter
> + * @memcg: memory cgroup
> + * @event: event id
> + *
> + * Allows to read memory cgroup event counters.
> + */
> +__bpf_kfunc unsigned long bpf_mem_cgroup_vm_events(struct mem_cgroup *memcg,
> +						enum vm_event_item event)
> +{
> +	return memcg_events(memcg, event);
> +}
> +
> +/**
> + * bpf_mem_cgroup_usage - Read memory cgroup's usage
> + * @memcg: memory cgroup
> + *
> + * Returns current memory cgroup size in bytes.
> + */
> +__bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
> +{
> +	return page_counter_read(&memcg->memory);
> +}
> +
> +/**
> + * bpf_mem_cgroup_page_state - Read memory cgroup's page state counter
> + * @memcg: memory cgroup
> + * @idx: counter idx
> + *
> + * Allows to read memory cgroup statistics. The output is in bytes.
> + */
> +__bpf_kfunc unsigned long bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, int idx)
> +{
> +	if (idx < 0 || idx >= MEMCG_NR_STAT)
> +		return (unsigned long)-1;
> +
> +	return memcg_page_state_output(memcg, idx);
> +}
> +
> +/**
> + * bpf_mem_cgroup_flush_stats - Flush memory cgroup's statistics
> + * @memcg: memory cgroup
> + *
> + * Propagate memory cgroup's statistics up the cgroup tree.
> + */
> +__bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
> +{
> +	mem_cgroup_flush_stats(memcg);
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> @@ -82,6 +132,11 @@ BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_ACQUIRE | KF_RET_NULL | KF_RCU)
>  BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
>  
> +BTF_ID_FLAGS(func, bpf_mem_cgroup_vm_events, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_mem_cgroup_usage, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_TRUSTED_ARGS | KF_SLEEPABLE)
> +
>  BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
>  
>  static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
> @@ -93,7 +148,7 @@ static int __init bpf_memcontrol_init(void)
>  {
>  	int err;
>  
> -	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> +	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
>  					&bpf_memcontrol_kfunc_set);
>  	if (err)
>  		pr_warn("error while registering bpf memcontrol kfuncs: %d", err);
> -- 
> 2.51.0

-- 
Michal Hocko
SUSE Labs

