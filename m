Return-Path: <linux-kernel+bounces-844708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E16BBC28E9
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E36B34F2F85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9069C228CBC;
	Tue,  7 Oct 2025 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qoL0TY5Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ug7Cvqmm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qoL0TY5Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ug7Cvqmm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4485015B971
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759866759; cv=none; b=jpbOk9JAmKfjAAkpy4f9bWI3aXsYb76i6P/Z/G9/0dq0uRkOdeR1kLdIHTy05reABOO5TEdgx3sv4vr0fAOHUzIXM5gXdDE3UpVzb/aWtBeupYm9lyyA/3fHH9SpeS/kAL4LlFOSaMXoSqO2O+s+s8UFgrTYnd4DEhLM8hHwqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759866759; c=relaxed/simple;
	bh=W8mfpTTTobhHAMBtX3V8fhqKx02V3ANQOh/eqTqD+xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot1nvrUT1reep7I5vZXsBR4LWjymk5IRDlkEuXi33NrAlY/QG85HiWRa7PBDOQDiiIaaVubEhjpqYGPMTP5XKnk5CteuObQ7XYsXKfOOt1saZqsMfcBgCFQQ0/24ordY6arjweAvkpu7tRqacWuikrEtsSwrH6TvRranNU4Oubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qoL0TY5Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ug7Cvqmm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qoL0TY5Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ug7Cvqmm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45FAF1F38F;
	Tue,  7 Oct 2025 19:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759866755;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/6ycznNAaNzZ2Kw9ftZKFBuaKypa6S9AHLf5Pa9sGA=;
	b=qoL0TY5QaSPvWiJtSGufq7eVuQcA/6LWen9M/JjYE0PQLkdqjbT0q/t5xPLEn9JLdtJLjP
	csMO4ZWFoaACo7fT9RVozt8IRKXPO1BOwII8NlEbU+RMaNI7h+VpgvLYhJ3WW8urVno5K+
	jGaIBHOamiKF9hoXxwZmSwGghVvsusA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759866755;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/6ycznNAaNzZ2Kw9ftZKFBuaKypa6S9AHLf5Pa9sGA=;
	b=ug7CvqmmbG8EyqlF1hrah6xb1bGpKOI+y+g3FuaeJ+e5F8328EAaQjvt0HS7aHtoiG+NH1
	CTRIpSuOwcd9JRBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759866755;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/6ycznNAaNzZ2Kw9ftZKFBuaKypa6S9AHLf5Pa9sGA=;
	b=qoL0TY5QaSPvWiJtSGufq7eVuQcA/6LWen9M/JjYE0PQLkdqjbT0q/t5xPLEn9JLdtJLjP
	csMO4ZWFoaACo7fT9RVozt8IRKXPO1BOwII8NlEbU+RMaNI7h+VpgvLYhJ3WW8urVno5K+
	jGaIBHOamiKF9hoXxwZmSwGghVvsusA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759866755;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/6ycznNAaNzZ2Kw9ftZKFBuaKypa6S9AHLf5Pa9sGA=;
	b=ug7CvqmmbG8EyqlF1hrah6xb1bGpKOI+y+g3FuaeJ+e5F8328EAaQjvt0HS7aHtoiG+NH1
	CTRIpSuOwcd9JRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C100F13693;
	Tue,  7 Oct 2025 19:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gzQ6K4Jv5WiIHAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 07 Oct 2025 19:52:34 +0000
Date: Tue, 7 Oct 2025 21:52:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Shuhao Fu <sfual@cse.ust.hk>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@nvidia.com>
Subject: Re: [PATCH] drm/nouveau: fix bad ret code in nouveau_bo_move_prep
Message-ID: <20251007195233.GA154142@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <aOU9BXjYDNoPRQmf@homelab>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOU9BXjYDNoPRQmf@homelab>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.50

Hi,

[ Cc Ben ]

> In `nouveau_bo_move_prep`, if `nouveau_mem_map` fails, an error code
> should be returned. Currently, it returns zero even if vmm addr is not
> correctly mapped.

> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
> Fixes: 9ce523cc3bf2 ("drm/nouveau: separate buffer object backing memory from nvkm structures")
> ---
>  drivers/gpu/drm/nouveau/nouveau_bo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> index b96f0555ca14..f26562eafffc 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> @@ -929,7 +929,7 @@ nouveau_bo_move_prep(struct nouveau_drm *drm, struct ttm_buffer_object *bo,
>  		nvif_vmm_put(vmm, &old_mem->vma[1]);
>  		nvif_vmm_put(vmm, &old_mem->vma[0]);
>  	}
> -	return 0;
> +	return ret;

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

