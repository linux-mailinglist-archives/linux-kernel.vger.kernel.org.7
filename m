Return-Path: <linux-kernel+bounces-881694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFE9C28C5F
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 09:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92FCD347965
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 08:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A03B239E88;
	Sun,  2 Nov 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iBFgohLG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q/JuuGhq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BRlsa6IG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nk/c3qtf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A370830
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762073608; cv=none; b=PWncyJiWAdm5Spx6okpPINHhs3egW9A3uG32KM0838Bwy5/K9EkcIFIlNMs8zUM8KcKL4FJxKP30X1+hvTM8DH6y/sTETFlklT6jhqv2vJ3TFXGIEjQyO5PHQ8ZzuGVLHzFvrmzurDXLk2AIY8B96o7iHRuhesJWbZQ/ws1qEPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762073608; c=relaxed/simple;
	bh=Uiyfq1AbaevCeFXJzhxuASvSef/oaPME8epTDo2A4x0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3y1IM9SOG6pheALI0vA6QrE6QWKY37Rmj72oBPlxQpfaKdX6NOo0JV+GcmbReCBRxmLmCjK90m5ZKUNrYE0Adj0kkgu54erT6NofBhMAWeoD3wbRkXsCHltlOnR9w+bsUDHfsRaQ4cjmfv6NR5SHyg4h6JlEPmvvnHARt6TtdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iBFgohLG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q/JuuGhq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BRlsa6IG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nk/c3qtf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0159B21E42;
	Sun,  2 Nov 2025 08:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762073599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whWmuIo8BkrFD3woku67Lui3vFiGIiHeK9ApU5yRluY=;
	b=iBFgohLGxcu0RSzyb6nRNTalk+sUyMqlkihulaONZb1q9mOMMD+EWY/lKKLIHqgZcZjOUV
	9YJXMmcNKrvVoiN1O0sw/WIn1sJTiqVKF5m0qMbc7OpBuCdOHcLfspe59BRo1oDu0opDWr
	cWPIFx9A6JGWisc8OYOb9t0g+veuiI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762073599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whWmuIo8BkrFD3woku67Lui3vFiGIiHeK9ApU5yRluY=;
	b=Q/JuuGhqGAMBtfcq1lJOjG3mezXROXiJ/p7mJQbQIcjFlH2ZQ8R8q4HhhsmULWNpw4/8is
	odni3IFL17F1h6BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762073598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whWmuIo8BkrFD3woku67Lui3vFiGIiHeK9ApU5yRluY=;
	b=BRlsa6IGatUMijsSsO6Mbn2XwyuJgzMtX4QTl0zEUJRrmvCa3j6BZGVSYqoK15qlGsgy7w
	JMFeEmguRqLrmQ6pDnyNajMeuKRtQoTcaAB/cPKuxkJLWuXlMkLUOKEOHcdcnG3hKYpfGs
	Vzbs7q3iltOBzgl65jYJvEPnUITipNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762073598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whWmuIo8BkrFD3woku67Lui3vFiGIiHeK9ApU5yRluY=;
	b=Nk/c3qtf2HUK9ARKRWngyZ+sEBqz0QlXUKZnMU2i49UBpx/jCLRbgqQI0N0ohp43GEb167
	WlfqerZpc4l0zpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C199013699;
	Sun,  2 Nov 2025 08:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K8RzLf0bB2nmPgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 02 Nov 2025 08:53:17 +0000
Date: Sun, 02 Nov 2025 09:53:17 +0100
Message-ID: <87frawiznm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?Baltaz=E1r?= Radics <baltazar.radics@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: line6: add support for POD HD Pro X
In-Reply-To: <20251031183514.40926-1-baltazar.radics@gmail.com>
References: <20251031183514.40926-1-baltazar.radics@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.76 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.16)[-0.788];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -1.76

On Fri, 31 Oct 2025 19:35:14 +0100,
Baltazár Radics wrote:
> 
> It uses the same protocol as other POD HD models so it just needed
> proper config.
> 
> Signed-off-by: Baltazár Radics <baltazar.radics@gmail.com>

Applied to for-next branch now.  Thanks.


Takashi

