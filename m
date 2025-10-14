Return-Path: <linux-kernel+bounces-852757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D3472BD9D16
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FDD6354410
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D29F18A6B0;
	Tue, 14 Oct 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oI9cYXl+"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1A749C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449990; cv=none; b=On0BW8Ty/Sz+ktXIfKHeVTJdSnOwj+3JgaO2teN6LZmAJKu4iQ58ud2yRz/ADle6bVGxW3GaJayw4oT/Blrga/JmAi1KYiFLolVTUjZtv2RBuMbRsG+aE8VWw18080l/DLZ6CDLjhAJ6turllslGkwZxVGiHFeEHI8RxnTNSyDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449990; c=relaxed/simple;
	bh=IElxN4QNGTGIaRmLgByL0OIhhUz5m3vPuXMGPnxLbRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWghI6vk7lhAGTZCrlIlyAlB2bzr4w89wFv6icg72b9cb9ypeR19IKlReY5TBG+vMFbr3zHK7Kni1oWK0+nPk07k4rdKLIirTp60b1SBIeV/v1IFV26v3USrsqqFsEqRwFh1ylk+KLKuhsdgeIQadeqIBWCL4ycSC+Om1SVJ6KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oI9cYXl+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so54755195e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760449987; x=1761054787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYLX/V/IYNpEsTQWc+fcqDgIUy63VyLnT/A3MBhbEHY=;
        b=oI9cYXl+2lD1f6dK9qT0yogzJUBWL/VxQ7wt7Ev2WZpr6ZOAastakCrVxw336aPUis
         9DOwpnp9fDW2xMCvSXad+snG4Izlc2uWP6hCS5MOo+aidkoDprTnX42kOTtWaITaq7CD
         k9Z/4NtaXsjI1aNKLB1sUWXht/xbNQmiDt1oxbZYuj4yLRlEPDKHqm4PdicTo6hlILjY
         EBe2wTQ9YP8Yi6phOGL5lor5ce74p4xGMbVKdTiHC3QKCGSdqQyIOZmgrV1y4jGx4r1o
         EiGVUj+++rtuOxj3a/5kF39NvIRq/nzro5m1Kka99LAM9v1rnreQSiPVHS+6yYx2sayU
         A18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760449987; x=1761054787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYLX/V/IYNpEsTQWc+fcqDgIUy63VyLnT/A3MBhbEHY=;
        b=Am1H6M6t8KU2baiTpnJb7x3Bh5wqJvPzNYitEH68C0YG/0yGKdR4TcF9JeoBM3Z5Dk
         BkUUj/uv2YvxN1cVoMXq4fCWp/ewk59vvyffaJRtrz46UP60dcJsdoz3ItsjW7nVEwMI
         JiY2y3AYRYLi4Y0DqZ5SoVzaC/DR77ZiyifdxF0Rns/d5h11ZEDM0HgQRJAr5XdCf+nH
         PIU9oHOgZZ2lubs6Swn+vTg4pfbJBUXMdWan8ol0BI8C219Dw2z4NjJBBelU3ibc6jHG
         svtIDFYDpPQS8ip+v0kGwrqCGCpyvCghWsoMxc2Hh3YJx3w+NzTNkzdL6H5SV9LsCXJ7
         KVrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAbJLtpLa6/mz1V4xY9KCbxU2Xocox09ps5x6It60VI8QLNEo02gfuI3X0CVuOwSZTnGiQwQOCc9epxsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmUiV3DiY9Kev3XFbXNBogAxDWcUQxHTcbu5fsfrMoXy/0wKi
	dqwG9tPS8+2OVbQyVes1u8kWV88zAy2++W7A/sX5ZW2xnzyUW+L7+9Ig+syYJz1EdsXEBjNgkwe
	AwSsM
X-Gm-Gg: ASbGnctUBIFlsrj/c5OOtXSYW27kp3146j3ZQGyXXxbnv2cSE4Q2CBvAY2RNHHRlJh9
	9wzLid5pa7kuZdlkpg8z3qzQlShpXt5zmKuA7AZwMqbQykNzWo8gahPNKOT68LBZIjGrANuMFcD
	dS4sJyM0UydsdlWk+h5GYUZT53nSKY5AHWsEm2aDoo/Ln58IkJelfNRCOuhpjc1bJRbq13NlzaQ
	KfSubTxDcDRxmQLH0ikN48Lw4fYF5Us0d47I2zCrYUWIEGJxROw7TeLVSJmiMhfZjZbL9BXJb5e
	d8ai8fJV5W89COePGyIOT0EWtMMcnFTZXxFnnXTbaetGLIQTlOd12aYXKprbVDNLkBQQ8BN47Kd
	/0usdF0gim4y958MZkQxf7bPmtFI0BA99D5vb9c2rdTpDPmsm+RVPWH+Q6xK8Ow==
X-Google-Smtp-Source: AGHT+IFcYBoVH6SZ1b0n1fUVs59heTV+uMc9my9gJaVg1Bkdl7LM1WLOakMGVQ2yKdbkJej4zbdLaA==
X-Received: by 2002:a05:600c:4ed4:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-46fa9b08be6mr157473195e9.26.1760449986537;
        Tue, 14 Oct 2025 06:53:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb483c7e0sm244106135e9.7.2025.10.14.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:53:06 -0700 (PDT)
Date: Tue, 14 Oct 2025 16:53:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: gregkh@linuxfoundation.org, johan@kernel.org, elder@kernel.org,
	schopin@ubuntu.com, me@abhy.me, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: documentation: replace strncpy() with
 strscpy_pad()
Message-ID: <aO5VvrKTswmfO-n9@stanley.mountain>
References: <20251014134148.2597178-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014134148.2597178-1-vivek.balachandhar@gmail.com>

On Tue, Oct 14, 2025 at 01:41:48PM +0000, Vivek BalachandharTN wrote:
> strncpy() does not guarantee NUL-termination and is deprecated for
> NUL-terminated strings. Replace it with strscpy_pad(), which guarantees
> NUL-termination and zero-pads the remaining bytes, matching the fixed-size
> firmware tag semantics.
> 
> Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
> ---
>  .../greybus/Documentation/firmware/firmware.c        | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/greybus/Documentation/firmware/firmware.c b/drivers/staging/greybus/Documentation/firmware/firmware.c
> index 3b35ef6d4adb..deac8584841b 100644
> --- a/drivers/staging/greybus/Documentation/firmware/firmware.c
> +++ b/drivers/staging/greybus/Documentation/firmware/firmware.c

This is sample user space code so the strscpy_pad() isn't available.  It
will break the compile.

regards,
dan carpenter


