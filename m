Return-Path: <linux-kernel+bounces-843278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2BABBED28
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE5B3BF212
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD7A2459F3;
	Mon,  6 Oct 2025 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5BU/bdH"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F482248A8
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772109; cv=none; b=oGWbYkIV3fRHhOxtuY6wqn+zuYxXg/81UqnSmiHKVkJOZ4UChHuHbRjp0gN8E1LKdbSLMlQF8+An3YMfa/XHd5/aCntLD7jkAzxq+mCSCCO4xhpElkQl8DHVBMeMVjSx+NVsKk/uTgbGcGw1dODQNDQmwkvr96lUTwR7QJkbdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772109; c=relaxed/simple;
	bh=7G7lEHsdRFuPWTJ+Bg1G2NIO8iAqFG5hf7M2mDU7cUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXsTehB6zB6INg/9qwvfAU6voaHN6F3envegscx4pNQoqMPKNqpAWODEdRbXcwn2ATo5dBLER3CwzBkoeYVznEOY4dhn/uVQyZ4jXqD8BzsvlRmi1Ias8FuZ9Ucxe3slZP2Aj0ZPwo7ZdcC5jNExTDAx9WiQP7AzrOdeQlyntGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5BU/bdH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26c209802c0so50449015ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759772107; x=1760376907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3SYJP5oOId3gJHWkwqUX6EUfjqic+Th68f73mKwYp6Y=;
        b=Y5BU/bdHUNYrz/IwcVymiKG4EkD/xlxOJ1r1+EMy1tBOFu9CmPhW+TxMmYRZ1XNM7f
         4j+ccHGcavPCsW5M0+AWFVDecIt8t5UpaNPtgFJyc+OU5i2we7JUszO2yWQZ/Ydp72h9
         LQuaz5YprVG8y7EW7iQDsPmlfv/oUq2MuaWlXbMoBn8/u+bl+MdTlp0FoY8dIcs0m8Mn
         ms+h/Gl7WNlxoHaeprWoBRmbBbvtlbeDc4w0hltoZbJTGP6mltwbNHJRbSbnn3ZTc2Sn
         Bmcb8p4qtmDMb3aG7j+zu6S6ILsMSrVz6cd9NBHoevZMt+mbOBoXRcVvvbFw65B7v8BT
         TvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772107; x=1760376907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SYJP5oOId3gJHWkwqUX6EUfjqic+Th68f73mKwYp6Y=;
        b=ImwLBlBO2JWEaawQVEwuAroIKLa93MToYO+aYqMMvLfcs2b8KINyUDkbJNqv43ZFKn
         R+jFemNZ98Hmf1JpOXUIreofjjhKjJyvUUcCIN/utYEGb1D5xWp0fgRogaNHO83s2reb
         TtVUjNS722QZnImtUOa16vnlS3Vbz4OCcsnBT6ESXXG7VLjxHhgXd17rS4oAdEBy7fQz
         dHrqRTJSHKTFFxDHPaE9kRd0bfeChFDYNBokKU+GxDsgWEuLuM4N6vdXnyRi9huiJSgr
         FZ62/Eo2RfaLYQ1+F4+/ZQCBYKXHdbS57kCKIWd/VWE4jouiJQafNBpyWjnYUQl4FAfB
         xoUA==
X-Gm-Message-State: AOJu0YxsWBjLtoETbF82U8jOEekxcm1Kbeq/tZH+vwMDAREkTIgeXBoS
	dVD/6VC96XvokgCXPoMhZigfMWZIj9lBPk6D4qptzX5a2BUX0jcIGqfWUKt9SU+IYZ6ReBF7a5U
	JcyON9ZhLgdvpaFPstaoV3AOhv0Dc//2wV19RvAU=
X-Gm-Gg: ASbGncvn6G87F8pib28gZ0Lg7ovoaLYOP/fwtn3+0ssXwwjDG/FJuTgyv8uO9r7Sa0P
	ipeNyQzIElH4lZ0kEZuzXQn0a8tb3afMXErVvdNgmqTuCqtYo5PMzTAooGfSGrUgFDj0GJTXldl
	AGsaB+qyb5aVhEo86B94ty/gqn5CCW351nUCM1Yd44fyLIQncF8uFEXPHVSb6Q7BfO7R2cG2ffo
	wUi/WN0X1+NJVPZOkv+7UotS1Jai9K99OiSCjdaPXVdeE8Z6LPz2fAskwMz+bG5JDroNnaM
