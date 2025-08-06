Return-Path: <linux-kernel+bounces-757351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B71CB1C124
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72A6189DEB1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7110220E005;
	Wed,  6 Aug 2025 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQT5k3Nl"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633ED171C9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464633; cv=none; b=k5nbpdANsokA0XYITiKXSav/BUSe0QpH5zOk6pkWNs5P6//WUAlfBvJiaPE+DXlE+i6sFgCDLESEZ/hw0upE8/s8f1dtnp6liYcqMhHXWtbpYI9YpQdOVesTCCiOJkWPHOkxGtN9m0fiF2VQHqvicOKMlgv7ob8xi3EuWQixA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464633; c=relaxed/simple;
	bh=xiLeZQeTnlMSaH/v0LpJn+/rNetTHoFQDVZsVqQaTTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUjUBFR6nQYW1zY1eGKE6U0BSrlUL7VlJ5lJLzEg7aMpc1gKofKgxNvhQUXbaiMtOohJwzAckxWYc0N0zLYCjF+TDd0qqKxGQtaqoV81ZjMx0yDVFSS1shu4ZadFHaoPEge3CepwjntfWe8bUdYrULkDwNK8Kg9HYM5zkwfsD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQT5k3Nl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23fe2be6061so4760045ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754464632; x=1755069432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wXLDPCGDjNvdOeR7jZ736CzN/nAMcYgqmwaHMi4ddf4=;
        b=DQT5k3NloO6eIJYvT2KGQpyv7YYWFFhgRbavwm+r6XPCY3wHTWmgdmPze4nY9b/G88
         EgmthFwQkFI8B8EJCsin2w/PJje0PZBoJx6zoGdcZMr6eJ04XjQY1WZYdD8NeReYxYP7
         mNDHwhGbIlGGVZjOy+20vRgzgOfW1QTGxjwzPqT3GeOHCve7cA4WZKpnEoABqEydI3q/
         zr3HngC9aWdGwInunoNI5+m3S5mNbpHdswO20l//N7MBvRmBJ1MEDJKojjzC+tftKUjC
         6uWS1RbDI1+FXRQMPu6mC5LWrRWWgIoni3fjwzwVaMNl6wYnb/jPDwgnihe3EuF4rUEA
         Z/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754464632; x=1755069432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXLDPCGDjNvdOeR7jZ736CzN/nAMcYgqmwaHMi4ddf4=;
        b=X3UbUInkHbUXk1c8TH97Lpzwm9za2tysLYo4hhArIQQjPiLjxCmNr7QGv2nPLu6zYC
         8ttEQSbmMxDHG/BjOeLUxXBlPr+rcPeDsxJBaeTcvYa5mOebRv9BUjodE8IvINGY7UkG
         AmEWg9IAa1EzXMkkLJm3ZRWUl34vpOwUvzo8Ehsv9jEiv4G6wBv4fDWY3CC40ySDwjZv
         iq9TnQJw3xrlschgM+PyBrm+YtGS9kU/Z45JsD5UiIQ9GTe90QaHGjpawwFVzSLkTDVb
         0IjNSa8K5hz9J4bLEZ258nsebt///c4WjUTWDTVpUs02wPriMiiA0JF5znVFOKsh1fNA
         mHtA==
X-Forwarded-Encrypted: i=1; AJvYcCXcPbQZupQ9u8++gx+LcBvHTBGq8Gp5MfEarbXMfQvr30+0RhFel7G0up0QYZh3MZZ9YBnYCaZATUuCJdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUHjTFSRKDmFwiUhqkWHSeIsHEqbZgJ6K/NLUyQjwAzRmZzm8C
	n81iO/DcPSjez38WzPJVOZIJhd4zYoLjNcb2T7fxuYYqeqD61yZhvgANtqFuS54ypYA7Tqd5pYM
	+AgBBm8SYkcjliBKGoNu3xxpYxK4q5vZhN4a/EPjr
X-Gm-Gg: ASbGncs0ZXusLCvbsQp1Pe/TLfKRzXS+vlz7eJfr2mEGltR51HA6MZzPjx3/wSe8HB/
	sQy+0bhsVmBKcWXKukrg15Wzf97OG4b6B3ToQxvSx27DRRdbWQuxLA5ckv8RfTdewyhwpjT5ZXb
	HzSx/DMRQalRpUkm8QjeR4j8BpYvMes+dCIHlnSTJaB9sR9Xk/erPRih4bAkyHfVx/JiHLu0E7Z
	8HbgT2LuiEUnIoQ7JfdHb02leAvztXdvlcB/gs=
