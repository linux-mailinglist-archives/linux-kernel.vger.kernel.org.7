Return-Path: <linux-kernel+bounces-794595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F711B3E3AA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB8316714B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760E73277BB;
	Mon,  1 Sep 2025 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o3ABb0gM"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D8D30F952
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730821; cv=none; b=NkYBbJCiRz03K5AToacZQom7/022XjKtP8u5q6/1Alp1nmzs3MG7wHp7nXZ+aVY49GAaE6AgZkkYjHZmARlETfw4cRutruIOw0vvB302AgEGrFeVhDhN6XasTbZ1tBO9y2rpP9uczlxGC95zLFW72UMfmprLOPTx1Ppp9vsOWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730821; c=relaxed/simple;
	bh=wvRHqi3dScj15IsjLi+ATrCVMUE7d9PpbVx2eGPnx4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpXUJycJDM+yK/pgYq/fk5w9h/zUwouK7kSQTTSoU+Emh+ewL7wokU0wgYil9iK7a3qlxocA1yJ9mrys8udcjEAJIwGgWE0AAQ9nbCK5BbuxXLemAOxFJeN673T7ujKgSVvSUvJg2mavIXXJ2dzLPi+3WNcuWHYHSLid6sGxCZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o3ABb0gM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7720f23123dso4011745b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756730819; x=1757335619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7y07yor/pAlX2cJEQqvfRVMWVvqV9hnsGNfw0TS32c=;
        b=o3ABb0gMorxpktNDLmFcNgXrqiViu8hI6Vrks+rXrRkdGfAjTgAyFYlrHIbzn7A6+h
         mayazLpXjjFp+dbZ23k+UwtBHt06A8Hvo1bEKjXAGEb5ICOjo1I5hcwupuXZVJK18zz/
         tyewI5Ld+RQCmD4y6pOyXyYWraYhGUTyo4dDrF7bMguhOkKEmRnxqeythECZMhmK7Un6
         YAnfCHiggvKD4PxKG1Qg9QO/38d+FYAb+BDAMXQE8kDS0DGwtXhUj2h7n4w41QKexpTy
         5Mbjj4ZAZQHACdTdHwGLrtOAjwLrBd4fb9aXRIOI9zfqwnvBidxhpNUzYC95MuKWvmSa
         1xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756730819; x=1757335619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7y07yor/pAlX2cJEQqvfRVMWVvqV9hnsGNfw0TS32c=;
        b=NXkOfseFxgPg+D69dOaO5BRo+NN8jpVqeq6CzV00WdiGmJ6uOkEp2GsMN+gh9pNsv3
         dsk6oLUGCXuyOMqejD5iZgQh+y5Udew1u86toUWTIaoemgpDfBjrO27BxVpNyAKiHLYu
         mc6D4P6H8sY5+c8TmK2oy0MxFi0UfthIEN4XjUMhye4HyKXAbcqCqLK6kAX8r0SR7AtU
         NPjuLdedYKNmFM8kdoeqOszT+uIwFwjCihk3M/hBuhKUbPArORP1yS2oKrmpn6Jizm4S
         XRsyoU8CgLhoMPUNfKT8Q6v33wrZ1TKEOMue1nlF551fFGy2GiAPIFazbrYFFOz2c6vg
         KVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUckjC6M57J0WI633DvlASAT2300YCKae4rSKr2Kq5YkdVI78Ppn+NV0iL7OrqBb0D++ZXlBr1k5A+f+uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfLnqmYt7nsY13IfF1dm6CJ9/ooo5DP7Tsb12igBsTAXzb9GNg
	7PnBxPqUB6hSor+b6NLtgby0pgQHbiQ3TDIJpZAB4Lt3I5TJQBmeAf/JdN29/cegyhogOtWng/K
	V7yNrIV3O7nSdZ9pyONwBIImGaZhnr37hR6kpiwdd
