Return-Path: <linux-kernel+bounces-891847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC77C43A54
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 09:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E193AF674
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5C92C158F;
	Sun,  9 Nov 2025 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U5ltba2B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Te6q1neV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U5ltba2B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Te6q1neV"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC8B13777E
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762678425; cv=none; b=PqbJ338O3Y8ccSSuLJfcWVdE59Z9DNz2LKriv/1dlr3WEBylMb0/ScxRKEfEWjz2jpWASOS2GA8576Ljbe4sK1jLfXzuATFVpBJvMZ073FneaJRpqfzZtnR0jUCl8zVK/Cf0vWIrfE/H3ZgEQEM1lOO11JRbnyZmoA0wx74TGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762678425; c=relaxed/simple;
	bh=cc2m5zEns14fW1bXoEQEFY4A2843Vewb3K617tyG42o=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzJQ/okxnp7Sp8m5NT9rIf3g77+NLGz3b8CXKbvSfOcFiC760BILF6ZVdmGqGWJebiYk4qpdRYXnhyjLGOPEvdtapNulOSVlRJEOvySIkg551lTJXB6PDf9N2uD938tF4L7LousYhCa7crxqkbEN9KJrkYRV+48pQMGuGda/EAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U5ltba2B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Te6q1neV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U5ltba2B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Te6q1neV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63EAE336FC;
	Sun,  9 Nov 2025 08:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762678421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YT0pipkfam0oEP71ixaTUjOYmnwa3zw5pb/NTg1ne2g=;
	b=U5ltba2BKJD01qOoXzl0llh7VEw2W2EkPegRQqMntQFITAs6Ne/783cqH6NaXw7a7QENPv
	XkJtC8YiLoBQeEaLeYCFMLe8i42aiaKz/9RnHin1CBSXJ2YwZVz6Xa0H4KZdqptP+5855r
	PaYyIK5vmaH/OGU0ah6oJtZK6Zqtu9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762678421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YT0pipkfam0oEP71ixaTUjOYmnwa3zw5pb/NTg1ne2g=;
	b=Te6q1neVqWbrJ2mGx5qIbK38sqFfjmECG5P4dDAzUWoAmolvmlrtVgFGo6u7XX+uBlsuw1
	e47x39WmrHpmTiCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=U5ltba2B;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Te6q1neV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762678421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YT0pipkfam0oEP71ixaTUjOYmnwa3zw5pb/NTg1ne2g=;
	b=U5ltba2BKJD01qOoXzl0llh7VEw2W2EkPegRQqMntQFITAs6Ne/783cqH6NaXw7a7QENPv
	XkJtC8YiLoBQeEaLeYCFMLe8i42aiaKz/9RnHin1CBSXJ2YwZVz6Xa0H4KZdqptP+5855r
	PaYyIK5vmaH/OGU0ah6oJtZK6Zqtu9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762678421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YT0pipkfam0oEP71ixaTUjOYmnwa3zw5pb/NTg1ne2g=;
	b=Te6q1neVqWbrJ2mGx5qIbK38sqFfjmECG5P4dDAzUWoAmolvmlrtVgFGo6u7XX+uBlsuw1
	e47x39WmrHpmTiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEB2A13E42;
	Sun,  9 Nov 2025 08:53:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qXfVNJRWEGkqMQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 09 Nov 2025 08:53:40 +0000
Date: Sun, 09 Nov 2025 09:53:40 +0100
Message-ID: <87tsz3pox7.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Add new quirk for HP new projects
In-Reply-To: <20251108142325.2563-1-baojun.xu@ti.com>
References: <20251108142325.2563-1-baojun.xu@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 63EAE336FC
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,linux.intel.com,gmail.com,perex.cz,ti.com,139.com,vger.kernel.org,intel.com,linaro.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 

On Sat, 08 Nov 2025 15:23:25 +0100,
Baojun Xu wrote:
> 
> Add new vendor_id and subsystem_id in quirk for HP new projects.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>

Applied now.  Thanks.


Takashi

