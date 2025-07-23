Return-Path: <linux-kernel+bounces-742202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03941B0EEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0351C82C67
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C4F284694;
	Wed, 23 Jul 2025 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q4bEBCj7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZrVh1UIE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nigw4flJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Km+OrjSE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D5284B3A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263733; cv=none; b=RQ/GCOrSnc5BmNjL8cQM3s9F76BLkjCePRJ9Hjbc84ZvC9l56S6zOoOxzzooTouhYBF4xroZqA1Er+/gk5uKTCadF6ZpVDaievvRPnYpofjhEKf4oG06znJGKKS+u49+tK3EPWNU8QsiUurNISzqA60f8Zu6HFxxkgG0FSBANn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263733; c=relaxed/simple;
	bh=q1YROvwkw3QWtBkiTRCYGWYE2il+LD5ZcEw//3vZ6OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+W/PYYuZVB4ORf7qIfoCE8TfAU58rx3LBDEpd77yJPqp5dYwMzNkqhmL1JHD1E/zD1TNIBAiPzA0q3HsK7OFKb4Q6lp3+lPvLz1SvJnTpTFtUaLl+fBZ/eFLuD9FTg97jZg3zkncXAY+zyV9Av5ykpbS9l2gdVxh0cuI8X/sNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q4bEBCj7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZrVh1UIE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nigw4flJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Km+OrjSE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA7E2218D5;
	Wed, 23 Jul 2025 09:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753263730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6e0oYfSmhk1vpAzcB9KYh3w+HHjNFd4D8pmNPbAL1oM=;
	b=q4bEBCj7AFQW8kjp2rssc7FgHugzBS+u7tKVDL4ySIqhj3lwtisU+pjXcIAi/qu73Ii/5t
	oezZF8yi+IR9QlIsAMKKcDZDGeAljeI6TNBp960ylpnSOFl303Xrbd9dpaRiX92eS1IhxR
	Vj1LjkmOQuBM5kAgV65HgkGmOpikDS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753263730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6e0oYfSmhk1vpAzcB9KYh3w+HHjNFd4D8pmNPbAL1oM=;
	b=ZrVh1UIE4tjMnrHPbxHDQJNaDB7GDxHnnQtjqebQWWJHP6z+8U39h3soz55gojlagyEBRu
	k+2D5sScgewOQ8BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753263729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6e0oYfSmhk1vpAzcB9KYh3w+HHjNFd4D8pmNPbAL1oM=;
	b=Nigw4flJ+LVggunln2cMQrvb69s+bP0lOmiu5vft09zxqW9w0YlXr9SDlqpI8GZmV0viaw
	xLlYsHD/DahjA3ndFsg+80iAl7+roRi5juZaqv1y9u2PZnwixiCWakClaWjVl8xRA8yTVW
	DuoAs2k4y2VonkiOjspz9XRxNSwv4tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753263729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6e0oYfSmhk1vpAzcB9KYh3w+HHjNFd4D8pmNPbAL1oM=;
	b=Km+OrjSEay5QPgXIhTrPlZW9fVSTu+OsVHLhsZx3QnxDIq3UJuivZ3NB183qJVLdQTExxj
	RQLFclycMMwXpeBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A07D613ABE;
	Wed, 23 Jul 2025 09:42:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cF/BJnGugGgZWwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Jul 2025 09:42:09 +0000
Message-ID: <66daf9db-ce97-4345-886c-3f8ab111b4fc@suse.cz>
Date: Wed, 23 Jul 2025 11:42:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: rename MM to MM MISC, add missing files
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>
References: <20250722192704.164758-1-lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250722192704.164758-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.com:email,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/22/25 21:27, Lorenzo Stoakes wrote:
> To fit in with other sections within MAINTAINERS for memory management
> files, rename the MEMORY MANAGEMENT section to MEMORY MANAGEMENT - MISC to
> contain files that are not described by other sections.
> 
> We also add missing files to MEMORY MANAGEMENT - MISC and MEMORY MANAGEMENT
> - CORE sections.
> 
> Move over appropriate files to the core section, and in both sections add
> remaining missing files. At this point, with the other recent MAINTAINERS
> changes, this should now mean that every memory management-related file has
> a section and assigned maintainers/reviewers.
> 
> For the time being, we maintain catch-all mm/ and tools/mm/ entries for MM

