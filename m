Return-Path: <linux-kernel+bounces-868991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D95C06AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CCEB342471
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EE51B532F;
	Fri, 24 Oct 2025 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRFCyJDK"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC1119DF6A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315476; cv=none; b=imXzdtYBF8+OYmXmm17YuyR3vIBtY8EhV4bkn/lRDulpecnFZoGuoQnWBHJS6vLj3NMefpLHIN9SGjCPwwcmz6EcnF/R5kUbLhS+0zRb6f35wbADoXMDdJ40suN1WVWxCOMkDxCv9f1bEfISkVOmTVyYbmSWXwl4fOqweMNANQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315476; c=relaxed/simple;
	bh=SNTn99TnA1JaXfaY3Rpqv497vvNlynqkAU5Ssl8CUuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4aUZQvwrrjfOJLRrb2Si9O3IZjGXjHM+SQLvsieb7x9oZIDc6cXXwTPOw04IPGbtQITC0+W0d13oxAFrEsaWVJbs2mvoY/9ulaYdYOkqeLbf82GX/FNyX2jTTNDgRk7jRbW4TwhwFLFaSrr4vUw2mth/tVRvh2RTQuAghWl9ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRFCyJDK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475c1f433d8so17592515e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761315473; x=1761920273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNTn99TnA1JaXfaY3Rpqv497vvNlynqkAU5Ssl8CUuk=;
        b=WRFCyJDKuENbfW3+hDiSXsKVE1PvKA60xs7D6JNalaw+rXGGIIFgjoASvcYNJbhh/p
         WPqbahGcjVe7Ezqfa9j4qEU5x8elEypYFoi3oMnR8yFZXluEe85JD7ozlCxk/KbpoR1C
         zk0GMKzVcEBiTt+bVvod4DJAbN3rRgIUc5Imu2TBIvPrsIdDFv5zKBsxkMLThn69vxZP
         E6oU2SGTFE/4qxncFwXgl7LLMvDoNmgr9a8ZAq+hVUYh0DTN4kVGO/Z+xpzwfW/DEVQw
         GsNBFRBEOKM76u2xbSmneqOFfCFS/5v9nXAIMzgn6pfXpk6oAFECBy6UVpX49NJsoYl2
         1hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761315473; x=1761920273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNTn99TnA1JaXfaY3Rpqv497vvNlynqkAU5Ssl8CUuk=;
        b=EVzSlYkneyvt6sTroIWapcMr2dX2qTsyaUd60DWCzg3X+Jo5ZUCa3VPDK+/4Ma1/5E
         vk9S9+/xfQrA69V7TGYI8yWgjp0Rm3bZo/hgrYnXAwpHcphSfpQzkCcpFqAy+/bmwAcl
         1RHd+PsybBLgkmWPKxQSYPuLvNnY+3XXoaFf3C80aTpYdiyntEceS8mQhYbeFZM5CAvT
         qEoKW0onRoHFUYc28B8YGJOhvmqcTNFZKyVJXNtyHkVo2cMZvpLkKxf9X9vQB8HP/FON
         g/5kxp7UoL/3YeQEHaeZZIIYiAV4NjkcFuUn3w+EUMq+AbkVSgfqBuxUE3BTqJnGszY6
         +vhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/o92iFYU0ryv96nUBNrcyDIbOwXJ6kZHUowsLTI6huXVE9af3WULIOmAEKXm5MI6W2aK8gg87N0QfiqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxik7Mo1DBMANIb5SAXlrfuWvLP6BMqXY9q3mfnAspBieygDYOx
	C0UQbBFckxEQw53ZiWdCDkmKCBYKnujDj5UKmP/rA0FySnySNSN3x4Xe3TC/Dm418wl96vB323O
	+faMOF/8BkhYhETdux5+5qoygcW5RV64=
