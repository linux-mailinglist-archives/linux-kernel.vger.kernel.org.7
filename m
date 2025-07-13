Return-Path: <linux-kernel+bounces-729121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83989B03208
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817C8189B774
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 16:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E12D27978B;
	Sun, 13 Jul 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5hRAdQ1"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309C53BE
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752422965; cv=none; b=c7zbMbd0XxFUDJOItrWDEEaUzOunXxKPN1CmB3aoT2l8qOuJz1j0FBCELq6S9AGPQjqAFHSCKM0hKF9fxG7HftFHtLqJweDVuWfMyd8NNloonFtIBHiVg0K5j9t2hLSiXQOzIjVxkiQXdzrktDbGQKEnXGqJSuxV3Ewe012xAkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752422965; c=relaxed/simple;
	bh=KRmk3NsGgVD0LMF5wEKWU3R43QFvlORAzL53r7et8Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mnna+1KpYJ+InB1wKVblModTwd7VIpdyAU4gyZQBuBZnrqAUGXZ8aNulT6h5AxF893VMKGMdsGeYgT010Asd5TAKuIo6q2UslEDNRljzGlv6Ve/gDqGNg0nTGygTg8KLBuymhOvegiCS1fejTL16DybdBFybTwZW0lHiDKaZTbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v5hRAdQ1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-455b00339c8so14153515e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752422962; x=1753027762; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rhba6lHhtD1VINr4iXPUASGWwdiuWX3glc/gMg4zgjM=;
        b=v5hRAdQ1M5mp6Zq73IZ7fTE6RsstjPBsaTOFI/WLLpPRNqylGAtGFWqonysxRK/jo8
         2aKNmvj00SN/5MVN6NJWqVTFcjD8TnD+2YCpnwfkp40+FKxT9nuSRR+AmLRpWcLl4moq
         6pYgnye4xChuGCNF2MmvcIzsii4tW9onDNBba8TGHPwzhGM4d906coiFVVwOaCX97PTn
         pvbJbVbSnNZsuSIvXMJijfIZJw/gz2/b9UWOtXISQrX9QtSOBBsArg2UtoZIal7nr+42
         mK+aS8bnja18jQxxZ9ouH0VPq1uYisQoTdYLQlDDvYh6OzrqTVwtM9xtITDpR4ER4NH7
         Kmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752422962; x=1753027762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhba6lHhtD1VINr4iXPUASGWwdiuWX3glc/gMg4zgjM=;
        b=H4w7f5O+ehVbrqtCFGccQudU4zpQF/KhsJXDhuO40zwX7Fm09p9gYxoQ0EUc96cBCg
         zxpiIOVmHP8dIhqU6RLs4zBxqkC8Hu+eCl479rFhN0bSPNx5+fBrvGq6XqTnaBBO2mBY
         FO+XyNq0UNte4TMdrDzOa5qla9HDhDCsvTwCI+zi1zFL0KxkIcJX5DcUwmIVPhAPuVZX
         49etSJSpQLdqmBvAU0FIR7/ni/h//AYzlx6hSpzdKaFk1mRXVIdyittwH86bVV80Hwym
         gS+KU7MmCl4ul4IoNofxBKt/6nyvhiLXKYg/lHzLF+2BiGu+6gPGt1OJ/rfUzp51b8ww
         MsqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ1Eq4e/+OrAHUk1v3NWWRQfWCBi2Hwfp9pi+Uhs/0Cbt9kpLKqarzfWQFZcpLpjtrA+OgkvkheUevkPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWI+6qdH7lbVZtCsr7nEExnMlel2PMUjGXNQ1Rt5WZzHDaCz9h
	7BIeaS9QXBQE3/kDJomd5heGgt7DHoT4ntsCR/QrmYfJ9ULCpr7jL1R+gbRCcKWpyzoi7/XYl5L
	NbM8Y
X-Gm-Gg: ASbGnct6g8NP+EzCa+Ktu0EpBEz9lYZ741G39BfafltxT1SzqKR1/o6ZOVj6CF2FW1j
	yHn58ITCp849+/K2xtXIfDTC+T7cp6Wi2A+19biytPsISxnauOS+MT+kmAP8mjwTSBz/1Tj47h6
	f0KNuxYgxfgM81cNARK0kK7+n+wcTa7fI0eZcnyUtod84RwuGgqQIxodEn2914A3yaMh4HBoU+4
	0zfQaYovu/li8XVY5j2C0jGrIJ9Dnwk69uvjj0VPjuewNSunVkDWS1gmsZ9vNlZGa+wxfiSRMJE
	bERqlwWdBVdtXB24JNdxQsPXusICwt22t/mXZ+8w+DN5fkjljn85HwMGCrPIe+s0mxHL9aqEzt1
	26lSpZlZ2Tv52fWndT4RHO+EIZTvJHXp76ALgnko2eptbCh9eUBeAgqAZPHnl
