Return-Path: <linux-kernel+bounces-839763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB925BB25B1
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA37325ADF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 02:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11DF231C91;
	Thu,  2 Oct 2025 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCUqfbVf"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6C1F936
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759371786; cv=none; b=WlJS9Ls9g0QJX7NuYzxTk37aVI84uX5Ld+Su2orRk9b5AvNHc93joYHui3CGr2fCY98Jk09+umwAYxIVrPIT2oa3gql7C3X9BBdQI/eScyhjl4kXPsQpOc2BhYvqAtqEAjNAXtZpq+LIt4Q5kZ6+wCVFmnn3Kt8apxOOiYie7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759371786; c=relaxed/simple;
	bh=noOVzFBtrlmWjjXtT8Z8WawlBMEgNebeu2HlTJ7LS1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D2R68IzubsfhQC2OYGrq/3FPvPcu+Sq8ZqLnxCvtyScagWK1z/7BzR/YYxoXKVB8JTlvDOqlOxv4iIspSAxYSa6brT3+aTJV9tNlJdekyfjkCkn63IGsrPOjLa5yqwJwN9WliRsyLllk22zLU+5vsIan4SQy8x7sp09V1QXcN68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCUqfbVf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78127433a32so468226b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759371783; x=1759976583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mF3LfHpef/3mN9CeEleeS0pHSg8cp/5+RdXD9b+jUXQ=;
        b=BCUqfbVfhfpyLzF+2ZtQbeRgjXBe6JpN41s8rLVK9uxPN/9LzrGfQBGQCBURuNcjXC
         tbnVqAteINRJ3EwzQuYVtLGvYILgF58LCabneRao0Rnp8zWMwmxd2R0OFeA/nMRkSwNx
         VfQegP9jpYZfcULjXmJ88nY8eppQEbik83dkm/5i5qlSd6SExsmc6x0RTDgUZivS1rsy
         T14AQYGYzIVahidJPC2J4hrd35VX1MBRNaTbinUHKEJ4lHDpvYNB78wCIK5lDxDmqYNr
         Ap5skn+HqOhCkGUEg/UiWZ8A8BBhKb/rT0lAeumYMtOf29Nve9lqqE6ERkeUygw9eD8W
         hUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759371783; x=1759976583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mF3LfHpef/3mN9CeEleeS0pHSg8cp/5+RdXD9b+jUXQ=;
        b=Muek+pqBILP3b2VdBxawZFbrIp1E2S+mmH0EFATJGcyAoYzwcVqWgfngZeCLGk7/GF
         ebu740fg3oq1ER/5myeJK5LdbFFaNQWlwoMSIHK+OC5JjVvoRoAHeMMWSY6GmujyQtgZ
         NFHQ4oI7iNeizeCRl5EtCcdkbl2rAiDMZJRRnaH5EJDhwCAwxB/rIHYF7StoxmfWk+DS
         zipcBtXD4wPm6eX0H4XxgeD2gW9u3KUr/VZtoualXm2bA+nLEBaQisq96EnkYu4lZhAk
         8IsALuueppSlDVsZpCP88PT8ssrUTIDK7cytMComlP940H5U2mbQzgeYfdAMrkJDPURW
         n1dg==
X-Forwarded-Encrypted: i=1; AJvYcCVzcjKtmv8VJx0hSxKoQ3O4Q3Zc+ltBc8sqvixWQXxkPDkTf3UrycPhPWRJmSszkC0jXc2kyCMtSmg2qnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxuxahg+MJl6cnW4Z6eUiaZvbIfGFIcTkqIBxmB5EX7oeohvk
	1sLba9vX8XSGDDB6otz4yC2okSNq+xTkCKIRbNnhmMuwkrNmaOE0gy+k
