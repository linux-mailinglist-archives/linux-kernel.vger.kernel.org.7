Return-Path: <linux-kernel+bounces-761905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52410B1FFCE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4C77A1848
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BE42D94A5;
	Mon, 11 Aug 2025 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZQz9W81"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6853D1F03DE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895719; cv=none; b=qYielSQsvW0TwiVAqLbxCc48owhlzg48hQM+cFBdCnM85t3W3M9qruF0n4Y5Lj2x+HjD+MMdl/RIkEqaxiX2l6R+HQ72O+AZ0EQoKev66e180BOtnep6cWcxmWb9ZSrFPsY2mEoZ7HLf34ktq1W4RWABOEjhXQ52wMJsJY9WbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895719; c=relaxed/simple;
	bh=i5i+o2f+rrl/OAOkHKuvWRjEKuAxEakK5GVIkg3Co6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hggxvVCY6feciS6OvESCwpdS7KREFqy6gljJDxU7UYMgPUl8tcpnjoVhlEzOndL1CbEjTtggUH+5fxoVaaohebYrW82FE1WEZZ29ukrzARx55l7YIXuN8q/jENXi4FAiKRMVKiWD8/DqVjgNALlzdPOGZE/M7VzmpmSlPpc1Htc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SZQz9W81; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24014cd385bso43667945ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895717; x=1755500517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHEw2IHzxA4wFPAA7C102H9OqGdRlerd4Wo31dulLWQ=;
        b=SZQz9W81/mXFsNxJ/m3ywX8jkIBpAonPnoei/q2JpUG5H5shjzuloeEut9f5VOTkSZ
         8HtUlOLiknpX9bxHSZM4vD61gZ+mrCfdAzka1joWQg0DaZ2Y2DJyoRjzzR1YiSlFnf8c
         FFPfVHfyjSWC1TWZbhntRW3MvERT286sVK5rNpwSF4qtlaYsVrFE063JIXP5ioKYeInm
         VvQjWFa8QcGP8pAWKtsn05XqknTOF/UIhkhqsDfxA7JGhgoCWzAJBvXbWmRhX46dR9BD
         FntrFGOsuiSC3CCgKdZxmM+cud8WuLuzGF/7dqphZQnTAQtyR1nOz7Cnrtsbe8IHdPCE
         G6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895717; x=1755500517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHEw2IHzxA4wFPAA7C102H9OqGdRlerd4Wo31dulLWQ=;
        b=Hqen/yj5Gf96FqJhLgdBGssoJTsv/FJJmXpKlj2k1vJf67Adxop78OzDnyJcyUcQKc
         +5biLRTrttdppNoqiKPJIHmCqs9HabdQ8aOHb4kbd6NzdN0NrfoeQQPR9bDVKYCENN/a
         yOAh402+n8omlupyENIFRdzXrHYn82Wn2eyPTGhdazQWZSwPDp1frajzZkIUOZrzmFQF
         stXHeCwhSc3Chgv2XkTUbe7YWsbEjBfHqdDXDpocEcFs4YnYw1rHHXfMAG4WCK5f4DOe
         ZsVFJG0sZNGXtIdAPbrZ8MVe+TitXPQzGZ5v0lZn+oQhMr8euUGe3XM1qHmoUOs4K8Wo
         u7RA==
X-Forwarded-Encrypted: i=1; AJvYcCUqyZmyKnXVWLWRffjYuRWClMJSu6L5q8wrYNfUTvwIc++UGoaV5GwqJDSa6GBRS3kntHkf+IPzAo5QQI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyeUWLDntJcpwMVhImT6J988/Gx/XU1JfmWk6J2ya19GY4ZBgX
	x4W8Kdh2A4fyWbMb3whu0ov/xhog4I/aqlbDFSF6/bXtvi4hXQHbf59EQK+RCg73k9g=
X-Gm-Gg: ASbGncsn7+sNiqVzWLez/VmUjwWPs1YIiqpaquPT1ug6HxIi7LFdwjoPw68GgiVT3DO
	GBhFdlO8bXT/5U1WOmPDErDYa3V/HWeXXdSRYCDq5uPSbTqkSIgcI88jARhHTDdwbbYnTiR0bjJ
	UDZ6YtHGwmndKVN2+4BSoTV8ywHMm9JMdo9pFQQ3wEg5A4FZyPlXapay6gakRCJj80n2Rr1iFB9
	0WrNJ0pl1UZT/FcOqsau5n6DJ9BjJ11YwEgYkJb3c1RmXI5JsPIkJpIXDPfBiODulNR4bI9ovos
	vLaeCiDpFxCpbz/Soiv9dviXyZ98fttLi/hH94uHx8xK0e0G160Ip3ygB+NEke+esz0KSxvfpoT
	HK6wwv8nO82gWXRiqjrJVZAt8z3wWZvwU9F8=
X-Google-Smtp-Source: AGHT+IGfBYscmszLcQ4WIVww+p90HeYYLjnd7VEGcPNozcJMTJpfpN4Si84n434k13+c6xYJKAYYSQ==
X-Received: by 2002:a17:902:fc4e:b0:240:469d:beb0 with SMTP id d9443c01a7336-242c21fc427mr199498845ad.31.1754895716651;
        Mon, 11 Aug 2025 00:01:56 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899aaecsm265961735ad.119.2025.08.11.00.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:01:55 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:31:53 +0530
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
Subject: Re: [PATCH v6 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
Message-ID: <20250811070153.5rjj2cudgs7rwiwc@vireshk-i7>
References: <20250806112807.2726890-1-quic_varada@quicinc.com>
 <20250806112807.2726890-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806112807.2726890-4-quic_varada@quicinc.com>

On 06-08-25, 16:58, Varadarajan Narayanan wrote:
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

Applied. Thanks.

-- 
viresh

