Return-Path: <linux-kernel+bounces-721882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDA8AFCF0F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDCE1BC253A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB3F2E1754;
	Tue,  8 Jul 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Or40ugs7"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A02BE042
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988164; cv=none; b=f+KKvG46MIAq+yqOjWAIX0G+TGAeTxxV/DsKdTH88T9GHEG5OWBzJ6wx3Zl5Pb7L510EFzTcwxZA5tvvuZZYpQL05YqBTofZozSiyx6HTMDjuJ14mIK2NKdFgbeoFfEAFfx16r5v5Ax7dLj4P3PIS9gq1Ka/cKM/aK/hN+Cz01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988164; c=relaxed/simple;
	bh=O/qhOgkOxi3hocrx+rUBV6/b+S1dRUR+skQ+I1EkPTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDmaT82BBXMIG+Fa4i0JkDNmbUHA6TRx7zml47ymiTKTTAXXmcUfZX/VQQd4HYqiYtk8nQS3jTflebJwVwB2NA0Yzwp/UCtYxV2szW1Uc7bY5BQt96xfCI/82dkgktBGXbJz5vk6sSx+4cZ+G9TzDeD/NOjc6dP/5wBx2b/ihnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Or40ugs7; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751988153; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+K75DgAcJd3ni8TWxdbrLs8s6O72trPBZtAlhh1O0R8=;
	b=Or40ugs7zVzSwqnNoNZQae6UHu0jGz4bqlxWUIZsQak9Dd3Dicw5UhJLPGqttlQ4hkPUqb9uxVKAvL+oLoLvhkLuW2kgJdCHqno3s+z/lqkvV7QtCJBUHNLBjanJ7riPwm3tuVdtYARV/cwLIXXEnI0q4FTs5ftzVPK5FaHCJ/Q=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiQCvrv_1751988151 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 23:22:32 +0800
Message-ID: <2f33ff18-39a9-416d-ae69-7bbdf530e67b@linux.alibaba.com>
Date: Tue, 8 Jul 2025 23:22:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: do sanity check on m->type in
 z_erofs_load_compact_lcluster()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250708110928.3110375-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250708110928.3110375-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/8 19:09, Chao Yu wrote:
> All below functions will do sanity check on m->type, let's move sanity
> check to z_erofs_load_compact_lcluster() for cleanup.
> - z_erofs_map_blocks_fo
> - z_erofs_get_extent_compressedlen
> - z_erofs_get_extent_decompressedlen
> - z_erofs_extent_lookback
> 
> Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
> Signed-off-by: Chao Yu <chao@kernel.org>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

