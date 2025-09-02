Return-Path: <linux-kernel+bounces-796820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD7CB407DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1B916A13F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D64311C10;
	Tue,  2 Sep 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVhD1i4k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA22DEA8C;
	Tue,  2 Sep 2025 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824476; cv=none; b=C18Xteo5KLpjf0x7OEaUT89OC/0htCuOhcGiIBBmKOW/h1erwqu2ilzPCjb/7tP7br1SOUSHW8w20n/Y/lj6W1x5smCyMHA876elE/H8f0VHIzL9IB8otD5OAzv0Tzg7rTMS4hAuhDg/BAP7cHb6gIF1M0ppvDq5VpPdJv7Rqrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824476; c=relaxed/simple;
	bh=u/B4fahLYBxFs/OMMTF/mEgo4u7RMfWA04aEYQT0ffU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gClkHrpxUpKy3Fmj3KhRLqm7gjcE4xNQfm4bi0ee8wWj8I7BzVdxs4fM6ZXEGOaACK9Gvmskyt4dHXtdUsFxwFekeYB5ohM2TTYgdq3gCwkdvJwiYotWiHaCTp0lH7M8AIt4MOPpEtE6Lj6ssn9+GT+5xOJxo+SQE+m/z5om1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVhD1i4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4207AC4CEED;
	Tue,  2 Sep 2025 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756824476;
	bh=u/B4fahLYBxFs/OMMTF/mEgo4u7RMfWA04aEYQT0ffU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVhD1i4kOWxPOzw124hLUYMiMxvpoO9v5skFKbyRbj10sqAYGV+7NEBn9YFZ9DoIQ
	 qWl/6WCnh1pcr3qVgKZSxjBlNg0Ijdip9YAoZBnbRBFSL0+Ylw9sRsZ5zmqljHU7QN
	 ZJzufZbLF21OSQbH5PV8264tiL2tdZz7bMiTR8rHDI23GYJ/vAfyEln+vDogVfbeOB
	 sRZ5jasPKAjWOGS4pYCAcAUYxWaOnrg46do3Lep/e16CeZ58f2zYA00Jd6dpuxQLIQ
	 hRF2anHq6mrQv1VPgVykJEv8w5tpLpyy30SI89Dz9x+O3MJQmHWB82arI3tvUPiNCb
	 uU5bq/CJb0dXw==
Date: Tue, 2 Sep 2025 15:47:50 +0100
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
Subject: Re: [PATCH v10 1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core
 driver
Message-ID: <20250902144750.GT2163762@google.com>
References: <cover.1755853480.git.zhoubinbin@loongson.cn>
 <3bc527944947480aba00ee05cb5078080591e4b5.1755853480.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bc527944947480aba00ee05cb5078080591e4b5.1755853480.git.zhoubinbin@loongson.cn>

On Fri, 22 Aug 2025, Binbin Zhou wrote:

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

Looks good.

-- 
Lee Jones [李琼斯]

