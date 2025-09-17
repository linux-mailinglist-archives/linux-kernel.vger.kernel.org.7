Return-Path: <linux-kernel+bounces-820080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0F6B7E6D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C72322060
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9852025EFBE;
	Wed, 17 Sep 2025 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXd15Vly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29162629D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091716; cv=none; b=icr4fKODgAyP4RinN0ATd3lmsia3QMoHYHA/lgsNuvGT972fsQt9+UOruF8nN4bvMCVqjgjxUYXz5/G0XzI/fbgZAC/ytl2hpM2VxezAXnz2tZgAeBHgchr2FZfKGFu6b+qn1QBzwh3RG8hNmh8GU1IXePpXenoFZ4MGuzECA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091716; c=relaxed/simple;
	bh=iTstyyfCiGsfuRaBINTgbE7P5G52Z1XmAqxvblvR3BU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AB8/OF+knM9EYi3AoNL00avUok4tk1Ixw/GHHYl4AyVMo7WpjJcQu7U1Lm4ekKK8G8sUcl2XmSUFsoTwSH1WdETlD1YPvgpMxRxd/6/A5if9aNb55CbYNKHEmRREMmErCPZ4fStaRs26+FVqAPRcZIy7179W4vdHWbfwiazHknE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXd15Vly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5379C4CEF0;
	Wed, 17 Sep 2025 06:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758091715;
	bh=iTstyyfCiGsfuRaBINTgbE7P5G52Z1XmAqxvblvR3BU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=KXd15VlymOXUj2cCehgceb0CPdWS4+egvZbP2DPqny28s31RuHIgsaqHiyfgQesCJ
	 iql1xsPQl43bPLva3+LqwgQRhW9IGayHxuUx/zEtjxRnRrwme/slbwdDIBQDcW4vbZ
	 HSNWHFnjClIwnVMUMtXLzDens3ADMI935BzyzdOk6EHHn+EaEflmqJDhsFozHKFQqO
	 Zp1v7oUefdF4xagDw1iYd4c/he2rMChRlcpoFM0jWx5zylGt3xh1fnhEsooxh8dZQZ
	 ljf669u09s2MyWeRZu71WIyuSTjxSFHDkWX4qP2Qw7Kpmutni0hTpk7enH9TI8Dzxk
	 9oNcVaBDlSrbQ==
Message-ID: <a625f1dd-ec3b-4e2c-9b3f-8a772cdc69dc@kernel.org>
Date: Wed, 17 Sep 2025 14:48:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, bintian.wang@honor.com, feng.han@honor.com
Subject: Re: [f2fs-dev] [PATCH v3 2/2] f2fs: fix infinite loop in
 __insert_extent_tree()
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <20250917023622.516052-1-wangzijie1@honor.com>
 <20250917023622.516052-2-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250917023622.516052-2-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/25 10:36, wangzijie wrote:
> When we get wrong extent info data, and look up extent_node in rb tree,
> it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
> return NULL and print some kernel messages in that case.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

