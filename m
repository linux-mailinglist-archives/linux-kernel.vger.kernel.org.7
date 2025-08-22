Return-Path: <linux-kernel+bounces-781504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E1B31351
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE1AAE7EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271342F4A0E;
	Fri, 22 Aug 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HYojqN9S"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2622CBC0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854930; cv=none; b=CjHwCOsoeOwdV/WMDI5fXa3UPkpiWfVoc/SV/1PX+/z+dat5UXim2A03pzMeoKQI0LScWoMzQHP6OM94f3sci+djZKiJPIrHC23ecX6jOAAtuTeEm8Y6O+RVM4adhSPo20a0udPdy3g7bdBNz/1zfyWsPRWHRBknC+YwH5yQICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854930; c=relaxed/simple;
	bh=IbLEAjuHyqoZRTWTQ1Get3JTdLxmKfmmH4b9vD9fY7Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tkIi920oluE6Uns8xsT+GX98kf4cja6VQf0e9yXYm8CLvrNKRBZNWMG7suIJr0C8SVZTLqgN52B/BTQEnsB3SmpFGJJ1qeOr4FJJfyL1GoslC/SJT1jQiE+wplivXuuwXxg5+QRiaSjZNOSvo5HYEBWCvSXiPMmCalBpczbWS9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HYojqN9S; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b05d251so11082665e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755854927; x=1756459727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tdZspPlKaSzIHZ+2SN/TDgYtX3ulzfnLR3chwiPSwtY=;
        b=HYojqN9S15y8qfkOHoF9u3nBL4XkHfd9nD1KRznW0YjguFEsTsf62xtit7phbBIDBO
         iKzYMl5cMbGNdPV6YDAgE/uO01S8ZUQ48GOZoQeelVuKueOKTS4/R3FQZathCEbwFek+
         r1VB3uebrfg9NFvI6Gy1Mo5ERidRJhqOsqqC8N6hlqZgCCyp9oCmLb0eIOOk6t75i1Yw
         EZ6PTFQU9zgpU3/vSUPxBtVBPh2kFAwAbIl1xRSdNaS7f7QhLDvAvPxnfWJBhq+UR2CI
         mg9W6H6Gs7ZykUDRvwGLfWrZhk0NTMpr5XDde4XkcysjRUPTigib3BzbtRrPBRgvcoyq
         kdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854927; x=1756459727;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdZspPlKaSzIHZ+2SN/TDgYtX3ulzfnLR3chwiPSwtY=;
        b=hD1rWDsjKE68eqij0f7zh533Os0euK9TGa6a15jSNKTyW7Whwp2CXGivplbqBtkdeu
         c3Z2oUVM6OlmosWCZmzqilZ+Ge7WsN5UsOqo8z9uJFU8Zka8UZvRAaNQIhn8/LsEpAOj
         MIsS4R0dcKkS/KEyhuO8pRHMNJODjCyDZUHIbx+FY+ByGG3BF1+tCD5mvV11i043xmi8
         EpBAZ2LN6yqzO1EzP85n9lXiyAF3kwn46wB95y8AqIgKrXnUKfT8MceprT+K4jEGouQz
         Q50G1mKffvLdafPatmR5tUwqLMRec/uVNQ7KNfm3mCVbct9WUP1qCu2iBBGR0eKNd0XU
         TRWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmsvvbt6epFKCzW2qQthvW/9wEsWZ2bYRE9KrpQK3Mn7t/crywsFN9SC2JjTdpQT1pQ6PcyN9Yq3FGLZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXFzkZ1QEDZNT21XTWoCJUkM2ttev6xYfQWJvOmjwKq9PtVZJp
	fqupMi6ivhImy42Zmmogkh/Rkq0GjmuD6CiWHLhq0jOTa7IavKm/T5FZGhOtdhJWYTq5gwvlvBy
	orZ1ZP+msF9r4YE9cjw==
