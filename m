Return-Path: <linux-kernel+bounces-786831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7EFB36B21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B06034E2C59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4174352FF0;
	Tue, 26 Aug 2025 14:40:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EE7352FFC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219229; cv=none; b=BCfqT9zZ0HcnD2qpd5EwCxqZiNknTdob2B3FOy5X8m6XTgSanqDhxixtnvldKJmsj/HRU1h8HzYhgoVKwaBL+nPUXa38VpAJwV91+XNgDiJDoGkX8kAcg4GSuJDTDZ/74Ay9Uziywx5gehDVe5vkzbxI+IFXcuhnjtdhkjewANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219229; c=relaxed/simple;
	bh=kSe13fwo97E00gcXuKHBNqwQgjC0TaeIYw3hj9qfT/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al0Gp5oJSpW9BdTCohCQTanf7BxXrkCgjALYsp2I9WQVJ98z4dwcwKi2kgx1/6bNkRzS0/krEZW3XUs4UAGmc5UK/QLjSsWu+AhD0T2EEHwzExhQbiagZEgiymL109jheyMvValgQ1vdAnysX0/jaosIFEpObU1azbuhR9Bfeiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D29D169E;
	Tue, 26 Aug 2025 07:40:18 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD3203F694;
	Tue, 26 Aug 2025 07:40:24 -0700 (PDT)
Date: Tue, 26 Aug 2025 15:40:22 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bhe@redhat.com, oxu@redhat.com, berrange@redhat.com,
	kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] arm64: kexec: Initialize kexec_buf struct in image_load()
Message-ID: <aK3HVqt6I5KxoHia@J2N7QTR9R3>
References: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-akpm-v1-1-3c831f0e3799@debian.org>

On Tue, Aug 26, 2025 at 05:08:51AM -0700, Breno Leitao wrote:
> The kexec_buf structure was previously declared without initialization
> in image_load(). This led to a UBSAN warning when the structure was
> expanded and uninitialized fields were accessed [1].

Just to check my understanding, is that only a problem for new fields
(e.g. the 'random' field added in [1]), or do we have UBSAN warnigns for
any existing fields? I assume there's no problem with existing fields
today.

> Zero-initializing kexec_buf at declaration ensures all fields are
> cleanly set, preventing future instances of uninitialized memory being
> used.
> 
> Andrew Morton suggested that this function is only called 3x a week[2],
> thus, the memset() cost is inexpressive.
> 
> Link: https://lore.kernel.org/all/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3/ [1]
> Link: https://lore.kernel.org/all/20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org/ [2]
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

This looks fine to me, but I reckon it should be added to the series
which extends kexec_buf, unless there's some reason to avoid that?

> ---
>  arch/arm64/kernel/kexec_image.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

IIUC arch/arm64/kernel/machine_kexec_file.c would need the same
treatment in load_other_segments().

If other architectures need this, it'd probably make sense to clean that
up treewide in one go. It looks like at least riscv and s390 need that
from a quick grep:

| [mark@lakrids:~/src/linux]% git grep -w 'struct kexec_buf .*;'
| arch/arm64/kernel/kexec_image.c:        struct kexec_buf kbuf;
| arch/arm64/kernel/machine_kexec_file.c: struct kexec_buf kbuf;
| arch/powerpc/include/asm/kexec.h:int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
| arch/powerpc/include/asm/kexec.h:                                 struct kexec_buf *kbuf);
| arch/riscv/kernel/elf_kexec.c:  struct kexec_buf kbuf;
| arch/riscv/kernel/elf_kexec.c:  struct kexec_buf kbuf;
| arch/riscv/kernel/elf_kexec.c:  struct kexec_buf kbuf;
| arch/s390/kernel/kexec_elf.c:   struct kexec_buf buf;
| arch/s390/kernel/kexec_image.c: struct kexec_buf buf;
| arch/s390/kernel/machine_kexec_file.c:  struct kexec_buf buf;
| arch/s390/kernel/machine_kexec_file.c:  struct kexec_buf buf;
| arch/s390/kernel/machine_kexec_file.c:  struct kexec_buf buf;
| include/linux/kexec.h:int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
| include/linux/kexec.h:extern int kexec_add_buffer(struct kexec_buf *kbuf);
| include/linux/kexec.h:int kexec_locate_mem_hole(struct kexec_buf *kbuf);
| kernel/kexec_file.c:    struct kexec_buf *kbuf = (struct kexec_buf *)arg;

Mark.

> 
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 532d72ea42ee8..b70f4df15a1ae 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -41,7 +41,7 @@ static void *image_load(struct kimage *image,
>  	struct arm64_image_header *h;
>  	u64 flags, value;
>  	bool be_image, be_kernel;
> -	struct kexec_buf kbuf;
> +	struct kexec_buf kbuf = {};
>  	unsigned long text_offset, kernel_segment_number;
>  	struct kexec_segment *kernel_segment;
>  	int ret;
> 
> ---
> base-commit: 7a77c6b5ce68a71b9102760a988a4564ff6d4106
> change-id: 20250826-akpm-18a57e3a39fd
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 
> 

