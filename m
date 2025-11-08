Return-Path: <linux-kernel+bounces-891377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ED2C42900
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 08:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4BF2B34B5F5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 07:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F62D739A;
	Sat,  8 Nov 2025 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qiEpD0x7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GWsG4oQT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qiEpD0x7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GWsG4oQT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54676285056
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762588526; cv=none; b=BeQlQR/SXxzPdr4K66dmMP/vHmwnuwyCQRypqV4SBHqCIrcRocvZPxRmSrRapfK7AA8Swx0YHg5S704DZjQaUw8lo2HpaRLVaD0orN8cWapy/rxY+kYoWy1PR6Mx5BIKIbAdJRd9mDQLYgioPhRWDn5wMB9ckE6bhC+HwLRza0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762588526; c=relaxed/simple;
	bh=JbBNdtDaUtqqNYh1NWJa1XrNS9PG/arKaCm3O/R6s5g=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnkgzF1r6CfJ0Mr0M3XBrMuIrpfq+8NPmCLyZO2fBpbrf12/TGj6fewXOnpflzo3yxOXSQr0Oz7m7H/F31N/Me3n/W6Q+sTao1undw3SO3o1m3/4K3qo6eyyOi3MyCdNIGB2x18U9LfuJgrxUs8TMbxgIDJtetpEfOZNstLccjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qiEpD0x7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GWsG4oQT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qiEpD0x7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GWsG4oQT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A366733AB5;
	Sat,  8 Nov 2025 07:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762588523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8ITrRH+YcsupiGQECJHppJ59lDIxrFeb+scWJOGz24=;
	b=qiEpD0x7r+GhCxqLrUH2AP0FRiYFpDO6JcZAmDOrkrhHA9Ux2zJx6/jdW/hNpRuh4LNAVr
	kb299GmgDCQnD8pmsj/IBLCjDDtuOyKq1oRIYGd9Npd+lJ28KQAEza3GCIi7cWjjQno1kt
	ApNcbrAKsI5J2BUur4NBHBQ0PcTlGOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762588523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8ITrRH+YcsupiGQECJHppJ59lDIxrFeb+scWJOGz24=;
	b=GWsG4oQTQ9O1mxJjBVx+z/7GC73jTqeXrLYJ8/7v7g8c+6OLdkupQImgIc2UIqWb/f9mJJ
	j9/omqwqpyI5L0Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762588523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8ITrRH+YcsupiGQECJHppJ59lDIxrFeb+scWJOGz24=;
	b=qiEpD0x7r+GhCxqLrUH2AP0FRiYFpDO6JcZAmDOrkrhHA9Ux2zJx6/jdW/hNpRuh4LNAVr
	kb299GmgDCQnD8pmsj/IBLCjDDtuOyKq1oRIYGd9Npd+lJ28KQAEza3GCIi7cWjjQno1kt
	ApNcbrAKsI5J2BUur4NBHBQ0PcTlGOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762588523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8ITrRH+YcsupiGQECJHppJ59lDIxrFeb+scWJOGz24=;
	b=GWsG4oQTQ9O1mxJjBVx+z/7GC73jTqeXrLYJ8/7v7g8c+6OLdkupQImgIc2UIqWb/f9mJJ
	j9/omqwqpyI5L0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6369D13675;
	Sat,  8 Nov 2025 07:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2z8EF2v3DmmRcgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 08 Nov 2025 07:55:23 +0000
Date: Sat, 08 Nov 2025 08:55:23 +0100
Message-ID: <878qghq7pw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: wangdich9700@163.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: Re: [PATCH v2] ALSA: au88x0: Fix array bounds warning in EQ drivers
In-Reply-To: <20251107024525.38454-1-wangdich9700@163.com>
References: <20251107024525.38454-1-wangdich9700@163.com>
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
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,intel.com,vger.kernel.org,lists.infradead.org,kylinos.cn];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Fri, 07 Nov 2025 03:45:25 +0100,
wangdich9700@163.com wrote:
> 
> From: wangdicheng <wangdicheng@kylinos.cn>
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
> ---
> 
> v1->v2:
> -Align both From and Signed-off-by addresses

Applied to for-next branch now.  Thanks.


Takashi

