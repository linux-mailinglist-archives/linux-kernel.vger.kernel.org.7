Return-Path: <linux-kernel+bounces-883416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B56C2D5EA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AB484F1900
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A311031B124;
	Mon,  3 Nov 2025 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPU4gW+C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E51A3191DA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189591; cv=none; b=rfue1OXh2KOGxJ2PfAspbcHoIlyInXnqNgGk9VHLlzXyJ3TaM5JHLSHX+JADrC0iJ3pDmnH2nN88TibC+uGPLgnJp+G9oodbshczMEoV/XsisnQAKY0lqH1BL87DXQqe0YIBn+7zvJeKg97ZVrZBtNEI3K7D9QhlYy3A0fPfqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189591; c=relaxed/simple;
	bh=WJ9VTR8wJ5hOe9IOw1nh+y69/i/y4QP6U0LeOmdyc58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKrAXnsJwdyCqkf0Zfxl84ag7zjRAXtrGzHDYbMHFUO5LYjad3y+VJFegyjTqCa69Bj9tEIxmxNjRH0TxXUFIoBTk0CLAsSDGOq9lmmKgJj3Je288DLqbbdXfs5ec7eEcuCtSDsNe5EsdQtGEffWtC9clBNQi82rtZVV+4WSKaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPU4gW+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88136C4CEE7;
	Mon,  3 Nov 2025 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762189590;
	bh=WJ9VTR8wJ5hOe9IOw1nh+y69/i/y4QP6U0LeOmdyc58=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XPU4gW+CjJomESHqNiS0EytGoIlIVKCyxyaIL6vriBsPRF8legOOUC57UtdV/gfzp
	 cCBMzjKpQZK7054Jj+W5irC8ZRqCU+lCoYdBXNgkS1KBXFPwFfor2I2feltLLBAfR0
	 zTZ/Zx6VQK/luOVgoTze2JMjjk9XGD3TtDvfeePb6TT6DPj7FTnrTBBSiclQDvm7Rf
	 HSVJbz0NYh8OXPhTKA2ypLCpgiSImuzMLoorvauKisM0UbLfIpwJRpYlUQjqLTjHo9
	 OAaGOV4WPk6VNeBP4k5wjRf85k7mFgFI6+80FSMu4rqxkzJPLfHNgEsN/REv6BAlXQ
	 OUdf6hPfo7tYw==
Message-ID: <cd632ad0-c73e-4e6d-872b-2f4dad285e9d@kernel.org>
Date: Mon, 3 Nov 2025 18:06:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ksm: perform a range-walk in break_ksm
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251031174625.127417-1-pedrodemargomes@gmail.com>
 <20251031174625.127417-3-pedrodemargomes@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251031174625.127417-3-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.10.25 18:46, Pedro Demarchi Gomes wrote:
> Make break_ksm() receive an address range and change
> break_ksm_pmd_entry() to perform a range-walk and return the address of
> the first ksm page found.
> 
> This change allows break_ksm() to skip unmapped regions instead of
> iterating every page address. When unmerging large sparse VMAs, this
> significantly reduces runtime.
> 
> In a benchmark unmerging a 32 TiB sparse virtual address space where
> only one page was populated, the runtime dropped from 9 minutes to less
> then 5 seconds.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>   mm/ksm.c | 88 ++++++++++++++++++++++++++++++--------------------------
>   1 file changed, 48 insertions(+), 40 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 922d2936e206..64d66699133d 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -607,35 +607,55 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>   	return atomic_read(&mm->mm_users) == 0;
>   }
>   
> -static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
> +struct break_ksm_arg {
> +	unsigned long addr;
> +};

Leftover? :)

> +
> +static int break_ksm_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long end,
>   			struct mm_walk *walk)
>   {
> -	struct folio *folio = NULL;
> +	unsigned long *found_addr = (unsigned long *) walk->private;
> +	struct mm_struct *mm = walk->mm;
> +	pte_t *start_ptep, *ptep;
>   	spinlock_t *ptl;
> -	pte_t *pte;
> -	pte_t ptent;
> -	int ret;
> +	int found = 0;

Best to perform the ret -> found rename already in patch #1.


With both things

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

