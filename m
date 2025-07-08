Return-Path: <linux-kernel+bounces-721062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E930AAFC449
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F9A47A44F0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104D229A30F;
	Tue,  8 Jul 2025 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="CL55tIaj"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65CB299943
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960349; cv=none; b=XztezR3pzMyEeoo5VXYZ/gAeOgmWv3VbhnmxFglPKXc+1pm7zUcTiqm2/kqEaUciopAp8lIqGHKoLLLDCJfywrhwjTZq8jq2ldhFyK9oRr9i5v2PU9N2p5Cc0r8EAuRPHn6RBItL2gf8BOI8U4uwx77TIRYM9XgOKyKZ4sUq4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960349; c=relaxed/simple;
	bh=wypA2EBmpHp+y/b2ODxhiTcNbDIFZEPcjrmQqxW5FIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GD0rS/PD0w4Z1G579prTlQT7ELfhL98i5Pk3OzOWQrlpdPJvOB+tQ4NoxSQ+bWz8aPOD18dNGFrh+K4hgviMOYrNO6beY+Om8ttxrx1niDohbXWJXfEvmhLGhMZOXZIlVBkJMnTqQ8Hvfk/kHko5VDt8he4bp06taMkpufz86Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=CL55tIaj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b390d09e957so2351878a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 00:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1751960347; x=1752565147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN7aSjUU2m/lgLen2skU4S+C9lHA5hU+Z1BWGyIcRGk=;
        b=CL55tIajcxGi82FtpZGUu1hsD2cqwt6I9lYcPqxmJx5qm9tHAijELkYnA/8yhEpLjy
         G5mAovIu7QkKzXh/HaLLr6Zh2cL0ytnExTVtm7ng2NLC4nCJ8ZdYn05sFEFMwURKmLz0
         FXu2wUK1DW2oktKXdh3pxSTmbrqzoONkEk+xXEAXQaG/F0lJOyssz/LX326Q1OfXX+WD
         T0Fuc4LVk0rnR6+wIBHOxC7tub+14bawjVF6N6KeXkOFWpYKVgILj/cEGp+Cl24ic0uU
         Oy+4SNQHDkdkvq9GeE3cWcvLfGYHCTdmUBbQNIPofwL5EGOBuDP/jhi+yw51m77vqQPW
         HIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751960347; x=1752565147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZN7aSjUU2m/lgLen2skU4S+C9lHA5hU+Z1BWGyIcRGk=;
        b=vZgHSMfRVdkgEnNznDOZEDim6UiEv2K6b1Q9C4QaBmXfxs6rwiqDwGSrfUOvjpen7i
         Xl8kbEBn3mma+O1guGL0vkIgy1mmBD8e4h57fHGqZ90zV1Oei+lF81wna8Tn8Oq0D+hk
         li2R5SoeW8KDaH4De0LvZJvc6ZAVWeg9dB6NijdlTbRUhP3Ntxd2Zwin7uFBFyE6C7lq
         5dkCY6f6Q/BjoQiQQYmGfs2XXeMj+8/gJ4FsB33PA7h/FKQkzYfhEnUtsA9XGvjMSqh0
         ej6KrHFMG4Hjj9xPeDyq06rjYejivekfraGWQeGBKAyViF3U+wXnz51cIxRVx0AP9NoY
         ckHw==
X-Forwarded-Encrypted: i=1; AJvYcCVVHMDYH+WGedPe8BHYWoQHZOzwkZUrzTBYJdwqGFphBn1YXIZ4SpfMkbU6LZMtw+OUqR2iZr3spV3U5/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNO0rGlwyo2jjDj+fpksToYjVQG6oVaf8cplOCxfxbVBJrEVyF
	XSPDUux1XrgDnyGZe9oth2Dvwobulxml/YdeY+a/UMecIR/9QfFRDKvY8akdqWShQrE=
X-Gm-Gg: ASbGnctxBYMLA96CWJ3UPVO0hJyPoc16WATj5I9KnN52hqDNQ4/PFzwcWA6rhNW/43L
	U+9ulMJMfIqVEa5SJRtSMVXJ57IG/3RkMEBZ43UO5UpZClunQZpvWyl0tVqCh9xwH6GOJ9XmLYC
	S+co4iB9VNdJPKWQ+8OR2HvyL68RXpdFB68kcdlDqVl9QQOefTO+B8PzCTMvTING7jLqkNbxmSQ
	sfV6dm3n1lcPrce9uFQTEzHuNn5FsnnlgGGuiWYb8/Z8v6vKfnIgy7IXZ5NgTTbwbU1rgocjLMv
	95869Qgv6TleZwNfW/N3Q/Ju3PQxrZaVRenb/AMoZQ7qaMyiN05cOWgMycod8LDxzdIkew12vOx
	j4UN0rlkH46+534vfqA==
X-Google-Smtp-Source: AGHT+IGcYNPUjs2kwjkvmFdGShMU4syGWz/FE+DbOGjtHhPQiV8ZsbgVj6QjspJrmZqOo3MkvanzoA==
X-Received: by 2002:a05:6a20:e687:b0:21f:cdfa:120e with SMTP id adf61e73a8af0-2260c839353mr26223435637.30.1751960347004;
        Tue, 08 Jul 2025 00:39:07 -0700 (PDT)
Received: from mystery-machine.brighamcampbell.com ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a540bsm11633523b3a.140.2025.07.08.00.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 00:39:06 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: dianders@chromium.org,
	tejasvipin76@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v2 0/3] drm: docs: Remove deprecated MIPI DSI macro
Date: Tue,  8 Jul 2025 01:38:57 -0600
Message-ID: <20250708073901.90027-1-me@brighamcampbell.com>
X-Mailer: git-send-email 2.49.0
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

The first patch of the series removes the last remaining references to
mipi_dsi_generic_write_seq() in the jdi-lpm102a188a driver and updates
the driver to use the undeprecated _multi variants of MIPI functions.
Any behavioral modification to the jdi lpm102a188a panel driver by this
series is unintentional.

changes to v2:
 - Remove all usages of deprecated MIPI functions from jdi-lpm102a188a
   driver instead of just mipi_dsi_generic_write_seq().
 - Update TODO item in drm documentation instead of removing it
   entirely.

Brigham Campbell (3):
  drm/panel: jdi-lpm102a188a: Update deprecated MIPI function calls
  Remove unused MIPI write seq and chatty functions
  drm: docs: Update task from drm TODO list

 Documentation/gpu/todo.rst                    |  26 +--
 drivers/gpu/drm/drm_mipi_dsi.c                |  34 +---
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 150 +++++++-----------
 include/drm/drm_mipi_dsi.h                    |  23 ---
 4 files changed, 71 insertions(+), 162 deletions(-)


Link: https://lore.kernel.org/lkml/20250707075659.75810-1-me@brighamcampbell.com/
base-commit: e33f256dbc293a1a3a31f18d56f659e7a27a491a
-- 
2.49.0


