Return-Path: <linux-kernel+bounces-836048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A33EBA89D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A32C1881B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D560928725E;
	Mon, 29 Sep 2025 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bkgRotVV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C7v1FoqY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bkgRotVV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C7v1FoqY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698F0285CBF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138054; cv=none; b=HhhmI7/dLv8cbkHJN8aEf6fmbWANJ/Dyw3wgOYLYL5dyg5tdBFgVJKl3fqqpLhBcmcWeCZJjth6/tQ0a96BwYYZp+416D4d+jvf/SBbl5T/O8vIt62NR+lE9xmCvCShicq1RUsq/Qf0ELCPxLwHxge8XKUMwUq9SD6rZtQsAjhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138054; c=relaxed/simple;
	bh=D8cNfGS1Qx+NvxaeGxBxIPlZJrNg3Kib+Kalcokq6iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svD34VQoXfPiFkklxL0O4q1xa7bq4sp7elCAK5tsEcPt6XXSu8CC0a+sWIG299R+XMlRGn5XqQdBnfPE/7KzgCZD7y7DBirR6i/G1tGZ7dLVufP2R2buzl6TIIIewphF0777KFsTDzbj/8xMYPoBny/PvYB0vHdSr0frj82XWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bkgRotVV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C7v1FoqY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bkgRotVV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C7v1FoqY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3922E2099A;
	Mon, 29 Sep 2025 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759138050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THAGxl1trzNBHfjS0/K74QzBCVdosk64YkSPhfoLeBg=;
	b=bkgRotVVMBWn6oomD82XK13KXxaLnMiyRpu5U+STT7FwHdQh4yaUREvUo2XPmYR8P61Y86
	KoQK5dMP0GG8bz5e22YjbeaEdAgtQeeLoBm8eXBZ4wtmtadXc7sGeXoOnyRqFUyTR/U4m5
	mPqvjlrFbxc2jo9sRzoPEAmjA7s7NnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759138050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THAGxl1trzNBHfjS0/K74QzBCVdosk64YkSPhfoLeBg=;
	b=C7v1FoqYE59RN5ryAIF6wzn0ovidI+j/mVDXSdP8PTXrizDKGI9wi07tXmoTggbv8abPHV
	TlYrovP5EuUOUkCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bkgRotVV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=C7v1FoqY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759138050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THAGxl1trzNBHfjS0/K74QzBCVdosk64YkSPhfoLeBg=;
	b=bkgRotVVMBWn6oomD82XK13KXxaLnMiyRpu5U+STT7FwHdQh4yaUREvUo2XPmYR8P61Y86
	KoQK5dMP0GG8bz5e22YjbeaEdAgtQeeLoBm8eXBZ4wtmtadXc7sGeXoOnyRqFUyTR/U4m5
	mPqvjlrFbxc2jo9sRzoPEAmjA7s7NnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759138050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THAGxl1trzNBHfjS0/K74QzBCVdosk64YkSPhfoLeBg=;
	b=C7v1FoqYE59RN5ryAIF6wzn0ovidI+j/mVDXSdP8PTXrizDKGI9wi07tXmoTggbv8abPHV
	TlYrovP5EuUOUkCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F0BC13782;
	Mon, 29 Sep 2025 09:27:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yposIAFR2mh0SAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 29 Sep 2025 09:27:29 +0000
Date: Mon, 29 Sep 2025 11:27:27 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: muchun.song@linux.dev, david@redhat.com, akpm@linux-foundation.org,
	catalin.marinas@arm.com, will@kernel.org,
	carl@os.amperecomputing.com, cl@gentwo.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb: avoid soft lockup when mprotect with
 PROT_MTE
Message-ID: <aNpQ_-uwp7gQDH__@localhost.localdomain>
References: <20250926162034.1785899-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926162034.1785899-1-yang@os.amperecomputing.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3922E2099A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On Fri, Sep 26, 2025 at 09:20:34AM -0700, Yang Shi wrote:
> When calling mprotect() with PROT_MTE, kernel will initialize MTE tags
> for every single page in the affected area. Soft lockup was observed
> when doing this for large HugeTLB memory area in our customer's workload
> (~300GB memory):
> 
> watchdog: BUG: soft lockup - CPU#98 stuck for 23s! [t2_new_sysv:126916]
> 
> CPU: 98 PID: 126916 Comm: t2_new_sysv Kdump: loaded Not tainted 6.17-rc7
> Hardware name: GIGACOMPUTING R2A3-T40-AAV1/Jefferson CIO, BIOS 5.4.4.1 07/15/2025
> pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : mte_clear_page_tags+0x14/0x24
> lr : mte_sync_tags+0x1c0/0x240
> sp : ffff80003150bb80
> x29: ffff80003150bb80 x28: ffff00739e9705a8 x27: 0000ffd2d6a00000
> x26: 0000ff8e4bc00000 x25: 00e80046cde00f45 x24: 0000000000022458
> x23: 0000000000000000 x22: 0000000000000004 x21: 000000011b380000
> x20: ffff000000000000 x19: 000000011b379f40 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc875e0aa5e2c
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : fffffc01ce7a5c00 x4 : 00000000046cde00 x3 : fffffc0000000000
> x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff0046cde7c000
> 
> Call trace:
>   mte_clear_page_tags+0x14/0x24
>   set_huge_pte_at+0x25c/0x280
>   hugetlb_change_protection+0x220/0x430
>   change_protection+0x5c/0x8c
>   mprotect_fixup+0x10c/0x294
>   do_mprotect_pkey.constprop.0+0x2e0/0x3d4
>   __arm64_sys_mprotect+0x24/0x44
>   invoke_syscall+0x50/0x160
>   el0_svc_common+0x48/0x144
>   do_el0_svc+0x30/0xe0
>   el0_svc+0x30/0xf0
>   el0t_64_sync_handler+0xc4/0x148
>   el0t_64_sync+0x1a4/0x1a8
> 
> Soft lockup is not triggered with THP or base page because there is
> cond_resched() called for each PMD size.
> 
> So add cond_resched() for hugetlb to avoid soft lockup.
> 
> Fixes: 25c17c4b55de ("hugetlb: arm64: add mte support")
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/hugetlb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index cb5c4e79e0b8..fe6606d91b31 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7242,6 +7242,8 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  						psize);
>  		}
>  		spin_unlock(ptl);
> +
> +		cond_resched();
>  	}
>  	/*
>  	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare
> -- 
> 2.47.0
> 

-- 
Oscar Salvador
SUSE Labs

