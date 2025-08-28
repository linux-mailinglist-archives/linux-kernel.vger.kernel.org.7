Return-Path: <linux-kernel+bounces-789545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3906EB39715
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97CC3BCD92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D36A2EB5CF;
	Thu, 28 Aug 2025 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g5THEQN2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ytj5Vijj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g5THEQN2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ytj5Vijj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6B2BE04D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370061; cv=none; b=AnwELBIVdFKensOzm1IwzFJCUOnu8ZUFkXrHi55orXoP5tMydaQlILGc6oXRntiYLr44HR+YzZrnWmWFvpo+kBoN9mVp7qo9xxSXJu9FGtf+59g3dJoUJ+BN1L6gqCIlWsn+6cUhdVCay3BPopEfLPGNzLY0MUDevFje5rn9xog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370061; c=relaxed/simple;
	bh=sfMt63UacuBw2pnE1Oybb1wnpfSV+T++31YiSDnOTxw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VH2wZV3woklnDkPXf58GDZ9EXY5r4wHDDHeSh3cwX+YFyDM7V2FduDYVtaTl35SwOc7svjwC8UUtU8vz/iyiozCeJFyaYYQWU//RYzz1sSh4mI+stYmDDwpON3Kj2jMEsPo/W1/L2NNja8CIJndCnDUxAMQkkIXMsnpKXR8jFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g5THEQN2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ytj5Vijj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g5THEQN2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ytj5Vijj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B60C338B6;
	Thu, 28 Aug 2025 08:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756370058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YaTh2AkPtW8EpYatcKHLSoYd9UBh9SkT7Ebip2b889Q=;
	b=g5THEQN2Jl0sHkVNcmVu3qoF0W0Z4BVmNj6waCU7+yFoM7ZyIxCReBjfzZFw88CAhBFnzV
	AhZC2r8MSus6jgXjx/mF7hNKw3oTbSviLlWCYHwF34+87+79K55lsSuz0R1deZP4oohuMo
	3MstwSyb9BOr0nGlO4JiD+O8y7VE/bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756370058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YaTh2AkPtW8EpYatcKHLSoYd9UBh9SkT7Ebip2b889Q=;
	b=ytj5Vijjrp/mOietmy2qHt6U7q8N2XD+gLUlQX4DUM33ZoDtRgAMkNlK7sFbQnt3c+cum0
	+EIF8fb1RadAYnDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=g5THEQN2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ytj5Vijj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756370058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YaTh2AkPtW8EpYatcKHLSoYd9UBh9SkT7Ebip2b889Q=;
	b=g5THEQN2Jl0sHkVNcmVu3qoF0W0Z4BVmNj6waCU7+yFoM7ZyIxCReBjfzZFw88CAhBFnzV
	AhZC2r8MSus6jgXjx/mF7hNKw3oTbSviLlWCYHwF34+87+79K55lsSuz0R1deZP4oohuMo
	3MstwSyb9BOr0nGlO4JiD+O8y7VE/bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756370058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YaTh2AkPtW8EpYatcKHLSoYd9UBh9SkT7Ebip2b889Q=;
	b=ytj5Vijjrp/mOietmy2qHt6U7q8N2XD+gLUlQX4DUM33ZoDtRgAMkNlK7sFbQnt3c+cum0
	+EIF8fb1RadAYnDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6E771368B;
	Thu, 28 Aug 2025 08:34:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hIlgL4kUsGhrLQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 28 Aug 2025 08:34:17 +0000
Date: Thu, 28 Aug 2025 10:34:17 +0200
Message-ID: <87cy8fg7zq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: lx_core: use int type to store negative error codes
In-Reply-To: <20250828081312.393148-1-rongqianfeng@vivo.com>
References: <20250828081312.393148-1-rongqianfeng@vivo.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3B60C338B6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Thu, 28 Aug 2025 10:13:10 +0200,
Qianfeng Rong wrote:
> 
> Change the 'ret' variable from u16 to int to store negative error codes or
> zero returned by lx_message_send_atomic().
> 
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but it's ugly as pants. Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
> flag is enabled.
> 
> No effect on runtime.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Applied now.  Thanks.


Takashi

