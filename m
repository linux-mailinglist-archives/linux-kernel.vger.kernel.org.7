Return-Path: <linux-kernel+bounces-836199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A60FBBA8FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0EA3AFE3C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872B12FFDDB;
	Mon, 29 Sep 2025 11:10:32 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9B2D249A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144232; cv=none; b=cVTULUT/8Es9iyezPAbgJFVmzPeMzvCNpw9PhEw01LpmmVffC7TW9YCvmRAkUXaqqXcHULNDE0pQQgM0IBWb1rrD+x+JRkJQ+JEBt2bcbIdNyUSkO/YHkoYe6/wOpp1DhjnLd73OgGqgtwaX+9pA6V8M7Sd1C+2w0XK0gx1D4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144232; c=relaxed/simple;
	bh=Vub8S/uaeeP/i/sARgDCmpVy3EEPQtjFb9sPbB8ndsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibt+SvN38qUhjVcE/FjzYlQa8+yiPhOIw8kSNUzWRmdAyfcbBJ/x2tEUUKASrriWBhw6bOPmQ59tXzJqktJWIum42hDD8ugzsOAPy/Swzo7zYx+rRUD3tolCzIn0bIuiHy7xNLUnk4waq0ME3OpOSidWpuBBlVYk33XPQ7IQxBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-528d157a48cso2918763137.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759144229; x=1759749029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLLC+wbxjpk4XmEv75JaQLpBxns7cUiLP7TpNdTyiBs=;
        b=c1S/0DA5pQv3xicLqScOHWiN7/AZ4ZHyAI9LxRo6nGx3nq/t76Kjn2PuO86KSPnJsS
         F/joQHtnR+u04QpInFpjrgoLlsNibzYAJQEDixYCJ9ltuFrf3+DWMr3Ay/xdN7e+fHv7
         C8ZoiqsFyz5zkZWs9PFt2shaACEM6lDMvr+TKoJhhn3yw/u8dns+blE9gBhS/JWByrja
         TCj1OOSET3kuWHUynZs3Mf2rvAwzSQ18atrBha6v+T9E3NAKr4y3gSIjhghYZX4zzLog
         2YMv/7nYLO9EuDdngxFSbnN8Xv37kCexYWgx/NrdhGWT+Xd2RyuqtZFtMXiilIgPUD0c
         0DNw==
X-Forwarded-Encrypted: i=1; AJvYcCXy7+MqGY+7niWwSbSMlUqWOzWwQyX/kEQxBgWiYmANwRgoZ4ju5RFYWeeDbD4qIV5nc2F+N4/OwpP912A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOHYj5pl6BwV+NfZAtLvHUqno8b24OWILFc88M2iFLWKXSpLm0
	rTC56sx8gUB1ODH2Ou1rbgSPcnSK6pVNxoFGYLRx9Qm6AAVw0ShZ5OyAelR3VMFh
X-Gm-Gg: ASbGncvFRSDjTMjJJTQ6xzi5/ZIGOvSoxtSn3eIaInHTti4plreDyXYHBe+rbXjp5wp
	rqPgjRgLbET/1AMsWHdBt9E+6vMRh3KX5ZYPQYl0hGcUdJS2I/x2zmFXCk1JABXKuK75eM8Jg0o
	yJlQIYDp0iGCSXeJGNsK2sP6QxCIBTxiDthpI4PBblosTWzol4kVrultm1US+wSrhjC522U37NX
	MlPAqqJxN1RJjUhtTBh5+yf+eD5wBNe1vm3w36MsVFKtay8uW+vZzcjJFXYnz4z2vVw2zxnSBoF
	MPOhu6Yo1XfRle/LXDza4zvUhjUIDeZzQqD3rtlS6j7t2lLfv/cjnYaHnb/LNKwKA5cB9S7bnAh
	0KbJWSOQOuOfMs2G9P6rKMw1KJaqWYhnIUHLQiYJ1+tEmocOy6DN6kRvVso1pirif+nYAy3joOY
	s=
