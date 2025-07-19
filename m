Return-Path: <linux-kernel+bounces-737631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11301B0AEA4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3763F3B3C0E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44733236429;
	Sat, 19 Jul 2025 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="DKhGQBj7"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393823534D
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752913624; cv=none; b=VwJxnb5p5/2WreOcT/cBrYwsjWlroJTC81pAlWZmVsCDyK8YTcYMblJ4vXBsgVV6WuGMbSj4Lar2Mnbn7fgnXX0zyNDhm8jym3wGdL8ppbx+afFrki9+o+4PKvXgvo8hNI9YhrAU/JTxSVW271jHxNX8HrCyaQHH7IoE421WQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752913624; c=relaxed/simple;
	bh=P22GETLL8XCTAG82w5KLzdw5PA4pQl85CxmaEqGA3PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWjF/Yj7Pw6syG9F4NqE6ESC0P6FFyA+WfyDjYMAIZ3tJsjVGINusnQeWfUiyFh3aUFPpBF3wjO7vxn2qM/TAsLpPcV4i5SBNBc+N+IZMuhYQDtVWKnx7eiz5OZUmx1Ie7RbjhEJ+rlfIq9YQLbsAs8zjKHs0YC59lKAbr1A7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=DKhGQBj7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74b52bf417cso1967713b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 01:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752913622; x=1753518422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EPId7hlRtak29cJpHNdXMRMJJGzWtgzI1RuZFg9RVGU=;
        b=DKhGQBj75kL0R1fRR/ZxZOoXIWHAutNRIfNM0BwMDkuJMHJ+V5u7f6xOUnGD1ltdMr
         OSYvUOM14UptrgS3hzeqviZbCwlt/lLH2n8MRcwbFAiVJ5OtTOefhp6I0nJWdF1vGkAk
         V+opPAEZItYdf20IRt1f51h0RQVR5QQwyND3urfYeiimutHcE18NEVUhrx2DDiL9Af7Z
         K6rv0hDBXR4JvQudGv/54mnuiGbppuCXDyyb5aaSVpr3jVNviLBL+mCYnuosMUIIPbQl
         Prl6WjFEpwni1kWEGKxfwkb47rIGQZxACu6+jy6FaZ9eGkgcPGCMBibbnMsgTV1Pqh+7
         dppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752913622; x=1753518422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPId7hlRtak29cJpHNdXMRMJJGzWtgzI1RuZFg9RVGU=;
        b=B4L9YjM5nwfUxWqQQKzKXgo/dJmZPTaYlGy+A4TY8kbmnznQTk7+fbDkdCeRhGuZt3
         jxsJUT4XlCpafYIjPy1/sjCqVCqpy96YBYREzea3qU75kr4ESPwlDEEbsP51b3r6Q6I/
         G6+QGRUKo/sOgVExc0DW0pYu80lZFoQjLSRdhQrUC8pfBk8UmzrokLPYChk4Uz423fuJ
         lAaJ2h3A5TM01KH6ZnbOqSqXk9U4xuRcDWAETqaxEvr4+vfpaTn+7EQMJmbav9CUTxZb
         p+IuPvkl4aGcOl4UUzGHI+umdNifTkudYC8nrsSVTIMfTgc4BfahlCTiHAD1AvsSkTh+
         d1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUbq3Zc/+RA7q8+ublsGpu4YrH+lpmQ80N4H1yk2cHn23Lz6GvQv4kGfFSC7yaQ3mcZj/1Ia43PAsN2yRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTqQXGiyhW+XsVuDmzg5xcmRLO/91HXpSMREr/HR5cPYJ0Pe8E
	nDvpiqXFPHHNqDwQcaiSOLUv0npZScxirzTbrZpDVaSQVfiC64kgK9Bks01bF3f+gY8=
X-Gm-Gg: ASbGncuSg+TDHxwC3tPpARmvfbIa5RwvFP8cEYhsjxHJKB9tVqWMARa7UM8bxWA2yDc
	19K67dRuDji/XVNizVyyXRQIWLA2r+aKvY+SgLpZnnk5pPbhFLRDH0hPJdHbMhNlToru882GqU3
	58fC4LA1rkw9NaEIsL4AwogmpCL0MT6kpbmg1qVUzOo/zQuo1ZTgsunTGoIcQOVXCiHTIPdiaE/
	oMkwPa2TT11jzcV59ob/AFQhoDxPM+KeIITqxNcn1/DVLhRZI6VKSKwg9ytjza25K/2IJjR4YkM
	qb/RkAkW5KBuPw0+SaEKjEk03fenmXaReehgrfUn9tGmfsCqO+Ulsu+BFI/CHKPC+7OYCIvJxF5
	xKfdU8qsm4m04B3b6/oHVULVGX3XYqrIG7URH1QFzcdvH2xeWag==
