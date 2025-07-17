Return-Path: <linux-kernel+bounces-735646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08967B0920D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C3E1684FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BB62FC3D9;
	Thu, 17 Jul 2025 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="by+4YpwQ"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA68A2877D0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770499; cv=none; b=TOm+2yxuofiharW05uJj2RU/ixQf8XVRX61dhrKKWkiSvg4Dvj9w3LBsRB7BvN/Sjdjb8GyeUaAfA+QGbE3puXRk1zj0sVgHCBZ0X3MHiTDtJJtO3BerDDK7qpTLRFxDj9s7xmCXHQFIwwhkzYl3QmI8PkxiYQD1s3nYrTM8K/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770499; c=relaxed/simple;
	bh=pPXx5Kxdptb3GobS6onHLMsPrJKy1RvezPijhN9+wfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRqr5kA5ccPlg8M1oF7WHCaX6ZGLBooq4M++V/tBU+udX+nc/ijT62O3zNibCey9VrWDC743EO6UkC0Hyr/gHHikjDaNPH99KXlTHcPxrdj7cL3wqpgF/uxOMDIDo3OCQdKuJI8VYwp8WUq3wl3LmJOB20RykgkFUBPq2gDu28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=by+4YpwQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3121aed2435so1196841a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752770497; x=1753375297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zaVonVNWKr3b0dyGZR9LCJexaagL6PKA2t2eXcHfTo=;
        b=by+4YpwQoFG055y/j2Dc5ZCis2H6ppXAgr/XWtHMb5bmKNcDcEALmijXVsQ5oLI+pd
         lFwHMbGqZ8UX17q+AhIdSbZNjXn7BB2cX7lbYEa/KPTwgOuj9Y8URaF5Vvr0xgjKDLBK
         wxG8Dr0ChEC1UHMr+fg2KC0fkl+lAUQlhFqNcugx6Nh0EyaDb/xm5bvaKjTB5sa0a+F+
         UoPwT7h9BQ5J/h85zXtjr69+VL65gn6k+nsu6aUqny5age9koW71NyRm5/Cs5e/vlo4d
         y3kNnukkAil9fPhm+lJ/HywR0nVuPZ18/0L/aeUsvFNsO/py2ajvbm9CsOQPhw0rvZ43
         +a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770497; x=1753375297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zaVonVNWKr3b0dyGZR9LCJexaagL6PKA2t2eXcHfTo=;
        b=HW/oATFfM83BPrZMMnLL1KeaZQZ4vwMdOb1P8kfRvQubeMFkBjayK72m9kgN5SgSIY
         2xI2qTHz3aiuLY0FDEBvVSpkImtKoJFHe4jUW0n9UQuhQ3S1+nSf+ouPiFvDXgHIRXGh
         vrlp7t5gbfARGroTcZnvgQfilHF5tZwTuM0Y6AS9fBjReXxHAwO2PBn2esmJYOB+w4cR
         1UYiSUW4ENgQAbOUX5+vBp0aEoI8Ov2zV4YUyV+5FUUwBm960/zS6woNADVMm+dSbQZz
         /ZH5Mj8b3NHBHQX6bthJDvumNMWL0cmwcQCuqd5NKl7Q1XPax9nimW9vozbUXUVvvCHA
         MLWg==
X-Forwarded-Encrypted: i=1; AJvYcCUGSj/JmsP0IgIkEtui6bY9QRafhU8/rMW08YogO+sDhufzbuQ3Pn2HvfsbTvvG087zs1SNuMezwjkq5P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKr+fHFvz971O8z0R6+iM+ZSpV9EhddA9CUA1YKpakgtUjVD3c
	UyX8vFYWvJWoZ7cbUvMg96PXHnfGR3ClJSOJYB6HiztYGg7sVFIptEBdpuidHVV5WTc=
X-Gm-Gg: ASbGncuUScjP9s9kDRx+SyURhV6n1jw6efyajXRFYHVg+gM9yqJIkashdraeC87197Y
	qbgW52zu0pt5/HZzBSsvu1EEFs6d2MFf0+3pw+RB+9q1vm/iLRfXFY8qF4u7gIDJ/qtWgaPXFc4
	vdc7zBr+z6BkWX/WopTuniXW1yEThiAWXv4fttQP0bC4xJZKsi0EbLW+QIi47B8GUwgZtyGD93O
	+BBvGufQiEzwNstnEWVSeoWWu/T0ub/zO3SsJKaEykjCXytn9SVPqN9vAGcPxqA9igWoEUGsLsp
	xRsg/eIWLOI+148JGrR0a8rzw7jO6I1jUWtg3HLpAwE6muQZ5swVCnomyJIa/GmPPAxWeHDr48f
	kUcJb3UpWjjzK1aADDiL8LWAAoNju6iFhTOsgA2H5VIqCoBtfHA==
X-Google-Smtp-Source: AGHT+IHnWxMFl+xdFfhd6iN1u48GSI5UYMmS7BfoELEh5F4oPsMjJBqSiWUBF1GSB6ivy5k7UULcDQ==
X-Received: by 2002:a17:90b:390f:b0:313:1e60:584d with SMTP id 98e67ed59e1d1-31caf844db3mr5977675a91.11.1752770497172;
        Thu, 17 Jul 2025 09:41:37 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf7e8ae4sm1821750a91.24.2025.07.17.09.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:41:36 -0700 (PDT)
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
Subject: [PATCH v3 0/4] drm: Fix bug in panel driver, update MIPI support macros
Date: Thu, 17 Jul 2025 10:40:48 -0600
Message-ID: <20250717164053.284969-1-me@brighamcampbell.com>
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
  drm: Create mipi_dsi_dual macro
  drm/panel: jdi-lpm102a188a: Fix bug and clean up driver
  drm: Remove unused MIPI write seq and chatty functions
  drm: docs: Update task from drm TODO list

 Documentation/gpu/todo.rst                    |  22 +-
 drivers/gpu/drm/drm_mipi_dsi.c                |  34 +--
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 197 ++++++------------
 include/drm/drm_mipi_dsi.h                    |  47 +++--
 4 files changed, 98 insertions(+), 202 deletions(-)

v3: https://lore.kernel.org/all/20250717065757.246122-1-me@brighamcampbell.com/
v2: https://lore.kernel.org/all/20250708073901.90027-1-me@brighamcampbell.com/
v1: https://lore.kernel.org/all/20250707075659.75810-1-me@brighamcampbell.com/

base-commit: 667efb341917bde19f5d7517b65defcdaed67c9e
-- 
2.50.1


