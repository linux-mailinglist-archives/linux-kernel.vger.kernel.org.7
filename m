Return-Path: <linux-kernel+bounces-832084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D016CB9E4CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C51421A58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2282F2E8DED;
	Thu, 25 Sep 2025 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I78H0gL5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8108628031C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792248; cv=none; b=Cc5t+esjIoaQjxDc+pSv7kEraXTh73cRXnVS4K4h3iRNoOKLOXn0uXUS17h0+bZDnqAzKB9vjVz4q/PSKgSRDc4vN17WkdGPjY0bxDHrcAKc6GjMARcYZ7uCGD/Mjtyg0VLyMT2ry7410dmw9oVMCE856AsomK4ARgFR/UVLHbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792248; c=relaxed/simple;
	bh=3N4CJaD+M54WGTq3I7yxeqpASBZUqxkfBMhDjJwnE8A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NIMe3CQH80sC8s3gko5Ruc9lHNk3yiyOTzXc0heHTPI3zzETaAyyeUTmvldniEgSA6UhR+iO24sLQf/jXxRFshuK2MVVqQ/xIxu6uffbBiy/Y2eGdNK299shSvSEBrEWB0rvocF0FjZTAvRi2+hJe2buF6Xxt4MRQRzeG4HQhek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I78H0gL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D470DC4CEF0;
	Thu, 25 Sep 2025 09:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758792248;
	bh=3N4CJaD+M54WGTq3I7yxeqpASBZUqxkfBMhDjJwnE8A=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=I78H0gL5TUSNkY9Ols3abq3aJ8Kjtglr/5ilPXLO0iqaaqPY4sLn7TuQEhR3lhX+I
	 AVipRP3Qq3+BnU5xSvN0buwFxr1wAnF+kOpzhPBLtm8vWlYWmgFqDI6OgqVqdTwMWo
	 MZLJFPpFXLekjbkJZL7dKx5hD8Mdqah3hunblO236UpRMVnHzkvVj9Wo5/35gEMHkQ
	 UvP7HqAKxuvCL+M5SVcYV1VVd+QdnHdvnAyS3uOmyO8nIQgK6/hMJM/MdYX5tuIGjr
	 y1DyLIa6m2j67h52p3BTaq+zwAtxsCETzVn9nmGt/6sxeJpkOWky8DyZf7R/AYOhZ9
	 PzqNLXMdkciZg==
Message-ID: <969225c5-c4b8-42d3-8cdf-66c1e949f681@kernel.org>
Date: Thu, 25 Sep 2025 17:24:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: remove unnecessary alignment for
 blocks_for_ssa
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250924185423.1305104-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250924185423.1305104-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/2025 2:54 AM, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> total_valid_blks_available is already a multiple of c.blks_per_seg.
> So, we don't need an additional alignment adjustment.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

