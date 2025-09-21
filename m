Return-Path: <linux-kernel+bounces-826368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BAEB8E55C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8D817CDCC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7B32951A7;
	Sun, 21 Sep 2025 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="cmt4qfgY"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318AB285047
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758486683; cv=none; b=PUCdHP/EpoJIALS3iHFLiOv8ut+3YisNiqe9b2v/io08DNc7GlbeVP2GT3KpM3dd+VvPhhBQZSTgnEaXjJEgDEwK7L1hJf7OWlMyP+2pow6l2k8neuJ0J8nda4qHn+qO1r7qyuSr6ncvvRYv84ewQ3jlHFfcong/CCiXxroWBsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758486683; c=relaxed/simple;
	bh=axBa+dj4HB39cZjZhfEDMsv7hHO/HGQu9wvFL/Tb50o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dV2hJlLkdNTW249Q/ykPPV9IlGOpZgIgB+4lVC9K/cT/SNK31OZ4WkcZAnhKN+gf6crbKVpaMnb7ZMk2sHJFCfRotG7vehxj6MZBdEVtVJBuZjgupk8Hbv9VvcSziOY9ci0ZBXRIngWYPCexfhkLeysGVcK099cLgF6aI4Aupi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=cmt4qfgY; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so2374652a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1758486680; x=1759091480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkhSDdzj5xF5sJ0V2SWAfan5oCRu1CDItuZmMcAwdU8=;
        b=cmt4qfgY0rqq6Br5RaczcXRcaBMVywDqB79KkIc4iPi6cFOM/67cZZkHfXs4Xs0lcR
         R9nhehIEurouWlb7OR6O3n9NknlJux+jwqocnWOIQYtKZM/n0LUUqXlL5jH70nxWTuGF
         F3c+5BGZWJqe2VCpbQ1ambVKka61qEFDRwNlOwTLt5NjS3lKjqHxMDmLJFjx5VlK6IEK
         JJyEYzTvcBxjZplxysOUv5TKbaCikuh9OzCSm7aIpUM8q5+ONUh0GJsK8OAY4qojloBI
         8NvzC6xhfwf7QMAuFnvdD9wFJB4vGPSIw/Yg7PrY8d3K0/3aKM5jVw3QUedcnCGXQJUd
         3DpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758486680; x=1759091480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkhSDdzj5xF5sJ0V2SWAfan5oCRu1CDItuZmMcAwdU8=;
        b=Rc6GGfihETMCT+7M0AOQsTqW2eM3uIaeJu0gV409x9bP9XEFqVKaSiAzWy09FDN4UK
         35Z1gvZL+P3Zf+ZiXcpoXu9zAme+QS45rJHHgdq5NcvI+olyu5mFsp8BQGgpRCrihQbg
         ibe01ufmkR6xGsd+QUVL/a+Z8TkMMnpswrckExtMUCxA3pZPgM1fpvAUuYUQR+OkQthh
         GTf6AR6XpUM/xX9GqrC5F3SYCv0UZxq7LZ0Lxlqra7E6GGkz1QiT0xMXwaeX5LufFKxK
         WgPoPLMJNB+yPI73fWk6rH0mk9ve0EihclTW14qQdgLHoOVbwBD7Hlg9HMSCsDBgwBue
         mBqg==
X-Forwarded-Encrypted: i=1; AJvYcCUnwbvaOv3R43aodq9sKskwKgJaPnQNxrUgWP6gk7RR9iYlePxGLyobp40kPt3tVTMpFgETPogxgE21xtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+TtvEO/lE1g4WuQdmDKpKTafMjyC2tpI8KQd80f7/4YSOPK9h
	VOFTsAVlbeMPV8x2MPwwix0E/3q35aaUNg68P+Vd4Fj/hSv+hi3uXJrxMv4G38IGUCQ0
