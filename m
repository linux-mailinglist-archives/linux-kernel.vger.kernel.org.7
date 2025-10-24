Return-Path: <linux-kernel+bounces-869177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEBEC07396
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B4F3A6BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16473375CD;
	Fri, 24 Oct 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MwYSgQF6"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F524335BBE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322252; cv=none; b=aOsIJ17oY8BK+2D0MWcF68C5TmjxNNrbzQ/S7f98UraxnG1jmrkSJC/DtBMm/9TrvjuYUendDVFNyhKdIQuugr6KQWIV+p8IhtuTqCZQo/LA6xNUxBk7xxCqqlmMGiOktizHDRPE95RblIS264Tpg6GdZBq+YvaTpRJi9Gf3cgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322252; c=relaxed/simple;
	bh=MZveBwN8pITgiKu2IvyyZYnSYExm65gAyhHVYf2v+Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQArh6TUByznpmHTuE9UkJwKTE0TfgtLb7rMPLwFtTWVBesdftBhBa3//6E9fb/ejNweHY1SQmIyNZqKCPJ1Qe36ymvUs3juIEhEuHxz/lPukatQ29XlRana5+FS/U+avJQa2sY2mLc8Jr+nJQ4ln936EaQED95TyGt4zfbYD5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MwYSgQF6; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88f8f346c2cso237415785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761322249; x=1761927049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opD0p0FG32wb49KtDa/XK4x3J2J0EHXdG+v2/vEH5Fw=;
        b=MwYSgQF6ZGQCuHJ9/3uqCM3HPBhX6w09ckq/WgT6xQOsUnnGqA7VhaP2ozVQ4zjW8H
         lTFBE65Tei1OfgLF4kFW+u1pcqBCWbFZezcsO5e3hlIymHAcJAkc4UrMkiYACaUCM7Jc
         sIruraoNk+rfw8O5Zd6goOs/yDmjUEU0yRZ0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322249; x=1761927049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opD0p0FG32wb49KtDa/XK4x3J2J0EHXdG+v2/vEH5Fw=;
        b=IFY1IZ576Ry1VIUn23tTvJ/ZSyPpsxXXZm6z18pegNL7kOef8YOYOKLMB+di7VRkcR
         ucymduevGaIUHHksS1QrPHRAtaCr3bCzYt2jOVqjs0v7D7HSRRvTSyBiPXzWQp/5LgRU
         lEzmSbuiJsSY+wG2VsIFlARxvKvGGE0WeeL3AKySVPqJUzy+XIqXPTNVcRnADRuWmTPM
         hyIcqn9+Dm+X/A7q2kprJRkR3lLBIxSZuh7E43wL+LS/j/e7l7+PvUHkxzJS/2CC18n0
         2lVbLTdmtMuwR0rS4W4+Vqq5F9GZyG4EvROx2AelFaPd7/IZ5V7NBahHbMHgqEHd9dHV
         /4Nw==
X-Gm-Message-State: AOJu0Yy1+YKlZ3IAn7D59hnvvU37qGbv5m9n7uJIyqmXeMxTUYKP63L1
	yUXrGNobUD0KkFLJUHidI7ZDOr5x2PSXVRzr2qcayjlgspU4UYlbkvIGCQ8F1AX62kZNCc65J3e
	S8tA=
X-Gm-Gg: ASbGnctZYiPLq+3aU7YOgzEvt2T2tySn6mDATcAvrWZpjVbEui4rqIPNVS6jOdP2PLa
	TGqENElYV9CfVrUZ6vmGWwrBbfFbTfS4YDva1yhk5IFiFaNGaQCIvAOFfFWz1dVyzoS6amdpdsi
	kVjNmoN7WvKvq+Xc9KwRBWfVsjUARh7f36KtyBGsMMszfl2udnfUGpzfdU3OPdha4ojT48aazPi
	YSt5362V+XMz2XEV5qjsb4h79B0E0zvtF1YcQy7J1OCD4PNqErd69MOfAXFtO9qJVoJT7GfyU7l
	FAZGlmBtvGgWmjqKfh9Fw02GSe8jNu9yP6V5ZPAY3t2S+5qPUvj7nPx771MN2h35tiIyQZhbVyc
	mXjzALtc2bQDP2Z7TcBSwR3t9tnqszmiGr0vaamEDSIgHlBeiTt4b43pg4M+gbzXxAq3HPV3Gvv
	2He1eTbfd99JbbC+No4YS7kj7cqM4Ff9T4sB6hCZiS3qW4eLm2H9ppBQ==
X-Google-Smtp-Source: AGHT+IH0HCr6anUy0iyCzrPFK+tAN9tG7rQ9EDWtMkljZDh5aKkYGHbaGCt7PMpC+ELG08rvUPyyug==
X-Received: by 2002:a05:620a:294a:b0:891:ae32:d696 with SMTP id af79cd13be357-891ae32d6b3mr3152351685a.66.1761322249347;
        Fri, 24 Oct 2025 09:10:49 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c0dbcafe0sm415158885a.3.2025.10.24.09.10.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 09:10:49 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-89ead335959so30944085a.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:10:48 -0700 (PDT)
X-Received: by 2002:a17:903:244b:b0:290:9a31:26da with SMTP id
 d9443c01a7336-290c9d31109mr364082495ad.16.1761321809382; Fri, 24 Oct 2025
 09:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023113257.v3.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <CAMuHMdUg5UXRcnH18S8-QtR9y+GbnAcxEQB2EyTOgd=uSUYPTg@mail.gmail.com>
