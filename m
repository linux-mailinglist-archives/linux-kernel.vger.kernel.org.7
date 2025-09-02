Return-Path: <linux-kernel+bounces-795646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7CEB3F5DA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9071A86B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C022E54DA;
	Tue,  2 Sep 2025 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LMogt2Ph";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RbemTe7b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LMogt2Ph";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RbemTe7b"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2AC20C038
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795558; cv=none; b=nN96+23Nc8HgIpMFrJtzJAkD6eyFZ4KKy2MCM0L9ULFlUXV0erUi7ytNnwLlSKw0veXqnblB8yedtcMFSai6TyX2SGNsGlzVkj42q5CnMZHMGy4ZOF/+ODow6JWZ6zeTQo7jxJlY2XKCGCz57FU0XQawHEW1wqyvHP1+DzrGORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795558; c=relaxed/simple;
	bh=I1PfshKHROmMcThjNy5rqOZbI5drHx+UvRZbfPB+SE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAJBgT0E7TgXil9NeH5lJERfpK9DAZNe455P3Qn9TvGPVmwjyfswXzkPoHA2X/pgXViI23HKd5pzbszTJZOu/RYxxtJEY6pXojmva0FphS71YzVwGyPYzzy+8zEnPiHeo9Luo5oi9DTIEkRXPKqHB3RwFvhR4TSpOtSfrWlL5Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LMogt2Ph; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RbemTe7b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LMogt2Ph; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RbemTe7b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 69CE31F445;
	Tue,  2 Sep 2025 06:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756795554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YesWicfSHaYSZUbHTDX/ghjshejKbaj2ovjBUHFLsAM=;
	b=LMogt2PhgX86GCwov6Mo0NB1J8Y7H+/RYiBSLy9u2DeKCx8TYpy39JQNkAe3S+ZcuGYx08
	i3XEKbue0QBrFq+pI5e3GTZeXc1pXXCUhsipX1mmna0f19q3tjdVsdNLWX/XAUHUNUIOzJ
	NnkxiVxpZHZAqYiTdQB0CiGAMHH/JNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756795554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YesWicfSHaYSZUbHTDX/ghjshejKbaj2ovjBUHFLsAM=;
	b=RbemTe7bj+QTRfe4SxNaQXIVwUemi2FzEzPsBKtYHx9Ngi/sIIIFBql/m51Vn9mTcDKEIo
	qB/taPB4wLI/oxCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LMogt2Ph;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RbemTe7b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756795554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YesWicfSHaYSZUbHTDX/ghjshejKbaj2ovjBUHFLsAM=;
	b=LMogt2PhgX86GCwov6Mo0NB1J8Y7H+/RYiBSLy9u2DeKCx8TYpy39JQNkAe3S+ZcuGYx08
	i3XEKbue0QBrFq+pI5e3GTZeXc1pXXCUhsipX1mmna0f19q3tjdVsdNLWX/XAUHUNUIOzJ
	NnkxiVxpZHZAqYiTdQB0CiGAMHH/JNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756795554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YesWicfSHaYSZUbHTDX/ghjshejKbaj2ovjBUHFLsAM=;
	b=RbemTe7bj+QTRfe4SxNaQXIVwUemi2FzEzPsBKtYHx9Ngi/sIIIFBql/m51Vn9mTcDKEIo
	qB/taPB4wLI/oxCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16D5713888;
	Tue,  2 Sep 2025 06:45:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ziw5A6KStmiZVQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Sep 2025 06:45:54 +0000
Message-ID: <79935b36-45a5-4388-b392-fb252e69ca42@suse.de>
Date: Tue, 2 Sep 2025 08:45:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] nvme-fc: reorganize ctrl ref-counting and cleanup
 code
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
 <20250829-nvme-fc-sync-v3-2-d69c87e63aee@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250829-nvme-fc-sync-v3-2-d69c87e63aee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 69CE31F445
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 8/29/25 17:37, Daniel Wagner wrote:
> The lifetime of the controller is managed by the upper layers. This
> ensures that the controller does not go away as long as there are
> commands in flight. Thus, there is no need to take references in the
> command handling code.
> 
> Currently, the refcounting code is partially open-coded for handling
> error paths. By moving the cleanup code fully under refcounting and
> releasing references when necessary, the error handling can be
> simplified.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fc.c | 102 ++++++++++++++++---------------------------------
>   1 file changed, 32 insertions(+), 70 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

