Return-Path: <linux-kernel+bounces-855227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4718FBE08FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 648AE5063E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A97303C9E;
	Wed, 15 Oct 2025 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OgACmLgj"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2EE2FE57F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558236; cv=none; b=TjxtPemI51NlcFOmRaliL9v99RKBIfT3DO8t7P7Of6Iy6ijjZE+ZZ7usXSEfF2bGWWXae6bYBgOIUT7hTv86Bfu33nAzzrjYThN8RWOiR6vlOSjJpFjeWZ3Q1bYlMyUXLjOzONjXCwceNyzmO0Ca5NDchezq+id82Oy/UoMl3qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558236; c=relaxed/simple;
	bh=PVOIGqVH2GNx8nbEhC4N+iemqePBsXVLOXVAi645cLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYvhlRVb0aQ0i4SLxY2BoMtqelddue2iSgANOuzUYTJdlyqEiFdMnR0fLeBuUObV4ckBmOhjmCrtd63aKNQPIUaTixALyq87jwOzCq0v5VUswTZOrS3zWQH9lD1YTksGjB7PLFtCQcmKD36QpFr3Fxrcb5s2NdY4XbgJ0uceGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OgACmLgj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so19757b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760558234; x=1761163034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jf1D+pXD9ez3LgtyDQn5W7bDLQYXqMdDa0ed4ybggHE=;
        b=OgACmLgj3Fqlk35hYcWGYLV9ZYj1vDR3GxyavGzVbpLSIwWbxNBmc9Mal+A9WSH7Nm
         J2oyyIDU7wlWMl8i+16+rc+ZhO6uGfgU4GsXW61dyC7YRpQR8AfpRTDTcAWYtJt1ePen
         VTW6EOib+7U4fUV72KMvPVQnA2PYFXKwmGDBfFBjjvRiiuSxByMCoROukQAWem9WJb2n
         2YghAb/cAgFD5HAKMkurjTKA6m7z34MVn8yT5+wsXr4ex8lVhl/jhNsX9h5TMc62tP04
         jHjSOi2oVz75K/CLm//a3Tn7GEtC+w3A+kvahEsDNSCaZhxuZ3WC0wyLRhHuXLSjlnWA
         G/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760558234; x=1761163034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jf1D+pXD9ez3LgtyDQn5W7bDLQYXqMdDa0ed4ybggHE=;
        b=YLCL4pLEhHMne9HNcPyYk6OoYKTscvU0WCyNElZ8DRL808pwR3cCvFY2UsRU9YiiLL
         gru3GqYDuYSKNZGXCEqlHfvN7t5ByZmIP6C74f22JRT1CeV720X/ui/h1kQVyItTq+Z7
         X6uCpHHBjDn8KEqecjK5COZxdB4vbHUqnl/uVs+d3Okop6vH5rrMj1v55OoNqlHnYpId
         ixgBEUQEu+mTIxSSewDMRygjJfrCrHNg1j9rcKh1ITmNV+55lmD4YBxTF6DrRohbskzr
         M+zjNAN9+bozWG+5DVLBxjL008YqjAXQYgrQmcOeUm1cwy4RS9s/tJsJvzVTIiPO46OB
         Qe1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6xyFfiixMWpUaTAg6/d2F6RiyPgoItd9Y5tFQIzh7DcFBp2IZesY0jhfJzg3yk3hLBq3MIhne4+pmIuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8NGj46V2iplqL6oL8LvG5NeRI0nJY0K/xwwILN9RKFqyDhja6
	NO0Oxgy6YWQofnn8Ie9tx3xXkaJS6aWeSBCdpI/25XRIabN0kaB5JsjP/rUDrhYuQNWGBUvCWT2
	VU1t7
X-Gm-Gg: ASbGncvW56XfLT7ToC0E295nGLkXUjtAaYqRhASa46+beRDDGgGSk53LdVh4u41A9Mm
	y3H1dnaSzQpAwkvryTuqZhxLgukPJKpsCOqu3k1GbFGI0uXpXtatu6lJsKeIlu0lOMvRaUZmHBQ
	JaGM/GgKrJaa7dCozNvJZoOP2JCvs8FWJdgFxrPSAKDyuDhdUWMKjO2RDC8RSl1ZxppAX/sj7ha
	C2Dpa5xoNfkhQQge4s8lTutbSWtbK4ZFyhTxbzlLSzTX3ToFpJBsa0xrQTbGavewAR6SmadzIgf
	KsScAO1yPk7dZRFeuqvRoX0hU0nsVlayW+RkNGFtlDbszNyZ6V/wQgC7Gi2uXaNTeQWXEOWb4X7
	PnRL58M/QBwkC3F0yCge7UodMHgCoX/3iDECWyIkW/4p4W5M+WTt0x6rGIoQ+21OGZOV6lyWdSw
	Mi94Adqu//zL+/1rOxCVyS/A==
X-Google-Smtp-Source: AGHT+IHwZvjxinrfQrnbeoDgW7hQBq/oQ8eKuyKeD7xr+PW/nsvJq8jqNBQZpbLuAC6y9e8iYnyRbg==
X-Received: by 2002:a05:6a00:464e:b0:780:fff4:f7db with SMTP id d2e1a72fcca58-793874402c2mr37486934b3a.15.1760558233936;
        Wed, 15 Oct 2025 12:57:13 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b06075fsm20151322b3a.17.2025.10.15.12.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:57:13 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 0/4] irqchip/riscv-imsic: IRQ handling optimizations
Date: Wed, 15 Oct 2025 12:55:11 -0700
Message-ID: <20251015195712.3813004-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes a small cleanup to imsic_irq_set_affinity() and a
series of optimizations to the IMSIC IRQ handling hot path.

Benchmarks on a SiFive P470-based board (95% confidence interval):
  perf bench sched messaging: 5.20% to  7.08% improvement
  perf bench sched pipe     : 8.47% to 13.85% improvement


Samuel Holland (4):
  irqchip/riscv-imsic: Remove redundant irq_data lookups
  irqchip/riscv-imsic: Embed the vector array in lpriv
  irqchip/riscv-imsic: Inline imsic_vector_from_local_id()
  irqchip/riscv-imsic: Remove irq_desc lookup from hot path

 drivers/irqchip/irq-riscv-imsic-early.c    | 11 +++-----
 drivers/irqchip/irq-riscv-imsic-platform.c | 11 ++++----
 drivers/irqchip/irq-riscv-imsic-state.c    | 30 +++++-----------------
 drivers/irqchip/irq-riscv-imsic-state.h    |  8 +++---
 4 files changed, 19 insertions(+), 41 deletions(-)

-- 
2.47.2

base-commit: 9b332cece987ee1790b2ed4c989e28162fa47860
branch: up/imsic-opt

