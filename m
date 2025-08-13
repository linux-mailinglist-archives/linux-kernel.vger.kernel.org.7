Return-Path: <linux-kernel+bounces-766744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF76AB24A90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992A7722ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9D42E972C;
	Wed, 13 Aug 2025 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDvpPEiH"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4B2C0F71
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091758; cv=none; b=DmBG3+PkepZwyEwxNryBqroHwW7FNv9dy8o27uzx9i8tySchCiMdHqa0CCfN334pvE7xB0dgrpt2GMVJbGM/rIAZlYp2d+CYvN2ZsRSzcNWcQ3HqTnoQMqF8yT61/JCHvftY26dnaF00qQuycliIZqS8esaKExYmgjqznPeIOUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091758; c=relaxed/simple;
	bh=fpX07AKXoevZHluQU2yuXbrZtTytOS3dvnNKN0QKdzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HglrwW1EEBreFBTl0BRKcvWmgUsVgSYpogLrSdjRJM2WIv0PzoSsDvHzRbS8RYx02o7iFYkMbZX+njDKR8ORBDGtAFQMolkO2UxXq4ezYo/MUU2uaOA3OmmVxH6ZbHSqEEKgadsZbLit06OAzDyN62bXj5ZvG+zI6HLqmQs7XA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDvpPEiH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso6932393a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755091754; x=1755696554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MOAo8EwGGhxCp+3TT0ofu53bm0FTlq8gbWgzZZLtVDg=;
        b=DDvpPEiH1HgDLfV2iLfHQ5+Q131aZ7X3pxfDGeLwaqTVW1OkGhG71NKe86tSfcOnLf
         p2mpWEkkrz4D/P0tak9AwMkIS4PE7I9g42WarsO+iRe8n8F/BQAAlv6QID8knS06IcaF
         oWAqcwZNR+G7oua/iYwbflJ6Uca0/fgYaCJLSNymbjiK8uYPLZaVRbX/RIvj1JCIr9Z8
         iedBvuccShAAz2Jy5foYNRVJTSJsLjAsi0ldL3V6Q29lNq8lnJ/ZcKLpG4dJnmFjNxOj
         48JuMuaI2WMWuF8KL/jI6WG2YD6KEeqdHse0bRTjUAispE8GYSUzUqq4O5SDoZcAbXVx
         bdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755091754; x=1755696554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOAo8EwGGhxCp+3TT0ofu53bm0FTlq8gbWgzZZLtVDg=;
        b=lRneNmPK+7QSBE3T+4F0d+7jweTOO6/S5T6Cj8fVtopk4lS4aRuGKxNzbrG0Js3Kae
         QZBReTNZX5M3KTEtC8dWUo38GI33XKfI7w+tCK3BLEZMhIqrd5A3KnN2oeB3Sy+YSHw5
         jm6pv43WpfuJ04D8JauHYE4IpZe71mtGTQ+ePgb/mbiECfsfneM7fJPRhRQAJG+MYqEb
         Vcird3jFf/kEDZQlgfb6+bM1L8Edt7BWn93j6uWmVnA52zPlNUtSMJxZhqIVFO56sAa9
         2jeJ5u1LjOPm7KDkPFuV2LxXHlvZp/cOtzwTGXpzPsVlF9YMw7lGxw3Z1cO8lHNdxa4s
         Fvcg==
X-Forwarded-Encrypted: i=1; AJvYcCUaHmaGPmGU0HmdtxUMr9yC4y3AwoyGu2D3weKIphSYL/1sxzH4rnXSXLjBlkQtZnFy2nEDQ9kczfy/bEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFsS8Wfq57v33xYtEFUytpE+aSRbv17usOKwoW0ENSWpsUU2pL
	UvEy14IMmsgiRc8vtXkYlmZy5CcrVmOWYhvze7yYMkiqnfO/WBVA384ehUMrJMi8VQ0=
X-Gm-Gg: ASbGnctQ0YWu9Xg58MizE3GdoNzkMZceTuo686QvPfkKvq5iQBf/f4t3lqrwVvWk0Ei
	AzzyPHjk8pLXLjNTLIzqGwCsEjEYLZmhlTNlWv9R+8KMAskl0ourOPIGI9E+IAFAq3/OU4F+94W
	3z5CHbMSdXnZZ9WmEHskKPnByf2l4dS5eAtZoGTYtnhg1QE/YecHf5G2gQLwq13TYaMjy/BgV+t
	Pyq8O2Kxi0QZRateAMnGp/dj/Ol6iK0EU1BlHYEDUDe2PEvGkDVGCpzcA93sTIDzrHR5Wx6Ly3r
	/V6x+KzUEpnuE+zS2FujK+Phi1su4zF/q/Dk6v4Zq+DcY1zUYpI3MNKz4lov5oFHRcqoPWXIO/e
	M6UEKIEIwmGo4/cXzt42gc3wrqVzIWzo4p2UTKbNXoMgXeCES
