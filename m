Return-Path: <linux-kernel+bounces-887209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3836DC378D6
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CEB1881877
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E703344049;
	Wed,  5 Nov 2025 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R5Gx6yH6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iK1Ery+M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R5Gx6yH6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iK1Ery+M"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E41344032
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372270; cv=none; b=LieAJm7DNYAUUNwWRVp+wK19TFWWRojWK/Mr6OwVdGI5kjgZa8bj6v555xDyYigt/BwJkVSZTmaoxNhK8+vBdzeoi2D9mbWGJWaRVMgmpeyqD9mWLBx0yh5vJWT7S6hI+VNsFlf1yZuuAsHz/Adi7QiXzxhqJMccioA7bNI07eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372270; c=relaxed/simple;
	bh=Tf4dNuGL3M0QC1svVEjenTpnqBG0sG1M7d8xbFvZNls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0KlvM22MJymXp7Ort1uQnzvTb9SBFLhlQUAjTyFdI7jj3WWqDeD9z66o0ke6WzFPD8YcbptdAp+9VFd+oUuFmFzUeqTR2v39rf15lbCmBUFy33OnXPIXbUVtwbf5BgACgBnrnq+WPJ3ipac6syJYqYojLXDPOBAleE+lNKi2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R5Gx6yH6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iK1Ery+M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R5Gx6yH6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iK1Ery+M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 291351F394;
	Wed,  5 Nov 2025 19:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762372265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tf4dNuGL3M0QC1svVEjenTpnqBG0sG1M7d8xbFvZNls=;
	b=R5Gx6yH627Xt3wpipcW3XM8jHfUry+QgDcEXtZxPeWuvB+SM+SJ7dy3yZ78M9uLR1VBbmt
	9f0Ac04QeotcYIGnhYEghE3wFnus53+7fxDAVnDoZZ7DSBSFchvCE1WKYw5FDFWnlI/EeR
	NeSVvgJvY9VugQbYAP+k84AZvO4GqsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762372265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tf4dNuGL3M0QC1svVEjenTpnqBG0sG1M7d8xbFvZNls=;
	b=iK1Ery+Mvrht7A2JtuhgBOW/6ekwfqA8yZyOxeIhb8Tea8wVg+GDk6tdcFSXlBVpOeqyWg
	IqcbVBLalP5VVGBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R5Gx6yH6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iK1Ery+M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762372265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tf4dNuGL3M0QC1svVEjenTpnqBG0sG1M7d8xbFvZNls=;
	b=R5Gx6yH627Xt3wpipcW3XM8jHfUry+QgDcEXtZxPeWuvB+SM+SJ7dy3yZ78M9uLR1VBbmt
	9f0Ac04QeotcYIGnhYEghE3wFnus53+7fxDAVnDoZZ7DSBSFchvCE1WKYw5FDFWnlI/EeR
	NeSVvgJvY9VugQbYAP+k84AZvO4GqsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762372265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tf4dNuGL3M0QC1svVEjenTpnqBG0sG1M7d8xbFvZNls=;
	b=iK1Ery+Mvrht7A2JtuhgBOW/6ekwfqA8yZyOxeIhb8Tea8wVg+GDk6tdcFSXlBVpOeqyWg
	IqcbVBLalP5VVGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16E5D13699;
	Wed,  5 Nov 2025 19:51:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y0ctBamqC2ngDAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Nov 2025 19:51:05 +0000
Date: Wed, 5 Nov 2025 20:51:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: odd objtool 'unreachable instruction' warning
Message-ID: <20251105195103.GR13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
 <ubqjeplvslhnspqw6pnqwo7c6sq2ygdtmkuqr4q3hjlxfkuwii@xn63k6qz22mz>
 <CAHk-=wgs8+xVbv5tu9kv5n=LwWFZ0FW4GPwVmXBPjLQ0goLfjQ@mail.gmail.com>
 <es4awalt6i63cy5kkrbz7f22cxpt4zbmq6zsbol3yafek2375e@6b6stnc6k6h2>
 <CAHk-=wjhcrqXoTLMjTF=pH_+Zq4vRdFY3Y4c_A3TemzSvssRzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjhcrqXoTLMjTF=pH_+Zq4vRdFY3Y4c_A3TemzSvssRzQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 291351F394
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21

On Wed, Oct 29, 2025 at 09:17:36AM -0700, Linus Torvalds wrote:
> Now, if objtool disassembly ever gives the kind of good disassembly
> that 'perf report' does - with branches turned into arrows etc - that
> would be lovely, and I'd replace my hacky alias in a heartbeat.

FWIW, 'objdump --visualize-jumps' shows the arrows, with
'--visualize-jumps=extended-color' they're colored and it's readable.

