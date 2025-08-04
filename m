Return-Path: <linux-kernel+bounces-755567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA866B1A887
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6987D18A2CB4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FE928B4E7;
	Mon,  4 Aug 2025 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICOctBeU"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2EC4430
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327737; cv=none; b=C+oURobS+S6IqayeDoftW10geSuyPSBzGmTaGXkLlFaDE6hkaDWjcHERvoyEqT9DwgRyIO8Up8I7nv3U374VxVDrb4IwOABekeARWCW2w23HZVb4fD4U4RE6ZIC865FlTWgwGpdTICi9wCfINV9rP1p/ihf5mL68pUE1k4qBsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327737; c=relaxed/simple;
	bh=SECVmWzh/lpnaSJsDkOaHPyjcg2dlaYHEw0Mowtnw4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SV6lHl73uy0PIZLA8LdbRQgefGgK4Ta8vJQIUSIlQCWZ1VtgcCi6MIAVpr0UK9tACC3pS9ORWQ/u3s5KSai3xuqmxTwXcZiayWF0NCvepKphlrI2VVMzS4qwd1OkL9XPtZ5hwzZQ3ZmmWKFOH0qY9yvmvflSL4KoEYGf2FI4p04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ICOctBeU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-458a84e2917so39659785e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 10:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754327733; x=1754932533; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NrTKl9K4+8vI5BzLuQ0RcuyJtwiyeqQNxpuwyBCjmjM=;
        b=ICOctBeUWFabBVRTi3EVh83U8YAl0Jwq0cqoiFUFjVednWTnBD4yKyRHPdUvZlmWL8
         +GDg5I9U4ctjd23Ea8aKECIIsP5xUiQ1Mw0+HvZuqb6NqwVxPlSJJwDuBclzIpnEf21Y
         d9ag5c2Glr/Qz+JukaOMSQn+DQc+zeg+ztlbm1drcNZYDb9Nk6yKI9upQK0ZOMwriDIo
         IqdYfgxrLjCUBYLQJhkW77vty1we6rqlEzdONWvP+EPFRjUS2ftxb1y7vJzy3X25OFFr
         +CV354SMlbxrvPeXnbKEfByciNbqThT3uA8zhVHJDrnVmLb2c+FHL638FshK2w3hQLZD
         eAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754327733; x=1754932533;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrTKl9K4+8vI5BzLuQ0RcuyJtwiyeqQNxpuwyBCjmjM=;
        b=EfcKLwisRpwpQGEy+xcvkz3BzfkvfB/l1/pSFGUf9UYy26XDT0+4zza2AkaDGatW8W
         DXFWFqe1x7Q8l7XnRv8oQamAkPkqoKpIm1dsmxAAguCoMm6kP7w1ANgjQ/+XfljiRAj7
         eozDEby7wObOjzsMaV8GdIzryjSQ7nXV/CaZrj1Zs9cjR4aAKAi1ZAVZH9MRWLK50O2U
         tEFyHc99NUY0V7d2otKfskCBn7zLmQHkf7ATv6TVhdXz9UDm3YmyIZxBPmDLBvYQfxuo
         QHNyYYge0LLZXNmq905+H16TKBFQsBAZbCuC6IarKKbCQAhohs3LWIavuGxwb0+RDHEF
         L/XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyC4ATaAkELBAW4pLobBofSARHt5bOLI0N1CxpuMN9wC//R4Qn2yU8u4l0RgPPGeLU8ylMWMAO1twsR+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPgcMpU8eCOosdyZbHJ1T5sfsZlOmxiNxoEp3Ms84VlyODffcK
	UJy9jedj+tN6j86JTcvKyxiwUlvSeVX1cwuNmpOSwt2KaRydFMUute7/sK56XIGKuCI=
