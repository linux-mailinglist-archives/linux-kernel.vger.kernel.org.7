Return-Path: <linux-kernel+bounces-822858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 011E5B84D87
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6CF7B9597
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E10C30BB98;
	Thu, 18 Sep 2025 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XXE4Ghsx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/5JvUO01";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XXE4Ghsx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/5JvUO01"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C9308F03
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202104; cv=none; b=CEm0CowWTB53mta8sBQGnEi8Yj8lNzDiD2dr0T49kqYddqzwSX0HoRA/v/jwcoQxsvJ737DhDAx6jTG79TAzppwrgiL6cGvgCYDVQ/tXbnnNFYM9lQRr8C7+nunGJwlk5fvODwSd8NWhdpEDlKjYhYbEWOUKBoprtonkCcEA2U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202104; c=relaxed/simple;
	bh=OHtr/GLIQSfiUyRZw9TngOUNCYePPYI56QWNccfYxr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrXbwzUfDDyQnK/ubDYhm2MHy/XFkmvZPBM+8OOGXaVRsiIEfxtGD0JclavuKs7EMV/bl2IMBCMZ2NJRzi3RaTqDZ/65JCEIukeHYq+2xl5GQfltAd+jtuZC9shKH97NVw7v015a2By/FqQqXvNMwCHaQADIzyvLx5x0rJWiKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XXE4Ghsx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/5JvUO01; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XXE4Ghsx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/5JvUO01; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 000611F793;
	Thu, 18 Sep 2025 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758202101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xm9X1U5lwGO/ypkag3EDrIMMEEF0BDQGAkYPjCwoAJ4=;
	b=XXE4GhsxG8OSG49egkHLGq+vQn6+l0MlN41O5i91wWAln7+JpMHOjmEKuy+v7OQBgduEvB
	/v3ZDIGb3oceVgM5XQM8Iq0mEfrJ9J2MIzK+adL3IuXo5ZiKO8W02Ujnzd9CrdiEXGjsDw
	kEF+U9unVx3lYCvAve7oI4EO5N0JQUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758202101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xm9X1U5lwGO/ypkag3EDrIMMEEF0BDQGAkYPjCwoAJ4=;
	b=/5JvUO01Wysy6NkRzT32nayJe74BjRmg4EkwDOYA6mxNa4XV1UWpJMNt/CmC+ckkm6bXdS
	VQ/5YVOCs/c8vvAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758202101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xm9X1U5lwGO/ypkag3EDrIMMEEF0BDQGAkYPjCwoAJ4=;
	b=XXE4GhsxG8OSG49egkHLGq+vQn6+l0MlN41O5i91wWAln7+JpMHOjmEKuy+v7OQBgduEvB
	/v3ZDIGb3oceVgM5XQM8Iq0mEfrJ9J2MIzK+adL3IuXo5ZiKO8W02Ujnzd9CrdiEXGjsDw
	kEF+U9unVx3lYCvAve7oI4EO5N0JQUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758202101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xm9X1U5lwGO/ypkag3EDrIMMEEF0BDQGAkYPjCwoAJ4=;
	b=/5JvUO01Wysy6NkRzT32nayJe74BjRmg4EkwDOYA6mxNa4XV1UWpJMNt/CmC+ckkm6bXdS
	VQ/5YVOCs/c8vvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AC1513A39;
	Thu, 18 Sep 2025 13:28:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ea16A/QIzGiNLwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 18 Sep 2025 13:28:20 +0000
Date: Thu, 18 Sep 2025 15:28:18 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Donet Tom <donettom@linux.ibm.com>, akpm@linux-foundation.org,
	clm@meta.com, Jonathan.Cameron@huawei.com,
	alison.schofield@intel.com, dakr@kernel.org, dave.jiang@intel.com,
	gregkh@linuxfoundation.org, kamezawa.hiroyu@jp.fujitsu.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rafael@kernel.org,
	ritesh.list@gmail.com, yury.norov@gmail.com, ziy@nvidia.com
Subject: Re: [PATCH] drivers/base/node: Fix double free in register_one_node()
Message-ID: <aMwI8n2-w1J_AOiD@localhost.localdomain>
References: <20250918054144.58980-1-donettom@linux.ibm.com>
 <5512b1b6-31f8-4322-8a5f-add8d1e9b22f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5512b1b6-31f8-4322-8a5f-add8d1e9b22f@redhat.com>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,linux-foundation.org,meta.com,huawei.com,intel.com,kernel.org,linuxfoundation.org,jp.fujitsu.com,vger.kernel.org,kvack.org,gmail.com,nvidia.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On Thu, Sep 18, 2025 at 07:55:07AM +0200, David Hildenbrand wrote:
> Yes, that matches what other users (staring at mm/memory-tiers.c) do.
> 
> I wonder if we should just inline register_node() into register_one_node().
> 
> Then it's clearer that we perform a put_device() already in there.
> 
> On top of that, we could then just s/register_one_node/register_node/
> 
> And then we could do a similar cleanup for unregister_one_node /
> unregister_node where I don't consider the split function really valuable.

Yap, that makes sense to me as well.

 

-- 
Oscar Salvador
SUSE Labs

