Return-Path: <linux-kernel+bounces-740075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C0B0CF64
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3A13BD79D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5031C07C3;
	Tue, 22 Jul 2025 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="afOOiuKD"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943DB72608
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753149202; cv=none; b=Nd/1XNJvLB1h3kFkY9BkLGWL8DaPaDAzTi94U/C1///QsNASmF0Zlv7wTLyM85ig+G2yGa6zLs/uHkD5Rn6ic0tZcD5R2Rs79vvbSBiKUyJoLsIIRUZBzZdZp4v1i9aXC09F0Fc0A6rVhslshYsbeBWle32xSCwWdl/5+Frwb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753149202; c=relaxed/simple;
	bh=PIlerTwii7wKspt/l05RAiot54ciwnajfn64bgA8Nkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hs2k9mueUX7/njHpQemkF36hqdCGGd1Y9+0Ve9vhiLEbEp9bpTqBfycm/0JpjIw+JaKn6iJ67rCEJespYHPlOLRBFoeMP1ChskF95T3IL3Fb/0AfQU4Ovd9c8he0pX9t/CBv5aVR9IMuLd952xsJq0lgffte+k6NHOboVBapqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=afOOiuKD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7494999de5cso3370871b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753149199; x=1753753999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02hyzrs3C6jwWph1NhtzQUl897VWViCvH01In3YsMDc=;
        b=afOOiuKDXTSM++Kl17PMq06d9UygNhdITO2xU8b3Hg63eo18r2unWP7ypkJRxEro+A
         H2WoEGx9ATfrC0BG1kouraZy2bVp7WIOYtKwBSea1KGHHxguzZHzKYz6aZi8IsUbV+tL
         WRbWUOzvVXoadAXq+YQPc/yj7vKPc3mhYOVe4mFZwuZfvRpgCo5epg+DL0OqvY95hF/w
         Lq5QSb8Kh4TMiKPKOD0IYIJZ1RqYDUdAH4QTHOtWtKqisLVqhrbrGWv/A9DPlFyg7Q9i
         q2FOnnuVg/LMeWpJAKTYTjDZjE0nR/tX9wXCwANOKS4TweAnTPkBPgLsdf7+VZt9ifcr
         LyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753149199; x=1753753999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02hyzrs3C6jwWph1NhtzQUl897VWViCvH01In3YsMDc=;
        b=UrcJ6pD4uG/kPftQJxb16zmmg5TOpbfnKW60o+4036kglhqPpRkMzJdn24PCFEkVqC
         uUW3wYwF9LRyVEmJEDPYXzCK0tfdZhTSn6TYKniZhCfzKVPoRw/xFwnIB/JAo52X8SMn
         /KsmScR0vfsYbOQNA/7kasnFgIMryx5Ann5kRja1P7LFFXgsAkjcS8GJfEVJXgkTi6m9
         Cap+Ei2uC50nfHz7GsVKaFRhzV+gMjQA4PYmzCJMVaGzHAy5yJi5hqcOIpVOYorf+YO6
         ZaUBGfq0909d/8CfveITn+j8suzWCb1xJFxVR2cDDDv1OI/ABdNKw0kK9XhCJXnjhCTe
         vkXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJMsWCTxwvPxm7peBPZE59+FgFQIkjl3MUFyz5RDnjCqwA5ruYmbUuk15jVyfOmuXZFigBewOWxXh/9O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRlp6jOCQARxIpjMuA22wVkxpNrVPs7vqhpQCGLVvoiTlk91ch
	0X1WF7Nb3ispzscRoDP7B1bNPQCYfofbmt0kCu7AAvbqecyb2Joxu57plvrGHNxoigE=
X-Gm-Gg: ASbGncsLRj260R6KBMAGWINaTnZIJa5aylHwb2gmhjLAvVHXoXGSvKUbqNuFGPPgS+8
	OUbInPsuxk3r4UK3rEzPndm82U8rRbVglBQ5MNeBoWnL+nLWW4RNeq2L765tfbUI/g5cyhwJyOz
	GuyVAkAO9cdusfpYtYrd/nimvrpmr/p2KrZBTBfGDQkZOSdEc015j2Q7GPZHyoEbTzOVCUswxgM
	UUPhoxfLzdn/VNyshpztcHecqwWfr367BMVjufBIgmc9toxDN5UK60WPtS7CKvmqE5IeeUjt4Iv
	Np+O8jzNvHXnmOEnZA4Jmajk5X1x1+//C1B+SyxP/Hbst6PuZTArdb1BH17r8acaWQhQWl8iWFk
	f0WF2mgdqA1G4EB1KWTDHQeXm+u2jTYtz3Ji+AYJBoRhgFatE5w==
X-Google-Smtp-Source: AGHT+IG+irLWOD78xwoAvbuOvZHdyLGDUiKL9Lg3uosSOKZjL28JHUt4/xMQ/877nSZppjATq3CYSA==
X-Received: by 2002:a17:902:f78a:b0:234:c549:da13 with SMTP id d9443c01a7336-23e24edaf41mr361519995ad.17.1753149198840;
        Mon, 21 Jul 2025 18:53:18 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe62d9fsm6017441a12.1.2025.07.21.18.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 18:53:18 -0700 (PDT)
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
Subject: [PATCH v6 0/4] drm: Fix bug in panel driver, update MIPI support macros
Date: Mon, 21 Jul 2025 19:53:07 -0600
Message-ID: <20250722015313.561966-1-me@brighamcampbell.com>
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
code using the new mipi_dsi_dual* macros introduced in the first patch.

changes to v6:
 - Fix various style and kerneldoc issues in patch 1/4
 - Fix typo mpi_dsi_dual... -> mipi_dsi_dual...
 - Fix incorrectly named "data" and "len" variables
 - Make _seq argument of mipi_dsi_dual_dcs_write_seq_multi macro
   variadic
 - Remove duplicate definition of mipi_dsi_dual_dcs_write_seq_multi
   macro from novatek display driver

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
 drivers/gpu/drm/drm_mipi_dsi.c                |  82 +-
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 196 ++---
 drivers/gpu/drm/panel/panel-novatek-nt36523.c | 804 +++++++++---------
 include/drm/drm_mipi_dsi.h                    | 118 ++-
 5 files changed, 614 insertions(+), 608 deletions(-)


base-commit: ca2a6abdaee43808034cdb218428d2ed85fd3db8
-- 
2.50.1


