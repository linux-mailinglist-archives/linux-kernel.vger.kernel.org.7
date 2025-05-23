Return-Path: <linux-kernel+bounces-660904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FE0AC23A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 15:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF5E7AB292
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 13:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4260D291862;
	Fri, 23 May 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c460AcOz"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F5A291157
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748006371; cv=none; b=uho7iNuEuSNmkWuZpkEajmVrwJitNFkeXOjNlGJNthGzfc1RB4jKaWV4X10u7MaTiiBYUCYJ1kEnzCe54CPy/TRX1QkySrV95aEgHx4/Wq7Xk7F8AkwXtSlK8Yg3TvrXPaNv7n6YxjifQtY6ctWluFu7toGYoLwHPJTWcfZAd0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748006371; c=relaxed/simple;
	bh=weVIVWSmAEm0vAps5JJpC+7tazPUvlBdD62+QheOM+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogX0Z+jCvH16Q3uEpsWGc6f1+J1v6r0Pjod8rNc6TyRmatXp5s/F+CFlrC9PDOAA/vJZeLLcbCKAraQpEXouLPw6XrcJloFfLpHS0WBWm+NBpHW8cPXggo4X1YfgQPhBqKcu4/qsa7lpnERmXkmL7GdOEV25Gug3LBsP+l7kMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c460AcOz; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c560c55bc1so884288285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748006369; x=1748611169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wxyrfP33qC8ALCV6TibxZ8ffP3Xham0td5+3H8syoiE=;
        b=c460AcOzuYYjeF+SezJ4YwxXN4T3pHzG3QjtXxx0mrZhn3vDtG6RETrb+0z2F2ijXm
         fEaINOST5DaCgAy0H6cBasspgJx5dysEGjivFdLLciKatewrFde+MiBwXIFp7b1M5aOO
         d4hPNg17kELhhoNAD9I9WCdOyIGYJcBpjI4GgCsr7vLu2GxnXwA6/kiRONd4CGgemk4i
         OXmeb32JRLIVgB2GHytXIlhtLTeQcqoRgXtWhW4DC6I2kAmnE1246tjdzFK7eN5F+VsK
         2as8pS/x+lkmIS2l+7MzjK7RWEljvm+kvB0hDfOg3lqA89rXO1q9tHaUBVLkQmjSpv2t
         y84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748006369; x=1748611169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxyrfP33qC8ALCV6TibxZ8ffP3Xham0td5+3H8syoiE=;
        b=K5VGB9e51mgVmFN93xBMui3TqVR4N66ww+YuxawIDdcVCQwhtHN/OMxIBX/Rtip8st
         r2F05Wet838Mc9b+wlbppm3Iz92PtKwjeTVVe1XBK6yE6VbTjZ2JfDYP8VAvujiZ93II
         RKe7qg7Q4pR/ppSKDP6DvQ0vLIJRMGCUVPPcVC6HwM5+TjmPrNKIiouyyUATwzQtySjI
         NUkY/mg0+aWYY9/hb/uHxb2dFx7FFxN0g6dPRIuq46P1fsYqvUeXMPlKBj96Pb6Cwb5R
         8cgEZVFNwsBcjK0JQEl5QJX+ywPWbNiV2zGdk7rkU1YPNcjNiDhTbZPaq6s1I1U6vn/a
         +Ung==
X-Forwarded-Encrypted: i=1; AJvYcCViKA/72HIwSAgU01OGiIcqn+OkR8pLJyh92J7CC34jUpr5+OWLo5dPU5JmNzmXHyhVnQgse8dAr6shXJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXaxm55WapC3ZY0oYX9+7YzUgeHhrbhyo562rngSzGGgs6z2y
	wTy/FrDIC787tz+eXpzLFXwMhbzeuM7aFdjKGezNLe8Txx6jYYc8Qts4hsXBPzNr/h5tL718kxL
	bUDYa610ZqAPZbK3oU1TeEQYHLbv3tvUcf3zoIxK8eg==
X-Gm-Gg: ASbGncs4c3ubVx+zRrZ5cR7q5luIOv/Sa+wdbhDP32c0pkoBK5V+1wf1BAOIf4/8Omc
	MMWypZPQZInm4YL/+87VlCXv4sZ8MbIGWcIj4/a8xuyYUbk5Sin8Q1oCxvRumca1V9WHXUKZ7rC
	EjsTioVuBZe5pFzmHq45Ox3NbHUAkA39qe+NDOuMENwjDzDBp6gQHzTuwSLLEP6uBsyvm0A6Tw/
	w==
X-Google-Smtp-Source: AGHT+IHyjvNAAtHNM58ZIM56gNpC2I5XziXsRadQQZ+dhZZ3rU8qNnJxcPg4bPBm0zEL2RJNey22Zg6GikdUy4Olj2Y=
X-Received: by 2002:a05:620a:400c:b0:7c0:c332:1cdb with SMTP id
 af79cd13be357-7cd4677d30dmr4029786585a.38.1748006368879; Fri, 23 May 2025
 06:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv08Rbg4f8ZyoZC9qseKdRygy8y86qFvts5D=BoJg888g@mail.gmail.com>
 <6tgxbull5sqlxbpiw3jafxtio2a3kc53yh27td4g2otb6kae5t@lr6wjawp6vfa>
In-Reply-To: <6tgxbull5sqlxbpiw3jafxtio2a3kc53yh27td4g2otb6kae5t@lr6wjawp6vfa>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 23 May 2025 18:49:17 +0530
X-Gm-Features: AX0GCFv47L9zNz_HqH7izio-QcYYMfFmCuTMugR2i0Gz9XAi2gWfyAbx-zg4GTQ
Message-ID: <CA+G9fYsjBXvm9NNKRbVo_7heX1537K8yOjH7OaSEQhGRmkLvgA@mail.gmail.com>
Subject: Re: riscv gcc-13 allyesconfig error the frame size of 2064 bytes is
 larger than 2048 bytes [-Werror=frame-larger-than=]
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcache@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 May 2025 at 22:18, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> On Thu, May 22, 2025 at 06:59:53PM +0530, Naresh Kamboju wrote:
> > Regressions on riscv allyesconfig build failed with gcc-13 on the Linux next
> > tag next-20250516 and next-20250522.
> >
> > First seen on the next-20250516
> >  Good: next-20250515
> >  Bad:  next-20250516
> >
> > Regressions found on riscv:
> >  - build/gcc-13-allyesconfig
> >
> > Regression Analysis:
> >  - New regression? Yes
> >  - Reproducible? Yes
> >
> > Build regression: riscv gcc-13 allyesconfig error the frame size of
> > 2064 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>
> Is this a kmsan build? kmsan seems to inflate stack usage by quite a
> lot.

This is allyesconfig build which has KASAN builds.

CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
CONFIG_KASAN_KUNIT_TEST=y
CONFIG_KASAN_EXTRA_INFO=y

- Naresh

