Return-Path: <linux-kernel+bounces-856687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18674BE4D10
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE34583B32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E9921C173;
	Thu, 16 Oct 2025 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+Nos+lS"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBACA334683
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635131; cv=none; b=eG4we8LIW7KH0+Us2RsEM96o35DTzBq/AIjAOqom23nZ5Y0cFIZLjahu7AbZyx1vzNBl7Wl5jxsyVHiK4K4JwWqWkhdMFIZcFsEkvLhsuyBVRBkrnhjNDojzRhXdD/cOZ+ioHeWaftbTJJrj/s+3ZhEzjLQl5Dig3Kt0ZiBK040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635131; c=relaxed/simple;
	bh=u1UIA2BIHa75e19Dzixz25eBYZXZ7a8Rdt0+VX/LF+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YII7uqiIWiI2ByiCfr2+Imf0318gdglkxpT6KineSiAlaz8wBYF70nM8OIEWITkYw91WBOvrEd0Fhl4S7c53K68t2JKmwGdtOhGw7pGiae6r/qXnGq2CZH4ittxmgiQVyA4eLbDocKVKhrJZm1C/pBvsK4JsF0vXKGsqfWN7HlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+Nos+lS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-426f1574a14so614005f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760635128; x=1761239928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R61SKl0heteonfQWMBAG66A3jLT07W0AMS7C2zZswDI=;
        b=C+Nos+lSiGdgujFJDKUQyd+bH8qPtw7hcHWCoY16VPySRRuIxsInKJsdG78YXKeZyL
         szPUURnyfJYR9jhlawmikP1TBSDEzogdZ2HAAmKpo3YBZXGpv96c//zVhDAUZiypPGq5
         h2+ZoT2DzUTk4UIE75b2B7j2hLXeNkJNhgLSF1iXdbOXpBOx2gfMU2QMsjUh+DO5KA3p
         MS7o+uUtqqpzqTEQ1uFlmHotnMByn1/h85DKQRk15KDM3VCtcFcB6TulMloXgrIRftxE
         2m8kJ6OAoTV+JUCftD6ISOcA6dflMc+q18plkjS68cuEyl8mJJwh8dLQNmokFZDmPsOL
         Ntkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635128; x=1761239928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R61SKl0heteonfQWMBAG66A3jLT07W0AMS7C2zZswDI=;
        b=cSV05ksN0/Y2Cqau6HD86ec5vAMqgFa0sAIjSAQYGDklF3OxWnKwPXBWcH+ceB4IP+
         ULFaNB8ZHVaEof4/o0YBRhJE5YpOa7FEZWCeZ1NaVPXZ1QVotXvoBrC0dVBQ/oTzmOTF
         /rgqH7WHJfiYzgG3zCYeLoQuFEVcUceiHpnwgsv0n2G9MbXO+wzbIWez66kO1llqLkTO
         UmB0UmzisoKv3zT94MuoYzUtB6+nONTWh9cSHxgf1eGlQrkO3sTyWipZ7q5ly5VmLjVH
         O5emfc8qI9nkPc2a5/pyZ0ZO1dMda6OlaPoi4zYYusp5YDThcBpWrlo0NNofioc6jfMR
         47jA==
X-Forwarded-Encrypted: i=1; AJvYcCXiEjkjvHx6Q94fP1IMcNaFk4JC0VGKtRfm6Dma+tpYSqtFPOFlUltvQmLoPMxBFwGleRIJYAScFU7BVp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGCJKdPIBk+SaDXFcZlrPH04ycxpYAZMeMREnDxy91bIwHusnB
	qQO6VrOGPg4vOQTi+VgSZ6UUjUvcM7Pi8VAnDc3FXL9oNlS6eIov5o92
X-Gm-Gg: ASbGncsvRwTMIK3q8K3Pa8K1dLDQDw10xO86fNe5DHiZGY2un0RsLdUrev/JTkmrAKV
	JWumXa5lJZyHqFCa0MoXyuNVaYLbalV2GfOdXK+AVSHLnkfuuUXr09TMyjlROgD5+I+ZVqQWRHW
	VmGboy3WYeZRZPq587tk38aMq0QLq0JgoCot1tz0Q1yndA1npzycso7N/a7KKh2xiW3UASwX5v5
	VoIZOXip9RHB3bV54LPeE79VXg9WUDmmU5QWawAvi4BzVvb/c7oCiCY7Me6EhMzOCo/ITuYXDHB
	OLIMt5yNA25oFstlB55ihPsGstTElYckOPE3dmOAB6boe1oEi0JF9LwxatyhmrfUQ4Ua8cSSUDC
	jOxX8wgeAa3vG2pxWIlIuG+AEdMWDJieA7Wyf/a/ChJVck0V+r6QMTXbAWlm+PXoJBkJQkmZox1
	rUruHDNVS2ezTkXxPzBhLq40WDd+zNOTN/
X-Google-Smtp-Source: AGHT+IGtxy9t5BEeTVIETxG2Z41hQ7E4hmY7HEIitTLwANiVPbSqfV1FzBoCuUQpqq4aGGwjVLWXHA==
X-Received: by 2002:a5d:5f82:0:b0:426:d54a:67e with SMTP id ffacd0b85a97d-42704dc9bffmr775251f8f.44.1760635127949;
        Thu, 16 Oct 2025 10:18:47 -0700 (PDT)
Received: from dell (117.red-81-33-123.dynamicip.rima-tde.net. [81.33.123.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711442dbaesm39349145e9.8.2025.10.16.10.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:18:47 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH] fbdev: vga16fb: Request memory region.
Date: Thu, 16 Oct 2025 19:18:45 +0200
Message-ID: <20251016171845.1397153-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch reserve and release VGA memory region with `*_mem_region`
fn's.

This align with Documentation/drm/todo.rst
"Request memory regions in all fbdev drivers"

I've tested with kernel and qemu both 32bits.

Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---

When I've run the code always return -EBUSY which makes sense as
mem is already requested,`/proc/iomem` shows `000a0000-000bffff : Video RAM area`.

I've seen that `cirrusfb` has this kind of code wrapped up with `#if 0`, and I
wonder if it makes sense to also wrap up with `#if 0`, at least , in
that way the code gets commented about expected behavior.


 drivers/video/fbdev/vga16fb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index eedab14c7d51..f506bf144a97 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1319,6 +1319,11 @@ static int vga16fb_probe(struct platform_device *dev)
 	if (ret)
 		return ret;
 
+	if (!request_mem_region(vga16fb_fix.smem_start, vga16fb_fix.smem_len,
+				"vga16b")) {
+		dev_err(&dev->dev,"vga16b: cannot reserve video memory at 0x%lx\n",
+		       vga16fb_fix.smem_start);
+	}
 	printk(KERN_DEBUG "vga16fb: initializing\n");
 	info = framebuffer_alloc(sizeof(struct vga16fb_par), &dev->dev);
 
@@ -1398,6 +1403,8 @@ static int vga16fb_probe(struct platform_device *dev)
  err_ioremap:
 	framebuffer_release(info);
  err_fb_alloc:
+	release_mem_region(vga16fb_fix.smem_start,
+		    vga16fb_fix.smem_len);
 	return ret;
 }
 
-- 
2.50.1


