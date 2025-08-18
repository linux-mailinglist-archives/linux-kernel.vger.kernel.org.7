Return-Path: <linux-kernel+bounces-774030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B69B2ADC6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4ED97AD926
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAE9321F2A;
	Mon, 18 Aug 2025 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FS1soXLa"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286623770B;
	Mon, 18 Aug 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533304; cv=none; b=uzqxObiUW0V5/KwDbGE974y+FjJSI5MFNyebWi2+5q0TOrcLDMz7UaGA7zz0rM3Untp7AnczUbPlO0EA7ijp4VWjKvA/jRHEa1WGY2xCRbl7sgaCW2Jjds9q0+1gZLf0j/daCCEppHrPUjZ8YflPc2iu9lSvMSpKu47NIakpBUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533304; c=relaxed/simple;
	bh=ou2NodSL61SjBBx3oNoEL8d9FXu/qhf54SYinlYpEpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZgMDNRzIMf6C1EvsD5ClxxovJPOa43e4oQ6VSmdSN6I7NCnbnvwlTuhLwbC7PoGla8+5kqNNoHprCsJFKlmaUz88nO4IC+USEYcRtm/2Bcyxy5Vkovozj6Qt8dT+KI2+uNMueCPw97mRWW184W5bNT6MZmCp0bCVjUVZaMhgFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FS1soXLa; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5CE0F40AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755533302; bh=PgKB2qnc/bRPAL5RwjdygVePDYnntw4ZWdIavREWLBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FS1soXLa521ujJUbl/402whSSESTHg9tMk1J4yJXD61Dfi279n3ZYdXUxCAqBrXbP
	 7uzuyvggLkYoXlerUj63roxK9vLzAUnVybiJ8ADgblvGi5LkC02Rne6uNwELG05I+6
	 k7OuwJQBxt+73WjptP+fON5qK+HI/wyJ2vePn9MgKDmwsi+JYLLCa/Ou+Yk0IU287M
	 3Bs39RXJcFhH8aA2anPFcTcN3lReE6Ci8Tc22FjnWBpnYKR6l1Y7r40THAF4d2OISs
	 tpNV3csYjY/jWhXXQNvQZbmv84TtmdKAC3lrG0p2OxW0RInDuM1q8EFkKH6kheFgli
	 bhQXe4L9M8KpA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5CE0F40AB4;
	Mon, 18 Aug 2025 16:08:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: hariconscious@gmail.com, shuah@kernel.org, catalin.marinas@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: HariKrishna <hariconscious@gmail.com>
Subject: Re: [PATCH] documentation/arm64 : kdump fixed typo errors
In-Reply-To: <20250816120731.24508-1-hariconscious@gmail.com>
References: <20250816120731.24508-1-hariconscious@gmail.com>
Date: Mon, 18 Aug 2025 10:08:21 -0600
Message-ID: <871pp8a9ze.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

hariconscious@gmail.com writes:

> From: HariKrishna <hariconscious@gmail.com>
>
> kdump.rst documentation typos corrected
>
> Signed-off-by: HariKrishna <hariconscious@gmail.com>
> ---
>  Documentation/arch/arm64/kdump.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/arch/arm64/kdump.rst b/Documentation/arch/arm64/kdump.rst
> index 56a89f45df28..d3195a93a066 100644
> --- a/Documentation/arch/arm64/kdump.rst
> +++ b/Documentation/arch/arm64/kdump.rst
> @@ -5,7 +5,7 @@ crashkernel memory reservation on arm64
>  Author: Baoquan He <bhe@redhat.com>
>  
>  Kdump mechanism is used to capture a corrupted kernel vmcore so that
> -it can be subsequently analyzed. In order to do this, a preliminarily
> +it can be subsequently analyzed. In order to do this, a preliminary
>  reserved memory is needed to pre-load the kdump kernel and boot such
>  kernel if corruption happens.

I don't think this is right.  While reserving judgment on
"preliminarily" as a word, the intended use is adverbial, so this change
does not make things better.  The better fix, perhaps, is to say
"previously" instead.

Should you choose to resubmit this, we'll need your real name in the
Signed-off-by tag, please.

Thanks,

jon

