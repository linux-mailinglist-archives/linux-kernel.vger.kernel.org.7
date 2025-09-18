Return-Path: <linux-kernel+bounces-791276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C40B3B47A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA8117CC14
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3061A274643;
	Fri, 29 Aug 2025 07:37:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDF8230BCC;
	Fri, 29 Aug 2025 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453025; cv=none; b=ke3hU56AeW+EZgXyac2UPv6LTR2xpZ56kFoUYrVC83d1vH73yHhR2ZEk1QJYHflmHrBIUJJTHQXKRkevbDwQ/wWTfKJU8lrQLA0f9ddVM83wCtRBC2bermaBBFw1/PSTTipfEKyd7GoSl50w7u1EjIp9ObZljn81/dazSKhmy9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453025; c=relaxed/simple;
	bh=ZrN5CZvecZj1cjTUBvsaaMMdCcXWcBcb2kUm0ns+0kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opCA2io5BC94Vhwa9OOGg8vgpdYDSnaJn81WvpZynaozdkpWUmMHLQVjlvYy2JymD5cxcV8xUaeBo6Gwqiq+mxgBhc5dcYsW+svc4itsu5+k/A5JxqTH5eEky5RjmYlxq4oHGDt/zkUjRmz2wb9eO2GpJhiUqQej90NysmSuGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F34FC4CEF0;
	Fri, 29 Aug 2025 07:37:04 +0000 (UTC)
Date: Fri, 29 Aug 2025 09:37:02 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Varadarajan Narayanan <quic_varada@quicinc.com>, Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Anusha Rao <quic_anusha@quicinc.com>, Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, 
	Devi Priya <quic_devipriy@quicinc.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Richard Cochran <richardcochran@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com, quic_leiwei@quicinc.com, 
	quic_pavir@quicinc.com, quic_suruchia@quicinc.com
Subject: Re: [PATCH v4 06/10] dt-bindings: clock: Add required
 "interconnect-cells" property
Message-ID: <20250829-ubiquitous-imaginary-mammoth-d52bde@kuoka>
References: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
 <20250828-qcom_ipq5424_nsscc-v4-6-cb913b205bcb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828-qcom_ipq5424_nsscc-v4-6-cb913b205bcb@quicinc.com>

On Thu, Aug 28, 2025 at 06:32:19PM +0800, Luo Jie wrote:
> ICC clocks are always provided by the NSS clock controller of IPQ9574,
> so add interconnect-cells as required DT property.

Does not make sense. If clocks are always, you require different
property?

> 
> Fixes: 28300ecedce4 ("dt-bindings: clock: Add ipq9574 NSSCC clock and reset definitions")
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>

Fixes cannot be in the middle of patchset.

See submitting patches and your internal guideline explaining it with
great details.

> ---
>  Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> index 17252b6ea3be..fc604279114f 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> @@ -57,6 +57,7 @@ required:
>    - compatible
>    - clocks
>    - clock-names
> +  - '#interconnect-cells'

ABI break without explanation.

Best regards,
Krzysztof


