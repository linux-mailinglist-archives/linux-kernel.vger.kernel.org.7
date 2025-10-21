Return-Path: <linux-kernel+bounces-863664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E73FBF8C05
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFD619A7CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A45427FB26;
	Tue, 21 Oct 2025 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ETUopv01";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZJeS7q18";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QwBCdvEZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c9dmNqQh"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE4F27815E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079371; cv=none; b=HfMJdp8EaWO4euq7xBCe3ukG5/k0Z7VLZGXIekbwU0yVo/+pdP4uZRo5Wc5V7p5TVDabNdW4CGxOjQgZyL/U4ctV/Pk6uBSxazmc1E+/iq03cIPzsMGWip9QXwXSk0ty3gD/j98QYfHE+gIk5V2Pv259t4V03XYFOgpqBivJ+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079371; c=relaxed/simple;
	bh=8PxKePBpIbHHxXdTPOcQ1mC94NI2v6cQYpcbtNALbrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVJp+3jBgnkEnUhuKCxMltrxKoomksl+pT12L7t/BtevAWhXdonwMx5y3ABQhSz0FvYhscnb5H/+ARLGoVK5pmab2veVAzlR5OYIEEk6cW+JSFYNHRmtkiuzfAB8YMBXHfvcnT/UHqwiT5+7swcBlu+QU4tsie6nt4G3BTK5ohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ETUopv01; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZJeS7q18; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QwBCdvEZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c9dmNqQh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 256941F38D;
	Tue, 21 Oct 2025 20:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761079361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jsOKW3AIPQN5V89Qk8Zc+bn1VcB+y5eEPzzaa4evx6Y=;
	b=ETUopv01kqaKUCXdffLwKvrU5AzimIF1OII50aAJ5VwlaVQxjcjtm3jzGaLFOV3GhHj19o
	g52nPuEPA6l+wMdeJIF4EWkRheZBQi+cfs4VoGEBn0GcdRUdiusMFOnXj/l8onRwtHOzFB
	dpMF+ZvJjrayu3jLVkHGj8zafzj/q3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761079361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jsOKW3AIPQN5V89Qk8Zc+bn1VcB+y5eEPzzaa4evx6Y=;
	b=ZJeS7q1829Pj7YDTZFQDXrBGPmr/0oNSbHhaW0M/uKZfdAJREDPhMkk6koeCcCDlS/UecB
	A5zHAnxsM3sV/wCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761079357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jsOKW3AIPQN5V89Qk8Zc+bn1VcB+y5eEPzzaa4evx6Y=;
	b=QwBCdvEZ/z2tW5qfKdea4qK1kL+8tkv999tgqAAjsugXwX/zIwxGgQy9+XxY/T7HbaPsPo
	Xu4iEJwn7A61wLJvods7inTvrnCGmHeLDzJKWAqqC1auWnpCasXqBEpzpYG+StzN/Kjm4v
	OzooJ9Mmui4/VAOuj1V1cURqcYTaH78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761079357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jsOKW3AIPQN5V89Qk8Zc+bn1VcB+y5eEPzzaa4evx6Y=;
	b=c9dmNqQh8VC5v0GdRtKRykh+U5EvJ9BgO2eoxTtNLctYFutk+rTMx8aFcvAKaPaMCFK41c
	vD1awaw2qmBueIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D6AA139B1;
	Tue, 21 Oct 2025 20:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oUDpAj3w92gyTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Oct 2025 20:42:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 37370A0990; Tue, 21 Oct 2025 22:42:36 +0200 (CEST)
Date: Tue, 21 Oct 2025 22:42:36 +0200
From: Jan Kara <jack@suse.cz>
To: Vlad Kulikov <vlad.kulikov.c@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	David Hildenbrand <david@redhat.com>, Simon Schuster <schuster.simon@siemens-energy.com>, 
	Vlad Kulikov <vlad_kulikov_c@pm.me>, Ma Wupeng <mawupeng1@huawei.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipc: create_ipc_ns: drop mqueue mount on sysctl setup
 failure
Message-ID: <ooib77rqm2jfirnf6cbgefpfkutoarq3ypi4guiueuodkdns6n@yhn7n5f5ucex>
References: <20251021181341.670297-1-vlad_kulikov_c@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021181341.670297-1-vlad_kulikov_c@pm.me>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Tue 21-10-25 21:13:39, Vlad Kulikov wrote:
> If setup_mq_sysctls(ns) fails after mq_init_ns(ns) succeeds, the error
> path skipped releasing the internal kernel mqueue mount kept in
> ns->mq_mnt. That leaves the vfsmount/superblock referenced until final
> namespace teardown, i.e. a resource leak on this rare failure edge.
> 
> Unwind it by calling mntput(ns->mq_mnt) before dropping user_ns and
> freeing the IPC namespace. This mirrors the normal ordering used in
> free_ipc_ns().
> 
> Signed-off-by: Vlad Kulikov <vlad_kulikov_c@pm.me>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  ipc/namespace.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index 59b12fcb40bd..cf62d11a09b9 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -75,10 +75,10 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
>  
>  	err = -ENOMEM;
>  	if (!setup_mq_sysctls(ns))
> -		goto fail_put;
> +		goto fail_mq_mount;
>  
>  	if (!setup_ipc_sysctls(ns))
> -		goto fail_mq;
> +		goto fail_mq_sysctls;
>  
>  	err = msg_init_ns(ns);
>  	if (err)
> @@ -92,9 +92,10 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
>  
>  fail_ipc:
>  	retire_ipc_sysctls(ns);
> -fail_mq:
> +fail_mq_sysctls:
>  	retire_mq_sysctls(ns);
> -
> +fail_mq_mount:
> +	mntput(ns->mq_mnt);
>  fail_put:
>  	put_user_ns(ns->user_ns);
>  	ns_common_free(ns);
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

