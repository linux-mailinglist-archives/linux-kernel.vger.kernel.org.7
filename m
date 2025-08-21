Return-Path: <linux-kernel+bounces-780488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D24B30296
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215E81687D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA1A3451CA;
	Thu, 21 Aug 2025 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J//ZAsAF"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5966BFCE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803169; cv=none; b=VAS0zx4wNoSUgTiozDbJ7e8ePBWNmT/M7cV68t5v+O8/ynyPgZtnaeN6GhwWbkzvM00rS0xgqeunS5YK0bYMTtpNig4LulTBryZtLKik/a2qpaKoAnpXaEy0+rJUJFJBUg+bZD+FxjDdoD1kI+rTDVYq28t5CPX7GQOnUooRcy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803169; c=relaxed/simple;
	bh=eQboAEdW3GP0UsWJ6wLqypGdhjyydMqiRTTtfxIQS/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV4ceZi/kEcrTNmlKIQEV25TMscLCziUZDDwH/SH4lfjtGI1WSqc0NuiWEiTIy+sYG1IinywxALSy0fiiJ9rvn/54kVrMnxXSjOEKc0e2CxqyrbP1KaJymFw7GXzf65iLsRcaBPH71i3W08pGIerKL1rYjvUfHcvmrIwHdl4c8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J//ZAsAF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2461864f7f8so7190085ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755803167; x=1756407967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxsvEUMFGy/v82rYSnGk6exH77wEMtBZDuoJFnE1xEQ=;
        b=J//ZAsAFRULRJFEdUZIQ8FbmiNAOYsVhVz7RefbV5mnaEJn+Z7E9GuhelDGvt1vZyY
         axaxH7marYndxYipo1dWKag1Z4nGZdTG/xhJPN6kLZV+/BTwpVA2KtcttacFFSenjLhu
         pnu5iotEJ9mZfWBFTZwEtNAF7TEPvYoUStZcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755803167; x=1756407967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxsvEUMFGy/v82rYSnGk6exH77wEMtBZDuoJFnE1xEQ=;
        b=DdUpIEokQBGnx1BuY2g6RxdZyeLlT9d0tep5XvrBNO9QX8yWxEC5LuL7DFb4IH+P3E
         XeKO5jxZl+R438C7fE0ciAOZTciVYTu9b8n18h2EmtdDcsPgla/xsXhBASt7SkwVbn/o
         zOh1PyPTA4SzoFAWBkNvdW9ggGjVX15nH6uxon1l5XChppgyd0U6T3IBHYTswIzEM9nk
         OWsiD8macXPwfCXKxBNw/2bc/8OF6Md9hsNpJZ/FPoqToD1HOi5AZLOUpef1YonOKhgC
         E+o2UdU5tufixXXM+0snan5xXyXU318xb7kgYuFwUEXMEEY1zHzYuvgDwUVebU9SThT8
         ibMw==
X-Forwarded-Encrypted: i=1; AJvYcCUA6ONUpV73yvwxo8YYMBboADlB9Uh/yPhq/In7ER7GoEKSjSIZxwz5yAj6YKbFY+cG1Bf8Frt/YWF5SPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoSkPYk7ezkNbnsBnlpcdS98EJmHPbFN4uuCThF1smYebTfW2w
	DZmhVEm8VESbE25h5m5rR/rCQLKLBPFNedyq0mET4F0GdJfUDu+cRSe1AYLMhsWXKQ==
X-Gm-Gg: ASbGncsddNnzmKCPAX6fwFrX82OXblsMhzSA+sL92YjyrNY+6eF9TcI5NFa9xSm+ypO
	CHHuZrCZWjiBpH3Q51VXqZ9mVD9qpkcljCcjufo+MKtsZzfEDiag/QZi4fybAEysL4vX+DRvt8A
	KyIVGG5h5yvh16oPGmmbDIs5OIYVoElRt2bz7opjNrI34c8Xoly8clKT9NadAO4Omo2QT9RW6vz
	uOvzCptWaFvlj82cgmwaGtxENRlFfSd/SByXH8uYIVbIjBYD34S+TiRI+P21RHKLNFXG1ROeb2D
	FSqDbXL008qtnSgXS300m6JTuYudY/OvFTMrclWmnlQr+Sy3s2/6WihnQnvaNyjAjkPpHdWQMtp
	SUrapZfyKepal7ismV5S1xY8RAWk7MXy8C7UFQdC2dYvvSqnzW+fqWcVxQVU=
