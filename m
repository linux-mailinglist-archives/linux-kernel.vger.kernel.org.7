Return-Path: <linux-kernel+bounces-830496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0DFB99D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26813274E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C363043DE;
	Wed, 24 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNHszp95"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDCE2FD1B8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716949; cv=none; b=bTjhxRKJTz5WICIG+T0dryOEZihqKnx5e43PjDpGHOQ8nUrdtWM3wURVfc7nu6fj/o2RaEUuUVHxsNrsIaqaC+bYNE+TEEatVrSr799GuDIlEJlMSpFxUL7TwPWV7X2lxNE3cnPsRT0ougg9yvlQomaXHtc0Ml0CRZPa3F3YAw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716949; c=relaxed/simple;
	bh=nNg409qV0z9AVT5cMQHXEMyBxSjmXRwUoXrYDF26FG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCW+TNxRE5Sfk0aR6Y8IPH6bBIHlgur19Bco4Ya5MF4eUd1dx9olsJuDSZsZqQMpvpSRo2KRDPOXzV8J522FG35OJsabo9qHEUXPY1cFICKBt27qYeuGhCFh0Skav7WNavyv7Ym8EfqFVH1U8nCEGPVLD7+btKLI391AOHldjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNHszp95; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758716946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zg/KeJeUvNE6SDnPn43Ej3SICDgB1VedGAUJQ2XUMaw=;
	b=eNHszp95KqldfYWqUY44CxJrxdG+HzUjzQxjUx9DgL2m2MHb+sTwfCB3E1ShHumdJ8bJa/
	8UHlDtSdYAr7zj1ByaAqOxo6nA+zcP+wzCeYXZH04DNmIOojZyvlMVSz0+Mgv/NNVWyYFH
	69yTatu5Zrap5t91rjFRo/HJkKst1Ug=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-Ny7C_lkfOay_225Q8dIZVQ-1; Wed, 24 Sep 2025 08:29:04 -0400
X-MC-Unique: Ny7C_lkfOay_225Q8dIZVQ-1
X-Mimecast-MFC-AGG-ID: Ny7C_lkfOay_225Q8dIZVQ_1758716943
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so1903743f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716943; x=1759321743;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zg/KeJeUvNE6SDnPn43Ej3SICDgB1VedGAUJQ2XUMaw=;
        b=QpZkUe/jOwytdu7eRIobrYRnFUPWrX8TsoC5Z3Rxjj/oAPw1I8mUOcGymu6nyaxgQo
         FMhZOLczn5Y2p7jUl/xZnGkGX/KmY3A4k9DrTCqQZLbquIF13DEvz+XnXHV5IqZ7cCG2
         s39ttG5xFWQ5JVzgYVYGozardQr+fkHN+qf7HuM7jCm8J8SMvb6cBuye0UJzHAQd30AC
         28+KKskKPXZKZOtXUdtMgU1zY8/1sK+oLrorH/qnWK5xhycSedmHrVVQ2hvjpLbnFI/V
         8d6XC+zTLM3pJadWLOB+etix72SvKW2A7p2Bp4mvFxUzf9JzKQgx5mNT/7cIFYJpZLHi
         iP5g==
X-Forwarded-Encrypted: i=1; AJvYcCWFcbKrDgLYiUkXyu8LuNH6a9lvA6+wgzGLuke1TtSy8jvlE8jqM3+amnRyhKcgZwT/+YKBkLMaLtuA5xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlldbUIiJkF/erx3B8WZeN+lT98avTt/4TshwEsrnYkyVOo7b
	joVPuAt8/p8PprxIcAAh5yc6R60iE/D411txSZVnbv+wnMWSxkJoG6p92uVL+luSp1vmouyLMMU
	6BygpQCbBhd24ryO5guQY+RZbPiZmc8SlVmvGNuewBEOVxqARaphDXojIzBBim0yQ3Q==
X-Gm-Gg: ASbGncsHJSY3w/wVbKa/4Wonb2bIvIxIWDXIh19RBJFMpfp1Rvb1RgymcLGqB8n4+d7
	/I5h3HFCLbEq72ljhzz4v1b3Hj3Ep9L6fa6/mB7vs0WXCepBRl0OzZfcV+8HiGVF/0aTMneyXKn
	JHX8BYbWwekDsOYHIDJTquz3AyeiiwDGkIrpaAKM2J97xEPmogMX4DzmeTcyzSgfL2qJA/HEbst
	kDmP7VT8Hg0Bswb1vww46YdUt9FRbzJ1H2jXcTr0YpyvduUpv4zWei6DWEaNnep6beyKf6JByjA
	ajlRG6oj1eVFLoL8PEpGAh8c+Qi0+8vixWevSd4pmR1VgR3sxaq4d2jnsPfbhc66XyO0wE87ib/
	n5ZLpCpPbIBFfpHXOima/N7Sd3KLBv6sa80qDr1NuwevEyVrO4m8jdx7ftH3TbV2N+g==
X-Received: by 2002:a5d:64e9:0:b0:3ec:d740:a71b with SMTP id ffacd0b85a97d-405ca959d79mr5315904f8f.31.1758716942782;
        Wed, 24 Sep 2025 05:29:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3xevDTMGBQG/yt32a0HQ37hskBklE0qC7Sm/CkDYkjJXHbzM/EDh9lB7E+58ArZeOtFZBpQ==
X-Received: by 2002:a5d:64e9:0:b0:3ec:d740:a71b with SMTP id ffacd0b85a97d-405ca959d79mr5315882f8f.31.1758716942363;
        Wed, 24 Sep 2025 05:29:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab62233sm30792525e9.21.2025.09.24.05.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 05:29:01 -0700 (PDT)
Message-ID: <2dcffe42-141b-40fc-9bc1-b61a1ed7d74f@redhat.com>
Date: Wed, 24 Sep 2025 14:29:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Next] copy_process(): Fixed jump logic error
To: Edward Adam Davis <eadavis@qq.com>, kees@kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <tencent_5E4F978D9525A58D97925ADDBADDB2193107@qq.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <tencent_5E4F978D9525A58D97925ADDBADDB2193107@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 14:06, Edward Adam Davis wrote:
> After futex_hash_allocate_default() fails, the logic should jump to
> bad_fork_cancel_cgroup, not bad_fork_core_free.
> 
> Jumping to bad_fork_core_free would cause a siglock imbalance.
> 
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

If it's still only in -next (which I assume when looking at the Next 
tag), into which patch should this fixup get squashed?

Or is this already upstream and we want actually Fixes: and CC stable?

(staring at current master, this seems to be an upstream problem?)

> ---
>   kernel/fork.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index e9a7fb5c3e49..a0b8eeeb1d27 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2349,7 +2349,7 @@ __latent_entropy struct task_struct *copy_process(
>   	if (need_futex_hash_allocate_default(clone_flags)) {
>   		retval = futex_hash_allocate_default();
>   		if (retval)
> -			goto bad_fork_core_free;
> +			goto bad_fork_cancel_cgroup;
>   		/*
>   		 * If we fail beyond this point we don't free the allocated
>   		 * futex hash map. We assume that another thread will be created

Makes me wonder whether we would have to undo anything the 
sched_cgroup_fork() did, or if that cleanup is implied in 
bad_fork_cancel_cgroup. Without digging too deep into the code, I assume 
the latter.

-- 
Cheers

David / dhildenb


