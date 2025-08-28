Return-Path: <linux-kernel+bounces-790073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 366DBB39EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5EE188C835
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8818B27A916;
	Thu, 28 Aug 2025 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixSENrPr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57397261C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387947; cv=none; b=jivgCxGgXr40auMMrgTagdBvaP6oZWKmcA3EbZoXX54MWToUHsKiqvLh9Oe4siLE4tA+ti2FV+EAdHNjBbpSjsP5FlpzoSuzzjAngYgymsDso2UpgjuUM2z773+1Bry1Uif9CkXWfANaMutYLUik4PpCRkb3V0moSxdKGIJ1H0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387947; c=relaxed/simple;
	bh=Gui68sDro66RAyiCW/3QZ7D+OhpJn7QyWGK9pLfxywk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pv7scil15Hy1FTOXh4sGYhHJErhWzJX0aLAJc2MvNugO5gH2KxvmC1wYFv0Oh9noRMzhlF7brmBG+2a3URd7RNyXz+GPwo6/0BXxbqXqbeXaMEXiE1IOJbqQqEmZObPov4FglcfQlqVCt0f678y9N/fQVD98953Yzlv23FVutBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixSENrPr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756387944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1gcQTBjZIOeAVv3+1MBRBTllVRRWkwC45vViKRladlo=;
	b=ixSENrPrxYp/9bJhIvaORb/HjVl6XvNsDcH8flI86ADlTrGNKALIrPfDi/mq9JRapEkW4+
	OATTevYcRqRBpmEGdZNwWxOe4rYE+oJrcPPbRxzUXJnVSHIBX2NVHqGu3lulHHjkwc/xQT
	euG49Ix/yLEyHJs1QYJbJtYAsNeqHjc=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-qvsySFE9PcucVdDKVc1e9Q-1; Thu, 28 Aug 2025 09:32:22 -0400
X-MC-Unique: qvsySFE9PcucVdDKVc1e9Q-1
X-Mimecast-MFC-AGG-ID: qvsySFE9PcucVdDKVc1e9Q_1756387941
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5228b365518so1080019137.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387941; x=1756992741;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gcQTBjZIOeAVv3+1MBRBTllVRRWkwC45vViKRladlo=;
        b=nypfOodSTfi0wHNJJfPvD7Zaj8pIKDukWbEN4x2YNHZnH0Rbr5w7Jo2vrh7o6b8+O7
         3jPR99CLjFAfqu1KMtL9S377U1FZtPJDroMm4wKnc974/76+4uPxdrAQzi/NXWVD4G+S
         lnh9vaID6waMpRPX9uMxbFldL6P9U+3AeMYmbBn8EBooJohPSjtPkqb9Qr4VhQYaXfbi
         68rKG2zazo4wjB6h9dZiu/iC5FLYLZOc7G415L/VCj/MD4tl3vcRlbL0LnOQLaDMXaIO
         G3StikqdIuj4nRisczI/sX4HEMU0Tk3VUjoHrgghe5Yh5Il0ShF8glDTQ8cEQleWNRYo
         e70w==
X-Forwarded-Encrypted: i=1; AJvYcCWngW16cl8IUVW4mcGEOXiIy8LSBUkAXh1ztitBsfCktC8Ga4m9BBElo0QHbGJwnsUNzmfrukm0QjXB5ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxkxRk5oQsAehrZaglOvS+PHqI/JIhuGmlAP1FHXfZhzUOjVXT
	4qGNg5uFsLCw6r1P4zdFrMTNVKw5kvMgoqaqUoQdO9VU2NaukPwKfh0O8Lr1UWdhrjFCn8GAdE4
	sa/Ox5I7+PqN1fYQ9VPbiHYUHjdYODo3ULIKtf4y8y8yfOahEriqJAqWQ1geBOc5BvUVBeQbAoA
	==
X-Gm-Gg: ASbGncuVcBj68sdF4JBNKKkclXANrzk486Tq4zK85liYOaVfWsUTzhM5iBw1v0kPYDD
	TuEvC0eg6xREZaueKBmw7w7jOdPd+WVwEmRYMEjmOQOkLfgT3RcXnpnZ5AhsowYMcCYX6aUbo30
	LZhW8pmMxkk3OB8KpcVdH8PamXkz1LEGyENMV9it3uPZIpUj4qO6PrIGlUkQmnw4io4W2mECItu
	X/RM9py99nbyWRiOwCdzm0VXo0/blPblXiwnPE3lyk4h8cUKBkFre9dYjUrc9f38naLOqVA4RLT
	VjhPZ2mKbzU0LMo27SkPC7mjErO6gYPtpYGGWY5k4q3smyCqSAdXOR34F3KcP/sBbLJhkjC35eT
	EoTs8NRSCzu3qcqLbJ3Q=
