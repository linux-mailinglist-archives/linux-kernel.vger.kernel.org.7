Return-Path: <linux-kernel+bounces-765431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B72E7B234E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AF36E1B93
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D92FFDD4;
	Tue, 12 Aug 2025 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Xv1u1woK"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBE2FF17D;
	Tue, 12 Aug 2025 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024028; cv=none; b=CczE9X5Dyj2FeLInVS8J45FfG2nxWBkI3VlYbjSoX46Yz7B/f6waA/RKwXQmUg22mIsrhqquHRFt+CViwVjMc/IILJQmQqfGa2X1dJc6qxf/41TOPcAcyoS92PFhurVsLtAQVjRj1+YTJTOuiiiC/d1OzvWQdXklTqnTuVYcA5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024028; c=relaxed/simple;
	bh=dMHlKk75+tPnXU4KgT+bLdlEkx19Sn3kugZwFqU4Iks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dnndSbC9qZwa6fhZYJTsuBWX/2nru3vyy4dXmVCPde1YiaUB3tZdrfQG1gRVrZ/7VPvEheRRJy7p0yyOVqfhfa2yZOU8kDH3WxHBBFMePMV5ATx+5DvrI6ZmpPwMmIvBBx7m2yrswwfQXpZnUMjtexkE1lZhQMD6W+uqWtRT0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Xv1u1woK; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1CFB140AD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755024026; bh=DUXEjNQofN7i2jKB1Vi4l0ISHfcgWa6MdCHIYt9HVl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Xv1u1woKx6mh/a6vSumZBaYe9ACuOoZ3pmXhWevUh+b/+DaFYHF0Hd5z15zp7R5Sa
	 tYoIvCHjvBw2byZ/CdrXHq1PcFfsyqPM9a+xf1rsM4vl62ohPj5LRrf73iXp8zvdMx
	 meFWlktA5ULg2Fycs0QAtbhVwQ4fyojA1SJ2Ecs67GfaSBP+I0g1Ss4CDF//1GK6ks
	 jYbTP6lEflwxMAqB8P3R+U5seTRvf0vL0FJlvxoxymiO6BxJZUZ+O10o5atcXUCA6B
	 9V6q9uNfqhv0D5mBTxTU9p0rEFCfgm7Cy6UiTx12Kk2LIl4u5Z0VGEfYK5xd8fyv25
	 XUQQHmw6gJ0uw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1CFB140AD9;
	Tue, 12 Aug 2025 18:40:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>, dhowells@redhat.com,
 brauner@kernel.org, max.kellermann@ionos.com, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] docs: folio_queue: Fix minor typo in folio_queue page
In-Reply-To: <20250810235346.4153-1-krishnagopi487@gmail.com>
References: <20250810235346.4153-1-krishnagopi487@gmail.com>
Date: Tue, 12 Aug 2025 12:40:25 -0600
Message-ID: <874iucfko6.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gopi Krishna Menon <krishnagopi487@gmail.com> writes:

> Specifically, fix typo 'hese'-> 'these'
>
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
>  Documentation/core-api/folio_queue.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/core-api/folio_queue.rst b/Documentation/core-api/folio_queue.rst
> index 83cfbc157e49..b7628896d2b6 100644
> --- a/Documentation/core-api/folio_queue.rst
> +++ b/Documentation/core-api/folio_queue.rst
> @@ -44,7 +44,7 @@ Each segment in the list also stores:
>   * the size of each folio and
>   * three 1-bit marks per folio,
>  
> -but hese should not be accessed directly as the underlying data structure may
> +but these should not be accessed directly as the underlying data structure may
>  change, but rather the access functions outlined below should be used.

Applied, thanks.

jon

