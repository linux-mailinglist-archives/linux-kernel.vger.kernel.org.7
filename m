Return-Path: <linux-kernel+bounces-798316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ED7B41C38
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E429E1A860D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20312F291A;
	Wed,  3 Sep 2025 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FxxVHlrK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R+CWmoV/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i6wy4Yi7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7c7skgWG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF82D7DDE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896711; cv=none; b=M6YAa2nTkQrrPyTPMFc3twop1wmmr6XMgtU7kHYPGGaLNSBbog6LkkQ+KX/dg+e2lmo8y1CJ8vnODcCIyavjKxwT2ioLHCN0j9xSxr36AP5IFpjwxpDXNEzoeysXt41EFSxUJ92E5bbS1VpuaKKhWQhvsfpAor0mDQOkBFtw4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896711; c=relaxed/simple;
	bh=aDu2IoAqXsCBkkLAkO2BkPoEt6t3Dl/DmFS2ucwu09Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOrQlCfvGvak+JfsAOyAY9l8ygOy/w4nEITMxeT4mIekxt5tnN9NbdJZdn9yxhttBgmRaCHII/f7WcwHgw3EmGZfhyPMLu5P7VtE4LOh8/w9yUzwOZWciwXbQOWI/nr+4w/C6/iHAjILMo/9hHmLM1J45yFTt7VjYKf7SNLKupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FxxVHlrK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R+CWmoV/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i6wy4Yi7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7c7skgWG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 270511F456;
	Wed,  3 Sep 2025 10:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756896707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYrV8AjA+LCz9LdUSb4XPBwf7Xj00OMvE/sE0GVZ9fA=;
	b=FxxVHlrKBmogHQG3VJD+VIjwMx+qn26GDpqXzZPprHPwHoBPrkzbsJcusyh1Q2GM+k3i56
	g4/bpPDOZ+hh+KECmt8Buz3Rz0oHAq7ldE4/GRjRaU5mWP1O+Kdg5yuyY1UDpHuBtxL8iS
	hRZNp7LXq3Q1x4Xy3bxhr02lvz3o23Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756896707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYrV8AjA+LCz9LdUSb4XPBwf7Xj00OMvE/sE0GVZ9fA=;
	b=R+CWmoV/UeUxHx41gCQl7AkS9ELil8fsg8OGSoIBbC4zlMlPVWLc/axFoqL6JkRXunU0hN
	nVSPtJCa/x0lsbDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i6wy4Yi7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7c7skgWG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756896706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYrV8AjA+LCz9LdUSb4XPBwf7Xj00OMvE/sE0GVZ9fA=;
	b=i6wy4Yi7rLehZjMFYvEkZxOkN8ohhJtMFLTw3q3Rt3H5kXvnxM9EE4+HfiAs5zCy+9W2Uq
	PL1oDrBB+t+NtzRcpR++Vs/vGbQgshck7ftae5y1M9dO644JxzM64FSDa6bujZJZmjkJUI
	NERQ4plxj/5JQW1II5H4Otrmly2KgPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756896706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYrV8AjA+LCz9LdUSb4XPBwf7Xj00OMvE/sE0GVZ9fA=;
	b=7c7skgWGloQl/dCJEIjdnhKqqaGPAkyM5lyraFrQWMBWWw7i5j/bIrCZlSFNhDbOyt81Yg
	FsU4n4vgcakZ40Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFAA913888;
	Wed,  3 Sep 2025 10:51:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pXslLcEduGjrDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 03 Sep 2025 10:51:45 +0000
Date: Wed, 03 Sep 2025 12:51:45 +0200
Message-ID: <87seh3vmf2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jaroslav Kysela <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Vasiliy
 Kovalev <kovalev@altlinux.org>,	John Veness <john-linux@pelago.org.uk>,	bo
 liu <bo.liu@senarytech.com>,	Jackie Dong <xy-jackie@139.com>,	Takashi Iwai
 <tiwai@suse.de>,	Richard Fitzgerald <rf@opensource.cirrus.com>,	Oldherl Oh
 <me@oldherl.one>,	=?ISO-8859-2?Q?Jaros=B3aw?= Janik
 <jaroslaw.janik@gmail.com>,	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/conexant: Fix typos in comments
In-Reply-To: <20250902154858.86102-2-thorsten.blum@linux.dev>
References: <20250902154858.86102-2-thorsten.blum@linux.dev>
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
X-Rspamd-Queue-Id: 270511F456
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,altlinux.org,pelago.org.uk,senarytech.com,139.com,suse.de,opensource.cirrus.com,oldherl.one,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.01

On Tue, 02 Sep 2025 17:48:41 +0200,
Thorsten Blum wrote:
> 
> s/OPLC/OLPC/
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied now.  Thanks.


Takashi

