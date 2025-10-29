Return-Path: <linux-kernel+bounces-874949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9161C17B41
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C48E354F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B3B2D7DDB;
	Wed, 29 Oct 2025 00:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Db3JaVht"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9618F24BD1A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699563; cv=none; b=B5ZFdHgSiH6NI0mFCbNMgtmmWY0mo+ybqlx4rXDwCJFsRmN479xziweXwMHyKjoA+hZ1iUD8hCuk+Lzr8PAKucwENl9RvL5QHHP0LOo6LuJ9g7Ox/fvbC1vgcJeKidyyOX2txieSWDnJGEamgx+HZECo1VtyVITSng6AV4WJghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699563; c=relaxed/simple;
	bh=59r1336W9+OTwstjI3TwUKacm6kaOVnO9mxXZSPTbCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kdd9Ztfu8GcEQIZQO8rIJWEj2pgOioSQGmvDZxJNuqDaVRgBXh4/OY+asqaaHpQhUoMdWlxi1zhb/dq3QVC5INj9IDPYHuSPWabi5t5MR6spY1CwLWYlz9s5HM4MBp0UYUFWntbUmAEi2IpP1ePFNVu2ghZ8T/seziDTaupjksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Db3JaVht; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b6d78062424so1416986566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761699560; x=1762304360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yugpZ0CmKY4qcuIn89QXxUqHhihKLi+NyAHXMCOOMuA=;
        b=Db3JaVht0retmi2cB9so6yct1h7lPAgQ2ae+DLSrCtbw+xRG/K8bmGbYR9Ad6UTsjk
         hrOMjFUlZKxdihKlesmup1xTALN21xQI8EzAbAAivpjOcLEKNSvwQ4vFJIjkqSz+JjAh
         8gzcg+Sa45ywWdPsYD8RnrKIsJCj3u0azwrGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761699560; x=1762304360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yugpZ0CmKY4qcuIn89QXxUqHhihKLi+NyAHXMCOOMuA=;
        b=IW9Aq2yyALsWeJFmHrO1CdoTvm6ze2/f3oJx2TAFjCaoQsjteEb0N3+13y7btTx+7E
         HGHkzwVKaTcW0m03f/d1RiZoTwpBudarYEnmDowW9CcjEj4TmbOXimeOHZYiRoKck63z
         x3V3CReYepKeBmxw8fcklzVcIu3wflPIT4bni/q0HpInZ893MMX68DnTj8seBwDkr45n
         L/2Ze7DkpLc8Y01nwU8A3MPnzdCjZRKQCEnkSFoD9xk9PJ154nY7wP28ZVPP/NvlE6dw
         Is0IflhuuB4IblH0Rx7OXpl5YNpf1opxtFyvt4/S7Jtqe/8p1DrzksK79KI1JBOuf+4b
         tJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXScamiM9IS9Cq3XYyzrtmlbHhHi6/UQ9Qz5vk6P1p7FLsrgoXKA92T1KCtk8USE/FcCz0Ts2B93ZGFSTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEiPhMDeZmpgmaE9rDJ836JyIHNQvdtrLA6Z45qteKFVpH8i3B
	vQXY1BN/vKgWp08OPYkkaJ2D6LBlbXZ2o4E889VFBxqQzil5jLVj8/TVmU1rpmowca6I8OPcOp1
	8W+MZWVcvBg==
X-Gm-Gg: ASbGncvmqlyoGUYkIvlRA2feW2gBT3wt+g8oNvmkX1vbWAg2WGUnhrsNpaSk6j0N4k4
	mCfQPBfcd5s3imavclzI6nmRT3Ok6yxMNUx5lldYR81+aDIrlFyXXW/LjsDWLhP9vqhVcqUMend
	p1E5+KPFn6lJzFutktlfwZnrSO8wiZBv96NL6inj+VetThqndUO2rtPdr0p5B91xzB20IDblRTi
	lpi18OiFpdMdVmFQgCcbMDt5pZ8Od6jmNeJ3K/QiTScSnEdI+mRBY+GLKoDJVGyFdj5Z5lhdSBU
	6cyCkEnUbaUgd5WnDi9sDqKvdfth97cfaXCuGRUFKx/zlTyHCyYwqidECeCJJ0bqDOZfLo4aBSD
	ZLwfmFxpTs91vLS46tK138d3FxjE5PxqV/+huKr3fpwuhVXDE5T+bpSDyhWYb60m5SXoWTFShDs
	3AxFkLon+10YuC4Em8iHE+80AORBtYLzgwwBNhlJWB18Ix03DkEQ==
