Return-Path: <linux-kernel+bounces-876076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5FFC1A93F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96165585F89
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC75F3469F5;
	Wed, 29 Oct 2025 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Yw87f4G0"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9F345CA3
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742547; cv=none; b=PzXzg2f+AdCJwQJXGPv7iWfiNcDkX6hmlf6RTyEWr5eM8bFGUs2DzMA0kR7dX2emaCvdt/2WetZfS3G+syKBnzYeh69o4BdrGh9a7F/QPyvzo937oa3sa9UlH6+GPkRlVyyzr3RJ3maFciR2igk2qo/4fMqu4180l24XXgWUHeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742547; c=relaxed/simple;
	bh=oaiGrX/ykXacoXQRvoz7NUmAFH9tG2T7WIpf9HIZMgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjfhhiOkwRM4eptry8CdK2aYvqbe8t1Z4erWtEBU06EB2UMVhWw7sNhF2hr3rBf1Y9fAg96yaMkt99WHBmdBMzW1pgnz+WbThvyEDEOwsgOQyKJh5Y/sJa9Z1HeKJw6PevoMqFmp7AwV+iIq3/Z4anjDpI7eQre+XT4Xb0P+iH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Yw87f4G0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57992ba129eso3823528e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761742542; x=1762347342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yNabgZGkHY+Qgm/MWzqFABw0v7t/r2KBAY0H1eEaJs=;
        b=Yw87f4G0Z27eqrwM5JXIVziLcECIZfoLLFzFGBoC9Qr3OGLvudXKDW4x1Jf/RbjE2W
         zUCGeuqgz/ACoBY4J1RxwIEvprs7IIyJXQoAMscWggtUDMhs9O4A7bMmqpSYAGaW9Q7V
         XqadTQ9ElNqzi+P27BbGHQnkhy8u+moJOzzmHqVYIy/h+4v1j8e0N8+WqX882vfwoz9G
         Rlfkm/RVK5RHqPHAX6HBDpi7Q65mctHA5N/Zv7L7bVeOYqzNxxwBs9/wQWnp/iwvzqYT
         m1LcguLENH5pjPIVLoAAbptdpr1/bylGB/6tzPul/UaoYgNeWszzk7Z+hEAds5pnoJ3Y
         SWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761742542; x=1762347342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yNabgZGkHY+Qgm/MWzqFABw0v7t/r2KBAY0H1eEaJs=;
        b=UmSpHBtFFxKINmwIsdV0roNpDaic+l/URUtxzqjQqwhmy3aXIwQ6l38aCUoc2d/ZcJ
         ijq8PVuzCZb6kVltyw2bBtBEqAI+b4V7ks3PQ8m3gUvgAj6act9Lz4V2YRw0emyXmmsq
         tAYvUeVNe7FbpDPyWlYVb4RVEShiPwWO8gJI5qhK4IVUgj75TfgpAMcCJ0FDI7NPnlMF
         +5Wle7Y7hChbOhFbeAVWTOjL4pqdvo9t3OE0bC0OfpF8VQSAXwMa8sBYQyUm/pdg+ySp
         ywPg/eTtx1HOZaUzLcLYJtXuPlIF1DCMxAdU//Z9vQ+gBoSz8V/iuogZbB362CyrJreV
         +mBw==
X-Forwarded-Encrypted: i=1; AJvYcCWkL6Rs+SG1Tc9UpWqjGLQbOjcb5cwBkeFejtXe5k0bGQq5Y94Avaqk02Bx/FM6Y/8RRIGI9zRDJ5CnsLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw40IQrDy+4rAhgv00wX2VzigOVFMhOFJMqZOqc1TqBuTY4T4MP
	B/1CuyMDlgsaYQRifkKJj8CIWoKT7AzzhRTggeD5V4/mTx+3h0cGO+BNqd9oDhc5Ls7lMwbJ+Km
	+pbyCplQtuRCodDTKt6Hr5v58CElVmZyvl46NaEx9WQ==
X-Gm-Gg: ASbGncsH1pTtr5yjWXFxI9MwHEN3x3DIgZh5/s7Z1GGCxuEhd8b/XwZjncEC2Uczu0Q
	iZ7m1fcqXl7H564AH7VQZ/kyHHb21a+VAWdY+sqd51n3pkhx/21GYMQm1a1p812nNihP8WG+MLf
	udPmGidQ3ztXqB08UOn3lcLDd0W9Qb8hiyleH2r3Bby/NyKINkic39KM5MZHU05lsn2JzJcqwag
	yzFkAXCWRfLgB5yWDhYJULkjCfFopK9AHZ3JLbAacIQ+3kimr3IVsV3O7dNGDE6oPOTI/PIchEO
	HXK1q2W05kKlekxL
X-Google-Smtp-Source: AGHT+IHVSlcZcRFweD/CsA6OtT1TIVhjc5sVUzGgiku4ascUdv/UmnI9MvaJYPGFR/shw1/3ylKd2GmpjO/iAE476gk=
X-Received: by 2002:a05:6512:3f09:b0:55b:8273:5190 with SMTP id
 2adb3069b0e04-59412a3db0amr1107474e87.18.1761742542582; Wed, 29 Oct 2025
 05:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-3-638a4cb33201@linaro.org> <06c7a64647ac78cfc5366a073ec12ccddda49572.camel@pengutronix.de>
In-Reply-To: <06c7a64647ac78cfc5366a073ec12ccddda49572.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:55:31 +0100
X-Gm-Features: AWmQ_bluIn90sOwg9DzJfIRKjPB4JCG8HCRF9jGS6ZP4TOd1qCJlUatPTeG_3uY
Message-ID: <CAMRc=McmA9M6gMzpJ1pgQG2+6gGQ5GgTV6mB_X95WxGCgv861w@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] software node: allow referencing firmware nodes
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:51=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix.=
de> wrote:
>
> > @@ -535,7 +535,13 @@ software_node_get_reference_args(const struct fwno=
de_handle *fwnode,
> >       ref_array =3D prop->pointer;
> >       ref =3D &ref_array[index];
> >
> > -     refnode =3D software_node_fwnode(ref->node);
> > +     if (ref->swnode)
> > +             refnode =3D software_node_fwnode(ref->swnode);
>
> software_node_fwnode(ref->swnode) never returns NULL if given a non-
> NULL parameter.
>

That's not true, it *will* return NULL if the software node in
question has not yet been registered with the fwnode framework.

Bart

