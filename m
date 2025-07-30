Return-Path: <linux-kernel+bounces-750721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D071B16039
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3501AA1933
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B163D221FCF;
	Wed, 30 Jul 2025 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLOI1mXw"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B40202C45
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878024; cv=none; b=AQcaGf1IZCnCSHnjLJEJdYekHAvo5tJ0OE5/FscdTRg9Ido396zjBNtsTNkVzfiRJQqqejQktGUc1/PU3EXTqmuTGsbxPVNOvrOSd75wK4HIluHUjKFXqsxYHJuvkgHkNehlmaHyXe85uLkezX4mLejRlUHL0YOiDCigr3rBofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878024; c=relaxed/simple;
	bh=zjiPu3cXl6sEosXyDz1t5PBP5oTsBy5Yj1jiRGlgaT8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F+Ca1BfAkXs5rGAbio+Z9lUzzqcUvopGHgq3GtfN15HBcB8rTvRB3VY5Q/siGnsEBSMozAKjeIOhLUYOFGEFv0yURfdwfW3Dgqd9jeHycGtqwcpuuZjar1vDO2GeFQb8wG6z7E938FO+DZZ1LB5opjkw8fomUe3teH0cx1PUbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kLOI1mXw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso525200f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753878020; x=1754482820; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6RCIk5vzFfP8iX+aivLku36+ce7/VFd7gJpq5Z9shY4=;
        b=kLOI1mXwksdHqonMMvBClC1WJXcD0dhONYmEwMdGtoYNt/pTlMMN6Wi4ypu4PITR64
         o0TnDxlZ03xM54Tx6ADsL5LfyLBDRXqtCEziGPZZ57DbOMVJ8KEKBxKZtQp+fhHXlP+x
         qHPfkzGsBLGOPXTtyuqpclAbkM/znDJMt0Lk4yKCuEA+yTLZm2NjQJFIzmZEzJxemktF
         DuQGlfZdmtLTUh45XSE7gJxlfzM9uEulJU8XK5vWhqAAxXBNl4Y+KSleSJ8tcl0HFuRs
         z9N0Vcw9y58KCc5eAmEpNVXWYgidII0J5PE143JTou89iJYVhIzHN7yJIaD/eeIi47vX
         emuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753878020; x=1754482820;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RCIk5vzFfP8iX+aivLku36+ce7/VFd7gJpq5Z9shY4=;
        b=dWNuDNmJQId1kItVaPYescqV4bNrRbyFlLb/m5a/ZcM/fXv6vZ5nJ6uppHMUbAX/y4
         9RMjHhwkWfSBbYgZzyz2bH2PIEhnckDBWffGoaIk2GG401r9WBE17Vu6fffnHQIvp2G9
         kO47CLrI4Npm4ELdEcZpo5361K5neGZoWbmsHZW071xFESoSZZDZApQo0isxIBzBv0Lu
         Tub8vYa0lT8LZHIb7Iy0Qy5SnXo4MgsZTZNxhlzHVN9NU9V1HG+1cPhhROR2C48ZdBUQ
         AHKcZjE8T0aj74Pd1hQnhR/A4SzN9UP1slx5Q1yelGZgbDjcd1d+4yamytSPkLpajjIW
         WkgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF3/bxyEV6DZL2FBzqfbjxSR7MTEfKFr58PM7j5aGKrR5AjL8kru1O52TzUWcnGF4ydbphU4mJ9dXaYCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Yp/IZ/QOVp/ofRV12VJ51khB/lHBVFGk5/b41n/A+idSu535
	8bER8gX6m+jCBy4BSZaK2UzCSMPGSAyAO2YA/3nBVj1ZQkOhvoBElYEkJfx9TjT8wW8=
X-Gm-Gg: ASbGncv9t1XnoOgKGOBvhaQnkrKAKZkYCR7xBQPnYF0gi5rtnHBYxAzPBirnXXElOTl
	6/jUFdwFach9JIdHz3CNKswBj7gRgCGLalY/6j6o5j6KYX1PsMynXKLV+lNldbPRdMmgFiMmab8
	nAGe6RSLLDdSjCIDxNaeAWLSS8tIRDTjj3HyjrihQXAegCPtX5lfjhdV1mQvrB59WMGnFKqCnXw
	Gb8jdf4tWvm3mmcF+MLgZzpLkTTUDtPW7SmJuDJWXxEqWAZqBPE2KVaW1l8aGcoLqnibRv1faDP
	jHerog4dR/T3LdQWO0WFnjfyzxsXXtai53K/Q4wyfDoKhLYnTTm4BqVQRq+s45Omas/CbGz4qUu
	U99k3Zg/Dq4PC7GInNtqgRIrmLQ==
