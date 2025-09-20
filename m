Return-Path: <linux-kernel+bounces-825881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D03B8D08E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E637C7F0A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF522749E9;
	Sat, 20 Sep 2025 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx2fa9ZS"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D009F26B777
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758399135; cv=none; b=uWizphEJUFHL4KOQqlgDE5MFFGvtcbXhWu4II6nZh+gRsx196H4OVU+GMnpqJGyPpJWQYRxgtel4++jm93dNdBVQNLjRI0kAQYy5Po1/3hFLamAWNCP+G2OAkc0InV57sCs3W6+icN0nkejR3s1fW9nzXLFfPSpnwb8PbXWH83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758399135; c=relaxed/simple;
	bh=feKc9PJGPZqt/uE+zM0sTjLZY7BjOt/apiF8YLIoW0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SRf3w4124ERN7PIkxHwJ4sG3yzgPU6gBmHnupGwXJdoSgToT3rqbT5edNFZpLKd6rrHZxx+77HOyCzkiqHSCQT00X9b+nLYHs6a7degI5g+3Skt/OZQa8z9p4Ceo3I1H/QAhAjSn6YpfJ3BoJj63sAt58ZA/MCg6skvU/gDoUII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx2fa9ZS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77e69f69281so1708815b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758399133; x=1759003933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfxhpuR4uEPQTXMkMfbx8NFTCu/dYBMS+9D8zFtE8M8=;
        b=Hx2fa9ZSigpYUBKxFgnFo4s1MOstHJ4uA+8Yaf+dKydK1P222s8OLnMQTUvGngFxWQ
         bRz+YKgya2x3ZJpXqkRCZc8toK3riiR7OF99r9cRLvwyJKPMPtO/s1MeAMxYMlCQteql
         F+DaibwN0/hgW6tdxPWfxSV2TZfvlgNp0Ztjmz4JymSc2dca3Yexh9egXExSaTXyrurJ
         /dLOAxGb0oGT8lPXZ70PTxtdwqEiIlkB8pQvJRg+eTWua7SBnzorNkhPZyl8Nw3w+bwd
         /hReW2qe6qjJVPPAz1+QQwgPflAIcDh34YAjx0Aikz941TJ/iGvcCbInNBG/6KNy9UDn
         iVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758399133; x=1759003933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfxhpuR4uEPQTXMkMfbx8NFTCu/dYBMS+9D8zFtE8M8=;
        b=RLD97lmOb9YDyw8K8auUmCA9YbIoV1z5s4tGkjd+89ZrXjdKYXv9YbcekvcTAgBpx/
         ER4gcFd5ZFy84incST08FRajejp/AfXnhOY3/NPwrdXqV3mFYxowsMmjMfo2UMDLmXck
         HwbE8Pty8D4bOb51zcgsGigFy0nTMZ2DZ1AhVSAz5Ilyf2kyxiGQ8tLFK7MGJFmmy5R7
         SfrsdTSQ0qcy09BbVVOdgUdPe/5i8wy0m8r0d7R+cdmx59qd/QEFAjUwEnERF6PUyaBP
         DQjMXrSb4iDGw01xBIQFnNiCRU+jgskHsOW3jTLhVCUvjs0pqxYjJpatdy1PPUUd6cMU
         PY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMmLxIQkiu5HcAnFJevdGrl3RmDbAVwERR/HU3NsqX35lUoQppy7EUe99EjelGMy5KmVzqzCHnX5Wa0hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoFdoBh+OsJjb6SHN8VJ5i+4vSdS9OJFOW0iwWzafrm+Idvj92
	h8wUszVCsP61+BFeqICFDKH5SoaQQni2XUo04OxRvK/XawiSg+dxw9rI
X-Gm-Gg: ASbGnctRlqnJf3U6eFTl9WVus3Pu72bwRXBMAPzIK2q7ahX/5qUPiRd8bS12FKHxGzR
	DJcgptGoq1M9fRXMyLA1Pm8j8bpo7r26z5zy34iZivQF/roYLSKZRdNAme0fi4wF6N5lhiVeWF1
	tvGJ+tw1GteB5gqSHrCobKwpLyMnMsxMfEY+jgj/k6Ck4mZXKBLSLxP19igRH9RC9cdLvcLcsdx
	bSLp+Y+8koiMygXru1Xcy7kS5hCiDnIx8kcp9i9dBmzMRO1ZxQYm+pKr6k53q4oqRJZxEf35xVn
	5VqOR3ajqAkEZlDHqaA9FFKzNmOLtxaSPkiJk/iWc0VvVaH/8kBMzCbhj3O2tBfm64O5B3jLl1U
	CJS3kkr/WUBA9VjoOhVmdGVq7hRyY/5phkjLSfMtN/CLq0o7fZXiS0XC/Aqd6QAGUxShZx+ZMDL
	tegKBW82qBoh/HPNKTR89AKKePFg==
X-Google-Smtp-Source: AGHT+IG2y+MxKod/XzAN+M1gu7tYhwj5v+CW7f8oWw+t8RRRrPcsei0GeMMgdnDja1lZ4nyAdg49Ig==
X-Received: by 2002:a05:6a21:329b:b0:263:57a:bb46 with SMTP id adf61e73a8af0-2920875282bmr11094636637.13.1758399133055;
        Sat, 20 Sep 2025 13:12:13 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e2b7d8078sm5919446b3a.81.2025.09.20.13.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:12:12 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kerneljasonxing@gmail.com,
	martin.lau@kernel.org,
	mhal@rbox.co,
	almasrymina@google.com,
	ebiggers@google.com,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com
Subject: [PATCH] [PATCH v2] net: skb: guard kmalloc_reserve() against oversized allocations
Date: Sat, 20 Sep 2025 20:11:38 +0000
Message-Id: <20250920201138.402247-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an explicit size check in kmalloc_reserve() to reject requests
larger than KMALLOC_MAX_SIZE before they reach the allocator.

syzbot reported warnings triggered by attempts to allocate buffers
with an object size exceeding KMALLOC_MAX_SIZE. While the existing
code relies on kmalloc() failure and a comment states that truncation
is "harmless", in practice this causes high-order allocation warnings
and noisy kernel logs that interfere with testing.

This patch introduces an early guard in kmalloc_reserve() that returns
NULL if obj_size exceeds KMALLOC_MAX_SIZE. This ensures impossible
requests fail fast and silently, avoiding allocator warnings while
keeping the intended semantics unchanged.

Fixes: 7fa4d8dc380f ("Add linux-next specific files for 20250821")
Reported-by: syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5a2250fd91b28106c37b

---
v2:
 - Add WARN_ONCE() to make oversized allocations visible

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 net/core/skbuff.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..70588f98c07e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -591,6 +591,13 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	/* The following cast might truncate high-order bits of obj_size, this
 	 * is harmless because kmalloc(obj_size >= 2^32) will fail anyway.
 	 */
+	if (unlikely(obj_size > KMALLOC_MAX_SIZE)) {
+		WARN_ONCE(1,
+			  "%s: request size %zu exceeds KMALLOC_MAX_SIZE (%lu)\n",
+			  __func__, obj_size, KMALLOC_MAX_SIZE);
+		return NULL;
+	}
+
 	*size = (unsigned int)obj_size;
 
 	/*
-- 
2.34.1


