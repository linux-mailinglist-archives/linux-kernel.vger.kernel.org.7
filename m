Return-Path: <linux-kernel+bounces-730413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D553B04429
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF180162663
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F27725BF00;
	Mon, 14 Jul 2025 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lYIZf8LW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XE60fYGa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HfSDwdtf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GG/1xn3x"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5A25D540
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507126; cv=none; b=rGrDBKQtFGUk2AJM1vNln+9YfDVyN7YLpLR/tdDabmyG82nLSwDihDwEMRviqtn6StfXmXLEMOe4P+lu+W2k1i4EYDniqbxNMkGky/nXGqkFRuxgqz7e9nb7rUIH5K7GldPFs2b1pkqkDu4flfswH7TiVtEI5VRIRRSDNpVFJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507126; c=relaxed/simple;
	bh=0sDXg9ihTAbqeLMgCAzibka9DJM22adnuxaexrpHDyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slk8nPJ/dhQCmaLYhBfkNrPVc9ffmmhNugTqMeNEE8yBoqorYui7xt8r8hxe9PXVrwCQBE/k6xMYGOgeWhXCLGEpHP+/jfCkrowQw1F/Hjs/4I539oqZsPF9SbNuFl7qgWtG+w/jngIA4WHd2F/gDsxpMUUb5yAxbaBF+NSm/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lYIZf8LW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XE60fYGa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HfSDwdtf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GG/1xn3x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D19871F38F;
	Mon, 14 Jul 2025 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752507122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldlagw0+7olXaG0GAUl5tIjnHmh26MDvg9oChVTsBBE=;
	b=lYIZf8LWZ/YALrk/M9bYOoLyNaRaxgIY7LqkzYf+AuNohRTjKlC+PiITyGBWe3KAPSyMnP
	XqUzStPAsVJ/ibl/OMTZCdgGoF+KQLvcXtWi4RV2ADWz7LQwLT3xKRA5zhl2saHlDr3fb0
	rtWkav/ggYqAaCwUWd7SI22Rzl9Mygs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752507122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldlagw0+7olXaG0GAUl5tIjnHmh26MDvg9oChVTsBBE=;
	b=XE60fYGa3q77Ey/sQPnX7Aqp0FkqvDrFew+WYyVrmSpnqBKQjkmZYwwv2Hq9BX6sWBRZqs
	wd0BoVDFnOiWUJBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HfSDwdtf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="GG/1xn3x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752507121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldlagw0+7olXaG0GAUl5tIjnHmh26MDvg9oChVTsBBE=;
	b=HfSDwdtfXgYXWWFbGWgDDu8MpkKH1ytTcYSTfw0+Cska5ISz9xx1fwMJDsrYJL9WiRc8ws
	Y0oLFbtX3ZQAwH4vQm4JAQjII7WjvJR7Jz/XP5W3MKZUB59UB1ldbXp+PZrvcH2Kmoxvw/
	g87rUeyH+ayfe5hdXAkLWkaoO3+1vuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752507121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldlagw0+7olXaG0GAUl5tIjnHmh26MDvg9oChVTsBBE=;
	b=GG/1xn3xwQ1+1XPOEDCmqkwPkf7uouB8wsHtOpckVmJDrhnNgkvrxKAr3W0YrowzV2uqGj
	W+jwYy9KdKNJ7zAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CA4B138A1;
	Mon, 14 Jul 2025 15:32:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uj8zA/EidWiCNwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 14 Jul 2025 15:32:01 +0000
Date: Mon, 14 Jul 2025 16:31:59 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
Message-ID: <nnm4cmygbeyzwxfwqduo5lq3d5cthuic5irof2l3tb5x43n2hz@mmjklktcfk2o>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
 <5e21df9f-7f75-412b-a173-fe6da49952e5@redhat.com>
 <b9bb8416-24a0-4bd2-97c1-055460cece23@lucifer.local>
 <0925c64b-c721-4dc5-913a-c43a94dc64a3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0925c64b-c721-4dc5-913a-c43a94dc64a3@redhat.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D19871F38F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Mon, Jul 14, 2025 at 05:03:03PM +0200, David Hildenbrand wrote:
> [...] 
> 
> But now I wonder, why is it okay to discard anon pages in a MAP_PRIVATE file
> mapping?

IIRC this was originally suggested by Linus, on one of the versions introducing
mseal. But the gist is that discarding pages is okay if you could already zero
them manually, using e.g memset. Hence the writeability checks.

-- 
Pedro

