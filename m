Return-Path: <linux-kernel+bounces-704217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45167AE9AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 12:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24991C40658
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 10:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAD821FF47;
	Thu, 26 Jun 2025 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKz8j8yZ"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9521CC59
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932671; cv=none; b=NmqVAvivwi9F2HQw0gw8zKV4ESzCQYYE3SJic55+9tbSaZcGR/8XyDvIKnDbOo5WRhqofKh0zsXAPNHFeQf1ppu51W+SNbcsIutGPGZjcVf8VgqMGOuGpEiO7CGvCwHpqhpB0m5SkLa8mb21Uwbbc6N7rC/KaPKOrSMFYHlcIiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932671; c=relaxed/simple;
	bh=6/CYJDnKQKVbQcwXiQ2rMzs2H9ssDvR6KIpjsUQ6QdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEHh62P1e56hYq1pgZeaj5c2iP7ryg7RJcHpsDvb1nYi3YgSutMccGOz3uVk/fwLa8UpJvl88GRH5bfOhqCeR7Dkq79OxU3PiBsaASfPZBpnKfjD4Bt7fvMFMXdAb/CrxH4CW2cwDNkIDEQ3LLRfBtZOBVO7eWQujbr0k0tQurA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jKz8j8yZ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso640604276.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750932668; x=1751537468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q9r85ztpEpS9CYbZbkPRdk5F829Mu+gn5m9UjJJ67w=;
        b=jKz8j8yZKBOa7biATTQpt47NE380p0arVVW2TvzqXbvq5RyIZnCMi7nhD/HhMXYxG9
         14ETF+3PzaHQPT51FU9gAiJNWVJT85d/s62Z/nGx47ZAS3XiL9bxnMyzzcoNRbkZaOLu
         Bkd578TgrI4eXkwPYweFBrsvKq4O9eYvRqwGWeN5V7lULHQgK5mVRsFHG16Azj4t/2SK
         Lft3M3XvrCJQaDOO7S6P7H8OEktGZLHitpS5Y04PLE12f5xCteSaouVLNrkEWLL7i7d2
         mMDby3gOo1GYd2hSAYRcTizT47AXZTWEDaRBRASJzsGv8l5L/L5Nh2agqwAlL8SrnNUn
         x/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750932668; x=1751537468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Q9r85ztpEpS9CYbZbkPRdk5F829Mu+gn5m9UjJJ67w=;
        b=jL2KLKh76UR5p0yKrR+hEQeZtnCSdHW7K/s7BJ0rRBochopOIOw6dDvSp8CrAsiwr+
         2YX3p6vr6JHy66v5C6lKiFWXy+ecIpEGmll8QRZosE6cnC3/bx4yq44p1xrcCsvZXlEu
         vJWDLoHXaPNd0kwr+s6ZukC7Q6ngDNhSWNrvMGt+gvk8Bsh2yG4hBOvlT4P1328VzWT8
         p4l8gYvQ7BBhYHpPAPHsEF04dGMAC627kQmV1HHaw3OEFniFn9lqB55oiczDVbmJFpY/
         Zq7AEXjJQGGDUa8rslgPQFBGPoWAqLTWZuzI8b+mVtHGZbukezTGCZtD54EoJK/T9YFw
         kr5g==
X-Forwarded-Encrypted: i=1; AJvYcCUDOS4PG/K6PuzJsgqL8sW8A0ZogKAGQ/4J8PXXQsOGyA+pVk0Cyjt1vH03qal2k8LauGw63c2SeW+0vGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+/neNVdCFW18YFKO4mMpLdmJ8pkCULCYmz6xQTz7btxdMI9F
	2Dt09LV2EOk96YDc52NLzLWVJl9+G76Amu9mXs0dKZ3PCFMgV4gxqerNZJ2WfJoJnaxXMl3Cikg
	Wny5oOUPZAB/X59JEU4wayz7i++043SNQoNHtSFHlag==
X-Gm-Gg: ASbGncs6KJOLmBbACYLVbucOpKVk/jGwjckM9pXIajlBsT27u+xCOjMJU2BRHIWviyp
	MKbj+e7/jtHW4MlRd29Jqty5Nm8u5WfDT4K2XuORG+M5Dk7cRYi8seCLE0Y5YrT53FeKkYsenu0
	J9pVTwMyRl7VDdYjOisyMegDrpUVj4deLKTZXiAZrpV5Y7
X-Google-Smtp-Source: AGHT+IFTNjmMODL7y1EvHVTNC82M3od38DyxrG8NO+F9c5mpyvxWXa3dqoy9a/B0A36TiqGlH0TnxzyON/TB5m34CYM=
X-Received: by 2002:a05:6902:210e:b0:e81:9581:4caa with SMTP id
 3f1490d57ef6-e860178bba2mr7662593276.34.1750932668573; Thu, 26 Jun 2025
 03:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <3903497.kQq0lBPeGt@rjwysocki.net>
In-Reply-To: <3903497.kQq0lBPeGt@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Jun 2025 12:10:31 +0200
X-Gm-Features: Ac12FXzz6qmhiLsuzk245wnHwdyyM19B97SD0ZUjObz7zXjCLdLDg9DQbgqL-iI
Message-ID: <CAPDyKFqXvNDqZjePwvF+mgs7bba47uoeH-7XvJkqZ2K4-bmXgg@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] PM: Use true/false as power.needs_force_resume values
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since power.needs_force_resume is a bool field, use true/false
> as its values instead of 1/0, respectively.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/runtime.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1827,7 +1827,7 @@
>         dev->power.request_pending = false;
>         dev->power.request = RPM_REQ_NONE;
>         dev->power.deferred_resume = false;
> -       dev->power.needs_force_resume = 0;
> +       dev->power.needs_force_resume = false;
>         INIT_WORK(&dev->power.work, pm_runtime_work);
>
>         dev->power.timer_expires = 0;
> @@ -1997,7 +1997,7 @@
>                 pm_runtime_set_suspended(dev);
>         } else {
>                 __update_runtime_status(dev, RPM_SUSPENDED);
> -               dev->power.needs_force_resume = 1;
> +               dev->power.needs_force_resume = true;
>         }
>
>         return 0;
> @@ -2047,7 +2047,7 @@
>
>         pm_runtime_mark_last_busy(dev);
>  out:
> -       dev->power.needs_force_resume = 0;
> +       dev->power.needs_force_resume = false;
>         pm_runtime_enable(dev);
>         return ret;
>  }
>
>
>

