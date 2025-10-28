Return-Path: <linux-kernel+bounces-874406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E467C163B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF84C355DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F50934C142;
	Tue, 28 Oct 2025 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Jb7YK/tX"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA92345CB1
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673222; cv=none; b=WZsZYkzdoWQAi87ULIWfJ0qeeDb4MRW0QeAY+cHelGjDPcJO0UXzImmJpuo3GFCS6HXzkWstCfp5qlOO82JWhUhxgKvHw1lLZtCtHZxvG83mPuG7pQ0S0kYkqSFb0HjAJY46EhJvOzPvZx+lxuj/Ths2vBLcdY59+6X0hvsZkTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673222; c=relaxed/simple;
	bh=aXUMeXzMr7+pu8Yf59D4UfcQD82Ccm+D67e+43HI4bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuxfRFfby5N6pOHdReH1yJYEvXGx3blQM++VxRTJCWF+jLzxhWh5RhPo3ODV6AsBTMDqhU0ZKH5oW4wUcUTiMfcO0mPAA3RGCHJawz3BAzFFsDahcSM3HahI5/Xm+DsavcKQCrGjI8GrFj0TnR7o1zdJyZj7OoOO+JJybl0D0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Jb7YK/tX; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3737d09d123so87178541fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761673218; x=1762278018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1dDT+Kuo18gW/vAs5pcbkOprB45nObDwGH/xrxPOiA=;
        b=Jb7YK/tX/NExrWrnnfEsvBKPDaXpc/KVGXJh1wkHCo4Zfs/c/o0rSwNvp11ctUHn0m
         Y2c/NFQCsQQpy7HyA24SMs5VAkyjRHaVj6cx52it3B5UwRa5FwpvqMmGjS+BCtlukMfG
         Um6dQl8jszRUVksnp6ZuaksjsS0ApRauEtN2aUIeeXDFbsCz16g/8ARsSTZyfFQvQm0k
         rkNZxp7xYTscP6u9+d9+7qs1ITpxYc1tf60x/tHJHk6omM8I9vkni4qVhyOx/zWpj4cR
         w7GLMo1m8WVXIC720BeQ9aH/dSvIrJ7qvIjqHLbQPOL4qD4/C65l5N1hFAF8ScwUn8O2
         ApfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673218; x=1762278018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1dDT+Kuo18gW/vAs5pcbkOprB45nObDwGH/xrxPOiA=;
        b=oPonnF6qC8WROQ2bb8T7NAUZUAxt+A819JdQLoVdMvHXKN2O7otATQ9e4R41J/cn1K
         jQ55T9QBonVTcTy2cxzSB6EGgEMOh6mIYBtOF3ar83FCbbLQQw5h4HEC/Zr/cBFcpBpn
         VlJLutuHlf1DP9aKW7KE+11bPkWQHqNmK3dh93i0tTqMdPPtLL2pO9etM6FGYTrBvZDt
         TuNXzF96fpmbreEXYeaXm4sSk1jL72WaINFzXv3ykUBsrC0Xyx45dIPjMz/d2oG+F6RL
         bjJYAeia0gvokwVOwA3T0WzKJ+Mm+vM9kj9W41ybqskxHtvlLjLiIhrnY1pLMmjecwp7
         IveA==
X-Forwarded-Encrypted: i=1; AJvYcCWMeOno2SD4iSFEMubSDV++J6jtp7F3SUI8gSpfzPmcb9Wn0ETA8Dsxp3+AW4EXPKtbbZK+ag3ck0FnEfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuLyO+hZW+DK384DIojpaTX8dDoYVTxqOZ1Hpfn9BEHwQ8W012
	p6Sn8iTngytmJAgunSdKHyxH9KyrS6BOkT7ASt/JLLv6t6apTsY01H57r8bMYQpnFlUVWArQgw7
	/pHvUgWuYocLbqg+nivzYUZWFtp8ouNYizrALUP0h3A==
X-Gm-Gg: ASbGncuPobtYF9AOnzqWQ88uGgfBBddeNk0OF4lMsldlkOVKCSS0YbHdHgcmI95RQwG
	J117V/DOo062DskPBl6nGe2HYpn9N/dVymdiVhh3Hrbq+yZreDPnENpu3hepI5rjrv4VPAjDGUq
	tzp5OU4A16DyOuMM11WgYVVwlJAqwsc5dxpvxvhzwnKB0zEb9DrvSIhIqu/n6VohwMTlbhKah9u
	KIPLn/Lut1YDYZB5hvBjz3fmWKECdaOf+wCWEgEOTiEWCi9a+T73ivd4yjcA2z2NCWCmFI4Pffw
	DapAG14+rjM+2GVggshxuS1fQfQ=
X-Google-Smtp-Source: AGHT+IFNOY7fS5NXoOFhyNJtmea1wSytgnH4oBkJVvZ9r27nhCdq6OSaGfOh73lSEWuOWGB7Asbt73QW9CvKZgTz/nE=
X-Received: by 2002:a05:651c:4347:10b0:338:10c9:5871 with SMTP id
 38308e7fff4ca-37a052c83admr689201fa.34.1761673218316; Tue, 28 Oct 2025
 10:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028155320.135347-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20251028155320.135347-3-krzysztof.kozlowski@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 Oct 2025 18:40:06 +0100
X-Gm-Features: AWmQ_bkhwYP_3u9-JoVziAs2Bk2afMmvyoh0mwlsnq_68htCAVlTBlNvVkP6s1g
Message-ID: <CAMRc=MewE_wRrKsbo94GuwrO2D=1L==3ceJBKXQXvLgiqhd7Dw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: MAINTAINERS: Add Bartosz Golaszewski as
 Qualcomm hci_qca maintainer
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:53=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> There are no dedicated maintainers of Qualcomm hci_qca Bluetooth
> drivers, but there should be, because these are actively used on many
> old and new platforms.  Bartosz Golaszewski agreed to take care of this
> code.
>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Link: https://lore.kernel.org/r/CAMRc=3DMdqAATOcDPhd=3Du0vOb8nLxSRd7N8rLG=
LO8F5Ywq3+=3DJCw@mail.gmail.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Changes in v2:
> Don't orphan, add Bartosz.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8abdc0e50699..8a2c5fb0ba55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21145,6 +21145,7 @@ F:      Documentation/devicetree/bindings/net/qco=
m,bam-dmux.yaml
>  F:     drivers/net/wwan/qcom_bam_dmux.c
>
>  QUALCOMM BLUETOOTH DRIVER
> +M:     Bartosz Golaszewski <brgl@bgdev.pl>
>  L:     linux-arm-msm@vger.kernel.org
>  S:     Maintained
>  F:     drivers/bluetooth/btqca.[ch]
> --
> 2.48.1
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

