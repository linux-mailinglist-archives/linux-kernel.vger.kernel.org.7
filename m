Return-Path: <linux-kernel+bounces-800378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E435BB43701
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA781C27618
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136E32F066C;
	Thu,  4 Sep 2025 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LyDIgMvd"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F72EFD98
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977838; cv=none; b=t9ZivRQK+1gX82za8t6n4EbPjsPh20RYxZtV/hVAOvaehzU2w5BjFxZ7JCHUCf96j6zOX8tHPKMr3QmtGqeRhpxO0O9Ge7hxbtRncjU6g6bASd9MYat9ZkEwymo2h9osc3r+/RXImwbjl9b6uq82/1YORYDicK0IpK+igxHU+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977838; c=relaxed/simple;
	bh=d6DJnsU//9cevGg0jVYiTkvbd/hhmd7yOLgFi5tH7ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpIuJ5zu9tRYjQejrbiijTJiX+7KZixTrcc0gsBH63u1iYWAVmBV/9HQkxlPgnxdRKUb6yTMZv2/ydQCLR8/ZyBJPOHaBcKNUTr3VCo30t1k9+hyUzYkz5MiDCTwdY+0Ytqwcsk/pBHpJIYmJla37sbJiqzn4Od8gMMfUZuinOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LyDIgMvd; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d603f13abso8825107b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756977835; x=1757582635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QzeRrlKixisMVnd0UvA2X18pYorJUCabya/Ko1pEIRg=;
        b=LyDIgMvddeO+vc8a4eJGFhR0zJl8f8yzfsITu5RlWe1+ApPietDxRSM2CLqLcWk2+o
         ptgE71GJMlTsy9eeLRZU3res9T3jz34q6l1c5aQ7yOn8HHIwY+wB3lmKjhd0DDtuH5OJ
         ZPq0sAfgWAx+1P8lOyNPJjj0oXlkXH1rWuEVDMB30OPfLF2MF7KoNfJYNNEayhg7EjOm
         yNJ4E6Oyj3SD22oi2maaCxU1DX8DStrLS6Jmjh61xa/UUxAgO33VCZRxkVQj0L9l1pTL
         GDEmROPRXxrnFKcDvwSOdUSghGNaDyZhtoW718UBH+oVqywGmg2pHzz8XNNsEdjvJBib
         35ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756977835; x=1757582635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzeRrlKixisMVnd0UvA2X18pYorJUCabya/Ko1pEIRg=;
        b=ODFChZ60jGbJr2bZrChdJG/Iw3ka2nlu/2J0DPBMWzwb/AHDYej/6YobbPS25KLHh1
         0VsP7YsgKv/MUl1twzQDmNf3M2MFJRZHbcDa1AqbCWhcdFIlN+vXTP+TPNt+ePEDdtT6
         F9dzyWlwc3hslYZ+Lb55yxRAUlU1jCv9NsdsHyweaLDliD3mjclctg/DhCQr8LE1PDIz
         8de2dejLaF8y8XmMa/DxbWZsq1bocv4Ay4D5fonskEXn/6U5a51bsVTuT/uMOaXmvTAh
         EzQlwfNX04u28K4CbJ1kqATcl+8+FgswKx3mZx/Mmp1fiqOjhDtuwxZZmKgR5bdGi6ei
         3j6A==
X-Forwarded-Encrypted: i=1; AJvYcCUSzq0O4LBP9ZnbGm1Mab2p17z2lX9TlatpS6Iz+I0EanVAB8FsjSVviPejMP4XzQ1NT18wud5pIebUAkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzxYYY7Ut1RxGMD79VjHNwHGlyQ+kWZQ+hlJFYFQOkqmYUKomo
	CAdOihG3zU42XRA8/CE3LWRv2g0Bd4mKcVi3ZsIp+Rp9uX3VQ2BHRNGlKNI3nybIw3B6yq9dWc3
	tvZch/b3ZrpTQMc+A58ZGT7zp8ZEvobvREYklW9u5ow==
