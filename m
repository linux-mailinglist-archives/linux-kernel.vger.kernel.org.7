Return-Path: <linux-kernel+bounces-863812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D37BF92A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7196E4F76F0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B0D227E83;
	Tue, 21 Oct 2025 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O8oRU4gZ"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1293527B4F7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761087459; cv=none; b=YS5qcMMGxpUyooYyN21KTMDgFhaMOGuJ9UZPPcyIB67RAc/S8MTeOhuffOzpDFES2iBIeByKKAFFCS4DrIH1UvqRHpGsFEHQlG3S6IYWJQhlrzs32WU+GrOE29YhIuRVRf80WalfeJq/KQW3WmPESL9MG6a3V2mFWBWAB9B32+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761087459; c=relaxed/simple;
	bh=U5jc6wwVzwI/4xtKkppT2GQMTE8U/THJxLUBFs+395E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8oNDTAQSVy+M0Mx6LH7mnCFdk2O80FUL8PkPfQQ5EXmmw7JuK5CS20sTOEuU5cG+PrFGPy1JIZMdRCD6aKbR/Sjk8LJCPAdiCAgWPByieeVQFXk43RgxstK6Bxq/402cf91rQdUt9t84bK4G4Dwa6wvWP804XFbag6wqWBR8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O8oRU4gZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so5746284a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761087453; x=1761692253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doBWJ36YRh7FR2yhW1YwaDN/HKyJY3N1ZAoovUg8x+M=;
        b=O8oRU4gZdPh+WrhI/yQ5sAXaW13r5JOsVlDX/Jk8mzWHmlz49X1A7Z/hSUS1XKTqb6
         MaaS58BB48hZ66nQ03CplTNX7DmaaOP7EUbf36NR7uT8I5i6srFltS1QZ3L4PNqFqtUa
         mKfJrZ1/hv3vE6soRg/iagSdbJ89r8H+AA71E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761087453; x=1761692253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doBWJ36YRh7FR2yhW1YwaDN/HKyJY3N1ZAoovUg8x+M=;
        b=JNlDkk2KZ0xLsD74xkxNCdO1kSChFNVR0RYyNEIf0s9tLDTWVKpGFvBtKq8RAc8rMJ
         QEVCyPqSL1s0mDXVGe5E3URNU993tWK7QyICAZPonJKFgOTGmZer3x3W+GcRhCpywNq8
         Iad3dCP5uHTfsAh+Q/G6CiBmgyRQjebDeLpyNmtNB5stxCpuM7/ce+q49Uk6UUNbRLdv
         sSBbMauxx13p1BTivb73Fx4HQ5pAJs9chIj2VpXRX7TRH4X5ISpGRhfuK5kDcCR2fR1F
         lRKbBTmRJfeqOj6ScwovJ1jZwuWwRWWMz7i/kJ5Vbfd0AdzgnXmKHC/S7/FuGYnjp57S
         09tA==
X-Gm-Message-State: AOJu0Yz5aczQw8AcBAT4Ler17LKTzAFqbcTdpFR8s2lymgMLl28nEGJD
	IgQLkGOXN1e8FyEE5ejpa8P904Petj8rX9zsqyvW2B3/GH4eY1OFD/DiFMuoSzSJDnv66UjlLpc
	Lz1A=
X-Gm-Gg: ASbGncsFdP5G5hg4Z+np2gvMDxjseqZvUXWqkevVJ122jzdDlOp7EWYLHEMspCKM3uV
	60YhkSYDeI+k6ln+owq4sN/0pLbQD3N1rK7/YD8xhYtpDucmm/x0RoYI+LlxJbUc2dSPN9FKLGl
	3bS0gJrGj7FG5z4A/umtfquiYzrS8y6UumsRclPukvnqrj2VdUlbznIprnu3qEAB5qu7scNsNAi
	BQ9fC1klBi0b+mpqv5FduqiNaxQPqBOe4oJ3sPTgWCSPENsdwg3xW956uNcH9eJqWTbdUvBFu0H
	B1bTGO98a7bhp+ZpopORbUZOP3wLyngD2672pWRN9uQdDiszwjAIjzV08+D8t3MkWqRRXCPqo8K
	JpR8OavVVLjvDqDaaMzCD71zgGINI09qEZVFpP/ihlhJbPxWZq+zsBTK3H3165I2stYMP+S1Fu2
	hPipMiWhCSkAGhj97ax0Z18OQtllEuV+/PlfutqIIzxfQ=