X-Google-Smtp-Source: AGHT+IHRfMcJZ1kG+n5978iWlkkPgMANVyQONUJ0QtigPrdAhXAs7eN2xp9KoLqBx3H87ZSTp3kuUA==
X-Received: by 2002:a05:600c:3f0c:b0:456:1006:5401 with SMTP id 5b1f17b1804b1-4561006660amr32350185e9.5.1752422962278;
        Sun, 13 Jul 2025 09:09:22 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561976784dsm11426405e9.18.2025.07.13.09.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 09:09:20 -0700 (PDT)
Date: Sun, 13 Jul 2025 18:09:17 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
	rui.zhang@intel.com, lukasz.luba@arm.com,
	david.collins@oss.qualcomm.com, stefan.schmidt@linaro.org,
	quic_tsoni@quicinc.com, konrad.dybcio@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
	dmitry.baryshkov@oss.qualcomm.com
Subject: Re: [PATCH v6 0/5] thermal: qcom-spmi-temp-alarm: Add support for
 new TEMP_ALARM subtypes
Message-ID: <aHPaLZ46BCdM2lRA@mai.linaro.org>
References: <20250710224555.3047790-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250710224555.3047790-1-anjelique.melendez@oss.qualcomm.com>

On Thu, Jul 10, 2025 at 03:45:50PM -0700, Anjelique Melendez wrote:
> Add support in the qcom-spmi-temp-alarm driver for the new PMIC
> TEMP_ALARM peripheral subtypes: GEN2 rev 2 and LITE. The GEN2 rev 2
> subtype provides greater flexibility in temperature threshold
> specification by using an independent register value to configure
> each of the three thresholds. The LITE subtype utilizes a simplified
> set of control registers to configure two thresholds: warning and
> shutdown. While at it refactor the qcom-spmi-temp-alarm driver to limit
> code reuse and if/else statements when deciphering between TEMP_ALARM 
> peripheral subtypes. 
> 
> Also add support to avoid a potential issue on certain versions of
> the TEMP_ALARM GEN2 subtype when automatic stage 2 partial shutdown
> is disabled.
> 
> This patch series is a continuation of older series from 7/2024
> (https://lore.kernel.org/all/20240729231259.2122976-1-quic_amelende@quicinc.com/)
> but current series has been reworked to address the change in thermal framework to
> update .set_trip_temp() callback function variables
> (https://lore.kernel.org/all/8392906.T7Z3S40VBb@rjwysocki.net/)
> 
> Changes since v5:
>   - Updated variable names to use stage2 instead of s2 in patch 1/5
>   - Added overtemp_stage enum for more clarity when reading back specific
>     temperature threshold in patch 2/5
>   - Updated temp alarm data subtype identification order in patch 4/5
>   - link: https://lore.kernel.org/all/20250620001918.4090853-1-anjelique.melendez@oss.qualcomm.com/
> Changes since v4:
>   - Removed the unnecessary thresh member of the qpnp_tm_chip struct in patch 2/5
>   - Updated order of logic to limit acquiring and releasing lock within
>     qpnp_tm_init() in patch 3/5
>   - Fixed misuse of signed vs unsigned integers in patches 4/5 and 5/5
>   - Added Dmitry's reviewed-by tag in patch 5/5
>   - link: https://lore.kernel.org/all/20250528235026.4171109-1-anjelique.melendez@oss.qualcomm.com/
> Changes since v3:
>   - Updated order of logic and made dig revision a local variable in patch 1/5
>   - Updated Locking Logic in patches 3/5, 4/5, 5/5
>   - link: https://lore.kernel.org/all/20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com/
> Changes since v2:
>   - Updated function name to include "gen1" in patch 2/5
>   - Added Dmitry's reviewed-by tag in patch 2/5
>   - link: https://lore.kernel.org/all/20250225192429.2328092-1-anjelique.melendez@oss.qualcomm.com/
> Changes since v1:
>   - Remove unnecessary moving of code
>   - Added new v2 patch 3/5 add a preparation patch to v1 patch 2/5
>   - Updated temp alarm data function names to be consistently named
>   - link: https://lore.kernel.org/all/20250213210403.3396392-1-anjelique.melendez@oss.qualcomm.com/
> 
> 
> Anjelique Melendez (4):
>   thermal: qcom-spmi-temp-alarm: Add temp alarm data struct based on HW
>     subtype
>   thermal: qcom-spmi-temp-alarm: Prepare to support additional Temp
>     Alarm subtypes
>   thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC
>     peripherals
>   thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals
> 
> David Collins (1):
>   thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required
> 
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 596 +++++++++++++++++---
>  1 file changed, 520 insertions(+), 76 deletions(-)
> 
> -- 

Applied, thanks


-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