In-Reply-To: <CAMuHMdUg5UXRcnH18S8-QtR9y+GbnAcxEQB2EyTOgd=uSUYPTg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 24 Oct 2025 09:03:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uo4YAh8zGeU+tsxHEapsPyjAr9AyBEaAgiL3mUnN41=w@mail.gmail.com>
X-Gm-Features: AS18NWBMCp5d_6B9UUkRIRbhw0cZobNwXLRN_85Hn_tEol9iOKdQ3SjYiCqWIMo
Message-ID: <CAD=FV=Uo4YAh8zGeU+tsxHEapsPyjAr9AyBEaAgiL3mUnN41=w@mail.gmail.com>
Subject: Re: [PATCH v3] init/main.c: Wrap long kernel cmdline when printing to logs
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Andrew Chant <achant@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brian Gerst <brgerst@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Francesco Valla <francesco@valla.it>, 
	Guo Weikang <guoweikang.kernel@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 24, 2025 at 12:51=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> > +config CMDLINE_LOG_WRAP_IDEAL_LEN
> > +       int "Length to try to wrap the cmdline when logged at boot"
> > +       default 1021
> > +       range -1 1021
>
> Apparently COMMAND_LINE_SIZE is still smaller than 1021 on several
> architectures (even in asm-generic: 512).  Unfortunately only s390
> still controls it through a config option, so you cannot have a
> "depends on COMMAND_LINE_SIZE > 1021" here...
>
> > +       help
> > +         At boot time, the kernel command line is logged to the consol=
e.
> > +         The log message will start with the prefix "Kernel command li=
ne: ".
> > +         The log message will attempt to be wrapped (split into multip=
le log
> > +         messages) at spaces based on CMDLINE_LOG_WRAP_IDEAL_LEN chara=
cters.
> > +         If wrapping happens, each log message will start with the pre=
fix and
> > +         all but the last message will end with " \". Messages may exc=
eed the
> > +         ideal length if a place to wrap isn't found before the specif=
ied
> > +         number of characters.
> > +
> > +         A value of -1 disables wrapping, though be warned that the ma=
ximum
>
> Or zero, right?
> So perhaps just use range 0 1021.

Sure, we can use 0 as the sentinel value. I was thinking -1 would be a
more obvious "wrapping is totally disabled" value but I don't feel
strongly about it. I'll change to 0 in the next patch.


> > +         length of a log message (1021 characters) may cause the cmdli=
ne to
> > +         be truncated.
> > +
> >  config INITRAMFS_PRESERVE_MTIME
> >         bool "Preserve cpio archive mtimes in initramfs"
> >         depends on BLK_DEV_INITRD
>
> > --- a/init/main.c
> > +++ b/init/main.c
>
> > +static void print_kernel_cmdline(const char *cmdline)
> > +{
> > +       size_t len;
> > +
> > +       /* Config option of -1 disables wrapping */
> > +       if (CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN < 0) {
>
> As does zero, right?

As the code is written right now, 0 does not disable wrapping. The
code treats everything less than 23 characters (the length of "Kernel
command line: " plus " \") to mean "wrap everything at the first
space". Yes, it's a little weird to do it this way, but it was either
that or add yet-another KConfig setting to disable wrapping and then
set the minimum to something higher. In v1/v2 I had the minimum set to
40 specifically to avoid the confusing case. There was previous
discussion about this in v2 [1].

...but yes, we can choose to make 0 be the special sentinel to disable
wrapping. I'll assume that's what you want and I'll change it in the
next version.


> You can add a check for "COMMAND_LINE_SIZE <=3D 1021" here,  so the
> compiler will eliminate the splitting code when it is not needed.

As the Kconfig is described and as the code is written, someone could
still choose wrapping even if COMMAND_LINE_SIZE <=3D 1021. Someone
could, for instance, choose to wrap these lines at 100 or 200
characters to make the log message look cleaner in their terminal/text
editor. ...but you're right that I can write this to be more optimal
for folks with shorter command lines who haven't touched the config.
I'll change the "if" test to this:

if (CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN =3D=3D 0 ||
    IDEAL_CMDLINE_LEN >=3D COMMAND_LINE_SIZE - 1) {
  pr_noitce(...);
  return;
}

That changes the sentinel to 0 (as I think you requested) and should
allow the compiler to optimize things out.

Making sure I got my math correct... Let me know if you see something wrong=
.

KERNEL_CMDLINE_PREFIX_LEN is 21

Assuming the CONFIG value isn't tiny, IDEAL_CMDLINE_LEN is the CONFIG
value minus 21.

So let's assume COMMAND_LINE_SIZE is 256. That means we can have at
most a cmdline length 255 to handle the '\0' termination.

So if the CONFIG value is (255 + 21) =3D 276 or more then we should hit
the "if" test and early-out because we can't wrap. If the CONFIG value
is 275 or less then we should proceed to wrapping.

We want ((276 - 21) >=3D (256 - 1)) to be true. It is.

We want ((275 - 21) >=3D (256 - 1)) to be false. It is.


I'll wait a few days and send a v4. I'll fold in Andrew's "__init"
patch as well.


[1] http://lore.kernel.org/r/CAD=3DFV=3DWFbH6kBMcoHNwQzsay6ecQQ2sZ3qc-=3DXT=
boFXK+RSspA@mail.gmail.com


-Doug

