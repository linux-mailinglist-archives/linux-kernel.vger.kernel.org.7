Return-Path: <linux-kernel+bounces-892707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6ECC45A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4EBE4EBF42
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4792F7467;
	Mon, 10 Nov 2025 09:29:40 +0000 (UTC)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD041E885A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766979; cv=none; b=DeSlGHoVu7NpFjKNrArCV8gL56LQHVEYjNQzFXLJlAwo+K+Dewx4i23jA/6/pqHbDaCcuFkBfx5SrSedKI0neRIjmUvGhfaflYMu9Xlwnloo7laO3qIjiD6OP3qwuDW/QERD6+HbJ2k+x0rwJO7/Ts0ygVit1mfWRvQpCnZfIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766979; c=relaxed/simple;
	bh=nJZPrXQKCl3bu6wUeQ/MI8ozYYEj+PYCSxFScA/Ei2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSBJnF6XdLC9/gdHxewOjx+0kVmB2dF9L5CYezTId7s5RagZ1p8tzRoBpbpouMRDfxEDJbwl89X+E/i6/H53jFB9GDahtJ3CO39pqa1WtaXSel5VN8UM69DaSKFalX/q7HYsJTjorNjmx4fIJr4aUjvke9ASIHDrFcWuTH/J2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dbd1421182so2292517137.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762766977; x=1763371777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/UF8iu/Ap/e6A6upppHsnZ+gquCWuIoNYkej9XhChM=;
        b=UHf6gSyLQUiujfiCS6hEwrE1ASmy8VPDoIoGl/x3XcZPH4c0zjDz+29LnGxHJ27mQ0
         UcLjGhgr8+0uE2xAZ5whBzxZpLS8O+Hl33KHBnUd13Ah88EaOZySpJYSVItiAfTr+qki
         RYIyVSKHz/CTgIjCNfR6JojCmigjBx98WwR/6gCsPUKFEahrvEA+00cvgO7Eac0ouj3N
         +1ZJiFjuzMsw4eQ3XQuYqxkwCMAVZgK6M/AOX+8+6qUZ8LNTck4rFBNDDyfFuS5BkuwY
         j/2ebr3Bo6Hg2DerCSTQy6AU8YJDeNMl6o65OereegHSi5Vc2w5FsaEIXiUtkYzDNgZT
         ZBhg==
X-Forwarded-Encrypted: i=1; AJvYcCWlwKQLDgpAtXCpp8zHdx9dKW7haWZhtG7APHRI8lv1PPXpDP/B+oMHLobV0k8yCvXSQVpS1bbxlwUnU8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnokzxXgHMOrPNogd9xFiMI8PVXuNUDrI7diY9//mhOGFylnqi
	rfKxhbSUfMjWhgfR93mFnzRK9RW+jZt+mAiJZIZe+wiENDg2KLGQmVCudBOVxfdI
X-Gm-Gg: ASbGncuJvPyGBC8uUUtfx7IyJAvV0VD4Iq5jryLbmVW2w8jImoPD8l6dYrUBIgahBPv
	Nm8BvhyAXuHN3F4NZkZKf8UfnqJmhh8tgOV0kK/E797R377f3RoHWOWo2OWFd6lFNQGQzV6oLdX
	a4/vu7g8oVuYJfz8yF2rFsYmBBZsgo35cYlVu27JBj26PIbZu71eeERA8uxDwYjc3XVyLgUalKu
	eTRoQmRuTFIfPxLrmrpU9hsPC1sybhtyUTKrNQ3h+pqGWTGD0oi0nGveds2Cjuv2xRHEMCpqsYl
	pX1nRDsrwUH51OJDVnFsW2UK48tAA4QmEbw6JfTJ4EXcQbYl/IwnINVGqgUyyf+vk62Tf05O5/3
	fzf1zveju+V/V9UV/UaDSVXomKekdheqQNxChC5dyUh1GiPKacdyH5ju5FxMuvxfjlTiD9PlVWU
	i4KJcUhe8oPnpMvsDmiNe5gPV+LCEG8i4kFdPMBfXwSGy/14jrozhv
X-Google-Smtp-Source: AGHT+IEOlhtblRe+jSAaVGtEBwX3MlcnyV56n49fbgoyaz1p4gwgalXtPwtRrqlUJMZwaCmiV1KLaQ==
X-Received: by 2002:a05:6102:41a3:b0:5db:2715:d029 with SMTP id ada2fe7eead31-5ddc481426bmr2264942137.43.1762766976691;
        Mon, 10 Nov 2025 01:29:36 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dda1d72ea2sm5546745137.7.2025.11.10.01.29.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 01:29:35 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5dbdb139b5bso2567021137.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:29:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMVZdIiZw+EZjGMGNJg3H3vckR/vN6yklh2tGIc12H/qs6LDrXeeVLPv5szAn6sZwuKh6wpDD7Ri0aMYM=@vger.kernel.org
