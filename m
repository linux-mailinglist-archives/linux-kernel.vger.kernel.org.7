Return-Path: <linux-kernel+bounces-800936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7802B43DE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996EE3B98FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4120730102F;
	Thu,  4 Sep 2025 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dw7eagzL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tnoeGslt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA41F301025
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994314; cv=none; b=fKQRwYDnWfjwYFI2FKdgdNnN3iDmge15dk0UKjbrnJ/ypBpqMSt5EMvfML/ER+WNDiAvhvcUTPRfXbrJMU04ANlIgOYXtYOe5Y5S4bJebqtI+NQ5Kto0uQWkMg1MZH/haEDxpkz4QSZ10xP8ASSkbSkLHYgbgioYuZ2sV4evxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994314; c=relaxed/simple;
	bh=g3gOPaA2pHD2klcmn/o2G5lqeyS6KsgGBK6JcTyyCcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lub5d+oI8g6Pnq5Wk2xGIHeVlw7DDkG5oDIsgsgOPCbNrMifTk/P/EEwx5KetjZR95jJ07bIH4J5pbpDKalfV+v8c/F0gyziJbEne+B9pBEQf1mDHs/sqUDBFKLeRh2dq0T1o2NhKtW38+bO7ZzJp3C2EN79IYe9zNtmOv61fbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dw7eagzL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tnoeGslt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756994310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfOCMRjTWP6T+VzCp3H2bEoUgPGG7P+rdNcstR9oXEk=;
	b=Dw7eagzLNiDQ0cAZ7GK+SF+XGYU8jpg2Cy4iAa8vGlk8OZhAbwozpoXZ36NUo+fnwzdywp
	UOJirqKibyVRYXei8DhNna+I0Ja8PsHdajsAXW31wrMoSPVtub+lcbV2tv8DsPkia/KytK
	ltr877BD++Fulg3kaCUebQHzZv6sUSiqbUUN7QgFaktAHQAH5TksYMTpfnUiZpzAoxWbLn
	moOs6R/10vOf3v0nA6pLkFShS1htD5+9fcw5KSrpMbB5laVoigQ5l2lYfoTfdcWwm3tY+H
	Dczmrnc5BHeqo0UqsFlFHmheiCZSr0ZZ7VPMk+I/HPC93DDRYKWgfFZiqEU6Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756994310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfOCMRjTWP6T+VzCp3H2bEoUgPGG7P+rdNcstR9oXEk=;
	b=tnoeGsltzWGjWHVuO81/XqYivFPH+dGBTHDQwW1yuOS3hRNfcOcp6qXXtMrMDmOrHss/Jc
	39z+3RnSKXzHqUAQ==
To: Daniil Tatianin <d-tatianin@yandex-team.ru>, Petr Mladek <pmladek@suse.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1] printk_ringbuffer: don't needlessly wrap data blocks
 around
In-Reply-To: <20250903001008.6720-1-d-tatianin@yandex-team.ru>
References: <20250903001008.6720-1-d-tatianin@yandex-team.ru>
Date: Thu, 04 Sep 2025 16:04:30 +0206
Message-ID: <84jz2etj3t.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-03, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
> Previously, data blocks that perfectly fit the data ring buffer would
> get wrapped around to the beginning for no reason since the calculated
> offset of the next data block would belong to the next wrap. Since this
> offset is not actually part of the data block, but rather the offset of
> where the next data block is going to start, there is no reason to
> include it when deciding whether the current block fits the buffer.

This is a nice catch!

Although note that this patch avoids wasting a maximum of 8 bytes of
ringbuffer space. If you are interested in tackling the wasted-space
issue of the printk ringbuffer there are much larger [0] fish to catch.

[0] https://lore.kernel.org/lkml/84y10vz7ty.fsf@jogness.linutronix.de

My comments below...

> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index d9fb053cff67..f885ba8be5e6 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1002,6 +1002,18 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>  	return true;
>  }
>  
> +static bool same_lpos_wraps(struct prb_data_ring *data_ring,
> +			     unsigned long begin_lpos, unsigned long next_lpos)

We need a better name here since it is not actually using the value of
@next_lpos to check the wrap count. Perhaps inverting the return value
and naming it blk_lpos_wraps(). So it would be identifying if the given
blk_lpos values lead to a wrapping data block. Some like this:

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d9fb053cff67d..cf0fcd9b106ae 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1002,6 +995,17 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 	return true;
 }
 
+/* Identify if given blk_lpos values represent a wrapping data block. */
+static bool blk_lpos_wraps(struct prb_data_ring *data_ring,
+			   unsigned long begin_lpos, unsigned long next_lpos)
+{
+	/*
+	 * Subtract one from @next_lpos since it is not actually part of this
+	 * data block. This allows perfectly fitting records to not wrap.
+	 */
+	return (DATA_WRAPS(data_ring, begin_lpos) != DATA_WRAPS(data_ring, next_lpos - 1));
+}
+
 /* Determine the end of a data block. */
 static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
 				   unsigned long lpos, unsigned int size)

> +{
> +	/*
> +	 * Subtract one from next_lpos since it's not actually part of this data
> +	 * block. We do this to prevent perfectly fitting records from wrapping
> +	 * around for no reason.
> +	 */
> +	return DATA_WRAPS(data_ring, begin_lpos) ==
> +	       DATA_WRAPS(data_ring, next_lpos - 1);
> +}
> +
>  /* Determine the end of a data block. */
>  static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
>  				   unsigned long lpos, unsigned int size)

The rest looked fine to me and also passed various private
tests. However, we should also update data_check_size(), since now data
blocks are allowed to occupy the entire data ring. Something like this:

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d9fb053cff67d..e6bdfb8237a3d 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -397,21 +397,14 @@ static unsigned int to_blk_size(unsigned int size)
  */
 static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
 {
-	struct prb_data_block *db = NULL;
-
 	if (size == 0)
 		return true;
 
 	/*
 	 * Ensure the alignment padded size could possibly fit in the data
-	 * array. The largest possible data block must still leave room for
-	 * at least the ID of the next block.
+	 * array.
 	 */
-	size = to_blk_size(size);
-	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
-		return false;
-
-	return true;
+	return (to_blk_size(size) <= DATA_SIZE(data_ring));
 }
 
 /* Query the state of a descriptor. */

Petr may have other ideas/opinions about this, so you should wait for a
response from him before submitting a new version.

John

