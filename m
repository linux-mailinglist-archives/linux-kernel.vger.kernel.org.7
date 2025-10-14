Return-Path: <linux-kernel+bounces-852468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4EBBD90F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 817C24EB540
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E1630C342;
	Tue, 14 Oct 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VVabfhq7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663B2F8BC1;
	Tue, 14 Oct 2025 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441742; cv=none; b=Q2IYwyIyzNU/OV4QgYm+hTlqYPGlt9zIo8CzuEEAFZyUcjXYjAQiye1TJxr9th/ml1/NlR3BDZ6Ee5kaY37Dsece+Kidt+sCm3+O3Gg632SOgTflLYxnry5SoD0OVq4xgBwoLB8HCELO39c7YYbknA9ZXdBZ5wEApsuuRAFMOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441742; c=relaxed/simple;
	bh=h4RfT8BW5uglHP1wgDRzO4OhIAmDCeHY9g1PjPS2PTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvwmVLqoOCEhU7hlzyIZWQ0k5Cpr2WqL3miC21t09ivlzBLHN0s5fStcyE06p4WqVh465ze84zDnjSqtl2PaGdCmER04ByJfv/yAS7H0QwkyDqba9JHNTikrIxO0yBZD42aoV6UtY2HXFwa9nbsZirmTsfQvSHISobkuT1OVGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VVabfhq7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760441738;
	bh=h4RfT8BW5uglHP1wgDRzO4OhIAmDCeHY9g1PjPS2PTQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VVabfhq7ySgeQWE5YFVpMC15pBUMza3xxclEaC8rofCUOdhDa1fPFMXSahF59tAt/
	 PlscaPeGH6puZRXSh6XtUdnz+6CF9Foificw1MOmFKh4t3a4oTta5+rOFKdNhW3H+Q
	 XUaAdk+wzy5wenoOHpkJhmM5eZ70dpnkv4bCgV3LN459Q+UWo/+TGav8F5A4WOsx/S
	 8dkoYVDPd0mQ+K3sv2RhVKBxsTdmrTyQsqw/GltdW4EFW9qQY1OT+ehE2YAkxfW/M2
	 4E7JHPGCHYOr1A6gBUY6KCGgy4uWUVGuo0rGLqJlv8f7eswHLugQuJw1fo7qIn4pL+
	 IF5aEfRAvMyFA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1FB2517E055D;
	Tue, 14 Oct 2025 13:35:38 +0200 (CEST)
Message-ID: <ac809179-7192-4218-8b13-86b9252652f4@collabora.com>
Date: Tue, 14 Oct 2025 13:35:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/9] regulator: Add support for MediaTek MT6363 SPMI
 PMIC Regulators
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 linux-mediatek@lists.infradead.org
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 wenst@chromium.org, igor.belwon@mentallysanemainliners.org
References: <20251003091158.26748-1-angelogioacchino.delregno@collabora.com>
 <20251003091158.26748-5-angelogioacchino.delregno@collabora.com>
 <5635636.31r3eYUQgx@workhorse>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <5635636.31r3eYUQgx@workhorse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/10/25 16:41, Nicolas Frattaroli ha scritto:
> On Friday, 3 October 2025 11:11:53 Central European Summer Time AngeloGioacchino Del Regno wrote:
>> Add a driver for the regulators found on the MT6363 PMIC, fully
>> controlled by SPMI interface.
>> This PMIC regulates voltage with an input range of 2.6-5.0V, and
>> features 10 buck converters and 26 LDOs.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/regulator/Kconfig                  |  10 +
>>   drivers/regulator/Makefile                 |   1 +
>>   drivers/regulator/mt6363-regulator.c       | 935 +++++++++++++++++++++
>>   include/linux/regulator/mt6363-regulator.h | 330 ++++++++
>>   4 files changed, 1276 insertions(+)
>>   create mode 100644 drivers/regulator/mt6363-regulator.c
>>   create mode 100644 include/linux/regulator/mt6363-regulator.h
>>
>> [...]
>> diff --git a/drivers/regulator/mt6363-regulator.c b/drivers/regulator/mt6363-regulator.c
>> new file mode 100644
>> index 000000000000..812775072eb5
>> --- /dev/null
>> +++ b/drivers/regulator/mt6363-regulator.c
>> [...]
>> +
>> +static int mt6363_regulator_set_mode(struct regulator_dev *rdev,
>> +				     unsigned int mode)
>> +{
>> +	struct mt6363_regulator_info *info = rdev_get_drvdata(rdev);
>> +	struct regmap *regmap = rdev->regmap;
>> +	int cur_mode, ret;
>> +
>> +	if (!info->modeset_reg && mode == REGULATOR_MODE_FAST)
>> +		return -EOPNOTSUPP;
>> +
>> +	switch (mode) {
>> +	case REGULATOR_MODE_FAST:
>> +		ret = mt6363_buck_unlock(regmap, true);
>> +		if (ret)
>> +			break;
>> +
>> +		ret = regmap_set_bits(regmap, info->modeset_reg, info->modeset_mask);
>> +
>> +		mt6363_buck_unlock(regmap, false);
>> +		break;
>> +	case REGULATOR_MODE_NORMAL:
>> +		cur_mode = mt6363_regulator_get_mode(rdev);
>> +		if (cur_mode < 0) {
>> +			ret = cur_mode;
>> +			break;
>> +		}
>> +
>> +		if (cur_mode == REGULATOR_MODE_FAST) {
>> +			ret = mt6363_buck_unlock(regmap, true);
>> +			if (ret)
>> +				break;
>> +
>> +			ret = regmap_clear_bits(regmap, info->modeset_reg, info->modeset_mask);
>> +
>> +			mt6363_buck_unlock(regmap, false);
>> +			break;
>> +		} else if (cur_mode == REGULATOR_MODE_IDLE) {
>> +			ret = regmap_clear_bits(regmap, info->lp_mode_reg, info->lp_mode_mask);
>> +			if (ret == 0)
>> +				usleep_range(100, 200);
>> +		} else {
>> +			ret = 0;
> 
> Just initialise ret to 0 at the start of the function scope when
> you declare it. You've already missed an uninitialised use once,
> and playing these branch games is just asking for more trouble
> in the future. There's no micro-optimisation you're doing here,
> clang produces the same assembly for both zero initialised and
> the else branch version you're doing here.
> 

It's not about micro-optimization. Double initialization is a bad coding practice.

Cheers,
Angelo

>> +		}
>> +		break;
>> +	case REGULATOR_MODE_IDLE:
>> +		ret = regmap_set_bits(regmap, info->lp_mode_reg, info->lp_mode_mask);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	if (ret) {
>> +		dev_err(&rdev->dev, "Failed to set mode %u: %d\n", mode, ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> [...]
> 
> Kind regards,
> Nicolas Frattaroli
> 
> 


