Return-Path: <linux-kernel+bounces-864882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52291BFBC40
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E8D4235EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E1C2C1589;
	Wed, 22 Oct 2025 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="XJKCzpAB"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA02F32E12F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134565; cv=none; b=bHH+6O85NWVv6drQVClRiAcucl2XFoqyju0F9KvUjDM15NXnIB0GpLN/k/sWHodBKOHJIz3dJkzxVlMgtdk7T5m1G+MBWP436MzkFQoawrRD0n5YEKzsOqbBivabtyQgXGbH14IH6mjVhRQCm9Drmlzdl6aHyyPc5cy1rbOkkDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134565; c=relaxed/simple;
	bh=qc+TGmxJjDR8e93EuCMFZsvuB2trJNVKy1yWPZqivBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CR8ZxNWS9O3vuApfEUxtHlZQx6sHrIk0t3Wnbzl4zqvaYBxKxd3bkWMPajQesQ2Usz9ETrVFOFGOaIn95xorl7At9bpbnwNFZSW8s1jJgJr2KgoRp1TXIpt+zpjZiJdpM8H/PSiF73FI5FGEQzy8xLYuvZDidpayJUD2C50i230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=XJKCzpAB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290b48e09a7so81339655ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1761134563; x=1761739363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5/wbf6GFhoGu3668TdoXMB0FT53GKQn1LtblB+CeVA=;
        b=XJKCzpABZvpOntw5f+NpGJ9RnShY54S2mztKg2R14SMf5F4WbZdKnyWpa1DaVI2CDD
         9D6V7q9q9LDgB6873yjqSXflbxCHeRpb0y7Kcn8cNNqZ8nKI3igqOAW4Z5I5QuT+d1X2
         +EEuGbTRWTMlyRtyJjLJbkQa/JcKP3+IB9jpTkZAgLbGK5plPyZp92wt8alWB9eO2fEJ
         KGvWAuwk3imBtGmofvHAtxFIIeIW0TO4RVTbk4GCf7FDZa9PzHaoVOK/zl9ViqJCjb3a
         L3KenxeaoPWI1UR22IFLMNVCxIyRcShtaj32S1n7epd6q9wQhIowW9CPgRz1h2JU7PK3
         s4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761134563; x=1761739363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5/wbf6GFhoGu3668TdoXMB0FT53GKQn1LtblB+CeVA=;
        b=DnIwT9cTlaHPratotdzWZFyeURliZkyMJNCSlBtVolDPwacDdDsJl5caLE7Cfit5xB
         9XyMKXRupbTE1goft44f1eB6Qpix6xLq7Hen6OsHub+de2CAVKJdXS+J+C0oyt+isG/R
         0FkKJI2jrM/j/QCZpkLXtd4suu2Qblm8eX43m9/8XPvYMdz9o4cZIllznqCob0DyDA+r
         twInUG2rFt8gawmftMTY7gI0EBnk2533/5c+ZVmtd1q5Lxpp0mZxruEyo9anzod7NEk7
         sw0v8FfnfhWSC19w75aeEdW/6Snrt/7xC3xlDrEt44tfcMpLYnXkNlAxIiM87HzAU/9I
         JPqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXByKLPByYbpL0yDrhv7KyAQVT6mWreaK7X+/IQI42TZTobqFxruZOMSYg07qg5vuqnyQYJrijL781FEB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ji16zIdxd9zCqzJN1Vpb6TxrO8Rmgqksje4urRk0Q3gejTok
	7DszHNieoeJJIEs4RMWBXq/Nh55ntZOHz3RH6qqY8/F5khi+Mzyuq1u6lYzgWu05Wl769F1pLzS
	nBzC+BcSnLxqLLCsSq+mVsRE7cSYTuOyJYfbMBS4gUA==
X-Gm-Gg: ASbGncuummaqjNe3ejNz7e2gCWrdFoTxHz5Ft6jagfZgxNuL9QGxt1ytYZLvxPsyTNK
	njeuMpyAXYfprEakhO4ysi6BfKHeu6l9h0KQ+ZOkpmHVOPJzmVgm/N6FIzYDzsnbDI/iTJklbXd
	5Hw6845NR+xEqY+ZLA/nEnyulZB9ibdd0um7PucfpU+i4PZYoqGllRbye0wGTxBG3XZ8NyzEb6L
	W2ens+suzpNXI3hvncBdkU11s2rXS0JQuN5vBKXM+vQYk6z7zLGAGG1LBbxuYVmDo+SJUXtdQKa
	3mO0sryD+nwI91GrP/G7NVNpJ6a6
X-Google-Smtp-Source: AGHT+IFL5t8enG2Zw7oK7pknpiCUZ9vYUeXHaONtu4SrU5QNhCELXo3GPXNs5SlUx4N7/HvLFJQcnXzAdCHO9w8JdQ0=
X-Received: by 2002:a17:902:cecb:b0:290:c94b:8381 with SMTP id
 d9443c01a7336-290c9c89dbbmr301590825ad.7.1761134562657; Wed, 22 Oct 2025
 05:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022053328.623411246@linuxfoundation.org>
In-Reply-To: <20251022053328.623411246@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 22 Oct 2025 21:02:26 +0900
X-Gm-Features: AS18NWDUgkoVTtfgD8dgXCgAaXo5KDUPhO3XXcd_9Q3gWO6keur8-RT4nYB1Nl0
Message-ID: <CAKL4bV747Ucee17YwB4y5L_We7Kk5aRe4REckptqgfH2+o2LxQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/160] 6.17.5-rc2 review
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

On Wed, Oct 22, 2025 at 2:34=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Oct 2025 05:33:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.5-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.17.5-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.5-rc2rv-g3cc198d00990
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Wed Oct 22 19:52:46 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

