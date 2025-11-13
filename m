Return-Path: <linux-kernel+bounces-899926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FD5C59215
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDEA3B1720
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400433624DA;
	Thu, 13 Nov 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AEywdnIK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OESjJwnj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qur/PDel";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fDqTZrHM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9EC3624D2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053072; cv=none; b=au1jFyff9pTgbBL/WbNZtIliFHrSADN+gfoD1f9rhCwDDEI5LjJu321kSHnjjzia8ALnK8t87nRf++cKlBUEU8OSpgig7EsuGqJYDMrfiWNgG8l/cIUoZeiIidlGWqfmXtrJeY34AZ1PnHh73qs63Igu6l7SSJXSqDnr5lgVLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053072; c=relaxed/simple;
	bh=KaLUBv4Ikg93l0ZMEEuvxSi+1r10ydy0dDWKp/y3GVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kivY3MaX6DwIROzbSym8B8AHNsKE6oAw85fZkqRzDlywBnq2TG4nLZ+5KhKZCme2aEG04XsGrNTUT6QmJ0UoMePf6t6FB5peSz40Lr/LuY43CJyvCd1K4KAt2SODY9DYvq73U5MOgPMaQrJ2m3zQctWgjOPvZ4zkaIUFAmABsoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AEywdnIK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OESjJwnj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qur/PDel; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fDqTZrHM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 545D71F449;
	Thu, 13 Nov 2025 16:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763053068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTCbrUfTP9d/K0a+blntLQtIjeHzDVEspbGQ29js3Fo=;
	b=AEywdnIKWcBy9JWvsjEUU35PEF35jxpc2jdpK/le7QCOtnPj2v/kZrbtdiZjxav0nqLMPh
	SG7jW5oZ2Un4ip9aGsWG0FCMWuaynenpX5j5oKOp2LCq4fvFckrZ7YtUrmqqJnRzeyu9QJ
	CHxLFO9h7Zj0B6ejKGQ/F6k1PVvXjbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763053068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTCbrUfTP9d/K0a+blntLQtIjeHzDVEspbGQ29js3Fo=;
	b=OESjJwnjjOfDfrqOirI9MQ/Q9zW8tvjuho/CJJVHMejpA6tsmzqEmzgx2sJF+5e6IfQDLx
	8wle4CG/3ke2c3DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Qur/PDel";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fDqTZrHM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763053067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTCbrUfTP9d/K0a+blntLQtIjeHzDVEspbGQ29js3Fo=;
	b=Qur/PDeljgQMw1mQhLoccPWYJqi6uKcustAdpsIT8xHsPFrw42BKTPsksG4U680TXmPrwC
	7fx08X6VQEMC1IfiIv/LglvpSXR0mBt17mbhuK0g1s9WwfSvEuwxvThvZRncWsVlry+lys
	j3fqhxH8JNaghKwW9cc4jn6V1PEiyFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763053067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTCbrUfTP9d/K0a+blntLQtIjeHzDVEspbGQ29js3Fo=;
	b=fDqTZrHMu4op/WM8I+Qgqs3Nl1CEWnEk/3p2ADLfGiMMQA8112e8cpr7SNfj3+qgU8QP+U
	7QWZrlERFfarzWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 275CF3EA61;
	Thu, 13 Nov 2025 16:57:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xlmkBwsOFmlTOAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Thu, 13 Nov 2025 16:57:47 +0000
Date: Thu, 13 Nov 2025 17:57:45 +0100
From: Jean Delvare <jdelvare@suse.de>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/cma: Remove CONFIG_CMA_SYSFS option
Message-ID: <20251113175745.2e29afe7@endymion>
In-Reply-To: <73552a22-c7c8-4106-949e-471b9a7bbc87@kernel.org>
References: <20251113145636.731a24e4@endymion>
	<73552a22-c7c8-4106-949e-471b9a7bbc87@kernel.org>
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
X-Rspamd-Queue-Id: 545D71F449
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01

On Thu, 13 Nov 2025 16:35:03 +0100, David Hildenbrand (Red Hat) wrote:
> On 13.11.25 14:56, Jean Delvare wrote:
> > The sysfs interface to CMA has a marginal runtime cost and a small
> > footprint, there's no reason not to include it in all kernels where
> > the dependencies are satisfied.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > ---
> > As discussed with David:
> >    https://lkml.org/lkml/2025/8/6/371  
> 
> Thanks for the reminder, it sounded familiar but I couldn't remember 
> when this was discussed.
> 
> Hoping this was properly compile-tested :)

Yes of course, I build-tested with both CONFIG_SYSFS=y and CONFIG_SYSFS
disabled.

> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

Thanks,
-- 
Jean Delvare
SUSE L3 Support

