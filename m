Return-Path: <linux-kernel+bounces-736855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0F9B0A430
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A88189721F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4AB2D979E;
	Fri, 18 Jul 2025 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l5MTkyHz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vHUQ1FCT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l5MTkyHz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vHUQ1FCT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68F246761
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752841581; cv=none; b=aDZfuuVhIEJsz/NqIOB3szV4bCpS/T1flECzhJYhhutzoavCwBgRmTsxsEDGBYl2XxgXBfI0zgjMVjZfIaWI0qkO3cj+/YCUqGSWHaB9KmutizSl7I1fPZ1A49LDoSWMzmhvpB+J7TcTm1Ygz42xH3c89YModoy+gSccWQT568o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752841581; c=relaxed/simple;
	bh=YLn6T50KiE45tD6SvH/SyM++ZqJcGh7d7SQC7KFT0Sk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFYBxgEPpeO74oeBXYwh9WXHC8+RLv9gmYZXqvANydQUUxZXD7oqDAexWzKXSxPdniOSVAXF4ZonNd8kWDqpTYQCJUHHuiGMHL+ichFIMgVaaAxE8LV8AE2lrCXzTqQPAV5MevT+mvfIDYTr63d3DK7xZOdh0641CEcMLXqWogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l5MTkyHz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vHUQ1FCT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l5MTkyHz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vHUQ1FCT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6DFE721195;
	Fri, 18 Jul 2025 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752841578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVU9IqAsOg6Uq7TzXhNz3Dmp4GgffUcuOtJokXy/GM4=;
	b=l5MTkyHzbzdKn8xky2D6mY8mU67ur/68aWYiiZaUFb5ciH6NjXO3LlqdGurq+xaaCXis4e
	nw6M58AN4wpIfmxoSgnEqHPkkPbjznVKH+tYb7AYO6+PYJ+UGH3TlM6XG1UWu1Zb5gV+sW
	6gMdBBN72jc0rzkU2tj07sUG0dun4HY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752841578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVU9IqAsOg6Uq7TzXhNz3Dmp4GgffUcuOtJokXy/GM4=;
	b=vHUQ1FCTu5wAjpgDOt5ZU5LslkI8I/vKbonJFc56CAWy2DnpoPYxowZGo9CFEs8LsccBkc
	h1jir+vjF2wobIDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l5MTkyHz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vHUQ1FCT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752841578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVU9IqAsOg6Uq7TzXhNz3Dmp4GgffUcuOtJokXy/GM4=;
	b=l5MTkyHzbzdKn8xky2D6mY8mU67ur/68aWYiiZaUFb5ciH6NjXO3LlqdGurq+xaaCXis4e
	nw6M58AN4wpIfmxoSgnEqHPkkPbjznVKH+tYb7AYO6+PYJ+UGH3TlM6XG1UWu1Zb5gV+sW
	6gMdBBN72jc0rzkU2tj07sUG0dun4HY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752841578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVU9IqAsOg6Uq7TzXhNz3Dmp4GgffUcuOtJokXy/GM4=;
	b=vHUQ1FCTu5wAjpgDOt5ZU5LslkI8I/vKbonJFc56CAWy2DnpoPYxowZGo9CFEs8LsccBkc
	h1jir+vjF2wobIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4285113A52;
	Fri, 18 Jul 2025 12:26:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qgXuDmo9emgUEgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 18 Jul 2025 12:26:18 +0000
Date: Fri, 18 Jul 2025 14:26:17 +0200
Message-ID: <87pldx7kie.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: usb: qcom: Adjust mutex unlock order
In-Reply-To: <20250718070309.441282-1-karanja99erick@gmail.com>
References: <20250718070309.441282-1-karanja99erick@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 6DFE721195
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Fri, 18 Jul 2025 09:03:08 +0200,
Erick Karanja wrote:
> 
> The mutexes qdev_mutex and chip->mutex are acquired in that order
> throughout the driver. To preserve proper lock hierarchy and avoid
> potential deadlocks, they must be released in the reverse
> order of acquisition.
> 
> This change reorders the unlock sequence to first release chip->mutex
> followed by qdev_mutex, ensuring consistency with the locking pattern.
> 
> Fixes: e2710ea98124 ("staging: sound: Adjust mutex unlock order")

This commit ID doesn't exist, and the commit summary doesn't sound
right.  You need to put the commit to be fixed with the commit summary
of that commit instead of your own.

Please resubmit with the proper Fixes tag.


thanks,

Takashi

