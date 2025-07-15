Return-Path: <linux-kernel+bounces-732282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3383CB0647B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0299C17FAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1425927A448;
	Tue, 15 Jul 2025 16:38:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61B62528FC;
	Tue, 15 Jul 2025 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597535; cv=none; b=VJvG/C85n6q0LxRrv4qZrSHjGFeauKhgkcQakifS2pl1URU5rGySq2gPkcMYRbJFFxXC+K/Vbzh3xHslNImn+zY3MlOMlIMylGw7QOT9DcCQkTmk32mTKyXHCipv3nFB25J98RgTYeoRA9nxJUxjbE9zon5x0pRAublc7xWYZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597535; c=relaxed/simple;
	bh=ftIDIcdfsxHjikRrEVhEACSjKBx6CsZrSGvFsUQvJAc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pLCxU/IgltIsfmsMiSjDdM7Cg6l+phPA1T1gtYCRzGKej/foQgo5+ikfVYZbcRyxK/mJR3ixN/rQW5vEpRv+CATUhUPAEJ/1PBiKHkelOaKfO2y90J1RmElj//AVaJN8+g1cu5vJjmKz1jQtYTN0129UbIdtH4uhmFZYF300f0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF71C4CEE3;
	Tue, 15 Jul 2025 16:38:55 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id E6B9C5FD47;
	Wed, 16 Jul 2025 00:38:51 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.or>, iuncuim <iuncuim@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev
In-Reply-To: <20250711035730.17507-1-iuncuim@gmail.com>
References: <20250711035730.17507-1-iuncuim@gmail.com>
Subject: Re: (subset) [PATCH v2 0/3] arm64: sunxi: a523: Enable Mali GPU
Message-Id: <175259753193.2390274.13790626107731920728.b4-ty@csie.org>
Date: Wed, 16 Jul 2025 00:38:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 11 Jul 2025 11:57:26 +0800, iuncuim wrote:
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> This patch adds gpu support on devices with a523 processor.
> 
> $ dmesg | grep panfrost
> [    3.826968] panfrost 1800000.gpu: clock rate = 432000000
> [    3.832305] panfrost 1800000.gpu: bus_clock rate = 200000000
> [    3.838353] panfrost 1800000.gpu: mali-g57 id 0x9091 major 0x0 minor 0x1
>                status 0x0
> [    3.846050] panfrost 1800000.gpu: features: 00000000,000019f7, issues:
>                00000001,80000400
> [    3.854134] panfrost 1800000.gpu: Features: L2:0x07110206 Shader:0x00000000
>                Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
> [    3.866011] panfrost 1800000.gpu: shader_present=0x1 l2_present=0x1
> [    3.874108] [drm] Initialized panfrost 1.3.0 for 1800000.gpu on minor 0
> 
> [...]

Applied to sunxi/dt-for-6.17 in local tree, thanks!

[2/3] arm64: dts: allwinner: a523: add Mali GPU node
      commit: 3d99e0dc888727a21b45ca64ff7b0cddbd17dd16
[3/3] arm64: dts: allwinner: a523: enable Mali GPU for all boards
      commit: d96d9ac8d2f197f31ea3de931dde1a217950f4ad

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


