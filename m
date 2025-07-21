Return-Path: <linux-kernel+bounces-739540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF6B0C78F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9425A3AFF54
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CFF2DEA6E;
	Mon, 21 Jul 2025 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mdrgcJ8E"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2A2DC34A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111610; cv=none; b=i3CVUyvX2ppgPtLrVNAw5Ie3SNbeLVrKEOMgG9U4SPrHw2EWYIM8xkg4WKF3Sr9KrOlmniHCOdTP/TFMbeqkRVPlq7/Xp7yTGAbs7U7YyPUHSh/aix7WVwRfS86cmU6ARX+yP+XtVAj1LbFdWuVDesUaZCe40xEQ/O2udNy9Xbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111610; c=relaxed/simple;
	bh=0GbzMT4cxkh07IwyP3DdnTSFHzeiMjC2PgkP6D9ZjvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPIT2JYkuNJ2R3BRVUJ8RrP+wmxRsjwz0wtbV/Uc5ksiQ3goE5tROtWByEbJv5jWqZ2568lM91s6SVQae9HabeJzSn1XfEIZZx3aRr4rfF1jRhHKLnwLJLq0VbOWceVtBiZBuWzOoTxlv7ywMZvXoEKgRjmHbawRTDCyL0w8UF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mdrgcJ8E; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23c8a5053c2so41835635ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753111609; x=1753716409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLR1wp04znb7ganRU49PBBxXl6E5Pbigx4KLe0tUHgw=;
        b=mdrgcJ8Ezl/clxryyuQ1CgB0KTmz3asdP6A5o3HfykB+5kTJuSippBBDq8ShZ97vbH
         ouBxsx9KFIpOMXK2Ev/vDZvTGhVaA85fdcyKJHhIuksKU16OMOasipW4//1/kYSFjKaw
         NXYTZ4VniUBENguG0pKMpcfrFV9LA6iJxHaKvuBNev7fQ6jY47GOr7BH96KCnXjPaBGd
         CelpAT9zN+ySgSf7u0nGQydwJbD8elznm9+vjnepfQ5tCrLuVxRGJrS9MzQydbWjQqzM
         M9WeVPsnFML4Kz1G72xrlchOrIOSb0EeR7NuZE/YC15Z+rr8/u88BOrKnXpDX0NvPiLC
         LI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111609; x=1753716409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLR1wp04znb7ganRU49PBBxXl6E5Pbigx4KLe0tUHgw=;
        b=D3p+9OFJtd/NXvbs07vBzjWEIisA8woq5lAlvi0RxPl8ujSsqNn82O6rfQIdened4G
         fWRiM6GXI77g6Zhi4krzNJ+8pcQd9cbjVmayQPpaCzmSY1gUvG64k8QwoiKb4AXRU7Nn
         6QvIwYnCLueK32ua92I3qUnJzIEVQfGf1vk6vIizNz07qMoii8I12RWQKr7sQwHOwKiR
         /6PLidsY7nf9jh8WgXpMkCfBLlXEO03WZfb6hDxoAYv0SORwy3T55ulA+AV53ArB9RtX
         kEl9bHBrFibaVDj6PYcchu7w0q1em0MZ2xQnaDDN7xOLfqi8UM2AE8qT8JaH74VLiK/j
         DOhg==
X-Forwarded-Encrypted: i=1; AJvYcCXEFSjHBKDua7JTU1keoJHVhEBpTzwtjcVGTuQRrC+MQqC7+7O+hT0EvKundmBswng7pbT812ppGj72Mok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/3HfSq81KkGdrmVr0kuftZQK//oE2lq7nn+kR7o/oVM/qn/5
	sJqe6BREkEe745bghgR88+2+wtoltwm5WGEzQI+AhJDvCXtd2wZU01w3qCHQP7mUj4U=
X-Gm-Gg: ASbGncsSSyY9U9jEEHlDQ9G32u4tXK95gPahUOlKp+ZX+Aeonk2uUv0T2RjdOnBroZ+
	8nQ/x68ODydO5oFw7athu2J2/7qNWDZdAY7abZ05K+/mmFOH+eCfYHV/lzaHDaNUKmVsd1h0hgu
	XBSR573Tf+oLZz2KMifC3wXl6J9xbugChbHEyo//WO97voz++BD6DfnSaVIKkgdwPdveDBytTnT
	eaN6PiAAp6YdefUJzuKfKwMUfCyUYY8qFBnC0oUxqeXSwp2cxvzFRgeufgUiK1in5BLVG8YAncl
	Yocaky3b6lijRLgIcNKl/MkzoxNd2n6m76f6gCxJJRR5Rhg3mN5rcJ8bMnULXJChbZMf+hrjoos
	+VZ755l6RmDhix7W4VreNRUyV8g==
X-Google-Smtp-Source: AGHT+IGZq5M24ox2EWye60cGVP1R1oggzOracSjmWPc1HuG98tMs47u97doXLxqik3MWrc6Y1CEeLQ==
X-Received: by 2002:a17:902:c405:b0:236:7333:f183 with SMTP id d9443c01a7336-23e24f4a679mr296932965ad.19.1753111608652;
        Mon, 21 Jul 2025 08:26:48 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:8fb5:9396:b7cf:1f69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e4918sm60080235ad.41.2025.07.21.08.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:26:48 -0700 (PDT)
Date: Mon, 21 Jul 2025 09:26:45 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] remoteproc: xlnx: disable unsupported features
Message-ID: <aH5cNYY8_ai2xvY7@p14s>
References: <20250716213048.2316424-1-tanmay.shah@amd.com>
 <20250716213048.2316424-2-tanmay.shah@amd.com>
 <20250721065724.GC4844@nxa18884-linux.ap.freescale.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721065724.GC4844@nxa18884-linux.ap.freescale.net>

On Mon, Jul 21, 2025 at 02:57:24PM +0800, Peng Fan wrote:
> On Wed, Jul 16, 2025 at 02:30:47PM -0700, Tanmay Shah wrote:
> >AMD-Xilinx platform driver does not support iommu or recovery mechanism
> >yet. Disable both features in platform driver.
> >
> >Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> >---
> > drivers/remoteproc/xlnx_r5_remoteproc.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> >diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> >index a51523456c6e..0ffd26a47685 100644
> >--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> >+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> >@@ -938,6 +938,8 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> > 
> > 	rproc_coredump_set_elf_info(r5_rproc, ELFCLASS32, EM_ARM);
> > 
> >+	r5_rproc->recovery_disabled = true;
> 
> This does not block sysfs write if my understanding is correct.
> recovery_store does not do any check. So even you set it to true,
> user could still write sysfs to set to false.

That is the case for all drivers and not specific to this one.  

> 
> >+	r5_rproc->has_iommu = false;
> 
> The default value should already be false. Is there a need to
> set it to false?

I never mind to see things set explicitly.  

> 
> Regards,
> Peng
> 
> > 	r5_rproc->auto_boot = false;
> > 	r5_core = r5_rproc->priv;
> > 	r5_core->dev = cdev;
> >-- 
> >2.34.1
> >

