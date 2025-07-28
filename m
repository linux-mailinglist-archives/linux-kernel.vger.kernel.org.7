Return-Path: <linux-kernel+bounces-747604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33091B135DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0EA7A91EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855F12165EC;
	Mon, 28 Jul 2025 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TNEWAEhf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YMr/2LGD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TNEWAEhf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YMr/2LGD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421119E97A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689103; cv=none; b=s+okIFNUALcMmyeP1+h1hnWGfuZ8mVgVhCFEDZoRzJnoqxQj32+DAUlSKokEr2cHoYdvgDk2+KwH7WICuhRkmRRk6OEWstp2BR+fy5AoJe73GJEV8z9BD0ty//qgnTf3yC612O7WJ936t31Q2QI8bKAnfwrzHsX9IyLLgMr4y38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689103; c=relaxed/simple;
	bh=SxWgn7HVnhivKlRNCeBL1hfo6OlmnPIbpZAA69eZUIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKYLQ3KBdQeBtrEL1mMp8M1knlOD79JnxC2LNVZf1a2rFdzgtwkDxNh1c3FmRFjX43wcvzdbISifw6/JLsQXxtKlYm2EX1CC9xK40Az6qfk+PAtBDCsPKYve7gXSJBBm4/WhCCxfgFpX8rTN2hXZN2eE7b5r7ok3mqr6bVsOVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TNEWAEhf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YMr/2LGD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TNEWAEhf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YMr/2LGD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 461691F750;
	Mon, 28 Jul 2025 07:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753689100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jt+LF63WPq9M7qfyoZDi9ix/UMLVruye6wA/WsxEDGA=;
	b=TNEWAEhfmMvgidAn9FpW3SEOjxUDcLGCMI1W7iTWwg9RqwshklTRNldiiej4NDQL1aJ7t1
	Dvz9YLc59jH/5ZJtUWK2433gdzsH3upXNLH4njHM8QfzjRHhpDiHRtI7PSiNnmm8Ji9sRi
	wzpuDc2cNBzbd9ib4eHBnvFXuZXTECM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753689100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jt+LF63WPq9M7qfyoZDi9ix/UMLVruye6wA/WsxEDGA=;
	b=YMr/2LGD88wN7gz09qZLyeD25hyo+JQ5s/mUnMUv7ObjFQhHZqJKAE4pW1RkUa3Wdx79X/
	5oIHVZHsa0QsjCBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753689100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jt+LF63WPq9M7qfyoZDi9ix/UMLVruye6wA/WsxEDGA=;
	b=TNEWAEhfmMvgidAn9FpW3SEOjxUDcLGCMI1W7iTWwg9RqwshklTRNldiiej4NDQL1aJ7t1
	Dvz9YLc59jH/5ZJtUWK2433gdzsH3upXNLH4njHM8QfzjRHhpDiHRtI7PSiNnmm8Ji9sRi
	wzpuDc2cNBzbd9ib4eHBnvFXuZXTECM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753689100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jt+LF63WPq9M7qfyoZDi9ix/UMLVruye6wA/WsxEDGA=;
	b=YMr/2LGD88wN7gz09qZLyeD25hyo+JQ5s/mUnMUv7ObjFQhHZqJKAE4pW1RkUa3Wdx79X/
	5oIHVZHsa0QsjCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36C021368A;
	Mon, 28 Jul 2025 07:51:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CSJjDAwsh2i5DgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 28 Jul 2025 07:51:40 +0000
Date: Mon, 28 Jul 2025 09:51:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, 
	Hannes Reinecke <hare@kernel.org>, Randy Jennings <randyj@purestorage.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Initialize discovery subsys after debugfs is
 initialized
Message-ID: <630f5d07-ad66-4b1a-b13d-670012e5fab9@flourine.local>
References: <20250725205005.1983426-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725205005.1983426-1-mkhalfella@purestorage.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,purestorage.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Fri, Jul 25, 2025 at 01:50:05PM -0700, Mohamed Khalfella wrote:
> During nvme target initialization discovery subsystem is initialized
> before "nvmet" debugfs directory is created. This results in discovery
> subsystem debugfs directory to be created in debugfs root directory.
> 
> nvmet_init() ->
>   nvmet_init_discovery() ->
>     nvmet_subsys_alloc() ->
>       nvmet_debugfs_subsys_setup()
> 
> In other words, the codepath above is exeucted before nvmet_debugfs is
> created. We get /sys/kernel/debug/nqn.2014-08.org.nvmexpress.discovery
> instead of /sys/kernel/debug/nvmet/nqn.2014-08.org.nvmexpress.discovery.
> Move nvmet_init_discovery() call after nvmet_init_debugfs() to fix it.
> 
> Fixes: 649fd41420a8 ("nvmet: add debugfs support")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

