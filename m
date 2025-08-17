Return-Path: <linux-kernel+bounces-772438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E705B292AC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 12:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331DA2030F4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 10:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D9E2749ED;
	Sun, 17 Aug 2025 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLvlo2oG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23998274670;
	Sun, 17 Aug 2025 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755426648; cv=none; b=AgSVEsed/4OOk7Xxq6iloSatqeMMF3fCMusnZnCiAUDyMH44xZSXn1XUIKmxVGkqKgqDNhdgUT/3VqfQOoNIvbuDeFDddxN6U7R53u1fGClRgloCrsX/lsTx4uUhqucqkXEIyed0P5o2gBRGJZQgAbKZcnwCwrUp30FbUXDFxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755426648; c=relaxed/simple;
	bh=ZpdIfkm7dfyECGIXzoxLPteZqCTh3B/QC/zL/1RBl48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBzMkseqm5sxhsZ34wdHCQdjTXKl+HSXjQ+fmNQM7gco8acMIi7E2dlyRKzAnlGFPnSmPvtjWc0zT/RfM98CQZ4DanxrB59Q2lMCvkW4wxKjFSWMx3snjmofpkt67ieA2qwFL7NiqAXhTb0o4r8tGv5G3FbQRbaEs2ZmpfcXACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLvlo2oG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EF2C4CEF1;
	Sun, 17 Aug 2025 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755426647;
	bh=ZpdIfkm7dfyECGIXzoxLPteZqCTh3B/QC/zL/1RBl48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bLvlo2oGKvEOSOUm3rp7JoYFpmM0dsAfHAmxHFhv+Mor6QbLMtWl1ftRlbNlALbfh
	 gKtw2BATylljYZMjvGuKWxLP7xHQCJsOwQ50F7SgED8rZ8U9Ozajgo3j5szFA8s/BQ
	 HLQDn9Z6HMvVHB2jFTaqVxOSmE1NyHAiqJf+Y4FGhdtGZ5RQcou2k5L6hhaK+mjhGp
	 kPVXZcl6ZmioZ4rN2GEh+e+gHdzaBv/BWFlvOb3/J8W4COQB4RvFFQiA1slCKzfXMl
	 kCMLMfOw2uqFag7+piqh8iBbmAAhG+DMmh+leF6Ogmt+iAsYsCk9ecQW0uwe4XhZwQ
	 MaSAa/XPbSecg==
Message-ID: <3287eb4b-24fd-499f-b5f0-4af2b509a29c@kernel.org>
Date: Sun, 17 Aug 2025 12:30:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] soc: apple: mailbox: Add Apple A11 and T2 mailbox
 support
To: Nick Chan <towinchenmi@gmail.com>
Cc: asahi@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Neal Gompa <neal@gompa.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Janne Grunau <j@jannau.net>, linux-arm-kernel@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Hector Martin <marcan@marcan.st>,
 Conor Dooley <conor+dt@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
 <20250811-t8015-nvme-v1-2-ef9c200e74a7@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250811-t8015-nvme-v1-2-ef9c200e74a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 15:50, Nick Chan wrote:
> Add ASC mailbox support for Apple A11 and T2 SoCs, which is used for
> coprocessors in the system.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>



