Return-Path: <linux-kernel+bounces-780328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3763BB30078
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D129A17CB1D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B02E5423;
	Thu, 21 Aug 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXAUBzTt"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC612E5415
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794896; cv=none; b=SXo1qW5MIk5AlFz9PXTXWXn9Gr6sIWDsP5KFwh1GEQfU2IyA7MGqYvWE25G3B9EPVR3p64IqoXi/l9VXiUdL8omnDty2ECyk/7yJSH3dWZggQzslRyxeXCJ0ZHHGH6J5UKU9eRTuRroko09XZgspkl3kRrf6hdWBdoBlVmdo/dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794896; c=relaxed/simple;
	bh=JjgaMxWJ9qbUm0986PYJxcTgcZRuZyftO3FNY5Np63E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1YrpMCgIenz+EUqKpXTxPa1SBMuBnz2lKPgPpe7APivyWOI78rMEvBWW678oLAqv4vtTRnS557vzk9vTKJFAvmVTdp7UEIKhLBuRAWeJoaSZOWzxMwCoz5DSKRB2Q7ko5A+9VItCwG6X5k9qBmtPYeUxqTKAaSto3sBHN3vG8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qXAUBzTt; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3352212fefdso10170571fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755794893; x=1756399693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjgaMxWJ9qbUm0986PYJxcTgcZRuZyftO3FNY5Np63E=;
        b=qXAUBzTty/1Y3VZQ8f+s0JBk9dZnF84hMLcKWS/ta/DGSYHXwPzAmzuyr5RURVS8jU
         NS/QUOLBZ+KmovR5FA3YWhXrlHzZIibRR/gMASYqtQVHsU6i+hDGSg6/mdkKreBI7lfs
         DC9tSc7b+xW0IRt5K9AWLwn61MDhIa5UOER8wTPwNd1+kD5d/1Jkmh/p9hopa4iUoBXM
         6G3sYULdSj0obmTvVkafQRDQMmHZKREJSZv3Y4J+lRLyRmyB6Vf5JlJvoTlaLgHORI+E
         so5LdAFQkTevhccS6NnikkMCawP50VIq5aJCGE0bY7lhqC0PWRd9nqXXUOKazATDY8SG
         Mpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794893; x=1756399693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjgaMxWJ9qbUm0986PYJxcTgcZRuZyftO3FNY5Np63E=;
        b=l+vmYiADNKm+/N/a9Dc4KwCego8L01eOn5v+aK6Sfwy8kiaa7ZGE2N9NkCyfZferR4
         fpIormCCB3JSVCsuQHTA87+K9HfyO/00ILfCkJnSaBmtrsnLbXj0k0VLI34hyeijWbyj
         3FMChPXaBi/W8i0MNqfQco+2+zSIGWVRIQLuZxYRGAVIEFdUOTihylgAI6a8pZuA0Zfy
         N9n+h6rv5Or5kHszSKhBsovcbr66OKWUuTChX2+xol2C6rKFJtqYkbHk+TLPC7uJW9Oc
         4HzvgGaADbm7+RCZkpVO0uL8VqP3NLrE7VwZtU/fOq5WlSlxsQoNF7Uilxx3EEBAg5BM
         oOKw==
X-Gm-Message-State: AOJu0Yz5OqnR3e6YW/l2Orta8Mn8cGTy2AgJ3NCqs+yo17G4fwPrDe+e
	zGL03TJhqTg3r4fZjvcrIPDLFpVi2tIFBTiSmIm/EKDHYuIGNems0Q1YEVaYT5WKvkH8yqUjcKR
	ju69zYi6Svq3GyUFhp4/50W0oXq+lfAK9z5/Py7rroeCKXnb1ZCBC
X-Gm-Gg: ASbGncvxUqbcy+aF0Ct+ocID3AvnJiDXtLfJDjycF6WH7kniLchvvvL4nfG01o7n2AO
	wWLm3E3/aOdkM4SdQYFy7VVKeEzRZnB0U+HJ7O/3tlI6se9QXyHBz2fByg0igTqaZlzvPqbeqYd
	VkGfz9bl+1PTsjoko7iouKxdFLyAMp9IbLum5bV/C5ZoR5N2UByRDvSO860Yj10rFyJH2lGO6nU
	wDYvvQ=
X-Google-Smtp-Source: AGHT+IG+3TRj8voJKTnwJVWxrL5l1oYpH/bU0LUo3gd5FaJMEzvePfb3DMbpBjz0hjYrM3LeuxGGpWK2HuDJsMGa8c4=
X-Received: by 2002:a2e:b88b:0:b0:333:fa8c:9aae with SMTP id
 38308e7fff4ca-33549eb715emr9619641fa.18.1755794892780; Thu, 21 Aug 2025
 09:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821101902.626329-1-marcos@orca.pet> <20250821101902.626329-3-marcos@orca.pet>
In-Reply-To: <20250821101902.626329-3-marcos@orca.pet>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Aug 2025 18:48:01 +0200
X-Gm-Features: Ac12FXyF_gVal52SyMhu7-iG4ESsRyyY1LZkPXX1dXgmWEJaBoPIOjMINHQJZMY
Message-ID: <CACRpkdbego5WMzPV=xixkfM1gfKoULxXLgfDiEXpz2dQUgw5ZA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] gpio: vortex: add new GPIO device driver
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Michael Walle <mwalle@kernel.org>, Lee Jones <lee@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 12:19=E2=80=AFPM Marcos Del Sol Vives <marcos@orca.=
pet> wrote:

> Add a new simple GPIO device driver for Vortex86 lines of SoCs,
> implemented according to their programming reference manual [1].
>
> This is required for detecting the status of the poweroff button and
> performing the poweroff sequence on ICOP eBox computers.
>
> IRQs are not implemented, as they are only available for ports 0 and 1,
> none which are accessible on my test machine (an EBOX-3352-GLW).
>
> [1]:
> http://www.dmp.com.tw/tech/DMP_Vortex86_Series_Software_Programming_Refer=
ence_091216.pdf
>
> Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>

Wow this driver got really compact with gpio regmap!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

