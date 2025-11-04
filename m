Return-Path: <linux-kernel+bounces-884626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D0AC309B0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A601895791
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1191E298CC4;
	Tue,  4 Nov 2025 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y2EAYdt2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CSGyaIS+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y2EAYdt2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CSGyaIS+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97662D7DDC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253536; cv=none; b=aAX8Aei782LRDspD534SjNEiguraffeKjYVWauQS/ZkAYpBTpndoU53J/hJqnCmOAqGy5XQz9sivCTjd0VwqilN3NhLPiKwFwJHfTeLv6YcY/xXXgv4IMzahYHAcMOU4mryODmeZmjGeVZ99FO0TxKSYmktogBRecTulM80u6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253536; c=relaxed/simple;
	bh=hsYEiHreeeYtTLSW1qc6yBkpblUQwZ1KsgJWNx10DsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFonwhpHAruNIhHwc3TdYqe5I+uwMR+RwVnaIY33Y2958E4MavA2JJjApJ/iV7QFC3FQ55NpUxHwk8OFuxspSGB1nhKfDTvFPDLPiDvPzzv+FsneUGkuue/EZKwvxWVt3l1XMo8G2bdxrjhYmXh/aRC6nkODsNEOddzw+4/DQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y2EAYdt2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CSGyaIS+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y2EAYdt2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CSGyaIS+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 762DE21167;
	Tue,  4 Nov 2025 10:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E0yUsgLmPVY+80cxgWgXklBbTsFguyq96i7zfSTgJE=;
	b=y2EAYdt29jvOd632+mr7U/KjhPidJF6CqHn6+44R8D4R6YvTq2Y/kaLjJ3Ad4IDiwhZkmi
	H6Cc46iLyA3UGP4w1swVFKp639GSF3bw4euR7YBHj1LzafaL7PQBQC/64POfdV/iCzexFC
	IXEMMsEQxJsvqnzQaPGQClBGbuAgvbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E0yUsgLmPVY+80cxgWgXklBbTsFguyq96i7zfSTgJE=;
	b=CSGyaIS++dS00OQwC9IJMVIRmurO1G2TddfUZIrJqX2dZLUir17Zfz2YIn5KvOIc1iHPbv
	DqZF3rRHMV4rPLDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y2EAYdt2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CSGyaIS+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E0yUsgLmPVY+80cxgWgXklBbTsFguyq96i7zfSTgJE=;
	b=y2EAYdt29jvOd632+mr7U/KjhPidJF6CqHn6+44R8D4R6YvTq2Y/kaLjJ3Ad4IDiwhZkmi
	H6Cc46iLyA3UGP4w1swVFKp639GSF3bw4euR7YBHj1LzafaL7PQBQC/64POfdV/iCzexFC
	IXEMMsEQxJsvqnzQaPGQClBGbuAgvbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E0yUsgLmPVY+80cxgWgXklBbTsFguyq96i7zfSTgJE=;
	b=CSGyaIS++dS00OQwC9IJMVIRmurO1G2TddfUZIrJqX2dZLUir17Zfz2YIn5KvOIc1iHPbv
	DqZF3rRHMV4rPLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A5C6139A9;
	Tue,  4 Nov 2025 10:52:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9KwIEdvaCWlXbwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 10:52:11 +0000
Message-ID: <8bdd652e-6d84-4295-b3a3-ad3bb5c4f019@suse.de>
Date: Tue, 4 Nov 2025 11:52:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvmet-fcloop: check all request and response have
 been processed
To: Daniel Wagner <wagi@kernel.org>, Justin Tee <justin.tee@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
 <20251028-nvmet-fcloop-fixes-v1-3-765427148613@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-3-765427148613@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 762DE21167
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 10/28/25 16:26, Daniel Wagner wrote:
> When the remoteport or the targetport are removed check that there are
> no inflight requests or responses.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

