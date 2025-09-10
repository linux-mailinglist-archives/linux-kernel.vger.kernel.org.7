Return-Path: <linux-kernel+bounces-809973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46847B51429
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACB01C21429
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6757C31D39E;
	Wed, 10 Sep 2025 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GqJMZItz"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB652638BC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757500886; cv=none; b=MYjMqSSPJeLpJliM8Js7xmbGurKbVXqV3qTZEUfL1CmNUChIoRCcG4VQAVf/ELDNZO22BJu/DHqAXR7gMMppegMVUw01kmGKqq6W8N1k55krFo7gAxgjZpsnSVsmZAAyDHv8ANldFUdef28+g73rshhzL2h1EwZWl45TjIJsSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757500886; c=relaxed/simple;
	bh=ep6DHmBHgd1kpbChAS+R+dvVahzWEZwGQlVUAbmwU28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBwZbzZUbiXIsUWfoj8jjs2N1OGz/3yOHykDrWCwffeTTuSPrrcoBt9fXwvy1LYiuUXWYkZFjOd3wbNZBioccMJWp6EFRTmmKo8eeG12nZkYUWFPkxjEylHusCuIXYNCVIUADvGHuC+8jN84YBs34SO8qQeF0TgIFHeQnvsCbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GqJMZItz; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b548745253so93408991cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757500884; x=1758105684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep6DHmBHgd1kpbChAS+R+dvVahzWEZwGQlVUAbmwU28=;
        b=GqJMZItzXp3L41y4JaNKCcLVTJCPOzdq7bf9pvwuxu+IYvWtISgt8BKDi/lr2D090z
         6KQV41Q+XSaFLv+/FJN6O9RAVoO5jdhvxClRZhwzeCydodArjvq6+uRhauPaWt9N9bO6
         bW+waoq5TsinxiCeEO2rpxbBn5y2IEoW0Nc+n5hR5wodI297EmsFViS0VF9atcxO99jP
         Na4sP9LFmYMGV+t1hekT7LmfAaF70gvAafetaJemWDS5oxgkRg2AVgzq0qPIpXo/NkKG
         UR2pHzc9tpQf1SAcCMCsVvJDtOHMvg8c5050rt8nvIKP0vjwZFm+wFtGhwttgKTbli+n
         o4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757500884; x=1758105684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep6DHmBHgd1kpbChAS+R+dvVahzWEZwGQlVUAbmwU28=;
        b=tu11AWlH5P1/3rGFEtO6ff6yhx/HzIy2FNyfiq8kapase4x6JwaVjIieF5Y87aCUt1
         W2b/FLA4za18E7ceG5L0Pn+TOcqIL+BDA5Q7cWHRr9qPPDh1nMn4sw+p6PJXVORXfOyV
         c3Os5NS9MgXnOY6Wdu+BRxggyI/P89pEMGIJpXTKQHQtxKFrfqrRsG+eUE6OXMVOtz42
         8BwWWMaJ6rv4QABb9sjtzhO7e31P1s6bPF9OhJLZ4O1HzJ1QhBm/JludEGZs2F0Z0jTM
         jcyxuu+D2QRH0Din05IS96j2fPa5aur3tMSiRF1r50VE1RHN+JvKCkruDyuKMJb+C0B6
         OlPw==
X-Forwarded-Encrypted: i=1; AJvYcCXVxadiDRs5uNFpZ2pfCqV6T54DWhx1XOCUGOxHSfguKEFoX8FmWt+jS739k2pmZa9tHeuTCHHuYaEBSM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1jxi1HUATUD8A3w2xAKmTHScjzxWDdXB7bbx51jpUAo8GFH/
	CO4Sh6Vz7WtksugqRQ7vuh9KvsKbbho0g+dmgdbSZFOdmWl/6v8BdUFdkb6zLZ45B2LBoItfjHR
	0R6wdIW/ScuZwgzYc4eJ9T7+Z597g8kDA56mdKHWE
X-Gm-Gg: ASbGncsmMItTkbEohNgRVfCGYPl4OibBVo7SykDwUqBwZw9h30Ez8Keju1Ze1dQGfzS
	tjmzyPxzbJxNBifoNJG9fk583oPR/3j/uAT5GnbZmx5iKWqz8uAz9ZdK57XENLFhKXUtu02v7Wl
	7JqU1/SorCi5o9sdouVN4ZofIcb0vDb+TowV+4wUa8KDhljjho4hY70vdSzWI3AHzvN9T1lLccb
	YCuuUIeDxjPxlhwRT1jMIEL9ojkuhbafFYvAyIMZmow
X-Google-Smtp-Source: AGHT+IH+/cbUHy8aAQiP5y+HLOOkI7jZTVO1M0xIDiJAFbe2JLcrCl7FbgVqf5O3wrtsPiVVxFILCO1nutxZp4kGACw=
X-Received: by 2002:a05:622a:40e:b0:4b5:e49d:8076 with SMTP id
 d75a77b69052e-4b5f84676e8mr170436381cf.56.1757500883119; Wed, 10 Sep 2025
 03:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901164212.460229-1-ethan.w.s.graham@gmail.com> <513c854db04a727a20ad1fb01423497b3428eea6.camel@sipsolutions.net>
