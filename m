Return-Path: <linux-kernel+bounces-864448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66727BFAD23
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AC31A07198
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF08F3016E6;
	Wed, 22 Oct 2025 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bK0vQGOi"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593AD2FD7CE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120619; cv=none; b=kF/I4xiRWas4q9IdZtGqs+YohbKhQJtqOeoPQLHTAbWq3ewMw1O2OMYJnVl1D6KD+fUItHkAjBGvi7LoTO4zDEWd0rnl4BJZxOAu+ACCR6l4oig0V47Bm6aarFKI1xhjsiKvnb6KVZocf+sGiL8IAFiHdbl4u+2ZfieK76cgkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120619; c=relaxed/simple;
	bh=6yDqTislwGgHhuTSoCOgEAsmhSSDRdKbbzHAvrht4jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6jPPOwBgCPHjqtS7ZC/7l7+WvRHqd2BA8/woe60OBPn045jEATp+pgtCUfo2fLbdcxDBK0sKJpodoeEentbgKRMTuqBUnfKt/3E4+jf1a+sSkXsKg4xbXbgURSNWNVkQwD23b1nWubyDL5LrYH87tIIEcCGZFdA+rdnwjLYMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bK0vQGOi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27eec33b737so98647495ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761120616; x=1761725416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ePywcST/UbYHzI66VBMJAjk1GlQaMlqfpX7Q31qmueU=;
        b=bK0vQGOiQgdls3rcrgDVlrVCXfspGHXp6Vk4+JEzCFgCn1pAVc5aRTUHqQAkh5M1oG
         xjZ4YXrWS5RWesqsD1bZEI4L9tX9VqOZ0V+J36Fww/oIyOeMBoluWroq6kEq3jBrz6wy
         h2nPnHppFFK/D/anQyF4Xs6pxsAgdDaX0NlNcJLPVd2+X8VH40SxYU6OCrThCDyvQeCh
         s5P2DGkoJERQyGcQ+p+/9Z7yJQln11B/47i6ZJDhDSJnUEP1H8FHK9vmILCawzL38tXE
         PjCna1MhgvYYWZhzqX/EK+d2oXERcKI35H+9gkZe3p7oaukm5SDXDT0rgJCjieaG1dQu
         ysyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120616; x=1761725416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePywcST/UbYHzI66VBMJAjk1GlQaMlqfpX7Q31qmueU=;
        b=DLXGHkNEe6f7UfAutyTlHsRhtymjQTUlnLo6yUeb/H96r/LywoMjsJ8LH3HqdetdI1
         EUMJyehx+Z/HxccMmBjK7L8lgBoRYxvGCHQLb60zK0NdEMJB9Lh/gqpgHebz4NGW7POe
         WoaFzpA3rdJSCuqBdhnKM9+NbsbW5j8Z4PpxOBYJlxAxOVXYnGLy9XBU2x2gv/2Z+pvN
         SkqTDkvlJl4UwHamo7G1cv5qpfo2rqVZ7KzepUQlM2/gtrJDac5UcoWU7tgX2ztGnS41
         lBsN9C2sbnrZjjB2yMcG/+goW8hTy8wHdbTibQ0DYRKfeXNWooFwD5DGWJozOGt4AHFh
         HHww==
X-Forwarded-Encrypted: i=1; AJvYcCVY4EaMgJPTzVzy0E88WwqSA6TsJjM+QyXci4D7o2MfJLw8RdJSw4XaaRvCkLyOg7xYkLZMAjx5/NNE4lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyobhGLWNFMJuBW/RHyGaDaVs1rkYpUbA1LF43Ejm4Q2TtMrnN
	d9NnAtTMb136tGMDyUVr5jaUV/CN0K/d1Ddejqefd5A946IGEqblETn2C6GocUSdIhfFf1rCIOr
	Y0UnWCSPnj86Z9eHeLVackyZuVMW7LX+GCAOFlA58MA==
X-Gm-Gg: ASbGncvFS4rfciq3Z8VCwXovpxSHNZd/1Zfjf3Xxoy84oBZ+iY/WGRMH7Mc19QtbYFg
	oJ1pQ38L+UPMrp9+J5JYWarx3bGigRrt+R+OTnwEMueVZBVj3rl07sW9aWDepSiddJ26R7/qO68
	xFAe6I0M1vJU131zOtPmxnxZF43yn1LakClv2fAEqBUSrXVVUWXUhR74hBfuXXjLyPr97ZTs4QY
	Q62lXacehvLLuzQRpwPQo8WJXp0TsHClIz3GhL8YnKjez4wESJbGYagyqilJn53uVkus5whyG9O
	6b9GP7yGZpXr9MFDZdtEDDig918E2XVG8+OMGB/E+lWxmWLmN72w+KpkOZvD
