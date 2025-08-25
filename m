Return-Path: <linux-kernel+bounces-783997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE2BB3352B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A8F17BDA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467D427B51C;
	Mon, 25 Aug 2025 04:36:42 +0000 (UTC)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414882701B4;
	Mon, 25 Aug 2025 04:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096601; cv=none; b=mgt3MjZFlvi1RikMzl2DpQ6+hcNHB+D/VvkVX2bAHMar7ZQe9aGzLPyGCsWFN4mFwz8k6rvAtvQJH6StyF7IO8Xzvzuakb9uWvknBq6LXLj0KwQHh5sF94cEWWutss5FtYu6/fR0VGyXPaNTSf+oQxxONdyspB2jYbbdAyKw2Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096601; c=relaxed/simple;
	bh=2UQdjiqd7O8IFLfGKPYuGC0jAgyCtp0zgSm8CQIH+Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=XOqHb27MH5meVW9CA0IzvxNhMHITIUOJArq897n/ehFVVMb7M0loUPf88MYle8gTcYgIFgOTPTNZq7ynDzYjFe6YOPJ2wBg15WJwPiS3nEVa3o4kygulgvb3OT3hj9kmB6titjzZe5W4EqsououzG7IwkjZqaPFbEEdImw0RrT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Aug 2025 13:36:29 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id 5C1832091489;
	Mon, 25 Aug 2025 13:36:29 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Mon, 25 Aug 2025 13:36:29 +0900
Received: from [10.213.136.107] (unknown [10.213.136.107])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id EF23410A016;
	Mon, 25 Aug 2025 13:36:28 +0900 (JST)
Message-ID: <cb453b09-4aa0-45f4-8cf6-abcf5c625007@socionext.com>
Date: Mon, 25 Aug 2025 13:36:28 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: socionext: uniphier-ld20: Add default PCI
 interrup controller address cells
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250822133318.312232-3-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250822133318.312232-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 2025/08/22 22:33, Krzysztof Kozlowski wrote:
> Add missing address-cells 0 to the PCI interrupt node to silence W=1
> warning:
> 
>    uniphier-ld20.dtsi:941.4-944.29: Warning (interrupt_map):
> /soc@0/pcie@66000000:interrupt-map:
>      Missing property '#address-cells' in node
> /soc@0/pcie@66000000/legacy-interrupt-controller, using 0 as fallback
> 
> Value '0' is correct because:
> 1. GIC interrupt controller does not have children,
> 2. interrupt-map property (in PCI node) consists of five components and
>     the fourth component "parent unit address", which size is defined by
>     '#address-cells' of the node pointed to by the interrupt-parent
>     component, is not used (=0)

I understand that "parent unit address" is omitted, and according to
the devicetree specification, "#address-cells" define the the size of
the address. However, GIC doesn't specify the address, so this line
is needed to indicate it.

For both patches,
Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

There is no tree to manage the SoC-specified commits, so please apply
this series into the DT tree.

Thank you,

---
Best Regards
Kunihiko Hayashi

