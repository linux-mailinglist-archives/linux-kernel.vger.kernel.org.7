Return-Path: <linux-kernel+bounces-787879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16173B37CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5758F3BD715
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D283314BB;
	Wed, 27 Aug 2025 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qGMV1ZJ6"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26B432254E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282035; cv=none; b=g12/datj2PVhgyWeHM0A4wwXXW5ewNZEVw/d+a9OWNIJEBUnZYEvNc4CX4FvW8toNotaAPpsjGJgXSVswiMtkEgzX8AEPhGMtvi1ZtWxDMBA7oyu3r66F6ggiXAjIn0+cC1IYziut5PROJuQQShJG/lHGWBgastg1UptoSP4xgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282035; c=relaxed/simple;
	bh=5HApl7J1+KZSg0OQPRohvfP1g3izBueYr15Dlsj4rF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7T2lQ+SG8V1jselPW5BMDxE0oI8nKxjMQRhCJNPh/ww8BL0TdwRJFAibUmdMGTOGRCjcHa89fPPX8uoixZNIBNCDtao68OY1Z2+mHsGVBByucmKJqvu0ff2lQQWzlGIQoeQrByDEOX3x/gpUZtAMExTrTySRnVXvEfehh8rMF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qGMV1ZJ6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b629c8035so16876235e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756282032; x=1756886832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+XEEEilHfE1GLhoyVzsYIneNopkvi33gatO1klgimhI=;
        b=qGMV1ZJ6G9DKbaS1t1XSH4Fghz01qch8NcwtjvQspZaT6QXvEIfBUhYtcgaF2vIX2E
         CClXdW6zk/fUoUkgwKVfeN5S34YcqbeMVL10gYQQUDnY6YqEfR4zDXn0/tqmLhEuShHB
         cLxlJK8CJ/TvpfT8vKTuMqcjMe5VfU+sK20bcPmRe0qOmcvyzalfH3Zpk1xWWHJiDsL6
         Lc27znoqDy2/RWNEtxtKDZCwQEkf9dpWlswNi/sCwzhDjBe/cDNp9giPq2cXOGtfTNn0
         PKHOmp5oeJjhpsMXW88B7M6ifu6P9nB25U50nVNWGbQgImFDqC52IBotMyuQ6uA6Xwwl
         AY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756282032; x=1756886832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XEEEilHfE1GLhoyVzsYIneNopkvi33gatO1klgimhI=;
        b=P7xPh+piThZ14DDS2imfwoimCqDaKCnfdVGHWbPyZBYibU90KHvpMTNYu6o9VJCgsf
         8k+N/6X2tabZS+nxyKYdOGFgkvI4CS6BqHdeRiia6rUfRs06iGm+Ii/2c3v0v8dHHv2z
         VQ7axelMJzDUEZTt6OWQ4IlJS+q0dyWASptteDwxQBMEjvZ31LXVhkukduGrWZ4lMYcu
         W3yPN/rFIDpxN2rtIp+N6hiep09pPnNVz53Sz8nte1UcYLnSkZczqpKsovqmrErdH6wu
         nleZtMVmY8K7wfY76ayWUmcFDdQ9B9xcPHe4wPxMiqHkeMr1LVGZlx8M97CW9KcTHiTs
         29Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ2fChmZDh58sHCwLx5sBPOHihpUXhY7MKyxOc7tHxygwpUuse/IgwpyWEc7EBcqBJjrq4rQ1088OUS4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Neu8gZUfYOYaHrcIEFREdu+aERPrIvVZ/RESWwCR6UfaB1e7
	LOQbaPrQk5W3w9ZwT3xWRafITVclPZY7UAGuEwJGV0QwCogL4kQqOTtQpmxAtmz/6E0=
X-Gm-Gg: ASbGncsVi9c9ZQLLZZ7nbnXf10eaavTwNYPP0Ch5r4Z6E0F+I87XXbuSmmToVawra71
	Mi6yU+bbxHiKcsfonhMu65Fp6CROH7Uj6/Urb7rjLVkzteoq++M1ue9FgyVROnuns04q7WwT5gr
	EBdaDt/2bSN2PiNizKmYcXLuVN+h+zFC9PfiCG//9xyUEHawxbElGcdXBGuVk9tKrSYk1et5BPY
	9aSL8I32uajPU8xceJ+eDdHTcWq4T/rjWrG3fzqhGBPL5z5dXOGKhkS1/W2hC55pbD1F+vY0XBJ
	MzFhlmiHO6E+C5vrxpvvZ9L7Mvl8YQli9k/F49ap6FAafsGR04W75Y9xbcteEEoFtU1VDLrkdBN
	XzAaPj/5J+mAZG2QWfufZU5vMDTI=
X-Google-Smtp-Source: AGHT+IE8CHB+zttlbDDIwDXRSFgPzyUYpDYBRdNDJ3qUHnqYkUBhH/KN69QYUoUlHi/jGAxq2dXn+Q==
X-Received: by 2002:a05:600c:4687:b0:45b:47e1:ef71 with SMTP id 5b1f17b1804b1-45b517f8e7fmr156917515e9.36.1756282032014;
        Wed, 27 Aug 2025 01:07:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f0f320esm19676075e9.16.2025.08.27.01.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 01:07:11 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:07:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: gregkh@linuxfoundation.org, dpenkler@gmail.com,
	matchstick@neverthere.org, arnd@arndb.de,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: gpib: simplify and fix get_data_lines
Message-ID: <aK68qXqStIwBrejF@stanley.mountain>
References: <20250826220502.210485-1-osama.abdelkader@gmail.com>
 <aK6wlcLBN1HclMpl@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK6wlcLBN1HclMpl@stanley.mountain>

On Wed, Aug 27, 2025 at 10:15:33AM +0300, Dan Carpenter wrote:
> On Wed, Aug 27, 2025 at 12:05:02AM +0200, Osama Abdelkader wrote:
> > The function `get_data_lines()` in gpib_bitbang.c currently reads 8
> > GPIO descriptors individually and combines them into a byte.
> > This has two issues:
> > 
> >   * `gpiod_get_value()` returns an `int` which may be negative on
> >     error. Assigning it directly into a `u8` may propagate unexpected
> >     values. Masking ensures only the LSB is used.
> 
> Using the last bit in an error code is not really "error handling"...
> 
> What you could do instead would be something like:
> 
> 	int ret;
> 
> 	for (i = 0; i < 8; i++) {
> 		ret |= (gpiod_get_value(lines[i]) & 1) << i;
> 		if (ret < 0) {
> 			pr_err("something failed\n");
> 			return -EINVAL;

I meant to write "return 0;".  It's type u8.

Also that doesn't work.  The masks and shift mess it up.

	u8 val = 0;
	int ret;

	for (i = 0; i < 8; i++) {
		ret = gpiod_get_value(lines[i]);
		if (ret < 0) {
			pr_err("something failed\n");
			continue;
		}
		val |= ret << i;
	}

	return ~val;

regards,
dan carpenter


