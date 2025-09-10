Return-Path: <linux-kernel+bounces-810209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD11B51745
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC271BC5406
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD7B31C57D;
	Wed, 10 Sep 2025 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BEQjhRzB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rurJ8SqK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BEQjhRzB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rurJ8SqK"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661031B83E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508714; cv=none; b=kN/L5YknHd17MSPYc7EfgFaqx6UYEoOrPDF8+IH2oLnDdfIDNV2U2NbRGf6FkQTMXxe6QYt1CzXDMu90CyAjbEhlpXSwVxUUq35Jn1thLgy1cXTWtIGUhblXlY8AlLaxkL3jADGRgp4rIg257o3gR1xLmNWpEYHUm+ab7uUgPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508714; c=relaxed/simple;
	bh=mMBx/rwYxWvNwNeWBzf11CrHvNw/4xWdHRYcPQrUMj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9y+oNLQeysSGEHJdWDNsETdtZcSdFdfFmv+9C8MgzV+xNjBiYr8LQ6zn40n5bfbZQqkh3hr89VBEQTy90JapqjUogXpPA5EfYhbcD9qO37UXExFMxjhGj6Gp8EDjxrsFYL9xV5i4Fl+TEs+50wcJOCeIefPFtHrHu10nLAg8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BEQjhRzB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rurJ8SqK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BEQjhRzB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rurJ8SqK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34EB233BBC;
	Wed, 10 Sep 2025 12:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757508710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pIJwL+vMh5l3ck0ee05Ab56qH+FWN4NOst1+i0OxjGA=;
	b=BEQjhRzB9UOagEQUB1jwY8JPKwFHrsS2euVJogIqH05KzOX5/cmV+rY4+wMae0xbXyc4QG
	39MMw9gIo08ZwB1P+PaTxDrIwlHgZZaERSZpTqm9jPVEMoJ8M/PUffoAHTdYjwP4x0bIAQ
	AGBcMnWSc7TOeY1wr23u333rThoGv4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757508710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pIJwL+vMh5l3ck0ee05Ab56qH+FWN4NOst1+i0OxjGA=;
	b=rurJ8SqKSm3tUtl+rSX7DnHzzed1vyieHCjaVK04+xrBTLhl0c+m6dlFRUvOyeuaX2XCBM
	ofdzq/mM26k8C/AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757508710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pIJwL+vMh5l3ck0ee05Ab56qH+FWN4NOst1+i0OxjGA=;
	b=BEQjhRzB9UOagEQUB1jwY8JPKwFHrsS2euVJogIqH05KzOX5/cmV+rY4+wMae0xbXyc4QG
	39MMw9gIo08ZwB1P+PaTxDrIwlHgZZaERSZpTqm9jPVEMoJ8M/PUffoAHTdYjwP4x0bIAQ
	AGBcMnWSc7TOeY1wr23u333rThoGv4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757508710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pIJwL+vMh5l3ck0ee05Ab56qH+FWN4NOst1+i0OxjGA=;
	b=rurJ8SqKSm3tUtl+rSX7DnHzzed1vyieHCjaVK04+xrBTLhl0c+m6dlFRUvOyeuaX2XCBM
	ofdzq/mM26k8C/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 047F813301;
	Wed, 10 Sep 2025 12:51:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IJTGOGR0wWgoAwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 10 Sep 2025 12:51:48 +0000
Date: Wed, 10 Sep 2025 13:51:47 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v1 1/9] mm/mmap: Move exit_mmap() trace point
Message-ID: <q6qlfs74tevbckjowf76y4fbfejr4ulyzrb4fkgq25qgebqnaf@colkcmdzt2bd>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-2-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909190945.1030905-2-Liam.Howlett@oracle.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lists.infradead.org,kvack.org,vger.kernel.org,redhat.com,oracle.com,suse.cz,google.com,suse.com,quicinc.com,huaweicloud.com,tencent.com,gmail.com,kernel.org,infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,oracle.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Tue, Sep 09, 2025 at 03:09:37PM -0400, Liam R. Howlett wrote:
> Move the trace point later in the function so that it is not skipped in
> the event of a failed fork.
> 
> Acked-by: Chris Li <chrisl@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

