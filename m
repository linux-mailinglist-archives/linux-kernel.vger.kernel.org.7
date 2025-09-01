Return-Path: <linux-kernel+bounces-794432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ECFB3E1A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8161A81EFB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF69C3101CD;
	Mon,  1 Sep 2025 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKoCxMAT"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92726C3A5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726435; cv=none; b=rvknvnhCcf3jX6T+4UnomcZeFgCWiZimiHYuF1NQyJVigcfPZl5pJWWkT0E9g0hC0rFyZQjLVGi/zYK7Cbjy7BsC5xxyNHIuo+uGQX94xpybMvAqJPCjKrpLEXjTFNzcXFthVntB1ikYkdpL9jDHb4g8VL7oZIK9vQma63poFCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726435; c=relaxed/simple;
	bh=NLO1dCIv2EF5Y/31u0lOX1YkMwC+8fc1J9seaeU96G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgqpViT79quZdiqdfT7YDaYzfMvTwhnCL7BkV/ELF9owOW0HuBqawyfF5Q6MgILOkMDciYNku0huGCLc6g6awB/ZeYSX7gxLxtEFEqxX8n3o0/RmSk5fdIbonYlGwVZcyIawyAqzpIvQS+gIDGwdWe772prKPC4yxBnJlY/GO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xKoCxMAT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b8b25296fso7924765e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756726432; x=1757331232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EaGLia0ZyDDZwtKndRyXXNbGsxcdHRQLopkYwbNyjyQ=;
        b=xKoCxMATqtEI/1lnYihwPaOFHAy+k6fzxXvmxzqWD71Ju4BSFSGbL+bOE6LNI2/Dik
         oNC1meEUG1PuvlvbV6KcX/KqMaKJ8MmjJMmsCjUFuzsZ5kpA5P7shYTktRsSX2e3Inxs
         6b2dAU0jvrpGAohC5fVI//23OlD1LAmWdwIyb7W9GI3wWqqbXmdl58GwTJSk+u7VlaLF
         MPnVL4GFpyuC+GCP+zPAiAyVb1nCaf0yqmRxt9ZFNZfHd7kJo9yxwRCikyGBu21FH4NS
         MBwf2OTHxMPiOH9MLBPtyeqJx3QvtFHNSoN5pl6POXE72/AYwkUBBdUuj04o7ick50rI
         sYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726432; x=1757331232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaGLia0ZyDDZwtKndRyXXNbGsxcdHRQLopkYwbNyjyQ=;
        b=JT1vnhzbp5osVgZbfzmeZwATq6m/3TDYl2zu9Blps+tDljKW6cP2O6EJihp1vXrdnv
         zgRj8JYtj9Lhq+bLCxSlYfuFmIrRT581BagcItP56g+BXysHVSooVxRge1dbKzwc0v2d
         Jp3s8Iqh43GUKw7kbVQIy6+HleU7939PciEDtqZTXsX9tHC6ellc0ACpNglnWKvFAO+b
         wtNoT8a+QjH3RM+lRutES9I/6X8sA86w3ftXFvwZqmyyf5S/0/mYtksW2nBfKNbp2oEg
         +hAXzv6YE7iAwZB77Glif789yDhsUlyFafT9opsyYjWOH5SbQF3gPF6/tFL1w9+V+ToL
         UvVw==
X-Forwarded-Encrypted: i=1; AJvYcCW53OaTUA3TFxNdX69Uq2bJN6PlWh/SfwrPzOvuobVcdJN+lkTIeONa6DXSuj+uhJeG2qFiqug6l08pxl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPDrQbMhwrDb2GesH+tOXAq8ltOlmhEjDX4z4nmTJgBNZUm8L9
	g+XcVVQAyBV7PrUftxkX3FpRowdp9M9q4UJFbsI+AIk99sv/OibQk/mM4JFYWEkk1Dc=
