Return-Path: <linux-kernel+bounces-762260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE446B20429
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFBD3BC1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3478B2DFA34;
	Mon, 11 Aug 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrwLBJ6q"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E532DF3D1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905498; cv=none; b=WwFnf9hjxHt2888u06S3NQWcB++eeMA6AQx1jp+wPfegpZNZqxngUSUpFCECevrHXFhIUXFJx7YkbNSRhrA2++dDWaXjoSiVpwagYyL4dtWsCE4sCEL8ViPSsVDMPgME0Ev3vMTfRGYxiUBgXJ5rA1Mdcy3F4bMIDZ8MWD36WqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905498; c=relaxed/simple;
	bh=oOOiZ1lqQ3eCOyBC4RUT7MgiecSXIg9A00t08CokTII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsdnddwmwGgc/In8NpyPXN/11WmmLM7av6IIwyXpnif21RGFNQDAyTNE/ZZ75ZLp7LijzfRy//Rw4FaO3HRmsRoAHDfps3CFN/kyyAwB0RTzpA67C/3LEaVeHkEhdQHFYOtMjwTUBi2cEBMVK7P004nm+cy2LKpuN0hIhW4S7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZrwLBJ6q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-769a21bd4d5so3763625b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754905496; x=1755510296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nCoqLwhb4uI1eEgHGHZ1KDRkXmPyMcyy/GtcB68Vpww=;
        b=ZrwLBJ6q7CR54OXI8khFF0A7T9EvvhJqm8bNzTCmHhQxhB5I1RzlII0tr4ntCdXqOT
         AT3/NaTk2MlnB74BaNkVEA3J8v49Q3ArhLAWPIflcd+ddvRHrRNz+22Jeevrqm4No3dl
         //huOxbZ/ZiD0I5pw4ta9kNgVzjXecgTs9qVtdS2KLgEYlEvzghBIIUFTSWkpIeJvxaq
         ZmbMfJP3FAwZBKnCSpM22CpmdTngGgwWyEcLO3BflUjc+X5mAo81X3NAUPK8G5s0IK4S
         ObSN8QVW5oJuJ3tVHCpkeCRJEbs/7AWiGDQM4kGrlLIxUWCdItro3L8dOg3Hy/1021F4
         GXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754905496; x=1755510296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCoqLwhb4uI1eEgHGHZ1KDRkXmPyMcyy/GtcB68Vpww=;
        b=SVgXrjw3SKd0GrPBLilXU4PdPcnaq7OlXySAdgpjbKGgrmTblI91mnI0VneW2gqEdV
         Qx4X2fzXqJNZ8/vm9Kk9cf5KgHOyPR6PE92znfvIc0KuzL1EnOlHHkukhpkvRgxYkPU1
         S7IXReS4DFKFzCXJUjgYh0w+H8BkNwBMlRfrW5aTjA3Imyh6Yw53IYABGd+JDiBp/DIY
         LnB8aEjQrj263dyU4C18UgGF1lCffKA/3un/zTkogsd5DwCCBFO7HI+2unE8snhotm3P
         sjkjdmyU3QJltFeKvkTEj1bUwF8CXf7oDtT6xzaRR0jfmzuEX3DtsvXMb+KKZTgYtg0F
         M1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS6ZCOPAlvNjm1NzhRQtIVCrlfwKk1/Gcxhtq4w29tCV89/mHwR+66fv1t1/LNnlaTvt91W1CtCtcpEyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm8xpVcXlIAedZ/BckWZq8BJAkT4r/tLQ0TEj2m6MhHZZJllIi
	w4hure/5DkdUKjkoTuGAN/HQwBvdAvjQz/7NbP/94NUwPD5SwIH/+lTBEOKxZjlPX90=
X-Gm-Gg: ASbGncuqe7VZOi5WJeka9g5d9WQr5RwgMjHPgxCV8NPc/1GYcVslHO8Yr27tZbbmKXD
	i2HS7VlGSjHFp+7XtLBqeiWDKi7IJLfPjHKO60LTpMbhplSxL0w1YwTIDaTzDLilPaBzGqg5JWm
	nCYpAlns6zgKMnvzXl1P5lWAowctZoMgJQ8G2vmile/tH3oEZgqdKSHZOIxv+Gy1OAe4rEkg6zW
	G24M7UZXTerCwsl+laBv1g5AA+YvQWF7DypAKDUEeq9eoR/awlUlLrCD7kidn6FB2dJ+Mtir0UM
	uNVSCMhBNmdk/+x/CC50D1F4ijjA+cbay/9YZIAXsafojJlJEFTTjRZl9qS/yX0LMyX8G57XL4t
	S+wdqoJmJRTRbjb5knZ1R0byq
X-Google-Smtp-Source: AGHT+IHx6GR2e/+tS4c7qDRjnWjAYpd+pizXL7vvtruA+7iTSso7twvaaA2D0cifsUCnt3e92ef/zA==
X-Received: by 2002:a17:903:292:b0:234:f4da:7eed with SMTP id d9443c01a7336-242c222bf2fmr179458745ad.44.1754905496369;
        Mon, 11 Aug 2025 02:44:56 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102a559bdsm15486233a91.1.2025.08.11.02.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:44:55 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:14:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	konradybcio@kernel.org, rafael@kernel.org, ilia.lin@kernel.org,
	djakov@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v7 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
Message-ID: <20250811094453.qvlpwwpmkpdyauzu@vireshk-i7>
References: <20250811090954.2854440-1-quic_varada@quicinc.com>
 <20250811090954.2854440-4-quic_varada@quicinc.com>
 <20250811092202.auarwnyoagebcw3o@vireshk-i7>
 <aJm6ixlMamgX/+bV@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJm6ixlMamgX/+bV@hu-varada-blr.qualcomm.com>

On 11-08-25, 15:10, Varadarajan Narayanan wrote:
> Sorry. Should I send a v8 with this dropped or is it okay?

No need of a resend for now.

-- 
viresh

