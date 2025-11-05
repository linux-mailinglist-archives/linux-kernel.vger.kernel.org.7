Return-Path: <linux-kernel+bounces-886454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5DCC35A88
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6804A1886D01
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B264313295;
	Wed,  5 Nov 2025 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pl+bDX0b"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459B21146C;
	Wed,  5 Nov 2025 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345883; cv=none; b=SaX+cMoOQbPPK3ZdHg6KZ+0iYqtC4inQlFBuiMoMHguHrdkQmhEZE+lPGSE0NYU7zhD+fvwyiJw1cMlEAUtJSaCLf5oHjr1tnBLleQ0xipFgn8cLvvC5zrWRgG7gBddLnCo5BosKM3osaDnLEjBDQ/b50JoGZ+QMl8u9sxJPI/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345883; c=relaxed/simple;
	bh=3orZaa3BJfbbwuZiYUMX6DK1I31IvSAL999Rpt9kpxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=totQm/+KCB7fL/NBiKgqiluu+N47sMeF38RfFCEZqIFeGR0pWPbn9KEz3OY7n9EmV3S7lXd8Y640OFJQJLIZSduiAqcWwSANGLHK4ffvnKnmPd/I5MiE6LB/rTj7txL5MrfhMhyeUBJAijTlPPvXwUoJmeIcBahaSK+0iRCPJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pl+bDX0b; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762345880;
	bh=3orZaa3BJfbbwuZiYUMX6DK1I31IvSAL999Rpt9kpxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pl+bDX0bsfW2Sp34vBeeVU0amQOnBSbALUJjzViisp14VXUgd+kJ2YRyADMAXSu2k
	 +tZQKNisJ1L5dnAApFHRQaYpIr0fRxzw8e7thjpllTZIxnYn6cMV7VBi3nhcUxriyM
	 xYtTANz739MqPnWXBEdScSR/YYxXG7tyOukQXzaXjHACdxikSaT29xW0B4aDPt8gQG
	 UGu/J/YKwraPp2LqhOqy320iKfH39MqvzGcPk1YFENq5a29Z7AFdcQK6ddODigVmSf
	 5Zd7um2SPDAhjP0Kw8QabG3x9Tiw3p7FyOQH8mXK31/RMoRVmJFobQrKgGAVKXG5HQ
	 D8LBxCHc0tM8A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AF9E517E009B;
	Wed,  5 Nov 2025 13:31:19 +0100 (CET)
Message-ID: <8bbea465-c277-499c-937d-71790a3555da@collabora.com>
Date: Wed, 5 Nov 2025 13:31:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] media: mediatek: fix VPU device leaks on probe
To: Johan Hovold <johan@kernel.org>,
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
 Houlong Wei <houlong.wei@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>, linux-media@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251028100454.4086-1-johan@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251028100454.4086-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/10/25 11:04, Johan Hovold ha scritto:
> This series fixes VPU device leaks during probe of the mdp driver.
> 
> Included is also a minor documentation update to make it clear that the
> VPU lookup helper returns the device with an incremented refcount.
> 
> Johan
> 
> 
> Changes in v2
>   - drop incorrect vcodec patch since that reference leak has already
>     been fixed by commit bf1d556ad4e0 ("media: mtk-vcodec: abstract
>     firmware interface") which added the codec release callback
> 
> 
> Johan Hovold (2):
>    media: mediatek: mdp: fix device leak on probe
>    media: mediatek: amend vpu_get_plat_device() documentation
> 
>   drivers/media/platform/mediatek/mdp/mtk_mdp_core.c | 7 +++++--
>   drivers/media/platform/mediatek/vpu/mtk_vpu.h      | 2 +-
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 


While series is

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



