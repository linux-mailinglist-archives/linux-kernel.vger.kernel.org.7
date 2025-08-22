Return-Path: <linux-kernel+bounces-782647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78308B3231D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4911E628510
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A7E2773F6;
	Fri, 22 Aug 2025 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ykmiMHXH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8ObR4Lnm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HSCqIWow";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5IvjwtjP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F259F2BFC85
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891931; cv=none; b=HWqlWATxaLy2wk3KukZoqCoq+pUyXxhS146jVvhEk0vo0/ETii082tPXxwTGm7aJMQ4HskIwiH/rBemaY/ctk628EBPpDUYrFqtu2FnZazpXQ5xWxBOhCvsAmEyKgQA7FNKzW0+2BaGMApntFH50xQ1KpkGYNOdwEOQxD/4Irvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891931; c=relaxed/simple;
	bh=qV4phOwmGE5NrajGHke2b0uxuCpMNYBHbRitW99FBf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRc3mwvB1ta39ff05GJz98TLYQSCBF4PtPiTxqtmIKQ8nwSf7UgzB9bb6swwY5vuZa4HjLF6GNh65QJS58Xjrj9Z2NiF27MG5w+u3WOGrTu++nE2we5KHvipzHM5+3z40E9VbQJUAyXg9U/EWUDnA4mdDCARNbBHTW35U7GXrjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ykmiMHXH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8ObR4Lnm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HSCqIWow; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5IvjwtjP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out2.suse.de (Postfix) with ESMTP id 3DB4D1F385;
	Fri, 22 Aug 2025 19:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755891924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5BMf9ITNHHswVF8PEaR4ndhiHkQMiVdrHDz6mV2kqc=;
	b=ykmiMHXHLywLlKWjovo3wMuBcC9OjXvHVvce6gInHppO160d3pLS8/SrRRVF2S7uBCIXZN
	/TDKK3Q3LH4qHUP/InW/qwRBfjzf10szxomjSTez2KQEBXU/yRASH8URciJUpoWKqvaIU9
	hZh3j9+o9t62Cqm/Oy7tkjVudO1R490=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755891924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5BMf9ITNHHswVF8PEaR4ndhiHkQMiVdrHDz6mV2kqc=;
	b=8ObR4LnmFAY8qgrZNVVRXc4AEdVPIGwSTKlkycqJmnmTzBuvxefddvHRRHQOmQ2eY9lApm
	nVuNuXMXx5Ks2kCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755891923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5BMf9ITNHHswVF8PEaR4ndhiHkQMiVdrHDz6mV2kqc=;
	b=HSCqIWowAoEW7W7H1kg1QIz7YOTX/lPZC25EHLFYieanmwvbLgcy6AszKq9p7q/T6Yzsat
	2JYYFEDJ8T0Q/6lh62t5zPQC+RQ1qoZLTJWBeLDnERceL+gq+TFb7QbASvEaLm91a+PuvR
	ba6H09xtFcOLml5bcZqCaCtDkatCw/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755891923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5BMf9ITNHHswVF8PEaR4ndhiHkQMiVdrHDz6mV2kqc=;
	b=5IvjwtjPKRJF0QEu+8kUY7OpVwMJF+lH0M7tM2br3TvUvgU/iAMHD58k5fjc0nxbJtDw2g
	r/YyEoscsNhZcLBQ==
Date: Fri, 22 Aug 2025 21:45:23 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Breno Leitao <leitao@debian.org>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <aKjI0wcPDXH5mYcL@dwarf.suse.cz>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <airxp44zdyxskfwrhhveis7gd2vsz5m4f3ipidsghi2x55h64c@s37v5rkuoega>
 <aKX1vbE5jWVUr298@dwarf.suse.cz>
 <lofhq3bgtl2bcbrbkgctyyg2gl7ef2naqdrplyb37jyde2xoeh@twcwhwthnzxd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lofhq3bgtl2bcbrbkgctyyg2gl7ef2naqdrplyb37jyde2xoeh@twcwhwthnzxd>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:helo,suse.cz:email,dwarf.suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On Thu, Aug 21, 2025 at 01:35:35AM -0700, Breno Leitao wrote:
> I have another question. I assume it’s not possible to allocate only the
> CMA crashkernel area for the kdump kernel, since we need to keep the
> loaded kernel in the crashkernel area while the system is running.
> Therefore, specifying crashkernel=X (without ',cma') is necessary.

exactly

> At the same time, since the crashdump environment will use CMA, the
> crashkernel area itself doesn’t need to be very large, as the CMA space
> will be allocated later.
> 
> With that in mind, how do I find what is the recommended size for the
> crashkernel area, assuming the CMA area will be more than sufficient at
> runtime?
>
> Does it need ot be much higher than the size of kdump kernel and initrd?

I don't have a good answer now - I have this on my to-do list
and I need to investigate this more to come up with a formula to
calculate the required size to include this in the kdump tool I
maintain for SUSE. 

When testing the kernel part I used 
crashkernel=100M crashkernel=XXX,cma on a machine that would
normally require something like crashkernel=430M.

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


