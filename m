Return-Path: <linux-kernel+bounces-863340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B2BF7961
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 926894E9817
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F2A345CDC;
	Tue, 21 Oct 2025 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lINGE05z"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D34D345CBC
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062880; cv=none; b=rhz0GQxsCMicUhluL8HrNRpk/w2sdEKRjMQtapQOUf87Gz0aYsjU0yx55c1q6ZByl8hrURHBBPTC2pja6mhUBtlO8d4lHtnFrsCmJlCCgHwNAnTLnO6QPj8lypr8NSEvtVJC/inpKAs+gqGadf/6bcrYZWiiWGY6PWIbjyhfLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062880; c=relaxed/simple;
	bh=bKpdUjAbZudmEXfwWsQOnsj8GT9aOq+yPry9bLfFxUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgqUEVLf68CU9jC4inPI+dxcSPL+HsMSVIEeOCX3GvJ0ch33WHS7srLT/Nb68mJXj6Xq3b67lQCvfLMyDIS6cA+eixYf99xRXagGPgUTqilHXWclob5JNu/mnGn2ymHJRLEY1OOjYm0T5krvzclYT3jf8aUU/EXce/sBX+QXdro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lINGE05z; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7810289cd4bso5515075b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761062876; x=1761667676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90eEaPtbwxy3p3pxWrxnRzTG0xmlwztyiMfCrjZT8xs=;
        b=lINGE05zUFf0vtETgY3aZr2wGtWoCnDsfiqPlANt5LiUwvw8o+Pg0aufj35dKzLfex
         cGedDvVYzLIE8qDSywj3CViwi/okWqInJ+8sOtVVxmSPNfiru1aWDmku46DbThekqD8W
         3sdCNfZVQcsZk4ZYMFawtSuqJMcI3e2oaSGMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062876; x=1761667676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90eEaPtbwxy3p3pxWrxnRzTG0xmlwztyiMfCrjZT8xs=;
        b=WLDQ5WErjO0xt10zGkpknFuQOfVEXPPSsvRDgXMX6nfaJA9d9ho9mjhmbnxUzgETrY
         NRafIv+PWmtdUyU3z2QIFHEvxmqLCgUxk+TvmguvHCLcW4JP82wvd3Mmcjbnc5AcB4zX
         0raQl93+LzbuqUhFbBh5cBjFfmfBpzNdmWZQZM7U/VACKL8KXbbLYxf1n1TPzOzGi5Id
         GYJGJHXLChK8PH6PpzSsVQt09Xjdx8EdukoWqCk9scLhjKjmK6HMtAVJqgbAX4bmHWfG
         hOzb/3MO3q7xN9YCnR01uGibThhamLdDzV+vyWXCrLPOhzSqlzxkN1zfWsO+AC5md39i
         HQiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPL9qzafKELJsO38vzKDmRNszelZktF8obXrMDNSw6TPdDIq0yQfYPy8dzvl0FO74sjwYuwt6e2oUYfXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEZe+qDSaNNAj0VJGhSho9mRVqAo7ykiGbUkYqt9ftFvjnFHjV
	OgaukvGkjwcXSkv00FMnW1LqIwI/FeCBm3vX4XLt/4fGDcDkPfgfiaCZ79d4ZRWvxIo0wjKC6eT
	CZQw=
X-Gm-Gg: ASbGncvRCOXHCxqFVTA4jXwGJH6Ra2WgONXOJR0433LUgJJmIDHzfdgxKtdxiTe9X+7
	/xBLPrVFX9yjLY4wbfCX9/dczjHIsDfXzmFcsYMamLwygeZJ62NqqTWvnE0qUllGlDth2kss9TR
	NB+NZXCj1trZaGjhEAvr/SC/IDmhhELb0hog/5xzqdTUMw5h4XfnXZ7S8ghXsUfc273arg0gLa1
	gS8/cumwGo8g/7SbuCT/D7c1Ti/NqDWiwfXmDfqj3Jp9A+I3Q8oppDoYrHbRu/riQfAXgp3Zg+0
	kzaOjpmJGjVBi3jLxpihYu0sI9t9j9R8wJWiO1D2vWaDd8ymIiNOTUTJ0wG81RbtWR6OeSw6LpQ
	5mVps6NTcPlWv+b5qb8NWWLvfK0PTh0jSN9g+Z/FZTM54PGzPfqhG0QzCCWILEI2vS833VuFs6d
	Mhv24jwBafkr3NY4zJH2ZuOsqzmu/UUA1lY9brsrUQub7cUhzRhWa+wQ==