X-Google-Smtp-Source: AGHT+IGj17zEPCJE5k/7tAvGPZbSPIFM4H4/9dExqXywN2nx7iL9LUcnSdV7P7vvnmjFDZ5Y7okCulPyPhag9YqyYNA=
X-Received: by 2002:a17:903:46c8:b0:27e:e77f:57f3 with SMTP id
 d9443c01a7336-290c9cb613bmr254571115ad.14.1761120616580; Wed, 22 Oct 2025
 01:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
 <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
 <aPIPGeWo8gtxVxQX@yuki.lan> <qveta77u5ruaq4byjn32y3vj2s2nz6qvsgixg5w5ensxqsyjkj@nx4mgl7x7o6o>
 <20251021-wollust-biografie-c4d97486c587@brauner> <lguqncbotw2cu2nfaf6hwgip6wtrmeg2azvyeht7l56itlomy5@uccupuql3let>
 <20251022075134.GA463176@pevik>
In-Reply-To: <20251022075134.GA463176@pevik>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 22 Oct 2025 13:40:04 +0530
X-Gm-Features: AS18NWBdzsxWz_QgzGvsSbF_tbzntKvd82uq9r2HYtjdHCUwx0XlbeuUCqIBmDg
Message-ID: <CA+G9fYssAU52bWwMiQ4GiRjroWJYgA+CvEFekq6mnkd+9Z-Vng@mail.gmail.com>
Subject: Re: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL: ioctl(pidfd,
 PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL: ENOTTY (25)
To: Petr Vorel <pvorel@suse.cz>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Cyril Hrubis <chrubis@suse.cz>, 
	open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	LTP List <ltp@lists.linux.it>, Andrey Albershteyn <aalbersh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 13:21, Petr Vorel <pvorel@suse.cz> wrote:
>
> > On Tue 21-10-25 15:21:08, Christian Brauner wrote:
> > > On Fri, Oct 17, 2025 at 02:43:14PM +0200, Jan Kara wrote:
> > > > On Fri 17-10-25 11:40:41, Cyril Hrubis wrote:
> > > > > Hi!
> > > > > > > ## Test error log
> > > > > > > tst_buffers.c:57: TINFO: Test is using guarded buffers
> > > > > > > tst_test.c:2021: TINFO: LTP version: 20250930
> > > > > > > tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
> > > > > > > @1760657272 aarch64
> > > > > > > tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > > > > > > tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> > > > > > > which might slow the execution
> > > > > > > tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
> > > > > > > ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
> > > > > > > ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
> > > > > > > info_invalid) expected EINVAL: ENOTTY (25)
>
> > > > > Looking closely this is a different problem.
>
> > > > > What we do in the test is that we pass PIDFD_IOCTL_INFO whith invalid
> > > > > size with:
>
> > > > > struct pidfd_info_invalid {
> > > > >         uint32_t dummy;
> > > > > };
>
> > > > > #define PIDFD_GET_INFO_SHORT _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info_invalid)
>
>
> > > > > And we expect to hit:
>
> > > > >         if (usize < PIDFD_INFO_SIZE_VER0)
> > > > >                 return -EINVAL; /* First version, no smaller struct possible */
>
> > > > > in fs/pidfs.c
>
>
> > > > > And apparently the return value was changed in:
>
> > > > > commit 3c17001b21b9f168c957ced9384abe969019b609
> > > > > Author: Christian Brauner <brauner@kernel.org>
> > > > > Date:   Fri Sep 12 13:52:24 2025 +0200
>
> > > > >     pidfs: validate extensible ioctls
>
> > > > >     Validate extensible ioctls stricter than we do now.
>
> > > > >     Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > >     Reviewed-by: Jan Kara <jack@suse.cz>
> > > > >     Signed-off-by: Christian Brauner <brauner@kernel.org>
>
> > > > > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > > > > index edc35522d75c..0a5083b9cce5 100644
> > > > > --- a/fs/pidfs.c
> > > > > +++ b/fs/pidfs.c
> > > > > @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
> > > > >                  * erronously mistook the file descriptor for a pidfd.
> > > > >                  * This is not perfect but will catch most cases.
> > > > >                  */
> > > > > -               return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
> > > > > +               return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
> > > > >         }
>
> > > > >         return false;
>
>
> > > > > So kernel has changed error it returns, if this is a regression or not
> > > > > is for kernel developers to decide.
>
> > > > Yes, it's mostly a question to Christian whether if passed size for
> > > > extensible ioctl is smaller than minimal, we should be returning
> > > > ENOIOCTLCMD or EINVAL. I think EINVAL would make more sense but Christian
> > > > is our "extensible ioctl expert" :).
>
> > > You're asking difficult questions actually. :D
> > > I think it would be completely fine to return EINVAL in this case.
> > > But traditionally ENOTTY has been taken to mean that this is not a
> > > supported ioctl. This translation is done by the VFS layer itself iirc.
>
> > Now the translation is done by VFS, I agree. But in the past (when the LTP
> > test was written) extensible ioctl with too small structure passed the
> > initial checks, only later we found out the data is too short and returned
> > EINVAL for that case. I *think* we are fine with just adjusting the test to
> > accept the new world order but wanted your opinion what are the chances of
> > some real userspace finding the old behavior useful or otherwise depending
> > on it.
>
> +1, thanks! Is it ok just expect any of these two regardless kernel version?
>
> @Naresh Kamboju will you send a patch to LTP ML?

Sure.
I love to send patches to LTP mailing list.

>
> Kind regards,
> Petr
>
> >                                                               Honza

