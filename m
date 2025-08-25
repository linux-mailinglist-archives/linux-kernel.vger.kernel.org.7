Return-Path: <linux-kernel+bounces-785641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B466BB34EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A130208612
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470BC1A9FB8;
	Mon, 25 Aug 2025 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YNFU7y2y"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AB61F560B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160397; cv=none; b=NIafi9Ler3i7FqtE0Ee8QM/LZjCpBYZAuThZgfATdz7mxTjv0wAyAqUYW+tKyYMT48sPnwoV9esM7eMqof5uH8N8f4eEPzGNWN6Uz+N9hVawLn2U5qDSzVzukJjVGkRRg6E6/7czIv1bTUevvuXCA6Bv25l9PJmN55Lk9x6xkvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160397; c=relaxed/simple;
	bh=pF5m4XVh5+kykGCQizUldzCrFgr+3qmcWGuNjVxySro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3owrUUcELeRFvA+qzrhvyOiGnuULqy0b7sKpvRj27IglCWfmJtbfu1Dve8zGnJgkXPs+PBDI/1nScGvxmCQv1JTX5njee2glW/GlamEpu7pvvOLrQvOaTDlrV6g8hrniT8TCGZWR2f2LM0tE+QW248B2izJ2WPi++aAXo62ZSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YNFU7y2y; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-771e15ce64eso1155788b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756160395; x=1756765195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/JpVTU3PWKRezYGNXaHQneZI3VniMUHuCsVrcgfQ/mw=;
        b=YNFU7y2y7zStDluE1E8zyp4nokpQ4jS0ZipW6DwTqqqti+NthkCLsP5bAeuIjxv7l8
         sg+j5/kr85OmM+rEU8bAqj+xnHh4ZzAvLQ0TsfRbyT3c9l96NVR9TFVUbHkFlJsuFlxO
         FFtaHLshuTGDYuVAKnghyS91ibQ1QptcnAucg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756160395; x=1756765195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JpVTU3PWKRezYGNXaHQneZI3VniMUHuCsVrcgfQ/mw=;
        b=F61CUUUm7mEx3IPBWB791ngiOMCTaABBtiW9z0rbUzjDYTujzVSpfR94xvYBOFWrHK
         9ZZANrrFmPFWhZOkgUcVE81NMPc0fD3pcbMbXsUF7NWQAwgI+1do0UUMp0TiAfO2gBhr
         dj4J/4a5rLB9SaWtTa+6+11QLME4oRD4A/C6Xct8F0pI6qDmSg8IrKrnKdrWpSOHFtkb
         CDhuJJDEX+obUDS2lJxNJ1mCoQSmXNO1dwGydoEs/cy4nXtaoM+jeEvHyVBow7toENZP
         BICmAxpzOK3w+sq+eRZ32ZQWOYwmRtfftrhz39H6bl7dcJm7qszKSpoKYEXkPdzQItbA
         PJFw==
X-Forwarded-Encrypted: i=1; AJvYcCV6Ua5zcX5cW4+70ZrlKcH4h5dpCL3NIWR8E+dvRAsV+p/hdd/532rnFSGI4Jq8o9dzixaKsTG4s3OGSS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwB+Cd6rPzqXaNaV1Gu8k6nDgMfPIH04fx81MT5jMLnafnVvcT
	H2JrLs0SaTPQIZDFJJfI3tfqjgC2ythMVAurlHb6Fp/TybszotLygg3+Y9tGXg3ahg==
X-Gm-Gg: ASbGncvj26tlm1gOZA5o9BPdURjhPOgqWw3R2cV5/xllGZmYOhQTx9lrSOWl7O9gcCX
	741vxKT7VyuxlgbcAsstoywrpmYC5Prl1GOnpyHOnDSM3U54ifGi4JYrOC1/NZRIHwhqyGvA0Ab
	UYRk9RAw3mntLVD4cpDLro6/43253NoRk41+OqqThT9pkDFD3LS6QJrm/aK/2MEZFGds1/1zdJE
	63Y1fXxjI0Yp9QErQYAo/+KNpoUl8zb+bbq5GDvJ/7gwiqHuMuZ9j+zjLz++kD+a99mItBeeQsb
	j3XBcMC3ElrF2WxzFb7i82ctOglhikxazPBIYADDvk07SYukx8uJbCjEa2b9NRNCNfhHHXC8KJU
	8wemxuHMZWMrFfmlSEe97qUVrT6PU/iYPc/R/wmkH2b5dmC+brwX8U8CL9Q==
