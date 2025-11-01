Return-Path: <linux-kernel+bounces-881537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484E9C286C5
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 20:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F6C3B5F6D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 19:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625FF3019B8;
	Sat,  1 Nov 2025 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bt6NhuXw"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC42FB620
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026384; cv=none; b=lIkn5+4HhRkL2xkg03r8NUQKDLhIjMfYDuSs6kukH3ADK+AgMxFEf2V+T09FGeFLU0DWRzY6wECRNmlAyo59oPTaGx6cNzVRsif05xTyCHdqBBRjeZJOCiD8NU5GPVujnN2QtX4gvuGwgqoEtjudnumYrflTUPRXIiy44cBGu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026384; c=relaxed/simple;
	bh=ya9HLn9UBkGfXOMBjOZnSUdvjJGss6zEIROPu9RJexs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fw0VNaoNQyLfDqqn7ZSd/yzqAlNo8dl+ZoQ7PQBP3mRwUsJgZGBKXhRJx4+5+ykFFs1P0IWVjMYS0hvPqNHpf/nSyt8vyKZ0GjCpdguXlIeHhMrYx5eutkoWlnZ6sL9ilSErwX6QGh2KsxrCI6aWxgyj/oSvaM0rKQYPkZbmgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bt6NhuXw; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <57bbade3-0707-4045-b39b-2053434b0b7c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762026370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSk/sZRQi90GHI3IILQtj3YgPAQn3xbHNm/4+VGi7to=;
	b=bt6NhuXwWlyIZUWEiIsROrc2jyonkIZX/DOSReszd9+6z1Nhl2up7ZnTMedodcIqC9ozwX
	W6aLNMDub//7cjEzYGIR3b7lj/p/0Mp4ex4mSvTR50MifJPiYezgJYuplEidrWU1FkCTxz
	qJsT50eEfIWOMW9JdydU/DYe9lZNic8=
Date: Sat, 1 Nov 2025 12:45:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 9/9] liveupdate: kho: Use %pe format specifier for
 error pointer printing
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
 brauner@kernel.org, corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
 pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-10-pasha.tatashin@soleen.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251101142325.1326536-10-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/11/1 7:23, Pasha Tatashin 写道:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> Make pr_xxx() call to use the %pe format specifier instead of %d.
> The %pe specifier prints a symbolic error string (e.g., -ENOMEM,
> -EINVAL) when given an error pointer created with ERR_PTR(err).
>
> This change enhances the clarity and diagnostic value of the error
> message by showing a descriptive error name rather than a numeric
> error code.
>
> Note, that some err are still printed by value, as those errors
> might come from libfdt and not regular errnos.
>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Appreciate your help, Pasha

Yanjun.Zhu

> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>   kernel/liveupdate/kexec_handover.c         |  4 ++--
>   kernel/liveupdate/kexec_handover_debugfs.c | 10 ++++++----
>   2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index be945c133a2f..167c761988d3 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1448,8 +1448,8 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>   		memblock_add(area->addr, size);
>   		err = memblock_mark_kho_scratch(area->addr, size);
>   		if (WARN_ON(err)) {
> -			pr_warn("failed to mark the scratch region 0x%pa+0x%pa: %d",
> -				&area->addr, &size, err);
> +			pr_warn("failed to mark the scratch region 0x%pa+0x%pa: %pe",
> +				&area->addr, &size, ERR_PTR(err));
>   			goto out;
>   		}
>   		pr_debug("Marked 0x%pa+0x%pa as scratch", &area->addr, &size);
> diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
> index 46e9e6c0791f..ac739d25094d 100644
> --- a/kernel/liveupdate/kexec_handover_debugfs.c
> +++ b/kernel/liveupdate/kexec_handover_debugfs.c
> @@ -150,8 +150,8 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
>   		err = __kho_debugfs_fdt_add(&dbg->fdt_list, sub_fdt_dir, name,
>   					    phys_to_virt(*fdt_phys));
>   		if (err) {
> -			pr_warn("failed to add fdt %s to debugfs: %d\n", name,
> -				err);
> +			pr_warn("failed to add fdt %s to debugfs: %pe\n", name,
> +				ERR_PTR(err));
>   			continue;
>   		}
>   	}
> @@ -168,8 +168,10 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
>   	 * reviving state from KHO and setting up KHO for the next
>   	 * kexec.
>   	 */
> -	if (err)
> -		pr_err("failed exposing handover FDT in debugfs: %d\n", err);
> +	if (err) {
> +		pr_err("failed exposing handover FDT in debugfs: %pe\n",
> +		       ERR_PTR(err));
> +	}
>   }
>   
>   __init int kho_out_debugfs_init(struct kho_debugfs *dbg)

-- 
Best Regards,
Yanjun.Zhu


