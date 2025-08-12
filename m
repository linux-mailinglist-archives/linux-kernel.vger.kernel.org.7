Return-Path: <linux-kernel+bounces-764957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D39B2299B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95DF61AA3C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B7D280CC9;
	Tue, 12 Aug 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZA9NG1ub"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CDB27FB26
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006210; cv=none; b=bQEaKuAcRxEa97QqKSsi6uUtOOXejmJH4GjN7wcPbgEGMrGqhLdHDxF4m5Ns1SOThWjSyhzfr7PeFMUVwaNzGocBKkhMP/OfdoVgzB44loFPLArpHx5oD/Nk7pwe2k00tEYil1gzeiLX0zOwf5yb8O0O/b//9cl91FWIAcZOGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006210; c=relaxed/simple;
	bh=10DayUutEE+8+BzPqhnagZ2gFTkIus6uLskzB/ocOU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hB4wFU3BWPgH0R0YIV56mbDWixowc3We1Jg/2pWc2I7FPGwvcqVp+f0r9rknweS2ZBkG1Rh91RgVb478XaALjJIT6Xyj2IxQe2n2+2YPvRWiGL5w7vSmYT/Z3izfQQ5htEDiRRzEEevwIpEUD2o2GHeSVcJjlce5MKJtlHQgpQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZA9NG1ub; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55cd96b5432so863335e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755006208; x=1755611008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10DayUutEE+8+BzPqhnagZ2gFTkIus6uLskzB/ocOU8=;
        b=ZA9NG1ubS3LVdt+RLvJW2cAJINGa5FA7N9zwkD5Ag662+zJ8N4dOaV5M3vy6f1w5E7
         ooP8pGGig7BVR8wpiywXDjBdYBG8Rg5Av4cc+NYvs3+eJtx6cj26S2++OQp99hpXd9Mp
         zFhELflYFEoOt36i90Q3ZB7DOI77rL1ZbfHP/CRMy4ULjjirkdw6QTyrEhQ/JWkSMhlZ
         j7zqjCDAxb6dZQsbhO0C42oa7wMw/zUp8uG8eejOqHSPbHV8tlH8vtNktuljrTS6raT0
         bFHLjsph7z6vrRTjWTYgDMolSdHLScwqgqKxbOns8ek9vLBLmzBGapy3Lh/LUzBdptUl
         3+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006208; x=1755611008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10DayUutEE+8+BzPqhnagZ2gFTkIus6uLskzB/ocOU8=;
        b=QpzEbpVQsxpUYAn8lg7W9tUGhc/pkA9aR9D233g1y5P9THVL8+7O83DPuNA0TfvAvS
         aYAZP59ING9EnPJVPRekwLzkW1zIErimxzI+d0T2BYbs8F4zkIXGZb7WosIEYU5GB6F1
         r/QDTwSNpltZCkALnx4a1Ioe08TUHNz1nXaEMdTowtadWmTX8WqwXhrh6RFnlMKK5ZQw
         2XVkT0BR5szVMD2TFk+cDPhhFXns6ybmCd59+JTa+hzfNBTlhPJqQofqgeU4FWXo1RgL
         RUIAYcDWvrPRclMBC/4xqcuPasf9XY7R7q9VLOfQNERcBGbAZHfwQdYPzHjfponjv2kl
         kWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5RWZ7BjGmkbIjS1VD5Fr8wGzqXp4u+TWPm1euJbSjscLjZ4JHFUXFFzZszU7lHKJf4fC1+/UaQVWo3gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBFUMUfbG5OTP+oFhqdHX1bPw92uG7RvSJEyYJlI6senegF5Qp
	zRwEg6AL0LF9CS39M4vaQWLsczJ/U4wNaFlLV2kDK2v+uoX+2q21fuAJ7PNMEapQXjnp9FJC4H+
	qSqr7ae4OaXVphACZEv3FEOc2n3Rgai6Tys24h2mrjA==
X-Gm-Gg: ASbGncsgeD4v+Pklkzhl+gRVYBnemhqbOy4Zi5WRUuTasTg3XYFGAf41QO7LBwRgOrD
	rc5u69mRE3pBOLMXTIhvl0ffb+PGhmpU8zg19S96nsViYc5DG77en+gh7mMGQHCG2BFxIuCHSQa
	vEG4dC7JX2k8l+Nc3dLwX9bJv6nJvQh6DrkRLHExgncgbm4ythDezz6pgRjiZ/hY7WWB8EwMYay
	5PVystalgpeD/gyawvIZtDZ2yTA/4GkPrv6
X-Google-Smtp-Source: AGHT+IHQzp04bzC5JdlSIA4egh40+H7c7r6zkMNOXSxJb7bMpFxuyFM28d79+bAJAythGzevvvdtqJolUysV3ZHuypo=
X-Received: by 2002:a05:6512:1509:10b0:554:f82f:181a with SMTP id
 2adb3069b0e04-55cd8af0b3amr687496e87.2.1755006207600; Tue, 12 Aug 2025
 06:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754928650.git.davthompson@nvidia.com> <8d2b630c71b3742f2c74242cf7d602706a6108e6.1754928650.git.davthompson@nvidia.com>
In-Reply-To: <8d2b630c71b3742f2c74242cf7d602706a6108e6.1754928650.git.davthompson@nvidia.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 15:43:16 +0200
X-Gm-Features: Ac12FXxBNvTrYsmC1epUgaIYhL60nohcjAuiTCNAcP_ercfbT7S70TOQRX_fyJY
Message-ID: <CAMRc=MfAP6sEZhcGvsyAXjTn47YPRfKsZq6MmbXjR17fQSDEXg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Revert "gpio: mlxbf3: only get IRQ for device
 instance 0"
To: David Thompson <davthompson@nvidia.com>
Cc: linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com, 
	mika.westerberg@linux.intel.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 7:51=E2=80=AFPM David Thompson <davthompson@nvidia.=
com> wrote:
>
> This reverts commit 10af0273a35ab4513ca1546644b8c853044da134.
>
> While this change was merged, it is not the preferred solution.
> During review of a similar change to the gpio-mlxbf2 driver, the
> use of "platform_get_irq_optional" was identified as the preferred
> solution, so let's use it for gpio-mlxbf3 driver as well.
>
> Cc: stable@vger.kernel.org
> Fixes: 10af0273a35a ("gpio: mlxbf3: only get IRQ for device instance 0")
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> ---

Ah, yes, it slipped through the crack, I should have paid more
attention like with the other one you mentioned.

Thanks!
Bart

