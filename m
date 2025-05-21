Return-Path: <linux-kernel+bounces-657465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2472EABF471
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 14:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1EF4E1B47
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 12:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F9BDDA9;
	Wed, 21 May 2025 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/l2tenU"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999326658A
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831067; cv=none; b=NXtf5ScYJGDhq6ODP4ahFq72xVwlsv7zuyxZOa5z/oNpYGGEML5ESWsvcLGcIIIZDWC1imhqKgrjQApaKMz/rodkh7SGVdheKw72UGHGQ6K/MYl5Z/LCtPd67Q6Ug8cxQiLFdODVnf0165PwvB7ktog5ikhnE39dnMWOQQSoToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831067; c=relaxed/simple;
	bh=GjbC2EZupc9rKlg7w9fKGg0yFJA0QDt5fWx5/+GR90Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDhlTTDsPF7OM2HdKxLYhRbGlzAbNBYEaI4ubLFCj9ElrDGNb5pSFwO/GThkV+QA6Jll23UHixq+qnLEXPaE4vqJvgq8MHX/vCC9x3HWlCAfJx6YB7yrLh44oftPBsI+MLrbjJHyKkt7Z0a6VpmcqpGIjWpMUPCT9RCzMwn1skE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U/l2tenU; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e7b9972069dso3393881276.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 05:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747831064; x=1748435864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zXfUW8AesLAvEK6uV7kil0i/JjavCCmq+bnWibYZk4c=;
        b=U/l2tenU0U0EZ1kcIrV2Jf4AO7wL2LvmDfH2smBpMhx9fv3R37V6dlZi/tZEqEu2Ow
         c4gaLvgX9Q1hVnDAt1Gvhb1XxWzrggTfTO0085pJsh0JsCsHMb21YgDNIA0ZDvPzqCg7
         WGNSnJgIP5C0GLYFR8BvGgvXb+83WtWnAI5MI0zQKxvnCVc6I+xKnpYvgws/vQegf2l7
         RYblF/Uq6YiNg3beLa4C0c/w6l4XP2v8HVu1siSFJ0Cpf6K10SYHWMHD2IEXxFj0YqOG
         QhIuX6Ow4GZ38Ig6c0Owiq2/H951m6ZHA3VChNqWPjpT9tlOhUWrTEBjgHGrBg0gKSaU
         F6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747831064; x=1748435864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXfUW8AesLAvEK6uV7kil0i/JjavCCmq+bnWibYZk4c=;
        b=hlEyPGH29QbGHaZhpFdJgDQRuvfYhBuik0Gqjzyf/Z3zUOQKVq3VRsmEsGT4sD8XWU
         nZ93X3nm3jyCq5BefgjPBzlIFpe1omdnk5v3hxL+yxihLnfXXKLDuYqhjMMLWPZn07/0
         HGg8/WUXMTztwL2J0LeLAWCArFJaNPeA7pTmBg5rFGHyFwbdEl8OgXdgFj5BonCS2M8g
         w+u93thKob0W5QDaYhDQilkh4ymrqjA2wI2ijZhC7N/2OI7msYqXhrj1pgKtv+Eqmu+i
         6pRYLmDSR9HGQQHqH8AMQsIS4WofFqeElRzDoOZvVylwCl6xop/AXSEb1iDTZpR2vc0M
         H/fw==
X-Forwarded-Encrypted: i=1; AJvYcCU0lvD6+jKbpawMCa7LGRd5rrw1NRWp/EoFfEy5l7Km301RGCnlejfC9LIqIJbD2DUSHVDWaascs1quXTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJoQ0yO640MYG0lwmB4Oz9nCdax9SmImLMHAtpwgycSCrhjMp6
	TUSwd8GT4R/SpbklAg9URIlxMDuAI/ltGuH8L/CF8s66qtJQYtiE2NWAAeKEIcBE5RJ89mHfFsD
	kOTf2RuWrQcWUrdK9l7L1gJsemJ9TCNJQQoDDIX1IEg==
X-Gm-Gg: ASbGncszKtZ8DJ9ei84mdSMsN605yLXJs3VDKoKGo3Pe8f+7LCVrLv5kvLitnTqc6Kr
	ZmvUXqalIAY+VGtjD0dWLwK5p+yVudKkR4DSrtSfUh41m3Mi2ufNjNi7ir9iFQE7ahTCfQyU47m
	rmGn1xvwyOya9kn49GaKjijz1caK5oecmcSw==
