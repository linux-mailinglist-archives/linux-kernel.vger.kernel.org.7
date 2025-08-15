Return-Path: <linux-kernel+bounces-770194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE99B27858
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA94AC0E53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6F02BE62C;
	Fri, 15 Aug 2025 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="AMcKf4Va"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0BC29D29D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235112; cv=none; b=Ms8mpM7l1STBu96efQF0gKMLiPMYDFtO0fCYkQb6sRV637zDiHxmtZPGkvVc9RGgfPa/iGvKH6c6+2WI6Qk52Bgwuuv2P6IQ8BQS6kwoBuqrJmlvaHlzDrkCEaHu+sDdZc/E+ZYrj442XazOI7hBDnTkOCDC/NTugMdRhgz4tkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235112; c=relaxed/simple;
	bh=GE9SRjuuSCv8a21ZTqK+ILZ4fs5VYlehz02IXPUa02c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DljcpZXa7/T2BDji/eaxwo8wm3WILpqxLXO0TS5KoGV44pB7mx5XI9ZDDtki+A2kVjCRBr/HN3oCJGVaUObz0f5UeP2pvzKAS2eh9I733IWLqKJyY1m8tCJE5xs04a9XsBtzF/jCBQ7SNcDAahC3zv86nAGKZmvaD5m7RxgODG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=AMcKf4Va; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24456f3f669so18061515ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755235110; x=1755839910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gc4I4GnyT4tSPzGGnUSG7Sj2q1K77d2MqUPufhFRRW0=;
        b=AMcKf4VasHexc8B/jr4YdlKYUh+mAWofj58kYoRsXlUokFuYawfhhxzYh3rJr7b5nY
         3RhlAfjS+YPQE2tuJp1jaoBpb86FNqXb+udDmv/7ne1C1nxol3fcWCDdHaMMTFzMBFUC
         SDbcecJwXmqflcs6nUsvzNhxNG+TQfU9VsYnutsSeNkiIaYjBZundHbHer1zz3zP37L2
         nG12PVeSv3ggWjxjrAlhVO72qakIJLTO4tHY5vImaZoNhMdJQeKZzz7v1dI7HoPU+T6j
         iPAFdJ8SJO82mGN/JneFvPP2NBFXYtKnh+Fyp+kG9GVBkqbgTRICZUydP2XX8rbzJo5c
         EnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235110; x=1755839910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gc4I4GnyT4tSPzGGnUSG7Sj2q1K77d2MqUPufhFRRW0=;
        b=G/u1JW3MsoGvbrzRB03gopIqCUZPwF5dXA9BfIz8B3nfLJhJDIDral2X6512+uucVu
         5NA+RozIAn7xXEDtrL7hvquE/X61GGusMcPpgh/1cfQd6Ib7Pioczwgnj372jYHvqk+V
         KYyKkn3DGzHXiC7prwwE2ZoPuoj1xEmJXnx8pr/Lx/+ZTIr61DQQtNb30dEO8p9ErnVD
         22SUMku0n6d/mC8z1JizvOxNPTLNX67PPn6BjYS+9T50mEgE9d1YKvMbk4x/xdddoPSZ
         tQC2n+dGF1jdzbPD/WTWzVRZFvOAGOsE1C8ksLClogjDcQU4iOHxaItMgwP7+8E/W0Cm
         akAg==
X-Forwarded-Encrypted: i=1; AJvYcCVfaYKTrHNmwptNT1VTBoU+pWnTTz6i5T3xWDemLcCHLA8P0NIpgfLjFOsWyhAZLHHdn0E5JkOLaq0G8Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyyi4A+xmXgliXVl64JyjzdnlMCqvwcrJHW22x6Uk315ztZGj3
	d4ivmFAWLeeReHcN5twQbzapRx7ZFm3AVPMpfWBhVYkQUovhw8vMDbeGSQxgjJ1ozs4=
X-Gm-Gg: ASbGncv80GeKoXmLZzuqmKnoBzcrjwqGJ1aokWOsRhk+zqA4K1lAM1IDK3tnrQ7X12n
	Td7VoqWdnr7C/og/1sIdRiQ+v5kL0wgqRNcs+QlMJNKoy+GqWkuB0qkCLkUTVHLf24Hhw7n0ckd
	zj+QmwdYmxjzL3wGez9MPZM+2SyUa6jiR3gZ5rhGW9NENc02NVGaQXPX8+s05mFNUhs9yRDXpJO
	3uSJm4gjbNC6UoSV6Yul/nF7XwNs3fywBlOYcfXLwGoNoF5rgeGC1bOe3Kc+HydNFcOuKY3LsdS
	gqgebNspLIjTiHNVOdzv9VHCVncomPFHzaAi92aV4Dfukz+WBHx4Tvo/zNvQhHENsJZSvzo9GtV
	/4DjLbXGa+ONgQCJw8HC59g==
X-Google-Smtp-Source: AGHT+IGivtfLCH94EwiqNLknns+DxOUwFc2vsl21qa22pKrZqAF+FtlV7AV9pspZ7Xlow2+nX+AUYw==
X-Received: by 2002:a17:903:245:b0:240:3dfd:99a2 with SMTP id d9443c01a7336-244594e0c77mr83625715ad.10.1755235110149;
        Thu, 14 Aug 2025 22:18:30 -0700 (PDT)
Received: from [127.0.1.1] ([103.88.46.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439978a4sm373212a91.10.2025.08.14.22.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:18:29 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 13:16:30 +0800
Subject: [PATCH v4 8/8] riscv: defconfig: Enable MMP_PDMA support for
 SpacemiT K1 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-working_dma_0701_v2-v4-8-62145ab6ea30@riscstar.com>
References: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
In-Reply-To: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2

Enable CONFIG_MMP_PDMA in the riscv defconfig for SpacemiT K1 SoC boards.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: No change.
v3: No change.
v2: Rebased. Part of the modification in v1 is now in this patch:
     - "riscv: defconfig: run savedefconfig to reorder it"
        , which has been merged into riscv/linux.git (for-next)
     - Link: https://git.kernel.org/riscv/c/d958097bdf88
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index f25394d088d0d3cbee41fa9fb553c71e495036fd..b9ef2da15fb22f08bdb5ee5d1bba9f6eed49ff97 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -241,6 +241,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
+CONFIG_MMP_PDMA=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y

-- 
2.43.0


