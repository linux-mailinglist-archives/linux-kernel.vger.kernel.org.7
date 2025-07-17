Return-Path: <linux-kernel+bounces-735398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D53B08EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F505A64CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C411D63D3;
	Thu, 17 Jul 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOudqMFQ"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E481DE894
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760957; cv=none; b=SVxdmVgAh5Pkm0dHjL6NscV0ehPqh4dpnBoVX38+JZiKPNC9jx1OC+O7L1BdBRrcTSwaeB+oLJX8gJOE2LeeoNvr01DuX9VGVFVRDMLl/BAa6xx0UEQyIxfeo29TgMHKcR+36kHxySx2YZjSrscLiaxNcACiuexhy68cgPXx7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760957; c=relaxed/simple;
	bh=jvjvNJ9/Hi0d0NH4OHDfhDk41aQZnW4W5eEeryeEQCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9K0DRTSMWza4mGqTKlN69xhvzkamZp/1aseZIjKwefxdRgynIEBdsZ/n5HWzT2uh+rM+ZQUSgV1+Yrme2J3O+frE0nENkTOWj6Sgo6OJssbgQRt1t3KoGpHopFM2nPPGAPQPPMXSCEG+0MyowKRQ/nR/hSBEkVne3Li/yCMXC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sOudqMFQ; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2eb5cbe41e1so662131fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752760955; x=1753365755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b/lGwtVvChzSLtqkQCS9MrMJ9VNP21TZnjqYYKZiq4I=;
        b=sOudqMFQBI/K4o1vSwg0X2pqwEsWMmd+/3Wi8Hjk5j3/K9e8EBJmHtqH+61PVlT7p7
         O0ZeTI1n/M+MJL3wJvdhs71Jue5nMHDIrNUBkeAEJGoPYslYU25nheq6XC8r6Tpfq5Sa
         5Iwze7XczfLS+IJdtTL81vVrrLH8OOEk8QsUJBxCoeT0mnXx1abeQkmDHNs2nbd72j9+
         R7benStUo2EgF8dj+/Yf0NlL0It0t675cpavNLmx4dWz8sxGF9h/2K4+BjijCHXwuX+s
         bbW/HaIfoFgZ1k9TT/giC6SAUAof9X/fGHth7LygBVPbfpmNPrrHJkCQbkJTRX6agmBQ
         jk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760955; x=1753365755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/lGwtVvChzSLtqkQCS9MrMJ9VNP21TZnjqYYKZiq4I=;
        b=LBrya+bUYBQKyvCyLf/uQqg7gTtbo4+ur4l3adAStHuNUJpbxyOAIp+5S/tIv6QXoS
         mvkkjUYrsuXsh7iysJmx4P5v/rIXoFQYq6WUMFcVzDpH5i3NxqrR70e6uDT3sV20w2/C
         mHWmRzp63eqrQQHi0MujtE1cQ84YcZtqwcWuMa1ueP9RHeefbfzNd1A6DQ9XubWmROad
         qYzi54YWkij601f5gQ/K28vtP+kgjRY0jcEBstskgwwObwBKa1eGoEYZqF3+Pjyww4DN
         y+y6sMcdeHJix1Ysiz3u32xD64DkcP4PYeP9VeU+/TM3w7rMnxMLEEh6mbotjx+xwgGY
         Tuxw==
X-Forwarded-Encrypted: i=1; AJvYcCXhEdPs4zKtzQSToTdOMPK8/UE5jDDoz9OUc2MBhp5eeZn9//Jhw/+YbwdZyK6/YhgafaAhC32ys5T2Rfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxynfTflDcKy8d6T/ARtYYLNb0V29q34fW1gDYb4ssqIfaI4evp
	ywq5P5PlZcGzhrFT/Xam5JeW856dWi22f87jOREmme6nWJnDwOWM0VwDWqR46pZo8fk=
X-Gm-Gg: ASbGncvV98Ab/VXPAuSH8+ELaBjhoLsw3GfoIKGVWgtxZY3IzvLI/NgMtrTHyj7BpK0
	nrlHOGg2ozyhJdtZ92Ee56paO6GcFf7yl9Rny6ghoA841/Q63P1lUikwE317WGf0zU3/slY6OCc
	HBeJpcJQVMLI3BeYNVohIAx6wL/URRyZNES3iUqAx4ee2skM9w4JzOqWVJoKj/xRYrU66IMVWZE
	3UOxMWiFsy0R0SbuX33P3LYwQjNjdMaWUH1MlH3D17d5EYcSUNWe0dt7lBqUHhvcITJWWjkD2Lh
	+PJHYIhzIcRbq+AUjRLRYB5st7hJhvPjRBEW2k1eGmYEvdkQ+keZzjTTtRZlbIQw0AE1dSwKQGO
	ER1Ge8X+sD5hK2+jXT7TZvqSbtxRy
X-Google-Smtp-Source: AGHT+IFLK3PoG0Ry9cupN+1Gy4j1J9SSXaeHm73Z+F4q8Igvf8Tt9wX4mzY9/+JFGf1Gd8BqtKEL3g==
X-Received: by 2002:a05:6871:7b0a:b0:2d5:b7b7:2d6e with SMTP id 586e51a60fabf-2ffd2abcf70mr2255355fac.38.1752760954743;
        Thu, 17 Jul 2025 07:02:34 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2c38:70d4:43e:b901])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e7b586ba3sm275626a34.40.2025.07.17.07.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:02:34 -0700 (PDT)
Date: Thu, 17 Jul 2025 17:02:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: Sergey Bashirov <sergeybashirov@gmail.com>, linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pNFS: fix uninitialized pointer access
Message-ID: <90cddfa9-2d0c-4806-b3df-6a5ddd13c97f@suswa.mountain>
References: <20250716143848.14713-1-antonio@mandelbit.com>
 <h4ydkt7c23ha46j33i42wh2ecdwtcrgxnvfb6c7mo3dqc7l2kz@ng7fev5rbqmi>
 <b927d3dd-a4ed-46d7-b129-59eaf60305c7@suswa.mountain>
 <d9b026f1-6ed3-41ca-8699-914c45b0339b@mandelbit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9b026f1-6ed3-41ca-8699-914c45b0339b@mandelbit.com>

On Thu, Jul 17, 2025 at 10:01:42AM +0200, Antonio Quartulli wrote:
> 
> I agree a comment would help.
> 
> > Another option would be to initialize the be_prev to NULL.  This will
> > silence the uninitialized variable warning.
> 
> But will likely trigger a potential NULL-ptr-deref, because the static
> analyzer believes we can get there with count==0.
> 

I don't know how Coverity does this.  In my experience, writing Smatch
I had to treat initializations to NULL as "ignore this variable".  We
used to have an uninitialized_var() macro to silence uninitialized
variables.  It did an assignment to itself something like:

#define uninitialized_var(x) x = x

But we removed it and changed all those places to just initialize the
variables to zero.

Even before, initializing things to zero was the standard way to silence
GCC uninitialized variable warnings, so warning about NULL pointer
dereferences tended to be prone to false positives and the worst kind of
really complicated false positives too.

regards,
dan carpenter


