Return-Path: <linux-kernel+bounces-795648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D02B3F5DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF0B485C71
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682172E542B;
	Tue,  2 Sep 2025 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rUp2AzRS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Op2aSIdE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rUp2AzRS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Op2aSIdE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24E2E5B02
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795635; cv=none; b=SZJXdgiOtvmEIo62uTbgL1eNVAUdaMvWNtGpnkdNqOxDT7aKfg4GLoViudpj1Qv/lRA8AumiRtFSwp76z8pm1qDbmLAhLsZss6nayGY9RtAASb5DayCgCMsL8o1Fq+lAZ/YQf+zeaKtyh/6WFEzsZxW/lPlNmnPKKwetfyKiFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795635; c=relaxed/simple;
	bh=kG8nEguerrBx9E6LJqY1msWYjgBhgNUEmkIygwRt8kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXlHEAux4FueyAm7ewPVF2v2gg+exZAhmtUb2nRM9UhW/Q1asTfHoxmwPVz2LJLbfAOMzcnZkdbkT9zYEViGypIVktXCbagj/9Aaj6QM5329uLmGWW6ZghCWDhXgNgURTE3vXDzIx9dF32TzBB1ZVVHRoB1nAO8S50jNi3InKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rUp2AzRS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Op2aSIdE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rUp2AzRS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Op2aSIdE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CC061F445;
	Tue,  2 Sep 2025 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756795632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyXPUrsPYBj1Ky4K5J5VMp11z3VWGs5TBLG8tgWyook=;
	b=rUp2AzRS9YM7SP3snjDkaE8NAmfyA/iCKxLfdb8js29lMO6phieelcYYXaPrgQ2B3JjpvZ
	VD03sMhVo4kS9fwDxg04SQCAp71NZOSHOAFbwkXan/4Nom15KvX5vByXcZ4EUeBITreGUz
	76d1AgH4fnc+LhTOIyvuIgYNpkkWfAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756795632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyXPUrsPYBj1Ky4K5J5VMp11z3VWGs5TBLG8tgWyook=;
	b=Op2aSIdEsbCmJIzqtnL3qytHxt088ANWgNGWQsJILxNNK+XxkPKMthmnbbB/SflbeVVvHE
	3ZgnMg9CwtHG0DAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756795632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyXPUrsPYBj1Ky4K5J5VMp11z3VWGs5TBLG8tgWyook=;
	b=rUp2AzRS9YM7SP3snjDkaE8NAmfyA/iCKxLfdb8js29lMO6phieelcYYXaPrgQ2B3JjpvZ
	VD03sMhVo4kS9fwDxg04SQCAp71NZOSHOAFbwkXan/4Nom15KvX5vByXcZ4EUeBITreGUz
	76d1AgH4fnc+LhTOIyvuIgYNpkkWfAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756795632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyXPUrsPYBj1Ky4K5J5VMp11z3VWGs5TBLG8tgWyook=;
	b=Op2aSIdEsbCmJIzqtnL3qytHxt088ANWgNGWQsJILxNNK+XxkPKMthmnbbB/SflbeVVvHE
	3ZgnMg9CwtHG0DAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F38013888;
	Tue,  2 Sep 2025 06:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 32XLAfCStmjuVQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Sep 2025 06:47:12 +0000
Message-ID: <b9ee2f1f-f250-4403-81c9-48fdc73221c1@suse.de>
Date: Tue, 2 Sep 2025 08:47:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] nvme-fc: refactore nvme_fc_reconnect_or_delete
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
 <20250829-nvme-fc-sync-v3-3-d69c87e63aee@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250829-nvme-fc-sync-v3-3-d69c87e63aee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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

I guess the subject should be 'refactor nvme_fc_reconnect_or_delete'

On 8/29/25 17:37, Daniel Wagner wrote:
> Instead using if else blocks, apply the 'early return' and 'goto out'
> pattern. This reduces the overall complexity of this function as the
> conditions can be read in a linear order.
> 
> The only function change is that always the next reconnect attempt
> message will be printed.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fc.c | 64 +++++++++++++++++++++++++++-----------------------
>   1 file changed, 34 insertions(+), 30 deletions(-)
> 
Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

