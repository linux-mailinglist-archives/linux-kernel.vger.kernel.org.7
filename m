Return-Path: <linux-kernel+bounces-842924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317AABBDFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8953A6745
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B6127A903;
	Mon,  6 Oct 2025 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KaxO4xqn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zyYuS0fQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KaxO4xqn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zyYuS0fQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7450E273803
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752783; cv=none; b=pMtPagFi6w7u0i7IpEp9eF1euVZYRfP+qkauPDHXsPjZXrIqQcn4EFKpEwTaMq7c5PID/0tvqni6litlytKOs4Uwbege782yzSYoiFzkxaIFl1jAvOBiEIVMQdEgt9UgUjVcu4zrEPp5hvab2X8GIkk+Pi/q7a9dJXF2/rUtwnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752783; c=relaxed/simple;
	bh=tJgr9R3Wgp/oAfFf84BmjZyFMLHIzS/cBzLD6GVfUHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZJ71b8MHJwjlqqM6AoLY6/HbUdWg8NaCk4RCRXItfTe/ixpRD1pMT8EwJwMbtEO0ifPT4mcayp6f6zvqx0fYRc2LkYn1ULMLHFZnUySy7LKRkcN0bDzl6SQSp2iG+Qns25KbRacy/s5WCXJWPcuM5WKR3r6LxZIDT5WbChfRlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KaxO4xqn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zyYuS0fQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KaxO4xqn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zyYuS0fQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D19B33771;
	Mon,  6 Oct 2025 12:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759752779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RbYTEVWJa/I0Jmvc9JTdtMIW4JnYonDMYg5KYJVrA2Q=;
	b=KaxO4xqnk8T7RjnDrSaKFZtwPzUWS91zXISItIVOEkFReRVUA+YAhRjPv9b8q0dLV0EC6S
	IWkZ1Brsyd5gT373CG/0BzKcvN67HHLCmKMuWy3fd0J0u90nkB24HXsLoRFEss/DAgBiOZ
	MohyeHwvmyFFWn3Ua4KLyHgAS6LD34k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759752779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RbYTEVWJa/I0Jmvc9JTdtMIW4JnYonDMYg5KYJVrA2Q=;
	b=zyYuS0fQh6eA03WF7ObaJ3Dj9yYyBe+b37w+dllVFy/+FDZ+iD3vT1x00YIV9Dkg6l8ILA
	wfhHbDNmQqciymAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759752779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RbYTEVWJa/I0Jmvc9JTdtMIW4JnYonDMYg5KYJVrA2Q=;
	b=KaxO4xqnk8T7RjnDrSaKFZtwPzUWS91zXISItIVOEkFReRVUA+YAhRjPv9b8q0dLV0EC6S
	IWkZ1Brsyd5gT373CG/0BzKcvN67HHLCmKMuWy3fd0J0u90nkB24HXsLoRFEss/DAgBiOZ
	MohyeHwvmyFFWn3Ua4KLyHgAS6LD34k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759752779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RbYTEVWJa/I0Jmvc9JTdtMIW4JnYonDMYg5KYJVrA2Q=;
	b=zyYuS0fQh6eA03WF7ObaJ3Dj9yYyBe+b37w+dllVFy/+FDZ+iD3vT1x00YIV9Dkg6l8ILA
	wfhHbDNmQqciymAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12BC913700;
	Mon,  6 Oct 2025 12:12:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T4TMAUuy42hGcQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 06 Oct 2025 12:12:59 +0000
Date: Mon, 6 Oct 2025 14:12:57 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/dirty: Replace READ_ONCE() with pudp_get()
Message-ID: <aOOySfntnNd8IyGv@localhost.localdomain>
References: <20251006055214.1845342-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006055214.1845342-1-anshuman.khandual@arm.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Mon, Oct 06, 2025 at 06:52:14AM +0100, Anshuman Khandual wrote:
> Replace READ_ONCE() with a standard page table accessor i.e pudp_get() that
> anyways defaults into READ_ONCE() in cases where platform does not override
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

