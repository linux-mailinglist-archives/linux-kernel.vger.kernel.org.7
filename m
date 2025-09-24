Return-Path: <linux-kernel+bounces-830149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D788B98E98
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0650189317A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C729A2882C9;
	Wed, 24 Sep 2025 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cZiP2itX"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B823287274;
	Wed, 24 Sep 2025 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702893; cv=none; b=m3ck3g2ryF4qoV3i5jbtG1baWWiSsigMHtKrjlRI3tT/jn7zqQ5I3xNW1MjVVgXpYdh9hKj1F+Z/ADa1kalyK08HbPEwe+iBTVhrJIc16w9KbOYH3plpkqOJFEShLJ0Kjg0YL8Ptp6Flx+ieFV/VafxY6Jo6XEMFUMaLZGsXsEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702893; c=relaxed/simple;
	bh=NQpn5On1CpZYeSoKNe+8hbK1OW/Ka5jHDW6U1lstCec=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ewGY+ohzFQcxkgU4Q+S84w4XqJj/hMiaV32oTQjdbl+eqG7TnjAh5n9paU34zBKbQwLX7MjxbuoIYLLLzalyEE0QafpYFPC9VaPcYoVp6EpXT8PVbjjkdgvGYPRLpS9G4yTV1JNoAAOIoZBZANDwfvLTfLYKW8NpVz1zbgLSOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cZiP2itX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758702888;
	bh=NQpn5On1CpZYeSoKNe+8hbK1OW/Ka5jHDW6U1lstCec=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cZiP2itXfdkJ6bbHkHMc2AZFZnMBN6qhCADI9XHKsDoH5Z3UxvU6pg5TTTvCd4QRV
	 hOQgX+AhF/IqbVDwCzcOROKW0HRKTgmzmHvPIAVItTLVm74ghMKsSzxLwQYsRwETbZ
	 iYn9P5sjyEpUq1c61LYGKYlNNHlxfdW64Dcgc+ELgLiws4ZjkA8xnUZeS2RJYglPf5
	 mo3wei2LNmW5X4+Zhlx3kSrG+t0IAD4flPr/gKEs2QyqCAfyLLex8r9fS8GHywc53Z
	 +bY9qM9I1OyLO/eHrBWHMYMR2Wv5dboev/iZwmtHu8dnP8J6sV6aDrYfufNsv6GFE5
	 7uzks4ph2dvEQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 32A5A17E0C21;
	Wed, 24 Sep 2025 10:34:48 +0200 (CEST)
Message-ID: <b520c02c-f405-4310-92b7-7301f9f29e28@collabora.com>
Date: Wed, 24 Sep 2025 10:34:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: dts: airoha: Add AN7583
 compatible
To: Christian Marangi <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250923185340.21526-1-ansuelsmth@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250923185340.21526-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/09/25 20:53, Christian Marangi ha scritto:
> Add Airoha AN7583 compatible to the list of enum for Airoha Supported
> SoCs.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