X-Google-Smtp-Source: AGHT+IGQ0Er0ikbn7otLufhr49GAViB+eYDY7XcsomnPLX3MomayKlYAppD+R3rJurYyfxiX41IbobCp19yEMNTFNKw=
X-Received: by 2002:a05:6902:1445:b0:e75:bb4f:65f with SMTP id
 3f1490d57ef6-e7b69e88ae4mr27113366276.17.1747831064489; Wed, 21 May 2025
 05:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8d83ea72-bb81-4c63-bf69-28cf5848ae20@tuxon.dev>
 <20250305140309.744866b2@jic23-huawei> <Z8k8lDxA53gUJa0n@google.com>
 <f74085be-7b14-4551-a0a7-779318a5dc70@tuxon.dev> <20250330163129.02f24afb@jic23-huawei>
 <5bca6dfd-fe03-4c44-acf4-a51673124338@tuxon.dev> <95f5923f-7a8f-4947-b588-419525930bcb@tuxon.dev>
 <CAPDyKFoMqmCFBoO8FwQe2wHh2kqQi4jUZNFyiNckK7QhGVgmvg@mail.gmail.com>
 <c3a2950a-17ff-444a-bee7-af5e7e10e2bf@tuxon.dev> <CAPDyKFozR4qDq4mzcZBK-LcoPf=fGyuJTXwdt=Ey+_DcQOAp0g@mail.gmail.com>
 <4o3wo76st7w6qwyye3rrayuo2qx773i6jfzcnbkhdj76ouh7ds@3e2mblehkgwf>
 <CAPDyKFqMB7XutXba73YHx1X4rm6uc3Fz6yMZ8yM=wgduEmgUDg@mail.gmail.com> <a20fc6ee-c6c3-4013-b175-4918b9a44380@tuxon.dev>
In-Reply-To: <a20fc6ee-c6c3-4013-b175-4918b9a44380@tuxon.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 May 2025 14:37:08 +0200
X-Gm-Features: AX0GCFsIU_Cv5FbQ2Bm0zIY-CQUORmN3DYEsWgTR0YU12ksOIQgVfnfzD5GxgjI
Message-ID: <CAPDyKFpbeLJUiB_xQbqDib+-8Q3AcJNVg+DuEcqmVGMbFdNxwA@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 May 2025 at 07:41, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>
> Hi, Ulf,
>
> On 20.05.2025 15:09, Ulf Hansson wrote:
> > For example, even if the order is made correctly, suppose a driver's
> > ->remove() callback completes by turning off the resources for its
> > device and leaves runtime PM enabled, as it relies on devres to do it
> > some point later. Beyond this point, nothing would prevent userspace
> > for runtime resuming/suspending the device via sysfs.
>
> If I'm not wrong, that can't happen? The driver_sysfs_remove() is called
> before device_remove() (which calls the driver remove) is called, this
> being the call path:
>
> device_driver_detach() ->
>   device_release_driver_internal() ->
>     __device_release_driver() ->
>       driver_sysfs_remove()
>       // ...
>       device_remove()
>
> And the driver_sysfs_remove() calls in the end __kernfs_remove() which
> looks to me like the place that actually drops the entries from sysfs, this
> being a call path for it:
>
> driver_sysfs_remove() ->
>   sysfs_remove_link() ->
>     kernfs_remove_by_name() ->
>       kernfs_remove_by_name_ns() ->
>         __kernfs_remove() ->
>
> activating the following line in __kernfs_remove():
>
> pr_debug("kernfs %s: removing\n", kernfs_rcu_name(kn));
>
> leads to the following prints when unbinding the watchdog device from its
> watchdog driver (attached to platform bus) on my board:
> https://p.fr33tux.org/935252

Indeed this is a very good point you make! I completely overlooked
this fact, thanks a lot for clarifying this!

However, my main point still stands.

In the end, there is nothing preventing rpm_suspend|resume|idle() in
drivers/base/power/runtime.c from running (don't forget runtime PM is
asynchronous too) for the device in question. This could lead to that
a ->runtime_suspend|resume|idle() callback becomes executed at any
point in time, as long as we haven't called pm_runtime_disable() for
the device.

That's why the devm_pm_runtime_enable() should be avoided as it simply
introduces a race-condition. Drivers need to be more careful and use
pm_runtime_enable|disable() explicitly to control the behaviour.

Kind regards
Uffe

