Return-Path: <linux-kernel+bounces-886486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BE6C35BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6276F4F9501
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2A13164A8;
	Wed,  5 Nov 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UCEL5Tyc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1E02E62B3;
	Wed,  5 Nov 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347409; cv=none; b=IXe/R+1ivktl4uk3wBBM0gHsLaQ/aqbedTYTALbwSLmQfamNTuFULoLxdDmbu5S1z7UcAN2k9VmRLWnRysGuz+47LEkTCpi+aO5hlPghU/Zp3CcktFaI3EQXums/JizcuRXKLoBPHoTD7yfkhjWynmzzTrUTkzWjiX9CZgwxMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347409; c=relaxed/simple;
	bh=zsnwty4DLcrZ2EUkS8MJ4pcrgNIbrvhUP3gBR7CEr5Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F4WmnfwV/yWgYRleLdXYFgr5vBRXGUAfbanE2OQ3uWzRtpPpkqHnf9ueHrD669ggtmhvOi4MAEldmwMRgrG+T1ctjdWMjZ0GMPrguI0ex9QkVsr+8iIdY0TCuBB/VhydUPUR0BX2DT0UzToMGNaZ+eL1S3P8cLLwZgOKxEF5nFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UCEL5Tyc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762347406;
	bh=zsnwty4DLcrZ2EUkS8MJ4pcrgNIbrvhUP3gBR7CEr5Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UCEL5Tyc+WmgK+8W7uwi4S4i+54SOTgymbKDKUO9kLVNg2pCje+jeIW5t8osCuFmp
	 ZK1CbG4eG3vtGhrz2FUfdaV9kjl1fvxsRyjmw9su9G6iU+7e9XSq9b2mihiW2QZXFk
	 o+7X280FWB7c/ZOrZ4kpRalhlacenF74cxlWJP8hYdF2Fpr2fXidaRpTtI+yA4NM8p
	 YSXMLDluJMiIeK09OS8OSv9zEMEc++8N1KhIDEHOj3PzjZpkEOG3cKYZ1Cmf6imBjD
	 sgPBNCC1rwlebjn6mMdr1w0F27kuq9f1WOehIOa/EkqIMoG53LWRy+NB05hRoYnSZa
	 fz2eTOoidP7eA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B37417E128C;
	Wed,  5 Nov 2025 13:56:45 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Frank Wunderlich <linux@fw-web.de>
Cc: Frank Wunderlich <frank-w@public-files.de>, 
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20251027132817.212534-1-linux@fw-web.de>
References: <20251027132817.212534-1-linux@fw-web.de>
Subject: Re: (subset) [PATCH v1 0/6] Add Bananapi R4 Pro support
Message-Id: <176234740545.29963.12296506699287860071.b4-ty@collabora.com>
Date: Wed, 05 Nov 2025 13:56:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 27 Oct 2025 14:28:10 +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> BananaPi R4 Pro is a MT7988A based board which exists in 2 different
> hardware versions:
> 
> - 4E: 4 GB RAM and using internal 2.5G Phy for WAN-Combo
> - 8X: 8 GB RAM and 2x Aeonsemi AS21010P 10G phys
> 
> [...]

Applied to v6.18-next/dts64, thanks!

[2/6] dt-bindings: arm: mediatek: add BPI-R4 Pro board
      commit: b88827cb0bd1a192855db40494970bbdd7aad939

Cheers,
Angelo



