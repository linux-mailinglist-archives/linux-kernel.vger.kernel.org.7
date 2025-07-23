Return-Path: <linux-kernel+bounces-742562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751DBB0F3B7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA30564D39
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169EB2E7BDD;
	Wed, 23 Jul 2025 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="pIHmasZB"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056EC2E762A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276228; cv=none; b=mTM8JuuwPeBlBK9z/yYyxswA9IJA/hXVGxuXTqrt8u4n/bxIu0iQT3crsOakBfj7QlI2J9b2LlDokG/nQVzkNcnRM6PdG+6nV4YVWKbL3SPK+fL5GH5ZsXnoB78rtjyu5HeSsptKHDU2g6Er/TPKadYU6qzocF3hPNiaZ3KUNvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276228; c=relaxed/simple;
	bh=vhBAalWa5gqDwmnSu/rBsFgFjTeJbqxDSovXVqBa20A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3a+NFgYAMqXKXkARayfK3Zgd/Ac7pQshr1x0wxluQEgSH7jwHrVua1qL7699WfP/nUcEPBy103sdYOc1U+DGf4ap9m6H4hhWyFtQ5aZ13RgvQxOrHTqPCKQ1i3OH8Tg8lEKULx1mp94su+K/yrG4xtQtzk/Qa4YFciVU3AROfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=pIHmasZB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a53359dea5so3216673f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1753276224; x=1753881024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhBAalWa5gqDwmnSu/rBsFgFjTeJbqxDSovXVqBa20A=;
        b=pIHmasZBcQ74ijjsISLBNbNCOz53btNAxANZfw66j3L2LkNuGcfR2DrQFNtLXsBQwD
         VHNy38J5cr3iwKR29fa/BQZXz8P9XEq5NA5EWr9fmPhClXmBWFLxPpbWhAk6hn5TOoeU
         s77tnfton5cD9h0NxX9sGNATlGU15cKyAY53l8jdOu86e8SG5f0Zl1ktAqPx7xUWeB+g
         N0qK0CeWNDfSZU1v4dNQIF1CXDX5dEObdKUWXeDv/8rUCcXsXDVr7WjgzJh7w4HATBxM
         sqS0a8Jai4OfHpaCbNM+1wf2hMkZlks83DkytfKCx/95sRkomREJJGUUYIX5VB2t30Lx
         3DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753276224; x=1753881024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhBAalWa5gqDwmnSu/rBsFgFjTeJbqxDSovXVqBa20A=;
        b=va1rqbbJsnRoDO5qzOgFt/e1Jo0ReFVWUGDVyIz0cBnsWewxbkgxPoAcsiO2r8UU0M
         mH8Y1oJlffQaCT7GzrKQt3Cj+PQUo6FasVX6V6ZgvhgAIKs9oXb7OtTca4efxh/1JliQ
         N+OFOaQnre3+7sfYhKgXszQf28KhOuQ4tIZLGn/pwG9WCZV6OFxNoDxusI4xvxnNaR0E
         /tP57JxSRxq+L0FrOfglFTrbE+GZoAQUx1gdcBy8Vd7oiydd7DYIaRufP0Nu6mglYf+W
         bs/5I2l7qf0z78lfyHth2FoJIa9tRkRQCePodFIoyffqgQRpZWokW2FtWf4InX3v4/K4
         6x/g==
X-Forwarded-Encrypted: i=1; AJvYcCXzvRS5M2o2B3fkfSqO7aGuwkj7lG85b2mFsjPxwSp6ZhgvL1h4b6IjwFDvxm2FIhrIomQBePY+UW/W/Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxV91lZ6zC9juYvFKClrlVMpS33D9plTNvd5boBqpr8akhaBRW
	JTEaylloVhxKl5k5Gk0+6eU3qgo+mOnX0nw1jmSlfcKg+eYKFSX4IfZ2MIw7lDbGN8jU5gi6FXC
	Vm/jNEAzp0A==
X-Gm-Gg: ASbGnctgk1AgHlUelyOxNia0T8bj8D7OZq3Sv+E2+S62XMBVg89unST+7GviLwQ/YRt
	IFDtpEHci081AOcYXabdGCuJRAbrMBimZ0uteIVdyKHKH1jvipJTfWYUTeXBab4mHk9ooIFZvOM
	Hd9vSjirVqP4GYvNiwG7odUZcDTDIgBDNIZ4SW5aeJnAUJaV6wtWq+sUEtqYuxKamYg+DY8PQ24
	I4nZpiqBv1+ZJhWj1HQ6hl0mp8dcmgzuTfCrsPwm329ISNN1WoRJQEw+VClIfj3vkNyVRFNhBAf
	IJFiiZRVVGXrTRwCyTMZk6ytY98mEzS2jktByOMOvDFo4KS2uJAQrK3j7l29nydZhFvp/0eEHgt
	u9UZ5gy7PLR6B1dqhI/nsWbGZ5+BEOFacV+nhq0fA4hthPDPIJyMV2gWTDjCn6l1s7/r41co+u5
	V7MpUhGWL/PipI
X-Google-Smtp-Source: AGHT+IHaikAjtXSOK7TzkgieFuqf48w0q0zzAkHwiGU+rMcHAorrKzxT8fl3tGpNBEzEAzrmfTi+OA==
X-Received: by 2002:a05:6000:40da:b0:3a4:eae1:a79f with SMTP id ffacd0b85a97d-3b768ef3c90mr2447676f8f.33.1753276224129;
        Wed, 23 Jul 2025 06:10:24 -0700 (PDT)
Received: from ?IPV6:2a02:1807:2a00:3400:7fcb:5e01:8f11:1009? ([2a02:1807:2a00:3400:7fcb:5e01:8f11:1009])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c813sm16511400f8f.84.2025.07.23.06.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 06:10:23 -0700 (PDT)
Message-ID: <fd4eba94-50f5-46c9-8675-cc0aaa4601c6@hammernet.be>
Date: Wed, 23 Jul 2025 15:10:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: spacemit: fix resource leak in
 spacemit_ccu_reset_register
To: Yixun Lan <dlan@gentoo.org>
Cc: sboyd@kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250723124020.60897-1-hendrik.hamerlinck@hammernet.be>
 <20250723125416-GYA738759@gentoo>
Content-Language: en-US
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
In-Reply-To: <20250723125416-GYA738759@gentoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Yixun,

Thank you for the review.

On 7/23/25 14:54, Yixun Lan wrote:
>> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
>> Fixes: 988543522ebd ("clk: spacemit: set up reset auxiliary devices")
> Can you put Fixes tag before SoB? I'd suggest to follow tip tree's docs
>
> https://docs.kernel.org/process/maintainer-tip.html
> 4.2.6. Ordering of commit tags
>
> otherwise, looks good
Thanks for pointing that out. I'll send the corrected version in the v2
and make sure to follow the guidelines in the future.
>
> Reviewed-by: Yixun Lan <dlan@gentoo.org>


