Return-Path: <linux-kernel+bounces-795905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01DB3F939
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A6E3B925F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653BC2E8DE5;
	Tue,  2 Sep 2025 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DGlPwnXt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HUof7w+A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DGlPwnXt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HUof7w+A"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FE7270572
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803341; cv=none; b=VyKTKlpnZTyDYfvAHHQ4TTCWTfIeFksRPLQ1s5Lrtf8BVcVC1fB9h99V6uRnP6S7a3AFkrY+XAKxEf91CgPKS1NVFAPBPQhExNyZ8xFknpnAk85TTu0VsRWzwaS/r05FX0ehcKbYSdW9SOTO7YhfpgRjvQnvwv7pCYdUaPCpwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803341; c=relaxed/simple;
	bh=7RkYQl9WFGz1IXnibe6VOcP1xKbTG8h4IG0xDChtqfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNIpxZneWyU00vD9Yd8rfZ44wNNhZf8YCHjJKZzhrnmzLsVT6mOa4mN/5sm92wZhoQ4T4dj8JapgdWKhiTiO3Gsh1xmoZ7bJyCDNmZDUOQpHf5obnuiUYQ7MgmfZ8eNiPXSqzVXlO8bvXzzZa6Tt2b2ByWapv5O8bKiYmsl2rL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DGlPwnXt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HUof7w+A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DGlPwnXt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HUof7w+A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 353E21F44E;
	Tue,  2 Sep 2025 08:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756803338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzEzSeG1OZAmNkAv8N7UBHLIFuPoLWkfKAmO5QPVi5M=;
	b=DGlPwnXtH8mCUTXb6T5MHUKgfNtZnDvffrikG16pXSj5i2pDtRTrXteTU2slrFdhcdEfRS
	v6nnF7cIBtZXzD5HjTt5kICE1YtYrvt/+uds7jYxr8wLXa/XYNd1mubz+r6R8Sla3WJcax
	49Wk5ap6Xs/0djam1SDxGyTzTNYs1Fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756803338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzEzSeG1OZAmNkAv8N7UBHLIFuPoLWkfKAmO5QPVi5M=;
	b=HUof7w+AWtw38QdxpWcvbWJAMBz+atWfWTrucNjK+AwP4Rm+47rtOMEHuAer2aQZVKwtRA
	rULECNcAAHkTJJCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756803338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzEzSeG1OZAmNkAv8N7UBHLIFuPoLWkfKAmO5QPVi5M=;
	b=DGlPwnXtH8mCUTXb6T5MHUKgfNtZnDvffrikG16pXSj5i2pDtRTrXteTU2slrFdhcdEfRS
	v6nnF7cIBtZXzD5HjTt5kICE1YtYrvt/+uds7jYxr8wLXa/XYNd1mubz+r6R8Sla3WJcax
	49Wk5ap6Xs/0djam1SDxGyTzTNYs1Fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756803338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzEzSeG1OZAmNkAv8N7UBHLIFuPoLWkfKAmO5QPVi5M=;
	b=HUof7w+AWtw38QdxpWcvbWJAMBz+atWfWTrucNjK+AwP4Rm+47rtOMEHuAer2aQZVKwtRA
	rULECNcAAHkTJJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC4DB13888;
	Tue,  2 Sep 2025 08:55:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1T5ZOAmxtmhWAQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Sep 2025 08:55:37 +0000
Message-ID: <24d92bef-6982-4cbc-91d1-49c21090860f@suse.de>
Date: Tue, 2 Sep 2025 10:55:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvmet-fc: avoid scheduling association deletion
 twice
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250829-fix-nvmet-fc-v2-0-26620e2742c7@kernel.org>
 <20250829-fix-nvmet-fc-v2-2-26620e2742c7@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250829-fix-nvmet-fc-v2-2-26620e2742c7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 8/29/25 17:43, Daniel Wagner wrote:
> When forcefully shutting down a port via the configfs interface,
> nvmet_port_subsys_drop_link() first calls nvmet_port_del_ctrls() and
> then nvmet_disable_port(). Both functions will eventually schedule all
> remaining associations for deletion.
> 
> The current implementation checks whether an association is about to be
> removed, but only after the work item has already been scheduled. As a
> result, it is possible for the first scheduled work item to free all
> resources, and then for the same work item to be scheduled again for
> deletion.
> 
> Because the association list is an RCU list, it is not possible to take
> a lock and remove the list entry directly, so it cannot be looked up
> again. Instead, a flag (terminating) must be used to determine whether
> the association is already in the process of being deleted.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fc.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

