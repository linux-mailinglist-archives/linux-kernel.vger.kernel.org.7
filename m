Return-Path: <linux-kernel+bounces-833658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15233BA2938
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11ABB1891086
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4974227F18B;
	Fri, 26 Sep 2025 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LsgsQepp"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA99C27D784
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869570; cv=none; b=EUCm7/X3CcbFNSv2UehC8ZGx8aZpAq0bBKxQQoMJC7t8AUaY2qjlG7mtqP8Lp8GaDhcbXEEFEQVwq4hYXsZBhbebYoPrOKBaWtHpl6Cw9+97Vyo71SyyuBer4ZFC5BdvyfjvdNP4ETxfMWB3RmbeU4hKJYaebNYcyoXY+7XJFQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869570; c=relaxed/simple;
	bh=b6ZKAv499VFPWlZnjzJkLC3vtFedefMkFojpCq3xoJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDNnDDLCwAf/eb0cxJNLI2IL9HkETxRzD6WyY86UbjBQYpnagGKrqKD8Jw7BbOC4kZIfwF3DiapWzZjN31j+0Luw52GTeIrw7NNT9T/zU7PhzqDRnw6yz5oY0gFgB1Izrb1VW1ITojEIAYSDgfrfMJdTVBzpqvuTcRZq+oceHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LsgsQepp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so1406571f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758869567; x=1759474367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cb6AqBb6fW9MZc+lYACgw4a/Y2tXZeUAquTmyt8CTwg=;
        b=LsgsQeppe6iMq+adrryOy6Y5tnR7q6sn29nCFdqWuxgHRZOZRcgElO0Y7GOSd4tkA0
         z/nwHEszwiGWQjgp9f8JM+FCm/fVP5x/F9zbILGrOrvO7UrtKKZRWgfR9xT+fcgRqHck
         j7RNgY/JiLes6groTdCPdq0TQ4Qfbkd1jJc1SqGP8YpMyBnctoSQ1cNFsXTz/HOlpE2u
         pVWByqCz2YaygqbNvB/at/JXkPo0wg/y4joRuKh3NF9tvlS9qI0T1T5iytSDlm+2nGvy
         f/ZicCB3UxOlIsNaATPfYmzy+QM5poWzT1PAdU966CPvATrw2Ze8f30CGQzt15/VVhYB
         Bs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869567; x=1759474367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb6AqBb6fW9MZc+lYACgw4a/Y2tXZeUAquTmyt8CTwg=;
        b=chNz3PXzfAfUBlopuYiDMumwo08pRWTOdAl6OB2IwfjteoYWkslD6J+jP142sFbl3m
         MnLIGu0IqUvZfqDsAu/pHLzs7su5tSn+FuWfz7KTaDcPRP/08TOPcbisc2Ngrn1g9tef
         jmbdKPn7lAVDOLPdvJeh8H0D5PqIT9gcJHZa63z2AWASph4hYrF54J4Z8NqH2xWRs65+
         +AQoFNF4ltAOVkwTQVwrxV+1kpucJkThFlGgvr0x1ptEJUKj2wmFfFurvosKIEA9amD1
         soHw6ZYjS+1zlFm65smN2Pnr0WJWInEKa/rriBmMNNhJmFfZrAUDWHXEUjtP/p5m9zjD
         rX/w==
X-Forwarded-Encrypted: i=1; AJvYcCXZd+ktRVgBFrO83sBp6nWDM7+bDGmMbMnd+XETIFFzg20I7bKsKp9m7k7SrK80rFCKZf7ktf9Wz8mT8IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaeCZCftYiGthsCLJmH/PjQlP6Ld2OIMXFfwb1mxP96XXZw9Sr
	cxw/Oz30tSBqZsX2//B5ZyaaeEFAovVWLtq7BF1PZj26phpuCX9Qv68qY+AJLiaYVV4=
