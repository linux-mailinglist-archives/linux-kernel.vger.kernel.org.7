Return-Path: <linux-kernel+bounces-731425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C88B05410
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB361C203A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B52741AD;
	Tue, 15 Jul 2025 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbY5k/mF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AFF72615;
	Tue, 15 Jul 2025 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566746; cv=none; b=iC9DCHD9iqa+opASNZVjRaTQWp67SY8tZfppVRFSYFjhthKQiCL8pLBNBaydjGAupdMi2asbJ38gL7bR+2i3nJ/Q+07nPommZO+N5usI0rExSw4mTe4Z0u+Rwy0sVVC5AdLaG5kFtXeRytdPJrQ4RX3gno50Y2CEl6Mu3DBU2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566746; c=relaxed/simple;
	bh=MBMCjmOb5fj8zMDCgliqcGGqoewJCvAhNjmYPBNeRhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TncE4o8TcJpbtAe9eq1dHq994CXuI971zkDQJldaokU5IoL1PI27rhvIeun0P0lO5bnJCw0K/vX2UgS+GNxQKAv/2Rq2tauVRertZ4dzXSo71nldiCVjcMcTmoco3enn3weAKjZrDOX0WW264Vteq8rJBt+8a/z9aAK90SCXpIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbY5k/mF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CA7C4CEE3;
	Tue, 15 Jul 2025 08:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752566745;
	bh=MBMCjmOb5fj8zMDCgliqcGGqoewJCvAhNjmYPBNeRhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CbY5k/mFKHNxUx9FsZkfPBww8cbSGuiqP9S/dSgJGDqlI9zaA8FUhbSytz7sbYGd9
	 ZOWsNMvi1EjIhBPRXf9isDCfSO1T6Uk98xuNgvjNNiVbNfEAABu1FhelaevIzCoPL8
	 3keyYQ4+5bKHPgULHBEKUthghtHI0vHyUa9mlOGfoHcHaK47B8M8EsUmtKtAxh59nr
	 xqf/iB7c8rAMW6MCchQR+W9OFSMBGwZVMzijE4UeuVv2fXkLDi7ooW/B2Ao0k98luB
	 s3o0pGlbaqovrM5w4fc0oyACA/sW65fDOsbavt+hVSHu8GI7gxOWV/tl3CEwSbDGws
	 b7xeMo9yCNKrw==
Date: Tue, 15 Jul 2025 10:05:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Yao <richard@scandent.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Akshay Athalye <akshay@scandent.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Andre Przywara <andre.przywara@arm.com>, 
	Junhao Xie <bigfoot@classfun.cn>, Caleb James DeLisle <cjd@cjdns.fr>, 
	Kever Yang <kever.yang@rock-chips.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 0/3] drm/panel: ilitek-ili9881c: Add Tianxianwei
 TWX700100S0
Message-ID: <20250715-loutish-pearl-cockle-252fca@krzk-bin>
References: <20250714221804.25691-1-richard@scandent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250714221804.25691-1-richard@scandent.com>

On Mon, Jul 14, 2025 at 06:17:58PM -0400, Richard Yao wrote:
> Hello,
> 
> This series adds support for the Tianxianwei TWX700100S0 panel. The
> first patch adds the Tianxianwei vendor to the vendor prefixes yaml
> file.  The second patch documents the DT binding. The third patch makes
> fairly standard changes to the ili9881c driver.
> 
> Runtime testing and validation was done using a patched rpi-6.12.36-v8
> kernel on a CM4 using a custom carrier board designed by Scandent.
> 
> I have confirmed in writing with Tianxianwei that this patch series may
> be released under the GPL after sending them an early draft for review.
> This should be superfluous given my signed-off, but I want to make it
> clear that I did not assume fair use when providing signed-off.
> 
> Changes in v3:
>   - Fixed squash artifact in the third patch's commit message.
>   - Changed v1 link to use lkml.org to address mailing list rejection
>     due to "HTML part".
>   - Link to v2: https://lkml.org/lkml/2025/7/14/1504

Please use lore links. b4 does it for you, BTW, so recommended way to
send patchset is to use b4.

Best regards,
Krzysztof


