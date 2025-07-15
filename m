Return-Path: <linux-kernel+bounces-732482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D460B0677C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713D33B1131
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AC628C864;
	Tue, 15 Jul 2025 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="fX/fSS+7"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8F17C77;
	Tue, 15 Jul 2025 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609932; cv=none; b=kzIKWpZhH94sE0Xtw8uihWfJgDUOD5ToXc8TxeoIGcE/h96ZB76JegW/Kp/LqbdMi4JIxLrE26prhc1nwdiZJfHoCi0Z6807wiJYRHt/44/zQnAFmTZ4QPO6/TQcHohfGfZLhvSuayzzRzYdY7+XRy9Y8MSXzrKW9Jp+GlB4Jg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609932; c=relaxed/simple;
	bh=bTD8iFbUHNhctTHp0SpefPgnwr8ORho3hEmUMzcX5lY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F+Cst0J6IYNbv8k4omBwtJb3q1MbOBUCFvMu/MR4/wCgKXDjlY9cTA50M60phPi9JetfHERLZHz/L13riJxcjyC+i8Oiuwrpic8/CJRdBIzFBueUCYDNeuZy0N99DmFYbSlf/5StbbDuUBFXAec8kylkE4NTz+hUrtTnd+OTS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=fX/fSS+7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 177A540AD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752609930; bh=r1hKgcI6d0PWM41MIr//4GILP2VXdVZ/JyEEwQLZoz8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fX/fSS+7YBLz1bA+Gx27jke+FcBBGjoOaso2nSHQk1wWUrk2csKa+tjaMR3BSF+FV
	 rcGWgrdJ7ZcaXhECg8iN4irhWUrSPhaTkRgXosv5QKw9f6WLbbFxMDG4DN+AD1E2sy
	 3C4hLFu6QaBHVdNTDChODCVBbriha2s04N8u7+5kGEH7LoMjjxWxgdxWE/PLOJEGZS
	 Vx2wNcppZT5ZbpWFDL7B0aCj4IPPj9FX3DdYRlbMoOjLrTrQeFLnI/Rj1GEDFJ/gU/
	 fl5NNbSqrB8CoNZQTMoJSARhTHhxVLai7X4JhgALu5oiJoWowvaHb0gs3y1Uj8516h
	 0MikOt5o3PIaw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 177A540AD0;
	Tue, 15 Jul 2025 20:05:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Haren Myneni <haren@linux.ibm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Donnellan
 <ajd@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 0/2] Documentation: ioctl-number: DRY cleanup
In-Reply-To: <20250715024258.16882-1-bagasdotme@gmail.com>
References: <20250715024258.16882-1-bagasdotme@gmail.com>
Date: Tue, 15 Jul 2025 14:05:29 -0600
Message-ID: <874ivdfcdy.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> As the subject suggests: don't repeat yourself (DRY) on table introduction
> (ioctl macros-related).
>
> Enjoy!
>
> Bagas Sanjaya (2):
>   Documentation: ioctl-number: Shorten macros table
>   Documentation: ioctl-number: Don't repeat macro names
>
>  .../userspace-api/ioctl/ioctl-number.rst      | 36 ++++++++++---------
>  1 file changed, 20 insertions(+), 16 deletions(-)

The first seems like a good cleanup; the second a bit less so, but I've
applied the pair.

Thanks,

jon

