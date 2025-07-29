Return-Path: <linux-kernel+bounces-749249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99709B14BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D419E174EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0302E288C04;
	Tue, 29 Jul 2025 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N/5cyCKu"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEED1F7554;
	Tue, 29 Jul 2025 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783952; cv=none; b=aqbwzImOeb8WTpHERbUPqkZUpryNS9QfO7LlQ5j4tEBmCTDmSIZ6/6vXDeCB6JXqbjbvHyT/yUA0aFVFAt1VL+qfGRumkVb+fxjg06veXKdtk4MYzDJJx0Onl7Iq870PpuC11SQQ0b/v1mfEHoFmwzBn4HOgPvVGFojvd4apsRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783952; c=relaxed/simple;
	bh=ga1JTtLUG7Q52MGzj+vkuRjsmvah356T2zKFS+YsXcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZETT+PLxji2vp/TJoBAU0xkmakcB/1ju45Xktxzs7c2bZZ5RTzm9vH5L3oTpsjw8IaZUXHXob0FJsWBHRWSM1eijvnlOdl+a1xnPq1tO4UenKNgN3aNqsWC/FSiCupRU6Rk0/4M9uEMFoov6SKEOkesNbZRavOkFxI3lV9ZV99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N/5cyCKu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753783948;
	bh=ga1JTtLUG7Q52MGzj+vkuRjsmvah356T2zKFS+YsXcE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N/5cyCKubm8JTRiz0NaERogxpC26wBdILD44OYbuR3AyAWI2d4V2tKksMFHzjPQaY
	 KXedWyGg99EDOZADwvUFIH+00PqZfJAhxSVmF5t35hBFA0w6HaslbJtfhKLd58Ihzc
	 jdo59aEPgerez2WgwWAoKe1NF2qZlg9qwiCXwAoWiuE1rFWllIgYZ84jVcpGTQRkQ7
	 0PEjqS64qpCOiWM+iQfC48TTL5dMgBTjocbslKIYcCBkz/V4Cmunwo76FDYje2/cQX
	 rp812m3xIHZwy+4362adXy4sNGQKSpJqSG5peTqfIotZ1kIE73c6usUW9aEz5H7niS
	 N+Cf+coo7+e8A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 380AF17E1284;
	Tue, 29 Jul 2025 12:12:27 +0200 (CEST)
Message-ID: <8fbe2710-df2a-463d-a6d0-3e3c1a2ba465@collabora.com>
Date: Tue, 29 Jul 2025 12:12:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: defconfig: Enable UFS support for MediaTek
 Genio 1200 EVK UFS board
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Ramax Lo <ramax.lo@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20250729093506.273337-1-macpaul.lin@mediatek.com>
 <20250729093506.273337-4-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250729093506.273337-4-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/07/25 11:35, Macpaul Lin ha scritto:
> Enable the UFS related settings to support Genio 1200 EVK UFS board.
> This board uses UFS as the boot device and also the main storage.
> This includes support for:
>   - CONFIG_SCSI_UFS_MEDIATEK
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


