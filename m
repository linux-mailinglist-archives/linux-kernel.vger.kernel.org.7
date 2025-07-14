Return-Path: <linux-kernel+bounces-730358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F127CB0437C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 690457B5694
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6830025A331;
	Mon, 14 Jul 2025 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E9BtveG+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QMQolox7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KpbQ25HL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zJPU3Elo"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4AC234984
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506337; cv=none; b=c9CliyRc2Kwl9tuVWowJMsKbeUMYZozQKaz7AlkXeIDHg02TOLZmv1oGkvcpV7NVIhmEADNlKy6wan+VwIGRtbFIa1XHVvXh9WoR3MKH3Mmq0p7CLhjy4sjGKaZEjLK/HIvUkWErHa69rDlu7+FgX7qwWY8nbGtk4qVJXkXZvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506337; c=relaxed/simple;
	bh=l7IckHahy283kH/EcRbno58OArvS21m4ts01ohQ19rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHIwFwLBSV+ayhl29Fb5jLySxv5GdgNmxI8sGkn9YlYEjV5Qzztb6aISefrSpPUXGeRL+3naBq1g9hffLEr899HiPeb1qd1hWxRjeuFF8JFkjwcn/IuCts/PwjqKJvXjxvC86DsbaeD0esg63KxXpcJXyNV2IxX8ZdRNiNGM1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E9BtveG+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QMQolox7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KpbQ25HL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zJPU3Elo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE91B2125B;
	Mon, 14 Jul 2025 15:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752506333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SH12eXRfFkfNm6HSRFM+mxpcW/B4TZTYFL4rCK3hgXQ=;
	b=E9BtveG+S/QPZ9wUXe6z7Rg7UWzDBsMvw84LeMAY2i3pRsTXUun81+QVFSstkybrnHnGH8
	4rj/77X0ZHIlDejpV3AYTeK6j2CpPXa9Vzc4fOR96R4tA1UfS8eq61y84TI9N8+YCOOoYk
	+iKEQ0/ve7TfAkYQ7QrJyZZQ7j4VY04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752506333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SH12eXRfFkfNm6HSRFM+mxpcW/B4TZTYFL4rCK3hgXQ=;
	b=QMQolox7gTE7bAg3wqF7FmVJFIOZO6PrdiDgSm++yRKWxxCnPEsP5J1DwyOUKuVk6ykJtA
	NOUkF2724KuystDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KpbQ25HL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zJPU3Elo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752506332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SH12eXRfFkfNm6HSRFM+mxpcW/B4TZTYFL4rCK3hgXQ=;
	b=KpbQ25HLi0WkblRNKteDe7N17Vjw1urSrUQjpZbgMcnTxlbeIzSiNGqBs+vOsKYoB5RqcE
	N9wkIQb3GVVm2ymo/xifXyHJr6C0neXu14lQNgyU+yJwdnIcOI7gtEI9nC9YebnsS2n1r6
	HdeFgSClVit9v9vL10peRwLJO4QQ5s8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752506332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SH12eXRfFkfNm6HSRFM+mxpcW/B4TZTYFL4rCK3hgXQ=;
	b=zJPU3Elo5CMg6ghoSQ2TbVVihuMHrCnftIOZJc5M1QyYJfFNcnuU+pmKS1HulNUOh2o0k9
	kvTy6cFQhYGIstDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EFFB138A1;
	Mon, 14 Jul 2025 15:18:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FViPC9wfdWjoMgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 14 Jul 2025 15:18:52 +0000
Date: Mon, 14 Jul 2025 16:18:50 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
Message-ID: <hlafwzbgyyez76ehaipubk2i3zldxlhqar6ozczea3mzhjxnga@dyuki2pnjkgr>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
X-Rspamd-Queue-Id: EE91B2125B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Mon, Jul 14, 2025 at 02:00:37PM +0100, Lorenzo Stoakes wrote:
> The madvise() logic is inexplicably performed in mm/mseal.c - this ought to
> be located in mm/madvise.c.
> 
> Additionally can_modify_vma_madv() is inconsistently named and, in
> combination with is_ro_anon(), is very confusing logic.
> 
> Put a static function in mm/madvise.c instead - can_madvise_modify() - that
> spells out exactly what's happening. Also explicitly check for an anon VMA.
> 
> Additionally add commentary to explain what's going on.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

