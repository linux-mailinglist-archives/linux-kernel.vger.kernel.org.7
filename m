Return-Path: <linux-kernel+bounces-780342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816E2B300B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B28722A83
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D9B2FB627;
	Thu, 21 Aug 2025 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1VY9dPK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900272E3AF0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795777; cv=none; b=RztxCCkEk97acdWVxY5hHEkCohVNEQw4+CqRU8B6w48PreFc2jTVFDGEOulzKvjtGlcVh8wkmjIffzfYrkc8PV9vQoHf5CU+UJHbmKySOWkXJfBrgF7eOCZWYjgVucziC/mB3rgS5NpXIrH6JZPwFY+1HlDjV/SxEL4EaBm+FVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795777; c=relaxed/simple;
	bh=h0EZR8ymfTHTE0MTKn/TRxutdQMFLi9NI5bR3iBi8cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP9m2BKOexeLk8FlYDayfFbT+q92K1fK4pvghd8uSjva5hIu9NOv1Z5tiMFPGZgnLyU2TIxIlRBUKSu/7uq+ki3BVVSPM2O+QNWYIVTBV9y+O6Z2pMPcFYtz+rU4H23mCxOap0f+pbeQhB+Wz5Ck4WVdnWlAoumzYBfXs0HZm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1VY9dPK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2eb4a171so1637157b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755795775; x=1756400575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgIQBgS3fjg4s44LcelsoWTbnYReQOHJSAQj8iHaBjI=;
        b=I1VY9dPKOUeZhJNQVes1JjXRNXjo/GJ9mvg+hHouab/9fO4xt+libZjn8SJYBFFBvV
         bPA28s3v7errjsethBc07tMd5Jz7JY1dlBswRhv8isA3Y5JccxGjtj1bXL1OztrSlOB+
         AdfjxBVCtDcjHBq7GjGL7p0KdgSDHHiQsjPKjo8B27cXZ/RyMOUOzYE+mNQQnY1zB+FN
         JU42cwvveD3dlTMWv/DMsq8PkSjV3DUc5t9wnMX+zwcuVQmeraZfotSGU2d6+VqsIpxE
         3x9zELtqXkvnhc73U2Y8KR+8Ri39Kg0Ydo4TkXEng0yUHdd0SdRYi6gWDVHMZUu+yfr7
         wOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755795775; x=1756400575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgIQBgS3fjg4s44LcelsoWTbnYReQOHJSAQj8iHaBjI=;
        b=Z091QfjLukCD3MmSfELEYjJOl7/20qkiyvp3481b1k/71tLV9rNaz8qqH2+eTbUVIS
         bAZ7gnzBhoDIQqIPsp21q9pl/WxvbfeB1MGHucUBRPc2/wn6mlVWXhPJM6NGXcozNJJh
         cbxQoSwLLBMMz7Y4zBgVeHYTJy9zAHYM3odYFYYDqOeO1QJRH5jRCstXud65fLYUrYde
         vkxjqFwQxvLVq4yMxKeAhDWdTizJn8vqHeQIJQJqNRShOe02sMGXJCG5EMZSKqROI7Mx
         IgJDhatyYycwjKJdZAVw/s6Mw7Q3kjMuAQ1zbm1ktWWVppt2PrJnFoVZ6Lpat5iFPWmg
         jO8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrbcPTtxYXqZ+yxgEx3pBT2OGk+rwl0f24fKeNIqpoWHxYpEVd6EuLW0NgHWRVUbVNVUnC8Pt+9Zdb4rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUawgO5Pg3z3p0fXNX4bNlueapt8Z/u6MrUeQ4oYfXN+3In/V9
	DB25my7TbqBYn0qHl27qZA75tNMyH1iw7gBv74cNHEzBDRuX+oWnWdGQ