X-Gm-Gg: ASbGncvQa3hSo/8UoeDX3w3e34pMrFd29cdpLe/xIkmQTIpgk2hK32clquwCL3ey/n5
	T/TC4pLcDmPMOTTlmUdqVgAZX0yQSs53w9zUq2ePN2EQAUQPhJsJPMtVPrNP2Q32UL+0Zh09bNO
	SPjAKim6y/Sfygmjvog2IKAPNJ35EOMsuc6pxvU1X2s7dAiv1YiGzeaX2/ojGZLzVJt8xkjitSZ
	ZnQ7LRbDcS+4ybgc/M0ZuuOUYlpj/LkW57HQMQE2zbZ2JFSxgYR2AUgBjfsP4DjoKMSzB7TVWX7
	cahXwVfRrE0iFYfBsFJtIJjr17TVHqA1rE5gh34D
X-Google-Smtp-Source: AGHT+IFX/G3bo8Uoav+A3W6y2COb3eJCl2p4q4v176xd43F6DF6xlmRapKd53ZZrE98dyTCCRF3vN4Q17nc/YbCzBW0=
X-Received: by 2002:a05:600c:34d5:b0:46f:b42e:e394 with SMTP id
 5b1f17b1804b1-4711793473fmr217356125e9.41.1761315473041; Fri, 24 Oct 2025
 07:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023131600.1103431-1-harry.yoo@oracle.com>
 <aPrLF0OUK651M4dk@hyeyoo> <CA+fCnZezoWn40BaS3cgmCeLwjT+5AndzcQLc=wH3BjMCu6_YCw@mail.gmail.com>
 <aPs6Na_GUhRzPW7v@hyeyoo>
In-Reply-To: <aPs6Na_GUhRzPW7v@hyeyoo>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 24 Oct 2025 16:17:41 +0200
X-Gm-Features: AWmQ_bka8VrwR-Z0b8RrCs_zbS1hTWfVkUFTv-W6umfuWyIbEP-ZV0vS8gZH8jE
Message-ID: <CA+fCnZeMwOE1EwuP-3Xrs2e0qp_A5eo2aiXB_q243GiLFZV-=Q@mail.gmail.com>
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

On Fri, Oct 24, 2025 at 10:35=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> w=
rote:
>
> > An alternative to unpoisoning or disabling KASAN could be to add
> > helper functions annotated with __no_sanitize_address that do the
> > required accesses. And make them inlined when KASAN is disabled to
> > avoid the performance hit.
>
> This sounds reasonable, let me try this instead of unpoisoning
> metadata. Thanks.

But note that you still need kasan_reset_tag() for HW_TAGS KASAN: this
mode is not based on compiler instrumentation and thus
__no_sanitize_address has no effect on it.

(There's been some discussion on making __no_sanitize_address work for
HW_TAGS: https://bugzilla.kernel.org/show_bug.cgi?id=3D212513#c2, but
this was never attempted.)

> > On a side note, you might also need to check whether SW_TAGS KASAN and
> > KMSAN would be unhappy with your changes:
> >
> > - When we do kasan_disable_current() or metadata_access_enable(), we
> > also do kasan_reset_tag();
> > - In metadata_access_enable(), we disable KMSAN as well.
>
> Thanks for pointing this out!
>
> Just to clarify, by calling kasan_reset_tag() we clear tag from the addre=
ss
> so that SW or HW tag based KASAN won't report access violation? (because
> there is no valid tag in the address?)

Yeah, kind of: kasan_reset_tag() sets the pointer tag (the top byte)
to 0xFF. With SW_TAGS KASAN, the compiler knows not to embed validity
checks for accesses through pointers with 0xFF in the top byte. With
HW_TAGS KASAN, the CPU is instructed to behave the same.

(This is slightly different than kasan_disable_current(): with
kasan_reset_tag(), validity checks do not happen at all. With
kasan_disable_current(), the checks happen but the bug reports are
ignored.)

Thank you!

