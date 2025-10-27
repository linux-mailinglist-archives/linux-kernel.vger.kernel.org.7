Return-Path: <linux-kernel+bounces-872291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C59BC0FD7B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DD6F4FCD39
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CBA316911;
	Mon, 27 Oct 2025 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqw5m9xV"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C233101DF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588174; cv=none; b=hko8e2GM6CtL3qgpVwvTPorIruYTkI3kGZ6CQGHQPm2WXQE/IPl7QRUNylt6r7a8ZnwG4krhHloHlhmzwR5N17IK5nL3T1jsPv76Hebxx71rIDLJhj474ZAnFs9TepFbg76gh82DNeLWJLfCOiIZ253prpTmnIvwrGXEGBoPqDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588174; c=relaxed/simple;
	bh=LvP36OFqg1n8BtKv/l9bCO2uLiZFM2W8O0LRWvjaIRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyBaPSvBuk3Md12DbIU7KPq3ytsskW1MmNhUHlHIhHFK3qj5y7lj1ilYJSWcvurmwJKNP2V6R08nU56pX2ycldJjx0q1B9+/GaVwt4EoAnOePiQWW8FSWcnAjHOyFeYKovnKgTMMsYU63JSAgf3C8GB5TpNbEcr9IdDk8aASGPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqw5m9xV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d5b756284so1050398766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588169; x=1762192969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=keQgCiVBqugDEVy75un1KzT9J08z1JpEGApwh+kNxek=;
        b=lqw5m9xViL14XfWCA9IYLvK9rauu1SJrWXaIsv4X/vVIeR3be/1BxXALbqRitr50iA
         XzoBP34LGbZZAbLkId09tCkwv8llCoHG8cn6HYWskNnzInqCvdksjV2xQNZFjlcbU6VA
         EMoIcSyJbJYcrFOHuUTrVY1P3uyu43inTgIZ58lF0l8PUj3rSL0R/yb/vX173B75EiaM
         7WMQpwMLIab1anPpDNv2AHeZHomeRQnrWs5phQokU2+NoUFqcwzDJkW3/RXgDnsCxUVj
         GLg2rX8k8HR+BIu4Iu6kYcV4A64+FPPV0SHFpQSxWbwXPI86NI+5o2kQr3GuS5KcWI+L
         UbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588169; x=1762192969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=keQgCiVBqugDEVy75un1KzT9J08z1JpEGApwh+kNxek=;
        b=WjKeDYxaxLZQUIpUCaOsPX9+CS16Kcknt8p1CP+yGsxSHli/e7Ucl8fG5zD1/xttkr
         zYFrYnBIVd/GBPjJITWQpt1uU/p8rLNpxGfkyYgGF/wAwFq0YhMNOlvkPi2jM+0yxfaz
         9yxg+2B2F3i6O0LIZEZAB2BveChstQMtecJtGASI0+XcSqgBp538Z6KoZDLFa/oy9Skm
         6R0xGZ2P3VfXkA5XXT5nriYtWRl9ZfuTiBt/3qc7v8MksCgLNbJ2A04FNS/ggw9L8hLz
         IBPLCz3kz+38VhPpGC2ouEMRhrOM+GEwXyIZPPpb3LHYuac19rbYoZUlQUfj0+Ksjfo9
         7G9w==
X-Forwarded-Encrypted: i=1; AJvYcCUCgxVDOuzFYRQSxS4y4PaXxN5TiechxYuvjQJ+fzMdY4BhHIPymBzSiu31qEnZJc30gblk/cBjXAo0HU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+wzyEA1G6Yg/f/S2spdQAprhYr7ehRx0j9Qc2YOpp/CRxmgLw
	Oui4CjPnxg0oq3G9Xp4ULEP9HxGDbwT1nLmvmbqZ5JSmhvj8cz6kmJs6nmgTThw2u866W27NIdM
	xHWN7+WL93aAtZE5P9KpLKZDIWFX13PI=
