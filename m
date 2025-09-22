Return-Path: <linux-kernel+bounces-827446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E86B91C89
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB93D2A6010
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2B9286439;
	Mon, 22 Sep 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a2VaBomj"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66EE283FEF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552221; cv=none; b=WvGzmUXCVT3/IBYh9ng99VCyXTM/v//7B6UyrX9mHWBTDGStKm/Snv5DtaUu7qTEe08HQYtK0zstddHqB0zaBNGsUjBFQU8M7HxWd8s7KbEGsoVu3zgt2KiJAsX35i/iN/AWPDIaOUvJ4o3tBR49x8or+UZ7frr6wmsHqPUUkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552221; c=relaxed/simple;
	bh=u0StcYlM0C5MF/wIPLzkoRZB9I6IGluJTtFy9zD0658=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jixOgbUmquxU97GNmto2NbImr+tDxcSWnkPQrKbIotCJBiGYQd4p2LTPe+Zw1enEGZur2+tFHHHd3doXPM9LNkB3USquuXbdzuVpm7YcTt+V/pBCWEN2BXMDnvDJ7NEKFVOC06Cb5jHJeEqQfPotiNKPzpzi0qamZOnvY1/X/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a2VaBomj; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758552211; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tKRMGh/qtU8jojR46arwg1WPw+eqAIS0mauPXhHXKBc=;
	b=a2VaBomjnB6jFttNAWhyMuJDTSJ7nuXLq4lCTghvcC9XoeQzf2hhqP4c0NmlKkaQ4A5+rq+P5XluksWNGa3SJFRWLElGmu75a/YHs1hI02tU9SI9PWU6MlQICM9uAzGHpKeGciIYE6ETEEm0QeX10z2Zl9+aY60Zip242dytCgE=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WoZpElR_1758552209 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Sep 2025 22:43:30 +0800
Message-ID: <7f41c935-c352-45c5-8a24-d690755d67d3@linux.alibaba.com>
Date: Mon, 22 Sep 2025 22:43:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add direct I/O support for compressed data
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: chao@kernel.org, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250922124304.489419-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250922124304.489419-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chunhai,

On 2025/9/22 20:43, Chunhai Guo wrote:
> Direct I/O is particularly useful in memory-sensitive scenarios, as it
> provides more predictable performance by avoiding unnecessary page cache
> overheads. For example, when accessing large files such as AI model files
> that are typically read only once, buffered I/O introduces redundant page
> cache usage and extra page copies, leading to unstable performance and
> increased CPU load due to memory reclaim. While Direct I/O can avoid these.
> 
> The table below shows that the performance of direct I/O is up to 54.6%
> higher than buffered I/O in the low-memory scenario. The results were
> obtained using the fio benchmark with 8 threads, each thread read a 2.5GB
> file, on ARM64 Android devices running the 6.6 kernel with an 8-core CPU
> and 12GB of memory.
> 
> +--------------------------------------------------------------------------+
> | fio benchmark       | buffered I/O (MiB/s) | direct I/O (MiB/s) |  diff  |
> |---------------------+----------------------+--------------------+--------|
> | normal scenario     |        2629.8        |       3648.7       | +38.7% |
> |---------------------+----------------------+--------------------+--------|
> | low memory scenario |        2350.0        |       3633.9       | +54.6% |
> +--------------------------------------------------------------------------+

Thanks for your patch!

Yes, avoid page cache by using direct I/O for read-once data (e.g.
distributing huge LLM model) actually makes sense on my side and your test
result is impressive.

I will look into your implementation later, since it's too late for v6.18.
Let's address this feature for the v6.19 cycle.

Thanks,
Gao Xiang

> 
> This patch does not support the following two cases. They will fall back to
> buffered I/O:
> (1) large folios, which will be supported in a follow-up patch.
> (2) folios with private data attached, as the private data is required by
> this direct I/O implementation.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>


