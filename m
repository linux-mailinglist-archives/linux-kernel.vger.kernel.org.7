Return-Path: <linux-kernel+bounces-838961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FBCBB0825
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74E01C2885
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928392EE276;
	Wed,  1 Oct 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="XRWN3H2D"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE6D45948
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325433; cv=none; b=FI+9seLJHQU4HOux7HhgXIf+jYQ1lSW9l68bzmYma1Z+ISmF/tAkE3xgbl8WOH1fV/lqCEpy6wqvJRPO72fxuWmX1+54ui31DxT5+ADCuvUMR5xFL84XkzOXDwdCgJDZqLWqnOkVtd8L9L9uGKLrmStjIIH7qT5zlhw5iO+vQTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325433; c=relaxed/simple;
	bh=SktQ3kOlhBAC2x3vmzqqiWJIKayZPjyxZa2VPO2W95s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boRQalNEIRxJIgJlAC05yWXqM5KSgLRG2d2xA/dKUv6iLIe9QIIp0N732FuKycAl/MopWrPZAbgON/AuTLTJvzuUuHXWlzScGUeHlRsf3P25ZOKDHIYejzooiNlPy/zTSuqNNxCQp8vurklWEojWV2qU0SR04oW8WS8L0dPFQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=XRWN3H2D; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8572d7b2457so126022185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1759325430; x=1759930230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCwcUuDlR2HsB5Hk2ZIMgqVF/pdzyf7iXfwKEpkpRxM=;
        b=XRWN3H2DBctRwacMAgmIgy7S3DPK5sifTGOkdehLWCgX6Xh85EJM4HafWsaiqhmLYD
         Txh1P5B268DaqKix3HPqNO81gomC1KYvQOUFrMIj6nmzHIPYDkS6RGIsudW372UZ4/u7
         1siql3blj3BL9vSGyvZqh2cp65N1VPKtMnTbX5QuKthv5vws+qKRxDYWRVCxR+XOrKfh
         T6dIbnde1KL+9ZLSG5Fqgbo6VD6WTmS3duo2m2K7mptm5YNlUZhBn6/nzyLOmQ9Tl5Fz
         cQOInFASfxJf+2zOmbMpXWIEsUlHsBUGChLRtL6+wV5VSYxOoyVxqIDlpGjqVa80xV35
         4FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759325430; x=1759930230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCwcUuDlR2HsB5Hk2ZIMgqVF/pdzyf7iXfwKEpkpRxM=;
        b=JZEY80KXNmu11dGMf/n1qi+cIkA+OplCADHpckukMwCfDD9QA4yKPHWlhJaXaz1kvx
         /GBCvBsfiUH6x8Tc6KXjhaupKB6klf9ddzLWs4VoxnjC7RU0CG80tfksYIdHInnjnFAU
         pgwl4qbiZs+lRdEJX4lzUFa2CwoR/j9DjIXSEtWQ+/jGYic99dqyaTIlwMGiVYZXPyWN
         FYCZNQmw6qm2qIrGWXzQfNB63ZkGsxHBhXYNb3lJdXwCC71Ih9bV56HDM6Ojjpr57293
         xtPJh1+CfYWKQniU1KC23Yo5Yn/41bb/w3i3zMNMHjslpfTJ19oazQkdiGAUsO8V+GFv
         goNw==
X-Forwarded-Encrypted: i=1; AJvYcCWevSY5aaPTVbhUyS3M3GL4j/LYUBsRVm5pT3SUOosmQjeFwIxgeBEI6tMp4eR1sKQswqFaq+jvJ/hrFaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7bH2W+nXv+GotgbLzP7Ncl6TbeMRA934zWUKd08xwN5ULoD0c
	nxfU+XcQqnEIlOm3dLyXFwWsaspFVAW4+sRKxcyWiHtJj3rQ2bp3I37SO/xHzmK1QTqoljtXAS7
	D6x4+g9N6ypfsYQTvfgzgxPIq/9t0HLDNR/40Fm/1HA==
X-Gm-Gg: ASbGncunG3HGWS67mFw8aIEkPslUOP5q86dPiz7qzyiKdDDhDPoN/W8QAKjaCriCc9L
	3kEUJJBQEGz3D54jOwc5Ugls0n6Aotw9bmjM2pO9Qd2dJnV/xhUQKogzD2jOVYvWyzGWc7IapJ3
	FOs+in4Rl5AcUzcaI9YLoVK+VhhU1Cm6wT0Y6J+zoUznptxpzI7w6xYmy9sEe5S0cpjXB7cemgD
	ZUUnMrVbNxBFKt3qciHA2jJFwIsJXX7
X-Google-Smtp-Source: AGHT+IFMFqctsC/gdxMYa79bTEHX3fAs8ipIL5VVoN11C3E29xDno2ZFwjrwO6xWIEz3lEpIgS6pt5gaKnnHsGAh2P4=
X-Received: by 2002:a05:620a:4508:b0:84f:8eb3:9648 with SMTP id
 af79cd13be357-86ee226f9b2mr1216961185a.36.1759325430066; Wed, 01 Oct 2025
 06:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143821.852512002@linuxfoundation.org>
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 1 Oct 2025 09:30:18 -0400
X-Gm-Features: AS18NWDMzWRD62Q2toC84MiLOfA3LeeQx4tD34WUJj7d19lC0jxZJv7F6icp5OE
Message-ID: <CAOBMUviHCYvHce4qoy_WXNK1tragYg2k5DbgpAxy_1dk3YtD=w@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/89] 6.12.50-rc1 review
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

On Tue, Sep 30, 2025 at 11:27=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.50 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.50-rc1.gz
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

