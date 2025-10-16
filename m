Return-Path: <linux-kernel+bounces-856907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1485BE564B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5A7C504E43
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133882DCF43;
	Thu, 16 Oct 2025 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoQK19Z7"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9245918FDDB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646413; cv=none; b=axgeSqJEjYO/9uX96mXZiNwIlGhdqL5Us7r51bEXXzp1tWyChhazNkkDTeQXtOmXrEf0oYP9eDHya5fMARPCqmgLPF0fyxvG0EXvWy687Wb5deiV9y2rvKgf7Pwh/1tWmRZt5/qDNTs+h/bJa3WMiN8RerSqzzRFH4galIft9do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646413; c=relaxed/simple;
	bh=xdxf4bGgZ3b0nAJDzpJIh8oNb3BVl6MHHNAqkvbVLn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSuskE4krU2D6P1f8qQueFHRLQkqtmNJMh3xsRSkXyiwH4XLeb+E64E8gmKmEd9q0ntxMZl287P71z6myHq8ml2dKzToITzyoaAtjCne+wFYEk7XXgJd/h2YgCO/u06Bu+kWqrQTQkt5smCnb1vEwmjlYf5XOh5u10HE2Q5uqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoQK19Z7; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33ba5fc3359so1231866a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760646411; x=1761251211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bo5Pb4pEnCN8Qp9wO+FXoUs/VjBU1u60no/MUECaFf8=;
        b=SoQK19Z7A9eR9ukTH8+3c4LN+x14wDqjGqoyVh+5sugwUg+ZjfXBol1okUTDeA25en
         vwOTU9K/nct0pKJVYj1rNFFUh7iI1UDRCJPK0Y1w8B/k5808oxRfnXWAKjI852FgNJlS
         syNot3sqCqg+Q/UjdZyQu+uPooBhVnnBs6VArKrhCuM/VzhJr+5QszH0X7iYKcDHRETR
         f2t6aL3fIFgFP45cbDWpuMMwngk7CTeTMVm99qXKczJCsDpLbSEYZmztrZGrh9R/YunG
         pI6WamFvdZmFhA70F4yT+yurmZyeabfVa1rQ3HpO6bzo7NMWosAsomOfDahcVHAijaX2
         mSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646411; x=1761251211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bo5Pb4pEnCN8Qp9wO+FXoUs/VjBU1u60no/MUECaFf8=;
        b=pTrObP7GLfJMJiaEjBtyN+OvJ5SrG7PxxxYSsJKqhFmGSc0OTYMpFo1V7ztF16QTCr
         Bf9IqQsPx1sRAyDW4HRTE2L/OQ32+ANS8juohtGFdgAIzJ9EB9yi3iajO0H5b3CGcha8
         W7SxrxBFPMYFUI3HUTqVresR39FLh6tT/SqAbWEszNkqapinPxyDkUdOFVW2n/4qWGvX
         vOFuzqXD9a/7Iwp7zkEbovGoTok6JSNljEhnVXDsl79ff3wHQ4AFAlqAK3IvOCECX3Om
         Ugv/6sk+TjlqwZ0/vBt1jTLDxjuym6kT/XEe/AFzQBGKWMaHGtwGENNQCr3/1a+wbU6K
         sxGw==
X-Forwarded-Encrypted: i=1; AJvYcCWM5WGstiGuKAQBcNqTPUGbe4XMXZfQ+FbnfVkx1i7SUjrR6tW26+62fOjPDsBC9TIjb2nx7nj/c8Xi+Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZU5yWkgt4rb1OT7rYZGVG0tN+h86ZazU/vJ7Oz67gWfGqGn/I
	mmrcE/pCJdsh70+NqCq4UlBp0q1RroNiu+Zd33Un+D9VrERzUGI6DPN1
