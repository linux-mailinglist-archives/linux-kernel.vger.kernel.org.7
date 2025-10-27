Return-Path: <linux-kernel+bounces-871966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAF4C0EFB2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8773AC0FC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADAF2D2497;
	Mon, 27 Oct 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLUT95eK"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56FE2C032E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579072; cv=none; b=mTrO6tgyOusRAye6ukbUwwv4gPHghIflFp1aOPzJFiH0iGIgfSHxrt/m5EttzDdcp29k2AV/Et6cism9dh4zMTLTP988b6Bkv6g7iXgmmT/iTEDj+lMPP1pxYbH98orvYOXdpplkiykq6jPP9RStg0bhstYosqtGRMM4yekPtd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579072; c=relaxed/simple;
	bh=dj+bnTfPD5E4CT0YPt0fXWXRL59XVMUbXq5o10JY+O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgD0TWWSPIcOBNc9DS4FPoKAhwUNW47mDoXSLPyfkn4F2fnvdSV5bQgi8uZrudR/pbH6/vynqWKMhp14F0UlGMcf3HdnXkSRMF79zZ1LfYSL6u2dTE5p5CvY8rQTVgMJznYwP6NH7TMBl6fQUJqr8E1jJl68mvB65WF8VZVY6fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CLUT95eK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2698d47e776so38432615ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761579070; x=1762183870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+DsN4jdZOSZ5kOtvEnVeEW6g+UQqLuSnwSLzBPvWmk=;
        b=CLUT95eK7npT+yoxbE0m9cj/uUdcQ+tKI7gq9zVeeaPrc60/ECzDaWK04T3da3KAkw
         im2AzB6fNOoVj8qYEeMaU/dlA5gpSF36+/h4t8BmZ5p3cxYF5yVz3lBSBrZ+Pj4HOYZg
         Y/+dcHyya7/8uVQ3OEdUczXmjOyDYsnbkSW23zvi9u8iLQeuPKAH+IE/sRh8zCIl0wrA
         6T0V21PBQYC7XAcAofKdQZNdN/oeMHInu02+d5K2HVOLJFMM7z+UxNd7qj6JQN2j71SG
         uY1bwMtEhxIeh21/212mR5FLmYPswelnfaGFWRzUjtiAmCmEHpYS/xgmRwc8LP7DVqgs
         Z/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579070; x=1762183870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+DsN4jdZOSZ5kOtvEnVeEW6g+UQqLuSnwSLzBPvWmk=;
        b=fXmf2dsAL8bEEeWkxDC0sy+w6mZFRS7I7vDcoUkk4g1EiFDISTLb9VrraMIkHG/vC5
         6+u8uVyUcOQFy43Q8UHmfxdm+AbcffD9L1kJl///hKUj89uvk78PvFyowChsGFV+U9vn
         s1+kACTokShCUcvX7AtDRVkkp3MRjuVt0ZFs7C7dfRpAE1TnTUAxI0eQ0gtVxAqQIrFh
         sjhw45fa5cNzhrgB1PrOL6iTD69garu6Yvri1dDMhligMCx2lrhOoUgFopuF1TlYnC3w
         YoXwrPqZUuEfSGoFAsQqvNNzrJLDS9Zvl/7xCA7tDnF7uACrboV5ubOE368tTwNwI0Uk
         5uHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRINagthgP5CTVlD9V796tFzHDMr+1sSiVyj0LvaWKyaYzDWd2Aw8Ew52YJacl2B9nEBIHE2/18MV8YbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/i/118SFpArliVAaL68QT3lCRUMbTdSruW4g9wT8HF83+uXg
	VInl2cFloR9V9rOVjB5qMtSi4B4O1RMLlWTE43ANwhy7rY4gUO8wGmAq3r1NMozeRCM=
X-Gm-Gg: ASbGncsyaaeJr5feL9ezG65iAlonqJSSvR0WIL4EQ9pQuPy+O4CzDZs2uuypGqpQF5F
	5fFLPejuwBMa5O8PPWGusmbPci5svAXoI357I0fTfD9eqSAjRGg0twJA5jWt+WEYRUr0vvxHV83
	i/mkNGnHNsH3hx/ioquz0RmWoWlNBndGEkdpvedrNIbs/Rn1AzFQrba3Ti6Udv/49USwKq3kTAd
	dFR/hVXzd1fK/QhIvQWoxhMY/8t5Vd20dLDhhFztLpRKxhoHM39HAmWNP2FXfr04i/FO6Ohicxw
	9DJwKeMNkwylDJb5aP1mtNeW3T3yc8YoERjV2skkvgPSFOAwRViNIGZTgP8eY/b3Dn1bh++fbmU
	eZRRLY3nYSwn3a3Gh3MrfmA525yec+geqqdDHmnDKR15a4S91IerRB/X8cxN7bHsR2BGgfJWWK2
	J32Ryzb6ctGWB6Ew==
X-Google-Smtp-Source: AGHT+IEP4FsWGs0UlCG38/MmB7iYt/IImDnHvF1ET52ZGM8b5MM8tWTghb1WNjJHrfHPnwqQpuudRg==
X-Received: by 2002:a17:903:b50:b0:264:a34c:c6d with SMTP id d9443c01a7336-294cb3ecbc3mr3384865ad.37.1761579069792;
        Mon, 27 Oct 2025 08:31:09 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:6669:f9ca:a6a4:f3ec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed807dbasm8970788a91.12.2025.10.27.08.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:31:09 -0700 (PDT)
Date: Mon, 27 Oct 2025 09:31:06 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Andrew Davis <afd@ti.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] remoteproc: core: misc update
Message-ID: <aP-QOnTuiEcx9nQK@p14s>
References: <20251016-rproc-cleanup-v3-v3-0-774083716e8a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-rproc-cleanup-v3-v3-0-774083716e8a@nxp.com>

On Thu, Oct 16, 2025 at 07:47:57PM +0800, Peng Fan wrote:
> This patchset is a misc update of remoteproc_core.c.
> Patch 1: Drop a pointless initialization to variable ret
> Patch 2-3: Cleanup the included headers
> Patch 4: Remove export of rproc_va_to_pa
> 
> I am also reviewing the rproc->lock usage and thinking whether we
> need to add a lockdep_assert_held for some functions that should have
> lock held. But not sure.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v3:
> - Drop patch 4: Use cleanup API. Because there is a deadlock issue
>   reported, need review the lock usage before the cleanup.
> - Drop patch 6 & 7: Use bitfield for bool
> - Add A-b from Andrew
> 
> Changes in v2:
> - Add patch 6 "remoteproc: stm32: Avoid directly taking address of auto_boot"
>   to address stm32_rproc.c build issue
> - Link to v1: https://lore.kernel.org/r/20251005-remoteproc-cleanup-v1-0-09a9fdea0063@nxp.com
> 
> ---
> Peng Fan (4):
>       remoteproc: core: Drop redundant initialization of 'ret' in rproc_shutdown()
>       remoteproc: core: Sort header includes
>       remoteproc: core: Removed unused headers
>       remoteproc: core: Remove unused export of rproc_va_to_pa
>

I have applied this set.

Thanks,
Mathieu
 
>  drivers/remoteproc/remoteproc_core.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> ---
> base-commit: 1fdbb3ff1233e204e26f9f6821ae9c125a055229
> change-id: 20251016-rproc-cleanup-v3-330464eee32e
> 
> Best regards,
> -- 
> Peng Fan <peng.fan@nxp.com>
> 

