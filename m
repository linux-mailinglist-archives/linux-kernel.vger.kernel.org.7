Return-Path: <linux-kernel+bounces-890432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 469AFC4009D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0351188A66B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE66D2BFC8F;
	Fri,  7 Nov 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BupN8VM9"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F442BEFE4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520927; cv=none; b=TpY1FiZZs9VwABKsnG9pCa4U/6iY++xO8kndYRIVJe1aOxrDbCZZiAyHQEMd3hIn3ik73VzmvsHNd3JPOuQD/zbuVxs32NtTEVNfyggB1j5xkfjgL7CI2H4JrtM71wM3aOMh3VN219z3uncTudai9Ma73j1YytiXJT0JXq9onPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520927; c=relaxed/simple;
	bh=OWiEd8XbPv8RdYmPKuplSxpJVZGnRYjpmY5XLgep+8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJyS2CINVjYJ5AjBs8Fkl3v+XJotRUA1e3Nk2PpSwSNfhl01IavzE6yV4rVtTQuiAXtR/Pukrgs0Q11Pq+Xkd42dI+2lM2otYXsz+VlmTfXBAaqNS0VJRjIqiYqt3oDwX27MfOGuPoxZ8bOmvchrmsxQ7H/hnDu2QAyUvokOgiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BupN8VM9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so1128755a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762520923; x=1763125723; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C1ywOlu3fOSK5EDS/96Lv9KyExdYs4hdjZJBrhwyZV0=;
        b=BupN8VM9+coHpMkoRAxsJOTc5Rp4vj4FXlg+/oDipm87kfldmi9RZo4b2Ib1OXVSQb
         E2avwPk3CHm88DmnhQAv6bB2WJFQqU6BDKEdzvMfoLwAuKNpCbsiiN3DCQPUN1NRVCjh
         qa5SMJQh27m+8e1VL9EkmxPaPO3eoqVCvdfqGQAxswXjGAk2wGZTI1El88FuMAw+N1RX
         y7CrHujXk5aTA1cbkBVPZvvHKXeXc5fWp8ezWBQXzi2LEC6MG2molG4R2me7EBjYz+qd
         37ej3/IY4jqzfUZqZCfTDlIM71qH9EDqJPxhXEEobynZdXxUrlnI5xUq8r8T67mmoevH
         os+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762520923; x=1763125723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1ywOlu3fOSK5EDS/96Lv9KyExdYs4hdjZJBrhwyZV0=;
        b=QP6ytW0PwHz40DrUGeTFwd9bJxiglLkARWmeLbQM3oOSepLZ6IoarJuifEFGfQ83Rw
         RRmMDOXpYys/Sg/t0pLuRQ5IDIFI500wvdZXb2Or/gtvm/BtNxTrOwux1S5rhHMMW+Th
         xUZ4DLK5hiBwEWWIJcYAXuQN9OfJS1gGNudMNR7zZU2DRpMM1oN7WFq2fBeMPNVzNuzz
         3frFqBcT3e+Oue+rjReigY91ArVol70h9Ccu8+FbrO8xAGvDXHqQK8Ry8fxO5bXEMKRW
         9XVMGWPNhsNrTFRhhEUC2qaTMHblX3BBpzoIqYFLUG+7W12UdWizDurym9ofZLjV9Hue
         J3fw==
X-Forwarded-Encrypted: i=1; AJvYcCUKDg09NE9Ye4yG5STCzxSD8NZ3mgNyC8ufboZsOYEZwfJZlDIX+BWkbinYaxCc4QBz4LKu2PVtvlVpdW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKduF+vmp/Ez7VW4hX5alhsSZP7nBJlXXLoFoaYMpIRijHQ6lr
	jkbccsiCMeaJqJHnWeeggeQ2wQU4wNi1JevY2YXEc4SjBmzFAoyohpB/xKSzkq2TknU=
X-Gm-Gg: ASbGncsrTTWCtcbPYsZp1dKIAzhxZU0DncuTl6bEOXZvyeJBOlZ6uCCFgTd0Wwv791C
	A0ICKDVJQR240ewhoKTGBubxRXQvuc8FuPPrt8vwrdNA8gwcbgWDgIgOfWOLJsgYENPRTbvpzx9
	o6zHuG2K5IChpPqnPuDz/uoyy8Q2D8VbGlxqtWE0UocCm5N1t2ru/axCYjTaDFM+rt7RYVpl0rF
	9ur58S9Aqt4W+xAcVfUeCsrTsnnKqTXvvbCuyGwZ+cmxBPGYUA/oGY48DtUCtSiglIzJZBl4yhz
	+79fq+5IMA02ENsL6HmnWy8CQo7bRmnzH3/IUj0NJQ9aNH1PhpsTZEkuQ6XO8Bifjml88kasjvi
	JmaIr2zxJJfFxbF9860SLuofWsTIO2JlDDPjXBjVszIhClChIYggFekJYHNlcDW/YYpyL5Kq2e5
	HuC9lgs53xiXhV0A==
