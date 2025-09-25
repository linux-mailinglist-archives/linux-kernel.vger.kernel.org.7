Return-Path: <linux-kernel+bounces-832510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9792AB9F8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89DA1C21C16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935925394A;
	Thu, 25 Sep 2025 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vPnSa8j3"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F54A253B40
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806401; cv=none; b=dXOpEt5pysY1D3KzZGzUCDE+btpecmUAbs6PoB4oLKF6HrGNdZO2VYav2TMjMM5xG565Me3BRA936s2z4BmwSIwQG5WIp5jk4JTf9XrNkRryMZWPCRjZ5V/c3D+LepNOPTiyqrEBrPa4DIc2EC1g3f88cxqObeamIdeomq48g5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806401; c=relaxed/simple;
	bh=YyK2lvbOXbBGryOpMQux96Q1vt+QrwWAbOiyxK6RAs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qj/7ejy8ZWbfjmYvsGQode2Ho3bIZr7oPJlFEfkmwlTxg1TOdpk83vWtLi0mPDRgsYBQ82zRChy0qWpRwva6gL9tOrwlX861Fimn8/UStbtmCEbq2iAsMhDsgF5KZ7lrNyUYqkiUCg6l9GUXunhszwBNAM8xLL0ViiwSvIyNEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vPnSa8j3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b29e8a3e453so138528366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758806398; x=1759411198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EYsaOKNHwZcLmxeqQOplLWeI/iDmclk0EIqTKGLRVqU=;
        b=vPnSa8j3DmSaHYV50awVO1R/1Yo/oMdeY4VrK2XwhOp8vOgeL9P4jqjOlcKIjD8jfo
         WgiyMuthdBSgXDYbwbjZts39Bx4VVf5j84z/TBXSNLjlx2y7guzc1qCebppuyy17B+ih
         tjwycIuEhz08O47/Pgor2dxEMwr8C72Kx8YYsi1ALBGL1oo9sEm5Ri7YQeJRZtoNEc0A
         Jzqp1iR4gWZ+MQQ0I6WgfVh5J42Ip80iWOsjG44HaIhQddxUnmOqcGi1ZCieMYBBRRd6
         OR5DPyEmp5HozgTclZcSjQCfXuCB+IyYpOEpP2PRRY6PIToLg37/K6EZ5XhqSj7+Hq/l
         KC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806398; x=1759411198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYsaOKNHwZcLmxeqQOplLWeI/iDmclk0EIqTKGLRVqU=;
        b=s7BUoDDrV/44GDQsgJfg1rst4/YXrLvoOz0Cwr7Zs3upS6KVvP3h232oIHSysRSfr+
         NwH/Ha/5LY1MLRrtLcr5oHQWXH0lpylW0RzC8vODIZcw3+y70R471S0or4kwjY359WkQ
         uzAkGm6gyf6Cb5lMhUZbUfIk3xjf/K9dmTvCz216p6A+uw1mf++POU7sBSsyY0P8n/+M
         KUxMtVVQYClrc2ut/riVIqG8yHSvGb9tYNKUF50ja6jdNjzx5HxvmOL6JhHwnJ1Zacpi
         wbNofjQtZig4RD1lx4bKDzuGrbgNz27+p2RxikGdVE3B2mSvGxgKrr2ZIp2FNMtbKhO/
         1KOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcCx8kBdUDN7Z0wiZgOQb929t/Tu4Vyum1tY4r4MTLOMFAENP6SEUg455MDPYfcXx8z8kGgvgy+3r8RbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl26RhMuYDldlHecmcReLL9J/reFBk1JUC13zeDbgHkLcBRYzE
	saRX+U6nV9HNRA9lHQAE3CmI+McGR5H6WW13SFF5IWZ4+KGQg0jy3tP/tfewFIeAuUI=
X-Gm-Gg: ASbGncs2gZ3iuHvDfgeoKL2L3kedSchmMurF9AqXg+kFku/mna/7O2FKCCV3zp8aKyI
	L5ELrU0fRFR0SqyvcHyZpr+9S+IbFvDitvxo2KIFMGANzwgEXbpV34Sn+RpTX9ZYKsu8dvB+25Z
	DDmvLfak/LKpKhJmZMd4u7j7lc/A8rndzQp/gX5Tv/klRbeN/qlZXXnMOEHT/577pYN6fio1Urv
	7BnuKRpglFJaYWPvY5Z05I3tyHH3xUs+AhnM+dKSH0mqSmkAkU4SZvbrPjiWo+h1PFs1JQH3gLU
	URWnmUIfKsWBgEImwMSWDl8EkL7/N16Jwj7gVwmy0w9lbBY6EACPfdgydBGeTF6HEbTbQEvykYF
	7lWqsWDnjqxp/CBU7YpcQWg==
X-Google-Smtp-Source: AGHT+IFGtxnVGv2ecu+++ctEtD2PwGh7olmiTWEA5Nd06S1qPZFvTUSBjy6wSrM3gBYU98dPW2fqdg==
X-Received: by 2002:a17:907:7211:b0:af1:f259:254d with SMTP id a640c23a62f3a-b34b79c7aa0mr338206166b.8.1758806397729;
        Thu, 25 Sep 2025 06:19:57 -0700 (PDT)
Received: from linaro.org ([86.121.170.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa4c35sm165745666b.26.2025.09.25.06.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:19:56 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:19:55 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: Re: [PATCH 23/24] arm64: dts: qcom: glymur: Add USB support
Message-ID: <wabocts3sscn2bvpgxamzpjmw3ivkbw2bo33aapospkmj7xtna@ynf2cwpw3fbw>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-23-24b601bbecc0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-v3_glymur_introduction-v1-23-24b601bbecc0@oss.qualcomm.com>

On 25-09-25 12:02:31, Pankaj Patil wrote:
> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> 
> The Glymur USB system contains 3 USB type C ports, and 1 USB multiport
> controller.  This encompasses 5 SS USB QMP PHYs (3 combo and 2 uni) and 5
> M31 eUSB2 PHYs.  The controllers are SNPS DWC3 based, and will use the
> flattened DWC3 QCOM design.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 243 ++++++++++++++
>  arch/arm64/boot/dts/qcom/glymur.dtsi    | 569 ++++++++++++++++++++++++++++++++
>  2 files changed, 812 insertions(+)
> 

[...]

> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index 8a563d55bdd4902222039946dd75eaf4d3a4895b..c48d3a70820e551822c5322761528159da127ca6 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -2417,6 +2417,231 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
>  			};
>  		};
>  

Also, as part of this patch, you need to attach the pipe clocks of the
PHY to the GCC.


