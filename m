Return-Path: <linux-kernel+bounces-896136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547AEC4FBC4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263D43B4E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E804234251E;
	Tue, 11 Nov 2025 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwDoggz0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIxybuA3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6F33D6CB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893856; cv=none; b=k/w0GlPGJ/j22hTVQBM2FIxGRF+O0aYIpkxcrjncFwQS2KXJsPKs8VTVvD0nan87cdZVw2+yEwxHEC2nVYAHNpWTPYCX9mcMAW0Yr7P/u4AqNXgxMKBlUTAheyWVwC7obn3xWvJQ26fzr1VqQYomN+G6lwkHeVMDNHfCRSL+iKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893856; c=relaxed/simple;
	bh=KXktgaFtHxbgxAtA3SwBBXkwSUqJQm9IFU9cuHXEKpQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eAPj1hSLrc7NJoz1bPBBKHw4G9j6zrBAFx2VI8Feiv/yACQHCIijqtlYHMLzxNuI90ea86RULezytz8g1C7wfsezikuErRKVwrF1LmmDw3/EwQ+ehd2UBx1fDQY4810O/z9+I1GRfBTOWvfpZyZk5KfOeITXDuAeJktmYnNh/nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwDoggz0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIxybuA3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762893853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AouMFoYtS/g71aagKlLU9Deonq3urwuQMJX7R1T1Afc=;
	b=YwDoggz0AQS5XV5w3RbBJzmzAGMh9KqpKmKUXfH07jPKkSQgtsz5MTviWRgUpVX3S399Z5
	PC5IEguQ0TWt2NOkh715B+SOFjk+jOJrdqcqhlEPW1TrfYYQd/ConoHjdFLaOx2D57MtYG
	1EBfW3HWCJqRE+IuNeAsl+bHUoQnYFo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-LtKbbP5jPBKZs2g9O9RWaA-1; Tue, 11 Nov 2025 15:44:12 -0500
X-MC-Unique: LtKbbP5jPBKZs2g9O9RWaA-1
X-Mimecast-MFC-AGG-ID: LtKbbP5jPBKZs2g9O9RWaA_1762893850
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4edd678b2a3so2062541cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762893850; x=1763498650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AouMFoYtS/g71aagKlLU9Deonq3urwuQMJX7R1T1Afc=;
        b=JIxybuA3xFJtVQqFi0/OXPZL+3Bt6dLVYM+WH94ey+/Gi1Ax+S9vGi8Hzf+NxcK7V/
         n41Ru0iiZgAdX9ZHNMOolqQwm7wuoORg0WrK2ImSTBbBC6B48uEn3RUGwSlHuc11lGkn
         ebFlqScy158Kdq7COoUZuQJuh380/DZJNCWVqkpaRDHFzQffcvMkUY+f0cky+IxMgE0M
         LjEkh7yv4Ow0UiiF0fitDpYPv4xrutp9auCf4ew08kRW2ALXRqjGWMKYmbt3UuPKChUR
         bZm/U1RShntXPagB/ax9PC21+uv+y+yXstwzASx0LeMDkJOT0qjqeL52QDVPBNFaFzP2
         HnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762893850; x=1763498650;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AouMFoYtS/g71aagKlLU9Deonq3urwuQMJX7R1T1Afc=;
        b=EcCBRix1dezfmU6dr2V1rCdchiFHCl8ZFYS3SWsP3BlOPoUiIDeYUJ+Fv2NkTPqXbJ
         HHd5ugP4+Hda/QM/nUJf0NSgEmRbHrkzoYfWJOOUQdHV3h4HJR+MEEcscJwhwXNgPOUz
         KakKQZ9YuM3aZvwpZH3RvQ/xwSvhGjsnOM0ugCk7FgTi/o4cCSnKmsZxPbZjpvxf+by1
         SefLZd7qjihWSc39uyEoB2QwC9T+wudfE8i1RnKADqKwV1nFy31zATf6gMV/V2aV+Bnn
         u6oQebrWdKwBlpBi6qkbpwcAZ6ul7SsGB7tp4TJ46FMIOJ6lz5U9hWbrxZEf7FdhTlv7
         xMkw==
