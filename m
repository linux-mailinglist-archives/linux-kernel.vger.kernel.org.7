Return-Path: <linux-kernel+bounces-792025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69710B3BF9F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83813B61EA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB6B334380;
	Fri, 29 Aug 2025 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9x5yifM"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8EC33439B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481825; cv=none; b=NDLKtnJBWZy6/soRkaEVpmGVuXglcAD3mouFww77wjF4IRA7mQFAlhaC27oDj8Er3dDaCyxEdDPAFzXneN428x0O3eCiO8Yw0ke2txdZpECYV6jp+bFfVfmysyOCEYXbybv1eQy7SSp6bIXPD5oh6Zyj/igc8V1Ha4l7YJCyurA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481825; c=relaxed/simple;
	bh=jjBQZYSgkeUve3l/0TMHfpFCEtj/TAvAXdiNNzzaTfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqcm1dRsqNube5M+BaMvvDcmt1MOVFZ0osAtqJBxAfgQedPMrje3qNkWKZmare3U2l1ME1OVL2tDOAk/tOUAGTWBONB/E1TLWiqCsmduVHxUQj+GzLt+kFJmo9JILNnVTZ5g3LD04EYknHcQ3D4EUjjYOZDSflTBzPoVzqrdoM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9x5yifM; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-333f8d25d33so1126631fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756481821; x=1757086621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+hd98U0ZthF5f+8G7o1tfOg/zgJ0QFCkx1D/PZTvig=;
        b=D9x5yifMHoSHcx59EMmEOXMccLgOA/dQUiae40t4QdF++snbYiCMEtGbNZGEU5hJNm
         GwGhzvpN8RfyfKSl5wHqEi+woADwwymNtcNEw3p1/cl3iz7yd2MI3bIXOc9cmbsTBnwC
         11e4s8l6JSPo7sTntBGZzuwcerpGOH7sWg6j/r2Okrv/1wCnPgrYiDJf0QiX1IZKX9tD
         BD5WKM62dUtF0PzZuhGLx6xGmUsRv6KC7qHJZdTVrot3KOSxCniO20IRTzKc8LyXQUVo
         ogzZMULJa6MnwW3ukKImjEadnizUglo5748Nnby9ZkEeVI3oz9st5dnhlwq4ilbCw4/L
         t5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756481821; x=1757086621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+hd98U0ZthF5f+8G7o1tfOg/zgJ0QFCkx1D/PZTvig=;
        b=Ea8QBdy94zSXL1gbZtJcPzwawSq05TTE4jh5OIt0mdcV5hvETcMTNwvpc0ZvUn/IlI
         +x+a5FBQgY+zTqcX7HjcG8IIzlw+tD9RdpBs5BTvhCGPp4GSZ6hus4out5ddBYXSgnrR
         NZzy0MYnDGtQ+H5qntU/Wn53AzUpQUGp06GfYnzwGgyHL38asRdCdyw82hm7aFhj8P91
         1fZSYW7gk9xjLJ9rtmNznrB53FajtQswzCk/5tpQCKUNBjEdOTilzeUQGzUmGEQ2gGR7
         GvW7ENEmfWRonHKhwtuFgM2BaBOnGjgFd4bFLUlQVVVpEEnxf7l5ACHLbnjqHmz43Ki8
         q9OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGyyYhvp+ptOC3otbo7XnVOwzJ0zpbRUMcUV0f/Hyc3KslwdV1taxXiTtALztavaPZyFGLG1YX/WtcKiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCAj4VzQ7R5MUweu2hPnzlvLmJyjeCQYLCZPyMTpAtf6fluVMj
	qfEneFUNFh4lZI2dU2xI8XU0w8+DzfnHf4whxAzfJcaEdznmD3xmP4tr
X-Gm-Gg: ASbGncs6S3gS5tqc8VV6GuHd9S2VmySzIfUKVO1JwPSNEdHq+OD3qfDCesq+jREqOL2
	ALpV5A+T1f5g93vTpKaRH3rlZJrltkv6Ge4xId6M/ptS5uWFAMule4rrSdr7DGG9MCxpTiOZ40I
	GziQb4ffdI+VtWI+rP/r7fATBUEvSVANBKHNhiab4yuFIZ7Pz7L2G2OIPqVcUFa86ezHzcdQOhJ
	3oJUgoeQIrZBzTo3VZG7COsBMzzB+HUGWStK6MuMwoqQfmEHwUB7bQpuKC2a22RRuqKUGXtZ+gm
	QBdkm2CQBGHPn9TAhI5dKcURi188XR6QOiqK0z4Y2OazENttR7UwcEi8CPylcDBw9Oy+i0QbVws
	4Blx/3WyowfO9hpU32zXQ3AC3hkNievvA7c+33z0eWaNWVr2nRg==
