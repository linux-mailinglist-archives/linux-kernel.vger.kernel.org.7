Return-Path: <linux-kernel+bounces-825085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483FDB8AEC3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A815A65FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D65925228B;
	Fri, 19 Sep 2025 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZUlZP1Z"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BDE20487E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306714; cv=none; b=DXB0ox91dD6d7H9XJzwhWj51XhoQJwrTCU8WrEMI6wPwggaqXjBDQzxM4aUMCEsk880OdzI6pC0FBbIiq1c1woxwuGp2oJFVB1QFOZ/Y6s9l4IUt2pR0eFaAQI3rKl0yDIPO1SxiWfW62AJUkuBY7QlDtMl9RQIKObPETpmfRQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306714; c=relaxed/simple;
	bh=NtQC/MmlK7h+ZKGq10SDYcJ+Z2kx1r11RyDe42/+ZMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jT/u2YrSlatWO2OGtZEs4XCRX3ZNtnogDXChLrs1jHtBYUMcgalPX34A7InK1vujxuQO9Cn9kMAzOynlrQNv+fIyLYk4TBCoGI/aPL0QGwsTrUwxXcg7TmwWCnFrl4hi029EkHx27PLOd8zMv37NHT2nf/v03ot6cVQwpMSIaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZUlZP1Z; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77d37d71967so1785742b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306712; x=1758911512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2yeL9qpe2dk3r4TeS6WdfN+7sBAeYo3Kd967A0Jh/U=;
        b=HZUlZP1ZTH4/iPzuQuz87wPuBVcMxuKzbq56sKhe3nQPAu8Pn1Bd6EVDt1aPg22yw1
         eSR+aKT8vrMs0IFCGIFnoSXqorcm0JAk54Ezegc4162KfoHgk3P/rsg4u4lLbQS3T+bk
         DQT6xfNzQmngeUgdXSilWW2pycwoykhIqxWlDHEVvPfyg6d3baudbGafx2E+RmpxkWFU
         IIQAkEMyX2TFOK+6NSMt4PCJnugX900lerFnWg265aVeSiCdDyTHocJ890OHUb8RWtLQ
         Nz5T4c+6/1syO8VevSaRgAEDo3rwKQo13g/N4jWfLBNh0z6wew7H4Ln5ez5O8d190Kay
         ddxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306712; x=1758911512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2yeL9qpe2dk3r4TeS6WdfN+7sBAeYo3Kd967A0Jh/U=;
        b=WAHZitaP2x3/32d/8xmI9drhBMAmCwrCTEZfFzcvB3SMlXg+lu9tkkO47CY0wv0Zd8
         j5j7jjqYCD3G8joyKmj6JYh+y8YU8X736sbxihpz32Miz1pGeU+/Ib3JVPOo9iQeixEA
         b9OVV1QB55raIVppEkBaOhzPeIU+luCzaDOhu6aef2Zb1wvEUTno4iM28BBITy2o837c
         x8AcRNHkTx1UoUlte+w1giM7agJY1ZOCJgEOiAJpn+s784ymc13gRSU+QmMVGqzmFFzP
         kbep6DaMuNEU+JHEA8tcrT8bqpuXI+TT/R3o7t8W4e6WE348byKwe/nGRpo+7aHlbCOq
         Sl3A==
X-Forwarded-Encrypted: i=1; AJvYcCUTMOHKb1rEX8SCk5++bPhno4lcI9Li+qIQC/W5GdHHbkkIDycwNGqn8Cf+VmdPjztgrLGKEKew0EGrovE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLujrFomJ4Qf6MOALljnaMeb9lJ3LJKGCWP6sa8ZoUhQoYzYYf
	0osmBN7gRwPh5hke3BdPM/ZhhWTgu2a05X4l8QlgUHMGGLn0+SXsXh472WkO4YpERmM=
X-Gm-Gg: ASbGncuhHV95G5lVsLqwmU1BPvRy40PGq0eNCJROHR1S2apHHXEm7IQTpqj4OQ4d0if
	l1HgSC2AabIc8MImuayFXdG1rMC9mQAPyg86Xw+Hr3DUAsLxMpF4M4u9k+VkgMTMhkHyEoQazEq
	QNqkFTAmeoITZjew6pw0nnY5DAqDMM+EFb9Nt2xGXVrX+9aBwBOcD+t2QE3OpNIaHalHNSGQY8b
	iQiaLu+3PZ8hAB61nxx03R3XdkA/ecVEq7/balSRoDEIW78G0Pa/Ci8uleQ9f0eiuwNPzb0Whho
	2rVyynPLqhohTmDpvxUrNVlqMMlzBN4CQf2V2enu91qh5WiCHJw6BKu82B36IUr+Whrzu1Uor3S
	YeUjGx5fqkdHAMOocj8xf8LabiDY=
X-Google-Smtp-Source: AGHT+IHKk1C6demLZSfQaSYDHM7x+46+mgzS0jEkowBppkgliAtg1CGYcuMNU68VKc1FYbdwa1S6tA==
X-Received: by 2002:a05:6a20:7d8b:b0:243:b089:9fbe with SMTP id adf61e73a8af0-284681cabeemr14558643637.31.1758306712226;
        Fri, 19 Sep 2025 11:31:52 -0700 (PDT)
Received: from gmail.com ([157.50.36.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b552fa85110sm538758a12.45.2025.09.19.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:31:51 -0700 (PDT)
From: hariconscious@gmail.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH net RESEND] net/core : fix KMSAN: uninit value in tipc_rcv
Date: Sat, 20 Sep 2025 00:01:46 +0530
Message-ID: <20250919183146.4933-1-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

Syzbot reported an uninit-value bug on at kmalloc_reserve for
commit 320475fbd590 ("Merge tag 'mtd/fixes-for-6.17-rc6' of
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux")'

Syzbot KMSAN reported use of uninitialized memory originating from functions
"kmalloc_reserve()", where memory allocated via "kmem_cache_alloc_node()" or
"kmalloc_node_track_caller()" was not explicitly initialized.
This can lead to undefined behavior when the allocated buffer
is later accessed.

Fix this by requesting the initialized memory using the gfp flag
appended with the option "__GFP_ZERO".

Reported-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388
Fixes: 915d975b2ffa ("net: deal with integer overflows in
kmalloc_reserve()")
Tested-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org> # 6.16

Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---

RESEND:
	- added Cc stable as suggested from kernel test robot

 net/core/skbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..2308ebf99bbd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -573,6 +573,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	void *obj;
 
 	obj_size = SKB_HEAD_ALIGN(*size);
+	flags |= __GFP_ZERO;
 	if (obj_size <= SKB_SMALL_HEAD_CACHE_SIZE &&
 	    !(flags & KMALLOC_NOT_NORMAL_BITS)) {
 		obj = kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
-- 
2.43.0


