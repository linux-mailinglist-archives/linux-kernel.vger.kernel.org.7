Return-Path: <linux-kernel+bounces-871645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9A3C0DF58
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D023A9E47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72087259CBF;
	Mon, 27 Oct 2025 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfWi1NcZ"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216AB25B1C7
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570788; cv=none; b=I1TV43x51Q4X4lU0Mhec/PEjnlorOBMGdnq+FeWIlNSsiEgnXcI+TMa/bM1YQbpQKwAvZIQrn6D4wik6WbQ60KgapIMJyGBH/94Zeb5CqoTDisdUKA/K0xv1oeiPdrA2gofH8My7t0gF1j20rAy0BFlalKNTUZEipJ4a4xoh3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570788; c=relaxed/simple;
	bh=4JRsrZ0EyNC76Kj9eXHalnnSKN5mK3A52nSIdisFktY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyj2aj23LbmZBFZV72NP2xhTCSPKL2m+ys6PqLOpGYPaVR+aaXilBdxAsNj9J8TWek3TBn7nA6Dtyi+ar+m5iONKw74wfl8Q384Uv61yZSLjHHUL03dlfYEhlslxUx3Zt4/xOYwobUCxshMfYzGdEO+vHWyLcces5OwpixvplaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QfWi1NcZ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b553412a19bso2963721a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761570785; x=1762175585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gNEXNCM0epFMr+RmcnWLYaOFdjohrZT8knavBi/MqIo=;
        b=QfWi1NcZiPZ1v/lBnwwAxknpGWEG089aeTAG/YYXxH4leIDuJQLVykO7fXJMn87js8
         QjkjA6KPC4I3kGBYQJRHq+eZpDiOtrLztl8suvjS5UGy9HpJJhp8x3tLPV9E82ZKPsaV
         d/TOATSFhxI44o9CpJZNgpKfW1EWfKJQrrsluEMBThjSLtgvjCIhQiwac/nMLv1mBzY2
         N9GVBDrSxRvS12Hgg0E/vrz2F0J3jD5J5Fm64+0t449D2qmoAgfarl85tOqmjf0D1N8c
         bopu8sTlvDJnp/yoYfkbtrRSV0aJZaVtD9q2xLd4Ss6VXI/FnfE4vYfh0OonNk5Z3UNZ
         CMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761570785; x=1762175585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNEXNCM0epFMr+RmcnWLYaOFdjohrZT8knavBi/MqIo=;
        b=h98afrFOFAffVC8QEUKJFOpQ4on6BBKqYGdUg9m74kUvR+uZjt+yx7T/L74I9exHxw
         2J/W4o8VNLTFkkKOWxibdBjnbF6hu8v0mmawAJsUzcaia7wv04wCu1sBkcydo72BaI62
         GgxdJfZmqRwhWoCwhsdxKu41VwrJO/XipY5GcD/S1+qe2jhU88oklSMSlH024gce0cS7
         X1v1EnvfU1lYD7MiV3as4bVYrQXll7TtINpT0Xn6Tz5vVhzjwbZQ5vo68L9LL+adqrYZ
         VPXiaocIoT8XVCBuzudPRffTvJaNy0+NXN39WpXEKYWl7BXBH2usK9xz+ICPVqdjGeip
         pgIw==
X-Forwarded-Encrypted: i=1; AJvYcCUZKqsrhpKxBnO+c3UDKxwm6/8TDY93Jr34vf8n7evAUesfrO2EuAhiHB4+RYdL06sIJyh+g67SVnpgQOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRqtCdrQgO/PxWI+TNdomvbmU0K3sOxYjAx29OG9mMQS2br5sh
	/G1uZCmA8Msixo6YhbKmmPWcBSabbpG2p2RDLMYnda1ykZcmzCIMCVRlH1xcTY+GILRX1nl30qZ
	9siqdRPp+YoiYnrROf2klkfUSi8FibIfwJSPYwIf6bw==