X-Google-Smtp-Source: AGHT+IGfHgl2Mg+qBoCrK1ngL7bmW44UgruqWF91vJSpnlAVaiAXHK2sy4pm6D5yit5Nm36Buca8JPYmaeowROChcNw=
X-Received: by 2002:a17:902:f691:b0:23f:75d1:3691 with SMTP id
 d9443c01a7336-2429f959eacmr24836285ad.15.1754464631438; Wed, 06 Aug 2025
 00:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805062333.121553-1-bhe@redhat.com>
In-Reply-To: <20250805062333.121553-1-bhe@redhat.com>
From: Marco Elver <elver@google.com>
Date: Wed, 6 Aug 2025 09:16:34 +0200
X-Gm-Features: Ac12FXwlK-cs-vH-SavIGCKnyqqqvtGaUUbmDgA0yfosyX6KUMYZkchuphMeuWE
Message-ID: <CANpmjNP-29cuk+MY0w9rvLNizO02yY_ZxP+T0cmCZBi+b5tDTQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	akpm@linux-foundation.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 08:23, 'Baoquan He' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Currently only hw_tags mode of kasan can be enabled or disabled with
> kernel parameter kasan=on|off for built kernel. For kasan generic and
> sw_tags mode, there's no way to disable them once kernel is built.
> This is not convenient sometime, e.g in system kdump is configured.
> When the 1st kernel has KASAN enabled and crash triggered to switch to
> kdump kernel, the generic or sw_tags mode will cost much extra memory
> for kasan shadow while in fact it's meaningless to have kasan in kdump
> kernel.

Are you using KASAN generic or SW-tags is production?
If in a test environment, is the overhead of the kdump kernel really
unacceptable?

> So this patchset moves the kasan=on|off out of hw_tags scope and into
> common code to make it visible in generic and sw_tags mode too. Then we
> can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
> kasan.
>
> Test:
> =====
> I only took test on x86_64 for generic mode, and on arm64 for
> generic, sw_tags and hw_tags mode. All of them works well.

Does it also work for CONFIG_KASAN_INLINE?

> However when I tested sw_tags on a HPE apollo arm64 machine, it always
> breaks kernel with a KASAN bug. Even w/o this patchset applied, the bug
> can always be seen too.
>
> "BUG: KASAN: invalid-access in pcpu_alloc_noprof+0x42c/0x9a8"
>
> I haven't got root cause of the bug, will report the bug later in
> another thread.
> ====
>
> Baoquan He (4):
>   mm/kasan: add conditional checks in functions to return directly if
>     kasan is disabled
>   mm/kasan: move kasan= code to common place
>   mm/kasan: don't initialize kasan if it's disabled
>   mm/kasan: make kasan=on|off take effect for all three modes
>
>  arch/arm/mm/kasan_init.c               |  6 +++++
>  arch/arm64/mm/kasan_init.c             |  7 ++++++
>  arch/loongarch/mm/kasan_init.c         |  5 ++++
>  arch/powerpc/mm/kasan/init_32.c        |  8 +++++-
>  arch/powerpc/mm/kasan/init_book3e_64.c |  6 +++++
>  arch/powerpc/mm/kasan/init_book3s_64.c |  6 +++++
>  arch/riscv/mm/kasan_init.c             |  6 +++++
>  arch/um/kernel/mem.c                   |  6 +++++
>  arch/x86/mm/kasan_init_64.c            |  6 +++++
>  arch/xtensa/mm/kasan_init.c            |  6 +++++
>  include/linux/kasan-enabled.h          | 11 ++------
>  mm/kasan/common.c                      | 27 ++++++++++++++++++++
>  mm/kasan/generic.c                     | 20 +++++++++++++--
>  mm/kasan/hw_tags.c                     | 35 ++------------------------
>  mm/kasan/init.c                        |  6 +++++
>  mm/kasan/quarantine.c                  |  3 +++
>  mm/kasan/shadow.c                      | 23 ++++++++++++++++-
>  mm/kasan/sw_tags.c                     |  9 +++++++
>  18 files changed, 150 insertions(+), 46 deletions(-)
>
> --
> 2.41.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20250805062333.121553-1-bhe%40redhat.com.

