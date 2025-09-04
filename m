Return-Path: <linux-kernel+bounces-800383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39876B43712
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0FD1C27F0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969852F3C39;
	Thu,  4 Sep 2025 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccGcI1Y/"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAA722836C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978040; cv=none; b=KyiPoJJUoAqY8XCchOKU1Au4/78iV93HOCtCSmhCReUIhxHWQoBy/NbbgTtogOlVxmzQRpobKnr3tTd07p5T+0xzlVrKZZSQV6F1hHKKi+fh2PSWotTvz1sqzps2xmUl8Kd+y80OrZzVOzziyK6QJqRwE8ETbluxklo1VNJj4kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978040; c=relaxed/simple;
	bh=m5V5yAwlWcGivcep1LpLjkL/uYuPtGhniYz5NzNVLMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huFS60xEI2KNSioqyPkKNR6taXE8F+lX+uZZG9AWu3KwLVK2/UEzPAAgDJ039J3sYSc/soK9MAbCrul0qg6wCBMqs3ecfSoD6FCsbHsRkKikkPtBzFeYeEzygINvBT9Y3RILYgqSNupk8AcqsYAngVO/4MxcqMk84Jk7dwuSVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ccGcI1Y/; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so833653276.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756978037; x=1757582837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zbvmmOuLIUDxZp1MnPrPCU4uMrAUR6dmAfh6E5KAke8=;
        b=ccGcI1Y/Un3550mew1hvH8pPUzIoh4BPibwfJKYGfNrkx6jxatssq6oLXMKJy4efLJ
         wDmHjW/C4Wnfh0H0IDNXNI1w0Q5Gxcw06i7xfJJF+PYKUGANc3HoZX/Z9KRvhdqe0D8x
         gFO0VJo1+IWr+w5bfg8MY2z9wX+QIYHgNgq8NmYj6VNK+3bc+EDQBPU4+qu29nwY+d6O
         pcgL9RFaucesRuHVHOgrNUnjqflECm4apjVX2aT3y/s28w2Jz50f3B9yODgMXDyp/drj
         tdEbe8mFAGYS+vK25Xm0myGc75dmmuJmAnBBZCBUhcGPnTi4AyPPWRkYhYnjFXslSwQN
         p62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756978037; x=1757582837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbvmmOuLIUDxZp1MnPrPCU4uMrAUR6dmAfh6E5KAke8=;
        b=tjYtmCcxndwF3zZOF6znPKa6GVV2iM+Hv1fWyUKo3/TNyUvjuolfNnZkYIOxb65sCS
         uwiqEs/iuFm34mpwlbu19o14v0QgiCJ1tNqn0v7sExxdUnrHBqpYO9g4zzaj7fqhaCvL
         j4yMX00bA3SMfKc+1JbIVRqULVKoOl45PfB6OO/6XnYzA5FEt5TPvUCPHRgnJXBBoAAp
         xouHPJHWyPEi2pbySdx7+8LbRdYzlxgjyr4cNtNWUfzFylar0V+nH+5LzKig6YVPs/zT
         XODni0LAPOGlEQV7W3VIMu+cd2l+9xUZAGY9VeqGjkjneyZ2v4v0jzeNvNHpeBv3iwcl
         ZBiA==
X-Forwarded-Encrypted: i=1; AJvYcCVaqWPm/o06WKJQBphVXkzQ1O7JTj5zFp7hYcouk1poplhJwNeJZxkiQG1crCcF/TdJVebEsK2ceEOZY/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YylorAubcu//EEXzQOKXo7vgAIYBOaGPXLBEsu3Aq+wd+GzvV5p
	uaMjDzKQZTeLQS6qO1F8+ZPqf6FAY2Npcco/Up/7/PP6nn5oypzIvW2OABvtifVb1DMJzurJLTm
	do/FePXh1N0vlxLatlqudA5B7UwqHXO0sfPZm5wfOVuW+fMfLVtDd
X-Gm-Gg: ASbGncswVgjGTq5TaXJPp2KABef8dKx8IBEN5O/j/MB79/1NcNGEupdf1J/sfBtgxB9
	ryhek3BZ80wKuqg+ZJscC0QpUzyPY9nUMSQG67Bt5UkX2Yc56LMEvuvvoF9/Bg1s5agoOmit+Le
	mN7kbkVzPlbps+JI91ouRmSHuO5sHTAyYm10fSmha+AOGLRrLDcCOKWWJ189+DcPaLRrQosCmC+
	0SoWY3UiB50J5t/nCY=
X-Google-Smtp-Source: AGHT+IHdZ4C9gIy76k2TL/mh0J4/RFSZEnngxhmBLw1tI+NSOUEGkIf8VYX6cpMLBIYdOMj5QaxWJXdV3lal6fJnTwg=
X-Received: by 2002:a05:690e:4308:b0:5fe:1b7d:8cb7 with SMTP id
 956f58d0204a3-601755b4dfcmr1559312d50.5.1756978037354; Thu, 04 Sep 2025
 02:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3381776.aeNJFYEL58@rafael.j.wysocki>
In-Reply-To: <3381776.aeNJFYEL58@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 11:26:41 +0200
X-Gm-Features: Ac12FXy9xOgdN1mtLPkFLfyCSrw6qK2l4IQFU4QEEm513md6_ixyqso-UEzQQi4
Message-ID: <CAPDyKFqk343jLYL=x=+7VcUAG_n9xVs8ZhB8x1mytYmm8C8h3g@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Clear power.must_resume in noirq
 suspend error path
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 15:55, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If system suspend is aborted in the "noirq" phase (for instance, due to
> an error returned by one of the device callbacks), power.is_noirq_suspended
> will not be set for some devices and device_resume_noirq() will return
> early for them.  Consequently, noirq resume callbacks will not run for
> them at all because the noirq suspend callbacks have not run for them
> yet.
>
> If any of them has power.must_resume set and late suspend has been
> skipped for it (due to power.smart_suspend), early resume should be
> skipped for it either, or its state may become inconsistent (for
> instance, if the early resume assumes that it will always follow
> noirq resume).
>
> Make that happen by clearing power.must_resume in device_resume_noirq()
> for devices with power.is_noirq_suspended clear that have been left in
> suspend by device_suspend_late(), which will subsequently cause
> device_resume_early() to leave the device in suspend and avoid
> changing its state.
>
> Fixes: 0d4b54c6fee8 ("PM / core: Add LEAVE_SUSPENDED driver flag")
> Link: https://lore.kernel.org/linux-pm/5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -720,8 +720,20 @@
>         if (dev->power.syscore || dev->power.direct_complete)
>                 goto Out;
>
> -       if (!dev->power.is_noirq_suspended)
> +       if (!dev->power.is_noirq_suspended) {
> +               /*
> +                * This means that system suspend has been aborted in the noirq
> +                * phase before invoking the noirq suspend callback for the
> +                * device, so if device_suspend_late() has left it in suspend,
> +                * device_resume_early() should leave it in suspend either in
> +                * case the early resume of it depends on the noirq resume that
> +                * has not run.
> +                */
> +               if (dev_pm_skip_suspend(dev))
> +                       dev->power.must_resume = false;
> +
>                 goto Out;
> +       }
>
>         if (!dpm_wait_for_superior(dev, async))
>                 goto Out;
>
>
>

