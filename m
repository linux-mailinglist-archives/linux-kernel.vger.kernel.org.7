Return-Path: <linux-kernel+bounces-875925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21386C1A251
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314FE1AA1EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B943396E0;
	Wed, 29 Oct 2025 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCdfCEyk"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D62D3A7C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761739841; cv=none; b=RgIQ7CQGABaFvye77XkLc+sNQh0hXFd6f+tIXzmpoTaQazhHsWcGP9XhW6ahisj/8oFqIoNlepOav1MeVHv9kaWO6t3mUAZ7bS39LZZ1+MrWaWujUPnUpmCVzGnrVYIUm5HmE6zIh0A/sEgSVhcy0Gg7mvweMgNSnRoPhvwmHiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761739841; c=relaxed/simple;
	bh=nmmmsqfKVAJAISlF0v0aoOiHV4ihW5X2wUL2HaVO778=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKXdpvccIajvQUjEl45mS0+Av1994QZurCuA/ijn/ljjiNDtjD64O9jjW5KkosMHnIVgP1vXtkT/cNsXa8W5rGQfqz4vo9VUiVIZb1HQr+tcmvEuO0M+EF47QUHVUsfrn8J5fdGwDoozITen7nAuSdLPiqV0HBpUYs/6whUij1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TCdfCEyk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47112a73785so45703795e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761739837; x=1762344637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9+YREs/dwvkAURlYBalhERi7T5HA8/ejvJOwTN6088=;
        b=TCdfCEykDlIyKPRaDyfq3dspvlguOsGDd2iM1TEE2w0+GReHGftA3RMZGpE0Xa+4CB
         c0MiMOkirRDjEnG0jRpbokT9wDAgcRXV2wXxCf8jgrghxDE2/4Lb5lvCEF3SDgcoVzMV
         ZlftlOOfvyGqPVj6IXkGpVu7LM7vXeki2RzUGsvbqicviUnBX6W0ni7u06RTs5DDSqRV
         PjnP0+zC8ZH5gAQN4TT91SICU/tUA1Ytci0S/VxzYtP1gzJp2QVfuv7zvBfwt1cIFEy+
         nEdXDKUU948rQren+hehbA/MMA7gvuHcDM7wXwg1wRA9dTHaQ/XhL3JAiJ5T707htePc
         m3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761739837; x=1762344637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9+YREs/dwvkAURlYBalhERi7T5HA8/ejvJOwTN6088=;
        b=ToqXdHxaDf6Phsz5zHDErktlwojm+Yv8oNF9Wvhlc9cwNrG01l0+cy6qney6hbgrwR
         YhJvn0Fw/0/OFz/1cW4JT7gQrk0wYj6P9H21HYFSGR3Y2Xp21uKh43xGHlYFEaZxSdXO
         BtvlmgF3Dw8qHQtldrzuMn1NRDR7ORjEMyCohbuLKf/dMTrPFzN9M/plvgulGWypi+Qh
         BvAmHrXWGsP2QIas65Lo1sSGB7JOI955RyAoz6roTRpbPsAgQvFHPO5qMMtrEO/dAJ7l
         T9E9YcqkYwI78opUrwW3m0k0Zrm0zh9IfZhtoWsivia7N5mKLMzRXAEsi7Xq3TIjZzwu
         TbYg==
X-Forwarded-Encrypted: i=1; AJvYcCVScEcqFYxi5ZwiNkVwnvr8UB8gDDHahZsJ1MdKCC3knuTeqP14mlx/YBbXO5maIiLjfBJmeuheL1DcuyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeOyFGR2Cqz+TjY1xNS2dQbvo66BTw/wW3T6G90+u3o29ZNUO6
	WZzXdvVe8YbAy6e5UPQ3i8DUGl6bNZTnDfcsD8q1+KbNNlucBwjJ807YgsLxXmYevYs=
X-Gm-Gg: ASbGncsafWPiLVxLni48TMBHvDM0TrBpFmLRFrp+NJORFuNQdkdwPSL2KktSO/EgqXq
	YreDJnFmILKXVFuFPKd/Vp8SW4EcJoZ0AdtZVqc0BYEr026KloG7rw56nzN+VUQ09dsWB7LL+AT
	cSnIsOzDS38w0K5qMldAADW4B8pfu6ADETMXKT67M6IEGer4dLXlCcfLdyDRzyznFzKgpLkbEuO
	uvwQ8JV8mpPRTzSLUtaS/UEbNYjiRAxGwQIAigdFDMldUJqHObnU3AJlFCt1fOr3d53EOoloyUg
	X3Y36a3xy8NR8uXkL7FBxTOe3JTaPmfo1m1qo1PKjRuXKWkFb9SXrGp7sQbZHtO2Xqwcj7AE47u
	/C6LGB+3rKEJH1AEzfDrY+aKqyF6mv4zPPi1RdcR4z4b1HQpxfnE576x5tVwwKxY4iqKHZ3wjMd
	x5To9v5PN5XCw5L/GO
X-Google-Smtp-Source: AGHT+IGIDloDBN8XL8rmy10flsio+t482MTy1ZQ7mnd0IkV1PLp8bTgCqmolXedNqKzaaInabxjXJw==
X-Received: by 2002:a05:600c:528b:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-4771e3937a8mr26462945e9.23.1761739837097;
        Wed, 29 Oct 2025 05:10:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4771e3b68fesm44788135e9.13.2025.10.29.05.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:10:36 -0700 (PDT)
Date: Wed, 29 Oct 2025 15:10:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Phil Elwell <phil@raspberrypi.com>, Umang Jain <uajain@igalia.com>
Subject: Re: [PATCH v3 0/7] staging: Destage VCHIQ interface and MMAL
Message-ID: <aQIEOJUHdVMriz7S@stanley.mountain>
References: <20251029-vchiq-destage-v3-0-da8d6c83c2c5@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-vchiq-destage-v3-0-da8d6c83c2c5@ideasonboard.com>

I did a review of some Smatch warnings.  These aren't published because
they generate too many false positives.  Only number 3 and number 7
are actual issues the rest are style nit-picks.

1. drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:2728 vchiq_add_service_internal() info: returning a literal zero is cleaner
s/return service;/return NULL;/

2. drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:408 vchiq_shutdown() info: returning a literal zero is cleaner
Delete the "ret" variable.

3. drivers/staging/vc04_services/bcm2835-camera/controls.c:198 ctrl_set_iso() warn: array off by one? 'iso_values[ctrl->val]'
There seems to be a mixup between iso_qmenu[] and iso_values[].  The one
is only used for ARRAY_SIZE() and the other is never checked for
ARRAY_SIZE().

4. drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:337 buffer_cb() warn: can 'buf' even be NULL?
Delete the NULL check.

5. drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:513 start_streaming() pedantic: propagate return from 'enable_camera' instead of returning '-EINVAL'
-       if (enable_camera(dev) < 0) {
+       ret = enable_camera(dev);
+       if (ret) {
                v4l2_err(&dev->v4l2_dev, "Failed to enable camera\n");
-               return -EINVAL;
+               return ret;
        }
6. drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:576 start_streaming() pedantic: propagate return from 'disable_camera' instead of returning '-EINVAL'
Same.

7. drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:881 vidioc_querycap() error: uninitialized symbol 'major'.
   drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:881 vidioc_querycap() error: uninitialized symbol 'minor'.
No error checking on vchiq_mmal_version()

8. drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c:1276 mmal_setup_components() info: returning a literal zero is cleaner
s/return ret;/return 0;/

regards,
dan carpenter

