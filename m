Return-Path: <linux-kernel+bounces-647034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69ABAB63BC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 09:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18FE3A4457
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 07:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13692205502;
	Wed, 14 May 2025 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZugocUIw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mLULY10B";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2C4DVa9g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N/p0pFqt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8F203706
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206295; cv=none; b=L3B31l4yCRVXsjCWWq7kjzYDWgDEpxuofJXFt5lQfyqBP9iClt1Fkxwif9BoBwDBEb65VFcjHX8qpv5uV/IgiU3lmUdM+OGIF2FvuQMDfepOs+9UY4hD7q4ZBILiA1BzBBUUuTBhyH+APWQtzy+89J8vfQL7148UadtM2uKOlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206295; c=relaxed/simple;
	bh=W+nE2bm0R538h5+mgSpvzoyhg8tnlTIiQzJEp4qhQFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxP5ExV0Bfv4oJzdeH5J3gK5yH5X5uPSZebyg2Q04CzN5BYAOLmHcR20XLn6XACraF0EFo3+IrFIys3av76/C/c4W066D15JCHdbTwq6kzan5eWqTVv7cUVa+ts03K8znfRzylJDl+3AzMU2EHCWeCLlxSZpR6cm0ibr75G+T3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZugocUIw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mLULY10B; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2C4DVa9g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N/p0pFqt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF2811F455;
	Wed, 14 May 2025 07:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747206292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aO5KB0Z/fUw5dPBp7DXtt0uD2MFjx2VrVku/p3Ic7no=;
	b=ZugocUIwRD8Y8IswqsGTU7jt6siT8+PkboLaSf6N+b97h2Nr//p2xTmtAAl+wBNFF2RcYp
	5L8xXmcCz8AiVRpLvEQalq2rvTz8CR+cagqs+za34Qn3ViX32uGu1E1ATXeXqRXyNPeun4
	u/ppqmMUEP03OLui5Rck2JXlJOMp4Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747206292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aO5KB0Z/fUw5dPBp7DXtt0uD2MFjx2VrVku/p3Ic7no=;
	b=mLULY10BmcPwkgfMWnHUMRopUL5Pq7HwpSSD6AmkO9ywDWwDy6WnjgjgNYDwI3wzgswhm+
	kewbZOqx21LH99AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747206290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aO5KB0Z/fUw5dPBp7DXtt0uD2MFjx2VrVku/p3Ic7no=;
	b=2C4DVa9g0Y0s5xfDLlsBh9qbvoqzWIh5RzE7bBq++vRNTaQ9h6DAy8n0teZe5qrhOb9Hih
	U+MxZnSBpMQT+9zCcP5+eiYX3ecBnZCZIyX0lOy2tNuahCAzE6PJh4bEQ+RnV+0JfPTsUE
	yXzsipcefgRFdR8YoVjlrZljWp0dFuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747206290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aO5KB0Z/fUw5dPBp7DXtt0uD2MFjx2VrVku/p3Ic7no=;
	b=N/p0pFqti41wdejig1qcglLCFR7VLe5/wL5Rydbn8sx/5VC7WtiF+0CEJRIbg08TScGHET
	zOWGm8JYHL5cRbDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4014137E8;
	Wed, 14 May 2025 07:04:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4CTIJZJAJGhYeQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 May 2025 07:04:50 +0000
Date: Wed, 14 May 2025 09:04:45 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Daniel Wagner <wagi@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, 
	John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] block: Remove obsolete configs BLK_MQ_{PCI,VIRTIO}
Message-ID: <a0c3a812-8a24-481c-9354-4475ac71d68b@flourine.local>
References: <20250514065513.463941-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514065513.463941-1-lukas.bulwahn@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo,suse.de:email]

On Wed, May 14, 2025 at 08:55:13AM +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 9bc1e897a821 ("blk-mq: remove unused queue mapping helpers") makes
> the two config options, BLK_MQ_PCI and BLK_MQ_VIRTIO, have no remaining
> effect.
> 
> Remove the two obsolete config options.

A quick grep revealed that there is at least a test config still in the
tree which uses BLK_MQ_VIRTIO:

drivers/gpu/drm/ci/x86_64.config
108:CONFIG_BLK_MQ_VIRTIO=y

Not sure how this is supposed to be handled.

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

