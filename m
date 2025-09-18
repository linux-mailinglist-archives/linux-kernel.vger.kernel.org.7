Return-Path: <linux-kernel+bounces-756828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559CDB1B9E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BB917329A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23DA86348;
	Tue,  5 Aug 2025 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iNl2pgjD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xt8PBYPa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PlO0nfK+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Otk+vfNt"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E119F11F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754417789; cv=none; b=kwEcFvGnOlfvAou9UAXIxv1MJX1Mob+UKfOZzKaJnGyTUErzsBS21HoebgsYmJovyaD7aFBWHO/D35xO1Z9BxSZ+OxZ56UUi483+KQxPsxua/XnnWmF7TTLDg3WOEHyppXYEiozspi/oknnQcWKN51MeUZJVKU2ZKSs2w5H5CGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754417789; c=relaxed/simple;
	bh=paPKQLL3rT1sD/2J3WmRf5gKr74E/PEBLq+bue489v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzLmt7dPKzq7EqZCX4QO0v0veZjPlU30YduUrzEZ0lRl2Et6m89BTuMj5eGoHmq1eohPrEsBmaixiTdXLkGNye5cI131eaPMSCywV2Vx5lx22ESmEPttYEpxN49dDkYVwfq8Yv0ix/hzM3ai5VEO0FEBJNWHO0Jpvv5eaZ30PyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iNl2pgjD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xt8PBYPa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PlO0nfK+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Otk+vfNt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 56E7721193;
	Tue,  5 Aug 2025 18:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754417785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kctONQzn+jRpnndVX91JrtKpnDWaCyDUo9tEJAtdgGM=;
	b=iNl2pgjDS71m88IGR4V+S9Yn6p+llNxCRAI7apwGK92OEExlbNeRDk4D+xzVr8a1NrIq3Z
	Nw85eCKaFpBoOvflgr2jsaytL2H/wdwD2aiyW0plSFolN2Zp/f88VLHZKItpFFTttGLzPZ
	MFXAYO3Ue6ehbEzvP8Cyoosu+bfBznc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754417785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kctONQzn+jRpnndVX91JrtKpnDWaCyDUo9tEJAtdgGM=;
	b=Xt8PBYPaf5GUc6GLwdJzmoQWHV0rE+YJFPOG61e8Kla2mBuskuQ9IOX7/n8XGBY3SVoGij
	f0l3Ddt8qedIJfAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PlO0nfK+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Otk+vfNt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754417784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kctONQzn+jRpnndVX91JrtKpnDWaCyDUo9tEJAtdgGM=;
	b=PlO0nfK+KZH4y8bXLlnirCWUV2OWXLg+C4vAU+aAdTYfQbUoPJwt2XW+gYlmqs+McpPLGf
	gqhYO3szx7Jba4wkVt8fv5+KMI2Wuk+wS7TUKoZnvBmoLJiAWreKKCoRNxkgipuySM/OEV
	2UY4jhz3BI/lfWBhLXJAp3BE8pS4GTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754417784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kctONQzn+jRpnndVX91JrtKpnDWaCyDUo9tEJAtdgGM=;
	b=Otk+vfNtzVmCV1yUpRFzvUgX1vd37pZI9pdNddnF7MWfe6kw7+YPUitFOAkRh8SvnG6XeK
	6r1VD6FyopbK/TAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5CF713A50;
	Tue,  5 Aug 2025 18:16:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4+CmJndKkmhRHgAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Tue, 05 Aug 2025 18:16:23 +0000
Date: Tue, 5 Aug 2025 15:16:17 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: Steve French <smfrench@gmail.com>
Cc: Wang Zhaolong <wangzhaolong@huaweicloud.com>, pshilov@microsoft.com, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	chengzhihao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH V2 0/4] Fix mid_q_entry memory leaks in SMB client
Message-ID: <wsdy24ihyizjw5ce4jnomhos3zwnbzdjx63qxywv5ud6kekcf5@ocqq2p6qobu3>
References: <20250805064708.332465-1-wangzhaolong@huaweicloud.com>
 <CAH2r5mssz19Qr+fmY62BnHOzwjQmWWU=wHXEVFkyTRGaWn-t0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAH2r5mssz19Qr+fmY62BnHOzwjQmWWU=wHXEVFkyTRGaWn-t0g@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 56E7721193
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On 08/05, Steve French wrote:
>The first three patches (cleanup) look fine and have added to
>cifs-2.6.git for-next (also added Enzo Acked-by) but the fourth patch
>("smb: client: fix mid_q_entry memleak leak with per-mid locking")
>causes xfstest generic/001 to fail with signing enabled.  See
>http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/5=
/builds/58/steps/34/logs/stdio
>and http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builde=
rs/5/builds/59/steps/34/logs/stdio