X-Google-Smtp-Source: AGHT+IHGJg8be7xU6VaEaBVE+3EWYZ4SopGxSXLSailrKgYeCMuf54WK7If+tDGPHqm1jXQLMQoqYA==
X-Received: by 2002:a05:6a00:14c7:b0:770:5987:5b3a with SMTP id d2e1a72fcca58-77059879144mr6483981b3a.16.1756160395127;
        Mon, 25 Aug 2025 15:19:55 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:230e:95:218f:e216])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-770401b01b2sm8327239b3a.64.2025.08.25.15.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 15:19:54 -0700 (PDT)
Date: Mon, 25 Aug 2025 15:19:52 -0700
From: Brian Norris <briannorris@chromium.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Odelu Kukatla <quic_okukatla@quicinc.com>,
	Douglas Anderson <dianders@chromium.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, cros-qcom-dts-watchers@chromium.org
Subject: Re: [RFC PATCH] arm64: dts: qcom: sc7280: Drop aggre{1,2}_noc QOS
 clocks on Herobrine
Message-ID: <aKzhiPIDszlMocIQ@google.com>
References: <20250823123718.RFC.1.Idebf1d8bd8ff507462fef9dc1ff47e84c01e9b60@changeid>
 <3i7pdzata6gxsc3svb3eygubfdfmnetlekxdd25bb4ljkdrlh7@bvufiwmdusqz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3i7pdzata6gxsc3svb3eygubfdfmnetlekxdd25bb4ljkdrlh7@bvufiwmdusqz>

Hi Dmitry,

Thanks for the response.

On Mon, Aug 25, 2025 at 12:22:03PM +0300, Dmitry Baryshkov wrote:
> On Sat, Aug 23, 2025 at 12:37:18PM -0700, Brian Norris wrote:
> > Specifically, they fail in qcom_icc_set_qos() when trying to write the
> > QoS settings for qhm_qup1. Several of the previous nodes (qhm_qspi,
> > qhm_qup0, ...) seem to configure without crashing.
> > 
> > I don't really know what's unique about Herobrine systems vs other
> > sc7280 systems that presumably work fine. I'd guess there's some
> > conflict with something configured by the boot firmware.
> 
> I think it well might be that Herobrine's TZ doesn't export QoS regions
> to Linux.

That may be. I don't really know what to look for to verify that without
a lot of research, aside from crashes like this though. I'm fine with
assuming this though.

> > I'm submitting as an RFC just to get thoughts from people who hopefully
> > know better than me what might be going wrong here.
> > 
> > Fixes: fbd908bb8bc0 ("interconnect: qcom: sc7280: enable QoS configuration")
> > Fixes: 2b5004956aff ("arm64: dts: qcom: sc7280: Add clocks for QOS configuration")
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > 
> >  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> > index 2ba4ea60cb14..59203ce58c61 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> > @@ -394,6 +394,16 @@ &vreg_l2c_1p8 {
> >  
> >  /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
> >  
> > +/* QoS seems to have conflicts with boot firmware on these devices. */
> > +&aggre1_noc {
> > +	/delete-property/ clocks;
> 
> While it might be enough for Linux to make it skip the QoS, I think a
> more correct fix would be to remove the 'reg' instead / in addition.

That should work too. However, besides simply violating
Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
(which is easy enough to tweak), that also violates basic simple-bus
rules:

arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb: soc@0 (simple-bus): interconnect@16e0000: 'anyOf' conditional failed, one must be fixed:
	'reg' is a required property
	'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
[...]

> On the other hand, having those boards used by only a few people it
> might be easier to just pick up the simple fix rather than implementing
> a 'proper' one.
> 
> Nevertheless, this would require changing the schema too, see
> Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml

Sure, I've tested out a change just to tweak the clock requirements.
I'll plan on submitting that if no solution arises for the 'reg' schema.

Brian

