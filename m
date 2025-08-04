Return-Path: <linux-kernel+bounces-755424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1CAB1A625
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70BF1885C91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA56220F5D;
	Mon,  4 Aug 2025 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wqpgoPxK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4/gAJ8Rh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1CuIXsQU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c7OOTM4U"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2421B184
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321620; cv=none; b=sQR3RGDQKvs3HORXByeiWGbD+JXDQegj8NJV0a8lI98YIeTFTd6UNAL0kuVIOQAjMqmcZqBDS89dQ8TLnahlfVPk92QNr/21Gkm7MCfB6d03QlnZ+cX/WBDsQkCWzRf2ULeC/vIUB1KujUmXyNTBRgkdyZ0PBsoj5iQiOsOdMno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321620; c=relaxed/simple;
	bh=xog2Gyt0uHa4RnTwEZdFBEwm63DIeRjt7c9vC9UuS5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWyUVD94ftMPzlceKqeh5FiVFBzRh/hDN1CrNXQlHMS23k/xy/7aYWGNjZ57Aiez3do8TvTkW46OM69zqrFnefk22WsM35BTMuy8BBQlWuvI3jfZkxSsfrGWFijwh12munD2wFeBudFa+uoK73z3D9PTztW2L6l9tzPBY3ipTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wqpgoPxK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4/gAJ8Rh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1CuIXsQU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c7OOTM4U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E392F1F46E;
	Mon,  4 Aug 2025 15:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754321614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0cpecDgVmpKu0rGCxmXRXuJz/heKHFUxU0R7ay2Nsgw=;
	b=wqpgoPxK7Kbb5dPmsQqcqVxwnYtu2jje5hwGJPn/qmh9/ixfeOn+xLTYSywDPWCQpcWhTf
	92mW40ohaLZBa9nnuGXVCVss17iQyEV0+dVv05IhIBoNkTTe7+0VZrIRCMPTjHGIPVvJyK
	HIvEtsJ74Fg+exWNciSzvQye1wiFqBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754321614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0cpecDgVmpKu0rGCxmXRXuJz/heKHFUxU0R7ay2Nsgw=;
	b=4/gAJ8Rhip9oP4LIMCEPj6LveSTeJOpi8JHMU9Pz5jXwsMjMDudGqaorYgWSdcGPMhGX9M
	6bQ9N5VIlkJtSODA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754321613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0cpecDgVmpKu0rGCxmXRXuJz/heKHFUxU0R7ay2Nsgw=;
	b=1CuIXsQU6LDqQ382s+MaKoOdFqZZG2R1UoxJ3cfdQxAq4Nu/3joUObC445zB8OFZ0rqwBP
	7/BTV66vicca10EeZ9zcRkJgJNQDTahdVb0dPcT20taKwWET3eYOHS8l0GXiV2XRhZjEQD
	R/x4zIMsuk17awl15EXeg/J/SL2mQbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754321613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0cpecDgVmpKu0rGCxmXRXuJz/heKHFUxU0R7ay2Nsgw=;
	b=c7OOTM4UPpxA/B4rhizfvgzBtC4tQdAKJt1kJatyIdm+DdZssyDNsYrlDSKW21nyMThPU4
	2kpQuhhiwAIyrMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C31BD13695;
	Mon,  4 Aug 2025 15:33:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XY1IL83SkGjIdwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 04 Aug 2025 15:33:33 +0000
Message-ID: <a12fc401-59bd-4005-b1f9-fcaa1f68f68b@suse.cz>
Date: Mon, 4 Aug 2025 17:33:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/nommu: convert kobjsize() to folios
Content-Language: en-US
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
 jannh@google.com, pfalcato@suse.de, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, SeongJae Park <sj@kernel.org>
References: <20250804145117.3857308-1-sidhartha.kumar@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250804145117.3857308-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 8/4/25 16:51, Sidhartha Kumar wrote:
> Simple folio conversion to remove a user of PageSlab() and
> PageCompound().
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Ok a stupid question maybe... why does this code exists at all? AFAICS only
that fs/proc/task_nommu.c can report how much bytes the kernel objects take
for a task? That code seems to be from pre-git era. Does anyone care today?

> ---
> v1 -> v2:
> 	change "compound folio" to "large folio" in comment per SJ
> 
>  mm/nommu.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 07504d666d6a..75548fae28f7 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -64,7 +64,7 @@ const struct vm_operations_struct generic_file_vm_ops = {
>   */
>  unsigned int kobjsize(const void *objp)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  
>  	/*
>  	 * If the object we have should not have ksize performed on it,
> @@ -73,22 +73,22 @@ unsigned int kobjsize(const void *objp)
>  	if (!objp || !virt_addr_valid(objp))
>  		return 0;
>  
> -	page = virt_to_head_page(objp);
> +	folio = virt_to_folio(objp);
>  
>  	/*
>  	 * If the allocator sets PageSlab, we know the pointer came from
>  	 * kmalloc().
>  	 */
> -	if (PageSlab(page))
> +	if (folio_test_slab(folio))
>  		return ksize(objp);
>  
>  	/*
> -	 * If it's not a compound page, see if we have a matching VMA
> +	 * If it's not a large folio, see if we have a matching VMA
>  	 * region. This test is intentionally done in reverse order,
>  	 * so if there's no VMA, we still fall through and hand back
> -	 * PAGE_SIZE for 0-order pages.
> +	 * PAGE_SIZE for 0-order folios.
>  	 */
> -	if (!PageCompound(page)) {
> +	if (!folio_test_large(folio)) {
>  		struct vm_area_struct *vma;
>  
>  		vma = find_vma(current->mm, (unsigned long)objp);
> @@ -100,7 +100,7 @@ unsigned int kobjsize(const void *objp)
>  	 * The ksize() function is only guaranteed to work for pointers
>  	 * returned by kmalloc(). So handle arbitrary pointers here.
>  	 */
> -	return page_size(page);
> +	return folio_size(folio);
>  }
>  
>  void vfree(const void *addr)


