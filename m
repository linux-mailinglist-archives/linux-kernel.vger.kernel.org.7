Return-Path: <linux-kernel+bounces-840132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 944E3BB3A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0121752C0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461030AAC2;
	Thu,  2 Oct 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FEqpewgy"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA902F0C5D;
	Thu,  2 Oct 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401248; cv=none; b=AQDc++UsnAxJPewvK2C4phtreWlP4dk4PK0otf0c2hDyaLe9bNfJckeK14t0EfJOZtEJR5JMXm8uLnFKsn4MKTBzRu/h+hw/xrl3I33iWYb4X08Nk+ZH25425jLiFffjPKA7eZanAHHcw2SJcHwyhaCUvMopXBbtS3hcUIVJgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401248; c=relaxed/simple;
	bh=yCHwgWNVGCTxuuG33TUZ1dUtpx+S65GKZJdMcIKh/u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmKnSGlto4Rp1NO4LTwwgH8VYkHVz9uBMHfP6Kcz2S1dr0OAt6B2eh5FYhEDY32VoHBBay4Czib+ktcFuvMJMBTfA1HrcXbXGWHlQ6glNstiZw7jgCtVFNxQsvjoAxzBReBVoSp/fBY7WhEzPJJXUDkeBsqvk+Gj1GEVFPC//xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FEqpewgy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759401243;
	bh=yCHwgWNVGCTxuuG33TUZ1dUtpx+S65GKZJdMcIKh/u4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FEqpewgygAdLWN4GejD4G3au5APVkAWwxzYwAhqQsX2cH/YoAk3f9fY4fY3gNKWq5
	 OVvREIT4CCMYz/9wa9KCofWUZPRRK+brp6ezfunnU6T7wPHotA8CkgpAiTSSVSw/jq
	 qvK+7tE73h/XLy2gaKlozS55gI4oU6ecw2ugERVwWAyXATBFrDomxfL5myXbZQWjYt
	 2acwSwCEtPjjA2SUqtXq31uNWhSukDtRhzmy+ed45eUe1PzL+uxWFgxwxqg57LqSMN
	 QLgxCy3BghLFGm7kaDyXI7uqPkJnHo7QlpANJ+3eu7qUcFDryOg82GTlTQFqYFdzQb
	 5K0eO1mkRU8SQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C0FED17E02B0;
	Thu,  2 Oct 2025 12:34:02 +0200 (CEST)
Message-ID: <e584b589-e9f0-48cf-9e75-a6ed64d9f7a3@collabora.com>
Date: Thu, 2 Oct 2025 12:34:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
To: Jjian Zhou <jjian.zhou@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20251002084204.15898-1-jjian.zhou@mediatek.com>
 <20251002084204.15898-3-jjian.zhou@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251002084204.15898-3-jjian.zhou@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/10/25 10:41, Jjian Zhou ha scritto:
> Add mtk-vcp-mailbox driver to support the communication with
> VCP remote microprocessor.
> 
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



