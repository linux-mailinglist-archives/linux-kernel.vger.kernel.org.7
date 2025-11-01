Return-Path: <linux-kernel+bounces-881591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB24C28838
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 23:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426EC3AE36E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 22:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C5D258EEF;
	Sat,  1 Nov 2025 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/6FodcB"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066FC34D3BE
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762037357; cv=none; b=CF04XLsnetv1tVg64bw9k9oiuIzVPJiupv19Yc4Zm+k0C1YYm9/boPtivUx/qehEQTjPh4lYMZZJz+nuYn90/WqY/+zLC6S9+38xEaJ1Ec8ljUqOP59jciZCIxz9ErA9q8FjGIGI00n5OA5QJr35CjVdGvUPcDkcA/v3/gazEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762037357; c=relaxed/simple;
	bh=9eFDsp1o4/8aVYrSUbQAIlSG2uAaNMrVWzWHNt1G/uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5hG361iOBU7UXyZSA7fr44rrFZUbhW0ArqeQkCBBamqNZ11ocCMGzQtYKr1Pw6kwP3cqqUe7/ayL6BSlMcgemE4QtK9uze3tjKI4m9Wjdqdz/jivOq9zMHSLlLimk6JqrvJymnOTvROjzUDs0TzEZD63C/FxclA6P3wJ2ao3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/6FodcB; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59303607a3aso3854978e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 15:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762037353; x=1762642153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eFDsp1o4/8aVYrSUbQAIlSG2uAaNMrVWzWHNt1G/uc=;
        b=S/6FodcBmexDRev34m+m9SLPhNiNlLCvWL4H0QuQVY6s7wnpa6wGP0waqoaejo+PTg
         HN/9YQXTc25zfP34adzuFgoWzEj+wxvXlMsJqfBz+ZAEQ8DstTyVdfiRC2b23FDqIydu
         9beUs4J2y4dLmTlK1SrlYnhXnSEq8g3ezMFhb05I/vrJzwDttJTvzrAKy8N/XH4qnOC3
         ua1hOFaPUQFuMLud3fGvtUpELUelyA2HLFkbeUyIsZylnJOuTB6LBqMreq8frZ9B/pzn
         H++fVTQcWUwnXI0241F8CaA2hAeFoC4kigxMjjTkc+eNKvvX3vbUxY6gNmliQYCdoWDz
         DkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762037353; x=1762642153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eFDsp1o4/8aVYrSUbQAIlSG2uAaNMrVWzWHNt1G/uc=;
        b=WeRAUL37+c9bo5Iu5W/3p91e4rAECffUwAfjwwQo8Fi3Qepo64YgCfJfv7I/KzknHX
         GXFO4wwERCzvj3A4p+6s4BPOjUz3NZCj9dTh10xEoso7oyKPPwEQGbVBHSlnFLhwsMVf
         vXPJ7y4zI2rjJqZIk7WsYmLLOUxazsNlyagvxCB5V5Pe+xzOryLrlFsjpN2aPiycN8MH
         aCEsSqaRe9zHv2ZFUUhSUtFbe+E1PPEPow4swSUAVXBt5tpdra3AaWfAUlaX6qCNrWbf
         YDDHnz6SQURM90kZ2kFRrNrZGl1RD1MsYt2k5ozBM73LX8oundNhcs78GMarNT01vKPW
         etAw==
X-Forwarded-Encrypted: i=1; AJvYcCX15lRO9iuHHM4JctYPmRlaRTJOGeA5kxtj44Xq2uFy4mqRnU7EbuO6VfihQSj1WznYwIG91OUlC89M9Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/b1inVNJmL+HogZ9edkKGG5S5PAwjPetc5XrHreZd46QIwg5
	3TinEn3C6MA5f0g7oUljEbcOLEBVcX2t7mbVrUT9N/T3YDl5Gd9OWDUmceUF9i7uwk17WklPycn
	zM7YuQEJgugKs/XEsSvSUaULhikwRYPyxtB38T+wn1A==
X-Gm-Gg: ASbGnctJox4qS+cZ2yPUgXU2d6JhHU7ugPZbjfPB9QBqDvl7PEE0PyJ7HGxG+czOkrv
	Dn8Q8lWPAcFesEArgIw5F8K42++8auq0Me6DFijM6xGl+ldLMGzu96lPcMdlEwRO7NCRZ1z1WBU
	hQxibeQo9pBIZjOjO3yhFGGvgMVOoQ8+2PYwY6nRCEXm1HCLDZx4qJL7dhLMzMyXNJDGABHnxUi
	QdWFw6IxRvLdjJzNY8e0J/ysLxhZgHyXNuIBXQaa0eHzol3BxkvwsZx8Kw97m9EUSwxg/k=
X-Google-Smtp-Source: AGHT+IEFjei2dnhSXzetj6BeQPK4MNRfC3hjYhc8iciIq7jhsRiPiX3k9EKQObiMXLp6AN6F8vipX1NIBfiBMmNbEV0=
X-Received: by 2002:a05:6512:3d07:b0:592:fc68:5b9d with SMTP id
 2adb3069b0e04-5941d50d137mr2589210e87.10.1762037353135; Sat, 01 Nov 2025
 15:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031150631.33592-1-brgl@bgdev.pl>
In-Reply-To: <20251031150631.33592-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 1 Nov 2025 23:49:02 +0100
X-Gm-Features: AWmQ_bk0YEw1TXqdQKMCiJryZDzqqz0FkOVR4q7f9m3SS51PMVlmFD7M-iMyOhM
Message-ID: <CACRpkdZ9PqScxfgadaNjMZbBS2OTwYh7Eecf_jhLKWKzGJGRwA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix invalid pointer access in debugfs
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 4:06=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> If the memory allocation in gpiolib_seq_start() fails, the s->private
> field remains uninitialized and is later dereferenced without checking
> in gpiolib_seq_stop(). Initialize s->private to NULL before calling
> kzalloc() and check it before dereferencing it.
>
> Fixes: e348544f7994 ("gpio: protect the list of GPIO devices with SRCU")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

