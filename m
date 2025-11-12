Return-Path: <linux-kernel+bounces-896641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE53C50DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA7034F1F97
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606ED28466F;
	Wed, 12 Nov 2025 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GiOuPgST";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b2GRBJPG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wLAJrC5+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xnSFYDxi"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F02216E32
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931161; cv=none; b=S2anZf20eheWuX2P/5PzvOkqR5CJYiQH53lKa9LovnufMGzRfEsmPYaNkKzNYtWHr64FwZpg3u9EYkUYJt/XY1/Q+3EPTW8BV1kJ99RX86sNyy07kXgg3jdEHOkNoDABLpiBHdvBejN+/UOhZVuAzFJZX74lO2oob/1cgotWxAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931161; c=relaxed/simple;
	bh=AE1swe41uBX60JwfO9PPaj+cX21vneidECO/IPS+G7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jglpCSKR3BLdBCJ+M2om918QxeV9TBd9LpQvNp4QStqHGyTdhzz+hRBcArzhZWvuwZvzQMl+VLwuyRpauKuETDu5di/VeMWlK8+8kVjHkgk+QSxCX0bDkIVVNML/r4hjBJscDSRnBJCUQWyy61Rk0pbbzee5GPSDsHtET0KnLno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GiOuPgST; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b2GRBJPG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wLAJrC5+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xnSFYDxi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B40B21A91;
	Wed, 12 Nov 2025 07:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762931157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcnGWYma/a63ZuZCz+Xvha5mqSnjWCOzwOq4Z6jHBVM=;
	b=GiOuPgSTWXAhHi1c7kWEzvZWLeJs0H3AUVO2FAOqOOnYAviqSse80KMuAa7u/hHnU5pQm4
	Y2qkfBahJhvm7bsakmggLNx69HN4yTn8uTEQIzJI3Z+DXhG+MNw/YAM8eAbPjIBxmCzeT4
	TBJcjHFvrbLbpkbRNPcfWce1eRnXOkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762931157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcnGWYma/a63ZuZCz+Xvha5mqSnjWCOzwOq4Z6jHBVM=;
	b=b2GRBJPGLtSPvpFhEgK8UppNrDKU8su2CMtYw9TWeqIHzoo6dd2MF1EZJqTG1oyMQbtG01
	ZT3b08iiKdURarAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wLAJrC5+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xnSFYDxi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762931156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcnGWYma/a63ZuZCz+Xvha5mqSnjWCOzwOq4Z6jHBVM=;
	b=wLAJrC5+5CdI63hvIo6YvtXnIBcFX+cNRnc/RTqppg3dzTOlCUk4fmb162QDefCRiwMnR0
	ve2ZLKNcBjR5Vi9AuKgvwJKvR3228Skzuv6/FSBZgYwgg/vGpDawGpUR49qnVEDOMVoAD3
	hy7H6OUbKIxqe7bLiDEZbwA4e0jyf0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762931156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcnGWYma/a63ZuZCz+Xvha5mqSnjWCOzwOq4Z6jHBVM=;
	b=xnSFYDxig7ta+6Es1T9SpmOMbOhMQ96TedL0IxQeE0tT7Y6QhurllHVDoKWblsHylSP7n+
	n90CP4nC3WuKyRCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E672D14DC2;
	Wed, 12 Nov 2025 07:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UtyyNdMxFGlVcgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 12 Nov 2025 07:05:55 +0000
Message-ID: <92761459-4d5f-4cca-b0b6-fc359f07ba69@suse.de>
Date: Wed, 12 Nov 2025 08:05:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] nvmet-tcp: Don't error if TLS is enabed on a reset
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-2-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251111234519.3467440-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5B40B21A91
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
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.51

On 11/12/25 00:45, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> If the host sends a AUTH_Negotiate Message on the admin queue with
> REPLACETLSPSK set then we expect and require a TLS connection and
> shouldn't report an error if TLS is enabled.
> 
> This change only enforces the nvmet_queue_tls_keyid() check if we aren't
> resetting the negotiation.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v2:
>   - Fixup long line
> 
>   drivers/nvme/target/auth.c             | 4 ++--
>   drivers/nvme/target/core.c             | 2 +-
>   drivers/nvme/target/fabrics-cmd-auth.c | 3 ++-
>   drivers/nvme/target/nvmet.h            | 4 ++--
>   4 files changed, 7 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

