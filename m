Return-Path: <linux-kernel+bounces-802128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFFFB44DE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CB41BC7803
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583E928D836;
	Fri,  5 Sep 2025 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gvGkw8UR"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E8289376;
	Fri,  5 Sep 2025 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053327; cv=none; b=Nzts8Okhtb/oIaHoXILs7nnKJLVAsiiE8KPvEv4AtoNYJf7IYcjTCLr+SfdlDfI3FCKAo+3UsQE+cAX/dVxIW6K4al78AFh6jIktzyqm1IHscnodnvexfFx61awimbtuOE1bPFLlWW3oEPTQ99Qh5r0yEIXu8+0+1+PORYyMeIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053327; c=relaxed/simple;
	bh=lCr6UhaaYUPZuytknqPGcqc+1wH9ae3le6oLjsdmwwg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvUe1Rm03vsQZf9L2ITPnNS4B1tYJr4gvbDI5fsVqkEQymoJfu/+5OXVTL4+eYQu6906DX810x1ILq6fIfKcXg5g64m7yK1YBTJ+3jFJ3wGILEd4j7LLi//YqW8XkqV6YYiGngUcagv57xAj9dsiyMY4/xNPY07FqiO8zb1J/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gvGkw8UR; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5856LxN33648440;
	Fri, 5 Sep 2025 01:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757053320;
	bh=MZ0Ulce0kaM8VNdePBdckrICFLg2CqjgRYS+JAgj81c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=gvGkw8UR3+5qalvJHjmNi/k3xYSo1sfPmw6LcNjQQIGHB0aExCvNiprbnpsQWzMEt
	 G6gi4JbLemQVc1RHX5VGCbtF5frreJj6WOaAX9h8X8C330GH8HgKEXKn/Ml1JP/ix1
	 4ijgIAVMetSiGKHFfc3jp1VJFQ14ebMRpzaft4Z8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5856Lx721436980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 01:21:59 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 01:21:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 01:21:59 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5856Lwx3302558;
	Fri, 5 Sep 2025 01:21:58 -0500
Date: Fri, 5 Sep 2025 11:51:57 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Akashdeep Kaur <a-kaur@ti.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>, <sebin.francis@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vishalm@ti.com>
Subject: Re: [PATCH v5 4/4] arm64: dts: ti: k3-pinctrl: Fix the bug in
 existing macros
Message-ID: <20250905062157.s32xwnyfbphyupfa@lcpd911>
References: <20250905051448.2836237-1-a-kaur@ti.com>
 <20250905051448.2836237-5-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905051448.2836237-5-a-kaur@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 05, 2025 at 10:44:48 +0530, Akashdeep Kaur wrote:
> Currently, DS_IO_OVERRIDE_EN_SHIFT macro is not defined anywhere but
> used for defining other macro.
> Replace this undefined macro with valid macro. Rename the existing macro
> to reflect the actual behavior.
> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-pinctrl.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index 8ce37ace94c9..e46f7bf52701 100644
> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> @@ -88,8 +88,8 @@
>  
>  #define PIN_DS_FORCE_DISABLE		(0 << FORCE_DS_EN_SHIFT)
>  #define PIN_DS_FORCE_ENABLE		(1 << FORCE_DS_EN_SHIFT)
> -#define PIN_DS_IO_OVERRIDE_DISABLE	(0 << DS_IO_OVERRIDE_EN_SHIFT)
> -#define PIN_DS_IO_OVERRIDE_ENABLE	(1 << DS_IO_OVERRIDE_EN_SHIFT)
> +#define PIN_DS_ISO_OVERRIDE_DISABLE     (0 << ISO_OVERRIDE_EN_SHIFT)
> +#define PIN_DS_ISO_OVERRIDE_ENABLE      (1 << ISO_OVERRIDE_EN_SHIFT)

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

