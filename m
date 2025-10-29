Return-Path: <linux-kernel+bounces-876662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D567CC1C084
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5BF9644DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8986B33F399;
	Wed, 29 Oct 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="s/A1U/KI"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A92F0C7E;
	Wed, 29 Oct 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753993; cv=none; b=ttP1+RLD/Rv7rBrfFDubJkPIYNJRZd8vQHKTB4OrF6Qfpos+jieimIP5BEYRSa6kROsGe4SByfo4dfujT2jV3sv4EFTDO9Di4W2MiZIk/AM/7+lsJyosKwuSDSgIj0Gl6mybnXVLjumKb1aE6HRYB2UDIF90S5E+DJfyU7zXEoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753993; c=relaxed/simple;
	bh=G4fzs3qtuEZIZn6cNxi72MzHtdibefMFo5Ql+qG0WZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DLW6N2Cqrod6cKLH9BrM/DGITa1xAPhB7Pq26NZKL0INT5R8mLLnTi+HioNU+iTlRvi6vYG4easixrLeq4vkEWJmyjlkC+SfFWgHQ0gapqPMGS5dY4T6wsD/U1+K3Vz56FDiKcIL1jjK71/752TuIgZ2kdZU6q2EYBZbRNAaww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=s/A1U/KI; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 74C68406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761753991; bh=lebOGd4UUNX/YiX1K71ON6xZSdBIVmPT1U7jx75xdHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s/A1U/KId6KvmqDVwRh2H7K+2wzytsyUXksrEVNPOLZodvb+WILqnipYulKSCfSJ2
	 6wJarniWzfulx7L5nsSQU4hVfYoWLDx86Xwc8vq8HTQnrY+SFE+jkaPE/e5so72t8n
	 fHPk0RP02PeosSlXFChYtzBUgwt9ohEgtqR+ajWGQchIS+1+NIlPeBbHGCkQJa0N4s
	 wDF8nkjWBmut2dvQ0xTQuXWRuvHsTLzxf9ShTcTKRqk99+bvIuHod1ALr9kNXhnewP
	 zX5UrA8domUoDfs3DVLTZ1WlXUKTO0gEWGd9qEjg1v9aFsn6FxJpTMUh9/sDGyIVtp
	 pDb19D5HQ5FpA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 74C68406FB;
	Wed, 29 Oct 2025 16:06:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Nadav Tasher <tashernadav@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Nadav Tasher <tashernadav@gmail.com>
Subject: Re: [PATCH] docs: replace broken links in ramfs-rootfs-initramfs docs
In-Reply-To: <20251025171625.33197-1-tashernadav@gmail.com>
References: <20251025171625.33197-1-tashernadav@gmail.com>
Date: Wed, 29 Oct 2025 10:06:30 -0600
Message-ID: <87jz0dr8u1.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nadav Tasher <tashernadav@gmail.com> writes:

> http://www.uwsg.iu.edu/ doesn't seem to exist anymore.
> I managed to find backups on archive.org, which helped me find
> the right links on https://lore.kernel.org/.
>
> http://freecode.com/projects/afio was also down, so I figured
> it could be replaced with https://linux.die.net/man/1/afio.
>
> Replace broken links to mailing list and aifo tool.
>
> Signed-off-by: Nadav Tasher <tashernadav@gmail.com>
> ---
>  Documentation/filesystems/ramfs-rootfs-initramfs.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

jon

