Return-Path: <linux-kernel+bounces-885912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A329C343BC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 339EF4E64B4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ED12D0C61;
	Wed,  5 Nov 2025 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TNFay4r5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NYp46wO4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TNFay4r5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NYp46wO4"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0C2C21C5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328004; cv=none; b=nEtHpc3grZv0pWlarYVFqMMCI2zGNOylV+7ANM3P+RzKBJxP89zRYc00XZfIiSjKATpRlW+ckhOpsUFQyJpUh6ho25F2z3rATNKgHSlgoYUEHfkPpQ2ckuMQuGPA5comRx61yi2hoZ4oCbZE6bZlHabxG/8scYUr0/Iv0cRmXMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328004; c=relaxed/simple;
	bh=KpgYdyErzYWNfsDmM8RpmBQYHn8qgFjSgqIbO1MS0uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv8Y4JRe1j0dj/n7AthTFju83j4bhq43dryIcrWrnAhPNtIwBN4Q8Ynk8yuIhLn5so2u91hh1yrzuAGSQYKHOgkYWcwDHn0lmK8r76AbRD3TtmZAKUi0oEJBcLJCfC4CFdF3U02dUhFzGkLHoi1LBjMkWBu9zpgBFvtlboOE5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TNFay4r5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NYp46wO4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TNFay4r5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NYp46wO4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7523211A9;
	Wed,  5 Nov 2025 07:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762328000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7WHpwWJsFQidSis9vBhinqzkd1Tci0EX77bk2nM6CQ=;
	b=TNFay4r5Gj7ooZMP9Y2U3UYkGjuiTTWK48blYrZCqZ1z9n3sHS8fvHot20S4XidEV3RxKa
	uVl3JPG+Y7HEo/cB0nlUlnTeebD/5XETyv+dcuCydLXB/IdrUsrIQsMs32VOmLImn8vZqQ
	6ZTBglOPbH4WuPRAmjfg5VDZrRyqu20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762328000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7WHpwWJsFQidSis9vBhinqzkd1Tci0EX77bk2nM6CQ=;
	b=NYp46wO4NnMflPPGcRUoSHWTDnP6TbiOfE9kvwRDqTpjz99RRd6KpXZD+tSttcuugiGkcN
	RKQrb6QlN8ifJ1Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762328000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7WHpwWJsFQidSis9vBhinqzkd1Tci0EX77bk2nM6CQ=;
	b=TNFay4r5Gj7ooZMP9Y2U3UYkGjuiTTWK48blYrZCqZ1z9n3sHS8fvHot20S4XidEV3RxKa
	uVl3JPG+Y7HEo/cB0nlUlnTeebD/5XETyv+dcuCydLXB/IdrUsrIQsMs32VOmLImn8vZqQ
	6ZTBglOPbH4WuPRAmjfg5VDZrRyqu20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762328000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7WHpwWJsFQidSis9vBhinqzkd1Tci0EX77bk2nM6CQ=;
	b=NYp46wO4NnMflPPGcRUoSHWTDnP6TbiOfE9kvwRDqTpjz99RRd6KpXZD+tSttcuugiGkcN
	RKQrb6QlN8ifJ1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ADF3132DD;
	Wed,  5 Nov 2025 07:33:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id umV0HMD9CmnuKQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:33:20 +0000
Message-ID: <15c974ec-dd78-4344-bd90-f30f4bb7da49@suse.de>
Date: Wed, 5 Nov 2025 08:33:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: drop bogus nid quirk for multipath devices which
 passed id test
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: John Meneghini <jmeneghi@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Daniel Wagner <dwagner@suse.de>
References: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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

On 10/28/25 13:54, Daniel Wagner wrote:
> From: Daniel Wagner <dwagner@suse.de>
> 
> Dell Express Flash NVMe P4610 reuse the Intel device id 0x0a54. The
> Intel P4500/46000 device needs NVME_QUIRK_BOBUG_NID whereas the Dell
> does not. Thus clear the quirk when the id check passes.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217981
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> Hi,
> 
> Obviously, using the correct IDs is really hard. There are at least two devices
> which share a the device id and one needs the bogus id workaround the other
> doesn't.
> 
> We discussed the idea to pass through configuration from the kernel command line
> at ALPSS. I am not sure, how far we got with this yet. What about something like
> this here?
> 
> Thanks,
> Daniel
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/core.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

