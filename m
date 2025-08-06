Return-Path: <linux-kernel+bounces-758185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE21B1CC2B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5C318C2399
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1BF29C33C;
	Wed,  6 Aug 2025 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBNshinW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFBA298CB6;
	Wed,  6 Aug 2025 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754506193; cv=none; b=lHdcMhVCbo8WQa7AnzlkJHcegx8a0x7Ft+DX6wc/v8Errz9Lq4S9bZ9SKVjnQX5tIfBc1cTk+jyYsf/1IFztH8uOtRAh4Kkh5dVHY0a7umyd1DJeMyzyA+ZIKhr9ue+hjSdFavosHkzD8Y/5s4fbm32hkfpbOqn4edVQJEFBRIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754506193; c=relaxed/simple;
	bh=Fq3lCenJdcFbBPGsBCYGH9j0A7GaUKJaPYK+8MGwrFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPue/ROBuVy3RpNtTVErkBOjk7Wv1KujycUzkerNX6tGIBLB2KMinZo0FySyCyeuYicA7mWhSOWCtgvAj9jQDKNSR1GuJArSxDdbrFVWDaq/BX5Dv4ZzzJipzQYKXCbRgMME9FCM9n9T7XIJ1zsuvzod3RlVbGpDJlLOJ6WdrCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBNshinW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEFDC4CEE7;
	Wed,  6 Aug 2025 18:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754506192;
	bh=Fq3lCenJdcFbBPGsBCYGH9j0A7GaUKJaPYK+8MGwrFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hBNshinW1rnUFB0o4Si2zgGSOP/IP78XUiCJDginX06F1KGRNz1j55sJezeLHVZIT
	 w+XFGy1HU53pbqmwxSShdWT3x289hy8VECUD9Zf43WDu2qCF3NGLZVxi1+m9+8JThv
	 5K7L1sIXatNl/G8UJrHzynyblSrCuZFBFqybQYJbRefZinuKj5YetQfpLqELxQ6feP
	 29TV8wgGKDELrFcxNoX47IQAZsxN3QtIdqhXHgYLhiL8sKtB0KnpeWBV6k1OQTCDsn
	 GUmic3fO/zrqiTDlMFdS5HNG0098MbM6KHCy4HyFbUUhLG67uYNf3It4jNRfBmMXzD
	 FtrRyybW8m0Tw==
Message-ID: <fab1f878-f174-4b21-985c-abd2e6369847@kernel.org>
Date: Wed, 6 Aug 2025 20:49:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mfd: macsmc: Remove error prints for
 devm_add_action_or_reset()
To: Waqar Hameed <waqar.hameed@axis.com>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Lee Jones <lee@kernel.org>
Cc: kernel@axis.com, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <pnd8qjym7td.a.out@axis.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <pnd8qjym7td.a.out@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 11:33, Waqar Hameed wrote:
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>


Thanks,

Sven


