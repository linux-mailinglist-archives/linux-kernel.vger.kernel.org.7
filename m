Return-Path: <linux-kernel+bounces-872726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F00C11E75
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1DB566D37
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3DD32E69A;
	Mon, 27 Oct 2025 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IfksUcQh"
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00B8334686
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605141; cv=none; b=M2BxlXCpefatvWh0zcRhaZ/fLUY5utMWoTd1YtZ7y1CPNPR4x3fAEz8UtqD38f6IJ/rHnitXbt/3uuiJzKkQlCVrpbyOQH+7DGtig//pdxzZ2rYLjOAzoWSfz6jC2f6vo+0cG9+nK37+pTwiPu7eks7f7F/kRT9mbVOncvmgOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605141; c=relaxed/simple;
	bh=RotLeLW5FAJfzQv7Gq4AgyigcI02XgPNhPI3twaoEDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9aBCtXtBcAytGkp2bvJarKlKvGDPbBbOZWgLoqnkusmfNhO8Xy1NIOvXFBqGFlc0xrWuYHXBpAblmTSecXD84Kz7Wy699kGj8F9O4QPkjutpEdtlC73IsUQ5vz+/LVATuYo11DoFoWv24z2fihLUUR5KMeQkLKT3TRxgqGn2QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IfksUcQh; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63bbf5f77daso5822410d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761605137; x=1762209937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RotLeLW5FAJfzQv7Gq4AgyigcI02XgPNhPI3twaoEDw=;
        b=IfksUcQhCwZkOkzycTMQ9LEXahrjMBnC3VHgaRlZPmlReF2TKBgolQ1fbWPa02dIOd
         eBYJfzFUw6lmAwQnpwtpKEhwqOmUJ0LNoUwczvn69sCd2YaEb3pmJLx8/T7EFdH4agpj
         UQRrT20m6TZ9r2x7LLFY+FfMLI/MrTY6nSVCGi1mPQcEJHzrkVnhpnTLp+PFE0KmrEW3
         2maQA4exW2yra1AFm+8JD342en1obdCxqo7xNa6Zo7OGtDbE+g6+8XUMIyf2qZUnh5Mk
         31Tgs76IoXOtzChIijOTNQDDDtqFdLvhZpTT7ex+6wMY/C/Xh05j4sEHxU1RKsl/6hR/
         nxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761605137; x=1762209937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RotLeLW5FAJfzQv7Gq4AgyigcI02XgPNhPI3twaoEDw=;
        b=uX5KPbl12vljwyo1iA/ALx+K5Kb641j6dB/sDtsONh9fAso6dx9OcJDtp8YNr6abqe
         SeI6Y5UuzbNY2SsN4dZJdM42rbML2/K6ho5F2N8V6Mo6QBBdUewlwk/KPKNGZ+NLxc8c
         ZdW0G+bbMjEc6/JSx/9sURTVqOd2fmtbm6nyWIp5xCzr5PwHfzK5OBw47FJmoj42nUpV
         pblXMvZpFPByNWfHPASDs1oxeLfB2oOlTuJaB6wmjkaOImJynzd229FLJGh+qhUfW4B7
         +4aDG8IgJuu6Ogjo5kcB1D0QXoIDGA4L5PAJo/fcqsHy/5qDlLK4IVeRJbm2Pt3wK2HF
         6GzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK+dw6gldWVQ6mevt36Drgdb1JWn1qz3mo0DP44Z5idpwUKv2QovmxWEC7iEVPNPL2nzqTwWwPaIyVe3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCptP4IvIVwg5Hg+v1SRiPuX9ek+4KxT5/gupM0bQxoWMUq9dQ
	o8lpXlIod1ztW0BkohAqvS1LiEKRahK0K0P0iYT6vwtEUbiKcDzF3M8RvjAt0EfoL5lQgVxfhJw
	yLzYGMkyUVIGGx1PZIqEsStxzcumEuTQCd9tagAdGKA==
X-Gm-Gg: ASbGncsyy317M3xyxl07+YG+3EWGk9xSEPO8/bVnEi35NilaUAYaEtyT7ZY96TlFVu9
	2oSgt2pLMbs4CCM3TGsSZMZGaaIfDGa+Jn73PUymcCdm9whJTeTRd1eDRv0bx2qjuMWtrfbLzBS
	lY962v+4kaKnsedHnOAhsj22q7FaEmaQ++8v6WIoY0kCREGLu6/pVTPwKCD5H87XeY//jFBtc4D
	FJ4XAWmMetzM/c0SASfueGG+O6VPjNEX070/JggX4hwC7WnK/Q+4bAETlqz
X-Google-Smtp-Source: AGHT+IHQUaQAuFKNvuH7uwmeyRiG08Rx2KLerYTfk5sUghQpE7Zwr7nVYIorRKJtFlyKPbrHglqgZde9hkHdiVRxyDI=
X-Received: by 2002:a53:a050:0:b0:636:a6de:9c50 with SMTP id
 956f58d0204a3-63f6baad20bmr1144271d50.43.1761605136059; Mon, 27 Oct 2025
 15:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-gpio-mmio-refactor-v1-0-b0de7cd5a4b9@linaro.org> <20251027-gpio-mmio-refactor-v1-1-b0de7cd5a4b9@linaro.org>
In-Reply-To: <20251027-gpio-mmio-refactor-v1-1-b0de7cd5a4b9@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:45:21 +0100
X-Gm-Features: AWmQ_bnlxqghxAQT0wbNVPkUTEMmLs4eXEoT8OGjcq1Qix4Xz6UIbZAIY5cu1rY
Message-ID: <CACRpkdbGM=M+ZLZ9453PLvTHkaHn-q3ota5C2gRD5bzoiezUnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mmio: use lock guards
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 2:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Shrink the code by a couple lines and improve lock management by using
> lock guards from cleanup.h.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

