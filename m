Return-Path: <linux-kernel+bounces-821169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DB4B80A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EB962000D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E3933AE8B;
	Wed, 17 Sep 2025 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rp7A3Rua";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SE0Zl8nJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rp7A3Rua";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SE0Zl8nJ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00469335926
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123455; cv=none; b=P6BIED9hnZKldOA+oVk2Qh+KktIKtylQuTI9UgyWft8t7CxcTK07tdO/FoUPoibKLxU4dJhrlgsQ+6/OcOgJbmwhSWRE2FDPq3EuuFEMoYDwQsBoAYpImN+Inzrpipv9wok0d33ENaTFIIrSBpucnI1RNpAKgXBStOqBNQZE/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123455; c=relaxed/simple;
	bh=bL0PTwba/ljCGMfNfylBv4NNETZUr0zppbsnzSP7Ek0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cphL4uV9QoQWuJOhpl+SgguA+NrlTm7vXR4ObBHkdrWPQy1ulPevRSLk4URbnwSwmSV32bBYxh/bAZzHL9CGDoto848ircytWDov0JL9QmORV4tIFwSc7DyqB28w91q+rsMqPahK2k5WEHx2KCO+l8t8QBXiJ4UgqY6SfSzKFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rp7A3Rua; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SE0Zl8nJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rp7A3Rua; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SE0Zl8nJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1715C20A0D;
	Wed, 17 Sep 2025 15:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758123452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLK4uKZ0YbY3dpZhagtBp53/TySPCpPxR5tJBuv7tAw=;
	b=Rp7A3Ruaz8wGPGus+7dZeLwK5Ri4igwLwhvha1mD4TTssFmp8llW6E6afHCiuovFQKmC3h
	WfJWvuFy6NZLzOjGZ6T2A06Sq5DCXPRpLLqHGFlQZpN/FCRT/DEVmKA2V9R9oHaLDz9FcL
	FOX3A9W/nP7zeXUcumOwvfY2sAwTXuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758123452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLK4uKZ0YbY3dpZhagtBp53/TySPCpPxR5tJBuv7tAw=;
	b=SE0Zl8nJqTXs2C3f5bSiK/tARJdE6sFJs7QzheKxX0t8sOEfpcKVO4fePYEDTaxcZx6znG
	OfL5N6+7B1Wq5pBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Rp7A3Rua;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SE0Zl8nJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758123452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLK4uKZ0YbY3dpZhagtBp53/TySPCpPxR5tJBuv7tAw=;
	b=Rp7A3Ruaz8wGPGus+7dZeLwK5Ri4igwLwhvha1mD4TTssFmp8llW6E6afHCiuovFQKmC3h
	WfJWvuFy6NZLzOjGZ6T2A06Sq5DCXPRpLLqHGFlQZpN/FCRT/DEVmKA2V9R9oHaLDz9FcL
	FOX3A9W/nP7zeXUcumOwvfY2sAwTXuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758123452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLK4uKZ0YbY3dpZhagtBp53/TySPCpPxR5tJBuv7tAw=;
	b=SE0Zl8nJqTXs2C3f5bSiK/tARJdE6sFJs7QzheKxX0t8sOEfpcKVO4fePYEDTaxcZx6znG
	OfL5N6+7B1Wq5pBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73C26137C3;
	Wed, 17 Sep 2025 15:37:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YQzRGLvVymioIQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 17 Sep 2025 15:37:31 +0000
Date: Wed, 17 Sep 2025 16:37:21 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: "H. Peter Anvin" <hpa@zytor.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH RESEND] x86/split_lock: Warn for bus locks once for each
 task
Message-ID: <hs7b3ghxpr2oq6rmqitw33xkunkqpvjkpnwzhqfq4em5vxvymw@rn4c6mr636es>
References: <20250910162126.157894-1-pfalcato@suse.de>
 <3c7c5bca-5d3f-4878-b6d4-72b036e8b588@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c7c5bca-5d3f-4878-b6d4-72b036e8b588@yandex-team.ru>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 1715C20A0D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Wed, Sep 17, 2025 at 05:41:11PM +0300, Maksim Davydov wrote:
> Hi!

Hi!

> I've tested this patch (VM w/ bus lock detection and w/o split lock
> detection). The warn mode works fine and as expected with only one
> notification per task. However, the ratelimit mode has been changed too:
> only one notification per task will be in dmesg, because this mode reuses
> notification code of warn mode. But in the documentation for ratelimit mode
> there is nothing about the limit of notifications: "Limit bus lock rate to N
> bus locks per second system wide and warn on bus locks.". Thus, I think that
> ratelimit mode should remain old behaviour.
>

So, you're suggesting different "warn" behaviors depending on =warn vs
=ratelimit? I don't have a particularly strong opinion here, but I was assuming
that "warn on bus locks" means "do whatever =warn is supposed to do". I'm not
sure warning every time gains you much, though.

-- 
Pedro

