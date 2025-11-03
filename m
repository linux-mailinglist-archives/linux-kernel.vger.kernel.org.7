Return-Path: <linux-kernel+bounces-883797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D1867C2E749
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DEE134C144
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EB7305054;
	Mon,  3 Nov 2025 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Yz8Hs29H"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1763A253B52;
	Mon,  3 Nov 2025 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213429; cv=none; b=HOjqi1o92oHu1gYbO+6VacbX4Ls5/y6RURT4qD5N5Gx3wNHENqDUUe9lbSOcP24Nd1pFKUG5a29GixAlsI/Ip2QoN1VhiYTCWG/P12nH7bD/BhEAU1HIv54LyiPkosgPe0BdIjhhDc/5lTFYjYUT91XcEMWfiI+dujTnFUsvFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213429; c=relaxed/simple;
	bh=W9kTvkXGhxlnwl6dcqTSkl4ipduPnacYfTO3z5ei260=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VU/JpMZmk5MfptLQdcgk6XXX45ngaQQ1lwGoxXHVO8BxpW2rOoWhU/reVLTGvDdKaRFHIqAVeZGFdmhq3n3+qngbQDxq5cvGLg2/q6PgdbrwlPeb1UfqS2D9VrM89KPo+gXqUaMeYjwiXxTt5uo03udhgutT5EnpJBcTasxLxH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Yz8Hs29H; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4F58F40AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762213426; bh=oKS1z7eQ8ip2lvPGXvOw3U9nANBvDh12FTm85ZuTH80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Yz8Hs29HpmpgYqQQwgOJ/YuK/qC77C0dYqYdyT1rqrP5pGAFxSsHpZrGIRm9G9txF
	 LR1Vb7QY3AXTLphekl5ivVQqfAe3y4IxQHEp9pDkaUs5+2p51GHW0rFRjU/XiSXMI8
	 8fJtihRCM3dvuzeh9XYCKlIAE9Fp2jcZAsb6Y5+Ppm0MJ+8ZHyWJnLApZKHxHDZKEx
	 Y+eViyDCGNJQgrx8v6hmHbrjTgoSSIXkfoS8pVMv3Nl46llmwG6HzEBsgV0ey5nq4b
	 nhMrn5I+wZWaXqqhUS7Kh4S5vHLXhcD+tp8ganxD1v1CAJBZDjNAoL3+8HYV+Mwpk4
	 uyleE4RaiwzMQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4F58F40AED;
	Mon,  3 Nov 2025 23:43:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lukas Bulwahn <lbulwahn@redhat.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: extend DOCUMENTATION SCRIPTS to the full
 directories
In-Reply-To: <20251103075948.26026-1-lukas.bulwahn@redhat.com>
References: <20251103075948.26026-1-lukas.bulwahn@redhat.com>
Date: Mon, 03 Nov 2025 16:43:45 -0700
Message-ID: <877bw6bs26.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Bulwahn <lbulwahn@redhat.com> writes:

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Due to commit abd61d1ff8f0 ("scripts: sphinx-pre-install: move it to
> tools/docs"), checkpatch.pl --self-test=patterns reported a non-matching
> file entry in DOCUMENTATION SCRIPTS. Clearly, there are now multiple
> documentation scripts, all located in Documentation/sphinx/ and tools/docs/
> and Mauro is the maintainer of those.
>
> Update the DOCUMENTATION SCRIPTS section to cover these directories. While
> at it, also make the DOCUMENTATION section cover the subdirectories of
> tools/docs/.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon

