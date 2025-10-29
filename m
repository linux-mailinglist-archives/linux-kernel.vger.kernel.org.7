Return-Path: <linux-kernel+bounces-876644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8A4C1C3C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1394A802514
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4E2EC088;
	Wed, 29 Oct 2025 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="b1RkBQGD"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C21A255C;
	Wed, 29 Oct 2025 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753787; cv=none; b=CjK41x+c74xaFKT7tx9iLy8smjQ4EVKgZRxlTjuLCNdXumYbMzzohRxlZ6/KS27RWXN2d5MZ+3pnfRyDzYNd2gJOF8S929lZWh6uGEIV9nFOMCEKzRp+nXrxqKxIFCh8s52P1YBKuZiPqFN+J7SXJfj9jerRdRGlfN4yGY1eASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753787; c=relaxed/simple;
	bh=uRNPV9MngKW+lezm1n1ktFoo6wCvoNd35Z5TJVwbwf4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pnBvhI0Yo0Pnv0eZoJCCN2VsJ3RJtLdrs725j1JRK+n8X/utQnvrLXBKBGJ1CV/cPZAW2CfHvupng/4/Cd8m7CPQwZqIC8dfB7uTdgY73ot11j135Qy/mh1DnYFrP3uth5mK9YRFI8IG9bHd/nDSqrlkhIGpDmkDTJh+aYn455o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=b1RkBQGD; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 15B08406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761753785; bh=QtzHjZyXHyMCInwQmhq+8jXm4YdKxK8TiahIvSTGhq8=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=b1RkBQGD9jhQSErffieuRihnAsquzKFoDYj22OS9bxmpBzx14/emKDJ7zAKUfVBwW
	 4Z0glreF3/HPu0VInfok8qV8LQ0T11NgJXQa2iKSD076cSEIoAlHwtFRCjCz4SLjOe
	 /e5dALvYeTBYOv0kajxNhMCUaVEt5jIFweU4rEQmz+GG8Q9+rm43rdvVCtzKe5G1KO
	 PiykQx06/VnUM8pXP/opKjpWWVQcdPBsH9iSYppSyvMkXDYPPFlrHLIyzQ52QMnibl
	 cVvFdKuqiInazDtNNPMFg452mX/cCVs7xO/yuDq7BPaVjV580wK6utVQgASpKac/U3
	 uaf54QyY5OFZw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 15B08406FB;
	Wed, 29 Oct 2025 16:03:05 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Alex Shi <seakeel@gmail.com>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Dongliang
 Mu <dzm91@hust.edu.cn>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Chinese-docs changes for v6.18
In-Reply-To: <CAJy-Am=nupkp6V6L1oA5DPxFNKq=4qM=ZVxxLeAw+uSQGSVhrw@mail.gmail.com>
References: <CAJy-Am=nupkp6V6L1oA5DPxFNKq=4qM=ZVxxLeAw+uSQGSVhrw@mail.gmail.com>
Date: Wed, 29 Oct 2025 10:03:04 -0600
Message-ID: <87o6ppr8zr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alex Shi <seakeel@gmail.com> writes:

> The following changes since commit f44a29784f685804d9970cfb0d3439c9e30981d7:
>
>   Documentation: update maintainer-pgp-guide for latest best practices
> (2025-09-09 13:43:55 -0600)
>
> are available in the Git repository at:
>
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/alexs/linux.git
> Chinese-docs-6.18
>
> for you to fetch changes up to b5750c27d395f865030d2ab084c447e1df718dd6:
>
>   Revert "Docs/zh_CN: Translate skbuff.rst to Simplified Chinese"
> (2025-10-26 21:33:45 +0800)
>
> ----------------------------------------------------------------
> Chinese translation docs for 6.18
>
> This is the Chinese translation subtree for 6.18. It includes
> the following changes:
>         - docs/zh_CN: Add rust Chinese translations
>         - docs/zh_CN: Add scsi Chinese translations
>         - docs/zh_CN: Add gfs2 Chinese translations
>         - Add some other Chinese translations and fixes
>
> Above patches are tested by 'make htmldocs'
>
> Signed-off-by: Alex Shi <alexs@kernel.org>

Pulled, thanks.

jon

