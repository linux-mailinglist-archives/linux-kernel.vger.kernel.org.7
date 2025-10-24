Return-Path: <linux-kernel+bounces-868194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D451EC049F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E64A0358D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F1629CB4C;
	Fri, 24 Oct 2025 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cIRh5nFO"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB01DB127
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289677; cv=none; b=IwqNPWOZ3qUvxo9I1pZHAs1PJgTcE31YXLbSmkCeRoquudK4952T03e+AHcioOnpZobC5Xic955TTL2YRlngtpsKZfVtI1XKIFS8BVJSSLYtiQWFo+N7Fber7Khz8YxU/t3aJL8yzH4s4oAq9iz88KperzfFHsWelgj0FWgeeeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289677; c=relaxed/simple;
	bh=BNniUyI901wXBDIZRDj//iLWjluNXPc/huJRB/20Imc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PL2F0RSjM5YZ8pAozqd+hwgsgboV+3n7xN91Qk3ID7WMVVY4SbCRfkCb3bl42omdp0sL4fcB1bB7yar6G9Sy6EWyDDuNnzyRIuleaAc62g/PPlDaJiWZP5ochrQyV+ZzqelWFIyq7HGQ8iR23suHzlSeoImZbBH+nI5vJD77yiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cIRh5nFO; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d327af2b-8089-4d1b-8f7f-9f18c0d9faba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761289671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJpu9jNeG/9AHqtuVmrf1mdpbO23IJsdx1yWPp+AZv8=;
	b=cIRh5nFOYHb6pF8W1pDgnMpBx3yfZ+vT+k8OKL4renNzvsbG3YwZjaVL2tEjNRluaJMKZt
	noGOXGtoSBhgmWSOrdo3DdHFZjsXW4A2dU1CwLkyZkVCCTn9c68E5sIzJoZS7HJD0eHa5W
	pL693ktqobj4sgZBoAIMN7pEIyeAmsY=
Date: Fri, 24 Oct 2025 15:06:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] LoongArch: kexec: Initialize kexec_buf struct
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kexec@lists.infradead.org, Breno Leitao <leitao@debian.org>,
 Youling Tang <tangyouling@kylinos.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251024063653.35492-1-youling.tang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <20251024063653.35492-1-youling.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

cc to loongarch@lists.linux.dev and linux-kernel@vger.kernel.org


On 10/24/25 14:36, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
>
> The kexec_buf structure was previously declared without initialization.
> commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
> added a field that is always read but not consistently populated by all
> architectures. This un-initialized field will contain garbage.
>
> This is also triggering a UBSAN warning when the uninitialized data was
> accessed:
>
>          ------------[ cut here ]------------
>          UBSAN: invalid-load in ./include/linux/kexec.h:210:10
>          load of value 252 is not a valid value for type '_Bool'
>
> Zero-initializing kexec_buf at declaration ensures all fields are
> cleanly set, preventing future instances of uninitialized memory being
> used.
>
> Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
> Link: https://lore.kernel.org/r/20250827-kbuf_all-v1-2-1df9882bb01a@debian.org
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>   arch/loongarch/kernel/kexec_efi.c          | 2 +-
>   arch/loongarch/kernel/kexec_elf.c          | 2 +-
>   arch/loongarch/kernel/machine_kexec_file.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
> index 45121b914f8f..5ee78ebb1546 100644
> --- a/arch/loongarch/kernel/kexec_efi.c
> +++ b/arch/loongarch/kernel/kexec_efi.c
> @@ -42,7 +42,7 @@ static void *efi_kexec_load(struct kimage *image,
>   {
>   	int ret;
>   	unsigned long text_offset, kernel_segment_number;
> -	struct kexec_buf kbuf;
> +	struct kexec_buf kbuf = {};
>   	struct kexec_segment *kernel_segment;
>   	struct loongarch_image_header *h;
>   
> diff --git a/arch/loongarch/kernel/kexec_elf.c b/arch/loongarch/kernel/kexec_elf.c
> index 97b2f049801a..1b6b64744c7f 100644
> --- a/arch/loongarch/kernel/kexec_elf.c
> +++ b/arch/loongarch/kernel/kexec_elf.c
> @@ -59,7 +59,7 @@ static void *elf_kexec_load(struct kimage *image,
>   	int ret;
>   	unsigned long text_offset, kernel_segment_number;
>   	struct elfhdr ehdr;
> -	struct kexec_buf kbuf;
> +	struct kexec_buf kbuf = {};
>   	struct kexec_elf_info elf_info;
>   	struct kexec_segment *kernel_segment;
>   
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
> index dda236b51a88..fb57026f5f25 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -143,7 +143,7 @@ int load_other_segments(struct kimage *image,
>   	unsigned long initrd_load_addr = 0;
>   	unsigned long orig_segments = image->nr_segments;
>   	char *modified_cmdline = NULL;
> -	struct kexec_buf kbuf;
> +	struct kexec_buf kbuf = {};
>   
>   	kbuf.image = image;
>   	/* Don't allocate anything below the kernel */

