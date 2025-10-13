Return-Path: <linux-kernel+bounces-850772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38BBD3A86
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32C7189FCE6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019C52FE58C;
	Mon, 13 Oct 2025 14:43:06 +0000 (UTC)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5374277C8D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366585; cv=none; b=HjyTJ+BxdG4kvUcsyuU5ElhmXEJYcVDyJwqBKVFwF0Ax+p8CpJ35XJtRdCgmR7woS7go6/HZwQV48ahoFY2IBDEQmfDn30mex0h4YbxFgVIo0aMD9OJJsVTLKxMf/23BIr2S6PFgskXZ/4lBphfogp3iqNK7jsZDRCVedlY4QKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366585; c=relaxed/simple;
	bh=a8rzeaiQ54tOFcMOe+sIUa8tfmcif5r7xjlXNM2RFaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLj76vNx4NKPK0tqVs21AkxS0Jx+ZxTCkJEx1tCVMEG++gaB1KFKtXCdETFRk6r/8pNAmqxeriywr/W1rVCLbCkkDb7U5cDBnCMxEYFu1IXZg46MkURFs6KitYvBzkaFH7ofAROJeattTDwqE7A+fySMrdttgOeP3+pR6+4nick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-59d576379b9so1806722137.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760366583; x=1760971383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BF1nvJKgerbunlxq6rI58NsjqwKmmQvTj5E3RRtPIQ=;
        b=qDS1BWROksgafWvsSy34C8pyLPtMlzO91fabW3WyWmvqpJlUMcqHuF2LvJuOaQh35V
         WrGpHKCafRtJM9sDL0AV48unqhTOg/sVNlHF+8u5nJvtOjNS0TzT/Ltj8buRRlkHKtkk
         xkhwkUMcE7YyOJTDJ2q7Tk5ZrO7c9G+0UovBfsiXHW6hhJQ/OasBJsrHbyhlRO7IkLz0
         gmTCTlF25o+A7CUZvJiT25Bj9PVTQx9celL2tCrfoCOjN6uqc6zdOdC9Ef/ntbJiL2fk
         ypE8Shs0T8uDNUGoDo7jA134VTRHa9ffkYrUUDetFSp8X3vRmtb739aVrnurX62gMQvp
         5YFw==
X-Forwarded-Encrypted: i=1; AJvYcCWtRdYTU+0BaKRz2jfwutYETKyHzIjkCEL9naZidrOFAiyUcQz3r7W/2ITpjzd73xi6DTDtwjlPcz4pGEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOh7+WNlcKmQlBg+6KNJo9oV4jCIyz7oyQ7dQqPOX2ybleotO
	lFdfsd5e+wN5dLrjsbjC+afhhR42SBj4wjXNZj4rolgLEmrEiyzCNke2U6oXXgzH
X-Gm-Gg: ASbGnctUjb25R7wZPjaASc3gd7bnS9jCzzsGFW7y8wg5DJ2OeufYyP9qpzn95ukOEnY
	IxFYWJe3fvbSa1zELfGsilOzvAMkNcFfKjp3Qg25/mPVJcNgjB07JCBM+KQrp3OZk0ZyAMpRXwF
	vvZz6rEfMk89qic75Q+8Tgw/yNcnlgKWguL70Y/OarMP3erUG8aNryy0dnZGILVsV/j0G7A47f/
	5MnOqvAF6DwJqvzLaf5n2eKA78PCYWexVvtdmhxCQ1ua6yvrxhPNc/O5XoBJYGhkO1NLbUIDBJK
	e3uQ9nkOfiBC2eFtoxM3nTz+oGlXsJMJdMDkVggdb8pj2634Ao8zv2qalyBMjcrzIKGXnbvp/5W
	WxukVG6QDPNcDseX9qpQlPwD1oHj+xWLiJF08C2YHbjholzIuDk2mxEzPg824WOVcCBbksSpNtR
	n+D9mV1VBeBbu1fw==
X-Google-Smtp-Source: AGHT+IEG7vRox6O2n7JsVOqz+XI7gVALs6RmBH+m1K0pepB+uDdeQGQG2tNbrWCuwboaSKXBHHotKw==
X-Received: by 2002:a05:6102:800f:b0:522:194f:fcd7 with SMTP id ada2fe7eead31-5d5e22b6002mr7242266137.15.1760366582688;
        Mon, 13 Oct 2025 07:43:02 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc716413sm3340534137.6.2025.10.13.07.43.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 07:43:02 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-59f64abbb61so1745866137.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:43:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVqOSIYrNvX9HkGnCrX7bVOtWojXLC2Tujz/yGpd6x8zopaffKZDNAPdMtvEnpy88YpGqCE1REEO3S9vs=@vger.kernel.org
X-Received: by 2002:a05:6102:598b:b0:521:57e7:3b19 with SMTP id
 ada2fe7eead31-5d5e23ad946mr7466194137.25.1760366582403; Mon, 13 Oct 2025
 07:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-ptr_err-v1-0-2c5efbd82952@chromium.org> <20251013-ptr_err-v1-27-2c5efbd82952@chromium.org>
In-Reply-To: <20251013-ptr_err-v1-27-2c5efbd82952@chromium.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Oct 2025 16:42:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUw4x4GxxZ+m+108rp+_uiuiNFHO4Vtrd3vftb_LwmCLQ@mail.gmail.com>
X-Gm-Features: AS18NWDbEQGWUFg0r_aGxPQP6vUjubUz4v9cHDpfk8kXxZq-lj2695LEwK7MQ10
Message-ID: <CAMuHMdUw4x4GxxZ+m+108rp+_uiuiNFHO4Vtrd3vftb_LwmCLQ@mail.gmail.com>
Subject: Re: [PATCH 27/32] media: renesas: vsp1: Use %pe format specifier
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Leon Luo <leonl@leopardimaging.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Julien Massot <julien.massot@collabora.com>, Jacopo Mondi <jacopo@jmondi.org>, 
	Daniel Scally <djrscally@gmail.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, Yong Zhi <yong.zhi@intel.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
	Tiffany Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
	Yunfei Dong <yunfei.dong@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Rui Miguel Silva <rmfrfs@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Martin Kepplinger <martink@posteo.de>, Purism Kernel Team <kernel@puri.sm>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Dafna Hirschfeld <dafna@fastmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 16:24, Ricardo Ribalda <ribalda@chromium.org> wrote:
> The %pe format specifier is designed to print error pointers. It prints
> a symbolic error name (eg. -EINVAL) and it makes the code simpler by
> omitting PTR_ERR().
>
> This patch fixes this cocci report:
> ./platform/renesas/vsp1/vsp1_drv.c:958:4-11: WARNING: Consider using %pe to print PTR_ERR()
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

