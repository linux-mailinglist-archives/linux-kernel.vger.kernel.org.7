Return-Path: <linux-kernel+bounces-778173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0EBB2E234
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CAEF586453
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB7332778E;
	Wed, 20 Aug 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sXKhSfF6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fq4P9uoN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sXKhSfF6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fq4P9uoN"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C3299AB3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706817; cv=none; b=TvSK12olPFsQ/6YWLD92ECwsgqqPKsJWP9Ek6WZDbHNvS5TSIeAUl069e6VTqSk5ft5mn2ZWCzn+7byh48LnmqeaMBAsY3EXiHfaZugPy6tXFBqsaVCF81aw0j5E47UNNynbKyWz8ZdeDcJIYwLeg1Yje7lz6TBsf+e99vnBI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706817; c=relaxed/simple;
	bh=Gg9nK7hIrqe1RzuAgr/Nwv1tKB36Fv/jz8O4Bkw6xoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YublfIv4Yb0OpHRNn/C8n6KkuBz3IMUee8Lq2n2rO+m7Oj7bOQH3Id6pOBPzfQWRnKE8L2ISzcGdl7+yNyo1KREfE66AE5983n9ykykFQVj6Fqq6+xxXQjsanVukeljMFE7V4rHHqbWVCeBFiMMM5Wr9pFGGEkf6SVwrfNh+FU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sXKhSfF6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fq4P9uoN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sXKhSfF6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fq4P9uoN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out2.suse.de (Postfix) with ESMTP id C1D7B1F83B;
	Wed, 20 Aug 2025 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755706813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of0EpYZMc60tijt952hk19vL2Z+k8maUSxNdRLvEe+I=;
	b=sXKhSfF60sU0oyczH2gIBe1RzsaWIYhAMs8FqjfzZB1781Z0mUmc3VTrLtBHyCQXhpIQbT
	dcYqBqdyktFou9LdN2fUP8+U7paXKyzkqKBLDU0cqU90JnlKAX+GOtOIRQWGpFMWONhV1U
	PTM2zJ6XBSO0FolyZTcXpMRT3C1KyEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755706813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of0EpYZMc60tijt952hk19vL2Z+k8maUSxNdRLvEe+I=;
	b=Fq4P9uoNy2MFtajWD5ryUxhCby68I3EkKpRKY0/jKmM3TEQ/6Znt+jZnyg2YdAhKRjHKiS
	ik6VcvZ6yBAHYTCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755706813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of0EpYZMc60tijt952hk19vL2Z+k8maUSxNdRLvEe+I=;
	b=sXKhSfF60sU0oyczH2gIBe1RzsaWIYhAMs8FqjfzZB1781Z0mUmc3VTrLtBHyCQXhpIQbT
	dcYqBqdyktFou9LdN2fUP8+U7paXKyzkqKBLDU0cqU90JnlKAX+GOtOIRQWGpFMWONhV1U
	PTM2zJ6XBSO0FolyZTcXpMRT3C1KyEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755706813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of0EpYZMc60tijt952hk19vL2Z+k8maUSxNdRLvEe+I=;
	b=Fq4P9uoNy2MFtajWD5ryUxhCby68I3EkKpRKY0/jKmM3TEQ/6Znt+jZnyg2YdAhKRjHKiS
	ik6VcvZ6yBAHYTCw==
Date: Wed, 20 Aug 2025 18:20:13 +0200
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
Message-ID: <aKX1vbE5jWVUr298@dwarf.suse.cz>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <airxp44zdyxskfwrhhveis7gd2vsz5m4f3ipidsghi2x55h64c@s37v5rkuoega>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <airxp44zdyxskfwrhhveis7gd2vsz5m4f3ipidsghi2x55h64c@s37v5rkuoega>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Hi Breno,

On Wed, Aug 20, 2025 at 08:46:54AM -0700, Breno Leitao wrote:
> Hello Jiri,
> 
> First, thank you for making this change; it’s very helpful.
> I haven’t come across anything regarding arm64 support. Is this on
> anyone’s to-do list?

Yes, I plan to implement this at least for ppc64, arm64 and s390x,
hopefully in time for 6.18.

Regards,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


