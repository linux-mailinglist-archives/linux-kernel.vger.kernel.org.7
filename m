Return-Path: <linux-kernel+bounces-867958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5233CC0402F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 986644F252C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D161C831A;
	Fri, 24 Oct 2025 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3MSdKDJ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC71B532F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268813; cv=none; b=Y4X6IcZC1nsoLAaNO+AbSui555v8xxmVBNcwQxc3DKkuAXe0BM5vwT7eMbatfyGpqXo23x4JoAIE8i+DFHlrAj4pojVC7B8sdciUt4eYdCFq6vBR1dN5iSPIhKTRfjul57gDgtSs0xjyniljVXQNmX0jbKU5Muu9fDsdyBzc0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268813; c=relaxed/simple;
	bh=8IYAyusncA0WDWQnsh5pBKEVIwZxhk9CGVxXMJ7jxGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1ppSW0PJZ7tGEJjVNPqn4MDGd7jzpRHlM4UWpQLHaFonp6na0juZTGha1A/r57oCb91NHrvkT/YnKSlHtKy44N4lNt9+qVuhfZhELc2Nlziz+6fxy+xP6yrQv6r5sDYfugFHu6QE8xqcPp7o0iZWmJmzqI08xxhKG/pb9LeVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3MSdKDJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47495477241so12129555e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761268809; x=1761873609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy50PIQ5NMkORVfUN5Id2ZgmraUO4+QWD/JL9v9VhXk=;
        b=U3MSdKDJyGV0VN95Fo8Qj0o9kYcaTL6FCjlRTv79vjZq0Ol9zmpedCAGjeTgON5EqJ
         n4CnAm02ufLW6aALLuwG/0qaL00Jr68SrIJ+jhU2WaVUoQPswRr1fVrtdUr8Cq9mToBl
         s3Zoh1S8UQS06nkItFKvd33wJgYQ/mCZ/8KXzyTGUcs/KrWg3MpJ/SMvf8XkRpwcvQO4
         nkJT7VN6od+mvxmHgxxz4hvFtQL4f05Z6FKs9+hw05fN3TCadLcLo0gmhYtQnr9SnDHZ
         IJkTCw+4SZNO26CJSbtHa1V8YRF8aN3z4Xv95E9etBDx315UZ1UR7wD1AXK4a+tvbapN
         IrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761268809; x=1761873609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cy50PIQ5NMkORVfUN5Id2ZgmraUO4+QWD/JL9v9VhXk=;
        b=b59P0vSlUD5lqUgis22fsuO/9+RdFzUpG18Qn6rZysGa4UVgOChOwUUrjMgEvoEfR2
         V43Nyf5rG9/RwJLPzS+14FYbIjwJRxLBexSzq1rtO9b0lZWTNAI2H7iFjutNRGGeUhyX
         mhOrs1uVgu/AfKcRXmoDb8JXJR8+4tvLPTd+ZW/WLvU1iwLtyHRcJxVh3qhAXh0JgBu1
         AJuGp2IZvju7/ZihFXa819m1mvsqBJfxTkIItsAQvyEQSN8EFhpzgZmqc13UM7uQTbnT
         4GA5wsYifY5Ls4n8TeKcWsyzmMNrtMzAaKBu1K67G3WKa81l+sfmBe3kM28I36jBKD2u
         OysA==
X-Forwarded-Encrypted: i=1; AJvYcCVcRbUiWIbC63CTbewERTM1H6aGI2H4bdvnwNWYmbgi4C+dcOI6WvpC9Q8LgFzZWfwtjCvOFMpPDpKlvMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZL7Zg8IOOe2BomXGQzP9sNKWxhYSLlLzUq9XosmpxMFnmpvq
	hYoQQYyLLKCA5A+HS7TBXlOkuKO5KPAzpfGBjOmovtArt6MNtyU6hXebw6y6bhOJnyuoqbqWMli
	1TC2BW8lVGkqqDnESPLpBSBauO7/sZRM=
