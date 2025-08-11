Return-Path: <linux-kernel+bounces-762193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D8B2032D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667B73A9081
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B56E2BB1D;
	Mon, 11 Aug 2025 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnXipBWe"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5962036FA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904127; cv=none; b=Q28oVYGSzTcT2D2ClXt6tVeuSbbRBvCju8aCZo+Ay3kCLGT+yx0hOFE0pjXPUJMFUE+vS3CpxTjVNRcP33OelLOCBOGA06pllLH+ktJtTMwE7ybGdKUtKWdu0FIw8cNW1S3Z2EckBjz872wVC2ZvI0ScXLzCydORjkW4W1wCkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904127; c=relaxed/simple;
	bh=K/zPVqxGg7tPN+JbH7RDbuwnwSJKsZfgYcJ/y4119IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d54BXbaPqfQhwXQU5ND0f6DkzvMppGKU3ecwVY2jWv083/Yqnu1fJGYdW1V3VsQHrKFZrDraWYPnQKOcRT6mgW5iEma7loSX40QdDHlOz380+jFD6/M4igKGnSQZcjTCSoWeR7my3BR8ifIgTMAFNfimtxk33xaFlcUkf+ApZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PnXipBWe; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso3374619b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754904125; x=1755508925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n44ROEDa3iRmjIj2E/S0tuIP2QaLePXT+HAKtrIXfuc=;
        b=PnXipBWeA2oYugnfcYMhifxpADIJqd+BzdtR/6Btms/qY7WjTCaCaTLicn36cZCZtp
         SL6URDZief23E7YUR2GB9QKopMU7aWlVEWBTPLRVDszIDU04d90n0khK4r3RysZWVTdv
         H2CrOc2bByNGC7n8+yVXXoemyInOdZCrLLzUbvOIse1HYoo7tuM/MQbhg4fY2AM1ZLTU
         c956F3p8roLky8nVAD6fRssdntkdUilIWe6SJdiI0xPJGXFr0I1X/Twi7B+vT2y9tpdE
         8Dvcl3sFEQur2SELjc8TBmyoY7NaCN1B+yBYuEWtZ84oCSW0PgNsMTxsknebkW+H0Nyt
         OcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904125; x=1755508925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n44ROEDa3iRmjIj2E/S0tuIP2QaLePXT+HAKtrIXfuc=;
        b=qXEVSzYnJjrwNfSPvz4kBqp+BuJ8ztI7qzi22uHHTslRjiTC8ot0Ld6THF+GgSp4uH
         GzeczX+JKhduHtxYEW4R68NyNe7q11jn6RJAguq0ZF/+QEwPc7qa/J50uHX5pR3ncdhL
         5JwruVTS/0OM4N0Vh+y2tNyuPJXvcwqiMNbPetmR3iT1DCXclreTodlTz48yth/QMgnS
         a4/uU/tSBzxc2Zu3KDhP0YdsHNc++iK2SPMzucI5bjw9OkPGr1xkZkpvvjR5hnA7zZzI
         wq/G/jMnHuHpKhQ1KKEW5k36a0WbJTMmO7yFBaf9wKnX4ZbLhMHB/1EUPGMotayEICUP
         2xTA==
X-Forwarded-Encrypted: i=1; AJvYcCXgA3tqPkYYhsqBBCjPEgwDpSbSDcY9ePS3V5Rya+GzfaFKngoHzd0QSy1hwEPQ3qjJELBT9aNo1vIM57g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPw/5XtPc7/j7GcC+rM6Y4sWmOK1pQqJFiQhzZ+1xKDh6vDRcu
	9tNQKU/EYBRNOwWE2NZ60DWPOPCL4F+I8ZIN9Hmw1EGa7zvhEGnAZcdf6YuVp94DDoE=
X-Gm-Gg: ASbGncsol0f2MF9mus3rX2p263d7Le393Ktrh77r1hfs2MlZOYoR26EdmjEk916kJyX
	NTC/hwbrF/Cf+6WR/T6sCn7CCkDT8NH5mioEW03+fzcrRr/RmeaL9FBf3vYtcpX/AB4ifBpNJQP
	PinYoDXKFSbWG4wnf8Ntny4snJVqe3aKbjK9AEwgsvkrIKITjftl31IRUY/leu04aP3+VMLS6A+
	iUryddQW4Q2QVzY7jDNsi9VW3wwukZcxYr1YH02XsA3IAR/EOYcEYD2dQyUZMIdQObT/eqKuODY
	/KEtziWjnbNlvRJqt0aSOZ6xxCsWqstFZ66QMKENXssXuHdGw9WzRlhpAqbJXphoXRE2FfAFVA3
	HCdvClbM6SACtLBqpfvpALZkQ
X-Google-Smtp-Source: AGHT+IEY0nvgGQRFqL9yezJOvWADh1/cHUUmKJ7QswLrUeIJdU75UuZ8LO0U21sJdWveXkp3OX6rWA==
X-Received: by 2002:a05:6a21:32a3:b0:23d:de52:a5f0 with SMTP id adf61e73a8af0-24055204322mr19749640637.42.1754904125252;
        Mon, 11 Aug 2025 02:22:05 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f5035sm20840763a12.39.2025.08.11.02.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:22:04 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:52:02 +0530
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
Message-ID: <20250811092202.auarwnyoagebcw3o@vireshk-i7>
References: <20250811090954.2854440-1-quic_varada@quicinc.com>
 <20250811090954.2854440-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811090954.2854440-4-quic_varada@quicinc.com>

On 11-08-25, 14:39, Varadarajan Narayanan wrote:
> From: Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> IPQ5424 have different OPPs available for the CPU based on
> SoC variant. This can be determined through use of an eFuse
> register present in the silicon.
> 
> Added support for ipq5424 on nvmem driver which helps to
> determine OPPs at runtime based on the eFuse register which
> has the CPU frequency limits. opp-supported-hw dt binding
> can be used to indicate the available OPPs for each limit.
> 
> nvmem driver also creates the "cpufreq-dt" platform_device after
> passing the version matching data to the OPP framework so that the
> cpufreq-dt handles the actual cpufreq implementation.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> [ Changed '!=' based check to '==' based check ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v5: Add 'Acked-by: Viresh Kumar'
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 5 +++++
>  2 files changed, 6 insertions(+)

You should have dropped this one now, as I already applied the
previous version.

-- 
viresh

