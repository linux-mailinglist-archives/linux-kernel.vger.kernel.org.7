Return-Path: <linux-kernel+bounces-806415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8B9B4967F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8E71B28135
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011613101D7;
	Mon,  8 Sep 2025 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="VkUUgaGj"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07383115BC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351162; cv=none; b=tGq3MCQ4f4H3Q43i8aK7NFKOGuz/THp/mMboGB3AbrF1pLGKYQOmT4SULp2tYBmeOcOkiHMUZfpwxC7erMYcEV+cqV2o9j1+ITWqDJkCkfi/BuYIZl1cZv1YyyDjt1UX7y0u06Qz+yGLlPzAxmqxeG2eRGXXXSRMn5oBvZV9BOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351162; c=relaxed/simple;
	bh=UereUCrEkQNC0tu3rtwE8zpk6zjz0QTQfAA76et2u8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNdfeQM2nT3rMxoKi3laW781hBTFR6Zw3u6i2Swwb/7tuYR/79xzoOsxodAWcvwGYh5uZV9vYwzfPn6a8q1mNXEf5NFqikdGe5ERLrNe4OyLbPGa+HF0VH/euPBYME2U5KqWal0yjwxYqfTjAMcZI4SQ4KFyl8heHAwSckXYRy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=VkUUgaGj; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-810e642c0bbso378821285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 10:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1757351160; x=1757955960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C70iKojrY7jdN82MqXaFezbDGouxyq22uvSJHJ1WlSs=;
        b=VkUUgaGj86hd1gcScGBZGy14jhr798eejbNIpRVYF+hCYvUgWJkHrd6ddzONtIoaYB
         OA/QQ6SrI/6TJaFaovEddk0QwktvJ86XJtV0oAkv2/FjpNGPgC/OX/GC++tYg+2wjxVO
         AtacAw7WrHyUhMfo97VcW0gjpjaPrV6KvzOzlV5XNt/7rj5dxzSE+yJ+zi28BmlAjuGS
         yYHM2aOj0g++jBUe9KGTq5zOpFBGQqh4L37Qp57ix35IDkdMiNNPUIFaaiOV7IPd8pIH
         qkz0uzrfBD9s3xKGsbPRJmreajaCsAvm2RrhCmLbR4hMQssJPSVWTJNeYpjtJLP53AKM
         yLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757351160; x=1757955960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C70iKojrY7jdN82MqXaFezbDGouxyq22uvSJHJ1WlSs=;
        b=cm9G0G6O+S46cC51k7ji1fOJ6Hf+gFxJP1v+UblTnld2j6lMix1DF7CtE6XjB1DqIA
         j8u9mXf8dAxBqAQep6F9D2PJEGajKmvCa8+/LZbRhxJrsUyM/CnmHA958wzMJO7mIV91
         GKX250RKqTnRDkiAxv7YAWBUj5YsvlmeUbxYtcS1QVZgNHdqAILOTnPqgAPZQvjqWw/m
         1ecczFcr3dkqHSgbaOcd7vh4Q28nmpYoKK4dkBahFDxufkma4XHxXA529tM6ID3R/DkS
         22zF3g7AYXyWaNoJw5dRq8gNSoyyQMy8fG/Ekt0oD+mUtBgMIkWBmVcKBMOAPHvdIeA3
         SR0w==
X-Forwarded-Encrypted: i=1; AJvYcCXCi7h1f7UG2UnXaeLtFIPFSH92uVyF0JOsxQqMkSWL597HROigdHgX5Hfq+A5OFbbWlifu2xT9QKPc9Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4++IVCkV3ewhryS1lfvdxo3dyr2iHqym9WvRYNjlEednQL3I
	ooHJRlSdwBFJW4cgChUSJQsxtKq7/FnlEyDUie9fxbn7Q/FXLcHRmEJip0QsV17R7MNy3nxZ+4P
	bfQ8HJCHq2XOQUBEAa6kg+ffbaeGPT2JpIuTkOFLT2A==
X-Gm-Gg: ASbGncsPefR5koIsC4mxWzk42cAw3/oPZQ09Dsa4k8Oft+uxbyYNPhOzIJkzkU3zDs7
	+GIKlPQ2yen5MmTTfJ7NKYqachixjpp9Sll0EOxbyt0xuuQFKd7lb4qNV0Pdn6odlQXNY0tWcOA
	blkTl5ZfunQYkOjQI0wEr6wMGK9s5XYuMSiS49HnlbBGCuWEUdppkLtujuk78S8VOq1ICt1oYAR
	E5Ru2JO
X-Google-Smtp-Source: AGHT+IG4c7OCzdFWJM4VhsvxR/re4+afJCA0GQQAlA0lULwfRtpZH6LGwuQ4VTihA22lXylz82aOiBirWDgwUthD+3Q=
X-Received: by 2002:a05:620a:4082:b0:806:2c5c:fdd with SMTP id
 af79cd13be357-813c1f89a1fmr889509285a.16.1757351159587; Mon, 08 Sep 2025
 10:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907195614.892725141@linuxfoundation.org>
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Mon, 8 Sep 2025 13:05:48 -0400
X-Gm-Features: Ac12FXxb4qpTT9OnLVbol23evRBLxN2yd-jE-8wHxvMJAYfbhe7J7JMejRQMjcY
Message-ID: <CAOBMUviNfJVJXTuVkgwyxUDQp5PHfEcRQ=LRpVjUQVo-DKqOng@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/175] 6.12.46-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 4:29=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.46 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.46-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

