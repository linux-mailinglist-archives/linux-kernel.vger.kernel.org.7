Return-Path: <linux-kernel+bounces-844682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F914BC27CF
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D9374EA5C2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D4122A4D6;
	Tue,  7 Oct 2025 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agGhPlZJ"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2245CA4B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864818; cv=none; b=ZoNEAo2NW5HWMvUzeFYhEp6zQinzxKrCAlcvJ1HFOI8hi1MeEcoyvoe+V3QolEA+72hazl9YOg4dz2pxw/yILIp/Wbgy8foA7aFFKjyf/J4au5JpBiEvuiBHqZ8Z6uhHzA7jx5cBeIS8g+v8AXqVmsyprsSSnVZ6R1WEJHt2hIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864818; c=relaxed/simple;
	bh=EiImG7GpvLr04lXxcmldheIyewvjHETXWh8n7xAqUho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugQHVEw8K3Tu5OWFlWz4xCi9jE5YrWOapEF8QIQhmGQj17BEAd4+WsoVJb53iy4uuiwK9T59tyWi3mNZlPW2omCRAUqyK2hHUGL/5kMR99LzICqWys+XN9JlO7f93fmsK7AZnSGGgSNOkAWWCriAg9FICgb8oZ/vgqtTXlqffdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=agGhPlZJ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-73f20120601so80216657b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759864815; x=1760469615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyvVzqRAZ+jJPuuow0tWhdGCSI6e0A8fiu8e4y33sz4=;
        b=agGhPlZJouEmh7XJJ8F6Sj+bHYwabcgqkpE5K3goS6PLlJ8RxyN9l0pHkpEi8X/YbI
         G66eIJectbfH1jLntf6fSmsL8K0h0CN8/kf04t81P9UYAY74YY9NW4kb327uN4fyfl3m
         70mJCZmP6vfFDUuAGEU9NdF2UD8UX5261Q4Fe1ptfKOfyFYHqM4GgK0mYPMRriVXW1Vj
         lmH1mK2mGfzs5v4az8GFh1djHyytG3mUCPUuXemq6x21wYBeRn1l+nFBcIb4RS8dOEFu
         yx2ux87w5YmUUJI+WBGcJX2zc5yAw0/izU2X286avg6UqHMmdEGWhsA9l7KIVJzc3Y2/
         xYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759864815; x=1760469615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyvVzqRAZ+jJPuuow0tWhdGCSI6e0A8fiu8e4y33sz4=;
        b=fUhU6/otPFyX7Tb0vc81qe146rUwUl8n1RONhlkyvAXaCKno9rCXtZIi+8ckBxo/Re
         9WE1FYKmjTU71jvDg6k+boqjiYc0u4eUgzVMu3oNRa/txOAPWqRIjgxOodmzbZAfU/Zj
         v21zg/NM6pbuDjhqLkWSpbPv5mnC2hbOgSeBr4uzdrDEZ69FADRcXrqM+U3lHNQcnJ9J
         FFy1lAN9vb7kEmCuZK9nkVnuw7mBgWF8Lt6tHlYGqFY5m3XYcskI9umWSmqA3yZZ9Jhi
         rhAO8bBwIQFN/XlXIr9Uo+JCRgyoh2dhr7jBaNe6dhoNKJ40T0r+bc2OWf1cbtUpuU+8
         qs6g==
X-Forwarded-Encrypted: i=1; AJvYcCVukNXWN9oHxEMdTKii785VqDuG99n/ohOXOn8tXkbkA8M+CVDGHPgmc3M89H64/mnEpiArNF2QiOyx2tE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2yUloOrx/nfUdAirUrgi7xnPg0XH+z2t1zPQpZrKU1ckFQSkW
	QQwwLuYIR+fMVxhG3hvhDG2PwysrDCkwoc86/3xHkCOEumeSK+egvmqwfrzXxsPM218VEEUAhtk
	VZMpefiKWkfs4b065o1KZnNSVX/roTZelFQEYVlDPYQ==
X-Gm-Gg: ASbGncs06QMv0U1boi1H/ob/xnE85U6rHh7uFJuSX3iANEJL4j7n8GjO4p2d9J8GwCT
	fNoZr9hA+EU/IDwJCn+TNBTGOeNuORK/KydLgXaBEjEknQ1HAMfybB8gqi8gWhgfRwEUyJwDd6M
	N1gmKujRaJiRWy4/JD1dY5U7OjTorL8jUfva9N9yFoVvRUsjTKw5bb4LHMMo7Xi6jTZ8HyApTzD
	AqafVIx9IDHaswRwVDUV/zR5UIy+R3RrZH4Po8pvcSW
X-Google-Smtp-Source: AGHT+IEcS4H3ART7XbkyRLcIVlRN9ttSIKXOMErrDhYI7itdbz36cK6980ngyigAxI0SbIW7DumJI/JYvN83SQijQyM=
X-Received: by 2002:a05:690e:c8:b0:622:7517:af78 with SMTP id
 956f58d0204a3-63ccb85338fmr715381d50.13.1759864815549; Tue, 07 Oct 2025
 12:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-gs101-usb-phy-clk-imbalance-v1-1-205b206126cf@linaro.org>
In-Reply-To: <20251006-gs101-usb-phy-clk-imbalance-v1-1-205b206126cf@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 7 Oct 2025 14:20:03 -0500
X-Gm-Features: AS18NWCtEcLGJeO6dNMCbDSRSbiDXW6f_hsYoSbqLJrQg-Tj2Vl72UtnnpoTtMI
Message-ID: <CAPLW+4mT+BcK+sLTenaNP7T3iFF1yXj4kziSYiJx2gOYV2NSWg@mail.gmail.com>
Subject: Re: [PATCH] phy: exynos5-usbdrd: fix clock prepare imbalance
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 3:07=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@li=
naro.org> wrote:
>
> Commit f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend
> with UDC bound (E850+)") incorrectly added clk_bulk_disable() as the
> inverse of clk_bulk_prepare_enable() while it should have of course
> used clk_bulk_disable_unprepare(). This means incorrect reference
> counts to the CMU driver remain.
>
> Update the code accordingly.
>
> Fixes: f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend wit=
h UDC bound (E850+)")
> CC: stable@vger.kernel.org
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsu=
ng/phy-exynos5-usbdrd.c
> index a88ba95bdc8f539dd8d908960ee2079905688622..1c8bf80119f11e2cd2f07c829=
986908c150688ac 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -1823,7 +1823,7 @@ static int exynos5_usbdrd_orien_sw_set(struct typec=
_switch_dev *sw,
>                 phy_drd->orientation =3D orientation;
>         }
>
> -       clk_bulk_disable(phy_drd->drv_data->n_clks, phy_drd->clks);
> +       clk_bulk_disable_unprepare(phy_drd->drv_data->n_clks, phy_drd->cl=
ks);
>
>         return 0;
>  }
>
> ---
> base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
> change-id: 20251006-gs101-usb-phy-clk-imbalance-62eb4e761d55
>
> Best regards,
> --
> Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
>

