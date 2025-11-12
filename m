Return-Path: <linux-kernel+bounces-897855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BA1C53C79
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66DA53442FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9DA347BDD;
	Wed, 12 Nov 2025 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1fvbV+m"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD470241CA2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969715; cv=none; b=SsZVocyQqJWWjFzjzzUaMAJlcaw/7W0OuORxONQdP/xt3FHHjL+FCVR0Y8buhJe7sRLKLYXpkLJ7cs2OxAXdJlGkqo6zwzHddhaBLHDK9MCSkSgmsaPsUjNDRSMS9HDwfekma1Gu4dA0m/ceFiouM63r2JGOOPmtFvkfYyan6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969715; c=relaxed/simple;
	bh=alg3GZVbOGWLPqlw23mtYgLHmyaW7rHaNGquInyV+is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WadeQv+ntzzacayOwvYRxp0iDXGclPB9DW5t5IoKLB3UTBlYSJJVWXo/bzo1qTnapQLAkLHUUGhxjXPtO3FNdFfc4bxeqYRk4QPFDHm+xaOXk3Vsop4AR7p4HmC80dOVt4AcWXHklxhW8aIyh5uX4o1Iu6/D9+HOypxTdOTtd1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1fvbV+m; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-378e8d10494so16808941fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762969712; x=1763574512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RtNiaEUI+oSnsJyG/c+SNYFc+FQ7s2DIR24yvY/faE=;
        b=V1fvbV+mMgVSsAB1Nqxpq6G618nkNw/bjmbg7EIoquzEqh8DYGfIi2uzdUkSwP6fV8
         cvSVXqpsi1eE32GbBU+4xz+mKNn1UG04yh8ZeD5HaGEmph9Ymio3Xpm1/yZ5pqlqpwRZ
         fAVcrkZS06I8J2DrauTAi3rYGPXhokJDf/3+K+huiUDRKisK2jaGGo4HkesgTgzwDlVt
         NFRjDyVE6I79t4R/h6ho3V89hbNqOKk9k75kbou0lrOnFyGUQc0TXnmVOFKfLZc9pjjE
         1x80W9OzFFpbnYj9qxMlc7900FP5QC4zyQWXKtJ0+B9r9bO9zXTZ2XZsea12Qhpo5cZD
         jc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762969712; x=1763574512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7RtNiaEUI+oSnsJyG/c+SNYFc+FQ7s2DIR24yvY/faE=;
        b=ruuIQXmbdyah9ERt4LpDz0QpMpxp8QLpxfKtWXNK5qkswns97CId57I7wEfRkXk9Fr
         iVC9DhRKZqJrtCIpADynq+EL86Ez1/HgKm/ZxtkQZhObmgaqK7yfADC+6Aa/Os44cTF/
         fBKzPvAfhoFfbErRPealmsH46wiqB6KqKzB1wc8ROR95H+XG10Yl7/sSpnnMvNpm+po5
         DeJVn6BMOTGqyK0ahuyxDmP491pQ1rDwO5ETl3iHOXYjepIZyn07C1SE6jJShEV56oP6
         KCMpq1XTS20dPG8J59QW0X2IfzYqZIUOjXI8bvpC8RSsvGvLH2eSlUqd5yxdMofrrNSs
         fbLw==
X-Forwarded-Encrypted: i=1; AJvYcCXYSn6Kjk0dsz353lxVtORjWs2OpLqFx6VhXjX18usjAAUt4TEia7kh60poCrRmCeZfHr54UxKO/1mXQNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9cmE04V/PusNu6Al7ATbHBr+zBU031Mnbac88UKQL+uMBVky3
	FSnXkxEa8RpDetaA0r1uWHgpqL/zzZqxZ74S3w9wdDsXcEL0xl77gFohUPRahBSiL3avYgZmmya
	Tu54nSYKC8grxK46olvk7VeJPxWQbAQM=
X-Gm-Gg: ASbGncveb4A3JK4pF3/7qVYwO/lPEURdYYvbZhCCOq27Qsjr0VrgxSkIlRD8819Wsvw
	SAKXKNW8S5hTPPH3XTYue83kj8ziiOodG9dil+fycxt/jTSvtch03Zs0140xF8XPqELbT9zZNLz
	IuXgKjFcgHvFuWM/4GoXIo3HGJPBbtDQChO9gj/QFEXwuP2cGdpvLejOuIZRMebm/NkrMFM4FWq
	z3dANCxIiztW1+bR9tsS3YTJ1zqw/1Os4tdNMJimuqUN1W73yxefJs/z414ljARQlodJ9c=
X-Google-Smtp-Source: AGHT+IFUSyjuKhia9bnSd3m+2XKy8hJzcQ9DOE86De5ut0/zfw/syHIlc0LrALyxrMp9Xpe7aEiZMUHElmGsUj1/cvA=
X-Received: by 2002:a05:6512:12c8:b0:592:fa8a:810d with SMTP id
 2adb3069b0e04-59576e0c293mr1351088e87.16.1762969711505; Wed, 12 Nov 2025
 09:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111004536.460310036@linuxfoundation.org>
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 12 Nov 2025 23:18:19 +0530
X-Gm-Features: AWmQ_bnluPVMUosVyxKqvHFL5eHej5lPP_cCQ5Wjldeq2Z-RlGs2I1Xcdqu8o74
Message-ID: <CAC-m1roJfjSk8iTSGNSE=fELNaUORwFmMS6YpwL6B=Ub=DWHnQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hiii greg,

On Tue, Nov 11, 2025 at 6:18=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k
>

Build and Boot Report for 6.17.8

The kernel version 6.17.8-rc1 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.17.8-rc1
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit : a0476dc10cb160082a35b307f8dbfe4a066d41ec

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

