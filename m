Return-Path: <linux-kernel+bounces-764955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D35B2296B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFFC15A05B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F78A28469B;
	Tue, 12 Aug 2025 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eGAQjq9I"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF941B040D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006173; cv=none; b=UdmiQ7oouHybVj8AcTNPEqlUMTVmCWfTBUYYR0ZcjhboVd3wXcQlb3k89EcEk751BMkaZHXxGmwP2juDx7WKb7k1XPpErD4YPtQwWt6m+3k1rdoa4Nzbf9ek7q13Fg/+tWFZmbmIRFHFWudpSkyX3ES3h6DUXQ8ujP064i80C5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006173; c=relaxed/simple;
	bh=WkpTqop/p/VXbD3Mpouw39PkBycZix50Z8dm6sU9O/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+YVngSZYhKo4MEuKbkjszPhbco9E7UoygcSKOuk6aYRyIExWXPgjWd6Xmin4mxaRm6InyESSKIUvF9M+74PlNTpoQQOqdEES7TJANREUU7wEls1OTHGh0utAQCroukpQ/e/b58o47xthH8AAzRwZ3HeYNqAq07/S6QS4i8D1qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eGAQjq9I; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55b8248e77bso5462142e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755006170; x=1755610970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4g0CjNts11+3oHCNDZ5gJDPRrk4gclKzgBm7miqOkM=;
        b=eGAQjq9IpL/gTUg3TWy67rbCDD3buTRrsMR28J+dmE4fCg9jNCtr87utJ7ETkXfSAS
         Yl4076ccSYY0CpyMz7paNR5aeIRKXFSYtz6F3KuykrPMhEh84V69fPkPPTh0PtdeLOcA
         JD/zRp7fqycyCbEA4sO1xJfRFu7tsnHepG7vuvWZJf58GXk+PEguAw1TvrRQ1AfomNqy
         7c5hS67XfMDnAZMSdpVk3ysOMWpyBWaXmKrBSKJ8HhpBtDhWsZJaVRHUdFjmkZi/ayOI
         BwFevQaiXLhhZrepFPwWBG33GzQoi+o/fzRxi9AClBxNBoERUnm3s9rJkPmfRVjSBvP2
         j92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006170; x=1755610970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4g0CjNts11+3oHCNDZ5gJDPRrk4gclKzgBm7miqOkM=;
        b=gLiBO5fbXX2HUxkdOa/cp/U9/2oKrcgt+jsR3HmilmMYHfbW4sAmA3IV5DugR0QAyV
         fMlAxh79Bp/EOK+KyaEu4GEOFHclsg2fgGdaCR/cePMU+0thdnR7I3KMopz6h1vFA48b
         JBOwpCTi3tE1AGP6qUh0ZxBmBXYjTbfBAYXLftOUVkbISt9RjFsRY1/USAqy67IQYIs6
         uCJvfgHGXvTiAXlEzlnV6ajW5ZgNUq5NFN/gGEM+OFNPet+Muikw6pAWYKoCYSBOI+J/
         EluvX+9eqUCvURKL2ChiDvFrQSfphc+BmIyMmebnwGwN8SMh94C3Zwm6UEZLZbUTrj8F
         aosw==
X-Forwarded-Encrypted: i=1; AJvYcCXbl6cpvmqSQBknCqyFGpACQjGPPI25GDnJzVbsNtKLDNwJ0fi+LzqM0wU+UoTkuI1bXx1I3eyLUikdRH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsrLJeBou4q00/NPYA9QhwxpbMOJ55muQCAlV61pcx5hoG+jYi
	YA1bZ/6oJK1xVaMOtgXhVGoFRwRt2MiU1XVVwMhU3dDmRtUOavp4+pwoqLJjtFwSMurEHmLfdy4
	vVFYpdNW+blqMj+wDl8aGfzpzUJ3qMdnfJu3F/HdWjSLx0wCPxoeR
X-Gm-Gg: ASbGnctNFUB/NRqJtWQtMRdZFANwhU9v59niYgqVnbL0dMxStUGlba6OY7J0h4rRnxA
	z1qxVGOcIRo+ftes7V7x+q/Nf837j3RN78xiD9/wad5rHPEyKA9u74EobA7lE60f22yW/ysIHbU
	DDdVH3ZqjSjgLZhHXlvmD9ajVMikpW+cT+ALyni7Ta8oZAqxZp3q1wjNhByiIPdS81yWz7bDRNu
	3fuI7LH0dajkGBfx422UWLZLGoFfQqhkyxM
X-Google-Smtp-Source: AGHT+IGT7C6SpEMV2b6ciCNBkYT3ULmCzFc5kB/Au9Kxn/MeeusTVlqfq7XNooEYzUyJ6v739uDuC8+2x4p+q07BWkE=
X-Received: by 2002:a05:6512:31c3:b0:55b:7fd2:25f0 with SMTP id
 2adb3069b0e04-55cd763b33cmr1197242e87.31.1755006170093; Tue, 12 Aug 2025
 06:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754928650.git.davthompson@nvidia.com> <ce70b98a201ce82b9df9aa80ac7a5eeaa2268e52.1754928650.git.davthompson@nvidia.com>
 <aJpT_nS5bDNRVn9a@smile.fi.intel.com>
In-Reply-To: <aJpT_nS5bDNRVn9a@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 15:42:38 +0200
X-Gm-Features: Ac12FXym4hP-E2PFWmiXeVjXY0EWjQJ327lO786BIbiVQWIwmxf2XAqohuOfWrY
Message-ID: <CAMRc=MftLCu6bedHkV=K9j-VgB=myWH_Lp_=vUprqUMC3RmpnQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: mlxbf3: use platform_get_irq_optional()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Thompson <davthompson@nvidia.com>, linus.walleij@linaro.org, 
	mika.westerberg@linux.intel.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 10:35=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 11, 2025 at 01:50:45PM -0400, David Thompson wrote:
> > The gpio-mlxbf3 driver interfaces with two GPIO controllers,
> > device instance 0 and 1. There is a single IRQ resource shared
> > between the two controllers, and it is found in the ACPI table for
> > device instance 0. The driver should not use platform_get_irq(),
> > otherwise this error is logged when probing instance 1:
> >     mlxbf3_gpio MLNXBF33:01: error -ENXIO: IRQ index 0 not found
>
> Missed Cc to stable@.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

I added it when applying.

Bart