X-Google-Smtp-Source: AGHT+IEouSTBDMcG/tchDfHpDvHcGOn021q8OTyah/7d7vm3vufHhiqKNCiTpyQWqwWHE044VaVj4Q==
X-Received: by 2002:a05:6402:90a:b0:640:9b11:5d65 with SMTP id 4fb4d7f45d1cf-6413f061d7fmr2900743a12.24.1762520923128;
        Fri, 07 Nov 2025 05:08:43 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f71394csm3968988a12.6.2025.11.07.05.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:08:42 -0800 (PST)
Date: Fri, 7 Nov 2025 14:08:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	linux-modules@vger.kernel.org,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] kallsyms/bpf: Set module buildid in
 bpf_address_lookup()
Message-ID: <aQ3vWIqG31BgE4YD@pathway.suse.cz>
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-4-pmladek@suse.com>
 <CAADnVQ+kbQ4uwtKjD1DRCf702v0rEthy6hU4COAU9CyU53wTHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+kbQ4uwtKjD1DRCf702v0rEthy6hU4COAU9CyU53wTHg@mail.gmail.com>

On Wed 2025-11-05 18:53:23, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 6:24 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > Make bpf_address_lookup() compatible with module_address_lookup()
> > and clear the pointer to @modbuildid together with @modname.
> >
> > It is not strictly needed because __sprint_symbol() reads @modbuildid
> > only when @modname is set. But better be on the safe side and make
> > the API more safe.
> >
> > Fixes: 9294523e3768 ("module: add printk formats to add module build ID to stacktraces")
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  include/linux/filter.h | 15 +++++++++++----
> >  kernel/kallsyms.c      |  4 ++--
> >  2 files changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index f5c859b8131a..b7b95840250a 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -1362,12 +1362,18 @@ struct bpf_prog *bpf_prog_ksym_find(unsigned long addr);
> >
> >  static inline int
> >  bpf_address_lookup(unsigned long addr, unsigned long *size,
> > -                  unsigned long *off, char **modname, char *sym)
> > +                  unsigned long *off, char **modname,
> > +                  const unsigned char **modbuildid, char *sym)
> >  {
> >         int ret = __bpf_address_lookup(addr, size, off, sym);
> >
> > -       if (ret && modname)
> > -               *modname = NULL;
> > +       if (ret) {
> > +               if (modname)
> > +                       *modname = NULL;
> > +               if (modbuildid)
> > +                       *modbuildid = NULL;
> > +       }
> > +
> >         return ret;
> >  }
> >
> > @@ -1433,7 +1439,8 @@ static inline struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
> >
> >  static inline int
> >  bpf_address_lookup(unsigned long addr, unsigned long *size,
> > -                  unsigned long *off, char **modname, char *sym)
> > +                  unsigned long *off, char **modname,
> > +                  const unsigned char **modbuildid, char *sym)
> >  {
> >         return 0;
> >  }
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 9455e3bb07fc..efb12b077220 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -374,8 +374,8 @@ static int kallsyms_lookup_buildid(unsigned long addr,
> >         ret = module_address_lookup(addr, symbolsize, offset,
> >                                     modname, modbuildid, namebuf);
> >         if (!ret)
> > -               ret = bpf_address_lookup(addr, symbolsize,
> > -                                        offset, modname, namebuf);
> > +               ret = bpf_address_lookup(addr, symbolsize, offset,
> > +                                        modname, modbuildid, namebuf);
> 
> The initial bpf_address_lookup() 8 years ago was trying
> to copy paste args and style of kallsyms_lookup().
> It was odd back then. This change is doubling down on the wrong thing.
> It's really odd to pass a pointer into bpf_address_lookup()
> so it zero initializes it.
> bpf ksyms are in the core kernel. They're never in modules.
> Just call __bpf_address_lookup() here and remove the wrapper.

I agree that it is ugly. It would make sense to initialize the
pointers in kallsyms_lookup_buildid and call there
__bpf_address_lookup() variant. Something like:

static int kallsyms_lookup_buildid(unsigned long addr,
			unsigned long *symbolsize,
			unsigned long *offset, char **modname,
			const unsigned char **modbuildid, char *namebuf)
{
	int ret;

	if (modname)
		*modname = NULL;
	if (modbuildid)
		*modbuildid = NULL;
	namebuf[0] = 0;
[...]
	if (!ret)
		ret = __bpf_address_lookup(addr, symbolsize, offset, namebuf);

}

As a result bpf_address_lookup() won't have any caller.
And __bpf_address_lookup() would have two callers.

It would make sense to remove bpf_address_lookup() and
rename __bpf_address_lookup() to bpf_address_lookup().

How does that sound?
Would you prefer to do this in one patch or in two steps, please?

Best Regards,
Petr

