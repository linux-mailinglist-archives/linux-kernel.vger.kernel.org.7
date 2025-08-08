Return-Path: <linux-kernel+bounces-759862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9A8B1E3B5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF81E16BF3E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BF0221F13;
	Fri,  8 Aug 2025 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4FPPr+c"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF339224249
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638769; cv=none; b=r+y2dd5RgKEkdOYoYHuybWw1BqkT4cIDsRg5mLynQmEBtZm/WTKYIvxVDRT5CwYAVBxTxoG3tAo0Mr1Y+G+yT8mRfYWMNXfv29hYD3DKyTdpkdt6cSYWOXYnQE7z1AW01oWe4Y3Ri4AJ0+BR/ZOT23QnjWfD1FW+/cOBysSwIOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638769; c=relaxed/simple;
	bh=Vy2/hAVyqR88g9tvaRcTQJ5loKg4GxxOjOXMI8FG7X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBjw+it6eh2Hn6NWW7jUP9eT0ehBbiOg9DuK4Yx4sjinkSmeXAUBqOXIc2hcHj0R7ptiEkc97K+vAb2ymv5/2ECBte4pDmhcPghh5CtIbjNC0jRa4EnzIqVrr/w7yA5VQvKYLGXtlIEAXefH7jKGiD4zDXxdpJaiP8bJi9R5jZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4FPPr+c; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23fd3fe0d81so17595585ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 00:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754638767; x=1755243567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yO1YpKtKP+ptfoFXdPV58S+ud0mO9FZrS4sipO+FnaU=;
        b=O4FPPr+cGPZ6fEgvdIXeusC+wOYd16+RvMMcHoyc9nMUSJEHe5L+2gX0pY7fnmeU5x
         RZEY+9URd9dnM7rZ5jafiI/EZ+FAM3/Ji9rnMnCm9QMtZroK8Fikinp6MDljkk1PZoab
         hK2aBLgO2HCltXihZWbWiQKRu41QoVwO4Z8OagBDwxbSwX0sOoSOz7kc6DJHe0TaEBhQ
         I6ezQXSxi61bixEI0kRaT3TbPyTKx2Z7saWBzHmd+eYjbM/Gwq9uqq4nAUp35NRXEJ98
         6JfhdlpxrDFNHSsPlfKymgfP3hkHKuFwfPMdGTi/hr5m2vBPlwvsijGyfs5VGk1XjdrQ
         /27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754638767; x=1755243567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yO1YpKtKP+ptfoFXdPV58S+ud0mO9FZrS4sipO+FnaU=;
        b=mbpFN4O6GIBDg5hbgP0IEBQXkTszV7wbYo/SEDLru/V7k9BWf4yRn339p/SeTcyDpq
         H3D34pRJhfVPR2wH7/R1i7L2wx74wfcqrtVvmh+ngyy+gIhebu8OkBK+2FTFNxa/vJ6/
         rppo9bW7Z+zKZy+WOx2q0mZWaXz/99HerA2bXwif1B7IFampfjnwKPsFsXhPdIXGPUQE
         8kZ8OvwYHxpbBHhzZJ7KArgmWEcrb7nX5HUXDNLGcBxDoVKdAxH+x7AK0rQSkMPt/CBc
         HshP8i6XLEQwnQUuHT2Yb9Lk5gHCNmvwm8ZeX0D9070Vvdt1qYZyoarlr9P83VhOPqib
         c+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI5WraLqZhm3XJBHi+/07yYLd9BeCnB3XUclMj9vD8R1hVB2BSfWWBEWlcRmhZYJbcNmwqz8AhoaB4AyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKl4TsJ4VMKgfVh5hZbleWHydQoemhIm4B7TLZ/w170kO0hOML
	8SLNzohoTwrs+HjwyFYOUus18XYLnv24zSVw8vsFOtbqqttu/bvfiQ2p
X-Gm-Gg: ASbGnctS/6YZPa2nO4xa+OIDriU/Ktbfa+s7TByko4Go7K4QsX83UwzJ6pY/ZJwDJ2x
	GguNbUl1ChYTC0MrFX4aUtHdAE8+w0ahqaU1s0Tg2H0WatyTrYGjD+UJvrIZ9faEVZrYeP/4Rz8
	WUfgJ1RjtNIM7G7SMhqr1wCSC60VxGX0UUd5mrwl/tQ3dbo2R8e3bALm81A+6JBoCkBtLqhJGLQ
	pB4lkYhfiFKVZ1PxqiuMMg4tCJIcqEgT9vCQLMbsvFnvGEweYy8Mpo7uXd6Uf+uq/db3JlX+U+9
	xqzbD3OJapxdGzgXflBzhPUY6qDUqzZY9iHQZKv4f0Nmr49Cx900Skz+AO9mO2/267QLAYsPxnY
	Zkh25H8ahCiJ5PGO03UPAFm5GkQ==
X-Google-Smtp-Source: AGHT+IHJAphSCGcCrKjr0TL4KujAuKvrfgHh/ezbsFmtY7IQENr8gP6eoXWCL6JC+pybzPRmoIEHjA==
X-Received: by 2002:a17:903:40d1:b0:240:1831:eeeb with SMTP id d9443c01a7336-242c22c59bemr31998535ad.40.1754638766916;
        Fri, 08 Aug 2025 00:39:26 -0700 (PDT)
Received: from archlinux ([2409:40d6:1b:7e6e:e637:1b70:a72e:cd3d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2426dec66desm121202935ad.54.2025.08.08.00.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 00:39:26 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: lyude@redhat.com
Cc: dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH] drm/nouveau: fix typos in comments
Date: Fri,  8 Aug 2025 13:08:40 +0530
Message-ID: <20250808073840.376764-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed three spelling mistakes in nouveau_exec.c comments:
 - alloctor -> allocator
 - exectued -> executed
 - depent -> depend

No functional changes.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
index 41b7c608c905..46294134f294 100644
--- a/drivers/gpu/drm/nouveau/nouveau_exec.c
+++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
@@ -60,14 +60,14 @@
  * virtual address in the GPU's VA space there is no guarantee that the actual
  * mappings are created in the GPU's MMU. If the given memory is swapped out
  * at the time the bind operation is executed the kernel will stash the mapping
- * details into it's internal alloctor and create the actual MMU mappings once
+ * details into it's internal allocator and create the actual MMU mappings once
  * the memory is swapped back in. While this is transparent for userspace, it is
  * guaranteed that all the backing memory is swapped back in and all the memory
  * mappings, as requested by userspace previously, are actually mapped once the
  * DRM_NOUVEAU_EXEC ioctl is called to submit an exec job.
  *
  * A VM_BIND job can be executed either synchronously or asynchronously. If
- * exectued asynchronously, userspace may provide a list of syncobjs this job
+ * executed asynchronously, userspace may provide a list of syncobjs this job
  * will wait for and/or a list of syncobj the kernel will signal once the
  * VM_BIND job finished execution. If executed synchronously the ioctl will
  * block until the bind job is finished. For synchronous jobs the kernel will
@@ -82,7 +82,7 @@
  * Since VM_BIND jobs update the GPU's VA space on job submit, EXEC jobs do have
  * an up to date view of the VA space. However, the actual mappings might still
  * be pending. Hence, EXEC jobs require to have the particular fences - of
- * the corresponding VM_BIND jobs they depent on - attached to them.
+ * the corresponding VM_BIND jobs they depend on - attached to them.
  */
 
 static int
-- 
2.50.1


