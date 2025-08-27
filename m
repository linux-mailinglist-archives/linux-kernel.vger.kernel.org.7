Return-Path: <linux-kernel+bounces-788334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31021B3830F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BC7684FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6250334F491;
	Wed, 27 Aug 2025 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zqq8jlrz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XZwMjA8g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zqq8jlrz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XZwMjA8g"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E413214228
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299446; cv=none; b=UCCCHazoDFvAq/hLdiPFjPICe5ONYl13bRb7M32rq2Y+9vGBUYaOglQMFqvbsalLN20GFzuYCvj1oGNucxqcP0vRcctFTkNeQici3Kg47xJBWVfeu2wQNa+nCuajuQai+5fO/rkZw6BZFss1psMNUG0Y3KPe9Nx5LpQVo8cILHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299446; c=relaxed/simple;
	bh=x9TQ2qqT2DI03llm2FpTgYgT3uV8cspvaqxhCBye1go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVtf6MDvRhB03v8Q/zIKnvpAARu1QyThx0VWuV5qrRg6FXWO4N5yIXwvQQbuTdzkQ8opfL/wSJW7XZZTwcAWRFcYkB8zRMfimt4hCt24ThuRz3l4g3NrRSUbRMEnjhGRlUBOrSi8Wp321lllX4itx5t3HFdLSN9NDCrk0gY8DIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zqq8jlrz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XZwMjA8g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zqq8jlrz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XZwMjA8g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4152E201DA;
	Wed, 27 Aug 2025 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756299443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAD7QJFjzDq1GdtAMg84jhFNCEBk4Gc6C3N9ret1YsY=;
	b=Zqq8jlrzHa+lfboUerUcQpfjmp2RjaEY7e/37gHTIotLvZDbIyP6jfD9dofMYwbjAS/o5y
	esS4S4uS6+i1eB8AB7NuejCXv/xzg7abM1P01zMiji3PwXBz3FZTZm1kAlbMM9s17XlsYE
	mGMGMD+BrZBLf9UECrl9bJ4at7vnW64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756299443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAD7QJFjzDq1GdtAMg84jhFNCEBk4Gc6C3N9ret1YsY=;
	b=XZwMjA8gacDvHqNchC6esmuSdoJneq4rdBDpd3E6wxY73fKqBxZKvBg8+7TXXTEGXFUL5l
	oYk/dk3DZxwvjECg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zqq8jlrz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XZwMjA8g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756299443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAD7QJFjzDq1GdtAMg84jhFNCEBk4Gc6C3N9ret1YsY=;
	b=Zqq8jlrzHa+lfboUerUcQpfjmp2RjaEY7e/37gHTIotLvZDbIyP6jfD9dofMYwbjAS/o5y
	esS4S4uS6+i1eB8AB7NuejCXv/xzg7abM1P01zMiji3PwXBz3FZTZm1kAlbMM9s17XlsYE
	mGMGMD+BrZBLf9UECrl9bJ4at7vnW64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756299443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAD7QJFjzDq1GdtAMg84jhFNCEBk4Gc6C3N9ret1YsY=;
	b=XZwMjA8gacDvHqNchC6esmuSdoJneq4rdBDpd3E6wxY73fKqBxZKvBg8+7TXXTEGXFUL5l
	oYk/dk3DZxwvjECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F47B13867;
	Wed, 27 Aug 2025 12:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XCHCI7IAr2gMXAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 27 Aug 2025 12:57:22 +0000
Date: Wed, 27 Aug 2025 13:57:26 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] tools: testing: Support EXTRA_CFLAGS in shared.mk
Message-ID: <6dd6xhsz44j647oon37oavwazd6lte2htv6tu6ecksnrwebpdd@gtdisqzbvfqi>
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
 <20250827-b4-vma-no-atomic-h-v1-3-5d3a94ae670f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-b4-vma-no-atomic-h-v1-3-5d3a94ae670f@google.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4152E201DA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Wed, Aug 27, 2025 at 11:04:43AM +0000, Brendan Jackman wrote:
> This allows the user to set cflags when building tests that use this
> shared build infrastructure.
> 
> For example, it enables building with -Werror so that patch-check
> scripts will fail:
> 
> 	make -C tools/testing/vma -j EXTRA_CFLAGS=-Werror
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

