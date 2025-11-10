Return-Path: <linux-kernel+bounces-894031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74D5C491EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81233B169E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4030F337113;
	Mon, 10 Nov 2025 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Q/zHzu47"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544884C6D;
	Mon, 10 Nov 2025 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803892; cv=none; b=LpYLwdqiXrNf6aodETg4sZZmpkWsHfAl8NrkAPIRcYIJPRzQQHcgHIlRMzw6+NNad3sd+TVXl8LpFEGgT0h4C4fxFjyp1JWx5T6K64KFfm/snImKAkXRs7x0BEXU5cxxlknG6gPTeuRIRQf2PUPSLORRXQxzI1kuA4nAubzoSYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803892; c=relaxed/simple;
	bh=2Tdh3rr5p+Mq9a2iezY7uO7x9ZUiudD3Ko1UObUXAfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EQqEh+wzb/8Hb8JTLKOKaaANc0ZWEYshwlXzDSB+BT8VLTV87YYiOoWqPGtg9AugP/ldm5et6LggQ8UeV4Xzf0Or8umD7FoykAIUJkpKGkp2rABlxUt9cUiDTViBI6RiqFskz2Kh9oFGLzP6yk8JF49pp1rwAiO3wnJotz0ZT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Q/zHzu47; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8172E40B69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762803890; bh=pP62DFCDpaIiEyGSvTP2N39n/fpS4sGBCTJcgtcVUj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q/zHzu47/Gq0mFcyW4oJHSBrLaU7by/ctuctxg46XehAD8IgTZp86nKy+bPod1ZwO
	 KJoeosDtbsWZ2vVnBy728nUJW/irpXRTTzK5N8QMiwlJJugAnPhNYbAuCMVZIZ2W8K
	 RQacA60V1sitUTdXvhtHYhJaIh51XQBNJZxiUolmZEByTTkWDdOCJlkxhJcXVYFZkU
	 fxIv5ojwc8wK5NPvrLxiplf3SNxHdYCeSDf4WQKPAOt70QNtustH8fnXv33fW+CUJm
	 g0VG4jz3rVAFLyZBRcH2IOEwP9wJ2Ra5iH7KSXFqRTXin9bKVNp0Q9TwB1hTvOFcbc
	 XDNR1LH2H4cgA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8172E40B69;
	Mon, 10 Nov 2025 19:44:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Alex Shi <alexs@kernel.org>, Dongliang Mu
 <dzm91@hust.edu.cn>, Federico Vaga <federico.vaga@vaga.pv.it>, Randy
 Dunlap <rdunlap@infradead.org>, Yanteng Si <si.yanteng@linux.dev>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] docs: doc-guide: parse-headers.rst update its
 documentation
In-Reply-To: <1f9025dc98dc58da3cc31f3343d5027f351be338.1762594622.git.mchehab+huawei@kernel.org>
References: <1f9025dc98dc58da3cc31f3343d5027f351be338.1762594622.git.mchehab+huawei@kernel.org>
Date: Mon, 10 Nov 2025 12:44:49 -0700
Message-ID: <87ms4ty8ni.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Besides converting from Perl to Python, parse-headers has gained
> some new functionality and was moved to tools/docs.
>
> Update its documentation accordingly.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-doc/9391a0f0-7c92-42aa-8190-28255b22e131@infradead.org/
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/doc-guide/parse-headers.rst     | 195 +++++++++---------
>  .../it_IT/doc-guide/parse-headers.rst         |   8 +-
>  .../zh_CN/doc-guide/parse-headers.rst         |   8 +-
>  3 files changed, 103 insertions(+), 108 deletions(-)

Applied, thanks.

jon

