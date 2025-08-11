Return-Path: <linux-kernel+bounces-763199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA97B211B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA57768487B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008072D480C;
	Mon, 11 Aug 2025 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBH7IX+/"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E922D4801;
	Mon, 11 Aug 2025 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928710; cv=none; b=X2PFTazbtvV8wWKam6m1wTJUHg397mLe9Ec1xYfvzt1lXmI0NCKltn4L2cf8sAbbKkHqIrJVogmEiAKfgSvliYap+0XeigkLVYN1lQmL6KcveFhZZ882F9IY+GOuhDvmFGoS6myUH/ZDQsHLOiilgopGeiqpUiCYBJlTFgX/5Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928710; c=relaxed/simple;
	bh=inFvKHCFQ98IeGbm7fVz6dBLX4ErbBbvKCda2avqLWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq3WomiD4tixHCAiW6PSa+SeDP2ukbpByz165lX7EV5+PkTQE+/moKqXV8EpAGPgx4u0mJzuy7+YGA3kSBkGeKABMLAoGx8Bz/7va4rKjFf+wgqal/oiPHl+Qnu0EAy8DlsUFKnAD1hnvvpVdbHHVZnkGVzWOjtzyMD0DhboYCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBH7IX+/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so4673022b3a.2;
        Mon, 11 Aug 2025 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754928708; x=1755533508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3UtT+6OjrcTpmymA1eEoBAo08cqrgunpUK4YecHL14=;
        b=nBH7IX+/UilXBzMN8yNieUfZpOuLqUtPHTa8h/uPsD+WkusgHjEVNz2Arke02F+yLI
         9/XiqDUb+8m5bqTCAe7yC7QIEoLCjkGrV9VNtC/NHVVD4E0ZmLtK2yZVxT9ew4nWwNOk
         N5OIxVsAPfbJkOYMYntaZ1Xrju1KqsK6V+wwzz7FrczRS50ONG520qAANDj24jNJj+ig
         BRLPHXN/aw9ea7tNMq1E8DcNLvLfkDqoXYDj3VT7WabT8Lwxv/fw8QE9rhjYWCdfcUqx
         LttxASzNaggd90pyDZubZaRypaAvqZFG9Lp7QUEoJ79YdiCX2V+n05deg2b8StROh/XE
         +ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754928708; x=1755533508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3UtT+6OjrcTpmymA1eEoBAo08cqrgunpUK4YecHL14=;
        b=F51VO7LGi+qWyyI6JDKm+swMKXfSLZA0HNuM+KH/JOrjgroazQMKaqukHY/9R6UaBi
         iXNII6ygo0aL0zTtDQ4qghnDfWf/ilnsCZAi4pbRE8DVVb4oPSgMinhuJYid4ucUCU4b
         wfz/qWpLlHfOAPxBy/R0HsqyKzbVswBJ60jcP+eOhzI+QqBua+ueARTHyYDNz8TYn8KD
         9kd6wG/vT57wT51iC1tmeJVhhrFpUTwMoNKFcYQtkGBGR7ou2YX3r2oXPzx1AEulmkHu
         ak/nBygcMGqNtsNaod2eIPg/HPsd27MVVJQ9Bsi6448K7SVw7U91SEq+bVPCa5/WcQM7
         TikQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBYm/6+mdshJR1zC51cSDor5VLN4+jR3KxARNhvF7ndfr445WoZ5Wy0c4T2aqJNlTKTiPx2hIxWUBR93Y=@vger.kernel.org, AJvYcCXOAdhsOiGEaSqU/Z5lCqfPgvb2rHO7e4NM2lw7R4905VOYlhO8feCpqfTfpF4z8aoSiWNy1y3PZfjeHJQX/Qz9rzopkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSY3xgx3yUW7CaG+A5GPm8jDHxZKTPJRGkdJuqaiBNq0YFVKun
	8yGY/yDk6hTLO4gAdPGDaeMH3E2LS4oi6YsQrJz3VLTluMlQsyBXvjLp
X-Gm-Gg: ASbGncvQGfx8dgvlDarFmsw0zfZhcenP3BYvQWYrE9T2YGI0hO3pmFFcZNDqPnAmBm3
	NVl6LaO1lFA+JbBFCSp/HEwu81fCdEX1ajHFZ7XVfjW42Av8HNF9vlkV111px6lWNEk7ih0FItx
	LDKts7wcDpYTgj9UVbTzNmooTDRu5pkpan1T+Bh0McnoOXN8bdAxxtV1M/eUJ9HPuLAxKukbJ/u
	bKs+haNtiJ3uPJtnd/kKCqbNeMHGw18yUd1k066tw9xzf6DGGm37Rcmo+ccPdv2P4ufiT1HuAN0
	rHy6TTFjAKV864DAwZ82saV3wx+R2CjtFC9cjEalVFnA8zaoYz8ehm+a6wqcoCU/mtB40XQ8Rsc
	krhzOk5xlfFbofG+MOgAa6wo=
X-Google-Smtp-Source: AGHT+IGamdAs2+CF+UQokpsVw/83w46mf552RQ8xVzabZR/lXPJ3zIUxXISBNUgp9YcHPi7Z3Y3Eug==
X-Received: by 2002:a17:903:2cc:b0:242:9bc4:f1c7 with SMTP id d9443c01a7336-242fc3acdddmr1819455ad.54.1754928707722;
        Mon, 11 Aug 2025 09:11:47 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a06sm277680485ad.81.2025.08.11.09.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:11:47 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:11:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, 
	Santosh Kumar Yadav <santoshkumar.yadav@barco.com>, Peter Korsgaard <peter.korsgaard@barco.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
