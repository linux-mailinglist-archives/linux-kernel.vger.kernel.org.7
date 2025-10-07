Return-Path: <linux-kernel+bounces-844529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C86C3BC223A
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAF054F76AF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DF72DFF0D;
	Tue,  7 Oct 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jcdm3lF9"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179292E0B6E
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855240; cv=none; b=ZS+o9xE31+/HzBXHs+qPCHfHeHRZzCNhMlpOmQGsnYXjXre9s6uSEvyE6cO1T5t0i3ZHcGBnpDtcFW598FFlLvHUgxN4raBcB7JsHdTR9UlcEcHIuC01Drxzu7rny0HTL/Y/bvS4SupxqMwaOOCg7Ycv/0SpsZ7zeuGJ11EWAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855240; c=relaxed/simple;
	bh=hFXYR4fcmLBIVGVw+InBgwA3ZnSYHsqcnzS4vlOpQQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4x8KVZlTcq59KUq3/NhEK730PmlSpFIJWkAaXZR6OcZ4lmwgIPaVCLdSLlJwlNHw1yIL8wO5bhHG4/Gq3KosdY17gynWnoNLSnmXzWuYw+r5tpgRDYRljFud9U5lkpQJzekdptKPv0nUPBUhbbdx0ExZywra+uzo7oClO2itEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jcdm3lF9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so69911965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759855237; x=1760460037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4T6AAskuAQMA+z0rbuJKIDBvXK6M4cVmAuCtckIwoTw=;
        b=Jcdm3lF9cp8hdxyA1TwTCKeOt1k7pIzDXoX0hqrHYLxKeb3AfnRRFLXutukwxM1zlI
         Jey0VeGuBo/ok6OKMEKzifL9VZlC2ARHb44yKW3yQp9Fbr/MZh6SimXBWy+CVKB5WMav
         EgGxVK27zpI61WY6MvWJoaiExBXw6QS8BUNn+hZIlPy/rpEo0B9KfHEMx9WKcrsJ4RGN
         DIdErZODu4/EUrOXxHui2sqQYEMwsc8qRA2xtEHPT8G4yFIMtrGKgtqQxOlnhJq2O9UN
         7sHDYTB3i2Os+S3Kb2meK1s0wDMgtZ0QyFRGAOTGTwg/BBkaGs1uwNaat8588vxOxiCk
         moBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855237; x=1760460037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T6AAskuAQMA+z0rbuJKIDBvXK6M4cVmAuCtckIwoTw=;
        b=WhgcOcEoV42UEcKPhIKZI7VgiDhWkcOLaHH11P58jYnX/RkUkQEQ+M3TSgMdLNQULl
         vh1YjTf5s+oxBf+XuVQOkTnV9uGON4Yb/kC3Tb1AvgPDMgF+RHTSbCv91kITC5UYMlhq
         +sqB/Q1b55lR0r9JblcZyQZTwvxcyXOIvZDjwlYCy65LUSYOkTM1M/J5uYnIBQIAbnLN
         cKpWt7jmlOC23Ja1eklo/+J8JWme492kd4JiTMd08Jx+oGtDG+2rPECRl0UUgB8Sx8/x
         jpa+APRZdNBfpxSeZn7uLfOc2NN+2Jq1IBuKyWJENVQiQqVhXrszqWqWXnyhF4PaWJ3i
         S0gw==
X-Forwarded-Encrypted: i=1; AJvYcCWMsgawxSUOZ758i4W2vVt73PBtDiG96Z2x4vl625UqACqG7BkBhlOE/q2i9Jlt/4KCiga1K3mhJ1xDPFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywNe7w/AW54+p/8UmFOkT2+FwcEUiOpGtyf+14tjzDmIZcZz4i
	79V8OQJKkzzbto9rbaIP97IRGKSCyD7jpd1uBeRVdIeVVEgDcSOXJ8icT8OAXKQRmfM=
X-Gm-Gg: ASbGnctpUePK8GNnkPprWA5bcXupa597xzrZOc/oMUN0gh/dfwMaQLS47Lghyq0DBzw
	9ZLHiI6lGiQtTG0DnzZGE9p1a/FLccVBssKyXei9TMjWBfIS6e6xw6LW5Ccj3Bm+pkrCZFo9Joe
	/Elcz8wnGl0x7pUyrx/YFJCmh7XuA9jwRyIWm0NfrPUZ/6OTRS9DSv9mIxPbskG5j84bNG92qEy
	RvD4tt1o4shUq0+xrwylRBcPriIIHXGFuMtQRFjFLr4NXMXJ6s++u1RxQrAAG5IhprmR24ZOS3u
	UghyoKttpmbV/dIyzvupUDHCFwyGK0tR1qcNfr7rUJLxgEjprJhSMwJ4Gtb0TNX+YkKEzsOHWFS
	xLmqaOKw8K5eZGhz1nCSk4hMIYp9i2m0MEE9+5w40CW4dooi+mjnEQoCO
X-Google-Smtp-Source: AGHT+IGlCEBhLy99r0MwbwBabTf5K5u09aQHi1qXsVdU6U8kDvKm7mhQZ0t1bgVq0uYvoequQknBLg==
X-Received: by 2002:a05:600c:528b:b0:46e:5cb5:8ca5 with SMTP id 5b1f17b1804b1-46fa9b164edmr2084845e9.35.1759855237338;
        Tue, 07 Oct 2025 09:40:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8f0170sm26956211f8f.49.2025.10.07.09.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:40:37 -0700 (PDT)
Date: Tue, 7 Oct 2025 19:40:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: ulf.hansson@linaro.org, zhoubinbin@loongson.cn,
	u.kleine-koenig@baylibre.com, chenhuacai@kernel.org,
	david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
	khalid@kernel.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
Message-ID: <aOVCgXnHDnErCLnu@stanley.mountain>
References: <20251007161948.12442-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007161948.12442-1-rakuram.e96@gmail.com>

On Tue, Oct 07, 2025 at 09:47:44PM +0530, Rakuram Eswaran wrote:
> Smatch reported:
> drivers/mmc/host/pxamci.c:709 pxamci_probe() warn: passing zero to 'PTR_ERR'
> 
> Case 1:
> When dma_request_chan() fails, host->dma_chan_rx is an ERR_PTR(),
> but it is reset to NULL before using PTR_ERR(), resulting in PTR_ERR(0).
> This mistakenly returns 0 instead of the real error code.
> 
> Case 2:
> When devm_clk_get() fails, host->clk is an ERR_PTR() resulting in the similar
> issue like case 1. 
> 
> Store the error code before nullifying the pointers in both the cases.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
> Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


