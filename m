Return-Path: <linux-kernel+bounces-831985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D13B9E132
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB0A385125
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F0266582;
	Thu, 25 Sep 2025 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYB0376T"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E225EF97
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789349; cv=none; b=hhOVFIEWH9EVNJkzlik7JIMBSFNOaCw6gs54pZgq1ietQHQiVw8ntAcjWK2hth6eO4b/3sMyo5TmgAFKj2xBvPXTC5byks1bkxyXdDHfeWFoJ+AhFf148I8gY1GouP3hXctbEnyxGdfpmNe+bxaWCJWa8Ycjt63dsEhG0f/1/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789349; c=relaxed/simple;
	bh=eDfizLwqAX3ps1KqSy9owcGN8dHDTaaVHlBJT/0x+IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8tJc3dDDcmRGGnuKMRPgiVAZLUfZ3XZUn2NbtBUTFKiC/pg1qCt1JtlHcAqNXqirGcRkR41zZh1CMV352bHqZr6r9ZvJbPAFjhdcmGrszFuxGOJTeg4CcG/a3KyTps47ceaFTD2yOIQ3e+j6cdTMfz1JIEYbaIaEIb2yOQh/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYB0376T; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5506b28c98so503209a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758789347; x=1759394147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDyXKD1mpeXok68wul2g//tY5b9PgvJaaF56RchZKHQ=;
        b=FYB0376TawJjOLYbp2TKehqZRGA0YuKM0v/mkYoPhaoC/QPbShSiNNBuV33FwIAOH9
         29BGLddN/71Slg0pbcaKD5UaPfMNWnd6HkHUJwrnuY7En33QlekBA5ZypAxwaS/jBVF2
         lIunlpciu+m6/8ZuYwXhPRLezbpNX7dzNEJ80U07X5pbWBqss4e7l3G0SCqyMPg8caMu
         SJCLWS79x3OYLE7gjABXBgnGptNzPgZ8iPOi08OP8fJKIGjI2VNp6qhdcz9j5Uh9iVvQ
         tKDtwgJZqGL9sEoCPnhu5SOC5FV2YLSHIGcSI9K8Kzu/ZiMl3uT3T4XJ6Bfhflm+RQ65
         UpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758789347; x=1759394147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDyXKD1mpeXok68wul2g//tY5b9PgvJaaF56RchZKHQ=;
        b=wa4/3rhLK+OAlaY0byGuFv30IAOwumMaw/5iH2yOlN9ICTrlUC5s8SZ2MejupwngXE
         Dwr0zrY5jrVyjG/h01Quv5vIQJEv7m1nkQ5p7sDqQYdIBgCt38mJLGYFsZtZElsh0vhF
         56CUs+aUXFLGfTFwnKj2IS4z+AnW6CUpUfHO+xh4ElAa/6HeyurXQqFc/9xR+kiw+43R
         RYklEsrETV+8LADEReIVIAsG2yEPwPlZRnkPbtzB1IwntH/KY/uixt6wKoBrFpTzLBmA
         zG/gnluOYh7Ul+mYmvLnHPR2iO6xlnjqn9Sg6gA/g6ZIXV8K5yWx6xdskbATV/rd1k4S
         xLyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWULrYcYrveioiqe89oeqn0TehKqLsS4U7CYAfl2fx70lkrbQLzqrWA9PxtZ117kTjC+uZvAptIUq9gJSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9d++sfXqzuDPfCPB0ASG08k7gKWL6nHdNoOaEnVs/lSVsQCHR
	jc6L+l097xWmnJDXhee435jZW8W6f2g83kr+FI00aDQo6C20Zvsgd0s/4VM5z9SJZdj1MpQFqiN
	d8otvDeJ8i7GD4KWMEv3ej4l62+ypjIo=
