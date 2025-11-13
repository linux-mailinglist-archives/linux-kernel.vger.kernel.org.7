Return-Path: <linux-kernel+bounces-899257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61EC573B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B335354B31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB27346E6E;
	Thu, 13 Nov 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xfYc8HJ3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KOXn7bwH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xfYc8HJ3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KOXn7bwH"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48890342C9E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033641; cv=none; b=eKuEtWlHUwa/njG/5EGCgif3s2BDaG5XCIPmoNCXpygu5/dyrTvt+eoHms8qeXMCskk5dSaan8kG1fsbUaL41x14xjWDNxmx1GuskEJZwnR9uEHtsKX50uq/p0sx0ozZIZfZ3G3bivBaREYPNrZGJyspw78WdW7PMbI6UTqncDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033641; c=relaxed/simple;
	bh=hZPNgdefE6AvRTEIIpd7l84uhOl5LSxQ4MAjyn1ko5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrQwKPC1EiIC9iPCjq2QfEzPAI+XJ0wkGzJcgx4QGYurO5iPIhxX/GCrR35W3TX7x0vy1/p/AUbQjyvJ4e9CwG9/kq5toECZWuJjeGzZNoBMO3qlplAQUyi7IE7TRiY5nH1gdrm/VX1DEuQQ0HCegTrrx+lXYkgXIHSp+7cXaqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xfYc8HJ3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KOXn7bwH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xfYc8HJ3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KOXn7bwH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77F5E1F791;
	Thu, 13 Nov 2025 11:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763033638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZthUKqi7Vyr9Dbs6vpgzy1ZbXby823BXqYQY2rExP5c=;
	b=xfYc8HJ3uqMdilgQnEVnUmUl77L8T/0ulRch/+9/ZbtP/ZoVZfZM4fVVVkOjeHJ1MN7DqF
	26Yr6r3ypVbz0XfH+cCNw17DV/LmMVPwuHKETw/XDdPn/sCfTI8SIAHtEDRThgEcZMVld+
	VR7FfoW2Wc3tATHJYzB1ZT9ahcWJSVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763033638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZthUKqi7Vyr9Dbs6vpgzy1ZbXby823BXqYQY2rExP5c=;
	b=KOXn7bwHbPe8gRKhpJyzfcobV1Pr0ri5q6v5os8d6ImSZamE2kMXdiP88kQs15q/gmkiU5
	h5GJ1Gfry+YCUnDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763033638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZthUKqi7Vyr9Dbs6vpgzy1ZbXby823BXqYQY2rExP5c=;
	b=xfYc8HJ3uqMdilgQnEVnUmUl77L8T/0ulRch/+9/ZbtP/ZoVZfZM4fVVVkOjeHJ1MN7DqF
	26Yr6r3ypVbz0XfH+cCNw17DV/LmMVPwuHKETw/XDdPn/sCfTI8SIAHtEDRThgEcZMVld+
	VR7FfoW2Wc3tATHJYzB1ZT9ahcWJSVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763033638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZthUKqi7Vyr9Dbs6vpgzy1ZbXby823BXqYQY2rExP5c=;
	b=KOXn7bwHbPe8gRKhpJyzfcobV1Pr0ri5q6v5os8d6ImSZamE2kMXdiP88kQs15q/gmkiU5
	h5GJ1Gfry+YCUnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68BF63EA61;
	Thu, 13 Nov 2025 11:33:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BARtGSbCFWnVcQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Nov 2025 11:33:58 +0000
Date: Thu, 13 Nov 2025 12:33:53 +0100
From: David Sterba <dsterba@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: zstd - Remove unnecessary size_t cast
Message-ID: <20251113113353.GP13846@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251108145707.258538-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108145707.258538-2-thorsten.blum@linux.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Sat, Nov 08, 2025 at 03:57:07PM +0100, Thorsten Blum wrote:
> Use max() instead of max_t() since zstd_cstream_workspace_bound() and
> zstd_dstream_workspace_bound() already return size_t and casting the
> values is unnecessary.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: David Sterba <dsterba@suse.com>

