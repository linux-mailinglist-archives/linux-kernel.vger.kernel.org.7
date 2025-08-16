Return-Path: <linux-kernel+bounces-771650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E51B28A0C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20746189D69D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCD61537A7;
	Sat, 16 Aug 2025 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fKJ/Q+i5"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6CA849C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755311035; cv=none; b=I9DR/XhBjzfvXskSIroA7M6j7GSeLUJGgGQ97VUXhvd95ETISfyxztYAyoqBIyGHW31kUoRZGGYwj5rg/tPo+ALgX6PztdbnGjyY2KWEC8fhLgQGcxE2wh+cxw3jJbE1Z5MY7uDi65w8HL+e8LuFYxibCMBdqwQZ66YNyoDiDXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755311035; c=relaxed/simple;
	bh=vd1Q/iIvN6B7dlNO1TEjjPKytmNby3nU3JdmU9OkYzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXSERUcoRVBWbEhsckqgOjPLVI1noypjyyh6aqOTmF0426oK7eFhv7jqmNc76EFGt0DlaOa9FoS94p2KGQMIw6Wd+AXaSTEtWp3jip+fRaBL0t7xhSehBnfgrNZUs+/hyTOnNQDAyODjKpRbXQDS8+Fyq6eFHOKu8G4mv9Tbprs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fKJ/Q+i5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24457fe9704so19782985ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755311034; x=1755915834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMrJZFZ4o+9OD1KNbPbn15xKcbrAR+qjukG3QxeAoyk=;
        b=fKJ/Q+i562nBgBbSATYlmUJzOTujyCX715ccR7Eg+q6UE/Xo21FmaErka5bqmnq6sC
         lpL0RPdVuGPVrGoHAA5JiAnCTg7SFQv/iYnjb/RLT5LG5UTAzNTUe0cdRgSKqbuPz1fE
         MYIetIXcWZgJDTOeJ15FaTvcQx2rKiOBqPGVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755311034; x=1755915834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMrJZFZ4o+9OD1KNbPbn15xKcbrAR+qjukG3QxeAoyk=;
        b=vjgS8Kg7hX4n5M/UHUz+dDW6nz2xEQO/JjrGcfMnshXU5n7wyZ+nclk54TlON4rVJ0
         7Fhm9FdQ74kICIvPAbDJQ4ScyU8v7b5zvN3O7BAQ4t4CvwGHzu9sAFKNUUuS25Hkq4o6
         TnPzbP3/enahhvClBOjxq/EQqfYdqRM7oYQ3PKNrJM82xF3nV9xzoM1kx05bXcNmiUXC
         A4cQmtvYing4OpqGPwvSlZDbIUQDYCAoUBknyMlCRvjFOj8zGLyq5Gn9FdaMzR+OER12
         3mxKRQzJXliMUOfXulAyMHrJqyCgPeYi8oSFjs6gvVHj3pVZQcufPSk3ZnXpDlMa47rA
         xnwA==
X-Forwarded-Encrypted: i=1; AJvYcCUavo4FGX1Jy/zT63rkd5WO0tFPUaMK+OoA5Xm53pxPI7rCB+0rUAjF3zV2qAtcQg386087tfjChqVCPMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4g3kHKcDPZk5M6SgwIh8yKpaFkvjarr9C7Myv0Of+xhE3oqNj
	lFgh84virXen+s4ZQaO5kWTP6sCpXX57fjTfIzPDXL5KNr6khIDm/VrBxsCRxwvqcUfGNVWjKln
	i8UY=
X-Gm-Gg: ASbGnctK/2fIOVx6Pg/aZSNCP6UcEFQTQgqV3d7KsljeD8GHwIj9h6cmkIakKsKP7pc
	MJTUD/j3tfln4kfoqDekOQ8L0wpA+Ga16iRJsbSvXhe1BuAkv/2hPKRR/ZxURVFetgyTiagETb2
	jhjHc3MszWtG6TtI5JnGrufcxvD7nWgLAe4e2dqZ2hAdY1l5vPUDGj5AtyfLy7CF05PwMs3ihyE
	dphs3I1TwhIM9Kvc2N771Tf99Pr9wvSdVtcjyGujdD0FPTrIcPHgtqpTiLiHHYQuxZQhm3dgZyZ
	NWXVBhpY2nUdz2NsxMJaW1xFq8ks3FHIZKyM/00LwA2febBuYo/eijLh1i3ubz7etOln2cqli74
	AjINPVY4Jnde7zzLPQP3DpOaGEoH6cBzvXPr7ITE2BFzCZnR7NeVXvS4gMADO
