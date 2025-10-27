Return-Path: <linux-kernel+bounces-871080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA65C0C6EB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E5D18884E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8129B2FB98D;
	Mon, 27 Oct 2025 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etBaUrra"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC402FABF6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554638; cv=none; b=RNlY2b+9yImkoiOB3gM8MsfuE1mA8eC/QtILh3zhLsUHiAm+lDvJbQX2uDZJLEvL5B7ZFuY1lNCQq5JebLLe578M3pzmKUNw+zI67NjpTXtU4qDZGAYaQW1IUwo/YRN4DvmlL81kQ+mDQm+5pXWBxLPYhxeLeEGysD2cN049ZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554638; c=relaxed/simple;
	bh=6GhP5nzTlCJfW037vP9XgllmDGxPVLYMDiLoDoeZNf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZDlyjQJRKHNJTPUQ2EgD2VsMyh4zWlxZQ8ka/e7EOMzyqeowFuRixWmI1JGKXnj2TLcHuG9MJig7KJqxfmT/qP++WXInS3xUwGk7kphcvJAgqtw6A6jtvYDht08Yqz5yc+JsRdB3g4dWk46FWiU0tTsPwAw5GWFV0h9k+O6XHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etBaUrra; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b593def09e3so2621966a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554636; x=1762159436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XdBHtrgp03ghVnsbwdnfe2LK03D2az8OLXtLHgvnDs=;
        b=etBaUrral7HiRlkJR5xaCp3MNIXyZm0xW2f6n99fj0EjBEICuBayIANI1njiuZgH3J
         MIkNOYCgvHo8FqzquFQ8dMygzlTiohEzoGRM/64fb+dj2XdVyKj5d16NKCWpWHOw0n7O
         lNI8DOrgVGAQjMP1JPDB5qQ7S6uMo1GQEYC7MYrFVe0YM5TCuCPhEzTjuR6n+Klle5tB
         Wib4R7WXeJRiPtw0Mc32FYsEputC4mB/WT8GzIFvzMNdgxCXKPPrOA4bqy/csF1vScOf
         c1stI8wv//WN0snEiNTTguzLBmvkor+9Vh7a/H1xfkXZrNNOaaPSp2lRzziPH2/1ctgQ
         QIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554636; x=1762159436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XdBHtrgp03ghVnsbwdnfe2LK03D2az8OLXtLHgvnDs=;
        b=A1PJ/5i60MxFWoPfgXcueJvJRT9W1rGEvNtk/FcKEelQ2YcpDsVUXfaDCEjRVVspu0
         0BmF/lW33X2UrtG/VkPab6MMQXeA2BLJjrab02LZ1mdcPCLYY0qMoj5uVn/RdwuO/+hO
         2PapEpW//qwn99scz1dMp5o2rl71sCz+NTf5u3ITsCLPXKI14m4kdTXWKcqmEHrsYFFO
         23uN1QPefSoqgt5dGpDExdlNlLRp2St+WTPtCo+zlkJWYAL6ynG3Mosv7+rEcStGn0NZ
         pYnBuaKSx8+atnuMj+4v/pqLZvIvsDpiRU3DXBcDqPbiOwo5hBLi+TX+jHBztwRYlOWp
         d8PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUft0NBFqkbUyHNsbD5Cg934S/m/6qzcs6vT6iGHPXngk77DSPn8SaAw/G/zttKjER6iEFT9oxc0tgEZN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBPePx+udpR87u1BPl9k1mjKDc1WlCygX2uNs+X10HhRtIQFgB
	+Vx4IcL1zFxjKC+mz7VzHp4BtjhhWv10iVsPOn+bxMSY22Ei57G+K7Ei
X-Gm-Gg: ASbGnctHCZKlatdMTnamXFQa1P8cbLI34ufYhcznfTS1WM8WTBcAEpfdsi1/giUOAlq
	wh5gZuJkdQZeQY9fl9E5qR27MY0U/oDpULULRQWFwOjRIRnFnU8LnCtV/fag0Ckj2z9L1GQjKMQ
	aQMFjLDB+93XmFSV2C3l/bD9m3jZA3nFbV3OjHyq1HrGuwGD8E7vD2zXhbNesrtp4LL/ecuOwr8
	xhLp34CSnhXK5o1DICk9rE11JF5oD5dzBGoUnCJKG5akqi5hggnj1c81ygSc9v3a191w+NtIIs2
	PbMLjj2nmuv+1YEiioXVZlf8ZZyMFTIDJ9c6vKByQPqf0sB8JyWwf0wawbJZSYydVO9fPFTdjoS
	NdzkkQPXkIKJd79+u8slpMF+1kLp9QppYLUW0g6eqCs8XT/v2p+VMoqPWziZSWVN7pjpxGeAlGH
	fpsvZZNhFnw+Q3lHtZ01olvA1Z1dWNXO/2
X-Google-Smtp-Source: AGHT+IHJsL6+kpoPk8x1PWb0mqg3iHOZS6wR/zv/DBqOZ8GMqq9D0VqdZrEygNgekK2sc9hwLF1zkA==
X-Received: by 2002:a17:902:c952:b0:290:a3ba:1a8b with SMTP id d9443c01a7336-29465525229mr183633555ad.24.1761554636181;
        Mon, 27 Oct 2025 01:43:56 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498e4349fsm73037945ad.107.2025.10.27.01.43.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 01:43:55 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Paul Mackerras <paulus@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] video: valkyriefb: Fix reference count leak in valkyriefb_init
Date: Mon, 27 Oct 2025 16:43:37 +0800
Message-Id: <20251027084340.79419-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_find_node_by_name() function returns a device tree node with its
reference count incremented. The caller is responsible for calling
of_node_put() to release this reference when done.

Found via static analysis.

Fixes: cc5d0189b9ba ("[PATCH] powerpc: Remove device_node addrs/n_addr")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/video/fbdev/valkyriefb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index 91d070ef6989..6ff059ee1694 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -329,11 +329,13 @@ static int __init valkyriefb_init(void)
 
 		if (of_address_to_resource(dp, 0, &r)) {
 			printk(KERN_ERR "can't find address for valkyrie\n");
+			of_node_put(dp);
 			return 0;
 		}
 
 		frame_buffer_phys = r.start;
 		cmap_regs_phys = r.start + 0x304000;
+		of_node_put(dp);
 	}
 #endif /* ppc (!CONFIG_MAC) */
 
-- 
2.39.5 (Apple Git-154)


