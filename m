Return-Path: <linux-kernel+bounces-768288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017AFB25F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFECF5C41CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BD62E7F1F;
	Thu, 14 Aug 2025 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuU6Euah"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6912A2EB5AC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160938; cv=none; b=Sg7mz68NgY7ccdzcdXfjx9IKTj9hsIe/hO4X5ohh+PZMWYfnitB3QFbnwS0M9xy8YwQZomoAXoxdoR9XF78M0MBjFra2BG0kZIGFK7lWMurnnC93Ra3tslCM4VMcaf8tl5YsjsR1qScbjgLcV/BlS2w+ll1l0FT+7f00bFKuQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160938; c=relaxed/simple;
	bh=ZLJ+OvTO9Egq2EDBDmrCftbeyKLRuoLdld/Xe68LeYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPjYz+h1oYN6pftV/W7e/VeOQc7wV2MJ57PGD9E99hbjfINi6Wh88JWHpum+8UoEF1JLb0CLfhODDkwN0eStFEZCSmrB8Pty/b2cMN+5R9zIhBF8/SkFgYsl6pEXg/iYbfnyDHYfiUZqZ4FisInztHM0OURHsiTQBIltLNyPwDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DuU6Euah; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55cdfcc0ceaso1690914e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755160931; x=1755765731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG6dQwLAbECIeGoi2Xeo1tsUHSb5SDFit/yFv4rq4XM=;
        b=DuU6EuahpUEIIkQja/tfYIOrM/AopXqcl63toq9TKuL5pk5ZF/AzsUAv+hqwYcykvd
         dPVPEJC9nrtWppsJ9J1HeZUGXQ3GXfvHVyMiE++R3TUfwtY+VQKHAWmgQj2a+tfTC+wG
         b7GyKEooiQYMKWFW/7Q/dB+nRcnzuQgoqG3UTtZ3E9wWhqYhkatldo8m0uQd+/t3BlRV
         AkrGN5l1zNXYhtET+qCA47OpPhAD/6Ry+VV8t4n4wxFXdv9xSPKE2pKR3g7TVLSS8zBU
         ME/tw9Z9N5CNdbkzxAN36qyAyg2uYDIZnrXJSGMhEHIeoAp1MQxnZJ5fyJLmNrYHLoDB
         FP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160931; x=1755765731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LG6dQwLAbECIeGoi2Xeo1tsUHSb5SDFit/yFv4rq4XM=;
        b=fnqYCDhMw/xwosG6BvRDqjwfr+YyhzrrskTbTNlsACGRAsZAGN+1gpW6rOZjCsbFXL
         E6xh1oqW/3JrDv4zwIlaekAit7vOA1yN5M7xOpqoM9uY9qqA4pqAaoTTtSXTjit3NDuf
         dgydwxS1XPPR0qQuVnThy0smdmGeBU5dw25PYvXySizdn7FeRKsMQ/mOxif7V0ICToRK
         PzDDO+vPbcafu2Yx+o5ENDOCPlT8Bmi5LckL867sy4pL9w3G1Zfs3joFzDvAPswSaPg7
         FL9EmrPkUXWni4mssMyvyKAySzP1zolu0hg6aP6FI5xw2ViPfPWLxs1fYkVxQX9KhCBe
         f+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLtDm9fNTdGgbxhEtsHp1l3vZFLn+YrNxgYFqcx5AiTVYk41VNyKOdL1LhSONqoCARYNq3Qn2t6qeYJPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu92oVW0y7v4KzO95wy/BTIG/9VBhulJXSwRbpdn/aZWvKiU0M
	lWLxWZPId3dCYs1vcwh0ORdoA9ZlR8eI6ujuyQPDClGnEtdyOWTlkI0tMMO8+0byVHNu3FbjB3r
	lKdntEpXChHfqZl40IW45WP5gDMvYMPZsP2Hwge3tvA==
X-Gm-Gg: ASbGncsquu3ZLVOsdTEgH7+GVRSbCT5BeIHr9PWpg5D6Cw3f+b0GSfT+p+1/Nbx1CuW
	Yg1qQbjhu17BQhRhS8vSEIn/iXjTiOW5Ke1f+fQEWDWE+Xv/bz8c29/TW+Kc6ifTMJybWWW25Ub
	GcssXnlawJygq25VNCCmntRp8g+CweOz3lnHklOGh8svbCXB/uNgfEwh4CFijX6jpToEPL4BJC7
	T6ZKC8=
X-Google-Smtp-Source: AGHT+IHprenDdT2lQfzU6Lhu57IKRhlpEZsnmmWVHV7r4cnpXiXk5gJnWOJBt44y2tnOfA/ZI4lRbK2Sb9a3BU4XGrM=
X-Received: by 2002:a05:6512:3190:b0:55a:4b21:a80a with SMTP id
 2adb3069b0e04-55ce62623camr605127e87.1.1755160931332; Thu, 14 Aug 2025
 01:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJwk0yBSCccGCjX3@stanley.mountain> <175506979055.8476.10658684000717777329.b4-ty@linaro.org>
In-Reply-To: <175506979055.8476.10658684000717777329.b4-ty@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Aug 2025 10:42:00 +0200
X-Gm-Features: Ac12FXzC-XOfXo4WQ45R4xq6JzH2dBOftR1LqQ_rC3r3c1A0HvmOG4EuWVtRZ8M
Message-ID: <CACRpkda_-JBGTTh7pLd+MkoVyCCKDqTZm8t9vaxWMWDE+sGyLw@mail.gmail.com>
Subject: Re: [PATCH next] gpio: aggregator: Fix off by one in gpiochip_fwd_desc_add()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thomas Richard <thomas.richard@bootlin.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 9:23=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> On Wed, 13 Aug 2025 08:38:27 +0300, Dan Carpenter wrote:
> > The "> chip->ngpio" comparison here needs to be ">=3D chip->ngpio",
> > otherwise it leads to an out of bounds access.  The fwd->valid_mask
> > bitmap only has chip->ngpio bits and the fwd->descs[] array has that
> > same number of elements.  These values are set in
> > devm_gpiochip_fwd_alloc().
> >
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] gpio: aggregator: Fix off by one in gpiochip_fwd_desc_add()
>       https://git.kernel.org/brgl/linux/c/148547000cfc1ba8cec02857268333d=
08724b9cc

Do I need this for the aggregator immutable branch I merged yesterday?

I have only merged that branch to my new development series, if
you need me to pull in a new version just send a new pull request
and I will use that instead.

Yours,
Linus Walleij

