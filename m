Return-Path: <linux-kernel+bounces-888031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F035C399E4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72AD71A2384E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7663090C2;
	Thu,  6 Nov 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W5YLioDe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YWPtDJAM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W5YLioDe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YWPtDJAM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF2308F2E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418616; cv=none; b=iEc8IXnhyz4WBOz0nuOCSCvT9hSsH2JuSySWbjkE7NIgdJI4xwUJcoOiIGmFMtvDOKcCzHOz+UxVMuOvkklkjZgZgZeNVgyKQP/FiGewOH1xc0q0N3dAXW4MFXNeejF0YYO4tk3j+A18CxrQ2d7Xyefvu7vXDeqyQ3NaPKr6KeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418616; c=relaxed/simple;
	bh=ZDeDghbzOy39C1FvGkfbq9Z3wdNjCBw+/ecRLrAv1to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+huJb/x2b4IR0O9jgamd74otgOV8GKrfZr/24kZDpuHJBYw700SP77AOF3Np4LOGyV4ObONoCdWch7U78i0ytlYR028NlQd/Wr1lman78LtKrdR0cafiplxCbgD/ANNXKC/7y0OHrv+1RNSX2W6BmyrEAUX0rHsFqwNvTcYtDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W5YLioDe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YWPtDJAM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W5YLioDe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YWPtDJAM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75EE921194;
	Thu,  6 Nov 2025 08:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762418607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sswmt4J0aLVPOKtr4xhZAlr6mDBfGuLUTP9RQrzr0jk=;
	b=W5YLioDeqt4MRMm2tCeuY30dkbESv/0KIobVbol6iQnwgx1f5ntgWo3JXcvAe1R9mwxfiW
	sEPM6aDtV9rkDTRUugSqcooiKrqS4pAdJ0JAQnmMj2YUZDVNy2ufidKYQ3SLcbiYap6MPk
	QMS4KZwYJOOTftOOXxKSvMnwc+XpVBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762418607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sswmt4J0aLVPOKtr4xhZAlr6mDBfGuLUTP9RQrzr0jk=;
	b=YWPtDJAMywHqn42RxiKz+H19fg0gajP748WkVn2MKMBq52XwhBD14IZkYSOAWe03kHINvC
	7Iqa0ipvdAPm2JBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762418607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sswmt4J0aLVPOKtr4xhZAlr6mDBfGuLUTP9RQrzr0jk=;
	b=W5YLioDeqt4MRMm2tCeuY30dkbESv/0KIobVbol6iQnwgx1f5ntgWo3JXcvAe1R9mwxfiW
	sEPM6aDtV9rkDTRUugSqcooiKrqS4pAdJ0JAQnmMj2YUZDVNy2ufidKYQ3SLcbiYap6MPk
	QMS4KZwYJOOTftOOXxKSvMnwc+XpVBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762418607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sswmt4J0aLVPOKtr4xhZAlr6mDBfGuLUTP9RQrzr0jk=;
	b=YWPtDJAMywHqn42RxiKz+H19fg0gajP748WkVn2MKMBq52XwhBD14IZkYSOAWe03kHINvC
	7Iqa0ipvdAPm2JBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DA6B13A31;
	Thu,  6 Nov 2025 08:43:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BJn5A69fDGmKZQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 06 Nov 2025 08:43:27 +0000
Date: Thu, 6 Nov 2025 08:43:25 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Robert Dinse <nanook@eskimo.com>
Cc: mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Folio Related Stability Crashes in 6.17.5 and 6.17.6
Message-ID: <erytfim3m6fy7qy3tmfwwkr6ymvyfoevhwsac4xtadimei6ux5@um6ylfu5e4ci>
References: <b964df0f-45e3-4fea-a84d-852869b49502@eskimo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b964df0f-45e3-4fea-a84d-852869b49502@eskimo.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed, Nov 05, 2025 at 07:19:17PM -0800, Robert Dinse wrote:
>       Since 6.17.5 I have twice had one of my servers lock up in a state
> where it still routed network traffic and responded to pings but no user
> programs are running.
> 
>      These are proceeded by kernel splats:
>

Are you sure it didn't ever repro on 6.17.5?
Also, I'm wondering if you have the rest of the dmesg?

