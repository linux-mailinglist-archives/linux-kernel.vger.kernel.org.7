Return-Path: <linux-kernel+bounces-815310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F932B56275
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 20:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84476189EAAF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 18:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42022116F4;
	Sat, 13 Sep 2025 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb0EuTHn"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9343A1F7098
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757786497; cv=none; b=cfXfWHJtyLqLBycAtParfQd1xivmyNsvCFP23GTHaXuP/4KJ2XtIXonR55B++vRJDHOzm/ajaagp1tj2CJuXvcMd1E8FePpknjWaBfKPNaFNZb4QlRiU7iT+f3oLdjG55+SfM7m2w2u7J1Bevpkms8ZrvzR1aooQ73IbMNXgbtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757786497; c=relaxed/simple;
	bh=UnaOqYluKu28oBnwPH0vnbCU+O6jr21CjF1YCAIsvFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UX8zcacs2KhjEEJmnHFoIyZufhWCSn1gcuFI/N+51+qc1Gg8B9phf9rqiayWFPPaAktyMl2+ThvPhDO/eG9LZjLgtdWn/CwR0qoRsrgF9L4qz18WgzItFwFQnXU+tesFdifd0wgqaXqoliboi3KKKAp+gsucSbrldFtWBN0YAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb0EuTHn; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-723bc91d7bbso23819727b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757786494; x=1758391294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NjHrIrhN/4pjfGuGdsD+5Ie4bMJa+37LDUXsJfR1WJM=;
        b=Nb0EuTHnk1rU4+sqHEk9Mz5mpnQs/KBTBTng1Hhz678Q9HwjDl1TLzA0KsKQkGCzYA
         jvJLACHZmVq69So4rWVOwFZlioYw8vsQ7nvMjkniKntOa312AJjbZDzqnknXXLfvWeSR
         +/WdVba6LWds6ExTHDYbt5ZgrWi3CdtQPxdzq9j9UTvkoCx5p6EChzRxjrCkl5nrLG65
         xycttFw6HPHGU5Npw+rEOdC26IQMI4/85fbcZ3ET87A6735jla5h8WJ64hc7KpvxcffE
         Qa99/97mOmQ7QE2tJiZLd9XrT5snjtLqazOCoVelfzi69R/VqJ1GYcaBd/AnEjHt3TMm
         voTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757786494; x=1758391294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjHrIrhN/4pjfGuGdsD+5Ie4bMJa+37LDUXsJfR1WJM=;
        b=RtdXg0d/buVzMRrikNMk7l2nbBNkLDxJ5NoGPOcVnlVbHuz3NQYKUbTHyMbkIENn0x
         caopZJgMzbDkYJyOEpzehAoOzTqWu+TEeKrGEOtWsdUZCUWHAtVmGBi3uwURSJYVFsqD
         L5Roqx/mhg+FxQwg2Wctm1UC6Z2iXrl4Uq2BaHDF7pw7P1T+ydprHUbV9Tx4cMvDiU46
         n7NxdvNyLsSQfjt3+1muhb4kB3J12Y5gp8bUI1TMOt3BHSA+H6MtLPrUFWTCVYh05euV
         EhlRDvUqVFJboI2mmOjxlyCxN5SwzPkupE5p79vWW12Q94XPmKvQf03SOUi+s6aKisst
         L1jg==
X-Forwarded-Encrypted: i=1; AJvYcCXNhSb4szOdEuQKY6kitOG8v0uk978VPGEa81GbZr5Z+wAyj0B9kCH+7+CajWGqvJhck3W+g7eYLqY5aGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiqVVcU/67eOd4RzPKQEMfxL8ggu8ndHY+KU69PSeaCqliMDS6
	gpICK+mW0lzNZVY9nxvKn+pFkiOohs+NFB2DDwQ/0Xbs3kMJQbNo9dJz
X-Gm-Gg: ASbGncvXYODqZ1lZqG+8saLcIieQBtZ6uTkaAEG/SQO6I4JYuxdNyuLsNBxQucu348X
	QYDL0TnUjfqgoDC94Hc6DV7D+4TVBayhLbYmDsTkSG88oGFAwMrcoJ8ON2E/okqF/TPKJECf9eO
	3XAaCd8qXhjaL6lf0XfitEOqf+fGCSaTBqRKd5tJGY0EI4aOL9sMcaqsNf/j0Lhbf6GGekzFzXg
	2T5sq6RX3siCPc/fRb8j+1gepcV6HH2ac2Wh6fa5W4G+g2E73R5Jd0DgSQfz1yS0MiaIm/1AEWN
	wV6m/aooY1YHxoNQHkmtWeEEjfyboVCQnJb/SdtbaXixblZHESYU56oh1W8g19fTCsqgVhlMKjr
	LgVLb8yYXCeAxk48ToYh3nyjq1c+dzZWmLsYp/AjpCmomFPHeuHv/HIrqXg==
X-Google-Smtp-Source: AGHT+IHi0t1g25a3FWwQ5Y/nJHat0XL4SNgFHd21Ox1E7oZI7Dop3SdUOK6vuMiPxpkEVNb3sGWL/Q==
X-Received: by 2002:a05:690c:620d:b0:721:28ef:8b5a with SMTP id 00721157ae682-73064cfc35fmr58784437b3.31.1757786494286;
        Sat, 13 Sep 2025 11:01:34 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-62484dd3e12sm1900016d50.8.2025.09.13.11.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 11:01:33 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH] mlxsw: spectrum_cnt: use bitmap_empty() in mlxsw_sp_counter_pool_fini()
Date: Sat, 13 Sep 2025 14:01:31 -0400
Message-ID: <20250913180132.202593-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function opencodes bitmap_empty(). Switch to the proper API in sake
of verbosity.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
index 50e591420bd9..b1094aaffa5f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
@@ -170,8 +170,7 @@ void mlxsw_sp_counter_pool_fini(struct mlxsw_sp *mlxsw_sp)
 	struct devlink *devlink = priv_to_devlink(mlxsw_sp->core);
 
 	mlxsw_sp_counter_sub_pools_fini(mlxsw_sp);
-	WARN_ON(find_first_bit(pool->usage, pool->pool_size) !=
-			       pool->pool_size);
+	WARN_ON(!bitmap_empty(pool->usage, pool->pool_size));
 	WARN_ON(atomic_read(&pool->active_entries_count));
 	bitmap_free(pool->usage);
 	devl_resource_occ_get_unregister(devlink,
-- 
2.43.0


