Return-Path: <linux-kernel+bounces-749032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E46B1491C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0EC3AD651
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6E8263F4A;
	Tue, 29 Jul 2025 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kXydCDBD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n3tsvFqV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kXydCDBD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n3tsvFqV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1B14A82
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753774139; cv=none; b=CgliibxY0DQlpFKlqmlUGGcScTLQECKRNtrsZBpHIUCw5kAiJo40BwMlP++qo0EegmSMSHG6eGm8PjZ+b7uzWLPSazdd1bxw4/uIN1jSVnbXMHngYKSttDIQSPKrE2lkL+hiDOQ/D36uxd2FqjmBaLiChncXi4IazHa+lCn9txM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753774139; c=relaxed/simple;
	bh=3g+YBipnYUL1sc2oVcsnEM7sFGgk63MRJ/8jMrhMLww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbxBYmDP8Vm/SipMkkrSMXXDysYC+mVjU/GCf+baJ0/RvgNVEcATVyCjlvFBaJTCQ7p7ZuAIB3BxTThkzFuQ0aujd19jHp61BKLiTz6TxLEMuLUIGAFCuGKhoy5WS6dS3LqRbnWlpawvKXUZUrrcb/e62EZbKs6t9o3YY7TLF7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kXydCDBD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n3tsvFqV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kXydCDBD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n3tsvFqV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 286461F798;
	Tue, 29 Jul 2025 07:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753774130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+dFkNP9dnDsUlvIlgqceGQ/GQ5/Gu0UWl4aKJjd8ak=;
	b=kXydCDBD36oI7KLwmHsAq2MNzHiSN/2UBRC39MDcgstsTEEUTxDVPRh0u3ttaKG+awh7hc
	6MGQMFr4Z1tbpJn7LRNYHvB68Wp0KtgGa4fT7F2SYL2/Abc1QByUubLqFyFUvv12Ck3qkP
	Yh5IvsPIzlTvI1S08mBOPiLUF4Okplk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753774130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+dFkNP9dnDsUlvIlgqceGQ/GQ5/Gu0UWl4aKJjd8ak=;
	b=n3tsvFqVmGNsjFXEOtzB8UPN6J+POWmS72WBRd0sy8curMSugyKp0Q76CeY9GWY+/gBVJI
	qQSVL8vSl1iFhXDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753774130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+dFkNP9dnDsUlvIlgqceGQ/GQ5/Gu0UWl4aKJjd8ak=;
	b=kXydCDBD36oI7KLwmHsAq2MNzHiSN/2UBRC39MDcgstsTEEUTxDVPRh0u3ttaKG+awh7hc
	6MGQMFr4Z1tbpJn7LRNYHvB68Wp0KtgGa4fT7F2SYL2/Abc1QByUubLqFyFUvv12Ck3qkP
	Yh5IvsPIzlTvI1S08mBOPiLUF4Okplk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753774130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+dFkNP9dnDsUlvIlgqceGQ/GQ5/Gu0UWl4aKJjd8ak=;
	b=n3tsvFqVmGNsjFXEOtzB8UPN6J+POWmS72WBRd0sy8curMSugyKp0Q76CeY9GWY+/gBVJI
	qQSVL8vSl1iFhXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EF3113A73;
	Tue, 29 Jul 2025 07:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zN0mJDF4iGjXJgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Jul 2025 07:28:49 +0000
Message-ID: <2d3a9693-cbaa-46b8-9c66-d4aaf04429b4@suse.de>
Date: Tue, 29 Jul 2025 09:28:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: Initialize discovery subsys after debugfs is
 initialized
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Daniel Wagner <dwagner@suse.de>,
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250725205005.1983426-1-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250725205005.1983426-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
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

On 7/25/25 22:50, Mohamed Khalfella wrote:
> During nvme target initialization discovery subsystem is initialized
> before "nvmet" debugfs directory is created. This results in discovery
> subsystem debugfs directory to be created in debugfs root directory.
> 
> nvmet_init() ->
>    nvmet_init_discovery() ->
>      nvmet_subsys_alloc() ->
>        nvmet_debugfs_subsys_setup()
> 
> In other words, the codepath above is exeucted before nvmet_debugfs is
> created. We get /sys/kernel/debug/nqn.2014-08.org.nvmexpress.discovery
> instead of /sys/kernel/debug/nvmet/nqn.2014-08.org.nvmexpress.discovery.
> Move nvmet_init_discovery() call after nvmet_init_debugfs() to fix it.
> 
> Fixes: 649fd41420a8 ("nvmet: add debugfs support")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/target/core.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