X-Google-Smtp-Source: AGHT+IEzBjqgE2BlaLz1oOWFjBrHioQyEDfCtdHE+F0FDfd8OvpCDexvgvzMEwrHYyRAhMYVJmlFCA==
X-Received: by 2002:a05:6a00:3a11:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-75724180944mr17224932b3a.16.1752913621977;
        Sat, 19 Jul 2025 01:27:01 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb157635sm2475260b3a.83.2025.07.19.01.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 01:27:01 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: dianders@chromium.org,
	tejasvipin76@gmail.com,
	diogo.ivo@tecnico.ulisboa.pt,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v5 0/4] drm: Fix bug in panel driver, update MIPI support macros
Date: Sat, 19 Jul 2025 02:26:34 -0600
Message-ID: <20250719082639.307545-1-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes the unintuitive mipi_dsi_generic_write_seq() macro
and related mipi_dsi_generic_write_chatty() method from the drm
subsystem. This is in accordance with a TODO item from Douglas Anderson
in the drm subsystem documentation. Tejas Vipin (among others) has
largely spearheaded this effort up until now, converting MIPI panel
drivers one at a time.

The second patch of the series removes the last remaining references to
mipi_dsi_generic_write_seq() in the jdi-lpm102a188a driver and updates
the driver to use the undeprecated _multi variants of MIPI functions. It
fixes a bug in the driver's unprepare function and cleans up duplicated
code using the new mipi_dsi_dual macro introduced in the first patch.

changes to v5:
 - Rework mipi_dsi_dual to explicitly not support passing macros into
   _func and add "dual" variants of the generic and dcs write macros.
 - Make jdi-lpm102a188a use the new
   mipi_dsi_dual_generic_write_seq_multi macro.
 - Make local struct variable in jdi-lpm102a188a conform to reverse
   christmas tree order.

changes to v4:
 - Fix whitespace (I forgot to run checkpatch. Thanks for your patience
   as I familiarize myself with the kernel development process)
 - Initialize mipi_dsi_multi_context struct

changes to v3:
 - Define new mipi_dsi_dual macro in drm_mipi_dsi.h to reduce code
   duplication.
 - Fix bug in lpm102a188a panel driver's unprepare function which causes
   it to return a nonsensical value.
 - Make lpm102a188a panel driver's unprepare function send "display off"
   and "enter sleep mode" commands to both serial interfaces regardless
   of whether an error occurred when sending the last command.

changes to v2:
 - Remove all usages of deprecated MIPI functions from jdi-lpm102a188a
   driver instead of just mipi_dsi_generic_write_seq().
 - Update TODO item in drm documentation instead of removing it
   entirely.

Brigham Campbell (4):
  drm: Create mipi_dsi_dual* macros
  drm/panel: jdi-lpm102a188a: Fix bug and clean up driver
  drm: Remove unused MIPI write seq and chatty functions
  drm: docs: Update task from drm TODO list

 Documentation/gpu/todo.rst                    |  22 +-
 drivers/gpu/drm/drm_mipi_dsi.c                |  82 +++++---
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 196 ++++++------------
 include/drm/drm_mipi_dsi.h                    | 112 ++++++++--
 4 files changed, 210 insertions(+), 202 deletions(-)

v4: https://lore.kernel.org/all/20250717164053.284969-1-me@brighamcampbell.com/
v3: https://lore.kernel.org/all/20250717065757.246122-1-me@brighamcampbell.com/
v2: https://lore.kernel.org/all/20250708073901.90027-1-me@brighamcampbell.com/
v1: https://lore.kernel.org/all/20250707075659.75810-1-me@brighamcampbell.com/

base-commit: ca2a6abdaee43808034cdb218428d2ed85fd3db8

May you all have a wonderful weekend. I'll be riding my motorcycle up
Logan Canyon.
-- 
2.50.1


