Return-Path: <linux-kernel+bounces-778822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB28B2EB98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B30A1C87E99
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4957B2D5410;
	Thu, 21 Aug 2025 03:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GU1Pn1w3"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B631DFE12;
	Thu, 21 Aug 2025 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745297; cv=none; b=BOcIm7VnjuHzRQTfTOtDVVi8Wc96rQFxUopz6hCFIQvw0u7FJN6ZDIj7L6GBhi/YL1AhLTLAAOvun2YJH+ydmjpT1R2nSZbGZh7otGCd0mzcK0BHknLTXpeQGA6wp9o9jnluKjSu22sTdvbJoipNOLFTqbjSF9Gud261gJIheu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745297; c=relaxed/simple;
	bh=QFApcwOgKWEd9R8/HCG0mqwLQtvWC+pKwVKJG/IsTPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDDIaUcCr4W/GNKNNgKdkoEKrzPRjDrxFvc+itvH7PVwgJXAVjXkvptjZG/zL5jBIi7Z4SeWPjT0XfjJbkHzsUYuujpnBzhwa2qdTY4/a6kUGPpLaAin64fwKxiKVnf+PMpeXRoJgimFq3hfyJG0x0hBC/3/ec2R+tnKFMDHjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GU1Pn1w3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24458263458so4903005ad.3;
        Wed, 20 Aug 2025 20:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755745295; x=1756350095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VBfgPDwHJj9xeq+UdTpIXwDQvBU8YAhfbNleYLr6cA=;
        b=GU1Pn1w3o6pv7cl6+9xKNnv/1fFvIx5glK6+YGwudKIsEmhS7WLlhrAShnuOq8E61l
         2AaQS+BIAW//+NQLlGf2Yto9nDJy9QMRyXK12ZwsKkBzXbJf8DeRI7wXu2A4EX7fLE5U
         /TxFWHMjqmK0P7B1Pyr7d25LY9mPI+TynSvFx3lOigKiXK6Irs2+oQsShQgomhD5YYrW
         vs9uy0lD9Gs+XsyaJp0HYqhslBbJweZddZAEIyxaDFUycRiC8RMjNvNJsmQ3LD36bbUw
         57Qj57HR1f8ePh51iN8slCP8uQwWhN1qTrjHB1FVBrbe6P5bf/NAARgp9Xz5UyRqE2By
         NkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755745295; x=1756350095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VBfgPDwHJj9xeq+UdTpIXwDQvBU8YAhfbNleYLr6cA=;
        b=ayuuL3nhOH4yAqVCaqtNXqHofglOVxn32zcYyb7XG2ZfD1qjqHTTCzon3+fvZkgeXm
         Kn/9o8hKQnyJEzQfedrN4b/+E8dSqHQEYAOp2vkjETKXZla0FczZCwceYtiK/Glwifyo
         v0l7IGQ1maNHIFOU1NBq+lDmw4jjyuL8c9S2FawH9N/xt9aWMTzN+CW8CZ56pZkFJ4jM
         CCtmr5qKo+zr769zP+bmD106+5e/dA4K1GDz67nLITPPj4nBfFjorf1w20PhdVHSWvul
         7DIpkN6mzl3x03f/HuXM5VyP/1L0AtLjldZiN6U3yBwAhd1grBi5/PZIzWVAcowf6XC2
         ay4g==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9gbQCIw8uVMAFPo7C979hcrE1vzMh6jYAGuWRmdopuHXi1KxLvkwZugQOwdwrukQXC0IK1e9kNXV744=@vger.kernel.org
X-Gm-Message-State: AOJu0YxufIufJRoNTvWaCabhawixNRVAVmqEFwCYh1AnM5W/cSynWzVr
	S+lhiToIQf5WjObFJObZ0lai73S9wZ4/Q9nxXPEYGb8JCNhGnxxcvb2NMGpE6yt/kUk=
X-Gm-Gg: ASbGncv5LNFcI+I1IL0YuT5cDP638PdZfUai8P7I4u/JgDqz63IlwtPMjnVxmTWNc2j
	aVC8QjenI7HhTUd8ISdr7xe7K/vcELOqYXaCM4iuXI9EwCt38gsf7oYOE6LV42PrLuECX4q4NNo
	i+2cLl+As6YMcN09g52vP36qWd/g+D2MqPmYMHDkCqYPKV0vr1W+uvJWGNuu5V6ijcvIpmdBdK2
	MUY4L02weA+Zye+uPshboRRATPF+P/T03ec5h0g5TqbZZRYosB5Et+e6OZIo5dsD5x+Pedp7Tl6
	1kAgeU5b7hu+fbS4+YxwmGg0RiuLXtna0EhRsPqZ60n/MeA5LVCgvw9ZV14GQPRoE5k3R1ZXnYn
	4pQc2xieVlcbZq7FJMVmCDthwVNGoQRaX2+cpCg==
