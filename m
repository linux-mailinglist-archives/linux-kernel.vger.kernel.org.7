Return-Path: <linux-kernel+bounces-780406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF6BB3017A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D5A1889BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4CA341677;
	Thu, 21 Aug 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gT/RNrnP"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C252DF3CF;
	Thu, 21 Aug 2025 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798685; cv=none; b=mHPz0KDEWFJQcUzy0IYNJgdD3ixDzJ6dPmYHlDyxHoQMW2sP+sojH1O+S285R6KOqT8pzsqZjZpgc59BQYmCagv6jHq0Z861DGgj8SuhZjYpivdPlsk0XrAqx7j/LH7vHtWiBzaM0cdm/r0s5HBksaPdv9phlzGBnfvs9QqYZLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798685; c=relaxed/simple;
	bh=wCAFsgAQdAjADY6fv4y4Kojg0L7QZpmm1WOfbOukUP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u4gY6iAtJXP5d28sD7jmuQkYKmATmdHmNWR9QQSCc6xZqtM5qfwnY3fm+YMYRF/5uvQ6jxoNihwR5hITRnhd1jPvYVxhFBLOzYOaKkYexBQgg1APerBDoIHX3CTcBlUsHNJarVnGsFAGyobayDvYOKAzFIz9K5KwfGIw9T8spxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=gT/RNrnP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6C4D340AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755798683; bh=hBwRWuKw3Z3dZICd18TkYfxbhcfBicekVpzn2o+lql8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gT/RNrnPVvetSoiiy0kOUBIgUSfIdoY1gUINWdsu8TxG6FpOT8Kz3oTB8lz9NnCl5
	 fVqxTQmtcGmQbokDePhl+mNxKcG0mED+PSA4xhOSHHdLRB03LrA2nNeMBzxX2QfHJu
	 R8f6Qn4KxBAgh9161bNlOF9VA6lKcJ7hp4fShqnqpf16JsRzUTecHcAa5BLEoBwtkU
	 1iUCzXKDvUPgot14Ishg9x8xOepJiButZXUTuSedRNQ6ZM/dEDvaz9pk0lNd5PccEU
	 MJdSwtZYzhYCk3ad0UCYiwz7QXviKCzun4rv9vSFbz2IR+M7M8qDDmMvtnjpcfPjwZ
	 CjsV7G0hRwQ/A==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6C4D340AB4;
	Thu, 21 Aug 2025 17:51:23 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux USB <linux-usb@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] Documentation: driver-api: usb: Limit toctree depth
In-Reply-To: <20250820050416.25219-1-bagasdotme@gmail.com>
References: <20250820050416.25219-1-bagasdotme@gmail.com>
Date: Thu, 21 Aug 2025 11:51:22 -0600
Message-ID: <87jz2w7ecl.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> toctree index in USB driver api docs currently spoils the entire docs
> headings due to lack of :maxdepth: option. Add the option to limit
> toctree depth to 1, mirroring usb subsystem docs in
> Documentation/usb/index.rst.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/driver-api/usb/index.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/driver-api/usb/index.rst b/Documentation/driver-api/usb/index.rst
> index cfa8797ea6144b..fcb24d0500d91d 100644
> --- a/Documentation/driver-api/usb/index.rst
> +++ b/Documentation/driver-api/usb/index.rst
> @@ -3,6 +3,7 @@ Linux USB API
>  =============
>  
>  .. toctree::
> +   :maxdepth: 1
>  

It's still kind of a mess, but that does make it better.  Applied,
thanks.

jon

