Return-Path: <linux-kernel+bounces-864065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B86BF9D48
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D9C18C766B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FF6279DAE;
	Wed, 22 Oct 2025 03:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gGZPUQhJ"
Received: from mail-m81200.xmail.ntesmail.com (mail-m81200.xmail.ntesmail.com [156.224.81.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CC21F5851;
	Wed, 22 Oct 2025 03:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.81.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761103626; cv=none; b=kczaPFbwnlpvdkeExvu4Voo12uwOo4DOOcInjqAEw3Pd5ROvzhL8pNl8fpeW25IJePvVM7vluN3LRfpUKEXmU+tK6Md0kkysma93fYecffDITsTNc93ZMIklwyied/Awxad3bskHm+Iwx9U3zQMDI9WO7EnmZCZahduChusMsYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761103626; c=relaxed/simple;
	bh=uVCrcdW0Vwhx/jWjpre118EZ+pyKEVWB2uyNVjptnko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UujAocLn90brkEN9JV1R0+GV1o43zu2KI9qB/UJU6DXRXKcsiKmSuBTdKp8TAaisynf0KvpNsK0UNnk3K+uwx/Offjkz64tPsG0SrsQFAzq2rx59zpYVCz+zIUEn8tKuom5WDqmvcI1Y59obJSR1zYc3qkUO4cJcFZJqdey0w7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gGZPUQhJ; arc=none smtp.client-ip=156.224.81.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.30] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26bd00351;
	Wed, 22 Oct 2025 11:21:43 +0800 (GMT+08:00)
Message-ID: <5a551943-141a-4842-a4d0-b66b32cf3e70@rock-chips.com>
Date: Wed, 22 Oct 2025 11:21:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] dt-bindings: clock, reset: Add support for rv1126b
To: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com,
 sboyd@kernel.org, sugar.zhang@rock-chips.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
 finley.xiao@rock-chips.com, Conor Dooley <conor.dooley@microchip.com>
References: <20251021065232.2201500-1-zhangqing@rock-chips.com>
 <20251021065232.2201500-3-zhangqing@rock-chips.com> <4463339.ejJDZkT8p0@phil>
From: zhangqing <zhangqing@rock-chips.com>
In-Reply-To: <4463339.ejJDZkT8p0@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a09efd41b03a3kunm7b6dc5c66e4f96
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU8aGVYYTUsfQh5KGhlMSx5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gGZPUQhJfHp4kvwOmpCT54yGpj+RvSNLLBZIvOwIq0JBMw+xfp4HUlM8CNWg2uS8J0FfRU9ovd2A3Ud1RGfHpJdw8CLVA/V/IZsTsItStaptUzEUDq3l2qRAuB4K9YLoMF5CoDJNFsG3cxVe6mb7EFKyp0QW2y6uMenc9a/zhaM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=ipg6mZebV/FQJ02tqFTMP9sueHte0K5Fd4JfkmgRrwU=;
	h=date:mime-version:subject:message-id:from;

Hi, Heiko:

在 2025/10/21 16:38, Heiko Stuebner 写道:
> Hi Elaine,
>
> Am Dienstag, 21. Oktober 2025, 08:52:27 Mitteleuropäische Sommerzeit schrieb Elaine Zhang:
>> Add clock and reset ID defines for rv1126b.
>> Also add documentation for the rv1126b CRU core.
>>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>   .../bindings/clock/rockchip,rv1126b-cru.yaml  |  52 +++
>>   .../dt-bindings/clock/rockchip,rv1126b-cru.h  | 392 +++++++++++++++++
>>   .../dt-bindings/reset/rockchip,rv1126b-cru.h  | 405 ++++++++++++++++++
>>   3 files changed, 849 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
>>   create mode 100644 include/dt-bindings/clock/rockchip,rv1126b-cru.h
>>   create mode 100644 include/dt-bindings/reset/rockchip,rv1126b-cru.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
>> new file mode 100644
>> index 000000000000..04b0a5c51e4e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/rockchip,rv1126b-cru.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip RV1126B Clock and Reset Unit
>> +
>> +maintainers:
>> +  - Elaine Zhang <zhangqing@rock-chips.com>
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +
>> +description:
>> +  The rv1126b clock controller generates the clock and also implements a
>> +  reset controller for SoC peripherals.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - rockchip,rv1126b-cru
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +  "#reset-cells":
>> +    const: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: xin24m
> I think we're missing the optional
>
>     rockchip,grf:
>       $ref: /schemas/types.yaml#/definitions/phandle
>       description:
>         Phandle to the syscon managing the "general register files" (GRF),
>         if missing pll rates are not changeable, due to the missing pll
>         lock status.
>
>
> because RV1126B_GRF_SOC_STATUS0 contains the PLL lock status.
The pll lock truly uses bit10 of the PLL_CON1 register of CRU and does 
not use grf. Does that mean there is no need to increase rockchip,grf？
>
>
> Heiko
>
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


