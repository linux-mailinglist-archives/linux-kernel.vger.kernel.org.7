Return-Path: <linux-kernel+bounces-849023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA952BCF074
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF630189E46D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687F221323C;
	Sat, 11 Oct 2025 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1C/hv9i8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X1xGpkx6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1C/hv9i8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X1xGpkx6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B7D1A7AE3
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760164259; cv=none; b=gEyJ3mzvRcKrlWrqwSozF5FOfAwS8PDECwcs73a+YUwpfsRqX+9UpjdFg5QVJmloXXbPi7RipR0wQJKasakmvjoPuAWQ8uvbkWQKPDDjgTGZaCa8KSLrnTpb4rEyxfPnY2B56t+fWMPSJ/+ClllbEDKUZg8JVfcjsTmtWBz/AA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760164259; c=relaxed/simple;
	bh=nr8Gno41C/RwsIKygs23NjoPH55WyPiyut7Kp+/xflU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5AcDuYKagi2yke97C6gGYpWg+RqAq213ZTkvyaSk7MoVxOP0AW1ca60PXm0LtzzkEys+2JWUs22nRcO6JAMPbuZ6bSe3+3x45xg8/YVmeMXCEDDRzMWloydd87XvL5cGXU3W4vHNcFpB9uZ28lcelGOdy88JkAeG/7SAPh9E2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1C/hv9i8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X1xGpkx6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1C/hv9i8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X1xGpkx6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77B9321241;
	Sat, 11 Oct 2025 06:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760164256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81GMM0LlaVH90KSmrW/v69Xx/0g3hMVcC8Zl05NII6w=;
	b=1C/hv9i86//uoAxjcdUeY89duLpbUhESRSPQxyc35QXQDq5Fbu/5GJFwGt+q7WtcxjHPBD
	9W8WKQ1eU5/oB5uuIcmiu96F9skTDdzvZI2m+jo+D/SFDMMBBqtlINpTZT7H5cergTcpyE
	iFOEFF6jVO1bkgdHOsM7k5EhuhzR79Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760164256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81GMM0LlaVH90KSmrW/v69Xx/0g3hMVcC8Zl05NII6w=;
	b=X1xGpkx6N8ktxle623bs1KP/byzmd3FWkxnnR3fqOBvy66Cb1EH+1iNL122ehTktOzekme
	GwMz2ww/IjMrieDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760164256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81GMM0LlaVH90KSmrW/v69Xx/0g3hMVcC8Zl05NII6w=;
	b=1C/hv9i86//uoAxjcdUeY89duLpbUhESRSPQxyc35QXQDq5Fbu/5GJFwGt+q7WtcxjHPBD
	9W8WKQ1eU5/oB5uuIcmiu96F9skTDdzvZI2m+jo+D/SFDMMBBqtlINpTZT7H5cergTcpyE
	iFOEFF6jVO1bkgdHOsM7k5EhuhzR79Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760164256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81GMM0LlaVH90KSmrW/v69Xx/0g3hMVcC8Zl05NII6w=;
	b=X1xGpkx6N8ktxle623bs1KP/byzmd3FWkxnnR3fqOBvy66Cb1EH+1iNL122ehTktOzekme
	GwMz2ww/IjMrieDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 467A813693;
	Sat, 11 Oct 2025 06:30:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s/LLD6D56WifDgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 11 Oct 2025 06:30:56 +0000
Date: Sat, 11 Oct 2025 08:30:55 +0200
Message-ID: <87jz129cgw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Cc: linux-sound@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/intel: Add MSI X870E Tomahawk to denylist
In-Reply-To: <20251010233026.5207-2-stuart.a.hayhurst@gmail.com>
References: <20251010233026.5207-2-stuart.a.hayhurst@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 

On Sat, 11 Oct 2025 01:28:29 +0200,
Stuart Hayhurst wrote:
> 
> This motherboard uses USB audio instead, causing this driver to complain
> about "no codecs found!".
> Add it to the denylist to silence the warning.
> 
> Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>

Applied now.  Thanks.


Takashi