X-Gm-Gg: ASbGncviLJ36qIp6XhvuX25qk5LaERR1cvH2loWqzbD8oFY6CG8M7lVNR9iYDpyXTXg
	tb2d1yIjo28YEBkb2V3L+Njr1dtM2HgzyrvATpDWWrVDVQqnzBynpWM7GsVZJkly9AvjDRGZECx
	bGzbkOdkLcvAjkny1hPooN6HmHYq48R8LjBiBQbI9MU7lspGtyL+Zz6o14YaYVYqVRySCjei1HC
	LEOEYQZpk8VaueA/UW6S2RrMySBmCJcEOxo4zJ2EDUeGMcUBSDWDY/EI1gtSaRvpe8pH8LngCYN
	SHn53MVhKkhj50l+d8PwkjIfZgOkMHAQiUDjAG3wNlFanoFaZ/4ZsGdG0+7fx9GQcmU7VmZuNDQ
	6K9VDdrJpKUIhE7VvQWziDw==
X-Google-Smtp-Source: AGHT+IEYY8XchQpusLo9mXkJksDRrdwYhd7zVEns9EdpAQet0iFAo1DMOL7A0ElRmCcRVOjtwSPk5Q==
X-Received: by 2002:a05:6000:2385:b0:3e3:dc04:7e1e with SMTP id ffacd0b85a97d-40e458a9486mr5070069f8f.7.1758869567035;
        Thu, 25 Sep 2025 23:52:47 -0700 (PDT)
Received: from linaro.org ([86.121.170.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc7d3780asm5678950f8f.52.2025.09.25.23.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:52:46 -0700 (PDT)
Date: Fri, 26 Sep 2025 09:52:44 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: glymur-crd: Enable eDP display
 support
Message-ID: <5awvbmtwa5tzyyvwhz4yigyt6uccozvr7i4iqlnrkd63dgbge2@usksmh5sbhl4>
References: <20250925-dts-qcom-glymur-crd-add-edp-v1-0-20233de3c1e2@linaro.org>
 <20250925-dts-qcom-glymur-crd-add-edp-v1-2-20233de3c1e2@linaro.org>
 <p7btiavlbu3wqcq62j25vyv5reusdqenz7wtqr3zspywittdfl@iivegwoqfjk7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p7btiavlbu3wqcq62j25vyv5reusdqenz7wtqr3zspywittdfl@iivegwoqfjk7>

On 25-09-25 19:46:45, Dmitry Baryshkov wrote:
> On Thu, Sep 25, 2025 at 06:02:49PM +0300, Abel Vesa wrote:
> > Enable the MDSS (Mobile Display SubSystem) along with the 3rd
> > DisplayPort controller and its PHY in order to bring support
> > for the panel on Glymur CRD platform. Also describe the voltage
> > regulator needed by the eDP panel.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/glymur-crd.dts | 76 +++++++++++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> > 
> > @@ -536,6 +552,52 @@ vreg_l4h_e0_1p2: ldo4 {
> >  	};
> >  };
> >  
> > +&mdss {
> > +	status = "okay";
> > +};
> > +
> > +&mdss_dp3 {
> > +	/delete-property/ #sound-dai-cells;
> > +
> > +	status = "okay";
> > +
> > +	aux-bus {
> > +		panel {
> > +			compatible = "samsung,atna60cl01", "samsung,atna33xc20";
> > +			enable-gpios = <&tlmm 18 GPIO_ACTIVE_HIGH>;
> > +			power-supply = <&vreg_edp_3p3>;
> > +
> > +			pinctrl-0 = <&edp_bl_en>;
> > +			pinctrl-names = "default";
> > +
> > +			port {
> > +				edp_panel_in: endpoint {
> > +					remote-endpoint = <&mdss_dp3_out>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	ports {
> > +		port@1 {
> > +			reg = <1>;
> > +			mdss_dp3_out: endpoint {
> 
> Define the endpoint in the SoC DTSI and just reference it here.

Will do.

Thanks for reviewing.

Abel

