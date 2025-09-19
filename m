Return-Path: <linux-kernel+bounces-824525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15A7B89795
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D761C87D55
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA001F3BAE;
	Fri, 19 Sep 2025 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hOSWJ7U/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8OLgf1Zr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="byjqooEg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MqqkmBtT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD01E5711
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285473; cv=none; b=jYitliBekVrLwMdEt25OgaLJLU9anFpFjtlYlvtXDctNMaY6cKu660JaROrOKjV3j0uTkacoy4h1M2DQ9Z5Np6QIKtRydtpH59NP9w8UuSIWDQG1OxVJ5Uw6hW2heOrAVKwXYbakoDURYAXCprDA4F9dWNCvmNCZm1GziA85a7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285473; c=relaxed/simple;
	bh=E071kAR9Cwiv4tprzrsQd0Wm1nTgm4cnT1ggYiCLipw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBC5UuNFJ/T4meEwqhFWo71jkMtBWUTmKwh6WwmJbF7EnhbpQ5p8B4Gm49PZHnQlFf+KcNE8Asrf6s8kqT8upo7DAYWcYXp1wfoWmrSxDej5PK4WuxgLvfraX1gvZUI0a+fFHo+S+tSX/GaSGyuXE9Zsnn0BLTiu+qoXno6odb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hOSWJ7U/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8OLgf1Zr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=byjqooEg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MqqkmBtT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C65B336B4;
	Fri, 19 Sep 2025 12:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758285469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C6GkLf705dTHn7tuGiBKNFNBqf28JhNLc1I8EUzcjUw=;
	b=hOSWJ7U/8dYXoWnNnn6X1odf4EaTM1yIxkWtxLQyXvMLITi+f4+C4I1ePsLkj1CUAGcDSl
	nZkhM9Y071HN0IysIX3E1/H+iPUCBDYwS3C9nDCV1SeMZa1xKCBacEnE4Gy6M4f41UfzKb
	lvlPCUWYrFzWJiSH2VtWPCjUlLW0H/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758285469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C6GkLf705dTHn7tuGiBKNFNBqf28JhNLc1I8EUzcjUw=;
	b=8OLgf1Zr3oOREDInTDBQpw63Fk0HgEYhgQ+PTEVMQ2ke3lA8G+VSPyT+iQYOcvWZ9yTvqK
	lOE0k0Js6yQa2WBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758285468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C6GkLf705dTHn7tuGiBKNFNBqf28JhNLc1I8EUzcjUw=;
	b=byjqooEgqNWSMVsab6feLYA1L0bmd4qz+qeiUHe840D2iqdHcwkEkeGmzxpp5PbYnTHPsS
	4wL7PGLo/OstegEJr4JNmgHs8ylY2601/bPC9HkAx1IsoaO1M7/nxE628XdUbb37oH2CmI
	CVkjwiTRcN70uJccnRLUTmCJR6rvaTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758285468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C6GkLf705dTHn7tuGiBKNFNBqf28JhNLc1I8EUzcjUw=;
	b=MqqkmBtTVWRKWn03tZcXSpkWq5S4ylxtoNpOKQpTS7h04IWTuiltf9fwfMtZvoXP6oUcEn
	GoH2t3o13iLcFXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B3C613A39;
	Fri, 19 Sep 2025 12:37:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cd2nHJtOzWgofgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Sep 2025 12:37:47 +0000
Date: Fri, 19 Sep 2025 14:37:47 +0200
Message-ID: <87segi8vok.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: cryolitia@uniontech.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Nie Cheng <niecheng1@uniontech.com>,
	Zhan Jun <zhanjun@uniontech.com>,
	Feng Yuan <fengyuan@uniontech.com>,
	qaqland <anguoli@uniontech.com>,
	kernel@uniontech.com,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH v4 2/5] param: export param_array related functions
In-Reply-To: <20250918-sound-v4-2-82cf8123d61c@uniontech.com>
References: <20250918-sound-v4-0-82cf8123d61c@uniontech.com>
	<20250918-sound-v4-2-82cf8123d61c@uniontech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Thu, 18 Sep 2025 11:24:31 +0200,
Cryolitia PukNgae via B4 Relay wrote:
> 
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> - int param_array_set(const char *val, const struct kernel_param *kp);
> - int param_array_get(char *buffer, const struct kernel_param *kp);
> - void param_array_free(void *arg);
> 
> It would be helpful for the new module param we designed in
> snd_usb_audio, in order to run additional custom codes when params
> are set in runtime, and re-use the extisted codes in param.c
> 
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

Can we do just like below?

static int param_set_quirkp(const char *val, const struct kernel_param *kp)
{
	guard(mutex)(&quirk_flags_mutex);
	return param_set_charp(val, kp);
}

static const struct kernel_param_ops param_ops_quirkp = {
	.set = param_set_quirkp,
	.get = param_get_charp,
	.free = param_free_charp,
};
#define param_check_quirkp param_check_charp

modules_param_parray(quirk_flags, quirkp, NULL, 0644);

Then mutex is locked at each time a parameter is set.
Optionally, the string value can be verified in param_set_quirkp()
before passing to param_set_charp(), too.


thanks,

Takashi

