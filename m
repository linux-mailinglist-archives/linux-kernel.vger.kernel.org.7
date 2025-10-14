Return-Path: <linux-kernel+bounces-852543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9547BD94A5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C24C1925823
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627A32F3C11;
	Tue, 14 Oct 2025 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvG7eOAM"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F3231280F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444054; cv=none; b=N1Zyn4YHkJVslxmDCbPSCP1UF8cv4bEmo6TS3GZcUPHxEL5NEKr1E/ztnCh+DoetYGZrB7vQi53pV87Q+QHYJkEmMERlpm5IhgSNWLlvkZtzS5TNLWENSYlh7eNH6yx/EVQS33oq6Rz/cxlSxJlTIhYTMNaiRuWIm50CWei1eW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444054; c=relaxed/simple;
	bh=fIBzMkg0VGF52LXe1aiatwyk4pMCOhu7mOP/HlvLhSQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzLIy8OhYJle6zDHA0pEUh3X3NE9MuslKB+/JkO4XBls2juCnVlgMM6rp4fsrOshRpXlR0H0tTtR9WWjNga8Z1zKdUUJhf5Q2GNDDvPfR3dWAtHeu4PbGwiMjK/q4F7qoOBmNEimjwnBUUg8X0a7qWCcD82xMUgXJyQ0jXj4LqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvG7eOAM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b403bb7843eso1119881166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760444047; x=1761048847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4uv5mR3gumLLTp4rzrsge5eRolk8g3BgbWGMPSIr70=;
        b=fvG7eOAMSKj3VnEF6W9A6rI3EbIps9jpVGhIf5yvHF7LlcHmxe1scAATSS1JB3pNWT
         XGgcvCFKnYUlHCxUsAxSB43g9uzu8y3957zpKYYZhgvS5PipzRvZjl6DLVmi6N+5bM6a
         G9KJs3R24CDXOKkZyy7xkE8EglxXqZd8hdLYIEFQVaKz0R/yg61uYzVvHX90Y9Z0rHEz
         lDvgYraTbLwmm1ppLQWYtWSXfm0zhgShBanpRxwiIDkaK//Q1ytZcEIeF4TrYRBliVmz
         c3qNbvnAA3KmHZ3FNb6Zh1FYurn25PHQPRCc89mNo/lLBq4u54WbQlBvJyjtpkuzVtC3
         FgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444047; x=1761048847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4uv5mR3gumLLTp4rzrsge5eRolk8g3BgbWGMPSIr70=;
        b=I6DvcTgU3Mk1Rnt3U8byjhXvXutLOg1gMzRR/DwxC6Z/vnGQQ/D2s5yypoxXCfLWqx
         OBchpv+Axa0dDhDV20tBUQk+DxX/gBD6+D0DdtylbChvdmscHXvjK5fVXS+MLvQJSuzQ
         tG4fwqVgHByh08VorCtdV5CUrTZioOtRYQ60rL/T38j+hgOJ1pCsNb8lzjNlkBLgGsCW
         JpKJvF+3qzt3igRBno6xHMAGoZSuy8z1+2Q0LSj6+RKCkzcyeRUdMiAlN4+zFlKHFLw1
         tgf8sthgJjJYw4TVEGGFUtja2s/jQVtk3w1qGqcop4zN8AqC2b9BWefH3GAkO5W1Q5Hx
         SLrg==
X-Forwarded-Encrypted: i=1; AJvYcCWFYRptn8J18YKP9F8zNfhjRbyfgXs/usmACEFnnOzHPrc6WengOa/0ok+O36K1Qb/beU1q4mZ5sFLdbD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLgMEJQYWhSOlegtIbmYjn8LikrCLYkpJ20Q0VDTb9j9lNI7UF
	HxzuAgORL032vE0l8nH2Ta/EPh9I4r6p2YkIcpvJcYT8Ryde3+YZzYRu
