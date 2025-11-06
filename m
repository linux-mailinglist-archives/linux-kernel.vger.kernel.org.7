Return-Path: <linux-kernel+bounces-888207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5939AC3A315
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5250A3A961E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59362311C19;
	Thu,  6 Nov 2025 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jJ3/bdbQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vdhprjmr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jJ3/bdbQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vdhprjmr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8683115B5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423628; cv=none; b=q9SW239qwZiVayuMWddTW5BedMkXT/KemPLiOKeXqg3xgz8et1EDQVUc7RZJoCmsNAVvHrxFbZ6+1KV+y7R6Lr6PbrNFg7gWqAXq2gH6zLQROFkVHmlMuDR0cguuD4WwYBX/SH2dEqA9cVDidet72BFKaO6VnlEfb1CMg8TOJnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423628; c=relaxed/simple;
	bh=ZLEgRRSQDN7upDxdqL0XIVOlf1gnv3u5YLQ89+NLHSc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7la12mAYYhojqBFwfr01lDeNNWROp6P3S/Lpmo8CuZOTcQTLt3+4mdusYU5DiWlSz6HQE8cgysdlcjefDsGg5YkmUvh2uEZmnBOn8yBIjJTWuZesP3re0AYQZsbfj96DBvCe0EzhLWoylAMljKZBwDC6n25VShVTwAsZK3TqcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jJ3/bdbQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vdhprjmr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jJ3/bdbQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vdhprjmr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15B9E21192;
	Thu,  6 Nov 2025 10:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762423621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqy2e7Vl2dCVoFI9LrkJ5a+szigX+DcaNhhV2Ef5eI8=;
	b=jJ3/bdbQZ6LuKTSl4CUJxWNMsl7/qQigS3kpLoz72YInxvsCaTRINe+tREd1DsZygv1ZMK
	R/+6isQ5mL5OkfzaZFzZ8q/Fv5JYPbipf22i/VG87MZxTs/aJAfiyMN88NIVflI1IYywSL
	ANjnilh8a5vDkWO4eYE5/rmgU1tnFok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762423621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqy2e7Vl2dCVoFI9LrkJ5a+szigX+DcaNhhV2Ef5eI8=;
	b=vdhprjmrCNcPL7NRnhX59NxsXa8fEyX5fuIGmwIYwIFpnyeQTJsB6FJtxEfeKqQGCUPoE2
	HhVjwsyVARSFnvCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="jJ3/bdbQ";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vdhprjmr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762423621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqy2e7Vl2dCVoFI9LrkJ5a+szigX+DcaNhhV2Ef5eI8=;
	b=jJ3/bdbQZ6LuKTSl4CUJxWNMsl7/qQigS3kpLoz72YInxvsCaTRINe+tREd1DsZygv1ZMK
	R/+6isQ5mL5OkfzaZFzZ8q/Fv5JYPbipf22i/VG87MZxTs/aJAfiyMN88NIVflI1IYywSL
	ANjnilh8a5vDkWO4eYE5/rmgU1tnFok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762423621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqy2e7Vl2dCVoFI9LrkJ5a+szigX+DcaNhhV2Ef5eI8=;
	b=vdhprjmrCNcPL7NRnhX59NxsXa8fEyX5fuIGmwIYwIFpnyeQTJsB6FJtxEfeKqQGCUPoE2
	HhVjwsyVARSFnvCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDB6F13A31;
	Thu,  6 Nov 2025 10:07:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0csMMURzDGmzPAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Nov 2025 10:07:00 +0000
Date: Thu, 06 Nov 2025 11:07:00 +0100
Message-ID: <87346rh3uj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: wangdich9700@163.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: Re: [PATCH] ALSA: au88x0: Fix array bounds warning in EQ drivers
In-Reply-To: <20251106063339.114596-1-wangdich9700@163.com>
References: <20251106063339.114596-1-wangdich9700@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 15B9E21192
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[163.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,vger.kernel.org,lists.infradead.org,kylinos.cn];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,kylinos.cn:email,suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.51

On Thu, 06 Nov 2025 07:33:39 +0100,
wangdich9700@163.com wrote:
> 
> From: wangdicheng <wangdich9700@163.com>
> 
> In file included from ../sound/pci/au88x0/au8830.c:15:
> In function ¡vortex_Eqlzr_SetAllBandsFromActiveCoeffSet¢,
> ../sound/pci/au88x0/au88x0_eq.c:571:9: error: ¡vortex_EqHw_SetRightGainsTarget¢ reading 2 bytes from a region of size 0 [-Werror=stringop-overread]
> 	vortex_EqHw_SetRightGainsTarget(vortex, &(eq->this130[eq->this10]));
> 
> Modified the array access in vortex_Eqlzr_SetAllBandsFromActiveCoeffSet() to use pointer arithmetic instead of array indexing.
> This resolves a compiler warning that incorrectly flagged a buffer overread when accessing the EQ gain array.
> The this130 array has fixed size 20 and the index is safely within bounds, making the original code correct but confusing to static analysis.
> 
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>

Again, please fix From and Signed-off-by addresses.


thanks,

Takashi

