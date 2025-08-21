Return-Path: <linux-kernel+bounces-780295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D783B30003
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131C9AA1FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892AB2DCF71;
	Thu, 21 Aug 2025 16:25:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3B8278751
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793509; cv=none; b=uCdwmo8gYL45x6zVeiYmIJsdswJHMvIQq9kEL+r1FeZaO7mITbQtd/UiWNBWnl/aUWyFdRDPEQGbZMtt4brGwuUX8zADfdRIp3lx69LIGCVl/YfC+z/4JVYscMFjetelcLd3BLSIr0I4zljxNu4HLIX/Y+5xK3g8qLPoiUN+SEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793509; c=relaxed/simple;
	bh=yGyRPfvYefcbeJNvmIgvH/VKwYaQH352R46xGhnmBgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=chAnokTcuMrwxzi6HYS9kPfLH6wU7kR9HSqubytTu9QLyBc8boZlmujUCAIxPPt9QZVt1E1K1gCYXjQZeWD/wnilHyegHJXBP9LbJQ/cR+Q74t3z9TW90Gtp4NCN985ZKV6b//VXXmrOyZl25wh8b973+brqnQSKkTKB15eTwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85839152B;
	Thu, 21 Aug 2025 09:24:58 -0700 (PDT)
Received: from [10.57.1.220] (unknown [10.57.1.220])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D68F3F738;
	Thu, 21 Aug 2025 09:25:03 -0700 (PDT)
Message-ID: <e412cd01-cf76-4486-a475-74b255aff4ab@arm.com>
Date: Thu, 21 Aug 2025 17:25:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/8] arm64: entry: Refactor preempt_schedule_irq()
 check code
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20250815030633.448613-1-ruanjinjie@huawei.com>
 <20250815030633.448613-7-ruanjinjie@huawei.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
 sstabellini@kernel.org, mark.rutland@arm.com, mbenes@suse.cz,
 broonie@kernel.org, anshuman.khandual@arm.com, ryan.roberts@arm.com,
 chenl311@chinatelecom.cn, liaochang1@huawei.com, kristina.martsenko@arm.com,
 leitao@debian.org, ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <20250815030633.448613-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 15/08/2025 04:06, Jinjie Ruan wrote:
> To align the structure of the code with irqentry_exit_cond_resched()
> from the generic entry code, hoist the need_irq_preemption()
> and IS_ENABLED() check earlier. And different preemption check functions
> are defined based on whether dynamic preemption is enabled.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---

That looks good to me as well, thanks for the changes !
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>


