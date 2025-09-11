Return-Path: <linux-kernel+bounces-812750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D395B53C36
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0696AA6990
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC46246BD8;
	Thu, 11 Sep 2025 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lx3yzrdG"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2150B25A34F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757618598; cv=none; b=DdIBLYUr0djDNkAbRFADc03rk/QVZIq4W437Z1MZp3aUpT4q8S0m4X8oDJLY2yht96QYFPhLINppHMZORkEWK7lKXKZpbejuqdmy/gBduT29vtkniak14LQV5WwygyEQGy/kEkDBF/f5HtbR2n6+SNqbosglZLrUJkyz2siz0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757618598; c=relaxed/simple;
	bh=YAyiKn4hc3cFfsFW0ibD5A1iWi0FrYCHt/eHSSWtkT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFGrU5Re9ND+20z7M1i7mHL1vcaoQ+O3cHNFW1Z2qnVSCmWS2woABYpMNYsy3DLD5IaEP6r7/5V2QCv6ubAeChF7vpkrT3AS5duWJ3w7qnJ4nPpGGUzrciApyW1NI7ErOtQt7Tolf0hC9adJRKROxdNRGC7d/W1C3GZO76wsc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lx3yzrdG; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b02c719a117so195270466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757618595; x=1758223395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zM91c6QWq+uCBsa7ficThVtWW8mqTSnDLUjVjSbKst8=;
        b=Lx3yzrdGCoi72/i5QvvdFsch9zkgnWobGl8NkqZ3YN0pfuooyrG7Zt8vRXmote1d0D
         /Ns22iFfQ/0y+oHhjjpFr9GIthhVbUKMVZcjXTza7/YjTxDK8fOuWk6wjBY/g+GtpZvU
         N9BEuJC1AnY65og2g8nvO9+TFQwY9C4mUcn1rpmxa6yTlpsFcXKbBnwYf3OpWpUR7aFy
         pqgDZe9gcQEW7lEBnHbFO8TDw69G9LSk+0Q6rays2/II1QLDMGOqKPpwGLBWeg0uYlh5
         WLtvhhVJNZAG8vTtzLENApGfWpJw+vQj2d4GgaMScIEHC7f7HjHBV9pP0ggzdpmAC28i
         3Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757618595; x=1758223395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM91c6QWq+uCBsa7ficThVtWW8mqTSnDLUjVjSbKst8=;
        b=aX6lqQvINTT/TvoCmVH3wzdij2yaYn3ROh7rq2XTtUyQUaL2XTuizbe5BuY5xGGbSs
         jJdaE8Lq7tGyZFNBrXipl2Ma1C+H1/ysZA3A15XJ3zvdC2JZMvaGWhVj5ictGPcq9Vax
         xvXWLSqYsxtybvlR/Z9Vd+jbIRewRFSajMBrvO2ooTwXgGNXIwn2VtzaN8hNvyOYGrtw
         SUOBboc+e2UxNbCES+45UsK2SbxKCIk7LEw+KiCrndSEHxFrN+bKxqlf6mvYDcQXAyMI
         /pCtTgTaUKRaTz1wYaaBKd8w4rw78JG9Nh1gLwpddZj/BJUpUmitIOy1LKXjT9upY0qT
         Ljag==
X-Forwarded-Encrypted: i=1; AJvYcCV4GbtKajodTOVH40LzpzSSyZxVRTnVVjbSJDVOj2CCUozFwVZ6GG/IjPDGX3OJ9HTUwlvNF/Z5WECA+Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzw2kNL11Xh41uJoNBF4PRBiY2Z17zhW+QZfSq7Qi7Vq/Im0ly
	ZzIIwCeITDh+tjIEupOxkzrQurowWu0KSOVRnwUzrdNFHIbZ/NixE8TpmT2kQLASiSE=
X-Gm-Gg: ASbGncsoAYDb50wJuHLBepkEbd7eiVRWDuzxrYv1Dn9T73XKQhJxgQsnnWslnq0B/gq
	jEQOLt68NW97hexA63nW7LpQksUShXqRzXd1dIyT8NF/Eu1fZSnyGOmZkG9xa287mOL3fJ+yMA5
	erHH+w+n0ChyH89NhHrKKR/Fn4TfUAI0TOHrjecYs3GmHElYsEm8vXxWK3ZKcBPDzPa+pnWVpkM
	mzYYQ9L2hyJ9p5X997SqsCXFKmKmaUaLkL7My9tlOoKSQ6VAWL0E71Mxi061idy3bUwdTbSBOwJ
	Nwci5Kf1Hd5bkL8YSPXOWAugBGOe5Nt7AIgKGEpSowzp39x9+ywWiTEaFeCRTcFux3il1BAcoEr
	3NdyQ5DtfTtmPlI4X/GXaleVv05Cz+5BLTsLo5RB21UA=
X-Google-Smtp-Source: AGHT+IECaXwRM7NEFU9UXMz2KM3uolbigIYa2qikVU5WTNFMXu3OXk1MTKht0h45Aq3L7wjr13QJBg==
X-Received: by 2002:a17:907:9694:b0:b04:6973:1ee9 with SMTP id a640c23a62f3a-b07c3570af8mr28774366b.16.1757618595297;
        Thu, 11 Sep 2025 12:23:15 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:bca5:53d3:be14:7516])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3347a4fsm187595466b.103.2025.09.11.12.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:23:14 -0700 (PDT)
Date: Thu, 11 Sep 2025 21:23:09 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Trilok Soni <quic_tsoni@quicinc.com>
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
Subject: Re: [PATCH 0/4] arm64: dts: qcom: x1e80100: Add IRIS video codec
Message-ID: <aMMg7OC_OgfK8X31@linaro.org>
References: <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
 <6a7bc6b1-7eb6-40a4-82bf-c547b4c07b51@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7bc6b1-7eb6-40a4-82bf-c547b4c07b51@quicinc.com>

On Thu, Sep 11, 2025 at 12:02:54PM -0700, Trilok Soni wrote:
> On 9/11/2025 11:38 AM, Stephan Gerhold wrote:
> > Add the necessary definitions to enable the IRIS video codec for
> > accelerated video decoding on the X1E CRD and Lenovo ThinkPad T14s. The
> > additions are largely copied as-is from sm8550.dtsi with some minor changes
> > necessary for X1E.
> > 
> > The PAS interface used to boot the IRIS firmware is not functional in EL2.
> 
> Just to confirm my understanding of above statement. The patches below
> works w/ the Gunyah and Linux running at NS-EL1 and "not functional in
> EL2" means Video working w/ the KVM Hypervisor on X1E right? 
> 

Yes, the patches enable video acceleration when running Linux with
Gunyah as usual. I added an extra patch to disable IRIS when running
with KVM, because my patches would introduce regressions otherwise.

The old Venus driver does support starting the video firmware when
running without Gunyah (for KVM on the Chrome platforms). The same code
works for KVM on X1E, so we could easily enable it once there is a
solution for the describing the video-firmware IOMMU in the device tree.
Mukesh is working on solving that for SA8775p [1].

[1]: https://lore.kernel.org/linux-arm-msm/20250819165447.4149674-12-mukesh.ojha@oss.qualcomm.com/

Thanks,
Stephan

