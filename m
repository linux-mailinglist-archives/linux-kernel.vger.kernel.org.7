Return-Path: <linux-kernel+bounces-849234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF00DBCFA77
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED9A189A1FA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C2427A906;
	Sat, 11 Oct 2025 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYJ6svKO"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0D32836B1
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206345; cv=none; b=b2SBNL51LbLxXhT4lO9wcIzSGODXjf8dEV0oQbi+YE4pmfIyOhrXs8xdLqocbEAN7UP4lcZLaWSUFXBcwHQkF2XjImrMXqgGToA9FN/3/6763LZJQRrTMJqJgcIgqypwUD+g3nWkf+iL5K9ZGE9vtGNHJySYksjQ5sr1YVObHbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206345; c=relaxed/simple;
	bh=JVyCen9ID7WfgBvuuobCEwAfQIMD3ZOSiRB+hExPSss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXwX4K12OEuQV97cj/150JZqPdv8Gw56jjB4wX+/wdIaGxEkEJ/7mskF3pmt7pQi8wPfsAUZ2DHFM5aRi3JKLpHgBW9ElZ9XeInxuUpuZ3UDBOjjK9SGEpYTqBX8pjVGcMirxbEjVG1dmu0kSCDoZrVMs408l6klWRscnjum5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYJ6svKO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so15376725e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760206342; x=1760811142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=byehOKya7clPyuO5oMzDVY12ALhC721UTQrHitcR078=;
        b=pYJ6svKOgToqWXUuYXTx61dpPMlgW7jhUHGKFN056+Wl5/PaqRfFKckKmiQkgyk+HS
         b4lqtABL8odPVXTjKgkazMPDktwkScfGLz8qZk4i7JVzzNBtCWdMvMD279o7uLMNJsM/
         rNh62sc4LYwoi++GI6Cse4Yk/ib9UxNiwDl27NUAyRbVRoOLi3gs7sH8RyqQ1Yp46DT9
         guqfCvAlf9iPIfRGquzuPOx/5QewdgIj9GybE7lXuxaRhljxJZBTBIG8e1Kk0/GWvO3k
         hAgOoOgmSm1C9/QmHdWmMSRKJXj1lD35YCo3UIwnHgc5Po46xh1BiAPmw+A+HgcSic79
         nh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760206342; x=1760811142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byehOKya7clPyuO5oMzDVY12ALhC721UTQrHitcR078=;
        b=N+ZwanlJlISnxVXOdBjySurMu/IoZXWJ/9291PEeFRQpVOjcaNy0ilEI/FBa5h+tQ9
         iUnLkl+vUvnac2B9eEom7Nb9KCJIY/T01UqCRYVmpeBIHh+WYjaada3u/U14y594IZdH
         b/XdKDTgiHiAViaMocVKGtfnNBP/uw9deFedUgKjqQLkbG0x5Nlb+79p2JaJ4KXPMnOy
         Xu+T8O7qsmHQ02wdqr3DLqNLHweoeD7ygpRc/PGebvrYAj5wCTHRtA2L83V++P2uF114
         dlw5MxR7nV0GHd3ty0vptQUQb+s9r6BCg/62mJ6ABXSPf+48yO4BeIpcpu0zqDd6IHY0
         K7xw==
X-Forwarded-Encrypted: i=1; AJvYcCUuAeMUyJXoNe3ddR1NXjsQVvPG/0W0uWynP0mozcAEnetZts61HD6LIhmY9MsZT07v/xoPNCU+3bZFk28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUeUovRI5M6Z+9SwW3JsfwM7BvAPLtXHSjHOS8f6lYGQD2vPDi
	spuP9rNdCVhdx6xiBVlAGFdDKrk/1cmSL8PE9eIhk5xoOW5ZRiUKNKTCnGVK2T4ZbOU=
