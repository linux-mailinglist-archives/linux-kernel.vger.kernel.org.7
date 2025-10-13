Return-Path: <linux-kernel+bounces-850581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DA2BD3366
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFF324F1A83
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AFF3081AA;
	Mon, 13 Oct 2025 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="OKaWQKzw"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269043081A7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362231; cv=none; b=aO1UoTQLQ8QURkoWotNe81DZSfWLQtl27UQioiDBx/6uioPW2YopDG2VeS2wPoNFshFYpcFYRCfH/UOm8aATCeDF08YWmyX9zBfz/mA0Ocnx8KqTARkIGMhGAFd2LE+f03B6nxJdvdKd/mC/GckGJw0rc7JqtnT6mLitBlpO0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362231; c=relaxed/simple;
	bh=6j4sCIsomLPE3GK/9DahwepOyid5uXYv2sDuhGLNFM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/2GA9L/1HVTcIFCRcQllnph5kMkvCl3060y9W15OP7YU9umshynR6jq8rb+xldG/Q0oT+adgT7/LCS1277skgfl0Q8IIoNcqEXxAAWmzhkgIzADFl2NpMJgFqD78IYIzVkZwX2t8R2LQ4eZiJwubKAnWnFts+frUhPPEPwH8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=OKaWQKzw; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-81efcad9c90so60542476d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1760362229; x=1760967029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kuyOtCXDAecJZfTlIjmVfECuejQEXz8BJl4zxdorR80=;
        b=OKaWQKzwP6VJpOhcbAUmOtqzWpXazuIs+CZYLjXvaCuGp7pqTFYrd7lgn4vWialmgW
         8/JK7ehE2TsXBWViJrF7SK4zFDvYyj7tEh213GywBTyQ4Jn7RoRAWCf4tphIk9UlCIVG
         wJi2GPZExErC4T9vrSTzFOLPUydUv+ysEj6U8nnTYOSB9D6EAS3VigchAxUfR3hJ1y8e
         5nqSv02z620wdXrLcWuAcZSI4p2RcpmWi8jeSXbaOe7uMet230/xobEHsISqCC8fWdHQ
         Vf+TTMtLkh8Mhu0Lqv7L6wq12k25yDpFPp9jPRfUYmxTy1cPFWXpKpsMbFVEixBxeNqe
         os8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362229; x=1760967029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuyOtCXDAecJZfTlIjmVfECuejQEXz8BJl4zxdorR80=;
        b=GqT5OZ8Q4amr74oYwgE8P9ero1AU1eN53mlRXxT4xsDsPJvg1ZLVyw1fmbrRQbcr74
         0uxXIxcX0PmX2z+vWsUQauMghRGzQlAB93MGwSCaAQu4iIX3A9DZW3MfjUpu8D/g9IpO
         PWCdfxSIxsorvfCNs6J331rFzhyFQ+g6gZFyCn5Oo+xWH6+/JAr1VbfQ5+EZuzg6CXlm
         y002SwSrEdw8EZV9q/OkU5LbRxvatBtqUa7KxZVzS4L5aQGWdcURTKrXPpciRH5v/TtL
         wKaizvsR9nmoeHCfRsqp8cGvWoCtuo76ka1FMd6/U3xaGgGuBSEm+YgYVv/WorNZL2AY
         Izhg==
X-Forwarded-Encrypted: i=1; AJvYcCVlrtRn1AJpjsRUlgFE1YnI2w2J4J/ICnbTorOS7JblVvWy2tVWSVPeIioSa9XukDE4tGKLCL/zgAyiDb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/wMWyWPbrthkX1fArVl5NM5V8OWhAv5SId/tkel5JehY/8ANA
	wVmRjqixfXxrr6OunMzXVGeqHNKNbO5iECfMgGw0qu81Jgw+9YutlEW77MSo5ZNThQ==