This...

> - MISC, though in future we may wish to remove these to make it obvious
> when files don't have assigned entries.
> 
> Finally, we copy across the maintainers/reviewers from MEMORY MANAGEMENT -
> CORE to MEMORY MANAGEMENT - MISC, as it seems the two are sufficiently
> related for this to be sensible.

... together with this means the pre-existing reviewers of CORE will now get
CC'd on everything under mm/ - I'm not sure if this consequence was apparent
and wanted, so pointing that out. Myself, as long as whole mm/ is there, I'd
rather not be one of the R: purely for volume reasons. The misc files
themselves would have been fine.

> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
> 
> Andrew - apologies, but there will likely be some small conflicts here
> given other MAINTAINERS patches move stuff from the MEMORY MANAGEMENT
> section too.
> 
> I kept patches separate in case one ends up having push-back we can still
> have the rest putting missing files in place.
> 
> Note that we also have [0] going through the slab tree, as it seemed a more
> suitable place to do that change to minimise conflicts on that front.
> 
> [0]: https://lore.kernel.org/all/20250722175901.152272-1-lorenzo.stoakes@oracle.com/
> 
> REVIEWERS NOTES:
> 
> This is based on discussions had in [1] both about this newly renamed
> section and where David indicated he was open to maintainership of the misc
> section.
> 
> I am sending un-RFC'd as, while a lot of files being moved about, it seems
> relatively safe to put these files in core/misc and we can move them around
> later if necessary.
> 
> Additionally, on the reviewers being added, these files are broadly files
> that could have been placed in the 'core' section, so this is more or less
> an administrative decision to split into two and so it seems reasonable to
> maintain the same list of people.
> 
> Apologies if this is overly presumptuous, the intent here is for us to
> finally reach a point (with the other patches applied) where (as far as I
> can tell) every memory management-related file should now have MAINTAINERS
> entries.
> 
> [1]: https://lore.kernel.org/all/20250616203844.566056-1-lorenzo.stoakes@oracle.com/
> 
>  MAINTAINERS | 82 +++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 57 insertions(+), 25 deletions(-)
> 

<trim>

> +MEMORY MANAGEMENT - MISC
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +M:	David Hildenbrand <david@redhat.com>
> +R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Mike Rapoport <rppt@kernel.org>
> +R:	Suren Baghdasaryan <surenb@google.com>
> +R:	Michal Hocko <mhocko@suse.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +W:	http://www.linux-mm.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	Documentation/admin-guide/mm/
> +F:	Documentation/mm/
> +F:	include/linux/memory-tiers.h
> +F:	include/linux/mempolicy.h
> +F:	include/linux/mempool.h
> +F:	include/linux/memremap.h

Weren't a bunch of these moved to other sections already?

> +F:	include/linux/mmu_notifier.h
> +F:	include/trace/events/ksm.h
> +F:	mm/
> +F:	mm/backing-dev.c
> +F:	mm/cma.c
> +F:	mm/cma_debug.c
> +F:	mm/cma_sysfs.c
> +F:	mm/dmapool.c
> +F:	mm/dmapool_test.c
> +F:	mm/early_ioremap.c
> +F:	mm/fadvise.c
> +F:	mm/io-mapping.c
> +F:	mm/ioremap.c
> +F:	mm/mapping_dirty_helpers.c
> +F:	mm/memory-tiers.c
> +F:	mm/mmu_notifier.c
> +F:	mm/page_idle.c
> +F:	mm/pgalloc-track.h
> +F:	mm/process_vm_access.c
> +F:	mm/ptdump.c
> +F:	tools/mm/
> +F:	tools/testing/selftests/mm/
> +
>  MEMORY MANAGEMENT - NUMA MEMBLOCKS AND NUMA EMULATION
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Mike Rapoport <rppt@kernel.org>
> --
> 2.50.1