X-Received: by 2002:a05:6102:94c:b0:5db:d07c:2199 with SMTP id
 ada2fe7eead31-5ddc4814cf6mr2252763137.45.1762766974788; Mon, 10 Nov 2025
 01:29:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106143625.3050119-1-claudiu.beznea.uj@bp.renesas.com>
 <20251106143625.3050119-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWDGpqdhCsA0MJqoL1JAiyVR-TA2YqDe+-S9Xf6c5O-gA@mail.gmail.com>
 <64c74f86-7438-49da-b164-a8a113e47c32@tuxon.dev> <CAMuHMdXG8w9jR9gr4av15VT69XNouqys5z4Rxx-nidnvnbN3dA@mail.gmail.com>
 <5edec052-5e65-4d00-a182-6675ce579be1@tuxon.dev>
In-Reply-To: <5edec052-5e65-4d00-a182-6675ce579be1@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 10:29:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVqaQ=E43Wrg7GtDD_MGS5ibF9o1DfpDCAq-=F=Exph_Q@mail.gmail.com>
X-Gm-Features: AWmQ_bl0zJyAvgz4Lr7-qJXghMxi7mBu6IDH_qPTBnyifvwjHPzf0BSzKBRfv30
Message-ID: <CAMuHMdVqaQ=E43Wrg7GtDD_MGS5ibF9o1DfpDCAq-=F=Exph_Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] usb: host: ehci-platform: Call reset assert/deassert
 on suspend/resume
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: stern@rowland.harvard.edu, gregkh@linuxfoundation.org, 
	p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, kuninori.morimoto.gx@renesas.com, 
	geert+renesas@glider.be, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Fri, 7 Nov 2025 at 19:42, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> On 11/7/25 10:01, Geert Uytterhoeven wrote:
> > On Thu, 6 Nov 2025 at 19:56, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> >> On 11/6/25 16:52, Geert Uytterhoeven wrote:
> >>> On Thu, 6 Nov 2025 at 15:36, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>
> >>>> The Renesas RZ/G3S SoC supports a power-saving mode in which power to most
> >>>> of the SoC components is turned off, including the USB blocks. On the
> >>>> resume path, the reset signal must be de-asserted before applying any
> >>>> settings to the USB registers. To handle this properly, call
> >>>> reset_control_assert() and reset_control_deassert() during suspend and
> >>>> resume, respectively.
> >>>>
> >>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>
> >>>> --- a/drivers/usb/host/ehci-platform.c
> >>>> +++ b/drivers/usb/host/ehci-platform.c
> >>>> @@ -454,6 +454,17 @@ static int __maybe_unused ehci_platform_suspend(struct device *dev)
> >>>>         if (pdata->power_suspend)
> >>>>                 pdata->power_suspend(pdev);
> >>>>
> >>>> +       ret = reset_control_assert(priv->rsts);
> >>>> +       if (ret) {
> >>>> +               if (pdata->power_on)
> >>>> +                       pdata->power_on(pdev);
> >>>> +
> >>>> +               ehci_resume(hcd, false);
> >>>> +
> >>>> +               if (priv->quirk_poll)
> >>>> +                       quirk_poll_init(priv);
> >>>
> >>> I have my doubts about the effectiveness of this "reverse error
> >>> handling".  If the reset_control_assert() failed, what are the chances
> >>> that the device will actually work after trying to bring it up again?
> >>>
> >>> Same comment for next patch.
> >>
> >> I wasn't sure if I should do this revert or not. In my mind, if the reset
> >> assert fails, the reset signal is still de-asserted.
> >
> > Possibly.  Most reset implementations either cannot fail, or can
> > fail due to a timeout.  What state the device is in in case of the latter is
> > hard to guess...
>
> In theory there are also failures returned by the subsystem code (e.g. if
> reset is shared and its reference counts don't have the proper values, if
> not shared and ops->assert is missing).
>
> In case of this particular driver and the ochi-platform one, as the resets
> request is done with devm_reset_control_array_get_optional_shared() the
> priv->resets is an array and the assert/de-assert is done through
> reset_control_array_assert()/reset_control_array_deassert() which, in case
> of failures, reverts the assert/de-assert operations. It is true that the
> effectiveness of the revert operation is unknown and depends on the HW, but
> the subsystem ensures it reverts the previous state in case of failure.
>
> For the case resets is not an array, it is true, it depends on the reset
> driver implementation and hardware.
>
> Could you please let me know how would you suggest going forward with the
> implementation for the patches in this series?

Up to the USB maintainer...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

