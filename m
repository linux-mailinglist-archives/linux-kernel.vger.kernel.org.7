Return-Path: <linux-kernel+bounces-838389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E28BAF0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 05:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D731941E15
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 03:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F292D0C75;
	Wed,  1 Oct 2025 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2k74Y+N"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4403E47B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759289578; cv=none; b=HzDBDK8Vlwt/QlItTU0Qc/pazjL7b+lX++MFIWCOpurUasRfn+iO9WfYS9t9akY2ALA3pTY+PQ12XD7xqk7WSMoDOVoEbuRxQcvXgXMDYBSRfgErSBvL0Rtqlz4ALhHpp7x12g0w7nHdZuniE3GkAk3MOMoJzPdKsvKxdTHxesA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759289578; c=relaxed/simple;
	bh=KviU+6USwJSwFnDl4bQG3Nhn4CNT21rUmw2aQShbMlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inN02ByY0EvuI5pXe6bwkjNSLTmD6P1iXKjfn7V/2pAx0IFfvKtsmYo1wjkcT82OJC7r0SRVL+Jnxq0QWeQUt1zIvdOOnw/m1Y97R6uiZNyyj9ee9RtJPhwNloqcjvLUqoNGNHc2uAm7KT3VJCFXcSFEe8aotN60wHnfUYjF5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2k74Y+N; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b57bf560703so5042160a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759289576; x=1759894376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+zmtX/z0UVEmGLTI9JLK1Wpr0yiIFaGTMqhMoT9rSZ4=;
        b=W2k74Y+NYgodvf4Oi5LQMVK4N/Dr4xNQ9jUlYuRrdH0LS4cpN/NB8xVnrlDDw/QA6+
         /ykLagy1xDZlcb1rnhVuCyhYFDvmLeqYTD/fJ6KBdJL0df8eIDWjwzilcMnLLBHdbIOE
         oYTnNHjTPzOZF3h+d3mRt8iYD+4i/49B3jNjQnTlRJfjk090qcrRT+zDGlb3pwvTkJ2m
         ULeM6A5uuIug5o7riw4A/F17uW3kI7ravYz3tEIawFDPsVkwqWVn9sK6NOivj1HXOOvC
         nhmhEPkw8unvq0DkzaoSBVeVJZ+4PU40nvELOqDgN3PDcLDs5oXZeU0B20vNe/JdXicX
         mn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759289576; x=1759894376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zmtX/z0UVEmGLTI9JLK1Wpr0yiIFaGTMqhMoT9rSZ4=;
        b=WXQ2ITp3FyvW4mofj5MTJDhwZyJnY5Q16CxrwK4jYMzB4WtaGtRCCgMkItbu43W6j0
         BG8r5COAFQRtcepz3PpuKzjUfKy9n1WFdUeEeftRCFZV4o1V5AQaY3gmrVtLt0IYKCGo
         J5rCRIoFAObEBVTMne869sGjcKAMQskqLYY4MsnF1DIMKm4Kc/EOnVzbbgpzK+FFBlj6
         I48b3aNuenXOldzl9io4hF+a6THZtATdlj6b4sINCPKHNM3zU0Y4f3sACFt1HF6bImrm
         NM7RLabtxw4D//VK30u+YxI1CPYo7gXCyPkXCm9VeRIos8+i3Jyv6vAQiszgNoJYgx2v
         edqA==
X-Forwarded-Encrypted: i=1; AJvYcCW3lQrBplLZfGPnFEm6XlR1b2n5FBTCF8AJTGvd/rB241jmnoNfZAbBL6Hlf5TGqBoUF0KuVO/jbR4UmkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4zNZ7heE0zVOBmJ/9WCfrQk/v0igzXeI2edQtxsjHvG+X8DIR
	Ei79wMC3+dsefN6dNGZ4OOxE8rvT2fpK9mbVpQpRBsB/XuhjOa1fKW0J
X-Gm-Gg: ASbGncuomP0TyHN7DqoTDK/69Vff+jD6Jldrm6AhjIK8nlwoejk+0dnKWfMEJFWpwcB
	ShIkahymViqz2CcCMmEH7SvkGhVZUJslFue/A0SfgRKepvUIU+Cx3Tl3SFDZmVqtGwuyd92fZiN
	Nx1ZUpUeq/apm73U9gEnUDqHudkTsGzTJ0B9BgkvWDqMrRfiNhiSD6jLsYCS0NDgSPOkn1tutm2
	KmxuNSsaLsa7SjRNyT4yXxKjZZAhzObyySerNXmgJ/4qHQTLHbRxi4J4c0IZfp/XTFzFP7jk42Y
	AtAhV9jVtHaCFedQ4aXwV0CZyJC0cCUa3HkLUXGrNBE9mguCIhhgrptzvokFRckglgRCKmCHjwD
	+Svtl6Wk0cIpF98+Bod3foWZMPGsjklS4Ua7xBEDsi+61+hILjPTs2439vA68rlnNO50KTF3oso
	fnI6U=
X-Google-Smtp-Source: AGHT+IFh4lfvADahzYY4PAf0OUbyhSPyHVh2B7BkYasgXfxdz06FSyxf7Qxl3gA703DMACpJB9hmJg==
X-Received: by 2002:a17:903:2a88:b0:254:70cb:5b36 with SMTP id d9443c01a7336-28e7f27db88mr20732215ad.8.1759289575705;
        Tue, 30 Sep 2025 20:32:55 -0700 (PDT)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:3746:506c:1567:3ec2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cf6e7sm174291535ad.2.2025.09.30.20.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 20:32:54 -0700 (PDT)
From: Chintan Patel <chintanlike@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	maxime.ripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com,
	Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH] drm/vblank: downgrade vblank wait timeout from WARN to debug
Date: Tue, 30 Sep 2025 20:32:12 -0700
Message-ID: <20251001033212.25423-1-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When wait_event_timeout() in drm_wait_one_vblank() times out, the
current WARN can cause unnecessary kernel panics in environments
with panic_on_warn set (e.g. CI, fuzzing). These timeouts can happen
under scheduler pressure or from invalid userspace calls, so they are
not always a kernel bug.

Replace the WARN with drm_dbg_kms() messages that provide useful
context (last and current vblank counters) without crashing the
system. Developers can still enable drm.debug to diagnose genuine
problems.

Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
Tested-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com

Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
 drivers/gpu/drm/drm_vblank.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 46f59883183d..c8dd9d4be26c 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1289,7 +1289,7 @@ void drm_wait_one_vblank(struct drm_device *dev, unsigned int pipe)
 {
 	struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
 	int ret;
-	u64 last;
+	u64 last, curr;
 
 	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
 		return;
@@ -1305,7 +1305,20 @@ void drm_wait_one_vblank(struct drm_device *dev, unsigned int pipe)
 				 last != drm_vblank_count(dev, pipe),
 				 msecs_to_jiffies(100));
 
-	drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
+	curr = drm_vblank_count(dev, pipe);
+
+	if (ret == 0) {
+		/*
+		 * Avoid spamming WARNs for timeouts which can be caused by
+		 * heavy scheduling pressure or invalid userspace calls (fuzzing).
+		 * Use debug message instead.
+		 */
+		drm_dbg_kms(dev, "WAIT_VBLANK: timeout crtc=%d, last=%llu, curr=%llu\n",
+			pipe, last, curr);
+	} else {
+		drm_dbg_kms(dev, "WAIT_VBLANK: completed crtc=%d, last=%llu, curr=%llu\n",
+			pipe, last, curr);
+		}
 
 	drm_vblank_put(dev, pipe);
 }
-- 
2.43.0


