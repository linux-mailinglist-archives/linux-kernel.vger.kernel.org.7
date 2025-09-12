Return-Path: <linux-kernel+bounces-814131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B7CB54FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF567B020B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7C030F924;
	Fri, 12 Sep 2025 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZY+ICV6"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D40303A13
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684097; cv=none; b=oemEaaKMBdjeSjwEjdH1nxiN70RmFF6fQQaT9hvvgrh0yoFvG6WNqN9Y30azMravGW3SPoPTwwWQmgkkHUvW9YEFYUEZB0mfRnP8cMdpu41CTMXAWVw4VsQUA4nog2dsdA+t3zFZWrDjV7KXf2/qzPmY30sAJdachUirhMrFAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684097; c=relaxed/simple;
	bh=fEA2x43XLCIFZ1HAK3Qmgt2WPelPhB3G6VX1hKyr04E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAYGAFeiBtH55lyJPlcbR1wajgLK2hUxLgJHKjJutnFQ8JtQceZU4A6fwpRgsnwsq0ff4QdeJE+SWjDSh62DPWFKxxy0f4ZhL+vYBQxVbG3YeIiDpCARAUQk/Cbg8ye8SelThjBDEIku44C58HgJtSVX2sV0yY8QtRzY6kdzhXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HZY+ICV6; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ea0297e9cd4so1195221276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757684093; x=1758288893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2bpJdu9pcJQYlguGDM8bqSYyNGG/RarwGDha2QaDV7I=;
        b=HZY+ICV6iudkiQNYe2sLLea4NT501Dw4egsi9L6nTGUS3TP4likQcWCh0l33zEkBor
         qld7HSDUKGCUZ3+K0pF4lA1NirUluSRDV7pIkFP+hsPRrt7d8IVtUvbAqpgAtK/rMYs3
         ggav0uF00M845sDJV/DSYbF8jXSMUNnFIPASX80UqZyWNik35Qs+raHmfHG/lGH+933g
         CQB8WuC2LHrS3Tdo296WX3l/jWoi+AtyWBkgtjg9iY8nsGB/DEVUNeDQ4gFAkY+ayQoe
         gMTiOLlY43MuWoA4ffPTPYUnyJz8bzYTCWyahejh6QpwdZqjTto+O57VOagO0Y1NYmte
         SESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684093; x=1758288893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bpJdu9pcJQYlguGDM8bqSYyNGG/RarwGDha2QaDV7I=;
        b=BNGjYlN9+MYcV0/7vAy/jj/WYIrwPgRrTG8fj1ePbKSvSTzBEo6iq11pcnEEvCuUR2
         vn0C9a9Gf40hNoS2cVLcdnOpUSbMxc/LoWpa1iEOXQz4PLI8iPhkV6v/se7yjGLc1sE1
         R1ZFPbQYxjkv2EYNZqLo+elW7AXNW/y5CRIVfz7r2Dwsb/fXMMs2Cqp1U5saZsccZ4uP
         ioMIoMjAixX0UakAwhk7eZc7YLgGg0hncy2DUj41Dp7Lul/iWF5AHct0FkHUaciGMl+H
         P6nb01UcJC7/F8r+4JjmaZiDhrcknzBYcdTU7mvBlS6utgtO0wAAnl3FW093XTxXO/VB
         bDzg==
X-Forwarded-Encrypted: i=1; AJvYcCUa530s+2I3LW/hUQ8MofrnsC4a5i6pINKtozO0FdSytDOP5Wk+lQbTsxHX3v9mE9Vycl7qQ8404GqnDbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzigngF8ZVTnA2MkiRljOGWpUKS/XegjvpFf31BF8GACpTbHI2p
	y62ntXyK+TVdmb+SrY3BRcREN6MHEpdja7ZhVG9WdJNTc0WimKg3A7HaoT9Z+YbXWkupoSKKnvg
	qeSUSPpix7+CEeBgMN+SLGTKpQ02v0hzbUTRLilbGTQ==
X-Gm-Gg: ASbGncv8fU23DovD0JaXpQmWOlSWUFGWSsJr5iGMzIZrPxi+I2Jago1klClPK7P6DEP
	A6s/rutijux4qczjlYsV5IVTQmDzhv2Wc2PtgAXKiMdTKqjYWgPd3cK7CLPc78jWMt+Rp9LsXa9
	nM4Ii3sTOb0yRPQpTIvDw83hw00cBLmGDLfXKW4oxFS9I7EsY5Huo1+1iQ/Isf/d4b7q4TdZhWK
	Jb1KdGYbHsbIY3gofE=
X-Google-Smtp-Source: AGHT+IEuZCNOuhgw71RPHODJCaUVdzYWPbD3/yFfpzIGoCGg4ZN37cLNl53g3621ReprRkmpK3fxKWmw69qSmb5zAxc=
X-Received: by 2002:a05:6902:420a:b0:e96:cb0a:de1e with SMTP id
 3f1490d57ef6-ea3d9a52b30mr2169012276.24.1757684092934; Fri, 12 Sep 2025
 06:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
 <20250908-lemans-evk-bu-v4-1-5c319c696a7d@oss.qualcomm.com> <aMP+cdmPkej+lPtN@hu-mchunara-hyd.qualcomm.com>
In-Reply-To: <aMP+cdmPkej+lPtN@hu-mchunara-hyd.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 15:34:17 +0200
X-Gm-Features: AS18NWClkCqcmoRAoe-mTGNfJBFQQqeUo2elvNw9ONlW9bzSgs8qRR9fnA2vWEI
Message-ID: <CAPDyKFoZEWyysS+WT=JBY388kFgKUeUL5hxm1wL1pmn+NUAEhA@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] dt-bindings: mmc: sdhci-msm: Document the Lemans compatible
To: Monish Chunara <quic_mchunara@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com, 
	Wasim Nazir <wasim.nazir@oss.qualcomm.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-i2c@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 13:05, Monish Chunara <quic_mchunara@quicinc.com> wrote:
>
> On Mon, Sep 08, 2025 at 01:49:51PM +0530, Wasim Nazir wrote:
> > From: Monish Chunara <quic_mchunara@quicinc.com>
> >
> > Add the MSM SDHCI compatible name to support both eMMC and SD card for
> > Lemans, which uses 'sa8775p' as the fallback SoC. Ensure the new
> > compatible string matches existing Lemans-compatible formats without
> > introducing a new naming convention.
> >
> > The SDHCI controller on Lemans is based on MSM SDHCI v5 IP. Hence,
> > document the compatible with "qcom,sdhci-msm-v5" as the fallback.
> >
> > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Hi Ulf,
>
> Could you please pick the binding (this patch) through your tree, so that the DT
> Maintainer can pick up the remaining dts changes through the qcom tree?

Sure, I usually do that, but sorry for the delay!

Applied for next, thanks!

Kind regards
Uffe


>
> Regards,
> Monish
>
> > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > index 22d1f50c3fd1..594bd174ff21 100644
> > --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > @@ -48,6 +48,7 @@ properties:
> >                - qcom,qcs615-sdhci
> >                - qcom,qcs8300-sdhci
> >                - qcom,qdu1000-sdhci
> > +              - qcom,sa8775p-sdhci
> >                - qcom,sar2130p-sdhci
> >                - qcom,sc7180-sdhci
> >                - qcom,sc7280-sdhci
> >
> > --
> > 2.51.0
> >

