Return-Path: <linux-kernel+bounces-846317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A42BC78D9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA6784F3376
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111FF26056C;
	Thu,  9 Oct 2025 06:32:18 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2525D1F7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759991537; cv=none; b=a2JPpQRcLzuAKM2M88/HkrFjsWtpfDnNPfa/bTYcO7K4iyaeuwS1mM9qVbiqb2DOB0deQ0x/ySH4X3FhtfzvE9J38oteUkieWrFmEy9fBKMYZxgXT9u2QTI4yWFi1uZV2Cj4nBzhvh9qmRAw7mdy9MG76VpEDvOTmrMBxwZrOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759991537; c=relaxed/simple;
	bh=IML62ClVT6Rt2e1eihBPJapmh60l8uz4y0+fqdIvsBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsgvpgUWUDsDNYDRdOiZhw6maba0V815NuCaQAAtFKBig6dTAw6liqBrQXTbyt1PD9+PPwfyBWWfeHYjt9D9GJQG2GNyv1S3Vpd+I5sDD+8xp/WgrmPLPgIJLpEOO1u/tpu4rFFXX5lnb5kp8Sre4u1g797v5mu4XrcEVdHDX9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.108] (unknown [114.241.81.247])
	by APP-01 (Coremail) with SMTP id qwCowACnAaTKVudoKMsxDQ--.10853S2;
	Thu, 09 Oct 2025 14:31:39 +0800 (CST)
Message-ID: <4de90ac7-f05d-4c16-a5c5-8101f5d2fe91@iscas.ac.cn>
Date: Thu, 9 Oct 2025 14:31:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Prevent early kernel panic in instrumented
 apply_early_boot_alternatives
To: Paul Walmsley <pjw@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 duchangbin <changbin.du@huawei.com>, Alexandre Ghiti <alex@ghiti.fr>,
 andybnac@gmail.com
References: <20250624113042.2123140-1-changbin.du@huawei.com>
 <a89f5970-5ea9-4d92-8952-6c26a22ac153@ghiti.fr>
 <d41d9c7a103f4600a4fc5beea77e0f4e@huawei.com>
 <2396743a-480e-2ab3-f7fe-569d8f2adfcf@kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <2396743a-480e-2ab3-f7fe-569d8f2adfcf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnAaTKVudoKMsxDQ--.10853S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYo7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj
	6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr
	1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAa
	Y2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4
	A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY
	0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07j189NUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 10/9/25 10:01, Paul Walmsley wrote:
> Hi Alex, duchangbin, Andy,
>
> On Wed, 25 Jun 2025, duchangbin wrote:
>
> [...]
>
> Working on cleaning out Patchwork.  Was there any further conclusion 
> reached on this patch, or more broadly, static ftrace ?

Static ftrace for riscv is no longer supported in 6.17. config RISCV is now:

    select DYNAMIC_FTRACE if FUNCTION_TRACER

Since commit 5874ca4c6280 ("riscv: Stop supporting static ftrace"). This
patch should be obsolete.

Vivian "dramforever" Wang


