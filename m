Return-Path: <linux-kernel+bounces-894738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A92C4BBA2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC8BC4E936B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDDA342C88;
	Tue, 11 Nov 2025 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HqOt32LO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PJnA96WJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HqOt32LO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PJnA96WJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368624A06B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843599; cv=none; b=eds5nrEhIwJLtcyAQ9YMLlA7gmRT+kQUS0J6FxE5GMKzACJpalBddKBU5ebmAXcbEOFML92DUeQAAxt5tanCv13wg+vA+KWbXs0A2b8uzTYc8ppxGb1EyfjtmoMrH12xD+tOSJuCxZrTKiG3i4iqdbXqzZvMXzBAojOJ7HaoyVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843599; c=relaxed/simple;
	bh=n6pmlxFtQsXL6Xf1TdQoBc0m0f4wqOCmg/7N3tSqacQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBFvZWaXifXU3dtC19NT3ne6w8qvQOizmhwYFTxckKVPLfrIC39r+kLCSHjFHOETer3IsMeZhPkqO+EWPw1FD2QohRnLeYB4i7kfueY/LNNEBzOhx2Nl1YbfgigZWG7v1BNhHe3phfGDDUtYqKi/vq1Jyf1YuHNqIagFIzxJf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HqOt32LO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PJnA96WJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HqOt32LO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PJnA96WJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42F1F21E2D;
	Tue, 11 Nov 2025 06:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762843596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oC01Lpz3QexT1AG0BuU7w7xpQwTU6MGL/YqYE0NL5XM=;
	b=HqOt32LOv/yzjcT/EmJqsmXIGMLazgJe2YrkWPI5LiMvh9yPWXf6xpSzt8KvhsUCCCfpBi
	yJcndp2+q6qw6ZitbLZLGwxhYv+Ldp0+MXIGyAZ6PlJ4NUeYRQLeEM/Zsecpzdyg9/MdBN
	feUWTe8JljZJiM/Zh21Py5VHeToaBnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762843596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oC01Lpz3QexT1AG0BuU7w7xpQwTU6MGL/YqYE0NL5XM=;
	b=PJnA96WJD6AXPwK5y0dtIavRgbsLq0keljeZ0MnWgv58v03WjMiN5MrONbKbmP2YoLFB30
	onkAHjbRp0LduSAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762843596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oC01Lpz3QexT1AG0BuU7w7xpQwTU6MGL/YqYE0NL5XM=;
	b=HqOt32LOv/yzjcT/EmJqsmXIGMLazgJe2YrkWPI5LiMvh9yPWXf6xpSzt8KvhsUCCCfpBi
	yJcndp2+q6qw6ZitbLZLGwxhYv+Ldp0+MXIGyAZ6PlJ4NUeYRQLeEM/Zsecpzdyg9/MdBN
	feUWTe8JljZJiM/Zh21Py5VHeToaBnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762843596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oC01Lpz3QexT1AG0BuU7w7xpQwTU6MGL/YqYE0NL5XM=;
	b=PJnA96WJD6AXPwK5y0dtIavRgbsLq0keljeZ0MnWgv58v03WjMiN5MrONbKbmP2YoLFB30
	onkAHjbRp0LduSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E5B914807;
	Tue, 11 Nov 2025 06:46:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YVgoBszbEmlHTgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 11 Nov 2025 06:46:36 +0000
Date: Tue, 11 Nov 2025 07:46:35 +0100
Message-ID: <87ikfh2his.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cristian Verde <verde.cristian2005@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: UB Sanitizer issue on wake-up from suspend (sound related)
In-Reply-To: <CAAAWurc_M9YKWmBAiXKe0gBF5Gfq2qksCU2heRv1BVhL+xfUow@mail.gmail.com>
References: <CAAAWurc_M9YKWmBAiXKe0gBF5Gfq2qksCU2heRv1BVhL+xfUow@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.20 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	INTRODUCTION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: 0.20

On Mon, 10 Nov 2025 20:46:00 +0100,
Cristian Verde wrote:
> 
> 
> Good evening (in my country),
> 
> My name is Cristian Verde and this is my first bug report, so I'm sorry for
> the crudity.
> 
> [ 6173.298248] UBSAN: invalid-load in /build/linux-PxlDdq/linux-6.16.8/sound/
> core/pcm_native.c:636:46
> [ 6173.298255] load of value 162 is not a valid value for type '_Bool'
> [ 6173.298281] nvidia 0000:01:00.0: PM: pci_pm_suspend(): nv_pmops_suspend
> [nvidia] returns -5
> [ 6173.298660] nvidia 0000:01:00.0: PM: dpm_run_callback(): pci_pm_suspend
> returns -5
> [ 6173.298673] nvidia 0000:01:00.0: PM: failed to suspend async: error -5
> [ 6173.341921] PM: Some devices failed to suspend, or early wake event
> detected
> [ 6173.818931] nvidia 0000:01:00.0: PM: pci_pm_suspend(): nv_pmops_suspend
> [nvidia] returns -5
> [ 6173.818991] nvidia 0000:01:00.0: PM: dpm_run_callback(): pci_pm_suspend
> returns -5
> [ 6173.819003] nvidia 0000:01:00.0: PM: failed to suspend async: error -5
> [ 6173.857619] PM: Some devices failed to suspend, or early wake event
> detected
> 
> Also found this Reddit post
> 
> I reported it already to Pop_OS maintainers, since I don't know where the
> problem is (the Pop_OS 22.04 that I'm using has Linux 6.16.8, as can be seen
> above, so a bit of an older version)
> 
> The issue might be related to why the volume slider doesn't work (since it's
> sound related)? Only happens on the laptop's speakers
> (LENOVO_MT_82Y7_BU_idea_FM_Yoga Pro 7 14IRH8), not any other audio devices.
> 
> If it helps, I had the same issue when I ran Ubuntu 22.04, and didn't have it
> on another machine (some ASUS).
> 
> I can provide other details, and please let me know if I should use
> other communication channels, thank you very much!
> 
> Best regards,
> Cristian Verde

This must be a bug rather in Nvidia download driver.  It means a wrong
value is stored in substream->runtime->stop_operating field which
should have been a boolean.


Takashi

