Return-Path: <linux-kernel+bounces-863099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA872BF7033
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D93E505E07
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAF6259CB3;
	Tue, 21 Oct 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="swMALA0N"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75875283C83
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056213; cv=none; b=Hw982seLROjwzgdeOsQHGrYzJWCEG/425h5kWYbJN5oYRbEzubcfQ5shNcRQJTM+pEEcKE9vjPuBqXOGLtCS9NkNpZEAJvKwIRQf8wOhP32tKKrPm462vsj8QUP6oScjBi6AAQ31Vvmd9lAx2zr+QMrwj0aMdTNRNIrYIveBiHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056213; c=relaxed/simple;
	bh=IXEiCfbFjHb0RagvMealrW5WYbDtUPRtCtvcvlM/5gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DH4sRGI6cd7p4NtAqD/SJyaJpb6MYQzDkh21WrORKgp2OAxvmVGy3bdCGAKJ7wfe3lu7doN5fvbF+CdyVJRat6r9oBrDNzc60hF0jci4w/woV+3hEQg1OYh8utkx3LtHV7Ny7DVU7RGk1iZo+UmNj95Hfz7cDy2qVO+kVLbagTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=swMALA0N; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46b303f755aso60340055e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761056210; x=1761661010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GH+Au8Z65JXGAtAPh2UGeuug8ILOECULe8PKQvQu4p0=;
        b=swMALA0Nc5IAGifCsrRdM8Nz4I01OyKEM5Q2not0A7YbgdErVuM2masPp49SU3fEAB
         aMK6tLB3YgpEUYvKZKRQZyRLaRn01+2pPZXxN0tCFCSHZYFT2+K7o+YbPI5ebmwaePyV
         xs/sxb5xvFD4hJ1n36JCfxD2pWBHRow6y2hIvr7Nxm78fYHLG7s0sr/MSIof1hnGzmfq
         FM3qe/ovwqqJ3o4xrr0FYevBJBS53ZeD1pqrhby6bDLcIdg+T4VzaWrqgHFLU/FA3uzq
         9nJbN5cISXts2mAcx977yriB+IYNSj/4BxMQyku5mLMarviGBD0/oWBJJtce5f0FBpjB
         g5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761056210; x=1761661010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH+Au8Z65JXGAtAPh2UGeuug8ILOECULe8PKQvQu4p0=;
        b=DsWEc7VtbnykvskFzltHirPHiqV9d1rzq1MYYORxjQYoBwUYNyZw1bRFFF1mPXlVN3
         5c//URiLOosWa9F9yMHbz9f47TCyURfkHOPChOSFmG2RuF3r7C11YpNLizRw8Q3RKRTg
         eaMOGcLQSqTD41gBJQPJj0A309+mCi/1Jp24qA1VN7xgZy1qbGXSXRltTdpJsKiCkjXr
         TM4KHPA+/f6saMUpZ5NFeappVmKWT2FBJIagbsnAsXcrgEFglvoyVBOtXNx2tRU3W9PX
         SCCRuFoRBBREQOd01Ugxr0L0qv2ca+UvSN0D5uv2RyMSnMwbGtHW/VI6/SDrw/H53o7z
         jlfA==
X-Forwarded-Encrypted: i=1; AJvYcCXDSjuK/0oeC98abBibRNjllldbI9UDNhXBzj72ClsFZykHdbogrEeKW8glC22mrbaUFWJw4IIg8vr4k5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz7tKFT0DVc0WrB4NMW8Ewx0Im69Qoq/XtYq4pmQwDw2hLxMTa
	RYqNMqk012LoeIuKlinfLO7PKQIkYvdvjDCy/URQ4UyY+A+Tdj+rZQlAmxz50Ot9qv4=
X-Gm-Gg: ASbGncuJ+5jKUJv3EElrBmC9/QQ9X314KTRVirIKVFbf+fPdgDWZkODvpmKSH9aTULu
	6q2leCQDxFX4Ui3+J/oguKGHaR+QLwFmSzM5914AOpkf0o8YWE7U9sqFTtfTjtdPE/pu5RpUSvx
	N0b2nlpE6XqEWXVuXMmUTPWIykpUlw9UhSwcuz2aINKpFL17JDglLvHiYwzwjFaoBVh17ED3ShU
	PuvqYq06y2no4Fa98D3MbYdu3+kwsADZJKys9TU6zWrcUdJ6ZHYXcw3SKgEur7LiHOtOvKUecpJ
	bXh7mUBxrWJ9bZdqhsr6768atgcpRBJn8ZTfVItcl5AwcXLiv0h1z2ytS0uJlJrSakOBGQc7xOq
	wJcFYjemjpDZTesQJVZX1CWlKhhjW8kwjeE4E5gIR/nVCPLHsQOOYWhgAMq4VavfNh9GCd1Ag
X-Google-Smtp-Source: AGHT+IGlCzAGBWO2jDwO8KOdW9RPFbusOV38zy/UqpC4nz4HnuMn3sNj6s9XMr9He0B2eairZT1Tyw==
X-Received: by 2002:a05:600c:818d:b0:46e:394b:49b7 with SMTP id 5b1f17b1804b1-4711791fed6mr135325295e9.37.1761056209687;
        Tue, 21 Oct 2025 07:16:49 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a9a9sm21138244f8f.29.2025.10.21.07.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:16:48 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:16:46 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e78100-t14s: Add audio playback
 over DisplayPort
Message-ID: <honsqyec45rg4yrh3rwjlqlhcqyatbbsvnhamhjdin3tgaggzc@5yrxw5mwhkni>
References: <20251021111050.28554-3-krzysztof.kozlowski@linaro.org>
 <20251021111050.28554-4-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021111050.28554-4-krzysztof.kozlowski@linaro.org>

On 25-10-21 13:10:52, Krzysztof Kozlowski wrote:
> Add necessary DAI links and DAI name prefixes to enable audio playback
> over USB/DisplayPort and HDMI.  The HDMI port is not yet enabled, but it
> should carry respective DAI name prefix regardless.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