X-Gm-Gg: ASbGncsXWEI+V8DDIpfHwdWKdtZU1N2kgOrg1pkr8+/rLfa6PJfJ1D+tbTOTQAN4J+w
	RlCGE0Gz/dbzKIJ4Y2R3zDzz6MIpkTV6M20mlCSKql7oxOhH2SFQcwE/Nxur2H53Vt6y0S87w2/
	8bfiJRt5I+2GG9E8sXlYfukCDSFbx970cogF+G8Ki3naeMzH3O0AoqRJ0fu1J6/4o34GI4iSl8g
	twkVJgnBF7MCJHZOAs11l3Oja5ImzaD+d7OgMzPBqThI8aMp6yvFfipGPiuWIi0IdCSqnM7L04b
	W/pEHmuKP8oNJ8lQdKqPqgvEZnQjzmG87apKXtfPyTVtruCFwj6lYcLEpVGG0YIpCk6wkFkaGmU
	NEz4Z9ioy4tUDGMPA2uBsTRCc6g==
X-Google-Smtp-Source: AGHT+IHkRlcBwOY51BkfooCa8LhIq4rnJgTTrE+rrJI+8PsajKfIrEpNVRNGLaYNbHSpIVOY51g+2w==
X-Received: by 2002:a17:907:2d93:b0:afe:b92b:28e9 with SMTP id a640c23a62f3a-b50ac5d0859mr2537079066b.49.1760444046995;
        Tue, 14 Oct 2025 05:14:06 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d61cd9f5sm1130915166b.21.2025.10.14.05.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:14:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 14 Oct 2025 14:14:04 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 2/2] bpf: Pass external callchain entry
 to get_perf_callchain
Message-ID: <aO4-jAA5RIUY2yxc@krava>
References: <20251014100128.2721104-1-chen.dylane@linux.dev>
 <20251014100128.2721104-3-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014100128.2721104-3-chen.dylane@linux.dev>

On Tue, Oct 14, 2025 at 06:01:28PM +0800, Tao Chen wrote:
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. Drawing on the per-cpu design of bpf_perf_callchain_entries,
> stack-allocated memory of bpf_perf_callchain_entry is used here.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 94e46b7f340..acd72c021c0 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -31,6 +31,11 @@ struct bpf_stack_map {
>  	struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>  };
>  
> +struct bpf_perf_callchain_entry {
> +	u64 nr;
> +	u64 ip[PERF_MAX_STACK_DEPTH];
> +};
> +
>  static inline bool stack_map_use_build_id(struct bpf_map *map)
>  {
>  	return (map->map_flags & BPF_F_STACK_BUILD_ID);
> @@ -305,6 +310,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>  	bool user = flags & BPF_F_USER_STACK;
>  	struct perf_callchain_entry *trace;
>  	bool kernel = !user;
> +	struct bpf_perf_callchain_entry entry = { 0 };

so IIUC having entries on stack we do not need to do preempt_disable
you had in the previous version, right?

I saw Andrii's justification to have this on the stack, I think it's
fine, but does it have to be initialized? it seems that only used
entries are copied to map

jirka

>  
>  	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>  			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
> @@ -314,12 +320,8 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>  	if (max_depth > sysctl_perf_event_max_stack)
>  		max_depth = sysctl_perf_event_max_stack;
>  
> -	trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
> -				   false, false);
> -
> -	if (unlikely(!trace))
> -		/* couldn't fetch the stack trace */
> -		return -EFAULT;
> +	trace = get_perf_callchain(regs, (struct perf_callchain_entry *)&entry,
> +				   kernel, user, max_depth, false, false);
>  
>  	return __bpf_get_stackid(map, trace, flags);
>  }
> @@ -412,6 +414,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>  	bool user = flags & BPF_F_USER_STACK;
>  	struct perf_callchain_entry *trace;
> +	struct bpf_perf_callchain_entry entry = { 0 };
>  	bool kernel = !user;
>  	int err = -EINVAL;
>  	u64 *ips;
> @@ -451,8 +454,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  	else if (kernel && task)
>  		trace = get_callchain_entry_for_task(task, max_depth);
>  	else
> -		trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
> -					   crosstask, false);
> +		trace = get_perf_callchain(regs, (struct perf_callchain_entry *)&entry,
> +					   kernel, user, max_depth, crosstask, false);
>  
>  	if (unlikely(!trace) || trace->nr < skip) {
>  		if (may_fault)
> -- 
> 2.48.1
> 

