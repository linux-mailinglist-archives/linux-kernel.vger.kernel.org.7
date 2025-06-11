Return-Path: <linux-kernel+bounces-681017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 808D1AD4D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 09:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282DD1BC213F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 07:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2440B2356A7;
	Wed, 11 Jun 2025 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uxP3fA0q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DO1zx4eA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uxP3fA0q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DO1zx4eA"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89275235340
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627596; cv=none; b=q/HORRiZxN3qpoJxDLdnlU+UHKs89FwWPiudM8TQaoAfAUp2otAI7Ft5VrUg4LL+Wr90PTzzTrvyGF62Nl7hvSmo08HVquHKLOci8Pzdi/234V8BLhQP+aHBAUXvudJ7cMISuEPt2d5D3qu0u7MjRitEuVbOG/DNYKqtsD2NBIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627596; c=relaxed/simple;
	bh=voCkIMKUZo8L4D/DAEVGka+lMbZ9q6uLMHsZHrNZ8U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wuryf8Hh3VJ5YZtIt8pyd6PoOZfxUV757GEdVjF+3IYPwc3jRttiZx0TDD6YuMXi6VV7Pvz1XFdFXL2Sw5KI18E5iWtlxKHjC1HOzpQXEtmdPz+yG4gIfUTkqlGxEBzLzAmWSafPyPGYgq4+5DTMca86zUw8/aZFkgm9gb6AGz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uxP3fA0q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DO1zx4eA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uxP3fA0q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DO1zx4eA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA49C1F769;
	Wed, 11 Jun 2025 07:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749627591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3Y1wXhNXQFw/kxdT7QOGHFJkCiQ1oUCutTM2v/mYUM=;
	b=uxP3fA0quVFpZxrF+amI0m/H2NjRptq2OIAk+cQFSovy8XeOnU9oNRcg5uotoWNmd3iF1s
	2hsbZixknIaSNG0zBtFEpsSMlt9nOoeifPwOAoAsdUm1XrObgeA3Nii854T1zBA+YasK5x
	JJH624Ft48mrlq6I3RiKGEy6nsrcyvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749627591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3Y1wXhNXQFw/kxdT7QOGHFJkCiQ1oUCutTM2v/mYUM=;
	b=DO1zx4eABPFk8HaEkJUZAVO5zevNtqGA5lwGur1j/kj3PtdlsNhbSvlOTFaGgX/b/+IBx0
	5mYCtT9E8TgY/jDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749627591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3Y1wXhNXQFw/kxdT7QOGHFJkCiQ1oUCutTM2v/mYUM=;
	b=uxP3fA0quVFpZxrF+amI0m/H2NjRptq2OIAk+cQFSovy8XeOnU9oNRcg5uotoWNmd3iF1s
	2hsbZixknIaSNG0zBtFEpsSMlt9nOoeifPwOAoAsdUm1XrObgeA3Nii854T1zBA+YasK5x
	JJH624Ft48mrlq6I3RiKGEy6nsrcyvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749627591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3Y1wXhNXQFw/kxdT7QOGHFJkCiQ1oUCutTM2v/mYUM=;
	b=DO1zx4eABPFk8HaEkJUZAVO5zevNtqGA5lwGur1j/kj3PtdlsNhbSvlOTFaGgX/b/+IBx0
	5mYCtT9E8TgY/jDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C4C9139CE;
	Wed, 11 Jun 2025 07:39:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Uyt6I8YySWh+WwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 11 Jun 2025 07:39:50 +0000
Date: Wed, 11 Jun 2025 09:39:49 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Shivank Garg <shivankg@amd.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, willy@infradead.org, rostedt@goodmis.org,
	apopple@nvidia.com, david@redhat.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2] mm: use folio_expected_ref_count() helper for
 reference counting
Message-ID: <aEkyxathfOPvH9To@localhost.localdomain>
References: <20250611052706.515408-2-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611052706.515408-2-shivankg@amd.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Wed, Jun 11, 2025 at 05:27:07AM +0000, Shivank Garg wrote:
> Replace open-coded folio reference count calculations with the
> folio_expected_ref_count().
> 
> No functional changes intended.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