X-Forwarded-Encrypted: i=1; AJvYcCU2TFMl0Gh/bHGzMt1oHiQ+bSipg+fPevJ4YDNgKTaYEhDFfT4kOzNmskInzHFhT5+P0mFk8IH5RG3A3Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKMponmHuSkEvRECmEQqjSyQZ1K1xGQ3PbJaUUPXfsJonqr8u
	GPfLrDRQOS/ASBoOn59d8p0TJweRSPZK2b8c9awLHYN9n72ytAdc9xUrE4ujy4B9Nk+KiOHrlNc
	+5ffd4V114lKKnk8jiUs0MEJadaFZzMfRkNq22XaesTFVquRYE9mOVJovXOt3l9F/XwEefMf6mA
	==
X-Gm-Gg: ASbGncsC30dEsSmIlhdL8eNAE+KiKh0E6dLrkBBlZxYsiMM6MPb4q61KsQ6QOD5+2V3
	VdPurGy+MGLiy2EUIx3jQHaBlml3Gk49ZDC5dhsMD10szmuH3BEZdV/AZHUBizyW7Fz6q5H1FZ1
	63IC9MOw6wZ+dkbftjtqkHRtgACwIZgU9VEjdDqPKoo3aics3dNhTMdPS2JnkRd4vQSXTmQ54CV
	nhA8ti4UdILqiZGb7vTFQ4GfhHwbFhZdhqwRZW9BYUQ1TxHWJIIySFr4qfb6edUIFuEPW3qG7ri
	97B61YWbZbj6TGQSZwZ/nwqGU2kQPRAyHdWiG9/UINEGqvMCtgm9atVkHsUsT3vhbzFihW7BV8c
	n0A8AG+GG4Jwm3A+BwSRN12EEkEywW5i6uPb76ATBKJjyFg==
X-Received: by 2002:ac8:5f8f:0:b0:4ed:b83f:78a3 with SMTP id d75a77b69052e-4eddbd7785dmr8990271cf.47.1762893849845;
        Tue, 11 Nov 2025 12:44:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE61o27JhGsft3MQNQXeIYKNMG5x6jKVgyaMvlVyyB9523TiIR1DvWB2nD07G01lezcrWTZAQ==
X-Received: by 2002:ac8:5f8f:0:b0:4ed:b83f:78a3 with SMTP id d75a77b69052e-4eddbd7785dmr8989821cf.47.1762893849371;
        Tue, 11 Nov 2025 12:44:09 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4edb56e2173sm55990661cf.2.2025.11.11.12.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:44:08 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <061cdd9e-a70b-4d45-909a-6d50f4da8ef3@redhat.com>
Date: Tue, 11 Nov 2025 15:44:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
To: Michal Hocko <mhocko@suse.com>, Waiman Long <llong@redhat.com>
Cc: Leon Huang Fu <leon.huangfu@shopee.com>, linux-mm@kvack.org,
 tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 akpm@linux-foundation.org, joel.granados@kernel.org, jack@suse.cz,
 laoar.shao@gmail.com, mclapinski@google.com, kyle.meyer@hpe.com,
 corbet@lwn.net, lance.yang@linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20251110101948.19277-1-leon.huangfu@shopee.com>
 <9a9a2ede-af6e-413a-97a0-800993072b22@redhat.com>
 <aROS7yxDU6qFAWzp@tiehlicka>
Content-Language: en-US
In-Reply-To: <aROS7yxDU6qFAWzp@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/11/25 2:47 PM, Michal Hocko wrote:
> On Tue 11-11-25 14:10:28, Waiman Long wrote:
> [...]
>>> +static void memcg_flush_stats(struct mem_cgroup *memcg, bool force)
>>> +{
>>> +	if (mem_cgroup_disabled())
>>> +		return;
>>> +
>>> +	memcg = memcg ?: root_mem_cgroup;
>>> +	__mem_cgroup_flush_stats(memcg, force);
>>> +}
>> Shouldn't we impose a limit in term of how frequently this
>> memcg_flush_stats() function can be called like at most a few times per
> This effectivelly invalidates the primary purpose of the interface to
> provide a method to get as-fresh-as-possible value AFAICS.
>
>> second to prevent abuse from user space as stat flushing is expensive? We
>> should prevent some kind of user space DoS attack by using this new API if
>> we decide to implement it.
> What exactly would be an attack vector?

just repeatedly write a string to the new cgroup file. It will then call 
css_rstat_flush() repeatedly. It is not a real DoS attack, but it can 
still consume a lot of cpu time and slow down other tasks.

Cheers,
Longman


