Return-Path: <linux-kernel+bounces-773254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7471AB29D52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368023ABE9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3947730DD37;
	Mon, 18 Aug 2025 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zbcSSq0s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rztUsYzt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zbcSSq0s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rztUsYzt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70830DD0E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508310; cv=none; b=VyApblGgGoiq0/rH7C/QC+k5I4t9E7LXYFf7zD4F2ySURmTmjVsEgqQVgGb15SdZYnmmaJ+DFYW1VsUl1Vpnv09curf8i0kvWgbXR/nbil8jyfro2cz5pIO9kyPraSQTrt4XbO3O2rtbT8Vz/BJ8PRtEiwDVM8Wy/6WC+jQYFUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508310; c=relaxed/simple;
	bh=f3/b24vi4WZUZhzGoyU68h/F9jJknT4PhA/ZhSGgCmA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tem3Ozj2eAfmgr+j5Ks1is8/znEbEOO9DVJZV3Job1slIQB6hMO5SxAM8ZjHVkNpNcfdgBOcf8bxSdiNArQ6jgp3VggCn3auoeSN5fzn0a1woEGq+90eUis2ALliXPRf+r/CGZCDpHHkeepkXp0pOSOEE4dNoYcm14AOuHv6N5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zbcSSq0s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rztUsYzt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zbcSSq0s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rztUsYzt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26A721F44E;
	Mon, 18 Aug 2025 09:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755508307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UIFh0u3sb9PLm3aSj2RqklSdtaj/XkSF6e+6PoFJ/og=;
	b=zbcSSq0sdEeYvaCEyPccL50PwuWVqDpT4ftQKZM6Wy7lszXRwPYmqA2EKhbbGDukkvRj9n
	UPGGF+sjWUoZjfff0myC2JOX0Yzz+4cmo93khMPTB1fdUiw9+TqUi0Frkgtq9gUvtOtpH1
	Y0+8yO7PWUBmlroYYI6yDZNhC7ebfUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755508307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UIFh0u3sb9PLm3aSj2RqklSdtaj/XkSF6e+6PoFJ/og=;
	b=rztUsYzt7kIU/Zf8jvJseHdUn4m+K+mQxNWZ6/7RcGqYWrTst9W/WTiARJnxvwNSgMjvUZ
	B7ueW8knsNkIMBDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755508307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UIFh0u3sb9PLm3aSj2RqklSdtaj/XkSF6e+6PoFJ/og=;
	b=zbcSSq0sdEeYvaCEyPccL50PwuWVqDpT4ftQKZM6Wy7lszXRwPYmqA2EKhbbGDukkvRj9n
	UPGGF+sjWUoZjfff0myC2JOX0Yzz+4cmo93khMPTB1fdUiw9+TqUi0Frkgtq9gUvtOtpH1
	Y0+8yO7PWUBmlroYYI6yDZNhC7ebfUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755508307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UIFh0u3sb9PLm3aSj2RqklSdtaj/XkSF6e+6PoFJ/og=;
	b=rztUsYzt7kIU/Zf8jvJseHdUn4m+K+mQxNWZ6/7RcGqYWrTst9W/WTiARJnxvwNSgMjvUZ
	B7ueW8knsNkIMBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C442E13A55;
	Mon, 18 Aug 2025 09:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f1ewLlLuomigNAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 18 Aug 2025 09:11:46 +0000
Date: Mon, 18 Aug 2025 11:11:46 +0200
Message-ID: <87zfbxvvsd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<13564923607@139.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<baojun.xu@ti.com>,
	<Baojun.Xu@fpt.com>,
	<jesse-ji@ti.com>
Subject: Re: [PATCH v2] ALSA: hda/tas2781: Add name prefix tas2781 for tas2781's dvc_tlv and amp_vol_tlv
In-Reply-To: <20250816042741.1659-1-shenghao-ding@ti.com>
References: <20250816042741.1659-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Sat, 16 Aug 2025 06:27:41 +0200,
Shenghao Ding wrote:
> 
> With some new devices adding into the driver, dvc_tlv and amp_vol_tlv will
> cause confusion for customers on which devices they support.
> 
> Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

Thanks, applied now.


Takashi