X-Gm-Gg: ASbGncsZlRJvZwg1v66VXPB3YjfMzwl2ZQd8CKiqVYhnuDPaNOCAjtEBBLkDKa608WU
	4xEQQJADSOjydj9FTt16GxzVPL8PPrir+OX56vyyFJw46db6agAocUTrTk9BfSrfN1y7bIQ1Ow9
	RG4/GJs5LT1/3ORWWVgLrd33mM9mdeaiR+mZIcUGDqhx9SfXAQp4wC0vCK1OXrWGsxyI8B2efpr
	LiUA5W+c3UukwAm+C1UgqEh3lT+p3kFZrKhkNmWERe6S5yZk0OqbfDKI42XSywlIVr95qReWuo2
	JXtzxAUhnAkNQxJWlpgy5lf4ezTI9ZSlHREZQRO9r/xA2og5L0uQcAVx/xrzLhPrZzGr8tRth+F
	u+UBeW5Z+ttPfejAwNjDgOumH5Jq3x0Y3t5zloSuOrQc3A+upbg==
X-Google-Smtp-Source: AGHT+IGtA3GUkdQo//QBn3pY2OMnyEfTVBquyoe34OK9IjLByDxNimIi0SJJkquSyLOMPM8YUydg0g==
X-Received: by 2002:a05:622a:8d08:b0:4e6:f791:c04 with SMTP id d75a77b69052e-4e6f7910f74mr186096831cf.50.1760362228806;
        Mon, 13 Oct 2025 06:30:28 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::20b3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e706d670dcsm75869621cf.28.2025.10.13.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 06:30:28 -0700 (PDT)
Date: Mon, 13 Oct 2025 09:30:25 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jimmy Hu <hhhuuu@google.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	badhri@google.com, royluo@google.com, Thinh.Nguyen@synopsys.com,
	balbi@ti.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: fix race condition in usb_del_gadget
Message-ID: <a337ce7a-a3b9-48d5-be33-eaaa71efba87@rowland.harvard.edu>
References: <20251013075756.2056211-1-hhhuuu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013075756.2056211-1-hhhuuu@google.com>

On Mon, Oct 13, 2025 at 07:57:56AM +0000, Jimmy Hu wrote:
> A race condition during gadget teardown can lead to a use-after-free
> in usb_gadget_state_work(), as reported by KASAN:
> 
>   BUG: KASAN: invalid-access in sysfs_notify+0_x_2c/0_x_d0
>   Workqueue: events usb_gadget_state_work
> 
> The fundamental race occurs because a concurrent event (e.g., an
> interrupt) can call usb_gadget_set_state() and schedule gadget->work
> at any time during the cleanup process in usb_del_gadget().
> 
> Commit 399a45e5237c ("usb: gadget: core: flush gadget workqueue after
> device removal") attempted to fix this by moving flush_work() to after
> device_del(). However, this does not fully solve the race, as a new
> work item can still be scheduled *after* flush_work() completes but
> before the gadget's memory is freed, leading to the same use-after-free.
> 
> This patch fixes the race condition robustly by introducing a 'teardown'
> flag and a 'state_lock' spinlock to the usb_gadget struct. The flag is
> set during cleanup in usb_del_gadget() *before* calling flush_work() to
> prevent any new work from being scheduled once cleanup has commenced.
> The scheduling site, usb_gadget_set_state(), now checks this flag under
> the lock before queueing the work, thus safely closing the race window.

Good analysis.

> 
> Fixes: 5702f75375aa9 ("usb: gadget: udc-core: move sysfs_notify() to a workqueue")
> Signed-off-by: Jimmy Hu <hhhuuu@google.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/usb/gadget/udc/core.c | 18 +++++++++++++++++-
>  include/linux/usb/gadget.h    |  6 ++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index d709e24c1fd4..c4268b76d747 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c

> @@ -1357,6 +1362,9 @@ static void usb_udc_nop_release(struct device *dev)
>  void usb_initialize_gadget(struct device *parent, struct usb_gadget *gadget,
>  		void (*release)(struct device *dev))
>  {
> +	/* For race-free teardown */
> +	spin_lock_init(&gadget->state_lock);
> +	gadget->teardown = false;
>  	INIT_WORK(&gadget->work, usb_gadget_state_work);
>  	gadget->dev.parent = parent;

> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 0f28c5512fcb..8302aeaea82e 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h

> @@ -426,6 +429,9 @@ struct usb_gadget {
>  	enum usb_ssp_rate		max_ssp_rate;
>  
>  	enum usb_device_state		state;
> +	/* For race-free teardown and state management */

The comments here and above merely repeat information that's already 
given in the kerneldoc.  They aren't needed.

Alan Stern

