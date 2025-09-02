Return-Path: <linux-kernel+bounces-795906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5676B3F93C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D731A86EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47B32E8B9A;
	Tue,  2 Sep 2025 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GHfTySCG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fTiGe8zn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GHfTySCG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fTiGe8zn"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB622A80D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803386; cv=none; b=WfsZ/96wdyeN9VWlnPrqDWhzkhdwthNNoSP//mVYBAnKCzW1keXhfIjTBfUgIwYFfImNumfG3fJMZPIKQbJh2XOa8/sfMWerk9JMnrYXEun7JcVENG2YVlkJK+ULvexvnTLv3ATrmvbVTlLUkPjui2EgGz7BAcuqkWeD4+CvmhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803386; c=relaxed/simple;
	bh=qEOUprsqtz/vWBV8IkyiW/PFvD6RKjPRv0dKnqkCark=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McEaCmPDJRbkfbzmKI9tZyRJiGR8Zh6ssuYP4UK1Zqj1Jf0SinxmwaCA75vaMVXxTCVQe6AzzZMIfQ+i3GXB0UhgdL09J7q/2ylJ5jrnwptlrVidEWNJvh1ISOIYlOfsBGE97wGSbGCF2sGZKoHru2vfakE1ly+0yeHqb+lZvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GHfTySCG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fTiGe8zn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GHfTySCG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fTiGe8zn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD42A211D4;
	Tue,  2 Sep 2025 08:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756803375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRGJfSr1tTTQgQoTLCSru/3DfqTcsG5lVrgMBCnfjRI=;
	b=GHfTySCGELYBF+CHIKP5NdUjiZ/lAnF2KgjqEMC+TK8zOe1+kXzTP1EapIp1poS3nkVpMD
	4FMJ6yOs6NnlAZqeKIylcQhvBpIrV7cmckR4Jfs06MV9iVsl117QOXPHrj/Gj/D0s/SUUU
	sfEqdbp30rdklsN9+6//Mb+DEZVKNV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756803375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRGJfSr1tTTQgQoTLCSru/3DfqTcsG5lVrgMBCnfjRI=;
	b=fTiGe8zn5dg2Yn2VqKTS4/gLGRnNHbh7iIWRULt5tLp04NY3WqzhFPmazNi/eDVS1wOCsL
	qjkWKU9uW6oTkLAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756803375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRGJfSr1tTTQgQoTLCSru/3DfqTcsG5lVrgMBCnfjRI=;
	b=GHfTySCGELYBF+CHIKP5NdUjiZ/lAnF2KgjqEMC+TK8zOe1+kXzTP1EapIp1poS3nkVpMD
	4FMJ6yOs6NnlAZqeKIylcQhvBpIrV7cmckR4Jfs06MV9iVsl117QOXPHrj/Gj/D0s/SUUU
	sfEqdbp30rdklsN9+6//Mb+DEZVKNV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756803375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRGJfSr1tTTQgQoTLCSru/3DfqTcsG5lVrgMBCnfjRI=;
	b=fTiGe8zn5dg2Yn2VqKTS4/gLGRnNHbh7iIWRULt5tLp04NY3WqzhFPmazNi/eDVS1wOCsL
	qjkWKU9uW6oTkLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8F7913888;
	Tue,  2 Sep 2025 08:56:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qiyuMC+xtmiZAQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Sep 2025 08:56:15 +0000
Message-ID: <054eb87c-c6c8-4c6a-8459-f238d73b9958@suse.de>
Date: Tue, 2 Sep 2025 10:56:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-fcloop: call done callback even when remote port is
 gone
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yi Zhang <yi.zhang@redhat.com>
References: <20250901-nvme-fc-fix-leaks-v1-1-3ae0aa88d5e5@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250901-nvme-fc-fix-leaks-v1-1-3ae0aa88d5e5@kernel.org>
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 9/1/25 17:51, Daniel Wagner wrote:
> When the target port is gone, it's not possible to access any of the
> request resources. The function should just silently drop the response.
> The comment is misleading in this regard.
> 
> Though it's still necessary to call the driver via the ->done callback
> so the driver is able to release all resources.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs-OBA0WMt5f7R0dz+rR4HcEz19YLhnyGsj-MRV3jWDsPg@mail.gmail.com/
> Fixes: 84eedced1c5b ("nvmet-fcloop: drop response if targetport is gone")
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

