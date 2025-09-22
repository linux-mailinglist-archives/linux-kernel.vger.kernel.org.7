Return-Path: <linux-kernel+bounces-827640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E2B92480
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9EC173818
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F283126A5;
	Mon, 22 Sep 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZuV5AD1"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15F3115B8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559477; cv=none; b=krKub/81YRqsbglVIq7tmZcLTMBVkBfMoveDueCqF4AV9YZiyWwx4IT2kbB5tRccu84GJ6TkPMQgf97Nmv98TJiNQl7e8v+9Ag1YTBa1gwVksenO16+dGhMBSeRBLIoII4XgAovmKjomeEU1OgV6um0yEcYOw99n094BWVsSTBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559477; c=relaxed/simple;
	bh=4X6/rYhYAaa/xGK/cCxDNg0XoRNHR8o2oZIpX/vwgNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kpj6HSjV22kfMoRbMNrmTKmZDg1vX5+hdQu89TZV7nx/17kpgju1EnX048eYhD/BddEYvv6WTf+OHKzJLrLR3KRC2U9hmDMBumtqEE0NY6lwlCADjZjnc8uXWMo+fnNMtVQcDJesCeDR3OILkEiqgAvrnmumP58sHdb8rsxsEjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZuV5AD1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b2d116cd1cbso17506266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758559474; x=1759164274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+qVjEH1OrHc9W6t0k0tXjROXejrmvtmPSgsAnXcZ868=;
        b=PZuV5AD1iPU/RDj2arbWlF2IHGIpZYSJ0rzpSN0itCbVPiAhlmhOCAxRmmv/LdPJ5S
         ornsIhH42th+7pyVVbMSxg0aa0dIjdFPaxHI8hDPNDuAgke61bWy1gN0h+AWIYTMUMeY
         B/Y9T1QkVdO0TGZ0/0vrxwsJDMqoqLD5iNOvDQ0SfySgJ8YYuRc3Pbn3bzjVfrGadgox
         +HYYOdjlEmS+X3NQisfICmo4j91rewlodmfllYDfDH3ZTRBarD6HCrbpUXM3dsIDMtrn
         WyPuGoi4ey5m46neYowQaFSt0Ra3zPASKWMBfMUWxCfUAzdSzr53cTW1pU39zbSEksUV
         LUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758559474; x=1759164274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qVjEH1OrHc9W6t0k0tXjROXejrmvtmPSgsAnXcZ868=;
        b=FRiHUK5yXVTjUP8n4W2zDptCoEdqp6HEhnKgTRsdDrCOT3+6cf+PymDrJHf4rG28Zi
         AfpOrvwAp2W1kHxcGsTRYPb+Y3mL3FyWi7iG3lRz/D+sYy+qffaNF2GLcRVkXtvcVfxF
         8VO5Qrzf4NHh5oWPtlnjm/rfPjU9truF01HN1+G7rWxLXSofiUghVrwynUV3mhwPwe10
         e+DUVKliCTRhs5cKdTfBsD8NaXt/K1P492d9Xv9dGTB5zVlzTaedkZ8q5RuEzTKcLUf/
         FePWT2dY0IXtawLQVUW1LCZArmJNGCfhJ7EyHK/T1fCNcq6N84AS4u+PNskSIJdqExGM
         2WTA==
X-Forwarded-Encrypted: i=1; AJvYcCXnsXHuMteUowlOOqehljOY/PTCqiq+2/jk1SHifdKbr/usCzOLYH0piX3CDw9MMI2YbDFdFUb5ChleGEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr9gsTvrCg8V0ZXQT4rLvSQN9f868VLg7Al7SJ7U7WOAUIY2H7
	vjM1F7C5eblo/66hRcs86nVeEtsE2fy5OkF0dPm7TNEOPkvRYRsn66XK
X-Gm-Gg: ASbGncuHq4RAM9sMCofLQkoPJ1Ds39tCeONadABO7nxKWkHO+ynYdQMOJEXyfRn8Ljj
	zpimjiOs0lHwa/wOVi5EX4kenvZwthNAmb/Ab/zBsUqiL2P2ThczISWV2lsQ01p4DzLu0eYh87d
	gQEHhmkI1U7/FOVHYisaJmHsPr9TRpWs18VxFkpnhNaAAFRN39r2kmbaBrf4iVVhoBakXXrl1rD
	IGGrvKeKfniHaMiHQmMbCKKSLQjWZRfLLDlwAml/AoFG6WMyoUNAU8IspEvSykku1t72/xQ5gir
	3wFxeLPX2kvgSMRVTkZgFxzMEVJZotrMaeGGLxIm9mI/tVQY5UgZJu5C20ZHLNUG2aZkbw5xCoW
	U4iHTHueIcweUJ5aE1uMviS18YQc=
X-Google-Smtp-Source: AGHT+IGIF21Xhnp4hpfIy7oA9V9TFGFTlwmwiLgfHOfK/D3mn2OP04oE6hrYlLRBvg7agjvzZJaJ8Q==
X-Received: by 2002:a17:906:1755:b0:b2b:c145:ab8a with SMTP id a640c23a62f3a-b2bc145b425mr204508766b.3.1758559473592;
        Mon, 22 Sep 2025 09:44:33 -0700 (PDT)
Received: from bhk ([165.50.125.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2d4309ab9asm216084566b.74.2025.09.22.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:44:33 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	mingo@kernel.org,
	tglx@linutronix.de,
	jfalempe@redhat.com,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] drm/gud: Use kmalloc_array() instead of kmalloc()
Date: Mon, 22 Sep 2025 18:43:59 +0100
Message-ID: <20250922174416.226203-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kmalloc with kmalloc array in drm/gud/gud_pipe.c since the
calculation inside kmalloc is dynamic "width * height" and added
u_char as the size of each element.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 drivers/gpu/drm/gud/gud_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 8d548d08f127..eeea0cb4c7aa 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -70,7 +70,7 @@ static size_t gud_xrgb8888_to_r124(u8 *dst, const struct drm_format_info *format
 	height = drm_rect_height(rect);
 	len = drm_format_info_min_pitch(format, 0, width) * height;
 
-	buf = kmalloc(width * height, GFP_KERNEL);
+	buf = kmalloc_array(width * height, sizeof(u_char), GFP_KERNEL);
 	if (!buf)
 		return 0;
 
-- 
2.51.0


