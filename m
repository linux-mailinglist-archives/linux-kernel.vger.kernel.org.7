Return-Path: <linux-kernel+bounces-884234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9A9C2FB36
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A86E4E82BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1941B87EB;
	Tue,  4 Nov 2025 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XxGGkISb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QR/gR4q7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jAXeZgq1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yWdkXekp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12760309EFE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242128; cv=none; b=rUZQw8obq8aOttTPD1YXKx498w75mLMgKqTVD/5y5jENOBR9m7N/gnRPyfHtvgXXp9kIA33R9hIWkC20r5ovKe9MNBqV5uh3d3GxE/UswV7qRKntkoJHihFu8uJhW7cJptq4eEDi714WjT9PEF8tG1IidmfvDeEssc8nHsDNmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242128; c=relaxed/simple;
	bh=yUm3MVUcsroOQ0YgDcvh+ePbtms1poKeUGEja3Lc1dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzzCpvw2/rW0/g77vrhXdv/qi1I1oprMxnj7x3zUnAg63DHFCHpSzh6Ux289QTNR4dbBCXnGOzH9p69t500VvB6OwW0gTpaYTkxef9gp0dE6QtKBwxHrrEQ3mmz7JR0S1/QV5Adl3+Ti3TSO5sbjHaIuJZ5ZAK8C0GBkp0huBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XxGGkISb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QR/gR4q7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jAXeZgq1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yWdkXekp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EECDD211B5;
	Tue,  4 Nov 2025 07:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762242125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mb/Kfdx4NePlvgrSU+TgWyJ54sHSQ5zy2PI/ESd5AYo=;
	b=XxGGkISbrGRGewd2uPilFvllU8gnsqjqyhPsdLhDF8LKR0Wd/eoBSZEGbZTH2ykdaECgpS
	uhvu7PviZm8hZvqboTskKp0QPVy3xSeVOyblCLUcXUIgo3za6xlLegUWnSRdICHRrqGcfq
	xok4wrXS9+NXWc/0VzqEa4qIO6kvPd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762242125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mb/Kfdx4NePlvgrSU+TgWyJ54sHSQ5zy2PI/ESd5AYo=;
	b=QR/gR4q7oTY4pcBug1YycYEJ9Y2cjjplaTfIjL4mORtytY8afFunhiBTvT8G6wFbj7vd9a
	npjstvg9hkE9q1Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762242124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mb/Kfdx4NePlvgrSU+TgWyJ54sHSQ5zy2PI/ESd5AYo=;
	b=jAXeZgq1MAAq0aiAWzo8lH9pcOFOXPKySDVuoPJ5rxUVJ016q70U3V7WwhXNJ7kYgBLRWe
	t/PL7VHltyXfgRPMDnfphiDAmxnJEWPXvSUOMh9wDbUtplhQ+we2xPWBI729E7qxneJMI/
	p5eG9Ziui2bNIzltQMsZrIKshED8LBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762242124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mb/Kfdx4NePlvgrSU+TgWyJ54sHSQ5zy2PI/ESd5AYo=;
	b=yWdkXekpyMAIGFdrnGPKKviLPuS5qQN/Ir012Dhw4il6kKhNEBetMEuMSt9Kl+aWIVJje1
	Wyr4wdiW66j8PRCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E53B1136D1;
	Tue,  4 Nov 2025 07:42:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id upDtN0yuCWlALwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 07:42:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8A9D7A2812; Tue,  4 Nov 2025 08:42:04 +0100 (CET)
Date: Tue, 4 Nov 2025 08:42:04 +0100
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Taotao Chen <chentaotao@didiglobal.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org, 
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix a drop_nlink warning in minix_rmdir
Message-ID: <l3x2jcya7en5ow5l5u3z5ukxr6ilp7snecm5i42zs4ci2t25j6@tesly72cat3d>
References: <20251102135239.2203389-1-jkoolstra@xs4all.nl>
 <aifdv7l2aomyyjdldpmhucnujstfzadjafy2s4kjqq5ecsk2hf@q4nph7xhemrg>
 <388208404.3543067.1762176108384@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <388208404.3543067.1762176108384@kpc.webmail.kpnmail.nl>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[4e49728ec1cbaf3b91d2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[xs4all.nl];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

Hello Jori!

On Mon 03-11-25 14:21:48, Jori Koolstra wrote:
> > Looks good, just one nit below. With that fixed feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Will do. Question: I have fixed another syzbot bug report in minix_rename/unlink
> and posted the patch. I figured that because they target different syzbot
> reports, they should be separate patches. However, I forgot to add the
> EFSCORRUPTED define in that patch (but did include it in the #syz test). What is
> the best way to rectify that and add your suggestion to this patch? Or should it
> be a single patch, or a series? I want to cause as little work as possible for
> you and other maintainers.

The most natural would be to submit these two patches in a single series
since they are actually related.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

