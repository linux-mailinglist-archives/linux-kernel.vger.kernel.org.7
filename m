Return-Path: <linux-kernel+bounces-886499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B720C35C36
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9127A4FAC15
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964313164DE;
	Wed,  5 Nov 2025 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CzFOvzAm"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC43081B3;
	Wed,  5 Nov 2025 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347901; cv=none; b=YxFuTTtXlWASGYnsrkrK5PVAkN6wYTbiURCrjaYwA7tTvEGDbAG5b+5gjA12kMEalvC9DOpJ8Hzw2+z/1aQdrmWxSfi0XyPF1FeG8xQaftZ2OqNQ7wUBi6FA7M1b+Ly5yqdkuoVwVIBwMOA+6jwbIiESn9FAuzv6LDCxdrVuVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347901; c=relaxed/simple;
	bh=/lcv0CRLqvhN1u0t7OFVDn+bvcyVjciZS0ifR6L0Ymo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHKCeyyNr16Q6Tenk1v7EszLTTcB2dkVczdQQH8AXuFbk95Bq/o1vDUK/CuWhhRKw/hkXLsP0fkLOcOwbq0T6wBCOYVVzb6ZtmbhiQVpfr/+D7DVE4z5sjE6ZUO+CYgtYlO7vgLFdZmNWHiFXUqL0AZ+Kb8N/A30wcY7aMr+ets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CzFOvzAm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762347897;
	bh=/lcv0CRLqvhN1u0t7OFVDn+bvcyVjciZS0ifR6L0Ymo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CzFOvzAmTBrDXgxrOwrrqIx7gs/r5A98UFhUYqc3e1yH1jxo+Y/O9bdF6Pqij5DdB
	 sVH3pO1h7Bp0sl9UjCg+IyxSZdL5RarAZ+Gdh6F/GAqkSo6tHx4pykUci3gtZQFct0
	 0h3sBhu7RIncDqqNnF+MkL7xhBSjk0WdordJsMCcCbkTD8prf2H5ww+7ERPsttCEbD
	 9Ias+BPY+6HeyUUq4YaVyzhT3NFP4vxcstuuAYWIYMgh7Sl2/CrWx5UsiXZHCFymRB
	 sGv4Vnl35s3mrNcDW71Hy2UaoS6Csp1xRZvNfC6h79qkfxMP3bIJMi3UCjH1xcLhro
	 +WnIVH7unOwug==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 055C217E0062;
	Wed,  5 Nov 2025 14:04:56 +0100 (CET)
Message-ID: <46e8ec8e-977d-4e7c-9f65-0c5d9c517825@collabora.com>
Date: Wed, 5 Nov 2025 14:04:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] SPMI: MediaTek: Add support for multi-bus
To: sboyd@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, hsin-hsiung.wang@mediatek.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20251024083247.25814-1-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251024083247.25814-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/10/25 10:32, AngeloGioacchino Del Regno ha scritto:
> Changes in v4:

Gentle ping for this series.

Cheers,
Angelo

>   - Refactored IRQ domain handling due to deprecation of function
>     irq_domain_add_tree() to use the new irq_domain_create_tree()
>   - Added .irq_eoi() callback for rcs_irq as that better reflects
>     the actual functionality of this interrupt controller (as its
>     SLV_x_y_EINT registers are really signaling "EOI", not "ACK")
>   - Fixed to use generic_handle_domain_irq_safe() to avoid races
>   - Tested again on MT8196 Chromebook
> 
> Changes in v3:
>   - Added Fixes tag to commit 3, collected R-b tag from wenst
> 
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
>   drivers/spmi/spmi-mtk-pmif.c                  | 472 +++++++++++++++---
>   2 files changed, 530 insertions(+), 80 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/spmi/mediatek,mt8196-spmi.yaml
> 



