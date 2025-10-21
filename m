Return-Path: <linux-kernel+bounces-862289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A62BF4E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484B24208E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65508279792;
	Tue, 21 Oct 2025 07:12:35 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4E275861
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030754; cv=none; b=nXja9m4C6niBNURi4YxkwBZrpJyGFOe4FvtKXdASYxuH0BQoCplMRYt5Asbs2MEU4VY5Lq74eq76783k1Qeli8Gh28koO2Mk+wZlRmriSdfye60vvy0hqrbMXOrLHgaS9zbO/IMqikWlxUQUVLR6ErqDJZYEZTJ4g0p3Dl+8gU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030754; c=relaxed/simple;
	bh=UpOZTzA2Cg0xuj9L9Snqlj1LAarwNb659Ui+cQ6KOhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qW+ApyfhMUEkEmNixk/nm7Rqth0sj3wpIzQKv5IfWfEdE5XYFKoK0osvngBW1sIki3yyi9xA79WZACXhxV9QRbVCq9/TgfYpk/WBFKLcyfXVNc2yNlwJmGV5yyGZdJe5O8oAbjgqaeXe4AunUb0ti3CaIHqaulLmr0staJqmuCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-78e4056623fso68105336d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761030751; x=1761635551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhPGZdM+an4DNurRNIbu5m1jJ3B3iI2V4DQkHllaTd4=;
        b=ETC2T8Iypx6PRystXll9E9pWkagiPkLYeGFozjztYCrnuF/9QdOr/WZxjQ14msybHu
         ofOChQ2Gj3dibMhEb903YVgSkP1jZ9ifA+UogSilZLjPpHqDKIp+GVVNaYncj4M0lolj
         rHdh0VVXd1q5TOueUCju+FGzRI/Iq4wRnv8NS50lfn3l7a7lhrdeuj78VdNazKw0+3hO
         iPcIigX16KXJaeD29tpjRDQ5lKlqVgmhdp+gAd32vo+lCHzVmakwMPoqPMBwjRJ1UDh0
         Ck4Iqu5Uf44/ahxCgHlIopBu9WxAo4yF77kHLjkltzw26+2Win4WhJSEpWWAAMOn+0pN
         FKyw==
X-Forwarded-Encrypted: i=1; AJvYcCV1z2X4m9xBOC9BGzelnIlTXjWjLZueJRYLhvwfPMFzwh08vtVlIj4m73PdnI1qkoxkjlUk4jG+y5rAZAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIe3lxMhLgF9it3vp/VYv5S+kfIw42LYYOXX6S63Z8TR836/3D
	SVd4fu4S6A/UbQheXGZcEOEdFNi7X3tCqV4+MNCQ05+W5tRM2S445iO8qlj07A7w
X-Gm-Gg: ASbGnctFhz/j2zGxRHMmChodcpaOOdm+NIA5wv+o0I0OU2pVvRhOp9Fy/rREG2T+h5+
	RWw5gn3Dd4d6xjA5FfpEmWW0QsS6Vh3yXXn8Rz7ENBDWyCOWtzkrwXx8PD0xE+IitDIwqQAUh3l
	fRJ5aC83XmFuljS6QL9UlZFrzept/oXrCIlFQISqJIh4rODK6nhjbzl+l1UZJZ7fC5e3Pq7/c6d
	1ubdeCAE32hfZqs+YMtvuKHHkotVqSojtJJins17v/8Tt3NlUzo3Q28Ar40kH9LfZX/cvhx35qm
	bUCwzZtP/j96Ekwkeu0+q1UGcH3Ig6wlImII+2thYAkTYNvYGxxxjJHVFfAoHDaHAcuDG5caiiK
	+WE2tfV7DJvG7SINEbR0J1GnI3r0lD21Juw9I9Drwbosg7YopwC5ukBMoRCRSNtH9r3WE4xdvLW
	E103bsrUt8j/8WFeLQQgC3d9Dsm+Y3rjJ6qRdONwuRnHqieyOCWpkx
X-Google-Smtp-Source: AGHT+IGogyrmvGlwFMpddWU65FY1BhJo46Cs/qKGNbSnkpwxmx63u6q5YwNxVGMfjKC3suvyGRYzaQ==
X-Received: by 2002:a05:6214:258e:b0:87c:275d:adcd with SMTP id 6a1803df08f44-87c275dba2fmr171901746d6.41.1761030751143;
        Tue, 21 Oct 2025 00:12:31 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf5237273sm65063346d6.26.2025.10.21.00.12.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:12:30 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-89048f76ec2so720839785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:12:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXMscE2/hYWjsBU6JV0K1izif+GCjhDgeWuh/hU7Zvl9BO34GPJWDepXu6q2bUO5801y+PZGcXEiVujP0=@vger.kernel.org
X-Received: by 2002:a05:6102:548c:b0:52a:1ff2:da15 with SMTP id
 ada2fe7eead31-5d7dd5a6916mr4190451137.15.1761030358892; Tue, 21 Oct 2025
 00:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <2d514d61-121d-44fc-aec7-637dd0920de8@infradead.org> <CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com>
 <CAMuHMdVT-_UVAO=1jvTPEjKO0zy7H1rUrQz1ubMfHivF4HWJNA@mail.gmail.com> <CAD=FV=WeXOj_hyA=V9hMLHOJ_m9ui5mP6cRv2DpjXnR62_nd2w@mail.gmail.com>
In-Reply-To: <CAD=FV=WeXOj_hyA=V9hMLHOJ_m9ui5mP6cRv2DpjXnR62_nd2w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 09:05:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWGb0jVt9ziBtWdHWC9omPAFMHVPBHDpv0F1XzvR0THpg@mail.gmail.com>
X-Gm-Features: AS18NWCwSLaTZzUZHHjPu2aHB1yMxhOD9WxIuBCDLK0u4mfaGukRaya3oKLFi-A
Message-ID: <CAMuHMdWGb0jVt9ziBtWdHWC9omPAFMHVPBHDpv0F1XzvR0THpg@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to logs
To: Doug Anderson <dianders@chromium.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	Andrew Chant <achant@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
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

Hi Doug,

CC s390

On Mon, 20 Oct 2025 at 18:04, Doug Anderson <dianders@chromium.org> wrote:
> On Mon, Oct 20, 2025 at 8:42=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Mon, 20 Oct 2025 at 17:33, Doug Anderson <dianders@chromium.org> wro=
te:
> > > Printing the command line to the kernel log buffer is one of the very
> > > rare cases where:
> > > * There's a legitimate reason to print a (potentially) very long
> > > string to the kernel buffer.
> >
> > arch/s390/Kconfig:
> >
> >     config COMMAND_LINE_SIZE
> >             int "Maximum size of kernel command line"
> >             default 4096
> >             range 896 1048576
> >
> > Yummy...
>
> Wow, what are they expecting to stuff in there? An encoded initramfs
> or something? I kinda feel like the 1MB number isn't something anyone
> expects but is a number picked to effectively be "unlimited".

Dunno, commit 622021cd6c560ce7 ("s390: make command line configurable")
lacks the "why" part.

> Do you have a suggestion of what my code should do if it sees such a
> long cmdline? At small numbers (4K, 8K, maybe even 32K) printing the
> wrapped cmdline is nice. Above that, maybe it should just print
> something like "<cmdline truncated>" or something?

I don't know, I never saw truncated kernel command lines myself.

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