X-Google-Smtp-Source: AGHT+IGn3wskvUOmxGwDb023iZK307GJCugVDS3Hvcpofi50RVg5991QeT/y55DTxn2/T7WEohqT9Q==
X-Received: by 2002:a05:6a00:3a05:b0:78f:6b8c:132 with SMTP id d2e1a72fcca58-7a220d22341mr21799793b3a.29.1761062875394;
        Tue, 21 Oct 2025 09:07:55 -0700 (PDT)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com. [209.85.214.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230121ebfsm11695666b3a.70.2025.10.21.09.07.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 09:07:53 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27eec33b737so86912915ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:07:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYTkoPZKxOa6xGDG+JORLs5ZhGSfcjgrvm1CKYAZ96zNs5yhSTQF8FLpXPCPHHhnZvx7AJQeFT+9Atkug=@vger.kernel.org
X-Received: by 2002:a17:902:d50a:b0:290:bfb7:376f with SMTP id
 d9443c01a7336-290cb46bf6emr190882455ad.51.1761062871921; Tue, 21 Oct 2025
 09:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <2d514d61-121d-44fc-aec7-637dd0920de8@infradead.org> <CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com>
 <CAMuHMdVT-_UVAO=1jvTPEjKO0zy7H1rUrQz1ubMfHivF4HWJNA@mail.gmail.com>
 <CAD=FV=WeXOj_hyA=V9hMLHOJ_m9ui5mP6cRv2DpjXnR62_nd2w@mail.gmail.com>
 <CAMuHMdWGb0jVt9ziBtWdHWC9omPAFMHVPBHDpv0F1XzvR0THpg@mail.gmail.com> <20251021131633.26700Dd6-hca@linux.ibm.com>
In-Reply-To: <20251021131633.26700Dd6-hca@linux.ibm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 21 Oct 2025 09:07:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XD19==ed=OPWSvrz-KNQSphHUPwCOqX2-Zi-1o8XE49g@mail.gmail.com>
X-Gm-Features: AS18NWByrjhJ32HQ8xty6HQCqWcjFJthoH_GcJNHfXtjtrqxtZ3YbUmJqh8GKAY
Message-ID: <CAD=FV=XD19==ed=OPWSvrz-KNQSphHUPwCOqX2-Zi-1o8XE49g@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to logs
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Francesco Valla <francesco@valla.it>, 
	Guo Weikang <guoweikang.kernel@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Sven Schnelle <svens@linux.ibm.com>, 
	linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 21, 2025 at 6:16=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> On Tue, Oct 21, 2025 at 09:05:48AM +0200, Geert Uytterhoeven wrote:
> > On Mon, 20 Oct 2025 at 18:04, Doug Anderson <dianders@chromium.org> wro=
te:
> > > On Mon, Oct 20, 2025 at 8:42=E2=80=AFAM Geert Uytterhoeven <geert@lin=
ux-m68k.org> wrote:
> > > > On Mon, 20 Oct 2025 at 17:33, Doug Anderson <dianders@chromium.org>=
 wrote:
> > > > > Printing the command line to the kernel log buffer is one of the =
very
> > > > > rare cases where:
> > > > > * There's a legitimate reason to print a (potentially) very long
> > > > > string to the kernel buffer.
> > > >
> > > > arch/s390/Kconfig:
> > > >
> > > >     config COMMAND_LINE_SIZE
> > > >             int "Maximum size of kernel command line"
> > > >             default 4096
> > > >             range 896 1048576
> > > >
> > > > Yummy...
> > >
> > > Wow, what are they expecting to stuff in there? An encoded initramfs
> > > or something? I kinda feel like the 1MB number isn't something anyone
> > > expects but is a number picked to effectively be "unlimited".
> >
> > Dunno, commit 622021cd6c560ce7 ("s390: make command line configurable")
> > lacks the "why" part.
>
> That was just a follow-on patch of commit 5ecb2da660ab ("s390: support co=
mmand
> lines longer than 896 bytes") which solved the real problem with a too sh=
ort
> maximum command line size back then. In order to never have to deal with =
this
> sort of problem again it was made configurable.
>
> But I doubt that anybody will change the default ever.

OK, so my theory that 1MB cmdline is not normal / realistic / expected
sounds correct. Essentially it's just saying "we didn't want to pick a
limit". We could add a bound to what's printed if we want (4K? 16K?),
but it's maybe not critical since we wouldn't expect crazy long
cmdlines anyway.

So I guess the question is whether any of my arguments convinced
Andrew that my current wrapping logic is OK. If not, hopefully he can
clarify if either of my theories of what he meant by "chunking" were
correct and then I can send a v2. ;-)

Of course, given that the max cmdline for most architectures is
something like 2K/4K, it also might not be too horrible to just
increase the printk limit? I was assuming that would be too
controversial...

-Doug



-Doug

