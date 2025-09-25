Return-Path: <linux-kernel+bounces-832586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A36B9FD4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C7A56346E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A8B287514;
	Thu, 25 Sep 2025 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MtaN07ET"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506628642E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808626; cv=none; b=lSRtr42Asqxl/OEXj4CM6b467Esaz8yWyrPiL6G+nWShAD2icExOYOW0rc2viLrcWzn+cNCYZVy+qYzVmy10qGf1cXTJPxDCwr7wWVa4fyOcw7WkPRMgVEBB2D9ja49pOPX6WjojO0bUBFXkA3lZd4BqdZLo0QML5lns9bOcO7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808626; c=relaxed/simple;
	bh=eVtI5KuXcf+iFYpz0dJERf2R3K4zLl1HHo6brVgQCa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAWZ1hqyAOJ7H4BeD3yuqR7EhSQd8UynXepyiTARwIYV3zdZSzZcACiHryL5zo068zzGNBzKzEoyONKHUyqlUXiUhn3iakLSt2KxGCDBYp43wJCFIqqC2/DEF7n+AzoUb1JQWrkaOO5GfZAb1nVv5jJDVhw+25TMi+iEJJnUoyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MtaN07ET; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758808622;
	bh=eVtI5KuXcf+iFYpz0dJERf2R3K4zLl1HHo6brVgQCa0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MtaN07ET/VwbJQu4G8dyeqXYDtfqBddMTc8oEZHCls7uBSIYJbgHnx2Fzgnxe+rt7
	 LSVNgv7S2WaVJQ2lBwoYVsDHyI1MR37vch0hdlS3akdvRPJ4CkKYQSnlQQVpTZCvZm
	 FFQVDXEG0bBIjZQdGl49Qy3k9vWX8xjP4hok44wu3DBYYDxFaagtXtsf+yf+uC7QSO
	 pGUWf8niVexakTQ9cWYwvRoefqeg3fIDf/nMccECXFBpwHSbdx/4V++OxpkSFzjKgW
	 IWEUK9s/AdF1A7WYo6Ds2HHayNod/xtVSvuv/QSAe7/a0GGmJg57rG3YyMQvzdmH9R
	 l7QPqppdNPacg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 059A417E0FBA;
	Thu, 25 Sep 2025 15:57:01 +0200 (CEST)
Message-ID: <719dcef6-a360-41cc-a5c5-fdbe53ec99d3@collabora.com>
Date: Thu, 25 Sep 2025 15:57:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/mediatek: mtk_dp: Fix hdmi codec and phy driver
 unregistration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 simona@ffwll.ch, matthias.bgg@gmail.com, dmitry.osipenko@collabora.com,
 granquet@baylibre.com, rex-bc.chen@mediatek.com, ck.hu@mediatek.com,
 amergnat@baylibre.com, djkurtz@chromium.org, littlecvr@chromium.org,
 bibby.hsieh@mediatek.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20250924103708.19071-1-angelogioacchino.delregno@collabora.com>
 <20250924103708.19071-2-angelogioacchino.delregno@collabora.com>
 <72pgsr4birfy5wtf5umsfkahr7tplnih5wxoj4x33igapaspmg@7iafkarq4hzg>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <72pgsr4birfy5wtf5umsfkahr7tplnih5wxoj4x33igapaspmg@7iafkarq4hzg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/09/25 03:09, Dmitry Baryshkov ha scritto:
> On Wed, Sep 24, 2025 at 12:37:06PM +0200, AngeloGioacchino Del Regno wrote:
>> During probe, this driver is registering two platform devices: one
>> for the HDMI Codec driver and one for the DisplayPort PHY driver.
>>
>> In the probe function, none of the error cases are unregistering
>> any of the two platform devices and this may cause registration
>> of multiple instances of those in case this driver returns one or
>> more probe deferral(s) in the "wrong" spots.
>>
>> In order to fix this, add devm actions to unregister those and
>> remove the manual calls to platform_device_unregister in the
>> mtk_dp_remove() function, as those would otherwise be redundant.
>>
>> Fixes: e71a8ebbe086 ("drm/mediatek: dp: Audio support for MT8195")
>> Fixes: caf2ae486742 ("drm/mediatek: dp: Add support for embedded DisplayPort aux-bus")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_dp.c | 30 ++++++++++++++++++++++++++----
>>   1 file changed, 26 insertions(+), 4 deletions(-)
>>
> 
> You can save yourself from all these troubles if you store the
> registered device at  connector->hdmi_audio.codec_pdev (see
> drm_connector_cleanup()).
> 
> And of course, you might use DRM_BRIDGE_OP_DP_AUDIO in order to reduce
> code duplication.
> 

Fair point. Noted! Thanks! :-D

