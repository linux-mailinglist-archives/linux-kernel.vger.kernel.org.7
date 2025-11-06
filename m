Return-Path: <linux-kernel+bounces-888559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C210C3B324
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F36A566855
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF1E32F755;
	Thu,  6 Nov 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJB+oMwR"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4022132ABCA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434508; cv=none; b=gWHdmatLNxdX8aY3J/9uBL4X1iYxPvCnT/y4E2GM0WNk0rC+jmV7VOUaAfbNBNPwPMO5c4eU2LcUe6GbpQB5CVAe94aKNqAsKS4qhgZh5nnTOA+fMjrrqLDJYFp/mXX/kViUH1kdzAamXIw1aoF1NWT+ffZXfcCPYyQs0NjLSoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434508; c=relaxed/simple;
	bh=8wi8v4pafiCAVW0LlbviwrSq4+RD7ApxtwSAV0zAito=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ny6CJYar3jpneHLnGGpDn0VBUnsaYLGXHm6nYUzuqoMj5xGqVbeNQafTB5j3Gz9/gCXksX6yiExMX7yIJQreoxA/rbGn5cOPie5yUdYVIFhL3GupTl86E+uus7rQJFZjJWfqL4N+q3TXhsdp/SA/tpIwLAqGqIzI857TucxDYYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LJB+oMwR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b72b495aa81so12795666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762434504; x=1763039304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=enqwyA/A3yCA7Wm2D9J7INIOgAB6+/16vEu7wgpBUcE=;
        b=LJB+oMwRSDYLXuRamc4Yk0Gw9JWPilvB/no2q3yEKpNvGkLorI7/qJnepZvbp+uVjO
         JAh4Fv5g5QxkDhU58OGkOQFwgHs6ZhaVX/K3tYx9PPjIcW3N+VGZwgRLO6qSZIUl08r/
         zCH61rkoVO4696u8ICgu8dk64AKzmRZMqQ1Fq5JhkMSPTR54bPZb0jrJecfmfnuzyh+9
         VeizpinU402Z0f6oMfRkwdxgGm9Sl1rHnFatOM00iAHZq1QLTasGaGeL/WlakZOD12zu
         v63XwyjeS/lBOaz30sgqU9yCO58Edu3bilru+bw2dE0g7BllDoOoc9G7U8u8uObfarSj
         uYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434504; x=1763039304;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enqwyA/A3yCA7Wm2D9J7INIOgAB6+/16vEu7wgpBUcE=;
        b=FH78a6S6YLBmaW7NcJfJwEgYZiQ2B0UipOBPaziNc7BnRwI+ggymQ+BK3PuQPJbY1Z
         7aX5dHG5ziHtrP3AoWWMi0ahOYawWFft9A2mWj2VUKQ682DTxa/RxquPTDOyP/3GVDxZ
         amiwocaOlJfLIvRlNLyQ4BG8n+aKT4MbOT0SMsC9Rbow3PMnDY40lA3SKwG3esVL/7k9
         hEFyHDPh869ra17TpLeLyjlWfO9oRmSc+wPTqhMz2yewDUHKzgG26B92DSCejgQcmPSQ
         94dT5Q4POK03U28vGwXHFal3YXXbNxOIUzTW9M1uj1UtEAw7Hb1N38BnMNru4wv6sK6S
         bDtw==
X-Forwarded-Encrypted: i=1; AJvYcCXUabXdqyKW4XaeNGZCSy9AYI565Cm8cTEvFSwoQAMt82ZquCSlwWB4RJHidGraDKLF077WlOdRR/Sq2NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwmIIspfb4L4qwNvvGweLnzxtE19EIJJbw0QEzhG1MqewOOr+
	BY/xBC68PhYgORpdzJlKtCwwUi2kxFOu/UiH9RrHtA1MLFIPdhLhvacCOTt+KwDNVTg=
