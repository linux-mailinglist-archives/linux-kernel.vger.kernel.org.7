Return-Path: <linux-kernel+bounces-826998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B9AB8FDAB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7D62A0C50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0042F618F;
	Mon, 22 Sep 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W/nQzgw/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86F296BAA;
	Mon, 22 Sep 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534837; cv=none; b=Gsn+yWOo27mObmNdbXGnz/lumWFzzku0QSqA0KVPk8JBXSXS+dHBh7gfBMy3zZvURWS5CHlxkuggXOul9fPJsYssYbhuDm+xM33jvUiLkwzN1Dos9m3R/YfNN7HcsnJjMQkGc+N5G7CaGLAj1W6JFs8dJvhz65EN4SffTcJ5hRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534837; c=relaxed/simple;
	bh=PL/YajbOibPLqyRMxiJdv/uzpYvMdylD/ei2zQhoXwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRn9wNayJK40zN8npin0Bec4ztzi7SACeauzmwsGcV1nZ2hnBaj66zbj94fxV64/DacX6+jFq0SDMttgjyJfrQFFC0JUXh5M2VW0S0bFc5EKqt8K58HWZX4lQfYREJTTF3RC/N/rIxXOOqQ3LAoXYt8ys+8G3C3essiBAD9lgN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=W/nQzgw/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758534833;
	bh=PL/YajbOibPLqyRMxiJdv/uzpYvMdylD/ei2zQhoXwI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W/nQzgw/B/SriU0SadvwUreIeC63YgmlyBEJRz4Je5mwXxlK1vKjWy37TIASblOFf
	 tGuskA2KvFgwvZFc+TLFGGgzYfKes4R/uuIncC1pR+der0PSFHtoPiScOfUC8rcaGf
	 T0Ypr4zGnZVxetKwVJS8W5CwpNZrX9wFYuF5fRPOcALAiAsA0ulzIumQScomGWYrC3
	 vjrNjrLxIY8ZOgDpSfWBcVgekxox2gWpnPxDrPy/obXq9ZEstd7jbQ61bybINrb5/M
	 55D/sTvL15r7ruD1xzcvvXdRkx4/jLjGGmvJ2C4dKMnlGn7sf8rZNVuHRaqjianyuY
	 YjX8xT8cgjQ5A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 01F9317E12C1;
	Mon, 22 Sep 2025 11:53:52 +0200 (CEST)
Message-ID: <3ba38a84-2e93-483e-8316-f992f981ac7b@collabora.com>
Date: Mon, 22 Sep 2025 11:53:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] arm64: dts: mt7981/openwrt-one: UART labels and
 console
To: Bryan Hinton <bryan@bryanhinton.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 daniel@makrotopia.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250922035828.2941327-1-bryan@bryanhinton.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250922035828.2941327-1-bryan@bryanhinton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/09/25 05:58, Bryan Hinton ha scritto:
> This series makes two small updates for MT7981:
> 
> - Patch 1/2: Add stable labels (uart0, uart1, uart2) in the SoC dtsi so
>    that board dts files can reference them directly.
> - Patch 2/2: Update the OpenWrt One board dts to define serial0 alias,
>    set chosen stdout-path, and enable uart0.
> 
> Both patches were build-tested (dtbs) and boot-tested: mainline Image+DTB
> built and loaded via U-Boot on MT7981 hardware, with serial console output
> verified.
> 

Whole series is

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Thanks!

