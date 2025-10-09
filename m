Return-Path: <linux-kernel+bounces-846369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E30D9BC7BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E56B3517C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9A61E1E12;
	Thu,  9 Oct 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mDe9u+UK"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41018DB35
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995466; cv=none; b=TxPFHnjyhr0xnN8wryJCsWJfrG8v6OOwX4X7vATpXOLL4thu1LuonxtP6uVC/oOQTWc4D5SDYkGXvsapXmGt32HxZmw3hszFmqwzbmHh66Oe4hs6cCxhIfSRrn1i7wMlwJQXAzHWoxtdLqQXn2iPQ7h9FpeXCctTdOMqM/EGZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995466; c=relaxed/simple;
	bh=dGju8AeWqVChK/btSkkXXitucm6kni2Hg7FXCU+eGHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt0DvISEnozaA4EMvyBff/pwxuEGKS9JezHnuy8rHWDxqlj2of/te4qDDLk8L4KsQX/JgW/VUY23t5z+yFruvgjqjC5X++AKROVIm3h2D/Ayw48VEZvHMYUZaFYi6nra1cTwwyouhz0UGa+wn7xDQ5XHnLgWloZo3ep0t73qnDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mDe9u+UK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso869302a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759995463; x=1760600263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QkBo4+o98aA49wUvu+G1xef2+IziwVoenRLYEe5BuKY=;
        b=mDe9u+UK4Mwu6M18fO0TRloIRr1AIoR0KlO4CS6yjeyJsGvfj1CWv7qlTBQZWKEnHK
         jM0FUy8uKYEeZIOIpavbq3oPWGMmXz9t+rDeqnvDaTyqSf0Fywgm8ykKtbSt4oG5Emf8
         T9XTTjyinFnO4Br/iwGz1PSwwz+ICZ7yRT1leZzyjYGEzsidBkeKCCZx69MxVBfi2T0V
         HJNvVfoLLJlz8H6ZC8wC1OByp6x8D0k98kL8le2fDn+ipcg7MqFU7tKspJs2HvMm4WDz
         OjWO+BtwfQJCSChuXNn9N+uc+MPhV0z6KgLYeNTRA+VLbOPwtE25RoJQCc+6es4VcNKH
         u5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759995463; x=1760600263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkBo4+o98aA49wUvu+G1xef2+IziwVoenRLYEe5BuKY=;
        b=nQHYQ5uwBvo6bVv12sTMai+5YDBr3HgroqMR1pSa+5mc3PKRYhRJWylpjHmjRkTvME
         om7E+OxvdsurQ/SnxpabdNY+nHIpgy3ahrdQO9KfBFAjL/37VuTUwlq+XG/Myexq7si1
         SRi9XuO2N7bZU5rWc56hPrSPVFzIe8avRA2XH8fy5WzWEE70eoo6b3nNWTaeX8Jfd33n
         g6Z4qE0lmmj9F39FbadIUBK2jzU02KVpz0q3TxRJmPVGDm/I3miYUoMdPmCXDs1REQPA
         iMSShjovvqTY/xOd9lt/KDhuE3LYWgrfhivqrFodp796ee7r+jskN7SHgp/LYGUN/dQC
         9oVA==
X-Forwarded-Encrypted: i=1; AJvYcCUWTA1Bpf70uGESyC2oi7Sgf7vNL6U/2Z80N0km5QZO42bn9lljynX0/xYRt149h1xJuOr34DMB3qEAu3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Rcz+z8iwVj+1quQUlWXZYku7o+VXBwu26YSiCwh0dEYEBd3I
	nKyupeOp3gV9+/xezjJUH0zRA/zTia+vnrkdiYigWqnpdqiWCF2zUuFzh8M2nP7T0DKQVL6n2vc
	xQWiQ
X-Gm-Gg: ASbGncuofrK5wLUwMrd5pbBZA5EZkF0n5QbqV5CvnfJARoFZZ+x9H9u99U8GCvUJLdm
	4dEt4EsX4PbFfiG0LSw5C1EMdRIvUOQhFgGkDj6Kn3VMqaPMzRZ1V8bDTtJB1OHKILRcojre8os
	ZpoGJGkGs0BPUKWTHnnsAQC8AlkWEjresLNLfiSDZqXLnrUQeKZ4z/sJbeXd6dmBlGFifYrpFJZ
	y3zhPKrltGyPK99xXNk9boazTcwVkd87TsW4kMU+8dAplSLxokS+Kyg4mwAsa4GpFI/PqMXsBoQ
	OG41tqPc6BVzv0NojDGzoAvhZAIHD0SKg4r+6h03Brax9FfbDrFdZ5HAFGo5Z6UECelRSr6un3q
	z3dUYYauBlpWGifhbFiGVgiv/k9djkp3VBmfH181QbuVWN9DTG7fhEmpJguEMOV2Oms8=
X-Google-Smtp-Source: AGHT+IFHi/yZs/pGR4qTm0LoEk0mx1AMmvxnoL+zqu9ZIvbq6rDqz2obSOnUoPzAuZGAuoj0ELKvaQ==
X-Received: by 2002:a05:6402:2708:b0:639:c56d:2407 with SMTP id 4fb4d7f45d1cf-639d5c3f43fmr6045687a12.22.1759995462468;
        Thu, 09 Oct 2025 00:37:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-639f30d9963sm1766971a12.15.2025.10.09.00.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:37:41 -0700 (PDT)
Date: Thu, 9 Oct 2025 10:37:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: cadence-quadspi: Fix pm_runtime unbalance on dma
 EPROBE_DEFER
Message-ID: <aOdmQhGW27I6rGTB@stanley.mountain>
References: <20251009-cadence-quadspi-fix-pm-runtime-v2-1-8bdfefc43902@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-cadence-quadspi-fix-pm-runtime-v2-1-8bdfefc43902@kernel.org>

On Thu, Oct 09, 2025 at 09:10:38AM +0200, Mattijs Korpershoek wrote:
> In csqspi_probe(), when cqspi_request_mmap_dma() returns -EPROBE_DEFER,
> we handle the error by jumping to probe_setup_failed.
> In that label, we call pm_runtime_disable(), even if we never called
> pm_runtime_enable() before.
> 
> Because of this, the driver cannot probe:
> 
> [    2.690018] cadence-qspi 47040000.spi: No Rx DMA available
> [    2.699735] spi-nor spi0.0: resume failed with -13
> [    2.699741] spi-nor: probe of spi0.0 failed with error -13
> 
> Only call pm_runtime_disable() if it was enabled by adding a new
> label to handle cqspi_request_mmap_dma() failures.
> 
> Fixes: b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
> This has been tested on a AM69 SK board.
> ---
> Changes in v2:
> - Updated message to use correct Fixes tag (Dan)
> - Link to v1: https://lore.kernel.org/r/20251008-cadence-quadspi-fix-pm-runtime-v1-1-33bcb4b83a2e@kernel.org

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


