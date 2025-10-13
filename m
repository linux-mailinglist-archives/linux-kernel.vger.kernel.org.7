Return-Path: <linux-kernel+bounces-850244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EBEBD2562
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7C534E1FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D219B26290;
	Mon, 13 Oct 2025 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Xe7fN3zu"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A042FDC37
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348519; cv=none; b=RetehlbOiGrIdP46W+5GUa6k6IIzOjjd1L7kDCpbHx3hmnMe8rrxrviRt1KCp+XgZyA2ehAgixMKo3ChmYQxI4ngpTuUi3vd9fkMCWZBCc5yrJX4FXTvPXViDs3k4dMU/nyXwxqE9xqZ3jVfW0we9fXIXXaxVDg4Ioek5VM/O04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348519; c=relaxed/simple;
	bh=7OS6r0QXUdcNugcyHhSXlvIAJ1AcOpyHg7bGDGAZEH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuGXcdOqklOlR55F2ybRr8QkvpNh4U93jNGP9EPkCaZsd5WWEdzH3RijiM08B6TQSJACaIlH3VWx4qVy2BSsiLZis1wJRdYIFAKWqFvUJzg1LKND/uZ/4pW6rBEQMf8H4i/ManlTt6NFkPwCKLVi/mvGHQKzYtO/o4v2OyocLKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Xe7fN3zu; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57e03279bfeso4997645e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760348516; x=1760953316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kzyn5HR4B+RyFj646ROarW3G5ceUJxiCmvsRF8Iv79k=;
        b=Xe7fN3zuenFQemPe1dDbIEgxV4gatd567o8sEtWNzxmpS/WHeyhZVXnR6ML8/WPi4A
         1Nf+JYOBMJE3HzPteaLRNsiqC6yOTXEp0if6yRl9iCKLYh4JyDBrFkjyWCVcVlub0fh6
         XN8pLnTOc1QYTdpz3XVhTYoDinAO/pUoi+ED3i1qGHgVtgzUxPkaq2FdpTa+4DLmtOz5
         6YgfgH9JdG9hg3dkklLTK38wMJKjpfgEJnhR5XktB4/VqkfVs9gSCJe0gj8WLSMz4SIt
         ddbBhm7DmCt156KGorlPJ4uT7lJUaWsc+SZeZsPfl3kK3ctg4Cexrmj+KewGkZwAGmPv
         f4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348516; x=1760953316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kzyn5HR4B+RyFj646ROarW3G5ceUJxiCmvsRF8Iv79k=;
        b=Et2W/btYsNyYu4LCC9bUYGXKRYPboJ1hIbFe6RknHmyPGAAy9u0SowcmaZOhqjYXL6
         6lHkieSOiALv/a4RYav2t7bjqe6fr2c9bkLto0NnaQA7VHh4LIOJ2BHm9//7zlxCg6NE
         fMRL3EyVtNzLwiHmq8iNBJ8dpV7Op4FD2FCUrOe3b+/fxJi1KlSD3dlv3MMEO2DX6Ct1
         41/I9ZhKc4HHqyzJoS1VzGKPiFWVkhXXWzF35IizfqWp4cv0gM/+vQXskGsE/eSTiAT+
         lP2J03QE6fLWPQAgRTQ8F7ur0ENoFAmN1rHC1JJRkYRK4CQaMpEOyPavr0oIfgFnDThk
         66Qw==
X-Forwarded-Encrypted: i=1; AJvYcCV1JAco3/ECrYq48RbtL6/T3aRKy646By+JCnO6VcOoq05G7eN0W5WhJqXgRGfBvRqoEthjzyFsylD7mwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHE8fjp+Q5ZRvyFz1d0+mfH1IAwOifAYXytxcd+K/7shyZn36y
	9w1QS0+xRD0KT88oa67QBHZz5jJmVJ7a67fGrxPjUEe8ZTZmoFrKifyfNJI0bFh0PO5Tm+W17pw
	4Pk+4ZSIJxM/Fylgq2kAJF6/q5Gdqy4YSr9lf84cxlw==
X-Gm-Gg: ASbGncuvya0yS8Q/Sdec8h5iNG6u9kJGkXKHW6qK6DqeRXiaaXOy/bq/ZJWzS+e4Imp
	elTzD4nPkG6kn5qqRTHZ/CYdZSZKqH5PVmu3cG8EwTCnCRPZtL8kCC03AEq0g+KUEd6KK9X2T6D
	W7h2CoRoANq8XvcPTHtT4jaHdFO6xfbrdYRQzxnU3ch0e7NSa/7cEoFwuxUzV31wSeQW/XKP+8+
	yx60qrOIQD6Q+39bMUkGrwEGUgkBo3cjrGiSjWGjGekSNBEutKKJy2S+w==
X-Google-Smtp-Source: AGHT+IEo2A2Q2VJMSBIH17uG06uyhaJ8OWT77uhilmx6FtBE+5N5iob0Ed/oF7xMbtYrws+KR2BR//E+D1FZ0z6K/go=
X-Received: by 2002:a05:6512:224d:b0:57d:cdb4:5b94 with SMTP id
 2adb3069b0e04-5905e2024e5mr7442241e87.11.1760348515946; Mon, 13 Oct 2025
 02:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010105338.664564-1-vaibhavgupta40@gmail.com>
 <202510110924.dUQeeRV6-lkp@intel.com> <20251011122612.4fa7c97a@barney> <aOpAO7j0Uyo6FPcu@gmail.com>
In-Reply-To: <aOpAO7j0Uyo6FPcu@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 13 Oct 2025 11:41:43 +0200
X-Gm-Features: AS18NWAxbYdqmNzUcHN6qByywYTVDrUPwmo1A34-f5zcgyydo35rhG25EAcst_4
Message-ID: <CAMRc=Me2ABQUXVeHyfsDR-etyT9mdX-kqxfQDnh3msfZiS6ccQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver: gpio-bt8xx: use generic PCI PM
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: =?UTF-8?Q?Michael_B=C3=BCsch?= <mb@bues.ch>, 
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	Bjorn Helgaas <helgaas@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 1:32=E2=80=AFPM Vaibhav Gupta <vaibhavgupta40@gmail=
.com> wrote:
>
> On Sat, Oct 11, 2025 at 12:26:12PM +0200, Michael B=C3=BCsch wrote:
> > On Sat, 11 Oct 2025 09:43:54 +0800
> > kernel test robot <lkp@intel.com> wrote:
> >
> > > Hi Vaibhav,
> > >
> > > kernel test robot noticed the following build errors:
> >
> > >    drivers/gpio/gpio-bt8xx.c: In function 'bt8xxgpio_suspend':
> > > >> drivers/gpio/gpio-bt8xx.c:233:19: error: 'struct bt8xxgpio' has no=
 member named 'saved_outen'
> > >      233 |                 bg->saved_outen =3D bgread(BT848_GPIO_OUT_=
EN);
> > >          |                   ^~
> >
> >
> > It looks like the
> > #ifdef CONFIG_PM
> > must be removed from struct bt8xxgpio definition.
> >
> > --
> > Michael B=C3=BCsch
> > https://bues.ch/
>
> Hello Michael,
>
> Ah yes, this macro somehow got overlooked by me. I will send a v2.
> Thanks for the review!
>
> Regards,
> Vaibhav

While at it: the subject should be: "gpio: bt8xx: ..."

Bart

