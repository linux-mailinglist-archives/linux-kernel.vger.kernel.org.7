Return-Path: <linux-kernel+bounces-884627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9B6C309F5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2C284F56A7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141832D6E76;
	Tue,  4 Nov 2025 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pMCgOU+g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nH5xlcVd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pMCgOU+g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nH5xlcVd"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E726FA60
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253559; cv=none; b=IBuZ7n45QhN/whzCOKEzrHsyHYbZKm9gkWXI+0TQosSV7JndYBG41sYI6Q0K9tg9XaXyXCZlBVVHJDzhPX/jXTLel5YuCIWvvwzaw6EXrbKbPYCSDqmcTMrGsJjGg6qRxcR9oWK6ROWRXhmXmRRazAPdXu9pdk6VvyMQdS0rS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253559; c=relaxed/simple;
	bh=rP6V5bTVeyFBBXBIL7mIO8nJ0oYs4wvpLdaLiqtd98w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Si65RAocPy/zIxwybpPgzhcqb86bsEFa2ajKOl+6aJ/uaEq0lhZrEeK3IsY/0bGJmyBPbblt/3hiy+b4S6jHQTKUtSbYZ1V3fvfLH087i+KI5EAdLx6IgOUPbT6QnXgxuAIOCxKjBk1ptoVUKthgoW89dUBbKffV/23RUAQghk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pMCgOU+g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nH5xlcVd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pMCgOU+g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nH5xlcVd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 168942116E;
	Tue,  4 Nov 2025 10:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6i469k8uzc9cH/k5nPYtXpVpJlQzHublJWG8HfoBk8=;
	b=pMCgOU+gxiefbqG2fqoc3BDjqlCGh7Wb12JBK3kEWcwGhwZ4czKuFqI5h5ZBc4UWBjgUGg
	tKuSNmlAgTjeCQqziYiZ7sEcui14rpvPIhSixOjNlPkkpmpMr3xV27+hx9Uzgi8hjKkmXC
	ETSxQxS9ybxvhN0eqDfPObLfhQpZ85U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6i469k8uzc9cH/k5nPYtXpVpJlQzHublJWG8HfoBk8=;
	b=nH5xlcVdWl6y3yLCvJqZE0/ArMBM8iyUuWptiylYWmZWH84HpgJTGb6kQtn6C5BvJbisAd
	3O/01ViM0gCEMBBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762253556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6i469k8uzc9cH/k5nPYtXpVpJlQzHublJWG8HfoBk8=;
	b=pMCgOU+gxiefbqG2fqoc3BDjqlCGh7Wb12JBK3kEWcwGhwZ4czKuFqI5h5ZBc4UWBjgUGg
	tKuSNmlAgTjeCQqziYiZ7sEcui14rpvPIhSixOjNlPkkpmpMr3xV27+hx9Uzgi8hjKkmXC
	ETSxQxS9ybxvhN0eqDfPObLfhQpZ85U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762253556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6i469k8uzc9cH/k5nPYtXpVpJlQzHublJWG8HfoBk8=;
	b=nH5xlcVdWl6y3yLCvJqZE0/ArMBM8iyUuWptiylYWmZWH84HpgJTGb6kQtn6C5BvJbisAd
	3O/01ViM0gCEMBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F111D139A9;
	Tue,  4 Nov 2025 10:52:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L4F3OvPaCWmEbwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 10:52:35 +0000
Message-ID: <fbccc6d2-4c6b-43a1-a06d-02d8af9ece96@suse.de>
Date: Tue, 4 Nov 2025 11:52:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nvmet-fcloop: remove unused lsdir member.
To: Daniel Wagner <wagi@kernel.org>, Justin Tee <justin.tee@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
 <20251028-nvmet-fcloop-fixes-v1-4-765427148613@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-4-765427148613@kernel.org>
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

On 10/28/25 16:26, Daniel Wagner wrote:
> Nothing is using lsdir member in struct fcloop_lsreq.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 4e429a1ea2bd..c30e9a3e014f 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -254,7 +254,6 @@ struct fcloop_nport {
>   struct fcloop_lsreq {
>   	struct nvmefc_ls_req		*lsreq;
>   	struct nvmefc_ls_rsp		ls_rsp;
> -	int				lsdir;	/* H2T or T2H */
>   	int				status;
>   	struct list_head		ls_list; /* fcloop_rport->ls_list */
>   };
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

