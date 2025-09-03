Return-Path: <linux-kernel+bounces-798699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E16B4218D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94954189FBEB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4B330506D;
	Wed,  3 Sep 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="ioZvnfs0"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592130506C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906141; cv=none; b=mSMBQxq9g1SS7Jlkr3wDNjM1xtfEIRsJ7gYy/RCNrik8BFMhT29yBSk6PfHlOMgHdjpWvDL4Ms7/79O1fMnS49GmnPLtXyqZisGdiLBEfwzI305rpO7uzlwSZR6PxkhBOj0kFbpYtboOaG9KPimVZ4tczp4iTNC/hWE8gALasoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906141; c=relaxed/simple;
	bh=izk0IZmyI3MpZX8dah1iAMq8tH5iGUvz2zunPfvcQnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0566kNgHXfLZXDSY8+IaYmyocw5zwh1nrbGwf17bNL7YquSJtgckXsuAlLbr0+U6S5JTnsEZpNDyVnSYLPqWEI65EkcNFFOp5E59iE7o1qZlknndxdxX/ZL4BVouAOarA4/uAln6B34XBqdXmWYqr1nODgOrnjwJdNt1yVs6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=ioZvnfs0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b2fa418ef3so61748341cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1756906137; x=1757510937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1xV/deyqGkmJxLaaOIY+1qBi2UrFX9CrtK1ZvKF0rs=;
        b=ioZvnfs0EEux+O5ebgtLh5ydx4q/FfZUlJsrglde3QMHaDyth48lnMt4N/aKt8cfCn
         xuiuBzhY7o4kYn6jnqO7374/Y8yTt7otArZQOwUhd9Q/bSwRcPixTtmHBFKPsdEathWr
         T+2SD7XLv0GXPmMGka5ymcYysERZEag1E9mGmlUA+daWx4J3UF7EZJBKbWF4w+u6FZG2
         bwoXZFU3DLIWgThJ2ZhO8K/FUfrOjXq7yO5I7IJLZKuTzdULZkhB1Gh0sypGHEXj6x+J
         EHGdvZmF5DrW2kF31mLvgRISSRCCWqeBCOzJXCYiF9e6BCfjzIcn4kJ6o17g4INVNSDk
         s5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756906137; x=1757510937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1xV/deyqGkmJxLaaOIY+1qBi2UrFX9CrtK1ZvKF0rs=;
        b=SjYdyBgOQRMLy9GMwLOTQg8m975u+2HhXEG2PUhNckSrUKLJUbkRpRSCRQa1qMzHSZ
         9WR85vKJYEnEi4e1ROhRq40qvEro2iLl32aPCZUTPWubY309Eg/fcrl1drJynR8MJfM7
         0tYmsgWpyLG54NEXIPpxuGERuQ+oeJMTVtk96m27J638cC9HCSrC9VT1qrlaAAjwaqg+
         odr7MzfUxbOqon/J32pDPyZ3TLlB/2hY/sEaKy4TT5lX6kKlfe/pk4jm24rnLVbBBi9e
         UlLhYQxK1RDcJpAaS5VDJU1QLK6XN/WOHqHkFUGzHU9fTnPZB2R5IO2IL3RlG0lhWeed
         mq1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQXcLbtPqSJehfN+vXiyC7/DEMH5VK8ib37Czt8861vnykoDVXsN84p8SU3HepA0gWD9sHM5FjS0i+yWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZS9ee0awo8sqf41akrfAFUgM0nvaU4nF4Z13ROaR7oVngIwO
	lTsaOZiAxWFdaUQWqepYl8QArqOIz2ROyWU3fcGWSdlQSMlygJc+ewPgGfk0lVjrBVYyCY++RrB
	D2w0X0eOrFpX0id65ro7zZ1XmUpNM9dKzBmbEqJ4itw==
X-Gm-Gg: ASbGncvuWchNHsVC052h5VidChkmGtFos3JZex6bTvZmFQyhQ+CzBD8XlENKlHMhdGp
	11Dj+WvuHUf8q2uff41WBtEFn+5AoOChFd+AV8dDC/+lf/MHFY321z4+UZ0+PvzM/KGPK1v9h5e
	9WR7+OHp1Hv3nndzk7su09HpnQh0fvzmjw1WBwR18cNjdLOfVhgUQ6FOmoyuUhVpdK0QGkU/B0G
	XGTIHoD
X-Google-Smtp-Source: AGHT+IEb9SF0ZAQ/gl70xHietNZGoqqgRbcYfcZB8vu3mSrxASuhTzMLNODi+2ufxi3Kb5/VCv5lEH2P3alFHmyuJUY=
X-Received: by 2002:ac8:5d87:0:b0:4a9:c2e1:89c4 with SMTP id
 d75a77b69052e-4b31da3d038mr183413971cf.47.1756906137150; Wed, 03 Sep 2025
 06:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131939.601201881@linuxfoundation.org>
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 3 Sep 2025 09:28:46 -0400
X-Gm-Features: Ac12FXwi4i5s22HaICVQk8Zg7KdU46JZLCzhgfwfvZeR0OQqZCIwhAezRAG0Tdw
Message-ID: <CAOBMUvi4yUWxMLU5usvYsCVd_cKd9iQHBqSzVp4sW4Kc9Z3fTg@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/95] 6.12.45-rc1 review
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

On Tue, Sep 2, 2025 at 9:40=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.45 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.45-rc1.gz
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

