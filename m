Return-Path: <linux-kernel+bounces-800853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C29B43CFF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BC95E0EAA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745E6301469;
	Thu,  4 Sep 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DnmiXVU/"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347CD2FE05F;
	Thu,  4 Sep 2025 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992160; cv=none; b=IvSrk/cKc/f04Cwkk21bi0dzIgGwjlY0an0lvIPHgcPEeyI5Fbqfq+AJlUCTLdBiXyHa5McvIwQIp8xiatZvh1aD75f87J7wIHT9tLH+Dqmo8Wt9f2RS03l2tyB5iNaNFIk33wllYzhh139xYMUpF4gwa/V+GhFsElLRChq0qRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992160; c=relaxed/simple;
	bh=MJoKl3nZIVYgflwLVJKwukC+oP7B/0y6TE5o/EX3ifM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YMdyB/CGFVxK07FSsdcqXndjZya93DjG1Jkyqz91O8s9yZqWeVPrTC49LyUA+tmx1cFV3HVobg7vCAg8mzTIknCgLiZGybNGxhj/Ai9qFz1riGoBUat/lr+GA9KzdX/FypLQjkIlzLNRc/dvSXils82/aJ++tpcDjfwkWuacevA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DnmiXVU/; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0D88F40AFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756992158; bh=BK03jMMk5Bp5Pi3nrPCq2zhRBB7WcROGWUToeOzSCzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DnmiXVU//AC1Jg75YFm0yovk+hYyjXFgntRfysI+fFYYudlNaJsAWvPfrNzAYOEAh
	 lt1KpN02CkUAO4tKhvNJXRFb7d8j+s3J1hG+egfAiotqu1vlIAbiGtuBj3ByStAWF6
	 atqwVZfVUmLHiWtLgMz/ljsFjjnBcWo4ubYQV3FrXyCDpiUKHHH0gJRGMaRhXTnvfT
	 pDmBMn8ZYASgc6rfyu2xfzCDOnSUX9U2VXd+FjoPH6JUGPt2NJyeZ9idFcm1NcsyxK
	 eegBgzkxwuNWqu8KCoMlT5JVCXeAMTe2OHZSWfsbirktBVIXi/U4UatTHePsav0wj2
	 UhBldZ3T7L2Ow==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0D88F40AFD;
	Thu,  4 Sep 2025 13:22:37 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: kurita <akito5623@gmail.com>, linux-doc@vger.kernel.org
Cc: akiyks@gmail.com, linux-kernel@vger.kernel.org, kurita
 <akito5623@gmail.com>
Subject: Re: [PATCH] docs: ja_JP: Update SubmittingPatches for 'Fixes:' tag
In-Reply-To: <20250903113552.2010371-1-akito5623@gmail.com>
References: <20250903113552.2010371-1-akito5623@gmail.com>
Date: Thu, 04 Sep 2025 07:22:37 -0600
Message-ID: <878qiunyhu.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kurita <akito5623@gmail.com> writes:

> The Japanese translation of SubmittingPatches is based on an old
> kernel version (2.6.39) and is missing several new sections.
>
> This patch adds the missing description for the 'Fixes:' tag to
> bring the document more in line with the current English original
> (Documentation/process/submitting-patches.rst).
>
> Signed-off-by:Akiyoshi kurita <akito5623@gmail.com>
> ---
>  Documentation/translations/ja_JP/SubmittingPatches | 4 ++++
>  1 file changed, 4 insertions(+)

So I only saw this because of Akira's response; something in how you are
sending your mail drives SpamAssassin nuts.

Thank you for working to improve our documentation!

In addition to everything Akira said, I must express a bit of worry
about updating this document piecemeal in this way.  Backporting
specific pieces in this way will yield a result that is not a
translation of anything - it is a new creation that never existed in the
original form.

It sure would be nicer (says the guy who has no ability to do that work)
to bring the translation as a whole current.

I'll accept pieces with acks from people who can properly judge them,
but I would prefer to just have a current translation.

Thanks,

jon