X-Gm-Gg: ASbGncuXovwjONc3VDdL8bGBiFgELjVEbdEW8QWRZeY/0Bp+pEzmgPn62U13dRStIZN
	WjoBwc5hKRhyW5GcWZBv6OVo0JMHxiylpsRk3YHLTtFs2nvjiT1D7GdRWJXpqQWwl/n5u8Oc2yT
	jckR6w/ANjkiFjM/jGMKZga+MJfLGkl9jVwact87hMV7MHJMrLueI7P9ha+ln1AcgqEI8KYnoOk
	7JNM1wtnltcc3K97O8vxdMb0F1YW0G39Ht6EdStdL9IIvDhomOVi4+eIKfAyvxxvXNMG8KLKexf
	5yWhfwKQAwIFlyfeg1vgKA0VnUfFp4vIqwo3bLuMRzzJb2Kw8ENu4RVk4Iy+4c0PqJ0qO2Gjl61
	pJ6lqcKstC7b167d6xKICpq/l2MYXHMr6qyvTFA==
X-Google-Smtp-Source: AGHT+IHlZsFA6bO5PL525W9kRFa10Ed6TtJv6bjUkL/ZCgjzMq2fAWcbrEpWZ54ZlAQ/b0gIQUe8sg==
X-Received: by 2002:a05:600c:a0a:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45b855aeb67mr56578155e9.32.1756726431637;
        Mon, 01 Sep 2025 04:33:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b66f2041fsm141251905e9.5.2025.09.01.04.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:33:50 -0700 (PDT)
Date: Mon, 1 Sep 2025 14:33:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Masaharu Noguchi <nogunix@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
	elder@kernel.org, greybus-dev@lists.linaro.org,
	florian.fainelli@broadcom.com, rjui@broadcom.com,
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	dave.stevenson@raspberrypi.com, laurent.pinchart@ideasonboard.com,
	hverkuil@kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: greybus: audio_topology: avoid
 -Wformat-truncation
Message-ID: <aLWEm2sQpmoNYLAC@stanley.mountain>
References: <20250830173850.323897-1-nogunix@gmail.com>
 <20250830173850.323897-2-nogunix@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830173850.323897-2-nogunix@gmail.com>

On Sun, Aug 31, 2025 at 02:38:49AM +0900, Masaharu Noguchi wrote:
>     - Fix -Wformat-truncation when prefixing device id to widget/control
>       names.
>     - Write the prefix with scnprintf() and copy the remainder with
>       strscpy().
>     - This avoids potential truncation and satisfies W=1 builds in
>       drivers/staging/greybus.
> 
> Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
> ---
>  drivers/staging/greybus/audio_topology.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
> index 6ca938dca4fd..5bf8b5e29dd8 100644
> --- a/drivers/staging/greybus/audio_topology.c
> +++ b/drivers/staging/greybus/audio_topology.c
> @@ -1013,7 +1013,7 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
>  				      struct snd_soc_dapm_widget *dw,
>  				      struct gb_audio_widget *w, int *w_size)
>  {
> -	int i, ret, csize;
> +	int i, ret, csize, n;
>  	struct snd_kcontrol_new *widget_kctls;
>  	struct gb_audio_control *curr;
>  	struct gbaudio_control *control, *_control;
> @@ -1087,7 +1087,8 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
>  
>  	/* Prefix dev_id to widget control_name */
>  	strscpy(temp_name, w->name, sizeof(temp_name));
> -	snprintf(w->name, sizeof(w->name), "GB %d %s", module->dev_id, temp_name);
> +	n = scnprintf(w->name, sizeof(w->name), "GB %d ", module->dev_id);
> +	strscpy(w->name + n, temp_name, sizeof(w->name) - n);

The strscpy() doesn't make sense.  If the string doesn't fit then you
can't *force* it to fit with strscpy().  :P

Here we're taking a buffer w->name and adding a prefix at the beginning
of the exact same buffer.  Obviously the result is going to be larger.
The W=1 warning doesn't add any new information...

I feel like these W=1 warnings about string truncation are rarely useful.
These limits are not normally thought out that deeply.  Poeople just say,
"This is probably something like a company name.  Let's say that a
company name is probably 48 characters long."  But really very few company
names are that long.  It's just a rough estimate.

And really it's not the worst thing if these strings are truncated.  Kernel
messages are mostly error messages.  We'll still be able to debug the crash
even if the last couple characters in a really long name are chopped off.

regards,
dan carpenter


