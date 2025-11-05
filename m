Return-Path: <linux-kernel+bounces-886107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AD3C34C12
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 365DF4FBFAD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F512FD685;
	Wed,  5 Nov 2025 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z//sTn5c"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B242FB978;
	Wed,  5 Nov 2025 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334077; cv=none; b=KaJZDCE8PNIyvLutYcbSnCAkyvur0xY0figTi2Iw6eu0V3Xve3Em1ICKCUALNu7XAR/G5kt160FM9WLSsA3TYvjRNWM6hmqizJZxJF7o7tH4v00MD/EJEa5H7um0RzkQw0/tOTamsq2LVP8cjP1jPqY+VeMPqAti67LoKD1HLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334077; c=relaxed/simple;
	bh=qWtgovMFKiTMTHDBfS7Kxt4dQ9VFI2F4oQIKhJkL1jY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jCyz09IuWclzItj5fjTgeyXA2fpy8Cvw5EEC9iBXr5UrQNM5Xny8ZpSsDx8+ppnGTvSvHiY6WxT9cnrhuOi70Md/Ip4X6ph5A5Esb38P39Z08xciKJWtEw4fPKg8FIYVP0oWj7ftnNlJGoEyfeENUpXOLXvb2n+MXM8tRS1mTEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z//sTn5c; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762334073;
	bh=qWtgovMFKiTMTHDBfS7Kxt4dQ9VFI2F4oQIKhJkL1jY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z//sTn5cgHw750Qw6GxY5XREnvUNETEmFkS3svN8Y+59h7+pZt88kiAHz/G47pffY
	 QWaL2k7AHtjnpXrcMuvUJqv1R2UfglFDV0dt7hIV43tH2gG/gmimBSOhOYSf1rhc4D
	 dR065+SV4njc+oxNiFXJ8noBKGMa0MWKU/IO+E4/0VN23bslViMB7F4DT2pR7ETsyk
	 mJOD9Tvt8Ypt4kfd1WeubJp/2wjUTpX3cq2+JFCe3yKG8JztHPrn5IOOjw0Aaq9Onb
	 vxUjSm7DB7XyxM9sLF2A+aMrod/lsSZGURl17/u7pyApgFa9CJKTOtX5AoJPeI+1jL
	 IZUUIETtm/gSg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C2B6A17E128C;
	Wed,  5 Nov 2025 10:14:32 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Jason-JH Lin <jason-jh.lin@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
 Nicolas Dufresne <nicolas@ndufresne.ca>, Nancy Lin <nancy.lin@mediatek.com>, 
 Singo Chang <singo.chang@mediatek.com>, 
 Paul-PL Chen <paul-pl.chen@mediatek.com>, Moudy Ho <moudy.ho@mediatek.com>, 
 Xiandong Wang <xiandong.wang@mediatek.com>, 
 Sirius Wang <sirius.wang@mediatek.com>, Fei Shao <fshao@chromium.org>, 
 Chen-yu Tsai <wenst@chromium.org>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>
In-Reply-To: <20251031155838.1650833-1-jason-jh.lin@mediatek.com>
References: <20251031155838.1650833-1-jason-jh.lin@mediatek.com>
Subject: Re: (subset) [PATCH 0/9] Add GCE support for MT8196 (series 1/4)
Message-Id: <176233407273.17051.14832672768529226895.b4-ty@collabora.com>
Date: Wed, 05 Nov 2025 10:14:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Fri, 31 Oct 2025 23:56:28 +0800, Jason-JH Lin wrote:
> From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>
> 
> This series adds initial support for the MediaTek MT8196 GCE in the CMDQ
> driver, including related API changes for new hardware requirements.
> 
> Series application order:
>   1. [Fixes] Refine DMA address handling for the command buffer
>   - https://lore.kernel.org/all/20251022171847.379470-1-jason-jh.lin@mediatek.com/
>   2. [Series 1/4] Add GCE support for MT8196 and update CMDQ APIs (this series)
>   3. [Series 2/4] Migrate subsystems to new CMDQ APIs
>   4. [Series 3/4] Remove shift_pa from CMDQ jump functions
>   5. [Series 4/4] Remove deprecated CMDQ APIs
> 
> [...]

Applied to v6.18-next/dts64, thanks!

[1/9] arm64: dts: mediatek: Add GCE header for MT8196
      commit: 355531a5ffd9e26f4d87ab34015c679e32d60e3c

Cheers,
Angelo