X-Gm-Gg: ASbGncsMHci+78uC0nT9jddhN4Uizo2/IVXKTHFPFd6rOqGrZHvdehGVSL+8O9SvV64
	vN4vaPp0rOrJQZj65JExggHUaOTfIKWr8jap16niIy3TyKnL16uolx2GBduNlLLi6wHeFduHl2g
	Fa0ypJ/gJdNRmAED0wCYR8RFNvUoQpvEdy601jVT3RET1Xjw1CEfB2n/IksAw11Y27cgAoEocz3
	4EqzyEQ
X-Google-Smtp-Source: AGHT+IFr9L4PrSZPmzSuetZEfmDWJaA0qvzMSVVhGJl1HJQyaGQxkOvsSArE/36UhbKntob1lOo5JVJohbDRYtoqRbY=
X-Received: by 2002:a05:690c:6c85:b0:71f:f198:da8f with SMTP id
 00721157ae682-72276335654mr205654447b3.2.1756977835142; Thu, 04 Sep 2025
 02:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6202205.lOV4Wx5bFT@rafael.j.wysocki> <2393512.ElGaqSPkdT@rafael.j.wysocki>
In-Reply-To: <2393512.ElGaqSPkdT@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 11:23:18 +0200
X-Gm-Features: Ac12FXwDCpU4_C_Ls_ht_T7Y3VN2FOjJ3-MfI0MyM4u_qIM41ufdSl_RCheNlgI
Message-ID: <CAPDyKFp5NbEtiLRZihta0y=DXSTKghnfGHH1N_Y1BF=Q73eTtA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PM: core: Annotate loops walking device links as _srcu
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 15:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since SRCU is used for the protection of device link lists, the loops
> over device link lists in multiple places in drivers/base/power/main.c
> and in pm_runtime_get_suppliers() should be annotated as _srcu rather
> than as _rcu which is the case currently.
>
> Change the annotations accordingly.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c    |   18 +++++++++---------
>  drivers/base/power/runtime.c |    4 ++--
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -40,8 +40,8 @@
>
>  typedef int (*pm_callback_t)(struct device *);
>
> -#define list_for_each_entry_rcu_locked(pos, head, member) \
> -       list_for_each_entry_rcu(pos, head, member, \
> +#define list_for_each_entry_srcu_locked(pos, head, member) \
> +       list_for_each_entry_srcu(pos, head, member, \
>                         device_links_read_lock_held())
>
>  /*
> @@ -281,7 +281,7 @@
>          * callbacks freeing the link objects for the links in the list we're
>          * walking.
>          */
> -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
> +       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
>                 if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>                         dpm_wait(link->supplier, async);
>
> @@ -338,7 +338,7 @@
>          * continue instead of trying to continue in parallel with its
>          * unregistration).
>          */
> -       list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
> +       list_for_each_entry_srcu_locked(link, &dev->links.consumers, s_node)
>                 if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>                         dpm_wait(link->consumer, async);
>
> @@ -675,7 +675,7 @@
>         idx = device_links_read_lock();
>
>         /* Start processing the device's "async" consumers. */
> -       list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
> +       list_for_each_entry_srcu_locked(link, &dev->links.consumers, s_node)
>                 if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>                         dpm_async_with_cleanup(link->consumer, func);
>
> @@ -1330,7 +1330,7 @@
>         idx = device_links_read_lock();
>
>         /* Start processing the device's "async" suppliers. */
> -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
> +       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
>                 if (READ_ONCE(link->status) != DL_STATE_DORMANT)
>                         dpm_async_with_cleanup(link->supplier, func);
>
> @@ -1384,7 +1384,7 @@
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
> +       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
>                 link->supplier->power.must_resume = true;
>
>         device_links_read_unlock(idx);
> @@ -1813,7 +1813,7 @@
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
> +       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node) {
>                 spin_lock_irq(&link->supplier->power.lock);
>                 link->supplier->power.direct_complete = false;
>                 spin_unlock_irq(&link->supplier->power.lock);
> @@ -2065,7 +2065,7 @@
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
> +       list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node) {
>                 if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
>                         continue;
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1903,8 +1903,8 @@
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> -                               device_links_read_lock_held())
> +       list_for_each_entry_srcu(link, &dev->links.suppliers, c_node,
> +                                device_links_read_lock_held())
>                 if (device_link_test(link, DL_FLAG_PM_RUNTIME)) {
>                         link->supplier_preactivated = true;
>                         pm_runtime_get_sync(link->supplier);
>
>
>

