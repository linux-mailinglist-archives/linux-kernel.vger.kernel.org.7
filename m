Return-Path: <linux-kernel+bounces-856614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5FFBE49D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E224809E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F121F32AAA7;
	Thu, 16 Oct 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNJjygoQ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA1329C49
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632652; cv=none; b=L8z7lhcNtS7Qf+5OPbt+zbqAw01YNZPQJzT7PWURCU5nW5t2Va3tUmozobxLi/zq07/5W9BdSSwEOBwW29vYTh7+ThIVq/EeoRQvPQvhy6jvW23PS+jAOfCWbo737LLgdWHocXKNfyUEm2gyb6EtFlAjXy8ZYBc9+SU2V1fsWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632652; c=relaxed/simple;
	bh=KEHq5Zv6SKODtoWAUUZ02QfgtCU6kZ9QOgSNgl9kgnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6r/zPvV36w5KvYQauQIWAeN5A1yFtCzrIQKyTIn0TwzUY71zFNsE6UCxFObWY72ZIoK/ukGMkTNgIy7nwrYQfxALu37gm3I7TxxYdP51cy2lb/uUStRhsYORXnTlcKXMNiyGtMrs4jc3CDtmIPi49UPoVDTD3VrGDMy8jdVPBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNJjygoQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so8704425e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760632649; x=1761237449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=45+w+j3wKKDN4yoFkSENhMTwEvEfIBVYuwOyTN6K8LA=;
        b=GNJjygoQs0rQ9GY3K7lzK50fODSxRs9worjuVD/nlH5XnwWltDIaQmIm9EN+8ZeHDl
         rBJPRpIDc2oCaOf4mN7uY4N319+gfJ3EPeGT0FtSGmXKpY3LyG6QRuRU4eG85AA1gJA3
         zHCQB9rjfKmyJ/6RzIvp3zp1l0ki8VBkCubkJSxlY2zWrxB4vB2pof864K7nTf4HSI0M
         vHIiuDJvmMH0DOefu/EhTznDH9JlkZpIorYS8Df7jIXHTwF2ySgf9g1yhtOh4MqfIbVu
         A5dSjBvdwxFr/HumMqWmTltarN5TTYh8u9FGZsWf+SPIzmytIyZ1MD3ThhVMez1yObUH
         u6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760632649; x=1761237449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45+w+j3wKKDN4yoFkSENhMTwEvEfIBVYuwOyTN6K8LA=;
        b=weeLyKHPv9s0SMS4kiHPKA/KtrldCMxh55SWzGN+XBYS5Oklh1wBfPXwNXQrei0SAu
         3xYwy5apZ4GtM2j61xbVqAtx8PkVoKTLHUY8SBxfNEpOMAAeqKPrKMWxNC1MI4q4H1CU
         u4BIjLy9IcrIKnCIhfEo1Z517xqqvxVZnbHWifQrpxDD3KnyZTKDsrkmheG5qw3JW40H
         hRed/w8aVcsuO0OU1jeiolwkwjzqQdsFJdGkbo4C7dWzHDSvB8rrxFO4edAwAsYls6Lq
         /S4Ra175B7gIoF4BfYVqxoTm/uamuQz4gSegOhZxdLgXreYmeHL9WQGpC+oYp8TNEvfZ
         zmbw==
X-Forwarded-Encrypted: i=1; AJvYcCXCoqufjU7d0wcUfU1JUjNynB+O+y2heby6ZXwYhEueIT3W8nBVJxHqNRZWAPcnXt5Whxwv1BUQzGR+MvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZrU0e0qaK32VUP2M7NVNSlAk8urHtizu3NjYtmFwNZLLS3X/G
	1gsdjuknGjkMLB6fwmGqEoYyLjN2A3l/sZGlAgRdrkGleoLw707SBjPC
X-Gm-Gg: ASbGncuure8U8O/RtoH7FV08QyKYbHPnIntj3sint6srtTX7vzgYXRdBDeOCFXBsZnF
	IOuefrLEPsSme5WW/yA0p1QH0fsvyGt7hhno964d25G7wNWmPQatLKEP8rhOZofp4+n0ZJfByLT
	PU+UPZBkaiLX0T40Gscz+mnWkQdH4ZiE/fPsFII07x6Yg0jj2OqAWE4GvNaFGeWMkSlIySjxcA8
	QsUwKwRPj4+gtvGj9KtRMHnN27WKJmyKSTghyygbGcFernRrhVD8ZAWOVHlr5IWcrZWUUceNK4Z
	OjnlUC+BWQZ/tMS5po9UGcPG3dvClealxzyNIH/LTBOzXDBgDarupNNZYsFjhN9D1RJYADooxnm
	KOYzXg39rpV1LwlYXXZPNnTuWdToh9iHcJW26rX6ssYXye5whB9MzqKXX4O6fXZQmfUJivAnPER
	UjO1T+oz2F+v3TZg==
X-Google-Smtp-Source: AGHT+IGEOTfVqWnJFYOk2GGMnHDO9Q9MSJhfGr6/3jWO6A4puL9KoGNizC6MjPxWvVhvNa+GQ/HzbQ==
X-Received: by 2002:a05:600c:458b:b0:46e:39da:1195 with SMTP id 5b1f17b1804b1-471178784d9mr5114965e9.3.1760632648448;
        Thu, 16 Oct 2025 09:37:28 -0700 (PDT)