X-Gm-Gg: ASbGncvMEHkTULRBM3a4MJoAhkiSjdrrWx+OeQhNNd65xe+pobkB0SzwHdqP/BqvI17
	TT3ilYGN8SRmGpamJypKXDb3YbxWZUsFJlEvKn38a7zZUCCcxHoX/rX2QBLIGZnbB/jR0+Hs3P+
	Pu2+CQfbpKp3QpDLYeNF1ayYyT76q/qwUbo6QucIYYDaDIvFUOMgZmOBz6RTAgUpl6Ppbj+xCof
	dSXU+7XJmJuMzhm4tNlMSPDwhyPBEtJ4EC/oTuymcpBBeIl/PWZ1+f98cOA+sTwfKWmEqHY9aGX
	bpVsixYyfkg4TCyXQug4VbXOdx1ZbtA5Ec/UkeyCJbWunXYd1c+57jo17A8aNtNH67zmO+06otm
	I0zURFnnodfVXhxLnn/7Y2whtYbgbqL3sEKp2VJEHTSEdGNMr5ConGsrroBc0B3TTr7NS9WzAIu
	Zz3CocgygKYkiMeQzJwY/uxQin4tBclYtTTx8F9JvMCHrB96uB254zdgU=
X-Google-Smtp-Source: AGHT+IE9B5Vdk4petXHg7AQwUSLZThEnOzKfYaaM8uzg+9wXXauMcXrMjeybYvp0mkVR/VZkAIO0fw==
X-Received: by 2002:a17:90b:28c4:b0:338:2c90:1540 with SMTP id 98e67ed59e1d1-33bcf8e7174mr1148401a91.20.1760646410655;
        Thu, 16 Oct 2025 13:26:50 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:6028:a61a:a132:9634? ([2620:10d:c090:500::5:e774])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd7b3da16sm314131a91.18.2025.10.16.13.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 13:26:50 -0700 (PDT)
Message-ID: <2fa573e6-bd9a-46b9-a2a6-bfb233d0389a@gmail.com>
Date: Thu, 16 Oct 2025 13:26:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] memcg: reading memcg stats more efficiently
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, andrii@kernel.org, ast@kernel.org,
 mkoutny@suse.com, yosryahmed@google.com, hannes@cmpxchg.org, tj@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 kernel-team@meta.com, mhocko@kernel.org, muchun.song@linux.dev
References: <20251015190813.80163-1-inwardvessel@gmail.com>
 <uxpsukgoj5y4ex2sj57ujxxcnu7siez2hslf7ftoy6liifv6v5@jzehpby6h2ps>
 <e102f50a-efa5-49b9-927a-506b7353bac0@gmail.com> <87wm4v7isj.fsf@linux.dev>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <87wm4v7isj.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 6:10 PM, Roman Gushchin wrote:
> JP Kobryn <inwardvessel@gmail.com> writes:
> 
>> On 10/15/25 1:46 PM, Shakeel Butt wrote:
>>> Cc memcg maintainers.
>>> On Wed, Oct 15, 2025 at 12:08:11PM -0700, JP Kobryn wrote:
>>>> When reading cgroup memory.stat files there is significant kernel overhead
>>>> in the formatting and encoding of numeric data into a string buffer. Beyond
>>>> that, the given user mode program must decode this data and possibly
>>>> perform filtering to obtain the desired stats. This process can be
>>>> expensive for programs that periodically sample this data over a large
>>>> enough fleet.
>>>>
>>>> As an alternative to reading memory.stat, introduce new kfuncs that allow
>>>> fetching specific memcg stats from within cgroup iterator based bpf
>>>> programs. This approach allows for numeric values to be transferred
>>>> directly from the kernel to user mode via the mapped memory of the bpf
>>>> program's elf data section. Reading stats this way effectively eliminates
>>>> the numeric conversion work needed to be performed in both kernel and user
>>>> mode. It also eliminates the need for filtering in a user mode program.
>>>> i.e. where reading memory.stat returns all stats, this new approach allows
>>>> returning only select stats.
> 
> It seems like I've most of these functions implemented as part of
> bpfoom: https://lkml.org/lkml/2025/8/18/1403
> 
> So I definitely find them useful. Would be nice to merge our efforts.

Sounds great. I see in your series that you allow the kfuncs to accept
integers as item numbers. Would my approach of using typed enums work
for you? I wanted to take advantage of libbpf core so that the bpf
program could gracefully handle cases where a given enumerator is not
present in a given kernel version. I made use of this in the selftests.

I'm planning on sending out a v3 so let me know if you would like to see
any alterations that would align with bpfoom.

