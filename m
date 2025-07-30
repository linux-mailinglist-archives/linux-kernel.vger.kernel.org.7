Return-Path: <linux-kernel+bounces-750930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065FDB162F4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034DA3BD06A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AF32DA740;
	Wed, 30 Jul 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1TlXqUzk"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EAA2D6407
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886257; cv=none; b=F5zf9hc9bPLqRnMHoKhnaNS5FYgevqf69HtB/kVjlH9qRdccKKglG11UW4BwVnwaX9rWBzWGDcfJIlXN1JtWjiCbpi80ztpviiCdlIGNxA8FncObZQ3yte2n3toicOvQooDgGxqQfvcXtAoOoGOVaULGX2GoFE2gKilVUxA1DIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886257; c=relaxed/simple;
	bh=lXJ73jdHr5s/O4AsJ9vHXZKR5cKPhac21dmjQ/GtsgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+krFS1vvUo1MIhy7rFKeNjT3hSOaBf2jQ6VM+liLGDcFlZtWcMIjnjGB1PnTkCwSo/atF6DYii9xjG+c9bIvobG4IArb4qy7N693ojF02/NGxzOUjGjolxzb3mEjYzvd3hBafL7vPLFWu/hvUsPv+8bCEgS1ZoXfxYs8bUqCDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1TlXqUzk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5550dca1241so6197775e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753886253; x=1754491053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXJ73jdHr5s/O4AsJ9vHXZKR5cKPhac21dmjQ/GtsgM=;
        b=1TlXqUzks9/AvUHlc2In5g2M7Bq3ooD3MMhfdkH3pRS/lbFQxAdvEgU57iA8eqKPa0
         qzQZQcSY6+7Mulm2NoLribjNdN3WYKamoBc3t4RGx2Mac3wtke0YA3pSEUafIWWeWHQ/
         y2f2xaQaTIvwH9uEpJuoo+NpxkQ2xrrNkQO6q1MzO9QFd3woMgnzSf0XOlbfVeYNLTRL
         HqdaUhRAFncKnupMXoxkaU0pye58LCmqHTqbwAe8NbK/YQ24DbVP5RV44pR9fxTLBv7H
         I2RYkZotZsuurDvIakEqXI0LUyyVDt8EWqGKRjAlhyFRHE18SP9zkBDTAw4/Xn4+Lbxp
         NqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753886253; x=1754491053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXJ73jdHr5s/O4AsJ9vHXZKR5cKPhac21dmjQ/GtsgM=;
        b=WVnT4hlnosJNvFWjzw1fmY13EIhTAqnc9D1Ro8dCjVBpekLjPrtzQ7pZoKZT95fD5i
         LyNGdV6HazsW90MPXeUKYTTfkkIigqQBuN9PqwrI3ARb7XPfURLltzfHmZF1N/r78wZj
         0i08fHDr0mmbR1H0DEcl0i4nDvN3hLt0vEXycahm60If4Ll4MzXEVFZVe/CH+TIlzRZR
         fVzejpL91rJjLoMJJI7cf93WwqPT+84tpUW1ZLNjUTtvb/ClEjRkerqEDj02/HO/1uvc
         0jaFcLc2KWspN22CwgZdz/juWKaw7KBzM15ZshasKzJFqOwAVuN9jmfFxXhgDmsGUULN
         C1GA==
X-Forwarded-Encrypted: i=1; AJvYcCXjmWW4dIlHPxrGccIq9QfwJUiTDaf9LIzsfrXEDwTlpxk+NK93CMmx7JQ6VYeWtiCUlmqjvIo2U5yCeFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHKWeeyGDRGUkaqgd8GszdtckfGVxKQ3lWwH7S0HN7wE8DSS8t
	fw77R9qiPuLa3o+v3AvMbYuHOkQNLXv5xgWHluTB0En5cFFUSQ8bDAKFev/7r4750yjtA4AYgEg
	aStswbOlESTgMVXFX0bKwJV0kl98/xGo2E9xTBLhhkA==
X-Gm-Gg: ASbGncujMmm69vt5DPHTgJ3ytkKhDxZwaGjSXOLKaOhpsR8+x60fMy0wiilLIhWkdY0
	RJZPMhwwNrhsxv29MzdwBbrWQLYKdPaM60FeApyTya4xoZ2BwaXozwdo8aowG6WI0wUNc0UJgHR
	+8j3mXhpSm+A25WatrTgAt20nUSOSlsj5wmfX+9zuchg9+UT7XLrGPK7mcqiQxQYOhRBIgtC5ta
	zVXMhA4tEsrC+unZ4xiweEhKa9p4icYcL35r5Q=
X-Google-Smtp-Source: AGHT+IEHQwnB79u13ccn0v4jhSNP1wNv1SCqDLPqjR5PoLcasXYprdf/GeMcKzgEB2VCqotr8ZyorITapctIMNYkHD0=
X-Received: by 2002:a05:6512:39d6:b0:553:2e3a:bae with SMTP id
 2adb3069b0e04-55b7c05f18fmr984925e87.39.1753886253374; Wed, 30 Jul 2025
 07:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723094558.5bcfca69@canb.auug.org.au> <627cbb55-2a55-4124-8f6e-7b4ba0441558@csgroup.eu>
 <6eac14b4-765b-4a29-b278-364dba47e0e9@app.fastmail.com> <0b738b01-8574-49b1-b89c-3c96e9a56b28@csgroup.eu>
In-Reply-To: <0b738b01-8574-49b1-b89c-3c96e9a56b28@csgroup.eu>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 30 Jul 2025 16:37:22 +0200
X-Gm-Features: Ac12FXyBTxA114Svy5Uj0ivWoSbrkrjvRPCa-JAMdMs5h4ChxTFMooUaMdouQsE
Message-ID: <CAMRc=Me=hNhER-EnvJarG-uig67cEPWfjuLyT1_F0WKd8jyLig@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the fsl tree
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnd Bergmann <arnd@arndb.de>, ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	linux-next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 4:23=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 30/07/2025 =C3=A0 15:55, Arnd Bergmann a =C3=A9crit :
> > On Wed, Jul 30, 2025, at 15:41, Christophe Leroy wrote:
> >>
> >> Le 23/07/2025 =C3=A0 01:45, Stephen Rothwell a =C3=A9crit :
> >>
> >> I was going to send a pull request for this fix but I see the duplicat=
e
> >> patch is already tagged in the soc tree:
> >>
> >> $ git tag --contains 12702f0c3834
> >> next-20250728
> >> next-20250730
> >> soc-drivers-6.17
> >>
> >> Shall I do anything or just ignore it and drop it from my tree ?
> >
> > Linus has already pulled the soc-drivers-6.17 tags, so I think
> > both copies of the patch ended up in mainline and there is nothing
> > left you can do to change that.
>
> The one in my tree is in Linux next, nowhere else for the time being as
> far as I know, as it was not included in the pull request I sent three
> weeks ago.
>

Arnd kindly picked it up directly into his tree when you were on
vacation in order to make sure it makes the v6.17 merge window.

Bartosz

