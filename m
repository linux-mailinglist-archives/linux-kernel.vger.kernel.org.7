Return-Path: <linux-kernel+bounces-875911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E481C1A1B0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B5A3BF78F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CFA336EE9;
	Wed, 29 Oct 2025 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvGgHDYT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A326B2F290A;
	Wed, 29 Oct 2025 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761738366; cv=none; b=Wrp/AAgCErlTlmbl5PVVka63gwujwRKAEh0mG4Xc/oRcFg4znHHzGU73fvGfNsN4UZZxNu63lB+w2GiEYeJ3T3bG82Z4Lolr2JnRiixwq70HEepkCzzLFpxdzZOPOqXuf4kf/bMtwMxOEoLlpSi7F11fitQNpb0U6Gm3Knr2QK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761738366; c=relaxed/simple;
	bh=5/ezlh6dKnG/scRqmnxs9ftYMDoe/gf88eLhhsutSL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUDVpAr2zmX8uwTbEqG8jLKj6vJAnvS6nysk/vjNTJ7T+AqGOl603YImaHyxKppJw8vgS2mEXAf+061xZ2cgTnBONgRuPMQtthhRIKb1srOlKfFWqBVIKlWcQ4GYfIUWc/P3yU+A5ui5p21deXcLt9xvE1jSj+D1MWzWGzG56S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvGgHDYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33742C4CEF7;
	Wed, 29 Oct 2025 11:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761738364;
	bh=5/ezlh6dKnG/scRqmnxs9ftYMDoe/gf88eLhhsutSL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PvGgHDYT9rUQkyQTwkmENhozPwfP1pkP6lOudu2DIb+lsdC8CrhFxABVwNaWDchOB
	 5HDSAA48uKlsedFtW5gnAkq5bvICaliuVdg2A+R+qJIfpkmnoJWdX38mVHwRSdl8ZU
	 vs9bQjNzA+9jxhVf9uwsx/5Urb/3rhYITjkI+tctdZ5Ay+itwzh1q4xXPixKp0NifH
	 jZqhJLNf+M3uT3MjsRKTFxfSfz/gWIS+1HY542xpfN2NiLZDMSnc+xeSqae1nfbD4H
	 1Ya3/dT+PtULqf21vHCNmwbBnsJVknsMEoOo2IZqUtkq2Ko8NtjJXi1eW9gRelZppZ
	 GP7818ILUp3/w==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.17 000/184] 6.17.6-rc1 review
Date: Wed, 29 Oct 2025 12:45:53 +0100
Message-ID: <20251029114553.699148-1-ojeda@kernel.org>
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
References: <20251027183514.934710872@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 27 Oct 2025 19:34:42 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.6 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for arm and loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

