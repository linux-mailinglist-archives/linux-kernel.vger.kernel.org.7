Return-Path: <linux-kernel+bounces-864528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCFABFAFDC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC17D19C0774
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396E330B52E;
	Wed, 22 Oct 2025 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4vS6xCu"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA90309EFB
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123189; cv=none; b=MZeLDRMkg9ZwVBDTWJmcWWC2kmuPIgq8KyNKm4VZKlsTRZ3VwtELv2WUZr6eAJ43b28JIKFXQCCR+GbXtdCv4mkMkf8k5sZ8zVscm8f1Sxidnmq7AOy4wzoY+HvXAEcVMjnwuXBHCUInOYPmQ7rrQmFENtZz0axvf3xyH5OAcpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123189; c=relaxed/simple;
	bh=AlKCgkSnSSPFD9Skbx2D0rMe1wy7Q92Jl+BlrTjwwZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7tPbFS7iBm6wcx2dFwbZC6ahCclP7pKbsdvwtlUPvWZlO/oqbLYNkLCBX3TpWOfGbYFwfsZRg1N2bgI0wySPeTfwwjNVfgPS1qA7DPpJg2WSILYyusRP320Hn/Fuhpb6X2J1l/MC+9Ci7EbCelNrOjOIfOW8pzMh4WoEZG6mmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G4vS6xCu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-471131d6121so50022975e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761123185; x=1761727985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VMT8mKYgwMl8yULjLBpYiH70IVjoTMUBL7pjvnp2wU=;
        b=G4vS6xCumFze4PR247HPqJYnkGR9llZ6rtlALjCnSKX74MYDu2f4Ot6NQrJXdNlH/5
         sZ9c8lEqjTnBf0H0cooxsz/5q74PKFm+WolFbi8VmJOwz70X3h5bJ7w4088mK+gqX8HM
         ff3he7k/0PQcLGI1FU7ZJtqQaYqHHrp9YA2vWKC8WYAh9wXfqjLvvXnt1EWgGZFSavKF
         Kj34zx9lpF9r8pF/21lmKCU9J1KZqDy8uJ7A0+Qsj508CJLTkCUgQGc7B0Zk1HIZf+yv
         CfizMTFh/1py0kB4O6J3q30+LpjjbiYaMN9zQbIILr+K8pJqV7g/uMKycFjPcCKudplp
         Ixww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761123185; x=1761727985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VMT8mKYgwMl8yULjLBpYiH70IVjoTMUBL7pjvnp2wU=;
        b=T/P4z76zQaBInDsOqkYncTqC7Lmnm52X4DV6VfwZHyD6FcytPG1oNG03vuPRDwJHZY
         RFW8OOSLYh7ttz578YQo6+1hIQDpGwsUraIATGRIRM37eMbOI6UhHpF+DTAUyMf+ghO4
         SxGr0eYjnY90azdC0Fw7jvSEWQctzhVafJbO+5bSPLmuxO0reAaNqEn4IIPKJxYgd2Gs
         SEp8mj5e2585nh3oSmOScgVtqCJlmKo9wqVwSdak31I+zonxwupd7WNwg53ysZlN037m
         ChX7EjwYavNr+s0XiXgD+zoFfacYUSkN4O4+JwbrH5sgcxD+bIXmdSf+IQpVNJWcsW7U
         7Vdg==
X-Forwarded-Encrypted: i=1; AJvYcCXeePxE9Lfw0BVqfRpTb/pvBlmlv9O2AmKDMCvl3wsJQgkgSDd60ozWaRZtpkgjV8vH2ikKZm5R4/V+mN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJjHR2emME6+XecjGg2jxamSnAU567Usw9/c2MCnqZVE1QuYwI
	5bQ9OWzx3ynFWYi3c6shUi88ErSYyWyACkIqQZ0sU70frmCrVG8tDE7+fOXOxwsYm+M=
X-Gm-Gg: ASbGncsWvtNN1qp+iaCfjkq8LOwovmMYTmMp9kAiuVpjvKRc1+tPA0FfGfrcqtdlezi
	qLN8tB3DJVZksfMMqprKsUM+4se7EpNPVHk0eMPNFc5x0kT9EGn/jiCddteWKhkfT5UCI7ZOE+p
	q/qjYLy/zEWPXeGzDYXlxHo0e6l1Lh7w3Kly2FRWHu945VsCW/YEmGKhAyL7cU34HUswMuEW83Y
	H7rICp+Fnuwjh2u/Ko14UNkz/ENSESlfuzdAQlDe6sAvdZwXafZld3EieQXT0rs9wc5FQMo28LJ
	W5Qmsxk1gOqAKDTL6ILQbcpWHF59tjVcQ6HCGSjU92q9Wh/3LjEoyxgE5Lbq2u9SX0UZyYdikWR
	uuIMr3KyKFEQraPmH+Cf+b/RJPFxaJKoFENih1BKRa197cqPyemPAMzG1A6nKDRLvMH05fb2RpU
	zRITVYluA=
X-Google-Smtp-Source: AGHT+IHwyfFfA2sTV/MUe2VyGQQg2MXtrnaRyMgy8UiRtfTE0dePiGALEoLXmNajHTlU4ohhAIWQFg==
X-Received: by 2002:a05:600c:3513:b0:471:1415:b545 with SMTP id 5b1f17b1804b1-4711786d625mr156424065e9.7.1761123184620;
        Wed, 22 Oct 2025 01:53:04 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428f709sm34692415e9.8.2025.10.22.01.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:53:03 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:53:01 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH v5 6/6] phy: qcom: qmp-pcie: Add support for glymur PCIe
 Gen4 x2 PHY
Message-ID: <rxju35izazp7zrzs6vyy2cxuynzc6k4i4iot5pjahwl2bfoka5@cutpfodvixmp>
References: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
 <20251017-glymur_pcie-v5-6-82d0c4bd402b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-glymur_pcie-v5-6-82d0c4bd402b@oss.qualcomm.com>

On 25-10-17 18:33:43, Qiang Yu wrote:
> From: Qiang Yu <quic_qianyu@quicinc.com>
> 
> Add support for Gen4 x2 PCIe QMP PHY found on Glymur platform.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>

Since this is something I already sent upstream here and it is more correct:

https://lore.kernel.org/all/20251015-phy-qcom-pcie-add-glymur-v1-2-1af8fd14f033@linaro.org/

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 86b1b7e2da86a8675e3e48e90b782afb21cafd77..2747e71bf865907f139422a9ed33709c4a7ae7ea 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -3363,6 +3363,16 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
>  	.ln_shrd	= 0x8000,
>  };
>  
> +static const struct qmp_pcie_offsets qmp_pcie_offsets_v8 = {
> +	.serdes     = 0x1000,
> +	.pcs        = 0x1400,
> +	.pcs_misc	= 0x1800,
> +	.tx		= 0x0000,
> +	.rx		= 0x0200,
> +	.tx2		= 0x0800,
> +	.rx2		= 0x0a00,
> +};
> +
>  static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
>  	.serdes     = 0x8000,
>  	.pcs        = 0x9000,
> @@ -4441,6 +4451,21 @@ static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_cfg = {
>  	.phy_status		= PHYSTATUS_4_20,
>  };
>  
> +static const struct qmp_phy_cfg glymur_qmp_gen4x2_pciephy_cfg = {
> +	.lanes = 2,
> +
> +	.offsets		= &qmp_pcie_offsets_v8,
> +
> +	.reset_list		= sdm845_pciephy_reset_l,
> +	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= pciephy_v6_regs_layout,

Definitely not v6 regs here. Needs to be v8.

NAK.

