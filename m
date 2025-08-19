Return-Path: <linux-kernel+bounces-775157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5D0B2BC07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468985E3FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06353115A9;
	Tue, 19 Aug 2025 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNt8FFRJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4A21ABBB;
	Tue, 19 Aug 2025 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592775; cv=none; b=NtQIeDQ2EfMQK4EOgODhW66BA1Jt2vBFWDc5Ti0X7RCEIcG1CeR5rp/op5ogdK6p7SF74CJZfPc2Noa2heiO91dbDoR+4VMiO7P3xAo5QzHYTodnV3lCe21QFHXXzgNDt93JquGzONaj8WIyBNqwCEAPDHYDd1NuenmY7NrU8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592775; c=relaxed/simple;
	bh=S/iXwuz8N0uwMCfHp+T12qa3ce4k79eljimBk6WuzjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkggADO2tJGiAoPzMH4uSNosCU29DuqfQ0VOKmcTITiLAWPlk9SYRP1zcEhiRRrPEnhX7GSiW9P5AjYkGtLDhBq9UI0kB9Te32uLZ4pyNuG2ZEFrjBhKsoufzMBYXavANrZ9GT1jXUT/28IPTnhw8+NVQ+NeUjUW/vJHZp9hSbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNt8FFRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B700C4CEF1;
	Tue, 19 Aug 2025 08:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755592774;
	bh=S/iXwuz8N0uwMCfHp+T12qa3ce4k79eljimBk6WuzjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNt8FFRJnA96OKeSLKP2MFsA3PbVp2Pbq7DnODQ3ldCYJEyR8gQ1JkdMYSdH0nBUi
	 J0fqhfqnq39Ral5NVj8NMSMgsjx/6hftzdv5/wWbB316pzpyYMFhajiZ2mivEFdWVv
	 dWYiG2y0HmO77VM+RsG8rVciewaTX+HtnW67wEdX0i5yjvcxfcJISp9q8fTcKEH85M
	 1ZI6iMsEo31AWAqzvfFG8ba95as+0t+Eelh8ETSCvTQNIuVK52lZjmwD+wbBbPx7Q7
	 QfAVBlchlqBNcI81b9sgaFZnl4LRWsgHO5oYvvlZOOziCcZZ8q7Mk2aRbmKyFcbRT4
	 rb2XVczqFiKhg==
Date: Tue, 19 Aug 2025 09:39:29 +0100
From: Will Deacon <will@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>, soc@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: Re: [PATCH] MAINTAINERS: exclude defconfig from ARM64 PORT
Message-ID: <aKQ4QSAqT7OLIBf1@willie-the-truck>
References: <20250818-arm64-defconfig-v1-1-f589553c3d72@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818-arm64-defconfig-v1-1-f589553c3d72@collabora.com>

On Mon, Aug 18, 2025 at 11:08:04PM +0200, Sebastian Reichel wrote:
> Patches for the arm64 defconfig are supposed to be sent to the
> SoC maintainers (e.g. a change in the generic arm64 defconfig
> required for Rockchip devices should be send to Heiko Stübner
> as he is listed as maintainer for "ARM/Rockchip SoC support")
> and not the ARM64 PORT maintainers.
> 
> While we cannot easily describe this in MAINTAINERS, we can at
> least stop it from giving false information and make it behave
> the same way as for the MAINTAINERS file itself (which basically
> has the same rules), so that it just outputs the LKML for the
> ARM64 defconfig.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index daf520a13bdf6a991c0160a96620f40308c29ee0..b6466a628381bf40ebcf7e3638ec65fabf6ad357 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3667,6 +3667,7 @@ F:	drivers/virt/coco/arm-cca-guest/
>  F:	drivers/virt/coco/pkvm-guest/
>  F:	tools/testing/selftests/arm64/
>  X:	arch/arm64/boot/dts/
> +X:	arch/arm64/configs/defconfig

Acked-by: Will Deacon <will@kernel.org>

Will

