Return-Path: <linux-kernel+bounces-849642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB22BBD091A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C5B34E7629
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C3B2EE60B;
	Sun, 12 Oct 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsi7X9+I"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BE52ECD0E
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760291971; cv=none; b=MdiR+WTiYSMzuUXrl6aSrfyaU9UTuyXQkBMcchodLfsYOwSlDW5CVIvoqhfbVKQIUG5eX/FVfkK9WSzic8bKEba8OddvCriYmvu5LdVyGhuMI/SiSMz+MBl/nOFV9WNaaGL3SuVGNcX+cSnU7qEPvjvC7tCyi8mj9ZtaKr5NRI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760291971; c=relaxed/simple;
	bh=qWt8KlsS667/DWj7CEknkJJNlszKHGEwCFpf/nti7Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neVz0XYIqf2IPbgwOsrl6JTiLf4xevn9d4SRCgRzF3UnMpicHbcyU3OYwNMpxxkJSDG2fO5yl7LuGkpzYpbB3+UL+34LbVq94FNHAOuN4tAK6gDf/SKzFolSYJ/Pm7pZ0ZDaUBeBo48xX6oonOnY+2kCxyjeyEBzu/4dS3FFYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsi7X9+I; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27ee41e0798so57190285ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760291969; x=1760896769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvLTpqWhUMNwfKi2DUzR3zUOBPTWtPFJRGCtsVkQ/g0=;
        b=jsi7X9+IOyGJnrlnwk/I0epxiqgODnSleiYV2QS8Cy/Zz9py4xvwveWbLY89SEfAv+
         rmB/3GInpQ35zXpZ0N3NPCTy7crlZ5MTTubVQNpvwzJjV3ItLfXEpR5eVSXgdSTD5eO8
         w+TIeRfLVuASWRI9ZVw6geQr9Fxzp65I+nnve5zUvwFqptApIdH4Mae3axVhIiTq0HC7
         RA7Kep648q6x7nMxMcR4xJUShhDi8ZEzAjOiD9L0OP6ENQsKqWFgVfsjkPwyVVUCRvCE
         TkrM0ILJLE1oAIPA/db2wtSsjkIwjDj7qUrEGghA5GTAnLwkwu7PFIH8zz/klq28QEw1
         b3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760291969; x=1760896769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvLTpqWhUMNwfKi2DUzR3zUOBPTWtPFJRGCtsVkQ/g0=;
        b=p75KElamUbdQ+0ilkKfDjhj6bAGGPH2mKbPrjVfeJWGYiEt+Ek90Gne6p4R3SKal67
         ntXqLjyd3z4MBL4ejnSl8tuOiCtv5/0MMYLlWHuWV3JbHIuzJXCLmgeEf4bh4ODPDvd6
         dlq7ZabblBPF9i15DbzD5vtLnvcHP5SUJFOLVfPsS7cm9Ejam/Hc6TIDvYtulTQyQabi
         hEfKm9B8FioamEYVUjN3426XZU0s+auMQlZQByNM5VPSKFEgAyx7KhSc3jWRYZ1R2dxN
         LlO4Oa4/iBU7A6pv6PR35+i/YaAV8Te+3Dd9pmp4zzA7cmuGH3qU35MnU+OpbnJOk4SP
         A5QA==
X-Forwarded-Encrypted: i=1; AJvYcCV1N0AtQ1kJl143ifflkaM2TNTpd2oa4X3DYA2aMspIMWwu1Hg8c5vmnSGk+GkX1GhTKG4uchgFmrX/wEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHyRaTmHtB467HO7TWMi1Dc1w0iyVVUprWi4B+HqHejmQA/1k
	VCHHUMHVvkpR+GB1JmCpbK4C888y6U2X5QaF5t3wcfuAOvK7Rw1bh2Iq
X-Gm-Gg: ASbGncuBgTnHuJohSmMJMy71HXQivbIqvuAqaqEzDFWXVSCOKJh6A0JDQjI/vgbFc5W
	7CrN4gLfJfm54SbiljR0GQksTGAlKxA9YWBwl1oQz89/4hEHpc+hyTnmTL0TOzURHzwZQlD/9nB
	a0+SukxF0bx/vq7gUMrlFHzRi0kwtUgxc46x0aZ04TBcMLmMl+dA1mAI1Qk8lzkuOoQ54Q5RewR
	2tEebFY6CRcciGbYHip6bHJPoWztepv7tgwAHn7jAWl+kOy8XW5vDK57A3S6Ql1zQjgdLtel2Vo
	ZWVY4/x486gvq23isQzsJB2ukRKfxRLD6brVrztyEzOdXKOVKlDqsqCUL6ahIotgbW0HwzdBIkm
	duHLzkel1iBBaop/Wm8JujZ3er5eZGzltWb9GgzucZdBV+atr/IuQHg==
X-Google-Smtp-Source: AGHT+IH66mjgwju+uytBphIGoHpFDHA0VnVMlPqCCqqHrYPKBigQsM48Pjhjh2izDM7DkBtwCGDObA==
X-Received: by 2002:a17:902:f642:b0:270:4964:ad7c with SMTP id d9443c01a7336-29027356555mr258463735ad.2.1760291969153;
        Sun, 12 Oct 2025 10:59:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2905571d68asm45135485ad.2.2025.10.12.10.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 10:59:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 12 Oct 2025 10:59:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] hwmon: sht3x: initialize variable 'ret' in
 update_interval_write().
Message-ID: <7fc29d1b-4c5b-4a0a-b591-dd260eb6acfe@roeck-us.net>
References: <20251012-my_driver_work-v1-1-9e5fe6de51f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012-my_driver_work-v1-1-9e5fe6de51f4@gmail.com>

On Sun, Oct 12, 2025 at 05:13:27PM +0530, Ranganath V N wrote:
> fix for the smatch errors:
> drivers/hwmon/sht3x.c:606 update_interval_write() error: uninitialized symbol 'ret'.
> 
> The warning can occur when both the data->mode and mode which is
> derived from get_mode_from_update_interval() are zero.
> In this case, no i2c command is sent and ret remains undefined
> before reaching the coman return path.
> 
> When both data->mode and mode are zero, the device remains in
> single shot mode and no configuration change is required.
> In such cases, it is correct to treat the operation as successful
> without issuing any i2c transfer.
> 
> To address this, initialize 'ret' to 'SHT3X_CMD_LENGTH'. this makes
> the no-operation path return success while keeping the existing error
> to all other paths.
> 
> This change removes the smatch errors. Tested by compiling.
> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>

Applied.

Guenter

> ---
>  drivers/hwmon/sht3x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> ---
> base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
> change-id: 20251012-my_driver_work-77b22c239e99
> 
> Best regards,
> 
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index 557ad3e7752a..4b52d57eaad8 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -553,7 +553,7 @@ static int update_interval_read(struct device *dev)
>  static int update_interval_write(struct device *dev, int val)
>  {
>  	u8 mode;
> -	int ret;
> +	int ret = SHT3X_CMD_LENGTH;
>  	const char *command;
>  	struct sht3x_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;

