Return-Path: <linux-kernel+bounces-839407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CE0BB1913
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 362F97B222B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD212D7DF8;
	Wed,  1 Oct 2025 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UO/2YdTR"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0490B2C159D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345602; cv=none; b=Ph+4NTzZOPLUCTVhGVK95Iw8NGP/ctM2YswVFQBa+1ULW25qYdvE3/ESl+a6VdhtsMrvqXIxPf2L7k3QZCoWS8wGNtl5O+x7NbGatuj1nVuFnQGkHbWb4yEvBnLPWEFnIj3uFZmKap8eCfYdLDjDiuVjovokWcZE3+mt2aupdCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345602; c=relaxed/simple;
	bh=/7uFq056iE+/b/Ir+0Cr1OjZjng+VJ83X+iaLMe841U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6gYQCjYT3bnaV44y3ylcpP9mwYMKtWCN/onT8blzUUv2fzFMuH7uPBCcDtRxb5IePsW1M8RRA4vyi9E35+EvysL/6a/Zy/X1VvnaggHDGur/d9KIhG9iqu6GchzygyavWrg5eF1u3/BlAsgs0zRlH8aDHNWc+hCHXQC9F1u+jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UO/2YdTR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b2e0513433bso39396166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759345598; x=1759950398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r1S8KRUqgAG1UODGHd0wi24X7As4LcyI2/rQbjVggMQ=;
        b=UO/2YdTRvR2l9AJNjH2EkEEmrB31UHW5Z9TGuXc2+FPt7EHqIgbFNy6w92bGJK6qJ6
         QYT3jbgGHGtElEz61whd3+Hgi5SAZ5J6Ulz/SQSijeFxOKtM9UPhag93zJ8ZQtxomMvs
         bAw/PpsjzibG+bBj9KNPb9dd42/zULrVbJaiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759345598; x=1759950398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1S8KRUqgAG1UODGHd0wi24X7As4LcyI2/rQbjVggMQ=;
        b=ScvCybpOgVe9BxRnCLeXj9klg2tF2mgEek8RNK5m+wkeZo4URTk8unbhMxLLBDxj4h
         zx67d0q+s8KpIjnfM0sjfIZwbhKP+FWoh+I6rDdjiLQAqY5+ly24JSIJucuITwZgJWeR
         ES959Va2I2y68oZIe+rXbn38BewF5DIEAtxd0PHWyEt9w+G3y40nXhAe3EWHIqA6F7sc
         ZJMH9VKrXlwa2bgyz5W2yQtadFbA6szR2UU3UGVo5QU51Zp8+91zjciCjOz2oyyW+OBR
         En8vGx1MDJc7UFJPM4oudsXockwK1w4IXgs9SOJuM3gF45uEDykjTQ4I5cH8cXxInnH2
         tcUg==
X-Forwarded-Encrypted: i=1; AJvYcCXb71iHpeEv2OTVKeA9gSlAUH2ylGrSpF2vptOmj1j4ciTgracxSGemTrfYdzY4iscJSdigqencmL+oJx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1HzwGYHZb8rrmV6ENB7+1dA8NxIsKE0SZgsqzJF4WzzmJB8Y
	jrm9NJE0HZS28pVTub0BQpQHM2B92vsL3BD7h0oIZddqJC0fIi/GGaYwZpTl1qqF6oIujFvmYeA
	4CNL17d4=
X-Gm-Gg: ASbGncubUIXhMcuJN/a6uskAL9VH/T1xDcVSBCh3PAHD5PYrKDSvT+CsQ+LXLqRKfr2
	HpO8Y1xqLcHz1y2MTSCe8kozT3vpr4971XdkbaKlGCKmAPA/SOX03bQz21pYJq4wePvChRUIVst
	nz+mOhNQXCvtYy3aPf4DqnOvl7CQImx2AIQvblPfcAwV33IzHu28e8q9Z7vS0JDEvLURfT9jMEY
	8qrBKqGiZQ6q4INI8t4Hi5pyyfzhvfmKeI3kAaI+uxDoijxiZxS/fGPUNKjV0KJc+K5c/CZz/wx
	Rmw7/9p/JWOo4WTDKkgowBPGu7uUaVkiBRiEg5hbogudUUhkQUnCkVee4Hhprzuk1OxF4BOJO4d
	dNQQJoeVdjCsdzun4K00Ogf0n7GqshTq0gqsP8Fp5am817BPZhkhR6fkUWbUqyX+9uP67HNUtIl
	+weiYYCYAD9e8zwx/q7faP
X-Google-Smtp-Source: AGHT+IH5RGYAr+PMxJEOsSvsBMx7I2Hwdopl6Rx2UdrRCMZrvieL8o4MPN8dvibJG0wnVkb4+b9ynA==
X-Received: by 2002:a17:907:2d90:b0:b3f:d232:5797 with SMTP id a640c23a62f3a-b46e585d4b7mr534781366b.22.1759345598080;
        Wed, 01 Oct 2025 12:06:38 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4f74esm24096766b.67.2025.10.01.12.06.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 12:06:37 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so431298a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:06:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUb//r/kC1T4N31XYdT7Ca2Y75cZXHH4gqJXgfVCGSuJtIWRjnnarBsDr0N480j8uOal31LdFhPzlRk0zA=@vger.kernel.org
X-Received: by 2002:a17:906:6a0c:b0:b3f:3efc:35d5 with SMTP id
 a640c23a62f3a-b46e585d400mr560815366b.15.1759345596314; Wed, 01 Oct 2025
 12:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929094107.34633-1-brgl@bgdev.pl> <CAHk-=whnmvjsan9Y=LcV0encJungD451VkdqYAKrRpk6YyA6-w@mail.gmail.com>
In-Reply-To: <CAHk-=whnmvjsan9Y=LcV0encJungD451VkdqYAKrRpk6YyA6-w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Oct 2025 12:06:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPqa8YnjjH=Np_Q8r+9xDrypJVL4SPtFzgN-Znjb6knA@mail.gmail.com>
X-Gm-Features: AS18NWBQbwNSzGagnRky8eufGxCzgJDwgghbWOSeBBuByz1r-HbMKjsahJtuBw0
Message-ID: <CAHk-=whPqa8YnjjH=Np_Q8r+9xDrypJVL4SPtFzgN-Znjb6knA@mail.gmail.com>
Subject: Re: [GIT PULL] gpio updates for v6.18-rc1
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 11:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's trivial to fix, but I should not be in the situation where I have
> to fix it, and I should not be getting pull requests that don't even
> build under trivial configurations.

I see that it got fixed in the MFD tree, but this is not how things
should work. At all.

                   Linus

