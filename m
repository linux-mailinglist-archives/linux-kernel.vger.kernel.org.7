Return-Path: <linux-kernel+bounces-831964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361ABB9E06C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575171BC08EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1E0271475;
	Thu, 25 Sep 2025 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS89TZM/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D4270EBB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788601; cv=none; b=O0URNczqhzoEl+LS+aTs80PcbCrmiaDBjV2iMuijd2evrEp/DRYhIHND0XOqU6/r7e0qSLhYKXTbbQOGruKeZc6sXAvZ3/Qgxe6zwrMv8xAqkfGMz9K2s53Wx1saNZUeAGneWs5eEvXc5mn0Y0iBGJJqENQaCdhkZR/RGJwk7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788601; c=relaxed/simple;
	bh=+i+v8nBQDmYxiOI9yfBbFobo4pYvLGhUh6yGl4OVrWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjvBQ3CX0GK3BNXxS7h3/Tqf2C8p3wKFAoEej65EWs14IZ1dhZlGY3KpIOqNeH1cgY0+kbC+NByvaIJS09oAOwge4NpJB1lRuC/6fF56qwBb6vziCPzXooi2ED/C9J/Um7RmWuh0brwvQEBaFB6MZsLdvmT0xeCfbrNE4m+P/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS89TZM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BA2C4AF09
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758788600;
	bh=+i+v8nBQDmYxiOI9yfBbFobo4pYvLGhUh6yGl4OVrWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bS89TZM/rYSbBJsihrOABaC7Ws4Dymxusk/RzKQtPsLbWYPFsFJbkkJI3jiH7t3MK
	 Bo/UM4sqcFayuDivgoTPN/QwOf5CCVLU23Hpvpsm1GR5eKb4gFAcNmciRfwKlRKqKh
	 Kz3gWT8Mg8fhm1b0Hs0K4acyGg1PKuQG+q72utXuxj62CylhfFdXUhYbuwv5zQrPyI
	 zPD7uHv7DWiYX10BjjJlluVfb4wddalIe3SBFLioAFf7sywQE+1OeY1vyPJBTIVLJF
	 iMANQGs1qECMgD/nxwJ+t6dPAn8Yh7jVbgNUqPb41+8k4tTfiqc1TYfivoZXChHeaX
	 kInqNdAjFGQEQ==
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b57bf560703so546807a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:23:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7N7O/d8gkK5Lgb+porGUlJj5IZHva6Wy9luDKcLCsydHtu3DtFvZJqsnlvER5KEFZ36xavEWgq4fAfbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2qWneVzoDZ2wbxc9WwPRGyOoPF8+X8HtCbkZOAC6ZrOAf5oA
	RBUGL+U2J9cFUMQJ/9HmBk3l7RkzA492L8PlDk++dhNAc+LYh070RtuenAK5SsNizKhOnFJRKoM
	7p/J1oMTZHh5+mT2kDuEN30RVmxf9XQo=
X-Google-Smtp-Source: AGHT+IHqRi9cxDcwv+8J0r++fES1iGaPLBL7PoV33Z33j0uZ50sYjFgBKelHRg+TSQvlkBiAkVzvHoNNWXSHTJKAekc=
X-Received: by 2002:a17:902:c94c:b0:269:8d1b:40c3 with SMTP id
 d9443c01a7336-27ed4a29ceamr31919655ad.12.1758788600013; Thu, 25 Sep 2025
 01:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-6-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-6-24b601bbecc0@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 25 Sep 2025 17:23:07 +0900
X-Gmail-Original-Message-ID: <CAJKOXPc8NYrwSLbaFZ_tRVpgkYPUYhaMde77p1VBhqm9PLsGjA@mail.gmail.com>
X-Gm-Features: AS18NWDOUgrqzLHcPEb42eVV56-kTL6L0tFBxQFD6o5ZtdLGSHVdoF-yjnHTMgc
Message-ID: <CAJKOXPc8NYrwSLbaFZ_tRVpgkYPUYhaMde77p1VBhqm9PLsGjA@mail.gmail.com>
Subject: Re: [PATCH 06/24] arm64: dts: qcom: glymur: Enable pdp0 mailbox
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 15:33, Pankaj Patil
<pankaj.patil@oss.qualcomm.com> wrote:
>
> From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>
> Enable pdp0 mailbox node on Glymur SoCs.
>
> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index 66a548400c720474cde8a8b82ee686be507a795f..ae013c64e096b7c90c0aa4cfc50f078a85518acb 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -4065,6 +4065,14 @@ watchdog@17600000 {
>                         interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
>                 };
>
> +               pdp0_mbox: mailbox@17610000 {
> +                       compatible = "qcom,glymur-cpucp-mbox", "qcom,x1e80100-cpucp-mbox";
> +                       reg = <0 0x17610000 0 0x8000>, <0 0x19980000 0 0x8000>;
> +                       interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +                       #mbox-cells = <1>;
> +                       qcom,rx-chans = <0x7>;
> +               };

Again one node per patch. this is really pointless, please read
submitting patches before posting.

New Soc is one logical change. One.