> [542551.007650] [    T238] INFO: task php8.3:1373100 blocked for more than
> 614 seconds.
> [542551.007652] [    T238]       Tainted: G S      W   E  6.17.6 #1
> [542551.007653] [    T238] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [542551.007654] [    T238] task:php8.3          state:D stack:0  pid:1373100
> tgid:1373100 ppid:5513   task_flags:0x400000 flags:0x00004002
> [542551.007657] [    T238] Call Trace:
> [542551.007658] [    T238]  <TASK>
> [542551.007659] [    T238]  __schedule+0x41c/0x16b0
> [542551.007661] [    T238]  ? _raw_spin_unlock_bh+0x1d/0x30
> [542551.007664] [    T238]  ? tcp_cleanup_rbuf+0x43/0xa0
> [542551.007670] [    T238]  schedule+0x20/0xe0
> [542551.007671] [    T238]  io_schedule+0x4c/0x80
> [542551.007673] [    T238]  folio_wait_bit+0x102/0x200

This does not have anything to do with folios (probably), but it looks like
swap IO is stuck. So, could possibly even be a block IO problem.

> [542551.007676] [    T238]  ? __pfx_wake_page_function+0x10/0x10
> [542551.007678] [    T238]  folio_wait_writeback+0x2e/0x80
> [542551.007680] [    T238]  shmem_swapin_folio+0x58d/0x1210
> [542551.007683] [    T238]  ? mod_memcg_lruvec_state+0xed/0x2b0
> [542551.007686] [    T238]  ? xas_load+0x11/0x100
> [542551.007688] [    T238]  ? filemap_get_entry+0x60/0x1c0
> [542551.007690] [    T238]  ? __lruvec_stat_mod_folio+0x7a/0xc0
> [542551.007693] [    T238]  shmem_get_folio_gfp+0x17a/0x5f0
> [542551.007696] [    T238]  shmem_fault+0x7a/0x390
> [542551.007698] [    T238]  __do_fault+0x38/0x1b0
> [542551.007701] [    T238]  do_fault+0x2bc/0x5b0
> [542551.007703] [    T238]  ? __x64_sys_alarm+0x61/0xb0
> [542551.007707] [    T238]  __handle_mm_fault+0x439/0xfc0
> [542551.007709] [    T238]  ? x64_sys_call+0x17e7/0x2330
> [542551.007715] [    T238]  handle_mm_fault+0xeb/0x2f0
> [542551.007718] [    T238]  do_user_addr_fault+0x203/0x690
> [542551.007720] [    T238]  exc_page_fault+0x7f/0x170
> [542551.007722] [    T238]  asm_exc_page_fault+0x27/0x30
> <snip>
> [542551.008011] [    T238] Kernel panic - not syncing: hung_task: blocked
> tasks
> [542551.008013] [    T238] CPU: 16 UID: 0 PID: 238 Comm: khungtaskd Kdump:
> loaded Tainted: G S      W   E       6.17.6 #1 NONE
> [542551.008017] [    T238] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN,
> [E]=UNSIGNED_MODULE

So, you have 1) CPU_OUT_OF_SPEC (wondering how you even have that?),
2) WARN before (which possibly explains this hang)

> <snip> 
>      Am running self compiled kernel on Ubuntu 24.04 system.  The .config
> used to generate the kernel is attached.  The compiler used is gcc 15.2. 
> The hardware this is running on is an i9-10980xe based machine clocked at
> 4.4Ghz all cores with -8 multiplier offset for avx512, -3 multiplier offset
> for AVX2.  The machine is equipped with 256G of RAM. There are three RAID1
> arrays, one based upon two SN770 WD Black nvme 1G drives mounted on /root,
> another based upon 13TB CMD drives on /space and a third on 13TB SMR drives
> on /bu.  We use Apache/2.4.65 (Unix) OpenSSL/3.6.0-dev and PHP from 5.6 to
> 8.3, most applications on 8.3.

So, yeah. As you mentioned on another email, a crashdump could most
definitely prove useful, but that's a PITA to setup. I think the full
dmesg could possibly be the key here. I would not be surprised if this
turns out to be a bug in another place.

-- 
Pedro

