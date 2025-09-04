Return-Path: <linux-kernel+bounces-799977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 843CCB431E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB5D1B2637A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F492459C5;
	Thu,  4 Sep 2025 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YbFApHCM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC01758B;
	Thu,  4 Sep 2025 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965767; cv=none; b=hUlaIRxWSeztqPj+ogz/dmNtKbonVtVhyHaYkN3kVYJHGO3VHRnOiYSWZgZ1+Qrn98OBSDyx4hAvZZrEWcOS0SqJTcKjdlcFrOFfLaB86p3yW9t788EF4HYu4Q4KRaapMQk8JYBqiWqpoV/iRioeTWYvO09pqkqVltCRau+5L+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965767; c=relaxed/simple;
	bh=090gkLICbGM7TNk6kExYlvvMe+p36xr/EilWtJfF52g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsXTyR37y5BAEJa1KoPs0f9sDkUCA9+inGYdFTjEeCb8chqBU0WUxgBxCOKIR7qShmdAT2GAlF70vudPyuUpT7gzwl4d/Fs9CszLM+FrcMTNGIlCEgbjQtZNw6IADVs6lIEy2gk+uewiEJ/lmQ/RCGa5EHuLjXYrKVwVpPmhbNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YbFApHCM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756965763;
	bh=090gkLICbGM7TNk6kExYlvvMe+p36xr/EilWtJfF52g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YbFApHCMtpPV7aWtDBimSagK7GUlxOLsVOhn2efk4y6D7WTKDqaDKNVh2Qw5HJa49
	 YT9K5uzYEUyhQS4tVDJXDUPkez3c6hNvH38OH/cZNvjSnvu7ia4Ij18GA5LV6Nq6aV
	 dkR5BklGOP+AfqjjFFrWhxfvzfXqo76Pd/BqUJsAJtyPWxrIv0x2N1PJvUHzlOrleY
	 wn/HCFCbSnr/lLPiHhxWv/EvkVBbjTFRlzLfvnUDjmh3oNbYKqXK9g1nFX8YYFBd8I
	 L2b6AYtvTLSQAsH+Kj07nc0Q6XsBsZR+CrMse/+ajzchGiixuDRRdt6isiKPzCRsTG
	 nTvYqllWSba2A==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A221A17E0EB8;
	Thu,  4 Sep 2025 08:02:42 +0200 (CEST)
Date: Thu, 4 Sep 2025 08:02:39 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [RFC PATCH 2/2] drm/panthor: add initial mt8196 support
Message-ID: <20250904080239.779b5e24@fedora>
In-Reply-To: <20250903225504.542268-3-olvaffe@gmail.com>
References: <20250903225504.542268-1-olvaffe@gmail.com>
	<20250903225504.542268-3-olvaffe@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Sep 2025 15:55:04 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
> index 02db21748c125..75e92c461304b 100644
> --- a/drivers/gpu/drm/panthor/Makefile
> +++ b/drivers/gpu/drm/panthor/Makefile
> @@ -12,4 +12,6 @@ panthor-y := \
>  	panthor_mmu.o \
>  	panthor_sched.o
>  
> +panthor-$(CONFIG_DRM_PANTHOR_SOC_MT8196) += panthor_soc_mt8196.o

Based on the stuff you describe (ASN hash, core mask read from an nvmem
cell, extra clks/regulators?), I don't think we need per-soc source
files and per-soc config options. If it becomes too HW specific (no
abstraction to make it SoC-agnostic), we can reconsider the per-SoC
file approach, but I believe it can all live in panthor_drv.c for now.

