Return-Path: <linux-kernel+bounces-894836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E4C4C335
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2BBD234EBA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D953D2D29CE;
	Tue, 11 Nov 2025 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F+wjVqlu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vek2zLom";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hg2u4BMe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZnfMZ2vp"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ABC2E5407
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847789; cv=none; b=aeH8zfhsK/qL3Qv4jcWldODArbVMODL7F7zKy5x9lsftmmqaam8adBrNSJ8fWglXy3ThwpQXnthyl04tgZg5zQwUKE+GtevgO4HF2vVfb5PUOONWXhHgT8e5SypyZYIwcNkNG4iNSJqno2mfiuTcvMMkgvhZpkPkeep6i3aItmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847789; c=relaxed/simple;
	bh=KDHyOELKf7jHac94xQajMC7ejs0MSo3fjBeVp0L1MZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXiLDhvYyxWYI8vPhNKRzPCeMJaidopV8+HsMNR3EjsKLKjj+DwwzL3GcgzJWL2+vIrF6MGQeUVPc7dnieTrYKfBVU2VwiCXl/OzVx4+oc/ZkTKb8uTrtB+i+kgk9ZDQARoAqjwA9aKfOJiTB54NQ650bWvg32PPo8Oxv1iFtJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F+wjVqlu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vek2zLom; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hg2u4BMe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZnfMZ2vp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D961C1F399;
	Tue, 11 Nov 2025 07:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762847786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9nEk9c1kRKHjmPhenxqkRPT9FPoh0RLFhK0X7tXvjIs=;
	b=F+wjVqluT176lizgzTqNtnb0wcGrpWTFXw4yeJAJG5On/fOeV1T9GF60oPo9mTe3OJehFk
	eICjzjoVVGU4eQbC/AHhXmPP+SHvxPzTOKYYiPnKqs/Ejun87k/9bwVncMLbXubBKwOpF8
	jRnlygcrfG/xZJRMprkLL81NkCQFehE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762847786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9nEk9c1kRKHjmPhenxqkRPT9FPoh0RLFhK0X7tXvjIs=;
	b=Vek2zLomK8EkwUgPH/ByC81G+B6kitYk9lEG3L9IVoHK+9J7YiV6lM98eHzGiC2scrBD9k
	AX+6slAsYLoYFpCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762847785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9nEk9c1kRKHjmPhenxqkRPT9FPoh0RLFhK0X7tXvjIs=;
	b=hg2u4BMeM78e2bYg0FWUF0d2URB3pqPNUTOvk9XFkjh6eDjdD63E6RePtN4Nox8h2LXYt8
	TGvP9e5ObIgy2il6Q+GUcnhgdd6fafVGCaNRlepSqKc+Rxt4CcfZOqRA+NqPqmC+Yl0Mjo
	aIXALiIMnvu4Qn4M13BxVq1JYfgFl8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762847785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9nEk9c1kRKHjmPhenxqkRPT9FPoh0RLFhK0X7tXvjIs=;
	b=ZnfMZ2vpGUylNRAjwEP9t+E6Qc2JivQOCHD19c0hhCFa6V0ctbibaYw9PaO4OSL6SxzRmB
	OnOnBxgHYPklgnDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B51A81484E;
	Tue, 11 Nov 2025 07:56:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2F1SKinsEmkyEgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 11 Nov 2025 07:56:25 +0000
Message-ID: <66acdf13-a225-4c9b-a29c-9b16079b7e02@suse.cz>
Date: Tue, 11 Nov 2025 08:56:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: rename walk_page_range_mm()
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1762795245.git.lorenzo.stoakes@oracle.com>
 <c684d91464a438d6e31172c9450416a373f10649.1762795245.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <c684d91464a438d6e31172c9450416a373f10649.1762795245.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 11/10/25 18:22, Lorenzo Stoakes wrote:
