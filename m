Return-Path: <linux-kernel+bounces-740101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC5AB0CFEB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F058954541C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247CF27A455;
	Tue, 22 Jul 2025 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KkWe1qnR"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19DE279DBB
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753153252; cv=none; b=WFsjDRj0hjqvCk6oOq2U/HqnvKfhVEUWaVkN5xKI2iu8wYQdR1chb11Y8I5qXlVbPoIko+rarn1awLk5B+IpdfpQ/NkAg4arYFQ3Kc8qAN8xbuc9frEp2lrvkOPaeXlY1MBjmsBRxm92qWq2s+yHLrrC45ouRuXzNc/I/xsTe5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753153252; c=relaxed/simple;
	bh=DIdiNs1qAYx9lBfv3pBqEPJZZ02aItnWfSsH2MZah6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pieUhTJ3unADhUmqhTItAMVNNE/dJCyQ2bla9dmo1JMQrQDdu0qeuVDNlzt6qt+df5gPE5+m5frgrfh5NQgkj1jcrtPdGjWorvWfUVCrOAw6oGoqP2AYlJwAtA7sWwW9/Ef/0ka8ES/7zVJCHZD9w5LKGeLrLo+RojOtT4zrP8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KkWe1qnR; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-73e810dc4cdso1270236a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753153249; x=1753758049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiIyK1lXVxB+2da1SDpcrPM0fJEv+NQOIcTd+CRshKQ=;
        b=KkWe1qnRwXTP1yyY5pyX1kYw0s3Gc9K0WKcEdhzsxUVhaowkI2gbOe+/lKuItg++5D
         iyYXeu4ShFXxH8Hb2fRGfCOVzdetWoPsQbmzX+bZayQYTnQqJt7Q0RR4EPZqqiMiUWV/
         ORTo+byvRxh5zCjf8fjyLz4/oQMlP1+Rt/83EPuNol7V6Fp11vwfOXarniPxPnWJQOL5
         k7bupaugYGvBAuaSh16eY9znrOD1HGyPW8z266Yn3wEatASLtP3tSjIAVaf8LG1IGCf5
         IVnZUfc+PAtydaZaFmJSXA2lAxcY8PXUsKLh3WM1DP7Xmpq3/MDp0xwoxCwySYIt8mnP
         JCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753153249; x=1753758049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiIyK1lXVxB+2da1SDpcrPM0fJEv+NQOIcTd+CRshKQ=;
        b=qzNihevmLQ6BLjyjGrifNTQM7ENEa6bh2BoN6EdBioNDNevpuHbR+sTvAtJpF2DCB9
         +cBy888fpJFWwZZtozQWDLeFaCnAtYj/wCYNFJMkJwd2qt7wm/5eprel5JOQvCVvaNpG
         LMEho93t1al3DXsGd0y63uhQ2kMtfooxgvOcyaSRucEpBNEPKUPGoFdA47uGpztRsiUF
         gSl+7zucjLxd0vSVKWNyX1UTHRgWP5ba7lYG3nI3PL1RYLdOuwpwiI/IGjNFAy/JDakk
         KdhhTpdyr8MolmUE17awCnH+HHHJmkk21MDADD6Oz0mt7lUMOFemRCr7YUUCtOhSrf8z
         wpXg==
X-Forwarded-Encrypted: i=1; AJvYcCUdsAP3MH7cWljg0Yzo5trH1h9FEeCmTl4Grudt5dW032PMUEqwvQDHndpzfaQCWbP3OzWblmAiiJy/HbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdjFdFaoanehrszRWLIxra14VC2euUGQih7OB7PW2tDr/f8hzi
	Ta0wBVG61GstfsRFeOuyTYGoaaJxeMUDpJYWC6+79VwLAOicAIFabOiuStkikR/E+m5f4i3eexH
	/uktYehWuEkDFMgov7/sZTB14NZI2tFvF8G6hsZ3B3g==
