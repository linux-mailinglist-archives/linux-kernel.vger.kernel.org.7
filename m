Return-Path: <linux-kernel+bounces-894032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C667C491F3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27BE3A3073
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E5A339B44;
	Mon, 10 Nov 2025 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="IodhC+kC"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3984320CC3;
	Mon, 10 Nov 2025 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803975; cv=none; b=RyWhScgbM2ki1DolryuG2oeKxFQDgdm4MK9qAE3JqB2Rytz+Edrl4i1miYs6aSBOA3Wi25yvrUP2FovX6hAIobKJA04/Y1YJp/3i4dLiujnD/VsGK35F2DLLoVp/JbvfdmiDCxyxYfCpK+fQXm1YOKvN8dqPc+FtuJzlTG4Rtx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803975; c=relaxed/simple;
	bh=EcH3TpWulH4D3080eVlJmC3KmsGN2gFCTiFBdFdLiko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CFbc3xhI1uxS8smFi+JEHqzDmREsP2lYGm+fzfscBHAYji20NqmxVttrEXhChTG+VaBA7Pm4b1ZR4GBDOWJpdWXcCDMVZWFa6ZZr+g8PP2qoplnaRoKEw97zQkRVVQ5J0/QrUtqnFThDjTJ+U1qeeSqGRsnN4l1dvGfCEAxl7OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=IodhC+kC; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0F53D40B69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762803973; bh=7P4mnIHrP6gZgtkzdrpL4PCG3JfKoELVkIDhuZQDGbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IodhC+kCeXr2e1WdB8rFQ+k4mVULG8MDVexirQpqZFArYxKUlzO6JiftHcw4Tp6UM
	 ZkE22LHGFrxXdwVSge6KlekUy3fFPvjjWTKRBGIWg8mLOGGZsMESeQSug/gNmo9jpK
	 pswpxaXHiokCfQFL0C426ccb13PGd2GvIwp+KX+tyIQJwTRQlu+fi/q51RzJqUN7Br
	 RropDnGeOg6+u3oZ1G15+RRCTBpPj7Ect1H8C5oQcaeOI6YcBVwNWP6txLeZvyZ9L6
	 kB6W04yoDo53dNSEAQ0+wJKeNd5rSkkOJsQnAZQBpYRV+cCjh+kSxzoceaOcat77/T
	 hNfx3MmmuyOGw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0F53D40B69;
	Mon, 10 Nov 2025 19:46:13 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Jani Nikula <jani.nikula@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/docs/get_abi.py: fix get_abi library directory
In-Reply-To: <3839bc4db2d5c7e14dd2686876a2c7b5d72a46cd.1762523688.git.mchehab+huawei@kernel.org>
References: <3839bc4db2d5c7e14dd2686876a2c7b5d72a46cd.1762523688.git.mchehab+huawei@kernel.org>
Date: Mon, 10 Nov 2025 12:46:12 -0700
Message-ID: <87ikfhy8l7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> changeset a5dd93016f20 ("docs: move get_abi.py to tools/docs") moved
> the script location, but didn't update library location, causing it
> to fail.
>
> Fixes: a5dd93016f20 ("docs: move get_abi.py to tools/docs")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  tools/docs/get_abi.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/docs/get_abi.py b/tools/docs/get_abi.py
> index 7ce4748a46d2..da69e77559cc 100755
> --- a/tools/docs/get_abi.py
> +++ b/tools/docs/get_abi.py
> @@ -14,7 +14,7 @@ import sys
>  
>  # Import Python modules
>  
> -LIB_DIR = "lib/abi"
> +LIB_DIR = "../../scripts/lib/abi"
>  SRC_DIR = os.path.dirname(os.path.realpath(__file__))

Sigh ... I was sure I had tested it ... evidently not.

Applied, thanks.

jon

