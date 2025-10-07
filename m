Return-Path: <linux-kernel+bounces-844219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9D8BC1533
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B2754EC3BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585622DC77F;
	Tue,  7 Oct 2025 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i1CILwRf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xg67vU2L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i1CILwRf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xg67vU2L"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0359C2797BE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839267; cv=none; b=C3IzzTE7dmK4tEpVICrw45fMzK5HKajmJM1CXz9oC5XALS9tU7VYr4lRotXJzanSQU93EOUasYeA+DYiDoeI0Z4nXguCYcGzbvMRuJyw0RsaqoViaJAo+spqie/Ry1PHI8NBiD3sZptNkJSPi1YLzKf93jnURSm3BqSGyIkekmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839267; c=relaxed/simple;
	bh=boZQQRxENSTXFV9pMkw/mWSbvnDjShqnxVxxrUNEEAQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJpemLhT+WBtxIImKNwpcbdp9YjpgF/Bakv30Cs67xeVP7E1MwewQ8pH7JlzYLKpU8QKpm/eV7Q5q7uZQkBnGIH/RgX0Agv/n3yV2vvRJQ7kriz+xS9JaZdPoj4pusGEu1zqya4H7LobOfBBl1zlakby1ufXeeaY9mb2q32BMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i1CILwRf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xg67vU2L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i1CILwRf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xg67vU2L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 182731F44F;
	Tue,  7 Oct 2025 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759839263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vl64LI1ehr2NMKN0Vi6qH/N4vk0qioUPQdIgtf4tiM0=;
	b=i1CILwRfuwuAcwfT/1Oa9kdcH51B37SQvStGdmLNOQHwhZmXl4ejtFCfmkf/ldX3zHxQuk
	IxXjcClhXw/slV8orLoDW/SmAZOuU0iP5x4/t8irSRiRfScTw02Xdn8mlfRg4NDx8P7kdZ
	H169CTXeBPukoXmJ8gng0WIRsZLvOGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759839263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vl64LI1ehr2NMKN0Vi6qH/N4vk0qioUPQdIgtf4tiM0=;
	b=xg67vU2LCG0JxyblYevssRnbBO73W8nwapvLirGKDygsrz1u5WNINxyib8HsvIztpPVRE+
	4J0LV4QZ6TnmujAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i1CILwRf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xg67vU2L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759839263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vl64LI1ehr2NMKN0Vi6qH/N4vk0qioUPQdIgtf4tiM0=;
	b=i1CILwRfuwuAcwfT/1Oa9kdcH51B37SQvStGdmLNOQHwhZmXl4ejtFCfmkf/ldX3zHxQuk
	IxXjcClhXw/slV8orLoDW/SmAZOuU0iP5x4/t8irSRiRfScTw02Xdn8mlfRg4NDx8P7kdZ
	H169CTXeBPukoXmJ8gng0WIRsZLvOGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759839263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vl64LI1ehr2NMKN0Vi6qH/N4vk0qioUPQdIgtf4tiM0=;
	b=xg67vU2LCG0JxyblYevssRnbBO73W8nwapvLirGKDygsrz1u5WNINxyib8HsvIztpPVRE+
	4J0LV4QZ6TnmujAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAB7F13AAC;
	Tue,  7 Oct 2025 12:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ++/DOB4E5WgRCQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 07 Oct 2025 12:14:22 +0000
Date: Tue, 07 Oct 2025 14:14:22 +0200
Message-ID: <87bjmiewo1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<stable@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<baojun.xu@ti.com>,
	<Baojun.Xu@fpt.com>,
	<13564923607@139.com>,
	<13916275206@139.com>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Enable init_profile_id for device initialization
In-Reply-To: <20251007103708.1663-1-shenghao-ding@ti.com>
References: <20251007103708.1663-1-shenghao-ding@ti.com>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,vger.kernel.org,alsa-project.org,ti.com,fpt.com,139.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 182731F44F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Tue, 07 Oct 2025 12:37:08 +0200,
Shenghao Ding wrote:
> 
> Optimize the time consumption of profile switching, init_profile saves
> the common settings of different profiles, such as the dsp coefficients,
> etc, which can greatly reduce the profile switching time comsumption and
> remove the repetitive settings.
> 
> Fixes: e83dcd139e77 ("ASoC: tas2781: Add keyword "init" in profile section")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

Applied now.  Thanks.


Takashi

