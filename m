Return-Path: <linux-kernel+bounces-753547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7002DB18460
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82E2188E3FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB89270542;
	Fri,  1 Aug 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7wOJ3ne"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C4D271441
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060352; cv=none; b=G48wT/8gOsUklF3ZE2dbOS9olf2LX2v5aRAaIcWfiiMMZZcy+yMP4KGGDQTXbfi+tklA9o5NjGdx1K2zHVOy/ENWG1vxJd1OCpNGD2DrQE6r5aW2DDIssNNCdMTnG4321kSVKHGFGFHTe37ERUpv7krckQeo/siicEW/pTa/xdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060352; c=relaxed/simple;
	bh=4BjNwYs5t/TeS7JMzM3vUjVwMjprEYq9o5942+GXyQg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fx7QrMSJK6TVHeWk/uKc4pY1FkDOY6MAg6i+664/ZwGP9g7Uuquhievg1eEPRrYM1ZXiEB+VN6mj6MEnp/eTgzWsrewP9XpgL46VZfUwukv7lznXjoQCrWXKjmpPCVw+qDoxQonqBm2+dhNrkieDVEVypP9xTK1nR81wkIajPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U7wOJ3ne; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45896cf24ebso9828555e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754060349; x=1754665149; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4BjNwYs5t/TeS7JMzM3vUjVwMjprEYq9o5942+GXyQg=;
        b=U7wOJ3neI4blSrVG/7f3gr9vrakC1qqEE7RvLiDY774yjaxjMqoA218E1j0YDmT/kR
         DIIVxvemXWDrwkbPoK079HG8KQmoTvVC70l20XOmR+HEo2Yt35NR2zi4nq0kopIAofGN
         XD0l9bi5CsDMyNhIStwdFn7ZKHKRIYlBizMReZ1YfSuIsqaDJBTBevwtFG+rvcO3Ztuy
         GXOkPB80EeKt5sq0lH1rlPS8hosyuu7ENt/mH+NQsIJPL0zlRur2n/LjeYWRZRMihRqd
         C6mJpoeYNeD5UPT4jEL+Wp4Qtt2vnbhirjoAdW8Uvu1anv4MR+EqzPweVB7t1uiQyX/T
         O1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754060349; x=1754665149;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4BjNwYs5t/TeS7JMzM3vUjVwMjprEYq9o5942+GXyQg=;
        b=xUSa3wZ51gst044s++u2QPnXg+e8W5/GCSmM0Cotux2W1e+mrvLTXKi0YMArS0/cBx
         6rl9RLqi67XeQD+VLQFZGCKwMWyWPF+2CG8nDEwPehIs5Auo8O0CwlZtNC0QZ9gQVu1+
         gEzn0dZ+78TzsG5YJPgB6wjSTLc/RNgA95fZWBsFU5pC61ViumVDvd7DxcoKN4Nu1Qpl
         lG0m+NnhAH1jZzsqXfsb9MmPUNz2WXggwiUrGOQQYDElqqlEeyHu7UMR+Fe2IwbJM8Gp
         LCYZdTKaQEMP1GCNU9/i85ipil0DnNuR0FmniWopMRHgJqeyFDaeGXhfgjURcrW9Vyw6
         CMZg==
X-Forwarded-Encrypted: i=1; AJvYcCWZj9cwlj6lP0/jCcUwqpfD2as2h64cRzy7Z88g6jKKDn3QRqD6MtyUyO0xK10rBOnJPsUYmGUwWWbGCGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1+9CbnPG4uNdWfbsZhkETAODW8cOdl1vOpMrr9jJJjxAUlL4
	Eukzoi0PSzLmcNh3tBGqio9FgIhgGQsLPSkzElMbqE5T9WDKZqygchx3huMDSQx+9sE=
