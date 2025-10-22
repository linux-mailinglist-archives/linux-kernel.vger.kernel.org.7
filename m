Return-Path: <linux-kernel+bounces-865764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 248D0BFDF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A55544E49FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A7C2DC770;
	Wed, 22 Oct 2025 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKJju6wp"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156C2D7DE5
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159376; cv=none; b=BlOcT02gceSg8msG9J0SYiXorKXsagdd93QyxQFzh3gMitoh2EwWnb4h1EJQC2NVr0x5qIcZT1srWk1hitdg5s2iveJD1jCwJqytJ92PtwAgDb6259XMNx0wSgmEVwC/ZVsNszD/+vhmIIqwg26v7dm1+a++nmE2pNJbkbKwUdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159376; c=relaxed/simple;
	bh=8+jnRCt38ZENX1NztlGe9YStpU+b5/SB937qYnXD5N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZQBQRPOtb4lqt9E5mDv1HjmBcTylGHJDyskMI614cP2DhPxMZ9DhF+iD+J4p1zp+HMuM/VREwnVfPFMywwYii1LkXBNM/AkzpdbEsy1cHX3xO6e9npRo+eUAU4MSQjZVDDfSPhdbE7VxYt+EHnLqm8dZEn2WNEFwrbc+Rr99iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKJju6wp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59054fc6a45so8346808e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761159371; x=1761764171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycqI0zLskmdJ9GL89kNkCWpDO4WHedc5HuGOuYMuhxQ=;
        b=eKJju6wp6Wg5cBMiybojfICJccR8arciFSlkQk3UArlyhVEuswDS2cmV3szYWoTMJL
         dggIicN+PVmlo+5OPSMW6DEPUu8ooHGybA/ECWKic8nSoU50W702xQU3yUEfb2Sk75vr
         zwbP16V77aZ3cuXrq4QBO8/tJloGqAIebs0Ct+4YE32IcpQfB1/QYeI3FvmnbdG9TvbL
         RwyaJd2qTMjHi1QWevOOXJ3D8Z4MfNPZ/sMVl7LNdqIp3k9c3tFvl5r6LtBjbt3bZTxm
         BdF71oMCNmMxLkCSTxsMwMrtDxR3FCAmuIIwn6qgLa+/srZBPq+WoYo7+ndnkN9BUFR7
         ezig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761159371; x=1761764171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycqI0zLskmdJ9GL89kNkCWpDO4WHedc5HuGOuYMuhxQ=;
        b=vGbA5kk0I0CQswCXfzrj1cWD0UyN5F+3Z3FM8zs4DD83UaptBZiaD5Vw68JamDGJZ0
         QtIiTzog9Tu11HOr0rzoFRE6wDzGLvqDMxMuEkvKiVQHLVZeVP2Um35rCDKpCzaB43Nk
         IdgFVVxxLxKk06YXrHdZIaskgAf0Cl5nEorUrTNBodpB0oG+YSJJDOA+M09uAlVVZ6m/
         Dk5xVaXQgEHlTdUMNwdCyUQ/hG0uIu3aO21f+UsZhrlDq+Q3ZZLDvwiACVqNdLrUksDj
         A1DZ/6wuhEYgzh6LEPOcUi7yT38oND6UL0XxbOQ7ESChgK/pYyagUWjdVZtRJkvOxkup
         HtKg==
X-Forwarded-Encrypted: i=1; AJvYcCWHOFT1cIcBLE0qROXkVjymRYbEViHNsjajqci57YxfEs65U34UEzDPq/6+oDORWEIXxPYpkINIWikJXo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbScV/U/Fq4RilaYQhd0fdLkIsSFHRWy/MZIwvrFaif/OJEFdM
	6DVUf481vZcypGoShMxEVD+BYkx+n1/SWj1pKz+6brQeBsElBcc9v5UmdzNKoI3TiOUsr78z4WQ
	3wib+IrEu9tZPMseureoPlizUzob83zY=
X-Gm-Gg: ASbGnctyaPoVFDdiXM6LM7yMBroiRwDj/VXjrWgJJg5E+t9CqzYFZNl00AupIUx3SsR
	yklzHFxWz83L9QbPnyLMUP3Yot9WfnEzxRb8cAikZPCBd883qMaUFB9oELjZLjuoZw5nMoMK5KF
	c4YELs4MChyFcHrWCVt29ds6C3nk5saMvlrDYLS6hz4ckB0B9wL46zVNDzyG/4lQ/Xf4AlqSS1U
	2xLyItL7hexA2gW6AQIDBOgDS+J4hjYszbFJPcuf9HMPgPUnU3zUHCjqrzHQ8vPI0ncoIPeW48i
	FmN+OIjcGgjpu6CNTVbms+OMCfRd
X-Google-Smtp-Source: AGHT+IEQK4lS7wTENTmg3d/K2RTVRvkWxz0OmjhCi4GxGNpOceINpP7P2RhDCCW2CVuqatkVa43OfxUQhgfzhP73I+4=
X-Received: by 2002:a05:6512:3ca9:b0:578:75b3:4326 with SMTP id
 2adb3069b0e04-591d85898camr6905309e87.29.1761159371180; Wed, 22 Oct 2025
 11:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022060141.370358070@linuxfoundation.org>
In-Reply-To: <20251022060141.370358070@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 23 Oct 2025 00:25:58 +0530
X-Gm-Features: AWmQ_bkxIq78J8bGR4Bl7M0BIY16lHxaS-yeq4_ZNjZukPpJrSPGuGvQ-EnMbjg
Message-ID: <CAC-m1rra_aXm8aV9rwQjPKBf9gGDHeqe0E5MqpWHd1BuxgUgeQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/135] 6.12.55-rc2 review
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

HI Greg,


On Wed, Oct 22, 2025 at 1:49=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.55 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Oct 2025 06:01:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.55-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and boot tested 6.12.55-rc2 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without any
issues.

Build
kernel: 6.12.55-rc2
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: bd9af5ba302635dcb1e470488c0fdf70be8d45cf

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep Malepu.

