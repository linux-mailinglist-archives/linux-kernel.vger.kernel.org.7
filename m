Return-Path: <linux-kernel+bounces-827261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1958BB914D2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD163BE6EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B714308F01;
	Mon, 22 Sep 2025 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KQxivix6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0033D544
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546588; cv=none; b=lOzXSAJ+bbX1ghvSbyg9RtrPRDuncx0aD+i+pPoJleaqKHoRL0BGbRpLW7SZKMBadWKDSQ5z6zp+unUPmoX9U+4WbkhYwN4VMlRb2wkYmmWJO4pLNjYutxbJcb17kUnniVrN7mXwa0S7ID6vJIxotUfF+YtgqgpxBORxwOkSNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546588; c=relaxed/simple;
	bh=fy8jCMFwgeaBX/8e41sT1quK3f3wa303trbgfRd6sIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGVV7n53ytzEvxb0zejVW5OX1mmNKKgIS/y1bB/43AtMRGj46B59RHJFynoBCdDxWEiErqO5Nzan0iohS6bcLazp+8guDzZ+wrjd7/ijV0e4XvH12CSXNiQUFvoKUsVUO3mRreW79QFHKFxjW/z4oLOMqAg/SNFssr0Wbxi+aNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KQxivix6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 657AE40E0196;
	Mon, 22 Sep 2025 13:09:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 32EOcYT_IOwb; Mon, 22 Sep 2025 13:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758546580; bh=470sp6n2l5eyC+ZyWGhlTfl9qtzsMLAW5KLzA8xXurI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQxivix6pv5InyS6Eyz9vdHeexEYQhrlefHXziJ00Ei3QL+6eg7L9MN+BSwvKvEuB
	 zauzbcLsInSGmc8g1AnL8OmvAEDnykOr/taKHK8aR/g8zUktCekwldwofEJv9u60sH
	 2i7kt+GEZJ4aRrYiMPuhwGMkXKNI5HPr9y5GrGQbnvFtgI5OWEC8UFOOMryZiax/nC
	 s1wWg+6fH/z7YL3XqH/h0q4+zU7Mmgc3lubUHxB14x5mhSgorUR+j9Tn2zOfCJ+Xgt
	 oKx/kBWs3+6FOJGH1OzBs12zLEGcBOSwhDoSkm3Pbw19KGaoOJlxmIIMCodrRydqIP
	 WiZni7WHgbIs9ANgmH6bKyDEkYaoLKOBozZ/XNMJHaEne9oMc2gcEDU/tw6mAKhEyC
	 9iofpFIsM3UnRQsierJHBYV04lSdzIaErw3VH+RDExZ/svqjvonY+TETG7+9znW6Mv
	 ImaJZz1luBxy4MivXZY3KJnTFJXObyOYMdeJMibGwnRUU29PsswGCyLN/AQCrH+Kbv
	 oY/ZtG34LyTjSVTq1ujCwucOp/7e/i1BxXvZp3XEJ8mB/nD0b9YIo/0ue4zquIKbqz
	 WdMYBwxS3nHCZ6sKQcfsJbg6E+ODgdGPhzUjKN74JbaM+/0qwV92AAMqwr4vzNj8mh
	 3hC/PAmtI7jDRTlWowzvosEo=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D4EEF40E015C;
	Mon, 22 Sep 2025 13:09:30 +0000 (UTC)
Date: Mon, 22 Sep 2025 15:09:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, chao.gao@intel.com,
	abusse@amazon.de, tony.luck@intel.com
Subject: Re: [PATCH v6 0/7] x86: Support for Intel Microcode Staging Feature
Message-ID: <20250922130924.GCaNFKhC8jkEGk8b7Y@fat_crate.local>
References: <20250921224841.3545-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250921224841.3545-1-chang.seok.bae@intel.com>

On Sun, Sep 21, 2025 at 03:48:34PM -0700, Chang S. Bae wrote:
> As the series continues to take shape, I hope this iteration can build
> momentum towards the integration.

Yes, thanks for incorporating all the comments. It looks like it is starting
to shape up.  My plan is to queue it *after* this merge window because we have
less than a week and I'd prefer not to rush it unnecessarily.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

