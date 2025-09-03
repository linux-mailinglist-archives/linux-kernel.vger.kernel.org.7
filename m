Return-Path: <linux-kernel+bounces-799517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E1FB42D12
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E0D189694D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D282EF662;
	Wed,  3 Sep 2025 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAE2tKWx"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BEA32F75C;
	Wed,  3 Sep 2025 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756940111; cv=none; b=R/f14+kbGOuf2yHmwB4sSwKTx8FC/GXS0wjiI86ka5Ut2bC03jS1Vt99ZU0OXDAo0QOb9POUGdPafqJmglbtyxNyppMjPmCFnlzbGAuPHHVEmWw8EeXN6pLTh2GSZS0KbyH/lFIlCtunmatSJoZfJnB2K3qEGLN7kKDpVEa92jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756940111; c=relaxed/simple;
	bh=TDkQlN88Q5n7Q6X+hCKD3/edFPOH4hkIHeuTFKnSF+4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MDXWX/z2dicI+2o6UqBpyH5pkL+z7VATgduUVqBdfwW48YV9wOgL4FQLugC2jhtgilpKTP8/oTAXxgTWWEu1jzPxtr93pWuK0eOvE5+FJpV5K9wS3T/DZmjO+v9oHPovnSfV4g4RE6Y8WwbxmXShwmaiD+klSq3CjbUpmcSWGlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAE2tKWx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24a9cc916b3so5093555ad.0;
        Wed, 03 Sep 2025 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756940109; x=1757544909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o7SdCGQ3OtPL4C8i+CiT/i+Gun3C1uxaqDOYUaITvFM=;
        b=cAE2tKWxo5wnTnpqwvWP/5JhuQ5muYmukKgLk3uTdGPp/q7WFL+erq/z2RQ+RAlcIf
         2ZjU0DbwUABb0aY2X5YJS/yv4aEbcTqO8AyZkio2BKzD4UBHfj2s/p6hQ1CQxMxSc53A
         x7Mcbpzv11UGD0Z1m6FA4HJGAsMEJ0nRmWV6d0l2EKuBN5mcgTHc0q3FU3dzZfeO3FZ2
         PsbWORLsm1ryUT3JwOn4l3MF7mtjnklizsPGWVxYvOSZRTwLcxEhwa1fzt46bD6i/ROD
         UuOIclEd1etGDO4Bu1pN/FKtQJOWggP+3KaKGB/5ORX/qCK27LcTZYhafnMAmUzqXOc6
         U1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756940109; x=1757544909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7SdCGQ3OtPL4C8i+CiT/i+Gun3C1uxaqDOYUaITvFM=;
        b=lGU32c30vQ91KDNYptnQA6DiOy37JEUNprAHMVyFpeW3sAsOAr5Lcl8F77oP99wQQf
         NXYs6+b1Q49kDIj3rIpw/OYRB9HAF1Z618iJ/Stiqd67LSTLWp+mc8f1jO8EgY0qCPnA
         +r5UVgvRep/zvAvXiwI96Z395uPcUb0GzWQSXakbRRRD23CPS75idf/1uUCV9c6w+mG5
         fhxj28bX9yhDG/1c694gscvwMK8Xli+Qnl8QxwSldC+41YppXKKFh4t+OkCmYbO3Cohg
         HMP2BuHWnQPM0Aygn4NqM8CwJdTmR0hUDydyDMWq5pasyloq2W/M7n8mrtKsizGwDoi7
         zZwg==
X-Forwarded-Encrypted: i=1; AJvYcCVRw6CH9BmNEacxgy2b2NEwj9yg5hHbYj+G1U96gtAKDFiBE2LxJ7MM5upi58su2HnYhFsZq4my8e2jSl9L@vger.kernel.org, AJvYcCVhm4GNyVnROkG0I54yrd03xtYw+LwcDS4JzGiFSQNfvn8RmzLAh6Ay03bypyQG4fChuQa9MmRj6RW4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hrJ1CW7worzJKqUms7U7zAaDyVU6C3H1FpyH8mF6FCp4KNQl
	JP9EkuRX6z8XFJ5D62EbMtpF+M8Op1pCJJnVsu0+4NE70i5REu/BMkvv
