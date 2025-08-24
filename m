Return-Path: <linux-kernel+bounces-783450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0F9B32DC7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 08:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF78D1B27653
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 06:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593D323B605;
	Sun, 24 Aug 2025 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b="V0h69TQM";
	dkim=permerror (0-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b="ZJvQ/Yw0"
Received: from mail.adomerle.pw (mail.adomerle.pw [185.125.100.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1401C3C08;
	Sun, 24 Aug 2025 06:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.100.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756016915; cv=none; b=Ttp2celjXTlhMD2g+RSYnr6tMeKfM/R8lzLEbuh4d2QbKUA7isNxFo9xtWW0uS8wesjNvnnzL3zDjxzP4QE3Mt7GkL41w5GHN94N4MOTC88BuaPUEj7NGpfk3b1ni4vtvmyOzxdJRxsz9lWMmF+UZ2Eo1XmEOaKzGl1mjWVXRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756016915; c=relaxed/simple;
	bh=B8ee4kyldyPYBE0lEQpibVul5GiqjqmoCWnCVtGtO0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfXdwSXaW6EbHgsSVIKNLTWXAbou6xQtM91KnA+xu0hx4aVc6w5ifZq291PuEQ/FpA0CuRkeLAmyMhXz3MUn2qwzpOwj2aJNgzy2U6UwtOOfSV0R253QK8hRXI+3PadvLLK2fw0uoqN0bIv2qop7TITvNNCf22Pza7dzcWMvcHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adomerle.pw; spf=pass smtp.mailfrom=adomerle.pw; dkim=pass (2048-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b=V0h69TQM; dkim=permerror (0-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b=ZJvQ/Yw0; arc=none smtp.client-ip=185.125.100.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adomerle.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adomerle.pw
DKIM-Signature: v=1; a=rsa-sha256; s=202506r; d=adomerle.pw; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1756016758; bh=BuLN7x9nhSvGMNIfHWMLb/X
	TLbgUL01zpnHuUy4VHko=; b=V0h69TQMBju8848JG9r/KT95nNI/nsVGLpj2QO6Y6KWFnc3hoM
	9tMRwTMOff43dUrhGOA0dbD6PtKc21p5W5PxUdpkYhSAZAzk8E9YFwNL9zsKvpGutkf467Xo3u2
	TpxHdZZL3gYIWTzJD02QIDv1mvxxsNo4uMh9BK7PexBQFhpSwTsCwCV38JHDYak9DqPtN96m/NO
	oQv/bDt6c7d3gfoqp5hcAg7LyCtXrjkqIilFTr3xheSBDlOmXjfyYO5FQQxnZH6hZ2I9e7HZ43+
	ZgUTHjG+szlw19+SGDK4Pj4i6XJLVG0/SATpdaUYs/zHAYLDN/cvmcdTTvGMIdGBPeQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202506e; d=adomerle.pw; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1756016758; bh=BuLN7x9nhSvGMNIfHWMLb/X
	TLbgUL01zpnHuUy4VHko=; b=ZJvQ/Yw0N3qYSsvJcCKBj3EgIuNJgk7GEHWq93sVfgMf3oJyKx
	mpUE5cXAjEkAJ0WlvX+avXWn2wOgFKLHPIAQ==;
Message-ID: <ce4f990c-c336-4aa4-93b0-7b9f4d9663b4@adomerle.pw>
Date: Sun, 24 Aug 2025 10:25:56 +0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: phy: mtk-tphy: add property for
 software role switch
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20250814234825.810-1-me@adomerle.pw>
 <20250815-important-warm-dove-03dde5@kuoka>
Content-Language: en-US
From: Arseniy Velikanov <me@adomerle.pw>
In-Reply-To: <20250815-important-warm-dove-03dde5@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.08.2025 10:28, Krzysztof Kozlowski wrote:
> On Fri, Aug 15, 2025 at 03:48:24AM +0400, Arseniy Velikanov wrote:
>> Add a boolean property to enable software control of the PHY mode
>> switching.
>>
>> Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
>> ---
>>   Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>> index b2218c151939..a90890d4a86f 100644
>> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>> @@ -255,6 +255,12 @@ patternProperties:
>>             use the property "mediatek,syscon-type" for newer SoCs that support it.
>>           type: boolean
>>   
>> +      mediatek,software-role-switch:
> 
> No, bindings do not describe software.
Sorry, I didn't quite understand you.

With this property the driver changes phy mode manually using debug regs 
instead of configuring hardware mode switching (because it's broken on 
some platforms). So every time the role in usb-role-switch changes, it 
has to switch phy mode. That's what I mean by "software".

I can rename this property to `mediatek,force-mode-switch` if that's a 
issue.

> 
> Also, never tested.
> 
> Best regards,
> Krzysztof

-- 
Kind regards,
Arseniy.

