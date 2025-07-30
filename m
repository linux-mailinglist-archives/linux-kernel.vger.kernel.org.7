Return-Path: <linux-kernel+bounces-750380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4502B15AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADF118C17AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C72290BAB;
	Wed, 30 Jul 2025 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJIXC2ee"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8A2641F9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864138; cv=none; b=WOWuOG/vZNNc0Evg6iS2vxnz+hWwMVuHXVItE53D1t/DY1qWM7iKpQzlU1hpxYgARc4zSKr7Xlsr/OLXluXtNBlwBq7J3l0PknwbM/uaWVAM+qif6VA9wU7kc/WvXSmIrv2ph1qowAwpJamPQ/6kODgW5JC/+nyN5rX0rJa4Rg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864138; c=relaxed/simple;
	bh=1r0lsiP6NFGnYsSI+kcsYV+APIoQCHOYgWvbuEVB5cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLjyxdtXI9ujUQI4b90ZwRPHW0ps1m0J/4uJsPz9xEyn1tUwn+LYt3+tFV3BOPJDS949lsKi9roEQ4YALEWsqvWrktjUMspPFYe0AtO6QNGxDisJ8KJdjm2DELXrPEXh1r+jrEn+VxE1PAdEwp8w2bUVQCY05ErvRae9qazXb5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AJIXC2ee; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso1117526b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864136; x=1754468936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YerKRYt4LpxD7mnuz6omSbAb88Gr2Tk54H8CGOtbvNE=;
        b=AJIXC2ee0SLyJg4Q7rmt/K04rQ/yuITaF6KL8bseDIpuRbI2W0d/3ixxVAOHw8xEdW
         YWBMFkxY87FCAzPgaGwOZjnPZVlnQ74f7sY1k4vs4IJs9xTYHwwAdSIQNW8ZDofma8vk
         vYQlSo10TV+y0NGravTM/AaBE01YQliLDXahIrVn9dhrgeBF+HXmNokTJmDeg6HulHDI
         0Ni1OfVCFC7S990O7phwaibR6bI5zurNwL17z7NJXZ7AtMI7rSmVlxfWunhS+rqTLMDU
         qRviaKbc6rJ72M6nF4fY0vp6zp+HYVHj9bliUBTKu/Jd5+FZgVp8bnMqhM5267E+EQA7
         isuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864136; x=1754468936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YerKRYt4LpxD7mnuz6omSbAb88Gr2Tk54H8CGOtbvNE=;
        b=OYctP7TrgANWF6XWI9+dP9zM5W3qVYxUsCseVm/Aawu3+D/DAZPd7nexMnFLo7f+MJ
         mODKY9nqZtWGZ1n3nyfgcOjFTQF1aCnl67QrLEZWNzTnfKg1cmfFsbupfVi/5C2DXSt9
         J6g1Fr5k27go+sYGRfTmdb6Qt/1YFT96lJ62AOQ37Y5DnpvrvLRn+FTl7Zr4CrC7kC4o
         d0PnG2aHtXl0R9g+nT7z6pjiSi+YZfEMDoOhPon1MypUEj775wVmyB1s8wWFMcMJDIjh
         a3Q3o3sMkkWPqkdDdyFF4bREapK5GKFHc6g25d7wHIaofgvRA04A5MLdKRLrPM9ht8Sj
         LVgw==
X-Forwarded-Encrypted: i=1; AJvYcCXiAZrKwsYQiJ88brYbSkqFluUdSwr+5Sg3OzHiKkuqQMscXcqJ55yZ2ckRY9TrbIxLm2W8DRZi++9kBW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzu+NqY/GOwogv1kQSawfiJol4fkdptJdhFy2tjY4ri+wKzOJ9
	26lh6WyOvkrf7h27qE0erfg9OZpjrD+YBXNSDSTnahUbXBRDUQHub6pcEue7ls86tLE=
X-Gm-Gg: ASbGncvGtngmLdx+TtqxUI/Ap1lJLU+LJss3l3Mgd3FZ8SLklHXp8VkTo99cZrFZCRA
	LGOkvRjxsjIY8hJ/3LslyQOxDxvMI11FGwMA3PzO+uwghn3Hy7VMklViWKpoJJIAnN4eq3B385o
	hia1v2s5IZa/EBzVyyh9IzpOd/11OwbPldKIioeU6oOUIszwLwac66/sYlNHmYhPamYeLUV/fpy
	vcE26bcmpbQ/SYYNPdJqjFiBSTrXyrXh7Q5rvqC177I5hjm7gaQvjrW7yimNpgbbti+qdsUrYSe
	BBsrYwSzYP5c2IMi6RP8wCyIB/AQA5HXa27sX0ywY2NNNSlKILUuoT4vl3gIfsXY10LXLEXbkaH
	Jp8P/bTw6Td2SN9/yBnSndLE=
X-Google-Smtp-Source: AGHT+IH0CJhtgQb6pIChZ+X8XZwoN1ESWodJscR6CHa9EpEX0lyC2wpKatW0FkXPKTJsPAVRZjuF7A==
X-Received: by 2002:a05:6a20:9389:b0:232:87d1:fac8 with SMTP id adf61e73a8af0-23dc0eba14bmr4486339637.40.1753864135839;
        Wed, 30 Jul 2025 01:28:55 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76b8d37eee6sm282359b3a.60.2025.07.30.01.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:55 -0700 (PDT)
Date: Wed, 30 Jul 2025 13:58:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	konradybcio@kernel.org, rafael@kernel.org, ilia.lin@kernel.org,
	djakov@kernel.org, quic_srichara@quicinc.com,
	quic_mdalam@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
Message-ID: <20250730082852.oxy3tjjtdrykrzne@vireshk-i7>
References: <20250730081316.547796-1-quic_varada@quicinc.com>
 <20250730081316.547796-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730081316.547796-4-quic_varada@quicinc.com>

On 30-07-25, 13:43, Varadarajan Narayanan wrote:
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
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> [ Changed '!=' based check to '==' based check ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Add Reviewed-by: Konrad
>     Change speed bin check to == instead of !=
> --
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 5 +++++
>  2 files changed, 6 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Lemme know if you want me to pick this one.

-- 
viresh

