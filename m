Return-Path: <linux-kernel+bounces-799049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72EAB42652
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E3B97B3C96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB7F2BE7A6;
	Wed,  3 Sep 2025 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="g0GotaTv"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF832BE651
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915955; cv=none; b=Ilgkr9+mf0kHJhLA2LfATPVtEC2nARYcYj+uyuCb9Tzmj9+xDwZA2Lraw7iN3mtxqTHlSrywSqEaCo33Jf3j6qo3nBB63fufM8eXlWKVhFF3d9Oy+AnzPmhOfiujjSsPvKDNrLBPMOU9satLB8JFbldrjKkOoaWNlEQiHwYKs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915955; c=relaxed/simple;
	bh=jVYSc68dlYLIHKx6ZtZFTCSfeXf14R8XdkSzH6Aqiyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMBhqGI7UeWWUOS5MxSOPD7HWoOE9YsXEZ4VTdjLFyYlWzuCYUDK1GfqmRuYccoiWZ9KFaZGQ2I4P4tpgyrEjtASaV6j3Ai4Fn3+TiUZ6A555D0grOeY7V1/1gKLARoCp2+sKiTGBMy7sIre2huY5q+MDx/6ERXRec7eGWCIIpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=g0GotaTv; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f7b6e4145so3327911e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756915952; x=1757520752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDv0YkWfgMrbAykmYhgPc5757sIuuDQeVA6MDv7fwBM=;
        b=g0GotaTvYeDS/wUcPp+TCppD4nJrMcFXWFKkMsl/AXwlo8AjTv7WSr1kbAj6cIm8I0
         AuXn+bz9/UBFxCv+NSXKgKArQygHeJtyi+5lGTDeiGB+zYCyLNnaWi25OKf3zXMzt3fI
         a1OIPJxLfhLwXO9w5sjdCo6TQ3E9FdexCJaJ8G7rl+QBHId6kTLYDMVdZKWUiIi5STUs
         1gZ9A1CbNhksVd3xmYvwfOEIBm/xg3S9kam9sjGcpKCeAA1HiYrvBZBfeAo+ApaSIMx0
         9j+tKenTmvoJ4JMf2MXAP+YbIULvCMj167877Ochsf4+pFJDeiihsJ4L/do1tkD8DUNd
         ysbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915952; x=1757520752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDv0YkWfgMrbAykmYhgPc5757sIuuDQeVA6MDv7fwBM=;
        b=FzLY+50sb+8KuLYr/j0LRrk6wpl728ASQodsGJ1JcD1WUXg2HUFbh3UVoIz2iHm9Ha
         oPfzu93yCSFhF9x6xpS9botV/2NOrYuxCoCEnAgHJqX7Z4LP5VNXYCQvWYblmiBVMfKg
         e2468pTXtDZre6ZljfUvmhmhppWZM/O3nRSg1cmCpbInI1HFUrLOHlunXdGvJhmrBySu
         /58lUVKQd85HkhW6k6nzEiX7Wze0kzlefRtXha3Tf/fZc17tvC7whLUXlTGxuenpuXnk
         Ol44N9rBRI9JI9rONC5jChvyXgCItYsTN634olSC46BCgAHAeQI68EXssyy3FuU5EuzH
         W5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFOF58ygS3dPCwkgUK+El6nVogP87gJYWh7B52PmXwsXdtp2v569D/ZdQNU+vZm3KmLqz9bWMpL0EwTI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw43ryS3UQgcC+YPKmtb4pdEBwKUWnuQHH2px71L6bareO1CFPr
	PEFeEK7jDHgA2b/OJUWmCwSR/vOgMVfY7zKKL/VbxnBI4zEp0WCMMfnD6As2pcFheR0zNQPeLqR
	OvmwwLOzrYF8mDDh4F3CQYFeBRUP0cGtdkyGTr2+8dQ==
X-Gm-Gg: ASbGncuN7h3BonVrb5/l3sBPrkWZhnY7mlyy/bzYusPSB9gG8upbcqonuRRgmdXHce5
	3isMVdWgusry+EQ/PWijkqVesNdWVFXFJSgjHfDlGtm8WTYVAPmqoYdSSyLDd/mg1TpfQnFtJkM
	H4OgvX+3DF3Siq59jvEM+UdczGOohVc/jgK2r5HStOkUU0hsUbZmtEjAjRvE2B96hW7a4pHnVxN
	zJa5T3x3yHQ3jBTjYz+bcA3q0YaKCKHbLtCK3c=
X-Google-Smtp-Source: AGHT+IG9kbY2aWTL+bQ4CXwiiutR8P33iBoPBAGU9ej78mB+Iz64u9wBkzKBXujWDJSkJohiCiXP1iFkD6uUx+YHjIw=
X-Received: by 2002:a05:6512:4608:b0:55f:67d5:938e with SMTP id
 2adb3069b0e04-55f7094f818mr4090090e87.39.1756915951790; Wed, 03 Sep 2025
 09:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
 <20250825-gpio-mmio-gpio-conv-v1-5-356b4b1d5110@linaro.org> <aLhhpiVpGscOFydS@black.igk.intel.com>
In-Reply-To: <aLhhpiVpGscOFydS@black.igk.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Sep 2025 18:12:20 +0200
X-Gm-Features: Ac12FXyZAxIt_WffCZOnIM4e2vN_EwG-wp8GqcwHD84BnpN3MJueeTCK3eA5rqA
Message-ID: <CAMRc=Mfk9yBSkMQj_egtfNQ8=A+mvyqqy+_KM690GCV-Sts0Lg@mail.gmail.com>
Subject: Re: [PATCH RESEND 05/14] gpio: ts4800: use generic device properties
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Hoan Tran <hoan@os.amperecomputing.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Yang Shen <shenyang39@huawei.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-unisoc@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 5:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Aug 25, 2025 at 11:48:46AM +0200, Bartosz Golaszewski wrote:
> >
> > Avoid pulling in linux/of.h by using the generic device properties.
>
> ...
>
> > -     retval =3D of_property_read_u32(node, "ngpios", &ngpios);
> > +     retval =3D device_property_read_u32(dev, "ngpios", &ngpios);
> >       if (retval =3D=3D -EINVAL)
> >               ngpios =3D DEFAULT_PIN_NUMBER;
> >       else if (retval)
>
> Don't we have a method in GPIOLIB that does this (can be called explicitl=
y by the drivers)?
>

Sure but we don't have the same behavior in GPIO core, we don't know
what DEFAULT_PIN_NUMBER is. I can't test this functionally so don't
want to change semantics.

Bart

