Return-Path: <linux-kernel+bounces-846580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389B5BC8675
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0353BBC14
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FFA2D7DE5;
	Thu,  9 Oct 2025 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BSWel78a"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412FE275844
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004437; cv=none; b=hG2ZLOZlFcR38bKkFaSnMFi4w1JcFglq0OYLlK+MoSIsL+SduXw0N7p48hdPW0Ooy9UyKN3QbCpGQN6ALFhTeZaY0nLuTsOwGDNVKo2foQEUZgYhtlJtDRxjKto1dMV4FdyhUYdc6+eyu7/91LiX1/LvT+zZ5NnfRD1mn8LNmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004437; c=relaxed/simple;
	bh=Z6fCQhdk3dr0h5KNJ6z6nOfj/2NAXHn2Z28Tx2ssQSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cm33g+SID/tTUMpvtym3KZifLhOi6oC4Vvyur8yU+p/PbxpNgLzgtoXhYvk8CY/MlXIrURlZBPDpLPqD/VUGMmY8+jhmMrqz6+5ZJV3ZpQM0yx9WNx+3G+xEayjCB+bq0oX/8wDwv1pH0EG7uNzfLBExpqFpzw61xHjkTFEyCHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BSWel78a; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57d5ccd73dfso831680e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760004433; x=1760609233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTdm+WQN/IArP6uzK/anYh69/F3/JcJMhmnKnGbESXs=;
        b=BSWel78aY2+7NF9UHBh+KZ2IHaDit0m57yLyD6pSgnOEwEcnESWe1u45jgVgDAmlj7
         XJrhvA0M7+ELzQZwfYk6ZzC4Z1f2AAeAzevBCTXYxqT+/AYb0v4sCW1Yw+C9HndcHUGI
         aNi1G2k9l82tG0sqrqhf5nhDmUUag3lLat4nMT41GknPfPdWIP2oBNTrCFtJzaknvsgD
         pZHQHaeJpoe8qiGGaywiBZDInA210UoR/h60Oj/aIk4vjx04pjUrGJO+BjvC0rZsaR9L
         tXWEerokmsrSbkiLd9b3uhlP/jeT1cDGQ5dskd+8QIa4DSRbLIsN5pRO+0vToiXNebtO
         p8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760004433; x=1760609233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTdm+WQN/IArP6uzK/anYh69/F3/JcJMhmnKnGbESXs=;
        b=sAYwc/wvDIiW+X7tGLcXryHKcc/3yfjM0ddqAEWSWq6RhEiiMeX4vEG5sbslqcUl1l
         F9U+XmpNjHicIXqyNcubCJeESGgBNJMEgOx6weAWSrd5zeuuP3WFXNmQOi2g2DiQVPs5
         couz1HZpAnOCirKtvf7/Cdt3qIqRrj8oHbK/VYvHWTvRC/zfjDm0H+6b4O9ks2yVqFCM
         CeHclf2hNlunFbH/WyX7rovQezfhzI1mmuDFym4FcEbIeO35RRPeaZIUrDHr5NNQF7oh
         DetgmxSLRaIT7kA1OqQ2P52jJFtzSBrXvYwcAIrhk+9ce6BDJPxoBkSOER/a3PvdTlSl
         QWfA==
X-Forwarded-Encrypted: i=1; AJvYcCV4UMZcCOI792e7/DL16Oqz6au/anCuX6/v9Wk0JRmfkMALJpnbuwmz+IUxbXzcq/N1akOaAxo+tEf2FnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYbdYguUQKI4BD4rmCkqZQLfB42LsLeqscs4oesVFY4cGlY4LY
	psP8MYXuPasol2FJvqNdgZ9Zc6NtrqFhvyV+Ebrx1vgl5A9KFkz90UaBMAYDzEUbPUzC/tsN/Yb
	7wQoJwc+NaQjjIiHz225Pun9S37t7l0mCNDC355YazQ==
X-Gm-Gg: ASbGncs2+Bu4YCE82DKQ5tweTWGPvOif/k7hetdDInSTZUGk+YOhYUH4HmG0R8tZDbF
	ESOvoajwZ/R2haGI/AWZPaLkTmdr3wr9duOMLQsJliQ7+nB8zzDa90tWtF5A+04ltoB3KfRDKqo
	lthiohrB1mNpxQguDfdd3nGVGIGVsyio7QctVZGbaSOlY7a6nfnZG0aNfaaXK7zg9AbvaFODcBr
	CBTGLjAV9a34wbyx2XD3Yth5IRfcT4CGyfqUF9lFH+r8OOEfRGI/4MZUNa/yVb/EvnqGrYp
X-Google-Smtp-Source: AGHT+IGDdNeze8LYJjC0w9X4/tmvn9bfTMHPkMojDzQaWsGrmkgUhXZlakYkQXFLaJe1+0eSO9i7NPOD2qru7Dz+8yg=
X-Received: by 2002:a05:6512:3e03:b0:55f:6c08:a15a with SMTP id
 2adb3069b0e04-5906d8efa49mr2043976e87.32.1760004433205; Thu, 09 Oct 2025
 03:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806091531.109861-1-stefano.manni@gmail.com>
 <CAMRc=MdfjuSSsD=LWDpUroyf+fxC7jQrJDtZJtmj_YiQYQjAuw@mail.gmail.com> <JZ0U3T.53FSIQ97H39F1@gmail.com>
In-Reply-To: <JZ0U3T.53FSIQ97H39F1@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 9 Oct 2025 12:06:59 +0200
X-Gm-Features: AS18NWDTzj0xfRlNNs2NBR-OnxUMd1ZPijaWjphbF82EwZLOrH-PY_ZJVlG7jvQ
Message-ID: <CAMRc=Me6cRLPsz9-DLMyFXVn8AXExWRP4fwHaN3=8HuHR6+VGg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: pisosr: read ngpios as U32
To: Stefano Manni <stefano.manni@gmail.com>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 11:28=E2=80=AFPM Stefano Manni <stefano.manni@gmail.=
com> wrote:
>
>
>
> On lun, ago 11 2025 at 09:56:51 +02:00:00, Bartosz Golaszewski
> <brgl@bgdev.pl> wrote:
> > On Wed, Aug 6, 2025 at 9:17=E2=80=AFAM Stefano Manni
> > <stefano.manni@gmail.com> wrote:
> >>
> >>  If of_property_read_u16() is used instead the value read
> >>  is always zero.
> >>
> >
> > Please state more clearly what the problem is. This sentence is quite
> > garbled,
>
>
> the value returned by of_property_read_u16() is always zero, if
> of_property_read_u32()
> is used instead , then the returned value is the right one contained in
> the dts.
>

So please put this into the commit message.

> >
> > If you're touching this, can you switch to using generic device
> > properties instead?
> >
>
> what do you mean with "generic device properties"?
>

Functions that allow to read properties through the fwnode associated
with a device bound to a driver. In this case:
device_property_read_u32().

Bart

