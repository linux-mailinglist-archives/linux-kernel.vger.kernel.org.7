Return-Path: <linux-kernel+bounces-796142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB53AB3FC67
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20F1167078
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F293283137;
	Tue,  2 Sep 2025 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dgWiBNNg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mAizxFrJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dgWiBNNg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mAizxFrJ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3F4283FE7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808870; cv=none; b=MlqfP7VToxXf9cL8eb6b7+akAq9IqIzf8qs8vitMArEjSxcqTEXULA7EAzbyQ84V/KJzIfUB8Br+Fd7Do9HMuF04KnrtVzPxIx5SGw8f0+p1Q7JA3hTgqbNP66oYAR0JaE0UBKbT+775lQfAkdReJQJtmHVjZKYBqljuxFuTf+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808870; c=relaxed/simple;
	bh=BRzCqC/wGbl29Iq/2LDpz4Cx5BPnsGXTNYX4SNuJJME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVdy/e0815zQuL7VxpbDzUUBfROL05CNlGWyavxfyloaVqHuj1A2j5lcyGSuIrORF9mH3FkhpJNBNJnxNDivg65CAdfwZoFnxVBHsnEN3YO4HZ0yHh4xKCOUPhrB6sWq7X4s+8sXz9bAWaJ9o375vj7CbXgM1a2PgYCfmICgPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dgWiBNNg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mAizxFrJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dgWiBNNg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mAizxFrJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48B7D1F453;
	Tue,  2 Sep 2025 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756808866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAdEUvGGrTcrNa5rNwgfDltoMSsHsHlk3IKB0f9qHkY=;
	b=dgWiBNNguzvImDtBQyuRlvJjJdmzQZreJnZBTkws1U6sr49cTlEAcnI6mRVfBjU/+/CRn0
	kbIze76LFBYhsaI8NtoQdU6YBLHgJiXnn2Z58E2/zhr/AP5Hfi+8XRzcGO2K1ZIrpvltdE
	4Ga9H73uxIGt41xAoMTyFg/xOcbJ2jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756808866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAdEUvGGrTcrNa5rNwgfDltoMSsHsHlk3IKB0f9qHkY=;
	b=mAizxFrJJL9CbzrXiszNaUfDOsjiZD2/xK+KIopjGH+N/9rWibEQb4DbSAaluJEDLGo1J+
	4s3OO6e1Wp7whoDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756808866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAdEUvGGrTcrNa5rNwgfDltoMSsHsHlk3IKB0f9qHkY=;
	b=dgWiBNNguzvImDtBQyuRlvJjJdmzQZreJnZBTkws1U6sr49cTlEAcnI6mRVfBjU/+/CRn0
	kbIze76LFBYhsaI8NtoQdU6YBLHgJiXnn2Z58E2/zhr/AP5Hfi+8XRzcGO2K1ZIrpvltdE
	4Ga9H73uxIGt41xAoMTyFg/xOcbJ2jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756808866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAdEUvGGrTcrNa5rNwgfDltoMSsHsHlk3IKB0f9qHkY=;
	b=mAizxFrJJL9CbzrXiszNaUfDOsjiZD2/xK+KIopjGH+N/9rWibEQb4DbSAaluJEDLGo1J+
	4s3OO6e1Wp7whoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17E6E13888;
	Tue,  2 Sep 2025 10:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hkLSBKLGtmguIAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Sep 2025 10:27:46 +0000
Message-ID: <15097ba9-c84f-427c-8a9e-9823385dfd14@suse.de>
Date: Tue, 2 Sep 2025 12:27:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] nvme-fc: use lock accessing port_state and rport
 state
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>
Cc: Yi Zhang <yi.zhang@redhat.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
 <20250902-fix-nvmet-fc-v3-4-1ae1ecb798d8@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250902-fix-nvmet-fc-v3-4-1ae1ecb798d8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 9/2/25 12:22, Daniel Wagner wrote:
> nvme_fc_unregister_remote removes the remote port on a lport object at
> any point in time when there is no active association. This races with
> with the reconnect logic, because nvme_fc_create_association is not
> taking a lock to check the port_state and atomically increase the
> active count on the rport.
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/all/u4ttvhnn7lark5w3sgrbuy2rxupcvosp4qmvj46nwzgeo5ausc@uyrkdls2muwx
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fc.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

