Return-Path: <linux-kernel+bounces-730360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E42B1B0438F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CED7A9AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0D225393C;
	Mon, 14 Jul 2025 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kqr40trc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3AsW2JYO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kqr40trc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3AsW2JYO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D4D23D280
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506410; cv=none; b=USOQ7b/IYFzHY5ymQBfid8VZwwoKH8YceCYAtTbMXIfie9Uz5fGHEqZ/mAjOMn4GvLBBBR+3cF01LsXAIP/51TMxBkLfGoD3VPFTUjP697fMfMjVNfM2/kj4DnpkMXMHecIHfHP8GBKO4KoJ7wVi9TkKNN8bcvZTbDreDRdC5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506410; c=relaxed/simple;
	bh=4uskv1/C8crxo8BjvlRrS3Nwdrc5JlSjIY9z0sF5zTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQsqfgto1K5Qv36fWjwjQm3uDcnYtvoElfOzOk+hcDIVh9PbKVM1V/xRSGJZzqtZS8emnK7mQjWca8tdGL/HbNAzyTLIY0Grn4+1KqOMtmS/56njZhXlQwZoZgHbXJQXELrkqrl4yanuEv+0BB78WwyVdoIHBTMAOiB6Rtp3vU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kqr40trc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3AsW2JYO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kqr40trc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3AsW2JYO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 020EC21232;
	Mon, 14 Jul 2025 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752506407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q987H/VxKiyrEGdI9nCVn+7yH6coUcXmQYYsj0C/Xcs=;
	b=Kqr40trc2m7KrFTUH19vTVpdqbb8BJBOdnVdUp/foyqGoB/MjFIjLyEdRRs8IuyyYBvLF3
	70pRKBvXNEq6eLMrzCHgFQ/um71tptV6aPMXd4HmHp8WOE4mQpd+TmkKL8ZDHN+evHLvWe
	cAyrBEiSpjRQviHYMmgPiSFPK+AJ1bM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752506407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q987H/VxKiyrEGdI9nCVn+7yH6coUcXmQYYsj0C/Xcs=;
	b=3AsW2JYOLrUhftPKakkMRBcwSo0Z+rRRpI7NtAyf8OvnTkgPkaChY/hf76ByCeJRTHUTwB
	xXRFMJHDRnkcwrBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Kqr40trc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3AsW2JYO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752506407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q987H/VxKiyrEGdI9nCVn+7yH6coUcXmQYYsj0C/Xcs=;
	b=Kqr40trc2m7KrFTUH19vTVpdqbb8BJBOdnVdUp/foyqGoB/MjFIjLyEdRRs8IuyyYBvLF3
	70pRKBvXNEq6eLMrzCHgFQ/um71tptV6aPMXd4HmHp8WOE4mQpd+TmkKL8ZDHN+evHLvWe
	cAyrBEiSpjRQviHYMmgPiSFPK+AJ1bM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752506407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q987H/VxKiyrEGdI9nCVn+7yH6coUcXmQYYsj0C/Xcs=;
	b=3AsW2JYOLrUhftPKakkMRBcwSo0Z+rRRpI7NtAyf8OvnTkgPkaChY/hf76ByCeJRTHUTwB
	xXRFMJHDRnkcwrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D11B138A1;
	Mon, 14 Jul 2025 15:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iDIxCyYgdWhIMwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 14 Jul 2025 15:20:06 +0000
Date: Mon, 14 Jul 2025 16:20:00 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 1/5] mm/mseal: always define VM_SEALED
Message-ID: <z5zu4izugwicreygz2yehepozrwnzeljucg34mplcpfdirl6rb@5y75qntbiwiy>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <f6dd43a1111677145b815b31bca8a04db0862c53.1752497324.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6dd43a1111677145b815b31bca8a04db0862c53.1752497324.git.lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 020EC21232
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Mon, Jul 14, 2025 at 02:00:36PM +0100, Lorenzo Stoakes wrote:
> There is no reason to treat VM_SEALED in a special way, in each other case
> in which a VMA flag is unavailable due to configuration, we simply assign
> that flag to VM_NONE, make VM_SEALED consistent with all other VMA flags in
> this respect.
> 
> Additionally, use the next available bit for VM_SEALED, 42, rather than
> arbitrarily putting it at 63 and update the declaration to match all other
> VMA flags.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

