Return-Path: <linux-kernel+bounces-852909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F18BDA36C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AC9C502D82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3422BF009;
	Tue, 14 Oct 2025 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SCX6Ugyh"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831D29D269;
	Tue, 14 Oct 2025 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454172; cv=none; b=Bk9/GBxPeWmgs0t9hAiGzv9EAdbGnUC1JE+UXB86PwnoK+7Fx5POnhh1dnW3A21b6xyc43WJjZINV6xqAIu6LU3AA+GwVTgmp9Ts+t9ip58l7ZWzXhyqXJ5Sy0pvbCYBSYVRkYq1eafcR/m/PbErvQcgSKtUMmU6D08rSchAj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454172; c=relaxed/simple;
	bh=31tNzzxc06hJ9qB6n3AoNoL+1awozPzzZjeGfAQItGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g7khQ3MbOjXWuVP9wMwS/n5F9XsL8XDjsPY9iKyQGXtJlzh/kbSuNPCuuSQ6auPQ6R3HvtLY0mg4JUx/iqax11OE5TJANvuZ+KWlTFicZWNt3DMNL9clo9swGo5WfIunXFGG/MZwmRv7tMq52UC/YfaR/+28NXmZgiGQH8KUcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SCX6Ugyh; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 80E3A40B1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760454169; bh=RAYMP5Au7e8ynwFPw7UUutsp++wbxW/bZK48bLnsnqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SCX6UgyhR8ISgSjYPYo9qDWhOelA4YyOT2xh3l0QJVGtIt1Qjih/PRnP0FvcoNbd0
	 LFvKex5KMQfiGCvc3S1CL99O7AzMzJ8whqtHlp6O4b5K/6UBust/NPiD+lsWG4jV62
	 dAE2GTXsQ4bBLqFIijRZkmn904c2+/uY9IkDJ3D6wmtP7ejnNA+Bkw/9a5nvmFmcuy
	 3/ldDgOQ8Y6ZgWqnNLcqe74y1dmfoFptH4kv7SUDqJtvRU+iRyOZOiiB/77s2BB0Gh
	 KNQxy0pl+b6lRpVSChCBOLLb1/HfadiB1jYlUBHTKnJ3VzrvgkUhwVhqOzn+92YdAe
	 8OxwCWi1+OVhA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 80E3A40B1E;
	Tue, 14 Oct 2025 15:02:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akiyoshi Kurita <weibu@redadmin.org>, linux-doc@vger.kernel.org
Cc: akiyks@gmail.com, linux-kernel@vger.kernel.org, weibu@redadmin.org
Subject: Re: [PATCH v5] docs: ja_JP: SubmittingPatches: describe the
 'Fixes:' tag
In-Reply-To: <20250924192426.2743495-1-weibu@redadmin.org>
References: <20250909022502.119560-1-weibu@redadmin.org>
 <20250924192426.2743495-1-weibu@redadmin.org>
Date: Tue, 14 Oct 2025 09:02:48 -0600
Message-ID: <87jz0xbk6f.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akiyoshi Kurita <weibu@redadmin.org> writes:

> Sync the ja_JP translation with the following upstream commits:
>
> commit 8401aa1f5997 ("Documentation/SubmittingPatches: describe the Fixes: tag")
> commit 19c3fe285cba ("docs: Explicitly state that the 'Fixes:' tag shouldn't split lines")
> commit 5b5bbb8cc51b ("docs: process: Add an example for creating a fixes tag")
> commit 6356f18f09dc ("Align git commit ID abbreviation guidelines and checks")
>
> The mix of plain text and reST markup for ``git bisect`` is intentional to
> align with the eventual reST conversion.
>
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
> v5:
>  - whole rewrite
> ---
>  .../translations/ja_JP/SubmittingPatches      | 28 ++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)

Applied.

That said ... this is not an RST file, and won't be pulled into the docs
build.  I would *love* to see a patch that moves this file into its
proper location under .../process/ and brings it into the build.

Thanks,

jon

