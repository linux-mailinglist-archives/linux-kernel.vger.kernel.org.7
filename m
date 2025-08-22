Return-Path: <linux-kernel+bounces-781032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8069CB30C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F78F5E2AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA41134CB;
	Fri, 22 Aug 2025 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bcc.bai.ne.jp header.i=@bcc.bai.ne.jp header.b="bDbcWxBy"
Received: from rmx-a.mailgw.jp (smx-a.mailgw.jp [210.171.6.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0519D065;
	Fri, 22 Aug 2025 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.6.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833488; cv=none; b=pF47UX1dpuTkx0hdvZvQY6ef3AMB/I8d44GPM4i+mfoSaUKeM6D8re5QdIVVKwAVq6N1Ofg6kz4uuglqw7vfewg7/Rld1nSi7tm3QZkIGgA4HnphASPP0UvdIacCTyRbdjcrYZnf5TclAyfnXL2Avn4teSyygkynUSq82c339UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833488; c=relaxed/simple;
	bh=22+DhZ9zPwLkwrXQele1XLn9fEYB+MqI0om042EoCWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSjPa2XuBupoPKxnM4liGnt2lUBGdpm0tNtDu9lfvmjE+nyFvk+JDeRkn/72diu9xyrzkkyScjUw/v7rTqIn1q8lt35Z6wQ98hRZvwfLYeamYN5R3xJU6YyRb7J9wMiTLRMeHEwiLgK8mbYZXXIfA+KYef5TDGRr7Wm/JZj3GVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bcc.bai.ne.jp; spf=pass smtp.mailfrom=bcc.bai.ne.jp; dkim=pass (2048-bit key) header.d=bcc.bai.ne.jp header.i=@bcc.bai.ne.jp header.b=bDbcWxBy; arc=none smtp.client-ip=210.171.6.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bcc.bai.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bcc.bai.ne.jp
Received: from bccml.bai.ne.jp (bccml-a.bai.ne.jp [210.171.3.161])
	by rmx-a.mailgw.jp  with ESMTP id 57M3KnEh030847-57M3KnEi030847;
	Fri, 22 Aug 2025 12:20:49 +0900
Received: from [192.168.11.11] (bai859bcd79.bai.ne.jp [133.155.205.121])
	by bccml.bai.ne.jp (Postfix) with ESMTPA id 1624B8192A;
	Fri, 22 Aug 2025 12:20:49 +0900 (JST)
Message-ID: <d0d7fc7f-d3f5-4375-abc4-c194c5b78c03@bcc.bai.ne.jp>
Date: Fri, 22 Aug 2025 12:20:48 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Enables sound output from the audio
 jack on OrangePI5 Plus
To: Jimmy Hon <honyuenkwun@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org
References: <20250821041555.4781-2-opi5plus@bcc.bai.ne.jp>
 <CALWfF7+rGDxtKDqYyazeh+8bndkyBb8LKe_gMq_EbNycD4mw3w@mail.gmail.com>
Content-Language: en-US
From: Hide Hako <opi5plus@bcc.bai.ne.jp>
In-Reply-To: <CALWfF7+rGDxtKDqYyazeh+8bndkyBb8LKe_gMq_EbNycD4mw3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FE-Last-Public-Client-IP: 210.171.3.161
X-FE-Policy-ID: 3:1:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=bcc.bai.ne.jp; s=20240516; c=relaxed/relaxed;
 h=message-id:date:mime-version:subject:to:cc:references:from:content-type;
 bh=p9uP8cxjGLNlDC8IEuVAZKUw+9vO9WrsgXPNx2Qu4J8=;
 b=bDbcWxBygFWyIUYXw912ssQ4jaYb80gXSXk3Hl+LEmN4HH1ZKhOKkhJUOaDtc07a7wukwvTKE13P
	6oZOXVXfIa4E+/1Zm6IihOKSGAEagfxDQdU3xAZ3+zLxeYSeeVS97JCMO1vYUhPazKP8l+nVkj3V
	7JRo8lTgW7yUjmgFrjqMUjOXBBaRko9DCSF0iqHoGf3Qa+zFEiQSCInR//d43cfWLFi3jDOYzWwJ
	XRZjCELFZgbA46rJ7BraTB5ez6ylspMIGWypXImNQ/17Cb04VzIqeGNZlxcSWfTWPJfWFyCZNQsu
	i9T/X26iZp9erO2/qNx0hmYC/3GbrypfEcMiiA==



On 2025/08/22 1:49, Jimmy Hon wrote:
> Note: the subject lost the "a" in arm64
Sorry, typo.
>
> On Wed, Aug 20, 2025, 23:19 Hide Hako <opi5plus@bcc.bai.ne.jp> wrote:
>
>> Currently, analog sound is not output from the audio jack.
>> This patch allows you to select analog headphones in alsamixer.
>> Works with kernel 6.16.1, but not 6.17.
>>
>> Signed-off-by: Hide Hako <opi5plus@bcc.bai.ne.jp>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
>> index 91d56c34a..656aac2df 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
>> @@ -113,6 +113,7 @@ analog_sound: sound {
>>                  simple-audio-card,mclk-fs = <256>;
>>                  simple-audio-card,bitclock-master = <&daicpu>;
>>                  simple-audio-card,frame-master = <&daicpu>;
>> +               simple-audio-card,pin-switches = "Headphones";
>>
> For the Plus, it has Speaker and Headphones.
> For the Max and Ultra, they only have Headphones.
For boards with an audio jack, the statement 
"simple-audio-card,pin-switches = "Headphones";" is probably required.
Without this statement, the "Headphones" item will not appear in alsamixer.
> So this property should be defined in the -plus.dts and the -compact.dtsi
> instead of this file which is common to all.
  This patch was created with reference to rk3588s-orangepi-5.dtsi.

Hide


