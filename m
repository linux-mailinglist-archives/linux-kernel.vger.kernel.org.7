Return-Path: <linux-kernel+bounces-788080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE18B37F83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C79189FF75
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB0030F926;
	Wed, 27 Aug 2025 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XY0Z3EH5"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571EB28312E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289384; cv=none; b=U4qM2oQbW0B4cLGu7oCf5ED+2wOFOljQL3w1gAHD/p96HZPgGny9P/ChqfxiZqVHJ6pnLooLl9vPM8whrTU/BBjKVDP9H/qc/Jp9hkm7xLKYlPER9gJlWmf/OhKK6bqX9t0HTXujm0GOj2b20XkPzMucSxvyL7SLh7F//niUQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289384; c=relaxed/simple;
	bh=J0lkcTHUid3XxD8U8mPToo1lJJyfeJ5m6rE6h09yz5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUZA4gGY2weYkbjWsREfZO/UN2WlMPlgNlkZcqZv8dch30SUVOYNI7QTrhHI1b4EMZccH3cp8YeaL9OsEgftEK5SMx+j/7n2WsHesPQjLRLzyjji52cb8bGhUAc6y1wqSn6Yuj/RUNlogiSoX7WQsofyYHDaV6Bb91w4IlP3iFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XY0Z3EH5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso40062065e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756289380; x=1756894180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPJo3DFYnaR9E2CWsARN7ky89otQMe3GktK/razN7cg=;
        b=XY0Z3EH54LMVqJ3elk1tZwb9GedNQAzDTTqZ+CDMo7DDlLEHVpp2uFfC8sE4PjzoyJ
         5O4xsIXIz6m8nkFru7QlaFAYiDFMEEHCScwFQucOcmJVBeHu5N1p+AMIz+5NhEht0ITB
         CjbGPHgHHSibBuzqQFVZK1xeUaDRJ3SdWvmCRk2eTu7Tf73fubVh79V8RKsYqgra52NW
         5udkCM94l+JsSwMygrwfpJ5CorHJnj72VpOmDGe1+JT2DvGZG7Qn7MdyGv1HTw1XF/kI
         8uL4EXd85qdW8Pe5tapE8cVVGBJOKFOCm4yuAYnOGYoYZC8rWSAPPpbX9w932eZNvZI2
         9L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289381; x=1756894181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPJo3DFYnaR9E2CWsARN7ky89otQMe3GktK/razN7cg=;
        b=DejG5KHtTGpeuZBQerwoYj6Wug82wc/6mOgdRhYnRyN/sKLSvs5XxJ+qYQHPV9+NBF
         wdK5gxAiLwTMMAjuQgXuUp7sMunkaRxgo5IAB7FZw8nzEn7Weiq+xh6/Uznh7ec0J1Q2
         Ih2+LdN27ajViczNxzyczX+sWH/AVaF0DF6M8u9A577keZc2+BqVScZiFvZQmtzEQbCk
         Ur3jAfemJV6I/tsY241QJ88C9urv4Uj8Nlht6x3RiMT2MNUpI1aK28LRz9pO5oiwBCn7
         K9Nhm/VFJKnTsk11ETGIO+UVLgqhOh+sxORZyUJcf+wQxZV6r9jxAdjq/4SA5GDNNbK1
         s8Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ49+xtdC3Uer2BNdzfIH1nTkVNQrjPZNh6/VKRw5kAKOi/gHq2kz5sp/di1Bg2z19ML8MvvbxEKJQlhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwywQ/YyYwxRUmieCan50Pupjxvs6Dy06b9OSA2YOLfR/TKJG/O
	Xv/ipoAA4u/bnA7iFeRi/o/6K4gbDGQmTvTGXuk4zKFN3CLK52FX9ZOgwQAxBAyYLcU=