X-Gm-Gg: ASbGncvXuwkEOxc+Ds0PrlVp1Q+FTdaR5JD2ShSx/kucoVhY18ktW/Wg0Q7YGo0L7j8
	1MprXt9wkISKyDwjJma+lC1ldAquuunCUPTKrEAiFdS3LpT4ZjC2nhzATtn203ZRGIi2ptiRpi6
	QfcrjSrHVTSm9xQtRKpU8eQQw04kg9G00AvM7EMuBPeLUqdB78nlusQE7XwF81keF1CZGUdn5wY
	IsGnZ20NHPLWt4rOBaAJuH//Hr3L//ULE1juMI/7v3FFGf2DaRCnaJ4IhGkgRcmx8ckFtoqOArO
	kITsxISc2wtJ4lVSFFF6TZaVMcmPGu3ylNGypOQVGdgtqQy2jrMK+kF2vtr+NOXYW+7iUYq2yP4
	x5QKhwPFzlnqmhOqNxxz9hwhe
X-Google-Smtp-Source: AGHT+IFced1ck500UG1sSQ2oA5JIKQTgG9625dNvOnPrh1McuPXBq0dD26/IITzmWfDQV2NcSL0qiQ==
X-Received: by 2002:a17:90a:e703:b0:32e:7270:94a1 with SMTP id 98e67ed59e1d1-33098356f85mr14880190a91.17.1758486680541;
        Sun, 21 Sep 2025 13:31:20 -0700 (PDT)
Received: from sultan-box ([79.127.217.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb79c2esm10647810b3a.2.2025.09.21.13.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 13:31:19 -0700 (PDT)
Date: Sun, 21 Sep 2025 13:31:15 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Bin Du <Bin.Du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com, mario.limonciello@amd.com,
	richard.gong@amd.com, anson.tsao@amd.com,
	Alexey Zagorodnikov <xglooom@gmail.com>
Subject: Re: [PATCH v4 2/7] media: platform: amd: low level support for isp4
 firmware
Message-ID: <aNBgk71V1rvYqiN7@sultan-box>
References: <20250911100847.277408-1-Bin.Du@amd.com>
 <20250911100847.277408-3-Bin.Du@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911100847.277408-3-Bin.Du@amd.com>

Hi Bin,

On Thu, Sep 11, 2025 at 06:08:42PM +0800, Bin Du wrote:
> Low level functions for accessing the registers and mapping to their
> ranges. This change also includes register definitions for ring buffer
> used to communicate with ISP Firmware. Ring buffer is the communication
> interface between driver and ISP Firmware. Command and responses are
> exchanged through the ring buffer.
> 
> Co-developed-by: Svetoslav Stoilov <Svetoslav.Stoilov@amd.com>
> Signed-off-by: Svetoslav Stoilov <Svetoslav.Stoilov@amd.com>
> Signed-off-by: Bin Du <Bin.Du@amd.com>
> Tested-by: Alexey Zagorodnikov <xglooom@gmail.com>

[snip]

> +++ b/drivers/media/platform/amd/isp4/Makefile
> @@ -3,4 +3,4 @@
>  # Copyright (C) 2025 Advanced Micro Devices, Inc.
>  
>  obj-$(CONFIG_AMD_ISP4) += amd_capture.o
> -amd_capture-objs := isp4.o
> +amd_capture-objs := isp4.o	\

Remove this hunk since there are no new objects added in this patch.

> +++ b/drivers/media/platform/amd/isp4/isp4_hw_reg.h
> @@ -0,0 +1,125 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef _ISP4_HW_REG_H_
> +#define _ISP4_HW_REG_H_
> +
> +#include <linux/io.h>
> +#include <linux/types.h>

Remove redundant linux/types.h include, as it is included by linux/io.h.

> +
> +#define ISP_SOFT_RESET			0x62000

[snip]

> +
> +#endif

Add /* _ISP4_HW_REG_H_ */

> -- 
> 2.34.1
> 

Sultan

