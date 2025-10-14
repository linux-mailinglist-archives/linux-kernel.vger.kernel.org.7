Return-Path: <linux-kernel+bounces-852225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B38BD87BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702623AEBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB6C2EA74C;
	Tue, 14 Oct 2025 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1H3IgPc3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k2mPwc/Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1H3IgPc3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k2mPwc/Q"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F72E7BD3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434889; cv=none; b=ARQjr3zMi9YpCk/j7HxnwRqIpuaosVHF13QuBAsbbQABfu+5j6ty0ClMCnj5tDv2aaZrSj2O0Gy9p+g6QPxdqTf+pDe+sNlSkHV/ekjsG/hnH7ISeJCUF0CkM8irBqZtxGQvtqN6oRJ3OCmx4T7u5IbVTq41Wso4ig2nQtcwlnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434889; c=relaxed/simple;
	bh=bdEnLJpwrOW3Ack6BQkUxN9GV7hkBb9AqeL/pEFxqLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLbSPw/6EIaK3TnmXD8oGGqp0ehwRa5ynlvmdF8SsXWdF1cN5n62luoV7HUJODWpK6REy+0ZQGj2nhEWF/IFCZvBtlSoLCEFc9nK4P3rykJqGUHmACTaXsl/wy+EJ4JKZldU9Je7vFo2Uc3/reHD5GK+waAsehe+sCAPpxojNjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1H3IgPc3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k2mPwc/Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1H3IgPc3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k2mPwc/Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A4491F7B2;
	Tue, 14 Oct 2025 09:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760434884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XoXuj8K6ZDVLY1mRyJSVSwhHzEVlf9jzE9Cln4mTonc=;
	b=1H3IgPc32utC6kfxuXukK2ocfQTMccE12b5ilIOrWLVg+H2sVRQtjGEx+r2k8EBfiwQOjx
	7zvN/D8Bqod/ny17ZO6BKf6mkN/7iTJF8kWk0fB8A5dwH369LzrmB4bMIeiZ/CH6Qe86Cp
	XGpXfD9XHdET4PD0VGsuoXMH7rXcwXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760434884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XoXuj8K6ZDVLY1mRyJSVSwhHzEVlf9jzE9Cln4mTonc=;
	b=k2mPwc/Q2dxXTz64jw8UXNBc2kONSuxaHdZ/SYdliLtsooEI5EVHulp8pLS5AGEGfV2CbU
	PzNdnhXBF0fEvYBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1H3IgPc3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="k2mPwc/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760434884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XoXuj8K6ZDVLY1mRyJSVSwhHzEVlf9jzE9Cln4mTonc=;
	b=1H3IgPc32utC6kfxuXukK2ocfQTMccE12b5ilIOrWLVg+H2sVRQtjGEx+r2k8EBfiwQOjx
	7zvN/D8Bqod/ny17ZO6BKf6mkN/7iTJF8kWk0fB8A5dwH369LzrmB4bMIeiZ/CH6Qe86Cp
	XGpXfD9XHdET4PD0VGsuoXMH7rXcwXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760434884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XoXuj8K6ZDVLY1mRyJSVSwhHzEVlf9jzE9Cln4mTonc=;
	b=k2mPwc/Q2dxXTz64jw8UXNBc2kONSuxaHdZ/SYdliLtsooEI5EVHulp8pLS5AGEGfV2CbU
	PzNdnhXBF0fEvYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3469139B0;
	Tue, 14 Oct 2025 09:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4KBmNMMa7miRWgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 14 Oct 2025 09:41:23 +0000
Date: Tue, 14 Oct 2025 10:41:18 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: correctly account old mapping after
 MREMAP_DONTUNMAP remap
Message-ID: <rtdubi5ewzrptvl25zcdg6ta46kcd6ixowaguftwo3rtmx5cz7@f4sj33igjuic>
References: <20251013165836.273113-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013165836.273113-1-lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6A4491F7B2
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -4.01

On Mon, Oct 13, 2025 at 05:58:36PM +0100, Lorenzo Stoakes wrote:
> Commit b714ccb02a76 ("mm/mremap: complete refactor of move_vma()")
> mistakenly introduced a new behaviour - clearing the VM_ACCOUNT flag of the
> old mapping when a mapping is mremap()'d with the MREMAP_DONTUNMAP flag
> set.
> 
> While we always clear the VM_LOCKED and VM_LOCKONFAULT flags for the old
> mapping (the page tables have been moved, so there is no data that could
> possibly be locked in memor), there is no reason to touch any other VMA
                        memory
> flags.
> 
> This is because after the move the old mapping is in a state as if it were
> freshly mapped. This implies that the attributes of the mapping ought to
> remain the same, including whether or not the mapping is accounted.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Looks good, thanks! Should we add a test for it?

-- 
Pedro

