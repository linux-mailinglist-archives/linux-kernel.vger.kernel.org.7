Return-Path: <linux-kernel+bounces-826720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D55B8F2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB1216735A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA442DA755;
	Mon, 22 Sep 2025 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwXkXpwN"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDEF3208
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523348; cv=none; b=AYIxt0T26TEbkhN4k3JShQcXjpGLZQpziykNnrJxPjwVcz3plO72GRQ1lpsC0SQuYL0AIIVl4IInSrlmLKcWPbwaP7tk935XJ0VsR8zYFqbWdesCA0VtYczD5Hmurj4urvyQ1HFPajqr/aVGRzbZiZM5sSscLaGbFqy9ZpXI57Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523348; c=relaxed/simple;
	bh=6smKOVXzK4TtOACukffUuOtD2ISMvekgmozYkJoZ6Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1cD7i9H0EFIcJyG6SMrOaW/0z7UtWfd4gWoHJ9sw+ktDry9qCB78W1d3pH60gREr6pXNnxrbWzjQVi5L53p4NwaAj3HWAWAZJc6NIv7ZIrqt5Siagv4T78O/FdeZ8QgUdHkzMLuuX4mFhhVwgvGlSszJLQ3PYjulh0FJoPIyb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwXkXpwN; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36a448c8aa2so6423961fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758523345; x=1759128145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6smKOVXzK4TtOACukffUuOtD2ISMvekgmozYkJoZ6Fo=;
        b=YwXkXpwNn1ceFOJHZpTsWgjOoTAtJCa7vELI67bKKPh1dfctGU2P+lo1v5BSwkvvQ0
         p0/b2BQAGiq5863CQqYrNzPracE14jsi3Dn5KsMZJ/Ww5os93XxyFXG3oiS6Fa5pLyWG
         1FMZyOBY2osQhJlIKRZ7BIs9S5OzJbU9RF55AQl+i1BQfcsFSeKh/W0ev39LEUHd4lxx
         3CM23hCZuMxP9EeW82Fp7ad0HCxJUJ6rgohmjVDt0JCkJbNyCrqieVMI66brWTfCurqJ
         /YC+/rqjo4wh0zLfgnzOtaJ2XIC0pnN+O/pvz+/4XQKKkSRniqsXPE/2VhZCuvQqft6t
         T52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758523345; x=1759128145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6smKOVXzK4TtOACukffUuOtD2ISMvekgmozYkJoZ6Fo=;
        b=SaqHx0HaYScdUWR9PYYrDzoqad4qBHZ8vFUDt3LdVV6tCew9WyKdugOTA5TVuODwz9
         /A1o3Q0uLP31iN3A3TH1BPvPEpSlSUWJ0MRFiaJSrYBDNRc+mUVW5JY2Hd1BlFZCTYCr
         PcMzPxbdgge3t41itoEIZamXkdtmOBExOUIhKgEGhte8tr4leOUQyt/FrkS7cg726AVB
         pg4WKAHDP2kdfmAo98olx2EIKERXgs3ZtoAAGEDnf8Gx52tXI0w02VJZrF4RwowUzAAB
         FFwo+kF2JA4jGEWQNxwwoDMPfUnBIwJNRwV7khDrnGAvnB1iD5+v/NEd4INRHFxgdA2Z
         YR+g==
X-Forwarded-Encrypted: i=1; AJvYcCVwlYE4r14eyLTqriOh41Ku/IcnnVjJsH9Paav1XM5z8kaK2k2wl1olBuxmFzn9lET5INgWCvkGx6gT6z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBB+n4gaSlm2eibSZG8v27bxNRewKBPtyYFjZPnDICH9tOz/4f
	uO0Y9O+7GXfnI4rQ2l5IUE8TqvUx4flK3SoOMikNe0v9xXtS5oCZSZ8oK4aCSbe1XHHxpZf47tY
	nuHoNBOAK8vG8SDsOwhlTKiUDcIheeiU=
X-Gm-Gg: ASbGncv981lEyDURT/CnLRCutOfQ3D3UEWe8U09sOFYiV9PJrWsuid5zu9zm3AOdcfk
	IevDB9yz40vkiSGHnvvMC6TE+flIchOinhS/PmIyNE1HLJGmpou1CRSy/W1FQRePOFTqP8hiyIB
	jWSssf7bhA9Pu8ABru/c0Fo9EJEZvACtNYjb3x0vmEjBHo1d+6+s5dNRsu9cnFn2dLJW0FGSMKU
	bnHJ4w=
X-Google-Smtp-Source: AGHT+IEJyATaRYNVQDMBkUluGRl8pdeW9VZthXRdIxDEQPmbKIq9RynzjSszeFrN/Ll/mI4kF3FXXvHfX91orqRNP5c=
X-Received: by 2002:a05:651c:3051:b0:361:3594:2b2c with SMTP id
 38308e7fff4ca-3641a214c62mr26907771fa.21.1758523344902; Sun, 21 Sep 2025
 23:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918190729.387117-1-akshayaj.lkd@gmail.com>
 <fe32537d44cbb187e1518740f33e3a6716dd363a.camel@gmail.com>
 <CAE3SzaReUnhWyzA8RtdizKeRU2zMsGbvQaVT-ug6v+=Pqq8WzA@mail.gmail.com>
 <CAE3SzaRsGw0coOWVmnN94E2TQJTOsoxBquYp-PSQrbSdpGGSCg@mail.gmail.com> <CAHp75Vdo2SpO_HnCDYnEkZ1LHpn4s0FTO5TjSKRNG24s-ByNDg@mail.gmail.com>
In-Reply-To: <CAHp75Vdo2SpO_HnCDYnEkZ1LHpn4s0FTO5TjSKRNG24s-ByNDg@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Mon, 22 Sep 2025 12:12:12 +0530
X-Gm-Features: AS18NWD8uuPsW3QaVzQg7NLjgx1tJM9VxuNg69Ahm84sisgdKeXzjoT24F_cl-U
Message-ID: <CAE3SzaTgA5noCL8E-9ELHpwV0gY_Fs2XKm6t5WqKrGxEXE9PPA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bma400: Refactor generic interrupt configuration
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, dan@dlrobertson.com, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 12:02=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Sep 22, 2025 at 5:59=E2=80=AFAM Akshay Jindal <akshayaj.lkd@gmail=
.com> wrote:
> >
> > Hello Reviewers,
> > Is there any feedback?
>
> No top-postings!
> No HTML!
>
> Please.
Apologies Andy, I was travelling, hence replied from my mobile.
Was not aware that plain text mode will not be obeyed.
Will make sure it does not get repeated next time.

Thanks,
Akshay.

