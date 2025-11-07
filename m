Return-Path: <linux-kernel+bounces-889974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63BAC3EF84
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150C23AFAD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AA3310627;
	Fri,  7 Nov 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pncd/QsM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ORvUOA/P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pncd/QsM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ORvUOA/P"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83F28725F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504227; cv=none; b=NyAAYxzyuNfyv7uvdFnecIwLEwJaHygYhUj1WmNqNoiFZ0S34auK2XhoLnBC6bMd6AynuKTul/QOoEBomrMEajHibyG/oVgf/CQRSm1ClniSwmXS4DuPjDMAiatU+xbpNIsx5/ASzJYmbigKjFmZEjx0eEvV0eVPCrLR3ctteG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504227; c=relaxed/simple;
	bh=9ENHtEg+5xSSa955ztu78HlM+E6vQlrT9JJG2J/nBq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHhblGLjFHxu80VYVgZ63be8mM6pIB5z6fsRHKkLkZdG/k+4OmGz5ub9gpiUsu3kReptphL5CxlPD44UNNeT8sAufvkm4irURuE9rq37yAzpyGjJQNfjNZCghp5UN5REY0GlP7SrPi6R0L6hTK4pJlhV3uAQoqzZ0ml59M/qqHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pncd/QsM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ORvUOA/P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pncd/QsM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ORvUOA/P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9DD912124F;
	Fri,  7 Nov 2025 08:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762504223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yfLvjLP1WtT0fDdb9ALr5xYXgUaeMcxf0N51cIO18kQ=;
	b=Pncd/QsMSchY5lA4BYpHjG9XRSEDwdC8/lmgt3VltNg5E1n1BGFIA10orZ40qVHYDrtEDz
	POJt23+poN9JOFoAnVe8GEqMaPaBkTeWfnzd7h9ZssLKs3FNQsWWLQ2sz/lilJ7vOqT1EF
	bd54eJ6OVKFwfbBP2WNg/o+lIvwVa7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762504223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yfLvjLP1WtT0fDdb9ALr5xYXgUaeMcxf0N51cIO18kQ=;
	b=ORvUOA/PiFAXk+h5gcPgGerBil3ygivizaZiobiPoJmH81o8W66zQ4obvXSe6CfCHJMzXt
	MTT6NnUveR0+DfBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Pncd/QsM";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ORvUOA/P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762504223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yfLvjLP1WtT0fDdb9ALr5xYXgUaeMcxf0N51cIO18kQ=;
	b=Pncd/QsMSchY5lA4BYpHjG9XRSEDwdC8/lmgt3VltNg5E1n1BGFIA10orZ40qVHYDrtEDz
	POJt23+poN9JOFoAnVe8GEqMaPaBkTeWfnzd7h9ZssLKs3FNQsWWLQ2sz/lilJ7vOqT1EF
	bd54eJ6OVKFwfbBP2WNg/o+lIvwVa7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762504223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yfLvjLP1WtT0fDdb9ALr5xYXgUaeMcxf0N51cIO18kQ=;
	b=ORvUOA/PiFAXk+h5gcPgGerBil3ygivizaZiobiPoJmH81o8W66zQ4obvXSe6CfCHJMzXt
	MTT6NnUveR0+DfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A88B132DD;
	Fri,  7 Nov 2025 08:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2kYzEB+uDWkDSgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Nov 2025 08:30:23 +0000
Message-ID: <1646ecdc-7119-43d3-9f1e-a0ed481d38f5@suse.de>
Date: Fri, 7 Nov 2025 09:30:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvmet-auth: update sc_c in target host hash
 calculation
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251106231711.3189836-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251106231711.3189836-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9DD912124F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 11/7/25 00:17, alistair23@gmail.com wrote:
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
> Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   drivers/nvme/target/auth.c             | 4 ++--
>   drivers/nvme/target/fabrics-cmd-auth.c | 1 +
>   drivers/nvme/target/nvmet.h            | 1 +
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

