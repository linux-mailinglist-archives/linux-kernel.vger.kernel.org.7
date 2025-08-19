Return-Path: <linux-kernel+bounces-775737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCFFB2C427
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4ED5A5A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB7533EAEB;
	Tue, 19 Aug 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h8Dcovti"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E433CEAC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607808; cv=none; b=cVKvoMiDdmCHG1BB4qaDUGvvPe+5t5bJI2kDJ9bDZXlNEPM155kNA70SjRDYs4OW2oJdJ/VO0o+u1sbkOJ7R9TimeHv+pyrgBrShHXzFjbvkusxRBUsI+fXVF8SbZ6s/OYEAfcWSipy+pimLKN+BNcfrwHtnFybWaA5Ph1fhcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607808; c=relaxed/simple;
	bh=VK+2UvvpL/cCLU3utXHTMH09m4NrnfRk3clo5zecdXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIavP8J7N46sHkE+iJFgmNfCKmBgl3hfix6yISxUNCx+iWjY01CcIxPJQWVWuB1E/sjGHXk+n86ZH8UGYyIE30s82pC7tOKkOfDOZ5YMewgaMQU2MrqS9ackrVWmcbpFajRiYLgpuFDYI5JaBJzM8jmAB0pZM9a1uxmIr6ORo/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h8Dcovti; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-333f8d1cbcdso43220351fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755607804; x=1756212604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK+2UvvpL/cCLU3utXHTMH09m4NrnfRk3clo5zecdXc=;
        b=h8Dcovtiih6rKkfnPp12hbsbmeHRx5VJqZJ+LQxCpdZZrShrLCh3Zpr50I4pWnQIH3
         hgK5uIy5Vw2ZoYGA/FREUecPEUBqZUT3k6zeMB/iWSgH4vdCC5g8zqFyjydZ85wbqXxV
         7S34aOUN6JvFOKbvKXWCPJDc/uM5sor44P1VPHLM5d4/wcKAFIc8JXSqTLvNjI4QrM8P
         MD9SGk5w7O7aGx1dhQ4W90286eCT+3K6gVVILHK1ssT6oi7MRwzzjXl957BAFJoSlckS
         nGwQEQfIg+T5p1ILyibZ2q5yasxJALGs7KflQ6co4wsmyT/uZmQ+taUCOZL8MIhD+ZJK
         2Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755607804; x=1756212604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VK+2UvvpL/cCLU3utXHTMH09m4NrnfRk3clo5zecdXc=;
        b=fSB6yynhrDcWp6/J4KGJxQMQjESLFEkn45xD3ROBppyXixZF8bNh+gaBcqaVvKh4Wp
         QiYuz/gNPPNe9PutZWbsd0PeNnagQET2fr6MA+4MT8HF3g+XUtxFvoF/8Wxsje58xbPn
         6oDTbleUbpjJ157dJ4L2+lvYmuSmcRO2lP629xSuo9AFdb/w15jke8CV3CHKR8psZeFd
         bsFauYxuPnKYn29eEqyRjWUMs/034Ru9wvbs6D+vMeOJtQt7KDDvf3mj+fZ1Re+OfccP
         ulmr1Bs4v/Bq8+ULrO224iw9+NRego+u3JSPF+wS7Bs8dyzceLb0kr9zb+Tzk1Mmmo5F
         EFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSinTGXBu74nMYFJKAqpjundciVTILEipg/khWgbpXpBjIG32NXULpT0fwMSl3rbBs1Xwf6M4FdjBGIIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeq0pjMuj4wl8E2DGOwdZqr7py+8PnFrM2DlnVSDj8YbFJylke
	Ho0e3zj7PbGUetheX0u/tNA1+6rI0MwTve7eRC1YDzDxfLF3cG+NEZTKfIIbluhikpQpMeWg0T4
	kpgBqFtiuKs6MD6VZnIVjB3XEhJu2uG+BhvWIXClC2Q==
X-Gm-Gg: ASbGnctxehCZpDrgUBit1eak74xdVDVj6BHYTJ0JQ3nrg82JdZQ4wFR+FgAd9yIlZC+
	TPDeas2+muEZ4pF4pKM3jOkHFEan7ddCAwOWI2hzYT8o+GVEmlzAtw7ssJj+N4tzJ+nOrUICSc5
	mJGewxdaW3s4nRL10l8ayZs/3c01VGUyxqB75j0MHrM+ccS9NdOHK3jra7RA8oTMLi4xoMwU+GN
	AZa03fU8doxLRmPlZ2NTPA=
X-Google-Smtp-Source: AGHT+IHeICNzId0TeCOa2HwCS057ZaEol6I8kkIJiDlz6bpaH7LQuiJrRfIa3kWPjQ+FO6z3QaESPtE94SzLL8OyVIg=
X-Received: by 2002:a05:651c:20d7:b0:32c:ab57:b03 with SMTP id
 38308e7fff4ca-335304f93acmr4931641fa.3.1755607804225; Tue, 19 Aug 2025
 05:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tnaaz2qlk5jpbonfle7uy7pb54qx6ixwuczfbkwtxxwpj7hwas@y7a2rwko3k6c>
In-Reply-To: <tnaaz2qlk5jpbonfle7uy7pb54qx6ixwuczfbkwtxxwpj7hwas@y7a2rwko3k6c>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 14:49:52 +0200
X-Gm-Features: Ac12FXzlHx5q_PBstfTvDK3Lfp-tFPZCTH94QW-bgrJdiOv30F24hNuiuM-S6zQ
Message-ID: <CACRpkdZyWYY11akth2RFw5FsbAo2WsiUBPPnnjw7bFaK=y+VbQ@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: gpio: add documentation about using
 software nodes
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@kernel.org>, 
	Hans de Goede <hansg@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 11:30=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Introduce documentation regarding use of software nodes to describe
> GPIOs on legacy boards that have not been converted to device tree.
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