X-Gm-Gg: ASbGncsXmX9ymJarzn9Fk8YBTyA9G2KgP14UXQicJ1tN0AmR2tK01vGYR091Y6L2VrV
	ZhmkZ7bwkAcDQUfV4F0Eqs14sSzWKmanzA7TNc7BYH+2E76cDml375kfQ77AEik6OnoJ1RH3L/H
	pImXIQLSZQKQPV0APcxhFefI24yb66dteHUdwIfwEZzgmsna4vVdms/kHNanVYhmMNTOKZT7GfZ
	15iDlBY9VVyVC75AHdaxa2sWWHcZxGTIwX+Og==
X-Google-Smtp-Source: AGHT+IFiKBS4LhKCc+e3TZ8akuJUR4dSaETLbnVbbjovQRnE+6jXoJciIAqdsOUJ/nrSn5d9rrftqE7Kz3oPsvH4jUY=
X-Received: by 2002:a17:903:3201:b0:26e:146e:769c with SMTP id
 d9443c01a7336-27ed4ad75c2mr30527635ad.52.1758789347230; Thu, 25 Sep 2025
 01:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com> <3562eeeb276dc9cc5f3b238a3f597baebfa56bad.camel@sipsolutions.net>
In-Reply-To: <3562eeeb276dc9cc5f3b238a3f597baebfa56bad.camel@sipsolutions.net>
From: Ethan Graham <ethan.w.s.graham@gmail.com>
Date: Thu, 25 Sep 2025 10:35:36 +0200
X-Gm-Features: AS18NWBFmYuT702hOj_C5JBwnZByzVghQRTr5ikBT0AN32tqz1vkZcQ1S7Omg5I
Message-ID: <CANgxf6xOJgP6254S8EgSdiivrfE-aJDEQbDdXzWi7K4BCTdrXg@mail.gmail.com>
Subject: Re: [PATCH v2 0/10] KFuzzTest: a new kernel fuzzing framework
To: Johannes Berg <johannes@sipsolutions.net>
Cc: ethangraham@google.com, glider@google.com, andreyknvl@gmail.com, 
	andy@kernel.org, brauner@kernel.org, brendan.higgins@linux.dev, 
	davem@davemloft.net, davidgow@google.com, dhowells@redhat.com, 
	dvyukov@google.com, elver@google.com, herbert@gondor.apana.org.au, 
	ignat@cloudflare.com, jack@suse.cz, jannh@google.com, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lukas@wunner.de, rmoar@google.com, shuah@kernel.org, 
	sj@kernel.org, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 2:52=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Fri, 2025-09-19 at 14:57 +0000, Ethan Graham wrote:
> >
> > This patch series introduces KFuzzTest, a lightweight framework for
> > creating in-kernel fuzz targets for internal kernel functions.
> >
> > The primary motivation for KFuzzTest is to simplify the fuzzing of
> > low-level, relatively stateless functions (e.g., data parsers, format
> > converters) that are difficult to exercise effectively from the syscall
> > boundary. It is intended for in-situ fuzzing of kernel code without
> > requiring that it be built as a separate userspace library or that its
> > dependencies be stubbed out. Using a simple macro-based API, developers
> > can add a new fuzz target with minimal boilerplate code.
>
> So ... I guess I understand the motivation to make this easy for
> developers, but I'm not sure I'm happy to have all of this effectively
> depend on syzkaller.

I would argue that it only depends on syzkaller because it is currently
the only fuzzer that implements support for KFuzzTest. The communication
interface itself is agnostic.

> You spelled out the process to actually declare a fuzz test, but you
> never spelled out the process to actually run fuzzing against it. For

Running the fuzzing is more of a tooling concern, and so instructions
were left out here. For the interested, the syzkaller flow is described
on GitHub: https://github.com/google/syzkaller/blob/master/docs/kfuzztest.m=
d

