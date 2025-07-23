Return-Path: <linux-kernel+bounces-742155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97396B0EE13
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5340E188246E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41502283FC2;
	Wed, 23 Jul 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YeiT/rU7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jBmcLNrk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YeiT/rU7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jBmcLNrk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7B7276050
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261741; cv=none; b=YYcVPId7hhfo2/FRYEntMDMPS21Lfs9WlGVuJaEmdnQWthji8369sojueYE3P4Yjj4fPflCKvw/HcvI0GhqXxQzPsspSm4mJ+AO8gEWhzldGsAmxLCs/tC/ETzZ+1H3Z9BQwdyD66Ks1BFu/qM9NxNytrWxyvk0P6Q1HAJ9XVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261741; c=relaxed/simple;
	bh=UGlIpk7fw2tJBs2nSGjmlKEhq+U4olq2Tq9e/0HS/28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnCmEaKgUgrIhxQFqprZgeHiccIOlKTDCHsIiZVRRdm6/D2dDTgN/huSXTAO230953PwiBwZGHM34meHAoT/RTE9gD0r9o45bld4Ykl6cUyhVuVyA+VeE4ogjpPEJnZmch79HEuk5l5bHPylyndqDUQvlvO5YzjbZ2z6bF0BnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YeiT/rU7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jBmcLNrk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YeiT/rU7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jBmcLNrk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B036A1F449;
	Wed, 23 Jul 2025 09:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753261737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZ86HXKj+U1sD3fGSIbwoOwgbbHNQx55VC+m5L7A/uA=;
	b=YeiT/rU7Mq2AECRYUXA2dMhab4893cj2Kh1z58Ucc7IgyBhPjriu8GZ34TNjx6D1Pu0Rj7
	+JABaDlFKYPd+Zyo4Xzp5FcDl3ov58Z323A62OaAHPJutyvU5XdtAjZwq+eJx+zp4Lps5z
	3mK3/V/9N3i1Y43XJ3pkxX9Wvkja4Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753261737;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZ86HXKj+U1sD3fGSIbwoOwgbbHNQx55VC+m5L7A/uA=;
	b=jBmcLNrkTaZlYfeIVXKMPUCkuXXeoj0V4c/iz0TytTHhd+4IbLZmEfRvisCQGvD3kGHJUX
	ohfhuTmDUJKMDMBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="YeiT/rU7";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jBmcLNrk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753261737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZ86HXKj+U1sD3fGSIbwoOwgbbHNQx55VC+m5L7A/uA=;
	b=YeiT/rU7Mq2AECRYUXA2dMhab4893cj2Kh1z58Ucc7IgyBhPjriu8GZ34TNjx6D1Pu0Rj7
	+JABaDlFKYPd+Zyo4Xzp5FcDl3ov58Z323A62OaAHPJutyvU5XdtAjZwq+eJx+zp4Lps5z
	3mK3/V/9N3i1Y43XJ3pkxX9Wvkja4Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753261737;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZ86HXKj+U1sD3fGSIbwoOwgbbHNQx55VC+m5L7A/uA=;
	b=jBmcLNrkTaZlYfeIVXKMPUCkuXXeoj0V4c/iz0TytTHhd+4IbLZmEfRvisCQGvD3kGHJUX
	ohfhuTmDUJKMDMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3241A13302;
	Wed, 23 Jul 2025 09:08:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HHsUCammgGh/UQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 23 Jul 2025 09:08:57 +0000
Date: Wed, 23 Jul 2025 10:08:55 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] MAINTAINERS: add missing interval_tree.c to memory
 mapping section
Message-ID: <567llsbwcwl4v4awyiykqw57f4msuclwrjgp4bivbkyrygogpv@evlqgd3bza7s>
References: <20250722171528.141083-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722171528.141083-1-lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B036A1F449
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01

On Tue, Jul 22, 2025 at 06:15:28PM +0100, Lorenzo Stoakes wrote:
> This seems to be the best place for this file.

Honestly, calling this "MISC" and going on with life is also ok.
But:

> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