X-Gm-Gg: ASbGncvZDEr073PsBMWCkFHxQeLKHqsYtZinQcu3YBGCfJx2QQkJFvdaeOV5NfRAzXu
	cE/RSS2fFN9lx3/twdq3BlgVubL5xRFpDhLF6vyuGEqkRW4tpt+ueOd40H2rmbfO2O0GR6MkuVk
	jWjNrrAT3uWTpcoCPsL236wA9KIQyVuXZB20UCZoVMRQsCpwnMXxavl1oW4zIrjZ76xhbEc3ty9
	fKjtRYsCJRNMuyLPdoeK5z7JPkHAj+DnlqY1CXew5dS+ZW+hkc5mQ==
X-Google-Smtp-Source: AGHT+IHzcBc4YYJpeDDugGdalUGLmOoVhyxPLPgnjb0HlKXSlALfB0fjTWzTMuWcnleuXqTacq9sgKTJ1OxjVOmND00=
X-Received: by 2002:a17:903:4b0d:b0:24a:aedb:1915 with SMTP id
 d9443c01a7336-24aaedb1b81mr55675215ad.9.1756730819298; Mon, 01 Sep 2025
 05:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901091050.1935505-1-abarnas@google.com> <20250901091050.1935505-3-abarnas@google.com>
 <aLWQSAX1ZKg6IiTb@smile.fi.intel.com>
In-Reply-To: <aLWQSAX1ZKg6IiTb@smile.fi.intel.com>
From: =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>
Date: Mon, 1 Sep 2025 14:46:47 +0200
X-Gm-Features: Ac12FXyc3n7Z0qCXdSTjDfMBIr2AbkPj7jLdgKKqBvKbDUlmPSbbyJWBW9Lvlfk
Message-ID: <CAATBrPHpLnsWb-Ua0z2Nmv7To_yXeosoV8+nGzcWfGUVPFq1Xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging:media: atomisp: Whitespaces cleanup in vmem.c
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 2:23=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Sep 01, 2025 at 09:10:50AM +0000, Adrian Barna=C5=9B wrote:
> > Whitespaces cleanup to conform with kernel style and improve readabilit=
y.
>
> Strange...

You mean the commit description? Should I reword it?

> >  /* subword bits move like this:         MSB[____xxxx____]LSB -> MSB[00=
000000xxxx]LSB */
> > -static inline unsigned long long
> > -subword(unsigned long long w, unsigned int start, unsigned int end)
> > +static inline unsigned long long subword(unsigned long long w, unsigne=
d int start,
> > +                                      unsigned int end)
> >  {
> >       return (w & (((1ULL << (end - 1)) - 1) << 1 | 1)) >> start;
> >  }
> >
> >  /* inverse subword bits move like this: MSB[xxxx____xxxx]LSB -> MSB[xx=
xx0000xxxx]LSB */
> > -static inline unsigned long long
> > -inv_subword(unsigned long long w, unsigned int start, unsigned int end=
)
> > +static inline unsigned long long inv_subword(unsigned long long w, uns=
igned int start,
> > +                                          unsigned int end)
> >  {
> >       return w & (~(((1ULL << (end - 1)) - 1) << 1 | 1) | ((1ULL << sta=
rt) - 1));
> >  }
>
> These two were just "fixed according to the kernel coding style" and here
> again. This is odd.
>
> Note, the style after the first patch is okay. I dunno what's wrong with =
it.

Those were not violate the kernel code style indeed, but it looks more
consistent this way for me.
Should I revert those?

> ...
>
> > -void isp_vmem_load(
> > -    const isp_ID_t           ID,
> > -    const t_vmem_elem        *from,
> > -    t_vmem_elem              *to,
> > -    unsigned int elems) /* In t_vmem_elem */
> > +void isp_vmem_load(const isp_ID_t ID, const t_vmem_elem *from, t_vmem_=
elem *to,
> > +                unsigned int elems) /* In t_vmem_elem */
>
> Please, (re)move trailing comments somewhere else.

Those comments are also in header so in my opinion we could get rid of
them here.

Thank you for a review
Adrian Barna=C5=9B