In-Reply-To: <513c854db04a727a20ad1fb01423497b3428eea6.camel@sipsolutions.net>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 10 Sep 2025 12:40:46 +0200
X-Gm-Features: AS18NWD9OOMFghsEyUOQIKKsq3tKxaVXVh2dSpezbvyYolCB64CRn-65yckShSU
Message-ID: <CAG_fn=Vco04b9mUPgA1Du28+P4q4wgKNk6huCzU34XWitCL8iQ@mail.gmail.com>
Subject: Re: [PATCH v2 RFC 0/7] KFuzzTest: a new kernel fuzzing framework
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ethan Graham <ethan.w.s.graham@gmail.com>, ethangraham@google.com, 
	andreyknvl@gmail.com, brendan.higgins@linux.dev, davidgow@google.com, 
	dvyukov@google.com, jannh@google.com, elver@google.com, rmoar@google.com, 
	shuah@kernel.org, tarasmadan@google.com, kasan-dev@googlegroups.com, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	dhowells@redhat.com, lukas@wunner.de, ignat@cloudflare.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:11=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> Hi Ethan,

Hi Johannes,

> Since I'm looking at some WiFi fuzzing just now ...
>
> > The primary motivation for KFuzzTest is to simplify the fuzzing of
> > low-level, relatively stateless functions (e.g., data parsers, format
> > converters)
>
> Could you clarify what you mean by "relatively" here? It seems to me
> that if you let this fuzz say something like
> cfg80211_inform_bss_frame_data(), which parses a frame and registers it
> in the global scan list, you might quickly run into the 1000 limit of
> the list, etc. since these functions are not stateless. OTOH, it's
> obviously possible to just receive a lot of such frames over the air
> even, or over simulated air like in syzbot today already.

While it would be very useful to be able to test every single function
in the kernel, there are limitations imposed by our approach.
To work around these limitations, some code may need to be refactored
for better testability, so that global state can be mocked out or
easily reset between runs.

I am not very familiar with the code in
cfg80211_inform_bss_frame_data(), but I can imagine that the code
doing the actual frame parsing could be untangled from the code that
registers it in the global list.
The upside of doing so would be the ability to test that parsing logic
in modes that real-world syscall invocations may never exercise.

>
> As far as the architecture is concerned, I'm reading this is built
> around syzkaller (like) architecture, in that the fuzzer lives in the
> fuzzed kernel's userspace, right?
>

This is correct.

> > We would like to thank David Gow for his detailed feedback regarding th=
e
> > potential integration with KUnit. The v1 discussion highlighted three
> > potential paths: making KFuzzTests a special case of KUnit tests, shari=
ng
> > implementation details in a common library, or keeping the frameworks
> > separate while ensuring API familiarity.
> >
> > Following a productive conversation with David, we are moving forward
> > with the third option for now. While tighter integration is an
> > attractive long-term goal, we believe the most practical first step is
> > to establish KFuzzTest as a valuable, standalone framework.
>
> I have been wondering about this from another perspective - with kunit
> often running in ARCH=3Dum, and there the kernel being "just" a userspace
> process, we should be able to do a "classic" afl-style fork approach to
> fuzzing.

This approach is quite popular among security researchers, but if I'm
understanding correctly, we are yet to see continuous integration of
UML-based fuzzers with the kernel development process.

> That way, state doesn't really (have to) matter at all. This is
> of course both an advantage (reproducing any issue found is just the
> right test with a single input) and disadvantage (the fuzzer won't
> modify state first and then find an issue on a later round.)

From our experience, accumulated state is more of a disadvantage that
we'd rather eliminate altogether.
syzkaller can chain syscalls and could in theory generate a single
program that is elaborate enough to prepare the state and then find an
issue.
However, because resetting the kernel (rebooting machines or restoring
VM snapshots) is costly, we have to run multiple programs on the same
kernel instance, which interfere with each other.
As a result, some bugs that are tricky to trigger become even trickier
to reproduce, because one can't possibly replay all the interleavings
of those programs.

So, yes, assuming we can build the kernel with ARCH=3Dum and run the
function under test in a fork-per-run model, that would speed things
up significantly.

>
> I was just looking at what external state (such as the physical memory
> mapped) UML has and that would need to be disentangled, and it's not
> _that_ much if we can have specific configurations, and maybe mostly
> shut down the userspace that's running inside UML (and/or have kunit
> execute before init/pid 1 when builtin.)

I looked at UML myself around 2023, and back then my impression was
that it didn't quite work with KASAN and KCOV, and adding an AFL
dependency on top of that made every fuzzer a one-of-a-kind setup.

> Did you consider such a model at all, and have specific reasons for not
> going in this direction, or simply didn't consider because you're coming
> from the syzkaller side anyway?

We did consider such a model, but decided against it, with the
maintainability of the fuzzers being the main reason.
We want to be sure that every fuzz target written for the kernel is
still buildable when the code author turns back on it.
We also want every target to be tested continuously and for the bugs
to be reported automatically.
Coming from the syzkaller side, it was natural to use the existing
infrastructure for that instead of reinventing the wheel :)

That being said, our current approach doesn't rule out UML.
In the future, we could adapt the FUZZ_TEST macro to generate stubs
that link against AFL, libFuzzer, or Centipede in UML builds.
The question of how to run those targets continuously would still be
on the table, though.

