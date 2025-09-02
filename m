Return-Path: <linux-kernel+bounces-795464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E8DB3F257
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADCAE7AE066
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 02:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1032E092B;
	Tue,  2 Sep 2025 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/fCua08"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538402E0402;
	Tue,  2 Sep 2025 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780256; cv=none; b=LjmCat5pEmSzSxGPgCrhYtHVgm3b/jV955DrQYDSXyz9izHAgLvfRMZ3aCjuC3irlHFnJ6EQxNSNuU3sUrou7cxJjfOp1x2dHD1iGcw1/cbTTnt2VVPIdsEFrzr1DcQ5f17TP4ogoIVo41KiiP6Yt3OaTtO2rjsy969CE7uciVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780256; c=relaxed/simple;
	bh=1uMNurdJck9aBnwhuc1PdvvDG2EMgOO91TXfYvHTozU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXaFYZUV0nYD4zgho4cXQSNJPPifUxJzD2d+u9Ezc77kv8wVKkKHSApQqAt/NFPESvwtR9z6uE7jpgdtWFcr9/pG+GugERzv/SpCX8IrNhNoCM1ig7yJQb2U7vobvUikJmxcS3isp0wQxVfxykQAOxGzgFS1l3kMk9tpdGlNk5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/fCua08; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso4296378b3a.1;
        Mon, 01 Sep 2025 19:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756780255; x=1757385055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PI5FLh9o1H+IW7Mt9HM8qXQ7KbMa2c6JgMyQVAOf3VI=;
        b=d/fCua081YmfSnitt+JMgyD/QTPpc5emDjBocMarqjPRCelJfYuirJlJtHffuEIxXC
         ws78a5Pk7J37z0JbFW4bkZp31NKxzP6TB39QXg+4PQTWzW4sDv5uneEhGfmdundR9AkT
         FPzsuuGxCfNKtDGGJQTQFiKYeZJ6h5F76mSDypHLdfSEw+wSLRf95yMixggkAKWjqE3j
         zEzWfKwzEFNxV/L5a8+iohzo9fZ7mpfrRCPfMejP8D7sB9O4/pIcOwsUphQkSRPgBEGL
         kSZovcUmN//Yaik54IQbiSlOq0bwD+pa/uVxZn3kCTkYsE5yLRiSNf8LK/K24CrwYOQZ
         Tt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756780255; x=1757385055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PI5FLh9o1H+IW7Mt9HM8qXQ7KbMa2c6JgMyQVAOf3VI=;
        b=Eo6S5Tu3JqxaY/v9FqA6GVgg+O4cyB/GNPbOz4Q8CjhN6o9Ro0Kebcb05wJTYuVuv0
         WTzj29yks5yG8ouU1bmjcqOp+J3WnX9F7xX7MwhbqeDoJwK6j2hKyV4Ce0q/VelFOCAW
         SBUx1dWykdMGxGQhVgvXUKDON4VhSNzgsvIcZJow7X4Mjt2ZvIPCIaZQ7xf4zbOC7Nrf
         y0s4PjR1CZYiU84yVBqmHF7lp1ITgsjnz4uRoVsSr1EzFcaR+UrTQU3bF+8vzIUBy/IN
         U5b2HShII2MCzi7PFwmr+j5eKP03pYX6pEjofCYI//j1ArIJwZoZKjjCvpbduyuLzylz
         PLxA==
X-Forwarded-Encrypted: i=1; AJvYcCXooMmx+15qcZXMzkKdhCjMWBygk8mAWPrJE8/l/CWxKrJ/QRyLLSH87e9AJKamM3mGVfMNdhy1bMiczlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTjZUqCN/oiUO32bDEfslo98vns7clCxdAVsk2UlKXokZ6xu48
	4+mK0yRoR53ulWYsPpsw1adWp7Sidzo2L/+TmG1GNgaL4s/vC26ItaVu
X-Gm-Gg: ASbGnctMN7Cpn2ZPIT56jm2zRqSSizl4Z4bTrfqhDL/l4FOA5g3nzqT/bsnr1x+8Gym
	HANN3dBPyvv29IidAyMj6CYTrYC8R4EB1tXIfypA2oIAA1H31L4mYi3hNbbhcaKBFNN8opBxm0D
	wPYzPS5QbDQCV7ewnzXo9JSeoZkk296PHZ597f9tfud2i3W5s5rHCTdUvSrRHsJGZFyJv/oxfHl
	wx4cDX6GRRK0VeCRpmrE8bZ+lXczydxDzz5b5kFtKNLUyxipuVFNugQjnCNHGwA2O+DqfWcUkrr
	R3D5y3h4JY+hTIB+Bnz7FqPKzAm3HpLIvLlXUMaHqT9AGIqXoka9gMStFacCKUP7xdnZsgOlyeX
	M/ZoO3kgTq3Zfu0IJ5wcMoIM0T20NVZL0dXJ2jnlLnHhN9dPm/643pkgf8Y15lB4=
X-Google-Smtp-Source: AGHT+IFUQUD/EHh/Zma9f2dATV4S4nUIiAeWzyqcozd39zviqlxw+wpoFXWDViqSUU2gRdKjLsGLgA==
X-Received: by 2002:a05:6a00:2347:b0:772:5ba4:d75 with SMTP id d2e1a72fcca58-7725ba41224mr7316154b3a.4.1756780254558;
        Mon, 01 Sep 2025 19:30:54 -0700 (PDT)
Received: from fedora ([172.59.162.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2bf5e0sm11973278b3a.36.2025.09.01.19.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 19:30:54 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1 1/3] docs: filesystems: sysfs: remove top level sysfs net directory
Date: Mon,  1 Sep 2025 19:30:39 -0700
Message-ID: <20250902023039.1351270-3-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902023039.1351270-1-alex.t.tran@gmail.com>
References: <20250902023039.1351270-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The net/ directory is not present as a top level sysfs directory
in standard Linux systems. Network interfaces can be accessible
via /sys/class/net instead.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 Documentation/filesystems/sysfs.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index c32993bc83c7..c50da87f27fa 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -299,7 +299,6 @@ The top level sysfs directory looks like::
     hypervisor/
     kernel/
     module/
-    net/
     power/
 
 devices/ contains a filesystem representation of the device tree. It maps
-- 
2.51.0


