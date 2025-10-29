Return-Path: <linux-kernel+bounces-876133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B818DC1B1CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA993425851
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D3B28C009;
	Wed, 29 Oct 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W//xex0Q"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C5523506F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743545; cv=none; b=TCZyiggWg+NtMpqDSwWsZ9Rf3TvZbH3A4Q8badWYgeqO5I6G1c56Ix0yLNN6qwUQRJ/hB6ekdEIGVgPijcwuHGHztmCywdSU2Co0iDVfts+TGuCFh3qQhWjAFHr+RlD7nKg6K1bZ/9H+BCeoDiwWm0JPXzvkfy9VAIB4OV8vP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743545; c=relaxed/simple;
	bh=HTF8B+gVcGSI+m7SBYfVfnrEJZHVBlnzm9rsfsDX+Nc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FLztO8wJUOtdr7CKfMvfAPx6ToGPJfv2UIQ+nnMFxFk9625PwjefShexYNuPQIbOy9er9HbJPOAqkzQNXclNPZj7GU+GKhU34+WSgR/M8jRUN89p2KWiz0HyKpyfrbQKltf2nm3H4DM9UINhC9a1bkSIN5hcq+a4gY91k+Rz5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=W//xex0Q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761743536;
	bh=HTF8B+gVcGSI+m7SBYfVfnrEJZHVBlnzm9rsfsDX+Nc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W//xex0QgbWA6pRlnueMAZLqXGd260REuvWPfQKBV1OMlEYzwHahXbAo9QClnsHTV
	 V7ofaA80uJFkz76vh+IWoNcS4OONVqJbEooCCwHCaVfCkFgCxoDq3+YrWnbptnJ3oN
	 XFfrs0hWjCz8qj6mV/GI2mC9MbLd6mKuIb1nCayL/GNqxvgTrFXCS1c4+oe8Xvgatg
	 lYdKr4fH5LzG2hCJ+ahDs9DKV29ziyqDQlaGLRBEeNzN3lfBxrhodaFS3Gwem+8e7E
	 lP4ksJjWJU8/nrOs7rFGkVuGijg8P5W6hxQwPm6YLxe/xVj1qb8mNp83vxZeVbx6eS
	 HTIGxkdAOp1ww==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B5A1617E1315;
	Wed, 29 Oct 2025 14:12:15 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Sirius Wang <sirius.wang@mediatek.com>
Cc: wenst@chromium.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, jh.hsu@mediatek.com
In-Reply-To: <20251029130842.32633-1-sirius.wang@mediatek.com>
References: <20251029130842.32633-1-sirius.wang@mediatek.com>
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: Add extra entry for MT8189
Message-Id: <176174353568.31020.16855973534724867360.b4-ty@collabora.com>
Date: Wed, 29 Oct 2025 14:12:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Wed, 29 Oct 2025 21:08:34 +0800, Sirius Wang wrote:
> The MT8189 has a different socinfo match for MT8189 SoC
> (commercial name Kompanio 540), so add it the driver.
> 
> 

Applied to v6.18-next/soc, thanks!

[1/1] soc: mediatek: mtk-socinfo: Add extra entry for MT8189
      commit: dd1d7af420e5a085e08c33220425caad35289bea

Cheers,
Angelo



