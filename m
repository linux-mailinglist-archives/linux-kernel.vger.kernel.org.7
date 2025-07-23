Return-Path: <linux-kernel+bounces-742084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A59B0ECEF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CBF1AA4067
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A3278E6A;
	Wed, 23 Jul 2025 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NzoEBDDF"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EF9212F89;
	Wed, 23 Jul 2025 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258611; cv=none; b=chCSDtD/e+tk2HVD83eAhGSdec4vTW06nrKm66PMOyvp3MoahH90GgGLkQWLhtWsoip4jaaTSnRL/FWbDqmW7EgiUqcPh7FngEVdwMB5ZfgtniG9A7APMCg4BARydnRQgdWsn7LJcVSJxBZKUscme65Oe1tggHIkwyAjQdfVb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258611; c=relaxed/simple;
	bh=+VQ4AqRNQYlMRlFVDGpoehc6xQniWJm1BPQ7EST4cqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcY33SA5TTcifOXvMMqqKDS65ma3WM+D1Ref4lmJkwbYIJ/NKDf5AFDf7t8f9NhGjcMePh4JSR4YNuITYlVcUleqrfLqENEl6wxSb8KNQ1ezDib8AG02QK/NUmSvf+v93ZUbIa7uLl4KX3U04yNbm16JQFzLi+IMRZVTFWIoVxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NzoEBDDF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753258608;
	bh=+VQ4AqRNQYlMRlFVDGpoehc6xQniWJm1BPQ7EST4cqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NzoEBDDFyHT92D135vYyDMDEg/L899CZaatPg8ttNTCMCzYXMmO9SSXl8HJxzi/eB
	 ouGmCUtK+4g9lbugxf9cGXhtzHCTnX8aIjeBUxrjc18JZeoLDMEQBa66bHd+PZAT1f
	 ANBKPB8CKnumyYU9hNBgfDomPdJJE2gw6cG4kKNlaKgq29lChRTcNb/z+nYrZaEyFl
	 +uML3FedhGDrxPcoHXNNSn23ekKEKAZxz/UstEwZT7/AmC43Zkhp0V1hhbBQ94jRaq
	 oUmudd6wIoxXJ6Cd5j5nPhZfQJbMPGWctqn/5XiCA5PMpcUPLSUC/fJhDMKNOJcIMu
	 yHgFL6I3Dm9Hw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 96B8517E017D;
	Wed, 23 Jul 2025 10:16:47 +0200 (CEST)
Message-ID: <5d7557f0-841b-45ea-901c-5b595ac8bde3@collabora.com>
Date: Wed, 23 Jul 2025 10:16:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: Fix out of range pull
 values
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Enric Balletbo i Serra <eballetbo@kernel.org>, Ben Ho <Ben.Ho@mediatek.com>,
 Fabien Parent <fparent@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250722171152.58923-2-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250722171152.58923-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/07/25 19:11, Rob Herring (Arm) ha scritto:
> A value of 10 is not valid for "mediatek,pull-down-adv" and
> "mediatek,pull-up-adv" properties which have defined values of 0-3. It
> appears the "10" was written as a binary value. The driver only looks at
> the lowest 2 bits, so the value "10" decimal works out the same as if
> "2" was used.
> 
> Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
> Fixes: 19b6403f1e2a ("arm64: dts: mt8183: add mt8183 pumpkin board")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> This is just a few of the warnings related to mt8183-pinctrl... Mediatek
> is #1 for DT warnings on arm64. And by #1, I mean worst. :( It would be
> nice to see some progress on fixing them. Otherwise, seeing new Mediatek
> bindings rather than fixing the existing stuff makes me grumpy.
> 

Thanks for this fix.

You're absolutely right about this, let me check what I can do (and if I can get
some colleague(s) of mine to look at that while I'm away in August).

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


