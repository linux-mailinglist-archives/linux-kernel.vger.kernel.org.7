Return-Path: <linux-kernel+bounces-794046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF04B3DC17
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB0D3AFD2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753F41E00A0;
	Mon,  1 Sep 2025 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lXRRBn96"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7722110E;
	Mon,  1 Sep 2025 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714583; cv=none; b=Hfo2HW6nn5qgj2yVZb4yPx8a0zJwT59wLuOo3DxL0f6hB7n7baGEGubmmsccfYTxg5Ht/ahBMI0gPo8ZJa/1K+b1WiT7Y/ZZYFXFSznodC30m1TpTE1XQFQj2BPv2aJYchYCJH/QuxRq4TcD0NnbUBFREkb31nb9YEOtqYRb0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714583; c=relaxed/simple;
	bh=ygrgvvQiBgPIQHANbXjqtT9el6txwpzllgaerc90Irk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIUhlXeL8qzR2ye/ju3HofDh/PtmqwFbqnnEYW9fICZ76KC4DR6DOZau+dthJarYWJiZKOWjVD9NOFpxmdvXQ5wshOuJIIyNdGRB8gPc8NOh9n4wOQ44V1ixMWEpUaCcRqlUqgnTb6nYxg4fodIBwvdFay4gPzRqDkspOmFLuxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lXRRBn96; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h2PekiNlUUgCJoV7Y212hHfSi1OIUIfWL7b385Tt0H8=; b=lXRRBn966NcsIlmtwK41iXKYfQ
	SHIrW8W+f5tfWl/YtPJkx9pjhCgPwUmNhkvQkQuqMxRw8wGIKp0frmOJHxJAmSr0bXiVR2KDHaiec
	2hLepnpBF6FalhdAG9ITIn9lFS8N00nS9yDBpbIP/AwV14XbFgxwe1LosCVFsHxbvb5yKH/WOARLC
	3Q/vMy9GLuy0g2nOZidA2djJ/zu/MYRzFuWhIxlFeqJUZwEII2pRWYRTlGpuzPOis9NG4d4uB5xV1
	3zpHPJf+oErcyNojZVnKzYVcFQXt9pyYx8CIs65/rVsbi83n9wBe+bWGiTJ4RIUg4UBWR4wJCK/N0
	6DVwt43Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uszi5-000000054QX-22WE;
	Mon, 01 Sep 2025 08:16:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EA41A300342; Mon, 01 Sep 2025 10:16:16 +0200 (CEST)
Date: Mon, 1 Sep 2025 10:16:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] objtool/LoongArch: Fix fall through warning about
 efi_boot_kernel()
Message-ID: <20250901081616.GA4067720@noisy.programming.kicks-ass.net>
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-2-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901072156.31361-2-yangtiezhu@loongson.cn>

On Mon, Sep 01, 2025 at 03:21:54PM +0800, Tiezhu Yang wrote:
> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
> the following objtool warning:
> 
>   vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
>   falls through to next function __efistub_exit_boot_func()
> 
> This is because efi_boot_kernel() doesn't end with a return instruction
> or an unconditional jump, then objtool has determined that the function
> can fall through into the next function.
> 
> At the beginning, try to do something to make efi_boot_kernel() ends with
> an unconditional jump instruction, but it is not a proper way.
> 
> After more analysis, one simple way is to ignore these EFISTUB functions
> in validate_branch() of objtool since they are useless for stack unwinder.
> 

This is drivers/firmware/efi/libstub/loongarch.c:efi_boot_kernel(),
right?

Why not simply do something like:

diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
index 3782d0a187d1..082611a5f1f0 100644
--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -81,4 +81,5 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 
 	real_kernel_entry(true, (unsigned long)cmdline_ptr,
 			  (unsigned long)efi_system_table);
+	BUG();
 }

