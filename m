Return-Path: <linux-kernel+bounces-813281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F27B54319
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618CCAA1478
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236D028507C;
	Fri, 12 Sep 2025 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="py/X9XdG"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0295C284B33
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659354; cv=none; b=fSzAv0xV8UxPPMh/KMmAoj2K4E9KKb+sjKUDp63a9cnr8D5UKYaFBtmj7Ewl907ztSshJwHAji6WTxxk8V0NRevZhxfQ676Y2aaHqmGpLjFupcnw6+gq28gRWkoD0k+kWvFYWfDg9OE5+SLPU5LwLtWn0IKAHi9/d2tvpRtPckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659354; c=relaxed/simple;
	bh=NiDw3YhiRCuiqX3s8Sx2YRwxOWOYND2WGqxePm5DDYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZrIShStbq0jXD9Ip83ZchyrdVgJeIEHs2CMHejrKCBvrjO1V85yBZlBpiq0c6EHfv1fOaex304Rh4aughBm5enrDG9vOfzgngpy19KoShiXtdoWakacOd8XWUme4GTP9vTOCwUJ8P4vcGrGw3/2V3utJ6z1b7TjbW4LwjTBv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=py/X9XdG; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7639af4c4acso15797376d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757659352; x=1758264152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiDw3YhiRCuiqX3s8Sx2YRwxOWOYND2WGqxePm5DDYE=;
        b=py/X9XdG3CpLIJmbtrlx9qUjems+Qc7ksjzpDBoJfTUDlQ/q86HjPVcrNWB3emvnN/
         0gIDzaY6CqJeP5rUF/0Le1MwTEkQB49kz0AQKyRJajNNZ71mgWnsaEZDmUqnk9h0UAcq
         z1XK76Nmm5BggXIN0SIbEzNmUKC/iUaESM8PN02RKhYtVf7FlISRVwdh16vu6XsbS+g1
         0AgWwwJlWjud7XM1n0eG9xSi8PzwAooUrIRDsAVSBZJbc42wiSywO9CCeWhd6nwXcq8i
         QPXGs/fvTk6qRpHKWjpkHUmY6yqKRa16bB+Sqfri8JMGPjN72iouigBdKBZA3tO4vqIq
         6mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659352; x=1758264152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiDw3YhiRCuiqX3s8Sx2YRwxOWOYND2WGqxePm5DDYE=;
        b=MMG25P5iBHXotkY4pfr0nscaoLjZUr22t/gYx/30+4cVTKkADchRIn+K3c6x/wEH9X
         UdEtFXN58qkv8oE9qKRf5cWVY9145Bj4qkupTIrgYbvjdWtZ0mmvx7+KSv22QF3eUrkZ
         LKx11PMFQU+yZ414yQcXaVqRPTt/QI8UXtBbAHKAFhYazSHulB9cSr5a7ksKUmgI6/Ia
         h8MYzOScn5mbwwPb9Xmaqph+SiRrELTdt9ArIY9GDEKEuSjXWmg/lEykqj+3fKhEg4em
         eMDSQwCmXr8gC35iW/IOFHy2urBY7qG8QAU4KcXJrEmxdABybfYWbu/6CsSqMAXOHC8t
         nKPw==
X-Forwarded-Encrypted: i=1; AJvYcCXnvzOuxPuroHwcb+fwfbodXyM3BvYvgR2IRJ+ObQhcqBCbkXQX53YccsQ9jdxWDs11ZIRky0xqaWVTdYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjdMDyZMX4MVzHiJzwp/egFb42HciUjekZxxbKQxrL9sCrwcB
	FtOuWqcUSvh9Z2krNAcp5HSJ8fQOk5YtBD29Wcf+9Q8rFa4RiQfpYxoQR2vgPAnk7DBpeDtnnZY
	uEAXWsV8NI/2EgApPENhcqGxtDjod7iCMCX3fxdzn
X-Gm-Gg: ASbGncvzk5RmNy0vBunZlveOqfx4mTZtRkBUMen3UhozDED5gBhTkFr/aV6WooHm9Z8
	p45HoCM65K4zAEjt3nx6QgjyiqktRUmEwpYdJUJs2sokcZF+q5W1i1zJlUWra8u9ipndPM6lxBt
	90niGaQmY1TMYUYneWOpO+bRMARzMHjViO3c10hMk4pm9ys1iDDodQcQyMN7/VvLOuoA/Rjqf+d
	CAvIlmz7zJm4QXwSZY3wonBRVaTBqx0q2BmHiUOYBy5RKARzB6/Ise6kWc4ZhM1jg==
X-Google-Smtp-Source: AGHT+IEySOSJPa6hD6RP73UcA+EVycB47r1tHjCeHNXYQHml1cj7aZJMRHV/AJ60ELcB5pCg7c1N2toT6ZWS7YO29Ps=
X-Received: by 2002:a05:6214:410d:b0:742:1ea2:b5fa with SMTP id
 6a1803df08f44-767beaa719cmr24286056d6.27.1757659351417; Thu, 11 Sep 2025
 23:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910052335.1151048-1-wangjinchao600@gmail.com> <aMO07xMDpDdDc1zm@mdev>
In-Reply-To: <aMO07xMDpDdDc1zm@mdev>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 12 Sep 2025 08:41:54 +0200
X-Gm-Features: AS18NWC5FlcfxTDi4nqpRg0jzSdo_HN5yk0SuuDRYsNBfDIot3LDMm7TkcnabIg
Message-ID: <CAG_fn=V5LUhQQeCo9cNBKX1ys3OivB49TuSeWoPN-MPT=YTG6g@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] mm/ksw: Introduce real-time Kernel Stack Watch
 debugging tool
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	"Naveen N . Rao" <naveen@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com, 
	"David S. Miller" <davem@davemloft.net>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 7:51=E2=80=AFAM Jinchao Wang <wangjinchao600@gmail.=
com> wrote:
>
> FYI: The current patchset contains lockdep issues due to the kprobe handl=
er
> running in NMI context. Please do not spend time reviewing this version.
> Thanks.
> --
> Jinchao

Hi Jinchao,

In the next version, could you please elaborate more on the user
workflow of this tool?
It occurs to me that in order to detect the corruption the user has to
know precisely in which function the corruption is happening, which is
usually the hardest part.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