X-Google-Smtp-Source: AGHT+IGflOfVguE6Zcr4PrV8Wh0Tp/I6NVnMhjQtdbb72ejQSrTmVZQgdzAnhQ/7Uy2DV2xMSH1Xdw==
X-Received: by 2002:a67:ea10:0:b0:5a0:a095:9a2f with SMTP id ada2fe7eead31-5ceceea8a2amr43862137.3.1759144228886;
        Mon, 29 Sep 2025 04:10:28 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916d1518f84sm2388121241.6.2025.09.29.04.10.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:10:28 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54b21395093so2918308e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:10:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSBRZ3C0q5Yh9cLKZp4QnHhimg34pgGQnmzmhhTBdJj3AKmfAYCsY75uPYUKeo9cNjjrVnmcSUHe9GkK8=@vger.kernel.org
X-Received: by 2002:a05:6122:e004:10b0:54a:89a2:21ad with SMTP id
 71dfb90a1353d-54fc419339bmr57791e0c.0.1759144227855; Mon, 29 Sep 2025
 04:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916163004.674341701@linutronix.de> <20250916163252.100835216@linutronix.de>
 <20250916184440.GA1245207@ax162> <87ikhi9lhg.ffs@tglx> <87frcm9kvv.ffs@tglx>
 <CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com>
 <20250929100852.GD3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdW_5QOw69Uyrrw=4BPM3DffG2=k5BAE4Xr=gfei7vV=+g@mail.gmail.com> <20250929110400.GL3419281@noisy.programming.kicks-ass.net>
In-Reply-To: <20250929110400.GL3419281@noisy.programming.kicks-ass.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 13:10:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWtE_E75_2peNaNDEcV6+5=hqJdi=FD37a3fazSNNeUSg@mail.gmail.com>
X-Gm-Features: AS18NWD0T2ErSWY-q1jXuUccpNHEsRySEci4kvFa-MWsnKplWNByVUEA9VYZXc0
Message-ID: <CAMuHMdWtE_E75_2peNaNDEcV6+5=hqJdi=FD37a3fazSNNeUSg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

Hoi Peter,

On Mon, 29 Sept 2025 at 13:04, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Sep 29, 2025 at 12:58:14PM +0200, Geert Uytterhoeven wrote:
> > On Mon, 29 Sept 2025 at 12:09, Peter Zijlstra <peterz@infradead.org> wr=
ote:
> > > On Mon, Sep 29, 2025 at 11:38:17AM +0200, Geert Uytterhoeven wrote:
> > >
> > > > > +       # Detect buggy clang, fixed in clang-17
> > > > > +       depends on $(success,echo 'void b(void **);void* c();int =
f(void){{asm goto("jmp %l0"::::l0);return 0;l0:return 1;}void *x __attribut=
e__((cleanup(b))) =3D c();{asm goto("jmp %l0"::::l1);return 2;l1:return 1;}=
}' | $(CC) -x c - -c -o /dev/null)
> > > >
> > > > This is supposed to affect only clang builds, right?  I am using
> > > > gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04) to build for
> > > > arm32/arm64/riscv, and thus have:
> > > >
> > > >     CONFIG_CC_IS_GCC=3Dy
> > > >
> > > > Still, this commit causes
> > > >
> > > >     CONFIG_CC_HAS_ASM_GOTO_OUTPUT=3Dy
> > > >     CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=3Dy
> > > >
> > > > to disappear from my configs? Is that expected?
> > >
> > > Not expected -- that means your GCC is somehow failing that test case=
.
> > > Ideally some GCC person will investigate why this is so.
> >
> > Oh, "jmp" is not a valid mnemonic on arm and riscv, and several other
> > architectures...
>
> Ah, d'0h indeed.
>
> void b(void **);void* c();int f(void){{asm goto(""::::l0);return 0;l0:ret=
urn 1;}void *x __attribute__((cleanup(b))) =3D c();{asm goto(""::::l1);retu=
rn 2;l1:return 1;}}
>
> Seems to still finger the issue on x86_64. That should build on !x86
> too, right?

Thanks, builds fine on arm32, arm64, riscv, m68k, powerpc, mips, s390.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

