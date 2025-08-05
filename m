Return-Path: <linux-kernel+bounces-756644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DF8B1B726
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4B4174CF3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8D12798ED;
	Tue,  5 Aug 2025 15:08:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFC8279780
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406513; cv=none; b=agDfTQ5vVQcMblTCVWeBmWGELy6W9SNTEFwhFeg4HT3ZqabU6lXSCR73XZYkW2Ii6cyGLgCf/PAEQBSNWk8Toz5CcTud4BABh3zMbdh22UP0STgwZtrX9wGQWOdPTa6A+5hu4mSQDCSKRjkFwY4/bUg/nlgw9DZMaCNa2Esg2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406513; c=relaxed/simple;
	bh=solg/BAxy0Q7+JjjWzI/VjKXvIKH6hxbQyE0QMr84og=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=fm+OlSsA35/hBF9cbXeNQ3qe2MMPExNYQIAiliVV4EJHZxk1cM4k00hiCPepn0CnliT6dIvmIYO239Si1G7QbRHHMWf8aG8JyOT8uYYKY0DTYZxV3QuUhwEJf5E35+7DxC6wh37yl9SW0GHqHNuKJyPhXijOvzj9emRWVUxRZOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C1652BCE;
	Tue,  5 Aug 2025 08:08:23 -0700 (PDT)
Received: from [10.1.29.177] (e137867.arm.com [10.1.29.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A5AA3F673;
	Tue,  5 Aug 2025 08:08:26 -0700 (PDT)
Message-ID: <6bd09b5b-9830-42b4-ad9e-9ad1e153e564@arm.com>
Date: Tue, 5 Aug 2025 16:08:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v7 0/7] arm64: entry: Convert to generic irq entry
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, sstabellini@kernel.org,
 mark.rutland@arm.com, puranjay@kernel.org, broonie@kernel.org,
 mbenes@suse.cz, ryan.roberts@arm.com, akpm@linux-foundation.org,
 chenl311@chinatelecom.cn, anshuman.khandual@arm.com,
 kristina.martsenko@arm.com, liaochang1@huawei.com, ardb@kernel.org,
 leitao@debian.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <20250729015456.3411143-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jinjie,

On 29/07/2025 02:54, Jinjie Ruan wrote:

> Since commit a70e9f647f50 ("entry: Split generic entry into generic
> exception and syscall entry") split the generic entry into generic irq
> entry and generic syscall entry, it is time to convert arm64 to use
> the generic irq entry. And ARM64 will be completely converted to generic
> entry in the upcoming patch series.
Note : I had to manually cherry-pick a70e9f647f50 when pulling the series
on top of the Linux Arm Kernel for-next/core branch, but there might be
something I'm missing here.
>
> The main convert steps are as follows:
> - Split generic entry into generic irq entry and generic syscall to
>    make the single patch more concentrated in switching to one thing.
> - Make arm64 easier to use irqentry_enter/exit().
> - Make arm64 closer to the PREEMPT_DYNAMIC code of generic entry.
> - Switch to generic irq entry.

I reviewed the whole series and as expected it looks good ! Just a few nits
here and there and some clarifications that I think could be useful.

I'm not sure about the generic implementation of 
`arch_irqentry_exit_need_resched()`
in patch 5, I would be tempted to move it to patch 7. I detail my 
thoughts more
on the relevant patches, but I might be wrong and that feels like details :
I don't think the code itself has issues.
> It was tested ok with following test cases on QEMU virt platform:
>   - Perf tests.
>   - Different `dynamic preempt` mode switch.
>   - Pseudo NMI tests.
>   - Stress-ng CPU stress test.
>   - MTE test case in Documentation/arch/arm64/memory-tagging-extension.rst
>     and all test cases in tools/testing/selftests/arm64/mte/*.
>
> The test QEMU configuration is as follows:
>
> 	qemu-system-aarch64 \
> 		-M virt,gic-version=3,virtualization=on,mte=on \
> 		-cpu max,pauth-impdef=on \
> 		-kernel Image \
> 		-smp 8,sockets=1,cores=4,threads=2 \
> 		-m 512m \
> 		-nographic \
> 		-no-reboot \
> 		-device virtio-rng-pci \
> 		-append "root=/dev/vda rw console=ttyAMA0 kgdboc=ttyAMA0,115200 \
> 			earlycon preempt=voluntary irqchip.gicv3_pseudo_nmi=1" \
> 		-drive if=none,file=images/rootfs.ext4,format=raw,id=hd0 \
> 		-device virtio-blk-device,drive=hd0 \
>
I'll spend some time testing the series now, specifically given patch 6's
changes, but other than that everything I saw made sense and didn't look
like it would be of concern to me.

Thanks,
Ada

