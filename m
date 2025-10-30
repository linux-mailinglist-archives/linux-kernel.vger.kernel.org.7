Return-Path: <linux-kernel+bounces-877885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61397C1F437
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEFC54E8FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492D9342169;
	Thu, 30 Oct 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kYBFLJiN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC232F6189;
	Thu, 30 Oct 2025 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816211; cv=none; b=t/R7tX7StmB5RBRDDPxgmCiU40Hoq+5thNtLqqVR74T8HqQoaaRqr6IBitTdmXYJua7fLcPA9X3o1NqX8KjFSJd410hZphM1SwPdXECVQN3IENnJEnhHktaVKrbOp6qK8+frX9K3UM0B4143uYis3eiceXJ1g4Q6ZBtoPbJ/ojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816211; c=relaxed/simple;
	bh=ya5omvxrI5mIeOveaUMXSMfKhV3/yYM0zHSY3WljRq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVNnhbOjfFOjz4LtyyqQvptp3OjorwE+TbD7q/souCi+lgPiOnKqYcFKoJKiwW+yIRaKAZC0Ve8ebswqF9EzIK6j4VxYpKv9vZy6gdayDsbhxPQKvb6+dPsw+HXoOlLJwUdmtupEgGBtZ1YZVb9W/V5hR0vmCPSgY1mMXcVgXDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kYBFLJiN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761816208;
	bh=ya5omvxrI5mIeOveaUMXSMfKhV3/yYM0zHSY3WljRq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kYBFLJiNlf4M6aesHbmVXtHz/DCfGCs9oqyJn2bNkRpa1b6zvucxCKE8UQg1F0fTA
	 N57P5Me8Tzhwa2+t649drLhcBnY0fRQHsSuBmUCgoT+1oonjugm/TOevUP5WPZnPxO
	 saARDGa7rrFXenArqezISZsl8jr34vUJDx64DOF21T+UL7m8PtH1igmD+H5d/71Tla
	 lm9UnzY/mUy8MVP0JU+t9/pBiAlTj2sV5WCb0D4IzCQeQkGLwJ3vMNmI0+A5T740ZV
	 KK1v6IAgghfu0lp9kp4aviQ/TMz6mBjPpuJV8kGzV/hnst5B4M0fGkD4N6alMZzewL
	 k/LTLBVpuby+g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8B6B917E1406;
	Thu, 30 Oct 2025 10:23:27 +0100 (CET)
Message-ID: <e5b3fc8e-c081-4067-9323-adc187b8b8a1@collabora.com>
Date: Thu, 30 Oct 2025 10:23:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: mediatek: pwrap: Add compatible for
 MT8189 SoC
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Flora Fu <flora.fu@mediatek.com>,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20251029-mt8189-dt-bindings-pwrap-v1-1-d52b1aa5f5a4@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251029-mt8189-dt-bindings-pwrap-v1-1-d52b1aa5f5a4@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/10/25 14:25, Louis-Alexis Eyraud ha scritto:
> Add compatible string for the PWRAP block on MT8189 SoC, which is
> compatible with the one used on MT8195.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