X-Gm-Gg: ASbGncvgOOAhuHWz4Z8WUm3rDEeGdP3G1CJq3lzD5WtGnYmTuWqyJunYIhFO+EzEo+s
	fyHIcpABINzMbnRCW1OyesODCTfqGSMVXJL1aNxY9Fd6gwBwJPMKAbGTAaod6ytQzNdTNf3Gg6y
	HQ2tg0b7yHmmdhnfBWnduB2BgN3tio81gGtMbQqgcs5awo+ikCHt0XzMXXWsZqtROmmNgIHecld
	FYR3UMvC5ZKUAV+AQESPdUEWInf2nZNxRFS1XGDJzkfWnyX7dXrGZDUR87LsRIBQxjOBm2Rtq3e
	m4GQRd/IsnvD/6FEFQaiKlWmvPZAECxOhHCM7c5aVVs5ekKZ/Vxey5P25ZNxpL0D7eMdfv+mGxP
	RBKrC4GL2bJe35mbR/qA+Ked6f4/es4Aobv3n4BOEkw==
X-Google-Smtp-Source: AGHT+IFJWjfI1n1Q1BGzFtpXqGVeGA3bk9apqrt0phLLs0Zin2ROyJdGQPpLFkG37xNdDNcr+MYP9g==
X-Received: by 2002:a05:600c:b96:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-46fa9ebe245mr116042085e9.11.1760206341387;
        Sat, 11 Oct 2025 11:12:21 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d3b9sm9936139f8f.11.2025.10.11.11.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 11:12:20 -0700 (PDT)
Date: Sat, 11 Oct 2025 21:12:17 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>, 
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH 19/24] arm64: dts: qcom: glymur: Add support for PCIe5
Message-ID: <7tvwxsdzkyh5ncsm4x5p26qdc2lhuecqecou6aectezdqxz2sf@4wsq3sppx6b4>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com>
 <da2vvejbqdteaszzwyktczqivjblyawzh2k2giyoxdxlxcdrcb@fkuqivjmaggf>
 <aOiw75D0RhDNLZLQ@hu-qianyu-lv.qualcomm.com>
 <ilr7iaasabiwynzdu4ca6bhcyu5ubznc4yw4chfa3hkqsxjauw@2y6smgstv624>
 <a75ndv2mzwy3niihi3o2ux7lrkue7h5avj2vcxgqhs3hasunfg@cosy2knsveey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a75ndv2mzwy3niihi3o2ux7lrkue7h5avj2vcxgqhs3hasunfg@cosy2knsveey>

On 25-10-11 18:57:56, Dmitry Baryshkov wrote:
> On Sat, Oct 11, 2025 at 02:43:14PM +0300, Abel Vesa wrote:
> > On 25-10-10 00:08:31, Qiang Yu wrote:
> > > On Wed, Oct 08, 2025 at 04:36:59PM +0300, Abel Vesa wrote:
> > > > On 25-09-25 12:02:27, Pankaj Patil wrote:
> > > > > From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> > > > > 
> > > > > Describe PCIe5 controller and PHY. Also add required system resources like
> > > > > regulators, clocks, interrupts and registers configuration for PCIe5.
> > > > > 
> > > > > Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> > > > > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > > > > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/qcom/glymur.dtsi | 208 ++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 207 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> > > > > index e6e001485747785fd29c606773cba7793bbd2a5c..17a07d33b9396dba00e61a3b4260fa1a535600f2 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> > > > > +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> > > > > @@ -951,7 +951,7 @@ gcc: clock-controller@100000 {
> > > > >  				 <0>,
> > > > >  				 <0>,
> > > > >  				 <0>,
> > > > > -				 <0>;
> > > > > +				 <&pcie5_phy>;
> > > > >  			#clock-cells = <1>;
> > > > >  			#reset-cells = <1>;
> > > > >  			#power-domain-cells = <1>;
> > > > > @@ -2511,6 +2511,212 @@ pcie_west_slv_noc: interconnect@1920000 {
> > > > >  			#interconnect-cells = <2>;
> > > > >  		};
> > > > >  
> > > > > +		pcie5: pci@1b40000 {
> > > > > +			device_type = "pci";
> > > > > +			compatible = "qcom,glymur-pcie", "qcom,pcie-x1e80100";
> > > > 
> > > > The first compatible is definitely "qcom,pcie-glymur".
> > > 
> > > According to Documentation/devicetree/bindings/arm/qcom-soc.yaml
> > > the preferred order is qcom,socname-ipblock.
> > 
> > Fair enough.
> > 
> > Now I wonder what happened when we added the one for x1e80100.
> 
> Our PCIe hosts mostly follow the legacy approach and nobody wanted to
> change it up to now.

Yeah, makes sense. Thanks.

