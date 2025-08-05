Return-Path: <linux-kernel+bounces-756177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313CAB1B0EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A6E1624F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECD9259CBA;
	Tue,  5 Aug 2025 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JKYLIDdF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W9D36PnH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sNtts3JH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iBbEuD6h"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72A81B960
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385649; cv=none; b=b+aNgfVn/ciLfHaTKGPjKrw4wRVFn7ez57aR1cW0lYE1ZJD7v38k8sB4c7rBNA7XdHqC7YAunkrHsJG45r53YVZTUYdZwAYEMHHZzMa6APFNz3YUJENCgEt7BMvdNJ1gwig8288j6zyuAVU/cqFIoGr1Jz9dwhJLA1s/C7X7RAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385649; c=relaxed/simple;
	bh=+jRmFplRDzZg5mVHHRuoaGOQ8p0iT2dOVN6esIDtERE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPp/bykGuYJP6SqMyIMqZ/n1FDTcQIHuzvQhOEvrqnP2qCwJ7arzvD+lP8nUZ2MEh7GdfYpea25A1s7gyn103Nvgk9u5CTV1Vsib7472cDD6HSh991jcpvz1eR3b9F7M6WSTL7POv+CxCweoqy/nTgD+AOJi5t7BphR/KxBHjDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JKYLIDdF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W9D36PnH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sNtts3JH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iBbEuD6h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE60221235;
	Tue,  5 Aug 2025 09:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754385640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHMRVK7QVsCp1KUp4tnCghouR6JYlszhPaJzdNosRRE=;
	b=JKYLIDdFNs3aYZsa6GvIKNRX/cwlIWnX7FxSvXIq3suGXbfTqxwOJMyuwHtpwCAM9xjFNi
	xLCrwNc9kYYtFh4lhdCeYRWby/Zs7JEcU2EAcKoOD4kxXoZZZLqyA/97mi86LXue45vuSF
	f8AOwB4+02DIcC3uO5T2zVh3YUJ5sqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754385640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHMRVK7QVsCp1KUp4tnCghouR6JYlszhPaJzdNosRRE=;
	b=W9D36PnHk3baL7DuUyr+HqePGIz/D9842my0AB3oYO9sgmWmuNxfoifsnby6agNFoX9kEn
	rCuEpPCAhjZi8iBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754385639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHMRVK7QVsCp1KUp4tnCghouR6JYlszhPaJzdNosRRE=;
	b=sNtts3JHY8JNB1Izae96sbqpsMi7G2NcXCderJkWaCw+EUDX9DXMBzWA78rKB8saNuU7HJ
	68GHr92raH00HKny/JUEV+4bMmN8Xx54HX9t4rdwS+1KjZmZDw3PPJegpimf/ppJ2gr4M5
	5eDHPg3bfwy33oT6H2v1v8uBgXXheb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754385639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHMRVK7QVsCp1KUp4tnCghouR6JYlszhPaJzdNosRRE=;
	b=iBbEuD6hS5eB0gMuFdHIdxCKTewxxhF+o81zBLSFRjEkFPDzRkMqNoekqYE2IdfwIPXge6
	smG0P5aUgGKq2VDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3BA913A55;
	Tue,  5 Aug 2025 09:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ci90M+fMkWhuSgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 05 Aug 2025 09:20:39 +0000
Message-ID: <3c6100a1-78a3-4211-a62d-eea07db91b62@suse.cz>
Date: Tue, 5 Aug 2025 11:20:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: Correct misleading comment on mmap_lock field in
 mm_struct
To: Adrian Huang <adrianhuang0701@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Liam.Howlett@oracle.com,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Feng Tang <feng.79.tang@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Adrian Huang <ahuang12@lenovo.com>
References: <20250805084726.2054-1-ahuang12@lenovo.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250805084726.2054-1-ahuang12@lenovo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,oracle.com,kernel.org,google.com,suse.com,gmail.com,kvack.org,vger.kernel.org,lenovo.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On 8/5/25 10:47 AM, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> The comment previously described the offset of mmap_lock as 0x120 (hex),
> which is misleading. The correct value is 120 (decimal), and using '0x120'
> could confuse readers trying to understand why the count and owner fields
> reside in separate cachelines.
> 
> This change also removes an unnecessary space for improved formatting.
> 
> Fixes: 2e3025434a6b ("mm: relocate 'write_protect_seq' in struct mm_struct")
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>

That seems all true so

Acked-by: Vlastimil Babka <vbabka@suse.cz>

But I wonder why we just hope this remains true "with some kernel
config" and don't employ some explicit alignment to make sure it's true
(except perhaps with some debug options like lockdep bloating the
structures, but we don't care about perfmance in such configs).

> ---
>  include/linux/mm_types.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 1ec273b06691..ec90bbf22e2b 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1027,9 +1027,9 @@ struct mm_struct {
>  					     */
>  		/*
>  		 * With some kernel config, the current mmap_lock's offset
> -		 * inside 'mm_struct' is at 0x120, which is very optimal, as
> +		 * inside 'mm_struct' is at 120, which is very optimal, as
>  		 * its two hot fields 'count' and 'owner' sit in 2 different
> -		 * cachelines,  and when mmap_lock is highly contended, both
> +		 * cachelines, and when mmap_lock is highly contended, both
>  		 * of the 2 fields will be accessed frequently, current layout
>  		 * will help to reduce cache bouncing.
>  		 *


