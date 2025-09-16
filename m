Return-Path: <linux-kernel+bounces-819189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F15B59CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD943B735F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44A0371E83;
	Tue, 16 Sep 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="i4T0pmca"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE049371E8D;
	Tue, 16 Sep 2025 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038176; cv=none; b=MoyRXKiZ/wNAKxDIyFI5iXGt39y2D7oBJ8CCSyLojo3O1oFengCA+CnO5nIYfifxTxMgEKvW6nKPrD+lEVDvR0y+vhYEa+6h4G9v3+izMICtgxorelgp+GwUqWRe8W8Bc45ujE2jEyALFIKlwnt3IlgNVIAkDARISXWKL9NQ7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038176; c=relaxed/simple;
	bh=wTJvJj6eRWdAYGjzYG9t3lToK4EhOXbyRLNUZQvHDHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kgvT3WOxOxCryr/ZvjglAdFQQHeh0dyPV687xZDqq5rhyZCYIpEvestAMdaT7EpRwlvcjCzAy069du4S7xpiLPK4hK9mzw46cbaumz6R/1GOk5pYxw022bOD22McaqWvEFDbcZQ3IaByV5JH1Km02e5Bh/OB5Q3M3a4dngpP3vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=i4T0pmca; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8F58840ADA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758038172; bh=GNHipi3gqWjiz9s6uaIWvAOuFHTUfXew1Fob6o15eC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=i4T0pmca4X/i+thMId7o+uDdMshe2mNRNvC3ZOmwcWzRCL9xdat83Ub2OvoHslzb7
	 5j/cEt2hBRDCBy4NtRUjyFXKfwtKQAY7+dtPit2qSV8u2A/o10LsQdLOFRxT/2P1bT
	 1Zs+2ls84dPcY115coSq3dIRPdW70nPoBSM6ql8cjvoeOM2UXKruIOjGOvg3237JQU
	 5F8UxmaPSDkWa8hByQZ2o+iG4UKQ2+hdBvzWlipsBj3Ee/uF0zS/8q/5NE10vkYRhr
	 /mfGczc8JPWnXukSgt0vSygfybpNDjlGYnjB3qKtytfT61/M+wUyY7dJis90te16sl
	 KgHMSzdzehNqg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8F58840ADA;
	Tue, 16 Sep 2025 15:56:12 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Taimoor Zaeem <taimoorzaeem@gmail.com>, andersson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: staging: fix spelling error in
 remoteproc.rst
In-Reply-To: <CANQcFN1s_iM8p5tYNz3Q_WyZki6Aw9_3HyoKwyoCVA9JeqG0eA@mail.gmail.com>
References: <CANQcFN1s_iM8p5tYNz3Q_WyZki6Aw9_3HyoKwyoCVA9JeqG0eA@mail.gmail.com>
Date: Tue, 16 Sep 2025 09:56:11 -0600
Message-ID: <87bjnafl2c.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taimoor Zaeem <taimoorzaeem@gmail.com> writes:

> From 10321c75f8fc1296775942f13cb3af78fdc8dcc8 Mon Sep 17 00:00:00 2001
> From: Taimoor Zaeem <taimoorzaeem@gmail.com>
> Date: Sun, 14 Sep 2025 16:31:56 +0500
> Subject: [PATCH] Documentation: staging: fix spelling error in remoteproc.rst
>
> Fix typo 'implementors' to 'implementers' in remote processor framework
> documentation.
>
> Signed-off-by: Taimoor Zaeem <taimoorzaeem@gmail.com>
> ---
>  Documentation/staging/remoteproc.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/staging/remoteproc.rst b/Documentation/staging/remoteproc.rst
> index 348ee7e508ac..5c226fa076d6 100644
> --- a/Documentation/staging/remoteproc.rst
> +++ b/Documentation/staging/remoteproc.rst
> @@ -104,7 +104,7 @@ Typical usage
>  	rproc_shutdown(my_rproc);
>    }
>  
> -API for implementors
> +API for implementers
>  ====================

Applied, thanks.

jon