Message-ID: <tigj3afybwwqj5n4etir6xil7njo6q6q36abfqk46oku6fgfyg@36cg54q5sbtn>
References: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
 <aJnlnx2qF6P61jJN@smile.fi.intel.com>
 <7c2d08e3-d1e2-433e-b726-307246ab17e9@kernel.org>
 <aJoQE2CQv3nzaSqc@smile.fi.intel.com>
 <uakyig6sp2sfuwtt2aq7ds5dcbsjrgcijenunefqzc46inpees@xc6bfr4mjnan>
 <aJoTvDA6_pxVoV7G@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJoTvDA6_pxVoV7G@smile.fi.intel.com>

On Mon, Aug 11, 2025 at 07:01:00PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 11, 2025 at 08:49:21AM -0700, Dmitry Torokhov wrote:
> > On Mon, Aug 11, 2025 at 06:45:23PM +0300, Andy Shevchenko wrote:
> > > On Mon, Aug 11, 2025 at 04:20:33PM +0200, Hans de Goede wrote:
> > > > On 11-Aug-25 2:44 PM, Andy Shevchenko wrote:
> > > > > On Sun, Aug 10, 2025 at 09:31:37PM -0700, Dmitry Torokhov wrote:
> 
> ...
> 
> > > > > Otherwise LGTM as here it looks like we establish platform device ourselves and
> > > > > hence no need some additional magic Hans mentioned in the other series.
> > > > 
> > > > Not entirely like with the x86-android-tablets patches this
> > > > declares a software-node for the gpiochip:
> > > > 
> > > > static const struct software_node gpiochip_node = {
> > > > 	.name = DRIVER_NAME,
> > > > };
> > > > 
> > > > and registers that node, but nowhere does it actually
> > > > get assigned to the gpiochip.
> > > > 
> > > > This is going to need a line like this added to probe():
> > > > 
> > > > 	p50->gc.fwnode = software_node_fwnode(&gpiochip_node);
> > > > 
> > > > note the software_node_fwnode() call MUST be made after
> > > > registering the software-nodes (group).
> > > > 
> > > > Other then needing this single line things are indeed
> > > > much easier when the code containing the software
> > > > properties / nodes is the same code as which is
> > > > registering the gpiochip.
> > > 
> > > Ah, good point!
> > 
> > This is wrong though, the software node need not be attached to the
> > gpiochip (and I wonder if it is even safe to do so). It simply provides
> > a name by which gpiochip is looked up in swnode_get_gpio_device().
> 
> Do we have all this being documented somewhere? Perhaps start with that?1

This is original commit introducing the functionality:

commit e7f9ff5dc90c3826231343439c35c6b7e9e57378
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Fri Nov 11 14:19:08 2022 -0800

    gpiolib: add support for software nodes

    Now that static device properties understand notion of child nodes and
    references, let's teach gpiolib to handle them:

    - GPIOs are represented as a references to software nodes representing
      gpiochip
    - references must have 2 arguments - GPIO number within the chip and
      GPIO flags (GPIO_ACTIVE_LOW/GPIO_ACTIVE_HIGH, etc)
    - a new PROPERTY_ENTRY_GPIO() macro is supplied to ensure the above
    - name of the software node representing gpiochip must match label of
      the gpiochip, as we use it to locate gpiochip structure at runtime
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    The following illustrates use of software nodes to describe a "System"
    button that is currently specified via use of gpio_keys_platform_data
    in arch/mips/alchemy/board-mtx1.c. It follows bindings specified in
    Documentation/devicetree/bindings/input/gpio-keys.yaml.

    static const struct software_node mxt1_gpiochip2_node = {
            .name = "alchemy-gpio2",
    };

    static const struct property_entry mtx1_gpio_button_props[] = {
            PROPERTY_ENTRY_U32("linux,code", BTN_0),
            PROPERTY_ENTRY_STRING("label", "System button"),
            PROPERTY_ENTRY_GPIO("gpios", &mxt1_gpiochip2_node, 7, GPIO_ACTIVE_LOW),
            { }
    };

    Similarly, arch/arm/mach-tegra/board-paz00.c can be converted to:

    static const struct software_node tegra_gpiochip_node = {
            .name = "tegra-gpio",
    };

    static struct property_entry wifi_rfkill_prop[] __initdata = {
            PROPERTY_ENTRY_STRING("name", "wifi_rfkill"),
            PROPERTY_ENTRY_STRING("type", "wlan"),
            PROPERTY_ENTRY_GPIO("reset-gpios",
                                &tegra_gpiochip_node, 25, GPIO_ACTIVE_HIGH);
            PROPERTY_ENTRY_GPIO("shutdown-gpios",
                                &tegra_gpiochip_node, 85, GPIO_ACTIVE_HIGH);
            { },
    };

    static struct platform_device wifi_rfkill_device = {
            .name   = "rfkill_gpio",
            .id     = -1,
    };

    ...

            software_node_register(&tegra_gpiochip_node);
            device_create_managed_software_node(&wifi_rfkill_device.dev,
                                                wifi_rfkill_prop, NULL);

I guess we could extract this into somewhere like
Documentation/driver-api/gpio/legacy-boards.rst, but given that after
initial set of conversions we should not be seeing any more users I
wonder if it is worth it.

Thanks.

-- 
Dmitry