X-Gm-Gg: ASbGncvd1sewDDqiH+XlQ7uDfzv2QPHsix/tSr4aHRvQo04/vJVhHNdyHAWR93jRX1e
	7dn2aefR7D+NGgh6ahefktoazKXt28/A/LpudWYcz+5ijYSQE7rtlneS/bzO67ioBqXhTTfarUS
	YOuQdPUH32Wa96UKGUbtxsTydxQWP972gvLVlcCEH6bWtrrgRLaBqRW79Dn0qLozZTixcgg/gLa
	6Bl3ibl5iCI6kThSa8hkKevidkR4tshlY8KNhsFJ3MbT+ZNlit3x0A6KZgehK06kiqO3ty6Y+i3
	X/C6Er4gPOWLIVQpqfJCI9TgyXRaEfa4XBdwjfyldRFPeH2/xYURhg/e8u2H
X-Google-Smtp-Source: AGHT+IEsdKc9R+4FlPyXgvJuUVfiubltPDZcJsLUDaYs1stlCo1Np2u3tQ9qE9+t58mdLnukcLVSUInlftA70xiEIvo=
X-Received: by 2002:a17:902:c412:b0:24b:25f:5f81 with SMTP id
 d9443c01a7336-2948b9758e0mr149025505ad.17.1761570785234; Mon, 27 Oct 2025
 06:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsL+w_XaOPaBaN5xMr6Ssrq_hh2_g8AgNxNmu0jCpjwxg@mail.gmail.com>
In-Reply-To: <CA+G9fYsL+w_XaOPaBaN5xMr6Ssrq_hh2_g8AgNxNmu0jCpjwxg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 27 Oct 2025 18:42:53 +0530
X-Gm-Features: AWmQ_bmY-i51q19AYcQpT-sEvBW1BPIqo1n5TQLSYT-9iYht4pVG5wgMSRv46e4
Message-ID: <CA+G9fYvzg-shL5LMmdJjJEGi6NvxHFdwbC5jQwtbFxkOFPnc4A@mail.gmail.com>
Subject: Re: next-20251027: s390: pf1550-onkey.c:154:12: error:
 'pf1550_onkey_resume' defined but not used [-Werror=unused-function]
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>, linux-s390@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Sean Nyekjaer <sean@geanix.com>, Lee Jones <lee@kernel.org>, Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 14:26, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The following S390 allyesconfig build regressions noticed on the
> Linux next-20251027 tag with gcc-14.
>
> * S390, build
>   - gcc-14-allyesconfig
>
> First seen on next-20251027
> Good: next-20251024
> Bad: next-20251027
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> Build regression: next-20251027: pf1550-onkey.c:154:12: error:
> 'pf1550_onkey_resume' defined but not used [-Werror=unused-function]
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders bisected this down to,
  9acb215cbebd ("Input: pf1550 - add onkey support")

>
> ## Build error
> drivers/input/misc/pf1550-onkey.c:154:12: error: 'pf1550_onkey_resume'
> defined but not used [-Werror=unused-function]
>   154 | static int pf1550_onkey_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~
> drivers/input/misc/pf1550-onkey.c:133:12: error:
> 'pf1550_onkey_suspend' defined but not used [-Werror=unused-function]
>   133 | static int pf1550_onkey_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [/builds/linux/scripts/Makefile.build:287:
> drivers/input/misc/pf1550-onkey.o] Error 1
>
>
> ## Source
> * Kernel version: 6.18.0-rc2-next-20251027
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git describe: next-20251027
> * Git commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
> * Architectures: S390
> * Toolchains: gcc-14
> * Kconfigs: allyesconfig
>
> ## Build
> * Test log:  https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/build.log
> * Test details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20251027/log-parser-build-kernel/gcc-compiler-_drivers_input_misc_pf-onkey_c_error_pf_onkey_resume_defined_but_not_used/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/34dKrowtK5wNPnem1T5LSEjjq5o/config
>
> --
> Linaro LKFT

