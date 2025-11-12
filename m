Return-Path: <linux-kernel+bounces-898289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 612C9C54C62
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D189C4E0F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F682E717C;
	Wed, 12 Nov 2025 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9ORUKvw"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E50186294
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988689; cv=none; b=NxbUakgLr/yczmqlKNXq3Kdve8M2RuqA31HEc1ygOtB+FdvSEGD1GmzRx38MEPPWC8KVYo17rgA06+40cIOHV6GqqoGdwTceNtBqftgEqAJhW+TxbHC8uSv2xYo4RdJz1YjsvvuTlY9j8ZfuyKosj50FTG9Sjr74DGY7t2l+FHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988689; c=relaxed/simple;
	bh=ePb3+WnqfOOCNnILjGCw4smH5j4z81BDW0dbUUEnCu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOFPnIsYbO/dhfMXMmQiRqxy2uBatwyU07NXGQWNVLoGE18YXSqp7+jjTLNCJzggxVUbNtot1+znghJ3uFe4gzT52UZ+THXaydI5g7fL6rGscyNnTsSCuVkqHk4iEjsE/J17PLDpsb22NkBSS724MNzArPZcjRMwsCHebOitXkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B9ORUKvw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5943f39bf9dso205740e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762988685; x=1763593485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePb3+WnqfOOCNnILjGCw4smH5j4z81BDW0dbUUEnCu4=;
        b=B9ORUKvwM0h6Q5eY7ZLeYgVlH+1oepsf9GzLbU1GRjIM/a966d0L2zTwlPVBr7eU0g
         PkufAHA9XDHhJtT05u3RDSjIXpNTJKQX/yX7nC93kMbUZHQ0xOV1/OSNeAC+Xl3MogaR
         ouPfy08qo5NtKk6hFXksnGaOSBWy1I7U4Ph8R30OyxjfBTUIyNJa/XF6yG/UtPs1nKOp
         H32veD+OVwj3vcXjQfHgQPii0C7SjkXnf6a+O1z48mxu5l8xo4d3dsqlzlSSTq/CoPcU
         GGGDONzBiERkbLPOKkdg6O+RWa5vs6BxFTGRKY9wthALdqYe5woGVxRg2lcTkDvusLE+
         HIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762988685; x=1763593485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePb3+WnqfOOCNnILjGCw4smH5j4z81BDW0dbUUEnCu4=;
        b=NTwCkdVVk7Z5bWHezDbGq+HfVoorEUUSZbyJlsa70lLnzTvsCOj6veC+T0M2iUfy/f
         hRoC9lp4voFm0PnST7jtc/wXqWUOkZNAXofYBTr0FGDQvpDPW2RSxtFwtgSNQmPIB9y2
         LUxFCSrtRXZfPTNAigOa9kihwKWDqL0pOzt3BmbP52gNojMr3neR5pf6L5a7DdHI/3Hl
         DK9t+MjUAzIA2Yj7hulWk8rTbCdD4Hyk4wnv0Z/vHpZw3378KaVhDdE6bPDV6WEEMV3s
         gkNkNiMcM/t68raITzKB/dnbCZhnpHvpQelvtLnXOcfsMh2j/AuBSsVIMt2/vCuyaY1G
         oKDA==
X-Forwarded-Encrypted: i=1; AJvYcCWI4G/TRVN/CxF6eAD/evLKBeJ9qN7J9VdAGLomvrEOfpFxGRRZWBLAEmeFKM3eTlJe7imzXU3/Ikj4Pis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbh+x+cSX9kgFaOoTLBGhuYO0osTOqgssAemmJWSkRCA3NqjDN
	3ZfuuCmCo6n1OFvbAAstafNX/9ca3N2q5zJT+rfeo7wbAEJTa9ONaO+Ho/XRRjTITl3tgAObX55
	PuM2rt5R+KOct/V99AM3aSy9ypho/8/BkXI4RQEUNlg==
X-Gm-Gg: ASbGnctNtHGdY+1tlaC9K9TPwlp6YX2IuZijFd8Id2CIQe2pOcDBLYyaH45BUAHf89T
	qEzT60gAwJgEkM+LAo0RUfgjX1/GlPmsVY4ghEujtvdczxDH5k73t2hUdhe9P3/lBoQfPPBbhil
	U/up01Rd2rk3vccN35/RqC9LyZ08la4h8rKgytYEo8ea7b+DRHCAZ5PVCi68P/SKKd7j7O6gsCU
	qwkr9iSH5pyfHrs1oB0pkzo2kPKyZHq4dC9NOY6/Ejo9Iz6EwPxhkFC5guyEYfYK9MpQx0=
X-Google-Smtp-Source: AGHT+IE1BF4Vv10l/Sjj6kBtQfn8UzqdYZU/iJmxP7Ig3hG1/jtYcI0ag1MxBYaDfkNDF6y/ADJNCl19evcJlZ4su28=
X-Received: by 2002:a05:6512:b8a:b0:591:c8ef:f838 with SMTP id
 2adb3069b0e04-5957ecc2749mr332999e87.17.1762988685375; Wed, 12 Nov 2025
 15:04:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112224924.2091880-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251112224924.2091880-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Nov 2025 00:04:33 +0100
X-Gm-Features: AWmQ_bmnNGj_Wxq99lzqQymduEdozG5iRqVkyE6m_DF6KCgBqogfvoiry7COaZQ
Message-ID: <CACRpkdbv1wZmLRu+r4PoxqACBa3TGzqnhAq9LvxqF_w7Q+rXwA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Documentation: gpio: Add a compatibility and
 feature list for PCA953x
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?B?TGV2ZW50ZSBSw6l2w6lzeg==?= <levente.revesz@eilabs.com>, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> From: Levente R=C3=A9v=C3=A9sz <levente.revesz@eilabs.com>
>
> I went through all the datasheets and created this note listing
> chip functions and register layouts.
>
> Signed-off-by: Levente R=C3=A9v=C3=A9sz <levente.revesz@eilabs.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Impressive.
Just taking the time and adding some docs for this very popular
GPIO expander is worth an applause because of the general
friendliness for developers.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

