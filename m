Return-Path: <linux-kernel+bounces-843965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49529BC0B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 854654F501A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CBA2E1C54;
	Tue,  7 Oct 2025 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gznl10my"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4D12D8365
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826056; cv=none; b=KGlcH1iAkmc5qDDLF6n7NWEt9q6BFlh60NUMxsK3efPiZtsTarwYUVUZnZK0AFg9XIY6OQQBAGD37q9OpfPRyvw7CtcsV3iIAVKgr8EDzkKyuGZTPl+uJlo9LxNkig6IOS2iphncGRWWeAlXb3K88NgdV5IXhESsH8o6q3I+oxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826056; c=relaxed/simple;
	bh=hnCPQFDJioFXFqwrcNntVGijjFsq5IgSQsQaRCg8dks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iucp3nH87lgSNy5ONXHWhoktEQBC+ic97agLHin1fwfWINYNqonUvQ6WzZEAF6kh0SEmD3EH7PUIydtsK4KQZvYQKlRqag2I0jf6rr0iJxnhavxyAzsudJM1hafjTf/Hh6yVYcLwGxwT3QdybOjCO18yhB0ZCVBd/sSGD7goRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gznl10my; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46b303f755aso45676745e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759826052; x=1760430852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QiLtkw4r+z3ELHzrkww79sYrVN4+kJqV9+CE0aX/r8k=;
        b=Gznl10myooEzq6wPdYbpIgHXK0odaCTNYIKa/UILeJNvFcbdqfxcisLhmRfcfKuOv1
         AByn817tiHfMfr7iGn0vpMzfQqycJ+JHUtPUdgBOqmlPVtUGSnLdZhkZ7aRd7+g0M1CG
         8qb98PRYsvMNbEA6JUM6REunxggElAQUVfjbzqJbiIt3xwmhQWVZexZ9VmXjlLLJFQs/
         fEmAhV+39s5ItYWp4K3G8G2rR5nnpBMgkFtVR179MiCSnu8nZmRn2I/3/PXuhZi2FfVf
         8KefWav68CwdkLTRlteoSRXQaHghVBtbYGpA6mORLMeIis6EsXMZ4Imeyz5Qs/rxeOhH
         tXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826052; x=1760430852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiLtkw4r+z3ELHzrkww79sYrVN4+kJqV9+CE0aX/r8k=;
        b=AAy+AyLeRgWnm6jQG4JlpMyfhpOr4ht+7ILi7bUaadDynKlN8c+l1z9j0lXe5yAa+3
         Ru9bVivjf58i5GOXOCQCpkSTUujY3cm5fwbDa2NCqFKo6GByGvqcLi9LynMZYorByEQG
         7j3jyf+5oboZvxoqdBi5hwgl4Tz6jEsv7Py+luJ5m2KjQPcpjUSs83Ukj96fPOOTuz4g
         4uSeJREXFX7iAI9FUCKirJLAz4M0HU9fBnlrgcSO7PJ05g40zvb2BUO/EH7SyUsvPtdO
         J97DUESYA7SuflIiW4LnKsR2X9hv7s71wLeC4ieiwv2N44AWyUPNQv38gbqjLt+8WTgc
         tB6w==
X-Forwarded-Encrypted: i=1; AJvYcCVyVel+YB0ve0fu5GcR4voitsqZO4gmxaKOZPfmNgr9BSwNS0H5i7j4DvxSrKDM8bW8RNEyjqBXfNGJm7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1tx61cypajSYMQIBzIFTy82gIIff2c/GERcyHBAHfKqLAzT8R
	TlDYgcCWB+kWHh0Nui5Wx+jVe6swTklk466mY11E9sADL627Ius9Yb/LT9tCTzZ7TB0=
X-Gm-Gg: ASbGncsvk1x9HZ2CNL4DReogKBDu6mBn0+jIPq6qDG1iITdhQhv53hpInWMBlVQUuGs
	Wc49En0SaRpYZyfazjySnKGX0DfmDjTOADM/VuCbvmG+oWJvSLtaRqk0hqKJVBpV+ujNkVKT2ZX
	ObeV8Vri6SpupJn9p9unJlHY/XMtukdbrEJIbHp1jPYHOtAfHiqPmqnAMvT7hEJkJSDKtJAC7XE
	ath0YyZhtDS/qq/0/3ZS6jcIY/l9ghGC4ZUuRa8m1f4E/BtPwx0qWyMSiyaZjjcKpPj2ygIXoGC
	abAITB81BL4NrkOdvK2DyKFN7KAyHrkQtnoUFgEQu5opi7M6MlP1O91I5axHSq8CsiUImp9NZuT
	nlLwHdPjRvZIggeiWYvWKk1B03cI2BqWlSpjPpjsge47x0tA=
X-Google-Smtp-Source: AGHT+IHzRBYvsifqIJW6l/DvFTb1GpI73cPAH1fs6Lrdh2C0kde6p/0HuIOkdP0J3Z8Xj3L4jdedOg==
X-Received: by 2002:a05:6000:2210:b0:3ee:114f:f89f with SMTP id ffacd0b85a97d-4256714faf6mr10470825f8f.15.1759826052003;
        Tue, 07 Oct 2025 01:34:12 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e960asm24204750f8f.37.2025.10.07.01.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:34:11 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:34:09 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Wesley Cheng <wesley.cheng@oss.qualcomm.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bryan O'Donoghue <bod@kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: x1e80100: Extend the gcc input
 clock list
Message-ID: <dz4rjtwdl6gqhn6g5prqvnifrgortzgjpwatbpf3n7kn22tniz@yjteyofk2gtr>
References: <20251003-topic-hamoa_gcc_usb4-v2-0-61d27a14ee65@oss.qualcomm.com>
 <20251003-topic-hamoa_gcc_usb4-v2-3-61d27a14ee65@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003-topic-hamoa_gcc_usb4-v2-3-61d27a14ee65@oss.qualcomm.com>

On 25-10-03 20:14:40, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> With the recent dt-bindings update, the missing USB4 clocks have been
> added.
> 
> Extend the existing list to make sure the DT contains the expected
> amount of 'clocks' entries.
> 
> Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

