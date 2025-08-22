Return-Path: <linux-kernel+bounces-782443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BF6B3206C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4471785C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C4B277CBD;
	Fri, 22 Aug 2025 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v8wr2uZ3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vtO1+coR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R0gYAF1/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4D5vr7xD"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF2258EF1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879653; cv=none; b=mTBM4hN1BhAqHlKOxIrZfUfhhcF6p1D850gbtUtfi3iXdxEKYtmEq8gnqhwgDGK2HTFR6zI7K6Jj0WPVuq1354j+zWULo9WXS2C7Qfac7swNYY0Fw0D4pP5KgD6ZGLKDDpi7VTU7JOgM7j9xGzgOyEMW7yvtv2HlYzs0H+Gyo04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879653; c=relaxed/simple;
	bh=7lxvSp3xknP0ncWDrIdidiF2KXik5mdLOiRveqS4JAE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BoYJcwv+fqtyDKs6Ht8Nmjn47yqfTp9p3173dnqwntxqS84Jv/RN7PaASkeL+cNloAwDrA21IEVVU/TmeSAWFQJovFzrnij3kuBuxe9IGx4xuH1Q6/k4XTSk7yT7MIRQoLrwASA39CqxIRSa1eFRRrStUF9qBHftXOUmoHnbfhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v8wr2uZ3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vtO1+coR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R0gYAF1/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4D5vr7xD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 385BA21CAA;
	Fri, 22 Aug 2025 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755879650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rzZrkrYEVebL5JcnI8zpZya0TGeLqT8CkJ3Q10kaPSE=;
	b=v8wr2uZ35uij08cattSd/1weCQzS0+MwisyyYnKZvm8YFb75DnonS/t4vDcBz2ARsQfuom
	iT5zhb89mUuUyO4orMi6rNYoKtr1t3sUxDbVl43d/6wGQALp9nBiXp3/UJv1pZQ+sN+nkV
	jfslCDoYLnN8Umz6w68HAIyJLME614I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755879650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rzZrkrYEVebL5JcnI8zpZya0TGeLqT8CkJ3Q10kaPSE=;
	b=vtO1+coRg0G1oKmwJxDpO6Qb9IlWDQGwSbs2oxTjy716za0eLWyw5HIHEQHmI2+mD78LWK
	bOyxOYgn2u9/qZBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="R0gYAF1/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4D5vr7xD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755879649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rzZrkrYEVebL5JcnI8zpZya0TGeLqT8CkJ3Q10kaPSE=;
	b=R0gYAF1/Z2duBxOH2w3SjrPP4CXTMhzdNYNgl2E7d1t+eS2Pq9L9FPwN04pkwESlPfYbIF
	gcYLJUqNvk98HiV5qWXLo5sWVw9k+sazymMaYJ6ZFA+boZkLX+EyxINa9EXBqLV+Ub3Pd5
	LXM/LjITpF3Pvm8c1YixqWBHcOAxn9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755879649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rzZrkrYEVebL5JcnI8zpZya0TGeLqT8CkJ3Q10kaPSE=;
	b=4D5vr7xDrO2b82waOhxpTdfCXwj56x8QpJWpLORDoN5B6KzQ1hkdGBWpUIJLQejVint0fG
	qf1P/cxQkx2MZPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFC4613931;
	Fri, 22 Aug 2025 16:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TA8KOeCYqGjHKgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 22 Aug 2025 16:20:48 +0000
Date: Fri, 22 Aug 2025 18:20:48 +0200
Message-ID: <878qjb49b3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Brady Norander <bradynorander@gmail.com>
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	amadeuszx.slawinski@linux.intel.com,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Select SOF driver on MTL Chromebooks
In-Reply-To: <20250821014730.8843-1-bradynorander@gmail.com>
References: <20250821014730.8843-1-bradynorander@gmail.com>
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
X-Rspamd-Queue-Id: 385BA21CAA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.51

On Thu, 21 Aug 2025 03:47:30 +0200,
Brady Norander wrote:
> 
> The SOF driver is required for functional audio on MTL Chromebooks
> 
> Signed-off-by: Brady Norander <bradynorander@gmail.com>

Thanks, applied now.


Takashi

