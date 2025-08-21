Return-Path: <linux-kernel+bounces-780416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9E0B3019D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FEDAC4631
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FDD343D7B;
	Thu, 21 Aug 2025 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="TkWY1O6K"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDCF33CE8E;
	Thu, 21 Aug 2025 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799226; cv=none; b=eax8OS+xbc2P3oQyjEcmf7AzAvpwIQNnXFmGNvKHKzQhGwwMufkEcZoqvcmh5kpgZuZwiwLIH72zF6OqVHL5EVUqKL+O96I7vFLJqnMP0P3+HkH9vqYtQMyAzWm6iuYRIuTOYhBKMWW9ZO14BsL3rjWxOp+26D46ygqr3NM7w6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799226; c=relaxed/simple;
	bh=ozmNUcy63K0EXVK6yBko48j5rKxmFUTvtSlsQjejRTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pIjIGNDK+IVId+rHGNq9UjJDI/PVuo66w+EtrBmMVwVpVWCTmY8BPJzOaEaHoUbf5di4xrro+k+LPSwsd3RIlYgG3K4a+G/BP5H3wVv6HM86LMvrWbUGq4LYRSfTAHBhdSWaIt3yzgESG1Sqf4FBu7rc00FgqUQKpIBeVK3t2Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=TkWY1O6K; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A192440AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755799222; bh=a0gmvmSgejJ2wUvpYDcnJHbLc5WuFKYJx7fuNwr+z00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TkWY1O6Kf57G+OF12yTCxsfPyp7zXK+uLHKjSL1COuAoElD4hrxRH7285jZFxQ8Fl
	 NXbc6WHeJ/maF2sDxMq8CKmHdcPxiaUZc6TVqJ5Slmh62ITBeO3qoZ1x5XLs1n0pJS
	 +kjDR+2L9CJztQyXepfonjysKYWPMxFv6DM+pN7XzIOZPveo2xYXzp4iCRA0NBOP+g
	 517h1jyD7Z/m3K5kBJS5o6KhPwgWJVHQMzwzEG76ntwutTkQ4QFWyyLjiXmPW8fFfy
	 HkP0yP8o+JXK7qM4UzOWbBS2P07niRIY32t//LWiWjCwoS2nxYf8NxgB1l7dHzOiPB
	 cs8GKT1uhsyIw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A192440AB4;
	Thu, 21 Aug 2025 18:00:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Rik van Riel <riel@surriel.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: sysctl: add a few more top-level /proc/sys entries
In-Reply-To: <20250819075456.113623-1-rdunlap@infradead.org>
References: <20250819075456.113623-1-rdunlap@infradead.org>
Date: Thu, 21 Aug 2025 12:00:21 -0600
Message-ID: <878qjc7dxm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Add a few missing directories under /proc/sys.
> Fix punctuation and doubled words.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/admin-guide/sysctl/index.rst |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Applied, thanks.

jon

