Return-Path: <linux-kernel+bounces-830331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EDFB996A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F9819C6CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7393F2DE717;
	Wed, 24 Sep 2025 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQuB7Hba"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406B024A05D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709427; cv=none; b=DcOa9/GQ0ImjVPzxGYTPXlKMNskWEWKoJxLnKhsfIU8/r8XJxrsszxL0fhJ/wwiwDyu7v84LX+8o/73PnCgLKVnlZ6H+LjyLt8z4l4N5z+8meGwVexaA2jNi2q5G+XlJXWjXPbamc+0deWabLlUkIO3F86N1BfkMz27ANY4tDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709427; c=relaxed/simple;
	bh=wljaEKuWWL3DhQrslfw2HXA2fIH2n1hotCcZnEdFrzU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6oQlzCjRNKTKJBX7yCXFmpUPb7hPHNRSb7oBbRnBd2rqY4nqk1r88Uppo5aMXwtsfOMjoqvkUe+GcDANzIdxJzPp4xNB/dU7/swQrgtX/t8PdL1ddngky9gsCJiRpXGSsc8sLgaFGGfFGsGi2Ui/oDJefHSoRg/Osjq4aKXKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQuB7Hba; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so464347f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758709420; x=1759314220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Jip6AA5ytMsKDtIMaGcXPfdygTtTlFWoiPJyBddqbQ=;
        b=YQuB7Hba1g6UkZhvQnqX7kG7/kA0iPVq6hRiQcYuppzIMdnuMyHDsN5XinBxktwfSw
         XwiYbrvWChyRNHLFoFPbl1vugxgssp8iXUv8vMdnAl40qa+ydiM7vsMy2qRNNpcz3WPg
         ohVJmEwuk007AlbzhB1gCBt2gqXYIFJIeoWww8t/Q2bbVhFzFgFRQX2G+xzbibp8hDOa
         io6I5pyRHN1MjmLjE9Vzx4OSXKLnxEwTWYmEUSOlpYOItGi3vL2zaK5OUu0koeK4HVJW
         KuhcUdawj9VbRi8osPa71h/FlG7dK90C52hS8zpMDsll3ucu8tb+h0Fv20S8OGJUXugX
         MbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709420; x=1759314220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Jip6AA5ytMsKDtIMaGcXPfdygTtTlFWoiPJyBddqbQ=;
        b=PDcOeYp0BA3WP39FnC1N9idtoT7pOzFrJVvAeeUADV98weRHXWyd/R0NrXAjZZI2K2
         +JnnnGnbP2fGkOtELhma/86xTg2tCKZZPwmbJZVk1OPuT7uUXvU9brhxpUljAMzFRM/T
         5Z+MyCEIm6c9EI9XQX2Mg+RV9k/ARkMwvvv+iXPIYduascc1r8/ltn9/hj8bIGzG0qYE
         dLbOQmKxFMJjDHSictBre9ncdN3U4AJeOyv9dJeWiWJvN2b1Ephd9x/ITd0IIwyKwbXq
         GH5N+rQ+ZGY/X1J9EciPI9B/Ob0EluqsA6XPjR65Ydp52orbZj2R6jFG4qJH8bjGtwIC
         wYVg==
X-Forwarded-Encrypted: i=1; AJvYcCWMK6/GbM4JnwMHS6MuUTfgEiRQY8rRu598Q18fPD80LN8T63CKzybGIDlCW6IXn8MdlCk0M4JE0wSuQwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJNqxMr93XGHsSdTX/J80QtClhjRY2moItyBdFvg+zr+eH44C
	p8ui9NuE9S/I4I4FJBgT2hjltwGWEAKaRAjtMzHdz7lrXZFF/5j0WrLL
