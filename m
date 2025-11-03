Return-Path: <linux-kernel+bounces-883691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7F1C2E1AD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0345D34C194
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE672C21DF;
	Mon,  3 Nov 2025 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2c+YpwCo"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76434D3A5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204300; cv=none; b=g+ITfTkfZCYpacZTJQ9748puyxYB9v3vKDAzKNLLwEpuVqsFqRRgceUcYxB5QY5go4R4POJiKKd1+/e2G/W6O61/dnF/NiaUq6hmAt5UkXLTPlmBYF+whk4XbF1B8kKgWxCrLSLZoLi/S8faCq1QIAWL7CER12fRRPe/qkY9mLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204300; c=relaxed/simple;
	bh=JfPvdsJ+CMycz4BOZgNHtspwbF/Z4QADgL7w0TVmfKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXBCvpwV5pKIEF+LzqTcNUwEIp4XJEcQj7tUWTnzSqgwqDbtVd6etfSL99xH4QoQh9Ogjxq9U2Sh5IXDut6lSX1RfEJ3cxCbGEFymFHwVIYqCW0BuJFu4jb9XyeaLiULLo7zzPA7B2BfaL3KbeHK21MOate3R+R7lAsQOmAX8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2c+YpwCo; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ea12242d2eso21401cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762204298; x=1762809098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kX9Uoa8XM0CmqdrVJteuqhhENpUkePOkAMCphCLteWk=;
        b=2c+YpwCoKXuQVmtb73BodvMqdiuuLWPrq6BpnoOh1tL11m4su2+clRY6NpHX7FxyP+
         6xEnWmTn+3c2oepVdQ2Qi5ZpiaH3kk34ih1xdftnqVKVIw3M2ENrjtR0o2JAHtevX2xZ
         sG395T3lsa8o9qtdmmei8lKWdSSBmbf+MZwKpGYFaBRlnYcmLPXlFOlyvjBzDI+E7Ldk
         h54OTjdwM0QUD3AAJnHxh2xwJ7mljLL7qW/WLfiXEZswyGWm0TztYvgereMygeUM9GZ3
         CdWXENtZ5m7TeWoA7eTE3wuagg9yU3DFD2os08BVqkoZYfeEhQ4jxwT7PcQ9b7LbkvJR
         s7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762204298; x=1762809098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kX9Uoa8XM0CmqdrVJteuqhhENpUkePOkAMCphCLteWk=;
        b=ZEuKlYBaxAl/VbRzqLN4vubixm+GAuD6uIxLoGTVXAHOTCY/WH1e5kqXDHRPO1pmyD
         852FUIRBMT4Pcbq3ssVlB4xSqeM6jHdZgyUVFs35XmWcqjf98ZYiAbaC/IiK+xANXa+H
         er62+0LuSJxIX834d6wrYMuA2YoPSzff+7RMHbmYeRJ0pBBhu0BEuTGtXFuIkTmfugLR
         nYWckLb3eDdOqWfBece62J4NGKXPu7EcyVXXOi/Qt7p6WZF43fZEmoJUVh3+q2DBtjU7
         estNQMmcE8biHyiCMkLJPvTrUyVvvizN+6AFY+RhiEGM27WT1TBpCfTF06Wst7DN1mqi
         sLjg==
X-Forwarded-Encrypted: i=1; AJvYcCWljQasTQ9bxMysKF6gey4tjkA0PeNYK5nQ73Q9qZ6U/7z6HmKrw0PmGt72J+hOsRpAbg45EbT43pziDeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+29UKfkKb1EexvhQtsUb97gE+ghbpO4A95dWvwgJ8GKCaIxV
	vFUYA7sNhTWSCxSZjfn1NMJCn/xhFMkf8EVXurw2JLwpGpooqiYORXE1wK3OPImPmNlOdpTnYAg
	gCp9q9Fef7tRneKhccVp6nEWMFKjpLTsFE8sut0rj
X-Gm-Gg: ASbGncuQr8PUhLsjZgQo0oMHJ6FtDCexrSlqCDGsolpZ08XvOY3jOazEjPHh6mnuksf
	7YVbT8XsxMxfK+xsv+R8Rv/virGu5aXoiYYwa1bJWijRsqNt6CK+8NVA7PRuCxxCUX+wEt1r93i
	+bPcMV93LusNUAr+o/FIstTVt60zYcJBXAFYgY1fK2Q+j7mSSr4gtDvfXC2nvnixP6P+3huO3R4
	lMGG6hDpBOZPv+4IhkHoCqoJGT5IX6yJMI5Z3+5vze+XR2wFaeo9a7D9AFg41nAgBi42TUxVw6U
	54dHMO5Vc4gnk26/R0yrwf7E8A==
X-Google-Smtp-Source: AGHT+IGcU2hfnfc5G3oebYujiehWR18T1HsnLLCKyWRRBuN2nfdGoWGf+dsbWzqPXpzsYkmDxeiW5JLnTwIXmAfYWdI=
X-Received: by 2002:ac8:594b:0:b0:4ed:18ef:4060 with SMTP id
 d75a77b69052e-4ed61c2b01dmr1764611cf.8.1762204297792; Mon, 03 Nov 2025
 13:11:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103185154.1933872-1-xur@google.com> <20251103210153.GJ3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20251103210153.GJ3245006@noisy.programming.kicks-ass.net>
From: Rong Xu <xur@google.com>
Date: Mon, 3 Nov 2025 13:11:25 -0800
X-Gm-Features: AWmQ_bnOsJAJHpCCclB45_nJj9amzWG5ZtSz2DCH56bfSY5N7-h49RspgCHDdWg
Message-ID: <CAF1bQ=S70mgCx8FKKePv1Lgp5UhJzn=Y9pPWjvjbWzzsjDKMmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] objtool: fix the check for dead_end function with
 multiple sibliing calls
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org, 
	Sriraman Tallam <tmsriram@google.com>, Han Shen <shenhan@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

While investigating a fix for the split function, I noticed this issue
in the code.
I'm not sure if we have multiple sibling calls in the current kernel
source. But I think
we should fix it.

The split function issue did affect us in the production.

Thanks,

-Rong

On Mon, Nov 3, 2025 at 1:01=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Nov 03, 2025 at 06:51:53PM +0000, xur@google.com wrote:
> > From: Rong Xu <xur@google.com>
> >
> > If a function has multiple sibling calls, the dead_end check should
> > only return true if all sibling call targets are also dead_end
> > functions.
>
> Cute, however did you find this?
>
> > Signed-off-by: Rong Xu <xur@google.com>
> > Reviewed-by: Sriraman Tallam <tmsriram@google.com>
> > Reviewed-by: Han Shen <shenhan@google.com>
> > Reviewed-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> > ---
> >  tools/objtool/check.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 9004fbc067693..c2ee3c3a84a62 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -314,7 +314,13 @@ static bool __dead_end_function(struct objtool_fil=
e *file, struct symbol *func,
> >                               return false;
> >                       }
> >
> > -                     return __dead_end_function(file, insn_func(dest),=
 recursion+1);
> > +                     /*
> > +                      * A function can have multiple sibling calls. Al=
l of
> > +                      * them need to be dead ends for the function to =
be a
> > +                      * dead end too.
> > +                      */
> > +                     if (!__dead_end_function(file, insn_func(dest), r=
ecursion+1))
> > +                             return false;
> >               }
> >       }
> >
> >
> > base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
> > --
> > 2.51.2.997.g839fc31de9-goog
> >

