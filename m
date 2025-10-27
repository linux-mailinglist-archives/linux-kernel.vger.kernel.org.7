Return-Path: <linux-kernel+bounces-871188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD23C0C974
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A88B189998B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA93F2F25F4;
	Mon, 27 Oct 2025 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ccTXQRot";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="glWsukJw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ccTXQRot";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="glWsukJw"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87A2E3AF2
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556109; cv=none; b=JWHRb/lRX53hThBkHF5t46GnkwZL4SlffYhw9N5dGqMYrVwFUGyM0xOnjF1J5b6DKF5V0gjQJr1a1YlwkBNINARkToQLTV70PUlA0T5St9ZTBkIJ7j6OldExx5odJ+uB8Pah6LhKevhahprf1OBcMvh9lGLbIik3a78cPadOP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556109; c=relaxed/simple;
	bh=L1bFiyMc0yMNUn7YfXsVdvNaa76ss5DHKKPYcqoZLvU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNCqiTRXe3d7d/6Jf06td33r/MhzVv9w4UzkyixpCj+Tby4jSbahGTh91GxDna2MxAyPtASVwbDnoOkXmI478KjHpoajFSNMwr5/eRXolFMxYmXB1fkjwRtCUvVy1bvZ7sCqf3i2VeR0o5e6xMqZlTkzZKZxevZbyU830PZn8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ccTXQRot; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=glWsukJw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ccTXQRot; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=glWsukJw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D1292115B;
	Mon, 27 Oct 2025 09:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761556105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EzkgZOlW5Ew7TsM2l/uMKjTEqtL4QdDKfQ93Hy/a1cc=;
	b=ccTXQRotqycIFjThC/E1w5IbzQ2Q4GY6WpqmO1Zktc7T96T3hwCYgs0gcx/pENSZ6O4k9b
	/bL3tCd0auVnmzcO3+/NC69v5ZhFgwlc4Le9nrJBamqop9U1ZN2okHUEkMchoQh3N+QTFs
	Dy3puiWtSd/ZqevKa+3nhL6N2S8uh/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761556105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EzkgZOlW5Ew7TsM2l/uMKjTEqtL4QdDKfQ93Hy/a1cc=;
	b=glWsukJw2lWPdHOrLmACZ9vU1xmvcjXlOvVVqk1ie4+dXYne4/xSOJ2sTRFJ01zU4rULAS
	KiYtqxlWGym2w+AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761556105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EzkgZOlW5Ew7TsM2l/uMKjTEqtL4QdDKfQ93Hy/a1cc=;
	b=ccTXQRotqycIFjThC/E1w5IbzQ2Q4GY6WpqmO1Zktc7T96T3hwCYgs0gcx/pENSZ6O4k9b
	/bL3tCd0auVnmzcO3+/NC69v5ZhFgwlc4Le9nrJBamqop9U1ZN2okHUEkMchoQh3N+QTFs
	Dy3puiWtSd/ZqevKa+3nhL6N2S8uh/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761556105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EzkgZOlW5Ew7TsM2l/uMKjTEqtL4QdDKfQ93Hy/a1cc=;
	b=glWsukJw2lWPdHOrLmACZ9vU1xmvcjXlOvVVqk1ie4+dXYne4/xSOJ2sTRFJ01zU4rULAS
	KiYtqxlWGym2w+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62ECA136CF;
	Mon, 27 Oct 2025 09:08:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MZffFok2/2ieRwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 27 Oct 2025 09:08:25 +0000
Date: Mon, 27 Oct 2025 10:08:25 +0100
Message-ID: <87h5vk3e5y.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: tanze <tanze@kylinos.cn>
Cc: phasta@mailbox.org,
	perex@perex.cz,
	phasta@kernel.org,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: maestro3: using vmalloc_array() to handle the code
In-Reply-To: <20251024105549.210654-1-tanze@kylinos.cn>
References: <20251024105549.210654-1-tanze@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Fri, 24 Oct 2025 12:55:49 +0200,
tanze wrote:
> 
> Change array_size() to vmalloc_array(), due to vmalloc_array()
> being optimized better, using fewer instructions, and handles
> overflow more concisely.
> 
> Signed-off-by: tanze <tanze@kylinos.cn>
> ---
> Hi, Philipp Stanner,
> 
> Thank you for your suggestions.
> I have made revisions according to your requirements.
> 
> Regarding the issue of my full name, thank you for your 
> attention to detail. Since I am in China, I use the name 
> "tanze" on many occasions, and the code I previously submitted 
> to the upstream community was also under this name.
> ---
> Changes in v2:
>  - Fix some issues in the commit message.
> 
> v1:
>  - patch: https://lore.kernel.org/all/20251022092339.551438-1-tanze@kylinos.cn/
> 
> Best regards,
> Ze Tan 

Applied now to for-next branch.

A name spelling like "tanze" seems seen often for Chinese names, so I
don't think it's a problem (although it appears somehow strange for
western countries).


thanks,

Takashi

