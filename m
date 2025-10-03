Return-Path: <linux-kernel+bounces-840975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E88BB5D98
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 05:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87D213445E1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 03:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1442DE700;
	Fri,  3 Oct 2025 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esQHc13w"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D882DC794
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 03:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759461813; cv=none; b=FlVDYLSGlWptbQMqu34wxr9x16tu0VaKuI5vHyQQJo1I6cPY8F1v63ZPcfF+rpaUdPzKxCYPICvS4zhBExHMqiUwtiiFD+SLHpFOoZclzlrYJmHeIyy7HwhTj3/uR/Nl3NXoxhMD2QMMc+OV7/XdZ0LggWyFjHVFE8gtPC0UPlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759461813; c=relaxed/simple;
	bh=Pi8NzakSne+S3t1+MxwHSUR5XlaKgmTuCdOWjw0b7e4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uTVxAJp8SANLtw2R8dGVBIAKvqYK3xpSpa7tBkMpefgG+r5JQUzhScb4Ogyd/idnw5qk0Y6k2ZVyi2mgejZ9KQRgqvps0yaQGrWexxA6uBrrdJYfCB4LzSVBM7+kfNedlCesRFGXmG04TGP10hU/fiAHFf06T8fTr2k5fSP1sns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esQHc13w; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-782023ca359so1817876b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 20:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759461807; x=1760066607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4MpfPEc8P9b4L2GNCySEMZpVOERhqW8EFBw6DoknkFk=;
        b=esQHc13wV2TOANkYhI/6tZ/lAe9U33I9LLbiiqKqnxK+7Au344rMA/YADgR1OsUMtf
         hgA/iCX2yQoLTPaLeNgg6SHU/3U/4yxq0jBIGh60uCLv8GnYZPLSYV4VLMkCANT3ve9/
         3uhk2HkVoJxAa88a3V+cWZpnYB9mBctz5JFt8vw2gSPbiAGZD+dmtA3IpksH7cSu3B47
         xd8DGhKr0D2c8n1etqsBFTRjlMj5qF4gHihtAUbai6JdLMtCa+rKfyxn4e5ub9eDsjoW
         n/8hsuLshezJxNhxsk9uH5H2dsiuhqW3DwtFVswzN8YA8TCyHCcmalxG6aJez71eba9H
         7Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759461807; x=1760066607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MpfPEc8P9b4L2GNCySEMZpVOERhqW8EFBw6DoknkFk=;
        b=tYI6yeCTaMoUpeoXLblgSsewya3hBS381EIQZD0l72//pP/fGHBILS1gbloFjOITBU
         udrmStJaUQzIKS4Zcqqh4oOvMR/R+QgwHpwY/fcITamVBeM1LQ3gVx6iRgZjwt51r6Jm
         YzHEQdElQdjFQx2KSezceLdq3MVux0S1bFv7EoCRxXT2gbxI2QdMZEl5bDlQuyIb8H9q
         l9qg/WDPTZ0q1JnTREX333tVL+y3W408BytSL+AdT9P6QzU23x7tFAzi12v6Bh8Bq7Y/
         lxQFor+kM52c8RTCpIOODxkjbIvVImNL4hrD0CEankatdpFMKk1r4V+Z7drsLwJgaO86
         RoPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy3u19uE9oZEcblGQiqjey78bUImBd4AxqmoEA1BIGXdjXgn/pF/5W6719L7pV91qw5hJINUvY1OSI4Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/7Vjd6/8PPO+wf97nCEqqGutxUj8n8IDpMkgW7GjtOAILkgXf
	F9/dLJ6ZWkxfODv4H4vjBhT5earUnlA5u2759qfJtRUbf+G82PfSFAe4
X-Gm-Gg: ASbGncvuszvUi1rpzKTYzMegeIQPArr+wN6G30PGK/jjmlLlCB/f/k4FUeqTzosmiGe
	/ygYMLIb9ZP//uoTy1ASLPKAzdru5Rf1HW857cBqlYBiRiW1wktya/Is8xIhcE2qcQAsu1bL2bI
	+LeLmWcXLEi3NExLHB8wpgIDlVVdMIdY4LXepNHuFFdntnbm3Bj8OIHYbNhXN/ztEz3gTMzvjl3
	gCX6P9IHtaT7DR1wBxhr/mYWdZbws6rz+5MnkCW68xO3aHSQMW8kfF/hVAz8E0dgUsFgucdiWIZ
	Gf2CG7xTQo9uQv8I7xKVHkbtI+cyTYoL4ib5fW09Fqpj2t3tz0ENnTIhaO9mzrfecW+ZjX41JAW
	6rbdrpBU0K4BACvHQty3FWzLbbE4WygG7Pf/nfAUL85lSMhB33XXNG/NQKcqDJjVm9jEOO3TWyT
	EOJ3k=
X-Google-Smtp-Source: AGHT+IHVZ5V7HiW9Rkw0s33+w+cQO1spnlPihGJa+P8ngoTWf74O/b6uIrMzfDZNNheYb8e6iNEHnA==
X-Received: by 2002:a05:6a00:230b:b0:781:1dc6:4e69 with SMTP id d2e1a72fcca58-78c98a89454mr2351558b3a.14.1759461807296;
        Thu, 02 Oct 2025 20:23:27 -0700 (PDT)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:326a:8939:a05c:b9d5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206e81fsm3460145b3a.70.2025.10.02.20.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 20:23:26 -0700 (PDT)
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
Subject: [PATCH v3] drm/vblank: downgrade vblank wait timeout from WARN to error
Date: Thu,  2 Oct 2025 20:23:03 -0700
Message-ID: <20251003032303.16518-1-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When wait_event_timeout() in drm_wait_one_vblank() times out, the
current WARN can cause unnecessary kernel panics in environments
with panic_on_warn set (e.g. CI, fuzzing). These timeouts can happen
under heavy scheduling pressure or in rare cases of delayed vblank
handling, and are not always a kernel bug.

Replace the WARN with drm_err() messages that report the timeout
without crashing the system. Developers can still enable drm.debug
to diagnose genuine problems.

Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
Tested-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
Signed-off-by: Chintan Patel <chintanlike@gmail.com>

v2:
 - Drop unnecessary in-code comment (suggested by Thomas Zimmermann)
 - Remove else branch, only log timeout case

v3:
 - Use drm_err() instead of drm_dbg_kms() (suggested by Ville Syrjälä)
 - Remove unnecessary curr = drm_vblank_count() (suggested by Thomas Zimmermann)
 - Fix commit message wording (“invalid userspace calls” → “delayed vblank handling”)
---
 drivers/gpu/drm/drm_vblank.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 46f59883183d..0664aea1b924 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1305,7 +1305,8 @@ void drm_wait_one_vblank(struct drm_device *dev, unsigned int pipe)
 				 last != drm_vblank_count(dev, pipe),
 				 msecs_to_jiffies(100));
 
-	drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
+	if (!ret)
+		drm_err(dev, "vblank wait timed out on crtc %i\n", pipe);
 
 	drm_vblank_put(dev, pipe);
 }
-- 
2.43.0


