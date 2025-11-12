Return-Path: <linux-kernel+bounces-896644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4801DC50E11
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8D33AE9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3657280A56;
	Wed, 12 Nov 2025 07:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sI+hAMX5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IUrc5g02";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RDugWhxp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i6uosrg9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C951B283C83
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931248; cv=none; b=TfuXYsPn42I4SFKXHH4TxCGuQ0o5FbZQUV6jp06RzLlYgPxrNoHMP6AGkd1S3i8FmqS8H/fYA0liFgO3u3SX+sUyrpu3qJMOUMabpu35lx2PEiC5ahC71nhmuWZN+gdJ7VuDnM8ANCK0RMadg7K2yxeVhhl8Hdj9RzRnpCWyM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931248; c=relaxed/simple;
	bh=kbeWbVE4vvsYMtESxtJkV4wxq1IPLKLSdZDHPMJEofo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7BFlxCoYMNSNgEpKiIyBcXYPxcVCvSYoEcozisv367gBjUyMh9dka4TtX9JHAdrk6dS7aSHDaiOg06gk5oFt0sq3t6+moDPnmoZjlvmd4QOA5lYW6eYZG3Ba4q1e2MlPORU5juQEjI6YzkXwrf6K2EouEQC7P3khvYeFr2izCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sI+hAMX5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IUrc5g02; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RDugWhxp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i6uosrg9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9DBF6211BF;
	Wed, 12 Nov 2025 07:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762931240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRcMr7fe/GG5q1A3wFULlZkFpSuz4pCLva2R0pIKsR4=;
	b=sI+hAMX5UPFiom3zBkcscENoTVS2k7IbLNbuT8yasdRQr/XQCQdpM/k0junjfBA5Uto+mw
	7EDPlL//S6pTMnmFB+kMsA19ZiCuNq2yaPyfvIFisyRBU1b8mbMJOSlYboAGTWZ/p+S0Aa
	YyRNvgLpyuVWcxPMAFDpFUWdgpWV2Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762931240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRcMr7fe/GG5q1A3wFULlZkFpSuz4pCLva2R0pIKsR4=;
	b=IUrc5g023YyvOM0Lg9H2Bmd0RRNHG3eiI0/t6L2pJIiXGRyBWOEr2L2h8MGoCht6ofhxsu
	/svSC1Moy7wFevDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RDugWhxp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=i6uosrg9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762931239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRcMr7fe/GG5q1A3wFULlZkFpSuz4pCLva2R0pIKsR4=;
	b=RDugWhxpSKecofuvA6QHrckEnQ5sNjrsgAWSmWp+S/hnLQVplLaiPz0DsGpOtJYt1GXyZ+
	fs3hrXBhtcligBP1McybppjE5cXeRtyumDjNqcV28WxiVOK9AneXQv7tc0VlQSa1ecfhOh
	c8CQbTFaCadBsoo7vPQcCIPqxchNrFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762931239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRcMr7fe/GG5q1A3wFULlZkFpSuz4pCLva2R0pIKsR4=;
	b=i6uosrg9JtAKAcgLzgdrg7XXpBSzvKOUmJ4qFb4M6mJEGPNvFN+jC84tkNaxQMWrYB/c7o
	fMfRXPl+f7B7EFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43E4014DC3;
	Wed, 12 Nov 2025 07:07:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lCZvDCcyFGmzcwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 12 Nov 2025 07:07:19 +0000
Message-ID: <2a0c50cf-86b3-45bd-aa8d-c462aae5b900@suse.de>
Date: Wed, 12 Nov 2025 08:07:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] nvmet-tcp: Don't free SQ on authentication success
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-3-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251111234519.3467440-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9DBF6211BF
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email,wdc.com:email]
X-Spam-Score: -4.51

On 11/12/25 00:45, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Curently after the host sends a REPLACETLSPSK we free the TLS keys as
> part of calling nvmet_auth_sq_free() on success. This means when the
> host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
> check for !nvmet_queue_tls_keyid(req->sq) fails.
> 
> This patch ensures we don't free the TLS key on success as we might need
> it again in the future.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v2:
>   - Don't call nvmet_auth_sq_free() in nvmet_execute_auth_send() either
> 
>   drivers/nvme/target/fabrics-cmd-auth.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

