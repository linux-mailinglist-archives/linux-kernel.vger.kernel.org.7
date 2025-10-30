Return-Path: <linux-kernel+bounces-877888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA57C1F470
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EA74035C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B0431A805;
	Thu, 30 Oct 2025 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mebfPC6+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E882F12A0;
	Thu, 30 Oct 2025 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816324; cv=none; b=AxhaVO5rQeE12S8jUfc7tADs2hdtjP1f7om9fZ0peEJZ2qdUseIJYq0qkHkkgViakFZzu2TfnjvknsS/Qs6vHkt96KP5R6uN3IPoGpPLLHMD2iFZ+ZxU/QFT2f6fGiKi47lptGOFCnqQ8DdO3xCefU12eHDm5vdP2xcUu8aBrF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816324; c=relaxed/simple;
	bh=oyf7HAZO8RhL2RYtja/zt16B8f/+ajKY5V1IZi5p/7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lqIczT3n9mXmz5Cdin965zB2QPfwnM2IT2X+dg1taig0mr8xgn5AVOsqXh1HjBN2y31r5lIKEJLvRBTXyzbpJEK9ucn52PjviGNMEg6jg9tez5DUHFAijp8ATWQA62Z+kVN1cRMYdiFyQ+LwfjVrCJkrGQQMS4hC9HHZBzGPA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mebfPC6+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761816321;
	bh=oyf7HAZO8RhL2RYtja/zt16B8f/+ajKY5V1IZi5p/7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mebfPC6+ymHZgokou0mpiUmD8p686JTQjEDu75rd+pL+LpKCWjd48Ch2AAA950haV
	 TWOfzi/K4glYJ1oQ1TvxGNLUaHEOP6QeWjt9ZkB5tw2ovvaa25lx3vuqLtofUWPf3A
	 P1t4Tbt8yFmDPyTf19i8OeMaljQJRqCYdBCvOIleSmYMCKPFpJg5oh5cSVfTmEha9Y
	 dje1pBQkscbg8C4IyJuhU/E+jGYq0JZNNiK08nlZsYQCfi/nG4+VU3uYDmq4wq5FeK
	 SoDpTtPyZl3MujcNxuUZyQVpyiM0U/M6vp827NqrfrawngPW++4gU8CckiSrU0gMtD
	 7LCpu2jN9Zl+g==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 148AB17E009B;
	Thu, 30 Oct 2025 10:25:21 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Flora Fu <flora.fu@mediatek.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20251029-mt8189-dt-bindings-pwrap-v1-1-d52b1aa5f5a4@collabora.com>
References: <20251029-mt8189-dt-bindings-pwrap-v1-1-d52b1aa5f5a4@collabora.com>
Subject: Re: [PATCH] dt-bindings: soc: mediatek: pwrap: Add compatible for
 MT8189 SoC
Message-Id: <176181632103.13078.15754462536677524202.b4-ty@collabora.com>
Date: Thu, 30 Oct 2025 10:25:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Wed, 29 Oct 2025 14:25:57 +0100, Louis-Alexis Eyraud wrote:
> Add compatible string for the PWRAP block on MT8189 SoC, which is
> compatible with the one used on MT8195.
> 
> 

Applied to v6.18-next/soc, thanks!

[1/1] dt-bindings: soc: mediatek: pwrap: Add compatible for MT8189 SoC
      commit: 4459d667a3d7001d1c1703dc79c87db1808cdde2

Cheers,
Angelo