X-Google-Smtp-Source: AGHT+IF7t/5uimt4spMXHcCSvFX3PWO+3xbZeZW/6BTEqZvA6CGHFJvw6CuEVbkxxqCTitoWh5b/CNIY1RkDf+GFkFE=
X-Received: by 2002:a17:902:ccca:b0:27f:1c1a:ee57 with SMTP id
 d9443c01a7336-28e9a574b8emr150187535ad.16.1759772107216; Mon, 06 Oct 2025
 10:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006170403.3584204-1-rrnewton@gmail.com> <cbc8d5bc-4ae7-4b61-81f4-9629857736f3@arm.com>
In-Reply-To: <cbc8d5bc-4ae7-4b61-81f4-9629857736f3@arm.com>
Reply-To: rrnewton@gmail.com
From: Ryan Newton <rrnewton@gmail.com>
Date: Mon, 6 Oct 2025 13:34:40 -0400
X-Gm-Features: AS18NWAICzboon-dCcAZVmLAwb0KjDAxIb0J9x4vN2jrS0oGI-oB8eLAAivDRiA
Message-ID: <CACYs5AbjoLKSv7SasUyJH=j6XF+3Zuyp_0CJUrnsA=8XDDW6bw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] sched_ext: lockless peek operation for DSQs
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, tj@kernel.org, 
	arighi@nvidia.com, newton@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Christian,

Sure, the lavd with peek is here:
https://github.com/sched-ext/scx/pull/2675

Beerland with peek is here:
https://github.com/sched-ext/scx/commit/c2a0f185051c06cc1ebae1dc40e5fe2bd30=
22c1e

The qmap one was not a meaningful change to the scheduler but just
extra peeks thrown in with debug prints.

Cheers,
  -Ryan

P.S. Good catch on the two newlines being split into the wrong diff.
Argh, I was playing with Sapling's `sl absorb` and I swear it said it
amended the earlier commit. Apologies for not catching it. FWIW here's
a tip with that correction:
  https://github.com/rrnewton/linux/commit/db426f852813e2b6deeae0869d20df1b=
ea647a07




On Mon, Oct 6, 2025 at 1:20=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 10/6/25 18:04, Ryan Newton wrote:
> > This allows sched_ext schedulers an inexpensive operation to peek
> > at the first element in a queue (DSQ), without creating an iterator
> > and acquiring the lock on that queue.
> >
> > Note that manual testing has thus far included a modified version of th=
e
> > example qmap scheduler that exercises peek, as well as a modified
> > modified LAVD (from the SCX repo) that exercises peek. The attached tes=
t
> > passes >1000 stress tests when run in concurrent VMs, and when run
> > sequentially on the host kernel. Presently, tested on the below
> > workstation and server processors.
> > - AMD Ryzen Threadripper PRO 7975WX 32-Cores
> > - AMD EPYC 9D64 88-Core Processor
>
> Is the adapted qmap and lavd available somewhere?
>
> >
> > Initial experiments indicate a substantial speedup (on schbench) when
> > running an SCX scheduler with per-cpu DSQs and peeking each queue to
> > retrieve the task with the minimum vruntime across all the CPUs.
> >
> > ---
> > Changes in v3:
> >  - inline helpers and simplify
> >  - coding style tweaks
> >
> > Changes in v2:
> >  - make peek() only work for user DSQs and error otherwise
> >  - added a stress test component to the selftest that performs many pee=
ks
> >  - responded to review comments from tj@kernel.org and arighi@nvidia.co=
m
> >  - link: https://lore.kernel.org/lkml/20251003195408.675527-1-rrnewton@=
gmail.com/
> >
> > v1 link: https://lore.kernel.org/lkml/20251002025722.3420916-1-rrnewton=
@gmail.com/
> >
> > Ryan Newton (2):
> >   sched_ext: Add lockless peek operation for DSQs
> >   sched_ext: Add a selftest for scx_bpf_dsq_peek
> >
> >  include/linux/sched/ext.h                     |   1 +
> >  kernel/sched/ext.c                            |  56 +++-
> >  tools/sched_ext/include/scx/common.bpf.h      |   1 +
> >  tools/sched_ext/include/scx/compat.bpf.h      |  19 ++
> >  tools/testing/selftests/sched_ext/Makefile    |   1 +
> >  .../selftests/sched_ext/peek_dsq.bpf.c        | 265 ++++++++++++++++++
> >  tools/testing/selftests/sched_ext/peek_dsq.c  | 230 +++++++++++++++
> >  7 files changed, 571 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
> >  create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c
> >
>