X-Gm-Gg: ASbGnctF799OOO8qOkoNzh0PJokl1W1li4JR6v1KIRxeCWaybIrGV/Qh0ytT8soq8ch
	qu5CES6aGAdhFnQNZ4vbp0xShWoFrfU2RNbJfMaEdMvrZyuXBeXxNYsD9HXRCTJ7BNPnFP/JFLm
	CFuOkQIeMmDlE1teefC2lz7D1sKWoRGnZ0I+BetqhMH+2Jh4G8lQMq4J81+T6gaKdLfi7vIi3/V
	4kyBF+P04QZIlS6Ncw4+BZ7vhg03YncxbMIWSDfAisOvrS1+Y+VinCpbVhTBvaZV5CCu5G/YIpN
	n5q9nfwu3VC04UT7G5JUuSEBYA6in4kbyp0aMTIdLqfcTRUmBcEYL6zOU25sKdQrVdCWyF4yiH0
	QkUH6ePiK2Ea919LKuuBD2E4rJNhrCbNM9luJcu+eOpIojQ6RIyhIoDPIHv4T2d19gKfasN7MQH
	C74GoXXiFN7Q==
X-Google-Smtp-Source: AGHT+IEhFktIMvpmJbrvjWFLTT5A3+FgRNJriwkj5RePnhU8700uH0+euhIJE/haVIpx1TPUCmOLqw==
X-Received: by 2002:a17:902:e848:b0:246:a90e:9179 with SMTP id d9443c01a7336-24944ab7df2mr226213595ad.28.1756940108651;
        Wed, 03 Sep 2025 15:55:08 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24a92f897d8sm131162215ad.24.2025.09.03.15.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 15:55:08 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC PATCH 0/2] drm/panthor: initial mt8196 support
Date: Wed,  3 Sep 2025 15:55:02 -0700
Message-ID: <20250903225504.542268-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MediaTek MT8196 has Mali-G925-Immortalis, for which panthor gained
support recently. But the soc also requires custom ASN hash to be
enabled. This series introduces panthor_soc_data for per-soc data and
uses it to enable custom ASN hash on MT8196.

The clk/regulator provider on MT8196 is GPUEB, whose driver[1] needs to
be cleaned up and upstreamed separately.

This initial support also lacks support for some hw configs. On some
configs, panthor is expected to query a mask from efuse to mask out
unavailable shader cores from ptdev->gpu_info.shader_present. This
requires extending panthor_soc_data with a callback to read the mask.

This is an RFC because the dependent drivers are not ready yet. But I
would like to gather opinions on having panthor_soc_data for
soc-specific data and having CONFIG_DRM_PANTHOR_SOC_MT8196 for
soc-specific code.

[1] https://gitlab.freedesktop.org/olv/kernel/-/commit/170d5fc90f817dc90bde54b32872c59cf5c77779

Chia-I Wu (2):
  dt-bindings: gpu: mali-valhall-csf: add MediaTek MT8196 compatible
  drm/panthor: add initial mt8196 support

 .../bindings/gpu/arm,mali-valhall-csf.yaml    |  1 +
 drivers/gpu/drm/panthor/Kconfig               |  6 +++++
 drivers/gpu/drm/panthor/Makefile              |  2 ++
 drivers/gpu/drm/panthor/panthor_device.c      |  2 ++
 drivers/gpu/drm/panthor/panthor_device.h      |  4 +++
 drivers/gpu/drm/panthor/panthor_drv.c         |  4 +++
 drivers/gpu/drm/panthor/panthor_gpu.c         | 26 ++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_regs.h        |  4 +++
 drivers/gpu/drm/panthor/panthor_soc.h         | 26 +++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_soc_mt8196.c  |  9 +++++++
 10 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_soc.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_soc_mt8196.c

-- 
2.51.0.338.gd7d06c2dae-goog


