Return-Path: <linux-kernel+bounces-887669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3866C38D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851F818C6455
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1454623BD1D;
	Thu,  6 Nov 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J755fygp"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44B1DE8BF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395635; cv=none; b=UJR5uVcCp5a6/Ob95GNRrx6B2+e3hVIqJcr64ya3/XXl+jSM9XUOAdWtNCaSFR7pTM/w+kqNXB8LVrnx4rAwGlA9f7oob/EFzb4G93M1Vz4XMErNo+rMFADokqMsSJUYWkClRznPl/kqWC+bt2wmQFQ1+ZhGbAeCOd8ITVvVJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395635; c=relaxed/simple;
	bh=IExuTD4yP3lfLoet8tZrvmXvXyTJ/DV9Z5x3qgVSFYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ncAreygW1eJem13o752KkkqRLB2NYqzn2+uI11s+3rvSNcqKKg3rjAcz95Hi97Bd4fwahr3sTn+Rbpc9A/xHN86PJzCnnX7cB+qdRN3COUVNB8jnl+8G4rAg5Ir6Mvz33R245O2YlB6u/4yCs5zCyU1eByoMcVYUf2OfDHamjVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J755fygp; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-793021f348fso429208b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762395633; x=1763000433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=APyjP89ZEGyOgpw6IYgPQw/KB5WQid/ruGqpO1r3Z0o=;
        b=J755fygpH9udwp6JQW+2muxZhlEnNOrnbjUt0s6zMdzYLx+I3DXsBDU1tQaA4cO0h4
         sKGVmKginnlYjaBU9LaYmWmpKM01+Zg8DFkILcIGhVIuvCIg0R6Limlt2ehLw4Zprxx0
         9z+PbqY0cH2bhBdkIpvSTQWgmOCfyLQqiinPqOtEleQp6GcwK5NOcrPs5f/OBC30xJn/
         axKhCh20UKYhB0sIcIFyUxr69A84o2GmlCZsV+mbnLueJGcXV5aiVcdhrAtklELG7FNQ
         P2A4JDh5XjPOoX5xsPONExRsXdYhvf2w3OuZeWiOomkgYG/duWAngC96CnTCF4ECme3p
         7DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762395633; x=1763000433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APyjP89ZEGyOgpw6IYgPQw/KB5WQid/ruGqpO1r3Z0o=;
        b=qszJy/P6S5TzCYTQb07Aqu9aKh1T5I92CYzZWcB4Rl6R/oKiMkGCNI7xMvWaTIlLVj
         7i9W3m4JxlCmF5kuddZsD4LLTuXWrx20ekMjKoUlq/fKWEgAs+uvFRMt5py0u6xgIECP
         +frEvDSZsA3ziMdsUEnyNaW+l0Ixn3l1izKrGh37W6LTrMTpKfLwTzXzIno8YdyRJ7wi
         PVuqYBQFYqm8dlTQJ4FZwHi2iyCzhnsagS+2eGfm6SCxFE8GPb8bHl8vIOYcsnDwDwPR
         jplI0WkHZXE6f1s3g4fDPNCdA/G7LUBQPZRPPMSRyQGubrX82yHZXM0tiW9Ec4Hul82A
         NBjg==
X-Forwarded-Encrypted: i=1; AJvYcCUUxDCqb1pqvC1ocT0SUotDrt28EnYEO1hUQhgbD60W+GW5No63D5ATGiBz+AtfF+DoMQ8liygESDJL3tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfOUziIAE1gIq77BTw2gmXUl8HMzc0JvcjVgpaHJhPvtpfLAj9
	yYnBEs4E34KhAzvCFkmEQZNZv4kic/E2U4ieHGLHeHs7hlJadt1tQ7BV
X-Gm-Gg: ASbGncsPEb2ImNSdbBDZArRWf5Nbcsx4q/fYnJlSXMcZOrCh/HS8bmlr5fsy+1iuu+z
	ILM3hmFC2xzAzDVb/OAVCCIeh6f3gZZ68sZ7N78seFpD3uVArsXEUzMfuy6holC50m2TcFnW/fz
	N3FYisV75jkusD2mpvrIihZy9loyNG7CwQ6JvCVxpbYEzXcCUsJUH9AKevOM0kT54eptqEgV0m7
	vzvqU7DTmHFpI09L1QGQfmxzg/+lIVXQ7KYDVY/DDsfxTgSpfpZeAzipgIpZmw9sbchzqyLYH6g
	QsqzNvdhMJwFM8IagQvBkmgWLfW38ON4OL2ghS/eN5E1XGP7zKHvXQiHvgIK9THqqt3fkDd2HMY
	Q7k5PdTFVUwta4QwHUvRtImrLXu46hL/n0C/ORBDvA6uLu/0=
X-Google-Smtp-Source: AGHT+IGwLwltM7hjFkqW1lSpRRGBPVQlKwEPQ277/7xJAbJDdTTr8KfzmlicE2p3iE7bm1PNBZeJ1Q==
X-Received: by 2002:a05:6a20:7484:b0:33e:eb7a:4473 with SMTP id adf61e73a8af0-34f846fdc8bmr6787728637.23.1762395633255;
        Wed, 05 Nov 2025 18:20:33 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7fd57f91sm830516b3a.23.2025.11.05.18.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 18:20:32 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STI ARCHITECTURE)
Subject: [PATCH dmaengine 0/2] dmaengine: st_fdma: support COMPILE_TEST
Date: Wed,  5 Nov 2025 18:20:13 -0800
Message-ID: <20251106022015.84970-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First commit fixes compilation under 64-bit and second actually enables
it.

Rosen Penev (2):
  dmaengine: st_fdma: change dreg_line to long
  dmaengine: st_fdma: add COMPILE_TEST support

 drivers/dma/Kconfig   | 2 +-
 drivers/dma/st_fdma.c | 2 +-
 drivers/dma/st_fdma.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--
2.51.2


