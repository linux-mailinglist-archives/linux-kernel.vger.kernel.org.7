Return-Path: <linux-kernel+bounces-838100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20322BAE710
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50491C2755
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A55228689B;
	Tue, 30 Sep 2025 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPjRbwDh"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66828640F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260461; cv=none; b=qwqs+cHenN51Wa6+yCwC7/mhC8QVsLGy+qoAU0RVUY7U18ZI8XDeyc+HS8p7g52jE+Fl7Qy+Tnhicdv0RUCaSq+vW70Urzwk54e0L8Iaa0rMHcSzH6tNNARYAgIPfAwgxlKK/K1e/w4gEYbW5GsM+4nMTMOYfBwgQ1xm+aN/rAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260461; c=relaxed/simple;
	bh=0kyHnmwQ/a13Xmqwsp8Z7wPblzDgblhkclYLzTai/nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpmKUSIiUHiybXU5RBbNhFbJ7gkEpKtUzGN+7A2ZqgtTBoZyqnn2UftBuek5EPwRmi8qVWfCessAuXTAMq7lcRl5VWNswwOV4UvvOfeG+OWfzMHuwiMgDEWtZlt7vOEw9NSY/zGpLsg0oaiJZ139O9/1hsZKzaTcxRxWqRB0Ek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UPjRbwDh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-279e2554c8fso64693545ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759260459; x=1759865259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nQxDxajR/Sam1KSYzGdudBRiapg5rl5sWBWoYDLBG+c=;
        b=UPjRbwDh6KxNGp15PjjdQQaYVL5h0zXwAw+E3mJDn9R6fg0YjiFnuTZQ7BB3eo9NgU
         D9L/hYBbYAn3YRQYAsU4qBouX5pQDZ54ODYvVl3kzCrY11XugqMXjSb7MZA8mUYUjkZC
         eHJxn1NYUDKXyHVhWrfwG8l0/E1KoCE4nrbG4w2zrMOdaptypRallQsLa8XVWkYc/1yk
         09NcSTePFbC0qBvdn35+jB+rLwAYkD7Ev2geG92iz462cHSLZRwKYDpADaS6NPOSvEYF
         27Oykzk2hAv+0PB3EgadHR3GCzEHOxqg6VYlJPQr5ud0QbMyIcPyNEyEGySJXKQYY+4c
         a4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759260459; x=1759865259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQxDxajR/Sam1KSYzGdudBRiapg5rl5sWBWoYDLBG+c=;
        b=wRcXTPSZL7xrvFGN7/pvhrnfY198/Qf2EjcnRfZCFZ6HyMml1Vrn0sXTYLMinaYm8T
         ZAVvcYyzv4d4dUFhQQM5LkxyiMICKUn7wKzuTPee6u1yQhODLtTbHiWaGIPc2Zs2eBsN
         xHClNmIhk7HSHe6MhTv9l+Zbc9bet2OswgcMvfTvbweIPmA1Vu1Md7zZLI+xY1LvS9F7
         AkykWlnZ/4F7v5r8qxqCvp8va8CjcAI7MBvMXbmhR1O9uk/x+tGKoQaE3ed9dBOSbbxj
         9Y13vQWSmUyQdzGIb1s5aHXHF+g3Aqc/AtqxOjNhAYYRTzDIF5uT8dvPck9H5ozgH2zb
         JCtA==
X-Forwarded-Encrypted: i=1; AJvYcCWRz1iU1hGjnSSfAoCMaI7NBWbQKFjaB5w4mI9l1OStd9ZRrQk/p0h20lfi7C6wzl6vznpVb/+n6hws5rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHqDexW0utp75II48UMvZ1ZOF98TCN5PcZeGpTG9EQeiKQp4UI
	zkmc10v+V8WLV6BD0UU5PXIJ+oL/YiIslAwzOTpzCJzmsiz+N5/438wnZ2XGAqekoYLDOP5QNBM
	pOLPOIycnCl09cy4WNgi6P/xk4AMtx3kRdz/iH6N7hw==
X-Gm-Gg: ASbGncvKrJxu5QQTeNzG+lxB5apGUcexoM7QJM8gfFTAvxZo833NFFymIUC/CPCYsnp
	PjtgLa/7VnJDEhyt9HLQOhyE3DLVkqY/UYBwc6oHiLHFBgDHd6vbxyVLH2+pKdmF6TasfOi2zr2
	/OQcfPgnwrnWQlKHAruFmkP2/PbvBihEjBRlSRAq1LqpOUfC9LtMQz++csxMy9P+RKskYQYh85P
	i22jQqo0uvYQjYSQRpSoRr3K+aGKqdwrAZqWUI1S488X7lye/s44c3uU9RxRnesA/vz7fiS72qY
	jWUH5c9hrASV0QTirC+LYzATWRIfVek=
X-Google-Smtp-Source: AGHT+IFaFh/dbgGIksQ/VwhgUOF+6SoIM70lxC8KuMuId9DIvXVuvWGEyxJOxgnRTVPkkVHSTJPrNd0WRWY/7Oxyd88=
X-Received: by 2002:a17:903:2f08:b0:288:5d07:8a8f with SMTP id
 d9443c01a7336-28e7f2a3ba2mr10180705ad.24.1759260459391; Tue, 30 Sep 2025
 12:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143822.939301999@linuxfoundation.org>
In-Reply-To: <20250930143822.939301999@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Oct 2025 00:57:27 +0530
X-Gm-Features: AS18NWAq2VDGjJYBroUXlLCPyC3gOIxToosJNMH6IsWUcf3ow_eF-wBXPZYh-6E
Message-ID: <CA+G9fYvhoeNWOsYMvWRh+BA5dKDkoSRRGBuw5aeFTRzR_ofCvg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/122] 5.10.245-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-fsdevel@vger.kernel.org, linux-block <linux-block@vger.kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Sept 2025 at 20:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.245 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.245-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following LTP syscalls failed on stable-rc 5.10.
Noticed on both 5.10.243-rc1 and 5.10.245-rc1

First seen on 5.10.243-rc1.

 ltp-syscalls
  - fanotify13
  - fanotify14
  - fanotify15
  - fanotify16
  - fanotify21
  - landlock04
  - ioctl_ficlone02

Test regression: LTP syscalls fanotify13/14/15/16/21 TBROK: mkfs.vfat
failed with exit code 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

We are investigating and running bisections.

### Test log
tst_test.c:1888: TINFO: === Testing on vfat ===
tst_test.c:1217: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0', not
making filesystem (use -I to override)
tst_test.c:1217: TBROK: mkfs.vfat failed with exit code 1
HINT: You _MAY_ be missing kernel fixes:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c285a2f01d69
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bc2473c90fca
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c45beebfde34a
Summary:
passed   72
failed   0
broken   1
skipped  0
warnings 0
<8>[  868.434017] <LAVA_SIGNAL_ENDTC fanotify13>

## Build logs
 * Test details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.10.y/v5.10.244-123-g9abf794d1d5c/ltp-syscalls/fanotify13/
 * Test log:  https://qa-reports.linaro.org/api/testruns/30062041/log_file/

--
Linaro LKFT

