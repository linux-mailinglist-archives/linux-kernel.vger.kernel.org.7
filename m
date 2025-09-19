Return-Path: <linux-kernel+bounces-825069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15362B8ADAE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F3516337D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75E922A4CC;
	Fri, 19 Sep 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR1EdqpL"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD00860B8A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305194; cv=none; b=tBqfVkJDY2Ub/N3yi8GLuvXX5rZTE8IIm/IIENaDzoNh3ToQYf4JoTxQQddC96m8wwINY8OEjdqptf0Hwu2Y0sK88NNZ5B/IRYt1MPOK5x94Zps6I3mIzKKR4Pwx64EZD4H8Gnq39TFEYaKEiIr4DtbT5sn+AvOs+RL4ERIitLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305194; c=relaxed/simple;
	bh=gDa85MneB+BAwS7qvm7CDHhrBvUCUyClipVl7dU5XkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KwcqkqyG5FqmQHMkhw6/9gBaFq5OoSc2OFzm+IKj6iT9QHZ+w3D3qRQJcQM2ct/RG9tjLytNM9xk2kKrvNKD+sFvKrP2mhRBDljc4yXmCxaxtD6zK3ugBKVuPDfP01jE7i4JFaXxbUetMYgS1Q22cFErDAiKlUix8KO8vNNStPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR1EdqpL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b552590d8cdso657502a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305192; x=1758909992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fq9/RhrmaJ95VHFP/mSsZ0mv4u1FmOMHDPmgSCxvyHU=;
        b=hR1EdqpLAvs+dSy38IGxoIFrouLJ3GJa+y3XrAZekHfXNiLnfK5jPiN8HgrF1bfa26
         knL0JvVuqHmdRegdJgVIdCWViy8nRqUFVE8xq+KkVOmNTSoRmQh9Qd6zvEIiSlFr4bFx
         AAR8g+zYPjDmX4p/z153dFp860K4R77dthXlTSMnuuveN0546X5iajorgihVWBs07pfj
         vX6ofpjajPUhubgsvxWw+ovKPlm5RBJfGGrKQm/gRqCsTmucJov5TwW7YjjBuv9Edy3W
         k+03Bijy2MfF/5FaFebT0Z2S8hZKihb7hw/Nm/IrvdTL/nDo32ONM0G4i8w9LL7EA9ph
         Y2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305192; x=1758909992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fq9/RhrmaJ95VHFP/mSsZ0mv4u1FmOMHDPmgSCxvyHU=;
        b=EpXIJEvEeqR168sWTskBuPjiSIrbq5Yzi5/58fR5mmwRtkh4GnohH/Xhv0rAKJ/Cil
         hQAq+IaatJFBS7rgIMquIspwb0bGQq/rM2jqvnV+L1pOqjW+YJ6V7fvpTY5tgStxZmfa
         eN+FiBZuLTB04piZHfV7EJAgfBgoFebtwm4YFGQWSnK+jiF9aXFCOpihpDJlMpMsRhDa
         WMD6F0Vx1JYR37jl7RYJQ4iM0g+jVpCCNKcrn72Tg3l66z6rIMguIxAkRqa1ckrI6+m4
         G3tPtZUH4F0Mec/rkHR3Y1HOWfgfTdoOZsauEndfECCGZ8X0m5GRyJLL6kUz8j6rADM4
         C32Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDOciP/QKv4pSoUar7xulzh5x5gLBF10CRYRDwgRVVfuGk5A8FIbDLZpFhJvn/JaJGDTPTypD3akJN514=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzy5s71RONHI8WpUoFkpasG6R7dTqeUKXKnITsfsIT0h6B7MXZ
	rKcTfqZDVFzApyc5KaoIQk5YemEk1fRHpwEkbPv0vZSUL9PamtDA4x7e
X-Gm-Gg: ASbGncvgYhudlIl6An++WFz7AuRfU5JjMmlq23Z+Y9UZ76APWkKF69lcPYBdM/2sa05
	gljxUNAwGT5KH3Rf19N11mbcCJzsCZ585pCkgjPvnu0dW7+l1yVn7s8o2CL4YHMVTzvJMVgVoVj
	Jzrp9fQgdMCijgrg8Au2ibglIrpn9fa2NsFPyFDCsPX5frKOn84TI51qM53dJRgbSWolclDff6j
	DHGewxebPsNHLeobFWQsK3oSPtwqPgnx7hWP15YU7aCg2MCumtHn7e102RNOl6N9PBKJLcTXv9L
	LjvDgKn0nkDPM9BY7Y6jzAhlha4S71H519auorJfvctRZMwJrApn/tDIs4TpdnB0omln3lRJM7V
	E83mp3r8PL8RBpF1rZcTW0h38x3c=
X-Google-Smtp-Source: AGHT+IG8ZpyqLIkbcuvtqtJ+EHy3A9Tiq7R+4x7DEyt9BYgtt5t3QogZOzW/orps6pe0vIGob3Fzng==
X-Received: by 2002:a17:90b:3945:b0:329:f535:6e4b with SMTP id 98e67ed59e1d1-3309838f187mr5713725a91.37.1758305192045;
        Fri, 19 Sep 2025 11:06:32 -0700 (PDT)
Received: from gmail.com ([157.45.202.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed257bb5asm8702313a91.0.2025.09.19.11.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:06:31 -0700 (PDT)
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
Subject: [PATCH net] net/core : fix KMSAN: uninit value in tipc_rcv
Date: Fri, 19 Sep 2025 23:36:01 +0530
Message-ID: <20250919180601.76152-1-hariconscious@gmail.com>
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
Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---
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