X-Google-Smtp-Source: AGHT+IFR2YUNw+owi6gGEBlDhbVRJTq+TxDRUNoS4xfuvyHBscMVivl4ILY8GrORQ5HbNAI2hrQbkw==
X-Received: by 2002:a17:902:fc44:b0:242:9bbc:6018 with SMTP id d9443c01a7336-2462efbdbddmr6386045ad.56.1755803167301;
        Thu, 21 Aug 2025 12:06:07 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:b2e:6a56:979c:1912])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2463604af38sm567935ad.17.2025.08.21.12.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 12:06:06 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:06:05 -0700
From: Brian Norris <briannorris@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 0/6] genirq/test: Platform/architecture fixes
Message-ID: <aKduHcYINJvMsB58@google.com>
References: <20250818192800.621408-1-briannorris@chromium.org>
 <9bfdbbed-52c1-4c5d-bdc3-963a902f2b4b@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bfdbbed-52c1-4c5d-bdc3-963a902f2b4b@roeck-us.net>

On Thu, Aug 21, 2025 at 10:02:52AM -0700, Guenter Roeck wrote:
> Build results:
> 	total: 162 pass: 162 fail: 0
> Qemu test results:
> 	total: 637 pass: 637 fail: 0
> Unit test results:
> 	pass: 640616 fail: 13
> Failed unit tests:
> 	arm64:imx8mp-evk:irq_cpuhotplug_test
> 	arm64:imx8mp-evk:irq_test_cases
> 	m68k:q800:irq_test_cases
> 	m68k:virt:irq_test_cases
> 
> Individual failures:
> 
> [   32.613761]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:210
> [   32.613761]     Expected remove_cpu(1) == 0, but
> [   32.613761]         remove_cpu(1) == -16 (0xfffffffffffffff0)
> [   32.621522]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:212
> [   32.621522]     Expected add_cpu(1) == 0, but
> [   32.621522]         add_cpu(1) == 1 (0x1)
> [   32.630930]     # irq_cpuhotplug_test: pass:0 fail:1 skip:0 total:1

I managed to get an imx8mp-evk setup running (both little and big
endian) and couldn't reproduce. But I'm guessing based on the logs that
we're racing with pci_call_probe(), which disables CPU hotplug
(cpu_hotplug_disable()) for its duration.

I'm not sure how to handle that.

1. I could just SKIP the test on EBUSY. But that'd make for flaky test
   coverage.
2. Expose some method to block cpu_hotplug_disable() users temporarily.
3. Stop trying to do CPU hotplug in a unit test. (It's bordering on
   "integration test"; but it's still useful IMO...)
4. Add an EBUSY retry loop? Or some other similar polling (if we had,
   say, a cpu_hotplug_disabled() API).

>     # irq_disable_depth_test: ASSERTION FAILED at kernel/irq/irq_test.c:53
>     Expected virq >= 0, but
>         virq == -12 (0xfffffffffffffff4)
>     # irq_disable_depth_test: pass:0 fail:1 skip:0 total:1
>     not ok 1 irq_disable_depth_test
>     # irq_free_disabled_test: ASSERTION FAILED at kernel/irq/irq_test.c:53
>     Expected virq >= 0, but
>         virq == -12 (0xfffffffffffffff4)
>     # irq_free_disabled_test: pass:0 fail:1 skip:0 total:1

We've discussed this one, and I have a fix (depends on SPARSE_IRQ).

Brian

