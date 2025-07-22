Return-Path: <linux-kernel+bounces-740055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E9DB0CF1D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79A23ACD35
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240EE1A3178;
	Tue, 22 Jul 2025 01:33:51 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0272557C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148030; cv=none; b=te9qEW72Wr5wLDOC/Hhs4BgoB38xRNWcOGpVylKLxtLKt/HsnGVcNBGP6bDFq5/YeMzOeiE66Bkrk08+ncZX/kxbQJeMz3kIKTSfMzkfBblPaLZwLmfLV3RfQVj6V3psXvQmZUYE1ZARvm+3i6Cwa+Ak03JQZ78uzZTzN/Ppqlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148030; c=relaxed/simple;
	bh=wp8zq+CwqXM4wW1l/Z2citGvtshsWLFeNika/T5VD7M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=odlEss6fZ8DZidskBCJIehD7H4F1Os/HSK2dYGfASuZkaeiQT28ZBrsXyuiVElZjWldKXvQUk7RUiCScP/HYdpQATPiKbaX20fkWanD8cbX9A0uOslEuPU7Pb6wfoClFOQz3IdSVfv1GyD++Xyokzj84hHlj/B86nrtffD0sUuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxrnJu6n5o0kQvAQ--.31464S3;
	Tue, 22 Jul 2025 09:33:34 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxpeRm6n5oHzQhAA--.42270S3;
	Tue, 22 Jul 2025 09:33:28 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: Implement physical address with ELF program
 header
To: kernel test robot <lkp@intel.com>, Huacai Chen <chenhuacai@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250721091248.3896152-1-maobibo@loongson.cn>
 <202507220309.mDl9W32Y-lkp@intel.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <7a5789f1-d6a5-3892-98c1-2c4b8515459d@loongson.cn>
Date: Tue, 22 Jul 2025 09:31:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202507220309.mDl9W32Y-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpeRm6n5oHzQhAA--.42270S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFyktw13Xw4fKr1DKrykJFc_yoW5KryUpr
	n5A3yqqr4jgr93Xw1DKF9ag34qqrnxWr42qa45J3Z3CFy7XF1jv3s7Cr9rWa42q34UKa10
	gFyrGayjya4UG3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOa93UUU
	UU=

Oops, it is the obvious compile issue. And I am messed with parallel 
tasks and do not notice this, what I test is old kernel.

Regards
Bibo Mao

On 2025/7/22 上午3:19, kernel test robot wrote:
> Hi Bibo,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 89be9a83ccf1f88522317ce02f854f30d6115c41]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Bibo-Mao/LoongArch-Implement-physical-address-with-ELF-program-header/20250721-171418
> base:   89be9a83ccf1f88522317ce02f854f30d6115c41
> patch link:    https://lore.kernel.org/r/20250721091248.3896152-1-maobibo%40loongson.cn
> patch subject: [PATCH v2] LoongArch: Implement physical address with ELF program header
> config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20250722/202507220309.mDl9W32Y-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 853c343b45b3e83cc5eeef5a52fc8cc9d8a09252)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250722/202507220309.mDl9W32Y-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507220309.mDl9W32Y-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:15: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:18: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:33: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:34: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:41: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:46: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:47: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:50: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not found: PHYS_OFFSET
>     ld.lld: error: too many errors emitted, stopping now (use --error-limit=0 to see all errors)
> 