> Make it clear we're referencing an unsafe variant of this function
> explicitly.
> 
> This is laying the foundation for exposing more such functions and
> maintaining a consistent naming scheme.
> 
> As a part of this change, rename check_ops_valid() to check_ops_safe() for
> consistency.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/internal.h |  2 +-
>  mm/madvise.c  |  4 ++--
>  mm/pagewalk.c | 22 +++++++++++-----------
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 0af87f6c2889..479234b39394 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1652,7 +1652,7 @@ static inline void accept_page(struct page *page)
>  #endif /* CONFIG_UNACCEPTED_MEMORY */
>  
>  /* pagewalk.c */
> -int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
> +int walk_page_range_mm_unsafe(struct mm_struct *mm, unsigned long start,
>  		unsigned long end, const struct mm_walk_ops *ops,
>  		void *private);
>  int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
> diff --git a/mm/madvise.c b/mm/madvise.c
> index de918b107cfc..7b938ff44be2 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1171,8 +1171,8 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
>  		unsigned long nr_pages = 0;
>  
>  		/* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
> -		err = walk_page_range_mm(vma->vm_mm, range->start, range->end,
> -					 &guard_install_walk_ops, &nr_pages);
> +		err = walk_page_range_mm_unsafe(vma->vm_mm, range->start,
> +				range->end, &guard_install_walk_ops, &nr_pages);
>  		if (err < 0)
>  			return err;
>  
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 6cace2c8814a..ab29b16abd2c 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -452,7 +452,7 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
>   * We usually restrict the ability to install PTEs, but this functionality is
>   * available to internal memory management code and provided in mm/internal.h.
>   */
> -int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
> +int walk_page_range_mm_unsafe(struct mm_struct *mm, unsigned long start,
>  		unsigned long end, const struct mm_walk_ops *ops,
>  		void *private)
>  {
> @@ -518,10 +518,10 @@ int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
>   * This check is performed on all functions which are parameterised by walk
>   * operations and exposed in include/linux/pagewalk.h.
>   *
> - * Internal memory management code can use the walk_page_range_mm() function to
> - * be able to use all page walking operations.
> + * Internal memory management code can use *_unsafe() functions to be able to
> + * use all page walking operations.
>   */
> -static bool check_ops_valid(const struct mm_walk_ops *ops)
> +static bool check_ops_safe(const struct mm_walk_ops *ops)
>  {
>  	/*
>  	 * The installation of PTEs is solely under the control of memory
> @@ -579,10 +579,10 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
>  		unsigned long end, const struct mm_walk_ops *ops,
>  		void *private)
>  {
> -	if (!check_ops_valid(ops))
> +	if (!check_ops_safe(ops))
>  		return -EINVAL;
>  
> -	return walk_page_range_mm(mm, start, end, ops, private);
> +	return walk_page_range_mm_unsafe(mm, start, end, ops, private);
>  }
>  
>  /**
> @@ -639,7 +639,7 @@ int walk_kernel_page_table_range_lockless(unsigned long start, unsigned long end
>  
>  	if (start >= end)
>  		return -EINVAL;
> -	if (!check_ops_valid(ops))
> +	if (!check_ops_safe(ops))
>  		return -EINVAL;
>  
>  	return walk_pgd_range(start, end, &walk);
> @@ -678,7 +678,7 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
>  						    pgd, private);
>  	if (start >= end || !walk.mm)
>  		return -EINVAL;
> -	if (!check_ops_valid(ops))
> +	if (!check_ops_safe(ops))
>  		return -EINVAL;
>  
>  	/*
> @@ -709,7 +709,7 @@ int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
>  		return -EINVAL;
>  	if (start < vma->vm_start || end > vma->vm_end)
>  		return -EINVAL;
> -	if (!check_ops_valid(ops))
> +	if (!check_ops_safe(ops))
>  		return -EINVAL;
>  
>  	process_mm_walk_lock(walk.mm, ops->walk_lock);
> @@ -729,7 +729,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
>  
>  	if (!walk.mm)
>  		return -EINVAL;
> -	if (!check_ops_valid(ops))
> +	if (!check_ops_safe(ops))
>  		return -EINVAL;
>  
>  	process_mm_walk_lock(walk.mm, ops->walk_lock);
> @@ -780,7 +780,7 @@ int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
>  	unsigned long start_addr, end_addr;
>  	int err = 0;
>  
> -	if (!check_ops_valid(ops))
> +	if (!check_ops_safe(ops))
>  		return -EINVAL;
>  
>  	lockdep_assert_held(&mapping->i_mmap_rwsem);