X-Gm-Gg: ASbGncsiZg/rge2ktswHjrN6yskS76lJqMVb+56nbJ4r+JyCKALXqdo1zl+l/3IiKv4
	jT67pjRwR3j8eNNXPpsfJr1Wvo05Ey169StheJg7gRcZVjQcaHnZhCiFGGYRThlB3ouCTqDIApn
	Kq3+nUbwRqx1S/Imd7J66fqfz6WNs/8sPEWvoOQeP3SNVYKfeq/woaSfIZRraaKqEJ4GGxhZjYe
	KhJYAaeMdUkRo9lKt3FOXiTLEBtKUw3btvlvtlibF9KHjelL5VnGIqTBFOeksJ2aMEY8/EONnKx
	OUlluht4GIYODOzuZaeSlswpxVaW0cRe2KQ1eaJe1oL1CpmJQBxDHzLbkoRsea/RWklVmeSp8He
	5fZSOVMGqBLSqWg4I9+L6/dsXCHRRH7nQuqZG
X-Google-Smtp-Source: AGHT+IHFVWbDzd1wxGcMpL06tK3u4JPh9n7RnrlNMdR93I+jSvHQrSHrY2AbiMq2wTWtpQtNYOwDMQ==
X-Received: by 2002:a05:600c:8b65:b0:441:b698:3431 with SMTP id 5b1f17b1804b1-45892bcfaf9mr93121045e9.28.1754060349100;
        Fri, 01 Aug 2025 07:59:09 -0700 (PDT)
Received: from [10.1.1.59] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458a3038121sm67756345e9.1.2025.08.01.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:59:08 -0700 (PDT)
Message-ID: <188efc4a8e37bc5dc64dd18989f9a254ef218449.camel@linaro.org>
Subject: Re: [PATCH v2 2/6] futex: Use RCU-based per-CPU reference counting
 instead of rcuref_t
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
	 <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
Cc: =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>, Darren Hart	
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar	
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra	
 <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long	 <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes	 <lorenzo.stoakes@oracle.com>,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport	 <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka	 <vbabka@suse.cz>,
 linux-mm@kvack.org
Date: Fri, 01 Aug 2025 15:59:06 +0100
In-Reply-To: <87ldo5ihu0.ffs@tglx>
References: <87ldo5ihu0.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-30 at 21:44 +0200, Thomas Gleixner wrote:
> On Wed, Jul 30 2025 at 13:20, Andr=C3=A9 Draszik wrote:
> > kmemleak complains about a new memleak with this commit:
> >=20
> > [=C2=A0 680.179004][=C2=A0 T101] kmemleak: 1 new suspected memory leaks=
 (see /sys/kernel/debug/kmemleak)
> >=20
> > $ cat /sys/kernel/debug/kmemleak
> > unreferenced object (percpu) 0xc22ec0eface8 (size 4):
> > =C2=A0 comm "swapper/0", pid 1, jiffies 4294893115
> > =C2=A0 hex dump (first 4 bytes on cpu 7):
> > =C2=A0=C2=A0=C2=A0 01 00 00 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ....
> > =C2=A0 backtrace (crc b8bc6765):
> > =C2=A0=C2=A0=C2=A0 kmemleak_alloc_percpu+0x48/0xb8
> > =C2=A0=C2=A0=C2=A0 pcpu_alloc_noprof+0x6ac/0xb68
> > =C2=A0=C2=A0=C2=A0 futex_mm_init+0x60/0xe0
> > =C2=A0=C2=A0=C2=A0 mm_init+0x1e8/0x3c0
> > =C2=A0=C2=A0=C2=A0 mm_alloc+0x5c/0x78
> > =C2=A0=C2=A0=C2=A0 init_args+0x74/0x4b0
> > =C2=A0=C2=A0=C2=A0 debug_vm_pgtable+0x60/0x2d8
> >=20
> > Reverting this commit (and patches 3 and 4 in this series due to contex=
t),
> > makes kmemleak happy again.
>=20
> Unsurprisingly ...
>=20
> debug_vm_pgtable() allocates it via mm_alloc() -> mm->init() and then
> after the selftest it invokes mmdrop(), which does not free it, as it is
> only freed in __mmput().
>=20
> The patch below should fix it.

It does. Thanks Thomas!

A.