X-Google-Smtp-Source: AGHT+IEH+TI5QgvCnZslam0zQn7pW77kAhYe+Ge/xZZbHdmH6rywrnhNSFYbsCxM4v+MlM/989uj4Q==
X-Received: by 2002:a17:907:a088:b0:b46:abad:430e with SMTP id a640c23a62f3a-b703d4cdbb3mr92155366b.37.1761699559709;
        Tue, 28 Oct 2025 17:59:19 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85309074sm1241824566b.2.2025.10.28.17.59.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 17:59:19 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c31c20b64so10413757a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:59:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbsos+IQYV4gOOyTNut0sV7lwFckJrkgvw+aMCmkEJD5IFJ6JVjakshj2nXGX/0Fka94e6Djq5sFIKbWw=@vger.kernel.org
X-Received: by 2002:a05:6402:5244:b0:63b:ede0:240d with SMTP id
 4fb4d7f45d1cf-6404419f0e1mr699847a12.4.1761699557818; Tue, 28 Oct 2025
 17:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
 <ubqjeplvslhnspqw6pnqwo7c6sq2ygdtmkuqr4q3hjlxfkuwii@xn63k6qz22mz>
In-Reply-To: <ubqjeplvslhnspqw6pnqwo7c6sq2ygdtmkuqr4q3hjlxfkuwii@xn63k6qz22mz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Oct 2025 17:59:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgs8+xVbv5tu9kv5n=LwWFZ0FW4GPwVmXBPjLQ0goLfjQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnWsezmseuUgtNvSRArtoGyuOm8TLGzEUg_cA8BtlMOKIE_K0kYA-m0NJ0
Message-ID: <CAHk-=wgs8+xVbv5tu9kv5n=LwWFZ0FW4GPwVmXBPjLQ0goLfjQ@mail.gmail.com>
Subject: Re: odd objtool 'unreachable instruction' warning
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 17:21, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> See the diff below, hopefully that fixes things for you?

Bingo, that patch works for me.

> On a related note, it would be nice if we could make that codegen more
> readable...  Here were a few formats I had played with before, any
> thoughts?

I don't think any of this is ever going to be remotely readable,
because of the whole horrible section noise.

If I recall correctly, one of the ideas you had was to use macros to
make things more legible, but that sadly didn't work with clang or
something like that?

Anyway, I certainly agree that we can make it *slightly* better, and
I'm not objecting to trying to do some incremental improvement, but
it's just always going to be pretty bad, and so I'd probably always
end up doing my ugly hack anyway.

Because for the assembler readability case, I do think the "avoid
alternatives" is just fundamentally nicer and simpler.

Now, at one point I tried to do a build config option to just have the
"assume feature XYZ" - so that you could just have a config option
that turns on SMAP and other features unconditionally.

That made the asm obviously look fine, but my simplistic patch at the
time made the source code itself so much less legible that I trashed
it. It just ended up being a mess of ifdefs.

(I did think that maybe I could make my patch cleaner with a few
helper macros, but it all ended up feeling like I was overthinking
things.  I suspect very few people actually care about that legible
assembler thing. End result: I just ended up with the very simple
local hack in my tree)

> Note there's also an objtool "disas" feature Alexandre is working on
> which will show the disassembly annotated with runtime patching info
> (alternatives, static branches, etc):

Yeah, that would be a good feature to have, although I wouldn't
obviate the asm cleanup for me.

Depending on what I am looking for, I end up looking at either the asm
output and the objdump output (or at both) because they each have
their good and bad parts.

Sometimes I *want* the comments that gcc in particular adds to the
assembler, and sometimes I prefer the "raw objdump" format.

Oh, and Alexandre: if you are working on improving objdump - are you
perhaps also looking at making the relocation output saner?

Because I absolutely detest the odd relocation output format. I use it
occasionally, but it's just crazy to see things like

<delayed_put_task_struct>:
        ...
        call   <delayed_put_task_struct+0x1a>
                        R_X86_64_PLT32  rethook_flush_task-0x4

when any *sane* tool would just output the simple

        call   rethook_flush_task

instead.  Because as it is, the line without the relocation info is
useless, and then the separate relocation line (with -r) is just
crazy.

I kind of do understand why it happens - few people care, objdump
supports many different instruction formats, the instruction decoding
is a separate thing from the relocation logic etc etc. But if somebody
is looking at making objdump generate prettier output, I'd love for
this to be one of the things fixed.

(And yes, I see this horrid output because I run objdump on individual
object files before linking, because it's *so* much simpler and
quicker)

Again - the real problem is that I'm just doing odd things that are
probably unusual enough that very few people care. And I've done it so
long that I can deal with it and read the horrors when necessary.

So it's not like this is a huge problem, it's just that I go "Oh Gods,
objdump output is not meant for humans" every time I do this.

                Linus

