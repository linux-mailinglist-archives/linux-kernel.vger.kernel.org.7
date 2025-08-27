Return-Path: <linux-kernel+bounces-787656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D0B37942
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB22365646
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987EC2C159C;
	Wed, 27 Aug 2025 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtZ4kVh7"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8574438B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270075; cv=none; b=H7vz45UKcgskF2/WUDfhHEzNSGwbd0IYiuut6B50d8h2D+cuTvofFXCdpMWFVAWmtAlBAhanCdRqLigPIgmKLhkaLIhvY4oZq19Bs0n77E6F2aqCrTZHt51GAVrsQojklO4PH9dvYuy8Y4aVW0lxPHgbUr6qc8B2ie65Pce9YxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270075; c=relaxed/simple;
	bh=HhYEP6qMh9+J2iu+xeQ1AWwC++xtPGmL9tym3pkVh5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egN8EEUoU5lS/1dPBoNFX++PthwcMbga1uym9D1O1LKbn+iJcT2SaJz4lLscahiAOav6Yf7dmi3Bt9mf3bkilgV4eOSl3XGidI4iPu3xhJigfgGivPhvtsaf5nzsiGls3I0YLsxVqEf6Tu2jzEq5RhSAV+5YDBUZHyc+63RNX6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtZ4kVh7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b627ea5f3so12376065e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756270072; x=1756874872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXAK34i6n0IW6+f/U/+fv+MxOP0/U5XW1xTt30ESlvA=;
        b=dtZ4kVh7aC5nkG9Txf0A65RuXMOwvKYNYygIkeQ4cU8DQsVoHEmYee/dzBVuD8Quu7
         l+0R6GqZoCDu8ErzIk5Fkg78GMCDd3D4HCm158BUbxwstLVShv6UYl0cUDOovAq2uHaH
         KJ9ngbm+aP9+6yOW95AklE3OFt9dlQHa/YHBGc56FR4LOK1tFggRNoC4qrcjXz0Ppjdg
         qWGYzNiOC6ISKT+talsPV0o+M2fTWvF4r9njUkuuMyjO1vy84uZd2om8Tf8wpJ9b9S9y
         uIEd7x17ivo9GkmggAEBMv2BfaJANhFoCszUhHrEt7LB/Tw+t9ac3GHL8JFKfSQzAtZT
         Mbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756270072; x=1756874872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXAK34i6n0IW6+f/U/+fv+MxOP0/U5XW1xTt30ESlvA=;
        b=MsmuPMGiNv+Hpgdkcz7vELbRBTZoGitNNrNm/+ApudTqBxr8pyRpXCACz5mTr7kWGc
         CTZv+rAK6u9BaJ9aR993VEEf5ob0DKhx/qTNaDUtvrc6SNbMK6sib4lZtgxWEb2flgXG
         LiWHJ6QZYWFAVFISfqyNk5XDC/lqzmPOQ7WdwpW3lhYkG/u7YgCOI1EQn6Iooq/7zCAb
         PCKNaGvZ0ekdSKCu2WBArnlUJmm8sX7zdoa7LLzUrNAg2+/1om5iM+iUKIejxuZK4pp3
         YRjh8YPueNZt9uOsQi9Nvh+bV4eoGI2jQmtmFKs5DMv+SQlHIrDhaT7/08pzZHTbG4SI
         vb0g==
X-Forwarded-Encrypted: i=1; AJvYcCXeiHLxKE+4v6mrNIlflYtKbQVdHdF/+jrZXSKiaBAxXrI+wSJFbKWwDNo0jM8XoD8mSz4GoOZ3o37e4R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhgeMWcDPrMA5UkSY4OpPmhqRnLiLnVSWjvkAiOqvpXf0bqf/
	4x55CtSOZlu4moZgmwae3ZlbjWKfVD04aj/YKJi7rsqyIWV3qeznFho7UGAbpQ==
X-Gm-Gg: ASbGncvDHokr+5DKxXwRJD7M/PCDoVlCnZxGSVh+sWzFPPo2RS3J23wvu+R/TrgXEZd
	1w6qytDqPeFrnfb3XXLMteP3A6EtDggRRZtKS6sV/tls4aWAIr0V8c0+p/jcP2v6bf16xSm9l7h
	ktGQxtXfZTapqt1sd8z/kpz68Rp28Yp6QoiVm5mBdNUSRnmF7FV0iFMQ5UvRZgHFhhaBZZMkNri
	Z3jH+YMXgPeA0RDkme9qcthmk97R7upe1q3u+Ge9SkCmhV0Ec6QwW/S46xlqKlm++qQvR1zRt1E
	5Fe6Y1lsxJ2LMFdCL+282eBcOCLFXA6i4VwCEixgNcMgOLmlD7uHXG955B8tg+YX4rQRH78zfLV
	yC+nNCFZQtAuAdGU7YO81yyua0aXOlecTXQ/iRJQnVLD4B7BgTM7LN2qtr2DdZfpSPX9TzQJBeL
	Ez2gAs/GFg9SnkOCtBHg==