X-Gm-Gg: ASbGncuWKTfkNz6/dPFJtH+pyhjyz7jypxpaPPa0eoxtb9YpnNOFj0HKPABAlAkA8sF
	Gp+8TKSZxAeZPqdtCCVoIl6iqqTpmxrA2xXtckDGSs9pbargdT++9fWEuFwV1S579w1Y73rtHV8
	pjRoIjKUhEE0ktdks1/O33zP1tz8w/iz9kiuNfMuDGL6IL+JMvFaj8JIQb9Xc/05jERPf8wV1Kh
	qbJ1BL8DDZw6fE3kuO19NLcXzhmz/T8lmfQIfrrTEWvgYBjVqjX/NG1KXMXH5NKie9Yu2zLG5hd
	i1A/nv0pxsdwEpjg3fbS/cSSvDgR+ujlXDmKD2sxOzk0N4Mc/SMLYQpKQS9FQ3YYtfFlrtYbxWt
	ZwBckV1fGdIglq7cBRh9jykmHEy43zNGb01vjdIT9C9HvgFTsHwXw52Z9Xojico5/bbxEGuaVnB
	706bIzX66oTg==
X-Google-Smtp-Source: AGHT+IHxLShFCm76xin7rHm8qNL6ADQW6sxwH14YEVEejbEnDXp8CfZFyeDbyzek8/KKOZq8n0qs+g==
X-Received: by 2002:a05:6a00:17a6:b0:781:556:f33 with SMTP id d2e1a72fcca58-78af3fe8bcbmr6233829b3a.5.1759371782828;
        Wed, 01 Oct 2025 19:23:02 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.91.136])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f99acesm1046229b3a.5.2025.10.01.19.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:23:02 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	ganglxie <ganglxie@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Candice Li <candice.li@amd.com>,
	Victor Skvortsov <victor.skvortsov@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alvin Lee <Alvin.Lee2@amd.com>,
	Karthi Kandasamy <karthi.kandasamy@amd.com>,
	David Rosca <david.rosca@amd.com>,
	=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	bhanuseshukumar@gmail.com
Subject: [PATCH] drm: amd:  Use kmalloc_array to prevent overflow of dynamic size calculation
Date: Thu,  2 Oct 2025 07:52:41 +0530
Message-Id: <20251002022241.77823-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kmalloc_array to avoid potential overflow during dynamic size calculation
inside kmalloc.

Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note:
 Patch is verified for compilation.
 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                 | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 540817e296da..642addf70466 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2566,7 +2566,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 		goto out;
 	}
 
-	*bps = kmalloc(sizeof(struct ras_badpage) * data->count, GFP_KERNEL);
+	*bps = kmalloc_array(sizeof(struct ras_badpage), data->count, GFP_KERNEL);
 	if (!*bps) {
 		ret = -ENOMEM;
 		goto out;
@@ -2722,7 +2722,7 @@ static int amdgpu_ras_realloc_eh_data_space(struct amdgpu_device *adev,
 	unsigned int old_space = data->count + data->space_left;
 	unsigned int new_space = old_space + pages;
 	unsigned int align_space = ALIGN(new_space, 512);
-	void *bps = kmalloc(align_space * sizeof(*data->bps), GFP_KERNEL);
+	void *bps = kmalloc_array(align_space, sizeof(*data->bps), GFP_KERNEL);
 
 	if (!bps) {
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 3d2f8eedeef2..e027798ece03 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -146,7 +146,7 @@ static void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size, uint64
 
 	if (*cap - *size < 1) {
 		uint64_t new_cap = *cap * 2;
-		uint64_t *new_mods = kmalloc(new_cap * sizeof(uint64_t), GFP_KERNEL);
+		uint64_t *new_mods = kmalloc_array(new_cap, sizeof(uint64_t), GFP_KERNEL);
 
 		if (!new_mods) {
 			kfree(*mods);
@@ -732,7 +732,7 @@ static int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsig
 	if (adev->family < AMDGPU_FAMILY_AI)
 		return 0;
 
-	*mods = kmalloc(capacity * sizeof(uint64_t), GFP_KERNEL);
+	*mods = kmalloc_array(capacity, sizeof(uint64_t), GFP_KERNEL);
 
 	if (plane_type == DRM_PLANE_TYPE_CURSOR) {
 		amdgpu_dm_plane_add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
-- 
2.34.1


