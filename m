Return-Path: <linux-kernel+bounces-874401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498FEC163A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7E31C26FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691A619E82A;
	Tue, 28 Oct 2025 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1QFlI4U"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFFF199FAC
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673165; cv=none; b=FaasvYrJEIy+w1XkYqM1ZolC1jZ4AXnIU7xYuQmDfum9+t26YodqZNu3IQ3JfBp8D0vkHo2jfXKYvkKyAxZOUtTL4cK7TWoAvZZjd6IGvtFP7qdoBOh1v5xHmWorzt0Q+ztyBi7IvrMRX/1A4c5EY8U+N5AG4txAbcVnZogd8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673165; c=relaxed/simple;
	bh=e5GKgH/UTKYoqeaateNe5qxhNdabeLnlG8oSSdUoad4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEP07QsLl01vTNl8GcfwwZ44Oyt5CIBb8Sspj+1ruqCP8R7jH+lslSOdmKWyrJaapwdv21BJwd4vc7bEn+UGQrIWT57UHkWHLd/MWrxVFobJoc3iBczjGKdM9ScOlF8qVoZxXne30s6Wo96c+225JbHfYdVJZrdooYMRbQl2Mr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1QFlI4U; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-87be45cba29so56101416d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761673162; x=1762277962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5GKgH/UTKYoqeaateNe5qxhNdabeLnlG8oSSdUoad4=;
        b=H1QFlI4UXJWp4xwUcmHqd/Npb30gF81hDIFSfgIwdncH0eREcuJtRH0jg0mw0hjjAR
         4ayhnC5xy6phB304/qUK2PUygSMxQGTwAZxtN3xZC81SYSmPhfY0TyFr1JTdcMkU1wc5
         PwS178q7xp8qRH6VseV4BfmG1j6K3fbGr/Ji72nVxt8nZxXc7zJhaBIyK/Ka/UxEijfk
         bq4RS3SGTCl5L4m0h3+3+rCs+t2A9OrUv7G4LtkOBQo/bXF+OdkTAi5UEgcDL59MD/6c
         u40BCJSLQBL5UL+ICVs85AX/ivVJ8YYr54UWQhzcQ427SsguU7UNIOiUFYvh8m6R17Vq
         d36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673162; x=1762277962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5GKgH/UTKYoqeaateNe5qxhNdabeLnlG8oSSdUoad4=;
        b=kgmzLneSfbF7/5Ee3ruVhSKziVK2368kZ+or0seevo9LMiwCKWn3Z48ZRhyr34wMrj
         yFxJCDEY6o8w21+BSsVJ39/felUkn6yu0kcnGjsEInj5EdTuKlcF2aWrWGzeR5+kkz0V
         4qycOf0OpOkjL8T3ynyhrpgYUQuaaA8CTmyw9nHTSh9Q4qiCGD1lLcLDmX19+rvlei0c
         7qHEI6Pmn7AfcEEzUagsy/FY21vlEuko6ZnLAOAKql+IXYvCSMFjdA1bOHvBQOlmzNn/
         IhkMDGEe8prqpBNTfx5eR4q43K5xUvmSERgfGelHk39rnDTcjvNBZ8hvxk8YFabpbzFy
         YqFA==
X-Forwarded-Encrypted: i=1; AJvYcCV/3dOv6Nt6Z3wWw5BZx+dthwECdbUZQ3HCiAziA/wYAk+KhMBpAb8hN6a0z7zaXrXzNarnUPlxmm5z54o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/q3mTdPTH84VYUrg6ovieCuYmknE8XNgxY8dAjAGEQ6+j5ki7
	ct5ifQSI2uf0GmEuxgRyFGToeFKnHjUsbgXb9sTIHQThVzPS6lWc7WUgVSWbAHfoV1xMYyvBYnd
	8kPYuwvlgmg4z/ebT94mRvqTg4QnJ9xUB7X9kCYN5
X-Gm-Gg: ASbGncvG3d6THhoci0zfiJIkxDcnw3vhAaj97XAXhWPeSITgZbylAmNmDueFyvl+jN2
	wbikjQq5y4Ox80Xg5k15g3+R8l26UjXZwiQye+Rd7ILuDa0/d3a3DV680gY9IyavgK/jmdykF8o
	x3pawyPNmSJGZvHguTVEovl2QkzU+UtjBUSZAQ2N+x6fZC2dz2kJwlEftf1dojbWYKW3HnLpJ77
	/wSmzZjmT7uZVwJNfGOug8sQ9bw7PLVycZ5DZwmu9gXa8aOQmPii2b62PXolRbjjpHTvq6lY+Kp
	c9bkKeCoYikne3cjV9uBqCFQyQ==
