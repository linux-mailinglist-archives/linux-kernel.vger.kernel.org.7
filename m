Return-Path: <linux-kernel+bounces-736339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E57B09BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3ABA65175
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689711FBC91;
	Fri, 18 Jul 2025 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KRN/SmZO"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC864689;
	Fri, 18 Jul 2025 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752821340; cv=none; b=PQbD4vCjR8swZxIk8202CRQFhpmkpVnyjrQ+WiOOp83DgVLVPQBdJtVrS9PuK9kM46OpEietO8BNAukgaASuxCgfudTBcf0nq0deh4GH1TZiQ8c9RBkeoa5jFTxwi+uKtEkVMNSJk6xwhb62VnQImHlbNJOvMEh9Tx/BMD0jlwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752821340; c=relaxed/simple;
	bh=Cam2JCWYE+AhdiTGpp3U6Crx7h/60ZtiTadCn/kFn8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBBgeNjN5OM9sf9n6mWrjKG7IV4/vVAbAjeUMZ7TUJWIXuxLVBfDQLGyPJEssH+7lUpfCsIQbfrSBpL1rx0qi96RDxmDdYF1Kb/64hvLZuIZ8iMerqQwmnJ7PBHtHSt3+QuSuHH7YUqLRDKwF7EeTkkYRbN7arwx32bBSvNqf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KRN/SmZO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752821337;
	bh=Cam2JCWYE+AhdiTGpp3U6Crx7h/60ZtiTadCn/kFn8s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KRN/SmZOi39TtZ/lXASxxb5Qni6eSNNQPO3baDCiGypeZZJhKjzPGD3xtRQRYUkun
	 wmh4VOtikVfvOKzZa8FC9iG+lvMNS3Lrnp/HvgyPPyYFaYLNxjCVHmPv3rI7pl5KRm
	 zsZKoN6TlFNnbw/bpRYtLASV8tSD/xgqi5PLNbntJwJFXtJ57oa2ur18mAUVFdiIyn
	 S4ywV0fZuVkp8VRYa0Wz4RfWwhOKWY9wvNVyPKxkMDnXVapcsVt+lqZGOsXGuHlw1S
	 oORvkkFizQq+/g81sLuU9dakw6gUaQr7YulurCn6ynWoXRQYgPc3gurI3R4HTAD6+t
	 qN7GOGKlKQZdg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E818817E1544;
	Fri, 18 Jul 2025 08:48:56 +0200 (CEST)
Message-ID: <e9e60ce4-c8f4-45cf-9ac2-b147eabc3201@collabora.com>
Date: Fri, 18 Jul 2025 08:48:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] ASoC: mediatek: mt8365-dai-i2s: pass correct size to
 mt8365_dai_set_priv
To: Guoqing Jiang <guoqing.jiang@canonical.com>, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com, amergnat@baylibre.com
Cc: zoran.zhan@mediatek.com, linux-sound@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250710011806.134507-1-guoqing.jiang@canonical.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250710011806.134507-1-guoqing.jiang@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/07/25 03:18, Guoqing Jiang ha scritto:
> Given mt8365_dai_set_priv allocate priv_size space to copy priv_data which
> means we should pass mt8365_i2s_priv[i] or "struct mtk_afe_i2s_priv"
> instead of afe_priv which has the size of "struct mt8365_afe_private".
> 
> Otherwise the KASAN complains about.
> 
> [   59.389765] BUG: KASAN: global-out-of-bounds in mt8365_dai_set_priv+0xc8/0x168 [snd_soc_mt8365_pcm]
> ...
> [   59.394789] Call trace:
> [   59.395167]  dump_backtrace+0xa0/0x128
> [   59.395733]  show_stack+0x20/0x38
> [   59.396238]  dump_stack_lvl+0xe8/0x148
> [   59.396806]  print_report+0x37c/0x5e0
> [   59.397358]  kasan_report+0xac/0xf8
> [   59.397885]  kasan_check_range+0xe8/0x190
> [   59.398485]  asan_memcpy+0x3c/0x98
> [   59.399022]  mt8365_dai_set_priv+0xc8/0x168 [snd_soc_mt8365_pcm]
> [   59.399928]  mt8365_dai_i2s_register+0x1e8/0x2b0 [snd_soc_mt8365_pcm]
> [   59.400893]  mt8365_afe_pcm_dev_probe+0x4d0/0xdf0 [snd_soc_mt8365_pcm]
> [   59.401873]  platform_probe+0xcc/0x228
> [   59.402442]  really_probe+0x340/0x9e8
> [   59.402992]  driver_probe_device+0x16c/0x3f8
> [   59.403638]  driver_probe_device+0x64/0x1d8
> [   59.404256]  driver_attach+0x1dc/0x4c8
> [   59.404840]  bus_for_each_dev+0x100/0x190
> [   59.405442]  driver_attach+0x44/0x68
> [   59.405980]  bus_add_driver+0x23c/0x500
> [   59.406550]  driver_register+0xf8/0x3d0
> [   59.407122]  platform_driver_register+0x68/0x98
> [   59.407810]  mt8365_afe_pcm_driver_init+0x2c/0xff8 [snd_soc_mt8365_pcm]
> 
> Fixes: 402bbb13a195 ("ASoC: mediatek: mt8365: Add I2S DAI support")
> Signed-off-by: Guoqing Jiang <guoqing.jiang@canonical.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



