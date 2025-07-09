Return-Path: <linux-kernel+bounces-722908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F56AFE08C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAEE3AE8CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB75E1C84D5;
	Wed,  9 Jul 2025 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTWTJNvQ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D109C42AA5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043911; cv=none; b=AWXscsKfydQV5ZnffRUz4e+XDH9eGS4VILykjJ4KFDeSnLoAA03VZJFBenS1SV9qxRx8gZuiIXHtIWplUxQdgdPmnd+KrqbyoR+OCkvFVQbzBqkXlcN4GO6SrIgC7WMcgYf/WDaPwWpGPLEwMBSXZYo/wZaf0P8atUAkqz8PINU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043911; c=relaxed/simple;
	bh=SbqDN93IT7j1xeSIcJ3yfzafblmB8ySoGDT1cwjSXdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3Ji2G53gadANvg4rpCY9PdS7TBWOe22n/Sf9ou6eJ9ZI1eHoSEKs3tN5kTYnHM8IbNtEQdlFLB7NZ2CCHpNYh7Ub/vRDHct1HY0S2pDe8x6Rmy6eZy63121xNtxKK+hJYjSQqwn3855kcQ01OgjuvwphHJug74dnK7C1kv9YmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTWTJNvQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so4573216b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 23:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752043909; x=1752648709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wsXmoNVf8gqhHwpX7v98CH6HHO1K78Rr2kE9W8JmaiQ=;
        b=VTWTJNvQwEsY4qXWUjn6yvEoS6g3nJkOJWfDhlmR2uY/hQ2AjEWRK0WPwX6GGA2JHG
         N/XysT74WkhbB958+BaGtJvNVmxbwRFhKfEHl+sBqC9nczTn5tUxyxTz2r5iLpjKXDSG
         T0NIXQgbj2C/EC7jYsiLr02VUQQH7Wk7buBOHQop+n41UgDvspItvTWbgX0dsYApqYRE
         yFKy/pysOEINVRVBcMWKiubN3H5UIbmL0EaMCh5ON8yu0seJk75KfDNjuUnN466cukEd
         FvEXunqwHB44ooG9qKhcIGrBRrwCFVgnqBEXrpt09bWKlIx4Vwlj3gHqH1LXHng11Jsg
         czWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752043909; x=1752648709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsXmoNVf8gqhHwpX7v98CH6HHO1K78Rr2kE9W8JmaiQ=;
        b=tvkCCvq1oRy1+27LBeX3odlqP6ZchRYF51BDeIzVDHR4hDnr/oErkwMnJgEjBFYPdA
         Q+u8vA1eD0wh8VoPdsmXaC7ELoORT+eatv2jhQxT4ba47tBOa+fnoJp7KCX8tI7zHw4F
         3ECsl48dKzozH8ChWF6siz1Vns45Jd1rSu+LG1U99tDvczqZ5ok4aYY6zIDnEX4hHClr
         qrePdjGoG1V0aldh4FRSLY89Ul+QERvwBoDJKesj49qBKi3JF9/UDVJnvLyvAwe6y9Vr
         X+vo3ghyA/uaKGfCFLJD5MdY1M2TnntOr47l7bYCJvmxrCuYQdVPyRduAJy1eMcc8R0o
         aZXA==
X-Forwarded-Encrypted: i=1; AJvYcCV0kVaHPwUxSVRsd0VXTKKQKx8xxdpVcvUfY+cMQEqf/jzseEOMohDOUR1PstcZtINwvzlG8fqI1x48qdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhBtJASGInBlJTbEMI9uNB63PspWs7dzgVnzISXX5gu5gCp64
	3x0egflI9SdoxMa9kDVfSgHVF2Xipm6JPCOwN49SfQeeKnAjwUBoay6P
X-Gm-Gg: ASbGnctC+62A2xxj7Gxsg4REC8ODYoiRXC3id39AhIm6mlqE58UTYjUfI632ezaErel
	egEoWZc5PCC7Z1pJqTJSqSLrDLrYHeTufeb2kBTKMurXuAmRcf7WMsQp4GCxkl7D+3WcrFskWEz
	vHDL9mbvGourTovxaGyIjGiDFnMpi8HlngBSoOkO9ELO+GZWJXtDXrN/o2wF8SX/3Eqnj80s/tf
	FkdIqYGiDbDQ7Jj77G+mkP/FaeLripRKX56UAGY190ef1pl6Tylavg17gLwitd58liSSKPxihD6
	RfFIUommYy0uXOhH1TFiE19hSlBvnwyIBLZmbn6qvWZGs4N5C0gXH8iDghEkgQbt6bQ0arj5
X-Google-Smtp-Source: AGHT+IHhwVqmIexE3eKGz91oczxiizHyu03L1oLCkTdwBUOHIgnDLMOxZ5EJMI1a3H3LD8QK/1k+bQ==
X-Received: by 2002:a05:6a20:6a24:b0:21c:e870:d77 with SMTP id adf61e73a8af0-22cd5ff1630mr2141698637.15.1752043908408;
        Tue, 08 Jul 2025 23:51:48 -0700 (PDT)
Received: from localhost.localdomain ([119.8.44.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee62dd6asm13324561a12.64.2025.07.08.23.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 23:51:48 -0700 (PDT)
From: Han Gao <rabenda.cn@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Han Gao <rabenda.cn@gmail.com>
Cc: Xinmudotmoe <xinmu@xinmu.moe>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amdkfd: enable kfd on LoongArch systems
Date: Wed,  9 Jul 2025 14:51:38 +0800
Message-ID: <ecedf70051b805c5cfdcc2b91f9304af24b3c3fd.1752043543.git.rabenda.cn@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KFD has been confirmed that can run on LoongArch systems.
It's necessary to support CONFIG_HSA_AMD on LoongArch.

Signed-off-by: Han Gao <rabenda.cn@gmail.com>
---

Changes in v2:
  Add 64BIT

v1: https://lore.kernel.org/amd-gfx/56e7ec54-9820-4e02-be97-2a9e1dedd117@amd.com/T/#t

 drivers/gpu/drm/amd/amdkfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index 62e88e5362e9..16e12c9913f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -5,7 +5,7 @@
 
 config HSA_AMD
 	bool "HSA kernel driver for AMD GPU devices"
-	depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64 || (RISCV && 64BIT))
+	depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64 || (RISCV && 64BIT) || (LOONGARCH && 64BIT))
 	select HMM_MIRROR
 	select MMU_NOTIFIER
 	select DRM_AMDGPU_USERPTR
-- 
2.47.2


