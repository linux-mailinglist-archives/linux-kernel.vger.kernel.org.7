Return-Path: <linux-kernel+bounces-813439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD592B5456B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D851C86581
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787BC26F293;
	Fri, 12 Sep 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CK7g8QAB"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46D19E97A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665889; cv=none; b=UTq27zYbw3xybSUbeowcKyMi+U6716Er78x7FZ49o9zRRhPRR2YijMJKajvsn6Vhpsmd8qHVaVNcohB2/chWguOW69E4G8W7pgApJ9Foj3502OhHBscGQPqHcTbmfuwdQiIPuNHfI1/biejf74IRO73mOoJMgzZ12Wux/a7xcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665889; c=relaxed/simple;
	bh=qxDPXfu0D2buR+RRbIJYhumpNTYZbGUZbNv5xeDdGtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHct6yZzT9YODCieViKk0ar7ab5UImL6+qVdfV8VNLjQYR++Kmssu1t1OV5LeQaZ0HYvVIZgY4sBJLBAECBCczxrQSdi/IsaDh0zor5WrVYsgF8RTy3JPlQ6QCsDG08YCyYv93mQnjc9liy8MPGy1UVZ+tzv/1Cf8MYWLpI3iVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CK7g8QAB; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b04770a25f2so222478866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757665886; x=1758270686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ppyqoh+Iw0PqJAwUNY4Ho0HDTTkAPt60vzkSPtE9aMY=;
        b=CK7g8QABQj2cvFfH+iBCciCe6r77uFwU/Ta/PYwD0y0dFTYaAio6PDdAAsve5zjkWq
         hwlTvm2RgPmK1BrcSHJCPV7JCadzMwtYGLhrrSf4bFI14MGAL6kUIk2Wt5Qtx6FgtOJN
         algt32Q4GwwvdUqCIn0tzIcC+Ch6v1Pm7txApJjnaLfb7nmryGgRzpGwHOondEIy06sf
         gm6HTpkgWVVKbceJvEH56LOYZZknT8xgeUn2U5L0yYjur/UrhMfGpESFH8fJ3eflwZmb
         XIqi2z5uOCUiFq8NGxJLU8jkHuy1eLunaVc+vc8y2+oMgu6xOXYynC5XZkT8bDQW0pQP
         7pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665886; x=1758270686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ppyqoh+Iw0PqJAwUNY4Ho0HDTTkAPt60vzkSPtE9aMY=;
        b=GcKT4McIhK7Qtj/pqUVKITJbgHKenEntdhvJagUfeWPulXi429jVut62K0yyrA+sxr
         OMbWOKj0mAumTbVkE5ConjaCTzMO3KwsLoP36c3RlmZF0pm7kqVn0E5NKkXLY4oFAwP1
         S76KuvkYJxfrZIif80rkToRSe8x3eWZSSnRissSq/bFF0nXnMmUoRaG6yaXGTlSnYNlT
         Y0scABMRujYlJRiGS6iRLPpJ8nDZMYKS0MQz330Rc6JV6rPkUH4jGMi44ydFmKFiyZt5
         v2FfTy5NirVSMXA9zMvdeKPo2DwTp67WrqUaGDaWmd/EUZ3tiAOpBnQWAywDQWoCsi5F
         TwtA==
X-Forwarded-Encrypted: i=1; AJvYcCVPulwacXj0eJaDJ8+d/f31hpkQ0kFrGUGqLBCbqYsLsr47MwKfcRP6+DvB/PVtA1+kYdUCQ8ZdK25t6r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBfWKBJ7XSv4aHG8f5vVI6ThOmde7rtR1WQM+s/FpwPtGRedv/
	PGhMC2GmrJwVxbeghZZp2ksA25lM3axeDDnYZImnREk07yudyhzU+hmOqhZYT6b4Gg8=
X-Gm-Gg: ASbGncuFweFtCCcLPtFu1bVNEglVrdvJrzP9qMTPDo4jEYyWw9wvj/LK9wGaIslDrjG
	FDwW/qwcLmF8hyaY6zl2nVrIgGrLg7ya4caU8YP6SZp0u1yybGe5PeXl9zIkocyGvky7JgyMihx
	BR99bPxOVOLAPC1UtkczdUYjy1XfUhAavujTvs/QamZzXWwucbddyf++nNFJW1bIk6pBpkeNHCN
	YUdubkOKkjiEx9++Pvdnjb6mK4tw6dlQR65Ea9ArRflUJAQ6y5qiOf2vi3blztK7xKisGMJ5Xli
	2Cd10QAa1rGzZXsyUdv5uAS11KY40sx21NtL6sNSB1rTcXEX/bLEVU7N/MzsxbD5cj2niP45Waj
	31OO0j8UHvxaRYShdinqhFnafKoOOrM1ce8pczYCpgMI=
X-Google-Smtp-Source: AGHT+IGK4F+WV3rm3atyzmeXXAtBgSxVX6KmGkgnNVbx+PqUaJlvPMOJRphX7MOVOAdtjlZGKPWKlw==
X-Received: by 2002:a17:906:9f84:b0:b04:ba4:8610 with SMTP id a640c23a62f3a-b07c3ab96damr205770166b.62.1757665886221;
        Fri, 12 Sep 2025 01:31:26 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:5fc2:ee41:2050:2d49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f20dcsm318941966b.90.2025.09.12.01.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:31:25 -0700 (PDT)
Date: Fri, 12 Sep 2025 10:31:21 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: x1e80100: Add IRIS video codec
Message-ID: <aMPaWSN8EXCEOuoz@linaro.org>
References: <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
 <20250911-x1e-iris-dt-v1-1-63caf0fd202c@linaro.org>
 <1beb1e15-cafd-408a-96bf-7f749b3499fd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1beb1e15-cafd-408a-96bf-7f749b3499fd@kernel.org>

On Fri, Sep 12, 2025 at 09:23:45AM +0200, Krzysztof Kozlowski wrote:
> On 11/09/2025 20:38, Stephan Gerhold wrote:
> > Add the IRIS video codec to accelerate video decoding/encoding. Copied
> > mostly from sm8550.dtsi, only the opp-table is slightly different for X1E.
> > For opp-240000000, we need to vote for a higher OPP on one of the power
> > domains, because the voltage requirements for the PLL and the derived
> > clocks differ (sm8550.dtsi has the same).
> > 
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 87 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> 
> Feels like duplicating this:
> 
> https://lore.kernel.org/all/20250910-hamoa_initial-v11-2-38ed7f2015f7@oss.qualcomm.com/
> 

Oh, yeah you're right. I haven't looked at that patch series for a while
because it went through so many revisions. Wouldn't have expected to
find that patch in there, especially without an indication in the cover
title...

But we can keep this short: The opp-table in that patch is wrong, they
don't have the correct required-opps for opp-240000000 like I described
in the commit message above. They could have easily known that if they
had asked the video team internally for review, because we had a pretty
long discussion with them if this is also needed for X1E. :-(

I'll comment there.

Thanks,
Stephan

