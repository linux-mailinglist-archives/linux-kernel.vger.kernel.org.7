Return-Path: <linux-kernel+bounces-734211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2252B07E72
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783831C41A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62072BEC20;
	Wed, 16 Jul 2025 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DmnLuyDJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OHSSW3Uh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86CF2BCF4B;
	Wed, 16 Jul 2025 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695924; cv=none; b=a/0V4IJnvRV/z/SR2gow7EMLLS7dGiOSnkCFfHNqO3abzzmMTUEPHRnwGUlnIMhKbI1vbvufTABn1koHhH96/pr2QhnRJV21jJmMz8NHBoXwveCcE90A1KHx5E/sUhU4XKex9nn0wb0u0VAVa11JOOz5wH3buIHFs5ztAxLFmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695924; c=relaxed/simple;
	bh=7QuCx8a4UBg/PNj1N31M+C5I775KhJpXkjO9k+tR3GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SN0ZuSE+KCvRZnEVwoZe9Fa1K1RAi/Ox79ItB4+Zf+MTbM7ePagnMyJ+t4iEPWj/wYEGG4nyRQU2MArYFsLpRGGH/kMFnAXFDzTbUvamni4ZXKwd47jXQqRdPI64m8VOfpggTRCFDTKMNK6k71j7mb3rB5Hl8fHGSwAVGwrIxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DmnLuyDJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OHSSW3Uh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 21:58:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752695918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPR48JgV4EPJQeAgOleKmQDcPYOkMtCBi4gLfMf18kI=;
	b=DmnLuyDJUCQ0eQb2uoUbQIL+OeUNogHLAo+Ipjaumd8gdfBtdY0HUqvl5CRvyth0OOe4rP
	C9aBeXk2RRMQuX4aSKQPkFS6F3sTxNFD9vjNVAVyDvs16Z2tLCCxkxMDpmjjEnYWuz8F3s
	LrPHHk0Ll3CljFrgJ96DwAq+ATZYixt+j2+V528RlyvIprV6q0Q4KEBQjbiUw0HC/MgfX3
	feEC/gtc9BZ2Pp0LBm0H/7zMpNFWsBEs6NoKpskt29i8axsZ6qLeDju1x8vZnWPuRw7fae
	YaMaSALpvyB4Xq2Ao3cAcBjuDryZG6R4EFf95LzsoqK2MCjwjb3VHtqRJf5Ihg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752695918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPR48JgV4EPJQeAgOleKmQDcPYOkMtCBi4gLfMf18kI=;
	b=OHSSW3Uh9KQIyREZ7aMdjpoWbsJgsIzrWja+ApNLJhg0qRXQIhNtuc2h41EJ5n4FSwmOsI
	hk1mwwt1eu0WGdCA==
From: Nam Cao <namcao@linutronix.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] irqchip/ls-scfg-msi: Fix NULL dereference in error
 handling
Message-ID: <20250716195835.W1ewP6iP@linutronix.de>
References: <15059507-6422-4333-94ca-e8e8840bd289@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15059507-6422-4333-94ca-e8e8840bd289@sabinyo.mountain>

On Wed, Jul 16, 2025 at 02:43:45PM -0500, Dan Carpenter wrote:
> The call to irq_domain_remove(msi_data->parent); was accidentally left
> behind during a code refactor.  It's not necessary to free
> "msi_data->parent" because it is NULL and, in fact, trying to free it
> will lead to a NULL pointer dereference.  Delete the unnecessary code.
> 
> Fixes: 94b59d5f567a ("irqchip/ls-scfg-msi: Switch to use msi_create_parent_irq_domain()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Nam Cao <namcao@linutronix.de>

Thanks for the fix!
Nam

