Return-Path: <linux-kernel+bounces-850549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D74BD3269
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93A084F16B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB442F547F;
	Mon, 13 Oct 2025 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rqCxKiS/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jXjc+Sjk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rqCxKiS/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jXjc+Sjk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D662FDC3C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361160; cv=none; b=Krbvlc1hd4grYhHKX1hNNHDnyJ0o0L6hug0WwiFfY0m11unLS3j9PG758SMJiw4rwHpCtEvCvz2YjWSdruHAfvqu7QIxyjWVQnj7zHD1bHO7td/GA3sx2RFv/ECf41T1j1a4x6fiWzTV08L/HqUQfgjGLxZoWmq0B87/oKWsAlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361160; c=relaxed/simple;
	bh=rsrkkHNVmkJO6KjR1KnF9I+uM5AkIZFSZtnjgzFeh5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRf0LT/lTlYK3Cvn7QQASIbF5oWZKbqahnDNwaDONuIE9btu29CetBMlgXl77nH+2XO9qv5eqCQp2XFfY+BoUKyH91sYsn5HcoJHOx3aWCXIGTnMuD3r3wfLavqy5I1qJE64QjLoLhxxzCuRCoyLfrWXf4MEwXVfDLhR/Q5a7So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rqCxKiS/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jXjc+Sjk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rqCxKiS/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jXjc+Sjk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 565F91F452;
	Mon, 13 Oct 2025 13:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760361156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUuAPVpZLv5x/RKRQlcJZBDq3mhfpECuNYSEtNn/MgM=;
	b=rqCxKiS/Gn/U+/YMsS/R3qNyYIrVdOukE/Q+IHbjUjPlgkZYtcHDm7y4Izu5HwP3M+MqLi
	aCTeDwOwZeIR06C854gj16lDtM337Djb2K4k8osZ6mEomFBe+wfSFKA8v8fp55FR7K3gh6
	qtUzvNHRjUakX9YLkijfyXooBZ6YfSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760361156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUuAPVpZLv5x/RKRQlcJZBDq3mhfpECuNYSEtNn/MgM=;
	b=jXjc+SjkQ3ffSxzkSe80xw4TRLPiLMIKD5GwQMLBqW9fpa9w4q7F2SjSIEw0USCypEwamj
	VW/kTlKX5FA4RiCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760361156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUuAPVpZLv5x/RKRQlcJZBDq3mhfpECuNYSEtNn/MgM=;
	b=rqCxKiS/Gn/U+/YMsS/R3qNyYIrVdOukE/Q+IHbjUjPlgkZYtcHDm7y4Izu5HwP3M+MqLi
	aCTeDwOwZeIR06C854gj16lDtM337Djb2K4k8osZ6mEomFBe+wfSFKA8v8fp55FR7K3gh6
	qtUzvNHRjUakX9YLkijfyXooBZ6YfSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760361156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUuAPVpZLv5x/RKRQlcJZBDq3mhfpECuNYSEtNn/MgM=;
	b=jXjc+SjkQ3ffSxzkSe80xw4TRLPiLMIKD5GwQMLBqW9fpa9w4q7F2SjSIEw0USCypEwamj
	VW/kTlKX5FA4RiCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4A4B1374A;
	Mon, 13 Oct 2025 13:12:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pHwrMcP67Gg+TAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 13 Oct 2025 13:12:35 +0000
Date: Mon, 13 Oct 2025 15:12:34 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, muchun.song@linux.dev,
	akpm@linux-foundation.org, broonie@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] hugetlbfs: check for shareable lock before calling
 huge_pmd_unshare()
Message-ID: <aOz6wqdZcEY8-ufB@localhost.localdomain>
References: <20251013093337.4432-1-kartikey406@gmail.com>
 <bab3249a-d9f2-4f19-9493-b7560aecc3ce@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bab3249a-d9f2-4f19-9493-b7560aecc3ce@redhat.com>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[f26d7c75c26ec19790e7];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Mon, Oct 13, 2025 at 11:54:00AM +0200, David Hildenbrand wrote:
> On 13.10.25 11:33, Deepanshu Kartikey wrote:
> > Hi David,
> > 
> > That makes a lot of sense - moving the assertions after the early return
> > checks is cleaner since the locks are only needed when actual unsharing
> > work happens.
> > 
> > Should I send a v5 with your suggested change?
> 
> Let's wait if the hugetlb maintainers have any preference.

Yes, now that I look again I think your suggestion makes more sense and
its much cleaner :-)

 

-- 
Oscar Salvador
SUSE Labs

