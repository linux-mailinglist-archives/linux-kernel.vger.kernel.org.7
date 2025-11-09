Return-Path: <linux-kernel+bounces-892030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15264C44246
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 17:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AE63AC5BF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123572FFFA8;
	Sun,  9 Nov 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngj2Ejw7"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE325C96
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762705262; cv=none; b=Rkc2Q141hOb0dyX1YMgvncrWt6jwkA/RcYfvDjbrPx+cEz3aznfua4HqPZS4lqIYNFtumNrfxQD4Yec+LjqkuALstDwkCzpXMGhpw+FmiGY35n4x41Jk2GIfc+ej6HE6xBhbl2bDQC7OasjjMpE8BOEp3xm5Dlx7jiwZ4GzA1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762705262; c=relaxed/simple;
	bh=61SWKbDLUNFzcXWQyijnqWFYpcX2iL5D9pAYMB12oZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3N2aOyThs+NvNxA3i7GHLwzs1I18H7JNSuallkq0pxmPAKPXSGbm9/kR5oYxTLngY2uoZfynlJO5fprwDw8puN4JgTwZVAw/LCJZxlwMO0LrsKzqJIlSOsBWxXSPGaT5LIkna9u47VogEvbGSuA3gAMYzkoywtWO9xzpG6VygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngj2Ejw7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471191ac79dso23567495e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 08:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762705258; x=1763310058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Y2ECQ1gAQhDNX2WMo5upuv1WUggBbkFJqtOU8k2avU=;
        b=ngj2Ejw7ckLHM7qB2Xzrg0lvq3/qgiCfFPM7R/Q665ANQmppBl/KRfcUFmRykmplfY
         lcFrxNBiG8TxwIIU2vPQIX5Bm3tuzYumFumh/hnQNXqToqCDzfFTdL1I7uzzPEvQ4eq5
         mXWp9va1nU0sp2apFW1LucuBGPYNfizvD4/kQ6c2lHniIEFC1wiKG8JIPa8Pl/eePPCJ
         PG5CwZtFG2A6cWm2vc46JqOq6wkbdeqOoHPi5KSEsoroUTGJMBTAFGul+72DlPDqK5D2
         9Z3x8JqpEb8ReTaNMQMH7baB6+F3XAnSR9hZUOfPLk8soD0jWRUUCy7NiZjL8fkx01We
         L1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762705258; x=1763310058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Y2ECQ1gAQhDNX2WMo5upuv1WUggBbkFJqtOU8k2avU=;
        b=uA0gSE+7rRmq/8HGbyzhEgU9CCnMgJt1uRWw7/5nFcd9OlgyXo00beHbzivLU2qWAJ
         I+kc3/nmxz1wMkT5Gx0qQWFy6sG5aAN0T9ei4m5ITp6F/V9KiVudtiQDTNJvS/A20dE4
         0fvgtVAO8SRf6G9p4rMW7hkV/dilVht6TyPVGFkEHrBRD4sY2R/+wJIbye2oD1fc3xaG
         Fan8fCgH+3nfoDtPKUd75VCkgOux4OCJqIGCp6NEGYrvlDzHJ20iwWeHYrD1ngqsJsOm
         rsG7q+o3d/p4XJ0Xe/I3ZJt9SLzMoVOGvIYnL18Lm2t1Qfxwb9YYrAsBHpEmgDJWuxzy
         ak8w==
X-Forwarded-Encrypted: i=1; AJvYcCWBc0rpQb70NLlGXvb7U5vKKGj5C620YlYHq7nN4NWr6pkIDyIF6GVP3OcqQJrYqQg6a9IV81C6ASOoMCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXGnesQbRhlBBNL/Bx2NfXI4MlHKuxYfY+LQro6Trqyv6KmEwi
	hYk/1ZdYHR2eP8k2O2LR4IXHGGyWcfJmOfQvUvdak/KnpBqzJHGaB4wpaN9vFA==
X-Gm-Gg: ASbGnct4BaU+IPinPOiX2i0osnI6/7vjRGBWCxXUQWQB/ROEvctQkmFpJHkCjGYO26T
	ka/jQWnJRicMUzAb0/aPaBZEAZl2hyvzBgOLWtEExJfNrrgrEJVNp74n2Kc1EOIBhX1bP8SjM4R
	2slplwALVxl0raf0wR9I+Us1edQ2WJjlcckzsjJEIsUDR9+BCbKQiaFwp1VKuxvh3GQtQA/bNbg
	JPNJbWkJfSzh53WTEakl3XWfr1MR7Kbb3Yl/Rh2fYfGyzYY6Kfoej6Q93vMn1TI8zmtkXDPZnJi
	d4pahFa8FqSLPUNNPTd7m5oRvftvX7XsGGjXG1n+S/AJQ5X89jaTC1TrhNl103tJtqNBEGYILga
	VibpNY0TluZOjkrgciyKRVOllmK+SrojzjNGd5a9uCxKd5VoH1itAe127IGd5vFZMu/DSuNdGsu
	07F0t82HraSSmaBXRskc9XSxaf4Ey4Cz6gwLcbOJ8b0z0lKxf+NgBU
X-Google-Smtp-Source: AGHT+IGIPJqsN7cEhcBe8dl15MdKMc0+HwUnHsPraYVKhItR5w069Qkh0LAYQtghv70SK26uqI7O7A==
X-Received: by 2002:a7b:ce86:0:b0:477:7975:30f2 with SMTP id 5b1f17b1804b1-47779753580mr13461475e9.10.1762705257901;
        Sun, 09 Nov 2025 08:20:57 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47764195940sm91218035e9.14.2025.11.09.08.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 08:20:57 -0800 (PST)
Date: Sun, 9 Nov 2025 16:20:56 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Huisong Li
 <lihuisong@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: therm: Use clamp_t to simplify int_to_short helper
Message-ID: <20251109162056.0a9cbd52@pumpkin>
In-Reply-To: <20251109130000.406691-1-thorsten.blum@linux.dev>
References: <20251109130000.406691-1-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Nov 2025 13:59:55 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Use clamp_t() instead of manually casting the return value.
> 
> Replace sprintf() with sysfs_emit() to improve sysfs show functions
> while we're at it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/w1/slaves/w1_therm.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
> index 9ccedb3264fb..cf686e6ba3d5 100644
> --- a/drivers/w1/slaves/w1_therm.c
> +++ b/drivers/w1/slaves/w1_therm.c
> @@ -961,9 +961,8 @@ static inline int temperature_from_RAM(struct w1_slave *sl, u8 rom[9])
>   */
>  static inline s8 int_to_short(int i)
>  {
> -	/* Prepare to cast to short by eliminating out of range values */
> -	i = clamp(i, MIN_TEMP, MAX_TEMP);
> -	return (s8) i;
> +	/* Cast to short by eliminating out of range values */
                   ^^^^^ no shorts here...
> +	return clamp_t(s8, i, MIN_TEMP, MAX_TEMP);

That is just plain broken.
clamp_t() really shouldn't have been allowed to exist.
That is a typical example of how it gets misused.
(min_t() and max_t() get misused the same way.)

Think what happens when i is 256.
The code should just be:

	return clamp(i, MIN_TEMP, MAX_TEMP);

No casts anywhere.
I'm not even sure the return type (s8) makes any sense.
It is quite likely that the code will be better if it is 'int'.
The fact that the domain in inside -128..127 doesn't mean that
the correct type for a variable isn't 'int'.

	David

>  }