X-Google-Smtp-Source: AGHT+IEzLhRvjAVm4Cta7u3gqBbuXxGfYAu/L56wiWh0qQYwqjYD99avpLnvK5jAgeVXmSt4Qiq0dgGWWZjR3bNU3C4=
X-Received: by 2002:a05:6214:40d:b0:87c:2b29:2613 with SMTP id
 6a1803df08f44-87ffb13ae3fmr67954756d6.50.1761673161744; Tue, 28 Oct 2025
 10:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com>
 <3562eeeb276dc9cc5f3b238a3f597baebfa56bad.camel@sipsolutions.net>
 <CANgxf6xOJgP6254S8EgSdiivrfE-aJDEQbDdXzWi7K4BCTdrXg@mail.gmail.com> <438ff89e22a815c81406c3c8761a951b0c7e6916.camel@sipsolutions.net>
In-Reply-To: <438ff89e22a815c81406c3c8761a951b0c7e6916.camel@sipsolutions.net>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 28 Oct 2025 18:38:43 +0100
X-Gm-Features: AWmQ_bnW72aQYooWWGflqdYTwRU7KZczsY8iNyINpHaHoghSdwZyWmyrA5jTR-Q
Message-ID: <CAG_fn=XSUw=4tVpKE7Q+R2qsBzbA5+_XC1xH=goxAUZiRD7iyQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/10] KFuzzTest: a new kernel fuzzing framework
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ethan Graham <ethan.w.s.graham@gmail.com>, ethangraham@google.com, 
	andreyknvl@gmail.com, andy@kernel.org, brauner@kernel.org, 
	brendan.higgins@linux.dev, davem@davemloft.net, davidgow@google.com, 
	dhowells@redhat.com, dvyukov@google.com, elver@google.com, 
	herbert@gondor.apana.org.au, ignat@cloudflare.com, jack@suse.cz, 
	jannh@google.com, kasan-dev@googlegroups.com, kees@kernel.org, 
	kunit-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lukas@wunner.de, 
	rmoar@google.com, shuah@kernel.org, sj@kernel.org, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 10:38=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> Hi Ethan, all,


Hi Johannes,

> > I would argue that it only depends on syzkaller because it is currently
> > the only fuzzer that implements support for KFuzzTest. The communicatio=
n
> > interface itself is agnostic.
>
> Yeah I can see how you could argue that. However, syzkaller is also
> effectively the only fuzzer now that supports what you later call "smart
> input generation", and adding it to any other fuzzer is really not
> straight-forward, at least to me. No other fuzzer seems to really have
> felt a need to have this, and there are ... dozens?

Structure-aware fuzzing is not unique to syzkaller, nor are domain
constraints for certain values.
https://github.com/google/fuzztest is one example of a fuzzer that
supports both.
libFuzzer also supports custom mutators
(https://github.com/google/fuzzing/blob/master/docs/structure-aware-fuzzing=
.md)

> > Since a KFuzzTest target is
> > invoked when you write encoded data into its debugfs input file, any
> > fuzzer that is able to do this is able to fuzz it - this is what syzkal=
ler
> > does. The bridge tool was added to provide an out-of-the-box tool
> > for fuzzing KFuzzTest targets with arbitrary data that doesn't depend
> > on syzkaller at all.
>
> Yes, I understand, I guess it just feels a bit like a fig-leaf to me to
> paper over "you need syzkaller" because there's no way to really
> (efficiently) use it for fuzzing.

When designing KFuzzTest, we anticipated two potential user scenarios:
1. The code author develops the fuzz test and runs it locally to
ensure its sanity and catch obvious errors.
2. The fuzz test lands upstream and syzkaller runs it continuously.

Ethan initially developed tools for both scenarios on the syzkaller
side, prioritizing simplicity of use over the diversity of potential
non-default fuzzing engines.
However, because smoke testing does not require a syzkaller
dependency, he added the bridge utility (I believe David Gow suggested
it).
That utility is easy to use for smoke testing, as it requires only a
one-line structure description.
I understand it may not be suitable for users who want to extensively
fuzz a particular test on their own machine without involving
syzkaller.

I agree we can do a better job by implementing some of the following option=
s:
1. For tests without nested structures, or for tests that request it
explicitly, allow a simpler input format via a separate debugfs file.
2. Export the constraints/annotations via debugfs in a string format
so that fuzzers do not need vmlinux access to obtain them.
3. Export the fuzz test input structure as a string. (We've looked
into this and deemed it infeasible because test inputs may reference C
structures, and we don't have a reflection mechanism that would allow
us to dump the contents of existing structs).


