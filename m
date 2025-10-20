Return-Path: <linux-kernel+bounces-861195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CCBBF2071
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12A1C4F71F9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3392550D4;
	Mon, 20 Oct 2025 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3gIDg0f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2960241664;
	Mon, 20 Oct 2025 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973167; cv=none; b=EQ7CUf87nTi2fo0S6w1Cm9Y6BkcTaNu0ZoHUx1ZbvNgVe8/AZ0hFs3BTeWJ7InSfcZXQWBM3ds9Wvg+FVS3WqhV6FsHRnHnrL6sKJy+DYUvKQi75vOTTEaDfZdjIzedNPPJu5l34VHm1w+ll1UhJX2Ug2qkTDPI83MU+Qm+f+eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973167; c=relaxed/simple;
	bh=JeRSR4Ta+L2hjq8GTqngKzhNub2dWLQYM7Ipyoq7T5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMKKxKTB1aA0+5IWlCvlg1SU4nILYhO3e6VS/bMFU84O0K1DvO1XaFfWMadq2THK0aM5+2gTC+E2UHpPR9/J1DaSJQ/WsDD/LPgFCTKJa6TrIAOMvS9/+iwEvXYTX4pezQhXI4Ra4+VzOTU0Mc/wHTFX0CzqpR2l+Nlp9d+vB2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3gIDg0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78389C4CEF9;
	Mon, 20 Oct 2025 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760973166;
	bh=JeRSR4Ta+L2hjq8GTqngKzhNub2dWLQYM7Ipyoq7T5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3gIDg0f4pXeuVRhvPNqfgrpn7HFElubGo+ZpEztdIG8aNS+OTD9O9RaXf309y9P2
	 icqXUqhsvwTqtLmuqjGG0tQ992u/RhmJjWnXWq7HQmxaVTSHVkh66RPBCJIfC4oPaU
	 c4qv7OyTg7SUY0/Wlv84tMyzzPzMv3eD+IvGQ9SfluFBbZUHmA2KjIqqgpy8KTrZZD
	 N2HQ54zDobCpIP4a5c/nHY+1vQprqbNcbkuHKUAeElaDH2/Ro9Zy2s3TSv1lsAr7Ce
	 KrGLUy6idxVbmTevzyBt5AVeSlTNiQhBHlz7u9zpNNK8sDAztSP6mS/YrTPsv3LEGV
	 sLbIK+yvzsbOg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vArZ5-000000003x0-2irw;
	Mon, 20 Oct 2025 17:12:51 +0200
Date: Mon, 20 Oct 2025 17:12:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Renjun Wang <renjunw0@foxmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add UNISOC(Spreadtrum) UIS7720
Message-ID: <aPZRc7hfCf8WqeyF@hovoldconsulting.com>
References: <tencent_0066A06B7D93DDC53FCE20AD3149F8B01908@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0066A06B7D93DDC53FCE20AD3149F8B01908@qq.com>

On Sun, Oct 19, 2025 at 06:44:38PM +0800, Renjun Wang wrote:
> Add support for UNISOC(Spreadtrum) UIS7720(A7720) module.

> Signed-off-by: Renjun Wang <renjunw0@foxmail.com>
> ---
>  drivers/usb/serial/option.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 62e984d20e59..667de914a5eb 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -619,6 +619,7 @@ static void option_instat_callback(struct urb *urb);
>  #define TOZED_PRODUCT_LT70C			0x4055
>  /* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
>  #define LUAT_PRODUCT_AIR720U			0x4e00
> +#define UNISOC_PRODUCT_UIS7720			0x4064

Now applied after fixing the sort order as Greg suggested.

Johan

