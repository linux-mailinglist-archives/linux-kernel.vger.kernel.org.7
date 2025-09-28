Return-Path: <linux-kernel+bounces-835587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B37ECBA7847
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8141897A8C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8029B764;
	Sun, 28 Sep 2025 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FlkpWXh3"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB08225D6
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759094535; cv=none; b=AilowWL4Rzeq1Bu4/Thf1EYd8G+MgtkJLTIKIRCl21DscWleWozh5bcp97gTQKRNyPFUAFACATF1kTQoKv1d1+W3ruW9L4r4M+AghpSzFM+q517gJ4ydAloeV/yetQT9ecGnY924eKgJKBGjPX0WdNGvx/RH3fDTXPY7fEP69CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759094535; c=relaxed/simple;
	bh=+Q5MesR7HdAhD0+v/uWSgN1Y3iib8z+4eaDVW2M7wZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1Mrr83SzqHJMzxQdMWeoMo/kasrg2raLWhZTFeMhLjsvo/tAgBE90CrXkSk/sliC1AKOp8cgsHirfH7Km1DJgBnCmI6KJikL/ZbP4vmm1j4BZqw8Pvd7reJQuzYKvcP5Kxi5nmmvEeh13gnsg8WDMcvU4qw+DQFz5B0Mdo6b+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FlkpWXh3; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-426f9f275b2so12279945ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759094533; x=1759699333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g09tOhd8i3LGVO3Ma+R2GpKg7N6ID+Lej0H4iQzvBbw=;
        b=FlkpWXh3+DOnoDSNGQzuid9R4h67kS99Oy566cm/sBMnimb/0s9iJjFK+mA347UBjz
         GT5HUwRgex1M8clGI91GJlrLldYImV9D12aNb9Qdai5uaKLYdmi5XHPIQbSY+UNx83ZU
         eFoepmveUTSyIXvs3UyN2bXxbWpf+X/rV/p9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759094533; x=1759699333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g09tOhd8i3LGVO3Ma+R2GpKg7N6ID+Lej0H4iQzvBbw=;
        b=I6YyLBZsUFi10y0r/YUQrdyb6YtVLNytqiKaw/S3H6b2DBh+33/HQYbAO0LHezjuH0
         BwEDz68T5qDQcfcYV9CZPKZLotzQ7ip8UP3+OoXkMAmtN9VSHFTkzgQBfWBOB6s1nYS7
         kAweRTijslLrNXVOSv6PiLhzxgrTzwHP1xKQK9ya5KKbpVKkK/3kqdM6qVMPdPP6of+h
         NBnEwne2rN67S7rfRMMzB2pYe+aH08tGltcM5qvT03ROA1vm7qyYWO9j9/EFGUzM9csX
         HofSuoWIPzU4qOFwNy+fYUmPQowNyOmyYgASxV0EUOncOtW0pZJky4f0C23V8ZdOSaDc
         SW2w==
X-Forwarded-Encrypted: i=1; AJvYcCVhxh/Fupsq8FIRBaSIIY5XXEAuwIm2stM9sV0OZfedLYf2LR94ev7Gcq/2kxKR7hArMVnkvp/PS0OJaQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YytmETz1kTlEb3uMn4OUgHofmU84XfTsvC08T/nNWItiuwvL8Ru
	yymz+yXrINxCW56g2NUsFK8ukaOjZwH1phzjI3bSC/Ro2z3Ycr1SGfQYxUfuaWxBaJg=
X-Gm-Gg: ASbGncvVSn25zCSGQgkfb/zpMWBUxfRmS0C8G1wYCXaDOsuRtg4bDtnTqZiKgRQ5+Rp
	QjdMb1m6LIP6XUxkooJatjWrXd1HQgTxROntUcnTZntG5ANtbAYZuEghvojJ0tjlJAp5Q8SrBTH
	EbIBwNDUy0F5uLXGTAh2G2q21PBdKqKRNQAulcFnnSzylBq3YUn7dJBVRmOgQoqsIynQ1emlcK+
	WdKBHdIOXdBHmNxps7CayMhm4A9hRqIoTx/GFIhFDTh0WzocJQH4GanFztBO/i39T69/Kwd2s22
	ib6M04wpPaXn8NjPUV9W4yjk80+C9p/4BnyZSYTz1u6hNG4E9RukGQxxNC6+5pfTslizA9Z4hJd
	xwN9RJ8NLapXry0cgu8pjWvq2SipJ/9I4jpw=
X-Google-Smtp-Source: AGHT+IGEE6j1ea7mA3zg2sHrANU4yNXVvLqMdz000SknmhP5748vqXwCYZrU1usN/WK2x4r+PZX3cg==
X-Received: by 2002:a05:6e02:12cf:b0:424:9926:a97b with SMTP id e9e14a558f8ab-42595654326mr227342465ab.25.1759094533081;
        Sun, 28 Sep 2025 14:22:13 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425bc68e6fbsm50246345ab.17.2025.09.28.14.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 14:22:12 -0700 (PDT)
Message-ID: <6e0d5120-868c-45fd-9ec5-67764a257ab5@linuxfoundation.org>
Date: Sun, 28 Sep 2025 15:22:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Error during building on next-20250926 - kunit.py run --alltests
 run
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 David Gow <davidgow@google.com>, johannes.berg@intel.com
Cc: shuah <shuah@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 KUnit Development <kunit-dev@googlegroups.com>,
 Networking <netdev@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <47b370c2-9ab2-419f-9d43-8da310fedb4a@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <47b370c2-9ab2-419f-9d43-8da310fedb4a@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/28/25 15:11, Shuah Khan wrote:
> Hi Thomas and David,
> 
> I am seeing the following error during "kunit.py run --alltests run"
> next-20250926.
> 
> $ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=16
> ERROR:root:/usr/bin/ld: drivers/net/wireless/intel/iwlwifi/tests/devinfo.o: in function `devinfo_pci_ids_config':
> devinfo.c:(.text+0x2d): undefined reference to `iwl_bz_mac_cfg'
> collect2: error: ld returned 1 exit status
> make[3]: *** [../scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
> make[2]: *** [/linux/linux_next/Makefile:1242: vmlinux] Error 2
> make[1]: *** [/linux/linux_next/Makefile:248: __sub-make] Error 2
> make: *** [Makefile:248: __sub-make] Error 2

Same problem when running - kunit.py run --alltests --arch x86_64
> 
> Possile intearction between these two commits: Note: linux-kselftext
> kunit branch is fine I am going send kunit pr to Linus later today.
> Heads up that "kunit.py run --alltests run" is failing on next-20250926
> 
> 
> commit 031cdd3bc3f369553933c1b0f4cb18000162c8ff
> Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Date:   Mon Sep 8 09:03:38 2025 +0200
> 
>      kunit: Enable PCI on UML without triggering WARN()
> 
> 
> commit 137b0bb916f1addb2ffbefd09a6e3e9d15fe6100
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Mon Sep 15 11:34:28 2025 +0300
> 
>      wifi: iwlwifi: tests: check listed PCI IDs have configs
> 
> Note: linux-kselftext build just fine.

linux-kselftect kunit branch is fine.

thanks,
-- Shuah

