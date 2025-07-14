Return-Path: <linux-kernel+bounces-729751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD17B03B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551A31A605BB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0861C243946;
	Mon, 14 Jul 2025 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="16kThx4o"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0E246BAF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486061; cv=none; b=tqUH/ru0dtA1xTT5M5jK91LZ0Y2/LAufISKDfpV3Jj9a3rnW3jMvsremvcZaLWkXnwgAiR8DjLs6qJWUUKcHPsdp8ykunR9tsXYMDYV6i7+y5tKQq++n92kgKSj7hFqXV5aP98tcv5jBuoVpfIZTLTI6/Gi2NGbuJsk9Nze94nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486061; c=relaxed/simple;
	bh=Kdry2gVbb8miTXmXd16rrT7u8YzjkAcFEZdjgAgPfA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WwFZ2/HSO3wlXsPrKQUeUHF/HUjSxdHgKdZ4z/Ok6bUiBqlIyhZLoIZt3HZUw7brwbO3ip/xHZBt+ean2g5K7qZuueH0gjT+rtyaRHC/+CzrqqioIFYnPwAOfRygGZlsZQ45HNFQgtOogBa8OnN/Lkff0n9g9OED5R8eUf0+FT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=16kThx4o; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4561ca74829so5446815e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752486058; x=1753090858; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBgGdTksVfeSjCf4/icT/1ch7Jc0HArkGcJLo9ytMP4=;
        b=16kThx4oc14mDeeieiSvzRjQ89+o8CCI83t9QLL/FD3l4z/vCssXGL1k6xLRfdwE6S
         d8E5/oHcTpMgCXrkzBvHFznmP5g3jFveVA7nkgeMtzsTMh2hMcqKaeiZZUnj+XQ2Gxix
         C6hZiQ2Om6qReeW0Bwv9uoLTSAEFzV0I4bMEB++hD6MOK4LlhAlyCjrzsyQB2yEt12CN
         yoUtyNOp9VbQYqW9NBxTEtDdL25cBCSJskA4LyzIlDQkPQ/Fc15lG+jju+c4jMFQK85r
         oVQQXSeMmX0h896ATKReGbRfshP/+xpkGN3MNVaNCLqrAGw2qO0cxvq28hmP8ws560JV
         uKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486058; x=1753090858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBgGdTksVfeSjCf4/icT/1ch7Jc0HArkGcJLo9ytMP4=;
        b=cnxh8J11hXofSyCeE2JtfpF0biZhNBf1NtGWHdtyVsQE9a7aX3Su4IWk2Xb4aHt6gh
         eIs+l4OerCsEIt5WtPZJGqArEh0Fu+GUMMq7jtis9e1YYeT1mp6g2OTCw3P4ZKmCntJj
         qtOuh9Su8X0qnr09QmCAlBom37cSyWJxJW+pS69cURvlVXoEoUQyTyH9EvEBBqzgHFQx
         bxYMt1TSdCO5oMA3P7oy91qo69sa0ZnssaAz1qhS2Son6KgJBTywMuxmT5h/OTc6JDM1
         QMC2wivyIiDuBiHNeuVynQgU07aihNRad0EwQmtAHqzPOBLR+6k4pmO28oq+B0FUXbSk
         jnog==
X-Forwarded-Encrypted: i=1; AJvYcCWiUpa3A2VijPjXzaN51QOug57ihk5tANRBiO2eN6x6uUINn3faTL/ndfc5FLWufbt6nC2nNcKE98Sv0+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydG90bwkqYk3P+DXke0tvQsP6Pmd3+xq20D3CtptEILwzPVy5N
	+goYH8KIutSrtIyULQ4LtlF01ZBTHlS/Th+shfDZYBYgY1UMhLKztKvSfzWQi2Dep6Q=
X-Gm-Gg: ASbGnctxOKwnH/zH+yEieO8vrjBM44k8oEkXVQ2Rv9Z5gvbUonTUqLdz1QKMUpT/GXd
	MVTdNRmavrmm9mG0tPSeqjLEFAOOLVccrhu20dSErqIeodRkhhjmY4oVxM64eWlCqPOWYMLDkXG
	Wa5E847UhpJl5r+6xIMTg2cMKxcQSJZDrP9xSVDajjXLvG74sIw1CtkYqTPRS5ucOCd06CG4SrN
	pHmIEHgM9CSS+xoZ/6bY4WZglsTn9QvYixoqRg8tmDMrhmau7Tow0J6VrpEodHNzrF1J/4zC07B
	SLHIIDcJNDF8cVmqsUm29bWrXK7yjKnImTp5L1zKuOgpsdk9xtLj546Hqgdmn9ZZ/ZXfONWN1A=
	=
X-Google-Smtp-Source: AGHT+IFZBd9BqIW4mTa6M2LIKLJ6VdBKVXcqNR4ZLAhmo9BpW6Qpf38x6Z4W0deTyL9Fnv8RWBe2kw==
X-Received: by 2002:a05:600c:5024:b0:456:1611:cea5 with SMTP id 5b1f17b1804b1-4561611d3d6mr36347635e9.18.1752486058120;
        Mon, 14 Jul 2025 02:40:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:0:1:2::3035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561b25a948sm24989035e9.35.2025.07.14.02.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:40:57 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 14 Jul 2025 17:39:35 +0800
Subject: [PATCH v3 8/8] riscv: defconfig: Enable MMP_PDMA support for
 SpacemiT K1 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-working_dma_0701_v2-v3-8-8b0f5cd71595@riscstar.com>
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
In-Reply-To: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

Enable CONFIG_MMP_PDMA in the riscv defconfig for SpacemiT K1 SoC boards.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: No change.
v2: Rebased. Part of the modification in v1 is now in this patch:
     - "riscv: defconfig: run savedefconfig to reorder it"
        , which has been merged into riscv/linux.git (for-next)
     - Link: https://git.kernel.org/riscv/c/d958097bdf88
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 37c98c0f98ffc0ee9d021e4d07aa37a27d342f7a..b6519fcc91c0bb56f71df336fd3793af3d64fe78 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -240,6 +240,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
+CONFIG_MMP_PDMA=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y

-- 
2.43.0


