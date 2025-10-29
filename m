Return-Path: <linux-kernel+bounces-875374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50993C18D21
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC023A8F14
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1663112C2;
	Wed, 29 Oct 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVeTIoLH"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024B3112B4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724701; cv=none; b=MAT2pcqJvD/p12/ge1oEjkMl/gVh96T+isjEjBnH+19M5TR00Ai+W1lXYhO2etYjI5vFhF/e7euZiAmxDTBxiUpcYRsIxrvQNhyH5Wq0tOciEhdwCOU248QXi231XdJfpwW4XNQNaD6PhMrg6zm/YjLUqxmS1PTTQNTJQ7vR+uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724701; c=relaxed/simple;
	bh=3/XHVuDU9ygfhagugXWaLoGazAfM6ug/NwQjbm2ArFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss06kEDb7FOQhi1pkRzmxkR2lGkfeOnI0LynwI5oSvsYqVZ+7f1jv+XKfFCcG/XFzmMoU+3SfwU4bbiQnN1aSUv8COjXTzDVt438Vdlui7UXcJi2yl86ybEoOeqxXfoKWipnLfeUC5dMjhST5vT8h37/DNZNvilxcGd0sjFy86c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nVeTIoLH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4298a028de6so399343f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761724696; x=1762329496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5RvgAgnj2z+3qcsz0KMHzZJuf9kq+SifHN2KZ1y88M=;
        b=nVeTIoLHSAce6qkObqBYPia7rWaLG/9NmvT5YtBnD6Nfj4i87Bb9VAU+VFfgGWCP9e
         UUonWP8JyEzdrqqt+5WphBwe++e2voP7OnXuaAhFQD4n5iGq7ax/fJikMr117QzGrkRQ
         Bk0JYW0sCDgzLGXFewwyQpit1izPamNgiga+Plu3H37qHpv9sJ1v43CkozpC6gn5W/lb
         ONkDmVcaBNkuqmT1sXpFBPdAf5fMdwHwCoePXDIgheWrzkGeUHT+NfRXnrhReFoP9Q1U
         LkXkElVAHOJf+EP4iyvBw4b1/N5/6NTn6ur9374Ev3SRKX4SbQmI2LiME0rz8MMLtyK4
         CDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724696; x=1762329496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5RvgAgnj2z+3qcsz0KMHzZJuf9kq+SifHN2KZ1y88M=;
        b=d2BxdewCL84xcFIJMXqJzzLoimSk9DrqyM4yGkhdP3EDMSoMFhQtsIACGzhxMBliUc
         qx/PXRogyuwRyV8j/UMwyTpa+xFCu7XP0/vsU6klzrE0b7Hehw8bSeX+PmCy8yWaXBRn
         /E5EX6zMIrTVXNHJZ1+ijs9SUgSmcMtulZ9blAP5DUY69cvIIywxFhWe9SesG2dNevG0
         Z/qMdH06r0hrlZbJvmXM1x6PpKv/qI67dFnyGENuLv6ZmwNRgh+/bIv3JNmW8H36n80g
         SjRX865ht70Zuw3/OcsYCsDuPWckf+oN0eMdvKo+uaQZ85OwtX/DuJgC0SUcLTimqWTO
         ukXg==
X-Forwarded-Encrypted: i=1; AJvYcCWjbS3pgF7EFshIct+/WpKDlZnryVQfmpqgoh4bmU4WKVnXqs73KNCkCPO2pTKFP74eNxdRcP57vUBM1H4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Qy4Jb1eYdsIeNFjfmTdgfmajxRtdwm9C3fZczV+TqB2LbypO
	I+CYO3rG6IcdvPiTWj0WKwVWhRVMlE2jGYqO0UH/8DdhZu7SwP/QjgcOLmf6YTfjUIk=
X-Gm-Gg: ASbGncusIREpfjYe+uMBcZoh6EQnyF74IYwFqBRNsULUqJAZ7507/TGQj1F/YwwMX6S
	xlnRJJgFRaPS2FNDRjJ2fsgbIx981pyqferXSN9MmVw7SETO912sznj5QUkwvS4n4Igaw52Z12w
	Jhtl2SWo/+C5L0v/6zZWcj7/KH0VJkKLMgHbNdMhsu/BE9gztFvwxz0Dvd8D+jRyp9c4eu6MLFN
	UI8hcOjyHNpIvW0uAYVQ536dUtKE9917yZRsGhpTSJFewu+hRhW+wvp50Zs4zfZdUafgpiuMlL+
	t5gEQyrqyOo/dev20P9hObsrLgHpwwzaAPxvdcqGy7usVPd1ra2lR2/fw+tWOHeUsAxdGGlMGiG
	dsukgFO2wRCzGAkSSlLs6hYaZgX1hoTxjLbC6YSu2BpAndjt/ihhkLSeaO/nMdLv3hqvGVTBB
X-Google-Smtp-Source: AGHT+IEPacXyIK1oaQfJqI0S2ywuOclTL8n8/3bmtpUnpCVVdges7BMfqcF1DOHNcmn+v2OO3NF+Uw==
X-Received: by 2002:a05:6000:41ea:b0:429:b21e:49c3 with SMTP id ffacd0b85a97d-429b21e4b58mr619629f8f.26.1761724695918;
        Wed, 29 Oct 2025 00:58:15 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db9d1sm24491585f8f.35.2025.10.29.00.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:58:15 -0700 (PDT)
Date: Wed, 29 Oct 2025 09:58:13 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jessica Zhang <jesszhan@quicinc.com>, Abhinav Kumar <abhinavk@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC/WIP 1/4] arm64: dts: qcom: sm8750: Add display (MDSS)
 with Display CC
Message-ID: <luq3ffklrwezh7kyf25sbwc5arbbnypkwj3mdcb5wxs55g4ip4@4haj4s7oahuv>
References: <20250424-sm8750-display-dts-v1-0-6fb22ca95f38@linaro.org>
 <20250424-sm8750-display-dts-v1-1-6fb22ca95f38@linaro.org>
 <nwyrhupbrqrh6q5yvk6egtm3whi5h6xslhzio4g7f7l7yjx7c3@atl4bbk5f4vb>
 <f2117bbe-89d4-49a8-9e5f-5dc975f9bc13@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2117bbe-89d4-49a8-9e5f-5dc975f9bc13@linaro.org>

On 25-10-29 08:45:09, Krzysztof Kozlowski wrote:
> On 29/10/2025 08:40, Abel Vesa wrote:
> > On 25-04-24 15:04:25, Krzysztof Kozlowski wrote:
> 
> That's April

Fair enough.

There is no newer version though, is there?

> 
> ...
> 
> >> +
> >> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> >> +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> >> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> >> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> >> +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> > 
> > No PIXEL1_CLK ?
> Why are you reviewing this one?

Yeah, I should definitely ignore this version.

Thanks.

