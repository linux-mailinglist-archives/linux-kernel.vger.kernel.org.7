Return-Path: <linux-kernel+bounces-885907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B2FC34398
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708C83AD025
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B5D2D2483;
	Wed,  5 Nov 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XBZyZcrd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FYCxHsRk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XBZyZcrd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FYCxHsRk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC8A2AF1D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327797; cv=none; b=F6f4/SBsdyFJJg+tAnA5cLkpwIBAul6+eG4V7sAbKhRhzTX7PsBxg/W6pkVaPC0JxznC1L6h885Pf0WpwytmB7yeRK0N7pgF/KoHuAVkHDrpBAOCCviregfNDc3yh4McKH418tbNIyWpYmcX8sphhntl14AdKg5Db/nOwr8cMf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327797; c=relaxed/simple;
	bh=ZZZQyn6ETHf4B1AcYBgpacdGjsCz9VdyCkoCikZ2QC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHQEfpU+XrbX4f39xgf2Lzonpv+fgY05OEzjDe3i1PrwXZ6COdAPCg+vopMSX7PZLeWBI4sKSVewTtcbzDPgIiBHE6DKOU6+A/Kr+VRkgETEyC/vLyg8QRAgc7keUCUfS+gxzixUnIPukCicvTs7LvY8GU9gHslxbzd69NLUdzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XBZyZcrd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FYCxHsRk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XBZyZcrd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FYCxHsRk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C24621195;
	Wed,  5 Nov 2025 07:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762327793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmga5nXVCyzNWMG6xGY585JOAg+yJVHIX21UaQb1d+U=;
	b=XBZyZcrdJU1kUT8K+IBrq+1dGA88PUJ3KKgeIFR1aIH+FfrfJW4udWm1is9ccjrALQPDHy
	3uAPG1yztE3o6iwCJupU4jIuJIpuknLMIKGTbtxpL2kIK5htgsbYOaMhQ918DPLkydHJVh
	eM9SkYjWV7GDvcdHdqumOgJPKtKyyuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762327793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmga5nXVCyzNWMG6xGY585JOAg+yJVHIX21UaQb1d+U=;
	b=FYCxHsRk8/HgNHe7J/nqXG4bJl1ZT40HiMDrEXgCppRpg57QbhVieb8l6Q6uDyEKpWdxUZ
	liuwd6hiauWzvJDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762327793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmga5nXVCyzNWMG6xGY585JOAg+yJVHIX21UaQb1d+U=;
	b=XBZyZcrdJU1kUT8K+IBrq+1dGA88PUJ3KKgeIFR1aIH+FfrfJW4udWm1is9ccjrALQPDHy
	3uAPG1yztE3o6iwCJupU4jIuJIpuknLMIKGTbtxpL2kIK5htgsbYOaMhQ918DPLkydHJVh
	eM9SkYjWV7GDvcdHdqumOgJPKtKyyuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762327793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmga5nXVCyzNWMG6xGY585JOAg+yJVHIX21UaQb1d+U=;
	b=FYCxHsRk8/HgNHe7J/nqXG4bJl1ZT40HiMDrEXgCppRpg57QbhVieb8l6Q6uDyEKpWdxUZ
	liuwd6hiauWzvJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FFBB132DD;
	Wed,  5 Nov 2025 07:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MGyFDfH8Cmn7JgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:29:53 +0000
Message-ID: <31a4e5f0-43e1-4aed-af84-715aca53fa1b@suse.de>
Date: Wed, 5 Nov 2025 08:29:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash
 calculation
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251104231414.1150771-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251104231414.1150771-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 11/5/25 00:14, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> the sc_c variable to the dhchap queue context structure which is
> appropriately set during negotiate and then used in the host response.
> 
> This breaks secure concat connections with a Linux target as the target
> code wasn't updated at the same time. This patch fixes this by adding a
> new sc_c variable to the host hash calculations.
> 
> Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v2:
>   - Rebase on v6.18-rc4
>   - Add Fixes tag
> 
>   drivers/nvme/host/auth.c               | 1 +
>   drivers/nvme/target/auth.c             | 5 +++--
>   drivers/nvme/target/fabrics-cmd-auth.c | 1 +
>   drivers/nvme/target/nvmet.h            | 1 +
>   4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index a01178caf15b..19980122d3d5 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -492,6 +492,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
>   	ret = crypto_shash_update(shash, buf, 2);
>   	if (ret)
>   		goto out;
> +	memset(buf, 0, sizeof(buf));
>   	*buf = chap->sc_c;
>   	ret = crypto_shash_update(shash, buf, 1);
>   	if (ret)
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 02c23998e13c..f54a1425262d 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -298,7 +298,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
>   	const char *hash_name;
>   	u8 *challenge = req->sq->dhchap_c1;
>   	struct nvme_dhchap_key *transformed_key;
> -	u8 buf[4], sc_c = ctrl->concat ? 1 : 0;
> +	u8 buf[4];
>   	int ret;
>   
>   	hash_name = nvme_auth_hmac_name(ctrl->shash_id);
> @@ -367,7 +367,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
>   	ret = crypto_shash_update(shash, buf, 2);
>   	if (ret)
>   		goto out;
> -	*buf = sc_c;
> +	*buf = req->sq->sc_c;
>   	ret = crypto_shash_update(shash, buf, 1);
>   	if (ret)
>   		goto out;
> @@ -378,6 +378,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
>   	ret = crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl->hostnqn));
>   	if (ret)
>   		goto out;
> +	memset(buf, 0, sizeof(buf));
>   	ret = crypto_shash_update(shash, buf, 1);
>   	if (ret)
>   		goto out;
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index 5d7d913927d8..16894302ebe1 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -43,6 +43,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
>   		 data->auth_protocol[0].dhchap.halen,
>   		 data->auth_protocol[0].dhchap.dhlen);
>   	req->sq->dhchap_tid = le16_to_cpu(data->t_id);
> +	req->sq->sc_c = le16_to_cpu(data->sc_c);
>   	if (data->sc_c != NVME_AUTH_SECP_NOSC) {
>   		if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
>   			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;

Hmm. Storing 'sc_c' directly does away with the need for the 'concat'
controller setting.
Can't we just drop that and use 'sq->sc_c' directly when checking if
secure concatenation is enabled?

> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 73da823a91fb..20be2fe43307 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -159,6 +159,7 @@ struct nvmet_sq {
>   	bool			authenticated;
>   	struct delayed_work	auth_expired_work;
>   	u16			dhchap_tid;
> +	u8			sc_c;
>   	u8			dhchap_status;
>   	u8			dhchap_step;
>   	u8			*dhchap_c1;
Cheers,Hannes

-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