X-Gm-Gg: ASbGnctZlCu/4IfyRAW9AQvsf46+2cCuHdB+J3RnJkn5bNfqSyKB3cXoBxv1XrS0EZa
	u/5kIOHk2qBkxVjpXt1uZ6f0G2AdrODW8e/OvGllJazDyyJKJXrMltzr3lskSK//fdemqT81COy
	g6Xr9VV6e3BW9UHFiyAiU2kRsJ2sAnVREaV6gXsiX2sPNS2UF8m2YeidGz4cvifISust4kvb1we
	EYP18A1kaYp0mqxFLIJ4MWzgev3FUOsFS/uDGNBWDIR53SmUrz4wLyBc6uPEGZ2D9kemF9+gJJc
	S2mryHv+LDMmlabgWu+WkfT7
X-Google-Smtp-Source: AGHT+IHP/V1F9P3TW5ZFh/h+hXxyEHvlqMWOQvAOVjJ5loLIb8qqHYGPMlplTaY2sFeQxNozQ0fFjQ7ofp+S0wxS29I=
X-Received: by 2002:a17:907:785:b0:b6d:6a3e:b960 with SMTP id
 a640c23a62f3a-b6dba5c0ce8mr88785366b.59.1761588168846; Mon, 27 Oct 2025
 11:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016171845.1397153-1-rampxxxx@gmail.com>
In-Reply-To: <20251016171845.1397153-1-rampxxxx@gmail.com>
From: Javier Garcia <rampxxxx@gmail.com>
Date: Mon, 27 Oct 2025 19:02:37 +0100
X-Gm-Features: AWmQ_bnRxFLdM34KXqFkDra9NbBgRdtN8M_nP9qHeXiirDeaOiJxudxosg27OyM
Message-ID: <CABPJ0vgtpjh2q605TifawiS36qAS+OO_dAnYVGsqd03GSXZp+g@mail.gmail.com>
Subject: Re: [PATCH] fbdev: vga16fb: Request memory region.
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Helge Deller, any comment on this patch?

---
Javier Garcia


On Thu, 16 Oct 2025 at 19:18, Javier Garcia <rampxxxx@gmail.com> wrote:
>
> This patch reserve and release VGA memory region with `*_mem_region`
> fn's.
>
> This align with Documentation/drm/todo.rst
> "Request memory regions in all fbdev drivers"
>
> I've tested with kernel and qemu both 32bits.
>
> Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
> ---
>
> When I've run the code always return -EBUSY which makes sense as
> mem is already requested,`/proc/iomem` shows `000a0000-000bffff : Video RAM area`.
>
> I've seen that `cirrusfb` has this kind of code wrapped up with `#if 0`, and I
> wonder if it makes sense to also wrap up with `#if 0`, at least , in
> that way the code gets commented about expected behavior.
>
>
>  drivers/video/fbdev/vga16fb.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
> index eedab14c7d51..f506bf144a97 100644
> --- a/drivers/video/fbdev/vga16fb.c
> +++ b/drivers/video/fbdev/vga16fb.c
> @@ -1319,6 +1319,11 @@ static int vga16fb_probe(struct platform_device *dev)
>         if (ret)
>                 return ret;
>
> +       if (!request_mem_region(vga16fb_fix.smem_start, vga16fb_fix.smem_len,
> +                               "vga16b")) {
> +               dev_err(&dev->dev,"vga16b: cannot reserve video memory at 0x%lx\n",
> +                      vga16fb_fix.smem_start);
> +       }
>         printk(KERN_DEBUG "vga16fb: initializing\n");
>         info = framebuffer_alloc(sizeof(struct vga16fb_par), &dev->dev);
>
> @@ -1398,6 +1403,8 @@ static int vga16fb_probe(struct platform_device *dev)
>   err_ioremap:
>         framebuffer_release(info);
>   err_fb_alloc:
> +       release_mem_region(vga16fb_fix.smem_start,
> +                   vga16fb_fix.smem_len);
>         return ret;
>  }
>
> --
> 2.50.1
>

