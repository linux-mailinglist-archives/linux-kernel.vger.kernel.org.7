Return-Path: <linux-kernel+bounces-779992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDF7B2FC13
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E007AA5A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF3A23D7F3;
	Thu, 21 Aug 2025 14:08:49 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780623D7D4;
	Thu, 21 Aug 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785329; cv=none; b=DcEdIArJ+o971eNlvIxKK9H7x5M5CR1PFBivw50Whw30kTXp1C9Dq1k1l28w+ihaZWUef7EUL6XdlucNqJ/8D+7yzUl3aGkcYBi8YH1dw1CP3jjn/tGfNs1XWfBeSwGS/lw5fevi+I5hy1EwEm+sGKaMPEPLDfP081L76iOmKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785329; c=relaxed/simple;
	bh=c3Po+GrocO8GJJuaoQl2k9EyZndU/YgvtVya44+YOCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUxs+u75FfwPu1PcYZUA+usTRS0gSyy/MWDo8eIQRh/cT3X0mh7KU1dqMzzXinlYFjtj7zvnEQtrPtZA/uv9px5KenSbLk93SyISYF9YWUyDi4jJhTAsDGodoyPIB2pBe/OXkDqjDM0P/USAOJPC9BDRfJeX0+AeqKYQnkwCJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.106] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowADXA6hfKKdoj+MRDg--.46265S2;
	Thu, 21 Aug 2025 22:08:31 +0800 (CST)
Message-ID: <c1396997-fa92-47cd-9bc6-8dcb67e87eb8@iscas.ac.cn>
Date: Thu, 21 Aug 2025 22:08:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
To: Hal Feng <hal.feng@starfivetech.com>, Conor Dooley <conor+dt@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250821100930.71404-1-hal.feng@starfivetech.com>
 <20250821100930.71404-4-hal.feng@starfivetech.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250821100930.71404-4-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowADXA6hfKKdoj+MRDg--.46265S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr1UKF4fXrWxZr4rWFyxuFg_yoWDWwc_Ga
	4kKw1fGF4UJF1kK3s8Grn7CF1FyayavrnxA3yFvr47JF9Yg34Yy3ZrG3y0kF1UAF1jgFs8
	GFn3WF4qkr4kKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxU2X_-DUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 8/21/25 18:09, Hal Feng wrote:
> [...]
> +++ b/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2025 StarFive Technology Co., Ltd.
> + * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-common.dtsi"
> +
> +/ {
> +	model = "StarFive VisionFive 2 Lite";
> +	compatible = "starfive,visionfive-2-lite", "starfive,jh7110s";
> +};

Might need to add starfive,jh7110s to:

  drivers/cpufreq/cpufreq-dt-platdev.c

So that it can use the opp stuff here:

> +
> +&cpu_opp {
> +	opp-312500000 {
> +		opp-hz = /bits/ 64 <312500000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-417000000 {
> +		opp-hz = /bits/ 64 <417000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-625000000 {
> +		opp-hz = /bits/ 64 <625000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-1250000000 {
> +		opp-hz = /bits/ 64 <1250000000>;
> +		opp-microvolt = <1000000>;
> +	};
> +};
> +> [...]


