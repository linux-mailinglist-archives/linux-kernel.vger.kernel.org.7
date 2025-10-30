Return-Path: <linux-kernel+bounces-877935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F643C1F629
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9AA7F34DA14
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33FB2571DA;
	Thu, 30 Oct 2025 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iYo0njcy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C+WEz6Z2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iYo0njcy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C+WEz6Z2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7691034B668
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817754; cv=none; b=XVxXkv6ZKMdisvb85DJAS11/Kfwwsa7SGNrjjp+Kf/Dk2PFLVI3j5Q79n4tWVNpy7XF+S5SxlkzmVRaX3izz6ERkeuarpQE1rLQA2g5FQ0L+B+Y9YLRj4pLgnn9yS14oAHCE2kjm1n3fNwGwgOBHWppkK+PDcbVeD1+A9pbNwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817754; c=relaxed/simple;
	bh=bSosIsxymDKaKpsup6wosx6b2SyNO8ZJgiFREY/zyKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oC1cGVoch/VuT5k//CBJA3E2AaXRZb070I3LwInSrWqNiFewVfOhby5c6oUuXwBYzl78QRDx5R+2SKt1aIT/r9wUKraPMea02AIujKcdNqu9eXoqN39geRiZA3HqM4itpTfvuHFdR015OcWXy5VVnujBl5KMwt4so0Brsnp2plY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iYo0njcy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C+WEz6Z2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iYo0njcy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C+WEz6Z2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CEA333384F;
	Thu, 30 Oct 2025 09:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761817748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUgiBp2raI4QXwn6G5OcZeSw0wZ8MTF4YiZenGoLgVY=;
	b=iYo0njcyj68NO2bg4LlNXMj5Yf+pcJIBH7fgFtWDpk6EvnFH+GEZNtjbMvgbEbNGrhKdbN
	eaDFzje1rHW8BTEJ1eThTI2ChHEjhxZ37VCpAmDq3IWI/186CMsJjucEBH49p51VuDCnu5
	Q6WPqCngm8JQSjNS2hyGNJ5vrurzXi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761817748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUgiBp2raI4QXwn6G5OcZeSw0wZ8MTF4YiZenGoLgVY=;
	b=C+WEz6Z266ZiCoCE3IVCWrC/QXSLHAaAiEmazy/uPITYBLm5N9tSw9CZ7E984KF1+Isfru
	S78my7wy6WIrPFDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761817748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUgiBp2raI4QXwn6G5OcZeSw0wZ8MTF4YiZenGoLgVY=;
	b=iYo0njcyj68NO2bg4LlNXMj5Yf+pcJIBH7fgFtWDpk6EvnFH+GEZNtjbMvgbEbNGrhKdbN
	eaDFzje1rHW8BTEJ1eThTI2ChHEjhxZ37VCpAmDq3IWI/186CMsJjucEBH49p51VuDCnu5
	Q6WPqCngm8JQSjNS2hyGNJ5vrurzXi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761817748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUgiBp2raI4QXwn6G5OcZeSw0wZ8MTF4YiZenGoLgVY=;
	b=C+WEz6Z266ZiCoCE3IVCWrC/QXSLHAaAiEmazy/uPITYBLm5N9tSw9CZ7E984KF1+Isfru
	S78my7wy6WIrPFDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFAD81396A;
	Thu, 30 Oct 2025 09:49:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WHzkLZQ0A2mUCAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 30 Oct 2025 09:49:08 +0000
