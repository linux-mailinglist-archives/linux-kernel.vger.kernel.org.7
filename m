Return-Path: <linux-kernel+bounces-750224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E2DB158D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71B23BE332
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D0E1E1A05;
	Wed, 30 Jul 2025 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="cCr4f9OV"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C965CA4E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856277; cv=none; b=QPl3MkpmVSOZzRrvOmqezlv7XVWl2lvDIge+62V1fVJJ2vtar4AQIw1TDoAlCYZGj3CYWCwjVRL8DxBcMETZESUSotzae+hl+VY/s9tz8EwU8KFhmqQvqvS8cuwJ+65r0XJkirBcQ8kEU1z+w+8yzLk9z13tXKwwK3se62nimFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856277; c=relaxed/simple;
	bh=XryLpjGqYYDV+FEX/ps+tCDjjYLBaSr57eRaMtgBXsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+rFroAIImRnbpvYS74TDMhczSHOOyw+8RTFDhNx0m0C/lV4ZLrS+dL4UmaydrfwmTEm6IfcBrhga+zZ9aRouyMqKD7j1MoKuuYIrMVztuiisVtp42DGBu7HzWUjkpdX3N4KnpuxtHcdUBw6h5B16qzMJIvz0iUkBCjWdHvYjNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=cCr4f9OV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2406fe901c4so11009245ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753856274; x=1754461074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=52xEfYQKRs8hJ1j3pgv2iCPTOPncEtEYrZ8Fw+FLizE=;
        b=cCr4f9OVdxOp1o4q3YCbfT6J2GQbYZ9HIQOFPE8uEwA9CHcbrXh9+PWh7PLpeWvfIW
         7b8GMyz4w2XobhYEyi+qqbBroKQPjROvTB+YNX9VSRO0GKzwZqBLNJUIuXBgKfOEhDn+
         bZuazZGNqMWbV+Ry/rTAm/Zipr81gDE2LVwXKzVWJW0bhjwgOXkafXM12KtRrciV8HwN
         zFNG3ciZaZrysCNjzT+I5ioIvDTCh7B3HqQIGzDIP1mx4KcZD301lJRNTYdtd7AAo4A+
         CN7tw+r9C4Z8Riq+QVW0lhC5hMXNX0KEz44gEfI/YEpzzKSB/pmloni/I7YMVx2WdgSG
         D+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753856274; x=1754461074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52xEfYQKRs8hJ1j3pgv2iCPTOPncEtEYrZ8Fw+FLizE=;
        b=Y8enNgD7V8NQ9NfGO/taXAhllcq2BvIeMRSfJJGk3ZZrTJS5YIM/fF2SiWRGfOjofY
         cxGIkBEpymp4u1aNtsPDfDXLMT+ILUpQp1F2yi06nXsDdA0xU6pMqPHcEG1BUIbQNaBR
         ZrxJZazpU9lY9xqSFxBOCml2yQC0P3ePiC5s4YZ3AjS4F0/+jhqcMLnLnSWORnAv5F5k
         yYG9h5iaob0zl5ZLd7M6K03Hb96/xWctofhphaF99pA3Bx3L/Sb2QODDjSxp78g5fWzI
         Vk2tEe+NQfSSFjoeLgrIUkMioMaaadoOcGPqnP3rm75zGsa7B0kQr9rBhFZ05jYcLmF/
         NR0g==
X-Forwarded-Encrypted: i=1; AJvYcCVBFzgyIiB9+ryjv5JQwTjmxLeocQpc3AgTWv6JDz/1BPAqBcWIURBl70CRmwTh/F+Y2f55qGv4kDTIiWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWuTjYwBionBRRDCrqc9FaKX5VotDfso3hZeaqzCFdPzBjjYTz
	3sNGqP3/2sGUVoOzZAYin5OZ+ok9Ca0SdgcdWlg7K3WjO+pwI4s3/Cozz0h2yLCUxUA=
X-Gm-Gg: ASbGncv6SgKulYYCNj7ngKVZ8x/6yz94Hbu4l0nXpxLWDkVOqu7GscGcSVSQjUEdzt2
	vYZubjmdYh0O9x5vqFAKMP5oQQrNPMGsZO03AaYNhLqUVPR5gv756Ejyt89FSORIM0SPe2iNozk
	QddP3iWs9BLal5xl1pFUK0CKnrDTk6LCKzCN/bnaGOqdqYg+rleIaeQtKGsikZT1Etez3uuNQcM
	xOyFLVt+vNQRM5wRDe2keIrLX4sY/ShljzHIK769U/1tOGMziZpwdzxHIStQR+PizF0IorAJxYg
	2N5I/PwjIhgF7+PKRrKkV9bH0ESt5rAbWtCc+iNAX6IwtdHJgRg5xZdi69+zUdcidfvU7+cAsoD
	0eJfh0flNuXx3LPttOMwzuTWdK3//1AqsvZ+bcxMa8SyA7eR1uQ==
X-Google-Smtp-Source: AGHT+IHyEWFTQDnTXUtR2Jyv+AM6C4D4XNrd6963rDHySiItD68akYv1yW4JeDtRX9x0xFCJT4X5Uw==
X-Received: by 2002:a17:903:1aa3:b0:240:8cec:4803 with SMTP id d9443c01a7336-24096a68233mr26935725ad.7.1753856274216;
        Tue, 29 Jul 2025 23:17:54 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffa37f078sm75017815ad.115.2025.07.29.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 23:17:53 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linus.walleij@linaro.org,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	sam@ravnborg.org
Cc: dianders@chromium.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v3 0/3] drm/panel: novatek-nt35560: Fix bug and clean up
Date: Wed, 30 Jul 2025 00:17:45 -0600
Message-ID: <20250730061748.1227643-1-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bug in novatek-nt35560 driver's nt35560_set_brightness() which
causes the driver to incorrectly report that it "failed to disable
display backlight".

Add mipi_dsi_dcs_read_multi() to drm_mipi_dsi.c for improved error
handling in drivers which use mipi_dsi_dcs_read() multiple times in a
row. Add mipi_dsi_dcs_write_var_seq_multi() and
mipi_dsi_generic_write_var_seq_multi() to drm_mipi_dsi.h to allow
drivers to more conveniently construct MIPI payloads at runtime.

Clean up novatek-nt35560 driver to use "multi" variants of MIPI.

Changes to v3:
 - Fix incorrect Fixes tag. The bug was introduced by an earlier commit.
 - Minor formatting improvements.

Changes to v2:
 - Separate bug fix into its own commit for backporting.
 - Add var_seq_multi() variants of MIPI write macros for sending
   non-static MIPI messages.
 - Minor formatting improvements.

Brigham Campbell (3):
  drm/panel: novatek-nt35560: Fix invalid return value
  drm: Add MIPI read_multi func and two write macros
  drm/panel: novatek-nt35560: Clean up driver

 drivers/gpu/drm/drm_mipi_dsi.c                |  37 ++++
 drivers/gpu/drm/panel/panel-novatek-nt35560.c | 198 ++++++------------
 include/drm/drm_mipi_dsi.h                    |  35 ++++
 3 files changed, 132 insertions(+), 138 deletions(-)


base-commit: 33f8f321e7aa7715ce19560801ee5223ba8b9a7d
-- 
2.50.1