X-Gm-Gg: ASbGnct03k8vutv89cWnRT55Kb34TYBnjodGiRHWP1++zKY0T6hBV6SgDRQp4S/Q2lT
	xzxBvlNT/xMaJX96ZlmsZOzj48Hj+w0BTdzfnb8foiVX4GXT/4mSGQtuI/l06qF4+qWlSKpmEWi
	4uHwy0lmDARtAwDjqqbAcivxGbxPEWODumOLzlMJhDqe+34pE3ajgd9d/p+D61LosJuyb0EK5JR
	H/AG7MpL3ScsC/MlVql
X-Google-Smtp-Source: AGHT+IGwnGLm4PpIYwzH75awhbsJSf+lZtNwfbv2zSoW+8E6F/LfS+KA1nTDmKZunTm81WX+23amzXEHi5dUF84vl9o=
X-Received: by 2002:a05:6808:23cb:b0:406:6e86:683e with SMTP id
 5614622812f47-41cee083b49mr14516648b6e.14.1753153248624; Mon, 21 Jul 2025
 20:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531100407.282-1-dqfext@gmail.com> <CAEEQ3wkKxt-p1339EbXt-1nF_GvMmgYMio3OBHZSNke1kJc5sQ@mail.gmail.com>
In-Reply-To: <CAEEQ3wkKxt-p1339EbXt-1nF_GvMmgYMio3OBHZSNke1kJc5sQ@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 22 Jul 2025 11:00:37 +0800
X-Gm-Features: Ac12FXzVVbpVD0I9lTj6nHEI4BHP_roN7FMin7PG7LAQW3BUKkLep4DpVIUCUxc
Message-ID: <CAEEQ3wmVPrZ6s8msM8RgcyZePGhXM1ikYMc5wW2n8q3Bf90EVw@mail.gmail.com>
Subject: Re: [External] [PATCH] RISC-V: Implement ioremap_wc/wt
To: Qingfang Deng <dqfext@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	Qingfang Deng <qingfang.deng@siflower.com.cn>, Eric Chan <ericchancf@google.com>, 
	Andrea Parri <parri.andrea@gmail.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qingfang,

On Thu, Jun 6, 2024 at 2:48=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com>=
 wrote:
>
>  Hi Qingfang,
>
>
> On Fri, May 31, 2024 at 6:04=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> =
wrote:
> >
> > From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> >
> > Currently on RISC-V, ioremap_wc/wt uses the default ioremap
> > implementation, which maps the memory as strongly-ordered non-cacheable
> > IO memory on systems with Svpbmt.
> >
> > To improve performance, map the memory as weakly-ordered non-cacheable
> > normal memory.
> >
> > Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> > ---
> >  arch/riscv/include/asm/io.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> > index 1c5c641075d2..582503e0f508 100644
> > --- a/arch/riscv/include/asm/io.h
> > +++ b/arch/riscv/include/asm/io.h
> > @@ -133,6 +133,14 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_pa=
w())
> >  #define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), buffer=
, count)
> >  #endif
> >
> > +#ifdef CONFIG_MMU
> > +#define ioremap_wc(addr, size) \
> > +       ioremap_prot((addr), (size), \
> > +                    (_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_NOCACHE)

Compared with IO attributes, NC attributes can improve performance,
specifically in these aspects: Relaxed Order, Gathering, Supports Read
Speculation, Supports Unaligned Access. Therefore, it is necessary to
implement ioremap_wc().

> > +
> > +#define ioremap_wt ioremap_wc

From the perspective of arm64, ioremap_wt should have IO attributes
rather than NC attributes, so this line should be removed.

> > +#endif
> > +
> >  #include <asm-generic/io.h>
> >
> >  #ifdef CONFIG_MMU
> > --
> > 2.34.1
> >
> >
>
> Can you provide specific test data for performance improvement?
>
> Thanks,
> Yunhui

Thanks,
Yunhui

