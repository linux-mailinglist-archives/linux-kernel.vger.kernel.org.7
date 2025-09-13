Return-Path: <linux-kernel+bounces-814936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E496AB55AA1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 02:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4879918993CE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F4729CE1;
	Sat, 13 Sep 2025 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxlWNxTp"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C811BC3F
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757722921; cv=none; b=dwoLIKArTcbOkltiEQaAc3PnQeEZU9d9BQQVXkUJXnOnltIP9q9DwAYSFoyzupWGNF4Q8QyfZ93QORDlAxANEpy1MP2y3OvqM9Wi9FlXwAryaiZqVjJdTpmvPBH3Bcf0mECrVbs9Kq9TFfu1ghwLTipEJK5dAezW7mkUmn/YZr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757722921; c=relaxed/simple;
	bh=k5zZArz6vslI4kO3FnfOETnAx6hadCaKl5BReigvXQ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ut/EYJKkCiJWV84n5ZzB1IYA263xkN3sjJa9LQHFmllcVTfCs9E54Ctp1cbBeWhs1JBAlQ+EYZ6UVBzpKSoV+TlidqdEq2rtCAj1GrqhW1m48xWEmCkYdswkaXezRoYDEmI0qGDWrN2PglqKXFvzhK+dsl/TGw8uxGx6huZ4fA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxlWNxTp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24b28de798cso17656935ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757722919; x=1758327719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cosKX5Xl7idwLQvWuO8wp7/WEaUIA3E5mnZgoJsColg=;
        b=QxlWNxTpwwVCPnA5CaL9N8JnbM3DGLid83e4J68JfEHzaDIIW0+IavhlM04+V0GhmK
         L2lrvIwXzK3uF8RBKWRhKZzD9/rk6X+P9amCafx4d9Gbyr5vzGXfVHJeXmbG8AprIuXl
         hKIXrTHcta2ZsdgOldpVcf0R7syMZgngmS7t8FvbBv3Bai0d9taseu8zLMfPmVr5xn8m
         +d9VRjjBYC9YvBl1YsnY4aMR98qYTnV262T9tesJall7kinqK9/CvqVrXMeubEDTwrss
         Smn3ecawhADJiwzf0qif8LV8iXwHAqvLxYDdxZ2E2cm64I1HWaA40xc6IkfU8ZcsDzaq
         SJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757722919; x=1758327719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cosKX5Xl7idwLQvWuO8wp7/WEaUIA3E5mnZgoJsColg=;
        b=iQBDdxIvTp/SXemLdo/K2aUFpWKwQoeS5JLD2Bc+Yqiz00CV39W5Psetha3mdmaors
         iOw7f7bvDy+1cblib5JwQ4NdB31JLPuGiaCUFKH4r9r7oV9ywMvmiWVTYNV/VVj8QL/2
         FcUDcOVpB4EWSiR4h5JjLcyWOOicrAJJEdA6YtbQZd6W5t435qTgHXv62TZGYCwRxAOl
         5MmRFFgAYgj4b9CqvU+IBzrUsL3z7TGY4l2j7xYmiK4B5iGDGrnmOhkWTmUWA2sniewI
         6Kqaz0x5zHAnyTdYoZgzdL5Bn5PepiThmleSc9/8LD0kOefhrxvrlUxRFh6o34sQqyAI
         HCOg==
X-Forwarded-Encrypted: i=1; AJvYcCVLcn3u0QLiPFNymsm08Nki5qdosX8gN2TKwiRUFlJGE8GHxs7NfTwtKIenSHCovoC23mKwD5CI5ZPC5gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwcNt8XJfMh/4wKhYb2ovlRMiIifUkmZwzNSdQVCiV1Oe7773m
	7jTnWnnpiCJt6Dsd9mDchxQY/GEnkatVCtHNzDMKGGalEQnGVY39HFte
X-Gm-Gg: ASbGncvii/R6pAUJBCKvhh1oO/03l25G85SZNSN1ohZWysDyc/ooCz0p2aLLkC6a+eP
	9WEwc9nspbGccJ4o0oibZ0jlccVbxey0nwmOWq1wG8ACnXUAtPAmpmPSY5Sh0+t93707A9WBbJO
	jhhzMt5Q0sE69vx2XLVRk4dkW0fpPSMlV688Ccp35DG5ANeROjOSDHX47VHGJzDKwbKzs3AZK+8
	IUH0aZlDqG2BGPiJYqjRsSNm6hMF7phnlSxV9eBEa+XNVvCNk4tSzl1h7DFv8Y683eVpziU3/+U
	pLVAoziTXMmLGwpfDmG3N23T6jK/Z44kMnJ4jvkV/QO+A8qyXO0jwQsZ8/DgIAmzVpZJfTF085z
	/ZuYPvlex1U2p7JbRLiwQWMw3P82UP/ik+A2ZEmzg73owBfswnwalMPBIIaQ6+mFZQ5YbVdbPPh
	bQU6Q2UFMxvw==
X-Google-Smtp-Source: AGHT+IFohPP4U81t22Ynet3qFVaqgBlL6dIfvElA14+ZZZffQX0/DiVAU8HTvR3Y0I/KjtcyFh/Pdg==
X-Received: by 2002:a17:902:f54f:b0:249:308:353 with SMTP id d9443c01a7336-25d26d4ca85mr45666985ad.41.1757722919083;
        Fri, 12 Sep 2025 17:21:59 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32e0c2863e6sm406490a91.28.2025.09.12.17.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 17:21:58 -0700 (PDT)
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
Subject: [PATCH v2 0/2] drm/panthor: initial mt8196 support
Date: Fri, 12 Sep 2025 17:21:53 -0700
Message-ID: <20250913002155.1163908-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
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

---
v2:

- drop RFC as this series works with the downstream GPUEB driver, and
  should work with Nicolas's GPUEB driver posted to
  https://lore.kernel.org/lkml/20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com/
  with no change.
- remove CONFIG_DRM_PANTHOR_SOC_MT8196 and panthor_soc*.[ch], as this
  initial support is just about ASN hash.

Chia-I Wu (2):
  dt-bindings: gpu: mali-valhall-csf: add MediaTek MT8196 compatible
  drm/panthor: add custom ASN_HASH support for mt8196

 .../bindings/gpu/arm,mali-valhall-csf.yaml    |  1 +
 drivers/gpu/drm/panthor/panthor_device.c      |  2 ++
 drivers/gpu/drm/panthor/panthor_device.h      | 14 +++++++++++
 drivers/gpu/drm/panthor/panthor_drv.c         |  6 +++++
 drivers/gpu/drm/panthor/panthor_gpu.c         | 25 ++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_regs.h        |  4 +++
 6 files changed, 51 insertions(+), 1 deletion(-)

-- 
2.51.0.384.g4c02a37b29-goog


