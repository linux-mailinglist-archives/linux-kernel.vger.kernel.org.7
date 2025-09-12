Return-Path: <linux-kernel+bounces-813001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA607B53F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1AC3B0E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5329F1DA55;
	Fri, 12 Sep 2025 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9jzRvu+"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC22DC779
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757636727; cv=none; b=UIqpJvCN7HU8dkPeij/jaGXToG/yQSmw3IA4uikJfJvSMfeD2+8t+h7KNfkq0w75qfx9OoJS/8Vjrc8MY0mOoi4CViRx38EyxzzP7S/vDHiDt/zLnljFMFfKz2fAOFTmE6znhhioQ7zUO25eaMZXEf7+BO8klYcAkFhHib3emck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757636727; c=relaxed/simple;
	bh=hp5MIGKEzSFnBE8cl+hkPuzFrbts7C8+p+D14zMNoWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZj436Zab+Vg5H61upbywk08gUMrRelgEgn9wsZyF8qYu4fwoksqa5rrz11Jqnk746xWFQUfPqzGPVat03kvVKEN+CslWyfDm1Wpp1S/6/O46Lz8sKYnTcx5pDH405XtPzZNMNrpktl/44kfFY+F0TlPIzgLA6sPkjekBXyxLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9jzRvu+; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b5d6ce4ed7so199171cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757636725; x=1758241525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBEQ8ZTMn3TZxAlSy9fAiaDOr1I2tmTY9zRoUUHxCNg=;
        b=I9jzRvu+30oBQLVuK5gBFCgmxq/GlXOJVlCkAIKGIRrZGKWMf5nHjebtXrVwEsJUNw
         dm4rJJN7DtosM/iYGP3Iwy5wOkDolsmWWk7GLRsVDYP6ijVvAVa5IMrWpCWKSpoFxdvH
         vL4M7auX0AnqGHzttg3Pc4eV+RdvvBDilBkPrvSapdWHB20olzF+zLkHDjy2azQiQWK/
         yCsyJlg4o+qnxiBb9jscQB0SQrkJ6GunMbIGWsGIKpFSQXEr69ejmyWKKnP/HCgC67hx
         m0peP7Dunjmn2pgvFTgUZFtn2g9wDt4Td+oRszWCBuzJyy+qr/k1fJr/WPfdho8om0jp
         ru/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757636725; x=1758241525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBEQ8ZTMn3TZxAlSy9fAiaDOr1I2tmTY9zRoUUHxCNg=;
        b=XP2xg9LEKslnRw2/rWPzDcq4iVTyyuMS2UGbMAkAIqsNc3MXG631kPKbZpc1Q+Q5r1
         nDjewIeefqO4EMe7T1dltX4XMhc+rdejSQAVgQz+R0FvopDR9J/zedxWar524vuwEs4W
         BxH5u5NCJEzaf0rxMPLILijO5ycGxeB6NYjESmcz0CVzgShtjHnB4Mu4plSFR1ybpHf8
         bLAiQQ2Og9jj2FDcFp2WQC8XYaVgInjKtsCnMTcH7ZoHxr5FyQl+6Aom9cFHSY4zpUv6
         zIqXAkm/DFUgpxD+garQhzZ6vXw9JfwHBkZBitQ+pHv4CMEqmsuUkzNwo1YBgawDJP9B
         TZ4w==
X-Forwarded-Encrypted: i=1; AJvYcCX9UoDReAfbw+hO4XU/d85j0CdwRnC5iD+s/h9Hnfbj37ldgUzzfMQaSC0owjqUOmE96ZruG4GvrV/6ZBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4XUR9Q71s2NWdaa7RLQwfT5MNLX8nXcRkzmVASI1KB2/KEbNu
	wqnEUt8/PXNc1XgslBmMK8KXEjkkoAjXobtfoNWFvWdY7UrRJWpDaQgKazBuqLFVP5/7iGlgnsj
	tt9HeqQXQAQlbMdPKoiwHnBT7HwLDE4vqMlPOEGbj
X-Gm-Gg: ASbGncsDwYRbbIeTEraaqBw/ncnjOV/9afFRGoKADZWZSy5H612ZitiXljwHdzq6BWV
	WEVsA1dI0A0+DFCO1t9m9wWGCleFAWLdnMC+l6E6NgD3nE3TGHZmhshJBKxLAezBCeKSFoqq36s
	VjqydtRxl+U46Mv03ueZ4n6q2t4cMamsyqlWdIqexvB4qL31bNo8rdO7R8IQ9dDIH/DT+xhgLoA
	9NQce3R72OJHqHzZMNqHgNOsVD+NC+hrU2RSj8m/boE
X-Google-Smtp-Source: AGHT+IE+0Ikv6ZmClRprAjJ7En2Cf/iJ3MovNG6j9LOKINd4JOerL1B8XHmC6+uwh0xdO946ixKIpCb4kUZ9Dkji5K0=
X-Received: by 2002:a05:622a:4a:b0:4b3:4781:bf2f with SMTP id
 d75a77b69052e-4b626eb8e4dmr17807611cf.9.1757636724078; Thu, 11 Sep 2025
 17:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909234942.1104356-1-surenb@google.com> <20cafc1c.a658.199394de44e.Coremail.00107082@163.com>
 <aMLvCCZbmpSE/aql@devbig569.cln6.facebook.com> <902f5f32-2f03-4230-aab0-a886fd8e4793@gmail.com>
 <20250911143132.ca88948c48df874f71983218@linux-foundation.org>
In-Reply-To: <20250911143132.ca88948c48df874f71983218@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Sep 2025 17:25:12 -0700
X-Gm-Features: AS18NWCtHRQfQeopObePXdwXorxorF9mUB9KiM1id21GcnnHiYfUjUroiM7mNYg
Message-ID: <CAJuCfpEoWtgv8k4vApkGsNNUYFBnvS-N2DPQu2JrreCUPbT5dA@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Yueyang Pan <pyyjason@gmail.com>, 
	David Wang <00107082@163.com>, kent.overstreet@linux.dev, vbabka@suse.cz, 
	hannes@cmpxchg.org, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, pasha.tatashin@soleen.com, 
	souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 2:31=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 11 Sep 2025 12:00:23 -0400 Usama Arif <usamaarif642@gmail.com> wr=
ote:
>
> > > I think simply adding * to the end of function name or filename is su=
fficient
> > > as they are already str.
> > >
> >
> > Instead of:
> >
> > 49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_cre=
ate
> >
> > Could we do something like:
> >
> > 49152      48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_creat=
e(inaccurate)
>
> Can we add another row, saying "the previous row was inaccurate"?  I
> guess that would break parsers also.
>
>
>
> I don't know if this was by design, but the present format does provide
> extensibility.  It is basically
>
>         NNNN NNN name:value name:value
>
> one could arguably append a third name:value and hope that authors of
> existing parsers figured this out.

Actually that sounds like the best idea so far. Currently the format is:

<bytes> <count> <file>:<line> [<module>] func:<function>

We can adopt a rule that after this, the line can contain additional
key:value pairs. In that case for inaccurate lines we can add:

49152      48 arch/x86/kernel/cpu/mce/core.c:2709
func:mce_device_create accurate:no

In the future we can append more key:value pairs if we need them.
Parsers which don't know how to parse a new key can simply ignore
them.

Does that sound good to everyone?

>
>
> Whatev.  I'll drop this version from mm.git.

