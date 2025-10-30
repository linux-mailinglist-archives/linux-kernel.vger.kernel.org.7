Return-Path: <linux-kernel+bounces-879244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEECC229FA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A623142266D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5524A331A6F;
	Thu, 30 Oct 2025 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiE2BC9B"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3872E4257
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865454; cv=none; b=r7YVE4Ub6vrLoAm0yJxmQDvJWQROoCeTKBIB8z5yBhCgTC9y5phleTalKYdwNRGi0S5KRcrOwPS1Auo8gsftLQp3Pn5nkXI4d7aQc4z6uL+i5//D5pZMBxWr7pQiGpCpEJDPpmMlqPspHhpIvEX8hMPVKdoCWb0qxEw8NZLQO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865454; c=relaxed/simple;
	bh=gjhoZV57Btx1LNmk/Wj5dyQ3VIg9ZS0LnU+a2x/0lPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALkLOhGSnvwq6ptg9j0COH1ICEpMXJRpfFxslMKHwZcXmx7J9LOb8b88QUhieZ88JMzN/TN3U5AibSpTfIWgM6GFuGM+xzHBVg7txZAJn3nFxv/2QFzoIwVXK/GY+139zdNXW1/aXG/aVjDrtxJd2VPAsL9bZIGn98G+K03EMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiE2BC9B; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475dd54d7cdso6624645e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761865451; x=1762470251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=spTnbkYHkS5sFJlII3J1Det01f4GO/gKWkvcwEWUpZ8=;
        b=eiE2BC9ByNJhi1FeBCS2RHNqnmTAKWDNl6f8vtLQNT5QIs9N2CzzRGlteV1Y6e8WJR
         qdm9Wm9ES9R4kcESrqeMJ1xtq7DIP0srtkpYvZDaGjP64UJXyVWm3mWgIzHj1innm09R
         fqESYxc0+AsFEY/n9xJDvm4LHSUHi+84LoK4Etc0RjAv9WaOXOKZ7oATpG6CxFY7RYyk
         WxyFdmGHDTKiHUcJWyJIduAo8/YT3RI3wdqhAgEcA1MHVYIe0/Ph8qJAZfnkNAVBuMQV
         lLCrlwIss/waJPvPQEQ7D5Uc2ayPYJaezOdngMd+Twbx5QpeZ2tEFAcVnJgJomhBdchY
         wpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761865451; x=1762470251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spTnbkYHkS5sFJlII3J1Det01f4GO/gKWkvcwEWUpZ8=;
        b=JH4h9bivFRILj038hmmyAAsA1MiD53XjKpufyBaTR/qSPIRNkzyDF5WZdSmn9oigEh
         kd4DkWezwlUJoWymODsHrjiM7PjoPrH778Fht4lN9CIAVJjAhV1fxQPY31s4gk/G6fib
         fScfD4eaAZI4/tlXU+ZW13vACsDi5qjvOFK2UCY0j1JfJlwf6vs/XIVgmf6SWihfnHb2
         Se4fBSaHOpDeFAHp8Ht59rpe5qBunPmv/i0usfnKSonxM81a61ETpIRb3X0QxmYGUKgD
         VUDe0NrcK0ioNvtLmL3imjFoyFh1LrNw83dGuE7htkEpVd06kw5/9R8lNGUNrnblfSoD
         PrTg==
X-Gm-Message-State: AOJu0YxFz0WQl8fIZgH/pUnUfvy0CH6bkYdyikG2wD4b/zRCGuxyMTCl
	bjuMZ7P7vFMpSQI9MhT1c3ha30bsKd7gvlvBSmfhQLwqfelYrrEeZdBHEERj5stC
X-Gm-Gg: ASbGncvtJdk1LMX0xyguBFA1IY2nFLxnck67vWCKObafvlkGrnJGhipQUJ0uC/eoVHa
	5mkE7LoXdKDG5qU+jFSLp423s17RrHfKMNAcXWhCLkTQSGBnt5AHnY3cxg2udfZLsMgrIUuppgO
	U1G4AKocT68JxBGxTUo/6Xnqii/U2wZYZqBcTjyfMP7mOcszopyGOCnJvk04EU3LWa4IH75jTGl
	X3y/xsl0ciijy3Gyfc7tObn9+XpptI5e7lNNDEHJvgE69aEmx60gc9NWq3y1WirGe+1WjI5tywy
	BjAcOlWp4lBDNe3H7FhM1KEQctJiV1kbMN8H6YzaobIdVxlW0LFsxoYdwNGMkXlvE6MQ8YPT3gS
	yIhqwbVI6qf4TiNqa1nUzVlJtGH9R4ijQcYxsKsmOk+dLyN1lkYYDAngcK6KpZU4bLzPKpBnsKy
	2Gwm4wVpxFkzo=
X-Google-Smtp-Source: AGHT+IFC7JbgK0f+mgKIcbZcySjz0mcvo7VVc4C2hDfzVb829xeoqBnvTAh+hZXl4KB+Y0uGYyJg1A==
X-Received: by 2002:a05:600c:538e:b0:477:214f:bd95 with SMTP id 5b1f17b1804b1-4773087b183mr13255895e9.23.1761865450511;
        Thu, 30 Oct 2025 16:04:10 -0700 (PDT)
Received: from fedora ([154.182.161.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ff8235sm2227025e9.14.2025.10.30.16.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 16:04:09 -0700 (PDT)
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
Subject: [PATCH v3 0/5] drm/nouveau: Enable variable page sizes and compression
Date: Fri, 31 Oct 2025 01:03:52 +0200
Message-ID: <20251030230357.45070-1-mohamedahmedegypt2001@gmail.com>
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


