Return-Path: <linux-kernel+bounces-884625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4B7C30998
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D544214B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E28E2D6623;
	Tue,  4 Nov 2025 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JvqqbKWZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jQsoz15l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JvqqbKWZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jQsoz15l"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDBF26FA60
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253498; cv=none; b=HUTgztHCIRkAi4T6TRepencsw8tmFFDi/JXlne5KoD8pl8xqGUqkFTPOCtVYW+PNLw+69wrAtHXuIdZ6EcqV8S6o+0s6a3HYMc/slP+62xmEXv3YUwzd/Fc/CJ04IgwSn+EX8tO813kNOszxM9v1lLZam2graCmjJO///2wh6Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253498; c=relaxed/simple;
	bh=1bjmm2YNr/MFEcGqpat+Yqkzrbp+AZAsijzt5Q9C9a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqmbNpcfZtjFNtPxHsYcxzTOAcNQ6dyaqHPgwWZEeU7a2guZIYJ0+JmlYTRJkSUG0vc6jgFn05dqs1z6UopsudDBYbeYDOerQCp+a2ALOe4ZgF6ALqHHHn3V0iVOGOu7GoIihUIaxlizwYG0bJsD5qtSp4qgLleLJ/1BiV4dgSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JvqqbKWZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jQsoz15l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JvqqbKWZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jQsoz15l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A71921167;
	Tue,  4 Nov 2025 10:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvl6XZ232GSUFvC70qNdvJh7hVhwQCiFbz9tJi6d5Ww=;
	b=JvqqbKWZsGSZJPfxnrSbDGxY2cPw/epWjApMxEEzT9X9CcuSMAtNsMrVoqrouJ7f35WSdu
	1NQaxfBKbM/7WuitelGBSz0Su6D/5H5Lycr6JRe9CJDPnWihsS7EMVEQiW+CuATwk0GEHO
	XbOg9Qs7nNBJTVNWcNkkEVCXzbapkbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvl6XZ232GSUFvC70qNdvJh7hVhwQCiFbz9tJi6d5Ww=;
	b=jQsoz15l00m2J2O6JuH+I2yveeeIUGE2PNoJL5Lq0SAXVzBp2j9R5aB2Tj/+OcTHoT1j+F
	SbtV0sd+4SE0ZrDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvl6XZ232GSUFvC70qNdvJh7hVhwQCiFbz9tJi6d5Ww=;
	b=JvqqbKWZsGSZJPfxnrSbDGxY2cPw/epWjApMxEEzT9X9CcuSMAtNsMrVoqrouJ7f35WSdu
	1NQaxfBKbM/7WuitelGBSz0Su6D/5H5Lycr6JRe9CJDPnWihsS7EMVEQiW+CuATwk0GEHO
	XbOg9Qs7nNBJTVNWcNkkEVCXzbapkbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvl6XZ232GSUFvC70qNdvJh7hVhwQCiFbz9tJi6d5Ww=;
	b=jQsoz15l00m2J2O6JuH+I2yveeeIUGE2PNoJL5Lq0SAXVzBp2j9R5aB2Tj/+OcTHoT1j+F
	SbtV0sd+4SE0ZrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED6A8139A9;
	Tue,  4 Nov 2025 10:51:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mAqPObbaCWlbbgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 10:51:34 +0000
Message-ID: <db035c45-91e4-422e-820c-701c0a60bc3c@suse.de>
Date: Tue, 4 Nov 2025 11:51:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] nvme-fc: check all request and response have been
 processed
To: Daniel Wagner <wagi@kernel.org>, Justin Tee <justin.tee@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
 <20251028-nvmet-fcloop-fixes-v1-2-765427148613@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-2-765427148613@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 10/28/25 16:26, Daniel Wagner wrote:
> When the rport is removed there shouldn't be any in flight request or
> responses.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

