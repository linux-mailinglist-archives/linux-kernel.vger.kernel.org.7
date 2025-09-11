Return-Path: <linux-kernel+bounces-812744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429DAB53C18
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9E93BE76E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414F2242927;
	Thu, 11 Sep 2025 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsR495xm"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A41A0BF3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617490; cv=none; b=RXJVYSqBwgIMvcNkZh7m3PXZJS8AsxtXedGDS0fXClI3v5C6Yp4L9b+mI5rXTfAJGE2KONrd+zEMOprTf+WejEnpVc3fp6YEzurGEZlgSndOyFrmJM2Hm4Ldkrtdnj9KJHqdrDthXMz/PmL8LJFoQ8G8ABKFg9iNA+luBcdAB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617490; c=relaxed/simple;
	bh=CXkH7IG5itXt2SmPip8bJaP++ykY/AEN0S8D5dtt3i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHny7TEppExo+ocAufcH/t9g5FoXu8PNWv7fcSHhhVnYNo+5/ZuZ7xVLfdcLt4D/zvdQwcLhvj1DI5MQ7mY6BbgReB8ae7gS2GARITDq2VWxgqOWgDF2uARvWtJcLUENfgDOV2Ll6ExC0sPYvM7x+dDmJ+HgnYqvaSTfCgMt4Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsR495xm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24b14d062acso1600145ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757617488; x=1758222288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXkH7IG5itXt2SmPip8bJaP++ykY/AEN0S8D5dtt3i4=;
        b=RsR495xmfdTYp3+BHA/jh+uxCl+a5wbTBnasvdT+q2uCjZcsnP4JUJ4fW0aYZO2llh
         IOPcZVsn2kuKJbjOfOqQZZhvNVupevRIlzNYfcGQ43NnuhiKZD0yr1RIgwZ8wg2F4FjD
         LyvRGI05t/o+D2oo68QSy1HMuN82hWx2f1Q1ZSyG/ehhhS1QkLQDYCHlp3YmGXxmk1V5
         Te/AnoII/V7NQC2yAds5hNq3ApJ43xjtkeIy0OLEMy8I2i9d0ubM4lIViwCvcrxATo6H
         BGTyVyiblXGwjHoZnyzbwEaUY8z8KtBwPivvs9qrAAitIWx8+BwaNNhgvs32T2TPJS6D
         P6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617488; x=1758222288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXkH7IG5itXt2SmPip8bJaP++ykY/AEN0S8D5dtt3i4=;
        b=Np4iYNbaNlfM5/rxjdW8JBp+Ky7Y9JdvTGGP+TVDU1ZiXGZ9pMln15dXBAChe7TjsP
         80cqELzkichpSsfHu6vNk2vtONyLQ9i31SKD31J5X6HUuCtflQGf5TqSb6o39KeAOWCV
         0ucbuAgVefYQ3CtqVGUYo3lMFQEs+rtlSSqLoWVwRKxEkgcQ9EyuGM5eWTbfEOGPud8Q
         rWQDkBWnmWLkVG0smTOL643qPZSow+9OBeP38Phd+LsFwHUZ3P16h9PJVpD8BTT+ZK5m
         Z8PcDuczXM5Cy20dkel8yeQ2BcAxfmyqpUwMc0WKnSQVMnHNcEPZ2ORPOLO3zB4hhP+1
         N5bw==
X-Forwarded-Encrypted: i=1; AJvYcCVhbswYTan54gJ8SPICwyl5h/HwzvGfRj0e5u/jGOzslLtl1yFpYZblQuJYfJnhbD2jF5QozWPSbfmv+tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynBi3hWa8AxJVle1xrXFRHhpfYYBaWoDyUhjB8kT9Ht9VEm4Nv
	aO0R5b48PUzjgYs6Bx3cvvCFhfERKhR3RBIrLgVaGllqI4FQuFZ3KzKE70Sxh/c1u8i4V8hw/YK
	/8KAaI/9US+htyklEe9QyYnbyzBvZ2ms=
X-Gm-Gg: ASbGnctmzG0J/VONjMhd+Shln0VAKSKr4nmprj0z9gN1TJDQ5x0mcyqZS/sP56UheBw
	DnPAuRacg0mbK5zsIOq9lvzxHOnfafukA7zTW/T1rJZ++dhErwIB4XsrneTc/wquaUlHRysM+4B
	eBtOQWrut+pFRC7vCZBE5v8gO7iZTSew25KTmTD1Z897QIhemkiEKpGJs8Q+tL2rYdIWhNjbrcM
	9GsJbLSjykBVDXFUfeSh5Ci/gSS7VffK/5D4a5lpD1xK0tlnfYafetY7rzgkIIeWHT+FJLIE7gp
	qfz/3uwaWxUIT9FmVW3cA5TySA==
X-Google-Smtp-Source: AGHT+IFtOJr7VY+2LEhl5aMk2PoyrpBKl+Pkp7GBG6r4rETx5wsdCdKzGprePS6AckZkoCNRk1yoqNC5tcIfdBwa6VA=
X-Received: by 2002:a17:902:eccb:b0:24c:b69d:5929 with SMTP id
 d9443c01a7336-25d243ec0cfmr2539275ad.2.1757617488573; Thu, 11 Sep 2025
 12:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910151216.646600-1-hca@linux.ibm.com> <20250910151216.646600-2-hca@linux.ibm.com>
 <20250911013243.GA292340@ax162> <20250911145659.8894Dea-hca@linux.ibm.com> <20250911184429.GA2395987@ax162>
In-Reply-To: <20250911184429.GA2395987@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Sep 2025 21:04:36 +0200
X-Gm-Features: AS18NWAwft7HpNthq0uaNRzFRK30ynGsG36xk3t_FH_3eH4Ssso_enqZ-_f86rA
Message-ID: <CANiq72kJ9L_Kpv9+z5=xZvbWxLRYXpKS-76XwwvQP+wMWsMJtg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Compiler Attributes: Add __assume macro
To: Nathan Chancellor <nathan@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 8:44=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> I do not think anyone really owns compiler_types.h so unless Miguel has
> any objections from the compiler attributes perspective, I think you can
> just take this via the s390 tree with the other two changes.

No objections from me, and thanks for spotting the OpenMP thing above.

I would say, though, that this is a fairly general and subtle tool to
have around, so it would be nice to have others chime in. In other
words, do we want to start using `assume`s? Should we constrain its
use a bit, e.g. say its use should really be justified etc.? (In the
Rust side, a tool like this would require a SAFETY comment on top with
a justification, which may give a developer pause).

Thanks!

Cheers,
Miguel

