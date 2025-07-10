Return-Path: <linux-kernel+bounces-724905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEBFAFF85C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868781C83881
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999892206B3;
	Thu, 10 Jul 2025 05:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pelV/W32"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7428517741
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752124700; cv=none; b=EYGEN3z2XMXlXOQhwtn+JgztY8jKrZxtXta3wBVu2dtp8wbSmc5WN1Y5+l0GC0WuFz6iRrMVJAh73qywA/e1TcVi1b/S6zTRvLNYK54hU0wqoGACSN4Fo6+RUHAKhZ3oCcAZvQsVJpB4eQFFwXkBGfmh1wwZkuI0re78wIhb/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752124700; c=relaxed/simple;
	bh=+prmtkbRtnJH7brcPHnUVHuM9W6rEu8kI8l0pMcU158=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+8L8aMTk3HKxtIzB6VzMKzzb0CcdkS0C06qm8/cm4dRuNx9wOIEsk0PE8e1M/AHSds8hzt5fZ6umhfFo4o2fmdRKXgqOfBlzOJRSgeHjkYh1gTVfg/cl+mO0x+DxNafPDFlV95y9SDUo1f/Lpp+8rB0CL07naBhvwmum1hRgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pelV/W32; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752124694; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IgvuMSIU4no/7pCv1hjrhM3le8Z2kO0KwGxYEchnocg=;
	b=pelV/W321iak//VDLWKdJkl/nTQIL33zio6kr9hgxivnyPqWe8NGcQtpGUbsGVKzxn7otyx93oqdc6jrSwndtxz/eokUW8L0vEVkNpIXgO9Fx2+7FCEm52Yl1MO6S6Gl3cdZ9YXYEjd2xdJhGSJLteV6sVQ+sslJr9SFdCJYfqg=
Received: from 30.221.128.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WibNLdE_1752124692 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Jul 2025 13:18:13 +0800
Message-ID: <c3ebea91-9a78-4ac8-8312-3d98008f7950@linux.alibaba.com>
Date: Thu, 10 Jul 2025 13:18:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: support metadata compression
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250708120143.3572-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250708120143.3572-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bo,

On 2025/7/8 20:01, Bo Liu wrote:
> Filesystem metadata has a high degree of redundancy, so
> should compress well in the general case.
> To implement this feature, we make a special on-disk inode
> which keeps all metadata as its data, and then compress the
> special on-disk inode with the given algorithm.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

I'm working on erofs-utils support for this feature, but
before that I tend to support optional metadata compression,
which means

if the bit 63 of nid is set, the inode itself metadata compressed.
if not, just uses the current way.

Because that we could enable image incremental builds so that
we don't have to rewrite the base inodes again.

Thanks,
Gao Xiang

