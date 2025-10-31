Return-Path: <linux-kernel+bounces-879998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A3CC249D6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CF7A4F1E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7369D340D84;
	Fri, 31 Oct 2025 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH38Px07"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24597340A76
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907784; cv=none; b=qHLxS1V7yAojiTvoEw3ERlsFE2nta0aio53rQd3NS2+7kkw4ctQCloVP7w/nLY6HFxdyNeneV6z6TUHCq091/L8bWXB37qQRsjVZiCt3VhG/V5V6Dhihb1emhfvu8iSj8jHAlpIMp+kwlJbKQDZGNpQxgatAqshMPgqPds1m14Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907784; c=relaxed/simple;
	bh=w1BIQ+EWNzxtxJ+RnD526CQynVSweoUZFsNrEy4K5h8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukYl1KWhLbQ7rLg0pwLpye4H+PxZWwK5kvAgKuNmqBIAFd+UsnJ1BvZq0qXoip8aYNQ2MlWRuAZEDI3n1ohvOvS/4+PwzykaZvgvoi7ZAPxiRBl3X0hHqio9RMl41TGMsiEO3tGzRxMvzv4fS5HQ9vBFtmZstfw+nlDrLhTj8EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH38Px07; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429babfccd9so1529692f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761907781; x=1762512581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+5RYdD1QoUGDR2Tgu8m6WkM1ZGxPlfPcnOpoxoT7WDc=;
        b=PH38Px07hUJWqIfkwJ2nLY7xgzCiPTVnnVa+ftjOyjjxpxlStHsHr/+maQWyl9zZq1
         RD1JGptx+aqGv7BBSkPtoX2It8wOumZTs/gQZ29XOaha3ceCRnZzJHA+W4Ns6LYEve5f
         3eylKlQJmThP44u7U3U1NCAcO0FKTJaJEvSgR398hZu8C2H1RuxhYTnUFKV6CEU8sej9
         LVtn4GUZzpKuCil/nd3PrDPjn3fvWKCJBZ4x+FT4r2u7DlUK/d6STGoR7SXJXPhwrZll
         SnbnuysJO+oZcJPEFoI9+c6c2u8vK7jj/CEJd24cLVLkD1BRT7qX7k2lp6VIUItPjcMn
         M/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907781; x=1762512581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5RYdD1QoUGDR2Tgu8m6WkM1ZGxPlfPcnOpoxoT7WDc=;
        b=hYRBQS3LhqMF/F9nPV0ZOqYaMpLdSefx86NWosGJfopHfh14VDyR9MY7bU3vvWMncR
         6z8O9sGpF7UVlBWXY/aa7KT5sHOfIG/ggGt35igoqN4XGJekJM1MMsO4Ztn7ydfTMt09
         fP+hqmnCYWkXzmJa/IbTeNGzxHilOJPca+nUW6bf29zy9BiYjN7AEFYjMYWiAeo+R4dh
         d9/g3RK8x++7LharRC7Y5bINDepAgIC3Nu5QbMXXfJK4QXMcJ1p3LOSjw5b6uPzh2b5Q
         4wU7NJvmItkdc4k9AI/HD4zai1Y2HSIQlx4xZC30z7t+6wvDye3kz6MdGlVw+0G05Tkh
         gNbg==
X-Gm-Message-State: AOJu0Yw39S4dd8+ym4TC770TtYG8XzKx8SPP7tBSr6iF4SFbvy5xn9Z+
	Jo/3a+yH6t7AFIbSql0T3a7f8wojnKEFH7hO3Ll67PTRJHfOYY+2on2mufLE7T9o
X-Gm-Gg: ASbGnctOTnnNZHkVnAaR91OIEtRLiKt75nU9UDLReGRg5weji7bi94A5nOAk8dSiK+N
	jdtg+pRq8iixdWBWpZBfcbX2EmNANNL/xUf/o3e4UQylbvinDrG3/cDAlHx/enuVfKkF/W1MZc+
	xiljxQ6nS19QMhKaam/W953nohUji1Xt6KJpkF2hQ0ISHLkabzHt3hPGx8pbM4KsalzmQODgK9q
	x+wkixlZtvbT74MH/IVLnx5qvdGHp74/p+jBCpbQ6r13aLtNHTspid9ZlLV3NbYTCJtTXDCwE9l
	kYLCERRopsFCULabCbAoNbBAdQEJJQMd1gTXuhLsUA2rq+AAH3klmATyBrfJlb743AA4mX+txVr
	aa4D596bxBwu7zqN6d9itfq+uv4O95lyOhlPT5jiZr8e6sdGH1wWgDZ5wq7ZCW2NI4tlB0hY44v
	0kpLhgjODV4xTiqMYR0n/0YA==
X-Google-Smtp-Source: AGHT+IE8VBb875dxLRxDB34lR0lZEjeaTd1sqXxjVzPNZFqjTJI6vGaaBoNW4XialIBbVA/YfCjRrw==
X-Received: by 2002:a5d:5888:0:b0:425:7c2f:8f98 with SMTP id ffacd0b85a97d-429bd675fc0mr2308988f8f.1.1761907780764;
        Fri, 31 Oct 2025 03:49:40 -0700 (PDT)
Received: from fedora ([154.182.161.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fcf7d07sm19498025e9.9.2025.10.31.03.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:49:40 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Mary Guillemard <mary@mary.zone>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	nouveau@lists.freedesktop.org,
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH v4 0/5] drm/nouveau: Enable variable page sizes and compression
Date: Fri, 31 Oct 2025 12:49:19 +0200
Message-ID: <20251031104924.10631-1-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new VM_BIND interface only supported 4K pages. This was problematic as
it left performance on the table because GPUs don't have sophisticated TLB
and page walker hardware. 

Additionally, the HW can only do compression on large (64K) and huge (2M)
pages, which is a major performance booster (>50% in some cases).

This patchset sets out to add support for larger page sizes and also
enable compression and set the compression tags when userspace binds with
the corresponding PTE kinds and alignment. It also increments the nouveau
version number which allows userspace to use compression only when the
kernel actually supports both features and avoid breaking the system if a
newer mesa version is paired with an older kernel version.

For the associated userspace MR, please see !36450:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36450

- v4: Fix missing parenthesis in second patch in the series.
- v3: Add reviewed-by tags, revert page selection logic to v1 behavior.
- v2: Implement review comments, change page selection logic.
- v1: Initial implementation.

Ben Skeggs (2):
  drm/nouveau/mmu/gp100: Remove unused/broken support for compression
  drm/nouveau/mmu/tu102: Add support for compressed kinds

Mary Guillemard (2):
  drm/nouveau/uvmm: Prepare for larger pages
  drm/nouveau/uvmm: Allow larger pages

Mohamed Ahmed (1):
  drm/nouveau/drm: Bump the driver version to 1.4.1 to report new
    features

 drivers/gpu/drm/nouveau/nouveau_drv.h         |   4 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c        | 102 +++++++++++++++---
 drivers/gpu/drm/nouveau/nouveau_uvmm.h        |   1 +
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    |  69 +++++++-----
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp10b.c    |   4 +-
 5 files changed, 131 insertions(+), 49 deletions(-)

-- 
2.51.1


