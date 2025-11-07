Return-Path: <linux-kernel+bounces-890009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FBDC3F0E8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DF03AD746
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5BB3168FB;
	Fri,  7 Nov 2025 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kw71YCFc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C812741AB;
	Fri,  7 Nov 2025 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506128; cv=none; b=DVIhE6rN92yNj5AiviKCqKp9XrLAt7SoPjApqCo0VfY2JfzfzkjCcQeQe+arDz4NbuJo7Gbz/ATBuM/WHCRhmd7q0hI+ZXu6fhOaVrxc3LnGaMSCetV2cFwOSs8bTKmQ3in4WnwMgxCPmOp+iVR+eG8qVHlatb6Tp8kZbVjEZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506128; c=relaxed/simple;
	bh=wS/nXim/NyVIVfyxDtGH5DaHltReoroPyVmp5wGin44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZAodwmn75GLEp4r7hm5lLwUXTH071FokqX4CmgEwH0Y+59AV072k02V9aQ8vEYctc8JkFbbHISQ41yJF94iP93a9eZdVjqJWYqWT5hYrJgEUZ3fzvBvCir8b0XtiXYIrSmvieckqlLx47GTRPRkbyKn+uACE7YS+KlIWRAeet0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kw71YCFc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762506118;
	bh=wS/nXim/NyVIVfyxDtGH5DaHltReoroPyVmp5wGin44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kw71YCFcDM3FboAdapJIUMulgckTgvjlgS6m9B403bjyEHLIVrgdDONNohVsuDfnN
	 1lKfOM6hqOcfoAAAAzyejkj1w5Zvev1UyMvWfe9/Fc8sWLfKy56KufeKaArh2DPm9u
	 m27oguRnwFFKer90nU5xVG+QJ6owens5BJJpO5wctUiEfG41BItEL3AubVU/3/lK2N
	 ZaFmDoddsAf+ENDCOYRresyBfzR0PGlePvL0M9dpF5PRNqDJRNy/Gb+Kec22+AkdA3
	 PRxB77za/RqtaAtIV799lB5K/1tlEIVydS9xxbKe49JLu7Cjl2bElzZGe31Hyts4cK
	 yKuVxnfN9zkUg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E21617E090D;
	Fri,  7 Nov 2025 10:01:57 +0100 (CET)
Message-ID: <701b6abc-71e8-43fc-adfd-211a62dbec64@collabora.com>
Date: Fri, 7 Nov 2025 10:01:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/9] Add support MT6316/6363/MT6373 PMICs regulators
 and MFD
To: Lee Jones <lee@kernel.org>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, wenst@chromium.org,
 igor.belwon@mentallysanemainliners.org
References: <20251027110527.21002-1-angelogioacchino.delregno@collabora.com>
 <20251106161149.GU8064@google.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251106161149.GU8064@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/11/25 17:11, Lee Jones ha scritto:
> On Mon, 27 Oct 2025, AngeloGioacchino Del Regno wrote:
> 
>> Changes in v11:
>>   - Removed unnecessary #address-cells in all mt6316 bindings
>>
>> Changes in v10:
>>   - Added "struct" prefix to structs kerneldoc
>>   - Renamed struct mtk_spmi_pmic_pdata to mtk_spmi_pmic_variant
>>   - Added "REG_" to MT6363/73 mfd register definitions to disambiguate
>>   - Expanded MTK_SPMI_PMIC_IRQ_GROUP macro parameter names as suggested
>>   - Some rewording of comments as suggested, addition of more comments
>>   - Refactored IRQ domain handling due to deprecation of function
>>     irq_domain_add_tree() to use the new irq_domain_create_tree()
>>   - Fixed to use generic_handle_domain_irq_safe() to avoid races
>>   - Added support for two interrupt cells in translation
>>   - Removed .irq_lock() and .irq_unlock() in favor of lockdep classes
>>   - Added support for handling PMICs without IRQ Group register for
>>     upcoming MT6685 implementation
> 
> The MFD part looks okay.
> 
> Let me know when you have all the Acks and the set is ready to be merged.
> 


Lee, the regulators part was picked by Mark, so I guess you can take the MFD part
through your tree.

I'm not sure if you can also take patch [7/9] (auxadc binding), but it would be
great if you could, because there is an auxadc example in the mfd binding that
needs that commit in order to succeed the binding check.

Cheers,
Angelo

