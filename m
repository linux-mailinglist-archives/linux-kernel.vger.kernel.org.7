Return-Path: <linux-kernel+bounces-816916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DDAB57ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CA51AA1AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D429C3093CF;
	Mon, 15 Sep 2025 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jboKRX35";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uqGAV7NG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jboKRX35";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uqGAV7NG"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A01309EE6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938938; cv=none; b=mXWJutZb2HVfw1dMjH/v9QXM+Av2VFf/rwYHFm7bF55l8kOIsh0CwAqRKbaUgL/gmnCQtUAM+eg7Tp+FOeo/Bqv4LT2lhbqIWyCWBR33jST1q3dZd4R/AT8PRYZ+kW2FUTC8Xszok0bNgzZWqrWXAqzI8CZb+9j4sz1tzhYyins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938938; c=relaxed/simple;
	bh=I1z0QKpTTdyUmHHiarAz8fl/WUx+eOJEhMLIts7vHVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avt5ne8HKj72IK7DsigBqyQ9cYX+JLnXBjmOxqxovsYjV+AOmWibu2qIONm21B7ujzqsY3C3JI0xDOWxNfBf1lMCwKefpeS7AkBb7d83IqljARBjUq8vkzzM4yTMmP8JjFXxG7d+yAasDrwgrd2C20fXJlASMt3wUnZuZckhvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jboKRX35; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uqGAV7NG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jboKRX35; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uqGAV7NG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B37282233F;
	Mon, 15 Sep 2025 12:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757938934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Gd6ocK7PYXnLUfd/4ioVl2Nj5mTe5C70EFMZFs7vgk=;
	b=jboKRX35Rd49UkjaxBd8gP9+HCqhsUIXMwJMB/+lhrSoipTFEnCC3LV6yNkLoanv3t+JZE
	PerGuhYEZf3CsDbsoPcALsorHLc5RyxciKBlnU64jAMtspuD01xdk29l/fT6xPdJhP9D1c
	IK32NPwqVBHe2k3Cs4PT7DCc8irDwW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757938934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Gd6ocK7PYXnLUfd/4ioVl2Nj5mTe5C70EFMZFs7vgk=;
	b=uqGAV7NGJS+b+BEil1xjYH460xObSQlMAmgv0cyKr2AEIMYuauTPp7cA7YtzLPDgJn+Q4g
	u5ytQFYuQ3hm1FAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jboKRX35;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uqGAV7NG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757938934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Gd6ocK7PYXnLUfd/4ioVl2Nj5mTe5C70EFMZFs7vgk=;
	b=jboKRX35Rd49UkjaxBd8gP9+HCqhsUIXMwJMB/+lhrSoipTFEnCC3LV6yNkLoanv3t+JZE
	PerGuhYEZf3CsDbsoPcALsorHLc5RyxciKBlnU64jAMtspuD01xdk29l/fT6xPdJhP9D1c
	IK32NPwqVBHe2k3Cs4PT7DCc8irDwW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757938934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Gd6ocK7PYXnLUfd/4ioVl2Nj5mTe5C70EFMZFs7vgk=;
	b=uqGAV7NGJS+b+BEil1xjYH460xObSQlMAmgv0cyKr2AEIMYuauTPp7cA7YtzLPDgJn+Q4g
	u5ytQFYuQ3hm1FAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 756A31368D;
	Mon, 15 Sep 2025 12:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KVOzGvYEyGi4NwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 15 Sep 2025 12:22:14 +0000
Date: Mon, 15 Sep 2025 14:22:13 +0200
From: Jean Delvare <jdelvare@suse.de>
To: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Naveen Krishna Chatradhi
 <naveenkrishna.chatradhi@amd.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Target architecture of amd-sbi driver
Message-ID: <20250915142213.3fa69cd8@endymion>
In-Reply-To: <5c9f7100-0e59-4237-a252-43c3ee4802a2@amd.com>
References: <20250915112834.1d566970@endymion>
	<5c9f7100-0e59-4237-a252-43c3ee4802a2@amd.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B37282233F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01

On Mon, 15 Sep 2025 16:04:37 +0530, Gupta, Akshay wrote:
> On 9/15/2025 2:58 PM, Jean Delvare wrote:
> > The amd-sbi Linux driver (sbrmi-i2c kernel module) can currently be
> > selected on all architectures. Is this driver intended to be used on
> > the host, or on the BMC, or both?
> >
> > If it's an host-side driver, it should not be proposed on non-x86
> > architectures by default and we should add a hardware dependency to it
> > (or'd with COMPILE_TEST to preserve build testing coverage). What do
> > you think?
> 
> Its not a host-side driver and is intended for BMC. Today we are using 
> over ARM and ARM64 BMC.

OK, thanks for clarifying. I think this information could be added to
Kconfig to benefit to all users and help them decide if they want to
build the driver or not. I'll send a patch.

-- 
Jean Delvare
SUSE L3 Support

