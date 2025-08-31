Return-Path: <linux-kernel+bounces-793549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DDDB3D50A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A696189838E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 19:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377FC221F0C;
	Sun, 31 Aug 2025 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/IvDzH4"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8A1F5617
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756669837; cv=none; b=Qeod+mnf9UTak5oehPemQIrvZtk/GBrVrM1fxhytvu7AEFXBjoUbmhew1hK4k2Xn4XZP2mS3DIB2bmw6luxiQndl3zxFaY8TxN2HZzRakpIS8H0yfxLtXPGLJ0kLnJnArv6g5YmQJ3XMjGyxIIRsi3/ZMGD03HfQDv3zE90cxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756669837; c=relaxed/simple;
	bh=P4FB628sty88Z99STrg6jmI28kN4uzd3WCLVjRdttwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XmsVrp1WemGKsQO2zp1Vy/gN64qJlz/fqyfQjnh3U6BIPV8qOg4pzTXCqzyRVKy1GbAZmtT01UDat/7jOhsuc3RhPx2i9yg+26nv5YaIZQv8V9s+tMfCUYyterYEIWVFs8tD35Uhz+JKIISNvrbWWrB+Gm86p4G8NAGjtfUWfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/IvDzH4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so1657687f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756669834; x=1757274634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nBh+IsCBL92vWqrVuEHjY1sB3Kv+/80tU+UoBNfYnVQ=;
        b=c/IvDzH44FCCjzbB3CA1RGmYScXiN4RoMKwQmf7ZdB4Kxkol0k2mmm1AQm94iY0VP7
         bV/XwMPDC3F92w9lUVGOD+ZxdWhj88JDYVQ7gWB22Mlygauz/hZaQnZBB/j3Jcf45sP6
         n7bJsPPNaKgV5Yd1H9HAgCag9nA5rPeYxwPMy75WsmRp0Bea1IP0PLdVgViWHcnTcCHJ
         sHw6UAZ203ddJVXh1s23JLqgvbPw5VSjMDmzhsbKLfTV+C4t7XbSuZavjEsVPova/MAl
         M3y2vi3+CCGqaa8ChaR5B3sU6g/i4HR0Kc2vHMhvb2QuCvCg7fh1KwXznhN2Seu/xzHh
         R1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756669834; x=1757274634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBh+IsCBL92vWqrVuEHjY1sB3Kv+/80tU+UoBNfYnVQ=;
        b=I1Fa5uQWIHU/OAF2WXN4Cj14d/Bpynd7z7rvk4lVrYgnl81SivWESBCXkJOUIRYEWz
         ZZiVEmv2qURF37tXvf5e+lEwfVK46iHvsrEaUbX6jIo2OG5GFEd0UtyP2dQXHef+EWAY
         LRP1DEEVLo/gc9VcuIBm9b5NjftO85/rTF8SnGnZaSETFIfZRbBbVKYe8PlNH9wF/p9i
         M9S8DkPejh0cFFhhhAuA2af/oSU+da3yG/FOj8z5ueuU8bKtNy4/kdcMWCDruWyJpPEA
         IV8eri/4sJPXfMD1DALaeQDJCeeJwz2o/X9T84e5FbvwazcxjUJ5sdKfGykX+usaYkhv
         SXVw==
X-Forwarded-Encrypted: i=1; AJvYcCUMWSJB4+Vqd8B/5EtmQXYgrtYNtmr545+RbGcxTfaef/kGGwmusF33eJOU/zGDlGJtmnwKmOcCBaGx2Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Gpu/UI8VaU7Yoc2cJI1w/SjnYHgrfFsENgKKCB5l0F1ebfWp
	jz0fea55Cxn3h89gh+t5AuXzlijxS3gF+i/xO6iqkMkN4ytqhdAsmxei
X-Gm-Gg: ASbGncu+TYoSShI1olzFT8SfM7pzgqyCZNPCKoSagLEr2z3LvGoEw/3e8Z54gxk0+V4
	nl0aszEHcEfzgyfrUi2nrDsA1lQZLh5tadXZDhOJP97Y7ig7sHZofDkP29xu0so5FKFAZ6YcrFO
	feDv5fS2MEgbro0GIT2V3eLHTZ8oAB+aGnij74qZ3DZyw8T6TxhdOZFIOWCZxumTh5/Vy7pwj7f
	ZaCrJ2O0kEZ1ZPQdr1++apMsXwAU3J8nT6XUtGOfxdnZVUaDoRxAfJ0TATJe0AO1y69M595PpL/
	gqpbt8ETp/P6xmuAr6UzCIVQo/kHcUwFy0+tn0e7Sv22qkbzZUVZqSgHJsJyLf5luqWn+wrlPqY
	0DimTzC/H3HsRqTuZHHT0UCNOV6GokQepU1Ga/M1pmh9KY/qnNWkj2g==
X-Google-Smtp-Source: AGHT+IHx/YvcKoYEJXAEUUtX3eR6wAG3GYII2ll5a0+ectmFZ16V6CaoamGchWsUr5/tzs4pkS/9cQ==
X-Received: by 2002:a5d:5f90:0:b0:3d0:d6e6:5d76 with SMTP id ffacd0b85a97d-3d1e05b8ddcmr4095247f8f.55.1756669833830;
        Sun, 31 Aug 2025 12:50:33 -0700 (PDT)
Received: from simo-Alienware-Area-51m-R2.. ([41.250.61.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d204asm12232674f8f.24.2025.08.31.12.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 12:50:33 -0700 (PDT)
From: Mohammed GUERMOUD <mohammed.guermoud@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mohammed GUERMOUD <mohammed.guermoud@gmail.com>
Subject: [PATCH] drm/gpuvm: add missing blank line after declaration
Date: Sun, 31 Aug 2025 20:50:03 +0100
Message-ID: <20250831195003.370338-1-mohammed.guermoud@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The checkpatch.pl script reported a "Missing a blank line after
declarations" warning.

Add the required blank line to adhere to the Linux kernel coding style
and improve readability.

Signed-off-by: Mohammed GUERMOUD <mohammed.guermoud@gmail.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index db9b089ef62c..522349cd414d 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2485,6 +2485,7 @@ drm_gpuvm_sm_map_exec_lock(struct drm_gpuvm *gpuvm,
 {
 	if (req_obj) {
 		int ret = drm_exec_prepare_obj(exec, req_obj, num_fences);
+
 		if (ret)
 			return ret;
 	}
-- 
2.43.0


