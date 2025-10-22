Return-Path: <linux-kernel+bounces-864035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0336ABF9C57
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3FA46496D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21447322A;
	Wed, 22 Oct 2025 02:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i1qRP3Zc"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200415687D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101525; cv=none; b=JcHrsTf8k0q6wu/X5+0DDS6ctELAY/xjf7EZ/47bc0McxjVlUsmvdqcatJlTzje+6JxbgGx6/W+ktDqPi5uuoZ9YMdROWUUPISewSIZ0qGUsmj7FVNVuv93zeKjG/pFkDJbIx4EglHwNEBAXNohVR0b94NGy3p5YX7BNA5lzXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101525; c=relaxed/simple;
	bh=SckLvPfNF7K9t9Ceh76SwrnYBVO44uCiz+BPFvTozlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OW7/lBvVZhxIgs4TF9vDLVPnZSk9Y8UEfPXMzjXAMFy+g1GfjSbDRm5E2GgLFGpXS0xZoU0fKWCefRXVq6O50ANlnCabo8AFyVTlmGx245S0PuwC4rOL2Gt8ZQ3z/SNNh9v8eZsS5lSyq/PXaO6UL3L5s66Tvm2u9WQ9/koUwU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i1qRP3Zc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6a7ed1ff9eso3559205a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761101523; x=1761706323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUijxIKfyv6I4IyhrWKtkT/qgBfiggPn6aW8B7UM0aA=;
        b=i1qRP3Zcols4VcTH7it5flyNI6dZN8qlYY4G8c3k36nWXHkvznBJb5dZO6Tt9ALMY3
         sqbFWcQv1sn8xJ2jrUzMPGOo9HwrQgqZ5cSLw81UMos6720Lh6ZOwjAN26TxX/Ernbqx
         ZGQXz9CmIJweIB3/Qi0e5hxPYhb6ysc1X+lSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761101523; x=1761706323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUijxIKfyv6I4IyhrWKtkT/qgBfiggPn6aW8B7UM0aA=;
        b=eUj3hJtKQHEGi3fDd+R97HfUSyGI4q3mspjZhhUKIG322iCA8Ia7hmhQ92n0obDE79
         bSE6gMnqOLWj5HNJHdfhgZsoF9w2TQNlps31k/9/JyAXYnC3GfYe8e/dfWdiPk5s5xks
         nDDNpONo5aDX85FX8i6k9VDTwxzHhbO5WMjN/Na+8SBsqBE2tZYUHINVftPQeJbeIlRW
         aMJdGZEE7k1Y04J9x0vhRjdoiYUYIZiceUHaNg9PzEyOKJyVZD250asq7m/UITIlZbMw
         fCIHkGY3qXbVs+UjaTpwE33ref0cgGJVv6o9LKTXp8QyGIq0yqjVcI2Ouiy6FZS4BpqF
         0XFw==
X-Gm-Message-State: AOJu0YyE/syF4ItRvjjGio/OF1xv8J4yslMt9svmLP04uxVdCj1J3kPK
	juLWvWQv1xnJsirDM1riIWJsMUJI82+gRlxLKUuYSrMhXLcFBXWklCD4z80BxvBNKFhUQxhx/MV
	YU3c=
X-Gm-Gg: ASbGncvgvrbHBlCFPbwL6+UsDYBSrjSdV+00Zd3yU25PZnvUSkHDnE0rUubjWFu0JIU
	4hjdgxNDs+FBbfU90lENioy7P70iqiDSYJhx0S2IMO1HOl9DdpsCHIiaXoDFN1cAFnYFWzPRTF6
	SUctEjW96xUgTyloS7fxDM7bbjckFpoZmU5kPMbrhicc3HdUShEWbwuqbp8ZVvY1c15XTeWMxLG
	8FRfr9EAgM+ZahE+3Q5L4LmdK7wuBsHQ+YXznMeXBboR3Wn8HvTEJW5Zbja51jK31hZAfDCt5Ob
	22h73f5WFzGlmrziadCyKJ5qQQVy+SkzC3Fs3od9+SjVk9a6DkeyH6U+Ab4l8EuZcGi0B6B07/w
	/5ba3sVdglhGPkAv82I3tfD0LcCTZyjfMXEfbR0+9PF3qvHNj1eN/giUd4FIS8clW4zgcJy4VQE
	uo1tctk1eWfP2kRj5Lr2ib5pneUFfDnlzeNrEMi/Uphhc=
