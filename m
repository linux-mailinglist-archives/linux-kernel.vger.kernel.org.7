Return-Path: <linux-kernel+bounces-822653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F61DB84678
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECB516AD98
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11BD2BDC1B;
	Thu, 18 Sep 2025 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aT13i7do"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BE25334B;
	Thu, 18 Sep 2025 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758196044; cv=none; b=M1wNwz4WVL4VPbM3jlJjU2T7Z6g/2xGGqfXyXPSUG4g/5k8AEtojCwvN9xfAntDEGHTjEnRR0zIrJCI2SfbXpg9ChOk40MOwwPgBkabUuDmtFib6tA2TaknbvRTwYro2rx6tcSYVhMPW1csY7VDzszL6wlyG23MZZK/WUgJCTBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758196044; c=relaxed/simple;
	bh=6EKZDkdDj+TQTFKi29y3ENgReTXMEGTTC1s38Fo2/GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKLPctxpDXXpwGstykJm/IO3zIP2CKIbmg/7Uw8CcEQ5PnOjgdFFJzy+n1Vr2GelgW5Jc3em9sqRidtio9grnuCts0stKmZ/eMeSZ+XR+UN8vozwfU7bHdisiIzbytmUdcxeFqTos/ucE+CuBRprznRzvTdagtvx43yp8ev7mdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aT13i7do; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758196040;
	bh=6EKZDkdDj+TQTFKi29y3ENgReTXMEGTTC1s38Fo2/GA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aT13i7doY1WMx3ADOq+HzXsPl1jAKpBpEZI81nRRpR+YRkCVwTNVdH5tHrdUx3Ave
	 c4g1Gvmj9RW3sKCGJM52hwcYc/6zn+zlK/Zd+zsC4hBX1vWPqf/EFswGkgsaDi+xhb
	 +k4ZyVOf7h0E3WxBhGKhb8x20GmLSarNAv5g9/6+2zAS6XBJj7I3RmfHAdN6Fkghu8
	 33DaoU50JzO5m0UplX3G/wEQZpt2qUBVdkwgWr9Q4P5pStpXl8UjqIWMQb9GPvE7fV
	 Ew1wQ82nMzRp497XUEfegOK0EIk48nKPkU9MuQwkYliUnzpmPYQEU7nZhpOsTzxtXG
	 aYenc45V8LhOQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0583E17E0B8C;
	Thu, 18 Sep 2025 13:47:19 +0200 (CEST)
Message-ID: <c31bc281-94d5-40b6-a9bd-76b41769f6e5@collabora.com>
Date: Thu, 18 Sep 2025 13:47:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] SPMI: MediaTek: Add support for multi-bus
To: sboyd@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, hsin-hsiung.wang@mediatek.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20250703115828.118425-1-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250703115828.118425-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/07/25 13:58, AngeloGioacchino Del Regno ha scritto:
> Changes in v2:
>   - Fixed indentation error in dt-bindings
> 
> This series adds basic support for multi-bus (multi-master) SPMI
> controllers, as found in the MediaTek MT8196 Chromebook SoC and
> the MediaTek MT6991 Dimensity 9400 Smartphone SoC, including RCS
> interrupt handling and per-bus registration.
> 
> AngeloGioacchino Del Regno (5):
>    dt-bindings: spmi: Add MediaTek MT8196 SPMI 2 Arbiter/Controllers
>    spmi: mtk-pmif: Add multi-bus support for SPMI 2.0
>    spmi: mtk-pmif: Keep spinlock until read is fully done
>    spmi: mtk-pmif: Implement Request Capable Slave (RCS) interrupt
>    spmi: mtk-pmif: Add support for MT8196 SPMI Controller
> 
>   .../bindings/spmi/mediatek,mt8196-spmi.yaml   | 138 +++++
>   drivers/spmi/spmi-mtk-pmif.c                  | 471 +++++++++++++++---
>   2 files changed, 530 insertions(+), 79 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/spmi/mediatek,mt8196-spmi.yaml
> 


Gentle ping on this series.

Regards,
Angelo

