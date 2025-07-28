Return-Path: <linux-kernel+bounces-747739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B81B1377E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17D67A51FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCA7236A88;
	Mon, 28 Jul 2025 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Cz9thDgR"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433BC2367D4;
	Mon, 28 Jul 2025 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694882; cv=none; b=irKQcvKcsmRPp2qK1UuudNshsNcxa2WN82JoOFXgzvW1uqia47R1Ggu7zyShD4p+XmLYw+hGXbEEhq0Om6hAOZF14KpBW8PPAg/Zco5BFB4Kro6JMmh4SVlN8UwF3t+3QWodyEiO2P+bB/RUrin+ZAX+sFwNG2Juao0RQhzDJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694882; c=relaxed/simple;
	bh=Ebq1BvzYefK2bJIq0l36kLRfYmXoclAETpF4p0VJMSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VNE5c8vsl+pOiVnfgsDDjOQ+oZhXaDbinNYCXWoXzGT7P2/pOiS5eAfy8zWWrGYsqHnhVkg8Nubvvyv/FM5nrJ4Sly1LiqwS41c8TP04ovYjEIP5gxGxtGPnptTowCTZ+P++4YxQp+3TiN6Tw5otrFNVGYoKKlYQJwHm/KWzCw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Cz9thDgR; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S5AQBU005322;
	Mon, 28 Jul 2025 11:27:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	tKkzym8iL3hbITcicEqfEneityvCYZo4YSktLirvyx4=; b=Cz9thDgRAVogk5sj
	Ry6zrR/xEwoonnK8i5QMYJoMsLjKDOgzYPgfW/b755DX+Dxm7KHNXn5xgJ9EXSuV
	PLhEdScHf/zZcx+QxFtQbfBwVOT5ZMXey2/1jtvshN41d8M3C3xwCq9SjZMvpZn7
	dGlVyecB8tfw8/UMjzHeNvSVEkp5KBa2MkG1Un+P8zpZvhRjP696uDJWGbCKah+E
	HlJGCJkpHYW6mYplJ4Pxw27aHa6rDphkt2OB0PjBvZnIe5A3P5S9n7lcU+cjVPZO
	+qM5NxQMHWb1rL0OB2F7kGlF+rl58j1jvzqopRfWRhqOwXRs87MQQ5nnS4MsuEs6
	pghrkg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484m58y971-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 11:27:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C73E24004F;
	Mon, 28 Jul 2025 11:26:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 426066F3FF7;
	Mon, 28 Jul 2025 11:26:13 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 11:26:12 +0200
Message-ID: <517de150-9fb1-4098-92a3-d5a24eea67a1@foss.st.com>
Date: Mon, 28 Jul 2025 11:26:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: sti: drop B2120 board support
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
References: <20250714-sti-rework-v2-0-f4274920858b@gmail.com>
 <20250714-sti-rework-v2-3-f4274920858b@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250714-sti-rework-v2-3-f4274920858b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01



On 7/14/25 15:49, Raphael Gallais-Pou wrote:
> B2120 boards are internal boards which never were commercialised.
> 
> Remove them from bindings.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> 
> ---
> Changes in v2:
> - Added Krzysztof's acked-by
> - Put this patch last to get a bisectable series
> ---
>  Documentation/devicetree/bindings/arm/sti.yaml | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sti.yaml b/Documentation/devicetree/bindings/arm/sti.yaml
> index 842def3e3f2bce470763d3665c7603b9058b1e4e..177358895fe1c9f80f8c825142cf015d04286ce8 100644
> --- a/Documentation/devicetree/bindings/arm/sti.yaml
> +++ b/Documentation/devicetree/bindings/arm/sti.yaml
> @@ -14,12 +14,8 @@ properties:
>      const: '/'
>    compatible:
>      oneOf:
> -      - items:
> -          - const: st,stih407-b2120
> -          - const: st,stih407
>        - items:
>            - enum:
> -              - st,stih410-b2120
>                - st,stih410-b2260
>            - const: st,stih410
>        - items:
> 


Hi Raphael

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks

