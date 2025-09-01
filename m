Return-Path: <linux-kernel+bounces-794665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAC1B3E4FA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545754404C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A331DD9A;
	Mon,  1 Sep 2025 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJVrwvta"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0786329
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733252; cv=none; b=cgBQS9coxAHgEg+9v+iEKjio0vJs3Xge5Jhd3PqJmGH6Kwq2paDNpaecgmlzu0pabgx9Su1UP7zGnCjjT7w2eViBUE/2Q7G2kj05m3Rj0WbWDOaTKLKUepZkBE/f8bha1OKPMXQudLiUL8d7NqjOB5fpAN/tVFiO0TEJgRiscKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733252; c=relaxed/simple;
	bh=fNzrzBOmUfUkL+rdi+LGLcpV5MZwfFh11U0nDpLmcf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqC0MgAfybO1unQsVnmbuOVnoLQYLAreiTNzLrzZuV1nc5GU573qYkzwguFClFor6twUiW8w4lax+XlfhUx63W5WHBDAyl1FedrQlnAZE4lhAaYiKHRuHYejlz/xEZ0LkD01o3i44SoqBy0Yx8Rsftts9Piepoy1NqSSJnyM1a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MJVrwvta; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-249036375a1so29403545ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756733250; x=1757338050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jV51K7A1stp0fFZW7EXTK5PI5DR7Ti0Q40zH30E1jgU=;
        b=MJVrwvtaoNMMxm1t6q5fngNeW2ZDd5eqYQARjEncR5a0wu3rDvOcpBpvmxD4lT5SHK
         c/WpEwSfLRgnki85pQWbT6mcbWXfAoPzeDxIg4a5sENAG79TJOacIiXy97GPrYT3Eczn
         oTu09BCOaVdAstqXZvbrWIZBD4b5fotDvOJu6ypd2akBHVYeUxjLSWrtKxNRCexdkBYI
         THJ1th9vfCunKaMH3+uTG/qI2THWIQpmDVmVd6jiy5R6YwS1XkH53FxthkT2TyvKgCNX
         K2FNQ+JVRSe7vLRZSNR7jgZyaVMKghfYIofPHf9iBKPg0oJymaDKbEXQDW9fhSWbe+0r
         WyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733250; x=1757338050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jV51K7A1stp0fFZW7EXTK5PI5DR7Ti0Q40zH30E1jgU=;
        b=Gg3IjkNH6sqGzsHapGm0iPj1lO+xR6k0h70ZdV++X+Nan1Ahiog+MclVt+hIv51Ady
         9qZ+T3YJoOopnMQ2huMVmAf4MRZvNi7vVfzlnBEjizb4UgG4ePDi2LHm9ngO4Fx8xfRA
         g7QvPDqpRt2YZibgj82w19ABJLE7p6i3yw9fZRTdUunIUpnjX8jRu1RMOIp9sxu8CeHv
         2BVPDjwpu/z/C+RM+8gkIYKWjNDz5SVpxlgo6I2fbkJtYGgqWVxnvuZfWrWNnGKvl7xx
         WWnXZ3Tb2uO3xhxs6KqkeGwqmXXz5bJZ4BQMwym/0OD/pL9J6WpIMYTD8n+hM0DaoJWh
         cR9g==
X-Forwarded-Encrypted: i=1; AJvYcCXXdgTEhzwnSQLjpjVRmn6nAzszq2vEN2pkCEhNCiJeDjXvkuyLiFYyu9RNhCw8a4n5keCoBBmyLE7/H7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiesUOVtA1WQeRjGqfneAlvhttdXahUVz4DjQIzhd2HUgCcBwf
	4qP82Djt0Vh4xqZ+/PUlWOa/9TNv+19lHC/OnCsaAVbhvjrVx84/Ge+XiTx6bHIbai8sHiwATBq
	+sOGMwzbIPZVC+5BJhQZqFc8C3eUrrfvAjVe8FzzJ
