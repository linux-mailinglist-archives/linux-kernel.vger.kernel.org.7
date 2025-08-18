Return-Path: <linux-kernel+bounces-772937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F269B29991
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686567A33AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DB72741C9;
	Mon, 18 Aug 2025 06:18:45 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823AF273D9E;
	Mon, 18 Aug 2025 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497925; cv=none; b=jzbFxo8si/9GI865m/TYg9aRfg/FjwDEIfnfJoINE/nfaVXa2AG+9Mbb6TafCff0qbWiE3q0VRym6SaqNGuOHxrqpyC2fURC39k2c8kZO67xzfH5HuYCoCm64FyN5K8t8r+EVzizOtzpTuPhcIEsqpNPuL84dU8Ru3cFiwCVzXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497925; c=relaxed/simple;
	bh=YelkCI2wFXS4RLpRQN289W2HuXEBeTZw5aUaGzTs6a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmM11EyYOpv+yQLD3mERFPJ62Rh4ezXPCo4Eohjxy01PU44hNga+Zx+Wco1zdzJs3xshhC1QRjLK1JwCMA5a6j2A+UnzpfJ3NCFv9D1ThEhG/8LhsxVCl7Uy33Sd85v7sKy8JQ3vTFradKnsltApaVaz0y5k8uS/BaFbNU0U3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1755497838t1fd5a6b6
X-QQ-Originating-IP: K5v4RAVWugn23UNjkoicspSCFboAu0bRGFTZhubq0CM=
Received: from [IPV6:240f:10b:7440:1:e696:3c18 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 14:17:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3725019992298414931
Message-ID: <F46196958466A8A7+60461f17-bd3a-4e17-be6e-b4f22dddcde5@radxa.com>
Date: Mon, 18 Aug 2025 15:17:07 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Radxa E24C
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 jonas@kwiboo.se, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh@kernel.org, ziyao@disroot.org
References: <058E04574291144B+66620590-b680-44b9-92c5-7dc4c43080e7@radxa.com>
 <20250815100110.1302357-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20250815100110.1302357-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MhFAoh6gmjppIABUC5Nr7UHdRf/PRmw0CsLmh7kyn1LFXlDeJUL+F7tx
	zcvPEfG3jVlTRSFOYE9ETlGYW41Ak57STppNhCURMf4ZvYd3uzOGCNPEb535vSJ985qlQW7
	E6TQqdNMlgQ6C7lWWqXq5+Hs0YgOz3OTrj6jxQyVD805kJhZSdOOJRZFSoqBQHYWQsv6BAU
	HkGP2/dp7yzi9Yyg7eLZcC3kB4idAgxuZN+/pEv965vSgejW+6/ecdgoxdAgC1LAhsN5qoj
	0ctBbn8zm7LkEauVLVRPnRrCspdMP2iuIC/M+Xz0ue1Ow3GzITVy1n9TXL3Wa6Vr36xn0ws
	6CPeHR6Ma+Rx2ukHvxjh1Zu/hKMUeed2iJGKUzi+ZFibA3aYbTmSEEQdKNQlnDq01blJjf4
	RkRxdjrFoa9rWNo0FfT45yB5zShYUF/OpOq34ZaPoKyLMkjPCZrw59V46ddS1VtF9YC4Ecq
	khoIlMnfLNP8eXy8pAT1vYSA6vfjYMHZxNQkAtztXGAKr5GrbXCeX+/fUd7yzbubcbp14X0
	nvJTuEkFSTPMq5ltKmLMTtoA+JPdh3EDKOvP/LDBgkv6vlDgBRCb1GF9wZLr3oZdRCrnXdp
	5KwTXyLz0rtSA7bgb+81xOqJCutXJGsH136p90NZJEhxIBE3bWpndnE4yg8lWSiXoaw/BkV
	bys+Su5ou3bfRCirxmwfG2VFRecRhf/YaVh6mAtVViAOuVUom5He7zsiRnqoZrVcZCklvfs
	OTNF3xjw+2OBT7WXnrFiZ/Dr0EcWk/u8ur1zyy1RL5j3Sgel3A4EjOXTwW1hasavhoHR5XZ
	m/O6cVo3cg4cGeL+0SHTJyAG71dmCh3RhGC6No7vXGkXaN4zQNm3lGsDLKu97RzmwAp/YIM
	BHLu5vXDMJ8ZKay4HtD9mO6IGZ47/ftWE0GfdB0e4i/NfW58tXsThUDYONoMGIJtz+02TPV
	wFg128RFydSKMTd9gzAaSrFU4
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Hi Chukun,

On 8/15/25 19:01, Chukun Pan wrote:
> Hi,
> 
>> "label" is deprecated. "color" and "function" should be enough to
>> explain what they are.
>>
>> (Personally, I prefer LED_FUNCTION_STATUS to LED_FUNCTION_HEARTBEAT)
> 
> BTW, will there be versions of Radxa E24C and Radxa E54C with
> onboard eMMC? It seems that they are all onboard SPI instead
> of eMMC. If there is no onboard eMMC version, we can remove
> the sdhci node in dts.

Although optional, there are also E24C/E54C versions with eMMC.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Thanks,
> Chukun
> 
> --
> 2.25.1
> 
> 
> 


