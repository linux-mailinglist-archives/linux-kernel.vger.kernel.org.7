Return-Path: <linux-kernel+bounces-889653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5683EC3E263
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A23A3AE311
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344492F746F;
	Fri,  7 Nov 2025 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="i8obIctg"
Received: from mail-m15577.qiye.163.com (mail-m15577.qiye.163.com [101.71.155.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593ED2E5405;
	Fri,  7 Nov 2025 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762479628; cv=none; b=qxYszHy1xAAnXv8qlibzyHdI32hmKdkeOZbx6XzCo/TA62Jy7NnXn6FaKOY+Uw7Sl1vGdCB+ngHHg2sZ9WZsyzTVJzVGBwCGKEOrVbBRoH3lRKDSotSeYNh6KOnUbJXk1VwX2mw0Bo7AlcPt79JSLE8hQnJq4Wm4tKELf2cF4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762479628; c=relaxed/simple;
	bh=x3ee7MPdOGqj9S4iiDxNfC1Dqwh6Q/oHmHbk3UsgQw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBCnZ6v/zuBylIqa26VqbgiaQsUqPDrChfymZSKJCKRO8h+zoxKyQ5VlOBj+9vHuE2QWPQSgCmc2ny6Kh2UvxEHLjyUav/+i1R2RrpjawSElWvxxcbFg3OCqBF9EmFU3hM1Udgs2VaNbrhj+m3xsemRBS1/H+czWZf0IEjJj7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=i8obIctg; arc=none smtp.client-ip=101.71.155.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.30] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28b3fcd75;
	Fri, 7 Nov 2025 09:24:58 +0800 (GMT+08:00)
Message-ID: <f39d34b3-5e52-4490-99d8-db9b32f1324e@rock-chips.com>
Date: Fri, 7 Nov 2025 09:24:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] dt-bindings: clock: rockchip: Add RK3506 clock and
 reset unit
To: Jonas Karlman <jonas@kwiboo.se>
Cc: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com,
 heiko@sntech.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 huangtao@rock-chips.com, finley.xiao@rock-chips.com
References: <20251027084147.4148739-1-zhangqing@rock-chips.com>
 <20251027084147.4148739-7-zhangqing@rock-chips.com>
 <241e4a1d-039c-4738-b492-6325ad354b2e@kwiboo.se>
From: zhangqing <zhangqing@rock-chips.com>
In-Reply-To: <241e4a1d-039c-4738-b492-6325ad354b2e@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a5beaae2203a3kunm52616c82d042dd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpLQ1YZTklLHRoZQxkaGh5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=i8obIctgp8PJQDzcSsl2yOaii93gYF/sd2SGLm2fBTKLXepQGj96EsKc9vZxFSs2R+cxyt5utlBL9WeBLT1in7BIZuTmtHSxAf+c2xZvlw+12j4KNs7jUIjsb+/tjhs4OVWDczanwxQx8PLDqO+ovB6kzJPmSTiEtrw91bj+9Ps=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=JrcLPjYRMh28B+ghpJStH6nxi8FMijAngji3KjqZsv8=;
	h=date:mime-version:subject:message-id:from;