X-Google-Smtp-Source: AGHT+IFxFyvLRlvI//+N2amY4eKcFJIHNjTGuk8Up1imrlzzmHPsU7HrzAw6S8zG0dbR7sK+B7C2oA==
X-Received: by 2002:a17:903:2f82:b0:244:6c39:3383 with SMTP id d9443c01a7336-2446d709449mr54558145ad.21.1755311033583;
        Fri, 15 Aug 2025 19:23:53 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:eaff:25b5:2a27:51d9])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32330da89d5sm5454374a91.0.2025.08.15.19.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 19:23:52 -0700 (PDT)
Date: Fri, 15 Aug 2025 19:23:51 -0700
From: Brian Norris <briannorris@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Tsai Sung-Fu <danielsftsai@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] genirq: Add kunit tests for depth counts
Message-ID: <aJ_rt6AORXs6RTGI@google.com>
References: <20250522210837.4135244-1-briannorris@chromium.org>
 <ded44edf-eeb7-420c-b8a8-d6543b955e6e@roeck-us.net>
 <aJ91RRsMB-duD2yR@google.com>
 <fc42ed34-e87d-4868-94bb-30554a3f6ec4@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc42ed34-e87d-4868-94bb-30554a3f6ec4@roeck-us.net>

On Fri, Aug 15, 2025 at 05:24:24PM -0700, Guenter Roeck wrote:
> I can try, but the irq test code fails for me all over the place, so I am
> not sure if it is worth it.
> 
> From my current upstream test results (6.17-rc1):
> 
> Build results:
> 	total: 162 pass: 162 fail: 0
> Qemu test results:
> 	total: 637 pass: 637 fail: 0
> Unit test results:
> 	pass: 640017 fail: 649
> 
> The failures are all from the irq test code. I didn't have time to analyze it.
> You can find details at https://kerneltests.org/builders in the "master" column
> if you have time.

I can't replicate all of those easily, since I don't have tooling ready
for some of the more esoteric architectures. But many of those look like
they boil down to a single oversight: that some architectures default to
IRQ_NOREQUEST, and so I need to throw this onto the fake IRQs I set up:

	irq_settings_clr_norequest(desc);

With that, I can pass on ARCH=arm:

  tools/testing/kunit/kunit.py run 'irq_test_cases*' --arch arm \
      --qemu_args '-smp 2' --cross_compile arm-linux-gnueabi-

I'm less sure about the ARCH=parisc{,64} ones, but I think that boils
down to missing CONFIG_SPARSE_IRQ. I think I can skip tests in the
!SPARSE_IRQ case.

> Note that "imply SMP" does not make SMP mandatory. I can still disable it after
> enabling IRQ_KUNIT_TEST on x86.

Right, that's intentional. There are a few CONFIG_SMP-conditional bits
in the tests, since many users likely run on ARCH=um, which does not
have an SMP build.

> Frankly I don't really understand what "imply"
> is supposed to be useful for.

Documentation/kbuild/kconfig-language.rst calls it a "weak reverse
dependency" (i.e., a weak "select") and:

  This is useful e.g. with multiple drivers that want to indicate their
  ability to hook into a secondary subsystem while allowing the user to
  configure that subsystem out without also having to unset these drivers.

Basically, I want SMP when it's available, but I don't want to force it
when not. And it means on KUNIT_ALL_TESTS builds that otherwise didn't
make an opinionated choice for CONFIG_SMP, we get CONFIG_SMP=y. The
latter point is relevant to tools/testing/kunit/kunit.py.

I have a patch series to clean up a little while fixing the errors
you've pointed me at. I'll probably send it out next week.

Thanks,
Brian