X-Gm-Gg: ASbGnct//ms9rRgpkxtKHvTcIBAahUmandHqXwkjA1RfipC0s5SJF2GbClecN+ramwK
	o807uzYPdFec0FUqnFCFOqgOaMD++VP3IhmESsOU9LK2lQ2pPktL0yE0N10PqeQNSnGKTFa220B
	SIdlZ1b53W8Naj0JZciOqlmaz+JUBBSwBzkJJ6ElIbTXLudfreV4RLxBS7JukQnCqR3aGiwz/y4
	ftCgblQeBjM/AOClsH+v+8vIj6ngyOmRVFow79hmOHfj6o9xSdkwY2irNf1ABeW
X-Google-Smtp-Source: AGHT+IE69FGO0OzzXMwhaoMRS2q4IeFD8qIfXTVJo75C49xHY1FRbDwJQDcNEfx9CtcjyMh4JkjZAHZ3bTFwzj9tY+A=
X-Received: by 2002:a17:903:3c45:b0:248:f762:865b with SMTP id
 d9443c01a7336-24944b196e1mr101515255ad.28.1756733250370; Mon, 01 Sep 2025
 06:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901091050.1935505-1-abarnas@google.com> <20250901091050.1935505-2-abarnas@google.com>
 <aLWS9QsvmzZW4Bak@smile.fi.intel.com>
In-Reply-To: <aLWS9QsvmzZW4Bak@smile.fi.intel.com>
From: =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>
Date: Mon, 1 Sep 2025 15:27:19 +0200
X-Gm-Features: Ac12FXzx9PEJF0qZBZJFJPWNQrrMGW9HgVOcnLKTWsob1RafNAi2Th3uDaSy3dU
Message-ID: <CAATBrPFnSnxwzBQTOdbt0h=epXW7G5Rj8Sr_erKKzUzCH6xC5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: media: atomisp: Remove typedefs for basic
 types in vmem.c
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 2:35=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Sep 01, 2025 at 09:10:49AM +0000, Adrian Barna=C5=9B wrote:
> > Cleared typedefs hiding unsigned long long type, to align with
> > kernel coding style.
>
> ...
>
> > -static inline hive_uedge
> > -subword(hive_uedge w, unsigned int start, unsigned int end)
> > +static inline unsigned long long
> > +subword(unsigned long long w, unsigned int start, unsigned int end)
> >  {
> >       return (w & (((1ULL << (end - 1)) - 1) << 1 | 1)) >> start;
> >  }
> >
> >  /* inverse subword bits move like this: MSB[xxxx____xxxx]LSB -> MSB[xx=
xx0000xxxx]LSB */
> > -static inline hive_uedge
> > -inv_subword(hive_uedge w, unsigned int start, unsigned int end)
> > +static inline unsigned long long
> > +inv_subword(unsigned long long w, unsigned int start, unsigned int end=
)
> >  {
> >       return w & (~(((1ULL << (end - 1)) - 1) << 1 | 1) | ((1ULL << sta=
rt) - 1));
> >  }
>
> Also consider to simplify the above (in a separate change).
>
> static inline unsigned long long
> subword(unsigned long long w, unsigned int start, unsigned int end)
> {
>         return (w & GENMASK_ULL(end, 0)) >> start;
> }
>
> static inline unsigned long long
> inv_subword(unsigned long long w, unsigned int start, unsigned int end)
> {
>         return w & (~GENMASK_ULL(end, 0) | GENMASK_ULL(start, 0));
> }
>
> ...if I'm not mistaken, so double check all these.
>
> At least in my case the end =3D=3D 64 is not allowed while it seems the o=
riginal
> code allows it to be equal to the end =3D=3D 63 case. Needs testing anywa=
y...

Those functions works odd:
when (end =3D 8, start =3D 0) it affects bits 0...7

This should make the same results, will check twice if i not missed
anything and post v2:

static inline unsigned long long _subword(unsigned long long w,
unsigned int start,
unsigned int end)
{
return (w & GENMASK_ULL(end-1, 0)) >> start;
}

static inline unsigned long long _inv_subword(unsigned long long w,
unsigned int start,
unsigned int end)
{
return w & (~GENMASK_ULL(end-1, start));
}


Thank you for a review
Adrian Barna=C5=9B

