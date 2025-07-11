Return-Path: <linux-kernel+bounces-727944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0641B021A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BAB1C430C4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5D12EF2B6;
	Fri, 11 Jul 2025 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=neon.tech header.i=@neon.tech header.b="YZnpZ/Tl"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862661CDFD5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251152; cv=none; b=bl2K+ISRkquWvc95QIXy54SH5dGTOZcf6uZA3uCqcohobJQQ/nbFsGohHxhnczpgVLQokcZkMb/Adtwfb16SCfjWxl2rxQvl6nKWlwZIvVM1QFaRvrRkOfIbcFjy6Q9ERew3KUK1njGgRkiHkT0q+Ip7zxCv9FeWlSyaLQzKxEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251152; c=relaxed/simple;
	bh=/KpZWkaEwJLKMDMQn4psJepbWMGXVRfdxAgsB9WhCMk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DwVY4TkI2dWEdVK8c3Iocu6qlJkA+daeGB+DTTCmKZryTVHAH3CWEE2hX9bkwsQul1Ez48oiLLwV8k2iAY3vhetfwhX7KXOzcNfUq2qv6afjaUt4XlBKF+NiRJFo+tqte+L2TO29nyww0UOaSoSOlyY2gp97FUxtEnsNu7fZJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neon.tech; spf=pass smtp.mailfrom=neon.tech; dkim=pass (1024-bit key) header.d=neon.tech header.i=@neon.tech header.b=YZnpZ/Tl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neon.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neon.tech
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a52874d593so2027918f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neon.tech; s=google; t=1752251148; x=1752855948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mVOvJzOysvMSEvzQTn/gtmIPfcXAeZXReyjGvGDvpHk=;
        b=YZnpZ/TlUlIPu46VPsnB7nPOcqTTBZ/EMERBbM/IfG8PLZZUQwFOAPeH2o4rhtUpqa
         8blVZHo6ZoZjQ8vrpTGmYdC1wAflUl7wrsdQ2WhdiRgt2Tr/KXzZ0pHGS1YatiPMrj6W
         Sl6+0XPq2vXotfqnyO2x1Bo7SXcUhJGqY1AU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251148; x=1752855948;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVOvJzOysvMSEvzQTn/gtmIPfcXAeZXReyjGvGDvpHk=;
        b=LRm4Z2P5XRplWA1phrq2SSmhGPVOdpXdWZdNZhzLMYDvKf9nuw9GCFY9Ty+TqpJnPd
         ltCpuuccL2bZ9VVLQQGA2N5M9D4drqFaO9xueYGPXDNZT0iN5KJc7BXquhrjZRfuRfRk
         NyCl2ZXs8xlNL5EQQ774VzllObythGihVWdOnT5LgLiDDJq9Q0ZmS59OQm7yKj4mq9yN
         rErjVmAiWcHPz8+V6dLgZRjSeZYUOZO+quIWl+FD6sEgezfQi22cNTlxHQNRCB+YYc6Z
         FEJ40xNowOgVAy++NRbzdj21s422mHi+jxwccEF+yYOYk7kmaYcSqFwWgmaMb5CkqGbH
         Le7w==
X-Gm-Message-State: AOJu0YzBdva6XZt/5cYU4RNZXkz8NJWYG7U95ek7XEiVWgRGMAnc6nRq
	yb4IoEn9AmOnuIDZ9xPtjKbe4ZNvEhI2H9P9XZCIvmERuZBWdTulQx7k63lt1TK4//hqeqkShGX
	bAgOxPKc=
X-Gm-Gg: ASbGncvOsyw/aYQ7YjVCjNy9M5rD1zVvqkeazT6SPwa26SZzIblCWJfkZRoTmOXgsdX
	M9gV59qU6WPl3ZBcRBvSXTdhSoIwXAkqKCBkhjFHK/divMdJLcD13Guoghl07qJmrSKDfBvLYAp
	G64St0za7hEl9dbi5tTBurddEWj79DFUDDr/u9gnrbO+Ht5FUx3JjpXvdDIVPX7/9jgTHeokaIa
	Fku8femoACfkLMbvBYxQfK5ot74wUTRoJxsekUQOUbKjzOQhDqMZE6BpW0jj7cmf+QhyC/UbILm
	DPKZ4QrF46AjKWCqkMMCGYCKkFE//3p43RCYMoWV0bW9Vx+ztjvSe9xxNTGYAHKWwVMFNernHix
	UedIhHCgXD63dJ5qeBfQKUVvn
X-Google-Smtp-Source: AGHT+IEs1P02WdLGoha1eDbYqb7Wcp8T+IYiXaRxuwhMaq3zMywB/uJnh5edgskpK0L3sbIWWEbGNA==
X-Received: by 2002:a05:6000:4186:b0:3a5:2599:4178 with SMTP id ffacd0b85a97d-3b5f188e184mr3270301f8f.19.1752251148469;
        Fri, 11 Jul 2025 09:25:48 -0700 (PDT)
Received: from [192.168.86.142] ([90.253.47.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26c8bsm4822114f8f.88.2025.07.11.09.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 09:25:48 -0700 (PDT)
Message-ID: <136b4999-1c05-4d30-9521-d621196e6ba7@neon.tech>
Date: Fri, 11 Jul 2025 17:25:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 3/4] x86/mm: Handle alloc failure in phys_*_init()
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

During memory hotplug, allocation failures in phys_*_init() aren't
handled, which results in a null pointer dereference if they occur.

This patch depends on the previous patch ("x86/mm: Allow error returns
from phys_*_init()").

Signed-off-by: Em Sharnoff <sharnoff@neon.tech>
---
Changelog:
- v4: Split this patch out from the error handling changes
---
 arch/x86/mm/init_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ca71eaec1db5..eced309a4015 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -573,6 +573,8 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 		}
 
 		pte = alloc_low_page();
+		if (!pte)
+			return -ENOMEM;
 		paddr_last = phys_pte_init(pte, paddr, paddr_end, new_prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
@@ -665,6 +667,8 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 		}
 
 		pmd = alloc_low_page();
+		if (!pmd)
+			return -ENOMEM;
 		ret = phys_pmd_init(pmd, paddr, paddr_end,
 				    page_size_mask, prot, init);
 
@@ -727,6 +731,8 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 		}
 
 		pud = alloc_low_page();
+		if (!pud)
+			return -ENOMEM;
 		ret = phys_pud_init(pud, paddr, __pa(vaddr_end),
 				    page_size_mask, prot, init);
 
@@ -775,6 +781,8 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 		}
 
 		p4d = alloc_low_page();
+		if (!p4d)
+			return -ENOMEM;
 		ret = phys_p4d_init(p4d, __pa(vaddr), __pa(vaddr_end),
 				    page_size_mask, prot, init);
 
-- 
2.39.5


