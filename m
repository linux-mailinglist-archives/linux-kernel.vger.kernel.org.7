Return-Path: <linux-kernel+bounces-745899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 338DAB12034
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBD61CE0F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAAE1FC7E7;
	Fri, 25 Jul 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yiLsfnqv"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5740F1E5701
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753454280; cv=none; b=qVhFEOGNxkZtCm0m6VqIU2ryyiUeh9Td+pGoV0n7ZT9gGmVOG69tMUBUdWjwluxZ/tyFtCxPslfvRXCzeQZWG3dVp7D2AfuUnNhX+gDttz0bBq1BPk4TyTDXwM8ju2FhBjg0GSKkrS4xo/LInRWX3Y3mKSav6jFjWO7voMBuDvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753454280; c=relaxed/simple;
	bh=dagE9sKoD2ehnEY5qPUFePsMYk3AT09hWoqOeJW1pJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptLnmSbaFs/BnPf+FJFcwC2NHL0+bFO638QVHDtmCBqhLyNXpot1hHTUf7TwNf4uFm2jWO8cM7I8bfafHphHo8n//YDkQXSjClFwny7xnG4lbox8pKsVXYkVROeyaghwnFLJZAqmVkyahJOD+qwFhpzk27ZPH6WfAZA15RTEs+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yiLsfnqv; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4abc0a296f5so28286741cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753454278; x=1754059078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8Br67kpHlUcVp1I+AlPTk1fWbNSy9YXckgKLzf2oqc=;
        b=yiLsfnqvlVeqJnYyvc6fMSHZCSe17w0/kKc83du0V3ersk6Nx5yW/WPVjuaR7/3fqS
         Rn3wla1cRf6LWJ2O3oTCl1NAZFhPcBRKQPORy62+F08uUZcBOqzg2alZGMswVFpUKD/Z
         X5yat6MonLYtCZ8+nNCdOlp+GsDpTU3sPhRvlrpaudCBL+tlnvift+QaeAFWGjQ+TnDu
         eoQBEgsikJLTiDhyIbK8V1l8C++YdLy9szS72f5ZX+zEkmQzMtkC/UCwpFOdgmyITNxP
         vfknKrN9CTKPLLCF7DZoCSK/56/dI/8Ai6ImKQcreVcUTxwAbKvR1nP/f1YZXckNnHJn
         FPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753454278; x=1754059078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8Br67kpHlUcVp1I+AlPTk1fWbNSy9YXckgKLzf2oqc=;
        b=cxhBE2oYF/HQvE4VH1BW/iUmciTluWTQ0B8cZpWvqfubMnC2ZaLPoqc8wpPoJ2DHXu
         ooQ6z5VHbepRLI4Q6n7McLSUr2nGMovdyq0GpdEEdwNZJDgNFzX8cqNz2HNxrH+ttUr4
         0Q9hynFhLewJgnF8H1GCnXypnT1LhLjQKSW7HQYW14Xz9p4/ipXBvmK4Zu7s7mxiOrtK
         gIVVfN7u+NrRzqZ5rTPxeXkyjNceuqRbkwSc9OKJCkQDZkB+gnQsP8Z2/AF0XGXC+p6I
         Lr817/L6UowWl4zfLezW3p2FpK4cwqXjHjMk+Cj3gw8xJXpYJWBybMi+qKZqK6CGCmMA
         7Vbg==
X-Forwarded-Encrypted: i=1; AJvYcCXI327IkEQ6Kh+7VWVy6OoMw47zMmRYcmf/zAmx/QaCfjld+wK/BzgQMh/rAb/wmBopB3eDxrfJU8Wf3L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEf9TM8Jn8drQD+OX6mMnCwtH9hxGnGuMgrHOpBCPYoDIlY/2
	v0WEOl7miJNqcuC6egYFV15e4l0JeoaSEOZRw4TWQyHuKnVOukPWzAo8BynZRrkfg59XXW10ype
	XOGgMwiPfNtXuXeKgULjMBZi4Ps4fTTqRyVSeNXAQ
X-Gm-Gg: ASbGncsrtl2+Byo9g3h6+TF+f5omRP3Fiu671qDA0narU572tPDl9CB943gxqFvQDAA
	wFEowEzlNimDDaBw6RJMYom8rjU51b/qeoBTe6mFQEbeDijnCHNzpHisaCWqoDgraNZuyGjbH96
	b6e8bhfh8kpGpyqOiV3g3U+9WoWDOGQeFWJiWK/wwtlKTp3WwegGGZ5PM5K/MmmPClY0WbpY5Tq
	mrMa19/06RvjshtXbcjNMkbxO5kk4ekf1YBiS0u74EvYXXW
X-Google-Smtp-Source: AGHT+IGCFlQa1n2hjhbJuELkAdoUF/alUJWXQcS3PKXDHSB6Ln7bQ+S7J2oKj+6hjNBKqQ3I2OLw2lnIO8zQ3zGd1oM=
X-Received: by 2002:a05:6214:1ccc:b0:705:982:3cb8 with SMTP id
 6a1803df08f44-707204b0ff6mr23039986d6.6.1753454276038; Fri, 25 Jul 2025
 07:37:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626134158.3385080-1-glider@google.com> <20250626134158.3385080-11-glider@google.com>
 <CACT4Y+YSfOE6Y9y-8mUwUOyyE-L3PUHUr6PuNX=iu-zyMyv3=A@mail.gmail.com>
In-Reply-To: <CACT4Y+YSfOE6Y9y-8mUwUOyyE-L3PUHUr6PuNX=iu-zyMyv3=A@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 25 Jul 2025 16:37:19 +0200
X-Gm-Features: Ac12FXy-DhcoJp-qiCmwab46NJ0PZ2JSKLIvCIWT-laejPsOjCULrKUtahAig3I
Message-ID: <CAG_fn=WSm=u1zOGaPydq89jSw_iiQdSTPSNsd=WbeByLfTVmtw@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] kcov: selftests: add kcov_test
To: Dmitry Vyukov <dvyukov@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 5:15=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com> w=
rote:
>
> On Thu, 26 Jun 2025 at 15:42, Alexander Potapenko <glider@google.com> wro=
te:
> >
> > Implement test fixtures for testing different combinations of coverage
> > collection modes:
> >  - unique and non-unique coverage;
> >  - collecting PCs and comparison arguments;
> >  - mapping the buffer as RO and RW.
> >
> > To build:
> >  $ make -C tools/testing/selftests/kcov kcov_test
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> >  MAINTAINERS                              |   1 +
> >  tools/testing/selftests/kcov/Makefile    |   6 +
> >  tools/testing/selftests/kcov/kcov_test.c | 364 +++++++++++++++++++++++
>
> Let's also add 'config' fragment (see e.g. ./dma/config)
> Otherwise it's impossible to run these tests in automated fashion.
Done in v3.

> > +/* Normally these defines should be provided by linux/kcov.h, but they=
 aren't there yet. */
>
> Then I think we need to do:
> #ifndef KCOV_UNIQUE_ENABLE

Good point!

