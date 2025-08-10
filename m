Return-Path: <linux-kernel+bounces-761372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B67B1F8F2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 09:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5003BD2A6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A422144B4;
	Sun, 10 Aug 2025 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzlVMe4q"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4161A7264
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754811638; cv=none; b=XctkPdjgn/UX6ebNKAbLuYpv7K++YsZ7SEVVeSeKe2S5n8tUWmridKdULeQzMp+MIxZHTshomijCjI3pnHoTCTSpWDprebjazVtLCb3Umo7MVl2qhsj7ygyNFO8z4cFizbGMp+AakxMCVmUADtSQdDux3HCxjEZ8VDfGZqVOdeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754811638; c=relaxed/simple;
	bh=Y2MyhjjslDupB6WjuFHwZ+ZhdYcIeH3CC6kbwxOn4Jc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t6Mm+pnn/693p8UzLYmQBvsF3lLzk6oyKeZGegWrSt+LVey4H4p+nfw1HRkukm+7vdPhZcvfaYgBd2+DuFzz2NdsvEHw4Dm7yazN2A5K45kpCx9RjW7Uc2YLWr6He4VPEtHXcIP9I4US2tYOoqTKbbMVQz3sD2Zp+f7H23ghb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzlVMe4q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-240418cbb8bso21466805ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 00:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754811636; x=1755416436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f3qWSqA6uMau46FnL/gjHf1qw0j0WRwZWdWAHLL5xbI=;
        b=OzlVMe4qV54/0Tw9iSMIGyCw4R8qao0mYR9+RP8ntD/O5iDG7NelEGDoNC5q1x11Q2
         k05VhWhACH37aHEcbSLSBNUkDaP5fiSoaqngeKeKDKCs6fyQbbBC5FcZj7S8GG/Q8P8Q
         bKq1bp5o4+sEOa+IuP2ulXAAO1XF5okHHV9neayjB7Jo+vUtVpxWgVtFLsEUbQsr9vhV
         fSTXjU2q1eB9r+WlhjJJ+L51yUbBwrxAmEeL5qfJcJV2Omw6qGU7yzvxtJD0JyrFwO+0
         FI0IZNXGIoika0l8L7PikOwJh2ax4JuCq1jbq0tfHShhZdkXVDEwX5owECSWqFZ2LItW
         co/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754811636; x=1755416436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3qWSqA6uMau46FnL/gjHf1qw0j0WRwZWdWAHLL5xbI=;
        b=kZSSMG2ZmYxNr2WwFO67C56eiRqPOhRixg9tq525qqVHgd9edyPvvsmVFbPHb9wIy3
         e2iRGMBksYlwoK8gZIWlwu4/C8E2fYsF9Db9QGsabKpK335zknZMpZ9gfLILPj7uIoje
         mC7C0lkwJjQPBYC6x+DJIU6dQubulVAPtTQcVTiSy9rKDl8IAfc2XKkh6XZCHpbdVdKU
         GbpxwTYNkpVfexCOQsd5LYgzkAY4C4ptCBNQ2mbewPzXXkDG1J3SIpxAr16zOikCuvuV
         GI9tc0xjwyoQIRZ+fUnMhaDypSnESY2ISF/Le7xcrWC5wcdBAE1Q0BTHAiEZKKHeWX+/
         +JMw==
X-Forwarded-Encrypted: i=1; AJvYcCVcbl2an5kiJf2bmVYr31y9CnjcGYK4lFOo+I6vFvj95kbLk8iyhAKCQ7IrTXB2FH38Gi+TMtZXZWtnsK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxehECRM59rqjcH6jBXSDUqPwsiyRQxC2LeNpvpuxLxGMNeK+/e
	hnJ+PgZo/2uOJTjiLLDtLZkLPEcI0vcIidbMNBWzG8s/qJRAeCU917r8
X-Gm-Gg: ASbGnctQ4tsO315qdYX86UHbNfoIjLllbK8ACfLioEAMbDt9cmCLpDwRWQFY9vBmVqQ
	yYOYaWoafOYvInWqBbfq2toVoncC1bAWZGPuNdWkiXy01ya3bVSW3WFi8eSlGyc68T4z8zUn7xM
	79TabqvKdOjsKdo4dtSHXQGfmMyU5Dhh1RGILzYvD0AarlPjd8KxUkNQhneAExvd9kN7+qty6jK
	57iHkMAkeGIfDlWaw175rFLvFTrH111p2LoKC6aKjL2PpNbFf/HzpPDfev6TE6YAdDe0+8hjI7f
	+i0F9vSueCx4gJjImeGFasFeRKwfn8Mj8kxBmrG4FSsdnQdiYOdUH/OzQWkIoCdFKJXy//eBHu1
	+d+7uegwMXp1sSlFLbo2WLNC/v9+vwiaUdw==
X-Google-Smtp-Source: AGHT+IHj8XJuZT+e8n3ptEvI4d1ZhTGMLL33JrSEDgad1N3hMltDmcEcAbLS/oGZI8f23DZetqYLKQ==
X-Received: by 2002:a17:902:ea0b:b0:240:b073:932b with SMTP id d9443c01a7336-242c205fe65mr120641005ad.23.1754811635618;
        Sun, 10 Aug 2025 00:40:35 -0700 (PDT)
Received: from pop-os.. ([172.59.160.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976d13sm244105245ad.109.2025.08.10.00.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 00:40:35 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH] gpu: fix spacing and indentation in drm_gpuvm_sm_map_exec_lock description
Date: Sun, 10 Aug 2025 00:40:14 -0700
Message-Id: <20250810074014.339366-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes:
./Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2444: ERROR: Unexpected indentation. [docutils]
./Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2446: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
./Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2450: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
./Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2451: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
./Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2455: ERROR: Unexpected indentation. [docutils]

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index bbc7fecb6f4a..17dafa01700f 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2441,21 +2441,26 @@ static const struct drm_gpuvm_ops lock_ops = {
  *        drm_exec_until_all_locked (&exec) {
  *            for_each_vm_bind_operation {
  *                switch (op->op) {
- *                case DRIVER_OP_UNMAP:
- *                    ret = drm_gpuvm_sm_unmap_exec_lock(gpuvm, &exec, op->addr, op->range);
- *                    break;
- *                case DRIVER_OP_MAP:
- *                    ret = drm_gpuvm_sm_map_exec_lock(gpuvm, &exec, num_fences,
- *                                                     op->addr, op->range,
- *                                                     obj, op->obj_offset);
- *                    break;
+ *                    case DRIVER_OP_UNMAP:
+ *                        ret = drm_gpuvm_sm_unmap_exec_lock(gpuvm, &exec, op->addr, op->range);
+ *                        break;
+ * 
+ *                    case DRIVER_OP_MAP:
+ *                        ret = drm_gpuvm_sm_map_exec_lock(gpuvm, &exec, num_fences,
+ *                                                         op->addr, op->range,
+ *                                                         obj, op->obj_offset);
+ * 
+ *                        break;
+ * 
  *                }
  *
  *                drm_exec_retry_on_contention(&exec);
- *                if (ret)
- *                    return ret;
+ *                if (ret) return ret;
+ * 
  *            }
+ * 
  *        }
+ * 
  *    }
  *
  * This enables all locking to be performed before the driver begins modifying
-- 
2.34.1


