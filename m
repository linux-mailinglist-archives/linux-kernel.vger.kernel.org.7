Return-Path: <linux-kernel+bounces-810244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4400EB517A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D457B2EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C531B117;
	Wed, 10 Sep 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MSd/rdoj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cWe8bxX7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MSd/rdoj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cWe8bxX7"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E88280318
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509824; cv=none; b=oHi4HHQ4IbF8/hMvCvLmVJndMUmXDFfX2u0LfzvOJID7nMTuJig8DEQOhmEA1iFEQnc9MgPVnM1j9MYGgx6umA4LPR83wcQY2yBPepNz14OOMqAp/Qyu7gQ+hImpUSiWPFAuPDvlgquNSYm1t61YC6d25sK4C67xpZtVroS+txg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509824; c=relaxed/simple;
	bh=URcr2AvWi9qCsAjFB5mM9HsH9NKagVcDD7gGqcPXsYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqzPgzjDkPX493H3QfgrGIfXqFdSWTi9KH2YUz9BFSrYSXDpRIepuWQFfC4DKrKopYbrPpCqe0be1AO5D3AwGvE6XR66Nfdb4DcUvblz8/wuyveYDKDXpUFNz/ob2NK6CB8yYF2oqvCJ64hqLl9dkHSDIgwtTgXL7VerVpFhDPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MSd/rdoj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cWe8bxX7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MSd/rdoj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cWe8bxX7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF33220153;
	Wed, 10 Sep 2025 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757509820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4hwjqp0O6NkHQyzQDGVKaUnlGbWM+Yny9R70phZ0CHc=;
	b=MSd/rdojyUhqonn2szGh795WAtRe4vVpNUcM1fnZMfgvyPVY79146G1QvRfqPdYswafanr
	ocLkbzeHhmo8/AggLo+tS2LfOZ0bIzBxZFu+eUsft9IlYgGi0vvm2yNtKfCfsoKHzea8X+
	PQ4m2UUceKh/1roujql6Es+gOw6ZFm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757509820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4hwjqp0O6NkHQyzQDGVKaUnlGbWM+Yny9R70phZ0CHc=;
	b=cWe8bxX7zPngm88WR4JbCxlYYPa8d9d6Y1GpDJdc0ajvH5TCe2wSp5jqOUrdX26xvqLYk0
	3kdxxMGi/rEEo6DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757509820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4hwjqp0O6NkHQyzQDGVKaUnlGbWM+Yny9R70phZ0CHc=;
	b=MSd/rdojyUhqonn2szGh795WAtRe4vVpNUcM1fnZMfgvyPVY79146G1QvRfqPdYswafanr
	ocLkbzeHhmo8/AggLo+tS2LfOZ0bIzBxZFu+eUsft9IlYgGi0vvm2yNtKfCfsoKHzea8X+
	PQ4m2UUceKh/1roujql6Es+gOw6ZFm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757509820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4hwjqp0O6NkHQyzQDGVKaUnlGbWM+Yny9R70phZ0CHc=;
	b=cWe8bxX7zPngm88WR4JbCxlYYPa8d9d6Y1GpDJdc0ajvH5TCe2wSp5jqOUrdX26xvqLYk0
	3kdxxMGi/rEEo6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8041013301;
	Wed, 10 Sep 2025 13:10:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pqsMHLt4wWjWCQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 10 Sep 2025 13:10:19 +0000
Date: Wed, 10 Sep 2025 14:10:17 +0100
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
Subject: Re: [PATCH v1 7/9] mm: Introduce unmap_desc struct to reduce
 function arguments
Message-ID: <ss4haln3wwk4gv62hhhdmx7tyog4dyd6auogvupm26idludj4k@abasio3iebze>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-8-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909190945.1030905-8-Liam.Howlett@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,oracle.com:email,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue, Sep 09, 2025 at 03:09:43PM -0400, Liam R. Howlett wrote:
> The unmap_region code uses a number of arguments that could use better
> documentation.  With the addition of a descriptor for unmap (called
> unmap_desc), the arguments can be more self-documenting and increase the
> descriptions within the declaration.
> 
> No functional change intended
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Neat, new helper struct just dropped!

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