X-Gm-Gg: ASbGnctdpSXQKV81FQNoowvNDcwEZ0XbqsFxdF7ilzg3SijgE7ni+LcMWPjTdXuqEdb
	sooA3XLl+YVy3qBIhERPGMxzxMbqLe6YOVhIJUUQU4VO9p4N7h2fN7muA9vj4s4EFkPuphEuHGM
	NMl1pNwAu3Tui145VTqXlp8q+Q6JNfSkSnxCRVChMVYuRzA4tURVr4BIRot9Om8Q6ImKkqROWW7
	bjT9VnSe7cCSvotxfKnYNIIYqGznpUllU6rA39VAIP7CHkgBqgj8qaimdoNmFJDuZQ6YcRPWMed
	ZJ69SET5LycQ9okvDPUK63uE/xHGRrcFKOD1jgjXuAAzFI/o9mFTSv/YaYzi6qIE+rm3pV10el4
	j4Ia653WPgKhtrVdsiHj9WObbR8A=
X-Google-Smtp-Source: AGHT+IG7OpLH6k3HwvLOeBkdHsqBfZQ/AFfCGLhvEb/bBCKCAM3IYfHng/H18tROilNBSKqh4ga5LA==
X-Received: by 2002:a05:600c:4715:b0:45b:47e1:f5fb with SMTP id 5b1f17b1804b1-45b517d8ffamr156139455e9.36.1756289379317;
        Wed, 27 Aug 2025 03:09:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cbd534656asm5268714f8f.66.2025.08.27.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:09:38 -0700 (PDT)
Date: Wed, 27 Aug 2025 13:09:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: gregkh@linuxfoundation.org, dpenkler@gmail.com,
	matchstick@neverthere.org, arnd@arndb.de,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: gpib: simplify and fix get_data_lines
Message-ID: <aK7ZX3rlcS6ObWvE@stanley.mountain>
References: <20250826220502.210485-1-osama.abdelkader@gmail.com>
 <aK6wlcLBN1HclMpl@stanley.mountain>
 <aK68qXqStIwBrejF@stanley.mountain>
 <f3ab3c2d-2056-4802-aa73-2b0db4c7fc30@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ab3c2d-2056-4802-aa73-2b0db4c7fc30@gmail.com>

On Wed, Aug 27, 2025 at 11:28:36AM +0200, Osama Abdelkader wrote:
> We can change the return type to int and propagate the error, so:
> 
> static int get_data_lines(u8 *out)
> 
> {
> 
> 	int val, i;
> 
> 	u8 ret = 0;
> 
> 	struct gpio_desc *lines[8] = { D01, D02, D03, D04, D05, D06, D07, D08 };
> 	for (i = 0; i < 8; i++) { 		val = gpiod_get_value(lines[i]);
> 
> 		if (val < 0)
> 
> 			return val; // propagate error
> 
> 		ret |= (val & 1) << i;
> 
> 	}
> 
> 	*out = ~ret; 	return 0;
> 
> }
> 
> Then in the caller:
> 
> u8 data;
> if (!get_data_lines(&data))
> 
> 	priv->rbuf[priv->count++] = data;
> 
> or we print the error here, What do you think?
> 

Printing the error closer to where the error occured is better.

How would we handle the error correctly?  Sometimes it's easy
because it's if we continue then we will crash and almost anything is
better than crashing.  But here if we return a 1 or 0, what's the
worst that can happen?  We can't know without testing.  Adding new
error checking often breaks stuff.  I've done it before where you
have code like:

	ret = frob();
	if (ret)
		return ret;

	frob();  // <-- here
	if (ret)
		return ret;

And obviously the original author left off the "ret = " part on the
second call.  So I don't feel bad about that I added that, but in
practice the second frob() always fails and I can't test it so now
people's driver doesn't load.

So adding error handling is a bit risky unless you have a way to test
this code.  Just printing an error and continuing as best we can is
safer.  People will let us know if the error ever happens.

Let's not over complicate it for an error which will likely never
happen.  We can just print an error and leave the bit as zero.

regards,
dan carpenter


