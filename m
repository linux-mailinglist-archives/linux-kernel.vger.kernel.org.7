Return-Path: <linux-kernel+bounces-805225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE2B485A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D493C306A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788F32E88B0;
	Mon,  8 Sep 2025 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b="L6FMUVYD"
Received: from mailout02.platinum-mail.de (mx02.platinum-mail.de [89.58.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E8A2E5D32
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317136; cv=none; b=Qj0UavUpLcURqx3Skr9d43RGlh8QO7OmuYY47Bw0Gor8DbZAF9YcGGnBBX/NQrxlTLkB68D1L0P1+3FXGn+/zNdDsKWX1NqZMwkshjg5vlaLDdk0JiWtdKTtf6NI2k7fP9itmN1xJL5rV7xIrqBJ11u1bClIy7knKCn6n06yXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317136; c=relaxed/simple;
	bh=XYXznLu/zaBSaLvSIy/jzKBai21AXuNxIa28T8/Ha7I=;
	h=Mime-Version:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:Content-Type; b=B5XAt7A9D0Gohg82GR8kT6YEPp6ZZL/WbL7H/nzhgNgVAZglKIGGuWmNF/vAAHhwIV/C/+X8m4Znfz0yYOAEBjA3p1zHm3bUCmLj1eFUFqZcPC/OPdQ3ndqghE0jRcWY73TMtO4jgHEhfwmXyFh8SyA1y+tkOOVqsIXepacwvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org; spf=pass smtp.mailfrom=achill.org; dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b=L6FMUVYD; arc=none smtp.client-ip=89.58.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=achill.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout02.platinum-mail.de (Mail Service) with ESMTPS id A7AA39A2928
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=achill.org; s=mail; c=relaxed/simple;
	t=1757317124; h=date:message-id:subject:from:to;
	bh=XYXznLu/zaBSaLvSIy/jzKBai21AXuNxIa28T8/Ha7I=;
	b=L6FMUVYDmRby72U4AUbIZEuzEm3NoevEE71kAF4PgyTgHnHqu+ZY6UWpyfmDf5EFAhUv9Esj9vo
	usfGbvsJ1akYK98CHI3+FGWFjkoTKUu3ozlG5AOiTLMGDn5Fd5Kq1Gohm8nYcKHVcG9Vr/3vYaJKo
	D4OYhBQVCoaltqpHUee3Pkdt4ftl91ym9LFTp+3jkJ7mel7qyzf5zWtrZxdRJZNqhMvbhSdU9mMh5
	/qxTgp8JArBAahDgrbu0FObN+hjAvN/0IF0WssMPsO8aUyAhX9pIrp2wfSRw3n6eGo8t3wEi6tkbH
	/5o6As9oePvYQTw3YFYwKxr9uFkTiEqqBcNA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Sep 2025 09:38:38 +0200
Message-Id: <DCN8XF4C6915.OQV51LHSTDKL@achill.org>
From: "Achill Gilgenast" <achill@achill.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
 <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
 <srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
 <hargar@microsoft.com>, <broonie@kernel.org>, <achill@achill.org>
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250907195615.802693401@linuxfoundation.org>
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8

On Sun Sep 7, 2025 at 9:57 PM CEST, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.6-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Thanks! Build-tested on all Alpine architectures and boot tested on
x86_64.

Tested-By: Achill Gilgenast <achill@achill.org>=