X-Gm-Gg: ASbGncuptBJz4+PmnGqFf4Fsu71QgILxbWmkLymdOpSN/q4m86SFallP8LvbvJea+mQ
	zatzVpRK879CY1kk8ywSIIcD6Tt9kc7lj7GWsjGn9m9TAQ+CHq20mfHur2N+U0VtHgXwokZgIxh
	xTfEc2kLh2u044BWA1eZfs5YiZwhLQEXhAnbTeZ03lKxl/Amb82fM/qvmQ/hsgX3Vq+yAwQwjSM
	aoeeZ/WHW0gGsbyeaRtPOgXBpzyr/vnKaRJDkarYGx4IvPSSOINf89Z+93Mkb2p4xFCkTXlMP4S
	vwSdBjqu3vHC7dJNQYNs4JFGjL56bPLreRHCO9gmlMklUYvVnFUz5Qle5TLBz82N1+Pv1+7tPNW
	ONUvq51IcZzFU+qEOVISRX6o9+UAFiaxKinSINr9qJOHoAw==
X-Google-Smtp-Source: AGHT+IGUoRF6zWheyc8PbSi9qBR3P7QnDyPnk5ZEDyD8G4EFC8xTjpjy6yerDDOGMcO/a9cNl/kHjw==
X-Received: by 2002:a05:6a20:4322:b0:243:15b9:7655 with SMTP id adf61e73a8af0-24330af0eebmr4266782637.47.1755795774604;
        Thu, 21 Aug 2025 10:02:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e8ea037e4sm5454656b3a.31.2025.08.21.10.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 10:02:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 21 Aug 2025 10:02:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 0/6] genirq/test: Platform/architecture fixes
Message-ID: <9bfdbbed-52c1-4c5d-bdc3-963a902f2b4b@roeck-us.net>
References: <20250818192800.621408-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818192800.621408-1-briannorris@chromium.org>

On Mon, Aug 18, 2025 at 12:27:37PM -0700, Brian Norris wrote:
> The new kunit tests at kernel/irq/irq_test.c were primarily tested on
> x86_64, with QEMU and with ARCH=um builds. Naturally, there are other
> architectures that throw complications in the mix, with various CPU
> hotplug and IRQ implementation choices.
> 
> Guenter has been dutifully noticing and reporting these errors, in
> places like:
> https://lore.kernel.org/all/b4cf04ea-d398-473f-bf11-d36643aa50dd@roeck-us.net/
> 
> I hope I've addressed all the failures, but it's hard to tell when I
> don't have cross-compilers and QEMU setups for all of these
> architectures.
> 
> I've tested what I could on arm, powerpc, x86_64, and um ARCH.
> 
> This series is based on David's patch for these tests:
> 
> [PATCH] genirq/test: Fix depth tests on architectures with NOREQUEST by default.
> https://lore.kernel.org/all/20250816094528.3560222-2-davidgow@google.com/
> 
Looks pretty good.

Build results:
	total: 162 pass: 162 fail: 0
Qemu test results:
	total: 637 pass: 637 fail: 0
Unit test results:
	pass: 640616 fail: 13
Failed unit tests:
	arm64:imx8mp-evk:irq_cpuhotplug_test
	arm64:imx8mp-evk:irq_test_cases
	m68k:q800:irq_test_cases
	m68k:virt:irq_test_cases

Individual failures:

[   32.613761]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:210
[   32.613761]     Expected remove_cpu(1) == 0, but
[   32.613761]         remove_cpu(1) == -16 (0xfffffffffffffff0)
[   32.621522]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:212
[   32.621522]     Expected add_cpu(1) == 0, but
[   32.621522]         add_cpu(1) == 1 (0x1)
[   32.630930]     # irq_cpuhotplug_test: pass:0 fail:1 skip:0 total:1

    # irq_disable_depth_test: ASSERTION FAILED at kernel/irq/irq_test.c:53
    Expected virq >= 0, but
        virq == -12 (0xfffffffffffffff4)
    # irq_disable_depth_test: pass:0 fail:1 skip:0 total:1
    not ok 1 irq_disable_depth_test
    # irq_free_disabled_test: ASSERTION FAILED at kernel/irq/irq_test.c:53
    Expected virq >= 0, but
        virq == -12 (0xfffffffffffffff4)
    # irq_free_disabled_test: pass:0 fail:1 skip:0 total:1

Guenter

