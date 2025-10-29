Return-Path: <linux-kernel+bounces-875418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7424C18FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4097E1C80BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F3D3128BE;
	Wed, 29 Oct 2025 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aanJMoTV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cIX4pRDv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m041YqRp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z0x2vwDd"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E63128AB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725425; cv=none; b=NFesOAryV2P0arS3qqjWmcsCzh6oZU4ADxTMtt35VsDvfIidFmmFmQWtKTHyJYK3CJyfFiC0uQrK7S7a3zf2xA8NXEfw1eQ5DyDLGd6Re5RmsQgVhe7I1hin2qWg5wngOumvjxoCOaeNwgqiFAljs0cxhWarqM5UlqzAbVLdt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725425; c=relaxed/simple;
	bh=G/g8z9ZcXUBqaSiz4uN7jrJ062yTVq1THof1Y7WWI40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rn/mVcK2tLQ4u+nSt8Lb+4j48y/f200YLQqczqTpVSRxiHGBNnicSR03bpbazUy1jRDu1OU8wdSooz9eV52VRNS55qYddp6CfWCfHmtpMLR/g/c/BXNkf2/nqyoU1OnXgTwuX33Ricxdh3kZvFBgzUgEvYHG3fDf1PV29Ja5b00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aanJMoTV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cIX4pRDv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m041YqRp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z0x2vwDd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4CAF22861;
	Wed, 29 Oct 2025 08:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761725421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BzqTLbs8mgQsyyY/RD9x9SoJtcj0Gp8kLhPs0P0wmdU=;
	b=aanJMoTVTaH+UNwIAqCYcd07MhMHr4R9IuctpNS13NLrBKrqLaAA8cHDY9wMin8gu69Pwp
	mRX1fvklVpmBzfGcCK9e0i+ZIkA/f6tSt3cp7AM8PmO5RKhzkNhvOlwaMFesxC2u8Bh+Tr
	gZa7+fMvIaXmgSA5xJyeUSC2Pq71KZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761725421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BzqTLbs8mgQsyyY/RD9x9SoJtcj0Gp8kLhPs0P0wmdU=;
	b=cIX4pRDvbOa19f1bSDu6hch5qu0u2+uA0888Cxx4crjBHyT/wIgZfC1o6FtIcWpo9UWBwo
	0/jD1vrfNfVEEjDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m041YqRp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=z0x2vwDd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761725418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BzqTLbs8mgQsyyY/RD9x9SoJtcj0Gp8kLhPs0P0wmdU=;
	b=m041YqRp+tOqYfQChuHUdoVIgSiOyOGo5fgnAAozwRwxSFIxozID8oyu4pMNV7r5ZxHVEZ
	wm80M9z8JCdajMNjvyjsbhMNnI8kMm61qNQt8HyP3Pp1gNDQT1v15Q9YPIqeIvoWF1berN
	PJftIJa4JgSA+ItZKxX0eR4HDyWgdk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761725418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BzqTLbs8mgQsyyY/RD9x9SoJtcj0Gp8kLhPs0P0wmdU=;
	b=z0x2vwDdYft2lUSuopuNAUp82fBouYv+29ZkD8FAxCf6PkR18EIpQBnznf0Fvna7wVyoib
	7qgHNRsmHeecxCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 655421396A;
	Wed, 29 Oct 2025 08:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5nHjFurLAWmaMgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 29 Oct 2025 08:10:18 +0000
Message-ID: <9b8d8baf-022a-49a9-b8b9-db699125e064@suse.de>
Date: Wed, 29 Oct 2025 09:10:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: update sc_c in target host hash calculation
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251029045327.2035337-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251029045327.2035337-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C4CAF22861
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 10/29/25 05:53, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> the sc_c variable to the dhchap queue context structure which is
> appropriately set during negotiate and then used in the host response.
> 
> This breaks secure concat connections with a Linux target as the target
> code wasn't updated at the same time. This patch fixes this by adding a
> new sc_c variable to the host hash calculations.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   drivers/nvme/host/auth.c               | 1 +
>   drivers/nvme/target/auth.c             | 3 ++-
>   drivers/nvme/target/fabrics-cmd-auth.c | 1 +
>   drivers/nvme/target/nvmet.h            | 1 +
>   4 files changed, 5 insertions(+), 1 deletion(-)
> 
I've already send a similar patch for this, which actually should 
already have been merged.
Can you check if that works for you?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

