Return-Path: <linux-kernel+bounces-749072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 001D7B149B5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184E23BA316
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFA5270EA8;
	Tue, 29 Jul 2025 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lHg4Wcyd"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651326B766
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776199; cv=none; b=iZmtUuYKLEmf3D0Gxwp5WUcv7Z0Jcehc8sxNBvlkE693bEtopgSSUBaNwx+sU04xQ/QyjPtVmBlRhipdJhSd7HyXDz/w8RWVxVTDd9DxnLJfCbyZ9yEbYJDY42WI08OzvtR2eQ2q+NU1p4cqETCW4b8d75LSsyyMe6rW0rqsNsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776199; c=relaxed/simple;
	bh=UflJNvI/cneK2LX3m1PgDlZbFunqpRrS1ehCqCFEDw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/tY4Z0NiTHnKRWfmkVTzGetwnWakYjM3yT0EVvjE3yGVYXvyNhzwPWQnEV8OiUrT3Tk7ZAw/yKkipwV+xLc5PyJreO0GoUcwCHS934VKSsgjuyUzG5JOIf5QWbfGbIdK+jfXcPWkMhLBQRkUo2kyEogSWWuISM/drW5S45J458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lHg4Wcyd; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso5317834e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753776195; x=1754380995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UflJNvI/cneK2LX3m1PgDlZbFunqpRrS1ehCqCFEDw4=;
        b=lHg4WcyduMyjgVQ75Wwb2TKuNLuAjYgZ4+19osY9bKFZEzrmKY4uIMEN3fBC07R6go
         pskGLbA/N0ne2CkWctM4JDpWYRXHpfcukZqQEhqeEsS54LkKFTuuE8R2gHQZ7dHNDIzV
         xGLXBvdxtYSSjTyADL+bLKVpv3DsON/0tKEvOi6kSLDyDLULXRAG2ooTXmm8osUX1nPP
         eQlgc/4PzsjKTztid0tyehGU1MC7XLP8r+wa855O6Q9zN8PzYCUtiWd31uem/WT820in
         0XQ3IPjOetIlqAYz57oHyNvYGPqfDU25en2sUfikIhDhSjCjIlz/r5YYwbKOrg5MtohH
         0miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753776195; x=1754380995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UflJNvI/cneK2LX3m1PgDlZbFunqpRrS1ehCqCFEDw4=;
        b=ngpumCNgpq+KKfYzS1l6Wa+Ib/tcMVnPV+nhrJexOIZcnpVSDlscmXAY10Y39HJmXw
         eo8H+tEMg21AThgiKl0R5uxs0QWKZfXzxrrU+YmQU42qb/uLXBVaezXOhoDk99CpUuOe
         Jx96zshvcFscf458RvbO/jrJ4jZToU+mNu5rYJFEZgak2klIt6vIUkrIQHFrEJ6lEeo2
         1fgYhDbp6CzDRcyuG2fI4jY6SRRpfys2QBUUJZ9SkBl4BuO6nlnn66NvZkuiPdJZYz3+
         yzYGMM2hTFOuvgvey0HYGetR5msE6nBeP24HNEu6zJBzCSxpi3lse26qrS2MQ6sI5Q+o
         lrZg==
X-Forwarded-Encrypted: i=1; AJvYcCXtfICOU3b0f6CArOKRhrQesyNfMZz4siBWk7h//oo3+bqnQHZHCvyftBQDLkcgOxcrhyl3zLWhZ5yjkMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1OAy++mISKsbAPHgphdsFssYpUERq+f+ZfN55eScEBvZ5wzAk
	jx6EAvGK5qKjKrOqxAIJ9d1DhwCPryD+mUD8G3YZaU52m0PgfvwYVY7ihmQ7Oo9hP3fFPzABF0H
	nDblDw0Mzc3mS8LWdy3cpMQ6eUfGLP53WdxcjPxqOa50qlLQGUOVb
X-Gm-Gg: ASbGncvapMT8a4oA93R7ps9rbdO8nCfcggjpykkPsDv+bGNBrLqRdDhhZQDgNUuDErg
	U/ciYrygH63e71Ok+NMTnYcqNHWAbeCWK4x7gq101QH5AkC9rRsHnd2Jfw+PgGk4qyxLQNgjuAj
	2/fBJKSlbyHzM0MQeIK+P3uEuLEnm7Psla4732R3dEWd+hyjRD8dlnhspY77Em4qaJSP3pPMzMp
	GvK90Pd9CsEMfoz19XrymjD4XII0Imokpw8S0aw1Nvrj0wYBQ==
X-Google-Smtp-Source: AGHT+IHhGTfRcwlCoTMkBpGGIbg24X8fFN+ca6FGQ7O5Z0tgMTO9PPQ8O181X8MbzMzcz0jB3+Pt3eo0mb+Vi3jG5I0=
X-Received: by 2002:a05:6512:1082:b0:553:25f4:695c with SMTP id
 2adb3069b0e04-55b5f4b9c66mr3802415e87.50.1753776194943; Tue, 29 Jul 2025
 01:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-aaeon-up-board-pinctrl-support-v8-0-3693115599fe@bootlin.com>
 <CAMRc=MfS5Em65n0fwbu8JtJsc3rTgQO5cv+PymSonJtf6_zRKQ@mail.gmail.com>
 <824ec6d1-4272-44c7-b3bb-93d716ed3d43@bootlin.com> <CAMRc=McnU6TO5p7Jwy-DOg_8-=AS7rFRfaPD0yH1SERWXM8L+A@mail.gmail.com>
 <CAMRc=MeZ4HHJGkVBysLyusW5G-rM0iSQV1qqmFJUe1rsZrN2AA@mail.gmail.com> <CACRpkdbjQSns7a9EMx_5kdJ4Y2wsnocTLNsO2es7MQ=rKCBkQw@mail.gmail.com>
In-Reply-To: <CACRpkdbjQSns7a9EMx_5kdJ4Y2wsnocTLNsO2es7MQ=rKCBkQw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 29 Jul 2025 10:03:03 +0200
X-Gm-Features: Ac12FXz22uZHpwAEpH2A-edyCZbULy4WGvtG8B3M_WQs_F93ggeN_b2SiWiW7F4
Message-ID: <CAMRc=MdWkWvwVU66daz94NB-asxBBY-1EC3BSLtPO+6dcvyCMw@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] Add pinctrl support for the AAEON UP board FPGA
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 4:17=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Wed, Jul 23, 2025 at 10:43=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> > On Tue, Jul 15, 2025 at 3:17=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
>
> > > Well, nobody responded to my last email. This is a cross-tree series
> > > so at least Linus must confirm he's ok.
> > >
> > > Bart
> >
> > Linus, I'm willing to queue at least the GPIO part for v6.17, does the
> > pinctrl part look good to you?
>
> Yes go ahead, sorry for late reply!
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I was mainly waiting for Andy's review on this, so if Andy
> is OK, I'm OK with it.
>

Ah, I already sent my big PR for this cycle. :( Let's pick it up early
after rc1 and I'll prepare for you an immutable branch.

Bartosz

