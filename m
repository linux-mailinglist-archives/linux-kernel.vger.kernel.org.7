Return-Path: <linux-kernel+bounces-803241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA8AB45C91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9B0583436
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F098A2F7AA9;
	Fri,  5 Sep 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4IpGQ0jf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ADfAifX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54823BF91
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086026; cv=none; b=CtEAJ96dtArD97gW6EbP6m9Nn+kKJElMiHSiiX5PQxTaXLx4D1Sd548j0FAqPjZXR0YpsnBqxZr190VGHGJTUmD9UmVGXrhPxeBFkSkwIOVITZN3Lx3/F6Zmy0tSFAVxC6xpUBC5CX6ZmmCRB5LrCwKc2cyeBIkjLDVoSiUy5Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086026; c=relaxed/simple;
	bh=wOBvtD81eHSn9cztu5WIVl901CexNDPhjcprnjKtwVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T5AWgmODoxsb/TkVZUC5M5qxTMDskSD456x5JYHHKAsUTDFWNyc1jsGjaQ+N7VeV7bkXhbSNbd1viPNYiOiE7P8a/8kvQlaQWDWSAe0GCCpziaOsRZaMn7tHCQovf1NlYPDOv0Ud47hUE6Li5xtJ2v2OGeaB9c4thzTBLIm1lyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4IpGQ0jf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ADfAifX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757086022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iR+U27Too8ySmvRuGOemQg3tp82NRmTCp7I04NjyvEM=;
	b=4IpGQ0jfRIFeRMqqcShMjIFYIKIWhbB88xsR+QpWM7KiBauIjNlHktFlItgwQQB/pZXQBq
	mOHxujF+3KOkc3a3Vw9GSfzh7rc110XjfWRHJ2uuoebjTx0rrpUzhkrxVDEk6qnwxm7bz1
	wpFpI2DKkfRwgs2njl46Om9crx9E4gQi/K3eXrmOr2vMTjUF/POoHyphHqvm1jL8IEIMBf
	DSIOw2BeGiAaoPMB2cLiNsPbJkpLb5rwEatQOwq6goHfh/s9ILBUJY3szlcvhvWQSruJKE
	R2s5EJTmspe3jcIDJ42VMfxR+2LG8o+9EzC1tBxZVaFsO3BBXbmKoICr/DCfLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757086022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iR+U27Too8ySmvRuGOemQg3tp82NRmTCp7I04NjyvEM=;
	b=2ADfAifXROWHj826jzuDlqDv3PzAK+JN0pvWzMdXBm4eZ5XQC6EcB5j/TYsJ6C8tqNf+dm
	E5Gjv41ZvY735yAQ==
To: Daniil Tatianin <d-tatianin@yandex-team.ru>, Petr Mladek <pmladek@suse.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 1/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
In-Reply-To: <20250905144152.9137-2-d-tatianin@yandex-team.ru>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <20250905144152.9137-2-d-tatianin@yandex-team.ru>
Date: Fri, 05 Sep 2025 17:33:02 +0206
Message-ID: <84tt1gex89.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-05, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index d9fb053cff67..99989a9ce4b4 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1234,14 +1245,14 @@ static const char *get_data(struct prb_data_ring *data_ring,
>  	}
>  
>  	/* Regular data block: @begin less than @next and in same wrap. */
> -	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
> +	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
>  	    blk_lpos->begin < blk_lpos->next) {
>  		db = to_block(data_ring, blk_lpos->begin);
>  		*data_size = blk_lpos->next - blk_lpos->begin;
>  
>  	/* Wrapping data block: @begin is one wrap behind @next. */
> -	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
> -		   DATA_WRAPS(data_ring, blk_lpos->next)) {
> +	} else if (!is_blk_wrapped(data_ring,
> +		   blk_lpos->begin + DATA_SIZE(data_ring), blk_lpos->next)) {

It would look nicer if the arguments of the function were indented to
the function parenthesis:

	} else if (!is_blk_wrapped(data_ring, blk_lpos->begin +
				   DATA_SIZE(data_ring), blk_lpos->next)) {

Otherwise, everything is OK for me.

Reviewed-by: John Ogness <john.ogness@linutronix.de>
Tested-by: John Ogness <john.ogness@linutronix.de>

