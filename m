Return-Path: <linux-kernel+bounces-758823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A55B1D43E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72BE163B28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E62E244EA1;
	Thu,  7 Aug 2025 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxuStNyR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723C61B7F4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754555150; cv=none; b=Gbrli0k2EOxTTIK96nHbVsJ5eLzXBIFTfIJ+dvtAZCEjx1tXjGo3k4npAsQREKMC800IKJIGR4jA0F/2hILY3AsOQ/WJPLuD3umGlWPhNup8BGCNHHR9/TQ3x/BhuiUjGQW43xsQREbgEbAJ2ZiEsPH1jjIqu6IoDCi/i+izySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754555150; c=relaxed/simple;
	bh=Mn79SyilYTWcUb+3uimRZQL/uEQPnSniG2yXTYBSAKA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bp05KrrU5J3UPiCLKY5Qv5dWtb8NxdQjfiPcoLkgS8ZJnC79FzJ3ebIHKLNyDHIKyx3CQjLuFH0xKKiyTuP82+0K9FYmZYZnW2P/V9d/2j66T6uHbvicntkxFoZfjPL3R4YenA7YQXCCRkrgxJ2rwDUVoR3GgArBVpEdFe1gOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxuStNyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0338C4CEEB;
	Thu,  7 Aug 2025 08:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754555150;
	bh=Mn79SyilYTWcUb+3uimRZQL/uEQPnSniG2yXTYBSAKA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XxuStNyRcjp45qq/uEWQOjVSNgAXp9QDSPEOAnToeYRv0n/L8IBm9CuA/bwp28HZW
	 quLdVJbkHaltlZW+55V+RkYCTzU07iGle31+/OwHlCvFzyyDk0PGEALmqQV3wOlqfg
	 0BcvQep2sOmQFFi3B8787hrz+OooqrMC+mIdgnDwxXzfRnTSB7/gHBP/38rqZTnTlI
	 lq0nvyB6tWqOur15Jistde4b1bmpNsg1RnsHCaGhNqRuQ4tWIkNgmgb980WlueSA+9
	 uO9rsNmza6ZkdzjodusaaNB/alVz/+Ko29mTRZNDMbcveN6xnbWQnjLa3ciBsCymN5
	 NB19gUzbiqyFg==
Message-ID: <bc3f73b8-688a-4f1e-a0ce-abe3ce13f237@kernel.org>
Date: Thu, 7 Aug 2025 16:25:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] f2fs: add reserved nodes for privileged users
To: Chunhai Guo <guochunhai@vivo.com>, jaegeuk@kernel.org
References: <20250806091954.180602-1-guochunhai@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250806091954.180602-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 17:19, Chunhai Guo wrote:
> This patch allows privileged users to reserve nodes via the
> 'reserve_node' mount option, which is similar to the existing
> 'reserve_root' option.
> 
> "-o reserve_node=<N>" means <N> nodes are reserved for privileged
> users only.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

