Return-Path: <linux-kernel+bounces-797856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7786EB41654
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702B3680A0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539112D9EE2;
	Wed,  3 Sep 2025 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E8fWR7Wc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lsMUQ4zU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E8fWR7Wc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lsMUQ4zU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740E27FB2A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884082; cv=none; b=ZIEslbrJgXNJRqRfjy+DSaJQTA5GxoebtoExyXBuIvKcoulxpnzBBiegO1QXgW069tFxYYuVOTNlYplRqowQD5DPiweiSadlsbuIMiOAOVqCep1gcZvxDcQXw1X0n4VuKipnh3/PtHOBD6sVhWOEC2zRuCHVwj+Qp+CNPXThE6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884082; c=relaxed/simple;
	bh=XCJju57bq6ayw2SMfc0th7t/lqfRHBQUgw2HTfEIB8Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KClHjQH++ZmhGfTZVr6wU9UMdCrujA/dCh5Smy/a54z15gxkxBgi4P0yD6SFIeR54Zq2uY3+YT6iBf0tBI8S1miabenJu8vGBZZ3bQZK5Kf1FfOWBIHlvo02q44pxzY6SZFO71HEU+wzpXnh9zajS+fXAQMsv66coz2qBl3ctWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E8fWR7Wc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lsMUQ4zU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E8fWR7Wc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lsMUQ4zU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C76FC21293;
	Wed,  3 Sep 2025 07:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756884078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFBc6RWh8ZSGiW9y51f3aVlmvJZi/JtU2Up3L8KsEe4=;
	b=E8fWR7WcOowR+xEjSfF3rWjyV27IgfjBAmDlloPDhS+uE+GuOl0XGPDbPzM2zzLgX7OR0d
	UVtC5kMyyphu0WzTwSKu0yrNzJOo9kYK71TJKSWjtJoFqDjg1HrCyxOf5Z3Uy+lImArck+
	lVlxDZhX4fudPxx5r4mgXuqEt1fW8Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756884078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFBc6RWh8ZSGiW9y51f3aVlmvJZi/JtU2Up3L8KsEe4=;
	b=lsMUQ4zUFGEIUwfgxfyVLgbox+FgoinwYG4YadgXwFrYGtqQ0n8bjtv2Y2gEt90/avqR2c
	XjrJQr0j0zHQSkDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756884078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFBc6RWh8ZSGiW9y51f3aVlmvJZi/JtU2Up3L8KsEe4=;
	b=E8fWR7WcOowR+xEjSfF3rWjyV27IgfjBAmDlloPDhS+uE+GuOl0XGPDbPzM2zzLgX7OR0d
	UVtC5kMyyphu0WzTwSKu0yrNzJOo9kYK71TJKSWjtJoFqDjg1HrCyxOf5Z3Uy+lImArck+
	lVlxDZhX4fudPxx5r4mgXuqEt1fW8Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756884078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFBc6RWh8ZSGiW9y51f3aVlmvJZi/JtU2Up3L8KsEe4=;
	b=lsMUQ4zUFGEIUwfgxfyVLgbox+FgoinwYG4YadgXwFrYGtqQ0n8bjtv2Y2gEt90/avqR2c
	XjrJQr0j0zHQSkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8129413888;
	Wed,  3 Sep 2025 07:21:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LhfzHW7st2hePQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 03 Sep 2025 07:21:18 +0000
Date: Wed, 03 Sep 2025 09:21:18 +0200
Message-ID: <87cy88vw5t.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<13564923607@139.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<baojun.xu@ti.com>,
	<Baojun.Xu@fpt.com>
Subject: Re: [PATCH v2] ALSA: hda/tas2781: Fix the order of TAS2781 calibrated-data
In-Reply-To: <20250903041351.143-1-shenghao-ding@ti.com>
References: <20250903041351.143-1-shenghao-ding@ti.com>
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
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,ti.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Wed, 03 Sep 2025 06:13:51 +0200,
Shenghao Ding wrote:
> 
> A bug reported by one of my customers that the order of TAS2781
> calibrated-data is incorrect, the correct way is to move R0_Low
> and insert it between R0 and InvR0.
> 
> Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> 
> ---
> v2:
>  - Submit to sound branch maintianed by Tiwai instead of linux-next branch
>  - drop other fix

You haven't answered to my previous question at all.

Is the issue you're trying to fix something different from what Gergo
already fixed in commit d5f8458e34a331e5b228de142145e62ac5bfda34
(which was already merged to Linus tree).


Takashi

