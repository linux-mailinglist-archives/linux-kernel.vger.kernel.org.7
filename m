Return-Path: <linux-kernel+bounces-816236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B13B57162
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2137179806
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199272D5925;
	Mon, 15 Sep 2025 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wadm5Atn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AScTcPFQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wadm5Atn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AScTcPFQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5D12652A4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921175; cv=none; b=guUqzkD5LZg/U9iVh12wiAye1wJBudO4JNSpaYsWd15Q9smYpCb2Jvv15BsqT2DBLkKxVgmSB0J1xQWAsJOt41NvCuU17WyhGEBv3iiPZekSWmFpyhJrb8sJNl04YfwRh/NvQdDB9m8nbs0rvBS5gG7PHc+JRoziCSmUNFEIB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921175; c=relaxed/simple;
	bh=kw2dhhmgpxr8qvGpYt8/zyom2R+dyfpAfG10VZ7S3Z0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fV5+q5KwlvlzSpVPcMhdhTUM8qMaEY6+HmdlW1iMLRcYeyb5FUq4rc1utsgAl3RodJgEXoQm5bdYeONEvwRIZ1jSAMyt97iok9ykXkl0S4KcVXR++ldnGh7Sfb1d4HA24bT19hxLczAkZskGt5TJlJphPEIgtO0eyRVRXVUwX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wadm5Atn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AScTcPFQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wadm5Atn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AScTcPFQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A4B722133;
	Mon, 15 Sep 2025 07:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757921172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2flWNyQyomKjwJxhJ1eA1NPf+ztzz2Vbkgwkb999PS0=;
	b=wadm5AtnJlVkL2gkoaBgZBE2ez3uujVOvV/zCWT+39lpDhwhWxtIl62GaswY1RR45QMnx7
	BCzAXl+mst0DjeDD8KS7LFsuzFV7lFpa6LdrlhSlwRxa1Q54Jt5/KeslQmUx05HPoDQmw7
	YFyHPCcB8zKAg447TV72JgXn3kPmcdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757921172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2flWNyQyomKjwJxhJ1eA1NPf+ztzz2Vbkgwkb999PS0=;
	b=AScTcPFQNdVGy4Zxqcx4w7P4uaYyl3CFHPZTu6qvAF+9lzmB9BTN3/XB9q1IyWBTH0qjzG
	AIdwSNs/mrPPwDCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757921172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2flWNyQyomKjwJxhJ1eA1NPf+ztzz2Vbkgwkb999PS0=;
	b=wadm5AtnJlVkL2gkoaBgZBE2ez3uujVOvV/zCWT+39lpDhwhWxtIl62GaswY1RR45QMnx7
	BCzAXl+mst0DjeDD8KS7LFsuzFV7lFpa6LdrlhSlwRxa1Q54Jt5/KeslQmUx05HPoDQmw7
	YFyHPCcB8zKAg447TV72JgXn3kPmcdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757921172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2flWNyQyomKjwJxhJ1eA1NPf+ztzz2Vbkgwkb999PS0=;
	b=AScTcPFQNdVGy4Zxqcx4w7P4uaYyl3CFHPZTu6qvAF+9lzmB9BTN3/XB9q1IyWBTH0qjzG
	AIdwSNs/mrPPwDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D9071372E;
	Mon, 15 Sep 2025 07:26:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m5a1DZS/x2hwUgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 15 Sep 2025 07:26:12 +0000
Date: Mon, 15 Sep 2025 09:26:11 +0200
Message-ID: <87bjncp46k.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: asihpi: Simplify error handling in PCM substream setup
In-Reply-To: <20250914205945.214179-1-jihed.chaibi.dev@gmail.com>
References: <20250914205945.214179-1-jihed.chaibi.dev@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Sun, 14 Sep 2025 22:59:45 +0200,
Jihed Chaibi wrote:
> 
> Refactor error handling in the PCM substream setup to combine redundant
> checks and improve code readability. Free the dpcm structure and return
> appropriate error codes (-EBUSY for HPI_ERROR_OBJ_ALREADY_OPEN, -EIO
> for other errors) in a single block.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

Thanks, applied now.


Takashi

