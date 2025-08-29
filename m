Return-Path: <linux-kernel+bounces-792500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E418AB3C4D7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070211C8462F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1912D12F3;
	Fri, 29 Aug 2025 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="IDT+sdmg"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D629E10B;
	Fri, 29 Aug 2025 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506596; cv=none; b=C6Fq4heyBORCB8S07AjNfxG9KmOHSjXsYGAk+st0vH/rt1upsyJFHxJqPtDy2eMGpVr8Cj9QiotxkhQtrpltSzI66zy3YZ2+ePONTPmAtMoKHkTm9nHRTln85L0n4S7iHBXg0o3BaW/5H1CqzFULrZtCCd5wTX4hL45zxTkkLxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506596; c=relaxed/simple;
	bh=LnrThKrEpQ24kePsrpvbmzEfdRYOsirO/t/abPlh8QI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D4BAcj9EKZ32IYKS66zZ6SfEupJHgiWtUweoP/AAFAIZ2KugENLUCjEqaEKjD4h9ZgqzdOrgy2uXCnRZDOjYUdbdEcVFjtxnGCr3WYTbQBcfo6sdTzNuLnIF3FR47idsKmtIZ9dI66Dtq0yQfelWMoI98qoSNJcxOicTwFU8elY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=IDT+sdmg; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2889540AE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756506594; bh=7HAaOu7AXHORrFxnxCD3awBn+iaSr3q0I8AS3Zg5wlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IDT+sdmgtOdckzlqJ/MUOzQqFm9iZ2oVjFSffgA+a4J3ZWpG6JDolO6SVKSwN1MBF
	 fl/CJfFw83ewEx1V70ZL3we+qb532tQQUu/hsn7aKBUotJhygmQMO1HYgib3UTk8Q9
	 UYxMy8aKkNU0BXsKKNNNS+HpG1gxaGY8P9OE+Vd7jmmG3bMOfJg3mMLh4JnBVU+IbX
	 QjBUexuUsC/wPJPzI5/locFsYCwhnSZfzAVW8LdnSxClbpISqbhaxowBToUxlvyuYn
	 vKgsjotFe/AZ0jxUCA2Fan1vZhjB0CnwQzXH1H6ELBzQQkpb5S3zRcZmJmpXDQ5J3z
	 TYvEwi732/n8A==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2889540AE2;
	Fri, 29 Aug 2025 22:29:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Vivek Alurkar <primalkenja@gmail.com>
Cc: Vivek Alurkar <primalkenja@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] Fix typo in RAID arrays documentation
In-Reply-To: <20250821051622.8341-2-primalkenja@gmail.com>
References: <20250821051622.8341-2-primalkenja@gmail.com>
Date: Fri, 29 Aug 2025 16:29:53 -0600
Message-ID: <87v7m53gny.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vivek Alurkar <primalkenja@gmail.com> writes:

> Changed "write-throuth" to "write-through".
>
> Signed-off-by: Vivek Alurkar <primalkenja@gmail.com>
> ---
> Changes since v1:
> 	-Changed '"write-through" and "write-back"' to
> 	'"write-through" or "write-back"' as suggested by Randy Dunlap.
>
>  Documentation/admin-guide/md.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
> index 4ff2cc291d18..04668272c0ee 100644
> --- a/Documentation/admin-guide/md.rst
> +++ b/Documentation/admin-guide/md.rst
> @@ -758,7 +758,7 @@ These currently include:
>  
>    journal_mode (currently raid5 only)
>        The cache mode for raid5. raid5 could include an extra disk for
> -      caching. The mode can be "write-throuth" and "write-back". The
> +      caching. The mode can be "write-through" or "write-back". The
>        default is "write-through".

Applied, thanks.

jon