X-Received: by 2002:a05:6102:418f:b0:521:412d:94ea with SMTP id ada2fe7eead31-521412da0dfmr5367121137.34.1756387940649;
        Thu, 28 Aug 2025 06:32:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSUUdmKnWbgEPhXO4rx99S0UBIjQrOc1XfwS8UoeSDiP1UjihcSieOJOAuM8Elh6ok71rurw==
X-Received: by 2002:a05:6102:418f:b0:521:412d:94ea with SMTP id ada2fe7eead31-521412da0dfmr5367086137.34.1756387940118;
        Thu, 28 Aug 2025 06:32:20 -0700 (PDT)
Received: from [192.168.1.17] (pool-68-160-160-85.bstnma.fios.verizon.net. [68.160.160.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebed8902c5sm1110656285a.22.2025.08.28.06.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:32:19 -0700 (PDT)
Message-ID: <0ab92ae3-674f-445e-883c-0e511add85d2@redhat.com>
Date: Thu, 28 Aug 2025 09:32:18 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/tools: drop `-o pipefail` in gcc check scripts
To: Jan Stancek <jstancek@redhat.com>, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu,
 linux-kernel@vger.kernel.org
References: <e8c743dfb16c6c00fd793d7afa6eed33c49f895f.1756202009.git.jstancek@redhat.com>
Content-Language: en-US
From: Joe Lawrence <joe.lawrence@redhat.com>
Autocrypt: addr=joe.lawrence@redhat.com; keydata=
 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
 pNzsRQ==
In-Reply-To: <e8c743dfb16c6c00fd793d7afa6eed33c49f895f.1756202009.git.jstancek@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/25 5:54 AM, Jan Stancek wrote:
> We've been observing rare non-deterministic kconfig failures during
> olddefconfig, where ARCH_USING_PATCHABLE_FUNCTION_ENTRY was getting
> disabled and with it number of other config options that depend on it.
> 
> The reason is that gcc-check-fpatchable-function-entry.sh can fail
> if `grep -q` (or scripts/dummy-tools/gcc) is fast enough to exit while
> there is still someone writing on other side of pipe. `pipefail`
> propagates that error up to kconfig.
> 
> This can be seen for example with:
>   # (set -e; set -o pipefail; yes | grep -q y); echo $?
>   141
> 
> or by running the actual check script in loop extensively:
>   ----------------------------- 8< -------------------------------
>   function kconfig()
>   {
>     for i in `seq 1 100`; do
>       arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh \
>         ./scripts/dummy-tools/gcc -mlittle-endian \
>         || { echo "Oops"; exit 1; }
>     done
>   }
> 
>   for ((i=0; i<$(nproc); i++)); do kconfig & done
>   wait; echo "Done"
>   ----------------------------- >8 -------------------------------
> 
> Fixes: 0f71dcfb4aef ("powerpc/ftrace: Add support for -fpatchable-function-entry")
> Fixes: b71c9ffb1405 ("powerpc: Add arch/powerpc/tools directory")
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh | 1 -
>  arch/powerpc/tools/gcc-check-mprofile-kernel.sh           | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> index 06706903503b..baed467a016b 100755
> --- a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> +++ b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> @@ -2,7 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  set -e
> -set -o pipefail
>  
>  # To debug, uncomment the following line
>  # set -x
> diff --git a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
> index 73e331e7660e..6193b0ed0c77 100755
> --- a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
> +++ b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
> @@ -2,7 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  set -e
> -set -o pipefail
>  
>  # To debug, uncomment the following line
>  # set -x

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

This bug manifests when automated scripts expect to run a kernel build
after `make olddefconfig`.  I reported this to Jan when I found that
kpatch-build [1] instances were hanging (expecting to hear from a user
that would never answer :(

[1] https://github.com/dynup/kpatch/blob/master/kpatch-build/kpatch-build
-- 
Joe


