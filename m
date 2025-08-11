Return-Path: <linux-kernel+bounces-762395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C06A0B205F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBD77AEF02
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6BE2505CB;
	Mon, 11 Aug 2025 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8lbw34h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4CF241136
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909033; cv=none; b=kCMhlNlhd5hyPgzSp/mOQeLLvvQdd/gK6+71d5qHLTOKQQGlx1r87SvUao4M2HaAlvWe7Q3pHJDYOcWkeyEKLQvuTKnC4CDQRs3ymUAsLYsccRII/VX4JtREdIFl1ORhcA1mts+SRfGmcg/42uCvAuyay/Ro17eNrrTKn3yFN/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909033; c=relaxed/simple;
	bh=RL02yIA3ZBoae2LqkUhd8Ztvv3r4XMzdn9pwoj0qZ8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+r7C1DKOX3bwtQF8N+5dYg+HzprDLxPJaNh9Ll02+3FMndTNmnd4AfRNTHpe3/fKd7xifjYC5ofu3/aqFd7fy8qHwdKqapaiFORuSb8y7EVQ94LLN9GhcL5t0Umbi8SPU9yoURUkIWVaZJvMzex9qgQfFom6gSftAWPCD7XFLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8lbw34h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D44C4CEF6;
	Mon, 11 Aug 2025 10:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754909033;
	bh=RL02yIA3ZBoae2LqkUhd8Ztvv3r4XMzdn9pwoj0qZ8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H8lbw34hdkpGir/mUnbPkKHrU47JWl62cqXWh2jqVyHsra+vo0oXX5WrJqN66IMFC
	 ZF+HmNeQGndj0vZwhvCKoiOnuoawfzCRol9RiUpROuEq7Wmc1iAVAKAZPGT7P6ztCU
	 uMvylJIN6fvceujXrkp2RnFuIsuofaRCQDDuG+hanVsSPVwmMZYzbMHxvkQRqyLJ/Y
	 WW17OWQA43I8ZOOdXGwLfbKXVCFXGHYnsPm3LwK+qIss/C0oPe0JTH4+OsnlJ/BWFj
	 jkjTdeCvdSU0kK6nMxLr3/Tv6o7iXJ5Oj83iPkGlqHalu0E56QHxpqMmAtjn29oXC6
	 WpoV4fDor+yAg==
Date: Mon, 11 Aug 2025 16:13:47 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Sungbae Yoo <sungbaey@nvidia.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tee: optee: ffa: fix a typo of
 "optee_ffa_api_is_compatible"
Message-ID: <aJnJY5hV-Pul8QzN@sumit-X1>
References: <SJ2PR12MB86897F31237163137445D7CAB82DA@SJ2PR12MB8689.namprd12.prod.outlook.com>
 <aJmChHa_BxNO74cB@sumit-X1>
 <SJ2PR12MB8689AE34D74E657EFC3055F7B828A@SJ2PR12MB8689.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR12MB8689AE34D74E657EFC3055F7B828A@SJ2PR12MB8689.namprd12.prod.outlook.com>

On Mon, Aug 11, 2025 at 10:00:17AM +0000, Sungbae Yoo wrote:
> Fixes optee_ffa_api_is_compatbile() to optee_ffa_api_is_compatible()
> because compatbile is a typo of compatible.
> 
> Fixes: 4615e5a34b95 ("optee: add FF-A support")
> 

This blank line should be dropped.

> Signed-off-by: Sungbae Yoo <sungbaey@nvidia.com>
> 

With that fixed, feel free to apply:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index f9ef7d94cebd..a963eed70c1d 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -657,7 +657,7 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
>   * with a matching configuration.
>   */
> 
> -static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
> +static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
>                     const struct ffa_ops *ops)
>  {
>     const struct ffa_msg_ops *msg_ops = ops->msg_ops;
> @@ -908,7 +908,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>     ffa_ops = ffa_dev->ops;
>     notif_ops = ffa_ops->notifier_ops;
> 
> -   if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
> +   if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
>         return -EINVAL;
> 
>     if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> --
> 2.34.1

