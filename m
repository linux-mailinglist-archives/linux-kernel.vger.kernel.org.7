Return-Path: <linux-kernel+bounces-857707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E87BBE7BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 000F335BFFE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937273128A6;
	Fri, 17 Oct 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/q5tp5/"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4298F2D8767
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692845; cv=none; b=prkbQKUEeM9J5bgnBMZaV84SIk6LG8L+UuA5DKGdmcKtGvKk34AYoZOhMVmZ7xUZB8/eDJ0u6neZpKEd9sxA+FFHL2ath96YfdQLhZGKvmpAWzstiJO6NQupr11IavfJ19z9hzyRAnwW5zA+vJdgKTF0ikIQ1k937nFNNdPhhzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692845; c=relaxed/simple;
	bh=arpQCWK126GMa9425WGmA2NWCbIvN4MCYLjOgF9A6W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jT1KSTyZscJ6tlLr0vSx7zwBHuTBmKpkfRtbhOGfD3FQ65bdRqehFzS4g6ytT2/X/UcRP0af7iv6RHf7SEk+GWoHMLGZ1/y+ZMPl8Ef9sJOZ1wPJzcyv2yyx6uIUY1AvcIsKBJmuKsebhgzGph14Nz5IQVCwB+eljpxiReGE+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/q5tp5/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290d4d421f6so5775555ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760692843; x=1761297643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LhknjiEqyUugoHigEu5rPV98JBjQEuOdpnABFTzWfmA=;
        b=j/q5tp5/kRtLiFIkzt8qE92PeYtgHPsmLnUNlT/g06UQpfj3VMoKEmDiTLthbV8mNL
         KyxzXq+FgoknaGFEwrayiZ/WIA50n31v24ldR8sntyfaCSE9Sg3gS++ui+xiRHJYRE0e
         +vV83x8tNXBXNYgTzaCxV/rYH3SR8klrETwl3FVGgimkDKIln2eRAPSMsUehJ8vm9bnd
         QHDdlX1y88BvxZJmFTAMjTWSStE3kQxOgWmIa/KtOPABvnHMSmLS95cUtXErzIp8IWFN
         g+t+c8UU2tgqLjCD4dMfSCO2d8JVPcqwbN+I5LRa+MV7/VS0oOCovEpFjygrIaYti4Fe
         hcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760692843; x=1761297643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhknjiEqyUugoHigEu5rPV98JBjQEuOdpnABFTzWfmA=;
        b=lDDT/ia0+FJZrAZsnP0vFySw1vDoo1SACAh4G/KZ7qDeFauEK1xb/IDbku6i4lUQdN
         YXohmbrgINTOCb1TU+Em/MC6WJhg0wPHNAIXIzEcRGU4lSq7++pNPDkM7oRelQ17QFAl
         edHgHcMMbPLlnPMKfbZuAOyjS2bY3MDfXI/iSsBCx2ax0BmqZ5G69dcrDMlgDuYIOcim
         TsyfBaBCZg1Dwf9crF3Ud+FJ9AVGuKhpdCT6qHgHaGGpx91GxVKpLVXTn/Xrx/01jYyj
         Exc+UgwebTc6PFoiRPicrfvgQisBr12+I6pgHWTaUBdVplkAY+zvZT8Jj8g5jp3PgLAY
         Kytw==
X-Gm-Message-State: AOJu0YwSaF2nGlqycHsfjtsu5yUT0O06WE3guiJe9UcpWBal3boHkj8O
	rCr6UFUeSFo1ZFDs1D+vdU+SLSjdQHXDRcBF9LiOe0uj6jp5R5HrQzrkaoD/uGbhfw2mys0fa4w
	pg/ZnkvU/mlrO7ZEEiTiSAbBQAjnFpWCZoZQnpbfYD4yElnuClPTB9Oc=
X-Gm-Gg: ASbGncuwPDlauDnENpDW+bxDc6dJ4f0dSJoQdIgCjNv98Gj1jZ9JEZ5XHOkY/GhIjfN
	gGeFywdhLCqaTuNU74hxceeylnowSmyQAZw0rSF7j20AvGA/5clhSntWdO3b+7yfdj4VdLp3Xem
	zsgoWAP44Oj+NEfO2yckwGBphcPN6P2XcxVyBe3q8yvPI2h82RmjwH1c/2OGD9so50ljmQWuCjI
	Xg8GnXBOIaE1ACCC5T9o9d2m3oUviyCzTm9vv1vLkE9qa6IdHQUZZnyBmUKdG0qHkgw/1/yF1J2
	ZMErxclDBb/bX7G7x95k5OS70CuW15JrrO3TXFJRnqHa3feyFA==
X-Google-Smtp-Source: AGHT+IH8McWMlP4j6h/In61PzhIcYXxJLdaulFUt4hQVbIPHKC+IElEF8O1paYDYvmL7uBRRfha5zKIJziU3JZlwoqY=
X-Received: by 2002:a17:903:b0e:b0:25c:d4b6:f111 with SMTP id
 d9443c01a7336-290cb65b633mr37181575ad.47.1760692843202; Fri, 17 Oct 2025
 02:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
In-Reply-To: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 17 Oct 2025 14:50:31 +0530
X-Gm-Features: AS18NWDlNGurivO1eFZTkxH5OkdGuvePuO7Z9_9bbaV5WCId2Ea8RDnwy82C9Ic
Message-ID: <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
Subject: Re: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL: ioctl(pidfd,
 PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL: ENOTTY (25)
To: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	LTP List <ltp@lists.linux.it>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, chrubis <chrubis@suse.cz>, 
	Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="UTF-8"

+ LTP mailing list,

On Fri, 17 Oct 2025 at 14:21, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The LTP syscalls ioctl_pidfd05 test failed due to following error on
> the Linux mainline
> kernel v6.18-rc1-104-g7ea30958b305 on the arm64, arm and x86_64.
>
> The Test case is expecting to fail with EINVAL but found ENOTTY.

[Not a kernel regression]

From the recent LTP upgrade we have newly added test cases,
ioctl_pidfd()

The test case is meant to test,

Add ioctl_pidfd05 test
Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO
 is used.
 This happens when:
   - info parameter is NULL
   - info parameter is providing the wrong size

However, we need to investigate the reason for failure.

Test case: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c

>
> Please investigate this reported regression.
>
> First seen on v6.18-rc1-104-g7ea30958b305
> Good: 6.18.0-rc1
> Bad: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> Test regressions: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL:
> ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL:
> ENOTTY (25)
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ## Test error log
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> tst_test.c:2021: TINFO: LTP version: 20250930
> tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
> @1760657272 aarch64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> which might slow the execution
> tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
> ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
> ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
> info_invalid) expected EINVAL: ENOTTY (25)
> Summary:
> passed   1
> failed   1
>
> ## Source
> * Kernel version: 6.18.0-rc1
> * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> * Git describe: v6.18-rc1-104-g98ac9cc4b445
> * Git commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
> * Architectures: arm64, x86_64
> * Toolchains: gcc-13 clang
> * Kconfigs: defconfig+lkftconfig
>
> ## Build
> * Test log: https://lkft.validation.linaro.org/scheduler/job/8495154#L15590
> * Test details:
> https://regressions.linaro.org/lkft/linux-mainline-master/v6.18-rc1-104-g98ac9cc4b445/ltp-syscalls/ioctl_pidfd05/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/34AVGrBMrEy9qh7gqsguINdUFFt
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34AVFcbKDpJQfCdAQupg3lZzwFY/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/34AVFcbKDpJQfCdAQupg3lZzwFY/config
>
> --
> Linaro LKFT

- Naresh

