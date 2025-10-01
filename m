Return-Path: <linux-kernel+bounces-838930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C13BB0723
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FED1926911
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4777E2EC57F;
	Wed,  1 Oct 2025 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sxSyGSR/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ItTL2eou";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nBTKxE2C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ga03/4WG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5932980A8
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324636; cv=none; b=Fo9xmse3j2J757EMXYlh4Yf8mQUetGtCwucItnf+eGjCN8/jS9wMHklcoSM0SGVxolcafh4Ak3mZFG84fk91J3OQMFDgCK+tmB56cWnN5RnoL4CVQqInzrpwNo7H2kYcIMIoeLJkKE9agx35AdDzgv8L/32R7hshm5gEPxXKT8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324636; c=relaxed/simple;
	bh=nF9es9/WIczao8YSFCjg4z1d/Hv7Cj1JHGYDhyhICzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxZRysRXBShFrz0VUf5hZZ+t6kMCQB+jgELM7FZHJhHo/+nzwDcDmTOq6jaccRBra6E6pLTBKzAC7oZwdScjZ8+E6QdoCHZVUon9XH6tzCf/f9+oTrhwInVe7IOT8M/iSr0N2QiwrxVWpqxSlqpMgc1glK6N6ADz6Z/ydVrOdD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sxSyGSR/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ItTL2eou; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nBTKxE2C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ga03/4WG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FF2D1FB66;
	Wed,  1 Oct 2025 13:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759324632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmRrN30rfew7e/j2Ph45WjnBsE+EVhv1bOJ8ZOYpilQ=;
	b=sxSyGSR/05AfwtKZW9+4jdwaNmsSnhB+gyiMe3kPKkWQRjNCOHzM/oypF7Fj1JqOE9wddo
	jMZ9UPUxIYrdvaivVhEZGQdjwLV95/0+mtQiRKalZYizeuJNUWnDPvjtkQ7mbhRtJBRn94
	4i020G8YVJscSoxjdsdpBysieOezSoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759324632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmRrN30rfew7e/j2Ph45WjnBsE+EVhv1bOJ8ZOYpilQ=;
	b=ItTL2eou8Wl55gSlsfk2xBhlGn0fW9gOu1DjoPIU2fQvVhlvsKKo9OqhD9qepKtTf8FQU1
	KBO/dXpB0OX89uCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nBTKxE2C;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Ga03/4WG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759324631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmRrN30rfew7e/j2Ph45WjnBsE+EVhv1bOJ8ZOYpilQ=;
	b=nBTKxE2CepeBww3zK1xK18HiHHlmS4yHFNTHwMb33LlWKEKzQY8gWCEeGovIsS2ceib6uR
	zQkWjlKYcc7Yk8GP4UL90bXvD6LpWtYtZ20wH3BggZayt8ChXYkIUSXv6zvmFg+2YOP7/o
	TF3Sglo9FpWe4fR/YNvnvHMWuI3qZeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759324631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmRrN30rfew7e/j2Ph45WjnBsE+EVhv1bOJ8ZOYpilQ=;
	b=Ga03/4WGFp5aYpkn4UvpK3mtiZ39QXlhD6z5ou2eOXXgFe2Yb0LM1NA+Yu+zWdkKHihxLZ
	E9VIWO+maVJCeFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A18613A3F;
	Wed,  1 Oct 2025 13:17:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZsoyIdYp3WjqDwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 01 Oct 2025 13:17:10 +0000
Message-ID: <5e057255-ccd4-4250-8653-73040e14354f@suse.cz>
Date: Wed, 1 Oct 2025 15:19:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/page_owner: Rename proc-prefixed variables for
 clarity
To: Hu Song <husong@kylinos.cn>, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250930092153.843109-1-husong@kylinos.cn>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250930092153.843109-1-husong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9FF2D1FB66
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Spam-Score: -4.51

On 9/30/25 11:21 AM, Hu Song wrote:
> From: Song Hu <husong@kylinos.cn>
> 
> The `proc_page_owner_operations` and related variables were renamed to
> `page_owner_fops` to better reflect their association with `debugfs` rather
> than `/proc`. This improves code clarity and aligns with kernel naming
> conventions.
> 
> Signed-off-by: Song Hu <husong@kylinos.cn>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

how bout going even further and renaming to:

show_stacks_fops
count_threshold_fops

static means we can't collide with other files using the same name so no
need for page_owner prefix everywhere

> ---
>  mm/page_owner.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index c3ca21132c2c..bb88b72b6062 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -848,7 +848,7 @@ static void init_early_allocated_pages(void)
>  		init_zones_in_node(pgdat);
>  }
>  
> -static const struct file_operations proc_page_owner_operations = {
> +static const struct file_operations page_owner_fops = {
>  	.read		= read_page_owner,
>  	.llseek		= lseek_page_owner,
>  };
> @@ -929,7 +929,7 @@ static int page_owner_stack_open(struct inode *inode, struct file *file)
>  	return seq_open_private(file, &page_owner_stack_op, 0);
>  }
>  
> -static const struct file_operations page_owner_stack_operations = {
> +static const struct file_operations page_owner_stack_fops = {
>  	.open		= page_owner_stack_open,
>  	.read		= seq_read,
>  	.llseek		= seq_lseek,
> @@ -948,7 +948,7 @@ static int page_owner_threshold_set(void *data, u64 val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
> +DEFINE_SIMPLE_ATTRIBUTE(page_owner_threshold_fops, &page_owner_threshold_get,
>  			&page_owner_threshold_set, "%llu");
>  
>  
> @@ -961,13 +961,12 @@ static int __init pageowner_init(void)
>  		return 0;
>  	}
>  
> -	debugfs_create_file("page_owner", 0400, NULL, NULL,
> -			    &proc_page_owner_operations);
> +	debugfs_create_file("page_owner", 0400, NULL, NULL, &page_owner_fops);
>  	dir = debugfs_create_dir("page_owner_stacks", NULL);
>  	debugfs_create_file("show_stacks", 0400, dir, NULL,
> -			    &page_owner_stack_operations);
> +			     &page_owner_stack_fops);
>  	debugfs_create_file("count_threshold", 0600, dir, NULL,
> -			    &proc_page_owner_threshold);
> +			    &page_owner_threshold_fops);
>  
>  	return 0;
>  }