X-Gm-Gg: ASbGncvIZ2b+bGbUEnfUuEpXo5DOCI8D5eaYB/JTrhM4yhz477EH+/fZZpoVPyHoQOu
	KqY38Lmehi/m0M8TP5JEmt0rbqQWeHtqFiqcsi/9xq/KPY0MmJODedhBlx5tkZ1qRrxHKOLBz/V
	DXD7ud1ds+dbDrERB3HKWF/RgPH5buBYkfm6aUAXP47ZqnH7YnW6Ybk3ysd9zpLC8rFhelpVjFU
	liNp3+EhDcdq+LGoD1WjkPiEiI5zFQHBUTNQhXFM8wRcvJBe8iOZsI994iTybtgO+U6laGSNcf7
	auAH6s+itxK43cM4350EaIg72eOaKQ==
X-Google-Smtp-Source: AGHT+IFcsv1if8cvL8kTlEejCx/FQgqyt5yCy0bJs0SYJkx4Iq5kMise7FkEaCwdtzjswF2CqR/fouTnY/43pxfDv9c=
X-Received: by 2002:a05:6000:240f:b0:426:d582:14a3 with SMTP id
 ffacd0b85a97d-4298a040705mr2343679f8f.9.1761268808604; Thu, 23 Oct 2025
 18:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023131600.1103431-1-harry.yoo@oracle.com> <aPrLF0OUK651M4dk@hyeyoo>
In-Reply-To: <aPrLF0OUK651M4dk@hyeyoo>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 24 Oct 2025 03:19:57 +0200
X-Gm-Features: AWmQ_bm41GuiWsYtz5XuMNDIQQhr0EMvmp-bLNyUrjc6_dWg-wZ67Ora4xbHgfU
Message-ID: <CA+fCnZezoWn40BaS3cgmCeLwjT+5AndzcQLc=wH3BjMCu6_YCw@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: ensure all metadata in slab object are word-aligned
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
	Alexander Potapenko <glider@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Feng Tang <feng.79.tang@gmail.com>, 
	Christoph Lameter <cl@gentwo.org>, Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:41=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> Adding more details on how I discovered this and why I care:
>
> I was developing a feature that uses unused bytes in s->size as the
> slabobj_ext metadata. Unlike other metadata where slab disables KASAN
> when accessing it, this should be unpoisoned to avoid adding complexity
> and overhead when accessing it.

Generally, unpoisoining parts of slabs that should not be accessed by
non-slab code is undesirable - this would prevent KASAN from detecting
OOB accesses into that memory.

An alternative to unpoisoning or disabling KASAN could be to add
helper functions annotated with __no_sanitize_address that do the
required accesses. And make them inlined when KASAN is disabled to
avoid the performance hit.

On a side note, you might also need to check whether SW_TAGS KASAN and
KMSAN would be unhappy with your changes:

- When we do kasan_disable_current() or metadata_access_enable(), we
also do kasan_reset_tag();
- In metadata_access_enable(), we disable KMSAN as well.

> This warning is from kasan_unpoison():
>         if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
>                 return;
>
> on x86_64, the address passed to kasan_{poison,unpoison}() should be at
> least aligned with 8 bytes.
>
> After manual investigation it turns out when the SLAB_STORE_USER flag is
> specified, any metadata after the original kmalloc request size is
> misaligned.
>
> Questions:
> - Could it cause any issues other than the one described above?
> - Does KASAN even support architectures that have issues with unaligned
>   accesses?

Unaligned accesses are handled just fine. It's just that the start of
any unpoisoned/accessible memory region must be aligned to 8 (or 16
for SW_TAGS) bytes due to how KASAN encodes shadow memory values.

> - How come we haven't seen any issues regarding this so far? :/

As you pointed out, we don't unpoison the memory that stores KASAN
metadata and instead just disable KASAN error reporting. This is done
deliberately to allow KASAN catching accesses into that memory that
happen outside of the slab/KASAN code.

