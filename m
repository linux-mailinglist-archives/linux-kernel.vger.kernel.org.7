Return-Path: <linux-kernel+bounces-743315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FF1B0FD32
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B411567E65
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BE5258CE2;
	Wed, 23 Jul 2025 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjaOEy2H"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16553282F5;
	Wed, 23 Jul 2025 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312219; cv=none; b=IDCSuhtvm/a2FNrtS/gmoT0sZW/tS4k14AFWjuC1iluAyFzRf8avXuaCgiao69xACQUvAkGo8Uw+2FrzCLFvZ66q+ZRm4TPq6j0EdvMf27Po0ZuGU2B2Dmen1obXOjoFvkNrZr4o4oUShOfiwovbmwCHz666SciAP6eAwAK6VW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312219; c=relaxed/simple;
	bh=4ZK2/FIJUsENpZnMQJIx1UGaoqt/Ntxoh+tRpcxt6I0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mbI8XRxxH+8tw1s3ZqmVQeckxT8M6L1vgnAUdj7Dnc+1dSdi43JN+LyAnmiiAhrg7hQdIM6+aAXVrOamoUaLjtv3Z75pVmkeVSWYh3/yr8OkMc4IDA8cC9BB0aMVOAXjoyEjXJEUrVPO8HhzisHCO8pwKRQw6WTIdLqEeqKpe4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjaOEy2H; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6159466e80aso220009eaf.1;
        Wed, 23 Jul 2025 16:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753312216; x=1753917016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/sMOKl1qPfDYFP5H9BSR9iy68hZaSmVV02bYi57AUw=;
        b=GjaOEy2HXeIGvGmPESInM+WwCYhTqimpyXLzFjnTW622j7ogCzPphIUThMmETRZ51d
         HZ9qJ9d8aaxlwSGN5SNIRCGDSeJJaP1q4zoWdVEH9PoTAJ52StG2GLQuNjEeDjb9asOG
         kz6SiPV5VPQGUm1pGvVGXHQYbjowpuvdxApSyyKgfQ085FYup+XdrJbwIcZV84ugmdoQ
         +JU/b8mWaEwBSvjZkHu3fJR9140i+rz+pX/nzUrz/gdZzZBVYtNgVc86yYJmRinPQVus
         O4Wl/l1UP8fFB7dxpJhGMs1LgVBfF7Hls8H7Oxyt3nfbJWA/VBU88709h+VOPhoZBtHI
         eTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753312216; x=1753917016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/sMOKl1qPfDYFP5H9BSR9iy68hZaSmVV02bYi57AUw=;
        b=FOWR3PLSwLmFDGPozs/hFrxFLwN1Nh8xf3MygDQuz1+TR2zFX3gk39euYvxo1I8oU/
         q08SgCNIYxmmvYGznkPc4fbD5E+PJ0rDAtNnXIG7ZEQw5WDHGQPby/AQtJXWe/jiLoyT
         ADMInFI0I+EGHBv0F+wp/r7n74jPlTAvQ/L8FJAenvNDH2FNjjh6loG0EJ2KQHajeP/8
         /cLWsPbDEBOtPfXAkp6M9kZ8gT7uKNO5dRh4psTJ2IB1PDOvs3bb9V45SJbtW27onX2e
         AH0o+DQsVKHB6M/QDBKADbcEhV9KiHbFo1v6GYwbVy3vSK1GGpEQbyMv3ibClLDg6lNk
         X5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWq8xyjAFd0eV1ei48XeIaJ2UYnmSUw7zMWuTPP2LG4xbC6EUBADnPOV5VFy9XKJgCLRjxtHbk3UUsI7gw=@vger.kernel.org, AJvYcCXTn7wzR95o+VrIPeB4Blh1/kgybafjknDv/0mCw863cwtv+ez9AuItvhr4MUJresBGRz8LzPEYW29ZBko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7nyVRxR6VBkHGgR/HN9sZtt+WwGh4Pk5o/HX2kEdPOizOePOL
	FZ0I6grFwYYSCsaYRS4CZX4Osl+1JDqlyOa7CUM7Yzm1mLWky6CtoP+3
X-Gm-Gg: ASbGncuGGxK4OZeY2UQqaLqOfPIk2r5z1sWhR4NWUYdWBkq4M7X1QQimpUXbXBgxg6F
	rweLlDBVI08cOtHbmsV96E1V0BZSaL75QhIHgjOtrTkRwYyVVFkhPi1pZpuj6XVCkSwkt5lTeZi
	2HGaAhRj53wDMO7xYH+8TL1V6oLk4u2/ZNP4lPUoMHHr+HGrszFKVHgvqDmoo/7iJJsI98rjTii
	65YAMVPI7Qp2Hsn6Xy0zLaDXlGU7qZ/K/PAW/azCJ6ywdSXdSwkFyON8h7VGaCek2SDwJMSglSm
	3CpRbCl85rz8F5Rp5gsEcANDbvu/SQp1ELeCS+3k9MiBdrswwMKPV5bYvyYj7WhpP7wwLo6NCKc
	veg/fTzKsFKhXWodf2e9/WXcP
X-Google-Smtp-Source: AGHT+IGKJeIrU99unpGmeSOC4hD5uT4FVQkH3W5TmmXgmCbqAp5O23lQehpbjHWeFPXPhyI/ngwJkw==
X-Received: by 2002:a05:6820:a0a:b0:612:c547:7984 with SMTP id 006d021491bc7-6186e7a1b84mr2657715eaf.1.1753312215922;
        Wed, 23 Jul 2025 16:10:15 -0700 (PDT)
Received: from s-machine2.. ([2806:2f0:5501:d07c:9462:4ab2:1882:2baa])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-618fb42942esm71092eaf.3.2025.07.23.16.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:10:15 -0700 (PDT)
From: Sergio Perez Gonzalez <sperezglz@gmail.com>
To: vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
	pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] soundwire: sysfs_emit() expects a buffer of size PAGE_SIZE
Date: Wed, 23 Jul 2025 17:09:25 -0600
Message-ID: <20250723230927.109534-1-sperezglz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In read_buffer_show(), allocate sufficient memory to pass on to
sysfs_emit(), which expects a buffer of size PAGE_SIZE.

Link: https://scan7.scan.coverity.com/#/project-view/53936/11354?selectedIssue=1648019
Fixes: 35323d8ab811 ("soundwire: replace scnprintf() with sysfs_emit() for sysfs consistency")
Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
---
 drivers/soundwire/debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index 825f7abbad32..08fb1e29026e 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -306,12 +306,12 @@ static int cmd_go(void *data, u64 value)
 DEFINE_DEBUGFS_ATTRIBUTE(cmd_go_fops, NULL,
 			 cmd_go, "%llu\n");
 
-#define MAX_LINE_LEN 128
-
 static int read_buffer_show(struct seq_file *s_file, void *data)
 {
-	char buf[MAX_LINE_LEN];
 	int i;
+	char *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
 	if (num_bytes == 0 || num_bytes > MAX_CMD_BYTES)
 		return -EINVAL;
-- 
2.43.0