Was about to reply here as I was testing (an unrelated patch) with generic/=
100
and got the same backtrace.

@Wang btw sorry I missed your reproducer in the bugzilla link, I'll take
a look.  Thanks!

>[Tue Aug 5 11:03:32 2025] run fstests generic/001 at 2025-08-05 11:03:32
>[Tue Aug 5 11:03:33 2025] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>[Tue Aug 5 11:03:33 2025] [ BUG: Invalid wait context ]
>[Tue Aug 5 11:03:33 2025] 6.16.0 #1 Tainted: G E
>[Tue Aug 5 11:03:33 2025] -----------------------------
>[Tue Aug 5 11:03:33 2025] cifsd/24912 is trying to lock:
>[Tue Aug 5 11:03:33 2025] ffffffffafc14630
>(crypto_alg_sem){++++}-{4:4}, at: crypto_alg_lookup+0x40/0x120
>[Tue Aug 5 11:03:33 2025] other info that might help us debug this:
>[Tue Aug 5 11:03:33 2025] context-{5:5}
>[Tue Aug 5 11:03:33 2025] 1 lock held by cifsd/24912:
>[Tue Aug 5 11:03:33 2025] #0: ff11000134c25870
>(&temp->mid_lock){+.+.}-{3:3}, at: mid_execute_callback+0x19/0x40
>[cifs]
>[Tue Aug 5 11:03:33 2025] stack backtrace:
>[Tue Aug 5 11:03:33 2025] CPU: 1 UID: 0 PID: 24912 Comm: cifsd
>Tainted: G E 6.16.0 #1 PREEMPT(voluntary)
>[Tue Aug 5 11:03:33 2025] Tainted: [E]=3DUNSIGNED_MODULE
>[Tue Aug 5 11:03:33 2025] Hardware name: Red Hat KVM, BIOS
>1.16.3-4.el9 04/01/2014
>[Tue Aug 5 11:03:33 2025] Call Trace:
>[Tue Aug 5 11:03:33 2025] <TASK>
>[Tue Aug 5 11:03:33 2025] dump_stack_lvl+0x79/0xb0
>[Tue Aug 5 11:03:33 2025] __lock_acquire+0xace/0x21c0
>[Tue Aug 5 11:03:33 2025] ? check_irq_usage+0xa4/0xa80
>[Tue Aug 5 11:03:33 2025] lock_acquire+0x143/0x2d0
>[Tue Aug 5 11:03:33 2025] ? crypto_alg_lookup+0x40/0x120
>[Tue Aug 5 11:03:33 2025] ? check_noncircular+0x71/0x120
>[Tue Aug 5 11:03:33 2025] down_read+0x7c/0x2e0
>[Tue Aug 5 11:03:33 2025] ? crypto_alg_lookup+0x40/0x120
>[Tue Aug 5 11:03:33 2025] ? __pfx_down_read+0x10/0x10
>[Tue Aug 5 11:03:33 2025] ? lockdep_unlock+0x51/0xc0
>[Tue Aug 5 11:03:33 2025] ? __lock_acquire+0x11ee/0x21c0
>[Tue Aug 5 11:03:33 2025] crypto_alg_lookup+0x40/0x120
>[Tue Aug 5 11:03:33 2025] crypto_alg_mod_lookup+0x53/0x2b0
>[Tue Aug 5 11:03:33 2025] crypto_alloc_tfm_node+0x76/0x130
>[Tue Aug 5 11:03:33 2025] cifs_alloc_hash+0x44/0x130 [cifs]
>[Tue Aug 5 11:03:33 2025] smb3_calc_signature+0x4f0/0x7b0 [cifs]
>[Tue Aug 5 11:03:33 2025] ? __pfx_smb3_calc_signature+0x10/0x10 [cifs]
>[Tue Aug 5 11:03:33 2025] ? find_held_lock+0x2b/0x80
>[Tue Aug 5 11:03:33 2025] ? tcp_recvmsg+0xc9/0x2d0
>[Tue Aug 5 11:03:33 2025] ? rcu_is_watching+0x20/0x50
>[Tue Aug 5 11:03:33 2025] ? trace_irq_enable.constprop.0+0xac/0xe0
>[Tue Aug 5 11:03:33 2025] ? tcp_recvmsg+0xc9/0x2d0
>[Tue Aug 5 11:03:33 2025] ? __local_bh_enable_ip+0x90/0xf0
>[Tue Aug 5 11:03:33 2025] ? sock_has_perm+0x97/0x1a0
>[Tue Aug 5 11:03:33 2025] smb2_verify_signature+0x178/0x290 [cifs]
>[Tue Aug 5 11:03:33 2025] ? __pfx_smb2_verify_signature+0x10/0x10 [cifs]
>[Tue Aug 5 11:03:33 2025] ? look_up_lock_class+0x5d/0x140
>[Tue Aug 5 11:03:33 2025] smb2_check_receive+0x154/0x1c0 [cifs]
>[Tue Aug 5 11:03:33 2025] ? __pfx_smb2_check_receive+0x10/0x10 [cifs]
>[Tue Aug 5 11:03:33 2025] ? __lock_acquire+0x3f1/0x21c0
>[Tue Aug 5 11:03:33 2025] ? __lock_acquire+0x3f1/0x21c0
>[Tue Aug 5 11:03:33 2025] smb2_writev_callback+0x1f2/0x870 [cifs]
>[Tue Aug 5 11:03:33 2025] ? lock_acquire+0x143/0x2d0
>[Tue Aug 5 11:03:33 2025] ? mid_execute_callback+0x19/0x40 [cifs]
>[Tue Aug 5 11:03:33 2025] ? __pfx_smb2_writev_callback+0x10/0x10 [cifs]
>[Tue Aug 5 11:03:33 2025] ? do_raw_spin_lock+0x10c/0x190
>[Tue Aug 5 11:03:33 2025] ? __pfx_do_raw_spin_lock+0x10/0x10
>[Tue Aug 5 11:03:33 2025] ? _raw_spin_unlock+0x23/0x40
>[Tue Aug 5 11:03:33 2025] mid_execute_callback+0x33/0x40 [cifs]
>[Tue Aug 5 11:03:33 2025] cifs_demultiplex_thread+0xc95/0x15e0 [cifs]
>[Tue Aug 5 11:03:33 2025] ? __pfx_cifs_demultiplex_thread+0x10/0x10 [cifs]
>[Tue Aug 5 11:03:33 2025] ? find_held_lock+0x2b/0x80
>[Tue Aug 5 11:03:33 2025] ? __kthread_parkme+0x4b/0xd0
>[Tue Aug 5 11:03:33 2025] ? __pfx_cifs_demultiplex_thread+0x10/0x10 [cifs]
>[Tue Aug 5 11:03:33 2025] kthread+0x216/0x3e0
>[Tue Aug 5 11:03:33 2025] ? __pfx_kthread+0x10/0x10
>[Tue Aug 5 11:03:33 2025] ? __pfx_kthread+0x10/0x10
>[Tue Aug 5 11:03:33 2025] ? lock_release+0xc4/0x270
>[Tue Aug 5 11:03:33 2025] ? rcu_is_watching+0x20/0x50
>[Tue Aug 5 11:03:33 2025] ? __pfx_kthread+0x10/0x10
>[Tue Aug 5 11:03:33 2025] ret_from_fork+0x23a/0x2e0
>[Tue Aug 5 11:03:33 2025] ? __pfx_kthread+0x10/0x10
>[Tue Aug 5 11:03:33 2025] ret_from_fork_asm+0x1a/0x30
>[Tue Aug 5 11:03:33 2025] </TASK>
>
>(it worked without the patch see e.g.
>http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/5=
/builds/60
>and http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builde=
rs/5/builds/56)
>
>On Tue, Aug 5, 2025 at 1:54=E2=80=AFAM Wang Zhaolong
><wangzhaolong@huaweicloud.com> wrote:
>>
>> I've been investigating a pretty nasty memory leak in the SMB client. Wh=
en
>> compound requests get interrupted by signals, we end up with mid_q_entry
>> structures and server buffers that never get freed[1].
>>
>> User foreground process                    cifsd
>> cifs_readdir
>>  open_cached_dir
>>   cifs_send_recv
>>    compound_send_recv
>>     smb2_setup_request
>>      smb2_mid_entry_alloc
>>       smb2_get_mid_entry
>>        smb2_mid_entry_alloc
>>         mempool_alloc // alloc mid
>>         kref_init(&temp->refcount); // refcount =3D 1
>>      mid[0]->callback =3D cifs_compound_callback;
>>      mid[1]->callback =3D cifs_compound_last_callback;
>>      smb_send_rqst
>>      rc =3D wait_for_response
>>       wait_event_state TASK_KILLABLE
>>                                   cifs_demultiplex_thread
>>                                     allocate_buffers
>>                                       server->bigbuf =3D cifs_buf_get()
>>                                     standard_receive3
>>                                       ->find_mid()
>>                                         smb2_find_mid
>>                                           __smb2_find_mid
>>                                            kref_get(&mid->refcount) // +1
>>                                       cifs_handle_standard
>>                                         handle_mid
>>                                          /* bigbuf will also leak */
>>                                          mid->resp_buf =3D server->bigbuf
>>                                          server->bigbuf =3D NULL;
>>                                          dequeue_mid
>>                                      /* in for loop */
>>                                     mids[0]->callback
>>                                       cifs_compound_callback
>>     /* Signal interrupts wait: rc =3D -ERESTARTSYS */
>>     /* if (... || midQ[i]->mid_state =3D=3D MID_RESPONSE_RECEIVED) *?
>>     midQ[0]->callback =3D cifs_cancelled_callback;
>>     cancelled_mid[i] =3D true;
>>                                        /* The change comes too late */
>>                                        mid->mid_state =3D MID_RESPONSE_R=
EADY
>>                                     release_mid  // -1
>>     /* cancelled_mid[i] =3D=3D true causes mid won't be released
>>        in compound_send_recv cleanup */
>>     /* cifs_cancelled_callback won't executed to release mid */
>>
>> The core issue is a race condition where cifs_cancelled_callback never
>> gets a chance to run, so cleanup never happens. I've spent quite a bit
>> of time trying to understand how to fix this safely.
>>
>> Honestly, my first instinct was to just patch the callback assignment
>> logic directly. But the more I dug into it, the more I realized that
>> the current locking scheme makes this really tricky to do safely. We
>> have one big lock protecting multiple different things, and trying to
>> fix the race condition directly felt like playing with fire.
>>
>> I kept running into scenarios where a "simple" fix could introduce
>> deadlocks or new race conditions. After looking at this from different
>> angles, I came to the conclusion that I needed to refactor the locking
>> first to create a safe foundation for the actual fix.
>>
>> Patches 1-3 are foundational refactoring. These three patches rename
>> locks for clarity, separate counter protection from queue operations,
>> and replace the confusing mid_flags bitmask with explicit boolean
>> fields. Basically, they untangle the current locking mess so I can
>> implement the real fix without breaking anything.
>>
>> The 4th patch in the series is where the real fix happens. With
>> the previous refactoring in place, I could safely add a lock to each
>> mid_q_entry and implement atomic callback execution. This eliminates
>> the race condition that was causing the leaks.
>>
>> In summary, my approach to the fix is to use smaller-grained locking to
>> avoid race conditions. However, during the implementation process,
>> this approach involves more changes than I initially hoped for. If
>> there's a simpler or more elegant way to fix this race condition that
>> I've missed, I'd love to hear about it. I've tried to be thorough in
>> my analysis, but I know there are folks with more experience in this
>> codebase who might see a better path.
>>
>> V1 -> V2:
>>   - Inline the mid_execute_callback() in the smb2ops.c to eliminate
>>     the sparse warning.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220404 [1]
>>
>> Wang Zhaolong (4):
>>   smb: client: rename server mid_lock to mid_queue_lock
>>   smb: client: add mid_counter_lock to protect the mid counter counter
>>   smb: client: smb: client: eliminate mid_flags field
>>   smb: client: fix mid_q_entry memleak leak with per-mid locking
>>
>>  fs/smb/client/cifs_debug.c    | 12 ++++--
>>  fs/smb/client/cifsglob.h      | 22 ++++++-----
>>  fs/smb/client/connect.c       | 57 +++++++++++++++++----------
>>  fs/smb/client/smb1ops.c       | 23 +++++++----
>>  fs/smb/client/smb2ops.c       | 72 +++++++++++++++++++----------------
>>  fs/smb/client/smb2transport.c |  5 ++-
>>  fs/smb/client/transport.c     | 71 ++++++++++++++++++----------------
>>  7 files changed, 152 insertions(+), 110 deletions(-)
>>
>> --
>> 2.39.2
>>
>>
>
>
>--=20
>Thanks,
>
>Steve
>

