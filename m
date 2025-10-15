Return-Path: <linux-kernel+bounces-854728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78456BDF401
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B76D507CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18DF2D9797;
	Wed, 15 Oct 2025 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jCLw79yg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3202D6E4D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540319; cv=none; b=GbtRockbYzMxDGTJbJ82dx0Qhd3klCm2TD5Sj0xRqZPf79LZi0ojh8zDn6Lr5g47S3I+mYD2ug7i6fuwte3Ywr1sgzBM5Jv6sbyPFKsi/ssd9a8i31fkl+VZQyBlzPR7l+qMydJ3ktDLIujummZ570l1q/DKpkSi0Z5nWl3Fx+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540319; c=relaxed/simple;
	bh=fDOmNPkc8pzUUHIPZufp/adQkxap2A2ApP7//urC4X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKhorMwSYa14L7fI04O9bn1Y4b+j9qBD/e9JW2IXAvEwY6E58ga0eoD/WhWegtRPDi1z5APW063Qgw/8sIQ/6L1Rah/D4vBV16o3hxWrVmWih6HB2PcSJUPffppuzCzZj+WraA2l53Ao5/TRWtBoXJOQVijAeYCwLhqbJkl4r+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jCLw79yg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760540314;
	bh=fDOmNPkc8pzUUHIPZufp/adQkxap2A2ApP7//urC4X8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jCLw79ygkzloTeEZD5dC8uB5ZcSc4KljWGAySBYCDiPK4BM3N8J65Odjs2n4qQS3C
	 GieJ458Pa6vGj7dM+AE4nHV59H8xb7mUSVndmIbtj4WzQKhshO9YIsx2MK/NkBhLgi
	 pEoS5cxtbItV7+t3UbIX05yzIqIQqjzwe6gT07bgX7+UmC7Pckw8yOBGDONIxiql/p
	 hvxBsKIkUDk5/0axuKto//arbq2E7B2QaOznaTiEd2XgFQWQxfBjNFdw5PdXr+VSMm
	 5XX4ZO45S0Op7fPwfBJxNDk3+ks4faSW2kmafT4CTVOlEC/uCXIlC7xboCvWITYpun
	 oDorU67v0Frbw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F61E17E00A3;
	Wed, 15 Oct 2025 16:58:34 +0200 (CEST)
Message-ID: <c7a2bf5f-a4e7-4b2b-94c7-b39bd69b78ba@collabora.com>
Date: Wed, 15 Oct 2025 16:58:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: mtk-gpueb: Add missing 'static' to mailbox ops
 struct
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Chia-I Wu <olvaffe@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 kernel test robot <lkp@intel.com>
References: <20251013-mt8196-gpueb-mbox-fix-v1-1-d7de0cb20c36@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251013-mt8196-gpueb-mbox-fix-v1-1-d7de0cb20c36@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/10/25 10:09, Nicolas Frattaroli ha scritto:
> mtk_gpueb_mbox_ops should be declared static. However, due to its const
> nature, this specifier was missed, as it compiled fine without it and
> with no warning by the compiler.
> 
> arc-linux-gcc (GCC) 12.5.0 doesn't seem to like it however, so add the
> static to fix that.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510100629.3nGvrhEU-lkp@intel.com/
> Fixes: dbca0eabb821 ("mailbox: add MediaTek GPUEB IPI mailbox")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



