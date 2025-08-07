Return-Path: <linux-kernel+bounces-759309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC19B1DBD8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691D57E05A9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4807270569;
	Thu,  7 Aug 2025 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liOyyNwP"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C0F2701D0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754584541; cv=none; b=p87q4cmNT58SRUNFOmv6wtbfWOqRLad9MNDygndf0xqH9p8MDWq/tllaP/TlnHqbHdtX2A/OcCI4k6oU73UbrnqhJTlrHXdZzrs7Ax5+NZKfaeKSex6mvbh5a6n9g9bEspKqDH5incZePUBjmKzHYWIZ5+M27xTcO/svkG2w2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754584541; c=relaxed/simple;
	bh=yJogpypRJnovSOr0J3reD7d8VHXNsnh4LnJ9ywkb6yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lll67+olP/fwpmt3utvAT0eBwQAFEEC5CzeWkmFzLEykDreqKffkX3iWLRhv+SqR/khGjrPrZsYLY2kcBouhl9MqSWgT+JVGncyTNSIpEBq2mzNkGvdrUF8PwmNhJX904ih3cUI2EAT87S3JvDK4Ip7BO5EawcR5taGfllub6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liOyyNwP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55b9dfd4020so223894e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754584537; x=1755189337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HtJ7SukZttuLpvU2sM4wbLSaHHmB2xRR25bbI/ADQkc=;
        b=liOyyNwPhmCIsEJz+phhXoaYa2zbIAcG/TOijCHGqnktDqBSqW/UJDoluq9LIXtDzY
         psHoAsxw6uZwEhpYhA4WCn2jgwjRXiOBPv8Oot8sOipqZ4YeGpyEvMCYsx/ql1Y1FZeB
         7TBZxVIGuiaQcTN7AaheiCpaFv58pKRo84M0z4z4WEnuvYx6/qa9iJJsBAO8gTv5WKmu
         AmTIVo6B097Oa3q7sBXl0UCrAQw38kcdEzCK0jfZgoQ9grs1InLMTElgyL24BRauj6Wu
         LMV1rggvkCiP4yPAyP9C/AE6oGBFWtD/DMT9uE6+9evNYHLNOvA+cWcdVdiOHPizDxUM
         Qg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754584537; x=1755189337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtJ7SukZttuLpvU2sM4wbLSaHHmB2xRR25bbI/ADQkc=;
        b=QvsbLnmpJ/cWCZxy3Yms4YH6DhxWv3IYndykhI/dbv6apxddqTPXWBycRCrt2TH8Jv
         eHUkIRllCcZ6koJX4EJ/jOvW1Mj9bfoqytJd7ZiEySIQgKFujoHarvoHIVHwhdyRitJY
         2eOGohfz6vsFnV98f40rdnzBh/AQWQaNWcJLMguKMoL6s2A6T6WYq/y9/UKRXUdsGwxf
         IZqarx+E612F3DhJojV7jLuLgadDqGufutAJL+RFiCpbi9btBRnqPUmtbIE48Li12PZN
         RX/QlS7BukX7dL1tOs0+f2P4Y8ONUuEg+FQRxkDZEqYdrWLBzjpzPtuBT3EkyTyCm5hH
         6D+w==
X-Forwarded-Encrypted: i=1; AJvYcCVOHseCMQ75JiUCHi+A6BpUHdvqzcdwvh/bu/EiUStXFnQj2o5MLyBGW9I+Jbr9pEkb5r2TcRgqkVuOat4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwJ6nUbbgJIrH+PLa9MM0V3D8JSMSIdG2QkmFre43pmSsOih+C
	986fOT/TmTxvtWUBMYD79Yula6XCjL6lTqO+lBaRROGjt/fR0y3KWkCx
X-Gm-Gg: ASbGncvRpJxKvzLJVPrYMxdvcYboHZGH8uzU6undiVu5dH9yl8+nu5f97WIVittMbGQ
	fnSl4OEKHKdQofX3LcmsdgToMhWSFM6XPrRodnXhSFCN0O5U7fMyz9rK/uKVT/Yyma9TtaMYj6J
	Yv5FseJ6VlftZ3s691ER3wtXHDQ+yW9t+Bb1D5i5ct7ypXfRWRWeXTcjMVhyA0FbscA/7AbEvOw
	0qu87ohL8oLMrkS1YO1PXsIwDPR5ATNQ7Vo/QtfuxaG4RaokWpjhCXEBgi223CSv3CfnPaFb7Aq
	nUmYOnr/wU28fYfswVHgSgK4QC0JuiHdRPks2+w6zfca9gPVQiMMV2XdW/NmgJCJLdxxiIwXLws
	HeWd2GfCiXdZBi3N9ij3l7/ii06GqrqajdXMZ4eo=