X-Gm-Gg: ASbGnctE0WYAt/+pssW9nb/U4A30aRKBxbN54rxVmhycb9TaPDGljaKBVRjK64NAFmH
	jwSXh4nycRhV7T9PfG257pMHUe0lyHZDadPo5I1OcVI033C51Faua06xS3JOPQgyrVbVg39D3MJ
	SxkJrAhhDHz2FQRAF5ezv0xWlqG/K0ASpbyxS3XDSTTMyqayXwi8kw8r+h2LHdsTeB78XIMe8JD
	sAJADWbmOBIg5rYqiosKIr/S9i++yyfJh3XgQNlfZAJ07eajaOYUprmp8EmdTBTL4MS8ENTTn1q
	DiGsXxLw79XTbE4cI8LY4UtfRor/9TRcs8c1Dli7g430DzJGgRbwx0g6xo/YtTHupnvEabR0aBm
	nCJQbYXFm4kU=
X-Google-Smtp-Source: AGHT+IH7SKx2kJx45gtSN77AKvZD/WsXiJFVRScKsTn2qfd7bVys7yigp6x5cK3vK2f1JlYGEcK1Pg==
X-Received: by 2002:a5d:5d89:0:b0:3fd:271d:e2a5 with SMTP id ffacd0b85a97d-40abe093fccmr1803842f8f.11.1758709420375;
        Wed, 24 Sep 2025 03:23:40 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407aebsm28637355f8f.14.2025.09.24.03.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 03:23:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Sep 2025 12:23:37 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCHv4 bpf-next 2/6] uprobe: Do not emulate/sstep original
 instruction when ip is changed
Message-ID: <aNPGqZfbViOaX82C@krava>
References: <20250916215301.664963-1-jolsa@kernel.org>
 <20250916215301.664963-3-jolsa@kernel.org>
 <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com>
 <20250924084956.GW3245006@noisy.programming.kicks-ass.net>
 <CAADnVQJ6CFD6D9gDb5R=ZnAiXVVJxMe+V3Mv+qniwD13-28MTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ6CFD6D9gDb5R=ZnAiXVVJxMe+V3Mv+qniwD13-28MTQ@mail.gmail.com>

On Wed, Sep 24, 2025 at 11:47:42AM +0200, Alexei Starovoitov wrote:
> On Wed, Sep 24, 2025 at 11:15 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Sep 16, 2025 at 03:28:52PM -0700, Andrii Nakryiko wrote:
> > > On Tue, Sep 16, 2025 at 2:53 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > If uprobe handler changes instruction pointer we still execute single
> > > > step) or emulate the original instruction and increment the (new) ip
> > > > with its length.
> > > >
> > > > This makes the new instruction pointer bogus and application will
> > > > likely crash on illegal instruction execution.
> > > >
> > > > If user decided to take execution elsewhere, it makes little sense
> > > > to execute the original instruction, so let's skip it.
> > > >
> > > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  kernel/events/uprobes.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > index 7ca1940607bd..2b32c32bcb77 100644
> > > > --- a/kernel/events/uprobes.c
> > > > +++ b/kernel/events/uprobes.c
> > > > @@ -2741,6 +2741,13 @@ static void handle_swbp(struct pt_regs *regs)
> > > >
> > > >         handler_chain(uprobe, regs);
> > > >
> > > > +       /*
> > > > +        * If user decided to take execution elsewhere, it makes little sense
> > > > +        * to execute the original instruction, so let's skip it.
> > > > +        */
> > > > +       if (instruction_pointer(regs) != bp_vaddr)
> > > > +               goto out;
> > > > +
> > >
> > > Peter, Ingo,
> > >
> > > Are you guys ok with us routing this through the bpf-next tree? We'll
> > > have a tiny conflict because in perf/core branch there is
> > > arch_uprobe_optimize() call added after handler_chain(), so git merge
> > > will be a bit confused, probably. But it should be trivially
> > > resolvable.
> >
> > Nah, I suppose that'll be fine. Thanks!
> 
> Thanks! Applied.
> 
> Jiri,
> in the future, please keep the whole history in the cover letter.
> v1->v2, v2->v3. Just v4 changes are nice, but pls copy paste
> previous cover letters and expand them.

ok

> Also please always include links to previous versions in the cover.
> Search on lore sucks. Links in the cover are a much better
> way to preserve the history.

will add them in future, thanks

jirka