X-Gm-Gg: ASbGncvzijM0uf6fkv9mHhTuoHsms8ikI3zbBfZyT8B4SRmOaPTx33AkDtEzVXJO1xZ
	8HHBTY/ZYgz9fgiMpE8OWg2OQG8xM0hNskzAfePXBtwOoCjzggWqyddQHIxUcLI9BgEQQeOgwKN
	xeoLPBDlJ3d62NrLGfmFVGH0zWKaNTSU6CgHL63FlRMp8mU781ibM6guxadvLk56+00Go5ieuba
	zWLipFYn3Iyy1em+fy6ed8hhQlVzQQULGkg4mAfeiWXo8lwCMxA3IFAPXNztrk57VkkKl1OPPv5
	hfyAanhDnyLkgogVBnBLDXpHCYgD3Gw/CGfWu/NYzyqGkumUdotkuLHL8yx1GkM+rPqdiKk1Ww3
	BROpvf3wANXwYhx+ro7XOLVDnrcnmeAq5IixOrionwl4j8VLo2SzIprwrpcvV4MRGV5B5oY0qUU
	iSJxE7BHMNpApM
X-Google-Smtp-Source: AGHT+IFDbNceai8kygqAPsrd4nZO/xDH+qcQBTNTFiNY8JYz+2UNeSt3srq3B3R4fGOrxSuhtxFg2Q==
X-Received: by 2002:a17:906:c103:b0:b70:7d61:b8a5 with SMTP id a640c23a62f3a-b7265603d1cmr729211766b.62.1762434504394;
        Thu, 06 Nov 2025 05:08:24 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c8e29sm208344066b.74.2025.11.06.05.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:08:23 -0800 (PST)
Date: Thu, 6 Nov 2025 16:08:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Francesco Pompo <francescopompo2@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Pompo <francescopompo2@gmail.com>
Subject: Re: [PATCH] efistub/smbios: Add fallback for SMBIOS record lookup
Message-ID: <68a428fd-aad8-4540-a509-d33ba116b5b9@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102001411.108385-1-francescopompo2@gmail.com>

Hi Francesco,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Francesco-Pompo/efistub-smbios-Add-fallback-for-SMBIOS-record-lookup/20251102-081803
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20251102001411.108385-1-francescopompo2%40gmail.com
patch subject: [PATCH] efistub/smbios: Add fallback for SMBIOS record lookup
config: i386-randconfig-141-20251103 (https://download.01.org/0day-ci/archive/20251104/202511040131.8yGeRa6u-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202511040131.8yGeRa6u-lkp@intel.com/

smatch warnings:
drivers/firmware/efi/libstub/smbios.c:55 verify_ep_int_checksum() error: buffer overflow 'ptr' 5 <= 14

vim +/ptr +55 drivers/firmware/efi/libstub/smbios.c

d45578057224c4 Francesco Pompo 2025-11-02  48  static bool verify_ep_int_checksum(const struct smbios_entry_point *ep)
d45578057224c4 Francesco Pompo 2025-11-02  49  {
d45578057224c4 Francesco Pompo 2025-11-02  50  	const u8 *ptr = (u8 *)&ep->int_anchor;
d45578057224c4 Francesco Pompo 2025-11-02  51  	u8 sum = 0;
d45578057224c4 Francesco Pompo 2025-11-02  52  	int i;
d45578057224c4 Francesco Pompo 2025-11-02  53  
d45578057224c4 Francesco Pompo 2025-11-02  54  	for (i = 0; i < 15; i++)
d45578057224c4 Francesco Pompo 2025-11-02 @55  		sum += ptr[i];

This loop reads across a bunch of struct members.  We would normally
use a struct_group() to say that all the struct members are grouped
together.

d45578057224c4 Francesco Pompo 2025-11-02  56  
d45578057224c4 Francesco Pompo 2025-11-02  57  	return sum == 0;
d45578057224c4 Francesco Pompo 2025-11-02  58  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


