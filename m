Return-Path: <linux-kernel+bounces-894038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDE1C49214
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17E7188C883
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F45633F373;
	Mon, 10 Nov 2025 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZtdsBlIk"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D94433EB01;
	Mon, 10 Nov 2025 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804101; cv=none; b=LEfaFIQO2y66spTgznuW+k4zrfbv3ODcmTSUnVAS6nKwKnH0VcmVQNKLGCaGJNAI+6vke2wr7N9iTu+moZLIAxui3wGsSbVkNSbULM+W5xflzsCraAbjVR1ieuaJL/bgTYj7leh3ba2WUKty6MD2YTl2GfvI9tmbyoWE9+nkwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804101; c=relaxed/simple;
	bh=VDzQK+8HEtStJHehqNgBXiWFKNe0ld8GDs4pPNyXcr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q7JwtNIn1qvzNPMenJkI9GUiC3TVz3+PybH38yxp+NvWmxOK1YpWZe3tkB1MvBsAO9ToSK1TYAdYqkC6Hp1BGZfqtx3t9AsV/toJxfzrycN/e0ra2wia4d0CxYzWnaUSK5N2PZe+WQObXW0RQ6dDuf7H4JanVL9YB7nMnAeaK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZtdsBlIk; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8B21F40AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762804099; bh=60XE0n4ktcWn8stcg6+J2/wZdP/C+HhifbPKQu61aC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZtdsBlIkYOVn8oc/8L7e4N1UD8nrN0Z4mHSPFi2UB39PrXOzy7PFL1lZTbk+CS3Zt
	 iQK7p44VcFbqboFkBseYpjOxk1tMwuRKYgmbzuYR7ulgvNpxHL64EOlT+WKEfqoDG7
	 /O3J7GKEGc06rLLWdiOshAdtvn9qaKC8bSummX9dWKLPhIkVcVhRRhlgmgC4sso5B9
	 HqC1idyjFyYCeEhZtu2I8eMzdHHRLZw63GWMORxzZ7VnQXDjtaCGe2M9JyE1gmANQy
	 ANkYG40AaWHNQD2opJAGWRfwQ2+i9R93E6X04+j8VsKMop4KvMg7e9v5JP9XU/VL9X
	 KFOnaxhh+5Y6A==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8B21F40AFB;
	Mon, 10 Nov 2025 19:48:19 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux ARM
 <linux-arm-kernel@lists.infradead.org>, linux-actions@lists.infradead.org
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Andreas =?utf-8?Q?F?=
 =?utf-8?Q?=C3=A4rber?=
 <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] Documentation: parport-lowlevel: Separate function
 listing code blocks
In-Reply-To: <20251105124947.45048-1-bagasdotme@gmail.com>
References: <20251105124947.45048-1-bagasdotme@gmail.com>
Date: Mon, 10 Nov 2025 12:48:18 -0700
Message-ID: <87ecq5y8hp.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Commit be9d0411f1608a ("parport-lowlevel.txt: standardize document
> format") reSTify parport interface documentation but forgets to properly
> mark function listing code blocks up. As such, these are rendered as
> long-running normal paragraph instead.
>
> Fix them by adding missing separator between the code block marker and
> the listing.
>
> Fixes: be9d0411f1608a ("parport-lowlevel.txt: standardize document format")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/driver-api/parport-lowlevel.rst | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

jon

