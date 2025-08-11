Return-Path: <linux-kernel+bounces-761813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51858B1FEBF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164B03BBA83
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5510726D4EB;
	Mon, 11 Aug 2025 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5J16kuK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F381DF98F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890889; cv=none; b=slDHIU/dvWQbzj1lHC5Am2B5eDnW+OPm7k3aIShdYJ8uN6CkIcwqzQ1R50QHvH8gsFf0ugmSmqCMR66EAS6fQ8DCQq1RxRbxliDJj2GKtW/UXjJub5bbo9wfhNIxjCTOb5jeuzOvT2nWmJmZho7WQtvd4Diveg6XVR8pXFfaCrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890889; c=relaxed/simple;
	bh=AGpSbbO9BlUDuEdBA3XSdDky7H21WLK9dwd7KKSaKY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j31u43QDlZOZ2JNJg4iQRx0TPIvRO0IhzI9VOFU3aTZ+2xWrI3SimTfvF88SkRMRWk53DIjATOyAx9L4holz117+wiBQ87CJvjctzzJyCZOCrRrNDbpN+6jyrNzkgPaUpkbBa/R2i40WIOzq11qQe87Kejz5ILUkQ04652VmAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5J16kuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C79C4CEED;
	Mon, 11 Aug 2025 05:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754890889;
	bh=AGpSbbO9BlUDuEdBA3XSdDky7H21WLK9dwd7KKSaKY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5J16kuKWp5ArZw48/USMiJJy1fDJMzKNmM625koO4HBZoXxYOw4B+YjgAl4G0Ctw
	 rmzjyXzeBDqOcnaRJZu5ssFTeygBd3DaSvntTI0nT6iiHU+ac3qlZjR8yKxxa5lDrP
	 odKGUC9XNhaaDqpuPE7/yTw4WpuVfWDsDNSTISMtE9HL4tjmlpU5OcR9rAbXvyvCXZ
	 Xh17VPBqUwxcy4xSuhVX2LxfMTSlv8gGXbm8Fd20zXsM1cMFVEP0HA1I4u3HL8JoYW
	 biJMEiyrfilhYzVfi7gDonBPbG/mSj6XyLwe+G0jdYsBQHHcHOELNTuUgLTJ0IRQ4i
	 jGDwDTwamGbHA==
Date: Mon, 11 Aug 2025 11:11:24 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Sungbae Yoo <sungbaey@nvidia.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tee: optee: ffa: fix a typo of
 "optee_ffa_api_is_compatible"
Message-ID: <aJmChHa_BxNO74cB@sumit-X1>
References: <SJ2PR12MB86897F31237163137445D7CAB82DA@SJ2PR12MB8689.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR12MB86897F31237163137445D7CAB82DA@SJ2PR12MB8689.namprd12.prod.outlook.com>

On Wed, Aug 06, 2025 at 12:47:35PM +0000, Sungbae Yoo wrote:

Add some commit description.

> Fix: commit 4615e5a34b95 ("optee: add FF-A support")

Correct fixes tag, should be instead:

Fixes: 4615e5a34b95 ("optee: add FF-A support")

-Sumit

> Signed-off-by: Sungbae Yoo <sungbaey@nvidia.com>
> 
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
>                                         const struct ffa_ops *ops)
>  {
>         const struct ffa_msg_ops *msg_ops = ops->msg_ops;
> @@ -908,7 +908,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         ffa_ops = ffa_dev->ops;
>         notif_ops = ffa_ops->notifier_ops;
> 
> -       if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
> +       if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
>                 return -EINVAL;
> 
>         if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> --
> 2.34.1

