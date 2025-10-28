Return-Path: <linux-kernel+bounces-874562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D137DC1694C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553093B4639
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3055729C33F;
	Tue, 28 Oct 2025 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjs155XQ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E2F4A07
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678982; cv=none; b=gx0NM1FDuJqlB4Ub6RjR/lSEiqY6uqwJLNs64ZG/U3jkX62MOErKxJJqXrMdKPMU66q74aIJoTKOBPISKzmTm9Uiu6nG0MI3H4EJtr2I4lsIZjrh8P78bBB+FnISEcFYz2MXwXBXISIE/o6UP0ymyMRfdxdXLlykxQdItYQ4VKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678982; c=relaxed/simple;
	bh=5Hw2kN2SLLyRcmeugDO6vvlDEM9OCK18JiF5H2jgHe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJreFJC8ycFjchi828ztKChsJLAyBJjJhKbQ/MHOhnZocgMSCBLN18SK+/2d1IPFiTgfosW/ghANd/VJl+QjmhCOyjClTaZgfVTJkdf2RiSMQpiakBYtUc3cMWwmdgXMUcURNT57D3Qn/kwxZXEI05JI/awi9MNhl1phlqCrSak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gjs155XQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4298b49f103so2252242f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761678978; x=1762283778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Nm3E4MKpYHM3eDwwralpb5B+mems99sHN7CXPQYlpw=;
        b=Gjs155XQ07W1x0DVTqydDHSRffx8Z7yJk9uqv6t4E3Q1u9PKiMIB0nc/6+OOnsfrvD
         FfSJojczAqFD+5q4zCkkHvwWaynBxtdcxTIohzl1Zk13XYn/uq/9lav3NqkEWU9pp6B9
         2gzuL/i1OW70mm0JXxa+5Yc21HnLbKyMUIlmuQPzYFsdezjlKsOBessJolEgBE6k/k+L
         jfXiq+p5Q4uKEl+G4uBtap8md8VlvCSXxWD4L7X54SeggMNnOluKEgd7eYLatNZXKo6h
         F3KAIGp5QWEuCw2GvBEl+sENmnLwX6nygVglQQNTcBUUcNbb2om/mAZ98L4tfsYYrYM3
         96wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761678978; x=1762283778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Nm3E4MKpYHM3eDwwralpb5B+mems99sHN7CXPQYlpw=;
        b=QSKcL+H5ULYu4O4UqRxy2oGush9BVyDsAvhmQ+ZbCzDbd21kgDyaZmFe2O2klDkBeY
         VerCRaGEzvt+0pL/c7sW2e9S1Zco32gqL6QsTlbJxCSNibHBMOhtq4/crmMpCYDhjC9s
         MRVRTfSy6oBHnDcvf+1Pg2GHCd45jF/LrvDNer1FdnDE6oVbIgSdG1T0Vil9j8E15WVW
         uVonRA+bjv7slyKbeSsS3ddOkQsWSDvo4eCRptPuohTrqIkX512cyrsJantCvmk8r4jY
         nS+0qO1Qy/4oXgQ5RqvqyE1mylLR3Pu/zjO+P6trjr1GO0U4Tp3Z08a8aETi38BUKUvK
         UZfA==
X-Forwarded-Encrypted: i=1; AJvYcCUCAcRlcOth/s420igYlXC9xE8tD5VifLDBGyb0uYd4CmyvgPxhHzU/tOXCC0KDIPsU2EfDaUppIy6YMbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIWT4ttoyrSJvRY1BpBOZ4U3b1gfZEsvI2IBZtcxCaZClHWA9
	anA040Tjf0gQ5BhtSXn/rm+VkceARi89UXHdbi7P//im0kEiDSVAvQjw
X-Gm-Gg: ASbGncvil8d9+JerLtDGb9AfqcyxAgAj94Esdt2O3vXh3G6c/46ERcE46N+Pd3R+w82
	FDUeDPYQgrl8DMSTuOoz8cKmxXh5XReVDZbHTQRHIHy6sE2/gLeslLgrPsdwgkUKuQ7dxGdDkub
	gRJNhQDo/PkB/OpNkuQc0bU/ANgL+/cHprvYUnc2X5Njuob0CrU03zswPygK4q+kwZVkTh1fHlO
	TdNWN991J1jhjev9IVPbOQ0F5lSJ/JvhoSKe8Lvh3Ot/WFnMqlK3JqVSzMPFocK8R/XJUgQrF9n
	hLMpVZ91kn28x6nAv0Kmj94osh+MqHBQcpzH/xjETjXQyzMN8m6bqpPLEYxHWV1f+NFa8dNvGEQ
	YNEoRMcMu5M8n7yaiVvPAwpU5JweO2bKQY5w+8jqkO5hbITusO0avwvjgwD0CqI4ZSF8ZM4oA/G
	kBz0bDQLfk6YkIvkmuaOQbIvTkfUQPc5HOpptOswhHUUqGHhdElcg5wTlJPOQ=
X-Google-Smtp-Source: AGHT+IHffoMv5k0CgidXAMVyKRHrRcXi4iDRyKmMUzXSwiqt2PVTWsko8mfU0XNy6JLFIyM8tRxTSQ==
X-Received: by 2002:a05:6000:26d0:b0:3e9:2fea:6795 with SMTP id ffacd0b85a97d-429aefcaa41mr153239f8f.53.1761678977999;
        Tue, 28 Oct 2025 12:16:17 -0700 (PDT)
Received: from dell (229.red-88-1-12.dynamicip.rima-tde.net. [88.1.12.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbb2bsm22256326f8f.13.2025.10.28.12.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 12:16:17 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH v2] fbdev: vga16fb: Request memory region.
Date: Tue, 28 Oct 2025 20:16:15 +0100
Message-ID: <20251028191615.2765711-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <6c565f4c-ef05-45f2-9a82-cbba4a11cc07@gmx.de>
References: <6c565f4c-ef05-45f2-9a82-cbba4a11cc07@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch reserve and release VGA memory region.

This align with Documentation/drm/todo.rst
"Request memory regions in all fbdev drivers"

I've tested with 32bits kernel and qemu.

Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
v1 -> v2:
      * Add release in vga16fb_remove , thanks Helge Deller.
      * v1 https://lore.kernel.org/lkml/20251016171845.1397153-1-rampxxxx@gmail.com/

 drivers/video/fbdev/vga16fb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index eedab14c7d51..208e3eefb3ff 100644
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
 
@@ -1407,6 +1414,8 @@ static void vga16fb_remove(struct platform_device *dev)
 
 	if (info)
 		unregister_framebuffer(info);
+	release_mem_region(vga16fb_fix.smem_start,
+		    vga16fb_fix.smem_len);
 }
 
 static const struct platform_device_id vga16fb_driver_id_table[] = {
-- 
2.50.1


