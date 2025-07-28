Return-Path: <linux-kernel+bounces-748353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF59B14009
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55E717DC27
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734CB280309;
	Mon, 28 Jul 2025 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="WaQKzh3h"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60245274B2A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719518; cv=none; b=ttoBcXh/dFCI0lb+47EsVLk1L+rk208+MlgboFG5H6irqbp1gh+rCFUL+1Y/ce8FSNt1ITKOuxoRJgcVuR9m9dE1UiiCBF2TEvWOSTyJ4E27S+CMM+NilhJpdvxdi8g+VT6oQ3/qDoYkg3DwtxDAl+6StDljxYdWEsdJPHpiI78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719518; c=relaxed/simple;
	bh=qZoIOpM275X4L3kKtCAm6l0VO0badaejvSERKJ3EkiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHQmdTGFC2Q6ODBQS2sRsVSB7vag0uSPFsRLGp+OX7cIcKhAB0AXffZPjRZHGkAau7daQkDDBPjWolxAg8UABvXjUpKZcXoqUYLP24vnrPkWWDItuf7KfW0joem2zAXTnxyYcXBirESPgI5j6fxT0/AEHMKU2Khiply0KskAnqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=WaQKzh3h; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753719516;
 bh=YyHnFzhHfGPVWYtWBHmq/4Wb5XjJqFHdWikvdnddpqs=;
 b=WaQKzh3hOSXdXdy5mQgnvyjJb0Na4DnOT1Wz3QITFXm88IPAvrmFyp079cdykUeDZUrRtjVJx
 ZSENRiJNdjJYe4JXICI05YwRKHO9kT+5OVG4ZHd3+dyWRSPLh1VLm8AGfn8s2fBXl40MEV8sH+u
 SVclwYB+Wy90wVx5pyFEBtaxN9ACi9sWvA/1KIzhKRgKL45vOnseXPB2SGTlrPHqdjS2XIIVzSR
 HYpB6ilfBisjD8xYkBrf8iabN/AeVxx7qzKl/kH8QA9DZ9KtKJCGiDzGrTuXPpP2OzCIp0xZO1v
 OlvspV4AuAzSXANiqfp5KQPC4+2AYEmKyAeL2hURatyQ==
X-Forward-Email-ID: 6887a2d9351ec66b15a23cb7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <bd253ee7-742b-4fdb-8ce2-4976d4578a3a@kwiboo.se>
Date: Mon, 28 Jul 2025 18:18:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Add SFC node for RK3528
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "ziyao@disroot.org" <ziyao@disroot.org>
References: <20250727144409.327740-2-jonas@kwiboo.se>
 <20250728070038.174726-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250728070038.174726-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 7/28/2025 9:00 AM, Chukun Pan wrote:
> Hi,
> 
>> +		sfc: spi@ffc00000 {
>> +			compatible = "rockchip,sfc";
>> +			reg = <0x0 0xffc00000 0x0 0x4000>;
>> +			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
>> +			clock-names = "clk_sfc", "hclk_sfc";
> 
> The clock* should be placed before interrupts.

Thanks for catching this, will fix in v2.

> BTW, doesn't the sfc node need to configure pinctrl?

Not sure if it make sense to have a default here. fspi_pins is most
likely always used, however fspi_csn0 and/or fspi_csn1 is probably board
specific.

On the Radxa E24C only fspi_csn0 and fspi_pins are used.

Regards,
Jonas

> 
> Thanks,
> Chukun
> 
> --
> 2.25.1
> 
> 