Received: from gmail.com ([51.154.248.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710ed4b47fsm25518655e9.4.2025.10.16.09.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 09:37:28 -0700 (PDT)
Date: Thu, 16 Oct 2025 16:37:27 +0000
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Michael Buesch <m@bues.ch>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] gpio: bt8xx: use generic PCI PM
Message-ID: <aPEfR_lwO1i2wGYb@gmail.com>
References: <20251013155303.1103235-1-vaibhavgupta40@gmail.com>
 <20251013174319.GA847155@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013174319.GA847155@bhelgaas>

On Mon, Oct 13, 2025 at 12:43:19PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 13, 2025 at 03:52:59PM +0000, Vaibhav Gupta wrote:
> > Switch to the new generic PCI power management framework and remove legacy
> > callbacks like .suspend() and .resume(). With the generic framework, the
> > standard PCI related work like:
> > 	- pci_save/restore_state()
> > 	- pci_enable/disable_device()
> > 	- pci_set_power_state()
> > is handled by the PCI core and this driver should implement only gpio-bt8xx
> > specific operations in its respective callback functions.
> 
> Tiny nits:
> 
> s/use generic PCI PM/use generic power management/  # subject; not PCI
> s/new generic PCI power/generic power management/   # no longer "new" :)
> 
> > Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> > ---
> >  drivers/gpio/gpio-bt8xx.c | 29 +++++++----------------------
> >  1 file changed, 7 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/gpio/gpio-bt8xx.c b/drivers/gpio/gpio-bt8xx.c
> > index 05401da03ca3..70b49c385b43 100644
> > --- a/drivers/gpio/gpio-bt8xx.c
> > +++ b/drivers/gpio/gpio-bt8xx.c
> > @@ -52,10 +52,8 @@ struct bt8xxgpio {
> >  	struct pci_dev *pdev;
> >  	struct gpio_chip gpio;
> >  
> > -#ifdef CONFIG_PM
> >  	u32 saved_outen;
> >  	u32 saved_data;
> > -#endif
> >  };
> >  
> >  #define bgwrite(dat, adr)	writel((dat), bg->mmio+(adr))
> > @@ -224,9 +222,9 @@ static void bt8xxgpio_remove(struct pci_dev *pdev)
> >  	pci_disable_device(pdev);
> >  }
> >  
> > -#ifdef CONFIG_PM
> > -static int bt8xxgpio_suspend(struct pci_dev *pdev, pm_message_t state)
> > +static int __maybe_unused bt8xxgpio_suspend(struct device *dev)
> 
> I think __maybe_unused is unnecessary because of this path:
> 
>   DEFINE_SIMPLE_DEV_PM_OPS
>     _DEFINE_DEV_PM_OPS
>       SYSTEM_SLEEP_PM_OPS
>         pm_sleep_ptr
> 	  PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
> 
> Detailed explanation here:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/util_macros.h?id=v6.17#n86
> 
Fixed them in v6.
> >  {
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> >  	struct bt8xxgpio *bg = pci_get_drvdata(pdev);
> >  
> >  	scoped_guard(spinlock_irqsave, &bg->lock) {
> 
> Unrelated to this patch, but it's not clear to me why bg->lock is
> needed here (or maybe anywhere).
> 
>   $ git grep -l "static int.*_suspend" drivers/gpio | wc -l
>   26
>   $ git grep -W "static int.*_suspend" drivers/gpio | grep lock | grep -v unlock | wc -l
> 
> It looks like only about 8 of the 26 gpio drivers that implement
> .suspend() protect it with a lock.  I would expect a lock to be needed
> in all of them or none of them.
> 

I can have a look at them.

regards,
Vaibhav
> > @@ -238,23 +236,13 @@ static int bt8xxgpio_suspend(struct pci_dev *pdev, pm_message_t state)
> >  		bgwrite(0x0, BT848_GPIO_OUT_EN);
> >  	}
> >  
> > -	pci_save_state(pdev);
> > -	pci_disable_device(pdev);
> > -	pci_set_power_state(pdev, pci_choose_state(pdev, state));
> > -
> >  	return 0;
> >  }
> >  
> > -static int bt8xxgpio_resume(struct pci_dev *pdev)
> > +static int __maybe_unused bt8xxgpio_resume(struct device *dev)
> >  {
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> >  	struct bt8xxgpio *bg = pci_get_drvdata(pdev);
> > -	int err;
> > -
> > -	pci_set_power_state(pdev, PCI_D0);
> > -	err = pci_enable_device(pdev);
> > -	if (err)
> > -		return err;
> > -	pci_restore_state(pdev);
> >  
> >  	guard(spinlock_irqsave)(&bg->lock);
> >  
> > @@ -267,10 +255,8 @@ static int bt8xxgpio_resume(struct pci_dev *pdev)
> >  
> >  	return 0;
> >  }
> > -#else
> > -#define bt8xxgpio_suspend NULL
> > -#define bt8xxgpio_resume NULL
> > -#endif /* CONFIG_PM */
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(bt8xxgpio_pm_ops, bt8xxgpio_suspend, bt8xxgpio_resume);
> >  
> >  static const struct pci_device_id bt8xxgpio_pci_tbl[] = {
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_BROOKTREE, PCI_DEVICE_ID_BT848) },
> > @@ -286,8 +272,7 @@ static struct pci_driver bt8xxgpio_pci_driver = {
> >  	.id_table	= bt8xxgpio_pci_tbl,
> >  	.probe		= bt8xxgpio_probe,
> >  	.remove		= bt8xxgpio_remove,
> > -	.suspend	= bt8xxgpio_suspend,
> > -	.resume		= bt8xxgpio_resume,
> > +	.driver.pm	= &bt8xxgpio_pm_ops,
> >  };
> >  
> >  module_pci_driver(bt8xxgpio_pci_driver);
> > -- 
> > 2.51.0
> > 

