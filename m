Return-Path: <linux-kernel+bounces-818537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016FAB59302
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF49169BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CB12F83B2;
	Tue, 16 Sep 2025 10:10:57 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60BD2E8E04
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017456; cv=none; b=ANjOp35QUJHjdqNvCggb7Acnh5kdDq7tGjiuVMYY4eogFiOkTcQ+JWPkbNmchbSdnYOjBhIPEYy9+lYYZpRWu4zqS8nyKIjXz6wBFh8Ip0eEYy3Wgki35exM4XSFH0nMikNWzDaEWykc8yD1Fmfn3rbR/Rx0Kjxy5yRm5dgQNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017456; c=relaxed/simple;
	bh=/9wF0vy0tw5T0bKnAANkQEvrwPKBiKOdApMI1SEJeAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9eXey9oiRm0l4ZTGPJ5I/EkSWHosmIcpbUunzlOAuVQq9lFle6kh6scZrxEJXNzvjtP0cqrPnmc1pKs4w4t4OuCckxJVLvKHLBVt4bu4IrNF9p9kgIShH0bkXliJ+M0i9LNzC9Okc+2vJWaqJ5MpFxjdDd8IzxxapY7hlhZLx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-890190a3579so1402571241.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758017454; x=1758622254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1pUZdanyHlRQIc45clyhD7FxJZAK/SGkllVoia3idE=;
        b=pgY4FJH8eNXaKlWPiH9/yDPUvQTaOw83YveUikgM+/UPEkDpaye0vKUeICd/tgvPNO
         qY77jWxMY3Q5nWEOECehRKVsVtWQ9Dm15IGuUu8nbPbW72QdQXrywc8dvU41riny4+jw
         EyDAsEax1GkUCdT82sAuj/0DOMtRc94wcMZYl1ue2CHQsgO5QCI2IU0UgmugKpjuh9t6
         /z91DAo76MHptjnToEgaX3RcxnAG6xTfVrVxvlW/pvyvN7Os14ykEA2X26GCg135065o
         lXhYKmetRd5CRdJUbYpwXYcLvHm+k7zc/LyaNQ6WXqUyQqy/wS44HVUhwjsqkopQRMsV
         EYTA==
X-Forwarded-Encrypted: i=1; AJvYcCUrQ1bBCnSXvEC3wZFcLe5ggQ2Wt0Qdo0/OC02qt0wJqlYGD20CuKTCVxE6BtiYaiCcbEXPOfSU8prwEgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2y4yR47npKr5huQKHF4ys/H1i5L/L6C37qgV6PkrdNUD2H1C
	cZ6PG+uZc+usGnEjvt0FLCfkyCQ/ymdg4QgJ3YJy9bwB81Dgz4lil7fnWIl4e41x
X-Gm-Gg: ASbGnctUqC5i+QEjQFNqzbVL91WMYU6fu10nqkzTpXDt24Y9Goj9H5MqTSPyNHOEYEO
	ZXngayh7w5Kr2SLcifex4A4Nw38BUrgTBKikCGqusF6cSqsiPmhREYH+JzZe1oEg/ciKO60vvhy
	qHNRGzh4yxiKi00akpbEADgj/6O/42YuCTE8gs2M9bhCsl8Y31PhRNNXeRXRz+eiuksM567fvjZ
	C7cpEkTygE26V/xGtvoV7sJWXMjG5zJbOlbCZfEUZwS5r1fJ9/wJ9ZSEYM8/3izxQZaxLWmaXEy
	ErPsTKdHGI+5gmnDMBDPMK/EPjfY6Togtpo+Ne7k3mWGPI1uIeiofvN0POx36sgL7MWG8v1BUOi
	UA+YvsXguhvT21vvcQt3NBeR16E1MJnzmaG1wg7hZLSSLzJVk3ekrkrJkjJ8c
