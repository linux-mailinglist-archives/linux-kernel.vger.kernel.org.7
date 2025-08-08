Return-Path: <linux-kernel+bounces-760795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBB5B1F03F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 23:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E790565CF0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD30244E8C;
	Fri,  8 Aug 2025 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WvkJF2MV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1/9xl/VC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VlFEcN1+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V21WGjzr"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54321ADB9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754688725; cv=none; b=mb2gR3L7eTtThLyOgs/LNCkDmx8eTLpRNKr8RnwY6AbtjNftFJE6Ow4NXhTGwjwTv42wEVZBexQMR5+Y8kj3N5CbwFhJm86iVtX4pOV+e9TiNTng4RofRrf4fNQ5AJw0NWr7VKcLVFoCMt03d0uKHZwZYuYMCAh9+TZONHd7U5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754688725; c=relaxed/simple;
	bh=KD6MyFkEfBenKf/K2EH/YSf7Qowxg5WV6+qQzc7Km0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXP2iLJiaa5lFOHreSyIJPR5HzCykQJh66P2MjMvIFekyxcfA45W4eyr/t1Yfwu1wnGNMTrYXhAtH5kerDS92ahYvZQ8IN8yPGGK0bQNXAlwTigscxX+aDEEZ2IP0wbSoZMjStsWUbW0a18WPfLwafQaQjBZKAGij2ARgH7SUAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WvkJF2MV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1/9xl/VC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VlFEcN1+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V21WGjzr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EEDDE5BE9D;
	Fri,  8 Aug 2025 21:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754688720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ozpPeuGz/5jR8RvrsN+ym3S5Zd0rR0WHaXf/FgJQh6A=;
	b=WvkJF2MV28XaR7NjO9JlgURbxOnMk04dnMp3rU4DB+pvF138qC1HM2dOGur2+tvInHtwhn
	jfNI+6dwVILpfddZ5FmtdADWInRef0Aa4aDmpkDE8OeG6hXziJoFvpb5otsMlx91lJkn9p
	2m/F5CAyCG+GyMGd/F8hyoXHpYBBgLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754688720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ozpPeuGz/5jR8RvrsN+ym3S5Zd0rR0WHaXf/FgJQh6A=;
	b=1/9xl/VCICqUNFJtiSIuAX5jSdnseyst7G72Zy0fJ2FKOjxsvcQ5ttp93n869MszjrK2oR
	zLat/mG/+eJP8NBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754688719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ozpPeuGz/5jR8RvrsN+ym3S5Zd0rR0WHaXf/FgJQh6A=;
	b=VlFEcN1+KLihWbtuyRDQBtfXWzk0WoralxzzPCXwgLkywvuLnKCdmwApiPQcdkM4PbR3GB
	DzsEFBuBRWQ/HbMHepl0O+uKty1mFsgMInZlfJW4cQ21pnxwft9x75plbp0d6nKcdj42kS
	7U5Fal2G9obLQfUOO5e1J4/vZjHztUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754688719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ozpPeuGz/5jR8RvrsN+ym3S5Zd0rR0WHaXf/FgJQh6A=;
	b=V21WGjzrpRzk35KZ/w/wPCKv/uza/4Jmfd/mwutbrrQnlrPEXgiG0XLJYDwrNWrx1hWeLe
	AJjdavret2ktQQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A2261392A;
	Fri,  8 Aug 2025 21:31:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZjKwBs9slmgRHgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 08 Aug 2025 21:31:59 +0000
Date: Fri, 8 Aug 2025 22:32:01 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: kernel test robot <lkp@intel.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	linux-riscv@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: ld.lld: error: Function Import: link error: linking module flags
 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at
 1229286), and 'i32 1' from vmlinux.a(vma_exec.o at 1246866)
Message-ID: <j6pxm4n2n3tnan22x73ff3ku6dwr6e65mi4tafjmlyoicbpygi@vbjbioh7p5fx>
References: <202508082339.sjRnzZrX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508082339.sjRnzZrX-lkp@intel.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

This doesn't look particularly mm related, CC'd riscv and kernel llvm lists.

On Sat, Aug 09, 2025 at 12:09:05AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   37816488247ddddbc3de113c78c83572274b1e2e
> commit: dd7a6246f4fd6e8a6dcb08f1f51c899f3e0d3b83 mm: abstract initial stack setup to mm subsystem
> date:   3 months ago
> config: riscv-randconfig-r071-20250729 (https://download.01.org/0day-ci/archive/20250808/202508082339.sjRnzZrX-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 1b4db78d2eaa070b3f364a2d2b2b826a5439b892)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250808/202508082339.sjRnzZrX-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508082339.sjRnzZrX-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(core.o at 1243626)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(ring_buffer.o at 1239546)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(vmalloc.o at 1246746)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(memory.o at 1246026)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(main.o at 1225686)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(output.o at 1404306)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(mmap.o at 1246206)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(vma.o at 1246806)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(drm_gem.o at 1315866)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(drm_gem_shmem_helper.o at 1317846)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(virtgpu_vram.o at 1327806)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 1' from vmlinux.a(alternative.o at 1226286), and 'i32 3' from vmlinux.a(init.o at 1229286)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(direct-io.o at 1251666)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(debug_vm_pgtable.o at 1247886)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(drm_gem_dma_helper.o at 1317726)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(blk-lib.o at 1282566)
> >> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(vma_exec.o at 1246866)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(context.o at 1229706)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(setup.o at 1226826)
>    ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 1229286), and 'i32 1' from vmlinux.a(physaddr.o at 1229886)
>    ld.lld: error: too many errors emitted, stopping now (use --error-limit=0 to see all errors)
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
Pedro

