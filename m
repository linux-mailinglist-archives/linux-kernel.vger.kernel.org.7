Return-Path: <linux-kernel+bounces-837653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB2ABACD75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8980175867
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD56D2FB0BC;
	Tue, 30 Sep 2025 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLwvF2Nc"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6012FB0BA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235277; cv=none; b=l10GD8IKMjlF5hwuK2hAm50kX94DzpzApD/WCx6Xx/HRknYj6yUKmPWJqo93mfTs/aVISvM9YvqlSZs29VF7Ns21uNRXGT6FcSKWaPtIvttN2qKXh49MiJ53jE2m9FW7OdLAewiAS2pD7wm6YjT0EHUytNVf2bSEaTbuokpsCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235277; c=relaxed/simple;
	bh=CxPeSWWtp7yCi/S8nYJQqvkOJ/VCWtVtMBJciycxULY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/57lLzkyG4Kdf31k5uP4Lwcgv+93PuQRLOzokdP2MKJ3+RGjevS/P0m8H/QK8agHuwkKgzXHCs4nVGsSsFe69jFQuqI1gq3pplw0n/Jc0DQPb8Ybb1wz8noKGkfkRBVBrnewd0VQHH6M4qJWkn41K/HpP9bCx9zjtOuvVKIidE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SLwvF2Nc; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57e03279bfeso8304258e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759235273; x=1759840073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxPeSWWtp7yCi/S8nYJQqvkOJ/VCWtVtMBJciycxULY=;
        b=SLwvF2NcHgm+xvIppO/mJXE03JFyZaKbzgyZzLaYH7fmn8+IVUXmwu7wWQShP/fBov
         ZMuN/N4Km1K0GiNbr++bZPdJjtzRXaG2yIMVwsFKwFu+CV1ozPjqB0DaxYSLBgPWYKeo
         vg8xnZ/tQO5NJZdlo4YPLw4KPJ23t527YM+mA36Fg6h55BSWU1XbdgKyB4y7L92p1pzO
         oGdnzlOI/YX9e294Q1Ijlmeve2KcDJUOS54NDJ9aK8qMxw0MCZ2TnHe08miSWQGXnrpE
         FnFFt70gGbTWHPHvmjNJ2It/F4hGUIZzG95vvt1ihs8ihRIqwy7H62hJ0L3X3sSemcIS
         6YaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235273; x=1759840073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxPeSWWtp7yCi/S8nYJQqvkOJ/VCWtVtMBJciycxULY=;
        b=skGka6xBCksCOQMHtLVLhkcjz19fQnhJk2oUgFfptKODoqszgrry5Zskti7BlU1iN/
         xKrNMP8BM9C0/fr1EkwIqhn1d3ThnGYQ2iBRWP7vFd5/JzF2Beh/vKelA4A6YaxO+pIq
         zyUMADppTQ7ZFKlrCZQ2VX+t9kzSq3IdHZQjbQVBJbXmgRShT01ciRt89mqBFlVwxIAa
         hm04hzKaMctEMGI9lK5W6kI12XuJXgpm27V4lXh91DbjPwdWPIxZG1esppAkOPJOYKUJ
         LiBDof1+X0qQGUrexwX4H+UPDsa0EF8fwl3ZMkO77FCUrENNnsjws6amLHWHinF1QNvZ
         xvgw==
X-Forwarded-Encrypted: i=1; AJvYcCUvsFxq+HlUmkmYqq+czpKc7OLhLbwoPduHiwuN1yPPNc0epm7QUClwgnDyEm0faBO/e8HyWKoOoZWPfj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY5gx9Qgpoegi4y2jzRTz7To4cUah2dPezsCvCbNfe7TWJKgu1
	GhqwKbgFn6l/G9WgVA7GWCQFJiMnIIFPj59R612I3MSfkccYkvL42dB7nq+lV86h/eLw03eSj5z
	Px5I9LIUCRDWZYIN8AsU79VqPQjcOR6o6CeA7d9mQCQ==
X-Gm-Gg: ASbGnctKLbf+0/2O1JpDiuz+SxPZtlE6s0J/cUJK6UgHvpy/ojIGOEYkDgDgNI+Sn6C
	QLYVCXfbw0pLO7CjqpT4qDGbmcTJR8FCFNjBKdgwHtwLrRkyd5Q5FWWpgG6sobHlyJG5905lHj8
	tR4oi6k78W6bqLbTTKZFtFkEiLLtIE9EaZoi+hbG87glB/r7wG/Jysw0ZXmlb69oq0KSLA87Y1R
	9wIczYE1oJN6EPCFOUApRoY/EFicKONkrWBlOu6qg==
X-Google-Smtp-Source: AGHT+IFl2fD15jSgCh2pFv3aJNRspWrtZV7i7NaeRsIsPQWf104POXmKeFKk8H4hPkV5j7/R8Qw1pfLGsDY+0vg+EMY=
X-Received: by 2002:a05:6512:3989:b0:57a:9595:5b24 with SMTP id
 2adb3069b0e04-5897c90fe5fmr1410763e87.7.1759235272628; Tue, 30 Sep 2025
 05:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902222334.105236-1-jihed.chaibi.dev@gmail.com>
In-Reply-To: <20250902222334.105236-1-jihed.chaibi.dev@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 30 Sep 2025 14:27:41 +0200
X-Gm-Features: AS18NWBwwrrU2OE7TyXGE3VY4x57V1Hc3ztY6uepvj1pSge5poxYVFnZvxeYHBU
Message-ID: <CACRpkdYRD0oNi+tp6bwhUymX+ayDjcSVs4Cyo61uy=tW4Xtajw@mail.gmail.com>
Subject: Re: [PATCH] ARM: configs: u8500: Set NFC_SHDLC as built-in
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux@armlinux.org.uk, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 12:23=E2=80=AFAM Jihed Chaibi <jihed.chaibi.dev@gmai=
l.com> wrote:

> The CONFIG_NFC_SHDLC=3Dm setting in u8500_defconfig causes a Kconfig
> warning because the NFC_SHDLC symbol does not support being built
> as a module.
>
> Change the selection from 'm' to 'y' to build the driver in-kernel.
>
> Fixes: 344cad0660ea0 ("ARM: configs: Update U8500 defconfig")
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

Patch applied and forwarded to the ARM SoC tree.

Yours,
Linus Walleij