> > This is exactly right. It's not used by syzkaller, but this is how it's
> > intended to work when it's used as a standalone tool, or for bridging
> > between KFuzzTest targets and an arbitrary fuzzer that doesn't
> > implement the required encoding logic.
>
> Yeah I guess, but that still requires hand-coding the descriptions (or
> writing a separate parser), and notably doesn't work with a sort of in-
> process fuzzing I was envisioning for ARCH=3Dum. Which ought to be much
> faster, and even combinable with fork() as I alluded to in earlier
> emails.

Can you describe the interface between the fuzz test and the fuzzing
engine that you have in mind?
For ARCH=3Dum, if you don't need structure awareness, I think the
easiest solution would be to make FUZZ_TEST wrap the code into
something akin to LLVMFuzzerTestOneInput()
(https://llvm.org/docs/LibFuzzer.html) that would directly pass random
data into the function under test. The debugfs interface is probably
excessive in this case.

But let's say we want to run in-kernel fuzzing with e.g. AFL++ - will
a simplified debugfs interface solve the problem?
What special cases can we omit to simplify the interface?

> I mean, yeah, I guess but ... Is there a fuzzer that is able generate
> such input? I haven't seen one. And running the bridge tool separately
> is going to be rather expensive (vs. in-process like I'm thinking
> about), and some form of data extraction is needed to make this scale at
> all.
>
> Sure, I can do it all manually for a single test, but is it really a
> good idea that syzkaller is the only thing that could possibly run this
> at scale?

Adding more fuzzing engines will not automatically allow us to run
this at scale.
For that, we'll need a continuous fuzzing system to manage the kernels
and corpora, report bugs, find reproducers, and bisect the causes.
I don't think building one for another fuzzing engine will be worth it.
That said, we can help developers better fuzz their code during local
runs by not always requiring the serialization format.

> > You're right that the provided examples don't leverage the feature of
> > being able to pass more complex nested data into the kernel. Perhaps
> > for a future iteration, it might be worth adding a target for a functio=
n
> > that takes more complex input. What do you think?
>
> Well, I guess my thought is that there isn't actually going to be a good
> example that really _requires_ all this flexibility. We're going to want
> to test (mostly?) functions that consume untrusted data, but untrusted
> data tends to come in the form of a linear blob, via the network, from a
> file, from userspace, etc. Pretty much only the syscall boundary has
> highly structured untrusted data, but syzkaller already fuzzes that and
> we're not likely to write special kfuzztests for syscalls?

We are not limited to fuzzing parsers of untrusted data. The idea
behind KFuzzTest is to validate that a piece of code can cope with any
input satisfying the constraints.
We could just as well fuzz a sorting algorithm or the bitops.
E.g. Will Deacon had the idea of fuzzing a hypervisor, which
potentially has many parameters, not all of which are necessarily
blobs.

> > I'm not sure how much of the kernel complexity really could be reduced
> > if we decided to support only simpler inputs (e.g., linear buffers).
> > It would certainly simplify the fuzzer implementation, but the kernel
> > code would likely be similar if not the same.
>
> Well, you wouldn't need the whole custom serialization format and
> deserialization code for a start, nor the linker changes around
> KFUZZTEST_TABLE since run-time discovery would likely be sufficient,
> though of course those are trivial. And the deserialization is almost
> half of the overall infrastructure code?

We could indeed organize the code so that simpler test cases (e.g. the
examples provided in this series) do not require the custom
serialization format.
I am still not convinced the whole serialization idea is useless, but
perhaps having a simplified version will unblock more users.

>
> Anyway, I don't really know what to do. Maybe this has even landed by
> now ;-) I certainly would've preferred something that was easier to use
> with other fuzzers and in-process fuzzing in ARCH=3Dum, but then that'd
> now mean I need to plug it in at a completely different level, or write
> a DWARF parser and serializer if I don't want to have to hand-code each
> target.
>
> I really do want to do fuzz testing on wifi, but with kfuzztest it
> basically means I rely on syzbot to actually run it or have to run
> syzkaller myself, rather than being able to integrate it with other
> fuzzers say in ARCH=3Dum. Personally, I think it'd be worthwhile to have
> that, but I don't see how to integrate it well with this infrastructure.

Can you please share some potential entry points you have in mind?
Understanding which functions you want to fuzz will help us simplify the fo=
rmat.

Thank you for your input!

> Also, more generally, it seems unlikely that _anyone_ would ever do
> this, and then it's basically only syzbot that will ever run it.
>
> johannes
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev=
/438ff89e22a815c81406c3c8761a951b0c7e6916.camel%40sipsolutions.net.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

