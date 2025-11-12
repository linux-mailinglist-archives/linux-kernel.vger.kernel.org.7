Return-Path: <linux-kernel+bounces-896862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3760CC516CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2485E3BFCAF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43C301006;
	Wed, 12 Nov 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RH4HSRqa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aI61nmiI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oTX2P9Qd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EqV1YYGk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4AA3009D8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940027; cv=none; b=T2mxEevxDqHivo5VfFooYERNKIB1YMMCprjF4HFylQzXozlk63wrASwUzTi1VkA1y8Ne2phCE51S0/6Wg0fGcLSf5G34r82BfjurZ3voU4jxV1qS/SmSvwdVxVAWBDkiETWArXNJBKi4pCq/HkroqcoS4cNyGaOlwY+giBErXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940027; c=relaxed/simple;
	bh=cQiEeJr3LIq6Vx826saSZDq6N16zIj+ovDauzOQGDOI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7f2owwBnmoWF53tD4r90xbLoLRY9Of3Q9LDcNs9r5ZPUGk7tW8QaTgWvmW6hr+PensfQBv8yz9weD9IG7q27CbIO6qkmBdod6+ByrQyHYWDOyoO3P0t7RRjmQLa6jq3uU1HN8h0T4w8oBm6CmSQxpX0Z1RbrgaTGK40b6klxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RH4HSRqa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aI61nmiI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oTX2P9Qd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EqV1YYGk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CFC9C1F7E5;
	Wed, 12 Nov 2025 09:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762940023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TJgYQEP9OZUCYA0ies5nLsCFigdTCsKBXD315BujuZs=;
	b=RH4HSRqa9w7oqZxuAhHrpchKneJY+MQyEEfkvICiRo2dXvYVngzHouYD8q3YxxXtzTUOCz
	8eQB2adXi7U9CvYvcGoIS8W6P1ANtu7txmZ+6rfo32Qwvrq0JNML5VhhZgqOZd2HG7VPvD
	dYBbiNj0UyJvAChx183KOrCdZXBnshk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762940023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TJgYQEP9OZUCYA0ies5nLsCFigdTCsKBXD315BujuZs=;
	b=aI61nmiIFJx+HyrnWsLLMRVJSCG4UA20voFosMDU+NrzzTNMhwNeyqJE/vivTx1pkgvAF2
	7MGLUW7X+MxjegAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oTX2P9Qd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EqV1YYGk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762940022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TJgYQEP9OZUCYA0ies5nLsCFigdTCsKBXD315BujuZs=;
	b=oTX2P9QdXdQtymeJU2SGqi1Pitje9hiWdqE30on4dmqFPHFdICcPWnDWGdGbWz4Pn+stzK
	lh9gIJKVv+IwRluR9s0KcJLmyetelsSEJKgdIbR0yo6vMfQ78JNek03HKOFrbtdCw1vNld
	S6nxfFAZmxIvz0Ph8frso7id9NoIpPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762940022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TJgYQEP9OZUCYA0ies5nLsCFigdTCsKBXD315BujuZs=;
	b=EqV1YYGkehtPJEGJUf3pS4Mm4DZAVbSMyUqGX4+gSkhRv/zP2iTWpm645HqcsMqf3xrWnb
	bd8Gp8w+IOiz7wAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63B933EA61;
	Wed, 12 Nov 2025 09:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aikpF3ZUFGklBgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 12 Nov 2025 09:33:42 +0000
Date: Wed, 12 Nov 2025 10:33:41 +0100
Message-ID: <87zf8rioi2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: <tiwai@suse.de>,
	<robh+dt@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<shenghao-ding@ti.com>,
	<navada@ti.com>,
	<13916275206@139.com>,
	<v-hampiholi@ti.com>,
	<v-po@ti.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<yung-chuan.liao@linux.intel.com>,
	<broonie@kernel.org>,
	<antheas.dk@gmail.com>,
	<stuart.a.hayhurst@gmail.com>,
	<dan.carpenter@linaro.org>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Correct the wrong project ID
In-Reply-To: <20251112092609.15865-1-baojun.xu@ti.com>
References: <20251112092609.15865-1-baojun.xu@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: CFC9C1F7E5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,linux.intel.com,gmail.com,perex.cz,ti.com,139.com,vger.kernel.org,intel.com,linaro.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 

On Wed, 12 Nov 2025 10:26:09 +0100,
Baojun Xu wrote:
> 
> The project hardware ID should be ALC287_FIXUP_TXNW2781_I2C,
> not ALC287_FIXUP_TAS2781_I2C for HP Lampass projects.
> 
> Fixes: 7a39c723b747 ("ALSA: hda/tas2781: Add new quirk for HP new projects")
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>

Thanks, applied now.


Takashi