X-Google-Smtp-Source: AGHT+IEYWtBY/v69iHdBMm2oOUl/phxTLS9NimBh75e+tw8TfgIHGCKLX3FPzWtHINS3KQsJxoZh6A==
X-Received: by 2002:a05:600c:c87:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-45b5179f338mr152920525e9.4.1756270072226;
        Tue, 26 Aug 2025 21:47:52 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23? ([2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f3125ccsm13026565e9.19.2025.08.26.21.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 21:47:51 -0700 (PDT)
Message-ID: <54cf2f4e-5496-45c3-a22c-aa8b38fede47@gmail.com>
Date: Wed, 27 Aug 2025 05:47:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
Content-Language: en-GB
To: Suren Baghdasaryan <surenb@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yueyang Pan <pyyjason@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, hannes@cmpxchg.org
References: <cover.1755190013.git.pyyjason@gmail.com>
 <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com>
 <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
 <CAJuCfpHyXWwrKkFmmbHTGtG9L-JK2eCt03ku9364i4v6SJKFbA@mail.gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJuCfpHyXWwrKkFmmbHTGtG9L-JK2eCt03ku9364i4v6SJKFbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/08/2025 03:32, Suren Baghdasaryan wrote:
> On Thu, Aug 21, 2025 at 12:53 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> On Thu, Aug 21, 2025 at 12:18:00PM -0700, Yueyang Pan wrote:
>>> On Thu, Aug 21, 2025 at 11:35:19AM -0700, Shakeel Butt wrote:
>>>> On Thu, Aug 14, 2025 at 10:11:56AM -0700, Yueyang Pan wrote:
>>>>> Right now in the oom_kill_process if the oom is because of the cgroup
>>>>> limit, we won't get memory allocation infomation. In some cases, we
>>>>> can have a large cgroup workload running which dominates the machine.
>>>>> The reason using cgroup is to leave some resource for system. When this
>>>>> cgroup is killed, we would also like to have some memory allocation
>>>>> information for the whole server as well. This is reason behind this
>>>>> mini change. Is it an acceptable thing to do? Will it be too much
>>>>> information for people? I am happy with any suggestions!
>>>>
>>>> For a single patch, it is better to have all the context in the patch
>>>> and there is no need for cover letter.
>>>
>>> Thanks for your suggestion Shakeel! I will change this in the next version.
>>>
>>>>
>>>> What exact information you want on the memcg oom that will be helpful
>>>> for the users in general? You mentioned memory allocation information,
>>>> can you please elaborate a bit more.
>>>>
>>>
>>> As in my reply to Suren, I was thinking the system-wide memory usage info
>>> provided by show_free_pages and memory allocation profiling info can help
>>> us debug cgoom by comparing them with historical data. What is your take on
>>> this?
>>>
>>
>> I am not really sure about show_free_areas(). More specifically how the
>> historical data diff will be useful for a memcg oom. If you have a
>> concrete example, please give one. For memory allocation profiling, is
>> it possible to filter for the given memcg? Do we save memcg information
>> in the memory allocation profiling?
> 
> Actually I was thinking about making memory profiling memcg-aware but
> it would be quite costly both from memory and performance points of
> view. Currently we have a per-cpu counter for each allocation in the
> kernel codebase. To make it work for each memcg we would have to add
> memcg dimension to the counters, so each counter becomes per-cpu plus
> per-memcg. I'll be thinking about possible optimizations since many of
> these counters will stay at 0 but any such optimization would come at
> a performance cost, which we tried to keep at the absolute minimum.
> 
> I'm CC'ing Sourav and Pasha since they were also interested in making
> memory allocation profiling memcg-aware. Would Meta folks (Usama,
> Shakeel, Johannes) be interested in such enhancement as well? Would it
> be preferable to have such accounting for a specific memcg which we
> pre-select (less memory and performance overhead) or we need that for
> all memcgs as a generic feature? We have some options here but I want
> to understand what would be sufficient and add as little overhead as
> possible.

Yes, having per memcg counters is going to be extremely useful (we were
thinking of having this as a future project to work on). For meta fleet
in particular, we might have almost 100 memcgs running, but the number
of memcgs running workloads is particularly small (usually less than 10).
In the rest, you might have services that are responsible for telemetry,
monitoring, security, etc (for which we arent really interested in
the memory allocation profile). So yes, it would be ideal to have the
profile for just pre-select memcgs, especially if it leads to lower memory
and performance overhead.

Having memory allocation profile at memcg level is especially needed when
we have multiple workloads stacked on the same host. Having it at host
level in such a case makes the data less useful when we have OOMs and
for workload analysis as you dont know which workload is contributing
how much.

> Thanks,
> Suren.