X-Google-Smtp-Source: AGHT+IEV1Zcxig6B84KjoGLmnQxYJfI8WE6NEw3RyN2c/rW4MMbT3R26Q1g5buZcviTpIuDd25neeA==
X-Received: by 2002:a17:902:db07:b0:234:9656:7db9 with SMTP id d9443c01a7336-245fedcc650mr13272515ad.32.1755745294859;
        Wed, 20 Aug 2025 20:01:34 -0700 (PDT)
Received: from lkmp.. ([49.37.161.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c73f2sm40160695ad.94.2025.08.20.20.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:01:34 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: linux-doc@vger.kernel.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	corbet@lwn.net
Cc: tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	harry.wentland@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	rakuram.e96@gmail.com,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Deucher <Alexander.Deucher@amd.com>
Subject: [PATCH v2 1/2] docs: gpu: amdgpu: Fix spelling in amdgpu documentation
Date: Thu, 21 Aug 2025 08:29:55 +0530
Message-ID: <20250821025957.22546-2-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821025957.22546-1-rakuram.e96@gmail.com>
References: <20250821025957.22546-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed following typos reported by Codespell

1. propogated ==> propagated
   aperatures ==> apertures
In Documentation/gpu/amdgpu/debugfs.rst

2. parition ==> partition
In Documentation/gpu/amdgpu/process-isolation.rst

3. conections ==> connections
In Documentation/gpu/amdgpu/display/programming-model-dcn.rst

In addition to above,
Fixed wrong bit-partition naming in gpu/amdgpu/process-isolation.rst
from "fourth" partition to "third" partition.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---
 Documentation/gpu/amdgpu/debugfs.rst                       | 4 ++--
 Documentation/gpu/amdgpu/display/programming-model-dcn.rst | 2 +-
 Documentation/gpu/amdgpu/process-isolation.rst             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gpu/amdgpu/debugfs.rst b/Documentation/gpu/amdgpu/debugfs.rst
index 5150d0a95658..151d8bfc79e2 100644
--- a/Documentation/gpu/amdgpu/debugfs.rst
+++ b/Documentation/gpu/amdgpu/debugfs.rst
@@ -94,7 +94,7 @@ amdgpu_error_<name>
 -------------------
 
 Provides an interface to set an error code on the dma fences associated with
-ring <name>.  The error code specified is propogated to all fences associated
+ring <name>.  The error code specified is propagated to all fences associated
 with the ring.  Use this to inject a fence error into a ring.
 
 amdgpu_pm_info
@@ -165,7 +165,7 @@ GTT memory.
 amdgpu_regs_*
 -------------
 
-Provides direct access to various register aperatures on the GPU.  Used
+Provides direct access to various register apertures on the GPU.  Used
 by tools like UMR to access GPU registers.
 
 amdgpu_regs2
diff --git a/Documentation/gpu/amdgpu/display/programming-model-dcn.rst b/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
index c1b48d49fb0b..bc7de97a746f 100644
--- a/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
+++ b/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
@@ -100,7 +100,7 @@ represents the connected display.
    For historical reasons, we used the name `dc_link`, which gives the
    wrong impression that this abstraction only deals with physical connections
    that the developer can easily manipulate. However, this also covers
-   conections like eDP or cases where the output is connected to other devices.
+   connections like eDP or cases where the output is connected to other devices.
 
 There are two structs that are not represented in the diagram since they were
 elaborated in the DCN overview page  (check the DCN block diagram :ref:`Display
diff --git a/Documentation/gpu/amdgpu/process-isolation.rst b/Documentation/gpu/amdgpu/process-isolation.rst
index 6b6d70e357a7..25b06ffefc33 100644
--- a/Documentation/gpu/amdgpu/process-isolation.rst
+++ b/Documentation/gpu/amdgpu/process-isolation.rst
@@ -26,7 +26,7 @@ Example of enabling enforce isolation on a GPU with multiple partitions:
     $ cat /sys/class/drm/card0/device/enforce_isolation
     1 0 1 0
 
-The output indicates that enforce isolation is enabled on zeroth and second parition and disabled on first and fourth parition.
+The output indicates that enforce isolation is enabled on zeroth and second partition and disabled on first and third partition.
 
 For devices with a single partition or those that do not support partitions, there will be only one element:
 
-- 
2.43.0