X-Google-Smtp-Source: AGHT+IEf1nLZq2A/9qjF7cMRwVowf6aVMbDmzAl3uBNou1TtuZ9IH3zr/KEDQxg/DBhbKFpXNNTITA==
X-Received: by 2002:a05:6000:2003:b0:3b7:908e:e4ac with SMTP id ffacd0b85a97d-3b7908eef14mr4440299f8f.2.1753878020074;
        Wed, 30 Jul 2025 05:20:20 -0700 (PDT)
Received: from [10.1.1.59] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78d45d010sm6980865f8f.8.2025.07.30.05.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 05:20:19 -0700 (PDT)
Message-ID: <0c8cc83bb73abf080faf584f319008b67d0931db.camel@linaro.org>
Subject: Re: [PATCH v2 2/6] futex: Use RCU-based per-CPU reference counting
 instead of rcuref_t
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kernel@vger.kernel.org
Cc: =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>, Darren Hart	
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar	
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra	
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Valentin
 Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>, Andrew
 Morton	 <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Michal Hocko	 <mhocko@suse.com>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan	 <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Date: Wed, 30 Jul 2025 13:20:18 +0100
In-Reply-To: <20250710110011.384614-3-bigeasy@linutronix.de>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
	 <20250710110011.384614-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-10 at 13:00 +0200, Sebastian Andrzej Siewior wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>=20
> The use of rcuref_t for reference counting introduces a performance bottl=
eneck
> when accessed concurrently by multiple threads during futex operations.
>=20
> Replace rcuref_t with special crafted per-CPU reference counters. The
> lifetime logic remains the same.
>=20
> The newly allocate private hash starts in FR_PERCPU state. In this state,=
 each
> futex operation that requires the private hash uses a per-CPU counter (an
> unsigned int) for incrementing or decrementing the reference count.
>=20
> When the private hash is about to be replaced, the per-CPU counters are
> migrated to a atomic_t counter mm_struct::futex_atomic.
> The migration process:
> - Waiting for one RCU grace period to ensure all users observe the
> =C2=A0 current private hash. This can be skipped if a grace period elapse=
d
> =C2=A0 since the private hash was assigned.
>=20
> - futex_private_hash::state is set to FR_ATOMIC, forcing all users to
> =C2=A0 use mm_struct::futex_atomic for reference counting.
>=20
> - After a RCU grace period, all users are guaranteed to be using the
> =C2=A0 atomic counter. The per-CPU counters can now be summed up and adde=
d to
> =C2=A0 the atomic_t counter. If the resulting count is zero, the hash can=
 be
> =C2=A0 safely replaced. Otherwise, active users still hold a valid refere=
nce.
>=20
> - Once the atomic reference count drops to zero, the next futex
> =C2=A0 operation will switch to the new private hash.
>=20
> call_rcu_hurry() is used to speed up transition which otherwise might be
> delay with RCU_LAZY. There is nothing wrong with using call_rcu(). The
> side effects would be that on auto scaling the new hash is used later
> and the SET_SLOTS prctl() will block longer.
>=20
> [bigeasy: commit description + mm get/ put_async]

kmemleak complains about a new memleak with this commit:

[  680.179004][  T101] kmemleak: 1 new suspected memory leaks (see /sys/ker=
nel/debug/kmemleak)

$ cat /sys/kernel/debug/kmemleak
unreferenced object (percpu) 0xc22ec0eface8 (size 4):
  comm "swapper/0", pid 1, jiffies 4294893115
  hex dump (first 4 bytes on cpu 7):
    01 00 00 00                                      ....
  backtrace (crc b8bc6765):
    kmemleak_alloc_percpu+0x48/0xb8
    pcpu_alloc_noprof+0x6ac/0xb68
    futex_mm_init+0x60/0xe0
    mm_init+0x1e8/0x3c0
    mm_alloc+0x5c/0x78
    init_args+0x74/0x4b0
    debug_vm_pgtable+0x60/0x2d8
    do_one_initcall+0x128/0x3e0
    do_initcall_level+0xb4/0xe8
    do_initcalls+0x60/0xb0
    do_basic_setup+0x28/0x40
    kernel_init_freeable+0x158/0x1f8
    kernel_init+0x2c/0x1e0
    ret_from_fork+0x10/0x20

And futex_mm_init+0x60/0xe0 resolves to
    mm->futex_ref =3D alloc_percpu(unsigned int);
in futex_mm_init().

Reverting this commit (and patches 3 and 4 in this series due to context),
makes kmemleak happy again.

Cheers,
Andre'

