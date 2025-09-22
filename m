Return-Path: <linux-kernel+bounces-827849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF71B9343A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916922A57DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EC0281378;
	Mon, 22 Sep 2025 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBirfv6j"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDED279782
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574084; cv=none; b=XvXGUcH/QEo3GUh01aT6yGEkFXrSiFRjorZzqWnGl3kvvOeGdDillhoBcUCJbWBhUTe3fg5CzBds9ay75M0b3URAKKza2TPxSRFXIOpzTh67HXtkK7kWZsxByxJJnmFJKPcIYUV1Gkjb0OZV5z22nkknzEpBbDacrIQqyj9kRMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574084; c=relaxed/simple;
	bh=pE10PShoxNlFwAuYiz+gEtT3x6OgXhVGNZoXiBF2uwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P30ORX57ISb0rPKDqPe6dEJ6nJ/RC9AcnlT5dne/ywxHC49626bqcJUJvy5v8LeeI8BtHdGLvQZFHVBqDXXdp87UPhAq3GhKO8lkPp3MnehVFXBvbD8vlQelOZxQxVmdgG2HjaVBilU/Vt37NQ8RpEf10nyiBPp60pfnvjT1mKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBirfv6j; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54d23714adso3809769a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758574082; x=1759178882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRupgu2oLIRJ4YbwydOEX0rzUmWrxjSy6aJdxKz3zYU=;
        b=cBirfv6jWy8u9WTREiNseQmsYvd1hKHw316OWDLFZrQIkhn5JVMyWeKBMUSmTv4Pn8
         G+glio0whtwBlMqLPteSE7XoiHPtfOI1haargHIpgmA7q/UlbdNvGXUR7bn5bXUm3Usg
         NQ3XE7Jpk0OE95rvfv8W8/s/vWtrSMWWxD5jAY/40o4ybM35QfnBFII3FWEXBwez3WHM
         HMJzSNQyMqPrp2Htmdh91hX9Q6bQC2OFeJS0g3sBKAZ3o1Nz5tWbfJISM9pN6RP2LMHH
         Fa97Ie8m2nbhxuxnFWdww2i4frkTBeW1ZTOfrTJE0Z14nqRJAJE9n6vXd4UVT/fM3K7N
         Of3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758574082; x=1759178882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRupgu2oLIRJ4YbwydOEX0rzUmWrxjSy6aJdxKz3zYU=;
        b=IaD6IbySBWkMfyMj7HumOF9uj7pwGvcCcbadCMprX7GoeQFVYU9oWxs1OSaWNspANH
         /2o9E5iRwYTIYiu6J1uHtaosTNuio7vBok9FZNIC/gRfIq6mCm/DmAL0g3VH0JEjOLEU
         seFqnejKvjXCsjoCAO5AgAFV5CI9uC0tofFIZiPnWSdM7XerI1kKYgH2+w+KpWv959Kk
         VGccPw/+7KHCzTUiiIb8aPL3tyz0HYfnrC74qp4yNlzSj1smC4kvp/oDLIkP4ENvjxHZ
         G1q5++836PJ7EmXPmS0e7MNQRMCxLXtTfPgg2kd3ZYIPZ4UgOvpXmBjZcqce0Beik8T7
         8yZA==
X-Forwarded-Encrypted: i=1; AJvYcCVIvYxHL21bLslIwYSDZpN5Vl9X8ceIde1eoe9mhC+hA46xcSFCamxl8YDJzpoBik2Zsx1Y+niESCvfxKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDlfE5FxVj7i2c9OImfnG0gGMfVHQcC6vO+nQWr2dv/1kTV9p0
	vihN7LYuJTX66vGSmviPG3I8puP8z0HvUZEfqHuk6n6kjK4Oxw4NG1gP6IBbtZFweKFhFxU+xP5
	LAuFXqzxL7ODEXU1EYWm/ivN8zJ0H+gU=
X-Gm-Gg: ASbGncshcxMoND/ZbP8GokotLg4VEouDsIMEXTTv5x3d41+HcsXvjrxoInNRmVJYdU9
	8e0M4NqrOjQSvobVjevicNPmqD5aC0Xuw5HjXkML3gPfquIYTODpEkyZX4jAnozLChpb1Bgb7cW
	yqBDas0smUH+xyqMSg9Aq1vE3b7pq5iiC1VAgxBPCOLSft5/0GmEsjrjt1gnYxjvnUlR1ceKqHS
	yc9Qp6OsiLUr30ILYKs2JI=
X-Google-Smtp-Source: AGHT+IEUuRWAd6fG0rfybE+0nP/IJA4IiQhjz/jt+hdzGma+ca+nrEuDJjaAUdoxzJ1xY3vBRwKee/XUZdJVl1Lpshw=
X-Received: by 2002:a17:902:f64f:b0:274:823c:8642 with SMTP id
 d9443c01a7336-27cd7464367mr926955ad.10.1758574082268; Mon, 22 Sep 2025
 13:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916215301.664963-1-jolsa@kernel.org> <20250916215301.664963-3-jolsa@kernel.org>
 <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Sep 2025 13:47:47 -0700
X-Gm-Features: AS18NWDxAmgOz0mcGrQMXGNUADECY-kaOgTXybxwa3vFyGGUnDZr74-MswLax0s
Message-ID: <CAEf4BzYfh_oqMOCq8G1S48Ym3th4+wQS1=ZTgRE3OTQrAJnCMQ@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/6] uprobe: Do not emulate/sstep original
 instruction when ip is changed
To: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 3:28=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 16, 2025 at 2:53=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > If uprobe handler changes instruction pointer we still execute single
> > step) or emulate the original instruction and increment the (new) ip
> > with its length.
> >
> > This makes the new instruction pointer bogus and application will
> > likely crash on illegal instruction execution.
> >
> > If user decided to take execution elsewhere, it makes little sense
> > to execute the original instruction, so let's skip it.
> >
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/events/uprobes.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 7ca1940607bd..2b32c32bcb77 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2741,6 +2741,13 @@ static void handle_swbp(struct pt_regs *regs)
> >
> >         handler_chain(uprobe, regs);
> >
> > +       /*
> > +        * If user decided to take execution elsewhere, it makes little=
 sense
> > +        * to execute the original instruction, so let's skip it.
> > +        */
> > +       if (instruction_pointer(regs) !=3D bp_vaddr)
> > +               goto out;
> > +
>
> Peter, Ingo,
>
> Are you guys ok with us routing this through the bpf-next tree? We'll
> have a tiny conflict because in perf/core branch there is
> arch_uprobe_optimize() call added after handler_chain(), so git merge
> will be a bit confused, probably. But it should be trivially
> resolvable.

Ping. Any objections for landing this patch in bpf-next?

>
> >         if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
> >                 goto out;
> >
> > --
> > 2.51.0
> >

