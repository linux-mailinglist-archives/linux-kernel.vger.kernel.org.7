Return-Path: <linux-kernel+bounces-891430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67606C42A64
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF6564E452E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E3E2E22BD;
	Sat,  8 Nov 2025 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5AmjzQc"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9099C1D61B7
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762594435; cv=none; b=NNeD0/uk6UOxRMmgSKAkYC+ujL8duLkNkMtvCGvYnwidLApKVxc5IXSg7p53fJ9f9jJZotIGZKYEYdz3s27qLMbKqaBG/iMnJ2xgXOXvbyeEgT/9yxhCPmPp2OQqF6Y/Jd7r3MSwkthmHdqoFHVcFtKD46T+9pMsuYUmIKoDjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762594435; c=relaxed/simple;
	bh=/Yh0dc4iImsJEJ2MRXkTnS/IDGLaDFRBsXksKigswSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtETxhZjWknBxq2ETcR9ApfasAVzN1wBWLVeRqMmUK9wzLEkQVc3n05Ksn6gjMWMTG1WrbtCpL8mcRos58BwyXBfbnhY1VK3S2usjwkpBZ4+xDUFtbg/cho4Cijih9AoD73SClNqnwMDt/Ngfmzu06uaTRVD8xCE/9bJOO5Wdl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5AmjzQc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4711b95226dso14164455e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 01:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762594432; x=1763199232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiApigOOG8LHPEXfDKXbVktrWsjTUfreGKJRz4Nc8lA=;
        b=J5AmjzQcMElJ5E7w6yEBEY2mTIEScDHEs3PUNRREqREfjfSMWtsmrN7SZRVTuTnRVN
         GYUFWwr/LkimVeGJuKWKubkezwb6pms+8+MYBNmex/lSDfM0U/e9cxmwbbFMTbDSMMqg
         f3Rfkmo5vYy7jbw0iEAC/jAvDGXm24ITk5slI/azCcg+vQWcElVZusPRzYZyUeh24uon
         lhqwWPNgNXg53MfcKiclk7X9Qt1bbBgRTHgVbONPwP4B6SLqqN2tibPlAaMTYqeiBKnR
         L49hUAxl7v++MvSP+0ak6KWj74outAN3Fz5utyM3NeTV7UxAf2Er2St9KHxmdwFxDNHn
         IPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762594432; x=1763199232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QiApigOOG8LHPEXfDKXbVktrWsjTUfreGKJRz4Nc8lA=;
        b=fkB07NLc6fxq3XWqu4QG6s9e+X7VmgOEYbuBiX+9PRNpQ1SoEZzpjR91M1tcxukOgR
         16JijdeGDC/MaiwmouGLrrE2ewxuGCmEAPqdYuSy+XZ6RtVS+r184uVbBR0aPK7wU4e0
         1QBsvCyRtKsWdkgMujf9frGVt1tiATFDjbl6YIB/42P7xWgRmtaOBOUN59Vnf0G9T89G
         77gSxd+fKwuVy+nIjd7BngfkzHrXJGVYCYME0pKB9rZK1BdIuUdwKuvUqWcWEQ4AKaHR
         ASavL9H/bEfHApLDEsBkCZPT/9RWTGXtF9LWDLVoSPmWQRVbQuDlSvbgZ+F9dG4e3rQl
         BAGw==
X-Forwarded-Encrypted: i=1; AJvYcCXdPgQIzljomqO9x6nD4c7HSjXpBdkO9N5dNQ0TyxuCt3LakfalzQukPwhpgU5t7qjU8eh6z5P61nKFSgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRG6kJRPHKYok2EITda9cpOZ4r2pBS+SeKk+dC3X1B/yMsTnye
	2OviD2+RMFtKqt1B9djoi1ojtXcNjqHrJuLEsryqxUYdpeEnVXqWMrk5
X-Gm-Gg: ASbGncv1OtaugaPN/Iinn1Qbni77nl3ICGtLS0US5pOY3ZVn6tp5+Qt4hBXUzSmhPrK
	TgADusEiQh+J+E09Uk9SSqhRrNKqEmdAZ0nMxlIvXbW1O0DMz/5tQ7O6lq0MSdjadPMHci79Vip
	7qKsdsYOZ6TVPAHBbVA71z6uO/q2s0LyiH13AjlBvVOsUZkfR6C+ragbF0hu7UDAGV5D4bxjnI9
	XPslGbVsoyTgQZiSyJSEi2rnqk+P0Of8mER/4IdaMaTmRG1l4C0HQNK5HYr6gfoe4GI8nPVhDKM
	z9+YfIFVX7ua4Vbm3ZUhnDBMRiv00tBzEDA/gx9qgXgAzvyEu7CnXoLLYUhNiEFL3VazJUb68mh
	ktMC0KgElRMbf3FF7IeN3LdgHhVAbCJ9+a40qTOEXkOpKNGqRAvin+VQB3oQy8MTKVtF0+8t8es
	uFcAHrYsgiAn+t+00ZNwc9EmlNLNYY+mS9UJrUMPsj8tnzhquGVDgWFDWGS6ssRtP+XNOSraLBw
	NxNajft
X-Google-Smtp-Source: AGHT+IEd4XyN6o1k4yt4rMN5pB+/mSHIFBxKb+L3mgiOpSENoQYSE80ZfJu9ZJL1EDqCKgK7GtsnaQ==
X-Received: by 2002:a05:6000:2681:b0:429:cacf:1064 with SMTP id ffacd0b85a97d-42b2dc877f3mr1621212f8f.29.1762594431704;
        Sat, 08 Nov 2025 01:33:51 -0800 (PST)
Received: from dell (229.red-88-1-12.dynamicip.rima-tde.net. [88.1.12.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67920fcsm10435119f8f.39.2025.11.08.01.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 01:33:51 -0800 (PST)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH v3] fbdev: vga16fb: Request memory region.
Date: Sat,  8 Nov 2025 10:33:48 +0100
Message-ID: <20251108093348.2842180-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <f9998d60-e532-48ae-8e03-d867cc0ec847@gmx.de>
References: <f9998d60-e532-48ae-8e03-d867cc0ec847@gmx.de>
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
v1 -> v3:
      * Add space after comma.
      * v2 https://lore.kernel.org/lkml/20251028191615.2765711-1-rampxxxx@gmail.com/
v1 -> v2:
      * Add release in vga16fb_remove , thanks Helge Deller.
      * v1 https://lore.kernel.org/lkml/20251016171845.1397153-1-rampxxxx@gmail.com/
 drivers/video/fbdev/vga16fb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index eedab14c7d51..3b4c50d98ba6 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1319,6 +1319,11 @@ static int vga16fb_probe(struct platform_device *dev)
 	if (ret)
 		return ret;
 
+	if (!request_mem_region(vga16fb_fix.smem_start, vga16fb_fix.smem_len,
+				"vga16b")) {
+		dev_err(&dev->dev, "vga16b: cannot reserve video memory at 0x%lx\n",
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


