Return-Path: <linux-kernel+bounces-864083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86897BF9DED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C2A94F222D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235FC2D3237;
	Wed, 22 Oct 2025 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ArXfRtXO"
Received: from mail-m3284.qiye.163.com (mail-m3284.qiye.163.com [220.197.32.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B592D29CA;
	Wed, 22 Oct 2025 03:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104688; cv=none; b=mXt5WHqwu+PkGxBHQdqwS0XzvScTzKQPXUhhDgMOlHuob0oUmnVytwkhtYizwyuBD12hISKn5gFbM9J9tyYz1ylyIBKyNQ+zglSSJfPfkTE37sguP3vHL9WczgqJp9H1psMbEwqQCy6/LOYqq/X/zMPbTLbuOP1lU7rp8mUlZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104688; c=relaxed/simple;
	bh=4CUUYu8tJIpieoEr4zh1QV6WKXOdMk/TpkB9Q8Hm9BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBK9am9OqNmOX3mupEqgBnI/tOV48PL8jGoCP14iU0Iru8vaZf9jVNKSdxfCqo2Djl5nqxFw8PqxUVypSrlaebY0IM2w5ugelUGsflQChxsRQslqhk2D+awfxPHVV5kgQnCHR2nGvKE9+0NVud9uACQUKcm/fFp1p11gpvVHuOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ArXfRtXO; arc=none smtp.client-ip=220.197.32.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.30] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26bdc4b26;
	Wed, 22 Oct 2025 11:44:34 +0800 (GMT+08:00)
Message-ID: <f9aaa47e-4fa5-4b13-8abc-392d2c96512e@rock-chips.com>
Date: Wed, 22 Oct 2025 11:44:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] clk: rockchip: add support for pvtpll clk
To: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com,
 sboyd@kernel.org, sugar.zhang@rock-chips.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
 finley.xiao@rock-chips.com
References: <20251021065232.2201500-1-zhangqing@rock-chips.com>
 <20251021065232.2201500-6-zhangqing@rock-chips.com>
 <13871591.dW097sEU6C@phil>
From: zhangqing <zhangqing@rock-chips.com>
In-Reply-To: <13871591.dW097sEU6C@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a0a04be1703a3kunm0809e1ec6ecec4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRhPSVZKTUJKGU8dQ01LSENWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ArXfRtXOs2Jy9UF1xMhJNAXTDSfBWHv5TLXYDrpUBZhvjN0KZHcPa6Htb7xhp6ndoH9+j0hekWLIk24NbBulhzu9JGj+WCGA2RSZSb1hEG1s8x3RgYZoDVVUUYXCfV6+nTV20cmyoWv2ZRkX2h82AHT2ZEzZWEElehV4GWOOsD8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=GOlmDU3XHNnYO/SjaQRIDwYCDCAm+u1iC+Arz69K7Y4=;
	h=date:mime-version:subject:message-id:from;


在 2025/10/21 21:47, Heiko Stuebner 写道:
> Am Dienstag, 21. Oktober 2025, 08:52:30 Mitteleuropäische Sommerzeit schrieb Elaine Zhang:
>> Support to adjust pvtpll by volt-sel and otp.
>> Support calibrate pvtpll init frequency.
>>
>> PVTPLL is used to monitor the chip performance variance caused by chip
>> process, voltage and temperature, and generate a set of reference signals
>> for adjusting the voltage of the chip.
>>
>> PVTPLL supports the following features:
>>
>> 1. A clock oscillation ring is integrated and used to generate a clock
>> like signal (osc_clk),the frequency of this clock is determined
>> by the cell delay value of clock oscillation ring circuit
>>
>> 2. A frequency counter(osc_cnt) is used to measure the frequency of osc_clk.
>>
>> 3. A externally input clock (ref_clk) is used as a reference clock for
>> detecting the frequency of osc_clk.
>>
>> 4. A calculation counter uses ref_clk to generate a configurable
>> periodic timing window.
>>
>> 5. Two clock counters are used to measure the frequency of the clock
>> generated by OSC_WRAPPER?
>>
>> 6. Support for dividing the ref_clk and osc_clk
>>
>> 7. Support for configuring the effective polarity of the voltage
>> regulator signal 'OUT'
>>
>> The clock path of cpu used pvtpll:
>>
>>      --gpll--|--\
>>              |   \                                 | \
>>              |    \                                |  \
>>              |     \                               |   \
>>     --v0pll--| mux |--[gate]--[div]--clk_core_src--|mux |--clk_core
>>              |     /                               |   /
>>              |    /   --ref_clk--[div]-cpu_pvtpll--|  /
>>     --v1pll--|   /                                 | /
>>              |--/
>>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> [...]
>
>> +	pvtpll->regmap_cru = syscon_regmap_lookup_by_phandle_optional(np, "rockchip,cru");
> Not convinced about that :-) .
>
> (1) the cru itself already ioremaps the CRU memory, so having a syscon
>      there would ioremap that memory a second time.
> (2) we should definitly not expose the whole CRU io-memory to other
>      drivers to write "random" stuff to. This will just invited further
>      hacks, where people want to take shortcuts with clock settings.
>
> Also this seems highly specific to the rv1126b.
>
> Looking at the registers, this is a clk-mux between that deepslow clock
> and the actual pvtpll output and the config function really only
> reparents to the pvtpll in all cases.
>
> So I believe this should in the worst case just be mux clock, but also
> I see that the "correct" setting will already be set by the
>
>          /* pvtpll src init */
>          writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_CORECLKSEL_CON(0));
>          writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_NPUCLKSEL_CON(0));
>          writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_VICLKSEL_CON(0));
>          writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_VEPUCLKSEL_CON(0));
>          writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_VCPCLKSEL_CON(0));
>
> in the rv1126b clock driver?
This configuration is only used to select the source clock of pvtpll, 
whether it is 24M or 32K.
For pvtpll to function properly, it needs to be switched from the 
default 32K to 24M.
>
> So that whole mode setting should not be necessary at all maybe?
Pvtpll adjusts the ring and len parameters according to the voltage and 
frequency, and calibrates and adjusts the parameter table of pvtpll 
based on the batch of chips.

Pvtpll is located in pd. After the pd on/off, configuration information 
will be lost and some recovery operations need to be performed, so the 
address of cru is required.

About the syscon attribute is used by the cpu dev freq driver to obtain 
pvtpll information.This depends on cpu dev freq driver. Upstream can 
remove the syscon next version.

>
> Thanks
> Heiko
>
>
>
-- 
张晴
瑞芯微电子股份有限公司
Rockchip Electronics Co.,Ltd
地址：福建省福州市铜盘路软件大道89号软件园A区21号楼
Add:No.21 Building, A District, No.89 Software Boulevard Fuzhou, Fujian 350003, P.R.China
Tel:+86-0591-83991906-8601
邮编：350003
E-mail:elaine.zhang@rock-chips.com
****************************************************************************
保密提示：本邮件及其附件含有机密信息，仅发送给本邮件所指特定收件人。若非该特定收件人，请勿复制、使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件或其他方式即刻告知发件人。福州瑞芯微电子有限公司拥有本邮件信息的著作权及解释权，禁止任何未经授权许可的侵权行为。

IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents of this email and any attachments may contain information that is privileged, confidential and/or exempt from disclosure under applicable law and relevant NDA. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the information is STRICTLY PROHIBITED. Please immediately contact the sender as soon as possible and destroy the material in its entirety in any format. Thank you.

****************************************************************************


