Return-Path: <linux-kernel+bounces-867131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AA0C01AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FD7A565E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C5732861C;
	Thu, 23 Oct 2025 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKcnDu1U"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8198328625
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228076; cv=none; b=kj4wAmQRvDDyaaSn7y4S0F66KrnEU/75JeBjHWv7nPcCpygFdd/auO1oo6OFsbcZaAFAJDJjcj3xS75/2SmEaNWYn+t7+zx9KxyhX2ZuiBFq1wleSK1Z/hCkC5CO1zR81Ev5sA3GL3BF/LGoqVhi1a6VvVr6yi3ARLXFJJSVf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228076; c=relaxed/simple;
	bh=JnMWVm8H5Ck5TN7RGfsn5EcNXl+YklqB9zPZXCC4wAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsTGG2RSdvDQFn75DvQBG1GbBGkSzlFtTgpKi3/NvAaMHe+lnVnQlfP2ZHcuFA6ET9r4sI+LE/Gz0jmctkl2l08I6m53aHyqWDyodJrGyf6cf7NzBcZBIrtV5CBpEByKPPZqqoHfm4z1wQKqJHUd2ZdASq4p5fpbLioZy9C445E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bKcnDu1U; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4710022571cso9082505e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761228073; x=1761832873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JnMWVm8H5Ck5TN7RGfsn5EcNXl+YklqB9zPZXCC4wAA=;
        b=bKcnDu1Ugc8m1FO2mnc9vhsm9Gt701FFuUye9pb+IQLedRuOOPZ7GH9xP2YLtnqaWA
         3VWYZdNJluPWjsWKI7bj08iE3QMIoaJnU8TwJUYPVn/0XA0XkuqAHU5BXj7LoJjjzhI+
         Jt/w+MfFqdWkbmI0HsqDr4W7tk+853JoroELlD6yHZaI6anlSaR+rYrmNHOp1jmiaWFD
         bRyN7v/bJVXOET0nkcYsGPOCnkR+dK/eo37HgXt2JobJRvmuyK6SZzZEl2gA0M2s61AR
         mECOx3QCU9G2NjOSy3w79ydxc1TC77gKKwO4rdMFp48bKYCp+HPRYn1Q4LKcTYA2ZnkS
         9wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228073; x=1761832873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnMWVm8H5Ck5TN7RGfsn5EcNXl+YklqB9zPZXCC4wAA=;
        b=sANq8FCUsOHCPX20d/Xkxhm8q4k+Nqbe3rWiAziwih9wRq65YEoNYsDOIr0mOL7Cfd
         jWo+nURmeFVSnBGzBNXT+tb1wVgHzTMnwowD19hzRi5D5mxD+RKgg36Auib8sMvpZF+r
         AtErq7/CqCi7ZDKiW+SCp1gj3Ew44TqXoNJmYU9RcaOHUSTo7mdv8toQQBTAyRYgRu5v
         MiyOQF8KPMwkG4h7kqbcgM8WbX00BNGFzSktE9kDfdgEtXsx6VDwtvHrDwQXO8N+o/tj
         WirEZPO0ZBmmFuM+MmvTIMKmOreULXgur7Fnia6Yt1O2jhorD6p1UvwHa78WPeAEwZJH
         4r9A==
X-Forwarded-Encrypted: i=1; AJvYcCVqMRTf17vhFiGn3/lADrw4R5uAIUfDiYFSIBejBQMqUxZfwejAjbOoXqHl2BtWhcQyThvbF9+zKw8JWL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZSxj3kqCJqncfI78AMiVQLDnthRxkjO7T8WM79UY4+k1ebdA
	viXVbi+PUiMHj21FT0J6nYfiZy9/sZObkV6KHQJZ/Ok1TOtHyBP8SrV2+huAC/7IA3U=
X-Gm-Gg: ASbGncttf917+vZuW2fD3F8ag+hb3MMuAFSNrOaCRO2IZobNWckxJoJuU6EZwl4aU6H
	+HezDrE0HKdN2zLEwgZ2qBPKGuhqJyoviKSPVoYdAutbahtY6XPAN076MnItMmGEwyliHy/cnvQ
	3W3mgsZL4u39LTOk0V0g8BslQyxJy9G1lF/F0ACVfnyCdkgjc+8GanDQxexXQIdRcWd8XNyrPjl
	wPjBoQ0M8fHoyYYR4jNFIMJCUKiZd1yFPe9dQo3syxfRGLkmmbJ6cY6AiFhp+HdhwpjFOuNtSyw
	+yBwfPSq8MlL7YQRoIszzxCiAz1qp6B70Tk+3s9S1HHkt7KueJdCCLiP77TZkJO3aiEv0xP6HKz
	7COaETU23ilRbdF4pMguJf3NvClUqNQdTlm3HMmIZBhvcLoIWXZSpnO1dYOO0eDSQT4vSUN2EVU
	gKSIdRQw==
X-Google-Smtp-Source: AGHT+IEQurVzp77OCpHZFz2TRcOchNrP75ZwR0sZ9FlZgnu+xhnNBWaXzzz3i5vljtf/+Kejv/936A==
X-Received: by 2002:a05:600c:4688:b0:46f:b42e:ed87 with SMTP id 5b1f17b1804b1-47117925eb5mr165543035e9.40.1761228072957;
        Thu, 23 Oct 2025 07:01:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475cae924a1sm49352875e9.2.2025.10.23.07.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:01:12 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:01:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: ally heev <allyheev@gmail.com>
Cc: dan.j.williams@intel.com, Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Whitcroft <apw@canonical.com>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hunter <david.hunter.linux@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
Message-ID: <aPo1JU7pe-vvQzEf@stanley.mountain>
References: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
 <68f7b830ec21a_10e910070@dwillia2-mobl4.notmuch>
 <f9cabfed7b165299b8048670e548c671f300f2b2.camel@gmail.com>
 <CAMB6jUG+ES6XY7NL5TF-hFVDmz6O5rd9T-HNk7Q+pJA2_9g4Mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMB6jUG+ES6XY7NL5TF-hFVDmz6O5rd9T-HNk7Q+pJA2_9g4Mw@mail.gmail.com>

On Thu, Oct 23, 2025 at 04:38:43PM +0530, ally heev wrote:
> I will take this back. Found this in `include/linux/cleanup.h`
> ```
> * Given that the "__free(...) = NULL" pattern for variables defined at
> * the top of the function poses this potential interdependency problem
> * the recommendation is to always define and assign variables in one
> * statement and not group variable definitions at the top of the
> * function when __free() is used.
> ```

Ah, right.

regards,
dan carpenter


