Return-Path: <linux-kernel+bounces-831005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89496B9B23E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 014F84E2A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C0A3161AC;
	Wed, 24 Sep 2025 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vevfVSZA"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961C8314A9D;
	Wed, 24 Sep 2025 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736461; cv=none; b=qZwEh2W0yF3ydoVk7q2SZhWEDB63mPMFuZiqvXA6rDs5mCgvdS9EEFhzT9zs4BnyMRERhsRa1Ynmc+hvg066dMvmk13gxEfNHpxU1Z7V3SgEbrzNX1RLFMJ2nzU8fenPWp+MPLnZi6TfvTkRUNQqGOkkGHszizzS8ZXLyUwkBaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736461; c=relaxed/simple;
	bh=yZaV+sxozajM6fh76n/Q3fe/F45TDwcisoxUUnq5Ds4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwfzTqVbXU5JgBuHrtwlWzxNjZcscbZf9ovwVW1FmlHOKIOARc5NjvJ9su2jkILtLD7b5t/Y3NU95mV+uHv6Sb5sFKZP+w0Zde4cY1EuiIvtlgsySSQ8MtXlWt8NmvrXnKubG4YCXVaBaW8t+Pm41V5tiycxQRHVpoEv+Xh31qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vevfVSZA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=79J+s7OT4SJ76d+lyjBn2RVcHoFxmPfoh9N1Knl5A4s=; b=vevfVSZA7KAuh5przsgxSgsQV8
	ysrMUeZAVxJUYo5gD0+VZ41D2UZbMgkMLpZFtcjHNUpjBHsXkSXSRTkgKGjl/g8qk+s6mhO34XAlT
	CpfRxgLxPMtUG6A/pI5mzpaRVH+DH/R1ULIU136NFMHcn1xvnmsqsa9DJ8pmQaVE3pWa3x3olp7kp
	4CukeB9QrrrNx/N+TJVzYOkjivPowDuKK4YvGsz5oAw9N/58erBbXmxXuOpqjHwyDRiZbKxKliw7s
	oUfKZKAZPrgjGOKJH38RH7J4YiToNPDudJIXI2lEy+ut8ltJ9eVXhC70SIDaeHropF8vnJpPzGLPR
	djEmsPyg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Th5-00000002KNj-0pDY;
	Wed, 24 Sep 2025 17:54:19 +0000
Message-ID: <e7c29532-71de-496b-a89f-743cef28736e@infradead.org>
Date: Wed, 24 Sep 2025 10:54:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Sep 24 (htmldocs / pdfdocs)
To: Mark Brown <broonie@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <aNQC_Nv03iyldOqP@finisterre.sirena.org.uk>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aNQC_Nv03iyldOqP@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/24/25 7:41 AM, Mark Brown wrote:
> Hi all,
> 
> There will be no -next releases Tuesday and Wednesday next week, and
> it's possible I might run out of time on Monday.
> 

When I run 'make O=DOCS htmldocs', I see these warning messages:

../Documentation/Makefile:70: warning: overriding recipe for target 'pdfdocs'
../Documentation/Makefile:61: warning: ignoring old recipe for target 'pdfdocs'


Is this a known issue?

I have seen these warning messages for several days recently.

-- 
~Randy


