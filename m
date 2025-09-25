Return-Path: <linux-kernel+bounces-831933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4238B9DEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 914F37ABED3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F2F2D73B6;
	Thu, 25 Sep 2025 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuwG7TZt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BA52652AF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786966; cv=none; b=lpCFtQRd3XoxJOXvwWCHonSzzXN2EcIqnd4cwfpA1BT4G/GHcFVMJWRuc4hT2amDPkrRW/iLX4EOi7C1Rztp4obv/ODFJYBqBqG30xH9lsCxFClWmV+T/v6vQGXhyY1D/4VJVS1tYPNMSncfqFsMqjDFx7FAFJ8o9M13SyhVGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786966; c=relaxed/simple;
	bh=iNOrlSv+UnH9YXYGgLh4d5QBAGujb/M/E8kWZNFFdKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZ1bBrp88Oxvq3tVTa/OSmdw6bcwWOJ8XbUG+gbOSmmSv+atIRxd9hUeGM0l4fUxXftI/0IIcxVPV4hOaSQVdEIp33OmQC4H35eWRpblhiYGnIDUR8eQqfeIEdUIlfZq0nEgHU/cIYxEB6mGMfrd8Scq4nA5ltqG0HKwCyN8G+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuwG7TZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08348C19421
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758786966;
	bh=iNOrlSv+UnH9YXYGgLh4d5QBAGujb/M/E8kWZNFFdKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TuwG7TZtZyhUdJWz7gyJ+1ze0T9iGppwI7ERgAxVpl6yLlnuQ7tiMNfXQLiOXdTq8
	 e+RTNIgyC5wC7xnhIIGbZcFFyHDT1qEOFtnFNVXV9OBimONwiRJfVUYxr0mfS+0egS
	 qPr/LwJw1ykVN0Lq8Tasr2rg30jxbjgQnE9+aRud7C2VZFxeBsOlBuW2PrnDFecm3J
	 mHd+3vcG3qtKHqSFs6N7efrBWKp6htN4nD8kVp7GUCj5g6WwFFYA+moa/3KfI1tmyV
	 TjoCNDLmFHyIX4wM9N7d4Y2fXC9jpaz/OPCsfq+vOJ6hcOXmqF9QJP2XuniChXRbEb
	 Mkvtqh5TzBjiA==
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-244580523a0so7837985ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:56:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcxVNzHN5DMZFSGZ7Tp2pU21bAjvNoEp0vKY/nufgNk3s4qTKc3GUUjSVODKZ6JVe9LtowsnnVIFPEJhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVFiTvKmjZn/re3WkParFYM5aVQ055jPPRzcBd1G8iwIzpG/2V
	a6+hS6JF9afdZ3jF5SS9+w8mGvfSjRoN0+tMJ4Xn7i/7GGdSIGWg1WLk6XwTYJFwFCcTMZ0cJ0G
	7gxcQ+Yh3BW+vF9mGt56zr6QtdQ6nUuI=
X-Google-Smtp-Source: AGHT+IGwiFpqHmhXAhBBFAso/lUytZrxuoUy4+24dMkBcof4Rt456e4kjJjM/KaUSq35uvSNF6sG9ZpMzxNTEoW2FNA=
X-Received: by 2002:a17:903:32c3:b0:267:e3af:ae67 with SMTP id
 d9443c01a7336-27ed49d2f64mr28324145ad.14.1758786965578; Thu, 25 Sep 2025
 00:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v2-13-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-13-8e1533a58d2d@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 25 Sep 2025 16:55:53 +0900
X-Gmail-Original-Message-ID: <CAJKOXPfCFS4UDbN_SejG=zJt1Dt_mtz_p_+MGAaEr5SpK3ydRw@mail.gmail.com>
X-Gm-Features: AS18NWDm7SJn3zsL3AKVzt-6BJJFQvrAi-FrGgXNCkiSPvbpCGZr-N3-JKzjofA
Message-ID: <CAJKOXPfCFS4UDbN_SejG=zJt1Dt_mtz_p_+MGAaEr5SpK3ydRw@mail.gmail.com>
Subject: Re: [PATCH v2 13/24] arm64: dts: qcom: Update pmh0104 dtsi for Glymur CRD
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 15:29, Pankaj Patil
<pankaj.patil@oss.qualcomm.com> wrote:
>
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>
> Update the pmh0104.dtsi to include multiple instances of PMH0104
> DT nodes, one for each SID assigned to this PMIC on the spmi_bus0
> and spmi_bus1 in Glymur CRD board.
>
> Take care to avoid compilation issue with the existing nodes by
> gaurding each PMH0104 nodes with `#ifdef` for its corresponding
> SID macro. So that only the nodes which have the their SID macro
> defined are the only ones picked for compilation.
>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/pmh0104.dtsi | 84 +++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/pmh0104.dtsi b/arch/arm64/boot/dts/qcom/pmh0104.dtsi
> index f5393fdebe957ea0caf4bbc16117374b4759bda3..d3ea7486d842ec813a79268fc1466e1513426d78 100644
> --- a/arch/arm64/boot/dts/qcom/pmh0104.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmh0104.dtsi
> @@ -6,7 +6,63 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
>
> +&spmi_bus0 {
> +#ifdef PMH0104_I_E0_SID


NAK

I'm surprised you decided to ignore all existing discussions and my
clear point in this.

This is neither readable, nor maintainable.

Please join community in discussing this, instead of coming with
another invention which I already said is poor.

Best regards,
Krzysztof

