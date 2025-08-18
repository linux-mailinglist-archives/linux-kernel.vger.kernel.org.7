Return-Path: <linux-kernel+bounces-773252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB68B29D56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A581890EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D4430DD1F;
	Mon, 18 Aug 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kl/Antdt"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525930DD0E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508300; cv=none; b=tsHH2UBEOWKVY9lZJiSyVJSzou+L1H2767Endo8dg/O0T5JuYGHKH0X15mn7U9UH6CJ4zxH75AjQsC4m15OJkgNZj9VuCstFpMOP+npBpTUCdOy9nkfPWcboBidWpMHhRHXCQ4RoIrZkq0TGGK2fYg4p8TlsKlzW99PQE8qJIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508300; c=relaxed/simple;
	bh=DcnZxDmddaN0uXNCAKklDD8KhKB/8VIRPzW44qoA8sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXRNycw7/gCwBfo3GmLUicENxRkk/kRmP8jlyowbG2Skb9Obmf9IBAPSoUudejrLduTncBpdtIiSYAMTXjVNoTkJpeNmPgSyY4p9hfE8XQelBM+auC5qlTL7hkAyemEOQOltW5+UtH5e6cwIA/M4vKfazLWR93Fb3lGfbE0kuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kl/Antdt; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55cdfcc0ceaso4428175e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755508295; x=1756113095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcnZxDmddaN0uXNCAKklDD8KhKB/8VIRPzW44qoA8sE=;
        b=kl/AntdtMgU91z+uPQbU6HRtx6fU7cQir5rMkQ27rtYBNo7QzCHTgVp2F0ReYokG4/
         aZKoyKxIH7koVD5MI+szpXFBUxHRSjFWLwth1aUFo/ZxE3mx2LmtUbkzHbZq++Hcasfk
         FP1Z/FzMQ6ySFvgBOyDeuMTTL7gcCmAsUbqR5HzrDiyUhZnmncuiSdNCccHRibLHWgCF
         eXFfsf6B26ki2yBfeawCdcoBvFSUD2de60eGIy0fpgGzqVS6bJrDk/YxdS3VqAW3tyH7
         HIzu6ARFkYVM9/3NQdvAJwYgNEUQawe3yZFNOPVIPlZEjZ9YXBhctr2BcHRD9pNu2bhO
         EOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508295; x=1756113095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcnZxDmddaN0uXNCAKklDD8KhKB/8VIRPzW44qoA8sE=;
        b=ncADjCj+r7ku70I2Np5SJBPrJjlWYIz+a+fUdQqveGhIBn8NzRb1HSivcFXEjPwjiT
         ZkLKnaTIWJv2FcRgGACa3h+++CdA+LadvHpg9teinqCGdTU7s+bbdk66NblAQeOuTMZn
         k/w+YmsGEgzg3wqwDyYAidkQDoMh9CTn+7UywRnnBTTW0vkZV1y7sLYRbgEDgYDJFSDe
         YFRuRcQrLThPuQ5CIz0yxCWtXCmGtWY+eDc27IjCegcVoP/BXRnq7aa8eKLyvUjF0gYJ
         yZjqTs0ZAYeSlpjynWdItRY3Jv47eERf5unyGlFXfTGxBK2rON+n0OcAQAoYqVNjeB2H
         zz3g==
X-Forwarded-Encrypted: i=1; AJvYcCUsTatPpdDmp7NS6Ao/Q1LU7feaFN7itw1v8WX74k5cu2Kthd83Oef65/fY39VzEvqQ5jY8b12YGBbyQEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfMZp2ti2pqLzIRabaH58W2Ux8ql5Mhpm0xFgfD1Qg3vBq1hLn
	YPNnBpukM0Cv46A8y+xDspxCcrQBCB8CAWYP9oia3H7G2ab6hnFCci01iQ+GeixTsNUNyinBsm3
	DwcL0A1+GDuvtb3godVVAVe2gJ5973F28HY4xDFMP7w==
X-Gm-Gg: ASbGncuGL6PS/qPNz+SeQAvVWdfNmuG6wlj263p9Xq74RUmIqjpNa1Ih/crZOre0gJh
	bt80AohgGHA2GAtRaVF8j/FASh++UBghm54tbqhP7Q0sxU4M1wUIT6Uiii7cFdvmnI8s1BVa4v+
	AkM9UzLkIzoygaQwDGSzMwFAG2/P+AP6rBA8yx7xW4e3jsipbVLfBjbAejAmSJ+Kj7mV2nNTtvz
	RVOpeAhu+ZJ
X-Google-Smtp-Source: AGHT+IHgT6KsRzSnbopUtkS8cEhRfVfJ0+AHWqYOh3gWL/IW0zk5pe+bot9eWtYj+gnQIC499kzORbuEnGkUjOVjrWk=
X-Received: by 2002:a05:651c:e0e:b0:32c:be6e:6719 with SMTP id
 38308e7fff4ca-333fac4d04bmr33701811fa.1.1755508295256; Mon, 18 Aug 2025
 02:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755170493.git.legion@kernel.org> <e548b7761302defec15aa2098172eabb1ce1ad4a.1755170493.git.legion@kernel.org>
In-Reply-To: <e548b7761302defec15aa2098172eabb1ce1ad4a.1755170493.git.legion@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Aug 2025 11:11:24 +0200
X-Gm-Features: Ac12FXxtga8FCHwZMpHGt8XLiCGvlV2q8kZWzSqELDgp5nsspkpj9rrMqCjq2Ao
Message-ID: <CACRpkdZ9oyJ4aJ5Dcp_Dtv5qoiSo+g5cO7Uf4PmHgv_Z423onQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] pinctrl: meson: Fix typo in device table macro
To: Alexey Gladkov <legion@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Masahiro Yamada <masahiroy@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Xianwei Zhao <xianwei.zhao@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, 
	linux-gpio@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 3:08=E2=80=AFPM Alexey Gladkov <legion@kernel.org> =
wrote:

> The typo when using the MODULE_DEVICE_TABLE macro was not noticeable
> because the macro was defined only if the module was built as a separate
> module.
>
> Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-gpio@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507220009.8HKbNP16-lkp@i=
ntel.com/
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

This patch 5/9 applied separately to pin control fixes.

Yours,
Linus Walleij

