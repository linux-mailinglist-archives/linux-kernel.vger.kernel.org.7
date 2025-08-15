Return-Path: <linux-kernel+bounces-771094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D286FB282D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE136172AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F090829E0EF;
	Fri, 15 Aug 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guu1WztW"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390F319844
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271279; cv=none; b=j1iDTzbXw/9s9IXs4Z+IRMI3Wn4ovoLtYw4kwjohPJBTV8X1o2z3ASi36JtyiQwJN69KdUkgmIiRChcZzp7dbl9S3Hbq8HSOFmJcNqRxovIst115++eE5zurX15giUN/X35s0+KJHBoqHiL3MaxIE/LNz/+bTTufr+A10rizT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271279; c=relaxed/simple;
	bh=X/6ldqOjIEBOQyY9WQnGzCyCAJUUmFey8lDum83dx4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWYKYNaWngxC8xfANHvwWE87xwbwtlKjl8qhM00pPyXJvYVglz3ylssXBiu4Hz5nRhoM9uaDwUXE3i8u2iMyGRnTOSQuIq2KCx4EF9lDx76Y/mrAdQOsNvlL9nTIqKG/hyH2uwJgutl76BuTN+XNNR4nKwakCcNjzMjandsMPFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guu1WztW; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4717390ad7so1453674a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755271277; x=1755876077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PneJNxQnmLIWm+5oNFTyeol/SNmSmTg8BXa2eLZkhW4=;
        b=guu1WztWJvMJcZtCPRhxrXfZxLD/sTK/PLJKfmw04GmFVoNdmRago5NGls1Iq0m/YR
         HUO8bOgxatl2twXawOZpnpDmXr3IF03/2utrJoKyEHlAswkoQ1YbdQzP6YFPiiZ6Quzv
         EP73f40pjbx+u/VJ7fobr25WlzDMMMeWSPAUlz+3zGBNaQCPnCnRXrhHuannCQJQCKSE
         KlCOGapQ3EVUZasjCMTgJa6PWQN9FzH7WqxwqvgVxGWLg3rdhl9N3PDIdGi7BSL6I4/o
         dM0WxusyGcEL2cDpQ/ObPY8PFyKpD3Z7VA42jMENLCaPVcjPE5qZUEoYtZ7y584jFY30
         VNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271277; x=1755876077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PneJNxQnmLIWm+5oNFTyeol/SNmSmTg8BXa2eLZkhW4=;
        b=StNHe8OKL4q2XzCFzVQ1K5ksNHUTr7axN0lCbzps8o1p05zB+7Pf1KoA5v/T8UPf9r
         LbM3zZBh7+/8Y8LoWprMTVSvoO7x6UU7uKkupm/HlItmOvhuXLzecRdSUonJ3gNHR2W2
         +8mLTRKM8Lde283gYSoGIYDWX8OoJtKXzPH83QwAk+NoGJTJ4+7n6FDPMlgL8dO01/RW
         hk2tQdmNhhY+lRLITYBlouBnJUlk0O0AuYNy+qt5tnubo+hxribhvo/uDtptrUHnUhLT
         LDle7GlfycPXiws24egUeu/5J7isE1uw8QhtKMMRMWU6bwDYixhpzWAXCCLdr9RGWI4V
         uYKw==
X-Forwarded-Encrypted: i=1; AJvYcCWMFSYT3yACq/ZOif3trsZn1EtSdCcQ7QGQ6RQXXAD1NDz2qQxWBObGxmSB2tg800Z22unbRTBatevnpSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeZspgugABHaVldgfOODL1PfUZ9mV4FsSKkvKGYSGQZi0jVAtP
	ORkqEMWC0mbkhVDv99XKiNL/qbl0b75YtldQigG4i1q5zWt0ioFvVy6S
X-Gm-Gg: ASbGncug1H8mpxJAf34jLXDjJv+Wao3w89KKTmqzc/ugPcQTFRvgibyouEqmOGb7pC5
	7LfVN8jdTXvNhZlDWHiZj0YPHnnQ2j5qn8TOhv2u0b4e+lWRF0WnTGkqXTFVRYCDy7GpW7aDQaH
	CsSAlJUMWJ8uCp12/DehXw55Ld4FkhAobHJ4JkOcXo7+fT5wnyn78MJxaxaSw07qjbCxmahKPD3
	f1Ob6VzawzlebShNWw0HLrmHrZuc4THoqoGPt1I7lgmn/dM6dusx9lAk5yGI5/jA6oDIDtzL7PC
	gKjL6ypFzZq10+xHUaGTt7QEBRRgaSpSKG5mPGpbQX5eT2jE2hVpEm8s53sPuZh7jp96gzxBMqz
	yUIM/Rzsyzdx7+HOlNqnI
