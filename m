Return-Path: <linux-kernel+bounces-787143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6EEB371E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19B2366291
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA52934F463;
	Tue, 26 Aug 2025 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b="beBf5nn0"
Received: from mailout02.platinum-mail.de (mx02.platinum-mail.de [89.58.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4628135B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231439; cv=none; b=AapmrDW+CrZik7tjtvs/aBEoc9vzWJ8e61tbyx31sqeTseYCfbedIFFbFgPJOaX2nevs+LhzLe6Ij3PexACXdN0i9+sARvxfgFhwujMMiiA9A5PTd9UP/lY3vvOVv4jGg/qf/YYJAhne1YmCx0Noox7m7hJkIcXl2CumIGsWEnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231439; c=relaxed/simple;
	bh=bfzh2QX9aI79kIf9vMnLClOeFShsKjbWgXfp42ADjGw=;
	h=Mime-Version:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=leMNjoteNsvn4RzkYp3iWuDttcKTRA0/mRV0WP2g2iyPl/y/duVOkraWHFrZSwdlE79IDMqrt7n3QnI860OhQH6v5400+sKdR/0p8rHbUTSZK1yKixok5prMwwCgPjkximzQDeLrZKfVhzJjknldYYfCo404hG2dCT2rNb5lpW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org; spf=pass smtp.mailfrom=achill.org; dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b=beBf5nn0; arc=none smtp.client-ip=89.58.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=achill.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout02.platinum-mail.de (Mail Service) with ESMTPS id 6D2069A2935
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=achill.org; s=mail; c=relaxed/simple;
	t=1756231425; h=date:message-id:subject:from:to;
	bh=bfzh2QX9aI79kIf9vMnLClOeFShsKjbWgXfp42ADjGw=;
	b=beBf5nn09Gq625Sub1q4RSBEqMejGmN0xpoUFxbXzOdFiIWgN9VedM4tJP/38mFtGFiX+v0I9zI
	2aTW8ZoXIVY6m7g8ahDl3FtwWJX468SHXTSaz60rGquYDZRK/L619QuACZt9A/GphY9Hk+nM6sMCK
	trxvuyz2mJpNsoVeapHPZJNdr+lXV12X9WvPqZdvfyVHcZYlEQ+xG3NC9MzjedaYYxdlllaz/CAEG
	HkWQF3OhsWeSd1On1aaR9dNuoCAHtiPqr7jeDwaA7f4NHPu3VGSGNmehd9OS7EZ9Nt3LPIFGUXwtE
	tiMKwHTarwoxL+SkaTo9nDfFyxQUBMfVEDHQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Aug 2025 20:03:43 +0200
Message-Id: <DCCK2XXZJSYN.30GFYJ0SQZ2QG@achill.org>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
 <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
 <srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
 <hargar@microsoft.com>, <broonie@kernel.org>
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
From: "Achill Gilgenast" <achill@achill.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250826110937.289866482@linuxfoundation.org>
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8

On Tue Aug 26, 2025 at 1:04 PM CEST, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.4 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.4-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Thanks! Builded on all Alpine architectures (aarch64, armv7,
loongarch64, ppc64le, riscv64, s390x, x86, x86_64) and boot-tested on
x86_64.

Tested-By: Achill Gilgenast <achill@achill.org>=