X-Google-Smtp-Source: AGHT+IEN3t+4dtqJoDjW2b+OdRoHkvLm4dtO+jA+JKb7jsvUfAXdWJilkby1rP0gMkBtVII8fIKNMA==
X-Received: by 2002:a17:90b:51c4:b0:32e:3f93:69e2 with SMTP id 98e67ed59e1d1-33bcf87ad33mr26440689a91.13.1761087453053;
        Tue, 21 Oct 2025 15:57:33 -0700 (PDT)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com. [209.85.214.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223cb0a5sm633113a91.1.2025.10.21.15.57.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 15:57:31 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-290c2b6a6c2so56867975ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:57:30 -0700 (PDT)
X-Received: by 2002:a17:902:ce8d:b0:282:2c52:5094 with SMTP id
 d9443c01a7336-290caf831c2mr200878285ad.37.1761087450214; Tue, 21 Oct 2025
 15:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <20251020115132.10897a599c8fbda4829b3f89@linux-foundation.org>
 <CAD=FV=Uzp_Pi_q5YRbRi3FgdiCy1HR3g6P72d92dbqAdLyWuRQ@mail.gmail.com> <20251021135553.811b77539d2d41fff3c3b992@linux-foundation.org>
In-Reply-To: <20251021135553.811b77539d2d41fff3c3b992@linux-foundation.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 21 Oct 2025 15:57:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XXpMnjXzPgDseoLGOYUHVQy9Z2cjmCC+OE+uDC43eNRw@mail.gmail.com>
X-Gm-Features: AS18NWDyuFa4ioCcno1eSGwwMkyCjgQZ5S24dwjlz7Z32yYgF-BEUWilWTykob8
Message-ID: <CAD=FV=XXpMnjXzPgDseoLGOYUHVQy9Z2cjmCC+OE+uDC43eNRw@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to logs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brian Gerst <brgerst@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Francesco Valla <francesco@valla.it>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Guo Weikang <guoweikang.kernel@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 21, 2025 at 1:55=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 20 Oct 2025 13:00:22 -0700 Doug Anderson <dianders@chromium.org> =
wrote:
>
> > > And the code would presumably be much simpler if we simply chunked up
> > > the printing and spat out one really long line.
> >
> > I'm not quite sure what you're suggesting. Before my changes we _do_
> > try to spit out one really long line, but then printk() silently
> > truncates it for us at 1021 characters. Re-reading your suggestion,
> > I'm not sure if you're suggesting that we improve printk() to handle
> > lines longer than 1021 characters by chunking them up, or if you're
> > suggesting that this code could use "pr_cont()" to chunk things up.
> > ...or something totally different. ;-) Can you clarify?
>
> I was suggsting the latter - emit these really long lines via repeated
> calls to printk().

OK, I coded this up. I started with a pr_notice() and after 1021 bytes
I followed up with a pr_cont().

Unfortunately, this doesn't seem to work to make "one big line". The
subsequent strings w/ "pr_cont()" end up on separate lines. In other
words:
  pr_notice(first_1021_byte_str);
  pr_cont(second_1021_bytes_str);
  pr_cont(last_10_byte_str);

Ends up with logs that look like:
  [ 0.000000] first_1021_byte_str
  [ 0.000000] second_1021_bytes_str
  [ 0.000000] last_10_byte_str

...so we end up with a worse situation than with my patches since the
wrapping happens at exactly 1021 characters rather than wrapping based
on spaces.

I tried to dig into this a bit to make sure it wasn't just a bug in my
patch. I made it wrap at 504 bytes. Now I tested something like:
  pr_notice(First_504_byte_str);
  pr_cont(Second_504_bytes_str);
  pr_cont(Third_504_bytes_str);
  pr_cont(Fourth_504_bytes_str);
  pr_cont(Last_10_byte_str);

Now I had:
  [ 0.000000] First_504_byte_strSecond_504_bytes_str
  [ 0.000000] Third_504_bytes_strFourth_504_bytes_str
  [ 0.000000] Last_10_byte_str

In other words pr_cont() was working properly, but it seemed to
realize when the resultant string would be > 1021 characters and it
started a new line for me. This further cemented in my mind that it's
not a way around the 1021 character limit.


For giggles, I also tried backing out my patch and just doing:

-#define PRINTK_MESSAGE_MAX     2048
+#define PRINTK_MESSAGE_MAX     8192

-#define PRINTKRB_RECORD_MAX    1024
+#define PRINTKRB_RECORD_MAX    4096

When I looked at the serial console output I found success. My very
long cmdline was printed out in its entirety. ...but it made "dmesg"
real unhappy. :'( In fact, when I ran `dmesg` after doing this it
actually fully stopped printing anything when it got to the long line.
:-P Things looked OK when I looked at `/dev/kmsg` directly. ...so I
ran strace on `dmesg` on my system and I found:

read(3, "6,53,0,-;alternatives: applying "..., 2047) =3D 50
write(1, "\33[32m[    0.000000] \33[0m\33[33malt"..., 74[    0.000000]
alternatives: applying boot alternatives
) =3D 74
read(3, 0xaab6c875c2d8, 2047)           =3D -1 EINVAL (Invalid argument)
close(3)                                =3D 0

In other words `dmesg` seemed to be trying to read 2047 bytes from
`/dev/kmsg` and this wasn't enough to hold the output line. You can
see in the kernel function devkmsg_read() that when this happens the
kernel returns -EINVAL.

We could _try_ to improve devkmsg_read() to be able to return partial
log lines, but that violates the docs. The file
`Documentation/ABI/testing/dev-kmsg` says:

  Every read() from the opened device node receives one record
  of the kernel's printk buffer.
  ...
  Messages in the record ring buffer get overwritten as whole,
  there are never partial messages received by read().

So tl;dr: as far as I can tell, we simply cannot put the whole cmdline
(which is 2048+ on many architectures) on one line without breaking
userspace. My userspace reads 2047 bytes and we'd need to return not
just the cmdline but the prefix "Kernel command line:" as well as the
data about time/log_level/etc.


Does any of the above change your mind about my wrapping scheme? ;-)
Obviously, I'd want to update my commit message with some of the
research...

-Doug

