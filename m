Return-Path: <linux-kernel+bounces-752135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73662B171A5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E80C1AA37FB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C410A2C1595;
	Thu, 31 Jul 2025 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xr+ARsGs"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749912C158D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966789; cv=none; b=lz4FWya72HO9VG6kOz3SJ37ppVQnhYJykVBulXiiPB81eN6gUK8CcMq4UVgnSFNvHq1jjD0kt3ju7VHCjUWO05wBo7ZhkSRCtCHwN8c9OHpwFN4u5WQuYIndcpP6O/7s1fo/ZgH2K/lqROsygaPg+G+iwxBqsPsh2dpQMPD506k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966789; c=relaxed/simple;
	bh=OlwkJhUnVJSu0YQjxc1gQQ/f9ockLl7IL62ObEbC2yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=YcqMFmqTegmUBYIWiU82zjMCX51HVXpm96+Sy535zx/STLh/TNsEQ6KA4Un/6F78h71XI+pr7mEq01LKZPG4AYUwdOagOrW+GHblbf5IBHyUd1CHfqOfML7wmrsulG9nLvo8h1f0NV7sAabu7XGD+AXocni0iTBESsDrNrgVz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xr+ARsGs; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4a807c89-d57b-463a-9166-836301ee9947@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753966774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NH9FRiynBWmz+TuFtsldRHKl2P9Mf6GV3/ecDf9SulU=;
	b=xr+ARsGs90n+e4EJB2/aZZS3nAn0zrVWNbDfG6INi30wDzIw055GiHjsWFEJByRMfgqySw
	da8aMglDu+wCSn2Bv1HgLAb6f70bUY5JjTm/PYR2HWwdzlxONXV81GGWPL0a3LZ7gCM9M9
	AT7dE1spfAR2xHi8+H8xZxDcABzdCOU=
Date: Thu, 31 Jul 2025 20:58:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] KVM: arm64: Dump instruction on hyp panic
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>
References: <20250717234744.2254371-1-smostafa@google.com>
 <20250717234744.2254371-2-smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <20250717234744.2254371-2-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Mostafa,
On 2025/7/18 07:47, Mostafa Saleh wrote:

... ....

> +	/* Dump the faulting instruction */
> +	if (!is_protected_kvm_enabled() ||
> +	    IS_ENABLED(CONFIG_NVHE_EL2_DEBUG))
> +		dump_instr(panic_addr + kaslr_offset());
> +
This part seem like unnecessary, cause it'll be remove in patch 2(Only 
the comment left).

>   	/*
>   	 * Hyp has panicked and we're going to handle that by panicking the
>   	 * kernel. The kernel offset will be revealed in the panic so we're
Another confusion is that no similar wording to what you mentioned in 
the cover—specifically "Cannot dump pKVM nVHE stacktrace: 
!CONFIG_PROTECTED_NVHE_STACKTRACE"—has been found in the code.


-- 
Thanks,
        Kunwu Chan.


