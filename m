Return-Path: <linux-kernel+bounces-770053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 097F4B27645
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C491887B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F2B29B777;
	Fri, 15 Aug 2025 02:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lq3golUm"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C6C29B23E;
	Fri, 15 Aug 2025 02:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225822; cv=none; b=iq97Z2ALSzhDKvCvX+ZsDRwNvMhnjD24Nmy3Pvmg5P/DA+Bx86AlVpGWZFPaE0357ULx4YlSKPO2fui9t4xFgS9IXK2JgG48VSn5eM0+0MRN/gMf5NL38lcBUUp6GOnaqwi3d7DwIk4hWhdu2ga0KLfv19bkCs0TpILHXLZ8MZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225822; c=relaxed/simple;
	bh=/PV07ux8NWA3wTky7V+QQKjc5NjD4ZFIT6NkARZRNGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCvaQNvBgxSciUBaia3Ehup7xTpaxjvqDWMc8wJJFC5Ah4BSvkpwEq46v1J3bZQAdbpdUUoMwFtDisejoVXNbathv48SevawAG7qzqUjRVKd9dy/HnwwYj952aEvvwp/TFpDflDNr5rgT/kNfbFalTIm8RFA7RD6B+lvCyUHqTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lq3golUm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=aBmIJscIait2IhulupFgTY7aIusSXNXvDlOfUbDJvoc=; b=lq3golUmdLII2ubuRV5Ikjfnu2
	TjDFEND/pwz75AUlrIHozYbX0ySZOSEDHW6OOe43BVXEYz8SYA9KxuZgUs1uEXS0Z2IL0I8J8vgyj
	4uj2vqOrC1AqwV36zkNDTpltl/ZBmG98776puO3HP4wBHgw9VJLYMjD2ZAjDgEsntH1PA5TuFGBiq
	4NbDsur6l9HURRHxfSfxlwq5Hkp1J7bt9MYylmqlRpduf43lusEkuICMrgbINnaMTeVwlTZIV3WyP
	mBq0kIuDmk42/OQegxBrEtgKR3dsSVln5ISp1UR2NE258VtSAHLFTaWoJSRf+2YRwayifZV2eyTo7
	wuhn0h3g==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umkPq-00000001DDQ-2Qu8;
	Fri, 15 Aug 2025 02:43:38 +0000
Message-ID: <1c04bed1-64aa-478d-a9ea-e54c335b3a1f@infradead.org>
Date: Thu, 14 Aug 2025 19:43:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] docs: remove kernel-doc.pl
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Akira Yokosawa <akiyks@gmail.com>
References: <20250813213218.198582-1-corbet@lwn.net>
 <20250813213218.198582-14-corbet@lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250813213218.198582-14-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/13/25 2:32 PM, Jonathan Corbet wrote:
> We've been using the Python version and nobody has missed this one.  All
> credit goes to Mauro Carvalho Chehab for creating the replacement.

Thanks, Mauro. I certainly won't miss kernel-doc.pl.

> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/kernel-doc.pl | 2439 -----------------------------------------
>  1 file changed, 2439 deletions(-)
>  delete mode 100755 scripts/kernel-doc.pl

-- 
~Randy


