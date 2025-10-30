Return-Path: <linux-kernel+bounces-878127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61463C1FD9C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCBC40722E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E013E334C15;
	Thu, 30 Oct 2025 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aqPMFx1G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1EX8X97G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aqPMFx1G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1EX8X97G"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147F26AA94
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824162; cv=none; b=axQvPl1CQPxLRMGe35jEdYAI8y2QxDVeWHjCKw39tQoIpMheX/2RqwbJihFpu3fth8b3c4uO9GFZIE6iRyFjbF8I3UbaSyfsPuDcpoFULqQKzxzyKYFmEAeYt1NGTGQcHpkC3PZBXNbiCgTR56x7WDDviEB1P3j8DaNVbiJFDTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824162; c=relaxed/simple;
	bh=D/FEHZ+W14ZcqIjTtJIACpeZx3sQupdk+kjRtCX6adA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuVWvcqtp3uhRPSnyeIkPxUkNBf66/1DPV6HGhZqHPxIb//fo/qAgTJRlJsc++2Ge2byTbooWI7fg/XO9/fLJ7RmZJ0X0mn00xX0QJQD956HksGYV3Zh3GW9Hu5PCHSgXQT7inYfeon2ba1eZ4lE/j5IVU+GqDpEKNjGzLdf9Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aqPMFx1G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1EX8X97G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aqPMFx1G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1EX8X97G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0BAF4336FF;
	Thu, 30 Oct 2025 11:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761824159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnyv1phIaMc3O0L7+mc5e385AHmoTBbBtJqSb7URAzo=;
	b=aqPMFx1GistKVBJM3HWBsjCI6QrRz0oQs+GExNqrIGTjq3MlWL39qcnAjV+gRkN1SIUgDc
	h0aGOuiarJjm2zCVooHrD3WYPzCEhW9VIfKvkb4fqtfqDfTef5wQO1mQJ/J0/asVAMKmJk
	k8XOhxLOpmvfhpMiszNQcB/ZTZij1g8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761824159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnyv1phIaMc3O0L7+mc5e385AHmoTBbBtJqSb7URAzo=;
	b=1EX8X97GHvCQEwIdcHC69KRlG6rmuPGuyEo+FRZ9KbvCZZ2E0pb5a7uuKP5WxdrNZU+hoY
	evu97F2EbO1CiuDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761824159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnyv1phIaMc3O0L7+mc5e385AHmoTBbBtJqSb7URAzo=;
	b=aqPMFx1GistKVBJM3HWBsjCI6QrRz0oQs+GExNqrIGTjq3MlWL39qcnAjV+gRkN1SIUgDc
	h0aGOuiarJjm2zCVooHrD3WYPzCEhW9VIfKvkb4fqtfqDfTef5wQO1mQJ/J0/asVAMKmJk
	k8XOhxLOpmvfhpMiszNQcB/ZTZij1g8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761824159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnyv1phIaMc3O0L7+mc5e385AHmoTBbBtJqSb7URAzo=;
	b=1EX8X97GHvCQEwIdcHC69KRlG6rmuPGuyEo+FRZ9KbvCZZ2E0pb5a7uuKP5WxdrNZU+hoY
	evu97F2EbO1CiuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9F951396A;
	Thu, 30 Oct 2025 11:35:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pkkcOZ5NA2mgcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 11:35:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 736F1A0AD6; Thu, 30 Oct 2025 12:35:58 +0100 (CET)
Date: Thu, 30 Oct 2025 12:35:58 +0100
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Christian Brauner <brauner@kernel.org>, Taotao Chen <chentaotao@didiglobal.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org, 
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Subject: Re: [PATCH] Add error handling to minix filesystem similar to ext4
Message-ID: <bjfubgishimixpldq2wohndba2ui4r6wfxzomhrdn7qucteri3@ka6tysjsu6u3>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
 <b16d9663-bf2c-41ea-a697-dc94fa2d6c1b@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16d9663-bf2c-41ea-a697-dc94fa2d6c1b@I-love.SAKURA.ne.jp>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[4e49728ec1cbaf3b91d2];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,xs4all.nl,kernel.org,didiglobal.com,brown.name,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Thu 30-10-25 20:18:07, Tetsuo Handa wrote:
> On 2025/10/30 19:59, Jan Kara wrote:
> > The patch looks ok to me but since minix filesystem driver is in the kernel
> > mostly to allow mounting ancient unix filesystems I don't quite understand
> > the motivation for adding the new mount options. Why not just fixup
> > minix_rmdir() to better handle corrupted filesystems?
> I guess that a filesystem which is not needed from boot time can be
> implemented in userspace. Can't we migrate legacy filesystems to
> fuse-based userspace implementations?

I didn't research availability / usability of a FUSE driver for minix but
if there's working userspace alternative, deprecating the kernel driver is
certainly a welcome option :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