X-Google-Smtp-Source: AGHT+IFR6iebHf+8m9CthwrSpnbKhlvbWxtJ/c0VWjlsjpaPAyeik2NIhpLjJuZj3UbyEmu0IRZMKxiqKzeCS3M=
X-Received: from wmby11-n1.prod.google.com ([2002:a05:600c:c04b:10b0:459:d6d6:554d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1548:b0:459:d709:e5b0 with SMTP id 5b1f17b1804b1-45b5178e893mr20589265e9.5.1755854927367;
 Fri, 22 Aug 2025 02:28:47 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:28:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADg4qGgC/32NSw6DMAxEr4K8rquEv7rqPSoWAUyw1BCUQESFc
 vemHKDLN5p5c4Inx+ThkZ3gKLBnuyTIbxkMs1o0IY+JIRd5JVpZol73oNDsGx3IC2oyqGrRqr4
 oSqokpOHqaOLjkr66xDP7zbrP9RHkL/2rCxIFUmoM/UT12DRPba1+032wBroY4xc4q3GTtQAAA A==
X-Change-Id: 20250814-gpuva-mutex-in-gem-a608ab334e51
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=IbLEAjuHyqoZRTWTQ1Get3JTdLxmKfmmH4b9vD9fY7Y=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoqDhI7cJ5PRI/lSv1X75CC6AIfMHgMPZS1RZIN
 g5Lt7w1VqmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKg4SAAKCRAEWL7uWMY5
 RlcaD/9/NlLC8uUEjxawJfxBiv/2EsetL0ASiMNHOOfB3U8qD816yL7nN3UvHwlvTrXHzhT7A22
 Vgbq/nU0Be2ft9I0TEzz8MIFc5iG66Q2TM3txaBp96519MrHNj6eZT1WBRC/ceFcOZYEWqlRDUL
 8K6QrGpO0DA3R2/xwFLBiTyNlZ/fmx4m/ZG48Et1sB5RpCSyu1aMGx8JallE79LUd3wlLYaJW8f
 bBa7iWaB5rLaPls3w9i1RorovONa2VUt9nqc/Jzh8TVuueKvcPOfS/01zeDnZXgexESZQQejF1q
 Z73usLjZ09gSfOg/TMwTjzj77iQ5vZnJnecgDaMNcKucZ1d9+NM/aOwjr1RUUXsUfqHQs09bspJ
 aHwKl1p6fQdDv83GK9qRKAXKuH53SmCIb3YufjTQhpoB1q/KctdRAA9sBhHNFUUrB/j8pyPeaLj
 ynhWmNIW8OXGFykqExurrsnJw0wq9lU1cnXy2G3+N2CpoxE4gweveYIUQFYUDZPknZas1nng3zS
 S/+z6oRE13mtKcNv8ECUK2LVceNOifVVZVIhxLUGY8/inWuPJv+qc8b/Dbx1yQnl2qpLNcbnVlf
 C6RvPM7HvcXdPvCrWTttwRJswy87NqMqXMuoSck5WftFq3XiwuvhEBbc9jPqQfAcWaPuN3fb00T ExxdTky9MUx9uVw==
X-Mailer: b4 0.14.2
Message-ID: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
Subject: [PATCH v2 0/3] Add mutex to drm_gem_object.gpuva list
From: Alice Ryhl <aliceryhl@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Danilo Krummrich <dakr@kernel.org>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

See the first patch for motivation.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Move the mutex_destroy() call to drm_gem_private_object_fini()
- Add a third patch to get rid of the lockdep map.
- Link to v1: https://lore.kernel.org/r/20250814-gpuva-mutex-in-gem-v1-0-e202cbfe6d77@google.com

---
Alice Ryhl (3):
      drm_gem: add mutex to drm_gem_object.gpuva
      panthor: use drm_gem_object.gpuva.lock instead of gpuva_list_lock
      gpuvm: remove gem.gpuva.lock_dep_map

 drivers/gpu/drm/drm_gem.c             |  2 ++
 drivers/gpu/drm/drm_gpuvm.c           | 30 +++++++++++++--------------
 drivers/gpu/drm/panthor/panthor_gem.c |  3 ---
 drivers/gpu/drm/panthor/panthor_gem.h | 12 -----------
 drivers/gpu/drm/panthor/panthor_mmu.c | 21 ++++++++++---------
 include/drm/drm_gem.h                 | 39 ++++++++++++++---------------------
 include/drm/drm_gpuvm.h               | 30 ++++++++++++++++++++++++---
 7 files changed, 70 insertions(+), 67 deletions(-)
---
base-commit: 3f13bcc886fc034113cb75cb32b8d9db1216b846
change-id: 20250814-gpuva-mutex-in-gem-a608ab334e51

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


