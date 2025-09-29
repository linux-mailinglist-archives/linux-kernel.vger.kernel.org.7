Return-Path: <linux-kernel+bounces-836534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04662BA9F49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91499421A44
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7513230C344;
	Mon, 29 Sep 2025 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R0lj5LsK"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ADB1FBC91
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161942; cv=none; b=oZIqy4GU92DnlYMs1tqdOk1yefh+aFLnwf+1lINxXc+n0rqRskyRm5ePhfq8zILhcX0dJIe1vu6qJi/nrOLjqqIi2ebQ7hl8DRomJjd2s85C2DH0Qg73PuCQAtOXorBURhgM6G2w/NFt12XBdsdz2zXJz5q7TCGMmPYxrxyv3so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161942; c=relaxed/simple;
	bh=lqvVXsxwgd7KNRJpVXUs4xGkpt9oAdHyl6eHPB76/64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iy886Z0OeGhx8ZEpBcYvd0BZw5D1cLKqOeiSyk8AQN+wqbod5AQsR1rb6hmwF3tgwoh0Vp/H6A2j0LfbwGV3bGn1KKDLQe2hC5TcKuLbmh7THiwablq/suDpbuj7fHh7TDkpp0qhWWnhCKBAY1GU7264StpulcWjaPuXzU7a+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R0lj5LsK; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4248b34fc8eso48393895ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759161940; x=1759766740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrDEmBp4PuhFWDo5pZJaz9gu+ynKRcGeNOm0qBaqKcQ=;
        b=R0lj5LsKDoGfnBGnPbMLAEiJIOLaW5YJ2OPTLXS6obuW6kJwX64o33D8X0TUMIgLKZ
         Yd2p19rXbdI21yIQlvlnCdYrVN6AsDhSoKU9aSig0WeouQDMVc5AYZzH3Sm7e+L/OloU
         RMbxGT6rJ1khtdiTAaYLm/Rjg0d+ZcrdmcI74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161940; x=1759766740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrDEmBp4PuhFWDo5pZJaz9gu+ynKRcGeNOm0qBaqKcQ=;
        b=DTo5MkwAwcLC841FFRQ2iK7Z716Hu3RUQSD1MIzY1r2xIms91dYkARkvONDKPxwlv1
         MV9OecpPKPwuqb6NfXRim2PSrrUrsZAvviA8Ny46KJ4h8Wmv2duWGd9wLGzdzQOvI35N
         2iDTFOrXqdlVtoEPelI9L+oQtdv3hCXIpwQ1G7a8N01oeEqQOwAjZzo5Y6wjxq/ZeQyv
         bM824GqbsEXamkLYHkfCvRWNSVoXnNLzrHqw0BGAhNsdq9V9jdgr4QGMQkJmAkihY71a
         nPWHiizzkeo54okVxsfwO3zCvQvCOd49KgDKUFzOUgEOGeZpcp7/Vee9DE/BMlTL4bci
         uzag==
X-Forwarded-Encrypted: i=1; AJvYcCU4imeo4g4gGCBM28Zv2J0d5h5Mt5aIplKb3j8kkPNng5v6NtEgCDJhCYt4NjpV7G+jKprpSNP2H2Bo9qY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3kAUgIoqV2a84W0aImWNbBTXHaLWvF04OU21w8gWHZ0tpITr
	YXJs9xOJnFSkMKJdCJWESXeMnoRA5s2UJaW7V6Fe4PetG+6uaa25hmEiIr0Hd+xIKZw=
X-Gm-Gg: ASbGncuCaxLLitTbKY7F0kYb050AIr2FlinVIuhTWZJwGI5LplFNQg+LcmaBp6h2Tcb
	JmMCwKTfJv8iZBpNzKGbhM1g0lfgfr+IjvTsimJ1zNMqx/1uii2qnhg2uwLFY/3I/+GaiRVlnae
	goLB70G4Chtj0MsuFfRDSqUw1gXQ47QbIR++z2Edquwe7s0O8CYmVm3vxR7O7UQc3NEVhNfudCt
	6PkHanJm5qwJuxg7gixOa2yWpTgAxG3mUwKK0R4rn5sZXnYuWX+LJR/FrInDuRz0hd0H9lfDBK/
	5AUSm2t3x0Bk75GTC+gU7utfDpnuwsKKp780+W60N4nN+Fj6bVeBBYFJZ6bE2rNrX73L0uAl2fj
	mvoszaxQbONfHvOpcP/IhGTQX+WeFof5ybmXyOe+XWfhECw==
X-Google-Smtp-Source: AGHT+IEhlH1Gw/rb3nZHres5CyuavbpCDfQhybviqKFDUwCs02E+gqmN2K0KZHVbSkEfbaN/G2gDFw==
X-Received: by 2002:a05:6e02:1d86:b0:424:57d:1a50 with SMTP id e9e14a558f8ab-425955ed837mr293336485ab.11.1759161939748;
        Mon, 29 Sep 2025 09:05:39 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425bc685127sm57769475ab.11.2025.09.29.09.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 09:05:39 -0700 (PDT)
Message-ID: <0f3a1bad-4e8e-473f-8f78-92a6b96450b9@linuxfoundation.org>
Date: Mon, 29 Sep 2025 10:05:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Error during building on next-20250926 - kunit.py run --alltests
 run
To: "Berg, Johannes" <johannes.berg@intel.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 David Gow <davidgow@google.com>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: shuah <shuah@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 KUnit Development <kunit-dev@googlegroups.com>,
 Networking <netdev@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <47b370c2-9ab2-419f-9d43-8da310fedb4a@linuxfoundation.org>
 <6e0d5120-868c-45fd-9ec5-67764a257ab5@linuxfoundation.org>
 <PH8PR11MB8285FB2BB207666DE9814F61E91BA@PH8PR11MB8285.namprd11.prod.outlook.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <PH8PR11MB8285FB2BB207666DE9814F61E91BA@PH8PR11MB8285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/25 01:07, Berg, Johannes wrote:
> +Miri
> 
> Hi Shuah,
> 
>>> I am seeing the following error during "kunit.py run --alltests run"
>>> next-20250926.
>>>
>>> $ make all compile_commands.json scripts_gdb ARCH=um O=.kunit
>>> --jobs=16
>>> ERROR:root:/usr/bin/ld: drivers/net/wireless/intel/iwlwifi/tests/devinfo.o: in
>> function `devinfo_pci_ids_config':
>>> devinfo.c:(.text+0x2d): undefined reference to `iwl_bz_mac_cfg'
>>> collect2: error: ld returned 1 exit status
>>> make[3]: *** [../scripts/Makefile.vmlinux:72: vmlinux.unstripped]
>>> Error 1
>>> make[2]: *** [/linux/linux_next/Makefile:1242: vmlinux] Error 2
>>> make[1]: *** [/linux/linux_next/Makefile:248: __sub-make] Error 2
>>> make: *** [Makefile:248: __sub-make] Error 2
> 
> Yeah, really my mistake, I didn't consider what happens in the test there when iwlwifi is built but without CONFIG_IWLMVM and CONFIG_IWLMLD.
> 
> I think we should add those to actually run their kunit tests too, which would fix the build issue, and maybe even CONFIG_IWLDVM to increase coverage of the tests in iwlwifi itself. I can send a patch for that.
> 
> All that said, the patch that breaks it is in linux-next via iwlwifi-next but seems to actually have missed the cutoff for 6.18, so we're good for now and I suppose Miri can even squash the build fix into that later.
> 

Thank you. Sounds like a plan.

I will send my kunit pr to Linus then.

thanks,
-- Shuah

