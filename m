Return-Path: <linux-kernel+bounces-864565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0045BFB15F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E383BCF32
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6A8311C24;
	Wed, 22 Oct 2025 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nfxh77TH"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15CD30E0DD
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124125; cv=none; b=D8Kni0MKBnl3jYR5Xs3ABnaMVYTiifiO13/tE9hlqMPUv6/CZG9pbshVkq0vmcysQ3e2szcHm9RWGZKFNzEwdC6K8u6R32jYHK7PliPcNoCIgDVPJNjaxrMJTCdiF/B23Vs6Sl2VN/dqF0z7VUCNl56xCSrHBxkT7elPJ8sVaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124125; c=relaxed/simple;
	bh=XwI9/Pg63nWAOQs+Pbg1hKzGVpozCmZVIXWuKjVsO8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo/jJENAjmUYlyAPA6JbqTMzCrYA5cdrSLKg2wdSLh/nl52nOV6O8PYevikP0PxkseHNEv2BGFfafgr58xMUp9nwRoABIOJfe4nUi/pvUubMJpyKv828rXSXKrArKIP0+uw9sWTwnhDFdfDMVYuSaoRBzpvtNuoxRoYFhDvCzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nfxh77TH; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ece1102998so5418342f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761124121; x=1761728921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IR6lsN0D+gAwku4dXN7wcI1QUBm99dnHT8qukWlDAjc=;
        b=nfxh77TH912Iy0/iwkOvfi7hks1JLS3L4Nngiy2zLqQ2uIL+gUqvJii9d0WlE5udQj
         kTPdsMRlUw8B8//+JrSmGKOfxvtby8KrqdIszPfT1WkSLOhoR3i7KxeNwnr4o/E1ri7y
         SMrYLKNj6MuaZSGlfdVbCBl5fRt30LfS6CcNoliYKj5FLXlzIzQrjshRy9p1ef3YCLRB
         ZQ2FtGc7Ovrb4QdSkOcXA+YaX6NwVFbVFGQXFy+d4iDDRPhpT0kMz19LI/lgCvd2t0lQ
         tfUgNDS/IZnF9fDM1aJhFuq/xTqX70MGSy5Cczc4niZtbWWBvTPuFULYBsWskZeUvXsK
         mShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761124121; x=1761728921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR6lsN0D+gAwku4dXN7wcI1QUBm99dnHT8qukWlDAjc=;
        b=lFOYYsH/bxPEJRoPflakgrzYw6jwW7vviLa4kULhHFMHIwtiB3XYgCVq0skPc4mUsA
         Y1XRZrMSGszL3oUPDp44HHo00a5wW61xI5J49GZI9WvTcoJAUxF8/evROoM62josGUNn
         2U8Ft4MH0mJ1kI0KB0k1/R2dUD9f6IFuQUc6tzHKwTbzng1yHCWsNSzEb6etkxamHAcK
         grrJlhA0cM7ic+fY9SgQ81EYVgQCclNZ37vnI52D272iCtjucl4NfcEv3llv7WPabf1Y
         nybBXF9o2dWZQRSw4M04zb4Iut+NbCt9q9UNVnPXfWCuniQuijVHGfZ8/V6kwQpkD9iB
         wB7g==
X-Forwarded-Encrypted: i=1; AJvYcCXUzHqCyUCb654ayKT/6SUaEzZMk9ivVJS3QJVKjeNALc1CZ71UJyAAu5UxWEMyEkOBXS7TydVYUTyr8Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu+q9N1wRcqS1dtZrld2pJO0eSdjqChIF9EOhIduH1gfbu0JG3
	Xocp2H+nqRivR0PtkCLFG3nmUn9l7TSGuhKknVS2MmcwsrHN5tt0cns4lrMJxHcBmhc=
X-Gm-Gg: ASbGncu6DI6G44oz0lQf1f6CH/1xFuOhbS8QXrDr3Pwk/ALzZ/xHur24gr7gqsSkvg9
	738tMIvjJ+iMa6PS7GgkwoIvn92dH+b5+82yIp0ml7+aAztWUnLnOwvCUAz598RmwnkX9vVOfuA
	cBXkINo660Dzbg4i1zwsO1sQOt+mre0OfP9bHE8kw4Gncm2HiKX66Z5ioMX4kdg+7mDLkbOLXdk
	C3trpyJKMGAIXTHh9dPqBWbcovskDp1XYNaCIChRyoAgfU3OVhFkcVDAQBCtaARc3VwQgk4LZCV
	J3V+3ffOVW/W6CHe6mmHaX74Mnu9bsJ2hN256N4uBKAw5B5n5NE5PM6ziFtf5s/h2+2FSUiUAPm
	UhAMo/dpGKEfa4EM5M7/7NqKo7bfrZLqkpmg2e14i/rSdcZdB1kh8r57jDwEe/Sbp7wn9TsqIAC
	jy6Piz+Wo=
X-Google-Smtp-Source: AGHT+IHvJFt8VlT5VCY364CrT9cw9v3O1vNM7YyvBOJIGj4xhlggMfEoG6gw4R5G2QRkCeX2sxlT0w==
X-Received: by 2002:a05:6000:1a86:b0:427:8c85:a4b0 with SMTP id ffacd0b85a97d-4278c85aad2mr11780759f8f.56.1761124121045;
        Wed, 22 Oct 2025 02:08:41 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a7dasm26488612f8f.25.2025.10.22.02.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 02:08:40 -0700 (PDT)
Date: Wed, 22 Oct 2025 12:08:38 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Danila Tikhonov <danila@jiaxyga.com>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: camcc-sm7150: Fix PLL config of PLL2
Message-ID: <rkp7dol23li6zdqaz2jzbkjntmc57lxmvxve2kc4ljh7gbu4k6@73v5d3mjsu6r>
References: <20251021-agera-pll-fixups-v1-0-8c1d8aff4afc@fairphone.com>
 <20251021-agera-pll-fixups-v1-2-8c1d8aff4afc@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-agera-pll-fixups-v1-2-8c1d8aff4afc@fairphone.com>

On 25-10-21 20:08:55, Luca Weiss wrote:
> The 'Agera' PLLs (with clk_agera_pll_configure) do not take some of the
> parameters that are provided in the vendor driver. Instead the upstream
> configuration should provide the final user_ctl value that is written to
> the USER_CTL register.
> 
> Fix the config so that the PLL is configured correctly.
> 
> Fixes: 9f0532da4226 ("clk: qcom: Add Camera Clock Controller driver for SM7150")
> Suggested-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

