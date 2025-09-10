Return-Path: <linux-kernel+bounces-810216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326E4B51756
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8864E054E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4478F31C572;
	Wed, 10 Sep 2025 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s8CFhKY1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YD0KplvS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s8CFhKY1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YD0KplvS"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E751831A57A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508881; cv=none; b=G8RJNknHZjq6kMrbTnZ20Yj6ZRtTXeEnMnbcno8Y0815puKpsldw0qys8otina9f+msqvmjBOSi7rty0g2Sr5ZBWGm6j4LJympKmoY6c+ZLJFzgFBRUQtjcvbrSgHYk4Cyvy+q8cA00XP3amnnprjQSxfMtAo6HuhM2xjrrltvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508881; c=relaxed/simple;
	bh=hwRsepZy5wmSUzFcW2Lj9Ma4+ks4wODj6A/Ge3H3+0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8vE/MoHYNEBhl79BTgkMaPjgrThBxTZBr+PLYovcPc9RzRZQkr/FLb9J0oz89nLGDCqHwR6vARILgA77/uosGDPFA7NqPMoiVQK5Wg4ay8zT6tKK4qGihV/zEuHUtGlLEVyjKqokXvdJFadWo6KQ9Kir5DgarrKVIAA1hk5KoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s8CFhKY1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YD0KplvS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s8CFhKY1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YD0KplvS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB05720AB9;
	Wed, 10 Sep 2025 12:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757508876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sk+37UwWwPALMxUocJnLLKSlfsnWl0NqUyQHiakKMtg=;
	b=s8CFhKY19/NcLq+FjQWJYFX8TDi4dCHLzvXG9cZrHOp+Zg/M/L8q8xCxqijwySBLaniYIC
	LV3A7vg6iLgr96HKfywgqiOCiHf03hRtI1FxQLRSJeNWaPTmRf7ab5NAm2dQ6kGjQ4Nr3M
	q1E/KH1qXdiz5tHe4gdA13bib9cJ+As=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757508876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sk+37UwWwPALMxUocJnLLKSlfsnWl0NqUyQHiakKMtg=;
	b=YD0KplvSzl5fxb8wSKECLd6BOo9bH4N5o8VQPAszZLKkLV8X/zLMEGczoKeMQgwKLfNG6y
	xgoym8sSHwmjctCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757508876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sk+37UwWwPALMxUocJnLLKSlfsnWl0NqUyQHiakKMtg=;
	b=s8CFhKY19/NcLq+FjQWJYFX8TDi4dCHLzvXG9cZrHOp+Zg/M/L8q8xCxqijwySBLaniYIC
	LV3A7vg6iLgr96HKfywgqiOCiHf03hRtI1FxQLRSJeNWaPTmRf7ab5NAm2dQ6kGjQ4Nr3M
	q1E/KH1qXdiz5tHe4gdA13bib9cJ+As=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757508876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sk+37UwWwPALMxUocJnLLKSlfsnWl0NqUyQHiakKMtg=;
	b=YD0KplvSzl5fxb8wSKECLd6BOo9bH4N5o8VQPAszZLKkLV8X/zLMEGczoKeMQgwKLfNG6y
	xgoym8sSHwmjctCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85AAB13301;
	Wed, 10 Sep 2025 12:54:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5wyNHQt1wWgZBAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 10 Sep 2025 12:54:35 +0000
Date: Wed, 10 Sep 2025 13:54:25 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v1 2/9] mm/mmap: Abstract vma clean up from exit_mmap()
Message-ID: <lrkxxt3ywknfqudhf4u5kwgegrewqw6laxqonx5ysqmop6flxc@gwbqpadk5btv>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-3-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909190945.1030905-3-Liam.Howlett@oracle.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lists.infradead.org,kvack.org,vger.kernel.org,redhat.com,oracle.com,suse.cz,google.com,suse.com,quicinc.com,huaweicloud.com,tencent.com,gmail.com,kernel.org,infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Tue, Sep 09, 2025 at 03:09:38PM -0400, Liam R. Howlett wrote:
> Create the new function tear_down_vmas() to remove a range of vmas.
> exit_mmap() will be removing all the vmas.
> 
> This is necessary for future patches.
> 
> No functional changes intended.
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b07b3ec5e28f5..a290448a53bb2 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1250,6 +1250,29 @@ int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
>  }
>  EXPORT_SYMBOL(vm_brk_flags);
>  
> +static inline
> +unsigned long tear_down_vmas(struct mm_struct *mm, struct vma_iterator *vmi,
> +		struct vm_area_struct *vma, unsigned long max)
> +{
> +	unsigned long nr_accounted = 0;
> +	int count = 0;
> +
> +	mmap_assert_write_locked(mm);
> +	vma_iter_set(vmi, vma->vm_end);
> +	do {
> +		if (vma->vm_flags & VM_ACCOUNT)
> +			nr_accounted += vma_pages(vma);
> +		vma_mark_detached(vma);
> +		remove_vma(vma);
> +		count++;
> +		cond_resched();
> +		vma = vma_next(vmi);
> +	} while (vma && vma->vm_end <= max);

By not checking for XA_ZERO_ENTRY, we're technically breaking bisectability
here.

In any case,

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

