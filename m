Return-Path: <linux-kernel+bounces-779975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44E5B2FBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48327AA35C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D090A1FAC42;
	Thu, 21 Aug 2025 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="XgXgIs3r"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15C9204C36
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784877; cv=none; b=n/uCFpcX5+NcoQsZWNN8Kqnf6xFoI+i7YTlk68zWm53Pe43H/ud9lvgfgpuBy74BNZMIxOSnq6KWVb0mAvZ95uZFLVXLoVXLFT6P4vmH7uXOIFMgP/AeDBTTKArSfdg/cVsrWBQA9tF81K+wbEWYYM82i9cxkkS6fmsYFojMBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784877; c=relaxed/simple;
	bh=/uTdTO/nDUx+eAcgds196YVNmXM00r28OyJIQuGSYR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VA63PkQMnBKlvYaCl0+LAdv/zHQW72BlEQlOOedMYEUVapxpp/+No9uT/DDWNZPbFw99B9PppSCMsE8esqYFCoZl6XGrQjMe1etHdajxfIjYaix5rf2IV4T00CdnrDhVCPhPloqHOrpLtDskPDE0mOGkySXCBTJ7ayUWAbvLdMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=XgXgIs3r; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e87030df79so109853785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1755784874; x=1756389674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uTdTO/nDUx+eAcgds196YVNmXM00r28OyJIQuGSYR4=;
        b=XgXgIs3rSk7ivvqz0AUBUWQSQvlGIjosjPnHdlmp+dmsST9NiZN/x7Sa76WfQZq6qN
         UnnYoZUE6kgKoP+garm/j6OBRZZ7jNoyIPRaPZZAWiKNv1FWhmvuiBJvTAEEIFJRzG+y
         e98sXtRCIpXBLlRYvwb33x50ZdgIF8F/a/lWSP5MkFOZRD0xklua0UwJdL7xECLGG1jT
         t8Z1FYmtb9jKFW1yLzni5IaSZ96LfwlLKKA1Yz9KkITByOBgkjhkdHO43JL0MbrFfpBD
         7EAmv5X3ktPlR7UHsGjYiel8EedWJdm9Z9la7IWvZniGx+PZzFpH+q6wFWa85ax3mpU6
         7r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784874; x=1756389674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uTdTO/nDUx+eAcgds196YVNmXM00r28OyJIQuGSYR4=;
        b=Tz+gqgaHOrWOkpNkn3Xe5d5dM/lD613o0QFYQDXJPf/077VwSVEVTvg4Dm88TrWeQV
         NMFIhfS9zqJ5UIxIFbFams5dC2LJVF4WTIuyZyEkWkBpiLh0WYgBqVLyJzFLJ9MeYYLq
         ykU/MsK5UZDIs8rQ3Ss8DBKX6xXhtZMDeXxeQRlUbb315S/jsCPsa4iNimEwqec+7qtc
         e3QXOXDDjenM2qMQTPxfQnCmkPzzwho3yuPXuR+B55F8tYgO5xK2b7yV24XvW2sfX8yF
         oUbZxeHe+1pzqOsgOxUR3CNuGKe7INN5kjcptUp/d8XDWSqhMq148XKkiAdIXElCzkRZ
         CATg==
X-Forwarded-Encrypted: i=1; AJvYcCXem2hR9EatKvHK/8LHw/ohuinXrnPD15HJ3lV628JcdRTxQPr8tGvO7QHw9JmFwUMEn+VEnXwx75IOn5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4aSUcmnSbKyINKxro4w3ejYVglTZS81J1TXeU4zJyoVQR6WtV
	vVTpFB2EmUgY7o7A8TSpyuHL5EYfDH8JlPfoSeY/7VilHP9g8wrBUGMpsZ1fNFfQm+CXpRVpU6x
	nYF8xqsAimgljo9CfKfwTaM19wRbYo5/Eb4CZ/Tze
X-Gm-Gg: ASbGncsMWHp51Xzr3Cmy8b/NIN6dzISvcCuCtKuRPZbp8WjGTDdRC4cYQUoseT2gghY
	z4O2uzYAdVBmGiTpC5pVDXqd5LpvVWKiCWQan551uu1F/PJztnEeQl7rCW3G1wzO8zvr7pCRTQW
	4q0AK+Ru1/xkhm5yhhGT4fPSEzmN1OJQgNoodOtAWQy/tM6e16BdtMALnoh1AOaP1iKo+WaVjm0
	YvDeFR4Fg==
X-Google-Smtp-Source: AGHT+IFrTmd6PZscCgHOXkg/jLaGOEY9AFZjzY8D6UcfbNdWBrcE8ZI5Z+Or0cCq7HQqU9l75OgLwmXGP6qzjQ+iRcI=
X-Received: by 2002:a05:620a:1a23:b0:7e8:137d:3528 with SMTP id
 af79cd13be357-7ea08d86dffmr264808185a.8.1755784872867; Thu, 21 Aug 2025
 07:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821080723.525379-1-zhao.xichao@vivo.com> <20250821080723.525379-8-zhao.xichao@vivo.com>
 <CAKv63usy7FsiUCjrqibcr196kVGb5_FDeU__OwLWJxasb3MgZg@mail.gmail.com> <CAHp75Vd+p1kPPZyrkOsE7EUpCEjd0ii+uHR69EvGNbbDOFuA6w@mail.gmail.com>
In-Reply-To: <CAHp75Vd+p1kPPZyrkOsE7EUpCEjd0ii+uHR69EvGNbbDOFuA6w@mail.gmail.com>
From: Crt Mori <cmo@melexis.com>
Date: Thu, 21 Aug 2025 16:00:35 +0200
X-Gm-Features: Ac12FXzWKQ44hpbQEumVQBTi8x-Bmw7JFWW4iGNpkw6vhDhhAYvMf5d021Ujt-c
Message-ID: <CAKv63usB4zfOUFHy3WCdQn20egsAjrq76AkaQ2KxdAFO0UjOcw@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: temperature: mlx90635: Remove dev_err_probe() if
 error is -ENOMEM
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Xichao Zhao <zhao.xichao@vivo.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:MELEXIS MLX90635 DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, fair enough. (sorry was html message before)

Acked-by: Crt Mori<cmo@melexis.com>

On Thu, 21 Aug 2025 at 14:47, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
>
> On Thu, Aug 21, 2025 at 2:47=E2=80=AFPM Crt Mori <cmo@melexis.com> wrote:
> >
> > I am not sure I agree with this. It provides an error message with
> > reason and I understand we want as few as possible, but this would be
> > a valid remark inside the logs?
>
> How? dev_err_probe() is no-op for ENOMEM.
>
> Also there is an agreement inside the kernel community that ENOMEM
> errors need no log, as if it's the case, we have much bigger issues
> than that.
>
> > On Thu, 21 Aug 2025 at 10:08, Xichao Zhao <zhao.xichao@vivo.com> wrote:
> > >
> > > The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> > > Therefore, remove the useless call to dev_err_probe(), and just
> > > return the value instead.
>
> With all that said, the series is correct and good to go. I don't see
> obstacles otherwise.
>
> --
> With Best Regards,
> Andy Shevchenko

