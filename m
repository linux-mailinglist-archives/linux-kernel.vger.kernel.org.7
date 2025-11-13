Return-Path: <linux-kernel+bounces-898521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E45DC5574A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07F02343527
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D82F9DA7;
	Thu, 13 Nov 2025 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajXpbqFp"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB42BF3F3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763001522; cv=none; b=N9UQavCKjlSortxhRO+AiKXWJjCXlzHCBLDkO0o5/oN55cjLdC4psykE4AQGu+JAbTvWVLJO/eYeY3EfnIfXvNliRmkJNibmQVd/X98cZ/MENrlXYq/AK9LPsnUtJ8kb46QLL8WfcaB6tCzHBjYcBvGLc4pJJo0S2GFp38uWRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763001522; c=relaxed/simple;
	bh=b9nrhEPfCiyZMSsvm1GGUlSZszYX6kHmfuhCM7AblyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcMQo+3VZZQ3AvU40taVaVbewAFK3Jx4gzmM+VwVLIJl3hOIGpwrEYodg+hFRJK9HsvQlTQ9WY/egE1YhkIcQRdU67xp225aVabaWn5TIqf5/5ASzftSum+jMOOjeAzTpH8HNUvvGsmBPvOKLD3BZJE0btvPFM5X8nWbEGjIQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajXpbqFp; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso513741a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763001519; x=1763606319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+96ehWUDXlUzB4eDVsRts8db5j69ugG1igF8TDcUmE=;
        b=ajXpbqFpBUEzBavrZWz57MBp6AJW53Niyg/ko+EmvkcuXsIe11107HiQlZkjeiEB41
         5z9eTf+Yf22tm/J53LbDAXyj8t0e6uk2RgQ5oXBVlqrqzEURGJKdi08gnAEx8+UZIiBJ
         DY+qLdG002KeFI6TukYz9/ApbiL32KV8HTFm+6KrQw2vgzZLTt2FYDZZ2imAyL8DU0/a
         sX0d54XqZHVvrKQjTQkgcBLQ86qqV+4sZ7UwBw/C5K9P02sxQ1Eqr3mi1Gwv1fPrz45G
         +wgLTol73pi8VO3Orrg0ybVb/VHMLsvWvPNFoZLbr57gvJkIDgUNR1isW38u44qoyEeW
         K4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763001519; x=1763606319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N+96ehWUDXlUzB4eDVsRts8db5j69ugG1igF8TDcUmE=;
        b=R5q1p93OqcZ8QD9WMYPi4K8CaCjmJ9JhUPQNUA8yEzItgtjYxIduboS7RI36gcgj0H
         ItxKHNLlIjxCYKkvWTz7WXk/qVr3P/6g8E3qcbnfSYg1cRMn0w35/2BEZaukGtcXwku2
         noeny6KFH+abMLWaM9KiJC+lIGAqB/Tvb6I1CJXJI0nVoiP/BvKmBfn/G4GRfuEjXpTV
         VC/Q32xiHjq9KQ/A29xCDfOlRzDhP15a6NesiEdbtelXcoTrq/Kbxa7XSYdPdEtdsP/j
         XnH+yp6hQHHKYSXKOrbyWQK2mNI42GaL0uyMwFoHEnkZ2qiZC6NDe32ZSzBB8Wq7oZiU
         luLA==
X-Forwarded-Encrypted: i=1; AJvYcCUmZ7BMQAl6rbXK3TiWCemO23A69zn4t3tPLxCpuz+KCtGVN/lD64/x+VONvN6/Fe1E2XmNTzVT7qyyX9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ZEMf2lFRYqDyL5bJHLoZ78yzfjfyvjTFBC27LQgCFTX0IeUk
	0NZ9TxyYMYAZxYSc0KhJ5Am5sVhB9A7kIrSCijyziof3H9zOYh/e8jlQHS6jcM4feDCn0ofCbxX
	44tLgKnumbp7I5StHIkay96vKG5QobZM=
X-Gm-Gg: ASbGncvX0zsizQSYraZ9Eouphp4J8edGNwQ/9GH+t78rfsXrjBv2szJXymgSr7MRlZK
	XsuLiYB8AcHaQvig59QQDbdtvRbuJNbl620ILgmoHBU0I3Qb9SwT30/aN0yPHiwPNsTQ3SlvM1s
	xgCa0hD4bYY5m8OMqQ4QqUL0T9+BPPZKCnmTmcLPMzNROLBdIu+RY3S2eqBxJY5zMfRUYz4RByp
	BJbpltzAgguBSF1BePIjEgip34uqR25APzb3ElhMa9D4sjAw/GI2WQoCGCM5Lwpf8el5IvG
X-Google-Smtp-Source: AGHT+IH00h0RrxArZVMyx5i8z0vIkw51lctnegt2Ez1yz7f3Em2ufp8UAQKctIC3wIwZ1t70+vvarw7vNaphmjfycNA=
X-Received: by 2002:a17:907:3c88:b0:b73:222c:1e7f with SMTP id
 a640c23a62f3a-b7331b2f9e2mr537858166b.62.1763001519109; Wed, 12 Nov 2025
 18:38:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112034333.2901601-1-dolinux.peng@gmail.com>
 <CAErzpms8oRkqJhxk1R6LMUq1GeZT3TqkPOm2yRAfY1ph_F2YNw@mail.gmail.com>
 <20251112103804.4a43591a@gandalf.local.home> <CAErzpmt8Dsq3f6ZUvtmc25hvy0NH6uRxBHPSxeZhkFfzkdJ04g@mail.gmail.com>
 <20251112210236.07deb6b2@gandalf.local.home>
In-Reply-To: <20251112210236.07deb6b2@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 13 Nov 2025 10:38:27 +0800
X-Gm-Features: AWmQ_bkw_Ikkq5MjVmbc01vPLShbMH0gn-vMCA9Ltdvj0VuAomw9ENBZWeJzyD8
Message-ID: <CAErzpmsn-uys3VdchF_CKBPUQT+328wtaKnbufoDi-o9x7eHaA@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>, 
	Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 10:02=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 13 Nov 2025 09:48:52 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > I noticed that when funcgraph-args is enabled, it registers
> > trace_graph_entry_args
> > to replace trace_graph_entry. The only difference is whether a valid
> > fregs pointer
> > is passed.
> >
> > To reduce overhead, I propose consolidating the two entry functions. We=
 could
> > maintain only trace_graph_entry and pass the fregs parameter to graph_e=
ntry.
> > Within __graph_entry, we can then conditionally record arguments based =
on
> > 'TRACE_GRAPH_ARGS && !!fregs'.
>
> What overhead are you reducing?  Why add a branch statement in a critical=
 path?

Thanks. During testing, I found that enabling funcgraph-args incurs signifi=
cant
overhead (344ms) compared to other trace options (near-zero).

# time echo 1 > options/funcgraph-retaddr

real    0m0.000s
user    0m0.000s
sys     0m0.000s

# time  echo 1 > options/funcgraph-args

real    0m0.344s
user    0m0.000s
sys     0m0.344s

So I thought it may need to be optimized.

>
> The graph_entry() should not be looking at the flags argument. It's calle=
d
> by *every function*. Also note, I recently fixed the flags to be per
> instance and not global. Which means testing the flags would require
> indirection lookups.

Thanks, I agree and it indeed introduces extra branch instruction and
may introduce more overhead when using indirection lookups.

>
> -- Steve

