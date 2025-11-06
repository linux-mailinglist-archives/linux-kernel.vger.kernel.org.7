Return-Path: <linux-kernel+bounces-888033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64E0C39A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753C818C1088
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFBB2D978D;
	Thu,  6 Nov 2025 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D7Kmda0G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b346HRNJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D7Kmda0G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b346HRNJ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759A1C4A13
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418835; cv=none; b=Fcn+nfHS+muDRNttXRsErTBRefFsylzmBMB1A2lvucxzigB93jaLFwuTgeKkFkJesNTRdgVB9fEmWedI/yfyNYQ5H4G6w4WqZGLykthDQab6HrCynOed2qY4IYfyu4nv19f0qtgS4EELA8XRlik+jad2hNOVYiKHvVoKSFNYZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418835; c=relaxed/simple;
	bh=KZ8Cti4lDMa+T6DgdWa3A09MNCXDCxZUIRh7q87mQxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXP0ImhG96E0pOUzlbfbn979DMqfEEE/qpdQIFtkYs55R6hbUnIZN+aRpM+vwq8N/cWpOT5nz4a0xO/mQ1wxwc/XIE+1DVaEOGzyh8McZ/z4YvOmCyCgdDuIxbuGdyxqtBaMJfHUKFV6qu3dazU51USpOg9e0PZ/MgJFFLvHqLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D7Kmda0G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b346HRNJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D7Kmda0G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b346HRNJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5BF9A1F393;
	Thu,  6 Nov 2025 08:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762418831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9JKRyZqRIzeeD2jmnhtIuap9opd/wOkmcUgyeZHF30=;
	b=D7Kmda0G3Z7SHhwzQH+EkEv8Y5m4wFUgwE875yybFFsOfsYVRdQmq5OBQ5o2Cp8rY5Mp79
	Z9UitGp/NNfdd34g1YUBEpwWTqrmr0sd3qLmZOVETnUhjrL/JDdqCSL81iBTsG9bfCvTHo
	GcUvY85XYF0CaHqbpI0PoQ3jHRMS3mQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762418831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9JKRyZqRIzeeD2jmnhtIuap9opd/wOkmcUgyeZHF30=;
	b=b346HRNJPV99Cmed5Qf0YuTSpglLJxc2xoL9ehP+c8NyfPGle8Q+9zUKwtBZTnCyEneqY3
	87xWEOeKvxbSpRBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D7Kmda0G;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b346HRNJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762418831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9JKRyZqRIzeeD2jmnhtIuap9opd/wOkmcUgyeZHF30=;
	b=D7Kmda0G3Z7SHhwzQH+EkEv8Y5m4wFUgwE875yybFFsOfsYVRdQmq5OBQ5o2Cp8rY5Mp79
	Z9UitGp/NNfdd34g1YUBEpwWTqrmr0sd3qLmZOVETnUhjrL/JDdqCSL81iBTsG9bfCvTHo
	GcUvY85XYF0CaHqbpI0PoQ3jHRMS3mQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762418831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9JKRyZqRIzeeD2jmnhtIuap9opd/wOkmcUgyeZHF30=;
	b=b346HRNJPV99Cmed5Qf0YuTSpglLJxc2xoL9ehP+c8NyfPGle8Q+9zUKwtBZTnCyEneqY3
	87xWEOeKvxbSpRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB97013A31;
	Thu,  6 Nov 2025 08:47:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uQquNY5gDGlLaQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 06 Nov 2025 08:47:10 +0000
Date: Thu, 6 Nov 2025 08:47:09 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Robert Dinse <nanook@eskimo.com>
Cc: mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Folio Related Stability Crashes in 6.17.5 and 6.17.6
Message-ID: <yd3kw6xvpq3vf6m5mjsnd76fy5fowgfytwdieohohq3wndgfia@b3in7oxevjhk>
References: <b964df0f-45e3-4fea-a84d-852869b49502@eskimo.com>
 <erytfim3m6fy7qy3tmfwwkr6ymvyfoevhwsac4xtadimei6ux5@um6ylfu5e4ci>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <erytfim3m6fy7qy3tmfwwkr6ymvyfoevhwsac4xtadimei6ux5@um6ylfu5e4ci>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5BF9A1F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01

On Thu, Nov 06, 2025 at 08:43:25AM +0000, Pedro Falcato wrote:
> On Wed, Nov 05, 2025 at 07:19:17PM -0800, Robert Dinse wrote:
> >       Since 6.17.5 I have twice had one of my servers lock up in a state
> > where it still routed network traffic and responded to pings but no user
> > programs are running.
> > 
> >      These are proceeded by kernel splats:
> >
> 
> Are you sure it didn't ever repro on 6.17.5?

s/on/before/g, obviously.

-- 
Pedro

