Return-Path: <linux-kernel+bounces-720042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9E7AFB634
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECD31AA5257
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1D229A9E6;
	Mon,  7 Jul 2025 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="naKIiZf5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F961EB36
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898893; cv=none; b=gDF36VxROVI4I0Amj8/HvfNdY0KPd/DwijECduaZzzT+7lncpnU+OXx/0IY+9ePjetpLlaTY8xzlKCH/MIWo4mXIP8oFSYFdU8dMnuiTap/VbvRQDBIWGsULSy9wKsNwQ45mquEtqgpBgfI2S72+0qmE+PbrbLYeHUPwbX7B7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898893; c=relaxed/simple;
	bh=ftgI7JOkFf+HQ0//LRt4z8im+TRZqPx40imRxqmB1Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqZTqe/C5rgqWuj3yKbH2+anphJ/SYcfSz72dK2ISepf8Wa1dWVrktypYeCdLEdvnCV4OjSHapwME0qAwypG1ClaPbAbuKvDQp2col1CEhW17W7K0POT9zzQmu1AC0yCWXXu7TJQIMbKERGb/7KqGM5/kykuMlgoo+qIp5yfVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=naKIiZf5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751898890;
	bh=ftgI7JOkFf+HQ0//LRt4z8im+TRZqPx40imRxqmB1Mk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=naKIiZf5NiWjA2XQ3IkD/fX1kn263RI17ts/5z/z5SRvSIhlNoup37rlEpyZClC6Y
	 yzq/lzhLqDn7AnjqUQ6yrIjMuIMBK5D12CFHtllezSV8/8nJi3Gp13DX9eOPuac58C
	 xZyBp4Gp8RejqTOAHWXsjtxcVwJ7/43kwdS4fqWNoajXh+zv+6WEON5agInGpRY5A8
	 j1RXudoQi8wtvYnUwBNnk/eFc7NORQJzOWHumy3l3DKhBP68qazCI0UHRHP7DN26yp
	 TxwA7cTY5Nj5/bBFvtCKmxHxBw5hcK/CZPVmUmFEYZyYA44MPx8BhrU9AYRJ39MCvY
	 89gIhmUGXdScw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D225217E0A28;
	Mon,  7 Jul 2025 16:34:49 +0200 (CEST)
Message-ID: <1c82e387-9d98-4967-bfe9-947238ee2a0f@collabora.com>
Date: Mon, 7 Jul 2025 16:34:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: enable XSPHY driver
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-mediatek@lists.infradead.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250707-mtk-defconfig-usb-phy-v1-1-4a5dd0d26402@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250707-mtk-defconfig-usb-phy-v1-1-4a5dd0d26402@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/07/25 16:28, Nicolas Frattaroli ha scritto:
> The mediatek XSPHY driver is required on mt8196 for working USB support.
> Enable it in the defconfig.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



