Return-Path: <linux-kernel+bounces-727947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3054BB021AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3335664DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4E52EFD81;
	Fri, 11 Jul 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=neon.tech header.i=@neon.tech header.b="Xp4cKFOi"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A80A2EF664
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251173; cv=none; b=o/NLBJtGZ7/x2w2AVAw3ZYlrVZQCgV/psIIt0PSURSGqIClZqNbpPpJyvD7NWqsdymPcs8XMZIqrQZSzeM/wdzJwcp/nTT+r4fStvCkxJJnbo+BIDmgHqRCXDGkHO5t/mlt2lQegLkvlRva1FS+Dnoduqfnav4k33fMaR15aP6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251173; c=relaxed/simple;
	bh=oUgexkfKk7lyPiAr32ML/pXsH4yEapBM5mh6e46sSV8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=liNWjVOw0ZBTSjJ4ganbsU1F+rryIHFBC+fjDIP/F/WQm77vKe574n/tHVJR6VqcVbRfMnh7wMWK6dJ2GfSa/js4OyFPga7lVoJmR1n1hTSNAyL1M4cJ40tfXTNFyLbGZTT3trxp8UjQH/z04RORSydsXp3xiUu6GM/7eZHC430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neon.tech; spf=pass smtp.mailfrom=neon.tech; dkim=pass (1024-bit key) header.d=neon.tech header.i=@neon.tech header.b=Xp4cKFOi; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neon.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neon.tech
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso1428327f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neon.tech; s=google; t=1752251170; x=1752855970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l0BaFIA4z05BNHrxzPc5c1dvIBEP+tuY7096Lefw244=;
        b=Xp4cKFOiui77VK95tUBdBN90iFHh/l0b6pifoEvtrbzb10XoxacSCC6WdS8UUQ7oW4
         k2Wh9Iz2dp5TnBxNv7gXADlRjVnF7foylUUE11zQ/qeVYf9sDhU3hA2ekybmVy7QR5+E
         NSCx30JmZEPXkr9dnZmaaxAf+n9UPoyXmmv+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251170; x=1752855970;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0BaFIA4z05BNHrxzPc5c1dvIBEP+tuY7096Lefw244=;
        b=ZWUqMXYcu71QirC5Xx243Hx/HYNHAiGoJI2nhKuHcAa7d4r7xBEPmUvpUHYJKYElMO
         IvdvW+Ki/OKUkbOOtsttfdeNRYr9m9dKVWmDATtsjL6/cC8Q1hrh++Vn8NcASnDFOnvH
         2yxkm5JGRnHvOHgql35EzdrATQB34Kb6ho8SAkGVA9MEVwX5GVz5kYUz1owXUF21xdIy
         Q3QJ+3Wz62/6qoAcNmNjLA/26kMSwnWsscPKi9xMYttwAoSSzDi8qrps2koFBaEVs9F0
         T3X69otqrW2cMvw9dwuVHFrtKNRey5lh+wL9YGm1yqB3K8EDxc5QajWTyvNnj6B1jKC9
         3u0A==
X-Gm-Message-State: AOJu0YxCcboo5Dp0NvM0C1uxlEi4bpFf9MDp1l8w6tZ5UOirrEhLMY0q
	/BXclTEl2AqEgQb+zPwbH2Adji/C7Le6kGmii2bVtFk6T8h1YiTjBIIovw9sn/UZubQw0HnObj+
	HPqPov5VIxQ==
X-Gm-Gg: ASbGncuhnUvVnx3PxZfzNbHQwO43gQP0Z0LSbhxD3Z+7oBJoKThXz0oIYmOHCGJRevD
	patY5l39/5mn74DA5t8xeXCLuTa7nbuuSxLzC0AkgcFOjCkxrUaJ3UxhYe/mVrI/DSA3JrGzaep
	CkFblv658qNX0dxemXOFuvWBKV11AsWrncTd69p2WWC3u8eDLep5aQAt0c8CqP+JBjpjYmk6Qfu
	7mhY3PQURihzifx9txEEr+0wy1Mi9YNBGIYIOEIFI0xtk4X6Yuj6D4PATt5eKs109BUqo64pAo3
	NjbOJjk6hi8U+WkOvBefKCi/V/uc9PyRstH692P5p085zOnFyCMygbErnterkvoQ3pk9oKY02KB
	7IEDIWOc2vGSV7fczV573w3/a
X-Google-Smtp-Source: AGHT+IEtHlc6T4CwaJgqjYewHkiPoUMq70zuk2O5AEHpJyyZehub4IRGD1KMTYZkaghmkygyzYGm5w==
X-Received: by 2002:a05:6000:41fa:b0:3a4:dbdf:7154 with SMTP id ffacd0b85a97d-3b5f18deb50mr4130063f8f.54.1752251169679;
        Fri, 11 Jul 2025 09:26:09 -0700 (PDT)
Received: from [192.168.86.142] ([90.253.47.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e2710bsm4851898f8f.99.2025.07.11.09.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 09:26:09 -0700 (PDT)
Message-ID: <51de7373-1b8d-426d-b720-ad9134c170bd@neon.tech>
Date: Fri, 11 Jul 2025 17:26:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 4/4] x86/mm: Use GFP_KERNEL for alloc_low_pages() after
 boot
From: Em Sharnoff <sharnoff@neon.tech>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Oleg Vasilev <oleg@neon.tech>, Arthur Petukhovsky <arthur@neon.tech>,
 Stefan Radig <stefan@neon.tech>, Misha Sakhnov <misha@neon.tech>
References: <4fe0984f-74dc-45fe-b2b6-bdd81ec15bac@neon.tech>
Content-Language: en-US
In-Reply-To: <4fe0984f-74dc-45fe-b2b6-bdd81ec15bac@neon.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently it's GFP_ATOMIC. GFP_KERNEL seems more correct.

From Ingo M. [1]

> There's no real reason why it should be GFP_ATOMIC AFAICS, other than
> some historic inertia that nobody bothered to fix.

and previously Mike R. [2]

> The few callers that effectively use page allocator for the direct map
> updates are gart_iommu_init() and memory hotplug. Neither of them
> happen in an atomic context so there is no reason to use GFP_ATOMIC
> for these allocations.
>
> Replace GFP_ATOMIC with GFP_KERNEL to avoid using atomic reserves for
> allocations that do not require that.

[1]: https://lore.kernel.org/all/aEE6_S2a-1tk1dtI@gmail.com/
[2]: https://lore.kernel.org/all/20211111110241.25968-5-rppt@kernel.org/

Signed-off-by: Em Sharnoff <sharnoff@neon.tech>
---
Changelog:
- v2: Add this patch
- v3: No changes
- v4: No changes
---
 arch/x86/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 474a7294016c..b37ac1d546af 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -132,7 +132,7 @@ __ref void *alloc_low_pages(unsigned int num)
 		unsigned int order;
 
 		order = get_order((unsigned long)num << PAGE_SHIFT);
-		return (void *)__get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
+		return (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
 	}
 
 	if ((pgt_buf_end + num) > pgt_buf_top || !can_use_brk_pgt) {
-- 
2.39.5


