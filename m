Return-Path: <linux-kernel+bounces-877884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78EC1F441
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48380188B158
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076AE341645;
	Thu, 30 Oct 2025 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GJ6e9DSP"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8412E2F12A2;
	Thu, 30 Oct 2025 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816210; cv=none; b=HhjKtSZwwZOUrMkH8l6M6II+3LKXhhk5piIl1AbqAXuU7BR/bIryXRacVDZwf6ETBMNf81u/aVy32kodZWAH65wR9XwrbU0Mhd/ZSR1TYcjZbtYVY4f+61A0zwZw+56L2HUpeIQTOC3h1UByo5u3jpTpQr5kqjCwxor2Bej7DCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816210; c=relaxed/simple;
	bh=RuQBqrdtUqoyAIaOqRpMQ6P5/VwynqIJx+FW8eJmZrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeZ9VAnbmNTkdzziGUFKWsxMVL8aMCo3O6Va5PFxMiRAVPsv/SXJh4UNfGCfqly9uwZnHhEeagLowHhehy2RokYkeF4ea819e1c6jPLdGRWR3Udj7bE4pkfuJbuWvVbGsPOrv3It69332SLUgTJxvuqXfGGsH9W24jvBS+efV2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GJ6e9DSP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761816206;
	bh=RuQBqrdtUqoyAIaOqRpMQ6P5/VwynqIJx+FW8eJmZrA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GJ6e9DSPVh7u+eTrjWEbA926QJ51gld8urEAHHONd9igGi+plgW0FEiLnp9BWR3ys
	 HrmkCNxZ2ZSS2bYNZB0fqG9b2KIclQJLKJVWGFGv0OQRp9lCT8H16PoMNiCCG+05+1
	 x2MY1iSms/1i6uE9gfhdqqB+OUgypAtUlXe2mptcKp2yWkdmlbkZRLYxmMv2sGJPCx
	 BIIq3sHAwXFDYltAr/vKDHQB00Pgully+qY4S3n4/lZcFC+KB3hdiwtvpBRyqp4KLc
	 JHmcFBOgVUc59ut7Y7p4fVDkupg0V9wPc2EiPns77jtxAj8qcZL277W6lmxuc9K3Io
	 IHsQvJwf5Q3cg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4D83D17E13F9;
	Thu, 30 Oct 2025 10:23:26 +0100 (CET)
Message-ID: <a46ff728-63f3-46c5-8b6e-880c36c2d164@collabora.com>
Date: Thu, 30 Oct 2025 10:23:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: spmi: spmi-mtk-pmif: Add compatible for
 MT8189 SoC
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20251029-mt8189-dt-bindings-spmi-v1-1-fbea12a4ed5e@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251029-mt8189-dt-bindings-spmi-v1-1-fbea12a4ed5e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/10/25 14:31, Louis-Alexis Eyraud ha scritto:
> Add compatible string for the SPMI block on MT8189 SoC, which is
> compatible with the one used on MT8195.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