X-Google-Smtp-Source: AGHT+IGvJu2is807ZROPWMJAIvi4HljR+5vdCuYlSyAioa2q1juIjzC61Y4AXfJ1YhjEMjHGEyK6Qw==
X-Received: by 2002:a17:903:1a0b:b0:240:671c:6341 with SMTP id d9443c01a7336-2430d1a0ed4mr46283215ad.26.1755091753689;
        Wed, 13 Aug 2025 06:29:13 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:8898:77ef:a09b:a8f4:7c6e:b37d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242ff10e4ffsm45530725ad.38.2025.08.13.06.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:29:13 -0700 (PDT)
From: darshanrathod475@gmail.com
To: lyude@redhat.com,
	dakr@kernel.org
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH] drm/nouveau/acr: remove assignments from conditional statements
Date: Wed, 13 Aug 2025 18:59:05 +0530
Message-Id: <20250813132905.653228-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Darshan Rathod <darshanrathod475@gmail.com>

Replace assignments inside if statements with separate assignment and
conditional check. Assigning variables in conditionals can obscure the
code flow and reduce readability.

This change improves clarity and follows common kernel coding style
practice. There is no change to functionality.

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
index bd104a030243..f9ac300803e5 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
@@ -71,7 +71,8 @@ nvkm_acr_lsfw_add(const struct nvkm_acr_lsf_func *func, struct nvkm_acr *acr,
 	}
 
 	if (!lsfw) {
-		if (!(lsfw = kzalloc(sizeof(*lsfw), GFP_KERNEL)))
+		lsfw = kzalloc(sizeof(*lsfw), GFP_KERNEL);
+		if (!lsfw)
 			return ERR_PTR(-ENOMEM);
 
 		lsfw->id = id;
@@ -95,7 +96,8 @@ nvkm_acr_lsfw_load_sig_image_desc_(struct nvkm_subdev *subdev,
 	struct nvkm_acr_lsfw *lsfw;
 	int ret;
 
-	if (IS_ERR((lsfw = nvkm_acr_lsfw_add(func, acr, falcon, id))))
+	lsfw = nvkm_acr_lsfw_add(func, acr, falcon, id);
+	if (IS_ERR(lsfw))
 		return lsfw;
 
 	ret = nvkm_firmware_load_name(subdev, path, "sig", ver, &lsfw->sig);
@@ -260,7 +262,8 @@ nvkm_acr_lsfw_load_bl_inst_data_sig(struct nvkm_subdev *subdev,
 	u32 *bldata;
 	int ret;
 
-	if (IS_ERR((lsfw = nvkm_acr_lsfw_add(func, acr, falcon, id))))
+	lsfw = nvkm_acr_lsfw_add(func, acr, falcon, id);
+	if (IS_ERR(lsfw))
 		return PTR_ERR(lsfw);
 
 	ret = nvkm_firmware_load_name(subdev, path, "bl", ver, &bl);
@@ -296,7 +299,8 @@ nvkm_acr_lsfw_load_bl_inst_data_sig(struct nvkm_subdev *subdev,
 			 lsfw->app_resident_data_size;
 
 	lsfw->img.size = lsfw->bootloader_size + lsfw->app_size;
-	if (!(lsfw->img.data = kzalloc(lsfw->img.size, GFP_KERNEL))) {
+	lsfw->img.data = kzalloc(lsfw->img.size, GFP_KERNEL);
+	if (!lsfw->img.data) {
 		ret = -ENOMEM;
 		goto done;
 	}
@@ -345,7 +349,8 @@ nvkm_acr_lsfw_load_bl_sig_net(struct nvkm_subdev *subdev,
 	u32 *bldata;
 	int ret;
 
-	if (IS_ERR((lsfw = nvkm_acr_lsfw_add(func, acr, falcon, id))))
+	lsfw = nvkm_acr_lsfw_add(func, acr, falcon, id);
+	if (IS_ERR(lsfw))
 		return PTR_ERR(lsfw);
 
 	ret = nvkm_firmware_load_name(subdev, path, "bl", ver, &bl);
@@ -373,7 +378,8 @@ nvkm_acr_lsfw_load_bl_sig_net(struct nvkm_subdev *subdev,
 	lsfw->app_size = lsfw->app_resident_code_size + lsfw->app_resident_data_size;
 
 	lsfw->img.size = lsfw->bootloader_size + lsfw->app_size;
-	if (!(lsfw->img.data = kzalloc(lsfw->img.size, GFP_KERNEL))) {
+	lsfw->img.data = kzalloc(lsfw->img.size, GFP_KERNEL);
+	if (!lsfw->img.data) {
 		ret = -ENOMEM;
 		goto done;
 	}
-- 
2.25.1


