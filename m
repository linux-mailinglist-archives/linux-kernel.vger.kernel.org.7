Return-Path: <linux-kernel+bounces-886522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14124C35D06
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4A96205C8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674EB31D379;
	Wed,  5 Nov 2025 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVAqOpsS"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567B31D371
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349034; cv=none; b=rOxf6u5k+S7Ea6MUkAo/QwVPeXB88ZiR1ozZ+Seu+KC3fWmm0J5rMuhwObPEJ7TTCZlmqsTROPh/c9LOHFFXRZa3xhPGcKIW15XnTJFdk4IRerSkDHDqeL71nD6180WvzQoyUEKKe/DVykF6VLrnd8bjs/bQ1juyKsIS2H7CtUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349034; c=relaxed/simple;
	bh=s/94gijIF0XRuyDVkC8CAXhywzL9UjqQBpellCChGTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Te4pjbrTky5AeTQbOfr5caVxLxH2mDOfs9a+OcABhgeMOk/1DYSsTNbO0c7A5o6695bRGbky3uUCrUj9K6DAeu0HXJFoGf0VZRQcXHoD6COmup9wC/Jkfk/OvhCmuwkC8XBkHOwllxAo4n+dP28IEiGSxDTUutG2QNXk87hJq1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVAqOpsS; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a33f49018so30464171fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762349031; x=1762953831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WNWzl9UPAGqC0OeojGWF3FUUOCD6lJ7lBCWbQ62ZwI=;
        b=YVAqOpsSGvKYDPLoztpTZUQpcXAqF7Sh5EkX0naLQpd3lXJyWYNDgzURhuSMqjwvY+
         /fsAXl6rl66QI5aytr9CHvZlc7yQ6lmILUm9+dvyf6ywUZhel9t9xy0Gy+TT6j1YrW2g
         dqO1v4qS/qk191CknV18ms0h7NUfMTU7SLrjv5sfUEKhozsn/yyD/X7e/XLyg46/1WRU
         BAJYXoX6KYZMoHlKisQA4vjdQZ79NnEu2IuN4RI3l6j0OpJyzkyhoALElXIM3FGn9zws
         o39wmj3WajEJVWnLU6t37ccIdY++EwH4Cce0wWMKC6g3C7NDYz4H5Grb8z2WEMWonUVT
         PHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349031; x=1762953831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WNWzl9UPAGqC0OeojGWF3FUUOCD6lJ7lBCWbQ62ZwI=;
        b=mLlc8/3/ZbcmRog+JCVBxBnd1uUJFPp02Rt1jlF7bmkbAWI0zUJOj714ePnNwO+KMO
         28hVu5HAV2vPZZlq22QJKW3//shDiT8OYBiftoH95LQd9vcYNnWWePGliAsr2Ma0+ZDX
         3H1n1id34VqNSbYrtywpWp3b6yN9HHIhNXloaNLD+5airJiq/KaqwdCzMjSwzay+WUKX
         bP+jvs0dUkU8nBoc5dvDmnaXrJhHmWt+VGP8DQASfxgut4DMfoKr1Q0VTekjJoUywWPN
         8Ztg9yJOkUTI+PQe0BB7Pk1AhQK/tUIMKbsHBuSxVZQcYdCK/Pt8G/Brn/IlmPRluoHE
         ihLw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ6S6RmKnye7qlPl8KCybsKCl8ZWO/OHNaalrx5tQBKIX7M7TmnpSFIeSAJoM6eY5kZNqFZno6mK8zftc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUBTQvFJUC2C6+VY4aw3RQeG+jpFaJuINH2YGE+uFH6yL7SJrm
	HToJren8F2B+NVnM0WrNYIoBvfloVulwdP/yMpc+mC8ekbe+er6EA14c3Iz+g7huvip/Vp10dWq
	odXHMWIy0vFYgo5mp+b2dIesKsZEl5bg=