X-Google-Smtp-Source: AGHT+IFRP0TgRI1LJWt+ukv4TCLrzZ9WJOGSF67Bq2/JNdqHeLeqxJH/Dh0Ama38et71dawyAoAiSA==
X-Received: by 2002:a17:902:d54b:b0:240:5c75:4d47 with SMTP id d9443c01a7336-2446cbc4db5mr35856215ad.0.1755271277025;
        Fri, 15 Aug 2025 08:21:17 -0700 (PDT)
Received: from vernon-pc ([114.232.195.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f581sm16359275ad.83.2025.08.15.08.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:21:16 -0700 (PDT)
Date: Fri, 15 Aug 2025 23:20:55 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, glider@google.com, elver@google.com,
	dvyukov@google.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, muchun.song@linux.dev,
	osalvador@suse.de, shuah@kernel.org, richardcochran@gmail.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/7] mm: memory: add mTHP support for wp
Message-ID: <aJ9QJ2V0WQ5XneJx@vernon-pc>
References: <20250814113813.4533-1-vernon2gm@gmail.com>
 <20250814113813.4533-7-vernon2gm@gmail.com>
 <226e21a5-8a8e-43a0-bf5f-12a761f49a27@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226e21a5-8a8e-43a0-bf5f-12a761f49a27@redhat.com>

On Thu, Aug 14, 2025 at 01:58:34PM +0200, David Hildenbrand wrote:
> On 14.08.25 13:38, Vernon Yang wrote:
> > Currently pagefaults on anonymous pages support mthp, and hardware
> > features (such as arm64 contpte) can be used to store multiple ptes in
> > one TLB entry, reducing the probability of TLB misses. However, when the
> > process is forked and the cow is triggered again, the above optimization
> > effect is lost, and only 4KB is requested once at a time.
> >
> > Therefore, make pagefault write-protect copy support mthp to maintain the
> > optimization effect of TLB and improve the efficiency of cow pagefault.
> >
> > vm-scalability usemem shows a great improvement,
> > test using: usemem -n 32 --prealloc --prefault 249062617
> > (result unit is KB/s, bigger is better)
> >
> > |    size     | w/o patch | w/ patch  |  delta  |
> > |-------------|-----------|-----------|---------|
> > | baseline 4K | 723041.63 | 717643.21 | -0.75%  |
> > | mthp 16K    | 732871.14 | 799513.18 | +9.09%  |
> > | mthp 32K    | 746060.91 | 836261.83 | +12.09% |
> > | mthp 64K    | 747333.18 | 855570.43 | +14.48% |
>
> You're missing two of the most important metrics: COW latency and memory
> waste.

OK, I will add the above two test later.

>
> Just imagine what happens if you have PMD-sized THP.
>
> I would suggest you explore why Redis used to recommend to disable THPs
> (hint: tail latency due to COW of way-too-large chunks before we do what we
> do today).

Thanks for the suggestion, I'm not very familiar with Redis indeed. Currently,
this series supports small granularity sizes, such as 16KB, and I will also
test redis-benchmark later to see the severity of tail latency.

>
> So staring at usemem micro-benchmark results is a bit misleading.
>
> As discussed in the past, I would actually suggest to
>
> a) Let khugepaged deal with fixing this up later, keeping CoW path
>    simpler and faster.
> b) If we really really have to do this during fault time, limit it to
>    some order (might even be have to be configurable).

This is a good way to add a similar shmem_enabled knob after if need.

>
> I really think we should keep CoW latency low and instead let khugepaged fix
> that up later. (Nico is working on mTHP collapse support)
>
> [are you handling having a mixture of PageAnonExclusive within a folio
> properly? Only staring at R/O PTEs is usually insufficient to determine
> whether you can COW or whether you must reuse].

There is no extra processing on PageAnonExclusive here, only judging by R/O PTEs,
thank you for pointing it out, and I will look into how to properly handle
this situation later.

>
> --
> Cheers
>
> David / dhildenb
>

