Return-Path: <linux-kernel+bounces-844221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1CDBC153C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4E43C7479
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812202DC789;
	Tue,  7 Oct 2025 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eDZ6jDGQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XLvFVF4k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eDZ6jDGQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XLvFVF4k"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D762DC32A
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839300; cv=none; b=C+H+Us7qwiwB2QjzA4renUUt1OeOuaj6/eae85z9GS41WhpafbbHUi3F3D/wa7PfukpjNYTx4dyfhrJscDq0DppQzJavimdDcZIjXPEXbUys71kyC3gSmPFR/SmGmxSi787A5KrQCY6AQexWpdM/EzwKXQc0H0UGMsP7qJza8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839300; c=relaxed/simple;
	bh=N0esEhr5i1anNCwzj+5Cy///h9Tv8LW3qTL42UltI3A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIiXWtuCo5A32TXK9XXS/2cmZ8+ousFx5I1WtNOMKVQI3J9HrCM65+dCRS93Hdr8PUOi31g6yapiUhOFZsIlT/1CBQGMuijwzl8PxptWhZagTmZgpbHZw099tPEQu00ZE6JSLSLVh0YpTy+WS+CCVuGSd8WywbgRZ8FqhAsD9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eDZ6jDGQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XLvFVF4k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eDZ6jDGQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XLvFVF4k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D6531F44F;
	Tue,  7 Oct 2025 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759839297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mne8hDbWTu6yFK2C2TGQLRe9x25YVlXtjppmdhHOcIQ=;
	b=eDZ6jDGQ/eWwGZU0mIQuAJ2Z4PbK1xOQxfkZQCSBcWulCNpbjIqDWncI3ihgG0uFvz/dzv
	JjUuKRTPGmEbv9OIPSr+9EmHARvSg5W8NrUIFE9nZvpcnfwBC92uc7BJMbI92etYZ1YBcZ
	ylmS6RiEzAk0XD4GTYnCpOrftQZE9m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759839297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mne8hDbWTu6yFK2C2TGQLRe9x25YVlXtjppmdhHOcIQ=;
	b=XLvFVF4kQLiXzZ3B6YCd3UzEPC4WnI052B4j3V4BVFhqqYqhgKqV9rtc3NanmM+pDOwdR4
	2oUDU6DohuUZZZAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eDZ6jDGQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XLvFVF4k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759839297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mne8hDbWTu6yFK2C2TGQLRe9x25YVlXtjppmdhHOcIQ=;
	b=eDZ6jDGQ/eWwGZU0mIQuAJ2Z4PbK1xOQxfkZQCSBcWulCNpbjIqDWncI3ihgG0uFvz/dzv
	JjUuKRTPGmEbv9OIPSr+9EmHARvSg5W8NrUIFE9nZvpcnfwBC92uc7BJMbI92etYZ1YBcZ
	ylmS6RiEzAk0XD4GTYnCpOrftQZE9m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759839297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mne8hDbWTu6yFK2C2TGQLRe9x25YVlXtjppmdhHOcIQ=;
	b=XLvFVF4kQLiXzZ3B6YCd3UzEPC4WnI052B4j3V4BVFhqqYqhgKqV9rtc3NanmM+pDOwdR4
	2oUDU6DohuUZZZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 550A213AAC;
	Tue,  7 Oct 2025 12:14:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TSMyFEEE5WhaCQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 07 Oct 2025 12:14:57 +0000
Date: Tue, 07 Oct 2025 14:14:57 +0200
Message-ID: <87a522ewn2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: "Geoffrey D . Bennett" <g@b4.vu>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb: fpc: replace kmalloc_array followed by copy_from_user with memdup_array_user
In-Reply-To: <20251007120057.21918-1-pedrodemargomes@gmail.com>
References: <20251007120057.21918-1-pedrodemargomes@gmail.com>
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
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 6D6531F44F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Tue, 07 Oct 2025 14:00:57 +0200,
Pedro Demarchi Gomes wrote:
> 
> Replace kmalloc_array() followed by copy_from_user() with
> memdup_array_user() to improve and simplify fcp_ioctl_set_meter_map().
> 
> No functional changes intended.
> 
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>

Applied now.  Thanks.


Takashi

