Return-Path: <linux-kernel+bounces-783469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BA4B32E01
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996D73BC0B7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 07:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C2524C664;
	Sun, 24 Aug 2025 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bcc.bai.ne.jp header.i=@bcc.bai.ne.jp header.b="e2L96bCA"
Received: from rmx-b.mailgw.jp (smx-b.mailgw.jp [210.171.6.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7524467B;
	Sun, 24 Aug 2025 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.6.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756021108; cv=none; b=MKlFuCtsc0cd/GxxQw2v+FS7SnZsfqEvYzz/1skEvanvy/rSq0Wq9CvPjoaVDDBlnzUoe9HN1ZhuID0roMhmmupYcCJlO2twalNUUb6UGfgl/YFiMnATeiqvxkPhEttL9Uxb1RV+fphpFORKtDF0nuQeI1FNQYwoP6V+/xWRBh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756021108; c=relaxed/simple;
	bh=iDdCpFyWd7epqUGs66dyAmaZv0TFETT0aH5mRBkakJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwMtn8veZUpJcYGv2YnkQ7LycXJsc9ADmLWk6sexfqibcrzCggF2I7dUDoRcg4xJyewPx4+x9+uf6k+jQorf3tTpVbwqeeGZ57vJyfTXm5Du8ejIP+pmQMyOR5ElypIVNogS0ZmsmUndgRn04MaM3wCT4gKamU1aJ+LBgUMiBCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bcc.bai.ne.jp; spf=pass smtp.mailfrom=bcc.bai.ne.jp; dkim=pass (2048-bit key) header.d=bcc.bai.ne.jp header.i=@bcc.bai.ne.jp header.b=e2L96bCA; arc=none smtp.client-ip=210.171.6.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bcc.bai.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bcc.bai.ne.jp
Received: from bccml.bai.ne.jp (bccml-a.bai.ne.jp [210.171.3.161])
	by rmx-b.mailgw.jp  with ESMTP id 57O7bqps028395-57O7bqpt028395;
	Sun, 24 Aug 2025 16:37:52 +0900
Received: from [192.168.11.8] (bai859bcd79.bai.ne.jp [133.155.205.121])
	by bccml.bai.ne.jp (Postfix) with ESMTPA id 9DF3781AA6;
	Sun, 24 Aug 2025 16:37:51 +0900 (JST)
Message-ID: <5c5e6fe7-866c-4b79-bf52-35a393fbeb3d@bcc.bai.ne.jp>
Date: Sun, 24 Aug 2025 16:37:51 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rm64: dts: rockchip: Enables sound output from the audio
 jack on OrangePI5 Plus
To: Maud Spierings <maud_spierings@hotmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sound@vger.kernel.org, robh@kernel.org
References: <20250821041555.4781-2-opi5plus@bcc.bai.ne.jp>
 <AM7P189MB1009A6BCD143F9BE5C3341FAE33CA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Hide Hako <opi5plus@bcc.bai.ne.jp>
In-Reply-To: <AM7P189MB1009A6BCD143F9BE5C3341FAE33CA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FE-Last-Public-Client-IP: 210.171.3.161
X-FE-Policy-ID: 3:1:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=bcc.bai.ne.jp; s=20240516; c=relaxed/relaxed;
 h=message-id:date:mime-version:subject:to:cc:references:from:content-type;
 bh=b612zyZuwwWZsTfE+gJ72Y9isVumaiaCq1dyAr8cbwI=;
 b=e2L96bCAWEGTgj74lXbRoZnxCIbWVL3ppVqDGlL0ZnVtS7RoSJm2HWDELDPzNuqRkIYFGDW1EkJ5
	rpHcIPzY025bY5XYdVQTqXqPXJIGgfV7VWbrEhojVRuwnePBlI83Sew7IpdlAL91zFnWDrnuAVy5
	ieE4VEQrqIqoxC7Vu5j4A+rkFKucGIzVg0AwKXnK971z1rYMff+5hFbB9GCcTKNTaP03rJvyZEb6
	d3rBs8470uc7P0ZW1bJ9bg9Ge0vfA9vu1rB8Ic32JvSApbE5QqIJj3wmoZklAY+CugAfxanWNy0w
	/g7lLA3rXnPXxcislm2I01rkBglnTvpUA4F+HA==

Hello Muad

On 2025/08/23 19:00, Maud Spierings wrote:
> Hello Hide,
>
>> Currently, analog sound is not output from the audio jack.
>> This patch allows you to select analog headphones in alsamixer.
>> Works with kernel 6.16.1, but not 6.17.
>>
>> Signed-off-by: Hide Hako <opi5plus@bcc.bai.ne.jp>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi 
>> <https://lore.kernel.org/all/20250821041555.4781-2-opi5plus@bcc.bai.ne.jp/#Z2e.:20250821041555.4781-2-opi5plus::40bcc.bai.ne.jp:1arch:arm64:boot:dts:rockchip:rk3588-orangepi-5.dtsi> 
>> | 1 +
>>   1 filechanged 
>> <https://lore.kernel.org/all/20250821041555.4781-2-opi5plus@bcc.bai.ne.jp/#related>, 
>> 1 insertion(+)
>>
>> diff 
>> <https://lore.kernel.org/all/20250821041555.4781-2-opi5plus@bcc.bai.ne.jp/#iZ2e.:20250821041555.4781-2-opi5plus::40bcc.bai.ne.jp:1arch:arm64:boot:dts:rockchip:rk3588-orangepi-5.dtsi> 
>> --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi index 
>> 91d56c34a..656aac2df 100644 --- 
>> a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi +++ 
>> b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi @@ -113,6 
>> +113,7 @@ analog_sound: sound { simple-audio-card,mclk-fs = <256>;
>>           simple-audio-card,bitclock-master = <&daicpu>;
>>           simple-audio-card,frame-master = <&daicpu>;
>> + simple-audio-card,pin-switches = "Headphones"; /*TODO: SARADC_IN3 
>> is used as MIC detection / key input */
>>             daicpu: simple-audio-card,cpu {
>> -- 
>> 2.48.1
> I tried this patch, but I am not able to get any audio out on my 
> headphones. using kernel 6.16.1
>
> I did see headphones in alsamixer, but cannot get it to actually 
> output any audio. Any hints?
I use ubuntu 25.04.
Setting -> Sound -> Output Device.
Two Analog Output-Built-in-Audio are displayed.
Please select second Analog Output-Built-in-Audio.

I'm currently working on another patch. As pointed out by Jimmy, I'm 
creating a patch for rk3588-orangepi-5-plus.dts.
Thank you Muad.

Hide


