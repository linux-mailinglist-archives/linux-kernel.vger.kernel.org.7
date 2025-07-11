Return-Path: <linux-kernel+bounces-727581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB8DB01C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497B63A9A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2482C325A;
	Fri, 11 Jul 2025 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="NiRaG5fK"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9252C3255;
	Fri, 11 Jul 2025 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238316; cv=none; b=uHdxrZolHPHSykd3pRNdLLmhy3UGzWdO67dCEsWgekMaKCpBkKYu+7cjm7oCHhXnJHCArjzz9RG1KT/y2vdeycv3rIbIuuKGnVHlooJgD/U4Z/qwskeY+IDdz/oxu+z0ij/98Dab5xd124QAe9/nUrjS/ZTErADa/eo0Xuowvj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238316; c=relaxed/simple;
	bh=3AWkZ0s/sd1/QOxaopIuWTXz/ibv2bkQR7ck3+1BeNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VYoNYjajCjmAONXTeRnGKqnU+m9WM9ncdNDCChu/G40ZMxw6pki+OWEqjJUksdufDivuLbPNPxfBDG6Uf5ISnTQDMMGNuR/zT1D3PF3+P8hItAvYHKv4xYlrA7CDcdjyrX18Y+ZeSFzm/q9nX0K76keGkbaIfdVFFLCOPmvsAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=NiRaG5fK; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 621E740AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752238314; bh=pvRnJ6fGOQ7F967zLvEgbnXWICTTFrxnNk+K97WLwE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NiRaG5fKsjN7WffXbrhAuhdRprY1EBIqGa1L83BZwvFypcbZrp+r3mPQ0hywM8vjo
	 +cx4yzl7BGI0TuM4Pa7Pb1PiJjRO2jaTwlHGnsU7tKeUs8Fq5Xgl5OaOUh4Zt/c/hV
	 0uA+3oP57e4ewPqzGNF+FWCQDHzCtosTGscCRzYF7rZf1gj2lbHEosU+Y2KgN5m+Qd
	 xSChMHMt1YlFC9OPHLMO8xd00zPUk/HOMkRjfgSKcXOorCPCzgsTUsjLxohfgsrGY5
	 l/JixLrhTLWp2kb2VqstwbFsZwCDOI+3+MF5fjnv1NJaDVMghYk/a5UnwQVAE4Vild
	 zyZupmv2jCjvw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 621E740AAB;
	Fri, 11 Jul 2025 12:51:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Brigham Campbell <me@brighamcampbell.com>, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Brigham Campbell <me@brighamcampbell.com>
Subject: Re: [PATCH RESEND] drm: docs: Fix typo in introduction.rst
In-Reply-To: <20250711030157.124778-1-me@brighamcampbell.com>
References: <20250711030157.124778-1-me@brighamcampbell.com>
Date: Fri, 11 Jul 2025 06:51:53 -0600
Message-ID: <87tt3ix53q.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brigham Campbell <me@brighamcampbell.com> writes:

> Fix typo in Documentation/gpu/introduction.rst
>
> Link: https://lore.kernel.org/all/20250620180258.132160-1-me@brighamcampbell.com/
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>
> This patch has received no response as of June 20th. If it's
> unacceptable for whatever reason, please let me know and I'll drop it.
> This is the only typo I happened across while reading the document. I
> scanned it for more typos when I prepared this patch, but found none.

The patch seems fine, though I wouldn't put a Link: tag for a previous
version like that.

I didn't apply it because the DRM folks generally handle their own
documentation patches.  I'm assuming this one just fell through the
cracks; resending it was the right thing to do.

Thanks,

jon

