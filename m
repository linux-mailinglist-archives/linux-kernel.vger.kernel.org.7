Return-Path: <linux-kernel+bounces-884624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB47C309E0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF0DD4F8FD7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B272D979A;
	Tue,  4 Nov 2025 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EwvXlJXv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rUUwqsFe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zjqTMwKX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dLILKA/Z"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208642D9796
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253475; cv=none; b=eCGHBSl858sUvovM7yoEUfjYR260x0V10LJdACfOsrk2snLj1HvZWs2G479iHIamxQVlTnwtLKcpjis3srNrU9T7Tvt7ypLIe+Glt7zkYVBRCYx3QMhXcTXXw37OPyzhmA3yqaeoA9g7EvdXahHDJpphNKHNZ3SeREbBrjS5CJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253475; c=relaxed/simple;
	bh=z5P9lNBEE7IOsD65MLxHeUwfFI0nx/OLllxy1MHr4G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbNFuEV4ty6IVa+HOzF7B5bQhVioPJWXYGIRJH7HXLZ60Azf2cKFeFsNiTIXkyYxRh6YhzGoYtD7CSZglNwoziHj3rxbSf9FDqFNqVM16OOsv+1F9rTYkomEDS8KK73+XDgXoKTOVWIKNGuIAzA+N+p6VA5A/d8rUDkEvVq2faw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EwvXlJXv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rUUwqsFe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zjqTMwKX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dLILKA/Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDEBA21167;
	Tue,  4 Nov 2025 10:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMjhk+aGsEEpedQXhsPzilwROqHBJolr6YIHF/2rFPY=;
	b=EwvXlJXvjjjI2WSoG4ts/wPwXi1fdk88bGjhmbHqYMYADJP9SZiFDdaSf5HpL94gtOPuR6
	FS6pxD1GbclPMCqsexq2I6eWus4ZmPZLG28ouhiTMplzKBRGXIiRQpxmf6G6ACMFVOZlHZ
	CZkGscIeLjqRz/EZVWDkHKhLVq1Q26I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMjhk+aGsEEpedQXhsPzilwROqHBJolr6YIHF/2rFPY=;
	b=rUUwqsFedBomuDb8ijIQOKG7Cyd/tp3F0kMVlTTkUAgHEZuJvqpKIM8JnF1nlv6ksz6ita
	GNHIJLIhImAePVDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zjqTMwKX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="dLILKA/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMjhk+aGsEEpedQXhsPzilwROqHBJolr6YIHF/2rFPY=;
	b=zjqTMwKXdO+6iQk0ucTXOXFGYx/sGdZAqA5LP1KpbaZDRm4omMfWtJXoo3enDjMLk/9A54
	b5p3FKQQ4Pa5gtPImhW6QkqguXT71Of5XvWqaGBG2SmfI3T7IAFLZknmtUPvy83HgAXQDZ
	h/kihe/I43/nClS8Bg0ik9jx90wLLhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMjhk+aGsEEpedQXhsPzilwROqHBJolr6YIHF/2rFPY=;
	b=dLILKA/ZTkYqQ/wqXDoJl6JBFVdY0FRn64AyulU1xx9PB9NK7500Bb0qCB44tmTO17OWh5
	SJ+FmZVtIbO+rlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D592D139A9;
	Tue,  4 Nov 2025 10:51:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /JZ2M53aCWn4bQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 10:51:09 +0000
Message-ID: <accf6ad7-047b-48d0-b626-f3ef0facd649@suse.de>
Date: Tue, 4 Nov 2025 11:51:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
To: Daniel Wagner <wagi@kernel.org>, Justin Tee <justin.tee@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
 <20251028-nvmet-fcloop-fixes-v1-1-765427148613@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-1-765427148613@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EDEBA21167
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 10/28/25 16:26, Daniel Wagner wrote:
> nvme_fc_ctrl_put can acquire the rport lock when freeing the
> ctrl object:
> 
> nvme_fc_ctrl_put
>    nvme_fc_ctrl_free
>      spin_lock_irqsave(rport->lock)
> 
> Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 03987f497a5b..2c0ea843ae57 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1488,7 +1488,9 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
>   		if (ret)
>   			/* leave the ctrl get reference */
>   			break;
> +		spin_unlock_irqrestore(&rport->lock, flags);
>   		nvme_fc_ctrl_put(ctrl);
> +		spin_lock_irqsave(&rport->lock, flags);
>   	}
>   
>   	spin_unlock_irqrestore(&rport->lock, flags);
> 
In theory, yes.
In practice we're getting a reference to the controller at the start
of the loop, so nvme_fc_ctrl_put() should just decrement the refcount.
But _if_ someone manages to sneak in an drop the reference while we are
within that loop then the entire logic falls apart as the controller
will be deleted and the next loop iteration will trip over an
uninitialized pointer.
So you would need to modify the loop to use
loop_for_each_entry_safe() to avoid this, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