> the record, and everyone else who might be reading, here's my
> understanding:
>
>  - the FUZZ_TEST() macro declares some magic in the Linux binary,
>    including the name of the struct that describes the necessary input
>
>  - there's a parser in syzkaller (and not really usable standalone) that
>    can parse the vmlinux binary (and doesn't handle modules) and
>    generates descriptions for the input from it
>
>  - I _think_ that the bridge tool uses these descriptions, though the
>    example you have in the documentation just says "use this command for
>    this test" and makes no representation as to how the first argument
>    to the bridge tool is created, it just appears out of thin air

syzkaller doesn't use the bridge tool at all. Since a KFuzzTest target is
invoked when you write encoded data into its debugfs input file, any
fuzzer that is able to do this is able to fuzz it - this is what syzkaller
does. The bridge tool was added to provide an out-of-the-box tool
for fuzzing KFuzzTest targets with arbitrary data that doesn't depend
on syzkaller at all.

In the provided examples, the kfuzztest-bridge descriptions were
hand-written, but it's also feasible to generate them with the ELF
metadata in vmlinux. It would be easy to implement support for
this in syzkaller, but then we would depend on an external tool
for autogenerating these descriptions which we wanted to avoid.

>
>  - the bridge tool will then parse the description and use some random
>    data to create the serialised data that's deserialized in the kernel
>    and then passed to the test

This is exactly right. It's not used by syzkaller, but this is how it's
intended to work when it's used as a standalone tool, or for bridging
between KFuzzTest targets and an arbitrary fuzzer that doesn't
implement the required encoding logic.

>    - side note: did that really have to be a custom serialization
>      format? I don't see any discussion on that, there are different
>      formats that exist already, I'd think?
>
>  - the test runs now, and may or may not crash, as you'd expect

>
> I was really hoping to integrate this with ARCH=3Dum and other fuzzers[1]=
,
> but ... I don't really think it's entirely feasible. I can basically
> only require hard-coding the input description like the bridge tool
> does, but that doesn't scale, or attempt to extract a few thousand lines
> of code from syzkaller to extract the data...

I would argue that integrating with other fuzzers is feasible, but it does
require some if not a lot of work depending on the level of support. syzkal=
ler
already did most of the heavy lifting with smart input generation and mutat=
ion
for kernel functions, so the changes needed for KFuzzTest were mainly:

- Dynamically discovering targets, but you could just as easily write a
  syzkaller description for them.
- Encoding logic for the input format.

Assuming a fuzzer is able to generate C-struct inputs for a kernel function=
,
the only further requirement is being able to encode the input and write
it into the debugfs input file. The ELF data extraction is a nice-to-have
for sure, but it's not a strict requirement.

>
> [1] in particular honggfuzz as I wrote earlier, due to the coverage
>     feedback format issues with afl++, but if I were able to use clang
>     right now I could probably also make afl++ work in a similar way
>     by adding support for --fsanitize-coverage=3Dtrace-pc-guard first.
>
>
> I'm not even saying that you had many choices here, but it's definitely
> annoying, at least to me, that all this infrastructure is effectively
> dependent on syzkaller due to all of this. At the same time, yes, I get
> that parsing dwarf and getting a description out is not an easy feat,
> and without the infrastructure already in syzkaller it'd take more than
> the ~1.1kLOC (and even that is not small) it has now.
>
>
> I guess the biggest question to me is ultimately why all that is
> necessary? Right now, there's only the single example kfuzztest that
> even uses this infrastructure beyond a single linear buffer [2]. Where
> is all that complexity even worth it? It's expressly intended for
> simpler pieces of code that parse something ("data parsers, format
> converters").

You're right that the provided examples don't leverage the feature of
being able to pass more complex nested data into the kernel. Perhaps
for a future iteration, it might be worth adding a target for a function
that takes more complex input. What do you think?

I'm not sure how much of the kernel complexity really could be reduced
if we decided to support only simpler inputs (e.g., linear buffers).
It would certainly simplify the fuzzer implementation, but the kernel
code would likely be similar if not the same.

