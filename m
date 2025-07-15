Return-Path: <linux-kernel+bounces-731754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2497B0590B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AD6C7A8F12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7762D94A0;
	Tue, 15 Jul 2025 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfNp4uZI"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BCD2673A9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579574; cv=none; b=alZglgnsezffs7//io8fhuTJs2QQoXpk2asz3S4Cz9gJLOL35SLM1YqnpZy8jyZ1iqpST4JqiInLmXgs0P3MsZy/3VdBcrYhHgNU4qmwLDKaFwuTLQPu2NIXHR9IHUb2LMJUxXV76yfUeXQhyWQ+B0Um8TCn+3Y/DjjICmLoQlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579574; c=relaxed/simple;
	bh=w1brcsbdt0tlcESNSyTMgCKbPvuMt9idpFuroZNU/gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIp31OOjThqCOM/jXcNfYsCtt97vOvWUQLTYjRTq+3f24JQ3Caw3zRet96cQMR6rh/gWEz2iUd6rpxR3qkq/WukoIFJDQs12LJ1HlCbvlHsDKGfRWHGOe9TI2Xx6RRhqAwAvY5kRHN4V8S61xOUQm96kueeeCWWqLYYPXQ96HUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TfNp4uZI; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e1d8c2dc2so49071647b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752579571; x=1753184371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RhdF9Yv+ocxCNpwigI26KHR6mp6iXHv5oflRqdQCh5E=;
        b=TfNp4uZIpH2IyjijQksyW5A9K0dSo1n6xC7Us0Lz68JBlQwlntmgzMn6E5BA7a84Um
         21Ll0eqp5kj8a+iP6LrD2Rn1QWPveocGR+Mmz53Mpv3VMkdB3WfYd1nv+/t2/c+8FZXP
         oXAPn4DLTDmONjzyf/ugdRTWpLwzT3/gWRRHvWNhoDYks193Sgz8zHufyKI5hUZExxtR
         /6WxULY0CQ3tEM1w2AHJoCndBtMRK6LnDIM+5sNVJGyq68TecxGusmEi87yl/49cIqkQ
         T3G6p2Ys1jLNh1IE+ZRPO2BukQ6qLOVssCk6jji7KWiuKyyJ0fFIOwzETkaj+alaMTJk
         /5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752579571; x=1753184371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhdF9Yv+ocxCNpwigI26KHR6mp6iXHv5oflRqdQCh5E=;
        b=jkwt9xQxLn5lvmVVM8uzI1L56LOLDeHGheyh3GMoa9lCuz5TDvghdChTRKJtkHSFsR
         pMyq2N+J21UnSGkGCfw4hQ4cn7WL0YDlzZcnqOlaUlvELaz2aejtIbMBLQHlF3KxmebE
         Efaal+nSdpVFD5h2mrpQxTv0lZufC4laWl4XSAkDAuOQx55VVBlJe6z3jrV2HM3FHBQB
         6Fy5BetC9Dy6MDuRbFSqnfGBJ9GX8u9aot37CTkhbgE+mce6NNBFYEskPkkb5TU6pw9g
         OIG/U9mFySESm5GbFtTBNGRDl5nseuzV7xsyDj3tMUvfzqhhgK1tdOxivGQcKmMQznFx
         5xWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsrA8HZGnQ64vuyKGyxa+BphbGhvdW7P9AunWUrYnRy7nMZaKP0qe8RHwk+mXcicBXn0fUmLB9GZk4HV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7JzPcxvbEZ15JorsnZUHebWYqqN7jqcrFjoX3evjuEQj+qt+Z
	6s7rEWlAAS7W0kc5ifco2cOJgnoegVLi31XRBYpsm4+j15Xy1M29kTqy3jm96eF/tiEpaVgjxDN
	FeUclf0GFcpLGzy8wjSiqwkwhkkR511+gBIGC709xog==
