Return-Path: <linux-kernel+bounces-849144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C89CBCF4A1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6232442593B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C83626B08F;
	Sat, 11 Oct 2025 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJ1psErk"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181BB26561E
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760183006; cv=none; b=KM6R59YrZ1EwvnUpKyj/OMrKwTIQoDKTlzW4XRZsE6Q2SPLA5ltJinE4+ENy3F1VdD2+LufDAPMxO44P/ghrCA5rAUeUbHsre/ErrltDnMzvEmpQ9Hwys3HJBmxMQWc+1FUdfbJtOrpPwJ2ZT/O7JXgqTyjeO368VSRWJ5RP9fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760183006; c=relaxed/simple;
	bh=VNyemAc7vyXNsAZSmjzs75LPZtRSVe13x1Us9A7Fhtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5c+K7D9L9DNCb9MDsITDKkmpBx9DGCu/fv0MLl4c2140cEahQAtfAPpQqkAh/N229J8T/tNxcyUOBvm9YQOiQ0BMfi7ReIVoL+Fw21I4Azl8wXagm9GJ8IASy9rrms+5W2vFkBL9XlOVvikpz8XcV7aUzDi05H9zsunh/wuWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJ1psErk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso26443635e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760182998; x=1760787798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hY5uvSgS29Hcw6WzxbdNBonbA1Uf41cjYtAAQjFbEX8=;
        b=HJ1psErkwauja7VgHlCCoAoabklIaYojylsuzqa9yMqJ0YakJkSP+HiUUOszBLnQZL
         mOa1hTv+YHHLVu2MFqoSIdfp8KQqQ6Cb0DNWKvWdbqyxCRm3a0o6+FDijVZYjyZW/lEg
         jRyEArW4094vwid7TwRMiP0cb/qpls3PVRNxFcMP6eEu32/9N4/fsGGL3f88nBmjpHWq
         5JyJsqnz6nYCHbvgMdQLAcaPWn0buHUVp6YhohulXngGEpky7v5d+1vStpDu9iqVhPB0
         Z1lU+hBrRuuqZFma8umwWxpmtkBOxSZpavtai1jvuFPzJxe4bte3YsBS52jfb5j4IjUk
         DKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760182998; x=1760787798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY5uvSgS29Hcw6WzxbdNBonbA1Uf41cjYtAAQjFbEX8=;
        b=Ls3lXnJQn+wf82Zy9GDxsIt4qdC0EYktdPzWWNZG18JiDI/i53nD0DOAFPHeVdWz3R
         fzA8ZTNX9EbZIOhJUT7w4VJZQXeM+3LHU/ZfTGRv87UpF6z2o9cZh3vfP5TpWiyv2F70
         hCNvs71Y15p+8mQHunbO9T2Rv7R7EY3KwEoU9g/fTJwo8+P046KshkwJdKyNL27aAdp0
         KH36prfg+Dk28c1g0UwICd9B/rx9M7A6KwU1TeyvmnzQ2wmz9IjWTBJM75Muw4cHgm/S
         +mW2DNOEkBh0gTVxjGuHYtnutin5odjk2mq3HU0mIyClCYwwOHaQcR43to+uMj11D8Ux
         rU+A==
X-Forwarded-Encrypted: i=1; AJvYcCVT1j3pKI9yX1u+RhARyWaRuNVEigEX4oS0Hw3TkN7d2BA/FqboYz0YicWhLSDSeFeCqdkl5WuNCOyhYpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrFmk6VF9kn1rstaUz834XASAAFyj6/k9oo4S+fdDymi0xFTzM
	44p3ixRcn6CxA/uLtdYLdXP5VDrOzMYCz3HAqFa2uGsx4MEm5zwDCpkuzol0FG/3+NM=
X-Gm-Gg: ASbGncu/Nq/tiuz27zvHsAxskqcVtI002ZBCGzr4wPzYN0PeRpf+NZkvPcm8hIJfM+u
	etThgO11KOySKbfPtCQoCSOSaVSaPnLbYkIZO1yrBkIt/mHamA8S8T5vohe3s6/LMZEWTqcJLz8
	Xd+KxG9+HXGoLrxb+m+P3QMciSB1K5jd3tH3gkGxGt0GoTuTJNBhpAE6rmtW3LIgyp6akVdIuI5
	EAVcJPirk2fUb3cKGmcdrJRAcKW1exkMouPmGTwj5q8Z1h2rqfS2TbuWdFhhQr4bAz0tSDpNTHL
	fUBUBZRlHHhZ4pk2oHUxWD9U1b2DuDjwhaOtOPk2edMeFyGMC3YzoQOb4pAAnxjSQ+cDbFNENiv
	gxkHSrMTs0Ddq3EtbX0sslj74zTJNBeEkPSkRmsym4tbvXyVLPTra
X-Google-Smtp-Source: AGHT+IFRCrBmD7s1cgzkGkuICLV7U1JPlNpBXYM/m0v9awapqHAnkU1llQHTFmawWVqgaD2lMT2oZQ==
X-Received: by 2002:a05:600c:34c5:b0:46e:3d5a:d15d with SMTP id 5b1f17b1804b1-46fa9b064bcmr89831475e9.26.1760182997632;
        Sat, 11 Oct 2025 04:43:17 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb48a5bf9sm90105195e9.18.2025.10.11.04.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 04:43:15 -0700 (PDT)
Date: Sat, 11 Oct 2025 14:43:14 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH 19/24] arm64: dts: qcom: glymur: Add support for PCIe5
Message-ID: <ilr7iaasabiwynzdu4ca6bhcyu5ubznc4yw4chfa3hkqsxjauw@2y6smgstv624>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com>
 <da2vvejbqdteaszzwyktczqivjblyawzh2k2giyoxdxlxcdrcb@fkuqivjmaggf>
 <aOiw75D0RhDNLZLQ@hu-qianyu-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOiw75D0RhDNLZLQ@hu-qianyu-lv.qualcomm.com>

On 25-10-10 00:08:31, Qiang Yu wrote:
> On Wed, Oct 08, 2025 at 04:36:59PM +0300, Abel Vesa wrote:
> > On 25-09-25 12:02:27, Pankaj Patil wrote:
> > > From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> > > 
> > > Describe PCIe5 controller and PHY. Also add required system resources like
> > > regulators, clocks, interrupts and registers configuration for PCIe5.
> > > 
> > > Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> > > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/glymur.dtsi | 208 ++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 207 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> > > index e6e001485747785fd29c606773cba7793bbd2a5c..17a07d33b9396dba00e61a3b4260fa1a535600f2 100644
> > > --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> > > @@ -951,7 +951,7 @@ gcc: clock-controller@100000 {
> > >  				 <0>,
> > >  				 <0>,
> > >  				 <0>,
> > > -				 <0>;
> > > +				 <&pcie5_phy>;
> > >  			#clock-cells = <1>;
> > >  			#reset-cells = <1>;
> > >  			#power-domain-cells = <1>;
> > > @@ -2511,6 +2511,212 @@ pcie_west_slv_noc: interconnect@1920000 {
> > >  			#interconnect-cells = <2>;
> > >  		};
> > >  
> > > +		pcie5: pci@1b40000 {
> > > +			device_type = "pci";
> > > +			compatible = "qcom,glymur-pcie", "qcom,pcie-x1e80100";
> > 
> > The first compatible is definitely "qcom,pcie-glymur".
> 
> According to Documentation/devicetree/bindings/arm/qcom-soc.yaml
> the preferred order is qcom,socname-ipblock.

Fair enough.

Now I wonder what happened when we added the one for x1e80100.

