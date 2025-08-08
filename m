Return-Path: <linux-kernel+bounces-760743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B212EB1EF8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18311C26F20
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813262264AD;
	Fri,  8 Aug 2025 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="foVuFZKW"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5F620F069
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685476; cv=none; b=mdpRcIx5hyrINJC6XKNECG/Z9MEEw0XpCheicdpTr8EH7T90VNNH9JATYaIFij/u8K48f4VSqJej4Ao/UTa0ySz3k24Y8rbZVNd/y04w0Llxip2HLvt6fEa52XRY3nJiFDV2cmb1F6nnJSv8UZt0tsNPx79KQ2mblC5tMvep5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685476; c=relaxed/simple;
	bh=+6LsQBm4QPhBEatSkMMcv9gFRZ0fm4O5m2FYBmYd8oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otZDAxNZ/bim7shexcky1z5r/GaM4T0ATeczo4pITaQcY+kNTqWtKf50VFhmfhmfhvVISZfJ3W+G+VoCboyh2CNfpevw/l2qo4uxue9e7NRzpaesxuqmH41MJcCuYtphMOBojlZw1sOvaXnilRS5uiZjgmH7ed1mMXjuv3e6eoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=foVuFZKW; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-881985fb9edso83172639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754685474; x=1755290274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3cL4173TD/GE23drUNUHmAMHH2CpGpaopBf0wJi8Eg=;
        b=foVuFZKWPYlA+dJVSqX9oKcqP9ANlZFiAi9lKjfIG1kSi9lqsmJ1fmb6bOpWbFwAbP
         0urXzm6F5fR6Bvc92gUsZdX5EN/MB+jE8LRPOF/Cr42V0ufQzloki2CEWX/yNBplvKIY
         DJnY1BfmWovty9l85xFxzi2wJHKqEC0MeWy9eQAvWIC8FJWug0nHo5Xl5LHuzuOM3xE4
         c4LJ4YwkacRQ/6LxVxqP53+5kboXWR2WbvQoY30cAahkZEdgz5di8ydMzc85Yha+igs4
         jWr9rratWFuWy/kbn5AtkCoiwfkC7OSXn2SxIEmzYFnMGwbGLMn3e/yAYTW86k50qClM
         80DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754685474; x=1755290274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3cL4173TD/GE23drUNUHmAMHH2CpGpaopBf0wJi8Eg=;
        b=eqgbFBEKBYXywz6p9DiB8HHl2sIT7Sk4nO8BjgKqsTq1IgsqVH/vJkU0nBd2yaoH6Y
         xftG8h+diER3okTKFdiG3h8rnmI8q1pi/mUmM4Iufi13wI9WeKH7yecE1J+4K6xZ2bj8
         fX4opVNppauv7MlQf91c1s9CYCd0l60eAW/p0Bnizu+DNoRNAzMXVcNF7JGt7u4Shfen
         mScbjD15eYzGCkq8A9F1ySVhYhRStFwcx3KGsWT9qc2tjhPop3kihXORMKhFyBkWA4By
         2IOBnMZxvZkjeBysTJUf4hfrorF34xHXlEn8Y3eHKUl6ufnR532WZ+RRUiUHc7DAc8Zp
         +TxA==
X-Forwarded-Encrypted: i=1; AJvYcCXrIBoUsyqpW5F3grpD2YYvMkCKnXYt/Pv1vl8bwBgLD7lRnnFGqx9JAwxar8m88v2tSBqLpBXyz0AZ2vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK0LClGCHMPWqsRxKXmyElS5aH6hyKI5PUEBVd3oi5hG5U1yJb
	U6jSjaCNXmRuP3er6GFaxXsO2wnRO7MS5pATq+rp1oNslfRBL8HYJri5TTlofEUJchU=
X-Gm-Gg: ASbGncvC1v9IyJ+WSwCwOd7Jm9PY5bHLgfPdsm6oG0SywjCUFHzhA5xMUcilnew7FER
	48IEUBymc2mcqwWAESXjna6om3GAOXSRb/s6OnFYKrQ14fpyyvkp5yXlym3hVO4gsRCSQA995U1
	Ib05zXv6G0z01GqJ4qJoIWJunj4f0E+kTiIwsZzpJg6YfzwACmGXrLrpfcJhycwcpebxcN2wrQn
	ObOlWptw1JRdmuT1W+KqWlPU3WCA7d+CThwrF5AFr8ngulWvIAqvfEuLUvMv6MWFDZyOkDZfq4N
	69ewzjTFHv6OYgsaidt2QbSnD032jPBuzUdD9r0xjRtk56FzhCFtMmNr0KO3de1FV1H01s3vChQ
	VWg==
X-Google-Smtp-Source: AGHT+IH3T9GniO3kCs0U0D+h3PJP0VuPWpGN/Vxl1xLYGpAFBBVll3FFeR9g+Gn5YSooj3vdJntuWQ==
X-Received: by 2002:a05:6602:6d0e:b0:864:68b0:60b3 with SMTP id ca18e2360f4ac-883f126e6e2mr962460039f.12.1754685473932;
        Fri, 08 Aug 2025 13:37:53 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:8255:4e6::7d:6f])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-883f198d551sm82229339f.19.2025.08.08.13.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:37:53 -0700 (PDT)
Date: Fri, 8 Aug 2025 15:37:51 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [PATCH 2/4] ipmi: Disable sysfs access and requests in
 maintenance mode
Message-ID: <aJZgH01YM9sFRkUO@CMGLRV3>
References: <20250807230648.1112569-1-corey@minyard.net>
 <20250807230648.1112569-3-corey@minyard.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807230648.1112569-3-corey@minyard.net>

Hi Corey,

On Thu, Aug 07, 2025 at 06:02:33PM -0500, Corey Minyard wrote:
> If the driver goes into any maintenance mode, disable sysfs access until
> it is done.
>

Why specifically sysfs reads during FW update state? Is there an expectation
that during a FW update, that redfish/ipmi/etc... are chunking/buffering the
FW payloads to the device, thus needs write access? I'm assuming that the
device is blocking waiting for paylods to finish, so sending additional messages
just get ignored?

> If the driver goes into reset maintenance mode, disable all messages
> until it is done.
> 
> Signed-off-by: Corey Minyard <corey@minyard.net>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index f124c0b33db8..72f5f4a0c056 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -2338,6 +2338,11 @@ static int i_ipmi_request(struct ipmi_user     *user,
>  
>  	if (!run_to_completion)
>  		mutex_lock(&intf->users_mutex);
> +	if (intf->maintenance_mode_state == IPMI_MAINTENANCE_MODE_STATE_RESET) {
> +		/* No messages while the BMC is in reset. */
> +		rv = -EBUSY;
> +		goto out_err;
> +	}
>  	if (intf->in_shutdown) {
>  		rv = -ENODEV;
>  		goto out_err;
> @@ -2639,6 +2644,12 @@ static int __bmc_get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc,
>  	    (bmc->dyn_id_set && time_is_after_jiffies(bmc->dyn_id_expiry)))
>  		goto out_noprocessing;
>  
> +	/* Don't allow sysfs access when in maintenance mode. */
> +	if (intf->maintenance_mode_state) {
> +		rv = -EBUSY;
> +		goto out_noprocessing;
> +	}
> +
>  	prev_guid_set = bmc->dyn_guid_set;
>  	__get_guid(intf);
>  
> -- 
> 2.43.0
> 

Best, Fred

