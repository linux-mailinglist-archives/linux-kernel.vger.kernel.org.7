Return-Path: <linux-kernel+bounces-761413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71FFB1F9C5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 13:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AB4177268
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 11:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFB623D2A0;
	Sun, 10 Aug 2025 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht+fXlbT"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F73566A
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754824966; cv=none; b=qWUidFx1pEe8oTiTaHFz8OrUpDS4O7PbCcOAf/Ok6EtvHZzS52iWEgPwn9ta/g2k4Dpw5IrURzoCrsPbUsGJsB2hKRAcPvK+RGeN2ZIaGFsuBEHzNmvi+Mxarl2jEaS+Jx8c2IRKobHFqFZYXnNH7Iif2Fs7vlTDpaclAiv0308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754824966; c=relaxed/simple;
	bh=e1gGJ9Xs89sHMXSSC7LWCCJGzyL5Y/mSAQAQNPjPduw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVIUukmuI1CxG5V0cl5yV2h68be/4uHqM0t4SLiN69cpuBgsyFA/gnhi0oy8IvcXVZi3vjOXtNHEWN5X1zLMA3+/wkWjiHfH11X9ZQ1qDKYCO5Lh4sUi2fA4oCY/Na7o44/8DRFO5pFSGaCYmnhzAMPCWnbq2H7fUbiG9KLrTow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht+fXlbT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459ddf9019cso10852045e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 04:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754824963; x=1755429763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhhFXRDo1oqiT60OoNv34yNBdmuJ8HYGxW8L8Z+UYnk=;
        b=Ht+fXlbTLf+EU0XQRfPUaYMvQj4zylKfgb2D4Cf65jXj/BOlpcQKvB6K3RFc0bUpeq
         zJRYN3d4wecp0mDVet0nwnV8I50GA9QNgn2nwkMFU6WRwruDcXxEqHvZY/oUk0K1uoF9
         cAGKADA245W3ikiSXjyeI5cm3ug+5/dFWO+KaXTsoJsfSJ0oC6iXNOFsTDCMybmQ7szn
         LTeCNbQkqikf8aoPXHGk8uA206mW6HUgBPUv+STXe/X5a/Z/XijP8K9mpR8iM2al50S3
         FWewwOMX+DE60U0smFpZXk+cHCblLv6ftd+ZBzOIV8CKJrY/QRod6vwBHuV71Nn9fis4
         r3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754824963; x=1755429763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhhFXRDo1oqiT60OoNv34yNBdmuJ8HYGxW8L8Z+UYnk=;
        b=u8IxfBvFDejE1r8EL52Ft+9sbYTIhu+3Pr8nW2V/y/EbIZDHKGFMEVYP1KZDlSiHbk
         7YHj0ZXdKgjPBL48ErBYjwVz+xM1sghWVDh8TOS/dY5N4Z7f45aIj4Gsn38L4qNC1Bx7
         qj5YfbWYLz4gAWqNd3/ydZgypf6+HeU4+qVeMKdK2beXm5kqgMnsr7bWHxUZl1K8E890
         kYD2iE3LKjdIR5EAgkH6t/SgDB3PVlG4tEbQOeVRi0U9baTZJ8xzOgGmOXCoeYKP9DgZ
         puxNAn8dNbGqXMAPlIGXuvhH9yPwsh6HTGYIFh5QvO1tD0q1orhVejNpWckH6esMUsyY
         84mg==
X-Forwarded-Encrypted: i=1; AJvYcCW3/CB5GJECIjUDmghXneqFukTqEHhbxPzwZWcl0SRBfopjAJB+Sh+OcPAoGp7EvQubMf4mr0aFVsrNgVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykS2V+LfJLLF/rMZmEfWTPCK2BM9Gn+ZBu0PpYGK0oqRnSERN3
	PV7eGGPN53/UnRQ6I9qOHYE/yXAbKP7GDi7Z6BYVIwuusIMT/9eKZKY7
X-Gm-Gg: ASbGncuCWPaDVKQOdQJ415Bhmx7iVTx9IpzanadF1ILVrp3q7+nuil8sjqNli3DCD21
	RLGxqIJw242yTllEUS0zzCCnODCs8nnUrza3DFqQ1N0zTRXI9DDipSz+pLrtBZrCjpi0xM4nr0+
	n/UZhG8ZRqgG6mi9vWLwUqtbekMggZYtTQBuqZv0fsttxjJqZopXorT89TwTyP7H3Ducuq0gVnI
	gDbdhG/r5dv/43EWQY/hUrLgO4KJXjEavC4JqIXGYNXq69sOQ9pur5Cnt83cL6QbfcH3Sx/O79g
	8RNZHJjQxteWt2PvBwnMwCdU5RhUSHtIowvd1mT0zlK9Qsni8unUfGTiOMn9tBUJ9Fy1bhPfT0M
	YFir+WOZsusEQ2clgZks6EyDPgGz1UatIVQQ4QxmKh56VXBI0xci5XDw0tmfJ4/4trmuzr/V7
X-Google-Smtp-Source: AGHT+IFaniUBDX8gJy6ORJM4iQr4pxv5XTKMu1lZCkl7ztSeaP2EIElttBJC25j1GVEo/9v7FIJk8Q==
X-Received: by 2002:a05:600c:4ed0:b0:456:1bae:5470 with SMTP id 5b1f17b1804b1-459f4eb4126mr86519615e9.8.1754824962393;
        Sun, 10 Aug 2025 04:22:42 -0700 (PDT)
Received: from localhost.localdomain (109.red-88-1-15.dynamicip.rima-tde.net. [88.1.15.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f5ca8ab7sm15816113f8f.59.2025.08.10.04.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 04:22:41 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dakr@kernel.org,
	robin.clark@oss.qualcomm.com,
	antomani103@gmail.com,
	dmitry.baryshkov@oss.qualcomm.com,
	me@brighamcampbell.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH v2] drm: Add directive to format code in comment
Date: Sun, 10 Aug 2025 13:22:18 +0200
Message-ID: <20250810112218.293272-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <qf6xwtxh57jg6ico7n53ft7bepogeal5wfhthodsnf55eabgum@de2ah47jovbg>
References: <qf6xwtxh57jg6ico7n53ft7bepogeal5wfhthodsnf55eabgum@de2ah47jovbg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")

  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2444: Unexpected indentation.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2446: Block quote ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2450: Definition list ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2451: Definition list ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2455: Unexpected indentation.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2456: Definition list ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2457: Definition list ends without a blank line; unexpected unindent.
  Warning: ./drivers/gpu/drm/drm_gpuvm.c:2458: Definition list ends without a blank line; unexpected unindent.


Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
v1 -> v2:
      * Added the proper Fixes tag.
      * v1 https://lore.kernel.org/lkml/20250804212902.22554-1-rampxxxx@gmail.com

 drivers/gpu/drm/drm_gpuvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index bbc7fecb6f4a..74d949995a72 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2432,6 +2432,8 @@ static const struct drm_gpuvm_ops lock_ops = {
  *
  * The expected usage is:
  *
+ * .. code-block:: c
+ *
  *    vm_bind {
  *        struct drm_exec exec;
  *
-- 
2.50.1


