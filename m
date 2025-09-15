Return-Path: <linux-kernel+bounces-817430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EA4B5821A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D56E3AF7C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C892877F7;
	Mon, 15 Sep 2025 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cZ1CyEQG"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DFA27A103
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953751; cv=none; b=pqSO/0ENUkyPgHdMVkzOflbWEE7r4oMZwZBdm4dZwsJBX3sYp3slfOFdyYWhMcnP3Ofi3siEXQV5D4YMvqAc1aSdcx8DXwMb4b1qalVPpnMig4ficne9xoY5ohjAzyz+AaH4BRAXex6VKZZrgTyA/aGVFp7TjE8TknRAIL/tZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953751; c=relaxed/simple;
	bh=gE2E45uufUftZzzuWHCvT3/unryv2SJtCTK24vDB94Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISzl9KRH8z3Ve4pBVrQgfR4HMDwXKaBpBWZAj+1T0OjGPESXkyP/BNu4sGd2K5RphxzLwJNcDWd2VCNvOa75cBzrUG/FmdBxWUNeEnVp598RV+GLOwNMvZuGZ0dL2/OduM0sBp+hLDd2XNVVAADpLXj/Zf2gIMDKk1zbipd23X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cZ1CyEQG; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88de776ab4aso157152039f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757953748; x=1758558548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+sTjpO0cIpsChCn8JbuHptxP7HKcKjnaPUPmSOiAZ4=;
        b=cZ1CyEQGGs39kqH7nfzoPBcNTRwqlQ1TdfDhySm4p+SSd65VpPId7F+E7wJ4ykPK1s
         Mj9Q5PpQ5oooRDRzy9vMCbWP3T0FgbBNViIKhOs+gbcyhrGXiDf1aMjOXRKzfd2CwWyK
         L7zCMlE1703RrOuf52J3RIEF2nLiF9OViRMME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953748; x=1758558548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+sTjpO0cIpsChCn8JbuHptxP7HKcKjnaPUPmSOiAZ4=;
        b=uItj8gMAdJisjW6tFxTIGNuuWjnseFW6ZXPfaDIdzd/iybcKND7vTmioy8AJHSca/N
         eF7Th3nFKKgogxjuE5LZpzajx2rB17unJbXzI2+fmiUv61JG9Oi2sukkwT2lq4a6/LQG
         g0sRtxVawZCjNW6hQilHu2E4zT3n3Xop2SGSsMjxTJk7zIlHiUnyuuJV1f1ZKXRt70cb
         0sb687JDOkZb+CMeZQVTnG/ttfeSHfaUhE/MZOX3KpbCNBtCcEgAGhzeYudrAJPLIRGd
         diBrnCY7WAuXorInWVR+zszUZADdHshSAhV596CQJKLLsMp4YdWsWvq5j5NRwm25eV7h
         cZXA==
X-Forwarded-Encrypted: i=1; AJvYcCV3evzRhItMjriwvyDEOf/ixvbsB4bMQvZMGv1GbE79dxosxjSz+g9GrIY2Hyhnnr5ZnHnCT4iu6BpOQXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuW9LFzStLSEjEt2DdZFhh5e3f/G8ULvEe1xWTuJkRD85fkf8f
	CtHcID2pHq48MtqgkujYF5ccjKGfmCI2D1yIGfSkyJiasPE49V1HdZ3/DpVLWXEHKbk=
X-Gm-Gg: ASbGncsFdG5cbxXXwcECUqZ8d3ktUZRKc66a4LEUwihb7jA+LPhW3M0O2Enpo+U0V1m
	VLXMg4vPQ+gl5w6IkxXRpz4V2emZUcUvdsydoku00+JX+B49lg9TUdKMup30jNtLCDFpG57YYAL
	YxlO0h2rTy1y+Opqkg47Ap91+r7C+qnlJbXYfsshaU/6pgR1UgFVeURnNceralb93/LhURNX2c7
	oepPhoOMFacYJF1BgPWPaD5Z8NQ3CGEZkuN4sGNnOk50N3HPoE1BR9didfEXsV1Zp9aATRjO5Yr
	JJT6MvIX/7MHUxgfucI/8i/19Za3Ofv8kaYJdkLAUBmHs1UuIrON0ke/4XkIIE01LllLlQ2+RHz
	0s9JqPLUFutDxjzeCWAFhXbgLoJ6MlusSuic/mvZG43RhN3k=
