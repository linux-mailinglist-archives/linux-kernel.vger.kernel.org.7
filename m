Return-Path: <linux-kernel+bounces-839842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0585BB28BD
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 07:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 714BD7B11FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 05:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC4123D288;
	Thu,  2 Oct 2025 05:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFuwkWr6"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC382773F4
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759383704; cv=none; b=BpgrAGRmXbBPOxBx0glHf/e/zUN/DPOzrVGy9/ZtOfl5AhxDE6sxNWqlZ4iZrH0QihWlcqZFOR3lOtRskomzO2mkChZGHpa/exjIrmmGDf1QHUh0eEJfkaZzvslbu/EgomhKl1hLpVVGd8kYS7LkfO8tQ9z1+WcvXyyj4fugoDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759383704; c=relaxed/simple;
	bh=XvGHxbsFqwJV9iJ0+i1FJwCW/FqgBntxP6PbeKydXSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Po+N6mEDFIXYquLjEp0F0MDhhl8jjDOKxy3AmWf09H8s8JLwzVW3lEFsaOLqjeL2xz2sHaEbRsANugigfJwtE/tjC4TZEDP3cDS2rrTdLt+EInmDXb2R4EfkdlvFCJ0GRyjZw3jZIF8K08NuETA8nKnMeTfmrLgWp60EXsAcTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFuwkWr6; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54a79cadd1fso402623e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759383702; x=1759988502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5x6zJFWtgD3ZseLPAVe670DGxAQ0CKQ4TEPs78MePYs=;
        b=gFuwkWr6Dz6EDEYSHqkzkTjP03BhrLpGSH9WOomiK6FnwudbBABIwzmZHL+U+ubP++
         CEKfS2EVEGkRk8n8c7ZRgtNm6ZWxM/2Axu9UqGjGfDBlsEBKCLuKFl9meXIOijztcrkT
         xTvxZHxuhCWQ4F2DrDs8SDTuQ8/4AVuye0pwAyN5EBQJCoEOwMo/gPo7ONxVi/OvMbrc
         Q78JHIdWDcIroU3cyz+b9KZXuvTlPZoZfg8lt+szfBCg+2c47+2M0G6mfEn9J3T3v0f9
         crz4cTLriNjgwFFhzMB8ajSS5mtmgCrpmhPXhTSXhuK3zTj2uJIk4tWheD96F8lF6LV6
         2UsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759383702; x=1759988502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5x6zJFWtgD3ZseLPAVe670DGxAQ0CKQ4TEPs78MePYs=;
        b=D5BDc1ArQ+14v3pVFSQflqWghNYoMYDUZu4bLbXrnedM/CP+5c9nY79V6f0+m/Lhwo
         8iHKzRy0ypbvPNLnIQ4MYSeuehOBepgGjk79+xpPOoJyl9uysDHh2+8gmvIGQUQc4pL2
         jrRWlhIw4qDbrMgVKaXzX6IYR1LtUKSVASGLzezHPcx1rmq4Sf83myUbBlltcNOf1GQ1
         h9pUZPQQEj8KNnw6NGFJMxMpMN5O/Cg3LRccoJ6gupS0gsiYlEQeNsAXZA6hCQk6aO7a
         j3n7krc0ja6MMQvGdf81ogh2Wd+1NcVBAFwe4Z7K+3HdqGigGBGnx3mC8IX0/PB2Dzh3
         gNWA==
X-Forwarded-Encrypted: i=1; AJvYcCW2VAKdIlW8sHnFnCs2ip4cmM3eJ84r20vTNh6F9aHmrFIt7kmKNKLRKznZzTopm3tEO1rTPWl7+XVNTVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaFhVCJrIymuhT2JUimCeXYRi22HrdEoKzVZO2KQ0MxkjpVpdZ
	1DSIrxj/JGqBISxe4waWcpPFu9+D/xagjeKiYMILDPPgqWQy0g17hNOClqXw8jLN2gVKKZix3pE
	oyWii/rxyj5kfhHAkIqZSynPVvhsInksDnVBV
X-Gm-Gg: ASbGncu1eG+9/AoJ2Fl31jMXVMoX9TXPRCzSoWVn449xGGubpx7q+eiWtPzc9T2gVc6
	FEOapd2aoE09mvkeZZ23PiU8ICWLp251OLgOrYsUforstbJSGtxVCTIKqFAILk+Ej7ZyBg7arL7
	4WWRLSD5lV6whVoPpmx1RfYM43gXN7pqDG5/cFKrZw640Lo+6b3SwM0AdGraSsL6yFZKF022rvW
	e9S76Enu9p9JTJoNs4oruxeY24eoYEx
X-Google-Smtp-Source: AGHT+IGEkTTfLP5itOz9+QtpvlXNI/0w6Lyt5SdIzsilfoIcWxy7ksT5170dbLBGuvLlhy9yJjlUX158j1bkoa+xNs0=
X-Received: by 2002:a05:6122:1ac8:b0:54a:9316:f429 with SMTP id
 71dfb90a1353d-5522d18daaemr2265788e0c.3.1759383702305; Wed, 01 Oct 2025
 22:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928054019.1189591-1-alex.t.tran@gmail.com> <CAMRc=Mcj3YpHqFqdGPF7YXRHz=56J73TV2oPm70SHUmgXRAy=A@mail.gmail.com>
In-Reply-To: <CAMRc=Mcj3YpHqFqdGPF7YXRHz=56J73TV2oPm70SHUmgXRAy=A@mail.gmail.com>
From: Alex Tran <alex.t.tran@gmail.com>
Date: Wed, 1 Oct 2025 22:41:31 -0700
X-Gm-Features: AS18NWBMdlKKNXnALU_uhdUAH-MGfd6utxEUkbKtTgAAxfxzcWP4zPYorkBPDEg
Message-ID: <CA+hkOd7ch=-Mi10njagF1bwW7fFRwm8fkiWD4RueMih02_12rw@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: gpio-grgpio: call request_irq after incrementing
 the reference count
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

> Any chance this could be made to use atomic_t instead?
>
> Like:
>
> if (atomic_fetch_add(1, &priv->uirqs) == 0) {
>         request_irq()
>         ...
> }
>
> ?
>
> Bart

Sure, the reference count can be converted to atomic_t. I'll follow up
with a v2 patch.

Thanks,
-- 
Alex Tran

