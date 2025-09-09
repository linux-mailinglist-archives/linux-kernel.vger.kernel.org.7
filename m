Return-Path: <linux-kernel+bounces-808150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065FCB4FAD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D83A18809C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE79337684;
	Tue,  9 Sep 2025 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p+NfiNmg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4jDLiLI7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p+NfiNmg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4jDLiLI7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5405F23ABB3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420981; cv=none; b=G98vQ0YA2fOQCTSJE9BuAv3hzv4pQNlrTJXvZ+Tx4imTQDZNazZWRaOylIX+y8y2pRsqEWxQj/rMBfMj600LYhsCtoTdqQkFJeErzHMw3MFQXICPzSbqifFzO228vrQbF9mIUBUaXRcasExaZFEYV9EMrFMwB4ANvu0SkocIjWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420981; c=relaxed/simple;
	bh=Ka59ykaPW+MKDvKTX83Y6tNA1ic0Se9zGgz8nQfnpS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWIkBqq6uzsJRFxXFBk64Th2pbxAjEt2wPxdI2U44J3k5/SSdO1uhiKN4sVyI/asqrx49TQ3IwHxORKKCR7w+oEKX+ro19BRfNZtNfWMvEHAwhcvjZdMCkA2v/azUywkx6QfWIFPDFYwDhQSuqqpY1ZG4gZtV4nFkDcGBltuaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p+NfiNmg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4jDLiLI7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p+NfiNmg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4jDLiLI7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CF962A610;
	Tue,  9 Sep 2025 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757420977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RA3OSl7wMdLOgZRMDC7dY66FMH8ogo6BWB6QlPmnqFI=;
	b=p+NfiNmgJ0TY7j4tNFRlmO8d6JY1jV/OC7M9f6wWmZj31u7taAxUSF9nAquLGxbfTYrxuo
	AAHq1SiyqEX90oYhCKWTAMvguCRGyhK+6zMTjcQLnRIPXlW3j3D12ny31nbqAsUnYGzlu+
	fJdzV5QPweXAmp88C9DT82P9wbBENm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757420977;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RA3OSl7wMdLOgZRMDC7dY66FMH8ogo6BWB6QlPmnqFI=;
	b=4jDLiLI7pga/yx8KNekLXvF1VYbgr9ekQsLk6L/bj9ytAMiNTY4RMHIXOgGCNAu+4kXfqV
	enbmnnyQrlz6BADg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=p+NfiNmg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4jDLiLI7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757420977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RA3OSl7wMdLOgZRMDC7dY66FMH8ogo6BWB6QlPmnqFI=;
	b=p+NfiNmgJ0TY7j4tNFRlmO8d6JY1jV/OC7M9f6wWmZj31u7taAxUSF9nAquLGxbfTYrxuo
	AAHq1SiyqEX90oYhCKWTAMvguCRGyhK+6zMTjcQLnRIPXlW3j3D12ny31nbqAsUnYGzlu+
	fJdzV5QPweXAmp88C9DT82P9wbBENm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757420977;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RA3OSl7wMdLOgZRMDC7dY66FMH8ogo6BWB6QlPmnqFI=;
	b=4jDLiLI7pga/yx8KNekLXvF1VYbgr9ekQsLk6L/bj9ytAMiNTY4RMHIXOgGCNAu+4kXfqV
	enbmnnyQrlz6BADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DFCA1388C;
	Tue,  9 Sep 2025 12:29:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aOFgBrEdwGjHSQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 09 Sep 2025 12:29:37 +0000
Date: Tue, 9 Sep 2025 14:29:36 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] nvmet-fc: fixes for blktests tests
Message-ID: <4de56010-25fb-400c-ac44-c21ebc6d58b0@flourine.local>
References: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 2CF962A610
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On Tue, Sep 02, 2025 at 12:21:59PM +0200, Daniel Wagner wrote:
> I've added the other two patches I've recenetly send out to this series
> for getting blktests with FC more stable. So this series containts all
> the latest versions of the patches flying around.
> 
> What is missing are the changes for nvme/041. These patches need some
> more work and more review.

ping

