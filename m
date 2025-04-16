Return-Path: <linux-kernel+bounces-605122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2595DA89D08
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 14:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663241891D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8525292903;
	Tue, 15 Apr 2025 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HIbbN4Fa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sLcpf5hA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HIbbN4Fa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sLcpf5hA"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5102750F2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744718452; cv=none; b=kZwgR1l82LWvyxRPwrIGRM4yescZU9c+xTDq86LdOwku0CWP5TT1BxTxLMzr53v2mXOSvZTVgbdFOpffTqN9Xdh2u/Bz7TcjqrtWJ//6+2xBXiUhTVAwYQaOCBAczASt4u5xzkqZLykYjM4cntsLViWRmUoaYXKdSBy2lI1gDn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744718452; c=relaxed/simple;
	bh=CGxfHBl6a2Berpe+DXb/rQbNeEkIU1c3eJPLFNzC9ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soS82iutO9ZJ747AcT7fl3getVBhb/u+SWF0gbXLU/ec1Cu2JypvKJEDuLKQbRRiVFUdPtCwyW9nlw12zzJSW0RRX+63YM29M37NMuCXELI2Sk/YHgRwG9sL6CLl3HzzCBLl4NkcTuTwIfmY/cPLQNREKWBWbDJvK/w3WpEk+Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HIbbN4Fa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sLcpf5hA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HIbbN4Fa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sLcpf5hA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53F4E1F385;
	Tue, 15 Apr 2025 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744718448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIYACVzH95X7MM4tbWT0wTSgKJd6vp8NHMKWqgVgJMA=;
	b=HIbbN4FabSCFbUCTFfy1BcdNReLGit4sWPpQUvbRUXA5d1NX5o3v+fLo2tZQYd+2tNXpnp
	8Buq0KQMipvqSGmkLIUhp19p5e9Gm7t4BlRN06tRfW8BXX8rLeYLja9tDAfr5oe5GUZ3zA
	fVQ1G4y+RWHfqm2vn66pR7T9/dJOg2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744718448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIYACVzH95X7MM4tbWT0wTSgKJd6vp8NHMKWqgVgJMA=;
	b=sLcpf5hA+SaX/LDXTmsDT4ur6R/Ns3gGP4isqUUS5egZTTR73/HJA36gVAiImTAyaEQEiw
	7nZRiW5xtP6rGjBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744718448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIYACVzH95X7MM4tbWT0wTSgKJd6vp8NHMKWqgVgJMA=;
	b=HIbbN4FabSCFbUCTFfy1BcdNReLGit4sWPpQUvbRUXA5d1NX5o3v+fLo2tZQYd+2tNXpnp
	8Buq0KQMipvqSGmkLIUhp19p5e9Gm7t4BlRN06tRfW8BXX8rLeYLja9tDAfr5oe5GUZ3zA
	fVQ1G4y+RWHfqm2vn66pR7T9/dJOg2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744718448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIYACVzH95X7MM4tbWT0wTSgKJd6vp8NHMKWqgVgJMA=;
	b=sLcpf5hA+SaX/LDXTmsDT4ur6R/Ns3gGP4isqUUS5egZTTR73/HJA36gVAiImTAyaEQEiw
	7nZRiW5xtP6rGjBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 351A0139A1;
	Tue, 15 Apr 2025 12:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gun6C3BK/md3CgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 15 Apr 2025 12:00:48 +0000
Date: Tue, 15 Apr 2025 14:00:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com, 
	Mohamed Khalfella <mkhalfella@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Message-ID: <81f06615-2037-4177-b38e-d67c8e7ca95b@flourine.local>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <e8264916-ca27-4a3a-8006-a6e348282fc3@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8264916-ca27-4a3a-8006-a6e348282fc3@suse.de>
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, Apr 01, 2025 at 11:37:29AM +0200, Hannes Reinecke wrote:
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -2345,6 +2345,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
> >   	nvme_stop_keep_alive(ctrl);
> >   	flush_work(&ctrl->async_event_work);
> > +	nvme_schedule_failover(ctrl);
> >   	nvme_tcp_teardown_io_queues(ctrl, false);
> >   	/* unquiesce to fail fast pending requests */
> >   	nvme_unquiesce_io_queues(ctrl);
> > 
> Hmm. Rather not.
> 
> Why do we have to have a separate failover queue?

This RFC plays with the idea to handle the request which timeout on
ctrl level. The main point is to avoid touching every single transport.

An additional failover queue is likely to introduce new problems and
additional complexity. There is no free lunch. So I don't think it's a
good concept afterall.

And as discussed during LSFMM I think it would best to focus on factor
out the common code (the project I wanted to work on for a while...)
from the transports first and then figure out how to get the CQT, CCF
working.

> Can't we simply delay the error recovery by the cqt value?

Yes and no. As we know from our in house testing, it fixes the problem
for customers but it is not spec compliant.

