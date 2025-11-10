Return-Path: <linux-kernel+bounces-893886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F490C48949
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B909D3B591B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B415D32B9A7;
	Mon, 10 Nov 2025 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIHQfj+N"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6532B98C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799233; cv=none; b=iXY11c/yHf6kWVdl9xjJCaJKrFBqlkW7sMh3Dv4tT0C7IZBWJ7RPEPLDaZJeD5bXyEo9aaeFfkGc7761eVS96gbVBhNuMjXlbqoggP4DI8PQ+FHd3+tQgeQukNmtKPzf9iNHKfkVs9ra/03ENljgUXqs2EP9A7S/dP+gjkQ58ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799233; c=relaxed/simple;
	bh=Jo4KQohk0qAHMwR3XazWzSRyRFzOWbPZkI4FA8ppyNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=omH65YEuaVmIf78Ag64NhUX6O3DORnmWmxbfyfOzWarXzgfWwPvZKo04HwgvhxTBjJv5OWpy/QKgeJnVYiY1MlrSFDY2p7i8VvVuKeQ1txch9pVPJZLy3FhLntRBANHdgUh5mhLUtPsoI659zoYFttAi+w6+OX6lF12zl+jdwe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIHQfj+N; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3408c9a8147so45472a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762799231; x=1763404031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wAEVQn71Lt+FJLFXbW1DizRgBnzxoKpEi8u5SYwmvaM=;
        b=MIHQfj+NiRfEcUInXqK2Sa29bcGOKf27JSmgT/qqdaLNxxQ5HMcRPa4oXPNP8WxkMa
         o4Vz9jK4APhu5dXgOQ/FIAWeyBjinRttwlzShaFYccMDFS2up+lziTfhneprLAuOshZk
         VvxfyMAdIuqou30lO/L7sJA/nuyGfoexM6G+I23tPUzm25ygeN+P490xYrThIXD93Gfo
         DGio2+bVzgFDBt1O5xs5MiudnhsyqIJTUnDKhu6FljdSmOraCea9+7iPzTk1WNH4s4GY
         baGYBrH/bv9vNw7O6pKoYNb8wyQN4PkzL0Ths0wYmQpa6xnZws6pb4WP1wOXizw/ky8k
         gjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762799231; x=1763404031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAEVQn71Lt+FJLFXbW1DizRgBnzxoKpEi8u5SYwmvaM=;
        b=ma1ppCMzu9SsxSDTTxiTaBxBtKpndAoNDs25gtWLCmeRKqNCG2xtDemz2rEcpUGMss
         zk1twv/IIwf8Uq1bN+VznW0skfnKF3g5jbo1BsTYEglc+qkk0gE0BnGsOFQkgRBK7BaB
         f3v88fp9Sk9KTFkJmEd546kKK3yVv4n8TkWWQWBx56t+OnyO7egKsIb/XVCUdh60Pivs
         tWOVa3NWCSXztEIm2Tv4j23Gzr19lcDEXOEhe0seTA6tLJZZ9uRK2EclmnL6o8KllpiD
         0IrSJSXS2mMH0o/Bogmy5j6Gcqc0CDibTjUpsqRNQDtV07V8sqgGz4J1/1LcmCFKJJTM
         p11w==
X-Forwarded-Encrypted: i=1; AJvYcCWSxv/qMWlfkcU0Cip0oy8lKg+E6aR7AE1aA/f5+Dz0se3fcgLF0iyWnipqQsX0+BsPuJ+co2W7OCNaOYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/58Swobt4dWQontUMKPkQSMDqAMbvnCzkDmF5ULcEaxr3oAvH
	rv3R+lsJxNHtGhNDHs/cTVA985pBPwZx19eNkAR5qMJJ0tq32MfhxpVp
X-Gm-Gg: ASbGnctfkpOgNFBaKoNLfebXZSplatELz2Vi8d23Ihx2ObunldJsgMDsXD6Z+TeCr3b
	pnIqPqHhZ5eUFgmk+zQJ8Df4ZvbtEGaQjQS8JQeZMTyQjMK7aUHAmXYgkRNZuicM+snYXY38H9n
	GAZXHcBZzjUG9IuzSeMn5G9Qpa2l+ljpWX8j3W6IyBsws2CaHdXcu+IwwqqFYAfrbNk52AJPa4z
	dDt7ZulXhhg+C7R99cQlApC0rD0Lem3gyYPx2+YqO/TEp2G9BIKK3GIpzcIx7hVGQ8GPAw5EhcM
	afEyBAYUl2QRYcnSNzw+h7qKoh8CMxjc/SozV2+75CRXUGgRx7o681BFwx95xDWnx/LY3ua0dWD
	x+dhBlfDplDBotjEmGxkT7MUjsIBSeL52r5Vouy7mvYhB2tQiNJKD5fy9JQjXszrxzAvUy9AOdx
	OiEDYvRgWP4aaaF7fZ
X-Google-Smtp-Source: AGHT+IFp+5QPdyLsVySxg6S/DGa6ThFvZYJARt+ZTjhpCxWXJLS3IdM0P8g9EmWbeYBwYclfdp8zMw==
X-Received: by 2002:a17:90b:2dc9:b0:32e:2fa7:fe6b with SMTP id 98e67ed59e1d1-343bf23165cmr373892a91.14.1762799230756;
        Mon, 10 Nov 2025 10:27:10 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9634f56sm12752943b3a.4.2025.11.10.10.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 10:27:10 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] ethtool: fix incorrect kernel-doc style comment in ethtool.h
Date: Mon, 10 Nov 2025 18:25:45 +0000
Message-Id: <20251110182545.2112596-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building documentation produced the following warning:

  WARNING: ./include/linux/ethtool.h:495 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * IEEE 802.3ck/df defines 16 bins for FEC histogram plus one more for

This comment was not intended to be parsed as kernel-doc, so replace
the '/**' with '/*' to silence the warning and align with normal
comment style in header files.

No functional changes.

Fixes: cc2f08129925 ("ethtool: add FEC bins histogram report")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 include/linux/ethtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index c2d8b4ec62eb..5c9162193d26 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -492,7 +492,7 @@ struct ethtool_pause_stats {
 };
 
 #define ETHTOOL_MAX_LANES	8
-/**
+/*
  * IEEE 802.3ck/df defines 16 bins for FEC histogram plus one more for
  * the end-of-list marker, total 17 items
  */
-- 
2.34.1


