Return-Path: <linux-kernel+bounces-838509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726EDBAF589
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8213A45BB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD45123D28C;
	Wed,  1 Oct 2025 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4SF4gYz"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECBF271469
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759302098; cv=none; b=vAlJfFOQNaa6+HweFXGWLePmkXqAFJ2ws1h1+ixl3pp6ddqYdEu2ldxgX5YMM8LvJTuHPaZpsW1+aloeMDfbeR5yXTLz94OV6nR9pZcfgh0v8ISmjDawKGxDN27+uPqDonpMFmlCGk8KZJ7/1TX2x/x/QaQ+emJju8eEpivSf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759302098; c=relaxed/simple;
	bh=NoddTmT1ZpMZmhvqL/VnxeYOx5G30Q7gAZRFXZdird8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwGAKtSahOrL1Z71F9G4Dy/y143PVLyMLUK4e1Bnu05jNh/lU44RYJBtFf0qBo7iIYnBeupcbplfzie5SaQ3wbDfMbKyGrz0oy1kYNL3AvswbPuvkIxR/8CfCdHUCbot5d8qOWIZ3CE74NH4o3Lp8Nm5Fl+fTEd33dWw++Ti690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4SF4gYz; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so6445138e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759302094; x=1759906894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLTUhbN3S9oKDftwQ4KAabVHzCpjwG5/226AXZhhAnw=;
        b=d4SF4gYziQUTLErGuJtyv1QWLx6wGi331oc+QqcxSm6kHE9paW5ncu/WgGuve0AOHC
         N3tyEAVibeYQW9z8WrDGSmn1cpAn4zvF5ilPQHjzLOJbQlLrGNzfUcCqPYeCYn31QGj6
         BuONJv+iaNNXCtYdpkn7EZCm4qufc9B7mZPBno1WY0Tz3ReyWvcOAJfYxdJmCr7dAdKw
         bCdWHQXrl/E2yMo7wsGuR9q4H7BjXNpzyPkVIUXGBEeCLbXk1XYiZx+u48uR7KxJ5qt1
         7kDX5yMs7BbPlgDq3JSBnr6V1tSPwjZ0MIDxGfjZ+zTBKVX7ktGRJxKEq1OmCgpKFrCl
         zSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759302094; x=1759906894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLTUhbN3S9oKDftwQ4KAabVHzCpjwG5/226AXZhhAnw=;
        b=AV8nGsd9DBX/eoOTkDh8C6ZWAN+VTbMFvD5cL1LmXYWwPO7v7kocrlOwfhVXhRKiOf
         83LKQh2ZJWzcRW/tH053MC9FU/ymFOpG+D3cWkaeIaOmkLPdnQonCjeolNbA2YThgF1s
         XLTSGYE9s3sspOJRgfgepbhdSdSZlgW3Hqvm0GX8xZExPquBet2zXOs3O5Fmjr/1DJei
         mGngUl/qP26g1pt6lR5YJY+N7+wV0bzDc9qkNEwrgPfIGHjNTykArvxYT8naTDIRuCDQ
         LBsfLVe/stS+BtdMAYyVpI+JNJre1uMV9jdh1H25KqNoxJJDGnYhB+s5hBMIG4dMzwJE
         w/6g==
X-Forwarded-Encrypted: i=1; AJvYcCXN9j62xqOQ+GK+vXsIkvFiEKYQdOwDKQ5VbWJOa3L5Ioau2BJ2wEp9gN8VzymEofktJY93g3t/gBu81kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4sZ4G4xcxkYD6faw+PYkkvHJOn6f2TRuILCduZuITRJjDdQY
	VgwWVCgEIx8xXhdZQMWEDScgNV17Bg8ngKlwFVKvbNthb6yqvzBqEodV16WXMLEdTh711MFdRL7
	DNnbTGx2gxI1qrNauSWbf78Oq2KJJBhA=
X-Gm-Gg: ASbGncusQI6u/f3VROWZ3gmJ0r+GMplM1VYbT8DLojB2SDoQQ+8GEaOO28pBF3rCByg
	z1O30EbZW52t/mv+szF9BzyOEeXCae6okxq0UFPop15WhwPZsAOTfBKaVg/njApOKlNpNJLKDyU
	84Hf7RB+c6cqI+BCt3RIqgpFh5UB3IDo0ux3oK/wRfiiCnjRfZZp77mos3ARhKQJUpJgOLDfTWa
	ACFpFcTIGWdWNyYRhjnxQtG8/Ab1Ph7YRTLL7waPr1mBLQTP1A/vRLP3ZkTY0gXyUHH0G6RTw==
X-Google-Smtp-Source: AGHT+IFwcnpELmeJSQeEEzcc1sfvMTyHOGQce3S8i35SE1Ix9luZWMEUuqlQ1lvfYGfcFV55BA5E5+gdos42rFQPf/w=
X-Received: by 2002:a05:6512:3994:b0:586:83e2:228a with SMTP id
 2adb3069b0e04-58af9f4a92fmr623509e87.45.1759302093749; Wed, 01 Oct 2025
 00:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143831.236060637@linuxfoundation.org>
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 1 Oct 2025 12:31:21 +0530
X-Gm-Features: AS18NWB0_y7FqfcK3WyRSleddS4VDm6-xNbmK1P6eeEu7ZgL8DsqI6nEF_XJ2II
Message-ID: <CAC-m1rqxJ+wOODZUacmDcRjzNYJqE8OazoP18mY0KDjt1kPAQQ@mail.gmail.com>
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

On Tue, Sep 30, 2025 at 8:34=E2=80=AFPM Greg Kroah-Hartman
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
> -------------

Build and boot tested 6.16.10-rc1 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without
issues.

Build
kernel: 6.16.10-rc1
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: e1acc616e91adfbab433eb599e00d88f0bcdb07f

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep Malepu.

