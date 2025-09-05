Return-Path: <linux-kernel+bounces-803070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BBCB45A2B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F393AF36A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B9C36808F;
	Fri,  5 Sep 2025 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZO6Zk1Qx"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3A4362061
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757081578; cv=none; b=r9hclGwyGSYkK+kWaQVmY3UNA4iNGkdiJ6CGHenN70rR+hZPxM7SCVnRMP3IMGJoE9jRYALXXF46Bvqz39zUklx+MGSDNbp4IMJ3+E2t7nI1CRlL65llfoVq+2EpgxNv2B5tW9cPqCU4PYniFU/MknLSVMmbwPlpF+rusAZ/dso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757081578; c=relaxed/simple;
	bh=K+/vJ1tGgqKgyQZv1jVkzBjgkemzM7IqP/9bVzcLYD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGSweBDX3a/LFmd0HmoTYvqKF4V50lj4MPHrLVoGtxM3B+c4Ws0Ozy2+oZVVz+piZm+SxDNCTfyNHlPO0qtc1AC9Cs2oQ3tm7IsSkPcL44Eet2iXpz0ly+h7z+w+qSJ6S1DxKj+H1Q22qJkLP29ig4VN9HizGC+xn2sm2a5Bw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZO6Zk1Qx; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55ce5221f0bso372251e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757081575; x=1757686375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNIM8R1x/7yzpF+VhHfpd33myaTbFu2Eq9aory2fbt8=;
        b=ZO6Zk1QxwLEBgBncwctxUzew2hze29Nn0CZhPrqKnBfQ9O6ygelBWx8w3p08NHRL2f
         ctV6pY4N1oGCLX94Bbb80t32f+BpiAbimVEZIDDf+qr5g5cmB+c0EccyHHOjkxhCpysc
         hYxSsMRxSbJHmV2resIFaRGcZSgr2V/afNmfrQpDWzfArv3FPwhmkNE/LIbzkLlRQebF
         4Q4yjbv62xB/wgPWtB6Qm3YVt4mPIFnSIRLkCj6VuCrlocZuIFQcBQgQfyooe6m4Now2
         DnumdnPOhEvQ5+DPxcL8Wz2TMssorQpy0ips55z499sfqQqzLKXU8M+QD+mxlLQ0FfUN
         duZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757081575; x=1757686375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNIM8R1x/7yzpF+VhHfpd33myaTbFu2Eq9aory2fbt8=;
        b=UwIQvGgIvOULVJ2i/qcoYyBrkGeJ6Kb2yxSaWarosOt2bwb9UciN5a4qYrDIfmMNiL
         gnD2tInenM9WKvH453fu9A3gY6U39bcpsHC7Gly8zCFSa+RlA0+AtGtfbJQKPSH7w/ic
         pXPBSHzs937n0Vuw2ZfEzxmxEzydSeiDF0QEcM7mrloLPVfao3BcviCJqLQI2EL/zZSU
         JRz+Ew1gawkUdlvLGuBRpmNvglOH7R6aFioyFOwU4mGNJ3tKvR5UP5On1clHT3R0wdYO
         TGXQrJG3fZGbRiiW9TBhq5pLL5FBpA4s+XaWoEvb4YKBPav4bRkUSz/EeqA17ZzAwrnQ
         mNBw==
X-Forwarded-Encrypted: i=1; AJvYcCUPLW1YQWi2S74qroFwizf/ywzT1R31ftxWJZwVMx1py/y7bz6cZYMTsHrrKMV3aXWM5cpKQI3+2mMOt30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPCzWPG0RNf+DoXeA+/TwN1gvUyciZ70Eg938LQqDAenC2wu2R
	My32nXkK8/7c7Jaf+xbRTCfLev5k0o+7AKM/Rjh0NOQEIb8qKWmeAjMb
X-Gm-Gg: ASbGnctkzsezljyeCqaEUYBQxOJ4METAaeBWPjuF+4DsDYY3JctNPsJjfFxsU043oit
	QvO3kmYhFgH7cMDCprSrR60pkFeXTxI5rXaGX4e6m9FGNbfEAFCFyn639wdS7syDdXt/qfwoVsz
	fEKq8QVUiuWKhGB95QOVqlMWOId0LJYyzyYzMOS2kyA+sWNa8KoNb9dfRxt5ABq/l8zRY/YnWWh
	SpVcZtGRkBPf1aji1TnJdbE4a1AsbKf8qgPyjPovjynVL6Z9hjBscQFpGfjSPH7M3swVl0dvVno
	AhgaxPWf2OeFnZ+Y8hKurTglEdP1spqBZ+ztG3RrHXgcBHbk0Pe9EOLVAnRIvyT5ZT/5DclVdJ/
	MR447QBU9veyKkuyA7bnbLvhKVpI50Lw7tZxtYwA=
X-Google-Smtp-Source: AGHT+IEfNTI/6WSD3WRB8RpqbaQVi4CaDeSa7b+YRq4kEmhqfw9wFx/wZI/iLKEByvwhvIhqmPVoUQ==
X-Received: by 2002:a2e:96c1:0:b0:32f:3e83:4389 with SMTP id 38308e7fff4ca-336be137752mr29425441fa.7.1757081574352;
        Fri, 05 Sep 2025 07:12:54 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4cb9b5esm19558321fa.28.2025.09.05.07.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:12:53 -0700 (PDT)
Message-ID: <1c54cadb-36e7-4e72-83e9-53c597570c9b@gmail.com>
Date: Fri, 5 Sep 2025 16:12:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3] x86/dumpstack: Prevent KASAN false positive
 warnings in __show_regs
To: Tengda Wu <wutengda@huaweicloud.com>, x86@kernel.org,
 jpoimboe@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20250830092556.3360776-1-wutengda@huaweicloud.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250830092556.3360776-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/30/25 11:25 AM, Tengda Wu wrote:
> When task A walks task B's stack without suspending it, the continuous
> changes in task B's stack (and corresponding KASAN shadow tags) may cause
> task A to hit KASAN redzones when accessing obsolete values on the stack,
> resulting in false positive reports. [1][2]
> 
> The specific issue occurs as follows:
> 
> Task A (walk other tasks' stacks)           Task B (running)
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
> `task != current` during unwinding, and disabling KASAN checks when this
> scenario occurs.
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

