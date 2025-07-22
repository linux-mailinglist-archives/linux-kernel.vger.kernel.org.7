Return-Path: <linux-kernel+bounces-741386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A0CB0E37B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08441C8359B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D674280CCE;
	Tue, 22 Jul 2025 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbBdjSE3"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9427FD72
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208840; cv=none; b=oG3IZLRxql5TdIVyCuYi9zmkVDw47pqK2zgk8ELv+if8Lbv/UeXX1XTEN1s3/jkOtamEfssG+YXNlESWGc4jpYDAiflksb0tHd15WtvK51PkfcYC+VmSwX4h2nNTDO++LLacyPqsiAi4BZXIVVbXFbO0hxdO+sq3OiGSVkgPlZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208840; c=relaxed/simple;
	bh=TzuX4mInNFL0Y71HlZ/CxdY52DbWevcbHeKa5VEl6b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4EIq0ffAd/u/8NVie1shjlFiwARWiFvxbzR6e91pXDFea6zd/p59rx7jUEkkHZEmHcd+q64Hr2TvqrAOPA9HCA6H4zzo+7my5Cb/XkCk4n3UuqplEHGAiDMA8e34StWg/9hLXYqYm2OZ8+1YNslryZNPNwqqStuJUSwgUIaSF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fbBdjSE3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso4006684f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753208836; x=1753813636; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z8+WxTUCxaG+bKBH/CjfFqMsRzOrc36DXiZRhX8IKQ=;
        b=fbBdjSE3y2GGmYpxw+mlOrzUt9fZZvAVKKg89b6flAay1wOTFChU2s10nR6Php8caf
         vlHE45fOuBxcyRXk2r8uj/u1iaQr+nJWdzaaHS3Zfa59gBMjsQXoN8fC3SrQUbk7K0iv
         LUsM82heCOvhFW98e2iorMsaBuDkpKX3UPSUArRQ/wFmco7VLe7DH1y630oPfWuevjqH
         8QtAKzhQGJ6CfgaEXMCNm4WzxijTZXkgzdlmS1JDSb9M2wzKiLwbEhIavuzwbFi6s2mX
         TftJiA5QcOpfdzWUHPEPRBaixzcYgyDnKa92qHrjTgnV0/UKQkwmWLrh8Uxycwx/aW5o
         uzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208836; x=1753813636;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Z8+WxTUCxaG+bKBH/CjfFqMsRzOrc36DXiZRhX8IKQ=;
        b=uK8zBpH60GSZb/Kl+Bemy6XIeoKa4N7FsYmhPCVVNyKLzjlHbqALlNDDUrvOdF5b3l
         ymZp5IBQfFqIBo4QSc/TYVE32Ym8v+CHF1U8x/4j9PgWBym7pfq8uZrmpH37sIh27Los
         TjwskmvqVB0DqwsKkW/BwdLGHN1F+0gNH0nYgQkh9UuNMuh93mCyZdKCKBKNSsT8kRz6
         XKD7fgZN5O41VOH+cwl9l6gNKIs2rqDvTbmbq60u8cfPNnCGhekdmIhZXuDX2eWqq9iv
         Y57EcfkP1YPnFOU88jIY7GvSWAB39qcH9Hi90cepHkjH3/lVpXYrWBj3vYmLcZwVDDKF
         PB7g==
X-Forwarded-Encrypted: i=1; AJvYcCUsYUwhh2Nx1L3pSCM9O69/yrBbwyHY3DJ4mFxpgWKD6JOVsfsZ6qpZldeKFPI5Lpw1JEgJ9RidiQSfs54=@vger.kernel.org
X-Gm-Message-State: AOJu0YybrqVww8IZ3vfyJjVCmbb9vJCv2NWVv0qowwgepl/XBRSfyNms
	UGrn6RQGF5QwdqNl5Ze5Gdsufuxf3J00R03SBTRJwNvZ5h3AlI1hlugX8hxJuD4Uuw==
X-Gm-Gg: ASbGncvwQsogMl1EiSrTr+/gkE7PbIVWXq6EO4CHOHmu95IIl2zqNsL0W2Zud11Acxn
	0Y3b7lKfDH0luKS284e6O0Wi2Cf/Ei7zqsLSTDkX5kQDuecbgA+k7r/piFNBfyrFcjZ/Pu3TZRQ
	YuY1pomcXqsOpaiiUxL+wTtL9LVZZQSReVApt8DYRib/F0ksISafTY8SLOynaFAUAOuPL30WBjT
	UsnG1Y6bydN12QrqRApGMgmIhRDu67KkB573Ql0mSflAhuGyIuTssDFd4krrybVFc3iRZO52IE+
	eN2kIkfrc8BIl2nEqZT6NqJvRm8gSbaJKFv+HogHBGjbFw5KFoQ5o2rnk5Y2bd7zFvc8Y3S1XvI
	/munAb9cpYyL3YXhpjvJVYxwwZMsXQXP6yYRGiMd4Y6Oh+wMeG+4UOWcYuA==
