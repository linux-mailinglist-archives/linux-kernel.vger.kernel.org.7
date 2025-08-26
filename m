Return-Path: <linux-kernel+bounces-786624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BADBAB35F37
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898E4364F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B6A307484;
	Tue, 26 Aug 2025 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DaY/9TEH"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2B528000C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211789; cv=none; b=DNhICVTYDMxufWspuWpmCwjHjzAKnJcLVzxe+tPcLYuwgIzZif9RC/3yuDCtSij8Qfy7GpwtZ3FRTHandmu1YtLDy+c4sU8YdBx/8z+agtc7GH2A2ltpulD428iQ87z7tO3LKkQE6NNef04QJohJyXNexF1m7JZvb/9MQn3oi8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211789; c=relaxed/simple;
	bh=GG0OZ6GLiRlZltpTWxyq0wPNaZPep3i36UPYib9zmGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqTalpmxhgk9C1puMzRXDLAHmv2vtPEYsxKEPErKsczZxfra+2c0h99AqcHgrtsxpEO6kZVBoh07th1twSpUYApIfIGhgms+JZegy1GNHDL4cYsEukCtZk35uvkSrTu72wCvulAIZD55OJIgY6gE3MRE/7kydBhtGFjlfVsqo6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DaY/9TEH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c6df24f128so2462670f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756211786; x=1756816586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gBeiE9LNukLMGwDkFXIG3w4fI05jvJOIyYobYgQIygk=;
        b=DaY/9TEHVTRCUgEbGSOB0zZ1lsWJfEmtYBiY2B7xdrP9cfKePQn+NgNBycwOuR4oa8
         CSeYVdGF8nLQIDPD9wnvFnw8FhvPa1DQKODGGXKTom4RT7VoiK8uyDBBzfZFrW99NqJq
         1O1ofvCjkhp8lShDjII5BmXwkHhaDCObAz37zKi5dVTF6hqBH5KQ/R+vxvobo5f7NZjw
         S82OlaVwnb1pP12RVStoI2OxUqyTpxkWeGmCy1zHsC1Cs2GPd3GyUDoAwbW44yN17kEh
         8HFjMEVhGHnXXnOSTSPKdpjsV3/zjdb75kbMxg33gWHCd+c/oQA3ajXdcVeA7Iln3yxy
         0iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756211786; x=1756816586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBeiE9LNukLMGwDkFXIG3w4fI05jvJOIyYobYgQIygk=;
        b=PDIPBfvzcTtm8sp2F94Nr+LYRD/3c49nupQWkS/6VvaP7mcTHZDvR1zO+eKEC8Mrmj
         5wraaHY/67o0iW3BK8JXM2Y6bapNZKXS41FUrl/TQxISriwoz41dph1TC9HH8dqNHFqp
         H7I9lpStjlRQEAWgP9PFwoblnMsOQKVZa/785sZIaCCPSORDBJC+fxUJdp2WA0a1GOjH
         0yHffevn1zdXNp2j0v0PclGIxfzfQ+0HjC90mJUnqYPYhz/B7KangiLB4kDANLBnrqsJ
         Bx9C6NSyzsxoCxFmUkgMV5mgpXmd1qrAz5OW1l4PPMycueusbY1oAFzysLZCkgSTkh5N
         26kw==
X-Forwarded-Encrypted: i=1; AJvYcCV+yfUhOdZE8p3b3LrZEI9QdflZQTvPYkgi1c/o8MexOX1eGK1O8y42/c3N7oHo8kP9sR/KHOHVQLGTwdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6vcNX24oZ0Wa7e4U0E9LGMuXYokhPota/5LWoCeJZLfqDhyp
	gp7jTaA/Vi/BRTtV8eknoMi98CyuBb9dz5nJie9DS5Qyw+p8m252axouQ9XyFasxJhg=
X-Gm-Gg: ASbGncuV99eyzPsU4pJ/YlcvyMQ5//YcyoTtAMMfjziNYUOmJT8PkmCbESqRDskpMJy
	QypK56l5s4rAv6K1CzJoRLG2j0fOjeWSVqK2CYFCCQIezu4YCtNNuVmd4MwRf1EcTWN1TNBYImG
	EdG9gA1nbFn9zDm86zKkIwjr9XzWG5NJy/dydC5gzPqcG4Ks/p3xuOy6b28WmI+39li/uvDasVT
	KVDaT/uY7TpnQOOXwIwav1clO0BWMA8Zf3a2D+Dzxf5sQ2HHZCD2fUkJcYB4sIJwRKgWjRIW99j
	rvyWzIkILWwOvw4dWKngRutl0c8bkBUrOIMiEUuQM+mgkVLcDctL11ubSf6jLMVE+vobOMgdPbE
	/RFYVIMbJu0WgO0qUhHxAAQ7XTHUdKfOYKZp7dA==
X-Google-Smtp-Source: AGHT+IHMe18dV7JNEUnQGXIlUU6xJmQSIHVCHST1ZqMCllJ6NRHrhQ+rT4IdFNx8d/Wdk/LNZf+F8w==
X-Received: by 2002:a05:6000:240e:b0:3c8:89e9:6aa7 with SMTP id ffacd0b85a97d-3c889e96e2fmr7372053f8f.2.1756211785879;
        Tue, 26 Aug 2025 05:36:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c7116e1478sm16017950f8f.46.2025.08.26.05.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:36:25 -0700 (PDT)
Date: Tue, 26 Aug 2025 15:36:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Rubin <matchstick@neverthere.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: gpib: use int type to store negative error
 codes
Message-ID: <aK2qRRoXViUS-0HL@stanley.mountain>
References: <20250826123208.300145-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826123208.300145-1-rongqianfeng@vivo.com>

On Tue, Aug 26, 2025 at 08:32:01PM +0800, Qianfeng Rong wrote:
> The "ret" variable is used to store the return from bb_write() returns
> either zero on success or negative error codes on failure.  Storing the
> error codes in size_t which is an unsigned long, doesn't cause an issue
> at runtime but it's ugly as pants.  Change "ret" from size_t to int
> type.  No effect on runtime.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
> v2: Modified commit message as suggested by Dan.

Awesome.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


