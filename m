Return-Path: <linux-kernel+bounces-754807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CB8B19D00
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527A8178331
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA4023BD1D;
	Mon,  4 Aug 2025 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X7yZLNHL"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2D2F2D;
	Mon,  4 Aug 2025 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294170; cv=none; b=nZZaD+d9dQMdQ8d6SBaI+DEnZOug/MnwIZA7lf6z+HU1Bw9/6cn6pX8HIy9dhuSVM9m5zTUfU7dpWDDKQ0SUq6oBNI8nnHN5OQX7Vlz8nsR5CUuklTSaKRnHXXorWaD9/ELf22721AoMYOQbh1cFR8t1/NincC+JUbgQnPHDuvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294170; c=relaxed/simple;
	bh=BnROzuyXaP1UwzsNHCzraWROM8wBopZw3oc70QdaeLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zp+MefwXNIx81Wm0mjrRMxictV/zM9w5Q61yyn+uctUDEnAwi5k+5kFZIss920M9EaRW7CaD3uUvlXfDqh3arkCl+Eyk98y3KmXHyJF6+0LMknBc47zmAPAQMD3fv9fNVHJDXWtufUhSR6S153MkZ5aBY2770/9KSwEqeOM/yNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X7yZLNHL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754293819;
	bh=BnROzuyXaP1UwzsNHCzraWROM8wBopZw3oc70QdaeLY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X7yZLNHLr5r4UBsZrUZv1Fye/q81mMRCYpkb5sYPybsalpnFBh7oVBKEL22Uj+Fsv
	 OAdjfNL3sn+doU+cV8IywTM0GTsdUtBTkaFYv6v8TzdkykYmFqt4QwkiHvuIt+B2Qs
	 fToBWzRC9+/zfxonJUmzfUr2S6v08U0E4y9UlVdzacKGXHYF4vBYkXvfshKcJLfduy
	 mJtSitKhRYiO71CMnuMvOXGLtXyc8oGbPhtsvLHVUjsJCgr7aW+kWoDbtmctSC24K6
	 cYviCWyOellTh9LYIQTy7hFs3Cm8IXtlwqTkuqu+eoLw0+9ZgM0Z2qKexnnn+EYQ4Z
	 F9TjvuSZUm4Rw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 12EE217E04DA;
	Mon,  4 Aug 2025 09:50:18 +0200 (CEST)
Message-ID: <d030ed4a-bb43-4f24-82c9-6106209013b9@collabora.com>
Date: Mon, 4 Aug 2025 09:50:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/23] Add support for MT8195/88 HDMIv2 and DDCv2
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, ck.hu@mediatek.com,
 jitao.shi@mediatek.com, jie.qiu@mediatek.com, junzhi.zhao@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 dmitry.baryshkov@linaro.org, lewis.liao@mediatek.com,
 ives.chenjh@mediatek.com, tommyyl.chen@mediatek.com,
 jason-jh.lin@mediatek.com
References: <20250415104321.51149-1-angelogioacchino.delregno@collabora.com>
 <2eq5je6xk4ly5lxijit3ufor7pmm7mgivbuigzr35lrbe2ryvr@3axnsyabigm7>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2eq5je6xk4ly5lxijit3ufor7pmm7mgivbuigzr35lrbe2ryvr@3axnsyabigm7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/08/25 00:23, Dmitry Baryshkov ha scritto:
> On Tue, Apr 15, 2025 at 12:42:58PM +0200, AngeloGioacchino Del Regno wrote:
>>
>> This series adds support for the HDMI-TX v2 Encoder and DDCv2, and for
>> the direct connection DPI as found in MT8195, MT8188 and their variants.
> 
> Angelo, just wanted to check, what is the fate of this series? I think
> it wasn't updated since April. It was a really good example of utilizing
> the HDMI framework(s). Wink.
> 

Even though it was fully reviewed, everything but the actual driver was picked
for whatever reason.

I am about to go on holidays for the entire month, but I asked Louis (added to the
loop) to resend the driver while I am away... :-)

Thanks for the reminder and especially for the appreciation, btw.

Cheers!
Angelo

>>
> 


