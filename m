Return-Path: <linux-kernel+bounces-886583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC70C36015
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09213A71DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93881A9FB6;
	Wed,  5 Nov 2025 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZAgnZp1b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jco2c2Ts";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZAgnZp1b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jco2c2Ts"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83312CDBE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352184; cv=none; b=MuOT3IGeNa0xtv7ueeDrV9CDR+9deavfM0KCHklXzTQUzNzK3fj5s0VGuiAC/4h/5bqUDIsO8sVyZE0iIAoZrC+NaS8jVNXkuACpYFBKgEikqc7BldkfOj2g72n2wL08FThDQsWx47KEkTt4tPpRlU81k6AyikPNaSKaXNUvmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352184; c=relaxed/simple;
	bh=wCHN5H9mchP1y9fkZJjQxB8pWxo4aGOEsmVIwaBLFLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnGf7/ng7YFZ85rmMSpUBF4od+FN5Md2IM6BLAWteZzeIOp/6Rvit1IVkM1h8hYaVycdoDcNVwHidNzHtJEjjCBw49xA619e6jHGHW+BBdELmIv6QEphSyVPK2sFn3Jth2KwRKXh2S8fovdiilqQEYeXry6xvM7SHhhNTEEjTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZAgnZp1b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jco2c2Ts; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZAgnZp1b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jco2c2Ts; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F0D11F443;
	Wed,  5 Nov 2025 14:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762352180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxijTgwj4qu/PtpAhpALHtZ5gBcQ08IIOzs5scz9wAA=;
	b=ZAgnZp1beMCDQuPib8hLvJz5oCykZmr6ck6Ej/Nhdxtb+z+12++QaMDxGcyG/L3DJn2yl2
	tqa/wT8kM3RDINdiMAua9A1d74/H2TpsRoLEJ3ycvxFUEqse0CnvV9W/ewuK17MdpJOgLx
	9FZykxZ9cikAYKOERiwE9l85Hw7cOR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762352180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxijTgwj4qu/PtpAhpALHtZ5gBcQ08IIOzs5scz9wAA=;
	b=jco2c2TsE1GvQjlBUxLKyXGvVE4Ef/jz0HVJ8IitvIor3aznOWSQ7I+FaCIdZMwU43atBk
	Spa1RB0ytSTVoPDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762352180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxijTgwj4qu/PtpAhpALHtZ5gBcQ08IIOzs5scz9wAA=;
	b=ZAgnZp1beMCDQuPib8hLvJz5oCykZmr6ck6Ej/Nhdxtb+z+12++QaMDxGcyG/L3DJn2yl2
	tqa/wT8kM3RDINdiMAua9A1d74/H2TpsRoLEJ3ycvxFUEqse0CnvV9W/ewuK17MdpJOgLx
	9FZykxZ9cikAYKOERiwE9l85Hw7cOR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762352180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxijTgwj4qu/PtpAhpALHtZ5gBcQ08IIOzs5scz9wAA=;
	b=jco2c2TsE1GvQjlBUxLKyXGvVE4Ef/jz0HVJ8IitvIor3aznOWSQ7I+FaCIdZMwU43atBk
	Spa1RB0ytSTVoPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEBAF13A88;
	Wed,  5 Nov 2025 14:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q5rPLzNcC2kzQAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 05 Nov 2025 14:16:19 +0000
Date: Wed, 5 Nov 2025 15:16:18 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH v4 0/2] mm/hugetlb: refactor sysfs/sysctl interfaces
Message-ID: <aQtcMkivdFHbW2lK@localhost.localdomain>
References: <cover.1762310125.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762310125.git.zhuhui@kylinos.cn>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Wed, Nov 05, 2025 at 10:42:42AM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> The hugetlb.c file has grown significantly and become difficult to
> maintain. This patch series extracts the sysfs and sysctl interface
> code into separate dedicated files to improve code organization.
> 
> The refactoring includes:
> - Patch 1: Extract sysfs interface into mm/hugetlb_sysfs.c
> - Patch 2: Extract sysctl interface into mm/hugetlb_sysctl.c
> 
> No functional changes are introduced in this series. The code is moved
> as-is, with only minor formatting adjustments for code style
> consistency. This should make future maintenance and enhancements to
> the hugetlb subsystem easier.
> 
> Testing: The patch series has been compile-tested and maintains the
> same functionality as the original code.
> 
> Changelog:
> v4:
> According to the comments of David Hildenbrand, add copyright of
> hugetlb.c to hugetlb_internal.h, hugetlb_sysctl.c and hugetlb_sysfs.c.
> v3:
> According to the comments of SeongJae Park, updated MAINTAINERS to
> add new files.
> Removed the wrong copyright in hugetlb_internal.h.
> v2:
> According to the comments of David Hildenbrand, removed the wrong
> copyright in the file headers.
> 
> Hui Zhu (2):
>   mm/hugetlb: extract sysfs into hugetlb_sysfs.c
>   mm/hugetlb: extract sysctl into hugetlb_sysctl.c

I am replying here as a response to https://lore.kernel.org/linux-mm/58d3c50f-2b4a-4053-a846-613434d5bcd9@redhat.com/T/#mf694af3f5a6ca56b76adf66352cbb88d022fe36c

So, taking a look at patch#1 as an example,which moves sysfs stuff into hugetlb_sysfs.c.
I have the feeling we are moving too much stuff. It is true that drawing a line
is not easy, but e.g: you mention

The following components are moved to mm/hugetlb_sysfs.c:
- hugetlb page demote functions (demote_free_hugetlb_folios,
  demote_pool_huge_page)

I __think__ that moving demote_store() into hugetlb_sysfs.c is fine, but although
demote_pool_huge_page and demote_free_hugetlb_folios are only called from there,
they look more than a sysfs interface and more like hugetlb generic code.

Again, drawing a like might be difficult, but I think that e.g: we should only move
sysfs entry points functions into hugetlb_sysfs.c

Does that make sense?
 

-- 
Oscar Salvador
SUSE Labs

