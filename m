Return-Path: <linux-kernel+bounces-828743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF319B9555C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F86C189B258
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27765320CBF;
	Tue, 23 Sep 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ENxgqdB2"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614EC1946DF;
	Tue, 23 Sep 2025 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621310; cv=none; b=CfLsumL4EgW3k01VOAD9VU671uv4bGyTZx0yuJNO4HO4QsNbEQjyqeOObIWvAZx5JKKAXcQz6CK/+CBg3MdK+FDLUAP9jN3IA5mRHys3JEV/BuWSx3NMbUsZWQsYTp0bN7IBBleX4+ThkI8+6Wvb7AwWdPeeSl/nwutMiDCiM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621310; c=relaxed/simple;
	bh=6jkoZaLgcRgIvyAKD9Sgrmlisy0AVP4pRawO5HYe6i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtIeSrfIdXePqy3G1IRfE3SdUXP5PT0brbLW7ZYvDh7zyLh26zCan0VEIyUkoJLBpdA5RLNUM2KLnrgUZBSwo1T2f2NCbu6ICGfCdC1zfsdIcEUQWyRGEuROhATE1Sw9fqQvGfGQmH9kw0inshDo364PT41BWF7pq0pzz5k5RT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ENxgqdB2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758621306;
	bh=6jkoZaLgcRgIvyAKD9Sgrmlisy0AVP4pRawO5HYe6i4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ENxgqdB20Q6egxrLJ/jdK12CrtpBRvuAat1f/ggJa6qUan0LopthbwJZcEUEIldxH
	 Z+z24QYl5FDG+eLZMlpStEg8zJsONSfVc3AwsWl/bkPYIMtnj+0L8dht2s/XEABPmf
	 hKDoVwkLkkLkU2VxsD86oLgOv2irwXqKu67WmoZYDDoygxhObV7PJzNoq0qHuuKVUn
	 BkhiOgwB2oCqBNQuTNKY89DJ79AxAVehYMRFiRaxtxxwMTI+hsGnQ9kSyke3xPOnLz
	 HPLCc8/OptlYTzrvS6YGnAjm9f9Sz5PxzvFioH3VJxmkM9GFPDHJRliu3UEsSjlK1H
	 2WGmncA/N+s5A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E11BC17E0299;
	Tue, 23 Sep 2025 11:55:05 +0200 (CEST)
Message-ID: <2961fdbb-067a-4d03-a4fb-68ea54638724@collabora.com>
Date: Tue, 23 Sep 2025 11:55:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] memory: mtk-smi: Add mt8189 support
To: Zhengnan Chen <zhengnan.chen@mediatek.com>, Yong Wu
 <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250919081014.14100-1-zhengnan.chen@mediatek.com>
 <20250919081014.14100-3-zhengnan.chen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250919081014.14100-3-zhengnan.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/09/25 10:09, Zhengnan Chen ha scritto:
> From: "zhengnan.chen" <zhengnan.chen@mediatek.com>
> 
> Add the necessary platform data and ostdl setting to enable support
> for mt8189 smi.
> 
> Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



