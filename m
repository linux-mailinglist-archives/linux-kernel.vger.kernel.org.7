Return-Path: <linux-kernel+bounces-752246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E901CB172EC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D87C563DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DAC2D1F7C;
	Thu, 31 Jul 2025 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=ciq.com header.i=@ciq.com header.b="Ei5u/Kud"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32EF2D1F45
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971170; cv=none; b=PYemmZRY6LZ9AfCDJwSvFUnk/hua7hJ2MR68g/G8Ifeg3NlIGCRMv0rRCi4riZt/YKMybfeLCFdPfgZ9oD10MT0B/05SNHJGPRb+jgSK9M9MG++Plt99dBqJAttrHVSXQklReII5h6MWFZO6F8a52VLaI6RB4ODyYw0BW9C2Ua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971170; c=relaxed/simple;
	bh=Idh9foYlobnkqdDD9TDu5/SpFZZrciK/ewtMb2geQbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5XAGTAJ57KIlxxZ2cuEMR5XfwUxKlT3PyrJ6pehEI5Z4jYvb87Qu2JJ3BVp4HQtIxMnxKel0T+l8MdxSsuLq0hjCqcXTp1/8EkJ7IR90ujaK5noMBqiTIQLLIXUWX6HhEcEuRdJqdJTIrXyILZDcs3v4wxOQfbym+4UUN9vjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=temperror (0-bit key) header.d=ciq.com header.i=@ciq.com header.b=Ei5u/Kud; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e623a12701so40213785a.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1753971167; x=1754575967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilfwqsoaQ9met52S7qm5b2+HGaecgZb3Z6l9hEzitcs=;
        b=Ei5u/Kud8RVzgsD5BKdAMIIh4rLkBDjLf9CMR1mg5yyrnpCrpLvFamIwJGf7Gi0fsF
         X4Sd4vizJhgr5RRHPN/ph6pP54y0HM116zl5TU+j/GLn+iwO8pkIBBOzmAQCJshl8hBA
         e/HKweTgOFrRg+avHiPYfervT/BGyoZcitDy67db7VYLrNwfMssDHKz44pLqla3i8BnC
         CFPNf6auWCxcjs49oAYrE4gtQstipy5TedSkGQnMW6hLyfDOzIR7WbMbQJ9URRZL091u
         drRFITzHvxpDGCUlSFD83IicR/fVJhqJGrndjJBuf4t85/RoZZxrMcnZQs0omKjIPs+W
         vYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753971167; x=1754575967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilfwqsoaQ9met52S7qm5b2+HGaecgZb3Z6l9hEzitcs=;
        b=FsG/i+wt3fSsY4vh/kkHVD4EYpRy0GsxjP2gZzXzTsXBDnwetiWDcmUINUxd5XwFly
         nNbHCbOlU8mUY0RoFfC4onJple7GJOwp2g80uSq3j0GV44mH+tHzUSm5dNDrZOS4EFkp
         HjtlTBUKOE1cEGacgWXXalgSWNzccAi3Ii6R3HxIV1ypQLQC+nOaMpKlhVGDqna5aKSv
         iKSrw77sFXmDNtbDEw5+H+lYmWsIj3oBU+0AOrH2L/PdtqmII8v89yaDpCNtjg7CIFqe
         KdCuhJPXSJVPSDydy4hKA6bHTCdPoBAvtbqjRfJOKhVbPfZC4pf4xjr8+WPEu5r/cAlQ
         gzkA==
X-Forwarded-Encrypted: i=1; AJvYcCUUHGGFWjGN0+QrUsVVBSDy2x2SoM9fXyS0GYMTP9d9e/dxRaTuZkFvbMp2II7ZhbasaQPj4sKAoOUXUh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvztMNEx5ZPH6MxrI77f3KOYFEFnrIlKS5MwSaahD+OkCzuYsw
	9xJuxMq3iCnVmHwnHVwE93N4BzKm4fuZdWMtde/TRaqUbPKLQ7U/m50UZugHlM7hRK7No5+Lk9n
	TdyuFAYf86R4HGCOyFgVMmsKkn5rwncRERY9+oT69eA==
X-Gm-Gg: ASbGncsN4SdaEvKqmip5tocmfn29jEWjeMxBwUp0IueTS8+Y8Yu+CdzRWvtltRdMBuW
	Fzyj5rJb1HAj7beNy0N4ut+j8dyZmwjvJy9d+AbIdIERJb1/YDpPC2NZJnA/tMiMiYRejEe93pL
	1kP3gsSwQCMxPojFn4qOdHQJ65U17T8GlrXOHdTvJ/O91dGuU2+R+xlN7aBOn697r6N79pnTpiG
	xX9gg6f
X-Google-Smtp-Source: AGHT+IEZGZAjJ6oTT/y0eC5XEJAwdjFNArop3uSkBDdCtmPqSMYvdMHeSgLNTUW+1pljPGLH32dL1zf5CykkNJQ/IMQ=
X-Received: by 2002:a05:620a:1997:b0:7e1:31ca:954d with SMTP id
 af79cd13be357-7e66ef7923emr1043723185a.13.1753971167480; Thu, 31 Jul 2025
 07:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730093233.592541778@linuxfoundation.org>
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Thu, 31 Jul 2025 10:12:36 -0400
X-Gm-Features: Ac12FXyV2Urw95nrCpp0mmTC6H-HCM7BEoKwi79mPFC-PVRxatkeHBA1vjTgd5s
Message-ID: <CAOBMUvh13vSvX4m7x=AvW1zrXTYfyF9J0JMsAwECY9gku1+=RQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/117] 6.12.41-rc1 review
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

On Wed, Jul 30, 2025 at 5:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.41 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.41-rc1.gz
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

