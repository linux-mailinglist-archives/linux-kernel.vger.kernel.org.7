Return-Path: <linux-kernel+bounces-820225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0FAB7C4CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648152A0B50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3235B308F0E;
	Wed, 17 Sep 2025 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QKy9gYy1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QQ98NDyL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O9pfrPeR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TWhAn3zE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73B23081DB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097133; cv=none; b=EuR/ildqdnX2rktdYeZRB1svFL/ZvM71H4uo2D9EKEN3XtbT4Srxr0yMqaWQ+dDb7IeCGGackQpHLUo3g+tTFhOiNwFcSGQ0dKXgznGqzZ3eZX/LdNM22xjhJLOZULRaFOhN/GWwzDFbIzLM/gWloC1Gn2UaHk65+y4TBSx37O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097133; c=relaxed/simple;
	bh=tHTS98ix6fubxBMrfZDjVgQq/C9j1OXsT1BzpJOfVJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZwpKuRT4c/egViKgCdcEjp9l3XkQBs63L3MO+l1tpTpY0XoutJlawvfaPn9Jz/4io+uy4bs9qPyKGMzYAZObYOZUzyvat98Uc1c2ZdIuQidjMggyT0gnt3QGkpLF3piPvUdhiZsFOfPC9MIyAzihHJrMebOlR8kyvD5KDTmgqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QKy9gYy1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QQ98NDyL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O9pfrPeR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TWhAn3zE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9EF9221A4;
	Wed, 17 Sep 2025 08:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758097130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0gIuU9BfAksM0VCnmAs6vvgKEo+iRNtzKZCzt55LcHE=;
	b=QKy9gYy1ComwTc+vQCBzK3bAN4dI0pAG2Q3EfLESztOs+tFGBj0U8DAYF1TqSK4Jpw7V+U
	T62o8AE25X3FktxqSp4KPYalsKvs5STJLZK+VvVuSxE4u0uewYMaVIVgWgmJdzrdt+MRT0
	F2Nlk4lHnWqGrzIOchrkGY/UB1CJANk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758097130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0gIuU9BfAksM0VCnmAs6vvgKEo+iRNtzKZCzt55LcHE=;
	b=QQ98NDyL4IE5tPlNNPIwQyIjn4gEX7IDvrZR5d58smXRM3ZBwOfvSQDaafIavRKF4/3i8w
	VVi2GX0dnULrtwBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758097129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0gIuU9BfAksM0VCnmAs6vvgKEo+iRNtzKZCzt55LcHE=;
	b=O9pfrPeRKeta0cqOznkr0QMpC4z2NnMdlI88YFcDhieFTcRoAJ/t+qciFLBxCp7d0L7gHx
	GXOUDFc3yUodTyutNxefB2/W/GRo6ynt9drtotTOIhYOewFOf5zshtGKUCBUlGBvvhhpBZ
	qgvG9DPoTBkvSa6+4EsUb/CFh7oB16U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758097129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0gIuU9BfAksM0VCnmAs6vvgKEo+iRNtzKZCzt55LcHE=;
	b=TWhAn3zEp97BkxWyLCYfe2R+zA/uCSQ9cg8Ale7wGXgldTdEbRYPVq5rAvexdSBOJ5Il1E
	p6I64rVvp3X7APAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 156621368D;
	Wed, 17 Sep 2025 08:18:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tmJsAeluymhZBAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 17 Sep 2025 08:18:49 +0000
Date: Wed, 17 Sep 2025 10:18:47 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Jane Chu <jane.chu@oracle.com>
Cc: david@redhat.com, harry.yoo@oracle.com, liushixin2@huawei.com,
	muchun.song@linux.dev, akpm@linux-foundation.org, jannh@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] mm/hugetlb: fix copy_hugetlb_page_range() to
 use ->pt_share_count
Message-ID: <aMpu58yNnLWszoqX@localhost.localdomain>
References: <20250916191252.1653993-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916191252.1653993-1-jane.chu@oracle.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On Tue, Sep 16, 2025 at 01:12:52PM -0600, Jane Chu wrote:
> commit 59d9094df3d79 ("mm: hugetlb: independent PMD page table shared count")
> introduced ->pt_share_count dedicated to hugetlb PMD share count tracking,
> but omitted fixing copy_hugetlb_page_range(), leaving the function relying on
> page_count() for tracking that no longer works.
> 
> When lazy page table copy for hugetlb is disabled, that is, revert
> commit bcd51a3c679d ("hugetlb: lazy page table copies in fork()")
> fork()'ing with hugetlb PMD sharing quickly lockup -
> 
> [  239.446559] watchdog: BUG: soft lockup - CPU#75 stuck for 27s!
> [  239.446611] RIP: 0010:native_queued_spin_lock_slowpath+0x7e/0x2e0
> [  239.446631] Call Trace:
> [  239.446633]  <TASK>
> [  239.446636]  _raw_spin_lock+0x3f/0x60
> [  239.446639]  copy_hugetlb_page_range+0x258/0xb50
> [  239.446645]  copy_page_range+0x22b/0x2c0
> [  239.446651]  dup_mmap+0x3e2/0x770
> [  239.446654]  dup_mm.constprop.0+0x5e/0x230
> [  239.446657]  copy_process+0xd17/0x1760
> [  239.446660]  kernel_clone+0xc0/0x3e0
> [  239.446661]  __do_sys_clone+0x65/0xa0
> [  239.446664]  do_syscall_64+0x82/0x930
> [  239.446668]  ? count_memcg_events+0xd2/0x190
> [  239.446671]  ? syscall_trace_enter+0x14e/0x1f0
> [  239.446676]  ? syscall_exit_work+0x118/0x150
> [  239.446677]  ? arch_exit_to_user_mode_prepare.constprop.0+0x9/0xb0
> [  239.446681]  ? clear_bhb_loop+0x30/0x80
> [  239.446684]  ? clear_bhb_loop+0x30/0x80
> [  239.446686]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> There are two options to resolve the potential latent issue:
>   1. warn against PMD sharing in copy_hugetlb_page_range(),
>   2. fix it.
> This patch opts for the second option.
> While at it, simplify the comment, the details are not actually relevant
> anymore.
> 
> Fixes: 59d9094df3d79 ("mm: hugetlb: independent PMD page table shared count")
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks


-- 
Oscar Salvador
SUSE Labs

