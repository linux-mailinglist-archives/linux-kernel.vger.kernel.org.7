Return-Path: <linux-kernel+bounces-741012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D832AB0DEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF18D3A42FB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652B32EA721;
	Tue, 22 Jul 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="axhpDc8X"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0DA2EA156
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194683; cv=none; b=cAS5SU7yOfkxMhlUodeJBjbg3U4R3cC7fs6Uk0aKEqt5cq8xWeFKZk+UQc0bdTLVRTa2o09tOPQS93WLRgmYaNj9cZyHRU4i1oJmxpl0ECioeZWRpidUtWwJ7l5QfWpenpoV/5M1TwAUGmlgGhpBrRldcAe0D+yE5960h7OFK+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194683; c=relaxed/simple;
	bh=UZ+zBV2JeyxDYayE20yxFBEI2cnrLC+AvEyRTZiqdzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlsP1yGbQHT5GLC9jmkeH9gPZsdO1u+Z92NmxO0L+UyD+LW2+1Lw2oBzjYL4ZBGRkLk621ZxnbYhw8Dp/DdCoOrBxLVFZzT+Bs1pLqj21v36uIOjkF57yb9vwOFGxD7969PMgqGRVGyPPEcB3J1NqYhMQNBfiGYJFaat4qfq9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=axhpDc8X; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5551a770828so6117818e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753194680; x=1753799480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BV1WGtpxAkHZqPn5ByrKWI6F5o4/gV/EdT2Vc2w+8Qw=;
        b=axhpDc8X4VmYOSSWitSMM0Rl9MmZd4ePLcjYSHXHSVXY5VSYxz0Q7DChhnV3VDnOBl
         s/Q/VKVXOzLximZuY46EiBoKrHMemquRfjRjBNA8VusBMg2b57FQ3hqFPh1u+f+OIYzQ
         K9ImZF+KHlt0pBHODImaqSjkI0WYRTT0+Jf0fn9B2uXKmRH2pkuDWFCDYBlikhsddDvc
         rmTqG2OqZVXCY9GlHiMMa0UHNMwCKVMDsAg4IZekw+qyy7ERrIQvLVHC9p3Fi1T8wPgX
         C59zelaKyYBZ6AI4L10AbUqCJKusaJ7+W+NqCkDp9jxWVY1LYZWXjk1ycROs2c4PZ36Z
         hAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194680; x=1753799480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BV1WGtpxAkHZqPn5ByrKWI6F5o4/gV/EdT2Vc2w+8Qw=;
        b=WRrzoMDfL6g9sCABcYOuX/ecJ7n3h3WyczJB5cC3uFJjyax/1uqWE04Byr0ax3mWhZ
         Bsvo+Yd8sq5RRUkCRq6ccu6NfvIA32abd/Car+nHmnGOzqVgaeDp0fRAgNqAxH9+Iotz
         X44J0MZJ/HNtxj1cA/sv9e5Esqwp2ln29lLk3kvqP0DkZa7ythAgCZ+4wRHZqJA6OLNs
         +8sJ2UVngMDH/39FWaMS6YuBaF8LwDD5w80xwe0RzOnoPu7DA3GwpayWaIDPFtjcBTPE
         acali2KhkwwRvJYoJ6FbL8G98iAVWLOJgFc6gow5urd/HfXTbSKmMNOdVzt0YVDyoMOO
         P43g==
X-Forwarded-Encrypted: i=1; AJvYcCUHJAGqIsX99m6VAz9kbAR1yvmhEQ8v46M+E77iywl+xrESk0PBxMABPBKLXK1YZyOQXQ0sTfaPefmxsQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfPLe7Otyqfvhf5JSiHxEAqnl1sLDii0FJLeIhpe71FwMXs36H
	uDZPGtleoEDX2QuOw3aJ0UkpTyNGqvyR3LgzoGFKxxBfJjDw7EhRvVqPZZl05C4urCqW6RAD9s8
	BcjcjcqPYiz3lJSw89zLVN8UXBhBeNrNm8rBopCTBhQ==
X-Gm-Gg: ASbGncsEApJP8jmhB7fpBjeqVCaCCYLvKrQYgkSLhkKkixJYHjGJV2IzuDGP7JU0Xaw
	/62c9RUtfzjLCW32lB3I3ijqiYbp4KeXLLJ6oPPdDdX3WU0AZsKGzcMESq9IgYdIJcJT14x/MMt
	OD8+grODNS5GpPHw/bchXnqXYVQvhOfsPoD/oHAYqD9W7bsDTKlweXdf9YEn03UyHnX0TqeOfSr
	N3nrN+FmXEj40Q9IrZGtBahVK1iUIFayV61LoKuZcfYgHBm
X-Google-Smtp-Source: AGHT+IFEqOvUZdS0xFaiTKwfEoQAuQOvPLkieUBzBnWGqxyef23UMwYYSmoW4V1YF8P8O4BYxzngOKTcYEWjVpbw5cE=
X-Received: by 2002:a05:6512:1323:b0:553:ceed:c859 with SMTP id
 2adb3069b0e04-55a2331da49mr6069204e87.21.1753194679879; Tue, 22 Jul 2025
 07:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721233146.962225-1-s-ramamoorthy@ti.com> <CAMRc=McTJnTn1sf6Kc42yePvUyP87h1utJ7B_ynWjUxxm0E4Lw@mail.gmail.com>
 <CADL8D3YaF4zt2Wu0Vv1=8W9e9n5BKM+2npgfVmLhJ=wz-jHMKQ@mail.gmail.com>
In-Reply-To: <CADL8D3YaF4zt2Wu0Vv1=8W9e9n5BKM+2npgfVmLhJ=wz-jHMKQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 22 Jul 2025 16:31:08 +0200
X-Gm-Features: Ac12FXy7NJ_nraRS25UNlwGulNE3E8mn28sh-4PSfu7qcum-O7yR_ClX6M5nv2I
Message-ID: <CAMRc=Me7ade2aSJhn4tEAdNUvB3Y5TRLp8j8w8zgP5J3C6_MkQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Add TI TPS65214 PMIC GPIO Support
To: Jon Cormier <jcormier@criticallink.com>
Cc: Shree Ramamoorthy <s-ramamoorthy@ti.com>, aaro.koskinen@iki.fi, andreas@kemnade.info, 
	khilman@baylibre.com, rogerq@kernel.org, tony@atomide.com, 
	linus.walleij@linaro.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, m-leonard@ti.com, 
	praneeth@ti.com, christophe.jaillet@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 4:16=E2=80=AFPM Jon Cormier <jcormier@criticallink.=
com> wrote:
> >
> > This doesn't apply on top of my gpio/for-next branch. Do you think you
> > can quickly submit another iteration rebased on top of it?
> Maybe this is a basic question but is there a rule of thumb for where
> to base patches to be submitted to the mailing lists?  I've generally
> been basing them off the latest tag in linux-stable/master.  I suppose
> this might be one of those it depends on the subsystem things?
> >

I feed my tree into linux next, so generally using linux-next/master
would be your best bet. The rule of thumb typically is checking the
subsystem's git tree in MAINTAINERS and using whatever branch goes
into the next release.

Bartosz

