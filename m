Return-Path: <linux-kernel+bounces-804109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E68B46A16
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 10:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BC11CC5F2E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7967B2C0F60;
	Sat,  6 Sep 2025 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKcXWMmj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC85023184A;
	Sat,  6 Sep 2025 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757146251; cv=none; b=sZDLEWKGVfWZfGFzkorUeqSpJw4A+t3Cai89S4g5MuEEvdxuWRgXxvCA/QkZ6iocFIg/BnR90hb71qgCYv57k/z8D8+cHKmciiE11DrPEX9F4dnxrAQ1UHVwcEv7gj0bj2NXhTwh0cO+xVCq8a70pzs9i8flweGDuz0O1nXV0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757146251; c=relaxed/simple;
	bh=cwPk6T3fU2IyG+AYF8QYuidB4vOjI0tVcpBFG7S39rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5vbsODN2lL1OXtuDNfdzAZAN3o7AzTe2axVqgZESm+HBA/02FHYX3nE6UcAJt3EULfrpvx/WVRIIHR/x4L5hVSJprNUyKGgsDBcffc2DIgsZGsdnFic5qp99eZK5yzJREMweNJ9f5YrY9dS4A8G3q53oufy2DQkkLdSIljzpUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKcXWMmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBDFC4CEE7;
	Sat,  6 Sep 2025 08:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757146251;
	bh=cwPk6T3fU2IyG+AYF8QYuidB4vOjI0tVcpBFG7S39rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKcXWMmj+SwlIU1GzFq8oGy5jgkkN17Uj4Hff5l9S2IVzbrPSPFYHuXjC5JuEo27j
	 Y2B29lJ8waYDU63qj4rxD3ZGvwPFJL+wsuWuKva/z6fmmOY3izAgdYxQGymJ6nubwr
	 QwsgF3t7rKBJE3i0+yp314MQ9Jw+fh69USW5yn3orTcbGVen/0szcZDM+Z9DhnoFPe
	 c81VjlZ84X+7b1jVcrC4h2S24HKSq2u5nGodK9yC4x+NuvCJYrlC79BXRSzUfd6gJr
	 aLmpCilGHesAV8kg406u0E/QMxzxM86UqXunzWFzSjV0eSdxGIAq1XHExGVuFtCiru
	 IuJSvEmMbAUGQ==
From: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v5 0/4] Add support ANS2 NVMe on Apple A11
Date: Sat,  6 Sep 2025 10:10:43 +0200
Message-Id: <175714604478.14736.9361483258492179321.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
References: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 20:09:11 +0800, Nick Chan wrote:
> Apple A11 SoC comes with an NVMe controller that is similar to the
> NVMe controller in M1, but less customized. Notably, it does not
> have NVMMU or Linear SQ.
> 
> The controller is wired to an older variant of the SART address filter,
> and uses an older variant of ASC mailbox, so add support for them too.
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (apple-soc/drivers-6.18), thanks!

[1/4] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
      https://github.com/AsahiLinux/linux/commit/1dd8daf1cd49
[2/4] nvme: apple: Add Apple A11 support
      https://github.com/AsahiLinux/linux/commit/04d8ecf37b5e

Applied to git@github.com:AsahiLinux/linux.git (apple-soc/dt-6.18), thanks!

[3/4] arm64: dts: apple: t8015: Fix PCIE power domains dependencies
      https://github.com/AsahiLinux/linux/commit/55a1ed25fa8b
[4/4] arm64: dts: apple: t8015: Add NVMe nodes
      https://github.com/AsahiLinux/linux/commit/eef7336dc6c1

Best regards,
-- 
Sven Peter <sven@kernel.org>


