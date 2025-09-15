Return-Path: <linux-kernel+bounces-816330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F87B57282
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663221A2043D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97594502A;
	Mon, 15 Sep 2025 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIH4zaWs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2FC2EA14E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923555; cv=none; b=gfQmNqUY8aK+S7mLFIJvJsnXQLl5VIhTAdugW3b6aMYyoQFBFRE0Fk69Sp7gh+EFaYKiqP9dI01Fz0utdPtZ3htrBDUvQOhmtowHbXR5yKt9iCFl3BS2oMDsD+szzLWjuNc/6BVQxVUIUTt91oHAmzLi5Id5SIQH6S9vOaTG2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923555; c=relaxed/simple;
	bh=I3JF6cOAPqmMnoVF1qL1n4PddVdDWphuLVxeTXkhXGw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jm/tXJdCMyttMQNoRRpBjxK6MAHDbxse/+GBFTE03EUg5Hi3LIFLgiyi1ztTef9CvEuQbFnRRCVtHobhjjLFTEBj8s3TqRJiBiyWh+1HIN8bNNN2kEYkIUUzvhY+nJ6KOFS7zPPdNyHDoaZMtT34Ap/nJ53H51D0EdUuPrdScMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIH4zaWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05CFC4CEF1;
	Mon, 15 Sep 2025 08:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757923554;
	bh=I3JF6cOAPqmMnoVF1qL1n4PddVdDWphuLVxeTXkhXGw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qIH4zaWsJQmFui+Enjuy08n7j1Ovcw34EkO0bXRjIOY5UjGH4OYFOAhHgMW3YgZ+i
	 vmvaS4g9JIEOMyFIpo3DDr3LbHIhr2VppLObYo8XpdPCO2uqztIncsdz9FpWHmKpir
	 EMksVAhwjWq1AEaZV0WTv3d/Fyu5Wxj+CZ+YEjvYNQhfFkC2WLFPWzltcpO431sda3
	 Rna0AkH5PGjZoQlhiHKwxEwZ9q0lJ2NrnJpXYe17amiS0g8i1z4ABl6B1lKLd6qZyj
	 2AqfvgXniBEb1T0coH8oc5x83MRQb4W613J/yC/ubYNG2BTr4QXkZjxIBS4dqys+Mv
	 ZB4skUPrluXYA==
Message-ID: <599690b3-469d-4498-ae6f-6c2e3ce4e303@kernel.org>
Date: Mon, 15 Sep 2025 16:05:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, bintian.wang@honor.com, feng.han@honor.com
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: fix infinite loop in
 __insert_extent_tree()
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <20250915035246.98055-1-wangzijie1@honor.com>
 <20250915035246.98055-2-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250915035246.98055-2-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 11:52, wangzijie wrote:
> When we get wrong extent info data, and look up extent_node in rb tree,
> it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
> return NULL.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