X-Gm-Gg: ASbGncuEwyEfaCAMRi8axWgDi2X6MyNoRiIGqlwPp4wps/a0twjhXEEJ2pxzMUJzv3Y
	v9UewiLN8UOH9GjVTrCT5TojKxInKFlFqzl5CXsbQYpsw5nAJmPhxNYfxD4ZU0vRAFc1bTpuDnR
	QeIhuV2JfEDnOTxKltxlnD4h+qfOLEcSWUW2tsVywtoT8j0YWr8GxiMJPqbDH/mMOCZ5LV4ATcf
	MASmNxI
X-Google-Smtp-Source: AGHT+IFpNo6m2jKxrLFJywmpCePiEHAB4ueqq//e+oIfr6dzryrMEq4r1A4fQMLYQFve8ARlc7cumyRBk5kOl2ibfIA=
X-Received: by 2002:a05:690c:a99:b0:70f:8883:eb1a with SMTP id
 00721157ae682-717d78af82amr271581787b3.6.1752579571263; Tue, 15 Jul 2025
 04:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6191258.lOV4Wx5bFT@rjwysocki.net>
In-Reply-To: <6191258.lOV4Wx5bFT@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 13:38:55 +0200
X-Gm-Features: Ac12FXxlQ6Rul8fpbADmy4e_n9zSxErO-V3JMyWSuQQY3mrQaNd2GM_CLg-atE4
Message-ID: <CAPDyKFqs4-TZy8Vj72TwRUjoUp9V=yXGDUksRe7FhKVVwnvAuw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Update power.completion for all devices on errors
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 19:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After commit aa7a9275ab81 ("PM: sleep: Suspend async parents after
> suspending children"), the following scenario is possible:
>
>  1. Device A is async and it depends on device B that is sync.
>  2. Async suspend is scheduled for A before the processing of B is
>     started.
>  3. A is waiting for B.
>  4. In the meantime, an unrelated device fails to suspend and returns
>     an error.
>  5. The processing of B doesn't start at all and its power.completion is
>     not updated.
>  6. A is still waiting for B when async_synchronize_full() is called.
>  7. Deadlock ensues.
>
> To prevent this from happening, update power.completion for all devices
> on errors in all suspend phases, but do not do it directly for devices
> that are already being processed or are waiting for the processing to
> start because in those cases it may be necessary to wait for the
> processing to actually complete before updating power.completion for
> the device.
>
> Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
> Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
> Closes: https://lore.kernel.org/linux-pm/e13740a0-88f3-4a6f-920f-15805071a7d6@linaro.org/
> Reported-and-tested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1323,6 +1323,22 @@
>         device_links_read_unlock(idx);
>  }
>
> +static void dpm_async_suspend_complete_all(struct list_head *device_list)
> +{
> +       struct device *dev;
> +
> +       guard(mutex)(&async_wip_mtx);
> +
> +       list_for_each_entry_reverse(dev, device_list, power.entry) {
> +               /*
> +                * In case the device is being waited for and async processing
> +                * has not started for it yet, let the waiters make progress.
> +                */
> +               if (!dev->power.work_in_progress)
> +                       complete_all(&dev->power.completion);
> +       }
> +}
> +
>  /**
>   * resume_event - Return a "resume" message for given "suspend" sleep state.
>   * @sleep_state: PM message representing a sleep state.
> @@ -1499,6 +1515,7 @@
>                 mutex_lock(&dpm_list_mtx);
>
>                 if (error || async_error) {
> +                       dpm_async_suspend_complete_all(&dpm_late_early_list);
>                         /*
>                          * Move all devices to the target list to resume them
>                          * properly.
> @@ -1701,6 +1718,7 @@
>                 mutex_lock(&dpm_list_mtx);
>
>                 if (error || async_error) {
> +                       dpm_async_suspend_complete_all(&dpm_suspended_list);
>                         /*
>                          * Move all devices to the target list to resume them
>                          * properly.
> @@ -1994,6 +2012,7 @@
>                 mutex_lock(&dpm_list_mtx);
>
>                 if (error || async_error) {
> +                       dpm_async_suspend_complete_all(&dpm_prepared_list);
>                         /*
>                          * Move all devices to the target list to resume them
>                          * properly.
>
>
>