X-Gm-Gg: ASbGncv/9eXxa1Yhb3cWypgk5GYHrvtSkFRg9Wtyt8U54/gsZuZvzBuSXrIPk/VO2GR
	gPh9ehA3BWYo0a+E5xB+Asuc0icUguDxt5qT5laKTFIL6yHGqBc+S72pSunbTkDZbLRG73hPGED
	yWiLZML9FD8HU4q+q4WVDu3TJ2wArz30bfy9yoo5K58EOgfmjUZ9LEctuqyTwXR60OkOUGZJrzK
	cBh2am1z1ugYvd43l2yztqBoAgkm3pGJNALSk3gOgKAjm2L8bAgLex0xGMCCjAB0k4Web12qKSV
	OS033c2ASFKZ
X-Google-Smtp-Source: AGHT+IGdn3dvXTFfnd26oUCEg5vL/XwsKbx6eN6B7iFUvvLn+iruzlQSAGzvDJ9vCiy6F+m/VX5r20KcdkbP0rV3R/0=
X-Received: by 2002:a2e:a109:0:b0:37a:3033:16f6 with SMTP id
 38308e7fff4ca-37a5142e2c8mr9741151fa.35.1762349030972; Wed, 05 Nov 2025
 05:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104003921.9707-1-akinobu.mita@gmail.com> <aQo1VjjQw1OZG8nY@kernel.org>
In-Reply-To: <aQo1VjjQw1OZG8nY@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 5 Nov 2025 22:23:39 +0900
X-Gm-Features: AWmQ_bm7dSG6fty0drtbxuWvBO6bGxhtYdnsjyRSa0aF5n43MfZsmtccLtweZyg
Message-ID: <CAC5umyigiSS+ynr2JnNSaR3irW0eEWFuUVnJvY2QvJJO4yfP-A@mail.gmail.com>
Subject: Re: [PATCH] memblock: fix memblock_estimated_nr_free_pages() for
 soft-reserved memory
To: Mike Rapoport <rppt@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=E5=B9=B411=E6=9C=885=E6=97=A5(=E6=B0=B4) 2:18 Mike Rapoport <rppt@kern=
el.org>:
>
> (added Dan Williams)
>
> Hi,
>
> On Tue, Nov 04, 2025 at 09:39:21AM +0900, Akinobu Mita wrote:
> > memblock_estimated_nr_free_pages() returns the difference between the t=
otal
> > size of the "memory" memblock type and the "reserved" memblock type.
> >
> > The "soft-reserved" memory regions are added to the "reserved" memblock
> > type, but not to the "memory" memblock type. Therefore,
>
> @Dan, do we really need to memblock_reserve() the E820_TYPE_SOFT_RESERVED
> ranges?
> Quick scan didn't show anything that requires this, but I could easily mi=
ss
> something.
>
> > memblock_estimated_nr_free_pages() may return a smaller value than
> > expected, or if it underflows, an extremely large value.
> >
> > /proc/sys/kernel/threads-max is determined by the value of
> > memblock_estimated_nr_free_pages().  This issue was discovered on machi=
nes
> > with CXL memory because kernel.threads-max was either smaller than expe=
cted
> > or extremely large for the installed DRAM size.
> >
> > This fixes the issue by improving the accuracy of
> > memblock_estimated_nr_free_pages() by subtracting only the overlapping =
size
> > of regions with "memory" and "reserved" memblock types.
> >
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> >  mm/memblock.c | 33 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index e23e16618e9b..af014fa10a44 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
>
> ...
>
> > @@ -1826,7 +1842,22 @@ phys_addr_t __init_memblock memblock_reserved_ke=
rn_size(phys_addr_t limit, int n
> >   */
> >  unsigned long __init memblock_estimated_nr_free_pages(void)
> >  {
> > -     return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size=
());
>
> We have memblock_reserved_kern_size() that tells how much memory was
> reserved from the actual RAM. Replacing memblock_reserved_size() with
> memblock_reserved_kern_size() will omit "soft-reserved" ranges.

Replacing memblock_reserved_size() with memblock_reserved_kern_size(
MEMBLOCK_ALLOC_ANYWHERE, NUMA_NO_NODE) also fixed the problem. Thank you.