X-Google-Smtp-Source: AGHT+IGnyZpNXR77p2K2UXxMNlUXrsqMoljf+XvMFuWqkCoBxLSRe8NNaUUErIGafJP6y1/K6iCiDQ==
X-Received: by 2002:ac2:5685:0:b0:55f:4527:1035 with SMTP id 2adb3069b0e04-55f68cc39b1mr429628e87.10.1756481820835;
        Fri, 29 Aug 2025 08:37:00 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f6784540bsm711241e87.69.2025.08.29.08.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 08:36:59 -0700 (PDT)
Message-ID: <3c595fec-ab8d-4b96-af19-2877c8afca9b@gmail.com>
Date: Fri, 29 Aug 2025 17:36:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] x86: Prevent KASAN false positive warnings in
 __show_regs
To: Tengda Wu <wutengda@huaweicloud.com>, x86@kernel.org,
 jpoimboe@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20250829094744.3133324-1-wutengda@huaweicloud.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250829094744.3133324-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/29/25 11:47 AM, Tengda Wu wrote:
> When task A walks task B's stack without suspending it, the continuous
> changes in task B's stack (and corresponding KASAN shadow tags) may cause
> task A to hit KASAN redzones when accessing obsolete `regs->` contents,
> resulting in false positive reports. [1][2]
> 
> The specific issue occurs as follows:
> 
> Task A (walk other task's stack)            Task B (running)
> 1. echo t > /proc/sysrq-trigger
> 
> show_trace_log_lvl
>   regs = unwind_get_entry_regs()
>   show_regs_if_on_stack(regs)
>                                             2. The stack data pointed by
>                                                `regs` keeps changing, and
>                                                so are the tags in its
>                                                KASAN shadow region.
>     __show_regs(regs)
>       regs->ax, regs->bx, ...
>         3. hit KASAN redzones, OOB
> 
> Fix this by detecting asynchronous stack unwinding scenarios through
> checking whether the `regs` are located in the current task's stack
> during unwinding, and disabling KASAN checks when this scenario occurs.
> 
> [1] https://lore.kernel.org/all/000000000000cb8e3a05c4ed84bb@google.com/
> [2] KASAN out-of-bounds:
> [332706.552324] BUG: KASAN: out-of-bounds in __show_regs+0x4b/0x340
> [332706.552433] Read of size 8 at addr ffff88d24999fb20 by task sysrq_t_test.sh/3977032
> [332706.552562]
> [332706.552652] CPU: 36 PID: 3977032 Comm: sysrq_t_test.sh Kdump: loaded Not tainted 6.6.0+ #20
> [332706.552783] Hardware name: Huawei RH2288H V3/BC11HGSA0, BIOS 3.35 10/20/2016
> [332706.552906] Call Trace:
> [332706.552998]  <TASK>
> [332706.553089]  dump_stack_lvl+0x32/0x50
> [332706.553193]  print_address_description.constprop.0+0x6b/0x3d0
> [332706.553303]  print_report+0xbe/0x280
> [332706.553409]  ? __virt_addr_valid+0xed/0x160
> [332706.553512]  ? __show_regs+0x4b/0x340
> [332706.553612]  kasan_report+0xa8/0xe0
> [332706.553716]  ? __show_regs+0x4b/0x340
> [332706.553816]  ? asm_exc_page_fault+0x22/0x30
> [332706.553919]  __show_regs+0x4b/0x340
> [332706.554021]  ? asm_exc_page_fault+0x22/0x30
> [332706.554123]  show_trace_log_lvl+0x274/0x3b0
> [332706.554229]  ? load_elf_binary+0xf6e/0x1610
> [332706.554330]  ? rep_stos_alternative+0x40/0x80
> [332706.554439]  sched_show_task+0x211/0x290
> [332706.554544]  ? __pfx_sched_show_task+0x10/0x10
> [332706.554648]  ? _find_next_bit+0x6/0xc0
> [332706.554749]  ? _find_next_bit+0x37/0xc0
> [332706.554852]  show_state_filter+0x72/0x130
> [332706.554956]  sysrq_handle_showstate+0x7/0x10
> [332706.555062]  __handle_sysrq+0x146/0x2d0
> [332706.555165]  write_sysrq_trigger+0x2f/0x50
> [332706.555270]  proc_reg_write+0xdd/0x140
> [332706.555372]  vfs_write+0x1ff/0x5f0
> [332706.555474]  ? __pfx_vfs_write+0x10/0x10
> [332706.555576]  ? __pfx___handle_mm_fault+0x10/0x10
> [332706.555682]  ? __fget_light+0x99/0xf0
> [332706.555785]  ksys_write+0xb8/0x150
> [332706.555887]  ? __pfx_ksys_write+0x10/0x10
> [332706.555989]  ? ktime_get_coarse_real_ts64+0x4e/0x70
> [332706.556094]  do_syscall_64+0x55/0x100
> [332706.556196]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> Fixes: 3b3fa11bc700 ("x86/dumpstack: Print any pt_regs found on the stack")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>

