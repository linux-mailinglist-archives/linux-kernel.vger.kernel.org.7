Return-Path: <linux-kernel+bounces-724465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A9AFF340
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25E65A2D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED271237163;
	Wed,  9 Jul 2025 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PLDTiMiQ"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E322F76B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094520; cv=none; b=ul2jY4Ban+BnbSGS+KTNbCOb+D0H6Egj2mJvuchrU4N7JzvijG3CcYt6A6dC3z2bm4qxRe/JDc+fYYlYwFxWVPqsSnKdPiV+CuOnk7oATXH+YKWDpIvQpWWB3k8y1hbbtGLDWC3gfpGb/yAp1ma3M4BUKuMIgarO2dwYLzvPB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094520; c=relaxed/simple;
	bh=xSEW6FAy4KVCqQ8iI1cz5XH4Lw16eWn474FLDIwWLAo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=htpwft0gJGGR4x3FBgZlFB/jXTL2WE8jzTuii98iQNQhWlHM1Jac4DsuW3LYA742Ghu8ShXP6LH/MzutnoRCn4q+6jkXWQc3GgIJRH7BWN/gYvu1mgcc/d+SlY1vBd9QZhQa5h9naQUtcBcSDhRggztopjLSH1h2luGL9b71eFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PLDTiMiQ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752094506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ERUvSzTuxrDFO8MNtmpjhK8Lt5j+LTHiSFCYzTufBk=;
	b=PLDTiMiQ8wIn6mD7XPD2HPBF5d3zDO1OkqTPq1/33abMS6k92zHSY+XaVwrcOg1Hm7bL01
	y8S6oURJ/cPiSPUxNsQ1L+SlcZ0RIIeYTQoQ06UVQW0Da+S9MoJHL1GTFihRUueNh36kI+
	NWTE/n0n1yVcVYhIM83BjBp6bOTPAHk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] ALSA: echoaudio: Replace deprecated strcpy() with
 strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <87bjptzch3.wl-tiwai@suse.de>
Date: Wed, 9 Jul 2025 22:55:02 +0200
Cc: Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 Andres Urian Florez <andres.emb.sys@gmail.com>,
 linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7F3BCAEF-67D2-4907-9392-CAEFD3EF58C7@linux.dev>
References: <20250709124655.1195-1-thorsten.blum@linux.dev>
 <87bjptzch3.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Migadu-Flow: FLOW_OUT

On 9. Jul 2025, at 16:05, Takashi Iwai wrote:
> Thanks, applied now.
> 
> And now I'm going to convert all the rest of such trivial stuff
> (strcpy() with card->driver, shortname, mixername, longname, as well
> as pcm->name, and else) in sound/* for 6.17.

Yes, please :) I thought about submitting a patch series for all of
sound/*, but didn't find the time yet.

Thanks,
Thorsten


