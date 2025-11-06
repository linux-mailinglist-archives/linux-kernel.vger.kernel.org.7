Return-Path: <linux-kernel+bounces-888789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B62C3BEAA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F184279D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A8734572E;
	Thu,  6 Nov 2025 14:54:19 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870F33E37A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440859; cv=none; b=tDM0CEHSEJ2DeZEMleR1UuceCBj391J6QY8X5GmCTF74vznrRNEG2UwZ7otpNhCTpc9eN9RnFcORze7cc7Hq3t4BDmMUBai8oxM7eZ3b9vXjqQCtJi9ySRsUkI8MYqIwr3H4xz10jp+3Gujz29ionCcq549oomS7tOgFCCc9sfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440859; c=relaxed/simple;
	bh=r79Q+HCPKXd52mcnj87kTRiQrunxhy1UKBzOf00q5GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPGD0ulTKM1VDxYK8Pz3urrK+hQ3Ml7BGxsL/rLoJEmuJ+cNFy6xwxFNR9PaIhDPwsYryFRBlLLncG7baFp8+MbT0dBaxxQgBX5D/OAEsx300L0zcRc/+XjMWHtBcIsYCTBsL1+3yFkoOZs4Kiy/PmnKcBE13ax53NIf2Lsj7LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-935356590ddso304232241.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440856; x=1763045656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFPkOy62CsvEABPT5ZNROGLn2vMQp9hQ8wMPm7mPqLo=;
        b=hntSuPhPcQ4NOajeiQGY+lAYlFgYnLuMqhWnolxcF4GHF4FS/zeftQRrcqy9FfxK7O
         lt2THdRPh+pHdbHe/AZH2H4Kn4hnvhM6umbt+upaYYWa0TpQkgreSr1p/jL6B4c4Mv+3
         kl05iZrxRy5CGPmWSxNFTWeKDOWHU22r344TffSI3iCaR+Od8i6COBk7hIb+5u2eNhed
         gRj3/4hNEt6oJsGXUXHdMb2JuJy7xawqyfBUFom9de1mNJFkLAVn6zTBMLv4G5VOLxRE
         1lc3qo9ZogaI9iBl1YcQqtmDWs3b7HB1+gkRodkfDQFxt6Pn1/Xi+m5BSP3xrG6SIrT/
         owng==
X-Forwarded-Encrypted: i=1; AJvYcCXVxvcMG3HfKMqWNm8Lts1nYd+LG/cyJRhSb7MuW1jB+Z8piNxzv23ug9EiP9/V/s27eIVGN/zSUh3s5Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ12BZ8FlmJ+nfN9PQ/a2UAwwI1aWXEhRU8JMGjfy1eChlfs4f
	lMVU1G8i193vUhLxgLXLm1TWFDcDROl0h2EO3EU84URA0smwkNxVIHs39nUFrxFaGZc=
X-Gm-Gg: ASbGncvAWGMHQGAUlefTKwntU98MVArogSljxskJVMFulUYRStTFqX0mw+bM1XSd2J6
	7d1nTUMXIUow1lNR40A0yOxJfFZZChK8z5gZASbImBx7jkcs9ZDxHyCn+qzT4Gr96uuGBJSkZr5
	/FslK6+sMb5/+g9NSUV+u7Xq1pIYtMQvXDxftRdOOUdbpYlP6Rtpiond0q5QWiZ8ZoKwf4ld6kn
	6MBO54Ve0Zz/iYTcWNZP+nYpa6TwvmD3Hj+p7STr34O3YDooWUBYoVaOrox4/MVM6QsQgLYjqZk
	R+27UOztTq/x+4HDsb6Pwjj8sac6+1ydirWqMZScF4h0TA+k5vvAtz+uroLSLkfd0Yyk3sopRMQ
	A9aNPNjFFp60iClbcGZ36stt6FHg1tVB0Mev3+gF4rXM8d2CtRFcqwXw/jvrZwKRq7/HMatudp6
	5UKB4Iof8gYMJeO2nNIt0Ie+BEmxey8KLz4WFLYjAqW0rhPYzv
X-Google-Smtp-Source: AGHT+IEUrRMZe2vwxOwO5ulirnNLyVxEpiMBRElwz26nYsZbDDAtEXRqmklv5Ee1Ccem0MUmpXR0VQ==
X-Received: by 2002:a05:6102:952:b0:5b1:15:1986 with SMTP id ada2fe7eead31-5dd89124c44mr2364309137.15.1762440856419;
        Thu, 06 Nov 2025 06:54:16 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dda200bbb3sm1096964137.11.2025.11.06.06.54.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:54:14 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9352cbe2e14so313607241.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:54:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKZ19Y0m/JFSSqVl8tBHDjk3RqZ3h93T/lcwsSD4wnuQQP+7ePYRXqPZpdIAv48bzSr2JPG4CpPwaegeg=@vger.kernel.org
X-Received: by 2002:a05:6102:b02:b0:535:2f14:ea5e with SMTP id
 ada2fe7eead31-5dd88ef0717mr2314262137.8.1762440853361; Thu, 06 Nov 2025
 06:54:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106143625.3050119-1-claudiu.beznea.uj@bp.renesas.com> <20251106143625.3050119-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251106143625.3050119-4-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 15:54:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWrYRqLf20z7wR7KfL870j4HigCU6BQ5_Of7-sEszfrMQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnu0EVBs5ig8TaeiRn2O9F3MIOheFSe3K7OvivAK8VjmRCtCrf57Jo2kRQ
Message-ID: <CAMuHMdWrYRqLf20z7wR7KfL870j4HigCU6BQ5_Of7-sEszfrMQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] usb: host: ohci-platform: Call reset assert/deassert
 on suspend/resume
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: stern@rowland.harvard.edu, gregkh@linuxfoundation.org, 
	p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, kuninori.morimoto.gx@renesas.com, 
	geert+renesas@glider.be, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Thu, 6 Nov 2025 at 15:36, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The Renesas RZ/G3S SoC supports a power-saving mode in which power to most
> of the SoC components is turned off, including the USB blocks. On the
> resume path, the reset signal must be de-asserted before applying any
> settings to the USB registers. To handle this properly, call
> reset_control_assert() and reset_control_deassert() during suspend and
> resume, respectively.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -280,6 +281,14 @@ static int ohci_platform_suspend(struct device *dev)
>         if (pdata->power_suspend)
>                 pdata->power_suspend(pdev);
>
> +       ret = reset_control_assert(priv->resets);
> +       if (ret) {
> +               if (pdata->power_on)
> +                       pdata->power_on(pdev);
> +
> +               ohci_resume(hcd, false);

Same comment as previous patch: if the reset_control_assert() failed,
what are the chances that the device will actually work after trying
to bring it up again?

> +       }
> +
>         return ret;
>  }
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

