Return-Path: <linux-kernel+bounces-884628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC17C309BC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D193A5C50
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2ED2D6E76;
	Tue,  4 Nov 2025 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tB2Hs0BJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lkiWxvgF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tB2Hs0BJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lkiWxvgF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47BD19F40A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253645; cv=none; b=dfIPIHDhQCScXbJHLm1cW70R7EdBNhWcy73UhrRw+w9ekcKGecawmr1v9yI7c+3qLZHBv0qTwfTWSq1Acjs3871+YfTBFE8yKoJwdZKrUSaah9eTo5LNOi/FGcJVgA9DOfn4VSBjuZeJEOcCdTD6mM4sjUEWEw2caRrdw44UUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253645; c=relaxed/simple;
	bh=xff2ou2COWsnGapS98FVlJPduzs6isPv7hXDAEStANk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dymzHZL700rLuV22YqewU9vgnN1BvIpIR2104BnL81c9c1GB4MEURaNxZO9ulgzsMZ0j2GmdL7VYAvvh3dkRXwCN8ZGp4ndOefO05MRTpoPoyDckjjK1XXl+hE4MvLa4KY2jkHxiL4rW84j81IPJHU4BYAcJM8xkWqUE/QNJuS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tB2Hs0BJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lkiWxvgF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tB2Hs0BJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lkiWxvgF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A59C61F387;
	Tue,  4 Nov 2025 10:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbVY/VBqk2zvjO5PdxoPmUFEkfs061ELl9sM5HumuOM=;
	b=tB2Hs0BJrBJDXILIjdtq8kcNXqgGd0Mp6BzN0QaLC3tF2Z4+fidBQ37qN4HJr/t0Mksvil
	uJ199Pn0gpJzR/EeaJnW3coiInA9bKAM6f1aB3wInY1MCuLrjIqEijth3FKmMJkhzWPWJ4
	S0SzIN4tVk9Di7FsKDDysM1/PDVerxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbVY/VBqk2zvjO5PdxoPmUFEkfs061ELl9sM5HumuOM=;
	b=lkiWxvgFmDuug3uR3C6RYE0H5Tw4gzabSFHCzuau/LiHt3nMPZN3zmzkkT2qZVt1YdKZCJ
	qUISTFzX6OMvhAAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbVY/VBqk2zvjO5PdxoPmUFEkfs061ELl9sM5HumuOM=;
	b=tB2Hs0BJrBJDXILIjdtq8kcNXqgGd0Mp6BzN0QaLC3tF2Z4+fidBQ37qN4HJr/t0Mksvil
	uJ199Pn0gpJzR/EeaJnW3coiInA9bKAM6f1aB3wInY1MCuLrjIqEijth3FKmMJkhzWPWJ4
	S0SzIN4tVk9Di7FsKDDysM1/PDVerxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbVY/VBqk2zvjO5PdxoPmUFEkfs061ELl9sM5HumuOM=;
	b=lkiWxvgFmDuug3uR3C6RYE0H5Tw4gzabSFHCzuau/LiHt3nMPZN3zmzkkT2qZVt1YdKZCJ
	qUISTFzX6OMvhAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A96A139A9;
	Tue,  4 Nov 2025 10:54:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3YUeIUnbCWn4cAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 10:54:01 +0000
Message-ID: <58eb1762-342d-4729-bfe4-8c79ef63f913@suse.de>
Date: Tue, 4 Nov 2025 11:54:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvmet-fc: use pr_* print macros instead of dev_*
To: Daniel Wagner <wagi@kernel.org>, Justin Tee <justin.tee@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
 <20251028-nvmet-fcloop-fixes-v1-5-765427148613@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-5-765427148613@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 10/28/25 16:26, Daniel Wagner wrote:
> Many of the nvmet-fc log messages cannot print the device used, because
> it's not there yet:
> 
>    (NULL device *): {0:0} Association deleted
> 
> Use the pr_* macros consistently throughout the module and match the
> output of the nvme-fc module.
> 
> Using port:association ids are more useful when debugging what's going
> on, because these match now with the log entries from nvme-fc.
> ---
>   drivers/nvme/target/fc.c | 48 +++++++++++++++++++++---------------------------
>   1 file changed, 21 insertions(+), 27 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

