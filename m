Return-Path: <linux-kernel+bounces-751235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF1FB166C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225DA3B4166
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8872E11C6;
	Wed, 30 Jul 2025 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VwCbtILZ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1490926F461;
	Wed, 30 Jul 2025 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903035; cv=none; b=KGzq85/Jdqcg2WRSRa5D94LVnRwWr9M2IQcL9gF1DAHUzjIFKvEy79pFIhlfT3i7tv2liw2CjgA19GVgsAOg+pqcDlj/47RG4q73KArbTR50jDQsUDbn0gS2M4H1jP/Hj5O0slJE90hvpB7sw8hcB9+kpNEw2QiOd6Na/oEjB/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903035; c=relaxed/simple;
	bh=ne05AV+6Qp/salB4UYY04vV0PlkPA1GwjChoJ8vl2mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svgChggWe10E95u9ObWKWE4EVfOYcD/zF+/ZeAKJD6M+FnLFjowiqWceSxLCgp8tyb4skBHfScj0LU5wPX/vW1l2xU3A2yzUG6cfM3kAiZZv0Os17umQFH0uIfeUYGfmVze8nlVdlrJVbr3EPAm+R+jgI3qlLcdTNTX4MNuwJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VwCbtILZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7DRM6GejOWAzE0PBtYi22750l7Fywcc4++ng0WeIuAM=; b=VwCbtILZLjjUA/VbjWZx1qhig4
	sSRKcCPHuydMY6gy6t9eIPv2kCuta1q1iQesLx9vnYT+AwFX8hcjzFocoQViV3UXpCwGvEDEdEvkj
	ixgYcIRin2FTe9HTbtW6drYanhfA5pjBfTxgcOVomIOTZ+oeFSUOKs677bDiFP30ZFsa95c6DTzXT
	9yR24cxEjSL/ifMCJd2wRyqLmjWOqVP9eOBV93TGWSwUsBtHV2LmnOri3eg7Alh+yu7+NzoGjXGE2
	cKXO3eT9LTS1PpYbuOYDv5c5lRVt9bB49mcrxgpb7+oqZ5xKga5ZIISFFtDuMoMDT2LZyXQy+NOhy
	V2EqkKYg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhCIb-00000002Gk1-2jKo;
	Wed, 30 Jul 2025 19:17:13 +0000
Message-ID: <c0416cd1-0055-4ca9-9780-e885ead4939b@infradead.org>
Date: Wed, 30 Jul 2025 12:17:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: gpu: nouveau.rst: fix a wrong path
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org
References: <20250730102010.2976882-1-mchehab+huawei@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250730102010.2976882-1-mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/25 3:20 AM, Mauro Carvalho Chehab wrote:
> The nouveau.rst file is pointing to a file at the wrong path,
> causing doctree cache expires and forcing kernel-doc to run every
> time.
> 
> Fix it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Mauro,

Bagas sent a patch for this on June 10 and it's already fixed in linux-next.
It's probably sitting in a DRM tree waiting for a PR.

Thanks.

> ---
>  Documentation/gpu/nouveau.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/nouveau.rst b/Documentation/gpu/nouveau.rst
> index b8c801e0068c..cab2e81013bc 100644
> --- a/Documentation/gpu/nouveau.rst
> +++ b/Documentation/gpu/nouveau.rst
> @@ -25,7 +25,7 @@ providing a consistent API to upper layers of the driver stack.
>  GSP Support
>  ------------------------
>  
> -.. kernel-doc:: drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
> +.. kernel-doc:: drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
>     :doc: GSP message queue element
>  
>  .. kernel-doc:: drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h

-- 
~Randy


