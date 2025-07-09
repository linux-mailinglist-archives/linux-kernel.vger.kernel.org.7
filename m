Return-Path: <linux-kernel+bounces-722913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8382EAFE09A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7393A5314
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9EA26B748;
	Wed,  9 Jul 2025 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="DfpC7Vf9"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8CF26B2DA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044115; cv=none; b=pmcHZFYlI6JMqn7H5k980baE4UfzA51vWZFdHvhshflC85vRTXD7CIt7cFrosrFEjw4ZT4p4DwQ4Bh3BwCUJQAEIZ5LvwKxyzEC2OMjRGEVLNskRZ0fC0eiW312JkKzJdhGoN58t7ZZjn/CLaGLaFdNhew4Hz16wuPXzlUDxqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044115; c=relaxed/simple;
	bh=Llz36kufN52xm0i4d8RFpEM5cFRnEKZ/vBmybKKThBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Un5foFa68YAVkKPIiJo7LPv7fckiy+ssCzUx+sgnlyn77WcnXd0fUe/C3nYGKvckv7E1QK5OoSC5AKuNkwVPK4bBCwSSxQ6Sc/ebY6Aw5wd3aywZEZ4hBXjgGSSLSIPMvipaOe6F3z+66CcrJo8t1hPakm4BuiY+eFHjhKZsHII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=DfpC7Vf9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3121aed2435so5012209a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 23:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1752044113; x=1752648913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxSHhqCIu08V3Qwag9o38Kp5WRa0opkmxc/P0igOUiI=;
        b=DfpC7Vf9jJptE0mcyvdR89c40XpAb25s4OioClGlgdthuWEy+i5NJjX4hI1KhUcUox
         NrOjO02EzWuATNFdxUSK0Am73fKkXxmzzMG9F7kzrMPm6c47FDyvWc+BfpVkpQ3/OUdR
         GC6YbgXnBL/LzF6ruu8aSoRSOBLUZ4hK+Kj9ojOGA65Ewm2GDwb8xmBN7DjEiIUthoa/
         INwzmpQwSHXUoZmoyAsCBMZAdhaP6OajoBiuhLC3ywZe/Ri/cTcE+RQQEqFepmLs9OcY
         +z3Z1ZxwqYCypv78SwZFo/srMLrrTKtg6dR31v7+qdQHuG+8SUuCKX7HFicVX/RvQv87
         KifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752044113; x=1752648913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxSHhqCIu08V3Qwag9o38Kp5WRa0opkmxc/P0igOUiI=;
        b=LAPm3EeG8CQG7zDBrUQpvuVMb0B8GsVZjuW6/8myO9qbWZyq/Ie3H9is61iZpr36Wj
         IrmhJF4TPd9hSpuPvkMJUJjPKdUIX/E2RQ67/11IachwPsidgiET0SkcXk3/tJvOyHta
         jjGmqw62oHzEjzZURNanpOPjsKFeIiAFIlr1WLJClfv6WWgeHcZu6Rpt3IYerOx/3Mf1
         yxlDdP86l7BQxF8hMhmfRxfoVS/qenn5aY8TuFxSlz4GAcdJ+3BE57gTvGQBnOMlI+gS
         jXFNhIIFGFIK7yIVlsrUGqlOWEEjLsBTwHzBfBCaLgv3BNdvoLMoR/o+M4NSvJb0efAv
         FN8g==
X-Forwarded-Encrypted: i=1; AJvYcCXAtY9oy6esoC4DNz1n0EDn8FmNpOC6FeZAq+KsuhllJCZB4EOgxBMzc+RYyyKHzlG5kriF2BtKQ0tKvzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01Nky1X/SxEWp+TJzSu2LNvFepxzaG2BKmZFhMYWNUs/TOrhM
	Yg+LdFArQjclWTabOsrOoynO+JsM2W5d3PtaW7CuO2eMFTs2CimFmScjWfKhZY6I1QKmPd/BxEU
	Wy8pB9mqylo2TgT8KStn1e+8A3Uj/onxouTgWgRVXOQ==
X-Gm-Gg: ASbGnctTfhOnTOQocucmu8XGFsv0zG9Gsvd0LW/TSfKOvwWbMXQU8Sto08VqG+d+bQL
	yx3qV6fcSbyFI2TSpeS3HQboDsFQuz7ulkbf1azFgzauXMLmtKLB5/nbgaPTqp4XGkiJKLQIKP4
	3Leb47LHpbIksadI6GlUhCV5V1A/6ofMBbnJdHpa2PhrM=
X-Google-Smtp-Source: AGHT+IF5H0//doa2nKgKyMBFHav2Tca1UhHeZa/y5+70t9CTKpzojdZBrhFAhrvWQGEyl4cbrKijcS3La+7jkZmxDZ4=
X-Received: by 2002:a17:90b:510a:b0:313:f883:5d36 with SMTP id
 98e67ed59e1d1-31c2fcc389amr2109500a91.1.1752044112748; Tue, 08 Jul 2025
 23:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708162236.549307806@linuxfoundation.org>
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 9 Jul 2025 15:54:55 +0900
X-Gm-Features: Ac12FXzuUaKQ0Ks2xEiZvI9ZcmwyTtrC1KBrVsD1P6JK2q27gyC7Ngbilk0Vh6g
Message-ID: <CAKL4bV5Q1eGnsOXbf2bL4kjcU8ZGn5W+bMPKsYzBNqp9OxY2xQ@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Jul 9, 2025 at 1:23=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.6 release.
> There are 178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.15.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.15.6-rc1rv-gb283c37b8f14
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Wed Jul  9 14:44:32 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