X-Google-Smtp-Source: AGHT+IHbi0y+xNhZB+N4ryFB4lYbS+TONJwNHIIui2TQ7b0+xvQqkhejS8jFhKcGIsVFPu/2WxuMRg==
X-Received: by 2002:a67:e707:0:b0:530:f657:c5d with SMTP id ada2fe7eead31-5560ecaceb7mr5579537137.20.1758017453538;
        Tue, 16 Sep 2025 03:10:53 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5537062ca23sm3339539137.6.2025.09.16.03.10.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 03:10:53 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-89018e97232so1501997241.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:10:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQE6ip2YHAJ6vXqficrQefNBp7m7eKECsEsyYkt8yM38hD/V5qQJuAGRxTfQjcZvvazap9o3EhgAq0W0o=@vger.kernel.org
X-Received: by 2002:a05:6102:418c:b0:523:d987:2170 with SMTP id
 ada2fe7eead31-5560ecac853mr4460438137.21.1758017452861; Tue, 16 Sep 2025
 03:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757810729.git.fthain@linux-m68k.org> <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org>
 <20250915080054.GS3419281@noisy.programming.kicks-ass.net>
 <4b687706-a8f1-5f51-6e64-6eb09ae3eb5b@linux-m68k.org> <20250915100604.GZ3245006@noisy.programming.kicks-ass.net>
 <8247e3bd-13c2-e28c-87d8-5fd1bfed7104@linux-m68k.org> <57bca164-4e63-496d-9074-79fd89feb835@app.fastmail.com>
 <1c9095f5-df5c-2129-df11-877a03a205ab@linux-m68k.org>
In-Reply-To: <1c9095f5-df5c-2129-df11-877a03a205ab@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Sep 2025 12:10:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV92Lu646bJ3cmEoR5C4rfkFsaf0E_uYPbSiLwrTtMbTw@mail.gmail.com>
X-Gm-Features: AS18NWBQnqcmNaklvhAZCp1NFZT2CLc-AZ2UDUvO79JO3zIGXT7yGUxg2731AZo
Message-ID: <CAMuHMdV92Lu646bJ3cmEoR5C4rfkFsaf0E_uYPbSiLwrTtMbTw@mail.gmail.com>
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic operations
To: Finn Thain <fthain@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

CC Adrian,

On Tue, 16 Sept 2025 at 02:16, Finn Thain <fthain@linux-m68k.org> wrote:
> On Mon, 15 Sep 2025, Arnd Bergmann wrote:
> > On Mon, Sep 15, 2025, at 12:37, Finn Thain wrote:
> > > On Mon, 15 Sep 2025, Peter Zijlstra wrote:
> > >>
> > >> > When you do atomic operations on atomic_t or atomic64_t, (sizeof(long)
> > >> > - 1) probably doesn't make much sense. But atomic operations get used on
> > >> > scalar types (aside from atomic_t and atomic64_t) that don't have natural
> > >> > alignment. Please refer to the other thread about this:
> > >> > https://lore.kernel.org/all/ed1e0896-fd85-5101-e136-e4a5a37ca5ff@linux-m68k.org/
> > >>
> > >> Perhaps set ARCH_SLAB_MINALIGN ?
> > >
> > > That's not going to help much. The 850 byte offset of task_works into
> > > struct task_struct and the 418 byte offset of exit_state in struct
> > > task_struct are already misaligned.
> >
> > Has there been any progress on building m68k kernels with -mint-align?
>
> Not that I know of.
>
> > IIRC there are only a small number of uapi structures that need
> > __packed annotations to maintain the existing syscall ABI.
>
> Packing uapi structures (and adopting -malign-int) sounds easier than the
> alternative, which might be to align certain internal kernel struct
> members, on a case-by-case basis, where doing so could be shown to improve
> performance on some architecture or other (while keeping -mno-align-int).

indeed.

> Well, it's easy to find all the structs that belong to the uapi, but it's
> not easy to find all the internal kernel structs that describe MMIO
> registers. For -malign-int, both kinds of structs are a problem.

For structures under arch/m68k/include/asm/, just create a single
C file that calculates sizeof() of each structure, and compare the
generated code with and without -malign-int.  Any differences should
be investigated, and attributed when needed.

For structures inside m68k-specific drivers, do something similar inside
those drivers ('git grep "struct\s*[a-zA-Z0-9_]*\s*{"' is your friend).

Most Amiga-specific drivers should be fine, as they were used on APUS
(PowerPC) before.  I guess the same is true for some of the Mac-specific
drivers that are shared with PowerPC.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