X-Google-Smtp-Source: AGHT+IHWIMlQSVzvAq85Yom5KJ9BYmsTxVnjI5RbzJDAcwDVZQTDVOTdmdUULBd3ut0q8DI1kuLuUA==
X-Received: by 2002:a05:6000:1885:b0:3a4:f644:95f0 with SMTP id ffacd0b85a97d-3b768f165f7mr219753f8f.54.1753208835850;
        Tue, 22 Jul 2025 11:27:15 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:2834:9:53e1:3729:be19:c80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d807sm14296542f8f.73.2025.07.22.11.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:27:15 -0700 (PDT)
Date: Tue, 22 Jul 2025 20:27:08 +0200
From: Marco Elver <elver@google.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	clang-built-linux <llvm@lists.linux.dev>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: [PATCH 6.12 000/158] 6.12.40-rc1 review
Message-ID: <aH_X_AVUDoP7oB0E@elver.google.com>
References: <20250722134340.596340262@linuxfoundation.org>
 <CA+G9fYu8JY=k-r0hnBRSkQQrFJ1Bz+ShdXNwC1TNeMt0eXaxeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYu8JY=k-r0hnBRSkQQrFJ1Bz+ShdXNwC1TNeMt0eXaxeA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Tue, Jul 22, 2025 at 11:30PM +0530, Naresh Kamboju wrote:
> On Tue, 22 Jul 2025 at 19:27, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.12.40 release.
> > There are 158 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.40-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> With addition to the previous report on the stable-rc 6.15.8-rc1 review
> While building allyesconfig build for arm64 and x86 with the toolchain
> clang-nightly version 22.0.0 the following build warnings / errors
> noticed on the stable-rc 6.12.40-rc1 review.
> 
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Yes
> 
> Build regression: arm64 x86 kcsan_test.c error variable 'dummy' is
> uninitialized when passed as a const pointer argument here
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Build log
> 
> kernel/kcsan/kcsan_test.c:591:41: error: variable 'dummy' is
> uninitialized when passed as a const pointer argument here
> [-Werror,-Wuninitialized-const-pointer]
>   591 |         KCSAN_EXPECT_READ_BARRIER(atomic_read(&dummy), false);
>       |                                                ^~~~~
> 1 error generated.

Thanks for catching this. Newer versions of Clang seem to be getting
smarter. We can silence the warning with the below patch:

From 56c920457a4e7077b83aafb0c9c8105fb98b0158 Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Tue, 22 Jul 2025 20:19:17 +0200
Subject: [PATCH] kcsan/test: Initialize dummy variable

Newer compiler versions rightfully point out:

 kernel/kcsan/kcsan_test.c:591:41: error: variable 'dummy' is
 uninitialized when passed as a const pointer argument here
 [-Werror,-Wuninitialized-const-pointer]
   591 |         KCSAN_EXPECT_READ_BARRIER(atomic_read(&dummy), false);
       |                                                ^~~~~
 1 error generated.

Although this particular test does not care about the value stored in
the dummy atomic variable, let's silence the warning.

Link: https://lkml.kernel.org/r/CA+G9fYu8JY=k-r0hnBRSkQQrFJ1Bz+ShdXNwC1TNeMt0eXaxeA@mail.gmail.com
Fixes: 8bc32b348178 ("kcsan: test: Add test cases for memory barrier instrumentation")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index c2871180edcc..49ab81faaed9 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -533,7 +533,7 @@ static void test_barrier_nothreads(struct kunit *test)
 	struct kcsan_scoped_access *reorder_access = NULL;
 #endif
 	arch_spinlock_t arch_spinlock = __ARCH_SPIN_LOCK_UNLOCKED;
-	atomic_t dummy;
+	atomic_t dummy = ATOMIC_INIT(0);
 
 	KCSAN_TEST_REQUIRES(test, reorder_access != NULL);
 	KCSAN_TEST_REQUIRES(test, IS_ENABLED(CONFIG_SMP));
-- 
2.50.0.727.gbf7dc18ff4-goog

