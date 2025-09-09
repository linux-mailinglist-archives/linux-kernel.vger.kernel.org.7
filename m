Return-Path: <linux-kernel+bounces-808918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CE6B50689
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0D8443797
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A663570C5;
	Tue,  9 Sep 2025 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="X92MdW+w"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD92C225415;
	Tue,  9 Sep 2025 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447080; cv=none; b=HSGt1GM3lPoEKQG1NOh2iKqG3v3jrvhGsKN4ggY1Gc5asbS4ZBNU9Y7i0VC+8gcQ/3FY+VQjuFSsMuJc7KdCzuweON9AhjWAcVdXdjVD5V8wOubl7QogkOCt5cY5hKRipTa3eDuxzhQJ1t4OPnxIe+UIc1HkSD8TZsLrw4cNrVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447080; c=relaxed/simple;
	bh=Hjvykh5ysrjFWn9uNw0Avop1oR99O0VPqmt8WvwIgAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bjWJWRnnoxzChBvQWFZj0V6WINtyveZyNMjufU069wBM1FO4WCAfqoPbsfc0dEsjdsURkmUwSf4UFodjE3oh9sSGhIsc6p70at1QSEXDmpndOgSl0pqXgbOADkL3hQWSl6l/7LbNw1pYsjbxOx5U+1R3MaZUdOMNdqttFqtQg4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=X92MdW+w; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AD82940AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757447077; bh=tRaqaf6ukoG9IqHA/H4Ez3b4WygU9CcskI8SBTMppgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=X92MdW+wsCByX6vsq534bXGrFsLXmDFXIzBlP7wLUp5B7AKMCCE27ccDYJSbvO8dO
	 WRv4LVSyoxRPfVsCYTRSMdkIe2IgQsM0LcJ1Le4Bt3BqXDFp0RyNwdOUU9EKIN0S5q
	 ZUyG23d3Oas21AFuoEAObzAIGmj+ZDyB4F8u4zb3k/g+7e+0UP2en9Mko9DSVmJ6OY
	 n+Z2KTFNwNSbp4Hzcz4LCXw5s+Y5CMNNbKUhuYTrfNUeSxDAamcUCTL49TzOVD+srQ
	 9ie5lcik43RZFYfh7ELCNaY3gTOVdAuEo9WM9jwkU0xqEP1SxW+gviYc6XboWjJr73
	 bkoNuST15+lXA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AD82940AF9;
	Tue,  9 Sep 2025 19:44:37 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: update maintainer-pgp-guide for latest
 best practices
In-Reply-To: <20250902-pgp-guide-updates-v1-1-62ac7312d3f9@linuxfoundation.org>
References: <20250902-pgp-guide-updates-v1-1-62ac7312d3f9@linuxfoundation.org>
Date: Tue, 09 Sep 2025 13:44:36 -0600
Message-ID: <878qinv2aj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> Freshen up the maintainer PGP guide:
>
> - Bump minimum GnuPG version requirement from 2.2 to 2.4, since 2.2 is
>   no longer maintained
> - All major hardware tokens now support Curve25519, so remove outdated
>   ECC support callouts
> - Update hardware device recommendations (Nitrokey Pro 2 -> Nitrokey 3)
> - Broaden backup media terminology (USB thumb drive -> external media)
> - Update wording to follow vale's linter recommendations
> - Various minor wording improvements for clarity
>
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> ---
>  Documentation/process/maintainer-pgp-guide.rst | 158 ++++++++++++-------------
>  1 file changed, 75 insertions(+), 83 deletions(-)

Applied, thanks.

jon