X-Google-Smtp-Source: AGHT+IHgVIs0Ii+ZgjokGv1ekJ1cj2/IWtg6/KIP+9n2ZOYbUZYfxdaeObSScMpnMl5eLHmj0LLzUQ==
X-Received: by 2002:a17:902:dac2:b0:269:8f2e:e38 with SMTP id d9443c01a7336-290c9cf97b1mr226414715ad.6.1761101522990;
        Tue, 21 Oct 2025 19:52:02 -0700 (PDT)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com. [209.85.214.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fd7693sm124324895ad.40.2025.10.21.19.52.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 19:52:02 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so79643935ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:52:02 -0700 (PDT)
X-Received: by 2002:a17:903:98f:b0:277:3488:787e with SMTP id
 d9443c01a7336-290c9cf8e7fmr245991655ad.12.1761101521821; Tue, 21 Oct 2025
 19:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021173939.v2.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <8bc35675-13ab-4444-ba45-be910ebc4ff4@paulmck-laptop>
In-Reply-To: <8bc35675-13ab-4444-ba45-be910ebc4ff4@paulmck-laptop>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 21 Oct 2025 19:51:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WFbH6kBMcoHNwQzsay6ecQQ2sZ3qc-=XTboFXK+RSspA@mail.gmail.com>
X-Gm-Features: AS18NWCHiZMC2fwgMnQe7cDsJwBHgsE-d-ZUsBWwyd2V572upi_D9LW6xFskcAI
Message-ID: <CAD=FV=WFbH6kBMcoHNwQzsay6ecQQ2sZ3qc-=XTboFXK+RSspA@mail.gmail.com>
Subject: Re: [PATCH v2] init/main.c: Wrap long kernel cmdline when printing to logs
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Andrew Chant <achant@google.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brian Gerst <brgerst@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Francesco Valla <francesco@valla.it>, 
	Guo Weikang <guoweikang.kernel@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 21, 2025 at 7:16=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, Oct 21, 2025 at 05:39:48PM -0700, Douglas Anderson wrote:
> > The kernel cmdline length is allowed to be longer than what printk can
> > handle. When this happens the cmdline that's printed to the kernel
> > ring buffer at bootup is cutoff and some kernel cmdline options are
> > "hidden" from the logs. This undercuts the usefulness of the log
> > message.
> >
> > Specifically, grepping for COMMAND_LINE_SIZE shows that 2048 is common
> > and some architectures even define it as 4096. s390 allows a
> > CONFIG-based maximum up to 1MB (though it's not expected that anyone
> > will go over the default max of 4096 [1]).
> >
> > The maximum message pr_notice() seems to be able to handle (based on
> > experiment) is 1021 characters. This appears to be based on the
> > current value of PRINTKRB_RECORD_MAX as 1024 and the fact that
> > pr_notice() spends 2 characters on the loglevel prefix and we have a
> > '\n' at the end.
> >
> > While it would be possible to increase the limits of printk() (and
> > therefore pr_notice()) somewhat, it doesn't appear possible to
> > increase it enough to fully include a 2048-character cmdline without
> > breaking userspace. Specifically on at least two tested userspaces
> > (ChromeOS plus the Debian-based distro I'm typing this message on) the
> > `dmesg` tool reads lines from `/dev/kmsg` in 2047-byte chunks. As per
> > `Documentation/ABI/testing/dev-kmsg`:
> >
> >   Every read() from the opened device node receives one record
> >   of the kernel's printk buffer.
> >   ...
> >   Messages in the record ring buffer get overwritten as whole,
> >   there are never partial messages received by read().
> >
> > We simply can't fit a 2048-byte cmdline plus the "Kernel command
> > line:" prefix plus info about time/log_level/etc in a 2047-byte read.
> >
> > The above means that if we want to avoid the truncation we need to do
> > some type of wrapping of the cmdline when printing.
> >
> > Add wrapping to the printout of the kernel command line. By default,
> > the wrapping is set to 1021 characters to avoid breaking anyone, but
> > allow wrapping to be set lower by a Kconfig knob
> > "CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN". Any tools that are correctly
> > parsing the cmdline today (because it is less than 1021 characters)
> > will see no difference in their behavior. The format of wrapped output
> > is designed to be matched by anyone using "grep" to search for the
> > cmdline and also to be easy for tools to handle. Anyone who is sure
> > their tools (if any) handle the wrapped format can choose a lower
> > wrapping value and have prettier output.
> >
> > Wrapping is based on spaces, ignoring quotes. All lines are prefixed
> > with "Kernel command line: " and lines that are not the last line have
> > a " \" suffix added to them. The prefix and suffix count towards the
> > line length for wrapping purposes. The ideal length will be exceeded
> > if no appropriate place to wrap is found.
> >
> > The wrapping function added here is fairly generic and could be made a
> > library function (somewhat like print_hex_dump()) if it's needed
> > elsewhere in the kernel. However, having printk() directly incorporate
> > this wrapping would be unlikely to be a good idea since it would break
> > printouts into more than one record without any obvious common line
> > prefix to tie lines together. It would also be extra overhead when, in
> > general, kernel log message should simply be kept smaller than 1021
> > bytes. For some discussion on this topic, see responses to the v1
> > posting of this patch [2].
> >
> > [1] https://lore.kernel.org/r/20251021131633.26700Dd6-hca@linux.ibm.com
> > [2] https://lore.kernel.org/r/CAD=3DFV=3DVNyt1zG_8pS64wgV8VkZWiWJymnZ-X=
CfkrfaAhhFSKcA@mail.gmail.com
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Nice!!!
>
> However, there is tooling that will choke on the line-wrapping.  :-(

Ah, so you're saying that you know of a tool that will behave better
if an overflowing cmdline is truncated (like the current behavior)
instead of an overflowing cmdline suddenly starting to wrap. OK,
that's fair. Any chance you could provide any more details about the
tool?


> So would it be possible to have a Kconfig option (or a special value for
> your new CMDLINE_LOG_WRAP_IDEAL_LEN Kconfig option) that preserves the
> old behavior?  (Yes, I am of course looking into making things line-wrap
> tolerant here, but...)

Seems like a valid request. I'd rather not add yet another Kconfig
option, but how about if I allow CMDLINE_LOG_WRAP_IDEAL_LEN to go from
-1 to 1021. Any time that the value is a nonnegative value less than
the length of the prefix ("Kernel command line: ") we'll basically
just always wrap at the first space. If the config is the special
value of -1 then it will totally disable the new behavior. Does that
seem reasonable?

Do you have any preference about what the default should be? If the
tool you're aware of is something that's common and lots of people use
it, then it seems like -1 should be the default. If your tool is
something that's just on a special / custom linux distro then maybe
you'd be OK with the default of 1021.

-Doug

