Return-Path: <linux-kernel+bounces-860672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F172BF0AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B563A6EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F342FB609;
	Mon, 20 Oct 2025 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TpewgXYs"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AB2F616B;
	Mon, 20 Oct 2025 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957383; cv=none; b=rzYG9laVK2eBubB3quWqUN6vvFKPgnRpbxr3wzbRZwlD2A5gMQlR+nwgOXNy4bnYPZ1Wf368EDz3DfOz49vizZhKqP+ZqDJSbWiPeS+FgiRLpGnN/2DNU2+wnip9J33sZTHTgKO2BqmCiavOiX/BmxFbxF5DnxFP0cTuOseIYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957383; c=relaxed/simple;
	bh=I+YIClIz20Rq9+WEu53+FWQ6hYP5ElMvgvG8sAmQxW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/hFmeBdyIBnjql1lk7PI6PcE73n4dmPdlQJyJkj19CCxKFcl5BfN8MaGqMws4ErgY/UkFFuhXgbmVmnno+P5QH7L10FwQGG4Sb/GvPeETd4vp+On2Ylo3gbwerK18NGEPni0R2KStRfsryU/ippakuwaQ3wK5GNthQ6k4NIkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TpewgXYs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760957380;
	bh=I+YIClIz20Rq9+WEu53+FWQ6hYP5ElMvgvG8sAmQxW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TpewgXYsijilmoIMmUUpMgdkfJFJReq3OTbo1AsZEUEFLxnVnQGhRvGFb/Vm3H2qC
	 qcreg7872Lm/1HwpFl8lf+yx0YL9saa+oQkk5H4PKOC0plGlQWbyiA0VWJ1r5fNOsO
	 Fyf0VbUIOcl6vXDtGNFLnC5vZ2rQ/bNFUlWFTuNLQvgIEuLUDCZK6tEuiMkLqwX1iH
	 ZSbQmZZDUjRIHo+M0zqSY9Op5U7O7VW37zrWlGRv/kKxq+RIvZFxWrh6Ymu4O1fhg0
	 j9cIUprsIA4Qss6fySTinczaWWKxgbA7vY9djbQyYjkQKnCTY20Tgm+9G0Jp6ZxXxS
	 Q7TLYKf780Ipw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E108717E13F9;
	Mon, 20 Oct 2025 12:49:39 +0200 (CEST)
Message-ID: <e22e4d18-a481-4332-8b99-ec8386023091@collabora.com>
Date: Mon, 20 Oct 2025 12:49:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/13] dt-bindings: soc: mediatek: add ovl yaml for
 MT8189
To: Xiandong Wang <xiandong.wang@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 sirius.wang@mediatek.com, vince-wl.liu@mediatek.com, jh.hsu@mediatek.com,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20251020074211.8942-1-xiandong.wang@mediatek.com>
 <20251020074211.8942-8-xiandong.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020074211.8942-8-xiandong.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 09:40, Xiandong Wang ha scritto:
> Add compatible string to support ovl for MT8189.
> 
> Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>

Please change the title and write a .. descriptive .. commit description.

dt-bindings: display: mediatek: ovl: Add compatible string for MT8189

Add a OVL compatible for the MT8189 SoC. This SoC's OVL IP is fully compatible
with the one found in MT819.. 5? 6? Which one?

Also do the same for all (well, most of, actually) of your bindings commits.

Cheers,
Angelo

> ---
>   .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml      | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> index 4f110635afb6..578e90d0e3b9 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> @@ -25,6 +25,7 @@ properties:
>             - mediatek,mt2701-disp-ovl
>             - mediatek,mt8173-disp-ovl
>             - mediatek,mt8183-disp-ovl
> +          - mediatek,mt8189-disp-ovl
>             - mediatek,mt8192-disp-ovl
>             - mediatek,mt8195-disp-ovl
>             - mediatek,mt8195-mdp3-ovl
> @@ -44,6 +45,7 @@ properties:
>             - const: mediatek,mt8192-disp-ovl
>         - items:
>             - const: mediatek,mt8188-disp-ovl
> +          - const: mediatek,mt8189-disp-ovl
>             - const: mediatek,mt8195-disp-ovl
>         - items:
>             - const: mediatek,mt8188-mdp3-ovl




