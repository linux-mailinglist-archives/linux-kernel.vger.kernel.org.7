Return-Path: <linux-kernel+bounces-826154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D508CB8DABC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 14:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FDD189D07D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA02A2C11D4;
	Sun, 21 Sep 2025 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eBL0SBqG"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021E1DB15F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457301; cv=none; b=ZtdfYO6oV/rUtthZGJdzLLUHrhuo4E+nRtTwJ+6SXL0yQH/iDHSYqdq0A7/nhPfpCvihXFcqZw2V51g8oCpEwWxECfoJHgW9O26lTkOeBE9TFQCJ7eq0n5zohSPYLT7H8+1LGfx5CySSiDeRMW+3dd+xpqEl6bEH0N1P688BYeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457301; c=relaxed/simple;
	bh=AnCf4qD3OM8C7k/Xsb2THRqEyN5SjDqXe1BNpn0BrHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8t2PbMrVlwG5oDVeNkuzjwg9vuw//Ds5kE4qUJKWrU7cYMdKVaz/GfGf8S4ddqDdD872vJmhKg+IJqvw8fjkKWRJofGFQVli7h+WW99lO2URDCO9A08mzVMIqtXUfSeeD6wiEGBmc2uBcQAjP8uY9ZMASc5L71VFtJB0TP+Zn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=eBL0SBqG; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4f9d61e7deso2318230a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 05:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758457299; x=1759062099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJSacj7AG4ILM3IhKBoSOgA0n/MoBkGpNIVRvcCoIHQ=;
        b=eBL0SBqG/jsM+ilKeEYK2zZOk5BqF14Vwj7iCbUFzPhV+xd7swbcJEjWyQf3mTTQvQ
         jmjcc1SF4ttkR41IW0EdtbKmn5dkU0ddiowh5QQysfa/C/PBLNp/Pkz5EOr7j1fps2fG
         mXEfUBIaupTB6LmSfIO+Gg+XqzbynU+EXiHSEPLfkyDE24BjEtQhhC4R+paKjM4o8jwW
         RAUTio8MU6RS2RcCgbBWeGKdsbuqdwydEe0mWOsI6BJxOa1o68NIKd54UV9pJXXAHZbm
         CGInQrvzJK7uW+bcgQtTVwdIFiOynzaveFV74qk8eCxcP0YkYUx4WnkYprZIDbILYy/l
         YlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758457299; x=1759062099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJSacj7AG4ILM3IhKBoSOgA0n/MoBkGpNIVRvcCoIHQ=;
        b=qQLRYMGki6GM6duIbO/OuH+FXbke9lBg/aqtXBw9ItIruYgEJfCAPXoysndoAm3e9l
         Lojm3MUJwHFmO3JmR5XHVEe+HyFDqbGh82LleamzJTBFqG8JUTCw0S0lG+/NXQQDo1L/
         UvLUDDwvRSUrKiCoGmjqUr8kOfgkhGj5aURxl6Kmr71rX7bWxs6FuwJHsu8mwLm2hIqH
         VwOsi6C8NKoSUviIY8pch0TeFa255K+Nh+wC9O/N1t8fgwENWzjdn1m6/l3u8jW2/z0m
         av+6PZ+78YZAAAV46AphKVNCCL7YmMtus2wgK8jlxCavCihYvsKO4cyJFWT2aTHIKSe6
         40Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUvHacxTWmd9wfU2NA9mrX8TIEEvtRioXGqLh4KGInqyDhCq/o6Gbx+Ik0MNqFh5dflHe+esIyAEANcohw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2xD5TPIjs0othX4CaBR39qAyAluayF28OBnnIsCObOFZmWjV
	zf2Fy3sZWy52XLGS0bMxyy6Jedq30hv/j8JOXEvf3siR6B0Nb1WGQZwa9wxmvnFFwVTVQog8O0I
	uxTFIHygaeU8dBihlWb24qn0nhhz9iEc=
X-Gm-Gg: ASbGncvRK06b+1FT9GfLhEw4r7ZUGX3nnRa2cV/GZTWj3I2eYM/GyXTQ14ai+SPkyTE
	+QLfyu1qr1SUnu6mPCjofJMIAR0/CpEsEUL6svHtZRdo/d8FPnzMqDCj0fs5xdUkVaIXhwclV/n
	UxHopk9N72rul2+h+x0Ne/AUyPKM6Wi5ujrEtTmX5rA63OIZAK7p6noD3TO89s/1E7so71/v+6r
	jRNVTWC5s8xv5mA0b4qE41RXrb5AMeCkLW0wj2w
X-Google-Smtp-Source: AGHT+IHxVUgYnrAwJ5OpwEe3a87VRT7ipKjcAWLyiv2qdzKscH5CGBdYdKav7D1rg7rvs2u3DavET/DGycZAJPZEzvc=
X-Received: by 2002:a17:902:ce0f:b0:26e:146e:7692 with SMTP id
 d9443c01a7336-26e146e795dmr86596405ad.17.1758457299072; Sun, 21 Sep 2025
 05:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-meson-clk-cleanup-24-v1-0-e163c9a1fc21@baylibre.com> <b88a947c-7074-4fed-8283-c278b573a7ca@sirena.org.uk>
In-Reply-To: <b88a947c-7074-4fed-8283-c278b573a7ca@sirena.org.uk>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 21 Sep 2025 14:21:28 +0200
X-Gm-Features: AS18NWBkK72iXzXS1RwqWQ8AGRSrCLxvKKstfcdk8Ru-9k8WuxA-Kr0_IG8ezi0
Message-ID: <CAFBinCBe3LhN+3beovFVuWPpe3pDF5P1wSt7nPjm=ykRAx4zzQ@mail.gmail.com>
Subject: Re: [PATCH 00/26] clk: amlogic: clock controllers clean-up and factorisation
To: Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Sun, Sep 21, 2025 at 1:25=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Jul 02, 2025 at 05:25:58PM +0200, Jerome Brunet wrote:
> > The work on this patchset started with the submission of the Amlogic t7
> > peripheral clock controller [1]. This controller is fairly similar to
> > existing controllers. Once again, it redefines the peripheral clock mac=
ro,
> > the probe function and composite clock helpers, even if it is almost th=
e
> > same as in other controllers. This code duplication trend has been goin=
g on
> > for too long and now is the time to properly address the problem.
>
> Friday's -next breaks the boot for me on the Libretch Alta.  The system
> doesn't show any output on the console unfortunately:
>
>    https://lava.sirena.org.uk/scheduler/job/1853204#L1606
>
> Unfortunately earlycon isn't turned on, I'll try to do so at tomorrow or
> Tuesday.
>
> A bisect points to the patch 4c4e17f27013 ("clk: amlogic: naming
> consistency alignment") which looks like it's a squash of several of the
> patches here.  Due to issues with the bootloader it could potentially be
> an adjacent commit but this looks suspiciously relevant.  Bisect log, my
> infrastructure does retry the boot a lot on these boards so even if the
> final error is a bootloader issue there will likely have been boots that
> start the kernel:
A few days ago Marek reported problems on an Odroid-N2 and provided a fix: =
[0]
It's not queued up for -next yet.

Please give Marek's patch a try


[0] https://lore.kernel.org/linux-amlogic/175834437006.4354.119335451740046=
16373@lazor/T/#m29128b0acec2db62d45971d94a1c38fedc8493a0