X-Google-Smtp-Source: AGHT+IHkT64c9OHy2Nzz9XBeldTkqmQHkNU7gSOvuItx5Jn+CKscilRIlUOnQhfn0UMy94ic/YnGvQ==
X-Received: by 2002:a05:6512:3b28:b0:55b:8e2e:8ce4 with SMTP id 2adb3069b0e04-55caf317e7bmr927137e87.5.1754584537230;
        Thu, 07 Aug 2025 09:35:37 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bd4asm2706906e87.11.2025.08.07.09.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 09:35:36 -0700 (PDT)
Message-ID: <69b4f07d-b83d-4ead-b3f1-1e42b2dca9c2@gmail.com>
Date: Thu, 7 Aug 2025 18:34:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>, linux-mm@kvack.org
Cc: glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, akpm@linux-foundation.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org
References: <20250805062333.121553-1-bhe@redhat.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250805062333.121553-1-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/5/25 8:23 AM, Baoquan He wrote:
> Currently only hw_tags mode of kasan can be enabled or disabled with
> kernel parameter kasan=on|off for built kernel. For kasan generic and
> sw_tags mode, there's no way to disable them once kernel is built. 
> This is not convenient sometime, e.g in system kdump is configured.
> When the 1st kernel has KASAN enabled and crash triggered to switch to
> kdump kernel, the generic or sw_tags mode will cost much extra memory
> for kasan shadow while in fact it's meaningless to have kasan in kdump
> kernel.
> 

Ideally this problem should be solved by having kdump kernel with different
config. Because if we want only reliably collect crash dumps, than we probably
don't want other debug features, e.g. like VM_BUG_ON() crashing our kdump kernel.



> So this patchset moves the kasan=on|off out of hw_tags scope and into
> common code to make it visible in generic and sw_tags mode too. Then we
> can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
> kasan.
> 
> Test:
> =====
> I only took test on x86_64 for generic mode, and on arm64 for
> generic, sw_tags and hw_tags mode. All of them works well.
> 
> However when I tested sw_tags on a HPE apollo arm64 machine, it always
> breaks kernel with a KASAN bug. Even w/o this patchset applied, the bug 
> can always be seen too.
> 
> "BUG: KASAN: invalid-access in pcpu_alloc_noprof+0x42c/0x9a8"
> 
> I haven't got root cause of the bug, will report the bug later in
> another thread.
> ====
> 
> Baoquan He (4):
>   mm/kasan: add conditional checks in functions to return directly if
>     kasan is disabled
>   mm/kasan: move kasan= code to common place
>   mm/kasan: don't initialize kasan if it's disabled
>   mm/kasan: make kasan=on|off take effect for all three modes
> 
>  arch/arm/mm/kasan_init.c               |  6 +++++
>  arch/arm64/mm/kasan_init.c             |  7 ++++++
>  arch/loongarch/mm/kasan_init.c         |  5 ++++
>  arch/powerpc/mm/kasan/init_32.c        |  8 +++++-
>  arch/powerpc/mm/kasan/init_book3e_64.c |  6 +++++
>  arch/powerpc/mm/kasan/init_book3s_64.c |  6 +++++
>  arch/riscv/mm/kasan_init.c             |  6 +++++
>  arch/um/kernel/mem.c                   |  6 +++++
>  arch/x86/mm/kasan_init_64.c            |  6 +++++
>  arch/xtensa/mm/kasan_init.c            |  6 +++++
>  include/linux/kasan-enabled.h          | 11 ++------
>  mm/kasan/common.c                      | 27 ++++++++++++++++++++
>  mm/kasan/generic.c                     | 20 +++++++++++++--
>  mm/kasan/hw_tags.c                     | 35 ++------------------------
>  mm/kasan/init.c                        |  6 +++++
>  mm/kasan/quarantine.c                  |  3 +++
>  mm/kasan/shadow.c                      | 23 ++++++++++++++++-
>  mm/kasan/sw_tags.c                     |  9 +++++++
>  18 files changed, 150 insertions(+), 46 deletions(-)
> 


