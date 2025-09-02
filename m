Return-Path: <linux-kernel+bounces-796716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C7DB40648
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107C21689D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495E62DFF1D;
	Tue,  2 Sep 2025 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wDvUDvro"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA71220F5E;
	Tue,  2 Sep 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822107; cv=none; b=lyxUTKRxwZb6OpH/w8NnIQgQXWdelnLJxX9MVfxCebeMky39pII7LP7958SsOIaX/q+TwB7GWZasBs7A/KMHQk+nU/5Hmz8JGMSOIVyJALWP2OAetX8l2aSFLzJ6Aob2MqdPZZsr+qNWQIZ1fv2hGTixeqrZmia+8NpoG8I+nYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822107; c=relaxed/simple;
	bh=keU71mt+mL8ZC7oI2ryZm1aP/UrhHjOrirqvvxCZCIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NRjzgXAnXIQhzUM5fQudUZ/FdiS6at8yMku+NY6vUubWX2tN060RUP9ftbPCQ9sy7IExjCkGztccfpuyQD6+K41eVN0yq8egnhz1WmN0zFusaL1WkRx1dNmxDhry1A64Yyo+RHqxDWSDnRc4vfPh/QM2or0+W2jKuQyH0UUe59A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wDvUDvro; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582DHPqh021113;
	Tue, 2 Sep 2025 16:08:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	OfsW8QTgbTdLP4DbkI1LhSpqxaBZQsvlgtJGzho+GHo=; b=wDvUDvro07WcbWVI
	GSKHtFjhToKdMWBImiAgJUCkfdPfgWtxbpKjPNuX8DWIBmAN0BqyUzLhxbb1/lhh
	Y4POLhNDo+hf7jd2oGzi49bG4xkpqsZ2Iqy4+SSO1QlqPxSEMN6eNS318/v/GRVQ
	5jzEQ1qwlkGhtYBft9mIA38QWR92RV7RfO2ew1QvWyPQfwG2lu8CpeR6MggbfdJ6
	ow2HFWqpIAl+bwqv/LuFM66Xs1JW+1JNbh0vofvuGJYoDKJIt3hMNSbuOjInBGwr
	fyyszoeqUbuSPQThgjbZkTjKG+qUR1dO8B0P3uQqxFElWtWgtZlftU0eCRQScSrT
	kErQSw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48upqkd2tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 16:08:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6DF0B40045;
	Tue,  2 Sep 2025 16:06:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0D83C3A874D;
	Tue,  2 Sep 2025 16:05:23 +0200 (CEST)
Received: from [10.48.87.121] (10.48.87.121) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 2 Sep
 2025 16:05:22 +0200
Message-ID: <9b669562-ee52-47b6-856e-3184b3e89d28@foss.st.com>
Date: Tue, 2 Sep 2025 16:05:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] clk: divider, gate: create regmap-backed copies of
 gate and divider clocks
To: Conor Dooley <conor@kernel.org>, <sboyd@kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara
	<daire.mcnamara@microchip.com>,
        <pierre-henry.moussay@microchip.com>,
        <valentina.fernandezalanis@microchip.com>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones
	<lee@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt
	<palmer@dabbelt.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-riscv@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250901-rigid-sacrifice-0039c6e6234e@spud>
 <20250901-yearling-reconcile-99d06fe7868e@spud>
Content-Language: en-US
From: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <20250901-yearling-reconcile-99d06fe7868e@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01


On 9/1/25 13:04, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Implement regmap-backed copies of gate and divider clocks by replacing
> the iomem pointer to the clock registers with a regmap and offset
> within.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v4:
> - increase map_offset to a u32
> - use a single Kconfig option for both divider and gate regmap
>    implementations
> ---
>   drivers/clk/Kconfig              |   4 +
>   drivers/clk/Makefile             |   2 +
>   drivers/clk/clk-divider-regmap.c | 271 +++++++++++++++++++++++++++++++
>   drivers/clk/clk-gate-regmap.c    | 254 +++++++++++++++++++++++++++++
>   include/linux/clk-provider.h     | 119 ++++++++++++++
>   5 files changed, 650 insertions(+)
>   create mode 100644 drivers/clk/clk-divider-regmap.c
>   create mode 100644 drivers/clk/clk-gate-regmap.c
>
Hi Conor,

i tested the clk_gate_remap part with my code, it works fine.

Just a  minor remark concerning .round_rate, you can add my

Reviewed-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

> +const struct clk_ops clk_divider_regmap_ops = {
> +	.recalc_rate = clk_divider_regmap_recalc_rate,
> +	.round_rate = clk_divider_regmap_round_rate,

.round_rate could be removed ?


> +	.determine_rate = clk_divider_regmap_determine_rate,
> +	.set_rate = clk_divider_regmap_set_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_divider_regmap_ops);
> +
> +const struct clk_ops clk_divider_regmap_ro_ops = {
> +	.recalc_rate = clk_divider_regmap_recalc_rate,
> +	.round_rate = clk_divider_regmap_round_rate,

dito


> +	.determine_rate = clk_divider_regmap_determine_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_divider_regmap_ro_ops);
> +


