Return-Path: <linux-kernel+bounces-898186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC7CC5484B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA07434972C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ED22D839B;
	Wed, 12 Nov 2025 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb7qiCwn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44127299AA3;
	Wed, 12 Nov 2025 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980953; cv=none; b=ICuzTfbzNND8KYfPEi+NbGc7UObAygBaVvH8qdo9JPQAmQCzonrTSxxTPiRoMXlb1EnGymNUxYoI2TnkPibnbl6n5H5KUSmEuQzZqXFhGSmC24rAGivdC10Sv+/BnrX0Ggc6Bcyj+Yzq7uT1TsygpidudZ4u9K72VIPDFvilfPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980953; c=relaxed/simple;
	bh=u9LmrEU/UvD3HmrDpdPbJVYRs1xAIxsoSOUYJsiJhbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Taje7woZ5RHX10XHkFt+Jd6DIT7XXQ2TxZa4bUp1E8LLOfn4GsnBxv/AD9J29wnb6GZQ3hNxjS4fNOrR3PbQAWj03yN7Nth0eaZMtoyVX8snolNFHGLVhfvjk/yFfj9sQTTkWjO5jgAm9rS+CQKYR4Gh68wPOhPc3P9IPtIqkpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb7qiCwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16A3C16AAE;
	Wed, 12 Nov 2025 20:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762980952;
	bh=u9LmrEU/UvD3HmrDpdPbJVYRs1xAIxsoSOUYJsiJhbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nb7qiCwnhPto2pgEl1/YJZWf8v8VutOtnoIDpx0ty3mtsRHdkdGOnCGFELPA1rSNT
	 LM5PW7nFf1xDLRFStZhD3Fwr4tIm5aF424LfGdKxbMfetOpxfl6mHvvbblyhEwZPgC
	 7BBageWFnPyKejQpAyZ9CE/4V0NoNahtGvmRTMOslrdInQT6aGI44hP38qw3cGC+cb
	 FybHGYHwVi45ZJtfO/6DLk9jeBCrG51IUlUt2Z3EFgHMJwhgOzqqheg3vOCiSUtl4W
	 x7JU8Z7ecosRmmuKt0yMiIgn4Di+2LIL6piMmZJ0nZzvbh16AkX63sVUiy2qsZ5uRY
	 mGPLGg43yOsXA==
Date: Wed, 12 Nov 2025 14:55:51 -0600
From: Rob Herring <robh@kernel.org>
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	James Morse <james.morse@arm.com>,
	Chen Zhou <chenzhou10@huawei.com>, Baoquan He <bhe@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] of/fdt: Some bug fixes and cleanups
Message-ID: <20251112205551.GC2155854-robh@kernel.org>
References: <20251112143520.233870-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112143520.233870-1-yuntao.wang@linux.dev>

On Wed, Nov 12, 2025 at 10:35:10PM +0800, Yuntao Wang wrote:
> This patch series fixes several bugs related to dt_root_addr_cells and
> dt_root_size_cells, and performs some cleanup.
> 
> Links to the previous related patches:
> 
> https://lore.kernel.org/lkml/CAL_JsqJxar7z+VcBXwPTw5-Et2oC9bQmH_CtMtKhoo_-=zN2XQ@mail.gmail.com/
> 
> Yuntao Wang (10):
>   of/fdt: Introduce dt_root_addr_size_cells() and
>     dt_root_addr_size_bytes()
>   of/reserved_mem: Use dt_root_addr_size_bytes() instead of open-coding
>     it
>   of/reserved_mem: Use dt_root_addr_size_bytes() instead of open-coding
>     it
>   of/reserved_mem: Use dt_root_addr_size_bytes() instead of open-coding
>     it

Your aim in writing subjects should be to write something that is unique 
for every commit in the past or future. Because you can never make the 
same change twice, right? (I'm excluding 'fix typos/spelling' type 
commits). Certainly the same subject in one series is never right.

>   of/fdt: Use dt_root_addr_size_bytes() instead of open-coding it
>   of/fdt: Fix the len check in early_init_dt_check_for_elfcorehdr()
>   of/fdt: Fix the len check in
>     early_init_dt_check_for_usable_mem_range()
>   of/fdt: Use dt_root_addr_size_bytes() instead of open-coding it

This is not what I meant. We have multiple copies of this where only 
the property name changes: 

	prop = of_get_flat_dt_prop(node, "linux,elfcorehdr", &len);
	if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
		return;

	elfcorehdr_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
	elfcorehdr_size = dt_mem_next_cell(dt_root_size_cells, &prop);

Instead, add a function something like this:

static void early_init_dt_read_address(unsigned long node, const char 
*prop, u64 *addr, u64*size)
{
        prop = of_get_flat_dt_prop(node, prop, &len);
        if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
                return;

        *addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
        *size = dt_mem_next_cell(dt_root_size_cells, &prop);
}

Then we only have the length checks in one place.


That still leaves the cases with more than 1 entry open coded. So 
instead, to cover that case to something like this:

const __be32 *of_get_flat_dt_address_prop(unsigned long node, const char 
*propname, int *len)
{
	prop = of_get_flat_dt_prop(node, propname, &len);
	if (!prop || (*len % (dt_root_addr_cells + dt_root_size_cells))) {
		*len = 0;
		return NULL;
	}

	*len /= (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
	return prop;
}

And then a user would look something like this:

prop = of_get_flat_dt_address(node, "linux,usable-memory-range", &len);
for (i = 0; i < len; i++) {
	of_read_address_idx(prop, i, &addr, &size);
	...
}

Here 'len' is number of addr+size entries.

And the simple case of reading 1 entry could be just:

of_read_address_idx(of_get_flat_dt_address(node, "linux,elfcorehdr", NULL), 0, &addr, &size);

Rob

