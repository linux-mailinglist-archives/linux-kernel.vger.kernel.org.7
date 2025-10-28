Return-Path: <linux-kernel+bounces-874146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E145EC15A12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60A4B504AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27C132D450;
	Tue, 28 Oct 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D76UCDz7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j+tgclw9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D76UCDz7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j+tgclw9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85CC34320C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666439; cv=none; b=ekoHubs5rD/IA0n7qZZ6WruBKt/KPlnGAbAcCZxPJ517ux4gb+GHoZAaDhQ+RkQyUYEA3swORTCO76+wUdYJ5Wn/zvKSBRcyQkn2ULqCEDzkbP/4axn6swm1EEYmsLmSoULESQcuiRbbwEPLT6E7uPutAKnIYJe+4ztYp7oPb24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666439; c=relaxed/simple;
	bh=3OS1iKsFRWmOGNOTc7RYW3m1T1faV3fKwcMW9HaYc2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vocd1A2e51LzqSv3QRlVx0BWpuD/po9jPygYyECPksDf6Q2zLDrQXa7CmdbKglWtZZbc0A2Vy5D6pBOmiLQpCgzMMgcRVX8K0sRgkKI4fpq4xIm6mKR3N3fn0PAQTByBeKGNYZCwspdT67Kjd2kkEGagfc/ap6UiCPoLYmF/3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D76UCDz7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j+tgclw9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D76UCDz7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j+tgclw9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 985EA218E6;
	Tue, 28 Oct 2025 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761666432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+crhKvqkHlfXPE3UZGCDMo5igLkxWQZ3nmbdzOcy9cw=;
	b=D76UCDz7DnzAaKKMymz8WmD9RlXz6AT3hn+oCSGhtPrtYCEZ5dU2A6IqQxBd+AzszQFJ+O
	kkWDjv8q9iTAJRj+vHLNKr1lbW5GdhjvjbrnWjQ4dg4/L3AliO85vnbqhntuoG2QqMW6ij
	0f8Z94QFuM8b4cEunGnDFGRO1bmXJyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761666432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+crhKvqkHlfXPE3UZGCDMo5igLkxWQZ3nmbdzOcy9cw=;
	b=j+tgclw9OAAxATNDtHBsxRfctv1tA7Qv7PKPJmGZ33BnIbidLnd0oqjkJ0RHN2z/ne0jrv
	+zPxGkHxUG3cPkCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D76UCDz7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=j+tgclw9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761666432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+crhKvqkHlfXPE3UZGCDMo5igLkxWQZ3nmbdzOcy9cw=;
	b=D76UCDz7DnzAaKKMymz8WmD9RlXz6AT3hn+oCSGhtPrtYCEZ5dU2A6IqQxBd+AzszQFJ+O
	kkWDjv8q9iTAJRj+vHLNKr1lbW5GdhjvjbrnWjQ4dg4/L3AliO85vnbqhntuoG2QqMW6ij
	0f8Z94QFuM8b4cEunGnDFGRO1bmXJyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761666432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+crhKvqkHlfXPE3UZGCDMo5igLkxWQZ3nmbdzOcy9cw=;
	b=j+tgclw9OAAxATNDtHBsxRfctv1tA7Qv7PKPJmGZ33BnIbidLnd0oqjkJ0RHN2z/ne0jrv
	+zPxGkHxUG3cPkCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8889613A7D;
	Tue, 28 Oct 2025 15:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FIl4IIDlAGlebQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 28 Oct 2025 15:47:12 +0000
Date: Tue, 28 Oct 2025 16:47:12 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] nvmet-fc: use pr_* print macros instead of dev_*
Message-ID: <83e3fc56-9bb3-4372-95e1-3b318c34e26b@flourine.local>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
 <20251028-nvmet-fcloop-fixes-v1-5-765427148613@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-5-765427148613@kernel.org>
X-Rspamd-Queue-Id: 985EA218E6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On Tue, Oct 28, 2025 at 04:26:24PM +0100, Daniel Wagner wrote:
> Many of the nvmet-fc log messages cannot print the device used, because
> it's not there yet:
> 
>   (NULL device *): {0:0} Association deleted
> 
> Use the pr_* macros consistently throughout the module and match the
> output of the nvme-fc module.
> 
> Using port:association ids are more useful when debugging what's going
> on, because these match now with the log entries from nvme-fc.

Signed-off-by: Daniel Wagner <wagi@kernel.org>

