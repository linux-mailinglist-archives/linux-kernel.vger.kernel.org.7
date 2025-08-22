Return-Path: <linux-kernel+bounces-782599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D628B32292
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C8F5814BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697E72D1F64;
	Fri, 22 Aug 2025 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NsPKLLKW"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9C2D12EE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889317; cv=none; b=E3SLyes87Q/VXULjszPLkJtD+OYhGhOnx0Xb0ALWCAosPI8Jus/UrBhc2mGa4hCpffTuxktROHkd7XElN93P+ZRd0x8Xji1Fjqb/fR9JDAXZLbzuRorpDDi7k2s85mW4e6RRUezweCOBRC8FPTv5ENy0Bnq00t0kidX1hkmJgzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889317; c=relaxed/simple;
	bh=F6CyFhck5m8cKEPXXRbIJbXQPp2uCDn9sqFms57kv6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpyvRCdbCGnFqYb8TE1TCUs4Pq53+N2H7Stk0edZRFdRvAOyLB7Xh3C+hM3y5gryX9oPcUggbytPVWkNUAAmEHgqu2L7zVjGYk1FIY2bVNZHc6CP806m9KPYdwIEDCPPvbVymrdX17rvalhLkSDOfbDvP3EqgOoRq/RCvXpgADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NsPKLLKW; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso2843259b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755889315; x=1756494115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qRfJ1efwUt5qzWhi/EksrwXOERx/hksi00iK1a2Is0=;
        b=NsPKLLKW9A9BeXy7JJeLoIg0ypeA1T44gktEsHtDMCp1zCer9zEMjHXNPkzcbTI68l
         MXpgClGCAI61FZ+7tDSea19X8cq7ZratyClDgmQynNmf1bGYzr6HwvKkmaKoJ9eNX22a
         DsKJMMxzCMloR4lRgsKnZdNuMgf2ZKCWM3XAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889315; x=1756494115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qRfJ1efwUt5qzWhi/EksrwXOERx/hksi00iK1a2Is0=;
        b=i7gCqiK/INkT68L7DNT/ZD627baL1G3kFcwQvHeRkBX8cvtzqenMXbaF69KrDjEp3W
         nEivHgCTUXwriA7K28ljUrGCFgAUbjO4MyeDHzznEJthz4WhFj9X4dTVLC31apCsJUNx
         GDLCdpisk+A/PBK0Cor0+eLVWdSHBS/HhRVTiO387red7YfVfc4EF5ATAT2RJ39x4q4b
         QnVm5HlYxLJEtqbU2EyX4v876g9tl/ztcXgSLKtk4FsOJ0faRxQTHS4wdhd78k4UwGby
         8RdPX3uu3FGY+J+6vNDPVvSoGEKc4ESaF5OfzRRtveM2OBZkpggE0P5JHMFWlzmgIkqc
         X8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFzM/DmH4q8V5wSAz0BRDzDYHr0pAykHBxCuZM7/3FD0H1+xeDsLQ14e0+q8eXhWFZ6cjrE9DmVeO0EsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf7muPF8z83hunOlA4Lprts2ZvRSERJKoZLh1szYWC28Qp+gGr
	S9c4CCO8eT8sLIvOy2XJZ1hKn1UtF1b+TkoHsq2WVJnNpqtbrdWwzQ++n62Q7K5zMA==
X-Gm-Gg: ASbGncsJ5zxuqGVZHCzMkUGCD7G5ywkgoUOFO8GVUVT3RcUi2djlmin/ljA5GdH3rk0
	fzM7xPVr3nrc2Dc+CU1U/B8LX5RtemlwkNu9hhyazAtl3J9bk2UDDKOom90qUhB0UcsQgV6F8HH
	hfnfd9FUUrILeukFNFeqR8sYVhaEsw9rSeHIU+sQr/441mv2oQ9Mv+tm6/LdOC/KzjtoIrgrviA
	YhDw4FF3e31hHbEkJvN8kGz6uuETEMj+dJ8r7WQel6cIjv7h0EuhoniW2Sf1OrqFdVxghHCpH3B
	aJTQgV4NuON8BnnBtPBnhWevXmjZa7aVk1i7DAJ+VhLP2hXDOBMn0qF0xBQopzB13n8/dzNHW/h
	FtAI2XLoRoxAjZzEqCzKvl8XX/cycMJ8pjrrJ6BafUkzWIx2vBdD7ZMftc1Iy+2cO2KrfCw==
