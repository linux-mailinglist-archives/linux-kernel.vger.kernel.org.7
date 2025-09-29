Return-Path: <linux-kernel+bounces-836178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006B0BA8F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828B0189CB1B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20412FBDFE;
	Mon, 29 Sep 2025 10:58:30 +0000 (UTC)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782935950
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143510; cv=none; b=l+3vX2TlUiWepJ28GwNqHlaJNjka+N6xJ0yZqBE+VNVDneBiM/BBHKpJbVcB65r0JUEmQ8J7b8l3BZIoNlGYP4GKcA83ScT48y4vYNThX2W8B/t8jee0OkoZR7aBuWwYU2S0pzT9bF5/M3R0ngOzga8eVPUK5/jHfCb7P8nYwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143510; c=relaxed/simple;
	bh=AIov++tWGwEKyifuT48l+bxxj97iIWePTzxd3YrxKIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CC4y4KfXltoVoBsvurDL12KB5g856CznZaIdkSTgETDsa+u5Kj4NaSsyDKJw29Kf+RqX4+iEY0IwvxgEdPDtXy/oo34XT/BB3d5tAJ2kPjvuPysRxaMLDJThI9qdjh08JTlMLJ881p779jKY6GSLRiM5h4UvnhVipvQzsATPkPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54a94e39720so1580641e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759143507; x=1759748307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+MPZozySbtur1IZVuljxCO3XEppmGl3RjxuL+jZDRc=;
        b=Idnv0WuIbSOZ0XlGZfgtIp2LF0dwFQCZ+Fki4DQvZ4BP1NsW7ICdCigUO0PdAVSTZa
         dV5SlygZ5rEVy9alOu5djZiO0ojpLFksDZdVlLVqky21FGu/HtXW8au8qcRxx8EPqU18
         +WZhG0rj22Wav2M9XiGTccSI/Se1a7ZLMTvrkutBxUK5cyjiKnEwQ6IdjKZ4+zZOlGiS
         j5kDf1KNwhWnHwIr8oumbvZ3l1vUynk2OpJlZHcpvefWanAJ76OlE5fahZnwDTurlA7A
         HgJp97o18nR3hwno8pMbUu3l/eJsEp/r5F99I4vLs52zfLcHWTsRhY5pxtJjhJdpwnXJ
         bEoA==
X-Forwarded-Encrypted: i=1; AJvYcCUd9LTT6kRjiAuNuOsDoMu1wiE80HA1Zp5XprJHw5Zl0loYA5GGM49Bp0eRj1nQfM2eP0g+nhNf7To0aNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRoE2yn4+0TXTCaNDm9ONY+mutCjiwgDDpu41wtA5LskRuE0ql
	hUWI6yRDahPKIXZh29t2ThY7j+SKbNpMQoFOWCeTtHXRJkiIdSye2orH5yGz+fov
X-Gm-Gg: ASbGncuOrU8df9G5hUvJbAmYiPISTpE7Djwe1ayfy4Szg+/0zZmbfZ9AGUBijEtty6L
	FUSPcExqTcvwpUUPefEeTzdSgYQCA3DU1ByX+e5Xw5hV0DNyTuKZK8N9V2Xo/B/4AdgdZanrDjr
	0pI9BvKl3jkS7fPEly70nq/Hudn8LGCtWXe6LYuY26bFmWB/v2Q3Ue/la9Lk+vciMBE85Ae9ukT
	zg0Ip8doZogyWHibz1XoIJK6iU+Evk/0ZtOmxB/SLkKRwuM1IZrwOVLTzAdIXUS6EaNV+Mw4Cb7
	Y/hTLZ4R4FwAwaBDZYSfBgfhYgmjyJhiamcgKKFN0UPE+BvUsCPLr5lZyAz9zwweA6C/46m9PgC
	VNG1XU9NJJQndu+wh9L2+LBPFCfaGho1KwfkzMLDEERl+FEM92EiE6Se9wBLs
X-Google-Smtp-Source: AGHT+IFCid3LYq8i2usHRaUJMOCjwt3lOJMztQ4ItPMaLE9nMVeb3/A83O4ESaHjJVu8ltP4LmS1Vg==
X-Received: by 2002:a05:6122:1699:b0:544:9a46:7c85 with SMTP id 71dfb90a1353d-54bea1f6407mr6276834e0c.4.1759143507200;
        Mon, 29 Sep 2025 03:58:27 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bed60fdaasm2446874e0c.0.2025.09.29.03.58.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 03:58:26 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5a3511312d6so1955613137.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:58:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyYuhsamZUrjUwLovB6tUO+tbDGjcDmrQFpdP9VaXlUX4kVrr1G5BTD5sPUkW+ZmmwcMa3iBVpTTRA6IM=@vger.kernel.org
X-Received: by 2002:a05:6102:50aa:b0:534:cfe0:f864 with SMTP id
 ada2fe7eead31-5acc473077dmr6450963137.4.1759143505642; Mon, 29 Sep 2025
 03:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916163004.674341701@linutronix.de> <20250916163252.100835216@linutronix.de>
 <20250916184440.GA1245207@ax162> <87ikhi9lhg.ffs@tglx> <87frcm9kvv.ffs@tglx>
 <CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com> <20250929100852.GD3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250929100852.GD3245006@noisy.programming.kicks-ass.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 12:58:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW_5QOw69Uyrrw=4BPM3DffG2=k5BAE4Xr=gfei7vV=+g@mail.gmail.com>
X-Gm-Features: AS18NWDQJuqnAIK-2DUIq8EbZk99RAekWX-gMhtGREaGuJ754MDAMcZKkUQDKxM
Message-ID: <CAMuHMdW_5QOw69Uyrrw=4BPM3DffG2=k5BAE4Xr=gfei7vV=+g@mail.gmail.com>
Subject: Re: [patch V2a 2/6] kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang <
 version 17
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <nathan@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Sept 2025 at 12:09, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Sep 29, 2025 at 11:38:17AM +0200, Geert Uytterhoeven wrote:
>
> > > +       # Detect buggy clang, fixed in clang-17
> > > +       depends on $(success,echo 'void b(void **);void* c();int f(void){{asm goto("jmp %l0"::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto("jmp %l0"::::l1);return 2;l1:return 1;}}' | $(CC) -x c - -c -o /dev/null)
> >
> > This is supposed to affect only clang builds, right?  I am using
> > gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04) to build for
> > arm32/arm64/riscv, and thus have:
> >
> >     CONFIG_CC_IS_GCC=y
> >
> > Still, this commit causes
> >
> >     CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
> >     CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
> >
> > to disappear from my configs? Is that expected?
>
> Not expected -- that means your GCC is somehow failing that test case.
> Ideally some GCC person will investigate why this is so.

Oh, "jmp" is not a valid mnemonic on arm and riscv, and several other
architectures...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

