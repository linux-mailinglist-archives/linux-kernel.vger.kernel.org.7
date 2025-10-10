Return-Path: <linux-kernel+bounces-847838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEC3BCBDAB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F1994EC371
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90E423E35B;
	Fri, 10 Oct 2025 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ouuEGk3R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bdqcFU5J";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ouuEGk3R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bdqcFU5J"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C639AC2E0
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760079843; cv=none; b=rUIa9Qx08l1b9pA+KPEd4p/zTl//LsSh9I9VKnF0+fWKFgpbvhcOQH2ydkMeXivw8/KxeGJdPCb8CP8ehB46snjjVUE8hR6MeGbqyOA4NmZe0J4JN9zC+liKLbVTxZRtzNzQMcwNMLRC7u76cxYpmt6kfD4Z85dmHPMimKOpvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760079843; c=relaxed/simple;
	bh=ECli3oNhCUbzdZpOIMg/kskkNHG0fp6jZc7+Jv9X9Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KT9kkk4wn7uMDZAorxD78akuqiNoyzmyYwdocG1F2D822t6yK9Qy0S90iYZhsRdnAGd+lmTrMc8JdmaGdPJmPlLex980qbi1lC/AosWpNIwdwAM99v6FlAFh+PmgaGt3Js6iHMCvUYZT397QDqzpcGffiW4/yDkdioN3eQ6cSJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ouuEGk3R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bdqcFU5J; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ouuEGk3R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bdqcFU5J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86842222AA;
	Fri, 10 Oct 2025 07:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760079837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJHAX+igMXV+KAJJKez9mmyUS7tV115m9DcTyfDrR1k=;
	b=ouuEGk3R66RmyRRE1i+oPZPGcLUrP8Q5TrgQxZOdl9qyDlqiCCS8a2j56DkGy6zR7ArPKs
	JceYQrFoeDmpz/NTZAT7/BCm6iKbkJ+ztnoJ8iKDo1/90eXS7OVbINvPBahOxg1x3wL+Za
	zqDF/bKTcPP1ENJmnVdDhb8RV1bKNjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760079837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJHAX+igMXV+KAJJKez9mmyUS7tV115m9DcTyfDrR1k=;
	b=bdqcFU5JQBdwoR4fzpC+Q+OPDgkN6FUZj6H5Jm+0xBJDKftcANQY+r2HD89i8qMl7Wqy51
	595X6q0jnwuIBtAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ouuEGk3R;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bdqcFU5J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760079837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJHAX+igMXV+KAJJKez9mmyUS7tV115m9DcTyfDrR1k=;
	b=ouuEGk3R66RmyRRE1i+oPZPGcLUrP8Q5TrgQxZOdl9qyDlqiCCS8a2j56DkGy6zR7ArPKs
	JceYQrFoeDmpz/NTZAT7/BCm6iKbkJ+ztnoJ8iKDo1/90eXS7OVbINvPBahOxg1x3wL+Za
	zqDF/bKTcPP1ENJmnVdDhb8RV1bKNjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760079837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJHAX+igMXV+KAJJKez9mmyUS7tV115m9DcTyfDrR1k=;
	b=bdqcFU5JQBdwoR4fzpC+Q+OPDgkN6FUZj6H5Jm+0xBJDKftcANQY+r2HD89i8qMl7Wqy51
	595X6q0jnwuIBtAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 546D413A40;
	Fri, 10 Oct 2025 07:03:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rkZ2E92v6GhCZAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 10 Oct 2025 07:03:57 +0000
Message-ID: <33dd4088-2a48-4dbd-a374-e2204aff3941@suse.de>
Date: Fri, 10 Oct 2025 09:03:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme/tcp: handle tls partially sent records in
 write_space()
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20251010042514.704249-2-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251010042514.704249-2-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 86842222AA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

On 10/10/25 06:25, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> With TLS enabled, records that are encrypted and appended to TLS TX
> list can fail to see a retry if the underlying TCP socket is busy, for
> example, hitting an EAGAIN from tcp_sendmsg_locked(). This is not known
> to the NVMe TCP driver, as the TLS layer successfully generated a record.
> 
> Typically, the TLS write_space() callback would ensure such records are
> retried, but in the NVMe TCP Host driver, write_space() invokes
> nvme_tcp_write_space(). This causes a partially sent record in the TLS TX
> list to timeout after not being retried.
> 
> This patch fixes the above by calling queue->write_space(), which calls
> into the TLS layer to retry any pending records.
> 
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
> V2:
>      - Unconditionally invoke TLS write_space(). This means we don't need
>        to export tls_is_partially_sent_record()
> ---
> drivers/nvme/host/tcp.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1413788ca7d5..6016510577bd 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1079,8 +1079,13 @@ static void nvme_tcp_write_space(struct sock *sk)
>   
>   	read_lock_bh(&sk->sk_callback_lock);
>   	queue = sk->sk_user_data;
> +
>   	if (likely(queue && sk_stream_is_writeable(sk))) {
>   		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> +		/* Ensure pending TLS partial records are retried */
> +		if (nvme_tcp_queue_tls(queue))
> +			queue->write_space(sk);
> +
>   		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   	}
>   	read_unlock_bh(&sk->sk_callback_lock);

Minus the whitespace change:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

