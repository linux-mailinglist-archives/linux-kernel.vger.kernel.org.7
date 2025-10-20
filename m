Return-Path: <linux-kernel+bounces-860638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F02EBF0918
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9933D34B2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4102F745C;
	Mon, 20 Oct 2025 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ymbfzvez"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3924167A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956558; cv=none; b=bbh4r3gyXzNaOwP3XTEmZXydWyfWms1fwTOf2t/f0uU3SGU0bNMNQVkI65mUp+qoeG5GIDvuDboIFVn0KSJp6uYwZB+MmxNE5p8uFqKDIrPnloAlS+pLTwsZxO+Ag9uXZ/rTWdaezTwLMDxPXN0QjI1iarq+i+vs5WT3r38oGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956558; c=relaxed/simple;
	bh=mGHh4+u3muodQrfYI8vuBXTSLKVHsvy01DupG4JFCeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxrMuCMsI5hx6caK2foAMLS/AW6stv92P6ILcrXdwiWh0u1RPyhvTpuFAGnJYtWBNZRH8XLXN/LzQaju1pA8kv+dBZtgPIbHNKkVPrFjZ9gW01nXHXY9eOI8Z0YQ2XbTBLSTtjpzvr7hdwvtjwRgd0uHEQ/rnkvNybqSWRXVbcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ymbfzvez; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760956554;
	bh=mGHh4+u3muodQrfYI8vuBXTSLKVHsvy01DupG4JFCeE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ymbfzvez+47CIF5d88vLk3/jJF1VCySlB0GnWuxV/7I2EqRdFhqODClhSF2k46i6d
	 8ZpQpf0W3FuD9mE2Df+j+VJ5JgIt2NIEWrnZc04VE1JsjtViJZzNGc46Q4+hZoktzk
	 Pp5y23ZHduL3pSHqgQ6lCCsl+lvNIVD2aURzD+qEWlTcZQMlAyzSEFJSFcBiVNEMOV
	 DHKhb0HeM1Tk+wLmOGHlm3r9g3xf9Q4E7KKO2ImukohnQ6HEevHMTeep8ehTIEm/o6
	 y64dUPFznjcq6nObFb6feWAvaLmp0dBD/JL28EW7LuvEdeVt1FmQKnwp8jORU0883p
	 H8oW6WMDuDLzQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8C8EB17E0C87;
	Mon, 20 Oct 2025 12:35:53 +0200 (CEST)
Message-ID: <12cdd987-796b-44fb-a508-eb1dc7cde8be@collabora.com>
Date: Mon, 20 Oct 2025 12:35:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/14] iommu/mediatek-v1: add missing larb count sanity
 check
To: Johan Hovold <johan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy
 <vdumpa@nvidia.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251020045318.30690-1-johan@kernel.org>
 <20251020045318.30690-11-johan@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020045318.30690-11-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 06:53, Johan Hovold ha scritto:
> Add the missing larb count sanity check to avoid writing beyond a fixed
> sized array in case of a malformed devicetree.
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



