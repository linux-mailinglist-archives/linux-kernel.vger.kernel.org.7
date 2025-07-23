Return-Path: <linux-kernel+bounces-742536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE26B0F341
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C911CC29C8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E4C2E7BAB;
	Wed, 23 Jul 2025 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQjgY9Z0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EBE28A1FE;
	Wed, 23 Jul 2025 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275987; cv=none; b=P/RQjXuRaeH8u4/dxRWo2f4VKmIyeNVLBNXvWMQ8yNzP4SqMy7GrZ1R5jAXTAjzpDYNx61tyzPIFPDQ926XTEOCbpIgNInAUK6YPqnvutppXxfprPsHXKC+bO9uXztwYkJ/bA0SaU6tmbszmJltnCEs6UYv2ZNfo++20LLv1Ejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275987; c=relaxed/simple;
	bh=waIKXZS7SvDvppXRvapNC1Nk0LZTcv2EgEsK4+ZpodI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxftTtDCSfaziKnaNhMROMFcjM6dYLtBA5nHELraeJAn0FU5Hc6eWu7QmesVMutsMZ95i5vbXLWjcjD4l1N4qM6ho3nWVT1Q8nyW5OcPZyQiEhrnpEZ+Izr7DfB7HKmqzQIwyMJy3W00Yh11cPZ3yXDz0+qHqw794zgS5vDODhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQjgY9Z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824D4C4CEF5;
	Wed, 23 Jul 2025 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753275987;
	bh=waIKXZS7SvDvppXRvapNC1Nk0LZTcv2EgEsK4+ZpodI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQjgY9Z0Gw2L7ctORUaD16dUg5UHtBOWD0Z+pG9R0+nOPXQnV/dgb2+Mc0kakzDlt
	 IQezkekl7TfnfWJW6hLbRGlq2kPh2y0yPVaxZCjIpbGIuIO4DP4QpBg4nmspeoSDkr
	 4KC92AUdbKGhXcMkat/DFYAOFmhPSUTGxcmj1oWBGcydSzzSaOOJaC1D0SJU0+/nV9
	 W/OgamsmmeVqFVN9AGlKc7msmX+kQvwW3RywLv05af878exEPVy0cQHQkZXlcaTXTC
	 dKCjtNUKcM02vP4RO0gnyaNt0CkfC3BtqsDO5gMU+q3T+DCjTOfXt1h/0HF1ML1HIj
	 FZiOC6zH+1Lig==
Date: Wed, 23 Jul 2025 14:06:21 +0100
From: Lee Jones <lee@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Corey Minyard <minyard@acm.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, jeffbai@aosc.io,
	kexybiscuit@aosc.io, wangyao@lemote.com,
	Chong Qiao <qiaochong@loongson.cn>,
	Corey Minyard <corey@minyard.net>
Subject: Re: [PATCH v8 1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core
 driver
Message-ID: <20250723130621.GV11056@google.com>
References: <cover.1752548073.git.zhoubinbin@loongson.cn>
 <8066e0deddcb774f2e411aa420fcf72894ff097d.1752548073.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8066e0deddcb774f2e411aa420fcf72894ff097d.1752548073.git.zhoubinbin@loongson.cn>

On Tue, 15 Jul 2025, Binbin Zhou wrote:

> The Loongson-2K Board Management Controller provides an PCIe interface
> to the host to access the feature implemented in the BMC.
> 
> The BMC is assembled on a server similar to the server machine with
> Loongson-3 CPU. It supports multiple sub-devices like DRM and IPMI.
> 
> Co-developed-by: Chong Qiao <qiaochong@loongson.cn>
> Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Acked-by: Corey Minyard <corey@minyard.net>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  MAINTAINERS                 |   6 ++
>  drivers/mfd/Kconfig         |  13 +++
>  drivers/mfd/Makefile        |   2 +
>  drivers/mfd/ls2k-bmc-core.c | 189 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 210 insertions(+)
>  create mode 100644 drivers/mfd/ls2k-bmc-core.c

Looks good.

-- 
Lee Jones [李琼斯]