X-Gm-Gg: ASbGncubY+egUQ9jwEL/vWvtT9cWSD6ofVSLj2axiXCw6M4cEwy/gStPrOj/Hsw0CcK
	pfDr9VMLyksPuwLP55I6kfuvMksTLyQUU4ftX+67JBLNzLH8j98RZXGcXk74PQabsM59M6uJLTB
	VAi1JDihZv3OzpbSBZk5+oi6Z8GixtvAIyVQDtrjbab20/e3RlTYALX3VOWLBcdn4oGIysCDiST
	9TIaFikYwK8SHE/GJl7O3cwfUw89AX0SYuJTBV2W4pud/gcAK8H3wbYLuH/15GkTdRgrEyKX/0m
	IDg0hGl6aPt7Tm0bVuMqftjmOUvYJ9v5u2Z71g69KoDVM547n/R0KiObj+PmacC7E2SRskCgC7o
	3uhZ6S7PLTWCZbkmHxlLWNRZ10dCyElw6AlKupQ==
X-Google-Smtp-Source: AGHT+IFGyZV3Lnqkd/Us0kr0C9bu01zWEPsZjgPddB7McgPHFiYC5RrBkxKNSmpQutG9nl15DFY5XA==
X-Received: by 2002:a05:6000:1ac6:b0:3b7:8af8:b90f with SMTP id ffacd0b85a97d-3b8d94c3f5dmr6949009f8f.40.1754327732649;
        Mon, 04 Aug 2025 10:15:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a6f62sm15897981f8f.73.2025.08.04.10.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 10:15:32 -0700 (PDT)
Date: Mon, 4 Aug 2025 20:15:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Ethan Carter Edwards <ethan@ethancedwards.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu/gfx10: remove redundant repeated null checks
Message-ID: <fda8103d-cac8-4c00-a78e-6eb27141d9ea@suswa.mountain>
References: <20250801-amdgfx10-v1-1-e1dcbe18d84e@ethancedwards.com>
 <CADnq5_N+bQppUAD-qR8QC8M6nW+oRF8+7z=Qakcxc=a6Z8q4Gg@mail.gmail.com>
 <c82931b5-0de2-4e45-a80b-3a90b0cc98a2@suswa.mountain>
 <CADnq5_Mk3FO_tvxFo+fJgqskVc7qtGv74VM6EStx_BcVpahXEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Mk3FO_tvxFo+fJgqskVc7qtGv74VM6EStx_BcVpahXEQ@mail.gmail.com>

On Mon, Aug 04, 2025 at 11:08:57AM -0400, Alex Deucher wrote:
> On Mon, Aug 4, 2025 at 10:49 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Mon, Aug 04, 2025 at 10:32:43AM -0400, Alex Deucher wrote:
> > > On Sat, Aug 2, 2025 at 4:22 AM Ethan Carter Edwards
> > > <ethan@ethancedwards.com> wrote:
> > > >
> > > > The repeated checks on grbm_soft_reset are unnecessary. Remove them.
> > > >
> > >
> > > These are not NULL checks and they are necessary.  The code is
> > > checking if any bits are set in that register.  If not, then we can
> > > skip that code as there is nothing to do.
> > >
> >
> > It's not a null check, but it is a nested check and it's a local
> > variable so the patch is correct enough.  At this point we know that
> > grbm_soft_reset can't be zero.
> 
> It can be 0 as far as I can see.  If none of the GRBM_STATUS bits are
> set, then we never set any of the bits in grbm_soft_reset.
> 

You're missing the first check...

drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
  7657          if (grbm_soft_reset) {
                    ^^^^^^^^^^^^^^^
Checked.

  7658                  /* stop the rlc */
  7659                  gfx_v10_0_rlc_stop(adev);
  7660  
  7661                  /* Disable GFX parsing/prefetching */
  7662                  gfx_v10_0_cp_gfx_enable(adev, false);
  7663  
  7664                  /* Disable MEC parsing/prefetching */
  7665                  gfx_v10_0_cp_compute_enable(adev, false);
  7666  
  7667                  if (grbm_soft_reset) {
                            ^^^^^^^^^^^^^^^
Unnecessary.

  7668                          tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
  7669                          tmp |= grbm_soft_reset;
  7670                          dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
  7671                          WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
  7672                          tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
  7673  
  7674                          udelay(50);
  7675  
  7676                          tmp &= ~grbm_soft_reset;
  7677                          WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
  7678                          tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
  7679                  }
  7680  
  7681                  /* Wait a little for things to settle down */
  7682                  udelay(50);
  7683          }
  7684          return 0;

regards,
dan carpenter


