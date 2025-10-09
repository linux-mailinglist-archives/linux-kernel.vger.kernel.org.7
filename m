Return-Path: <linux-kernel+bounces-846577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63719BC8656
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97B53AB4D1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62139275B05;
	Thu,  9 Oct 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O69MDSx5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD53E8F48
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004066; cv=none; b=sESA7BPqUf3Q8XS98XrSucMN8Uqpaz+IcUzBarSUMrcYKl+eaKH0nXCElHHPEf5stm+8CKOKAxTejV2HGqq2D8PgXWsxgUOdeu7k1OlG15gOsG3ecYM8NGCdn9jf65G1JnOuU78uykBrupy45lxIaVSogTrj8Vte07wc6WqbAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004066; c=relaxed/simple;
	bh=+ianuhorv8lajqogYlbJdzSHuiiQds4gR2t6IRFjPrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YYqhRxG2fi518BAiw0PGCmaxsbaKbdPPiQT+YcvYPzRiJclPq3GeQc+WgqYQRpwcDZBYwrgeEh+6F4W1uAyAblQV3ucSXHXNONpoJ2/tzN7E5GVb+fOkzVv6uIrqZlX47yojfmNaQgzvGNBAdw8tHO5ar2vglCdyf+zcP6rKVR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O69MDSx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5ECC4CEF5;
	Thu,  9 Oct 2025 10:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760004065;
	bh=+ianuhorv8lajqogYlbJdzSHuiiQds4gR2t6IRFjPrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O69MDSx5XDRpDu5T4RSn/Ka16r6XL193FOyyqFYFlxcG9Xc64gqFgGeqS5X/+v+Es
	 CTc/ZLWIEXYAY6jIrCdMuin3XrZZInxcP9dd3l62FHIPQjxcOcbB08olbgvL7Zi+j1
	 DjbVRHVCbIDQfKAx7W4JeZcNijVjqaqB8Xasm163xfkJBLONFn3T3RrG2TifXKD7QT
	 JOku+zvrWsFq0Umqt4OiKAR/MfAQfcjeMqbUcg8zkIRiQBBRe5PCPKBSFrpZA9r2z5
	 XrbEB/R0xeM9v31AJpiFZ3WWaf4XghMjTVHUMfBmjTfLoyRGNCgVMZXXwdOklb6DcX
	 cxWIdXDLZZ3xw==
From: Lee Jones <lee@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chong Qiao <qiaochong@loongson.cn>, Corey Minyard <corey@minyard.net>, 
 Huacai Chen <chenhuacai@kernel.org>, Lee Jones <lee@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <cover.1759478975.git.dan.carpenter@linaro.org>
References: <cover.1759478975.git.dan.carpenter@linaro.org>
Subject: Re: [PATCH 0/2] mfd: ls2kbmc: Fix a couple Smatch warnings
Message-Id: <176000406355.2720962.11959392466062866125.b4-ty@kernel.org>
Date: Thu, 09 Oct 2025 11:01:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-b87af

On Fri, 03 Oct 2025 12:28:58 +0300, Dan Carpenter wrote:
> These are two issues which were detected by Smatch.  They're not really
> going to happen in real life.  Small kmalloc()s can't fail.
> The devm_mfd_add_devices() function isn't going to fail either...
> 
> But still, they're worth fixing just for correctness sake.
> 
> Dan Carpenter (2):
>   mfd: ls2kbmc: Fix an IS_ERR() vs NULL check in probe()
>   mfd: ls2kbmc: check for devm_mfd_add_devices() failure
> 
> [...]

Applied, thanks!

[1/2] mfd: ls2kbmc: Fix an IS_ERR() vs NULL check in probe()
      commit: b9be0a544c0684672168c7d4a95dc54ba8e1e883
[2/2] mfd: ls2kbmc: check for devm_mfd_add_devices() failure
      commit: 35fc7b7df6761233e9d1f85cfc7fc5c4372a5d7b

--
Lee Jones [李琼斯]


