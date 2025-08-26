Return-Path: <linux-kernel+bounces-786873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF2EB36D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FCE983AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8670D244691;
	Tue, 26 Aug 2025 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jtd1oiLf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h7My61nM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q3iQ3u+t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YCDGa+93"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12796F305
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220547; cv=none; b=s/+qzoaFZoou8C2KfGCBIFlIZEXNz9A7UUaCDJlYV5XRUkIDtVHOJrf645J3HtrBgs9BfN91+MqiCvPSh2Ble436oTdW7ZMvAQoC0gHxqNeYMsflf10ryMEot/C/s7jbSll/uMzMuDiDWMiB3LMKkEkqy0ppssv7QhXzD40i73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220547; c=relaxed/simple;
	bh=gmLHn+JclKbBQaZgva/YFukNm9V7gMp7FDO6cJ1BgKA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WV0oMXxz3fXiY+AozU++Pahd30H+9gQMF//ObtPZY/Piy8CzeKE5E5jZCr4QkiNQbh8M96w9LKt2i1dKY3BJaR4hBJKYy0GsC8lQB6s/qg0BnJKhaBLAsMHdi4xwt4Cj7LtlgPV3OlFaKt6TJuLd/uB1J1jutIiU/k3AnJHTygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jtd1oiLf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h7My61nM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q3iQ3u+t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YCDGa+93; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D30AE1F79B;
	Tue, 26 Aug 2025 15:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756220541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/EK/zJoRkG0BUXAMAazPDRYCWHWMzDXyPvU4VjCDWSg=;
	b=jtd1oiLfuZPftGPt8TrY0u9qh2jF4+zjVG9WDS5uEMBBmQeEyA3eLWB/XDT3ybWtldX7vl
	MbkRyQs7eDfup6Af02BREHLx7uIsoSLWSw/RTvrxrkPz4PBfb2PFuTerYt0Zms7KjURhT9
	T9HcorPz7Df3O6MA02sXCriTLzSnkls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756220541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/EK/zJoRkG0BUXAMAazPDRYCWHWMzDXyPvU4VjCDWSg=;
	b=h7My61nMIlE0I0cmVP2YrecFyGPY1L3Rx7kY29lyhlwt/VKoK4miotdHKgP7O9VuHoQAHl
	kivkcjS5w26LT0DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756220540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/EK/zJoRkG0BUXAMAazPDRYCWHWMzDXyPvU4VjCDWSg=;
	b=Q3iQ3u+te9Royo7a6vIr0EY0c81r76ZhQytiroBNJWKx1L9uSYyMH9LMvWXWEp7abc55v/
	7yOQPHx4oRHPW1tE1aj+IRz6cOL1S2MfyMhyipZNywe/fitbdeSBPNfguK6foCY2W+nV8E
	nHQby2NDtM0Kj3VfrfcXRetorP9hpy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756220540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/EK/zJoRkG0BUXAMAazPDRYCWHWMzDXyPvU4VjCDWSg=;
	b=YCDGa+938GA8/ob9zxhkXeMpIqmMo1YzR71gusVueVRBrf89DVTdLiutbOxnqGzFJi+4Eh
	DBhlUNXhIImruvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93BAB13A31;
	Tue, 26 Aug 2025 15:02:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GueHInzMrWjlUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 Aug 2025 15:02:20 +0000
Date: Tue, 26 Aug 2025 17:02:20 +0200
Message-ID: <87cy8igm83.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: aer@tuxedocomputers.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christoffer Sandberg <cs@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix headset mic for TongFang X6[AF]R5xxY
In-Reply-To: <20250826141054.1201482-1-aer@tuxedocomputers.com>
References: <20250826141054.1201482-1-aer@tuxedocomputers.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Tue, 26 Aug 2025 16:10:54 +0200,
aer@tuxedocomputers.com wrote:
> 
> From: Aaron Erhardt <aer@tuxedocomputers.com>
> 
> Add a PCI quirk to enable microphone detection on the headphone jack of
> TongFang X6AR5xxY and X6FR5xxY devices.
> 
> Signed-off-by: Aaron Erhardt <aer@tuxedocomputers.com>

Applied now.  Thanks.


Takashi

