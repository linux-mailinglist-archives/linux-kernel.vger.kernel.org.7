Return-Path: <linux-kernel+bounces-740298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E020B0D258
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FF96C7DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AF92BE7CC;
	Tue, 22 Jul 2025 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MXesI4YK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tiGZJ0Gy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MXesI4YK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tiGZJ0Gy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532161DB122
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168066; cv=none; b=SG4/PLwcSY/qcnID8FaCQTmrsZVKzgVWlkk3j+4UrAJyY6T2dquFHEdsGDWX1kMEkqhrw0jjw1s8LJIrNjrnusEz1SFpJieAw6pRTUPdM8y35rHVro0OoqAgB5T+wwvwmYm31hqme02swRKtsXZIpI6qFiD9LFaNFotWxjITGZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168066; c=relaxed/simple;
	bh=QcKd8PsbOH04ztlC++6g9AxLX0SainTl+mXcmOk12uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EH8PVJIzFdFojcVaSVEHiJDwK4LLKrPpCBGP/Ud3AAeGBxAtqni0lVorZkLGafTAAW+Cf6kygLLS8xpYxmWsMCTqsyNVKHWTKBhqs1XSpnw2wV168iR/7GcqzHwLCkJTodONFDB6bzNXFOZfA52wkFxUqoz0men3CrozykxEK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MXesI4YK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tiGZJ0Gy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MXesI4YK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tiGZJ0Gy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A48D1F7C7;
	Tue, 22 Jul 2025 07:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753168063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB0bdUuvTMSoUuv8zpmwKTPtA+pQOTkGSSD5giYhlT4=;
	b=MXesI4YKqsNYCaPfsw1fhSzy5j+PRo59T1TfL53hNIWABgMPPaNp5wv3DaAY8bGuyXDolm
	IKgDGdmu9902cEkSaL1X7hke/Vvj54DPIcBqAyZ02zWw00er1J3qA5xhp/h0MctC20krla
	qd76X2W+0I2BZIXrVAqE45Y3gdw7kdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753168063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB0bdUuvTMSoUuv8zpmwKTPtA+pQOTkGSSD5giYhlT4=;
	b=tiGZJ0GyASz6nAzCbYxbBv1RDfwF7jlnPqB42VVpKwSFZ4J/FfgcAg00KytwkvLLdfDVCN
	Xh88WzYwCF7FAHBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MXesI4YK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tiGZJ0Gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753168063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB0bdUuvTMSoUuv8zpmwKTPtA+pQOTkGSSD5giYhlT4=;
	b=MXesI4YKqsNYCaPfsw1fhSzy5j+PRo59T1TfL53hNIWABgMPPaNp5wv3DaAY8bGuyXDolm
	IKgDGdmu9902cEkSaL1X7hke/Vvj54DPIcBqAyZ02zWw00er1J3qA5xhp/h0MctC20krla
	qd76X2W+0I2BZIXrVAqE45Y3gdw7kdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753168063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB0bdUuvTMSoUuv8zpmwKTPtA+pQOTkGSSD5giYhlT4=;
	b=tiGZJ0GyASz6nAzCbYxbBv1RDfwF7jlnPqB42VVpKwSFZ4J/FfgcAg00KytwkvLLdfDVCN
	Xh88WzYwCF7FAHBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D0FA13A32;
	Tue, 22 Jul 2025 07:07:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uZZEBb84f2hZdAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Jul 2025 07:07:43 +0000
Message-ID: <fac23c24-100b-4bc2-ae74-045fb71990b0@suse.de>
Date: Tue, 22 Jul 2025 09:07:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme: prevent admin controller from smart log
 fetch (LID 2)
To: Kamaljit Singh <kamaljit.singh1@wdc.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cassel@kernel.org, dlemoal@kernel.org
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
 <20250718001415.3774178-3-kamaljit.singh1@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250718001415.3774178-3-kamaljit.singh1@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 6A48D1F7C7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 7/18/25 02:14, Kamaljit Singh wrote:
> Similar to a discovery ctrl, prevent an admin-ctrl from getting a smart
> log. LID 2 is optional for admin controllers to support.
> 
> In the future when support for LID=0 (supported log pages) is added,
> GLP accesses can be made smarter by basing such calls on response
> from LID=0 reads.
> 
> Reference: NVMe Base rev 2.2, sec 3.1.3.5, fig 31.
> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 105127638c31..6e5c9871b76d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3705,7 +3705,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
>   
>   	nvme_configure_opal(ctrl, was_suspended);
>   
> -	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
> +	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl)) {
>   		/*
>   		 * Do not return errors unless we are in a controller reset,
>   		 * the controller works perfectly fine without hwmon.

And to go with my suggestion for the previous patch, maybe it's
an idea to have a helper 'nvme_io_queues_supported()' which could be
used here (and in the previous patch)?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