X-Google-Smtp-Source: AGHT+IEJzZF0BGCbIvlEszdewtPyiyEjXRaiR+hdFvugN44tYVhlRO+VJIO/vMCzUnVJIaBknAPoVg==
X-Received: by 2002:a05:6602:140f:b0:887:48b8:fe74 with SMTP id ca18e2360f4ac-89034dd42c9mr1343262539f.17.1757953747088;
        Mon, 15 Sep 2025 09:29:07 -0700 (PDT)
Received: from [10.212.145.175] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88f2f6c62a5sm465640039f.22.2025.09.15.09.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 09:29:06 -0700 (PDT)
Message-ID: <3dc95227-2be9-48a0-bdea-3f283d9b2a38@linuxfoundation.org>
Date: Mon, 15 Sep 2025 10:29:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] kunit: Enable PCI on UML without triggering
 WARN()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
References: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/8/25 01:03, Thomas Weißschuh wrote:
> Various KUnit tests require PCI infrastructure to work. All normal
> platforms enable PCI by default, but UML does not. Enabling PCI from
> .kunitconfig files is problematic as it would not be portable. So in
> commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
> PCI was enabled by way of CONFIG_UML_PCI_OVER_VIRTIO=y. However
> CONFIG_UML_PCI_OVER_VIRTIO requires additional configuration of
> CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID or will otherwise trigger a WARN() in
> virtio_pcidev_init(). However there is no one correct value for
> UML_PCI_OVER_VIRTIO_DEVICE_ID which could be used by default.
> 
> This warning is confusing when debugging test failures.
> 
> On the other hand, the functionality of CONFIG_UML_PCI_OVER_VIRTIO is not
> used at all, given that it is completely non-functional as indicated by
> the WARN() in question. Instead it is only used as a way to enable
> CONFIG_UML_PCI which itself is not directly configurable.
> 
> Instead of going through CONFIG_UML_PCI_OVER_VIRTIO, introduce a custom
> configuration option which enables CONFIG_UML_PCI without triggering
> warnings or building dead code.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> ---
> Changes in v2:
> - Rebase onto v6.17-rc1
> - Pick up review from Johannes
> - Link to v1: https://lore.kernel.org/r/20250627-kunit-uml-pci-v1-1-a622fa445e58@linutronix.de
> ---
>   lib/kunit/Kconfig                           | 7 +++++++
>   tools/testing/kunit/configs/arch_uml.config | 5 ++---
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index c10ede4b1d2201d5f8cddeb71cc5096e21be9b6a..1823539e96da30e165fa8d395ccbd3f6754c836e 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -106,4 +106,11 @@ config KUNIT_DEFAULT_TIMEOUT
>   	  If unsure, the default timeout of 300 seconds is suitable for most
>   	  cases.
>   
> +config KUNIT_UML_PCI
> +	bool "KUnit UML PCI Support"
> +	depends on UML
> +	select UML_PCI
> +	help
> +	  Enables the PCI subsystem on UML for use by KUnit tests.

I am applying this patch for 6.18-rc1.

Please send a patch to fix the following warning on top of this one based
on

https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit

WARNING: please write a help paragraph that fully describes the config symbol with at least 4 lines
#136: FILE: lib/kunit/Kconfig:109:
+config KUNIT_UML_PCI
+	bool "KUnit UML PCI Support"
+	depends on UML
+	select UML_PCI
+	help
+	  Enables the PCI subsystem on UML for use by KUnit tests.

thanks,
-- Shuah

