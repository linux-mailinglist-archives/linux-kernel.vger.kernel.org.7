Return-Path: <linux-kernel+bounces-823397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 338F8B8650F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7DBB60876
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAFB25DCEC;
	Thu, 18 Sep 2025 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YW6Tz8wp"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA01E3DE5;
	Thu, 18 Sep 2025 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217682; cv=none; b=I2xpqShKWJnFHcVLIkSDV8V28KHcaazHmt/kbE3CZetlp0uGSVmFDduzwbLoBsKWqEUbxuc6PxZvbijFwqP4ddOBnroeplf+dbOckSLheyQmfVAmx/fPcajgRqzl1KW9FcUrE1xzO/HKXSzmd4gGNCOXVluEtTiq4thWmqLcIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217682; c=relaxed/simple;
	bh=DfSwm2ER3Yj4uK2QlEa60/GiAXDirNZ6AIe8oxVcEpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rz8yd7EwFMOoPXv0CNW2RN/wKyKsTOv1IQJUa4FglZRTPQtCylMGUTQCQQ6o9PNxVvo6F8SSWMR1DkzNRCjAg6LD00EpkNO826krEV8/5X7LpUazjyqLj+3vj/Ugo3KolHIEIxdBJRKQRliifNrCuHKaFAwwlEApBWwi9ZZZJqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YW6Tz8wp; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E92BF40B15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758217680; bh=y3mcXDZuUDAj85GwNusgpkA9hwg+p7xvaXbhlKIF80o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YW6Tz8wp4paCDN8pyX13DknoPv6/ibT9tTj9X42Un7pJsm0P0VSP6HkL1yqk5KBkr
	 4XFCeHP5BVcwLdATKpw6wDYV6lX+y2pKcaslekL9Gvjh3DF4fmSNwLPKoZIyRC94dS
	 8AvStsA3/tRiHIFo2iPrUyorNcWEsz9wHlvZvisbkXbr2FykUHXS41kXxXHzX8sXu/
	 awWHXh6CGD6eG8558M9cARDtDsDXhy4gtJh+lEUCtM8XavTCm9Sf3byj7/rmP1Sg/r
	 cjhH68b7IifFgPHBNgXis48DTQBWvNrdCrRVl3HMvC+9DvauZtVxoC0U2yxJXKZlZL
	 Ba7auOBtcwXAg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E92BF40B15;
	Thu, 18 Sep 2025 17:47:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH v8 00/24] Split sphinx call logic from docs Makefile
In-Reply-To: <cover.1758196090.git.mchehab+huawei@kernel.org>
References: <cover.1758196090.git.mchehab+huawei@kernel.org>
Date: Thu, 18 Sep 2025 11:47:59 -0600
Message-ID: <87ldmb7iuo.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> v8 contains a bug fix for ./tools/docs/check-variable-fonts.py command
> line together with a new --deny-vf argument to it, plus addresses
> a couple checkpatch warnings. Only 4 patches changed: patches 1, 2, 4
> and 5.

OK.  I have applied this to a branch called build-script in my tree.
Applying it to current docs-mw (or docs-next) was a bit of a challenge,
due to merge conflicts with the makefiles, but I got there.

This work is now merged in docs-next (and will thus show in linux-next),
but it's not yet in docs-mw, so we're not committed to putting it into
6.18.  My current thinking, if all goes well, is to shift it to docs-mw
just after the merge window.

It all seems to work for me, with one little oddity: the "Indices"
section in Documentation/rust/index.rst (which is protected by the usual
".. only::" block) is being included in the htmldocs build, leading to a
spurious "Indices" entry in the left column.  Something about the way
the rust directory is being build sets "subproject" maybe?  I haven't
had the time to figure it out.

Thanks,

jon