X-Google-Smtp-Source: AGHT+IERU1thLXYMzICfViuGk8kImPkUJS7xK6VrYeodDoNR/f9WswSi/cDfGBjhN7V5j2ahaOqNhQ==
X-Received: by 2002:a05:6a00:2309:b0:76e:99ff:c9f7 with SMTP id d2e1a72fcca58-7702fc0267bmr5221220b3a.22.1755889315318;
        Fri, 22 Aug 2025 12:01:55 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:154c:8cf:f7d0:c083])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7703ffb48a0sm617048b3a.8.2025.08.22.12.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 12:01:54 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:01:53 -0700
From: Brian Norris <briannorris@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 0/6] genirq/test: Platform/architecture fixes
Message-ID: <aKi-oXTf0RphLLgn@google.com>
References: <20250818192800.621408-1-briannorris@chromium.org>
 <9bfdbbed-52c1-4c5d-bdc3-963a902f2b4b@roeck-us.net>
 <aKduHcYINJvMsB58@google.com>
 <2143e074-c82f-4f38-84c7-6a39c6c6ecd3@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2143e074-c82f-4f38-84c7-6a39c6c6ecd3@roeck-us.net>

On Fri, Aug 22, 2025 at 11:34:04AM -0700, Guenter Roeck wrote:
> On 8/21/25 12:06, Brian Norris wrote:
> > On Thu, Aug 21, 2025 at 10:02:52AM -0700, Guenter Roeck wrote:
> > > Build results:
> > > 	total: 162 pass: 162 fail: 0
> > > Qemu test results:
> > > 	total: 637 pass: 637 fail: 0
> > > Unit test results:
> > > 	pass: 640616 fail: 13
> > > Failed unit tests:
> > > 	arm64:imx8mp-evk:irq_cpuhotplug_test
> > > 	arm64:imx8mp-evk:irq_test_cases
> > > 	m68k:q800:irq_test_cases
> > > 	m68k:virt:irq_test_cases
> > > 
> > > Individual failures:
> > > 
> > > [   32.613761]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:210
> > > [   32.613761]     Expected remove_cpu(1) == 0, but
> > > [   32.613761]         remove_cpu(1) == -16 (0xfffffffffffffff0)
> > > [   32.621522]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:212
> > > [   32.621522]     Expected add_cpu(1) == 0, but
> > > [   32.621522]         add_cpu(1) == 1 (0x1)
> > > [   32.630930]     # irq_cpuhotplug_test: pass:0 fail:1 skip:0 total:1
> > 
> > I managed to get an imx8mp-evk setup running (both little and big
> > endian) and couldn't reproduce. But I'm guessing based on the logs that
> > we're racing with pci_call_probe(), which disables CPU hotplug
> > (cpu_hotplug_disable()) for its duration.
> > 
> > I'm not sure how to handle that.
> > 
> > 1. I could just SKIP the test on EBUSY. But that'd make for flaky test
> >     coverage.
> > 2. Expose some method to block cpu_hotplug_disable() users temporarily.
> > 3. Stop trying to do CPU hotplug in a unit test. (It's bordering on
> >     "integration test"; but it's still useful IMO...)
> > 4. Add an EBUSY retry loop? Or some other similar polling (if we had,
> >     say, a cpu_hotplug_disabled() API).

Ah, I see that add_cpu() (cpu_subsys_online()) already has an -EBUSY
retry loop, but remove_cpu() doesn't. So #4 seems like a good solution.
It might even make sense to retry in cpu_subsys_offline(), rather than
just in the test.

I'll give this some thought for later though.

> Here is an additional data point: It only happens with big endian tests.
> This always happens in my setup, and it only happens when booting from
> virtio-pci but not when booting from other devices.
> 
> I just re-ran the test and it passed this time, so this is apparently
> a flake. I'd suggest to ignore it for now. If I see it again and find
> a clean way to reproduce it we can have another look. The emulated PCIe
> controller for imx8mp-evk isn't exactly stable, so this may just be a side
> effect of emulation problems.

This furthers my suspicion that it's a race with PCIe probing. On the
failure case, the test is running right after some PCI scan logs.

But I'm fine deferring for now, since it's not very reproducible.

Brian