在 2025/10/30 21:55, Jonas Karlman 写道:
> Hi Elaine,
>
> On 10/27/2025 9:41 AM, Elaine Zhang wrote:
>> From: Finley Xiao <finley.xiao@rock-chips.com>
>>
>> Add device tree bindings for clock and reset unit on RK3506 SoC.
>> Add clock and reset IDs for RK3506 SoC.
>>
>> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
>> ---
>>   .../bindings/clock/rockchip,rk3506-cru.yaml   |  51 ++++
>>   .../dt-bindings/clock/rockchip,rk3506-cru.h   | 285 ++++++++++++++++++
>>   .../dt-bindings/reset/rockchip,rk3506-cru.h   | 211 +++++++++++++
>>   3 files changed, 547 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
>>   create mode 100644 include/dt-bindings/clock/rockchip,rk3506-cru.h
>>   create mode 100644 include/dt-bindings/reset/rockchip,rk3506-cru.h
> [snip]
>
>> diff --git a/include/dt-bindings/reset/rockchip,rk3506-cru.h b/include/dt-bindings/reset/rockchip,rk3506-cru.h
>> new file mode 100644
>> index 000000000000..f38cc066009b
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/rockchip,rk3506-cru.h
>> @@ -0,0 +1,211 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Copyright (c) 2023-2025 Rockchip Electronics Co., Ltd.
>> + * Author: Finley Xiao <finley.xiao@rock-chips.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_REST_ROCKCHIP_RK3506_H
>> +#define _DT_BINDINGS_REST_ROCKCHIP_RK3506_H
>> +
>> +/* CRU-->SOFTRST_CON00 */
>> +#define SRST_NCOREPORESET0_AC		0
>> +#define SRST_NCOREPORESET1_AC		1
>> +#define SRST_NCOREPORESET2_AC		2
>> +#define SRST_NCORESET0_AC		3
>> +#define SRST_NCORESET1_AC		4
>> +#define SRST_NCORESET2_AC		5
>> +#define SRST_NL2RESET_AC		6
>> +#define SRST_ARESETN_CORE_BIU_AC	7
>> +#define SRST_HRESETN_M0_AC		8
>> +
>> +/* CRU-->SOFTRST_CON02 */
>> +#define SRST_NDBGRESET			9
>> +#define SRST_PRESETN_CORE_BIU		10
>> +#define SRST_RESETN_PMU			11
>> +
>> +/* CRU-->SOFTRST_CON03 */
>> +#define SRST_PRESETN_DBG		12
>> +#define SRST_POTRESETN_DBG		13
>> +#define SRST_PRESETN_CORE_GRF		14
>> +#define SRST_RESETN_CORE_EMA_DETECT	15
>> +#define SRST_RESETN_REF_PVTPLL_CORE	16
>> +#define SRST_PRESETN_GPIO1		17
>> +#define SRST_DBRESETN_GPIO1		18
>> +
>> +/* CRU-->SOFTRST_CON04 */
>> +#define SRST_ARESETN_CORE_PERI_BIU	19
>> +#define SRST_ARESETN_DSMC		20
>> +#define SRST_PRESETN_DSMC		21
>> +#define SRST_RESETN_FLEXBUS		22
>> +#define SRST_ARESETN_FLEXBUS		23
>> +#define SRST_HRESETN_FLEXBUS		24
>> +#define SRST_ARESETN_DSMC_SLV		25
>> +#define SRST_HRESETN_DSMC_SLV		26
>> +#define SRST_RESETN_DSMC_SLV		27
>> +
>> +/* CRU-->SOFTRST_CON05 */
>> +#define SRST_ARESETN_BUS_BIU		28
>> +#define SRST_HRESETN_BUS_BIU		29
>> +#define SRST_PRESETN_BUS_BIU		30
>> +#define SRST_ARESETN_SYSRAM		31
>> +#define SRST_HRESETN_SYSRAM		32
>> +#define SRST_ARESETN_DMAC0		33
>> +#define SRST_ARESETN_DMAC1		34
>> +#define SRST_HRESETN_M0			35
>> +#define SRST_RESETN_M0_JTAG		36
>> +#define SRST_HRESETN_CRYPTO		37
> Is there a reason why this (and the RV1126B) reset names now include the
> RESETN name in all reset constant?
>
> For RK3528 and prior mainline SoCs the RESETN part of the name has been
> striped from the constant, suggest we also strip the RESETN part for
> RK3506 and RV1126B for consistency with other RK SoCs.

The current practice is to separate the reset id from the clk id.

Follow with others RK socs(RK3528、RK3588、RK3576.....)
>
> Regards,
> Jonas
>
> [snip]
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


