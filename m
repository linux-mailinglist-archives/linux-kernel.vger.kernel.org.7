Return-Path: <linux-kernel+bounces-877604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DC7C1E8F2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7983AF00C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5A92F7AA1;
	Thu, 30 Oct 2025 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mWZVzjf/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J8agQIQP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mWZVzjf/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J8agQIQP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4375F2EC555
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761805639; cv=none; b=JEKlXi6SYucTbPkC9HZ6+2N/jOyyukwyvRVxPOIL8wIFQUzg5/5Cf3110/9JlUYT8BGpF5CnhSCAkPnnLpXFZE4nQN4mgIcopPVbUVBl0SeSjjlP+AYwtiXJ6AVtQ/DH/M0zcL6HAXvdp9ZcC6vz6+sAvovUs8xlybBj/U/pfu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761805639; c=relaxed/simple;
	bh=xzdUhIOqirpm/E0sjloLaoAGmpDBjbR+GEN6VsncgF4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VO6Fg9/CU3ntN85C8sWoO1Upn5mWDqTGH57mKePaxQ8TrZU9qcJFjrVT46ZydA+cdk3U7EnEIBicB0U7IzSJM/EoCFZI1ahm3S19G6RXFSgY0I4EE42BjBlDQd+mPdSD0BZv+ernuZTPaySWcXLlsP/E/oZWOwB7eblC+1gcU+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mWZVzjf/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J8agQIQP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mWZVzjf/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J8agQIQP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 673651F79D;
	Thu, 30 Oct 2025 06:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761805635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekN0M4ZsiNEZDhioT+YAy/2Ebin5suoZuw/IzZBktRs=;
	b=mWZVzjf/jFRTZMHmi3y68YMElYlvt7D+ozZ1EU3o4HYrBcQ5tJUipAvLx+aVQFeXM8JLlr
	ZR4YqcMzjFf4n9ZaYaBrzphSWCsSEKMkGowDw21a4AzGiKoY3oVtjJbF7S68hinTOITxtg
	AGL1ZRS30CC0RDA8oaz5ibTKyTlRsSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761805635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekN0M4ZsiNEZDhioT+YAy/2Ebin5suoZuw/IzZBktRs=;
	b=J8agQIQPpH2kq1aH7fBu636ZaSTshKrNlFjytfFYH5fFCKdRhYKloIxsRefJEa3SKXw7uE
	4UFYvrwaZWvYX+CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761805635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekN0M4ZsiNEZDhioT+YAy/2Ebin5suoZuw/IzZBktRs=;
	b=mWZVzjf/jFRTZMHmi3y68YMElYlvt7D+ozZ1EU3o4HYrBcQ5tJUipAvLx+aVQFeXM8JLlr
	ZR4YqcMzjFf4n9ZaYaBrzphSWCsSEKMkGowDw21a4AzGiKoY3oVtjJbF7S68hinTOITxtg
	AGL1ZRS30CC0RDA8oaz5ibTKyTlRsSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761805635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekN0M4ZsiNEZDhioT+YAy/2Ebin5suoZuw/IzZBktRs=;
	b=J8agQIQPpH2kq1aH7fBu636ZaSTshKrNlFjytfFYH5fFCKdRhYKloIxsRefJEa3SKXw7uE
	4UFYvrwaZWvYX+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D45413393;
	Thu, 30 Oct 2025 06:27:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id crLSBUMFA2kAQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 30 Oct 2025 06:27:15 +0000
Date: Thu, 30 Oct 2025 07:27:14 +0100
Message-ID: <87a51852gt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	chris.chiu@canonical.com,
	edip@medip.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable mic on Vaio RPL
In-Reply-To: <20251029181152.389302-1-edson.drosdeck@gmail.com>
References: <20251029181152.389302-1-edson.drosdeck@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.79 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.19)[-0.949];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -1.79

On Wed, 29 Oct 2025 19:11:52 +0100,
Edson Juliano Drosdeck wrote:
> 
> Vaio RPL is equipped with ACL256, and needs a
> fix to make the internal mic and headphone mic to work.
> Also must to limits the internal microphone boost.
> 
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

Applied now.  Thanks.


Takashi

