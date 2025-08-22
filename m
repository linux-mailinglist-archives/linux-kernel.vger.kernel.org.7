Return-Path: <linux-kernel+bounces-781889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9581FB3184A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C89EAE02CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB762FD1CA;
	Fri, 22 Aug 2025 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4t5an2Iv"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42CF2F6196;
	Fri, 22 Aug 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866924; cv=none; b=OAnTgU+0lBcjjt9ubNtjRldyjqn9pGSYmjNCWBDNwIl+uRX/AOz+Vs6/rYuSXi08HY/10a4DQFBJ1mPXf90TPu3w9T8FxGDJWsC4GY9JQYArXfmXnsuxl39IenZspW6Vi40MEBOga1ByU7rt4dHsgwnDx7abtIy5keHjYGZG+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866924; c=relaxed/simple;
	bh=3xhnfcc/k5yv3VnUt/EjE5Lj7F1moiQvxJV3agD7uEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tc/OxhTEuQWYyTv50pJawihs0Bx/fHpRsVf+KEQZtjUNPrAThON6iwO9XgM3hPffvK0uPmWVFOhRnLV6Sb8MxOCcck3F5MGzPLflEbBpOdkADVS2+kvBnQs/8ZNih1JKVOzI7b2kHgc29/L5kGH9ij/WPZSlNkCiIXFDXoMzWKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4t5an2Iv; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCgmp0005067;
	Fri, 22 Aug 2025 14:48:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	TGbeZuqspzRioDGrdvKPMUoTcNPF7/XnoWtRoGzbxwQ=; b=4t5an2Ivhpfv44vd
	pS602YSZFg2zu/Ma53LpeLjt9uVgcrxM/zA9mrYjWj9md+D50UqoNLMtyrHBVThD
	ns2T8NhfiIJCji7gnXToOWLv4qUmlUMqBllMGf2MY9BnjwOeLh5CgH3UMjdRkuSU
	jvmo7fQ6ukEBWck3EDHSq1y5zZYveTyPQ86nsPnvY6gLUxRFeauBIYCOfihhJfWL
	dIjBrHGib5QXRPnevSicyqCidUtqNAxfN8vlggmd/fbqe6Oav96TABlTaKr2kWQe
	T4UFAa1zB6vmq3QL4LBz0qeJFizbY7ncMbp7ZnZMtDWG0iSXjT0bdR6/cRbgG4El
	snQJ0g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48nd5xs6qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:48:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7D0E540048;
	Fri, 22 Aug 2025 14:47:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8279A71DB2B;
	Fri, 22 Aug 2025 14:46:17 +0200 (CEST)
Received: from [10.48.87.178] (10.48.87.178) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 14:46:16 +0200
Message-ID: <13ae9184-e835-476c-a96c-df8cd94c6e4b@foss.st.com>
Date: Fri, 22 Aug 2025 14:46:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/13] dt-bindings: display: st,stm32mp25-lvds: add
 access-controllers property
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250821-drm-misc-next-v4-0-7060500f8fd3@foss.st.com>
 <20250821-drm-misc-next-v4-4-7060500f8fd3@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250821-drm-misc-next-v4-4-7060500f8fd3@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01

Hi Raphael,

Thanks for the patch.

Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>

Le 21/08/2025 à 13:08, Raphael Gallais-Pou a écrit :
> access-controllers is an optional property that allows a peripheral to
> refer to one or more domain access controller(s).
>
> This property is added when the peripheral is under the STM32 firewall
> controller.  It allows an accurate representation of the hardware, where
> the peripheral is connected to a firewall bus.  The firewall can then
> check the peripheral accesses before allowing its device to probe.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
> index 74e61d95370c299130410cdaae833514324c3e8f..05a73bbc246a8994b6aabf7c2cd9dca773232be4 100644
> --- a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
> +++ b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
> @@ -59,6 +59,9 @@ properties:
>     resets:
>       maxItems: 1
>   
> +  access-controllers:
> +    maxItems: 1
> +
>     ports:
>       $ref: /schemas/graph.yaml#/properties/ports
>   
>