Date: Thu, 30 Oct 2025 10:49:08 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Justin Tee <justintee8345@gmail.com>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	LKML <linux-kernel@vger.kernel.org>, Justin Tee <justin.tee@broadcom.com>
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
Message-ID: <84d028aa-31dd-4f8f-8370-3db4667d0dc7@flourine.local>
References: <CABPRKS9GGS2mQ46UMmM3G_NnamCsYj7zBaa_c4rQfO1h=59wrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPRKS9GGS2mQ46UMmM3G_NnamCsYj7zBaa_c4rQfO1h=59wrQ@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Tue, Oct 28, 2025 at 05:33:17PM -0700, Justin Tee wrote:
> So, something like this?
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 03987f497a5b..fcd30801921b 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1468,14 +1468,16 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
>  {
>         struct fcnvme_ls_disconnect_assoc_rqst *rqst =
>                                         &lsop->rqstbuf->rq_dis_assoc;
> -       struct nvme_fc_ctrl *ctrl, *ret = NULL;
> +       struct nvme_fc_ctrl *ctrl, *tmp, *ret = NULL;
>         struct nvmefc_ls_rcv_op *oldls = NULL;
>         u64 association_id = be64_to_cpu(rqst->associd.association_id);
>         unsigned long flags;
> 
> +       nvme_fc_rport_get(rport);
> +
>         spin_lock_irqsave(&rport->lock, flags);
> 
> -       list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
> +       list_for_each_entry_safe(ctrl, tmp, &rport->ctrl_list, ctrl_list) {
>                 if (!nvme_fc_ctrl_get(ctrl))
>                         continue;
>                 spin_lock(&ctrl->lock);
> @@ -1488,11 +1490,15 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
>                 if (ret)
>                         /* leave the ctrl get reference */
>                         break;
> +               spin_unlock_irqrestore(&rport->lock, flags);
>                 nvme_fc_ctrl_put(ctrl);
> +               spin_lock_irqsave(&rport->lock, flags);
>         }
> 
>         spin_unlock_irqrestore(&rport->lock, flags);
> 
> +       nvme_fc_rport_put(rport);
> +
>         /* transmit a response for anything that was pending */
>         if (oldls) {
>                 dev_info(rport->lport->dev,

I've dropped the nvme_fc_rport_get because it's not necessary, a ref is
taken in nvme_fc_rcv_ls_req, so the port is not going away until the
disconnect LS is processed.

All tests seems to work fine except one, nvme/58 (test rapid namespace
remapping). But this one also fails for the other trasnport, e.g TCP:

	block nvme1n1: no available path - failing I/O
	Oops: general protection fault, probably for non-canonical address 0xdffffc00000I
	KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
	CPU: 5 UID: 0 PID: 707 Comm: kworker/5:2H Tainted: G      D W           6.17.0-ra
	Tainted: [D]=DIE, [W]=WARN
	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-6.fc43 04/01/2014
	Workqueue: kblockd nvme_requeue_work [nvme_core]
	RIP: 0010:__rq_qos_done_bio+0x24/0xa0
	Code: 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 53 49 89 f4 48 83 ec 08 48 89 fbc
	RSP: 0018:ffff888116e07980 EFLAGS: 00010256
	RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
	RDX: 1ffff11022f2a6eb RSI: ffff88810d2a6140 RDI: 0000000000000000
	nvme nvme4: IDs don't match for shared namespace 3
	RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffffff9f4df3cf
	R10: ffff888116e0760f R11: ffffffffa6b771d0 R12: ffff88810d2a6140
	R13: ffff88810d2a6148 R14: ffff88810d2a6140 R15: ffff888106d66808
	FS:  0000000000000000(0000) GS:ffff8881b2408000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	nvme nvme3: rescanning namespaces.
	CR2: 000055f4b1f6d080 CR3: 000000011c082000 CR4: 0000000000750ef0
	PKRU: 55555554
	Call Trace:
	 <TASK>
	 bio_endio+0x1c9/0x610
	 nvme_ns_head_submit_bio+0x79e/0xa20 [nvme_core 8550ebbc328e8e8a801d6cacfcd551a5]
	 ? lock_release+0x244/0x450
	 __submit_bio+0x31a/0x6c0
	 ? __pfx___submit_bio+0x10/0x10
	 ? lock_acquire+0x292/0x2e0
	 ? lock_release+0x244/0x450
	 ? __pfx_blk_cgroup_bio_start+0x10/0x10
	 ? lock_acquire+0x292/0x2e0
	 ? submit_bio_noacct_nocheck+0x577/0xaa0
	 submit_bio_noacct_nocheck+0x577/0xaa0
	 ? trace_irq_enable.constprop.0+0xc0/0x100
	 ? trace_hardirqs_on+0x32/0x40
	 ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
	 ? submit_bio_noacct+0x97d/0x1ce0
	 nvme_requeue_work+0xa2/0xd0 [nvme_core 8550ebbc328e8e8a801d6cacfcd551a5345e7fd9]
	 process_one_work+0x7f3/0x1420
	 ? __pfx_process_one_work+0x10/0x10
	 ? local_clock+0x11/0x30
	 ? assign_work+0x156/0x390
	 worker_thread+0x5cf/0xfe0
	 ? _raw_spin_unlock_irqrestore+0x40/0x60
	 ? __pfx_worker_thread+0x10/0x10
	 ? __kthread_parkme+0xb3/0x1f0
	 ? __pfx_worker_thread+0x10/0x10
	 kthread+0x39d/0x740
	 ? __pfx_do_raw_spin_trylock+0x10/0x10
	 ? __pfx_kthread+0x10/0x10
	 ? kvm_sched_clock_read+0xd/0x20
	 ? local_clock_noinstr+0xb/0xf0
	 ? local_clock+0x11/0x30
	 ? lock_release+0x2e2/0x450
	 ? __pfx_kthread+0x10/0x10
	 ret_from_fork+0x371/0x460
	 ? __pfx_kthread+0x10/0x10
	 ? __pfx_kthread+0x10/0x10
	 ret_from_fork_asm+0x1a/0x30
	 </TASK>
	Modules linked in: nvmet_tcp nvmet nvme_tcp nvme nvme_fabrics nvme_core nvme_autp
	---[ end trace 0000000000000000 ]---
	

