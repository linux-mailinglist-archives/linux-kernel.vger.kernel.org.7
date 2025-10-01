Return-Path: <linux-kernel+bounces-838855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEDCBB0478
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B252A1A07
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D9146B5;
	Wed,  1 Oct 2025 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="yYmpHnC9"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E24B19DF4A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320491; cv=none; b=AYTUmoDLJVH15drSZ3rPcxlcZYjQY3cyvAcb12YPGGsIr97SXONfFxrJbaRlPAb77ZuxaqdJrpjsQ5ChDw4kIkoeXW1tTUZDuqbSIs3NJ7pOrznLrymBM5X9c7n27H7uHxzqwEdtsc9fEVXKJ7BLGe3nkTwa8Y0W1QgLEI87+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320491; c=relaxed/simple;
	bh=csMzOkqhqq0NPGbJ1AMy9xSJB/pQW18xDTmUjopzve4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHD6a1v1DcONR/JPKl4Xzn5TI2HvX4/fBS0VsDHQNWFK6KW8wvo7/ChhBgsppifNbG+VxMWkAJTeIS921tktiL/46FJVzxrYUMLMNVMlf1adlHuoHLqQuZwuzfYahb8BrhD8h6u4Z0ZmqVF1Skag4Na1HX9v0VqvgIdVX7RDY8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=yYmpHnC9; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b55562f3130so4990757a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1759320489; x=1759925289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBoe7Syk3GxvADKCt3WjIA+BL5jslyqexantunfoqDA=;
        b=yYmpHnC9LoFluHayuGHA8wgObnMqTWxlgW6ToMHjEmgUDC/fxA6Lt86qpPytfvpJNf
         WX6XXIFmyCiA+vGkWLxCpDqgkOrkviVrEOBmPNNdNwcv7DiMxinmJyNJ3oZ13/7zf7wH
         3nu0Cmrdwv33V2d4KTd2YsPb3AsgjO5sH2Lre8iN14ZQG2+YDOKDVq3tn1Dj0eEIplBW
         rdzzegFAW8bTig/aqJYT5d6CEM1E1RaHEtd2/dz4zctzo6JdNxzWP3puBpuNKYk6x6Lj
         2OdG7bEyc2sDSQ2eGfdv/MkK55BSYr6g0qQuxO5GcA/rU5WgNpsdq4ZvZXQNekQp0XxW
         sygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759320489; x=1759925289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBoe7Syk3GxvADKCt3WjIA+BL5jslyqexantunfoqDA=;
        b=E1mnCy6C0UVDGfoSsPHljwgVSxnbQII1O16Mb/clVuiZIbkD3KsrTZU25q8hZ5Ibl+
         AG+XsE7gz93UK+rvtmEAz0q6/UOH7otpa9vf67EBJ3NNdQxebMCNtdnLV6T1vAarvr+L
         77i+77zgp45bGe+BrjHhars+Y0hqEEoL/2WMMHIBbK19vZTvuqCqp9oBd5V8WRTrZIOB
         XqgziMUZwk1NPNlZJHi63A6xCBPJ3pSIY5r8KbCfQOQzFjvr1q0jr9khgqg1w2GWpMLt
         EUn5hckBnUyfP7YK2uemo8eWqLqUnY2Xaaf2jUdMURh72gXph7QJ3cGVivxoEnT5XX0Y
         fgCA==
X-Forwarded-Encrypted: i=1; AJvYcCXnVsWZvEusKKQ9IBquC0/tw9M2T3TcErLzWTdK8TZ89Zef5Pn0KAb5IwhqOoPQQp0myVPW8YaeT7tpJS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCPuJwz2GOfw48h51e9FFE7eW1VBGy8vgPGzmJ0s7KVA2pAZJi
	8uylieCxbGaWmG2TuGRgf/eLZHgJoEU9ta95kcIHfCK4WojVuS8b/kPM3ZbFfq0lNIu/eOIqPYw
	vpF9dZZbwiI4lteOy5ljgBlSDGHIY+t3FhaEqRZYm8A==
X-Gm-Gg: ASbGncval+Ty99vfWVMk3lpSbxGI4n+IU+rZXjb/juzZO/vpf9M9HdS2dnm6Ll43Te3
	ZZfuKV2HagPsTBhgyTbdDetiswTPVohOiMGhygz5bQWX+0f1DWoKYgm6tMILlpiqmu7owdZUzgb
	Y26bt4YSlP9AN50M8XJZnS1iP5tAGhrnpZlVobsvitljtnOE5QnEd3GE/NpdypapU4w2bQS4h4g
	YorkwNhwfMTObqvLb9KdNVcwc27LuY=
X-Google-Smtp-Source: AGHT+IGkPZJTB8z3YoAexgiC7CsgHER9u++uyAlZFkQM8dP//udEvGRt/+iF4QEmHB9QwVCUV1hh0lfdrjEX30b/qN4=
X-Received: by 2002:a17:902:cecf:b0:264:f714:8dce with SMTP id
 d9443c01a7336-28e7f32ffcamr46563735ad.36.1759320487851; Wed, 01 Oct 2025
 05:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143831.236060637@linuxfoundation.org>
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 1 Oct 2025 21:07:50 +0900
X-Gm-Features: AS18NWC1OTooJzZIFpum2zpAjYDZsdXN6RoJ1TZRIvF1fudfKrE19_yzu_OSpNY
Message-ID: <CAKL4bV5d8nSDD+PdAC-SB-fu=FVu9BDsYDM8irwkWnEVrTUQfA@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/143] 6.16.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Oct 1, 2025 at 12:02=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.16.10-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.10-rc1rv-ge1acc616e91a
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Wed Oct  1 20:37:04 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

