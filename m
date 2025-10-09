Return-Path: <linux-kernel+bounces-847566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7722BCB346
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 054834E73FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B5289E08;
	Thu,  9 Oct 2025 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRFHzbRR"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CFB1A01C6
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760053160; cv=none; b=nTO8H+Qy+GJfzlLbJza8XJMAkJ3ZjJyJsael4Q/+9ZAS/M9PwB3uQvQYapBXdJFYS4UZEnS/y/F9GSFe/7EcFRm0TdsCEwa4q1qZ12hQB7A3cMReq16FHz7IAucBfwdAZ3RUOHXPYMma4bjhDyScbZ8c9DesjprUVEs1BCEuJKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760053160; c=relaxed/simple;
	bh=yQRfp2+aEYtI4J7ggklJ4Q5590vFVND/mS7Yi47bqVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kl8K7KGE/0jvxFEhk9lN5lXJOlQXOTVQJs5iK7K9V8CvszkB7vCN7A4NfEzWPYhIHMu05exq94eeHd2gFIL/KVnWhteWt/21FC/sszQX9jTc5ylCW79C6etDoTI+GJnNoCrk4v8aEMhcieZdkhM13jA8b+2S8usOvU5cnVLrkmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRFHzbRR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so15286875e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760053157; x=1760657957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJFaIMUPoYmzAjPmdOJ59lzNVZeNVTShHGh4jV4ztic=;
        b=aRFHzbRRVIkUKby1rrDbfqYPs8NeaElhTllbpD6Kd2nr6n6x1wMcz4+NSkUg/81PhZ
         kU85D/s90PvJFtGvlnJZyAoSQt21A0ahxBBFiUEc5X3G4s0aVlxth+9h/ADs2Omv0BOJ
         Mpk+IMPrayNSqLkBnoMYCARm97h0LGn8Q8YV0yDJwRrL6cw/Jei0XzhJb3R/aTSWOdMi
         noSBB8NgeuwaoRLhw+5BKuqBsKNfQzY/ZcRfRMmMfnrhYQxZYCePmXIxdA6xbuAb5b+I
         p7S2u1kQLfP1Xyfrb8B6jDyLS8ijxTo7ve4wNyoscfzTxK7lcXBwp6JU9LUGmEUOFNTO
         zHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760053157; x=1760657957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJFaIMUPoYmzAjPmdOJ59lzNVZeNVTShHGh4jV4ztic=;
        b=APwXyTHzspW8bqbbpUzfbgX7fZiMjmaWZ88S8pqnbCyIzoVvWRHokaEQc7tqDLP1Mq
         KymLd7gO8uOSQa14y6ypfWTpq5UhNmK3J7TCl9/yWU3+XfN16hQzchFZI93I0uHeKcgk
         ot6KPYG7+5q3WmEmX9lwHSnZ+A6CYHF6vsItzoUATNutpDzfP8iJukgcIupMNWsLxkjS
         /5iumgM6MTPC37XDM01BUdP4MiPxwX37etgyHGlphrdsCbIm4Etb8Q4jCZ8b/JdQmxr0
         ZkelnyfN6X2xK6365R98XtAQLNt58d7rnMkq8x1M+406tgkA9rKYwlJU1FRp1uIdsDx1
         9Mdw==
X-Gm-Message-State: AOJu0YyNi2JavKL+7AI5i5DhAyXG95bh5/3nBT6LOTuFl+sK/4hKKiLN
	RHMnyZdTDP9Qx1MuA0EOeyOCfpxQDP36kWpxbTiKPD8wdgFSUAgxaPIjy5AeNw==
X-Gm-Gg: ASbGncvn36yHX5tc5a+JsESNHO4l3uKS7nSWNCkeMn7QgroZyvbzmzP7y2tPaPewcUe
	WCALS+r2fDZ1EnysoWhoTPJ8WUz6sWb5kVotwEzRssn3MEaIm9ts+zjh7lDYrI3i76UaMxW9vQP
	Tm/D4oJatIognMfKZ5sJ7Dsd48DXYhsfxva2m1Zpgq4QoCAwR0k0CPbQ7PkIEuNK0yCe0/nJGbY
	RUb3fKWznYM/JKucwLKhC6zjIBscPkLWQq+jTeO1OH3bdb4m1x1daIoCVswW22RCNK5/fsZE6KH
	DJae1HKu860uLYQJFro1SihjYjUTR3u/lF2oQrOgK4SrSrpPHn410HgdGWmbUFOWjqv124R0Itd
	lo8uTQ7P1/UsJKbz4J7D3KWw+OBNHUTci84Eb02LHXu7eIRMtgjus
X-Google-Smtp-Source: AGHT+IEWq4VpnqfU8FFLrzl/DHl5jygZ2q4d7dLrByZ4bLt3b/dzlYCAmwAed5vYoO1IY1J7qpOOUg==
X-Received: by 2002:a05:600c:a08b:b0:45f:2bc5:41c3 with SMTP id 5b1f17b1804b1-46fa9a8f261mr65000185e9.8.1760053156830;
        Thu, 09 Oct 2025 16:39:16 -0700 (PDT)
Received: from fedora ([41.45.27.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3e3206sm46066075e9.4.2025.10.09.16.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 16:39:15 -0700 (PDT)
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
Subject: [PATCH 0/5 v2] drm/nouveau: Enable variable page sizes and compression
Date: Fri, 10 Oct 2025 02:38:32 +0300
Message-ID: <20251009233837.10283-1-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.0
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

- v2: Implement review comments.
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

 drivers/gpu/drm/nouveau/nouveau_drv.h         |  4 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c        | 71 ++++++++++++++-----
 drivers/gpu/drm/nouveau/nouveau_uvmm.h        |  1 +
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    | 69 ++++++++++--------
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp10b.c    |  4 +-
 5 files changed, 100 insertions(+), 49 deletions(-)

-- 
2.51.0


