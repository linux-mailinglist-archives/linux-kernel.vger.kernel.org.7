Return-Path: <linux-kernel+bounces-852705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEE1BD9B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3883E32BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213353148AD;
	Tue, 14 Oct 2025 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JiuDP1Uc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14F6314A61;
	Tue, 14 Oct 2025 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447916; cv=none; b=F5o/JOBJMD37yO9Yf5wgdS2KL73x1bSsh8hj+a1KR+sCruie9hwBhKFn+2nTOwVBbZseVVvqfGfHcmoEd6Wmn443W14/HrQCXQoMfBNdivMUenhx1bGoAzrVDNXa4Xp+0X7SfCSQyweBq3sO2w3LjGeisX/h1jG/WZ+YsFdlg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447916; c=relaxed/simple;
	bh=0PHlghkMy0M2zWI+PULLEdh13RRT9hr/l2k572RphtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5uAHsCq/tDcaKIf3owch5Mzh32/CKsbNzOayySsiAZ236H6nDJuOpNL04pHmCb4LxT5GyOFycTVnknVFzJuw0fCj/ZKi8cY9JLOb8B+w9IMdqCTRNcTVqcotDIwHlGnqNQCQAv9C76Y92QklmdNpJjcRoVAuHkDotHbYXBNayA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JiuDP1Uc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760447912;
	bh=0PHlghkMy0M2zWI+PULLEdh13RRT9hr/l2k572RphtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JiuDP1Uc68NZgbbmM9swTQoN8w2zjkaxiyAOm+cMoOh6thPGQgmRBsR9EIpYmYpDa
	 NSYAbqE+mRlhQkiMuqYvGvvxJM4A1WpuAuQ/5euOBX/W9Ag97QTmya5Y5ar0pqrUil
	 AQp2G/4fPuGHlhPZlzjXeVhipJbRDqvJZeZ2vSx+lvU7kiFfvLCxtu3+56yaRUnewJ
	 GyTQEbtLg6hFGDWVoUiGRHNHdTMSGCRd2GEwDM7U65J6rdgufQQxN+Z7meXvs00Y4P
	 OvIMua5nR7bwgVUEpXCOfJtW+yUN0cbP32ZDkFGrc1Jov2kzPbhZuwMelbJYI78MiF
	 EExxrSXt9Sfiw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7182F17E129E;
	Tue, 14 Oct 2025 15:18:31 +0200 (CEST)
Message-ID: <4c44af65-4d69-48a1-a0a0-3fb1cefa1046@collabora.com>
Date: Tue, 14 Oct 2025 15:18:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: mt8365-evk: Enable GPU support
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250813-mt8365-enable-gpu-v1-0-46c44c6c1566@collabora.com>
 <20250813-mt8365-enable-gpu-v1-3-46c44c6c1566@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250813-mt8365-enable-gpu-v1-3-46c44c6c1566@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/08/25 11:25, Louis-Alexis Eyraud ha scritto:
> Enable for the Mediatek Genio 350-EVK board the support of the
> Arm Mali G52 MC1 GPU integrated in the MT8365 SoC.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



